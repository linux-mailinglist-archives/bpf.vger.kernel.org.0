Return-Path: <bpf+bounces-67972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6A9B50BB6
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD855E769B
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC902580D1;
	Wed, 10 Sep 2025 02:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncV5+nvU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909762517B9;
	Wed, 10 Sep 2025 02:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472307; cv=none; b=MMa99Oxrgy1gkEQtGL1Q/2gduBaIs4/OPDWWkKyb2XxbluT0of0lgcTCRL4eqPTtTKPam3FNS3iwNmODDd/Y8myFzo4PXOtB1AxGcRWLGsInf50X2e8rchbATLtqfJXN+iFTLpn7EmVFqUwO359DxVxlI90iaL3fVyd5unaF4Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472307; c=relaxed/simple;
	bh=7WtIa9KFVwVNuShVf+3LlNgoO4bhXrXBaqav+cjNWzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=orshDYjP7P1M5O74d/R2BqWIzmHYyUb4o+Vw7UuBOrlTaLjHKtDcz1ewy6hxBxQIsznHRg50unO/Q0g65mamEPc/JVHANW3qmZlyj+XSnjK6UQDubw1sUBLVZlT+TaJwv1JN7xNpQfQBpf9PJ+d38IJE0FxpK+WKFjQsqD2cjLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncV5+nvU; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b5488c409d1so581379a12.1;
        Tue, 09 Sep 2025 19:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472305; x=1758077105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECymoV0afChIph3b2IQOw2gRJYGDzpM8kCcLRfRhoGM=;
        b=ncV5+nvUhkoDRRH5kBE83RLl+tFvsJdBXJinaUMF4oS0orosWLkMcbTk6fDEmYEBiU
         xCCQhP3FA/hTSdKnTyGjo+agI2Xoy2hPtimNMnpuC1/IbDlFhXuXaQmOtOU8eZMhD/pd
         qGqcf1B5B6wqPECq1Et0btyLnLS0j+7XNe5pRtrQDP8ltlj2wwN48HPOiatkpYZPJah5
         pyNHfjcWY8s5fZ36yCjgxzarthQWFf78C9XSv4sWpL4i5Cc9xg1V++s8Bx/vIdng3A5d
         e4yG8Vb9n66lhUavZcJXIkJJXG53mNnd5z3lCZuFGNZaP6hgzDYZ/nECflQeFbs6kLxr
         kZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472305; x=1758077105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECymoV0afChIph3b2IQOw2gRJYGDzpM8kCcLRfRhoGM=;
        b=Ssn16z1D/1+RZyaIjKncaIQFc8ZwGHbaZUEG/YyyEiX3dpLNgaXSyCi41cITitViFA
         vh5WLpkWkWNs2E04HycDWjNU+Fu/eNqNlmfoBh36WJ1dSxy+78TiqW3WByCgr3Ec4Gu1
         neDGN9fRIHQRyJjBQ0RVbKFvQA4m8aMJBn0dvi1/QQdmmUrXqcRCCch1+zC0fqWu/jVB
         ntNUNjX8kKgqtOTw8KolsOYLZq91H90E8Dz/ONJFgfBDbzkqCKuH/HhovykUC2GGKaV7
         dHatu7AZtrHWuWdcggln4ZZw6mYUm/CEcIA6niguji9wtSbOVg9Xuv3+TVteRaXytZpr
         7U9A==
X-Forwarded-Encrypted: i=1; AJvYcCVDkY9eE5ec6rTbGaKx74LPiWNf/fq175vjM4kQ+jXhiZLx5+rXP4iySHEP+Aleutn9dVD7CIO62LM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9NsgUVCmFAH4tIjw3f9tzaF7r3+nUqjEkUs7viDilzz2NhiSS
	mNSmZ+cuVWsDL2y2eAb3/T+pkd0TdAqiO6q5BpAzNaoEi5W89hF2eRFs
X-Gm-Gg: ASbGncuBeR9Arl4nP4NWgOlvoRwTAZ1WoYlFhlnmGwuAnxgQOb1dP3Gm13gwjlfOhvK
	ImJUV4uuRV5hZgcDR/BKRq9+CovmMUoOXTHIMN77o4XqwKOo8frhV9+FNOaN1cA2I+j/qGFPySG
	reeB3o84+byr0OZQELEGPvblvwseCIUbPSXtoK9qfTbh7Oj2KbiX18/PMN+EG55+aJqWLUFd+Ag
	kN+J+eYJz6rh8Wzs7qjQPglSaIfrP1w1bKbKClCisMXz/GbYBdthJSdLCoQ95OJmzF1tP5Bk3wk
	0u2yrOnuIUywmLpRFGnYkDNQpislnum19i8XHMRpWWJ2WWkYESAKiGsFEe14QXJJ/ID/N167gnR
	OBDDXHJMVowOghswq5WgahR/IC9w0bhTGagJk2cAb7Pd5KrRZePXn4/URqNFSQSPaTgflhPEhJ/
	g4k5aIK1l7yezjYQ==
