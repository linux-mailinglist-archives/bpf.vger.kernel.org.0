Return-Path: <bpf+bounces-38789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCB196A47B
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96101F25AF7
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 16:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8462518E772;
	Tue,  3 Sep 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUQK0hqW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00AC18C337;
	Tue,  3 Sep 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381200; cv=none; b=pRvK5IXtiNwgQfAWmZkIzhT6gMzDhbhyYpZ4ZRbl/4yZ03GLSE9lH5C96gq6qQzIq6uK8YzTia3jfaZ9E0TlGW8WZ3FWj5M6kK98yJ7SntyamzviJy9V+g82l26qiOuhMSrNKgD6UO9mI/QFDs8xlgI8GuuE8INdc/tPk8TUxpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381200; c=relaxed/simple;
	bh=lrdhJdJA4s0Q68tz8/X6z/teMdVY0ZLD1o3u/Im7vbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uFElq7GODsHPaPsJ32VXs6SQG8pEsDyya1wOu8eHrzgtuvMZ+OBorP1X3A83sZjIR8SYgfliacIC4ZPOgwM0adCe3l8Uswu51GmQQHx0xX15OSzo1b+32i0oBkYMdnt97Aqt5wkrIBnzMjCQClnKYXGwn2n5pwAh/CWdlvrDDn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUQK0hqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4F9C4CECB;
	Tue,  3 Sep 2024 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725381199;
	bh=lrdhJdJA4s0Q68tz8/X6z/teMdVY0ZLD1o3u/Im7vbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sUQK0hqWHjhN9aKoa4Repr1qNftcp7ydpKncx0makaYsmlxxNjPv55mJQBDwbxo9T
	 aWeqMHa83uUs4/v0FGLp2VjDXMRq3NbJwDPt59qGRSfsvL61QFRCf+W3kUcewoNo/Q
	 CxPfDmqCOh17yHZauRsP0LjfSftLKo2Ho5lHQb1lhzIj9tOK/VW3uCR8IwUMQIBRT7
	 MnCFqDhnn0XOTRW4wJsepznGB6Fj1UuV5HvecAKg5W0iFmTak4FOcnnsjOKpTKMSws
	 4gmYcsgXpPus1geBBbWwb3Y7pE8U3xcrM9PFqqORfm686d/5n0YjlEVQYCUF7MIjL+
	 eAKhlS7UqhRgw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 43E61CE1FB9; Tue,  3 Sep 2024 09:33:19 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/11] srcu: Bit manipulation changes for additional reader flavor
Date: Tue,  3 Sep 2024 09:33:11 -0700
Message-Id: <20240903163318.480678-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
References: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there are only two flavors of readers, normal and NMI-safe.
Very straightforward state updates suffice to check for erroneous
mixing of reader flavors on a given srcu_struct structure.  This commit
upgrades the checking in preparation for the addition of light-weight
(as in memory-barrier-free) readers.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/srcutree.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index f259dd8342721..06ade8ca7804f 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -462,7 +462,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
 		if (IS_ENABLED(CONFIG_PROVE_RCU))
 			mask = mask | READ_ONCE(cpuc->srcu_reader_flavor);
 	}
-	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask >> 1)),
+	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
 		  "Mixed NMI-safe readers for srcu_struct at %ps.\n", ssp);
 	return sum;
 }
@@ -712,8 +712,10 @@ void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 	sdp = raw_cpu_ptr(ssp->sda);
 	old_reader_flavor_mask = READ_ONCE(sdp->srcu_reader_flavor);
 	if (!old_reader_flavor_mask) {
-		WRITE_ONCE(sdp->srcu_reader_flavor, reader_flavor_mask);
-		return;
+		old_reader_flavor_mask = cmpxchg(&sdp->srcu_reader_flavor, 0, reader_flavor_mask);
+		if (!old_reader_flavor_mask) {
+			return;
+		}
 	}
 	WARN_ONCE(old_reader_flavor_mask != reader_flavor_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_reader_flavor_mask, reader_flavor_mask);
 }
-- 
2.40.1


