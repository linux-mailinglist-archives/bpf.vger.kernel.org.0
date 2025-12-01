Return-Path: <bpf+bounces-75825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AACC98B3F
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 19:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2503A40B8
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 18:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0870B337B93;
	Mon,  1 Dec 2025 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4+IpOcz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F492F60D5
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764613355; cv=none; b=EgbdbtYWL5Acf3HBCgknNGVvCci6x/MDIPn9BdPbKU6J4WnP2eI7tJ9UG7/vBLRHxhoW6Cj8fAFOyy2gCMTzaz90rQRfliF8XFalc3OTnu4IRwTQC18dWLcKgxjk+Of4JS0TYCGL9lewiIpRUWGaM9fvPHzKr4rMsaIFN61KpFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764613355; c=relaxed/simple;
	bh=f6vDi+yeVaC2RG5jkzGgVh2iXonrJg7cm+yrGe65Y/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OvFBcCApjDOnmEE1zWEk6sn7Ev31gysL85S0vhATkennNSYJQbmuXw/j0tB7q5NMErAePY2gHM2y8PE63XRV6tJwMphWRzs4d7Bs2CKguolJpfs0Kd30DeVS1SnsZcp6p0+ilcFMwPsmYUUIL5+bRW8bXTTNRWPe8hAVu0uwVsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4+IpOcz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso5184881b3a.1
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 10:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764613352; x=1765218152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ueCZWROex1K05yjQ2KmDJlpMznlhqxB9SJ+JLGyN5+g=;
        b=h4+IpOczw4API/F0eP33o12AV50NbWV1ZyWgIUgKGlhfiPDT54tvzomtZavl0qLhE/
         POourxMooyIbc4IsAM8X2S7KBlp2WJ5aovALvlq+Sczkl89p2Z5DJIriLu4BZ2imlbbW
         4IHAUguq9GrJOjcFOSoZZjr5lkNEbe+ahSJ25rTUoA+NA4M6aXQ0tbPCUsUl737lia2M
         GGF8kPxwg5Bs843oJrmm79+NotvWuleip0mrdpbhCqtwnfU3kDedFpTJ3txxhedCyhTk
         y0kfHFJg7gu3nZ9/plxL49slvacasmflZ6mo+nGhD2zW1cG4RuejQd5X26/MFXeyqzpT
         F/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764613352; x=1765218152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueCZWROex1K05yjQ2KmDJlpMznlhqxB9SJ+JLGyN5+g=;
        b=cR7bRRQp8sdbXF/8r9w/ULyshkvaB/6PLSZFZ/zA2IKXQHgMZhBVmYA1iC0l+Dtfc0
         /4ulTbk1VrIwrCF/QvADFWzQgHtukSDcOq47F+Q3otRnnCjnPrlXza+pbg53aUcD+tyV
         9hZXOAv5PolSGcygWX8wxTPhaPzTGA35MAyc/3S6fR6aRAPHnpFtCVo3uj+UVh3e+Gnn
         EcRKL8W/z5YwrmMNBJ9PvzKrOXgEbXwX0oBzjNQJ7KE9QlnkpjdTjh9iSxHkvmt7MKB6
         MHdzuZVyaHfqb/eP+LGLMGc09miWx/zpRiOruQBO1FoUJ+0lmCjDVtHPK8W9XICFUDau
         5uIw==
X-Gm-Message-State: AOJu0YxMyoIqRYWC1O8RJBs+ZYu0Zp+mlRVvO4Xzim122WOhzr68+7L3
	qx4Ms9Qc08iINtFM796mDQEMcFHo5YcCzcN7ZXiQKodcTurq9pm1+xJI
X-Gm-Gg: ASbGncvQG/cNr/T0yQ6kPKvyuja2/+zcTHdviH1671tXGFkKQ6uYWptCbBX72/ipzi0
	WIvI19as9L+OuB1WjIkTq8R3DRTxAjAVCh1ZLorm0AIOW8RMnSCdXcCxUQcFMoaDiJ7jFWzQ3xS
	+7Pp+OOE3YFX9ASZBHNSK1VD8vhlJtlYf3DUhsoeRAhtJOA0EICFHiwCLLw2XVSuPoCuZ10aB44
	pvziH7ZYK/PuJzF0U+6TUJ6yvsB5lQfEKQ1OCm/Yp/wud50IN/4IWFZsrx3orMPHbmgcukFSNkE
	YjAGIONO2QjFukeF0uFSgLFZSJ4dTbTbwFXM7iTnwdEc4OjJTrN+ssJzvTdbDJwLOb+Pb6YyU6v
	I801zq+iTbcacvWRGnrJeGuoAXgtemnPko5CkUuJ8h936p+U6QwfFuqicF7n9W+AFlGhXqqI6YZ
	j07Nbm+luLpKKNbvXAiC8mwpK3y6deCkyWIBqV8ocj2c9BQ5yCr+oDJNg=
