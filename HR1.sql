SELECT first_name, 
        last_name," +
						"email, phone_number, hire_date" +
						"FROM employees" + 
						"WHERE lower(first_name) LIKE '%" + Keyword + "%' OR " +
						"lower(last_name) LIKE '%" + Keyword + "%'";