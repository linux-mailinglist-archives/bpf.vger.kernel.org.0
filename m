Return-Path: <bpf+bounces-17038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6B0809146
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 20:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7269BB20D8C
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 19:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD7E4F882;
	Thu,  7 Dec 2023 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urv7ZZg+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981674F5F7;
	Thu,  7 Dec 2023 19:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8C1C433C8;
	Thu,  7 Dec 2023 19:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701977334;
	bh=eMusVwTrdgEkt+KFoA8JGId1Q66EYgkk/hlk2YotBiU=;
	h=From:To:Cc:Subject:Date:From;
	b=urv7ZZg+lBPXYlMuNl62mPHHXQR8TyOplw8R2R3NJSsBSOcyBOMa7xStG2xZ4IAH2
	 aUUFkt09CHZk1ABjw9k1pedXaUho/13b0BkIJ+rQDRbyAi1KtP1/BEXeI5RmkW2L29
	 bCf9AG3pjbXA/ypr7cPbkvQmCHUAEv+EavE4OGE60AJLRvYHBY1iqADZooRRyWAat1
	 zBc5XnKUgp/K0eaEFW1zPxLbF/Ph9N/b3cxCLMgvdrvlfmwgcNVWPD2fTfWkKvFnlE
	 skLi3WMegYOwPODPwk5y+X0bhaOkFoR6mcUuc7kz2Yo0+4msqrRGWAPtjnWAOS/Pmc
	 PZwv7ZimkMTIQ==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	bpf@vger.kernel.org
Subject: [GIT PULL] Networking for v6.7-rc5
Date: Thu,  7 Dec 2023 11:28:53 -0800
Message-ID: <20231207192853.448914-1-kuba@kernel.org>
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

The following changes since commit 6172a5180fcc65170bfa2d49e55427567860f2a7:

  Merge tag 'net-6.7-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-12-01 08:24:46 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc5

for you to fetch changes up to b0a930e8d90caf66a94fee7a9d0b8472bc3e7561:

  vsock/virtio: fix "comparison of distinct pointer types lacks a cast" warning (2023-12-07 10:12:34 -0800)

----------------------------------------------------------------
Including fixes from bpf and netfilter.

Current release - regressions:

 - veth: fix packet segmentation in veth_convert_skb_to_xdp_buff

Current release - new code bugs:

 - tcp: assorted fixes to the new Auth Option support

Older releases - regressions:

 - tcp: fix mid stream window clamp

 - tls: fix incorrect splice handling

 - ipv4: ip_gre: handle skb_pull() failure in ipgre_xmit()

 - dsa: mv88e6xxx: restore USXGMII support for 6393X

 - arcnet: restore support for multiple Sohard Arcnet cards

Older releases - always broken:

 - tcp: do not accept ACK of bytes we never sent

 - require admin privileges to receive packet traces via netlink

 - packet: move reference count in packet_sock to atomic_long_t

 - bpf:
   - fix incorrect branch offset comparison with cpu=v4
   - fix prog_array_map_poke_run map poke update

 - netfilter:
   - 3 fixes for crashes on bad admin commands
   - xt_owner: fix race accessing sk->sk_socket, TOCTOU null-deref
   - nf_tables: fix 'exist' matching on bigendian arches

 - leds: netdev: fix RTNL handling to prevent potential deadlock

 - eth: tg3: prevent races in error/reset handling

 - eth: r8169: fix rtl8125b PAUSE storm when suspended

 - eth: r8152: improve reset and surprise removal handling

 - eth: hns: fix race between changing features and sending

 - eth: nfp: fix sleep in atomic for bonding offload

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Brett Creeley (1):
      ionic: Fix dim work handling in split interrupt mode

ChunHao Lin (1):
      r8169: fix rtl8125b PAUSE frames blasting when suspended

D. Wythe (1):
      netfilter: bpf: fix bad registration on nf_defrag

Daniel Borkmann (1):
      packet: Move reference count in packet_sock to atomic_long_t

Daniil Maximov (1):
      net: atlantic: Fix NULL dereference of skb pointer in

Dinghao Liu (1):
      net: bnxt: fix a potential use-after-free in bnxt_init_tc

Dmitry Safonov (5):
      Documentation/tcp: Fix an obvious typo
      net/tcp: Consistently align TCP-AO option in the header
      net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
      net/tcp: Don't add key with non-matching VRF on connected sockets
      net/tcp: Don't store TCP-AO maclen on reqsk

