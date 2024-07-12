Return-Path: <bpf+bounces-34631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A45792F6A6
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 10:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F552822DF
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 08:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B341713B5A5;
	Fri, 12 Jul 2024 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yr8MtIdn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ADB12FB3C
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720771311; cv=none; b=WLoTaAADGwAF631M9SEZNUxcREHxr7niskiL2FqIHCM/Nm342PXh2KpcxsAfKiVWxOU1sZMimD8GhOkajzPZ0QKepgluIN/x+sfgrf5I8EPyIZTzQ3UHNJo8Q4hoQIDGWS7tDHb6H01I6KbJtvLoTZG7HsPdie49C6fZe/NwR88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720771311; c=relaxed/simple;
	bh=q2crKi91CF8z4iB1wfF/SUbNPXEZvk+LSuEa4FiKy3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmCpusd0uoKlRVs8sRJLrb8V6YaQb+m5JfXz7LWmpSBYnRYI1ucm9Cnpiy7JCkZhNvE77tik23TOihKhFCq1hTRV8i4yAXcGBXPEgVqu+cd7xlU9ZKlf3OjTVrwxeK42VaIfg0Bips1y9G/cvp7GZ1DPd8k21StmpjNvjngMMbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yr8MtIdn; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eeb2d60efbso20199041fa.1
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 01:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720771307; x=1721376107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tu0rD67yYFMjFdOHEvQS2rbGhPRx9HRDC8kVS5gPdn8=;
        b=Yr8MtIdnKXK1nnA9ComMIJbbXYYiyfdDVAkxgFuDpypHk5zOUQvbrrnMFnHmafv7hH
         aSklnpRj+xKJyh19fmfMIcyypVqco7LVrdPjY7TNRNVVxzLPQ+BMByGGLf1D50bJT0t1
         TCr8lLn5isvdgTQ3EyKg/h7qe3IOP7Hx+Vti9DdoZ9qFTiqNlNfpUHhakx60eYjiVNoN
         uj6vOuZ5DxiWYcfJ6MBX15IfzauCx+Wr+cdHzlxMae1dPPBM187oM+Ay8Yy8+yOylzj/
         pgodiTtIy62kYvyYEI/JXS63gdOZe1qQrQSD6onknxtVLOGddiPnrFXkHEUFcZduIAxC
         oxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720771307; x=1721376107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tu0rD67yYFMjFdOHEvQS2rbGhPRx9HRDC8kVS5gPdn8=;
        b=SlCaRRw1E5jPDy55ISyvVXhn9ew+IoGzlz6niSZ00NCg1JgOycoScFGy/NhoIhKfL7
         PEvZTQWFPfONt0b260iAuVmKTOfKGDCvXBKTTNDXWBoZzX/gkp3pU14DGDA7Dqs0Zyze
         Wk+7iptJ3Kxx80XY1eMtesIi1H+TOAn752VWjHmVmdr3FZ1Wos+3dqhPuwEPTPi76xfh
         NB/aFvDeoT0cVrO+1diUzauDbEJH7/kW+BvzADDFSVAtpgg6GXk4WCcnrlDufwBTsx2n
         iXzr74OM01rbS/rR1xmqefOcWpRRcbSIH3gAHgWI3aV199R2jBEW546+l53g/+7A/tzG
         BOEw==
X-Gm-Message-State: AOJu0YysP8U8J5DcAq1bnX68lq1Xn3OGs4s4K6/pO3Xy/NftL6TsdbNX
	s75SYhC6s7yWsCVrHMgmD0gWEobNC377zmKoP6FxwgU8XKkdaDP+5xsuPcIb1KSYBj3GnONoQFW
	GLJc=
X-Google-Smtp-Source: AGHT+IGy9rK9SzYGE8yiUoZdjiHNMLWCPEJZ9EUFbH0BpRM2xCzahtH3Cadu3kwXKgjCou0BYv2HNg==
X-Received: by 2002:a2e:a4ad:0:b0:2ec:3d2e:2408 with SMTP id 38308e7fff4ca-2eeb317175emr69842741fa.33.1720771305792;
        Fri, 12 Jul 2024 01:01:45 -0700 (PDT)
