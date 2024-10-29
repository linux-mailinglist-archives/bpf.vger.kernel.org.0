Return-Path: <bpf+bounces-43409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE489B52D9
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 20:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C579282A76
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 19:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2F720720A;
	Tue, 29 Oct 2024 19:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuFB0GMP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DA21DDA2D
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230767; cv=none; b=cYSmUftzCuiXtlNcxsmKQlPnK8qhlVksiAfTuXgj5Q32pQUeMgvdIzk0sD+LEMRxNMnnxu/54j5LXjDWSo2bh2IqcGtowU3fiyKT0obRjOo4KGpgtFaYuAI6e3NRsGMWVja42WOfKa/YuKIgPKInKlcfDjOifb38VdxRgmfgS4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230767; c=relaxed/simple;
	bh=WrXKTQr95pLj1evwtfmfyc9kLqBuR9opgRelzz+539c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yct9BPFaS8uiIY60a45WoIZpVGACX3P24ARx4yr93ZYv3r5xhNliuaXTQPpHO+aJ4SKOvoU5i5CdYOhLYV0W4oYv2M8GOqxg0T+LOpjkCeldF7ogXUBHEGEWIjIdQbjQ4foPVAqDdSRag3sGCtH1Lbt6lW/VasTh8PXdrz+eD+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuFB0GMP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c8b557f91so55189755ad.2
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730230764; x=1730835564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EeZ2mA3+rO7MnYFoqOG0COXp26DnIuLtmmHIgcw/weM=;
        b=OuFB0GMPQWZvfieAsNmol8puS8YK5HcIiveb0CIWe2y96g7ijcjGm4fdm5Y/9fSOeU
         M9PeM0MXUfzVzzV99kMOgfPy0KwCHFWuM2NdfSATeq85tSUdNcetjFrOH3jDrdAZxc4g
         Fys7v4ZfRiChNrzwHfiR3iQPojhgNtQLr1jf31GlQFtr/n2rnDTPmVzOdc+sOnF9u3CR
         A8Kpi8AeIwDn3F6BXWDWvCOkLcqQvX6vGcfMbVM+Ze1cveJpkGkX+uRcjjPxUOISUaQ4
         4zCdpauhXL4ytAtojtLmq5M/xoeqmNREUDBXFroissSmZEz0MrhsB7YUG8LSWX1cRgyB
         36Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730230764; x=1730835564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EeZ2mA3+rO7MnYFoqOG0COXp26DnIuLtmmHIgcw/weM=;
        b=qVVZGIT1Qin35m9FtYB7Wjtw1qXgDmtt6unOKbWIjtLJZpChv6dkShbKtfPSArppS5
         r8hVDjDtnJIN+dZFRn/9kKXBbx/GN/Ti/iMNlJhsiLzSNpl6jfZoVPMLvdKg5r6CvInh
         sUomPY8FB5B8/JRizrhMiFA7RWmWwHBGF1YWGBJ7unzpdgDIBmC2MLpwYnKubfZdyLFT
         JGvPkEIEHn8vZ5WUnPPFqA5VOKGSGh9fuoITpsuVQMp4CwwRTwXnWK1q+PwEgdBgsU0j
         k747KGCEdAmYRCDcYDCjyG9V3HMQ7YGgzV7edY27SametkeijtQcHufNq7vlJmb5TGEE
         WwoA==
X-Gm-Message-State: AOJu0YxS88G3l0We7yscK8P5ntduuI7z2SfoP0St2ubXP9a9uBvpGZyn
	cLCsob/FhJzBLeRCFJ3yAX+nmZe6INls5MCBkDzqaRYOmWkWXcb18p+KGA==
X-Google-Smtp-Source: AGHT+IGLsyuiRYxFFdzbOBzak475vNdeL0GxpIgV8eQTIbnHx8tHyJgiFBQuWcmVgAxwcCAU99RNyA==
X-Received: by 2002:a17:902:dac9:b0:207:7eaa:d6bb with SMTP id d9443c01a7336-210c6c091b6mr184881565ad.29.1730230763943;
        Tue, 29 Oct 2024 12:39:23 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6dcbasm69978655ad.98.2024.10.29.12.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 12:39:23 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hou Tao <houtao@huaweicloud.com>
Subject: [PATCH bpf] bpf: disallow 40-bytes extra stack for bpf_fastcall patterns
Date: Tue, 29 Oct 2024 12:39:11 -0700
Message-ID: <20241029193911.1575719-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hou Tao reported an issue with bpf_fastcall patterns allowing extra
stack space above MAX_BPF_STACK limit. This extra stack allowance is
not integrated properly with the following verifier parts:
- backtracking logic still assumes that stack can't exceed
  MAX_BPF_STACK;
- bpf_verifier_env->scratched_stack_slots assumes only 64 slots are
  available.

