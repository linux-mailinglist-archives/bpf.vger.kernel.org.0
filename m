Return-Path: <bpf+bounces-59183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FAAAC6E61
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 18:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C4A47A48D2
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 16:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB5328DEEB;
	Wed, 28 May 2025 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vw5b8A6N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9257428850E
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748450967; cv=none; b=VcJ4wUJIaQ5u/1+FWIsFzQ6n6uimdLwrjMJ4z1zbpWkGBN8IpXuCkWeoRfFrFC2wRXK1lX669Q4veDcfUK0E9ofJdaAIINssJrdR9to2zAsnHKfkAea+1BHcyPtSaPk7WIZpzUHauy1VW0AHtUPOZ63ZpKAvfaxDG2TTnd7fNgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748450967; c=relaxed/simple;
	bh=ur1Xmdwocr4ZqOgGje1zP+GF9Ip1eHHD+giv5y3OVQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HEzkAtuzxO/5KZk/skwJSOR9C0+/DSmYcBMS8+xiPt1/X9696VtvFYqGQm1DlU/a0iL8jy5cunXi/k9a/iQFMrQla68FtM3AngmMB8kZ+T6WEEgQQIlP5aBKiAHPxCDpaXfD++PKHOv61nugAfogSThAEtSufOFa0mWnwhloaEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vw5b8A6N; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c9563fafso3544598b3a.0
        for <bpf@vger.kernel.org>; Wed, 28 May 2025 09:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748450965; x=1749055765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NqlstiNOU0Xjjw+wrhGxlMMEFFWaOOpa6KMCtlg+d7k=;
        b=Vw5b8A6Ns/ubIRuhgjKHhZGmtSJzHycHdGevkgBtaV/JlvREG9nq6P32bAIx0jnYJB
         5k7V9gKXv5lDtURvxnVRciCfn7NA5s7ljExHLQYRXa/875NwD+wRu2VRf2Hxhcl+4AqG
         AOyt0avveRO1e2wtpn3GuHw0JrTOb9TbI1ri1Wsfuh0lArQpCos423/zTZSJtiNJWJ3u
         obI6RNU7MvVtJfvqo2OYkHoLu7xIC6zJVi9XkpmCriXxtYoG3aIQjvmx9y4SO/K0F/LY
         q5B4v235G6mptDT/exy5RlSSm8somO5Ji3H8Qupa8F+IPI6MRiY2j0IQWuEV9nGAjsdQ
         RfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748450965; x=1749055765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqlstiNOU0Xjjw+wrhGxlMMEFFWaOOpa6KMCtlg+d7k=;
        b=h0k0xXA79dZmoV85F1vakntBwrl6hb6uFAORHMvnkydlCiD55T+/s6IdieqcAf6Tc9
         AgfPKFtIgse0TQLG4cF8XXbZtYLjw/VMM/ybdIwYy3SSXNFlsmpVPB1EYzRO/kmILGdm
         WeH+VcKcHX2ED+FzG3pjWgGF7zPgqNYG5B78JG2RgoffFcSU2fpsM2AETlPtmDLR0qe1
         7kpLfvvEZ+XkMvoV+H8tOzDJ+uQTJwwBzAqrEw+niOz0T3VKTWLNsUcFGgW/qUptuz0B
         PIgN5F5T+ehrfzVt+tFoOR57DTKTux62C3jB6QN2g2RTzYD93AUB+t6rz8rSKkWaoyy/
         S3bw==
X-Gm-Message-State: AOJu0Yw8nWcnFGISnLSmLwMMPegfYrNVJQWsj4Nyay/8lkKNHZvL9Juu
	vz+Baz5mFP7FsUcaexG44LM47v2poJNeg0U+0SzAA5/K/F32FehECcw/
