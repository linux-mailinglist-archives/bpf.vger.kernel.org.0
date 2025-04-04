Return-Path: <bpf+bounces-55291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C351BA7B38F
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 02:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460FB17A96C
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1941FC7C1;
	Fri,  4 Apr 2025 00:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tX4DbqK8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7993B1FBEAA;
	Fri,  4 Apr 2025 00:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725177; cv=none; b=ukYZsUJgvxU2zX2lm4Z5dHyQ7/5R9pU7GBRCbqhqzy0Sb077vdxeybw8kXiAXvhz4WZNntK+TR6+T3OHvHB54E8uE4KDwVyEQaXaIy0K9oeI4KRXDB55TnfDYukSU10W89bgTE6PbQl907JTsY0WSmoBcI7NX/yisrK8RYbsZ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725177; c=relaxed/simple;
	bh=JC5nynroQin28s78UB4uKN0QBcwJeKjUtRFXFw7kjIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U3hMzoZgnShMRjGXX0Zn4LVhQTfx09xv08zTohGSSRRKUg1eHqnwdagES7Msc5p/i4vBFYse/qD23KeydWZCl0seBEbL7MHWG/7BlHdtjbxGzO4M1VvXsw/mrs89F+fW9Nt9ooFWCjlFKrCGGmSLYF++P5ZPXFDlNEcYvSw5fAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tX4DbqK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6D5C4CEE9;
	Fri,  4 Apr 2025 00:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725177;
	bh=JC5nynroQin28s78UB4uKN0QBcwJeKjUtRFXFw7kjIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tX4DbqK89x0JuHMwbzE5RRhVVfaCl7RPA09KzZkPXMDQQ8IqNynkri4Kpm7eswOr3
	 P5b59Dq/hW8oe3OtPe+OL8lDLkD08DYQ41xSCyXsYSgB6+QjDtPbBJrwey8eshR4VQ
	 7Vuu6qsay5G2v6eNdPxg067jmp/Dxa66+938wKYQXCWFoGnRKrsMrp/eVzZFchk8ew
	 /6hRcQCEjqTh59L4UTeAv+TwTP5t8OuEuA3TXFitsObLRVgA+jMsX8wIkm8kBhpzbY
	 K5AKMptx+aZLrfwsv2xlBkhCy4L4laneXCwzdk+4mNY+YnyAgX7PdPmsUhVq/i/Qbc
	 jFziabnFk+f8A==
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
Subject: [PATCH AUTOSEL 6.12 16/20] bpf: Only fails the busy counter check in bpf_cgrp_storage_get if it creates storage
Date: Thu,  3 Apr 2025 20:05:36 -0400
Message-Id: <20250404000541.2688670-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000541.2688670-1-sashal@kernel.org>
References: <20250404000541.2688670-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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
index 6547fb7ac0dcb..129a51b1da1b1 100644
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


