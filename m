Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A7D6EAF29
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 18:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjDUQbg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 12:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjDUQbd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 12:31:33 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7357814F72
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94ed7e49541so256565166b.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682094687; x=1684686687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWulsIzALwMd9wYNJRNZRarwLcG9Zsb0Jk1OKBFMIm0=;
        b=Mu5BMbKDO4d56DDv8K49az0JtUA0OnpOdrVYuykwDygmfmbUJtx8DDtiZpnX4+Tr9g
         ZFkk7KXKic+g8KVs/R183mfrhcGXcod21oLIX5UhAhiz+qtjQDlKG8LcRZnB1FCnTROG
         H4OUy9V5GjYna6QPqs0q7kU75/bal6MDaySVetSFNB6+D13wB94FthL1CZQq72vEcW+9
         zKAtomE3OhDBpSkdLmhpi3ie3Ho7Je9TU7la2n0uQX3wpiEle0GoPsDlre7edu+3Ft63
         w0L1zNsjkyBCKRPmORyWOvP9O5+vOopcpTMTU/cU4Pd26829GqdhMpdreZIJI3wJB0+O
         D5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094687; x=1684686687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWulsIzALwMd9wYNJRNZRarwLcG9Zsb0Jk1OKBFMIm0=;
        b=UgEh0JyIen/A+zAAUFGC6+kjAyeuaGTKjFCEhHniHDppgsdoxNZUwgy+D6M0wcOxZw
         C/CP4nHMuiSlsrzB2kiN1j1PWWEXsmO1rljICvQXy4u33KVGV27mrvgeWuMFBNRkSsI8
         Bziq8+XbmLd5/j/ysIdfPFCRe2QBgG8bMjLauLlB4rh0KqkHYdHnNVDpeq7dKxku/FSb
         eNsqokhaUKpUzmdsQAFp9A2joniDDNGO68kffuIbrVRd3+DuoxA6k4l/feteqrh8+l4K
         zTaNvvukr+0u3UiKXAic9ublaCBGNmm83x5KbKL+cYKcF3vTTBw+Qor/hm+rkMyG16nA
         ufbQ==
X-Gm-Message-State: AAQBX9dJ/XF8SxObYZeAXeoeVUDV0brms53vypysz9vQ5u0kpnHGqP7w
        YTIyDYp8ltgXFwqOXugFbtJOOmo+fjem0Q==
X-Google-Smtp-Source: AKy350ZFeXqG2flUbiWOddZucH6cAB0YBgbwuAF/5Hx0TXzE39XdkikdrjwLuDsI4/4OthkUVWG5Ow==
X-Received: by 2002:a17:906:6b83:b0:94f:3d6e:f584 with SMTP id l3-20020a1709066b8300b0094f3d6ef584mr2924578ejr.5.1682094687392;
        Fri, 21 Apr 2023 09:31:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id k9-20020a170906970900b009534211cc97sm2248578ejx.159.2023.04.21.09.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 09:31:27 -0700 (PDT)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v3 09/10] selftests/bpf: Add tests for cgroup unix socket address hooks
Date:   Fri, 21 Apr 2023 18:27:17 +0200
Message-Id: <20230421162718.440230-10-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The unix socket address hooks do not support modifying the source
address so we skip source address checks when we're running a unix
socket address hook test.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  13 ++
 .../selftests/bpf/prog_tests/section_names.c  |  30 ++++
 .../testing/selftests/bpf/progs/bindun_prog.c |  59 ++++++++
 .../selftests/bpf/progs/connectun_prog.c      |  53 +++++++
 .../selftests/bpf/progs/recvmsgun_prog.c      |  59 ++++++++
 .../selftests/bpf/progs/sendmsgun_prog.c      |  53 +++++++
 tools/testing/selftests/bpf/test_sock_addr.c  | 137 +++++++++++++++++-
 7 files changed, 397 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bindun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/connectun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/recvmsgun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/sendmsgun_prog.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 8c993ec8ceea..dbdec3d5152e 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -1,6 +1,8 @@
 #ifndef __BPF_KFUNCS__
 #define __BPF_KFUNCS__
 
