Return-Path: <bpf+bounces-45766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 339D29DAEFD
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 22:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0CEAB21DCC
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 21:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23C320370C;
	Wed, 27 Nov 2024 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs5tzNl3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84642036EE
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 21:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732743348; cv=none; b=Ndky3ToxzAHMFUS50MtM7HYP8eSqgs94wvKYVsN3CmSSmILG+bF11TDk1sc6YOs3x0rk2GUUu+JBN+sE980RcLfv45A3gnh2ULjoaPP2z3wLvw4oEwTsmKXBO3Z5tQLCJjHjjbnzcAATq6do/Oao8/fdADdEQ0EGDbQvgO5JnyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732743348; c=relaxed/simple;
	bh=AS6RGpUg7SjcvNF28pmCk7E8ajACcP7mIl90yqST/d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ainb+PEMYU0Sd++4dMGu6artNK0IgtyFjvpN1aVUwELKYnwr3Xv7TFa5BocWgB4/1s3Vbm8mvqnsvn2ncTpP/vD9kr0Icj8lEonHPc/N82015DNGecOwzbnshVLWBqC+Z7FQBdDY+8ndisc550r+ajFVlJA9nv1DrHJbmaF10Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hs5tzNl3; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4349cc45219so1004875e9.3
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 13:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732743345; x=1733348145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgMjlVEVk7tVqhgBZ+ffrrUJynt0xwMe4LZjpiGG/NA=;
        b=hs5tzNl3zgi+Ai5TSNJkLmeMLq1gvlSHvRtm5H3TE9a37H676tSNUF90x5yNBVRNkk
         wu+amc0uYyjtuyS5boI7b/uzw1US91QdfRqIV/jtn2VniiY5V5QtCnRLN3WcDunVOnea
         1ShPNkeKVQgbLxbnXiozQr8iiPYpMflfI6pwmUFyLV41AG/y/g0b6phSOwV66dqSVs0G
         OYbTwu6D1GI/PY8d2b2jufZpSrPSVaX22CBAhmooAtKwl05hnXLQI4YGiuDbJ1s8AW5T
         BefQw+Dtn2uxcBP3sSxg6LdhVigXoZILWmAH0sUI4hYnFZlUbgw1n6pBL6gHL+lmBCWo
         chSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732743345; x=1733348145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgMjlVEVk7tVqhgBZ+ffrrUJynt0xwMe4LZjpiGG/NA=;
        b=WwBdnKiRPBEuj43OJVg3U8CCD8+RgysStlMOCDDjnktKrd3YOoliJWnrOd6lkl45Ea
         1bvieMrfHDDRbp9P3sXD20KXTZ7KpmAfi3J/zKVb6+y1pmkkYfg1CPHExAK2kYWdW20v
         9NzKLUWBP5w9e/03PiagQnr2nJmX0DdDenJfsIcyYgKmrO2fn/RncQ1F+0B52sC45zKw
         Do+BupejNYS+2fKviL+SOvKIgl2VRDim+hiRxF4iTDwnGxlbB8NLn3IicVAtkTXhn1p3
         JqOnWUSeKmUF3HJiL2obbobMuOGxcBHrieEKj5/PduRzdrNmMpLOXHlLeO4fiyoqSom9
         booQ==
X-Gm-Message-State: AOJu0YznkBZ1olShQntLI/EHutfE9qm/OSrWPsflOwRYIeSvzsniJcMY
	84ur2JFz1RyUw02DcwTSNKKv5Eec4dtxZPQgcaumWHDQc+piR20nQKFmxn3r03A=
X-Gm-Gg: ASbGncsRrJK6k20CilmL5riQG4dezkLissDGyRPV1cxOybNZIk2/lf0oBI9evz50kai
	nEiKPC1cepEDDCr6OnJOv3IiV+tib2+a/ZQ4t/irc67CbaB5M3WWv0mZ4Eq7NwJL9XPt4s9l1f7
	ih2KG8/2GdzvwfF+aPFLzN1AwO2OqQRxGmwTswyldaB1Yt+kwgMdPiTo6mvVm903MWSNvcy8fPv
	Hp/emM/U4ur4mzfXsvm3x3th+I8TznfGVfMT06EYtbKRYEeJqJOaQ95/+Y3LTnqBsRVvq0xc2N8
X-Google-Smtp-Source: AGHT+IESEC4IxYEsiSGFI7RG98LDQbOFVg5pvsNYFe74y2bTWi4LCmHBKZmVqb+WRfVVeK/51fth2Q==
X-Received: by 2002:a05:600c:4686:b0:434:a923:9313 with SMTP id 5b1f17b1804b1-434a9de55b4mr40037845e9.25.1732743344791;
        Wed, 27 Nov 2024 13:35:44 -0800 (PST)
