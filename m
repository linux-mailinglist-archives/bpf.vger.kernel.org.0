Return-Path: <bpf+bounces-4916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6A9751730
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 06:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2961C2126E
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70321525F;
	Thu, 13 Jul 2023 04:09:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB7B525B
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 04:09:06 +0000 (UTC)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EAD26A0;
	Wed, 12 Jul 2023 21:08:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-666e64e97e2so148120b3a.1;
        Wed, 12 Jul 2023 21:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689221338; x=1691813338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OjOaQ4N2P1vOa7SIPcBYDDT70Jy/LwX1Sa9/h9lE1M=;
        b=DByfjyMzbLvFACAqCFdz4yPgGGC41UVSt4B4Vp9J5Bqmm0HmJ1o8Un6PZpVFHUPEbq
         Demf+dNImhsAwR/dg3V50ilhTMItkFmQonEr2UvtUa40x2esyVU8wxj7Ewj3BtNsPFvH
         TFdZHwp1vgQED638QnHw2jwMD+RLxXKrdbXd0x5Gg+EI0R3QgrUAnD+hLom0pTfhZOlz
         RvOIwuaXr+gYjgZus3wEXrpWOCpm9iUI73yzBGf1NVK7V+TfAsSizcw7p7bE84B03Phe
         yMfmK9JJNzjja3NZ3uyngf+TQ6eQ28LCha6VT+4XtGMMO6m0gj6Ki/RS5aRB2ta0xDct
         E33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689221338; x=1691813338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OjOaQ4N2P1vOa7SIPcBYDDT70Jy/LwX1Sa9/h9lE1M=;
        b=FpbzGv28RycW686gS2jp9kNtJ0Km7eCr9xtYJ1WAe7EMf+9hwJjnKJATQeJQwPsIM5
         fTWTjxd4PNE0tyonacvvgadE0FX5j2M7i03ok7JtaudnYyPrXC3t8aaxfaYRVASrKncx
         HaDvCiA0WSvLWLFlem1pv2MLsKmINmG8xE0rvddbaIhvFzUBcKkSywRyHrnM6bjROm8H
         gKSoNMybwcsv/UQVXaVTX3eJMhMzrh3p/lLcLHBlqKJ5HEVwlXbsNGc0RxBsW/2Z0Mma
         ZU6Jo/9ymzcgldqS9QfNJRCvAS7pLlBdE/s+7c1DRwN74rxd7+QVYanu/aZ0TpDyhpGj
         WYxA==
X-Gm-Message-State: ABy/qLZHEXUtYxfp7XJsNHi6GWNn1l67HljTOm5BWXP/UxWvpTSzP4wF
	7LI4BxKMrc6lz7JlntVvGfY=
X-Google-Smtp-Source: APBJJlHihuchurNq88rkHmbj8Xz19WdFlUg2XrVsIOngIK187DuDJhQGM3y1Las1+bT43Usq9Nvlpg==
X-Received: by 2002:a05:6a20:160a:b0:130:1563:7502 with SMTP id l10-20020a056a20160a00b0013015637502mr99467pzj.7.1689221338134;
        Wed, 12 Jul 2023 21:08:58 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.100])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902d48700b001bb04755212sm483217plg.228.2023.07.12.21.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:08:57 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: yhs@meta.com,
	daniel@iogearbox.net,
	alexei.starovoitov@gmail.com
Cc: ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	dsahern@kernel.org,
	jolsa@kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v10 3/3] selftests/bpf: add testcase for TRACING with 6+ arguments
Date: Thu, 13 Jul 2023 12:07:38 +0800
Message-Id: <20230713040738.1789742-4-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713040738.1789742-1-imagedong@tencent.com>
References: <20230713040738.1789742-1-imagedong@tencent.com>
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

Add fentry_many_args.c and fexit_many_args.c to test the fentry/fexit
with 7/11 arguments. As this feature is not supported by arm64 yet, we
disable these testcases for arm64 in DENYLIST.aarch64. We can combine
them with fentry_test.c/fexit_test.c when arm64 is supported too.

Correspondingly, add bpf_testmod_fentry_test7() and
bpf_testmod_fentry_test11() to bpf_testmod.c

Meanwhile, add bpf_modify_return_test2() to test_run.c to test the
MODIFY_RETURN with 7 arguments.

Add bpf_testmod_test_struct_arg_7/bpf_testmod_test_struct_arg_7 in
bpf_testmod.c to test the struct in the arguments.

And the testcases passed on x86_64:

./test_progs -t fexit
Summary: 5/14 PASSED, 0 SKIPPED, 0 FAILED

./test_progs -t fentry
Summary: 3/2 PASSED, 0 SKIPPED, 0 FAILED

./test_progs -t modify_return
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

