Return-Path: <bpf+bounces-15382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5535E7F1BD2
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 18:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D14D0B213C2
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 17:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4362CCCA;
	Mon, 20 Nov 2023 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SqkO72LV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F69E98
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 09:59:44 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKHt7dr021266
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 09:59:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=zgztEWCQ23gLYqMSJXYnjC7JsrocEqpm7DBwugLQG9A=;
 b=SqkO72LVc7xVBiVIfpThchwV7wWVPaFeXOL1XCGTbLVKPx/1KP0YF7dhvJvPn+qmg0av
 zX1V1GerIvGWfG2n2HyRq55zBsyqrsh4HQYCKPrNsOawiimrXqQpdcif5j86E33mzetU
 t1gZAB8YLTRUdH5sD8L5tKpGnBXUxd8NKeA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ugajcs0dk-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 09:59:43 -0800
Received: from twshared4397.08.ash8.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 09:59:39 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 934A02792C0FC; Mon, 20 Nov 2023 09:59:27 -0800 (PST)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner
	<hannes@cmpxchg.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 0/2] bpf: Add mmapable task_local storage
Date: Mon, 20 Nov 2023 09:59:23 -0800
Message-ID: <20231120175925.733167-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GhAw4tBPihlk7us-5MS0E2YQjznUkvKV
X-Proofpoint-GUID: GhAw4tBPihlk7us-5MS0E2YQjznUkvKV
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_18,2023-11-20_01,2023-05-22_02

This series adds support for mmap()ing single task_local storage mapvals
into userspace. Two motivating usecases:

  * sched_ext ([0]) schedulers might want to act on 'scheduling hints'
    provided by userspace tasks. For example, a task can tag itself as
    latency-sensitive but not particularly computationally intensive and
    BPF scheduler can use this information to make better scheduling
    decisions. Similarly, a database task about to start a
    transaction can tag itself as doing so without high overhead by
    writing to the mmap'd mapval. In both cases the information is
    task-specific and in the latter it'd be preferable to avoid
    incurring syscall overhead as the hint would change often.

  * strobemeta ([1]) technique to read thread_local storage is used
    by tracing programs at Meta to annotate tracing data with
    task-specific metadata. For example, a multithreaded webserver with
    a pool of worker threads preparing responses and other threads
    handling request connections might want to tag threads by type, and
    further tag worker threads with feature flags enabled during request
    processing.
      * The strobemeta technique predates existence of task_local
	storage map, instead relying on reverse-engineering thread_local
	storage implementation specifics. The approach enabled here
	avoids much of this complexity.

The general thrust of this series' implementation is "simplest thing
that works". A userspace thread can mmap() a task_local storage map fd
and receive the map_value corresponding to its task. In the future we
can support mmap()ing in other threads' map_values via offset parameter
or some other approach. Similarly, this series makes no attempt to pack
multiple map_values into a userspace-mappable page - each map_value for
a BPF_F_MMAPABLE task_local storage map is given its own page. For the
motivating usecases above neither of those potential improvements is
necessary. Patch 1's summary digs deeper into implementation details.

This series' changes to generic local_storage implementation shared by
cgroup_local storage and others will make extending this support to
those local storage types straightforward in the future.

Summary of patches:
  * Patch 1 adds support for mmapable map_vals in generic
    bpf_local_storage infrastructure and uses the new feature in
    task_local storage
  * Patch 2 adds tests

  [0]: https://lore.kernel.org/bpf/20231111024835.2164816-1-tj@kernel.org/
  [1]: tools/testing/selftests/bpf/progs/strobemeta*

Dave Marchevsky (2):
  bpf: Support BPF_F_MMAPABLE task_local storage
  selftests/bpf: Add test exercising mmapable task_local_storage

 include/linux/bpf_local_storage.h             |  14 +-
 kernel/bpf/bpf_local_storage.c                | 145 +++++++++++---
 kernel/bpf/bpf_task_storage.c                 |  35 +++-
 kernel/bpf/syscall.c                          |   2 +-
 .../bpf/prog_tests/task_local_storage.c       | 177 ++++++++++++++++++
 .../bpf/progs/task_local_storage__mmap.c      |  59 ++++++
 .../bpf/progs/task_local_storage__mmap.h      |   7 +
 .../bpf/progs/task_local_storage__mmap_fail.c |  39 ++++
 8 files changed, 445 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/task_local_storage__m=
map.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_local_storage__m=
map.h
 create mode 100644 tools/testing/selftests/bpf/progs/task_local_storage__m=
map_fail.c

--=20
2.34.1


