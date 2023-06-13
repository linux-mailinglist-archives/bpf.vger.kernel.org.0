Return-Path: <bpf+bounces-2477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC0A72D781
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 04:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B00A1C20BFC
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 02:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE391FB4;
	Tue, 13 Jun 2023 02:53:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ABB7F
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 02:53:23 +0000 (UTC)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81651991;
	Mon, 12 Jun 2023 19:53:19 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 46e09a7af769-6b280319df5so3334089a34.3;
        Mon, 12 Jun 2023 19:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686624799; x=1689216799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5v/B2wo+H7MgbJawsb1mh4k2q1GRnaIUu6dzRZ7Tos8=;
        b=pnbxpEraEGNwAGxwjgFylY/wJw3Y+82r/O8AaT1NJxWJCAKdeg/AFJfeQ8rNzIrbGP
         H89A3wZAfdIyJRrcPJ3uGuzq51fduRqGX/GgQH7eANzorjGt5lphvk0dMRHlnDqdgPKi
         snK242eNePtHU2HBvbWHx/tnUIbgBAQYqZ1eN4Bjcq/2cpHcMREjhBNXSse9i5KwO0w4
         bPo2tVKzoMeDyU2ECIdq4NJ9LOBed0Vc9kLCHGMj7mRd6SSuoR19oAn8LCzk7vBvtLY7
         s/VNBtq1rNqrF80fIkD2oAh4/GZftA2r23v88xUn+i0A6vwYeIUGTKjK1BgRJdto0lPS
         kwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686624799; x=1689216799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5v/B2wo+H7MgbJawsb1mh4k2q1GRnaIUu6dzRZ7Tos8=;
        b=V3k9dP9o7M55NrUfhC3MtzrMd8QJi5X5mrdbz2r753fhjMN98OhjnA3stiw1RyXEdx
         EqvZnQx7kDJ9RLje8/obg8VRV9n7QLROtREusUhjiw8c8znga3UYY2Ndk8sqqcjcqgmd
         rcksPfanShtAA7z5aSIBegNtvLZmo0taTwVzc/x6EbJGzyXRkU6EMD0GTaZWYzjV2zzx
         fTn+7UwN72ThFNygQblEykRlmSG6ohSQWlExYTT0ZgO1hUVv+hX0dbLs6CXoNUl9PILW
         v3zO6xO3xqQNUWCONnGUMdp8JahPL7v+TFEpWDC9JrIPPv4xZXccBxLYhutZYe2bGZm3
         QSYg==
X-Gm-Message-State: AC+VfDyw5d3Y4vTx3V7AIPkyhtONqt9g18DiX/vM9nDS6OAvCh9Bbjoz
	EXLM+bdZgLC8Q3VSZLVpwME=
X-Google-Smtp-Source: ACHHUZ7/LjTYqreCxkD/iajL2aXNjjt6bB23h7ynycSQnHiPxHLqoGdpTOYv2uRVJ/PmVss18MJxlg==
X-Received: by 2002:a05:6830:1007:b0:6b0:cfce:6d1f with SMTP id a7-20020a056830100700b006b0cfce6d1fmr8613930otp.24.1686624798783;
        Mon, 12 Jun 2023 19:53:18 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.85])
        by smtp.gmail.com with ESMTPSA id v65-20020a632f44000000b00543e9e17207sm8240207pgv.30.2023.06.12.19.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 19:53:18 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: add testcase for TRACING with 6+ arguments
Date: Tue, 13 Jun 2023 10:52:26 +0800
Message-Id: <20230613025226.3167956-4-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613025226.3167956-1-imagedong@tencent.com>
References: <20230613025226.3167956-1-imagedong@tencent.com>
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

And the testcases passed:

./test_progs -t fexit
Summary: 5/12 PASSED, 0 SKIPPED, 0 FAILED

./test_progs -t fentry
Summary: 3/0 PASSED, 0 SKIPPED, 0 FAILED

