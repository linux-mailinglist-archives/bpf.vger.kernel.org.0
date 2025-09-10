Return-Path: <bpf+bounces-68008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C64DCB51523
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 13:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C10B169F67
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 11:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B943176FA;
	Wed, 10 Sep 2025 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ORsD0vJq"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8794530E0D9
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502735; cv=none; b=Y36+gYfefNeAnxTp2ImxQgVOkghmqQPWsdLHwiNiYtKk9sz6C3SshU7JE0u6qfU0dW67+lx9x0gJj9FeBzo6JS+ywNi8KvBpPnL7dbG2PxhDyclHGuysJ79T2mlhvwsSPz2raJVIhjq9uICvxREo0j1SxklbKwwrlRFbxlluRlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502735; c=relaxed/simple;
	bh=15wiv9SDyX8RSPbCbRd2nK87PtB1rgOFQKH3KNcrXBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDEGByL1cBcgDqWiq0n7unIjW19i+a6tKuOr6Lxqszeck3j+2dEDM/00PqhP1Wshhg1a1YPxOq0VWNncUpVFSTz/yUKfYBQDptAdDzep7SFYNphB06AXKDVxxEvDCAPGnOuG1w44+kyJNXt86Njz4OS70vUPDIkZ2Xqyawo8GIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ORsD0vJq; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCU4vWiD6/NsvFLlK+FRGFrR7TyTzqVh9WZmw/WAuAeMgArx5NirOC/3eiBMI8Nifc5wNMxIOxcDPYQW@vger.kernel.org, AJvYcCVgWOgT1al73roOn0G11y/BVjP7jg1wsOSn/m3JunhFSgdgqYzFe7d2gIvjeGoC06zdQjYm1lR0AtKvPomh@vger.kernel.org, AJvYcCWYVJ9xxpd78zOLuvWvC2wkgImyqNsvRdKoWK2HJivYrS3XiIRA804LxNDeGgH5RP8In9I=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757502718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F6U12JUXh/Zo09vWXMp+Cb3EE33Oezl/ape3XxZCQqU=;
	b=ORsD0vJqR0SZy2wzM1S1d7hwdCPESLP5WWr9HOQcboT8YtD4G3cAiW6CPqE/PSjsQyKnz9
	d1NCgN1RUsf+JBXrztgFSGzY70XbKxgooMy1FmB9c4fEgRW1KzplFxSCbGjNfG1SpUrKgU
	tzXq6cb58QtCYSWjIHjZkTL2uGGu1+c=
X-Gm-Message-State: AOJu0Yw4sTpQZ31Kj8uCIB1xN1YeslblJjkxt2oPe0x2iMT6eLjFHlCz
	PQgbV2It0dhjqDMD4L4JQLfWfD9+h1EXLiD8EKKupMUSIv8ZqVrwTZ8Cu3DVK13HfaUGLVg5PxF
	eidOsQdNMSms93yqj+UlZbubwRrNzfYc=
X-Google-Smtp-Source: AGHT+IEzWZymJmEPHG0S7rR0Jqwh2/1XgGul1QNR7j8cLWI/AphVyWcpiEdEIyxAJexGkvhlT+hqG91T0HpQqfbb8F4=
X-Received: by 2002:a05:6214:2627:b0:736:ee1b:e with SMTP id
 6a1803df08f44-73931c496f2mr164321536d6.21.1757502711884; Wed, 10 Sep 2025
 04:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910024447.64788-1-laoar.shao@gmail.com>
In-Reply-To: <20250910024447.64788-1-laoar.shao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Date: Wed, 10 Sep 2025 19:11:14 +0800
X-Gmail-Original-Message-ID: <CABzRoybG8-MXdvTdfFvtdg93rrvMD_yPB-M4PPddk+67Vu3GAg@mail.gmail.com>
X-Gm-Features: AS18NWC2VzqdpT3C2v7_EKHpEjgrA3Lke5-D1zbQDAQet2rVrZt5DPhVs0E4q3k
Message-ID: <CABzRoybG8-MXdvTdfFvtdg93rrvMD_yPB-M4PPddk+67Vu3GAg@mail.gmail.com>
Subject: Re: [PATCH v7 mm-new 0/9] mm, bpf: BPF based THP order selection
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com, 
	rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Seems like we forgot to CC linux-kernel@vger.kernel.org ;p

