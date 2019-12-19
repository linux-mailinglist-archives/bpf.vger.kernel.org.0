Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3FD125C33
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 08:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfLSHpn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 02:45:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52524 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbfLSHpm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Dec 2019 02:45:42 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJ7efqV013436
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 23:45:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=UnJdQGO+RyHYsL8UiXgCY7P/R2giOX77rGChm1iO5q4=;
 b=ihm3Q8yivsl3jqIpn0keRwmFw0Z/wgy2jOxsdP4kjSWXIz8mHbInyKZ56NDAJterGbUe
 C5/4IB96xGxBFrY60b/6choyqklVJF42dRvfQZzxFD/kJjzjviQ+QF4421SmkeMVD0Xg
 D42wiEPxEGlSa8eUqzHO/bLo/0mWW+k6NHk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wyqv4khn5-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 23:45:41 -0800
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 18 Dec 2019 23:45:07 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id AFEB937138B6; Wed, 18 Dec 2019 23:45:06 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <andriin@fb.com>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v4 bpf-next 0/6] bpf: Support replacing cgroup-bpf program in MULTI mode
Date:   Wed, 18 Dec 2019 23:44:32 -0800
Message-ID: <cover.1576741281.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_08:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=624 mlxscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=13 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190065
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v3->v4:
- use OPTS_VALID and OPTS_GET to handle bpf_prog_attach_opts.

v2->v3:
- rely on DECLARE_LIBBPF_OPTS from libbpf_common.h;
- separate "required" and "optional" arguments in bpf_prog_attach_xattr;
- convert test_cgroup_attach to prog_tests;
- move the new selftest to prog_tests/cgroup_attach_multi.

v1->v2:
- move DECLARE_LIBBPF_OPTS from libbpf.h to bpf.h (patch 4);
- switch new libbpf API to OPTS framework;
- switch selftest to libbpf OPTS framework.

This patch set adds support for replacing cgroup-bpf programs attached with
BPF_F_ALLOW_MULTI flag so that any program in a list can be updated to a new
version without service interruption and order of programs can be preserved.

Please see patch 3 for details on the use-case and API changes.

Other patches:
Patch 1 is preliminary refactoring of __cgroup_bpf_attach to simplify it.
Patch 2 is minor cleanup of hierarchy_allows_attach.
Patch 4 extends libbpf API to support new set of attach attributes.
Patch 5 converts test_cgroup_attach to prog_tests.
Patch 6 adds selftest coverage for the new API.


Andrey Ignatov (6):
  bpf: Simplify __cgroup_bpf_attach
  bpf: Remove unused new_flags in hierarchy_allows_attach()
  bpf: Support replacing cgroup-bpf program in MULTI mode
  libbpf: Introduce bpf_prog_attach_xattr
  selftests/bpf: Convert test_cgroup_attach to prog_tests
  selftests/bpf: Test BPF_F_REPLACE in cgroup_attach_multi

 include/linux/bpf-cgroup.h                    |   4 +-
 include/uapi/linux/bpf.h                      |  10 +
 kernel/bpf/cgroup.c                           |  97 +--
 kernel/bpf/syscall.c                          |   4 +-
 kernel/cgroup/cgroup.c                        |   5 +-
 tools/include/uapi/linux/bpf.h                |  10 +
 tools/lib/bpf/bpf.c                           |  17 +-
 tools/lib/bpf/bpf.h                           |  11 +
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/testing/selftests/bpf/.gitignore        |   1 -
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../bpf/prog_tests/cgroup_attach_autodetach.c | 111 ++++
 .../bpf/prog_tests/cgroup_attach_multi.c      | 285 +++++++++
 .../bpf/prog_tests/cgroup_attach_override.c   | 148 +++++
 .../selftests/bpf/test_cgroup_attach.c        | 571 ------------------
 15 files changed, 652 insertions(+), 626 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
 delete mode 100644 tools/testing/selftests/bpf/test_cgroup_attach.c

-- 
2.17.1

