Return-Path: <bpf+bounces-7520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1A6778688
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 06:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B521F28184C
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 04:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89681872;
	Fri, 11 Aug 2023 04:31:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C49310F8
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 04:31:42 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49C22700
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 21:31:40 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-583fe10bb3cso17998567b3.2
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 21:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691728300; x=1692333100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8V+BEPKBQqIxV4EKn5ggp5dLKh2VJhA4yojeA2l5zQ=;
        b=SLG1YH/z6Bw1n5AoncmyXbhfWy4fGDcC/yFG9jglcD7crDruMKvYXSNeeuWbzBvCxH
         Mkt/w5CveD5E5ZCTqLeIqYePQy0aDquvmOkr1dZsnWIzucLg7UY3r5BqbHkfeEiSxDoW
         URsUAsvW4b94Tdiud0YITNk7i8zIBYHIB0RD47gD4RKFaZxAegxMm8vviQyTe3UiWTXX
         J8uCkKrUib+mKAGtuAFtjx0io+yqTugX71bdTPKksVXD2vwHzA7+ffW2KaQGa2dsA1vS
         eA9DhYfecwhT9XDB+gAe4QHAkCr3N0H//ykfsnzLp/UNa7+ZJ6iPdgFBm5MDHP/Zb5Jd
         plSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691728300; x=1692333100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8V+BEPKBQqIxV4EKn5ggp5dLKh2VJhA4yojeA2l5zQ=;
        b=OaL8u1Y/G8rljvYSdvbdRuv4/LYYTC5P/kgo2RtDk1ZNy0DQm25kwMScU3i18M73H4
         gMAiNJOrlDMrGoAmf5o5ywEv8OAwIOOH0r3wUGbmfmLP5TGOgLM6RaMvdol8/N4CwRKD
         YditFBqQ541ieju//5IKsxACJDR3K17mjaIam4s80OVgV/uolPukHRKWZA51JSmKa/zw
         s7/XKqAdgZZ7wOwhlV78P/sB1ogmVaL4/SnmyeyDFkP2A97l0vWRVrzQCnlvty+WIudr
         ab45BUcDc7W0gwVm8wK+/494paUjPa4JvtLCOWcw9UtGvvobg5X/ap6aMU5FSITiRUUt
         Ir5g==
X-Gm-Message-State: AOJu0Yzkli3D6oM+mwf18/LL+3BI2kif5EAUUkdw4sutN39DiJP9L1vb
	B+U8LJ16AamDpoi1vOV5u59q97qN7yBXuQ==
X-Google-Smtp-Source: AGHT+IFb8xQmuD5TQJZEpcruITePcLuvqDs6EzBlorKQoA4dGa4Whjy9P6yILLjiGGNHubED0MIWYA==
X-Received: by 2002:a81:91c5:0:b0:584:189c:13ec with SMTP id i188-20020a8191c5000000b00584189c13ecmr1258747ywg.21.1691728299663;
        Thu, 10 Aug 2023 21:31:39 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:16da:9387:4176:e970])
        by smtp.gmail.com with ESMTPSA id n15-20020a819c4f000000b00583e52232f1sm767961ywa.112.2023.08.10.21.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 21:31:39 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@google.com,
	yonghong.song@linux.dev
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v2 6/6] bpf: Add test cases for sleepable BPF programs of the CGROUP_SOCKOPT type.
Date: Thu, 10 Aug 2023 21:31:27 -0700
Message-Id: <20230811043127.1318152-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811043127.1318152-1-thinker.li@gmail.com>
References: <20230811043127.1318152-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <kuifeng@meta.com>

Do the same test as non-sleepable ones.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  44 ++++
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  47 ++++
 .../selftests/bpf/prog_tests/sockopt_sk.c     |  34 ++-
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 242 ++++++++++++++++++
 .../selftests/bpf/verifier/sleepable.c        |   2 +-
 5 files changed, 366 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 209811b1993a..553c60818996 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -131,4 +131,48 @@ extern int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *nod
  */
 extern struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root) __ksym;
 
