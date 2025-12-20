Return-Path: <bpf+bounces-77219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 44648CD26B3
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 05:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 688163001BED
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 04:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EE128851E;
	Sat, 20 Dec 2025 04:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NAFuJG62"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607D82D3EC7
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 04:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766203996; cv=none; b=vAW3+SgNZFwqNZ4Qsz3USVLShZalk9LONLeorMd6pOmSmoUs28nARkPY/gRViS1wRN2EfoQUj/wOZW98JqAE00alUpDyD+v2CKmmCupGL00l+QaheS9cvKp++4yW0be8YYQll0uOceK/q9uPYBKYMh3j0gQXIP6l6RnZpc5xfwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766203996; c=relaxed/simple;
	bh=4DeohZCAU7R93ieq7vAUQg/xPE7WkYLq6gYLNj/ei4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/91lFEb3EFZySUuXUnIyqlDswuzj+WE6YbT0JdzXmBozymupuGmhk3jCCLo9SqNC9Xmz+k9FueZh4sURDUPDuRlCMK7HbQ53uwV5g2FHZiVrXoVo0ZGJ+BJ6m1F2hzhAtHYS4+BLxbIVrUSrGyT0slY7zuXhtTcvzZ0/O7xkcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NAFuJG62; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766203986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bPQTxbjOsUH1fDrPgGNgOPUx/ZBOkWfSHpGi3Oz7pPA=;
	b=NAFuJG629yY6Nhfr9Us/v7fJyz37uH4uunecV/tadsZ5GP8rCD3f+908GyEqk3QU5C5PSP
	nmsFCXDBYgQit8pWulqlilS0o4+Z9izosHwV0Rxa6F+P5Abq5fgTpU+Vkrel8ZGTvyUTPy
	H2KuQ45lM144qRyi1uN24A/LTj0vQGE=
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
	Roman Gushchin <roman.gushchin@linux.dev>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH bpf-next v2 1/7] mm: declare memcg_page_state_output() in memcontrol.h
Date: Fri, 19 Dec 2025 20:12:44 -0800
Message-ID: <20251220041250.372179-2-roman.gushchin@linux.dev>
In-Reply-To: <20251220041250.372179-1-roman.gushchin@linux.dev>
References: <20251220041250.372179-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To use memcg_page_state_output() in bpf_memcontrol.c move the
declaration from v1-specific memcontrol-v1.h to memcontrol.h.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 1 +
 mm/memcontrol-v1.h         | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6a48398a1f4e..b309d13110af 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -950,6 +950,7 @@ static inline void mod_memcg_page_state(struct page *page,
 }
 
 unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx);
+unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
 unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx);
 unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 				      enum node_stat_item idx);
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 6358464bb416..a304ad418cdf 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -27,7 +27,6 @@ unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
 void drain_all_stock(struct mem_cgroup *root_memcg);
 
 unsigned long memcg_events(struct mem_cgroup *memcg, int event);
-unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
 int memory_stat_show(struct seq_file *m, void *v);
 
 void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
-- 
2.52.0


