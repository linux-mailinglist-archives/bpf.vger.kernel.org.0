Return-Path: <bpf+bounces-45115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA849D190B
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 20:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995841F22016
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 19:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AED1E5712;
	Mon, 18 Nov 2024 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lB3mxngc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578AE14F9CF;
	Mon, 18 Nov 2024 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731958603; cv=none; b=QdRaSDcuQH7QQi/iHw6Jx2/5W6TOKVWoMyoSFNpyWLSex0h/C06sFUKTqwKBVM4IWfsD4PJyE+K3Bmix6mxTMvDZ1O0ghO0YoZEA58K/VDHbkrdMWtUapNmX2hmLKafQjeqfwWHCvSm58DnaP0CqMTU2Rna4usFZvoBg7KVoqMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731958603; c=relaxed/simple;
	bh=rfyGJnVFPjIMsnyY0j/nZ/7GaNED2ggTZ0g3gLAHIjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sNmizGba6AbqieEwTZVlH7fYnLFhyLLujQ/N71oI5UA4WZla9Aptzay3n416ay4QrMMHO/4WHR3SH0Gz9EuEdiROCGGfnalqekb2mr8M9xe3tXO19E2wCT+RViT3FMlZQ1NPnRERbJVpcw/Pu7JhNApxwj4Ms344k1Qno7NtqOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lB3mxngc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7242f559a9fso169913b3a.1;
        Mon, 18 Nov 2024 11:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731958599; x=1732563399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qANuAm7vLgV+XAw13VgujhjbJWUIzcEjMpJoBqhdbPM=;
        b=lB3mxngctzFP4ik6EQcOGTgfzEfQA81Ex8bjryEKinC4QxKCtPa3gE9tlwwySozdpE
         lpCNIOrTgLdKYK9UBiCHE/z5nJnnD2VW3Q+gko9DU7bX72WE6uPUACy92UVYNf0/8F8u
         tXAMucH6yB3IitbhOeTzBQS6W3B97JTHhmuJIlj8C9NufHXASDBNo5uUUM2YNxK9bZCV
         +X/SDum+9snDQn1W26KVo7P63g6qD/sdYoA/AfhU4+dGS43VqUzzDiXKgNOdxm9MdgW/
         yubXhreWn9CTUChyrxWpsD+6023Duundgo4jylfvzuxktcSpgSVq/y7mmdq/6lPEGtlo
         QvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731958599; x=1732563399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qANuAm7vLgV+XAw13VgujhjbJWUIzcEjMpJoBqhdbPM=;
        b=q7FRmojqDNgwUntJXfARrULPTrT1bBYupCu+SSoYCpInyrcq4+5S/ke25byiA0ZJs4
         M8QrWImh/e1Zm6jsMBR+oidyVxgiA1Ra78PPz1Fgl2O+M1hcDd2EAMX5AS2Se2HfE/DQ
         ucwGO6nKrGKZBSkc+ZdkTa1PmsKCXZa2ud3pUhd7U6MTFpT0P/r5svxG2/8nY8TVANZv
         GWENMnSwMmq85mVhzfewGc6cT9S4hyCS5S1zYHK41SrsUNOZl3/pS4390RKMZIjDx9WN
         DYKO0BcLlpN7ngsqCdn3InEv7N/O/h6E0jWKIL739+NQBORYoGGcvxa4pUn1t/LfxiUl
         Kgsw==
X-Forwarded-Encrypted: i=1; AJvYcCU1MWx59AAHA/YHFGuDnedgNB8YQsp4k+XMCqoMIPauWK0+U4jT3S3YpgyhVe3z3nNAhWr3tw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ/dZDeX06rqERFSRhu4NbhreEKTi9U52NGrl1xPTsmPiFV94K
	6v4M/8pwYTJRLe6BQ823MlFsSuA89HT7FpLp2pJK5m5mI61WmPcI
X-Google-Smtp-Source: AGHT+IFZ08k36fgOP74GMco1xYetq84dlIfOzfjwzrlsU93gx6xbsdBIPilWhs92pYwCyjqg7aM1cA==
X-Received: by 2002:a05:6a00:3a1f:b0:71e:692e:7afb with SMTP id d2e1a72fcca58-72476b72b62mr19321122b3a.5.1731958599300;
        Mon, 18 Nov 2024 11:36:39 -0800 (PST)
