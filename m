Return-Path: <bpf+bounces-41340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3266D995DA7
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 04:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C431F2674F
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 02:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADC37346D;
	Wed,  9 Oct 2024 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbqNmZxP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F8415C3
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 02:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440001; cv=none; b=J9EeXE6u6ZHVKaCrcSo9jzO/0RVosWG3+lQ5iri3NoOivY7L3YHe/yqyo5GDhTWmwhxhkFmmg0JLpV7NMUBbME+Ct0AyUHrNEGEkCLBr+VUb2EAzGEydNgVgqHNox0InYI2ucGuJJFauYqgWnfBrQyFsg1X7k3PsGdXTeYH0AWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440001; c=relaxed/simple;
	bh=3kxqwmYhLNWtMTRYNObJ60B8rU/uFAus3kKtQphQYoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LYhYIHEGq1P0z7xNLPEEM1sIaB3C/vj9h3JPX+Icy1bgIM3t8NLWkiAh5woqnfy6cw7cfml5KPJc0vfV8E1xZfiNnA9cDdydrMop6RSZXc+NVpd1d3KHcpmGeNIgVaAcQiXckPphA69zRjuZaoxzcXFiMn4b9Iv4/z5cuR24esQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbqNmZxP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e27f9d2354so1209472a91.0
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 19:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728439999; x=1729044799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WxMIE7d6B/29s01PhSlk2HwNr3LCxy63AWWsYiEWYV8=;
        b=BbqNmZxP3QAAcmET/mCuJ1B5jc1ly1gIH/LZFamhyXo9l5OLwCm4boy8HjqhHWtnO0
         2ty/xR0dF+WUnUPJ11R+VDrLjy6vxhBKbws/AGIl3wz6fisfUslG5ylw8x9+k6NXNeOo
         U1gKmtxayii31b7o04Stb0zGTv+Bl2jDgfLghWfuTKY+Mo3hjbfZ4rs3qaYcqJC6fde2
         hpdD49QKAcO9SU2lk5no/U0upZj94QpY6zzN2dbYiMJbIeNN0rgQc+lr3IpVOvHQGDv8
         Uv6dKla0ljjYGZrjg28J10DiCKZb7IaBZOFdXdFrKY7c8WL4xkaMxzCeY8PNxtXMtJ/y
         haLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728439999; x=1729044799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxMIE7d6B/29s01PhSlk2HwNr3LCxy63AWWsYiEWYV8=;
        b=BG7YI9rdRUeLG86iKeKbGX6p4Z+MGYmNklgOWL6JilwZfKsp5bBUGSaW5UcVZMCPJk
         afRNvRHSBLxjt2F1swO3NYdz0Aw0fazhZaf8l9mB4pZ7tEjKRxn61zrJI9OukjLvBu9G
         Kq+YymequaIgX5mhnRGX94YHKlnjPoMcrbQydVfDOtdw/wF7knj/tLdWJD0OYxphBcrI
         FCP5Vz9SScgxdqWjAsab95bSFRJb0GZy84E2elvc0gr3rr3V8QHtBSU2OWBl4BuGVUdb
         QOrjdENXCLbFfkcGJvsZqiQlNJ+q2O3rwFhDwpIhvSRNcbr/mh47r4X8RX8TX735/1LB
         ntnQ==
X-Gm-Message-State: AOJu0YxPOXsnKg+UGbgn3FPpop/+wke9rTM2+Z7NlUDIpzKfMwADhbVA
	giZbBZFa5bge6eDLidRcfBZClHSsIrXo7TlUwYr0nYZ4yHmjOPXDkrLXQQ==
X-Google-Smtp-Source: AGHT+IER13hXn20MwIsQv2iNQrO9K0j4FX7oqEDIqcc2kWzCHrxSH/IcXd+EX0pCKK7G5fb2eZxVew==
X-Received: by 2002:a17:90a:c246:b0:2d3:da6d:8330 with SMTP id 98e67ed59e1d1-2e2a21e7d39mr1131322a91.4.1728439999137;
        Tue, 08 Oct 2024 19:13:19 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5a7579esm307696a91.51.2024.10.08.19.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 19:13:18 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 1/2] bpf: force checkpoints at loop back-edges
Date: Tue,  8 Oct 2024 19:12:53 -0700
Message-ID: <20241009021254.2805446-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In [1] syzbot reported an interesting BPF program.
Verification for this program takes a very long time.

[1] https://lore.kernel.org/bpf/670429f6.050a0220.49194.0517.GAE@google.com/

The program could be simplified to the following snippet:

    /* Program type is kprobe */
       r7 = *(u16 *)(r1 +0);
    1: r7 += 0x1ab064b9;
       if r7 & 0x702000 goto 1b;
       r7 &= 0x1ee60e;
       r7 += r1;
       if r7 s> 0x37d2 goto +0;
       r0 = 0;
       exit;

