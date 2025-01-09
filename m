Return-Path: <bpf+bounces-48394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E824A078E8
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 15:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF8467A4DE4
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 14:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDEB219EAD;
	Thu,  9 Jan 2025 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ea/ZnCZb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6062163A1;
	Thu,  9 Jan 2025 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432085; cv=none; b=SHr3x+mrkNRBTXdBXiFGIYhLBpRbtDN3S2kziOFbFt4u+WzoF714M7ML+vN6s28eRV+aK3+oWBiwSJ3rYxtOp6OCerUlQrlr5SCCzBz4NtSS6McqKaA+WHncvcjEqgCX4PLT53BaZsCEUjk88+JpDB8aKnSixI+v79vDqFQ7igc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432085; c=relaxed/simple;
	bh=OAdEG1vf8tSr9JU1w/hnRQYfRNA9+KBF3HzkgcAvugM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EAo1dED9pQpmhD5FeePgPQs1Sz8HBPY07fW+HfgACjKjUORnmY+BJjUrntmm3vKz3pQIzI33yaL2nHFTIe8RLPYrfVVIOH6W30X7fA6sxoCo8UrdX+WoNMzvCPij1SKaw0PIRlGLrIhAjzKel6hQSqTMwhiTopbCGZPhUC5M+bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ea/ZnCZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C86EC4CED2;
	Thu,  9 Jan 2025 14:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736432085;
	bh=OAdEG1vf8tSr9JU1w/hnRQYfRNA9+KBF3HzkgcAvugM=;
	h=From:To:Cc:Subject:Date:From;
	b=ea/ZnCZb8SFKO7JjTGqfYY6Hl893I04+qF/Lr0JxAv7HGgZtKfs7AtxuBy57TiD/q
	 9T3YTWJYonIyDW2jkJQ+HkcrALc/NXl8//nXgoUx+fcy1sYzaoi1a8k+FYG5Uc2dW4
	 POP7KI8zFJVcov2k1tfsE9VT87R50XcmDq++TQTrz/ZYtciocOucJACHIPH185THZd
	 3NuZEGaNiUWYqZaNFbCcyHEm7+WH+WN9wGhXvB2VMF0mvbw5GqKZpJQyBGATyd4xIr
	 Nu/FqLu0oCQBktsMnGbvWL6/QdnaJh455bBUBuNem5ARO0rEAIrbCQBOPtP2IEaptQ
	 +Wymz8Ch0a0UQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Max Makarov <maxpain@linux.com>,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] uprobes: Fix race in uprobe_free_utask
Date: Thu,  9 Jan 2025 15:14:40 +0100
Message-ID: <20250109141440.2692173-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Max Makarov reported kernel panic [1] in perf user callchain code.

The reason for that is the race between uprobe_free_utask and bpf
profiler code doing the perf user stack unwind and is triggered
within uprobe_free_utask function:
  - after current->utask is freed and
  - before current->utask is set to NULL

 general protection fault, probably for non-canonical address 0x9e759c37ee555c76: 0000 [#1] SMP PTI
 RIP: 0010:is_uprobe_at_func_entry+0x28/0x80
 ...
  ? die_addr+0x36/0x90
  ? exc_general_protection+0x217/0x420
  ? asm_exc_general_protection+0x26/0x30
  ? is_uprobe_at_func_entry+0x28/0x80
  perf_callchain_user+0x20a/0x360
  get_perf_callchain+0x147/0x1d0
  bpf_get_stackid+0x60/0x90
  bpf_prog_9aac297fb833e2f5_do_perf_event+0x434/0x53b
  ? __smp_call_single_queue+0xad/0x120
  bpf_overflow_handler+0x75/0x110
  ...
  asm_sysvec_apic_timer_interrupt+0x1a/0x20
 RIP: 0010:__kmem_cache_free+0x1cb/0x350
 ...
  ? uprobe_free_utask+0x62/0x80
  ? acct_collect+0x4c/0x220
  uprobe_free_utask+0x62/0x80
  mm_release+0x12/0xb0
  do_exit+0x26b/0xaa0
  __x64_sys_exit+0x1b/0x20
  do_syscall_64+0x5a/0x80

It can be easily reproduced by running following commands in
separate terminals:

  # while :; do bpftrace -e 'uprobe:/bin/ls:_start  { printf("hit\n"); }' -c ls; done
  # bpftrace -e 'profile:hz:100000 { @[ustack()] = count(); }'

Fixing this by making sure current->utask pointer is set to NULL
before we start to release the utask object.

[1] https://github.com/grafana/pyroscope/issues/3673
Reported-by: Max Makarov <maxpain@linux.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index fa04b14a7d72..5d71ef85420c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1915,6 +1915,7 @@ void uprobe_free_utask(struct task_struct *t)
 	if (!utask)
 		return;
 
+	t->utask = NULL;
 	WARN_ON_ONCE(utask->active_uprobe || utask->xol_vaddr);
 
 	timer_delete_sync(&utask->ri_timer);
@@ -1924,7 +1925,6 @@ void uprobe_free_utask(struct task_struct *t)
 		ri = free_ret_instance(ri, true /* cleanup_hprobe */);
 
 	kfree(utask);
-	t->utask = NULL;
 }
 
 #define RI_TIMER_PERIOD (HZ / 10) /* 100 ms */
-- 
2.47.0


