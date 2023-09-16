Return-Path: <bpf+bounces-10208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F057A3187
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 18:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F0E1C2096E
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 16:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216561BDC7;
	Sat, 16 Sep 2023 16:59:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC2A1428F;
	Sat, 16 Sep 2023 16:59:04 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10300CE6;
	Sat, 16 Sep 2023 09:59:03 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c0f3f24c27so1819608a34.2;
        Sat, 16 Sep 2023 09:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694883542; x=1695488342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Q92pm77a+s472b4BEOKTb4HhV/bQ32lY6EPxV3UfEs=;
        b=nSi0/HI9+1cTmsDnD8Mep5w9XG8le6Nk9gryVCJ5TyiVWOvZ3WfBLveR72jalgI+MA
         kmbNKW6L4Pj0l7vX0hngtc+P3/13m5yv1SMXXnL59KHKRk2Bu/qiAJq0+mjLspK3iNI4
         7TdPunsETRmRYZTgXsxQEX+qtXDSB+RFqtp2LKmdQq8DXdOoahznxTCjVlC6hropTOkd
         KZg7/ZWGPGCQjACUkykLkU5cMEyGrvvRNw5UKxaVUiWv1G5WvPSf4TdvV6skXJkaq0Nr
         n2MiNe44oc5TgQvypBuHX4igaKSyC5pM5mDj5E4hnNf1QEdPbs5Ucy8eNEcQ+IbsmXAb
         nU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694883542; x=1695488342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Q92pm77a+s472b4BEOKTb4HhV/bQ32lY6EPxV3UfEs=;
        b=lSQFRYmGTyDV2fHyfYOdQXykVXqe9EK9ovcYSqmvqnwUujn/vK32oigMbtSsZzGkDZ
         G2zyIdKBftpOBjrPt+q9GQb0m+X97D7ug/w0/wCMJ9KVH97orWlcMDO9tl1elh1oY7Pv
         a0/9lOnG106RQLsqJf+lZenZ+az8I9/DoEsuUKuBWBZjhGjQzo84sr6dk7jlN6Hn8ExF
         cIgNpaEvCbBRa4EnxoUm8PO1r9sgtIKDM/CSn9OuY1BvcShn91HO3LzP2AbNCoYg0xbL
         yNo7oZHAoTCcyNy6qk/Giv5xPut9ZejFh0UhSAwwgxVSDzccapqd8qifIV1+sofzLg6V
         CPjw==
X-Gm-Message-State: AOJu0YxfzGySmhuG3LmNwblxRfBDXdOBN6dV+nbE/XurI0eLxogoCpbU
	HO+6fhsmuFbaf2YGvgCeuho=
X-Google-Smtp-Source: AGHT+IH0EWz7cQBkiQte4VvgVIhd8hmcOlJyVFnI0DOpogYTCWPQONtNrvtaLTWskJnncVJG4VWZcw==
X-Received: by 2002:a05:6358:52cd:b0:132:d333:4a5c with SMTP id z13-20020a05635852cd00b00132d3334a5cmr5898333rwz.10.1694883542065;
        Sat, 16 Sep 2023 09:59:02 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::4:b299])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902eec400b001b8622c1ad2sm5495498plb.130.2023.09.16.09.58.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 16 Sep 2023 09:59:01 -0700 (PDT)
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
Subject: pull-request: bpf-next 2023-09-16
Date: Sat, 16 Sep 2023 09:58:53 -0700
Message-Id: <20230916165853.15153-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 73 non-merge commits during the last 9 day(s) which contain
a total of 79 files changed, 5275 insertions(+), 600 deletions(-).

The main changes are:

1) Basic BTF validation in libbpf, from Andrii Nakryiko.

2) bpf_assert(), bpf_throw(), exceptions in bpf progs, from Kumar Kartikeya Dwivedi.

3) next_thread cleanups, from Oleg Nesterov.

4) Add mcpu=v4 support to arm32, from Puranjay Mohan.

5) Add support for __percpu pointers in bpf progs, from Yonghong Song.

6) Fix bpf tailcall interaction with bpf trampoline, from Leon Hwang.

