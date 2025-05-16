Return-Path: <bpf+bounces-58380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC18AB9635
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 08:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6EFA030AB
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 06:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7662226CFF;
	Fri, 16 May 2025 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wABxfM9x"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E6D221FD4
	for <bpf@vger.kernel.org>; Fri, 16 May 2025 06:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747378174; cv=none; b=T+SeJx7JPjkHWGB8/40JJJs3QlxJXmiQsbrTFVQzfor7UvS399hgkupnSFLvQVb4bXs8ZlrZjAP0NfD528L8TRP3qWuo6KoaqBbfAsHmWxl+Q9lk0C4LWcmQnZbnOAXhi0A3CRnYJWpKOthtodZBBeh+lo/NI+1A8CeOgBReo/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747378174; c=relaxed/simple;
	bh=sg+sQl+gHXroJGyjSMpwjQg6chV+GnJCGvWkX8PFwZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOCHKRXkveIs8lKpxCmnK/Z2YD8GjgnW8w46oFVbEqNzZpBbzRET61trXAVIY65xMX8v0b9qJuAyPtlIshynpPPzDNccJp4Lg34TplJYsc82HSBSq9p5htRuRGcaIWCtQ9u62RHU4htb3ZYQ/zlFsrykpEeo645nkJTIf118/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wABxfM9x; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747378169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IzHgteX+DiRHg0P96tNBM3iI8xKb/ZAbEXKlmYyzoHo=;
	b=wABxfM9xp6FgM9v7ejZlbjDnAnjdGnnbgbCx0VXaexVniB7dq1QHA/LwEkFWZ2av2p6uch
	Y7ipUI4zAY5p+Gx5upGd0zVpPwPO7iKgevbaZ/Asg1fGjb5XE2IlI2TQDykpYvV6YNXEk/
	YbXBrcuLYceHt0ut41nZtsrfUbe3YS8=
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
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 1/5] memcg: disable kmem charging in nmi for unsupported arch
Date: Thu, 15 May 2025 23:49:08 -0700
Message-ID: <20250516064912.1515065-2-shakeel.butt@linux.dev>
In-Reply-To: <20250516064912.1515065-1-shakeel.butt@linux.dev>
References: <20250516064912.1515065-1-shakeel.butt@linux.dev>
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
 include/linux/memcontrol.h |  5 +++++
 mm/memcontrol.c            | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f7848f73f41c..53920528821f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -62,6 +62,11 @@ struct mem_cgroup_reclaim_cookie {
 
 #ifdef CONFIG_MEMCG
 
+#if defined(CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS) || \
+	!defined(CONFIG_HAVE_NMI) || defined(ARCH_HAVE_NMI_SAFE_CMPXCHG)
+#define MEMCG_SUPPORTS_NMI_CHARGING
+#endif
+
 #define MEM_CGROUP_ID_SHIFT	16
 
 struct mem_cgroup_id {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e17b698f6243..dface07f69bb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2647,11 +2647,26 @@ static struct obj_cgroup *current_objcg_update(void)
 	return objcg;
 }
 
+#ifdef MEMCG_SUPPORTS_NMI_CHARGING
+static inline bool nmi_charging_allowed(void)
+{
+	return true;
+}
+#else
+static inline bool nmi_charging_allowed(void)
+{
+	return false;
+}
+#endif
+
 __always_inline struct obj_cgroup *current_obj_cgroup(void)
 {
 	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
 
+	if (in_nmi() && !nmi_charging_allowed())
+		return NULL;
+
 	if (in_task()) {
 		memcg = current->active_memcg;
 		if (unlikely(memcg))
-- 
2.47.1


