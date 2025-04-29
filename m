Return-Path: <bpf+bounces-56901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51983AA02B1
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 08:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9516482B39
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 06:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DDF274FF7;
	Tue, 29 Apr 2025 06:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pG0gvPFe"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746202749FA
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 06:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907159; cv=none; b=GfArdpukdp4SVgka/XeImQ5tEaMxJcotNE9u0vPwpMXUS127reQSRSpwVIUBvEbiSl2gema1nXsw0/g1hVA72Je8FgnlYQ7pdpTiwnq3sn3ULzBXf/PASdmsT+t5D2UTREvvYzyng+Cw6E4QpT8h6MHZx4ZxvytXZRPMTOIbLfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907159; c=relaxed/simple;
	bh=4ZARyn4Kvc4tIjl+hyyJXaOGuO29OJ0678GpGOFviKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B12h3fFrX9Hfa4f8PcnJ7yWngQRxmvRXO0a/DQBWUC6WieIs2xBTfH4S20pMWDB6rqFGayrMzWIhKPnmajdrr557oJ5aIVKEPTL4iOFOk4T7IbBj0jcBFNHy2kI7f30ql1Z0jSElqJhMfF097rQp5xL2A3ZKO+EC/OuMxF9aNsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pG0gvPFe; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745907145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1vGq4MwXGBU2BwGXIJqfgqUXOST/Ia51A5EY2pHZHj8=;
	b=pG0gvPFeZ4aI6IFrQ53IlmNlS5nCGNRbVl9idb8bgNTJu0XQHdBl+OnndRmlRzyQmXVo3l
	Qpuy+MJaig53kCsoHkQf6aKgfWvaUE66RjcoFxl3ENK0nLWRsPtYehD18FWL+zJZ98TTNI
	YNz6T4Ci6WfaL1wHcbEbE2JCfs4OOEs=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	JP Kobryn <inwardvessel@gmail.com>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [RFC PATCH 0/3] cgroup: nmi safe css_rstat_updated
Date: Mon, 28 Apr 2025 23:12:06 -0700
Message-ID: <20250429061211.1295443-1-shakeel.butt@linux.dev>
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
allocations, we need nmi safe memcg stats and for that we need nmi safe
css_rstat_updated() which adds the given cgroup state whose stats are
updated into the per-cpu per-ss update tree. This series took the aim to
make css_rstat_updated() nmi safe.

This series is based on [1].

[1] http://lore.kernel.org/20250404011050.121777-1-inwardvessel@gmail.com

Shakeel Butt (3):
  llist: add list_add_iff_not_on_list()
  cgroup: support to enable nmi-safe css_rstat_updated
  cgroup: make css_rstat_updated nmi safe

 include/linux/cgroup-defs.h |   4 ++
 include/linux/llist.h       |   3 +
 kernel/cgroup/rstat.c       | 112 ++++++++++++++++++++++++++++--------
 lib/llist.c                 |  30 ++++++++++
 4 files changed, 124 insertions(+), 25 deletions(-)

-- 
2.47.1