7) Raise irq_work in bpf_mem_alloc while irqs are disabled to improve refill probabablity, from Hou Tao.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git 

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alan Maguire, Andrey Konovalov, Dave Marchevsky, "Eric W. Biederman", 
Jiri Olsa, Maciej Fijalkowski, Quentin Monnet, Russell King (Oracle), 
Song Liu, Stanislav Fomichev, Yonghong Song

----------------------------------------------------------------

The following changes since commit 73be7fb14e83d24383f840a22f24d3ed222ca319:

  Merge tag 'net-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-09-07 18:33:07 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git 

for you to fetch changes up to ec6f1b4db95b7eedb3fe85f4f14e08fa0e9281c3:

  Merge branch 'exceptions-1-2' (2023-09-16 09:36:44 -0700)

----------------------------------------------------------------
Alexei Starovoitov (7):
      Merge branch 'bpf-add-support-for-local-percpu-kptr'
      Merge branch 'bpf-enable-irq-after-irq_work_raise-completes'
      Merge branch 'bpf-task_group_seq_get_next-misc-cleanups'
      Merge branch 'bpf-x64-fix-tailcall-infinite-loop'
      Merge branch 'seltests-xsk-various-improvements-to-xskxceiver'
      Merge branch 'arm32-bpf-add-support-for-cpuv4-insns'
      Merge branch 'exceptions-1-2'

Andrii Nakryiko (2):
      libbpf: Add basic BTF sanity validation
      Merge branch 'selftests/bpf: Optimize kallsyms cache'

Artem Savkov (1):
      selftests/bpf: Skip module_fentry_shadow test when bpf_testmod is not available

Denys Zagorui (1):
      bpftool: Fix -Wcast-qual warning

Hou Tao (3):
      bpf: Enable IRQ after irq_work_raise() completes in unit_alloc()
      bpf: Enable IRQ after irq_work_raise() completes in unit_free{_rcu}()
      selftests/bpf: Test preemption between bpf_obj_new() and bpf_obj_drop()

Kumar Kartikeya Dwivedi (17):
      bpf: Use bpf_is_subprog to check for subprogs
      arch/x86: Implement arch_bpf_stack_walk
      bpf: Implement support for adding hidden subprogs
      bpf: Implement BPF exceptions
      bpf: Refactor check_btf_func and split into two phases
      bpf: Add support for custom exception callbacks
      bpf: Perform CFG walk for exception callback
      bpf: Treat first argument as return value for bpf_throw
      mm: kasan: Declare kasan_unpoison_task_stack_below in kasan.h
      bpf: Prevent KASAN false positive with bpf_throw
      bpf: Detect IP == ksym.end as part of BPF program
      bpf: Disallow fentry/fexit/freplace for exception callbacks
      bpf: Fix kfunc callback register type handling
      libbpf: Refactor bpf_object__reloc_code
      libbpf: Add support for custom exception callbacks
      selftests/bpf: Add BPF assertion macros
      selftests/bpf: Add tests for BPF exceptions

Larysa Zaremba (1):
      bpf: Allow to use kfunc XDP hints and frags together

Leon Hwang (4):
      selftests/bpf: Correct map_fd to data_fd in tailcalls
      bpf, x64: Comment tail_call_cnt initialisation
      bpf, x64: Fix tailcall infinite loop
      selftests/bpf: Add testcases for tailcall infinite loop fixing

Magnus Karlsson (10):
      selftests/xsk: print per packet info in verbose mode
      selftests/xsk: add timeout for Tx thread
      selftests/xsk: add option to only run tests in a single mode
      selftests/xsk: move all tests to separate functions
      selftests/xsk: declare test names in struct
      selftests/xsk: add option that lists all tests
      selftests/xsk: add option to run single test
      selftests/xsk: use ksft_print_msg uniformly
      selftests/xsk: fail single test instead of all tests
      selftests/xsk: display command line options with -h

Martin KaFai Lau (1):
      Merge branch 'bpf: expose information about netdev xdp-metadata kfunc support'

