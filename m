Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651EC4551F7
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 02:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240889AbhKRBJn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 20:09:43 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43722 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237831AbhKRBJn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Nov 2021 20:09:43 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHLeBeb027342
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 17:06:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=CgADUzvfbbIMHduO3Dzu9j6EFtkKl6CAlsf4noW2/qY=;
 b=P8W/qQfhfbBqyz5fzSQ/dQbEK+h7Q8ZpyNRAwdjtRIiFnh/b6tzsXsNcbwswNxM92Vzz
 I09yIx/OJ2z1Ra0lW0mLdkTw76JyYFkk1hcF7KgkQAg+reCbs5RPek9ntxYJH3grRoay
 g5lq0sh2Z1CGXsGrY1UjdvhCF4baCOsu3d0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cd4bxc6rn-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 17:06:43 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 17 Nov 2021 17:06:41 -0800
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id DF8F94F5FABD; Wed, 17 Nov 2021 17:06:37 -0800 (PST)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>,
        Joanne Koong <joannekoong@fb.com>
Subject: [PATCH bpf-next 0/3] Add bpf_for_each helper
Date:   Wed, 17 Nov 2021 17:04:01 -0800
Message-ID: <20211118010404.2415864-1-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-FB-Source: Intern
X-Proofpoint-GUID: 6D2Fo10ZSyqW45OuWQjrYb76t6yRhhru
X-Proofpoint-ORIG-GUID: 6D2Fo10ZSyqW45OuWQjrYb76t6yRhhru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_09,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 mlxlogscore=530 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset add a new helper, bpf_for_each.

One of the complexities of using for loops in bpf programs is that the ve=
rifier
needs to ensure that in every possibility of the loop logic, the loop wil=
l always
terminate. As such, there is a limit on how many iterations the loop can =
do.

The bpf_for_each helper moves the loop logic into the kernel and can ther=
eby
guarantee that the loop will always terminate. The bpf_for_each helper si=
mplifies
a lot of the complexity the verifier needs to check, as well as removes t=
he
constraint on the number of loops able to be run.

From the test results, we see that using bpf_for_each in place
of the traditional for loop led to a decrease in verification time
and number of bpf instructions by 100%. The benchmark results show
that as the number of iterations increases, the overhead per iteration
decreases.

The high-level overview of the patches -
Patch 1 - kernel-side + API changes for adding bpf_for_each
Patch 2 - tests
Patch 3 - benchmark for overhead of a bpf_for_each call


Joanne Koong (3):
  bpf: Add bpf_for_each helper
  selftests/bpf: Add tests for bpf_for_each
  selftest/bpf/benchs: add bpf_for_each benchmark

 include/linux/bpf.h                           |   1 +
 include/uapi/linux/bpf.h                      |  23 ++++
 kernel/bpf/bpf_iter.c                         |  32 ++++++
 kernel/bpf/helpers.c                          |   2 +
 kernel/bpf/verifier.c                         |  28 +++++
 tools/include/uapi/linux/bpf.h                |  23 ++++
 tools/testing/selftests/bpf/Makefile          |   3 +-
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_for_each.c     | 105 ++++++++++++++++++
 .../bpf/benchs/run_bench_for_each.sh          |  16 +++
 .../bpf/prog_tests/bpf_verif_scale.c          |  12 ++
 .../selftests/bpf/prog_tests/for_each.c       |  61 ++++++++++
 .../selftests/bpf/progs/for_each_helper.c     |  82 ++++++++++++++
 tools/testing/selftests/bpf/progs/pyperf.h    |  70 +++++++++++-
 .../selftests/bpf/progs/pyperf600_foreach.c   |   5 +
 .../testing/selftests/bpf/progs/strobemeta.h  |  73 +++++++++++-
 .../selftests/bpf/progs/strobemeta_foreach.c  |   9 ++
 17 files changed, 544 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_for_each.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_for_each=
.sh
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_helper.c
 create mode 100644 tools/testing/selftests/bpf/progs/pyperf600_foreach.c
 create mode 100644 tools/testing/selftests/bpf/progs/strobemeta_foreach.=
c

--=20
2.30.2

