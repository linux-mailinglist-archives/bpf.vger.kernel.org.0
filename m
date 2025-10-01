Return-Path: <bpf+bounces-70105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CCCBB0D40
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9A03C5701
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 14:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C843081D4;
	Wed,  1 Oct 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZV7DNIaW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973F9307487;
	Wed,  1 Oct 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330122; cv=none; b=p19SIer6YT+0cmF8o7a4HQhxrP0gR92vVYhzUuo/3EFQAygrFVI2UZxy3rIwJNsehFbq3fxHs3buB1BUWY4lUar5RJWW2u7O3HmAzZyndCKf+MkAQAAUBg6CWmhtANeItm2uKkoxUJiD1hN+XsUZKeQwVIJ2NlAkX2Pqdr27c6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330122; c=relaxed/simple;
	bh=81BLq8+oPnPePeqC2bm5XK2/WvvBNdRPQuuI5LrZL9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H9LdMdhDTjQmebPgaiyv9+IuzIDZQqjsJ5XlIrfAIcnFTDvQYLGwcygkyKMGHYapR39Xi2cVegqv0BXTyJGminYNKJ5o0ptRDNbq017VryyG3HggNK51amwpJ6AruFSC9axhdPz7aXr8IO2YbdLvdZ+aSOspRaepjax17gxYCSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZV7DNIaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF1EC4AF0B;
	Wed,  1 Oct 2025 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759330122;
	bh=81BLq8+oPnPePeqC2bm5XK2/WvvBNdRPQuuI5LrZL9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZV7DNIaWcrlojWlA3X9ZPb/9vaOqUIRRr/b+Mg643ai0OqJ88s5P/XvBdWIINDEGU
	 9PcWKT7K9IXv+J950K32IJpGKGfQuHhofS3AvSjIJtabEdNoqua93mjXWNNIceFHbf
	 Q5tNxIRqroWCNYfGdJ0ch72lKFwxAM7Ukr1lEgDyyBJx87m/feF1YP0oQiXHg3Rz49
	 FeaswbGPbUorsETo4yAk4OsCVbHAGEI7V2vQoSa9t+a7dh+vNBasWOAnANgi6zpDkb
	 RzxvLNh0ccgwN0LqW3HHxGsoc4kfHIL4uRu7fnYTDpPJroipsZI1aBrPZgQsDnK15S
	 Ub9hqLOCzcAWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 92237CE14F5; Wed,  1 Oct 2025 07:48:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v2 19/21] doc: Update for SRCU-fast definitions and initialization
Date: Wed,  1 Oct 2025 07:48:30 -0700
Message-Id: <20251001144832.631770-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
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
index 4a116d7a564edc..b5cdbba3ec2e71 100644
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
index c9bfb2b218e525..4b30f701225fdb 100644
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
index cf0b0ac9f4636a..a1582bd653d115 100644
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


