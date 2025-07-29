Return-Path: <bpf+bounces-64597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 865FBB14B05
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 11:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426E3167307
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 09:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B555226541;
	Tue, 29 Jul 2025 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er1BGMs2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F46B17A2F8
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780704; cv=none; b=auIWNab7Y2FFvAQdwLMyMqQF5fTYBIw+rWmkhG+XEhZcQZnr0g6gWHQ32M+bFBoKvU7i7uw36/HtqPqG1qcj9hjKwhr1XvXf3I/npp3FyOJdOSwQhryRES9eHSmSNkHO/MmqN/IULG8y2n+7nTv/orfhp373xWi1C1Ylu7yGpbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780704; c=relaxed/simple;
	bh=5nIuoEhk7MSob4J4JnQDG2HEXlMjUKu55RryQtlFBtY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=d1gRMxySQiYC+CEWQU4WvucD+h2o2j6JmV55irHs4jtxyIAgGZqj0K9UdqHdiPxjrugOup3aceUm5gjKz+a5jUUbKPt0g38aUsR0eSqFNCLFPBSdt/aV9ETf+wA4brb4reIud68aRGwkKyjUOz02SrgQiswG8RHFOH0FNKlyIv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Er1BGMs2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24063eac495so7413695ad.0
        for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 02:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753780702; x=1754385502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VUZOWenIjy5GkEEwkSpdq0uykANnDNd/BlY3skqN8K4=;
        b=Er1BGMs26iSNB2XrwV5F+9aYSCjpRrluwFF2ZWlCub4MjXgzGyuO9DtzyYmIPFpwhM
         t/BcSd1NAaT5CPKnjhG/YCRCW12r6f7fHeyu4RCHP1WL94SU1VjD8ZJ48jy8xWz2Lrvd
         hdqSDnyrBkFWxv7C7GI3wY4R25pU/BErreoY90zcX6EH7jgL87LT98hUFUejRAAMXPfJ
         cqH8wY+ZL+l9PF0AhvlJyYnMoC81UAZ3HSCK9E0UYT2kTj5zovnDITxi7XswczpNVjTm
         CwAFeYGtDDf5ELjC4DBS8y1MZiRIBhitli7nYZs6k09cyxCX9x98En9w6d9egcPt9Fro
         El0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780702; x=1754385502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUZOWenIjy5GkEEwkSpdq0uykANnDNd/BlY3skqN8K4=;
        b=UX1jaTcOmb1GmoEWigyzL1YI1G7IrSY/DxshkBACn2cVseTks7mBqY3FFRYiKmI5el
         fN3QbQLnvgTINbWXp6whXkmibtxqckQAtIohVWSJCxl3JO9mfydT8m5raLRqP5kCXAyF
         Lq9S9oo0yEcBkZucUJvxrMt2rpvbNO7k6hBU3ZWSW2dYZ7m1OKV17V7LBz0fcZKxfUuc
         b0p0MypZ++7wl/Y7NfFJx+iX32D9xeLNwsUD0qTGks158G98OtJCRQKkaogHaCYthRT8
         LqJRWQAr0lp6meWzjqlKHA3CN2rcDs28U2TYHObq7mdKVCCqGEQlqLm7etNcMz9M/C8k
         YDiQ==
X-Gm-Message-State: AOJu0Yy48PI6X/r0bFi0uAHmmgPX+k9WTXM8KK3z7pMN93q+xL/Gia3H
	MmxHKUIQ8+nZAT9hEskT+2bfizWi1Z7PHeKD3MzEmjyeupOJVv6+L0cm
X-Gm-Gg: ASbGnctxy5LMfUp+xfcMfgS77afzowHN9oZlQKb5Myxd3yxkT6dAuu6MpDK3Hq7zHgP
	3qSIsSHu9+4l/llA9SPk8uRQ3Ti4U+0/+1K9sbSKn1zfaqRQ7pYbkz0Im4X9EwJWaZqlAxxEPkX
	sKn06pMjuGcuCqd0hQ13oYF3tiWDHw2MOMxMvncxz9f9NwT1EqYq86MO7mFdauN2vwQa3q1p7uz
	xLAqkPi9bx/vc+Rcl/9ZxihZJR0oT6x+iuLHJbn08SGpjrXwkko0uRbo6I5CxskZloRGnifpc3y
	Dd6HJHuBxDmK5PS3RLCmpE019qW0EkAuKgnpYljBtrO29Drv8vucVLp11yw59ncT69dI0iNtoLW
	76VSRn9LBBVcXbnodHgW6speBDh2UMLoWbTQ14FoHtGbtJcA7
