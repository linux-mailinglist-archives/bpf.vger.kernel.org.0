Return-Path: <bpf+bounces-68529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C41B59C95
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 17:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D29324536
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 15:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C35352FF2;
	Tue, 16 Sep 2025 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ww6X2mXT"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281FD3570B4
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037966; cv=none; b=u53+K/KfQscnQV7R1g7vxjQ/DA48yD/E4Hc/ZuxlLbbXgB4BAq2K6RQMisFe0JYOKWjR/POZY+yS+IJL2jceHzCBIFZnijL973zZgK8/A8dAXBeKAiWZlX5JVMsn4FL2Z7zxmnTxekNCKuwRGyUJx8eH44kX4QfAZ5PDkGmafyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037966; c=relaxed/simple;
	bh=9Qe62bZWaJrS75Zy2Dycz9dwDd7lbtWMjCefxIgobgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lciBs41yesaEs770btLaMWzutieqbXXBOEjHS3oiJn7FyjcYobYjNZAQkq+Bs9Gs+n0HVX5vAurspjSZefmdVU1HW9u7ejW/8Oh5qVUgHChPKviC//pUJ/vr4fhCxLNEbMxvfYgqDsbzKkGEdtig47yBllutyVoCFnr3CDnwwdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ww6X2mXT; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758037962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wY8pDcEkIECvI8QI9y28bkmZkEfrq7HL5M6nvOFerYA=;
	b=Ww6X2mXTTsHnHYuM0NKnaym4x/8UBm3Cxy/0P7WVQEOBVcQEhQvezgiL1sfnXShbW0f0YV
	sJ7yYYj7OMl/PqiSczig+f6vr69ILGRQM9E8pA3m5/EVxTc/ySjl5Yr4z9BDCAj8Y8YYJ1
	ui1upKfCysubDwP4MGGNYdoVy1yJOKc=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	yatsenko@meta.com,
	puranjay@kernel.org,
	davidzalman.101@gmail.com,
	cheick.traore@foss.st.com,
	chen.dylane@linux.dev,
	mika.westerberg@linux.intel.com,
	ameryhung@gmail.com,
	menglong8.dong@gmail.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Add union argument tests using fexit programs
Date: Tue, 16 Sep 2025 23:52:11 +0800
Message-ID: <20250916155211.61083-4-leon.hwang@linux.dev>
In-Reply-To: <20250916155211.61083-1-leon.hwang@linux.dev>
References: <20250916155211.61083-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

By referencing
commit 1642a3945e223 ("selftests/bpf: Add struct argument tests with fentry/fexit programs."),
test the following cases for union argument support:

* 8B union argument.
* 16B union argument.

cd tools/testing/selftests/bpf
./test_progs -t tracing_struct/union_args
472/3   tracing_struct/union_args:OK
472     tracing_struct:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tracing_struct.c | 29 ++++++++++++++++
 .../selftests/bpf/progs/tracing_struct.c      | 33 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 31 +++++++++++++++++
 3 files changed, 93 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
index 19e68d4b35327..6f8c0bfb04155 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
@@ -112,10 +112,39 @@ static void test_struct_many_args(void)
 	tracing_struct_many_args__destroy(skel);
 }
 
