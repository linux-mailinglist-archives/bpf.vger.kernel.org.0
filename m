Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813D34551BF
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 01:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241983AbhKRAhe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 17 Nov 2021 19:37:34 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56650 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241990AbhKRAhb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Nov 2021 19:37:31 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1AHLe70Z032255
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 16:34:32 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3cd3ahvhyc-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 16:34:31 -0800
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 17 Nov 2021 16:34:31 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 6729499613B2; Wed, 17 Nov 2021 16:34:25 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/4] libbpf: unify low-level map creation APIs
Date:   Wed, 17 Nov 2021 16:34:19 -0800
Message-ID: <20211118003423.1885869-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 3DMAH-0af7R7uE0TopPflonBWtKL5Oqf
X-Proofpoint-ORIG-GUID: 3DMAH-0af7R7uE0TopPflonBWtKL5Oqf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_09,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=641
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add new OPTS-based bpf_map_create() API. Schedule deprecation of 6 (!)
existing non-extensible variants. Clean up both internal libbpf use of
to-be-deprecated APIs as well as selftests/bpf.

Thankfully, as opposed to bpf_prog_load() and few other *_opts structs
refactorings, this one is very straightforward and doesn't require any macro
magic.

Third patch also ensures that when libbpf 0.7 development starts we won't be
getting deprecation warning for using our own xsk_* APIs. Without that it's
hard to simulate libbpf 0.7 and ensure that there are no upcoming
deprecation warnings.

Andrii Nakryiko (4):
  libbpf: unify low-level map creation APIs w/ new bpf_map_create()
  libbpf: use bpf_map_create() consistently internally
  libbpf: prevent deprecation warnings in xsk.c
  selftests/bpf: migrate selftests to bpf_map_create()

 tools/lib/bpf/bpf.c                           | 140 ++++++++----------
 tools/lib/bpf/bpf.h                           |  33 ++++-
 tools/lib/bpf/bpf_gen_internal.h              |   5 +-
 tools/lib/bpf/gen_loader.c                    |  46 ++----
 tools/lib/bpf/libbpf.c                        |  63 +++-----
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/lib/bpf/libbpf_internal.h               |  21 ---
 tools/lib/bpf/libbpf_probes.c                 |  30 ++--
 tools/lib/bpf/skel_internal.h                 |   3 +-
 tools/lib/bpf/xsk.c                           |  18 +--
 .../bpf/map_tests/array_map_batch_ops.c       |  13 +-
 .../bpf/map_tests/htab_map_batch_ops.c        |  13 +-
 .../bpf/map_tests/lpm_trie_map_batch_ops.c    |  15 +-
 .../selftests/bpf/map_tests/sk_storage_map.c  |  50 +++----
 .../bpf/prog_tests/bloom_filter_map.c         |  36 ++---
 .../selftests/bpf/prog_tests/bpf_iter.c       |   8 +-
 tools/testing/selftests/bpf/prog_tests/btf.c  |  51 +++----
 .../bpf/prog_tests/cgroup_attach_multi.c      |  12 +-
 .../selftests/bpf/prog_tests/pinning.c        |   4 +-
 .../selftests/bpf/prog_tests/ringbuf_multi.c  |   4 +-
 .../bpf/prog_tests/select_reuseport.c         |  21 +--
 .../selftests/bpf/prog_tests/sockmap_basic.c  |   4 +-
 .../selftests/bpf/prog_tests/sockmap_ktls.c   |   2 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c |   4 +-
 .../selftests/bpf/prog_tests/test_bpffs.c     |   2 +-
 .../selftests/bpf/test_cgroup_storage.c       |   8 +-
 tools/testing/selftests/bpf/test_lpm_map.c    |  27 ++--
 tools/testing/selftests/bpf/test_lru_map.c    |  16 +-
 tools/testing/selftests/bpf/test_maps.c       | 110 +++++++-------
 tools/testing/selftests/bpf/test_tag.c        |   5 +-
 tools/testing/selftests/bpf/test_verifier.c   |  52 +++----
 31 files changed, 357 insertions(+), 460 deletions(-)

-- 
2.30.2

