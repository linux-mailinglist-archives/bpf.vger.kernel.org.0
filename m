Return-Path: <bpf+bounces-39367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D8297256F
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 00:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E37B1F24C2F
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 22:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D2718D651;
	Mon,  9 Sep 2024 22:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qj7LGjIK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B40723741;
	Mon,  9 Sep 2024 22:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725922148; cv=none; b=rjU/zsr34c0vP+q4a3m7r1QhsoN8+4QqSrDSzuoX9i5BZ5h4EVkvNg0Devo+gtxjanfdp9rg1PLfe8x2R9chEcc6OyYNLifs6ZnzHouBNf2JEM4yPS4Ux5mZmzwnVQyIncHtk+PxB8UlQ8lIwzWPXMz7XNSz8GOg/xTAlGVW5C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725922148; c=relaxed/simple;
	bh=x8xT6Nd43iZqhxpKIsN/hr12eI960eOd780+i+F1Atc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mm4Rz3W7kY2MVL1j9ZOZILZQOVs9Z6iB7jEL95X6rALUm6HTynsUNkbsE5oOH8xOhWs1enx4pAdggYGo/yBogwh8+BsbFyol2vKdjsjGygbn5BrXrsMsjDveGPTk6kW04jD/1NmjzKAdWcdWcZ2N1e1d2j6h+Pn/ZucZBucleR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qj7LGjIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D39C4CEC5;
	Mon,  9 Sep 2024 22:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725922148;
	bh=x8xT6Nd43iZqhxpKIsN/hr12eI960eOd780+i+F1Atc=;
	h=From:To:Cc:Subject:Date:From;
	b=qj7LGjIKNle5RK+58k3eBRV3NEPSM5nK4eRuRoBOpL8uCogiq2V6n9YdZ4JRFB7Rl
	 AEjDAPpNZnKwoPOgpDDk2BiLXz537SKKF2Hn4+U1PasfrwJ/JkOZk1Ou43tRYuK3fy
	 VTrqcZ1E/er/RhKqFhR0G4cT8wqtehqFYjXCuY1/09NKcG+41YyLftzyhuI90nAK7M
	 pROYUMEUuS0SFHgU0AfxHS8u6F8PJ6kHRLZpLmZ725Pxp+IrRcdtDhgmtub3DBVlcm
	 8oc5MvejYm+9hRX3yaU7+OLGj/9fc3REg/33Us9iwGi5uVVyQJTvMvGvaFCjRZaK6H
	 D5plj8dwOVuVg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 0/3] SRCU-protected uretprobes hot path
Date: Mon,  9 Sep 2024 15:49:00 -0700
Message-ID: <20240909224903.3498207-1-andrii@kernel.org>
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
instance itself. See patch #1 for all the details.

rfc->v1:
  - made put_uprobe() work in any context, not just user context (Oleg);
  - changed to unconditional mod_timer() usage to avoid races (Oleg).
  - I kept single-stepped uprobe changes, as they have a simple use of all the
    hprobe functionality developed in patch #1.

Andrii Nakryiko (3):
  uprobes: allow put_uprobe() from non-sleepable softirq context
  uprobes: SRCU-protect uretprobe lifetime (with timeout)
  uprobes: implement SRCU-protected lifetime for single-stepped uprobe

 include/linux/uprobes.h |  53 +++++-
 kernel/events/uprobes.c | 370 +++++++++++++++++++++++++++++++++-------
 2 files changed, 353 insertions(+), 70 deletions(-)

-- 
2.43.5