Received: from localhost.localdomain ([12.37.166.69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0d4esm6518159b3a.117.2024.11.18.11.36.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 Nov 2024 11:36:38 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	peterz@infradead.org,
	mingo@kernel.org,
	jolsa@kernel.org,
	martin.lau@kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] BPF changes for v6.13
Date: Mon, 18 Nov 2024 11:36:35 -0800
Message-Id: <20241118193635.77842-1-alexei.starovoitov@gmail.com>
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

The following changes since commit 9f8e716d46c68112484a23d1742d9ec725e082fc:

  Merge tag 'bpf-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2024-11-13 09:14:19 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.13

for you to fetch changes up to 2c8b09ac2537299511c898bc71b1a5f2756c831c:

  libbpf: Change hash_combine parameters from long to unsigned long (2024-11-16 11:01:38 -0800)

----------------------------------------------------------------
= BPF networking changes will come via net-next PR

= Several arch/x86/ and uprobe patches are also in Ingo's PR:
  https://lore.kernel.org/all/Zzt5lYZGF8IOrgpB@gmail.com/
  They were pulled into bpf-next via stable tag 'perf-core-for-bpf-next'.
  Then Jiri's uprobe session patches were applied on top.
  tip or bpf-next PRs can be pulled in any order. sha-s are the same.

= The following are the main BPF changes (there should be no conflicts):

- Add BPF uprobe session support (Jiri Olsa)

- Optimize uprobe performance (Andrii Nakryiko)

- Add bpf_fastcall support to helpers and kfuncs (Eduard Zingerman)

- Avoid calling free_htab_elem() under hash map bucket lock (Hou Tao)

- Prevent tailcall infinite loop caused by freplace (Leon Hwang)

- Mark raw_tracepoint arguments as nullable (Kumar Kartikeya Dwivedi)
      
- Introduce uptr support in the task local storage map (Martin KaFai Lau)

- Stringify errno log messages in libbpf (Mykyta Yatsenko)

- Add kmem_cache BPF iterator for perf's lock profiling (Namhyung Kim)

- Support BPF objects of either endianness in libbpf (Tony Ambardar)

- Add ksym to struct_ops trampoline to fix stack trace (Xu Kuohai)

- Introduce private stack for eligible BPF programs (Yonghong Song)

- Migrate samples/bpf tests to selftests/bpf test_progs (Daniel T. Lee)

- Migrate test_sock to selftests/bpf test_progs (Jordan Rife)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Abhinav Saxena (1):
      bpf: Remove trailing whitespace in verifier.rst

Alan Maguire (2):
      selftests/bpf: Fix uprobe_multi compilation error
      docs/bpf: Add description of .BTF.base section

Alexei Starovoitov (17):
      Merge branch 'selftests-bpf-migrate-and-remove-cgroup-tracing-related-tests'
      Merge branch 'bpf-add-kmem_cache-iterator-and-kfunc'
      Merge branch 'bpf-fix-tailcall-infinite-loop-caused-by-freplace'
      Merge branch 'fix-libbpf-s-bpf_object-and-bpf-subskel-interoperability'
      Merge branch 'share-user-memory-to-bpf-program-through-task-storage-map'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge branch 'fix-resource-leak-checks-for-tail-calls'
      Merge branch 'handle-possible-null-trusted-raw_tp-arguments'
      Merge branch 'fix-lockdep-warning-for-htab-of-map'
      Merge branch 'refactor-lock-management'
      Merge branch 'selftests-bpf-fix-for-bpf_signal-stalls-watchdog-for-test_progs'
      Merge branch 'bpf-support-private-stack-for-bpf-progs'
      Merge branch 'add-kernel-symbol-for-struct_ops-trampoline'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      bpf: Introduce range_tree data structure and use it in bpf arena
      selftests/bpf: Add a test for arena range tree algorithm
      selftests/bpf: Fix build error with llvm 19

Alistair Francis (1):
      bpf: Move btf_type_is_struct_ptr() under CONFIG_BPF_SYSCALL

Andrii Nakryiko (21):
      Merge branch 'libbpf-selftests-bpf-support-cross-endian-usage'
      Merge branch 'bpf_fastcall-attribute-in-vmlinux-h-and-bpf_helper_defs-h'
      uprobes: switch to RCU Tasks Trace flavor for better performance
      Merge branch 'bpf-static-linker-fix-linking-duplicate-extern-functions'
      libbpf: fix sym_is_subprog() logic for weak global subprogs
      libbpf: never interpret subprogs in .text as entry programs
      selftests/bpf: add subprog to BPF object file with no entry programs
      Merge branch 'implement-mechanism-to-signal-other-threads'
      Merge branch 'fix-wmaybe-uninitialized-warnings-errors'
      selftests/bpf: fix test_spin_lock_fail.c's global vars usage
      libbpf: move global data mmap()'ing into bpf_object__load()
      selftests/bpf: validate generic bpf_object and subskel APIs work together
      libbpf: start v1.6 development cycle
      selftests/bpf: drop unnecessary bpf_iter.h type duplication
      uprobes: allow put_uprobe() from non-sleepable softirq context
      uprobes: SRCU-protect uretprobe lifetime (with timeout)
      Merge tag 'perf-core-for-bpf-next' from tip tree
      Merge branch 'bpf-add-uprobe-session-support'
      Merge branch 'libbpf-stringify-error-codes-in-log-messages'
      Merge branch 'bpf-range_tree-for-bpf-arena'
      bpf: use common instruction history across all states

Björn Töpel (2):
      libbpf: Add missing per-arch include path
      selftests: bpf: Add missing per-arch include path

Breno Leitao (1):
      perf/x86/amd: Warn only on new bits set

Chen Ni (1):
      libbpf: Remove unneeded semicolon

Christophe JAILLET (1):
      bpf: Constify struct btf_kind_operations

Daniel T. Lee (4):
      selftests/bpf: migrate cgroup sock create test for setting iface/mark/prio
      selftests/bpf: migrate cgroup sock create test for prohibiting sockets
      samples/bpf: remove obsolete cgroup related tests
      samples/bpf: remove obsolete tracing related tests

Dapeng Mi (4):
      perf/x86: Refine hybrid_pmu_type defination
      x86/cpu/intel: Define helper to get CPU core native ID
      perf/x86/intel: Support hybrid PMU with multiple atom uarchs
      perf/x86/intel: Add PMU support for ArrowLake-H

Eder Zulian (3):
      resolve_btfids: Fix compiler warnings
      libbpf: Prevent compiler warnings/errors
      libsubcmd: Silence compiler warning

Eduard Zingerman (9):
      bpf: Allow specifying bpf_fastcall attribute for BPF helpers
      bpf: __bpf_fastcall for bpf_get_smp_processor_id in uapi
      bpf: Use KF_FASTCALL to mark kfuncs supporting fastcall contract
      bpftool: __bpf_fastcall for kfuncs marked with special decl_tag
      selftests/bpf: Fix backtrace printing for selftests crashes
      selftests/bpf: watchdog timer for test_progs
      selftests/bpf: add read_with_timeout() utility function
      selftests/bpf: allow send_signal test to timeout
      selftests/bpf: update send_signal to lower perf evemts frequency

Eric Long (2):
      libbpf: Do not resolve size on duplicate FUNCs
      selftests/bpf: Test linking with duplicate extern functions

Florian Schmaus (1):
      kbuild,bpf: Pass make jobs' value to pahole

Hou Tao (3):
      bpf: Call free_htab_elem() after htab_unlock_bucket()
      selftests/bpf: Move ENOTSUPP from bpf_util.h
      selftests/bpf: Test the update operations for htab of maps

Ihor Solodrai (5):
      selftests/bpf: Remove test_skb_cgroup_id.sh from TEST_PROGS
      selftests/bpf: Set vpath in Makefile to search for skels
      libbpf: Change log level of BTF loading error message
      selftests/bpf: Check for timeout in perf_link test
      selftests/bpf: Set test path for token/obj_priv_implicit_token_envvar

Jason Xing (2):
      bpf: syscall_nrs: Disable no previous prototype warnning
      bpf: handle implicit declaration of function gettid in bpf_iter.c

Jiri Olsa (19):
      selftests/bpf: Fix uprobe consumer test
      selftests/bpf: Bail out quickly from failing consumer test
      uprobe: Add data pointer to consumer handlers
      uprobe: Add support for session consumer
      selftests/bpf: Fix uprobe consumer test (again)
      bpf: Allow return values 0 and 1 for kprobe session
      bpf: Force uprobe bpf program to always return 0
      bpf: Add support for uprobe multi session attach
      bpf: Add support for uprobe multi session context
      libbpf: Add support for uprobe multi session attach
      selftests/bpf: Add uprobe session test
      selftests/bpf: Add uprobe session cookie test
      selftests/bpf: Add uprobe session recursive test
      selftests/bpf: Add uprobe session verifier test for return value
      selftests/bpf: Add kprobe session verifier test for return value
      selftests/bpf: Add uprobe session single consumer test
      selftests/bpf: Add uprobe sessions to consumer test
      selftests/bpf: Add threads to consumer test
      libbpf: Fix memory leak in bpf_program__attach_uprobe_multi

Jordan Rife (4):
      selftests/bpf: Migrate *_POST_BIND test cases to prog_tests
      selftests/bpf: Migrate LOAD_REJECT test cases to prog_tests
      selftests/bpf: Migrate BPF_CGROUP_INET_SOCK_CREATE test cases to prog_tests
      selftests/bpf: Retire test_sock.c

Juntong Deng (2):
      bpf: Add bpf_task_from_vpid() kfunc
      selftests/bpf: Add tests for bpf_task_from_vpid() kfunc

Kan Liang (2):
      perf/x86/rapl: Move the pmu allocation out of CPU hotplug
      perf/x86/rapl: Clean up cpumask and hotplug

Kui-Feng Lee (4):
      bpf: Support __uptr type tag in BTF
      bpf: Handle BPF_UPTR in verifier
      libbpf: define __uptr.
      selftests/bpf: Some basic __uptr tests

Kumar Kartikeya Dwivedi (8):
      bpf: Tighten tail call checks for lingering locks, RCU, preempt_disable
      bpf: Unify resource leak checks
      selftests/bpf: Add tests for tail calls with locks and refs
      bpf: Mark raw_tp arguments with PTR_MAYBE_NULL
      selftests/bpf: Clean up open-coded gettid syscall invocations
      selftests/bpf: Add tests for raw_tp null handling
      bpf: Refactor active lock management
      bpf: Drop special callback reference handling

Leon Hwang (4):
      bpf: Prevent tailcall infinite loop caused by freplace
      selftests/bpf: Add test to verify tailcall and freplace restrictions
      bpf, bpftool: Fix incorrect disasm pc
      bpf, x86: Propagate tailcall info only for subprogs

Luo Yifan (2):
      tools/bpf: Fix the wrong format specifier in bpf_jit_disasm
      bpftool: Cast variable `var` to long long

Manu Bretelle (1):
      selftests/bpf: vm: Add support for VIRTIO_FS

Markus Elfring (1):
      bpf: Call kfree(obj) only once in free_one()

Martin KaFai Lau (9):
      Merge branch 'Retire test_sock.c'
      bpf: Add "bool swap_uptrs" arg to bpf_local_storage_update() and bpf_selem_alloc()
      bpf: Postpone bpf_selem_free() in bpf_selem_unlink_storage_nolock()
      bpf: Postpone bpf_obj_free_fields to the rcu callback
      bpf: Add uptr support in the map_value of the task local storage.
      selftests/bpf: Test a uptr struct spanning across pages.
      selftests/bpf: Add update_elem failure test for task storage uptr
      selftests/bpf: Add uptr failure verifier tests
      selftests/bpf: Create task_local_storage map with invalid uptr's struct

Martin Kelly (1):
      bpf: Update bpf_override_return() comment

Matteo Croce (1):
      bpf: fix argument type in bpf_loop documentation

Menglong Dong (1):
      bpf: Replace the document for PTR_TO_BTF_ID_OR_NULL

Mykyta Yatsenko (6):
      selftests/bpf: Emit top frequent code lines in veristat
      selftests/bpf: Increase verifier log limit in veristat
      libbpf: Introduce errstr() for stringifying errno
      libbpf: Stringify errno in log messages in libbpf.c
      libbpf: Stringify errno in log messages in btf*.c
      libbpf: Stringify errno in log messages in the remaining code

Namhyung Kim (6):
      libbpf: Fix possible compiler warnings in hashmap
      bpf: Add kmem_cache iterator
      mm/bpf: Add bpf_get_kmem_cache() kfunc
      selftests/bpf: Add a test for kmem_cache_iter
      bpf: Add open coded version of kmem_cache iterator
      selftests/bpf: Add a test for open coded kmem_cache iter

Oleg Nesterov (9):
      uprobes: don't abuse get_utask() in pre_ssout() and prepare_uretprobe()
      uprobes: sanitiize xol_free_insn_slot()
      uprobes: kill the unnecessary put_uprobe/xol_free_insn_slot in uprobe_free_utask()
      uprobes: simplify xol_take_insn_slot() and its caller
      uprobes: move the initialization of utask->xol_vaddr from pre_ssout() to xol_get_insn_slot()
      uprobes: pass utask to xol_get_insn_slot() and xol_free_insn_slot()
      uprobes: deny mremap(xol_vma)
      uprobes: kill xol_area->slot_count
      uprobes: fold xol_take_insn_slot() into xol_get_insn_slot()

Puranjay Mohan (2):
      bpf: Implement bpf_send_signal_task() kfunc
      selftests/bpf: Augment send_signal test with remote signaling

Sidong Yang (1):
      libbpf: Change hash_combine parameters from long to unsigned long

Tao Chen (1):
      libbpf: Fix expected_attach_type set handling in program load callback

Tony Ambardar (8):
      libbpf: Improve log message formatting
      libbpf: Fix header comment typos for BTF.ext
      libbpf: Fix output .symtab byte-order during linking
      libbpf: Support BTF.ext loading and output in either endianness
      libbpf: Support opening bpf objects of either endianness
      libbpf: Support linking bpf objects of either endianness
      libbpf: Support creating light skeleton of either endianness
      selftests/bpf: Support cross-endian building

Viktor Malik (5):
      bpftool: Prevent setting duplicate _GNU_SOURCE in Makefile
      selftests/bpf: Disable warnings on unused flags for Clang builds
      selftests/bpf: Allow building with extra flags
      selftests/bpf: skip the timer_lockup test for single-CPU nodes
      bpf: Do not alloc arena on unsupported arches

Xu Kuohai (4):
      bpf, arm64: Remove garbage frame for struct_ops trampoline
      bpf: Remove unused member rcu from bpf_struct_ops_map
      bpf: Use function pointers count as struct_ops links count
      bpf: Add kernel symbol for struct_ops trampoline

Yonghong Song (8):
      bpf: Find eligible subprogs for private stack support
      bpf: Enable private stack for eligible subprogs
      bpf, x86: Avoid repeated usage of bpf_prog->aux->stack_depth
      bpf, x86: Support private stack in jit
      selftests/bpf: Add tracing prog private stack tests
      bpf: Support private stack for struct_ops progs
      selftests/bpf: Add struct_ops prog private stack tests
      bpf: Add necessary migrate_disable to range_tree.

Yuan Chen (1):
      bpf: Fix the xdp_adjust_tail sample prog issue

Zhang Jiao (1):
      selftests/bpf: Add missing va_end.

Zhu Jun (6):
      tools/bpf: Remove unused variable from runqslower
      samples/bpf: Remove unused variables
      samples/bpf: Fix a resource leak
      selftests/bpf: Removed redundant fd after close in bpf_prog_load_log_buf
      samples/bpf: Remove unused variables in tc_l2_redirect_kern.c
      samples/bpf: Remove unused variable in xdp2skb_meta_kern.c

 Documentation/bpf/btf.rst                          |  77 ++-
 Documentation/bpf/verifier.rst                     |   4 +-
 arch/Kconfig                                       |   1 +
 arch/arm64/net/bpf_jit_comp.c                      |  47 +-
 arch/x86/events/amd/core.c                         |  10 +-
 arch/x86/events/intel/core.c                       | 133 ++++-
 arch/x86/events/intel/ds.c                         |  21 +
 arch/x86/events/perf_event.h                       |  34 +-
 arch/x86/events/rapl.c                             | 130 ++---
 arch/x86/include/asm/cpu.h                         |   6 +
 arch/x86/kernel/cpu/intel.c                        |  15 +
 arch/x86/net/bpf_jit_comp.c                        | 149 ++++-
 include/linux/bpf.h                                |  63 ++-
 include/linux/bpf_local_storage.h                  |  12 +-
 include/linux/bpf_verifier.h                       |  67 ++-
 include/linux/btf.h                                |  22 +-
 include/linux/btf_ids.h                            |   1 +
 include/linux/cpuhotplug.h                         |   1 -
 include/linux/filter.h                             |   1 +
 include/linux/uprobes.h                            |  79 ++-
 include/uapi/linux/bpf.h                           |   9 +-
 kernel/bpf/Makefile                                |   3 +-
 kernel/bpf/arena.c                                 |  38 +-
 kernel/bpf/arraymap.c                              |  26 +-
 kernel/bpf/bpf_cgrp_storage.c                      |   4 +-
 kernel/bpf/bpf_inode_storage.c                     |   4 +-
 kernel/bpf/bpf_local_storage.c                     |  79 ++-
 kernel/bpf/bpf_struct_ops.c                        | 115 +++-
 kernel/bpf/bpf_task_storage.c                      |   7 +-
 kernel/bpf/btf.c                                   |  57 +-
 kernel/bpf/core.c                                  |   6 +
 kernel/bpf/dispatcher.c                            |   3 +-
 kernel/bpf/hashtab.c                               |  56 +-
 kernel/bpf/helpers.c                               |  29 +-
 kernel/bpf/kmem_cache_iter.c                       | 238 ++++++++
 kernel/bpf/memalloc.c                              |   5 +-
 kernel/bpf/range_tree.c                            | 272 +++++++++
 kernel/bpf/range_tree.h                            |  21 +
 kernel/bpf/syscall.c                               | 124 ++++-
 kernel/bpf/trampoline.c                            |  60 +-
 kernel/bpf/verifier.c                              | 597 ++++++++++++++------
 kernel/events/uprobes.c                            | 608 +++++++++++++++------
 kernel/trace/bpf_trace.c                           | 116 +++-
 kernel/trace/trace_uprobe.c                        |  12 +-
 mm/slab_common.c                                   |  19 +
 net/core/bpf_sk_storage.c                          |   6 +-
 samples/bpf/Makefile                               |  25 -
 samples/bpf/sock_flags.bpf.c                       |  47 --
 samples/bpf/syscall_nrs.c                          |   5 +
 samples/bpf/tc_l2_redirect_kern.c                  |   6 -
 samples/bpf/test_cgrp2_array_pin.c                 | 106 ----
 samples/bpf/test_cgrp2_attach.c                    | 177 ------
 samples/bpf/test_cgrp2_sock.c                      | 294 ----------
 samples/bpf/test_cgrp2_sock.sh                     | 137 -----
 samples/bpf/test_cgrp2_sock2.c                     |  95 ----
 samples/bpf/test_cgrp2_sock2.sh                    | 103 ----
 samples/bpf/test_cgrp2_tc.bpf.c                    |  56 --
 samples/bpf/test_cgrp2_tc.sh                       | 187 -------
 samples/bpf/test_current_task_under_cgroup.bpf.c   |  43 --
 samples/bpf/test_current_task_under_cgroup_user.c  | 115 ----
 samples/bpf/test_overhead_kprobe.bpf.c             |  41 --
 samples/bpf/test_overhead_raw_tp.bpf.c             |  17 -
 samples/bpf/test_overhead_tp.bpf.c                 |  23 -
 samples/bpf/test_overhead_user.c                   | 225 --------
 samples/bpf/test_override_return.sh                |  16 -
 samples/bpf/test_probe_write_user.bpf.c            |  52 --
 samples/bpf/test_probe_write_user_user.c           | 108 ----
 samples/bpf/tracex7.bpf.c                          |  15 -
 samples/bpf/tracex7_user.c                         |  56 --
 samples/bpf/xdp2skb_meta_kern.c                    |   2 +-
 samples/bpf/xdp_adjust_tail_kern.c                 |   1 +
 scripts/Makefile.btf                               |   6 +-
 scripts/bpf_doc.py                                 |  53 +-
 tools/bpf/bpf_jit_disasm.c                         |   2 +-
 tools/bpf/bpftool/Makefile                         |   6 +-
 tools/bpf/bpftool/btf.c                            | 100 +++-
 tools/bpf/bpftool/jit_disasm.c                     |  40 +-
 tools/bpf/resolve_btfids/main.c                    |   4 +-
 tools/bpf/runqslower/runqslower.bpf.c              |   1 -
 tools/include/uapi/linux/bpf.h                     |   9 +-
 tools/lib/bpf/Makefile                             |   3 +-
 tools/lib/bpf/bpf.c                                |   1 +
 tools/lib/bpf/bpf_gen_internal.h                   |   1 +
 tools/lib/bpf/bpf_helpers.h                        |   1 +
 tools/lib/bpf/btf.c                                | 308 ++++++++---
 tools/lib/bpf/btf.h                                |   3 +
 tools/lib/bpf/btf_dump.c                           |   7 +-
 tools/lib/bpf/btf_relocate.c                       |   2 +-
 tools/lib/bpf/elf.c                                |   4 +-
 tools/lib/bpf/features.c                           |  15 +-
 tools/lib/bpf/gen_loader.c                         | 190 +++++--
 tools/lib/bpf/hashmap.h                            |  20 +-
 tools/lib/bpf/libbpf.c                             | 526 +++++++++---------
 tools/lib/bpf/libbpf.h                             |   4 +-
 tools/lib/bpf/libbpf.map                           |   5 +
 tools/lib/bpf/libbpf_internal.h                    |  43 +-
 tools/lib/bpf/libbpf_version.h                     |   2 +-
 tools/lib/bpf/linker.c                             | 105 +++-
 tools/lib/bpf/relo_core.c                          |   2 +-
 tools/lib/bpf/ringbuf.c                            |  34 +-
 tools/lib/bpf/skel_internal.h                      |   3 +-
 tools/lib/bpf/str_error.c                          |  71 +++
 tools/lib/bpf/str_error.h                          |   7 +
 tools/lib/bpf/usdt.c                               |  32 +-
 tools/lib/bpf/zip.c                                |   2 +-
 tools/lib/subcmd/parse-options.c                   |   2 +-
 tools/testing/selftests/bpf/.gitignore             |   1 -
 tools/testing/selftests/bpf/Makefile               |  60 +-
 tools/testing/selftests/bpf/benchs/bench_trigger.c |   3 +-
 tools/testing/selftests/bpf/bpf_experimental.h     |   6 +
 .../selftests/bpf/bpf_testmod/bpf_testmod-events.h |   8 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        | 108 +++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h        |   5 +
 tools/testing/selftests/bpf/bpf_util.h             |  12 +
 tools/testing/selftests/bpf/config.vm              |   7 +-
 tools/testing/selftests/bpf/io_helpers.c           |  21 +
 tools/testing/selftests/bpf/io_helpers.h           |   7 +
 .../selftests/bpf/map_tests/task_storage_map.c     |   3 +-
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |   2 +-
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c  |  14 +-
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  |   4 -
 tools/testing/selftests/bpf/prog_tests/cb_refs.c   |   4 +-
 .../selftests/bpf/prog_tests/cgrp_local_storage.c  |  10 +-
 .../testing/selftests/bpf/prog_tests/core_reloc.c  |   2 +-
 tools/testing/selftests/bpf/prog_tests/iters.c     |   4 +-
 .../selftests/bpf/prog_tests/kmem_cache_iter.c     | 126 +++++
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   |   2 +
 .../selftests/bpf/prog_tests/linked_funcs.c        |   2 +-
 tools/testing/selftests/bpf/prog_tests/log_buf.c   |   3 -
 .../testing/selftests/bpf/prog_tests/lsm_cgroup.c  |   4 -
 .../testing/selftests/bpf/prog_tests/map_in_map.c  | 132 ++++-
 .../selftests/bpf/prog_tests/ns_current_pid_tgid.c |   2 +-
 tools/testing/selftests/bpf/prog_tests/perf_link.c |  15 +-
 .../testing/selftests/bpf/prog_tests/raw_tp_null.c |  25 +
 .../selftests/bpf/prog_tests/rcu_read_lock.c       |   4 +-
 .../testing/selftests/bpf/prog_tests/send_signal.c | 146 +++--
 tools/testing/selftests/bpf/prog_tests/sock_addr.c |   4 -
 .../testing/selftests/bpf/prog_tests/sock_create.c | 348 ++++++++++++
 .../{test_sock.c => prog_tests/sock_post_bind.c}   | 254 +++------
 .../bpf/prog_tests/struct_ops_private_stack.c      | 106 ++++
 .../testing/selftests/bpf/prog_tests/subskeleton.c |  76 ++-
 tools/testing/selftests/bpf/prog_tests/tailcalls.c | 128 ++++-
 .../testing/selftests/bpf/prog_tests/task_kfunc.c  |  80 +++
 .../selftests/bpf/prog_tests/task_local_storage.c  | 286 +++++++++-
 .../selftests/bpf/prog_tests/timer_lockup.c        |   6 +
 tools/testing/selftests/bpf/prog_tests/token.c     |  19 +-
 .../selftests/bpf/prog_tests/uprobe_multi_test.c   | 361 ++++++++++--
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 tools/testing/selftests/bpf/progs/bpf_iter.h       | 167 ------
 .../selftests/bpf/progs/bpf_iter_bpf_array_map.c   |   2 +-
 .../selftests/bpf/progs/bpf_iter_bpf_hash_map.c    |   2 +-
 .../selftests/bpf/progs/bpf_iter_bpf_link.c        |   2 +-
 .../testing/selftests/bpf/progs/bpf_iter_bpf_map.c |   2 +-
 .../bpf/progs/bpf_iter_bpf_percpu_array_map.c      |   2 +-
 .../bpf/progs/bpf_iter_bpf_percpu_hash_map.c       |   2 +-
 .../bpf/progs/bpf_iter_bpf_sk_storage_helpers.c    |   2 +-
 .../bpf/progs/bpf_iter_bpf_sk_storage_map.c        |   2 +-
 .../selftests/bpf/progs/bpf_iter_ipv6_route.c      |   2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c  |   2 +-
 .../testing/selftests/bpf/progs/bpf_iter_netlink.c |   2 +-
 .../selftests/bpf/progs/bpf_iter_setsockopt.c      |   2 +-
 .../selftests/bpf/progs/bpf_iter_setsockopt_unix.c |   2 +-
 .../testing/selftests/bpf/progs/bpf_iter_sockmap.c |   2 +-
 .../selftests/bpf/progs/bpf_iter_task_btf.c        |   2 +-
 .../selftests/bpf/progs/bpf_iter_task_file.c       |   2 +-
 .../selftests/bpf/progs/bpf_iter_task_stack.c      |   2 +-
 .../selftests/bpf/progs/bpf_iter_task_vmas.c       |   2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_tasks.c |   2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c  |   2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c  |   2 +-
 .../selftests/bpf/progs/bpf_iter_test_kern3.c      |   2 +-
 .../selftests/bpf/progs/bpf_iter_test_kern4.c      |   2 +-
 .../selftests/bpf/progs/bpf_iter_test_kern5.c      |   2 +-
 .../selftests/bpf/progs/bpf_iter_test_kern6.c      |   2 +-
 .../bpf/progs/bpf_iter_test_kern_common.h          |   2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_udp4.c  |   2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_udp6.c  |   2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_unix.c  |   2 +-
 .../selftests/bpf/progs/bpf_iter_vma_offset.c      |   2 +-
 tools/testing/selftests/bpf/progs/cgroup_iter.c    |   3 +-
 .../selftests/bpf/progs/cgrp_ls_sleepable.c        |   3 +-
 .../testing/selftests/bpf/progs/exceptions_fail.c  |   4 +-
 .../testing/selftests/bpf/progs/kmem_cache_iter.c  | 108 ++++
 .../selftests/bpf/progs/kprobe_multi_verifier.c    |  31 ++
 tools/testing/selftests/bpf/progs/linked_funcs1.c  |   8 +
 tools/testing/selftests/bpf/progs/linked_funcs2.c  |   8 +
 tools/testing/selftests/bpf/progs/preempt_lock.c   |  14 +-
 tools/testing/selftests/bpf/progs/raw_tp_null.c    |  32 ++
 .../selftests/bpf/progs/struct_ops_detach.c        |  12 +
 .../selftests/bpf/progs/struct_ops_private_stack.c |  62 +++
 .../bpf/progs/struct_ops_private_stack_fail.c      |  62 +++
 .../bpf/progs/struct_ops_private_stack_recur.c     |  50 ++
 tools/testing/selftests/bpf/progs/tailcall_fail.c  |  64 +++
 .../selftests/bpf/progs/task_kfunc_common.h        |   1 +
 .../selftests/bpf/progs/task_kfunc_failure.c       |  14 +
 .../selftests/bpf/progs/task_kfunc_success.c       |  51 ++
 tools/testing/selftests/bpf/progs/task_ls_uptr.c   |  63 +++
 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c     |   5 +-
 .../selftests/bpf/progs/test_send_signal_kern.c    |  35 +-
 .../selftests/bpf/progs/test_spin_lock_fail.c      |   4 +-
 .../selftests/bpf/progs/test_tp_btf_nullable.c     |   6 +-
 .../selftests/bpf/progs/update_map_in_htab.c       |  30 +
 .../selftests/bpf/progs/uprobe_multi_consumers.c   |   6 +-
 .../selftests/bpf/progs/uprobe_multi_session.c     |  71 +++
 .../bpf/progs/uprobe_multi_session_cookie.c        |  48 ++
 .../bpf/progs/uprobe_multi_session_recursive.c     |  44 ++
 .../bpf/progs/uprobe_multi_session_single.c        |  44 ++
 .../selftests/bpf/progs/uprobe_multi_verifier.c    |  31 ++
 tools/testing/selftests/bpf/progs/uptr_failure.c   | 105 ++++
 .../testing/selftests/bpf/progs/uptr_map_failure.c |  27 +
 .../selftests/bpf/progs/uptr_update_failure.c      |  42 ++
 .../selftests/bpf/progs/verifier_arena_large.c     | 110 +++-
 .../selftests/bpf/progs/verifier_private_stack.c   | 272 +++++++++
 .../selftests/bpf/progs/verifier_ref_tracking.c    |   4 +-
 tools/testing/selftests/bpf/progs/verifier_sock.c  |  60 ++
 .../selftests/bpf/progs/verifier_spin_lock.c       |   2 +-
 tools/testing/selftests/bpf/test_maps.c            |   4 -
 tools/testing/selftests/bpf/test_progs.c           | 114 +++-
 tools/testing/selftests/bpf/test_progs.h           |  14 +
 tools/testing/selftests/bpf/test_verifier.c        |   4 -
 tools/testing/selftests/bpf/uprobe_multi.c         |   4 +
 tools/testing/selftests/bpf/uptr_test_common.h     |  63 +++
 tools/testing/selftests/bpf/veristat.c             | 161 +++++-
 223 files changed, 7718 insertions(+), 3774 deletions(-)
 create mode 100644 kernel/bpf/kmem_cache_iter.c
 create mode 100644 kernel/bpf/range_tree.c
 create mode 100644 kernel/bpf/range_tree.h
 delete mode 100644 samples/bpf/sock_flags.bpf.c
 delete mode 100644 samples/bpf/test_cgrp2_array_pin.c
 delete mode 100644 samples/bpf/test_cgrp2_attach.c
 delete mode 100644 samples/bpf/test_cgrp2_sock.c
 delete mode 100755 samples/bpf/test_cgrp2_sock.sh
 delete mode 100644 samples/bpf/test_cgrp2_sock2.c
 delete mode 100755 samples/bpf/test_cgrp2_sock2.sh
 delete mode 100644 samples/bpf/test_cgrp2_tc.bpf.c
 delete mode 100755 samples/bpf/test_cgrp2_tc.sh
 delete mode 100644 samples/bpf/test_current_task_under_cgroup.bpf.c
 delete mode 100644 samples/bpf/test_current_task_under_cgroup_user.c
 delete mode 100644 samples/bpf/test_overhead_kprobe.bpf.c
 delete mode 100644 samples/bpf/test_overhead_raw_tp.bpf.c
 delete mode 100644 samples/bpf/test_overhead_tp.bpf.c
 delete mode 100644 samples/bpf/test_overhead_user.c
 delete mode 100755 samples/bpf/test_override_return.sh
 delete mode 100644 samples/bpf/test_probe_write_user.bpf.c
 delete mode 100644 samples/bpf/test_probe_write_user_user.c
 delete mode 100644 samples/bpf/tracex7.bpf.c
 delete mode 100644 samples/bpf/tracex7_user.c
 create mode 100644 tools/testing/selftests/bpf/io_helpers.c
 create mode 100644 tools/testing/selftests/bpf/io_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_create.c
 rename tools/testing/selftests/bpf/{test_sock.c => prog_tests/sock_post_bind.c} (64%)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
 delete mode 100644 tools/testing/selftests/bpf/progs/bpf_iter.h
 create mode 100644 tools/testing/selftests/bpf/progs/kmem_cache_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c
 create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_ls_uptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/update_map_in_htab.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c
 create mode 100644 tools/testing/selftests/bpf/progs/uptr_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/uptr_map_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/uptr_update_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_private_stack.c
 create mode 100644 tools/testing/selftests/bpf/uptr_test_common.h

