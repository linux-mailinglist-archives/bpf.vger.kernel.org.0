Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49AAA7B38B
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2019 21:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfG3TyP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jul 2019 15:54:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24506 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725209AbfG3TyP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Jul 2019 15:54:15 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6UJrXKA027191
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2019 12:54:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=ERGL1bEUtIH6hFE9kBVpfz75eUKkjbqgn3ermc94H/Q=;
 b=GkF5eHu1BaqokhE5zScPPVt5foRl/vIk4m7FjlGRluzMdsSXWRW9lnPqQhvo8/ge/eMe
 HpfLIUq7+NhJdCJUADVHBiZn+7oi4kpNZamAQmTrBDcA2ss3HdPYPU5UXUFEgcJG4UkB
 /JrjnX0GSip3YuZxk2CKgdeiKhiEcfcuQYU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u2f53tudf-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2019 12:54:14 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 30 Jul 2019 12:54:12 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 639FF861655; Tue, 30 Jul 2019 12:54:11 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <yhs@fb.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 00/12] CO-RE offset relocations
Date:   Tue, 30 Jul 2019 12:53:56 -0700
Message-ID: <20190730195408.670063-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907300202
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set implements central part of CO-RE (Compile Once - Run
Everywhere, see [0] and [1] for slides and video): relocating fields offsets.
Most of the details are written down as comments to corresponding parts of the
code.

Patch #1 adds loading of .BTF.ext offset relocations section and macros to
work with its contents.
Patch #2 implements CO-RE relocations algorithm in libbpf.
Patch #3 introduced BPF_CORE_READ macro, hiding usage of Clang's
__builtin_preserve_access_index intrinsic that records offset relocation.
Patches #4-#12 adds selftests validating various parts of relocation handling,
type compatibility, etc.

For all tests to work, you'll need latest Clang/LLVM supporting
__builtin_preserve_access_index intrinsic, used for recording offset
relocations. Kernel on which selftests run should have BTF information built
in (CONFIG_DEBUG_INFO_BTF=y).

  [0] http://vger.kernel.org/bpfconf2019.html#session-2
  [1] http://vger.kernel.org/lpc-bpf2018.html#session-2

v1->v2:
- add offsetofend(), fix btf_ext optional fields checks (Song);
- add bpf_core_dump_spec() for logging spec representation;
- move special first element processing out of the loop (Song);
- typo fixes (Song);
- drop BPF_ST | BPF_MEM insn relocation (Alexei);
- extracted BPF_CORE_READ into bpf_helpers (Alexei);
- added extra tests validating Clang capturing relocs correctly (Yonghong);
- switch core_relocs.c to use sub-tests;
- updated mods tests after Clang bug was fixed (Yonghong);
- fix bug enumerating candidate types;

