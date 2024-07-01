Return-Path: <bpf+bounces-33465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4ED91D7D0
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 07:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3EA280D51
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 05:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591CA45C18;
	Mon,  1 Jul 2024 05:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CyU4xxF2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB92E23A0
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 05:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719813563; cv=none; b=C2lTBYLzQeX/IU7C+bWSp/JWKymJ+ZaimhCSrYGFOGUfzCd76pi1yLoqYf+Cvu+mXRYthUTO57WDGENrhjQLWbY3FG7ocQGuMiPmd1rJURBCoizpohMqavRvdogr6kJ2phKeK6DZlKuRXiBAf6DMuaVMkSqfahAMNaIA49++sf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719813563; c=relaxed/simple;
	bh=+iupi2WsKHKI81C2CYvg5H0Z1rTkqiff2HBJeHnE9eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKspWB3oIzfoHzvoovvXkeIcGkxo/dqPw+tgdwKtmoaSTc3I6EaY83t+ETANTg280B76+Ccn+E176Mq+gDNztZAtvS8RnqDtxhtfJ4j+oOouLq2eOeB/k1ZvNwm5YEvd6Tho8gJlg55QU6iFpRReYfoq0Ta4p3ehwYEPpYCbGgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CyU4xxF2; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so35263981fa.2
        for <bpf@vger.kernel.org>; Sun, 30 Jun 2024 22:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719813559; x=1720418359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAPbadPb6q2VWdhCUW9jshptcILXycSKtDQ/n2o6rdA=;
        b=CyU4xxF25azzOeE01ASxQP9fQxpZhKKY1vbOoj+KQglTbYt/r1LeY9N3mxAC34mtrF
         ZmM6LcGqskkMbCVi7/80dJyh8UhbaBhIIRZ0FGpGfYQuWAPphBXGPUFsYaUef9+G/r5u
         IsJrfh2qUSU731iKTk4j0y1/7Uq6U2UvHKgxo1RZRXQcTX19JelGoUMNb3yL9OokQ9D3
         19K+TUPWzlf53aCn/oazpJDbbbjHFlu5n1RvTPaGuPprmcPsOS0PzmrvZtdz+GtsYgzw
         xI8tmtrKcDsAmdWJu3pPZ1m/KzlIQzzu68NILu0VkeyO9aTQLndwlU2HBe69OQu8vw8Y
         aC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719813559; x=1720418359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAPbadPb6q2VWdhCUW9jshptcILXycSKtDQ/n2o6rdA=;
        b=pSl1rZZGJErYrPCXD9GTSXv3e5VpGtBvuyRj6kmYm3Uo/EPTCiQfrHcxVWsSPxOMZF
         eY+qyjotW/rfm1uvnugjxWLEjtnxOGydiqdNWiyc1p6LLRSWspnErJfcgSXgBV6GsD3L
         ulnhalV/6HkrKvdPMTcAJa6HmU4cMThABNDQrRWCe7WL16Bz0z/NsRd2jrXkLkKZ2R2d
         9UMt4RQZ+ctZ5gJAsc9GdPvUSx5qdTbMDyWGRHrvjgw2BpYdquBs9BrnG7keL/5Ny/ao
         w7fC0U+JgZnUQjUpeip8TUHiljQapa8ZGwdHHZL3Pr74BEZXQlkbCFgg2FNvkKgCe7Gr
         xVCQ==
X-Gm-Message-State: AOJu0YzLzpGJN8ADUyyLbmm8VWI7OnuLxsuTUsDf9xA4fOlUyc/IO0Fs
	waBOVNB5sNvxWjKcW3B/t3JOjXCCg3pWd6fM0bWEUe6Q4SIvDs6asw/TnVl5XG5TbZdFhDPzrr2
	G
X-Google-Smtp-Source: AGHT+IFhi3V2FXdfD1y5FeO5xAFziaS70ukTpq4so0MI7nWIfk5RbmqlNiJ8EQmPfd4FVLi2kbOhxg==
X-Received: by 2002:a2e:b5cd:0:b0:2ec:5073:5814 with SMTP id 38308e7fff4ca-2ee5e380959mr32476181fa.8.1719813559110;
        Sun, 30 Jun 2024 22:59:19 -0700 (PDT)
