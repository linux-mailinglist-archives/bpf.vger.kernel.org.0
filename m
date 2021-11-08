Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B43D447A5C
	for <lists+bpf@lfdr.de>; Mon,  8 Nov 2021 07:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbhKHGQL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 8 Nov 2021 01:16:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40118 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237676AbhKHGQI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Nov 2021 01:16:08 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A799lq0001267
        for <bpf@vger.kernel.org>; Sun, 7 Nov 2021 22:13:24 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c6atd53dj-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 07 Nov 2021 22:13:23 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 7 Nov 2021 22:13:20 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5621E84C4979; Sun,  7 Nov 2021 22:13:17 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 00/11] Future-proof more tricky libbpf APIs
Date:   Sun, 7 Nov 2021 22:13:05 -0800
Message-ID: <20211108061316.203217-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: aAZdtyZLb7dWizRLAjBx6-XnBOhLTwbz
X-Proofpoint-ORIG-GUID: aAZdtyZLb7dWizRLAjBx6-XnBOhLTwbz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080041
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

To validate that not just source code compatibility is preserved, but that
applications using libbpf as a shared library stay compatible as well, first
few patches extend selftests/bpf with another flavor of test_progs (-shared),
that compiles against libbpf.so. Using this flavor I've validated manually
that compiling "old application" (selftests before being adapted to using new
variants of revamped APIs) are compiled and successfully run against newest
libbpf version as well as the older libbpf version (provided no new variants
are used). All these scenarios seem to be working as expected.

Currently, the way that selftests are set up we'll build three variants of BPF
object files (alu32, no-alu32, and alu32 but for shared flavor), which is
suboptimal. It is possible to rework Makefile to only generate alu32 vs
no-alu32 variants and use them in appropriate flavors, minimizing unnecessary
work. But that was left for follow up patches as there are already a lot of
changes across selftests and libbpf.

Andrii Nakryiko (11):
  bpftool: normalize compile rules to specify output file last
  selftests/bpf: minor cleanups and normalization of Makefile
  selftests/bpf: allow to generate per-flavor list of tests
  selftests/bpf: add test_progs flavor using libbpf as a shared lib
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
 tools/lib/bpf/btf.c                           | 46 +++++----
 tools/lib/bpf/btf.h                           | 72 ++++++++++++--
 tools/lib/bpf/btf_dump.c                      | 26 ++++--
 tools/lib/bpf/libbpf.c                        | 70 +++++++++++---
 tools/lib/bpf/libbpf.h                        | 86 ++++++++++++++---
 tools/lib/bpf/libbpf.map                      |  8 ++
 tools/lib/bpf/linker.c                        |  4 +-
 tools/testing/selftests/bpf/.gitignore        |  9 +-
 tools/testing/selftests/bpf/Makefile          | 93 +++++++++++--------
 .../selftests/bpf/benchs/bench_ringbufs.c     |  8 +-
 tools/testing/selftests/bpf/btf_helpers.c     |  4 +-
 tools/testing/selftests/bpf/prog_tests/btf.c  | 46 ++-------
 .../bpf/prog_tests/btf_dedup_split.c          |  6 +-
 .../selftests/bpf/prog_tests/btf_dump.c       | 33 +++----
 .../selftests/bpf/prog_tests/btf_split.c      |  4 +-
 .../bpf/prog_tests/get_stack_raw_tp.c         |  5 +-
 .../selftests/bpf/prog_tests/kfree_skb.c      |  6 +-
 .../selftests/bpf/prog_tests/perf_buffer.c    |  6 +-
 .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    |  7 +-
 tools/testing/selftests/bpf/test_maps.c       |  4 +-
 tools/testing/selftests/bpf/test_progs.c      |  6 +-
 .../selftests/bpf/test_tcpnotify_user.c       |  4 +-
 27 files changed, 363 insertions(+), 225 deletions(-)

-- 
2.30.2