Received: from localhost (fwdproxy-cln-010.fbsv.net. [2a03:2880:31ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbe40csm1229815e9.10.2024.11.27.13.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:35:43 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 5/7] bpf: Improve verifier log for resource leak on exit
Date: Wed, 27 Nov 2024 13:35:33 -0800
Message-ID: <20241127213535.3657472-6-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127213535.3657472-1-memxor@gmail.com>
References: <20241127213535.3657472-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5787; h=from:subject; bh=AS6RGpUg7SjcvNF28pmCk7E8ajACcP7mIl90yqST/d8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR46uisfmwfl0HO6vr6Ld6iK7fLArMpYJD2/kdwOe Ev/8MqqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0eOrgAKCRBM4MiGSL8RyoRLD/ 9Vw/QC1BtkvgT2ih+fdHl3m8auODgjOlr/85kZpVBnI2pa30iOLeYqmhZ0XHSDnTOjJuNiUgFyE2JE b/8KA75I8oBM4NMgkGOhHPO7X0gWZdJ4etT1wYHggCiFXwC1aMMYtYlkpbhR1fg78OQu7HYYn6Bo/N 66I1pHJubxr/hgsBONcxV41bs81Tx3u2oOKH05noNFKM68iP0+7NSkMqzOKf8Oht32uEByeHyOEmeC K/C9FTnzP06GEy3BpzhsW6h+8MUtaDStULhUK6+K0J0Ey11UftklvdgVB1lrQtJfbILZWCL63GdF9o YiYCXkR17UMLGZeMjGP8PB3Gn8JimQFEH+SeozyyqovvZz+HiV9/FfApJKq9+t1PJS4ahJA22u0r4m +/IUvYd3eB2jKoB4pAc0/RQsllqX7Opf45NT4PS/D+SUMFnLbPaQIp29DR1q7/AfuQpx43gYIz9EEr 9xeU1DhzjGSqUsjmaOPyw+B4DB28SWxzwNJ9l4hm71bFro68I9gh79lyyUXMfkot7UQnpdILpwfh7T Q61m/iboWR4sDmb/99If45lqFmEa2iGTpuUSHwP+5Dc7wxdNwdR9QmsM6HL52EEib+xf/3bhJ85ZcO MzQaOuMTMRrkuwbTJTAmXxRkGlFsLiOgy7STvcLjPbGLyVr4I182vNUPYUUQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The verifier log when leaking resources on BPF_EXIT may be a bit
confusing, as it's a problem only when finally existing from the main
prog, not from any of the subprogs. Hence, update the verifier error
string and the corresponding selftests matching on it.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                              |  2 +-
 .../testing/selftests/bpf/progs/exceptions_fail.c  |  4 ++--
 tools/testing/selftests/bpf/progs/preempt_lock.c   | 14 +++++++-------
 .../selftests/bpf/progs/verifier_spin_lock.c       |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c6b40da49835..b9fdb7e362ca 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19088,7 +19088,7 @@ static int do_check(struct bpf_verifier_env *env)
 				 * match caller reference state when it exits.
 				 */
 				err = check_resource_leak(env, exception_exit, !env->cur_state->curframe,
-							  "BPF_EXIT instruction");
+							  "BPF_EXIT instruction in main prog");
 				if (err)
 					return err;
 
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index fe0f3fa5aab6..8a0fdff89927 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -131,7 +131,7 @@ int reject_subprog_with_lock(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_rcu_read_lock-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_rcu_read_lock-ed region")
 int reject_with_rcu_read_lock(void *ctx)
 {
 	bpf_rcu_read_lock();
@@ -147,7 +147,7 @@ __noinline static int throwing_subprog(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_rcu_read_lock-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_rcu_read_lock-ed region")
 int reject_subprog_with_rcu_read_lock(void *ctx)
 {
 	bpf_rcu_read_lock();
diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
index 885377e83607..5269571cf7b5 100644
--- a/tools/testing/selftests/bpf/progs/preempt_lock.c
+++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
@@ -6,7 +6,7 @@
 #include "bpf_experimental.h"
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_1(struct __sk_buff *ctx)
 {
 	bpf_preempt_disable();
@@ -14,7 +14,7 @@ int preempt_lock_missing_1(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_2(struct __sk_buff *ctx)
 {
 	bpf_preempt_disable();
@@ -23,7 +23,7 @@ int preempt_lock_missing_2(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_3(struct __sk_buff *ctx)
 {
 	bpf_preempt_disable();
@@ -33,7 +33,7 @@ int preempt_lock_missing_3(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_3_minus_2(struct __sk_buff *ctx)
 {
 	bpf_preempt_disable();
@@ -55,7 +55,7 @@ static __noinline void preempt_enable(void)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_1_subprog(struct __sk_buff *ctx)
 {
 	preempt_disable();
@@ -63,7 +63,7 @@ int preempt_lock_missing_1_subprog(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_2_subprog(struct __sk_buff *ctx)
 {
 	preempt_disable();
@@ -72,7 +72,7 @@ int preempt_lock_missing_2_subprog(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_2_minus_1_subprog(struct __sk_buff *ctx)
 {
 	preempt_disable();
diff --git a/tools/testing/selftests/bpf/progs/verifier_spin_lock.c b/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
index 3f679de73229..25599eac9a70 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
@@ -187,7 +187,7 @@ l0_%=:	r6 = r0;					\
 
 SEC("cgroup/skb")
 __description("spin_lock: test6 missing unlock")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_spin_lock-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_spin_lock-ed region")
 __failure_unpriv __msg_unpriv("")
 __naked void spin_lock_test6_missing_unlock(void)
 {
-- 
2.43.5


