Return-Path: <bpf+bounces-5668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D3275DA37
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 07:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801D71C21537
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 05:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF1AE563;
	Sat, 22 Jul 2023 05:23:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2678BEC
	for <bpf@vger.kernel.org>; Sat, 22 Jul 2023 05:23:03 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3FD1FF9
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 22:22:59 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5768a7e3adbso55277177b3.0
        for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 22:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690003378; x=1690608178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xk8iTGdwbd8Zsy4PoAcL/n6Hjgl6tK37/ejooBk7GLQ=;
        b=YTGiI3zKn4i96GZ09izHY0UcHWTvhfDpwBuUkucI+f7o2q+L9B9PTYmJu6HI5/xfeo
         H8Jw/4mMUFhRVQZ3BAes5k2SNzezgBDXKlny9zamfrL/kLjWvPNEwXFlFnpyihA5RlKe
         YJgMg6USssjI2fvlYm6gto0wISGZOvHMdAaSd1biroOmuzZ7gEzSHnuR490Ndq3LGo+I
         GvSEzI3K9v4l3ck0NVyxTO5HxMMaizMScHK0ZVfjeJEw/GC7VyW6BItnUomjePq+5aMQ
         ZuC83G8loVjnGL/ngHER6yqS6EC00MYcbpkJyxNzUvXPd4mSIdu+pmtngan19FdvLlba
         poFg==
X-Gm-Message-State: ABy/qLZ4YVEXKouj0cK7X/XbaZL0mlX+AwDyjvIgR45YdEl1h6H2noPq
	z4HrNXsUaW2xFmOexkyjDmHzeeob8p/tXw==
X-Google-Smtp-Source: APBJJlEhp8aQRjNYzMF5VEv/C4pIh6ISOkPsAKksqvrpJ49axEBwhU8plY3sbRWunzrKNlysj2Fhtg==
X-Received: by 2002:a0d:cccc:0:b0:56c:e5a3:3e09 with SMTP id o195-20020a0dcccc000000b0056ce5a33e09mr1456668ywd.15.1690003377592;
        Fri, 21 Jul 2023 22:22:57 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c289:3eeb:eb78:fe3b])
        by smtp.gmail.com with ESMTPSA id y191-20020a0dd6c8000000b00577335ea38csm1397829ywd.121.2023.07.21.22.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 22:22:57 -0700 (PDT)
From: kuifeng@meta.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	Kui-Feng Lee <kuifeng@meta.com>
Subject: [RFC bpf-next 5/5] bpf: Add test cases for sleepable BPF programs of the CGROUP_SOCKOPT type.
Date: Fri, 21 Jul 2023 22:22:48 -0700
Message-Id: <20230722052248.1062582-6-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722052248.1062582-1-kuifeng@meta.com>
References: <20230722052248.1062582-1-kuifeng@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <kuifeng@meta.com>

Do the same test as non-sleepable ones.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  27 ++
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  30 ++
 .../selftests/bpf/prog_tests/sockopt_sk.c     |  34 +-
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 299 ++++++++++++++++++
 .../selftests/bpf/verifier/sleepable.c        |   2 +-
 5 files changed, 389 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 209811b1993a..80b82858b50c 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -131,4 +131,31 @@ extern int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *nod
  */
 extern struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root) __ksym;
 
+/* Description
+ *	Allocate a buffer of 'size' bytes for being installed as optval.
+ * Returns
+ *	> 0 on success, the size of the allocated buffer
+ *	-ENOMEM or -EINVAL on failure
+ */
+extern int bpf_sockopt_alloc_optval(struct bpf_sockopt *sopt, int size,
+				    struct bpf_dynptr *ptr__uninit) __ksym;
+
+/* Description
+ *	Install the buffer pointed to by 'ptr' as optval.
+ * Returns
+ *	0 on success
+ *	-EINVAL if the buffer is too small
+ */
+extern int bpf_sockopt_install_optval(struct bpf_sockopt *sopt,
+				      struct bpf_dynptr *ptr) __ksym;
+
+/* Description
+ *	Release the buffer allocated by bpf_sockopt_alloc_optval.
+ * Returns
+ *	0 on success
+ *	-EINVAL if the buffer was not allocated by bpf_sockopt_alloc_optval
+ */
+extern int bpf_sockopt_release_optval(struct bpf_sockopt *sopt,
+				      struct bpf_dynptr *ptr) __ksym;
+
 #endif
diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 642dda0e758a..a77a1851865e 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -41,4 +41,34 @@ extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym;
 extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym;
 extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dynptr *clone__init) __ksym;
 
+extern int bpf_copy_to_user(void *dst__uninit, __u32 dst__sz,
+			    const void *src_ign) __ksym;
+
+/* Description
+ *	Allocate a buffer of 'size' bytes for being installed as optval.
+ * Returns
+ *	> 0 on success, the size of the allocated buffer
+ *	-ENOMEM or -EINVAL on failure
+ */
+extern int bpf_sockopt_alloc_optval(struct bpf_sockopt *sopt, int size,
+				    struct bpf_dynptr *ptr__uninit) __ksym;
+
+/* Description
+ *	Install the buffer pointed to by 'ptr' as optval.
+ * Returns
+ *	0 on success
+ *	-EINVAL if the buffer is too small
+ */
+extern int bpf_sockopt_install_optval(struct bpf_sockopt *sopt,
+				      struct bpf_dynptr *ptr) __ksym;
+
+/* Description
+ *	Release the buffer allocated by bpf_sockopt_alloc_optval.
+ * Returns
+ *	0 on success
+ *	-EINVAL if the buffer was not allocated by bpf_sockopt_alloc_optval
+ */
+extern int bpf_sockopt_release_optval(struct bpf_sockopt *sopt,
+				      struct bpf_dynptr *ptr) __ksym;
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
index cb990a7d3d45..33ac89c562a2 100644
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
@@ -26,6 +29,53 @@ struct {
 	__type(value, struct sockopt_sk);
 } socket_storage_map SEC(".maps");
 
+/* Copy optval data to destinate even if optval is in user space. */
+static inline int cp_from_optval(struct bpf_sockopt *ctx,
+			void *dst, int len)
+{
+	if (ctx->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER) {
+		if (len < 0 ||
+		    ctx->user_optval + len > ctx->user_optval_end)
+			return -1;
+		return bpf_copy_from_user(dst, len, ctx->user_optval);
+	}
+
+	if (len < 0 ||
+	    ctx->optval + len > ctx->optval_end)
+		return -1;
+	memcpy(dst, ctx->optval, len);
+
+	return 0;
+}
+
+/* Copy source data to optval even if optval is in user space. */
+static inline int cp_to_optval(struct bpf_sockopt *ctx,
+			       const void *src, int len)
+{
+	if (ctx->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER) {
+		if (len < 0 ||
+		    ctx->user_optval + len > ctx->user_optval_end)
+			return -1;
+		return bpf_copy_to_user(ctx->user_optval, len, src);
+	}
+
+	#if 0
+	/* Somehow, this doesn't work.
+	 *
+	 * clang version 17.0.0
+	 *
+	 * progs/sockopt_sk.c:65:2: error: A call to built-in function
+	 * 'memcpy' is not supported.
+	 */
+	if (len < 0 ||
+	    ctx->optval + len > ctx->optval_end)
+		return -1;
+	memcpy(ctx->optval, src, len);
+	#endif
+
+	return 0;
+}
+
 SEC("cgroup/getsockopt")
 int _getsockopt(struct bpf_sockopt *ctx)
 {
@@ -136,6 +186,133 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	return 1;
 }
 
