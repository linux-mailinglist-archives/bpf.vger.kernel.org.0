Return-Path: <bpf+bounces-34630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8C892F6A5
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 10:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0ED81C227D2
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 08:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E8612DD95;
	Fri, 12 Jul 2024 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q8WErLfp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABA88801
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720771306; cv=none; b=hOAJ8TDe/KWag7WrPfFpPch2pgMtts/nyQp9gO800Vrtwb2DF0HBrHf2yy4eQHnlkmyCkhNO6/JNAfFfV9IHx1SsRZ6j21alWAi3VJfLbp6t8gDo6tp/5laXJNqPlh7ebJQrKN+hAZ1djg9JfbjjP7jRSkaiumW2MKeA1PFCj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720771306; c=relaxed/simple;
	bh=X8tM3iamUt3Yh9KRqu7/OonvmZQYF7aHTzXe2hrAVts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQzDe7Tj3EHRjbWuUnJefOOdh8mYa9wHiQto7Zpz8HSEPxEnkZfcGmDHj9t42roFPErJZITMLURHKBYLyx8MpqffX5z1/dBQSHuNeU2EyL8UmP1RN/eoKqUo3My/+wyhK6634jeKUpVijoY14WHpdWfCagluS/TGUjAsufSakp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q8WErLfp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a728f74c23dso246628266b.1
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 01:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720771302; x=1721376102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uK52txpLfvkMPlRg/xKLVKz51d+lmNCqEmprJzwH3To=;
        b=Q8WErLfpzoUh5Omx6u31/0u6dqkvhMZdbctAdE42p/LX/PIbUOg9I1/HKpOF09dQX9
         DIJ3IOtKlGCIzV1g0H8mHs7f6k2jfr3vJqiKK9wVpoKQ1a2lFWdYX/aOqJYFcVEKC2Ol
         67R9YEe1d0y9Vvkdr8pGbcoaKgf49wj1q7mnX6rC5tR9pf8DD5bMHmSDJKE9Uisr1iv3
         44TlJ6Coedut9nlPJaBxixKmV5v6kXg8/ZAQQqDjhNmWKnu4X7syXKuEEO1tKqfad44T
         cuX+Y6+MOk3mlgcwkZUXXD1RFQOJRRu9h/8VMvatOOjDA1yonQQ1QEVuSDOftxCriTwm
         bVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720771302; x=1721376102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uK52txpLfvkMPlRg/xKLVKz51d+lmNCqEmprJzwH3To=;
        b=rV15/kgE8CdLitgR+Glh4HgFJWf9MLSTUlrsLTYRRtOPv9vwYHxkoBsdbNY0uWA37U
         WNNwLzSkCpEOKe0Ji752lY9sEJpT9NIar/y10t65R3v9BLKRQXNTGPTA6wwRlRPo+9AB
         4oZaH8azTBaUzh5VFNJFnExDm2bHyROjSDf3KlRuPkzBFGNj1enV29hzLBIUYjQ+9ymd
         whYQpEmaf2ck3B7NcRCx5M03YO7IZaZn82LTdOyspp4oJgRG9ffqJQ/9JY33GsCPJLx9
         k9Eg9R6JLQTHt3dgsdxoTKFoGmStlvJpTir2EyFKlGqaNfsf+ow28pnlMHOOWNYmiZfH
         Uc3A==
X-Gm-Message-State: AOJu0Yxx9Vc6W0cLCF3b3C+4/ygGmqswzrDpkgQPy80xswL2Q25cR0qq
	b9qkW8tOHz/j0cw86a7GKKnYIkH2a9t7LRl2PNQgAYXCu6tPFUcm5y9fWCuP7I46CSQGIexkJI3
	AN9M=
X-Google-Smtp-Source: AGHT+IETAm8qBo6b5jF/6kS/rbC0iWteQR+YOmSW/7B2G7VzvVZFGHxcH9fIjnyPGZ5wY7+zuSAlqQ==
X-Received: by 2002:a17:906:408e:b0:a72:7603:49ef with SMTP id a640c23a62f3a-a780b6fee60mr670115166b.35.1720771302204;
        Fri, 12 Jul 2024 01:01:42 -0700 (PDT)
Received: from localhost ([2401:e180:8873:3610:b5e2:cfc7:c3d8:6a2b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438bfa94sm6849873b3a.50.2024.07.12.01.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 01:01:40 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/3] bpf: use check_add_overflow() to check for addition overflows
Date: Fri, 12 Jul 2024 16:01:25 +0800
Message-ID: <20240712080127.136608-3-shung-hsi.yu@suse.com>
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

Note: unlike adjust_ptr_min_max_vals() and scalar*_min_max_add(), it is
necessary to introduce intermediate variable in adjust_jmp_off() to keep
the functional behavior unchanged. Without an intermediate variable
imm/off will be altered even on overflow.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Change since v2:
- Refactor use of signed_add*_overflows() in adjust_jmp_off() and remove
  signed_add16_overflow(), both added in commit 5337ac4c9b80 ("bpf: Fix
  the corner case with may_goto and jump to the 1st insn.")
---
 kernel/bpf/verifier.c | 114 +++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 80 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cf2eb07ddf28..0126c9c80c58 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12726,36 +12726,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
-static bool signed_add16_overflows(s16 a, s16 b)
-{
-	/* Do the add in u16, where overflow is well-defined */
-	s16 res = (s16)((u16)a + (u16)b);
-
-	if (b < 0)
-		return res > a;
-	return res < a;
-}
-
 static bool signed_sub_overflows(s64 a, s64 b)
 {
 	/* Do the sub in u64, where overflow is well-defined */
@@ -13257,21 +13227,15 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
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
@@ -13374,52 +13338,40 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
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
 
@@ -18835,6 +18787,8 @@ static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
 {
 	struct bpf_insn *insn = prog->insnsi;
 	u32 insn_cnt = prog->len, i;
+	s32 imm;
+	s16 off;
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		u8 code = insn->code;
@@ -18846,15 +18800,15 @@ static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
 		if (insn->code == (BPF_JMP32 | BPF_JA)) {
 			if (i + 1 + insn->imm != tgt_idx)
 				continue;
-			if (signed_add32_overflows(insn->imm, delta))
+			if (check_add_overflow(insn->imm, delta, &imm))
 				return -ERANGE;
-			insn->imm += delta;
+			insn->imm = imm;
 		} else {
 			if (i + 1 + insn->off != tgt_idx)
 				continue;
-			if (signed_add16_overflows(insn->off, delta))
+			if (check_add_overflow(insn->off, delta, &off))
 				return -ERANGE;
-			insn->off += delta;
+			insn->off = off;
 		}
 	}
 	return 0;
-- 
2.45.2