X-Gm-Gg: ASbGnct3MrSuk8QnVCphOYJaYe9kEw73Q9UcvNJHszi4Wy0gb/q64g5BYS0H3xkGPds
	CeQgxpFhv7QLHoCbUnZXArxWkBDF7DYJqH2fyJ8hUECQREgWa4c8s+LbtyHsAQraqXvHvWYZQwR
	OFHO958hs4HAfvGXCrHf1yLvkpC1NOUyMsAJgF/H0Dfjjw/IAwm++iJHjFgO7D7S4VLpS6IH3Bi
	25ZAIe2qjxwgqTP6TKne5nRZidI3rYUIJotEiO6GlmWcVD1Be/9bGijpJ2yiNB+5XsonbXDGdzv
	euio9sJTWbusHo4FOkSLzm3YgqvC8MZNB4zFwcwhqX1QHdY+WRgN7/iQ0H5baLFlM5AxcTwxXdt
	emKM67gO3Q1lRp+mW
X-Google-Smtp-Source: AGHT+IFOfHFsYS94uE0jwazRP3Rfq77CfSkhygDTxlfr05uvMsU9aBNwvW28SeSWK7+y2bTZVFDKLw==
X-Received: by 2002:a05:6a00:2d90:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-746b40bfa6bmr4769050b3a.18.1748450964519;
        Wed, 28 May 2025 09:49:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-746e343c671sm1484825b3a.140.2025.05.28.09.49.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 May 2025 09:49:23 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF changes for 6.16
Date: Wed, 28 May 2025 09:49:21 -0700
Message-Id: <20250528164921.57695-1-alexei.starovoitov@gmail.com>
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

The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e:

  Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.16

for you to fetch changes up to c5cebb241e27ed0c3f4c1d2ce63089398e0ed17e:

  bpf, arm64: Remove unused-but-set function and variable. (2025-05-27 20:16:57 -0700)

----------------------------------------------------------------
Single PR this time with BPF changes.
There should be no conflicts.

- Fix and improve BTF deduplication of identical BTF types
  (Alan Maguire and Andrii Nakryiko)

- Support up to 12 arguments in BPF trampoline on arm64
  (Xu Kuohai and Alexis Lothoré) 

- Support load-acquire and store-release instructions in BPF JIT
  on riscv64 (Andrea Parri)

- Fix uninitialized values in BPF_{CORE,PROBE}_READ macros
  (Anton Protopopov)

- Streamline allowed helpers across program types (Feng Yang)

- Support atomic update for hashtab of BPF maps (Hou Tao)

- Implement json output for BPF helpers (Ihor Solodrai)

- Several s390 JIT fixes (Ilya Leoshkevich)

- Various sockmap fixes (Jiayuan Chen)

- Support mmap of vmlinux BTF data (Lorenz Bauer)

- Support BPF rbtree traversal and list peeking (Martin KaFai Lau)

- Tests for sockmap/sockhash redirection (Michal Luczaj)

- Introduce kfuncs for memory reads into dynptrs (Mykyta Yatsenko)

- Add support for dma-buf iterators in BPF (T.J. Mercier)

- The verifier support for __bpf_trap() (Yonghong Song)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alan Maguire (4):
      libbpf: Add identical pointer detection to btf_dedup_is_equiv()
      selftests/bpf: Add btf dedup test covering module BTF dedup
      libbpf/btf: Fix string handling to support multi-split BTF
      selftests/bpf: Test multi-split BTF

Alexei Starovoitov (15):
      Merge branch 'bpf-fix-ktls-panic-with-sockmap-and-add-tests'
      Merge branch 'bpf-sockmap-fix-data-loss-and-panic-issues'
      Merge branch 'bpf-support-atomic-update-for-htab-of-maps'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf after rc3
      Merge branch 'selftests-bpf-fix-a-few-issues-in-arena_spin_lock'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf after rc4
      Merge branch 'bpf-support-bpf-rbtree-traversal-and-list-peeking'
      Merge branch 'bpf-riscv64-support-load-acquire-and-store-release-instructions'
      Merge branch 'fix-verifier-test-failures-in-verbose-mode'
      Merge branch 'introduce-kfuncs-for-memory-reads-into-dynptrs'
      Merge branch 's390-bpf-remove-the-orig_call-null-check'
      Merge branch 's390-bpf-use-kernel-s-expoline-thunks'
      Merge branch 'replace-config_dmabuf_sysfs_stats-with-bpf'
      Merge branch 'bpf-arm64-support-up-to-12-arguments'
      bpf, arm64: Remove unused-but-set function and variable.

