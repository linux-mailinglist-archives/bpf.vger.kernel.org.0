Return-Path: <bpf+bounces-41769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE86699AA92
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 19:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9BE1C219DE
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 17:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568AD1D015A;
	Fri, 11 Oct 2024 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJ/ezhwt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25131C9B91;
	Fri, 11 Oct 2024 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668373; cv=none; b=t68zviXqrdflRVzOoFACZzojfsctQ4vUJjQHBW3uqUTZMI+q3PXEQeYy4DZCNYCyKBOK9nhYvFiG66+fgQlFx70CvZQjGZDjUHmAEC39zIGZKymPePHrWLZa3PRj7jXJsj9OeqLJ6jzCqpiqa/Z4lpo24ub2QvULq3LYxFfoKwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668373; c=relaxed/simple;
	bh=aRxkj03S73hF0jV8gryZajtKN0A7DA6aTKR8Jq/1sgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nP1zZAcRLY38qAS384LKbavXE5AIY2hi+hn5Dt5TPafzN43pCBZAFTSRg5sb0FwUWsIEid7uCl1ZVVbtdO9YxQrg0fWTROYS6m1ixfwgouVeSHjVAvWMJK5hrdFoJ2JwT+fOs4Wo+G9jJBp4XAxo/WiQoFKpAxFsRyp68OBO/0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJ/ezhwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB7FC4CEE2;
	Fri, 11 Oct 2024 17:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728668373;
	bh=aRxkj03S73hF0jV8gryZajtKN0A7DA6aTKR8Jq/1sgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJ/ezhwtdqid/ZsVPuQol1wyZCHB8dGpZSSm5GCtXCeT6tRoERkz7sQMUv95nkYzQ
	 WRjbcGAoFmhmsndhDMB6l2/E2p/fOChpWHSB5yRxKqOjo+YebMr3kPfAR7KLCRfcDi
	 ha+76hznaYRAG7sSc7/Y/UspbQsGiW8w8crbNiv1AGG0LOiv3NcocQTSISHYP2Atzl
	 UnIfJXcjw9V2D16HLeXAbT9p5lY197sR58QaNueOv9ZE4yrOGoJYkZ1jzyTAjnzMrt
	 oZRqAKdXd9Jm7S2wIQB3AOEGoFR85LHHQ9qMCKkePc6dHseq40gJx/RCHXJBMnrazE
	 QpuJQ+rZdpT2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B5BB9CE0F9C; Fri, 11 Oct 2024 10:39:32 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH v2 rcu 11/13] rcutorture: Add light-weight SRCU scenario
Date: Fri, 11 Oct 2024 10:39:29 -0700
Message-Id: <20241011173931.2050422-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop>
References: <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds an rcutorture scenario that tests light-weight SRCU
readers.  While in the area, it adjusts the size of the TREE10 scenario.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/CFLIST  |  1 +
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L  | 10 ++++++++++
 .../selftests/rcutorture/configs/rcu/SRCU-L.boot       |  3 +++
 .../selftests/rcutorture/configs/rcu/SRCU-N.boot       |  1 +
 tools/testing/selftests/rcutorture/configs/rcu/TREE10  |  2 +-
 5 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
index 98b6175e5aa09..45f572570a8c3 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
@@ -5,6 +5,7 @@ TREE04
 TREE05
 TREE07
 TREE09
+SRCU-L
 SRCU-N
 SRCU-P
 SRCU-T
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L
new file mode 100644
index 0000000000000..3b4fa8dbef8a9
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L
@@ -0,0 +1,10 @@
+CONFIG_RCU_TRACE=n
+CONFIG_SMP=y
+CONFIG_NR_CPUS=6
+CONFIG_HOTPLUG_CPU=y
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+#CHECK#CONFIG_RCU_EXPERT=n
+CONFIG_KPROBES=n
+CONFIG_FTRACE=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot
new file mode 100644
index 0000000000000..0207b3138c5be
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot
@@ -0,0 +1,3 @@
+rcutorture.torture_type=srcu
+rcutorture.reader_flavor=0x4
+rcutorture.fwd_progress=3
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot
index ce0694fd9b929..b54cf87dc1103 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot
@@ -1,2 +1,3 @@
 rcutorture.torture_type=srcu
+rcutorture.reader_flavor=0x2
 rcutorture.fwd_progress=3
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
index a323d8948b7cf..759ee51d3ddc6 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE10
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
@@ -1,5 +1,5 @@
 CONFIG_SMP=y
-CONFIG_NR_CPUS=56
+CONFIG_NR_CPUS=74
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
-- 
2.40.1


