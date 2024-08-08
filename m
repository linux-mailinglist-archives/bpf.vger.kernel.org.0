Return-Path: <bpf+bounces-36735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BEB94C754
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 01:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C46FDB239BF
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 23:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075371607A1;
	Thu,  8 Aug 2024 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+bnGmeq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8309115FA66
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723159366; cv=none; b=u7mvTHh6KUxUuVZ5x5ioFeu6ATiSgxdWafMKTIKBDgBgdozU754yd7phQr9s06j8TgmZ9+cTmQS3VBK3CeaylhMU+oeDY1I/r2WayTLxqWhgYNdjeH+at0rU93ScAMvkAOV0B4Y7NLkP4zTrUgHIvRrwlUAMyjUQnNJUrUk29/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723159366; c=relaxed/simple;
	bh=MUE+NS9AxMtIxI3Z4e6/laog02bwFDluzELfyAfhpzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjBHn6KgAlHeCGjVP+taVSLATwixt38rbAwuhUPGFyXaPvg+U7iGynV962iGwkM4QCqzWvy4lso64MZZOWT4zbor04C3T3xazRfHpfMk7e4XOiFAP2n6R7YaqbdlpfwC8NTKuyQkkTlr1jfqaMKIoAk+y+ub+5BiE+zvNZRViOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+bnGmeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F354C32782;
	Thu,  8 Aug 2024 23:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723159366;
	bh=MUE+NS9AxMtIxI3Z4e6/laog02bwFDluzELfyAfhpzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+bnGmeqeNo/4doxQ/AYFdupqQDr4JiFfynxUDyeam5Rslu1NfuIolYmSfG4buVWQ
	 KlcUkIZ1LNby+EPVLuqxgpyVWQ0zrM/kKpXTbVWahHITyfO71QHwwhqeC2voquOQmK
	 /jqQF1kPPbsC1RkWNbLnZXp0a0fNxCHbB2OoKw8J7s8UM5YXxx1imR+YKMCwCwtJLZ
	 X5wA6tyye5uNh4r+jbAYkMMxg4n7kiiZHo7zMAj9XdEZIfGq8HqiZFdQCNp0+Kz04t
	 FbkrWyb1/wWuKRFJaHe3ul3XSJU0M+pOHObURO2HDT1BklCL/J8o9PM+Y4GaPrhB9L
	 5jUcPgsYs/oGA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: tj@kernel.org,
	void@manifault.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 3/3] selftests/bpf: test passing iterator to a kfunc
Date: Thu,  8 Aug 2024 16:22:30 -0700
Message-ID: <20240808232230.2848712-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240808232230.2848712-1-andrii@kernel.org>
References: <20240808232230.2848712-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define BPF iterator "getter" kfunc, which accepts iterator pointer as
one of the arguments. Make sure that argument passed doesn't have to be
the very first argument (unlike new-next-destroy combo).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 16 ++++--
 .../selftests/bpf/progs/iters_testmod_seq.c   | 50 +++++++++++++++++++
 2 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 3687a40b61c6..c04b7dec2ab9 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -141,13 +141,12 @@ bpf_testmod_test_mod_kfunc(int i)
 
 __bpf_kfunc int bpf_iter_testmod_seq_new(struct bpf_iter_testmod_seq *it, s64 value, int cnt)
 {
-	if (cnt < 0) {
-		it->cnt = 0;
+	it->cnt = cnt;
+
+	if (cnt < 0)
 		return -EINVAL;
-	}
 
 	it->value = value;
-	it->cnt = cnt;
 
 	return 0;
 }
@@ -162,6 +161,14 @@ __bpf_kfunc s64 *bpf_iter_testmod_seq_next(struct bpf_iter_testmod_seq* it)
 	return &it->value;
 }
 
+__bpf_kfunc s64 bpf_iter_testmod_seq_value(int val, struct bpf_iter_testmod_seq* it__iter)
+{
+	if (it__iter->cnt < 0)
+		return 0;
+
+	return val + it__iter->value;
+}
+
 __bpf_kfunc void bpf_iter_testmod_seq_destroy(struct bpf_iter_testmod_seq *it)
 {
 	it->cnt = 0;
@@ -531,6 +538,7 @@ BTF_KFUNCS_START(bpf_testmod_common_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_testmod_seq_value)
 BTF_ID_FLAGS(func, bpf_kfunc_common_test)
 BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_create, KF_ACQUIRE | KF_RET_NULL)
diff --git a/tools/testing/selftests/bpf/progs/iters_testmod_seq.c b/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
index 3873fb6c292a..4a176e6aede8 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
@@ -12,6 +12,7 @@ struct bpf_iter_testmod_seq {
 
 extern int bpf_iter_testmod_seq_new(struct bpf_iter_testmod_seq *it, s64 value, int cnt) __ksym;
 extern s64 *bpf_iter_testmod_seq_next(struct bpf_iter_testmod_seq *it) __ksym;
+extern s64 bpf_iter_testmod_seq_value(int blah, struct bpf_iter_testmod_seq *it) __ksym;
 extern void bpf_iter_testmod_seq_destroy(struct bpf_iter_testmod_seq *it) __ksym;
 
 const volatile __s64 exp_empty = 0 + 1;
@@ -76,4 +77,53 @@ int testmod_seq_truncated(const void *ctx)
 	return 0;
 }
 
+SEC("?raw_tp")
+__failure
+__msg("expected an initialized iter_testmod_seq as arg #2")
+int testmod_seq_getter_before_bad(const void *ctx)
+{
+	struct bpf_iter_testmod_seq it;
+
+	return bpf_iter_testmod_seq_value(0, &it);
+}
+
+SEC("?raw_tp")
+__failure
+__msg("expected an initialized iter_testmod_seq as arg #2")
+int testmod_seq_getter_after_bad(const void *ctx)
+{
+	struct bpf_iter_testmod_seq it;
+	s64 sum = 0, *v;
+
+	bpf_iter_testmod_seq_new(&it, 100, 100);
+
+	while ((v = bpf_iter_testmod_seq_next(&it))) {
+		sum += *v;
+	}
+
+	bpf_iter_testmod_seq_destroy(&it);
+
+	return sum + bpf_iter_testmod_seq_value(0, &it);
+}
+
+SEC("?socket")
+__success __retval(1000000)
+int testmod_seq_getter_good(const void *ctx)
+{
+	struct bpf_iter_testmod_seq it;
+	s64 sum = 0, *v;
+
+	bpf_iter_testmod_seq_new(&it, 100, 100);
+
+	while ((v = bpf_iter_testmod_seq_next(&it))) {
+		sum += *v;
+	}
+
+	sum *= bpf_iter_testmod_seq_value(0, &it);
+
+	bpf_iter_testmod_seq_destroy(&it);
+
+	return sum;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.5


