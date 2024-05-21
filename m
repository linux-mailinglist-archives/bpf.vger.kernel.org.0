Return-Path: <bpf+bounces-30089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B598CA7A4
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 07:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B049B2202B
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 05:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C3E3F8C7;
	Tue, 21 May 2024 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhOTSKuM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169B58836;
	Tue, 21 May 2024 05:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716269453; cv=none; b=rqwDHVr5qknyNjha3/H/zrlj8SU245Bl2kN84JZbdDAx4bBQ3QFjRIhWetErI6FhFa0mDBGptWjBT/VYoif4T7yVXpQhzM9piLgQqPpzVa5m1gUoEywo1V1WVT1WCXEFkLG/UbwBQrQOR1Yj829/bzND1RZ0+QQn20xp5NiTUkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716269453; c=relaxed/simple;
	bh=tmFYAnZ399DtCaaCLZqcJMIYNXQT2/24auFWFxtMNHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HtTkDDj8dNWqWLU0zrhUXmw65SNyElGIiU1k2yFscnmlyg666FzGq5s81eOEWzgJlSD7dE3eoy2bgLkhn/8IdHNY/xyW2wEjqu4Vke88w8IQMJ/4MpciH0WoiVW2h+lu1CBvm7XdDYFvuUnkCm9dLmqfRFtOVopeWZXGNENgr6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhOTSKuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8DCC2BD11;
	Tue, 21 May 2024 05:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716269452;
	bh=tmFYAnZ399DtCaaCLZqcJMIYNXQT2/24auFWFxtMNHw=;
	h=From:To:Cc:Subject:Date:From;
	b=RhOTSKuMx2i5jsmJkj+EjHrXkq9apEsdvXzzQ0CHQeUlexGVMaOY6ZxTPt2xv7lb7
	 +5hfVPG8mqr6Ko76Uo7Pxg1Oylnpq0r4x6hgERQm1UbOElL1yY0MnaDNWULdpQDAYM
	 VTqjQ247kucKClu/ewzUA6u8sDMzQmkYSEWEAQ7UWokuEMNAaVnajEiftGY1FMC7v7
	 kbguqNtqXhq3WSeJ+WT0AQGLyRiNQo5gezPxF2l3QDEHRsGXrxi1IjvuE/QUdefar2
	 ToOGjRMaocQv32AuBnO+gynleLRINkiQ52YsfqFN8/3MrTyc/iTAG3Nc7mJvpKiIpi
	 0ktmzcjnR3sGw==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	oleg@redhat.com,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH] uprobes: prevent mutex_lock() under rcu_read_lock()
Date: Mon, 20 May 2024 22:30:17 -0700
Message-ID: <20240521053017.3708530-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent changes made uprobe_cpu_buffer preparation lazy, and moved it
deeper into __uprobe_trace_func(). This is problematic because
__uprobe_trace_func() is called inside rcu_read_lock()/rcu_read_unlock()
block, which then calls prepare_uprobe_buffer() -> uprobe_buffer_get() ->
mutex_lock(&ucb->mutex), leading to a splat about using mutex under
non-sleepable RCU:

  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:585
   in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 98231, name: stress-ng-sigq
   preempt_count: 0, expected: 0
   RCU nest depth: 1, expected: 0
   ...
   Call Trace:
    <TASK>
    dump_stack_lvl+0x3d/0xe0
    __might_resched+0x24c/0x270
    ? prepare_uprobe_buffer+0xd5/0x1d0
    __mutex_lock+0x41/0x820
    ? ___perf_sw_event+0x206/0x290
    ? __perf_event_task_sched_in+0x54/0x660
    ? __perf_event_task_sched_in+0x54/0x660
    prepare_uprobe_buffer+0xd5/0x1d0
    __uprobe_trace_func+0x4a/0x140
    uprobe_dispatcher+0x135/0x280
    ? uprobe_dispatcher+0x94/0x280
    uprobe_notify_resume+0x650/0xec0
    ? atomic_notifier_call_chain+0x21/0x110
    ? atomic_notifier_call_chain+0xf8/0x110
    irqentry_exit_to_user_mode+0xe2/0x1e0
    asm_exc_int3+0x35/0x40
   RIP: 0033:0x7f7e1d4da390
   Code: 33 04 00 0f 1f 80 00 00 00 00 f3 0f 1e fa b9 01 00 00 00 e9 b2 fc ff ff 66 90 f3 0f 1e fa 31 c9 e9 a5 fc ff ff 0f 1f 44 00 00 <cc> 0f 1e fa b8 27 00 00 00 0f 05 c3 0f 1f 40 00 f3 0f 1e fa b8 6e
   RSP: 002b:00007ffd2abc3608 EFLAGS: 00000246
   RAX: 0000000000000000 RBX: 0000000076d325f1 RCX: 0000000000000000
   RDX: 0000000076d325f1 RSI: 000000000000000a RDI: 00007ffd2abc3690
   RBP: 000000000000000a R08: 00017fb700000000 R09: 00017fb700000000
   R10: 00017fb700000000 R11: 0000000000000246 R12: 0000000000017ff2
   R13: 00007ffd2abc3610 R14: 0000000000000000 R15: 00007ffd2abc3780
    </TASK>

