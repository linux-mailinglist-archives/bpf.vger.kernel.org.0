Return-Path: <bpf+bounces-77100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEDFCCE33C
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 03:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DD083027E2B
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BE6272816;
	Fri, 19 Dec 2025 01:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BEoP7ESd"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEADA272805
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766109496; cv=none; b=oQvHAGR+xMx7xyLkVGHM7JwV++cgdxzt3Zd/1IIsIULzKyQpm1gNv5yIqrWU18afM1Bp4/JIuNX6ZtfmDBERXVgvjb68KpWrwS7GP2PDAwdybnnX3TdtYL/LhUVVxrbq7N9IHQgrtb3nzwB8OyV/goQ0hQH0XXiJmJTidRuYVJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766109496; c=relaxed/simple;
	bh=36WAX9kICStfdYP0ZEB4XsBd31l9PnlD+qlOP4EMu0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Me88CJF26Z2TOQgcRhz4luJGOeKS0iTlikws640GLtjm+2tFPUumZvxYcdHZ5FyNidgLMLyH+nJ61gerYqIFo0KdmoyOVmyaoyXVxOXXSnai21QsgOHnoGQVMupWjoHt6NMCzz4mkMG7/OHomWYFQUKOo2T+jgljt8EuvAZk/Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BEoP7ESd; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766109492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZxZtYJx1dwxpCMcKq8wqCyQtoClSuF/V4BGHii44wWo=;
	b=BEoP7ESdiETV53sORIkPZJVBHEIwFuS/bpau8YXo1EvZYX6rGF9DuhyiI6GxHGnBDZaeHw
	yRpXvo1Pl/R2nXI/bUT7XylqCrB6zVHds+oXksrWBJkx5djvWm59vH4fZFH7bBeGDAx7Tf
	IDxT5bqFE6e6lVkbruuiWLw359I9kU0=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: JP Kobryn <inwardvessel@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH bpf-next v1 3/6] mm: introduce bpf_get_root_mem_cgroup() BPF kfunc
Date: Thu, 18 Dec 2025 17:57:47 -0800
Message-ID: <20251219015750.23732-4-roman.gushchin@linux.dev>
In-Reply-To: <20251219015750.23732-1-roman.gushchin@linux.dev>
References: <20251219015750.23732-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce a BPF kfunc to get a trusted pointer to the root memory
cgroup. It's very handy to traverse the full memcg tree, e.g.
for handling a system-wide OOM.

It's possible to obtain this pointer by traversing the memcg tree
up from any known memcg, but it's sub-optimal and makes BPF programs
more complex and less efficient.

bpf_get_root_mem_cgroup() has a KF_ACQUIRE | KF_RET_NULL semantics,
however in reality it's not necessarily to bump the corresponding
reference counter - root memory cgroup is immortal, reference counting
is skipped, see css_get(). Once set, root_mem_cgroup is always a valid
memcg pointer. It's safe to call bpf_put_mem_cgroup() for the pointer
obtained with bpf_get_root_mem_cgroup(), it's effectively a no-op.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/bpf_memcontrol.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index 8aa842b56817..6d0d73bf0dd1 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -10,6 +10,20 @@
 
 __bpf_kfunc_start_defs();
 
+/**
+ * bpf_get_root_mem_cgroup - Returns a pointer to the root memory cgroup
+ *
+ * The function has KF_ACQUIRE semantics, even though the root memory
+ * cgroup is never destroyed after being created and doesn't require
+ * reference counting. And it's perfectly safe to pass it to
+ * bpf_put_mem_cgroup()
+ */
+__bpf_kfunc struct mem_cgroup *bpf_get_root_mem_cgroup(void)
+{
+	/* css_get() is not needed */
+	return root_mem_cgroup;
+}
+
 /**
  * bpf_get_mem_cgroup - Get a reference to a memory cgroup
  * @css: pointer to the css structure
@@ -64,6 +78,7 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
+BTF_ID_FLAGS(func, bpf_get_root_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_TRUSTED_ARGS | KF_ACQUIRE | KF_RET_NULL | KF_RCU)
 BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_TRUSTED_ARGS | KF_RELEASE)
 
-- 
2.52.0


