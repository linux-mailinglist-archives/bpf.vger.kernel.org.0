Return-Path: <bpf+bounces-78179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3771D00A83
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 03:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D819303769D
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 02:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA17026ED4F;
	Thu,  8 Jan 2026 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBl9hz2R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782CE23EAA4
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839140; cv=none; b=gVv26uZ1yUevg+jjoRVUmsYyyCQB9IzCBEQ45yJWSI793TA+lIjCG9MLIZnxqYwiOYs5EWqJQKqwkH8JIpbF5hy4L8mbivwNbYCykGcvhSckKFL9CVxuepJXnSqSOgUT9dhyMpzRD8XP3P9M8mbAiEm1EKZ+tvp66HD9jJG3GQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839140; c=relaxed/simple;
	bh=z1FXtwKIRsZptJAyDyFFIRDl2UKWJMd6LDExUnxO6es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ju2Ja1iMzvYoS5NfGv/KXRo4cf/ab4QbPY/iNrdBpQB6NALukY8mnmoqf2DwTLY1ccPUbuO9wfA4Zyc2g2JkBl+WCPD39evRVuDz0kRuTC9W2baph5E3QK07cy6BPMGmPYmwH+pgSrF7A2whcHHpYMuryx6rmolqFD1E9LBXdZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBl9hz2R; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-78fb6c7874cso31684147b3.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 18:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839137; x=1768443937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfGdp4s1hudLP6FKv2EKIaTufWaeCLX1APZrG5rR5Yg=;
        b=BBl9hz2R3dHe/KwrBzwBptXyvRr7B7d6UlZPXiG1aY8zi3zIRx6W4XbdyydO1yM7IE
         VK9c7RILUHxUwl/PeRCpajdngDjXhQODU0CnbMu6IfLfoJJ4NUseE1AOmxG/bLNo7fPE
         RrlMFssmfwXpPI137cWfvqkPI1gmukSCe6oWmI0ZLsaCxZ+bPqW9D7z6ekgO8tX25FNH
         1PylSM6vvYqsLNl22QBUBiRVTFIZXnc5/oJDGTsjjW3tWcaG0RYngUYgdEB5qS4fHI8m
         jPyQJqAwSEX1NRcsslZSWJNgJhxYHGQr1fOYSYS4nTPSAODMQ7kCoRdQE+Et8PA6FWq9
         +XOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839137; x=1768443937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfGdp4s1hudLP6FKv2EKIaTufWaeCLX1APZrG5rR5Yg=;
        b=u2cev9ot506bZOoKThqzrwxVL9VM+FXC8f43jVQdPuhTJCmWaMDFDJJNh6Y5x+cs/3
         yMuyjt8EDn/MRMLViLkmvUpMupovYWfkxULjc+Gb5Bj5yafZMqZuKnLh0m7XtrTS8SEG
         qbFHsrtjAm4z9ROF7rRa9c4qqstoT5LaV8Fv2RYwH+i6x7uNiTgiKL+J33G6Z7uffX8k
         8nUwTVNZ6QpllbVGKKYMdZFy70OT9qOtyprX8AK+2KByR4TsjDt8rm4AWCnbrk0khZbf
         65oqdFa0gvD9naGetiwiXvrpGJ/fQmPQaBssYt2SdB39Bqub02FtrgaJvNfaseA2aeAf
         Kp3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQuiXyz0OxT0vXMc6srUqwi/OE9MR2AAqB9c7BCv+5oyage+5vSr5nZfGEetXas27Zh8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6X3k5z+3Qjnet9bZet+LFoqyAUuuJBKO+g+M8SU/p8rAI0SQf
	zxJKlnfbo0CYGeJhCLsY+joM5mMebWZyQ9paPMRZejjhhOrQtV0wd6wC