+struct bpf_sock_addr_kern;
+
 /* Description
  *  Initializes an skb-type dynptr
  * Returns
@@ -35,4 +37,15 @@ extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, __u32 offset,
 extern void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *ptr, __u32 offset,
 			      void *buffer, __u32 buffer__szk) __ksym;
 
+/* Description
+ *  Modify the contents of a sockaddr.
+ * Returns__bpf_kfunc
+ *  -EINVAL if the sockaddr family does not match, the sockaddr is too small or
+ *  too big, 0 if the sockaddr was successfully modified.
+ */
+extern int bpf_sock_addr_set(struct bpf_sock_addr_kern *sa_kern,
+			     const void *addr, __u32 addrlen__sz) __ksym;
+
+void *bpf_rdonly_cast(void *obj, __u32 btf_id) __ksym;
+
 #endif
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
index 000000000000..60addb5a9c96
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bindun_prog.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+
+#include <string.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_kfuncs.h"
+
+#ifndef AF_UNIX
+#define AF_UNIX 1
+#endif
+
+#define DST_REWRITE_PATH	"\0bpf_cgroup_unix_test_rewrite"
+
+void *bpf_cast_to_kern_ctx(void *) __ksym;
+
+SEC("cgroup/bindun")
+int bind_un_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock *sk = ctx->sk;
+	struct bpf_sock_addr_kern *sa_kern = bpf_cast_to_kern_ctx(ctx);
+	struct sockaddr_un *sa_kern_unaddr;
+	struct sockaddr_un unaddr = {
+		.sun_family = AF_UNIX,
+	};
+	__u32 unaddrlen = offsetof(struct sockaddr_un, sun_path) +
+			  sizeof(DST_REWRITE_PATH) - 1;
+	int ret;
+
+	if (!sk)
+		return 0;
+
+	if (sk->family != AF_UNIX)
+		return 0;
+
+	if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
+		return 0;
+
+	memcpy(unaddr.sun_path, DST_REWRITE_PATH, sizeof(DST_REWRITE_PATH) - 1);
+
+	ret = bpf_sock_addr_set(sa_kern, (struct sockaddr *) &unaddr, unaddrlen);
+	if (ret)
+		return 0;
+
+	if (sa_kern->uaddrlen != unaddrlen)
+		return 0;
+
+	sa_kern_unaddr = bpf_rdonly_cast(sa_kern->uaddr,
+					 bpf_core_type_id_kernel(struct sockaddr_un));
+	if (memcmp(sa_kern_unaddr->sun_path, DST_REWRITE_PATH,
+		   sizeof(DST_REWRITE_PATH) - 1) != 0)
+		return 0;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/connectun_prog.c b/tools/testing/selftests/bpf/progs/connectun_prog.c
new file mode 100644
index 000000000000..ac7209bd326f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/connectun_prog.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+
+#include <string.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_kfuncs.h"
+
+#ifndef AF_UNIX
+#define AF_UNIX 1
+#endif
+
+#define DST_REWRITE_PATH	"\0bpf_cgroup_unix_test_rewrite"
+
+void *bpf_cast_to_kern_ctx(void *) __ksym;
+
+SEC("cgroup/connectun")
+int connect_un_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock_addr_kern *sa_kern = bpf_cast_to_kern_ctx(ctx);
+	struct sockaddr_un *sa_kern_unaddr;
+	struct sockaddr_un unaddr = {
+		.sun_family = AF_UNIX,
+	};
+	__u32 unaddrlen = offsetof(struct sockaddr_un, sun_path) +
+			  sizeof(DST_REWRITE_PATH) - 1;
+	int ret;
+
+	if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
+		return 0;
+
+	memcpy(unaddr.sun_path, DST_REWRITE_PATH, sizeof(DST_REWRITE_PATH) - 1);
+
+	/* Rewrite destination. */
+	ret = bpf_sock_addr_set(sa_kern, (struct sockaddr *) &unaddr, unaddrlen);
+	if (ret)
+		return 0;
+
+	if (sa_kern->uaddrlen != unaddrlen)
+		return 0;
+
+	sa_kern_unaddr = bpf_rdonly_cast(sa_kern->uaddr,
+					 bpf_core_type_id_kernel(struct sockaddr_un));
+	if (memcmp(sa_kern_unaddr->sun_path, DST_REWRITE_PATH,
+		   sizeof(DST_REWRITE_PATH) - 1) != 0)
+		return 0;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/recvmsgun_prog.c b/tools/testing/selftests/bpf/progs/recvmsgun_prog.c
new file mode 100644
index 000000000000..4567aad723ee
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/recvmsgun_prog.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+
+#include <string.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_kfuncs.h"
+
+#ifndef AF_UNIX
+#define AF_UNIX 1
+#endif
+
+#define SERVUN_PATH		"\0bpf_cgroup_unix_test"
+
+void *bpf_cast_to_kern_ctx(void *) __ksym;
+
+SEC("cgroup/recvmsgun")
+int recvmsgun_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock *sk = ctx->sk;
+	struct bpf_sock_addr_kern *sa_kern = bpf_cast_to_kern_ctx(ctx);
+	struct sockaddr_un *sa_kern_unaddr;
+	struct sockaddr_un unaddr = {
+		.sun_family = AF_UNIX,
+	};
+	__u32 unaddrlen = offsetof(struct sockaddr_un, sun_path) +
+			  sizeof(SERVUN_PATH) - 1;
+	int ret;
+
+	if (!sk)
+		return 1;
+
+	if (sk->family != AF_UNIX)
+		return 1;
+
+	if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
+		return 1;
+
+	memcpy(unaddr.sun_path, SERVUN_PATH, sizeof(SERVUN_PATH) - 1);
+
+	ret = bpf_sock_addr_set(sa_kern, (struct sockaddr *) &unaddr, unaddrlen);
+	if (ret)
+		return 1;
+
+	if (sa_kern->uaddrlen != unaddrlen)
+		return 1;
+
+	sa_kern_unaddr = bpf_rdonly_cast(sa_kern->uaddr,
+					 bpf_core_type_id_kernel(struct sockaddr_un));
+	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_PATH,
+		   sizeof(SERVUN_PATH) - 1) != 0)
+		return 1;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/sendmsgun_prog.c b/tools/testing/selftests/bpf/progs/sendmsgun_prog.c
new file mode 100644
index 000000000000..3e4fe0859421
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sendmsgun_prog.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+
+#include <string.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_kfuncs.h"
+
+#ifndef AF_UNIX
+#define AF_UNIX 1
+#endif
+
+#define DST_REWRITE_PATH	"\0bpf_cgroup_unix_test_rewrite"
+
+void *bpf_cast_to_kern_ctx(void *) __ksym;
+
+SEC("cgroup/sendmsgun")
+int sendmsg_un_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock_addr_kern *sa_kern = bpf_cast_to_kern_ctx(ctx);
+	struct sockaddr_un *sa_kern_unaddr;
+	struct sockaddr_un unaddr = {
+		.sun_family = AF_UNIX,
+	};
+	__u32 unaddrlen = offsetof(struct sockaddr_un, sun_path) +
+			  sizeof(DST_REWRITE_PATH) - 1;
+	int ret;
+
+	if (ctx->type != SOCK_DGRAM)
+		return 0;
+
+	memcpy(unaddr.sun_path, DST_REWRITE_PATH, sizeof(DST_REWRITE_PATH) - 1);
+
+	/* Rewrite destination. */
+	ret = bpf_sock_addr_set(sa_kern, (struct sockaddr *) &unaddr, unaddrlen);
+	if (ret)
+		return 0;
+
+	if (sa_kern->uaddrlen != unaddrlen)
+		return 0;
+
+	sa_kern_unaddr = bpf_rdonly_cast(sa_kern->uaddr,
+					 bpf_core_type_id_kernel(struct sockaddr_un));
+	if (memcmp(sa_kern_unaddr->sun_path, DST_REWRITE_PATH,
+		   sizeof(DST_REWRITE_PATH) - 1) != 0)
+		return 0;
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
2.40.0