Alexis Lothoré (eBPF Foundation) (1):
      selftests/bpf: enable many-args tests for arm64

Andrea Parri (2):
      bpf, riscv64: Introduce emit_load_*() and emit_store_*()
      bpf, riscv64: Support load-acquire and store-release instructions

Andrii Nakryiko (10):
      Merge branch 'likely-unlikely-for-bpf_helpers-and-a-small-comment-fix'
      Merge branch 'libbpf-introduce-line_info-and-func_info-getters'
      Merge branch 'libbpf-fix-event-name-too-long-error-and-add-tests'
      Merge branch 'bpf-allow-access-to-const-void-pointer-arguments-in-tracing-programs'
      libbpf: Improve BTF dedup handling of "identical" BTF types
      Merge branch 'bpf-allow-some-trace-helpers-for-all-prog-types'
      Merge branch 'bpf-retrieve-ref_ctr_offset-from-uprobe-perf-link'
      bpf, docs: document open-coded BPF iterators
      Merge branch 'libbpf-support-multi-split-btf'
      Merge branch 'allow-mmap-of-sys-kernel-btf-vmlinux'

Anton Protopopov (5):
      bpf: Fix a comment describing bpf_attr
      libbpf: Add likely/unlikely macros and use them in selftests
      libbpf: Use proper errno value in linker
      bpf: Fix uninitialized values in BPF_{CORE,PROBE}_READ
      libbpf: Use proper errno value in nlattr

Carlos Llamas (1):
      libbpf: Fix implicit memfd_create() for bionic

Chen Ni (1):
      selftests/bpf: Convert comma to semicolon

Di Shen (1):
      bpf: Revert "bpf: remove unnecessary rcu_read_{lock,unlock}() in multi-uprobe attach logic"

Feng Yang (6):
      libbpf: Fix event name too long error
      selftests/bpf: Add test for attaching uprobe with long event names
      selftests/bpf: Add test for attaching kprobe with long event names
      bpf: Streamline allowed helpers between tracing and base sets
      bpf: Allow some trace helpers for all prog types
      sched_ext: Remove bpf_scx_get_func_proto

Gregory Bell (2):
      selftests/bpf: test_verifier verbose causes erroneous failures
      selftests/bpf: test_verifier verbose log overflows

Hou Tao (7):
      bpf: Factor out htab_elem_value helper()
      bpf: Rename __htab_percpu_map_update_elem to htab_map_update_elem_in_place
      bpf: Support atomic update for htab of maps
      bpf: Add is_fd_htab() helper
      bpf: Don't allocate per-cpu extra_elems for fd htab
      selftests/bpf: Add test case for atomic update of fd htab
      bpf: Check rcu_read_lock_trace_held() in bpf_map_lookup_percpu_elem()

Ihor Solodrai (4):
      kbuild, bpf: Enable --btf_features=attributes
      libbpf: Verify section type in btf_find_elf_sections
      selftests/bpf: Remove sockmap_ktls disconnect_after_delete test
      scripts/bpf_doc.py: implement json output format

Ilya Leoshkevich (10):
      selftests/bpf: Set MACs during veth creation in tc_redirect
      selftests/bpf: Fix arena_spin_lock.c build dependency
      selftests/bpf: Fix arena_spin_lock on systems with less than 16 CPUs
      selftests/bpf: Fix endianness issue in __qspinlock declaration
      s390/bpf: Store backchain even for leaf progs
      bpf: Pass the same orig_call value to trampoline functions
      s390/bpf: Remove the orig_call NULL check
      s390: always declare expoline thunks
      s390/bpf: Add macros for calling external functions
      s390/bpf: Use kernel's expoline thunks

