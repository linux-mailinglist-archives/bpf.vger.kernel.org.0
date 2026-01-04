Return-Path: <bpf+bounces-77774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A79CCF0EDE
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 13:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54B09309DF66
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 12:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CA82E6CD8;
	Sun,  4 Jan 2026 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g06vRdSo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485D82D593C
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529794; cv=none; b=ucN3qYhfUMSz4NzjrTZwIi8J0ynZpD4v++ng0nS9p8zYTe2xpFwGLbzt1d+0afhKCSngX97t0d5GebXCk3WnmmjZbNNlCRd3KNx569x33K+aqLKD+X3Zfl5rvP2V8ReG7Lmr1ttUoJMX8J9Q9M+33f968n2+ieZA6SzTJzMMKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529794; c=relaxed/simple;
	bh=FMOyT2WtoZj5GSbKWSpfrSKT2Ekxp+5FC9qIXMaK4n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUArc0l56tTITTXfOHB7K9hVuBtpgvNDqoJjf2E282YujDvVL3aj/BwBlTbzaFVQJHrS6H/lCGTWGl0XssWaW/QCPo3x5UcfReBILPSqEIhYfQDfHwgu4xagDr3S2gug4iXDQNDq1PkFf7xdbjMt4XUbTxgqmS69Y9HZ13VzWFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g06vRdSo; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-78fb9a67b06so104345397b3.1
        for <bpf@vger.kernel.org>; Sun, 04 Jan 2026 04:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767529792; x=1768134592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pr7tMYsR2JGMfEpVgQtpV39godrpJucmD+wd8yWbP/Q=;
        b=g06vRdSorztjQm3QuQNmBxlX2zUUrp/TykxlMA7+PlztuNu90oPeNCall2jpaFiyVt
         /iNuQbMOmI1FoKSIID8/Amz/CIdVPny/4b8xMylIAXblrmwyE9SO5INWEHrQwwKLkl36
         AhvL7Dp8nNM4h1LlIJ58ZwpLz60HqYgiFkQa3KF+bhZ4qSDS7DxHuNr7rl5yQ/qYfQdq
         ov6LW13Uojkl3O5JiRMbG3WCyY2LMWpty+gcfIUz+z9t60wG6y0bSEoD6301BWb7JfVe
         r8CuHfKJqZb1szYK1bc3+s6nQbCf1KeoWZGH6RR2ZpHBi7ltGums2y69+Ak5GhS2aFGD
         AmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767529792; x=1768134592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pr7tMYsR2JGMfEpVgQtpV39godrpJucmD+wd8yWbP/Q=;
        b=jrnGzaPhKn3RbXKgCzyY4B9TX+t9oKGIqQ+HmZPwu2Fv3wHUMZnkzx6bVKI/hE5FPY
         95INbVqMtKzEKJ6k03RU8YQSFOlIkIHhNi2ePueTSXYXY6D6AEGHBSv81LfBemq+CTEj
         psZToH8iU1xNbjlr9pdehk3cTip+p3twM8annpIIufkw6jrLJQnkvmquawZQvCeIb3+K
         m9U05M3/Z0uXbRd/8CoWpQAoYw2vENCIcehQ1VaULiWMCGxfFObmtPZ5koZPTGlbCPek
         TiioFQgH57fBrWFdbGLe9Wfl1KhPP2O+sGjWHwiB+yK5jCk0IiKzBmmOshYUR6FaY18+
         ys3g==
X-Forwarded-Encrypted: i=1; AJvYcCXyr48U4FudafIaPGj5lmroJ1gEneeRKaqKne2v8o8+vD1yZ+bWDDwNVYb7ssj2oj/ka88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaDHX5M+WjZ3DHntk8cjLLn1WUqc1TetFvJISor8G7e6xZqk5w
	AWo0Rxy57wbHWvOwOc5xLZRGeSjLverLSfa7DUscwGww4mDpfxoTENlh
X-Gm-Gg: AY/fxX6bZ2g/lzLVtoGrYVK7Z7NoM++NKLUO7N/q4b92S9fx6FmKqI2um9jjlzY/qVh
	fJiJVzw8dPQ2D0pJPh3v5eigMbP5hpwsNzxMrkuYKfjX5idMlsx+2D/CHssoLBTx5kYh0CPxxwv
	K0en1Vux71c3mtylbZnXJ1f13jHBhP3ZxXR9av0DN8jcJJJKHncAai9nRyQy8cvj4FME+X3dE5n
	kg9cvqr3S3ZJQBN9fI6MskNO6Nto78KPmwTJI16zRUIOltIlRGR7uSn8rOUNtIBE24jwnn5eZp9
	jEz3y7y2gowDZ4yCqfMA6UncTdzeQ/Q0FGKc1OYd1NwONtNyY1nCFSUpNe3/yoRCSQcBPFSMFyr
	N8G+OFZ5pWOQ7AVKP7JH2aO0gQearu4rgkk7Rs2t3GGMieSBWk++q94N8nROdzE5KmTjgaqS2CE
	Zx/jNGWPCAes2U9gcfSQ==
X-Google-Smtp-Source: AGHT+IFWsPPNOFkmP83/8Tlkyzlfjee4irbLtWjYbMjW/LbqU0v4Eor4AUNnqcQx4oiYMPks/Jfp2Q==
X-Received: by 2002:a05:690c:64ca:b0:78f:86db:bef3 with SMTP id 00721157ae682-78fb3ec89bemr449311957b3.11.1767529792287;
        Sun, 04 Jan 2026 04:29:52 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm175449427b3.12.2026.01.04.04.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 04:29:52 -0800 (PST)
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
Subject: [PATCH bpf-next v6 06/10] bpf,x86: add fsession support for x86_64
Date: Sun,  4 Jan 2026 20:28:10 +0800
Message-ID: <20260104122814.183732-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104122814.183732-1-dongml2@chinatelecom.cn>
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
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


