Return-Path: <bpf+bounces-76850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D132CC6EC2
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 10:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DFF6305AE79
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 09:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A42F34105B;
	Wed, 17 Dec 2025 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fbkszo+i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B733D50E
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965329; cv=none; b=dDhY5xjAtG4OkuiRlcNKX/JHFNO64oEBuk0z8ma1VX22eNwzsTcWJZAsAcj2Ol6Q4Q+Y89RTSxivgMdmYxSEY2PVkSYey8Uj/DfWnsGlsvLt38vL54rbeszWlUGGmZf21BwMpxEv6F6TZpbrIkY04zkU3mEb/Q1AajJH+V3iAN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965329; c=relaxed/simple;
	bh=8UjztYwJ3V5glcGLXb6BENiANc0oStuVeMSUdlMadWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiG8JR31u4X+qTL/TQAhMHiRyHpFJyrdXKAA8prvQlOmibe6qrwmFyI14chRl24DKBbyAcixS7e/JD84kS0e1twqhtn1X82H2qcoKcT/loJz5ampkBwXPQ3zrvOTQOdbZ7wrq8V0URKd9XQeKwahJldbNRgf/IasLByRcO8xoo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fbkszo+i; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a0ac29fca1so34937715ad.2
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 01:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765965327; x=1766570127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYyVRjly71IVaO9XpSMOkg3chszPFkxF2ByaNmXFw0U=;
        b=Fbkszo+iU6QUDZU9moPXyAruR9ZREYm1i8fjwUcaCiDoWdKXKmYw8bOm1T032GmC/T
         JNRR+1f4IYSE7FP4UEsbVUBRqEy8fl24BrMu2EnUBWG5GzYB5vqc2RVOWJZVnSi5nFUR
         I2KKkHweTuYcOtpbZD9YZeb2MGdqcMBO9QZNytUj0minXz8FJWnO4H3+AjYJQCMftoh6
         +1QGjhUdMXER33v9O40gD/JCxtVrPmt0anrJ0qqE15dUSw7UO4izjCd9GBJmtRsz2bFV
         EPkYuRTQudx7NceiwuUCU0GfQ/PvOVIrtFnqOV/zdfFuH7APzM785tz+Y30KqpMr01jp
         tnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765965327; x=1766570127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zYyVRjly71IVaO9XpSMOkg3chszPFkxF2ByaNmXFw0U=;
        b=vVJiNLKvTZRMY7XXzjtT9purnVTTU+z2YbCaGdTG4p0zwRxtb5kh7QvWXRiS9cEtqr
         E9USJMkKXRL0WsBBMtEufZQFmeD/ZBGHtjHYqSUgb/lL4UCJlimVwQCM+wzALCnparXY
         bFkltChPwXsbQRNX9Y01fqGy5X2cPaMOi7Y2E29ObiTKcemsZ3cJ29dEcSH2xT9sYDOp
         Wim/hNMROdMV30KZUHxnVBRZpoKNtjdoDEabyRvnMXcA0CLlAmtobdQB73jxzfTPyQ48
         +AJUzsDa91QzHK+zCMXl/wCISw6GQejWyH3U+j9/7pUvFGL5So1ckpQ57l3h0MCWdbkp
         MUvA==
X-Forwarded-Encrypted: i=1; AJvYcCXZygTxHi9h4PJ2FLrIfCJ1ZaaCbc0E2wRLRIMz5LmXunAOW67gf00CrQkIhYjYwduMr9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMLD0U2/1MzziEGH0RJ/ncIJRNyPHUdBgTmAdQFhCp/zNhhBNU
	LEvjwkC7wjshjWomLrXFlIuF97YGDMUnD8wyuS1OwVJ0jHkCE/aao0K7
X-Gm-Gg: AY/fxX6bJ33GZv8PZzmEzJ20W4Mz1XMQywUp2jS1fIjh1hYzMDFEAfmMPc032b1KH7p
	A4oFHFOPabTn2+nzs1pv4UIKeL5hEyPl1qRD0vjJAdFfK2LcVPP8LoAQrcANpq8UlkhzYwi6ERm
	Pwck1qpYZhaPb2ltWgkui1cqcWE+Hum4eHxBeXn9exT9+POwr2d+wn5UCMNtoucvKwv6HlyQnh0
	cVQcUwEGbFNntuFckc6d6xKWdBOgmN4INWiDPpsjkh1LqGTuM+fD9MVtlhZX0qiGPRz1DwDY7I6
	jVgdq1GedaVkDYTZtNQcoU823aOuQUEKZEamtqnLsZW3qpsVsOW3rYJ4JMqZoLzzDAvsI4n4QlH
	ddqb5imG0jppd/I+/IA6upO7ctEWug8yKqabSX4uPLuFm4MWdqRtAuCjPvu+ff4tBWNNDa9mTM5
	rZcOTeLlw=
X-Google-Smtp-Source: AGHT+IEJALUlnag/srZc+nNutVyqUv3oQE6iSsJThTk62+uYDbyqqh3e2Gc3Am2sWZ6ZqH4wfrfqdg==
X-Received: by 2002:a17:902:d488:b0:2a0:d149:5d0f with SMTP id d9443c01a7336-2a0d1495d3emr117851165ad.17.1765965326939;
        Wed, 17 Dec 2025 01:55:26 -0800 (PST)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a07fa0b1aasm140715945ad.3.2025.12.17.01.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 01:55:26 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 5/9] bpf,x86: introduce emit_st_r0_imm64() for trampoline
Date: Wed, 17 Dec 2025 17:54:41 +0800
Message-ID: <20251217095445.218428-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217095445.218428-1-dongml2@chinatelecom.cn>
References: <20251217095445.218428-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the helper emit_st_r0_imm64(), which is used to store a imm64 to
the stack with the help of r0.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/net/bpf_jit_comp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index b69dc7194e2c..8cbeefb26192 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1300,6 +1300,15 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
 	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
 }
 
+static void emit_st_r0_imm64(u8 **pprog, u64 value, int off)
+{
+	/* mov rax, value
+	 * mov QWORD PTR [rbp - off], rax
+	 */
+	emit_mov_imm64(pprog, BPF_REG_0, value >> 32, (u32) value);
+	emit_stx(pprog, BPF_DW, BPF_REG_FP, BPF_REG_0, -off);
+}
+
 static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
 			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
 {
@@ -3341,16 +3350,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 *   mov rax, nr_regs
 	 *   mov QWORD PTR [rbp - nregs_off], rax
 	 */
-	emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
-	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);
+	emit_st_r0_imm64(&prog, nr_regs, nregs_off);
 
 	if (flags & BPF_TRAMP_F_IP_ARG) {
 		/* Store IP address of the traced function:
 		 * movabsq rax, func_addr
 		 * mov QWORD PTR [rbp - ip_off], rax
 		 */
-		emit_mov_imm64(&prog, BPF_REG_0, (long) func_addr >> 32, (u32) (long) func_addr);
-		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
+		emit_st_r0_imm64(&prog, (long)func_addr, ip_off);
 	}
 
 	save_args(m, &prog, regs_off, false, flags);
-- 
2.52.0