+/*
+ *     Description
+ *             Copy data from *ptr* to *sopt->optval*.
+ *     Return
+ *             >= 0 on success, or a negative error in case of failure.
+ */
+extern int bpf_so_optval_copy_to_r(struct bpf_sockopt *sopt,
+				   void *ptr, u32 ptr__sz) __ksym;
+/*
+ *     Description
+ *             Copy data from *ptr* to *sopt->optval*.
+ *     Return
+ *             >= 0 on success, or a negative error in case of failure.
+ */
+extern int bpf_so_optval_copy_to(struct bpf_sockopt *sopt,
+				 struct bpf_dynptr *ptr) __ksym;
+
+/* Description
+ *	Allocate a buffer of 'size' bytes for being installed as optval.
+ * Returns
+ *	> 0 on success, the size of the allocated buffer
+ *	-ENOMEM or -EINVAL on failure
+ */
+extern int bpf_so_optval_alloc(struct bpf_sockopt *sopt, int size,
+			       struct bpf_dynptr *ptr__uninit) __ksym;
+
+/* Description
+ *	Install the buffer pointed to by 'ptr' as optval.
+ * Returns
+ *	0 on success
+ *	-EINVAL if the buffer is too small
+ */
+extern int bpf_so_optval_install(struct bpf_sockopt *sopt,
+				 struct bpf_dynptr *ptr) __ksym;
+
+/* Description
+ *	Release the buffer allocated by bpf_so_optval_alloc.
+ * Returns
+ *	0 on success
+ *	-EINVAL if the buffer was not allocated by bpf_so_optval_alloc
+ */
+extern int bpf_so_optval_release(struct bpf_sockopt *sopt,
+				 struct bpf_dynptr *ptr) __ksym;
+
 #endif
diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 642dda0e758a..7c01825b10c8 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -41,4 +41,51 @@ extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym;
 extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym;
 extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dynptr *clone__init) __ksym;
 
+extern int bpf_copy_to_user(void *dst__uninit, __u32 dst__sz,
+			    const void *src_ign) __ksym;
+
+extern int bpf_so_optval_copy_to_r(struct bpf_sockopt *sopt,
+				   void *ptr, __u32 ptr__sz) __ksym;
+
+extern int bpf_so_optval_copy_to(struct bpf_sockopt *sopt,
+				 struct bpf_dynptr *ptr) __ksym;
+
+/* Description
+ *	Allocate a buffer of 'size' bytes for being installed as optval.
+ * Returns
+ *	> 0 on success, the size of the allocated buffer
+ *	-ENOMEM or -EINVAL on failure
+ */
+extern int bpf_so_optval_alloc(struct bpf_sockopt *sopt, int size,
+			       struct bpf_dynptr *ptr__uninit) __ksym;
+
+/* Description
+ *	Install the buffer pointed to by 'ptr' as optval.
+ * Returns
+ *	0 on success
+ *	-EINVAL if the buffer is too small
+ */
+extern int bpf_so_optval_install(struct bpf_sockopt *sopt,
+				 struct bpf_dynptr *ptr) __ksym;
+
+/* Description
+ *	Release the buffer allocated by bpf_so_optval_alloc.
+ * Returns
+ *	0 on success
+ *	-EINVAL if the buffer was not allocated by bpf_so_optval_alloc
+ */
+extern int bpf_so_optval_release(struct bpf_sockopt *sopt,
+				 struct bpf_dynptr *ptr) __ksym;
+
+/* Description
+ *	Initialize a dynptr to access the content of optval passing
+ *      to {get,set}sockopt()s.
+ * Returns
+ *	> 0 on success, the size of the allocated buffer
+ *	-ENOMEM or -EINVAL on failure
+ */
+extern int bpf_so_optval_from(struct bpf_sockopt *sopt,
+			      struct bpf_dynptr *ptr__uninit,
+			      unsigned int size) __ksym;
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index 05d0e07da394..e18a40d89860 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -92,6 +92,7 @@ static int getsetsockopt(void)
 	}
 	if (buf.u8[0] != 0x01) {
 		log_err("Unexpected buf[0] 0x%02x != 0x01", buf.u8[0]);
+		log_err("optlen %d", optlen);
 		goto err;
 	}
 