Andrii Nakryiko (12):
  libbpf: add .BTF.ext offset relocation section loading
  libbpf: implement BPF CO-RE offset relocation algorithm
  selftests/bpf: add BPF_CORE_READ relocatable read macro
  selftests/bpf: add CO-RE relocs testing setup
  selftests/bpf: add CO-RE relocs struct flavors tests
  selftests/bpf: add CO-RE relocs nesting tests
  selftests/bpf: add CO-RE relocs array tests
  selftests/bpf: add CO-RE relocs enum/ptr/func_proto tests
  selftests/bpf: add CO-RE relocs modifiers/typedef tests
  selftests/bpf: add CO-RE relocs ptr-as-array tests
  selftests/bpf: add CO-RE relocs ints tests
  selftests/bpf: add CO-RE relocs misc tests

 tools/lib/bpf/btf.c                           |  69 +-
 tools/lib/bpf/btf.h                           |   4 +
 tools/lib/bpf/libbpf.c                        | 915 +++++++++++++++++-
 tools/lib/bpf/libbpf.h                        |   1 +
 tools/lib/bpf/libbpf_internal.h               | 105 ++
 tools/testing/selftests/bpf/bpf_helpers.h     |  19 +
 .../selftests/bpf/prog_tests/core_reloc.c     | 381 ++++++++
 .../bpf/progs/btf__core_reloc_arrays.c        |   3 +
 .../btf__core_reloc_arrays___diff_arr_dim.c   |   3 +
 ...btf__core_reloc_arrays___diff_arr_val_sz.c |   3 +
 .../btf__core_reloc_arrays___err_non_array.c  |   3 +
 ...btf__core_reloc_arrays___err_too_shallow.c |   3 +
 .../btf__core_reloc_arrays___err_too_small.c  |   3 +
 ..._core_reloc_arrays___err_wrong_val_type1.c |   3 +
 ..._core_reloc_arrays___err_wrong_val_type2.c |   3 +
 .../bpf/progs/btf__core_reloc_flavors.c       |   3 +
 .../btf__core_reloc_flavors__err_wrong_name.c |   3 +
 .../bpf/progs/btf__core_reloc_ints.c          |   3 +
 .../bpf/progs/btf__core_reloc_ints___bool.c   |   3 +
 .../btf__core_reloc_ints___err_bitfield.c     |   3 +
 .../btf__core_reloc_ints___err_wrong_sz_16.c  |   3 +
 .../btf__core_reloc_ints___err_wrong_sz_32.c  |   3 +
 .../btf__core_reloc_ints___err_wrong_sz_64.c  |   3 +
 .../btf__core_reloc_ints___err_wrong_sz_8.c   |   3 +
 .../btf__core_reloc_ints___reverse_sign.c     |   3 +
 .../bpf/progs/btf__core_reloc_misc.c          |   4 +
 .../bpf/progs/btf__core_reloc_mods.c          |   3 +
 .../progs/btf__core_reloc_mods___mod_swap.c   |   3 +
 .../progs/btf__core_reloc_mods___typedefs.c   |   3 +
 .../bpf/progs/btf__core_reloc_nesting.c       |   3 +
 .../btf__core_reloc_nesting___anon_embed.c    |   3 +
 ...f__core_reloc_nesting___dup_compat_types.c |   5 +
 ...core_reloc_nesting___err_array_container.c |   3 +
 ...tf__core_reloc_nesting___err_array_field.c |   3 +
 ...e_reloc_nesting___err_dup_incompat_types.c |   4 +
 ...re_reloc_nesting___err_missing_container.c |   3 +
 ...__core_reloc_nesting___err_missing_field.c |   3 +
 ..._reloc_nesting___err_nonstruct_container.c |   3 +
 ...e_reloc_nesting___err_partial_match_dups.c |   4 +
 .../btf__core_reloc_nesting___err_too_deep.c  |   3 +
 .../btf__core_reloc_nesting___extra_nesting.c |   3 +
 ..._core_reloc_nesting___struct_union_mixup.c |   3 +
 .../bpf/progs/btf__core_reloc_primitives.c    |   3 +
 ...f__core_reloc_primitives___diff_enum_def.c |   3 +
 ..._core_reloc_primitives___diff_func_proto.c |   3 +
 ...f__core_reloc_primitives___diff_ptr_type.c |   3 +
 ...tf__core_reloc_primitives___err_non_enum.c |   3 +
 ...btf__core_reloc_primitives___err_non_int.c |   3 +
 ...btf__core_reloc_primitives___err_non_ptr.c |   3 +
 .../bpf/progs/btf__core_reloc_ptr_as_arr.c    |   3 +
 .../btf__core_reloc_ptr_as_arr___diff_sz.c    |   3 +
 .../selftests/bpf/progs/core_reloc_types.h    | 667 +++++++++++++
 .../bpf/progs/test_core_reloc_arrays.c        |  55 ++
 .../bpf/progs/test_core_reloc_flavors.c       |  62 ++
 .../bpf/progs/test_core_reloc_ints.c          |  44 +
 .../bpf/progs/test_core_reloc_kernel.c        |  36 +
 .../bpf/progs/test_core_reloc_misc.c          |  58 ++
 .../bpf/progs/test_core_reloc_mods.c          |  62 ++
 .../bpf/progs/test_core_reloc_nesting.c       |  46 +
 .../bpf/progs/test_core_reloc_primitives.c    |  43 +
 .../bpf/progs/test_core_reloc_ptr_as_arr.c    |  30 +
 61 files changed, 2685 insertions(+), 49 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/core_reloc.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_arrays.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___diff_arr_dim.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___diff_arr_val_sz.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_non_array.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_too_shallow.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_too_small.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_wrong_val_type1.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_wrong_val_type2.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_flavors.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_flavors__err_wrong_name.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_ints.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_ints___bool.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_ints___err_bitfield.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_ints___err_wrong_sz_16.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_ints___err_wrong_sz_32.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_ints___err_wrong_sz_64.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_ints___err_wrong_sz_8.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_ints___reverse_sign.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_misc.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_mods.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_mods___mod_swap.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_mods___typedefs.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_nesting.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___anon_embed.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___dup_compat_types.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___err_array_container.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___err_array_field.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___err_dup_incompat_types.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___err_missing_container.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___err_missing_field.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___err_nonstruct_container.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___err_partial_match_dups.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___err_too_deep.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___extra_nesting.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___struct_union_mixup.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_primitives.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_primitives___diff_enum_def.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_primitives___diff_func_proto.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_primitives___diff_ptr_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_primitives___err_non_enum.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_primitives___err_non_int.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_primitives___err_non_ptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_ptr_as_arr.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_ptr_as_arr___diff_sz.c
 create mode 100644 tools/testing/selftests/bpf/progs/core_reloc_types.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_flavors.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_ints.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_misc.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_mods.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_nesting.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_primitives.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_ptr_as_arr.c

-- 
2.17.1

