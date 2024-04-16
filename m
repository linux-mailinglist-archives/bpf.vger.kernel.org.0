Return-Path: <bpf+bounces-26949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3128A69F7
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 13:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A411F219C1
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 11:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864CF12A174;
	Tue, 16 Apr 2024 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVaC/7+d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48354129E64;
	Tue, 16 Apr 2024 11:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713268426; cv=none; b=lOm4wrz/GbVPkeC0fJKZmcYM17d/BZN99mtd33YucsJOEcnPTSczEl15GyXVXRp/qg8xjTmUxOOiDJZteJz0AVB8Z9fycPC2Aadrm7puwGTkVyM9u4td/QJRDCdeno4mFRMAwdWZ1K3wmWrGO/M1YfQw/JJviuvYRspet5guc8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713268426; c=relaxed/simple;
	bh=5RxQUoL+OTe9d1Ynqvd0tOUvgJ3NkyjjdNpfOhWHwPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BOkR8fxHIfwuWQ9qVVUKnGFfY1RwtEYSvi0AUnE2AEpv/fKYHB68iljKMu42/qHr00WKoWkQXdKSzvhc1375D+DSS2w9CaaarQ8iJGBixqbBUTM4r/8oQ8dGcQiHNQLeS/Yp0eanK4RziqisNASbm71dYptxsemw18GZygZqKf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVaC/7+d; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4dca51ef1cfso1318937e0c.3;
        Tue, 16 Apr 2024 04:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713268423; x=1713873223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s7v8nQN+HWJPiUsrG6izQsXF7a5r3hQ8/qVVfR22Ufw=;
        b=gVaC/7+drPRQSvtl6N4VR0iPvTcq33OD1ER7Ld8Z+Lcvb8ht9XZqt2GuUxA4E/6BCf
         pnBRyhgksy+W5Gqpxvnstc/BIW/6FpR80pDW2g08Ii1pfaCqvnbgGziI0blq9RXeOSYU
         MPt4wndIkFhBI664qjKZA+vMGQzNqTbSOVIB/+L9G/nAgFNtYCS4w5/tnKu2vvfHZPuY
         nyyXh5Ra4Y6U7rwq41yrW+gr/hw6xBXOcg+OBTshfnS8q3JshSt6d3x5E4f5hrnX20C6
         MiPyJXy7w22NMxhT56e9Scb03+7xEMroQ6skzeDsBSwfhwhZyk80QVEm7M9j0ghvsSYW
         dVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713268423; x=1713873223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7v8nQN+HWJPiUsrG6izQsXF7a5r3hQ8/qVVfR22Ufw=;
        b=r0KybyhlaMAWqqP819VnZiG0tIw9whZMzkqSwc2nkdLIlozAiNJOH+Xx6hUA0z7Ds4
         Kc2XGZqhYaCnAPUMOzF2uTnt6uDMUIHabRTwNx/K7AH1l5QT29U0V2MlDGM4Q9KS74Zd
         p6hp9O8J6buVVbK8VODygGYlGUKBNCNuoFUVlZdtA4YxyqQXrk7MFwPUiyq9LAGlgFr5
         XVObsEeESO8ltwq7i5xjexVxoZYkjo0GMxiHZ8xXZaVFiwH2zv/9Vj9eaRz1qHUGRx5E
         +jIwdYe/7yASQzZmDqbnueJV7h3d2D5Q9sBDKM2FSBTeDV810QPgAUYiFec3IhmFxrY3
         YRIw==
X-Forwarded-Encrypted: i=1; AJvYcCUiR/xdm2wfoFNdn8R7zqNVd0a/Z/OaMUUQA9/4cTzWSOmwzdCrOkubQ8lcP58QutvaxCDZ+US0SD00cooCjX9T7WhwZXP6h4NPoECkZINUVF93sm8jzqKn0+IaOsrLe93H
X-Gm-Message-State: AOJu0YzGhiMDZMdHH9DF6n1yCFCwmAq8vYDe1/22ZQ4s2rwe95geJq8i
	mWPh5Z8v7XsXZZLCBwlNMHAgdHj4gDcCFBZDw87iPg/WoIi8/iYU
X-Google-Smtp-Source: AGHT+IGD/k6XEx7ty/CGbQR2mclQHOq9ejpY7IhehX+8hrDzFWfuh6P+r8shztiWPLHaJHJBpVA19A==
X-Received: by 2002:a05:6122:31a4:b0:4da:a9d8:f719 with SMTP id ch36-20020a05612231a400b004daa9d8f719mr10229681vkb.4.1713268422942;
        Tue, 16 Apr 2024 04:53:42 -0700 (PDT)
