Return-Path: <bpf+bounces-37506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27203956C58
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 15:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3591F22748
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F92316C69C;
	Mon, 19 Aug 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0v4/sOg"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF9F16B74D
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074888; cv=none; b=iJoznuaG1WPiIxjK/mzSTQ3Mx1sppixKBDMfOwHFi0FfMu0qG5WAlUfbBfqyLO5srz6uxZcDAE6ur1C3K7BLmHoazGs6QScoimCvnjViqnHdKpylKFf3um422u2uQtTh9ybbvP4ewV8/nA9ofOHpKL+M5Ym1B7T0f13T1hzrYyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074888; c=relaxed/simple;
	bh=eB5Y74Zx/sSE5nnvYuaBg++kv5XFfqNRDtJ49BBh1rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPCm4Lkq9Q/Xl2DPnpyfPIkOrMtfNfVDNXKGPUD4Q/QbIiR8batBIQaxytgfsTF88LzP3tjqniTPjF39Kl10qDwJzoas7XuKfo20OulM4AP3GiOtTC2gYtwjvfBVI73MRONg6dqYs1fLenu0u4nuYskiWRVhI84uJ9pktgVgcUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0v4/sOg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724074886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PnscDpV0loAdA10GHqqV4Sk/NPtRpYZGLZNubtluAas=;
	b=h0v4/sOgMPBNDzfQ+98SFnUrnVERIsu7WcJoOu39uohluUY14WTegFmBnDbf5yIKL7vIBx
	yop6WlAMmDVQedwYhkKFdBDUYRrLoh7Aydh9MoaqOHpMzvssq7hCD5AZYHiue4v9QuqmHx
	zpj0LYsNJjCDq/35/ub4IMhvUfWVBj0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-om71W1M8Mt-rOYGSwdksHw-1; Mon,
 19 Aug 2024 09:41:22 -0400
X-MC-Unique: om71W1M8Mt-rOYGSwdksHw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33EDE18EB228;
	Mon, 19 Aug 2024 13:41:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.68])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5CC2219560A3;
	Mon, 19 Aug 2024 13:41:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 19 Aug 2024 15:41:14 +0200 (CEST)
Date: Mon, 19 Aug 2024 15:41:08 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC v3 09/13] uprobes: SRCU-protect uretprobe lifetime
 (with timeout)
Message-ID: <20240819134107.GB3515@redhat.com>
References: <20240813042917.506057-1-andrii@kernel.org>
 <20240813042917.506057-10-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813042917.506057-10-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/12, Andrii Nakryiko wrote:
>
> Avoid taking refcount on uprobe in prepare_uretprobe(), instead take
> uretprobe-specific SRCU lock and keep it active as kernel transfers
> control back to user space.
...
>  include/linux/uprobes.h |  49 ++++++-
>  kernel/events/uprobes.c | 294 ++++++++++++++++++++++++++++++++++------
>  2 files changed, 301 insertions(+), 42 deletions(-)

Oh. To be honest I don't like this patch.

I would like to know what other reviewers think, but to me it adds too many
complications that I can't even fully understand...

And how much does it help performance-wise?

I'll try to take another look, and I'll try to think about other approaches,
not that I have something better in mind...


But lets forgets this patch for the moment. The next one adds even more
complications, and I think it doesn't make sense.

As I have already mentioned in the previous discussions, we can simply kill
utask->active_uprobe. And utask->auprobe.

So can't we start with the patch below? On top of your 08/13. It doesn't kill
utask->auprobe yet, this needs a bit more trivial changes.

What do you think?

Oleg.

-------------------------------------------------------------------------------
From d7cb674eb6f7bb891408b2b6a5fb872a6c2f0f6c Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Mon, 19 Aug 2024 15:34:55 +0200
Subject: [RFC PATCH] uprobe: kill uprobe_task->active_uprobe

Untested, not for inclusion yet, and I need to split it into 2 changes.
It does 2 simple things:

	1. active_uprobe != NULL is possible if and only if utask->state != 0,
	   so it turns the active_uprobe checks into the utask->state checks.

	2. handle_singlestep() doesn't really need ->active_uprobe, it only
	   needs uprobe->arch which is "const" after prepare_uprobe().

	   So this patch adds the new "arch_uprobe uarch" member into utask
	   and changes pre_ssout() to do memcpy(&utask->uarch, &uprobe->arch).
