Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB58447158
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 04:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhKGD7E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 6 Nov 2021 23:59:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20342 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231126AbhKGD7E (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 6 Nov 2021 23:59:04 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A70Uod7006293
        for <bpf@vger.kernel.org>; Sat, 6 Nov 2021 20:56:21 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3c5n7ccj97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 06 Nov 2021 20:56:21 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sat, 6 Nov 2021 20:56:20 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 281FA8288914; Sat,  6 Nov 2021 20:56:14 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/9] Fix leaks in libbpf and selftests
Date:   Sat, 6 Nov 2021 20:56:10 -0700
Message-ID: <20211107035610.536469-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 56cxt842-nGaMGoVOyal_mOoaWncFW6f
X-Proofpoint-GUID: 56cxt842-nGaMGoVOyal_mOoaWncFW6f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-07_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=902 suspectscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111070022
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

 tools/lib/bpf/libbpf.c                                   | 1 +
 tools/testing/selftests/bpf/Makefile                     | 1 +
 tools/testing/selftests/bpf/btf_helpers.c                | 9 +++++++--
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c        | 1 +
 tools/testing/selftests/bpf/prog_tests/btf.c             | 6 ++----
 tools/testing/selftests/bpf/prog_tests/btf_dump.c        | 8 ++++++--
 tools/testing/selftests/bpf/prog_tests/core_reloc.c      | 2 +-
 .../testing/selftests/bpf/prog_tests/migrate_reuseport.c | 4 ++--
 tools/testing/selftests/bpf/prog_tests/skb_ctx.c         | 2 ++
 9 files changed, 23 insertions(+), 11 deletions(-)

-- 
2.30.2

