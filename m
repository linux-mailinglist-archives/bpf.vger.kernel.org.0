Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF8C649072
	for <lists+bpf@lfdr.de>; Sat, 10 Dec 2022 20:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiLJTgo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Dec 2022 14:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiLJTgm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Dec 2022 14:36:42 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED9F1706A
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:39 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w15so8280981wrl.9
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujkHO68+H2kWXGa1eSzUu+1gSiErJczAtQgFg50yd74=;
        b=P3P4zHIkqLdzPkpu6sWgxbxXHooQbFJ4+eM8ps27eYZ4HS62/3z+r2Qn+vKZbSewJ3
         Yyg3S8Zhg8UiOAf9Ou0vrO/qSJ1MPFFjDGBi8p1tYRHw9wdLkaWgj68dgw2qrYcBQLn+
         6BfdBanNo8Pk4kGz03XLP4CRRu+Vjg2/cVQYy+sWOuk2NCijSMGxowuk6nbexH4DVfk9
         FsCVkuFUCY0AVFmRTA7+oeTP8O+UdA4itcyVOJMFUCZ1fghITX7LPSKEuA1V2osY6WYX
         pBZcyYHiIJMlEtt5iZyKPjKT9HDeEWiFK1uGUDl68/y2Kv15IQ+UAeIOG9HkwUqlNqUK
         IWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujkHO68+H2kWXGa1eSzUu+1gSiErJczAtQgFg50yd74=;
        b=LyQaqaSRS5KgNvhmKrF1aluY+cG9km+y5sj8BYf7+vwP06Ndj7hXbm579/6vsR7BuD
         EQsaCp0h7VrI882PqvzZtogMmP3ymyGAFOZ6X996U/9IKJD3PhqkbWZS57SH4tZalLTy
         qN1WtKsUQDqVaBFPJq/uXzVQ4tTnofLElBXLu/8iOOtWU4EeOi2EY3agfYgpmqWzrZZz
         f6iPjzw6kGFV2SU/HW2HheDARmWon8yrjWZ9hqIqHXjPILKEEhDbkPNXWeSsHywrRyZB
         IqUqEeCFMf55tp73mHlSz2MopJ4DzYaFvqlH2TURwBd1InThCCc2zZc8G9nELkrAaQoN
         j5Uw==
X-Gm-Message-State: ANoB5pk9c4pczmA41HzoCOi4Aq6YHtOuhvFpQx7DlHjdGM0MgqL7KFN2
        hDulJx2xNvuXot7DuLLh/dNcdiMPacJdUQ==
X-Google-Smtp-Source: AA0mqf5498DS6F2JxwoEY9hhatbgqm3Oaa8H82TrEAsca1t0Bx6ymAJGth3aatx6QwZv62TP6G0vjw==
X-Received: by 2002:a05:6000:1111:b0:242:1b08:25ba with SMTP id z17-20020a056000111100b002421b0825bamr6324851wrw.39.1670700999069;
        Sat, 10 Dec 2022 11:36:39 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:366e])
        by smtp.googlemail.com with ESMTPSA id az18-20020adfe192000000b002423a5d7cb1sm4584676wrb.113.2022.12.10.11.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 11:36:38 -0800 (PST)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 8/9] selftests/bpf: Add tests for cgroup unix socket address hooks
Date:   Sat, 10 Dec 2022 20:35:58 +0100
Message-Id: <20221210193559.371515-9-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
References: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The unix socket address hooks do not support modifying the source
address so we skip source address checks when we're running a unix
socket address hook test.
---
 .../selftests/bpf/prog_tests/section_names.c  |  30 ++++
 .../testing/selftests/bpf/progs/bindun_prog.c |  36 +++++
 .../selftests/bpf/progs/connectun_prog.c      |  28 ++++
 .../selftests/bpf/progs/recvmsgun_prog.c      |  36 +++++
 .../selftests/bpf/progs/sendmsgun_prog.c      |  28 ++++
 tools/testing/selftests/bpf/test_sock_addr.c  | 137 +++++++++++++++++-
 6 files changed, 288 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bindun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/connectun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/recvmsgun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/sendmsgun_prog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/section_names.c b/tools/testing/selftests/bpf/prog_tests/section_names.c
index fc5248e94a01..51ebc8e6065d 100644
--- a/tools/testing/selftests/bpf/prog_tests/section_names.c
+++ b/tools/testing/selftests/bpf/prog_tests/section_names.c
@@ -113,6 +113,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_BIND},
 		{0, BPF_CGROUP_INET6_BIND},
 	},