X-Google-Smtp-Source: AGHT+IHJP0Qz12f6zlitK4mLom0lbwKGaBLhvAfihe5cCg9wPlHM/Mw8pPhsa6MVIoqAAMdRnepRMA==
X-Received: by 2002:a17:903:1a8c:b0:234:8e78:ce8a with SMTP id d9443c01a7336-23fb31c104bmr224767505ad.48.1753780702498;
        Tue, 29 Jul 2025 02:18:22 -0700 (PDT)
Received: from localhost.localdomain ([101.82.174.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30be01sm74337015ad.39.2025.07.29.02.18.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Jul 2025 02:18:21 -0700 (PDT)
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
	andrii@kernel.org,
	ameryhung@gmail.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v4 0/4] mm, bpf: BPF based THP order selection 
Date: Tue, 29 Jul 2025 17:18:03 +0800
Message-Id: <20250729091807.84310-1-laoar.shao@gmail.com>
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

Our production servers consistently configure THP to "never" due to
historical incidents caused by its behavior. Key issues include:
- Increased Memory Consumption
  THP significantly raises overall memory usage, reducing available memory
  for workloads.

- Latency Spikes
  Random latency spikes occur due to frequent memory compaction triggered
  by THP.

- Lack of Fine-Grained Control
  THP tuning is globally configured, making it unsuitable for containerized
  environments. When multiple workloads share a host, enabling THP without
  per-workload control leads to unpredictable behavior.

Due to these issues, administrators avoid switching to madvise or always
modes—unless per-workload THP control is implemented.

To address this, we propose BPF-based THP policy for flexible adjustment.
Additionally, as David mentioned [0], this mechanism can also serve as a
policy prototyping tool (test policies via BPF before upstreaming them).

Proposed Solution
-----------------

As suggested by David [0], we introduce a new BPF interface:

/**
 * @get_suggested_order: Get the suggested highest THP order for allocation
 * @mm: mm_struct associated with the THP allocation
 * @tva_flags: TVA flags for current context
 *             %TVA_IN_PF: Set when in page fault context
 *             Other flags: Reserved for future use
 * @order: The highest order being considered for this THP allocation.
 *         %PUD_ORDER for PUD-mapped allocations
 *         %PMD_ORDER for PMD-mapped allocations
 *         %PMD_ORDER - 1 for mTHP allocations
 *
 * Rerurn: Suggested highest THP order to use for allocation. The returned
 * order will never exceed the input @order value.
 */
int (*get_suggested_order)(struct mm_struct *mm, unsigned long tva_flags, int order);

This interface:
- Supports both use cases (per-workload tuning + policy prototyping).
- Can be extended with BPF helpers (e.g., for memory pressure awareness).

This is an experimental feature. To use it, you must enable
CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION.

Warning:
- The interface may change
- Behavior may differ in future kernel versions
- We might remove it in the future

A simple test case is included in Patch #4.

Changes:
RFC v3->v4:
- Use a new interface get_suggested_order() (David)
- Mark it as experimental (David, Lorenzo)
- Code improvement in THP (Usama)
- Code improvement in BPF struct ops (Amery)

RFC v2->v3: https://lwn.net/Articles/1024545/
- Finer-graind tuning based on madvise or always mode (David, Lorenzo)
- Use BPF to write more advanced policies logic (David, Lorenzo)

RFC v1->v2: https://lwn.net/Articles/1021783/
The main changes are as follows,
- Use struct_ops instead of fmod_ret (Alexei)
- Introduce a new THP mode (Johannes)
- Introduce new helpers for BPF hook (Zi)
- Refine the commit log

RFC v1: https://lwn.net/Articles/1019290/

Yafang Shao (4):
  mm: thp: add support for BPF based THP order selection
  mm: thp: add a new kfunc bpf_mm_get_mem_cgroup()
  mm: thp: add a new kfunc bpf_mm_get_task()
  selftest/bpf: add selftest for BPF based THP order seletection

 include/linux/huge_mm.h                       |  13 +
 include/linux/khugepaged.h                    |  12 +-
 mm/Kconfig                                    |  12 +
 mm/Makefile                                   |   1 +
 mm/bpf_thp.c                                  | 255 ++++++++++++++++++
 mm/huge_memory.c                              |   9 +
 mm/khugepaged.c                               |  18 +-
 mm/memory.c                                   |  14 +-
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/thp_adjust.c     | 183 +++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     |  69 +++++
 .../bpf/progs/test_thp_adjust_failure.c       |  24 ++
 12 files changed, 605 insertions(+), 7 deletions(-)
 create mode 100644 mm/bpf_thp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_failure.c

-- 
2.43.5


