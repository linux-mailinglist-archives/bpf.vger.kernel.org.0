Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73A544D161
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 06:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhKKFVB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 11 Nov 2021 00:21:01 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63404 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229564AbhKKFVB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 00:21:01 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1AB59YxG011574
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 21:18:12 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3c8p5naede-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 21:18:12 -0800
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 10 Nov 2021 21:18:09 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A5CBE8B08652; Wed, 10 Nov 2021 21:17:59 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/2] selftests/bpf: fix test_progs' log_level logic
Date:   Wed, 10 Nov 2021 21:17:56 -0800
Message-ID: <20211111051758.92283-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: cCG1R0SpZ7iEjymWxFhcKosa5TRdzunD
X-Proofpoint-ORIG-GUID: cCG1R0SpZ7iEjymWxFhcKosa5TRdzunD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_01,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=861 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111110028
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix the ability to request verbose (log_level=1) or very verbose (log_level=2)
logs with test_progs's -vv or -vvv parameters. This ability regressed during
recent bpf_prog_load() API refactoring. Also add
bpf_program__set_extra_flags() API to allow setting extra testing flags
(BPF_F_TEST_RND_HI32), which was also dropped during recent changes.

Andrii Nakryiko (2):
  libbpf: add ability to get/set per-program load flags
  selftests/bpf: fix bpf_prog_test_load() logic to pass extra log level

 tools/lib/bpf/libbpf.c                        | 14 ++++++++++++++
 tools/lib/bpf/libbpf.h                        |  3 +++
 tools/lib/bpf/libbpf.map                      |  2 ++
 tools/testing/selftests/bpf/testing_helpers.c |  7 ++++++-
 4 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.30.2

