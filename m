Return-Path: <bpf+bounces-78465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 659E1D0D714
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 15:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34E3B3047664
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 14:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400F7346A00;
	Sat, 10 Jan 2026 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLfJvHwu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F2634679C
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768054324; cv=none; b=JEqF5Vzo5gnC0+ukJDrPRwnpWEJHUJe3FUF1eE+ZK5+IXKWYKNxaYD90IriLlCSt+f5WUmN1sr9hpF2oZNYOUSTu6+TqhUnnZBie270bpu24DmIbk8BYfZQny/W+kW31u9ROzBB6asV6UmSafFW+UmW5wppgxcBsEN+841voWnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768054324; c=relaxed/simple;
	bh=z1FXtwKIRsZptJAyDyFFIRDl2UKWJMd6LDExUnxO6es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVWqlblzXq81+jaCpg3FC/KGdVXqb02mM9VORMRepQhAdLgjw2uaSMA7CKQCgRCIc2CAepSb9uMNkbfxoKfccgRPA2T69fmYzoPtAbzvH0LjEnwXl0A5d22Hs3v95cVUkA5zQWXk91tgfeRa7wSG4Q2xpYnMlppUbvVxgDSmwCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLfJvHwu; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-81e8b1bdf0cso662397b3a.3
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 06:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768054323; x=1768659123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfGdp4s1hudLP6FKv2EKIaTufWaeCLX1APZrG5rR5Yg=;
        b=VLfJvHwuVzL8rMClvJO4I5YzXw56cMFux6mA6esQenvUKdNhEMuGcaVtTSzlm8PDgz
         0zU9L5jMuaEMSppIGRu1lPCH+TTRRhG+MNukGOR2VXJLddLd0V9dzx36TDfbKOCEdGa4
         6emDqiGEsIWX610qkSHRpYc6NrAPR4NnkupB3d6MeUMRzgrB7ES9yM80vxaXvjoO+6Cv
         yrX2oHQxjat6APAbYiCUovf/5Aa1N4JYrzyBzwwziU9xLhfVbWG5dI9Hq5DVRcXBRCSq
         vo5IUaMAp4bvFCeNEcwU2/AAGlgUMg7xX2hiHzzUSjgChqNowuJiK1JnuncJtEAz4rr6
         fYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768054323; x=1768659123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfGdp4s1hudLP6FKv2EKIaTufWaeCLX1APZrG5rR5Yg=;
        b=Mb3haryI6ZLMY48j2vZM3B2S0KY2d6p+KNGtdqOK9WtSUNdZd67M9g41YMzzVyucLi
         JvXY8Z8+W5Z1byBXGopfZZLWW8p+xfuqYWjawiw/Uq1xo0s8pD/P5UJRUdC9U+b6h4Xn
         E9n1AKS5U0m2i1Bye1zEpsPAJ2EkY9eGm24IB7/g9P7vyUDkYXho6u9kzWq8wbmQTu5u
         8r6sBeE1t3KO21vGURbJHh3Ep32OBXR2aujd6jcrluLsx4sLbnRl9Mu/XMOfehXIhWL2
         V+0lUTdDxIgYP/NiS14c41nRb/h7x+o17vpencTMFzRIB0xMhpjjGwpYk9yRFSxVH8wO
         jfXA==
X-Forwarded-Encrypted: i=1; AJvYcCXVgZfy+/pJaGL3ix4xQXpi2hjPFGS2AZR/uDWO4X0L9mBB5oyQzFhGn4fzvZjoR9UPKoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ogOTcjDi6OahWG3PSFpP/HVP9heMYs8TY134NP82O2OOU71N
	O/Wtd0HHbWn7pEQNG6mNh1l6KJ1CqFhvcnIz7Je5yXJFprgXLGXJUNYD
X-Gm-Gg: AY/fxX5pQv9CgZdzILRapBwq7l3Zp/8hoD2/Ox4NMdN2ghsPhl2XR/COKtUsH0qEQQY
	FnWZqEJF1WyRbZniMlOz6vjthvqMRkDws4dwWe92AL0sVXM+pyrFkqjCvbPat8ixwaDE8Y0fbz6
	4UZh3GMZB8ZM0X98kRwq7522rD0QhimRFhuJ9qmM7BlAALFCVVZ35JnFr22Y6JRSDa5FChFQhPk
	l1DGKuES+EvbOVn7ijmx9Lt7rJVsUGpltGwAOLUpBCYqX8nMpLzXbWklNHS2NG2UiKJKB6B0g9a
	zijaVQeQO3uteSx+aQZfIHXjpmXcp5LZt3+vA5WuV8+vClPeai599Hiu8u0H29mRgTLnSRjJU7H
	WNBKSAj6mo9rpA/UjAiieeCSp8oDLtwhhe4htmf16Q/mN//5pauh+lyGXkio4kIB/dGHbOOmE2H
	23fq6g7VA=
X-Google-Smtp-Source: AGHT+IHFsjOI9vY+1n9I9bmJ5B1pg0vIMAkiVFjV3qYORsRqw9CiS1Ot3VqYNtj2DaTbLEq8lAlYZQ==
X-Received: by 2002:a05:6a00:4305:b0:7b9:7f18:c716 with SMTP id d2e1a72fcca58-81b7eb28136mr12520935b3a.1.1768054322695;
        Sat, 10 Jan 2026 06:12:02 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f42658f03sm1481079b3a.20.2026.01.10.06.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:12:02 -0800 (PST)
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
Subject: [PATCH bpf-next v9 03/11] bpf: change prototype of bpf_session_{cookie,is_return}
Date: Sat, 10 Jan 2026 22:11:07 +0800
Message-ID: <20260110141115.537055-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110141115.537055-1-dongml2@chinatelecom.cn>
References: <20260110141115.537055-1-dongml2@chinatelecom.cn>
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


