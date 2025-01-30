Return-Path: <bpf+bounces-50139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D777EA2344A
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA64E3A544A
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 19:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0191F12FD;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsCAn8+k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F97C18E743;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263799; cv=none; b=rFkBwFXmf+/IzLp7hA7ja+mqGmxtvBfxrL/OVOou+/Wu0bBCpamrnHQsJk5EQAnGlNvsKTYBJYNHXfMVUw58/iZyQAHUslK+jfZ8DtDfKflfDK7rA7/ng2MnaFHdMoFRl77IbtjQwVcDTRbdB+QGltmWEac2COAIw6hxAIKsU3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263799; c=relaxed/simple;
	bh=lp9AQ9TKsxbomNyt4e4oCMRlXfFXDxB1Z9oZ9NSAOfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pa1mxCdtq134pgSLGd+7AQmoVSpEpu+3H1jZob1tZY+CboO9rcv7UlGaEzl+tDhjFPFFHh+L7IfI60cLSDnSQU6WsQNkNp3rgjOoyg7ih+vF5RQNcYR1zA/NXqWPdXEYH9lZWoik1huFpZSbHvS58g5GZp1E5v4Z5N08ZrVZaVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsCAn8+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3821CC4CEE3;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263799;
	bh=lp9AQ9TKsxbomNyt4e4oCMRlXfFXDxB1Z9oZ9NSAOfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WsCAn8+kXn6rDeMJVzkMMNOSBN5fh/qPCLJKp9toV9DIeMjwTdApefa12ipy+ScPm
	 kRnJhGWPN9B7Wygfp1+gBkjjHbq4yrwsVRHBYzU0ROlFniBDfDv6zaN0iQj/8G7g8m
	 1GqsLxSzepTSk3r3d4dYDuhmPkHmzQ/seh5OEGPK2NdOK6PfvQOlmBIlqA6a4J25B/
	 iItsdgntRi9U7BbYLyZUMuGJUjLpDzVEORtJmlQGtQKzqEX39hnu14MmWjntWiGNPz
	 euaWzJLNyGZD4SRWu+JHMrftqWa5Z+PunP4OoN2vTXv2r+/It2uhEm9Q2chJOt2pUf
	 /nqU0BkLJs85w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D8447CE37DC; Thu, 30 Jan 2025 11:03:18 -0800 (PST)
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
Subject: [PATCH rcu v2] 03/20] srcu: Use ->srcu_gp_seq for rcutorture reader batch
Date: Thu, 30 Jan 2025 11:03:00 -0800
Message-Id: <20250130190317.1652481-3-paulmck@kernel.org>
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
index d26fb1d33ed9..1d2de50fb5d6 100644
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
index f87a9fb6d6bb..b5bb73c877de 100644
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


