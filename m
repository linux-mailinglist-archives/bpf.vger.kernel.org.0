Return-Path: <bpf+bounces-3117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D027398B3
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 09:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B661C21023
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 07:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC08134B4;
	Thu, 22 Jun 2023 07:58:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA63963A4
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 07:58:01 +0000 (UTC)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF62D1FF9;
	Thu, 22 Jun 2023 00:57:46 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1b512309d18so36600765ad.3;
        Thu, 22 Jun 2023 00:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687420666; x=1690012666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6ToYPTpAasb+y/gq67kPkqXDGMs0payZTh2X19SsFc=;
        b=QXwa6MCmOZyXRu5vaOocyH8JlQ03ll6PRh7Hy6wqCZ/xHFvS0N8i1w27V8CiXOTO8/
         54v4ISMmlJ3Zdv48eRDYVuJ/7tjcmJn/UhSY652KRbUxmTOf91PksftrC3fPuQ0yF5e+
         6JGenoJTOCdUSUiqGWsxjgHQ/aZfJ5Xf8Gf/fKZpCXvqL36fe/vgZ+a3qxzMiKIlcnMF
         /XLPJ6CVS7+iUtwl0Fs0k/6rxOV2r/cTF+oYnU7bX1xY6QFh91jorQmd6tcWfr8NnNNP
         elU51sRDOF2G3HQNk3dFh0cVkACUQpkgY7QpvCFNgzvHjaRDdO6Pj+NI6z5yP1Q3X6Jd
         pHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687420666; x=1690012666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6ToYPTpAasb+y/gq67kPkqXDGMs0payZTh2X19SsFc=;
        b=c9eBoi5JwQ+CC9z2FiTGM8LhF2IQ3+p5znvsda5txnJfYtNMJpuwxHSpZVV6fvvldq
         HTagx9WC8zC34Vx9ig1WnKHFj9B3RMCSO+XlpM+1xea2LPy7MkJLzEnk4KPUHqxDF08h
         dnltBZ+p27XcG7dinqJ70lMO+bdzdKZEm3yTrOSujBtTnsP73cniIad59vESF5/GyXqM
         xXwzwvQlm+Y5BXz/V52SDhpegLU9aV+2nkLDg4iidrKi5keSe0kJzL2pA7/6yf00ji+s
         5wawx6utAbVc3MVkdHCrCrycjn9T75dhCLiZs4b+k+CxHKrtjB0GDRjV2s5KQngQkz92
         Ynbg==
X-Gm-Message-State: AC+VfDzz5xCK2dFW7k9bqKdGnGRdinTHprWcjikFGFf2W9B/Kz/qiGo9
	X0MdD0vEsjPopBdQf89IUYs=
X-Google-Smtp-Source: ACHHUZ5DPJZmXCJtCRCqrrMSPHIoDSGeYuTfQQjxdHWMLUBVp+XRfTm5Xt+n2FShoCZp6hwMVNt0cA==
X-Received: by 2002:a17:902:e548:b0:1b6:788a:5527 with SMTP id n8-20020a170902e54800b001b6788a5527mr7843207plf.43.1687420666292;
        Thu, 22 Jun 2023 00:57:46 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.82])
        by smtp.gmail.com with ESMTPSA id iz3-20020a170902ef8300b001b3e84240b4sm4733338plb.67.2023.06.22.00.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 00:57:45 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: yhs@meta.com,
	alexei.starovoitov@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	benbjiang@tencent.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v7 3/3] selftests/bpf: add testcase for TRACING with 6+ arguments
Date: Thu, 22 Jun 2023 15:57:15 +0800
Message-Id: <20230622075715.1818144-4-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075715.1818144-1-imagedong@tencent.com>
References: <20230622075715.1818144-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Menglong Dong <imagedong@tencent.com>

Add test9/test10 in fexit_test.c and fentry_test.c to test the fentry
and fexit whose target function have 7/11 arguments.

Correspondingly, add bpf_testmod_fentry_test7() and
bpf_testmod_fentry_test11() to bpf_testmod.c

Meanwhile, add bpf_modify_return_test2() to test_run.c to test the
MODIFY_RETURN with 7 arguments.

Add bpf_testmod_test_struct_arg_7/bpf_testmod_test_struct_arg_7 in
bpf_testmod.c to test the struct in the arguments.

And the testcases passed:

./test_progs -t fexit
Summary: 5/12 PASSED, 0 SKIPPED, 0 FAILED

