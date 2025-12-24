Return-Path: <bpf+bounces-77412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B5DCDC566
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 14:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5703F302B986
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 13:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD81233F8AA;
	Wed, 24 Dec 2025 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwtpgmU+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1783C33F377
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766581742; cv=none; b=qImjKEpOZfSXKWVzsRsfa3wmPCpRoBNWcGWZWO1XnFrKp56nERbnHykVr7Ugop17TolgAbyLYAym/96kiDytxIH86ODSqXgq5mSjYoH4HKXu8IGicfnbGinxaeUGOppN9wSEHZ0k3vI3BOfKKHA8WgOsd9AwQtUBjn58GfyeYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766581742; c=relaxed/simple;
	bh=8UjztYwJ3V5glcGLXb6BENiANc0oStuVeMSUdlMadWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJQcbqCRNd9ANeAkKLPAqvVXgelNy3KFOfGn4YvTACpo68oXzX/hXFPClq8zC6XbPB9xfOI9XrudcpOW/O/nLaweS/ovibEJF9MWb21O67Ms7c2e3mMOL/5g3Qy509nAsPdWDzn5xty0qwMaj5/Vzmb21/8sLSJs2qMahqwyNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwtpgmU+; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7f0da2dfeaeso6092350b3a.1
        for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 05:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766581740; x=1767186540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYyVRjly71IVaO9XpSMOkg3chszPFkxF2ByaNmXFw0U=;
        b=JwtpgmU+axPMV354GF5rKyQGBuMCnvO7N/YiVvTY9Gvi5haZ+KeyoE/RJX1R480w7p
         eOMpAikR650ghga+M22qQW7vWrC9oE1MxO1rlGwokPLPSWAlsfLGSRM5nslPHfEF0XSa
         qv128otBSgCNSj4JvwfcG7Sa2odfUvUWTgv6XH6PxMoHXNkCHGAm/b9ee27Z351g4brb
         9JLJXanDDw8enyXOxOQG4VjLOVBA48U2xfYOQxei4Veat75blsetkOJmBhV/ilvZDcCB
         jHWCI3ZJ+WiVp3hWn31uoI91Z/FABeBhP32ECR/ZRhFRm1Js0M9mIgxeHkeM9iTndoOd
         T3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766581740; x=1767186540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zYyVRjly71IVaO9XpSMOkg3chszPFkxF2ByaNmXFw0U=;
        b=ZSyVq+uG6qvq7YERxzlFv+fX6W+IbFyu10hAGHzNvpG9VmF9uodmZYZqTGJ/63wb+v
         cS36RYQ3nx7sbW5sqcYT/U8r9q/dwcRguYFFTefIczvZI7KI6Cv8mDOudEobjnkQqcoo
         AkW9cEQq9pfrFBDo6+Gz4uy/ZNgiHgKhVhtET4evqT/LeRcuFVi5zeiwp40sWVvvBeVh
         mCMsmghmc9g1m9MO3zRJ5teQwDw5y+QpLTfVO79zSe/oJXKrMnX+7ASy8P5+oyE5FByK
         MqT2FTxmMb9ui7CtPyLRV7XpW1R84AwS31lcx/taTtWhHEejcROBOab+eYKlTG83pHgB
         AuAg==
X-Forwarded-Encrypted: i=1; AJvYcCWGeopTlylgYFLIt0RNSQjiqHEJ4V3yf8gYuCtFFsHFXlGgoDkSJg6Qn9DVOV8MCAr1jlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfNJQPzWDQMuMmeRGDzJXV+bmaarSQ7i7Y8xnQ/e25NMf4ff0F
	RqDvYp5V37AUNF+EeOJom17TmDjd+G/hKUz0evFHJp9jzcKan/UTQHiK
X-Gm-Gg: AY/fxX6q9LZD7L5oHd8oNShbL/IkLAk4BA/M5blH55bhaOYsSBQHuOYpCIht+aBdIB6
	6f5ytFd5vfDtgCyOLxui+iWhbj8dSyDABb/aLuXlLxvEhXHZGA46hL8Su6kj0jaNzuRVHNGRnhz
	kWQBVbnQ86gb5uV1Q95xk/NseW0ja3cJXlcBxCwIIBTohUV2U5dQY7iDdJMs/1rlKgmrgOYm+va
	UE07M+LTeR1gx2CgRG0Eq65vnSk+G2AMZm3e4S2LeI3rIRRTTfPR48/vkH7PDbsYpmqqp56TmR5
	sU366DHnRwOcQxWvAw8vgkjkC/UfIuSL/tDT+VV5d+1qpRYnVS99lJeDPyP00UFAxdyoELfRxFL
	389TDsdR/2aP9D0Cn9nQ+oX+OgpBD8+PUsyxNB8ruS3yH70N0JrEfWF0ZOJnJpyNxnNHe6s1tqB
	61U19Yjrk=
X-Google-Smtp-Source: AGHT+IErd7vAfIB+irZQwkzQ1fQaxD1AvOnZrKvCeFIJ2E1PWYMiRCEblW/NltGYCB7XCuuAuIDylg==
X-Received: by 2002:a05:6a00:bb84:b0:7fb:c6ce:a863 with SMTP id d2e1a72fcca58-7ff650c8297mr17244641b3a.13.1766581740390;
        Wed, 24 Dec 2025 05:09:00 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm16841173b3a.32.2025.12.24.05.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 05:09:00 -0800 (PST)
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
Subject: [PATCH bpf-next v5 05/10] bpf,x86: introduce emit_st_r0_imm64() for trampoline
Date: Wed, 24 Dec 2025 21:07:30 +0800
Message-ID: <20251224130735.201422-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224130735.201422-1-dongml2@chinatelecom.cn>
References: <20251224130735.201422-1-dongml2@chinatelecom.cn>
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


