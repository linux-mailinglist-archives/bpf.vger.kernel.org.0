Return-Path: <bpf+bounces-26639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A908A341F
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 18:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AA92B224B2
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 16:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16FD54F87;
	Fri, 12 Apr 2024 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OoF72YUw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB614D2B7
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712940774; cv=none; b=eEvYM3vs3p+92lr7Bh4Z6WZhpGazszd+eqtD7OtF5igclb2kHdN6LwOt5qddnLQv8EyKgorzcV5Hz35KkopTIdwsNUUFpC0GD295QcZzgYuBNOnqSDfzHWRXLvy6uKuV/rhW20aRxgGJQ5Hsd82uq5golVPZZHiKKOd9PSuqVcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712940774; c=relaxed/simple;
	bh=akFp6RK1LVFlFGVqS9Y6JaUDLitppl32gV3t5wwr/mY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dMNDE6Z/p29easgKULcDBYHhnFkpCnDs68FU++AI2ItRZksiKrbLwTW0N+FM5U1lFfxNJpOrUJ4M8e4O637YCNIkoZi19SNlY46IkedSHoKF98PkgC4grJdWR2Hso5uZTk7X4w3Ccc5Icv0hPf/QDAyObJq9jXnlZt7rUP4yzRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OoF72YUw; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so119311839f.3
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 09:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712940772; x=1713545572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r3M+9obBdhz1pEhPpeJ62za5haomWX8etV1oimZ4Krk=;
        b=OoF72YUwMrv3nF3ZHloFtSZ9iEd1OJq4gNOe2a3ehd2mk/wLIoNGHn+VcZkwVfjvyO
         PE7mookFgf27yENKr9zM4hsIA1N613L+ICnHaGpXMLLjLpraKpQqIX/IhiA9VDhOYNND
         2aubKiEO9Z/g+TxBhUl9c+w8AE4XVEKo4NS2df1bwm+QXSagmcrbuB4NH3GftAkVUrTH
         8SPM5xGBVfxJbo8xeGov5Qe0Y89+V7MLbgxQrMEvb3qoipEDygy4sc0xwoqHfumZ+C4F
         TcBuFt/jHuzSNeO2OsE+jBAnmrtpdgpsT6/v/Kbwc18fksi5JEBTOOR2+5LuyK7BJvUH
         ee7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712940772; x=1713545572;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r3M+9obBdhz1pEhPpeJ62za5haomWX8etV1oimZ4Krk=;
        b=dnNnkO4AsCltdbdme4pkTJ/t9JMrpMSgd2fIJa+sYssWfy5ex0KPHtUOu5mqO+jSu7
         Cz9Lsdql5WTln3C0TlbCtgwml9cEKoa8FoS4tDUlHgn0F2jUgpF6f3jX2WUYADHyzwaO
         hDRGZRCxl6+yg1xqyoCe2VJSDpFaAZvdxXIGnWBbcFtdYkH9C7BefghbKwkPS1ecSZk7
         GjXS5ByNr37rwfX7LhHIxXFYZV9GvJcgtwOHZgWcBFiBeo9tXipovgdvpU81jCbTwy7U
         5e6+0kHVcgMwb4Mxoedj7j+KwnlbJYnhtEGZ/SgZbx7atsNOMjrxgksJnSIsYDXBt1P9
         1xHg==
X-Gm-Message-State: AOJu0YzgJE2Sc+4d+IAdNMS86wgaaRJTTNmO82KpNbMhQZXnkSHLlZUW
	hTkTSa5Wa4+jkPxgs4fGZOWAOdtpjjLq0tWD9ckMuhO5WMaZQFcjgyEpVbjdzu2ijFgy8j7eP+T
	O45kjA2ULC6+482zk0/YsMCfYitDMtaQiKYjUe+QknNLFcG3LNMoyOHi8EfZsHKzQFglqNSaICe
	gYFeqMAIRiIUBt3zVTwLRF9u4=
