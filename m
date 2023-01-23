Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E03678BF6
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 00:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjAWXWo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 18:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjAWXWn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 18:22:43 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D29338647;
        Mon, 23 Jan 2023 15:22:41 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id m26so2045075qtp.9;
        Mon, 23 Jan 2023 15:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XmmT9Nohm3bkrZY1xyNULiy3EwUIG1ep2ItPBLBkAw=;
        b=7OBFj2kKlYp6egM4Q6DpauYoYIlA8Lec+eZTczCpfMCduLzLmKYpAARd4Kp8m39IlO
         6kpHqcwD+THouhX/bxqSgxZfpLgVs5yUOBoriLuHfhD8p6WR15upL5DxdyhDaabGo7WW
         qs2EjCLWmBHypwjgsKG1x3ULA2bnMMQDQFqH6ThOrNlqfR6aeHDeDagp62TT7vcuZH47
         2dgzcHkIwVgNcZQmK65jvkKur030SuvbNwwY9Q7bvIQ8iFg5PabDbfLgEiwyrvHAaP27
         9Roxg2tUQE7AFMAT9G3jE4WV7un2kQuE5NCcYmEPVNCZyIz2WNbnldHKC9hqweDbROiv
         +/kA==
X-Gm-Message-State: AFqh2kr1LnuzmaLShK7XgmC9wRLJ7+lJ3IuXQy3Pm+sMRwc/Xo4LcA0C
        eKxkmJapz3FWJ7CqyNJC911Y/skNcWnm+32I
X-Google-Smtp-Source: AMrXdXsbghVVtRNekk3+0al5dkhYsM2BV6Hditibc79gwUVqktU9DNDEbu/wHiu7sonJAjKS+2GHAQ==
X-Received: by 2002:ac8:46c4:0:b0:3b6:980e:87e7 with SMTP id h4-20020ac846c4000000b003b6980e87e7mr20935182qto.24.1674516160063;
        Mon, 23 Jan 2023 15:22:40 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id z10-20020ac8430a000000b003b6325dfc4esm158936qtm.67.2023.01.23.15.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 15:22:39 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next 3/3] bpf/selftests: Verify struct_ops prog sleepable behavior
Date:   Mon, 23 Jan 2023 17:22:28 -0600
Message-Id: <20230123232228.646563-4-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123232228.646563-1-void@manifault.com>
References: <20230123232228.646563-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In a set of prior changes, we added the ability for struct_ops programs
to be sleepable. This patch enhances the dummy_st_ops selftest suite to
validate this behavior by adding a new struct_ops entry to dummy_st_ops
which calls a KF_SLEEPABLE kfunc.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/bpf.h                           |  1 +
 net/bpf/bpf_dummy_struct_ops.c                | 18 ++++
 net/bpf/test_run.c                            |  6 ++
 .../selftests/bpf/prog_tests/dummy_st_ops.c   | 85 +++++++++++++++++--
 .../selftests/bpf/progs/dummy_st_ops.c        | 11 +++
 5 files changed, 113 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b30739634947..34b90bda3eed 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1473,6 +1473,7 @@ struct bpf_dummy_ops {
 	int (*test_1)(struct bpf_dummy_ops_state *cb);
 	int (*test_2)(struct bpf_dummy_ops_state *cb, int a1, unsigned short a2,
 		      char a3, unsigned long a4);
+	int (*test_3)(struct bpf_dummy_ops_state *cb);
 };
 
 int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 1ac4467928a9..46099737d1da 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -154,6 +154,23 @@ static bool bpf_dummy_ops_is_valid_access(int off, int size,
 	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
 }
 
+static int bpf_dummy_ops_check_member(const struct btf_type *t,
+				      const struct btf_member *member,
+				      const struct bpf_prog *prog)
+{
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct bpf_dummy_ops, test_3):
+		break;
+	default:
+		if (prog->aux->sleepable)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int bpf_dummy_ops_btf_struct_access(struct bpf_verifier_log *log,
 					   const struct bpf_reg_state *reg,
 					   int off, int size, enum bpf_access_type atype,
@@ -208,6 +225,7 @@ static void bpf_dummy_unreg(void *kdata)
 struct bpf_struct_ops bpf_bpf_dummy_ops = {
 	.verifier_ops = &bpf_dummy_verifier_ops,
 	.init = bpf_dummy_init,
+	.check_member = bpf_dummy_ops_check_member,
 	.init_member = bpf_dummy_init_member,
 	.reg = bpf_dummy_reg,
 	.unreg = bpf_dummy_unreg,
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 2723623429ac..cce1be49a3b7 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -730,6 +730,10 @@ noinline void bpf_kfunc_call_test_destructive(void)
 {
 }
 
+noinline void bpf_kfunc_call_test_sleepable(void)
+{
+}
+
 __diag_pop();
 
 BTF_SET8_START(bpf_test_modify_return_ids)
@@ -767,6 +771,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_sleepable, KF_SLEEPABLE)
 BTF_SET8_END(test_sk_check_kfunc_ids)
 
 static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
@@ -1677,6 +1682,7 @@ static int __init bpf_prog_test_run_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_prog_test_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_prog_test_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_prog_test_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_prog_test_kfunc_set);
 	return ret ?: register_btf_id_dtor_kfuncs(bpf_prog_test_dtor_kfunc,
 						  ARRAY_SIZE(bpf_prog_test_dtor_kfunc),
 						  THIS_MODULE);
diff --git a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
index c11832657d2b..fd496ef8f905 100644
--- a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
+++ b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
@@ -9,13 +9,37 @@ struct bpf_dummy_ops_state {
 	int val;
 };
 
