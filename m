Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590EA3FD053
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 02:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240914AbhIAAgY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 20:36:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52266 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240844AbhIAAgX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 20:36:23 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1810Ufev025279
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 17:35:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=xfJaQgEFutNFXHwxqE5t89p1I7MO4YmmYJYKZbVwTU4=;
 b=RoxxkhAlCK6II/ZzjpnpNSUOByRltX/hfQCzmnISFlMiYpzjU6gL4bKY7/ikRxeyAbAt
 Q7T0SN4OurkWX7GjjLsiVV6hwhPbXXz4iqXO/0zstpYZrCHFf8nYTKIsXIKzjy+o5sdC
 f2qvyPHkIWgPTMB4p0V47Yf+jh7LEAsBhh4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3asmx9dfe1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 17:35:27 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 31 Aug 2021 17:35:26 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 92286F58687E; Tue, 31 Aug 2021 17:35:20 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <kjain@linux.ibm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v4 bpf-next 0/3] bpf: introduce bpf_get_branch_snapshot
Date:   Tue, 31 Aug 2021 17:35:14 -0700
Message-ID: <20210901003517.3953145-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 6dVRIz7hVR8S6nJZnd9vro5aCaFM7D13
X-Proofpoint-GUID: 6dVRIz7hVR8S6nJZnd9vro5aCaFM7D13
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_10:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=938 mlxscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2109010001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

changes v3 =3D> v4:
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

With current code, on Intel CPU, LBR is stopped after 10 branch entries
after fexit triggers:

ID: 0 from intel_pmu_lbr_disable_all+58 to intel_pmu_lbr_disable_all+93
ID: 1 from intel_pmu_lbr_disable_all+54 to intel_pmu_lbr_disable_all+58
ID: 2 from intel_pmu_snapshot_branch_stack+88 to intel_pmu_lbr_disable_all+0
ID: 3 from bpf_get_branch_snapshot+77 to intel_pmu_snapshot_branch_stack+0
ID: 4 from __brk_limit+478052814 to bpf_get_branch_snapshot+0
ID: 5 from __brk_limit+478036039 to __brk_limit+478052760
ID: 6 from __bpf_prog_enter+34 to __brk_limit+478036027
ID: 7 from migrate_disable+60 to __bpf_prog_enter+9
ID: 8 from __bpf_prog_enter+4 to migrate_disable+0
ID: 9 from __brk_limit+478036022 to __bpf_prog_enter+0
ID: 10 from bpf_testmod_loop_test+22 to __brk_limit+478036003
ID: 11 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
ID: 12 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
ID: 13 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
...

[1] https://lore.kernel.org/bpf/20210818012937.2522409-1-songliubraving@fb.=
com/

Song Liu (3):
  perf: enable branch record for software events
  bpf: introduce helper bpf_get_branch_snapshot
  selftests/bpf: add test for bpf_get_branch_snapshot

 arch/x86/events/intel/core.c                  |  26 ++++-
 arch/x86/events/intel/ds.c                    |   8 --
 arch/x86/events/perf_event.h                  |  10 +-
 include/linux/perf_event.h                    |  26 +++++
 include/uapi/linux/bpf.h                      |  22 ++++
 kernel/bpf/trampoline.c                       |   3 +-
 kernel/events/core.c                          |   2 +
 kernel/trace/bpf_trace.c                      |  40 +++++++
 tools/include/uapi/linux/bpf.h                |  22 ++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  14 ++-
 .../bpf/prog_tests/get_branch_snapshot.c      | 101 ++++++++++++++++++
 .../selftests/bpf/progs/get_branch_snapshot.c |  44 ++++++++
 tools/testing/selftests/bpf/trace_helpers.c   |  37 +++++++
 tools/testing/selftests/bpf/trace_helpers.h   |   5 +
 14 files changed, 345 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_branch_snaps=
hot.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_branch_snapshot.c

--
2.30.2
