Return-Path: <bpf+bounces-42076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B094299F271
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 18:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 288C1B21CF9
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ABA1FAF0C;
	Tue, 15 Oct 2024 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eikvUaAA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D811D1F76D2;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008674; cv=none; b=QcCzN6vm4fNlhFh2JljHx5jxh8dI9Cin0uZXAZle2iNl9TiBB/GIEsjhJpeHc/nef87jH2dOM21QA9wA894LRMHBBXe0U+FfMTD99UlPUkxCrl1gOEVQF1/ecLv6LAjCnoPF+25qjGmh36L3XTb1EZmTURuIQgy2XiYSVE2+pIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008674; c=relaxed/simple;
	bh=2/hu6Yi0XsmLS7jmPPcP2qqf4oo1mhmwzrHcI6b4xBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TEXNULrtbZJfni1wrlEahi2MfG0Oi+b+5yclxf4I2pyMcEn+UnjFrFKBXePZc/OO4kyMioEICRSBqbv+1LsnGbOGECC9xSJphmAQ5jxPtWOkrdxEPgqd/QgLKmes0NiCbd43WpQDRFM67D+i+eOagwpy4vZmewtv5/LbUhNKW0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eikvUaAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EBDC4CEE3;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729008674;
	bh=2/hu6Yi0XsmLS7jmPPcP2qqf4oo1mhmwzrHcI6b4xBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eikvUaAAAV+LFBGasGXysFYWlnzo6ep0sjM6lJ+EOa0ujRPxyeBHVnLdKCwhCg+zu
	 gPsrpkMBFlWeEzNbUPK08SevdPC+tRQynJnAW7uLFw9I5qTtFr81pk8kLe8H0NnZF3
	 lh/QmqnCf3emspdPnHccaYisFqUE48OqoW/ngm9+E1AxJd4+Akpa06QD5ezS7AxahQ
	 aXMNe/gzffcug8gUaTpuMd1YByQ7qLKCUtCb6zNEiKGYKIMG5oPdn6Xfb9bLnMP9FG
	 LWSKEjc8MEDuQqbPbgGKvy+83kregsyfoZnSBLbHsQbPaDhAJHmDy25Yu/mMIilI4X
	 ijiC2cvzYr1UQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D1EA8CE1D59; Tue, 15 Oct 2024 09:11:13 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH rcu 12/15] rcutorture: Add srcu_read_lock_lite() support to rcutorture.reader_flavor
Date: Tue, 15 Oct 2024 09:11:09 -0700
Message-Id: <20241015161112.442758-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
References: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit causes bit 0x4 of rcutorture.reader_flavor to select the new
srcu_read_lock_lite() and srcu_read_unlock_lite() functions.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++--
 kernel/rcu/rcutorture.c                         | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 52922727006fc..203ec51e41d48 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5431,8 +5431,8 @@
 			If there is more than one bit set, the readers
 			are entered from low-order bit up, and are
 			exited in the opposite order.  For SRCU, the
-			0x1 bit is normal readers and the 0x2 bit is
-			for NMI-safe readers.
+			0x1 bit is normal readers, 0x2 NMI-safe readers,
+			and 0x4 light-weight readers.
 
 	rcutorture.shuffle_interval= [KNL]
 			Set task-shuffle interval (s).  Shuffling tasks
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 405decec33677..a313cdcb0960f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -658,6 +658,11 @@ static int srcu_torture_read_lock(void)
 		WARN_ON_ONCE(idx & ~0x1);
 		ret += idx << 1;
 	}
+	if (reader_flavor & 0x4) {
+		idx = srcu_read_lock_lite(srcu_ctlp);
+		WARN_ON_ONCE(idx & ~0x1);
+		ret += idx << 2;
+	}
 	return ret;
 }
 
@@ -683,6 +688,8 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 static void srcu_torture_read_unlock(int idx)
 {
 	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
+	if (reader_flavor & 0x4)
+		srcu_read_unlock_lite(srcu_ctlp, (idx & 0x4) >> 2);
 	if (reader_flavor & 0x2)
 		srcu_read_unlock_nmisafe(srcu_ctlp, (idx & 0x2) >> 1);
 	if ((reader_flavor & 0x1) || !(reader_flavor & 0x7))
-- 
2.40.1


