Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B79310102
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 00:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhBDXtV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 18:49:21 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55052 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231231AbhBDXtU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Feb 2021 18:49:20 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114NkYIs007848
        for <bpf@vger.kernel.org>; Thu, 4 Feb 2021 15:48:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=NjqJJp2Jp5aHJBp1l9VQMpOiKqbbaKqk6YF2UD7DMrQ=;
 b=q+G4lsv0npuYnIQciFoZor837RuMAhYB/m/bi2AAuKnQMVJYJptsAjVNgJfF0pP9oG7J
 KU2j8x5WSVOgwo/bbOejxWtusabwunfEkNRwDgR/LoH7znUq+Pv7v6okK4IcwEodgzGk
 /96YaRrE7fe0xMTOT0iFv9EcAynu0EfEZP4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36fh1uvqer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 15:48:39 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 15:48:39 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id B50D23704E75; Thu,  4 Feb 2021 15:48:27 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/8] bpf: add bpf_for_each_map_elem() helper
Date:   Thu, 4 Feb 2021 15:48:27 -0800
Message-ID: <20210204234827.1628857-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_13:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=1 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=218 bulkscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=1
 impostorscore=0 spamscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102040144
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
the signature might be
  long callback_fn(map, key, val, callback_ctx)

In the rest of series, Patch 1 did some refactoring. Patch 2
implemented core kernel support for the helper. Patches 3 and 4
added hashmap and arraymap support. Patches 5 and 6 added
libbpf and bpftool support. Patches 7 and 8 added selftests
for hashmap and arraymap.

[1]: https://lore.kernel.org/bpf/20210122205415.113822-1-xiyou.wangcong@gma=
il.com/

Yonghong Song (8):
  bpf: refactor BPF_PSEUDO_CALL checking as a helper function
  bpf: add bpf_for_each_map_elem() helper
  bpf: add hashtab support for bpf_for_each_map_elem() helper
  bpf: add arraymap support for bpf_for_each_map_elem() helper
  libbpf: support local function pointer relocation
  bpftool: print local function pointer properly
  selftests/bpf: add hashmap test for bpf_for_each_map_elem() helper
  selftests/bpf: add arraymap test for bpf_for_each_map_elem() helper

 include/linux/bpf.h                           |  18 ++
 include/linux/bpf_verifier.h                  |   3 +
 include/uapi/linux/bpf.h                      |  28 ++
 kernel/bpf/arraymap.c                         |  36 +++
 kernel/bpf/bpf_iter.c                         |  16 +
 kernel/bpf/hashtab.c                          |  57 ++++
 kernel/bpf/helpers.c                          |   2 +
 kernel/bpf/verifier.c                         | 299 ++++++++++++++++--
 kernel/trace/bpf_trace.c                      |   2 +
 tools/bpf/bpftool/xlated_dumper.c             |   3 +
 tools/include/uapi/linux/bpf.h                |  28 ++
 tools/lib/bpf/libbpf.c                        |  33 +-
 .../selftests/bpf/prog_tests/for_each.c       | 145 +++++++++
 .../bpf/progs/for_each_array_map_elem.c       |  71 +++++
 .../bpf/progs/for_each_hash_map_elem.c        | 103 ++++++
 15 files changed, 811 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/for_each.c
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_array_map_el=
em.c
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_map_ele=
m.c

--=20
2.24.1

