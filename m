Return-Path: <bpf+bounces-70102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F538BB0D13
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAD21946139
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 14:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F85306499;
	Wed,  1 Oct 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0+AuOus"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957F6304BB3;
	Wed,  1 Oct 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330120; cv=none; b=V8TsMS98z9+kTn89/vJsx1bIyZUL/5MNSNAnCWbEUqwhpyQ/RUs5wq7R2qF9bVIBIQFVKuKxh98otJ8k87Zslq1E9inN/kxh5Y+Xq4BkoI1656F1tnjmmAohAXFwSRLzDe7Y1TO6KRp/xzdfy128FX9bdQIUFJNvK6DWAN5QY+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330120; c=relaxed/simple;
	bh=pdnTyZTL7oQ5jSpDQHBWEglBgEqYI4vFkpmgL1RNbu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pSs0qUeryIJCE9UIB04zu6SP5jzmtVYUxxp3fCOBZZRQD3QOFoAT2vgUCaUZZnmmWXLeWcHjoshE26ysvyDLERohsKX4VxBkG8CO5QlksHQxuCWj40kedu+J2w8Z1d07i4BzBK/BNVBZHVke65veGWKephk4Dvl/LtJZ43MHYFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0+AuOus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04578C116D0;
	Wed,  1 Oct 2025 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759330120;
	bh=pdnTyZTL7oQ5jSpDQHBWEglBgEqYI4vFkpmgL1RNbu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a0+AuOus2VUJ6A77QBhQkKFyKvAaLi4uJn0dGy/IzRTbIbqab1b1FwN8OVGNjqMVM
	 L2/BQs39dPyC9L+0+ts8mI9rWqQjaY446jMGc4rLaOi0XRWj+FqnItuoB1IfH4rZjm
	 h+H0c5Rbec4yOh9NECV/ua8m2HxJz3nIfIheRADNI1Ie/8R0eokTS96xebG7cLUuPY
	 Bv40CVHy37zauyt8zywHK3LYEh8nKZHJPr1GurkgXSgXEOVJWqBs10TvccyTa9OMk6
	 N9hnPpOUNbeiqQEAbKlXi3URVLetqfAgYRDf13NCB8ezhC2WxoEUNYKM/oURba77YZ
	 +HrWs402CM68g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8523ACE147E; Wed,  1 Oct 2025 07:48:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v2 14/21] srcu: Make grace-period determination use ssp->srcu_reader_flavor
Date: Wed,  1 Oct 2025 07:48:25 -0700
Message-Id: <20251001144832.631770-14-paulmck@kernel.org>
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
index 9869a13b876342..c29203b23d1ad7 100644
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


