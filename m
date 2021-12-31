Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A28A48219E
	for <lists+bpf@lfdr.de>; Fri, 31 Dec 2021 03:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbhLaCra (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Dec 2021 21:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbhLaCra (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Dec 2021 21:47:30 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40082C061574
        for <bpf@vger.kernel.org>; Thu, 30 Dec 2021 18:47:30 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id i8so14287178pgt.13
        for <bpf@vger.kernel.org>; Thu, 30 Dec 2021 18:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ljsTy0/lXS5vYDdOuU1VbvXH9VCUGn4ietTgafdwqY=;
        b=TGy2Sxwc6Uw87FGm4jzv9k8Ywhjgs8ZUlSc+EDS9Ze8+pnXfR+Kbv8u+zm7cDZ713S
         /OCre3Z1ILxkqQR95tJwSmDBPHdcw6J9fEUfAyByIZsbW6PbpyuxoivjtzVGwaQVu1tv
         7jB9EPKV+AmANgtEsv5+GbF/emN+xCCDjzCVcCZU5lvwa8rbn6s8qBiXmS3+d+fAexFs
         XWcuIZMnJXoBHrTUc2/IrFqLdK+RiF78lJyCwUmMxzIgpuXCGCvvfzkGOZegJUCb5aDM
         jq2MagKuq2J//J5SywEtBf/s1GWndlnPvp0Ha+lgjpSXqZoq95aw34HEAydyiiK9uq0x
         Hy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ljsTy0/lXS5vYDdOuU1VbvXH9VCUGn4ietTgafdwqY=;
        b=YYMSJmg9L37TtwK/en7EHmWdZ/gMXxgXwv33DAazlmwW/67Q9eFxWa1CTG1rrvdt0u
         l5sBPtBdqZqdWkooieefQBemNM3MavMROvzdFEt6BUqviPd2zDx7pnhmDd4msE7Sd+fX
         KiH2R2V1/LIkQNWptSupWisGndM1JfxnIn8ZG5fswIKbV8A4uuyx/THTuh4lZ+tSetcW
         5oV2fn65cebWKXldHK37RKD4uM8t3xatrxSjjShq4Yvgz4VXixCOmbqgQIStWZ3kILJx
         fQPhb2ugOjImJpSpo6A1ZO92QpjNNLpfM/PaMkveuwdCBvathnmcZVs5mjmaEJ0vSS3Y
         i2dA==
X-Gm-Message-State: AOAM530QBDWTp+2Hf4Ykzrk+RtttJhO3GPXwvH0moA8hmeZEQ8lq6BGG
        6KHcIapvHGnLZgoFSkHHkSAI6VhjOq4=
X-Google-Smtp-Source: ABdhPJxSVF/SvE3sWnDhht4yW0PVxFVAImuaTKEMuqYU2ijRkiGA6CFcm2T7z+quS/y/kzfDyDf7CA==
X-Received: by 2002:a05:6a00:1485:b0:4bb:317a:a909 with SMTP id v5-20020a056a00148500b004bb317aa909mr34383769pfu.29.1640918849515;
        Thu, 30 Dec 2021 18:47:29 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:4e61])
        by smtp.gmail.com with ESMTPSA id a21sm28042194pfg.204.2021.12.30.18.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 18:47:29 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, kuba@kernel.org, andrii@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: pull-request: bpf-next 2021-12-30
Date:   Thu, 30 Dec 2021 18:47:27 -0800
Message-Id: <20211231024727.68955-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David, hi Jakub,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 72 non-merge commits during the last 20 day(s) which contain
a total of 223 files changed, 3510 insertions(+), 1591 deletions(-).

The main changes are:

1) Automatic setrlimit in libbpf when bpf is memcg's in the kernel, from Andrii.

2) Beautify and de-verbose verifier logs, from Christy.

3) Composable verifier types, from Hao.

4) bpf_strncmp helper, from Hou.

5) bpf.h header dependency cleanup, from Jakub.

6) get_func_[arg|ret|arg_cnt] helpers, from Jiri.

7) Sleepable local storage, from KP.

