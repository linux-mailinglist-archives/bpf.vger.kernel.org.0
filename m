Return-Path: <bpf+bounces-54823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14717A734C4
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 15:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C22A3B690E
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 14:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F60217F40;
	Thu, 27 Mar 2025 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8mMnuVW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1B820CCED
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086422; cv=none; b=jSaUrLA+cXwcyBBge8TObJHUc6Pt2+QTufbfuAUarvi8+/Hd5xrrkjDPrt+0Jk4e+YMdHDsJw6VEypEjtZln45KfNSjijyx2x8+NGzn2qpITMZB5bEDS5PTh1HsPd7Aa61x+5J2KlpQ87k3OE9tqlJyTHdiAzO6Hv4yFlbm9Q+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086422; c=relaxed/simple;
	bh=Pu133qAnFgzfTkZy8K+PwJw0NwbwDxFKfpf0bY5Dfg4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=alguL6tz4j2x+aG7Umo5k6ICtptu4E74eHP29Id9zHp59halOM9cW/GlY6ATE6H/85nKAH7da5w1bzoq7b7Io4mfAWLi00/0xQedzmMaOc6bjnFLwHjVcKz4RNSlGeq6h6lWWy1o57ig1excG8YTX7ANtjIAiud2jx6iO7nqIoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8mMnuVW; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6eaf1b6ce9aso10807516d6.2
        for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 07:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743086418; x=1743691218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ufuyqyjLLPDL+BlUhDRUXtAfKOpepTVBm8obr87+WuA=;
        b=X8mMnuVWl5Vpp4ZO+vbAyuza5mRQjgqLYXYBOCC3iJ00yeN/l6a4d7g75As5Bi1M1+
         KjMB+e3yczzwqXlVopoVjc/MRPZsduJwpjJsa1iJZomdfk1kI+eypp+aGlCQxkPOgO0G
         ibllS7LZuGJqpQtJFK8NVi59RDb17Ir/S9ITpmiZWpeeMv9zxScplzSFoMUMHZJBQt5O
         tVT9fIPYSP7b73L7OHOfYu1eVJncq6Cz7Q1xaRnp0aCrO9gCysVMcGB1tYzBKn/GvKkV
         N2K2agMKZprNjOuZJb6Z6v1x8HmVHdX3OQXl4VBekHOxa/IHmsGdpIvKWx9nP7/lDxLt
         xmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743086418; x=1743691218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufuyqyjLLPDL+BlUhDRUXtAfKOpepTVBm8obr87+WuA=;
        b=s1SzpypntmcHBTcxXi862jhKrWabHmFfVMMBktt6oMciTG98qX3aLQX0Go9aB1piDF
         ge5/NV+YmqLvijwGjTNIeIwpstp4YMA9roO2UP1VKe3z7idvbQBOa+ymjhszl3DiK/4u
         jWCT2LG0zE9mMfv5MLZZ0GuaOESoj8vA6E8p6FbkkLSXclAXSvyomzQV+ToHjLygRlmA
         vCFXo4C9Z30UD/lsEkSKCurlq6+mny7xA0hcptPjSbxgzOzdPJ7ryTufGvfYNfQRB/sL
         8ouw2IKKIaqxCHAb4XgSWrdkgUzwZ81fIeyep7/YHWk/Zw+X1PUMLa5sfrT9t+ri/QWE
         0HKw==
X-Gm-Message-State: AOJu0YzHVV5SbwS1OvRGTpW3yoDzuBuZeYn16p4LgOvmgvob/vMztWqC
	vdyhFa+9cvoZINQwgd/L9FTZV/W7ievgEwKsP1qRRrDwn9NlUoOr
X-Gm-Gg: ASbGnctoOH5lSHk4CVoztWylZtCwuVTdk1hBAlcisrpuz5xxuWo5Flc8wohPfA+2QQ5
	wG3YoDy9vEo92PcIOxlUHdWFsjwMTfFC0QjSR+xFGp72gLWhAD4vxAwjsk4MOmBH35W+fgkHnB/
	5v7BEG/WJovq0S8ALkG7wDd8otSsCbbbB0qNPykvOHv1hsOqBu4j169PDnvHux3LppOhdQuT2VZ
	p90sbnwN6h0DtYoaNfgOy31CWl9o5+DU9JREbmwa2vY4uwJeieoH06yLno4IWxJg6JSS71vb9Ds
	bUj8zotkyydhXzxA/zL2EHcCAP03JLfDef3hIA09e/0I605smnm03q+lQBstnrQFkT3AqlbtyVv
	0aCVfRbINW1N3ODN+6RPLdXq006ylX+Sgm34=
X-Google-Smtp-Source: AGHT+IGhi3PqFOOfsUYp7fEJj+oGYfvtqP6kovwGUGm5rsLcMH1yE2hDNJdUa7E16bQ8/dl9a6+jqA==
X-Received: by 2002:a05:6214:2585:b0:6d8:8a8f:75b0 with SMTP id 6a1803df08f44-6ed238a87b0mr55884516d6.14.1743086417880;
        Thu, 27 Mar 2025 07:40:17 -0700 (PDT)