The snippet exhibits the following behaviour depending on
BPF_COMPLEXITY_LIMIT_INSNS:
- at 1,000,000 verification does not finish in 15 minutes;
- at 100,000 verification finishes in 15 seconds;
- at 100 it is possible to get some verifier log.

Perf report collected for verification of the snippet:

    99.34%        veristat
       99.34%        [kernel.kallsyms]
          71.25%        [k] __mark_chain_precision
          24.81%        [k] bt_sync_linked_regs
          ...

Fragment of the log collected with instruction limit set to 100:

    1: (07) r7 += 447767737               ; R7_w=scalar(...)
    2: (45) if r7 & 0x702000 goto pc-2
    mark_precise: frame0: last_idx 2 first_idx 2 subseq_idx -1
    mark_precise: frame0: regs=r7 stack= before 1: (07) r7 += 447767737
    mark_precise: frame0: regs=r7 stack= before 2: (45) if r7 & 0x702000 goto pc-2
      ... repeats 25 times ...
    mark_precise: frame0: regs=r7 stack= before 1: (07) r7 += 447767737
    mark_precise: frame0: regs=r7 stack= before 2: (45) if r7 & 0x702000 goto pc-2
    mark_precise: frame0: parent state regs= stack=:  R1_r=ctx() R7_rw=Pscalar(...) R10=fp0
    2: R7_w=scalar(...)
    1: (07) r7 += 447767737

This shows very long backtracking walks done by mark_chain_precision()
inside of the very small loop. Such backtracking walks terminate at
checkpoint state boundaries, but checkpoints are introduced too
infrequently for this loop.

This patch forcibly enables checkpoints for each loop back-edge.
This helps with the programs in question, as verification of both
syzbot program and reduced snippet finishes in ~2.5 sec.

However, this comes with some cost. Here are veristat results for
selftests listed in veristat.cfg and cillium BPF programs from [2].

[2] https://github.com/anakryiko/cilium

$ ./veristat -e file,prog,duration,insns,states -f 'states_pct>5' \
  -C master-baseline.log this-patch.log
File                        Program                               Duration (us) (DIFF)  Insns     (DIFF)  States       (DIFF)
--------------------------  ------------------------------------  --------------------  ----------------  -------------------
loop1.bpf.o                 nested_loops                              +52014 (+40.34%)       +0 (+0.00%)    +39649 (+720.37%)
loop2.bpf.o                 while_true                                +1308 (+161.48%)  +2861 (+160.46%)      +316 (+554.39%)
loop3.bpf.o                 while_true                              +350359 (+106.88%)       +0 (+0.00%)  +101448 (+1049.86%)
loop4.bpf.o                 combinations                                 -88 (-34.78%)    -221 (-42.18%)        +13 (+72.22%)
loop5.bpf.o                 while_true                                    +5 (+10.64%)       +3 (+3.57%)         +2 (+22.22%)
loop6.bpf.o                 trace_virtqueue_add_sgs                    -1886 (-34.01%)   -3717 (-37.38%)         +18 (+8.61%)
netif_receive_skb.bpf.o     trace_netif_receive_skb                        +5 (+0.04%)       +0 (+0.00%)      +562 (+111.29%)
profiler2.bpf.o             kprobe__vfs_link                           -1132 (-12.50%)    -1142 (-8.41%)       +158 (+53.20%)
profiler2.bpf.o             kprobe__vfs_symlink                        -1059 (-17.39%)   -1173 (-13.63%)        +77 (+37.75%)
profiler2.bpf.o             kprobe_ret__do_filp_open                     -465 (-8.40%)     -832 (-9.91%)        +84 (+40.00%)
profiler2.bpf.o             raw_tracepoint__sched_process_exit          -524 (-29.91%)   -1050 (-33.89%)          -5 (-6.02%)
profiler2.bpf.o             tracepoint__syscalls__sys_enter_kill       -4977 (-22.00%)   -4585 (-18.96%)         +70 (+6.75%)
pyperf600.bpf.o             on_event                                   +16312 (+0.81%)   -53870 (-9.81%)      -3000 (-10.16%)
strobemeta_nounroll1.bpf.o  on_event                                  -16609 (-40.28%)  -20944 (-38.87%)       -294 (-18.62%)
strobemeta_nounroll2.bpf.o  on_event                                  -22022 (-23.60%)  -40646 (-34.23%)       -578 (-15.41%)
strobemeta_subprogs.bpf.o   on_event                                  -17414 (-33.30%)  -19758 (-36.47%)       -185 (-12.33%)
test_sysctl_loop1.bpf.o     sysctl_tcp_mem                                +76 (+8.05%)      +60 (+4.33%)       +71 (+273.08%)
test_sysctl_loop2.bpf.o     sysctl_tcp_mem                              +156 (+13.38%)      +77 (+5.13%)       +82 (+282.76%)
xdp_synproxy_kern.bpf.o     syncookie_tc                               +8711 (+52.72%)   +3610 (+26.23%)       +209 (+53.87%)
xdp_synproxy_kern.bpf.o     syncookie_xdp                              +8571 (+50.01%)   +3610 (+26.10%)       +209 (+53.73%)

