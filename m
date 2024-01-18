Return-Path: <bpf+bounces-19840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DE9832142
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 23:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03886B25A31
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 22:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4AA31A6B;
	Thu, 18 Jan 2024 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuL8k02S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4B92E85F;
	Thu, 18 Jan 2024 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705615278; cv=none; b=o080EOQXUGt1r8QsLpOyUUXSSKlkGhWfldo+n1FDyoapa9i/eM64FctftNXhvU6vAR/098YD8Cpp8jkpHx6XneIKtw01yEZqPiaZUQyXwYdsbKiH4JIzWtQtyk1CEpWpG8a3wrh4kpQEle7nKApLEmJYi428Du6MOA5lkg+qI8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705615278; c=relaxed/simple;
	bh=Efm+PXJ7N7sLa7pTKfa3U4klPY4k63z8iTuAYJQsFRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lpDTr6UYeDYLuxmuhoXBzhiDX4tqrRGjSjyC/0CcoHsqgOg+v8sWPJak8x99GauwEVAd8wBp8piDiMA8mbbTlPEJgKsMvpCbt1YxAX8R8wZBJhYeG5kT8NCWRZdsbVxDC5uXfhuf8TXT+9xN9cxyYcGND8iT3IZy7nCo69yrMN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuL8k02S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF6AC433F1;
	Thu, 18 Jan 2024 22:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705615278;
	bh=Efm+PXJ7N7sLa7pTKfa3U4klPY4k63z8iTuAYJQsFRk=;
	h=From:To:Cc:Subject:Date:From;
	b=TuL8k02S+rhHlOBqjRv0Smavss9EBk3xoM4T/tR2ORZvxXEhLahbpQ/dmGul9PWrq
	 A9RdD2Z1J6BgiVqvTnRZurwFUT0p+OlEk2OJCQ14WJiP3naQpyi8HSLWVohkplLmb0
	 v/O3d3YhWOHlTHgf2wgf8zYm2fyGK4bA7IiHIYsNCdJ/PVSi3AS+QF9zc5sJfzT3jp
	 kNGy+Tb9AfAmD/cnsgRHPwl13/DE9hrMX1N1qyRienua8B33vCkeXeHRJsWHZirCFa
	 flaZ7mjACUh0377u6gOTtZmBvU1lYF4k/RxUYBbsiWNyyrj4DcTuFz/JfSizGD0cUc
	 BvFvE3ZMkVQBg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	bpf@vger.kernel.org
Subject: [GIT PULL] Networking for v6.8-rc1
Date: Thu, 18 Jan 2024 14:01:16 -0800
Message-ID: <20240118220116.2146136-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit 3e7aeb78ab01c2c2f0e1f784e5ddec88fcd3d106:

  Merge tag 'net-next-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2024-01-11 10:07:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.8-rc1

for you to fetch changes up to 925781a471d8156011e8f8c1baf61bbe020dac55:

  Merge tag 'nf-24-01-18' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2024-01-18 12:45:05 -0800)

----------------------------------------------------------------
Including fixes from bpf and netfilter.

Previous releases - regressions:

 - Revert "net: rtnetlink: Enslave device before bringing it up",
   breaks the case inverse to the one it was trying to fix

 - net: dsa: fix oob access in DSA's netdevice event handler
   dereference netdev_priv() before check its a DSA port

 - sched: track device in tcf_block_get/put_ext() only for clsact
   binder types

 - net: tls, fix WARNING in __sk_msg_free when record becomes full
   during splice and MORE hint set

 - sfp-bus: fix SFP mode detect from bitrate

 - drv: stmmac: prevent DSA tags from breaking COE

Previous releases - always broken:

 - bpf: fix no forward progress in in bpf_iter_udp if output
   buffer is too small

 - bpf: reject variable offset alu on registers with a type
   of PTR_TO_FLOW_KEYS to prevent oob access

 - netfilter: tighten input validation

 - net: add more sanity check in virtio_net_hdr_to_skb()

 - rxrpc: fix use of Don't Fragment flag on RESPONSE packets,
   avoid infinite loop

 - amt: do not use the portion of skb->cb area which may get clobbered

 - mptcp: improve validation of the MPTCPOPT_MP_JOIN MCTCP option

Misc:

 - spring cleanup of inactive maintainers

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alexei Starovoitov (2):
      Merge branch 'bpf-fix-backward-progress-bug-in-bpf_iter_udp'
      Merge branch 'tighten-up-arg-ctx-type-enforcement'

