Return-Path: <bpf+bounces-56152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D9BA924E3
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 19:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B854634AF
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 17:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A0725D1F5;
	Thu, 17 Apr 2025 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B0EFgszK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D83A256C6E;
	Thu, 17 Apr 2025 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912561; cv=none; b=bwbDaeuC5pel7GF6wZ0HDJQd17W0Kjtduob7qRWV1rDUqNPPnz8mpW/ze+vhbZZou9LbINFyehyrd5QEJiUd+8BJiQMKzALkqu/r/nuu38jwLgcOaexpVAxcfC9NVKnmMzgGYNvBDx4rzVL2+j3AzDDuh2eQWGY0qXVUfmgGGIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912561; c=relaxed/simple;
	bh=eaxbHNubJ/EzZQo6aqRuDiaf9TjtyXrV0m8iLBfAgJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTasLEBMRauJFbGy0qqBjyV19O7xEom+uayGDBN2AOU1XTDtDXx8Tx/SLXyUJqKraGGgDIl9AhfyWBElMF4y4e+BAuXp2J5w6mvyusKciMSCiRH6EIpUiH4G3n60YQ7ugo8kaGjG6xMjSHOfJeGHxSmF+2s+PCfFLJcCYZEEfY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B0EFgszK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCC4C4CEE4;
	Thu, 17 Apr 2025 17:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744912561;
	bh=eaxbHNubJ/EzZQo6aqRuDiaf9TjtyXrV0m8iLBfAgJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B0EFgszKv5lxMny78R4IIrTAOuhLc7a8eMpvOjdqLlJWRQNqdL3mu+VTD+c+vdFlM
	 SK6uDYd6r2r2PtbEl2Xs+2Pe4+Pk21ZxyOI2u/jXBfS/VwJnpwg/cZHZgmu1aX1YJB
	 uP2hqM7p6wfuo/0MmC50aqX44BeD0m20KgBfcD8U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+16a19b06125a2963eaee@syzkaller.appspotmail.com,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 051/449] srcu: Force synchronization for srcu_get_delay()
Date: Thu, 17 Apr 2025 19:45:39 +0200
Message-ID: <20250417175120.039482205@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul E. McKenney <paulmck@kernel.org>

[ Upstream commit d31e31365b5b6c0cdfc74d71be87234ced564395 ]

Currently, srcu_get_delay() can be called concurrently, for example,
by a CPU that is the first to request a new grace period and the CPU
processing the current grace period.  Although concurrent access is
harmless, it unnecessarily expands the state space.  Additionally,
all calls to srcu_get_delay() are from slow paths.

This commit therefore protects all calls to srcu_get_delay() with
ssp->srcu_sup->lock, which is already held on the invocation from the
srcu_funnel_gp_start() function.  While in the area, this commit also
adds a lockdep_assert_held() to srcu_get_delay() itself.

Reported-by: syzbot+16a19b06125a2963eaee@syzkaller.appspotmail.com
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/srcutree.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index b83c74c4dcc0d..2d8f3329023c5 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -647,6 +647,7 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 	unsigned long jbase = SRCU_INTERVAL;
 	struct srcu_usage *sup = ssp->srcu_sup;
 
+	lockdep_assert_held(&ACCESS_PRIVATE(ssp->srcu_sup, lock));
 	if (srcu_gp_is_expedited(ssp))
 		jbase = 0;
 	if (rcu_seq_state(READ_ONCE(sup->srcu_gp_seq))) {
@@ -674,9 +675,13 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 void cleanup_srcu_struct(struct srcu_struct *ssp)
 {
 	int cpu;
+	unsigned long delay;
 	struct srcu_usage *sup = ssp->srcu_sup;
 
-	if (WARN_ON(!srcu_get_delay(ssp)))
+	spin_lock_irq_rcu_node(ssp->srcu_sup);
+	delay = srcu_get_delay(ssp);
+	spin_unlock_irq_rcu_node(ssp->srcu_sup);
+	if (WARN_ON(!delay))
 		return; /* Just leak it! */
 	if (WARN_ON(srcu_readers_active(ssp)))
 		return; /* Just leak it! */
@@ -1102,7 +1107,9 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
 {
 	unsigned long curdelay;
 
+	spin_lock_irq_rcu_node(ssp->srcu_sup);
 	curdelay = !srcu_get_delay(ssp);
+	spin_unlock_irq_rcu_node(ssp->srcu_sup);
 
 	for (;;) {
 		if (srcu_readers_active_idx_check(ssp, idx))
@@ -1849,7 +1856,9 @@ static void process_srcu(struct work_struct *work)
 	ssp = sup->srcu_ssp;
 
 	srcu_advance_state(ssp);
+	spin_lock_irq_rcu_node(ssp->srcu_sup);
 	curdelay = srcu_get_delay(ssp);
+	spin_unlock_irq_rcu_node(ssp->srcu_sup);
 	if (curdelay) {
 		WRITE_ONCE(sup->reschedule_count, 0);
 	} else {
-- 
2.39.5




