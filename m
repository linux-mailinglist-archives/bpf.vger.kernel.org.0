Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EBE41516E
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 22:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbhIVUeH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 22 Sep 2021 16:34:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46566 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237626AbhIVUeH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Sep 2021 16:34:07 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MIlNgV022611
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 13:32:36 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b86h0tj14-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 13:32:36 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 22 Sep 2021 13:32:32 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A6AA54B04EB7; Wed, 22 Sep 2021 13:32:27 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kafai@fb.com>, <joannekoong@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH RFC bpf-next 0/4] bpf_jhash_mem() and BPF Bloom filter implementation
Date:   Wed, 22 Sep 2021 13:32:20 -0700
Message-ID: <20210922203224.912809-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="UTF-8"
X-FB-Internal: Safe
X-FB-Source: Intern
X-Proofpoint-GUID: SKCUED4akGWkh_EdjCojnUbRo0esyHkP
X-Proofpoint-ORIG-GUID: SKCUED4akGWkh_EdjCojnUbRo0esyHkP
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_08,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a quick experiment on adding a hashing helper and buliding Bloom
filter with pure BPF code with no extra kernel functionality (beyond generic
hashing helper).

This is based on top of Joanne's series [0].

Patch 1 adds bpf_jhash_mem() helper. Patch 2 fixes existing benchmark to
report valid and consistent benchmark results and reduce amount of overhead
that stats counting itself causes. Patch 3 contains BPF-side implementation of
Bloom filter based on global variables. Patch 4 completes the integration on
user-space side. I split patch 3 and 4 to not distract from BPF-side changes.

Note that "Hashmap without bloom filter vs. hashmap with bloom filter"
benchmark is still spending lots of time in just generating random values on
BPF side, and it would be nice to optimize that and make it more reproducible
to compare different implementations. But I ran out of steam for doing that,
especially that I'm not sure this changes anything.

The same benchmark also checks only short 8-byte keys, which is a valid use
case, but not the only probably one, so would be nice to have that extended as
well.


For reference, here are full benchmark results comparing in-kernel Bloom filter
and custom BPF-implemented Bloom filter. I shortened the set of different
combinations tested to reduce amount of time to wait for results.

The results for "Hashmap without bloom filter vs. hashmap with bloom filter"
are quite confusing, though. I spent a bit of time to try to find
discrepancies. I confirmed that both implementations function correctly and
match 100% of time in terms of positives/negatives. Pure Bloom filter reading
benchmarks show a pretty small gap in performance with custom BPF
implementation losing. The "Hashmap without bloom filter vs. hashmap with bloom
filter" benchmark shows much bigger difference, though, which I wasn't able to
completely explain, to be entirely honest.

It's probably worth spending some more time investigating this, but I ran out
of self-alloted time for this.


Bloom filter map
================
        # threads: 1, # hashes: 1
10,000 entries -
        Total operations:    50.854 ± 0.134M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  31.36%
        [CUSTOM] Total operations:  49.391 ± 0.123M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  31.37%
100,000 entries -
        Total operations:    50.969 ± 0.049M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  24.04%
        [CUSTOM] Total operations:  49.135 ± 1.579M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  24.04%
1,000,000 entries -
        Total operations:    48.474 ± 1.619M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  27.50%
        [CUSTOM] Total operations:  46.088 ± 0.776M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  27.50%

        # threads: 1, # hashes: 3
10,000 entries -
        Total operations:    25.136 ± 0.011M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  4.71%
        [CUSTOM] Total operations:  24.115 ± 0.014M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  4.77%
100,000 entries -
        Total operations:    25.045 ± 0.120M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  7.67%
        [CUSTOM] Total operations:  23.028 ± 0.042M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  7.65%
1,000,000 entries -
        Total operations:    18.712 ± 0.406M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  2.64%
        [CUSTOM] Total operations:  18.100 ± 0.422M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  2.64%

        # threads: 1, # hashes: 5
10,000 entries -
        Total operations:    16.672 ± 0.011M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  0.32%
        [CUSTOM] Total operations:  15.318 ± 0.014M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  0.32%
100,000 entries -
        Total operations:    16.540 ± 0.121M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  0.78%
        [CUSTOM] Total operations:  15.189 ± 0.045M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  0.78%
1,000,000 entries -
        Total operations:    11.781 ± 0.192M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  1.79%
        [CUSTOM] Total operations:  11.651 ± 0.012M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  1.79%

        # threads: 1, # hashes: 10
10,000 entries -
        Total operations:    9.038 ± 0.052M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  0.00%
        [CUSTOM] Total operations:  8.620 ± 0.008M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  0.00%
