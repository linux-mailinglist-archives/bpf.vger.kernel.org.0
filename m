Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB54F23513F
	for <lists+bpf@lfdr.de>; Sat,  1 Aug 2020 10:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgHAIt6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Aug 2020 04:49:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1350 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726364AbgHAIt5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 1 Aug 2020 04:49:57 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0718fCtd027307
        for <bpf@vger.kernel.org>; Sat, 1 Aug 2020 01:49:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Gv+tkOXzVXQjsvPabJNYiLBu3kZuJsoerkHGvRAK+8g=;
 b=TgjSpmBUbiokaiQ7ep3w3RafLfF4Gzk4d0DnBPDpeiA3lzKB1Oweo+PosIkpeM0ZzCxh
 FPhFfdlRFn/SXfe5I4GBLJ+3+XkZk4wbixRAsn+4KX4opFH+lkveB5FlDUnJGmIXKNm2
 vGk5vq0oMjtlTPmLAjNp7zKRGUbL89frgk4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32m8dyeg66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2020 01:49:56 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 1 Aug 2020 01:49:55 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 757E062E53BD; Sat,  1 Aug 2020 01:47:23 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <brouer@redhat.com>, <dlxu@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/5] introduce BPF_PROG_TYPE_USER
Date:   Sat, 1 Aug 2020 01:47:16 -0700
Message-ID: <20200801084721.1812607-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-01_07:2020-07-31,2020-08-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=383 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008010067
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set introduces a new program type BPF_PROG_TYPE_USER, or "user
program". User program is triggered from user space via
sys_bpf(BPF_PROG_TEST_RUN). User program will replace some uprobe program=
s.
Compared against uprobe, user program has the following advantages:

1. User programs are faster. The new selftest added in 5/5, shows that a
   simple uprobe program takes 1400 nanoseconds, while user program only
   takes 300 nanoseconds.
2. User can specify on which cpu the user program would run.
3. User can pass arguments to the user program.

Song Liu (5):
  bpf: introduce BPF_PROG_TYPE_USER
  libbpf: support BPF_PROG_TYPE_USER programs
  selftests/bpf: add selftest for BPF_PROG_TYPE_USER
  selftests/bpf: move two functions to test_progs.c
  selftests/bpf: add benchmark for uprobe vs. user_prog

 include/linux/bpf_types.h                     |   2 +
 include/uapi/linux/bpf.h                      |  19 +++
 kernel/bpf/syscall.c                          |   3 +-
 kernel/trace/bpf_trace.c                      | 121 ++++++++++++++++++
 tools/include/uapi/linux/bpf.h                |  19 +++
 tools/lib/bpf/bpf.c                           |   1 +
 tools/lib/bpf/bpf.h                           |   3 +
 tools/lib/bpf/libbpf.c                        |   1 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 .../selftests/bpf/prog_tests/attach_probe.c   |  21 ---
 .../selftests/bpf/prog_tests/test_overhead.c  |   8 --
 .../bpf/prog_tests/uprobe_vs_user_prog.c      | 101 +++++++++++++++
 .../selftests/bpf/prog_tests/user_prog.c      |  52 ++++++++
 .../selftests/bpf/progs/uprobe_vs_user_prog.c |  21 +++
 tools/testing/selftests/bpf/progs/user_prog.c |  56 ++++++++
 tools/testing/selftests/bpf/test_progs.c      |  30 +++++
 tools/testing/selftests/bpf/test_progs.h      |   2 +
 17 files changed, 431 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_vs_user=
_prog.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/user_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_vs_user_prog=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_prog.c

--
2.24.1
