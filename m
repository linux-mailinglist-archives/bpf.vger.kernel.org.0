Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B775153F60A
	for <lists+bpf@lfdr.de>; Tue,  7 Jun 2022 08:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbiFGG0M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jun 2022 02:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiFGG0L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jun 2022 02:26:11 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FEAC967B
        for <bpf@vger.kernel.org>; Mon,  6 Jun 2022 23:26:10 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25751YAv025371
        for <bpf@vger.kernel.org>; Mon, 6 Jun 2022 23:26:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=upgppzRVRkYdAWGiSi6geX6HRs6SeDJvbePMMiamEiw=;
 b=kxTmyQs4ggyrgTNoyxClI7SVHRsaOyAi6aD6hmJ8dO9N72zc3vDFtpydwjj0bfUiVb5+
 Dfg3BYrlSm1oFPYKnjts1fSUQHIG7FPAGXcIMpO1exReAli1oJfhcixKhp3nNm0lB4nG
 Vcfb5NhBWbSj3WVTetS0HZWDCJFQ31Ux7Dw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ghy4gggxc-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 06 Jun 2022 23:26:09 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 6 Jun 2022 23:26:08 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id D887BB520EBC; Mon,  6 Jun 2022 23:25:54 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v5 00/17] bpf: Add 64bit enum value support
Date:   Mon, 6 Jun 2022 23:25:54 -0700
Message-ID: <20220607062554.3716237-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WluZwSy4-pxyYZBEicG3XPg-GBOKr5ev
X-Proofpoint-GUID: WluZwSy4-pxyYZBEicG3XPg-GBOKr5ev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-07_02,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
is also added for BTF_KIND_ENUM and BTF_KIND_ENUM64 to indicate
signedness, helping proper value printout.

Changelog:
  v4 -> v5:
    - skip newly-added enum64 C test if clang version <=3D 14.
  v3 -> v4:
    - rename btf_type_is_any_enum() to btf_is_any_enum() to favor
      consistency in libbpf.
    - fix sign extension issue in btf_dump_get_enum_value().
    - fix BPF_CORE_FIELD_SIGNED signedness issue in bpf_core_calc_field_r=
elo().
  v2 -> v3:
    - Implement separate btf_equal_enum()/btf_equal_enum64() and
      btf_compat_enum()/btf_compat_enum64().
    - Add a new enum64 placeholder type dynamicly for enum64 sanitization=
.
    - For bpftool output and unit selftest, printed out signed/unsigned
      encoding as well.
    - fix some issues with BTF_KIND_ENUM is doc and clarified sign extens=
ion
      rules for enum values.
  v1 -> v2:
    - Changed kflag default from signed to unsigned
    - Fixed sanitization issue
    - Broke down libbpf related patches for easier review
    - Added more tests
    - More code refactorization
    - Corresponding llvm patch (to support enum64) is also updated

Yonghong Song (17):
  bpf: Add btf enum64 support
  libbpf: Permit 64bit relocation value
  libbpf: Fix an error in 64bit relocation value computation
  libbpf: Refactor btf__add_enum() for future code sharing
  libbpf: Add enum64 parsing and new enum64 public API
  libbpf: Add enum64 deduplication support
  libbpf: Add enum64 support for btf_dump
  libbpf: Add enum64 sanitization
  libbpf: Add enum64 support for bpf linking
  libbpf: Add enum64 relocation support
  bpftool: Add btf enum64 support
  selftests/bpf: Fix selftests failure
  selftests/bpf: Test new enum kflag and enum64 API functions
  selftests/bpf: Add BTF_KIND_ENUM64 unit tests
  selftests/bpf: Test BTF_KIND_ENUM64 for deduplication
  selftests/bpf: Add a test for enum64 value relocations
  docs/bpf: Update documentation for BTF_KIND_ENUM64 support

 Documentation/bpf/btf.rst                     |  43 +++-
 include/linux/btf.h                           |  28 +++
 include/uapi/linux/btf.h                      |  17 +-
 kernel/bpf/btf.c                              | 142 +++++++++++--
 kernel/bpf/verifier.c                         |   2 +-
 tools/bpf/bpftool/btf.c                       |  57 ++++-
 tools/bpf/bpftool/btf_dumper.c                |  29 +++
 tools/bpf/bpftool/gen.c                       |   1 +
 tools/include/uapi/linux/btf.h                |  17 +-
 tools/lib/bpf/btf.c                           | 201 ++++++++++++++++--
 tools/lib/bpf/btf.h                           |  32 ++-
 tools/lib/bpf/btf_dump.c                      | 137 +++++++++---
 tools/lib/bpf/libbpf.c                        |  63 +++++-
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/lib/bpf/libbpf_internal.h               |   2 +
 tools/lib/bpf/linker.c                        |   2 +
 tools/lib/bpf/relo_core.c                     | 105 +++++----
 tools/lib/bpf/relo_core.h                     |   4 +-
 tools/testing/selftests/bpf/btf_helpers.c     |  25 ++-
 tools/testing/selftests/bpf/prog_tests/btf.c  | 153 +++++++++++--
 .../selftests/bpf/prog_tests/btf_write.c      | 126 ++++++++---
 .../selftests/bpf/prog_tests/core_reloc.c     |  58 +++++
 .../bpf/progs/btf__core_reloc_enum64val.c     |   3 +
 .../progs/btf__core_reloc_enum64val___diff.c  |   3 +
 .../btf__core_reloc_enum64val___err_missing.c |   3 +
 ...btf__core_reloc_enum64val___val3_missing.c |   3 +
 .../selftests/bpf/progs/core_reloc_types.h    |  78 +++++++
 .../bpf/progs/test_core_reloc_enum64val.c     |  70 ++++++
 tools/testing/selftests/bpf/test_btf.h        |   1 +
 29 files changed, 1217 insertions(+), 190 deletions(-)
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

