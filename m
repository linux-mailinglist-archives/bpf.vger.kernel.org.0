Return-Path: <bpf+bounces-77484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 490AFCE803C
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 20:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7062930145B8
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 19:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2462BE7B1;
	Mon, 29 Dec 2025 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBtkOgI7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9368F27F4CA;
	Mon, 29 Dec 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035467; cv=none; b=Enhf8i/KazqImsL/mV7ma0QP/wk65lEhrgdxK7zvwiO+wXIQ3R1YQrT+yX0axK+u8WqWtkNR7m5gxAF/FJ04Gao6KTP4EEXpKWORPX2G4SkKUq8M/Uc05DdV0s6F6/ViAGCs+wAQj56MWX0A7AH1s0+vULau4De0PaED0FOuXIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035467; c=relaxed/simple;
	bh=Ax7FBvNwaT/XyPQJp8bumqr3pkAZvIxwCUWKEB+5I40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pd6Hv6kHT9+HnPI5oAg3X9BDdNBvLHZgiRXOzemEcp3p0oeFgXnKRlReFb7DD6bxA6qADmht3m7Pn0XKH2EdyxtzZd6CQIj29adfBjAx7dQcc2r6eQ2phbjAstaYCbRRx+J+tA5PM/D4yso07zbCUY/ipyA6CW6jL8hrb1HibTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBtkOgI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F65EC2BC87;
	Mon, 29 Dec 2025 19:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035467;
	bh=Ax7FBvNwaT/XyPQJp8bumqr3pkAZvIxwCUWKEB+5I40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kBtkOgI7FntPLyVBT9mVPpSLqozf4X28y1qnhCHDQWIy4bcYWvqujwWFRqcU29j4V
	 F93hqWB5o/+Yg0qLpVwjdTZGTuLyRbYHBBOWlu7dhExKrj9yhSNZv36K6lVNGTRwfp
	 QeFNldkeTSacIPbBJZ972g88LKSYkaZMTGHFx7iTPqRyiPNE7U4Yud6jNtxROzt9P4
	 yABjw3hbMSAwS4QhPWzbEEVBcKUOK9WX1wGVaDeSJq6ezABE5w5yT9qqgXigW2Rawm
	 V/1Q9Jj4OLSwi7sb/PBPzNsdtQvThcxnWzDfEW+ufDIqJ74qlwgqIXnfDX8cpHpZF4
	 UeFcJk8NU9Wgw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 77A79CE10F4; Mon, 29 Dec 2025 11:11:06 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org
Subject: [PATCH v4 6/9] rcu: Update Requirements.rst for RCU Tasks Trace
Date: Mon, 29 Dec 2025 11:11:01 -0800
Message-Id: <20251229191104.693447-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b206b083-f611-43b6-993f-78ddbe315813@paulmck-laptop>
References: <b206b083-f611-43b6-993f-78ddbe315813@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit updates the documentation to declare that RCU Tasks Trace
is implemented as a thin wrapper around SRCU-fast.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 .../RCU/Design/Requirements/Requirements.rst         | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index ba417a08b93df..b5cdbba3ec2e7 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2780,12 +2780,12 @@ Tasks Trace RCU
 ~~~~~~~~~~~~~~~
 
 Some forms of tracing need to sleep in readers, but cannot tolerate
-SRCU's read-side overhead, which includes a full memory barrier in both
-srcu_read_lock() and srcu_read_unlock().  This need is handled by a
-Tasks Trace RCU that uses scheduler locking and IPIs to synchronize with
-readers.  Real-time systems that cannot tolerate IPIs may build their
-kernels with ``CONFIG_TASKS_TRACE_RCU_READ_MB=y``, which avoids the IPIs at
-the expense of adding full memory barriers to the read-side primitives.
+SRCU's read-side overhead, which includes a full memory barrier in
+both srcu_read_lock() and srcu_read_unlock().  This need is handled by
+a Tasks Trace RCU API implemented as thin wrappers around SRCU-fast,
+which avoids the read-side memory barriers, at least for architectures
+that apply noinstr to kernel entry/exit code (or that build with
+``CONFIG_TASKS_TRACE_RCU_NO_MB=y``.
 
 The tasks-trace-RCU API is also reasonably compact,
 consisting of rcu_read_lock_trace(), rcu_read_unlock_trace(),
-- 
2.40.1