X-Google-Smtp-Source: AGHT+IGu/Dyy5bVWiR11P8CqZ0xQAszxZBU7BGkbz2U87mX5hNQfubwSdya44A1mcXyh4yiCxaKoZTn+BA==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6638:3798:b0:482:cd20:d3b8 with SMTP id
 w24-20020a056638379800b00482cd20d3b8mr110105jal.0.1712940771666; Fri, 12 Apr
 2024 09:52:51 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:52:25 -0500
In-Reply-To: <20240412165230.2009746-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240412165230.2009746-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240412165230.2009746-5-jrife@google.com>
Subject: [PATCH v2 bpf-next 4/6] selftests/bpf: Add IPv4 and IPv6 sockaddr
 test cases
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Artem Savkov <asavkov@redhat.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This patch lays the groundwork for testing IPv4 and IPv6 sockaddr hooks
and their interaction with both socket syscalls and kernel functions
(e.g. kernel_connect, kernel_bind, etc.) and moves the test cases from
the old-style bpf/test_sock_addr.c self test into the sock_addr
prog_test.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 391 ++++++++++++------
 1 file changed, 269 insertions(+), 122 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index 5fd6177189915..92879b971a098 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -3,16 +3,43 @@
 
 #include "test_progs.h"
 
+#include "bind4_prog.skel.h"
+#include "bind6_prog.skel.h"
 #include "connect_unix_prog.skel.h"
+#include "connect4_prog.skel.h"
+#include "connect6_prog.skel.h"
+#include "sendmsg4_prog.skel.h"
+#include "sendmsg6_prog.skel.h"
+#include "recvmsg4_prog.skel.h"
+#include "recvmsg6_prog.skel.h"
 #include "sendmsg_unix_prog.skel.h"
 #include "recvmsg_unix_prog.skel.h"
 #include "getsockname_unix_prog.skel.h"
 #include "getpeername_unix_prog.skel.h"
 #include "network_helpers.h"
 
+#define TEST_IF_PREFIX          "test_sock_addr"
+#define TEST_IPV4               "127.0.0.4"
+#define TEST_IPV6               "::6"
+
+#define SERV4_IP                "192.168.1.254"
+#define SERV4_REWRITE_IP        "127.0.0.1"
+#define SRC4_IP                 "172.16.0.1"
+#define SRC4_REWRITE_IP         TEST_IPV4
+#define SERV4_PORT              4040
+#define SERV4_REWRITE_PORT      4444
+
+#define SERV6_IP                "face:b00c:1234:5678::abcd"
+#define SERV6_REWRITE_IP        "::1"
+#define SERV6_V4MAPPED_IP       "::ffff:192.168.0.4"
+#define SRC6_IP                 "::1"
+#define SRC6_REWRITE_IP         TEST_IPV6
+#define SERV6_PORT              6060
+#define SERV6_REWRITE_PORT      6666
+
 #define SERVUN_ADDRESS         "bpf_cgroup_unix_test"
 #define SERVUN_REWRITE_ADDRESS "bpf_cgroup_unix_test_rewrite"
