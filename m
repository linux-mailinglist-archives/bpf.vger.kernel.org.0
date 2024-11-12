Return-Path: <bpf+bounces-44633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 568539C5AF8
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 15:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B11B282B15
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D609B200B88;
	Tue, 12 Nov 2024 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHk8JAtZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5339E1FF056;
	Tue, 12 Nov 2024 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423146; cv=none; b=tvN8Eq43NQhskGSamRjzk2qTmEw3WRUHoOp0c5y71fpklWNMNqiBthyCoLz8Wmt0xTjikKezEvjAB/3JRVIdQDZTWXcGCemcYw7CVcslay5jD7kz5wnoiPO0OOFRanp7+f6RNsfBCGc/wQ7HBIxXtTbcVi/2DIN0Ctvlspukixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423146; c=relaxed/simple;
	bh=cdJ+xBnPORsx2g7uxvtjLS56Zpr2XJsr87vnsr2jyos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqniYbOlEeIxMwnje3Cvny43nmJ/tHTBHh5MSwgtw3iYZFGQt8cvAl0cgo+8Lat1J1+VnpcJbSU/tTrjGBeCznzxrlqsYyA9kb/bMFAzEpiNBjqljzYGo8Qp2dTeZfDoc/erXrwptmJSd3hZY1QroJnvN72MKBy+CXGHSJdy6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHk8JAtZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFFBC4CED9;
	Tue, 12 Nov 2024 14:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423145;
	bh=cdJ+xBnPORsx2g7uxvtjLS56Zpr2XJsr87vnsr2jyos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OHk8JAtZ4DmTg1qGtX9TXL3Xq6bcOHS8jRo5I6rlok3iZW8m89sw985/l8ImsRwHT
	 2XlKB1WF83tYrLHTFkE5WQ6pf0aNa3BSZsyOUnLIzT5NwJ7JBXQPdBaweGkA3I7inQ
	 VIsIIBTtFoNUwFj4ny5Vo9EjPyh9IZGvEH4yy3Fle1ZpkQ8+qXicH6gpSRXhXE87pl
	 Ccu/HbfVKm0OAGQ4zc91gU7k+yQwC95R7kertZh7tgr+hKdnzdyNDmXHuu0iTtEpZJ
	 f/NM+PapRVldfY3kL2r1xPHI0//A9jJwpf/4+KZ3X/t/nyvr87fjvWVDWd5KwqKF+J
	 9kYpTr9pA9n5Q==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 05/16] srcu: Bit manipulation changes for additional reader flavor
Date: Tue, 12 Nov 2024 15:51:48 +0100
Message-ID: <20241112145159.23032-6-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112145159.23032-1-frederic@kernel.org>
References: <20241112145159.23032-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

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
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/srcutree.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index f259dd834272..9774bc500de5 100644
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
@@ -712,8 +712,9 @@ void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 	sdp = raw_cpu_ptr(ssp->sda);
 	old_reader_flavor_mask = READ_ONCE(sdp->srcu_reader_flavor);
 	if (!old_reader_flavor_mask) {
-		WRITE_ONCE(sdp->srcu_reader_flavor, reader_flavor_mask);
-		return;
+		old_reader_flavor_mask = cmpxchg(&sdp->srcu_reader_flavor, 0, reader_flavor_mask);
+		if (!old_reader_flavor_mask)
+			return;
 	}
 	WARN_ONCE(old_reader_flavor_mask != reader_flavor_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_reader_flavor_mask, reader_flavor_mask);
 }
-- 
2.46.0


