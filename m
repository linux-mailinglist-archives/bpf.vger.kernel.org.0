Return-Path: <bpf+bounces-55296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 727CDA7B3AD
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 02:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B7A3B4F47
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD652046B4;
	Fri,  4 Apr 2025 00:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5rDlg/W"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B322045BD;
	Fri,  4 Apr 2025 00:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725213; cv=none; b=qjOXxN9l6OBI9GVG+XuiBHkvtLDiykJLpDsCh/6g6w2weXTw6q4LuVLG+FRP6HTlsS4rghllo1F+V6GT7Lomzoxw8XAwpY6E2H3psFEC8uAHtT0XFetlF0a0oI7MN/6R9MM/S8vVZYFSLxoqKPxG7BMDErLtImJlDzcbWMNYMRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725213; c=relaxed/simple;
	bh=+u0+g6UvPqNLcLw5Z4Do5wUhFhP7h8XFf1TffU5uJ+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y7Ls0Mql4iWeboYovwBrS3NzDCevO1Y8AdO+Lozw5E4X3kVOXQ2p32rhQcshsjcq6zwVzYI+RlzWxtVOl9rwb8XGH2pdFYFxq4i2FCi2q1B73IpXuNUBH7OdqngHKEw3LiHmIoaUWEgjRY5a8llQeOFrambaW+V5zkI4s9i81Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5rDlg/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D187C4CEE5;
	Fri,  4 Apr 2025 00:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725213;
	bh=+u0+g6UvPqNLcLw5Z4Do5wUhFhP7h8XFf1TffU5uJ+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s5rDlg/Wk0GoBa1Pu0os1E3uPHBfgpMUCadG6fruIhFMVz2XTzF8UPrqZ7hWEROFz
	 XmPNjfXk4HYn0T6sFsk2HjLA42/4YNvxH2hVW212HSlXfWDMjZkD0h4/3ONFuwROiO
	 3sQHrqUYIlN8DamdOfZOH7qQcYDcSqLFLSqsDrfifdKoF+so+AChDCYINlOdrIEsyB
	 X7xNACRrI469bpcCNrwk5kRQj+uwcBODvptj/WZ7Y+BJV6Piq9FC7xtCuSHdCDkjzr
	 lmUTzlDaNFyWlqDmsArEfGsucbBexK7T1STIWTXVY5RR4G9dy3t1krs77rPWYKkpS3
	 zt9pC4jKzkVOw==
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
Subject: [PATCH AUTOSEL 6.6 12/16] bpf: Only fails the busy counter check in bpf_cgrp_storage_get if it creates storage
Date: Thu,  3 Apr 2025 20:06:20 -0400
Message-Id: <20250404000624.2688940-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000624.2688940-1-sashal@kernel.org>
References: <20250404000624.2688940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index ee1c7b77096e7..fbbf3b6b9f835 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -162,6 +162,7 @@ BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
 	   void *, value, u64, flags, gfp_t, gfp_flags)
 {
 	struct bpf_local_storage_data *sdata;
+	bool nobusy;
 
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
@@ -170,21 +171,21 @@ BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
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
 						 value, BPF_NOEXIST, gfp_flags);
 
 unlock:
-	bpf_cgrp_storage_unlock();
+	if (nobusy)
+		bpf_cgrp_storage_unlock();
 	return IS_ERR_OR_NULL(sdata) ? (unsigned long)NULL : (unsigned long)sdata->data;
 }
 
-- 
2.39.5


