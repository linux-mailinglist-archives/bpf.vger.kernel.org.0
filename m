Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCE93F9096
	for <lists+bpf@lfdr.de>; Fri, 27 Aug 2021 01:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243665AbhHZWSZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 18:18:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42320 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230397AbhHZWSZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Aug 2021 18:18:25 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17QMDMx4001776
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 15:17:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=SNlvjBOoMc2diRh3mh3qe/DjYVpAezw4uV4LpUmVRRc=;
 b=gf0iGrZq0VKc9m3tQF01o8GKUpardlVEtbyIgFk/wzoPgBIQXU56P0nlcVFyusbbT85b
 DRC/220w3UeJ2VeAl9SGe3JhVwMZx9QxDX5TzJ+5SHFF93YNMofnFlfCjxMclJq8vPaZ
 MX+LFBrC9FUFy0HCJrNDBWJkN7JQpYVKhlE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3angchnhvb-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 15:17:37 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 26 Aug 2021 15:15:47 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 96B51E2EC432; Thu, 26 Aug 2021 15:13:11 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <kjain@linux.ibm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 bpf-next 0/3] bpf: introduce bpf_get_branch_snapshot
Date:   Thu, 26 Aug 2021 15:13:03 -0700
Message-ID: <20210826221306.2280066-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 20cYZVCD9EASkaXpOai1Vjp-OsQTN24z
X-Proofpoint-ORIG-GUID: 20cYZVCD9EASkaXpOai1Vjp-OsQTN24z
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-26_05:2021-08-26,2021-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108260124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Changes v1 =3D> v2:
1. Rename the helper as bpf_get_branch_snapshot;
2. Fix/simplify the use of stack_call;
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

 arch/x86/events/intel/core.c                  |   5 +-
 arch/x86/events/intel/lbr.c                   |  13 +++
 arch/x86/events/perf_event.h                  |   2 +
 include/linux/bpf.h                           |   2 +
 include/linux/filter.h                        |   3 +-
 include/linux/perf_event.h                    |  29 +++++
 include/uapi/linux/bpf.h                      |  16 +++
 kernel/bpf/trampoline.c                       |  11 ++
 kernel/bpf/verifier.c                         |   7 ++
 kernel/events/core.c                          |   3 +
 kernel/trace/bpf_trace.c                      |  38 +++++++
 net/bpf/test_run.c                            |  15 ++-
 tools/include/uapi/linux/bpf.h                |  16 +++
 .../bpf/prog_tests/get_branch_snapshot.c      | 106 ++++++++++++++++++
 .../selftests/bpf/progs/get_branch_snapshot.c |  41 +++++++
 tools/testing/selftests/bpf/trace_helpers.c   |  30 +++++
 tools/testing/selftests/bpf/trace_helpers.h   |   5 +
 17 files changed, 339 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_branch_snaps=
hot.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_branch_snapshot.c

--
2.30.2
