Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200913FCFAE
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 00:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240927AbhHaWvW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 18:51:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5240 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240924AbhHaWvW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 18:51:22 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17VMiZBj018602
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 15:50:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=ib7eLpTolryXiUjlUCND4FkAhD3/9dCsEmaRFjErw+c=;
 b=Ep5YgMY9eo+hD+Lk4tBkY2tyNFnCcN4+NpNJaMxFy4KHjec59b8/Wxr0Rs532rHHTDAx
 eP5gzk4R5+EkiBFLRJ27HnMHlFLa8U+c5xCxod0UZyfuKDDSOtiXk/5MIzbq53zqJF2m
 Y/7IX2wbIP7qboX1wdUt+EW8qs8WmamWlOQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3asscrt38f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 15:50:25 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 31 Aug 2021 15:50:23 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id E56801C88BAA; Tue, 31 Aug 2021 15:50:19 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Joanne Koong <joannekoong@fb.com>
Subject: [PATCH bpf-next 0/5] Implement bloom filter map
Date:   Tue, 31 Aug 2021 15:50:00 -0700
Message-ID: <20210831225005.2762202-1-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: UM6HHQMaE1SCgejgVxN3QUsFR-3Fwv0A
X-Proofpoint-ORIG-GUID: UM6HHQMaE1SCgejgVxN3QUsFR-3Fwv0A
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_09:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 spamscore=0
 mlxlogscore=941 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds a new kind of bpf map: the bloom filter map.
Bloom filters are a space-efficient probabilistic data structure
used to quickly test whether an element exists in a set.
In a bloom filter, false positives are possible whereas false
negatives are not.

This patchset includes benchmarks for a configurable number of hashes and
entries in the bloom filter. The benchmarks roughly show that on average,
using 3 hash functions is one of the most optimal choices. When comparing
hashmap lookups using 3 hashes in the bloom filter vs. hashmap lookups no=
t
using a bloom filter, lookups using the bloom filter are roughly 15% fast=
er
for 50k entries, 25% faster for 100k entries, 180% faster for 500k entrie=
s,
and 200% faster for 1 million entries.

Joanne Koong (5):
  bpf: Add bloom filter map implementation
  libbpf: Allow the number of hashes in bloom filter maps to be
    configurable
  selftests/bpf: Add bloom filter map test cases
  bpf/benchs: Add benchmark test for bloom filter maps
  bpf/benchs: Add benchmarks for comparing hashmap lookups with vs.
    without bloom filter

 include/linux/bpf.h                           |   3 +-
 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |   3 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/bloom_filter.c                     | 171 ++++++++
 kernel/bpf/syscall.c                          |  20 +-
 kernel/bpf/verifier.c                         |  19 +-
 tools/include/uapi/linux/bpf.h                |   3 +
 tools/lib/bpf/bpf.c                           |   2 +
 tools/lib/bpf/bpf.h                           |   1 +
 tools/lib/bpf/libbpf.c                        |  32 +-
 tools/lib/bpf/libbpf.h                        |   3 +
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/lib/bpf/libbpf_internal.h               |   4 +-
 tools/testing/selftests/bpf/Makefile          |   4 +-
 tools/testing/selftests/bpf/bench.c           |  57 ++-
 tools/testing/selftests/bpf/bench.h           |   3 +
 .../bpf/benchs/bench_bloom_filter_map.c       | 383 ++++++++++++++++++
 .../bpf/benchs/run_bench_bloom_filter_map.sh  |  43 ++
 .../bpf/benchs/run_bench_ringbufs.sh          |  30 +-
 .../selftests/bpf/benchs/run_common.sh        |  60 +++
 .../bpf/prog_tests/bloom_filter_map.c         | 123 ++++++
 .../selftests/bpf/progs/bloom_filter_map.c    | 123 ++++++
 23 files changed, 1048 insertions(+), 44 deletions(-)
 create mode 100644 kernel/bpf/bloom_filter.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bloom_filter=
_map.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bloom_fi=
lter_map.sh
 create mode 100644 tools/testing/selftests/bpf/benchs/run_common.sh
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bloom_filter_m=
ap.c
 create mode 100644 tools/testing/selftests/bpf/progs/bloom_filter_map.c

--=20
2.30.2

