Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0E2438017
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 00:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhJVWGN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 18:06:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58742 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231363AbhJVWGN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 Oct 2021 18:06:13 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19MLBWeQ023632
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 15:03:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=u7Ixq+WDZFUYVA5JiMxLeRovRuVVg/Hm0c19nQYUAcY=;
 b=Bq4r1NFdpQJayUDXymIlVdY25vpOQyR5bXcFo54vAoa2Wma7YyShhp1/yO4RKBsJNbHZ
 7Y2RkPp/h+1Ym2hKGFj3yF3rngbbueWaf+NIasVCcMpSOKM/j6CJ10IeAfFYZ1H4V1eJ
 DQ0NN2wUa9a3Nm+gRFEBly1F9GdrgV8EL1w= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3buu1ydd65-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 15:03:54 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 22 Oct 2021 15:03:53 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id CC2093EE3863; Fri, 22 Oct 2021 15:03:49 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>, Joanne Koong <joannekoong@fb.com>
Subject: [PATCH v5 bpf-next 0/5] Implement bloom filter map
Date:   Fri, 22 Oct 2021 15:02:44 -0700
Message-ID: <20211022220249.2040337-1-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: UFvGgnhpMv7bjycCEO3aTCWRu4URPsz-
X-Proofpoint-ORIG-GUID: UFvGgnhpMv7bjycCEO3aTCWRu4URPsz-
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_05,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110220125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds a new kind of bpf map: the bloom filter map.
Bloom filters are a space-efficient probabilistic data structure
used to quickly test whether an element exists in a set.
For a brief overview about how bloom filters work,
https://en.wikipedia.org/wiki/Bloom_filter
may be helpful.

One example use-case is an application leveraging a bloom filter
map to determine whether a computationally expensive hashmap
lookup can be avoided. If the element was not found in the bloom
filter map, the hashmap lookup can be skipped.

This patchset includes benchmarks for testing the performance of
the bloom filter for different entry sizes and different number of
hash functions used, as well as comparisons for hashmap lookups
with vs. without the bloom filter.

A high level overview of this patchset is as follows:
1/5 - kernel changes for adding bloom filter map
2/5 - libbpf changes for adding map_extra flags
3/5 - tests for the bloom filter map
4/5 - benchmarks for bloom filter lookup/update throughput and false positi=
ve
rate
5/5 - benchmarks for how hashmap lookups perform with vs. without the bloom
filter

v4 -> v5:
* Change the "bitset map with bloom filter capabilities" to a bloom filter =
map,
remove bitset tests
* Reduce verbiage by changing "bloom_filter" to "bloom", and renaming progs=
 to
more concise names.
* in 2/5: remove "map_extra" from struct definitions that are frozen, creat=
e a
"bpf_create_map_params" struct to propagate map_extra to the kernel at map
creation time, change map_extra to __u64
* in 4/5: check pthread condition variable in a loop when generating initial
map data, remove "err" checks where not pragmatic, generate random values
for the hashmap in the setup() instead of in the bpf program, add check_arg=
s()
for checking that there aren't more requested entries than possible unique
entries for the specified value size
* in 5/5: Update commit message with updated benchmark data

v3 -> v4:
* Generalize the bloom filter map to be a bitset map with bloom filter
capabilities
* Add map_extra flags; pass in nr_hash_funcs through lower 4 bits of map_ex=
tra
for the bitset map
* Add tests for the bitset map (non-bloom filter) functionality
* In the benchmarks, stats are computed only as monotonic increases, and pl=
ace
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
  bpf: Add bloom filter map implementation
  libbpf: Add "map_extra" as a per-map-type extra flag
  selftests/bpf: Add bloom filter map test cases
  bpf/benchs: Add benchmark tests for bloom filter throughput + false
    positive
  bpf/benchs: Add benchmarks for comparing hashmap lookups w/ vs. w/out
    bloom filter

 include/linux/bpf.h                           |   2 +
 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |   9 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/bloom_filter.c                     | 198 ++++++++
 kernel/bpf/syscall.c                          |  19 +-
 kernel/bpf/verifier.c                         |  19 +-
 tools/include/uapi/linux/bpf.h                |   9 +
 tools/lib/bpf/bpf.c                           |  27 +-
 tools/lib/bpf/bpf_gen_internal.h              |   2 +-
 tools/lib/bpf/gen_loader.c                    |   3 +-
 tools/lib/bpf/libbpf.c                        |  41 +-
 tools/lib/bpf/libbpf.h                        |   3 +
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/lib/bpf/libbpf_internal.h               |  25 +-
 tools/testing/selftests/bpf/Makefile          |   6 +-
 tools/testing/selftests/bpf/bench.c           |  60 ++-
 tools/testing/selftests/bpf/bench.h           |   3 +
 .../bpf/benchs/bench_bloom_filter_map.c       | 477 ++++++++++++++++++
 .../bpf/benchs/run_bench_bloom_filter_map.sh  |  45 ++
 .../bpf/benchs/run_bench_ringbufs.sh          |  30 +-
 .../selftests/bpf/benchs/run_common.sh        |  60 +++
 .../bpf/prog_tests/bloom_filter_map.c         | 204 ++++++++
 .../selftests/bpf/progs/bloom_filter_bench.c  | 153 ++++++
 .../selftests/bpf/progs/bloom_filter_map.c    |  82 +++
 25 files changed, 1431 insertions(+), 51 deletions(-)
 create mode 100644 kernel/bpf/bloom_filter.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bloom_filter_m=
ap.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bloom_filt=
er_map.sh
 create mode 100644 tools/testing/selftests/bpf/benchs/run_common.sh
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bloom_filter_map=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/bloom_filter_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/bloom_filter_map.c

--=20
2.30.2