-#define SRCUN_ADDRESS	       "bpf_cgroup_unix_test_src"
+#define SRCUN_ADDRESS          "bpf_cgroup_unix_test_src"
 
 enum sock_addr_test_type {
 	SOCK_ADDR_TEST_BIND,
@@ -43,130 +70,148 @@ struct sock_addr_test {
 	const char *expected_src_addr;
 };
 
-static void *connect_unix_prog_load(int cgroup_fd)
-{
-	struct connect_unix_prog *skel;
-
-	skel = connect_unix_prog__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "skel_open"))
-		goto cleanup;
-
-	skel->links.connect_unix_prog = bpf_program__attach_cgroup(
-		skel->progs.connect_unix_prog, cgroup_fd);
-	if (!ASSERT_OK_PTR(skel->links.connect_unix_prog, "prog_attach"))
-		goto cleanup;
-
-	return skel;
-cleanup:
-	connect_unix_prog__destroy(skel);
-	return NULL;
-}
-
-static void connect_unix_prog_destroy(void *skel)
-{
-	connect_unix_prog__destroy(skel);
-}
-
-static void *sendmsg_unix_prog_load(int cgroup_fd)
-{
-	struct sendmsg_unix_prog *skel;
-
-	skel = sendmsg_unix_prog__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "skel_open"))
-		goto cleanup;
-
-	skel->links.sendmsg_unix_prog = bpf_program__attach_cgroup(
-		skel->progs.sendmsg_unix_prog, cgroup_fd);
-	if (!ASSERT_OK_PTR(skel->links.sendmsg_unix_prog, "prog_attach"))
-		goto cleanup;
-
-	return skel;
-cleanup:
-	sendmsg_unix_prog__destroy(skel);
-	return NULL;
-}
-
-static void sendmsg_unix_prog_destroy(void *skel)
-{
-	sendmsg_unix_prog__destroy(skel);
-}
-
-static void *recvmsg_unix_prog_load(int cgroup_fd)
-{
-	struct recvmsg_unix_prog *skel;
-
-	skel = recvmsg_unix_prog__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "skel_open"))
-		goto cleanup;
-
-	skel->links.recvmsg_unix_prog = bpf_program__attach_cgroup(
-		skel->progs.recvmsg_unix_prog, cgroup_fd);
-	if (!ASSERT_OK_PTR(skel->links.recvmsg_unix_prog, "prog_attach"))
-		goto cleanup;
-
-	return skel;
-cleanup:
-	recvmsg_unix_prog__destroy(skel);
-	return NULL;
-}
-
-static void recvmsg_unix_prog_destroy(void *skel)
-{
-	recvmsg_unix_prog__destroy(skel);
-}
-
-static void *getsockname_unix_prog_load(int cgroup_fd)
-{
-	struct getsockname_unix_prog *skel;
-
-	skel = getsockname_unix_prog__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "skel_open"))
-		goto cleanup;
-
-	skel->links.getsockname_unix_prog = bpf_program__attach_cgroup(
-		skel->progs.getsockname_unix_prog, cgroup_fd);
-	if (!ASSERT_OK_PTR(skel->links.getsockname_unix_prog, "prog_attach"))
-		goto cleanup;
-
-	return skel;
-cleanup:
-	getsockname_unix_prog__destroy(skel);
-	return NULL;
+#define BPF_SKEL_FUNCS(skel_name, prog_name) \
+static void *skel_name##_load(int cgroup_fd) \
+{ \
+	struct skel_name *skel; \
+	skel = skel_name##__open_and_load(); \
+	if (!ASSERT_OK_PTR(skel, "skel_open")) \
+		goto cleanup; \
+	skel->links.prog_name = bpf_program__attach_cgroup( \
+		skel->progs.prog_name, cgroup_fd); \
+	if (!ASSERT_OK_PTR(skel->links.prog_name, "prog_attach")) \
+		goto cleanup; \
+	return skel; \
+cleanup: \
+	skel_name##__destroy(skel); \
+	return NULL; \
+} \
+static void skel_name##_destroy(void *skel) \
+{ \
+	skel_name##__destroy(skel); \
 }
 
