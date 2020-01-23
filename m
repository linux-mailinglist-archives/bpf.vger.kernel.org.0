Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D711460EF
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 04:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgAWD31 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jan 2020 22:29:27 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:42509 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWD31 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jan 2020 22:29:27 -0500
Received: by mail-pg1-f170.google.com with SMTP id s64so624511pgb.9;
        Wed, 22 Jan 2020 19:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VUDrYaWVKwEXLzJ2z3bP0vRzEh4HmGLWlNRuXphy84Q=;
        b=Huhj1vwD/DMQhJI1LNOkC03sRN399Jf2b0EH82Paq433lSZITuG7DY3ZvBk04TjO7A
         pBCE7Xm6wfxJQTk4i5uqZFKYcCP/hi37guzCtAAtvi0rnIV8Dvsz5xI6uNeJy5ZjzKXK
         EsY4Wle5VNV0SK2s47Ng1H9oIO0Nkj8oCOK+jpyyV4Tmo1/fuhv5byYc2hecMNSwJIII
         Rn6TnDOBbUuUdfQyvZ/RrUNvb1KciW2IVlAp0E7pjRxyIjHXshh84rpPCNGMGXTx5btL
         ZerHfzWm+QA+qy0Ag5ZRCJ5uLtNDWAjkp02muuYUWK1FBtMvCv5zwb0CBAhbH4NBTXM0
         fHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VUDrYaWVKwEXLzJ2z3bP0vRzEh4HmGLWlNRuXphy84Q=;
        b=JJA7VdVWZzrDSsTVZrueARr3hk7ExDWVak1nKteqC7C62AlLrZEYRzOgbCXj3zRODF
         yqqSSK+/OlkR2pyLlVYRkMACZgxS/quh8FltWRrOgkq/flqrYYP4BOlzZ0wgJe2yuFY5
         uI0Mgarj/NnoXdU7noW+82BK2xPYOsd8AmMATfuhu/eYOefkTOeGuFTn1zZ/ECx2hHej
         586NpcoUubFxrKhjJNM/lMaHkg6k7yX+5vm+ujPfw/n9Is9sVY3ukUXipTyyDLyA3/QM
         rYBBb3gx7rLjWAEaBcqYH434EwBEDDCTvHf1JHABGjR9yfZrdIKvOWT5Wvy7weQt2B9C
         wEwA==
X-Gm-Message-State: APjAAAXdv2tglHRDgy/WdmJHLoGhcqEGvjnecyu1W1YjDgpmPha2kIgU
        2+k7rjZYPhsZNzjs7wH2zXw=
X-Google-Smtp-Source: APXvYqw+kv5K4V5a40Nume0zhZGpX5XkIFCR11c9cIXFePAjwP7805t9eKOoD27dr9PL3v6Amv0C2g==
X-Received: by 2002:a63:551a:: with SMTP id j26mr1675945pgb.370.1579750165615;
        Wed, 22 Jan 2020 19:29:25 -0800 (PST)
Received: from ast-mbp.thefacebook.com (prnvpn05.thefacebook.com. [199.201.64.4])
        by smtp.gmail.com with ESMTPSA id a17sm428307pjv.6.2020.01.22.19.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2020 19:29:24 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: pull-request: bpf-next 2020-01-22
Date:   Wed, 22 Jan 2020 19:29:21 -0800
Message-Id: <20200123032921.61191-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 92 non-merge commits during the last 16 day(s) which contain
a total of 320 files changed, 7532 insertions(+), 1448 deletions(-).

The main changes are:

1) function by function verification and program extensions from Alexei.

2) massive cleanup of selftests/bpf from Toke and Andrii.

3) batched bpf map operations from Brian and Yonghong.

4) tcp congestion control in bpf from Martin.

5) bulking for non-map xdp_redirect form Toke.

6) bpf_send_signal_thread helper from Yonghong.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alexei Starovoitov, Andrii Nakryiko, Björn Töpel, Brendan Jackman, Brian 
Vazquez, Dan Carpenter, Hulk Robot, Jann Horn, Jesper Dangaard Brouer, 
John Fastabend, Jonathan Lemon, Martin KaFai Lau, Paul E. McKenney, 
Petar Penkov, Quentin Monnet, Ryan Goodfellow, Song Liu, Toke 
Høiland-Jørgensen, Yonghong Song

----------------------------------------------------------------

