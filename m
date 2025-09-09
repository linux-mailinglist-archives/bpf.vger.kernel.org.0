Return-Path: <bpf+bounces-67914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D07DB503E9
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 19:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A851C649C7
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6C1371E93;
	Tue,  9 Sep 2025 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="ISrdpp8O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FB436CDE7
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437233; cv=none; b=hVlT1fgtjbOZfkAaIeCfBbOKgS2Ccdbp0aHane1b4q/X9B/Wr2Eg22rUNxSbqvaCbnZZSS6PobqBB1v5NbwNgLa0NQMcZzOs9NHyUHTjW6CqwlkAQ73XutTAQj7n8/5xQWjoVUdku9eRRDPyWAqgAhvU7ZWFs2568xZUWtFe47Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437233; c=relaxed/simple;
	bh=tGDHJIgCTUUPwRtopnD/nRijjraAsc7+FnfoSWhHjLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Boj2FPwQo7mEDA0we/5NWMK0/WXnf9XzbMNwOws82l3ZRBdoFAKdtZCzJ3VTUQL5d5iaNNdRKukY7kTa+moTfdxjRHVEQx0fPaFAtxeu+bsppllbKPLB1GOGaFzw6C5VuPXDghgGxzWSxmUZaj5rp6yHXx/uoyJNqQYaolLQwK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=ISrdpp8O; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b47174b335bso583640a12.2
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 10:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437230; x=1758042030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnDZGyoYcvbN/fAhHed4VoGwhEHHH/8bxxHpG8Zt2E4=;
        b=ISrdpp8OKkzTM1dkB+jD+wwrY/pIYprtqmOFT2l8XQrYN1Nqig++Hx8OhS6AKcunqJ
         MJG8C8tuW5NTPoUpmdIt6Iic0ziLK1Kft13qelUvs39qSvtexLAu9G3ardM0avG8sunb
         xHY9rBoJn5F8F3og6HiA1LWoJ0cgfhvtQf+zJMvclnc/AUaD3CH+IqY/OQo50U+5QfrQ
         FxqmdvHZehte8wb57YUP76T2O1IpzsxrDhvGj9iWiZXtpA8dtzPp6SYH5T7Ca66DXxaS
         e5KLQm/gNVWo1G/TFHMZG5rQFkYbxuFWKM7JjphA/ZxRdIyP7/WHZ4M2QqY4R66ltLI9
         2C1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437230; x=1758042030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnDZGyoYcvbN/fAhHed4VoGwhEHHH/8bxxHpG8Zt2E4=;
        b=YzL6mSj2wmBplFMzpKdeY8KcIbf56gOBQro6/gV96TtNdegVCOyAjcn03FEbL/hpNf
         x5oO0SGXZD/+2oaRFKewaAm4r4dh/RDOfTsvAp1WbREYXP+Fngg5qyjlhtW0f2N+ERVF
         4EHdHB0JuG757E0YwdpIwKhotNJuuV2HFsndHaB8hX7nifVP9VQvbx/INPKsx1M9wRj9
         Eb55KSRlT3+4j3NwRUomRG7VvcIkdrBrkch8TcHeSpKBs36Krw3cciqn3p9EPtYWM+7n
         K7BcI+jJxTB2waOdjMQa39Q0SFjxZC6tzOqSaWDFgobp5awe9413slAzW6jzto3cJZXx
         MU4Q==
X-Gm-Message-State: AOJu0YxkDVKgnSKtDrW0fLXTEGIc/IoNd6qU7p+oa4ASQVhqHqlDRiJY
	slS99CSgW2VjgTCeR8SPdS82CE/2H5KfkZB8Ewqsl61UmCI0gdRq1kFnzSzd05Ap2xZ/Dcejo7M
	6wuAg
