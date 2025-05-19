Return-Path: <bpf+bounces-58471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A490EABB520
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 08:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69EEA7A8702
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 06:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041B72459C8;
	Mon, 19 May 2025 06:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="obBozUuY"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69A8245031
	for <bpf@vger.kernel.org>; Mon, 19 May 2025 06:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747636334; cv=none; b=hSmuPzbwgPOac9GUUlNpf2Hv3vQHQW2UYf/BEn/jBf6dxtMrqN1DJ9ajUP0McwqxyqaVxekRsZ2n9Q5MbwuhC6Q+zY/r/Iy2HnhDZ4StjwEPgjMeUaHycB4xywFcRb+DLHHoVP4njFEILzLMOMp78dw+g9ikrNbSe87XW7uBRSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747636334; c=relaxed/simple;
	bh=b9joiAfq/KXTWJWvhP6k0Abjv8MXdGpexHQg8ErjGuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bwl+V62eQgBPag750qLEvdoWoOesdOXeOw5e66TwpwdogwEaCn4n/o9t2zrwlXyXVQDjd4kB1TE7OzDKaDev6WC7Oh76R9U23IJ9buIFZcytvlZjYyoW0n/qsrrEh6b03VYYMdydcdnyIoWkIBzgvqgKGff/tRir3VyHeEaiw+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=obBozUuY; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747636317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qhwfp4EBzg3RNOWbJvbUL8OkMdkVj45Lqv1H1O9YUck=;
	b=obBozUuYgXdLhdigMtpTnfWbC/7w0awskie0wRvHeJkMInnYpWmeuUGZ+VZdXe8Negeb1V
	zcVVgf+s6Pa/xxAC+r2hLVPQfy2IAHTzZQ6ecYLgHQC4KLxeqLPDfXiX4iMdzgnn1gxDyG
	LuBYRBi7IhifT+NU73qxjSkfP3Clsh4=
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
Subject: [PATCH v4 0/5] memcg: nmi-safe kmem charging
Date: Sun, 18 May 2025 23:31:37 -0700
Message-ID: <20250519063142.111219-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Users can attached their BPF programs at arbitrary execution points in
the kernel and such BPF programs may run in nmi context. In addition,
these programs can trigger memcg charged kernel allocations in the nmi
context. However memcg charging infra for kernel memory is not equipped
to handle nmi context for all architectures.

This series removes the hurdles to enable kmem charging in the nmi
context for most of the archs. For archs without CONFIG_HAVE_NMI, this
series is a noop. For archs with NMI support and have
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS, the previous work to make memcg
stats re-entrant is sufficient for allowing kmem charging in nmi
context. For archs with NMI support but without
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS and with
ARCH_HAVE_NMI_SAFE_CMPXCHG, this series added infra to support kmem
charging in nmi context. Lastly those archs with NMI support but without
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS and ARCH_HAVE_NMI_SAFE_CMPXCHG,
kmem charging in nmi context is not supported at all.

Mostly used archs have support for CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
and this series should be almost a noop (other than making
memcg_rstat_updated nmi safe) for such archs. 

Changes since v3:
- Use internal config symbols for nmi unsafe configs as suggested by
  Johannes.

Changes since v2:
- Rearrange in_nmi() check as suggested by Vlastimil
- Fix commit messag of patch 5 as suggested by Vlastimil

Changes since v1:
- The main change was to explicitly differentiate between archs which
  have sane NMI support from others and make the series almost a noop
  for such archs. (Suggested by Vlastimil)
- This version very explicitly describes where kmem charging in nmi
  context is supported and where it is not.

Shakeel Butt (5):
  memcg: disable kmem charging in nmi for unsupported arch
  memcg: nmi safe memcg stats for specific archs
  memcg: add nmi-safe update for MEMCG_KMEM
  memcg: nmi-safe slab stats updates
  memcg: make memcg_rstat_updated nmi safe

 include/linux/memcontrol.h |  21 ++++++
 mm/memcontrol.c            | 136 +++++++++++++++++++++++++++++++++----
 2 files changed, 145 insertions(+), 12 deletions(-)

-- 
2.47.1


