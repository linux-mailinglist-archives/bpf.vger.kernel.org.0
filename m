Return-Path: <bpf+bounces-12168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC8C7C8E71
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6DEFB20B5C
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 20:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCB91C298;
	Fri, 13 Oct 2023 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="m5xwi1ji"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6CF7489
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 20:44:44 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC44FBB
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 13:44:42 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39DGsfR0006690
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 13:44:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=WIm5pWIXBjjdQgWT45NEjNe8nu8zxvqFPxKNY2sv29k=;
 b=m5xwi1jiJXi+Epizlibikg4Ik+fuLI1MWep0cjLksgmHwE75ZAlXHwOQm5CJb+zIL0ub
 JI01p2nBRSe9ns25/2mTBR3HDGgrOY/LyyaekgW/GCZre/aTMGgX/0vUXLyfCw0eVfhn
 /eLxbal4vKVIa3VKLwwImm8UIPSguT/7Ya4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3tq8g8348x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 13:44:41 -0700
Received: from twshared19681.14.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 13 Oct 2023 13:44:41 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id ADE5825B0E81B; Fri, 13 Oct 2023 13:44:27 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v7 bpf-next 0/5] Open-coded task_vma iter
Date: Fri, 13 Oct 2023 13:44:21 -0700
Message-ID: <20231013204426.1074286-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KvP_VgivNsOq5lzIIB19IQVjOftJRlNS
X-Proofpoint-ORIG-GUID: KvP_VgivNsOq5lzIIB19IQVjOftJRlNS
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_12,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

At Meta we have a profiling daemon which periodically collects
information on many hosts. This collection usually involves grabbing
stacks (user and kernel) using perf_event BPF progs and later symbolicating
them. For user stacks we try to use BPF_F_USER_BUILD_ID and rely on
remote symbolication, but BPF_F_USER_BUILD_ID doesn't always succeed. In
those cases we must fall back to digging around in /proc/PID/maps to map
virtual address to (binary, offset). The /proc/PID/maps digging does not
occur synchronously with stack collection, so the process might already
be gone, in which case it won't have /proc/PID/maps and we will fail to
symbolicate.

This 'exited process problem' doesn't occur very often as
most of the prod services we care to profile are long-lived daemons, but
there are enough usecases to warrant a workaround: a BPF program which
can be optionally loaded at data collection time and essentially walks
/proc/PID/maps. Currently this is done by walking the vma list:

  struct vm_area_struct* mmap =3D BPF_CORE_READ(mm, mmap);
  mmap_next =3D BPF_CORE_READ(rmap, vm_next); /* in a loop */

Since commit 763ecb035029 ("mm: remove the vma linked list") there's no
longer a vma linked list to walk. Walking the vma maple tree is not as
simple as hopping struct vm_area_struct->vm_next. Luckily,
commit f39af05949a4 ("mm: add VMA iterator"), another commit in that series,
added struct vma_iterator and for_each_vma macro for easy vma iteration. If
similar functionality was exposed to BPF programs, it would be perfect for =
our
usecase.

This series adds such functionality, specifically a BPF equivalent of
for_each_vma using the open-coded iterator style.

Notes:
  * This approach was chosen after discussion on a previous series [0] which
    attempted to solve the same problem by adding a BPF_F_VMA_NEXT flag to
    bpf_find_vma.
  * Unlike the task_vma bpf_iter, the open-coded iterator kfuncs here do not
    drop the vma read lock between iterations. See Alexei's response in [0].
  * The [vsyscall] page isn't really part of task->mm's vmas, but
    /proc/PID/maps returns information about it anyways. The vma iter added
    here does not do the same. See comment on selftest in patch 3.
  * bpf_iter_task_vma allocates a _data struct which contains - among other
    things - struct vma_iterator, using BPF allocator and keeps a pointer to
    the bpf_iter_task_vma_data. This is done in order to prevent changes to
    struct ma_state - which is wrapped by struct vma_iterator - from
    necessitating changes to uapi struct bpf_iter_task_vma.

Changelog:

v6 -> v7: https://lore.kernel.org/bpf/20231010185944.3888849-1-davemarchevs=
ky@fb.com/

Patch numbers correspond to their position in v6