Jiapeng Chong (1):
      selftest/bpf/benchs: Remove duplicate sys/types.h header

Jiayuan Chen (10):
      bpf: fix ktls panic with sockmap
      selftests/bpf: add ktls selftest
      bpf, sockmap: Fix data lost during EAGAIN retries
      bpf, sockmap: fix duplicated data transmission
      bpf, sockmap: Fix panic when calling skb_linearize
      selftest/bpf/benchs: Add benchmark for sockmap usage
      ktls, sockmap: Fix missing uncharge operation
      selftests/bpf: Add test to cover sockmap with ktls
      bpf, sockmap: Avoid using sk_socket after free when sending
      bpftool: Add support for custom BTF path in prog load/loadall

Jiri Olsa (3):
      bpf: Add support to retrieve ref_ctr_offset for uprobe perf link
      selftests/bpf: Add link info test for ref_ctr_offset retrieval
      bpftool: Display ref_ctr_offset for uprobe link info

Jonathan Wiepert (1):
      Use thread-safe function pointer in libbpf_print

KaFai Wan (3):
      bpf: Allow access to const void pointer arguments in tracing programs
      selftests/bpf: Add test to access const void pointer argument in tracing program
      bpf: Avoid __bpf_prog_ret0_warn when jit fails

Khaled Elnaggar (1):
      docs: bpf: Fix bullet point formatting warning

Kumar Kartikeya Dwivedi (1):
      bpf: Add support for __prog argument suffix to pass in prog->aux

Kuniyuki Iwashima (1):
      selftests/bpf: Relax TCPOPT_WINDOW validation in test_tcp_custom_syncookie.c.

Lorenz Bauer (3):
      btf: Allow mmap of vmlinux btf
      selftests: bpf: Add a test for mmapable vmlinux BTF
      libbpf: Use mmap to parse vmlinux BTF from sysfs

Lorenzo Bianconi (2):
      bpf: Allow XDP dev-bound programs to perform XDP_REDIRECT into maps
      selftests/bpf: xdp_metadata: Check XDP_REDIRCT support for dev-bound progs

Luis Gerhorst (1):
      selftests/bpf: Fix caps for __xlated/jited_unpriv

Malaya Kumar Rout (1):
      selftests/bpf: Close the file descriptor to avoid resource leaks

Martin KaFai Lau (12):
      Merge branch 'bpf-allow-xdp_redirect-for-xdp-dev-bound-programs'
      bpf: Check KF_bpf_rbtree_add_impl for the "case KF_ARG_PTR_TO_RB_NODE"
      bpf: Simplify reg0 marking for the rbtree kfuncs that return a bpf_rb_node pointer
      bpf: Add bpf_rbtree_{root,left,right} kfunc
      bpf: Allow refcounted bpf_rb_node used in bpf_rbtree_{remove,left,right}
      selftests/bpf: Add tests for bpf_rbtree_{root,left,right}
      bpf: Simplify reg0 marking for the list kfuncs that return a bpf_list_node pointer
      bpf: Add bpf_list_{front,back} kfunc
      selftests/bpf: Add test for bpf_list_{front,back}
      bpftool: Fix cgroup command to only show cgroup bpf programs
      Merge branch 'ktls-sockmap-fix-missing-uncharge-operation-and-add-selfttest'
      Merge branch 'selftests-bpf-test-sockmap-sockhash-redirection'