X-Gm-Gg: ASbGncuzic+V4DHw6g6kmqWKvzPh6dmYnUOxtHQzKliNItv6BC8bcSGe6H+4A64Ne3J
	uMz4uu1HCandfFcWLf2R13yvHXrN2FM77mDYJBt+yRdaUeEn5eMMxS3QGSeUTvVspYYvjUKYjJm
	syMrjpbAs6R7TAgoz6PQJ3t/Ka6v9sgTJ0qPv+Lvq3Yf0TVWEiFb4VZYIN5iFmcsCCDVXh0Xj16
	KLTxe2rypsfR/zb7xjCgnpIJWXr9rFoA8qjGr0i4YJaklS56Mv081iz2adh5xSd6GXC7glh5jAf
	EXktgNw3e4H7FfO3WQiBgNPvhBt5Go37/cVEyBN/XdJDmB8F442kU+8rjgHQRoM1ggyDgjW2HTH
	nybhu6JUPvDj4lU1fbVxjOI17
X-Google-Smtp-Source: AGHT+IFyxjVSMtlEkbxXV8DgdUiK7K23TWlpUVj53Sf/Vqhsr07QctML3Y77JRwPj85vC/mneF0wVw==
X-Received: by 2002:a05:6a21:6da1:b0:252:3a33:660f with SMTP id adf61e73a8af0-2534441f65amr9965493637.4.1757437230316;
        Tue, 09 Sep 2025 10:00:30 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:29 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 05/14] selftests/bpf: Test bpf_sock_destroy() with sockmap iterators
Date: Tue,  9 Sep 2025 09:59:59 -0700
Message-ID: <20250909170011.239356-6-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
References: <20250909170011.239356-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expand the suite of tests for bpf_sock_destroy() to include invocation
from socket map and socket hash iterators.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../selftests/bpf/prog_tests/sock_destroy.c   | 119 +++++++++++++++---
 .../selftests/bpf/progs/sock_destroy_prog.c   |  63 ++++++++++
 2 files changed, 164 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
index 9c11938fe597..829e6fb9c1d8 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
@@ -8,13 +8,20 @@
 
 #define TEST_NS "sock_destroy_netns"
 
-static void start_iter_sockets(struct bpf_program *prog)
+static void start_iter_sockets(struct bpf_program *prog, struct bpf_map *map)
 {
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo = {};
 	struct bpf_link *link;
 	char buf[50] = {};
 	int iter_fd, len;
 
-	link = bpf_program__attach_iter(prog, NULL);
+	if (map)
+		linfo.map.map_fd = bpf_map__fd(map);
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+
+	link = bpf_program__attach_iter(prog, &opts);
 	if (!ASSERT_OK_PTR(link, "attach_iter"))
 		return;
 
@@ -32,7 +39,22 @@ static void start_iter_sockets(struct bpf_program *prog)
 	bpf_link__destroy(link);
 }
 
-static void test_tcp_client(struct sock_destroy_prog *skel)
+static int insert_socket(struct bpf_map *socks, int fd, __u32 key)
+{
+	int map_fd = bpf_map__fd(socks);
+	__s64 sfd = fd;
+	int ret;
+
+	ret = bpf_map_update_elem(map_fd, &key, &sfd, BPF_NOEXIST);
+	if (!ASSERT_OK(ret, "map_update"))
+		return -1;
+
+	return 0;
+}
+
+static void test_tcp_client(struct sock_destroy_prog *skel,
+			    struct bpf_program *prog,
+			    struct bpf_map *socks)
 {
 	int serv = -1, clien = -1, accept_serv = -1, n;
 
@@ -52,8 +74,17 @@ static void test_tcp_client(struct sock_destroy_prog *skel)
 	if (!ASSERT_EQ(n, 1, "client send"))
 		goto cleanup;
 
+	if (socks) {
+		if (!ASSERT_OK(insert_socket(socks, clien, 0),
+			       "insert_socket"))
+			goto cleanup;
+		if (!ASSERT_OK(insert_socket(socks, serv, 1),
+			       "insert_socket"))
+			goto cleanup;
+	}
+
 	/* Run iterator program that destroys connected client sockets. */
-	start_iter_sockets(skel->progs.iter_tcp6_client);
+	start_iter_sockets(prog, socks);
 
 	n = send(clien, "t", 1, 0);
 	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
@@ -69,7 +100,9 @@ static void test_tcp_client(struct sock_destroy_prog *skel)
 		close(serv);
 }
 
