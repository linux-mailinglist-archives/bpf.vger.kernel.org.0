Return-Path: <bpf+bounces-78468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE59D0D735
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 15:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 060703027CDD
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D4A346A10;
	Sat, 10 Jan 2026 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfR/9MOC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9296340262
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768054354; cv=none; b=Ii5mIxx+QY/f2UD4pjy+iWDoUrsZijI93WCdY9PpUrRWn7li4jNbf8Elrr4XqDAhAHB9GmgYAlkA2QI6CY6AMwkTb6yV02XYFhIMPRnu+CM7wPTob/aHNi/cWPZP16PV4Hs3mMrCNnDcqQMSFx446V1KBtqIwavoDlxupK6EdCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768054354; c=relaxed/simple;
	bh=Jl4pPblCht3wmewNy4AzorDUqLIIBs1abVtcBevb20M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxpjyBnihO6kwEqjbfkkxAqP1cyVSVdpmqkHW1n1qYdVakglKN0WkWYgrxeLsd8/0fZzif1SIUMasAJZ4RKrgx7mqsy5GRcuNlg5XSWz86EUqZbJP7MyWqHQbKn8iN0QDZR9r+XjfVeYSN6ZsMfGmnHzdMCth8KGlZmdgyo09ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfR/9MOC; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-81f4ba336b4so19867b3a.1
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 06:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768054353; x=1768659153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dY3ezCDqJEw5lLNp3hPcdtqAe3v6kNoUNdbynGQ6sjc=;
        b=SfR/9MOCfk3B0n2ty4b7itFLZiy5OAPmoAa6p11TBUqDXMx8MCUnWdKgM7CS3UH7Jh
         bcYco6lW96Mo0DfZb2f3W+nFX0LPzpEDosZgjjVpI3ZQMKtY37PXufssYdRHY+0UvadX
         sAK5yew8atlTpSDbe3Q6IxLQm+soldInJhu6XKddmfFVt8t0oWiINgvdSicf2T/XRtlJ
         SQk62Guz0BWLoWNY8+0DG4y/lovwi0O+CxQi2MEgKgamMEuoTOUzqcfQuTMwgHT+6cyr
         l0MS9K8pTZx/NAOezUWlYcQv1ScdTEroQZq/ErGf3xY9K0xBKjG0atvq+sDEnB5KgggB
         4eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768054353; x=1768659153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dY3ezCDqJEw5lLNp3hPcdtqAe3v6kNoUNdbynGQ6sjc=;
        b=pC/jp2BxiJz9qc2Hv+A15bFYkY9cC7HAPOJ6UrQB+JMFaCr5Uy+0x1FVjxI+uu6eGg
         6fGXwFGJIY2o1KsCnCOPb3OaVheRHN8pxgd57DUgYigEP7pTzRV/ZCcC6jUuMnJpRTCf
         KdxivwUkDRmLDFC/wSetRboESnzoKEQT0zKguZhiCwGehLWMrWdYVGAW8r2HgsXVM4ZG
         zAZM9jY9wfVbhnNuSL1VT0AZ9rFR51ATe2bmZFZV51ZY2Ne6pKVnp7v+j/19NkhZaVSa
         Ta6vPgKu78sJ1yaJqbW5daPNq5xN4HmGKBl47Y7X43MQWeufJUOWy6U2cjWQpbvxiGlM
         J1eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtPFsQno1wCkgELppahySNIBAoZujIuTEt9EiHhS91NCe4s4DjurT4IYrCiCLv7kOh1f0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Nuc/ezfMq+rmrqieEWy1CCpElEJLhl52A6C2GXPze/Z20sxE
	HOB0USX1VVHssbWSkXtbaz0WRdzBhmnA6ol+OuQi225mK/1zFAK7uL/u
X-Gm-Gg: AY/fxX7T6NQujI6n1xYIocRiD+v02PBuz/VS3ZwPolWP7+ql5hXmwv79y8qGI7O9+ty
	8zfeO8V7ghB0rohmihGfGMKo8/FbnUa2Gj9njR/gLrLzC8Re6MeT5LH/6TbcHf04Yh7+rpmw9qI
	4P6SqCkzzwbb2muVg+voAxtpOgTC9i4kP1PimW1WRyPNw/fd+TBiG+zPyzqKbEFikiE4I2XbYdl
	/v0xERIDYjNRlVdAYdLJ9fjxLS4TScIALOagp3CeJEZ2/ZRnxHNKEQIuSfjEDkjwB7ZkyDyiQWA
	/KXn4t57YWj/wbeXE0/FtUtP7EsuXIOSFNQ9x/vsbtYOhsvxhfh4lO5aUM1ar89ea9WuxUfRovF
	YJnMolXpsk44u7jScv6+z8SvZGC0l0v7S8szrXUxdV7IU/6SVl3aAyjq+ANQpKF0ro4D1B7YPZO
	rFDY6Uik0=
X-Google-Smtp-Source: AGHT+IGDcnm/lkKKBuwc0MZ05ieVLcfimIlOgX2VnOdk2Fk0Ph8Hu9l31xuFI2Cmcw9Y52dW2IfBow==
X-Received: by 2002:a05:6a00:7704:b0:81c:555c:e85d with SMTP id d2e1a72fcca58-81c555ceb11mr7645214b3a.36.1768054353061;
        Sat, 10 Jan 2026 06:12:33 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f42658f03sm1481079b3a.20.2026.01.10.06.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:12:32 -0800 (PST)
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
Subject: [PATCH bpf-next v9 06/11] bpf,x86: introduce emit_store_stack_imm64() for trampoline
Date: Sat, 10 Jan 2026 22:11:10 +0800
Message-ID: <20260110141115.537055-7-dongml2@chinatelecom.cn>
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

Introduce the helper emit_store_stack_imm64(), which is used to store a
imm64 to the stack with the help of r0.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v9:
- rename emit_st_r0_imm64() to emit_store_stack_imm64()
---
 arch/x86/net/bpf_jit_comp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e3b1c4b1d550..d94f7038c441 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1300,6 +1300,15 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
 	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
 }
 
+static void emit_store_stack_imm64(u8 **pprog, int stack_off, u64 imm64)
+{
+	/* mov rax, imm64
+	 * mov QWORD PTR [rbp - stack_off], rax
+	 */
+	emit_mov_imm64(pprog, BPF_REG_0, imm64 >> 32, (u32) imm64);
+	emit_stx(pprog, BPF_DW, BPF_REG_FP, BPF_REG_0, -stack_off);
+}
+
 static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
 			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
 {
@@ -3352,16 +3361,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 *   mov rax, nr_regs
 	 *   mov QWORD PTR [rbp - nregs_off], rax
 	 */
-	emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
-	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);
+	emit_store_stack_imm64(&prog, nregs_off, nr_regs);
 
 	if (flags & BPF_TRAMP_F_IP_ARG) {
 		/* Store IP address of the traced function:
 		 * movabsq rax, func_addr
 		 * mov QWORD PTR [rbp - ip_off], rax
 		 */
-		emit_mov_imm64(&prog, BPF_REG_0, (long) func_addr >> 32, (u32) (long) func_addr);
-		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
+		emit_store_stack_imm64(&prog, ip_off, (long)func_addr);
 	}
 
 	save_args(m, &prog, regs_off, false, flags);
-- 
2.52.0


