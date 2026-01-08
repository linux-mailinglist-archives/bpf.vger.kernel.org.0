Return-Path: <bpf+bounces-78182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA5ED00AE7
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 03:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A683079333
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 02:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE4B284898;
	Thu,  8 Jan 2026 02:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhaC/dY1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0519C280317
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 02:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839170; cv=none; b=t3aZn+n2E5+IhcngMJlKa+J2Awn/gX7brJm+0rQdDDOssFebEzwyo2N2k5kj1qfW/bbY4X8rkxkQeHNx8xPiAP8HZlMRsgHNZySfBPNRv1CorMUA9x1uyA4jsyd4Cs0ULiM/TfdcvMckENCLtm+RKZNR1LUKGyZDCLpY4+PwjLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839170; c=relaxed/simple;
	bh=Vk+W6eyr2IUQD5U+QNmcmmn6L3jEBra1Cbetb1uK2cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCmk9ymS4U2fnKOCoSfA/q74BGdfUNxqaPYs4xBaJatNnuP/S/q2bkf6nsvoTlFHr1bk51PnHiASkS674cZYZrmMPnGDLeDCes8O+a16vdCmqaeHVFL6X3WjxRU1oq9ojA9ERxswv7Fwh8YoLf4nra4noQWInGSPq4FOs51Khng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhaC/dY1; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-790abc54b24so25769577b3.3
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 18:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839166; x=1768443966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6UQnELg0jWNEfAf+zm6n+6F3yec3GYQzyGkx+3yxZQ=;
        b=OhaC/dY1ecZoUT3nWAaF14ZYYqd5OMqC4cR4R+s2et4PChFH3oCZF+7cYn0u0tZf7H
         /Do7qhcd5HxUnQyiy5lN/ALWZVmKP0Q6x3V7VsAlgF82zqNnLwWqqP9CXCa8FFssUjE6
         IRn1CUSyQk4GBCGjTcMrR6lcM6odWDsJJZ054chWiBSEM2RpYeoi79KHV480gHqDMrTC
         pTN5jMhdvw5y6+9wUH6R5TAuB71j9u/NeZgzXHzLQ/OpY7Jk6WHLrBvkdNurco46THJX
         T/0s3WxH8nz5sCcpmcjEgtkMRDUo71dl1KQ/gq6xTunyROJfH/XovPTtJTUtDWYHNdVY
         TRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839166; x=1768443966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u6UQnELg0jWNEfAf+zm6n+6F3yec3GYQzyGkx+3yxZQ=;
        b=R7aYTjndwKaFSZa50hVn31xvMaOqxVcZY+LWjFoahG/P96Giu05y3P0dvidST+nKu7
         5ESXIVjHRVqgRyTccVNo9DALmme465mTliZy00pn8nLjdbOR0XSKyhlx+F/NgBfFspSU
         73CiXlIN0gTBd5CojM9zOPuN93DfCwbaaTUJoAOlEbQ+7kqTk7+fH2IxhZXx9bH6Aa1x
         NsleLUuGPgEEI4/F9FCe8gR3RqZ4Tws07jh4+fTRC7yHeCas4Os+/Fhtdpy1+gsUZYIV
         HcI73twlQmSNWhOSuO9+wH8o6kERasW4VcRgG9XATiZP1bspeeENPzU8l1uZukLKt45S
         N9cg==
X-Forwarded-Encrypted: i=1; AJvYcCXvTNT85YS7GPHRfvczoOe6mYKcI8MBmDGgilGc3M5Sa8cxN+tVu1qOojs0O9HhKp9+xlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2jJZt/w60iQBUMD1dIzY4304S6TD0t1cN4pyL02BZnZwrzoiJ
	63M828OxNQFkNeTtBYT07HD1ZRVmCYXM2bfbqgeYKZXTN8Vn8Jvum5s2
X-Gm-Gg: AY/fxX5X6hYDhC79vJnY0BgiHdGhy0ZcD1liaYWyyje4lRe5GbS5giix6TD7oBbl4ZI
	L8XiFTlQfzXm9RrxWazZ7aTUuPuilYiJYLIfXzHMSztPnVCVbV9ONkrd6/HJHH4In6J04bB5Dzp
	JzNq3j/XBESp2tkEqIgaHHhdBuhgLQ81OTqBUUFZJ69QOe9N2f2F+2egMaIcQw7qjVbnybjyRId
	sNSIuRfrX5Y8TZ0CrueXCd3AxyhgyGU9nqEf19R0ELDlaIKEMxmll6KoTYOJFCla+j/3VS069ve
	KN7L9TLaVXWKbN9KmOaeKrkUGRH55Npgb3u45feisDH/CC74Kh2Vp7u+7FQAmCq+GDBCjkn43+L
	onTRwjWlYtZ38ffVEhFldVb1Y3VWgHwXr7JQg5ioFHGJiK6nKfcqlBz274avmChVebhkawPJZO/
	GgEUV/er5fBjQD0CZW4g==
X-Google-Smtp-Source: AGHT+IH3w0PVzJutpZZWvbHJnp14TE6zHYkgRIkeRzvOCfFzjh5nXjFqTNfNUhUJu/4O8mFMK30lFA==
X-Received: by 2002:a05:690c:6285:b0:78f:8666:4ba7 with SMTP id 00721157ae682-790b56add94mr37794607b3.49.1767839165938;
        Wed, 07 Jan 2026 18:26:05 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa57deacsm24855027b3.20.2026.01.07.18.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:26:05 -0800 (PST)
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
Subject: [PATCH bpf-next v8 06/11] bpf,x86: introduce emit_st_r0_imm64() for trampoline
Date: Thu,  8 Jan 2026 10:24:45 +0800
Message-ID: <20260108022450.88086-7-dongml2@chinatelecom.cn>
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

Introduce the helper emit_st_r0_imm64(), which is used to store a imm64 to
the stack with the help of r0.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/net/bpf_jit_comp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e3b1c4b1d550..a87304161d45 100644
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
@@ -3352,16 +3361,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
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


