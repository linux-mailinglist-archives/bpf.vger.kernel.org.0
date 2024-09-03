Return-Path: <bpf+bounces-38791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4FB96A484
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90221F243A7
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 16:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412F919007E;
	Tue,  3 Sep 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0PhqSn6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BFF18DF78;
	Tue,  3 Sep 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381200; cv=none; b=DiGMjZbHplCiGVZ0YJ+iC4O4CAw2yQKt/czzkHsGSPues3kQf+aNEmDgL1Z9QuwdTiJWqkRUTWPh+K5qkskXwtv6ofiztabmdQZD17yDjNx+mtkOOey3BYYmign7kYP5TeVjhFAiImVVPCaKNVriF6qBFocqTu6mIpXy6DTXHAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381200; c=relaxed/simple;
	bh=TrRYS3BDqMwAYAWdj/eC52NWX50os8xSeV2W52BC9zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PsiVhYYtfk9SMs0gilTlCqgGaD6+9GjID+cW5tcAkjIANgvrJuOBGkQNe24LAp5kX16+R6Peryne0m2CWoZjyMlpcMJYw5ki26iZJ3mMgtmLeQuFzKL6Z/mWClxFwB05DUFS1L1v06BEj3J5UqeabcGfkny4UpEm3N9XAP065Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0PhqSn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA84C4CEDB;
	Tue,  3 Sep 2024 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725381200;
	bh=TrRYS3BDqMwAYAWdj/eC52NWX50os8xSeV2W52BC9zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K0PhqSn6GJAi5/ctfo28sRRyHbNSMWOeGfZF4RipImQ/eO52RoNO18D7MFpose/GJ
	 DhZ3BO4hlMfOoRjuYM8tzM9IkpxiVFAT5T2u0zWbDEClDvBNA8iLQ5z2bu6FZgP6tj
	 DH1IgFjSSzt+k2CIP89AKNVqNDorYEgf39frlfsNs7kArtqcQ+xi26wIQaWNf8Hqq/
	 sfl6OGokwgImSaanRpgEldsx1NsY/ZU+cefjVRkcJ0FpP9Z7MBpIkdGVWWy73sZ1RE
	 f3z/qBaNvpqvub9Gtd+I0l5CqdYhgeO2dEYiHj9cQKbdwsyl9D4kAI8pHuVMbyGmQF
	 TZZyF4nSaZYag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5613BCE2A9C; Tue,  3 Sep 2024 09:33:19 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/11] rcutorture: Add srcu_read_lock_lite() support to rcutorture.reader_flavor
Date: Tue,  3 Sep 2024 09:33:17 -0700
Message-Id: <20240903163318.480678-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
References: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
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
index e107c82f0b21b..39bf8ce17e992 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5357,8 +5357,8 @@
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
index 1a3e0fdca7139..306a449bbad87 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -660,6 +660,11 @@ static int srcu_torture_read_lock(void)
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
 
@@ -685,6 +690,8 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
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


