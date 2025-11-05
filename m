Return-Path: <bpf+bounces-73722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FBCC37BE6
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DF718C684B
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715E734DB71;
	Wed,  5 Nov 2025 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTzmmkrY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687834AB1E;
	Wed,  5 Nov 2025 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374740; cv=none; b=IR4lNCnnqsWPijltbuCFGC4XK6o5alE/TTqncfXUXKS1WUyWqHNaHrFcSZKB+2E0kjWyrnDXgE4qW4wdg7eqaHdxZVNIzVffk9YCr58PGUJxDf3w1uwfJdbS3DHvxBhl/YzKDpz4EBm/thui/UDK78iMqu8Cc7bxAWtXuKDihgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374740; c=relaxed/simple;
	bh=7uPrv4irYTmEwJ2B3VG3qdNupsgZm8tMakjud6mO6xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J72t8dIp5WLhcE8Fyp0+L+6lCJEZtK+BvndWEKkIqvmZlM1lJU6Mxv85bgWX275lSKCO6maWK2ojfijuVB2cfZmK7KTcHFqrxLWc5foFdwg4EZlv3c3LCP8l+EQGydexP35+20dcrXj00t5jhKRMGL9T9uPdDYUkUzVaMRIAWoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTzmmkrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A087C16AAE;
	Wed,  5 Nov 2025 20:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762374740;
	bh=7uPrv4irYTmEwJ2B3VG3qdNupsgZm8tMakjud6mO6xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bTzmmkrY46z2jaGX+VV+L4GYI1IHCnoNC6T68gI2f3l014ApTF6Y754EFT82w3oOL
	 8yjuA0T7uZw0bhDMPQzOIMnUN0LTzcvRtQ5povhIzd/rBBB6eRzjImNiRIO+4nI8fP
	 EqOAsZ0VwPlMN4xgosnwynjFdBjAoCnxgryWJ4ibxgP4uRNWantt7KFQyE+RrNElYd
	 wX5QyczHdhsvFT0bSoY7rkBDQgL7w8cZ9LNMqY46ebC8L9MAjkbxrQXe2aNFMOW3Up
	 s/SHi1G66EFVR0zFcn0osygCw7qzrunRf8+U5Gjx7xtIfZviBgbWLsFNdNgl/vH4Kw
	 JtVe58v8wWneA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9BE01CE0F7D; Wed,  5 Nov 2025 12:32:18 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v2 09/16] doc: Update for SRCU-fast definitions and initialization
Date: Wed,  5 Nov 2025 12:32:09 -0800
Message-Id: <20251105203216.2701005-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit documents the DEFINE_SRCU_FAST(), DEFINE_STATIC_SRCU_FAST(),
and init_srcu_struct_fast() API members.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 .../RCU/Design/Requirements/Requirements.rst  | 33 ++++++++++---------
 Documentation/RCU/checklist.rst               | 12 ++++---
 Documentation/RCU/whatisRCU.rst               |  3 ++
 3 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index f24b3c0b9b0d..ba417a08b93d 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2637,15 +2637,16 @@ synchronize_srcu() for some other domain ``ss1``, and if an
 that was held across as ``ss``-domain synchronize_srcu(), deadlock
 would again be possible. Such a deadlock cycle could extend across an
 arbitrarily large number of different SRCU domains. Again, with great
-power comes great responsibility.
+power comes great responsibility, though lockdep is now able to detect
+this sort of deadlock.
 
