Return-Path: <bpf+bounces-58167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1A2AB61FE
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 07:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A35487A9417
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 05:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD91F1F5617;
	Wed, 14 May 2025 05:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hPnhbFlp"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EEF1F4727
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 05:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199321; cv=none; b=lrUkTquaxB60jMl6RMxBf2g5o6qXfkq0ihhbe3aGV8lJZk2kZLVKah9Z45tbnwB4EQ0xJwhB5sMZ1QN8+coYuWOSvqPPdC8HUTvojF3EJNeVQAlaAKaYkU70g1lt8lvybKljv2umwjacNwPeLB6TWaPwUsinpE+yqrHrZBFkEAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199321; c=relaxed/simple;
	bh=T09G6u74ugfY+Qw4NtR8Czo3LBeM2esFQ7fqbk+jJkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ob5uEL7XuT+p4B8F6kmfTbORvbTWYvghGuzITnFzcSa18qwAziUZMT4a3SYHUbEsmcW1G1b/0Q7d08Gp07lhIqKPk1Non8rFjIPOiG8ia1IvDpmLRscW9OAR3eMAfhV7wapU9tMR40UTr/yEmtwRpDakdQ4Zz51RCxeAYfpw7Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hPnhbFlp; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747199307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P9kdViurlj538Q6MuE1F4r212ss/hlvHwNoP1Mi6ISE=;
	b=hPnhbFlpXfCtCge6s+0OD0iwfyMIZrFNgO8gH54/OZMctpmOXROIBLcOPXJvVwK1OVg503
	jn1id7tQvOPJB50jqt9pa+7zTnhz0iY2yLAZ/Pa6TNv6R6f3znr8kro2EmZZxAQpzckN8C
	Jl3f4o1zRwJAuqTuXnJ4grkMGY3a8/E=
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
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 0/7] memcg: make memcg stats irq safe
Date: Tue, 13 May 2025 22:08:06 -0700
Message-ID: <20250514050813.2526843-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series converts memcg stats to be irq safe i.e. memcg stats can be
updated in any context (task, softirq or hardirq) without disabling the
irqs. This is still not nmi-safe on all architectures but after this
series converting memcg charging and stats nmi-safe will be easier.


Changes since RFC[1]:
--------------------
1. Rebased on next-20250513 (mm tree has some conflicts with cgroup
   tree).
2. Does not depend of nmi-safe memcg series [2].
3. Made memcg_rstat_updated re-entrant using this_cpu_* ops as suggested
   by Vlastimil.
4. Fixes some spelling mistakes as suggested by Vlastimil.
5. Rearranged the 6th and 7th patch as suggested by Vlastimil.

Link: http://lore.kernel.org/20250513031316.2147548-1-shakeel.butt@linux.dev [1]
Link: http://lore.kernel.org/20250509232859.657525-1-shakeel.butt@linux.dev [2]

Shakeel Butt (7):
  memcg: memcg_rstat_updated re-entrant safe against irqs
  memcg: move preempt disable to callers of memcg_rstat_updated
  memcg: make mod_memcg_state re-entrant safe against irqs
  memcg: make count_memcg_events re-entrant safe against irqs
  memcg: make __mod_memcg_lruvec_state re-entrant safe against irqs
  memcg: no stock lock for cpu hot-unplug
  memcg: objcg stock trylock without irq disabling

 include/linux/memcontrol.h |  41 +--------
 mm/memcontrol-v1.c         |   6 +-
 mm/memcontrol.c            | 170 +++++++++++++++----------------------
 mm/swap.c                  |   8 +-
 mm/vmscan.c                |  14 +--
 5 files changed, 86 insertions(+), 153 deletions(-)

-- 
2.47.1


