Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB14B11EF9B
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2019 02:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfLNBnr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Dec 2019 20:43:47 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51160 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726741AbfLNBnr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Dec 2019 20:43:47 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBE1b1aE025173
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2019 17:43:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=qvrsnLENNQhCUj8a8R1laUZ8CCB5QyTiCurLQ7mIgek=;
 b=RvnXSSxOjn54bD815sUVGFmcXgzmE0cqRdoPa6cWhAH4ob5D15LzCSR0DIlvPPJIaB/j
 hZ8AWV459qPGGPqryZ53mmQsJSZVaw2FUMtOncHhAvnR50FnW3w4DBochHkuczNcEVUp
 a4aIbBEUtGvJ0PUIF7/NTSS6s04CyQqYKco= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wvp7hg0k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2019 17:43:46 -0800
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Dec 2019 17:43:44 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 910732EC1D51; Fri, 13 Dec 2019 17:43:43 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 bpf-next 00/17] Add code-generated BPF object skeleton support
Date:   Fri, 13 Dec 2019 17:43:24 -0800
Message-ID: <20191214014341.3442258-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_09:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=9 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912140006
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set introduces an alternative and complimentary to existing libbpf
API interface for working with BPF objects, maps, programs, and global data
from userspace side. This approach is relying on code generation. bpftool
produces a struct (a.k.a. skeleton) tailored and specific to provided BPF
object file. It includes hard-coded fields and data structures for every map,
program, link, and global data present.

Altogether this approach significantly reduces amount of userspace boilerplate
code required to open, load, attach, and work with BPF objects. It improves
attach/detach story, by providing pre-allocated space for bpf_links, and
ensuring they are properly detached on shutdown. It allows to do away with by
name/title lookups of maps and programs, because libbpf's skeleton API, in
conjunction with generated code from bpftool, is filling in hard-coded fields
with actual pointers to corresponding struct bpf_map/bpf_program/bpf_link.

Also, thanks to BPF array mmap() support, working with global data (variables)
from userspace is now as natural as it is from BPF side: each variable is just
a struct field inside skeleton struct. Furthermore, this allows to have
a natural way for userspace to pre-initialize global data (including
previously impossible to initialize .rodata) by just assigning values to the
same per-variable fields. Libbpf will carefully take into account this
initialization image, will use it to pre-populate BPF maps at creation time,
and will re-mmap() BPF map's contents at exactly the same userspace memory
address such that it can continue working with all the same pointers without
any interruptions. If kernel doesn't support mmap(), global data will still be
successfully initialized, but after map creation global data structures inside
skeleton will be NULL-ed out. This allows userspace application to gracefully
handle lack of mmap() support, if necessary.

A bunch of selftests are also converted to using skeletons, demonstrating
significant simplification of userspace part of test and reduction in amount
of code necessary.

v3->v4:
- add OPTS_VALID check to btf_dump__emit_type_decl (Alexei);
- expose skeleton as LIBBPF_API functions (Alexei);
- copyright clean up, update internal map init refactor (Alexei);

v2->v3:
- make skeleton part of public API;
- expose btf_dump__emit_type_decl and btf__align_of APIs;
- move LIBBPF_API and DECLARE_LIBBPF_OPTS into libbpf_common.h for reuse;

v1->v2:
- checkpatch.pl and reverse Christmas tree styling (Jakub);
- sanitize variable names to accomodate in-function static vars;

rfc->v1:
- runqslower moved out into separate patch set waiting for vmlinux.h
  improvements;
- skeleton generation code deals with unknown internal maps more gracefully.


Andrii Nakryiko (17):
  libbpf: don't require root for bpf_object__open()
  libbpf: add generic bpf_program__attach()
  libbpf: move non-public APIs from libbpf.h to libbpf_internal.h
  libbpf: add BPF_EMBED_OBJ macro for embedding BPF .o files
  libbpf: extract common user-facing helpers
  libbpf: expose btf__align_of() API
  libbpf: expose BTF-to-C type declaration emitting API
  libbpf: expose BPF program's function name
  libbpf: refactor global data map initialization
  libbpf: postpone BTF ID finding for TRACING programs to load phase
  libbpf: reduce log level of supported section names dump
  libbpf: add BPF object skeleton support
  bpftool: add skeleton codegen command
  selftests/bpf: add BPF skeletons selftests and convert attach_probe.c
  selftests/bpf: convert few more selftest to skeletons
  selftests/bpf: add test validating data section to struct convertion
    layout
  bpftool: add `gen skeleton` BASH completions

 tools/bpf/bpftool/bash-completion/bpftool     |  11 +
 tools/bpf/bpftool/gen.c                       | 551 ++++++++++++++++
 tools/bpf/bpftool/main.c                      |   3 +-
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/net.c                       |   1 +
 tools/lib/bpf/bpf.h                           |   6 +-
 tools/lib/bpf/btf.c                           |  39 ++
 tools/lib/bpf/btf.h                           |  29 +-
 tools/lib/bpf/btf_dump.c                      | 115 ++--
 tools/lib/bpf/libbpf.c                        | 588 ++++++++++++++----
 tools/lib/bpf/libbpf.h                        | 129 ++--
 tools/lib/bpf/libbpf.map                      |  11 +
 tools/lib/bpf/libbpf_common.h                 |  38 ++
 tools/lib/bpf/libbpf_internal.h               |  17 +
 tools/testing/selftests/bpf/.gitignore        |   2 +
 tools/testing/selftests/bpf/Makefile          |  36 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 154 +----
 .../selftests/bpf/prog_tests/fentry_fexit.c   | 105 ++--
 .../selftests/bpf/prog_tests/fentry_test.c    |  72 +--
 tools/testing/selftests/bpf/prog_tests/mmap.c |  58 +-
 .../selftests/bpf/prog_tests/probe_user.c     |   6 +-
 .../selftests/bpf/prog_tests/rdonly_maps.c    |  11 +-
 .../selftests/bpf/prog_tests/skeleton.c       |  51 ++
 .../bpf/prog_tests/stacktrace_build_id.c      |  79 +--
 .../bpf/prog_tests/stacktrace_build_id_nmi.c  |  84 +--
 .../selftests/bpf/progs/test_attach_probe.c   |  34 +-
 .../selftests/bpf/progs/test_skeleton.c       |  37 ++
 27 files changed, 1598 insertions(+), 670 deletions(-)
 create mode 100644 tools/bpf/bpftool/gen.c
 create mode 100644 tools/lib/bpf/libbpf_common.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/skeleton.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_skeleton.c

-- 
2.17.1

