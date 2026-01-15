Return-Path: <bpf+bounces-79025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEE3D242C4
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 12:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92F6630C2AF5
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 11:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D8F37B416;
	Thu, 15 Jan 2026 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YarNjgYy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E24376BEE
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476254; cv=none; b=vFBnzSyE51Urv9fUoMg507CZJuCxi0B5Ak/+b9nT8py6yUaeWX9L2BxD65YAjsrutAVkwne38qxq2HbhWT3CNjgokSHsABf8wIXDD0FrpNMyRQKCvBy5VbL0uZs8GIwqaCE3Q9y1ZW09bUsdNelBMVFKuzF0gAnZblnCfzNoZOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476254; c=relaxed/simple;
	bh=Itcaf26Y45P0JIbP0zCWsMUMv9fsLICqg21TFcfGwGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phTTZiGM6kGieBMvfczkoFobdttC0AoVHCcov4vwvKwvBNyZkrEDo/ROQCWCIsptVX/3yOOtZrgnEMMPr++bM3Jwrkz110D1oXZdvuW3aaobVlZfoxDxa5+oUEhtRzzrceJNERQzTCUlUNUcC22hEfPbOVBWvu4J2VdgCgUGLYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YarNjgYy; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a0834769f0so5624775ad.2
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 03:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768476248; x=1769081048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqPghPT79kN2ifffYdZv2FAk43D0a28aw/1itsDYUg8=;
        b=YarNjgYy9gYoOzf/Gy7bXnIz6UNgCYHbsXX0Nhgp9kDcCwFLHpBQFBQy8v/I2XlDjS
         AtbPJvoQKkYXaVvxd/toQslKS7XorFJVkfKcLqYU1m20evWYwZMvZfmLIwKp55LlD4Ub
         yrdoUubicx+HhM2ltUE9oTraThQDf4xu6e/UBL2oU6KOSj391e6O2dlHRh/Dpa96caB8
         gDuBNd4ZxFk35OzCXhTgAP0weEjElVT4FiL+bWapUW97pI1JctvFpPQZXkxQgprfwnL5
         Z5umWvypJ65pUZXGtD36DWy9FACkl5IRAgRhJCms70JIUCRGOwSrL108qBr9pwAmXgFv
         X0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768476248; x=1769081048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rqPghPT79kN2ifffYdZv2FAk43D0a28aw/1itsDYUg8=;
        b=wr2HBlop7PAUBfSqrARF3jYqqV2+9oQQ7Srg+y8RSOm4M/zxYQvy+J0KIO6WbMuekb
         1f1v8x33DfFe1PvMyDE6ZEuPCIKH6lhURsTGem46OtngKyYNcpD6JuNgfs0U0jvLyOLr
         G8u2Ol0VFBTcRKg7yAU290wDmVeCeOeiot3gswCMGzEaNmUEe2g34hucy0XX2ELcHBi6
         uzbteD3wWsMJE0Cr/Hj3IEEleMoNIte5K+O7uJT8wzQxJzmR+JVP0nFOIYdxnI7i0XZh
         CYkCsefosAFYmb8AXKKrxQQU2vYpoGJsO+18azi+CxUmXktTA5TKmrLeDeL06vW3oO+F
         7f4g==
X-Forwarded-Encrypted: i=1; AJvYcCWdEeCVNxlMMHJeLGxAhFEOhlKWJ4BHB2NlTaaAcojjIL64RR42w0AL9BZ4t36lYZhKtzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGBQMyhyEieG0udpdJkU3nZLCD2eDzfvYY0EF/BanSrtDplKWc
	3+eKGwEwu120X2OaAlz0OCuT9f3WVjXDaH1E4LscqId/b8cg9C9EluI+
X-Gm-Gg: AY/fxX6Cpv0I+T990gHAAggR7PxigdzhG0olHiKI3ml6RwP3b4Twm5dM9yXZYaQv7XO
	EobhZLvg31+GA95pvbswj1ytd6nn90R9qAqUPWUYPR4dlCQhRrXqKvlvFVfIIWAbg9PTUVx7YSF
	+0+CLlC17Nk/RBRUcgjltu8qOaMB+HN3jODNP2lCZkx3gdZi47KB08KOS0wPYIrls+5X5QLG0Nl
	5IgyH89TV3VvDROcLAdnSAXJwuZ7Wu5cuIC3O1yAjFgPJpIIMu9YWA16T702fnGsrFEJqORcDMw
	uZLVehAXBLKHPTpAKJ3d4VyD6K3NORY15ysIVac3VZfe7otRTn1kIbwAOR/M90kgUB+/oyTuGEE
	ZCpsasELmDBJpWKqAmVQ5jiGwp6s/ZJqILG/SpYJA25UOwrEOPPVIJn1nBAFQEdNkHBA6EbT/3g
	bWwqQGWew=
X-Received: by 2002:a17:903:283:b0:29e:e925:1abf with SMTP id d9443c01a7336-2a599e4f274mr56245905ad.43.1768476248463;
        Thu, 15 Jan 2026 03:24:08 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3ba03f9sm248523225ad.0.2026.01.15.03.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:24:08 -0800 (PST)
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
Subject: [PATCH bpf-next v10 07/12] bpf,x86: add fsession support for x86_64
Date: Thu, 15 Jan 2026 19:22:41 +0800
Message-ID: <20260115112246.221082-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115112246.221082-1-dongml2@chinatelecom.cn>
References: <20260115112246.221082-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF_TRACE_FSESSION supporting to x86_64, including:

1. clear the return value in the stack before fentry to make the fentry
   of the fsession can only get 0 with bpf_get_func_ret().

2. clear all the session cookies' value in the stack.

2. store the index of the cookie to ctx[-1] before the calling to fsession

3. store the "is_return" flag to ctx[-1] before the calling to fexit of
   the fsession.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v10:
- use "|" for func_meta instead of "+"
- pass the "func_meta_off" to invoke_bpf() explicitly, instead of
  computing it with "stack_size + 8"
- pass the "cookie_off" to invoke_bpf() instead of computing the current
  cookie index with "func_meta"

v5:
- add the variable "func_meta"
- define cookie_off in a new line

v4:
- some adjustment to the 1st patch, such as we get the fsession prog from
  fentry and fexit hlist
- remove the supporting of skipping fexit with fentry return non-zero

v2:
- add session cookie support
- add the session stuff after return value, instead of before nr_args
---
 arch/x86/net/bpf_jit_comp.c | 52 ++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2f31331955b5..16720f2be16c 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3094,13 +3094,19 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
 
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 		      struct bpf_tramp_links *tl, int stack_size,
-		      int run_ctx_off, bool save_ret,
-		      void *image, void *rw_image)
+		      int run_ctx_off, int func_meta_off, bool save_ret,
+		      void *image, void *rw_image, u64 func_meta,
+		      int cookie_off)
 {
-	int i;
+	int i, cur_cookie = (cookie_off - stack_size) / 8;
 	u8 *prog = *pprog;
 
 	for (i = 0; i < tl->nr_links; i++) {
+		if (tl->links[i]->link.prog->call_session_cookie) {
+			emit_store_stack_imm64(&prog, BPF_REG_0, -func_meta_off,
+					       func_meta | (cur_cookie << BPF_TRAMP_SHIFT_COOKIE));
+			cur_cookie--;
+		}
 		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
 				    run_ctx_off, save_ret, image, rw_image))
 			return -EINVAL;
@@ -3218,12 +3224,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 					 void *func_addr)
 {
 	int i, ret, nr_regs = m->nr_args, stack_size = 0;
-	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
+	int regs_off, func_meta_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	void *orig_call = func_addr;
+	int cookie_off, cookie_cnt;
 	u8 **branches = NULL;
+	u64 func_meta;
 	u8 *prog;
 	bool save_ret;
 
@@ -3259,7 +3267,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 *                 [ ...             ]
 	 * RBP - regs_off  [ reg_arg1        ]  program's ctx pointer
 	 *
-	 * RBP - nregs_off [ regs count	     ]  always
+	 * RBP - func_meta_off [ regs count, etc ]  always
 	 *
 	 * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
 	 *
@@ -3282,15 +3290,20 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	stack_size += nr_regs * 8;
 	regs_off = stack_size;
 
-	/* regs count  */
+	/* function matedata, such as regs count  */
 	stack_size += 8;
-	nregs_off = stack_size;
+	func_meta_off = stack_size;
 
 	if (flags & BPF_TRAMP_F_IP_ARG)
 		stack_size += 8; /* room for IP address argument */
 
 	ip_off = stack_size;
 
+	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
+	/* room for session cookies */
+	stack_size += cookie_cnt * 8;
+	cookie_off = stack_size;
+
 	stack_size += 8;
 	rbx_off = stack_size;
 
@@ -3358,8 +3371,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	/* mov QWORD PTR [rbp - rbx_off], rbx */
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
 
+	func_meta = nr_regs;
 	/* Store number of argument registers of the traced function */
-	emit_store_stack_imm64(&prog, BPF_REG_0, -nregs_off, nr_regs);
+	emit_store_stack_imm64(&prog, BPF_REG_0, -func_meta_off, func_meta);
 
 	if (flags & BPF_TRAMP_F_IP_ARG) {
 		/* Store IP address of the traced function */
@@ -3378,9 +3392,18 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 	}
 
+	if (bpf_fsession_cnt(tlinks)) {
+		/* clear all the session cookies' value */
+		for (int i = 0; i < cookie_cnt; i++)
+			emit_store_stack_imm64(&prog, BPF_REG_0, -cookie_off + 8 * i, 0);
+		/* clear the return value to make sure fentry always get 0 */
+		emit_store_stack_imm64(&prog, BPF_REG_0, -8, 0);
+	}
+
 	if (fentry->nr_links) {
-		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
-			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image))
+		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off, func_meta_off,
+			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image,
+			       func_meta, cookie_off))
 			return -EINVAL;
 	}
 
@@ -3440,9 +3463,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 	}
 
+	/* set the "is_return" flag for fsession */
+	func_meta |= (1ULL << BPF_TRAMP_SHIFT_IS_RETURN);
+	if (bpf_fsession_cnt(tlinks))
+		emit_store_stack_imm64(&prog, BPF_REG_0, -func_meta_off, func_meta);
+
 	if (fexit->nr_links) {
-		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off,
-			       false, image, rw_image)) {
+		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off, func_meta_off,
+			       false, image, rw_image, func_meta, cookie_off)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
-- 
2.52.0