The test case 'state_loop_first_last_equal' needs an update because
checkpoints placement for it changed. (There is now a forced
checkpoint at 'l0'). The goal of the test is to check that there is a
jump history entry with the same last_idx/first_idx pair.
Update the test by moving 'if' instruction to 'l0',
so that total number of checkpoints in the test remains the same.
(But now interesting last_idx/first_idx pair is 1/1 instead of 4/4).

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c                         |  4 +++
 .../selftests/bpf/progs/verifier_precision.c  | 25 +++++++++++--------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7d9b38ffd220..3fa517b3fb57 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16055,9 +16055,11 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 	int *insn_state = env->cfg.insn_state;
 
 	if (e == FALLTHROUGH && insn_state[t] >= (DISCOVERED | FALLTHROUGH))
+		/* FALLTHROUGH from t already processed */
 		return DONE_EXPLORING;
 
 	if (e == BRANCH && insn_state[t] >= (DISCOVERED | BRANCH))
+		/* BRANCH from t already processed */
 		return DONE_EXPLORING;
 
 	if (w < 0 || w >= env->prog->len) {
@@ -16081,6 +16083,8 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 		insn_stack[env->cfg.cur_stack++] = w;
 		return KEEP_EXPLORING;
 	} else if ((insn_state[w] & 0xF0) == DISCOVERED) {
+		/* back-edge */
+		mark_force_checkpoint(env, w);
 		if (env->bpf_capable)
 			return DONE_EXPLORING;
 		verbose_linfo(env, t, "%d: ", t);
diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index 6b564d4c0986..7215c0cc0ccb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -95,34 +95,37 @@ __naked int bpf_end_bswap(void)
 SEC("?raw_tp")
 __success __log_level(2)
 /*
- * Without the bug fix there will be no history between "last_idx 3 first_idx 3"
+ * Without the bug fix there will be no history between "last_idx 1 first_idx 1"
  * and "parent state regs=" lines. "R0_w=6" parts are here to help anchor
  * expected log messages to the one specific mark_chain_precision operation.
  *
  * This is quite fragile: if verifier checkpointing heuristic changes, this
  * might need adjusting.
  */
-__msg("2: (07) r0 += 1                       ; R0_w=6")
-__msg("3: (35) if r0 >= 0xa goto pc+1")
-__msg("mark_precise: frame0: last_idx 3 first_idx 3 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r0 stack= before 2: (07) r0 += 1")
-__msg("mark_precise: frame0: regs=r0 stack= before 1: (07) r0 += 1")
+__msg("3: (07) r0 += 1                       ; R0_w=6")
+__msg("4: (05) goto pc-4")
+__msg("1: (35) if r0 >= 0xa goto pc+3")
+__msg("mark_precise: frame0: last_idx 1 first_idx 1 subseq_idx -1")
+__msg("mark_precise: frame0: parent state regs=r0 stack=:  R0_rw=P6 R1=ctx() R10=fp0")
+__msg("mark_precise: frame0: last_idx 4 first_idx 1 subseq_idx 1")
 __msg("mark_precise: frame0: regs=r0 stack= before 4: (05) goto pc-4")
-__msg("mark_precise: frame0: regs=r0 stack= before 3: (35) if r0 >= 0xa goto pc+1")
-__msg("mark_precise: frame0: parent state regs= stack=:  R0_rw=P4")
-__msg("3: R0_w=6")
+__msg("mark_precise: frame0: regs=r0 stack= before 3: (07) r0 += 1")
+__msg("mark_precise: frame0: regs=r0 stack= before 2: (07) r0 += 1")
+__msg("mark_precise: frame0: regs=r0 stack= before 1: (35) if r0 >= 0xa goto pc+3")
+__msg("mark_precise: frame0: parent state regs= stack=:  R0_rw=P4 R1=ctx() R10=fp0")
+__msg("1: R0=6")
 __naked int state_loop_first_last_equal(void)
 {
 	asm volatile (
 		"r0 = 0;"
 	"l0_%=:"
-		"r0 += 1;"
-		"r0 += 1;"
 		/* every few iterations we'll have a checkpoint here with
 		 * first_idx == last_idx, potentially confusing precision
 		 * backtracking logic
 		 */
 		"if r0 >= 10 goto l1_%=;"	/* checkpoint + mark_precise */
+		"r0 += 1;"
+		"r0 += 1;"
 		"goto l0_%=;"
 	"l1_%=:"
 		"exit;"
-- 
2.46.2


