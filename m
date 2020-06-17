Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1081FD1D8
	for <lists+bpf@lfdr.de>; Wed, 17 Jun 2020 18:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgFQQVe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 12:21:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1472 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbgFQQVd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Jun 2020 12:21:33 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HGFYue032101
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 09:21:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=6bFP+Xzc2xdJu0TuKt9N3ue977E9TVzgGzNKPoftMUQ=;
 b=PahKFQuIgzjpFjCqWmVqLje3OJgn43k5q9C1qNCW/4yvZvsFUXbnsCUG4mVdqRZthvER
 KhzYtomGCOYaI12N7CA3tcyqYi4KEsjOe4TTS45hydkHDftY7etjBEkQjhAiAE1nPu98
 l3HGL3gOj9RbNyZd2stY2UO04iUovuRqx3Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q660nbrx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 09:21:32 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Jun 2020 09:21:31 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 32B482EC350D; Wed, 17 Jun 2020 09:18:52 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/9] libbpf ksym support and bpftool show PIDs
Date:   Wed, 17 Jun 2020 09:18:23 -0700
Message-ID: <20200617161832.1438371-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_06:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=8
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006170129
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

