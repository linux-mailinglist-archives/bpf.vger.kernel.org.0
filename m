Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BC4686608
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 13:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjBAMgp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 07:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjBAMgo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 07:36:44 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 103795AB74;
        Wed,  1 Feb 2023 04:36:40 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxV+nXXNpjWXkLAA--.18305S3;
        Wed, 01 Feb 2023 20:36:39 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxOL3WXNpjUXImAA--.10032S2;
        Wed, 01 Feb 2023 20:36:38 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/4] bpf: Replace BPF_ALU and BPF_JMP with BPF_ALU32 and BPF_JMP64
Date:   Wed,  1 Feb 2023 20:36:34 +0800
Message-Id: <1675254998-4951-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8AxOL3WXNpjUXImAA--.10032S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Wr18Jr1UJr43Jw48Ww4kZwb_yoWfXw4Dp3
        W8K3sxtFnavF17WF1xArsFvFWFyF4vgay7Gr1vvry5Z3W8JFyxXr4xKF43JrnxKrWrXwn5
        A34S93yY93W8XFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
        4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The intention of this patchset is to make the code more readable,
no functional changes, based on bpf-next.

If this patchset makes no sense, please ignore it and sorry for that.

Tiezhu Yang (4):
  bpf: Add new macro BPF_ALU32 and BPF_JMP64
  bpf: treewide: Clean up BPF_ALU and BPF_JMP
  bpf: treewide: Clean up BPF_ALU_* and BPF_JMP_*
  bpf: Mark BPF_ALU and BPF_JMP as deprecated

 Documentation/bpf/clang-notes.rst                  |    2 +-
 Documentation/bpf/classic_vs_extended.rst          |   26 +-
 Documentation/bpf/instruction-set.rst              |   28 +-
 Documentation/bpf/verifier.rst                     |   14 +-
 Documentation/networking/cdc_mbim.rst              |    8 +-
 arch/arm/net/bpf_jit_32.c                          |  110 +--
 arch/arm64/net/bpf_jit_comp.c                      |  112 +--
 arch/loongarch/net/bpf_jit.c                       |  108 +--
 arch/mips/net/bpf_jit_comp32.c                     |  106 +--
 arch/mips/net/bpf_jit_comp64.c                     |  106 +--
 arch/powerpc/net/bpf_jit_comp.c                    |    2 +-
 arch/powerpc/net/bpf_jit_comp32.c                  |  152 +--
 arch/powerpc/net/bpf_jit_comp64.c                  |  162 ++--
 arch/riscv/net/bpf_jit_comp32.c                    |  108 +--
 arch/riscv/net/bpf_jit_comp64.c                    |  120 +--
 arch/s390/net/bpf_jit_comp.c                       |  108 +--
 arch/sparc/net/bpf_jit_comp_32.c                   |   72 +-
 arch/sparc/net/bpf_jit_comp_64.c                   |  108 +--
 arch/x86/net/bpf_jit_comp.c                        |  118 +--
 arch/x86/net/bpf_jit_comp32.c                      |  116 +--
 drivers/net/ethernet/netronome/nfp/bpf/jit.c       |  124 +--
 drivers/net/ethernet/netronome/nfp/bpf/main.h      |    8 +-
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c  |    4 +-
 include/linux/bpf_verifier.h                       |   14 +-
 include/linux/filter.h                             |   38 +-
 include/uapi/linux/bpf.h                           |    2 +
 include/uapi/linux/bpf_common.h                    |    4 +-
 kernel/bpf/arraymap.c                              |   14 +-
 kernel/bpf/core.c                                  |   52 +-
 kernel/bpf/disasm.c                                |   22 +-
 kernel/bpf/hashtab.c                               |    8 +-
 kernel/bpf/syscall.c                               |   12 +-
 kernel/bpf/verifier.c                              |  106 +--
 kernel/seccomp.c                                   |   68 +-
 lib/test_bpf.c                                     | 1004 ++++++++++----------
 net/core/filter.c                                  |  242 ++---
 net/xdp/xskmap.c                                   |    4 +-
 samples/bpf/bpf_insn.h                             |   22 +-
 samples/bpf/cookie_uid_helper_example.c            |   12 +-
 samples/bpf/sock_example.c                         |    4 +-
 samples/bpf/test_cgrp2_attach.c                    |    8 +-
 samples/bpf/test_cgrp2_sock.c                      |    4 +-
 samples/seccomp/bpf-direct.c                       |   18 +-
 samples/seccomp/bpf-helper.c                       |    2 +-
 samples/seccomp/bpf-helper.h                       |   56 +-
 samples/seccomp/dropper.c                          |    4 +-
 samples/seccomp/user-trap.c                        |    2 +-
 tools/bpf/bpf_dbg.c                                |  254 ++---
 tools/bpf/bpf_exp.y                                |  130 +--
 tools/bpf/bpftool/cfg.c                            |    4 +-
 tools/bpf/bpftool/feature.c                        |    4 +-
 tools/include/linux/filter.h                       |   34 +-
 tools/include/uapi/linux/bpf.h                     |    2 +
 tools/include/uapi/linux/bpf_common.h              |    4 +-
 tools/lib/bpf/bpf_endian.h                         |    2 +-
 tools/lib/bpf/gen_loader.c                         |   36 +-
 tools/lib/bpf/libbpf.c                             |   14 +-
 tools/lib/bpf/linker.c                             |    2 +-
 tools/lib/bpf/relo_core.c                          |    4 +-
 tools/perf/util/bpf-prologue.c                     |    8 +-
 tools/testing/selftests/bpf/prog_tests/align.c     |   24 +-
 tools/testing/selftests/bpf/prog_tests/btf.c       |   32 +-
 .../selftests/bpf/prog_tests/cgroup_attach_multi.c |    8 +-
 .../bpf/prog_tests/flow_dissector_load_bytes.c     |    4 +-
 tools/testing/selftests/bpf/prog_tests/sockopt.c   |   42 +-
 tools/testing/selftests/bpf/progs/pyperf600.c      |    2 +-
 tools/testing/selftests/bpf/progs/syscall.c        |    2 +-
 tools/testing/selftests/bpf/test_cgroup_storage.c  |    4 +-
 tools/testing/selftests/bpf/test_lru_map.c         |    4 +-
 tools/testing/selftests/bpf/test_sock.c            |   30 +-
 tools/testing/selftests/bpf/test_sock_addr.c       |    6 +-
 tools/testing/selftests/bpf/test_sysctl.c          |  172 ++--
 tools/testing/selftests/bpf/test_verifier.c        |   44 +-
 tools/testing/selftests/bpf/test_verifier_log.c    |    2 +-
 tools/testing/selftests/bpf/verifier/and.c         |   10 +-
 .../testing/selftests/bpf/verifier/array_access.c  |   92 +-
 tools/testing/selftests/bpf/verifier/atomic_and.c  |   14 +-
 .../testing/selftests/bpf/verifier/atomic_bounds.c |    2 +-
 .../selftests/bpf/verifier/atomic_cmpxchg.c        |   12 +-
 .../testing/selftests/bpf/verifier/atomic_fetch.c  |   12 +-
 .../selftests/bpf/verifier/atomic_fetch_add.c      |    8 +-
 tools/testing/selftests/bpf/verifier/atomic_or.c   |   12 +-
 tools/testing/selftests/bpf/verifier/atomic_xchg.c |    4 +-
 tools/testing/selftests/bpf/verifier/atomic_xor.c  |   10 +-
 tools/testing/selftests/bpf/verifier/basic_call.c  |   14 +-
 tools/testing/selftests/bpf/verifier/basic_instr.c |   14 +-
 tools/testing/selftests/bpf/verifier/basic_stack.c |    2 +-
 tools/testing/selftests/bpf/verifier/bounds.c      |  154 +--
 .../selftests/bpf/verifier/bounds_deduction.c      |   24 +-
 .../bpf/verifier/bounds_mix_sign_unsign.c          |  132 +--
 .../testing/selftests/bpf/verifier/bpf_get_stack.c |   16 +-
 .../selftests/bpf/verifier/bpf_loop_inline.c       |   40 +-
 tools/testing/selftests/bpf/verifier/calls.c       |  594 ++++++------
 tools/testing/selftests/bpf/verifier/cfg.c         |   14 +-
 tools/testing/selftests/bpf/verifier/cgroup_skb.c  |    2 +-
 .../selftests/bpf/verifier/cgroup_storage.c        |   28 +-
 tools/testing/selftests/bpf/verifier/ctx.c         |   24 +-
 tools/testing/selftests/bpf/verifier/ctx_sk_msg.c  |    8 +-
 tools/testing/selftests/bpf/verifier/ctx_skb.c     |  130 +--
 tools/testing/selftests/bpf/verifier/d_path.c      |    4 +-
 tools/testing/selftests/bpf/verifier/dead_code.c   |   56 +-
 .../selftests/bpf/verifier/direct_packet_access.c  |   92 +-
 .../testing/selftests/bpf/verifier/div_overflow.c  |    8 +-
 .../testing/selftests/bpf/verifier/event_output.c  |    2 +-
 .../selftests/bpf/verifier/helper_access_var_len.c |   80 +-
 .../selftests/bpf/verifier/helper_packet_access.c  |   84 +-
 .../selftests/bpf/verifier/helper_restricted.c     |   40 +-
 .../selftests/bpf/verifier/helper_value_access.c   |  132 +--
 .../selftests/bpf/verifier/jeq_infer_not_null.c    |   32 +-
 tools/testing/selftests/bpf/verifier/jit.c         |   50 +-
 tools/testing/selftests/bpf/verifier/jmp32.c       |   32 +-
 tools/testing/selftests/bpf/verifier/jset.c        |   40 +-
 tools/testing/selftests/bpf/verifier/jump.c        |  242 ++---
 tools/testing/selftests/bpf/verifier/junk_insn.c   |    2 +-
 tools/testing/selftests/bpf/verifier/ld_abs.c      |   14 +-
 tools/testing/selftests/bpf/verifier/ld_imm64.c    |    6 +-
 tools/testing/selftests/bpf/verifier/leak_ptr.c    |    4 +-
 tools/testing/selftests/bpf/verifier/loops1.c      |   58 +-
 tools/testing/selftests/bpf/verifier/lwt.c         |   16 +-
 tools/testing/selftests/bpf/verifier/map_in_map.c  |   32 +-
 tools/testing/selftests/bpf/verifier/map_kptr.c    |  126 +--
 tools/testing/selftests/bpf/verifier/map_ptr.c     |    4 +-
 .../selftests/bpf/verifier/map_ptr_mixing.c        |   28 +-
 tools/testing/selftests/bpf/verifier/map_ret_val.c |   12 +-
 tools/testing/selftests/bpf/verifier/meta_access.c |   32 +-
 tools/testing/selftests/bpf/verifier/precise.c     |   44 +-
 .../selftests/bpf/verifier/prevent_map_lookup.c    |    4 +-
 tools/testing/selftests/bpf/verifier/raw_stack.c   |   32 +-
 .../selftests/bpf/verifier/raw_tp_writable.c       |    4 +-
 .../testing/selftests/bpf/verifier/ref_tracking.c  |  164 ++--
 tools/testing/selftests/bpf/verifier/regalloc.c    |   64 +-
 tools/testing/selftests/bpf/verifier/ringbuf.c     |   20 +-
 tools/testing/selftests/bpf/verifier/runtime_jit.c |   50 +-
 .../selftests/bpf/verifier/search_pruning.c        |   66 +-
 tools/testing/selftests/bpf/verifier/sock.c        |  114 +--
 tools/testing/selftests/bpf/verifier/spill_fill.c  |   26 +-
 tools/testing/selftests/bpf/verifier/spin_lock.c   |  126 +--
 tools/testing/selftests/bpf/verifier/stack_ptr.c   |    6 +-
 tools/testing/selftests/bpf/verifier/subreg.c      |   96 +-
 tools/testing/selftests/bpf/verifier/uninit.c      |    2 +-
 tools/testing/selftests/bpf/verifier/unpriv.c      |   60 +-
 tools/testing/selftests/bpf/verifier/value.c       |   10 +-
 .../selftests/bpf/verifier/value_adj_spill.c       |    4 +-
 .../selftests/bpf/verifier/value_illegal_alu.c     |   10 +-
 .../testing/selftests/bpf/verifier/value_or_null.c |   46 +-
 .../selftests/bpf/verifier/value_ptr_arith.c       |  266 +++---
 tools/testing/selftests/bpf/verifier/var_off.c     |    6 +-
 tools/testing/selftests/bpf/verifier/xadd.c        |   16 +-
 tools/testing/selftests/bpf/verifier/xdp.c         |    2 +-
 .../bpf/verifier/xdp_direct_packet_access.c        |  228 ++---
 tools/testing/selftests/net/csum.c                 |    6 +-
 tools/testing/selftests/net/gro.c                  |    8 +-
 tools/testing/selftests/net/psock_fanout.c         |   12 +-
 tools/testing/selftests/net/reuseport_bpf.c        |    6 +-
 tools/testing/selftests/net/reuseport_bpf_numa.c   |    4 +-
 tools/testing/selftests/net/toeplitz.c             |    6 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c      |   68 +-
 157 files changed, 4299 insertions(+), 4295 deletions(-)

-- 
2.1.0