@@ -220,7 +221,7 @@ static int getsetsockopt(void)
 	return -1;
 }
 
-static void run_test(int cgroup_fd)
+static void run_test_nonsleepable(int cgroup_fd)
 {
 	struct sockopt_sk *skel;
 
@@ -246,6 +247,32 @@ static void run_test(int cgroup_fd)
 	sockopt_sk__destroy(skel);
 }
 
+static void run_test_sleepable(int cgroup_fd)
+{
+	struct sockopt_sk *skel;
+
+	skel = sockopt_sk__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	skel->bss->page_size = getpagesize();
+
+	skel->links._setsockopt_s =
+		bpf_program__attach_cgroup(skel->progs._setsockopt_s, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links._setsockopt_s, "setsockopt_link"))
+		goto cleanup;
+
+	skel->links._getsockopt_s =
+		bpf_program__attach_cgroup(skel->progs._getsockopt_s, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links._getsockopt_s, "getsockopt_link"))
+		goto cleanup;
+
+	ASSERT_OK(getsetsockopt(), "getsetsockopt");
+
+cleanup:
+	sockopt_sk__destroy(skel);
+}
+
 void test_sockopt_sk(void)
 {
 	int cgroup_fd;
@@ -254,6 +281,9 @@ void test_sockopt_sk(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup /sockopt_sk"))
 		return;
 
-	run_test(cgroup_fd);
+	if (test__start_subtest("nonsleepable"))
+		run_test_nonsleepable(cgroup_fd);
+	if (test__start_subtest("sleepable"))
+		run_test_sleepable(cgroup_fd);
 	close(cgroup_fd);
 }
diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index cb990a7d3d45..e1aacefd301e 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -5,6 +5,9 @@
 #include <netinet/in.h>
 #include <bpf/bpf_helpers.h>
 
+typedef int bool;
+#include "bpf_kfuncs.h"
+
 char _license[] SEC("license") = "GPL";
 
 int page_size = 0; /* userspace should set it */
@@ -136,6 +139,129 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	return 1;
 }
 
