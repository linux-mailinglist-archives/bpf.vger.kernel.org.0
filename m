Return-Path: <bpf+bounces-49106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D28DBA14310
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3BC188B24E
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD2024387A;
	Thu, 16 Jan 2025 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyGgN56T"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861ED2419F3;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058875; cv=none; b=oWqEdmmSF3JCOv+QHIPXTbKtbEnmJG9zx8TErvQISuA8nF7dowOOJENR+qaVAgXwoWsSODl0Wt7u6VmjyxuEUtYiLasqV3XWbU8mVAtgWXQKnnH6j6zeLLay1bGoCVGBEcJGqmBEzWyQjfinOrNWcTB+VVXX6mFeZCHP2rESy9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058875; c=relaxed/simple;
	bh=qZ5N0znarsb8nc88G8D6jI4/3NF8Vug/jojZz1Lsxpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H2eNyvmGXaI+ddFP0KPj2RCTVO+DX/df+b3pcr3T1sCtWcixI9mJDlG7IPlHH+7Ylr+7sTS/36PUOvfIyGnrmTToYG3EgA3MjkHQiviv8RMI9/DoGxvrvDZnnUPOw/ZF0eEdioS6l4X8crYETyZ7urmuoAJMEmwsbCWoMyHVcrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyGgN56T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0DCC4CEF4;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058875;
	bh=qZ5N0znarsb8nc88G8D6jI4/3NF8Vug/jojZz1Lsxpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FyGgN56TBhcRfIKdVu2vCvzdZ3kAl7ksHf2M1s6mgxPX8FfFWV3rQzIZmN2Uiiic0
	 u7TWoTk2yswXXai8i+2HFCkJyvgRHSab3SPvGHkoqlzUCkWRmxV82HuUTq0DsMsW4+
	 8QYGB18IrbOHx8iQmmJtZhij8iqlVBNr7HtdwF2ZlGIbHKpoKiUweL9M1ct/RtspP5
	 ga0DEWECUU9RT8bT6Ro/xo4qQyRNK9xELWfx7Psxyta7vQw1JI+C/uYxZf5EJTDqOV
	 CmbzYMVbPt+Hh135npZIE/5BVWh4ZCA7grz4zSbjgXZbIMaC0cwypj7qXhEMrODE8W
	 M/tWKNt86sbmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9641DCE37D5; Thu, 16 Jan 2025 12:21:14 -0800 (PST)
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
Subject: [PATCH rcu 09/17] srcu: Add SRCU_READ_FLAVOR_SLOWGP to flag need for synchronize_rcu()
Date: Thu, 16 Jan 2025 12:21:04 -0800
Message-Id: <20250116202112.3783327-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
References: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
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
index ca00b9af7c237..505f5bdce4446 100644
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
index 46e4cdaa1786e..973e49d04f4f1 100644
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