X-Google-Smtp-Source: AGHT+IGVVMHoxwQuixztdbo1+fcy9gAa8fVWkaDB65TP0G/V80AaCegKULeF4WMABeBE44UXwnfeTg==
X-Received: by 2002:a17:902:e802:b0:24b:1625:5fa5 with SMTP id d9443c01a7336-2516d33edd9mr221042545ad.11.1757472304575;
        Tue, 09 Sep 2025 19:45:04 -0700 (PDT)
Received: from localhost.localdomain ([101.82.183.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb314bcesm635831a91.12.2025.09.09.19.44.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Sep 2025 19:45:03 -0700 (PDT)
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
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 mm-new 0/9] mm, bpf: BPF based THP order selection
Date: Wed, 10 Sep 2025 10:44:37 +0800
Message-Id: <20250910024447.64788-1-laoar.shao@gmail.com>
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
Additionally, as David mentioned, this mechanism can also serve as a
policy prototyping tool (test policies via BPF before upstreaming them).

Proposed Solution
=================

This patch introduces a new BPF struct_ops called bpf_thp_ops for dynamic
THP tuning. It includes a hook thp_get_order(), allowing BPF programs to
influence THP order selection based on factors such as:

- Workload identity
  For example, workloads running in specific containers or cgroups.
- Allocation context
  Whether the allocation occurs during a page fault, khugepaged, swap or
  other paths.
- VMA's memory advice settings
  MADV_HUGEPAGE or MADV_NOHUGEPAGE
- Memory pressure
  PSI system data or associated cgroup PSI metrics

The new interface for the BPF program is as follows:

/**
 * @thp_get_order: Get the suggested THP orders from a BPF program for allocation
 * @vma: vm_area_struct associated with the THP allocation
 * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is set
 *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_VM_NONE
 *            if neither is set.
 * @tva_type: TVA type for current @vma
 * @orders: Bitmask of requested THP orders for this allocation
 *          - PMD-mapped allocation if PMD_ORDER is set
 *          - mTHP allocation otherwise
 *
 * Return: The suggested THP order from the BPF program for allocation. It will
 *         not exceed the highest requested order in @orders. Return -1 to
 *         indicate that the original requested @orders should remain unchanged.
 */

int thp_get_order(struct vm_area_struct *vma,
                  enum bpf_thp_vma_type vma_type,
                  enum tva_type tva_type,
                  unsigned long orders);

Only a single BPF program can be attached at any given time, though it can
be dynamically updated to adjust the policy. The implementation supports
anonymous THP, shmem THP, and mTHP, with future extensions planned for
file-backed THP.

This functionality is only active when system-wide THP is configured to
madvise or always mode. It remains disabled in never mode. Additionally,
if THP is explicitly disabled for a specific task via prctl(), this BPF
functionality will also be unavailable for that task

**WARNING**
- This feature requires CONFIG_BPF_GET_THP_ORDER (marked EXPERIMENTAL) to
  be enabled.
- The interface may change
- Behavior may differ in future kernel versions
- We might remove it in the future

Selftests
=========

BPF CI 
------

Patch #7: Implements a basic BPF THP policy that restricts THP allocation
          via khugepaged to tasks within a specified memory cgroup.
Patch #8: Provides tests for dynamic BPF program updates and replacement.
Patch #9: Includes negative tests for invalid BPF helper usage, verifying
          proper verification by the BPF verifier.

Currently, several dependency patches reside in mm-new but haven't been
merged into bpf-next. To enable BPF CI testing, these dependencies were
manually applied to bpf-next. All selftests in this series pass 
successfully [0].

Performance Evaluation
----------------------

Performance impact was measured given the page fault handler modifications.
The standard `perf bench mem memset` benchmark was employed to assess page
fault performance.

Testing was conducted on an AMD EPYC 7W83 64-Core Processor (single NUMA
node). Due to variance between individual test runs, a script executed
10000 iterations to calculate meaningful averages.

- Baseline (without this patch series)
- With patch series but no BPF program attached
- With patch series and BPF program attached

The results across three configurations show negligible performance impact:

  Number of runs: 10,000
  Average throughput: 40-41 GB/sec

Production verification
-----------------------

We have successfully deployed a variant of this approach across numerous
Kubernetes production servers. The implementation enables THP for specific
workloads (such as applications utilizing ZGC [1]) while disabling it for
others. This selective deployment has operated flawlessly, with no
regression reports to date.

For ZGC-based applications, our verification demonstrates that shmem THP
delivers significant improvements:
- Reduced CPU utilization
- Lower average latencies

We are continuously extending its support to more workloads, such as
TCMalloc-based services. [2]

Deployment Steps in our production servers are as follows,

1. Initial Setup:
- Set THP mode to "never" (disabling THP by default).
- Attach the BPF program and pin the BPF maps and links.
- Pinning ensures persistence (like a kernel module), preventing
disruption under system pressure.
- A THP whitelist map tracks allowed cgroups (initially empty -> no THP
allocations).

2. Enable THP Control:
- Switch THP mode to "always" or "madvise" (BPF now governs actual allocations).

3. Dynamic Management:
- To permit THP for a cgroup, add its ID to the whitelist map.
- To revoke permission, remove the cgroup ID from the map.
- The BPF program can be updated live (policy adjustments require no
task interruption).

4. To roll back, disable THP and remove this BPF program. 

**WARNING**
Be aware that the maintainers do not suggest this use case, as the BPF hook
interface is unstable and might be removed from the upstream kernel—unless
you have your own kernel team to maintain it ;-)

