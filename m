Return-Path: <bpf+bounces-58086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D91C6AB49F3
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 05:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8318C5885
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 03:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606FB1DE8AF;
	Tue, 13 May 2025 03:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fsod+VEy"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A03A1DDC18
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 03:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747106021; cv=none; b=R0+rK5XLQ5qka3v6nC91U3UWQ6rlJcH63+faBdMIPUi0SAZVVScizXqtrZXoSK1ueAn0cz1rVxbNBURqTIPEjZnoe//7gwTMqsCfUOjFP4Yp6rks+AM9otptUUc3gC7SOeUkOMEYs0/xOkLC6fpSdSoUeYcX+jslqQ4bV6X/FqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747106021; c=relaxed/simple;
	bh=VNs9FPMzhf8zazFaa800LQaMlJPP89OGHWyxvsX0gWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QM7UBrFgUgqH2wei/OzD8W760S4BZ9kztB3yebAGlnO8Kktk6n1x8U5TYfbKiKQezAt457r1+4HFqw9XhO4G1XRLuvA1zl2JYKu/c1eyWFQZsxs3O5OBgA5X8u+s652rDGAV0fYB40WgCOZ49tUktc1ZaoVYfIojCthTgNN4rhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fsod+VEy; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747106017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GXTE4pS6BF9sV5mPeyf6QZn/p+H6nbjslyn4BcRhdGI=;
	b=fsod+VEy1I0JSZeB2v3fX4N8+mvOIpWzAisX09rwYZcupI5wDatBPi9QzhMWInGbcyHpHO
	CS0cfnbsycQTdfk59F+1eFzWVlNLP7nRQsbrG0KlOt3lydbnsuHyhd+GRbi+2U0qk1Yvrc
	hQ5fF4K0jPNU/7gD+PHZYJ4z8DHXXis=
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
Subject: [RFC PATCH 0/7] memcg: make memcg stats irq safe
Date: Mon, 12 May 2025 20:13:09 -0700
Message-ID: <20250513031316.2147548-1-shakeel.butt@linux.dev>
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
irqs.

This is still an RFC as I am not satisfied with the usage of atomic_*
ops in memcg_rstat_updated(). Second I still need to run performance
benchmarks (any suggestions/recommendations would be appreciated).
Sending this out early to get feedback.

This is based on latest mm-everything branch along with the nmi-safe
memcg series [1].

Link: http://lore.kernel.org/20250509232859.657525-1-shakeel.butt@linux.dev

Shakeel Butt (7):
  memcg: memcg_rstat_updated re-entrant safe against irqs
  memcg: move preempt disable to callers of memcg_rstat_updated
  memcg: make mod_memcg_state re-entrant safe against irqs
  memcg: make count_memcg_events re-entrant safe against irqs
  memcg: make __mod_memcg_lruvec_state re-entrant safe against irqs
  memcg: objcg stock trylock without irq disabling
  memcg: no stock lock for cpu hot-unplug

 include/linux/memcontrol.h |  41 +--------
 mm/memcontrol-v1.c         |   6 +-
 mm/memcontrol.c            | 167 +++++++++++++++----------------------
 mm/swap.c                  |   8 +-
 mm/vmscan.c                |  14 ++--
 5 files changed, 85 insertions(+), 151 deletions(-)

-- 
2.47.1


