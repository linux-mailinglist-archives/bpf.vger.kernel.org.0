Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C344E1BF0F7
	for <lists+bpf@lfdr.de>; Thu, 30 Apr 2020 09:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgD3HPU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Apr 2020 03:15:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44988 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726427AbgD3HPU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 30 Apr 2020 03:15:20 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 03U7CRBL026231
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2020 00:15:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=oHVi5ueKaWuWicwhCYlChyYuDYcyyxOjty+i5W41S+o=;
 b=dCYlVfI4j3MVZgB14/sue3XxPKCYH38TYuhDA/3OhTjMJTHkiSo6y18ZE8ZAT+XZ9ctT
 jRhX5oXUnGQ2+E0AVuN5MQLR7Q9Pdse9Wa6x1KnivhlXwct6sERA3rMoHywE8dKlwYWi
 t7Muv7acI1wmIo+4TE5/jnFskDdoGjFHguk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 30mgvp1226-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2020 00:15:18 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 30 Apr 2020 00:15:17 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id E179B62E4E4F; Thu, 30 Apr 2020 00:15:13 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v9 bpf-next 0/3] bpf: sharing bpf runtime stats with
Date:   Thu, 30 Apr 2020 00:15:03 -0700
Message-ID: <20200430071506.1408910-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_02:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=8 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004300058
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

run_time_ns is a useful stats for BPF programs. However, it is gated by
sysctl kernel.bpf_stats_enabled. When multiple user space tools are
toggling kernl.bpf_stats_enabled at the same time, they may confuse each
other.

Solve this problem with a new BPF command BPF_ENABLE_STATS.

Changes v8 =3D> v9:
  1. Clean up in selftest (Andrii).
  2. Not using static variable in test program (Andrii).

Changes v7 =3D> v8:
  1. Change name BPF_STATS_RUNTIME_CNT =3D> BPF_STATS_RUN_TIME (Alexei).
  2. Add CHECK_ATTR to bpf_enable_stats() (Alexei).
  3. Rebase (Andrii).
  4. Simplfy the selftest (Alexei).

Changes v6 =3D> v7:
  1. Add test to verify run_cnt matches count measured by the program.

Changes v5 =3D> v6:
  1. Simplify test program (Yonghong).
  2. Rebase (with some conflicts).

Changes v4 =3D> v5:
  1. Use memset to zero bpf_attr in bpf_enable_stats() (Andrii).

Changes v3 =3D> v4:
  1. Add libbpf support and selftest;
  2. Avoid cleaning trailing space.

Changes v2 =3D> v3:
  1. Rename the command to BPF_ENABLE_STATS, and make it extendible.
  2. fix commit log;
  3. remove unnecessary headers.

Song Liu (3):
  bpf: sharing bpf runtime stats with BPF_ENABLE_STATS
  libbpf: add support for command BPF_ENABLE_STATS
  bpf: add selftest for BPF_ENABLE_STATS

 include/linux/bpf.h                           |  1 +
 include/uapi/linux/bpf.h                      | 11 ++++
 kernel/bpf/syscall.c                          | 57 +++++++++++++++++++
 kernel/sysctl.c                               | 36 +++++++++++-
 tools/include/uapi/linux/bpf.h                | 11 ++++
 tools/lib/bpf/bpf.c                           | 10 ++++
 tools/lib/bpf/bpf.h                           |  1 +
 tools/lib/bpf/libbpf.map                      |  1 +
 .../selftests/bpf/prog_tests/enable_stats.c   | 45 +++++++++++++++
 .../selftests/bpf/progs/test_enable_stats.c   | 18 ++++++
 10 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/enable_stats.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_enable_stats.c

--
2.24.1
