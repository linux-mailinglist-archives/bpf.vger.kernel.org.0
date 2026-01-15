Return-Path: <bpf+bounces-79024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F33CD242A5
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 12:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11CF83078220
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 11:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E055A3793C3;
	Thu, 15 Jan 2026 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9babHY/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C4A3793C6
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476241; cv=none; b=CBfKUWd1D7GgDYI+X49uFoJT+RGNOnDI6eC97EJhy9wjdjGKK2Qf7QDIqO8yuAGbxWET3daFC2hkULYRIex0eEIeavPeGFaxgOr5klNnqgSDvZCYuNv5O7LK6vxGgB1XYfsh+2MSuWdj1tjy9d+lio6/mG6UtwdP7/HzJk23xxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476241; c=relaxed/simple;
	bh=6fOLPr5pZFj/RQ+K6yXNXzxNF1aapP52tKW6Swnvtbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOiVriu+g6lvzxjrTEZnOBb1O+aboQdYfGNX9IvMwAIoSE03ihqY/5b/9NOU3EQlwBp/+Aj5AJf8BK+yJJ5rjORAeNPozPDCIPaI2QylAXJuFmlm8XYjZWQScGoEdIkPBHYqlqoEnZWAzGlHzWholCdeBx6f1lyXFiAW7MCkgzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9babHY/; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a58f2e514eso5129675ad.3
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 03:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768476239; x=1769081039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3QmrLYBEBYXBAfPFlkqBudM2njHTQyGi8eiKfdRBPI=;
        b=K9babHY/ckbeMC7JWrc2N9zaJeIR32aum9bXI+ItToFP1vuPRVa/ZT3//LSHjBu1bl
         Fa3fR9nS1pWJmLQJCqqadWNhoPSDJUi0pTF188aG7f+0q13f6SOHK562sCxRuIIaExRX
         avhBNwopcFqyjsNQ2t0RISqyHDe7qak5/v1h0TOn65LKzD+gDcvSZnodzMHjYeWTIPfF
         TJdGsMtZ60F741Unep2stHo7TQTLa+SSnBCXapMZz3Pazj1XFt7BPpZF04shZbRx1dvY
         PHVuW/jT+lpHM4KgTIzY2xSTTFS+x4oys3WFnqXWfz5Dpz/dgVqcJWWxLefGmMzd2+U4
         G8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768476239; x=1769081039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L3QmrLYBEBYXBAfPFlkqBudM2njHTQyGi8eiKfdRBPI=;
        b=rvsWFroNI6f3N6YzRfbWRcvMN3FBGvUQ+WIL2+eYUv2aGXmaXbuG5rhI+YIBLTFFOo
         AsBwkpR7St1HK5BZ3MWsQiTFYdn+zfMZ8VnTzybhivxyFnDAhnsR+bWVGG1mJuaajHnx
         m171GT653LEgjiS719cdndbEzHS+p29oF5CfZdaZgg7ywQN2btDRpciO5MFCx6JWcBEm
         oCvGlk40R4EnOtD56pOUwRnxWaVAo8F9P+nht4F5TzUZOdl4xaSRu1cj5/DqwRvl3dB4
         fucHbLVsmisU5k/qh4STYvFNhPiow7yNZHjAiZpG3Pwh4pY4p0hF7aDAwBNRVpKAC/kJ
         MfyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2ehoVESuiBMWl3PwYNKj1TKUKXthUpmzFibkCdI54TAXwboqxE22SS4SErsgkLTvCpew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2tniJ4jGG6nvJMi7dgthEdV0GGE2Pk/eU23Zw6DFPkaFzCe+M
	X7MAZCZOjGM21F5aF2bXSNh/C6jTuTG7u+RPyj57eFlt17pzb5KFE0PV
X-Gm-Gg: AY/fxX5wwXR2+Ut5fQo4k84bMsU+OLJHGzcfmZAcs80mpEfCj8Jj6Yw1XJWU9hqkhVB
	teggJmqZG0VxBwXuRqh6q3okeLKdItjcPJZP4othuKvK9Tmt13Cjtw02ZHDb5J5592V/2m1/toJ
	1lGnRNMN/rz7CGHiwLUtOeGFzeACWmlrjH4xFW1SYa8dZXeXQU3bUTxhjBY6KOuGqMajC3C11MV
	2sXe414PJXgomfzpSJ2rc2y1f3LMN/9JwWenfI0yvxwJKSXhz9++867HaIpB2AdKdlLAarOvBHl
	qWjP8fEUXebZigdEg8RTh6X/KUn7CscI5LlyMR1TWgXlQC9LN8pDLj+l5s+BRoeIEmtntGRxuVS
	gDWsRIwzisMlYTzGzznJ0PA3iazrgI1TLXZdHAI8XkHCvuk3Gr6oPJ9CyF1J4I3K2XpStONq5Er
	5pWzdhgFU=
X-Received: by 2002:a17:902:e784:b0:2a0:c58b:ed6 with SMTP id d9443c01a7336-2a599e347d0mr61989615ad.29.1768476239321;
        Thu, 15 Jan 2026 03:23:59 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3ba03f9sm248523225ad.0.2026.01.15.03.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:23:58 -0800 (PST)
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
Subject: [PATCH bpf-next v10 06/12] bpf,x86: introduce emit_store_stack_imm64() for trampoline
Date: Thu, 15 Jan 2026 19:22:40 +0800
Message-ID: <20260115112246.221082-7-dongml2@chinatelecom.cn>
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

Introduce the helper emit_store_stack_imm64(), which is used to store a
imm64 to the stack with the help of a register.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v10:
- add the "reg" to the function arguments of emit_store_stack_imm64()
- use the positive offset in emit_store_stack_imm64()
- remove some unnecessary comment, as we already have proper comment in
  emit_store_stack_imm64()

v9:
- rename emit_st_r0_imm64() to emit_store_stack_imm64()
---
 arch/x86/net/bpf_jit_comp.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e3b1c4b1d550..2f31331955b5 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1300,6 +1300,16 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
 	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
 }
 
+static void emit_store_stack_imm64(u8 **pprog, int reg, int stack_off, u64 imm64)
+{
+	/*
+	 * mov reg, imm64
+	 * mov QWORD PTR [rbp + stack_off], reg
+	 */
+	emit_mov_imm64(pprog, reg, imm64 >> 32, (u32) imm64);
+	emit_stx(pprog, BPF_DW, BPF_REG_FP, reg, stack_off);
+}
+
 static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
 			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
 {
@@ -3348,20 +3358,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	/* mov QWORD PTR [rbp - rbx_off], rbx */
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
 
-	/* Store number of argument registers of the traced function:
-	 *   mov rax, nr_regs
-	 *   mov QWORD PTR [rbp - nregs_off], rax
-	 */
-	emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
-	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);
+	/* Store number of argument registers of the traced function */
+	emit_store_stack_imm64(&prog, BPF_REG_0, -nregs_off, nr_regs);
 
 	if (flags & BPF_TRAMP_F_IP_ARG) {
-		/* Store IP address of the traced function:
-		 * movabsq rax, func_addr
-		 * mov QWORD PTR [rbp - ip_off], rax
-		 */
-		emit_mov_imm64(&prog, BPF_REG_0, (long) func_addr >> 32, (u32) (long) func_addr);
-		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
+		/* Store IP address of the traced function */
+		emit_store_stack_imm64(&prog, BPF_REG_0, -ip_off, (long)func_addr);
 	}
 
 	save_args(m, &prog, regs_off, false, flags);
-- 
2.52.0


