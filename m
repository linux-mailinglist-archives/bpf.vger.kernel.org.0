Return-Path: <bpf+bounces-67560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C91B45935
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 15:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098F6A63129
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 13:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B358A35A289;
	Fri,  5 Sep 2025 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GVxN8Zap"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8203570BE
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079175; cv=none; b=cIDtLSL3MVCcfEAgv7il03Enul6TsTAud3pSC/LW+Lc6S6LsNFcSKr/ZLL2S14eChdlByiJ9vcUMqUu71Q8Cma+ZAeBqSEVcoK8AeRcSjxakNgyEfE9hf98G0Tk5hAChpyL0u0mNFG/0szKnmN2TrT5hHzVJHeFEZ04UL8kupYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079175; c=relaxed/simple;
	bh=uInE0YkDUJUXbXok94E9bxvR8a4hiG6j6WidqWN48kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKEeipyc0mpEeGOl6kI9Ymx+6FsROfrB139uA43G/lSPe9TGoF66jJfBxqstlvRN+14GOLUop+ItXhAvrTx49VVga1XumoMLpPptU+nqDCiIsQfUaXBMVlwJI8zZD3uGjzTb8l6X0VYmnNih+fHOHjT1TvqMrVnVdDiFVwox8Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GVxN8Zap; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757079171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9T08l57xag5gO77hB+KVsLs3u1rcQ9NCVDDsDmzUHGM=;
	b=GVxN8Zapg3Nc8zcWmAHmKMKw+roQ21h8eubgMfF0Xw68lkOzvYlW3rO0IzZBeiYHPSXqLL
	CRPb9g7/eLZ2VHNGL0TWazdriPgQvZk5cTKHrD60M7FODgtIuf4nExUA+PHaAE+jmpQeeX
	aGzw7Y28boNyYuQY7Ztz+f2jax2r3KI=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test to access union argument in tracing program
Date: Fri,  5 Sep 2025 21:32:26 +0800
Message-ID: <20250905133226.84675-3-leon.hwang@linux.dev>
In-Reply-To: <20250905133226.84675-1-leon.hwang@linux.dev>
References: <20250905133226.84675-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Adding verifier test for accessing union argument in tracing programs.

The test program loads 1st argument of bpf_fentry_test11 function
which is union and checks that verifier allows that.

cd tools/testing/selftests/bpf
./test_progs -t verifier_btf_ctx
501/7   verifier_btf_ctx_access/btf_ctx_access union arg accept:OK
501     verifier_btf_ctx_access:OK
Summary: 1/7 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 net/bpf/test_run.c                                 | 14 +++++++++++++-
 .../selftests/bpf/progs/verifier_btf_ctx_access.c  | 12 ++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 4a862d6053861..c65d468fd6012 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -574,6 +574,16 @@ noinline int bpf_fentry_test10(const void *a)
 	return (long)a;
 }
 
+typedef union {
+	void *arg0;
+	int *arg1;
+} union_test_t;
+
+noinline int bpf_fentry_test11(union_test_t t)
+{
+	return (int)(long)t.arg0;
+}
+
 noinline void bpf_fentry_test_sinfo(struct skb_shared_info *sinfo)
 {
 }
@@ -688,6 +698,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 	struct bpf_fentry_test_t arg = {};
 	u16 side_effect = 0, ret = 0;
 	int b = 2, err = -EFAULT;
+	union_test_t utt = {};
 	u32 retval = 0;
 
 	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
@@ -705,7 +716,8 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 		    bpf_fentry_test7((struct bpf_fentry_test_t *)0) != 0 ||
 		    bpf_fentry_test8(&arg) != 0 ||
 		    bpf_fentry_test9(&retval) != 0 ||
-		    bpf_fentry_test10((void *)0) != 0)
+		    bpf_fentry_test10((void *)0) != 0 ||
+		    bpf_fentry_test11(utt) != 0)
 			goto out;
 		break;
 	case BPF_MODIFY_RETURN:
diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c b/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
index 03942cec07e56..ff379836b5f00 100644
--- a/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
@@ -77,4 +77,16 @@ __naked void ctx_access_const_void_pointer_accept(void)
 "	::: __clobber_all);
 }
 
+SEC("fentry/bpf_fentry_test11")
+__description("btf_ctx_access union arg accept")
+__success __retval(0)
+__naked void ctx_access_union_arg_accept(void)
+{
+	asm volatile ("					\
+	r2 = *(u64 *)(r1 + 0);		/* load 1st argument value (union) */\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.50.1


