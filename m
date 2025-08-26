Return-Path: <bpf+bounces-66510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C115B3555C
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 09:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B153AECA3
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 07:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455DE2F7478;
	Tue, 26 Aug 2025 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWy6iHph"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1041B2D0629;
	Tue, 26 Aug 2025 07:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192809; cv=none; b=B7XJbS1zOIpTVeWV4Yt2EZTUsSDC4Gww1VsPX33htvrPl2SPoMU3eN+q8DqX1UwmQtpHUVrzhOB+eUwCkBh7JOByTqxlqpzXeXpLLFwW+8iK+LHa0Ihw4+zpe2/ROpGn4U3ugwmV/yelIu3Xzf/WyKsmHjTiNvIoVrXpHAwYF7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192809; c=relaxed/simple;
	bh=fSCDY3o6Up3bUD+HLjZxKCdcxMBo8o5mMIJCE8ADBV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Q/qQax+E4TYhyxD8q20FW845Jgo/BfXHmhS0URMCy+o5qVOtoFp6VpC1UUEAQcOZo/YWxi9JPddB2TL/P5RSlmBksDyKYIH9pjKbgJ4tfofO7o20VayOOj9nDXJOV9c1szsZNdm1r3huHu7Rv71/ipY/5pCMy0lNLr0UickzzrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWy6iHph; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b49d6f8f347so2244083a12.0;
        Tue, 26 Aug 2025 00:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756192807; x=1756797607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MvSNIEmsBO/S1uWXAujiQsWnGsOXId7wmCU3A+Uy2og=;
        b=jWy6iHphxZW92wYBpa1Eg4YwLDzH5bNrEfHhjog+EabkRYm12kGIo4it49v609nj7M
         wxLO+bdpIx/A9or6MgeU4HYLnKCoBxO3kRnUD5qmlif8/efc37UeJWW6mNIEbEc0kS5m
         SZlU8BUoMJyoEnvs+w1YptOWLg6Ehz9ZZNxsCjP6sDlDdjtLXYtFq3Cv7rdJ3nWxoHMD
         eFIjbcywoPp9WEP7MQ1rt4Hm/L2bAg/r+xdWjiOvMD5JuIV7s8a3PYwHqsDXFmAJj8OZ
         a0tE33Mq5lIFTsSdZVuvyWbgY/XnjjrKO6mzU52xlEV9BxvBqEBshNROcdh/zxcPz+1l
         wnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192807; x=1756797607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MvSNIEmsBO/S1uWXAujiQsWnGsOXId7wmCU3A+Uy2og=;
        b=lgcf4WEyh3C1rZRMlOy+XKxAnOlbeWIXF0dJbxE1s0r1/6cJYRBaUAzfasdY9GddYT
         FUlS4FE86xW+6BBWcDHLXwhwv/D3lSCc6a4mY9sGUhIln+aQcGz3ZHN6Xf02pJoGG+6b
         v6m1B5cjccjkc49+VuBj5V/ACo/5cdsLntmyp9yd4j27OHHtGFfwnQmv39FFk2n8fWRD
         Yrbq5DAitaYmDscGQqTpHoRmWwcJeSCS0TKWQGiy/33V19VsRFrsyRblpbFxUeJyMUwm
         SCp7DJ58QmoXld7dne7P88U5xzSg4V3hvJvqj92OsSAR10AU48P6KqZ8beIk+Z99jUcS
         GUjw==
X-Forwarded-Encrypted: i=1; AJvYcCVnths13IE4L5Pjswbtuqwwi7B46uostzWngPEt/eAyVmuJEiJv8PwevxFB9ssruv4W32S0z3uK1r4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNM3mmVKlNggpE6M80AtiJmT9cqM6izV/Ypqjlhaus0PVkJ3aK
	/I08bybeY/vNzIfL3TxNH3CRlq+1EOdQBAO5rl86dsYGCnQXMQQI0n6X
X-Gm-Gg: ASbGncsSpy0T3KPFS9JeDButITN4rtVxrckcRJh+CzXbSHl2qvG0H2y9d4MjUbKTt+O
	VB2mwJ9mfFpOqRjHFPBSwmhI104Pr4uvEwlZLzw6ftBCvlLc2pD2C9OcIWg8xHGmfzXJSbdBPpX
	S4uMOgoQIEtvV/FFzy45TyLAVQoARI9VKDqQWGbiKcaUInXh2koPN0us0WWLiBi7TgBU4mR2ZxD
	RBP+h6q3WLVid1YcfAb6vdPe8ukiNFseqWaBd/gQUToY8obwu+5KUwS4iavCJ2s5N5cuJdh8VTR
	C3HN/Q4szbZq9nLqyC7Zys/z+9RZ/PSA/gotM5spHKFxAL7yjfvB15uWh0kFf+z0ZfwY0LtuyM2
	iHzQjveskg4ir4psY/Pgj/lf31wp+aZQABMrwP36c92IU3xRUy2SnwS/haJK7TcoXtimGw6vPuR
	+LuYQ=
X-Google-Smtp-Source: AGHT+IHJJhanwvW5EbqwEOoFAkZdDHlluG/q6CqoQ9rDCm4qZgtWZOtyBmLarDVC5avUWvJXYxUL7w==
X-Received: by 2002:a05:6a20:4325:b0:243:15b9:7655 with SMTP id adf61e73a8af0-24340d2288cmr21351592637.47.1756192807103;
        Tue, 26 Aug 2025 00:20:07 -0700 (PDT)
