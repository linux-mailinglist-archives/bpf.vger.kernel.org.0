Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80103268E5
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 21:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhBZUuR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 15:50:17 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4722 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230124AbhBZUuQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 15:50:16 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QKi0UH004079
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 12:49:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=jXm8FSbPx5eUmho/RICrBKdQvCAOYEGFkcSljjk8YMo=;
 b=O8fg1Un45CiywTItQu6h3ZBlb8ySwO+GZhJaAOqOmTtHpNAeNT/dpYYWpK1OPleT/4a4
 QtlZaPaOyNUo4P82xRBGbVCZ1UR6TlE572IGSEiCrzqAVOBMIrg1am3HwXdixfAEB03C
 iN5/ZrpWLo/35rsjYX9HvkxZouqO+/Co4/4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36x96c20vb-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 12:49:35 -0800
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Feb 2021 12:49:23 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 9FE4D3705324; Fri, 26 Feb 2021 12:49:20 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v5 00/12] bpf: add bpf_for_each_map_elem() helper
Date:   Fri, 26 Feb 2021 12:49:20 -0800
Message-ID: <20210226204920.3884074-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_09:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=622 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102260155
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set introduced bpf_for_each_map_elem() helper.
The helper permits bpf program iterates through all elements
for a particular map.

The work originally inspired by an internal discussion where
firewall rules are kept in a map and bpf prog wants to
check packet 5 tuples against all rules in the map.
A bounded loop can be used but it has a few drawbacks.
As the loop iteration goes up, verification time goes up too.
For really large maps, verification may fail.
A helper which abstracts out the loop itself will not have
verification time issue.

A recent discussion in [1] involves to iterate all hash map
elements in bpf program. Currently iterating all hashmap elements
in bpf program is not easy if key space is really big.
Having a helper to abstract out the loop itself is even more
meaningful.

The proposed helper signature looks like:
  long bpf_for_each_map_elem(map, callback_fn, callback_ctx, flags)
where callback_fn is a static function and callback_ctx is
a piece of data allocated on the caller stack which can be
accessed by the callback_fn. The callback_fn signature might be
different for different maps. For example, for hash/array maps,
the signature is
  long callback_fn(map, key, val, callback_ctx)

In the rest of series, Patches 1/2/3/4 did some refactoring. Patch 5
implemented core kernel support for the helper. Patches 6 and 7
added hashmap and arraymap support. Patches 8/9 added libbpf
support. Patch 10 added bpftool support. Patches 11 and 12 added
selftests for hashmap and arraymap.

[1]: https://lore.kernel.org/bpf/20210122205415.113822-1-xiyou.wangcong@gma=
il.com/

Changelogs:
  v4 -> v5:
    - rebase on top of bpf-next.
  v3 -> v4:
    - better refactoring of check_func_call(), calculate subprogno outside
      of __check_func_call() helper. (Andrii)
    - better documentation (like the list of supported maps and their
      callback signatures) in uapi header. (Andrii)
    - implement and use ASSERT_LT in selftests. (Andrii)
    - a few other minor changes.
  v2 -> v3:
    - add comments in retrieve_ptr_limit(), which is in sanitize_ptr_alu(),
      to clarify the code is not executed for PTR_TO_MAP_KEY handling,
      but code is manually tested. (Alexei)
    - require BTF for callback function. (Alexei)
    - simplify hashmap/arraymap callback return handling as return value
      [0, 1] has been enforced by the verifier. (Alexei)
    - also mark global subprog (if used in ld_imm64) as RELO_SUBPROG_ADDR. =
(Andrii)
    - handle the condition to mark RELO_SUBPROG_ADDR properly. (Andrii)
    - make bpftool subprog insn offset dumping consist with pcrel calls. (A=
ndrii)
  v1 -> v2:
    - setup callee frame in check_helper_call() and then proceed to verify
      helper return value as normal (Alexei)
    - use meta data to keep track of map/func pointer to avoid hard coding
      the register number (Alexei)
    - verify callback_fn return value range [0, 1]. (Alexei)
    - add migrate_{disable, enable} to ensure percpu value is the one
      bpf program expects to see. (Alexei)
    - change bpf_for_each_map_elem() return value to the number of iterated
      elements. (Andrii)
    - Change libbpf pseudo_func relo name to RELO_SUBPROG_ADDR and use
      more rigid checking for the relocation. (Andrii)
    - Better format to print out subprog address with bpftool. (Andrii)
    - Use bpf_prog_test_run to trigger bpf run, instead of bpf_iter. (Andri=
i)
    - Other misc changes.

Yonghong Song (12):
  bpf: factor out visit_func_call_insn() in check_cfg()
  bpf: factor out verbose_invalid_scalar()
  bpf: refactor check_func_call() to allow callback function
  bpf: change return value of verifier function add_subprog()
  bpf: add bpf_for_each_map_elem() helper
  bpf: add hashtab support for bpf_for_each_map_elem() helper
  bpf: add arraymap support for bpf_for_each_map_elem() helper
  libbpf: move function is_ldimm64() earlier in libbpf.c
  libbpf: support subprog address relocation
  bpftool: print subprog address properly
  selftests/bpf: add hashmap test for bpf_for_each_map_elem() helper
  selftests/bpf: add arraymap test for bpf_for_each_map_elem() helper

 include/linux/bpf.h                           |  17 +
 include/linux/bpf_verifier.h                  |   3 +
 include/uapi/linux/bpf.h                      |  38 ++
 kernel/bpf/arraymap.c                         |  40 ++
 kernel/bpf/bpf_iter.c                         |  16 +
 kernel/bpf/hashtab.c                          |  65 ++++
 kernel/bpf/helpers.c                          |   2 +
 kernel/bpf/verifier.c                         | 364 +++++++++++++++---
 kernel/trace/bpf_trace.c                      |   2 +
 tools/bpf/bpftool/xlated_dumper.c             |   3 +
 tools/include/uapi/linux/bpf.h                |  38 ++
 tools/lib/bpf/libbpf.c                        |  76 +++-
 .../selftests/bpf/prog_tests/for_each.c       | 130 +++++++
 .../bpf/progs/for_each_array_map_elem.c       |  61 +++
 .../bpf/progs/for_each_hash_map_elem.c        |  95 +++++
 tools/testing/selftests/bpf/test_progs.h      |  11 +
 16 files changed, 897 insertions(+), 64 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/for_each.c
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_array_map_el=
em.c
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_map_ele=
m.c

--=20
2.24.1

