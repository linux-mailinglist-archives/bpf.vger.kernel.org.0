Return-Path: <bpf+bounces-58472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90EDABB526
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 08:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C295E3B7CC1
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 06:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5092459D6;
	Mon, 19 May 2025 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LOpPqdGw"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C54E24503E
	for <bpf@vger.kernel.org>; Mon, 19 May 2025 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747636342; cv=none; b=Y1ANsYKNT0r0fSKnc4tnPptVXcfbHa6sv7alrvNiDrddW9+RR2kMry6e+5p0773B1gGDr/WE3heremRG8FomBI9QORcBeQ/GGoxkIAAt9PHbOVJCFP92FeUKO1yn/0n5p9Y/cMe7q4og15f21bjls5y5Kr7/7lRomd//efv7ynU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747636342; c=relaxed/simple;
	bh=/jQh79tAgtQJLtj+eNyK2IrGdLJQsJ6BkRvDCw707AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMDJrobOFJPxdnzdWuCZbhiR0VscO91UeCz5LtrJwMqsVWl0KqMdzQAK3r1nPOgrC0GF3tdLWBGt/5EFXyZE1kIhbF/NOYlDh8mwrKSNF1Z49mJVs5HB/G1WjdHEhevXnrEhd/lpCzprPGkOYHftXDBhEOrpKd7rReZtc7aVEwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LOpPqdGw; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747636329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4FZldpF4GqktzniwkIkdN9+wQAuTiNO6J7GT2TDHJM=;
	b=LOpPqdGwVTtIP0zbqyv0THgRp28es+d9NT9WIwpXgEYTvlXV4mQIB6Qk+B83teJozFhY72
	zuoQHmP1oW5upj8znNJGuMDX4O2BCkgKW4snGWa7YoRSAUKeXZFt7ej9Qungt/YyTUGtPq
	jQE+hdenHiYUJ/jG03tvDzsaE8s385s=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v4 1/5] memcg: disable kmem charging in nmi for unsupported arch
Date: Sun, 18 May 2025 23:31:38 -0700
Message-ID: <20250519063142.111219-2-shakeel.butt@linux.dev>
In-Reply-To: <20250519063142.111219-1-shakeel.butt@linux.dev>
References: <20250519063142.111219-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The memcg accounting and stats uses this_cpu* and atomic* ops. There are
archs which define CONFIG_HAVE_NMI but does not define
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS and ARCH_HAVE_NMI_SAFE_CMPXCHG, so
memcg accounting for such archs in nmi context is not possible to
support. Let's just disable memcg accounting in nmi context for such
archs.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 init/Kconfig    | 7 +++++++
 mm/memcontrol.c | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 4cdd1049283c..a2aa49cfb8bd 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1006,6 +1006,13 @@ config MEMCG
 	help
 	  Provides control over the memory footprint of tasks in a cgroup.
 
+config MEMCG_NMI_UNSAFE
+	bool
+	depends on MEMCG
+	depends on HAVE_NMI
+	depends on !ARCH_HAS_NMI_SAFE_THIS_CPU_OPS && !ARCH_HAVE_NMI_SAFE_CMPXCHG
+	default y
+
 config MEMCG_V1
 	bool "Legacy cgroup v1 memory controller"
 	depends on MEMCG
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e17b698f6243..532e2c06ea60 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2652,6 +2652,9 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
 	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
 
+	if (IS_ENABLED(CONFIG_MEMCG_NMI_UNSAFE) && in_nmi())
+		return NULL;
+
 	if (in_task()) {
 		memcg = current->active_memcg;
 		if (unlikely(memcg))
-- 
2.47.1


