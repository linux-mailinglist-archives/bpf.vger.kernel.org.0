Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5385F4739C2
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 01:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhLNAtC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 13 Dec 2021 19:49:02 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47368 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231908AbhLNAtC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Dec 2021 19:49:02 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 1BDMcUuA031488
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 16:49:01 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3cx9rq3h88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 16:49:01 -0800
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 16:48:59 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id B595AD01DF6E; Mon, 13 Dec 2021 16:48:57 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v3 bpf-next 0/2] libbpf: auto-bump RLIMIT_MEMLOCK on old kernels
Date:   Mon, 13 Dec 2021 16:48:54 -0800
Message-ID: <20211214004856.3785613-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: ZB3-bQ-XwWh_melZBbOCyZMwAoVfhc4_
X-Proofpoint-GUID: ZB3-bQ-XwWh_melZBbOCyZMwAoVfhc4_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-13_14,2021-12-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=408 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make libbpf bump RLIMIT_MEMLOCK, similarly to BCC, if kernel is old enough to
use memcg-based memory accounting for BPF. Patch #2 drops explicit
setrlimi(RLIMIT_MEMLOCK) calls in test_progs, test_maps, and test_verifier.

v2->v3:
  - use difference in fdinfo's memlock reporting to detect memcg;
v1->v2:
  - fix up out-of-sync comments (Toke).

Andrii Nakryiko (2):
  libbpf: auto-bump RLIMIT_MEMLOCK if kernel needs it for BPF
  selftests/bpf: remove explicit setrlimit(RLIMIT_MEMLOCK) in main
    selftests

 tools/lib/bpf/bpf.c                           | 109 ++++++++++++++++++
 tools/lib/bpf/bpf.h                           |   2 +
 tools/lib/bpf/libbpf.c                        |  47 ++------
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/lib/bpf/libbpf_internal.h               |  39 +++++++
 tools/lib/bpf/libbpf_legacy.h                 |  12 +-
 tools/testing/selftests/bpf/bench.c           |  16 ---
 tools/testing/selftests/bpf/prog_tests/btf.c  |   1 -
 .../bpf/prog_tests/select_reuseport.c         |   1 -
 .../selftests/bpf/prog_tests/sk_lookup.c      |   1 -
 .../selftests/bpf/prog_tests/sock_fields.c    |   1 -
 tools/testing/selftests/bpf/test_maps.c       |   1 -
 tools/testing/selftests/bpf/test_progs.c      |   2 -
 tools/testing/selftests/bpf/test_verifier.c   |   4 +-
 14 files changed, 174 insertions(+), 63 deletions(-)

-- 
2.30.2

