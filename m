Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193632CB16C
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 01:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgLBAYn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 1 Dec 2020 19:24:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17914 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726516AbgLBAYn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Dec 2020 19:24:43 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B20GuEc021821
        for <bpf@vger.kernel.org>; Tue, 1 Dec 2020 16:24:02 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3547g8qwu2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 16:24:02 -0800
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 1 Dec 2020 16:24:00 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 7802D2ECA70C; Tue,  1 Dec 2020 16:23:55 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v4 bpf-next 00/14] Support BTF-powered BPF tracing programs for kernel modules
Date:   Tue, 1 Dec 2020 16:16:02 -0800
Message-ID: <20201202001616.3378929-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_12:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 phishscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch sets extends kernel and libbpf with support for attaching
BTF-powered raw tracepoint (tp_btf) and tracing (fentry/fexit/fmod_ret/lsm)
BPF programs to BPF hooks defined in kernel modules. As part of that, libbpf
now supports performing CO-RE relocations against types in kernel module BTFs,
in addition to existing vmlinux BTF support.

Kernel UAPI for BPF_PROG_LOAD is extended with extra parameter
(attach_btf_obj_id) which allows to specify kernel module BTF in which the BTF
type is identifed by attach_btf_id.

This patch set also sets up a convenient and fully-controlled custom kernel
module (called "bpf_testmod"), that is a predictable playground for all the
BPF selftests, that rely on module BTFs. Currently pahole doesn't generate
BTF_KIND_FUNC info for ftrace-able static functions in kernel modules, so
expose traced function in bpf_sidecar.ko. Once pahole is enhanced, we can go
back to static function.

From end user perspective there are no extra actions that need to happen.
Libbpf will continue searching across all kernel module BTFs, if desired
attach BTF type is not found in vmlinux. That way it doesn't matter if BPF
hook that user is trying to attach to is built into vmlinux image or is
loaded in kernel module.

v3->v4:
  - merge together patch sets [0] and [1];
  - avoid increasing bpf_reg_state by reordering fields (Alexei);
  - preserve btf_data_size in struct module;

v2->v3:
  - fix subtle uninitialized variable use in BTF ID iteration code;

v1->v2:
  - module_put() inside preempt_disable() region (Alexei);
  - bpf_sidecar -> bpf_testmod rename (Alexei);
  - test_progs more relaxed handling of bpf_testmod;
  - test_progs marks skipped sub-tests properly as SKIP now.

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=393677&state=*
  [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=393679&state=*

Andrii Nakryiko (14):
  bpf: fix bpf_put_raw_tracepoint()'s use of __module_address()
  bpf: keep module's btf_data_size intact after load
  libbpf: add internal helper to load BTF data by FD
  libbpf: refactor CO-RE relocs to not assume a single BTF object
  libbpf: add kernel module BTF support for CO-RE relocations
  selftests/bpf: add bpf_testmod kernel module for testing
  selftests/bpf: add support for marking sub-tests as skipped
  selftests/bpf: add CO-RE relocs selftest relying on kernel module BTF
  bpf: remove hard-coded btf_vmlinux assumption from BPF verifier
  bpf: allow to specify kernel module BTFs when attaching BPF programs
  libbpf: factor out low-level BPF program loading helper
  libbpf: support attachment of BPF tracing programs to kernel modules
  selftests/bpf: add tp_btf CO-RE reloc test for modules
  selftests/bpf: add fentry/fexit/fmod_ret selftest for kernel module

 include/linux/bpf.h                           |  13 +-
 include/linux/bpf_verifier.h                  |  28 +-
 include/linux/btf.h                           |   7 +-
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              |  90 +++-
 kernel/bpf/syscall.c                          |  44 +-
 kernel/bpf/verifier.c                         |  77 +--
 kernel/module.c                               |   1 -
 kernel/trace/bpf_trace.c                      |   8 +-
 net/ipv4/bpf_tcp_ca.c                         |   3 +-
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/bpf.c                           | 101 ++--
 tools/lib/bpf/btf.c                           |  61 ++-
 tools/lib/bpf/libbpf.c                        | 490 +++++++++++++-----
 tools/lib/bpf/libbpf_internal.h               |  31 ++
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |  12 +-
 .../selftests/bpf/bpf_testmod/.gitignore      |   6 +
 .../selftests/bpf/bpf_testmod/Makefile        |  20 +
 .../bpf/bpf_testmod/bpf_testmod-events.h      |  36 ++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  52 ++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  14 +
 .../selftests/bpf/prog_tests/core_reloc.c     |  80 ++-
 .../selftests/bpf/prog_tests/module_attach.c  |  53 ++
 .../selftests/bpf/progs/core_reloc_types.h    |  17 +
 .../bpf/progs/test_core_reloc_module.c        |  96 ++++
 .../selftests/bpf/progs/test_module_attach.c  |  66 +++
 tools/testing/selftests/bpf/test_progs.c      |  65 ++-
 tools/testing/selftests/bpf/test_progs.h      |   1 +
 29 files changed, 1204 insertions(+), 271 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/.gitignore
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/Makefile
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/module_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_module_attach.c

-- 
2.24.1

