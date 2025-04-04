Return-Path: <bpf+bounces-55279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD534A7B30E
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 02:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80FE16F127
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9E91A2860;
	Fri,  4 Apr 2025 00:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+j7hcrK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744731A0BDB;
	Fri,  4 Apr 2025 00:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725085; cv=none; b=EhXuGe8O48dMjls8n+eMky8CAVqezGP3Dhh1zUjKVXrCUwpLTZ1Bc2UANV2Do6G7KAF6Z039hCfjfjSfNyxs777wDuQv95A9Vy2xMa0Kp/b/iY29hm7euseO3541E5GzsDENMJ+K8bQAtM95p45bBK6hwRA0XcoxZncpLEdKlrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725085; c=relaxed/simple;
	bh=1t3b2g5zv1kGMrnGcqnnYLhdjuZkwcJRJS6UI/lIQ+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qYcVhfqWpKuxtYs5WjiFMWK4ozissMOuOVu8PVxzGvdcnKOqfVDgg0tvBfape2BTUyRR8SO5sWVtinH9Vd8BNmMmR3mXjsulp1vN/Ul44lviOoBPs7uYlYYqNqjVvIhGL8yV9vobJcQYk4pz0WL4xT5DmyVB6cXZWqLO9hRjKxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+j7hcrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62B6C4CEE3;
	Fri,  4 Apr 2025 00:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725084;
	bh=1t3b2g5zv1kGMrnGcqnnYLhdjuZkwcJRJS6UI/lIQ+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+j7hcrKxB/0WB5pos2p0hPAszciJJyrd2sDcw276hcK2i6ITvzYOZ5ZmnD6uVM/2
	 2p3SU4qDGT6tt1iNMv2KnHatGscNWfLgRG7ZL9/CNTl8UnTsK69zSrsPKhhkRSSUMY
	 vqq1LWgUFs0pqTXcE1cBBW6y5FSCnzH4GScSZ0PGTlhpiBvHzygwi8JjzMIZniG78g
	 Lbv0SG/W+JhvxIkP9flmZV/NgkOzUwSmLsz9XAE4Om0siTH9uMjsRGcMy9iQZNsuAU
	 8ZHIVskNWUAv6K5ZYrUASFWc9K8FPwU+foSOSfMcYuV2hDcMQeecf7EcCKWzQzcWPw
	 kP3TqjI/f71nw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	martin.lau@linux.dev,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 19/23] bpf: Only fails the busy counter check in bpf_cgrp_storage_get if it creates storage
Date: Thu,  3 Apr 2025 20:03:56 -0400
Message-Id: <20250404000402.2688049-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000402.2688049-1-sashal@kernel.org>
References: <20250404000402.2688049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

[ Upstream commit f4edc66e48a694b3e6d164cc71f059de542dfaec ]

The current cgrp storage has a percpu counter, bpf_cgrp_storage_busy,
to detect potential deadlock at a spin_lock that the local storage
acquires during new storage creation.

There are false positives. It turns out to be too noisy in
production. For example, a bpf prog may be doing a
bpf_cgrp_storage_get on map_a. An IRQ comes in and triggers
another bpf_cgrp_storage_get on a different map_b. It will then
trigger the false positive deadlock check in the percpu counter.
On top of that, both are doing lookup only and no need to create
new storage, so practically it does not need to acquire
the spin_lock.

The bpf_task_storage_get already has a strategy to minimize this
false positive by only failing if the bpf_task_storage_get needs
to create a new storage and the percpu counter is busy. Creating
a new storage is the only time it must acquire the spin_lock.

This patch borrows the same idea. Unlike task storage that
has a separate variant for tracing (_recur) and non-tracing, this
patch stays with one bpf_cgrp_storage_get helper to keep it simple
for now in light of the upcoming res_spin_lock.

The variable could potentially use a better name noTbusy instead
of nobusy. This patch follows the same naming in
bpf_task_storage_get for now.

I have tested it by temporarily adding noinline to
the cgroup_storage_lookup(), traced it by fentry, and the fentry
program succeeded in calling bpf_cgrp_storage_get().

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/r/20250318182759.3676094-1-martin.lau@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/bpf_cgrp_storage.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 54ff2a85d4c02..148da8f7ff368 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -161,6 +161,7 @@ BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
 	   void *, value, u64, flags, gfp_t, gfp_flags)
 {
 	struct bpf_local_storage_data *sdata;
+	bool nobusy;
 
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
@@ -169,21 +170,21 @@ BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
 	if (!cgroup)
 		return (unsigned long)NULL;
 
-	if (!bpf_cgrp_storage_trylock())
-		return (unsigned long)NULL;
+	nobusy = bpf_cgrp_storage_trylock();
 
-	sdata = cgroup_storage_lookup(cgroup, map, true);
+	sdata = cgroup_storage_lookup(cgroup, map, nobusy);
 	if (sdata)
 		goto unlock;
 
 	/* only allocate new storage, when the cgroup is refcounted */
 	if (!percpu_ref_is_dying(&cgroup->self.refcnt) &&
-	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
+	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) && nobusy)
 		sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
 						 value, BPF_NOEXIST, false, gfp_flags);
 
 unlock:
-	bpf_cgrp_storage_unlock();
+	if (nobusy)
+		bpf_cgrp_storage_unlock();
 	return IS_ERR_OR_NULL(sdata) ? (unsigned long)NULL : (unsigned long)sdata->data;
 }
 
-- 
2.39.5


