Return-Path: <bpf+bounces-43846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A092E9BA7AC
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 20:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2AB41C20A28
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 19:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5753E189F5A;
	Sun,  3 Nov 2024 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/azD1fr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331EC18756A
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730662523; cv=none; b=fuYnWIxdejCdAr2Znzq3s/M1hQHjtX1YKACsnZa421TPVieJqcvLt99HvGt7HpwourzNadScKVb9k76O71q/vIx0yWmgxw2sPAbZ2fE04ePtvY9zkiiraZERcacMrw/iGd+zZA9NFBTKuoempTAIbRoWyNWXv7ypZ66S5VyLxRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730662523; c=relaxed/simple;
	bh=24tNqLBMPAstXcEG50Y99Zp8jdqY3afmUcIQKWuiHBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbznUZpnUtKmr6JhLihE6vq4/N/o9uDgdQ2+vvODVYhxdrqV+fipwxZPQpRqIUXHAvomDxhpBWnZAS/rV9ElGjgo4jZSm8BeOkRg1sc20y/adhux8fgt2CukiwGRlypUIady8Nak6M3dYXMVFOk9Wbz3bAA9S1qfxvUm4iF6QP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/azD1fr; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so30293525e9.1
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 11:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730662520; x=1731267320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5p2hCLjfzedLrY/PuAn7mcGY9AOeiqSMiTahDqn2M8=;
        b=W/azD1frCNpPIWjOLx2Puu+ddP64FthtG6D4oRkPSBk5RtBZcwcI6VmhkYUfasEKgW
         YlRO7xVG3NClmCtwinG483e41S96JpLRTdCI11W2dzJ59pOMh60BMA4UG/1r24+ZLtrV
         qtRIslacaprLzvrSKct367qL6DALMtFUu/7tJvScPMVMVK9gxzi+zdne8i7NjJdT6QQ1
         JfTs0lSWGQPXuLSbygCDurVyLgzJYRM+6agCUV+OkwfEpNJ6xSVNGHe3edz5/Dgs8S+2
         v2pNHHdGCs4o3cA0u0XQPgL4sBdtT2D7/OrcKRLmJJs8FE2FBgzjA/Vo2/helekpUV2A
         JuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730662520; x=1731267320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5p2hCLjfzedLrY/PuAn7mcGY9AOeiqSMiTahDqn2M8=;
        b=hFz7EoUZqFxMtNYpx4ATqnv2I4ac4xz39Qdx2K4X6e2tIDdEFEOMMQHwtCa2rEeLfu
         IIOo2q3Wt73PN+zS6Cbl3nAPHqiRgVufiUulOtFLx8NVbbCVxmL/fgNVlCwT6s+uuQP6
         nN53g/w/P7FcTFnaIMzLpBvz5gslPF+DIKAacmy897ENAePVsugUZv9/AvrYks6GPnHh
         nPnvfybej25Ed61Pch4e4Wpr0q83a5ZbKiv9VRt7uMgY5MG8+t4h4a4tlkFlPl6OVLu5
         O2vJfqASTjYNGo4zvax4r9vv61ddz4WVSAAYV4nV9eQYHShdzl8TVZonBzCFcNzBYzfG
         BHNQ==
X-Gm-Message-State: AOJu0Yz+JpQv5TgvF2/9Oo3cmPtd/E5/KXnD3cNpbIYrrTvHogWaC2Tw
	OtVR/T/0npX7tafnw0pNLkoh7UGTRAgeAH3PQ/ODlctOuPLPQmG0wRYAHVN/MJz7Eg==
X-Google-Smtp-Source: AGHT+IFbr402wBj+hpQPvD2i9jDstKL9Q+NVWiMoDudAjJ/gOXraSmEbbdg6yxu3CCQbP5KgCAR7MQ==
X-Received: by 2002:a05:600c:a41:b0:42a:a6d2:3270 with SMTP id 5b1f17b1804b1-432832562aemr83498845e9.21.1730662519697;
        Sun, 03 Nov 2024 11:35:19 -0800 (PST)
