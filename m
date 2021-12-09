Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB1246DFB9
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 01:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbhLIAxB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 8 Dec 2021 19:53:01 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36974 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229846AbhLIAxA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Dec 2021 19:53:00 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8JTtSY026601
        for <bpf@vger.kernel.org>; Wed, 8 Dec 2021 16:49:28 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cttsgwjbc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Dec 2021 16:49:28 -0800
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 16:49:25 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 407C7C523F46; Wed,  8 Dec 2021 16:49:23 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 00/12] Enhance and rework logging controls in libbpf
Date:   Wed, 8 Dec 2021 16:49:08 -0800
Message-ID: <20211209004920.4085377-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: HbFzBdWwuSqVfSqb4lzP3gsUlHb9fUsm
X-Proofpoint-GUID: HbFzBdWwuSqVfSqb4lzP3gsUlHb9fUsm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_08,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112090002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add new open options and per-program setters to control BTF and program
loading log verboseness and allow providing custom log buffers to capture logs
of interest. Note how custom log_buf and log_level are orthogonal, which
matches previous (alas less customizable) behavior of libbpf, even though it
sort of worked by accident: if someone specified log_level = 1 in
bpf_object__load_xattr(), first attempt to load any BPF program resulted in
wasted bpf() syscall with -EINVAL due to !!log_buf != !!log_level. Then on
retry libbpf would allocated log_buffer and try again, after which prog
loading would succeed and libbpf would print verbose program loading log
through its print callback.

This behavior is now documented and made more efficient, not wasting
unnecessary syscall. But additionally, log_level can be controlled globally on
a per-bpf_object level through bpf_object_open_opts, as well as on
a per-program basis with bpf_program__set_log_buf() and
bpf_program__set_log_level() APIs.

Now that we have a more future-proof way to set log_level, deprecate
bpf_object__load_xattr().

v1->v2:
  - fix log_level == 0 handling of bpf_prog_load, add as patch #1 (Alexei);
  - add comments explaining log_buf_size overflow prevention (Alexei).

Andrii Nakryiko (12):
  libbpf: fix bpf_prog_load() log_buf logic for log_level 0
  libbpf: add OPTS-based bpf_btf_load() API
  libbpf: allow passing preallocated log_buf when loading BTF into
    kernel
  libbpf: allow passing user log setting through bpf_object_open_opts
  libbpf: improve logging around BPF program loading
  libbpf: preserve kernel error code and remove kprobe prog type
    guessing
  libbpf: add per-program log buffer setter and getter
  libbpf: deprecate bpf_object__load_xattr()
  selftests/bpf: replace all uses of bpf_load_btf() with bpf_btf_load()
  selftests/bpf: add test for libbpf's custom log_buf behavior
  selftests/bpf: remove the only use of deprecated
    bpf_object__load_xattr()
  bpftool: switch bpf_object__load_xattr() to bpf_object__load()

 tools/bpf/bpftool/gen.c                       |  11 +-
 tools/bpf/bpftool/prog.c                      |  24 +--
 tools/bpf/bpftool/struct_ops.c                |  15 +-
 tools/lib/bpf/bpf.c                           |  88 ++++++--
 tools/lib/bpf/bpf.h                           |  22 +-
 tools/lib/bpf/btf.c                           |  78 ++++---
 tools/lib/bpf/libbpf.c                        | 194 ++++++++++++------
 tools/lib/bpf/libbpf.h                        |  49 ++++-
 tools/lib/bpf/libbpf.map                      |   3 +
 tools/lib/bpf/libbpf_internal.h               |   1 +
 tools/lib/bpf/libbpf_probes.c                 |   2 +-
 .../selftests/bpf/map_tests/sk_storage_map.c  |   2 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |   6 +-
 tools/testing/selftests/bpf/prog_tests/btf.c  |  50 +++--
 .../selftests/bpf/prog_tests/log_buf.c        | 137 +++++++++++++
 .../selftests/bpf/progs/test_log_buf.c        |  24 +++
 tools/testing/selftests/bpf/test_verifier.c   |   2 +-
 tools/testing/selftests/bpf/testing_helpers.c |  10 +-
 18 files changed, 544 insertions(+), 174 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/log_buf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_log_buf.c

-- 
2.30.2

