Return-Path: <bpf+bounces-32510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED12B90E6D7
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 11:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76371C217A8
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 09:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B9C80626;
	Wed, 19 Jun 2024 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiwbKVSc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85867F7C6
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788945; cv=none; b=j7c7FzEwVKvs5etY62mg5H8B4sLkT5AjxGBcwF5NtGceizoI8Lx7nhkaonDuEa/+ldOsUycAcyCAldAqOAoE17tVpFuswsDEonDQwCQix+e8LfbOIni3Ebh2Cy0G4Kt9X3e2OQiJ8DEFqae8rccFBB3qyAJkgX8oAgJutiM8wws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788945; c=relaxed/simple;
	bh=c5oTgP9QkkqMhl0mhuFCPOTyp5qmTdwIBTcPx9gqqZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2zheKs+rdeQF9sXMyWFad+5WDTmOZ+RIPv5xNNFCnUUhpfe7tYKwCj0LdR15Zz+JWM+cQGSrS4OjUMOJztfGPs4imDQQQC4vnBiP27LO1mGjpt2VQJ/paPRx6lRg5RqKmP1MXlJeeynhtEpDVaN+uyCtnln0GetFHy+IuL/nAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiwbKVSc; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-35f090093d8so4964543f8f.0
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718788941; x=1719393741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuFNtRiPUxiY2ssVsIPz8qk6a5jINgTHJnFo8uiNf6E=;
        b=WiwbKVScTYDjXfoJa0nRuUtcRiy0RcLl95oJhVipq1J7kLUlZJdPry13GvNnXR/8Ij
         NSZZ+iwoB5ao5VN4aIUpNTjMziwsO6MjTWidqmUBcwdb8Rqm74scrjqORiG0f/kbTxSO
         s168OJXU7RyZ0bxxGHsQgB0PCb/bazk4Ibw43nQvyngddF+vF5e5QLzELo4tpBH2lqPy
         aENBKEHj7mfXQZL6q2miAY6gQySY84enJb8HFtMIo9OQw2TDhO3QRT1eT9X28swZVBs3
         0dwRUWrdBLdEbOVANEf7Sca8/RY19LjpmwMvSb/nq9eLQL4KsPP1Tqla9sCo/kK9nDzJ
         bOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718788941; x=1719393741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuFNtRiPUxiY2ssVsIPz8qk6a5jINgTHJnFo8uiNf6E=;
        b=oX6BIEHnG4q0CrdJX3cVfH1hc6kapV68NGM0VyoPynUt0DvA8PD6AG5XJB+YbcvH7h
         7XvZNca+2aRJyLA1bhymJ7epu2UVrU+o/CggoNsYt+8RRqpeuYZ19wj7U7HlurCV/rF0
         d5YoAlDajg4tVye89u6j5vF31TBAcm9wadUZWDqx3o3tVG7SkksGtQsNfEmi1NRkIdpo
         vZpuOottXkLp37zUblMWKUEjH3e5V0Si0KfH8KSyEIPOc99ILDseKeJEscwXFz14CopB
         UfGIs2O42y6JEZT1M0orCE6nnlK5YOxqkYPRv3XDnIBMUeiUST8wElbHv5dmmuzsi5ns
         2pDA==
X-Gm-Message-State: AOJu0YycQHq4CQZ1URf1orRryf22E+BMwENbuNxKH3lw2FmOZJemRIXU
	q0RaEiHPha0tYeUArOYLyT7lqaDDJO2vX3Ew2KnTYUpXhHWBj8es0kUq8/wK
X-Google-Smtp-Source: AGHT+IEi+t6LCzQjl+9fEB5xZGJaMXkkQhn5DC8PrgPixXxp61yBKXreDrlHZ4R5kfn92Q8VNc6qfw==
X-Received: by 2002:a5d:49c7:0:b0:35f:488:6d3d with SMTP id ffacd0b85a97d-3631998ee26mr1491524f8f.58.1718788941234;
        Wed, 19 Jun 2024 02:22:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750935ecsm16669902f8f.3.2024.06.19.02.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 02:22:20 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rishabh Iyer <rishabh.iyer@berkeley.edu>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v2 2/2] bpf, x86: Skip bounds checking for PROBE_MEM with SMAP
