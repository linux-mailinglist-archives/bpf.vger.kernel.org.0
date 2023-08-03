Return-Path: <bpf+bounces-6885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E502276F0E1
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 19:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1A01C20456
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 17:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EE925173;
	Thu,  3 Aug 2023 17:48:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193C01F16D
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 17:48:56 +0000 (UTC)
Received: from out-91.mta1.migadu.com (out-91.mta1.migadu.com [IPv6:2001:41d0:203:375::5b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C7726B0
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 10:48:54 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691084933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ese9rTcUWizGRMmz+MjMiatxAhII0KNkiJC2ZZz7Wzs=;
	b=X1MC5FUYLKJuyHM8g8LD9LwBdHm6oRRM04W3axmlsIdUQZf0nXU2YlmSx/DKRSN53P5d14
	eseXrm0CQZkfQ7f5ipFqglToVyoiffUpkfzsx2erdqXDcAZ82Z2jH/lCPfce/2r9GINmiC
	swbejnV+88pFNwPcGD/dQTbxdwN3dRg=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ast@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf-next 2023-08-03
Date: Thu,  3 Aug 2023 10:48:45 -0700
Message-Id: <20230803174845.825419-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 54 non-merge commits during the last 10 day(s) which contain
a total of 84 files changed, 4026 insertions(+), 562 deletions(-).

The main changes are:

1) Add SO_REUSEPORT support for TC bpf_sk_assign from Lorenz Bauer,
   Daniel Borkmann

2) Support new insns from cpu v4 from Yonghong Song

3) Non-atomically allocate freelist during prefill from YiFei Zhu

4) Support defragmenting IPv(4|6) packets in BPF from Daniel Xu

5) Add tracepoint to xdp attaching failure from Leon Hwang

6) struct netdev_rx_queue and xdp.h reshuffling to reduce
   rebuild time from Jakub Kicinski

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Amritha Nambiar, Björn Töpel, Colm Harrington, Dave Thaler, David 
Vernet, Eduard Zingerman, Florian Westphal, Gerhard Engleder, Hou Tao, 
Jesper Dangaard Brouer, Jiri Olsa, Kuniyuki Iwashima, 
Quentin Monnet, Wei Fang, Yipeng Zou, Yonghong Song

----------------------------------------------------------------

