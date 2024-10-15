Return-Path: <bpf+bounces-42077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A3D99F26E
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 18:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F03B1F22C7C
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CAC1FAF0D;
	Tue, 15 Oct 2024 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9aengoc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D089B1F76CB;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008674; cv=none; b=XIV49JsGuDjGWPtVMFTma2ZB+yy5YKcqU89iE95xJbVyr1q+rrYOYNMf8QUwqEJ+nsvPsHN+znZO+OHY34GGekyM0Hwn0v6XRCcUe6v/X2qoDFgvB8whgwX3k7XsFhVE25HlYmHQy1YMSKBptFTjs+weaLy+ojWBrBZ7XA1T4Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008674; c=relaxed/simple;
	bh=aRxkj03S73hF0jV8gryZajtKN0A7DA6aTKR8Jq/1sgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qlXi+Th+NM4k5p+lNJ/F5FbnL0NX5UpWawyc/OEZrwA50kJdJDwWnLFgZQChXdg6pHVSvErELAkGa2GjAfBzjrPZNjl2J79y6+fwPj4CmaLVxP5Ye5HNdtTaGAmIvjz2S86RUt6/qs95/TefNn6ry9XGnI6vB3ZQs+Bk2NucXx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9aengoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEEBC4CEEA;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729008674;
	bh=aRxkj03S73hF0jV8gryZajtKN0A7DA6aTKR8Jq/1sgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A9aengocjrOEp06JhtZ7EDKxhhEbbEJWPJt5kIWlCOu6SeFdTfUT68yFtT9Bm1WSm
	 DWqw/2zF4G4HaT/JcV/VDfWWQIjRZINlsFlflqzlE4k3dNq9ELaF6bS5siJXKvXSXJ
	 AxQ/jXkMamJAHktKdBcFFFEVoUYElKshmFe9OAPwdXQ78ypcMGB6y6mkxsdc9Utq3T
	 swlx3XYeVEzwkxV6JdxTARGjDfTKJXlKzyk2xPSbeBbWnrW9KpFCfkK/PMd6iHIqDe
	 5wsmH/pi28YEEK8WrCGrQgWdS4l3PhqPWrWa5gjiT+eByI7KanmBYrazv1QSmb8wT4
	 6eQskVSS087Qg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D4755CE1FD0; Tue, 15 Oct 2024 09:11:13 -0700 (PDT)
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
Subject: [PATCH rcu 13/15] rcutorture: Add light-weight SRCU scenario
Date: Tue, 15 Oct 2024 09:11:10 -0700
Message-Id: <20241015161112.442758-13-paulmck@kernel.org>
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