8) Extend kfunc with PTR_TO_CTX, PTR_TO_MEM argument support, from Kumar.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Abaci Robot, Andrii Nakryiko, Dave Marchevsky, Emmanuel Deloget, Florian 
Fainelli, Ilya Leoshkevich, Joanne Koong, John Fastabend, Lorenzo 
Fontana, Magnus Karlsson, Marc Kleine-Budde, Martin KaFai Lau, Nick 
Desaulniers, Nikolay Aleksandrov, Quentin Monnet, Stefano Garzarella, 
TCS Robot, Tejun Heo, Toke Høiland-Jørgensen, Yonghong Song

----------------------------------------------------------------

The following changes since commit 77ab714f00703c91d5a6e15d7445775c80358774:

  Merge branch 'add-fdma-support-on-ocelot-switch-driver' (2021-12-10 20:57:00 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git 

for you to fetch changes up to 9e6b19a66d9b6b94395478fe79c5a3ccba181ad3:

  bpf: Fix typo in a comment in bpf lpm_trie. (2021-12-30 18:42:34 -0800)

----------------------------------------------------------------
Alexei Starovoitov (8):
      libbpf: Fix gen_loader assumption on number of programs.
      Merge branch 'introduce bpf_strncmp() helper'
      bpf: Silence coverity false positive warning.
      Merge branch 'bpf: Add helpers to access traced function arguments'
      Merge branch 'bpf: remove the cgroup -> bpf header dependecy'
      Merge branch 'Introduce composable bpf types'
      Merge branch 'Sleepable local storage'
      Merge branch 'lighten uapi/bpf.h rebuilds'

Andrii Nakryiko (15):
      selftests/bpf: Remove last bpf_create_map_xattr from test_verifier
      libbpf: Don't validate TYPE_ID relo's original imm value
      libbpf: Fix potential uninit memory read
      libbpf: Add sane strncpy alternative and use it internally
      libbpf: Auto-bump RLIMIT_MEMLOCK if kernel needs it for BPF
      selftests/bpf: Remove explicit setrlimit(RLIMIT_MEMLOCK) in main selftests
      Merge branch 'Stop using bpf_object__find_program_by_title API'
      libbpf: Avoid reading past ELF data section end when copying license
      Merge branch 'tools/bpf: Enable cross-building with clang'
      libbpf: Rework feature-probing APIs
      selftests/bpf: Add libbpf feature-probing API selftests
      bpftool: Reimplement large insn size limit feature probing
      libbpf: Normalize PT_REGS_xxx() macro definitions
      libbpf: Use 100-character limit to make bpf_tracing.h easier to read
      libbpf: Improve LINUX_VERSION_CODE detection

Christoph Hellwig (4):
      bpf, docs: Fix verifier references
      bpf, docs: Split the comparism to classic BPF from instruction-set.rst
      bpf, docs: Generate nicer tables for instruction encodings
      bpf, docs: Move the packet access instructions last in instruction-set.rst

Christy Lee (3):
      bpf: Only print scratched registers and stack slots to verifier logs.
      bpf: Right align verifier states in verifier logs.
      Only output backtracking information in log level 2

Grant Seltzer (1):
      libbpf: Add doc comments for bpf_program__(un)pin()

Haimin Zhang (1):
      bpf: Add missing map_get_next_key method to bloom filter map.

Hao Luo (9):
      bpf: Introduce composable reg, ret and arg types.
      bpf: Replace ARG_XXX_OR_NULL with ARG_XXX | PTR_MAYBE_NULL
      bpf: Replace RET_XXX_OR_NULL with RET_XXX | PTR_MAYBE_NULL
      bpf: Replace PTR_TO_XXX_OR_NULL with PTR_TO_XXX | PTR_MAYBE_NULL
      bpf: Introduce MEM_RDONLY flag
      bpf: Convert PTR_TO_MEM_OR_NULL to composable types.
      bpf: Make per_cpu_ptr return rdonly PTR_TO_MEM.
      bpf: Add MEM_RDONLY for helper args that are pointers to rdonly mem.
      bpf/selftests: Test PTR_TO_RDONLY_MEM

Hou Tao (4):
      bpf: Add bpf_strncmp helper
      selftests/bpf: Fix checkpatch error on empty function parameter
      selftests/bpf: Add benchmark for bpf_strncmp() helper
      selftests/bpf: Add test cases for bpf_strncmp()

Jakub Kicinski (6):
      add includes masked by cgroup -> bpf dependency
      add missing bpf-cgroup.h includes
      bpf: Remove the cgroup -> bpf header dependecy
      net: Don't include filter.h from net/sock.h
      net: Add includes masked by netdevice.h including uapi/bpf.h
      bpf: Invert the dependency between bpf-netns.h and netns/bpf.h

Jean-Philippe Brucker (7):
      selftests/bpf: Fix segfault in bpf_tcp_ca
      tools: Help cross-building with clang
      tools/resolve_btfids: Support cross-building the kernel with clang
      tools/libbpf: Enable cross-building with clang
      bpftool: Enable cross-building with clang
      tools/runqslower: Enable cross-building with clang
      selftests/bpf: Enable cross-building with clang

Jiapeng Chong (1):
      bpf: Use kmemdup() to replace kmalloc + memcpy

Jiri Olsa (7):
      bpf: Allow access to int pointer arguments in tracing programs
      selftests/bpf: Add test to access int ptr argument in tracing program
      bpf, x64: Replace some stack_size usage with offset variables
      bpf: Add get_func_[arg|ret|arg_cnt] helpers
      selftests/bpf: Add tests for get_func_[arg|ret|arg_cnt] helpers
      libbpf: Do not use btf_dump__new() macro in C++ mode
      selftests/bpf: Add btf_dump__new to test_cpp

KP Singh (2):
      bpf: Allow bpf_local_storage to be used by sleepable programs
      bpf/selftests: Update local storage selftest for sleepable programs

Kui-Feng Lee (4):
      selftests/bpf: Stop using bpf_object__find_program_by_title API.
      samples/bpf: Stop using bpf_object__find_program_by_title API.
      tools/perf: Stop using bpf_object__find_program_by_title API.
      libbpf: Mark bpf_object__find_program_by_title API deprecated.

Kumar Kartikeya Dwivedi (1):
      bpf: Extend kfunc with PTR_TO_CTX, PTR_TO_MEM argument support

Leon Huayra (1):
      bpf: Fix typo in a comment in bpf lpm_trie.

Maciej Fijalkowski (1):
      xsk: Wipe out dead zero_copy_allocator declarations

Paolo Abeni (2):
      bpf: Do not WARN in bpf_warn_invalid_xdp_action()
      bpf: Let bpf_warn_invalid_xdp_action() report more info

Paul Chaignon (1):
      bpftool: Enable line buffering for stdout

Pu Lehui (1):
      selftests/bpf: Correct the INDEX address in vmtest.sh

Xiu Jianfeng (1):
      bpf: Use struct_size() helper

 Documentation/bpf/classic_vs_extended.rst          | 376 +++++++++++
 Documentation/bpf/index.rst                        |   1 +
 Documentation/bpf/instruction-set.rst              | 514 +++++----------
 arch/s390/mm/hugetlbpage.c                         |   1 +
 arch/x86/net/bpf_jit_comp.c                        |  55 +-
 drivers/bluetooth/btqca.c                          |   1 +
 drivers/infiniband/core/cache.c                    |   1 +
 drivers/infiniband/hw/irdma/ctrl.c                 |   2 +
 drivers/infiniband/hw/irdma/uda.c                  |   2 +
 drivers/infiniband/hw/mlx5/doorbell.c              |   1 +
 drivers/infiniband/hw/mlx5/qp.c                    |   1 +
 drivers/net/amt.c                                  |   1 +
 drivers/net/appletalk/ipddp.c                      |   1 +
 drivers/net/bonding/bond_main.c                    |   1 +
 drivers/net/can/usb/peak_usb/pcan_usb.c            |   1 +
 drivers/net/dsa/microchip/ksz8795.c                |   1 +
 drivers/net/dsa/xrs700x/xrs700x.c                  |   1 +
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   2 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.h       |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c  |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |   2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |   2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |   1 +
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |   2 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |   2 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       |   2 +-
 drivers/net/ethernet/huawei/hinic/hinic_tx.c       |   1 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.h         |   1 -
 drivers/net/ethernet/intel/ice/ice_devlink.c       |   2 +
 drivers/net/ethernet/intel/ice/ice_txrx.c          |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c      |   2 +
 drivers/net/ethernet/intel/ice/ice_xsk.c           |   2 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   2 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   2 +-
 drivers/net/ethernet/intel/igc/igc_xdp.c           |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_txrx_common.h   |   2 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       |   2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |   2 +-
 drivers/net/ethernet/marvell/mvneta.c              |   2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |   2 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |   1 +
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c   |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |   2 +-
 drivers/net/ethernet/microsoft/mana/mana_bpf.c     |   2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   2 +
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |   2 +-
 drivers/net/ethernet/qlogic/qede/qede_fp.c         |   2 +-
 drivers/net/ethernet/sfc/efx.c                     |   1 +
 drivers/net/ethernet/sfc/efx_channels.c            |   1 +
 drivers/net/ethernet/sfc/efx_common.c              |   1 +
 drivers/net/ethernet/sfc/rx.c                      |   2 +-
 drivers/net/ethernet/socionext/netsec.c            |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   2 +-
 drivers/net/ethernet/ti/cpsw_priv.c                |   2 +-
 drivers/net/ethernet/ti/cpsw_priv.h                |   2 +
 drivers/net/hamradio/hdlcdrv.c                     |   1 +
 drivers/net/hamradio/scc.c                         |   1 +
 drivers/net/hyperv/netvsc_bpf.c                    |   2 +-
 drivers/net/loopback.c                             |   1 +
 drivers/net/tun.c                                  |   2 +-
 drivers/net/veth.c                                 |   4 +-
 drivers/net/virtio_net.c                           |   4 +-
 drivers/net/vrf.c                                  |   1 +
 drivers/net/wireless/ath/ath11k/debugfs.c          |   2 +
 drivers/net/wireless/realtek/rtw89/debug.c         |   2 +
 drivers/net/xen-netfront.c                         |   2 +-
 fs/nfs/dir.c                                       |   1 +
 fs/nfs/fs_context.c                                |   1 +
 fs/select.c                                        |   1 +
 include/linux/bpf-cgroup-defs.h                    |  70 +++
 include/linux/bpf-cgroup.h                         |  57 +-
 include/linux/bpf-netns.h                          |   8 +-
 include/linux/bpf.h                                | 107 +++-
 include/linux/bpf_local_storage.h                  |   6 +
 include/linux/bpf_verifier.h                       |  27 +
 include/linux/cgroup-defs.h                        |   2 +-
 include/linux/dsa/loop.h                           |   1 +
 include/linux/filter.h                             |   2 +-
 include/linux/perf_event.h                         |   1 +
 include/net/ip6_fib.h                              |   1 +
 include/net/ipv6.h                                 |   2 +
 include/net/netns/bpf.h                            |   9 +-
 include/net/route.h                                |   1 +
 include/net/sock.h                                 |   2 +-
 include/net/xdp_priv.h                             |   1 -
 include/net/xdp_sock.h                             |   1 +
 include/uapi/linux/bpf.h                           |  39 ++
 kernel/bpf/bloom_filter.c                          |   6 +
 kernel/bpf/bpf_inode_storage.c                     |   6 +-
 kernel/bpf/bpf_local_storage.c                     |  50 +-
 kernel/bpf/bpf_task_storage.c                      |   6 +-
 kernel/bpf/btf.c                                   | 124 ++--
 kernel/bpf/cgroup.c                                |   2 +-
 kernel/bpf/cpumap.c                                |   4 +-
 kernel/bpf/devmap.c                                |   4 +-
 kernel/bpf/helpers.c                               |  29 +-
 kernel/bpf/local_storage.c                         |   3 +-
 kernel/bpf/lpm_trie.c                              |   2 +-
 kernel/bpf/map_iter.c                              |   4 +-
 kernel/bpf/net_namespace.c                         |   1 +
 kernel/bpf/reuseport_array.c                       |   6 +-
 kernel/bpf/ringbuf.c                               |   2 +-
 kernel/bpf/syscall.c                               |   3 +-
 kernel/bpf/trampoline.c                            |   8 +
 kernel/bpf/verifier.c                              | 696 ++++++++++++---------
 kernel/cgroup/cgroup.c                             |   1 +
 kernel/sysctl.c                                    |   1 +
 kernel/trace/bpf_trace.c                           |  81 ++-
 kernel/trace/trace_kprobe.c                        |   1 +
 kernel/trace/trace_uprobe.c                        |   1 +
 net/bluetooth/bnep/sock.c                          |   1 +
 net/bluetooth/eir.h                                |   2 +
 net/bluetooth/hidp/sock.c                          |   1 +
 net/bluetooth/l2cap_sock.c                         |   1 +
 net/bridge/br_ioctl.c                              |   1 +
 net/caif/caif_socket.c                             |   1 +
 net/core/bpf_sk_storage.c                          |  10 +-
 net/core/dev.c                                     |   2 +-
 net/core/devlink.c                                 |   1 +
 net/core/filter.c                                  |  72 +--
 net/core/flow_dissector.c                          |   1 +
 net/core/lwt_bpf.c                                 |   1 +
 net/core/sock_diag.c                               |   1 +
 net/core/sock_map.c                                |   2 +-
 net/core/sysctl_net_core.c                         |   1 +
 net/decnet/dn_nsp_in.c                             |   1 +
 net/dsa/dsa_priv.h                                 |   1 +
 net/ethtool/ioctl.c                                |   1 +
 net/ipv4/nexthop.c                                 |   1 +
 net/ipv4/udp.c                                     |   1 +
 net/ipv6/ip6_fib.c                                 |   1 +
 net/ipv6/seg6_local.c                              |   1 +
 net/ipv6/udp.c                                     |   1 +
 net/iucv/af_iucv.c                                 |   1 +
 net/kcm/kcmsock.c                                  |   1 +
 net/netfilter/nfnetlink_hook.c                     |   1 +
 net/netfilter/nft_reject_netdev.c                  |   1 +
 net/netlink/af_netlink.c                           |   2 +
 net/packet/af_packet.c                             |   1 +
 net/rose/rose_in.c                                 |   1 +
 net/sched/sch_frag.c                               |   1 +
 net/smc/smc_ib.c                                   |   2 +
 net/smc/smc_ism.c                                  |   1 +
 net/socket.c                                       |   1 +
 net/unix/af_unix.c                                 |   1 +
 net/vmw_vsock/af_vsock.c                           |   1 +
 net/xdp/xskmap.c                                   |   1 +
 net/xfrm/xfrm_state.c                              |   1 +
 net/xfrm/xfrm_user.c                               |   1 +
 samples/bpf/hbm.c                                  |  11 +-
 samples/bpf/xdp_fwd_user.c                         |  12 +-
 security/device_cgroup.c                           |   1 +
 tools/bpf/bpftool/Makefile                         |  13 +-
 tools/bpf/bpftool/feature.c                        |  26 +-
 tools/bpf/bpftool/main.c                           |   2 +
 tools/bpf/resolve_btfids/Makefile                  |   1 +
 tools/bpf/runqslower/Makefile                      |   4 +-
 tools/include/uapi/linux/bpf.h                     |  39 ++
 tools/lib/bpf/Makefile                             |   3 +-
 tools/lib/bpf/bpf.c                                |  85 ++-
 tools/lib/bpf/bpf.h                                |   2 +
 tools/lib/bpf/bpf_tracing.h                        | 431 ++++++-------
 tools/lib/bpf/btf.h                                |   6 +
 tools/lib/bpf/btf_dump.c                           |   4 +-
 tools/lib/bpf/gen_loader.c                         |  11 +-
 tools/lib/bpf/libbpf.c                             |  85 ++-
 tools/lib/bpf/libbpf.h                             |  77 ++-
 tools/lib/bpf/libbpf.map                           |   4 +
 tools/lib/bpf/libbpf_internal.h                    |  60 ++
 tools/lib/bpf/libbpf_legacy.h                      |  12 +-
 tools/lib/bpf/libbpf_probes.c                      | 251 ++++++--
 tools/lib/bpf/relo_core.c                          |  20 +-
 tools/lib/bpf/xsk.c                                |   9 +-
 tools/perf/builtin-trace.c                         |  13 +-
 tools/scripts/Makefile.include                     |  13 +-
 tools/testing/selftests/bpf/Makefile               |  12 +-
 tools/testing/selftests/bpf/bench.c                |  24 +-
 tools/testing/selftests/bpf/bench.h                |   9 +-
 tools/testing/selftests/bpf/benchs/bench_count.c   |   2 +-
 tools/testing/selftests/bpf/benchs/bench_rename.c  |  16 +-
 .../testing/selftests/bpf/benchs/bench_ringbufs.c  |  14 +-
 tools/testing/selftests/bpf/benchs/bench_strncmp.c | 161 +++++
 tools/testing/selftests/bpf/benchs/bench_trigger.c |  24 +-
 .../selftests/bpf/benchs/run_bench_strncmp.sh      |  12 +
 tools/testing/selftests/bpf/config                 |   2 +
 tools/testing/selftests/bpf/prog_tests/align.c     | 191 +++---
 .../testing/selftests/bpf/prog_tests/bpf_obj_id.c  |   4 +-
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  |   7 +-
 tools/testing/selftests/bpf/prog_tests/btf.c       |   1 -
 .../selftests/bpf/prog_tests/connect_force_port.c  |  18 +-
 .../testing/selftests/bpf/prog_tests/core_reloc.c  |  79 ++-
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c       |  17 +-
 .../selftests/bpf/prog_tests/get_func_args_test.c  |  44 ++
 .../selftests/bpf/prog_tests/get_stack_raw_tp.c    |   4 +-
 tools/testing/selftests/bpf/prog_tests/ksyms_btf.c |  14 +
 .../selftests/bpf/prog_tests/libbpf_probes.c       | 124 ++++
 .../selftests/bpf/prog_tests/select_reuseport.c    |   1 -
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c |   1 -
 .../testing/selftests/bpf/prog_tests/sock_fields.c |   1 -
 .../selftests/bpf/prog_tests/sockopt_inherit.c     |  15 +-
 .../selftests/bpf/prog_tests/stacktrace_map.c      |   4 +-
 .../bpf/prog_tests/stacktrace_map_raw_tp.c         |   4 +-
 .../selftests/bpf/prog_tests/test_local_storage.c  |  20 +-
 .../selftests/bpf/prog_tests/test_overhead.c       |  20 +-
 .../selftests/bpf/prog_tests/test_strncmp.c        | 167 +++++
 .../selftests/bpf/prog_tests/trampoline_count.c    |   6 +-
 .../selftests/bpf/progs/get_func_args_test.c       | 123 ++++
 tools/testing/selftests/bpf/progs/local_storage.c  |  24 +-
 tools/testing/selftests/bpf/progs/strncmp_bench.c  |  50 ++
 tools/testing/selftests/bpf/progs/strncmp_test.c   |  54 ++
 .../bpf/progs/test_ksyms_btf_write_check.c         |  29 +
 tools/testing/selftests/bpf/test_cpp.cpp           |   9 +-
 tools/testing/selftests/bpf/test_maps.c            |   1 -
 tools/testing/selftests/bpf/test_progs.c           |   2 -
 tools/testing/selftests/bpf/test_verifier.c        |  18 +-
 .../selftests/bpf/verifier/btf_ctx_access.c        |  12 +
 tools/testing/selftests/bpf/vmtest.sh              |   2 +-
 223 files changed, 3510 insertions(+), 1591 deletions(-)
 create mode 100644 Documentation/bpf/classic_vs_extended.rst
 create mode 100644 include/linux/bpf-cgroup-defs.h
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_strncmp.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_strncmp.sh
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_strncmp.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_args_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/strncmp_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/strncmp_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c
 create mode 100644 tools/testing/selftests/bpf/verifier/btf_ctx_access.c
