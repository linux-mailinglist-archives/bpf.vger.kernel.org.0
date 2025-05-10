Return-Path: <bpf+bounces-57958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB32AB2037
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 01:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21094E4275
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 23:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD7B264F81;
	Fri,  9 May 2025 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NSMF+qwX"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3446221DB9
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746833366; cv=none; b=taBnRbLPlQb//3EpaEOOqCnagAoe9o+jJ0jYMuDrCEIrdT195C045QHYdNEDwtFU9CwlGlsuyyadfkfRKF38jTTv2GmWzWI/6Q9XTHnF7awEn/7U7J6bJNI/mZuXrK55hirNeUdTV4CuKx9yoCR61U0oRzjVqadKCO/1EGa7xsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746833366; c=relaxed/simple;
	bh=aWMDUqTlg8yBXVFLElcPolZriEBCBo36iTwWLs5hHcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3JNzk941aZ+ZmeuQzlaGpGFMQ7AsrflGD0A5VrvlGp8mwXScsTbOAI7wJ4riKtX5ln/z6HBDN+J4AxyBBFJjGVx7h3AMY4M4rygCvxcBTtjnAwvWtFA4LAnLtjQJyvCeNmG1UrTC4IiIidNgqJbRIW2XEHt/7orFAeTSNEz7Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NSMF+qwX; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746833352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J4VBELZKVh9c+NN05lvMDVzh5vrV8L5R0K09W43K4So=;
	b=NSMF+qwXdjyonU75kVK3drmkVY72aepNgUdyyTMjA3GlllkY3BKuGMwnb83kE6Qe/joeK6
	Ugsuoi8uALx2oFJgDiw5BrzxWNpBVn39/ZEQcdyz6wIf49PNG88TACXc0idbiVvJLoHvdC
	77k+BVstMcpgReG0AAAkvt4ExOdO+Dg=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 0/4] memcg: nmi-safe kmem charging
Date: Fri,  9 May 2025 16:28:55 -0700
Message-ID: <20250509232859.657525-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

BPF programs can trigger memcg charged kernel allocations in nmi
context. However memcg charging infra for kernel memory is not equipped
to handle nmi context. This series adds support for kernel memory
charging for nmi context.

The initial prototype tried to make memcg charging infra for kernel
memory re-entrant against irq and nmi. However upon realizing that
this_cpu_* operations are not safe on all architectures (Tejun), this
series took a different approach targeting only nmi context. Since the
number of stats that are updated in kernel memory charging path are 3,
this series added special handling of those stats in nmi context rather
than making all >100 memcg stats nmi safe.

There will be a followup series which will make kernel memory charging
reentrant for irq and will be able to do without disabling irqs.

We ran network intensive workload on this series and have not seen any
significant performance differences with and without the series.

Shakeel Butt (4):
  memcg: add infra for nmi safe memcg stats
  memcg: add nmi-safe update for MEMCG_KMEM
  memcg: nmi-safe slab stats updates
  memcg: make objcg charging nmi safe

 include/linux/memcontrol.h |  6 +++
 mm/memcontrol.c            | 87 +++++++++++++++++++++++++++++++++++---
 2 files changed, 88 insertions(+), 5 deletions(-)

-- 
2.47.1