-static void test_tcp_server(struct sock_destroy_prog *skel)
+static void test_tcp_server(struct sock_destroy_prog *skel,
+			    struct bpf_program *prog,
+			    struct bpf_map *socks)
 {
 	int serv = -1, clien = -1, accept_serv = -1, n, serv_port;
 
@@ -93,8 +126,17 @@ static void test_tcp_server(struct sock_destroy_prog *skel)
 	if (!ASSERT_EQ(n, 1, "client send"))
 		goto cleanup;
 
+	if (socks) {
+		if (!ASSERT_OK(insert_socket(socks, clien, 0),
+			       "insert_socket"))
+			goto cleanup;
+		if (!ASSERT_OK(insert_socket(socks, accept_serv, 1),
+			       "insert_socket"))
+			goto cleanup;
+	}
+
 	/* Run iterator program that destroys server sockets. */
-	start_iter_sockets(skel->progs.iter_tcp6_server);
+	start_iter_sockets(prog, socks);
 
 	n = send(clien, "t", 1, 0);
 	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
@@ -110,7 +152,9 @@ static void test_tcp_server(struct sock_destroy_prog *skel)
 		close(serv);
 }
 
-static void test_udp_client(struct sock_destroy_prog *skel)
+static void test_udp_client(struct sock_destroy_prog *skel,
+			    struct bpf_program *prog,
+			    struct bpf_map *socks)
 {
 	int serv = -1, clien = -1, n = 0;
 
@@ -126,8 +170,17 @@ static void test_udp_client(struct sock_destroy_prog *skel)
 	if (!ASSERT_EQ(n, 1, "client send"))
 		goto cleanup;
 
+	if (socks) {
+		if (!ASSERT_OK(insert_socket(socks, clien, 0),
+			       "insert_socket"))
+			goto cleanup;
+		if (!ASSERT_OK(insert_socket(socks, serv, 1),
+			       "insert_socket"))
+			goto cleanup;
+	}
+
 	/* Run iterator program that destroys sockets. */
-	start_iter_sockets(skel->progs.iter_udp6_client);
+	start_iter_sockets(prog, socks);
 
 	n = send(clien, "t", 1, 0);
 	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
@@ -143,11 +196,14 @@ static void test_udp_client(struct sock_destroy_prog *skel)
 		close(serv);
 }
 
