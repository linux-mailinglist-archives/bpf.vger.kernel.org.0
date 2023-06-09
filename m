Return-Path: <bpf+bounces-2221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDFF729610
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 11:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24982818A3
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 09:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5B314A98;
	Fri,  9 Jun 2023 09:57:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004DB13AE9
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 09:57:26 +0000 (UTC)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A046A41;
	Fri,  9 Jun 2023 02:57:15 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 46e09a7af769-6af74ca9f4aso512144a34.3;
        Fri, 09 Jun 2023 02:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686304634; x=1688896634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxLT1h6F8xwdKl2Puy3yKVy/htvueJ5tWaXe00nH7Yg=;
        b=sp36f1+U7UIE/GzY+Yor6cPco4VrwtLSsueBy42O7/RbqdM7sh1E7DAJoVGRB4D08C
         AVRyAps37X77X+p7geVsUgTcJPOLERyGPG0wfVRqDCKbOQgaE+O4sX3bu715jsMnlfhJ
         Hms9ZrQfwjIrV4eTIPIHzePPlVGLCb3yure6JJUIger0zzxnrOPh3fwJAzMmXIBGZ1Im
         yLwSWFK2oDysLS/u4I+YEviZELWHuYYiF2j+4MmpD5ry9+5LTr9bH9Ho31qkciaUFuRr
         fa8/fl3uRk+r57KbVT+0Y/2vt5kqncvRj9S+TPpKXYZAADCsVsroW3diglG7UHMYr/lH
         yNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686304634; x=1688896634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxLT1h6F8xwdKl2Puy3yKVy/htvueJ5tWaXe00nH7Yg=;
        b=a05Inib7kikKzMjIfu/LTjuiTBW3L1Lt5PRQ6FpBYc9TlDmauOalAR23fYSPfEE0od
         eiqMSqzCFRxe6sHnMMKnVFzL9bkAjx1nnuPwfsIJ0jGJw58rjSsDMuT5adUBZG6Cz6ZS
         xONLWoCBHtjn2GlR4JZ3qDsXhvTADAbpJ5WLafGRMcB0l9l8LWHfFP2Jaj07qbSxgQn9
         A1X0uq6d/lYa1nbE6nngVnIU5ofiYaRYmR90UkOr4WTGBbvxhwAKRPFMJUNEGaccljtb
         jxpELTKm5cuAe6TItybygiOS1LyC731moqKk3+tkhyIy096a+FXcZqd2rPK0ksxmgA2d
         D5Aw==
X-Gm-Message-State: AC+VfDwHYQJg6BEMg58CLGjdpgvkoHnNeiKbE0vvOkWRL6DDXeLip2ZB
	zJJYE95XCxU7/RzEtqH1DmM=
X-Google-Smtp-Source: ACHHUZ563rm/yEIvDaWJviav8CScXDT+LaSwJKY6T56YgIF+XN8X9xf8uXDh+JUNuIPpHR+FYs2R1A==
X-Received: by 2002:a05:6359:3a8:b0:127:c478:641c with SMTP id eg40-20020a05635903a800b00127c478641cmr783805rwb.28.1686304634260;
        Fri, 09 Jun 2023 02:57:14 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.114])
        by smtp.gmail.com with ESMTPSA id 26-20020a63175a000000b0053f3797fc4asm2603369pgx.0.2023.06.09.02.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:57:13 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: add testcase for FENTRY/FEXIT with 6+ arguments
Date: Fri,  9 Jun 2023 17:56:53 +0800
Message-Id: <20230609095653.1406173-4-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609095653.1406173-1-imagedong@tencent.com>
References: <20230609095653.1406173-1-imagedong@tencent.com>
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
and fexit whose target function have 7/12 arguments.

Correspondingly, add bpf_testmod_fentry_test7() and
bpf_testmod_fentry_test12() to bpf_testmod.c

And the testcases passed:

./test_progs -t fexit
Summary: 5/12 PASSED, 0 SKIPPED, 0 FAILED

./test_progs -t fentry
Summary: 3/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
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
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 19 ++++++-
 .../selftests/bpf/prog_tests/fentry_fexit.c   |  4 +-
 .../selftests/bpf/prog_tests/fentry_test.c    |  2 +
 .../selftests/bpf/prog_tests/fexit_test.c     |  2 +
 .../testing/selftests/bpf/progs/fentry_test.c | 33 +++++++++++
 .../testing/selftests/bpf/progs/fexit_test.c  | 57 +++++++++++++++++++
 6 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index cf216041876c..66615fdbe3df 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -191,6 +191,19 @@ noinline int bpf_testmod_fentry_test3(char a, int b, u64 c)
 	return a + b + c;
 }
 
