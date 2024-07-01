Return-Path: <bpf+bounces-33466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5405C91D7D1
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 07:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5651F20EDC
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 05:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B856B482CD;
	Mon,  1 Jul 2024 05:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lyn/h3NW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F250223A0
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 05:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719813567; cv=none; b=MAEc5TYG9VD9VsPVlXo9MjxuISdi6HfmUePsEUzJq8TZQJcs1g5UofVjMJ/iAvnfjJiNUQLDLBYEpYKM7q8cdmVrhJ4NISQus5ic/FizpTHZ0XsHayWpCCnKpwQ9BmCO+stUT04FWXCoNbNg/qclfFjE0KsMUbKfOWMXS7y8q7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719813567; c=relaxed/simple;
	bh=rmewnV3MDnyx52yemwclVH6Pq5K7aqMd2kHXsFcLXRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9XCP0KN2JBdLwVzWZkTa1y81CFgMtrBzEBoh7irQslW0gU4gd+/JWbaaJSpyDUtOgNjcJuQFBQwGYBVkqooeyT9N5dYbu35rHxOBzvVZDN8MuJ1o6QA0DGzTEsWnY01Bj7ZfVaVFlTSQgIt1eYty3EFCJ9gHTK2rvGde+5Whx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lyn/h3NW; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so29498221fa.3
        for <bpf@vger.kernel.org>; Sun, 30 Jun 2024 22:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719813562; x=1720418362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWmH4hDodkDaXchL2xoc6Lj3aRMyLrgtg3l2E1qoMpQ=;
        b=Lyn/h3NW3sgCERVXny83xIil5VJQDK7wOBCZDobc1FTtbPipLGp3nF1NIaCQMGJVhm
         6Zw84qdeKVxtzea2H8WpaCPYEegAI7nJCzf4KGuBRNJDw7a7Mc7AohWx9UGOll8Ok238
         ye/vf9PAojQwKKs2QL8lEeLt8AGaqrTV1bB7lwFtd9OwxkXv24FDNHew6+jsj7ifEZPa
         Y2ElB1SvXF0UY3OCKhGEVDyyqSLdAuED4xHefzD+2D8aLzeE7oswgO2FKp2Y3urqsp+G
         ALYkMhkG1zZmejl3vOGH2/TEBO1IwqEtoU1OhyWH83IYckiuWQwMrBy1XUAWGGnyy/Mk
         ivfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719813562; x=1720418362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWmH4hDodkDaXchL2xoc6Lj3aRMyLrgtg3l2E1qoMpQ=;
        b=X3x9/Y6ef2f/MZvp13hbg7QzRL+V1VIHRdOshrBpUtCD5U589fruxwDM7P2Flwk9Qw
         GiqX+EF8Gsdkwz2S6kS3loH4AuJsRsS5WOPyPyTAhD0HtTWjlOSWvCrvu+0t9RQM9BLO
         OZKtAWMEsjCHiECKEOJb/mk+JNiU78QkligLp0IRm0ngLNmkJgVg+M/C/G4b39JME902
         bcVqhsfGcUPCBewtjJi02ZSSvfF6TiRdBn/BAl6NfaCLb+5b4K3GlKlT6w1V9YNV1Tey
         DC2xw+J8CmAOOs7V2nDYPPHYpqkakb/ZQdcAemFaiMrKvcEw/5x/5YnMiPafJdbmMCx3
         Hemg==
X-Gm-Message-State: AOJu0Yy7hdslW8sPumu/ZWkdiw3Lx132TOfKmHkEm/4v8QXbuGnfKrEU
	w80dZ+HDTKsx/uJMyxJ2bhHO5laCBWttD6Q5Eu6+qH4B0PmBHAcf8HdfM5/nGNw3jpFd6X756Eg
	X
X-Google-Smtp-Source: AGHT+IHTaIULw6plscXj23J805aLCLBpqyyL5ldE9VH/ZmRWVycKTIBLzQyozqxF4w2XnUeHrVTnjg==
X-Received: by 2002:a05:651c:54a:b0:2ec:2314:3465 with SMTP id 38308e7fff4ca-2ee5e345950mr36496281fa.11.1719813562606;
        Sun, 30 Jun 2024 22:59:22 -0700 (PDT)
Received: from localhost ([2401:e180:8841:b02b:633f:bed8:da6:a3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac159ac64sm55410265ad.295.2024.06.30.22.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 22:59:22 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/2] bpf: use check_sub_overflow() to check for subtraction overflows
Date: Mon,  1 Jul 2024 13:59:05 +0800
Message-ID: <20240701055907.82481-3-shung-hsi.yu@suse.com>
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
---
Some bike shedding. For aesthetic symmetry, we can also change unsigned
overflow check for subtraction to

	if (check_sub_overflow(*dst_umin, src_reg->umax_value, dst_umin) ||
	    check_sub_overflow(*dst_umax, src_reg->umin_value, dst_umax)) {
		*dst_umin = 0;
		*dst_umax = U64_MAX;
	}

The 2nd check_sub_overflow(*dst_umax, src_reg->umin_value, dst_umax) is
redundant (though likely don't matter much in terms of performance), but
without that check we technically can't use the value at the dst_umax
pointer. So that, or

	*dst_umax -= src_reg->src_reg->umin_value;
    /* if dst_umin does not overflow we know that dst_umax won't either */
	if (check_sub_overflow(*dst_umin, src_reg->umax_value, dst_umin)) {
		*dst_umin = 0;
		*dst_umax = U64_MAX;
	}

OTOH current unsigned subtraction check already gives pretty clean
assembly right now (see below), so in terms of assembly I don't think
using check_sub_overflow would make much of a difference.

	if (dst_reg->umin_value < umax_val) {
   139ea:	mov    0x38(%r12),%rax
   139ef:	cmp    %r10,%rax
   139f2:	jb     14247 <adjust_reg_min_max_vals+0xe57>
		dst_reg->umax_value -= umin_val;
   139f8:	mov    0x40(%r12),%rdx
   139fd:	mov    0x30(%rsp),%rcx
		dst_reg->umin_value -= umax_val;
   13a02:	sub    %r10,%rax
		dst_reg->umax_value -= umin_val;
   13a05:	sub    %rcx,%rdx
   ...
   13a12:	mov    %rdx,0x40(%r12)
   13a17:	mov    %rax,0x38(%r12)
   ...
		dst_reg->umax_value = U64_MAX;
   14247:	mov    $0xffffffffffffffff,%rdx
		dst_reg->umin_value = 0;
   1424e:	xor    %eax,%eax

---
 kernel/bpf/verifier.c | 57 +++++++++++--------------------------------
 1 file changed, 14 insertions(+), 43 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 26c2b7527942..8417f6187961 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12725,26 +12725,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -13277,14 +13257,11 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
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
@@ -13377,19 +13354,16 @@ static void scalar_min_max_add(struct bpf_reg_state *dst_reg,
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
@@ -13405,19 +13379,16 @@ static void scalar32_min_max_sub(struct bpf_reg_state *dst_reg,
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