Amit Cohen (3):
      mlxsw: spectrum_acl_erp: Fix error flow of pool allocation failure
      selftests: mlxsw: qos_pfc: Remove wrong description
      selftests: mlxsw: qos_pfc: Adjust the test to support 8 lanes

Andrii Nakryiko (5):
      libbpf: feature-detect arg:ctx tag support in kernel
      bpf: extract bpf_ctx_convert_map logic and make it more reusable
      bpf: enforce types for __arg_ctx-tagged arguments in global subprogs
      selftests/bpf: add tests confirming type logic in kernel for __arg_ctx
      libbpf: warn on unexpected __arg_ctx type when rewriting BTF

Arnd Bergmann (1):
      wangxunx: select CONFIG_PHYLINK where needed

Benjamin Poirier (3):
      selftests: bonding: Change script interpreter
      selftests: forwarding: Remove executable bits from lib.sh
      selftests: bonding: Add more missing config options

Breno Leitao (6):
      net: fill in MODULE_DESCRIPTION()s for SLIP
      net: fill in MODULE_DESCRIPTION()s for HSR
      net: fill in MODULE_DESCRIPTION()s for NFC
      net: fill in MODULE_DESCRIPTION()s for Sun RPC
      net: fill in MODULE_DESCRIPTION()s for ds26522 module
      net: fill in MODULE_DESCRIPTION()s for s2io

Claudiu Beznea (1):
      net: phy: micrel: populate .soft_reset for KSZ9131

David Howells (1):
      rxrpc: Fix use of Don't Fragment flag

David S. Miller (1):
      Merge branch 'tls-splice-hint-fixes'

Dmitry Antipov (1):
      net: liquidio: fix clang-specific W=1 build warnings

Dmitry Safonov (1):
      selftests/net/tcp-ao: Use LDLIBS instead of LDFLAGS

Eric Dumazet (7):
      mptcp: mptcp_parse_option() fix for MPTCPOPT_MP_JOIN
      mptcp: strict validation before using mp_opt->hmac
      mptcp: use OPTION_MPTCP_MPJ_SYNACK in subflow_finish_connect()
      mptcp: use OPTION_MPTCP_MPJ_SYN in subflow_check_req()
      mptcp: refine opt_mp_capable determination
      udp: annotate data-races around up->pending
      net: add more sanity check in virtio_net_hdr_to_skb()

Fedor Pchelkin (1):
      ipvs: avoid stat macros calls from preemptible context

Hao Sun (2):
      bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS
      selftests/bpf: Add test for alu on PTR_TO_FLOW_KEYS

Horatiu Vultur (1):
      net: micrel: Fix PTP frame parsing for lan8841

Ido Schimmel (2):
      mlxsw: spectrum_acl_tcam: Fix NULL pointer dereference in error path
      mlxsw: spectrum_acl_tcam: Fix stack corruption

Jakub Kicinski (20):
      Merge branch 'fix-module_description-for-net-p1'
      MAINTAINERS: eth: mtk: move John to CREDITS
      MAINTAINERS: eth: mt7530: move Landen Chao to CREDITS
      MAINTAINERS: eth: mvneta: move Thomas to CREDITS
      MAINTAINERS: eth: mark Cavium liquidio as an Orphan
      MAINTAINERS: Bluetooth: retire Johan (for now?)
      MAINTAINERS: mark ax25 as Orphan
      MAINTAINERS: ibmvnic: drop Dany from reviewers
      Merge branch 'rtnetlink-allow-to-enslave-with-one-msg-an-up-interface'
      Merge branch 'net-ethernet-ti-am65-cpsw-allow-for-mtu-values'
      net: fill in MODULE_DESCRIPTION()s for wx_lib
      Merge branch 'mptcp-better-validation-of-mptcpopt_mp_join-option'
      selftests: netdevsim: sprinkle more udevadm settle
      selftests: netdevsim: correct expected FEC strings
      selftests: bonding: add missing build configs
      net: netdevsim: don't try to destroy PHC on VFs
      selftests: netdevsim: add a config file
      Merge branch 'mlxsw-miscellaneous-fixes'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge tag 'nf-24-01-18' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Jiri Pirko (1):
      net: sched: track device in tcf_block_get/put_ext() only for clsact binder types

John Fastabend (2):
      net: tls, fix WARNIING in __sk_msg_free
      net: tls, add test to capture error on large splice

Kunwu Chan (1):
      net: dsa: vsc73xx: Add null pointer check to vsc73xx_gpio_probe

