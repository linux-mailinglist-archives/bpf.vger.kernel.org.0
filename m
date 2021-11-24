Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE0B45B0A5
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 01:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhKXA0k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 23 Nov 2021 19:26:40 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25840 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231515AbhKXA0k (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 19:26:40 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANMf2IB006883
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:23:32 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ch3jsu62j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:23:31 -0800
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 16:23:31 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 74BA6A666A5D; Tue, 23 Nov 2021 16:23:27 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 00/13] Fix sanitizer-reported libbpf and selftest issues
Date:   Tue, 23 Nov 2021 16:23:12 -0800
Message-ID: <20211124002325.1737739-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: H-ucsh6qgEVkjejGjfqK-4XQGYI_wrI6
X-Proofpoint-ORIG-GUID: H-ucsh6qgEVkjejGjfqK-4XQGYI_wrI6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_08,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After doing another run with ASAN, LSAN, and UBSAN, they turned up a bunch of
new issues not noticed before. Fix all of them in preparation for sanitized
test_progs runs in BPF CI in the near future.

Andrii Nakryiko (13):
  tools/resolve_btf_ids: close ELF file on error
  libbpf: fix potential misaligned memory access in btf_ext__new()
  libbpf: prevent UBSan from complaining about integer overflow
  libbpf: don't call libc APIs with NULL pointers
  libbpf: fix glob_syms memory leak in bpf_linker
  libbpf: fix using invalidated memory in bpf_linker
  selftests/bpf: fix UBSan complaint about signed __int128 overflow
  selftests/bpf: fix possible NULL passed to memcpy() with zero size
  selftests/bpf: prevent misaligned memory access in get_stack_raw_tp
    test
  selftests/bpf: fix misaligned memory access in queue_stack_map test
  selftests/bpf: prevent out-of-bounds stack access in test_bpffs
  selftests/bpf: fix misaligned memory accesses in xdp_bonding test
  selftests/bpf: fix misaligned accesses in xdp and xdp_bpf2bpf tests

 tools/bpf/resolve_btfids/main.c               |  5 +--
 tools/lib/bpf/btf.c                           | 11 +++---
 tools/lib/bpf/btf.h                           |  2 +-
 tools/lib/bpf/libbpf.c                        | 10 ++++--
 tools/lib/bpf/linker.c                        |  6 +++-
 .../selftests/bpf/prog_tests/btf_dump.c       |  2 +-
 .../selftests/bpf/prog_tests/core_reloc.c     |  3 +-
 .../bpf/prog_tests/get_stack_raw_tp.c         | 14 +++++---
 .../bpf/prog_tests/queue_stack_map.c          | 12 ++++---
 .../selftests/bpf/prog_tests/test_bpffs.c     |  4 ++-
 tools/testing/selftests/bpf/prog_tests/xdp.c  | 11 +++---
 .../selftests/bpf/prog_tests/xdp_bonding.c    | 36 ++++++++++---------
 .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    |  6 ++--
 13 files changed, 74 insertions(+), 48 deletions(-)

-- 
2.30.2