Oleg Nesterov (5):
      bpf: task_group_seq_get_next: cleanup the usage of next_thread()
      bpf: task_group_seq_get_next: cleanup the usage of get/put_task_struct
      bpf: task_group_seq_get_next: fix the skip_if_dup_files check
      bpf: task_group_seq_get_next: kill next_task
      bpf: task_group_seq_get_next: simplify the "next tid" logic

Puranjay Mohan (9):
      arm32, bpf: add support for 32-bit offset jmp instruction
      arm32, bpf: add support for sign-extension load instruction
      arm32, bpf: add support for sign-extension mov instruction
      arm32, bpf: add support for unconditional bswap instruction
      arm32, bpf: add support for 32-bit signed division
      arm32, bpf: add support for 64 bit division instruction
      selftest, bpf: enable cpu v4 tests for arm32
      bpf/tests: add tests for cpuv4 instructions
      MAINTAINERS: Add myself for ARM32 BPF JIT maintainer.

Quan Tian (1):
      docs/bpf: update out-of-date doc in BPF flow dissector

Rong Tao (2):
      selftests/bpf: trace_helpers.c: Optimize kallsyms cache
      selftests/bpf: trace_helpers.c: Add a global ksyms initialization mutex

Song Liu (1):
      bpf: Charge modmem for struct_ops trampoline

Stanislav Fomichev (3):
      bpf: make it easier to add new metadata kfunc
      bpf: expose information about supported xdp metadata kfunc
      tools: ynl: extend netdev sample to dump xdp-rx-metadata-features

Tirthendu Sarkar (1):
      xsk: add multi-buffer support for sockets sharing umem

