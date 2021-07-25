Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E7A3D4F1F
	for <lists+bpf@lfdr.de>; Sun, 25 Jul 2021 19:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhGYQ6a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 25 Jul 2021 12:58:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61420 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229709AbhGYQ63 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 25 Jul 2021 12:58:29 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 16PHWtEg031297
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 10:38:59 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3a0ej0nug9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 10:38:59 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 25 Jul 2021 10:38:57 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 551433D405AD; Sun, 25 Jul 2021 10:38:54 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH bpf-next 00/14] BPF perf link and user-provided context value
Date:   Sun, 25 Jul 2021 10:38:31 -0700
Message-ID: <20210725173845.2593626-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: b0sR-BHOQrW4oQ2AFbDErXiTZrZkbMZJ
X-Proofpoint-GUID: b0sR-BHOQrW4oQ2AFbDErXiTZrZkbMZJ
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-25_05:2021-07-23,2021-07-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107250126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set implements an ability for users to specify custom black box u64
value for each BPF program attachment, which is available to BPF program at
runtime. This is a feature that's critically missing for cases when some sort
of generic processing needs to be done by the common BPF program logic (or
even exactly the same BPF program) across multiple BPF hooks (e.g., many
uniformly handled kprobes) and it's important to be able to distinguish
between each BPF hook at runtime (e.g., for additional configuration lookup).

Currently, something like that can be only achieved through:
  - code-generation and BPF program cloning, which is very complicated and
    unmaintainable;
  - on-the-fly C code generation and further runtime compilation, which is
    what BCC uses and allows to do pretty simply. The big downside is a very
    heavy-weight Clang/LLVM dependency and inefficient memory usage (due to
    many BPF program clones and the compilation process itself);
  - in some cases (kprobes and sometimes uprobes) it's possible to do function
    IP lookup to get function-specific configuration. This doesn't work for
    all the cases (e.g., when attaching uprobes to shared libraries) and has
    higher runtime overhead and additional programming complexity due to
    BPF_MAP_TYPE_HASHMAP lookups. Up until recently, before bpf_get_func_ip()
    BPF helper was added, it was also very complicated and unstable (API-wise)
    to get traced function's IP from fentry/fexit and kretprobe.

With libbpf and BPF CO-RE, runtime compilation is not an option, so to be able
to build generic tracing tooling simply and efficiently, ability to provide
additional user context value for each *attachment* (as opposed to each BPF
program) is extremely important. Two immediate users of this functionality are
going to be libbpf-based USDT library (currently in development) and retsnoop
([0]), but I'm sure more applications will come once users get this feature in
their kernels.

To achieve above described, all perf_event-based BPF hooks are made available
through a new BPF_LINK_TYPE_PERF_EVENT BPF link, which allows to use common
LINK_CREATE command for program attachments and generally brings
perf_event-based attachments into a common BPF link infrastructure.

With that, LINK_CREATE gets ability to pass throught user_ctx value during
link creation (BPF program attachment) time. bpf_get_user_ctx() BPF helper is
added to allow fetching this value at runtime from BPF program side. user_ctx
is stored either on struct perf_event itself and fetched from the BPF program
context, or is passed through ambient BPF run context, added in
c7603cfa04e7 ("bpf: Add ambient BPF runtime context stored in current").

On the libbpf side of things, BPF perf link is utilized whenever is supported
by the kernel instead of using PERF_EVENT_IOC_SET_BPF ioctl on perf_event FD.
All the tracing attach APIs are extended with OPTS and user_ctx is passed
through corresponding opts structs.

Last part of the patch set adds few self-tests utilizing new APIs.

There are also a few refactorings along the way to make things cleaner and
easier to work with, both in kernel (BPF_PROG_RUN and BPF_PROG_RUN_ARRAY), and
throughout libbpf and selftests.

Follow-up patches will extend user_ctx to fentry/fexit programs.

  [0] https://github.com/anakryiko/retsnoop

Cc: Peter Zijlstra <peterz@infradead.org> # for perf_event changes

Andrii Nakryiko (14):
  bpf: refactor BPF_PROG_RUN into a function
  bpf: refactor BPF_PROG_RUN_ARRAY family of macros into functions
  bpf: refactor perf_event_set_bpf_prog() to use struct bpf_prog input
  bpf: implement minimal BPF perf link
  bpf: allow to specify user-provided context value for BPF perf links
  bpf: add bpf_get_user_ctx() BPF helper to access user_ctx value
  libbpf: re-build libbpf.so when libbpf.map changes
  libbpf: remove unused bpf_link's destroy operation, but add dealloc
  libbpf: use BPF perf link when supported by kernel
  libbpf: add user_ctx support to bpf_link_create() API
  libbpf: add user_ctx to perf_event, kprobe, uprobe, and tp attach APIs
  selftests/bpf: test low-level perf BPF link API
  selftests/bpf: extract uprobe-related helpers into trace_helpers.{c,h}
  selftests/bpf: add user_ctx selftests for high-level APIs

 drivers/media/rc/bpf-lirc.c                   |   4 +-
 include/linux/bpf.h                           | 206 ++++++++------
 include/linux/bpf_types.h                     |   3 +
 include/linux/filter.h                        |  63 +++--
 include/linux/perf_event.h                    |   1 +
 include/linux/trace_events.h                  |   8 +-
 include/uapi/linux/bpf.h                      |  25 ++
 kernel/bpf/cgroup.c                           |  32 +--
 kernel/bpf/core.c                             |  29 +-
 kernel/bpf/syscall.c                          | 101 ++++++-
 kernel/events/core.c                          |  71 +++--
 kernel/trace/bpf_trace.c                      |  45 +++-
 tools/include/uapi/linux/bpf.h                |  25 ++
 tools/lib/bpf/Makefile                        |  10 +-
 tools/lib/bpf/bpf.c                           |  32 ++-
 tools/lib/bpf/bpf.h                           |   8 +-
 tools/lib/bpf/libbpf.c                        | 196 +++++++++++---
 tools/lib/bpf/libbpf.h                        |  71 ++++-
 tools/lib/bpf/libbpf.map                      |   3 +
 tools/lib/bpf/libbpf_internal.h               |  32 ++-
 .../selftests/bpf/prog_tests/attach_probe.c   |  61 +----
 .../selftests/bpf/prog_tests/perf_link.c      |  89 ++++++
 .../selftests/bpf/prog_tests/user_ctx.c       | 254 ++++++++++++++++++
 .../selftests/bpf/progs/test_perf_link.c      |  16 ++
 .../selftests/bpf/progs/test_user_ctx.c       |  85 ++++++
 tools/testing/selftests/bpf/trace_helpers.c   |  66 +++++
 tools/testing/selftests/bpf/trace_helpers.h   |   3 +
 27 files changed, 1226 insertions(+), 313 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_link.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/user_ctx.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_link.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_user_ctx.c

-- 
2.30.2

