import streamlit as st
import pandas as pd
import psycopg2
import os

import psycopg2
conn = psycopg2.connect(
    host=st.secrets["DB_HOST"],
    database=st.secrets["DB_NAME"],
    user=st.secrets["DB_USER"],
    password=st.secrets["DB_PASSWORD"]
)

# --------------------------------------------------
# Page configuration
# --------------------------------------------------
st.set_page_config(
    page_title="Student Information System",
    layout="wide"
)

# --------------------------------------------------
# Database connection
# --------------------------------------------------
conn = psycopg2.connect(
    host="localhost",
    database="student_information_system",
    user="postgres",
    password="root"
)

# --------------------------------------------------
# Session state initialization
# --------------------------------------------------
if "logged_in" not in st.session_state:
    st.session_state.logged_in = False
    st.session_state.role = None
    st.session_state.user_id = None


# --------------------------------------------------
# Login Page
# --------------------------------------------------
def login_page():
    st.markdown(
    "<h1 style='text-align: center;'>Student Information System</h1>",
    unsafe_allow_html=True
)

    col1, col2, col3 = st.columns([1, 2, 1])

    with col2:
        st.subheader("Login")

        role = st.selectbox("Select Role", ["Student", "Instructor", "Registrar"])
        user_id = st.text_input("Enter your ID")

        if st.button("Login"):
            if not user_id.strip():
                st.error("Please enter your ID.")
                return

            try:
                with conn.cursor() as cur:
                    if role == "Student":
                        cur.execute(
                            "SELECT 1 FROM student WHERE student_id = %s",
                            (user_id,)
                        )
                    else:
                        cur.execute(
                            "SELECT 1 FROM staff WHERE staff_id = %s",
                            (user_id,)
                        )

                    if cur.fetchone() is None:
                        st.error("Invalid ID.")
                        return

                st.session_state.logged_in = True
                st.session_state.role = role
                st.session_state.user_id = user_id
                st.rerun()

            except Exception as e:
                st.error(f"Database error: {e}")
                
logo_path = "images/parami.jpg"

if os.path.exists(logo_path):
    st.sidebar.image(logo_path, width=150)

st.sidebar.markdown("**Developed by:**")
st.sidebar.markdown("- Zin Mon Thet")
st.sidebar.markdown("- Tar Rein Thway")
st.sidebar.markdown("- Thant Sin Tun")

# --------------------------------------------------
# Sidebar after login
# --------------------------------------------------
def sidebar():
    st.sidebar.markdown("---")

    st.sidebar.markdown(f"**Role:** {st.session_state.role}")
    st.sidebar.markdown(f"**ID:** {st.session_state.user_id}")
    st.sidebar.markdown("---")

    if st.sidebar.button("Logout"):
        st.session_state.logged_in = False
        st.session_state.role = None
        st.session_state.user_id = None
        st.rerun()


# --------------------------------------------------
# App Router
# --------------------------------------------------
if not st.session_state.logged_in:
    login_page()

else:
    sidebar()

    role = st.session_state.role
    user_id = st.session_state.user_id

    # --------------------------------------------------
    # STUDENT PORTAL
    # --------------------------------------------------
    if role == "Student":
        st.header("Student Portal")

        action = st.radio(
            "Select Action",
            ["View Courses & Grades", "Check Graduation Requirements"]
        )

        with conn.cursor() as cur:
            try:
                if action == "View Courses & Grades":
                    cur.execute(
                        "SELECT * FROM get_student_courses(%s)",
                        (user_id,)
                    )
                    rows = cur.fetchall()

                    if rows:
                        df = pd.DataFrame(
                            rows,
                            columns=[
                                "Student ID", "Name", "Course",
                                "Semester", "Year", "Grade"
                            ]
                        )
                        st.dataframe(df)
                    else:
                        st.info("No courses found.")

                elif action == "Check Graduation Requirements":
                    cur.execute(
                        "SELECT * FROM check_graduation_requirements(%s)",
                        (user_id,)
                    )
                    rows = cur.fetchall()

                    df = pd.DataFrame(
                        rows,
                        columns=["Section", "Details"]
                    )
                    st.dataframe(df)

                    status_row = df[df["Section"] == "STATUS"]
                    if not status_row.empty:
                        status_text = status_row["Details"].values[0]
                        if "✓" in status_text:
                            st.success(status_text)
                        else:
                            st.error(status_text)

            except Exception as e:
                st.error(f"Error: {e}")

    # --------------------------------------------------
    # INSTRUCTOR PORTAL
    # --------------------------------------------------
    elif role == "Instructor":
        st.header("Instructor Portal")

        action = st.radio(
            "Select Action",
            ["View Sections & Students", "Enter Grades"]
        )

        with conn.cursor() as cur:
            try:
                if action == "View Sections & Students":
                    cur.execute(
                        "SELECT * FROM v_instructor_sections WHERE instructor_id = %s",
                        (user_id,)
                    )
                    rows = cur.fetchall()

                    if rows:
                        df = pd.DataFrame(
                            rows,
                            columns=[
                                "Section ID", "Instructor ID", "Course Name",
                                "Student ID", "Student Name",
                                "Enrollment ID", "Grade"
                            ]
                        )
                        st.dataframe(df)
                    else:
                        st.info("No sections assigned.")

                elif action == "Enter Grades":
                    cur.execute(
                        """
                        SELECT enrollment_id, student_id, student_name, course_name
                        FROM v_instructor_sections
                        WHERE instructor_id = %s
                        """,
                        (user_id,)
                    )
                    rows = cur.fetchall()

                    if rows:
                        df = pd.DataFrame(
                            rows,
                            columns=[
                                "Enrollment ID", "Student ID",
                                "Student Name", "Course"
                            ]
                        )

                        enrollment_id = st.selectbox(
                            "Select Enrollment",
                            df["Enrollment ID"]
                        )

                        grade = st.text_input("Grade (A–F)")
                        grade_points = st.number_input(
                            "Grade Points", 0.0, 4.0
                        )

                        if st.button("Submit Grade"):
                            cur.execute(
                                "SELECT enter_grade(%s, %s, %s)",
                                (enrollment_id, grade, grade_points)
                            )
                            conn.commit()
                            st.success("Grade updated successfully.")

                    else:
                        st.info("No enrollments available.")

            except Exception as e:
                st.error(f"Error: {e}")

    # --------------------------------------------------
    # REGISTRAR PORTAL
    # --------------------------------------------------
    elif role == "Registrar":
        st.header("Registrar Portal")

        action = st.radio(
            "Select Action",
            ["View Enrollments", "Add Enrollment"]
        )

        with conn.cursor() as cur:
            try:
                if action == "View Enrollments":
                    cur.execute("SELECT * FROM v_registrar_transcripts")
                    rows = cur.fetchall()

                    df = pd.DataFrame(
                        rows,
                        columns=[
                            "Student ID", "Student Name", "Course Name",
                            "Semester", "Academic Year",
                            "Grade", "Enrollment ID"
                        ]
                    )
                    st.dataframe(df)

                elif action == "Add Enrollment":
                    student_id = st.text_input("Student ID")
                    section_id = st.text_input("Section ID")
                    enrollment_id = st.text_input("Enrollment ID")
                    status = st.selectbox(
                        "Status",
                        ["enrolled", "completed", "dropped"]
                    )

                    if st.button("Add Enrollment"):
                        cur.execute(
                            "SELECT add_enrollment(%s, %s, %s, %s)",
                            (enrollment_id, student_id, section_id, status)
                        )
                        conn.commit()
                        st.success("Enrollment added successfully.")

            except Exception as e:
                st.error(f"Error: {e}")

