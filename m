Return-Path: <bpf+bounces-15763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539B37F6519
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 18:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FAD1C20F64
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 17:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCC03FE50;
	Thu, 23 Nov 2023 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwUAbNgT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F87E3FE28;
	Thu, 23 Nov 2023 17:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A23C433CC;
	Thu, 23 Nov 2023 17:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700759906;
	bh=VjB3FlEP5mzJb2iOsvQ+sI6wD44eHxHZMbdOFnxC2YI=;
	h=From:To:Cc:Subject:Date:From;
	b=kwUAbNgThF/7sGUCPWbFqIqoJMyEyEjA6Eb9UwPozhLiJ1bK5ER3+sfPl12gIHMn0
	 uoTu82pZN3VZR65XPImX0WVLqlMusGFxQctu6U8RkNTtsTmxASwxPxJCLY7Jfeyy/f
	 Vvn7L5QX0C0FiXjH53F+G0zhBJ92f4zk6Oa2Z4ka0L0Gle4ab0EhD7MppdRYjMnlm2
	 jN2vJbHYqDDwyRk67N9//+ZnIVhTKeUHe5eKtg/76Uw+ajU9IpjRC0FnvdzxARWsOq
	 nmwhT/HP39PpbBuw+YiDkn8+4SM/PPeqSuhrkrWUI82zJbOeUfoQMJWO9UxhCDzMcQ
	 4h9HzOoMiY9lQ==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	bpf@vger.kernel.org
Subject: [GIT PULL] Networking for v6.7-rc3
Date: Thu, 23 Nov 2023 09:18:25 -0800
Message-ID: <20231123171825.957077-1-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit 7475e51b87969e01a6812eac713a1c8310372e8a:

  Merge tag 'net-6.7-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-11-16 07:51:26 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc3

for you to fetch changes up to 39f04b1406b23fcc129a67e70d6205d5a7322f38:

  tools: ynl: fix duplicate op name in devlink (2023-11-23 08:52:23 -0800)

----------------------------------------------------------------
Including fixes from bpf.

Current release - regressions:

 - Revert "net: r8169: Disable multicast filter for RTL8168H
   and RTL8107E"

 - kselftest: rtnetlink: fix ip route command typo

Current release - new code bugs:

 - s390/ism: make sure ism driver implies smc protocol in kconfig

 - two build fixes for tools/net

Previous releases - regressions:

 - rxrpc: couple of ACK/PING/RTT handling fixes

Previous releases - always broken:

 - bpf: verify bpf_loop() callbacks as if they are called unknown
   number of times

 - improve stability of auto-bonding with Hyper-V

 - account BPF-neigh-redirected traffic in interface statistics

Misc:

 - net: fill in some more MODULE_DESCRIPTION()s

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alex Elder (1):
      net: ipa: fix one GSI register field width

Alexei Starovoitov (1):
      Merge branch 'verify-callbacks-as-if-they-are-called-unknown-number-of-times'

Arseniy Krasnov (1):
      vsock/test: fix SEQPACKET message bounds test

D. Wythe (1):
      net/smc: avoid data corruption caused by decline

Daniel Borkmann (6):
      net, vrf: Move dstats structure to core
      net: Move {l,t,d}stats allocation to core and convert veth & vrf
      netkit: Add tstats per-CPU traffic counters
      bpf, netkit: Add indirect call wrapper for fetching peer dev
      selftests/bpf: De-veth-ize the tc_redirect test case
      selftests/bpf: Add netkit to tc_redirect selftest

David Howells (3):
      rxrpc: Fix some minor issues with bundle tracing
      rxrpc: Fix RTT determination to use any ACK as a source
      rxrpc: Defer the response to a PING ACK until we've parsed it

David S. Miller (1):
      Merge branch 'rxrpc-ack-fixes'

Eduard Zingerman (11):
      selftests/bpf: track tcp payload offset as scalar in xdp_synproxy
      selftests/bpf: track string payload offset as scalar in strobemeta
      selftests/bpf: fix bpf_loop_bench for new callback verification scheme
      bpf: extract __check_reg_arg() utility function
      bpf: extract setup_func_entry() utility function
      bpf: verify callbacks as if they are called unknown number of times
      selftests/bpf: tests for iterating callbacks
      bpf: widening for callback iterators
      selftests/bpf: test widening for iterating callbacks
      bpf: keep track of max number of bpf_loop callback iterations
      selftests/bpf: check if max number of bpf_loop iterations is tracked

Eric Dumazet (1):
      wireguard: use DEV_STATS_INC()

Gerd Bayer (1):
      s390/ism: ism driver implies smc protocol

Haiyang Zhang (2):
      hv_netvsc: fix race of netvsc and VF register_netdevice
      hv_netvsc: Fix race of register_netdevice_notifier and VF register

Hao Ge (1):
      dpll: Fix potential msg memleak when genlmsg_put_reply failed

Heiner Kallweit (1):
      Revert "net: r8169: Disable multicast filter for RTL8168H and RTL8107E"

Ivan Vecera (1):
      i40e: Fix adding unsupported cloud filters

Jacob Keller (3):
      ice: remove ptp_tx ring parameter flag
      ice: unify logic for programming PFINT_TSYN_MSK
      ice: restore timestamp configuration after device reset

Jakub Kicinski (5):
      net: fill in MODULE_DESCRIPTION()s for SOCK_DIAG modules
      docs: netdev: try to guide people on dealing with silence
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      tools: ynl: fix header path for nfsd
      tools: ynl: fix duplicate op name in devlink

Jann Horn (1):
      tls: fix NULL deref on tls_sw_splice_eof() with empty record

Jean Delvare (1):
      stmmac: dwmac-loongson: Add architecture dependency

