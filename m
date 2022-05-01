Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E2451673B
	for <lists+bpf@lfdr.de>; Sun,  1 May 2022 21:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbiEATDk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 May 2022 15:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbiEATDk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 May 2022 15:03:40 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830F5CC6
        for <bpf@vger.kernel.org>; Sun,  1 May 2022 12:00:11 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 241BROOF018144
        for <bpf@vger.kernel.org>; Sun, 1 May 2022 12:00:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=wPWRJzzxUm6c6pJHOQzdmkURwY+caD5uck1vZBYpwY4=;
 b=huujT0mog9JAs+V4VX6kYCzCKKLfLtT/IiTORVmQS0FaAsSBr9VcOgEHpDp4u2w2bwmL
 oWsFpI9mlBG2cXq8f/xg1JMhUaZKAC3s4YLsLNR1qflQnF/Cg78g+6HWqvJ71/xbBfGF
 sV2Fy4gweuh+GsYGTQp/Vf7RDKjJpl2W7RE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fs2uxnjt7-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 01 May 2022 12:00:10 -0700
Received: from twshared8508.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 1 May 2022 12:00:09 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 237F19C01EE2; Sun,  1 May 2022 12:00:02 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 00/12] bpf: Add 64bit enum value support
Date:   Sun, 1 May 2022 12:00:02 -0700
Message-ID: <20220501190002.2576452-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0JXeIOJ1pqq3HPjqgzmOeIns9VjMflnC
X-Proofpoint-GUID: 0JXeIOJ1pqq3HPjqgzmOeIns9VjMflnC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-01_07,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, btf only supports upto 32bit enum value with BTF_KIND_ENUM.
But in kernel, some enum has 64bit values, e.g., in uapi bpf.h, we have
  enum {
        BPF_F_INDEX_MASK                =3D 0xffffffffULL,
        BPF_F_CURRENT_CPU               =3D BPF_F_INDEX_MASK,
        BPF_F_CTXLEN_MASK               =3D (0xfffffULL << 32),
  };
With BTF_KIND_ENUM, the value for BPF_F_CTXLEN_MASK will be encoded
as 0 which is incorrect.

To solve this problem, BTF_KIND_ENUM64 is proposed in this patch set
to support enum 64bit values. Also, since sometimes there is a need
to generate C code from btf, e.g., vmlinux.h, btf kflag support
is also added for BTF_KIND_ENUM and BTF_KIND_ENUM64, which will
permit proper value printout, signed or unsigned.

In the rest of this patch set, Patch #1 added kernel support,
Patches #2 - #4 for libbpf, Patch #5 for bpftool. Patches #6 - #11
are for various selftests, and Patch #12 added BTF_KIND_ENUM64
in btf documentation.

Yonghong Song (12):
  bpf: Add btf enum64 support
  libbpf: Permit 64bit relocation value
  libbpf: Fix an error in 64bit relocation value computation
  libbpf: Add btf enum64 support
  bpftool: Add btf enum64 support
  selftests/bpf: Fix selftests failure
  selftests/bpf: Test new libbpf enum32/enum64 API functions
  selftests/bpf: Add BTF_KIND_ENUM64 unit tests
  selftests/bpf: Test BTF_KIND_ENUM64 for deduplication
  selftests/bpf: add a test for enum64 value relocation
  selftests/bpf: Clarify llvm dependency with possible selftest failures
  docs/bpf: Update documentation for BTF_KIND_ENUM64 support

 Documentation/bpf/btf.rst                     |  34 ++-
 include/linux/btf.h                           |  18 +-
 include/uapi/linux/btf.h                      |  17 +-
 kernel/bpf/btf.c                              | 132 +++++++++-
 tools/bpf/bpftool/btf.c                       |  47 +++-
 tools/bpf/bpftool/btf_dumper.c                |  32 +++
 tools/bpf/bpftool/gen.c                       |   1 +
 tools/include/uapi/linux/btf.h                |  17 +-
 tools/lib/bpf/btf.c                           | 226 +++++++++++++++++-
 tools/lib/bpf/btf.h                           |  21 ++
 tools/lib/bpf/btf_dump.c                      |  94 ++++++--
 tools/lib/bpf/libbpf.c                        |  64 ++++-
 tools/lib/bpf/libbpf.map                      |   4 +
 tools/lib/bpf/libbpf_internal.h               |   2 +
 tools/lib/bpf/linker.c                        |   2 +
 tools/lib/bpf/relo_core.c                     | 119 +++++----
 tools/lib/bpf/relo_core.h                     |   4 +-
 tools/testing/selftests/bpf/README.rst        |  18 ++
 tools/testing/selftests/bpf/btf_helpers.c     |  21 +-
 tools/testing/selftests/bpf/prog_tests/btf.c  | 128 ++++++++--
 .../selftests/bpf/prog_tests/btf_dump.c       |  10 +-
 .../selftests/bpf/prog_tests/btf_write.c      | 120 +++++++---
 .../selftests/bpf/prog_tests/core_reloc.c     |  43 ++++
 .../bpf/progs/btf__core_reloc_enum64val.c     |   3 +
 .../progs/btf__core_reloc_enum64val___diff.c  |   3 +
 .../btf__core_reloc_enum64val___err_missing.c |   3 +
 ...btf__core_reloc_enum64val___val3_missing.c |   3 +
 .../bpf/progs/btf_dump_test_case_syntax.c     |   2 +-
 .../selftests/bpf/progs/core_reloc_types.h    |  47 ++++
 .../bpf/progs/test_core_reloc_enum64val.c     |  53 ++++
 tools/testing/selftests/bpf/test_btf.h        |   1 +
 31 files changed, 1126 insertions(+), 163 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
m64val.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
m64val___diff.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
m64val___err_missing.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
m64val___val3_missing.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_enu=
m64val.c

--=20
2.30.2