./test_progs -t tracing_struct
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Menglong Dong <imagedong@tencent.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
v10:
- fix the failed test cases of trampoline_count and get_func_args_test
v9:
- change the way to test fmod_ret
v8:
- split the testcases, and add fentry_many_args/fexit_many_args to
  DENYLIST.aarch64
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
 net/bpf/test_run.c                            | 14 ++++-
 tools/testing/selftests/bpf/DENYLIST.aarch64  |  2 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 49 ++++++++++++++++-
 .../selftests/bpf/prog_tests/fentry_test.c    | 43 +++++++++++++--
 .../selftests/bpf/prog_tests/fexit_test.c     | 43 +++++++++++++--
 .../bpf/prog_tests/get_func_args_test.c       |  4 +-
 .../selftests/bpf/prog_tests/modify_return.c  | 10 ++--
 .../selftests/bpf/prog_tests/tracing_struct.c | 19 +++++++
 .../bpf/prog_tests/trampoline_count.c         |  4 +-
 .../selftests/bpf/progs/fentry_many_args.c    | 39 ++++++++++++++
 .../selftests/bpf/progs/fexit_many_args.c     | 40 ++++++++++++++
 .../selftests/bpf/progs/modify_return.c       | 40 ++++++++++++++
 .../selftests/bpf/progs/tracing_struct.c      | 54 +++++++++++++++++++
 13 files changed, 345 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_many_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/fexit_many_args.c

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 63b11f7a5392..7d47f53f20c1 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -565,6 +565,13 @@ __bpf_kfunc int bpf_modify_return_test(int a, int *b)
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
@@ -600,6 +607,7 @@ __diag_pop();
 
 BTF_SET8_START(bpf_test_modify_return_ids)
 BTF_ID_FLAGS(func, bpf_modify_return_test)
+BTF_ID_FLAGS(func, bpf_modify_return_test2)
 BTF_ID_FLAGS(func, bpf_fentry_test1, KF_SLEEPABLE)
 BTF_SET8_END(bpf_test_modify_return_ids)
 
@@ -667,7 +675,11 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 	case BPF_MODIFY_RETURN:
 		ret = bpf_modify_return_test(1, &b);
 		if (b != 2)
-			side_effect = 1;
+			side_effect++;
+		b = 2;
+		ret += bpf_modify_return_test2(1, &b, 3, 4, (void *)5, 6, 7);
+		if (b != 2)
+			side_effect++;
 		break;
 	default:
 		goto out;
diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 08adc805878b..3b61e8b35d62 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -10,3 +10,5 @@ kprobe_multi_test/link_api_addrs                 # link_fd unexpected link_fd: a
 kprobe_multi_test/link_api_syms                  # link_fd unexpected link_fd: actual -95 < expected 0
 kprobe_multi_test/skel_api                       # libbpf: failed to load BPF skeleton 'kprobe_multi': -3
 module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
+fentry_test/fentry_many_args                     # fentry_many_args:FAIL:fentry_many_args_attach unexpected error: -524
+fexit_test/fexit_many_args                       # fexit_many_args:FAIL:fexit_many_args_attach unexpected error: -524
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
diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_test.c b/tools/testing/selftests/bpf/prog_tests/fentry_test.c
index c0d1d61d5f66..aee1bc77a17f 100644
--- a/tools/testing/selftests/bpf/prog_tests/fentry_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_test.c
@@ -2,8 +2,9 @@
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
 #include "fentry_test.lskel.h"
+#include "fentry_many_args.skel.h"
 
-static int fentry_test(struct fentry_test_lskel *fentry_skel)
+static int fentry_test_common(struct fentry_test_lskel *fentry_skel)
 {
 	int err, prog_fd, i;
 	int link_fd;
@@ -37,7 +38,7 @@ static int fentry_test(struct fentry_test_lskel *fentry_skel)
 	return 0;
 }
 
-void test_fentry_test(void)
+static void fentry_test(void)
 {
 	struct fentry_test_lskel *fentry_skel = NULL;
 	int err;
@@ -46,13 +47,47 @@ void test_fentry_test(void)
 	if (!ASSERT_OK_PTR(fentry_skel, "fentry_skel_load"))
 		goto cleanup;
 
-	err = fentry_test(fentry_skel);
+	err = fentry_test_common(fentry_skel);
 	if (!ASSERT_OK(err, "fentry_first_attach"))
 		goto cleanup;
 
-	err = fentry_test(fentry_skel);
+	err = fentry_test_common(fentry_skel);
 	ASSERT_OK(err, "fentry_second_attach");
 
 cleanup:
 	fentry_test_lskel__destroy(fentry_skel);
 }
