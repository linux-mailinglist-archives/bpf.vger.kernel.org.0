Return-Path: <bpf+bounces-4980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EC6752F2B
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 04:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886B81C21434
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 02:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB2C817;
	Fri, 14 Jul 2023 02:09:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5FA29;
	Fri, 14 Jul 2023 02:09:20 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0525726BC;
	Thu, 13 Jul 2023 19:09:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so911496b3a.3;
        Thu, 13 Jul 2023 19:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689300554; x=1691892554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U8Mbo8tXkF4+cDEdtDUhjQy9rceUrv1pc3/MPqDzHsc=;
        b=HrEKY2+xR42zUO9dr3idOpFTvj53dUpb3cQ7n9Ar+yweNB9DioEQEuhcGJih1IuM/i
         luo9mjCoa7jHJ5alprpiUwE9NuyI+PI6Wn9wJgGZkvbLnwzcx+SZWy9kwIBqtcAaKfdB
         N+XZNoHOEsoarQ9x2GNEWZQL7YFCCVJNJlgWfBYN3+COpL6uve493ptPBbw0dMyXmIMr
         ZBL/EYgSr1SDioDnsJ77i2xO4b2XRr/QkZEHF+dH5pDvuuz0ib1LitNwTCm6WewxU6f7
         ed/tnpNrm86EN6SOldAbHIuZlTPsmIFV+RU3aPQXCMp2/NfY4znszfSOYLsgeXi4HDQD
         TZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689300554; x=1691892554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8Mbo8tXkF4+cDEdtDUhjQy9rceUrv1pc3/MPqDzHsc=;
        b=WabtnTf516fx+VenQcFtM1JIOE4jZxaf0nPIwrCbFU8jc9NpCFYYOSDYr9JHC5D8yF
         f8ztCyPWiUSGc9Xj1bqeiFOLLBDg3iuGJ8AhT/g/IzSuw3e+/gJ2fRjda02FSlPudd2R
         v5Z+7cx6n0S2txbcHxjPzKEmyOamfRIKzssOp3e5j6TjFQb9ea9aFAvZoiLLqyczfcVU
         UJUB8+m0Al+AFcNS1tN0CaAfqAPr8nopt89/UxVshvLpxqRlEBEAv6WDedx/B5kWIumU
         EM8kZ59Wm8h6DTAEgAW3dRNDfovJPueGfdgmtcc/jtnrv9iI8+8957ExDvJJnSC6xUHE
         MStQ==
X-Gm-Message-State: ABy/qLbvAzj1Bj6mz8/WckBWHUWlTytRRjN2qk7AX5oGaVQk491HZT5n
	3EYfnpImczkBFxZ2BUHQFdg=
X-Google-Smtp-Source: APBJJlElH009mCDKBlRGIjptH2v2/sZXSGdoGcU9/4DxNrgmuJk7ouUm1WNurihzJSiraYKi4btTww==
X-Received: by 2002:a05:6a20:9712:b0:132:9d0:1492 with SMTP id hr18-20020a056a20971200b0013209d01492mr2292924pzc.35.1689300554108;
        Thu, 13 Jul 2023 19:09:14 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:400::5:2ff4])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902aa8200b001ac40488620sm6544073plr.92.2023.07.13.19.09.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Jul 2023 19:09:13 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: pull-request: bpf-next 2023-07-13
Date: Thu, 13 Jul 2023 19:09:10 -0700
Message-Id: <20230714020910.80794-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 67 non-merge commits during the last 15 day(s) which contain
a total of 106 files changed, 4444 insertions(+), 619 deletions(-).

The main changes are:

1) Fix bpftool build in presence of stale vmlinux.h, from Alexander Lobakin.

2) Introduce bpf_me_mcache_free_rcu() and fix OOM under stress, from Alexei Starovoitov.

3) Teach verifier actual bounds of bpf_get_smp_processor_id() and fix perf+libbpf issue
   related to custom section handling, from Andrii Nakryiko.

4) Introduce bpf map element count, from Anton Protopopov.

5) Check skb ownership against full socket, from Kui-Feng Lee.

6) Support for up to 12 arguments in BPF trampoline, from Menglong Dong.

7) Export rcu_request_urgent_qs_task, from Paul E. McKenney.

8) Fix BTF walking of unions, from Yafang Shao.

9) Extend link_info for kprobe_multi and perf_event links, from Yafang Shao.

There should be no merge conflicts.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alexei Starovoitov, Andrii Nakryiko, Dan Carpenter, Daniel Xu, David 
Vernet, Fabio M. De Francesco, Hou Tao, Ira Weiny, Jiri Olsa, John 
Fastabend, kernel test robot, Quentin Monnet, Ravi Bangoria, Stanislav 
Fomichev, Toke Høiland-Jørgensen, Yonghong Song

