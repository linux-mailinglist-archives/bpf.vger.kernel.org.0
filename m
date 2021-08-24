Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B663F57D1
	for <lists+bpf@lfdr.de>; Tue, 24 Aug 2021 08:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhHXGC5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Aug 2021 02:02:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63136 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234519AbhHXGC5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Aug 2021 02:02:57 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17O5uXxH028679
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 23:02:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=lPa7PCjv5m0QXRnNv3eW6sd2bXRA8WEwGpz+psv/Mp8=;
 b=BMyXrx3z1nm8AhXf74cfXejMFaHOvCajb2is9qogqXRnPZKB5Xpq2HzC7S+tt4y4+LLM
 IXSNxncar4ETOijGe+SHCoA3k5Tcl4R89btHfP8zYLRLGHS5v6yhV48BjEqW0Q1jZh/y
 h0i7+21XycdcuezjMJNWQVn3IbEzIc62mpw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3amc6p59hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 23:02:13 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 23 Aug 2021 23:02:12 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 3CF02DDDF76D; Mon, 23 Aug 2021 23:02:06 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next 0/3] bpf: introduce bpf_get_branch_trace
Date:   Mon, 23 Aug 2021 23:01:54 -0700
Message-ID: <20210824060157.3889139-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: Gh_O3UyJF4G2umGTHSWGENozDVeLJbLH
X-Proofpoint-GUID: Gh_O3UyJF4G2umGTHSWGENozDVeLJbLH
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-24_01:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 spamscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=826 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108240039
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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
  bpf: introduce helper bpf_get_branch_trace
  selftests/bpf: add test for bpf_get_branch_trace

 arch/x86/events/intel/core.c                  |   5 +-
 arch/x86/events/intel/lbr.c                   |  12 ++
 arch/x86/events/perf_event.h                  |   2 +
 include/linux/filter.h                        |   3 +-
 include/linux/perf_event.h                    |  33 ++++++
 include/uapi/linux/bpf.h                      |  16 +++
 kernel/bpf/trampoline.c                       |  15 +++
 kernel/bpf/verifier.c                         |   7 ++
 kernel/events/core.c                          |  28 +++++
 kernel/trace/bpf_trace.c                      |  30 +++++
 net/bpf/test_run.c                            |  15 ++-
 tools/include/uapi/linux/bpf.h                |  16 +++
 .../bpf/prog_tests/get_branch_trace.c         | 106 ++++++++++++++++++
 .../selftests/bpf/progs/get_branch_trace.c    |  41 +++++++
 tools/testing/selftests/bpf/trace_helpers.c   |  30 +++++
 tools/testing/selftests/bpf/trace_helpers.h   |   5 +
 16 files changed, 361 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_branch_trace=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_branch_trace.c

--
2.30.2