On Wed, Sep 10, 2025 at 12:02=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Our production servers consistently configure THP to "never" due to
> historical incidents caused by its behavior. Key issues include:
> - Increased Memory Consumption
>   THP significantly raises overall memory usage, reducing available memor=
y
>   for workloads.
>
> - Latency Spikes
>   Random latency spikes occur due to frequent memory compaction triggered
>   by THP.
>
> - Lack of Fine-Grained Control
>   THP tuning is globally configured, making it unsuitable for containeriz=
ed
>   environments. When multiple workloads share a host, enabling THP withou=
t
>   per-workload control leads to unpredictable behavior.
>
> Due to these issues, administrators avoid switching to madvise or always
> modes=E2=80=94unless per-workload THP control is implemented.
>
> To address this, we propose BPF-based THP policy for flexible adjustment.
> Additionally, as David mentioned, this mechanism can also serve as a
> policy prototyping tool (test policies via BPF before upstreaming them).
>
> Proposed Solution
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This patch introduces a new BPF struct_ops called bpf_thp_ops for dynamic
> THP tuning. It includes a hook thp_get_order(), allowing BPF programs to
> influence THP order selection based on factors such as:
>
> - Workload identity
>   For example, workloads running in specific containers or cgroups.
> - Allocation context
>   Whether the allocation occurs during a page fault, khugepaged, swap or
>   other paths.
> - VMA's memory advice settings
>   MADV_HUGEPAGE or MADV_NOHUGEPAGE
> - Memory pressure
>   PSI system data or associated cgroup PSI metrics
>
> The new interface for the BPF program is as follows:
>
> /**
>  * @thp_get_order: Get the suggested THP orders from a BPF program for al=
location
>  * @vma: vm_area_struct associated with the THP allocation
>  * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is=
 set
>  *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_V=
M_NONE
>  *            if neither is set.
>  * @tva_type: TVA type for current @vma
>  * @orders: Bitmask of requested THP orders for this allocation
>  *          - PMD-mapped allocation if PMD_ORDER is set
>  *          - mTHP allocation otherwise
>  *
>  * Return: The suggested THP order from the BPF program for allocation. I=
t will
>  *         not exceed the highest requested order in @orders. Return -1 t=
o
>  *         indicate that the original requested @orders should remain unc=
hanged.
>  */
>
> int thp_get_order(struct vm_area_struct *vma,
>                   enum bpf_thp_vma_type vma_type,
>                   enum tva_type tva_type,
>                   unsigned long orders);
>
> Only a single BPF program can be attached at any given time, though it ca=
n
> be dynamically updated to adjust the policy. The implementation supports
> anonymous THP, shmem THP, and mTHP, with future extensions planned for
> file-backed THP.
>
> This functionality is only active when system-wide THP is configured to
> madvise or always mode. It remains disabled in never mode. Additionally,
> if THP is explicitly disabled for a specific task via prctl(), this BPF
> functionality will also be unavailable for that task
>
> **WARNING**
> - This feature requires CONFIG_BPF_GET_THP_ORDER (marked EXPERIMENTAL) to
>   be enabled.
> - The interface may change
> - Behavior may differ in future kernel versions
> - We might remove it in the future
>
> Selftests
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> BPF CI
> ------
>
> Patch #7: Implements a basic BPF THP policy that restricts THP allocation
>           via khugepaged to tasks within a specified memory cgroup.
> Patch #8: Provides tests for dynamic BPF program updates and replacement.
> Patch #9: Includes negative tests for invalid BPF helper usage, verifying
>           proper verification by the BPF verifier.
>
> Currently, several dependency patches reside in mm-new but haven't been
> merged into bpf-next. To enable BPF CI testing, these dependencies were
> manually applied to bpf-next. All selftests in this series pass
> successfully [0].
>
> Performance Evaluation
> ----------------------
>
> Performance impact was measured given the page fault handler modification=
s.
> The standard `perf bench mem memset` benchmark was employed to assess pag=
e
> fault performance.
>
> Testing was conducted on an AMD EPYC 7W83 64-Core Processor (single NUMA
> node). Due to variance between individual test runs, a script executed
> 10000 iterations to calculate meaningful averages.
>
> - Baseline (without this patch series)
> - With patch series but no BPF program attached
> - With patch series and BPF program attached
>
> The results across three configurations show negligible performance impac=
t:
>
>   Number of runs: 10,000
>   Average throughput: 40-41 GB/sec
>
> Production verification
> -----------------------
>
> We have successfully deployed a variant of this approach across numerous
> Kubernetes production servers. The implementation enables THP for specifi=
c
> workloads (such as applications utilizing ZGC [1]) while disabling it for
> others. This selective deployment has operated flawlessly, with no
> regression reports to date.
>
> For ZGC-based applications, our verification demonstrates that shmem THP
> delivers significant improvements:
> - Reduced CPU utilization
> - Lower average latencies
>
> We are continuously extending its support to more workloads, such as
> TCMalloc-based services. [2]
>
> Deployment Steps in our production servers are as follows,
>
> 1. Initial Setup:
> - Set THP mode to "never" (disabling THP by default).
> - Attach the BPF program and pin the BPF maps and links.
> - Pinning ensures persistence (like a kernel module), preventing
> disruption under system pressure.
> - A THP whitelist map tracks allowed cgroups (initially empty -> no THP
> allocations).
>
> 2. Enable THP Control:
> - Switch THP mode to "always" or "madvise" (BPF now governs actual alloca=
tions).
>
> 3. Dynamic Management:
> - To permit THP for a cgroup, add its ID to the whitelist map.
> - To revoke permission, remove the cgroup ID from the map.
> - The BPF program can be updated live (policy adjustments require no
> task interruption).
>
> 4. To roll back, disable THP and remove this BPF program.
>
> **WARNING**
> Be aware that the maintainers do not suggest this use case, as the BPF ho=
ok
> interface is unstable and might be removed from the upstream kernel=E2=80=
=94unless
> you have your own kernel team to maintain it ;-)
>
> Future work
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> file-backed THP policy
> ----------------------
>
> Based on our validation with production workloads, we observed mixed
> results with XFS large folios (also known as file-backed THP):
>
> - Performance Benefits
>   Some workloads demonstrated significant improvements with XFS large
>   folios enabled
> - Performance Regression
>   Some workloads experienced degradation when using XFS large folios
>
> These results demonstrate that File THP, similar to anonymous THP, requir=
es
> a more granular approach instead of a uniform implementation.
>
> We will extend the BPF-based order selection mechanism to support
> file-backed THP allocation policies.
>
> Hooking fork() with BPF for Task Configuration
> ----------------------------------------------
>
> The current method for controlling a newly fork()-ed task involves callin=
g
> prctl() (e.g., with PR_SET_THP_DISABLE) to set flags in its mm->flags. Th=
is
> requires explicit userspace modification.
>
> A more efficient alternative is to implement a new BPF hook within the
> fork() path. This hook would allow a BPF program to set the task's
> mm->flags directly after mm initialization, leveraging BPF helpers for a
> solution that is transparent to userspace. This is particularly valuable =
in
> data center environments for fleet-wide management.
>
> Link: https://github.com/kernel-patches/bpf/pull/9706 [0]
> Link: https://wiki.openjdk.org/display/zgc/Main#Main-EnablingTr... [1]
> Link: https://google.github.io/tcmalloc/tuning.html#system-level-optimiza=
tions [2]
>
> Changes:
> =3D=3D=3D=3D=3D=3D=3D:
>
> v6->v7:
> Key Changes Implemented Based on Feedback:
> From Lorenzo:
>   - Rename the hook from get_suggested_order() to bpf_hook_get_thp_order(=
).
>   - Rename bpf_thp.c to huge_memory_bpf.c
>   - Focuse the current patchset on THP order selection
>   - Add the BPF hook into thp_vma_allowable_orders()
>   - Make the hook VMA-based and remove the mm parameter
>   - Modify the BPF program to return a single order
>   - Stop passing vma_flags directly to BPF programs
>   - Mark vma->vm_mm as trusted_or_null
>   - Change the MAINTAINER file
> From Andrii:
>   - Mark mm->owner as rcu_or_null to avoid introducing new helpers
> From Barry:
>   - decouple swap from the normal page fault path
> kernel test robot:
>   - Fix a sparse warning
> Shakeel helped clarify the implementation.
>
> RFC v5-> v6: https://lwn.net/Articles/1035116/
> - Code improvement around the RCU usage (Usama)
> - Add selftests for khugepaged fork (Usama)
> - Add performance data for page fault (Usama)
> - Remove the RFC tag
>
> RFC v4->v5: https://lwn.net/Articles/1034265/
> - Add support for vma (David)
> - Add mTHP support in khugepaged (Zi)
> - Use bitmask of all allowed orders instead (Zi)
> - Retrieve the page size and PMD order rather than hardcoding them (Zi)
>
> RFC v3->v4: https://lwn.net/Articles/1031829/
> - Use a new interface get_suggested_order() (David)
> - Mark it as experimental (David, Lorenzo)
> - Code improvement in THP (Usama)
> - Code improvement in BPF struct ops (Amery)
>
> RFC v2->v3: https://lwn.net/Articles/1024545/
> - Finer-graind tuning based on madvise or always mode (David, Lorenzo)
> - Use BPF to write more advanced policies logic (David, Lorenzo)
>
> RFC v1->v2: https://lwn.net/Articles/1021783/
> The main changes are as follows,
> - Use struct_ops instead of fmod_ret (Alexei)
> - Introduce a new THP mode (Johannes)
> - Introduce new helpers for BPF hook (Zi)
> - Refine the commit log
>
> RFC v1: https://lwn.net/Articles/1019290/
>
> Yafang Shao (10):
>   mm: thp: remove disabled task from khugepaged_mm_slot
>   mm: thp: add support for BPF based THP order selection
>   mm: thp: decouple THP allocation between swap and page fault paths
>   mm: thp: enable THP allocation exclusively through khugepaged
>   bpf: mark mm->owner as __safe_rcu_or_null
>   bpf: mark vma->vm_mm as __safe_trusted_or_null
>   selftests/bpf: add a simple BPF based THP policy
>   selftests/bpf: add test case to update THP policy
>   selftests/bpf: add test cases for invalid thp_adjust usage
>   Documentation: add BPF-based THP policy management
>
>  Documentation/admin-guide/mm/transhuge.rst    |  46 +++
>  MAINTAINERS                                   |   3 +
>  include/linux/huge_mm.h                       |  29 +-
>  include/linux/khugepaged.h                    |   1 +
>  kernel/bpf/verifier.c                         |   8 +
>  kernel/sys.c                                  |   6 +
>  mm/Kconfig                                    |  12 +
>  mm/Makefile                                   |   1 +
>  mm/huge_memory.c                              |   3 +-
>  mm/huge_memory_bpf.c                          | 243 +++++++++++++++
>  mm/khugepaged.c                               |  19 +-
>  mm/memory.c                                   |  15 +-
>  tools/testing/selftests/bpf/config            |   3 +
>  .../selftests/bpf/prog_tests/thp_adjust.c     | 284 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/lsm.c       |   8 +-
>  .../selftests/bpf/progs/test_thp_adjust.c     | 114 +++++++
>  .../bpf/progs/test_thp_adjust_sleepable.c     |  22 ++
>  .../bpf/progs/test_thp_adjust_trusted_owner.c |  30 ++
>  .../bpf/progs/test_thp_adjust_trusted_vma.c   |  27 ++
>  19 files changed, 849 insertions(+), 25 deletions(-)
>  create mode 100644 mm/huge_memory_bpf.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_sle=
epable.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_tru=
sted_owner.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_tru=
sted_vma.c
>
> --
> 2.47.3
>
>

