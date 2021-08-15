Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8429C3EC7C8
	for <lists+bpf@lfdr.de>; Sun, 15 Aug 2021 09:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhHOHGo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 15 Aug 2021 03:06:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58612 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230501AbhHOHGn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 15 Aug 2021 03:06:43 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17F75B3O014360
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:14 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ae9vqc1uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:14 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 15 Aug 2021 00:06:12 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 934AA3D405A0; Sun, 15 Aug 2021 00:06:10 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v5 bpf-next 00/16] BPF perf link and user-provided bpf_cookie
Date:   Sun, 15 Aug 2021 00:05:53 -0700
Message-ID: <20210815070609.987780-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: BBgvt1kq-JYXaW7Kkx1jctMIVpExpgCb
X-Proofpoint-ORIG-GUID: BBgvt1kq-JYXaW7Kkx1jctMIVpExpgCb
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-15_02:2021-08-13,2021-08-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 clxscore=1034 priorityscore=1501 lowpriorityscore=0 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108150049
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set implements an ability for users to specify custom black box u64
value for each BPF program attachment, bpf_cookie, which is available to BPF
program at runtime. This is a feature that's critically missing for cases when
some sort of generic processing needs to be done by the common BPF program
logic (or even exactly the same BPF program) across multiple BPF hooks (e.g.,
many uniformly handled kprobes) and it's important to be able to distinguish
between each BPF hook at runtime (e.g., for additional configuration lookup).

The choice of restricting this to a fixed-size 8-byte u64 value is an explicit
design decision. Making this configurable by users adds unnecessary complexity
(extra memory allocations, extra complications on the verifier side to validate
accesses to variable-sized data area) while not really opening up new
possibilities. If user's use case requires storing more data per attachment,
it's possible to use either global array, or ARRAY/HASHMAP BPF maps, where
bpf_cookie would be used as an index into respective storage, populated by
user-space code before creating BPF link. This gives user all the flexibility
and control while keeping BPF verifier and BPF helper API simple.

Currently, similar functionality can only be achieved through:
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
additional bpf_cookie value for each *attachment* (as opposed to each BPF
program) is extremely important. Two immediate users of this functionality are
going to be libbpf-based USDT library (currently in development) and retsnoop
([0]), but I'm sure more applications will come once users get this feature in
their kernels.

To achieve above described, all perf_event-based BPF hooks are made available
through a new BPF_LINK_TYPE_PERF_EVENT BPF link, which allows to use common
LINK_CREATE command for program attachments and generally brings
perf_event-based attachments into a common BPF link infrastructure.

With that, LINK_CREATE gets ability to pass throught bpf_cookie value during
link creation (BPF program attachment) time. bpf_get_attach_cookie() BPF
helper is added to allow fetching this value at runtime from BPF program side.
BPF cookie is stored either on struct perf_event itself and fetched from the
BPF program context, or is passed through ambient BPF run context, added in
c7603cfa04e7 ("bpf: Add ambient BPF runtime context stored in current").

On the libbpf side of things, BPF perf link is utilized whenever is supported
by the kernel instead of using PERF_EVENT_IOC_SET_BPF ioctl on perf_event FD.
All the tracing attach APIs are extended with OPTS and bpf_cookie is passed
through corresponding opts structs.

Last part of the patch set adds few self-tests utilizing new APIs.

There are also a few refactorings along the way to make things cleaner and
easier to work with, both in kernel (BPF_PROG_RUN and BPF_PROG_RUN_ARRAY), and
throughout libbpf and selftests.

Follow-up patches will extend bpf_cookie to fentry/fexit programs.

While adding uprobe_opts, also extend it with ref_ctr_offset for specifying
USDT semaphore (reference counter) offset. Update attach_probe selftests to
validate its functionality. This is another feature (along with bpf_cookie)
required for implementing libbpf-based USDT solution.

  [0] https://github.com/anakryiko/retsnoop

Cc: Peter Zijlstra <peterz@infradead.org> # for perf_event changes

v4->v5:
  - rebase on latest bpf-next to resolve merge conflict;
  - add ref_ctr_offset to uprobe_opts and corresponding selftest;
v3->v4:
  - get rid of BPF_PROG_RUN macro in favor of bpf_prog_run() (Daniel);
  - move #ifdef CONFIG_BPF_SYSCALL check into bpf_set_run_ctx (Daniel);