Lin Ma (1):
      net: qualcomm: rmnet: fix global oob in rmnet_policy

Ludvig Pärsson (1):
      ethtool: netlink: Add missing ethnl_ops_begin/complete

Marc Kleine-Budde (1):
      net: netdev_queue: netdev_txq_completed_mb(): fix wake condition

Marcin Wojtas (1):
      MAINTAINERS: eth: mvneta: update entry

Martin KaFai Lau (3):
      bpf: iter_udp: Retry with a larger batch size without going back to the previous bucket
      bpf: Avoid iter->offset making backward progress in bpf_iter_udp
      selftests/bpf: Test udp and tcp iter batching

Nicolas Dichtel (3):
      Revert "net: rtnetlink: Enslave device before bringing it up"
      selftests: rtnetlink: check enslaving iface in a bond
      selftests: rtnetlink: use setup_ns in bonding test

Nikita Yushchenko (1):
      net: ravb: Fix dma_addr_t truncation in error case

Nikita Zhandarovich (1):
      ipv6: mcast: fix data-race in ipv6_mc_down / mld_ifc_work

Nithin Dabilpuram (1):
      octeontx2-af: CN10KB: Fix FIFO length calculation for RPM2

Pablo Neira Ayuso (8):
      netfilter: nf_tables: reject invalid set policy
      netfilter: nf_tables: validate .maxattr at expression registration
      netfilter: nf_tables: bail out if stateful expression provides no .clone
      netfilter: nft_limit: do not ignore unsupported flags
      netfilter: nf_tables: check if catch-all set element is active in next generation
      netfilter: nf_tables: do not allow mismatch field size and set key length
      netfilter: nf_tables: skip dead set elements in netlink dump
      netfilter: nf_tables: reject NFT_SET_CONCAT with not field length description

Paolo Abeni (2):
      Merge branch 'selftests-net-small-fixes'
      mptcp: relax check on MPC passive fallback

Pavel Tikhomirov (4):
      netfilter: nfnetlink_log: use proper helper for fetching physinif
      netfilter: nf_queue: remove excess nf_bridge variable
      netfilter: propagate net to nf_bridge_get_physindev
      netfilter: bridge: replace physindev with physinif in nf_bridge_info

Petr Machata (1):
      mlxsw: spectrum_router: Register netdevice notifier before nexthop

Qiang Ma (1):
      net: stmmac: ethtool: Fixed calltrace caused by unbalanced disable_irq_wake calls

Romain Gantois (1):
      net: stmmac: Prevent DSA tags from breaking COE

Russell King (Oracle) (1):
      net: sfp-bus: fix SFP mode detect from bitrate

Sanjuán García, Jorge (1):
      net: ethernet: ti: am65-cpsw: Fix max mtu to fit ethernet frames

Sneh Shah (1):
      net: stmmac: Fix ethool link settings ops for integrated PCS

Taehee Yoo (1):
      amt: do not use overwrapped cb area

Tony Nguyen (1):
      i40e: Include types.h to some headers

Vladimir Oltean (1):
      net: dsa: fix netdev_priv() dereference before check on non-DSA netdevice events