+static struct dummy_st_ops *open_load_skel(void)
+{
+	int err;
+	struct dummy_st_ops *skel;
+
+	skel = dummy_st_ops__open();
+	if (!ASSERT_OK_PTR(skel, "dummy_st_ops_open"))
+		return NULL;
+
+	err = bpf_program__set_flags(skel->progs.test_3, BPF_F_SLEEPABLE);
+	if (!ASSERT_OK(err, "set_sleepable")) {
+		dummy_st_ops__destroy(skel);
+		return NULL;
+	}
+
+	err = dummy_st_ops__load(skel);
+	if (!ASSERT_OK(err, "dummy_st_ops_load")) {
+		dummy_st_ops__destroy(skel);
+		return NULL;
+	}
+
+	return skel;
+}
+
 static void test_dummy_st_ops_attach(void)
 {
 	struct dummy_st_ops *skel;
 	struct bpf_link *link;
 
-	skel = dummy_st_ops__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "dummy_st_ops_load"))
+	skel = open_load_skel();
+	if (!skel)
 		return;
 
 	link = bpf_map__attach_struct_ops(skel->maps.dummy_1);
@@ -34,8 +58,8 @@ static void test_dummy_init_ret_value(void)
 	struct dummy_st_ops *skel;
 	int fd, err;
 
-	skel = dummy_st_ops__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "dummy_st_ops_load"))
+	skel = open_load_skel();
+	if (!skel)
 		return;
 
 	fd = bpf_program__fd(skel->progs.test_1);
@@ -61,8 +85,8 @@ static void test_dummy_init_ptr_arg(void)
 	struct dummy_st_ops *skel;
 	int fd, err;
 
-	skel = dummy_st_ops__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "dummy_st_ops_load"))
+	skel = open_load_skel();
+	if (!skel)
 		return;
 
 	fd = bpf_program__fd(skel->progs.test_1);
@@ -107,8 +131,8 @@ static void test_dummy_multiple_args(void)
 	size_t i;
 	char name[8];
 
-	skel = dummy_st_ops__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "dummy_st_ops_load"))
+	skel = open_load_skel();
+	if (!skel)
 		return;
 
 	fd = bpf_program__fd(skel->progs.test_2);
@@ -122,6 +146,47 @@ static void test_dummy_multiple_args(void)
 	dummy_st_ops__destroy(skel);
 }
 
+static void test_dummy_sleepable(void)
+{
+	__u64 args[1] = {0};
+	LIBBPF_OPTS(bpf_test_run_opts, attr,
+		.ctx_in = args,
+		.ctx_size_in = sizeof(args),
+	);
+	struct dummy_st_ops *skel;
+	int fd, err;
+
+	skel = open_load_skel();
+	if (!skel)
+		return;
+
+	fd = bpf_program__fd(skel->progs.test_3);
+	err = bpf_prog_test_run_opts(fd, &attr);
+	ASSERT_OK(err, "test_run");
+
+	dummy_st_ops__destroy(skel);
+}
+
+static void test_dummy_sleepable_disallowed(void)
+{
+	struct dummy_st_ops *skel;
+	int err;
+
+	skel = dummy_st_ops__open();
+	if (!ASSERT_OK_PTR(skel, "dummy_st_ops_open"))
+		goto out;
+
+	err = bpf_program__set_flags(skel->progs.test_1, BPF_F_SLEEPABLE);
+	if (!ASSERT_OK(err, "set_sleepable"))
+		goto out;
+
+	err = dummy_st_ops__load(skel);
+	ASSERT_ERR(err, "dummy_st_ops_load");
+
+out:
+	dummy_st_ops__destroy(skel);
+}
+
 void test_dummy_st_ops(void)
 {
 	if (test__start_subtest("dummy_st_ops_attach"))
@@ -132,4 +197,8 @@ void test_dummy_st_ops(void)
 		test_dummy_init_ptr_arg();
 	if (test__start_subtest("dummy_multiple_args"))
 		test_dummy_multiple_args();
+	if (test__start_subtest("dummy_sleepable"))
+		test_dummy_sleepable();
+	if (test__start_subtest("dummy_not_sleepable"))
+		test_dummy_sleepable_disallowed();
 }
diff --git a/tools/testing/selftests/bpf/progs/dummy_st_ops.c b/tools/testing/selftests/bpf/progs/dummy_st_ops.c
index ead87edb75e2..721886867efb 100644
--- a/tools/testing/selftests/bpf/progs/dummy_st_ops.c
+++ b/tools/testing/selftests/bpf/progs/dummy_st_ops.c
@@ -12,10 +12,13 @@ struct bpf_dummy_ops {
 	int (*test_1)(struct bpf_dummy_ops_state *state);
 	int (*test_2)(struct bpf_dummy_ops_state *state, int a1, unsigned short a2,
 		      char a3, unsigned long a4);
+	int (*test_3)(struct bpf_dummy_ops_state *state);
 };
 
 char _license[] SEC("license") = "GPL";
 
+void bpf_kfunc_call_test_sleepable(void) __ksym;
+
 SEC("struct_ops/test_1")
 int BPF_PROG(test_1, struct bpf_dummy_ops_state *state)
 {
@@ -43,8 +46,16 @@ int BPF_PROG(test_2, struct bpf_dummy_ops_state *state, int a1, unsigned short a
 	return 0;
 }
 
+SEC("struct_ops/test_3")
+int BPF_PROG(test_3, struct bpf_dummy_ops_state *state)
+{
+	bpf_kfunc_call_test_sleepable();
+	return 0;
+}
+
 SEC(".struct_ops")
 struct bpf_dummy_ops dummy_1 = {
 	.test_1 = (void *)test_1,
 	.test_2 = (void *)test_2,
+	.test_3 = (void *)test_3,
 };
-- 
2.39.0

