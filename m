Return-Path: <bpf+bounces-34205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AE892B37A
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 11:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DE51F232BF
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 09:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D53154433;
	Tue,  9 Jul 2024 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzFiO5H0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AE214BFB4;
	Tue,  9 Jul 2024 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516629; cv=none; b=g26jmxiKMhliRgRa+M2An3RZ0HNPRSiyUg7KHSt85fRZ2L7fSStIe8slt5Ne/C1sVphvV69JwpUGVGwHceJsgTlSIU7xzdmbjNN0JScaLwcbGfce0LrOBgoYyHmpMw4u+rLzH7BEFpBNtAHzFRoj7eE1zZRBdILxCGDElb9Nrn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516629; c=relaxed/simple;
	bh=ApZvhLxtD4l70b1t3CJeyj/B8UQ6goleRLaq5M5l6PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFujUohVXet8zA0GSAXJ1prjSvcsRrcoP4hkiW3tgYGyt7ePHTMmLQuMo/5Cz7aYf8tySUDbGEpC3IUE/bDZLC1Fm3iin10U3TTVLRoIF1uFFRpGzCD3fqJPEd6litBSyXl0iWceP3HkNi6dkKmNDje3S/dPFsZuB1J+0xZAclw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzFiO5H0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F69CC3277B;
	Tue,  9 Jul 2024 09:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720516628;
	bh=ApZvhLxtD4l70b1t3CJeyj/B8UQ6goleRLaq5M5l6PM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GzFiO5H0FW5TxZ1x3d/UT/sCzZxzBuiLk8wEtbxzTINkdXVIs2o43Dtys6PlQ6+Ay
	 Los/liv0rxNkZxcjX6iuyrIDr9JUaj5gbgLWpILHJLYDH9XOHo/FWEbzQjkIAVXz4w
	 czJNJQaeUWTF8sBJS/ybTBFm3QdpCKp1f6JftpkEhXUKrjBqmv9LZBNzFQbd+TVDel
	 Vqy4z1FHF8Yl2RU1LfX+JFQq+OIQI2PtpbX34in4xhvDxAORLVv6U3XLADV9b1l8BK
	 KWrRuqrHRlJ08nZ9ds2Xzlg50IexIpZdIS+QT82HRVZWN3/DTxSjRYg3H8JZOfH44L
	 f9iehTsZVfmEQ==
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
Subject: [PATCH bpf-next v11 4/9] selftests/bpf: Use start_server_str in sk_lookup
Date: Tue,  9 Jul 2024 17:16:20 +0800
Message-ID: <5981539f5591d2c4998c962ef2bf45f34c940548.1720515893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720515893.git.tanggeliang@kylinos.cn>
References: <cover.1720515893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses public helper start_server_str() to simplify make_server()
in prog_tests/sk_lookup.c.

Add a callback setsockopts() to do all sockopts, set it to post_socket_cb
pointer of struct network_helper_opts. And add a new struct cb_opts to save
the data needed to pass to the callback. Then pass this network_helper_opts
to start_server_str().

Also use ASSERT_OK_FD() to check fd returned by start_server_str().

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 58 +++++++++++--------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index de2466547efe..20ee5da2c721 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -77,6 +77,12 @@ struct test {
 	bool reuseport_has_conns; /* Add a connected socket to reuseport group */
 };
 
+struct cb_opts {
+	int family;
+	int sotype;
+	bool reuseport;
+};
+
 static __u32 duration;		/* for CHECK macro */
 
 static bool is_ipv6(const char *ip)
@@ -142,19 +148,14 @@ static int make_socket(int sotype, const char *ip, int port,
 	return fd;
 }
 
-static int make_server(int sotype, const char *ip, int port,
-		       struct bpf_program *reuseport_prog)
+static int setsockopts(int fd, void *opts)
 {
-	struct sockaddr_storage addr = {0};
+	struct cb_opts *co = (struct cb_opts *)opts;
 	const int one = 1;
-	int err, fd = -1;
-
-	fd = make_socket(sotype, ip, port, &addr);
-	if (fd < 0)
-		return -1;
+	int err = 0;
 
 	/* Enabled for UDPv6 sockets for IPv4-mapped IPv6 to work. */
-	if (sotype == SOCK_DGRAM) {
+	if (co->sotype == SOCK_DGRAM) {
 		err = setsockopt(fd, SOL_IP, IP_RECVORIGDSTADDR, &one,
 				 sizeof(one));
 		if (CHECK(err, "setsockopt(IP_RECVORIGDSTADDR)", "failed\n")) {
@@ -163,7 +164,7 @@ static int make_server(int sotype, const char *ip, int port,
 		}
 	}
 
-	if (sotype == SOCK_DGRAM && addr.ss_family == AF_INET6) {
+	if (co->sotype == SOCK_DGRAM && co->family == AF_INET6) {
 		err = setsockopt(fd, SOL_IPV6, IPV6_RECVORIGDSTADDR, &one,
 				 sizeof(one));
 		if (CHECK(err, "setsockopt(IPV6_RECVORIGDSTADDR)", "failed\n")) {
@@ -172,7 +173,7 @@ static int make_server(int sotype, const char *ip, int port,
 		}
 	}
 
-	if (sotype == SOCK_STREAM) {
+	if (co->sotype == SOCK_STREAM) {
 		err = setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one,
 				 sizeof(one));
 		if (CHECK(err, "setsockopt(SO_REUSEADDR)", "failed\n")) {
@@ -181,7 +182,7 @@ static int make_server(int sotype, const char *ip, int port,
 		}
 	}
 
-	if (reuseport_prog) {
+	if (co->reuseport) {
 		err = setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &one,
 				 sizeof(one));
 		if (CHECK(err, "setsockopt(SO_REUSEPORT)", "failed\n")) {
@@ -190,19 +191,28 @@ static int make_server(int sotype, const char *ip, int port,
 		}
 	}
 
-	err = bind(fd, (void *)&addr, inetaddr_len(&addr));
-	if (CHECK(err, "bind", "failed\n")) {
-		log_err("failed to bind listen socket");
-		goto fail;
-	}
+fail:
+	return err;
+}
 
-	if (sotype == SOCK_STREAM) {
-		err = listen(fd, SOMAXCONN);
-		if (CHECK(err, "make_server", "listen")) {
-			log_err("failed to listen on port %d", port);
-			goto fail;
-		}
-	}
+static int make_server(int sotype, const char *ip, int port,
+		       struct bpf_program *reuseport_prog)
+{
+	struct cb_opts cb_opts = {
+		.family = is_ipv6(ip) ? AF_INET6 : AF_INET,
+		.sotype = sotype,
+		.reuseport = reuseport_prog,
+	};
+	struct network_helper_opts opts = {
+		.backlog	= SOMAXCONN,
+		.post_socket_cb = setsockopts,
+		.cb_opts	= &cb_opts,
+	};
+	int err, fd;
+
+	fd = start_server_str(cb_opts.family, sotype, ip, port, &opts);
+	if (!ASSERT_OK_FD(fd, "start_server_str"))
+		return -1;
 
 	/* Late attach reuseport prog so we can have one init path */
 	if (reuseport_prog) {
-- 
2.43.0


