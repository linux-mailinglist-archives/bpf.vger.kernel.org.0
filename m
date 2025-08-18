Return-Path: <bpf+bounces-65847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CE6B29939
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 07:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1772049FE
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 05:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7135227056D;
	Mon, 18 Aug 2025 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSr9oASB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FD626E715
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755496527; cv=none; b=GLMukRX7sBK1nka2roLmmJRv2/+MIXN4LlfTBgZo2HFg+BI+vpmMJKdtQQ2XK5GTGVh+ejbAs4SzlafzlV+MSRPoI/BMI31SuY+PPtBQCSiQMzFm91kF84KE0cjRDBfh9t2tAISUqcbmaXFu6ZFdVnnxDw1AyA0veF0x+CLF5Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755496527; c=relaxed/simple;
	bh=smMN+FpR1+eknwBD1eRrG2VJEwX5I/120FSC4vDdc34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CUJvbmOxkmLFkckOkhRx+T1dU4CYU6oT53w1pZy7vF3/PUMLaNRCoD+jn9Pknwn5K5u+WNFRVf6Jx8FDifrdD9DxUTuM+EmcYPWOwgygfedgC6Z2i5hAqG/qcjbWYhBI7Ho2sojN8U70wlLYeoZylpU0OBdvel+6JAKTB8rqEFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSr9oASB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b47174c8e45so3451965a12.2
        for <bpf@vger.kernel.org>; Sun, 17 Aug 2025 22:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755496525; x=1756101325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zvxQ1/uTL4P7DfPMu9exFJ5IOK6MPi65nYvIyHfL3OM=;
        b=RSr9oASBAROtQS2M19H7e9jJOEmrcKuhjf9Dr/7eGG6mjjTw+HWkMqVACKKj670y9b
         UXesUvLAQVZdZTsX3gPWEIVvymESAWZiRjvK+Gv/ZOrgBDbe5IXu83h6emDWUJS4SpDr
         +39/CA+7+bnvZqpN8ANjUEen3/GUF/aBRN83J3VULOoy6kpU17FWzy2NtqpoyC0Sjqmf
         9Q54aFb+SR0aFZRKt3myn+Q70dYaxLqf3o0kxbZbnkGkX+A3dQOh2qJO8LFpdb3097Lu
         RnoviXmH764f1IpnzofGL4/84+DylgZnsxk9CVIZjCKal+9roofJaFpFMQoH4sR2abOg
         sEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755496525; x=1756101325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvxQ1/uTL4P7DfPMu9exFJ5IOK6MPi65nYvIyHfL3OM=;
        b=oeCdYomED4E6pIWapb5w6Ay/dpNZ2pgzjb8mLMDlP9UYn9JWsz0mjCuHDrt7jamzZD
         VXtebxddBwIxyKZKsqS6ScLQTlWU17oeSKiNAZ9cAUyMUBBsuk1MUgZT+kAtCtxX0a1Q
         YHVRSWOHhNnQfQ6XmzfhcCwxLOTvb6mUfN7zo0Gycs6HaSl4q/HAOd5vUWlSxBAfU//H
         /rKW+7ZIcY1d70dztuodRXbsLjsD1a3+wiSnpRD8+V5XIQL3ygKOteqYWtre/bF2LAnk
         0lKvcm4PRXXXizdB9978AHyDvwntEjhqQ7z8kf7Dn/QoC4GkSFc3NNFW/2VqwpIftxSK
         n7rQ==
X-Gm-Message-State: AOJu0YxRFRuEdbyCOptO6fOfBsyTrXlaH2fxbZdMx7VRD1kTpHmqPZuu
	DJq2mg3qQLtwQZHYlnZQ5KXO0FuiJ//iXBUCeXVCWnqRj2rJd+Z7nPPX