Yonghong Song (13):
      bpf: Add support for non-fix-size percpu mem allocation
      bpf: Add BPF_KPTR_PERCPU as a field type
      bpf: Add alloc/xchg/direct_access support for local percpu kptr
      bpf: Add bpf_this_cpu_ptr/bpf_per_cpu_ptr support for allocated percpu obj
      selftests/bpf: Update error message in negative linked_list test
      libbpf: Add __percpu_kptr macro definition
      selftests/bpf: Add bpf_percpu_obj_{new,drop}() macro in bpf_experimental.h
      selftests/bpf: Add tests for array map with local percpu kptr
      bpf: Mark OBJ_RELEASE argument as MEM_RCU when possible
      selftests/bpf: Remove unnecessary direct read of local percpu kptr
      selftests/bpf: Add tests for cgrp_local_storage with local percpu kptr
      selftests/bpf: Add some negative tests
      bpf: Mark BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE deprecated

 Documentation/bpf/prog_flow_dissector.rst          |   2 +-
 Documentation/netlink/specs/netdev.yaml            |  21 +
 Documentation/networking/xdp-rx-metadata.rst       |   7 +
 MAINTAINERS                                        |   5 +-
 arch/arm/net/bpf_jit_32.c                          | 280 ++++++++-
 arch/arm/net/bpf_jit_32.h                          |   4 +
 arch/arm64/net/bpf_jit_comp.c                      |   2 +-
 arch/s390/net/bpf_jit_comp.c                       |   2 +-
 arch/x86/net/bpf_jit_comp.c                        | 149 ++++-
 include/linux/bpf.h                                |  40 +-
 include/linux/bpf_verifier.h                       |   9 +-
 include/linux/filter.h                             |  58 +-
 include/linux/kasan.h                              |   2 +
 include/net/xdp.h                                  |  19 +-
 include/net/xdp_sock.h                             |   2 +
 include/uapi/linux/bpf.h                           |   9 +-
 include/uapi/linux/netdev.h                        |  16 +
 kernel/bpf/bpf_struct_ops.c                        |  26 +-
 kernel/bpf/btf.c                                   |  34 +-
 kernel/bpf/core.c                                  |  37 +-
 kernel/bpf/helpers.c                               |  61 ++
 kernel/bpf/memalloc.c                              |  30 +-
 kernel/bpf/offload.c                               |  18 +-
 kernel/bpf/syscall.c                               |   6 +-
 kernel/bpf/task_iter.c                             |  40 +-
 kernel/bpf/trampoline.c                            |   4 +-
 kernel/bpf/verifier.c                              | 645 ++++++++++++++++++---
 lib/test_bpf.c                                     | 371 ++++++++++++
 mm/kasan/kasan.h                                   |   1 -
 net/core/netdev-genl.c                             |  12 +-
 net/core/xdp.c                                     |   4 +-
 net/xdp/xsk.c                                      |   2 +-
 net/xdp/xsk_buff_pool.c                            |   3 +
 samples/bpf/Makefile                               |   4 +
 tools/bpf/bpftool/gen.c                            |   2 +-
 tools/include/uapi/linux/bpf.h                     |   9 +-
 tools/include/uapi/linux/netdev.h                  |  16 +
 tools/lib/bpf/bpf_helpers.h                        |   1 +
 tools/lib/bpf/btf.c                                | 160 +++++
 tools/lib/bpf/libbpf.c                             | 166 +++++-
 tools/net/ynl/generated/netdev-user.c              |  19 +
 tools/net/ynl/generated/netdev-user.h              |   3 +
 tools/net/ynl/samples/Makefile                     |   2 +-
 tools/net/ynl/samples/netdev.c                     |   8 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64       |   1 +
 tools/testing/selftests/bpf/DENYLIST.s390x         |   1 +
 tools/testing/selftests/bpf/bpf_experimental.h     | 319 ++++++++++
 tools/testing/selftests/bpf/prog_tests/btf.c       |   4 +-
 .../testing/selftests/bpf/prog_tests/exceptions.c  | 408 +++++++++++++
 .../selftests/bpf/prog_tests/fill_link_info.c      |   2 +-
 .../bpf/prog_tests/kprobe_multi_testmod_test.c     |  20 +-
 .../testing/selftests/bpf/prog_tests/libbpf_str.c  |   6 +-
 .../testing/selftests/bpf/prog_tests/linked_list.c |   4 +-
 .../bpf/prog_tests/module_fentry_shadow.c          |   5 +
 .../selftests/bpf/prog_tests/percpu_alloc.c        | 125 ++++
 .../selftests/bpf/prog_tests/preempted_bpf_ma_op.c |  89 +++
 tools/testing/selftests/bpf/prog_tests/tailcalls.c | 269 ++++++++-
 tools/testing/selftests/bpf/progs/exceptions.c     | 368 ++++++++++++
 .../selftests/bpf/progs/exceptions_assert.c        | 135 +++++
 tools/testing/selftests/bpf/progs/exceptions_ext.c |  72 +++
 .../testing/selftests/bpf/progs/exceptions_fail.c  | 347 +++++++++++
 .../selftests/bpf/progs/percpu_alloc_array.c       | 183 ++++++
 .../bpf/progs/percpu_alloc_cgrp_local_storage.c    | 105 ++++
 .../selftests/bpf/progs/percpu_alloc_fail.c        | 164 ++++++
 .../selftests/bpf/progs/preempted_bpf_ma_op.c      | 106 ++++
 .../selftests/bpf/progs/tailcall_bpf2bpf_fentry.c  |  18 +
 .../selftests/bpf/progs/tailcall_bpf2bpf_fexit.c   |  18 +
 tools/testing/selftests/bpf/progs/verifier_bswap.c |   3 +-
 tools/testing/selftests/bpf/progs/verifier_gotol.c |   3 +-
 tools/testing/selftests/bpf/progs/verifier_ldsx.c  |   3 +-
 tools/testing/selftests/bpf/progs/verifier_movsx.c |   3 +-
 tools/testing/selftests/bpf/progs/verifier_sdiv.c  |   3 +-
 .../selftests/bpf/test_bpftool_synctypes.py        |   9 +
 tools/testing/selftests/bpf/test_xsk.sh            |  40 +-
 tools/testing/selftests/bpf/trace_helpers.c        | 134 +++--
 tools/testing/selftests/bpf/trace_helpers.h        |   8 +-
 tools/testing/selftests/bpf/xsk_prereqs.sh         |  10 +-
 tools/testing/selftests/bpf/xskxceiver.c           | 535 ++++++++++-------
 tools/testing/selftests/bpf/xskxceiver.h           |  44 +-
 79 files changed, 5275 insertions(+), 600 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/preempted_bpf_ma_op.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_assert.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_alloc_array.c
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_local_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/preempted_bpf_ma_op.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c