v2->v3:
  - user_ctx -> bpf_cookie, bpf_get_user_ctx -> bpf_get_attach_cookie (Peter);
  - fix BPF_LINK_TYPE_PERF_EVENT value fix (Jiri);
  - use bpf_prog_run() from bpf_prog_run_pin_on_cpu() (Yonghong);
v1->v2:
  - fix build failures on non-x86 arches by gating on CONFIG_PERF_EVENTS.

Andrii Nakryiko (16):
  bpf: refactor BPF_PROG_RUN into a function
  bpf: refactor BPF_PROG_RUN_ARRAY family of macros into functions
  bpf: refactor perf_event_set_bpf_prog() to use struct bpf_prog input
  bpf: implement minimal BPF perf link
  bpf: allow to specify user-provided bpf_cookie for BPF perf links
  bpf: add bpf_get_attach_cookie() BPF helper to access bpf_cookie value
  libbpf: re-build libbpf.so when libbpf.map changes
  libbpf: remove unused bpf_link's destroy operation, but add dealloc
  libbpf: use BPF perf link when supported by kernel
  libbpf: add bpf_cookie support to bpf_link_create() API
  libbpf: add bpf_cookie to perf_event, kprobe, uprobe, and tp attach
    APIs
  selftests/bpf: test low-level perf BPF link API
  selftests/bpf: extract uprobe-related helpers into trace_helpers.{c,h}
  selftests/bpf: add bpf_cookie selftests for high-level APIs
  libbpf: add uprobe ref counter offset support for USDT semaphores
  selftests/bpf: add ref_ctr_offset selftests

 Documentation/networking/filter.rst           |   4 +-
 drivers/media/rc/bpf-lirc.c                   |   6 +-
 drivers/net/ppp/ppp_generic.c                 |   8 +-
 drivers/net/team/team_mode_loadbalance.c      |   2 +-
 include/linux/bpf.h                           | 200 ++++++++------
 include/linux/bpf_types.h                     |   3 +
 include/linux/filter.h                        |  66 +++--
 include/linux/perf_event.h                    |   1 +
 include/linux/trace_events.h                  |   7 +-
 include/uapi/linux/bpf.h                      |  25 ++
 kernel/bpf/bpf_iter.c                         |   2 +-
 kernel/bpf/cgroup.c                           |  32 +--
 kernel/bpf/core.c                             |  31 ++-
 kernel/bpf/syscall.c                          | 105 +++++++-
 kernel/bpf/trampoline.c                       |   2 +-
 kernel/bpf/verifier.c                         |   2 +-
 kernel/events/core.c                          |  74 ++---
 kernel/trace/bpf_trace.c                      |  47 +++-
 lib/test_bpf.c                                |   2 +-
 net/bpf/test_run.c                            |   6 +-
 net/core/filter.c                             |   4 +-
 net/core/ptp_classifier.c                     |   2 +-
 net/netfilter/xt_bpf.c                        |   2 +-
 net/sched/act_bpf.c                           |   4 +-
 net/sched/cls_bpf.c                           |   4 +-
 tools/include/uapi/linux/bpf.h                |  25 ++
 tools/lib/bpf/Makefile                        |  10 +-
 tools/lib/bpf/bpf.c                           |  32 ++-
 tools/lib/bpf/bpf.h                           |   8 +-
 tools/lib/bpf/libbpf.c                        | 213 ++++++++++++---
 tools/lib/bpf/libbpf.h                        |  75 +++++-
 tools/lib/bpf/libbpf.map                      |   3 +
 tools/lib/bpf/libbpf_internal.h               |  32 ++-
 .../selftests/bpf/prog_tests/attach_probe.c   |  98 ++-----
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 254 ++++++++++++++++++
 .../selftests/bpf/prog_tests/perf_link.c      |  89 ++++++
 .../selftests/bpf/progs/test_bpf_cookie.c     |  85 ++++++
 .../selftests/bpf/progs/test_perf_link.c      |  16 ++
 tools/testing/selftests/bpf/trace_helpers.c   |  87 ++++++
 tools/testing/selftests/bpf/trace_helpers.h   |   4 +
 40 files changed, 1315 insertions(+), 357 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_link.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bpf_cookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_link.c

-- 
2.30.2

