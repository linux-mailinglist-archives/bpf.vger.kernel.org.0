Return-Path: <bpf+bounces-27593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAA08AF951
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 23:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18C51C24560
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 21:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05107144D2E;
	Tue, 23 Apr 2024 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LlOD8sg/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798EC14388D;
	Tue, 23 Apr 2024 21:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908505; cv=none; b=rXfuyV9XR05wcC54klvUsYzLLcPZKJq96+jfjudm25uQzIaglkeV6HCPxKaJZLFDx7f1mPYBkLmRyydyTq9XbRGmKbvnkEi6saEvelFTwLRdLsRm35tem5nBlmDb5rPelgL0rxHn67UULHumWtzJDNWkdTtUHXv+X39zB0Vpiwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908505; c=relaxed/simple;
	bh=CExlSkHgH0tyCbljyaKTd5oE2X8dmxwpHc61O1PkWUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6R8B02pCpJLhOH8WQQoJN6o/I2DlbGD+VoYIHCm4gVCUC13wD3DQ3/cB7vcKeBtyA44BW2UkvgRZt7OvkYWVqkw5LL5KqzZnbuxFyyYyzvj5vfWeAtIVFqSGa5wuWM+XAIlZQOVQHnheH/j3Ft8yxYS8CM0vnBnXQdRDAbxk2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LlOD8sg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB23C32783;
	Tue, 23 Apr 2024 21:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908505;
	bh=CExlSkHgH0tyCbljyaKTd5oE2X8dmxwpHc61O1PkWUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LlOD8sg/6ximsKtgmGyO57L6OrMAAqBu3CrTMql5sy5W8T4ExRsI4BnVReiZ1b9G1
	 nIiHBbHUYqhL50rwSWL6YWeLmyaXafn8wM67zKi6XNlK7FHdj/A7FG5VHce8rfsKnE
	 c4lMUwdQFtGM8Csyuhmx4j5Djykz1QaoozTt+//E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 059/158] perf lock contention: Add a missing NULL check
Date: Tue, 23 Apr 2024 14:38:01 -0700
Message-ID: <20240423213857.872307501@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
References: <20240423213855.824778126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit f3408580bac8ce5cd76e7391e529c0a22e7c7eb2 ]

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
Link: https://lore.kernel.org/r/20240409225542.1870999-1-namhyung@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 95cd8414f6ef8..e5d78565f479f 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -289,6 +289,7 @@ static inline __u32 check_lock_type(__u64 lock, __u32 flags)
 	struct task_struct *curr;
 	struct mm_struct___old *mm_old;
 	struct mm_struct___new *mm_new;
+	struct sighand_struct *sighand;
 
 	switch (flags) {
 	case LCB_F_READ:  /* rwsem */
@@ -310,7 +311,9 @@ static inline __u32 check_lock_type(__u64 lock, __u32 flags)
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
2.43.0