Here is an example of an issue with precision tracking
(note stack slot -8 tracked as precise instead of -520):

    0: (b7) r1 = 42                       ; R1_w=42
    1: (b7) r2 = 42                       ; R2_w=42
    2: (7b) *(u64 *)(r10 -512) = r1       ; R1_w=42 R10=fp0 fp-512_w=42
    3: (7b) *(u64 *)(r10 -520) = r2       ; R2_w=42 R10=fp0 fp-520_w=42
    4: (85) call bpf_get_smp_processor_id#8       ; R0_w=scalar(...)
    5: (79) r2 = *(u64 *)(r10 -520)       ; R2_w=42 R10=fp0 fp-520_w=42
    6: (79) r1 = *(u64 *)(r10 -512)       ; R1_w=42 R10=fp0 fp-512_w=42
    7: (bf) r3 = r10                      ; R3_w=fp0 R10=fp0
    8: (0f) r3 += r2
    mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx -1
    mark_precise: frame0: regs=r2 stack= before 7: (bf) r3 = r10
    mark_precise: frame0: regs=r2 stack= before 6: (79) r1 = *(u64 *)(r10 -512)
    mark_precise: frame0: regs=r2 stack= before 5: (79) r2 = *(u64 *)(r10 -520)
    mark_precise: frame0: regs= stack=-8 before 4: (85) call bpf_get_smp_processor_id#8
    mark_precise: frame0: regs= stack=-8 before 3: (7b) *(u64 *)(r10 -520) = r2
    mark_precise: frame0: regs=r2 stack= before 2: (7b) *(u64 *)(r10 -512) = r1
    mark_precise: frame0: regs=r2 stack= before 1: (b7) r2 = 42
    9: R2_w=42 R3_w=fp42
    9: (95) exit

This patch disables the additional allowance for the moment.
Also, two test cases are removed:
- bpf_fastcall_max_stack_ok:
  it fails w/o additional stack allowance;
- bpf_fastcall_max_stack_fail:
  this test is no longer necessary, stack size follows
  regular rules, pattern invalidation is checked by other
  test cases.

Reported-by: Hou Tao <houtao@huaweicloud.com>
Closes: https://lore.kernel.org/bpf/20241023022752.172005-1-houtao@huaweicloud.com/
Fixes: 5b5f51bff1b6 ("bpf: no_caller_saved_registers attribute for helper calls")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c                         | 14 +----
 .../bpf/progs/verifier_bpf_fastcall.c         | 55 -------------------
 2 files changed, 2 insertions(+), 67 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 587a6c76e564..a494396bef2a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6804,20 +6804,10 @@ static int check_stack_slot_within_bounds(struct bpf_verifier_env *env,
                                           struct bpf_func_state *state,
                                           enum bpf_access_type t)
 {
-	struct bpf_insn_aux_data *aux = &env->insn_aux_data[env->insn_idx];
-	int min_valid_off, max_bpf_stack;
-
-	/* If accessing instruction is a spill/fill from bpf_fastcall pattern,
-	 * add room for all caller saved registers below MAX_BPF_STACK.
-	 * In case if bpf_fastcall rewrite won't happen maximal stack depth
-	 * would be checked by check_max_stack_depth_subprog().
-	 */
-	max_bpf_stack = MAX_BPF_STACK;
-	if (aux->fastcall_pattern)
-		max_bpf_stack += CALLER_SAVED_REGS * BPF_REG_SIZE;
+	int min_valid_off;
 
 	if (t == BPF_WRITE || env->allow_uninit_stack)
-		min_valid_off = -max_bpf_stack;
+		min_valid_off = -MAX_BPF_STACK;
 	else
 		min_valid_off = -state->allocated_stack;
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index 9da97d2efcd9..5094c288cfd7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -790,61 +790,6 @@ __naked static void cumulative_stack_depth_subprog(void)
 	:: __imm(bpf_get_smp_processor_id) : __clobber_all);
 }
 
-SEC("raw_tp")
-__arch_x86_64
-__log_level(4)
-__msg("stack depth 512")
-__xlated("0: r1 = 42")
-__xlated("1: *(u64 *)(r10 -512) = r1")
-__xlated("2: w0 = ")
-__xlated("3: r0 = &(void __percpu *)(r0)")
-__xlated("4: r0 = *(u32 *)(r0 +0)")
-__xlated("5: exit")
-__success
-__naked int bpf_fastcall_max_stack_ok(void)
-{
-	asm volatile(
-	"r1 = 42;"
-	"*(u64 *)(r10 - %[max_bpf_stack]) = r1;"
-	"*(u64 *)(r10 - %[max_bpf_stack_8]) = r1;"
-	"call %[bpf_get_smp_processor_id];"
-	"r1 = *(u64 *)(r10 - %[max_bpf_stack_8]);"
-	"exit;"
-	:
-	: __imm_const(max_bpf_stack, MAX_BPF_STACK),
-	  __imm_const(max_bpf_stack_8, MAX_BPF_STACK + 8),
-	  __imm(bpf_get_smp_processor_id)
-	: __clobber_all
-	);
-}
-
-SEC("raw_tp")
-__arch_x86_64
-__log_level(4)
-__msg("stack depth 520")
-__failure
-__naked int bpf_fastcall_max_stack_fail(void)
-{
-	asm volatile(
-	"r1 = 42;"
-	"*(u64 *)(r10 - %[max_bpf_stack]) = r1;"
-	"*(u64 *)(r10 - %[max_bpf_stack_8]) = r1;"
-	"call %[bpf_get_smp_processor_id];"
-	"r1 = *(u64 *)(r10 - %[max_bpf_stack_8]);"
-	/* call to prandom blocks bpf_fastcall rewrite */
-	"*(u64 *)(r10 - %[max_bpf_stack_8]) = r1;"
-	"call %[bpf_get_prandom_u32];"
-	"r1 = *(u64 *)(r10 - %[max_bpf_stack_8]);"
-	"exit;"
-	:
-	: __imm_const(max_bpf_stack, MAX_BPF_STACK),
-	  __imm_const(max_bpf_stack_8, MAX_BPF_STACK + 8),
-	  __imm(bpf_get_smp_processor_id),
-	  __imm(bpf_get_prandom_u32)
-	: __clobber_all
-	);
-}
-
 SEC("cgroup/getsockname_unix")
 __xlated("0: r2 = 1")
 /* bpf_cast_to_kern_ctx is replaced by a single assignment */
-- 
2.47.0