./test_progs -t fentry
Summary: 3/0 PASSED, 0 SKIPPED, 0 FAILED

./test_progs -t modify_return
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

./test_progs -t tracing_struct
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Menglong Dong <imagedong@tencent.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
v6:
- add testcases to tracing_struct.c instead of fentry_test.c and
  fexit_test.c
v5:
- add testcases for MODIFY_RETURN
v4:
- use different type for args in bpf_testmod_fentry_test{7,12}
- add testcase for grabage values in ctx
v3:
- move bpf_fentry_test{7,12} to bpf_testmod.c and rename them to
  bpf_testmod_fentry_test{7,12} meanwhile
- get return value by bpf_get_func_ret() in
  "fexit/bpf_testmod_fentry_test12", as we don't change ___bpf_ctx_cast()
  in this version
---
 net/bpf/test_run.c                            | 23 ++++++--
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 49 ++++++++++++++++-
 .../selftests/bpf/prog_tests/fentry_fexit.c   |  4 +-
 .../selftests/bpf/prog_tests/fentry_test.c    |  2 +
 .../selftests/bpf/prog_tests/fexit_test.c     |  2 +
 .../selftests/bpf/prog_tests/modify_return.c  | 20 ++++++-
 .../selftests/bpf/prog_tests/tracing_struct.c | 19 +++++++
 .../testing/selftests/bpf/progs/fentry_test.c | 32 +++++++++++
 .../testing/selftests/bpf/progs/fexit_test.c  | 33 ++++++++++++
 .../selftests/bpf/progs/modify_return.c       | 40 ++++++++++++++
 .../selftests/bpf/progs/tracing_struct.c      | 54 +++++++++++++++++++
 11 files changed, 271 insertions(+), 7 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 2321bd2f9964..df58e8bf5e07 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -561,6 +561,13 @@ __bpf_kfunc int bpf_modify_return_test(int a, int *b)
 	return a + *b;
 }
 
