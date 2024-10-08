Return-Path: <bpf+bounces-41164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 318A4993BBD
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 02:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64891F23806
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 00:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FAC8BEE;
	Tue,  8 Oct 2024 00:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfPKuaGK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7145420ED;
	Tue,  8 Oct 2024 00:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728347159; cv=none; b=DWKl+13SmzHWY5M0/GTp6AjoHM8k9ejmipXhziMS6ms0YP9alvV2+vhoHVEC+PnfzD/Uga5oWThX8/GNmypBJO7whilHne/KRo9WVgyQ+OHOQ2xobd8j8rg6/PlnGB/Iwz+2fxfvzUJp1RqTf/SNg6kIwMgft9XkMgYh6vV9wmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728347159; c=relaxed/simple;
	bh=cCwIj8LnQFwevOQ/BGPARxkFz7CHLKYsnaMOyfuJ9S4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KCVSrER5P1ksBvGBGygPU3ROLcnxP8AnvcIqoDj4WlqFtqt+CeYT138DcNObmTdQBWpaoK3Y/zw1TSO55sshK0qhfvOb3E8yQ0wTlulpkl8TUCykfVeophzwGNwWh4HobuqC0erUiGRuTUxeBzr2dXFSW05poBzJn0EGOWvsA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfPKuaGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01E2C4CEC6;
	Tue,  8 Oct 2024 00:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728347159;
	bh=cCwIj8LnQFwevOQ/BGPARxkFz7CHLKYsnaMOyfuJ9S4=;
	h=From:To:Cc:Subject:Date:From;
	b=XfPKuaGKTP/DQ2W3Zg3By9fsVBA+GoZPxSrjryx1KDmy9nZgRjlTwuVfyT9BCE2dY
	 NmiK+byHP9T2CgwjvTrEvoPwHYyaVYoFUF3l4HsrNC8KbbYEgrZO05u1eMPGqugxkS
	 7sGPfN2S8N3DM6Q6kNANaAOQ+lv/P1bxmLteZRUhxJPLg6x3qh9lzXSO+ucn6DQBOu
	 Y3tAsGFcC7onaJKt5Z8eXdFeUuvAZx6ypybx84yUArTsp6OApSsGQJ+gMx+0l9kGnp
	 J3Ex7GMiVHWVuSH1KTHPEUDPX3XgRKdQb4WkUQrvGjKZR+Gp1LkQZT3R+f7HKJhU9e
	 5bfsAmU3KCbEg==
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
Subject: [PATCH v2 tip/perf/core 0/2] SRCU-protected uretprobes hot path
Date: Mon,  7 Oct 2024 17:25:54 -0700
Message-ID: <20241008002556.2332835-1-andrii@kernel.org>
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
 kernel/events/uprobes.c | 312 ++++++++++++++++++++++++++++++++++------
 2 files changed, 321 insertions(+), 45 deletions(-)

-- 
2.43.5


