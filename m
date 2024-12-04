Return-Path: <bpf+bounces-46052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E95B9E31C8
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 04:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501BF1668A1
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 03:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47F113BC0C;
	Wed,  4 Dec 2024 03:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccbthAhD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF6F126C1E
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 03:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281456; cv=none; b=JDY0JEBsecfqurSuB0mV1OAOsms7p9AIDd9joZ2UOJdYDSD+UcITpYu0q9F1R2sC2bXyi9Hmym1n9w0xWg0YzQxW6MXG3PegDqFQGTILdjemR637EvkLqRt7NbvSfV/plceDBsyZ4OGgG3mo/YWxdU9+74i2hMShfnGa3QztOi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281456; c=relaxed/simple;
	bh=jz4clmOncxLib17b2DjJqNcWHWzrENujw0X43qR3P6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQiVHtbtpuK0K74clHU6R9coJ90R6ZzF6z+wmJe5pLMeDe9VWbKydrzuoBXTU6zsqPZPn7LPNEG4OmNZIcgLT+XhdEn3bZ4M1IYJqjPdOXbnfJwHysuoIorEClyS01Q92HPFOnk8krJMLQaL3Uca6iDUwhKoXvndr/FlMD5c2bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccbthAhD; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43497839b80so40478915e9.2
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 19:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733281452; x=1733886252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5pGGEEG8fKxtViBtuHO4/boa5CwSA2mnjJe5gfkENU=;
        b=ccbthAhDCoGFftWcLHO2dCSH+smHfRmf2wIBuU6HsgVrAGG9scpPtaoruHhBfD+faX
         WvDsee3yoVsfzM+PYfjxCKuFtM7k2akZGe3IRdEjm0jwKT21GX1/9P/x8bqJV0/WqOL8
         8ovuUML/cI+b1Aa50Twa1UIAz3f/o8dZd4GBhUNPUjnEh/fvf5XOb+6+f7Zl5Tjjf0Rm
         h5oLQ8qBPlvM71WRoa63Jir9B4xmEeBdE1PHWZWlyxHh4DAUKBa/E4V6pkfhDGNqvcur
         elY42EpAUu993QOE3fg4A4tlHYUJoI1B7k4AENdSXY25uMAGGL6KbGNyWX02ATcVTlUv
         0hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733281452; x=1733886252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5pGGEEG8fKxtViBtuHO4/boa5CwSA2mnjJe5gfkENU=;
        b=aPiOXVjUl9X5UYBPJafVCda9dHbajY/ksdDIH/sfKUDEKS0DWHxfAtmedpKmNubl8q
         tYOmyyVRB7GJrGh5UtJEMn5ghefVW/yES8LLPphiKpfE7HaUSl2KEqoLDHxOMWHVTIq/
         bTtkdNgiLHD7XCA1Li1a6u2ZuG6hPmmNujtmYIZKNAGS7sfWym8iF1KD7ovI7e/ZRAKx
         ex0Y1e5N68IQrpQXvlquCSrs5uxOUphIvnG0HGYhcwDdZvEEK6Q496hFxV7+6fDYTOgM
         AilWbUf+TZNGoEmlAB9UxOFMh0r7cNBLMiD5RPw+ZHvgFTxVNTg9FYOF+q6BV//6fVen
         x6OQ==
X-Gm-Message-State: AOJu0YzlAcx3QhQPWbPoL4f3v2Kohe+fa23KM7uwTYCaYO5uFIk5amU3
	ztNfyjPb6zlnYDThJK5p8tx+0kxVmNw1qZV3qi4ako2fPJCZo4Qua7Ob3RxkBcw=