+
+static void fentry_many_args(void)
+{
+	struct fentry_many_args *fentry_skel = NULL;
+	int err;
+
+	fentry_skel = fentry_many_args__open_and_load();
+	if (!ASSERT_OK_PTR(fentry_skel, "fentry_many_args_skel_load"))
+		goto cleanup;
+
+	err = fentry_many_args__attach(fentry_skel);
+	if (!ASSERT_OK(err, "fentry_many_args_attach"))
+		goto cleanup;
+
+	ASSERT_OK(trigger_module_test_read(1), "trigger_read");
+
+	ASSERT_EQ(fentry_skel->bss->test1_result, 1,
+		  "fentry_many_args_result1");
+	ASSERT_EQ(fentry_skel->bss->test2_result, 1,
+		  "fentry_many_args_result2");
+	ASSERT_EQ(fentry_skel->bss->test3_result, 1,
+		  "fentry_many_args_result3");
+
+cleanup:
+	fentry_many_args__destroy(fentry_skel);
+}
+
+void test_fentry_test(void)
+{
+	if (test__start_subtest("fentry"))
+		fentry_test();
+	if (test__start_subtest("fentry_many_args"))
+		fentry_many_args();
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_test.c b/tools/testing/selftests/bpf/prog_tests/fexit_test.c
index 101b7343036b..1c13007e37dd 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_test.c
@@ -2,8 +2,9 @@
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
 #include "fexit_test.lskel.h"
+#include "fexit_many_args.skel.h"
 
-static int fexit_test(struct fexit_test_lskel *fexit_skel)
+static int fexit_test_common(struct fexit_test_lskel *fexit_skel)
 {
 	int err, prog_fd, i;
 	int link_fd;
@@ -37,7 +38,7 @@ static int fexit_test(struct fexit_test_lskel *fexit_skel)
 	return 0;
 }
 
-void test_fexit_test(void)
+static void fexit_test(void)
 {
 	struct fexit_test_lskel *fexit_skel = NULL;
 	int err;
@@ -46,13 +47,47 @@ void test_fexit_test(void)
 	if (!ASSERT_OK_PTR(fexit_skel, "fexit_skel_load"))
 		goto cleanup;
 
-	err = fexit_test(fexit_skel);
+	err = fexit_test_common(fexit_skel);
 	if (!ASSERT_OK(err, "fexit_first_attach"))
 		goto cleanup;
 
-	err = fexit_test(fexit_skel);
+	err = fexit_test_common(fexit_skel);
 	ASSERT_OK(err, "fexit_second_attach");
 
 cleanup:
 	fexit_test_lskel__destroy(fexit_skel);
 }
+
+static void fexit_many_args(void)
+{
+	struct fexit_many_args *fexit_skel = NULL;
+	int err;
+
+	fexit_skel = fexit_many_args__open_and_load();
+	if (!ASSERT_OK_PTR(fexit_skel, "fexit_many_args_skel_load"))
+		goto cleanup;
+
+	err = fexit_many_args__attach(fexit_skel);
+	if (!ASSERT_OK(err, "fexit_many_args_attach"))
+		goto cleanup;
+
+	ASSERT_OK(trigger_module_test_read(1), "trigger_read");
+
+	ASSERT_EQ(fexit_skel->bss->test1_result, 1,
+		  "fexit_many_args_result1");
+	ASSERT_EQ(fexit_skel->bss->test2_result, 1,
+		  "fexit_many_args_result2");
+	ASSERT_EQ(fexit_skel->bss->test3_result, 1,
+		  "fexit_many_args_result3");
+
+cleanup:
+	fexit_many_args__destroy(fexit_skel);
+}
+
+void test_fexit_test(void)
+{
+	if (test__start_subtest("fexit"))
+		fexit_test();
+	if (test__start_subtest("fexit_many_args"))
+		fexit_many_args();
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
index 28cf63963cb7..64a9c95d4acf 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
@@ -30,7 +30,9 @@ void test_get_func_args_test(void)
 	prog_fd = bpf_program__fd(skel->progs.fmod_ret_test);
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "test_run");
-	ASSERT_EQ(topts.retval, 1234, "test_run");
+
+	ASSERT_EQ(topts.retval >> 16, 1, "test_run");
+	ASSERT_EQ(topts.retval & 0xffff, 1234 + 29, "test_run");
 
 	ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
 	ASSERT_EQ(skel->bss->test2_result, 1, "test2_result");
diff --git a/tools/testing/selftests/bpf/prog_tests/modify_return.c b/tools/testing/selftests/bpf/prog_tests/modify_return.c
index 5d9955af6247..a70c99c2f8c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/modify_return.c
+++ b/tools/testing/selftests/bpf/prog_tests/modify_return.c
@@ -41,6 +41,10 @@ static void run_test(__u32 input_retval, __u16 want_side_effect, __s16 want_ret)
 	ASSERT_EQ(skel->bss->fexit_result, 1, "modify_return fexit_result");
 	ASSERT_EQ(skel->bss->fmod_ret_result, 1, "modify_return fmod_ret_result");
 
+	ASSERT_EQ(skel->bss->fentry_result2, 1, "modify_return fentry_result2");
+	ASSERT_EQ(skel->bss->fexit_result2, 1, "modify_return fexit_result2");
+	ASSERT_EQ(skel->bss->fmod_ret_result2, 1, "modify_return fmod_ret_result2");
+
 cleanup:
 	modify_return__destroy(skel);
 }
