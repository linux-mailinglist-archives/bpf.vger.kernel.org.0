Return-Path: <bpf+bounces-69926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5FBBA744F
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 17:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E47179552
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 15:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BBF1B0F1E;
	Sun, 28 Sep 2025 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGLmgckB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B09C17BA6
	for <bpf@vger.kernel.org>; Sun, 28 Sep 2025 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759074374; cv=none; b=sHMYS6yKde/zv0EBq24o7GswdNlRg3wqiUJisIfrHdiwT5eYYY36bt2/NUl8k22TlN9N4YMm+FiavJ4MJFKivbiLj/1Pd466RDlpFNEfwgoncXVd+nsUOdIha6NG49FYBHOzNOdbjHogfKuh0zwJEM5RqaFOPA0cLJHktxKxVCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759074374; c=relaxed/simple;
	bh=UmyvdpPrPgHT6K96gUk/VoxRIbnOo0SJnr+aoRgqijs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iulwHExf8Sxx2FTOa500jLkpO9/raESoLdWM1lWyjb1qT1iyhcEbh+mCnoRj8YSHPXxZsoG93mkwnFVtVaExtU2dyDqDhZIa9eW2roba8qyzRcUx7REyvcFH0W6LzYmkwIOgctm7K4lHS280HgFEHFmGNCNmTT+R2ydArNM9yHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGLmgckB; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso2947070f8f.3
        for <bpf@vger.kernel.org>; Sun, 28 Sep 2025 08:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759074370; x=1759679170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xBdAwa4mJeZWl0SX7ni0y5dLBMpXHonhDDbW8aRGlso=;
        b=PGLmgckBroqQBOE00EIzLOrsVMwi5PBsc+r59RSvbSr+QEqa+aopWzgbbNdZAQ6k2Y
         SVr8xGcy7BDbBpJjt6GZzCyts/iaEEBJWStu7UWglfjp+OoYlvS3lgzfwY4E/8XmbeRY
         f+j8V2LM9gynuRMR8DiMfvp71q8xDraX2I18923wt0atgsIjWyG7jgPgyk2DeXwR9AcW
         cFz+XX5Vpbwlao71ei3A9sDhovn86fxto+02EUfI8QDxHZvXb2jlxt/cPT8bnj32lW2M
         sEZDlDuCRg3hpG7wdDQDRc8Q91dvHRrXeZcudJrsorDCH2ZnGAj8GKihT4XMN5i7rqAc
         q9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759074370; x=1759679170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBdAwa4mJeZWl0SX7ni0y5dLBMpXHonhDDbW8aRGlso=;
        b=CwZUVjPjS/L2KDzDV6C+hjB1GK+IavNV9WpH5AUGfwXY4VXx3oI2DzTucBi87MThWs
         yan7zYzJPcsosU9m9e3oGewRdkNwy5MbTzyaZSYRu0OiGAxPlejjXGwOZc6x3s0OMfUy
         N1k0fMIsvI5qWqhiig+mMm9M2ysRRW7gyRQK4GH8js1elBJdb7SatUDUoyrnuGUWUQXZ
         dm73jwbYFLnVHp0+FGuS7PUNjhUGuwStFPtbubiokKRZCkq8rp+SEY1vIX5PEy3F9nlZ
         McE1Hqaqhu7NdmWgLbq2kqmYXQP3JZRUv8g4guKJhxB+ldHYshm5zxics8pi3rOmOlUh
         Pp0Q==
X-Gm-Message-State: AOJu0Ywc/PN1JAxNRTY0bzKtsIdTIqqRntj3hKaUG3HfCHALhl9kJTlO
	hTMAWQTjzayat2FHl8rNLm36dU1qfXBPQ9jhE+YyxQLhF67rKjUfPOEy
X-Gm-Gg: ASbGncvEpBuWLJsdOhAhY29VGiljbDa+uchIoSZupVAnWp4zXE756yjLCu3YxA/JxrZ
	kI356LgwleBA6+0F+tA28h3stIVUrwjo7C7Ix1kyamZzlymONl/LYC5kjMStuSdvAq18pmHse8s
	nhpMhrsgjFNodgIMRtWx/q9jPYr5z6Bpv0YqFVXln2RVybDU4zVfd2FgigHdfVGFeZe4JE9nU8T
	xg4Q0clWmJHSGTjnUgh5CAtZXLxY2zb1CSZ8Ogsj5jgzAwAQf6xMnOVA25GmGZ0KWnUkgxjFvBs
	1Vw8YCl29yi+fPFWoFLccz0TNlcyaCxK2OWHr00AXgotpMAOAZb/UfT3ddXA292vhn+K5ehJ/5J
	YwtEvaav6K7KTkh0eIMm6qM3u+jxa5mNh8pD7+f5SNpm8ysVmV2K92N4=
X-Google-Smtp-Source: AGHT+IHCHP411fvTjMB31lRgmhHNBE0RYV45mxYGlvvVm6j/TTbV23GjZ7jjN99E4pEOLG3NsfKiIQ==
X-Received: by 2002:a05:6000:2585:b0:3fd:eb15:77a with SMTP id ffacd0b85a97d-40e46514bd9mr10454949f8f.6.1759074369253;
        Sun, 28 Sep 2025 08:46:09 -0700 (PDT)
