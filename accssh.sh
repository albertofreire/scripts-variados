#--------------------
#!/bin/sh
#--------------------
#
# Desenvolvido por albertofreire@yahoo.com.br

# Altere conforme a necessidade
# -----------------------------
user_mk="admin"
ssh_port="22"
ssh_key="/root/.ssh/dsa_key"
# -----------------------------

# Não altere nada aqui
ssh_consult()
{
	local ip="$1"
	local query="$2"
	local user="$user_mk"
	local port="$ssh_port"
	local key="$ssh_key"
	local timeout_path="$(which timeout)"
	local ssh_path="$(which ssh)"

	exec_query="$(${timeout_path} -s9 3s\
		${ssh_path} -o StrictHostKeyChecking=no\
		-l ${user} -p${port} -i ${key} ${ip} ${query})"

	echo "$exec_query"
}

ssh_consult "$1" "$2"