+	{
+		"cgroup/bindun",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_BIND},
+		{0, BPF_CGROUP_UNIX_BIND},
+	},
 	{
 		"cgroup/connect4",
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_CONNECT},
@@ -123,6 +128,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_CONNECT},
 		{0, BPF_CGROUP_INET6_CONNECT},
 	},
+	{
+		"cgroup/connectun",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_CONNECT},
+		{0, BPF_CGROUP_UNIX_CONNECT},
+	},
 	{
 		"cgroup/sendmsg4",
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_SENDMSG},
@@ -133,6 +143,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6_SENDMSG},
 		{0, BPF_CGROUP_UDP6_SENDMSG},
 	},
+	{
+		"cgroup/sendmsgun",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_SENDMSG},
+		{0, BPF_CGROUP_UNIX_SENDMSG},
+	},
 	{
 		"cgroup/recvmsg4",
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_RECVMSG},
@@ -143,6 +158,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6_RECVMSG},
 		{0, BPF_CGROUP_UDP6_RECVMSG},
 	},
+	{
+		"cgroup/recvmsgun",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_RECVMSG},
+		{0, BPF_CGROUP_UNIX_RECVMSG},
+	},
 	{
 		"cgroup/sysctl",
 		{0, BPF_PROG_TYPE_CGROUP_SYSCTL, BPF_CGROUP_SYSCTL},
@@ -168,6 +188,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETPEERNAME},
 		{0, BPF_CGROUP_INET6_GETPEERNAME},
 	},
+	{
+		"cgroup/getpeernameun",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_GETPEERNAME},
+		{0, BPF_CGROUP_UNIX_GETPEERNAME},
+	},
 	{
 		"cgroup/getsockname4",
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETSOCKNAME},
@@ -178,6 +203,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETSOCKNAME},
 		{0, BPF_CGROUP_INET6_GETSOCKNAME},
 	},
+	{
+		"cgroup/getsocknameun",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_GETSOCKNAME},
+		{0, BPF_CGROUP_UNIX_GETSOCKNAME},
+	},
 };
 
 static void test_prog_type_by_name(const struct sec_name_test *test)
