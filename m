Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692B33FBE6D
	for <lists+bpf@lfdr.de>; Mon, 30 Aug 2021 23:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbhH3VmJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 17:42:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57584 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237296AbhH3VmI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Aug 2021 17:42:08 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ULe8qQ006964
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 14:41:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=GQkjT68Y1G0cFcBBOBufW5uO3v6jWnEaZhZVXddLF0Q=;
 b=PGj5ps+zKOHRiEsgkrVfJEZF6xWFWfPDBUyFn+sneBwVyzfR7O80uvkq4deTlv1vvsmg
 XEi8MlakBXr+byFwHt5O7bvky4VhBVzzisggJd6Xop31isMxFt26EaUYAQsLV249a4Si
 vMU6fWeUncu5bQZOhK3VDV5L3e1U+iToU2U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3arnw15yw8-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 14:41:14 -0700
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 30 Aug 2021 14:41:11 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id DD81FF146804; Mon, 30 Aug 2021 14:41:09 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <kjain@linux.ibm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v3 bpf-next 0/3] bpf: introduce bpf_get_branch_snapshot
Date:   Mon, 30 Aug 2021 14:41:03 -0700
Message-ID: <20210830214106.4142056-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 4WWCllbV5xHC1iGnQWJBpgBMsNpbwArq
X-Proofpoint-GUID: 4WWCllbV5xHC1iGnQWJBpgBMsNpbwArq
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-30_06:2021-08-30,2021-08-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108300136
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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

With current code, on Intel CPU, LBR is stopped after 6 branch entries
after fexit triggers:

ID: 0 from intel_pmu_lbr_disable_all.part.10+37 to intel_pmu_lbr_disable_al=
l.part.10+72
ID: 1 from intel_pmu_lbr_disable_all.part.10+33 to intel_pmu_lbr_disable_al=
l.part.10+37
ID: 2 from intel_pmu_snapshot_branch_stack+46 to intel_pmu_lbr_disable_all.=
part.10+0
ID: 3 from __bpf_prog_enter+38 to intel_pmu_snapshot_branch_stack+0
ID: 4 from __bpf_prog_enter+8 to __bpf_prog_enter+38
ID: 5 from __brk_limit+477020214 to __bpf_prog_enter+0
ID: 6 from bpf_fexit_loop_test1+22 to __brk_limit+477020195
ID: 7 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
ID: 8 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
...

[1] https://lore.kernel.org/bpf/20210818012937.2522409-1-songliubraving@fb.=
com/

Song Liu (3):
  perf: enable branch record for software events
  bpf: introduce helper bpf_get_branch_snapshot
  selftests/bpf: add test for bpf_get_branch_snapshot

 arch/x86/events/intel/core.c                  |  24 +++-
 include/linux/bpf.h                           |   2 +
 include/linux/filter.h                        |   3 +-
 include/linux/perf_event.h                    |  24 ++++
 include/uapi/linux/bpf.h                      |  16 +++
 kernel/bpf/trampoline.c                       |  13 +++
 kernel/bpf/verifier.c                         |  12 ++
 kernel/events/core.c                          |   3 +
 kernel/trace/bpf_trace.c                      |  43 +++++++
 net/bpf/test_run.c                            |  15 ++-
 tools/include/uapi/linux/bpf.h                |  16 +++
 .../bpf/prog_tests/get_branch_snapshot.c      | 106 ++++++++++++++++++
 .../selftests/bpf/progs/get_branch_snapshot.c |  41 +++++++
 tools/testing/selftests/bpf/trace_helpers.c   |  30 +++++
 tools/testing/selftests/bpf/trace_helpers.h   |   5 +
 15 files changed, 349 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_branch_snaps=
hot.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_branch_snapshot.c

--
2.30.2
