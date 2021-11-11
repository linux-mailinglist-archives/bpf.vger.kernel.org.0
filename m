Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573DC44DE74
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 00:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhKKX2j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 18:28:39 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55998 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233119AbhKKX2j (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 18:28:39 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1ABN4BjO004914
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 15:25:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=0oLaYBhKRDf4bdjTdw0X3d9H6KfmgMojg4GwfMtQo5U=;
 b=VbvqRp38lvvLLQ7i+Ra0F6wKuD9PcM7XGCLVVZrZIPWb56Otgg3A0G+APTxQGw8IWvwx
 Xs62AaUAQQBQ5xD8MDQPDnBaUMM+walaYxIsEBRnQwimq3p3XN1ymVxboopz3amYwLkm
 A9F9fIY21MQMlv5H2YRx+hfC9hbmEbOKALg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3c9ca7g6d8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 15:25:48 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 15:25:47 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 314BF24B3D5F; Thu, 11 Nov 2021 15:25:43 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 00/10] Support BTF_KIND_TYPE_TAG for btf_type_tag attributes
Date:   Thu, 11 Nov 2021 15:25:43 -0800
Message-ID: <20211111232543.786041-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: ATHuACFPM-VwXRbUfwSkVBAyFvXjqJj6
X-Proofpoint-GUID: ATHuACFPM-VwXRbUfwSkVBAyFvXjqJj6
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_09,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=681 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111110118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LLVM patches ([1] for clang, [2] and [3] for BPF backend)
added support for btf_type_tag attributes. This patch
added support for the kernel.

The main motivation for btf_type_tag is to bring kernel
annotations __user, __rcu etc. to btf. With such information
available in btf, bpf verifier can detect mis-usages
and reject the program. For example, for __user tagged pointer,
developers can then use proper helper like bpf_probe_read_kernel()
etc. to read the data.

BTF_KIND_TYPE_TAG may also useful for other tracing
facility where instead of to require user to specify
kernel/user address type, the kernel can detect it
by itself with btf.

Patch 1 added support in kernel, Patch 2 for libbpf and Patch 3
for bpftool. Patches 4-9 are for bpf selftests and Patch 10
updated docs/bpf/btf.rst file with new btf kind.

  [1] https://reviews.llvm.org/D111199
  [2] https://reviews.llvm.org/D113222
  [3] https://reviews.llvm.org/D113496

Changelogs:
  v1 -> v2:
    - add more dedup tests
    - remove build requirement for LLVM=3D1
    - remove testing macro __has_attribute in bpf programs
      as it is always defined in recent clang compilers.

Yonghong Song (10):
  bpf: Support BTF_KIND_TYPE_TAG for btf_type_tag attributes
  libbpf: Support BTF_KIND_TYPE_TAG
  bpftool: Support BTF_KIND_TYPE_TAG
  selftests/bpf: Test libbpf API function btf__add_type_tag()
  selftests/bpf: Add BTF_KIND_TYPE_TAG unit tests
  selftests/bpf: Test BTF_KIND_DECL_TAG for deduplication
  selftests/bpf: Rename progs/tag.c to progs/btf_decl_tag.c
  selftests/bpf: Add a C test for btf_type_tag
  selftests/bpf: Clarify llvm dependency with btf_tag selftest
  docs/bpf: Update documentation for BTF_KIND_TYPE_TAG support

 Documentation/bpf/btf.rst                     |  13 +-
 include/uapi/linux/btf.h                      |   3 +-
 kernel/bpf/btf.c                              |  14 +-
 tools/bpf/bpftool/btf.c                       |   2 +
 tools/include/uapi/linux/btf.h                |   3 +-
 tools/lib/bpf/btf.c                           |  23 +++
 tools/lib/bpf/btf.h                           |   9 +-
 tools/lib/bpf/btf_dump.c                      |   9 +
 tools/lib/bpf/libbpf.c                        |  31 +++-
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/lib/bpf/libbpf_internal.h               |   2 +
 tools/testing/selftests/bpf/README.rst        |   9 +-
 tools/testing/selftests/bpf/btf_helpers.c     |   4 +-
 tools/testing/selftests/bpf/prog_tests/btf.c  | 169 +++++++++++++++++-
 .../selftests/bpf/prog_tests/btf_tag.c        |  44 ++++-
 .../selftests/bpf/prog_tests/btf_write.c      |  67 ++++---
 .../bpf/progs/{tag.c =3D> btf_decl_tag.c}       |   4 -
 .../selftests/bpf/progs/btf_type_tag.c        |  25 +++
 tools/testing/selftests/bpf/test_btf.h        |   3 +
 19 files changed, 382 insertions(+), 53 deletions(-)
 rename tools/testing/selftests/bpf/progs/{tag.c =3D> btf_decl_tag.c} (94%)
 create mode 100644 tools/testing/selftests/bpf/progs/btf_type_tag.c

--=20
2.30.2

