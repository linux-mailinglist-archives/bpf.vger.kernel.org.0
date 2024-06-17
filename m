Return-Path: <bpf+bounces-32281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A7890A87D
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 10:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595CF2837E4
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 08:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DCA190466;
	Mon, 17 Jun 2024 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oh3PZfpQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1914B17F5;
	Mon, 17 Jun 2024 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613212; cv=none; b=pwAVG1NeUfGsMeqKbXAIcA0MeQdAXl7HtQ2YczLiEGL6wfDN/ausOrK80CaLIkxuAB43vyNtXpA5TAT5pnZGwAldBa1hOmFuvQ/Wf5QSL4DOxnNPScaDe11JH2bITw5ulGIfHYG9sqyJ6gHOB3v1VyOqfldzQX0+k9/cFyCIuxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613212; c=relaxed/simple;
	bh=AsdAeRE0aIxwv2Q2OeCYD5fNH5nAbKhA8vWFDG9rv9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJhHos7ZInQxzeLqgluydj0yZAmZEy8OrvrrS/t0nabQwsx0tUujJhyliTQoY5/BNlHOOQfYgpJ9Na6/U3lLVQhOpK5/P0CFq3c+ywG0xJX1ZZh1vfep2agvwr4ivAifXjWRownP3+t49CEzLcbWRcPZrz96w5w8RWKGFaIJqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oh3PZfpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3228C3277B;
	Mon, 17 Jun 2024 08:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718613211;
	bh=AsdAeRE0aIxwv2Q2OeCYD5fNH5nAbKhA8vWFDG9rv9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oh3PZfpQn8LS8QytECiWAm2IZAa5d7GkN+Mr0HKS8j0OtolRReVrcutC/Rdtu79sK
	 cxGozLWQ8Xptq41PeFBHZAc6bStAOHApsjO6zNaCRMWGH1au4AA+Q3R7iZh06iudKF
	 62ONbz2AAn8ry2v7MuaEhgJG9sw2L+LLsc+fDDDAPyuJ//XhDCv0XGvo/4jo0cR11d
	 yhLuIiLyxjmGcDRvq1BS6gi+Jb/YXXSjaYd7Gd1MCUMCujVOJ5so48rwwF6rbMiG9E
	 jGcWutwOqQlh8KihVrZ5A5QKA9mLiCXRLF01KDjCCGkPcQkyV0c83vfnkn1NZwXHLz
	 CrYh0Ojf3s6Jw==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH mptcp-next v3 1/6] selftests/bpf: Drop type from network_helper_opts
Date: Mon, 17 Jun 2024 16:33:06 +0800
Message-ID: <6a902bdceb90763bfeb6500fc2ce70acf7cf51ad.1718612857.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718612857.git.tanggeliang@kylinos.cn>
References: <cover.1718612857.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The opts.{type, noconnect} is at least a bit non intuitive or unnecessary.
The only use case now is in test_bpf_ip_check_defrag_ok which ends up
bypassing most (or at least some) of the connect_to_fd_opts() logic. It's
much better that test should have its own connect_to_fd_opts() instead.

This patch adds a new "type" parameter for connect_to_fd_opts(), then
opts->type and getsockopt(SO_TYPE) can be replaced by "type" parameter in
it.

In connect_to_fd(), use getsockopt(SO_TYPE) to get "type" value and pass
it to connect_to_fd_opts().

In bpf_tcp_ca.c and cgroup_v1v2.c, "SOCK_STREAM" types are passed to
connect_to_fd_opts(), and in ip_check_defrag.c, different types "SOCK_RAW"
and "SOCK_DGRAM" are passed to it.

With these changes, the strcut member "type" of network_helper_opts can be
dropped now.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 26 +++++++++----------
 tools/testing/selftests/bpf/network_helpers.h |  3 +--
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  2 +-
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    |  4 +--
 .../bpf/prog_tests/ip_check_defrag.c          |  5 ++--
 5 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index e20caef06aae..c0efccaae488 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -303,27 +303,16 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 	return -1;
 }
 
