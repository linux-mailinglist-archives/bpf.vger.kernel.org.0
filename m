Return-Path: <bpf+bounces-43009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E409ADAFF
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 06:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6831B1C2136E
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 04:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B091E16DEDF;
	Thu, 24 Oct 2024 04:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpuJ0Duw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D14155308;
	Thu, 24 Oct 2024 04:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729744923; cv=none; b=CGyTi/IIW8ZKc+KqHjhAPtK4PShRo+U6daSPffNDfl/IphGNQ1aqUtcNmqer5MT+K4M4UyPUOAfZtGtg1e9TCyppVOzrmJIneCibfUEmK8451FdC37sfRDlYVUh47inMw2MFXG6OtdJNsySfWy1C9QyfZGisXj9DoFyRBZWNLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729744923; c=relaxed/simple;
	bh=U8IRrTU/pt5P5yBPwVDyPSezRT9FW6UdCcA8/gGFhiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=szYhN9uNqm5dr+kY88F8Gv9+rjk1cWRzZ1qtuY5wCGs8MhmyrBFnRA1I7G4sgrwBVtfnYR3xNv5zVpUuDi330wDoSj+CfJcq7eEfW/8IzFj82pK0OlFTOe5ChOGEJjZ1NDTyCYly5NXCVX5EsueOEJG6XIesgzE7QwqgAVncv1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpuJ0Duw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B85C4CEC7;
	Thu, 24 Oct 2024 04:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729744922;
	bh=U8IRrTU/pt5P5yBPwVDyPSezRT9FW6UdCcA8/gGFhiM=;
	h=From:To:Cc:Subject:Date:From;
	b=mpuJ0Duwrveb/DT/GO5KLEkU46IUfW2Vqk+w56Mb8orDODkxFVsF9dn2fDJXdQ7wJ
	 d81HmV/9GN8INXFRVhNakM9TrnNzRhjtxF37+ch8KGEXWpDGyP9vRPqLBugFyKORD8
	 Ib+MqvWL6WQQW3QL7yEjxPvLZnPkw3WcNlWHiOErGT1N00ov+NsweHYV8sIE9YT3yM
	 y26CQaaF135YvL28ihqeG9b7QjR8dnidw2AEtb5LQos8xdp67JPqKolxaLFHG1RS88
	 0vvfrleWZrCttq2UGY0ImxHCKwarLx5ys++KW2I36YXsXdvEDCwDK0JSSW7C8yFuRz
	 EWzA3+Zr1wrxg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mingo@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 tip/perf/core 0/2] SRCU-protected uretprobes hot path
Date: Wed, 23 Oct 2024 21:41:57 -0700
Message-ID: <20241024044159.3156646-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Recently landed changes make uprobe entry hot code path makes use of RCU Tasks
Trace to avoid touching uprobe refcount, which at high frequency of uprobe
triggering leads to excessive cache line bouncing and limited scalability with
increased number of CPUs that simultaneously execute uprobe handlers.

This patch set adds return uprobe (uretprobe) side of this, this time
utilizing SRCU for the same reasons. Given the time between entry uprobe
activation (at which point uretprobe code hijacks user-space stack to get
activated on user function return) and uretprobe activation can be arbitrarily
long and is completely under control of user code, we need to protect
ourselves from too long or unbounded SRCU grace periods.

To that end we keep SRCU protection only for a limited time, and if user space
code takes longer to return, pending uretprobe instances are "downgraded" to
refcounted ones. This gives us best scalability and performance for
high-frequency uretprobes, and keeps upper bound on SRCU grace period duration
for low frequency uretprobes.

There are a bunch of synchronization issues between timer callback running in
IRQ handler and current thread executing uretprobe handlers, which is
abstracted away behind "hybrid lifetime uprobe" (hprobe) wrapper around uprobe
instance itself.

There is now a speculative try_get_uprobe() and, possibly, a compensating
put_uprobe() being done from the timer thread (softirq), so we need to make
sure that put_uprobe() is working well from any context. This is what patch #1
does, employing deferred work callback, and shifting all the locking to it.

v2->v3:
  - rebased onto peterz/queue.git's perf/core on top of Jiri's changes;
  - simplify hprobe states by utilizing HPROBE_GONE for NULL uprobe (Peter);
  - hprobe_expire() can return uprobe with refcount, if requested (Peter);
  - keep hprobe_init_leased() and hprobe_init_stable() to a) avoid srcu_idx
    bikeshedding dependency and b) leased constructor shouldn't accept NULL
    uprobe, so it's nice to be able to easily express and enforce that;
  - patch #1 stays the same, we'll work on uprobe_delayed_lock separately;
v1->v2:
  - dropped single-stepped uprobes changes to make this change a bit more
    palatable to Oleg and get some good will from him :)
  - fixed the bug with not calling __srcu_read_unlock when "expiring" leased
    uprobe, but failing to get refcount;
  - switched hprobe implementation to an explicit state machine, which seems
    to make logic more straightforward, evidenced by this allowing me to spot
    the above subtle LEASED -> GONE transition bug;
  - re-ran uprobe-stress many-many times, it was instrumental for getting
    confidence in implementation and spotting subtle bugs (including the above
    one, once I modified timer logic to ran at fixed interval to increase the
    probability of races with the normal uretprobe consumer code);
rfc->v1:
  - made put_uprobe() work in any context, not just user context (Oleg);
  - changed to unconditional mod_timer() usage to avoid races (Oleg).
  - I kept single-stepped uprobe changes, as they have a simple use of all the
    hprobe functionality developed in patch #1.

Andrii Nakryiko (2):
  uprobes: allow put_uprobe() from non-sleepable softirq context
  uprobes: SRCU-protect uretprobe lifetime (with timeout)

 include/linux/uprobes.h |  54 ++++++-
 kernel/events/uprobes.c | 309 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 322 insertions(+), 41 deletions(-)

-- 
2.43.5