-Unlike the other RCU flavors, SRCU read-side critical sections can run
-on idle and even offline CPUs. This ability requires that
-srcu_read_lock() and srcu_read_unlock() contain memory barriers,
-which means that SRCU readers will run a bit slower than would RCU
-readers. It also motivates the smp_mb__after_srcu_read_unlock() API,
-which, in combination with srcu_read_unlock(), guarantees a full
-memory barrier.
+Unlike the other RCU flavors, SRCU read-side critical sections can run on
+idle and even offline CPUs, with the exception of srcu_read_lock_fast()
+and friends.  This ability requires that srcu_read_lock() and
+srcu_read_unlock() contain memory barriers, which means that SRCU
+readers will run a bit slower than would RCU readers. It also motivates
+the smp_mb__after_srcu_read_unlock() API, which, in combination with
+srcu_read_unlock(), guarantees a full memory barrier.
 
 Also unlike other RCU flavors, synchronize_srcu() may **not** be
 invoked from CPU-hotplug notifiers, due to the fact that SRCU grace
@@ -2681,15 +2682,15 @@ run some tests first. SRCU just might need a few adjustment to deal with
 that sort of load. Of course, your mileage may vary based on the speed
 of your CPUs and the size of your memory.
 
-The `SRCU
-API <https://lwn.net/Articles/609973/#RCU%20Per-Flavor%20API%20Table>`__
+The `SRCU API
+<https://lwn.net/Articles/609973/#RCU%20Per-Flavor%20API%20Table>`__
 includes srcu_read_lock(), srcu_read_unlock(),
-srcu_dereference(), srcu_dereference_check(),
-synchronize_srcu(), synchronize_srcu_expedited(),
-call_srcu(), srcu_barrier(), and srcu_read_lock_held(). It
-also includes DEFINE_SRCU(), DEFINE_STATIC_SRCU(), and
-init_srcu_struct() APIs for defining and initializing
-``srcu_struct`` structures.
+srcu_dereference(), srcu_dereference_check(), synchronize_srcu(),
+synchronize_srcu_expedited(), call_srcu(), srcu_barrier(),
+and srcu_read_lock_held(). It also includes DEFINE_SRCU(),
+DEFINE_STATIC_SRCU(), DEFINE_SRCU_FAST(), DEFINE_STATIC_SRCU_FAST(),
+init_srcu_struct(), and init_srcu_struct_fast() APIs for defining and
+initializing ``srcu_struct`` structures.
 
 More recently, the SRCU API has added polling interfaces:
 
diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index c9bfb2b218e5..4b30f701225f 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -417,11 +417,13 @@ over a rather long period of time, but improvements are always welcome!
 	you should be using RCU rather than SRCU, because RCU is almost
 	always faster and easier to use than is SRCU.
 
-	Also unlike other forms of RCU, explicit initialization and
-	cleanup is required either at build time via DEFINE_SRCU()
-	or DEFINE_STATIC_SRCU() or at runtime via init_srcu_struct()
-	and cleanup_srcu_struct().  These last two are passed a
-	"struct srcu_struct" that defines the scope of a given
+	Also unlike other forms of RCU, explicit initialization
+	and cleanup is required either at build time via
+	DEFINE_SRCU(), DEFINE_STATIC_SRCU(), DEFINE_SRCU_FAST(),
+	or DEFINE_STATIC_SRCU_FAST() or at runtime via either
+	init_srcu_struct() or init_srcu_struct_fast() and
+	cleanup_srcu_struct().	These last three are passed a
+	`struct srcu_struct` that defines the scope of a given
 	SRCU domain.  Once initialized, the srcu_struct is passed
 	to srcu_read_lock(), srcu_read_unlock() synchronize_srcu(),
 	synchronize_srcu_expedited(), and call_srcu().	A given
diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index cf0b0ac9f463..a1582bd653d1 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -1227,7 +1227,10 @@ SRCU: Initialization/cleanup/ordering::
 
 	DEFINE_SRCU
 	DEFINE_STATIC_SRCU
+	DEFINE_SRCU_FAST        // for srcu_read_lock_fast() and friends
+	DEFINE_STATIC_SRCU_FAST // for srcu_read_lock_fast() and friends
 	init_srcu_struct
+	init_srcu_struct_fast
 	cleanup_srcu_struct
 	smp_mb__after_srcu_read_unlock
 
-- 
2.40.1