----------------------------------------------------------------

The following changes since commit 3a8a670eeeaa40d87bd38a587438952741980c18:

  Merge tag 'net-next-6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2023-06-28 16:43:10 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 1cd0e7715cad848017e48033772791e8b9ee2932:

  selftests/bpf: Add selftest for PTR_UNTRUSTED (2023-07-13 16:24:29 -0700)

----------------------------------------------------------------
for-netdev

----------------------------------------------------------------
Alexander Lobakin (3):
      bpftool: use a local copy of perf_event to fix accessing :: Bpf_cookie
      bpftool: Define a local bpf_perf_link to fix accessing its fields
      bpftool: Use a local bpf_perf_event_value to fix accessing its fields

Alexei Starovoitov (15):
      Merge branch 'bpf: add percpu stats for bpf_map'
      Merge branch 'bpf: Support ->fill_link_info for kprobe_multi and perf_event links'
      bpf: Rename few bpf_mem_alloc fields.
      bpf: Simplify code of destroy_mem_alloc() with kmemdup().
      bpf: Let free_all() return the number of freed elements.
      bpf: Refactor alloc_bulk().
      bpf: Factor out inc/dec of active flag into helpers.
      bpf: Further refactor alloc_bulk().
      bpf: Change bpf_mem_cache draining process.
      bpf: Add a hint to allocated objects.
      bpf: Allow reuse from waiting_for_gp_ttrace list.
      selftests/bpf: Improve test coverage of bpf_mem_alloc.
      bpf: Introduce bpf_mem_free_rcu() similar to kfree_rcu().
      bpf: Convert bpf_cpumask to bpf_mem_cache_free_rcu.
      Merge branch 'bpf-x86-allow-function-arguments-up-to-12-for-tracing'

Andrea Terzolo (1):
      libbpf: Skip modules BTF loading when CAP_SYS_ADMIN is missing

Andrii Nakryiko (6):
      Merge branch 'libbpf: add netfilter link attach helper'
      libbpf: only reset sec_def handler when necessary
      Merge branch 'bpftool: Fix skeletons compilation for older kernels'
      libbpf: Fix realloc API handling in zero-sized edge cases
      bpf: teach verifier actual bounds of bpf_get_smp_processor_id() result
      selftests/bpf: extend existing map resize tests for per-cpu use case

Anton Protopopov (5):
      bpf: add percpu stats for bpf_map elements insertions/deletions
      bpf: add a new kfunc to return current bpf_map elements count
      bpf: populate the per-cpu insertions/deletions counters for hashmaps
      bpf: make preloaded map iterators to display map elements count
      selftests/bpf: test map percpu stats

Björn Töpel (3):
      selftests/bpf: Add F_NEEDS_EFFICIENT_UNALIGNED_ACCESS to some tests
      selftests/bpf: Honor $(O) when figuring out paths
      selftests/bpf: Bump and validate MAX_SYMS

Daniel Borkmann (2):
      selftests/bpf: Fix bpf_nf failure upon test rerun
      Merge branch 'bpf-mem-cache-free-rcu'

Dave Thaler (1):
      bpf, docs: Fix definition of BPF_NEG operation

David Vernet (1):
      bpf,docs: Create new standardization subdirectory

Fangrui Song (1):
      bpf: Replace deprecated -target with --target= for Clang

Florian Westphal (2):
      libbpf: Add netfilter link attach helper
      selftests/bpf: Add bpf_program__attach_netfilter helper test

Hou Tao (3):
      bpf: Remove unnecessary ring buffer size check
      selftests/bpf: Add benchmark for bpf memory allocator
      bpf: Add object leak check.

Jackie Liu (2):
      libbpf: Cross-join available_filter_functions and kallsyms for multi-kprobes
      libbpf: Use available_filter_functions_addrs with multi-kprobes

John Sanpe (1):
      libbpf: Remove HASHMAP_INIT static initialization helper

Kui-Feng Lee (2):
      bpf, net: Check skb ownership against full socket.
      selftests/bpf: Verify that the cgroup_skb filters receive expected packets.

Lu Hongfei (1):
      selftests/bpf: Correct two typos

Menglong Dong (3):
      bpf, x86: save/restore regs with BPF_DW size
      bpf, x86: allow function arguments up to 12 for TRACING
      selftests/bpf: add testcase for TRACING with 6+ arguments

Paul E. McKenney (1):
      rcu: Export rcu_request_urgent_qs_task()

