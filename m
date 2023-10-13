Return-Path: <bpf+bounces-12173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0BA7C8E95
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04B4282F1B
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 20:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E5C21A15;
	Fri, 13 Oct 2023 20:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YRPh6URS"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AC51170C
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 20:54:35 +0000 (UTC)
X-Greylist: delayed 383 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Oct 2023 13:54:33 PDT
Received: from out-192.mta1.migadu.com (out-192.mta1.migadu.com [95.215.58.192])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13752BB
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 13:54:33 -0700 (PDT)
Message-ID: <17453ff8-895b-4684-9c7d-2c64d82cf9e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697230088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YG8ziJ9ZCgn8I1aJK1baq5x64CsUc9oB54/5cYG2ewE=;
	b=YRPh6URSbIRUnRRNYDpzXmR/kVUk8+mKFMoTM/6z44AKWoXHMWN22JDbYU9T4YQPL8mxBX
	MH7srOF27hxclrgu20XkssIDYhNJ1w9A9TnzFI1ntjM5KsFaCjhL/EJ4oEtI03YuoBCTT0
	PGhDQRRobJ6XOcmJxizfI+p8MVEcaXA=
Date: Fri, 13 Oct 2023 16:48:02 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 bpf-next 0/5] Open-coded task_vma iter
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20231013204426.1074286-1-davemarchevsky@fb.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <20231013204426.1074286-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/13/23 4:44 PM, Dave Marchevsky wrote:
> At Meta we have a profiling daemon which periodically collects
> information on many hosts. This collection usually involves grabbing
> stacks (user and kernel) using perf_event BPF progs and later symbolicating
> them. For user stacks we try to use BPF_F_USER_BUILD_ID and rely on
> remote symbolication, but BPF_F_USER_BUILD_ID doesn't always succeed. In
> those cases we must fall back to digging around in /proc/PID/maps to map
> virtual address to (binary, offset). The /proc/PID/maps digging does not
> occur synchronously with stack collection, so the process might already
> be gone, in which case it won't have /proc/PID/maps and we will fail to
> symbolicate.
> 
> This 'exited process problem' doesn't occur very often as
> most of the prod services we care to profile are long-lived daemons, but
> there are enough usecases to warrant a workaround: a BPF program which
> can be optionally loaded at data collection time and essentially walks
> /proc/PID/maps. Currently this is done by walking the vma list:
> 
>   struct vm_area_struct* mmap = BPF_CORE_READ(mm, mmap);
>   mmap_next = BPF_CORE_READ(rmap, vm_next); /* in a loop */
> 
> Since commit 763ecb035029 ("mm: remove the vma linked list") there's no
> longer a vma linked list to walk. Walking the vma maple tree is not as
> simple as hopping struct vm_area_struct->vm_next. Luckily,
> commit f39af05949a4 ("mm: add VMA iterator"), another commit in that series,
> added struct vma_iterator and for_each_vma macro for easy vma iteration. If
> similar functionality was exposed to BPF programs, it would be perfect for our
> usecase.
> 
> This series adds such functionality, specifically a BPF equivalent of
> for_each_vma using the open-coded iterator style.
> 
> Notes:
>   * This approach was chosen after discussion on a previous series [0] which
>     attempted to solve the same problem by adding a BPF_F_VMA_NEXT flag to
>     bpf_find_vma.
>   * Unlike the task_vma bpf_iter, the open-coded iterator kfuncs here do not
>     drop the vma read lock between iterations. See Alexei's response in [0].
>   * The [vsyscall] page isn't really part of task->mm's vmas, but
>     /proc/PID/maps returns information about it anyways. The vma iter added
>     here does not do the same. See comment on selftest in patch 3.
>   * bpf_iter_task_vma allocates a _data struct which contains - among other
>     things - struct vma_iterator, using BPF allocator and keeps a pointer to
>     the bpf_iter_task_vma_data. This is done in order to prevent changes to
>     struct ma_state - which is wrapped by struct vma_iterator - from
>     necessitating changes to uapi struct bpf_iter_task_vma.
> 
> Changelog:
> 
> v6 -> v7: https://lore.kernel.org/bpf/20231010185944.3888849-1-davemarchevsky@fb.com/
> 
> Patch numbers correspond to their position in v6
> 
> Patch 2 ("selftests/bpf: Rename bpf_iter_task_vma.c to bpf_iter_task_vmas.c")
>   * Add Andrii ack
> Patch 3 ("bpf: Introduce task_vma open-coded iterator kfuncs")
>   * Add Andrii ack
>   * Add missing __diag_ignore_all for -Wmissing-prototypes (Song)
> Patch 4 ("selftests/bpf: Add tests for open-coded task_vma iter")
>   * Remove two unnecessary header includes (Andrii)
>   * Remove extraneous !vmas_seen check (Andrii)

Whoops, forgot to add another bullet here:
  * Initialize FILE *f = NULL to address llvm-16 CI warnings (Andrii)

