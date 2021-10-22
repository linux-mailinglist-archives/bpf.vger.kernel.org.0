Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B2743803F
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 00:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhJVWex convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 22 Oct 2021 18:34:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35210 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233793AbhJVWew (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 Oct 2021 18:34:52 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19MLBTFn023358
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 15:32:34 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3buu1ydhtp-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 15:32:34 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 22 Oct 2021 15:32:32 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5180670D5F5C; Fri, 22 Oct 2021 15:32:30 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/4] Parallelize verif_scale selftests
Date:   Fri, 22 Oct 2021 15:32:24 -0700
Message-ID: <20211022223228.99920-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: DGkmVXxlh3g6IzmN7NFRdi8gph9OKBhH
X-Proofpoint-ORIG-GUID: DGkmVXxlh3g6IzmN7NFRdi8gph9OKBhH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_05,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=728
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110220126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Reduce amount of waiting time when running test_progs in parallel mode (-j) by
splitting bpf_verif_scale selftests into multiple tests. Previously it was
structured as a test with multiple subtests, but subtests are not easily
parallelizable with test_progs' infra. Also in practice each scale subtest is
really an independent test with nothing shared across all substest.

This patch set changes how test_progs test discovery works. Now it is possible
to define multiple tests within a single source code file. One of the patches
also marks tc_redirect selftests as serial, because it's extremely harmful to
the test system when run in parallel mode.

Andrii Nakryiko (4):
  selftests/bpf: normalize selftest entry points
  selftests/bpf: support multiple tests per file
  selftests/bpf: mark tc_redirect selftest as serial
  selftests/bpf: split out bpf_verif_scale selftests into multiple tests

 tools/testing/selftests/bpf/Makefile          |   7 +-
 .../bpf/prog_tests/bpf_verif_scale.c          | 220 ++++++++++++------
 .../selftests/bpf/prog_tests/btf_dump.c       |   2 +-
 .../selftests/bpf/prog_tests/resolve_btfids.c |  10 +-
 .../selftests/bpf/prog_tests/signal_pending.c |   2 +-
 .../selftests/bpf/prog_tests/snprintf.c       |   4 +-
 .../selftests/bpf/prog_tests/tc_redirect.c    |   2 +-
 .../bpf/prog_tests/xdp_adjust_tail.c          |   6 +-
 .../bpf/prog_tests/xdp_devmap_attach.c        |   4 +-
 9 files changed, 169 insertions(+), 88 deletions(-)

-- 
2.30.2