Zhu Yanjun (1):
      virtio_net: Fix "‘%d’ directive writing between 1 and 11 bytes into a region of size 10" warnings

 CREDITS                                            |  17 ++
 MAINTAINERS                                        |  16 +-
 drivers/net/amt.c                                  |   6 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c             |   2 +
 .../ethernet/cavium/liquidio/cn23xx_pf_device.c    |   2 +-
 .../ethernet/cavium/liquidio/cn23xx_vf_device.c    |   2 +-
 .../net/ethernet/cavium/liquidio/octeon_mailbox.h  |   5 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |   1 +
 drivers/net/ethernet/intel/i40e/i40e_diag.h        |   1 +
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c    |   7 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c |   8 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl_tcam.c    |   6 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |  24 +--
 drivers/net/ethernet/neterion/s2io.c               |   1 +
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |   2 +-
 drivers/net/ethernet/renesas/ravb_main.c           |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   1 +
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  20 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  33 ++-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   5 +-
 drivers/net/ethernet/wangxun/Kconfig               |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |   1 +
 drivers/net/netdevsim/netdev.c                     |   9 +-
 drivers/net/phy/micrel.c                           |   9 +
 drivers/net/phy/sfp-bus.c                          |   8 +-
 drivers/net/slip/slhc.c                            |   1 +
 drivers/net/slip/slip.c                            |   1 +
 drivers/net/virtio_net.c                           |   9 +-
 drivers/net/wan/slic_ds26522.c                     |   1 +
 include/linux/btf.h                                |   2 +-
 include/linux/netfilter_bridge.h                   |   6 +-
 include/linux/skbuff.h                             |   2 +-
 include/linux/virtio_net.h                         |   9 +-
 include/net/netdev_queues.h                        |   2 +-
 kernel/bpf/btf.c                                   | 231 ++++++++++++++++++---
 kernel/bpf/verifier.c                              |   4 +
 net/bridge/br_netfilter_hooks.c                    |  42 +++-
 net/bridge/br_netfilter_ipv6.c                     |  14 +-
 net/core/rtnetlink.c                               |  14 +-
 net/dsa/user.c                                     |   7 +-
 net/ethtool/features.c                             |   9 +-
 net/hsr/hsr_main.c                                 |   1 +
 net/ipv4/netfilter/nf_reject_ipv4.c                |   9 +-
 net/ipv4/udp.c                                     |  34 ++-
 net/ipv6/mcast.c                                   |   4 +
 net/ipv6/netfilter/nf_reject_ipv6.c                |  11 +-
 net/ipv6/udp.c                                     |  16 +-
 net/mptcp/options.c                                |   6 +-
 net/mptcp/subflow.c                                |  17 +-
 net/netfilter/ipset/ip_set_hash_netiface.c         |   8 +-
 net/netfilter/ipvs/ip_vs_xmit.c                    |   4 +-
 net/netfilter/nf_log_syslog.c                      |  13 +-
 net/netfilter/nf_queue.c                           |   6 +-
 net/netfilter/nf_tables_api.c                      |  44 ++--
 net/netfilter/nfnetlink_log.c                      |   8 +-
 net/netfilter/nft_limit.c                          |  19 +-
 net/netfilter/xt_physdev.c                         |   2 +-
 net/nfc/digital_core.c                             |   1 +
 net/nfc/nci/core.c                                 |   1 +
 net/nfc/nci/spi.c                                  |   1 +
 net/rxrpc/ar-internal.h                            |   1 +
 net/rxrpc/local_object.c                           |  13 +-
 net/rxrpc/output.c                                 |   6 +-
 net/rxrpc/rxkad.c                                  |   2 +
 net/sched/cls_api.c                                |  12 +-
 net/sunrpc/auth_gss/auth_gss.c                     |   1 +
 net/sunrpc/auth_gss/gss_krb5_mech.c                |   1 +
 net/sunrpc/sunrpc_syms.c                           |   1 +
 net/tls/tls_sw.c                                   |   6 +-
 tools/lib/bpf/libbpf.c                             | 142 ++++++++++++-
 .../selftests/bpf/prog_tests/sock_iter_batch.c     | 135 ++++++++++++
 .../selftests/bpf/prog_tests/test_global_funcs.c   |  13 ++
 .../testing/selftests/bpf/progs/bpf_tracing_net.h  |   3 +
 .../testing/selftests/bpf/progs/sock_iter_batch.c  |  91 ++++++++
 tools/testing/selftests/bpf/progs/test_jhash.h     |  31 +++
 .../selftests/bpf/progs/verifier_global_subprogs.c | 164 ++++++++++++++-
 .../bpf/progs/verifier_value_illegal_alu.c         |  19 ++
 tools/testing/selftests/drivers/net/bonding/config |   8 +
 .../drivers/net/bonding/mode-1-recovery-updelay.sh |   2 +-
 .../drivers/net/bonding/mode-2-recovery-updelay.sh |   2 +-
 .../testing/selftests/drivers/net/mlxsw/qos_pfc.sh |  19 +-
 .../drivers/net/mlxsw/spectrum-2/tc_flower.sh      | 106 +++++++++-
 .../testing/selftests/drivers/net/netdevsim/config |  10 +
 .../drivers/net/netdevsim/ethtool-common.sh        |   1 +
 .../selftests/drivers/net/netdevsim/ethtool-fec.sh |  18 +-
 .../drivers/net/netdevsim/udp_tunnel_nic.sh        |   1 +
 tools/testing/selftests/net/forwarding/lib.sh      |   0
 tools/testing/selftests/net/rtnetlink.sh           |  26 +++
 tools/testing/selftests/net/tcp_ao/Makefile        |   4 +-
 tools/testing/selftests/net/tls.c                  |  14 ++
 90 files changed, 1366 insertions(+), 235 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_iter_batch.c
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/config
 mode change 100755 => 100644 tools/testing/selftests/net/forwarding/lib.sh