-static void test_udp_server(struct sock_destroy_prog *skel)
+static void test_udp_server(struct sock_destroy_prog *skel,
+			    struct bpf_program *prog,
+			    struct bpf_map *socks)
 {
 	int *listen_fds = NULL, n, i, serv_port;
 	unsigned int num_listens = 5;
 	char buf[1];
+	__u32 key;
 
 	/* Start reuseport servers. */
 	listen_fds = start_reuseport_server(AF_INET6, SOCK_DGRAM,
@@ -159,8 +215,15 @@ static void test_udp_server(struct sock_destroy_prog *skel)
 		goto cleanup;
 	skel->bss->serv_port = (__be16) serv_port;
 
+	if (socks)
+		for (key = 0; key < num_listens; key++)
+			if (!ASSERT_OK(insert_socket(socks, listen_fds[key],
+						     key),
+				       "insert_socket"))
+				goto cleanup;
+
 	/* Run iterator program that destroys server sockets. */
-	start_iter_sockets(skel->progs.iter_udp6_server);
+	start_iter_sockets(prog, socks);
 
 	for (i = 0; i < num_listens; ++i) {
 		n = read(listen_fds[i], buf, sizeof(buf));
@@ -200,14 +263,34 @@ void test_sock_destroy(void)
 	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
 		goto cleanup;
 
-	if (test__start_subtest("tcp_client"))
-		test_tcp_client(skel);
-	if (test__start_subtest("tcp_server"))
-		test_tcp_server(skel);
-	if (test__start_subtest("udp_client"))
-		test_udp_client(skel);
-	if (test__start_subtest("udp_server"))
-		test_udp_server(skel);
+	if (test__start_subtest("tcp_client")) {
+		test_tcp_client(skel, skel->progs.iter_tcp6_client, NULL);
+		test_tcp_client(skel, skel->progs.iter_sockmap_client,
+				skel->maps.sock_map);
+		test_tcp_client(skel, skel->progs.iter_sockmap_client,
+				skel->maps.sock_hash);
+	}
+	if (test__start_subtest("tcp_server")) {
+		test_tcp_server(skel, skel->progs.iter_tcp6_server, NULL);
+		test_tcp_server(skel, skel->progs.iter_sockmap_server,
+				skel->maps.sock_map);
+		test_tcp_server(skel, skel->progs.iter_sockmap_server,
+				skel->maps.sock_hash);
+	}
+	if (test__start_subtest("udp_client")) {
+		test_udp_client(skel, skel->progs.iter_udp6_client, NULL);
+		test_udp_client(skel, skel->progs.iter_sockmap_client,
+				skel->maps.sock_map);
+		test_udp_client(skel, skel->progs.iter_sockmap_client,
+				skel->maps.sock_hash);
+	}
+	if (test__start_subtest("udp_server")) {
+		test_udp_server(skel, skel->progs.iter_udp6_server, NULL);
+		test_udp_server(skel, skel->progs.iter_sockmap_server,
+				skel->maps.sock_map);
+		test_udp_server(skel, skel->progs.iter_sockmap_server,
+				skel->maps.sock_hash);
+	}
 
 	RUN_TESTS(sock_destroy_prog_fail);
 
diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
index 9e0bf7a54cec..d91f75190bbf 100644
--- a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
+++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
@@ -24,6 +24,20 @@ struct {
 	__type(value, __u64);
 } udp_conn_sockets SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 5);
+	__type(key, __u32);
+	__type(value, __u64);
+} sock_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKHASH);
+	__uint(max_entries, 5);
+	__type(key, __u32);
+	__type(value, __u64);
+} sock_hash SEC(".maps");
+
 SEC("cgroup/connect6")
 int sock_connect(struct bpf_sock_addr *ctx)
 {
@@ -142,4 +156,53 @@ int iter_udp6_server(struct bpf_iter__udp *ctx)
 	return 0;
 }
 
+SEC("iter/sockmap")
+int iter_sockmap_client(struct bpf_iter__sockmap *ctx)
+{
+	__u64 sock_cookie = 0, *val;
+	struct sock *sk = ctx->sk;
+	__u32 *key = ctx->key;
+	__u32 zero = 0;
+
+	if (!key || !sk)
+		return 0;
+
+	sock_cookie  = bpf_get_socket_cookie(sk);
+	val = bpf_map_lookup_elem(&udp_conn_sockets, &zero);
+	if (val && *val == sock_cookie)
+		goto destroy;
+	val = bpf_map_lookup_elem(&tcp_conn_sockets, &zero);
+	if (val && *val == sock_cookie)
+		goto destroy;
+	goto out;
+destroy:
+	bpf_sock_destroy((struct sock_common *)sk);
+out:
+	return 0;
+}
+
+SEC("iter/sockmap")
+int iter_sockmap_server(struct bpf_iter__sockmap *ctx)
+{
+	struct sock *sk = ctx->sk;
+	struct tcp6_sock *tcp_sk;
+	struct udp6_sock *udp_sk;
+	__u32 *key = ctx->key;
+
+	if (!key || !sk)
+		return 0;
+
+	tcp_sk = bpf_skc_to_tcp6_sock(sk);
+	if (tcp_sk && tcp_sk->tcp.inet_conn.icsk_inet.inet_sport == serv_port)
+		goto destroy;
+	udp_sk = bpf_skc_to_udp6_sock(sk);
+	if (udp_sk && udp_sk->udp.inet.inet_sport == serv_port)
+		goto destroy;
+	goto out;
+destroy:
+	bpf_sock_destroy((struct sock_common *)sk);
+out:
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


