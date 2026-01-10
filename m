Return-Path: <bpf+bounces-78469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27471D0D73F
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 15:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EE91308791D
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74255346A1C;
	Sat, 10 Jan 2026 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr3NB1Ou"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27DB34679C
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768054366; cv=none; b=q1dvgBbDhqkweMjsrME+kTVw2EvxFHc1TOJv/dz0Bj3mvUnkubcav48/9w1A0nYfY2lTGRNFXeyT8qO0i8o7rjk/gozgUi1llS1BEe2RkxYGS7Hod4xKfg08Ys2gY6m3nCUsdY6c4x8lJ8Ljtj/yeAJL1fTzLWMWblUclzTTD6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768054366; c=relaxed/simple;
	bh=UKWXQ8lrzEPWgxemDQ6yw1XM1w6GFT2HGNkxpdD4QCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZgbSO0+qw/i686ys/FobdZAGtcilM73hfl5ds7xEBdFvowaNvSi+6rwLMDz9UV46eeSoa5HeWoa54sP5XXBoJgGG1KhjQUI5wLP1CIlIAfxsP1fNjG7tAtA3xhTFmuCJkJJdfzrcTbbcF94FoWoN31f3liREVevQVOKFHHXO3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr3NB1Ou; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-81f4c0e2b42so8014b3a.1
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 06:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768054364; x=1768659164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuDJq9OcqlXOoYELFFiMxpUFbHiZNG+R5rDqqX2qwUQ=;
        b=gr3NB1OuUqE8dhGgStPxbNpGmJCzdiGVIJH0J0Ai2da/zqHsC6FhVyDeExcn04poYh
         wteR8fNdsrrD1fvOtPdNNeqSlCibNDmv7WfiMhAh1GyI4c4n147jsGiBW2s9txPrwQg8
         MB1CNUXRhmEHx5Y+YuOnXNjFoCDD/dphHABmucrk0O8APrjuX7MdTOiMDesPoK1CJF1R
         NumXRbBQ4RffGmUY41CrWnK8x08AnopFAB/w/LEg3dqtCyknD29V2MdkS0cy71w2sHo1
         1GSp2PvMFTuVZ5bx4Vx8iNDO3i/ZJujyQ4m8lxs3Z//26ZVGGy4humW9or8toFg/ZXk2
         Idug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768054364; x=1768659164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cuDJq9OcqlXOoYELFFiMxpUFbHiZNG+R5rDqqX2qwUQ=;
        b=O83xfrBgKEAMconrnKHAPYTz2ZI/2o66WF8dlQYBNIUj0Ku18jOxUz8y1FxehSlLOA
         LMSuQOO92EWyuaDYWHVconDfLlaY+p9HVqutNrIptrWcj4y7PsAtDHbBBvvcBwtwvuJo
         8+ZLFBmpTBV3b90Zppe/Z+eIDD1a9iNFujeiepa03wBTg2ateHmZ1Kgb217FskepcsJI
         r+cQWyc+HteLb4kauqcvGg0FGT+l0opn0Pv+A6Zbt9e7jlc9rbW7Li8OtN5RYuYiYhUC
         G/qJHLNveAdfJWTlg6yrfya2/YAAJ9++7TR9RfeBoT37kGEyZApA6BI7b2kpiekwDicU
         t7tQ==
X-Forwarded-Encrypted: i=1; AJvYcCURsxqIJUApWXvAtfMQCWP6RYLXGdJU6yy7Jwzzc0J8zfnYwvtomHZ7e5DNupNNZkLkdtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRXiJyS2qpmG8KqoeTYE5B02cRa3ycGRfrF4ucV1Ak9PTks5vB
	JZjWapf4wDa4VhumQH0rGLKAIDVmjhwagDoKCzdfu05DzsNnwXK8MzVY
X-Gm-Gg: AY/fxX6t34UqJH1y7S2bR+BdkMx/SuTJDikrE77WnBvivhBGoIt4wKacfDCeJiY13YF
	ebs9QjWzGG0Xjn+qmSgm33y9RYnp4sha+N1yJw68kbUEXOTMGedzeNMKEq48LSBM+VV/42Wk99I
	LJkDQeGgQCUDG0LaBCeUAel0bcAXROYvrwnIp7345Ouowa3RJIvQYZTwOpE6lxnbxQvsjzl19Fu
	540zlQUR5bUhlKhd2WjEe2VCF/lfPwXh5B5EwS1x+rq0LTw/kwDeHgXXoCtheJ+rjHbRAJOaZql
	h+1g9cu8AhKeLDGn+Z23qnXEjmzNypIwqxCbbOpeOL5vCt8lPX4BeXZL6FP3BEXQ1sBT1d55wKV
	wHg+Xse5oLVCOq5LlouOCZJWnDmqxkzEnTtVZyoZSkP7BI/bdMB9wPU+f5j9+PKhfFIisLMSo0v
	dMwOG2fYs=
X-Google-Smtp-Source: AGHT+IFLWfpiux/Kh9OQtDcuqehT+WANU8TvRohmEzGWI5MjMm7PzROsSMC/B8nDbc23kmcVsN6PRw==
X-Received: by 2002:a05:6a00:ad8a:b0:7e8:4587:e8c5 with SMTP id d2e1a72fcca58-81b80cb141cmr11319417b3a.56.1768054364182;
        Sat, 10 Jan 2026 06:12:44 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f42658f03sm1481079b3a.20.2026.01.10.06.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:12:43 -0800 (PST)
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
Subject: [PATCH bpf-next v9 07/11] bpf,x86: add fsession support for x86_64
Date: Sat, 10 Jan 2026 22:11:11 +0800
Message-ID: <20260110141115.537055-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110141115.537055-1-dongml2@chinatelecom.cn>
References: <20260110141115.537055-1-dongml2@chinatelecom.cn>
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
index d94f7038c441..0671a434c00d 100644
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
+			emit_store_stack_imm64(&prog, stack_size + 8, func_meta);
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
+			emit_store_stack_imm64(&prog, cookie_off - 8 * i, 0);
+		/* clear the return value to make sure fentry always get 0 */
+		emit_store_stack_imm64(&prog, 8, 0);
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
+		emit_store_stack_imm64(&prog, nregs_off, func_meta);
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


