Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E423413BF6
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 23:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhIUVHC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 17:07:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15960 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232718AbhIUVHB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 17:07:01 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LHA1H8020969
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 14:05:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=30+gXXvkNRZwBmM+QUEMzcWZad0B3FYUW4IDlH0C76A=;
 b=Hku7LgZ0rOgZUcao178/AmNLvhbNzO9ZyF1DRwyW/ntIiKnD7fCTgc4riUrHC4nsqO4l
 K/lwDvvFSEBrtYPQpuQKAXG1FgNi64BoKMtxRPWht0Hpg7UMnrVuVvAFhQ0iI0+dzlsG
 +4bMecPjUHO/cb4VTwBJStDZxutTq/UBiNk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b79q5nc32-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 14:05:32 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 14:04:47 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 4ACE82AC130F; Tue, 21 Sep 2021 14:04:46 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>, Joanne Koong <joannekoong@fb.com>
Subject: [PATCH v3 bpf-next 0/5] Implement bloom filter map
Date:   Tue, 21 Sep 2021 14:02:20 -0700
Message-ID: <20210921210225.4095056-1-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: TLE6rmngUTfvNuXrKvm_-V3Mu35SGOG9
X-Proofpoint-ORIG-GUID: TLE6rmngUTfvNuXrKvm_-V3Mu35SGOG9
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_06,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=894 clxscore=1015
 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210125
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
  libbpf: Allow the number of hashes in bloom filter maps to be
    configurable
  selftests/bpf: Add bloom filter map test cases
  bpf/benchs: Add benchmark test for bloom filter maps
  bpf/benchs: Add benchmarks for comparing hashmap lookups with vs.
    without bloom filter

 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |   6 +-
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/bloom_filter.c                     | 185 +++++++++
 kernel/bpf/syscall.c                          |  14 +-
 kernel/bpf/verifier.c                         |  19 +-
 tools/include/uapi/linux/bpf.h                |   6 +-
 tools/lib/bpf/bpf.c                           |   2 +
 tools/lib/bpf/bpf.h                           |   1 +
 tools/lib/bpf/libbpf.c                        |  32 +-
 tools/lib/bpf/libbpf.h                        |   2 +
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/lib/bpf/libbpf_internal.h               |   4 +-
 tools/testing/selftests/bpf/Makefile          |   4 +-
 tools/testing/selftests/bpf/bench.c           |  57 ++-
 tools/testing/selftests/bpf/bench.h           |   3 +
 .../bpf/benchs/bench_bloom_filter_map.c       | 384 ++++++++++++++++++
 .../bpf/benchs/run_bench_bloom_filter_map.sh  |  43 ++
 .../bpf/benchs/run_bench_ringbufs.sh          |  30 +-
 .../selftests/bpf/benchs/run_common.sh        |  60 +++
 .../bpf/prog_tests/bloom_filter_map.c         | 177 ++++++++
 .../selftests/bpf/progs/bloom_filter_map.c    | 157 +++++++
 22 files changed, 1142 insertions(+), 48 deletions(-)
 create mode 100644 kernel/bpf/bloom_filter.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bloom_filter_m=
ap.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bloom_filt=
er_map.sh
 create mode 100644 tools/testing/selftests/bpf/benchs/run_common.sh
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bloom_filter_map=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/bloom_filter_map.c

--=20
2.30.2

