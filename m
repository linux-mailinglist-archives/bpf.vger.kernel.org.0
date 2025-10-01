Return-Path: <bpf+bounces-70104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3EFBB0D37
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B623D188ECF6
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 14:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A393081D2;
	Wed,  1 Oct 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW4StiLS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951AD306D58;
	Wed,  1 Oct 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330122; cv=none; b=rdlqt6DiRRvBIcWe3/oCETWVnl13PdSLJO1gZGkRyUIGbFU8MLGU5gV8HhmwQMJVW+FsQefZT5B5uyDIqh0NQQ9im54q5w2JAyw4SbvVt02M1Ou2x8SAca6DZiCUiwXZHcMsT9/1hwvFyfLDUqy0EM8JKuQ3pBkR0Ys6rm41pg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330122; c=relaxed/simple;
	bh=XhR9e3hqlUudx27Vubeb4TW2DWMcOEhmyHuKz9F2A/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJgO1G0Y9+Hs4U9+dBs9JPEhozO0u4kuUl5DET7TmZoqIw6FR7pUnACV80PcT7eCbBflSaMQ5WIIR+O+ebPKDYPvrrob8d6jxKhV757B3v2BrVeDXQY7obR6Rtt+ChJV/j7+Ph0BbqCAFQVZkFoL4Zz/TlyywlXS57i9FbXwZNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MW4StiLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3B0C4CEF9;
	Wed,  1 Oct 2025 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759330122;
	bh=XhR9e3hqlUudx27Vubeb4TW2DWMcOEhmyHuKz9F2A/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MW4StiLSL/ElaVEebubHzd/b/Qn/rurqgM7IolVNzy0msGtcBwyPWp16vYkK98+P6
	 HEut7n+MEoyw1vL3FS/pa5uCNNowlkBQAgbvZ3BRNpEVl3+e3OxUILaUKQ7KNwlDgi
	 hL0NpeQguVM8OndK4urvj7qw7C7VBhYCp6YJgclHwMq6nVZsUpThV0BqOF+UFPejmX
	 gU7iCPf5GNlNm3hvEwB0TarFQlcZ7W/Z514g0cz64h2aaHX3XLj+hjLdiNIDFGCJL7
	 TPzb3chsbu5dhxbfalbkFEFIY8e0k0BetFVua+I4UcpMArQUYBKN06/m/4eufpnoUf
	 uFvPZSza+Lr9g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8A6C6CE14C4; Wed,  1 Oct 2025 07:48:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v2 16/21] refscale: Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast()
Date: Wed,  1 Oct 2025 07:48:27 -0700
Message-Id: <20251001144832.631770-16-paulmck@kernel.org>
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

This commit updates the initialization for the "srcu-fast" scale
type to use DEFINE_STATIC_SRCU_FAST() when reader_flavor is equal to
SRCU_READ_FLAVOR_FAST.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/refscale.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 19841704d8f579..ece77f6d055b85 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -184,6 +184,7 @@ static const struct ref_scale_ops rcu_ops = {
 
 // Definitions for SRCU ref scale testing.
 DEFINE_STATIC_SRCU(srcu_refctl_scale);
+DEFINE_STATIC_SRCU_FAST(srcu_fast_refctl_scale);
 static struct srcu_struct *srcu_ctlp = &srcu_refctl_scale;
 
 static void srcu_ref_scale_read_section(const int nloops)
@@ -216,6 +217,12 @@ static const struct ref_scale_ops srcu_ops = {
 	.name		= "srcu"
 };
 
+static bool srcu_fast_sync_scale_init(void)
+{
+	srcu_ctlp = &srcu_fast_refctl_scale;
+	return true;
+}
+
 static void srcu_fast_ref_scale_read_section(const int nloops)
 {
 	int i;
@@ -240,7 +247,7 @@ static void srcu_fast_ref_scale_delay_section(const int nloops, const int udl, c
 }
 
 static const struct ref_scale_ops srcu_fast_ops = {
-	.init		= rcu_sync_scale_init,
+	.init		= srcu_fast_sync_scale_init,
 	.readsection	= srcu_fast_ref_scale_read_section,
 	.delaysection	= srcu_fast_ref_scale_delay_section,
 	.name		= "srcu-fast"
-- 
2.40.1


