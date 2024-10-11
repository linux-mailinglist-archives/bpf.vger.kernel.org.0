Return-Path: <bpf+bounces-41767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 908CE99AA8E
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 19:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE291C21A60
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 17:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239AB1D0142;
	Fri, 11 Oct 2024 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZnA64R0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4DF1C8FC0;
	Fri, 11 Oct 2024 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668373; cv=none; b=dugbhNU29sR7hSMvj673a7Ci6eSw57XfyXe5WXv2pQcqpDiaxuMtqNoNNrP6PZkmw2vxcZ9GXSlfE4KzR0QqB6EU5SRikK7f9qYL1ydDu3+V4zA/AJgSHdg9kDBTu0Mh1BuCOnTRXs3yq1Q2sHwEu7UHan7PixAbmY2Yuzpga2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668373; c=relaxed/simple;
	bh=2/hu6Yi0XsmLS7jmPPcP2qqf4oo1mhmwzrHcI6b4xBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fYYIzrkeYpcQCWnClG0PR/lbxvgUHKcURmr7xM8Eno9JplBloJa3okRmvJ5xQq8xABb5qDd4kGINDF/jNu4I++kiGt4B175cIkO7b8NKiiYGTvxZAznujH4zQDtq3FN0vu85WX11F8b/R7w93btnZr36oElzRJRdYujy34YbONQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZnA64R0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F2EC4CECF;
	Fri, 11 Oct 2024 17:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728668373;
	bh=2/hu6Yi0XsmLS7jmPPcP2qqf4oo1mhmwzrHcI6b4xBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eZnA64R0ZeQ681YG9A5oU06l2QqEKnA9DWhONKA/HCfSWdJQquJlN38/U4a7sD6I5
	 t8avRXal1UwdDUm1OCZ81a+KLhGFvpa6/W43n+lhi/mKJ47qygR04S6BikO/ufVZ/f
	 xcpyNqEYgcPNuiS8n5FgHWF2eH57wBfJ8LHomzyiq1a3332GuKJmG1DmLayrut09jI
	 2oM9OWGQ2vSf+AB4viTowxKEcbidyA6sQDiw1TX0HOPzOU7A2T8oEwS0IurkiyS9Gy
	 VrMrjbvRPQr2OLsUSDBAz2S6gYYEpnKMpmnE+7+IIrhRTwLjNSxqSDV9DneuFL+X/4
	 8dziQtQaHNg9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B2BC0CE0F99; Fri, 11 Oct 2024 10:39:32 -0700 (PDT)
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
Subject: [PATCH v2 rcu 10/13] rcutorture: Add srcu_read_lock_lite() support to rcutorture.reader_flavor
Date: Fri, 11 Oct 2024 10:39:28 -0700
Message-Id: <20241011173931.2050422-10-paulmck@kernel.org>
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
index 52922727006fc..203ec51e41d48 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5431,8 +5431,8 @@
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
index 405decec33677..a313cdcb0960f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -658,6 +658,11 @@ static int srcu_torture_read_lock(void)
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
 
@@ -683,6 +688,8 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
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