Future work
===========

file-backed THP policy
----------------------

Based on our validation with production workloads, we observed mixed
results with XFS large folios (also known as file-backed THP):

- Performance Benefits
  Some workloads demonstrated significant improvements with XFS large
  folios enabled
- Performance Regression
  Some workloads experienced degradation when using XFS large folios

These results demonstrate that File THP, similar to anonymous THP, requires
a more granular approach instead of a uniform implementation.

We will extend the BPF-based order selection mechanism to support
file-backed THP allocation policies.

Hooking fork() with BPF for Task Configuration
----------------------------------------------

The current method for controlling a newly fork()-ed task involves calling
prctl() (e.g., with PR_SET_THP_DISABLE) to set flags in its mm->flags. This
requires explicit userspace modification.

A more efficient alternative is to implement a new BPF hook within the
fork() path. This hook would allow a BPF program to set the task's
mm->flags directly after mm initialization, leveraging BPF helpers for a
solution that is transparent to userspace. This is particularly valuable in
data center environments for fleet-wide management. 

Link: https://github.com/kernel-patches/bpf/pull/9706 [0] 
Link: https://wiki.openjdk.org/display/zgc/Main#Main-EnablingTr... [1]
Link: https://google.github.io/tcmalloc/tuning.html#system-level-optimizations [2]

Changes:
=======:

v6->v7:
Key Changes Implemented Based on Feedback:
From Lorenzo:
  - Rename the hook from get_suggested_order() to bpf_hook_get_thp_order(). 
  - Rename bpf_thp.c to huge_memory_bpf.c
  - Focuse the current patchset on THP order selection
  - Add the BPF hook into thp_vma_allowable_orders()
  - Make the hook VMA-based and remove the mm parameter
  - Modify the BPF program to return a single order
  - Stop passing vma_flags directly to BPF programs
  - Mark vma->vm_mm as trusted_or_null
  - Change the MAINTAINER file
From Andrii:
  - Mark mm->owner as rcu_or_null to avoid introducing new helpers
From Barry:
  - decouple swap from the normal page fault path
kernel test robot:
  - Fix a sparse warning
Shakeel helped clarify the implementation.

RFC v5-> v6: https://lwn.net/Articles/1035116/
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
  mm: thp: remove disabled task from khugepaged_mm_slot
  mm: thp: add support for BPF based THP order selection
  mm: thp: decouple THP allocation between swap and page fault paths
  mm: thp: enable THP allocation exclusively through khugepaged
  bpf: mark mm->owner as __safe_rcu_or_null
  bpf: mark vma->vm_mm as __safe_trusted_or_null
  selftests/bpf: add a simple BPF based THP policy
  selftests/bpf: add test case to update THP policy
  selftests/bpf: add test cases for invalid thp_adjust usage
  Documentation: add BPF-based THP policy management

 Documentation/admin-guide/mm/transhuge.rst    |  46 +++
 MAINTAINERS                                   |   3 +
 include/linux/huge_mm.h                       |  29 +-
 include/linux/khugepaged.h                    |   1 +
 kernel/bpf/verifier.c                         |   8 +
 kernel/sys.c                                  |   6 +
 mm/Kconfig                                    |  12 +
 mm/Makefile                                   |   1 +
 mm/huge_memory.c                              |   3 +-
 mm/huge_memory_bpf.c                          | 243 +++++++++++++++
 mm/khugepaged.c                               |  19 +-
 mm/memory.c                                   |  15 +-
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/thp_adjust.c     | 284 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/lsm.c       |   8 +-
 .../selftests/bpf/progs/test_thp_adjust.c     | 114 +++++++
 .../bpf/progs/test_thp_adjust_sleepable.c     |  22 ++
 .../bpf/progs/test_thp_adjust_trusted_owner.c |  30 ++
 .../bpf/progs/test_thp_adjust_trusted_vma.c   |  27 ++
 19 files changed, 849 insertions(+), 25 deletions(-)
 create mode 100644 mm/huge_memory_bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_sleepable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_owner.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_vma.c

-- 
2.47.3


