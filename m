Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D141CA4BF
	for <lists+bpf@lfdr.de>; Fri,  8 May 2020 09:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEHHGF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 May 2020 03:06:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54974 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbgEHHGF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 May 2020 03:06:05 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048762ju020938
        for <bpf@vger.kernel.org>; Fri, 8 May 2020 00:06:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=baFpFbIDHaKMImJSdN+7dpCGgUiU8qjtIMJ347QphjM=;
 b=hjzUswQNPhbI4djz9GFbmaNGAWp550U/UPWZ/OOVA8KXVgKdbQeWtqjcZZVVkRyo+uHY
 JiNYr0WEf5VCMAy/joeFAw6+URdIiiDOok86S8EaWJ9+TY0IJzAFLibT5ilVJoJE7uIc
 OX/5KXygAJnfhpMlxgS7s7aRX0yzVPOitwU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30vtdfa52w-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 08 May 2020 00:06:04 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 8 May 2020 00:05:55 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id B34052EC3844; Fri,  8 May 2020 00:05:49 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/3] Add benchmark runner and few benchmarks
Date:   Fri, 8 May 2020 00:05:45 -0700
Message-ID: <20200508070548.2358701-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_08:2020-05-07,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 suspectscore=8 mlxlogscore=999 clxscore=1015 phishscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080061
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add generic benchmark runner framework which simplifies writing various
performance benchmarks in a consistent fashion.  This framework will be u=
sed
in follow up patches to test performance of perf buffer and ring buffer a=
s
well.

Patch #1 adds generic runner implementation and atomic counter benchmarks=
 to
validate benchmark runner's behavior.

Patch #2 implements test_overhead benchmark as part of bench runner. It a=
lso
add fmod_ret BPF program type to a set of benchmarks.

Patch #3 tests faster alternatives to set_task_comm() approach, tested in
test_overhead, in search for minimal-overhead way to trigger BPF program
execution from user-space on demand.

Andrii Nakryiko (3):
  selftests/bpf: add benchmark runner infrastructure
  selftest/bpf: fmod_ret prog and implement test_overhead as part of
    bench
  selftest/bpf: add BPF triggring benchmark

 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |  15 +-
 tools/testing/selftests/bpf/bench.c           | 390 ++++++++++++++++++
 tools/testing/selftests/bpf/bench.h           |  74 ++++
 tools/testing/selftests/bpf/bench_count.c     |  91 ++++
 tools/testing/selftests/bpf/bench_rename.c    | 195 +++++++++
 tools/testing/selftests/bpf/bench_trigger.c   | 167 ++++++++
 .../selftests/bpf/prog_tests/test_overhead.c  |  14 +-
 .../selftests/bpf/progs/test_overhead.c       |   6 +
 .../selftests/bpf/progs/trigger_bench.c       |  47 +++
 10 files changed, 998 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bench.c
 create mode 100644 tools/testing/selftests/bpf/bench.h
 create mode 100644 tools/testing/selftests/bpf/bench_count.c
 create mode 100644 tools/testing/selftests/bpf/bench_rename.c
 create mode 100644 tools/testing/selftests/bpf/bench_trigger.c
 create mode 100644 tools/testing/selftests/bpf/progs/trigger_bench.c

--=20
2.24.1

