Return-Path: <bpf+bounces-77482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF69CE8039
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 20:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E67A3033D5A
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 19:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830142BDC29;
	Mon, 29 Dec 2025 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPud9yx8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853B3274B4D;
	Mon, 29 Dec 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035467; cv=none; b=SN70VcjPXu+WTucKqOsbgGIXazbhoJ1R2sIDHb4Ptc++x2ADDo8w/VMF8Uh3l9EwHSwLWMA9/tNhCmvJlWd0IxQdmw5QAXlV2QaxsRinDccAvPiOInPqpNYUvN4+WaHfGAX3WHOMxml5BQRunEZ1Voxam43m9/BmkRhllcouxm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035467; c=relaxed/simple;
	bh=RCb48nJYGD9FDhOCx8rn3xYPgrAldJAxldDGmLx+cXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RWVHDm5ZEDuD2jq9YWHtbeTXlL6izCNyYtxZZTotXzK18xyvvGod7aw3D4thRobjeI0iWuyxVULTLs/NraDap65yxtf0N/yLTwn9M32ql2QO5iJunvB+Ph8CttH7aaoX5aKPVKNbrAJUUWg3zknz4E6u1QTUR72QW/iScBUzcio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPud9yx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AED9C116D0;
	Mon, 29 Dec 2025 19:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035467;
	bh=RCb48nJYGD9FDhOCx8rn3xYPgrAldJAxldDGmLx+cXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GPud9yx8fkrJj1bXBaOEtWEXx0zNuJBAsu1KSTeBA4eyzJ87sk7zKkPbbljl2BCWg
	 hzJ1mZSmjuyXZ7CN+mZLSoKHod4Vj9uuG80RK0O8m2aj3IcutlWyF9PHA3+o7DuyNE
	 dEBdIkjmrSF/MUoyk4iturHrQhCcWcmfMg95Tzyhihsxr+HJgAG6lpyRmCTgy/565j
	 wTyDTRG7tbsXKfL8JoRIxlP/j0lCVgLIMA59x5LFmNs9405nkQRKlF4/QblKz9o0HU
	 7SX1J9jPchzMrJ8G2rbuOfnWLXZvef27IPMjQalNhR13FJ1fqt/iLTBwQ4/D+o5dbP
	 ptww06FsZUElw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7E802CE11A4; Mon, 29 Dec 2025 11:11:06 -0800 (PST)
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
Subject: [PATCH v4 9/9] rcutorture: Test rcu_tasks_trace_expedite_current()
Date: Mon, 29 Dec 2025 11:11:04 -0800
Message-Id: <20251229191104.693447-9-paulmck@kernel.org>
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

This commit adds a ->exp_current member to the tasks_tracing_ops structure
to test the rcu_tasks_trace_expedite_current() function.

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 78a6ebe77d35d..d00b043823aef 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1178,6 +1178,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.deferred_free	= rcu_tasks_tracing_torture_deferred_free,
 	.sync		= synchronize_rcu_tasks_trace,
 	.exp_sync	= synchronize_rcu_tasks_trace,
+	.exp_current	= rcu_tasks_trace_expedite_current,
 	.call		= call_rcu_tasks_trace,
 	.cb_barrier	= rcu_barrier_tasks_trace,
 	.cbflood_max	= 50000,
-- 
2.40.1