The following changes since commit dc644b540a2d2874112706591234be3d3fbf9ef7:

  tcx: Fix splat in ingress_destroy upon tcx_entry_free (2023-07-24 11:42:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 648880e9331c68b2008430fd90f3648d1795399d:

  Merge branch 'net: struct netdev_rx_queue and xdp.h reshuffling' (2023-08-03 08:38:53 -0700)

----------------------------------------------------------------
pull-request: bpf-next 2023-08-03

----------------------------------------------------------------
Alan Maguire (1):
      selftests/bpf: fix static assert compilation issue for test_cls_*.c

Alexei Starovoitov (3):
      Merge branch 'bpf-support-new-insns-from-cpu-v4'
      Merge branch 'support-defragmenting-ipv-4-6-packets-in-bpf'
      Merge branch 'bpf-xdp-add-tracepoint-to-xdp-attaching-failure'

Arnd Bergmann (2):
      bpf: work around -Wuninitialized warning
      bpf: fix bpf_probe_read_kernel prototype mismatch

Colin Ian King (1):
      selftests/xsk: Fix spelling mistake "querrying" -> "querying"

Daniel Borkmann (1):
      selftests/bpf: Test that SO_REUSEPORT can be used with sk_assign helper

Daniel Xu (6):
      netfilter: defrag: Add glue hooks for enabling/disabling defrag
      netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link
      bpf: selftests: Support not connecting client socket
      bpf: selftests: Support custom type and proto for client sockets
      bpf: selftests: Add defrag selftests
      netfilter: bpf: Only define get_proto_defrag_hook() if necessary

Hou Tao (2):
      bpf, cpumap: Remove unused cmap field from bpf_cpu_map_entry
      bpf, devmap: Remove unused dtab field from bpf_dtab_netdev

Jakub Kicinski (3):
      eth: add missing xdp.h includes in drivers
      net: move struct netdev_rx_queue out of netdevice.h
      net: invert the netdevice.h vs xdp.h dependency

Jose E. Marchesi (1):
      bpf, docs: fix BPF_NEG entry in instruction-set.rst

Leon Hwang (2):
      bpf, xdp: Add tracepoint to xdp attaching failure
      selftests/bpf: Add testcase for xdp attaching failure tracepoint

Lorenz Bauer (8):
      udp: re-score reuseport groups when connected sockets are present
      bpf: reject unhashed sockets in bpf_sk_assign
      net: export inet_lookup_reuseport and inet6_lookup_reuseport
      net: remove duplicate reuseport_lookup functions
      net: document inet[6]_lookup_reuseport sk_state requirements
      net: remove duplicate sk_lookup helpers
      bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign
      net: remove duplicate INDIRECT_CALLABLE_DECLARE of udp[6]_ehashfn

Martin KaFai Lau (3):
      Merge branch 'Add SO_REUSEPORT support for TC bpf_sk_assign'
      Merge branch 'Remove unused fields in cpumap & devmap'
      Merge branch 'net: struct netdev_rx_queue and xdp.h reshuffling'

Pu Lehui (1):
      riscv, bpf: Adapt bpf trampoline to optimized riscv ftrace framework

Randy Dunlap (1):
      libbpf: fix typos in Makefile

Yauheni Kaliuta (1):
      tracing: bpf: use struct trace_entry in struct syscall_tp_t

YiFei Zhu (1):
      bpf: Non-atomically allocate freelist during prefill

Yonghong Song (23):
      MAINTAINERS: Replace my email address
      bpf: Support new sign-extension load insns
      bpf: Support new sign-extension mov insns
      bpf: Handle sign-extenstin ctx member accesses
      bpf: Support new unconditional bswap instruction
      bpf: Support new signed div/mod instructions.
      bpf: Fix jit blinding with new sdiv/smov insns
      bpf: Support new 32bit offset jmp instruction
      bpf: Add kernel/bpftool asm support for new instructions
      selftests/bpf: Fix a test_verifier failure
      selftests/bpf: Add a cpuv4 test runner for cpu=v4 testing
      selftests/bpf: Add unit tests for new sign-extension load insns
      selftests/bpf: Add unit tests for new sign-extension mov insns
      selftests/bpf: Add unit tests for new bswap insns
      selftests/bpf: Add unit tests for new sdiv/smod insns
      selftests/bpf: Add unit tests for new gotol insn
      selftests/bpf: Test ldsx with more complex cases
      docs/bpf: Add documentation for new instructions
      bpf: Fix compilation warning with -Wparentheses
      selftests/bpf: Enable test test_progs-cpuv4 for gcc build kernel
      docs/bpf: Improve documentation for cpu=v4 instructions
      docs/bpf: Fix malformed documentation
      bpf: Fix an array-index-out-of-bounds issue in disasm.c

 Documentation/bpf/bpf_design_QA.rst                |   5 -
 .../bpf/standardization/instruction-set.rst        | 130 +++-
 MAINTAINERS                                        |   4 +-
 arch/riscv/net/bpf_jit_comp64.c                    | 153 ++--
 arch/x86/net/bpf_jit_comp.c                        | 141 +++-
 drivers/net/bonding/bond_main.c                    |   1 +
 drivers/net/ethernet/amazon/ena/ena_netdev.h       |   1 +
 drivers/net/ethernet/engleder/tsnep.h              |   1 +
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h   |   1 +
 drivers/net/ethernet/freescale/enetc/enetc.h       |   1 +
 drivers/net/ethernet/freescale/fec.h               |   1 +
 drivers/net/ethernet/fungible/funeth/funeth_txrx.h |   1 +
 drivers/net/ethernet/google/gve/gve.h              |   1 +
 drivers/net/ethernet/intel/igc/igc.h               |   1 +
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |   1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   1 +
 drivers/net/ethernet/ti/cpsw_priv.h                |   1 +
 drivers/net/hyperv/hyperv_net.h                    |   1 +
 drivers/net/tap.c                                  |   1 +
 drivers/net/virtio_net.c                           |   1 +
 include/linux/bpf.h                                |  12 +
 include/linux/filter.h                             |  34 +-
 include/linux/netdevice.h                          |  55 +-
 include/linux/netfilter.h                          |  10 +
 include/net/busy_poll.h                            |   1 +
 include/net/inet6_hashtables.h                     |  81 ++-
 include/net/inet_hashtables.h                      |  74 +-
 include/net/mana/mana.h                            |   2 +
 include/net/netdev_rx_queue.h                      |  53 ++
 include/net/sock.h                                 |   7 +-
 include/net/xdp.h                                  |  29 +-
 include/trace/events/xdp.h                         |  18 +
 include/uapi/linux/bpf.h                           |   9 +-
 kernel/bpf/btf.c                                   |   1 +
 kernel/bpf/core.c                                  | 206 +++++-
 kernel/bpf/cpumap.c                                |   3 -
 kernel/bpf/devmap.c                                |   2 -
 kernel/bpf/disasm.c                                |  58 +-
 kernel/bpf/memalloc.c                              |  24 +-
 kernel/bpf/offload.c                               |   1 +
 kernel/bpf/verifier.c                              | 349 +++++++--
 kernel/trace/bpf_trace.c                           |  11 -
 kernel/trace/trace_syscalls.c                      |  12 +-
 net/bpf/test_run.c                                 |   1 +
 net/core/dev.c                                     |   6 +-
 net/core/filter.c                                  |   4 +-
 net/core/net-sysfs.c                               |   1 +
 net/ipv4/inet_hashtables.c                         |  66 +-
 net/ipv4/netfilter/nf_defrag_ipv4.c                |  17 +-
 net/ipv4/udp.c                                     |  88 +--
 net/ipv6/inet6_hashtables.c                        |  69 +-
 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c          |  11 +
 net/ipv6/udp.c                                     |  96 +--
 net/netfilter/core.c                               |   6 +
 net/netfilter/nf_bpf_link.c                        | 125 +++-
 net/netfilter/nf_conntrack_bpf.c                   |   1 +
 net/xdp/xsk.c                                      |   1 +
 tools/include/uapi/linux/bpf.h                     |   9 +-
 tools/lib/bpf/Makefile                             |   4 +-
 tools/testing/selftests/bpf/.gitignore             |   2 +
 tools/testing/selftests/bpf/Makefile               |  33 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |   9 +-
 .../selftests/bpf/generate_udp_fragments.py        |  90 +++
 .../testing/selftests/bpf/ip_check_defrag_frags.h  |  57 ++
 tools/testing/selftests/bpf/network_helpers.c      |  29 +-
 tools/testing/selftests/bpf/network_helpers.h      |   3 +
 .../selftests/bpf/prog_tests/assign_reuse.c        | 199 ++++++
 .../selftests/bpf/prog_tests/ip_check_defrag.c     | 283 ++++++++
 .../selftests/bpf/prog_tests/test_ldsx_insn.c      | 139 ++++
 tools/testing/selftests/bpf/prog_tests/verifier.c  |  10 +
 .../testing/selftests/bpf/prog_tests/xdp_attach.c  |  65 ++
 .../testing/selftests/bpf/progs/ip_check_defrag.c  | 104 +++
 .../selftests/bpf/progs/test_assign_reuse.c        | 142 ++++
 .../selftests/bpf/progs/test_cls_redirect.h        |   9 +
 tools/testing/selftests/bpf/progs/test_ldsx_insn.c | 118 ++++
 .../selftests/bpf/progs/test_xdp_attach_fail.c     |  54 ++
 tools/testing/selftests/bpf/progs/verifier_bswap.c |  59 ++
 tools/testing/selftests/bpf/progs/verifier_gotol.c |  44 ++
 tools/testing/selftests/bpf/progs/verifier_ldsx.c  | 131 ++++
 tools/testing/selftests/bpf/progs/verifier_movsx.c | 213 ++++++
 tools/testing/selftests/bpf/progs/verifier_sdiv.c  | 781 +++++++++++++++++++++
 tools/testing/selftests/bpf/verifier/basic_instr.c |   6 +-
 tools/testing/selftests/bpf/xskxceiver.c           |   2 +-
 84 files changed, 4026 insertions(+), 562 deletions(-)
 create mode 100644 include/net/netdev_rx_queue.h
 create mode 100755 tools/testing/selftests/bpf/generate_udp_fragments.py
 create mode 100644 tools/testing/selftests/bpf/ip_check_defrag_frags.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/assign_reuse.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_ldsx_insn.c
 create mode 100644 tools/testing/selftests/bpf/progs/ip_check_defrag.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_assign_reuse.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ldsx_insn.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bswap.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_gotol.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ldsx.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_movsx.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_sdiv.c

