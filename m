Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59214070F7
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 20:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhIJSfN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 14:35:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22196 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232158AbhIJSfN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 14:35:13 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18AIUVZh025067
        for <bpf@vger.kernel.org>; Fri, 10 Sep 2021 11:34:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=8O9Z01WTul8YIyj6F/JcTTjuH4Rm2WjozHPaqR2A+3Y=;
 b=AoybrWLg/fZB8vYu7GjuOJbBZLxvSyzFTbSOMbEmyAsio9GsfqSsXyqYQvE7IlT8adjX
 qzV0ZWOpxN10Mwh/x8PmP9v7WcvC9FUbUT8XZtW2QzF/WGezriNVFRcx6OMsZmu1PKnP
 3gOwVjgT3UaiMThVj20WYMi67Dj0Uz3CMuE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aytgdxsd5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Sep 2021 11:34:01 -0700
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 10 Sep 2021 11:34:00 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id EA89810A91483; Fri, 10 Sep 2021 11:33:57 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <kjain@linux.ibm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v7 bpf-next 0/3] bpf: introduce bpf_get_branch_snapshot
Date:   Fri, 10 Sep 2021 11:33:49 -0700
Message-ID: <20210910183352.3151445-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: fIB8cfPOkKXxo-3RaYo4FNKBqVwhKL--
X-Proofpoint-GUID: fIB8cfPOkKXxo-3RaYo4FNKBqVwhKL--
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_07:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=984 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Changes v6 =3D> v7:
1. Improve/fix intel_pmu_snapshot_branch_stack() logic. (Peter).

Changes v5 =3D> v6:
1. Add local_irq_save/restore to intel_pmu_snapshot_branch_stack. (Peter)
2. Remove buf and size check in bpf_get_branch_snapshot, move flags check
   to later fo the function. (Peter, Andrii)
3. Revise comments for bpf_get_branch_snapshot in bpf.h (Andrii)

Changes v4 =3D> v5:
1. Modify perf_snapshot_branch_stack_t to save some memcpy. (Andrii)
2. Minor fixes in selftests. (Andrii)

Changes v3 =3D> v4:
1. Do not reshuffle intel_pmu_disable_all(). Use some inline to save LBR
   entries. (Peter)
2. Move static_call(perf_snapshot_branch_stack) to the helper. (Alexei)
3. Add argument flags to bpf_get_branch_snapshot. (Andrii)
4. Make MAX_BRANCH_SNAPSHOT an enum (Andrii). And rename it as
   PERF_MAX_BRANCH_SNAPSHOT
5. Make bpf_get_branch_snapshot similar to bpf_read_branch_records.
   (Andrii)
6. Move the test target function to bpf_testmod. Updated kallsyms_find_next
   to work properly with modules. (Andrii)

Changes v2 =3D> v3:
1. Fix the use of static_call. (Peter)
2. Limit the use to perfmon version >=3D 2. (Peter)
3. Modify intel_pmu_snapshot_branch_stack() to use intel_pmu_disable_all
   and intel_pmu_enable_all().

Changes v1 =3D> v2:
1. Rename the helper as bpf_get_branch_snapshot;
2. Fix/simplify the use of static_call;
3. Instead of percpu variables, let intel_pmu_snapshot_branch_stack output
   branch records to an output argument of type perf_branch_snapshot.

Branch stack can be very useful in understanding software events. For
example, when a long function, e.g. sys_perf_event_open, returns an errno,
it is not obvious why the function failed. Branch stack could provide very
helpful information in this type of scenarios.

This set adds support to read branch stack with a new BPF helper
bpf_get_branch_trace(). Currently, this is only supported in Intel systems.
It is also possible to support the same feaure for PowerPC.

The hardware that records the branch stace is not stopped automatically on
software events. Therefore, it is necessary to stop it in software soon.
Otherwise, the hardware buffers/registers will be flushed. One of the key
design consideration in this set is to minimize the number of branch record
entries between the event triggers and the hardware recorder is stopped.
Based on this goal, current design is different from the discussions in
original RFC [1]:
 1) Static call is used when supported, to save function pointer
    dereference;
 2) intel_pmu_lbr_disable_all is used instead of perf_pmu_disable(),
    because the latter uses about 10 entries before stopping LBR.

With current code, on Intel CPU, LBR is stopped after 7 branch entries
after fexit triggers:

ID: 0 from bpf_get_branch_snapshot+18 to intel_pmu_snapshot_branch_stack+0
ID: 1 from __brk_limit+477143934 to bpf_get_branch_snapshot+0
ID: 2 from __brk_limit+477192263 to __brk_limit+477143880  # trampoline
ID: 3 from __bpf_prog_enter+34 to __brk_limit+477192251
ID: 4 from migrate_disable+60 to __bpf_prog_enter+9
ID: 5 from __bpf_prog_enter+4 to migrate_disable+0
ID: 6 from bpf_testmod_loop_test+20 to __bpf_prog_enter+0
ID: 7 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
ID: 8 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
...

[1] https://lore.kernel.org/bpf/20210818012937.2522409-1-songliubraving@fb.=
com/

Song Liu (3):
  perf: enable branch record for software events
  bpf: introduce helper bpf_get_branch_snapshot
  selftests/bpf: add test for bpf_get_branch_snapshot

 arch/x86/events/intel/core.c                  |  67 ++++++++++--
 arch/x86/events/intel/ds.c                    |   2 +-
 arch/x86/events/intel/lbr.c                   |  20 +---
 arch/x86/events/perf_event.h                  |  19 ++++
 include/linux/perf_event.h                    |  23 ++++
 include/uapi/linux/bpf.h                      |  22 ++++
 kernel/bpf/trampoline.c                       |   3 +-
 kernel/events/core.c                          |   2 +
 kernel/trace/bpf_trace.c                      |  30 ++++++
 tools/include/uapi/linux/bpf.h                |  22 ++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  19 +++-
 .../selftests/bpf/prog_tests/core_reloc.c     |  14 +--
 .../bpf/prog_tests/get_branch_snapshot.c      | 100 ++++++++++++++++++
 .../selftests/bpf/prog_tests/module_attach.c  |  39 -------
 .../selftests/bpf/progs/get_branch_snapshot.c |  40 +++++++
 tools/testing/selftests/bpf/test_progs.c      |  39 +++++++
 tools/testing/selftests/bpf/test_progs.h      |   2 +
 tools/testing/selftests/bpf/trace_helpers.c   |  37 +++++++
 tools/testing/selftests/bpf/trace_helpers.h   |   5 +
 19 files changed, 430 insertions(+), 75 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_branch_snaps=
hot.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_branch_snapshot.c

--
2.30.2