Douglas Anderson (5):
      r8152: Hold the rtnl_lock for all of reset
      r8152: Add RTL8152_INACCESSIBLE checks to more loops
      r8152: Add RTL8152_INACCESSIBLE to r8156b_wait_loading_flash()
      r8152: Add RTL8152_INACCESSIBLE to r8153_pre_firmware_1()
      r8152: Add RTL8152_INACCESSIBLE to r8153_aldps_en()

Eric Dumazet (2):
      ipv6: fix potential NULL deref in fib6_add()
      tcp: do not accept ACK of bytes we never sent

Florian Westphal (2):
      netfilter: nft_set_pipapo: skip inactive elements during set walk
      netfilter: nf_tables: fix 'exist' matching on bigendian arches

Geetha sowjanya (3):
      octeontx2-af: Fix mcs sa cam entries size
      octeontx2-af: Fix mcs stats register address
      octeontx2-af: Add missing mcs flr handler call

Heiner Kallweit (1):
      leds: trigger: netdev: fix RTNL handling to prevent potential deadlock

Hui Zhou (1):
      nfp: flower: fix for take a mutex lock in soft irq context and rcu lock

Ido Schimmel (2):
      psample: Require 'CAP_NET_ADMIN' when joining "packets" group
      drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group

Ivan Vecera (1):
      i40e: Fix unexpected MFS warning message

Jacob Keller (1):
      iavf: validate tx_coalesce_usecs even if rx_coalesce_usecs is zero

Jakub Kicinski (7):
      MAINTAINERS: exclude 9p from networking
      Merge branch 'ionic-small-driver-fixes'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge tag 'nf-23-12-06' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'fixes-for-ktls'
      Merge branch 'generic-netlink-multicast-fixes'

Jianheng Zhang (1):
      net: stmmac: fix FPE events losing

Jiri Olsa (2):
      bpf: Fix prog_array_map_poke_run map poke update
      selftests/bpf: Add test for early update in prog_array_map_poke_run

John Fastabend (2):
      net: tls, update curr on splice as well
      bpf: sockmap, updating the sg structure should also update curr

Kelly Kane (1):
      r8152: add vendor/device ID pair for ASUS USB-C2500

Lorenzo Bianconi (1):
      net: veth: fix packet segmentation in veth_convert_skb_to_xdp_buff

Marcin Szycik (1):
      ice: Restore fix disabling RX VLAN filtering

Michal Swiatkowski (1):
      ice: change vfs.num_msix_per to vf->num_msix

Naveen Mamindlapalli (1):
      octeontx2-pf: consider both Rx and Tx packet stats for adaptive interrupt coalescing

Nithin Dabilpuram (1):
      octeontx2-af: Adjust Tx credits when MCS external bypass is disabled

Pablo Neira Ayuso (2):
      netfilter: nf_tables: bail out on mismatching dynset and set expressions
      netfilter: nf_tables: validate family when identifying table via handle

Paolo Abeni (4):
      tcp: fix mid stream window clamp.
      Merge branch 'there-are-some-bugfix-for-the-hns-ethernet-driver'
      Merge branch 'tcp-ao-fixes'
      Merge branch 'octeontx2-af-miscellaneous-fixes'

Phil Sutter (1):
      netfilter: xt_owner: Fix for unsafe access of sk->sk_socket

Rahul Bhansali (1):
      octeontx2-af: Update Tx link register range

Randy Dunlap (1):
      hv_netvsc: rndis_filter needs to select NLS

Sean Nyekjaer (1):
      net: dsa: microchip: provide a list of valid protocols for xmit handler

Shannon Nelson (1):
      ionic: fix snprintf format length warning

Shigeru Yoshida (1):
      ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()

Stefano Garzarella (1):
      vsock/virtio: fix "comparison of distinct pointer types lacks a cast" warning

Subbaraya Sundeep (2):
      octeontx2-pf: Add missing mutex lock in otx2_get_pauseparam
      octeontx2-af: Check return value of nix_get_nixlf before using nixlf

Thinh Tran (1):
      net/tg3: fix race condition in tg3_reset_task()

Thomas Reichinger (1):
      arcnet: restoring support for multiple Sohard Arcnet cards

Tobias Waldekranz (1):
      net: dsa: mv88e6xxx: Restore USXGMII support for 6393X

Wen Gu (1):
      net/smc: fix missing byte order conversion in CLC handshake

Yewon Choi (1):
      xsk: Skip polling event check for unbound socket

Yonghong Song (1):
      bpf: Fix a verifier bug due to incorrect branch offset comparison with cpu=v4

