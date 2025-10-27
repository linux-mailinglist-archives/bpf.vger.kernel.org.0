Return-Path: <bpf+bounces-72390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AE3C11FB1
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 00:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8704C427D9A
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 23:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7762E32E14D;
	Mon, 27 Oct 2025 23:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DChI+nOh"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1E2330B03
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 23:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607081; cv=none; b=AjHE0oN89SUNmcXU7V1XVznsaxiSN09+8/s1PZy6JNweyDJ502T2rHP8LH2ywDsZLV9P1sCxZXNuCfqnOWt0d9FC8sq+vjUT0RGUiFuTka+eNwwi2UikRoEx/jLoyizgMdQWqXtUNF0r58CevaxlNXT4oH5xpkXa3O1ebnO7Z3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607081; c=relaxed/simple;
	bh=j8cURuTw2UB7s4I3cGS52HkEzNvtVptK0sqwh1Hfb6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhbFMnD+t5D4GiPsADTo4HpCb4UWKcl2W3iYb3m11NwzIrCbLHUJEUBD8RVl6X9EEiilXE6jRIUl/UkWqgqASWUujuZ5muZ8BFnIKd9FbxOFBMgLboMYuNyOM9WL1iWGLggnxARwjfg2weOBaBflw7eTu4FOozP/8Eh299/byII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DChI+nOh; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761607077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0vZi5Lm6HCXIvJj/q+L10BffcrsXOVY7/TA959BCzAY=;
	b=DChI+nOhg5pm0r/ehW0aA7Na275GkEkntqDZcK3b1Dwod6J7Mzy4LWhPA9pDr9SZZlW2FP
	O/X9pKzumDkjOjsl0o10KvMl3obEFu91NSz4LHU+7mRfQDrjEm7Hw1/2POKAkt7x9TQD4K
	Ybq7JocSIOeCr0DjI3Vf2lO0N+b5ny4=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 05/23] mm: declare memcg_page_state_output() in memcontrol.h
Date: Mon, 27 Oct 2025 16:17:08 -0700
Message-ID: <20251027231727.472628-6-roman.gushchin@linux.dev>
In-Reply-To: <20251027231727.472628-1-roman.gushchin@linux.dev>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
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
---
 include/linux/memcontrol.h | 1 +
 mm/memcontrol-v1.h         | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9af9ae28afe7..50d851ff3f27 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -949,6 +949,7 @@ static inline void mod_memcg_page_state(struct page *page,
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
2.51.0


