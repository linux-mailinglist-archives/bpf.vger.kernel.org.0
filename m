Return-Path: <bpf+bounces-33540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAFE91EADE
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BB11F22968
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 22:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B292171650;
	Mon,  1 Jul 2024 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVKXxvYE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93EE84A2B;
	Mon,  1 Jul 2024 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719873579; cv=none; b=uMjxmYo0aLxGu0WEqk9V7IPXs09yKkRMc4Kx76fkcXoGmkv/76vRDPDydFCq24DWby6WFi8ZQl0MvLhh034fJvjdnuQvttq8TZA5N1eQzKnnqpzZ0ZI7tYYodFUIPt/yPJ4gJYnsGYap35Vt+EsFyXaAMVKM92bVAdYpI7B9zac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719873579; c=relaxed/simple;
	bh=VcemCeYUS40HCZgcrZISuSxnZJqGRxw5LVgWe2CMGxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hNA6UkeOYB0PE4Eamse7s/55nn2R8FwSDP2ncrb82qRKANuvC8hbGhJxaKbCPL0mMsH/IubS8SO+O7H5kMK1ZKdKPdOdwrTSbzNr9H6E1Oauy2cT0fYP2CGcsPwPCPLeshio4By0JlIoLVUK0bA74EAuhLHz/yFYVIP7x5R2NAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVKXxvYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00535C116B1;
	Mon,  1 Jul 2024 22:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719873579;
	bh=VcemCeYUS40HCZgcrZISuSxnZJqGRxw5LVgWe2CMGxc=;
	h=From:To:Cc:Subject:Date:From;
	b=SVKXxvYEYBC00UXBEVr4UPtSvDeDZcZ3LmlLreWulHeRmMrb8SUFaU2hvYi4xEWds
	 Wdxq34x4TkkCaBIo8RgqIyZu0elI3vwuciX+eDU0Xu6smruKpa+O5gK7t0nRrdHB3U
	 Ur3x33j99/l2/R8N7KCJOuRFoxXNsomZFQM+67d5s58LLT/BuH1SVTKvtKkbLupFV+
	 AtteGQTqLEaJXjK0Zenjsau3AB0e2IzfhXGPRGCJSbLCZs/ZzT+z2iC1Hs05kf6u7q
	 FKN7jFhB6BY7F5nDnN+o6XUsl42THyzvGNmcAD1Z5N5bs9Kho5kewHOQHbO/6Q+s3e
	 ojSXemfL2HBFA==
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
Subject: [PATCH v2 00/12] uprobes: add batched register/unregister APIs and per-CPU RW semaphore
Date: Mon,  1 Jul 2024 15:39:23 -0700
Message-ID: <20240701223935.3783951-1-andrii@kernel.org>
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

v1->v2:
  - added RCU-delayed uprobe freeing to put_uprobe() (Masami);
  - fixed clean up handling in uprobe_register_batch (Jiri);
  - adjusted UPROBE_REFCNT_* constants to be more meaningful (Oleg);
  - dropped the "fix" to switch to write-protected mmap_sem, adjusted invalid
    comment instead (Oleg).

Andrii Nakryiko (12):
  uprobes: update outdated comment
  uprobes: correct mmap_sem locking assumptions in uprobe_write_opcode()
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
 kernel/events/uprobes.c                       | 550 ++++++++++++------
 kernel/trace/bpf_trace.c                      |  40 +-
 kernel/trace/trace_uprobe.c                   |  53 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  22 +-
 5 files changed, 447 insertions(+), 247 deletions(-)

-- 
2.43.0


