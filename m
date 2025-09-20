Return-Path: <bpf+bounces-69035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F131B8BB81
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 02:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBAC5A5BB5
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 00:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2331F78E6;
	Sat, 20 Sep 2025 00:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovwSs220"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7A11E47CA;
	Sat, 20 Sep 2025 00:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329975; cv=none; b=T/6GHi3fOLpfj13Gi+54AOh98PU9sQSCTsPUj3LFNlNEkt3jwLymziRsHAVV83FU0fMKUwfug5QrwcwxMJozyaG7RMbJaGDBjBBEPZPS7cS5meaztm07eYQvBnszGuhVewarsEnSPt3DMtVB1O3ymtObSK+fEJVZ/CpNvMyj0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329975; c=relaxed/simple;
	bh=uxjzFijAGUqRJoJXtzBFbfoa3JxlkIJaaNsClV+5oUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mp/g2LZAlvJx1lnspi7FZJaPEFNqJvJ1wOwe79pHRYhhpIZf6ANrzeUKgq5VOfGzgJK9+7hp5c46c/2SGmrP+Z4LdxiTYGz2Cv+wLX8pKNEEgJ2d1H9AJFiAtnNfIsBBeIHGE8qCQ8uCf83S/M09sHI6bcjgsVX8oYhfMnNq3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovwSs220; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6C9C4CEF0;
	Sat, 20 Sep 2025 00:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329975;
	bh=uxjzFijAGUqRJoJXtzBFbfoa3JxlkIJaaNsClV+5oUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovwSs220cwaf1Eysgh+7ibAfmk4j7Fr9TxxBn+uoJEFVcete2buaB9MKeJLhF3AQT
	 n7rfj7lYn24ipMJbmckDDJNyX9BpJR6jyiToz0+cWyOqfqJVptMm+kbpxbAfg/BPYO
	 8hARG2kQ6gDvxBAe9pBbQ9qx7CV7Bl7YsUJryMDwodhwjaHyWWcLrnVYyFTYV64QSk
	 EA212+shlNAUnzphpwl22+BEC6/7mBbGrJC6PRPs8/DFmfxQ4JxZY7XC2Zuyqawfax
	 qX3ePEKxqEPmSAY4CYVCsOiJB6OXFrXYzc9vBzIN0/OdAPRbjvmmsjO1Q9LczXDHCn
	 +mJGI/wjODD2w==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/46] sched_ext: Use rhashtable_lookup() instead of rhashtable_lookup_fast()
Date: Fri, 19 Sep 2025 14:58:24 -1000
Message-ID: <20250920005931.2753828-2-tj@kernel.org>
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

The find_user_dsq() function is called from contexts that are already
under RCU read lock protection. Switch from rhashtable_lookup_fast() to
rhashtable_lookup() to avoid redundant RCU locking.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f5873f8ed669..df433f6fab4b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -207,7 +207,7 @@ static struct scx_dispatch_q *find_global_dsq(struct task_struct *p)
 
 static struct scx_dispatch_q *find_user_dsq(struct scx_sched *sch, u64 dsq_id)
 {
-	return rhashtable_lookup_fast(&sch->dsq_hash, &dsq_id, dsq_hash_params);
+	return rhashtable_lookup(&sch->dsq_hash, &dsq_id, dsq_hash_params);
 }
 
 /*
-- 
2.51.0


