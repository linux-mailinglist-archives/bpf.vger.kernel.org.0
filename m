Return-Path: <bpf+bounces-78183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60636D00ABA
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 03:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29F1A30150FD
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 02:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7177428688D;
	Thu,  8 Jan 2026 02:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRNYeYPC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744222857FA
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 02:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839178; cv=none; b=LmdiMDHMN/8Yp0Vqr/LcM6THgemzINSPzMeJMLvxatja6LxB1525cj0yxJ0BIidu1t7txzMG5VIW2UhJFy2H8+TDr5kkC/LnhPwFyxWNDAcDc19ogdBfyfSyheM9S5Nh2Y92txbHd/bCAXfVKqN/AEeAPzWKXHuYVeO1m2PWqxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839178; c=relaxed/simple;
	bh=XHarCaGaxO4UOuhsLfcJy1QlrtGM5hU6MX1y6/kQaWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9kvCZikBQsIPUKry6k4tVBQHpJAyEsNG2NJzA7uFmuGDQmXSofquaxk84dxU5H1J14/KUIChyCtVovW+j36/vJIc6d5cB+v6SggyKI9mQix9bddTzVflAwNqa45RAIHg/TeGNVN/bakGjzaNHZIILJIx7LszGiXBGqBAls9vd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRNYeYPC; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-6420c08f886so3675862d50.3
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 18:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839175; x=1768443975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngssSFUNq6ZVeh2IW9d/LUmz0anO5RIn1dRAez89M0E=;
        b=jRNYeYPCTZV36MVyBhM2QbDsGL6xJpiOmOW//F8EBOd/vZTzoS8B/zvXndagQ+9deu
         TUtUYv56IkZ2B2MprQPzCN+IXMoX8TGI8rN0NLXiO/tcBwR1yLTlBh1AS2cjRRGbmH3/
         YZ3clLPwnykHobwYkgMiOcmexGiy1ryFFrSG3r+J1obsobBW8h4ZfIPwgylYS91ra91T
         teH8hq2bqH6ByPPrSRhMDxYBM/dbWzkRz9IZUaF+k7JF1Z46dUcDGBposkS9Y7UNLdSG
         0OuHL2NvPff0h+0jeCFGWTFG8SlEFpDBQ8HVXhbYzr9w8ts8zQnSpFOkMszhLSIAJq48
         6+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839175; x=1768443975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ngssSFUNq6ZVeh2IW9d/LUmz0anO5RIn1dRAez89M0E=;
        b=RNWurtHx503Xm9VtaNtJglQNkngJKg8XCyvDX+1rvrN0O6f5fXhO43cqHRfy/YwQHR
         sWgaeWf/LHLkjgieCeR4LUl6EEzBreARnVMxbuCOg54dKky9V/8rMNsD3LC/Mfdw0LdN
         bZjWCPi+p+LTJVGGG4pAiaIXAWfYBiS/OJDFH5jl+PitTVbnRNYdcPZIPmswPURSLXFn
         JxuM69j3KBuh+AraMEl+pv5IYL/1fm9CfvbE5ynJ69HIWt3aD4YQk/s5AfF6nKaU0IMk
         LgaLzjpGm+BjaaFtiee23jNXcrelr2uNWv6zOdXnXNYfVcU/qXNRko3ahDFNTeoZ8Tj2
         VXEA==
X-Forwarded-Encrypted: i=1; AJvYcCWTJptsMswxUDkprMGDaCmq+ea5T+HQs98mS17KlQfzQyDd6D4H5B3O3CZFA+89BtQ0ir8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJyatOsVNyTvPGbT1WxVIJqxZE4KK0x80DULg3IzFlOLIK/3Jz
	dRmoaiFDH+4Lof0CgCPEe9yrvGFVd6PddJ7XhKJk7fsSJHhTfnzsninf