Michal Luczaj (8):
      selftests/bpf: Support af_unix SOCK_DGRAM socket pair creation
      selftests/bpf: Add socket_kind_to_str() to socket_helpers
      selftests/bpf: Add u32()/u64() to sockmap_helpers
      selftests/bpf: Introduce verdict programs for sockmap_redir
      selftests/bpf: Add selftest for sockmap/hashmap redirection
      selftests/bpf: sockmap_listen cleanup: Drop af_vsock redir tests
      selftests/bpf: sockmap_listen cleanup: Drop af_unix redir tests
      selftests/bpf: sockmap_listen cleanup: Drop af_inet SOCK_DGRAM redir tests

Mykyta Yatsenko (11):
      selftests/bpf: Support struct/union presets in veristat
      libbpf: Add getters for BTF.ext func and line info
      selftests/bpf: Add BTF.ext line/func info getter tests
      selftests/bpf: Allow skipping docs compilation
      helpers: make few bpf helpers public
      bpf: Implement dynptr copy kfuncs
      selftests/bpf: introduce tests for dynptr copy kfuncs
      libbpf: Check bpf_map_skeleton link for NULL
      selftests/bpf: Remove unnecessary link dependencies
      selftests/bpf: Add SKIP_LLVM makefile variable
      bpf: Fix error return value in bpf_copy_from_user_dynptr

Paul Chaignon (3):
      bpf: Clarify role of BPF_F_RECOMPUTE_CSUM
      bpf: Clarify the meaning of BPF_F_PSEUDO_HDR
      bpf: WARN_ONCE on verifier bugs

Peilin Ye (6):
      bpf/verifier: Handle BPF_LOAD_ACQ instructions in insn_def_regno()
      bpf, riscv64: Skip redundant zext instruction after load-acquire
      selftests/bpf: Use CAN_USE_LOAD_ACQ_STORE_REL when appropriate
      selftests/bpf: Avoid passing out-of-range values to __retval()
      selftests/bpf: Verify zero-extension behavior in load-acquire tests
      selftests/bpf: Enable non-arena load-acquire/store-release selftests for riscv64

Saket Kumar Bhaskar (1):
      selftests/bpf: Fix bpf_nf selftest failure

Shung-Hsi Yu (1):
      bpf: Use proper type to calculate bpf_raw_tp_null_args.mask index

T.J. Mercier (6):
      selftests/bpf: Fix kmem_cache iterator draining
      dma-buf: Rename debugfs symbols
      bpf: Add dmabuf iterator
      bpf: Add open coded dmabuf iterator
      selftests/bpf: Add test for dmabuf_iter
      selftests/bpf: Add test for open coded dmabuf_iter

Tao Chen (4):
      bpf: Check link_create.flags parameter for multi_kprobe
      bpf: Check link_create.flags parameter for multi_uprobe
      libbpf: Remove sample_period init in perf_buffer
      bpf: Fix WARN() in get_bpf_raw_tp_regs

Thorsten Blum (2):
      bpf: Replace offsetof() with struct_size()
      bpf: Replace offsetof() with struct_size()

Viktor Malik (1):
      libbpf: Fix buffer overflow in bpf_object__init_prog

WangYuli (1):
      bpf, docs: Fix non-standard line break

Xu Kuohai (1):
      bpf, arm64: Support up to 12 function arguments

YiFei Zhu (1):
      bpftool: Fix regression of "bpftool cgroup tree" EINVAL on older kernels

