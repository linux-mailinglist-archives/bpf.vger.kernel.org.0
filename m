Return-Path: <bpf+bounces-60403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13896AD6242
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 00:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D9E1BC06D3
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 22:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCD624C08D;
	Wed, 11 Jun 2025 22:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H4KFhf79"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F71424A04A;
	Wed, 11 Jun 2025 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749680170; cv=none; b=twqIyOMTwslA4ddZpi3qqNJp7Db56c8qR+BJfDD4JaZe1bjpwuQHMv25K7tBuSIeePYdZ9CPL3mnVsn73ehND1r9/XMnUqhkAQyRMTyPuEcfMxVKV9R9HirQnwsyKUk+ZWNa9+h5L4alXZ3/x/xzQ3nBFcmJK1enrHzhSSfbQs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749680170; c=relaxed/simple;
	bh=nlAgSavjtdsiPe9rsk1pY8gZUiGpNyTj6HcBVPcuhPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FbSgxPuAV3yjJZhkYRokZ1WXZ/+22x3WvRnw21XxOOSMgUUDEbI72IIHzUOSp5HXiEhN1LWzfkQ4pL/8IL9CFnmHFEAj+89RqC92cGdln2nVjzKaOgBB/PHylypwcHNYqJ9B3ykzX+ezG64J0ARlXSIrwCXQLrTRZWPKMyVN414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H4KFhf79; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749680154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lYytpibLt4/Z7wsWilf15mdzCpQBPoxPKxpntneeV0s=;
	b=H4KFhf7971HKrGdif2KwiqK92xb+/SwP2ksEGNoh4wz57QCSWT8YmWoMcT6Pt/6N0+wpB/
	Iw36uws2qtccUfqOAbMTtP7mYI/LbttTWzgnJ/IAZIH5m8LVNolgiL/F2dhWuVrnqX1DVH
	GQOum3dN6a4RzH/KhZXizuX8H62+r3M=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: JP Kobryn <inwardvessel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v2 0/4] cgroup: nmi safe css_rstat_updated
Date: Wed, 11 Jun 2025 15:15:28 -0700
Message-ID: <20250611221532.2513772-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

BPF programs can run in nmi context and may trigger memcg charged memory
allocation in such context. Recently linux added support to nmi safe
page allocation along with memcg charging of such allocations. However
the kmalloc/slab support and corresponding memcg charging is still
lacking,

To provide nmi safe support for memcg charging for kmalloc/slab
allocations, we need nmi safe memcg stats because for kernel memory
charging and stats happen together. At the moment, memcg charging and
memcg stats are nmi safe and the only thing which is not nmi safe is
adding the cgroup to the per-cpu rstat update tree. i.e.
css_rstat_updated() which this series is doing.

This series made css_rstat_updated by using per-cpu lockless lists whose
node in embedded in individual struct cgroup_subsys_state and the
per-cpu head is placed in struct cgroup_subsys. For rstat users without
cgroup_subsys, a global per-cpu lockless list head is created. The main
challenge to use lockless in this scenario was the potential multiple
inserters from the stacked context i.e. process, softirq, hardirq & nmi,
potentially using the same per-cpu lockless node of a given
cgroup_subsys_state. The normal lockless list does not protect against
such scenario.

The multiple stacked inserters using potentially same lockless node was
resolved by making one of them succeed on reset the lockless node and the
winner gets to insert the lockless node in the corresponding lockless
list. The losers can assume the lockless list insertion will eventually
succeed and continue their operation.

Changelog since v2:
- Add more clear explanation in cover letter and in the comment as
  suggested by Andrew, Michal & Tejun.
- Use this_cpu_cmpxchg() instead of try_cmpxchg() as suggested by Tejun.
- Remove the per-cpu ss locks as they are not needed anymore.

Changelog since v1:
- Based on Yosry's suggestion always use llist on the update side and
  create the update tree on flush side

[v1] https://lore.kernel.org/cgroups/20250429061211.1295443-1-shakeel.butt@linux.dev/
 


Shakeel Butt (4):
  cgroup: support to enable nmi-safe css_rstat_updated
  cgroup: make css_rstat_updated nmi safe
  cgroup: remove per-cpu per-subsystem locks
  memcg: cgroup: call css_rstat_updated irrespective of in_nmi()

 include/linux/cgroup-defs.h   |  11 +--
 include/trace/events/cgroup.h |  47 ----------
 kernel/cgroup/rstat.c         | 169 +++++++++++++---------------------
 mm/memcontrol.c               |  10 +-
 4 files changed, 74 insertions(+), 163 deletions(-)

-- 
2.47.1