X-Gm-Gg: AY/fxX4gTq5XrTKdQtEZPWCqiERCd7abtL6XY5qX/AL1F2DLBVvtc9RQ8vKnew/AnEd
	Ov3qh3KgSUFcMB4G11ehy7Fww85/vnqMxFQQl8dgRWbk2hGUWojJLiC43wEMr27XXdow8j+FQzs
	BzEAoaqgk5MBME9fFsCDWJmOVkedpwZ1NO6QzfZD+Wea9XIxdeWlyF276UdfVaquDk1jxdehjIb
	/KLSac0yYR78gu4yAanRZIfIi41EdkmyhAkhwWXPQi9T9dOoj3kJGu7NR+oDHIkwIW55ZzBZOZt
	fvuuaLMz1w+CAlYXmjU0KC+sbzVy3Gd5QphBrQpvxRGBt6Y1thBcnJ/4/4K1UBvQwiDPjMkprP0
	URCc4j2MY4CMvHAZYqK81X7r6gkFxB1r4LIuCQy1JbBJcrtLIDvA5+F/jfjGStZjXDsi29YKHY+
	NxWGJFbAs=
X-Google-Smtp-Source: AGHT+IHqYMLoVCf2X8X0QJMoLJQnWHLCXx3Yuc6YM1wrrAj6dJa9o4RR5eXnLSarByUc9ac/HaBOTw==
X-Received: by 2002:a05:690c:6012:b0:78d:1136:4e6f with SMTP id 00721157ae682-790b55d3489mr50675527b3.15.1767839137335;
        Wed, 07 Jan 2026 18:25:37 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa57deacsm24855027b3.20.2026.01.07.18.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:25:37 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v8 03/11] bpf: change prototype of bpf_session_{cookie,is_return}
Date: Thu,  8 Jan 2026 10:24:42 +0800
Message-ID: <20260108022450.88086-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108022450.88086-1-dongml2@chinatelecom.cn>
References: <20260108022450.88086-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the function argument of "void *ctx" to bpf_session_cookie() and
bpf_session_is_return(), which is a preparation of the next patch.

The two kfunc is seldom used now, so it will not introduce much effect
to change their function prototype.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/bpf_trace.c                             |  4 ++--
 tools/testing/selftests/bpf/bpf_kfuncs.h             |  4 ++--
 .../bpf/progs/kprobe_multi_session_cookie.c          | 12 ++++++------
 .../selftests/bpf/progs/uprobe_multi_session.c       |  4 ++--
 .../bpf/progs/uprobe_multi_session_cookie.c          | 12 ++++++------
 .../bpf/progs/uprobe_multi_session_recursive.c       |  8 ++++----
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 5f621f0403f8..297dcafb2c55 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3316,7 +3316,7 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 
 __bpf_kfunc_start_defs();
 
-__bpf_kfunc bool bpf_session_is_return(void)
+__bpf_kfunc bool bpf_session_is_return(void *ctx)
 {
 	struct bpf_session_run_ctx *session_ctx;
 
@@ -3324,7 +3324,7 @@ __bpf_kfunc bool bpf_session_is_return(void)
 	return session_ctx->is_return;
 }
 
-__bpf_kfunc __u64 *bpf_session_cookie(void)
+__bpf_kfunc __u64 *bpf_session_cookie(void *ctx)
 {
 	struct bpf_session_run_ctx *session_ctx;
 
diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index e0189254bb6e..dc495cb4c22e 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -79,8 +79,8 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
 				      struct bpf_dynptr *sig_ptr,
 				      struct bpf_key *trusted_keyring) __ksym;
 