Yonglong Liu (2):
      net: hns: fix wrong head when modify the tx feature when sending packets
      net: hns: fix fake link up on xge port

Zhipeng Lu (1):
      octeontx2-af: fix a use-after-free in rvu_npa_register_reporters

 Documentation/networking/tcp_ao.rst                |   2 +-
 MAINTAINERS                                        |   1 +
 arch/x86/net/bpf_jit_comp.c                        |  46 ++++++++
 drivers/leds/trigger/ledtrig-netdev.c              |  11 +-
 drivers/net/arcnet/arcdevice.h                     |   2 +
 drivers/net/arcnet/com20020-pci.c                  |  89 ++++++++-------
 drivers/net/dsa/microchip/ksz_common.c             |  16 ++-
 drivers/net/dsa/mv88e6xxx/pcs-639x.c               |  31 ++++-
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c    |  10 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.h    |   4 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |  18 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c       |   1 +
 drivers/net/ethernet/broadcom/tg3.c                |  11 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |  29 +++++
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |  53 +++++----
 drivers/net/ethernet/hisilicon/hns/hns_enet.h      |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  12 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.h        |   1 -
 drivers/net/ethernet/intel/ice/ice_sriov.c         |   7 +-
 .../net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c   |  11 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |   5 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |   2 +-
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c    |  18 ++-
 drivers/net/ethernet/marvell/octeontx2/af/mcs.h    |   2 +
 .../net/ethernet/marvell/octeontx2/af/mcs_reg.h    |  31 ++++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |   3 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   1 +
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |   5 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   8 ++
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |   8 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_reg.c    |   4 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_reg.h    |   1 +
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |   6 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   9 ++
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |  20 ++--
 .../ethernet/netronome/nfp/flower/tunnel_conf.c    | 127 +++++++++++++++------
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |   2 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |  16 +--
 drivers/net/ethernet/realtek/r8169_main.c          |   7 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c       |  45 +++-----
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h       |   4 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |   3 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |   1 +
 drivers/net/hyperv/Kconfig                         |   1 +
 drivers/net/usb/r8152.c                            |  28 ++++-
 drivers/net/veth.c                                 |   3 +-
 include/linux/bpf.h                                |   3 +
 include/linux/stmmac.h                             |   1 +
 include/linux/tcp.h                                |   8 +-
 include/linux/usb/r8152.h                          |   1 +
 include/net/genetlink.h                            |   2 +
 include/net/tcp.h                                  |   9 +-
 include/net/tcp_ao.h                               |   6 +
 kernel/bpf/arraymap.c                              |  58 ++--------
 kernel/bpf/core.c                                  |  12 +-
 net/core/drop_monitor.c                            |   4 +-
 net/core/filter.c                                  |  19 +++
 net/ipv4/ip_gre.c                                  |  11 +-
 net/ipv4/tcp.c                                     |  28 ++++-
 net/ipv4/tcp_ao.c                                  |  17 ++-
 net/ipv4/tcp_input.c                               |  11 +-
 net/ipv4/tcp_ipv4.c                                |   4 +-
 net/ipv4/tcp_minisocks.c                           |   2 +-
 net/ipv4/tcp_output.c                              |  15 +--
 net/ipv6/ip6_fib.c                                 |   6 +-
 net/ipv6/tcp_ipv6.c                                |   2 +-
 net/netfilter/nf_bpf_link.c                        |  10 +-
 net/netfilter/nf_tables_api.c                      |   5 +-
 net/netfilter/nft_dynset.c                         |  13 ++-
 net/netfilter/nft_exthdr.c                         |   4 +-
 net/netfilter/nft_fib.c                            |   8 +-
 net/netfilter/nft_set_pipapo.c                     |   3 +
 net/netfilter/xt_owner.c                           |  16 ++-
 net/netlink/genetlink.c                            |   3 +
 net/packet/af_packet.c                             |  16 +--
 net/packet/internal.h                              |   2 +-
 net/psample/psample.c                              |   3 +-
 net/smc/af_smc.c                                   |   4 +-
 net/smc/smc_clc.c                                  |   9 +-
 net/smc/smc_clc.h                                  |   4 +-
 net/tls/tls_sw.c                                   |   2 +
 net/vmw_vsock/virtio_transport_common.c            |   3 +-
 net/xdp/xsk.c                                      |   5 +-
 tools/testing/selftests/bpf/prog_tests/tailcalls.c |  84 ++++++++++++++
 tools/testing/selftests/bpf/progs/tailcall_poke.c  |  32 ++++++
 88 files changed, 821 insertions(+), 356 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_poke.c