Received: from localhost ([2401:e180:8841:b02b:633f:bed8:da6:a3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d96cbsm55695155ad.119.2024.06.30.22.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 22:59:18 -0700 (PDT)
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v2 1/2] bpf: use check_add_overflow() to check for addition overflows
Date: Mon,  1 Jul 2024 13:59:04 +0800
Message-ID: <20240701055907.82481-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701055907.82481-1-shung-hsi.yu@suse.com>
References: <20240701055907.82481-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

signed_add*_overflows() was added back when there was no overflow-check
helper. With the introduction of such helpers in commit f0907827a8a91
("compiler.h: enable builtin overflow checkers and add fallback code"), we
can drop signed_add*_overflows() in kernel/bpf/verifier.c and use the
generic check_add_overflow() instead.

This will make future refactoring easier, and takes advantage of
compiler-emitted hardware instructions that efficiently implement these
checks.

After the change GCC 13.3.0 generates cleaner assembly on x86_64:

	err = adjust_scalar_min_max_vals(env, insn, dst_reg, *src_reg);
   13625:	mov    0x28(%rbx),%r9  /*  r9 = src_reg->smin_value */
   13629:	mov    0x30(%rbx),%rcx /* rcx = src_reg->smax_value */
   ...
	if (check_add_overflow(*dst_smin, src_reg->smin_value, dst_smin) ||
   141c1:	mov    %r9,%rax
   141c4:	add    0x28(%r12),%rax
   141c9:	mov    %rax,0x28(%r12)
   141ce:	jo     146e4 <adjust_reg_min_max_vals+0x1294>
	    check_add_overflow(*dst_smax, src_reg->smax_value, dst_smax)) {
   141d4:	add    0x30(%r12),%rcx
   141d9:	mov    %rcx,0x30(%r12)
	if (check_add_overflow(*dst_smin, src_reg->smin_value, dst_smin) ||
   141de:	jo     146e4 <adjust_reg_min_max_vals+0x1294>
   ...
		*dst_smin = S64_MIN;
   146e4:	movabs $0x8000000000000000,%rax
   146ee:	mov    %rax,0x28(%r12)
		*dst_smax = S64_MAX;
   146f3:	sub    $0x1,%rax
   146f7:	mov    %rax,0x30(%r12)

Before the change it gives:

	s64 smin_val = src_reg->smin_value;
     675:	mov    0x28(%rsi),%r8
	s64 smax_val = src_reg->smax_value;
	u64 umin_val = src_reg->umin_value;
	u64 umax_val = src_reg->umax_value;
     679:	mov    %rdi,%rax /* rax = dst_reg */
	if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
     67c:	mov    0x28(%rdi),%rdi /* rdi = dst_reg->smin_value */
	u64 umin_val = src_reg->umin_value;
     680:	mov    0x38(%rsi),%rdx
	u64 umax_val = src_reg->umax_value;
     684:	mov    0x40(%rsi),%rcx
	s64 res = (s64)((u64)a + (u64)b);
     688:	lea    (%r8,%rdi,1),%r9 /* r9 = dst_reg->smin_value + src_reg->smin_value */
	return res < a;
     68c:	cmp    %r9,%rdi
     68f:	setg   %r10b /* r10b = (dst_reg->smin_value + src_reg->smin_value) > dst_reg->smin_value */
	if (b < 0)
     693:	test   %r8,%r8
     696:	js     72b <scalar_min_max_add+0xbb>
	    signed_add_overflows(dst_reg->smax_value, smax_val)) {
		dst_reg->smin_value = S64_MIN;
		dst_reg->smax_value = S64_MAX;
     69c:	movabs $0x7fffffffffffffff,%rdi
	s64 smax_val = src_reg->smax_value;
     6a6:	mov    0x30(%rsi),%r8
		dst_reg->smin_value = S64_MIN;
     6aa:	00 00 00 	movabs $0x8000000000000000,%rsi
	if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
     6b4:	test   %r10b,%r10b /* (dst_reg->smin_value + src_reg->smin_value) > dst_reg->smin_value ? goto 6cb */
     6b7:	jne    6cb <scalar_min_max_add+0x5b>
	    signed_add_overflows(dst_reg->smax_value, smax_val)) {
     6b9:	mov    0x30(%rax),%r10   /* r10 = dst_reg->smax_value */
	s64 res = (s64)((u64)a + (u64)b);
     6bd:	lea    (%r10,%r8,1),%r11 /* r11 = dst_reg->smax_value + src_reg->smax_value */
	if (b < 0)
     6c1:	test   %r8,%r8
     6c4:	js     71e <scalar_min_max_add+0xae>
	if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
     6c6:	cmp    %r11,%r10 /* (dst_reg->smax_value + src_reg->smax_value) <= dst_reg->smax_value ? goto 723 */
     6c9:	jle    723 <scalar_min_max_add+0xb3>
	} else {
		dst_reg->smin_value += smin_val;
		dst_reg->smax_value += smax_val;
	}
     6cb:	mov    %rsi,0x28(%rax)
     ...
     6d5:	mov    %rdi,0x30(%rax)
     ...
	if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
     71e:	cmp    %r11,%r10
     721:	jl     6cb <scalar_min_max_add+0x5b>
		dst_reg->smin_value += smin_val;
     723:	mov    %r9,%rsi
		dst_reg->smax_value += smax_val;
     726:	mov    %r11,%rdi
     729:	jmp    6cb <scalar_min_max_add+0x5b>
		return res > a;
     72b:	cmp    %r9,%rdi
     72e:	setl   %r10b
     732:	jmp    69c <scalar_min_max_add+0x2c>
     737:	nopw   0x0(%rax,%rax,1)

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 94 +++++++++++++------------------------------
 1 file changed, 28 insertions(+), 66 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d3927d819465..26c2b7527942 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12725,26 +12725,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
-static bool signed_add_overflows(s64 a, s64 b)
-{
-	/* Do the add in u64, where overflow is well-defined */
-	s64 res = (s64)((u64)a + (u64)b);
-
-	if (b < 0)
-		return res > a;
-	return res < a;
-}
-
-static bool signed_add32_overflows(s32 a, s32 b)
-{
-	/* Do the add in u32, where overflow is well-defined */
-	s32 res = (s32)((u32)a + (u32)b);
-
-	if (b < 0)
-		return res > a;
-	return res < a;
-}
-
 static bool signed_sub_overflows(s64 a, s64 b)
 {
 	/* Do the sub in u64, where overflow is well-defined */
@@ -13246,21 +13226,15 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		 * added into the variable offset, and we copy the fixed offset
 		 * from ptr_reg.
 		 */
-		if (signed_add_overflows(smin_ptr, smin_val) ||
-		    signed_add_overflows(smax_ptr, smax_val)) {
+		if (check_add_overflow(smin_ptr, smin_val, &dst_reg->smin_value) ||
+		    check_add_overflow(smax_ptr, smax_val, &dst_reg->smax_value)) {
 			dst_reg->smin_value = S64_MIN;
 			dst_reg->smax_value = S64_MAX;
-		} else {
-			dst_reg->smin_value = smin_ptr + smin_val;
-			dst_reg->smax_value = smax_ptr + smax_val;
 		}
-		if (umin_ptr + umin_val < umin_ptr ||
-		    umax_ptr + umax_val < umax_ptr) {
+		if (check_add_overflow(umin_ptr, umin_val, &dst_reg->umin_value) ||
+		    check_add_overflow(umax_ptr, umax_val, &dst_reg->umax_value)) {
 			dst_reg->umin_value = 0;
 			dst_reg->umax_value = U64_MAX;
-		} else {
-			dst_reg->umin_value = umin_ptr + umin_val;
-			dst_reg->umax_value = umax_ptr + umax_val;
 		}
 		dst_reg->var_off = tnum_add(ptr_reg->var_off, off_reg->var_off);
 		dst_reg->off = ptr_reg->off;
@@ -13363,52 +13337,40 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 static void scalar32_min_max_add(struct bpf_reg_state *dst_reg,
 				 struct bpf_reg_state *src_reg)
 {
-	s32 smin_val = src_reg->s32_min_value;
-	s32 smax_val = src_reg->s32_max_value;
-	u32 umin_val = src_reg->u32_min_value;
-	u32 umax_val = src_reg->u32_max_value;
+	s32 *dst_smin = &dst_reg->s32_min_value;
+	s32 *dst_smax = &dst_reg->s32_max_value;
+	u32 *dst_umin = &dst_reg->u32_min_value;
+	u32 *dst_umax = &dst_reg->u32_max_value;
 
-	if (signed_add32_overflows(dst_reg->s32_min_value, smin_val) ||
-	    signed_add32_overflows(dst_reg->s32_max_value, smax_val)) {
-		dst_reg->s32_min_value = S32_MIN;
-		dst_reg->s32_max_value = S32_MAX;
-	} else {
-		dst_reg->s32_min_value += smin_val;
-		dst_reg->s32_max_value += smax_val;
+	if (check_add_overflow(*dst_smin, src_reg->s32_min_value, dst_smin) ||
+	    check_add_overflow(*dst_smax, src_reg->s32_max_value, dst_smax)) {
+		*dst_smin = S32_MIN;
+		*dst_smax = S32_MAX;
 	}
-	if (dst_reg->u32_min_value + umin_val < umin_val ||
-	    dst_reg->u32_max_value + umax_val < umax_val) {
-		dst_reg->u32_min_value = 0;
-		dst_reg->u32_max_value = U32_MAX;
-	} else {
-		dst_reg->u32_min_value += umin_val;
-		dst_reg->u32_max_value += umax_val;
+	if (check_add_overflow(*dst_umin, src_reg->u32_min_value, dst_umin) ||
+	    check_add_overflow(*dst_umax, src_reg->u32_max_value, dst_umax)) {
+		*dst_umin = 0;
+		*dst_umax = U32_MAX;
 	}
 }
 
 static void scalar_min_max_add(struct bpf_reg_state *dst_reg,
 			       struct bpf_reg_state *src_reg)
 {
-	s64 smin_val = src_reg->smin_value;
-	s64 smax_val = src_reg->smax_value;
-	u64 umin_val = src_reg->umin_value;
-	u64 umax_val = src_reg->umax_value;
+	s64 *dst_smin = &dst_reg->smin_value;
+	s64 *dst_smax = &dst_reg->smax_value;
+	u64 *dst_umin = &dst_reg->umin_value;
+	u64 *dst_umax = &dst_reg->umax_value;
 
-	if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
-	    signed_add_overflows(dst_reg->smax_value, smax_val)) {
-		dst_reg->smin_value = S64_MIN;
-		dst_reg->smax_value = S64_MAX;
-	} else {
-		dst_reg->smin_value += smin_val;
-		dst_reg->smax_value += smax_val;
+	if (check_add_overflow(*dst_smin, src_reg->smin_value, dst_smin) ||
+	    check_add_overflow(*dst_smax, src_reg->smax_value, dst_smax)) {
+		*dst_smin = S64_MIN;
+		*dst_smax = S64_MAX;
 	}
-	if (dst_reg->umin_value + umin_val < umin_val ||
-	    dst_reg->umax_value + umax_val < umax_val) {
-		dst_reg->umin_value = 0;
-		dst_reg->umax_value = U64_MAX;
-	} else {
-		dst_reg->umin_value += umin_val;
-		dst_reg->umax_value += umax_val;
+	if (check_add_overflow(*dst_umin, src_reg->umin_value, dst_umin) ||
+	    check_add_overflow(*dst_umax, src_reg->umax_value, dst_umax)) {
+		*dst_umin = 0;
+		*dst_umax = U64_MAX;
 	}
 }
 
-- 
2.45.2


