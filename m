Return-Path: <bpf+bounces-32962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE55915AED
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 02:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7050B2143D
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 00:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304B84C83;
	Tue, 25 Jun 2024 00:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0Rds3UJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2A4C70;
	Tue, 25 Jun 2024 00:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274912; cv=none; b=PD8JN6j4bauWubcgfvJsdhfzBP9gfq7xr1CQdzQvAtQyLBqiXsu143N9hKefxlDwJ/JHWlilqRMWnjwbnyzY2ZY5m71+DTe/p8C0CdhT2n5tWdRmiTEzVNKrT6L605LxDIMuNKS1Gt7SCJZuClRHB90rnU8Ofh0+K9N7H3bQkSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274912; c=relaxed/simple;
	bh=EEoU701Lp5g4fgWsox0U5BO2BQ90YsK48K1PsLz8tDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cvoKRstXlfYpx4QioCGVCGUVc8mG6rbDUd/lZg9mJCrgaSuMEZnxoPEVIiyPipF1zaDavQyeevP5pzSCWUka4VZRE3aq+ftC2B3sqnrqWd0h4aij4Par+kgUhvWDnZv2CueYBWbDFbn8st6qTBtb3sGCxEHLCkYJaU42gHg0uHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0Rds3UJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E74BC2BBFC;
	Tue, 25 Jun 2024 00:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719274912;
	bh=EEoU701Lp5g4fgWsox0U5BO2BQ90YsK48K1PsLz8tDg=;
	h=From:To:Cc:Subject:Date:From;
	b=T0Rds3UJ77VQCi8hGbb4dfXG8TLGoj0wJJWtNDG+Br65usoQA8ATwft8BaQU/4BZG
	 /xFgQm0Q6pSnD27hnUepiEg31NqyA4j6x4Hqn6itgWIvgRcRfTSxpSpM7A6e/ANokO
	 fmgs37UKv2rgtsMctQBN8LHsBMjVQHDM4MHDVaufHk9wx43XHIDDvLfo0otjIcJIRu
	 N7totTQWbMvy7FSXM3QlSUz/H41nKipka1udTYhIqOghKoSU3+e4f1mywwV/9ZOp6u
	 nXpoKs4IM9oo11dztwkHBY2saqotCZW4yR/OV/UXwY/8+KLH+YNhvdKbcovKaxrZr4
	 M4lxHkGCii23Q==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	oleg@redhat.com
Cc: peterz@infradead.org,
	mingo@redhat.com,
	bpf@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	clm@meta.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 00/12] uprobes: add batched register/unregister APIs and per-CPU RW semaphore
Date: Mon, 24 Jun 2024 17:21:32 -0700
Message-ID: <20240625002144.3485799-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set, ultimately, switches global uprobes_treelock from RW spinlock
to per-CPU RW semaphore, which has better performance and scales better under
contention and multiple parallel threads triggering lots of uprobes.

To make this work well with attaching multiple uprobes (through BPF
multi-uprobe), we need to add batched versions of uprobe register/unregister
APIs. This is what most of the patch set is actually doing. The actual switch
to per-CPU RW semaphore is trivial after that and is done in the very last
patch #12. See commit message with some comparison numbers.

Patch #4 is probably the most important patch in the series, revamping uprobe
lifetime management and refcounting. See patch description and added code
comments for all the details.

With changes in patch #4, we open up the way to refactor uprobe_register() and
uprobe_unregister() implementations in such a way that we can avoid taking
uprobes_treelock many times during a single batched attachment/detachment.
This allows to accommodate a much higher latency of taking per-CPU RW
semaphore for write. The end result of this patch set is that attaching 50
thousand uprobes with BPF multi-uprobes doesn't regress and takes about 200ms
both before and after the changes in this patch set.

Patch #5 updates existing uprobe consumers to put all the relevant necessary
pieces into struct uprobe_consumer, without having to pass around
offset/ref_ctr_offset. Existing consumers already keep this data around, we
just formalize the interface.

Patches #6 through #10 add batched versions of register/unregister APIs and
gradually factor them in such a way as to allow taking single (batched)
uprobes_treelock, splitting the logic into multiple independent phases.

Patch #11 switched BPF multi-uprobes to batched uprobe APIs.

As mentioned, a very straightforward patch #12 takes advantage of all the prep
work and just switches uprobes_treelock to per-CPU RW semaphore.

Andrii Nakryiko (12):
  uprobes: update outdated comment
  uprobes: grab write mmap lock in unapply_uprobe()
  uprobes: simplify error handling for alloc_uprobe()
  uprobes: revamp uprobe refcounting and lifetime management
  uprobes: move offset and ref_ctr_offset into uprobe_consumer
  uprobes: add batch uprobe register/unregister APIs
  uprobes: inline alloc_uprobe() logic into __uprobe_register()
  uprobes: split uprobe allocation and uprobes_tree insertion steps
  uprobes: batch uprobes_treelock during registration
  uprobes: improve lock batching for uprobe_unregister_batch
  uprobes,bpf: switch to batch uprobe APIs for BPF multi-uprobes
  uprobes: switch uprobes_treelock to per-CPU RW semaphore

 include/linux/uprobes.h                       |  29 +-
 kernel/events/uprobes.c                       | 522 ++++++++++++------
 kernel/trace/bpf_trace.c                      |  40 +-
 kernel/trace/trace_uprobe.c                   |  53 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  23 +-
 5 files changed, 419 insertions(+), 248 deletions(-)

-- 
2.43.0


