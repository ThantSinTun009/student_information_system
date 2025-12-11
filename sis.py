import streamlit as st
import psycopg2
import pandas as pd
import os
import datetime

# -----------------------
# DB CONNECT
# -----------------------
def get_conn():
    return psycopg2.connect(
        host="localhost",
        database="student_information_system",
        user="postgres",
        password="root"
    )
    
# -----------------------
# SIDEBAR
# -----------------------
st.sidebar.markdown("<h2 style='text-align:left;'>🎓 SIS Dashboard</h2>", unsafe_allow_html=True)

logo_path = "parami.jpg"
if os.path.exists(logo_path):
    st.sidebar.image(logo_path, width=160, caption="Parami University")

st.sidebar.markdown("---")
st.sidebar.markdown("👤 **Name:** Thant Sin Tun")
st.sidebar.markdown("🆔 **Student ID:** PIUS20230003")
st.sidebar.markdown("---")

# -----------------------
# MENU
# -----------------------
menu = ["🏠 Home", "➕ Add Student", "📋 View Students"]
choice = st.sidebar.selectbox("Menu", menu)


# -----------------------
# ADD STUDENT PAGE
# -----------------------
def add_student():
    st.markdown("<h2 style='color:#4E7BFF;'>➕ Add New Student</h2>", unsafe_allow_html=True)
    st.write("Please fill in the student information below:")

    col1, col2 = st.columns(2)
    with col1:
        student_number = st.text_input("Student Number")
        first_name = st.text_input("First Name")
    with col2:
        last_name = st.text_input("Last Name")
        email = st.text_input("Email")

    dob = st.date_input(
        "Date of Birth",
        value=datetime.date(2000, 1, 1),
        min_value=datetime.date(1990, 1, 1),
        max_value=datetime.date(2015, 12, 31)
    )

    st.markdown("---")

    if st.button("💾 Save Student", use_container_width=True):
        conn = get_conn()
        cur = conn.cursor()
        cur.execute("""
            INSERT INTO students(student_number, first_name, last_name, email, dob)
            VALUES (%s, %s, %s, %s, %s)
        """, (student_number, first_name, last_name, email, dob))
        conn.commit()

        st.success("🎉 Student added successfully!")


# -----------------------
# VIEW STUDENTS PAGE
# -----------------------
def view_students():
    st.markdown("<h2 style='color:#4E7BFF;'>📋 All Students</h2>", unsafe_allow_html=True)

    conn = get_conn()
    df = pd.read_sql("SELECT * FROM students ORDER BY student_id", conn)

    st.dataframe(df, use_container_width=True, height=500)


# -----------------------
# PAGE ROUTING
# -----------------------
if choice == "🏠 Home":
    st.title("🎓 Student Information System")
    st.subheader("Welcome to your SIS Dashboard!")
    st.info("Use the menu on the left to manage students.")

elif choice == "➕ Add Student":
    add_student()

elif choice == "📋 View Students":
    view_students()