Received: from localhost ([2401:e180:8873:3610:b5e2:cfc7:c3d8:6a2b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad23a6sm61326475ad.281.2024.07.12.01.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 01:01:45 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 3/3] bpf: use check_sub_overflow() to check for subtraction overflows
Date: Fri, 12 Jul 2024 16:01:26 +0800
Message-ID: <20240712080127.136608-4-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240712080127.136608-1-shung-hsi.yu@suse.com>
References: <20240712080127.136608-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to previous patch that drops signed_add*_overflows() and uses
(compiler) builtin-based check_add_overflow(), do the same for
signed_sub*_overflows() and replace them with the generic
check_sub_overflow() to make future refactoring easier and have the
checks implemented more efficiently.

Unsigned overflow check for subtraction does not use helpers and are
simple enough already, so they're left untouched.

After the change GCC 13.3.0 generates cleaner assembly on x86_64:

	if (check_sub_overflow(*dst_smin, src_reg->smax_value, dst_smin) ||
   139bf:	mov    0x28(%r12),%rax
   139c4:	mov    %edx,0x54(%r12)
   139c9:	sub    %r11,%rax
   139cc:	mov    %rax,0x28(%r12)
   139d1:	jo     14627 <adjust_reg_min_max_vals+0x1237>
	    check_sub_overflow(*dst_smax, src_reg->smin_value, dst_smax)) {
   139d7:	mov    0x30(%r12),%rax
   139dc:	sub    %r9,%rax
   139df:	mov    %rax,0x30(%r12)
	if (check_sub_overflow(*dst_smin, src_reg->smax_value, dst_smin) ||
   139e4:	jo     14627 <adjust_reg_min_max_vals+0x1237>
   ...
		*dst_smin = S64_MIN;
   14627:	movabs $0x8000000000000000,%rax
   14631:	mov    %rax,0x28(%r12)
		*dst_smax = S64_MAX;
   14636:	sub    $0x1,%rax
   1463a:	mov    %rax,0x30(%r12)

Before the change it gives:

	if (signed_sub_overflows(dst_reg->smin_value, smax_val) ||
   13a50:	mov    0x28(%r12),%rdi
   13a55:	mov    %edx,0x54(%r12)
		dst_reg->smax_value = S64_MAX;
   13a5a:	movabs $0x7fffffffffffffff,%rdx
   13a64:	mov    %eax,0x50(%r12)
		dst_reg->smin_value = S64_MIN;
   13a69:	movabs $0x8000000000000000,%rax
	s64 res = (s64)((u64)a - (u64)b);
   13a73:	mov    %rdi,%rsi
   13a76:	sub    %rcx,%rsi
	if (b < 0)
   13a79:	test   %rcx,%rcx
   13a7c:	js     145ea <adjust_reg_min_max_vals+0x119a>
	if (signed_sub_overflows(dst_reg->smin_value, smax_val) ||
   13a82:	cmp    %rsi,%rdi
   13a85:	jl     13ac7 <adjust_reg_min_max_vals+0x677>
	    signed_sub_overflows(dst_reg->smax_value, smin_val)) {
   13a87:	mov    0x30(%r12),%r8
	s64 res = (s64)((u64)a - (u64)b);
   13a8c:	mov    %r8,%rax
   13a8f:	sub    %r9,%rax
	return res > a;
   13a92:	cmp    %rax,%r8
   13a95:	setl   %sil
	if (b < 0)
   13a99:	test   %r9,%r9
   13a9c:	js     147d1 <adjust_reg_min_max_vals+0x1381>
		dst_reg->smax_value = S64_MAX;
   13aa2:	movabs $0x7fffffffffffffff,%rdx
		dst_reg->smin_value = S64_MIN;
   13aac:	movabs $0x8000000000000000,%rax
	if (signed_sub_overflows(dst_reg->smin_value, smax_val) ||
   13ab6:	test   %sil,%sil
   13ab9:	jne    13ac7 <adjust_reg_min_max_vals+0x677>
		dst_reg->smin_value -= smax_val;
   13abb:	mov    %rdi,%rax
		dst_reg->smax_value -= smin_val;
   13abe:	mov    %r8,%rdx
		dst_reg->smin_value -= smax_val;
   13ac1:	sub    %rcx,%rax
		dst_reg->smax_value -= smin_val;
   13ac4:	sub    %r9,%rdx
   13ac7:	mov    %rax,0x28(%r12)
   ...
   13ad1:	mov    %rdx,0x30(%r12)
   ...
	if (signed_sub_overflows(dst_reg->smin_value, smax_val) ||
   145ea:	cmp    %rsi,%rdi
   145ed:	jg     13ac7 <adjust_reg_min_max_vals+0x677>
   145f3:	jmp    13a87 <adjust_reg_min_max_vals+0x637>

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/verifier.c | 57 +++++++++++--------------------------------
 1 file changed, 14 insertions(+), 43 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0126c9c80c58..8da132a1ef28 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12726,26 +12726,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
-static bool signed_sub_overflows(s64 a, s64 b)
-{
-	/* Do the sub in u64, where overflow is well-defined */
-	s64 res = (s64)((u64)a - (u64)b);
-
-	if (b < 0)
-		return res < a;
-	return res > a;
-}
-
-static bool signed_sub32_overflows(s32 a, s32 b)
-{
-	/* Do the sub in u32, where overflow is well-defined */
-	s32 res = (s32)((u32)a - (u32)b);
-
-	if (b < 0)
-		return res < a;
-	return res > a;
-}
-
 static bool check_reg_sane_offset(struct bpf_verifier_env *env,
 				  const struct bpf_reg_state *reg,
 				  enum bpf_reg_type type)
@@ -13278,14 +13258,11 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		/* A new variable offset is created.  If the subtrahend is known
 		 * nonnegative, then any reg->range we had before is still good.
 		 */
-		if (signed_sub_overflows(smin_ptr, smax_val) ||
-		    signed_sub_overflows(smax_ptr, smin_val)) {
+		if (check_sub_overflow(smin_ptr, smax_val, &dst_reg->smin_value) ||
+		    check_sub_overflow(smax_ptr, smin_val, &dst_reg->smax_value)) {
 			/* Overflow possible, we know nothing */
 			dst_reg->smin_value = S64_MIN;
 			dst_reg->smax_value = S64_MAX;
-		} else {
-			dst_reg->smin_value = smin_ptr - smax_val;
-			dst_reg->smax_value = smax_ptr - smin_val;
 		}
 		if (umin_ptr < umax_val) {
 			/* Overflow possible, we know nothing */
@@ -13378,19 +13355,16 @@ static void scalar_min_max_add(struct bpf_reg_state *dst_reg,
 static void scalar32_min_max_sub(struct bpf_reg_state *dst_reg,
 				 struct bpf_reg_state *src_reg)
 {
-	s32 smin_val = src_reg->s32_min_value;
-	s32 smax_val = src_reg->s32_max_value;
+	s32 *dst_smin = &dst_reg->s32_min_value;
+	s32 *dst_smax = &dst_reg->s32_max_value;
 	u32 umin_val = src_reg->u32_min_value;
 	u32 umax_val = src_reg->u32_max_value;
 
-	if (signed_sub32_overflows(dst_reg->s32_min_value, smax_val) ||
-	    signed_sub32_overflows(dst_reg->s32_max_value, smin_val)) {
+	if (check_sub_overflow(*dst_smin, src_reg->s32_max_value, dst_smin) ||
+	    check_sub_overflow(*dst_smax, src_reg->s32_min_value, dst_smax)) {
 		/* Overflow possible, we know nothing */
-		dst_reg->s32_min_value = S32_MIN;
-		dst_reg->s32_max_value = S32_MAX;
-	} else {
-		dst_reg->s32_min_value -= smax_val;
-		dst_reg->s32_max_value -= smin_val;
+		*dst_smin = S32_MIN;
+		*dst_smax = S32_MAX;
 	}
 	if (dst_reg->u32_min_value < umax_val) {
 		/* Overflow possible, we know nothing */
@@ -13406,19 +13380,16 @@ static void scalar32_min_max_sub(struct bpf_reg_state *dst_reg,
 static void scalar_min_max_sub(struct bpf_reg_state *dst_reg,
 			       struct bpf_reg_state *src_reg)
 {
-	s64 smin_val = src_reg->smin_value;
-	s64 smax_val = src_reg->smax_value;
+	s64 *dst_smin = &dst_reg->smin_value;
+	s64 *dst_smax = &dst_reg->smax_value;
 	u64 umin_val = src_reg->umin_value;
 	u64 umax_val = src_reg->umax_value;
 
-	if (signed_sub_overflows(dst_reg->smin_value, smax_val) ||
-	    signed_sub_overflows(dst_reg->smax_value, smin_val)) {
+	if (check_sub_overflow(*dst_smin, src_reg->smax_value, dst_smin) ||
+	    check_sub_overflow(*dst_smax, src_reg->smin_value, dst_smax)) {
 		/* Overflow possible, we know nothing */
-		dst_reg->smin_value = S64_MIN;
-		dst_reg->smax_value = S64_MAX;
-	} else {
-		dst_reg->smin_value -= smax_val;
-		dst_reg->smax_value -= smin_val;
+		*dst_smin = S64_MIN;
+		*dst_smax = S64_MAX;
 	}
 	if (dst_reg->umin_value < umax_val) {
 		/* Overflow possible, we know nothing */
-- 
2.45.2


