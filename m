Return-Path: <bpf+bounces-69811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9133CBA3284
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 11:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F7E2A4F16
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 09:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86F929D28B;
	Fri, 26 Sep 2025 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9lz6dGT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E5429BD95
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879239; cv=none; b=M4HNRvofeI0PhyQTA3UdLOCioWWw8Rq9b6zRWxAKG6b27/R/BI8C9q2QxG05Tzmo5uj6TK+cOfCwrMJJKS1IW+cncorts0OWAUctip4RLpbi5UbsH/UuAl7y+0corDBNIf7O3E5uqefMWTvVbVBpjECPS8NhA12MRolCLpw85B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879239; c=relaxed/simple;
	bh=jv5bYfnBcUxQHcyaZsWiSs8RZm9pACyHst6S9viu/ZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WGomXJzK+QwLPNqz6vA8d7Ng+7Uy0TKuseuHy63yymtTlXo2wUezcz391fuxnzesVZ9Gy2Buys7dNAGYEejAn3jT8N2dLhRdQIDNsGtn6L7htiBuSmzLifAuFb8sOYeB0AwZaEZ8XjDSGIhpDYpe+Qwvwh3gVMTlZVQzp50vWGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9lz6dGT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2570bf6058aso28205395ad.0
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 02:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758879237; x=1759484037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OK9v3uuIIJ3uiffBiQKb1x/mkncrjAvi7aiw8pI8xco=;
        b=E9lz6dGTyBO1bFoPDfXJMFi+g8WT2dhhR3QkfH/U5YXdSJg7+Rrob1MmUpfjvzES28
         IMiWAHRfHcdTgeR0ZMA+OmuSIzzRfDsWLR6ei5cibmmYHWIfFeYeRT84Hf8CEVZorpq1
         /Lm/Rmqs8I3Bb/9d1EnruG+PKI6iuyEzR7A63dDF6uC44CZioyEcFopx5QaA5OMnL+Dm
         45VXKzq+C5puT74jNHqnml+DKPA93kcfUs4jaG279oU4k0TwFzZkquqCOoFqy/XtAVO5
         Psr2we8Y020hD5EmOu6s3WWKp3ZPvehZA4O9whlsSQ27h2xNL4PQk06F3V9CApLfVLAR
         7ePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879237; x=1759484037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OK9v3uuIIJ3uiffBiQKb1x/mkncrjAvi7aiw8pI8xco=;
        b=Efa/nqdN8rEGh5qkoBIcHFX+ISwPIUWsluBT86S+pj17uZnxm+vw+ufCP6Gr1iavoJ
         7cd+5PBTqW+G3EjtlwZR2rdOAp+o5MdK/wKWoJTuLftrUP3Dg9qNkiANlsQGkLb59fY1
         +T+K9+M3L/uMO0+iXCmj/UBoa61Xms3yeOwt1gPaKchLUR2mm/+hpce7/FoJOGzYV/2N
         OScq52hv79qPGRW3bOHGj76wmYGb9+9CIcw3n9cPd/HPU8ki8RxRqySSFna7ViIyIo7C
         aKOGXYNtKwGoZ027wonMj8lYbdGLco1L89odFMVRP3Yo9pRR6LKDv6D9kQZMutLT7YWL
         MS/w==
X-Gm-Message-State: AOJu0YyHe6uAYJtB5JzHOgphD49BFockJFR1vTjme4+mtGm/AC9E6Vz1
	TpSA/VbAti9cbR62NQc9MMY+ypOUxIrAca859XH+RD4A6rBpQwPZ/5tB
X-Gm-Gg: ASbGncuhAVPwdqn8Q1gOE2i5LGHhAzOxt5k+7LxxN6TqSPmYAL2c0WBd8p59SXlBWsC
	T2/GASU3W2vDLh5uMjnLUakT/yRBrcxbrtoQdVmNuxxR2R1UHJDde+N/VucFeyW9kPKaZdcDm/+
	zMUkf8FFR0QeqopvQjrU8I3WQDR6qgFHE9hbQWcCD/vapoPhLH9wseHOGN2nUjI5Dj0hB2af21O
	O8Op/IATcoQqk9dmDtNMOGTarpEdeyEnxmp/m1WV6fN/urzmqaLJb8aue5/c8HkreWP8dcQ2HqQ
	eqKzrB1ZNvLP9+udXaMeacwXiX0Jns3c7HIFabm8jQ+pWZum96CUINNWYPWIo7rueZmn3PyCkXT
	z56mT1EXxcWMRY8bC6DAMREfukP+oXC4WZY02nrdqICO8J/OA2egf8iKnPxusHriEpXrxOHacMx
	1xe/9/7+b26MSK
X-Google-Smtp-Source: AGHT+IGH+qGMJqKC5ApYpUNbCLP9GsNWqMlAh0AwrcIMTddhDg+v0RJ9sK1UGTjAznokTOB5+2I6DQ==
X-Received: by 2002:a17:902:e5c6:b0:27b:472e:3a22 with SMTP id d9443c01a7336-27ed4a5eb18mr72968975ad.56.1758879236424;
        Fri, 26 Sep 2025 02:33:56 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1c21:566:e1d1:c082:790c:7be6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cda43sm49247475ad.25.2025.09.26.02.33.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Sep 2025 02:33:55 -0700 (PDT)
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
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 mm-new 00/12] mm, bpf: BPF based THP order selection
Date: Fri, 26 Sep 2025 17:33:31 +0800
Message-Id: <20250926093343.1000-1-laoar.shao@gmail.com>
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
 * thp_order_fn_t: Get the suggested THP order from a BPF program for allocation
 * @vma: vm_area_struct associated with the THP allocation
 * @type: TVA type for current @vma
 * @orders: Bitmask of available THP orders for this allocation
 *
 * Return: The suggested THP order for allocation from the BPF program. Must be
 *         a valid, available order.
 */
