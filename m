Return-Path: <bpf+bounces-44129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7289A9BF0F8
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 16:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B88284E31
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 15:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C873E1E767B;
	Wed,  6 Nov 2024 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LURUJwI2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FF6202F8A;
	Wed,  6 Nov 2024 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905173; cv=none; b=X7gjsKBC0ZBv6vPfNe9JywQFAd9bfV4x6+WBUCqP/C2bEUUcXbxuGUVfg9DWx0A6S2WqPDWNtRIycuu5eL3eaMPCbgpZDp6diErY+07zBlNLSg3ECt5J0YAsAVUUGQGwrlUvtEBmACGWkIiAIXepk/xzw57sk5wLjzNcIidHj5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905173; c=relaxed/simple;
	bh=oY9T9tNg446qMb0aOnJdQRe0Ot6PCpEIBaCDhmC46zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1mICmmGKlsvwGb2QkZD5xvPkYdrgrRJemOYoN8pQ8jKJbrBoKYHh/LFsQbWtepKPHUrrnAwoNHgef+QEopNZSNP9RZf+atybh8pV009O1Kk1rx0MFP47JDh9HH5XZnczvIZUSSRjjw+b7Hzzi+u2e9JcWG08FeXpo+FsTXbFAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LURUJwI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF11CC4CED3;
	Wed,  6 Nov 2024 14:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730905173;
	bh=oY9T9tNg446qMb0aOnJdQRe0Ot6PCpEIBaCDhmC46zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LURUJwI23qRr870S7hjbwt/ofN95Wh8dC6YJCCpcHLfmp/OBIVTtw6/M/cNRSwjFb
	 lXOjZVApBfPE2SA+3xS+pmBoQ9gNmNQz8RKeewsplPgjNi5ilG6AW13hrMuBbrO3Ux
	 j0TyA8UMJoSw3bBmA6E0y68rK/aIgju4B1MVIlq44XgxnugknPUh9R4tSkq0UQvIrG
	 CcVcR8gIEVzO5QIw38D5ZElsu4nu8yIM4RYa8NLzH352A3guBVXVG9zv/pcQZA8O6X
	 YHFdbovfyad/Ti43O7gb4UAXdqucyaK8m/k/LOFlNVW0tnenFDqu2vztpPKsEulZhO
	 qGrOXGBbtMzsA==
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
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 5/8] doc: Remove kernel-parameters.txt entry for rcutorture.read_exit
Date: Wed,  6 Nov 2024 15:59:08 +0100
Message-ID: <20241106145911.35503-6-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241106145911.35503-1-frederic@kernel.org>
References: <20241106145911.35503-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

There is only ever the one read-exit task, and there is no module
parameter named rcutorture.read_exit, so remove the bogus documentation.
Instead, use rcutorture.read_exit_burst to enable/disable read-exit
race testing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..7edc5a5ba9c9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5412,11 +5412,6 @@
 			Set time (jiffies) between CPU-hotplug operations,
 			or zero to disable CPU-hotplug testing.
 
-	rcutorture.read_exit= [KNL]
-			Set the number of read-then-exit kthreads used
-			to test the interaction of RCU updaters and
-			task-exit processing.
-
 	rcutorture.read_exit_burst= [KNL]
 			The number of times in a given read-then-exit
 			episode that a set of read-then-exit kthreads
-- 
2.46.0


