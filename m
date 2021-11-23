Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FE445AB4E
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 19:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbhKWShj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 13:37:39 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45472 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238991AbhKWShj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 13:37:39 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1ANGTjOZ022785
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 10:34:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=yW5P0kp4PoxHVzjM73dJtvjrt4icaPG2wHRgl8enhNg=;
 b=Q49E4FrZSdFP6N0BfSEUMj2PFoITOYGvLu94obHA64XK33qqRCEUi0G1tnSJSlLnRHw6
 k0Opa5P/FeEYZOoGVjyMoRCZWgKpfkaFzEbBm3uaSCm86hjeQcdt3I0eCl4eHrqjOzEB
 ZM9IHLx07eoCnrJXLMIq4jl+o5L/VFzm4q8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3ch3v50yaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 10:34:30 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 23 Nov 2021 10:34:29 -0800
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id E00DB533D29F; Tue, 23 Nov 2021 10:34:21 -0800 (PST)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <Kernel-team@fb.com>, Joanne Koong <joannekoong@fb.com>
Subject: [PATCH v2 bpf-next 0/4] Add bpf_loop_helper
Date:   Tue, 23 Nov 2021 10:34:05 -0800
Message-ID: <20211123183409.3599979-1-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 5J37OjtY54gCnIvylGs1waNqNKBzVjkV
X-Proofpoint-GUID: 5J37OjtY54gCnIvylGs1waNqNKBzVjkV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_06,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=592 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111230090
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
and number of bpf instructions by 100%. The benchmark results show
that as the number of iterations increases, the overhead per iteration
decreases.

The high-level overview of the patches -
Patch 1 - kernel-side + API changes for adding bpf_loop
Patch 2 - tests
Patch 3 - use bpf_loop in strobemeta + pyperf600 and measure verifier per=
formance
Patch 4 - benchmark for throughput + latency of bpf_loop call

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
 kernel/bpf/verifier.c                         |  97 +++++++-----
 tools/include/uapi/linux/bpf.h                |  25 ++++
 tools/testing/selftests/bpf/Makefile          |   4 +-
 tools/testing/selftests/bpf/bench.c           |  26 ++++
 tools/testing/selftests/bpf/bench.h           |   1 +
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
 20 files changed, 745 insertions(+), 42 deletions(-)
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