./test_progs -t modify_return
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
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
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 45 +++++++++++++++-
 .../selftests/bpf/prog_tests/fentry_fexit.c   |  4 +-
 .../selftests/bpf/prog_tests/fentry_test.c    |  2 +
 .../selftests/bpf/prog_tests/fexit_test.c     |  2 +
 .../selftests/bpf/prog_tests/modify_return.c  | 20 ++++++-
 .../testing/selftests/bpf/progs/fentry_test.c | 52 ++++++++++++++++++
 .../testing/selftests/bpf/progs/fexit_test.c  | 54 +++++++++++++++++++
 .../selftests/bpf/progs/modify_return.c       | 40 ++++++++++++++
 9 files changed, 235 insertions(+), 7 deletions(-)

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
index aaf6ef1201c7..737ef0a5dca4 100644
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
@@ -191,6 +196,35 @@ noinline int bpf_testmod_fentry_test3(char a, int b, u64 c)
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
+noinline int bpf_testmod_fentry_test_struct1(u64 a, void *b, short c,
+					     int d, void *e,
+					     struct bpf_testmod_struct_arg_4 f)
+{
+	return a + (long)b + c + d + (long)e + f.a + f.b;
+}
+
+noinline int bpf_testmod_fentry_test_struct2(u64 a, void *b, short c,
+					     int d, void *e,
+					     struct bpf_testmod_struct_arg_4 f,
+					     int g)
+{
+	return a + (long)b + c + d + (long)e + f.a + f.b + g;
+}
+
 int bpf_testmod_fentry_ok;
 
 noinline ssize_t
@@ -206,6 +240,7 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 	struct bpf_testmod_struct_arg_1 struct_arg1 = {10};
 	struct bpf_testmod_struct_arg_2 struct_arg2 = {2, 3};
 	struct bpf_testmod_struct_arg_3 *struct_arg3;
+	struct bpf_testmod_struct_arg_4 struct_arg4 = {21, 22};
 	int i = 1;
 
 	while (bpf_testmod_return_ptr(i))
@@ -243,7 +278,15 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 
 	if (bpf_testmod_fentry_test1(1) != 2 ||
 	    bpf_testmod_fentry_test2(2, 3) != 5 ||
-	    bpf_testmod_fentry_test3(4, 5, 6) != 15)
+	    bpf_testmod_fentry_test3(4, 5, 6) != 15 ||
+	    bpf_testmod_fentry_test7(16, (void *)17, 18, 19, (void *)20,
+			21, 22) != 133 ||
+	    bpf_testmod_fentry_test11(16, (void *)17, 18, 19, (void *)20,
+			21, 22, 23, 24, 25, 26) != 231 ||
+	    bpf_testmod_fentry_test_struct1(16, (void *)17, 18, 19,
+			(void *)20, struct_arg4) != 133 ||
+	    bpf_testmod_fentry_test_struct2(16, (void *)17, 18, 19,
+			(void *)20, struct_arg4, 23) != 156)
 		goto out;
 
 	bpf_testmod_fentry_ok = 1;
diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c b/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
index 130f5b82d2e6..7decf57e7591 100644
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
+	for (i = 0; i < 13; i++) {
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
diff --git a/tools/testing/selftests/bpf/progs/fentry_test.c b/tools/testing/selftests/bpf/progs/fentry_test.c
index 52a550d281d9..3614c85c4ead 100644
--- a/tools/testing/selftests/bpf/progs/fentry_test.c
+++ b/tools/testing/selftests/bpf/progs/fentry_test.c
@@ -77,3 +77,55 @@ int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
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
+
+__u64 test12_result = 0;
+SEC("fentry/bpf_testmod_fentry_test_struct1")
+int BPF_PROG(test12, __u64 a, void *b, short c, int d, void *e, __u64 s_a,
+	     int s_b)
+{
+	test12_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
+		e == (void *)20 && s_a == 21 && s_b == 22;
+	return 0;
+}
+
+__u64 test13_result = 0;
+SEC("fentry/bpf_testmod_fentry_test_struct2")
+int BPF_PROG(test13, __u64 a, void *b, short c, int d, void *e, __u64 s_a,
+	     int s_b, int f)
+{
+	test13_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
+		e == (void *)20 && s_a == 21 && s_b == 22 && f == 23;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/fexit_test.c b/tools/testing/selftests/bpf/progs/fexit_test.c
index 8f1ccb7302e1..f6c50e4663db 100644
--- a/tools/testing/selftests/bpf/progs/fexit_test.c
+++ b/tools/testing/selftests/bpf/progs/fexit_test.c
@@ -78,3 +78,57 @@ int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
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
+
+__u64 test12_result = 0;
+SEC("fexit/bpf_testmod_fentry_test_struct1")
+int BPF_PROG(test12, __u64 a, void *b, short c, int d, void *e, __u64 s_a,
+	     int s_b, __u64 ret)
+{
+	test12_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
+		e == (void *)20 && s_a == 21 && s_b == 22 && ret == 133;
+	return 0;
+}
+
+__u64 test13_result = 0;
+SEC("fexit/bpf_testmod_fentry_test_struct2")
+int BPF_PROG(test13, __u64 a, void *b, short c, int d, void *e, __u64 s_a,
+	     int s_b, int f, __u64 ret)
+{
+	test13_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
+		e == (void *)20 && s_a == 21 && s_b == 22 && f == 23 &&
+		ret == 156;
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
-- 
2.40.1