100,000 entries -
        Total operations:    8.076 ± 0.027M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  0.01%
        [CUSTOM] Total operations:  7.261 ± 0.007M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  0.01%
1,000,000 entries -
        Total operations:    6.263 ± 0.041M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  0.03%
        [CUSTOM] Total operations:  6.173 ± 0.013M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  0.03%

        # threads: 4, # hashes: 1
10,000 entries -
        Total operations:    203.453 ± 0.161M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  31.28%
        [CUSTOM] Total operations:  197.959 ± 0.051M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  31.34%
100,000 entries -
        Total operations:    203.887 ± 0.155M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  24.07%
        [CUSTOM] Total operations:  197.476 ± 1.796M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  24.09%
1,000,000 entries -
        Total operations:    189.259 ± 0.473M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  27.50%
        [CUSTOM] Total operations:  185.157 ± 0.346M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  27.48%

        # threads: 4, # hashes: 3
10,000 entries -
        Total operations:    100.394 ± 0.062M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  4.76%
        [CUSTOM] Total operations:  93.896 ± 0.104M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  4.75%
100,000 entries -
        Total operations:    100.382 ± 0.155M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  7.62%
        [CUSTOM] Total operations:  93.460 ± 0.145M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  7.65%
1,000,000 entries -
        Total operations:    71.424 ± 0.710M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  2.65%
        [CUSTOM] Total operations:  72.546 ± 0.228M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  2.65%

        # threads: 4, # hashes: 5
10,000 entries -
        Total operations:    66.652 ± 0.116M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  0.32%
        [CUSTOM] Total operations:  60.790 ± 0.454M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  0.33%
100,000 entries -
        Total operations:    66.401 ± 0.090M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  0.78%
        [CUSTOM] Total operations:  61.066 ± 0.069M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  0.77%
1,000,000 entries -
        Total operations:    48.299 ± 0.369M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  1.79%
        [CUSTOM] Total operations:  47.401 ± 0.347M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  1.79%

        # threads: 4, # hashes: 10
10,000 entries -
        Total operations:    36.273 ± 0.030M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  0.00%
        [CUSTOM] Total operations:  34.464 ± 0.073M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  0.00%
100,000 entries -
        Total operations:    32.525 ± 0.047M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  0.01%
        [CUSTOM] Total operations:  29.516 ± 0.110M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  0.01%
1,000,000 entries -
        Total operations:    25.515 ± 0.405M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  0.03%
        [CUSTOM] Total operations:  24.566 ± 0.189M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  0.03%

        # threads: 8, # hashes: 1
10,000 entries -
        Total operations:    406.129 ± 2.262M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  31.45%
        [CUSTOM] Total operations:  384.758 ± 0.379M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  31.24%
100,000 entries -
        Total operations:    407.817 ± 0.793M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  24.05%
        [CUSTOM] Total operations:  394.745 ± 1.302M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  24.05%
1,000,000 entries -
        Total operations:    383.159 ± 0.289M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  27.49%
        [CUSTOM] Total operations:  371.173 ± 0.454M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  27.49%

        # threads: 8, # hashes: 3
10,000 entries -
        Total operations:    201.079 ± 0.183M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  4.69%
        [CUSTOM] Total operations:  187.658 ± 0.544M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  4.74%
100,000 entries -
        Total operations:    199.826 ± 0.972M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  7.63%
        [CUSTOM] Total operations:  185.415 ± 0.358M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  7.62%
1,000,000 entries -
        Total operations:    148.589 ± 1.320M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  2.65%
        [CUSTOM] Total operations:  142.591 ± 4.825M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  2.64%

        # threads: 8, # hashes: 5
10,000 entries -
        Total operations:    133.306 ± 0.468M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  0.32%
        [CUSTOM] Total operations:  127.377 ± 0.271M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  0.32%
100,000 entries -
        Total operations:    132.915 ± 0.364M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  0.78%
        [CUSTOM] Total operations:  123.722 ± 3.169M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  0.77%
1,000,000 entries -
        Total operations:    94.803 ± 3.240M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  1.79%
        [CUSTOM] Total operations:  95.670 ± 2.624M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  1.79%

        # threads: 8, # hashes: 10
10,000 entries -
        Total operations:    72.517 ± 0.083M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  0.00%
        [CUSTOM] Total operations:  65.803 ± 0.069M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  0.00%
100,000 entries -
        Total operations:    65.533 ± 0.148M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  0.01%
        [CUSTOM] Total operations:  59.908 ± 2.841M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  0.01%