-int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts)
+int connect_to_fd_opts(int server_fd, int type, const struct network_helper_opts *opts)
 {
 	struct sockaddr_storage addr;
 	struct sockaddr_in *addr_in;
 	socklen_t addrlen, optlen;
-	int fd, type, protocol;
+	int fd, protocol;
 
 	if (!opts)
 		opts = &default_opts;
 
-	optlen = sizeof(type);
-
-	if (opts->type) {
-		type = opts->type;
-	} else {
-		if (getsockopt(server_fd, SOL_SOCKET, SO_TYPE, &type, &optlen)) {
-			log_err("getsockopt(SOL_TYPE)");
-			return -1;
-		}
-	}
-
 	if (opts->proto) {
 		protocol = opts->proto;
 	} else {
@@ -369,8 +358,17 @@ int connect_to_fd(int server_fd, int timeout_ms)
 	struct network_helper_opts opts = {
 		.timeout_ms = timeout_ms,
 	};
+	socklen_t optlen;
+	int type;
+
+	optlen = sizeof(type);
+
+	if (getsockopt(server_fd, SOL_SOCKET, SO_TYPE, &type, &optlen)) {
+		log_err("getsockopt(SOL_TYPE)");
+		return -1;
+	}
 
-	return connect_to_fd_opts(server_fd, &opts);
+	return connect_to_fd_opts(server_fd, type, &opts);
 }
 
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms)
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 11eea8e2e4f1..c92bed35dfe2 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -25,7 +25,6 @@ struct network_helper_opts {
 	int timeout_ms;
 	bool must_fail;
 	bool noconnect;
-	int type;
 	int proto;
 	int (*post_socket_cb)(int fd, void *opts);
 	void *cb_opts;
@@ -61,7 +60,7 @@ void free_fds(int *fds, unsigned int nr_close_fds);
 int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
 		    const struct network_helper_opts *opts);
 int connect_to_fd(int server_fd, int timeout_ms);
-int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts);
+int connect_to_fd_opts(int server_fd, int type, const struct network_helper_opts *opts);
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
 int fastopen_connect(int server_fd, const char *data, unsigned int data_len,
 		     int timeout_ms);
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 67358adf5db3..164f237b24dd 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -49,7 +49,7 @@ static bool start_test(char *addr_str,
 		goto err;
 
 	/* connect to server */
-	*cli_fd = connect_to_fd_opts(*srv_fd, cli_opts);
+	*cli_fd = connect_to_fd_opts(*srv_fd, SOCK_STREAM, cli_opts);
 	if (!ASSERT_NEQ(*cli_fd, -1, "connect_to_fd_opts"))
 		goto err;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
index addf720428f7..9709c8db7275 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
@@ -32,7 +32,7 @@ static int run_test(int cgroup_fd, int server_fd, bool classid)
 		goto out;
 	}
 
-	fd = connect_to_fd_opts(server_fd, &opts);
+	fd = connect_to_fd_opts(server_fd, SOCK_STREAM, &opts);
 	if (fd < 0)
 		err = -1;
 	else
@@ -52,7 +52,7 @@ void test_cgroup_v1v2(void)
 	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, port, 0);
 	if (!ASSERT_GE(server_fd, 0, "server_fd"))
 		return;
-	client_fd = connect_to_fd_opts(server_fd, &opts);
+	client_fd = connect_to_fd_opts(server_fd, SOCK_STREAM, &opts);
 	if (!ASSERT_GE(client_fd, 0, "client_fd")) {
 		close(server_fd);
 		return;
diff --git a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
index 284764e7179f..1607a05bf2c2 100644
--- a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
+++ b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
@@ -164,7 +164,6 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	};
 	struct network_helper_opts tx_ops = {
 		.timeout_ms = 1000,
-		.type = SOCK_RAW,
 		.proto = IPPROTO_RAW,
 		.noconnect = true,
 	};
@@ -201,7 +200,7 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	nstoken = open_netns(NS0);
 	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
 		goto out;
-	client_tx_fd = connect_to_fd_opts(srv_fd, &tx_ops);
+	client_tx_fd = connect_to_fd_opts(srv_fd, SOCK_RAW, &tx_ops);
 	close_netns(nstoken);
 	if (!ASSERT_GE(client_tx_fd, 0, "connect_to_fd_opts"))
 		goto out;
@@ -210,7 +209,7 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	nstoken = open_netns(NS0);
 	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
 		goto out;
-	client_rx_fd = connect_to_fd_opts(srv_fd, &rx_opts);
+	client_rx_fd = connect_to_fd_opts(srv_fd, SOCK_DGRAM, &rx_opts);
 	close_netns(nstoken);
 	if (!ASSERT_GE(client_rx_fd, 0, "connect_to_fd_opts"))
 		goto out;
-- 
2.43.0