Received: from localhost.localdomain ([62.48.188.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb871d051sm15161360f8f.14.2025.09.28.08.46.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Sep 2025 08:46:08 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	peterz@infradead.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	jolsa@kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] BPF changes for 6.18
Date: Sun, 28 Sep 2025 16:46:06 +0100
Message-Id: <20250928154606.5773-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit e59a039119c3ec241228adf12dca0dd4398104d0:

  Merge tag 's390-6.17-4' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2025-09-11 08:46:30 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.18

for you to fetch changes up to 4ef77dd584cfd915526328f516fec59e3a54d66e:

  libbpf: Replace AF_ALG with open coded SHA-256 (2025-09-28 04:25:31 -0700)

----------------------------------------------------------------
Note, there is a trivial conflict between tip and bpf-next trees:
in kernel/events/uprobes.c between commit:
  4363264111e12 ("uprobe: Do not emulate/sstep original instruction when ip is changed")
from the bpf-next tree and commit:
  ba2bfc97b4629 ("uprobes/x86: Add support to optimize uprobes")
from the tip tree:
https://lore.kernel.org/all/aNVMR5rjA2geHNLn@sirena.org.uk/
since Jiri's two separate uprobe/bpf related patch series landed
in different trees. One was mostly uprobe. Another was mostly bpf.

Other than that the main changes are:

- Support pulling non-linear xdp data with bpf_xdp_pull_data() kfunc
  (Amery Hung).
  Applied as a stable branch in bpf-next and net-next trees.

- Support reading skb metadata via bpf_dynptr (Jakub Sitnicki).
  Also a stable branch in bpf-next and net-next trees.

- Enforce expected_attach_type for tailcall compatibility
  (Daniel Borkmann)

- Replace path-sensitive with path-insensitive live stack analysis
  in the verifier (Eduard Zingerman).
  This is a significant change in the verification logic. More details,
  motivation, long term plans are in the cover letter/merge commit.

- Support signed BPF programs (KP Singh).
  This is another major feature that took years to materialize.
  Algorithm details are in the cover letter/marge commit.

- Add support for may_goto instruction to s390 JIT (Ilya Leoshkevich)

- Add support for may_goto instruction to arm64 JIT (Puranjay Mohan)

- Fix USDT SIB argument handling in libbpf (Jiawei Zhao)

- Allow uprobe-bpf program to change context registers (Jiri Olsa)

- Support signed loads from BPF arena (Kumar Kartikeya Dwivedi
  and Puranjay Mohan)

- Allow access to union arguments in tracing programs (Leon Hwang)

- Optimize rcu_read_lock() + migrate_disable() combination
  where it's used in BPF subsystem (Menglong Dong)

- Introduce bpf_task_work_schedule*() kfuncs to schedule
  deferred execution of BPF callback in the context of
  a specific task using the kernel’s task_work infrastructure
  (Mykyta Yatsenko)

- Enforce RCU protection for KF_RCU_PROTECTED kfuncs
  (Kumar Kartikeya Dwivedi)

- Add stress test for rqspinlock in NMI
  (Kumar Kartikeya Dwivedi)

- Improve the precision of tnum multiplier verifier operation
  (Nandakumar Edamana)

- Use tnums to improve is_branch_taken() logic (Paul Chaignon)

- Add support for atomic operations in arena in riscv JIT (Pu Lehui)

- Report arena faults to BPF error stream (Puranjay Mohan)

- Search for tracefs at /sys/kernel/tracing first in bpftool
  (Quentin Monnet)

- Add bpf_strcasecmp() kfunc (Rong Tao)

- Support lookup_and_delete_elem command in BPF_MAP_STACK_TRACE
  (Tao Chen)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alan Maguire (1):
      selftests/bpf: More open-coded gettid syscall cleanup

Alexei Starovoitov (19):
      Merge branch 'task-local-data'
      Merge branch 'bpf-use-vrealloc-in-bpf_patch_insn_data'
      Merge branch 'bpf-introduce-and-use-rcu_read_lock_dont_migrate'
      Merge branch 's390-bpf-add-s390-jit-support-for-timed-may_goto'
      Merge branch 'bpf-arm64-support-for-timed-may_goto'
      Merge branch 'selftests-bpf-benchmark-all-symbols-for-kprobe-multi'
      Merge branch 'selftests-bpf-introduce-experimental-bpf_in_interrupt'
      Merge branch 'bpf-replace-wq-users-and-add-wq_percpu-to-alloc_workqueue-users'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf after rc5
      Merge branch 'bpf-report-arena-faults-to-bpf-streams'
      Merge branch 'remove-use-of-current-cgns-in-bpf_cgroup_from_id'
      Merge branch 'update-kf_rcu_protected'
      Merge branch 'bpf-replace-path-sensitive-with-path-insensitive-live-stack-analysis'
      Merge branch 'signed-bpf-programs'
      Merge branch 'bpf-introduce-deferred-task-context-execution'
      Merge branch 'signed-loads-from-arena'
      Merge branch 'bpf-allow-union-argument-in-trampoline-based-programs'
      Merge branch 'riscv-bpf-fix-uninitialized-symbol-retval_off'
      Merge branch 'uprobe-bpf-allow-to-change-app-registers-from-uprobe-registers'

Amery Hung (19):
      bpf: Allow syscall bpf programs to call non-recur helpers
      selftests/bpf: Introduce task local data
      selftests/bpf: Test basic task local data operations
      selftests/bpf: Test concurrent task local data key creation
      bpf: Allow struct_ops to get map id by kdata
      selftests/bpf: Add multi_st_ops that supports multiple instances
      selftests/bpf: Test multi_st_ops and calling kfuncs from different programs
      selftests/bpf: Copy test_kmods when installing selftest
      bpf: Clear pfmemalloc flag when freeing all fragments
      bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
      bpf: Support pulling non-linear xdp data
      bpf: Clear packet pointers after changing packet data in kfuncs
      bpf: Make variables in bpf_prog_test_run_xdp less confusing
      bpf: Support specifying linear xdp packet data size for BPF_PROG_TEST_RUN
      selftests/bpf: Test bpf_xdp_pull_data
      selftests: drv-net: Pull data before parsing headers
      bpf: Emit struct bpf_xdp_sock type in vmlinux BTF
      selftests/bpf: Test changing packet data from global functions with a kfunc
      selftests/bpf: Test changing packet data from kfunc

Andrea Righi (1):
      bpf: Mark kfuncs as __noclone

Andrii Nakryiko (2):
      Merge branch 'libbpf-fix-reuse-of-devmap'
      Merge branch 'libbpf-fix-usdt-sib-argument-handling-causing-unrecognized-register-error'

Anton Protopopov (1):
      bpf: Add a verbose message when the BTF limit is reached

Chenghao Duan (1):
      riscv: bpf: Fix uninitialized symbol 'retval_off'

Cryolitia PukNgae (1):
      libbpf: Add documentation to version and error API functions

D. Wythe (1):
      libbpf: Fix error when st-prefix_ops and ops from differ btf

Daniel Borkmann (2):
      bpf: Enforce expected_attach_type for tailcall compatibility
      selftests/bpf: Add test case for different expected_attach_type

Eduard Zingerman (17):
      bpf: removed unused 'env' parameter from is_reg64 and insn_has_def32
      bpf: use realloc in bpf_patch_insn_data
      bpf: potential double-free of env->insn_aux_data
      bpf: dont report verifier bug for missing bpf_scc_visit on speculative path
      selftests/bpf: trigger verifier.c:maybe_exit_scc() for a speculative state
      bpf: bpf_verifier_state->cleaned flag instead of REG_LIVE_DONE
      bpf: use compute_live_registers() info in clean_func_state
      bpf: remove redundant REG_LIVE_READ check in stacksafe()
      bpf: declare a few utility functions as internal api
      bpf: compute instructions postorder per subprogram
      bpf: callchain sensitive stack liveness tracking using CFG
      bpf: enable callchain sensitive stack liveness tracking
      bpf: signal error if old liveness is more conservative than new
      bpf: disable and remove registers chain based liveness
      bpf: table based bpf_insn_successors()
      selftests/bpf: __not_msg() tag for test_loader framework
      selftests/bpf: test cases for callchain sensitive live stack tracking

Eric Biggers (2):
      bpf: Use sha1() instead of sha1_transform() in bpf_prog_calc_tag()
      libbpf: Replace AF_ALG with open coded SHA-256

Feng Yang (2):
      bpf: Replace kvfree with kfree for kzalloc memory
      selftests/bpf: Fix the issue where the error code is 0

Fushuai Wang (1):
      bpf: Replace get_next_cpu() with cpumask_next_wrap()

Hengqi Chen (5):
      selftests/bpf: Use vmlinux.h for BPF programs
      bpf, arm64: Remove duplicated bpf_flush_icache()
      riscv, bpf: Remove duplicated bpf_flush_icache()
      riscv, bpf: Sign extend struct ops return values properly
      bpf, arm64: Call bpf_jit_binary_pack_finalize() in bpf_jit_free()

Ilya Leoshkevich (10):
      s390/bpf: Do not write tail call counter into helper and kfunc frames
      s390/bpf: Write back tail call counter for BPF_PSEUDO_CALL
      s390/bpf: Write back tail call counter for BPF_TRAMP_F_CALL_ORIG
      selftests/bpf: Clobber a lot of registers in tailcall_bpf2bpf_hierarchy tests
      s390/bpf: Use direct calls and jumps where possible
      s390/bpf: Add s390 JIT support for timed may_goto
      selftests/bpf: Add a missing newline to the "bad arch spec" message
      selftests/bpf: Add __arch_s390x macro
      selftests/bpf: Enable timed may_goto verifier tests on s390x
      selftests/bpf: Remove may_goto tests from DENYLIST.s390x

Jakub Sitnicki (10):
      bpf: Add dynptr type for skb metadata
      bpf: Enable read/write access to skb metadata through a dynptr
      selftests/bpf: Cover verifier checks for skb_meta dynptr type
      selftests/bpf: Pass just bpf_map to xdp_context_test helper
      selftests/bpf: Parametrize test_xdp_context_tuntap
      selftests/bpf: Cover read access to skb metadata via dynptr
      selftests/bpf: Cover write access to skb metadata via dynptr
      selftests/bpf: Cover read/write to skb metadata at an offset
      selftests/bpf: Cover metadata access from a modified skb clone
      bpf: Return an error pointer for skb metadata when CONFIG_NET=n

Jiapeng Chong (2):
      bpf: Remove duplicate crypto/sha2.h header
      bpftool: Remove duplicate string.h header

Jiawei Zhao (3):
      libbpf: Fix USDT SIB argument handling causing unrecognized register error
      selftests/bpf: Enrich subtest_basic_usdt case in selftests to cover SIB handling logic
      libbpf: Remove unused args in parse_usdt_note

Jiayuan Chen (1):
      selftests/bpf: Fix incorrect array size calculation

Jiri Olsa (6):
      bpf: Allow uprobe program to change context registers
      uprobe: Do not emulate/sstep original instruction when ip is changed
      selftests/bpf: Add uprobe context registers changes test
      selftests/bpf: Add uprobe context ip register change test
      selftests/bpf: Add kprobe write ctx attach test
      selftests/bpf: Add kprobe multi write ctx attach test

KP Singh (12):
      bpf: Update the bpf_prog_calc_tag to use SHA256
      bpf: Implement exclusive map creation
      libbpf: Implement SHA256 internal helper
      libbpf: Support exclusive map creation
      selftests/bpf: Add tests for exclusive maps
      bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD
      bpf: Move the signature kfuncs to helpers.c
      bpf: Implement signature verification for BPF programs
      libbpf: Update light skeleton for signing
      libbpf: Embed and verify the metadata hash in the loader
      bpftool: Add support for signing BPF programs
      selftests/bpf: Enable signature verification for some lskel tests

Kumar Kartikeya Dwivedi (6):
      bpf: Do not limit bpf_cgroup_from_id to current's namespace
      selftests/bpf: Add a test for bpf_cgroup_from_id lookup in non-root cgns
      bpf: Enforce RCU protection for KF_RCU_PROTECTED
      selftests/bpf: Add tests for KF_RCU_PROTECTED
      bpf, x86: Add support for signed arena loads
      selftests/bpf: Add stress test for rqspinlock in NMI

Leon Hwang (5):
      selftests/bpf: Introduce experimental bpf_in_interrupt()
      selftests/bpf: Add case to test bpf_in_interrupt()
      selftests/bpf: Skip timer_interrupt case when bpf_timer is not supported
      bpf: Allow union argument in trampoline based programs
      selftests/bpf: Add union argument tests using fexit programs

Li Jun (1):
      bpf: Standardize function declaration style

Magnus Karlsson (1):
      MAINTAINERS: Delete inactive maintainers from AF_XDP

Marco Crivellari (3):
      bpf: replace use of system_wq with system_percpu_wq
      bpf: replace use of system_unbound_wq with system_dfl_wq
      bpf: WQ_PERCPU added to alloc_workqueue users

Martin KaFai Lau (7):
      Merge branch 'allow-struct_ops-to-create-map-id-to'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge branch 'add-a-dynptr-type-for-skb-metadata-for-tc-bpf'
      Merge branch 'bpf-next/skb-meta-dynptr' into 'bpf-next/master'
      Merge branch 'bpf-next/skb-meta-dynptr' into 'bpf-next/master'
      Merge branch 'add-kfunc-bpf_xdp_pull_data'
      Merge branch 'bpf-next/xdp_pull_data' into 'bpf-next/master'

Matt Bobrowski (1):
      bpf/selftests: Fix test_tcpnotify_user

Matt Fleming (1):
      selftests/bpf: Add LPM trie microbenchmarks

Menglong Dong (10):
      rcu: add rcu_read_lock_dont_migrate()
      bpf: use rcu_read_lock_dont_migrate() for bpf_cgrp_storage_free()
      bpf: use rcu_read_lock_dont_migrate() for bpf_inode_storage_free()
      bpf: use rcu_read_lock_dont_migrate() for bpf_iter_run_prog()
      bpf: use rcu_read_lock_dont_migrate() for bpf_task_storage_free()
      bpf: use rcu_read_lock_dont_migrate() for bpf_prog_run_array_cg()
      bpf: use rcu_read_lock_dont_migrate() for trampoline.c
      selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
      selftests/bpf: skip recursive functions for kprobe_multi
      selftests/bpf: add benchmark testing for kprobe-multi-all

Mykyta Yatsenko (13):
      libbpf: Export bpf_object__prepare symbol
      selftests/bpf: Add BPF program dump in veristat
      bpf: refactor special field-type detection
      bpf: extract generic helper from process_timer_func()
      bpf: htab: extract helper for freeing special structs
      bpf: verifier: permit non-zero returns from async callbacks
      bpf: bpf task work plumbing
      bpf: extract map key pointer calculation
      bpf: task work scheduling kfuncs
      selftests/bpf: BPF task work scheduling tests
      selftests/bpf: add bpf task work stress tests
      selftests/bpf: Task_work selftest cleanup fixes
      selftests/bpf: Fix flaky bpf_cookie selftest

Nandakumar Edamana (2):
      bpf: Improve the general precision of tnum_mul
      bpf: Add selftest to check the verifier's abstract multiplication

Paul Chaignon (6):
      bpf: Tidy verifier bug message
      bpf: Use tnums for JEQ/JNE is_branch_taken logic
      selftests/bpf: Tests for is_scalar_branch_taken tnum logic
      bpf: Explicitly check accesses to bpf_sock_addr
      selftests/bpf: Move macros to bpf_misc.h
      selftests/bpf: Test accesses to ctx padding

Pu Lehui (10):
      riscv, bpf: Extract emit_stx() helper
      riscv, bpf: Extract emit_st() helper
      riscv, bpf: Extract emit_ldx() helper
      riscv: Separate toolchain support dependency from RISCV_ISA_ZACAS
      riscv, bpf: Add rv_ext_enabled macro for runtime detection extentsion
      riscv, bpf: Add Zacas instructions
      riscv, bpf: Optimize cmpxchg insn with Zacas support
      riscv, bpf: Add ex_insn_off and ex_jmp_off for exception table handling
      riscv, bpf: Add support arena atomics for RV64
      selftests/bpf: Enable arena atomics tests for RV64

Puranjay Mohan (10):
      bpf, arm64: Add JIT support for timed may_goto
      selftests/bpf: Enable timed may_goto tests for arm64
      bpf: arm64: simplify exception table handling
      bpf: core: introduce main_prog_aux for stream access
      bpf: Report arena faults to BPF stderr
      selftests: bpf: introduce __stderr and __stdout
      selftests: bpf: use __stderr in stream error tests
      selftests/bpf: Add tests for arena fault reporting
      bpf, arm64: Add support for signed arena loads
      selftests: bpf: Add tests for signed loads from arena

Qianfeng Rong (2):
      bpf: Remove redundant __GFP_NOWARN
      bpf: Replace kvfree with kfree for kzalloc memory

Quentin Monnet (2):
      bpftool: Search for tracefs at /sys/kernel/tracing first
      bpftool: Add bash completion for program signing options

Ricardo B. Marlière (3):
      selftests/bpf: Fix bpf_prog_detach2 usage in test_lirc_mode2
      selftests/bpf: Upon failures, exit with code 1 in test_xsk.sh
      selftests/bpf: Fix count write in testapp_xdp_metadata_copy()

Rong Tao (2):
      bpf: add bpf_strcasecmp kfunc
      selftests/bpf: Test kfunc bpf_strcasecmp

Saket Kumar Bhaskar (1):
      selftests/bpf: Fix arena_spin_lock selftest failure

Shubham Sharma (1):
      selftests/bpf: Fix typos and grammar in test sources

Tao Chen (10):
      bpftool: Add bpf_token show
      bpftool: Add bpftool-token manpage
      bpftool: Add bash completion for token argument
      bpf: Remove migrate_disable in kprobe_multi_link_prog_run
      bpf: Remove preempt_disable in bpf_try_get_buffers
      bpftool: Add HELP_SPEC_OPTIONS in token.c
      bpftool: Fix UAF in get_delegate_value
      bpf: Add lookup_and_delete_elem for BPF_MAP_STACK_TRACE
      selftests/bpf: Refactor stacktrace_map case with skeleton
      selftests/bpf: Add stacktrace map lookup_and_delete_elem test case

Thomas Weißschuh (1):
      bpf: Don't use %pK through printk

Tiezhu Yang (1):
      selftests/bpf: Remove entries from config.{arch} already present in config

Tom Stellard (1):
      bpftool: Fix -Wuninitialized-const-pointer warnings with clang >= 21

Vincent Li (1):
      bpftool: Add kernel.kptr_restrict hint for no instructions

Yonghong Song (1):
      selftests/bpf: Fix selftest verifier_arena_large failure

Yuan Chen (2):
      bpftool: Refactor kernel config reading into common helper
      bpftool: Add CET-aware symbol matching for x86_64 architectures

Yureka Lilian (2):
      libbpf: Fix reuse of DEVMAP
      selftests/bpf: Add test for DEVMAP reuse

 CREDITS                                            |   6 +
 Documentation/bpf/kfuncs.rst                       |  19 +-
 Documentation/bpf/verifier.rst                     | 264 -------
 MAINTAINERS                                        |   2 -
 arch/arm64/net/Makefile                            |   2 +-
 arch/arm64/net/bpf_jit_comp.c                      | 127 ++-
 arch/arm64/net/bpf_timed_may_goto.S                |  40 +
 arch/riscv/Kconfig                                 |   1 -
 arch/riscv/include/asm/cmpxchg.h                   |   6 +-
 arch/riscv/kernel/setup.c                          |   1 +
 arch/riscv/net/bpf_jit.h                           |  70 +-
 arch/riscv/net/bpf_jit_comp64.c                    | 569 +++++---------
 arch/s390/net/Makefile                             |   2 +-
 arch/s390/net/bpf_jit_comp.c                       | 148 ++--
 arch/s390/net/bpf_timed_may_goto.S                 |  45 ++
 arch/x86/net/bpf_jit_comp.c                        | 125 ++-
 crypto/asymmetric_keys/pkcs7_verify.c              |   1 +
 include/linux/bpf.h                                |  73 +-
 include/linux/bpf_verifier.h                       |  65 +-
 include/linux/btf.h                                |   2 +-
 include/linux/cgroup.h                             |   1 +
 include/linux/filter.h                             |  17 +-
 include/linux/rcupdate.h                           |  14 +
 include/linux/tnum.h                               |   6 +
 include/linux/verification.h                       |   1 +
 include/net/xdp.h                                  |   5 +
 include/net/xdp_sock_drv.h                         |  21 +-
 include/uapi/linux/bpf.h                           |  22 +
 kernel/bpf/Kconfig                                 |   2 +-
 kernel/bpf/Makefile                                |   2 +-
 kernel/bpf/arena.c                                 |  30 +
 kernel/bpf/arraymap.c                              |  21 +-
 kernel/bpf/bpf_cgrp_storage.c                      |   6 +-
 kernel/bpf/bpf_inode_storage.c                     |   6 +-
 kernel/bpf/bpf_iter.c                              |   6 +-
 kernel/bpf/bpf_lru_list.c                          |  10 +-
 kernel/bpf/bpf_struct_ops.c                        |  12 +
 kernel/bpf/bpf_task_storage.c                      |   6 +-
 kernel/bpf/btf.c                                   |  99 ++-
 kernel/bpf/cgroup.c                                |  11 +-
 kernel/bpf/core.c                                  |  60 +-
 kernel/bpf/cpumap.c                                |   2 +-
 kernel/bpf/devmap.c                                |   2 +-
 kernel/bpf/hashtab.c                               |  43 +-
 kernel/bpf/helpers.c                               | 612 ++++++++++++++-
 kernel/bpf/liveness.c                              | 733 +++++++++++++++++
 kernel/bpf/local_storage.c                         |   2 +-
 kernel/bpf/log.c                                   |  30 +-
 kernel/bpf/memalloc.c                              |   2 +-
 kernel/bpf/stackmap.c                              |  16 +-
 kernel/bpf/syscall.c                               | 125 ++-
 kernel/bpf/tnum.c                                  |  63 +-
 kernel/bpf/trampoline.c                            |  18 +-
 kernel/bpf/verifier.c                              | 869 ++++++++++-----------
 kernel/cgroup/cgroup.c                             |  24 +-
 kernel/events/core.c                               |   4 +
 kernel/events/uprobes.c                            |   7 +
 kernel/trace/bpf_trace.c                           | 201 +----
 net/bpf/test_run.c                                 |  59 +-
 net/core/filter.c                                  | 210 ++++-
 tools/bpf/bpftool/Documentation/bpftool-gen.rst    |  13 +-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst   |  14 +-
 tools/bpf/bpftool/Documentation/bpftool-token.rst  |  64 ++
 tools/bpf/bpftool/Makefile                         |   6 +-
 tools/bpf/bpftool/bash-completion/bpftool          |  37 +-
 tools/bpf/bpftool/btf_dumper.c                     |   2 +-
 tools/bpf/bpftool/cgroup.c                         |   4 +
 tools/bpf/bpftool/common.c                         |  93 +++
 tools/bpf/bpftool/feature.c                        |  86 +-
 tools/bpf/bpftool/gen.c                            |  68 +-
 tools/bpf/bpftool/link.c                           |  54 +-
 tools/bpf/bpftool/main.c                           |  29 +-
 tools/bpf/bpftool/main.h                           |  21 +
 tools/bpf/bpftool/prog.c                           |  33 +-
 tools/bpf/bpftool/sign.c                           | 211 +++++
 tools/bpf/bpftool/token.c                          | 210 +++++
 tools/bpf/bpftool/tracelog.c                       |  11 +-
 tools/include/uapi/linux/bpf.h                     |  22 +
 tools/lib/bpf/bpf.c                                |   6 +-
 tools/lib/bpf/bpf.h                                |   5 +-
 tools/lib/bpf/bpf_gen_internal.h                   |   2 +
 tools/lib/bpf/gen_loader.c                         |  47 ++
 tools/lib/bpf/libbpf.c                             | 213 ++++-
 tools/lib/bpf/libbpf.h                             |  52 +-
 tools/lib/bpf/libbpf.map                           |   3 +
 tools/lib/bpf/libbpf_internal.h                    |   4 +
 tools/lib/bpf/skel_internal.h                      |  76 +-
 tools/lib/bpf/usdt.bpf.h                           |  44 +-
 tools/lib/bpf/usdt.c                               |  72 +-
 tools/testing/selftests/bpf/.gitignore             |   1 +
 tools/testing/selftests/bpf/DENYLIST.s390x         |   1 -
 tools/testing/selftests/bpf/Makefile               |  43 +-
 tools/testing/selftests/bpf/bench.c                |  22 +-
 tools/testing/selftests/bpf/bench.h                |   1 +
 .../selftests/bpf/benchs/bench_lpm_trie_map.c      | 555 +++++++++++++
 tools/testing/selftests/bpf/benchs/bench_sockmap.c |   5 +-
 tools/testing/selftests/bpf/benchs/bench_trigger.c |  61 ++
 .../selftests/bpf/benchs/run_bench_trigger.sh      |   4 +-
 tools/testing/selftests/bpf/bpf_experimental.h     |  54 ++
 tools/testing/selftests/bpf/bpf_kfuncs.h           |   3 +
 tools/testing/selftests/bpf/bpf_util.h             |   3 +
 tools/testing/selftests/bpf/cgroup_helpers.c       |  20 +
 tools/testing/selftests/bpf/cgroup_helpers.h       |   1 +
 tools/testing/selftests/bpf/config                 |   1 +
 tools/testing/selftests/bpf/config.aarch64         |  12 -
 tools/testing/selftests/bpf/config.ppc64el         |   1 -
 tools/testing/selftests/bpf/config.riscv64         |   1 -
 tools/testing/selftests/bpf/config.s390x           |  11 -
 tools/testing/selftests/bpf/config.x86_64          |   5 -
 tools/testing/selftests/bpf/network_helpers.c      |   2 +-
 tools/testing/selftests/bpf/prog_tests/align.c     | 178 ++---
 .../selftests/bpf/prog_tests/arena_spin_lock.c     |  13 +
 tools/testing/selftests/bpf/prog_tests/atomics.c   |  10 +-
 .../selftests/bpf/prog_tests/attach_probe.c        |  28 +
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |   3 +-
 tools/testing/selftests/bpf/prog_tests/btf_dump.c  |   2 +-
 .../selftests/bpf/prog_tests/cgroup_xattr.c        |   2 +-
 .../testing/selftests/bpf/prog_tests/cgrp_kfunc.c  |  71 ++
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |   2 +
 tools/testing/selftests/bpf/prog_tests/fd_array.c  |   2 +-
 .../selftests/bpf/prog_tests/fentry_fexit.c        |  15 +-
 .../testing/selftests/bpf/prog_tests/fentry_test.c |   9 +-
 .../testing/selftests/bpf/prog_tests/fexit_test.c  |   9 +-
 .../testing/selftests/bpf/prog_tests/kernel_flag.c |   2 +-
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   | 247 +-----
 tools/testing/selftests/bpf/prog_tests/map_excl.c  |  54 ++
 .../selftests/bpf/prog_tests/module_attach.c       |   2 +-
 .../bpf/prog_tests/pinning_devmap_reuse.c          |  50 ++
 .../bpf/prog_tests/prog_tests_framework.c          | 125 +++
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  |   4 +-
 .../selftests/bpf/prog_tests/res_spin_lock.c       |  16 +
 tools/testing/selftests/bpf/prog_tests/spin_lock.c |  12 +-
 .../selftests/bpf/prog_tests/stacktrace_build_id.c |   2 +-
 .../bpf/prog_tests/stacktrace_build_id_nmi.c       |   2 +-
 .../selftests/bpf/prog_tests/stacktrace_map.c      |  71 +-
 .../bpf/prog_tests/stacktrace_map_raw_tp.c         |   4 +-
 .../selftests/bpf/prog_tests/stacktrace_map_skip.c |   2 +-
 tools/testing/selftests/bpf/prog_tests/stream.c    | 131 ++--
 .../selftests/bpf/prog_tests/string_kfuncs.c       |   1 +
 .../selftests/bpf/prog_tests/task_local_data.h     | 386 +++++++++
 .../selftests/bpf/prog_tests/task_work_stress.c    | 130 +++
 .../prog_tests/test_struct_ops_id_ops_mapping.c    |  74 ++
 .../bpf/prog_tests/test_task_local_data.c          | 297 +++++++
 .../selftests/bpf/prog_tests/test_task_work.c      | 157 ++++
 .../selftests/bpf/prog_tests/test_veristat.c       |  44 +-
 tools/testing/selftests/bpf/prog_tests/timer.c     |  34 +
 .../selftests/bpf/prog_tests/tracing_struct.c      |  29 +
 tools/testing/selftests/bpf/prog_tests/uprobe.c    | 156 +++-
 tools/testing/selftests/bpf/prog_tests/usdt.c      |  83 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   4 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 222 +++++-
 .../selftests/bpf/prog_tests/xdp_devmap_attach.c   |  31 +-
 .../selftests/bpf/prog_tests/xdp_pull_data.c       | 179 +++++
 tools/testing/selftests/bpf/progs/arena_atomics.c  |   9 +-
 .../testing/selftests/bpf/progs/arena_spin_lock.c  |   5 +-
 tools/testing/selftests/bpf/progs/bpf_cc_cubic.c   |   2 +-
 tools/testing/selftests/bpf/progs/bpf_dctcp.c      |   2 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h       |  24 +
 tools/testing/selftests/bpf/progs/bpf_test_utils.h |  18 +
 .../selftests/bpf/progs/cgroup_read_xattr.c        |   2 +-
 .../selftests/bpf/progs/cgrp_kfunc_success.c       |  12 +
 tools/testing/selftests/bpf/progs/dynptr_fail.c    | 258 ++++++
 tools/testing/selftests/bpf/progs/dynptr_success.c |  55 ++
 .../selftests/bpf/progs/exceptions_assert.c        |  34 +-
 .../selftests/bpf/progs/freplace_connect_v4_prog.c |   2 +-
 .../selftests/bpf/progs/iters_state_safety.c       |   6 +-
 .../selftests/bpf/progs/iters_task_failure.c       |   4 +-
 tools/testing/selftests/bpf/progs/iters_testmod.c  |  46 ++
 .../selftests/bpf/progs/iters_testmod_seq.c        |   6 +-
 .../testing/selftests/bpf/progs/kprobe_write_ctx.c |  22 +
 tools/testing/selftests/bpf/progs/loop1.c          |   7 +-
 tools/testing/selftests/bpf/progs/loop2.c          |   7 +-
 tools/testing/selftests/bpf/progs/loop3.c          |   7 +-
 tools/testing/selftests/bpf/progs/loop6.c          |  21 +-
 tools/testing/selftests/bpf/progs/lpm_trie.h       |  30 +
 tools/testing/selftests/bpf/progs/lpm_trie_bench.c | 230 ++++++
 tools/testing/selftests/bpf/progs/lpm_trie_map.c   |  19 +
 tools/testing/selftests/bpf/progs/map_excl.c       |  34 +
 .../selftests/bpf/progs/mem_rdonly_untrusted.c     |   4 +-
 tools/testing/selftests/bpf/progs/rbtree_search.c  |   2 +-
 .../{test_stacktrace_map.c => stacktrace_map.c}    |   2 +
 tools/testing/selftests/bpf/progs/stream.c         | 158 ++++
 .../selftests/bpf/progs/string_kfuncs_failure1.c   |   6 +
 .../selftests/bpf/progs/string_kfuncs_failure2.c   |   1 +
 .../selftests/bpf/progs/string_kfuncs_success.c    |   5 +
 .../bpf/progs/struct_ops_id_ops_mapping1.c         |  59 ++
 .../bpf/progs/struct_ops_id_ops_mapping2.c         |  59 ++
 .../selftests/bpf/progs/struct_ops_kptr_return.c   |   2 +-
 .../selftests/bpf/progs/struct_ops_refcounted.c    |   2 +-
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c        |   3 +
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c        |   3 +
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c        |   3 +
 .../bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c  |   3 +
 .../selftests/bpf/progs/task_local_data.bpf.h      | 237 ++++++
 tools/testing/selftests/bpf/progs/task_work.c      | 107 +++
 tools/testing/selftests/bpf/progs/task_work_fail.c |  96 +++
 .../testing/selftests/bpf/progs/task_work_stress.c |  73 ++
 .../selftests/bpf/progs/test_cls_redirect.c        |   6 +-
 .../selftests/bpf/progs/test_cls_redirect_dynptr.c |   2 +-
 tools/testing/selftests/bpf/progs/test_overhead.c  |   5 +-
 .../selftests/bpf/progs/test_pinning_devmap.c      |  20 +
 .../selftests/bpf/progs/test_task_local_data.c     |  65 ++
 .../selftests/bpf/progs/test_tcp_hdr_options.c     |   5 +-
 .../selftests/bpf/progs/test_tcpnotify_kern.c      |   1 -
 tools/testing/selftests/bpf/progs/test_uprobe.c    |  38 +
 tools/testing/selftests/bpf/progs/test_usdt.c      |  31 +
 .../selftests/bpf/progs/test_xdp_devmap_tailcall.c |  29 +
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 419 ++++++++++
 .../selftests/bpf/progs/test_xdp_pull_data.c       |  48 ++
 .../testing/selftests/bpf/progs/timer_interrupt.c  |  48 ++
 tools/testing/selftests/bpf/progs/tracing_struct.c |  33 +
 tools/testing/selftests/bpf/progs/trigger_bench.c  |  12 +
 .../testing/selftests/bpf/progs/uretprobe_stack.c  |   4 +-
 .../selftests/bpf/progs/verifier_arena_large.c     |   1 +
 .../testing/selftests/bpf/progs/verifier_bounds.c  |  79 +-
 .../selftests/bpf/progs/verifier_bpf_fastcall.c    |  27 +-
 tools/testing/selftests/bpf/progs/verifier_ctx.c   |  32 +-
 .../selftests/bpf/progs/verifier_global_ptr_args.c |   4 +-
 tools/testing/selftests/bpf/progs/verifier_ldsx.c  | 178 ++++-
 .../selftests/bpf/progs/verifier_live_stack.c      | 294 +++++++
 .../testing/selftests/bpf/progs/verifier_loops1.c  |  21 +
 .../testing/selftests/bpf/progs/verifier_map_ptr.c |   7 +-
 .../selftests/bpf/progs/verifier_may_goto_1.c      |  38 +-
 tools/testing/selftests/bpf/progs/verifier_mul.c   |  38 +
 .../selftests/bpf/progs/verifier_precision.c       |  16 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c      |  12 +-
 tools/testing/selftests/bpf/progs/verifier_sock.c  |  48 +-
 .../selftests/bpf/progs/verifier_spill_fill.c      |  40 +-
 .../bpf/progs/verifier_subprog_precision.c         |   6 +-
 .../testing/selftests/bpf/progs/verifier_var_off.c |   6 +-
 tools/testing/selftests/bpf/test_kmods/Makefile    |   2 +-
 .../selftests/bpf/test_kmods/bpf_test_rqspinlock.c | 209 +++++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c | 155 ++++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.h |   6 +
 .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |   4 +
 tools/testing/selftests/bpf/test_lirc_mode2_user.c |   2 +-
 tools/testing/selftests/bpf/test_loader.c          | 300 +++++--
 tools/testing/selftests/bpf/test_progs.c           |  13 +
 tools/testing/selftests/bpf/test_progs.h           |  17 +
 tools/testing/selftests/bpf/test_sockmap.c         |   2 +-
 tools/testing/selftests/bpf/test_tcpnotify_user.c  |  20 +-
 tools/testing/selftests/bpf/test_xsk.sh            |   2 +
 tools/testing/selftests/bpf/testing_helpers.c      |  14 +-
 tools/testing/selftests/bpf/testing_helpers.h      |   1 +
 tools/testing/selftests/bpf/trace_helpers.c        | 234 ++++++
 tools/testing/selftests/bpf/trace_helpers.h        |   3 +
 tools/testing/selftests/bpf/verifier/bpf_st_mem.c  |   4 +-
 tools/testing/selftests/bpf/verifier/calls.c       |   8 +-
 tools/testing/selftests/bpf/verify_sig_setup.sh    |  11 +-
 tools/testing/selftests/bpf/veristat.c             |  56 +-
 tools/testing/selftests/bpf/xdping.c               |   2 +-
 tools/testing/selftests/bpf/xsk.h                  |   4 +-
 tools/testing/selftests/bpf/xskxceiver.c           |  14 +-
 tools/testing/selftests/net/lib/xdp_native.bpf.c   |  89 ++-
 254 files changed, 11830 insertions(+), 2794 deletions(-)
 create mode 100644 arch/arm64/net/bpf_timed_may_goto.S
 create mode 100644 arch/s390/net/bpf_timed_may_goto.S
 create mode 100644 kernel/bpf/liveness.c
 create mode 100644 tools/bpf/bpftool/Documentation/bpftool-token.rst
 create mode 100644 tools/bpf/bpftool/sign.c
 create mode 100644 tools/bpf/bpftool/token.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_lpm_trie_map.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_excl.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_devmap_reuse.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_data.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_work_stress.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_id_ops_mapping.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_work.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_test_utils.h
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
 create mode 100644 tools/testing/selftests/bpf/progs/lpm_trie.h
 create mode 100644 tools/testing/selftests/bpf/progs/lpm_trie_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/lpm_trie_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_excl.c
 rename tools/testing/selftests/bpf/progs/{test_stacktrace_map.c => stacktrace_map.c} (98%)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_id_ops_mapping1.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_id_ops_mapping2.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_local_data.bpf.h
 create mode 100644 tools/testing/selftests/bpf/progs/task_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_stress.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_pinning_devmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_local_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_devmap_tailcall.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_interrupt.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_live_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_mul.c
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c

