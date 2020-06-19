Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87D3201C73
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 22:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389767AbgFSUd1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 16:33:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6126 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389257AbgFSUd0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Jun 2020 16:33:26 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05JKR3Sa020787
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 13:33:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=vy/0AoJ51tt/pnPI5De3UimmiYaGEdBXsh+0C7B3Usw=;
 b=YGEoGOCGlIw9oWRdfQli8813dSFApV3jzIbMTv9tfpGY3d8FW6lFFhE7TNwIGhEfThwT
 xpf5pXPJybIEO9SrW3N/RQnELzFDomfBy+2qXr4Znp2kubrhTRE/5bL9LPtw8OPCFmZs
 qcMOU1ScpGIGe0ldJ517de0z6M8EZzL88Ak= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 31rcbe9h7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 13:33:25 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 13:33:24 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 6BACD2EC30E4; Fri, 19 Jun 2020 13:30:27 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 0/9] libbpf ksym support and bpftool show PIDs
Date:   Fri, 19 Jun 2020 13:30:16 -0700
Message-ID: <20200619203026.78267-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_21:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 cotscore=-2147483648 malwarescore=0 adultscore=0 impostorscore=0
 bulkscore=0 suspectscore=8 mlxscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190145
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set implements libbpf support for a second kind of special ext=
erns,
kernel symbols, in addition to existing Kconfig externs.=20

Right now, only untyped (const void) externs are supported, which, in
C language, allow only to take their address. In the future, with kernel =
BTF
getting type info about its own global and per-cpu variables, libbpf will
extend this support with BTF type info, which will allow to also directly
access variable's contents and follow its internal pointers, similarly to=
 how
it's possible today in fentry/fexit programs.

As a first practical use of this functionality, bpftool gained ability to=
 show
PIDs of processes that have open file descriptors for BPF map/program/lin=
k/BTF
object. It relies on iter/task_file BPF iterator program to extract this
information efficiently.

There was a bunch of bpftool refactoring (especially Makefile) necessary =
to
generalize bpftool's internal BPF program use. This includes generalizati=
on of
BPF skeletons support, addition of a vmlinux.h generation, extracting and
building minimal subset of bpftool for bootstrapping.

v1->v2:
- docs fixes (Quentin);
- dual GPL/BSD license for pid_inter.bpf.c (Quentin);
- NULL-init kcfg_data (Hao Luo);

rfc -> v1:
- show pids, if supported by kernel, always (Alexei);
- switched iter output to binary to support showing process names;
- update man pages;
- fix few minor bugs in libbpf w.r.t. extern iteration.

Cc: Hao Luo <haoluo@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Quentin Monnet <quentin@isovalent.com>


Andrii Nakryiko (9):
  libbpf: generalize libbpf externs support
  libbpf: add support for extracting kernel symbol addresses
  selftests/bpf: add __ksym extern selftest
  tools/bpftool: move map/prog parsing logic into common
  tools/bpftool: minimize bootstrap bpftool
  tools/bpftool: generalize BPF skeleton support and generate vmlinux.h
  libbpf: wrap source argument of BPF_CORE_READ macro in parentheses
  tools/bpftool: show info for processes holding BPF map/prog/link/btf
    FDs
  tools/bpftool: add documentation and sample output for process info

 tools/bpf/bpftool/.gitignore                  |   5 +-
 .../bpf/bpftool/Documentation/bpftool-btf.rst |   5 +
 .../bpftool/Documentation/bpftool-link.rst    |  13 +-
 .../bpf/bpftool/Documentation/bpftool-map.rst |   8 +-
 .../bpftool/Documentation/bpftool-prog.rst    |  11 +
 tools/bpf/bpftool/Makefile                    |  60 ++-
 tools/bpf/bpftool/btf.c                       |   6 +
 tools/bpf/bpftool/common.c                    | 308 +++++++++++
 tools/bpf/bpftool/link.c                      |   7 +
 tools/bpf/bpftool/main.c                      |  12 +-
 tools/bpf/bpftool/main.h                      |  56 +-
 tools/bpf/bpftool/map.c                       | 163 +-----
 tools/bpf/bpftool/pids.c                      | 229 +++++++++
 tools/bpf/bpftool/prog.c                      | 159 +-----
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c     |  80 +++
 tools/bpf/bpftool/skeleton/pid_iter.h         |  12 +
 tools/bpf/bpftool/skeleton/profiler.bpf.c     |   3 +-
 tools/bpf/bpftool/skeleton/profiler.h         |  46 --
 tools/build/feature/Makefile                  |   4 +-
 tools/build/feature/test-clang-bpf-co-re.c    |   9 +
 .../build/feature/test-clang-bpf-global-var.c |   4 -
 tools/lib/bpf/bpf_core_read.h                 |   8 +-
 tools/lib/bpf/bpf_helpers.h                   |   1 +
 tools/lib/bpf/btf.h                           |   5 +
 tools/lib/bpf/libbpf.c                        | 484 ++++++++++++------
 .../testing/selftests/bpf/prog_tests/ksyms.c  |  71 +++
 .../testing/selftests/bpf/progs/test_ksyms.c  |  32 ++
 27 files changed, 1253 insertions(+), 548 deletions(-)
 create mode 100644 tools/bpf/bpftool/pids.c
 create mode 100644 tools/bpf/bpftool/skeleton/pid_iter.bpf.c
 create mode 100644 tools/bpf/bpftool/skeleton/pid_iter.h
 delete mode 100644 tools/bpf/bpftool/skeleton/profiler.h
 create mode 100644 tools/build/feature/test-clang-bpf-co-re.c
 delete mode 100644 tools/build/feature/test-clang-bpf-global-var.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksyms.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms.c

--=20
2.24.1