@@ -49,9 +53,9 @@ static void run_test(__u32 input_retval, __u16 want_side_effect, __s16 want_ret)
 void serial_test_modify_return(void)
 {
 	run_test(0 /* input_retval */,
-		 1 /* want_side_effect */,
-		 4 /* want_ret */);
+		 2 /* want_side_effect */,
+		 33 /* want_ret */);
 	run_test(-EINVAL /* input_retval */,
 		 0 /* want_side_effect */,
-		 -EINVAL /* want_ret */);
+		 -EINVAL * 2 /* want_ret */);
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
diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
index e91d0d1769f1..6cd7349d4a2b 100644
--- a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
+++ b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
@@ -88,8 +88,8 @@ void serial_test_trampoline_count(void)
 	if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
 		goto cleanup;
 
-	ASSERT_EQ(opts.retval & 0xffff, 4, "bpf_modify_return_test.result");
-	ASSERT_EQ(opts.retval >> 16, 1, "bpf_modify_return_test.side_effect");
+	ASSERT_EQ(opts.retval & 0xffff, 33, "bpf_modify_return_test.result");
+	ASSERT_EQ(opts.retval >> 16, 2, "bpf_modify_return_test.side_effect");
 
 cleanup:
 	for (; i >= 0; i--) {
diff --git a/tools/testing/selftests/bpf/progs/fentry_many_args.c b/tools/testing/selftests/bpf/progs/fentry_many_args.c
new file mode 100644
index 000000000000..b61bb92fee2c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_many_args.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Tencent */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_result = 0;
+SEC("fentry/bpf_testmod_fentry_test7")
+int BPF_PROG(test1, __u64 a, void *b, short c, int d, void *e, char f,
+	     int g)
+{
+	test1_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
+		e == (void *)20 && f == 21 && g == 22;
+	return 0;
+}
+
+__u64 test2_result = 0;
+SEC("fentry/bpf_testmod_fentry_test11")
+int BPF_PROG(test2, __u64 a, void *b, short c, int d, void *e, char f,
+	     int g, unsigned int h, long i, __u64 j, unsigned long k)
+{
+	test2_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
+		e == (void *)20 && f == 21 && g == 22 && h == 23 &&
+		i == 24 && j == 25 && k == 26;
+	return 0;
+}
+
+__u64 test3_result = 0;
+SEC("fentry/bpf_testmod_fentry_test11")
+int BPF_PROG(test3, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f,
+	     __u64 g, __u64 h, __u64 i, __u64 j, __u64 k)
+{
+	test3_result = a == 16 && b == 17 && c == 18 && d == 19 &&
+		e == 20 && f == 21 && g == 22 && h == 23 &&
+		i == 24 && j == 25 && k == 26;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/fexit_many_args.c b/tools/testing/selftests/bpf/progs/fexit_many_args.c
new file mode 100644
index 000000000000..53b335c2dafb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fexit_many_args.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Tencent */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_result = 0;
+SEC("fexit/bpf_testmod_fentry_test7")
+int BPF_PROG(test1, __u64 a, void *b, short c, int d, void *e, char f,
+	     int g, int ret)
+{
+	test1_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
+		e == (void *)20 && f == 21 && g == 22 && ret == 133;
+	return 0;
+}
+
+__u64 test2_result = 0;
+SEC("fexit/bpf_testmod_fentry_test11")
+int BPF_PROG(test2, __u64 a, void *b, short c, int d, void *e, char f,
+	     int g, unsigned int h, long i, __u64 j, unsigned long k,
+	     int ret)
+{
+	test2_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
+		e == (void *)20 && f == 21 && g == 22 && h == 23 &&
+		i == 24 && j == 25 && k == 26 && ret == 231;
+	return 0;
+}
+
+__u64 test3_result = 0;
+SEC("fexit/bpf_testmod_fentry_test11")
+int BPF_PROG(test3, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f,
+	     __u64 g, __u64 h, __u64 i, __u64 j, __u64 k, __u64 ret)
+{
+	test3_result = a == 16 && b == 17 && c == 18 && d == 19 &&
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


