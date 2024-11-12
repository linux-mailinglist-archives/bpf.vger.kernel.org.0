Return-Path: <bpf+bounces-44641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EC19C5B0E
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 15:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD5C1F22E0A
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 14:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A56202F7D;
	Tue, 12 Nov 2024 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5ERMtBi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E11FF7DF;
	Tue, 12 Nov 2024 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423183; cv=none; b=iYim1ZWYX3k0nJSaBVP0iFMd80keuMn2wYBgLPa1Klhh2g6KrUA9WARqRfrI95wjcoDsqT2SqyRA7jp4zBm/cHxlXdQcKPpdqpnia7qeawT3PVquukukJdhyYHnfx4rtRK6LXh9NwqkA9ON/de75EWA/2z42ZqhPL4yuke0vNcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423183; c=relaxed/simple;
	bh=C5DvJ9v6NDVzUTyLbZO2R6cXGi2WrGyjqmelZ/LOsj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vy+fQmPj4c06AsfnWR6RIOzOHzGCZl8FKAMgwkpCtsJsEEp2RhDM1ICic7ssBgPVnJIjZRLsTVIHoOfZMMo6c7HHiX2HuNf5/65A4IQV3GlC1OZTYIYwpfRADoTdgzGnzOlB9MEBhzYuUlf/xSHcKvAgMYFuGPOItFVfJfHhRn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5ERMtBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC68C4CECD;
	Tue, 12 Nov 2024 14:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423183;
	bh=C5DvJ9v6NDVzUTyLbZO2R6cXGi2WrGyjqmelZ/LOsj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s5ERMtBinGrWLNvuQa3lnWb/5AfUahCSWRxf+4D0BDpSjtTVtwbG5fyxUShkfZC2H
	 uFmqO7387uTsRHvQUAg4lkgaJMjwzxQi4WKak2J191ixJrnAySNb7JKQe8mPur/Mxg
	 I+kgPu3wT3teEhCr6R9LDpLL1lQRd7cJSVOM0OhphJ/Rn8e9ZeNg5fePYcad01q3tH
	 9crG0HBPopZ1RDgNQ+aR26/8cH+GDdtjDbfNu/dus5O1Iz+2mZH1l8zjWjxdBn8Nhl
	 Ba0avAhxESRMZzCwjTcgPbQYjpDcjrL4AyLXyP4M8NTuJQz5IN+7t9IcWn4KyxouGZ
	 6N1ojdybd+Jlg==
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
Subject: [PATCH 14/16] rcutorture: Add light-weight SRCU scenario
Date: Tue, 12 Nov 2024 15:51:57 +0100
Message-ID: <20241112145159.23032-15-frederic@kernel.org>
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

This commit adds an rcutorture scenario that tests light-weight SRCU
readers.  While in the area, it adjusts the size of the TREE10 scenario.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
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
index 98b6175e5aa0..45f572570a8c 100644
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
index 000000000000..3b4fa8dbef8a
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
index 000000000000..0207b3138c5b
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot
@@ -0,0 +1,3 @@
+rcutorture.torture_type=srcu
+rcutorture.reader_flavor=0x4
+rcutorture.fwd_progress=3
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot
index ce0694fd9b92..b54cf87dc110 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot
@@ -1,2 +1,3 @@
 rcutorture.torture_type=srcu
+rcutorture.reader_flavor=0x2
 rcutorture.fwd_progress=3
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
index a323d8948b7c..759ee51d3ddc 100644
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
2.46.0


