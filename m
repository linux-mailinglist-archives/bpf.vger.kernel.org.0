Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137EF40A521
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 06:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhINEKh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 00:10:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43084 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232991AbhINEKf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 00:10:35 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DM9YVm014544
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 21:09:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=Va2GtmOyYTTBLpPuyHZFgFCpabrF607cxBCSO67Sq4o=;
 b=KR24R5vD0wga1S2KQbiFTkVqYJgXBomS6ulwXLxFqnnbCqhAGaK5Aka6ZazXOX0sL4rL
 0H4fzMBf0Nu0z3kCvNDiWr+jSRjRA30KKxfeVQmu38HnJdIPNl8K9etddGt24yRN7mDw
 tHZF8SXDXqesRH5naPd0BW2zr68EpNVJ7ZE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b1vfcywbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 21:09:18 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 21:09:16 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 8A9AA25C5B58; Mon, 13 Sep 2021 21:09:13 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>, Joanne Koong <joannekoong@fb.com>
Subject: [PATCH v2 bpf-next 0/4] Implement bloom filter map
Date:   Mon, 13 Sep 2021 21:04:29 -0700
Message-ID: <20210914040433.3184308-1-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: OkaGSkZMX0kFOiC1dCHWqYKwiP3uJ03d
X-Proofpoint-ORIG-GUID: OkaGSkZMX0kFOiC1dCHWqYKwiP3uJ03d
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_09,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 mlxlogscore=992 priorityscore=1501 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140024
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

This patchset includes benchmarks for testing out the performance of
the bloom filter for different entry sizes and different number of
hash functions used, as well as comparisons for hashmap lookups
with vs. without the bloom filter.

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

Joanne Koong (4):
  bpf: Add bloom filter map implementation
  selftests/bpf: Add bloom filter map test cases
  bpf/benchs: Add benchmark test for bloom filter maps
  bpf/benchs: Add benchmarks for comparing hashmap lookups with vs.
    without bloom filter

 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |  10 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/bloom_filter.c                     | 205 +++++++++
 kernel/bpf/syscall.c                          |  14 +-
 kernel/bpf/verifier.c                         |  19 +-
 tools/include/uapi/linux/bpf.h                |  10 +
 tools/testing/selftests/bpf/Makefile          |   4 +-
 tools/testing/selftests/bpf/bench.c           |  57 ++-
 tools/testing/selftests/bpf/bench.h           |   3 +
 .../bpf/benchs/bench_bloom_filter_map.c       | 393 ++++++++++++++++++
 .../bpf/benchs/run_bench_bloom_filter_map.sh  |  43 ++
 .../bpf/benchs/run_bench_ringbufs.sh          |  30 +-
 .../selftests/bpf/benchs/run_common.sh        |  60 +++
 .../bpf/prog_tests/bloom_filter_map.c         | 177 ++++++++
 .../selftests/bpf/progs/bloom_filter_map.c    | 156 +++++++
 16 files changed, 1144 insertions(+), 40 deletions(-)
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