+SEC("cgroup/getsockopt.s")
+int _getsockopt_s(struct bpf_sockopt *ctx)
+{
+	__u8 *optval_end = ctx->optval_end;
+	__u8 *optval = ctx->optval;
+	struct tcp_zerocopy_receive *zcvr;
+	struct bpf_dynptr optval_dynptr;
+	struct sockopt_sk *storage;
+	struct bpf_sock *sk;
+	char buf[1];
+	__u64 addr;
+	int ret;
+
+	if (ctx->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER) {
+		optval_end = ctx->optval_end;
+		optval = ctx->optval;
+	}
+
+	/* Bypass AF_NETLINK. */
+	sk = ctx->sk;
+	if (sk && sk->family == AF_NETLINK)
+		return 1;
+
+	/* Make sure bpf_get_netns_cookie is callable.
+	 */
+	if (bpf_get_netns_cookie(NULL) == 0)
+		return 0;
+
+	if (bpf_get_netns_cookie(ctx) == 0)
+		return 0;
+
+	if (ctx->level == SOL_IP && ctx->optname == IP_TOS) {
+		/* Not interested in SOL_IP:IP_TOS;
+		 * let next BPF program in the cgroup chain or kernel
+		 * handle it.
+		 */
+		return 1;
+	}
+
+	if (ctx->level == SOL_SOCKET && ctx->optname == SO_SNDBUF) {
+		/* Not interested in SOL_SOCKET:SO_SNDBUF;
+		 * let next BPF program in the cgroup chain or kernel
+		 * handle it.
+		 */
+		return 1;
+	}
+
+	if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION) {
+		/* Not interested in SOL_TCP:TCP_CONGESTION;
+		 * let next BPF program in the cgroup chain or kernel
+		 * handle it.
+		 */
+		return 1;
+	}
+
+	if (ctx->level == SOL_TCP && ctx->optname == TCP_ZEROCOPY_RECEIVE) {
+		/* Verify that TCP_ZEROCOPY_RECEIVE triggers.
+		 * It has a custom implementation for performance
+		 * reasons.
+		 */
+
+		bpf_so_optval_from(ctx, &optval_dynptr, sizeof(*zcvr));
+		zcvr = bpf_dynptr_data(&optval_dynptr, 0, sizeof(*zcvr));
+		addr = zcvr ? zcvr->address : 0;
+		bpf_so_optval_release(ctx, &optval_dynptr);
+
+		return addr != 0 ? 0 : 1;
+	}
+
+	if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
+		if (optval + 1 > optval_end)
+			return 0; /* bounds check */
+
+		ctx->retval = 0; /* Reset system call return value to zero */
+
+		/* Always export 0x55 */
+		buf[0] = 0x55;
+		ret = bpf_so_optval_alloc(ctx, 1, &optval_dynptr);
+		if (ret >= 0) {
+			bpf_dynptr_write(&optval_dynptr, 0, buf, 1, 0);
+			ret = bpf_so_optval_copy_to(ctx, &optval_dynptr);
+		}
+		bpf_so_optval_release(ctx, &optval_dynptr);
+		if (ret < 0)
+			return 0;
+		ctx->optlen = 1;
+
+		/* Userspace buffer is PAGE_SIZE * 2, but BPF
+		 * program can only see the first PAGE_SIZE
+		 * bytes of data.
+		 */
+		if (optval_end - optval != page_size && 0)
+			return 0; /* unexpected data size */
+
+		return 1;
+	}
+
+	if (ctx->level != SOL_CUSTOM)
+		return 0; /* deny everything except custom level */
+
+	if (optval + 1 > optval_end)
+		return 0; /* bounds check */
+
+	storage = bpf_sk_storage_get(&socket_storage_map, ctx->sk, 0,
+				     BPF_SK_STORAGE_GET_F_CREATE);
+	if (!storage)
+		return 0; /* couldn't get sk storage */
+
+	if (!ctx->retval)
+		return 0; /* kernel should not have handled
+			   * SOL_CUSTOM, something is wrong!
+			   */
+	ctx->retval = 0; /* Reset system call return value to zero */
+
+	buf[0] = storage->val;
+	ret = bpf_so_optval_copy_to_r(ctx, buf, 1);
+	if (ret < 0)
+		return 0;
+	ctx->optlen = 1;
+
+	return 1;
+}
+
 SEC("cgroup/setsockopt")
 int _setsockopt(struct bpf_sockopt *ctx)
 {
@@ -236,3 +362,119 @@ int _setsockopt(struct bpf_sockopt *ctx)
 		ctx->optlen = 0;
 	return 1;
 }