Received: from localhost (fwdproxy-cln-004.fbsv.net. [2a03:2880:31ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6984e3sm135561255e9.48.2024.11.03.11.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 11:35:19 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Rishabh Iyer <rishabh.iyer@berkeley.edu>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>,
	x86@kernel.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 2/2] bpf, x86: Skip bounds checking for PROBE_MEM with SMAP
Date: Sun,  3 Nov 2024 11:35:12 -0800
Message-ID: <20241103193512.4076710-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241103193512.4076710-1-memxor@gmail.com>
References: <20241103193512.4076710-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2747; h=from:subject; bh=24tNqLBMPAstXcEG50Y99Zp8jdqY3afmUcIQKWuiHBI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnJ8wNYj993Q8YuJ3N3/xm4JC6LFtTeTnFQeqBwPFH hLHLzWOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZyfMDQAKCRBM4MiGSL8RykKCEA CYpwoa6CNkRVcqatnsqU30bDVX7ZP++vFvX94oVWuRuT/vCebs8vtOHD6DTbnh4QnFaoNYuJoIKYdG BwCaCk4QZSqTNMWUUbKMRJ+Tt8wTcsg4Fpyy6hEWwNCfodvp00g/IRzXE/ljgQvVa447PBDGy7ugla 7f0aZSCz6hQudOIbHqxM8fK+T4PmpNzbXJWndNLTaUQmLpy5MEuSuK+uJ/cgTb/eleQW5eSLot/TxA ANgZ6UjlRj7bH0dmpj0o2mOzCWtB9MnY8rbj0OrkiWpdU1IXP2LM78uwLPPy6Kp3hweTlAdBumJRl2 kAZqLFluRLty1JeDV4mal4r26vMjz5UyHKLgVghNnR0IHZvwM81vtyagoJ9iCJu1QDYaqZVyFIBBpu DMGm6Q5gX3x9NGV0jdvgndIbrLqf2NqliFEqsgMkujKnmdxfAhrcq0M+icN3Xs0EUyOu0Nba/MqM0t PXGRW/ZndSHZzrt7Yf3bjWLWhl56I00xndV+5sCFtOdJxnSoNSo2gm4Ysrb9MzYyuFVJ8yCYjvNJwo I6o2nXk4OCmoFOYMT4GXvZFoPHOp2GkfP9KjtOHAYmjPnkVvuRoppcBwB88/wttexPQe7YfWyJWsHh TdWg58LFlayUgMgvNuOFJXvIe4/zuyjwB0m38+mtuD8+Ny4VtRgvI6TgareQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The previous patch changed the do_user_addr_fault page fault handler to
invoke BPF's fixup routines (by searching exception tables and calling
ex_handler_bpf). This would only occur when SMAP is enabled, such that
any user address access from BPF programs running in kernel mode would
reach this path and invoke the fixup routines.

Relying on this behavior, disable any bounds checking instrumentation in
the BPF JIT for x86 when X86_FEATURE_SMAP is available. All BPF
programs execute with SMAP enabled, therefore when this feature is
available, we can assume that SMAP will be enabled during program
execution at runtime.

This optimizes PROBE_MEM loads down to a normal unchecked load
instruction. Any page faults for user or kernel addresses will be
handled using the fixup routines, and the generation exception table
entries for such load instructions.

All in all, this ensures that PROBE_MEM loads will now incur no runtime
overhead, and become practically free.

Acked-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 06b080b61aa5..7e3bd589efc3 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1954,8 +1954,8 @@ st:			if (is_imm8(insn->off))
 		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
 			insn_off = insn->off;
 
-			if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
-			    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
+			if ((BPF_MODE(insn->code) == BPF_PROBE_MEM ||
+			     BPF_MODE(insn->code) == BPF_PROBE_MEMSX) && !cpu_feature_enabled(X86_FEATURE_SMAP)) {
 				/* Conservatively check that src_reg + insn->off is a kernel address:
 				 *   src_reg + insn->off > TASK_SIZE_MAX + PAGE_SIZE
 				 *   and
@@ -2002,6 +2002,9 @@ st:			if (is_imm8(insn->off))
 				/* populate jmp_offset for JAE above to jump to start_of_ldx */
 				start_of_ldx = prog;
 				end_of_jmp[-1] = start_of_ldx - end_of_jmp;
+			} else if ((BPF_MODE(insn->code) == BPF_PROBE_MEM ||
+				    BPF_MODE(insn->code) == BPF_PROBE_MEMSX)) {
+				start_of_ldx = prog;
 			}
 			if (BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
 			    BPF_MODE(insn->code) == BPF_MEMSX)
@@ -2014,9 +2017,13 @@ st:			if (is_imm8(insn->off))
 				u8 *_insn = image + proglen + (start_of_ldx - temp);
 				s64 delta;
 
+				if (cpu_feature_enabled(X86_FEATURE_SMAP))
+					goto extable_fixup;
+
 				/* populate jmp_offset for JMP above */
 				start_of_ldx[-1] = prog - start_of_ldx;
 
+			extable_fixup:
 				if (!bpf_prog->aux->extable)
 					break;
 
-- 
2.43.5


