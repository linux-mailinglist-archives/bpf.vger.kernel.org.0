Return-Path: <bpf+bounces-7836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9490F77D150
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 19:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498182814F9
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 17:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BB717FFE;
	Tue, 15 Aug 2023 17:47:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B3113AFD
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 17:47:40 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060E61BDB
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 10:47:38 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-583d702129cso62060937b3.3
        for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 10:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692121656; x=1692726456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOqmEllem/jPeBzpq8fEl4V95lhjC3iSrE+tn6lSaq0=;
        b=WvDnAcCJm20xYQRzAfAa3rEpZ2EDbdSWa2V7DksaUUTLEfvLJ2Chiuo7C555yKx1HH
         50RTOXFxAv14Rj1euie5r8EinTQFwMgfI9AC12A/MJgDKypK0ybohndJLl6ZrLQRA5qt
         tVxpiMXTi4B9+017soFfzOuZm4LH0yqFjG43+fpaAwXDLw5TWFvd/dshoLAmepzFRlAA
         KBhVYXacSe32LPbpHmrOzR5nM/aTf6BTJct/Gmw5gHzMLkOAjKDnNSwfwBLtmeR8kopO
         dKy7g3H4zGX/4l8X/Kp/9JfKsrsO6lwB0LigZJrAHoS/XKg/ziq6YLtmElZxyP1wBKYp
         tKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692121656; x=1692726456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOqmEllem/jPeBzpq8fEl4V95lhjC3iSrE+tn6lSaq0=;
        b=kmVZuSxPfX87nPjB0ce9vo//HaqOT24mkOUHgr7LQRABddz0PRHoM9z75HSZancPWD
         IXPJf+SNfGq5ff0mmnS8lbOZah70//BGNhpvMFZ/onXmn1jzVnfxFHtCw8XivHRzefYY
         c+fQyhUqgy30jlBchCd9Mxjr6oKt6ChM8fbnktYr/+ufCX33gme4+Q1svG3yb8diKH5T
         ZAUFKuFscqe2CENldWOfy9+QxTN3AJYdhmdFGPhsQJjWZXH7uj6sw6MLTvVnV/90zEWr
         h4KGs66kJcRuzV83rrINryCMbSKp448LoxME0L3NvPg9zXQy4rzdkRjelwyrGsQtgQgm
         RlKg==
X-Gm-Message-State: AOJu0YymZ4Ap8HWACcIbMQpRS8pCJUOnVD0Y2YOczqFTyVr+k5Ty9RJ8
	vEEaDsGQuiaqye3js/2Y4MlvlRPOcfDnkg==
X-Google-Smtp-Source: AGHT+IGbO0ysPOdNX0TwbMRRNmVT/IrLnuPhCvy0JAp/vu8z2xNK2Nq3M31ziOt7CY4rVWTaj+R+TA==
X-Received: by 2002:a0d:edc6:0:b0:56d:3b91:7e76 with SMTP id w189-20020a0dedc6000000b0056d3b917e76mr13678510ywe.12.1692121656369;
        Tue, 15 Aug 2023 10:47:36 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:84ee:9e38:88fa:8a7b])
        by smtp.gmail.com with ESMTPSA id o128-20020a0dcc86000000b00577139f85dfsm3509404ywd.22.2023.08.15.10.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 10:47:35 -0700 (PDT)
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
Subject: [RFC bpf-next v3 5/5] selftests/bpf: Add test cases for sleepable BPF programs of the CGROUP_SOCKOPT type
Date: Tue, 15 Aug 2023 10:47:12 -0700
Message-Id: <20230815174712.660956-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815174712.660956-1-thinker.li@gmail.com>
References: <20230815174712.660956-1-thinker.li@gmail.com>
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

From: Kui-Feng Lee <thinker.li@gmail.com>

Do the same test as non-sleepable ones.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  36 +++
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  41 +++
 .../selftests/bpf/prog_tests/sockopt_sk.c     | 112 +++++++-
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 257 ++++++++++++++++++
 .../selftests/bpf/verifier/sleepable.c        |   2 +-
 5 files changed, 445 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 209811b1993a..9b5dfefe65dc 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -131,4 +131,40 @@ extern int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *nod
  */
 extern struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root) __ksym;
 
+/*
+ *     Description
+ *             Copy data from *ptr* to *sopt->optval*.
+ *     Return
+ *             >= 0 on success, or a negative error in case of failure.
+ */
+extern int bpf_sockopt_dynptr_copy_to(struct bpf_sockopt *sopt,
+				      struct bpf_dynptr *ptr) __ksym;
+
+/* Description
+ *	Allocate a buffer of 'size' bytes for being installed as optval.
+ * Returns
+ *	> 0 on success, the size of the allocated buffer
+ *	-ENOMEM or -EINVAL on failure
+ */
+extern int bpf_sockopt_dynptr_alloc(struct bpf_sockopt *sopt, int size,
+				    struct bpf_dynptr *ptr__uninit) __ksym;
+
+/* Description
+ *	Install the buffer pointed to by 'ptr' as optval.
+ * Returns
+ *	0 on success
+ *	-EINVAL if the buffer is too small
+ */
+extern int bpf_sockopt_dynptr_install(struct bpf_sockopt *sopt,
+				      struct bpf_dynptr *ptr) __ksym;
+
+/* Description
+ *	Release the buffer allocated by bpf_sockopt_dynptr_alloc.
+ * Returns
+ *	0 on success
+ *	-EINVAL if the buffer was not allocated by bpf_sockopt_dynptr_alloc
+ */
+extern int bpf_sockopt_dynptr_release(struct bpf_sockopt *sopt,
+				      struct bpf_dynptr *ptr) __ksym;
+
 #endif
diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 642dda0e758a..772040225257 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -41,4 +41,45 @@ extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym;
 extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym;
 extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dynptr *clone__init) __ksym;
 
+extern int bpf_sockopt_dynptr_copy_to(struct bpf_sockopt *sopt,
+				      struct bpf_dynptr *ptr) __ksym;
+
+/* Description
+ *	Allocate a buffer of 'size' bytes for being installed as optval.
+ * Returns
+ *	> 0 on success, the size of the allocated buffer
+ *	-ENOMEM or -EINVAL on failure
+ */
+extern int bpf_sockopt_dynptr_alloc(struct bpf_sockopt *sopt, int size,
+				    struct bpf_dynptr *ptr__uninit) __ksym;
+
+/* Description
+ *	Install the buffer pointed to by 'ptr' as optval.
+ * Returns
+ *	0 on success
+ *	-EINVAL if the buffer is too small
+ */
+extern int bpf_sockopt_dynptr_install(struct bpf_sockopt *sopt,
+				      struct bpf_dynptr *ptr) __ksym;
+
+/* Description
+ *	Release the buffer allocated by bpf_sockopt_dynptr_alloc.
+ * Returns
+ *	0 on success
+ *	-EINVAL if the buffer was not allocated by bpf_sockopt_dynptr_alloc
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
+extern int bpf_sockopt_dynptr_from(struct bpf_sockopt *sopt,
+				   struct bpf_dynptr *ptr__uninit,
+				   unsigned int size) __ksym;
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
index cb990a7d3d45..efacd3b88c40 100644
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
@@ -136,6 +145,134 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	return 1;
 }
 
+SEC("cgroup/getsockopt.s")
+int _getsockopt_s(struct bpf_sockopt *ctx)
+{
+	struct tcp_zerocopy_receive *zcvr;
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
+		bpf_sockopt_dynptr_from(ctx, &optval_dynptr, sizeof(*zcvr));
+		zcvr = bpf_dynptr_data(&optval_dynptr, 0, sizeof(*zcvr));
+		addr = zcvr ? zcvr->address : 0;
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
+		ret = bpf_sockopt_dynptr_alloc(ctx, 1, &optval_dynptr);
+		if (ret >= 0) {
+			bpf_dynptr_write(&optval_dynptr, 0, buf, 1, 0);
+			ret = bpf_sockopt_dynptr_copy_to(ctx, &optval_dynptr);
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
+	ret = bpf_sockopt_dynptr_alloc(ctx, 1, &optval_dynptr);
+	if (ret >= 0) {
+		bpf_dynptr_write(&optval_dynptr, 0, buf, 1, 0);
+		ret = bpf_sockopt_dynptr_copy_to(ctx, &optval_dynptr);
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
@@ -144,6 +281,9 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	struct sockopt_sk *storage;
 	struct bpf_sock *sk;
 
+	if (skip_nonsleepable)
+		return 1;
+
 	/* Bypass AF_NETLINK. */
 	sk = ctx->sk;
 	if (sk && sk->family == AF_NETLINK)
@@ -236,3 +376,120 @@ int _setsockopt(struct bpf_sockopt *ctx)
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
+		ret = bpf_sockopt_dynptr_alloc(ctx, sizeof(__u32),
+					       &optval_buf);
+		if (ret < 0)
+			bpf_sockopt_dynptr_release(ctx, &optval_buf);
+		else {
+			tmp = 0x55AA;
+			bpf_dynptr_write(&optval_buf, 0, &tmp, sizeof(tmp), 0);
+			ret = bpf_sockopt_dynptr_install(ctx, &optval_buf);
+		}
+
+		return ret >= 0 ? 1 : 0;
+	}
+
+	if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION) {
+		/* Always use cubic */
+
+		ret = bpf_sockopt_dynptr_alloc(ctx, 5, &optval_buf);
+		if (ret < 0) {
+			bpf_sockopt_dynptr_release(ctx, &optval_buf);
+			return 0;
+		}
+		bpf_dynptr_write(&optval_buf, 0, "cubic", 5, 0);
+		ret = bpf_sockopt_dynptr_install(ctx, &optval_buf);
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
+		ret = bpf_sockopt_dynptr_alloc(ctx, 1, &optval_buf);
+		if (ret < 0) {
+			bpf_sockopt_dynptr_release(ctx, &optval_buf);
+			return 0;
+		}
+		tmp_u8 = 0;
+		bpf_dynptr_write(&optval_buf, 0, &tmp_u8, 1, 0);
+		ret = bpf_sockopt_dynptr_install(ctx, &optval_buf);
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
+	bpf_sockopt_dynptr_from(ctx, &optval_buf, sizeof(__u8));
+	optval = bpf_dynptr_data(&optval_buf, 0, sizeof(__u8));
+	if (optval) {
+		storage->val = *optval;
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


