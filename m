Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DE9468D3F
	for <lists+bpf@lfdr.de>; Sun,  5 Dec 2021 21:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbhLEUgU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 5 Dec 2021 15:36:20 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44050 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238456AbhLEUgT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 5 Dec 2021 15:36:19 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1B5AZBnT025839
        for <bpf@vger.kernel.org>; Sun, 5 Dec 2021 12:32:51 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3crpx6jyxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 05 Dec 2021 12:32:51 -0800
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 5 Dec 2021 12:32:49 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 151FBBFD7792; Sun,  5 Dec 2021 12:32:38 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 00/11] Enhance and rework logging controls in libbpf
Date:   Sun, 5 Dec 2021 12:32:23 -0800
Message-ID: <20211205203234.1322242-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: zUhfjhDnimudat2Dd9l1wsRFaySFSUSo
X-Proofpoint-ORIG-GUID: zUhfjhDnimudat2Dd9l1wsRFaySFSUSo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-05_11,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 mlxlogscore=939 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112050123
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

Andrii Nakryiko (11):
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
 tools/lib/bpf/bpf.c                           |  46 ++++-
 tools/lib/bpf/bpf.h                           |  22 +-
 tools/lib/bpf/btf.c                           |  78 +++++---
 tools/lib/bpf/libbpf.c                        | 188 ++++++++++++------
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
 18 files changed, 509 insertions(+), 161 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/log_buf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_log_buf.c

-- 
2.30.2