Received: from lima-default.myfiosgateway.com (pool-108-50-252-180.nwrknj.fios.verizon.net. [108.50.252.180])
        by smtp.gmail.com with ESMTPSA id qh6-20020a0562144c0600b0069b520a60f3sm6639792qvb.136.2024.04.16.04.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:53:42 -0700 (PDT)
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
To: ast@kernel.org
Cc: harishankar.vishwanathan@rutgers.edu,
	sn624@cs.rutgers.edu,
	sn349@cs.rutgers.edu,
	m.shachnai@rutgers.edu,
	paul@isovalent.com,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 bpf-next] bpf: Harden and/or/xor value tracking
Date: Tue, 16 Apr 2024 07:53:02 -0400
Message-Id: <20240416115303.331688-1-harishankar.vishwanathan@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses a latent unsoundness issue in the
scalar(32)_min_max_and/or/xor functions. While it is not a bugfix, it
ensures that the functions produce sound outputs for all inputs.

The issue occurs in these functions when setting signed bounds. The
following example illustrates the issue for scalar_min_max_and(), but it
applies to the other functions.

In scalar_min_max_and() the following clause is executed when ANDing
positive numbers:

		/* ANDing two positives gives a positive, so safe to
		 * cast result into s64.
		 */
		dst_reg->smin_value = dst_reg->umin_value;
		dst_reg->smax_value = dst_reg->umax_value;

However, if umin_value and umax_value of dst_reg cross the sign boundary
(i.e., if (s64)dst_reg->umin_value > (s64)dst_reg->umax_value), then we
will end up with smin_value > smax_value, which is unsound.

Previous works [1, 2] have discovered and reported this issue. Our tool
Agni [2, 3] consideres it a false positive. This is because, during the
verification of the abstract operator scalar_min_max_and(), Agni restricts
its inputs to those passing through reg_bounds_sync(). This mimics
real-world verifier behavior, as reg_bounds_sync() is invariably executed
at the tail of every abstract operator. Therefore, such behavior is
unlikely in an actual verifier execution.

However, it is still unsound for an abstract operator to set signed bounds
such that smin_value > smax_value. This patch fixes it, making the abstract
operator sound for all (well-formed) inputs.

It is worth noting that while the previous code updated the signed bounds
(using the output unsigned bounds) only when the *input signed* bounds were
positive, the new code updates them whenever the *output unsigned* bounds
do not cross the sign boundary.

An alternative approach to fix this latent unsoundness would be to
unconditionally set the signed bounds to unbounded [S64_MIN, S64_MAX], and
let reg_bounds_sync() refine the signed bounds using the unsigned bounds
and the tnum. We found that our approach produces more precise (tighter)
bounds.

For example, consider these inputs to BPF_AND:

/* dst_reg */
var_off.value: 8608032320201083347
var_off.mask: 615339716653692460
smin_value: 8070450532247928832
smax_value: 8070450532247928832
umin_value: 13206380674380886586
umax_value: 13206380674380886586
s32_min_value: -2110561598
s32_max_value: -133438816
u32_min_value: 4135055354
u32_max_value: 4135055354

/* src_reg */
var_off.value: 8584102546103074815
var_off.mask: 9862641527606476800
smin_value: 2920655011908158522
smax_value: 7495731535348625717
umin_value: 7001104867969363969
umax_value: 8584102543730304042
s32_min_value: -2097116671
s32_max_value: 71704632
u32_min_value: 1047457619
u32_max_value: 4268683090

After going through tnum_and() -> scalar32_min_max_and() ->
scalar_min_max_and() -> reg_bounds_sync(), our patch produces the following
bounds for s32:
s32_min_value: -1263875629
s32_max_value: -159911942

Whereas, setting the signed bounds to unbounded in scalar_min_max_and()
produces:
s32_min_value: -1263875629
s32_max_value: -1

As observed, our patch produces a tighter s32 bound. We also confirmed
using Agni and SMT verification that our patch always produces signed
bounds that are equal to or more precise than setting the signed bounds to
unbounded in scalar_min_max_and().

[1] https://sanjit-bhat.github.io/assets/pdf/ebpf-verifier-range-analysis22.pdf
[2] https://link.springer.com/chapter/10.1007/978-3-031-37709-9_12
[3] https://github.com/bpfverif/agni

---
Changelog:

v3:
	* Removed unused variables