Patch 2 ("selftests/bpf: Rename bpf_iter_task_vma.c to bpf_iter_task_vmas.c=
")
  * Add Andrii ack
Patch 3 ("bpf: Introduce task_vma open-coded iterator kfuncs")
  * Add Andrii ack
  * Add missing __diag_ignore_all for -Wmissing-prototypes (Song)
Patch 4 ("selftests/bpf: Add tests for open-coded task_vma iter")
  * Remove two unnecessary header includes (Andrii)
  * Remove extraneous !vmas_seen check (Andrii)
New Patch ("bpf: Add BPF_KFUNC_{START,END}_defs macros")
  * After talking to Andrii, this is an attempt to clean up __diag_ignore_a=
ll
    spam everywhere kfuncs are defined. If nontrivial changes are needed,
    let's apply the other 4 and I'll respin as a standalone patch.

v5 -> v6: https://lore.kernel.org/bpf/20231010175637.3405682-1-davemarchevs=
ky@fb.com/

Patch 4 ("selftests/bpf: Add tests for open-coded task_vma iter")
  * Remove extraneous blank line. I did this manually to the .patch file
    for v5, which caused BPF CI to complain about failing to apply the
    series

v4 -> v5: https://lore.kernel.org/bpf/20231002195341.2940874-1-davemarchevs=
ky@fb.com/

Patch numbers correspond to their position in v4

New Patch ("selftests/bpf: Rename bpf_iter_task_vma.c to bpf_iter_task_vmas=
.c")
  * Patch 2's renaming of this selftest, and associated changes in the
    userspace runner, are split out into this separate commit (Andrii)

Patch 2 ("bpf: Introduce task_vma open-coded iterator kfuncs")
  * Remove bpf_iter_task_vma kfuncs from libbpf's bpf_helpers.h, they'll be
    added to selftests' bpf_experimental.h in selftests patch below (Andrii)
  * Split bpf_iter_task_vma.c renaming into separate commit (Andrii)

Patch 3 ("selftests/bpf: Add tests for open-coded task_vma iter")
  * Add bpf_iter_task_vma kfuncs to bpf_experimental.h (Andrii)
  * Remove '?' from prog SEC, open_and_load the skel in one operation (Andr=
ii)
  * Ensure that fclose() always happens in test runner (Andrii)
  * Use global var w/ 1000 (vm_start, vm_end) structs instead of two
    MAP_TYPE_ARRAY's w/ 1k u64s each (Andrii)


v3 -> v4: https://lore.kernel.org/bpf/20230822050558.2937659-1-davemarchevs=
ky@fb.com/

Patch 1 ("bpf: Don't explicitly emit BTF for struct btf_iter_num")
  * Add Andrii ack
Patch 2 ("bpf: Introduce task_vma open-coded iterator kfuncs")
  * Mark bpf_iter_task_vma_new args KF_RCU and remove now-unnecessary !task
    check (Yonghong)
    * Although KF_RCU is a function-level flag, in reality it only applies =
to
      the task_struct *task parameter, as the other two params are a scalar=
 int
      and a specially-handled KF_ARG_PTR_TO_ITER
   * Remove struct bpf_iter_task_vma definition from uapi headers, define in
     kernel/bpf/task_iter.c instead (Andrii)
Patch 3 ("selftests/bpf: Add tests for open-coded task_vma iter")
  * Use a local var when looping over vmas to track map idx. Update vmas_se=
en
    global after done iterating. Don't start iterating or update vmas_seen =
if
    vmas_seen global is nonzero. (Andrii)
  * Move getpgid() call to correct spot - above skel detach. (Andrii)

v2 -> v3: https://lore.kernel.org/bpf/20230821173415.1970776-1-davemarchevs=
ky@fb.com/

Patch 1 ("bpf: Don't explicitly emit BTF for struct btf_iter_num")
  * Add Yonghong ack

Patch 2 ("bpf: Introduce task_vma open-coded iterator kfuncs")
  * UAPI bpf header and tools/ version should match
  * Add bpf_iter_task_vma_kern_data which bpf_iter_task_vma_kern points to,
    bpf_mem_alloc/free it instead of just vma_iterator. (Alexei)
    * Inner data ptr =3D=3D NULL implies initialization failed


v1 -> v2: https://lore.kernel.org/bpf/20230810183513.684836-1-davemarchevsk=
y@fb.com/
  * Patch 1
    * Now removes the unnecessary BTF_TYPE_EMIT instead of changing the
      type (Yonghong)
  * Patch 2
    * Don't do unnecessary BTF_TYPE_EMIT (Yonghong)
    * Bump task refcount to prevent ->mm reuse (Yonghong)
    * Keep a pointer to vma_iterator in bpf_iter_task_vma, alloc/free
      via BPF mem allocator (Yonghong, Stanislav)
  * Patch 3

  [0]: https://lore.kernel.org/bpf/20230801145414.418145-1-davemarchevsky@f=
b.com/

Dave Marchevsky (5):
  bpf: Don't explicitly emit BTF for struct btf_iter_num
  selftests/bpf: Rename bpf_iter_task_vma.c to bpf_iter_task_vmas.c
  bpf: Introduce task_vma open-coded iterator kfuncs
  selftests/bpf: Add tests for open-coded task_vma iter
  bpf: Add BPF_KFUNC_{START,END}_defs macros

 include/linux/btf.h                           |  7 ++
 kernel/bpf/bpf_iter.c                         |  8 +-
 kernel/bpf/cpumask.c                          |  6 +-
 kernel/bpf/helpers.c                          |  9 +-
 kernel/bpf/map_iter.c                         |  6 +-
 kernel/bpf/task_iter.c                        | 89 +++++++++++++++++++
 kernel/trace/bpf_trace.c                      |  6 +-
 net/bpf/test_run.c                            |  7 +-
 net/core/filter.c                             | 13 +--
 net/core/xdp.c                                |  6 +-
 net/ipv4/fou_bpf.c                            |  6 +-
 net/netfilter/nf_conntrack_bpf.c              |  6 +-
 net/netfilter/nf_nat_bpf.c                    |  6 +-
 net/xfrm/xfrm_interface_bpf.c                 |  6 +-
 .../testing/selftests/bpf/bpf_experimental.h  |  8 ++
 .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++---
 .../testing/selftests/bpf/prog_tests/iters.c  | 58 ++++++++++++
 ...f_iter_task_vma.c =3D> bpf_iter_task_vmas.c} |  0
 .../selftests/bpf/progs/iters_task_vma.c      | 43 +++++++++
 19 files changed, 248 insertions(+), 68 deletions(-)
 rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c =3D> bpf_ite=
r_task_vmas.c} (100%)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_vma.c

--=20
2.34.1

