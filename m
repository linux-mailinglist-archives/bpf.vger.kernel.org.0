Return-Path: <bpf+bounces-77773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BCFCF0ED5
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 13:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FFEA306B6BF
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 12:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2482C2C08DC;
	Sun,  4 Jan 2026 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwEi3rOG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3011F3B8A
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529783; cv=none; b=sVz9W1JeG2VACjnJNqOPRYCJdOhF6Ugd7e0EVFGeQvF3JaiITHpXALOnkY8kLIoqk3oz+Ihxhb7oAhPmTyG/dcmzCy3LA9gG1Sk6FSyZnL1bUGH73dI5V69vNgR0SrjbcrxjUK73tYBTSsoGJ3GHwcNVAegkHA/c41YuEjFZwO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529783; c=relaxed/simple;
	bh=Vk+W6eyr2IUQD5U+QNmcmmn6L3jEBra1Cbetb1uK2cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLu546eKdWcI8YmZIP87v47kTLEWWkCMs+8VG+iCp+jlaVL/8+U5kekSFlENgo4AHitQUv6YhIN/qaBFqpcg2sEDI0xMWbPfxZxxLGdYL1xvoNyO8WJuoXwUn/rH2Im4A+wk2MZ+d6dDEZrkBWIz3t3xPk02Vd76v35gsmzcewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwEi3rOG; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-64661975669so12707395d50.3
        for <bpf@vger.kernel.org>; Sun, 04 Jan 2026 04:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767529781; x=1768134581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6UQnELg0jWNEfAf+zm6n+6F3yec3GYQzyGkx+3yxZQ=;
        b=HwEi3rOGl6rs7txLQ4Yv/AkTui8CkINcKNwZzquuNTQS+kF3yzQpJ2DWZT52+YW16/
         GUKIkmT7rx+EVAuNqfY+s7GKEwRUID7s1JNqceE8rN8hD3HzTb3uT56srz5wXXe9kSBb
         l1qosiDkixwzlcXkhn/44sBzdqrRPk2acLWna3R9Kyvsz97Qq53AKilPNATiKAlM/RaF
         WA2+ciI43D+2IKNozAdC7FkXnysFkoEn9SIQqrc0RNSxGXfRoOoSmsI2z8XKpDAN9B36
         23783O5HhrW3dhefzjo3Irg6t+r6RXPmYFB0rT4luSXoOjNbVveU266b9zOFiyAAX0bk
         usDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767529781; x=1768134581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u6UQnELg0jWNEfAf+zm6n+6F3yec3GYQzyGkx+3yxZQ=;
        b=eD1kWoNRZt5IIDr3/DYvvV15hJ1vS0ZXMvMQ2eg6Oluw+ZQ21Ym7Q/1TvkU2vtC7Ow
         XfrVyDSc2oxyLCoj1+AZHnwFYuy116KiM2IGul/sDYGsAAX+t+LTQInB8GKb8NttXlqU
         zX2hdH7I6amSg2S5b2XhAjC/QVUmMZywJONhj9T/Y5CsQPcwksWx1416Nh/wSpg865x8
         EYtELBJxV6hK/HYJvdApgGBOG1tgzp1Wfn2wLL16MUHLdde+MZyrhPU22Dv3jX5+UsxJ
         GBZfniYztie0gJ5VMPfgQtv1S2BTjTYRblREn1CbaUnCyqWlBV3/Yhx8tQo6QT7a5pz1
         q8NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXRszKFBKezacv4bRy9Ax0TG+23/FrDvkDySM7DXdM2Kjo6UCH+L4PzEJCToCD+4LKdA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOWbBwRTlNJHPfjB1M299OV2snuBLl2a0rYA+A4OFf2vsrIlWy
	QF0k8Hbly/PxadYR1+Qe9XKTdZHCweZ6pg2kT1jRFzwGw3K3nn12t5x7
X-Gm-Gg: AY/fxX6c5Yazn6J/yOg+iPvCIGT9AqOcXuSb7n7KDqu58WYaYDqXC0JB+kHw34DHnUH
	37wAxb2UPtmDwqDxKuUZE3wfyKn0LStdxNBnuMOoQSY6daE29ryT/9dIiniEa9Oxm648N5x5kww
	d4yPNTYsfmiU5L2hbyGBpul1FoLPQEzn+L0kWvUIT5eemSkrmxdWwZfT+GLKDAeYVfB76ruMCsK
	VQQC7os64xs90r1quSBpx7lugYkQsTdKjhZoytDP1c5w0QdWQ4OeGM+OuesTekf3qirtUWgDw42
	Qq69IYi5YOGioglVrpQ9Wuv05HNu5iCAjrjCz+HUzymWSx32pXuJO9JxqK/qpaBasT52n+IhpVS
	1tiTvVDlDKzK/UohVjGyN62lkFyyHC6L9CVOXxBazV/IaVmwHPLTzMDjXe2i3OOxCnhLUK0DnfZ
	xv/mGbXO0=
X-Google-Smtp-Source: AGHT+IExCIUIES0rpnVBP5Dw4YstZJa342yIXF0UaDhHyPx4G8VhE1josRA+AJAHrW7AJglmeJ+vqA==
X-Received: by 2002:a53:be51:0:b0:644:2e5b:410a with SMTP id 956f58d0204a3-6466a901132mr28541542d50.71.1767529781214;
        Sun, 04 Jan 2026 04:29:41 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm175449427b3.12.2026.01.04.04.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 04:29:40 -0800 (PST)
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
Subject: [PATCH bpf-next v6 05/10] bpf,x86: introduce emit_st_r0_imm64() for trampoline
Date: Sun,  4 Jan 2026 20:28:09 +0800
Message-ID: <20260104122814.183732-6-dongml2@chinatelecom.cn>
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