-static void getsockname_unix_prog_destroy(void *skel)
-{
-	getsockname_unix_prog__destroy(skel);
-}
-
-static void *getpeername_unix_prog_load(int cgroup_fd)
-{
-	struct getpeername_unix_prog *skel;
-
-	skel = getpeername_unix_prog__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "skel_open"))
-		goto cleanup;
-
-	skel->links.getpeername_unix_prog = bpf_program__attach_cgroup(
-		skel->progs.getpeername_unix_prog, cgroup_fd);
-	if (!ASSERT_OK_PTR(skel->links.getpeername_unix_prog, "prog_attach"))
-		goto cleanup;
-
-	return skel;
-cleanup:
-	getpeername_unix_prog__destroy(skel);
-	return NULL;
-}
-
-static void getpeername_unix_prog_destroy(void *skel)
-{
-	getpeername_unix_prog__destroy(skel);
-}
+BPF_SKEL_FUNCS(bind4_prog, bind_v4_prog);
+BPF_SKEL_FUNCS(bind6_prog, bind_v6_prog);
+BPF_SKEL_FUNCS(connect4_prog, connect_v4_prog);
+BPF_SKEL_FUNCS(connect6_prog, connect_v6_prog);
+BPF_SKEL_FUNCS(connect_unix_prog, connect_unix_prog);
+BPF_SKEL_FUNCS(sendmsg4_prog, sendmsg_v4_prog);
+BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_prog);
+BPF_SKEL_FUNCS(sendmsg_unix_prog, sendmsg_unix_prog);
+BPF_SKEL_FUNCS(recvmsg4_prog, recvmsg4_prog);
+BPF_SKEL_FUNCS(recvmsg6_prog, recvmsg6_prog);
+BPF_SKEL_FUNCS(recvmsg_unix_prog, recvmsg_unix_prog);
+BPF_SKEL_FUNCS(getsockname_unix_prog, getsockname_unix_prog);
+BPF_SKEL_FUNCS(getpeername_unix_prog, getpeername_unix_prog);
 
 static struct sock_addr_test tests[] = {
+	/* bind - system calls */
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind4: bind (stream)",
+		bind4_prog_load,
+		bind4_prog_destroy,
+		AF_INET,
+		SOCK_STREAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind4: bind (dgram)",
+		bind4_prog_load,
+		bind4_prog_destroy,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind6: bind (stream)",
+		bind6_prog_load,
+		bind6_prog_destroy,
+		AF_INET6,
+		SOCK_STREAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind6: bind (dgram)",
+		bind6_prog_load,
+		bind6_prog_destroy,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+	},
+
+	/* connect - system calls */
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect4: connect (stream)",
+		connect4_prog_load,
+		connect4_prog_destroy,
+		AF_INET,
+		SOCK_STREAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SRC4_REWRITE_IP,
+	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
-		"connect_unix",
+		"connect4: connect (dgram)",
+		connect4_prog_load,
+		connect4_prog_destroy,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SRC4_REWRITE_IP,
+	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect6: connect (stream)",
+		connect6_prog_load,
+		connect6_prog_destroy,
+		AF_INET6,
+		SOCK_STREAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect6: connect (dgram)",
+		connect6_prog_load,
+		connect6_prog_destroy,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect_unix: connect (stream)",
 		connect_unix_prog_load,
 		connect_unix_prog_destroy,
 		AF_UNIX,
@@ -177,9 +222,37 @@ static struct sock_addr_test tests[] = {
 		0,
 		NULL,
 	},
