Return-Path: <bpf+bounces-50146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527EAA23455
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5138E3A60E5
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 19:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0866E1F238D;
	Thu, 30 Jan 2025 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpAMnCDC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6031F1309;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263800; cv=none; b=Az/tp5rpM3uUsfOL5CxRbsyRoovDapo9NorAaTj1Bz6MFx/9J2uMN0cyXTZoNly1g6vq8Tb3m6d8/H0hs9gnZj6ZI0ZPwU1QhfJjULCg+m88IqAV6lDgRFb2V2S8j/Xre3D/kieGGzemFEbBAoo5v5du7GY6o4lq0VUO6OS5B1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263800; c=relaxed/simple;
	bh=5ruSTvJEzPGDJi6C6EpBP1OHtgmiOjNHg94xZOMkJZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AotOM9FGhCFc6ctukMY92BoAuDQzJvILadWsXiSEcwwuQgYcy9JOo5qW6wBexsXA8Q+URni7OxhkjmFi04WsuLlZxQjaHGAuXBbsNrYsNl315BnQLryUGgBzvSF39ozgKOfY/FKrsnc8ZdRGEzKSram8tGrUCr/Y092H8zm4Iu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpAMnCDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97638C4CEE5;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263799;
	bh=5ruSTvJEzPGDJi6C6EpBP1OHtgmiOjNHg94xZOMkJZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kpAMnCDC0MBzoflQXttkdt7xLZ54oy0p2Kc3irhEQtbBKWxnoZSbpz63VELBEpNAq
	 SnflTk+y4HcVO5iw4EOcOBnJw+pt8eFdJ+kc2rEyB1U2a0lbQgkFgibQl7HJ6YNTc3
	 ArxzVRMYOo4V5NHwAsX0WU6NeJuXpjmZwxZQDC9atX5l9/IfXAhS0NAD4Fax9aPk2q
	 Ddirmomk1v5A5yvYqtIiSCcKbbiwgCXi4+x7ypTqYu6JIKxEEPM+L1qIBGPZTOezMz
	 N9/Zv0npD8siCfTBSyhrklY3FMhd6vvQTpIlTrxdViEc94vv/KF1yzsQAlQzMIZXNx
	 jEaqXRfinQbrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E98F3CE37E9; Thu, 30 Jan 2025 11:03:18 -0800 (PST)
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
Subject: [PATCH rcu v2] 09/20] srcu: Add SRCU_READ_FLAVOR_SLOWGP to flag need for synchronize_rcu()
Date: Thu, 30 Jan 2025 11:03:06 -0800
Message-Id: <20250130190317.1652481-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
References: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit switches from a direct test of SRCU_READ_FLAVOR_LITE to a new
SRCU_READ_FLAVOR_SLOWGP macro to check for substituting synchronize_rcu()
for smp_mb() in SRCU grace periods.  Right now, SRCU_READ_FLAVOR_SLOWGP
is exactly SRCU_READ_FLAVOR_LITE, but the addition of the _fast() flavor
of SRCU will change that.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h  | 3 +++
 kernel/rcu/srcutree.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index ca00b9af7c23..505f5bdce444 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -49,6 +49,9 @@ int init_srcu_struct(struct srcu_struct *ssp);
 #define SRCU_READ_FLAVOR_LITE	0x4		// srcu_read_lock_lite().
 #define SRCU_READ_FLAVOR_ALL   (SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
 				SRCU_READ_FLAVOR_LITE) // All of the above.
+#define SRCU_READ_FLAVOR_SLOWGP	SRCU_READ_FLAVOR_LITE
+						// Flavors requiring synchronize_rcu()
+						// instead of smp_mb().
 
 #ifdef CONFIG_TINY_SRCU
 #include <linux/srcutiny.h>
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 46e4cdaa1786..973e49d04f4f 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -449,7 +449,7 @@ static bool srcu_readers_lock_idx(struct srcu_struct *ssp, int idx, bool gp, uns
 	}
 	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
 		  "Mixed reader flavors for srcu_struct at %ps.\n", ssp);
-	if (mask & SRCU_READ_FLAVOR_LITE && !gp)
+	if (mask & SRCU_READ_FLAVOR_SLOWGP && !gp)
 		return false;
 	return sum == unlocks;
 }
@@ -487,7 +487,7 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
 	unsigned long unlocks;
 
 	unlocks = srcu_readers_unlock_idx(ssp, idx, &rdm);
-	did_gp = !!(rdm & SRCU_READ_FLAVOR_LITE);
+	did_gp = !!(rdm & SRCU_READ_FLAVOR_SLOWGP);
 
 	/*
 	 * Make sure that a lock is always counted if the corresponding
@@ -1205,7 +1205,7 @@ static bool srcu_should_expedite(struct srcu_struct *ssp)
 
 	check_init_srcu_struct(ssp);
 	/* If _lite() readers, don't do unsolicited expediting. */
-	if (this_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE)
+	if (this_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_SLOWGP)
 		return false;
 	/* If the local srcu_data structure has callbacks, not idle.  */
 	sdp = raw_cpu_ptr(ssp->sda);
-- 
2.40.1