X-Google-Smtp-Source: AGHT+IFB9ACLBVLiTMTRVnJV4Oejua7rGvEPa6KM8EtDCH3R/GghUOWCNqLbL7E4Nd3YzhNlOWSzrA==
X-Received: by 2002:a05:7022:7f0b:b0:11b:ca88:c4f5 with SMTP id a92af1059eb24-11c9d860f40mr16488837c88.35.1764613352154;
        Mon, 01 Dec 2025 10:22:32 -0800 (PST)
Received: from ast-mac.corp.tfbnw.net ([2620:10d:c090:500::6:e284])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm73714920c88.1.2025.12.01.10.22.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Dec 2025 10:22:31 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	rostedt@goodmis.org
Subject: [GIT PULL] BPF changes for 6.19
Date: Mon,  1 Dec 2025 10:22:28 -0800
Message-ID: <20251201182229.95029-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 7a0892d2836e12cc61b6823f888629a3eb64e268:

  Merge tag 'pci-v6.18-fixes-5' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci (2025-11-14 15:45:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.19

for you to fetch changes up to ff34657aa72a4dab9c2fd38e1b31a506951f4b1c:

  bpf: optimize bpf_map_update_elem() for map-in-map types (2025-11-29 09:48:41 -0800)

----------------------------------------------------------------
There is a trivial conflict with ftrace tree in kernel/trace/Kconfig:
https://lore.kernel.org/all/20251201093343.63ef2596@canb.auug.org.au/

- Convert selftests/bpf/test_tc_edt and test_tc_tunnel from .sh to
  test_progs runner (Alexis Lothoré)

- Convert selftests/bpf/test_xsk to test_progs runner (Bastien Curutchet)

- Replace bpf memory allocator with kmalloc_nolock() in bpf_local_storage
  (Amery Hung), and in bpf streams and range tree (Puranjay Mohan)

- Introduce support for indirect jumps in BPF verifier and x86 JIT
  (Anton Protopopov) and arm64 JIT (Puranjay Mohan)

- Remove runqslower bpf tool (Hoyeon Lee)

- Fix corner cases in the verifier to close several syzbot reports
  (Eduard Zingerman, KaFai Wan)

- Several improvements in deadlock detection in rqspinlock (Kumar Kartikeya Dwivedi)

- Implement "jmp" mode for BPF trampoline and corresponding DYNAMIC_FTRACE_WITH_JMP.
  It improves "fexit" program type performance from 80 M/s to 136 M/s.
  With Steven's Ack. (Menglong Dong)

- Add ability to test non-linear skbs in BPF_PROG_TEST_RUN (Paul Chaignon)

- Do not let BPF_PROG_TEST_RUN emit invalid GSO types to stack (Daniel Borkmann)

- Generalize buildid reader into bpf_dynptr (Mykyta Yatsenko)

- Optimize bpf_map_update_elem() for map-in-map types (Ritesh Oedayrajsingh Varma)

- Introduce overwrite mode for BPF ring buffer (Xu Kuohai)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alan Maguire (4):
      libbpf: Fix parsing of multi-split BTF
      selftests/bpf: Test parsing of (multi-)split BTF
      bpftool: Allow bpftool to build with openssl < 3
      selftests/bpf: Allow selftests to build with older xxd

Alex Tran (1):
      docs: bpf: map_array: Specify BPF_MAP_TYPE_PERCPU_ARRAY value size limit

Alexei Starovoitov (24):
      Merge branch 'fix-sleepable-context-tracking-for-async-callbacks'
      Merge branch 'add-kfuncs-bpf_strcasestr-and-bpf_strncasestr'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf before 6.18-rc1
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf at 6.18-rc2
      Merge branch 'bpf-mm-related-minor-changes'
      Merge branch 'bpf-introduce-file-dynptr'
      Merge branch 'misc-rqspinlock-updates'
      Merge branch 'selftests-bpf-integrate-test_xsk-c-to-test_progs-framework'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf after 6.18-rc4
      Merge branch 'bpf-skip-bounds-adjustment-for-conditional-jumps-on-same-scalar-register'
      Merge branch 'bpf-indirect-jumps'
      Merge branch 'percpu_hash-maps'
      selftests/bpf: Convert glob_match() to bpf arena
      selftests/bpf: Fix failure paths in send_signal test
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf after 6.18-rc5+
      Merge branch 'replace-bpf-memory-allocator-with-kmalloc_nolock-in-local-storage'
      Merge branch 'bpf-arm64-indirect-jumps'
      Merge branch 'bpf-nested-rcu-critical-sections'
      Merge branch 'bpf-trampoline-support-jmp-mode'
      Merge branch 'ease-bpf-signing-build-requirements'
      Merge branch 'general-enhancements-to-rqspinlock-stress-test'
      Merge branch 'a-pair-of-follow-ups-for-indirect-jumps'
      Merge branch 'limited-queueing-in-nmi-for-rqspinlock'
      Merge branch 'selftests-bpf-convert-test_tc_edt-sh-into-test_progs'

Alexis Lothoré (eBPF Foundation) (12):
      selftests/bpf: Add tc helpers
      selftests/bpf: Make test_tc_tunnel.bpf.c compatible with big endian platforms
      selftests/bpf: Integrate test_tc_tunnel.sh tests into test_progs
      selftests/bpf: Remove test_tc_tunnel.sh
      selftests/bpf: Skip tc_tunnel subtest if its setup fails
      selftests/bpf: Add checks in tc_tunnel when entering net namespaces
      selftests/bpf: Systematically add SO_REUSEADDR in start_server_addr
      selftests/bpf: Use start_server_str rather than start_reuseport_server in tc_tunnel
      selftests/bpf: rename test_tc_edt.bpf.c section to expose program type
      selftests/bpf: integrate test_tc_edt into test_progs
      selftests/bpf: remove test_tc_edt.sh
      selftests/bpf: do not hardcode target rate in test_tc_edt BPF program

Altgelt, Max (Nextron) (1):
      bpf: don't skip other information if xlated_prog_insns is skipped

Amery Hung (6):
      bpf: Always charge/uncharge memory when allocating/unlinking storage elements
      bpf: Remove smap argument from bpf_selem_free()
      bpf: Save memory alloction info in bpf_local_storage
      bpf: Replace bpf memory allocator with kmalloc_nolock() in local storage
      bpf: Disable file_alloc_security hook
      selftests/bpf: Remove usage of lsm/file_alloc_security in selftest

Andrii Nakryiko (3):
      bpf: Consistently use bpf_rcu_lock_held() everywhere
      Merge branch 'multi-split-btf-fixes-and-test'
      Merge branch 'libbpf-fix-btf-dedup-to-support-recursive-typedef'

Anton Protopopov (21):
      bpf: fix the return value of push_stack
      bpf: save the start of functions in bpf_prog_aux
      bpf: generalize and export map_get_next_key for arrays
      bpf: make bpf_insn_successors to return a pointer
      libbpf: fix formatting of bpf_object__append_subprog_code
      bpf, x86: add new map type: instructions array
      bpftool: Recognize insn_array map type
      libbpf: Recognize insn_array map type
      selftests/bpf: add selftests for new insn_array map
      bpf: support instructions arrays with constants blinding
      selftests/bpf: test instructions arrays with blinding
      bpf, x86: allow indirect jumps to r8...r15
      bpf, x86: add support for indirect jumps
      bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
      libbpf: support llvm-generated indirect jumps
      selftests/bpf: add new verifier_gotox test
      selftests/bpf: add C-level selftests for indirect jumps
      bpf: Add a check to make static analysers happy
      bpf: cleanup aux->used_maps after jit
      bpf: force BPF_F_RDONLY_PROG on insn array creation
      bpf: check for insn arrays in check_ptr_alignment

Arnaud Lecomte (2):
      bpf: Refactor stack map trace depth calculation into helper function
      bpf: Fix stackmap overflow check in __bpf_get_stackid()

Bastien Curutchet (eBPF Foundation) (15):
      selftests/bpf: test_xsk: Split xskxceiver
      selftests/bpf: test_xsk: Initialize bitmap before use
      selftests/bpf: test_xsk: Fix __testapp_validate_traffic()'s return value
      selftests/bpf: test_xsk: fix memory leak in testapp_stats_rx_dropped()
      selftests/bpf: test_xsk: fix memory leak in testapp_xdp_shared_umem()
      selftests/bpf: test_xsk: Wrap test clean-up in functions
      selftests/bpf: test_xsk: Release resources when swap fails
      selftests/bpf: test_xsk: Add return value to init_iface()
      selftests/bpf: test_xsk: Don't exit immediately when xsk_attach fails
      selftests/bpf: test_xsk: Don't exit immediately when gettimeofday fails
      selftests/bpf: test_xsk: Don't exit immediately when workers fail
      selftests/bpf: test_xsk: Don't exit immediately if validate_traffic fails
      selftests/bpf: test_xsk: Don't exit immediately on allocation failures
      selftests/bpf: test_xsk: Isolate non-CI tests
      selftests/bpf: test_xsk: Integrate test_xsk.c to test_progs framework

Chu Guangqing (1):
      samples/bpf: Fix spelling typos in samples/bpf

Daniel Borkmann (1):
      bpf: Do not let BPF test infra emit invalid GSO types to stack

Donald Hunter (1):
      docs/bpf: Add missing BPF k/uprobe program types to docs

Eduard Zingerman (3):
      bpf: Add missing checks to avoid verbose verifier log
      bpf: correct stack liveness for tail calls
      bpf: test the correct stack liveness of tail calls

Edward Adam Davis (1):
      bpf: Fix exclusive map memory leak

Fushuai Wang (1):
      bpf: Use rcu_read_lock_dont_migrate in bpf_sk_storage.c

Hoyeon Lee (5):
      selftests/bpf: Move common TCP helpers into bpf_tracing_net.h
      selftests/bpf: Replace TCP CC string comparisons with bpf_strncmp
      selftests/bpf: Use sockaddr_storage directly in cls_redirect test
      selftests/bpf: Use sockaddr_storage instead of sa46 in select_reuseport test
      bpf: Remove runqslower tool

Jianyun Gao (5):
      libbpf: Optimize the redundant code in the bpf_object__init_user_btf_maps() function.
      libbpf: Fix the incorrect reference to the memlock_rlim variable in the comment.
      libbpf: Complete the missing @param and @return tags in btf.h
      libbpf: Update the comment to remove the reference to the deprecated interface bpf_program__load().
      libbpf: Fix some incorrect @param descriptions in the comment of libbpf.h

KaFai Wan (2):
      bpf: Skip bounds adjustment for conditional jumps on same scalar register
      selftests/bpf: Add test for conditional jumps on same scalar register

Kumar Kartikeya Dwivedi (15):
      bpf: Fix sleepable context for async callbacks
      bpf: Refactor storage_get_func_atomic to generic non_sleepable flag
      selftests/bpf: Add tests for async cb context
      rqspinlock: Disable queue destruction for deadlocks
      selftests/bpf: Add ABBCCA case for rqspinlock stress test
      bpf: Adjust return value for queue destruction in rqspinlock
      selftests/bpf: Relax CPU requirements for rqspinlock stress test
      selftests/bpf: Add lock wait time stats to rqspinlock stress test
      selftests/bpf: Make CS length configurable for rqspinlock stress test
      rqspinlock: Enclose lock/unlock within lock entry acquisitions
      rqspinlock: Perform AA checks immediately
      rqspinlock: Use trylock fallback when per-CPU rqnode is busy
      rqspinlock: Disable spinning for trylock fallback
      rqspinlock: Precede non-head waiter queueing with AA check
      selftests/bpf: Add success stats to rqspinlock stress test

Leon Hwang (3):
      bpf: Free special fields when update [lru_,]percpu_hash maps
      selftests/bpf: Add test to verify freeing the special fields in pcpu maps
      bpf: Introduce internal bpf_map_check_op_flags helper function

Martin KaFai Lau (6):
      Merge branch 'support-non-linear-skbs-for-bpf_prog_test_run'
      Merge branch 'selftests-bpf-convert-test_tc_tunnel-sh-to-test_progs'
      Merge branch 'selftests-bpf-enfoce-so_reuseaddr-in-basic-test-servers'
      bpf: Check skb->transport_header is set in bpf_skb_check_mtu
      selftests/bpf: Test bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set
      Merge branch 'selftests-bpf-networking-test-cleanups'

Martin Teichmann (2):
      bpf: properly verify tail call behavior
      bpf: test the proper verification of tail calls

Matt Bobrowski (4):
      selftests/bpf: retry bpf_map_update_elem() when E2BIG is returned
      selftests/bpf: Use ASSERT_STRNEQ to factor in long slab cache names
      selftests/bpf: skip test_perf_branches_hw() on unsupported platforms
      selftests/bpf: Improve reliability of test_perf_branches_no_hw()

Menglong Dong (9):
      bpf: Handle return value of ftrace_set_filter_ip in register_fentry
      ftrace: Introduce FTRACE_OPS_FL_JMP
      x86/ftrace: Implement DYNAMIC_FTRACE_WITH_JMP
      bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
      bpf,x86: adjust the "jmp" mode for bpf trampoline
      bpf: specify the old and new poke_type for bpf_arch_text_poke
      bpf: implement "jmp" mode for trampoline
      selftests/bpf: Call bpf_get_numa_node_id() in trigger_count()
      bpf: make kprobe_multi_link_prog_run always_inline

Mykyta Yatsenko (15):
      bpf: Fix handling maps with no BTF and non-constant offsets for the bpf_wq
      selftests/bpf: Add more bpf_wq tests
      bpf: Extract internal structs validation logic into helpers
      selftests/bpf: remove unnecessary kfunc prototypes
      bpf: widen dynptr size/offset to 64 bit
      lib: move freader into buildid.h
      lib/freader: support reading more than 2 folios
      bpf: verifier: centralize const dynptr check in unmark_stack_slots_dynptr()
      bpf: add plumbing for file-backed dynptr
      bpf: add kfuncs and helpers support for file dynptrs
      bpf: verifier: refactor kfunc specialization
      bpf: dispatch to sleepable file dynptr
      selftests/bpf: add file dynptr tests
      selftests/bpf: Fix intermittent failures in file_reader test
      selftests/bpf: Align kfuncs renamed in bpf tree

Nirbhay Sharma (1):
      bpf: Document cfi_stubs and owner fields in struct bpf_struct_ops

Paul Chaignon (5):
      bpf: Refactor cleanup of bpf_prog_test_run_skb
      bpf: Reorder bpf_prog_test_run_skb initialization
      bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN
      selftests/bpf: Support non-linear flag in test loader
      selftests/bpf: Test direct packet access on non-linear skbs

Paul Houssel (2):
      libbpf: Fix BTF dedup to support recursive typedef definitions
      selftests/bpf: Add BTF dedup tests for recursive typedef definitions

Pu Lehui (1):
      bpf: Fix invalid prog->stats access when update_effective_progs fails

Puranjay Mohan (9):
      selftests/bpf: Fix list_del() in arena list
      bpf: Use kmalloc_nolock() in bpf streams
      bpf: Use kmalloc_nolock() in range tree
      bpf: verifier: Move desc->imm setup to sort_kfunc_descs_by_imm_off()
      bpf: arm64: Add support for instructions array
      bpf: arm64: Add support for indirect jumps
      selftests: bpf: Enable gotox tests from arm64
      bpf: support nested rcu critical sections
      selftests: bpf: Add tests for unbalanced rcu_read_lock

Ritesh Oedayrajsingh Varma (1):
      bpf: optimize bpf_map_update_elem() for map-in-map types

Rong Tao (2):
      bpf: add bpf_strcasestr,bpf_strncasestr kfuncs
      selftests/bpf: Test bpf_strcasestr,bpf_strncasestr kfuncs

Sahil Chandna (1):
      bpf: Prevent nesting overflow in bpf_try_get_buffers

Saket Kumar Bhaskar (1):
      selftests/bpf: Fix htab_update/reenter_update selftest failure

Shardul Bankar (1):
      bpf: Clarify get_outer_instance() handling in propagate_to_outer_instance()

Siddharth Chintamaneni (1):
      bpf: Cleanup unused func args in rqspinlock implementation

Tiezhu Yang (1):
      selftests/bpf: Silence unused-but-set build warnings

Xing Guo (1):
      selftests/bpf: Update test_tag to use sha256

Xu Kuohai (3):
      bpf: Add overwrite mode for BPF ring buffer
      selftests/bpf: Add overwrite mode test for BPF ring buffer
      selftests/bpf/benchs: Add overwrite mode benchmark for BPF ring buffer

Yafang Shao (2):
      bpf: mark mm->owner as __safe_rcu_or_null
      bpf: mark vma->{vm_mm,vm_file} as __safe_trusted_or_null

Yonghong Song (1):
      selftests/bpf: Fix selftest verif_scale_strobemeta failure with llvm22

Zhang Chujun (1):
      bpftool: Fix missing closing parethesis for BTF_KIND_UNKN

 Documentation/bpf/libbpf/program_types.rst         |   18 +
 Documentation/bpf/map_array.rst                    |    5 +-
 MAINTAINERS                                        |    1 +
 arch/arm64/net/bpf_jit_comp.c                      |   25 +-
 arch/loongarch/net/bpf_jit.c                       |    9 +-
 arch/powerpc/net/bpf_jit_comp.c                    |   10 +-
 arch/riscv/net/bpf_jit_comp64.c                    |   11 +-
 arch/s390/net/bpf_jit_comp.c                       |    7 +-
 arch/x86/Kconfig                                   |    1 +
 arch/x86/kernel/ftrace.c                           |    7 +-
 arch/x86/kernel/ftrace_64.S                        |   12 +-
 arch/x86/net/bpf_jit_comp.c                        |   97 +-
 include/asm-generic/rqspinlock.h                   |   60 +-
 include/linux/bpf.h                                |  102 +-
 include/linux/bpf_local_storage.h                  |   13 +-
 include/linux/bpf_types.h                          |    1 +
 include/linux/bpf_verifier.h                       |   30 +-
 include/linux/buildid.h                            |   25 +
 include/linux/filter.h                             |   12 +-
 include/linux/ftrace.h                             |   33 +
 include/uapi/linux/bpf.h                           |   33 +-
 kernel/bpf/Makefile                                |    2 +-
 kernel/bpf/arraymap.c                              |   38 +-
 kernel/bpf/bpf_insn_array.c                        |  304 +++
 kernel/bpf/bpf_local_storage.c                     |  235 +-
 kernel/bpf/bpf_lsm.c                               |    1 +
 kernel/bpf/core.c                                  |   26 +-
 kernel/bpf/disasm.c                                |    3 +
 kernel/bpf/hashtab.c                               |   67 +-
 kernel/bpf/helpers.c                               |  296 ++-
 kernel/bpf/liveness.c                              |   42 +-
 kernel/bpf/log.c                                   |    3 +
 kernel/bpf/range_tree.c                            |   21 +-
 kernel/bpf/ringbuf.c                               |  114 +-
 kernel/bpf/rqspinlock.c                            |   90 +-
 kernel/bpf/stackmap.c                              |   62 +-
 kernel/bpf/stream.c                                |  159 +-
 kernel/bpf/syscall.c                               |   86 +-
 kernel/bpf/trampoline.c                            |   83 +-
 kernel/bpf/verifier.c                              |  983 +++++--
 kernel/trace/Kconfig                               |   12 +
 kernel/trace/bpf_trace.c                           |   48 +-
 kernel/trace/ftrace.c                              |   17 +-
 lib/buildid.c                                      |   56 +-
 net/bpf/test_run.c                                 |  148 +-
 net/core/bpf_sk_storage.c                          |   16 +-
 net/core/filter.c                                  |   16 +-
 samples/bpf/do_hbm_test.sh                         |    2 +-
 samples/bpf/hbm.c                                  |    4 +-
 samples/bpf/tcp_cong_kern.c                        |    2 +-
 samples/bpf/tracex1.bpf.c                          |    2 +-
 tools/bpf/Makefile                                 |   13 +-
 tools/bpf/bpftool/Documentation/bpftool-map.rst    |    3 +-
 tools/bpf/bpftool/btf_dumper.c                     |    2 +-
 tools/bpf/bpftool/map.c                            |    3 +-
 tools/bpf/bpftool/sign.c                           |    6 +
 tools/bpf/runqslower/.gitignore                    |    2 -
 tools/bpf/runqslower/Makefile                      |   91 -
 tools/bpf/runqslower/runqslower.bpf.c              |  106 -
 tools/bpf/runqslower/runqslower.c                  |  171 --
 tools/bpf/runqslower/runqslower.h                  |   13 -
 tools/include/uapi/linux/bpf.h                     |   33 +-
 tools/lib/bpf/bpf.c                                |    2 +-
 tools/lib/bpf/btf.c                                |   75 +-
 tools/lib/bpf/btf.h                                |    8 +
 tools/lib/bpf/libbpf.c                             |  296 ++-
 tools/lib/bpf/libbpf.h                             |   27 +-
 tools/lib/bpf/libbpf_internal.h                    |    2 +
 tools/lib/bpf/libbpf_probes.c                      |    4 +
 tools/lib/bpf/linker.c                             |    3 +
 tools/testing/selftests/bpf/.gitignore             |    2 +-
 tools/testing/selftests/bpf/Makefile               |   44 +-
 .../testing/selftests/bpf/benchs/bench_ringbufs.c  |   65 +-
 tools/testing/selftests/bpf/benchs/bench_trigger.c |    4 +-
 .../selftests/bpf/benchs/run_bench_ringbufs.sh     |    4 +
 tools/testing/selftests/bpf/bpf_arena_list.h       |    6 +-
 tools/testing/selftests/bpf/bpf_arena_strsearch.h  |  128 +
 tools/testing/selftests/bpf/bpf_kfuncs.h           |   12 +-
 tools/testing/selftests/bpf/network_helpers.c      |   52 +-
 tools/testing/selftests/bpf/network_helpers.h      |   16 +
 .../selftests/bpf/prog_tests/arena_strsearch.c     |   30 +
 tools/testing/selftests/bpf/prog_tests/bpf_gotox.c |  292 +++
 .../selftests/bpf/prog_tests/bpf_insn_array.c      |  504 ++++
 tools/testing/selftests/bpf/prog_tests/btf.c       |   65 +
 tools/testing/selftests/bpf/prog_tests/btf_split.c |   87 +-
 tools/testing/selftests/bpf/prog_tests/check_mtu.c |   23 +-
 .../selftests/bpf/prog_tests/cls_redirect.c        |  122 +-
 .../testing/selftests/bpf/prog_tests/file_reader.c |  117 +
 .../testing/selftests/bpf/prog_tests/htab_update.c |   37 +-
 .../selftests/bpf/prog_tests/kmem_cache_iter.c     |    3 +-
 .../selftests/bpf/prog_tests/perf_branches.c       |   22 +-
 .../selftests/bpf/prog_tests/rcu_read_lock.c       |    4 +-
 .../selftests/bpf/prog_tests/refcounted_kptr.c     |   56 +
 .../selftests/bpf/prog_tests/res_spin_lock.c       |    8 +-
 tools/testing/selftests/bpf/prog_tests/ringbuf.c   |   65 +
 .../selftests/bpf/prog_tests/select_reuseport.c    |   67 +-
 .../testing/selftests/bpf/prog_tests/send_signal.c |    5 +
 .../selftests/bpf/prog_tests/string_kfuncs.c       |    2 +
 tools/testing/selftests/bpf/prog_tests/test_lsm.c  |    2 +-
 .../testing/selftests/bpf/prog_tests/test_tc_edt.c |  145 ++
 .../selftests/bpf/prog_tests/test_tc_tunnel.c      |  714 ++++++
 .../testing/selftests/bpf/prog_tests/test_tunnel.c |  107 +-
 tools/testing/selftests/bpf/prog_tests/test_xsk.c  | 2596 +++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/test_xsk.h  |  298 +++
 tools/testing/selftests/bpf/prog_tests/verifier.c  |    4 +
 tools/testing/selftests/bpf/prog_tests/wq.c        |   56 +
 tools/testing/selftests/bpf/prog_tests/xsk.c       |  151 ++
 .../testing/selftests/bpf/progs/arena_strsearch.c  |  146 ++
 tools/testing/selftests/bpf/progs/bpf_cc_cubic.c   |    9 -
 tools/testing/selftests/bpf/progs/bpf_cubic.c      |    7 -
 tools/testing/selftests/bpf/progs/bpf_dctcp.c      |    6 -
 tools/testing/selftests/bpf/progs/bpf_gotox.c      |  448 ++++
 .../selftests/bpf/progs/bpf_iter_setsockopt.c      |   17 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h       |    4 +
 .../testing/selftests/bpf/progs/bpf_tracing_net.h  |   14 +
 tools/testing/selftests/bpf/progs/connect4_prog.c  |   21 +-
 tools/testing/selftests/bpf/progs/dynptr_success.c |   12 +-
 tools/testing/selftests/bpf/progs/file_reader.c    |  145 ++
 .../testing/selftests/bpf/progs/file_reader_fail.c |   52 +
 tools/testing/selftests/bpf/progs/htab_update.c    |   19 +-
 .../testing/selftests/bpf/progs/ip_check_defrag.c  |    5 -
 tools/testing/selftests/bpf/progs/lsm.c            |    8 +-
 tools/testing/selftests/bpf/progs/lsm_tailcall.c   |    8 +-
 tools/testing/selftests/bpf/progs/rcu_read_lock.c  |   40 +
 .../testing/selftests/bpf/progs/refcounted_kptr.c  |   60 +
 tools/testing/selftests/bpf/progs/ringbuf_bench.c  |   11 +
 .../selftests/bpf/progs/string_kfuncs_failure1.c   |   12 +
 .../selftests/bpf/progs/string_kfuncs_failure2.c   |    2 +
 .../selftests/bpf/progs/string_kfuncs_success.c    |   10 +
 tools/testing/selftests/bpf/progs/strobemeta.h     |    6 +-
 .../selftests/bpf/progs/tcp_ca_write_sk_pacing.c   |    2 -
 tools/testing/selftests/bpf/progs/test_check_mtu.c |   12 +
 .../selftests/bpf/progs/test_perf_branches.c       |    3 +
 .../selftests/bpf/progs/test_ringbuf_overwrite.c   |   98 +
 tools/testing/selftests/bpf/progs/test_tc_edt.c    |   11 +-
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c |   95 +-
 tools/testing/selftests/bpf/progs/trigger_bench.c  |    6 +-
 .../bpf/progs/verifier_async_cb_context.c          |  181 ++
 .../testing/selftests/bpf/progs/verifier_bounds.c  |  154 ++
 .../bpf/progs/verifier_direct_packet_access.c      |   59 +
 tools/testing/selftests/bpf/progs/verifier_gotox.c |  389 +++
 .../selftests/bpf/progs/verifier_live_stack.c      |   50 +
 tools/testing/selftests/bpf/progs/verifier_lsm.c   |    4 +-
 .../selftests/bpf/progs/verifier_netfilter_ctx.c   |    5 -
 tools/testing/selftests/bpf/progs/verifier_sock.c  |   39 +-
 .../bpf/progs/verifier_subprog_precision.c         |   53 +
 tools/testing/selftests/bpf/progs/wq.c             |   17 +
 tools/testing/selftests/bpf/progs/wq_failures.c    |   23 +
 tools/testing/selftests/bpf/test_bpftool_build.sh  |    4 -
 .../selftests/bpf/test_kmods/bpf_test_rqspinlock.c |  236 +-
 tools/testing/selftests/bpf/test_loader.c          |   29 +-
 tools/testing/selftests/bpf/test_maps.c            |    3 +-
 tools/testing/selftests/bpf/test_tag.c             |    2 +-
 tools/testing/selftests/bpf/test_tc_edt.sh         |  100 -
 tools/testing/selftests/bpf/test_tc_tunnel.sh      |  320 ---
 tools/testing/selftests/bpf/xskxceiver.c           | 2696 +-------------------
 tools/testing/selftests/bpf/xskxceiver.h           |  156 --
 157 files changed, 10944 insertions(+), 5090 deletions(-)
 create mode 100644 kernel/bpf/bpf_insn_array.c
 delete mode 100644 tools/bpf/runqslower/.gitignore
 delete mode 100644 tools/bpf/runqslower/Makefile
 delete mode 100644 tools/bpf/runqslower/runqslower.bpf.c
 delete mode 100644 tools/bpf/runqslower/runqslower.c
 delete mode 100644 tools/bpf/runqslower/runqslower.h
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_strsearch.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_strsearch.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/file_reader.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_tc_edt.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_xsk.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_xsk.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xsk.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_strsearch.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_gotox.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_reader.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_reader_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_overwrite.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_gotox.c
 delete mode 100755 tools/testing/selftests/bpf/test_tc_edt.sh
 delete mode 100755 tools/testing/selftests/bpf/test_tc_tunnel.sh

