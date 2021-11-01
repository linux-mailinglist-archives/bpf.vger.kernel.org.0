Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCF444238C
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 23:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhKAWsz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 18:48:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16034 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229848AbhKAWsz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Nov 2021 18:48:55 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A1GoNJV010553
        for <bpf@vger.kernel.org>; Mon, 1 Nov 2021 15:46:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=v/Juxwe6P+7UNbx7VpkIM136wX09//qQhUVXcwrEhPQ=;
 b=TN3KS4s/iCvta+gl4cPLqubFZpfOx0asWl+mHL/GOc/A585gfkvXxiz1j0XJqB3qAa81
 ZHv7RHQ+H9JlDMEXGvZjXUNMxWFEsBcuc1HQMzT7AVdzKqPb+pswtW1k5nH8lQipDuuN
 X02hIA3uM9onXgVcrujr+16dqyeJ9C+PHfk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3c2daw567v-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 15:46:20 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 1 Nov 2021 15:46:19 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id D11998EEEAEC; Mon,  1 Nov 2021 15:43:58 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v3 bpf-next 0/4] libbpf: deprecate bpf_program__get_prog_info_linear
Date:   Mon, 1 Nov 2021 15:43:53 -0700
Message-ID: <20211101224357.2651181-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 8i3bZUFYz6fldvjD4VrfLGzKMnxe4AmI
X-Proofpoint-ORIG-GUID: 8i3bZUFYz6fldvjD4VrfLGzKMnxe4AmI
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-01_07,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=795 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111010119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_program__get_prog_info_linear is a helper which wraps the
bpf_obj_get_info_by_fd BPF syscall with some niceties that put
all dynamic-length bpf_prog_info in one buffer contiguous with struct
bpf_prog_info, and simplify the selection of which dynamic data to grab.

The resultant combined struct, bpf_prog_info_linear, is persisted to
file by 'perf' to enable later annotation of BPF prog data. libbpf
includes some vaddr <-> offset conversion helpers for
struct bpf_prog_info_linear to simplify this.

This functionality is heavily tailored to perf's usecase, so its use as
a general prog info API should be deemphasized in favor of just calling
bpf_obj_get_info_by_fd, which can be more easily fit to purpose. Some
examples from caller migrations in this series:

  * Some callers weren't requesting or using dynamic-sized prog info and
    are well served by a simple get_info_by_fd call (e.g.
    dump_prog_id_as_func_ptr in bpftool)
  * Some callers were requesting all of a specific dynamic info type but
    only using the first record, so can avoid unnecessary malloc by
    only requesting 1 (e.g. profile_target_name in bpftool)
  * bpftool's do_dump saves some malloc/free by growing and reusing its
    dynamic prog_info buf as it loops over progs to grab info and dump.

Perf does need the full functionality of
bpf_program__get_prog_info_linear and its accompanying structs +
helpers, so copy the code to its codebase, migrate all other uses in the
tree, and deprecate the helper in libbpf.

Since the deprecated symbols continue to be included in perf some
renaming was necessary in perf's copy, otherwise functionality is
unchanged.

This work was previously discussed in libbpf's issue tracker [0].

[0]: https://github.com/libbpf/libbpf/issues/313

v2->v3:
  * Remove v2's patch 1 ("libbpf: Migrate internal use of
    bpf_program__get_prog_info_linear"), which was applied [Andrii]
  * Add new patch 1 migrating error checking of libbpf calls to
    new scheme [Andrii, Quentin]
  * In patch 2, fix !=3D -1 error check of libbpf call, improper realloc
    handling, and get rid of confusing macros [Andrii]
  * In patch 4, deprecate starting from 0.6 instead of 0.7 [Andrii]

v1->v2: fix bpftool do_dump changes to clear bpf_prog_info after use and
correctly pass realloc'd ptr back (patch 2)

Dave Marchevsky (4):
  bpftool: Migrate -1 err checks of libbpf fn calls
  bpftool: use bpf_obj_get_info_by_fd directly
  perf: pull in bpf_program__get_prog_info_linear
  libbpf: deprecate bpf_program__get_prog_info_linear

 tools/bpf/bpftool/btf_dumper.c                |  42 +--
 tools/bpf/bpftool/prog.c                      | 158 ++++++++---
 tools/bpf/bpftool/struct_ops.c                |   2 +-
 tools/lib/bpf/libbpf.h                        |   3 +
 .../Documentation/perf.data-file-format.txt   |   2 +-
 tools/perf/util/Build                         |   1 +
 tools/perf/util/annotate.c                    |   3 +-
 tools/perf/util/bpf-event.c                   |  41 ++-
 tools/perf/util/bpf-event.h                   |   2 +-
 tools/perf/util/bpf-utils.c                   | 261 ++++++++++++++++++
 tools/perf/util/bpf-utils.h                   |  76 +++++
 tools/perf/util/bpf_counter.c                 |   6 +-
 tools/perf/util/dso.c                         |   1 +
 tools/perf/util/env.c                         |   1 +
 tools/perf/util/header.c                      |  13 +-
 15 files changed, 527 insertions(+), 85 deletions(-)
 create mode 100644 tools/perf/util/bpf-utils.c
 create mode 100644 tools/perf/util/bpf-utils.h

--=20
2.30.2

