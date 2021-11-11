Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A77544D1AC
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 06:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhKKFj1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 11 Nov 2021 00:39:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42500 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229463AbhKKFjZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 00:39:25 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AB4iiu1012620
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 21:36:37 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c8mxck8yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 21:36:36 -0800
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 10 Nov 2021 21:36:35 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 951E88B0E5FD; Wed, 10 Nov 2021 21:36:25 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 0/9] Future-proof more tricky libbpf APIs
Date:   Wed, 10 Nov 2021 21:36:15 -0800
Message-ID: <20211111053624.190580-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: NSkPM2f00uzyo5RuXoXLJoj3VFTDR6_2
X-Proofpoint-GUID: NSkPM2f00uzyo5RuXoXLJoj3VFTDR6_2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_01,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110029
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set continues the work of revamping libbpf APIs that are not
extensible, as they were added before we figured out all the intricacies of
building APIs that can preserve ABI compatibility (both backward and forward).

What makes them tricky is that (most of) these APIs are actively used by
multiple applications, so we need to be careful about refactoring them. See
individual patches for details, but the general approach is similar to
previous bpf_prog_load() API revamp. The biggest different and complexity is
in changing btf_dump__new(), because function overloading through macro magic
doesn't work based on number of arguments, as both new and old APIs have
4 arguments. Because of that, another overloading approach is taken; overload
happens based on argument types.

I've validated manually (by using local test_progs-shared flavor that is
compiling test_progs against libbpf as a shared library) that compiling "old
application" (selftests before being adapted to using new variants of revamped
APIs) are compiled and successfully run against newest libbpf version as well
as the older libbpf version (provided no new variants are used). All these
scenarios seem to be working as expected.

v1->v2:
  - add explicit printf_fn NULL check in btf_dump__new() (Alexei);
  - replaced + with || in __builtin_choose_expr() (Alexei);
  - dropped test_progs-shared flavor (Alexei).

Andrii Nakryiko (9):
  bpftool: normalize compile rules to specify output file last
  selftests/bpf: minor cleanups and normalization of Makefile
  libbpf: turn btf_dedup_opts into OPTS-based struct
  libbpf: ensure btf_dump__new() and btf_dump_opts are future-proof
  libbpf: make perf_buffer__new() use OPTS-based interface
  selftests/bpf: migrate all deprecated perf_buffer uses
  selftests/bpf: update btf_dump__new() uses to v1.0+ variant
  tools/runqslower: update perf_buffer__new() calls
  bpftool: update btf_dump__new() and perf_buffer__new_raw() calls

 tools/bpf/bpftool/Makefile                    | 16 ++--
 tools/bpf/bpftool/btf.c                       |  2 +-
 tools/bpf/bpftool/gen.c                       |  2 +-
 tools/bpf/bpftool/map_perf_ring.c             |  9 +-
 tools/bpf/runqslower/runqslower.c             |  6 +-
 tools/lib/bpf/btf.c                           | 46 ++++++----
 tools/lib/bpf/btf.h                           | 71 +++++++++++++--
 tools/lib/bpf/btf_dump.c                      | 31 +++++--
 tools/lib/bpf/libbpf.c                        | 70 +++++++++++----
 tools/lib/bpf/libbpf.h                        | 86 ++++++++++++++++---
 tools/lib/bpf/libbpf.map                      |  8 ++
 tools/lib/bpf/linker.c                        |  4 +-
 tools/testing/selftests/bpf/Makefile          | 32 +++----
 .../selftests/bpf/benchs/bench_ringbufs.c     |  8 +-
 tools/testing/selftests/bpf/btf_helpers.c     |  4 +-
 tools/testing/selftests/bpf/prog_tests/btf.c  | 46 ++--------
 .../bpf/prog_tests/btf_dedup_split.c          |  6 +-
 .../selftests/bpf/prog_tests/btf_dump.c       | 33 +++----
 .../selftests/bpf/prog_tests/btf_split.c      |  4 +-
 .../bpf/prog_tests/get_stack_raw_tp.c         |  5 +-
 .../selftests/bpf/prog_tests/kfree_skb.c      |  6 +-
 .../selftests/bpf/prog_tests/perf_buffer.c    |  6 +-
 .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    |  7 +-
 .../selftests/bpf/test_tcpnotify_user.c       |  4 +-
 24 files changed, 318 insertions(+), 194 deletions(-)

-- 
2.30.2