+
+SEC("cgroup/setsockopt.s")
+int _setsockopt_s(struct bpf_sockopt *ctx)
+{
+	__u8 *optval_end = ctx->optval_end;
+	struct bpf_dynptr optval_buf;
+	__u8 *optval = ctx->optval;
+	struct sockopt_sk *storage;
+	struct bpf_sock *sk;
+	__u8 tmp_u8;
+	__u32 tmp;
+	int ret;
+
+	if (ctx->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER) {
+		optval_end = ctx->optval_end;
+		optval = ctx->optval;
+	}
+
+	/* Bypass AF_NETLINK. */
+	sk = ctx->sk;
+	if (sk && sk->family == AF_NETLINK)
+		return -1;
+
+	/* Make sure bpf_get_netns_cookie is callable.
+	 */
+	if (bpf_get_netns_cookie(NULL) == 0)
+		return 0;
+
+	if (bpf_get_netns_cookie(ctx) == 0)
+		return 0;
+
+	if (ctx->level == SOL_IP && ctx->optname == IP_TOS) {
+		/* Not interested in SOL_IP:IP_TOS;
+		 * let next BPF program in the cgroup chain or kernel
+		 * handle it.
+		 */
+		ctx->optlen = 0; /* bypass optval>PAGE_SIZE */
+		return 1;
+	}
+
+	if (ctx->level == SOL_SOCKET && ctx->optname == SO_SNDBUF) {
+		/* Overwrite SO_SNDBUF value */
+
+		ret = bpf_so_optval_alloc(ctx, sizeof(__u32), &optval_buf);
+		if (ret < 0)
+			bpf_so_optval_release(ctx, &optval_buf);
+		else {
+			tmp = 0x55AA;
+			bpf_dynptr_write(&optval_buf, 0, &tmp, sizeof(tmp), 0);
+			ret = bpf_so_optval_install(ctx, &optval_buf);
+		}
+
+		return ret >= 0 ? 1 : 0;
+	}
+
+	if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION) {
+		/* Always use cubic */
+
+		ret = bpf_so_optval_alloc(ctx, 5, &optval_buf);
+		if (ret < 0) {
+			bpf_so_optval_release(ctx, &optval_buf);
+			return 0;
+		}
+		bpf_dynptr_write(&optval_buf, 0, "cubic", 5, 0);
+		ret = bpf_so_optval_install(ctx, &optval_buf);
+		if (ret < 0)
+			return 0;
+		ctx->optlen = 5;
+
+		return 1;
+	}
+
+	if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
+		/* Original optlen is larger than PAGE_SIZE. */
+		if (ctx->optlen != page_size * 2)
+			return 0; /* unexpected data size */
+
+		ret = bpf_so_optval_alloc(ctx, 1, &optval_buf);
+		if (ret < 0) {
+			bpf_so_optval_release(ctx, &optval_buf);
+			return 0;
+		}
+		tmp_u8 = 0;
+		bpf_dynptr_write(&optval_buf, 0, &tmp_u8, 1, 0);
+		ret = bpf_so_optval_install(ctx, &optval_buf);
+		if (ret < 0)
+			return 0;
+		ctx->optlen = 1;
+
+		return 1;
+	}
+
+	if (ctx->level != SOL_CUSTOM)
+		return 0; /* deny everything except custom level */
+
+	if (optval + 1 > optval_end)
+		return 0; /* bounds check */
+
+	storage = bpf_sk_storage_get(&socket_storage_map, ctx->sk, 0,
+				     BPF_SK_STORAGE_GET_F_CREATE);
+	if (!storage)
+		return 0; /* couldn't get sk storage */
+
+	bpf_so_optval_from(ctx, &optval_buf, sizeof(__u8));
+	optval = bpf_dynptr_data(&optval_buf, 0, sizeof(__u8));
+	if (optval) {
+		storage->val = *optval;
+		ctx->optlen = -1; /* BPF has consumed this option, don't call
+				   * kernel setsockopt handler.
+				   */
+	}
+	bpf_so_optval_release(ctx, &optval_buf);
+
+	return optval ? 1 : 0;
+}
+
diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
index 1f0d2bdc673f..4b6c1117ec9f 100644
--- a/tools/testing/selftests/bpf/verifier/sleepable.c
+++ b/tools/testing/selftests/bpf/verifier/sleepable.c
@@ -85,7 +85,7 @@
 	.expected_attach_type = BPF_TRACE_RAW_TP,
 	.kfunc = "sched_switch",
 	.result = REJECT,
-	.errstr = "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
+	.errstr = "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, cgroup, and struct_ops programs can be sleepable",
 	.flags = BPF_F_SLEEPABLE,
 	.runs = -1,
 },
-- 
2.34.1


