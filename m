Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFBA4473E6
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 17:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhKGQtW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 7 Nov 2021 11:49:22 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10276 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235819AbhKGQtQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 7 Nov 2021 11:49:16 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A7AvQcZ019285
        for <bpf@vger.kernel.org>; Sun, 7 Nov 2021 08:46:32 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c67uebntc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 07 Nov 2021 08:46:32 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 7 Nov 2021 08:46:31 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 81008838FABC; Sun,  7 Nov 2021 08:46:25 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v3 bpf-next 0/9] Fix leaks in libbpf and selftests
Date:   Sun, 7 Nov 2021 08:46:15 -0800
Message-ID: <20211107164624.4137512-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: d1Vdz6AdvODHPeHrnLyhsbpnhIE36bjf
X-Proofpoint-ORIG-GUID: d1Vdz6AdvODHPeHrnLyhsbpnhIE36bjf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-07_09,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=918 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111070108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix all the memory leaks reported by ASAN. All but one are just improper
resource clean up in selftests. But one memory leak was discovered in libbpf,
leaving inner map's name leaked.

First patch fixes selftests' Makefile by passing through SAN_CFLAGS to linker.
Without that compiling with SAN_CFLAGS=-fsanitize=address kept failing.

Running selftests under ASAN in BPF CI is the next step, we just need to make
sure all the necessary libraries (libasan and liblsan) are installed on the
host and inside the VM. Would be great to get some help with that, but for now
make sure that test_progs run is clean from leak sanitizer errors.

v2->v3:
  - fix per-cpu array memory leaks in btf_iter.c selftests (Hengqi);
v1->v2:
  - call bpf_map__destroy() conditionally if map->inner_map is present.

Andrii Nakryiko (9):
  selftests/bpf: pass sanitizer flags to linker through LDFLAGS
  libbpf: free up resources used by inner map definition
  selftests/bpf: fix memory leaks in btf_type_c_dump() helper
  selftests/bpf: free per-cpu values array in bpf_iter selftest
  selftests/bpf: free inner strings index in btf selftest
  selftests/bpf: clean up btf and btf_dump in dump_datasec test
  selftests/bpf: avoid duplicate btf__parse() call
  selftests/bpf: destroy XDP link correctly
  selftests/bpf: fix bpf_object leak in skb_ctx selftest

 tools/lib/bpf/libbpf.c                                   | 5 ++++-
 tools/testing/selftests/bpf/Makefile                     | 1 +
 tools/testing/selftests/bpf/btf_helpers.c                | 9 +++++++--
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c        | 8 ++++----
 tools/testing/selftests/bpf/prog_tests/btf.c             | 6 ++----
 tools/testing/selftests/bpf/prog_tests/btf_dump.c        | 8 ++++++--
 tools/testing/selftests/bpf/prog_tests/core_reloc.c      | 2 +-
 .../testing/selftests/bpf/prog_tests/migrate_reuseport.c | 4 ++--
 tools/testing/selftests/bpf/prog_tests/skb_ctx.c         | 2 ++
 9 files changed, 29 insertions(+), 16 deletions(-)

-- 
2.30.2