diff --git a/tools/testing/selftests/bpf/progs/bindun_prog.c b/tools/testing/selftests/bpf/progs/bindun_prog.c
new file mode 100644
index 000000000000..1183063ef745
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bindun_prog.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <string.h>
+
+#include <linux/bpf.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include <bpf/bpf_helpers.h>
+
+#define DST_REWRITE_PATH	"\0bpf_cgroup_unix_test_rewrite"
+
+SEC("cgroup/bindun")
+int bind_un_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock *sk;
+
+	sk = ctx->sk;
+	if (!sk)
+		return 0;
+
+	if (sk->family != AF_UNIX)
+		return 0;
+
+	if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
+		return 0;
+
+	memcpy(ctx->user_path, DST_REWRITE_PATH, sizeof(DST_REWRITE_PATH));
+	ctx->user_addrlen = offsetof(struct sockaddr_un, sun_path) +
+			    sizeof(DST_REWRITE_PATH) - 1;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/connectun_prog.c b/tools/testing/selftests/bpf/progs/connectun_prog.c
new file mode 100644
index 000000000000..f443fdb862fe
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/connectun_prog.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <string.h>
+
+#include <linux/bpf.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include <bpf/bpf_helpers.h>
+
+#define DST_REWRITE_PATH	"\0bpf_cgroup_unix_test_rewrite"
+
+SEC("cgroup/connectun")
+int connect_un_prog(struct bpf_sock_addr *ctx)
+{
+	if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
+		return 0;
+
+	/* Rewrite destination. */
+	memcpy(ctx->user_path, DST_REWRITE_PATH, sizeof(DST_REWRITE_PATH));
+	ctx->user_addrlen = offsetof(struct sockaddr_un, sun_path) +
+			    sizeof(DST_REWRITE_PATH) - 1;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/recvmsgun_prog.c b/tools/testing/selftests/bpf/progs/recvmsgun_prog.c
new file mode 100644
index 000000000000..0334b9420adc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/recvmsgun_prog.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <string.h>
+
+#include <linux/bpf.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include <bpf/bpf_helpers.h>
+
+#define SERVUN_PATH		"\0bpf_cgroup_unix_test"
+
+SEC("cgroup/recvmsgun")
+int recvmsgun_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock *sk;
+
+	sk = ctx->sk;
+	if (!sk)
+		return 1;
+
+	if (sk->family != AF_UNIX)
+		return 1;
+
+	if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
+		return 1;
+
+	memcpy(ctx->user_path, SERVUN_PATH, sizeof(SERVUN_PATH));
+	ctx->user_addrlen = offsetof(struct sockaddr_un, sun_path) +
+			    sizeof(SERVUN_PATH) - 1;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/sendmsgun_prog.c b/tools/testing/selftests/bpf/progs/sendmsgun_prog.c
new file mode 100644
index 000000000000..0f6020e5d463
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sendmsgun_prog.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <string.h>
+
+#include <linux/bpf.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include <bpf/bpf_helpers.h>
+
+#define DST_REWRITE_PATH	"\0bpf_cgroup_unix_test_rewrite"
+
+SEC("cgroup/sendmsgun")
+int sendmsg_un_prog(struct bpf_sock_addr *ctx)
+{
+	if (ctx->type != SOCK_DGRAM)
+		return 0;
+
+	/* Rewrite destination. */
+	memcpy(ctx->user_path, DST_REWRITE_PATH, sizeof(DST_REWRITE_PATH));
+	ctx->user_addrlen = offsetof(struct sockaddr_un, sun_path) +
+			    sizeof(DST_REWRITE_PATH) - 1;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 6a618c8f477c..c96322bcc6c8 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -12,6 +12,7 @@
 #include <sys/types.h>
 #include <sys/select.h>
 #include <sys/socket.h>
+#include <sys/un.h>
 
 #include <linux/filter.h>
 
@@ -28,12 +29,16 @@
 #define CG_PATH	"/foo"
 #define CONNECT4_PROG_PATH	"./connect4_prog.bpf.o"
 #define CONNECT6_PROG_PATH	"./connect6_prog.bpf.o"
+#define CONNECTUN_PROG_PATH	"./connectun_prog.bpf.o"
 #define SENDMSG4_PROG_PATH	"./sendmsg4_prog.bpf.o"
 #define SENDMSG6_PROG_PATH	"./sendmsg6_prog.bpf.o"
+#define SENDMSGUN_PROG_PATH	"./sendmsgun_prog.bpf.o"
 #define RECVMSG4_PROG_PATH	"./recvmsg4_prog.bpf.o"
 #define RECVMSG6_PROG_PATH	"./recvmsg6_prog.bpf.o"
+#define RECVMSGUN_PROG_PATH	"./recvmsgun_prog.bpf.o"
 #define BIND4_PROG_PATH		"./bind4_prog.bpf.o"
 #define BIND6_PROG_PATH		"./bind6_prog.bpf.o"
+#define BINDUN_PROG_PATH	"./bindun_prog.bpf.o"
 
 #define SERV4_IP		"192.168.1.254"
 #define SERV4_REWRITE_IP	"127.0.0.1"
@@ -51,6 +56,9 @@
 #define SERV6_PORT		6060
 #define SERV6_REWRITE_PORT	6666
 
+#define SERVUN_ADDRESS		"bpf_cgroup_unix_test"
+#define SERVUN_REWRITE_ADDRESS	"bpf_cgroup_unix_test_rewrite"
+
 #define INET_NTOP_BUF	40
 
 struct sock_addr_test;
@@ -88,8 +96,10 @@ struct sock_addr_test {
 
 static int bind4_prog_load(const struct sock_addr_test *test);
 static int bind6_prog_load(const struct sock_addr_test *test);
+static int bindun_prog_load(const struct sock_addr_test *test);
 static int connect4_prog_load(const struct sock_addr_test *test);
 static int connect6_prog_load(const struct sock_addr_test *test);
+static int connectun_prog_load(const struct sock_addr_test *test);
 static int sendmsg_allow_prog_load(const struct sock_addr_test *test);
 static int sendmsg_deny_prog_load(const struct sock_addr_test *test);
 static int recvmsg_allow_prog_load(const struct sock_addr_test *test);
@@ -102,6 +112,8 @@ static int recvmsg6_rw_c_prog_load(const struct sock_addr_test *test);
 static int sendmsg6_rw_c_prog_load(const struct sock_addr_test *test);
 static int sendmsg6_rw_v4mapped_prog_load(const struct sock_addr_test *test);
 static int sendmsg6_rw_wildcard_prog_load(const struct sock_addr_test *test);
+static int sendmsgun_prog_load(const struct sock_addr_test *test);
+static int recvmsgun_prog_load(const struct sock_addr_test *test);
 
 static struct sock_addr_test tests[] = {
 	/* bind */
@@ -217,6 +229,20 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		"bindun: rewrite path",
+		bindun_prog_load,
+		BPF_CGROUP_UNIX_BIND,
+		BPF_CGROUP_UNIX_BIND,
+		AF_UNIX,
+		SOCK_STREAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+		SUCCESS,
+	},
 
 	/* connect */
 	{
@@ -331,6 +357,34 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		"connectun: rewrite SOCK_STREAM path",
+		connectun_prog_load,
+		BPF_CGROUP_UNIX_CONNECT,
+		BPF_CGROUP_UNIX_CONNECT,
+		AF_UNIX,
+		SOCK_STREAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+		SUCCESS,
+	},
+	{
+		"connectun: rewrite SOCK_DGRAM path",
+		connectun_prog_load,
+		BPF_CGROUP_UNIX_CONNECT,
+		BPF_CGROUP_UNIX_CONNECT,
+		AF_UNIX,
+		SOCK_DGRAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+		SUCCESS,
+	},
 
 	/* sendmsg */
 	{
@@ -515,6 +569,20 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SYSCALL_EPERM,
 	},
+	{
+		"sendmsgun: rewrite SOCK_DGRAM path",
+		sendmsgun_prog_load,
+		BPF_CGROUP_UNIX_SENDMSG,
+		BPF_CGROUP_UNIX_SENDMSG,
+		AF_UNIX,
+		SOCK_DGRAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+		SUCCESS,
+	},
 
 	/* recvmsg */
 	{
@@ -601,6 +669,20 @@ static struct sock_addr_test tests[] = {
 		SERV6_IP,
 		SUCCESS,
 	},
+	{
+		"recvmsgun: rewrite SOCK_DGRAM path",
+		recvmsgun_prog_load,
+		BPF_CGROUP_UNIX_RECVMSG,
+		BPF_CGROUP_UNIX_RECVMSG,
+		AF_UNIX,
+		SOCK_DGRAM,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+		SUCCESS,
+	},
 };
 
 static int mk_sockaddr(int domain, const char *ip, unsigned short port,
@@ -608,8 +690,9 @@ static int mk_sockaddr(int domain, const char *ip, unsigned short port,
 {
 	struct sockaddr_in6 *addr6;
 	struct sockaddr_in *addr4;
+	struct sockaddr_un *addrun;
 
-	if (domain != AF_INET && domain != AF_INET6) {
+	if (domain != AF_INET && domain != AF_INET6 && domain != AF_UNIX) {
 		log_err("Unsupported address family");
 		return -1;
 	}
@@ -638,6 +721,15 @@ static int mk_sockaddr(int domain, const char *ip, unsigned short port,
 			return -1;
 		}
 		*addr_len = sizeof(struct sockaddr_in6);
+	} else if (domain == AF_UNIX) {
+		if (*addr_len < sizeof(struct sockaddr_un))
+			return -1;
+		addrun = (struct sockaddr_un *)addr;
+		addrun->sun_family = domain;
+		addrun->sun_path[0] = 0;
+		strcpy(addrun->sun_path + 1, ip);
+		*addr_len = offsetof(struct sockaddr_un, sun_path) + 1 +
+			    strlen(ip);
 	}
 
 	return 0;
@@ -706,6 +798,11 @@ static int bind6_prog_load(const struct sock_addr_test *test)
 	return load_path(test, BIND6_PROG_PATH);
 }
 
+static int bindun_prog_load(const struct sock_addr_test *test)
+{
+	return load_path(test, BINDUN_PROG_PATH);
+}
+
 static int connect4_prog_load(const struct sock_addr_test *test)
 {
 	return load_path(test, CONNECT4_PROG_PATH);
@@ -716,6 +813,11 @@ static int connect6_prog_load(const struct sock_addr_test *test)
 	return load_path(test, CONNECT6_PROG_PATH);
 }
 
+static int connectun_prog_load(const struct sock_addr_test *test)
+{
+	return load_path(test, CONNECTUN_PROG_PATH);
+}
+
 static int xmsg_ret_only_prog_load(const struct sock_addr_test *test,
 				   int32_t rc)
 {
@@ -889,12 +991,23 @@ static int sendmsg6_rw_c_prog_load(const struct sock_addr_test *test)
 	return load_path(test, SENDMSG6_PROG_PATH);
 }
 
+static int sendmsgun_prog_load(const struct sock_addr_test *test)
+{
+	return load_path(test, SENDMSGUN_PROG_PATH);
+}
+
+static int recvmsgun_prog_load(const struct sock_addr_test *test)
+{
+	return load_path(test, RECVMSGUN_PROG_PATH);
+}
+
 static int cmp_addr(const struct sockaddr_storage *addr1, socklen_t addr1_len,
 		    const struct sockaddr_storage *addr2, socklen_t addr2_len,
 		    int cmp_port)
 {
 	const struct sockaddr_in *four1, *four2;
 	const struct sockaddr_in6 *six1, *six2;
+	const struct sockaddr_un *un1, *un2;
 
 	if (addr1->ss_family != addr2->ss_family)
 		return -1;
@@ -913,6 +1026,10 @@ static int cmp_addr(const struct sockaddr_storage *addr1, socklen_t addr1_len,
 		return !((six1->sin6_port == six2->sin6_port || !cmp_port) &&
 			 !memcmp(&six1->sin6_addr, &six2->sin6_addr,
 				 sizeof(struct in6_addr)));
+	} else if (addr1->ss_family == AF_UNIX) {
+		un1 = (const struct sockaddr_un *)addr1;
+		un2 = (const struct sockaddr_un *)addr2;
+		return memcmp(un1, un2, addr1_len);
 	}
 
 	return -1;
@@ -992,7 +1109,7 @@ static int connect_to_server(int type, const struct sockaddr_storage *addr,
 
 	domain = addr->ss_family;
 
-	if (domain != AF_INET && domain != AF_INET6) {
+	if (domain != AF_INET && domain != AF_INET6 && domain != AF_UNIX) {
 		log_err("Unsupported address family");
 		goto err;
 	}
@@ -1066,7 +1183,7 @@ static int sendmsg_to_server(int type, const struct sockaddr_storage *addr,
 
 	domain = addr->ss_family;
 
-	if (domain != AF_INET && domain != AF_INET6) {
+	if (domain != AF_INET && domain != AF_INET6 && domain != AF_UNIX) {
 		log_err("Unsupported address family");
 		goto err;
 	}
@@ -1095,7 +1212,7 @@ static int sendmsg_to_server(int type, const struct sockaddr_storage *addr,
 			hdr.msg_control = &control6;
 			hdr.msg_controllen = sizeof(control6.buf);
 		}
-		if (init_pktinfo(domain, CMSG_FIRSTHDR(&hdr))) {
+		if (domain != AF_UNIX && init_pktinfo(domain, CMSG_FIRSTHDR(&hdr))) {
 			log_err("Fail to init pktinfo");
 			goto err;
 		}
@@ -1257,10 +1374,11 @@ static int run_connect_test_case(const struct sock_addr_test *test)
 	if (cmp_peer_addr(clientfd, &expected_addr, expected_addr_len))
 		goto err;
 
-	if (cmp_local_ip(clientfd, &expected_src_addr, expected_src_addr_len))
+	if (test->domain != AF_UNIX &&
+	    cmp_local_ip(clientfd, &expected_src_addr, expected_src_addr_len))
 		goto err;
 
-	if (test->type == SOCK_STREAM) {
+	if (test->domain != AF_UNIX && test->type == SOCK_STREAM) {
 		/* Test TCP Fast Open scenario */
 		clientfd = fastconnect_to_server(&requested_addr, addr_len);
 		if (clientfd == -1)
@@ -1339,7 +1457,8 @@ static int run_xmsg_test_case(const struct sock_addr_test *test, int max_cmsg)
 					&recvmsg_addr_len) == -1)
 			goto err;
 
-		if (cmp_addr(&recvmsg_addr, recvmsg_addr_len, &expected_addr,
+		if (test->domain != AF_UNIX &&
+		    cmp_addr(&recvmsg_addr, recvmsg_addr_len, &expected_addr,
 			     expected_addr_len,
 			     /*cmp_port*/ 0))
 			goto err;
@@ -1382,18 +1501,22 @@ static int run_test_case(int cgfd, const struct sock_addr_test *test)
 	switch (test->attach_type) {
 	case BPF_CGROUP_INET4_BIND:
 	case BPF_CGROUP_INET6_BIND:
+	case BPF_CGROUP_UNIX_BIND:
 		err = run_bind_test_case(test);
 		break;
 	case BPF_CGROUP_INET4_CONNECT:
 	case BPF_CGROUP_INET6_CONNECT:
+	case BPF_CGROUP_UNIX_CONNECT:
 		err = run_connect_test_case(test);
 		break;
 	case BPF_CGROUP_UDP4_SENDMSG:
 	case BPF_CGROUP_UDP6_SENDMSG:
+	case BPF_CGROUP_UNIX_SENDMSG:
 		err = run_xmsg_test_case(test, 1);
 		break;
 	case BPF_CGROUP_UDP4_RECVMSG:
 	case BPF_CGROUP_UDP6_RECVMSG:
+	case BPF_CGROUP_UNIX_RECVMSG:
 		err = run_xmsg_test_case(test, 0);
 		break;
 	default:
-- 
2.38.1

