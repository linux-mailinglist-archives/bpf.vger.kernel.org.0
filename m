Return-Path: <bpf+bounces-73720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FA6C37BCB
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C5B18C4E21
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C5E34CFD5;
	Wed,  5 Nov 2025 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0zkxm8m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F734887C;
	Wed,  5 Nov 2025 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374740; cv=none; b=pmZVsYVldsczmSGlWIM0Zo2BYg/Lq5FJnNhP0e5pitvwPNwL/ghf5AV/8i+fAhrF5WoNC6PhA6b7RfkVelyzvlLlRE6yKDzbrrr/j8ZrEVbwfhMdvRgCnyby+n5dMSarHbnS01kpVl654KxUGvce5hsD/pZdOakU5AQLiMZABM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374740; c=relaxed/simple;
	bh=Q0AKERJDbUSfsvDf4x7Le3CWRCQuSmTY0wgl6K/Nz6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nhZwOT06pMixNBSd93XRVo/XNL+4KCrt/0vt8T1ctJpwoCDvXOSZTRWcSKAM4mWYfylAGxk1AjSrFJg0CZz4wD9VPN0Bp3atiw1XxcP4v5Ux2Y4Mc7ntjyIQUSEcyjCZaDFdVazXvsFhQKQ+6BRa/O78lVDVa2AgO5wn7SMVYFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0zkxm8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E11C19421;
	Wed,  5 Nov 2025 20:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762374739;
	bh=Q0AKERJDbUSfsvDf4x7Le3CWRCQuSmTY0wgl6K/Nz6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a0zkxm8mFO7vLeGUlhKNDvzrqqCJ0EWgw4UvfOtFP5952B63y1fRdQgZS32OnmQR0
	 O7EX8EbBUF6VtkPbhTj4J7M29E3fWzNM8z/CCkQGDDjRji/D7xUzKRJjlRsklWNjhc
	 s33zlrIlL1d9heXeSugnO7FO7hwDXcBoXzxaiFj6CgoewRfxYandFy8y483vOAONwB
	 pANzmEdIGy7GbXTtZa45tKpWwo9GoVIKILZc5/PCTrgYFqUe3FVil29mmRdvqcsvHO
	 u8191369DjGEm8BLIiLxNW96O/Z8XQv4ZEhgiLV5+MpqS08sJtMM7W36n9EI2eqq1Y
	 zj0NoOWyv63bQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 916D9CE0EBB; Wed,  5 Nov 2025 12:32:18 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v2 05/16] srcu: Make grace-period determination use ssp->srcu_reader_flavor
Date: Wed,  5 Nov 2025 12:32:05 -0800
Message-Id: <20251105203216.2701005-5-paulmck@kernel.org>
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

This commit causes the srcu_readers_unlock_idx() function to take the
srcu_struct structure's ->srcu_reader_flavor field into account.  This
ensures that structures defined via DEFINE_SRCU_FAST( or initialized via
init_srcu_struct_fast() have their grace periods use synchronize_srcu()
or synchronize_srcu_expedited() instead of smp_mb(), even before the
first SRCU reader has been entered.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 9869a13b8763..c29203b23d1a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -490,7 +490,7 @@ static bool srcu_readers_lock_idx(struct srcu_struct *ssp, int idx, bool gp, uns
 static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx, unsigned long *rdm)
 {
 	int cpu;
-	unsigned long mask = 0;
+	unsigned long mask = ssp->srcu_reader_flavor;
 	unsigned long sum = 0;
 
 	for_each_possible_cpu(cpu) {
-- 
2.40.1