+SEC("cgroup/getsockopt.s")
+int _getsockopt_s(struct bpf_sockopt *ctx)
+{
+	__u8 *optval_end = ctx->optval_end;
+	__u8 *optval = ctx->optval;
+	struct sockopt_sk *storage;
+	struct bpf_sock *sk;
+	struct tcp_zerocopy_receive zcvr;
+	char buf[1];
+	int ret;
+
+	if (ctx->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER) {
+		optval_end = ctx->user_optval_end;
+		optval = ctx->user_optval;
+	}
+
+	/* Bypass AF_NETLINK. */
+	sk = ctx->sk;
+	if (sk && sk->family == AF_NETLINK)
+		goto out;
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
+		goto out;
+	}
+
+	if (ctx->level == SOL_SOCKET && ctx->optname == SO_SNDBUF) {
+		/* Not interested in SOL_SOCKET:SO_SNDBUF;
+		 * let next BPF program in the cgroup chain or kernel
+		 * handle it.
+		 */
+		goto out;
+	}
+
+	if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION) {
+		/* Not interested in SOL_TCP:TCP_CONGESTION;
+		 * let next BPF program in the cgroup chain or kernel
+		 * handle it.
+		 */
+		goto out;
+	}
+
+	if (ctx->level == SOL_TCP && ctx->optname == TCP_ZEROCOPY_RECEIVE) {
+		/* Verify that TCP_ZEROCOPY_RECEIVE triggers.
+		 * It has a custom implementation for performance
+		 * reasons.
+		 */
+
+		/* Check that optval contains address (__u64) */
+		if (optval + sizeof(zcvr) > optval_end)
+			return 0; /* bounds check */
+
+		ret = cp_from_optval(ctx, &zcvr, sizeof(zcvr));
+		if (ret < 0)
+			return 0;
+		if (zcvr.address != 0)
+			return 0; /* unexpected data */
+
+		goto out;
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
+		ret = cp_to_optval(ctx, buf, 1);
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
+	ret = cp_to_optval(ctx, buf, 1);
+	if (ret < 0)
+		return 0;
+	ctx->optlen = 1;
+
+	return 1;
+
+out:
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > page_size)
+		ctx->optlen = 0;
+	return 1;
+}
+
 SEC("cgroup/setsockopt")
 int _setsockopt(struct bpf_sockopt *ctx)
 {
@@ -236,3 +413,125 @@ int _setsockopt(struct bpf_sockopt *ctx)
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
+	if (!(ctx->flags & BPF_SOCKOPT_FLAG_OPTVAL_ALLOC))
+		return 0;
+
+	if (ctx->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER) {
+		optval_end = ctx->user_optval_end;
+		optval = ctx->user_optval;
+	}
+
+	/* Bypass AF_NETLINK. */
+	sk = ctx->sk;
+	if (sk && sk->family == AF_NETLINK)
+		goto out;
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
+		if (optval + sizeof(__u32) > optval_end)
+			return 0; /* bounds check */
+
+		tmp = 0x55AA;
+		ret = cp_to_optval(ctx, &tmp, sizeof(tmp));
+		if (ret < 0)
+			return 0;
+		ctx->optlen = 4;
+
+		return 1;
+	}
+
+	if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION) {
+		/* Always use cubic */
+
+		ret = bpf_sockopt_alloc_optval(ctx, 5, &optval_buf);
+		if (ret < 0) {
+			bpf_sockopt_release_optval(ctx, &optval_buf);
+			return 0;
+		}
+		bpf_dynptr_write(&optval_buf, 0, "cubic", 5, 0);
+		ret = bpf_sockopt_install_optval(ctx, &optval_buf);
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
+		ret = bpf_sockopt_alloc_optval(ctx, 1, &optval_buf);
+		if (ret < 0) {
+			bpf_sockopt_release_optval(ctx, &optval_buf);
+			return 0;
+		}
+		tmp_u8 = 0;
+		bpf_dynptr_write(&optval_buf, 0, &tmp_u8, 1, 0);
+		ret = bpf_sockopt_install_optval(ctx, &optval_buf);
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
+	ret = cp_from_optval(ctx, &storage->val, 1);
+	if (ret < 0)
+		return 0;
+	ctx->optlen = -1; /* BPF has consumed this option, don't call kernel
+			   * setsockopt handler.
+			   */
+
+	return 1;
+
+out:
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > page_size)
+		ctx->optlen = 0;
+	return 1;
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


