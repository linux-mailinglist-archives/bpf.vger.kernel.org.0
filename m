Return-Path: <bpf+bounces-41470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9390997423
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 20:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C452817E6
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A98A1E2839;
	Wed,  9 Oct 2024 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M56uivsl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC541E1C25;
	Wed,  9 Oct 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497242; cv=none; b=klRIVeZrD8CNrZsYYUIlV7ZBsyzQN2tQ6D+sTtx21eyc9FpjOLoRNwJtGWRzrCBzVfy8pUCq8jjYkuoM8lfsgyO0i1DmnBhSXsAsOeESfzQ/EFlE4IpuUxvcyMm/o2i8ULc/HTerrM+1GguKYT+s6pRfdqbnWlU6JTUZFnpF+ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497242; c=relaxed/simple;
	bh=aRxkj03S73hF0jV8gryZajtKN0A7DA6aTKR8Jq/1sgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LplFtQvntknIeQpkQqJUzzTwhPZl24mkh3xaQiu0YElucGOf0ZUc7Nb0HHmuywboOCFZ9o8uaCQEniUtAxotwXHQVKKVzrH8jkXAiSuDrDcbLYVjswF7i1cozWDVia5RByEJFq958/94IVs8VEmBVsXr4rN2buWLDj3P1mC1CF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M56uivsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A6DC4CEE3;
	Wed,  9 Oct 2024 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497241;
	bh=aRxkj03S73hF0jV8gryZajtKN0A7DA6aTKR8Jq/1sgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M56uivslS80U3bDHqzXOPKBY9t3uuKNID6MTG9/Dz2WWpuCsFb19bJ/1JtfXvGqYt
	 o8CIpd16zK/IBUY79iT4ErhQQR28b5Dz8ytETi0bAcMqVYHnxvbegLQ+v4Hofwvf4g
	 YEj9QC2kp9gEM4a7UWu/sODFLyvLq9MXbtTbJKky6X0iIOKerjStKBoEKm3mjUELnN
	 te5/Q7j6E1TDEpx1vXo9lCZCSmPFHLFxFk0epGgXwVcWckBGE9s8EDUT/OaewxbDN5
	 SnjBy8H88Q7zRLx/nCuC++T+p9wm3Zvn4F4IkaRboYByKb4A6/W2p/TlbwNFJXfuTo
	 +rFP9GgJDntJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3068CCE1C55; Wed,  9 Oct 2024 11:07:21 -0700 (PDT)
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
Subject: [PATCH rcu 11/12] rcutorture: Add light-weight SRCU scenario
Date: Wed,  9 Oct 2024 11:07:18 -0700
Message-Id: <20241009180719.778285-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
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