+static void test_union_args(void)
+{
+	struct tracing_struct *skel;
+	int err;
+
+	skel = tracing_struct__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_struct__open_and_load"))
+		return;
+
+	err = tracing_struct__attach(skel);
+	if (!ASSERT_OK(err, "tracing_struct__attach"))
+		goto out;
+
+	ASSERT_OK(trigger_module_test_read(256), "trigger_read");
+
+	ASSERT_EQ(skel->bss->ut1_a_a, 1, "ut1:a.arg.a");
+	ASSERT_EQ(skel->bss->ut1_b, 4, "ut1:b");
+	ASSERT_EQ(skel->bss->ut1_c, 5, "ut1:c");
+
+	ASSERT_EQ(skel->bss->ut2_a, 6, "ut2:a");
+	ASSERT_EQ(skel->bss->ut2_b_a, 2, "ut2:b.arg.a");
+	ASSERT_EQ(skel->bss->ut2_b_b, 3, "ut2:b.arg.b");
+
+out:
+	tracing_struct__destroy(skel);
+}
+
 void test_tracing_struct(void)
 {
 	if (test__start_subtest("struct_args"))
 		test_struct_args();
 	if (test__start_subtest("struct_many_args"))
 		test_struct_many_args();
+	if (test__start_subtest("union_args"))
+		test_union_args();
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct.c b/tools/testing/selftests/bpf/progs/tracing_struct.c
index c435a3a8328ab..d460732e20239 100644
--- a/tools/testing/selftests/bpf/progs/tracing_struct.c
+++ b/tools/testing/selftests/bpf/progs/tracing_struct.c
@@ -18,6 +18,18 @@ struct bpf_testmod_struct_arg_3 {
 	int b[];
 };
 
+union bpf_testmod_union_arg_1 {
+	char a;
+	short b;
+	struct bpf_testmod_struct_arg_1 arg;
+};
+
+union bpf_testmod_union_arg_2 {
+	int a;
+	long b;
+	struct bpf_testmod_struct_arg_2 arg;
+};
+
 long t1_a_a, t1_a_b, t1_b, t1_c, t1_ret, t1_nregs;
 __u64 t1_reg0, t1_reg1, t1_reg2, t1_reg3;
 long t2_a, t2_b_a, t2_b_b, t2_c, t2_ret;
@@ -26,6 +38,9 @@ long t4_a_a, t4_b, t4_c, t4_d, t4_e_a, t4_e_b, t4_ret;
 long t5_ret;
 int t6;
 
+long ut1_a_a, ut1_b, ut1_c;
+long ut2_a, ut2_b_a, ut2_b_b;
+
 SEC("fentry/bpf_testmod_test_struct_arg_1")
 int BPF_PROG2(test_struct_arg_1, struct bpf_testmod_struct_arg_2, a, int, b, int, c)
 {
@@ -130,4 +145,22 @@ int BPF_PROG2(test_struct_arg_11, struct bpf_testmod_struct_arg_3 *, a)
 	return 0;
 }
 
+SEC("fexit/bpf_testmod_test_union_arg_1")
+int BPF_PROG2(test_union_arg_1, union bpf_testmod_union_arg_1, a, int, b, int, c)
+{
+	ut1_a_a = a.arg.a;
+	ut1_b = b;
+	ut1_c = c;
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_test_union_arg_2")
+int BPF_PROG2(test_union_arg_2, int, a, union bpf_testmod_union_arg_2, b)
+{
+	ut2_a = a;
+	ut2_b_a = b.arg.a;
+	ut2_b_b = b.arg.b;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 2beb9b2fcbd87..9cd28de05960c 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -62,6 +62,18 @@ struct bpf_testmod_struct_arg_5 {
 	long d;
 };
 
+union bpf_testmod_union_arg_1 {
+	char a;
+	short b;
+	struct bpf_testmod_struct_arg_1 arg;
+};
+
+union bpf_testmod_union_arg_2 {
+	int a;
+	long b;
+	struct bpf_testmod_struct_arg_2 arg;
+};
+
 __bpf_hook_start();
 
 noinline int
@@ -128,6 +140,20 @@ bpf_testmod_test_struct_arg_9(u64 a, void *b, short c, int d, void *e, char f,
 	return bpf_testmod_test_struct_arg_result;
 }
 
+noinline int
+bpf_testmod_test_union_arg_1(union bpf_testmod_union_arg_1 a, int b, int c)
+{
+	bpf_testmod_test_struct_arg_result = a.arg.a + b + c;
+	return bpf_testmod_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_test_union_arg_2(int a, union bpf_testmod_union_arg_2 b)
+{
+	bpf_testmod_test_struct_arg_result = a + b.arg.a + b.arg.b;
+	return bpf_testmod_test_struct_arg_result;
+}
+
 noinline int
 bpf_testmod_test_arg_ptr_to_struct(struct bpf_testmod_struct_arg_1 *a) {
 	bpf_testmod_test_struct_arg_result = a->a;
@@ -398,6 +424,8 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 	struct bpf_testmod_struct_arg_3 *struct_arg3;
 	struct bpf_testmod_struct_arg_4 struct_arg4 = {21, 22};
 	struct bpf_testmod_struct_arg_5 struct_arg5 = {23, 24, 25, 26};
+	union bpf_testmod_union_arg_1 union_arg1 = { .arg = {1} };
+	union bpf_testmod_union_arg_2 union_arg2 = { .arg = {2, 3} };
 	int i = 1;
 
 	while (bpf_testmod_return_ptr(i))
@@ -415,6 +443,9 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 	(void)bpf_testmod_test_struct_arg_9(16, (void *)17, 18, 19, (void *)20,
 					    21, 22, struct_arg5, 27);
 
+	(void)bpf_testmod_test_union_arg_1(union_arg1, 4, 5);
+	(void)bpf_testmod_test_union_arg_2(6, union_arg2);
+
 	(void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
 
 	(void)trace_bpf_testmod_test_raw_tp_null_tp(NULL);
-- 
2.50.1