v2:
	* Shortened the if condition that updates the signed bounds. In v1
	it was:

	if (dst_reg->smin_value >= 0 && smin_val >= 0 &&
		(s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
			// update s64 bounds using u64 bounds
	}

	In v2 it was updated to:

	if ((s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
		// update s64 bounds using u64 bounds
	}

	Inside the if, the signed bounds are updated using the unsigned
	bounds. The only case in which this is unsafe is when the unsigned
	bounds cross the sign boundary. The shortened if condition is
	enough to prevent this.

v1:
	https://lore.kernel.org/bpf/20240329030119.29995-1-harishankar.vishwanathan@gmail.com/
---

Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
---
 kernel/bpf/verifier.c | 94 ++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 54 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2aad6d90550f..68cfd6fc6ad4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13320,7 +13320,6 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
 	bool src_known = tnum_subreg_is_const(src_reg->var_off);
 	bool dst_known = tnum_subreg_is_const(dst_reg->var_off);
 	struct tnum var32_off = tnum_subreg(dst_reg->var_off);
-	s32 smin_val = src_reg->s32_min_value;
 	u32 umax_val = src_reg->u32_max_value;
 
 	if (src_known && dst_known) {
@@ -13333,18 +13332,16 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
 	 */
 	dst_reg->u32_min_value = var32_off.value;
 	dst_reg->u32_max_value = min(dst_reg->u32_max_value, umax_val);
-	if (dst_reg->s32_min_value < 0 || smin_val < 0) {
-		/* Lose signed bounds when ANDing negative numbers,
-		 * ain't nobody got time for that.
-		 */
-		dst_reg->s32_min_value = S32_MIN;
-		dst_reg->s32_max_value = S32_MAX;
-	} else {
-		/* ANDing two positives gives a positive, so safe to
-		 * cast result into s64.
-		 */
+
+	/* Safe to set s32 bounds by casting u32 result into s32 when u32
+	 * doesn't cross sign boundary. Otherwise set s32 bounds to unbounded.
+	 */
+	if ((s32)dst_reg->u32_min_value <= (s32)dst_reg->u32_max_value) {
 		dst_reg->s32_min_value = dst_reg->u32_min_value;
 		dst_reg->s32_max_value = dst_reg->u32_max_value;
+	} else {
+		dst_reg->s32_min_value = S32_MIN;
+		dst_reg->s32_max_value = S32_MAX;
 	}
 }
 
@@ -13353,7 +13350,6 @@ static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
 {
 	bool src_known = tnum_is_const(src_reg->var_off);
 	bool dst_known = tnum_is_const(dst_reg->var_off);
-	s64 smin_val = src_reg->smin_value;
 	u64 umax_val = src_reg->umax_value;
 
 	if (src_known && dst_known) {
@@ -13366,18 +13362,16 @@ static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
 	 */
 	dst_reg->umin_value = dst_reg->var_off.value;
 	dst_reg->umax_value = min(dst_reg->umax_value, umax_val);
-	if (dst_reg->smin_value < 0 || smin_val < 0) {
-		/* Lose signed bounds when ANDing negative numbers,
-		 * ain't nobody got time for that.
-		 */
-		dst_reg->smin_value = S64_MIN;
-		dst_reg->smax_value = S64_MAX;
-	} else {
-		/* ANDing two positives gives a positive, so safe to
-		 * cast result into s64.
-		 */
+
+	/* Safe to set s64 bounds by casting u64 result into s64 when u64
+	 * doesn't cross sign boundary. Otherwise set s64 bounds to unbounded.
+	 */
+	if ((s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
 		dst_reg->smin_value = dst_reg->umin_value;
 		dst_reg->smax_value = dst_reg->umax_value;
+	} else {
+		dst_reg->smin_value = S64_MIN;
+		dst_reg->smax_value = S64_MAX;
 	}
 	/* We may learn something more from the var_off */
 	__update_reg_bounds(dst_reg);
@@ -13389,7 +13383,6 @@ static void scalar32_min_max_or(struct bpf_reg_state *dst_reg,
 	bool src_known = tnum_subreg_is_const(src_reg->var_off);
 	bool dst_known = tnum_subreg_is_const(dst_reg->var_off);
 	struct tnum var32_off = tnum_subreg(dst_reg->var_off);
-	s32 smin_val = src_reg->s32_min_value;
 	u32 umin_val = src_reg->u32_min_value;
 
 	if (src_known && dst_known) {
@@ -13402,18 +13395,16 @@ static void scalar32_min_max_or(struct bpf_reg_state *dst_reg,
 	 */
 	dst_reg->u32_min_value = max(dst_reg->u32_min_value, umin_val);
 	dst_reg->u32_max_value = var32_off.value | var32_off.mask;
-	if (dst_reg->s32_min_value < 0 || smin_val < 0) {
-		/* Lose signed bounds when ORing negative numbers,
-		 * ain't nobody got time for that.
-		 */
-		dst_reg->s32_min_value = S32_MIN;
-		dst_reg->s32_max_value = S32_MAX;
-	} else {
-		/* ORing two positives gives a positive, so safe to
-		 * cast result into s64.
-		 */
+
+	/* Safe to set s32 bounds by casting u32 result into s32 when u32
+	 * doesn't cross sign boundary. Otherwise set s32 bounds to unbounded.
+	 */
+	if ((s32)dst_reg->u32_min_value <= (s32)dst_reg->u32_max_value) {
 		dst_reg->s32_min_value = dst_reg->u32_min_value;
 		dst_reg->s32_max_value = dst_reg->u32_max_value;
+	} else {
+		dst_reg->s32_min_value = S32_MIN;
+		dst_reg->s32_max_value = S32_MAX;
 	}
 }
 
@@ -13422,7 +13413,6 @@ static void scalar_min_max_or(struct bpf_reg_state *dst_reg,
 {
 	bool src_known = tnum_is_const(src_reg->var_off);
 	bool dst_known = tnum_is_const(dst_reg->var_off);
-	s64 smin_val = src_reg->smin_value;
 	u64 umin_val = src_reg->umin_value;
 
 	if (src_known && dst_known) {
@@ -13435,18 +13425,16 @@ static void scalar_min_max_or(struct bpf_reg_state *dst_reg,
 	 */
 	dst_reg->umin_value = max(dst_reg->umin_value, umin_val);
 	dst_reg->umax_value = dst_reg->var_off.value | dst_reg->var_off.mask;
-	if (dst_reg->smin_value < 0 || smin_val < 0) {
-		/* Lose signed bounds when ORing negative numbers,
-		 * ain't nobody got time for that.
-		 */
-		dst_reg->smin_value = S64_MIN;
-		dst_reg->smax_value = S64_MAX;
-	} else {
-		/* ORing two positives gives a positive, so safe to
-		 * cast result into s64.
-		 */
+
+	/* Safe to set s64 bounds by casting u64 result into s64 when u64
+	 * doesn't cross sign boundary. Otherwise set s64 bounds to unbounded.
+	 */
+	if ((s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
 		dst_reg->smin_value = dst_reg->umin_value;
 		dst_reg->smax_value = dst_reg->umax_value;
+	} else {
+		dst_reg->smin_value = S64_MIN;
+		dst_reg->smax_value = S64_MAX;
 	}
 	/* We may learn something more from the var_off */
 	__update_reg_bounds(dst_reg);
@@ -13458,7 +13446,6 @@ static void scalar32_min_max_xor(struct bpf_reg_state *dst_reg,
 	bool src_known = tnum_subreg_is_const(src_reg->var_off);
 	bool dst_known = tnum_subreg_is_const(dst_reg->var_off);
 	struct tnum var32_off = tnum_subreg(dst_reg->var_off);
-	s32 smin_val = src_reg->s32_min_value;
 
 	if (src_known && dst_known) {
 		__mark_reg32_known(dst_reg, var32_off.value);
@@ -13469,10 +13456,10 @@ static void scalar32_min_max_xor(struct bpf_reg_state *dst_reg,
 	dst_reg->u32_min_value = var32_off.value;
 	dst_reg->u32_max_value = var32_off.value | var32_off.mask;
 
-	if (dst_reg->s32_min_value >= 0 && smin_val >= 0) {
-		/* XORing two positive sign numbers gives a positive,
-		 * so safe to cast u32 result into s32.
-		 */
+	/* Safe to set s32 bounds by casting u32 result into s32 when u32
+	 * doesn't cross sign boundary. Otherwise set s32 bounds to unbounded.
+	 */
+	if ((s32)dst_reg->u32_min_value <= (s32)dst_reg->u32_max_value) {
 		dst_reg->s32_min_value = dst_reg->u32_min_value;
 		dst_reg->s32_max_value = dst_reg->u32_max_value;
 	} else {
@@ -13486,7 +13473,6 @@ static void scalar_min_max_xor(struct bpf_reg_state *dst_reg,
 {
 	bool src_known = tnum_is_const(src_reg->var_off);
 	bool dst_known = tnum_is_const(dst_reg->var_off);
-	s64 smin_val = src_reg->smin_value;
 
 	if (src_known && dst_known) {
 		/* dst_reg->var_off.value has been updated earlier */
@@ -13498,10 +13484,10 @@ static void scalar_min_max_xor(struct bpf_reg_state *dst_reg,
 	dst_reg->umin_value = dst_reg->var_off.value;
 	dst_reg->umax_value = dst_reg->var_off.value | dst_reg->var_off.mask;
 
-	if (dst_reg->smin_value >= 0 && smin_val >= 0) {
-		/* XORing two positive sign numbers gives a positive,
-		 * so safe to cast u64 result into s64.
-		 */
+	/* Safe to set s64 bounds by casting u64 result into s64 when u64
+	 * doesn't cross sign boundary. Otherwise set s64 bounds to unbounded.
+	 */
+	if ((s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
 		dst_reg->smin_value = dst_reg->umin_value;
 		dst_reg->smax_value = dst_reg->umax_value;
 	} else {
-- 
2.40.1


