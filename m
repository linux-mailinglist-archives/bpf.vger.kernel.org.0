Return-Path: <bpf+bounces-8118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509C87816EF
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 05:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C56281D89
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 03:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2667D1383;
	Sat, 19 Aug 2023 03:01:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA691368
	for <bpf@vger.kernel.org>; Sat, 19 Aug 2023 03:01:56 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43283C34
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 20:01:54 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58e6c05f529so16457787b3.3
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 20:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692414113; x=1693018913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P99fQ1gl3fWOGRt+EFQwR0jt13y17aQ4KhHrP6KeBeE=;
        b=Lfh5CgmNsLLc4cG2Jiac6kpz/juQ4ReEJVprX23mVPEcvfmGp0WLOu71kKRLrNCRQO
         Xd6Yhu3Lkws94ltWE30uCIHYL77RKbp9xyLjhW8Kn5NeTyPeIHUUAWqQ6exrYRRSK2JM
         +znOncVR3ylW8cgzUtFpv5c62Z+xY44jAn+povJoR/lMj+Y2rF4f9qAgu5NnFohy0FkE
         /JM/3vNKKYaGUZh4hK9E2thdTBGrEsoVi13CbTUr6gv1VH0zrqFisyZnP/KYKLQXFrdp
         6Yr7KLXthCUjFMcKbur1d7bTL53lc5UsPWt3vPQaKBn+lOaDvaOw3cxc0aK/dkbXH/FZ
         yvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692414113; x=1693018913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P99fQ1gl3fWOGRt+EFQwR0jt13y17aQ4KhHrP6KeBeE=;
        b=NVtwd2UOjXsERFWmDJXOWpEik5O69QHdXDG+GoR6Rl20fCgvV6Upym/FhcUzuA5IZG
         mRRouVr9ZjwimhAkmN1CV/cQlsodDULPJotReftkvicKCJ49aIoAoL1lUQgNRzOQTpBh
         hCAi3pLygtz+ufS54C2P0umIGM8TfXW8LnJNy+pRBgLpCsEL6H676l3HBErMrO9mLueC
         vc0MvYLQRUmCHHJKBUqNo0ekDNws8YS/nvCNXWkq4Grs21gyRYnNMxC9dkuSczTm9rrV
         X7n9DJCLmK3+JMb3BIJPVsBan9mNTdGRYXcy/frPwYKgnbIScMV30RJrRxktFdF+3pA0
         aF0w==
X-Gm-Message-State: AOJu0YxvSakQScXNdyGTWbfqUQHsGbQNTN+CQc1FvKpH7e0UTze4A3Kz
	ss/+1BEh1Mwps9kwiOpbxkbz18kzwUg=
X-Google-Smtp-Source: AGHT+IHgYr0CFZoGT3DHXvdrga5w9BDvp3meomDKqZXA6vL0eWL2ArToeJ67bBT0DXckubvZEFsnmw==
X-Received: by 2002:a81:6d53:0:b0:583:9018:6fbb with SMTP id i80-20020a816d53000000b0058390186fbbmr1136386ywc.37.1692414113625;
        Fri, 18 Aug 2023 20:01:53 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a059:9262:e315:4c20])
        by smtp.gmail.com with ESMTPSA id o199-20020a0dccd0000000b005704c4d3579sm903897ywd.40.2023.08.18.20.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 20:01:53 -0700 (PDT)
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
Subject: [RFC bpf-next v4 6/6] selftests/bpf: Add test cases for sleepable BPF programs of the CGROUP_SOCKOPT type
Date: Fri, 18 Aug 2023 20:01:43 -0700
Message-Id: <20230819030143.419729-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819030143.419729-1-thinker.li@gmail.com>
References: <20230819030143.419729-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

Do the same test as non-sleepable ones.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  22 ++
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  22 ++
 .../selftests/bpf/prog_tests/sockopt_sk.c     | 112 +++++++-
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 254 ++++++++++++++++++
 .../selftests/bpf/verifier/sleepable.c        |   2 +-
 5 files changed, 409 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 209811b1993a..20821a5960f0 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -131,4 +131,26 @@ extern int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *nod
  */
 extern struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root) __ksym;
 
+/* Description
+ *	Release the buffer allocated by bpf_dynptr_from_sockopt.
+ * Returns
+ *	0 on success
+ *	-EINVAL if the buffer was not allocated by bpf_dynptr_from_sockopt
+ */
+extern int bpf_sockopt_dynptr_release(struct bpf_sockopt *sopt,
+				      struct bpf_dynptr *ptr) __ksym;
+
+/* Description
+ *	Initialize a dynptr to access the content of optval passing
+ *      to {get,set}sockopt()s.
+ * Returns
+ *	> 0 on success, the size of the allocated buffer
+ *	-ENOMEM or -EINVAL on failure
+ */
+extern int bpf_dynptr_from_sockopt(struct bpf_sockopt *sopt,
+				   struct bpf_dynptr *ptr__uninit) __ksym;
+
+extern int bpf_sockopt_grow_to(struct bpf_sockopt *sopt,
+			       __u32 newsize) __ksym;
+
 #endif
diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 642dda0e758a..f50a976a315d 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -41,4 +41,26 @@ extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym;
 extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym;
 extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dynptr *clone__init) __ksym;
 
+/* Description
+ *	Release the buffer allocated by bpf_dynptr_from_sockopt.
+ * Returns
+ *	0 on success
+ *	-EINVAL if the buffer was not allocated by bpf_dynptr_from_sockopt
+ */
+extern int bpf_sockopt_dynptr_release(struct bpf_sockopt *sopt,
+				      struct bpf_dynptr *ptr) __ksym;
+
+/* Description
+ *	Initialize a dynptr to access the content of optval passing
+ *      to {get,set}sockopt()s.
+ * Returns
+ *	> 0 on success, the size of the allocated buffer
+ *	-ENOMEM or -EINVAL on failure
+ */
+extern int bpf_dynptr_from_sockopt(struct bpf_sockopt *sopt,
+				   struct bpf_dynptr *ptr__uninit) __ksym;
+
+extern int bpf_sockopt_grow_to(struct bpf_sockopt *sopt,
+			       __u32 newsize) __ksym;
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index 05d0e07da394..85255648747f 100644
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
 
@@ -246,6 +247,106 @@ static void run_test(int cgroup_fd)
 	sockopt_sk__destroy(skel);
 }
 
+static void run_test_nonsleepable_mixed(int cgroup_fd)
+{
+	struct sockopt_sk *skel;
+
+	skel = sockopt_sk__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	skel->bss->page_size = getpagesize();
+	skel->bss->skip_sleepable = 1;
+
+	skel->links._setsockopt_s =
+		bpf_program__attach_cgroup(skel->progs._setsockopt_s, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links._setsockopt_s, "setsockopt_link (sleepable)"))
+		goto cleanup;
+
+	skel->links._getsockopt_s =
+		bpf_program__attach_cgroup(skel->progs._getsockopt_s, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links._getsockopt_s, "getsockopt_link (sleepable)"))
+		goto cleanup;
+
+	skel->links._setsockopt =
+		bpf_program__attach_cgroup(skel->progs._setsockopt, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links._setsockopt, "setsockopt_link"))
+		goto cleanup;
+
+	skel->links._getsockopt =
+		bpf_program__attach_cgroup(skel->progs._getsockopt, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links._getsockopt, "getsockopt_link"))
+		goto cleanup;
+
+	ASSERT_OK(getsetsockopt(), "getsetsockopt");
+
+cleanup:
+	sockopt_sk__destroy(skel);
+}
+
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
+static void run_test_sleepable_mixed(int cgroup_fd)
+{
+	struct sockopt_sk *skel;
+
+	skel = sockopt_sk__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	skel->bss->page_size = getpagesize();
+	skel->bss->skip_nonsleepable = 1;
+
+	skel->links._setsockopt =
+		bpf_program__attach_cgroup(skel->progs._setsockopt, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links._setsockopt, "setsockopt_link (nonsleepable)"))
+		goto cleanup;
+
+	skel->links._getsockopt =
+		bpf_program__attach_cgroup(skel->progs._getsockopt, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links._getsockopt, "getsockopt_link (nonsleepable)"))
+		goto cleanup;
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
@@ -254,6 +355,13 @@ void test_sockopt_sk(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup /sockopt_sk"))
 		return;
 
-	run_test(cgroup_fd);
+	if (test__start_subtest("nonsleepable"))
+		run_test_nonsleepable(cgroup_fd);
+	if (test__start_subtest("sleepable"))
+		run_test_sleepable(cgroup_fd);
+	if (test__start_subtest("nonsleepable_mixed"))
+		run_test_nonsleepable_mixed(cgroup_fd);
+	if (test__start_subtest("sleepable_mixed"))
+		run_test_sleepable_mixed(cgroup_fd);
 	close(cgroup_fd);
 }
diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index cb990a7d3d45..60864452436c 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -5,10 +5,16 @@
 #include <netinet/in.h>
 #include <bpf/bpf_helpers.h>
 
+typedef int bool;
+#include "bpf_kfuncs.h"
+
 char _license[] SEC("license") = "GPL";
 
 int page_size = 0; /* userspace should set it */
 
+int skip_sleepable = 0;
+int skip_nonsleepable = 0;
+
 #ifndef SOL_TCP
 #define SOL_TCP IPPROTO_TCP
 #endif
@@ -34,6 +40,9 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	struct sockopt_sk *storage;
 	struct bpf_sock *sk;
 
