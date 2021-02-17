Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CE931DEFB
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 19:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhBQSSy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 13:18:54 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8876 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234386AbhBQSSx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Feb 2021 13:18:53 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11HIA43x014893
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 10:18:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=LEoJGtWzv7LXkJQEO82la+/qIpsizbIlyALoHAw7DCo=;
 b=AoafhS+j/UnbtKe5pXyCYM/cPT7q+QDyIVtZmpPFKOMcFyZnxypAlGWJDnMGKfvods7k
 sJLXbfHmogsxWM2iuhc7Ol64NlPlhdSVm2JQpCanKBX+HPbr9WK+bP0+OHn4hZQmkzJt
 EGgK9++5Q8X8KaLz1IV6pINWL4Kr1MLJkZA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 36quthwxre-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 10:18:12 -0800
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Feb 2021 10:18:11 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 9441E3704F7A; Wed, 17 Feb 2021 10:18:03 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 00/11] bpf: add bpf_for_each_map_elem() helper
Date:   Wed, 17 Feb 2021 10:18:03 -0800
Message-ID: <20210217181803.3189437-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_13:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=230 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170133
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

In the rest of series, Patches 1/2/3 did some refactoring. Patch 4
implemented core kernel support for the helper. Patches 5 and 6
added hashmap and arraymap support. Patches 7/8 added libbpf
support. Patch 9 added bpftool support. Patches 10 and 11 added
selftests for hashmap and arraymap.

[1]: https://lore.kernel.org/bpf/20210122205415.113822-1-xiyou.wangcong@gma=
il.com/

Yonghong Song (11):
  bpf: factor out visit_func_call_insn() in check_cfg()
  bpf: factor out verbose_invalid_scalar()
  bpf: refactor check_func_call() to allow callback function
  bpf: add bpf_for_each_map_elem() helper
  bpf: add hashtab support for bpf_for_each_map_elem() helper
  bpf: add arraymap support for bpf_for_each_map_elem() helper
  libbpf: move function is_ldimm64() earlier in libbpf.c
  libbpf: support local function pointer relocation
  bpftool: print local function pointer properly
  selftests/bpf: add hashmap test for bpf_for_each_map_elem() helper
  selftests/bpf: add arraymap test for bpf_for_each_map_elem() helper

 include/linux/bpf.h                           |  17 +
 include/linux/bpf_verifier.h                  |   3 +
 include/uapi/linux/bpf.h                      |  29 +-
 kernel/bpf/arraymap.c                         |  39 ++
 kernel/bpf/bpf_iter.c                         |  16 +
 kernel/bpf/hashtab.c                          |  63 ++++
 kernel/bpf/helpers.c                          |   2 +
 kernel/bpf/verifier.c                         | 346 +++++++++++++++---
 kernel/trace/bpf_trace.c                      |   2 +
 tools/bpf/bpftool/xlated_dumper.c             |   3 +
 tools/include/uapi/linux/bpf.h                |  29 +-
 tools/lib/bpf/libbpf.c                        |  52 ++-
 .../selftests/bpf/prog_tests/for_each.c       | 132 +++++++
 .../bpf/progs/for_each_array_map_elem.c       |  61 +++
 .../bpf/progs/for_each_hash_map_elem.c        |  95 +++++
 15 files changed, 829 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/for_each.c
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_array_map_el=
em.c
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_map_ele=
m.c

--=20
2.24.1