X-Gm-Gg: ASbGncsJ1vmxF/9lteNaatcPizccahC8vIjK26eEg9w5PZLK24XM9hMV6QoiaT6334W
	SLmbxgCQGjMkNBGZtXprZUiyAMt6/KZesoCGlY+0/NC2/HMTWjScQV9KXnCQi5n7m1wVkspEs3/
	zkguJGeus75QZbApFj62j0s8gZHYIh6JfT+9pYo/rqaff9J50ED4nRK7zTsiaIuYU4EEymSmw/o
	lbV9w+Fe/U2wnFt58P2x31yIgM8GQwRkGhrRUYnRvmzMdbn+tqR/l0MQa610EvvmfJt1XzeVATq
	MP+IQOhVtYO34A0JXDr4Wbe80GxwjM6LEumxgTonLdZuBYUnKtHWJsaVLCDkOU3zIsXHK/BJL3B
	pMYtpK+fpCDHZgOWjJw2NBZPkucwZmIqWvmKjai2Giz9SLutBZoP/BHGj
X-Google-Smtp-Source: AGHT+IHVmXW7GtPHCjFuQWBWihlY8bin+N9ybbXeSckobNgHCosgk1OBnu814SdZ2A2iY/x+v84Qxg==
X-Received: by 2002:a17:902:da2d:b0:240:bc10:804a with SMTP id d9443c01a7336-2446d8e1abfmr125857385ad.43.1755496524712;
        Sun, 17 Aug 2025 22:55:24 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323439961c9sm7003413a91.13.2025.08.17.22.55.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 17 Aug 2025 22:55:24 -0700 (PDT)
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
	ameryhung@gmail.com,
	rientjes@google.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v5 mm-new 0/5] mm, bpf: BPF based THP order selection
Date: Mon, 18 Aug 2025 13:55:05 +0800
Message-Id: <20250818055510.968-1-laoar.shao@gmail.com>
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
 * @get_suggested_order: Get the suggested THP orders for allocation
 * @mm: mm_struct associated with the THP allocation
 * @vma__nullable: vm_area_struct associated with the THP allocation (may be NULL)
 *                 When NULL, the decision should be based on @mm (i.e., when
 *                 triggered from an mm-scope hook rather than a VMA-specific
 *                 context).
 *                 Must belong to @mm (guaranteed by the caller).
 * @vma_flags: use these vm_flags instead of @vma->vm_flags (0 if @vma is NULL)
 * @tva_flags: TVA flags for current @vma (-1 if @vma is NULL)
 * @orders: Bitmask of requested THP orders for this allocation
 *          - PMD-mapped allocation if PMD_ORDER is set
 *          - mTHP allocation otherwise
 *
 * Rerurn: Bitmask of suggested THP orders for allocation. The highest
 *         suggested order will not exceed the highest requested order
 *         in @orders.
 */
 int (*get_suggested_order)(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
			    u64 vma_flags, enum tva_type tva_flags, int orders) __rcu;

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

Future work:
- Extend it to File THP

Changes:
RFC v4->v5:
- Add support for vma (David)
- Add mTHP support in khugepaged (Zi)
- Use bitmask of all allowed orders instead (Zi)
- Retrieve the page size and PMD order rather than hardcoding them (Zi)

RFC v3->v4: https://lwn.net/Articles/1031829/
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
Yafang Shao (5):
  mm: thp: add support for BPF based THP order selection
  mm: thp: add a new kfunc bpf_mm_get_mem_cgroup()
  mm: thp: add a new kfunc bpf_mm_get_task()
  bpf: mark vma->vm_mm as trusted
  selftest/bpf: add selftest for BPF based THP order seletection

 include/linux/huge_mm.h                       |  15 +
 include/linux/khugepaged.h                    |  12 +-
 kernel/bpf/verifier.c                         |   5 +
 mm/Kconfig                                    |  12 +
 mm/Makefile                                   |   1 +
 mm/bpf_thp.c                                  | 269 ++++++++++++++++++
 mm/huge_memory.c                              |  10 +
 mm/khugepaged.c                               |  26 +-
 mm/memory.c                                   |  18 +-
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/thp_adjust.c     | 224 +++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     |  76 +++++
 .../bpf/progs/test_thp_adjust_failure.c       |  25 ++
 13 files changed, 689 insertions(+), 7 deletions(-)
 create mode 100644 mm/bpf_thp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_failure.c

-- 
2.47.3