Received: from localhost.localdomain (219.sub-174-198-10.myvzw.com. [174.198.10.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec9628187sm110646d6.23.2025.03.27.07.40.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Mar 2025 07:40:17 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] Main BPF changes for 6.15
Date: Thu, 27 Mar 2025 10:40:13 -0400
Message-Id: <20250327144013.98005-1-alexei.starovoitov@gmail.com>
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

The following changes since commit 319fc77f8f45a1b3dba15b0cc1a869778fd222f7:

  Merge tag 'bpf-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2025-02-20 15:37:17 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.15

for you to fetch changes up to 9aa8fe29f624610b4694d5b5695e1017c4753f31:

  Merge branch 'bpf-fix-oob-read-and-add-tests-for-load-acquire-store-release' (2025-03-22 06:19:09 -0700)

----------------------------------------------------------------
For this merge window we're splitting BPF pull request into
three for higher visibility:
main changes, res_spin_lock, try_alloc_pages.

These are the main BPF changes:

- Add DFA-based live registers analysis to improve verification
  of programs with loops (Eduard Zingerman)

- Introduce load_acquire and store_release BPF instructions
  and add x86, arm64 JIT support (Peilin Ye)

- Fix loop detection logic in the verifier (Eduard Zingerman)

- Drop unnecesary lock in bpf_map_inc_not_zero() (Eric Dumazet)

- Add kfunc for populating cpumask bits (Emil Tsalapatis)

- Convert various shell based tests to selftests/bpf/test_progs
  format (Bastien Curutchet)

- Allow passing referenced kptrs into struct_ops callbacks
  (Amery Hung)

- Add a flag to LSM bpf hook to facilitate bpf program signing
  (Blaise Boscaccy)

- Track arena arguments in kfuncs (Ihor Solodrai)

- Add copy_remote_vm_str() helper for reading strings from
  remote VM and bpf_copy_from_user_task_str() kfunc (Jordan Rome)

- Add support for timed may_goto instruction (Kumar Kartikeya Dwivedi)

- Allow bpf_get_netns_cookie() int cgroup_skb programs (Mahe Tardy)

- Reduce bpf_cgrp_storage_busy false positives when accessing
  cgroup local storage (Martin KaFai Lau)

- Introduce bpf_dynptr_copy() kfunc (Mykyta Yatsenko)

- Allow retrieving BTF data with BTF token (Mykyta Yatsenko)

- Add BPF kfuncs to set and get xattrs with
  "security.bpf." prefix (Song Liu)

- Reject attaching programs to noreturn functions (Yafang Shao)

- Introduce pre-order traversal of cgroup bpf programs
  (Yonghong Song)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (18):
      Merge branch 'enable-writing-xattr-from-bpf-programs'
      Merge branch 'bpf-fix-array-bounds-error-with-may_goto-and-add-selftest'
      Merge branch 'extend-struct_ops-support-for-operators'
      Merge branch 'bpf-copy_verifier_state-should-copy-loop_entry-field'
      Merge branch 'selftests-bpf-tc_links-tc_opts-unserialize-tests'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf bpf-6.14-rc4
      bpf: Fix deadlock between rcu_tasks_trace and event_mutex.
      Merge branch 'optimize-bpf-selftest-to-increase-ci-success-rate'
      Merge branch 'global-subprogs-in-rcu-preempt-irq-disabled-sections'
      Merge branch 'timed-may_goto'
      Merge branch 'introduce-load-acquire-and-store-release-bpf-instructions'
      Merge branch 'bpf-simple-dfa-based-live-registers-analysis'
      Merge branch 'arena-spin-lock'
      Merge branch 'selftests-bpf-move-test_lwt_seg6local-to-test_progs'
      Merge branch 'bpf-introduce-helper-for-populating-bpf_cpumask'
      Merge branch 'security-propagate-caller-information-in-bpf-hooks'
      Merge branch 'bpf-reject-attaching-fexit-fmod_ret-to-noreturn-functions'
      Merge branch 'bpf-fix-oob-read-and-add-tests-for-load-acquire-store-release'

Alexis Lothoré (eBPF Foundation) (2):
      selftests/bpf: Enable kprobe_multi tests for ARM64
      bpf/selftests: test_select_reuseport_kern: Remove unused header

Amery Hung (14):
      selftests/bpf: Fix stdout race condition in traffic monitor
      bpf: Make every prog keep a copy of ctx_arg_info
      bpf: Support getting referenced kptr from struct_ops argument
      selftests/bpf: Test referenced kptr arguments of struct_ops programs
      bpf: Allow struct_ops prog to return referenced kptr
      selftests/bpf: Test returning referenced kptr from struct_ops programs
      bpf: Do not allow tail call in strcut_ops program with __ref argument
      selftests/bpf: Test struct_ops program with __ref arg calling bpf_tail_call
      bpf: Refactor check_ctx_access()
      bpf: Search and add kfuncs in struct_ops prologue and epilogue
      selftests/bpf: Test gen_pro/epilogue that generate kfuncs
      selftests/bpf: Clean up call sites of stdio_restore()
      selftests/bpf: Allow assigning traffic monitor print function
      selftests/bpf: Fix dangling stdout seen by traffic monitor thread

Andrea Terzolo (1):
      bpf: clarify a misleading verifier error message

Andrii Nakryiko (10):
      Merge branch 'btf-arbitrary-__attribute__-encoding'
      libbpf: fix LDX/STX/ST CO-RE relocation size adjustment logic
      selftests/bpf: add test for LDX/STX/ST relocations over array field
      libbpf: Fix hypothetical STT_SECTION extern NULL deref case
      Merge branch 'selftests-bpf-implement-setting-global-variables-in-veristat'
      Merge branch 'introduce-bpf_dynptr_copy-kfunc'
      Merge branch 'veristat-files-list-txt-notation-for-object-files-list'
      Merge branch 'introduce-bpf_object__prepare'
      Merge branch 'support-freplace-prog-from-user-namespace'
      Merge branch 'bpftool-using-the-right-format-specifiers'

Anton Protopopov (1):
      selftests/bpf: Fix selection of static vs. dynamic LLVM

Arnd Bergmann (1):
      bpf: preload: Add MODULE_DESCRIPTION

Bastien Curutchet (eBPF Foundation) (36):
      selftests/bpf: helpers: Add append_tid()
      selftests/bpf: test_xdp_veth: Remove unused defines
      selftests/bpf: test_xdp_veth: Remove unecessarry check_ping()
      selftests/bpf: test_xdp_veth: Use int to describe next veth
      selftests/bpf: test_xdp_veth: Split network configuration
      selftests/bpf: test_xdp_veth: Rename config[]
      selftests/bpf: test_xdp_veth: Add prog_config[] table
      selftests/bpf: test_xdp_veth: Add XDP flags to prog_configuration
      selftests/bpf: test_xdp_veth: Use unique names
      selftests/bpf: test_xdp_veth: Add new test cases for XDP flags
      selftests/bpf: Remove with_addr.sh and with_tunnels.sh
      selftests/bpf: test_xdp_veth: Create struct net_configuration
      selftests/bpf: test_xdp_veth: Use a dedicated namespace
      selftests/bpf: Optionally select broadcasting flags
      selftests/bpf: test_xdp_veth: Add XDP broadcast redirection tests
      selftests/bpf: test_xdp_veth: Add XDP program on egress test
      selftests/bpf: Remove test_xdp_redirect_multi.sh
      selftests/bpf: ns_current_pid_tgid: Rename the test function
      selftests/bpf: Optionally open a dedicated namespace to run test in it
      selftests/bpf: tc_links/tc_opts: Unserialize tests
      selftests/bpf: ns_current_pid_tgid: Use test_progs's ns_ feature
      selftests/bpf: test_tunnel: Add generic_attach* helpers
      selftests/bpf: test_tunnel: Add ping helpers
      selftests/bpf: test_tunnel: Move gre tunnel test to test_progs
      selftests/bpf: test_tunnel: Move ip6gre tunnel test to test_progs
      selftests/bpf: test_tunnel: Move erspan tunnel tests to test_progs
      selftests/bpf: test_tunnel: Move ip6erspan tunnel test to test_progs
      selftests/bpf: test_tunnel: Move geneve tunnel test to test_progs
      selftests/bpf: test_tunnel: Move ip6geneve tunnel test to test_progs
      selftests/bpf: test_tunnel: Move ip6tnl tunnel tests to test_progs
      selftests/bpf: test_tunnel: Remove test_tunnel.sh
      selftests/bpf: Move test_lwt_ip_encap to test_progs
      selftests/bpf: lwt_seg6local: Remove unused routes
      selftests/bpf: lwt_seg6local: Move test to test_progs
      selftests/bpf: test_xdp_vlan: Rename BPF sections
      selftests/bpf: Migrate test_xdp_vlan.sh into test_progs

Björn Töpel (1):
      selftests/bpf: Sanitize pointer prior fclose()

Blaise Boscaccy (2):
      security: Propagate caller information in bpf hooks
      selftests/bpf: Add a kernel flag test for LSM bpf hook

Breno Leitao (1):
      net: filter: Avoid shadowing variable in bpf_convert_ctx_access()

Chen Ni (1):
      selftests/bpf: Convert comma to semicolon

Daniel Xu (1):
      selftests/bpf: Support dynamically linking LLVM if static is not available

Eduard Zingerman (20):
      bpf: copy_verifier_state() should copy 'loop_entry' field
      selftests/bpf: test correct loop_entry update in copy_verifier_state
      bpf: don't do clean_live_states when state->loop_entry->branches > 0
      selftests/bpf: check states pruning for deeply nested iterator
      bpf: detect infinite loop in get_loop_entry()
      bpf: make state->dfs_depth < state->loop_entry->dfs_depth an invariant
      bpf: do not update state->loop_entry in get_loop_entry()
      bpf: use list_head to track explored states and free list
      bpf: free verifier states when they are no longer referenced
      bpf: fix env->peak_states computation
      bpf: abort verification if env->cur_state->loop_entry != NULL
      veristat: @files-list.txt notation for object files list
      veristat: Strerror expects positive number (errno)
      veristat: Report program type guess results to sdterr
      bpf: jmp_offset() and verbose_insn() utility functions
      bpf: get_call_summary() utility function
      bpf: simple DFA-based live registers analysis
      bpf: use register liveness information for func_states_equal
      selftests/bpf: test cases for compute_live_registers()
      bpf: correct use/def for may_goto instruction

Emil Tsalapatis (5):
      bpf: add kfunc for populating cpumask bits
      selftests: bpf: add bpf_cpumask_populate selftests
      bpf: fix missing kdoc string fields in cpumask.c
      selftests: bpf: fix duplicate selftests in cpumask_success.
      bpf: Make perf_event_read_output accessible in all program types.

Eric Dumazet (1):
      bpf: no longer acquire map_idr_lock in bpf_map_inc_not_zero()

Feng Yang (1):
      selftests/bpf: Fix cap_enable_effective() return code

Hou Tao (2):
      bpf: Use preempt_count() directly in bpf_send_signal_common()
      bpf: Check map->record at the beginning of check_and_free_fields()

Ian Rogers (1):
      libbpf: Add namespace for errstr making it libbpf_errstr

Ihor Solodrai (9):
      libbpf: Introduce kflag for type_tags and decl_tags in BTF
      docs/bpf: Document the semantics of BTF tags with kind_flag
      libbpf: Check the kflag of type tags in btf_dump
      selftests/bpf: Add a btf_dump test for type_tags
      bpf: Allow kind_flag for BTF type and decl tags
      selftests/bpf: Add a BTF verification test for kflagged type_tag
      bpf: define KF_ARENA_* flags for bpf_arena kfuncs
      libbpf: Implement bpf_usdt_arg_size BPF function
      selftests/bpf: Test bpf_usdt_arg_size() function

Jason Xing (1):
      selftests/bpf: Correct the check of join cgroup

Jiayuan Chen (9):
      bpftool: Using the right format specifiers
      bpf: Fix array bounds error with may_goto
      selftests/bpf: Introduce __load_if_JITed annotation for tests
      selftests/bpf: Add selftest for may_goto
      selftests/bpf: Allow auto port binding for cgroup connect
      selftests/bpf: Allow auto port binding for bpf nf
      selftests/bpf: Fixes for test_maps test
      bpftool: Add -Wformat-signedness flag to detect format errors
      bpftool: Using the right format specifiers

Jinghao Jia (1):
      samples/bpf: Fix broken vmlinux path for VMLINUX_BTF

Jiri Olsa (1):
      bpf: Add tracepoints with null-able arguments

Jordan Rome (3):
      mm: Add copy_remote_vm_str() for readng C strings from remote VM
      bpf: Add bpf_copy_from_user_task_str() kfunc
      selftests/bpf: Add tests for bpf_copy_from_user_task_str

Juntong Deng (1):
      bpf: Add struct_ops context information to struct bpf_prog_aux

Kohei Enju (2):
      bpf: Fix out-of-bounds read in check_atomic_load/store()
      selftests/bpf: Add selftests for load-acquire/store-release when register number is invalid

Kumar Kartikeya Dwivedi (10):
      bpf: Summarize sleepable global subprogs
      selftests/bpf: Test sleepable global subprogs in atomic contexts
      selftests/bpf: Add tests for extending sleepable global subprogs
      bpf: Add verifier support for timed may_goto
      bpf, x86: Add x86 JIT support for timed may_goto
      selftests/bpf: Introduce cond_break_label
      selftests/bpf: Introduce arena spin lock
      selftests/bpf: Add tests for arena spin lock
      selftests/bpf: Fix arena_spin_lock compilation on PowerPC
      bpf, x86: Fix objtool warning for timed may_goto

Levi Zim (1):
      bpf: Add comment about helper freeze

Mahe Tardy (2):
      bpf: add get_netns_cookie helper to cgroup_skb programs
      selftests/bpf: add cgroup_skb netns cookie tests

Martin KaFai Lau (6):
      bpf: Use kallsyms to find the function name of a struct_ops's stub function
      Merge branch 'selftests-bpf-migrate-test_xdp_redirect_multi-sh-to-test_progs'
      Merge branch 'selftests-bpf-migrate-test_xdp_redirect_multi-sh-to-test_progs'
      Merge branch 'selftests-bpf-migrate-test_tunnel-sh-to-test_progs'
      bpf: Only fails the busy counter check in bpf_cgrp_storage_get if it creates storage
      Merge branch 'selftests-bpf-migrate-test_xdp_vlan-sh-into-test_progs'

Mykyta Yatsenko (13):
      selftests/bpf: Implement setting global variables in veristat
      selftests/bpf: Introduce veristat test
      bpf/helpers: Refactor bpf_dynptr_read and bpf_dynptr_write
      bpf/helpers: Introduce bpf_dynptr_copy kfunc
      selftests/bpf: Add tests for bpf_dynptr_copy
      libbpf: Use map_is_created helper in map setters
      libbpf: Introduce more granular state for bpf_object
      libbpf: Split bpf object load into prepare/load
      selftests/bpf: Add tests for bpf_object__prepare
      bpf: BPF token support for BPF_BTF_GET_FD_BY_ID
      bpf: Return prog btf_id without capable check
      libbpf: Pass BPF token from find_prog_btf_id to BPF_BTF_GET_FD_BY_ID
      selftests/bpf: Test freplace from user namespace

Nandakumar Edamana (1):
      libbpf: Fix out-of-bound read

Peilin Ye (9):
      bpf: Factor out atomic_ptr_type_ok()
      bpf: Factor out check_atomic_rmw()
      bpf: Factor out check_load_mem() and check_store_reg()
      bpf: Introduce load-acquire and store-release instructions
      arm64: insn: Add BIT(23) to {load,store}_ex's mask
      arm64: insn: Add load-acquire and store-release instructions
      bpf, arm64: Support load-acquire and store-release instructions
      bpf, x86: Support load-acquire and store-release instructions
      selftests/bpf: Add selftests for load-acquire and store-release instructions

Pu Lehui (1):
      kbuild, bpf: Correct pahole version that supports distilled base btf feature

Rong Tao (1):
      bpftool: Check map name length when map create

Saket Kumar Bhaskar (3):
      selftests/bpf: Define SYS_PREFIX for powerpc
      selftests/bpf: Select NUMA_NO_NODE to create map
      selftests/bpf: Fix sockopt selftest failure on powerpc

Sewon Nam (1):
      bpf: bpftool: Setting error code in do_loader()

Song Liu (6):
      fs/xattr: bpf: Introduce security.bpf. xattr name prefix
      selftests/bpf: Extend test fs_kfuncs to cover security.bpf. xattr names
      bpf: lsm: Add two more sleepable hooks
      bpf: fs/xattr: Add BPF kfuncs to set and remove xattrs
      selftests/bpf: Test kfuncs that set and remove xattr from BPF programs
      bpf: arm64: Silence "UBSAN: negation-overflow" warning

T.J. Mercier (1):
      bpf, docs: Fix broken link to renamed bpf_iter_task_vmas.c

Tao Chen (1):
      libbpf: Wrap libbpf API direct err with libbpf_err

Tengda Wu (1):
      selftests/bpf: Fix freplace_link segfault in tailcalls prog test

Tony Ambardar (2):
      libbpf: Fix accessing BTF.ext core_relo header
      selftests/bpf: Fix runqslower cross-endian build

Viktor Malik (2):
      bpftool: Fix readlink usage in get_fd_type
      selftests/bpf: Fix string read in strncmp benchmark

Yafang Shao (2):
      bpf: Reject attaching fexit/fmod_ret to __noreturn functions
      selftests/bpf: Add selftest for attaching fexit to __noreturn functions

Yonghong Song (5):
      bpf: Sync uapi bpf.h header for the tooling infra
      bpf: Fix kmemleak warning for percpu hashmap
      docs/bpf: Document some special sdiv/smod operations
      bpf: Allow pre-ordering for bpf cgroup progs
      selftests/bpf: Add selftests allowing cgroup prog pre-ordering

 Documentation/bpf/bpf_iterators.rst                |    2 +-
 Documentation/bpf/btf.rst                          |   25 +-
 .../bpf/standardization/instruction-set.rst        |   20 +-
 arch/arm64/include/asm/insn.h                      |   12 +-
 arch/arm64/lib/insn.c                              |   29 +
 arch/arm64/net/bpf_jit.h                           |   20 +
 arch/arm64/net/bpf_jit_comp.c                      |   92 +-
 arch/s390/net/bpf_jit_comp.c                       |   14 +-
 arch/x86/net/Makefile                              |    2 +-
 arch/x86/net/bpf_jit_comp.c                        |  100 +-
 arch/x86/net/bpf_timed_may_goto.S                  |   55 +
 fs/bpf_fs_kfuncs.c                                 |  225 +++-
 include/linux/bpf-cgroup.h                         |    1 +
 include/linux/bpf.h                                |   31 +-
 include/linux/bpf_lsm.h                            |   18 +
 include/linux/bpf_verifier.h                       |   32 +-
 include/linux/btf.h                                |    3 +
 include/linux/filter.h                             |   20 +
 include/linux/lsm_hook_defs.h                      |    6 +-
 include/linux/mm.h                                 |    5 +
 include/linux/security.h                           |   12 +-
 include/uapi/linux/bpf.h                           |   10 +-
 include/uapi/linux/btf.h                           |    3 +-
 include/uapi/linux/xattr.h                         |    4 +
 kernel/bpf/arena.c                                 |    4 +-
 kernel/bpf/bpf_cgrp_storage.c                      |   11 +-
 kernel/bpf/bpf_iter.c                              |   13 +-
 kernel/bpf/bpf_lsm.c                               |    2 +
 kernel/bpf/bpf_struct_ops.c                        |  135 +-
 kernel/bpf/btf.c                                   |  127 +-
 kernel/bpf/cgroup.c                                |   33 +-
 kernel/bpf/core.c                                  |  117 +-
 kernel/bpf/cpumask.c                               |   53 +
 kernel/bpf/disasm.c                                |   16 +-
 kernel/bpf/hashtab.c                               |    9 +-
 kernel/bpf/helpers.c                               |  123 +-
 kernel/bpf/preload/bpf_preload_kern.c              |    1 +
 kernel/bpf/syscall.c                               |   48 +-
 kernel/bpf/verifier.c                              | 1376 +++++++++++++++-----
 kernel/trace/bpf_trace.c                           |   14 +-
 mm/memory.c                                        |  118 ++
 mm/nommu.c                                         |   79 ++
 net/core/filter.c                                  |    6 +-
 samples/bpf/Makefile                               |    2 +-
 scripts/Makefile.btf                               |    2 +-
 security/security.c                                |   15 +-
 security/selinux/hooks.c                           |    6 +-
 tools/bpf/bpftool/Makefile                         |    7 +-
 tools/bpf/bpftool/btf.c                            |   14 +-
 tools/bpf/bpftool/btf_dumper.c                     |    2 +-
 tools/bpf/bpftool/cgroup.c                         |    2 +-
 tools/bpf/bpftool/common.c                         |    7 +-
 tools/bpf/bpftool/gen.c                            |   12 +-
 tools/bpf/bpftool/jit_disasm.c                     |    3 +-
 tools/bpf/bpftool/link.c                           |   14 +-
 tools/bpf/bpftool/main.c                           |    8 +-
 tools/bpf/bpftool/map.c                            |   14 +-
 tools/bpf/bpftool/map_perf_ring.c                  |    6 +-
 tools/bpf/bpftool/net.c                            |    4 +-
 tools/bpf/bpftool/netlink_dumper.c                 |    6 +-
 tools/bpf/bpftool/prog.c                           |   13 +-
 tools/bpf/bpftool/tracelog.c                       |    2 +-
 tools/bpf/bpftool/xlated_dumper.c                  |    6 +-
 tools/bpf/runqslower/Makefile                      |    3 +-
 tools/include/uapi/linux/bpf.h                     |   10 +-
 tools/include/uapi/linux/btf.h                     |    3 +-
 tools/lib/bpf/bpf.c                                |    3 +-
 tools/lib/bpf/bpf.h                                |    3 +-
 tools/lib/bpf/btf.c                                |  105 +-
 tools/lib/bpf/btf.h                                |    3 +
 tools/lib/bpf/btf_dump.c                           |    5 +-
 tools/lib/bpf/libbpf.c                             |  237 ++--
 tools/lib/bpf/libbpf.h                             |   13 +
 tools/lib/bpf/libbpf.map                           |    3 +
 tools/lib/bpf/libbpf_internal.h                    |    1 +
 tools/lib/bpf/linker.c                             |    2 +-
 tools/lib/bpf/relo_core.c                          |   24 +-
 tools/lib/bpf/str_error.c                          |    2 +-
 tools/lib/bpf/str_error.h                          |    7 +-
 tools/lib/bpf/usdt.bpf.h                           |   32 +
 tools/testing/selftests/bpf/DENYLIST.aarch64       |    9 -
 tools/testing/selftests/bpf/Makefile               |   28 +-
 tools/testing/selftests/bpf/bpf_arena_spin_lock.h  |  533 ++++++++
 tools/testing/selftests/bpf/bpf_atomic.h           |  140 ++
 tools/testing/selftests/bpf/bpf_experimental.h     |   15 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h           |    5 +
 tools/testing/selftests/bpf/cap_helpers.c          |    8 +-
 tools/testing/selftests/bpf/cap_helpers.h          |    1 +
 tools/testing/selftests/bpf/network_helpers.c      |  111 +-
 tools/testing/selftests/bpf/network_helpers.h      |   21 +
 tools/testing/selftests/bpf/prog_tests/align.c     |   11 +-
 .../selftests/bpf/prog_tests/arena_atomics.c       |   66 +-
 .../selftests/bpf/prog_tests/arena_spin_lock.c     |  108 ++
 .../selftests/bpf/prog_tests/bloom_filter_map.c    |    5 +
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c  |   68 +
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c    |    9 +-
 tools/testing/selftests/bpf/prog_tests/btf.c       |   23 +-
 tools/testing/selftests/bpf/prog_tests/btf_dump.c  |  147 ++-
 .../selftests/bpf/prog_tests/cgroup_preorder.c     |  128 ++
 .../testing/selftests/bpf/prog_tests/cgroup_v1v2.c |   13 +-
 .../selftests/bpf/prog_tests/changes_pkt_data.c    |  107 --
 .../bpf/prog_tests/compute_live_registers.c        |    9 +
 .../testing/selftests/bpf/prog_tests/core_reloc.c  |    6 +-
 tools/testing/selftests/bpf/prog_tests/cpumask.c   |    5 +-
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |   21 +
 tools/testing/selftests/bpf/prog_tests/fd_array.c  |    4 +-
 .../selftests/bpf/prog_tests/fexit_noreturns.c     |    9 +
 tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c |  162 ++-
 .../testing/selftests/bpf/prog_tests/kernel_flag.c |   43 +
 .../selftests/bpf/prog_tests/lwt_ip_encap.c        |  540 ++++++++
 .../selftests/bpf/prog_tests/lwt_seg6local.c       |  176 +++
 .../selftests/bpf/prog_tests/netns_cookie.c        |   21 +-
 .../selftests/bpf/prog_tests/ns_current_pid_tgid.c |   47 +-
 tools/testing/selftests/bpf/prog_tests/prepare.c   |   99 ++
 .../selftests/bpf/prog_tests/pro_epilogue.c        |    2 +
 .../selftests/bpf/prog_tests/rcu_read_lock.c       |    3 +
 .../selftests/bpf/prog_tests/read_vsyscall.c       |    1 +
 .../selftests/bpf/prog_tests/setget_sockopt.c      |    2 +-
 tools/testing/selftests/bpf/prog_tests/spin_lock.c |    3 +
 .../selftests/bpf/prog_tests/summarization.c       |  144 ++
 tools/testing/selftests/bpf/prog_tests/tailcalls.c |    1 +
 tools/testing/selftests/bpf/prog_tests/tc_links.c  |   28 +-
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   |   40 +-
 .../bpf/prog_tests/test_struct_ops_kptr_return.c   |   16 +
 .../bpf/prog_tests/test_struct_ops_refcounted.c    |   14 +
 .../testing/selftests/bpf/prog_tests/test_tunnel.c |  633 +++++++--
 .../selftests/bpf/prog_tests/test_veristat.c       |  139 ++
 .../selftests/bpf/prog_tests/test_xdp_veth.c       |  638 +++++++--
 tools/testing/selftests/bpf/prog_tests/token.c     |   97 +-
 tools/testing/selftests/bpf/prog_tests/usdt.c      |   11 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |    8 +-
 tools/testing/selftests/bpf/prog_tests/xdp_vlan.c  |  175 +++
 tools/testing/selftests/bpf/progs/arena_atomics.c  |  121 +-
 .../testing/selftests/bpf/progs/arena_spin_lock.c  |   51 +
 tools/testing/selftests/bpf/progs/bpf_iter_tasks.c |  110 ++
 tools/testing/selftests/bpf/progs/bpf_misc.h       |   22 +
 .../testing/selftests/bpf/progs/bpf_tracing_net.h  |    4 +
 ...ore_reloc_arrays___err_bad_signed_arr_elem_sz.c |    3 +
 .../testing/selftests/bpf/progs/cgroup_preorder.c  |   41 +
 .../testing/selftests/bpf/progs/changes_pkt_data.c |   39 -
 .../selftests/bpf/progs/compute_live_registers.c   |  424 ++++++
 .../testing/selftests/bpf/progs/connect4_dropper.c |    4 +-
 .../testing/selftests/bpf/progs/core_reloc_types.h |   10 +
 tools/testing/selftests/bpf/progs/cpumask_common.h |    1 +
 .../testing/selftests/bpf/progs/cpumask_failure.c  |   38 +
 .../testing/selftests/bpf/progs/cpumask_success.c  |  120 +-
 tools/testing/selftests/bpf/progs/dynptr_success.c |  123 +-
 .../testing/selftests/bpf/progs/fexit_noreturns.c  |   15 +
 tools/testing/selftests/bpf/progs/irq.c            |   71 +-
 tools/testing/selftests/bpf/progs/iters.c          |  139 ++
 .../selftests/bpf/progs/netns_cookie_prog.c        |    9 +
 tools/testing/selftests/bpf/progs/preempt_lock.c   |   68 +-
 tools/testing/selftests/bpf/progs/prepare.c        |   28 +
 .../selftests/bpf/progs/priv_freplace_prog.c       |   13 +
 tools/testing/selftests/bpf/progs/priv_prog.c      |    6 +-
 .../selftests/bpf/progs/pro_epilogue_with_kfunc.c  |   88 ++
 tools/testing/selftests/bpf/progs/rcu_read_lock.c  |   61 +-
 tools/testing/selftests/bpf/progs/read_vsyscall.c  |   11 +-
 .../testing/selftests/bpf/progs/set_global_vars.c  |   47 +
 tools/testing/selftests/bpf/progs/strncmp_bench.c  |    5 +-
 .../selftests/bpf/progs/struct_ops_kptr_return.c   |   30 +
 .../struct_ops_kptr_return_fail__invalid_scalar.c  |   26 +
 .../struct_ops_kptr_return_fail__local_kptr.c      |   34 +
 .../struct_ops_kptr_return_fail__nonzero_offset.c  |   25 +
 .../struct_ops_kptr_return_fail__wrong_type.c      |   30 +
 .../selftests/bpf/progs/struct_ops_refcounted.c    |   31 +
 .../struct_ops_refcounted_fail__global_subprog.c   |   39 +
 .../progs/struct_ops_refcounted_fail__ref_leak.c   |   22 +
 .../progs/struct_ops_refcounted_fail__tail_call.c  |   36 +
 tools/testing/selftests/bpf/progs/summarization.c  |   78 ++
 ...kt_data_freplace.c => summarization_freplace.c} |   17 +-
 .../selftests/bpf/progs/test_cgroup1_hierarchy.c   |    4 +-
 .../selftests/bpf/progs/test_core_reloc_arrays.c   |    5 +
 tools/testing/selftests/bpf/progs/test_get_xattr.c |   28 +-
 .../testing/selftests/bpf/progs/test_kernel_flag.c |   28 +
 .../selftests/bpf/progs/test_kfunc_dynptr_param.c  |    6 +-
 .../testing/selftests/bpf/progs/test_lookup_key.c  |    2 +-
 .../selftests/bpf/progs/test_ptr_untrusted.c       |    2 +-
 .../bpf/progs/test_select_reuseport_kern.c         |    1 -
 .../selftests/bpf/progs/test_set_remove_xattr.c    |  133 ++
 .../selftests/bpf/progs/test_spin_lock_fail.c      |   69 +
 .../selftests/bpf/progs/test_task_under_cgroup.c   |    2 +-
 tools/testing/selftests/bpf/progs/test_usdt.c      |   14 +
 .../selftests/bpf/progs/test_verify_pkcs7_sig.c    |    2 +-
 tools/testing/selftests/bpf/progs/test_xdp_vlan.c  |   20 +-
 .../selftests/bpf/progs/verifier_bpf_fastcall.c    |   58 +-
 tools/testing/selftests/bpf/progs/verifier_gotol.c |    6 +-
 .../bpf/progs/verifier_iterating_callbacks.c       |    6 +-
 .../selftests/bpf/progs/verifier_load_acquire.c    |  218 ++++
 .../selftests/bpf/progs/verifier_may_goto_1.c      |   34 +-
 .../selftests/bpf/progs/verifier_precision.c       |   49 +
 .../selftests/bpf/progs/verifier_stack_ptr.c       |   52 +
 .../selftests/bpf/progs/verifier_store_release.c   |  286 ++++
 .../testing/selftests/bpf/progs/xdp_redirect_map.c |   88 ++
 .../selftests/bpf/progs/xdp_redirect_multi_kern.c  |   41 +-
 tools/testing/selftests/bpf/test_btf.h             |    6 +
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  108 ++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.h |    6 +
 tools/testing/selftests/bpf/test_loader.c          |   32 +-
 tools/testing/selftests/bpf/test_lwt_ip_encap.sh   |  476 -------
 tools/testing/selftests/bpf/test_lwt_seg6local.sh  |  156 ---
 tools/testing/selftests/bpf/test_maps.c            |    9 +-
 tools/testing/selftests/bpf/test_progs.c           |   72 +-
 tools/testing/selftests/bpf/test_progs.h           |    8 +
 tools/testing/selftests/bpf/test_tunnel.sh         |  645 ---------
 .../selftests/bpf/test_xdp_redirect_multi.sh       |  214 ---
 tools/testing/selftests/bpf/test_xdp_vlan.sh       |  233 ----
 .../selftests/bpf/test_xdp_vlan_mode_generic.sh    |    9 -
 .../selftests/bpf/test_xdp_vlan_mode_native.sh     |    9 -
 tools/testing/selftests/bpf/veristat.c             |  367 +++++-
 tools/testing/selftests/bpf/with_addr.sh           |   54 -
 tools/testing/selftests/bpf/with_tunnels.sh        |   36 -
 tools/testing/selftests/bpf/xdp_redirect_multi.c   |  226 ----
 213 files changed, 10643 insertions(+), 3497 deletions(-)
 create mode 100644 arch/x86/net/bpf_timed_may_goto.S
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_spin_lock.h
 create mode 100644 tools/testing/selftests/bpf/bpf_atomic.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_preorder.c
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/compute_live_registers.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kernel_flag.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prepare.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/summarization.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_veristat.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_vlan.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_bad_signed_arr_elem_sz.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_preorder.c
 delete mode 100644 tools/testing/selftests/bpf/progs/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/compute_live_registers.c
 create mode 100644 tools/testing/selftests/bpf/progs/fexit_noreturns.c
 create mode 100644 tools/testing/selftests/bpf/progs/prepare.c
 create mode 100644 tools/testing/selftests/bpf/progs/priv_freplace_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/pro_epilogue_with_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/set_global_vars.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__tail_call.c
 create mode 100644 tools/testing/selftests/bpf/progs/summarization.c
 rename tools/testing/selftests/bpf/progs/{changes_pkt_data_freplace.c => summarization_freplace.c} (57%)
 create mode 100644 tools/testing/selftests/bpf/progs/test_kernel_flag.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_remove_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_load_acquire.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_store_release.c
 delete mode 100755 tools/testing/selftests/bpf/test_lwt_ip_encap.sh
 delete mode 100755 tools/testing/selftests/bpf/test_lwt_seg6local.sh
 delete mode 100755 tools/testing/selftests/bpf/test_tunnel.sh
 delete mode 100755 tools/testing/selftests/bpf/test_xdp_redirect_multi.sh
 delete mode 100755 tools/testing/selftests/bpf/test_xdp_vlan.sh
 delete mode 100755 tools/testing/selftests/bpf/test_xdp_vlan_mode_generic.sh
 delete mode 100755 tools/testing/selftests/bpf/test_xdp_vlan_mode_native.sh
 delete mode 100755 tools/testing/selftests/bpf/with_addr.sh
 delete mode 100755 tools/testing/selftests/bpf/with_tunnels.sh
 delete mode 100644 tools/testing/selftests/bpf/xdp_redirect_multi.c