Yonghong Song (5):
      bpf: Remove special_kfunc_set from verifier
      bpf: Warn with __bpf_trap() kfunc maybe due to uninitialized variable
      selftests/bpf: Add unit tests with __bpf_trap() kfunc
      bpf: Do not include stack ptr register in precision backtracking bookkeeping
      selftests/bpf: Add tests with stack ptr register in conditional jmp

 Documentation/bpf/bpf_iterators.rst                | 117 +++-
 Documentation/bpf/kfuncs.rst                       |  17 +
 arch/arm64/net/bpf_jit_comp.c                      | 242 +++++---
 arch/riscv/net/bpf_jit.h                           |  15 +
 arch/riscv/net/bpf_jit_comp64.c                    | 332 +++++++----
 arch/riscv/net/bpf_jit_core.c                      |   3 +-
 arch/s390/include/asm/nospec-branch.h              |   4 -
 arch/s390/net/bpf_jit_comp.c                       | 138 +++--
 drivers/dma-buf/dma-buf.c                          |  98 +++-
 include/asm-generic/vmlinux.lds.h                  |   3 +-
 include/linux/bpf-cgroup.h                         |   8 -
 include/linux/bpf.h                                |  20 +
 include/linux/bpf_verifier.h                       |  24 +-
 include/linux/dma-buf.h                            |   4 +-
 include/uapi/linux/bpf.h                           |  19 +-
 kernel/bpf/Makefile                                |   3 +
 kernel/bpf/bpf_struct_ops.c                        |   2 +-
 kernel/bpf/btf.c                                   |  45 +-
 kernel/bpf/cgroup.c                                |  32 --
 kernel/bpf/core.c                                  |  29 +-
 kernel/bpf/dmabuf_iter.c                           | 150 +++++
 kernel/bpf/hashtab.c                               | 148 +++--
 kernel/bpf/helpers.c                               | 133 ++++-
 kernel/bpf/syscall.c                               |  10 +-
 kernel/bpf/sysfs_btf.c                             |  32 ++
 kernel/bpf/verifier.c                              | 636 +++++++++++----------
 kernel/sched/ext.c                                 |  15 +-
 kernel/trace/bpf_trace.c                           | 321 +++++++----
 kernel/trace/trace_uprobe.c                        |   2 +-
 net/bpf/test_run.c                                 |   8 +-
 net/core/filter.c                                  |  14 -
 net/core/skmsg.c                                   |  56 +-
 net/tls/tls_sw.c                                   |  15 +-
 scripts/Makefile.btf                               |   2 +
 scripts/bpf_doc.py                                 | 119 +++-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst   |  10 +-
 tools/bpf/bpftool/bash-completion/bpftool          |   4 +-
 tools/bpf/bpftool/cgroup.c                         |  14 +-
 tools/bpf/bpftool/link.c                           |   3 +
 tools/bpf/bpftool/prog.c                           |  12 +-
 tools/include/uapi/linux/bpf.h                     |  19 +-
 tools/lib/bpf/bpf_core_read.h                      |   6 +
 tools/lib/bpf/bpf_helpers.h                        |   8 +
 tools/lib/bpf/btf.c                                | 226 ++++++--
 tools/lib/bpf/libbpf.c                             |  87 +--
 tools/lib/bpf/libbpf.h                             |   6 +
 tools/lib/bpf/libbpf.map                           |   4 +
 tools/lib/bpf/libbpf_internal.h                    |   9 +
 tools/lib/bpf/linker.c                             |   6 +-
 tools/lib/bpf/nlattr.c                             |  15 +-
 tools/testing/selftests/bpf/DENYLIST               |   1 +
 tools/testing/selftests/bpf/DENYLIST.aarch64       |   2 -
 tools/testing/selftests/bpf/Makefile               |  16 +-
 tools/testing/selftests/bpf/bench.c                |   4 +
 .../testing/selftests/bpf/benchs/bench_htab_mem.c  |   3 +-
 tools/testing/selftests/bpf/benchs/bench_sockmap.c | 598 +++++++++++++++++++
 tools/testing/selftests/bpf/bpf_experimental.h     |   5 +
 tools/testing/selftests/bpf/config                 |   3 +
 .../selftests/bpf/prog_tests/arena_spin_lock.c     |  14 +-
 .../selftests/bpf/prog_tests/attach_probe.c        |  84 +++
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c    |   6 +
 .../selftests/bpf/prog_tests/btf_dedup_split.c     | 101 ++++
 tools/testing/selftests/bpf/prog_tests/btf_split.c |  58 +-
 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c |  81 +++
 .../testing/selftests/bpf/prog_tests/dmabuf_iter.c | 285 +++++++++
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |  13 +
 .../selftests/bpf/prog_tests/fd_htab_lookup.c      | 192 +++++++
 .../selftests/bpf/prog_tests/fill_link_info.c      |  18 +-
 .../selftests/bpf/prog_tests/kmem_cache_iter.c     |   2 +-
 .../testing/selftests/bpf/prog_tests/linked_list.c |   6 +
 tools/testing/selftests/bpf/prog_tests/rbtree.c    |   6 +
 tools/testing/selftests/bpf/prog_tests/sk_assign.c |   4 +-
 .../selftests/bpf/prog_tests/socket_helpers.h      |  84 ++-
 .../selftests/bpf/prog_tests/sockmap_helpers.h     |  25 +-
 .../selftests/bpf/prog_tests/sockmap_ktls.c        | 297 ++++++++--
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 457 ---------------
 .../selftests/bpf/prog_tests/sockmap_redir.c       | 465 +++++++++++++++
 .../testing/selftests/bpf/prog_tests/tc_redirect.c |  11 +-
 .../selftests/bpf/prog_tests/test_btf_ext.c        |  64 +++
 .../selftests/bpf/prog_tests/test_veristat.c       |   5 +
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/prog_tests/xdp_metadata.c        |  22 +-
 .../selftests/bpf/progs/bench_sockmap_prog.c       |  65 +++
 .../bpf/{ => progs}/bpf_arena_spin_lock.h          |  15 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h       |   5 +-
 tools/testing/selftests/bpf/progs/dmabuf_iter.c    | 101 ++++
 tools/testing/selftests/bpf/progs/dynptr_success.c | 230 ++++++++
 tools/testing/selftests/bpf/progs/fd_htab_lookup.c |  25 +
 tools/testing/selftests/bpf/progs/iters.c          |   2 -
 .../testing/selftests/bpf/progs/linked_list_peek.c | 113 ++++
 tools/testing/selftests/bpf/progs/prepare.c        |   1 -
 tools/testing/selftests/bpf/progs/rbtree_fail.c    |  29 +-
 tools/testing/selftests/bpf/progs/rbtree_search.c  | 206 +++++++
 .../testing/selftests/bpf/progs/set_global_vars.c  |  41 ++
 tools/testing/selftests/bpf/progs/test_btf_ext.c   |  22 +
 .../selftests/bpf/progs/test_sockmap_ktls.c        |  36 ++
 .../selftests/bpf/progs/test_sockmap_redir.c       |  68 +++
 .../bpf/progs/test_tcp_custom_syncookie.c          |   4 +-
 .../selftests/bpf/progs/verifier_bpf_trap.c        |  71 +++
 .../selftests/bpf/progs/verifier_btf_ctx_access.c  |  12 +
 .../selftests/bpf/progs/verifier_load_acquire.c    |  48 +-
 .../selftests/bpf/progs/verifier_precision.c       |  58 +-
 .../selftests/bpf/progs/verifier_store_release.c   |  39 +-
 tools/testing/selftests/bpf/progs/xdp_metadata.c   |  13 +
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |   8 +-
 tools/testing/selftests/bpf/test_loader.c          |  14 +-
 tools/testing/selftests/bpf/test_verifier.c        |   8 +-
 tools/testing/selftests/bpf/veristat.c             | 101 +++-
 108 files changed, 5801 insertions(+), 1713 deletions(-)
 create mode 100644 kernel/bpf/dmabuf_iter.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_sockmap.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_htab_lookup.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/bench_sockmap_prog.c
 rename tools/testing/selftests/bpf/{ => progs}/bpf_arena_spin_lock.h (98%)
 create mode 100644 tools/testing/selftests/bpf/progs/dmabuf_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/fd_htab_lookup.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list_peek.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_search.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_btf_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_redir.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bpf_trap.c