-extern bool bpf_session_is_return(void) __ksym __weak;
-extern __u64 *bpf_session_cookie(void) __ksym __weak;
+extern bool bpf_session_is_return(void *ctx) __ksym __weak;
+extern __u64 *bpf_session_cookie(void *ctx) __ksym __weak;
 
 struct dentry;
 /* Description
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
index 0835b5edf685..4981d29e3907 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
@@ -23,16 +23,16 @@ int BPF_PROG(trigger)
 	return 0;
 }
 
-static int check_cookie(__u64 val, __u64 *result)
+static int check_cookie(struct pt_regs *ctx, __u64 val, __u64 *result)
 {
 	__u64 *cookie;
 
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 1;
 
-	cookie = bpf_session_cookie();
+	cookie = bpf_session_cookie(ctx);
 
-	if (bpf_session_is_return())
+	if (bpf_session_is_return(ctx))
 		*result = *cookie == val ? val : 0;
 	else
 		*cookie = val;
@@ -42,17 +42,17 @@ static int check_cookie(__u64 val, __u64 *result)
 SEC("kprobe.session/bpf_fentry_test1")
 int test_kprobe_1(struct pt_regs *ctx)
 {
-	return check_cookie(1, &test_kprobe_1_result);
+	return check_cookie(ctx, 1, &test_kprobe_1_result);
 }
 
 SEC("kprobe.session/bpf_fentry_test1")
 int test_kprobe_2(struct pt_regs *ctx)
 {
-	return check_cookie(2, &test_kprobe_2_result);
+	return check_cookie(ctx, 2, &test_kprobe_2_result);
 }
 
 SEC("kprobe.session/bpf_fentry_test1")
 int test_kprobe_3(struct pt_regs *ctx)
 {
-	return check_cookie(3, &test_kprobe_3_result);
+	return check_cookie(ctx, 3, &test_kprobe_3_result);
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session.c
index 30bff90b68dc..a06c2d7ec022 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_session.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session.c
@@ -51,7 +51,7 @@ static int uprobe_multi_check(void *ctx, bool is_return)
 SEC("uprobe.session//proc/self/exe:uprobe_multi_func_*")
 int uprobe(struct pt_regs *ctx)
 {
-	return uprobe_multi_check(ctx, bpf_session_is_return());
+	return uprobe_multi_check(ctx, bpf_session_is_return(ctx));
 }
 
 static __always_inline bool verify_sleepable_user_copy(void)
@@ -67,5 +67,5 @@ int uprobe_sleepable(struct pt_regs *ctx)
 {
 	if (verify_sleepable_user_copy())
 		uprobe_multi_sleep_result++;
-	return uprobe_multi_check(ctx, bpf_session_is_return());
+	return uprobe_multi_check(ctx, bpf_session_is_return(ctx));
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
index 5befdf944dc6..d916d5017233 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
@@ -13,16 +13,16 @@ __u64 test_uprobe_1_result = 0;
 __u64 test_uprobe_2_result = 0;
 __u64 test_uprobe_3_result = 0;
 
-static int check_cookie(__u64 val, __u64 *result)
+static int check_cookie(struct pt_regs *ctx, __u64 val, __u64 *result)
 {
 	__u64 *cookie;
 
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 1;
 
-	cookie = bpf_session_cookie();
+	cookie = bpf_session_cookie(ctx);
 
-	if (bpf_session_is_return())
+	if (bpf_session_is_return(ctx))
 		*result = *cookie == val ? val : 0;
 	else
 		*cookie = val;
@@ -32,17 +32,17 @@ static int check_cookie(__u64 val, __u64 *result)
 SEC("uprobe.session//proc/self/exe:uprobe_multi_func_1")
 int uprobe_1(struct pt_regs *ctx)
 {
-	return check_cookie(1, &test_uprobe_1_result);
+	return check_cookie(ctx, 1, &test_uprobe_1_result);
 }
 
 SEC("uprobe.session//proc/self/exe:uprobe_multi_func_2")
 int uprobe_2(struct pt_regs *ctx)
 {
-	return check_cookie(2, &test_uprobe_2_result);
+	return check_cookie(ctx, 2, &test_uprobe_2_result);
 }
 
 SEC("uprobe.session//proc/self/exe:uprobe_multi_func_3")
 int uprobe_3(struct pt_regs *ctx)
 {
-	return check_cookie(3, &test_uprobe_3_result);
+	return check_cookie(ctx, 3, &test_uprobe_3_result);
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
index 8fbcd69fae22..d3d682512b69 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
@@ -16,11 +16,11 @@ int idx_return = 0;
 __u64 test_uprobe_cookie_entry[6];
 __u64 test_uprobe_cookie_return[3];
 
-static int check_cookie(void)
+static int check_cookie(struct pt_regs *ctx)
 {
-	__u64 *cookie = bpf_session_cookie();
+	__u64 *cookie = bpf_session_cookie(ctx);
 
-	if (bpf_session_is_return()) {
+	if (bpf_session_is_return(ctx)) {
 		if (idx_return >= ARRAY_SIZE(test_uprobe_cookie_return))
 			return 1;
 		test_uprobe_cookie_return[idx_return++] = *cookie;
@@ -40,5 +40,5 @@ int uprobe_recursive(struct pt_regs *ctx)
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 1;
 
-	return check_cookie();
+	return check_cookie(ctx);
 }
-- 
2.52.0


