Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EAE40BB68
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 00:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhINWbe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 18:31:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60492 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235303AbhINWbd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 18:31:33 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18EG1vET032006
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 15:30:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=MQwOndGRH9dXBrJGf+VEPmnDCLO3FXu9r1OFbzexUzQ=;
 b=Wcz4cTKlqmoMj7FucRu7/N0wAWBMo2uZ9s0P6VAaK6nse+bt92eiT0MhD6t1N9XaGBog
 TdrPzA5xfHWzoZdUwoeHCzT7jS+iadQhPef+z7g7HtQkyIR657BKwvw7FppnWXmODpAN
 30+OQT2OG7Rog2lKwSU2Guyn2cs8cnQLZhw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b2kgae5yb-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 15:30:14 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 15:30:09 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 7D42C738213D; Tue, 14 Sep 2021 15:30:04 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 00/11] bpf: add support for new btf kind BTF_KIND_TAG
Date:   Tue, 14 Sep 2021 15:30:04 -0700
Message-ID: <20210914223004.244411-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: TXrx3Lvcv3WGTGryHW8cp9BIJMalnkTR
X-Proofpoint-GUID: TXrx3Lvcv3WGTGryHW8cp9BIJMalnkTR
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_08,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 mlxlogscore=949 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LLVM14 added support for a new C attribute ([1])
  __attribute__((btf_tag("arbitrary_str")))
This attribute will be emitted to dwarf ([2]) and pahole
will convert it to BTF. Or for bpf target, this
attribute will be emitted to BTF directly ([3], [4]).
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

In the rest of the series, Patches 1-2 had
kernel support. Patches 3-4 added
libbpf support. Patch 5 added bpftool
support. Patches 6-10 added various selftests.
Patch 11 added documentation for the new kind.

  [1] https://reviews.llvm.org/D106614
  [2] https://reviews.llvm.org/D106621
  [3] https://reviews.llvm.org/D106622
  [4] https://reviews.llvm.org/D109560

Changelog:
  v2 -> v3:
    - put NR_BTF_KINDS and BTF_KIND_MAX into enum as well
    - check component_idx earlier (check_meta stage) in kernel
    - add more tests
    - fix misc nits
  v1 -> v2:
    - BTF ELF format changed in llvm ([4] above),
      so cross-board change to use the new format.
    - Clarified in commit message that BTF_KIND_TAG
      is not emitted by bpftool btf dump format c.
    - Fix various comments from Andrii.

Yonghong Song (11):
  btf: change BTF_KIND_* macros to enums
  bpf: support for new btf kind BTF_KIND_TAG
  libbpf: rename btf_{hash,equal}_int to btf_{hash,equal}_int_tag
  libbpf: add support for BTF_KIND_TAG
  bpftool: add support for BTF_KIND_TAG
  selftests/bpf: test libbpf API function btf__add_tag()
  selftests/bpf: change NAME_NTH/IS_NAME_NTH for BTF_KIND_TAG format
  selftests/bpf: add BTF_KIND_TAG unit tests
  selftests/bpf: test BTF_KIND_TAG for deduplication
  selftests/bpf: add a test with a bpf program with btf_tag attributes
  docs/bpf: add documentation for BTF_KIND_TAG

 Documentation/bpf/btf.rst                     |  29 +-
 include/uapi/linux/btf.h                      |  55 ++-
 kernel/bpf/btf.c                              | 128 +++++
 tools/bpf/bpftool/btf.c                       |  12 +
 tools/include/uapi/linux/btf.h                |  55 ++-
 tools/lib/bpf/btf.c                           |  84 +++-
 tools/lib/bpf/btf.h                           |  15 +
 tools/lib/bpf/btf_dump.c                      |   3 +
 tools/lib/bpf/libbpf.c                        |  31 +-
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/lib/bpf/libbpf_internal.h               |   2 +
 tools/testing/selftests/bpf/btf_helpers.c     |   7 +-
 tools/testing/selftests/bpf/prog_tests/btf.c  | 441 +++++++++++++++++-
 .../selftests/bpf/prog_tests/btf_tag.c        |  14 +
 .../selftests/bpf/prog_tests/btf_write.c      |  21 +
 tools/testing/selftests/bpf/progs/tag.c       |  39 ++
 tools/testing/selftests/bpf/test_btf.h        |   3 +
 17 files changed, 869 insertions(+), 72 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_tag.c
 create mode 100644 tools/testing/selftests/bpf/progs/tag.c

--=20
2.30.2