Date: Wed, 19 Jun 2024 09:22:16 +0000
Message-ID: <20240619092216.1780946-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619092216.1780946-1-memxor@gmail.com>
References: <20240619092216.1780946-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2699; i=memxor@gmail.com; h=from:subject; bh=c5oTgP9QkkqMhl0mhuFCPOTyp5qmTdwIBTcPx9gqqZM=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBmcqMXHVXLEcjnMz1ZjXdYJR6KEUpM7hl4PD0Iv CImrToA1vSJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZnKjFwAKCRBM4MiGSL8R ym2eEADC44zzO+zr1+TWeQwuGhXhsBTsAHFm7riuiIMzqmQb+uEXzOKdYoH1jRz4ktnspPO7Jt7 /JFbwihLTtMdTAjaIbbje7fbXjfZzfvnT2Kk0jdFHWSPJtvtgx4o+N0UWIH1YDz5yi4xwx3wUsr AvyEU7+KYASDCkq3wN7FYKnyTJz4aL5TRkcAVyAQrQPU+yO9fHrF7G0as30iJEEO+EboJwuqP3Z 9I2cTmZifbJ1b3YXsG5U2rimxub9X8HnF4pBPxcdqvm7Nab6ecfgUI12sOWe3GSzj7OCk7xUDbh zIsOF0UhfbQKzUYgYaCrqv00LnAeZGJVU7P7CaOPjdQnN555NVFqtt+jfZNcy5RJ4TU99Vq8jO/ K+N/nsZRTG9JZFPEsViCyPzpjMCrQSuhSyzw/LfrsqC0NwSulxDMljnuhDWT2Mpkknmp8GaE5WW 3c+rDsecaxzJX/S1wRQQ5CeyktaS8RuWf1fJGE/kCfg9NdG+H0luBFibbBYNmYepBTVU6XBabTP lzPNoe6Fwfb9PYs3v7Zq6yRg6GZc3eHRhgFqmLmybPWzJ/FYDo9drW+AypvIA1kNLypQ7zoV/U4 mMLj6Aky9Ns+h7rs8AJunzQeJ2KMxGz/2Jtv6EDEemBr+Nq2QWHEH0m/u+8PF/WIj5JY05Kmq7O jDdnfv67kL6NwKg==
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

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5159c7a22922..f8a39189cddc 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1864,8 +1864,8 @@ st:			if (is_imm8(insn->off))
 		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
 			insn_off = insn->off;
 
-			if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
-			    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
+			if ((BPF_MODE(insn->code) == BPF_PROBE_MEM ||
+			     BPF_MODE(insn->code) == BPF_PROBE_MEMSX) && !cpu_feature_enabled(X86_FEATURE_SMAP)) {
 				/* Conservatively check that src_reg + insn->off is a kernel address:
 				 *   src_reg + insn->off > TASK_SIZE_MAX + PAGE_SIZE
 				 *   and
@@ -1912,6 +1912,9 @@ st:			if (is_imm8(insn->off))
 				/* populate jmp_offset for JAE above to jump to start_of_ldx */
 				start_of_ldx = prog;
 				end_of_jmp[-1] = start_of_ldx - end_of_jmp;
+			} else if ((BPF_MODE(insn->code) == BPF_PROBE_MEM ||
+				    BPF_MODE(insn->code) == BPF_PROBE_MEMSX)) {
+				start_of_ldx = prog;
 			}
 			if (BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
 			    BPF_MODE(insn->code) == BPF_MEMSX)
@@ -1924,9 +1927,13 @@ st:			if (is_imm8(insn->off))
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
2.43.0


