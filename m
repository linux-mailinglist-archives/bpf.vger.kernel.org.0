Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C746E42498A
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 00:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbhJFWX3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 18:23:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37074 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230236AbhJFWX1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 18:23:27 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196K30ev007897
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 15:21:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=nrvGpJGn8iQ0oPnJnAgfjdq7nXSVRMcGo7wXZ5GMDTA=;
 b=WLKbQPyMqL1RdKS5AHXnpK5QGSDfMWEt5A927oEqtlYRBw60Ji5toXI5T7EL/0BrOPzD
 FFn5MDegK5BHs90jzml1Uti3//j7e6SioE04d+SRhi6SiZ2z5FGFUdrbyoRkuQgctubt
 gMxQtQr3lToLryEcUtE/JiefcPWCdJH4YaE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhc1bmnv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 15:21:34 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 15:21:33 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 89D6D345188A; Wed,  6 Oct 2021 15:21:29 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>, Joanne Koong <joannekoong@fb.com>
Subject: [PATCH bpf-next v4 0/5] Implement bitset maps, with bloom filter
Date:   Wed, 6 Oct 2021 15:20:58 -0700
Message-ID: <20211006222103.3631981-1-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: lUKyfZFQnV3p_g8PNIj64mc6qmcxqbwo
X-Proofpoint-GUID: lUKyfZFQnV3p_g8PNIj64mc6qmcxqbwo
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds a new kind of bpf map: the bitset map.

A bitset is an array data structure that compactly stores bits. It is a
non-associative data type and is often utilized to denote whether an element
exists in a set. A bitset is effective at exploiting bit-level parallelism =
in
hardware to perform operations quickly. For more information, please see
https://en.wikipedia.org/wiki/Bit_array

When a special flag is set, the bitset can be utilized as a bloom filter.
A bloom filter is a space-efficient probabilistic data structure used to
quickly test whether whether an element exists in a set. In a bloom filter,
false positives are possible whereas false negatives should never be. For a
more thorough overview about how bloom filters work,
https://en.wikipedia.org/wiki/Bloom_filter may be helpful.

One example use-case is an application leveraging a bloom filter map to
determine whether a computationally expensive hashmap lookup can be avoided=
. If
the element was not found in the bloom filter map, the hashmap lookup can be
skipped.

A high level overview of this patchset is as follows:
1/5 - kernel changes for the bitset map, with bloom filter capabilities
2/5 - libbpf changes for adding map_extra flags
3/5 - tests for the bitset map and for bloom filter capabilities
4/5 - benchmarks for bloom filter lookup/update throughput and false positi=
ve
rate
5/5 - benchmarks for how hashmap lookups perform with vs. without the bloom
filter

v3 -> v4:
* Generalize the bloom filter map to be a bitset map with bloom filter
capabilities
* Add map_extra flags; pass in nr_hash_funcs through lower 4 bits of map_ex=
tra
for the bitset map
* Add tests for the bitset map (non-bloom filter) functionality
* In the benchmarks, stats are computed only as monotonic increases. Placed
stats in a struct instead of as a percpu_array bpf map

v2 -> v3:
* Add libbpf changes for supporting nr_hash_funcs, instead of passing the
number of hash functions through map_flags.
* Separate the hashing logic in kernel/bpf/bloom_filter.c into a helper
function

v1 -> v2:
* Remove libbpf changes, and pass the number of hash functions through
map_flags instead.
* Default to using 5 hash functions if no number of hash functions
is specified.
* Use set_bit instead of spinlocks in the bloom filter bitmap. This
improved the speed significantly. For example, using 5 hash functions
with 100k entries, there was roughly a 35% speed increase.
* Use jhash2 (instead of jhash) for u32-aligned value sizes. This
increased the speed by roughly 5 to 15%. When using jhash2 on value
sizes non-u32 aligned (truncating any remainder bits), there was not
a noticeable difference.
* Add test for using the bloom filter as an inner map.
* Reran the benchmarks, updated the commit messages to correspond to
the new results.


Joanne Koong (5):
  bpf: Add bitset map with bloom filter capabilities
  libbpf: Add "map_extra" as a per-map-type extra flag
  selftests/bpf: Add bitset map test cases
  bpf/benchs: Add benchmark tests for bloom filter throughput + false
    positive
  bpf/benchs: Add benchmarks for comparing hashmap lookups w/ vs. w/out
    bloom filter

 include/linux/bpf.h                           |   2 +
 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |  10 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/bitset.c                           | 256 ++++++++++
 kernel/bpf/syscall.c                          |  25 +-
 kernel/bpf/verifier.c                         |  10 +-
 tools/include/uapi/linux/bpf.h                |  10 +
 tools/lib/bpf/bpf.c                           |   1 +
 tools/lib/bpf/bpf.h                           |   1 +
 tools/lib/bpf/bpf_helpers.h                   |   1 +
 tools/lib/bpf/libbpf.c                        |  25 +-
 tools/lib/bpf/libbpf.h                        |   4 +
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/lib/bpf/libbpf_internal.h               |   4 +-
 tools/testing/selftests/bpf/Makefile          |   6 +-
 tools/testing/selftests/bpf/bench.c           |  59 ++-
 tools/testing/selftests/bpf/bench.h           |   3 +
 .../bpf/benchs/bench_bloom_filter_map.c       | 448 ++++++++++++++++++
 .../bpf/benchs/run_bench_bloom_filter_map.sh  |  45 ++
 .../bpf/benchs/run_bench_ringbufs.sh          |  30 +-
 .../selftests/bpf/benchs/run_common.sh        |  60 +++
 tools/testing/selftests/bpf/bpf_util.h        |  11 +
 .../selftests/bpf/prog_tests/bitset_map.c     | 279 +++++++++++
 .../testing/selftests/bpf/progs/bitset_map.c  | 115 +++++
 .../selftests/bpf/progs/bloom_filter_bench.c  | 146 ++++++
 26 files changed, 1513 insertions(+), 43 deletions(-)
 create mode 100644 kernel/bpf/bitset.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bloom_filter_m=
ap.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bloom_filt=
er_map.sh
 create mode 100644 tools/testing/selftests/bpf/benchs/run_common.sh
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bitset_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/bitset_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/bloom_filter_bench.c

--=20
2.30.2

