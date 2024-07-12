Return-Path: <bpf+bounces-34625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A2C92F5EA
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 09:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CEDE283564
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 07:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E23C13D636;
	Fri, 12 Jul 2024 07:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYHoShJ8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991CC539A;
	Fri, 12 Jul 2024 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767930; cv=none; b=NulaUoaE+ScCt1REmeclSSF5AalfBUWWeXFtJikDpsEbIvQKmaHfWzggJGKniY4OuSWFJHC0LK2/ZcPEP6f0h6IjdgzP/jFZtY4/DRQZwuWOE4o3h6LbZlkAJ2c/Jjy13OfhptyxMAC3y77jt0YL4PU13YpYwjcow3KG6a0/kBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767930; c=relaxed/simple;
	bh=1XDJn0TtQHL6OsmkJ5DEznCn6PXG39XsRnPu7oafgvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zb4nvR40EujQvjN7k++2qsZld0x9MaPDY/mEcvwyS5QoouYTgOQEgR9AkIj/3FWwryNh4amHEFxPY29iB7MrW/QZcCIdNIgRlsdFQCelVtWT09DUeVN1JWkEQOgoduTG8zfLmjPoRSB2WQV5tkYFI5pQx3aOKha+GG6/OHftdsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYHoShJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAC7C4AF14;
	Fri, 12 Jul 2024 07:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720767930;
	bh=1XDJn0TtQHL6OsmkJ5DEznCn6PXG39XsRnPu7oafgvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bYHoShJ8H7u97+c+Tyw7Yf8DQwTfvEXKtsgMXthktM3+bfSorz9bmuxIhkFoMYWLk
	 ZK+rrb5vtmJSncDTUVGelJ9L8Zt7k8Qq+E4FyD5FjvW3Zw880HIv6Sdyn3EZt/ISNC
	 J0Iy2q2/pibGbE5PnHg+gGB3+wGXYDme2av6AblV2x5ED0bc7TIE0CnokLtSlAkijP
	 gQO7OVK3Qx1DlPdDYNcEX8F4YKmTUiG3P7ElVg9g90LlOwqKGMXAq1B50kXmb/h1+n
	 oPi9b2OWsgieJmpDeGwQHVq2QrUZHTU3eTO1Mx0h+aI6TgoUqm3XPc5RUG6wY2ltFd
	 qKXE8+RXYvLqw==
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
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 4/5] selftests/bpf: Use connect_to_addr_str in sk_lookup
Date: Fri, 12 Jul 2024 15:04:51 +0800
Message-ID: <0a6d2069ded86d5e78f7481a6bc3b059d992b1ff.1720767414.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720767414.git.tanggeliang@kylinos.cn>
References: <cover.1720767414.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses the new helper connect_to_addr_str() in make_client()
instead of using local defined function make_socket() + connect(). This
local function can be dropped latter.

A new parameter "expect_errno" is added for make_client() too to allow
different "expect_errno" is passed to make_client(). It is used to check
with "errno" after invoking connect_to_addr_str().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 26 +++++++------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index ae87c00867ba..beea7866b37f 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -229,25 +229,19 @@ static int make_server(int sotype, const char *ip, int port,
 	return -1;
 }
 
-static int make_client(int sotype, const char *ip, int port)
+static int make_client(int sotype, const char *ip, int port, int expect_errno)
 {
-	struct sockaddr_storage addr = {0};
-	int err, fd;
-
-	fd = make_socket(sotype, ip, port, &addr);
-	if (fd < 0)
-		return -1;
+	int fd;
 
-	err = connect(fd, (void *)&addr, inetaddr_len(&addr));
-	if (CHECK(err, "make_client", "connect")) {
+	fd = connect_to_addr_str(is_ipv6(ip) ? AF_INET6 : AF_INET,
+				 sotype, ip, port, NULL);
+	if (CHECK(fd < 0 && (!expect_errno || errno != expect_errno),
+		  "make_client", "connect_to_addr_str")) {
 		log_err("failed to connect client socket");
-		goto fail;
+		return -1;
 	}
 
 	return fd;
-fail:
-	close(fd);
-	return -1;
 }
 
 static __u64 socket_cookie(int fd)
@@ -646,7 +640,7 @@ static void run_lookup_prog(const struct test *t)
 			goto close;
 	}
 
-	client_fd = make_client(t->sotype, t->connect_to.ip, t->connect_to.port);
+	client_fd = make_client(t->sotype, t->connect_to.ip, t->connect_to.port, 0);
 	if (client_fd < 0)
 		goto close;
 
@@ -1152,7 +1146,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 	if (server_fd < 0)
 		return;
 
-	connected_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	connected_fd = make_client(sotype, EXT_IP4, EXT_PORT, 0);
 	if (connected_fd < 0)
 		goto out_close_server;
 
@@ -1166,7 +1160,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 		goto out_close_connected;
 
 	/* Try to redirect TCP SYN / UDP packet to a connected socket */
-	client_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	client_fd = make_client(sotype, EXT_IP4, EXT_PORT, 0);
 	if (client_fd < 0)
 		goto out_unlink_prog;
 	if (sotype == SOCK_DGRAM) {
-- 
2.43.0


