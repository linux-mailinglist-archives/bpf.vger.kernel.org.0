Return-Path: <bpf+bounces-60001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBA5AD1170
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 09:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6993AC64F
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 07:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C861E573F;
	Sun,  8 Jun 2025 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqKCJmX3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B115D1
	for <bpf@vger.kernel.org>; Sun,  8 Jun 2025 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749368147; cv=none; b=jbEmNawbw9SOq/LZlkwjO4MuEj9kmlaoOXE7fisw5qXJTCGp/MYMZ4OpKvj1sUCHAS7HaOvOqq2sONDCtXYk/+PWhZePI0SxU6ABSuv0gd7Hu0b5HABZaf6HAqH6pMVDCdiXK+JARp691TrCqVa9bpL+VVdh+CH2KWQ55wCXS+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749368147; c=relaxed/simple;
	bh=X8/bgUAX6qBUhHLLtM9Ld1oBxfsihFPF4V+kTrQMd+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZGTM7LEXvNJ5zG+/dINn0cUHUx04F4c/SwMd/wnxw89fq2WCxhW8e16UbMZr/AGXcBS/mQZkBfwncmsJRMUTp9z8X1QQYvonPJXF3iV79U0buSyAAUYjclrr8AdjqB+QfRAR7uPSI5PFMEWZvOyPLs5+2kfCPNFHSvhpvGGoYeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqKCJmX3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235ea292956so33391575ad.1
        for <bpf@vger.kernel.org>; Sun, 08 Jun 2025 00:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749368145; x=1749972945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rLJfTflDJDqHQE108qqMo51AUAVzbVzG2WCvHF03S0c=;
        b=fqKCJmX3uglSwJth/e/MoTFHPtNsVAv7UGXwUy0CQAVqkpc/gxdHXZcvD9YitMIO4X
         Lhx/Sh681sPCB9lqOG9BH4NLu94xYnHuBCpI+pWOdM46331wXY367b3jgdYesPDi87w3
         8PqBGBHHh4upp46K87ND2wNK7KWHttRkexIpOwbRNmLFOLfrejCtZhUoWR0dRq2k3VzM
         00cQjN7LI2oBiD89j48c7ZnnbXarB+siS4K7kxeMKQ7xlIhdMbQwDJqCgVPcgAvibNyc
         HJbTDWCefT1BBZOUwjBkk0x3Ag53mFEA2y35FTyfmn2Oe+if+M8i2I9Hbcr0bJGUc+r+
         ntXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749368145; x=1749972945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLJfTflDJDqHQE108qqMo51AUAVzbVzG2WCvHF03S0c=;
        b=YSg7+ewhCZ/iJQAOiCo85PKQdrhOsnMrvw0lsNXsbev6iz3J/cP0J/9bMAMUmEkm03
         xX+2zX/FFee8ZkNFjWtBTiJGvzd60DXEglb1Xt3c4Ivd3xciTc1dwcJmir4Ww58lokXB
         S4mSQ5c2n4CAVIMPEKIXV8BZXVNkGd62C+H4v+GMbXVo7F07xE2tl+ozpZjRttd4N+42
         rOUWH2Ik6jHlMwpVV4TTopV+7jwB+H5MD5Xz5Iipbn4YLsOYz8BPMdzNn0dAxWD2j0pg
         JvVHTcIXNOKlN6gvK/vz20/vihscOPyGQ0GAWytpnBjwotOzb3YGIMqqLa2fkE4Hy6Rr
         2i2Q==
X-Gm-Message-State: AOJu0Yx8WO7ypEPPAaVvRNGiuNxeA93bs5J6Y0uT+Q1FOS/jyRcuoXgj
	Te7LYCZRB0i4tYnDzZzwIZGWS6xx0oSwzupb0FzUjlqm+gwQD8B7FH9j
X-Gm-Gg: ASbGncvVNmHWqU+dt0tkOMCyvssTfTkQER0G75pAJLDDbbLUeSAlVIM1laqocShJGNc
	kqVE7XCtKeqLcaTpKiZ0qUS+WsRX2qPRevt/5fNm8f3VQLBKSMo5QUqzABB70x3STSqctk1a2aA
	UrLxIJESyh5ANaZBbeIYfiRuEeMmIeHgmUDjeCIP0ZxA6+cZUV/lQvNn5BuRmUKQm24PbDH+c/L
	rBOa5OLhR/VFgq0qJJExJ2vtyoU9BaPhdnvH8lgjzDEPLCPzv/jAewMRr4Z3ITncU9jtvsvo9U+
	dGagM4jMzdKlKjERbjSowZU/oRxxSjLWN6fpJhQu+TPmlm0w1iKrVDpOZLyyfMzYPdEQzPX1+dx
	sxLeit7KKUA==