+__bpf_kfunc int bpf_modify_return_test2(int a, int *b, short c, int d,
+					void *e, char f, int g)
+{
+	*b += 1;
+	return a + *b + c + d + (long)e + f + g;
+}
+
 int noinline bpf_fentry_shadow_test(int a)
 {
 	return a + 1;
@@ -596,9 +603,13 @@ __diag_pop();
 
 BTF_SET8_START(bpf_test_modify_return_ids)
 BTF_ID_FLAGS(func, bpf_modify_return_test)
+BTF_ID_FLAGS(func, bpf_modify_return_test2)
 BTF_ID_FLAGS(func, bpf_fentry_test1, KF_SLEEPABLE)
 BTF_SET8_END(bpf_test_modify_return_ids)
 
+BTF_ID_LIST(bpf_modify_return_test_id)
+BTF_ID(func, bpf_modify_return_test)
+
 static const struct btf_kfunc_id_set bpf_test_modify_return_set = {
 	.owner = THIS_MODULE,
 	.set   = &bpf_test_modify_return_ids,
@@ -661,9 +672,15 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 			goto out;
 		break;
 	case BPF_MODIFY_RETURN:
-		ret = bpf_modify_return_test(1, &b);
-		if (b != 2)
-			side_effect = 1;
+		if (prog->aux->attach_btf_id == *bpf_modify_return_test_id) {
+			ret = bpf_modify_return_test(1, &b);
+			if (b != 2)
+				side_effect = 1;
+		} else {
+			ret = bpf_modify_return_test2(1, &b, 3, 4, (void *)5, 6, 7);
+			if (b != 2)
+				side_effect = 1;
+		}
 		break;
 	default:
 		goto out;
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index aaf6ef1201c7..a6f991b56345 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -34,6 +34,11 @@ struct bpf_testmod_struct_arg_3 {
 	int b[];
 };
 
+struct bpf_testmod_struct_arg_4 {
+	u64 a;
+	int b;
+};
+
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in bpf_testmod.ko BTF");
@@ -75,6 +80,24 @@ bpf_testmod_test_struct_arg_6(struct bpf_testmod_struct_arg_3 *a) {
 	return bpf_testmod_test_struct_arg_result;
 }
 
+noinline int
+bpf_testmod_test_struct_arg_7(u64 a, void *b, short c, int d, void *e,
+			      struct bpf_testmod_struct_arg_4 f)
+{
+	bpf_testmod_test_struct_arg_result = a + (long)b + c + d +
+		(long)e + f.a + f.b;
+	return bpf_testmod_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_test_struct_arg_8(u64 a, void *b, short c, int d, void *e,
+			      struct bpf_testmod_struct_arg_4 f, int g)
+{
+	bpf_testmod_test_struct_arg_result = a + (long)b + c + d +
+		(long)e + f.a + f.b + g;
+	return bpf_testmod_test_struct_arg_result;
+}
+
 __bpf_kfunc void
 bpf_testmod_test_mod_kfunc(int i)
 {
@@ -191,6 +214,20 @@ noinline int bpf_testmod_fentry_test3(char a, int b, u64 c)
 	return a + b + c;
 }
 
+noinline int bpf_testmod_fentry_test7(u64 a, void *b, short c, int d,
+				      void *e, char f, int g)
+{
+	return a + (long)b + c + d + (long)e + f + g;
+}
+
+noinline int bpf_testmod_fentry_test11(u64 a, void *b, short c, int d,
+				       void *e, char f, int g,
+				       unsigned int h, long i, __u64 j,
+				       unsigned long k)
+{
+	return a + (long)b + c + d + (long)e + f + g + h + i + j + k;
+}
+
 int bpf_testmod_fentry_ok;
 
 noinline ssize_t
@@ -206,6 +243,7 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 	struct bpf_testmod_struct_arg_1 struct_arg1 = {10};
 	struct bpf_testmod_struct_arg_2 struct_arg2 = {2, 3};
 	struct bpf_testmod_struct_arg_3 *struct_arg3;
+	struct bpf_testmod_struct_arg_4 struct_arg4 = {21, 22};
 	int i = 1;
 
 	while (bpf_testmod_return_ptr(i))
@@ -216,6 +254,11 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 	(void)bpf_testmod_test_struct_arg_3(1, 4, struct_arg2);
 	(void)bpf_testmod_test_struct_arg_4(struct_arg1, 1, 2, 3, struct_arg2);
 	(void)bpf_testmod_test_struct_arg_5();
+	(void)bpf_testmod_test_struct_arg_7(16, (void *)17, 18, 19,
+					    (void *)20, struct_arg4);
+	(void)bpf_testmod_test_struct_arg_8(16, (void *)17, 18, 19,
+					    (void *)20, struct_arg4, 23);
+
 
 	struct_arg3 = kmalloc((sizeof(struct bpf_testmod_struct_arg_3) +
 				sizeof(int)), GFP_KERNEL);
@@ -243,7 +286,11 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 
 	if (bpf_testmod_fentry_test1(1) != 2 ||
 	    bpf_testmod_fentry_test2(2, 3) != 5 ||
-	    bpf_testmod_fentry_test3(4, 5, 6) != 15)
+	    bpf_testmod_fentry_test3(4, 5, 6) != 15 ||
+	    bpf_testmod_fentry_test7(16, (void *)17, 18, 19, (void *)20,
+			21, 22) != 133 ||
+	    bpf_testmod_fentry_test11(16, (void *)17, 18, 19, (void *)20,
+			21, 22, 23, 24, 25, 26) != 231)
 		goto out;
 
 	bpf_testmod_fentry_ok = 1;
diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c b/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
index 130f5b82d2e6..0078acee0ede 100644
--- a/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
@@ -31,10 +31,12 @@ void test_fentry_fexit(void)
 	ASSERT_OK(err, "ipv6 test_run");
 	ASSERT_OK(topts.retval, "ipv6 test retval");
 
+	ASSERT_OK(trigger_module_test_read(1), "trigger_read");
+
 	fentry_res = (__u64 *)fentry_skel->bss;
 	fexit_res = (__u64 *)fexit_skel->bss;
 	printf("%lld\n", fentry_skel->bss->test1_result);
-	for (i = 0; i < 8; i++) {
+	for (i = 0; i < 11; i++) {
 		ASSERT_EQ(fentry_res[i], 1, "fentry result");
 		ASSERT_EQ(fexit_res[i], 1, "fexit result");
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_test.c b/tools/testing/selftests/bpf/prog_tests/fentry_test.c
index c0d1d61d5f66..e1c0ce40febf 100644
--- a/tools/testing/selftests/bpf/prog_tests/fentry_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_test.c
@@ -24,6 +24,8 @@ static int fentry_test(struct fentry_test_lskel *fentry_skel)
 	ASSERT_OK(err, "test_run");
 	ASSERT_EQ(topts.retval, 0, "test_run");
 
+	ASSERT_OK(trigger_module_test_read(1), "trigger_read");
+
 	result = (__u64 *)fentry_skel->bss;
 	for (i = 0; i < sizeof(*fentry_skel->bss) / sizeof(__u64); i++) {
 		if (!ASSERT_EQ(result[i], 1, "fentry_result"))
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_test.c b/tools/testing/selftests/bpf/prog_tests/fexit_test.c
index 101b7343036b..ea81fa913ec6 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_test.c
@@ -24,6 +24,8 @@ static int fexit_test(struct fexit_test_lskel *fexit_skel)
 	ASSERT_OK(err, "test_run");
 	ASSERT_EQ(topts.retval, 0, "test_run");
 
+	ASSERT_OK(trigger_module_test_read(1), "trigger_read");
+
 	result = (__u64 *)fexit_skel->bss;
 	for (i = 0; i < sizeof(*fexit_skel->bss) / sizeof(__u64); i++) {
 		if (!ASSERT_EQ(result[i], 1, "fexit_result"))
diff --git a/tools/testing/selftests/bpf/prog_tests/modify_return.c b/tools/testing/selftests/bpf/prog_tests/modify_return.c
index 5d9955af6247..93febb6d81ef 100644
--- a/tools/testing/selftests/bpf/prog_tests/modify_return.c
+++ b/tools/testing/selftests/bpf/prog_tests/modify_return.c
@@ -11,7 +11,8 @@
 #define UPPER(x) ((x) >> 16)
 
 
-static void run_test(__u32 input_retval, __u16 want_side_effect, __s16 want_ret)
+static void run_test(__u32 input_retval, __u16 want_side_effect,
+		     __s16 want_ret, __s16 want_ret2)
 {
 	struct modify_return *skel = NULL;
 	int err, prog_fd;
@@ -41,6 +42,19 @@ static void run_test(__u32 input_retval, __u16 want_side_effect, __s16 want_ret)
 	ASSERT_EQ(skel->bss->fexit_result, 1, "modify_return fexit_result");
 	ASSERT_EQ(skel->bss->fmod_ret_result, 1, "modify_return fmod_ret_result");
 
+	prog_fd = bpf_program__fd(skel->progs.fmod_ret_test2);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+
+	side_effect = UPPER(topts.retval);
+	ret = LOWER(topts.retval);
+
+	ASSERT_EQ(ret, want_ret2, "test_run ret2");
+	ASSERT_EQ(side_effect, want_side_effect, "modify_return side_effect2");
+	ASSERT_EQ(skel->bss->fentry_result2, 1, "modify_return fentry_result2");
+	ASSERT_EQ(skel->bss->fexit_result2, 1, "modify_return fexit_result2");
+	ASSERT_EQ(skel->bss->fmod_ret_result2, 1, "modify_return fmod_ret_result2");
+
 cleanup:
 	modify_return__destroy(skel);
 }
@@ -50,8 +64,10 @@ void serial_test_modify_return(void)
 {
 	run_test(0 /* input_retval */,
 		 1 /* want_side_effect */,
-		 4 /* want_ret */);
+		 4 /* want_ret */,
+		 29 /* want_ret */);
 	run_test(-EINVAL /* input_retval */,
 		 0 /* want_side_effect */,
+		 -EINVAL /* want_ret */,
 		 -EINVAL /* want_ret */);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
index 1c75a32186d6..fe0fb0c9849a 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
@@ -55,6 +55,25 @@ static void test_fentry(void)
 
 	ASSERT_EQ(skel->bss->t6, 1, "t6 ret");
 
+	ASSERT_EQ(skel->bss->t7_a, 16, "t7:a");
+	ASSERT_EQ(skel->bss->t7_b, 17, "t7:b");
+	ASSERT_EQ(skel->bss->t7_c, 18, "t7:c");
+	ASSERT_EQ(skel->bss->t7_d, 19, "t7:d");
+	ASSERT_EQ(skel->bss->t7_e, 20, "t7:e");
+	ASSERT_EQ(skel->bss->t7_f_a, 21, "t7:f.a");
+	ASSERT_EQ(skel->bss->t7_f_b, 22, "t7:f.b");
+	ASSERT_EQ(skel->bss->t7_ret, 133, "t7 ret");
+
+	ASSERT_EQ(skel->bss->t8_a, 16, "t8:a");
+	ASSERT_EQ(skel->bss->t8_b, 17, "t8:b");
+	ASSERT_EQ(skel->bss->t8_c, 18, "t8:c");
+	ASSERT_EQ(skel->bss->t8_d, 19, "t8:d");
+	ASSERT_EQ(skel->bss->t8_e, 20, "t8:e");
+	ASSERT_EQ(skel->bss->t8_f_a, 21, "t8:f.a");
+	ASSERT_EQ(skel->bss->t8_f_b, 22, "t8:f.b");
+	ASSERT_EQ(skel->bss->t8_g, 23, "t8:g");
+	ASSERT_EQ(skel->bss->t8_ret, 156, "t8 ret");
+
 	tracing_struct__detach(skel);
 destroy_skel:
 	tracing_struct__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/fentry_test.c b/tools/testing/selftests/bpf/progs/fentry_test.c
index 52a550d281d9..18a0ea63cf67 100644
--- a/tools/testing/selftests/bpf/progs/fentry_test.c
+++ b/tools/testing/selftests/bpf/progs/fentry_test.c
@@ -77,3 +77,35 @@ int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
 		test8_result = 1;
 	return 0;
 }
+
+__u64 test9_result = 0;
+SEC("fentry/bpf_testmod_fentry_test7")
+int BPF_PROG(test9, __u64 a, void *b, short c, int d, void *e, char f,
+	     int g)
+{
+	test9_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
+		e == (void *)20 && f == 21 && g == 22;
+	return 0;
+}
+
+__u64 test10_result = 0;
+SEC("fentry/bpf_testmod_fentry_test11")
+int BPF_PROG(test10, __u64 a, void *b, short c, int d, void *e, char f,
+	     int g, unsigned int h, long i, __u64 j, unsigned long k)
+{
+	test10_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
+		e == (void *)20 && f == 21 && g == 22 && h == 23 &&
+		i == 24 && j == 25 && k == 26;
+	return 0;
+}
+
+__u64 test11_result = 0;
+SEC("fentry/bpf_testmod_fentry_test11")
+int BPF_PROG(test11, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f,
+	     __u64 g, __u64 h, __u64 i, __u64 j, __u64 k)
+{
+	test11_result = a == 16 && b == 17 && c == 18 && d == 19 &&
+		e == 20 && f == 21 && g == 22 && h == 23 &&
+		i == 24 && j == 25 && k == 26;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/fexit_test.c b/tools/testing/selftests/bpf/progs/fexit_test.c
index 8f1ccb7302e1..b2126fb781a1 100644
--- a/tools/testing/selftests/bpf/progs/fexit_test.c
+++ b/tools/testing/selftests/bpf/progs/fexit_test.c
@@ -78,3 +78,36 @@ int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
 		test8_result = 1;
 	return 0;
 }
+
+__u64 test9_result = 0;
+SEC("fexit/bpf_testmod_fentry_test7")
+int BPF_PROG(test9, __u64 a, void *b, short c, int d, void *e, char f,
+	     int g, int ret)
+{
+	test9_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
+		e == (void *)20 && f == 21 && g == 22 && ret == 133;
+	return 0;
+}
+
+__u64 test10_result = 0;
+SEC("fexit/bpf_testmod_fentry_test11")
+int BPF_PROG(test10, __u64 a, void *b, short c, int d, void *e, char f,
+	     int g, unsigned int h, long i, __u64 j, unsigned long k,
+	     int ret)
+{
+	test10_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
+		e == (void *)20 && f == 21 && g == 22 && h == 23 &&
+		i == 24 && j == 25 && k == 26 && ret == 231;
+	return 0;
+}
+
+__u64 test11_result = 0;
+SEC("fexit/bpf_testmod_fentry_test11")
+int BPF_PROG(test11, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f,
+	     __u64 g, __u64 h, __u64 i, __u64 j, __u64 k, __u64 ret)
+{
+	test11_result = a == 16 && b == 17 && c == 18 && d == 19 &&
+		e == 20 && f == 21 && g == 22 && h == 23 &&
+		i == 24 && j == 25 && k == 26 && ret == 231;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/modify_return.c b/tools/testing/selftests/bpf/progs/modify_return.c
index 8b7466a15c6b..3376d4849f58 100644
--- a/tools/testing/selftests/bpf/progs/modify_return.c
+++ b/tools/testing/selftests/bpf/progs/modify_return.c
@@ -47,3 +47,43 @@ int BPF_PROG(fexit_test, int a, __u64 b, int ret)
 
 	return 0;
 }
+
+static int sequence2;
+
+__u64 fentry_result2 = 0;
+SEC("fentry/bpf_modify_return_test2")
+int BPF_PROG(fentry_test2, int a, int *b, short c, int d, void *e, char f,
+	     int g)
+{
+	sequence2++;
+	fentry_result2 = (sequence2 == 1);
+	return 0;
+}
+
+__u64 fmod_ret_result2 = 0;
+SEC("fmod_ret/bpf_modify_return_test2")
+int BPF_PROG(fmod_ret_test2, int a, int *b, short c, int d, void *e, char f,
+	     int g, int ret)
+{
+	sequence2++;
+	/* This is the first fmod_ret program, the ret passed should be 0 */
+	fmod_ret_result2 = (sequence2 == 2 && ret == 0);
+	return input_retval;
+}
+
+__u64 fexit_result2 = 0;
+SEC("fexit/bpf_modify_return_test2")
+int BPF_PROG(fexit_test2, int a, int *b, short c, int d, void *e, char f,
+	     int g, int ret)
+{
+	sequence2++;
+	/* If the input_reval is non-zero a successful modification should have
+	 * occurred.
+	 */
+	if (input_retval)
+		fexit_result2 = (sequence2 == 3 && ret == input_retval);
+	else
+		fexit_result2 = (sequence2 == 3 && ret == 29);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct.c b/tools/testing/selftests/bpf/progs/tracing_struct.c
index c435a3a8328a..515daef3c84b 100644
--- a/tools/testing/selftests/bpf/progs/tracing_struct.c
+++ b/tools/testing/selftests/bpf/progs/tracing_struct.c
@@ -18,6 +18,11 @@ struct bpf_testmod_struct_arg_3 {
 	int b[];
 };
 
+struct bpf_testmod_struct_arg_4 {
+	u64 a;
+	int b;
+};
+
 long t1_a_a, t1_a_b, t1_b, t1_c, t1_ret, t1_nregs;
 __u64 t1_reg0, t1_reg1, t1_reg2, t1_reg3;
 long t2_a, t2_b_a, t2_b_b, t2_c, t2_ret;
@@ -25,6 +30,9 @@ long t3_a, t3_b, t3_c_a, t3_c_b, t3_ret;
 long t4_a_a, t4_b, t4_c, t4_d, t4_e_a, t4_e_b, t4_ret;
 long t5_ret;
 int t6;
+long t7_a, t7_b, t7_c, t7_d, t7_e, t7_f_a, t7_f_b, t7_ret;
+long t8_a, t8_b, t8_c, t8_d, t8_e, t8_f_a, t8_f_b, t8_g, t8_ret;
+
 
 SEC("fentry/bpf_testmod_test_struct_arg_1")
 int BPF_PROG2(test_struct_arg_1, struct bpf_testmod_struct_arg_2, a, int, b, int, c)
@@ -130,4 +138,50 @@ int BPF_PROG2(test_struct_arg_11, struct bpf_testmod_struct_arg_3 *, a)
 	return 0;
 }
 
+SEC("fentry/bpf_testmod_test_struct_arg_7")
+int BPF_PROG2(test_struct_arg_12, __u64, a, void *, b, short, c, int, d,
+	      void *, e, struct bpf_testmod_struct_arg_4, f)
+{
+	t7_a = a;
+	t7_b = (long)b;
+	t7_c = c;
+	t7_d = d;
+	t7_e = (long)e;
+	t7_f_a = f.a;
+	t7_f_b = f.b;
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_test_struct_arg_7")
+int BPF_PROG2(test_struct_arg_13, __u64, a, void *, b, short, c, int, d,
+	      void *, e, struct bpf_testmod_struct_arg_4, f, int, ret)
+{
+	t7_ret = ret;
+	return 0;
+}
+
+SEC("fentry/bpf_testmod_test_struct_arg_8")
+int BPF_PROG2(test_struct_arg_14, __u64, a, void *, b, short, c, int, d,
+	      void *, e, struct bpf_testmod_struct_arg_4, f, int, g)
+{
+	t8_a = a;
+	t8_b = (long)b;
+	t8_c = c;
+	t8_d = d;
+	t8_e = (long)e;
+	t8_f_a = f.a;
+	t8_f_b = f.b;
+	t8_g = g;
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_test_struct_arg_8")
+int BPF_PROG2(test_struct_arg_15, __u64, a, void *, b, short, c, int, d,
+	      void *, e, struct bpf_testmod_struct_arg_4, f, int, g,
+	      int, ret)
+{
+	t8_ret = ret;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.40.1


