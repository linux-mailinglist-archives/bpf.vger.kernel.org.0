Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE08470BA7
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 21:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238422AbhLJURN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 10 Dec 2021 15:17:13 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3734 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238375AbhLJURN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Dec 2021 15:17:13 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAJEwkP031357
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 12:13:37 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cvcvp0g0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 12:13:37 -0800
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 12:13:37 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5A7F7C91EBE1; Fri, 10 Dec 2021 12:13:35 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 0/2] libbpf: auto-bumpd RLIMIT_MEMLOCK on old kernels
Date:   Fri, 10 Dec 2021 12:13:31 -0800
Message-ID: <20211210201333.896276-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 4ISYld6LBxz2_SMV1M_k2LSWnNNPMqXA
X-Proofpoint-ORIG-GUID: 4ISYld6LBxz2_SMV1M_k2LSWnNNPMqXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_08,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1034 spamscore=0
 phishscore=0 impostorscore=0 mlxlogscore=409 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make libbpf bump RLIMIT_MEMLOCK, similarly to BCC, if kernel is old enough to
use memcg-based memory accounting for BPF. Patch #2 drops explicit
setrlimi(RLIMIT_MEMLOCK) calls in test_progs, test_maps, and test_verifier.

v1->v2:
  - fix up out-of-sync comments (Toke).

Andrii Nakryiko (2):
  libbpf: auto-bump RLIMIT_MEMLOCK if kernel needs it for BPF
  selftests/bpf: remove explicit setrlimit(RLIMIT_MEMLOCK) in main
    selftests

 tools/lib/bpf/bpf.c                           | 121 ++++++++++++++++++
 tools/lib/bpf/bpf.h                           |   2 +
 tools/lib/bpf/libbpf.c                        |  47 ++-----
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/lib/bpf/libbpf_internal.h               |  39 ++++++
 tools/lib/bpf/libbpf_legacy.h                 |  12 +-
 tools/testing/selftests/bpf/bench.c           |  16 ---
 tools/testing/selftests/bpf/prog_tests/btf.c  |   1 -
 .../bpf/prog_tests/select_reuseport.c         |   1 -
 .../selftests/bpf/prog_tests/sk_lookup.c      |   1 -
 .../selftests/bpf/prog_tests/sock_fields.c    |   1 -
 tools/testing/selftests/bpf/test_maps.c       |   1 -
 tools/testing/selftests/bpf/test_progs.c      |   2 -
 tools/testing/selftests/bpf/test_verifier.c   |   4 +-
 14 files changed, 186 insertions(+), 63 deletions(-)

-- 
2.30.2

