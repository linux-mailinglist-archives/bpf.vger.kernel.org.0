Return-Path: <bpf+bounces-26331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2A389E5CE
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96501F224C9
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 22:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0482C158D9C;
	Tue,  9 Apr 2024 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNVhCnQD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7381B757F6;
	Tue,  9 Apr 2024 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712703344; cv=none; b=fuiE/9QcqlOrSTR3s13vH3zo9UUVHOI65JN5x5kINj4zDU4WxgijXqJsEd3wyFn6XfHPbMdO+fAkvprjzRL4X7tqN5W1duN44InVsjZyDv5wCZxHH8OrEKMWtAAvO/OO7QTh0L3+yx/+IpCF8Bue2MeKel6SzTY2/h+iKasboyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712703344; c=relaxed/simple;
	bh=AFB5JJxzNK0ssWsl0dAByIzKSEq22BTDirPDWg2fGr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFDG+G6rlOtGkVq7rkS8KG+fNYnO6b1uF8FHf3XFhMntpu6zYqyXRJTYOgncymZPqUQIDzKJ7X5C8lMA72oEMAGKU0r02JnPsR4V3OhFR14KBVGEycVW5XI0GL6iUUrp6b//hus5SqSGSw94gS3maao+fLlbLib5NZh1YNkl3R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNVhCnQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F749C433F1;
	Tue,  9 Apr 2024 22:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712703343;
	bh=AFB5JJxzNK0ssWsl0dAByIzKSEq22BTDirPDWg2fGr0=;
	h=From:To:Cc:Subject:Date:From;
	b=QNVhCnQDb33aAtFoSRkz5s4jbUOSu7zxI1O24mEXGmmBsCG5SmrWgvwL1v1X1dtYo
	 m1xjrrleKCM9BINwTdfNiyjfBLIzbUqFLuvELnPjLGoknpEXUlPez+XkxNLN+xsb/A
	 m/pnRojoDuXa+RYvfQnH9o194L+rBXzwqBUGE7HWKu+STfL4F7xzv9iaK/B5upu6m6
	 GkRAJ4RrDE9y1Z4eruIUydEFIC7CTyXUlI0vFPFhlzjOiUlsTcLQj86nQa0mI6u6+9
	 eEhVesQnv13FB9b9MQ/Cuy57LoFkRBABQtCkV8ijQCuoctfV/OtO40Whw7FFCEKxQ0
	 eAw22zzJc9ahw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH v2] perf lock contention: Add a missing NULL check
Date: Tue,  9 Apr 2024 15:55:42 -0700
Message-ID: <20240409225542.1870999-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I got a report for a failure in BPF verifier on a recent kernel with
perf lock contention command.  It checks task->sighand->siglock without
checking if sighand is NULL or not.  Let's add one.

  ; if (&curr->sighand->siglock == (void *)lock)
  265: (79) r1 = *(u64 *)(r0 +2624)     ; frame1: R0_w=trusted_ptr_task_struct(off=0,imm=0)
                                        ;         R1_w=rcu_ptr_or_null_sighand_struct(off=0,imm=0)
  266: (b7) r2 = 0                      ; frame1: R2_w=0
  267: (0f) r1 += r2
  R1 pointer arithmetic on rcu_ptr_or_null_ prohibited, null-check it first
  processed 164 insns (limit 1000000) max_states_per_insn 1 total_states 15 peak_states 15 mark_read 5
  -- END PROG LOAD LOG --
  libbpf: prog 'contention_end': failed to load: -13
  libbpf: failed to load object 'lock_contention_bpf'
  libbpf: failed to load BPF skeleton 'lock_contention_bpf': -13
  Failed to load lock-contention BPF skeleton
  lock contention BPF setup failed
  lock contention did not detect any lock contention

Fixes: 1811e82767dcc ("perf lock contention: Track and show siglock with address")
Reviewed-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index fb54bd38e7d0..d931a898c434 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -284,6 +284,7 @@ static inline __u32 check_lock_type(__u64 lock, __u32 flags)
 	struct task_struct *curr;
 	struct mm_struct___old *mm_old;
 	struct mm_struct___new *mm_new;
+	struct sighand_struct *sighand;
 
 	switch (flags) {
 	case LCB_F_READ:  /* rwsem */
@@ -305,7 +306,9 @@ static inline __u32 check_lock_type(__u64 lock, __u32 flags)
 		break;
 	case LCB_F_SPIN:  /* spinlock */
 		curr = bpf_get_current_task_btf();
-		if (&curr->sighand->siglock == (void *)lock)
+		sighand = curr->sighand;
+
+		if (sighand && &sighand->siglock == (void *)lock)
 			return LCD_F_SIGHAND_LOCK;
 		break;
 	default:
-- 
2.44.0.478.gd926399ef9-goog


