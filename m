Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D6449E67D
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 16:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243100AbiA0PqN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 10:46:13 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61364 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243097AbiA0PqM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Jan 2022 10:46:12 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20RFTWOm014792
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 07:46:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=oU05b/eDaBsykvKyAZBKUGea9+Ifm+nOKR7Z/hsoKcY=;
 b=hgZXbSOIyeDDfvFf3G3Pdzp0vn65qnuyS8vvbPpiuzFSLmMZtosvCPqCefx5Hv0CQR/+
 pKa5Ks4DcsVi0pAnoLX3dy+DZcpGdD7YoCqTWdmiuUdV9BxVz47Vuhs1Bd+SsJGbSla2
 6QcHMtsG5xTKWyYXEkZm9dLKNun3LJ985Zg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dujwbbd6c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 07:46:12 -0800
Received: from twshared3115.02.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 07:46:08 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id B4EB95A22B5F; Thu, 27 Jan 2022 07:45:55 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next v3 0/6] bpf: add __user tagging support in vmlinux BTF
Date:   Thu, 27 Jan 2022 07:45:55 -0800
Message-ID: <20220127154555.650886-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JSOxWdYrwn39TSgaQJzaMD2n7qtxcbJt
X-Proofpoint-ORIG-GUID: JSOxWdYrwn39TSgaQJzaMD2n7qtxcbJt
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201270095
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The __user attribute is currently mainly used by sparse for type checking.
The attribute indicates whether a memory access is in user memory address
space or not. Such information is important during tracing kernel
internal functions or data structures as accessing user memory often
has different mechanisms compared to accessing kernel memory. For example,
the perf-probe needs explicit command line specification to indicate a
particular argument or string in user-space memory ([1], [2], [3]).
Currently, vmlinux BTF is available in kernel with many distributions.
If __user attribute information is available in vmlinux BTF, the explicit
user memory access information from users will not be necessary as
the kernel can figure it out by itself with vmlinux BTF.

Besides the above possible use for perf/probe, another use case is
for bpf verifier. Currently, for bpf BPF_PROG_TYPE_TRACING type of bpf
programs, users can write direct code like
  p->m1->m2
and "p" could be a function parameter. Without __user information in BTF,
the verifier will assume p->m1 accessing kernel memory and will generate
normal loads. Let us say "p" actually tagged with __user in the source
code.  In such cases, p->m1 is actually accessing user memory and direct
load is not right and may produce incorrect result. For such cases,
bpf_probe_read_user() will be the correct way to read p->m1.

To support encoding __user information in BTF, a new attribute
  __attribute__((btf_type_tag("<arbitrary_string>")))
is implemented in clang ([4]). For example, if we have
  #define __user __attribute__((btf_type_tag("user")))
during kernel compilation, the attribute "user" information will
be preserved in dwarf. After pahole converting dwarf to BTF, __user
information will be available in vmlinux BTF and such information
can be used by bpf verifier, perf/probe or other use cases.

Currently btf_type_tag is only supported in clang (>=3D clang14) and
pahole (>=3D 1.23). gcc support is also proposed and under development ([5]=
).

In the rest of patch set, Patch 1 added support of __user btf_type_tag
during compilation. Patch 2 added bpf verifier support to utilize __user
tag information to reject bpf programs not using proper helper to access
user memories. Patches 3-5 are for bpf selftests which demonstrate verifier
can reject direct user memory accesses.

  [1] http://lkml.kernel.org/r/155789874562.26965.10836126971405890891.stgi=
t@devnote2
  [2] http://lkml.kernel.org/r/155789872187.26965.4468456816590888687.stgit=
@devnote2
  [3] http://lkml.kernel.org/r/155789871009.26965.14167558859557329331.stgi=
t@devnote2
  [4] https://reviews.llvm.org/D111199
  [5] https://lore.kernel.org/bpf/0cbeb2fb-1a18-f690-e360-24b1c90c2a91@fb.c=
om/
=20=20
Changelog:
  v2 -> v3:
    - remove FLAG_DONTCARE enumerator and just use 0 as dontcare flag.
    - explain how btf type_tag is encoded in btf type chain.
  v1 -> v2:
    - use MEM_USER flag for PTR_TO_BTF_ID reg type instead of a separate
      field to encode __user tag.
    - add a test with kernel function __sys_getsockname which has __user ta=
gged
      argument.

Yonghong Song (6):
  compiler_types: define __user as __attribute__((btf_type_tag("user")))
  bpf: reject program if a __user tagged memory accessed in kernel way
  selftests/bpf: rename btf_decl_tag.c to test_btf_decl_tag.c
  selftests/bpf: add a selftest with __user tag
  selftests/bpf: specify pahole version requirement for btf_tag test
  docs/bpf: clarify how btf_type_tag gets encoded in the type chain

 Documentation/bpf/btf.rst                     |  13 +++
 include/linux/bpf.h                           |   9 +-
 include/linux/btf.h                           |   5 +
 include/linux/compiler_types.h                |   3 +
 kernel/bpf/btf.c                              |  34 ++++--
 kernel/bpf/verifier.c                         |  35 ++++--
 lib/Kconfig.debug                             |   8 ++
 net/bpf/bpf_dummy_struct_ops.c                |   6 +-
 net/ipv4/bpf_tcp_ca.c                         |   6 +-
 tools/testing/selftests/bpf/README.rst        |   2 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  18 ++++
 .../selftests/bpf/prog_tests/btf_tag.c        | 101 +++++++++++++++++-
 .../selftests/bpf/progs/btf_type_tag_user.c   |  40 +++++++
 .../{btf_decl_tag.c =3D> test_btf_decl_tag.c}   |   0
 14 files changed, 252 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/btf_type_tag_user.c
 rename tools/testing/selftests/bpf/progs/{btf_decl_tag.c =3D> test_btf_dec=
l_tag.c} (100%)

--=20
2.30.2