X-Gm-Gg: ASbGnctS6NcDF0+T8FObRzZeh4dugKhKQWmPWfc6IHDQ52+Y/ozgdPxlwTaE1xUlZ0C
	aPT4M7qkQeKXyY8yNC3wl3O9Q8VMBXx6MRWF/J9qzTd+xCN1gk/L1esd+zbsYEE+sAdP7PlCapP
	ZhOAwjURoL4laeNO3Z+K9CyN73ZZ/H19sOCKJVcO5nJ10q+/0QtYZNlAnTvO43Bs5dkXs6vdj9s
	/voXnKbpn5kYXP6id2VipcJ2wN8G3aloJoTw5dE29LSEyPUXKdDyqBCNnKCGREQSQc7nnUgL9qe
	7w==
X-Google-Smtp-Source: AGHT+IGVWtvEbqorP4vFIVPK27ORZnGayXSbWdjVHPCD1MTMWV2v/158Sw9qG0ld7AHEOkWJoqm+NA==
X-Received: by 2002:a05:600c:45ce:b0:431:60ec:7a91 with SMTP id 5b1f17b1804b1-434d4100a3fmr19972295e9.2.1733281452429;
        Tue, 03 Dec 2024 19:04:12 -0800 (PST)
Received: from localhost (fwdproxy-cln-035.fbsv.net. [2a03:2880:31ff:23::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbf57sm7586705e9.39.2024.12.03.19.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 19:04:11 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 5/7] bpf: Improve verifier log for resource leak on exit
Date: Tue,  3 Dec 2024 19:03:58 -0800
Message-ID: <20241204030400.208005-6-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204030400.208005-1-memxor@gmail.com>
References: <20241204030400.208005-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5835; h=from:subject; bh=jz4clmOncxLib17b2DjJqNcWHWzrENujw0X43qR3P6Q=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnT8Q/rN0VHGd1yxa35XMLltxvtxQW6a7hY/Xf7Fiy feHQ+D+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0/EPwAKCRBM4MiGSL8RyuNgD/ 43J0WOlbjphdo+8jMqzwvEavSZXW4vczYA49OvqMLd0F8bXZGsp2SzHpClzp4jQKBRCoUW/Pxib6Up nJTSoa0D5YlMb/9RGJrTMyUt9a6xIaqPVV01QhkcFNTuWxtYaOROk2XvrgV6d9rBau7s9wc8dzJZN7 1oG4g3Sf9ZiihFDRHQXDci75vayATi/FDKrDp0UsxDL60UceR4DbhbWlEJiX0Pdi0sINbbZJq04bh3 Mj1P8+komOoAVyXz96PmhQLg2mYslSdBxO2Ye++7USDCgu7hfzQfkzfuk1e4uhJxAhXkB5sGuKT7KC A/SZR5uXiXZATvgfz9+jiAU9ksDkj++JUxyNtFh3wiVJOMQ1sGLQNLG9+pl24PVrVl1swnt8cXaA7f z1Ho0nMM+PaMyR5/Blaw71+Qy+4F2OqmSeetSnShnt+6zKAtSIB3+V7rXzjetcPGW9xR25fRLfsjND d6h1zTVmQgtokydU02IRxErj5FFjyNm3psCkuXC7BV/9xe/XVYL3ndckr10OlAysynXxIxEOXBBQFk sgOvRAKbqSubfxJiDBpJ0AHWnBr9Ne2WsETHPkE6yXQjq1T510cQyRssaQTY5e2M6Y1bkKRMs7dvLp Da0u4dvARqRfzFLqs+QtIkW2HNg+CUg0RBg7aq96UcMt/TtlfE9CgrlDPbwg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The verifier log when leaking resources on BPF_EXIT may be a bit
confusing, as it's a problem only when finally existing from the main
prog, not from any of the subprogs. Hence, update the verifier error
string and the corresponding selftests matching on it.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                              |  2 +-
 .../testing/selftests/bpf/progs/exceptions_fail.c  |  4 ++--
 tools/testing/selftests/bpf/progs/preempt_lock.c   | 14 +++++++-------
 .../selftests/bpf/progs/verifier_spin_lock.c       |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b23f6fddf3af..31e0d33498ac 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19102,7 +19102,7 @@ static int do_check(struct bpf_verifier_env *env)
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


