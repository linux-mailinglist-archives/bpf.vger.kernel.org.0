Return-Path: <bpf+bounces-73304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882EFC2A473
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 08:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677E73B04F9
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 07:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2899529C326;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnBM3d/E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B2153BED;
	Mon,  3 Nov 2025 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154352; cv=none; b=WbgU0fBj7qvCM9zZLRGz4dIyG8nMWi7fQpSgCvxbkIa5KTVq5qt/Ns/3aujIGR9xhSJB0OHeesTphRC8ShjbUQVtc7JN+YbhKowu0MMn0uvOBSyVSt0xFF1tMGIMFNFFoRPLwGl3c8DjSXTOMt/8U5dH+hQzsXCI3yLnoPozeKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154352; c=relaxed/simple;
	bh=Q0AKERJDbUSfsvDf4x7Le3CWRCQuSmTY0wgl6K/Nz6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=osSOK/cWXFSH6GA1HXq8yobNLc7HHjwWl6+CDCi8HQbq+Xxwvk8Phb7299HBKZrHRd4gQheDu5YY6H8r5/6iUxUDl49SikGgN/jDwdYJf4FWgJflLPMp+ssp5Q2XOELgka8rTdu0XZF8mV8N9O58rbezJWOPDu5GrekSPYxrT9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnBM3d/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382EBC4AF0B;
	Mon,  3 Nov 2025 07:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154352;
	bh=Q0AKERJDbUSfsvDf4x7Le3CWRCQuSmTY0wgl6K/Nz6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jnBM3d/E+ybQzkcBC9iT6IUwRUfd3ufuyVxc8Fl/nEFWDPKw5MGD2U9mumDTjbuL+
	 xSsCTxgqlHeH+1tAy98A17kJgirQ/bMgYUTzWldFY+dzypYu3+IpNHADmPW87XwZ0u
	 EzZ/wA8a1h4HRdVcoIp/lRW6vNwHgiJXu5ru/ojh/3gp63fDNK/d7v6ml0pg37vOeP
	 HLIGWXyg2ZmxfN69zi2K65i1OoskCrL+6PY2Qv9NJlcMJyJM7XhzbCPWgV/eKGHzj0
	 GJprz6KUBoUPCyPDbk0c5qsmpT8dKZk5k4NGhFe09KomwZmYkUzoM/sbdaQE/082Z+
	 BiLd3EwBVRNMA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 84200CE0FF9; Sun,  2 Nov 2025 13:44:37 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH 05/19] srcu: Make grace-period determination use ssp->srcu_reader_flavor
Date: Sun,  2 Nov 2025 13:44:22 -0800
Message-Id: <20251102214436.3905633-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
References: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
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