Quentin Monnet (2):
      bpftool: Use a local copy of BPF_LINK_TYPE_PERF_EVENT in pid_iter.bpf.c
      bpftool: Use "fallthrough;" keyword instead of comments

Rong Tao (1):
      samples/bpf: syscall_tp: Aarch64 no open syscall

Stanislav Fomichev (2):
      bpf: Resolve modifiers when walking structs
      selftests/bpf: Add test to exercise typedef walking

Sumitra Sharma (1):
      lib/test_bpf: Call page_address() on page acquired with GFP_KERNEL flag

Yafang Shao (14):
      bpf: Support ->fill_link_info for kprobe_multi
      bpftool: Dump the kernel symbol's module name
      bpftool: Show kprobe_multi link info
      bpf: Protect probed address based on kptr_restrict setting
      bpf: Clear the probe_addr for uprobe
      bpf: Expose symbol's respective address
      bpf: Add a common helper bpf_copy_to_user()
      bpf: Support ->fill_link_info for perf_event
      bpftool: Add perf event names
      bpftool: Show perf link info
      bpf: Fix an error around PTR_UNTRUSTED
      selftests/bpf: Add selftests for nested_trust
      bpf: Fix an error in verifying a field in a union
      selftests/bpf: Add selftest for PTR_UNTRUSTED

 Documentation/bpf/bpf_devel_QA.rst                 |  10 +-
 Documentation/bpf/btf.rst                          |   4 +-
 Documentation/bpf/index.rst                        |   3 +-
 Documentation/bpf/llvm_reloc.rst                   |   6 +-
 Documentation/bpf/standardization/index.rst        |  18 +
 .../bpf/{ => standardization}/instruction-set.rst  |   2 +-
 .../bpf/{ => standardization}/linux-notes.rst      |   3 +-
 MAINTAINERS                                        |   2 +-
 arch/x86/net/bpf_jit_comp.c                        | 246 ++++++++--
 drivers/hid/bpf/entrypoints/Makefile               |   2 +-
 include/linux/bpf-cgroup.h                         |   4 +-
 include/linux/bpf.h                                |  30 ++
 include/linux/bpf_mem_alloc.h                      |   2 +
 include/linux/rcutiny.h                            |   2 +
 include/linux/rcutree.h                            |   1 +
 include/linux/trace_events.h                       |   3 +-
 include/uapi/linux/bpf.h                           |  40 ++
 kernel/bpf/btf.c                                   |  24 +-
 kernel/bpf/cpumask.c                               |  20 +-
 kernel/bpf/hashtab.c                               |  22 +-
 kernel/bpf/map_iter.c                              |  39 +-
 kernel/bpf/memalloc.c                              | 378 +++++++++++----
 kernel/bpf/preload/iterators/Makefile              |   2 +-
 kernel/bpf/preload/iterators/iterators.bpf.c       |   9 +-
 .../iterators/iterators.lskel-little-endian.h      | 526 +++++++++++----------
 kernel/bpf/ringbuf.c                               |  26 +-
 kernel/bpf/syscall.c                               | 180 ++++++-
 kernel/bpf/verifier.c                              |  42 +-
 kernel/rcu/rcu.h                                   |   2 -
 kernel/trace/bpf_trace.c                           |  49 +-
 kernel/trace/trace_kprobe.c                        |  13 +-
 kernel/trace/trace_uprobe.c                        |   3 +-
 lib/test_bpf.c                                     |  12 +-
 net/bpf/test_run.c                                 |  18 +-
 samples/bpf/Makefile                               |   6 +-
 samples/bpf/gnu/stubs.h                            |   2 +-
 samples/bpf/syscall_tp_kern.c                      |   4 +
 samples/bpf/test_lwt_bpf.sh                        |   2 +-
 samples/hid/Makefile                               |   6 +-
 tools/bpf/bpftool/Documentation/bpftool-gen.rst    |   4 +-
 tools/bpf/bpftool/Makefile                         |   2 +-
 tools/bpf/bpftool/btf_dumper.c                     |   2 +-
 tools/bpf/bpftool/feature.c                        |   2 +-
 tools/bpf/bpftool/link.c                           | 432 ++++++++++++++++-
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c          |  26 +-
 tools/bpf/bpftool/skeleton/profiler.bpf.c          |  27 +-
 tools/bpf/bpftool/xlated_dumper.c                  |   6 +-
 tools/bpf/bpftool/xlated_dumper.h                  |   2 +
 tools/bpf/runqslower/Makefile                      |   2 +-
 tools/build/feature/Makefile                       |   2 +-
 tools/include/uapi/linux/bpf.h                     |  40 ++
 tools/lib/bpf/bpf.c                                |   8 +
 tools/lib/bpf/bpf.h                                |   6 +
 tools/lib/bpf/hashmap.h                            |  10 -
 tools/lib/bpf/libbpf.c                             | 258 +++++++++-
 tools/lib/bpf/libbpf.h                             |  15 +
 tools/lib/bpf/libbpf.map                           |   1 +
 tools/lib/bpf/usdt.c                               |   5 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64       |   2 +
 tools/testing/selftests/bpf/Makefile               |  13 +-
 tools/testing/selftests/bpf/bench.c                |   4 +
 .../testing/selftests/bpf/benchs/bench_htab_mem.c  | 350 ++++++++++++++
 .../testing/selftests/bpf/benchs/bench_ringbufs.c  |   2 +-
 .../selftests/bpf/benchs/run_bench_htab_mem.sh     |  40 ++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |  49 +-
 tools/testing/selftests/bpf/cgroup_helpers.c       |  12 +
 tools/testing/selftests/bpf/cgroup_helpers.h       |   1 +
 tools/testing/selftests/bpf/cgroup_tcp_skb.h       |  35 ++
 tools/testing/selftests/bpf/gnu/stubs.h            |   2 +-
 .../selftests/bpf/map_tests/map_percpu_stats.c     | 447 +++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c    |   5 +-
 .../selftests/bpf/prog_tests/cgroup_tcp_skb.c      | 402 ++++++++++++++++
 .../testing/selftests/bpf/prog_tests/fentry_test.c |  43 +-
 .../testing/selftests/bpf/prog_tests/fexit_test.c  |  43 +-
 .../selftests/bpf/prog_tests/get_func_args_test.c  |   4 +-
 .../selftests/bpf/prog_tests/global_map_resize.c   |  14 +-
 .../selftests/bpf/prog_tests/modify_return.c       |  10 +-
 .../bpf/prog_tests/netfilter_link_attach.c         |  86 ++++
 .../selftests/bpf/prog_tests/ptr_untrusted.c       |  36 ++
 .../selftests/bpf/prog_tests/tcp_hdr_options.c     |   2 +-
 .../selftests/bpf/prog_tests/tracing_struct.c      |  19 +
 .../selftests/bpf/prog_tests/trampoline_count.c    |   4 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c | 382 +++++++++++++++
 .../testing/selftests/bpf/progs/fentry_many_args.c |  39 ++
 .../testing/selftests/bpf/progs/fexit_many_args.c  |  40 ++
 tools/testing/selftests/bpf/progs/htab_mem_bench.c | 105 ++++
 tools/testing/selftests/bpf/progs/linked_list.c    |   2 +-
 .../testing/selftests/bpf/progs/map_percpu_stats.c |  24 +
 tools/testing/selftests/bpf/progs/modify_return.c  |  40 ++
 .../selftests/bpf/progs/nested_trust_failure.c     |  16 +
 .../selftests/bpf/progs/nested_trust_success.c     |  15 +
 .../selftests/bpf/progs/test_global_map_resize.c   |   8 +-
 .../bpf/progs/test_netfilter_link_attach.c         |  14 +
 .../selftests/bpf/progs/test_ptr_untrusted.c       |  29 ++
 tools/testing/selftests/bpf/progs/tracing_struct.c |  54 +++
 .../testing/selftests/bpf/progs/verifier_typedef.c |  23 +
 tools/testing/selftests/bpf/trace_helpers.c        |   5 +-
 .../selftests/bpf/verifier/atomic_cmpxchg.c        |   1 +
 tools/testing/selftests/bpf/verifier/ctx_skb.c     |   2 +
 tools/testing/selftests/bpf/verifier/jmp32.c       |   8 +
 tools/testing/selftests/bpf/verifier/map_kptr.c    |   2 +
 tools/testing/selftests/bpf/verifier/precise.c     |   2 +-
 tools/testing/selftests/hid/Makefile               |   6 +-
 tools/testing/selftests/net/Makefile               |   4 +-
 tools/testing/selftests/tc-testing/Makefile        |   2 +-
 106 files changed, 4444 insertions(+), 619 deletions(-)
 create mode 100644 Documentation/bpf/standardization/index.rst
 rename Documentation/bpf/{ => standardization}/instruction-set.rst (99%)
 rename Documentation/bpf/{ => standardization}/linux-notes.rst (96%)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_htab_mem.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_htab_mem.sh
 create mode 100644 tools/testing/selftests/bpf/cgroup_tcp_skb.h
 create mode 100644 tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ptr_untrusted.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_many_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/fexit_many_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_mem_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_percpu_stats.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_netfilter_link_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_typedef.c