X-Google-Smtp-Source: AGHT+IGHBATQYKD0LjZb9hMz4Bpv4lpQX9A4LQto5tC/WT/v3Z67n+A7KwsXa/6TvOACLbmVzX43dQ==
X-Received: by 2002:a17:903:3d0f:b0:235:2375:7eaa with SMTP id d9443c01a7336-23601d05c80mr124941475ad.22.1749368144566;
        Sun, 08 Jun 2025 00:35:44 -0700 (PDT)
Received: from localhost.localdomain ([39.144.124.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236035069c3sm35968135ad.234.2025.06.08.00.35.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Jun 2025 00:35:43 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v3 0/5] mm, bpf: BPF based THP adjustment
Date: Sun,  8 Jun 2025 15:35:11 +0800
Message-Id: <20250608073516.22415-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Background
----------

We have consistently configured THP to "never" on our production servers
due to past incidents caused by its behavior:

- Increased memory consumption
  THP significantly raises overall memory usage.

- Latency spikes
  Random latency spikes occur due to more frequent memory compaction
  activity triggered by THP.

- Lack of Fine-Grained Control
  THP tuning knobs are globally configured, making them unsuitable for
  containerized environments. When different workloads run on the same
  host, enabling THP globally (without per-workload control) can cause
  unpredictable behavior.

Due to these issues, system administrators remain hesitant to switch to
"madvise" or "always" modes—unless finer-grained control over THP
behavior is implemented.

New Motivation
--------------

We have now identified that certain AI workloads achieve substantial
performance gains with THP enabled. However, we’ve also verified that some
workloads see little to no benefit—or are even negatively impacted—by THP.

In our Kubernetes environment, we deploy mixed workloads on a single server
to maximize resource utilization. Our goal is to selectively enable THP for
services that benefit from it while keeping it disabled for others. This
approach allows us to incrementally enable THP for additional services and
assess how to make it more viable in production.

Proposed Solution
-----------------

To enable fine-grained control over THP behavior, we propose dynamically
adjusting THP policies using BPF. This approach allows per-workload THP
tuning, providing greater flexibility and precision.

The BPF-based THP adjustment mechanism introduces two new APIs for granular
policy control:

- THP allocator

  int (*allocator)(unsigned long vm_flags, unsigned long tva_flags);

  The BPF program returns either THP_ALLOC_CURRENT or THP_ALLOC_KHUGEPAGED,
  indicating whether THP allocation should be performed synchronously
  (current task) or asynchronously (khugepaged).

  The decision is based on the current task context, VMA flags, and TVA
  flags.

- THP reclaimer

  int (*reclaimer)(bool vma_madvised);

  The BPF program returns either RECLAIMER_CURRENT or RECLAIMER_KSWAPD,
  determining whether memory reclamation is handled by the current task or
  kswapd.

We may explore implementing fine-grained tuning for khugepaged in future
iterations.

Alternative Proposals
---------------------

- Gutierrez’s cgroup-based approach [1]
  - Proposed adding a new cgroup file to control THP policy.
  - However, as Johannes noted, cgroups are designed for hierarchical
    resource allocation, not arbitrary policy settings [2].

- Usama’s per-task THP proposal based on prctl() [3]:
  - Enabling THP per task via prctl().
  - This provides an alternative approach for per-workload THP tuning,
    though it lacks dynamic policy adjustment capabilities and thus offers
    limited flexibility.

This is currently a PoC implementation with limited test. Feedback of any
kind is welcome.

Link: https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez.asier@huawei-partners.com/ [1]
Link: https://lore.kernel.org/linux-mm/20250430175954.GD2020@cmpxchg.org/ [2]
Link: https://lore.kernel.org/linux-mm/20250519223307.3601786-1-usamaarif642@gmail.com/ [3]

RFC v2->v3:
Thanks to the valuable input from David and Lorenzo:
- Finer-graind tuning based on madvise or always mode
- Use BPF to write more advanced policies / allocation logic

RFC v1->v2: https://lwn.net/Articles/1021783/
The main changes are as follows,
- Use struct_ops instead of fmod_ret (Alexei)
- Introduce a new THP mode (Johannes)
- Introduce new helpers for BPF hook (Zi)
- Refine the commit log

RFC v1: https://lwn.net/Articles/1019290/

Yafang Shao (5):
  mm, thp: use __thp_vma_allowable_orders() in khugepaged_enter_vma()
  mm, thp: add bpf thp hook to determine thp allocator
  mm, thp: add bpf thp hook to determine thp reclaimer
  mm: thp: add bpf thp struct ops
  selftests/bpf: Add selftest for THP adjustment

 include/linux/huge_mm.h                       |   8 +
 mm/Makefile                                   |   3 +
 mm/bpf_thp.c                                  | 184 ++++++++++++++++++
 mm/huge_memory.c                              |   5 +
 mm/khugepaged.c                               |   6 +-
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/thp_adjust.c     | 158 +++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     |  38 ++++
 8 files changed, 401 insertions(+), 2 deletions(-)
 create mode 100644 mm/bpf_thp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c

-- 
2.43.5


