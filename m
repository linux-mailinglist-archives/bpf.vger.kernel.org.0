Return-Path: <bpf+bounces-8164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A3F782F7C
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 19:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE7A1C20908
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 17:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9EC8F44;
	Mon, 21 Aug 2023 17:34:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8D88C17
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 17:34:30 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CE0F7
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 10:34:29 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LH36Fs003590
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 10:34:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=rYmruBNyP2CCUG3FLS/cn1K9lpkJo8KabuIipAD4jug=;
 b=fSvG2GHSM6G8DM/1cMG74R0ZwE2+c2n0wU4wfCrfvn9/1VgTIHCoYlR78VVrkuELQg+0
 YTRbBBoliHg7I/OKnjGGEOfxeQrbcJwBdOW/0Jzx23cEhLqNvCt8s9nQmgbNRSDFTcLT
 6Q7Y3QqNVV9g60hm64BRONB6l0UIjKf67fg= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3sjs2ux5tk-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 10:34:29 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 21 Aug 2023 10:34:28 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 3C2F82300E6D5; Mon, 21 Aug 2023 10:34:16 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>, <yonghong.song@linux.dev>,
        <sdf@google.com>, Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 0/3] Open-coded task_vma iter
Date: Mon, 21 Aug 2023 10:34:12 -0700
Message-ID: <20230821173415.1970776-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Grf5khF3369MX7l3hxzujgRXgWmmHI7m
X-Proofpoint-GUID: Grf5khF3369MX7l3hxzujgRXgWmmHI7m
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_06,2023-08-18_01,2023-05-22_02
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
  * bpf_iter_task_vma allocates a struct vma_iterator using BPF
    allocator and keeps a pointer to it. This is done in order to
    prevent changes to struct ma_state - which is wrapped by struct
    vma_iterator - from necessitating changes to uapi struct
    bpf_iter_task_vma.

Changelog:

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

Patch summary:
  * Patch 1 is a tiny fix I ran into while implementing the vma iter in this
    series. It can be applied independently.
  * Patch 2 is the meat of the implementation
  * Patch 3 adds tests for the new functionality
    * Existing iter tests exercise failure cases (e.g. prog that doesn't ca=
ll
      _destroy()). I didn't replicate them in this series, but am happy to =
add
      them in v2 if folks feel that it would be worthwhile.

  [0]: https://lore.kernel.org/bpf/20230801145414.418145-1-davemarchevsky@f=
b.com/

Dave Marchevsky (3):
  bpf: Don't explicitly emit BTF for struct btf_iter_num
  bpf: Introduce task_vma open-coded iterator kfuncs
  selftests/bpf: Add tests for open-coded task_vma iter

 include/uapi/linux/bpf.h                      |  4 +
 kernel/bpf/bpf_iter.c                         |  2 -
 kernel/bpf/helpers.c                          |  3 +
 kernel/bpf/task_iter.c                        | 79 +++++++++++++++++++
 tools/include/uapi/linux/bpf.h                |  5 ++
 tools/lib/bpf/bpf_helpers.h                   |  8 ++
 .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++---
 .../testing/selftests/bpf/prog_tests/iters.c  | 71 +++++++++++++++++
 ...f_iter_task_vma.c =3D> bpf_iter_task_vmas.c} |  0
 .../selftests/bpf/progs/iters_task_vma.c      | 56 +++++++++++++
 10 files changed, 239 insertions(+), 15 deletions(-)
 rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c =3D> bpf_ite=
r_task_vmas.c} (100%)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_vma.c

--=20
2.34.1

