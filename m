Return-Path: <bpf+bounces-45734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6947A9DAC27
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 17:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E2AB21768
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B309E200BB2;
	Wed, 27 Nov 2024 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgFY6w0N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBFB201013
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732726737; cv=none; b=nZM+raNSqOGPq+iHzDOxC8FUjGrh8yfIquYbDzB8jMYFE7G6X8MICmP/S035F36N3K0rAIc4h4CXTsbFk2CRB/jp41rLBVIdX5ZTHp5cOW7boFkXjpdMYHQ55lfzDaa+plAoFXCX4PvoUJUzLkh9PvlJyrYgU4i77jrhNUxcXAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732726737; c=relaxed/simple;
	bh=AS6RGpUg7SjcvNF28pmCk7E8ajACcP7mIl90yqST/d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsuBpqUwGrgMMCjfQ5Kf9LYIgw6Dp2bI47/r4hyeBSxtMPBSrie23UP1MsIMJ15vgf/A9SrY7eASDFSmi90y3p16INf11bmqOfW0OfptG4Uy3Z2AW2h/gd0cz3ugtK52HY10xij8n3Qb6HfmCB5hXQVDQPn14xmDOzHat11dbbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgFY6w0N; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso31760795e9.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 08:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732726733; x=1733331533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgMjlVEVk7tVqhgBZ+ffrrUJynt0xwMe4LZjpiGG/NA=;
        b=FgFY6w0Niq/vmF0+Uc8N3H2P95VmGizNk6mv3z5x1fdklXRcav4LntPLzIWPinABTe
         0wKWSLAEVufKfaUrULkKsSf09YcVtOPEdKWtiY2ZNp2gnbXBlTvf401k/xDwnq++acX9
         jlLr9YViJ5eFlG6QAEt034WKZLGEu3FwkHd2JcmhbHl0B0VbVM9ZgjOstkjCwcsM+WQw
         jyh5zEmCRWsUSXfELnB0PMc0lshBsw9Z3pIsoCismawjYfHvOm+5wUkxK5psj1OoFhCv
         A5p7iDHi0arjhVxSTfA8RqsSLDc5HBZwVAWYdeNENVevzqWw1owKASCqYZ6kgM5d/Geu
         EaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732726733; x=1733331533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgMjlVEVk7tVqhgBZ+ffrrUJynt0xwMe4LZjpiGG/NA=;
        b=WNEa9uzI+aOaqOYA5BtH7sIhJD1YIHxVXXkhfGHIjZQa+++efMpbJARXXK3/h8wjlR
         OXAoSjdJUvQOoPdIZwsjSz/PoeOs8AvFFQ9nqkVQjw98jnRupAiUdUcyprpqnjbP1akI
         c1I4dRcB+kAn+Kl3kA1bx+ipYByJ2NJQhwJ2MP0bSQRANOrDFSuE0M4x+6cdxouEi4sJ
         SwIMHWje8cGNdMi6tiY2KctKggxqmlrdUqjbtcb0qmAYKPFn1AXgm1wVFAPAx3UG4IQH
         oPEJRzqu1TBjzsngnD7HsoAAwpyjZEribRb5/moTzjroo7E3aTboDI0pLKYDGf3S6co8
         ppyw==
X-Gm-Message-State: AOJu0YycBO2LEyMPsk28VYvkFkASWHLxt7hOqjtK9MfkZxaWjt3Y2Swk
	fw7vqrjJkMbaBX2wrCgknITBf4x6ItOsWzGgMBsQzkZkoV+QEAi3nhAG2kMdaHY=
X-Gm-Gg: ASbGnctniw8ubkXsnAmMYJhwCi/vKdwrZCb86ZZKPm4/P5vJnBRRUGNQ+8T2Oi1gOCc
	rSCo9SBSvSXzVCSg7HY5cI/bA/4RC+CZ2ifC67YQvTJGXNM1a25WsEeMxRTT7+ar+DgC1Aqehpo
	T4n4OpvGMdRq5AfGW4On9lv61aAEEbPr0w4AC2qntj7qt/9ExzHTF3ct7cukSZixSMogiKOjPjl
	OgikibWlfRbDs4RWglQcH6XD2gnO5EnbYpmD+ceG6dayjW1BBGxt9KTYJuGvwhloV7cKgB6E+3L
	iQ==
X-Google-Smtp-Source: AGHT+IEykG0UfCzu4+raTlW1uRiPdnN8iFIhi4WtJSOL/D6lt6eTKt01dT7yvGroQLJP8/nu+asLQA==
X-Received: by 2002:a05:600c:198c:b0:431:52f5:f48d with SMTP id 5b1f17b1804b1-434a9dfee3cmr37034775e9.31.1732726733203;
        Wed, 27 Nov 2024 08:58:53 -0800 (PST)
Received: from localhost (fwdproxy-cln-020.fbsv.net. [2a03:2880:31ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb2683bsm16975624f8f.48.2024.11.27.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:58:52 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 5/7] bpf: Improve verifier log for resource leak on exit
Date: Wed, 27 Nov 2024 08:58:44 -0800
Message-ID: <20241127165846.2001009-6-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127165846.2001009-1-memxor@gmail.com>
References: <20241127165846.2001009-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5787; h=from:subject; bh=AS6RGpUg7SjcvNF28pmCk7E8ajACcP7mIl90yqST/d8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR0+5isfmwfl0HO6vr6Ld6iK7fLArMpYJD2/kdwOe Ev/8MqqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0dPuQAKCRBM4MiGSL8RyjxRD/ 4jKfXVek5l+0vCXlN752wcBHuO4giMjNm7GA6NYjJEoVTJd9WeWWtSkWAfLWYeEfNtRhoW8UfS4G1q 5ZlUR+0xL1bfHtFuCLIPIGFw2z8j8X8sIQFhdYeSEzKIkB53W/6tQ03JkpDfEv4YMcF3i0qqH0Z2ep ZCZuWuKgLysE/t9SKqta2mb0aYYFEpEUbwEMQ4GrenbZqO0wv1HA4WzD9/81sQ0jdJjntvHpWzSUV5 u4jq9LdZ/Ekfy9/r6pzSmEpi3/a7m+C96TQgCa9Cz+0nF2gdXR6+FlYa2ZIAnx7ArzoNci9evSwoS+ 3U0A4CTbbxhYKqJCgy1EOxc0R8xX2ArhJIioIldn5hK8/1f9M2rur1osvBeRJVn20GBQsxPR7ntUl8 ihurLIiqNnTLDl3WCyDMrOfrEOvfrDpNXkbTdZZuyu3qwBT8OKB0Uy6Z1ICJcyoILv1fp+FC0A+DWC UEERXPNEbzECahDQ+iUuYO6towildeixQbUOtekry/3Z9EamHMARJ4AQWwZMdYRdUJFEN6vlc9SNAz bedFpxvGGWsycFsP4SijHlbq4o6CnAE7dCBHLbLcyOZSX8mds3wqVg4T1S7eV6wKs64dFMGrB9c8KU EPpx/b6geGpaL0UXXmBWyDclyLkPzteRolBa88Ms2+JX3rBJA19AT+SKxU0g==
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