---
 include/linux/uprobes.h |  2 +-
 kernel/events/uprobes.c | 37 +++++++++++--------------------------
 2 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 3a3154b74fe0..df6f3dab032c 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -56,6 +56,7 @@ struct uprobe_task {
 
 	union {
 		struct {
+			struct arch_uprobe	uarch;
 			struct arch_uprobe_task	autask;
 			unsigned long		vaddr;
 		};
@@ -66,7 +67,6 @@ struct uprobe_task {
 		};
 	};
 
-	struct uprobe			*active_uprobe;
 	unsigned long			xol_vaddr;
 
 	struct arch_uprobe              *auprobe;
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index acc73c1bc54c..9689b557a5cf 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1721,7 +1721,7 @@ unsigned long uprobe_get_trap_addr(struct pt_regs *regs)
 {
 	struct uprobe_task *utask = current->utask;
 
-	if (unlikely(utask && utask->active_uprobe))
+	if (unlikely(utask && utask->state))
 		return utask->vaddr;
 
 	return instruction_pointer(regs);
@@ -1747,9 +1747,6 @@ void uprobe_free_utask(struct task_struct *t)
 	if (!utask)
 		return;
 
-	if (utask->active_uprobe)
-		put_uprobe(utask->active_uprobe);
-
 	ri = utask->return_instances;
 	while (ri)
 		ri = free_ret_instance(ri);
@@ -1965,14 +1962,9 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 	if (!utask)
 		return -ENOMEM;
 
-	if (!try_get_uprobe(uprobe))
-		return -EINVAL;
-
 	xol_vaddr = xol_get_insn_slot(uprobe);
-	if (!xol_vaddr) {
-		err = -ENOMEM;
-		goto err_out;
-	}
+	if (!xol_vaddr)
+		return -ENOMEM;
 
 	utask->xol_vaddr = xol_vaddr;
 	utask->vaddr = bp_vaddr;
@@ -1980,15 +1972,12 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 	err = arch_uprobe_pre_xol(&uprobe->arch, regs);
 	if (unlikely(err)) {
 		xol_free_insn_slot(current);
-		goto err_out;
+		return err;
 	}
 
-	utask->active_uprobe = uprobe;
+	memcpy(&utask->uarch, &uprobe->arch, sizeof(utask->uarch));
 	utask->state = UTASK_SSTEP;
 	return 0;
-err_out:
-	put_uprobe(uprobe);
-	return err;
 }
 
 /*
@@ -2005,7 +1994,7 @@ bool uprobe_deny_signal(void)
 	struct task_struct *t = current;
 	struct uprobe_task *utask = t->utask;
 
-	if (likely(!utask || !utask->active_uprobe))
+	if (likely(!utask || !utask->state))
 		return false;
 
 	WARN_ON_ONCE(utask->state != UTASK_SSTEP);
@@ -2313,19 +2302,15 @@ static void handle_swbp(struct pt_regs *regs)
  */
 static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
 {
-	struct uprobe *uprobe;
 	int err = 0;
 
-	uprobe = utask->active_uprobe;
 	if (utask->state == UTASK_SSTEP_ACK)
-		err = arch_uprobe_post_xol(&uprobe->arch, regs);
+		err = arch_uprobe_post_xol(&utask->uarch, regs);
 	else if (utask->state == UTASK_SSTEP_TRAPPED)
-		arch_uprobe_abort_xol(&uprobe->arch, regs);
+		arch_uprobe_abort_xol(&utask->uarch, regs);
 	else
 		WARN_ON_ONCE(1);
 
-	put_uprobe(uprobe);
-	utask->active_uprobe = NULL;
 	utask->state = UTASK_RUNNING;
 	xol_free_insn_slot(current);
 
@@ -2342,7 +2327,7 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
 /*
  * On breakpoint hit, breakpoint notifier sets the TIF_UPROBE flag and
  * allows the thread to return from interrupt. After that handle_swbp()
- * sets utask->active_uprobe.
+ * sets utask->state != 0.
  *
  * On singlestep exception, singlestep notifier sets the TIF_UPROBE flag
  * and allows the thread to return from interrupt.
@@ -2357,7 +2342,7 @@ void uprobe_notify_resume(struct pt_regs *regs)
 	clear_thread_flag(TIF_UPROBE);
 
 	utask = current->utask;
-	if (utask && utask->active_uprobe)
+	if (utask && utask->state)
 		handle_singlestep(utask, regs);
 	else
 		handle_swbp(regs);
@@ -2388,7 +2373,7 @@ int uprobe_post_sstep_notifier(struct pt_regs *regs)
 {
 	struct uprobe_task *utask = current->utask;
 
-	if (!current->mm || !utask || !utask->active_uprobe)
+	if (!current->mm || !utask || !utask->state)
 		/* task is currently not uprobed */
 		return 0;
 
-- 
2.25.1.362.g51ebf55