X-Gm-Gg: AY/fxX6XkhZdomQwxZl7u3V4JoTh//R/2NWQOVjNpN0rG25ViHhzkHNWuj5/FzlhjY6
	PIBmudLlu+WtsMqNhGXkOYUmr/flR2V8UVJMOy/fXOR5bsHT6/iSiFFN7WIcDyHYf7LZBWoVf02
	7t1nHcSd7gECSNRaZNnplsPQ/BnPz/EnpGkz0pVTsJ7QL0CA6lnSi4zuSj7MmWe/NANYUVx02Ry
	M0Umsc5ICtZ8kbeaijY/2iH2USysAgSaxZbge6jFIalv7wYp4RcR7WT3pPuCXgtldVWQnU5z432
	M1p1hPnFElCv4hQwHmfsU5oKqeAmpsrBXvYjCB9dwXcCxIT9Sf9KKC+2YlUjOHo/wp0A00jtQMc
	bFmUR4o8FpnEJByydtLZJ+E0U1t2a1mZd960OjzMbcwV7m4hbs3Z/5WJ0kdfksu3NilK/a0WN1L
	jXzyA3t5U=
X-Google-Smtp-Source: AGHT+IHMnVMqZPVaDxTm0y829YCzu+J8Kf2pktn+5NZgmMCz24JmIVyO3P2a8IsNKjk6erI9ANmAxg==
X-Received: by 2002:a05:690e:4106:b0:642:836:f27 with SMTP id 956f58d0204a3-64716c58afbmr4344656d50.44.1767839175262;
        Wed, 07 Jan 2026 18:26:15 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa57deacsm24855027b3.20.2026.01.07.18.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:26:15 -0800 (PST)
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
Subject: [PATCH bpf-next v8 07/11] bpf,x86: add fsession support for x86_64
Date: Thu,  8 Jan 2026 10:24:46 +0800
Message-ID: <20260108022450.88086-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108022450.88086-1-dongml2@chinatelecom.cn>
References: <20260108022450.88086-1-dongml2@chinatelecom.cn>
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
 arch/x86/net/bpf_jit_comp.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a87304161d45..32c13175bc65 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3094,12 +3094,17 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 		      struct bpf_tramp_links *tl, int stack_size,
 		      int run_ctx_off, bool save_ret,
-		      void *image, void *rw_image)
+		      void *image, void *rw_image, u64 func_meta)
 {
 	int i;
 	u8 *prog = *pprog;
 
 	for (i = 0; i < tl->nr_links; i++) {
+		if (tl->links[i]->link.prog->call_session_cookie) {
+			/* 'stack_size + 8' is the offset of func_md in stack */
+			emit_st_r0_imm64(&prog, func_meta, stack_size + 8);
+			func_meta -= (1 << BPF_TRAMP_M_COOKIE);
+		}
 		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
 				    run_ctx_off, save_ret, image, rw_image))
 			return -EINVAL;
@@ -3222,7 +3227,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	void *orig_call = func_addr;
+	int cookie_off, cookie_cnt;
 	u8 **branches = NULL;
+	u64 func_meta;
 	u8 *prog;
 	bool save_ret;
 
@@ -3290,6 +3297,11 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	ip_off = stack_size;
 
+	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
+	/* room for session cookies */
+	stack_size += cookie_cnt * 8;
+	cookie_off = stack_size;
+
 	stack_size += 8;
 	rbx_off = stack_size;
 
@@ -3383,9 +3395,19 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 	}
 
+	if (bpf_fsession_cnt(tlinks)) {
+		/* clear all the session cookies' value */
+		for (int i = 0; i < cookie_cnt; i++)
+			emit_st_r0_imm64(&prog, 0, cookie_off - 8 * i);
+		/* clear the return value to make sure fentry always get 0 */
+		emit_st_r0_imm64(&prog, 0, 8);
+	}
+	func_meta = nr_regs + (((cookie_off - regs_off) / 8) << BPF_TRAMP_M_COOKIE);
+
 	if (fentry->nr_links) {
 		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
-			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image))
+			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image,
+			       func_meta))
 			return -EINVAL;
 	}
 
@@ -3445,9 +3467,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 	}
 
+	/* set the "is_return" flag for fsession */
+	func_meta += (1 << BPF_TRAMP_M_IS_RETURN);
+	if (bpf_fsession_cnt(tlinks))
+		emit_st_r0_imm64(&prog, func_meta, nregs_off);
+
 	if (fexit->nr_links) {
 		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off,
-			       false, image, rw_image)) {
+			       false, image, rw_image, func_meta)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
-- 
2.52.0