Luckily, it's easy to fix by moving prepare_uprobe_buffer() to be called
slightly earlier: into uprobe_trace_func() and uretprobe_trace_func(), outside
of RCU locked section. This still keeps this buffer preparation lazy and helps
avoid the overhead when it's not needed. E.g., if there is only BPF uprobe
handler installed on a given uprobe, buffer won't be initialized.

Note, the other user of prepare_uprobe_buffer(), __uprobe_perf_func(), is not
affected, as it doesn't prepare buffer under RCU read lock.

Fixes: 1b8f85defbc8 ("uprobes: prepare uprobe args buffer lazily")
Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/trace_uprobe.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 8541fa1494ae..c98e3b3386ba 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -970,19 +970,17 @@ static struct uprobe_cpu_buffer *prepare_uprobe_buffer(struct trace_uprobe *tu,
 
 static void __uprobe_trace_func(struct trace_uprobe *tu,
 				unsigned long func, struct pt_regs *regs,
-				struct uprobe_cpu_buffer **ucbp,
+				struct uprobe_cpu_buffer *ucb,
 				struct trace_event_file *trace_file)
 {
 	struct uprobe_trace_entry_head *entry;
 	struct trace_event_buffer fbuffer;
-	struct uprobe_cpu_buffer *ucb;
 	void *data;
 	int size, esize;
 	struct trace_event_call *call = trace_probe_event_call(&tu->tp);
 
 	WARN_ON(call != trace_file->event_call);
 
-	ucb = prepare_uprobe_buffer(tu, regs, ucbp);
 	if (WARN_ON_ONCE(ucb->dsize > PAGE_SIZE))
 		return;
 
@@ -1014,13 +1012,16 @@ static int uprobe_trace_func(struct trace_uprobe *tu, struct pt_regs *regs,
 			     struct uprobe_cpu_buffer **ucbp)
 {
 	struct event_file_link *link;
+	struct uprobe_cpu_buffer *ucb;
 
 	if (is_ret_probe(tu))
 		return 0;
 
+	ucb = prepare_uprobe_buffer(tu, regs, ucbp);
+
 	rcu_read_lock();
 	trace_probe_for_each_link_rcu(link, &tu->tp)
-		__uprobe_trace_func(tu, 0, regs, ucbp, link->file);
+		__uprobe_trace_func(tu, 0, regs, ucb, link->file);
 	rcu_read_unlock();
 
 	return 0;
@@ -1031,10 +1032,13 @@ static void uretprobe_trace_func(struct trace_uprobe *tu, unsigned long func,
 				 struct uprobe_cpu_buffer **ucbp)
 {
 	struct event_file_link *link;
+	struct uprobe_cpu_buffer *ucb;
+
+	ucb = prepare_uprobe_buffer(tu, regs, ucbp);
 
 	rcu_read_lock();
 	trace_probe_for_each_link_rcu(link, &tu->tp)
-		__uprobe_trace_func(tu, func, regs, ucbp, link->file);
+		__uprobe_trace_func(tu, func, regs, ucb, link->file);
 	rcu_read_unlock();
 }
 
-- 
2.43.0