Received: from localhost.localdomain ([101.82.213.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm9686052b3a.75.2025.08.26.00.19.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 00:20:06 -0700 (PDT)
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
	rientjes@google.com,
	corbet@lwn.net
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 mm-new 00/10] mm, bpf: BPF based THP order selection
Date: Tue, 26 Aug 2025 15:19:38 +0800
Message-Id: <20250826071948.2618-1-laoar.shao@gmail.com>
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
==========

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
=================

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


Selftests
=========

BPF selftests
-------------

Patch #5: Implements a basic BPF THP policy that restricts THP allocation
          via khugepaged to tasks within a specified memory cgroup.
Patch #6: Contains test cases validating the khugepaged fork behavior.
Patch #7: Provides tests for dynamic BPF program updates and replacement.
Patch #8: Includes negative tests for invalid BPF helper usage, verifying
          proper verification by the BPF verifier.

Currently, several dependency patches reside in mm-new but haven't been
merged into bpf-next:
  mm: add bitmap mm->flags field
  mm/huge_memory: convert "tva_flags" to "enum tva_type"
  mm: convert core mm to mm_flags_*() accessors

To enable BPF CI testing, these dependencies were manually applied to
bpf-next [1]. All selftests in this series pass successfully. The observed
CI failures are unrelated to these changes.

Performance Evaluation
----------------------

As suggested by Usama [2], performance impact was measured given the page
fault handler modifications. The standard `perf bench mem memset` benchmark
was employed to assess page fault performance.

Testing was conducted on an AMD EPYC 7W83 64-Core Processor (single NUMA
node). Due to variance between individual test runs, a script executed
10000 iterations to calculate meaningful averages and standard deviations.

The results across three configurations show negligible performance impact:
- Baseline (without this patch series)
- With patch series but no BPF program attached
- With patch series and BPF program attached

The result are as follows,

  Number of runs: 10,000
  Average throughput: 40-41 GB/sec
  Standard deviation: 7-8 GB/sec

Production verification
-----------------------

We have successfully deployed a variant of this approach across numerous
Kubernetes production servers. The implementation enables THP for specific
workloads (such as applications utilizing ZGC [3]) while disabling it for
others. This selective deployment has operated flawlessly, with no
regression reports to date.

For ZGC-based applications, our verification demonstrates that shmem THP
delivers significant improvements:
- Reduced CPU utilization
- Lower average latencies

Future work
===========

Based on our validation with production workloads, we observed mixed
results with XFS large folios (also known as File THP):

- Performance Benefits
  Some workloads demonstrated significant improvements with XFS large
  folios enabled
- Performance Regression
  Some workloads experienced degradation when using XFS large folios

These results demonstrate that File THP, similar to anonymous THP, requires
a more granular approach instead of a uniform implementation.

We will extend the BPF-based order selection mechanism to support File THP
allocation policies.

Link: https://lwn.net/ml/all/9bc57721-5287-416c-aa30-46932d605f63@redhat.com/ [0] 
Link: https://github.com/kernel-patches/bpf/pull/9561 [1]
Link: https://lwn.net/ml/all/a24d632d-4b11-4c88-9ed0-26fa12a0fce4@gmail.com/ [2]
Link: https://wiki.openjdk.org/display/zgc/Main#Main-EnablingTransparentHugePagesOnLinux [3]

Changes:
=======

RFC v5-> v6:
- Code improvement around the RCU usage (Usama)
- Add selftests for khugepaged fork (Usama)
- Add performance data for page fault (Usama)
- Remove the RFC tag

RFC v4->v5: https://lwn.net/Articles/1034265/
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

Yafang Shao (10):
  mm: thp: add support for BPF based THP order selection
  mm: thp: add a new kfunc bpf_mm_get_mem_cgroup()
  mm: thp: add a new kfunc bpf_mm_get_task()
  bpf: mark vma->vm_mm as trusted
  selftests/bpf: add a simple BPF based THP policy
  selftests/bpf: add test case for khugepaged fork
  selftests/bpf: add test case to update thp policy
  selftests/bpf: add test cases for invalid thp_adjust usage
  Documentation: add BPF-based THP adjustment documentation
  MAINTAINERS: add entry for BPF-based THP adjustment

 Documentation/admin-guide/mm/transhuge.rst    |  47 +++
 MAINTAINERS                                   |  10 +
 include/linux/huge_mm.h                       |  15 +
 include/linux/khugepaged.h                    |  12 +-
 kernel/bpf/verifier.c                         |   5 +
 mm/Kconfig                                    |  12 +
 mm/Makefile                                   |   1 +
 mm/bpf_thp.c                                  | 269 ++++++++++++++
 mm/huge_memory.c                              |  10 +
 mm/khugepaged.c                               |  26 +-
 mm/memory.c                                   |  18 +-
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/thp_adjust.c     | 343 ++++++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     | 115 ++++++
 .../bpf/progs/test_thp_adjust_trusted_vma.c   |  27 ++
 .../progs/test_thp_adjust_unreleased_memcg.c  |  24 ++
 .../progs/test_thp_adjust_unreleased_task.c   |  25 ++
 17 files changed, 955 insertions(+), 7 deletions(-)
 create mode 100644 mm/bpf_thp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_vma.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_unreleased_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_unreleased_task.c

-- 
2.47.3