+noinline int bpf_testmod_fentry_test7(u64 a, void *b, short c, int d,
+				      void *e, u64 f, u64 g)
+{
+	return a + (long)b + c + d + (long)e + f + g;
+}
+
+noinline int bpf_testmod_fentry_test12(u64 a, void *b, short c, int d,
+				       void *e, u64 f, u64 g, u64 h,
+				       u64 i, u64 j, u64 k, u64 l)
+{
+	return a + (long)b + c + d + (long)e + f + g + h + i + j + k + l;
+}
+
 __diag_pop();
 
 int bpf_testmod_fentry_ok;
@@ -245,7 +258,11 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 
 	if (bpf_testmod_fentry_test1(1) != 2 ||
 	    bpf_testmod_fentry_test2(2, 3) != 5 ||
-	    bpf_testmod_fentry_test3(4, 5, 6) != 15)
+	    bpf_testmod_fentry_test3(4, 5, 6) != 15 ||
+	    bpf_testmod_fentry_test7(16, (void *)17, 18, 19, (void *)20,
+				     21, 22) != 133 ||
+	    bpf_testmod_fentry_test12(16, (void *)17, 18, 19, (void *)20,
+				      21, 22, 23, 24, 25, 26, 27) != 258)
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
diff --git a/tools/testing/selftests/bpf/progs/fentry_test.c b/tools/testing/selftests/bpf/progs/fentry_test.c
index 52a550d281d9..91dbf63b3ba1 100644
--- a/tools/testing/selftests/bpf/progs/fentry_test.c
+++ b/tools/testing/selftests/bpf/progs/fentry_test.c
@@ -77,3 +77,36 @@ int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
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
+SEC("fentry/bpf_testmod_fentry_test12")
+int BPF_PROG(test10, __u64 a, void *b, short c, int d, void *e, char f,
+	     int g, unsigned int h, long i, __u64 j, unsigned long k,
+	     unsigned char l)
+{
+	test10_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
+		e == (void *)20 && f == 21 && g == 22 && h == 23 &&
+		i == 24 && j == 25 && k == 26 && l == 27;
+	return 0;
+}
+
+__u64 test11_result = 0;
+SEC("fentry/bpf_testmod_fentry_test12")
+int BPF_PROG(test11, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f,
+	     __u64 g, __u64 h, __u64 i, __u64 j, __u64 k, __u64 l)
+{
+	test11_result = a == 16 && b == 17 && c == 18 && d == 19 &&
+		e == 20 && f == 21 && g == 22 && h == 23 &&
+		i == 24 && j == 25 && k == 26 && l == 27;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/fexit_test.c b/tools/testing/selftests/bpf/progs/fexit_test.c
index 8f1ccb7302e1..a6d8e03ff5b7 100644
--- a/tools/testing/selftests/bpf/progs/fexit_test.c
+++ b/tools/testing/selftests/bpf/progs/fexit_test.c
@@ -78,3 +78,60 @@ int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
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
+SEC("fexit/bpf_testmod_fentry_test12")
+int BPF_PROG(test10, __u64 a, void *b, short c, int d, void *e, char f,
+	     int g, unsigned int h, long i, __u64 j, unsigned long k,
+	     unsigned char l)
+{
+	__u64 ret;
+	int err;
+
+	/* BPF_PROG() don't support 14 arguments, and ctx[12] can't be
+	 * accessed yet. So we get the return value by bpf_get_func_ret()
+	 * for now.
+	 */
+	err = bpf_get_func_ret(ctx, &ret);
+	if (err)
+		return 0;
+
+	test10_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
+		e == (void *)20 && f == 21 && g == 22 && h == 23 &&
+		i == 24 && j == 25 && k == 26 && l == 27 &&
+		(int)ret == 258;
+	return 0;
+}
+
+__u64 test11_result = 0;
+SEC("fexit/bpf_testmod_fentry_test12")
+int BPF_PROG(test11, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f,
+	     __u64 g, __u64 h, __u64 i, __u64 j, __u64 k, __u64 l)
+{
+	__u64 ret;
+	int err;
+
+	/* BPF_PROG() don't support 14 arguments, and ctx[12] can't be
+	 * accessed yet. So we get the return value by bpf_get_func_ret()
+	 * for now.
+	 */
+	err = bpf_get_func_ret(ctx, &ret);
+	if (err)
+		return 0;
+
+	test11_result = a == 16 && b == 17 && c == 18 && d == 19 &&
+		e == 20 && f == 21 && g == 22 && h == 23 &&
+		i == 24 && j == 25 && k == 26 && l == 27 &&
+		ret == 258;
+	return 0;
+}
-- 
2.40.1