+	if (skip_nonsleepable)
+		return 1;
+
 	/* Bypass AF_NETLINK. */
 	sk = ctx->sk;
 	if (sk && sk->family == AF_NETLINK)
@@ -136,6 +145,133 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	return 1;
 }
 
+SEC("cgroup/getsockopt.s")
+int _getsockopt_s(struct bpf_sockopt *ctx)
+{
+	struct tcp_zerocopy_receive zcvr;
+	struct bpf_dynptr optval_dynptr;
+	struct sockopt_sk *storage;
+	__u8 *optval, *optval_end;
+	struct bpf_sock *sk;
+	char buf[1];
+	__u64 addr;
+	int ret;
+
+	if (skip_sleepable)
+		return 1;
+
+	/* Bypass AF_NETLINK. */
+	sk = ctx->sk;
+	if (sk && sk->family == AF_NETLINK)
+		return 1;
+
+	optval = ctx->optval;
+	optval_end = ctx->optval_end;
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
+		bpf_dynptr_from_sockopt(ctx, &optval_dynptr);
+		ret = bpf_dynptr_read(&zcvr, sizeof(zcvr),
+				      &optval_dynptr, 0, 0);
+		addr = ret >= 0 ? zcvr.address : 0;
+		bpf_sockopt_dynptr_release(ctx, &optval_dynptr);
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
+		ret = bpf_dynptr_from_sockopt(ctx, &optval_dynptr);
+		if (ret >= 0) {
+			bpf_dynptr_write(&optval_dynptr, 0, buf, 1, 0);
+		}
+		bpf_sockopt_dynptr_release(ctx, &optval_dynptr);
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
+	ret = bpf_dynptr_from_sockopt(ctx, &optval_dynptr);
+	if (ret >= 0) {
+		bpf_dynptr_write(&optval_dynptr, 0, buf, 1, 0);
+	}
+	bpf_sockopt_dynptr_release(ctx, &optval_dynptr);
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
@@ -144,6 +280,9 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	struct sockopt_sk *storage;
 	struct bpf_sock *sk;
 
+	if (skip_nonsleepable)
+		return 1;
+
 	/* Bypass AF_NETLINK. */
 	sk = ctx->sk;
 	if (sk && sk->family == AF_NETLINK)
@@ -236,3 +375,118 @@ int _setsockopt(struct bpf_sockopt *ctx)
 		ctx->optlen = 0;
 	return 1;
 }
+
+SEC("cgroup/setsockopt.s")
+int _setsockopt_s(struct bpf_sockopt *ctx)
+{
+	struct bpf_dynptr optval_buf;
+	struct sockopt_sk *storage;
+	__u8 *optval, *optval_end;
+	struct bpf_sock *sk;
+	__u8 tmp_u8;
+	__u32 tmp;
+	int ret;
+
+	if (skip_sleepable)
+		return 1;
+
+	optval = ctx->optval;
+	optval_end = ctx->optval_end;
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
+		ret = bpf_dynptr_from_sockopt(ctx, &optval_buf);
+		if (ret >= 0) {
+			tmp = 0x55AA;
+			bpf_dynptr_write(&optval_buf, 0, &tmp, sizeof(tmp), 0);
+		}
+		bpf_sockopt_dynptr_release(ctx, &optval_buf);
+
+		return ret >= 0 ? 1 : 0;
+	}
+
+	if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION) {
+		/* Always use cubic */
+
+		if (optval + 5 > optval_end)
+			bpf_sockopt_grow_to(ctx, 5);
+		ret = bpf_dynptr_from_sockopt(ctx, &optval_buf);
+		if (ret < 0) {
+			bpf_sockopt_dynptr_release(ctx, &optval_buf);
+			return 0;
+		}
+		bpf_dynptr_write(&optval_buf, 0, "cubic", 5, 0);
+		bpf_sockopt_dynptr_release(ctx, &optval_buf);
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
+		ret = bpf_dynptr_from_sockopt(ctx, &optval_buf);
+		if (ret < 0) {
+			bpf_sockopt_dynptr_release(ctx, &optval_buf);
+			return 0;
+		}
+		tmp_u8 = 0;
+		bpf_dynptr_write(&optval_buf, 0, &tmp_u8, 1, 0);
+		bpf_sockopt_dynptr_release(ctx, &optval_buf);
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
+	bpf_dynptr_from_sockopt(ctx, &optval_buf);
+	ret = bpf_dynptr_read(&storage->val, sizeof(__u8), &optval_buf, 0, 0);
+	if (ret >= 0) {
+		ctx->optlen = -1; /* BPF has consumed this option, don't call
+				   * kernel setsockopt handler.
+				   */
+	}
+	bpf_sockopt_dynptr_release(ctx, &optval_buf);
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


