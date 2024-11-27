Return-Path: <bpf+bounces-45722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628629DAADA
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 16:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D725EB22209
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 15:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C5D200120;
	Wed, 27 Nov 2024 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4iQIYzi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622561FF5F8
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721598; cv=none; b=UKGTFsg2vQ5wRjl/XU0xi7p8CTQ48YFf1+3jAd2h7SCv2wSd7gKa7hFiXeSfzrlMVe1kAe8juUW4kGk9doUV1CTSeghXXST7Gox/AJf0sQuyZotu9mT4q++Eq9e/TSX5YVFFmpf6umqCw0KBsDKQgC8Tn+D+EL6HlJ/3fqilCA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721598; c=relaxed/simple;
	bh=LRIHnze/tuJwh0Edu2mYJoN5fmH/KhBc7bfOgRA3U8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pY/DufEb7wKP/EENBBbbBaJgBVFDeAFlLE8jLCLl+yIlSFjeppUCekBLloeI8s+bxC9rWM9J6MpThuP1Q4GFHVFv3sJEPYJ3kkYKeSuY6PlfRVSgOwbhonXXdhxGTV5xCwaevT4AxcG1spTSdn/xoB78A6681WO7BN5iIQkXhqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4iQIYzi; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3824038142aso4440325f8f.2
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 07:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732721594; x=1733326394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qn+I+q5m9l6dM76TziVD0OvhITT1JjlgBm4WfvfTWmU=;
        b=N4iQIYzid+CUI6c1FtoKQatUvfgzSN9PZpSy9tJmTahbabTGLKfgsT3dabkDMHnbWq
         9iZlfi7elf2YCnyXyxEEFj8f/G9JMQtxOGSek8UIfdgJNcot0AvxK5Cpp5igcy+qs+VR
         ATNp3/+FRnei1cJkm54I7QV9U5RUc+Ve3QVWWMRQb7Ot5xSn8wuPxM3GQUHRxAkdNmHn
         W96gFRqOdH/thWH8qfQKkHO1xTwePhC8zJSNpd96GwW+drnwPhk3hJC5FVNrKNTDiBiI
         oPpdB3ETzQbeZ3qb62r8cfr9FeIlivjjTuPiEHv980k6iAsil/6osV40B7K1yk/dqnlI
         xoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732721594; x=1733326394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qn+I+q5m9l6dM76TziVD0OvhITT1JjlgBm4WfvfTWmU=;
        b=Oe4Zon8DoGw3th0QxWXPJrkXfzQTIKTjOPXRjH5QsLi1Xowzp/cmpzKxWJ9YkV8EO+
         OVMD+ui92wr6aid8sOUVNgnK1XvItaSHAhA+9PAM5IO1f0edBAgGqjOIklXF9oK1tq04
         h8+tJD0B6lkkqOmJWUV2ytj1D1vp7+2FKauSQyQPem3F1WqU5C/VPZmGSfIZ0Pm3MvrP
         TLy1UAs6OyciNdHz95J8myPMmdC5R5kxU7DcJoxdxB59aOGQquIPMkODX4F8BqBl6BAP
         hlyQpjqdzhtMn1JE5lisLffLklp7lEibFsyARnCvbjjvDXC+bpX3mTBWhlWcThXWT3I6
         LY6Q==
X-Gm-Message-State: AOJu0Yx9klWvGEzlF0sZHoYZZkIj2aFPJUtCWhnrvYrPUJEfQ5Chy1vy
	qqfDSXC+PtU4ExUD1bOKdg9sKNWVR+Upx8uoBXwYp28JJgKdi6soLtPPmLcqc+I=
X-Gm-Gg: ASbGnct4PNLIxiHsYVayE7i+nEC3/XkK4djibW0/VloGbwP950MDgWA86VXuFEAiHZY
	igpdvyxZEpBekVsLM2Li7T2EZsDv5BavVgEFuwqdD30K4b2xAlePfZ6s41VZhXA9nD5LSiYtkeQ
	z4I6bR2ntrezGoZhacOXbE/wJVD6003lR9cfE5EAtXxOie1YlUA/y+6TzTKZRKKjYuHmeLU2jSY
	26pv7TYDvIbIlx6Lm/upGmGQRlyIYOYnOTBWRE3qG/9fD62c6ERwBEHX3xL7t+N2jEzwEpoFKng
X-Google-Smtp-Source: AGHT+IHy0FCH3B/3uaACUcsntiDPBznWQoY4IfNPPU/Fw8teG4z1D51duDHkTwLTJ1ndpJH1AyqQAg==
X-Received: by 2002:a05:6000:1867:b0:382:50a7:beef with SMTP id ffacd0b85a97d-385c6ebda1emr3102849f8f.24.1732721594329;
        Wed, 27 Nov 2024 07:33:14 -0800 (PST)
Received: from localhost (fwdproxy-cln-003.fbsv.net. [2a03:2880:31ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7a45e4sm24355385e9.4.2024.11.27.07.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:33:13 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 5/7] bpf: Improve verifier log for resource leak on exit
Date: Wed, 27 Nov 2024 07:33:04 -0800
Message-ID: <20241127153306.1484562-6-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127153306.1484562-1-memxor@gmail.com>
References: <20241127153306.1484562-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5787; h=from:subject; bh=LRIHnze/tuJwh0Edu2mYJoN5fmH/KhBc7bfOgRA3U8A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnRztdG5HzoAS0J1Vxcd9Xoymb6GUP0G/6/zCRgFem XMBxHISJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0c7XQAKCRBM4MiGSL8RynQcD/ 9YCeBSyot+IYMv88rSM9CjFoFu8EEesg6VDNrW2wslcJtwZNqj9AilpY2WxlVBT8GDawlZmMz033YF S1kExRz1GjW5wHB0+Knjb6ZkBeXChKZflFX4narKfcggIFVSbm+lXNlMwktXM5cAH24au/9GXiqJW7 VaeYKGXA4h+eV8LWKbK2pS6pE1+vVnLegufldgZ+fN0ENjBFiQzvgk8Rrtdd2K9Hiv0JGwOtfCZwD8 hnamGugq4k37jYDO8iI+UtqCfjZDrbxYU4knI8Fi6DDev8GxBtejo03Lnop7fiFiaHNmFMsrjXb9qR rrYfHdsxcdqRy6gXP4c6jx0K9tRp6oWy/xMCUizr9RNuCiwCOS2Fqlzp2Uxs1FkImwd57/Qp4rGcCE YKod9NFsF42dG+wwJPiXUITIxckGhjTWS8xD8RRs9XPOVtzX2OHUM4gkGPe+v0FToL0sbPyJSbQxOI OGzqrhZYDd0UDBHaev/kvF/fQ/65qubNl0dSIT8JpMbp8jeTMSFa9WoPASJvfrDLbSidgKTrgw4G8F WI9JNmcmBjEBNgUdviahuHSdpYVEZMjLI5LVIQv1iCHdx7CHmGHD9R6X/gNV6qsY+RMeAJQRTWDgho 7YI5HcFg6/cPhdxVoInntE+oyttI6JAYf9s256u7cn9go/UzWyvAYaL5QUHg==
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
index 2ff866749fe7..946bfc114664 100644
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