+
+	/* sendmsg - system calls */
 	{
 		SOCK_ADDR_TEST_SENDMSG,
-		"sendmsg_unix",
+		"sendmsg4: sendmsg (dgram)",
+		sendmsg4_prog_load,
+		sendmsg4_prog_destroy,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SRC4_REWRITE_IP,
+	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg6: sendmsg (dgram)",
+		sendmsg6_prog_load,
+		sendmsg6_prog_destroy,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg_unix: sendmsg (dgram)",
 		sendmsg_unix_prog_load,
 		sendmsg_unix_prog_destroy,
 		AF_UNIX,
@@ -190,9 +263,37 @@ static struct sock_addr_test tests[] = {
 		0,
 		NULL,
 	},
+
+	/* recvmsg - system calls */
+	{
+		SOCK_ADDR_TEST_RECVMSG,
+		"recvmsg4: recvfrom (dgram)",
+		recvmsg4_prog_load,
+		recvmsg4_prog_destroy,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SERV4_IP,
+	},
 	{
 		SOCK_ADDR_TEST_RECVMSG,
-		"recvmsg_unix-dgram",
+		"recvmsg6: recvfrom (dgram)",
+		recvmsg6_prog_load,
+		recvmsg6_prog_destroy,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SERV6_IP,
+	},
+	{
+		SOCK_ADDR_TEST_RECVMSG,
+		"recvmsg_unix: recvfrom (dgram)",
 		recvmsg_unix_prog_load,
 		recvmsg_unix_prog_destroy,
 		AF_UNIX,
@@ -205,7 +306,7 @@ static struct sock_addr_test tests[] = {
 	},
 	{
 		SOCK_ADDR_TEST_RECVMSG,
-		"recvmsg_unix-stream",
+		"recvmsg_unix: recvfrom (stream)",
 		recvmsg_unix_prog_load,
 		recvmsg_unix_prog_destroy,
 		AF_UNIX,
@@ -216,6 +317,8 @@ static struct sock_addr_test tests[] = {
 		0,
 		SERVUN_ADDRESS,
 	},
+
+	/* getsockname - system calls */
 	{
 		SOCK_ADDR_TEST_GETSOCKNAME,
 		"getsockname_unix",
@@ -229,6 +332,8 @@ static struct sock_addr_test tests[] = {
 		0,
 		NULL,
 	},
+
+	/* getpeername - system calls */
 	{
 		SOCK_ADDR_TEST_GETPEERNAME,
 		"getpeername_unix",
@@ -558,11 +663,52 @@ static void test_getpeername(struct sock_addr_test *test)
 		close(serv);
 }
 
+static int ping_once(int ipv, const char *addr)
+{
+	const char *ping_cmd_prefix = "ping -";
+
+	if (!SYS_NOFAIL("type ping%d >/dev/null 2>&1", ipv))
+		ping_cmd_prefix = "ping";
+
+	return SYS_NOFAIL("%s%d -q -c 1 -W 1 %s >/dev/null 2>&1",
+			  ping_cmd_prefix, ipv, addr);
+}
+
+static int setup_test_env(void)
+{
+	SYS(err, "ip link add dev %s1 type veth peer name %s2", TEST_IF_PREFIX,
+	    TEST_IF_PREFIX);
+	SYS(err, "ip link set %s1 up", TEST_IF_PREFIX);
+	SYS(err, "ip link set %s2 up", TEST_IF_PREFIX);
+	SYS(err, "ip -4 addr add %s/8 dev %s1", TEST_IPV4, TEST_IF_PREFIX);
+	SYS(err, "ip -6 addr add %s/128 dev %s1", TEST_IPV6, TEST_IF_PREFIX);
+
+	int i;
+
+	for (i = 0; i < 5; i++) {
+		if (!ping_once(4, TEST_IPV4) && !ping_once(6, TEST_IPV6))
+			return 0;
+	}
+
+	ASSERT_FAIL("Timed out waiting for test IP to become available.");
+err:
+	return -1;
+}
+
+static void cleanup_test_env(void)
+{
+	SYS_NOFAIL("ip link del %s1 2>/dev/null", TEST_IF_PREFIX);
+	SYS_NOFAIL("ip link del %s2 2>/dev/null", TEST_IF_PREFIX);
+}
+
 void test_sock_addr(void)
 {
 	int cgroup_fd = -1;
 	void *skel;
 
+	if (!ASSERT_OK(setup_test_env(), "setup_test_env"))
+		goto cleanup;
+
 	cgroup_fd = test__join_cgroup("/sock_addr");
 	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
 		goto cleanup;
@@ -609,4 +755,5 @@ void test_sock_addr(void)
 cleanup:
 	if (cgroup_fd >= 0)
 		close(cgroup_fd);
+	cleanup_test_env();
 }
-- 
2.44.0.478.gd926399ef9-goog


