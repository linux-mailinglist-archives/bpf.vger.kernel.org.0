Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4020544BB00
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 06:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhKJFWk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 00:22:40 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59976 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229493AbhKJFWj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Nov 2021 00:22:39 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AA54GNI013699
        for <bpf@vger.kernel.org>; Tue, 9 Nov 2021 21:19:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=s2+WCEnOjGzPd0Z5BesDiedZ6AaDgOZtJA2HV4qxcVo=;
 b=eBlvu0GBbg/9omBweyFwolrbYxbU5eAsm/zfm1xy5AcJFMSlH9pYNEI03SLf/Qq0zRTo
 FNqarx5RvNCsM39hEB586ihMOdzk/CcbXW/F0MT/qsqTzwQ1QzC6JNopkGR2klo+oM++
 HYobrnq78acFbOA2kFI8rMwol7MqSVTmglQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c7vm9mer4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 21:19:52 -0800
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 9 Nov 2021 21:19:51 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id D2D332361123; Tue,  9 Nov 2021 21:19:40 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next 00/10] Support BTF_KIND_TYPE_TAG for btf_type_tag attributes
Date:   Tue, 9 Nov 2021 21:19:40 -0800
Message-ID: <20211110051940.367472-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: IzN9ypbH_1C_MS05DC6KO15nJ18Ynay7
X-Proofpoint-ORIG-GUID: IzN9ypbH_1C_MS05DC6KO15nJ18Ynay7
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_01,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 phishscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=676 spamscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111100024
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

 Documentation/bpf/btf.rst                     | 13 +++-
 include/uapi/linux/btf.h                      |  3 +-
 kernel/bpf/btf.c                              | 14 +++-
 tools/bpf/bpftool/btf.c                       |  2 +
 tools/include/uapi/linux/btf.h                |  3 +-
 tools/lib/bpf/btf.c                           | 23 +++++++
 tools/lib/bpf/btf.h                           |  9 ++-
 tools/lib/bpf/btf_dump.c                      |  9 +++
 tools/lib/bpf/libbpf.c                        | 31 ++++++++-
 tools/lib/bpf/libbpf.map                      |  1 +
 tools/lib/bpf/libbpf_internal.h               |  2 +
 tools/testing/selftests/bpf/README.rst        |  9 +--
 tools/testing/selftests/bpf/btf_helpers.c     |  4 +-
 tools/testing/selftests/bpf/prog_tests/btf.c  | 64 ++++++++++++++++--
 .../selftests/bpf/prog_tests/btf_tag.c        | 44 ++++++++++--
 .../selftests/bpf/prog_tests/btf_write.c      | 67 +++++++++++--------
 .../bpf/progs/{tag.c =3D> btf_decl_tag.c}       |  0
 .../selftests/bpf/progs/btf_type_tag.c        | 29 ++++++++
 tools/testing/selftests/bpf/test_btf.h        |  3 +
 19 files changed, 281 insertions(+), 49 deletions(-)
 rename tools/testing/selftests/bpf/progs/{tag.c =3D> btf_decl_tag.c} (100%)
 create mode 100644 tools/testing/selftests/bpf/progs/btf_type_tag.c

--=20
2.30.2

