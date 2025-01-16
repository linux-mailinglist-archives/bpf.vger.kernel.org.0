Return-Path: <bpf+bounces-49098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FACDA14303
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82CA57A2C0C
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9197E2419FC;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoE0U1XV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9E51993B2;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058875; cv=none; b=cO6RHZMAATQFeBvqR4JjCx5hDwyH47ssFQrYPWzakv1OjvBGHpMETMB2Y+rHqb9DzDtqrleWsshdjMb1dsNjQDYXVM1Si7egUy/Zc4deWLpyf5DbbPpk5sM591TJyBNFUD296jYGxtVGtHoEQkyDMj3WH3tkC6U9UA/YZLhKqYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058875; c=relaxed/simple;
	bh=agoDDzi55tZiNpJkbv6TUrSG6N86zEnTZs0F9AAe1Kk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=soKx7/DLP0rvF0mmIJ5dLgnXDJprVXJJ7S9IyGSKxF85Lo3agL8EeDFr88ebZ0HDG67zUg22Uq/4RmpCwwkKHl44Qmr+sjAqlKH8YS5pso9X4B/VvYAGZ06a+m0Rq+vlrCdRy0TXyclMFp4mRE30Jk781tqFRF26LQUoNO4PSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoE0U1XV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DA2C4CEDF;
	Thu, 16 Jan 2025 20:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058874;
	bh=agoDDzi55tZiNpJkbv6TUrSG6N86zEnTZs0F9AAe1Kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KoE0U1XVENdGNF4T2zoM57XFH/lHnPPBUBfC2grYhBMPlhJPqIUrTH2JajSz7CXMV
	 D7XMYV1sRJexuRGDFANA4n4bFhkKSFJqZ8eLPciUcGIvEsO0x/ezGQ1VPV+EdILi+C
	 t6jdFRF/192r4al/1iAz7GL0ILdoaot5wOL3UB3PwvZfmVUT7VhCLxuyU4pwzDhW2z
	 I8VYwyRALEJbEv0m6tpuIBa2D7fySdJvrLsdcLC3kuWN8eb82nXdWzCtmcwJRRdGLj
	 VlUpDgiVyYGwFdkoyjo9MWKHAdrLH2KrsTD2pYLxW1oZtDgLEkMYMz4fDcyI/A9ByA
	 VaJpT0a91QHFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 87286CE37B4; Thu, 16 Jan 2025 12:21:14 -0800 (PST)
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
Subject: [PATCH rcu 03/17] srcu: Use ->srcu_gp_seq for rcutorture reader batch
Date: Thu, 16 Jan 2025 12:20:58 -0800
Message-Id: <20250116202112.3783327-3-paulmck@kernel.org>
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

This commit stops using ->srcu_idx for rcutorture's reader-batch
consistency checking, using ->srcu_gp_seq instead.  This is a first
step towards a faster srcu_read_{,un}lock_lite() that avoids the array
accesses that use ->srcu_idx.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/rcutorture.c | 2 ++
 kernel/rcu/srcutree.c   | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d26fb1d33ed9a..1d2de50fb5d60 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -791,6 +791,7 @@ static struct rcu_torture_ops srcu_ops = {
 	.readunlock	= srcu_torture_read_unlock,
 	.readlock_held	= torture_srcu_read_lock_held,
 	.get_gp_seq	= srcu_torture_completed,
+	.gp_diff	= rcu_seq_diff,
 	.deferred_free	= srcu_torture_deferred_free,
 	.sync		= srcu_torture_synchronize,
 	.exp_sync	= srcu_torture_synchronize_expedited,
@@ -834,6 +835,7 @@ static struct rcu_torture_ops srcud_ops = {
 	.readunlock	= srcu_torture_read_unlock,
 	.readlock_held	= torture_srcu_read_lock_held,
 	.get_gp_seq	= srcu_torture_completed,
+	.gp_diff	= rcu_seq_diff,
 	.deferred_free	= srcu_torture_deferred_free,
 	.sync		= srcu_torture_synchronize,
 	.exp_sync	= srcu_torture_synchronize_expedited,
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index f87a9fb6d6bb8..b5bb73c877de7 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1679,7 +1679,7 @@ EXPORT_SYMBOL_GPL(srcu_barrier);
  */
 unsigned long srcu_batches_completed(struct srcu_struct *ssp)
 {
-	return READ_ONCE(ssp->srcu_idx);
+	return READ_ONCE(ssp->srcu_sup->srcu_gp_seq);
 }
 EXPORT_SYMBOL_GPL(srcu_batches_completed);
 
-- 
2.40.1