> New Patch ("bpf: Add BPF_KFUNC_{START,END}_defs macros")
>   * After talking to Andrii, this is an attempt to clean up __diag_ignore_all
>     spam everywhere kfuncs are defined. If nontrivial changes are needed,
>     let's apply the other 4 and I'll respin as a standalone patch.
> 
> v5 -> v6: https://lore.kernel.org/bpf/20231010175637.3405682-1-davemarchevsky@fb.com/
> 
> Patch 4 ("selftests/bpf: Add tests for open-coded task_vma iter")
>   * Remove extraneous blank line. I did this manually to the .patch file
>     for v5, which caused BPF CI to complain about failing to apply the
>     series
> 
> v4 -> v5: https://lore.kernel.org/bpf/20231002195341.2940874-1-davemarchevsky@fb.com/
> 
> Patch numbers correspond to their position in v4
> 
> New Patch ("selftests/bpf: Rename bpf_iter_task_vma.c to bpf_iter_task_vmas.c")
>   * Patch 2's renaming of this selftest, and associated changes in the
>     userspace runner, are split out into this separate commit (Andrii)
> 
> Patch 2 ("bpf: Introduce task_vma open-coded iterator kfuncs")
>   * Remove bpf_iter_task_vma kfuncs from libbpf's bpf_helpers.h, they'll be
>     added to selftests' bpf_experimental.h in selftests patch below (Andrii)
>   * Split bpf_iter_task_vma.c renaming into separate commit (Andrii)
> 
> Patch 3 ("selftests/bpf: Add tests for open-coded task_vma iter")
>   * Add bpf_iter_task_vma kfuncs to bpf_experimental.h (Andrii)
>   * Remove '?' from prog SEC, open_and_load the skel in one operation (Andrii)
>   * Ensure that fclose() always happens in test runner (Andrii)
>   * Use global var w/ 1000 (vm_start, vm_end) structs instead of two
>     MAP_TYPE_ARRAY's w/ 1k u64s each (Andrii)
> 
> 
> v3 -> v4: https://lore.kernel.org/bpf/20230822050558.2937659-1-davemarchevsky@fb.com/
> 
> Patch 1 ("bpf: Don't explicitly emit BTF for struct btf_iter_num")
>   * Add Andrii ack
> Patch 2 ("bpf: Introduce task_vma open-coded iterator kfuncs")
>   * Mark bpf_iter_task_vma_new args KF_RCU and remove now-unnecessary !task
>     check (Yonghong)
>     * Although KF_RCU is a function-level flag, in reality it only applies to
>       the task_struct *task parameter, as the other two params are a scalar int
>       and a specially-handled KF_ARG_PTR_TO_ITER
>    * Remove struct bpf_iter_task_vma definition from uapi headers, define in
>      kernel/bpf/task_iter.c instead (Andrii)
> Patch 3 ("selftests/bpf: Add tests for open-coded task_vma iter")
>   * Use a local var when looping over vmas to track map idx. Update vmas_seen
>     global after done iterating. Don't start iterating or update vmas_seen if
>     vmas_seen global is nonzero. (Andrii)
>   * Move getpgid() call to correct spot - above skel detach. (Andrii)
> 
> v2 -> v3: https://lore.kernel.org/bpf/20230821173415.1970776-1-davemarchevsky@fb.com/
> 
> Patch 1 ("bpf: Don't explicitly emit BTF for struct btf_iter_num")
>   * Add Yonghong ack
> 
> Patch 2 ("bpf: Introduce task_vma open-coded iterator kfuncs")
>   * UAPI bpf header and tools/ version should match
>   * Add bpf_iter_task_vma_kern_data which bpf_iter_task_vma_kern points to,
>     bpf_mem_alloc/free it instead of just vma_iterator. (Alexei)
>     * Inner data ptr == NULL implies initialization failed
> 
> 
> v1 -> v2: https://lore.kernel.org/bpf/20230810183513.684836-1-davemarchevsky@fb.com/
>   * Patch 1
>     * Now removes the unnecessary BTF_TYPE_EMIT instead of changing the
>       type (Yonghong)
>   * Patch 2
>     * Don't do unnecessary BTF_TYPE_EMIT (Yonghong)
>     * Bump task refcount to prevent ->mm reuse (Yonghong)
>     * Keep a pointer to vma_iterator in bpf_iter_task_vma, alloc/free
>       via BPF mem allocator (Yonghong, Stanislav)
>   * Patch 3
> 
>   [0]: https://lore.kernel.org/bpf/20230801145414.418145-1-davemarchevsky@fb.com/
> 
> Dave Marchevsky (5):
>   bpf: Don't explicitly emit BTF for struct btf_iter_num
>   selftests/bpf: Rename bpf_iter_task_vma.c to bpf_iter_task_vmas.c
>   bpf: Introduce task_vma open-coded iterator kfuncs
>   selftests/bpf: Add tests for open-coded task_vma iter
>   bpf: Add BPF_KFUNC_{START,END}_defs macros
> 
>  include/linux/btf.h                           |  7 ++
>  kernel/bpf/bpf_iter.c                         |  8 +-
>  kernel/bpf/cpumask.c                          |  6 +-
>  kernel/bpf/helpers.c                          |  9 +-
>  kernel/bpf/map_iter.c                         |  6 +-
>  kernel/bpf/task_iter.c                        | 89 +++++++++++++++++++
>  kernel/trace/bpf_trace.c                      |  6 +-
>  net/bpf/test_run.c                            |  7 +-
>  net/core/filter.c                             | 13 +--
>  net/core/xdp.c                                |  6 +-
>  net/ipv4/fou_bpf.c                            |  6 +-
>  net/netfilter/nf_conntrack_bpf.c              |  6 +-
>  net/netfilter/nf_nat_bpf.c                    |  6 +-
>  net/xfrm/xfrm_interface_bpf.c                 |  6 +-
>  .../testing/selftests/bpf/bpf_experimental.h  |  8 ++
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++---
>  .../testing/selftests/bpf/prog_tests/iters.c  | 58 ++++++++++++
>  ...f_iter_task_vma.c => bpf_iter_task_vmas.c} |  0
>  .../selftests/bpf/progs/iters_task_vma.c      | 43 +++++++++
>  19 files changed, 248 insertions(+), 68 deletions(-)
>  rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c => bpf_iter_task_vmas.c} (100%)
>  create mode 100644 tools/testing/selftests/bpf/progs/iters_task_vma.c
> 