Jiawen Wu (1):
      net: wangxun: fix kernel panic due to null pointer

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: fix failed operations during ax88179_reset

Kees Cook (1):
      MAINTAINERS: Add netdev subsystem profile link

Kunwu Chan (1):
      ipv4: Correct/silence an endian warning in __ip_do_redirect

Lech Perczak (1):
      net: usb: qmi_wwan: claim interface 4 for ZTE MF290

Long Li (1):
      hv_netvsc: Mark VF as slave before exposing it to user-mode

Lorenzo Bianconi (1):
      net: veth: fix ethtool stats reporting

Martin KaFai Lau (1):
      Merge branch 'bpf_redirect_peer fixes'

Nguyen Dinh Phi (1):
      nfc: virtual_ncidev: Add variable to check if ndev is running

Oliver Neukum (1):
      usb: aqc111: check packet for fixup for true limit

Paolo Abeni (4):
      kselftest: rtnetlink: fix ip route command typo
      Merge branch 'hv_netvsc-fix-race-of-netvsc-vf-register-and-slave-bit'
      Merge branch 'amd-xgbe-fixes-to-handle-corner-cases'
      Merge branch 'ice-restore-timestamp-config-after-reset'

Peilin Ye (2):
      veth: Use tstats per-CPU traffic counters
      bpf: Fix dev's rx stats for bpf_redirect_peer traffic

Raju Rangoju (3):
      amd-xgbe: handle corner-case during sfp hotplug
      amd-xgbe: handle the corner-case during tx completion
      amd-xgbe: propagate the correct speed and duplex status

Samuel Holland (1):
      net: axienet: Fix check for partial TX checksum

Simon Horman (1):
      MAINTAINERS: Add indirect_call_wrapper.h to NETWORKING [GENERAL]

Suman Ghosh (2):
      octeontx2-pf: Fix memory leak during interface down
      octeontx2-pf: Fix ntuple rule creation to direct packet to VF with higher Rx queue than its PF

 Documentation/process/maintainer-netdev.rst        |  20 +-
 MAINTAINERS                                        |   3 +
 drivers/dpll/dpll_netlink.c                        |  17 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |  14 +
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       |  11 +-
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |  14 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  16 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  12 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           | 146 +++----
 drivers/net/ethernet/intel/ice/ice_ptp.h           |   5 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |   3 -
 drivers/net/ethernet/intel/ice/ice_txrx.h          |   1 -
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |  20 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   2 +
 drivers/net/ethernet/realtek/r8169_main.c          |   4 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |   8 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c      |   4 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |   4 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   2 +-
 drivers/net/hyperv/netvsc_drv.c                    |  68 ++--
 drivers/net/ipa/reg/gsi_reg-v5.0.c                 |   2 +-
 drivers/net/netkit.c                               |  22 +-
 drivers/net/usb/aqc111.c                           |   8 +-
 drivers/net/usb/ax88179_178a.c                     |   4 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/veth.c                                 |  46 +--
 drivers/net/vrf.c                                  |  38 +-
 drivers/net/wireguard/device.c                     |   4 +-
 drivers/net/wireguard/receive.c                    |  12 +-
 drivers/net/wireguard/send.c                       |   3 +-
 drivers/nfc/virtual_ncidev.c                       |   7 +-
 drivers/s390/net/Kconfig                           |   3 +-
 drivers/s390/net/ism_drv.c                         |  93 +++--
 include/linux/bpf_verifier.h                       |  16 +
 include/linux/netdevice.h                          |  30 +-
 include/net/netkit.h                               |   6 +
 include/trace/events/rxrpc.h                       |   2 +-
 kernel/bpf/verifier.c                              | 438 +++++++++++++--------
 net/core/dev.c                                     |  57 ++-
 net/core/filter.c                                  |  19 +-
 net/ipv4/inet_diag.c                               |   1 +
 net/ipv4/raw_diag.c                                |   1 +
 net/ipv4/route.c                                   |   2 +-
 net/ipv4/tcp_diag.c                                |   1 +
 net/ipv4/udp_diag.c                                |   1 +
 net/mptcp/mptcp_diag.c                             |   1 +
 net/packet/diag.c                                  |   1 +
 net/rxrpc/conn_client.c                            |   7 +-
 net/rxrpc/input.c                                  |  61 ++-
 net/sctp/diag.c                                    |   1 +
 net/smc/af_smc.c                                   |   8 +-
 net/smc/smc_diag.c                                 |   1 +
 net/tipc/diag.c                                    |   1 +
 net/tls/tls_sw.c                                   |   3 +
 net/unix/diag.c                                    |   1 +
 net/vmw_vsock/diag.c                               |   1 +
 net/xdp/xsk_diag.c                                 |   1 +
 tools/net/ynl/Makefile.deps                        |   2 +-
 tools/net/ynl/generated/devlink-user.c             |   2 +-
 tools/net/ynl/ynl-gen-c.py                         |   6 +
 .../testing/selftests/bpf/prog_tests/tc_redirect.c | 315 +++++++++------
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 tools/testing/selftests/bpf/progs/bpf_loop_bench.c |  13 +-
 tools/testing/selftests/bpf/progs/cb_refs.c        |   1 +
 .../testing/selftests/bpf/progs/exceptions_fail.c  |   2 +
 tools/testing/selftests/bpf/progs/strobemeta.h     |  78 ++--
 .../bpf/progs/verifier_iterating_callbacks.c       | 242 ++++++++++++
 .../bpf/progs/verifier_subprog_precision.c         |  86 +++-
 .../selftests/bpf/progs/xdp_synproxy_kern.c        |  84 ++--
 tools/testing/selftests/net/rtnetlink.sh           |   2 +-
 tools/testing/vsock/vsock_test.c                   |  19 +-
 72 files changed, 1448 insertions(+), 686 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c