typedef int thp_order_fn_t(struct vm_area_struct *vma,
			   enum tva_type type,
			   unsigned long orders);

Only a single BPF program can be attached at any given time, though it can
be dynamically updated to adjust the policy. The implementation supports
anonymous THP, shmem THP, and mTHP, with future extensions planned for
file-backed THP.

This functionality is only active when system-wide THP is configured to
madvise or always mode. It remains disabled in never mode. Additionally,
if THP is explicitly disabled for a specific task via prctl(), this BPF
functionality will also be unavailable for that task

Rationale Behind the Non-Cgroup Design
--------------------------------------

cgroups are designed as nested hierarchies for partitioning resources. They
are a poor fit for enforcing arbitrary, non-hierarchical policies.

The THP policy is a quintessential example of such an arbitrary
setting. Even within a single cgroup, it is often necessary to enable
THP for performance-critical tasks while disabling it for others to
avoid latency spikes. Implementing this policy through a cgroup
interface that propagates hierarchically would eliminate the crucial
ability to configure it on a per-task basis.

While the bpf-thp mechanism has a global scope, this does not limit
its application to a single system-wide policy. In contrast to a
hierarchical cgroup-based setting, bpf-thp offers the flexibility to
set policies per-task, per-cgroup, or globally.

Fundamentally, it is a more powerful variant of prctl(), not a variant of
cgroup interface file.

WARNING
-------

- This feature requires CONFIG_BPF_GET_THP_ORDER (marked EXPERIMENTAL) to
  be enabled.
- The interface may change
- Behavior may differ in future kernel versions
- We might remove it in the future

Selftests
=========

BPF CI 
------

Patch #9:  Implements a basic BPF THP policy
Patch #10: Provides tests for dynamic BPF program updates and replacement.
Patch #11: Includes negative tests for invalid BPF helper usage, verifying
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

Tested By
---------

This v7 patch series has been tested by Lance. Thanks a lot!

  Tested-by: Lance Yang <lance.yang@linux.dev> (for v7)

Since the changes from v7 are minimal, I've retained the Tested-by tag
in the current version.

Future work
===========

Per-Task Defrag Policy
----------------------

In our production environment, applications handle memory allocation in two
ways: some pre-touch all memory at startup, while others allocate
dynamically.

For pre-touching applications, we prefer to allocate THP via direct reclaim
during their initial phase. For dynamic allocators, however, we prefer to
defer THP allocation to khugepaged to prevent latency spikes.

To support both strategies effectively, the defrag setting must be
configurable on a per-task basis.

File-backed THP Policy
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

Link: https://github.com/kernel-patches/bpf/pull/9869 [0] 
Link: https://wiki.openjdk.org/display/zgc/Main#Main-EnablingTransparentHugePagesOnLinux [1] 
Link: https://google.github.io/tcmalloc/tuning.html#system-level-optimizations [2]

Changes:
=======:

v7->v8:
Key Changes:
From Lorenzo:
  - Remove the @vma_type parameter and get it from @vma instead
  - Rename the config to BPF_THP_GET_ORDER_EXPERIMENTAL for highlighting
  - Code improvement around the returned order
- Fix the buiding error reported by kernel test robot in patch #1
  (Lance, Zi, Lorenzo)

v6->v7: https://lwn.net/Articles/1037490/
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

Yafang Shao (12):
  mm: thp: remove disabled task from khugepaged_mm_slot
  mm: thp: remove vm_flags parameter from khugepaged_enter_vma()
  mm: thp: remove vm_flags parameter from thp_vma_allowable_order()
  mm: thp: add support for BPF based THP order selection
  mm: thp: decouple THP allocation between swap and page fault paths
  mm: thp: enable THP allocation exclusively through khugepaged
  bpf: mark mm->owner as __safe_rcu_or_null
  bpf: mark vma->vm_mm as __safe_trusted_or_null
  selftests/bpf: add a simple BPF based THP policy
  selftests/bpf: add test case to update THP policy
  selftests/bpf: add test cases for invalid thp_adjust usage
  Documentation: add BPF-based THP policy management

 Documentation/admin-guide/mm/transhuge.rst    |  39 +++
 MAINTAINERS                                   |   3 +
 fs/proc/task_mmu.c                            |   3 +-
 include/linux/huge_mm.h                       |  42 ++-
 include/linux/khugepaged.h                    |  10 +-
 kernel/bpf/verifier.c                         |   8 +
 kernel/sys.c                                  |   7 +-
 mm/Kconfig                                    |  12 +
 mm/Makefile                                   |   1 +
 mm/huge_memory.c                              |   7 +-
 mm/huge_memory_bpf.c                          | 204 +++++++++++++
 mm/khugepaged.c                               |  66 ++--
 mm/madvise.c                                  |   7 +
 mm/memory.c                                   |  22 +-
 mm/shmem.c                                    |   2 +-
 mm/vma.c                                      |   6 +-
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/thp_adjust.c     | 288 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/lsm.c       |   8 +-
 .../selftests/bpf/progs/test_thp_adjust.c     |  55 ++++
 .../bpf/progs/test_thp_adjust_sleepable.c     |  22 ++
 .../bpf/progs/test_thp_adjust_trusted_owner.c |  30 ++
 .../bpf/progs/test_thp_adjust_trusted_vma.c   |  27 ++
 23 files changed, 799 insertions(+), 73 deletions(-)
 create mode 100644 mm/huge_memory_bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_sleepable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_owner.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_vma.c

-- 
2.47.3


