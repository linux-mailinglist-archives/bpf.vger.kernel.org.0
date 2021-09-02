Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67133FF1E9
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 18:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346039AbhIBQ6P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 12:58:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56230 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232259AbhIBQ6P (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Sep 2021 12:58:15 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 182GqT9B003533
        for <bpf@vger.kernel.org>; Thu, 2 Sep 2021 09:57:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=JfH3F4h9yjuZY4fXc+F2YZI5k+kzGOzFulOPWefUzpQ=;
 b=lJR7iNr164NtSL64JXfx7hULj5q17cWWnbfMC4p4OQvhPiVTgfO5ZDgfJkenAED3BG47
 Y4SHympPrM8HCGmzfZzbQ765YYu+1qL+olUZUrMkwcHw7v4t+cFgHhxeq/+PPpSInO62
 Hq7iUYOgYjr64x+QSG3XGvzrMNOUHl0Wtmg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3atdyhdc5b-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Sep 2021 09:57:15 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 2 Sep 2021 09:57:14 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id B912CFBB7C45; Thu,  2 Sep 2021 09:57:11 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <kjain@linux.ibm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v5 bpf-next 0/3] bpf: introduce bpf_get_branch_snapshot
Date:   Thu, 2 Sep 2021 09:57:03 -0700
Message-ID: <20210902165706.2812867-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: SmjsLUypbK7SBNra7Mx0BkR9KyDFHkOz
X-Proofpoint-ORIG-GUID: SmjsLUypbK7SBNra7Mx0BkR9KyDFHkOz
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-02_04:2021-09-02,2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 phishscore=0 mlxlogscore=955 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Changes v4 =3D> v5
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
 include/linux/perf_event.h                    |  23 ++++
 include/uapi/linux/bpf.h                      |  22 ++++
 kernel/bpf/trampoline.c                       |   3 +-
 kernel/events/core.c                          |   2 +
 kernel/trace/bpf_trace.c                      |  33 ++++++
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
 18 files changed, 378 insertions(+), 66 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_branch_snaps=
hot.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_branch_snapshot.c

--
2.30.2
