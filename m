Return-Path: <bpf+bounces-73317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8BBC2A491
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 08:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC432188EB96
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 07:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE342C0F7D;
	Mon,  3 Nov 2025 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFoHqJmz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12362BEFFE;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154354; cv=none; b=AV97PT4HYWN2UNVVsyT94uz91//DzlRh1a43cj5bnNh8clHbKMpzEfC+05ZYyGJgbyw/5bKevMMzoROJxi40sz7g6mxomilf84ln6Fb+Zk9VJw50WpIR35diEWKVL6isGu2IlkeDmzvGxW6PJL0DYjyEgs03DNPkdY7K3Zi+tJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154354; c=relaxed/simple;
	bh=Ga33FyuA/Xuk9qvyQLLFmM7o/uPEU/PVyo1IisR6tc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oIXCKWlFiOSxq+wv/ugQoDkLutBEtD87K1opPipm/k96VeNwyQlJ2DpAD4PYM+Yi5Sxx1DfXoIRgpVoS1uLHA91VTvRa4HVpw0Z3j8lJdX6vXAPJ4ho3CKG/CvN/hGQq2b8zAqL1WMnZYajpCy0UBFbFCCicZgSSBletHmDxLAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFoHqJmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C98C4AF11;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154354;
	bh=Ga33FyuA/Xuk9qvyQLLFmM7o/uPEU/PVyo1IisR6tc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EFoHqJmzax/JtrsDPUvyl5cHn3bZubnEPoo+T2qmujknnYNMtusuUFYyB/krzqTV/
	 wYeUjIoF3FRpv+bJjZnW167c1SZAZIeGLN0e5XF/DkUQ/NlAFGsNvHknt3+G8F+iSy
	 oaFwr/taZ/5X2b5wF7CItdwS+hUap3CB0BRkoTniF5yDsJJQiupY2IR2YQitcmN4la
	 e8p6g5VUJy6Yg7Rs+NvdByg3p3r44UYBLn949MFVkcZX4NJRwBj3OGwve6/FKlxzFS
	 fc4sqvhexW4mf6QsLW49F/nSCoRkYBbOwmP9EPeHLcEIL+7D86rs4nJ98WWSbHlKD8
	 18vGYfjjHs3jQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CB6B3CE19FB; Sun,  2 Nov 2025 15:07:01 -0800 (PST)
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
Subject: [PATCH 9/9] rcutorture: Test rcu_tasks_trace_expedite_current()
Date: Sun,  2 Nov 2025 15:06:59 -0800
Message-Id: <20251102230659.3906740-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a1e505e4-931b-45cf-8ca7-337442aa598e@paulmck-laptop>
References: <a1e505e4-931b-45cf-8ca7-337442aa598e@paulmck-laptop>
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
index 647af81e0b21..f651b1dc2c97 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1180,6 +1180,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.deferred_free	= rcu_tasks_tracing_torture_deferred_free,
 	.sync		= synchronize_rcu_tasks_trace,
 	.exp_sync	= synchronize_rcu_tasks_trace,
+	.exp_current	= rcu_tasks_trace_expedite_current,
 	.call		= call_rcu_tasks_trace,
 	.cb_barrier	= rcu_barrier_tasks_trace,
 	.cbflood_max	= 50000,
-- 
2.40.1