The following changes since commit 1ece2fbe9b427d379455f18a874bcd3ab86a2419:

  ptp: clockmatrix: Rework clockmatrix version information. (2020-01-07 13:51:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git 

for you to fetch changes up to 85cc12f85138f2ce3edf24833edd2179690306db:

  Merge branch 'bpf_cubic' (2020-01-22 16:30:15 -0800)

----------------------------------------------------------------
Al Viro (1):
      bpf: don't bother with getname/kern_path - use user_path_at

Alexei Starovoitov (20):
      Merge branch 'tcp-bpf-cc'
      Merge branch 'selftest-makefile-cleanup'
      libbpf: Sanitize global functions
      bpf: Introduce function-by-function verification
      selftests/bpf: Add fexit-to-skb test for global funcs
      selftests/bpf: Add a test for a large global function
      selftests/bpf: Modify a test to check global functions
      selftests/bpf: Add unit tests for global functions
      Merge branch 'runqslower'
      Merge branch 'bpf_send_signal_thread'
      Merge branch 'bpf-batch-ops'
      Merge branch 'bpftool-improvements'
      Merge branch 'xdp_redirect-bulking'
      Merge branch 'libbpf-include-path'
      bpf: Fix trampoline usage in preempt
      bpf: Fix error path under memory pressure
      bpf: Introduce dynamic program extensions
      libbpf: Add support for program extensions
      selftests/bpf: Add tests for program extensions
      Merge branch 'bpf_cubic'

Andrey Ignatov (1):
      bpf: Document BPF_F_QUERY_EFFECTIVE flag

Andrii Nakryiko (18):
      libbpf: Make bpf_map order and indices stable
      libbpf,selftests/bpf: Fix clean targets
      selftests/bpf: Ensure bpf_helper_defs.h are taken from selftests dir
      selftests/bpf: Further clean up Makefile output
      libbpf: Poison kernel-only integer types
      selftests/bpf: Add BPF_PROG, BPF_KPROBE, and BPF_KRETPROBE macros
      tools: Sync uapi/linux/if_link.h
      libbpf: Clean up bpf_helper_defs.h generation output
      selftests/bpf: Conform selftests/bpf Makefile output to libbpf and bpftool
      bpftool: Apply preserve_access_index attribute to all types in BTF dump
      tools/bpf: Add runqslower tool to tools/bpf
      selftests/bpf: Build runqslower from selftests
      libbpf: Support .text sub-calls relocations
      selftests/bpf: Add whitelist/blacklist of test names to test_progs
      libbpf: Revert bpf_helper_defs.h inclusion regression
      libbpf: Fix error handling bug in btf_dump__new
      libbpf: Simplify BTF initialization logic
      libbpf: Fix potential multiplication overflow in mmap() size calculation

Björn Töpel (1):
      xsk, net: Make sock_def_readable() have external linkage

Brian Vazquez (7):
      bpf: Add bpf_map_{value_size, update_value, map_copy_value} functions
      bpf: Add generic support for lookup batch op
      bpf: Add generic support for update and delete batch ops
      bpf: Add lookup and update batch ops to arraymap
      selftests/bpf: Add batch ops testing to array bpf map
      libbpf: Fix unneeded extra initialization in bpf_map_batch_common
      bpf: Fix memory leaks in generic update/delete batch ops

Chris Down (1):
      bpf, btf: Always output invariant hit in pahole DWARF to BTF transform

Daniel Borkmann (2):
      Merge branch 'bpf-global-funcs'
      Merge branch 'bpf-dynamic-relinking'

Daniel Díaz (1):
      selftests/bpf: Build urandom_read with LDFLAGS and LDLIBS

Eelco Chaudron (1):
      selftests/bpf: Add a test for attaching a bpf fentry/fexit trace to an XDP program

Hangbin Liu (1):
      selftests/bpf: Skip perf hw events test if the setup disabled it

Jesper Dangaard Brouer (1):
      devmap: Adjust tracepoint for map-less queue flush

KP Singh (1):
      libbpf: Load btf_vmlinux only once per object.

Li RongQing (1):
      bpf: Return -EBADRQC for invalid map type in __bpf_tx_xdp_map

Magnus Karlsson (1):
      xsk: Support allocations of large umems

Martin KaFai Lau (20):
      bpf: Save PTR_TO_BTF_ID register state when spilling to stack
      bpf: Avoid storing modifier to info->btf_id
      bpf: Add enum support to btf_ctx_access()
      bpf: Support bitfield read access in btf_struct_access
      bpf: Introduce BPF_PROG_TYPE_STRUCT_OPS
      bpf: Introduce BPF_MAP_TYPE_STRUCT_OPS
      bpf: tcp: Support tcp_congestion_ops in bpf
      bpf: Add BPF_FUNC_tcp_send_ack helper
      bpf: Synch uapi bpf.h to tools/
      bpf: libbpf: Add STRUCT_OPS support
      bpf: Add bpf_dctcp example
      bpf: Fix seq_show for BPF_MAP_TYPE_STRUCT_OPS
      bpftool: Fix a leak of btf object
      bpftool: Fix missing BTF output for json during map dump
      libbpf: Expose bpf_find_kernel_btf as a LIBBPF_API
      bpftool: Add struct_ops map name
      bpftool: Support dumping a map with btf_vmlinux_value_type_id
      bpf: Add BPF_FUNC_jiffies64
      bpf: Sync uapi bpf.h to tools/
      bpf: tcp: Add bpf_cubic example

Michal Rostecki (2):
      libbpf: Add probe for large INSN limit
      bpftool: Add misc section and probe for large INSN limit

Stanislav Fomichev (2):
      selftests/bpf: Restore original comm in test_overhead
      selftests/bpf: Don't check for btf fd in test_btf

Toke Høiland-Jørgensen (13):
      xdp: Move devmap bulk queue into struct net_device
      xdp: Use bulking for non-map XDP_REDIRECT and consolidate code paths
      samples/bpf: Don't try to remove user's homedir on clean
      tools/bpf/runqslower: Fix override option for VMLINUX_BTF
      selftests: Pass VMLINUX_BTF to runqslower Makefile
      tools/runqslower: Use consistent include paths for libbpf
      selftests: Use consistent include paths for libbpf
      bpftool: Use consistent include paths for libbpf
      perf: Use consistent include paths for libbpf
      samples/bpf: Use consistent include paths for libbpf
      tools/runqslower: Remove tools/lib/bpf from include path
      runsqslower: Support user-specified libbpf include and object paths
      selftests: Refactor build to remove tools/lib/bpf from include path

Yonghong Song (7):
      bpf: Add bpf_send_signal_thread() helper
      tools/bpf: Add self tests for bpf_send_signal_thread()
      bpf: Add batch ops to all htab bpf map
      tools/bpf: Sync uapi header bpf.h
      libbpf: Add libbpf support to batch ops
      selftests/bpf: Add batch ops testing for htab and htab_percpu map
      selftests/bpf: Fix test_progs send_signal flakiness with nmi mode

YueHaibing (1):
      bpf: Remove set but not used variable 'first_key'

 arch/x86/net/bpf_jit_comp.c                        |  18 +-
 drivers/net/tun.c                                  |   4 +-
 drivers/net/veth.c                                 |   2 +-
 drivers/net/virtio_net.c                           |   2 +-
 include/linux/bpf.h                                | 128 ++-
 include/linux/bpf_types.h                          |   9 +
 include/linux/bpf_verifier.h                       |  10 +-
 include/linux/btf.h                                |  52 ++
 include/linux/filter.h                             |  12 +-
 include/linux/netdevice.h                          |  13 +-
 include/net/sock.h                                 |   2 +
 include/net/tcp.h                                  |   2 +
 include/trace/events/xdp.h                         | 130 ++-
 include/uapi/linux/bpf.h                           |  72 +-
 include/uapi/linux/btf.h                           |   6 +
 kernel/bpf/Makefile                                |   3 +
 kernel/bpf/arraymap.c                              |   2 +
 kernel/bpf/bpf_struct_ops.c                        | 634 ++++++++++++++
 kernel/bpf/bpf_struct_ops_types.h                  |   9 +
 kernel/bpf/btf.c                                   | 488 +++++++++--
 kernel/bpf/core.c                                  |   1 +
 kernel/bpf/devmap.c                                |  95 +-
 kernel/bpf/hashtab.c                               | 264 ++++++
 kernel/bpf/helpers.c                               |  12 +
 kernel/bpf/inode.c                                 |  43 +-
 kernel/bpf/map_in_map.c                            |   3 +-
 kernel/bpf/syscall.c                               | 632 ++++++++++----
 kernel/bpf/trampoline.c                            |  59 +-
 kernel/bpf/verifier.c                              | 504 ++++++++---
 kernel/trace/bpf_trace.c                           |  27 +-
 net/core/dev.c                                     |   2 +
 net/core/filter.c                                  |  96 +--
 net/core/sock.c                                    |   2 +-
 net/ipv4/Makefile                                  |   4 +
 net/ipv4/bpf_tcp_ca.c                              | 252 ++++++
 net/ipv4/tcp_cong.c                                |  16 +-
 net/ipv4/tcp_ipv4.c                                |   6 +-
 net/ipv4/tcp_minisocks.c                           |   4 +-
 net/ipv4/tcp_output.c                              |   4 +-
 net/xdp/xdp_umem.c                                 |   7 +-
 net/xdp/xsk.c                                      |   2 +-
 samples/bpf/Makefile                               |   5 +-
 samples/bpf/cpustat_kern.c                         |   2 +-
 samples/bpf/fds_example.c                          |   2 +-
 samples/bpf/hbm.c                                  |   4 +-
 samples/bpf/hbm_kern.h                             |   4 +-
 samples/bpf/ibumad_kern.c                          |   2 +-
 samples/bpf/ibumad_user.c                          |   2 +-
 samples/bpf/lathist_kern.c                         |   2 +-
 samples/bpf/lwt_len_hist_kern.c                    |   2 +-
 samples/bpf/map_perf_test_kern.c                   |   4 +-
 samples/bpf/offwaketime_kern.c                     |   4 +-
 samples/bpf/offwaketime_user.c                     |   2 +-
 samples/bpf/parse_ldabs.c                          |   2 +-
 samples/bpf/parse_simple.c                         |   2 +-
 samples/bpf/parse_varlen.c                         |   2 +-
 samples/bpf/sampleip_kern.c                        |   4 +-
 samples/bpf/sampleip_user.c                        |   2 +-
 samples/bpf/sock_flags_kern.c                      |   2 +-
 samples/bpf/sockex1_kern.c                         |   2 +-
 samples/bpf/sockex1_user.c                         |   2 +-
 samples/bpf/sockex2_kern.c                         |   2 +-
 samples/bpf/sockex2_user.c                         |   2 +-
 samples/bpf/sockex3_kern.c                         |   2 +-
 samples/bpf/spintest_kern.c                        |   4 +-
 samples/bpf/spintest_user.c                        |   2 +-
 samples/bpf/syscall_tp_kern.c                      |   2 +-
 samples/bpf/task_fd_query_kern.c                   |   2 +-
 samples/bpf/task_fd_query_user.c                   |   2 +-
 samples/bpf/tc_l2_redirect_kern.c                  |   2 +-
 samples/bpf/tcbpf1_kern.c                          |   2 +-
 samples/bpf/tcp_basertt_kern.c                     |   4 +-
 samples/bpf/tcp_bufs_kern.c                        |   4 +-
 samples/bpf/tcp_clamp_kern.c                       |   4 +-
 samples/bpf/tcp_cong_kern.c                        |   4 +-
 samples/bpf/tcp_dumpstats_kern.c                   |   4 +-
 samples/bpf/tcp_iw_kern.c                          |   4 +-
 samples/bpf/tcp_rwnd_kern.c                        |   4 +-
 samples/bpf/tcp_synrto_kern.c                      |   4 +-
 samples/bpf/tcp_tos_reflect_kern.c                 |   4 +-
 samples/bpf/test_cgrp2_tc_kern.c                   |   2 +-
 samples/bpf/test_current_task_under_cgroup_kern.c  |   2 +-
 samples/bpf/test_lwt_bpf.c                         |   2 +-
 samples/bpf/test_map_in_map_kern.c                 |   4 +-
 samples/bpf/test_overhead_kprobe_kern.c            |   4 +-
 samples/bpf/test_overhead_raw_tp_kern.c            |   2 +-
 samples/bpf/test_overhead_tp_kern.c                |   2 +-
 samples/bpf/test_probe_write_user_kern.c           |   4 +-
 samples/bpf/trace_event_kern.c                     |   4 +-
 samples/bpf/trace_event_user.c                     |   2 +-
 samples/bpf/trace_output_kern.c                    |   2 +-
 samples/bpf/trace_output_user.c                    |   2 +-
 samples/bpf/tracex1_kern.c                         |   4 +-
 samples/bpf/tracex2_kern.c                         |   4 +-
 samples/bpf/tracex3_kern.c                         |   4 +-
 samples/bpf/tracex4_kern.c                         |   4 +-
 samples/bpf/tracex5_kern.c                         |   4 +-
 samples/bpf/tracex6_kern.c                         |   2 +-
 samples/bpf/tracex7_kern.c                         |   2 +-
 samples/bpf/xdp1_kern.c                            |   2 +-
 samples/bpf/xdp1_user.c                            |   4 +-
 samples/bpf/xdp2_kern.c                            |   2 +-
 samples/bpf/xdp2skb_meta_kern.c                    |   2 +-
 samples/bpf/xdp_adjust_tail_kern.c                 |   2 +-
 samples/bpf/xdp_adjust_tail_user.c                 |   4 +-
 samples/bpf/xdp_fwd_kern.c                         |   2 +-
 samples/bpf/xdp_fwd_user.c                         |   2 +-
 samples/bpf/xdp_monitor_kern.c                     |  10 +-
 samples/bpf/xdp_redirect_cpu_kern.c                |   2 +-
 samples/bpf/xdp_redirect_cpu_user.c                |   2 +-
 samples/bpf/xdp_redirect_kern.c                    |   2 +-
 samples/bpf/xdp_redirect_map_kern.c                |   2 +-
 samples/bpf/xdp_redirect_map_user.c                |   2 +-
 samples/bpf/xdp_redirect_user.c                    |   2 +-
 samples/bpf/xdp_router_ipv4_kern.c                 |   2 +-
 samples/bpf/xdp_router_ipv4_user.c                 |   2 +-
 samples/bpf/xdp_rxq_info_kern.c                    |   2 +-
 samples/bpf/xdp_rxq_info_user.c                    |   4 +-
 samples/bpf/xdp_sample_pkts_kern.c                 |   2 +-
 samples/bpf/xdp_sample_pkts_user.c                 |   2 +-
 samples/bpf/xdp_tx_iptunnel_kern.c                 |   2 +-
 samples/bpf/xdp_tx_iptunnel_user.c                 |   2 +-
 samples/bpf/xdpsock_kern.c                         |   2 +-
 samples/bpf/xdpsock_user.c                         |   6 +-
 scripts/bpf_helpers_doc.py                         |   2 -
 scripts/link-vmlinux.sh                            |   4 +-
 tools/bpf/Makefile                                 |  20 +-
 tools/bpf/bpftool/Documentation/bpftool-gen.rst    |   2 +-
 tools/bpf/bpftool/Makefile                         |   2 +-
 tools/bpf/bpftool/btf.c                            |  16 +-
 tools/bpf/bpftool/btf_dumper.c                     |   2 +-
 tools/bpf/bpftool/cgroup.c                         |   2 +-
 tools/bpf/bpftool/common.c                         |   4 +-
 tools/bpf/bpftool/feature.c                        |  22 +-
 tools/bpf/bpftool/gen.c                            |  10 +-
 tools/bpf/bpftool/jit_disasm.c                     |   2 +-
 tools/bpf/bpftool/main.c                           |   4 +-
 tools/bpf/bpftool/map.c                            | 106 ++-
 tools/bpf/bpftool/map_perf_ring.c                  |   4 +-
 tools/bpf/bpftool/net.c                            |   8 +-
 tools/bpf/bpftool/netlink_dumper.c                 |   4 +-
 tools/bpf/bpftool/perf.c                           |   2 +-
 tools/bpf/bpftool/prog.c                           |   6 +-
 tools/bpf/bpftool/xlated_dumper.c                  |   2 +-
 tools/bpf/runqslower/.gitignore                    |   1 +
 tools/bpf/runqslower/Makefile                      |  84 ++
 tools/bpf/runqslower/runqslower.bpf.c              | 100 +++
 tools/bpf/runqslower/runqslower.c                  | 187 ++++
 tools/bpf/runqslower/runqslower.h                  |  13 +
 tools/include/uapi/linux/bpf.h                     |  72 +-
 tools/include/uapi/linux/btf.h                     |   6 +
 tools/include/uapi/linux/if_link.h                 |   1 +
 tools/lib/bpf/Makefile                             |  11 +-
 tools/lib/bpf/bpf.c                                |  72 +-
 tools/lib/bpf/bpf.h                                |  27 +-
 tools/lib/bpf/bpf_prog_linfo.c                     |   3 +
 tools/lib/bpf/btf.c                                | 105 ++-
 tools/lib/bpf/btf.h                                |   2 +
 tools/lib/bpf/btf_dump.c                           |   4 +
 tools/lib/bpf/hashmap.c                            |   3 +
 tools/lib/bpf/libbpf.c                             | 952 +++++++++++++++++----
 tools/lib/bpf/libbpf.h                             |   8 +-
 tools/lib/bpf/libbpf.map                           |  11 +
 tools/lib/bpf/libbpf_errno.c                       |   3 +
 tools/lib/bpf/libbpf_probes.c                      |  27 +
 tools/lib/bpf/netlink.c                            |   3 +
 tools/lib/bpf/nlattr.c                             |   3 +
 tools/lib/bpf/str_error.c                          |   3 +
 tools/lib/bpf/xsk.c                                |   3 +
 tools/perf/examples/bpf/5sec.c                     |   2 +-
 tools/perf/examples/bpf/empty.c                    |   2 +-
 tools/perf/examples/bpf/sys_enter_openat.c         |   2 +-
 tools/perf/include/bpf/pid_filter.h                |   2 +-
 tools/perf/include/bpf/stdio.h                     |   2 +-
 tools/perf/include/bpf/unistd.h                    |   2 +-
 tools/testing/selftests/bpf/.gitignore             |   6 +-
 tools/testing/selftests/bpf/Makefile               | 104 ++-
 tools/testing/selftests/bpf/bpf_tcp_helpers.h      | 235 +++++
 tools/testing/selftests/bpf/bpf_trace_helpers.h    | 166 ++--
 tools/testing/selftests/bpf/bpf_util.h             |   2 +-
 .../selftests/bpf/map_tests/array_map_batch_ops.c  | 129 +++
 .../selftests/bpf/map_tests/htab_map_batch_ops.c   | 283 ++++++
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  | 212 +++++
 .../selftests/bpf/prog_tests/bpf_verif_scale.c     |   2 +
 tools/testing/selftests/bpf/prog_tests/cpu_mask.c  |   2 +-
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c       |  21 +-
 .../testing/selftests/bpf/prog_tests/perf_buffer.c |   2 +-
 .../testing/selftests/bpf/prog_tests/send_signal.c | 130 ++-
 .../bpf/prog_tests/stacktrace_build_id_nmi.c       |   8 +-
 .../selftests/bpf/prog_tests/test_global_funcs.c   |  82 ++
 .../selftests/bpf/prog_tests/test_overhead.c       |   8 +-
 .../testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c |  65 ++
 tools/testing/selftests/bpf/progs/bpf_cubic.c      | 544 ++++++++++++
 tools/testing/selftests/bpf/progs/bpf_dctcp.c      | 216 +++++
 tools/testing/selftests/bpf/progs/bpf_flow.c       |   4 +-
 tools/testing/selftests/bpf/progs/connect4_prog.c  |   4 +-
 tools/testing/selftests/bpf/progs/connect6_prog.c  |   4 +-
 tools/testing/selftests/bpf/progs/dev_cgroup.c     |   2 +-
 tools/testing/selftests/bpf/progs/fentry_test.c    |  23 +-
 tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c  |  82 +-
 .../selftests/bpf/progs/fexit_bpf2bpf_simple.c     |   7 +-
 tools/testing/selftests/bpf/progs/fexit_test.c     |  25 +-
 .../selftests/bpf/progs/get_cgroup_id_kern.c       |   2 +-
 tools/testing/selftests/bpf/progs/kfree_skb.c      |  20 +-
 tools/testing/selftests/bpf/progs/loop1.c          |   4 +-
 tools/testing/selftests/bpf/progs/loop2.c          |   4 +-
 tools/testing/selftests/bpf/progs/loop3.c          |   4 +-
 tools/testing/selftests/bpf/progs/loop4.c          |   2 +-
 tools/testing/selftests/bpf/progs/loop5.c          |   2 +-
 tools/testing/selftests/bpf/progs/netcnt_prog.c    |   2 +-
 tools/testing/selftests/bpf/progs/pyperf.h         |  11 +-
 tools/testing/selftests/bpf/progs/pyperf_global.c  |   5 +
 .../testing/selftests/bpf/progs/sample_map_ret0.c  |   2 +-
 tools/testing/selftests/bpf/progs/sendmsg4_prog.c  |   4 +-
 tools/testing/selftests/bpf/progs/sendmsg6_prog.c  |   4 +-
 .../selftests/bpf/progs/socket_cookie_prog.c       |   4 +-
 .../selftests/bpf/progs/sockmap_parse_prog.c       |   4 +-
 .../selftests/bpf/progs/sockmap_tcp_msg_prog.c     |   4 +-
 .../selftests/bpf/progs/sockmap_verdict_prog.c     |   4 +-
 .../testing/selftests/bpf/progs/sockopt_inherit.c  |   2 +-
 tools/testing/selftests/bpf/progs/sockopt_multi.c  |   2 +-
 tools/testing/selftests/bpf/progs/sockopt_sk.c     |   2 +-
 tools/testing/selftests/bpf/progs/strobemeta.h     |   2 +-
 tools/testing/selftests/bpf/progs/tailcall1.c      |   2 +-
 tools/testing/selftests/bpf/progs/tailcall2.c      |   2 +-
 tools/testing/selftests/bpf/progs/tailcall3.c      |   2 +-
 tools/testing/selftests/bpf/progs/tailcall4.c      |   2 +-
 tools/testing/selftests/bpf/progs/tailcall5.c      |   2 +-
 tools/testing/selftests/bpf/progs/tcp_rtt.c        |   2 +-
 .../testing/selftests/bpf/progs/test_adjust_tail.c |   2 +-
 .../selftests/bpf/progs/test_attach_probe.c        |   2 +-
 tools/testing/selftests/bpf/progs/test_btf_haskv.c |   2 +-
 tools/testing/selftests/bpf/progs/test_btf_newkv.c |   2 +-
 tools/testing/selftests/bpf/progs/test_btf_nokv.c  |   2 +-
 .../testing/selftests/bpf/progs/test_core_extern.c |   2 +-
 .../selftests/bpf/progs/test_core_reloc_arrays.c   |   4 +-
 .../bpf/progs/test_core_reloc_bitfields_direct.c   |   4 +-
 .../bpf/progs/test_core_reloc_bitfields_probed.c   |   4 +-
 .../bpf/progs/test_core_reloc_existence.c          |   4 +-
 .../selftests/bpf/progs/test_core_reloc_flavors.c  |   4 +-
 .../selftests/bpf/progs/test_core_reloc_ints.c     |   4 +-
 .../selftests/bpf/progs/test_core_reloc_kernel.c   |   4 +-
 .../selftests/bpf/progs/test_core_reloc_misc.c     |   4 +-
 .../selftests/bpf/progs/test_core_reloc_mods.c     |   4 +-
 .../selftests/bpf/progs/test_core_reloc_nesting.c  |   4 +-
 .../bpf/progs/test_core_reloc_primitives.c         |   4 +-
 .../bpf/progs/test_core_reloc_ptr_as_arr.c         |   4 +-
 .../selftests/bpf/progs/test_core_reloc_size.c     |   4 +-
 .../selftests/bpf/progs/test_get_stack_rawtp.c     |   2 +-
 .../testing/selftests/bpf/progs/test_global_data.c |   2 +-
 .../selftests/bpf/progs/test_global_func1.c        |  45 +
 .../selftests/bpf/progs/test_global_func2.c        |   4 +
 .../selftests/bpf/progs/test_global_func3.c        |  65 ++
 .../selftests/bpf/progs/test_global_func4.c        |   4 +
 .../selftests/bpf/progs/test_global_func5.c        |  31 +
 .../selftests/bpf/progs/test_global_func6.c        |  31 +
 .../selftests/bpf/progs/test_global_func7.c        |  18 +
 tools/testing/selftests/bpf/progs/test_l4lb.c      |   4 +-
 .../selftests/bpf/progs/test_l4lb_noinline.c       |   4 +-
 .../selftests/bpf/progs/test_lirc_mode2_kern.c     |   2 +-
 .../selftests/bpf/progs/test_lwt_ip_encap.c        |   4 +-
 .../selftests/bpf/progs/test_lwt_seg6local.c       |   4 +-
 .../testing/selftests/bpf/progs/test_map_in_map.c  |   2 +-
 tools/testing/selftests/bpf/progs/test_map_lock.c  |   2 +-
 tools/testing/selftests/bpf/progs/test_mmap.c      |   2 +-
 tools/testing/selftests/bpf/progs/test_obj_id.c    |   2 +-
 tools/testing/selftests/bpf/progs/test_overhead.c  |  34 +-
 .../testing/selftests/bpf/progs/test_perf_buffer.c |   5 +-
 tools/testing/selftests/bpf/progs/test_pinning.c   |   2 +-
 .../selftests/bpf/progs/test_pinning_invalid.c     |   2 +-
 .../testing/selftests/bpf/progs/test_pkt_access.c  |  38 +-
 .../selftests/bpf/progs/test_pkt_md_access.c       |   2 +-
 .../testing/selftests/bpf/progs/test_probe_user.c  |   7 +-
 .../selftests/bpf/progs/test_queue_stack_map.h     |   2 +-
 .../testing/selftests/bpf/progs/test_rdonly_maps.c |   2 +-
 tools/testing/selftests/bpf/progs/test_seg6_loop.c |   4 +-
 .../bpf/progs/test_select_reuseport_kern.c         |   4 +-
 .../selftests/bpf/progs/test_send_signal_kern.c    |  55 +-
 .../selftests/bpf/progs/test_sk_lookup_kern.c      |   4 +-
 .../selftests/bpf/progs/test_skb_cgroup_id_kern.c  |   2 +-
 tools/testing/selftests/bpf/progs/test_skb_ctx.c   |   2 +-
 tools/testing/selftests/bpf/progs/test_skeleton.c  |   2 +-
 .../selftests/bpf/progs/test_sock_fields_kern.c    |   4 +-
 tools/testing/selftests/bpf/progs/test_spin_lock.c |   2 +-
 .../selftests/bpf/progs/test_stacktrace_build_id.c |   2 +-
 .../selftests/bpf/progs/test_stacktrace_map.c      |   2 +-
 .../selftests/bpf/progs/test_sysctl_loop1.c        |   2 +-
 .../selftests/bpf/progs/test_sysctl_loop2.c        |   2 +-
 .../testing/selftests/bpf/progs/test_sysctl_prog.c |   2 +-
 tools/testing/selftests/bpf/progs/test_tc_edt.c    |   4 +-
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c |   4 +-
 .../bpf/progs/test_tcp_check_syncookie_kern.c      |   4 +-
 .../testing/selftests/bpf/progs/test_tcp_estats.c  |   2 +-
 .../testing/selftests/bpf/progs/test_tcpbpf_kern.c |   4 +-
 .../selftests/bpf/progs/test_tcpnotify_kern.c      |   4 +-
 .../testing/selftests/bpf/progs/test_tracepoint.c  |   2 +-
 .../testing/selftests/bpf/progs/test_tunnel_kern.c |   4 +-
 .../selftests/bpf/progs/test_verif_scale1.c        |   2 +-
 .../selftests/bpf/progs/test_verif_scale2.c        |   2 +-
 .../selftests/bpf/progs/test_verif_scale3.c        |   2 +-
 tools/testing/selftests/bpf/progs/test_xdp.c       |   4 +-
 .../testing/selftests/bpf/progs/test_xdp_bpf2bpf.c |  44 +
 tools/testing/selftests/bpf/progs/test_xdp_loop.c  |   4 +-
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |   2 +-
 .../selftests/bpf/progs/test_xdp_noinline.c        |   8 +-
 .../selftests/bpf/progs/test_xdp_redirect.c        |   2 +-
 tools/testing/selftests/bpf/progs/test_xdp_vlan.c  |   4 +-
 tools/testing/selftests/bpf/progs/xdp_dummy.c      |   2 +-
 .../testing/selftests/bpf/progs/xdp_redirect_map.c |   2 +-
 tools/testing/selftests/bpf/progs/xdp_tx.c         |   2 +-
 tools/testing/selftests/bpf/progs/xdping_kern.c    |   4 +-
 tools/testing/selftests/bpf/test_btf.c             |   4 -
 tools/testing/selftests/bpf/test_cpp.cpp           |   6 +-
 tools/testing/selftests/bpf/test_hashmap.c         |   2 +-
 tools/testing/selftests/bpf/test_progs.c           |  83 +-
 tools/testing/selftests/bpf/test_progs.h           |  10 +-
 tools/testing/selftests/bpf/test_sock.c            |   2 +-
 tools/testing/selftests/bpf/test_sockmap_kern.h    |   4 +-
 tools/testing/selftests/bpf/test_sysctl.c          |   2 +-
 tools/testing/selftests/bpf/trace_helpers.h        |   2 +-
 320 files changed, 7532 insertions(+), 1448 deletions(-)
 create mode 100644 kernel/bpf/bpf_struct_ops.c
 create mode 100644 kernel/bpf/bpf_struct_ops_types.h
 create mode 100644 net/ipv4/bpf_tcp_ca.c
 create mode 100644 tools/bpf/runqslower/.gitignore
 create mode 100644 tools/bpf/runqslower/Makefile
 create mode 100644 tools/bpf/runqslower/runqslower.bpf.c
 create mode 100644 tools/bpf/runqslower/runqslower.c
 create mode 100644 tools/bpf/runqslower/runqslower.h
 create mode 100644 tools/testing/selftests/bpf/bpf_tcp_helpers.h
 create mode 100644 tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
 create mode 100644 tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_cubic.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_dctcp.c
 create mode 100644 tools/testing/selftests/bpf/progs/pyperf_global.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func1.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func2.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func3.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func4.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func5.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func6.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func7.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_bpf2bpf.c