1,000,000 entries -
        Total operations:    50.937 ± 0.105M/s (drops 0.000 ± 0.000M/s)
        False positive rate:  0.03%
        [CUSTOM] Total operations:  47.526 ± 1.044M/s (drops 0.000 ± 0.000M/s)
        [CUSTOM] False positive rate:  0.03%


Hashmap without bloom filter vs. hashmap with bloom filter (throughput, 8 threads)
==================================================================================
        # hashes: 1
10,000 entries -
        Hashmap without bloom filter:  123.919 ± 0.458M/s
        Hashmap with bloom filter:  124.588 ± 0.450M/s
        [CUSTOM] Hashmap with bloom filter:  106.838 ± 0.114M/s
100,000 entries -
        Hashmap without bloom filter:  93.708 ± 0.715M/s
        Hashmap with bloom filter:  131.686 ± 1.272M/s
        [CUSTOM] Hashmap with bloom filter:  105.649 ± 0.278M/s
1,000,000 entries -
        Hashmap without bloom filter:  40.040 ± 0.677M/s
        Hashmap with bloom filter:  67.250 ± 0.506M/s
        [CUSTOM] Hashmap with bloom filter:  58.356 ± 0.541M/s

        # hashes: 3
10,000 entries -
        Hashmap without bloom filter:  123.882 ± 0.077M/s
        Hashmap with bloom filter:  152.423 ± 0.061M/s
        [CUSTOM] Hashmap with bloom filter:  126.021 ± 0.115M/s
100,000 entries -
        Hashmap without bloom filter:  94.291 ± 0.986M/s
        Hashmap with bloom filter:  127.944 ± 0.825M/s
        [CUSTOM] Hashmap with bloom filter:  106.943 ± 0.827M/s
1,000,000 entries -
        Hashmap without bloom filter:  40.183 ± 0.382M/s
        Hashmap with bloom filter:  125.224 ± 0.266M/s
        [CUSTOM] Hashmap with bloom filter:  89.717 ± 0.158M/s

        # hashes: 5
10,000 entries -
        Hashmap without bloom filter:  120.510 ± 0.351M/s
        Hashmap with bloom filter:  170.138 ± 0.088M/s
        [CUSTOM] Hashmap with bloom filter:  136.006 ± 0.324M/s
100,000 entries -
        Hashmap without bloom filter:  94.774 ± 0.191M/s
        Hashmap with bloom filter:  145.559 ± 0.687M/s
        [CUSTOM] Hashmap with bloom filter:  117.073 ± 0.382M/s
1,000,000 entries -
        Hashmap without bloom filter:  40.004 ± 0.492M/s
        Hashmap with bloom filter:  96.916 ± 0.148M/s
        [CUSTOM] Hashmap with bloom filter:  78.485 ± 0.289M/s

        # hashes: 10
10,000 entries -
        Hashmap without bloom filter:  124.034 ± 0.245M/s
        Hashmap with bloom filter:  169.757 ± 0.336M/s
        [CUSTOM] Hashmap with bloom filter:  134.634 ± 0.276M/s
100,000 entries -
        Hashmap without bloom filter:  94.872 ± 0.195M/s
        Hashmap with bloom filter:  141.107 ± 0.780M/s
        [CUSTOM] Hashmap with bloom filter:  109.279 ± 0.330M/s
1,000,000 entries -
        Hashmap without bloom filter:  40.215 ± 0.396M/s
        Hashmap with bloom filter:  98.084 ± 0.267M/s
        [CUSTOM] Hashmap with bloom filter:  78.579 ± 0.046M/s


  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=550585&state=*

Andrii Nakryiko (4):
  bpf: add bpf_jhash_mem BPF helper
  selftests/bpf: fix and optimize bloom filter bench
  selftests/bpf: implement custom Bloom filter purely in BPF
  selftests/bpf: integrate custom Bloom filter impl into benchs

 include/uapi/linux/bpf.h                      |   8 +
 kernel/bpf/helpers.c                          |  23 +++
 tools/include/uapi/linux/bpf.h                |   8 +
 tools/testing/selftests/bpf/Makefile          |   2 +-
 tools/testing/selftests/bpf/bench.c           |   6 +
 .../bpf/benchs/bench_bloom_filter_map.c       | 153 +++++++++++++++++-
 .../bpf/benchs/run_bench_bloom_filter_map.sh  |  22 +--
 .../selftests/bpf/benchs/run_common.sh        |   2 +-
 .../selftests/bpf/progs/bloom_filter_map.c    | 125 ++++++++++++--
 9 files changed, 317 insertions(+), 32 deletions(-)

-- 
2.30.2

