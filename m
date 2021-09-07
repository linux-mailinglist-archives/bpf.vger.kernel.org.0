Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C4340314E
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 01:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhIGXCF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 19:02:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49252 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347179AbhIGXCE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 19:02:04 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187N0a2T013609
        for <bpf@vger.kernel.org>; Tue, 7 Sep 2021 16:00:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=/eZ5kR0uSmkHCJRofC3ZT7ZAv1VQ/7MufA8qXSIfSRA=;
 b=bXXlBc+I8Vzv2cPNZpDi0YSaEEejEgmNViI1c6F0K1RiQUtg0vpSIYc03tKx/6/SLz4l
 VEzqICpjLYrLvv7zzXqYUOqoV46Uf4SCSo16IJtADXtNvn+mR0/63A4zZ/niHvR+K2tv
 jtujcJF72kuM9nUh+aO6w1Qwj35YWwb+bbI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcqfj7xh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 16:00:57 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 16:00:55 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 0E4A76E0C022; Tue,  7 Sep 2021 16:00:50 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/9] bpf: add support for new btf kind BTF_KIND_TAG
Date:   Tue, 7 Sep 2021 16:00:49 -0700
Message-ID: <20210907230050.1957493-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: vH0BFktLVBqHTNLhgXsQQIGwYW_gakg4
X-Proofpoint-GUID: vH0BFktLVBqHTNLhgXsQQIGwYW_gakg4
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_08:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 mlxlogscore=693 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109070145
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LLVM14 added support for a new C attribute ([1])
  __attribute__((btf_tag("arbitrary_str")))
This attribute will be emitted to dwarf ([2]) and pahole
will convert it to BTF. Or for bpf target, this
attribute will be emitted to BTF directly ([3]).
The attribute is intended to provide additional
information for
  - struct/union type or struct/union member
  - static/global variables
  - static/global function or function parameter.

This new attribute can be used to add attributes
to kernel codes, e.g., pre- or post- conditions,
allow/deny info, or any other info in which only
the kernel is interested. Such attributes will
be processed by clang frontend and emitted to
dwarf, converting to BTF by pahole. Ultimiately
the verifier can use these information for
verification purpose.

The new attribute can also be used for bpf
programs, e.g., tagging with __user attributes
for function parameters, specifying global
function preconditions, etc. Such information
may help verifier to detect user program
bugs.

After this series, pahole dwarf->btf converter
will be enhanced to support new llvm tag
for btf_tag attribute. With pahole support,
we will then try to add a few real use case,
e.g., __user/__rcu tagging, allow/deny list,
some kernel function precondition, etc,
in the kernel.

In the rest of the series, Patch 1 had
kernel support. Patches 2-3 added
libbpf support. Patch 4 added bpftool
support. Patch 5-8 added various selftests.
Patch 9 added documentation for the new kind.

  [1] https://reviews.llvm.org/D106614
  [2] https://reviews.llvm.org/D106621
  [3] https://reviews.llvm.org/D106622

Yonghong Song (9):
  bpf: support for new btf kind BTF_KIND_TAG
  libbpf: rename btf_{hash,equal}_int to btf_{hash,equal}_int_tag
  libbpf: add support for BTF_KIND_TAG
  bpftool: add support for BTF_KIND_TAG
  selftests/bpf: test libbpf API function btf__add_tag()
  selftests/bpf: add BTF_KIND_TAG unit tests
  selftests/bpf: test BTF_KIND_TAG for deduplication
  selftests/bpf: add a test with a bpf program with btf_tag attributes
  docs/bpf: add documentation for BTF_KIND_TAG

 Documentation/bpf/btf.rst                     |  30 +-
 include/uapi/linux/btf.h                      |  15 +-
 kernel/bpf/btf.c                              | 115 +++++++
 tools/bpf/bpftool/btf.c                       |  18 +
 tools/include/uapi/linux/btf.h                |  15 +-
 tools/lib/bpf/btf.c                           |  77 ++++-
 tools/lib/bpf/btf.h                           |  13 +
 tools/lib/bpf/btf_dump.c                      |   3 +
 tools/lib/bpf/libbpf.c                        |  31 +-
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/lib/bpf/libbpf_internal.h               |   2 +
 tools/testing/selftests/bpf/btf_helpers.c     |   7 +-
 tools/testing/selftests/bpf/prog_tests/btf.c  | 314 +++++++++++++++++-
 .../selftests/bpf/prog_tests/btf_tag.c        |  14 +
 .../selftests/bpf/prog_tests/btf_write.c      |  23 ++
 tools/testing/selftests/bpf/progs/tag.c       |  39 +++
 tools/testing/selftests/bpf/test_btf.h        |   6 +
 17 files changed, 686 insertions(+), 37 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_tag.c
 create mode 100644 tools/testing/selftests/bpf/progs/tag.c

--=20
2.30.2

