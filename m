Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EA91F7EEE
	for <lists+bpf@lfdr.de>; Sat, 13 Jun 2020 00:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgFLWe5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Jun 2020 18:34:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49354 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbgFLWe5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Jun 2020 18:34:57 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CM6kSv016365
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 15:34:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=6H9d0buiwMmfzcCnKuHgzaiREIh/QAARG0Kzs/57HkU=;
 b=QCIlc3eyeeiwD/c9HTIvS2xmA7DwFRV5feYsfci3wNVN/QuNVoXUg6XuLHrmxIL/ZPGZ
 iJZLJgXI0dQpAF79Mm9BNiZj3oMOqlzA/dfy0HWFKYoxnV7mvlaXFQsSQ/jnuMz70BlJ
 1vQuKE/HCCFJCwDP9tv2g0BkdcbytKq33Os= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31juxj6yq1-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 15:34:56 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 12 Jun 2020 15:34:43 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id EDA0B2EC1CA6; Fri, 12 Jun 2020 15:31:57 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 0/8] libbpf ksym support and bpftool show PIDs
Date:   Fri, 12 Jun 2020 15:31:42 -0700
Message-ID: <20200612223150.1177182-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_17:2020-06-12,2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 cotscore=-2147483648
 suspectscore=8 bulkscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120164
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
extend this support with BTF type info, which will allow additionally to
directly access variable's contents and follow internal pointers, similar=
ly to
how it's possible today in fentry/fexit programs.

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

This RFC seeks feedback on ksym externs support in libbpf. The way it is
designed and supported should be naturally extended with backwards
compatibility in mind for when kernel will get support for kernel global
variables access through BPF.

Please also provide your feedback bpftool support for showing PIDs and an=
d how
it could be done better. I'll update existing bpftool man pages and
bash-completion with examples of output and new flag in v1, after gather
initial feedback.

Cc: Hao Luo <haoluo@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Quentin Monnet <quentin@isovalent.com>

Andrii Nakryiko (8):
  libbpf: generalize libbpf externs support
  libbpf: add support for extracting kernel symbol addresses
  selftests/bpf: add __ksym extern selftest
  tools/bpftool: move map/prog parsing logic into common
  tools/bpftool: minimize bootstrap bpftool
  tools/bpftool: generalize BPF skeleton support and generate vmlinux.h
  libbpf: wrap source argument of BPF_CORE_READ macro in parentheses
  tools/bpftool: show PIDs with FDs open against BPF map/prog/link/btf

 tools/bpf/bpftool/.gitignore                  |   5 +-
 tools/bpf/bpftool/Makefile                    |  60 ++-
 tools/bpf/bpftool/btf.c                       |  39 ++
 tools/bpf/bpftool/common.c                    | 308 ++++++++++++
 tools/bpf/bpftool/link.c                      |  40 ++
 tools/bpf/bpftool/main.c                      |  19 +-
 tools/bpf/bpftool/main.h                      |  47 +-
 tools/bpf/bpftool/map.c                       | 195 ++------
 tools/bpf/bpftool/pids.c                      | 150 ++++++
 tools/bpf/bpftool/prog.c                      | 192 ++------
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c     |  77 +++
 tools/bpf/bpftool/skeleton/profiler.bpf.c     |   3 +-
 tools/bpf/bpftool/skeleton/profiler.h         |  46 --
 tools/build/feature/Makefile                  |   4 +-
 tools/build/feature/test-clang-bpf-co-re.c    |   9 +
 .../build/feature/test-clang-bpf-global-var.c |   4 -
 tools/lib/bpf/bpf_core_read.h                 |   8 +-
 tools/lib/bpf/bpf_helpers.h                   |   1 +
 tools/lib/bpf/btf.h                           |   5 +
 tools/lib/bpf/libbpf.c                        | 464 +++++++++++++-----
 .../testing/selftests/bpf/prog_tests/ksyms.c  |  71 +++
 .../testing/selftests/bpf/progs/test_ksyms.c  |  32 ++
 22 files changed, 1240 insertions(+), 539 deletions(-)
 create mode 100644 tools/bpf/bpftool/pids.c
 create mode 100644 tools/bpf/bpftool/skeleton/pid_iter.bpf.c
 delete mode 100644 tools/bpf/bpftool/skeleton/profiler.h
 create mode 100644 tools/build/feature/test-clang-bpf-co-re.c
 delete mode 100644 tools/build/feature/test-clang-bpf-global-var.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksyms.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms.c

--=20
2.24.1

