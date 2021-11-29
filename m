Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B87F4625C9
	for <lists+bpf@lfdr.de>; Mon, 29 Nov 2021 23:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbhK2WnT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 17:43:19 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39558 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234484AbhK2Wmm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 29 Nov 2021 17:42:42 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1ATIlB4x032204
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 14:39:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=pr0VB0oy4MQhVPuDiKPO7NJLtAuY/ihjJS5dz6mCwXc=;
 b=oRitHy8gAaXWIm6HmjMrAWog2RyGE9eiYnqo4mu9TqzZz72R9tdlZAtmRd4LtiU9WjWx
 bt5hYo1WbyOuEy3ULp6a+kNj/YJ42uc03HhHt5qOWnbOKdI9jmbcbgTHNvUxb/ufFVYb
 KVIY1jOvuk3dUy0vLRaKn29qbyiTl9uTni0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3cmna6778n-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 14:39:20 -0800
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 14:39:07 -0800
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 236B9570A522; Mon, 29 Nov 2021 14:39:00 -0800 (PST)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <Kernel-team@fb.com>, Joanne Koong <joannekoong@fb.com>
Subject: [PATCH v3 bpf-next 0/4] Add bpf_loop helper
Date:   Mon, 29 Nov 2021 14:37:21 -0800
Message-ID: <20211129223725.2770730-1-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-FB-Source: Intern
X-Proofpoint-GUID: GxmJIiu1Ma5Zuz7e2cUdVVxF8ynmfTzc
X-Proofpoint-ORIG-GUID: GxmJIiu1Ma5Zuz7e2cUdVVxF8ynmfTzc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_11,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=645
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0
 mlxscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111290107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset add a new helper, bpf_loop.

One of the complexities of using for loops in bpf programs is that the ve=
rifier
needs to ensure that in every possibility of the loop logic, the loop wil=
l always
terminate. As such, there is a limit on how many iterations the loop can =
do.

The bpf_loop helper moves the loop logic into the kernel and can thereby
guarantee that the loop will always terminate. The bpf_loop helper simpli=
fies
a lot of the complexity the verifier needs to check, as well as removes t=
he
constraint on the number of loops able to be run.

From the test results, we see that using bpf_loop in place
of the traditional for loop led to a decrease in verification time
and number of bpf instructions by ~99%. The benchmark results show
that as the number of iterations increases, the overhead per iteration
decreases.

The high-level overview of the patches -
Patch 1 - kernel-side + API changes for adding bpf_loop
Patch 2 - tests
Patch 3 - use bpf_loop in strobemeta + pyperf600 and measure verifier per=
formance
Patch 4 - benchmark for throughput + latency of bpf_loop call

v2 -> v3:
~ Rerun benchmarks on physical machine, update results
~ Propagate original error codes in the verifier

v1 -> v2:
~ Change helper name to bpf_loop (instead of bpf_for_each)
~ Set max nr_loops (~8 million loops) for bpf_loop call
~ Split tests + strobemeta/pyperf600 changes into two patches
~ Add new ops_report_final helper for outputting throughput and latency


Joanne Koong (4):
  bpf: Add bpf_loop helper
  selftests/bpf: Add bpf_loop test
  selftests/bpf: measure bpf_loop verifier performance
  selftest/bpf/benchs: add bpf_loop benchmark

 include/linux/bpf.h                           |   1 +
 include/uapi/linux/bpf.h                      |  25 ++++
 kernel/bpf/bpf_iter.c                         |  35 +++++
 kernel/bpf/helpers.c                          |   2 +
 kernel/bpf/verifier.c                         |  88 ++++++-----
 tools/include/uapi/linux/bpf.h                |  25 ++++
 tools/testing/selftests/bpf/Makefile          |   4 +-
 tools/testing/selftests/bpf/bench.c           |  37 +++++
 tools/testing/selftests/bpf/bench.h           |   2 +
 .../selftests/bpf/benchs/bench_bpf_loop.c     | 105 +++++++++++++
 .../bpf/benchs/run_bench_bpf_loop.sh          |  15 ++
 .../selftests/bpf/benchs/run_common.sh        |  15 ++
 .../selftests/bpf/prog_tests/bpf_loop.c       | 138 ++++++++++++++++++
 .../bpf/prog_tests/bpf_verif_scale.c          |  12 ++
 tools/testing/selftests/bpf/progs/bpf_loop.c  |  99 +++++++++++++
 .../selftests/bpf/progs/bpf_loop_bench.c      |  26 ++++
 tools/testing/selftests/bpf/progs/pyperf.h    |  71 ++++++++-
 .../selftests/bpf/progs/pyperf600_bpf_loop.c  |   6 +
 .../testing/selftests/bpf/progs/strobemeta.h  |  75 +++++++++-
 .../selftests/bpf/progs/strobemeta_bpf_loop.c |   9 ++
 20 files changed, 751 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_loop.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bpf_loop=
.sh
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_loop.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_loop.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_loop_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/pyperf600_bpf_loop.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/strobemeta_bpf_loop=
.c

--=20
2.30.2

