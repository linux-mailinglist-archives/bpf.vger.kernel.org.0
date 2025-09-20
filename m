Return-Path: <bpf+bounces-69056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFE8B8BBF9
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2412D1BC4A13
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1D12D0612;
	Sat, 20 Sep 2025 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0keoYFM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34B12C11E5;
	Sat, 20 Sep 2025 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329997; cv=none; b=qiYbjSwgx6/kNULk7ItckvOLRQcTh7SRJdkmh+57vMniTgV5/i9VYrgtTLLIQujajShmd0tPwL/KwfxsnfQJfpaxb6UhVZQpJbx+foNyXB9lGQl2baa1hR/RM5ase8y0ULh2/I/5cJ+xHXu+l5tEF0xQRSMXw4qX4yBxHwNO27o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329997; c=relaxed/simple;
	bh=o1SMsZdkzvH0cbMc1xDF7m+UJCXrcwarUk6PkPxqhDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtYKwcXlDkserxYyFntLnN/87Cl4ITZw3k4GTbJrzih2e2iznzvd5Qwevk3n3uyD5OcCg1m4SRrOo52dR1pkvvMsBO//Jy/xmaKySgtLDbDLJqF2wRWT4XlGbkGJdSSg+5TLdBlvLnXUZBVmCNt5lm9u0JV0xUp2VVD3EJwlJyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0keoYFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B03C4CEF0;
	Sat, 20 Sep 2025 00:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329996;
	bh=o1SMsZdkzvH0cbMc1xDF7m+UJCXrcwarUk6PkPxqhDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E0keoYFMnlure5tXMqeTk3KO/kCr7Lc6n0LC/ujUovrbw6L1OXYqGip57EOSYJTkd
	 rEhxs38Tk8/pU/dCbbCqjBV+zRMJtfYvd5GNNqncdbNgJrSNvzNlg2q37sM94l4YnK
	 9yR1CS3pRmfgERFVl5Wh6M94JxFgpPRwrSDRUSTHL5gu7rSJiRAtxU0peFlCTt+jNn
	 djJ8GJNv8c6vu/HhQe19aDdojtCGotjtOtLX6IreM+X7rec/fYVUwKQ9ncYOiA0pW4
	 7qT9mLWtGaaqRZvaJzqY81gAD6WTmzMeyYIgTVTswCOxBqKhmHcJaPHdB+jzoobgSj
	 +M4HoolN+fQMg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 22/46] sched_ext: Factor out scx_claim_exit() from scx_disable()
Date: Fri, 19 Sep 2025 14:58:45 -1000
Message-ID: <20250920005931.2753828-23-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920005931.2753828-1-tj@kernel.org>
References: <20250920005931.2753828-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both scx_disable() and scx_vexit() use cmpxchg on sch->exit_kind to claim
exit ownership but the latter lacks some sanity checks. Factor out
scx_claim_exit() from scx_disable() and use it in both places. This will
also be used to implement sub-sched disabling.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 54f65a196d94..b608c2c04730 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4086,15 +4086,20 @@ static void scx_disable_workfn(struct kthread_work *work)
 	scx_root_disable(sch);
 }
 
-static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind)
+static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 {
 	int none = SCX_EXIT_NONE;
 
 	if (WARN_ON_ONCE(kind == SCX_EXIT_NONE || kind == SCX_EXIT_DONE))
 		kind = SCX_EXIT_ERROR;
 
-	atomic_try_cmpxchg(&sch->exit_kind, &none, kind);
-	kthread_queue_work(sch->helper, &sch->disable_work);
+	return atomic_try_cmpxchg(&sch->exit_kind, &none, kind);
+}
+
+static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind)
+{
+	if (scx_claim_exit(sch, kind))
+		kthread_queue_work(sch->helper, &sch->disable_work);
 }
 
 static void dump_newline(struct seq_buf *s)
@@ -4412,9 +4417,8 @@ static void scx_vexit(struct scx_sched *sch,
 		      const char *fmt, va_list args)
 {
 	struct scx_exit_info *ei = sch->exit_info;
-	int none = SCX_EXIT_NONE;
 
-	if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
+	if (!scx_claim_exit(sch, kind))
 		return;
 
 	ei->exit_code = exit_code;
-- 
2.51.0


