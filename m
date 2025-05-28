Return-Path: <bpf+bounces-59174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA890AC6B2A
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 16:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86E7D7AB14A
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 13:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D961287500;
	Wed, 28 May 2025 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lz0nYryM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5528850D
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748440817; cv=none; b=CVnFqfYC5zQ9QQEcQfsN5geqHMut/fvqzH94awICPFweVG54LFO0MS71X8m2NVk1D+P+hl2Eheey8fJCoJTdqH2ERrvCa7kSESs04z6ojh0uEArDL6GKtMZDSGPi0p8CNm3s2vpGe5FYg6vsomp1KGyOvMDUaf4nmzjq3zV2zhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748440817; c=relaxed/simple;
	bh=PbiZlEzWUVopMjb9ZNVupI7WuRI8dfHpcZYs/poA2Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rq1FAimL8zx0YwfzS7KI9JHV0CDZgOh3NnKCMN97WnWr/evU2XHu9XNj+Rcev9bLeRXd4WzQrQ/f+NSe1r1OX7VOQpjKf4EFpCJhH8ZPB9bSYIuVZoh5cpn70X+mfBWcWCsKAYtqndAxgFL4kVp3kfeV+PNnqi0QUhTgsGz7ZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lz0nYryM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748440807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ugFzuL9L0Secq109FVV7BTO3OF/2/pc2I7bSZ2jl8gg=;
	b=Lz0nYryMrC+6Jy6Urh4Rd9yCfzR2XBVLwXiDEjEZmMyEwgiKUpcjS+g3YDTlAnvMoeCRx8
	U3O02cbM1SaVME0ytc6Sjk4uaw15+VWM8fjrXNDdk7qvTQTDVsPEVCjv63E8kMjBdzBLxZ
	VBWah3d20fShfVCOw9lKdIIqo9T4J14=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-xK6IY4lsPhaWS1XxET9E6Q-1; Wed,
 28 May 2025 10:00:01 -0400
X-MC-Unique: xK6IY4lsPhaWS1XxET9E6Q-1
X-Mimecast-MFC-AGG-ID: xK6IY4lsPhaWS1XxET9E6Q_1748440800
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D41E61945108;
	Wed, 28 May 2025 13:59:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.128])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C8EC51956095;
	Wed, 28 May 2025 13:59:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [GIT PULL] Networking for v6.16
Date: Wed, 28 May 2025 15:59:41 +0200
Message-ID: <20250528135941.50128-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Linus!

Beware, there is a semantic conflict with your tree, which will cause
build failure for CONFIG_AMD_NB enabled builds unless you also apply:

https://lore.kernel.org/linux-next/20250514152318.52714b39@canb.auug.org.au/

I'm aware of the following conflicts with your tree:

drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
  https://lore.kernel.org/linux-next/20250507124900.4dad50d4@canb.auug.org.au/

net/unix/af_unix.c
  https://lore.kernel.org/linux-next/20250526123701.01aec1c4@canb.auug.org.au/

With the ftrace tree:

include/trace/events/tcp.h
  https://lore.kernel.org/linux-next/20250516162301.6c5d2d3c@canb.auug.org.au/

With the rdma-fixes tree:

drivers/infiniband/hw/irdma/main.c
  https://lore.kernel.org/linux-next/20250513130630.280ee6c5@canb.auug.org.au/

With the reset tree:

MAINTAINERS
  https://lore.kernel.org/linux-next/20250506112554.3832cd40@canb.auug.org.au/

The following changes since commit 5cdb2c77c4c3d36bdee83d9231649941157f8204:

  Merge tag 'net-6.15-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-05-22 09:15:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.16

for you to fetch changes up to f6bd8faeb113c8ab783466bc5bc1a5442ae85176:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-05-28 10:11:15 +0200)

----------------------------------------------------------------
Networking changes for 6.16.

Core
----

 - Implement the Device Memory TCP transmit path, allowing zero-copy
   data transmission on top of TCP from e.g. GPU memory to the wire.

 - Move all the IPv6 routing tables management outside the RTNL scope,
   under its own lock and RCU. The route control path is now 3x times
   faster.

 - Convert queue related netlink ops to instance lock, reducing
   again the scope of the RTNL lock. This improves the control plane
   scalability.

 - Refactor the software crc32c implementation, removing unneeded
   abstraction layers and improving significantly the related
   micro-benchmarks.

 - Optimize the GRO engine for UDP-tunneled traffic, for a 10%
   performance improvement in related stream tests.

 - Cover more per-CPU storage with local nested BH locking; this is a
   prep work to remove the current per-CPU lock in local_bh_disable()
   on PREMPT_RT.

 - Introduce and use nlmsg_payload helper, combining buffer bounds
   verification with accessing payload carried by netlink messages.

Netfilter
---------

 - Rewrite the procfs conntrack table implementation, improving
   considerably the dump performance. A lot of user-space tools
   still use this interface.

 - Implement support for wildcard netdevice in netdev basechain
   and flowtables.

 - Integrate conntrack information into nft trace infrastructure.

 - Export set count and backend name to userspace, for better
   introspection.

BPF
---

 - BPF qdisc support: BPF-qdisc can be implemented with BPF struct_ops
   programs and can be controlled in similar way to traditional qdiscs
   using the "tc qdisc" command.

 - Refactor the UDP socket iterator, addressing long standing issues
   WRT duplicate hits or missed sockets.

Protocols
---------

 - Improve TCP receive buffer auto-tuning and increase the default
   upper bound for the receive buffer; overall this improves the single
   flow maximum thoughput on 200Gbs link by over 60%.

 - Add AFS GSSAPI security class to AF_RXRPC; it provides transport
   security for connections to the AFS fileserver and VL server.

 - Improve TCP multipath routing, so that the sources address always
   matches the nexthop device.

 - Introduce SO_PASSRIGHTS for AF_UNIX, to allow disabling SCM_RIGHTS,
   and thus preventing DoS caused by passing around problematic FDs.

 - Retire DCCP socket. DCCP only receives updates for bugs, and major
   distros disable it by default. Its removal allows for better
   organisation of TCP fields to reduce the number of cache lines hit
   in the fast path.

 - Extend TCP drop-reason support to cover PAWS checks.

Driver API
----------

 - Reorganize PTP ioctl flag support to require an explicit opt-in for
   the drivers, avoiding the problem of drivers not rejecting new
   unsupported flags.

 - Converted several device drivers to timestamping APIs.

 - Introduce per-PHY ethtool dump helpers, improving the support for
   dump operations targeting PHYs.

Tests and tooling
-----------------

 - Add support for classic netlink in user space C codegen, so that
   ynl-c can now read, create and modify links, routes addresses and
   qdisc layer configuration.

 - Add ynl sub-types for binary attributes, allowing ynl-c to output
   known struct instead of raw binary data, clarifying the classic
   netlink output.

 - Extend MPTCP selftests to improve the code-coverage.

 - Add tests for XDP tail adjustment in AF_XDP.

New hardware / drivers
----------------------

 - OpenVPN virtual driver: offload OpenVPN data channels processing
   to the kernel-space, increasing the data transfer throughput WRT
   the user-space implementation.

 - Renesas glue driver for the gigabit ethernet RZ/V2H(P) SoC.

 - Broadcom asp-v3.0 ethernet driver.

 - AMD Renoir ethernet device.

 - ReakTek MT9888 2.5G ethernet PHY driver.

 - Aeonsemi 10G C45 PHYs driver.

Drivers
-------

 - Ethernet high-speed NICs:
   - nVidia/Mellanox (mlx5):
     - refactor the stearing table handling to reduce significantly
       the amount of memory used
     - add support for complex matches in H/W flow steering
     - improve flow streeing error handling
     - convert to netdev instance locking
   - Intel (100G, ice, igb, ixgbe, idpf):
     - ice: add switchdev support for LLDP traffic over VF
     - ixgbe: add firmware manipulation and regions devlink support
     - igb: introduce support for frame transmission premption
     - igb: adds persistent NAPI configuration
     - idpf: introduce RDMA support
     - idpf: add initial PTP support
   - Meta (fbnic):
     - extend hardware stats coverage
     - add devlink dev flash support
   - Broadcom (bnxt):
     - add support for RX-side device memory TCP
   - Wangxun (txgbe):
     - implement support for udp tunnel offload
     - complete PTP and SRIOV support for AML 25G/10G devices

 - Ethernet NICs embedded and virtual:
   - Google (gve):
     - add device memory TCP TX support
   - Amazon (ena):
     - support persistent per-NAPI config
   - Airoha:
     - add H/W support for L2 traffic offload
     - add per flow stats for flow offloading
   - RealTek (rtl8211): add support for WoL magic packet
   - Synopsys (stmmac):
     - dwmac-socfpga 1000BaseX support
     - add Loongson-2K3000 support
     - introduce support for hardware-accelerated VLAN stripping
   - Broadcom (bcmgenet):
     - expose more H/W stats
   - Freescale (enetc, dpaa2-eth):
     - enetc: add MAC filter, VLAN filter RSS and loopback support
     - dpaa2-eth: convert to H/W timestamping APIs
   - vxlan: convert FDB table to rhashtable, for better scalabilty
   - veth: apply qdisc backpressure on full ring to reduce TX drops

 - Ethernet switches:
   - Microchip (kzZ88x3): add ETS scheduler support

 - Ethernet PHYs:
   - RealTek (rtl8211):
     - add support for WoL magic packet
     - add support for PHY LEDs

 - CAN:
   - Adds RZ/G3E CANFD support to the rcar_canfd driver.
   - Preparatory work for CAN-XL support.
   - Add self-tests framework with support for CAN physical interfaces.

 - WiFi:
   - mac80211:
     - scan improvements with multi-link operation (MLO)
   - Qualcomm (ath12k):
     - enable AHB support for IPQ5332
     - add monitor interface support to QCN9274
     - add multi-link operation support to WCN7850
     - add 802.11d scan offload support to WCN7850
     - monitor mode for WCN7850, better 6 GHz regulatory
   - Qualcomm (ath11k):
     - restore hibernation support
   - MediaTek (mt76):
     - WiFi-7 improvements
     - implement support for mt7990
   - Intel (iwlwifi):
     - enhanced multi-link single-radio (EMLSR) support on 5 GHz links
     - rework device configuration
   - RealTek (rtw88):
     - improve throughput for RTL8814AU
   - RealTek (rtw89):
     - add multi-link operation support
     - STA/P2P concurrency improvements
     - support different SAR configs by antenna

 - Bluetooth:
   - introduce HCI Driver protocol
   - btintel_pcie: do not generate coredump for diagnostic events
   - btusb: add HCI Drv commands for configuring altsetting
   - btusb: add RTL8851BE device 0x0bda:0xb850
   - btusb: add new VID/PID 13d3/3584 for MT7922
   - btusb: add new VID/PID 13d3/3630 and 13d3/3613 for MT7925
   - btnxpuart: implement host-wakeup feature

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Aaradhana Sahu (2):
      wifi: ath12k: Resolve multicast packet drop by populating key_cipher in ath12k_install_key()
      wifi: ath12k: Introduce check against zero for ahvif->key_cipher in ath12k_mac_op_tx()

Aditya Kumar Singh (19):
      wifi: ath12k: move firmware stats out of debugfs
      wifi: ath12k: add get_txpower mac ops
      wifi: ath12k: fix SLUB BUG - Object already free in ath12k_reg_free()
      wifi: ath12k: add reference counting for core attachment to hardware group
      wifi: ath12k: fix failed to set mhi state error during reboot with hardware grouping
      wifi: ath12k: fix ATH12K_FLAG_REGISTERED flag handling
      wifi: ath12k: fix firmware assert during reboot with hardware grouping
      wifi: ath12k: fix ath12k_core_pre_reconfigure_recovery() with grouping
      wifi: ath12k: handle ath12k_core_restart() with hardware grouping
      wifi: ath12k: handle ath12k_core_reset() with hardware grouping
      wifi: ath12k: reset MLO global memory during recovery
      wifi: ath12k: Fix frequency range in driver
      wifi: ath12k: Update frequency range if reg rules changes
      wifi: mac80211: handle non-MLO mode as well in ieee80211_num_beaconing_links()
      wifi: ath12k: handle scan link during vdev create
      wifi: ath12k: Use scan link ID 15 for all scan operations
      wifi: ath12k: fix mac pdev frequency range update
      wifi: mac80211: validate SCAN_FLAG_AP in scan request during MLO
      wifi: mac80211: accept probe response on link address as well

Aishwarya R (1):
      wifi: ath12k: remove redundant regulatory rules intersection logic in host

Alexander Duyck (1):
      net: phylink: Drop unused defines for SUPPORTED/ADVERTISED_INTERFACES

Alexey Charkov (1):
      dt-bindings: net: via-rhine: Convert to YAML

Alexey Kodanev (1):
      wifi: rtw88: fix the 'para' buffer size to avoid reading out of bounds

Allan Wang (2):
      wifi: mt76: mt7925: add EHT preamble puncturing
      wifi: mt76: mt7925: add rfkill_poll for hardware rfkill

Alok Tiwari (2):
      emulex/benet: correct command version selection in be_cmd_get_stats()
      Doc: networking: Fix various typos in rds.rst

Aloka Dixit (1):
      wifi: ath12k: pass link_conf for tx_arvif retrieval

Alper Ak (1):
      documentation: networking: devlink: Fix a typo in devlink-trap.rst

Amery Hung (16):
      bpf: Prepare to reuse get_ctx_arg_idx
      bpf: net_sched: Support implementation of Qdisc_ops in bpf
      bpf: net_sched: Add basic bpf qdisc kfuncs
      bpf: net_sched: Add a qdisc watchdog timer
      bpf: net_sched: Support updating bstats
      bpf: net_sched: Disable attaching bpf qdisc to non root
      libbpf: Support creating and destroying qdisc
      selftests/bpf: Add a basic fifo qdisc test
      selftests/bpf: Add a bpf fq qdisc to selftest
      selftests/bpf: Test attaching bpf qdisc to mq and non root
      bpf: net_sched: Fix using bpf qdisc as default qdisc
      bpf: net_sched: Fix bpf qdisc init prologue when set as default qdisc
      selftests/bpf: Test setting and creating bpf qdisc as default qdisc
      bpf: net_sched: Make some Qdisc_ops ops mandatory
      selftests/bpf: Test attaching a bpf qdisc with incomplete operators
      selftests/bpf: Cleanup bpf qdisc selftests

Amit Cohen (2):
      net: bridge: Prevent unicast ARP/NS packets from being suppressed by bridge
      selftests: test_bridge_neigh_suppress: Test unicast ARP/NS with suppression

Andrea Mayer (1):
      ipv6: sr: switch to GFP_ATOMIC flag to allocate memory during seg6local LWT setup

Andrii Staikov (1):
      ixgbe: add support for FW rollback mode

Andy Shevchenko (1):
      net: phy: Refactor fwnode_get_phy_node()

Anjaneyulu (1):
      wifi: iwlwifi: parse active and 20 MHz AP NVM channel flag

Antonio Quartulli (34):
      batman-adv: no need to start/stop queue on mesh-iface
      net: introduce OpenVPN Data Channel Offload (ovpn)
      ovpn: add basic netlink support
      ovpn: add basic interface creation/destruction/management routines
      ovpn: keep carrier always on for MP interfaces
      ovpn: introduce the ovpn_peer object
      ovpn: introduce the ovpn_socket object
      ovpn: implement basic TX path (UDP)
      ovpn: implement basic RX path (UDP)
      ovpn: implement packet processing
      ovpn: store tunnel and transport statistics
      ovpn: implement TCP transport
      skb: implement skb_send_sock_locked_with_flags()
      ovpn: add support for MSG_NOSIGNAL in tcp_sendmsg
      ovpn: implement multi-peer support
      ovpn: implement peer lookup logic
      ovpn: implement keepalive mechanism
      ovpn: add support for updating local or remote UDP endpoint
      ovpn: implement peer add/get/dump/delete via netlink
      ovpn: implement key add/get/del/swap via netlink
      ovpn: kill key and notify userspace in case of IV exhaustion
      ovpn: notify userspace when a peer is deleted
      ovpn: add basic ethtool support
      testing/selftests: add test tool and scripts for ovpn module
      MAINTAINERS: add Sabrina as official reviewer for ovpn
      MAINTAINERS: update git URL for ovpn
      ovpn: set skb->ignore_df = 1 before sending IPv6 packets out
      ovpn: don't drop skb's dst when xmitting packet
      selftest/net/ovpn: fix crash in case of getaddrinfo() failure
      ovpn: fix ndo_start_xmit return value on error
      selftest/net/ovpn: extend coverage with more test cases
      ovpn: drop useless reg_state check in keepalive worker
      ovpn: improve 'no route to host' debug message
      ovpn: fix check for skb_to_sgvec_nomark() return value

Arend van Spriel (3):
      wifi: brcmfmac: support per-vendor cfg80211 callbacks and firmware events
      wifi: brcmfmac: make per-vendor event map const
      wifi: brcmfmac: cyw: support external SAE authentication in station mode

Arnd Bergmann (2):
      bnxt_en: hide CONFIG_DETECT_HUNG_TASK specific code
      mdio: fix CONFIG_MDIO_DEVRES selects

Aryan Srivastava (1):
      net: phy: aquantia: fix commenting format

Avraham Stern (4):
      wifi: iwlwifi: mld: start AP with the correct bandwidth
      wifi: iwlwifi: mld: force the responder to use the full bandwidth
      wifi: iwlwifi: mld: add debugfs for using ptp clock time for monitor interface
      wifi: iwlwifi: add range response version 10 support

Balamurugan Mahalingam (1):
      wifi: ath12k: Add support for link specific datapath stats

Balamurugan S (7):
      wifi: ath12k: fix incorrect CE addresses
      wifi: ath12k: add ath12k_hw_params for IPQ5332
      wifi: ath12k: avoid m3 firmware download in AHB device IPQ5332
      wifi: ath12k: Add hw_params to remap CE register space for IPQ5332
      wifi: ath12k: add AHB driver support for IPQ5332
      wifi: ath12k: enable ath12k AHB support
      wifi: ath12k: Add support to clear qdesc array in REO cache

Baochen Qiang (34):
      wifi: ath12k: don't put ieee80211_chanctx_conf struct in ath12k_link_vif
      wifi: ath11k: determine PM policy based on machine model
      wifi: ath11k: introduce ath11k_core_continue_suspend_resume()
      wifi: ath11k: refactor ath11k_core_suspend/_resume()
      wifi: ath11k: support non-WoWLAN mode suspend as well
      wifi: ath11k: choose default PM policy for hibernation
      Reapply "wifi: ath11k: restore country code during resume"
      wifi: ath12k: introduce ath12k_fw_feature_supported()
      wifi: ath12k: use fw_features only when it is valid
      wifi: ath12k: support MLO as well if single_chip_mlo_support flag is set
      wifi: ath12k: identify assoc link vif in station mode
      wifi: ath12k: make assoc link associate first
      wifi: ath12k: group REO queue buffer parameters together
      wifi: ath12k: alloc REO queue per station
      wifi: ath12k: don't skip non-primary links for WCN7850
      wifi: ath12k: support 2 channels for single pdev device
      wifi: ath12k: fix a possible dead lock caused by ab->base_lock
      wifi: ath12k: refactor ath12k_reg_chan_list_event()
      wifi: ath12k: refactor ath12k_reg_build_regd()
      wifi: ath12k: add support to select 6 GHz regulatory type
      wifi: ath12k: move reg info handling outside
      wifi: ath12k: store reg info for later use
      wifi: ath12k: determine interface mode in _op_add_interface()
      wifi: ath12k: update regulatory rules when interface added
      wifi: ath12k: update regulatory rules when connection established
      wifi: ath12k: save power spectral density(PSD) of regulatory rule
      wifi: ath12k: add parse of transmit power envelope element
      wifi: ath12k: save max transmit power in vdev start response event from firmware
      wifi: ath12k: fill parameters for vdev set TPC power WMI command
      wifi: ath12k: add handler for WMI_VDEV_SET_TPC_POWER_CMDID
      wifi: ath12k: use WMI_VDEV_SET_TPC_POWER_CMDID when EXT_TPC_REG_SUPPORT for 6 GHz
      wifi: ath12k: fix regdomain update failure after 11D scan completes
      wifi: ath12k: fix regdomain update failure when adding interface
      wifi: ath12k: fix regdomain update failure when connection establishes

Baris Can Goral (1):
      replace strncpy with strscpy_pad

Bartosz Golaszewski (1):
      bcma: use new GPIO line value setter callbacks

Benjamin Berg (5):
      wifi: mac80211: do not offer a mesh path if forwarding is disabled
      wifi: iwlwifi: fix thermal code compilation with -Werror=cast-qual
      wifi: iwlwifi: mvm: use a radio/system specific power budget
      wifi: iwlwifi: mld: use a radio/system specific power budget
      wifi: iwlwifi: mld: call thermal exit without wiphy lock held

Benjamin Lin (1):
      wifi: mt76: mt7996: drop fragments with multicast or broadcast RA

Bert Karwatzki (1):
      wifi: check if socket flags are valid

Bhaskar Chowdhury (1):
      wifi: iwlwifi: fw: api: Absolute rudimentary typo fixes in the file power.h

Biju Das (19):
      dt-bindings: can: renesas,rcar-canfd: Simplify the conditional schema
      dt-bindings: can: renesas,rcar-canfd: Document RZ/G3E support
      can: rcar_canfd: Use of_get_available_child_by_name()
      can: rcar_canfd: Drop RCANFD_GAFLCFG_GETRNC macro
      can: rcar_canfd: Update RCANFD_GERFL_ERR macro
      can: rcar_canfd: Drop the mask operation in RCANFD_GAFLCFG_SETRNC macro
      can: rcar_canfd: Add rcar_canfd_setrnc()
      can: rcar_canfd: Update RCANFD_GAFLCFG macro
      can: rcar_canfd: Add rnc_field_width variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add max_aflpn variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add max_cftml variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add {nom,data}_bittiming variables to struct rcar_canfd_hw_info
      can: rcar_canfd: Add ch_interface_mode variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add shared_can_regs variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add struct rcanfd_regs variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add sh variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add external_clk variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Enhance multi_channel_irqs handling
      can: rcar_canfd: Add RZ/G3E support

Bitterblue Smith (10):
      wifi: rtw88: usb: Enable switching the RTL8814AU to USB 3
      wifi: rtw88: usb: Enable RX aggregation for RTL8814AU
      wifi: rtw88: Set AMPDU factor to hardware for RTL8814A
      wifi: rtw88: Don't set SUPPORTS_AMSDU_IN_AMPDU for RTL8814AU
      wifi: rtw88: Fix the module names printed in dmesg
      wifi: rtw88: Fix RX aggregation settings for RTL8723DS
      wifi: rtw88: Handle RTL8723D(S) with blank efuse
      wifi: rtw88: usb: Reduce control message timeout to 500 ms
      wifi: rtw88: usb: Upload the firmware in bigger chunks
      wifi: rtw88: Fix the random "error beacon valid" messages for USB

Bo-Cun Chen (1):
      net: ethernet: mtk_eth_soc: convert cap_bit in mtk_eth_muxc struct to u64

Boon Khai Ng (3):
      net: stmmac: Refactor VLAN implementation
      net: stmmac: stmmac_vlan: rename VLAN functions and symbol to generic symbol.
      net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN stripping

Breno Leitao (23):
      net: pass const to msg_data_left()
      trace: tcp: Add tracepoint for tcp_sendmsg_locked()
      netlink: Introduce nlmsg_payload helper
      neighbour: Use nlmsg_payload in neightbl_valid_dump_info
      neighbour: Use nlmsg_payload in neigh_valid_get_req
      rtnetlink: Use nlmsg_payload in valid_fdb_dump_strict
      mpls: Use nlmsg_payload in mpls_valid_fib_dump_req
      ipv6: Use nlmsg_payload in inet6_valid_dump_ifaddr_req
      ipv6: Use nlmsg_payload in inet6_rtm_valid_getaddr_req
      mpls: Use nlmsg_payload in mpls_valid_getroute_req
      net: fib_rules: Use nlmsg_payload in fib_valid_dumprule_req
      net: fib_rules: Use nlmsg_payload in fib_{new,del}rule()
      ipv6: Use nlmsg_payload in addrlabel file
      ipv6: Use nlmsg_payload in addrconf file
      ipv6: Use nlmsg_payload in route file
      ipv4: Use nlmsg_payload in devinet file
      ipv4: Use nlmsg_payload in fib_frontend file
      ipv4: Use nlmsg_payload in route file
      ipv4: Use nlmsg_payload in ipmr file
      vxlan: Use nlmsg_payload in vxlan_vnifilter_dump
      trace: tcp: Add const qualifier to skb parameter in tcp_probe event
      net: Use nlmsg_payload in neighbour file
      net: Use nlmsg_payload in rtnetlink file

Bui Quang Minh (7):
      selftests: net: move xdp_helper to net/lib
      selftests: net: add flag to force zerocopy mode in xdp_helper
      selftests: net: retry when bind returns EBUSY in xdp_helper
      selftests: net: add a virtio_net deadlock selftest
      xsk: respect the offsets when copying frags
      xsk: convert xdp_copy_frags_from_zc() to use page_pool_dev_alloc()
      xsk: add missing virtual address conversion for page

Carolina Jubran (1):
      net/mlx5e: Reuse per-RQ XDP buffer to avoid stack zeroing overhead

Chandrashekar Devegowda (1):
      Bluetooth: btintel_pcie: Dump debug registers on error

Charles Han (1):
      wifi: mt76: mt7996: Add NULL check in mt7996_thermal_init

Chen Linxuan (1):
      docs: tproxy: fix formatting for nft code block

Chen Ni (5):
      wifi: rtw88: sdio: Remove redundant 'flush_workqueue()' calls
      wifi: rtw88: usb: Remove redundant 'flush_workqueue()' calls
      net/mlx5: Use to_delayed_work()
      net: prestera: Use to_delayed_work()
      Bluetooth: hci_uart: Remove unnecessary NULL check before release_firmware()

Chiachang Wang (2):
      xfrm: Migrate offload configuration
      xfrm: Refactor migration setup during the cloning process

Chin-Yen Lee (1):
      wifi: rtw89: fix firmware scan delay unit for WiFi 6 chips

Chris Packham (1):
      net: mdio: Add RTL9300 MDIO driver

Christian Lamparter (1):
      wifi: p54: prevent buffer-overflow in p54_rx_eeprom_readback()

Christian Marangi (18):
      net: phy: mediatek: permit to compile test GE SOC PHY driver
      net: phy: mediatek: add Airoha PHY ID to SoC driver
      net: dsa: mt7530: generalize read port stats logic
      net: dsa: mt7530: move pkt size and rx err MIB counter to rmon stats API
      net: dsa: mt7530: move pause MIB counter to eth_ctrl stats API
      net: dsa: mt7530: move pkt stats and err MIB counter to eth_mac stats API
      net: dsa: mt7530: move remaining MIB counter to define
      net: dsa: mt7530: implement .get_stats64
      net: phy: mediatek: init val in .phy_led_polarity_set for AN7581
      net: phy: pass PHY driver to .match_phy_device OP
      net: phy: bcm87xx: simplify .match_phy_device OP
      net: phy: nxp-c45-tja11xx: simplify .match_phy_device OP
      net: phy: introduce genphy_match_phy_device()
      net: phy: Add support for Aeonsemi AS21xxx PHYs
      dt-bindings: net: Document support for Aeonsemi PHYs
      dt-bindings: net: dsa: mediatek,mt7530: Add airoha,an7583-switch
      net: dsa: mt7530: Add AN7583 support
      net: phy: mediatek: Add Airoha AN7583 PHY support

Christoph Hellwig (1):
      sctp: mark sctp_do_peeloff static

Christophe JAILLET (5):
      wifi: ath10k: Constify structures in hw.c
      wifi: mt76: Remove an unneeded local variable in mt76x02_dma_init()
      net: airoha: Fix an error handling path in airoha_alloc_gdm_port()
      mlxsw: core_thermal: Constify struct thermal_zone_device_ops
      cxgb4: Constify struct thermal_zone_device_ops

ChunHao Lin (2):
      r8169: add support for RTL8127A
      net: phy: realtek: add RTL8127-internal PHY

Colin Ian King (6):
      ice: make const read-only array dflt_rules static
      net: axienet: Fix spelling mistake "archecture" -> "architecture"
      net/mlx5: Fix spelling mistakes in mlx5_core_dbg message and comments
      net: dsa: rzn1_a5psw: Make the read-only array offsets static const
      net: ip_gre: Fix spelling mistake "demultiplexor" -> "demultiplexer"
      wifi: ath10k: Fix spelling mistake "comple" -> "complete"

Cosmin Ratiu (11):
      net/mlx5: Avoid using xso.real_dev unnecessarily
      xfrm: Use xdo.dev instead of xdo.real_dev
      xfrm: Remove unneeded device check from validate_xmit_xfrm
      xfrm: Add explicit dev to .xdo_dev_state_{add,delete,free}
      bonding: Mark active offloaded xfrm_states
      bonding: Fix multiple long standing offload races
      IB/IPoIB: Enqueue separate work_structs for each flushed interface
      IB/IPoIB: Replace vlan_rwsem with the netdev instance lock
      IB/IPoIB: Allow using netdevs that require the instance lock
      net/mlx5e: Don't drop RTNL during firmware flash
      net/mlx5e: Convert mlx5 netdevs to instance locking

Dan Carpenter (7):
      wifi: ath12k: Fix a couple NULL vs IS_ERR() bugs
      wifi: ath12k: Fix buffer overflow in debugfs
      rxrpc: rxgk: Set error code in rxgk_yfs_decode_ticket()
      rxrpc: rxgk: Fix some reference count leaks
      wifi: mt76: mt7925: Fix logical vs bitwise typo
      wifi: mt76: mt7996: remove duplicate check in mt7996_mcu_sta_mld_setup_tlv()
      net/mlx5: HWS, Fix an error code in mlx5hws_bwc_rule_create_complex()

Daniel Braunwarth (1):
      net: phy: realtek: Add support for WOL magic packet on RTL8211F

Daniel Gabay (1):
      wifi: iwlwifi: mld: add monitor internal station

Daniel Golle (1):
      net: ethernet: mtk_eth_soc: add support for MT7988 internal 2.5G PHY

Dave Ertman (4):
      iidc/ice/irdma: Rename IDC header file
      iidc/ice/irdma: Rename to iidc_* convention
      iidc/ice/irdma: Break iidc.h into two headers
      iidc/ice/irdma: Update IDC to support multiple consumers

Dave Marquardt (4):
      net: ibmveth: Indented struct ibmveth_adapter correctly
      net: ibmveth: Reset the adapter when unexpected states are detected
      net: ibmveth: added KUnit tests for some buffer pool functions
      net: ibmveth: Refactored veth_pool_store for better maintainability

David Heidelberg (2):
      dt-bindings: net: Add generic wireless controller
      dt-bindings: wireless: qcom,wcnss: Use wireless-controller.yaml

David Howells (15):
      rxrpc: kdoc: Update function descriptions and add link from rxrpc.rst
      rxrpc: Pull out certain app callback funcs into an ops table
      rxrpc: Remove some socket lock acquire/release annotations
      rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE
      rxrpc: Add the security index for yfs-rxgk
      rxrpc: Add YFS RxGK (GSSAPI) security class
      rxrpc: rxgk: Provide infrastructure and key derivation
      rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)
      rxrpc: rxgk: Implement connection rekeying
      rxrpc: Allow the app to store private data on peer structs
      rxrpc: Display security params in the afs_cb_call tracepoint
      afs: Use rxgk RESPONSE to pass token for callback channel
      rxrpc: Add more CHALLENGE/RESPONSE packet tracing
      rxrpc: rxperf: Add test RxGK server keys
      crypto/krb5: Fix change to use SG miter to use offset

David S. Miller (5):
      Merge branch 'bridge-mc-per-vlan-qquery'
      Merge branch 'pds_core-cleanups'
      Merge branch 'lan78xx-phylink-prep'
      Merge tag 'ovpn-net-next-20250515' of https://github.com/OpenVPN/ovpn-net-next
      Merge branch 'so_passrights'

David Wei (6):
      io_uring/zcrx: selftests: switch to using defer() for cleanup
      io_uring/zcrx: selftests: set hds_thresh to 0
      io_uring/zcrx: selftests: add test case for rss ctx
      io_uring/zcrx: selftests: use rand_port()
      io_uring/zcrx: selftests: parse json from ethtool -g
      io_uring/zcrx: selftests: fix setting ntuple rule into rss

Dian-Syuan Yang (1):
      wifi: rtw89: leave idle mode when setting WEP encryption for AP mode

Dimitri Fedrau (5):
      dt-bindings: net: ethernet-phy: add property mac-termination-ohms
      dt-bindings: net: dp83822: add constraints for mac-termination-ohms
      net: phy: Add helper for getting MAC termination resistance
      net: phy: dp83822: Add support for changing the MAC termination
      net: phy: marvell-88q2xxx: Enable temperature measurement in probe again

Dinesh Karthikeyan (1):
      wifi: ath12k: Add support to simulate firmware crash

Dmitry Antipov (3):
      wifi: rtw88: do not ignore hardware read error during DPK
      wifi: rt2x00: remove weird self-assignment in rt2800_loft_search()
      Bluetooth: MGMT: iterate over mesh commands in mgmt_mesh_foreach()

Donald Hunter (2):
      tools: ynl: handle broken pipe gracefully in CLI
      tools: ynl: parse extack for sub-messages

Dr. David Alan Gilbert (13):
      qed: Remove unused qed_memset_*ctx functions
      qed: Remove unused qed_calc_*_ctx_validation functions
      qed: Remove unused qed_ptt_invalidate
      qed: Remove unused qed_print_mcp_trace_*
      qed: Remove unused qed_db_recovery_dp
      net: 802: Remove unused p8022 code
      octeontx2-af: Remove unused rvu_npc_enable_bcast_entry
      rxrpc: Remove deadcode
      wifi: rtlwifi: Remove unused rtl_usb_{resume|suspend}
      wifi: rtlwifi: Remove uncalled stub rtl*_phy_ap_calibrate
      wifi: rtlwifi: Remove unused rtl_bb_delay()
      strparser: Remove unused __strp_unpause
      sctp: Remove unused sctp_assoc_del_peer and sctp_chunk_iif

Easwar Hariharan (1):
      netfilter: xt_IDLETIMER: convert timeouts to secs_to_jiffies()

Edward Adam Davis (1):
      wifi: mac80211_hwsim: Prevent tsf from setting if beacon is disabled

Eelco Chaudron (1):
      openvswitch: Stricter validation for the userspace action

Emmanuel Grumbach (7):
      wifi: iwlwifi: mld: remove stored_beacon support
      wifi: iwlwifi: update the PHY_CONTEXT_CMD API
      wifi: iwlwifi: pcie: add support for the reset handshake in MSI
      wifi: iwlwifi: add support for ALIVE v8
      wifi: iwlwifi: mld: support for COMPRESSED_BA_RES_API_S_VER_7
      wifi: iwlwifi: add support PE RF
      wifi: iwlwifi: drop whtc RF

En-Wei Wu (1):
      Bluetooth: btusb: use skb_pull to avoid unsafe access in QCA dump handling

Eric Biggers (13):
      r8152: use SHA-256 library API instead of crypto_shash API
      net/tg3: use crc32() instead of hand-rolled equivalent
      net: apple: bmac: use crc32() instead of hand-rolled equivalent
      net: introduce CONFIG_NET_CRC32C
      net: add skb_crc32c()
      net: use skb_crc32c() in skb_crc32c_csum_help()
      RDMA/siw: use skb_crc32c() instead of __skb_checksum()
      sctp: use skb_crc32c() instead of __skb_checksum()
      net: fold __skb_checksum() into skb_checksum()
      lib/crc32: remove unused support for CRC32C combination
      net: add skb_copy_and_crc32c_datagram_iter()
      nvme-tcp: use crc32c() and skb_copy_and_crc32c_datagram_iter()
      net: remove skb_copy_and_hash_datagram_iter()

Eric Dumazet (18):
      net: rps: change skb_flow_limit() hash function
      net: rps: annotate data-races around (struct sd_flow_limit)->count
      net: add data-race annotations in softnet_seq_show()
      net: rps: remove kfree_rcu_mightsleep() use
      net: remove cpu stall in txq_trans_update()
      tcp: add tcp_rcvbuf_grow() tracepoint
      tcp: fix sk_rcvbuf overshoot
      tcp: adjust rcvbuf in presence of reorders
      tcp: add receive queue awareness in tcp_rcv_space_adjust()
      tcp: remove zero TCP TS samples for autotuning
      tcp: fix initial tp->rcvq_space.space value for passive TS enabled flows
      tcp: always seek for minimal rtt in tcp_rcv_rtt_update()
      tcp: skip big rtt sample if receive queue is not empty
      tcp: increase tcp_limit_output_bytes default value to 4MB
      tcp: always use tcp_limit_output_bytes limitation
      tcp: increase tcp_rmem[2] to 32 MB
      net: rfs: add sock_rps_delete_flow() helper
      net: add debug checks in ____napi_schedule() and napi_poll()

Faicker Mo (1):
      net: openvswitch: Fix the dead loop of MPLS parse

Faizal Rahim (13):
      net: stmmac: move frag_size handling out of spin_lock
      net: ethtool: mm: reset verification status when link is down
      igc: rename xdp_get_tx_ring() for non-xdp usage
      igc: rename I225_RXPBSIZE_DEFAULT and I225_TXPBSIZE_DEFAULT
      igc: use FIELD_PREP and GENMASK for existing TX packet buffer size
      igc: optimize TX packet buffer utilization for TSN mode
      igc: use FIELD_PREP and GENMASK for existing RX packet buffer size
      igc: set the RX packet buffer size for TSN mode
      igc: add support for frame preemption verification
      igc: add support to set tx-min-frag-size
      igc: block setting preemptible traffic class in taprio
      igc: add support to get MAC Merge data via ethtool
      igc: add support to get frame preemption statistics via ethtool

Fan Gong (1):
      hinic3: module initialization and tx/rx logic

Felix Maurer (1):
      selftests: can: Import tst-filter from can-tests

Feng Jiang (1):
      wifi: mt76: scan: Fix 'mlink' dereferenced before IS_ERR_OR_NULL check

Feng Yang (1):
      selftests/bpf: Fix compilation errors

Fernando Fernandez Mancera (2):
      net: hsr: sync hw addr of slave2 according to slave1 hw addr on PRP
      netfilter: nft_tunnel: fix geneve_opt dump

Florian Westphal (15):
      netfilter: nf_tables: export set count and backend name to userspace
      selftests: netfilter: add conntrack stress test
      netfilter: nf_conntrack: speed up reads from nf_conntrack proc file
      selftests: netfilter: nft_fib.sh: check lo packets bypass fib lookup
      selftests: netfilter: fix conntrack stress test failures on debug kernels
      selftests: netfilter: nft_concat_range.sh: add coverage for 4bit group representation
      netfilter: xtables: support arpt_mark and ipv6 optstrip for iptables-nft only builds
      selftests: netfilter: nft_fib.sh: add 'type' mode tests
      selftests: netfilter: move fib vrf test to nft_fib.sh
      netfilter: nf_tables: nft_fib_ipv6: fix VRF ipv4/ipv6 result discrepancy
      netfilter: nf_tables: nft_fib: consistent l3mdev handling
      selftests: netfilter: nft_fib.sh: add type and oif tests with and without VRFs
      netfilter: conntrack: make nf_conntrack_id callable without a module dependency
      netfilter: nf_tables: add packets conntrack state to debug trace info
      selftests: netfilter: nft_queue.sh: include file transfer duration in log message

Frank Wunderlich (1):
      net: phy: mediatek: do not require syscon compatible for pio property

Gal Pressman (2):
      selftests: drv-net: rss_input_xfrm: Check test prerequisites before running
      ethtool: Block setting of symmetric RSS when non-symmetric rx-flow-hash is requested

Gang Yan (5):
      selftests: mptcp: add struct params in mptcp_diag
      selftests: mptcp: refactor send_query parameters for code clarity
      selftests: mptcp: refactor NLMSG handling with 'proto'
      selftests: mptcp: add helpers to get subflow_info
      selftests: mptcp: add chk_sublfow in diag.sh

Geert Uytterhoeven (1):
      dt-bindings: net: snps,dwmac: Align mdio node in example with bindings

Geliang Tang (3):
      mptcp: sched: split validation part
      selftests: mptcp: diag: drop nlh parameter of recv_nlmsg
      selftests: mptcp: sockopt: use IPPROTO_MPTCP for getaddrinfo

Greg Kroah-Hartman (1):
      net: phy: fix up const issues in to_mdio_device() and to_phy_device()

Gur Stavi (1):
      queue_api: reduce risk of name collision over txq

Gustavo A. R. Silva (2):
      wifi: mac80211: Avoid -Wflex-array-member-not-at-end warnings
      wifi: iwlwifi: mvm: Avoid -Wflex-array-member-not-at-end warning

Haiyang Zhang (1):
      net: mana: Add support for Multi Vports on Bare metal

Haiyue Wang (2):
      selftests: iou-zcrx: Get the page size at runtime
      selftests: iou-zcrx: Clean up build warnings for error format

Hangbin Liu (8):
      bonding: assign random address if device address is same as bond
      selftests: net: disable rp_filter after namespace initialization
      selftests: net: remove redundant rp_filter configuration
      selftests: net: use setup_ns for bareudp testing
      selftests: net: use setup_ns for SRv6 tests and remove rp_filter configuration
      selftests: netfilter: remove rp_filter configuration
      selftests: mptcp: remove rp_filter configuration
      selftests: net: move wait_local_port_listen to lib.sh

Hari Chandrakanthan (1):
      wifi: ath12k: fix link valid field initialization in the monitor Rx

Hari Kalavakunta (1):
      net: ncsi: Fix GCPS 64-bit member variables

Hariprasad Kelam (4):
      octeontx2-pf: AF_XDP: code clean up
      octeontx2-af: NPC: Clear Unicast rule on nixlf detach
      octeontx2-pf: QOS: Perform cache sync on send queue teardown
      octeontx2-pf: QOS: Refactor TC_HTB_LEAF_DEL_LAST callback

Heiner Kallweit (19):
      r8169: add helper rtl_csi_mod for accessing extended config space
      r8169: add helper rtl8125_phy_param
      net: phy: remove device_phy_find_device
      net: phy: remove redundant dependency on NETDEVICES for PHYLINK and PHYLIB
      r8169: refactor chip version detection
      r8169: add RTL_GIGA_MAC_VER_LAST to facilitate adding support for new chip versions
      r8169: use pci_prepare_to_sleep in rtl_shutdown
      net: phy: remove function stubs
      r8169: merge chip versions 70 and 71 (RTL8126A)
      r8169: merge chip versions 64 and 65 (RTL8125D)
      r8169: merge chip versions 52 and 53 (RTL8117)
      net: phy: factor out provider part from mdio_bus.c
      net: phy: remove stub for mdiobus_register_board_info
      net: phy: remove Kconfig symbol MDIO_DEVRES
      net: phy: fixed_phy: remove fixed_phy_register_with_gpiod
      net: phy: make mdio consumer / device layer a separate module
      net: phy: fixed_phy: remove irq argument from fixed_phy_add
      net: phy: fixed_phy: remove irq argument from fixed_phy_register
      net: phy: fixed_phy: constify status argument where possible

Henk Vergonet (1):
      wifi: mt76: mt76x2: Add support for LiteOn WN4516R,WN4519R

Henry Martin (2):
      wifi: mt76: mt7996: Fix null-ptr-deref in mt7996_mmio_wed_init()
      wifi: mt76: mt7915: Fix null-ptr-deref in mt7915_mmio_wed_init()

Horatiu Vultur (3):
      net: lan966x: Fix 1-step timestamping over ipv4 or ipv6
      net: phy: mscc: Fix memory leak when using one step timestamping
      net: phy: mscc: Stop clearing the the UDPv4 checksum for L2 frames

Howard Hsu (2):
      wifi: mt76: remove capability of partial bandwidth UL MU-MIMO
      wifi: mt76: mt7996: fix beamformee SS field

Hsin-chen Chuang (4):
      Bluetooth: Introduce HCI Driver protocol
      Bluetooth: btusb: Add HCI Drv commands for configuring altsetting
      Revert "Bluetooth: btusb: Configure altsetting for HCI_USER_CHANNEL"
      Revert "Bluetooth: btusb: add sysfs attribute to control USB alt setting"

Huacai Chen (3):
      net: stmmac: dwmac-loongson: Move queue number init to common function
      net: stmmac: dwmac-loongson: Add new multi-chan IP core support
      net: stmmac: dwmac-loongson: Add new GMAC's PCI device ID support

Huajian Yang (1):
      netfilter: bridge: Move specific fragmented packet to slow_path instead of dropping it

Ido Schimmel (16):
      vxlan: Add RCU read-side critical sections in the Tx path
      vxlan: Simplify creation of default FDB entry
      vxlan: Insert FDB into hash table in vxlan_fdb_create()
      vxlan: Unsplit default FDB entry creation and notification
      vxlan: Relocate assignment of default remote device
      vxlan: Use a single lock to protect the FDB table
      vxlan: Add a linked list of FDB entries
      vxlan: Use linked list to traverse FDB entries
      vxlan: Convert FDB garbage collection to RCU
      vxlan: Convert FDB flushing to RCU
      vxlan: Rename FDB Tx lookup function
      vxlan: Create wrappers for FDB lookup
      vxlan: Do not treat dst cache initialization errors as fatal
      vxlan: Introduce FDB key structure
      vxlan: Convert FDB table to rhashtable
      ipv4: Honor "ignore_routes_with_linkdown" sysctl in nexthop selection

Ilan Peer (1):
      wifi: iwlfiwi: mvm: Fix the rate reporting

Jacob Keller (2):
      net: ptp: introduce .supported_extts_flags to ptp_clock_info
      net: ptp: introduce .supported_perout_flags to ptp_clock_info

Jakub Kicinski (189):
      Merge branch 'rps-misc-changes'
      Merge branch 'udp_tunnel-gro-optimizations'
      net: avoid potential race between netdev_get_by_index_lock() and netns switch
      net: designate XSK pool pointers in queues as "ops protected"
      netdev: add "ops compat locking" helpers
      netdev: don't hold rtnl_lock over nl queue info get when possible
      xdp: double protect netdev->xdp_flags with netdev->lock
      netdev: depend on netdev->lock for xdp features
      docs: netdev: break down the instance locking info per ops struct
      netdev: depend on netdev->lock for qstats in ops locked drivers
      Merge branch 'net-depend-on-instance-lock-for-queue-related-netlink-ops'
      Merge branch 'bridge-prevent-unicast-arp-ns-packets-from-being-suppressed-by-bridge'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'tcp-add-a-new-tw_paws-drop-reason'
      Merge branch 'net-stmmac-stmmac_pltfr_find_clk'
      Merge branch 'trace-add-tracepoint-for-tcp_sendmsg_locked'
      netlink: specs: rename rtnetlink specs in accordance with family name
      netlink: specs: rt-route: specify fixed-header at operations level
      netlink: specs: rt-addr: remove the fixed members from attrs
      netlink: specs: rt-route: remove the fixed members from attrs
      netlink: specs: rt-addr: add C naming info
      netlink: specs: rt-route: add C naming info
      tools: ynl: support creating non-genl sockets
      tools: ynl-gen: don't consider requests with fixed hdr empty
      tools: ynl: don't use genlmsghdr in classic netlink
      tools: ynl-gen: consider dump ops without a do "type-consistent"
      tools: ynl-gen: use family c-name in notifications
      tools: ynl: generate code for rt-addr and add a sample
      tools: ynl: generate code for rt-route and add a sample
      Merge branch 'tools-ynl-c-basic-netlink-raw-support'
      Merge branch 'net-retire-dccp-socket'
      Merge branch 'add-l2-hw-acceleration-for-airoha_eth-driver'
      net: convert dev->rtnl_link_state to a bool
      Merge branch 'pktgen-code-cleanup'
      Merge branch 'add-support-for-mdb-offload-failure-notification'
      Merge branch 'cpsw-bindings-for-5000m-fixed-link'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'fix-late-dma-unmap-crash-for-page-pool'
      Merge branch 'net-convert-exit_batch_rtnl-to-exit_rtnl'
      Merge branch 'net-stmmac-remove-unnecessary-initialisation-of-1-s-tic-counter'
      Merge branch 'net-mlx5-hws-refactor-action-ste-handling'
      Merge branch 'rxrpc-afs-add-afs-gssapi-security-class-to-af_rxrpc-and-kafs'
      Merge branch 'net-stmmac-qcom-ethqos-simplifications'
      Merge branch 'mptcp-various-small-and-unrelated-improvements'
      Merge branch 'qed-deadcoding'
      Merge branch 'net-introduce-nlmsg_payload-helper'
      Merge branch 'net-stmmac-anarion-cleanups'
      Merge branch 'net-stmmac-ingenic-cleanups'
      Merge branch 'net-ptp-driver-opt-in-for-supported-ptp-ioctl-flags'
      Merge branch 'net-ethernet-ti-am65-cpsw-fix-mac-address-fetching'
      docs: networking: clarify intended audience of netdevices.rst
      Merge branch 'net-stmmac-sti-cleanups'
      Merge branch 'adopting-nlmsg_payload-in-ipv4-ipv6'
      Merge branch '10GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-stmmac-sunxi-cleanups'
      netdev: fix the locking for netdev notifications
      net: add UAPI to the header guard in various network headers
      tools: ynl: add missing header deps
      Merge branch 'net-adopting-nlmsg_payload-final-series'
      Merge branch 'net-stmmac-socfpga-fix-init-ordering-and-cleanups'
      Merge branch 'bnxt_en-update-for-net-next'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'net-phy-dp83822-add-support-for-changing-the-mac-series-termination'
      Merge branch 'add-gbeth-glue-layer-driver-for-renesas-rz-v2h-p-soc'
      Merge branch 'net-followup-series-for-exit_rtnl'
      Merge branch 'implement-udp-tunnel-port-for-txgbe'
      netlink: specs: allow header properties for attribute sets
      netlink: specs: rt-link: remove the fixed members from attrs
      netlink: specs: rt-link: remove if-netnsid from attr list
      netlink: specs: rt-link: remove duplicated group in attr list
      netlink: specs: rt-link: add C naming info
      netlink: specs: rt-link: adjust AF_ nest for C codegen
      netlink: specs: rt-link: make bond's ipv6 address attribute fixed size
      netlink: specs: rt-link: add notification for newlink
      netlink: specs: rt-neigh: add C naming info
      netlink: specs: rt-neigh: make sure getneigh is consistent
      netlink: specs: rtnetlink: correct notify properties
      netlink: specs: rt-rule: add C naming info
      Merge branch 'netlink-specs-rtnetlink-adjust-specs-for-c-codegen'
      Merge branch 'r8169-merge-chip-versions'
      Merge branch 'enable-multiple-irq-lines-support-in-airoha_eth-driver'
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'net-mlx5-hws-improve-ip-version-handling'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-bcmasp-add-v3-0-and-remove-v2-0'
      Merge branch 'tcp-fastopen-observability'
      tools: ynl: fix the header guard name for OVPN
      Merge branch 'fix-netdevim-to-correctly-mark-napi-ids'
      Merge branch 'io_uring-zcrx-fix-selftests-and-add-new-test-for-rss-ctx'
      Merge branch 'net-stmmac-socfpga-1000basex-support-and-cleanups'
      Merge branch 'net-stmmac-dwmac-loongson-add-loongson-2k3000-support'
      Merge branch 'veth-qdisc-backpressure-and-qdisc-check-refactor'
      Merge branch 'virtio-net-disable-delayed-refill-when-pausing-rx'
      Merge branch 'phase-out-hybrid-pci-devres-api'
      Merge branch 'io_uring-zcrx-selftests-more-cleanups'
      Merge branch 'xsk-respect-the-offsets-when-copying-frags'
      Merge tag 'nf-next-25-04-29' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      tools: ynl-gen: fix comment about nested struct dict
      tools: ynl-gen: factor out free_needs_iter for a struct
      tools: ynl-gen: fill in missing empty attr lists
      tools: ynl: let classic netlink requests specify extra nlflags
      tools: ynl-gen: support using dump types for ntf
      tools: ynl-gen: support CRUD-like notifications for classic Netlink
      tools: ynl-gen: multi-attr: type gen for string
      tools: ynl-gen: mutli-attr: support binary types with struct
      tools: ynl-gen: array-nest: support put for scalar
      tools: ynl-gen: array-nest: support binary array with exact-len
      tools: ynl-gen: don't init enum checks for classic netlink
      tools: ynl: allow fixed-header to be specified per op
      Merge branch 'net-stmmac-replace-speed_mode_2500-method'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'selftests-mptcp-increase-code-coverage'
      Merge branch 'net-ethtool-introduce-ethnl-dump-helpers'
      selftests: net: exit cleanly on SIGTERM / timeout
      Merge branch 'devlink-sanitize-variable-typed-attributes'
      Merge tag 'wireless-next-2025-05-06' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      tools: ynl-gen: rename basic presence from 'bit' to 'present'
      tools: ynl-gen: split presence metadata
      tools: ynl-gen: move the count into a presence struct too
      Merge branch 'tools-ynl-gen-split-presence-metadata'
      netlink: specs: nl80211: drop structs which are not uAPI
      netlink: specs: ovs: correct struct names
      netlink: specs: remove implicit structs for SNMP counters
      netlink: specs: rt-link: remove implicit structs from devconf
      Merge branch 'netlink-specs-remove-phantom-structs'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      selftests: net-drv: remove the nic_performance and nic_link_layer tests
      Merge branch 'add-more-features-for-enetc-v4-round-2'
      Merge branch 'dpaa_eth-conversion-to-ndo_hwtstamp_get-and-ndo_hwtstamp_set'
      Merge tag 'batadv-next-pullrequest-20250509' of git://git.open-mesh.org/linux-merge
      Merge branch 'refactoring-designware-vlan-code'
      selftests: drv-net: ping: make sure the ping test restores checksum offload
      Merge branch 'selftests-net-configure-rp_filter-in-setup_ns'
      Merge branch 'net-vertexcom-mse102x-improve-rx-handling'
      Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/linux
      netlink: fix policy dump for int with validation callback
      tools: ynl-gen: support sub-type for binary attributes
      tools: ynl-gen: auto-indent else
      tools: ynl-gen: support struct for binary attributes
      Merge branch 'net-mlx5-hws-complex-matchers-and-rehash-mechanism-fixes'
      Merge branch 'misc-drivers-sw-timestamp-changes'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'tcp-receive-side-improvements'
      net: sched: uapi: add more sanely named duplicate defines
      tools: ynl-gen: array-nest: support arrays of nests
      netlink: specs: rt-link: add C naming info for ovpn
      tools: ynl-gen: factor out the annotation of pure nested struct
      tools: ynl-gen: prepare for submsg structs
      tools: ynl-gen: submsg: plumb thru an empty type
      tools: ynl-gen: submsg: render the structs
      tools: ynl-gen: submsg: support parsing and rendering sub-messages
      tools: ynl: submsg: reverse parse / error reporting
      tools: ynl: enable codegen for all rt- families
      tools: ynl: add a sample for rt-link
      Merge branch 'tools-ynl-gen-support-sub-messages-and-rt-link'
      Merge branch 'vsock-test-improve-sigpipe-test-reliability'
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'queue_api-reduce-risk-of-name-collision-over-txq'
      Merge branch 'add-built-in-2-5g-ethernet-phy-support-on-mt7988'
      net: let lockdep compare instance locks
      Merge branch 'net-phy-fixed_phy-simplifications-and-improvements'
      Merge branch 'net-bcmgenet-64bit-stats-and-expose-more-stats-in-ethtool'
      Merge branch 'ipv6-follow-up-for-rtnl-free-rtm_newroute-series'
      Merge branch 'net-airoha-add-per-flow-stats-support-to-hw-flowtable-offloading'
      tools: ynl-gen: add makefile deps for neigh
      netlink: specs: tc: remove duplicate nests
      netlink: specs: tc: use tc-gact instead of tc-gen as struct name
      netlink: specs: tc: add C naming info
      netlink: specs: tc: drop the family name prefix from attrs
      tools: ynl-gen: support passing selector to a nest
      tools: ynl-gen: move fixed header info from RenderInfo to Struct
      tools: ynl-gen: support local attrs in _multi_parse
      tools: ynl-gen: support weird sub-message formats
      tools: ynl: enable codegen for TC
      netlink: specs: tc: add qdisc dump to TC spec
      tools: ynl: add a sample for TC
      Merge branch 'tools-ynl-gen-add-support-for-inherited-selector-and-therefore-tc'
      Merge branch 'net-faster-and-simpler-crc32c-computation'
      Merge branch 'net-phy-add-support-for-new-aeonsemi-phys'
      Merge branch 'net-mlx5-hws-set-of-fixes-and-adjustments'
      Merge branch 'net-mlx5-convert-mlx5-to-netdev-instance-locking'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'for-net-next-2025-05-22' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Merge tag 'wireless-next-2025-05-22' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'refactor-phy-reset-handling-and'
      Merge branch 'devmem-tcp-minor-cleanups-and-ksft-improvements'

Janne Grunau (3):
      dt-bindings: net: Add network-class schema for mac-address properties
      dt-bindings: wireless: bcm4329-fmac: Use wireless-controller.yaml schema
      dt-bindings: wireless: silabs,wfx: Use wireless-controller.yaml

Jason A. Donenfeld (2):
      wireguard: netlink: use NLA_POLICY_MASK where possible
      wireguard: selftests: specify -std=gnu17 for bash

Jason Xing (5):
      net: thunder: make tx software timestamp independent
      net: mlx4: add SOF_TIMESTAMPING_TX_SOFTWARE flag when getting ts info
      net: atlantic: generate software timestamp just before the doorbell
      net: cxgb4: generate software timestamp just before the doorbell
      net: stmmac: generate software timestamp just before the doorbell

Jedrzej Jagielski (14):
      devlink: add value check to devlink_info_version_put()
      ixgbe: add initial devlink support
      ixgbe: add handler for devlink .info_get()
      ixgbe: add .info_get extension specific for E610 devices
      ixgbe: add E610 functions getting PBA and FW ver info
      ixgbe: extend .info_get() with stored versions
      ixgbe: add device flash update via devlink
      ixgbe: add support for devlink reload
      ixgbe: add FW API version check
      ixgbe: add E610 implementation of FW recovery mode
      ixgbe: create E610 specific ethtool_ops structure
      ixgbe: add support for ACPI WOL for E610
      ixgbe: apply different rules for setting FC on E610
      ixgbe: add E610 .set_phys_id() callback implementation

Jeff Johnson (3):
      wifi: ath12k: Fix misspelling "upto" in dp.c
      wifi: ath12k: ahb: Replace del_timer_sync() with timer_delete_sync()
      wifi: iwlwifi: Add short description to enum iwl_power_scheme

Jeremy Harris (2):
      tcp: fastopen: note that a child socket was created
      tcp: fastopen: pass TFO child indication through getsockopt

Jeremy Kerr (2):
      net: mctp: use nlmsg_payload() for netlink message data extraction
      net: mctp: start tx queue on netdev open

Jesper Dangaard Brouer (2):
      net: sched: generalize check for no-queue qdisc on TX queue
      veth: apply qdisc backpressure on full ptr_ring to reduce TX drops

Jiande Lu (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3630 for MT7925

Jiawen Wu (17):
      net: txgbe: Update module description
      net: txgbe: Support to set UDP tunnel port
      net: wangxun: restrict feature flags for tunnel packets
      net: txgbe: Fix pending interrupt
      net: wangxun: Correct clerical errors in comments
      net: libwx: Fix log level
      net: txgbe: Remove specified SP type
      net: wangxun: Use specific flag bit to simplify the code
      net: txgbe: Distinguish between 40G and 25G devices
      net: txgbe: Implement PHYLINK for AML 25G/10G devices
      net: txgbe: Support to handle GPIO IRQs for AML devices
      net: txgbe: Correct the currect link settings
      net: txgbe: Restrict the use of mismatched FW versions
      net: txgbe: Implement PTP for AML devices
      net: txgbe: Implement SRIOV for AML devices
      net: libwx: Fix statistics of multicast packets
      net: txgbe: Support the FDIR rules assigned to VFs

Jiayuan Chen (2):
      tcp: add TCP_RFC7323_TW_PAWS drop reason
      tcp: add LINUX_MIB_PAWS_TW_REJECTED counter

Jiri Pirko (4):
      tools: ynl-gen: allow noncontiguous enums
      devlink: define enum for attr types of dynamic attributes
      devlink: avoid param type value translations
      devlink: use DEVLINK_VAR_ATTR_TYPE_* instead of NLA_* in fmsg

Jiri Slaby (SUSE) (1):
      irqdomain: ssb: Switch to irq_domain_create_linear()

Joe Damato (4):
      netdevsim: Mark NAPI ID on skb in nsim_rcv
      selftests: drv-net: Factor out ksft C helpers
      selftests: drv-net: Test that NAPI ID is non-zero
      tools/Makefile: Add ynl target

Johan Hovold (4):
      wifi: ath12k: extend dma mask to 36 bits
      wifi: ath11k: fix ring-buffer corruption
      wifi: ath11k: fix rx completion meta data corruption
      wifi: ath12k: fix ring-buffer corruption

Johannes Berg (141):
      wifi: free SKBTX_WIFI_STATUS skb tx_flags flag
      wifi: cfg80211/mac80211: remove more 5/10 MHz code
      wifi: iwlwifi: mvm: remove IWL_EMPTYING_HW_QUEUE_DELBA state
      wifi: iwlwifi: fw: do reset handshake during assert if needed
      wifi: iwlwifi: mld: remove P2P powersave tracking
      wifi: iwlwifi: mld: tests: simplify le32 bitfield handling
      net: ethernet: mtk_wed: annotate RCU release in attach()
      Merge tag 'ath-next-20250418' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath into wireless-next
      wifi: iwlwifi: mld: clarify variable type
      wifi: iwlwifi: mld: fix iwl_mld_emlsr_disallowed_with_link() return
      wifi: iwlwifi: mld: use cfg80211_chandef_get_width()
      wifi: iwlwifi: mld: allow EMLSR on separated 5 GHz subbands
      wifi: iwlwifi: define API for external FSEQ images
      wifi: iwlwifi: mld: skip unknown FW channel load values
      wifi: iwlwifi: clean up band in RX metadata
      wifi: iwlwifi: mld: rx: simplify channel handling
      wifi: iwlwifi: mld: simplify iwl_mld_rx_fill_status()
      wifi: iwlwifi: clean up config macro
      Revert "wifi: iwlwifi: clean up config macro"
      wifi: iwlwifi: mld: refactor tests to use chandefs
      wifi: iwlwifi: mld: tests: extend link pair tests
      wifi: iwlwifi: avoid scheduling restart during restart
      wifi: iwlwifi: implement TOP reset follower
      wifi: iwlwifi: mld: handle SW reset w/o NIC error
      wifi: iwlwifi: implement TOP reset
      wifi: iwlwifi: dvm: fix various W=1 warnings
      wifi: iwlwifi: mld: set rx_mpdu_cmd_hdr_size
      wifi: iwlwifi: mvm: remove nl80211 testmode
      wifi: iwlwifi: clean up config macro
      wifi: iwlwifi: remove TH/TH1 RF types
      wifi: iwlwifi: unify some configurations
      wifi: iwlwifi: pcie: add entry for Killer AX1650i on AdL-P
      wifi: iwlwifi: tests: check for device names
      wifi: iwlwifi: cfg: remove fw_name_mac
      wifi: iwlwifi: cfg: unify Qu/QuZ configs
      wifi: iwlwifi: cfg: unify Killer 1650s/i with Qu/Hr
      wifi: iwlwifi: cfg: remove unused config externs
      wifi: iwlwifi: cfg: remove max_tx_agg_size
      wifi: iwlwifi: cfg: remove iwl_ax201_cfg_qu_hr
      wifi: iwlwifi: cfg: remove duplicated iwl_cfg_gl
      wifi: iwlwifi: cfg: remove duplicated Sc device configs
      wifi: iwlwifi: cfg: remove iwl_cfg_br
      wifi: iwlwifi: tests: check configs are not duplicated
      wifi: iwlwifi: tests: check transport configs are not duplicated
      wifi: iwlwifi: cfg: clean up BW limit and subdev matching
      wifi: iwlwifi: cfg: rename BW_NO_LIMIT to BW_NOT_LIMITED
      wifi: iwlwifi: pcie: remove 'ent' argument from alloc
      wifi: iwlwifi: cfg: minor fixes for Sc
      wifi: iwlwifi: cfg: finish config split
      wifi: iwlwifi: cfg: move all names out of configs
      wifi: iwlwifi: tests: check for duplicate name strings
      wifi: iwlwifi: cfg: reduce mac_type to u8
      wifi: iwlwifi: cfg: remove unnecessary configs
      wifi: iwlwifi: pcie: don't call itself indirectly
      wifi: iwlwifi: mvm: add command order checks to kunit
      wifi: iwlwifi: remove iwl_cmd_groups_verify_sorted()
      wifi: iwlwifi: pcie: rename "continuous" memory
      wifi: iwlwifi: pcie: move ME check data to pcie
      wifi: iwlwifi: pcie: move invalid TX CMD into PCIe
      wifi: iwlwifi: pcie: move wait_command_queue into PCIe
      wifi: iwlwifi: unexport iwl_trans_pcie_send_hcmd()
      wifi: iwlwifi: remove PM mode and send-in-D3
      wifi: iwlwifi: pass full FW info to transport
      wifi: iwlwifi: trans: remove hw_id_str
      wifi: iwlwifi: trans: remove hw_wfpm_id
      wifi: iwlwifi: pcie: remove constant wdg_timeout
      wifi: iwlwifi: remove bc_table_dword transport config
      wifi: iwlwifi: trans: remove SCD base address validation
      wifi: iwlwifi: trans: collect device information
      wifi: iwlwifi: rework transport configuration
      wifi: iwlwifi: move STEP config into trans->conf
      wifi: iwlwifi: trans: move ext_32khz_clock_valid to config
      wifi: iwlwifi: remove sku_id from trans
      wifi: iwlwifi: fw: remove RATE_MCS_NSS_POS
      wifi: iwlwifi: rename modulation type values
      wifi: iwlwifi: mld: build HT/VHT injected rate in v2
      wifi: iwlwifi: mld: don't report bad EHT rate to mac80211
      wifi: iwlwifi: mvm: don't report bad EHT rate to mac80211
      wifi: iwlwifi: mvm: remove HT greenfield support
      wifi: iwlwifi: tests: allow same config for different MACs
      wifi: iwlwifi: cfg: use minimum API version 97 for Sc/Dr
      wifi: iwlwifi: tests: simplify devinfo_no_trans_cfg_dups()
      wifi: iwlwifi: dvm: pair transport op-mode enter/leave
      wifi: iwlwifi: pcie: log async commands
      wifi: iwlwifi: dvm: init 'keep_alive_beacons' in power tables
      wifi: iwlwifi: remove NVM C step override
      wifi: iwlwifi: mvm: fix beacon CCK flag
      wifi: iwlwifi: make iwl_uefi_get_uats_table() return void
      wifi: iwlwifi: fix 6005N/SFF match
      wifi: iwlwifi: handle v3 rates
      wifi: iwlwifi: cfg: remove 6 GHz from ht40_bands
      wifi: iwlwifi: cfg: inline HT params
      wifi: iwlwifi: pcie: remove 0x2726 devices
      wifi: iwlwifi: add JF1/JF2 RF for dynamic FW building
      wifi: iwlwifi: build 9000 series FW filenames dynamically
      wifi: iwlwifi: cfg: remove QuZ/JF special cases
      wifi: iwlwifi: cfg: remove 'cdb' value
      wifi: iwlwifi: cfg: build ax210 family FW names dynamically
      wifi: iwlwifi: cfg: handle cc firmware dynamically
      wifi: iwlwifi: cfg: remove nvm_hw_section_num from new devices
      wifi: iwlwifi: pass trans to iwl_parse_nvm_mcc_info()
      wifi: iwlwifi: rename cfg_trans_params to mac_cfg
      wifi: iwlwifi: cfg: remove dbgc_supported field
      wifi: iwlwifi: cfg: remove rf_id field
      wifi: iwlwifi: rename struct iwl_base_params
      wifi: iwlwifi: cfg: remove eeprom_size from new devices
      wifi: iwlwifi: cfg: remove DCCM offsets from new devices
      wifi: iwlwifi: cfg: move MAC parameters to MAC data
      wifi: iwlwifi: remove unused high_temp from iwl_cfg
      wifi: iwlwifi: cfg: add ucode API min/max to MAC config
      wifi: iwlwifi: cfg: unify num_rbds config
      wifi: iwlwifi: cfg: unify JF configs
      wifi: iwlwifi: cfg: unify HR configs
      wifi: iwlwifi: cfg: add GF RF config
      wifi: iwlwifi: cfg: add FM RF config
      wifi: iwlwifi: cfg: clean up Sc/Dr/Br configs
      wifi: iwlwifi: rename iwl_cfg to iwl_rf_cfg
      wifi: iwlwifi: mvm/mld: allow puncturing use in 5 GHz
      wifi: iwlwifi: dbg: fix dump trigger split check
      wifi: iwlwifi: cfg: remove some unused names
      wifi: iwlwifi: cfg: fix some device names
      wifi: iwlwifi: cfg: fix Ma device configs
      wifi: iwlwifi: cfg: fix and unify Killer/JF configs
      wifi: iwlwifi: cfg: unify and add some Killer devices
      wifi: iwlwifi: cfg: clean up HR device matching
      wifi: iwlwifi: tests: make subdev match test more precise
      wifi: iwlwifi: cfg: clean up JF device matching
      wifi: iwlwifi: cfg: clean up GF device matching
      wifi: iwlwifi: cfg: fix and clean up FM/WH device matching
      wifi: iwlwifi: cfg: fix PE RF names
      wifi: iwlwifi: cfg: add a couple of older devices
      wifi: iwlwifi: cfg: remove MAC type/step matching
      wifi: iwlwifi: cfg: mark Ty devices as discrete
      wifi: iwlwifi: cfg: clean up dr/br configs
      wifi: iwlwifi: cfg: reduce configuration struct size
      wifi: iwlwifi: fw: api: include required headers in rs/location
      Merge tag 'iwlwifi-next-2025-05-15' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      Merge tag 'rtw-next-2025-05-16' of https://github.com/pkshih/rtw
      net: netlink: reduce extack cookie size
      Merge tag 'ath-next-20250521' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'mt76-next-2025-05-21' of https://github.com/nbd168/wireless

Jon Kohler (1):
      vhost/net: Defer TX queue re-enable until after sendmsg

Jonas Gorski (1):
      net: dsa: b53: implement setting ageing time

Jordan Rife (8):
      bpf: udp: Make mem flags configurable through bpf_iter_udp_realloc_batch
      bpf: udp: Make sure iter->batch always contains a full bucket snapshot
      bpf: udp: Get rid of st_bucket_done
      bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch items
      bpf: udp: Avoid socket skips and repeats during iteration
      selftests/bpf: Return socket cookies from sock_iter_batch progs
      selftests/bpf: Add tests for bucket resume logic in UDP socket iterators
      wireguard: allowedips: add WGALLOWEDIP_F_REMOVE_ME flag

Joseph Huang (3):
      net: bridge: mcast: Add offload failed mdb flag
      net: bridge: Add offload_fail_notification bopt
      net: bridge: mcast: Notify on mdb offload failure

Joshua Washington (1):
      xdp: create locked/unlocked instances of xdp redirect target setters

Julian Vetter (4):
      eth: nfp: remove __get_unaligned_cpu32 from netronome drivers
      net: remove __get_unaligned_cpu32 from macvlan driver
      net: ipvlan: remove __get_unaligned_cpu32 from ipvlan driver
      wifi: mac80211: Replace __get_unaligned_cpu32 in mesh_pathtbl.c

Justin Chen (8):
      dt-bindings: net: brcm,asp-v2.0: Remove asp-v2.0
      dt-bindings: net: brcm,unimac-mdio: Remove asp-v2.0
      net: bcmasp: Remove support for asp-v2.0
      net: phy: mdio-bcm-unimac: Remove asp-v2.0
      dt-bindings: net: brcm,asp-v2.0: Add asp-v3.0
      dt-bindings: net: brcm,unimac-mdio: Add asp-v3.0
      net: bcmasp: Add support for asp-v3.0
      net: phy: mdio-bcm-unimac: Add asp-v3.0

Justin Iurman (2):
      net: ipv6: ioam6: use consistent dst names
      net: ipv6: ioam6: fix double reallocation

Justin Lai (3):
      rtase: Add ndo_setup_tc support for CBS offload in traffic control setup
      rtase: Modify the format specifier in snprintf to %u
      rtase: Use min() instead of min_t()

Kalesh AP (2):
      bnxt_en: Remove unused field "ref_count" in struct bnxt_ulp
      bnxt_en: Remove unused macros in bnxt_ulp.h

Kang Yang (14):
      wifi: ath12k: delete mon reap timer
      wifi: ath12k: parse msdu_end tlv in ath12k_dp_mon_rx_parse_status_tlv()
      wifi: ath12k: avoid call ath12k_dp_mon_parse_rx_dest_tlv() for WCN7850
      wifi: ath12k: add srng config template for mon status ring
      wifi: ath12k: add ring config for monitor mode on WCN7850
      wifi: ath12k: add interrupt configuration for mon status ring
      wifi: ath12k: add monitor mode handler by monitor status ring interrupt
      wifi: ath12k: add support to reap and process monitor status ring
      wifi: ath12k: fix macro definition HAL_RX_MSDU_PKT_LENGTH_GET
      wifi: ath12k: use ath12k_buffer_addr in ath12k_dp_rx_link_desc_return()
      wifi: ath12k: add support to reap and process mon dest ring
      wifi: ath12k: init monitor parameters for WCN7850
      wifi: ath12k: use different packet offset for WCN7850
      wifi: ath12k: enable monitor mode for WCN7850

Karol Kolacinski (3):
      ice: remove SW side band access workaround for E825
      ice: refactor ice_sbq_msg_dev enum
      ice: enable timesync operation on 2xNAC E825 devices

Karthikeyan Kathirvel (1):
      wifi: ieee80211: define beacon protection bit field

Karthikeyan Periyasamy (4):
      wifi: ath12k: Replace band define G with GHZ where appropriate
      wifi: ath12k: fix NULL access in assign channel context handler
      wifi: ath12k: Refactor the monitor channel context procedure
      wifi: ath12k: Move to NO_VIRTUAL monitor

Kees Cook (20):
      wifi: carl9170: Add __nonstring annotations for unterminated strings
      net: ethtool: Adjust exactly ETH_GSTRING_LEN-long stats to use memcpy
      net/mlx5e: ethtool: Fix formatting of ptp_rq0_csum_complete_tail_slow
      emulex/benet: Annotate flash_cookie as nonstring
      ipv4: fib: Fix fib_info_hash_alloc() allocation type
      pds_core: Allocate pdsc_viftype_defaults copy with ARRAY_SIZE()
      net/mlx4_core: Adjust allocation type for buddy->bits
      nfp: xsk: Adjust allocation type for nn->dp.xsk_pools
      ptp: ocp: Add const to bp->attr_group allocation type
      wifi: rtw89: fw: Remove "const" on allocation type
      Bluetooth: btintel: Check dsbr size from EFI variable
      net: core: Convert inet_addr_is_any() to sockaddr_storage
      net: core: Switch netif_set_mac_address() to struct sockaddr_storage
      net/ncsi: Use struct sockaddr_storage for pending_mac
      ieee802154: Use struct sockaddr_storage with dev_set_mac_address()
      net: usb: r8152: Convert to use struct sockaddr_storage internally
      net: core: Convert dev_set_mac_address() to struct sockaddr_storage
      rtnetlink: do_setlink: Use struct sockaddr_storage
      net: core: Convert dev_set_mac_address_user() to use struct sockaddr_storage
      wireguard: global: add __nonstring annotations for unterminated strings

Kevin Paul Reddy Janagari (1):
      tipc: Removing deprecated strncpy()

Kiran K (1):
      Bluetooth: btintel_pcie: Do not generate coredump for diagnostic events

Konrad Dybcio (1):
      net: ipa: Make the SMEM item ID constant

Kory Maincent (1):
      net: Add support for providing the PTP hardware source in tsinfo

Krzysztof Hałasa (1):
      usbnet: asix AX88772: leave the carrier control to phylink

Krzysztof Kozlowski (3):
      ptp: Do not enable by default during compile testing
      Bluetooth: btmrvl_sdio: Fix wakeup source leaks on device unbind
      Bluetooth: btmtksdio: Fix wakeup source leaks on device unbind

Kuan-Chung Chen (6):
      wifi: rtw89: 8922a: fix TX fail with wrong VCO setting
      wifi: rtw89: set pre-calculated antenna matrices for HE trigger frame
      wifi: rtw89: 8922a: increase beacon loss to 6 seconds
      wifi: rtw89: acpi: introduce country specific TAS enabling
      wifi: rtw89: phy: add C2H event handler for report of FW scan
      wifi: rtw89: constrain TX power according to dynamic antenna power table

Kuniyuki Iwashima (56):
      net: ena: Support persistent per-NAPI config.
      selftest: net: Remove DCCP bits.
      net: Retire DCCP socket.
      net: Unexport shared functions for DCCP.
      tcp: Rename tcp_or_dccp_get_hashinfo().
      net: Factorise setup_net() and cleanup_net().
      net: Add ops_undo_single for module load/unload.
      net: Add ->exit_rtnl() hook to struct pernet_operations.
      nexthop: Convert nexthop_net_exit_batch_rtnl() to ->exit_rtnl().
      vxlan: Convert vxlan_exit_batch_rtnl() to ->exit_rtnl().
      ipv4: ip_tunnel: Convert ip_tunnel_delete_nets() callers to ->exit_rtnl().
      ipv6: Convert tunnel devices' ->exit_batch_rtnl() to ->exit_rtnl().
      xfrm: Convert xfrmi_exit_batch_rtnl() to ->exit_rtnl().
      bridge: Convert br_net_exit_batch_rtnl() to ->exit_rtnl().
      bonding: Convert bond_net_exit_batch_rtnl() to ->exit_rtnl().
      gtp: Convert gtp_net_exit_batch_rtnl() to ->exit_rtnl().
      bareudp: Convert bareudp_exit_batch_rtnl() to ->exit_rtnl().
      geneve: Convert geneve_exit_batch_rtnl() to ->exit_rtnl().
      net: Remove ->exit_batch_rtnl().
      net: Drop hold_rtnl arg from ops_undo_list().
      pfcp: Convert pfcp_net_exit() to ->exit_rtnl().
      ppp: Split ppp_exit_net() to ->exit_rtnl().
      net: Fix wild-memory-access in __register_pernet_operations() when CONFIG_NET_NS=n.
      ipv6: Validate RTA_GATEWAY of RTA_MULTIPATH in rtm_to_fib6_config().
      ipv6: Get rid of RTNL for SIOCDELRT and RTM_DELROUTE.
      ipv6: Move some validation from ip6_route_info_create() to rtm_to_fib6_config().
      ipv6: Check GATEWAY in rtm_to_fib6_multipath_config().
      ipv6: Move nexthop_find_by_id() after fib6_info_alloc().
      ipv6: Split ip6_route_info_create().
      ipv6: Preallocate rt->fib6_nh->rt6i_pcpu in ip6_route_info_create().
      ipv6: Preallocate nhc_pcpu_rth_output in ip6_route_info_create().
      ipv6: Don't pass net to ip6_route_info_append().
      ipv6: Rename rt6_nh.next to rt6_nh.list.
      ipv6: Factorise ip6_route_multipath_add().
      ipv6: Protect fib6_link_table() with spinlock.
      ipv6: Defer fib6_purge_rt() in fib6_add_rt2node() to fib6_add().
      ipv6: Protect nh->f6i_list with spinlock and flag.
      ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.
      ipv6: Restore fib6_config validation for SIOCADDRT.
      ipv6: Remove rcu_read_lock() in fib6_get_table().
      inet: Remove rtnl_is_held arg of lwtunnel_valid_encap_type(_attr)?().
      ipv6: Narrow down RCU critical section in inet6_rtm_newroute().
      Revert "ipv6: sr: switch to GFP_ATOMIC flag to allocate memory during seg6local LWT setup"
      Revert "ipv6: Factorise ip6_route_multipath_add()."
      ipv6: Pass gfp_flags down to ip6_route_info_create_nh().
      ipv6: Revert two per-cpu var allocation for RTM_NEWROUTE.
      af_unix: Factorise test_bit() for SOCK_PASSCRED and SOCK_PASSPIDFD.
      af_unix: Don't pass struct socket to maybe_add_creds().
      scm: Move scm_recv() from scm.h to scm.c.
      tcp: Restrict SO_TXREHASH to TCP socket.
      net: Restrict SO_PASS{CRED,PIDFD,SEC} to AF_{UNIX,NETLINK,BLUETOOTH}.
      af_unix: Move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
      af_unix: Inherit sk_flags at connect().
      af_unix: Introduce SO_PASSRIGHTS.
      selftest: af_unix: Test SO_PASSRIGHTS.
      calipso: Don't call calipso functions for AF_INET sk.

Kurt Kanzenbach (6):
      igb: Link IRQs to NAPI instances
      igb: Link queues to NAPI instances
      igb: Add support for persistent NAPI config
      igb: Get rid of spurious interrupts
      igc: Limit netdev_tc calls to MQPRIO
      igc: Change Tx mode for MQPRIO offloading

Kyungwook Boo (1):
      i40e: fix MMIO write access to an invalid page in i40e_clear_hw

Lad Prabhakar (5):
      dt-bindings: net: dwmac: Increase 'maxItems' for 'interrupts' and 'interrupt-names'
      dt-bindings: net: Document support for Renesas RZ/V2H(P) GBETH
      net: stmmac: Add DWMAC glue layer for Renesas GBETH
      MAINTAINERS: Add entry for Renesas RZ/V2H(P) DWMAC GBETH glue layer driver
      dt-bindings: net: renesas-gbeth: Add support for RZ/V2N (R9A09G056) SoC

Larysa Zaremba (4):
      ice: do not add LLDP-specific filter if not necessary
      ice: remove headers argument from ice_tc_count_lkups
      ice: support egress drop rules on PF
      ice: enable LLDP TX for VFs through tc

Lee Trager (6):
      pldmfw: Don't require send_package_data or send_component_table to be defined
      eth: fbnic: Accept minimum anti-rollback version from firmware
      eth: fbnic: Add support for multiple concurrent completion messages
      eth: fbnic: Add mailbox support for PLDM updates
      eth: fbnic: Add devlink dev flash support
      eth: fbnic: Replace kzalloc/fbnic_fw_init_cmpl with fbnic_fw_alloc_cmpl

Leon Romanovsky (2):
      xfrm: validate assignment of maximal possible SEQ number
      xfrm: prevent configuration of interface index when offload is used

Leon Yen (1):
      wifi: mt76: mt7925: introduce thermal protection

Lingbo Kong (1):
      wifi: ath12k: Abort scan before removing link interface to prevent duplicate deletion

Linus Walleij (1):
      net: ethernet: cortina: Use TOE/TSO on all TCP

Liwei Sun (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3584 for MT7922

Lorenzo Bianconi (13):
      net: airoha: Add l2_flows rhashtable
      net: airoha: Add L2 hw acceleration support
      net: airoha: Add matchall filter offload support
      net: airoha: Introduce airoha_irq_bank struct
      net: airoha: Enable multiple IRQ lines support in airoha_eth driver.
      net: airoha: npu: Move memory allocation in airoha_npu_send_msg() caller
      net: airoha: Add FLOW_CLS_STATS callback support
      net: airoha: ppe: Disable packet keepalive
      Revert "wifi: mt76: Check link_conf pointer in mt76_connac_mcu_sta_basic_tlv()"
      dt-bindings: net: airoha: Add EN7581 memory-region property
      net: airoha: Do not store hfwd references in airoha_qdma struct
      net: airoha: Add the capability to allocate hwfd buffers via reserved-memory
      net: airoha: Add the capability to allocate hfwd descriptors in SRAM

Lucien.Jheng (1):
      net: phy: air_en8811h: Add clk provider for CKO pin

Luiz Augusto von Dentz (3):
      Bluetooth: ISO: Fix not using SID from adv report
      Bluetooth: ISO: Fix getpeername not returning sockaddr_iso_bc fields
      Bluetooth: L2CAP: Fix not checking l2cap_chan security level

MD Danish Anwar (1):
      net: ti: icssg-prueth: Add ICSSG FW Stats

Maharaja Kennadyrajan (3):
      wifi: ath12k: Fix spelling errors in mac.c file
      wifi: ath12k: Prevent sending WMI commands to firmware during firmware crash
      wifi: ath12k: fix node corruption in ar->arvifs list

Marc Kleine-Budde (1):
      Merge patch series "Add support for RZ/G3E CANFD"

Mark Bloch (1):
      net/mlx5e: Allow setting MAC address of representors

Martin KaFai Lau (4):
      Merge branch 'selftests-xsk-add-tests-for-xdp-tail-adjustment-in-af_xdp'
      Merge branch 'bpf-qdisc'
      Merge branch 'bpf-udp-exactly-once-socket-iteration'
      Merge branch 'fix-bpf-qdisc-bugs-and-clean-up'

Martyna Szapar-Mudlaw (1):
      ice: improve error message for insufficient filter space

Mateusz Pacuszka (2):
      ice: fix check for existing switch rule
      ice: receive LLDP on trusted VFs

Mateusz Polchlopek (1):
      idpf: assign extracted ptype to struct libeth_rqe_info field

Matthias Schiffer (3):
      batman-adv: constify and move broadcast addr definition
      net: phy: dp83867: remove check of delay strap configuration
      net: phy: dp83867: use 2ns delay if not specified in DTB

Matthieu Baerts (NGI0) (5):
      mptcp: sched: remove mptcp_sched_data
      mptcp: pass right struct to subflow_hmac_valid
      mptcp: add MPJoinRejected MIB counter
      selftests: mptcp: validate MPJoinRejected counter
      selftests: mptcp: info: hide 'grep: write error' warnings

Maxime Chevallier (6):
      net: stmmac: socfpga: Enable internal GMII when using 1000BaseX
      net: stmmac: socfpga: Don't check for phy to enable the SGMII adapter
      net: stmmac: socfpga: Remove unused pcs-mdiodev field
      net: ethtool: Introduce per-PHY DUMP operations
      net: ethtool: phy: Convert the PHY_GET command to generic phy dump
      net: ethtool: netlink: Use netdev_hold for dumpit() operations

Mengyuan Lou (6):
      net: libwx: Add mailbox api for wangxun pf drivers
      net: libwx: Add sriov api for wangxun nics
      net: libwx: Redesign flow when sriov is enabled
      net: libwx: Add msg task func
      net: ngbe: add sriov function support
      net: txgbe: add sriov function support

Miaoqing Pan (2):
      dt-bindings: net: wireless: ath12k: describe firmware-name property
      wifi: ath12k: support usercase-specific firmware overrides

Michael Chan (1):
      bnxt_en: Change FW message timeout warning

Michael Klein (6):
      net: phy: realtek: remove unsed RTL821x_PHYSR* macros
      net: phy: realtek: Clean up RTL821x ExtPage access
      net: phy: realtek: add RTL8211F register defines
      net: phy: realtek: Group RTL82* macro definitions
      net: phy: realtek: use __set_bit() in rtl8211f_led_hw_control_get()
      net: phy: realtek: Add support for PHY LEDs on RTL8211E

Michael Lo (4):
      wifi: mt76: mt7925: fix host interrupt register initialization
      wifi: mt76: mt7925: ensure all MCU commands wait for response
      wifi: mt76: mt7925: extend MCU support for testmode
      wifi: mt76: mt7925: add test mode support

Michael Walle (2):
      net: ethernet: ti: am65-cpsw: set fwnode for ports
      net: ethernet: ti: am65-cpsw: handle -EPROBE_DEFER

Michal Koutný (2):
      netfilter: xt_cgroup: Make it independent from net_cls
      net: cgroup: Guard users of sock_cgroup_classid()

Michal Luczaj (7):
      net: Drop unused @sk of __skb_try_recv_from_queue()
      af_unix: Remove unix_unhash()
      vsock/virtio: Linger on unsent data
      vsock: Move lingering logic to af_vsock core
      vsock/test: Introduce vsock_wait_sent() helper
      vsock/test: Introduce enable_so_linger() helper
      vsock/test: Add test for an unexpectedly lingering close()

Michal Swiatkowski (1):
      idpf: remove unreachable code from setting mailbox

Milena Olech (10):
      idpf: change the method for mailbox workqueue allocation
      idpf: add initial PTP support
      virtchnl: add PTP virtchnl definitions
      idpf: move virtchnl structures to the header file
      idpf: negotiate PTP capabilities and get PTP clock
      idpf: add mailbox access to read PTP clock time
      idpf: add PTP clock configuration
      idpf: add Tx timestamp capabilities negotiation
      idpf: add Tx timestamp flows
      idpf: add support for Rx timestamping

Mina Almasry (16):
      netmem: add niov->type attribute to distinguish different net_iov types
      net: add get_netmem/put_netmem support
      net: devmem: Implement TX path
      net: add devmem TCP TX documentation
      net: enable driver support for netmem TX
      gve: add netmem TX support to GVE DQO-RDA mode
      net: check for driver support in netmem TX
      selftests: ncdevmem: Implement devmem TCP TX
      net: devmem: move list_add to net_devmem_bind_dmabuf.
      page_pool: fix ugly page_pool formatting
      net: devmem: preserve sockc_err
      net: devmem: ksft: add ipv4 support
      net: devmem: ksft: add exit_wait to make rx test pass
      net: devmem: ksft: add 5 tuple FS support
      net: devmem: ksft: upgrade rx test to send 1K data
      net: devmem: ncdevmem: remove unused variable

Ming Yen Hsieh (4):
      wifi: mt76: add mt76_connac_mcu_build_rnr_scan_param routine
      wifi: mt76: mt7925: add RNR scan support for 6GHz
      wifi: mt76: mt7925: prevent multiple scan commands
      wifi: mt76: mt7925: refine the sniffer commnad

Mingcong Bai (1):
      wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723

Miri Korenblit (37):
      wifi: iwlwifi: re-add IWL_AMSDU_8K case
      wifi: iwlwifi: mld: avoid memory leak if mcc_init fails
      wifi: iwlwifi: mld: stop hw if mcc_init fails
      wifi: iwlwifi: mld: don't do iwl_trans_stop_device twice
      wifi: iwlwifi: mld: refactor purging async notifications
      wifi: iwlwifi: mld: properly handle async notification in op mode start
      wifi: iwlwifi: mld: inform trans on init failure
      wifi: iwlwifi: set step_urm in transport and not in the opmodes
      wifi: iwlwifi: add definitions for iwl_mac_power_cmd version 2
      wifi: iwlwifi: pcie: make sure to lock rxq->read
      wifi: iwlwifi: move phy_filters to fw_runtime
      wifi: iwlwifi: prepare for reading WPFC from UEFI
      wifi: iwlwifi: read WPFC also from UEFI
      wifi: iwlwifi: mld: send the WPFC table to the FW
      wifi: iwlwifi: mld: check for NULL before referencing a pointer
      wifi: iwlwifi: mld: don't return an error if the FW is dead
      wifi: iwlwifi: mld: support iwl_mac_power_cmd version 2
      wifi: iwlwifi: mvm: support ROC command version 6
      wifi: iwlwifi: mvm: support iwl_mac_power_cmd version 2
      wifi: iwlwifi: remove duplicated line
      wifi: iwlwifi: bump FW API to 99 for BZ/SC/DR devices
      wifi: iwlwifi: print the DSM value when read from UEFI
      wifi: iwlwifi: mld: don't check the TPT counters when scanning
      wifi: iwlwifi: debug: set CDB indication from CSR
      wifi: iwlwifi: mld: remove one more error in unallocated BAID
      wifi: iwlwifi: pcie: remove iwl_trans_pcie_gen2_send_hcmd
      wifi: iwlwifi: mld: avoid init-after-queue
      wifi: iwlwifi: stop supporting TX_CMD_API_S_VER_8
      wifi: iwlwifi: use normal versioning convention for iwl_tx_cmd
      wifi: iwlwifi: remove GEN3 from a couple of macros
      wifi: iwlwifi: use bc entries instead of bc table also for pre-ax210
      wifi: iwlwifi: unify iwlagn_scd_bc_tbl_entry and iwl_gen3_bc_tbl_entry
      wifi: iwlwifi: remove unused macro
      wifi: iwlwifi: map iwl_context_info to the matching struct
      wifi: iwlwifi: fix a wrong comment
      wifi: iwlwifi: rename ctx-info-gen3 to ctx-info-v2
      wifi: iwlwifi: mld: allow 2 ROCs on the same vif

Mohan Kumar G (2):
      wifi: mac80211: Update MCS15 support in link_conf
      wifi: ath12k: Send MCS15 support to firmware during peer assoc

Mohsin Bashir (6):
      eth: fbnic: add locking support for hw stats
      eth: fbnic: add coverage for hw queue stats
      eth: fbnic: add coverage for RXB stats
      eth: fbnic: add support for TMI stats
      eth: fbnic: add support for TTI HW stats
      eth: fbnic: fix `tx_dropped` counting

Moon Yeounsu (1):
      net: dlink: add synchronization for stats update

Muhammad Usama Anjum (1):
      wifi: ath11k: Fix QMI memory reuse logic

Muna Sinada (5):
      wifi: ath12k: remove open parenthesis
      wifi: mac80211: Add link iteration macro for link data
      wifi: mac80211: Create separate links for VLAN interfaces
      wifi: mac80211: VLAN traffic in multicast path
      wifi: ath12k: Prevent multicast duplication for dynamic VLAN

Neeraj Sanjay Kale (2):
      dt-bindings: net: bluetooth: nxp: Add support for host-wakeup
      Bluetooth: btnxpuart: Implement host-wakeup feature

Nelson Escobar (1):
      net/enic: Allow at least 8 RQs to always be used

Nikita Zhandarovich (1):
      net: usb: aqc111: fix error handling of usbnet read calls

Niklas Söderlund (1):
      net: phy: marvell-88q2xxx: Enable temperature sensor for mv88q211x

Nithyanantham Paramasivam (1):
      wifi: ath12k: Enable REO queue lookup table feature on QCN9274

Oleksij Rempel (9):
      net: dsa: microchip: add ETS scheduler support for KSZ88x3 switches
      net: usb: lan78xx: Improve error handling in PHY initialization
      net: usb: lan78xx: remove explicit check for missing PHY driver
      net: usb: lan78xx: refactor PHY init to separate detection and MAC configuration
      net: usb: lan78xx: move LED DT configuration to helper
      net: usb: lan78xx: Extract PHY interrupt acknowledgment to helper
      net: usb: lan78xx: Refactor USB link power configuration into helper
      net: usb: lan78xx: Extract flow control configuration to helper
      net: phy: microchip: document where the LAN88xx PHYs are used

Ondrej Jirman (2):
      wifi: rtw89: Convert rtw89_core_set_supported_band to use devm_*
      wifi: rtw89: Fix inadverent sharing of struct ieee80211_supported_band data

P Praneesh (19):
      wifi: ath12k: refactor ath12k_hw_regs structure
      wifi: ath12k: Add extra TLV tag parsing support in monitor Rx path
      wifi: ath12k: Avoid fetch Error bitmap and decap format from Rx TLV
      wifi: ath12k: change the status update in the monitor Rx
      wifi: ath12k: Avoid packet offset and FCS length from Rx TLV
      wifi: ath12k: add monitor interface support on QCN9274
      wifi: ath12k: Fix memory leak during vdev_id mismatch
      wifi: ath12k: Fix memory corruption during MLO multicast tx
      wifi: ath12k: Fix invalid memory access while forming 802.11 header
      wifi: ath12k: add rx_info to capture required field from rx descriptor
      wifi: ath12k: replace the usage of rx desc with rx_info
      wifi: ath12k: Handle error cases during extended skb allocation
      wifi: ath12k: Refactor tx descriptor handling in tx completion handler
      wifi: ath12k: Fix memory leak during extended skb allocation
      wifi: ath12k: Use skb->len for dma_unmap_single() length parameter
      wifi: ath12k: Add MSDU length validation for TKIP MIC error
      wifi: ath12k: Avoid allocating rx_stats when ext_rx_stats is disabled
      wifi: ath12k: Fix invalid RSSI values in station dump
      wifi: ath12k: fix memory leak in WMI firmware stats

Pablo Neira Ayuso (2):
      netfilter: nft_set_pipapo: prevent overflow in lookup table allocation
      netfilter: nft_set_pipapo: clamp maximum map bucket size to INT_MAX

Pagadala Yesu Anjaneyulu (10):
      wifi: iwlwifi: rename ppag_ver to ppag_bios_rev
      wifi: iwlwifi: fw: support reading PPAG BIOS table revision 4
      wifi: iwlwifi: fw: support PPAG command version 7
      wifi: iwlwifi: mld: add RFI_CONFIG_CMD to iwl_mld_system_names array
      wifi: iwlwifi: mld: Correct comments for cleanup functions
      wifi: iwlwifi: mld: Fix ROC activity cleanup in iwl_mld_vif
      wifi: iwlwifi: mld: move aux_sta member from iwl_mld_link to iwl_mld_vif
      wifi: iwlwifi: mld: Block EMLSR only when ready to enter ROC
      wifi: iwlwifi: mld: add support for ROC on BSS
      wifi: iwlwifi: Add helper function to extract device ID

Paolo Abeni (33):
      udp_tunnel: create a fastpath GRO lookup.
      udp_tunnel: use static call for GRO hooks when possible
      udp: properly deal with xfrm encap and ADDRFORM
      Merge branch 'eth-fbnic-extend-hardware-stats-coverage'
      Merge branch 'net-dsa-mt7530-modernize-mib-handling-fix'
      Merge branch 'introducing-openvpn-data-channel-offload'
      Merge branch 'mitigate-double-allocations-in-ioam6_iptunnel'
      Merge branch 'net-pktgen-fix-checkpatch-code-style-errors-warnings'
      Merge branch 'vxlan-convert-fdb-table-to-rhashtable'
      Merge branch 'ionic-support-qsfp-cmis'
      Merge branch 'ipv6-no-rtnl-for-ipv6-routing-table'
      Merge branch 'ip-improve-tcp-sock-multipath-routing'
      Merge branch 'tools-ynl-gen-additional-c-types-and-classic-netlink-handling'
      Merge branch 'net-ibmveth-make-ibmveth-use-new-reset-function-and-new-kunit-testsg'
      Merge tag 'nf-next-25-05-06' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'net-phy-realtek-add-support-for-phy-leds'
      Merge branch 'device-memory-tcp-tx'
      Merge branch 'tools-ynl-gen-support-sub-types-for-binary-attributes'
      Merge branch 'amd-xgbe-add-support-for-amd-renoir'
      Merge branch 'eth-fbnic-add-devlink-dev-flash-support'
      Merge branch 'octeontx2-improve-mailbox-tracing'
      Merge branch 'net-cover-more-per-cpu-storage-with-local-nested-bh-locking'
      Merge branch 'add-functions-for-txgbe-aml-devices'
      Merge branch 'add-the-capability-to-consume-sram-for-hwfd-descriptor-queue-in-airoha_eth-driver'
      Merge tag 'linux-can-next-for-6.16-20250522' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge tag 'ipsec-next-2025-05-23' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next
      Merge tag 'nf-next-25-05-23' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'net-convert-dev_set_mac_address-to-struct-sockaddr_storage'
      Merge branch 'wireguard-updates-for-6-16'
      Merge branch 'vsock-sock_linger-rework'
      Merge branch 'octeontx2-pf-do-not-detect-macsec-block-based-on-silicon'
      Merge branch 'net_sched-hfsc-address-reentrant-enqueue-adding-class-to-eltree-twice'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Pauli Virtanen (2):
      Bluetooth: add support for SIOCETHTOOL ETHTOOL_GET_TS_INFO
      Bluetooth: separate CIS_LINK and BIS_LINK link types

Pedro Falcato (1):
      mptcp: Align mptcp_inet6_sk with other protocols

Pedro Tammela (2):
      net_sched: hfsc: Address reentrant enqueue adding class to eltree twice
      selftests/tc-testing: Add a test for HFSC eltree double add with reentrant enqueue behaviour on netem

Peter Chiu (7):
      wifi: mt76: mt7996: rework WA mcu command for mt7990
      wifi: mt76: mt7996: rework DMA configuration for mt7990
      wifi: mt76: mt7996: adjust HW capabilities for mt7990
      wifi: mt76: mt7996: add PCI device id for mt7990
      wifi: mt76: mt7996: set EHT max ampdu length capability
      wifi: mt76: mt7996: fix invalid NSS setting when TX path differs from NSS
      wifi: mt76: mt7996: change max beacon size

Peter Seiderer (10):
      net: pktgen: fix code style (ERROR: "foo * bar" should be "foo *bar")
      net: pktgen: fix code style (ERROR: space prohibited after that '&')
      net: pktgen: fix code style (WARNING: suspect code indent for conditional statements)
      net: pktgen: fix code style (WARNING: Block comments)
      net: pktgen: fix code style (WARNING: Missing a blank line after declarations)
      net: pktgen: fix code style (WARNING: macros should not use a trailing semicolon)
      net: pktgen: fix code style (WARNING: quoted string split across lines)
      net: pktgen: fix code style (ERROR: else should follow close brace '}')
      net: pktgen: fix code style (WARNING: please, no space before tabs)
      net: pktgen: fix code style (WARNING: Prefer strscpy over strcpy)

Petr Malat (1):
      sctp: Do not wake readers in __sctp_write_space()

Phil Sutter (14):
      netfilter: nf_tables: Introduce functions freeing nft_hook objects
      netfilter: nf_tables: Introduce nft_hook_find_ops{,_rcu}()
      netfilter: nf_tables: Introduce nft_register_flowtable_ops()
      netfilter: nf_tables: Pass nf_hook_ops to nft_unregister_flowtable_hook()
      netfilter: nf_tables: Have a list of nf_hook_ops in nft_hook
      netfilter: nf_tables: Prepare for handling NETDEV_REGISTER events
      netfilter: nf_tables: Respect NETDEV_REGISTER events
      netfilter: nf_tables: Wrap netdev notifiers
      netfilter: nf_tables: Handle NETDEV_CHANGENAME events
      netfilter: nf_tables: Sort labels in nft_netdev_hook_alloc()
      netfilter: nf_tables: Support wildcard netdev hook specs
      netfilter: nf_tables: Add notifications for hook changes
      selftests: netfilter: Torture nftables netdev hooks
      selftests: netfilter: Fix skip of wildcard interface test

Philipp Stanner (8):
      net: prestera: Use pure PCI devres API
      net: octeontx2: Use pure PCI devres API
      net: tulip: Use pure PCI devres API
      net: ethernet: natsemi: Use pure PCI devres API
      net: ethernet: sis900: Use pure PCI devres API
      net: mdio: thunder: Use pure PCI devres API
      net: thunder_bgx: Use pure PCI devres API
      net: thunder_bgx: Don't disable PCI device manually

Ping-Ke Shih (7):
      wifi: rtw89: set 2TX for 1SS rate by default
      wifi: rtw89: fw: cast mfw_hdr pointer from address of zeroth byte of firmware->data
      wifi: rtw89: phy: reset value of force TX power for MAC ID
      wifi: rtw89: 8852c: update supported firmware format to 2
      wifi: rtw89: 8922a: rfk: adjust timeout time of RX DCK
      wifi: rtw89: pci: configure manual DAC mode via PCI config API only
      wifi: rtw89: pci: enlarge retry times of RX tag to 1000

Piotr Wejman (1):
      net: e1000e: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()

Po-Hao Huang (12):
      wifi: rtw89: 8922a: use SW CRYPTO when broadcast in MLO mode
      wifi: rtw89: Adjust management queue mapping for [MLO, HW-1]
      wifi: rtw89: Configure scan band when mlo_dbcc_mode changes
      wifi: rtw89: extend join_info H2C command for MLO fields
      wifi: rtw89: add MLD capabilities declaration
      wifi: rtw89: Fill in correct Rx link ID for MLO
      wifi: rtw89: allow driver to do specific band TX for MLO
      wifi: rtw89: send nullfunc based on the given link
      wifi: rtw89: add MLO track for MLSR switch decision
      wifi: rtw89: debug: extend dbgfs for MLO
      wifi: rtw89: debug: add MLD table dump
      wifi: rtw89: debug: add FW log component for MLO

Pradeep Kumar Chitrapu (1):
      wifi: ath12k: Fix incorrect rates sent to firmware

Przemek Kitszel (1):
      ixgbe: wrap netdev_priv() usage

Qasim Ijaz (3):
      wifi: mt76: mt7996: prevent uninit return in mt7996_mac_sta_add_links
      wifi: mt76: mt7996: avoid NULL pointer dereference in mt7996_set_monitor()
      wifi: mt76: mt7996: avoid null deref in mt7996_stop_phy()

Qiu Yutan (1):
      net: neigh: use kfree_skb_reason() in neigh_resolve_output() and neigh_connected_output()

Raj Kumar Bhagat (3):
      dt-bindings: net: wireless: describe the ath12k AHB module for IPQ5332
      wifi: ath12k: add support for fixed QMI firmware memory
      wifi: ath12k: fix cleanup path after mhi init

Rajat Soni (2):
      wifi: ath12k: Add helper function ath12k_mac_update_freq_range()
      wifi: ath12k: fix memory leak in ath12k_service_ready_ext_event

Raju Rangoju (6):
      amd-xgbe: Convert to SPDX identifier
      amd-xgbe: reorganize the code of XPCS access
      amd-xgbe: reorganize the xgbe_pci_probe() code path
      amd-xgbe: add support for new XPCS routines
      amd-xgbe: Add XGBE_XPCS_ACCESS_V3 support to xgbe_pci_probe()
      amd-xgbe: add support for new pci device id 0x1641

Ramasamy Kaliappan (4):
      wifi: ath12k: Fix the QoS control field offset to build QoS header
      wifi: cfg80211: Add support to get EMLSR capabilities of non-AP MLD
      wifi: mac80211: update ML STA with EML capabilities
      wifi: ath12k: update EMLSR capabilities of ML Station

Rameshkumar Sundaram (5):
      wifi: ath12k: fix wrong handling of CCMP256 and GCMP ciphers
      wifi: ath12k: avoid multiple skb_cb fetch in ath12k_mac_mgmt_tx_wmi()
      wifi: ieee80211: Add helpers to fetch EMLSR delay and timeout values
      wifi: nl80211: add link id of transmitted profile for MLO MBSSID
      wifi: mac80211: restructure tx profile retrieval for MLO MBSSID

Ramya Gnanasekar (1):
      wifi: ath12k: Fix WMI tag for EHT rate in peer assoc

Rand Deeb (1):
      ixgbe: Fix unreachable retry logic in combined and byte I2C write functions

Rengarajan S (1):
      net: lan743x: Modify the EEPROM and OTP size for PCI1xxxx devices

Rob Herring (Arm) (1):
      wifi: ath11k: Use of_property_present() to test property presence

Rosen Penev (1):
      wifi: ath9k: ahb: do ioremap resource in one step

Ruben Wauters (2):
      tools: ynl: fix typo in info string
      ipv4: ip_tunnel: Replace strcpy use with strscpy

Rui Salvaterra (1):
      igc: enable HW vlan tag insertion/stripping by default

Russell King (Oracle) (43):
      net: stmmac: provide stmmac_pltfr_find_clk()
      net: stmmac: dwc-qos: use stmmac_pltfr_find_clk()
      net: stmmac: stm32: simplify clock handling
      net: ethtool: fix get_ts_stats() documentation
      net: stmmac: dwc-qos: remove tegra_eqos_init()
      net: stmmac: intel: remove eee_usecs_rate and hardware write
      net: stmmac: intel-plat: remove eee_usecs_rate and hardware write
      net: stmmac: remove eee_usecs_rate
      net: stmmac: remove GMAC_1US_TIC_COUNTER definition
      net: stmmac: qcom-ethqos: set serdes speed using serdes_speed
      net: stmmac: qcom-ethqos: remove ethqos->speed
      net: stmmac: qcom-ethqos: remove unnecessary setting max_speed
      net: stmmac: qcom-ethqos: remove speed_mode_2500() method
      net: stmmac: anarion: clean up anarion_config_dt() error handling
      net: stmmac: anarion: clean up interface parsing
      net: stmmac: anarion: use stmmac_pltfr_probe()
      net: stmmac: anarion: use devm_stmmac_pltfr_probe()
      net: stmmac: imx: use stmmac_pltfr_probe()
      net: stmmac: ingenic: convert to stmmac_pltfr_pm_ops
      net: stmmac: ingenic: convert to devm_stmmac_pltfr_probe()
      net: stmmac: intel: remove unnecessary setting max_speed
      net: stmmac: sun8i: use stmmac_pltfr_probe()
      net: stmmac: sti: use phy_interface_mode_is_rgmii()
      net: stmmac: sti: convert to devm_stmmac_pltfr_probe()
      net: stmmac: sti: convert to stmmac_pltfr_pm_ops
      net: stmmac: sunxi: convert to set_clk_tx_rate()
      net: stmmac: sunxi: use stmmac_pltfr_probe()
      net: stmmac: sunxi: use devm_stmmac_pltfr_probe()
      net: stmmac: dwc-qos: use PHY clock-stop capability
      net: stmmac: mediatek: stop initialising plat->mac_interface
      net: stmmac: socfpga: init dwmac->stmmac_rst before registration
      net: stmmac: socfpga: provide init function
      net: stmmac: socfpga: convert to stmmac_pltfr_pm_ops
      net: stmmac: socfpga: call set_phy_mode() before registration
      net: stmmac: socfpga: convert to devm_stmmac_pltfr_probe()
      net: stmmac: visconti: convert to set_clk_tx_rate() method
      net: stmmac: dwc-qos: calibrate tegra with mdio bus idle
      net: stmmac: use a local variable for priv->phylink_config
      net: stmmac: use priv->plat->phy_interface directly
      net: stmmac: add get_interfaces() platform method
      net: stmmac: intel: move phy_interface init to tgl_common_data()
      net: stmmac: intel: convert speed_mode_2500() to get_interfaces()
      net: stmmac: remove speed_mode_2500() method

Saeed Mahameed (1):
      net: Kconfig NET_DEVMEM selects GENERIC_ALLOCATOR

Saket Kumar Bhaskar (1):
      selftests/bpf: Fix bpf selftest build warning

Salah Triki (1):
      wireless: purelifi: plfxlc: fix memory leak in plfxlc_usb_wreq_asyn()

Samuel Williams (1):
      wifi: mt76: mt7921: add 160 MHz AP for mt7922 device

Sarika Sharma (3):
      wifi: ath12k: using msdu end descriptor to check for rx multicast packets
      wifi: ath12k: correctly handle mcast packets for clients
      wifi: ath12k: fix invalid access to memory

Sascha Hauer (13):
      wifi: mwifiex: deduplicate code in mwifiex_cmd_tx_rate_cfg()
      wifi: mwifiex: use adapter as context pointer for mwifiex_hs_activated_event()
      wifi: mwifiex: drop unnecessary initialization
      wifi: mwifiex: make region_code_mapping_t const
      wifi: mwifiex: pass adapter to mwifiex_dnld_cmd_to_fw()
      wifi: mwifiex: simplify mwifiex_setup_ht_caps()
      wifi: mwifiex: fix indention
      wifi: mwifiex: make locally used function static
      wifi: mwifiex: move common settings out of switch/case
      wifi: mwifiex: remove unnecessary queue empty check
      wifi: mwifiex: let mwifiex_init_fw() return 0 for success
      wifi: mwifiex: drop asynchronous init waiting code
      wifi: mwifiex: remove mwifiex_sta_init_cmd() last argument

Sebastian Andrzej Siewior (18):
      net: page_pool: Don't recycle into cache on PREEMPT_RT
      net: dst_cache: Use nested-BH locking for dst_cache::cache
      ipv4/route: Use this_cpu_inc() for stats on PREEMPT_RT
      ipv6: sr: Use nested-BH locking for hmac_storage
      xdp: Use nested-BH locking for system_page_pool
      xfrm: Use nested-BH locking for nat_keepalive_sk_ipv[46]
      openvswitch: Merge three per-CPU structures into one
      openvswitch: Use nested-BH locking for ovs_pcpu_storage
      openvswitch: Move ovs_frag_data_storage into the struct ovs_pcpu_storage
      net/sched: act_mirred: Move the recursion counter struct netdev_xmit
      net/sched: Use nested-BH locking for sch_frag_data_storage
      mptcp: Use nested-BH locking for hmac_storage
      rds: Disable only bottom halves in rds_page_remainder_alloc()
      rds: Acquire per-CPU pointer within BH disabled section
      rds: Use nested-BH locking for rds_page_remainder
      netfilter: nf_dup{4, 6}: Move duplication check to task_struct
      netfilter: nft_inner: Use nested-BH locking for nft_pcpu_tun_ctx
      netfilter: nf_dup_netdev: Move the recursion counter struct netdev_xmit

Sergio Perez Gonzalez (1):
      net: macb: Check return value of dma_set_mask_and_coherent()

Shannon Nelson (6):
      ionic: extend the QSFP module sprom for more pages
      ionic: support ethtool get_module_eeprom_by_page
      ionic: add module eeprom channel data to ionic_if and ethtool
      pds_core: remove extra name description
      pds_core: smaller adminq poll starting interval
      pds_core: init viftype default in declaration

Shay Drory (1):
      net: Look for bonding slaves in the bond's network namespace

Shayne Chen (6):
      wifi: mt76: mt7996: add macros for pci device ids
      wifi: mt76: connac: rework TX descriptor and TX free for mt7990
      Revert "wifi: mt76: mt7996: fill txd by host driver"
      wifi: mt76: mt7996: fix RX buffer size of MCU event
      wifi: mt76: fix available_antennas setting
      wifi: mt76: support power delta calculation for 5 TX paths

Shengyu Qu (1):
      net: bridge: locally receive all multicast packets if IFF_ALLMULTI is set

Shruti Parab (1):
      bnxt_en: Report the ethtool coredump length after copying the coredump

Siddharth Vadapalli (2):
      dt-bindings: net: ethernet-controller: add 5000M speed to fixed-link
      dt-bindings: net: ti: k3-am654-cpsw-nuss: evaluate fixed-link property

Sidhanta Sahu (1):
      wifi: ath12k: Fix memory leak due to multiple rx_stats allocation

Simon Horman (5):
      octeon_ep_vf: Remove octep_vf_wq
      s390: ism: Pass string literal as format argument of dev_set_name()
      wifi: brcmsmac: Spelling corrections
      net: dlink: Correct endian treatment of t_SROM data
      net: ethernet: mtk_eth_soc: Correct spelling

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sky Huang (2):
      net: phy: mediatek: Sort config and file names in Kconfig and Makefile
      net: phy: mediatek: add driver for built-in 2.5G ethernet PHY on MT7988

Slawomir Mrozowicz (4):
      ixgbe: add E610 functions for acquiring flash data
      ixgbe: read the OROM version information
      ixgbe: read the netlist version information
      ixgbe: devlink: add devlink region support for E610

Somashekhar Puttagangaiah (5):
      wifi: iwlwifi: mld: allow EMLSR with 2.4 GHz when BT is ON
      wifi: iwlwifi: mld: add kunit test for emlsr with bt on
      wifi: iwlwifi: pcie: Add support for new device ids
      wifi: iwlwifi: handle reasons recommended by FW for leaving EMLSR
      wifi: iwlwifi: mld: add debug log instead of warning

Sowmiya Sree Elavalagan (4):
      wifi: ath12k: Power up root PD
      wifi: ath12k: Register various userPD interrupts and save SMEM entries
      wifi: ath12k: Power up userPD
      wifi: ath12k: Power down userPD

Sriram R (2):
      wifi: ath12k: Pass correct values of center freq1 and center freq2 for 320 MHz
      wifi: ath12k: Fix the enabling of REO queue lookup table feature

Stanislav Fomichev (8):
      configs/debug: run and debug PREEMPT
      net/mlx5: support software TX timestamp
      net: devmem: TCP tx netlink api
      selftests: net: validate team flags propagation
      net: devmem: support single IOV with sendmsg
      selftests: ncdevmem: make chunking optional
      selftests: ncdevmem: add tx test with multiple IOVs
      af_packet: move notifier's packet_dev_mc out of rcu critical section

StanleyYP Wang (7):
      wifi: mt76: connac: add support to load firmware for mt7990
      wifi: mt76: mt7996: rework register mapping for mt7990
      wifi: mt76: mt7996: add eeprom support for mt7990
      wifi: mt76: mt7996: rework background radar check for mt7990
      wifi: mt76: mt7915: set correct background radar capability
      wifi: mt76: mt7915: rework radar HWRDD idx
      wifi: mt76: mt7996: rework radar HWRDD idx

Stefan Wahren (6):
      dt-bindings: vertexcom-mse102x: Fix IRQ type in example
      net: vertexcom: mse102x: Add warning about IRQ trigger type
      net: vertexcom: mse102x: Drop invalid cmd stats
      net: vertexcom: mse102x: Implement flag for valid CMD
      net: vertexcom: mse102x: Return code for mse102x_rx_pkt_spi
      net: vertexcom: mse102x: Simplify mse102x_rx_pkt_spi

Stefano Garzarella (4):
      vsock/test: add timeout_usleep() to allow sleeping in timeout sections
      vsock/test: retry send() to avoid occasional failure in sigpipe test
      vsock/test: check also expected errno on sigpipe test
      vsock/virtio: fix `rx_bytes` accounting for stream sockets

Stefano Radaelli (1):
      net: phy: add driver for MaxLinear MxL86110 PHY

Steffen Klassert (2):
      Merge branch 'xfrm & bonding: Correct use of xso.real_dev'
      Merge branch 'Update offload configuration with SA'

Stone Zhang (1):
      wifi: ath11k: fix node corruption in ar->arvifs list

Subbaraya Sundeep (8):
      octeontx2-af: convert dev_dbg to tracepoint in mbox
      octeontx2-af: Display names for CPT and UP messages
      octeontx2: Add pcifunc also to mailbox tracepoints
      octeontx2: Add new tracepoint otx2_msg_status
      octeontx2-pf: Add tracepoint for NIX_PARSE_S
      octeontx2-af: Send Link events one by one
      octeontx2-af: Add MACSEC capability flag
      octeontx2-pf: macsec: Get MACSEC capability flag from AF

Sumanth Gavini (4):
      selftests: drv-net: Fix "envirnoments" to "environments"
      selftests: nci: Fix "Electrnoics" to "Electronics"
      selftests: net: Fix spellings
      nfc: Correct Samsung "Electronics" spelling in copyright headers

Suraj Gupta (1):
      net: xilinx: axienet: Fix Tx skb circular buffer occupancy check in dmaengine xmit

Suraj P Kizhakkethil (1):
      wifi: ath12k: Pass correct values of center freq1 and center freq2 for 160 MHz

Sven Eckelmann (2):
      batman-adv: Switch to crc32 header for crc32c
      batman-adv: Drop unused net_namespace.h include

Taehee Yoo (2):
      eth: bnxt: add support rx side device memory TCP
      eth: bnxt: fix deadlock when xdp is attached or detached

Tatyana Nikolova (1):
      ice: Replace ice specific DSCP mapping num with a kernel define

Thangaraj Samynathan (3):
      net: lan743x: Allocate rings outside ZONE_DMA
      net: lan743x: rename lan743x_reset_phy to lan743x_hw_reset_phy
      net: lan743x: Fix PHY reset handling during initialization and WOL

Thiraviyam Mariyappan (1):
      wifi: ath12k: Enable AST index based address search in Station Mode

Thomas Weißschuh (5):
      wifi: ath10k: Don't use %pK through printk
      wifi: ath11k: Don't use %pK through printk
      wifi: ath12k: Don't use %pK through printk
      wifi: wcn36xx: Don't use %pK through printk
      wifi: mwifiex: Don't use %pK through printk

Thomas Wu (1):
      wifi: ath12k: Disable broadcast TWT feature in HE MAC capabilities

Thorsten Blum (4):
      hamradio: Remove unnecessary strscpy_pad() size arguments
      rocker: Simplify if condition in ofdpa_port_fdb()
      xfrm: Remove unnecessary strscpy_pad() size arguments
      mptcp: pm: Return local variable instead of freed pointer

Ting-Ying Li (1):
      wifi: brcmfmac: Fix structure size for WPA3 external SAE

Toke Høiland-Jørgensen (5):
      page_pool: Move pp_magic check into helper functions
      page_pool: Track DMA-mapped pages and unmap them when destroying the pool
      tc: Return an error if filters try to attach too many actions
      Revert "mac80211: Dynamically set CoDel parameters per station"
      wifi: ath9k_htc: Abort software beacon handling if disabled

Tristram Ha (1):
      net: dsa: microchip: Add SGMII port support to KSZ9477 switch

Tushar Vyavahare (2):
      selftests/xsk: Add packet stream replacement function
      selftests/xsk: Add tail adjustment tests and support check

Victor Nogueira (1):
      selftests: tc-testing: Pre-load IFE action and its submodules

Vignesh C (1):
      wifi: ath12k: Fix scan initiation failure handling

Vincent Mailhol (2):
      can: dev: add struct data_bittiming_params to group FD parameters
      selftests: can: test_raw_filter.sh: add support of physical interfaces

Vinith Kumar R (3):
      wifi: ath12k: change soc name to device name
      wifi: ath12k: Add device dp stats support
      wifi: ath12k: print device dp stats in debugfs

Vlad Dogaru (17):
      net/mlx5: HWS, Fix matcher action template attach
      net/mlx5: HWS, Remove unused element array
      net/mlx5: HWS, Make pool single resource
      net/mlx5: HWS, Refactor pool implementation
      net/mlx5: HWS, Cleanup after pool refactoring
      net/mlx5: HWS, Add fullness tracking to pool
      net/mlx5: HWS, Fix pool size optimization
      net/mlx5: HWS, Implement action STE pool
      net/mlx5: HWS, Use the new action STE pool
      net/mlx5: HWS, Cleanup matcher action STE table
      net/mlx5: HWS, Free unused action STE tables
      net/mlx5: HWS, Export action STE tables to debugfs
      net/mlx5: HWS, Fix IP version decision
      net/mlx5: HWS, Harden IP version definer checks
      net/mlx5: HWS, Disallow matcher IP version mixing
      net/mlx5: SWS, fix reformat id error handling
      net/mlx5: HWS, register reformat actions with fw

Vladimir Oltean (17):
      net: ethtool: mm: extract stmmac verification logic into common library
      net: dsa: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
      net: dpaa_eth: convert to ndo_hwtstamp_set()
      net: dpaa_eth: add ndo_hwtstamp_get() implementation
      net: dpaa_eth: simplify dpaa_ioctl()
      net: dpaa2-eth: convert to ndo_hwtstamp_set()
      net: dpaa2-eth: add ndo_hwtstamp_get() implementation
      net: gianfar: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
      net: mvpp2: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
      net: ixp4xx_eth: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
      net: enetc: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
      net: mlxsw: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
      net: cpsw: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
      net: cpsw: isolate cpsw_ndo_ioctl() to just the old driver
      net: lan743x: convert to ndo_hwtstamp_set()
      net: lan743x: implement ndo_hwtstamp_get()
      net: stmmac: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()

Víctor Gonzalo (1):
      wifi: iwlwifi: Add missing MODULE_FIRMWARE for Qu-c0-jf-b0

WangYuli (3):
      bna: bnad_dim_timeout: Rename del_timer_sync in comment
      Bluetooth: btusb: Add RTL8851BE device 0x0bda:0xb850
      wireguard: selftests: cleanup CONFIG_UBSAN_SANITIZE_ALL

Wei Fang (17):
      net: enetc: add initial netc-lib driver to support NTMP
      net: enetc: add command BD ring support for i.MX95 ENETC
      net: enetc: move generic MAC filtering interfaces to enetc-core
      net: enetc: add MAC filtering for i.MX95 ENETC PF
      net: enetc: add debugfs interface to dump MAC filter
      net: enetc: add set/get_rss_table() hooks to enetc_si_ops
      net: enetc: make enetc_set_rss_key() reusable
      net: enetc: add RSS support for i.MX95 ENETC PF
      net: enetc: change enetc_set_rss() to void type
      net: enetc: enable RSS feature by default
      net: enetc: extract enetc_refresh_vlan_ht_filter()
      net: enetc: move generic VLAN hash filter functions to enetc_pf_common.c
      net: enetc: add VLAN filtering support for i.MX95 ENETC PF
      net: enetc: add loopback support for i.MX95 ENETC PF
      net: enetc: fix implicit declaration of function FIELD_PREP
      net: enetc: fix the error handling in enetc4_pf_netdev_create()
      net: phy: clear phydev->devlink when the link is deleted

Wen Gong (6):
      wifi: ath12k: add configure country code for WCN7850
      wifi: ath12k: use correct WMI command to set country code for WCN7850
      wifi: ath12k: add 11d scan offload support
      wifi: ath12k: store and send country code to firmware after recovery
      wifi: ath12k: avoid deadlock during regulatory update in ath12k_regd_update()
      wifi: ath12k: read country code from SMBIOS for WCN7850

Wentao Liang (4):
      octeontx2-pf: Add error log forcn10k_map_unmap_rq_policer()
      wifi: brcm80211: fmac: Add error log in brcmf_usb_dl_cmd()
      net/mlx5_core: Add error handling inmlx5_query_nic_vport_qkey_viol_cntr()
      net/mlx5: Add error handling in mlx5_query_nic_vport_node_guid()

Willem de Bruijn (3):
      ipv4: prefer multipath nexthop that matches source address
      ip: load balance tcp connections to single dst addr and port
      selftests/net: test tcp connection load balancing

Xuanqiang Luo (1):
      netfilter: conntrack: Remove redundant NFCT_ALIGN call

Yang Li (1):
      wifi: iwlwifi: mvm: Remove duplicated include in iwl-utils.c

Yedidya Benshimol (3):
      wifi: iwlwifi: Add a new version for sta config command
      wifi: iwlwifi: Add a new version for mac config command
      wifi: iwlwifi: Add support for a new version for link config command

Yevgeny Kliteynik (12):
      net/mlx5: HWS, expose function mlx5hws_table_ft_set_next_ft in header
      net/mlx5: HWS, add definer function to get field name str
      net/mlx5: HWS, expose polling function in header file
      net/mlx5: HWS, introduce isolated matchers
      net/mlx5: HWS, support complex matchers
      net/mlx5: HWS, force rehash when rule insertion failed
      net/mlx5: HWS, fix counting of rules in the matcher
      net/mlx5: HWS, fix redundant extension of action templates
      net/mlx5: HWS, rework rehash loop
      net/mlx5: HWS, dump bad completion details
      net/mlx5: HWS, fix typo - 'nope' to 'nop'
      net/mlx5: HWS, handle modify header actions dependency

Yingying Tang (2):
      wifi: ath12k: Reorder and relocate the release of resources in ath12k_core_deinit()
      wifi: ath12k: Adjust the process of resource release for ahb bus

Yixun Lan (1):
      dt-bindings: net: sun8i-emac: Add A523 EMAC0 compatible

Yong Wang (3):
      net: bridge: mcast: re-implement br_multicast_{enable, disable}_port functions
      net: bridge: mcast: update multicast contex when vlan state is changed
      selftests: net/bridge : add tests for per vlan snooping with stp state changes

Youn MÉLOIS (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3613 for MT7925

Yu Zhang(Yuriy) (1):
      wifi: ath11k: support DBS and DFS compatibility

Yury Norov (1):
      wifi: carl9170: micro-optimize carl9170_tx_shift_bm()

Yuuki NAGAO (1):
      wifi: rtw88: rtw8822bu VID/PID for BUFFALO WI-U2-866DM

Zak Kemble (3):
      net: bcmgenet: switch to use 64bit statistics
      net: bcmgenet: count hw discarded packets in missed stat
      net: bcmgenet: expose more stats in ethtool

Zhen XIN (2):
      wifi: rtw88: sdio: map mgmt frames to queue TX_DESC_QSEL_MGMT
      wifi: rtw88: sdio: call rtw_sdio_indicate_tx_status unconditionally

Zhengchao Shao (1):
      ipv4: remove unnecessary judgment in ip_route_output_key_hash_rcu

Zhongqiu Duan (1):
      netfilter: nft_quota: match correctly when the quota just depleted

Zijun Hu (2):
      sock: Correct error checking condition for (assign|release)_proto_idx()
      net: Delete the outer () duplicated of macro SOCK_SKB_CB_OFFSET definition

Zilin Guan (2):
      xfrm: use kfree_sensitive() for SA secret zeroization
      tipc: use kfree_sensitive() for aead cleanup

Zong-Zhe Yang (37):
      wifi: rtw89: fix typo of "access" in rtw89_sar_info description
      wifi: rtw89: regd: introduce string getter for reuse
      wifi: rtw89: sar: introduce structure to wrap query parameters
      wifi: rtw89: sar: add skeleton for SAR configuration via ACPI
      wifi: rtw89: acpi: introduce method evaluation function for reuse
      wifi: rtw89: acpi: support loading static SAR table
      wifi: rtw89: acpi: support loading dynamic SAR tables and indicator
      wifi: rtw89: acpi: support loading GEO SAR tables
      wifi: rtw89: sar: add skeleton for different configs by antenna
      wifi: rtw89: 8922a: support different SAR configs by antenna
      wifi: rtw89: 8852c: support different SAR configs by antenna
      wifi: rtw89: 8852bx: support different SAR configs by antenna
      wifi: rtw89: regd: indicate if regd_UK TX power settings follow regd_ETSI
      wifi: rtw89: add suffix "_ax" to Wi-Fi 6 HW scan struct and func
      wifi: rtw89: refactor flow that hw scan handles channel list
      wifi: rtw89: mcc: make GO announce one-time NoA for HW scan process
      wifi: rtw89: don't re-randomize TSF of AP/GO
      wifi: rtw89: mcc: make GO+STA mode calculate dynamic beacon offset
      wifi: rtw89: mcc: handle the case where NoA start time has passed
      wifi: rtw89: mcc: update entire plan when courtesy config changes
      wifi: rtw89: mcc: support courtesy mechanism on both roles at the same time
      wifi: rtw89: mcc: refine filling function of start TSF
      wifi: rtw89: mcc: avoid that loose pattern sets negative timing for auxiliary GO
      wifi: rtw89: extend mapping from Qsel to DMA ch for MLO
      wifi: rtw89: roc: dynamically handle link id and link instance index
      wifi: rtw89: introduce helper to get designated link for MLO
      wifi: rtw89: extract link part from core tx write function
      wifi: rtw89: chan: re-calculate MLO DBCC mode during setting channel
      wifi: rtw89: add handling of mlo_link_cfg H2C command and C2H event
      wifi: rtw89: debug: add mlo_mode dbgfs
      wifi: rtw89: declare MLO support if prerequisites are met
      wifi: rtw89: mcc: pass whom to stop at when pausing chanctx
      wifi: rtw89: mcc: drop queued chanctx changes when stopping
      wifi: rtw89: mcc: add courtesy mechanism conditions to P2P roles
      wifi: rtw89: mcc: introduce calculation of anchor pattern
      wifi: rtw89: mcc: deal with non-periodic NoA
      wifi: rtw89: mcc: avoid redundant recalculations if no chance to improve

sunliming (1):
      wifi: mt76: mt7996: fix uninitialized symbol warning

zhenwei pi (1):
      selftests: mptcp: use IPPROTO_MPTCP for getaddrinfo

 Documentation/admin-guide/bug-hunting.rst          |    2 +-
 .../devicetree/bindings/net/aeonsemi,as21xxx.yaml  |  122 +
 .../devicetree/bindings/net/airoha,en7581-eth.yaml |   13 +
 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    |    1 +
 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml     |   17 +
 .../devicetree/bindings/net/brcm,asp-v2.0.yaml     |   23 +-
 .../devicetree/bindings/net/brcm,unimac-mdio.yaml  |    2 +-
 .../bindings/net/can/renesas,rcar-canfd.yaml       |  171 +-
 .../bindings/net/dsa/mediatek,mt7530.yaml          |    5 +
 .../bindings/net/ethernet-controller.yaml          |   27 +-
 .../devicetree/bindings/net/ethernet-phy.yaml      |   10 +
 .../devicetree/bindings/net/network-class.yaml     |   46 +
 .../bindings/net/renesas,r9a09g057-gbeth.yaml      |  203 ++
 .../devicetree/bindings/net/snps,dwmac.yaml        |   27 +-
 .../devicetree/bindings/net/ti,dp83822.yaml        |    4 +
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml        |    2 +
 .../devicetree/bindings/net/vertexcom-mse102x.yaml |    2 +-
 .../devicetree/bindings/net/via,vt8500-rhine.yaml  |   41 +
 .../devicetree/bindings/net/via-rhine.txt          |   17 -
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   |    2 +-
 .../bindings/net/wireless/qcom,ath12k.yaml         |    6 +
 .../bindings/net/wireless/qcom,ipq5332-wifi.yaml   |  315 +++
 .../bindings/net/wireless/silabs,wfx.yaml          |    5 +-
 .../bindings/net/wireless/wireless-controller.yaml |   23 +
 .../devicetree/bindings/soc/qcom/qcom,wcnss.yaml   |    5 +-
 Documentation/netlink/genetlink-c.yaml             |    3 +
 Documentation/netlink/genetlink-legacy.yaml        |    3 +
 Documentation/netlink/netlink-raw.yaml             |    3 +
 Documentation/netlink/specs/devlink.yaml           |   24 +
 Documentation/netlink/specs/ethtool.yaml           |   27 +
 Documentation/netlink/specs/netdev.yaml            |   12 +
 Documentation/netlink/specs/nl80211.yaml           |   68 -
 Documentation/netlink/specs/ovpn.yaml              |  367 +++
 Documentation/netlink/specs/ovs_datapath.yaml      |   10 +-
 Documentation/netlink/specs/ovs_vport.yaml         |    5 +-
 .../netlink/specs/{rt_addr.yaml => rt-addr.yaml}   |   24 +-
 .../netlink/specs/{rt_link.yaml => rt-link.yaml}   |  248 +-
 .../netlink/specs/{rt_neigh.yaml => rt-neigh.yaml} |   12 +-
 .../netlink/specs/{rt_route.yaml => rt-route.yaml} |   22 +-
 .../netlink/specs/{rt_rule.yaml => rt-rule.yaml}   |    8 +-
 Documentation/netlink/specs/tc.yaml                |  514 +++--
 Documentation/networking/dccp.rst                  |  219 --
 .../device_drivers/ethernet/huawei/hinic3.rst      |  137 ++
 .../networking/device_drivers/ethernet/index.rst   |    2 +
 .../device_drivers/ethernet/meta/fbnic.rst         |   60 +
 .../device_drivers/ethernet/ti/icssg_prueth.rst    |   56 +
 Documentation/networking/devlink/devlink-info.rst  |    4 +
 Documentation/networking/devlink/devlink-trap.rst  |    2 +-
 Documentation/networking/devlink/index.rst         |    1 +
 Documentation/networking/devlink/ixgbe.rst         |  171 ++
 Documentation/networking/devmem.rst                |  150 +-
 Documentation/networking/index.rst                 |    1 -
 Documentation/networking/ip-sysctl.rst             |    8 +-
 .../networking/net_cachelines/net_device.rst       |    3 +-
 Documentation/networking/net_cachelines/snmp.rst   |    2 +
 Documentation/networking/netdev-features.rst       |    5 +
 Documentation/networking/netdevices.rst            |   67 +-
 Documentation/networking/netmem.rst                |   23 +-
 Documentation/networking/rds.rst                   |    8 +-
 Documentation/networking/rxrpc.rst                 |   39 +-
 Documentation/networking/tproxy.rst                |    4 +-
 Documentation/networking/xfrm_device.rst           |   10 +-
 .../translations/zh_CN/admin-guide/bug-hunting.rst |    2 +-
 .../translations/zh_TW/admin-guide/bug-hunting.rst |    2 +-
 .../userspace-api/netlink/netlink-raw.rst          |    2 +-
 MAINTAINERS                                        |   50 +-
 arch/alpha/include/uapi/asm/socket.h               |    2 +
 arch/m68k/coldfire/m5272.c                         |    2 +-
 arch/m68k/configs/amiga_defconfig                  |    2 -
 arch/m68k/configs/apollo_defconfig                 |    2 -
 arch/m68k/configs/atari_defconfig                  |    2 -
 arch/m68k/configs/bvme6000_defconfig               |    2 -
 arch/m68k/configs/hp300_defconfig                  |    2 -
 arch/m68k/configs/mac_defconfig                    |    2 -
 arch/m68k/configs/multi_defconfig                  |    2 -
 arch/m68k/configs/mvme147_defconfig                |    2 -
 arch/m68k/configs/mvme16x_defconfig                |    2 -
 arch/m68k/configs/q40_defconfig                    |    2 -
 arch/m68k/configs/sun3_defconfig                   |    2 -
 arch/m68k/configs/sun3x_defconfig                  |    2 -
 arch/mips/bcm47xx/setup.c                          |    2 +-
 arch/mips/configs/bigsur_defconfig                 |    1 -
 arch/mips/configs/gpr_defconfig                    |    1 -
 arch/mips/configs/mtx1_defconfig                   |    1 -
 arch/mips/include/uapi/asm/socket.h                |    2 +
 arch/parisc/include/uapi/asm/socket.h              |    2 +
 arch/powerpc/configs/pmac32_defconfig              |    1 -
 arch/powerpc/configs/ppc6xx_defconfig              |    1 -
 arch/sparc/include/uapi/asm/socket.h               |    2 +
 crypto/krb5/rfc3961_simplified.c                   |    1 +
 drivers/bcma/driver_gpio.c                         |    8 +-
 drivers/bluetooth/Kconfig                          |   12 -
 drivers/bluetooth/btintel.c                        |   13 +-
 drivers/bluetooth/btintel.h                        |    6 -
 drivers/bluetooth/btintel_pcie.c                   |  141 +-
 drivers/bluetooth/btintel_pcie.h                   |   19 +
 drivers/bluetooth/btmrvl_sdio.c                    |    4 +-
 drivers/bluetooth/btmtksdio.c                      |    2 +-
 drivers/bluetooth/btnxpuart.c                      |   58 +-
 drivers/bluetooth/btusb.c                          |  204 +-
 drivers/bluetooth/hci_aml.c                        |    3 +-
 drivers/infiniband/hw/irdma/main.c                 |  125 +-
 drivers/infiniband/hw/irdma/main.h                 |    3 +-
 drivers/infiniband/hw/irdma/osdep.h                |    2 +-
 drivers/infiniband/hw/irdma/type.h                 |    4 +-
 drivers/infiniband/sw/siw/Kconfig                  |    1 +
 drivers/infiniband/sw/siw/siw.h                    |   22 +-
 drivers/infiniband/ulp/ipoib/ipoib.h               |   13 +-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c            |   65 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |  127 +-
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c         |    8 +-
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c          |   19 +-
 drivers/net/Kconfig                                |   15 +
 drivers/net/Makefile                               |    1 +
 drivers/net/bareudp.c                              |   16 +-
 drivers/net/bonding/bond_alb.c                     |    8 +-
 drivers/net/bonding/bond_main.c                    |  180 +-
 drivers/net/can/ctucanfd/ctucanfd_base.c           |    8 +-
 drivers/net/can/dev/dev.c                          |   12 +-
 drivers/net/can/dev/netlink.c                      |   74 +-
 drivers/net/can/flexcan/flexcan-core.c             |    4 +-
 drivers/net/can/ifi_canfd/ifi_canfd.c              |   10 +-
 drivers/net/can/kvaser_pciefd.c                    |    6 +-
 drivers/net/can/m_can/m_can.c                      |    8 +-
 drivers/net/can/peak_canfd/peak_canfd.c            |    6 +-
 drivers/net/can/rcar/rcar_canfd.c                  |  280 ++-
 drivers/net/can/rockchip/rockchip_canfd-core.c     |    4 +-
 .../net/can/rockchip/rockchip_canfd-timestamp.c    |    2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |   10 +-
 drivers/net/can/usb/esd_usb.c                      |    6 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c        |    4 +-
 drivers/net/can/usb/etas_es58x/es58x_fd.c          |    6 +-
 drivers/net/can/usb/gs_usb.c                       |    8 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h        |    2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |    6 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |    6 +-
 drivers/net/can/xilinx_can.c                       |   16 +-
 drivers/net/dsa/b53/b53_common.c                   |   28 +
 drivers/net/dsa/b53/b53_priv.h                     |    1 +
 drivers/net/dsa/b53/b53_regs.h                     |    7 +
 drivers/net/dsa/bcm_sf2.c                          |    1 +
 drivers/net/dsa/dsa_loop.c                         |    2 +-
 drivers/net/dsa/hirschmann/hellcreek.h             |    2 +-
 drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c    |   24 +-
 drivers/net/dsa/hirschmann/hellcreek_hwtstamp.h    |    5 +-
 drivers/net/dsa/microchip/Kconfig                  |    1 +
 drivers/net/dsa/microchip/ksz9477.c                |  194 +-
 drivers/net/dsa/microchip/ksz9477.h                |    4 +-
 drivers/net/dsa/microchip/ksz_common.c             |  134 +-
 drivers/net/dsa/microchip/ksz_common.h             |   44 +-
 drivers/net/dsa/microchip/ksz_ptp.c                |   26 +-
 drivers/net/dsa/microchip/ksz_ptp.h                |    7 +-
 drivers/net/dsa/mt7530-mmio.c                      |    1 +
 drivers/net/dsa/mt7530.c                           |  270 ++-
 drivers/net/dsa/mt7530.h                           |   60 +-
 drivers/net/dsa/mv88e6xxx/chip.h                   |    2 +-
 drivers/net/dsa/mv88e6xxx/hwtstamp.c               |   24 +-
 drivers/net/dsa/mv88e6xxx/hwtstamp.h               |   16 +-
 drivers/net/dsa/mv88e6xxx/ptp.c                    |   11 +-
 drivers/net/dsa/ocelot/felix.c                     |   11 +-
 drivers/net/dsa/rzn1_a5psw.c                       |    5 +-
 drivers/net/dsa/sja1105/sja1105_ptp.c              |   46 +-
 drivers/net/dsa/sja1105/sja1105_ptp.h              |    7 +-
 drivers/net/ethernet/airoha/Kconfig                |    7 +
 drivers/net/ethernet/airoha/airoha_eth.c           |  492 +++-
 drivers/net/ethernet/airoha/airoha_eth.h           |  102 +-
 drivers/net/ethernet/airoha/airoha_npu.c           |  178 +-
 drivers/net/ethernet/airoha/airoha_npu.h           |    4 +-
 drivers/net/ethernet/airoha/airoha_ppe.c           |  485 +++-
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c   |    9 +-
 drivers/net/ethernet/airoha/airoha_regs.h          |  203 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |    2 +-
 drivers/net/ethernet/amd/pds_core/adminq.c         |    4 +-
 drivers/net/ethernet/amd/pds_core/core.c           |    7 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h        |  122 +-
 drivers/net/ethernet/amd/xgbe/xgbe-dcb.c           |  117 +-
 drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c       |  117 +-
 drivers/net/ethernet/amd/xgbe/xgbe-desc.c          |  117 +-
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c           |  268 +--
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |  117 +-
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       |  117 +-
 drivers/net/ethernet/amd/xgbe/xgbe-i2c.c           |  117 +-
 drivers/net/ethernet/amd/xgbe/xgbe-main.c          |  117 +-
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |  117 +-
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c           |  204 +-
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v1.c        |  117 +-
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c        |  117 +-
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c      |  117 +-
 drivers/net/ethernet/amd/xgbe/xgbe-ptp.c           |  117 +-
 drivers/net/ethernet/amd/xgbe/xgbe-smn.h           |   30 +
 drivers/net/ethernet/amd/xgbe/xgbe.h               |  128 +-
 drivers/net/ethernet/apple/bmac.c                  |   60 +-
 drivers/net/ethernet/aquantia/atlantic/aq_main.c   |    1 -
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |    2 +
 drivers/net/ethernet/broadcom/Kconfig              |    1 +
 drivers/net/ethernet/broadcom/asp2/bcmasp.c        |  176 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.h        |   78 +-
 .../net/ethernet/broadcom/asp2/bcmasp_ethtool.c    |   36 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |   13 +-
 .../net/ethernet/broadcom/asp2/bcmasp_intf_defs.h  |    3 +-
 drivers/net/ethernet/broadcom/bgmac.c              |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  214 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |    3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c |   11 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h     |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |    5 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h      |    4 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |    4 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |  277 ++-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |   32 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |    2 +-
 drivers/net/ethernet/broadcom/tg3.c                |   23 +-
 drivers/net/ethernet/brocade/bna/bnad.c            |    2 +-
 drivers/net/ethernet/cadence/macb_main.c           |    6 +-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |    8 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c  |   13 +-
 drivers/net/ethernet/chelsio/cxgb/cxgb2.c          |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |   20 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c           |    5 +-
 .../chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c    |   18 +-
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c      |    2 +-
 drivers/net/ethernet/cisco/enic/enic.h             |    1 +
 drivers/net/ethernet/cisco/enic/enic_main.c        |    3 +-
 drivers/net/ethernet/cortina/gemini.c              |   37 +-
 drivers/net/ethernet/dec/tulip/tulip_core.c        |    2 +-
 drivers/net/ethernet/dec/tulip/winbond-840.c       |    2 +-
 drivers/net/ethernet/dlink/dl2k.c                  |   14 +-
 drivers/net/ethernet/dlink/dl2k.h                  |   18 +-
 drivers/net/ethernet/emulex/benet/be_cmds.c        |    8 +-
 drivers/net/ethernet/emulex/benet/be_cmds.h        |    2 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |    2 +-
 drivers/net/ethernet/freescale/Kconfig             |    1 -
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |   41 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |   41 +-
 drivers/net/ethernet/freescale/enetc/Kconfig       |   12 +-
 drivers/net/ethernet/freescale/enetc/Makefile      |    4 +
 drivers/net/ethernet/freescale/enetc/enetc.c       |  123 +-
 drivers/net/ethernet/freescale/enetc/enetc.h       |   51 +-
 .../net/ethernet/freescale/enetc/enetc4_debugfs.c  |   90 +
 .../net/ethernet/freescale/enetc/enetc4_debugfs.h  |   20 +
 drivers/net/ethernet/freescale/enetc/enetc4_hw.h   |   12 +
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c   |  369 ++-
 drivers/net/ethernet/freescale/enetc/enetc_cbdr.c  |   50 +
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   |   78 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |  107 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.h    |   14 +-
 .../net/ethernet/freescale/enetc/enetc_pf_common.c |   93 +-
 .../net/ethernet/freescale/enetc/enetc_pf_common.h |    3 +
 drivers/net/ethernet/freescale/enetc/enetc_vf.c    |   12 +-
 drivers/net/ethernet/freescale/enetc/ntmp.c        |  462 ++++
 .../net/ethernet/freescale/enetc/ntmp_private.h    |  104 +
 drivers/net/ethernet/freescale/gianfar.c           |   53 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c      |    4 +-
 drivers/net/ethernet/google/gve/gve_main.c         |    9 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       |    8 +-
 drivers/net/ethernet/huawei/Kconfig                |    1 +
 drivers/net/ethernet/huawei/Makefile               |    1 +
 drivers/net/ethernet/huawei/hinic3/Kconfig         |   20 +
 drivers/net/ethernet/huawei/hinic3/Makefile        |   21 +
 drivers/net/ethernet/huawei/hinic3/hinic3_common.c |   53 +
 drivers/net/ethernet/huawei/hinic3/hinic3_common.h |   27 +
 drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c |   25 +
 drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h |   53 +
 .../net/ethernet/huawei/hinic3/hinic3_hw_comm.c    |   32 +
 .../net/ethernet/huawei/hinic3/hinic3_hw_comm.h    |   13 +
 .../net/ethernet/huawei/hinic3/hinic3_hw_intf.h    |  113 +
 drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c  |   24 +
 drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h  |   81 +
 drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c   |   21 +
 drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h   |   58 +
 drivers/net/ethernet/huawei/hinic3/hinic3_irq.c    |   62 +
 drivers/net/ethernet/huawei/hinic3/hinic3_lld.c    |  414 ++++
 drivers/net/ethernet/huawei/hinic3/hinic3_lld.h    |   21 +
 drivers/net/ethernet/huawei/hinic3/hinic3_main.c   |  354 +++
 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c   |   16 +
 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h   |   15 +
 drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h   |   13 +
 .../ethernet/huawei/hinic3/hinic3_mgmt_interface.h |  105 +
 .../net/ethernet/huawei/hinic3/hinic3_netdev_ops.c |   78 +
 .../net/ethernet/huawei/hinic3/hinic3_nic_cfg.c    |  233 ++
 .../net/ethernet/huawei/hinic3/hinic3_nic_cfg.h    |   41 +
 .../net/ethernet/huawei/hinic3/hinic3_nic_dev.h    |   82 +
 drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c |   21 +
 drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h |  120 +
 .../ethernet/huawei/hinic3/hinic3_queue_common.c   |   68 +
 .../ethernet/huawei/hinic3/hinic3_queue_common.h   |   54 +
 drivers/net/ethernet/huawei/hinic3/hinic3_rx.c     |  341 +++
 drivers/net/ethernet/huawei/hinic3/hinic3_rx.h     |   90 +
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c     |  670 ++++++
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.h     |  135 ++
 drivers/net/ethernet/huawei/hinic3/hinic3_wq.c     |   29 +
 drivers/net/ethernet/huawei/hinic3/hinic3_wq.h     |   76 +
 drivers/net/ethernet/ibm/Kconfig                   |   13 +
 drivers/net/ethernet/ibm/ibmveth.c                 |  358 ++-
 drivers/net/ethernet/ibm/ibmveth.h                 |   65 +-
 drivers/net/ethernet/intel/Kconfig                 |    3 +
 drivers/net/ethernet/intel/e1000e/e1000.h          |    2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |   75 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |    7 +-
 drivers/net/ethernet/intel/ice/devlink/devlink.c   |   45 +-
 drivers/net/ethernet/intel/ice/ice.h               |   67 +-
 drivers/net/ethernet/intel/ice/ice_common.c        |   22 +-
 drivers/net/ethernet/intel/ice/ice_common.h        |    3 +-
 drivers/net/ethernet/intel/ice/ice_dcb.c           |    2 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c       |   49 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h       |    9 +
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c        |    4 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c       |    6 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |   10 +-
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c  |    2 +-
 drivers/net/ethernet/intel/ice/ice_idc.c           |  207 +-
 drivers/net/ethernet/intel/ice/ice_idc_int.h       |    5 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |   71 +-
 drivers/net/ethernet/intel/ice/ice_lib.h           |    3 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |   81 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |   65 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        |   82 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h        |    5 -
 drivers/net/ethernet/intel/ice/ice_repr.c          |   10 +-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h       |   11 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c         |    4 +
 drivers/net/ethernet/intel/ice/ice_switch.c        |    4 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c        |  266 ++-
 drivers/net/ethernet/intel/ice/ice_tc_lib.h        |   11 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |   17 +-
 drivers/net/ethernet/intel/ice/ice_type.h          |    7 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |   26 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h        |   12 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |   53 +-
 drivers/net/ethernet/intel/idpf/Kconfig            |    1 +
 drivers/net/ethernet/intel/idpf/Makefile           |    3 +
 drivers/net/ethernet/intel/idpf/idpf.h             |   19 +
 .../net/ethernet/intel/idpf/idpf_controlq_api.h    |    3 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c         |   14 +
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c     |   67 +
 drivers/net/ethernet/intel/idpf/idpf_lan_pf_regs.h |    4 +
 drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h    |   13 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |   75 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c        |    9 +-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c         |  873 +++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h         |  362 +++
 .../net/ethernet/intel/idpf/idpf_singleq_txrx.c    |   25 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |  171 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |   18 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |  161 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h    |   84 +
 .../net/ethernet/intel/idpf/idpf_virtchnl_ptp.c    |  615 +++++
 drivers/net/ethernet/intel/idpf/virtchnl2.h        |  314 ++-
 drivers/net/ethernet/intel/igb/igb.h               |    5 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   78 +-
 drivers/net/ethernet/intel/igb/igb_ptp.c           |   20 +-
 drivers/net/ethernet/intel/igb/igb_xsk.c           |    1 +
 drivers/net/ethernet/intel/igc/igc.h               |   16 +-
 drivers/net/ethernet/intel/igc/igc_base.h          |    1 +
 drivers/net/ethernet/intel/igc/igc_defines.h       |   55 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   81 +
 drivers/net/ethernet/intel/igc/igc_main.c          |   90 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c           |   14 +-
 drivers/net/ethernet/intel/igc/igc_regs.h          |   16 +
 drivers/net/ethernet/intel/igc/igc_tsn.c           |  247 +-
 drivers/net/ethernet/intel/igc/igc_tsn.h           |   52 +
 drivers/net/ethernet/intel/ixgbe/Makefile          |    4 +-
 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c |  557 +++++
 drivers/net/ethernet/intel/ixgbe/devlink/devlink.h |   12 +
 drivers/net/ethernet/intel/ixgbe/devlink/region.c  |  290 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe.h           |   24 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c     |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c     |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c    |   56 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c      | 1509 ++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h      |   19 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  257 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c      |   12 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c |  707 ++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.h |   12 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c     |   51 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  282 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c       |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |   16 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      |    5 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h |  175 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c      |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       |    2 +-
 drivers/net/ethernet/intel/ixgbevf/ipsec.c         |   21 +-
 drivers/net/ethernet/marvell/Kconfig               |    1 -
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   58 +-
 .../ethernet/marvell/octeon_ep_vf/octep_vf_main.c  |    2 -
 .../ethernet/marvell/octeon_ep_vf/octep_vf_main.h  |    2 -
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c   |   17 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |    2 +
 .../net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c |    2 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |   11 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |    4 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |    4 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |   58 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_rep.c    |    2 +
 .../net/ethernet/marvell/octeontx2/af/rvu_trace.c  |    2 +
 .../net/ethernet/marvell/octeontx2/af/rvu_trace.h  |   88 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c |    9 +-
 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.c   |   18 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   37 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   10 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   37 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |   11 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |   16 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_xsk.c  |   42 +-
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c   |    4 +-
 .../net/ethernet/marvell/octeontx2/nic/qos_sq.c    |   22 +
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c   |   12 +-
 .../ethernet/marvell/prestera/prestera_counter.c   |    3 +-
 .../net/ethernet/marvell/prestera/prestera_pci.c   |    6 +-
 drivers/net/ethernet/mediatek/mtk_eth_path.c       |   45 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  119 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h        |   61 +-
 drivers/net/ethernet/mediatek/mtk_wed.c            |    4 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |    1 +
 drivers/net/ethernet/mellanox/mlx4/mr.c            |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |    7 +
 .../net/ethernet/mellanox/mlx5/core/en/health.c    |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |   25 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |    4 -
 drivers/net/ethernet/mellanox/mlx5/core/en/trap.c  |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h   |    6 -
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |   28 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |    2 +
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c    |    4 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   82 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |    8 +
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |   81 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |    7 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |   28 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   31 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |    4 +
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |    3 +
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |   26 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |    6 +-
 .../mellanox/mlx5/core/steering/hws/action.c       |  127 +-
 .../mellanox/mlx5/core/steering/hws/action.h       |   10 +-
 .../mlx5/core/steering/hws/action_ste_pool.c       |  467 ++++
 .../mlx5/core/steering/hws/action_ste_pool.h       |   69 +
 .../ethernet/mellanox/mlx5/core/steering/hws/bwc.c |  414 ++--
 .../ethernet/mellanox/mlx5/core/steering/hws/bwc.h |   20 +-
 .../mellanox/mlx5/core/steering/hws/bwc_complex.c  | 1348 ++++++++++-
 .../mellanox/mlx5/core/steering/hws/bwc_complex.h  |   21 +
 .../ethernet/mellanox/mlx5/core/steering/hws/cmd.c |    1 -
 .../ethernet/mellanox/mlx5/core/steering/hws/cmd.h |    1 -
 .../mellanox/mlx5/core/steering/hws/context.c      |    8 +-
 .../mellanox/mlx5/core/steering/hws/context.h      |    2 +
 .../mellanox/mlx5/core/steering/hws/debug.c        |   71 +-
 .../mellanox/mlx5/core/steering/hws/debug.h        |    2 +
 .../mellanox/mlx5/core/steering/hws/definer.c      |  290 ++-
 .../mellanox/mlx5/core/steering/hws/definer.h      |    2 +
 .../mellanox/mlx5/core/steering/hws/fs_hws.c       |   71 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.h       |   16 +
 .../mellanox/mlx5/core/steering/hws/internal.h     |    1 +
 .../mellanox/mlx5/core/steering/hws/matcher.c      |  716 +++---
 .../mellanox/mlx5/core/steering/hws/matcher.h      |   43 +-
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h      |   11 +
 .../mellanox/mlx5/core/steering/hws/pat_arg.c      |   76 +-
 .../mellanox/mlx5/core/steering/hws/pat_arg.h      |    5 +-
 .../mellanox/mlx5/core/steering/hws/pool.c         |  515 ++---
 .../mellanox/mlx5/core/steering/hws/pool.h         |  103 +-
 .../mellanox/mlx5/core/steering/hws/rule.c         |  191 +-
 .../mellanox/mlx5/core/steering/hws/rule.h         |   12 +-
 .../mellanox/mlx5/core/steering/hws/send.c         |  122 +-
 .../mellanox/mlx5/core/steering/hws/send.h         |    1 +
 .../mellanox/mlx5/core/steering/hws/table.c        |   16 +-
 .../mellanox/mlx5/core/steering/hws/table.h        |    5 +
 .../mellanox/mlx5/core/steering/sws/fs_dr.c        |   10 +-
 .../mellanox/mlx5/core/steering/sws/fs_dr.h        |   10 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |   18 +-
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |    8 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |   63 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |    7 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_ethtool.c |    2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c |   30 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h |   20 +-
 drivers/net/ethernet/meta/Kconfig                  |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h            |    6 +-
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h        |   34 +
 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c    |  258 ++-
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c    |  178 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c         |  311 ++-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h         |   56 +-
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c   |  335 ++-
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h   |   48 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c        |    7 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |   47 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |   10 +
 drivers/net/ethernet/microchip/lan743x_ethtool.c   |   18 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |   23 +-
 drivers/net/ethernet/microchip/lan743x_main.h      |    1 +
 drivers/net/ethernet/microchip/lan743x_ptp.c       |   62 +-
 drivers/net/ethernet/microchip/lan743x_ptp.h       |    7 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |    6 +
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |    5 +
 .../net/ethernet/microchip/lan966x/lan966x_ptp.c   |   63 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   24 +-
 drivers/net/ethernet/mscc/ocelot_net.c             |   33 +-
 drivers/net/ethernet/mscc/ocelot_ptp.c             |   48 +-
 drivers/net/ethernet/mscc/ocelot_vsc7514.c         |    2 +
 drivers/net/ethernet/natsemi/natsemi.c             |    2 +-
 drivers/net/ethernet/netronome/nfp/crypto/ipsec.c  |   11 +-
 drivers/net/ethernet/netronome/nfp/nfd3/dp.c       |    2 +-
 drivers/net/ethernet/netronome/nfp/nfdk/dp.c       |    2 +-
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |    2 +-
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |   99 +-
 drivers/net/ethernet/pensando/ionic/ionic_if.h     |   17 +-
 drivers/net/ethernet/qlogic/qed/qed.h              |    1 -
 drivers/net/ethernet/qlogic/qed/qed_dbg_hsi.h      |   31 -
 drivers/net/ethernet/qlogic/qed/qed_debug.c        |   25 -
 drivers/net/ethernet/qlogic/qed/qed_dev.c          |   19 -
 drivers/net/ethernet/qlogic/qed/qed_hsi.h          |   52 -
 drivers/net/ethernet/qlogic/qed/qed_hw.c           |   11 -
 drivers/net/ethernet/qlogic/qed/qed_hw.h           |    9 -
 .../net/ethernet/qlogic/qed/qed_init_fw_funcs.c    |  138 --
 drivers/net/ethernet/qualcomm/Kconfig              |    1 -
 drivers/net/ethernet/realtek/r8169.h               |    7 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  434 ++--
 drivers/net/ethernet/realtek/r8169_phy_config.c    |  205 +-
 drivers/net/ethernet/realtek/rtase/rtase.h         |   15 +
 drivers/net/ethernet/realtek/rtase/rtase_main.c    |   66 +-
 drivers/net/ethernet/renesas/ravb_ptp.c            |   11 +-
 drivers/net/ethernet/rocker/rocker_ofdpa.c         |    2 +-
 drivers/net/ethernet/sis/sis900.c                  |    2 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   12 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    3 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |    1 +
 .../net/ethernet/stmicro/stmmac/dwmac-anarion.c    |   25 +-
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |   57 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |   14 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ingenic.c    |   46 +-
 .../net/ethernet/stmicro/stmmac/dwmac-intel-plat.c |    9 -
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   42 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h  |    1 -
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |  108 +-
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |    1 -
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |   43 +-
 .../ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c  |  146 ++
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |  101 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    |   88 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |   57 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   10 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c  |   58 +-
 .../net/ethernet/stmicro/stmmac/dwmac-visconti.c   |   25 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |   41 -
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  295 +--
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   25 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |   89 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_descs.c   |   18 +
 drivers/net/ethernet/stmicro/stmmac/hwif.c         |    9 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   62 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   18 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   43 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c   |  174 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h   |    5 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  157 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   11 +
 .../net/ethernet/stmicro/stmmac/stmmac_platform.h  |    3 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c  |  374 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h  |   64 +
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   28 +-
 drivers/net/ethernet/ti/cpsw.c                     |   26 +
 drivers/net/ethernet/ti/cpsw_new.c                 |    4 +-
 drivers/net/ethernet/ti/cpsw_priv.c                |   70 +-
 drivers/net/ethernet/ti/cpsw_priv.h                |    6 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c       |   24 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h       |    2 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.c        |    8 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.h        |   58 +-
 drivers/net/ethernet/ti/icssg/icssg_switch_map.h   |   33 +
 drivers/net/ethernet/vertexcom/mse102x.c           |   80 +-
 drivers/net/ethernet/wangxun/Kconfig               |    4 +-
 drivers/net/ethernet/wangxun/libwx/Makefile        |    2 +-
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c    |   22 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |  347 ++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h         |    5 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |  188 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h        |    8 +-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c        |  176 ++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h        |   77 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c        |   30 +-
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c      |  909 ++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h      |   18 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |  115 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c      |   94 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c      |    5 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h      |    3 +
 drivers/net/ethernet/wangxun/txgbe/Makefile        |    3 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c     |  385 ++++
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h     |   15 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c |   38 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.h |    2 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c    |   23 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c      |    4 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c     |   60 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |  206 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |   47 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h     |    2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h    |  116 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |    8 +-
 drivers/net/ethernet/xscale/ixp4xx_eth.c           |   61 +-
 drivers/net/geneve.c                               |   16 +-
 drivers/net/gtp.c                                  |   18 +-
 drivers/net/hamradio/baycom_epp.c                  |    5 +-
 drivers/net/hyperv/netvsc_drv.c                    |    6 +-
 drivers/net/ipa/data/ipa_data-v3.1.c               |    1 -
 drivers/net/ipa/data/ipa_data-v3.5.1.c             |    1 -
 drivers/net/ipa/data/ipa_data-v4.11.c              |    1 -
 drivers/net/ipa/data/ipa_data-v4.2.c               |    1 -
 drivers/net/ipa/data/ipa_data-v4.5.c               |    1 -
 drivers/net/ipa/data/ipa_data-v4.7.c               |    1 -
 drivers/net/ipa/data/ipa_data-v4.9.c               |    1 -
 drivers/net/ipa/data/ipa_data-v5.0.c               |    1 -
 drivers/net/ipa/data/ipa_data-v5.5.c               |    1 -
 drivers/net/ipa/ipa_data.h                         |    2 -
 drivers/net/ipa/ipa_mem.c                          |   21 +-
 drivers/net/ipvlan/ipvlan_core.c                   |    2 +-
 drivers/net/macvlan.c                              |   20 +-
 drivers/net/mctp/mctp-usb.c                        |    2 +
 drivers/net/mdio/Kconfig                           |   48 +-
 drivers/net/mdio/Makefile                          |    1 +
 drivers/net/mdio/mdio-bcm-unimac.c                 |    2 +-
 drivers/net/mdio/mdio-realtek-rtl9300.c            |  522 +++++
 drivers/net/mdio/mdio-thunder.c                    |   10 +-
 drivers/net/mdio/of_mdio.c                         |    2 +-
 drivers/net/netdevsim/ipsec.c                      |   15 +-
 drivers/net/netdevsim/netdev.c                     |    4 +
 drivers/net/ovpn/Makefile                          |   22 +
 drivers/net/ovpn/bind.c                            |   55 +
 drivers/net/ovpn/bind.h                            |  101 +
 drivers/net/ovpn/crypto.c                          |  210 ++
 drivers/net/ovpn/crypto.h                          |  145 ++
 drivers/net/ovpn/crypto_aead.c                     |  389 ++++
 drivers/net/ovpn/crypto_aead.h                     |   29 +
 drivers/net/ovpn/io.c                              |  458 ++++
 drivers/net/ovpn/io.h                              |   34 +
 drivers/net/ovpn/main.c                            |  279 +++
 drivers/net/ovpn/main.h                            |   14 +
 drivers/net/ovpn/netlink-gen.c                     |  213 ++
 drivers/net/ovpn/netlink-gen.h                     |   41 +
 drivers/net/ovpn/netlink.c                         | 1258 +++++++++++
 drivers/net/ovpn/netlink.h                         |   18 +
 drivers/net/ovpn/ovpnpriv.h                        |   55 +
 drivers/net/ovpn/peer.c                            | 1364 +++++++++++
 drivers/net/ovpn/peer.h                            |  163 ++
 drivers/net/ovpn/pktid.c                           |  129 ++
 drivers/net/ovpn/pktid.h                           |   86 +
 drivers/net/ovpn/proto.h                           |  118 +
 drivers/net/ovpn/skb.h                             |   61 +
 drivers/net/ovpn/socket.c                          |  233 ++
 drivers/net/ovpn/socket.h                          |   49 +
 drivers/net/ovpn/stats.c                           |   21 +
 drivers/net/ovpn/stats.h                           |   47 +
 drivers/net/ovpn/tcp.c                             |  598 +++++
 drivers/net/ovpn/tcp.h                             |   36 +
 drivers/net/ovpn/udp.c                             |  449 ++++
 drivers/net/ovpn/udp.h                             |   25 +
 drivers/net/pfcp.c                                 |   23 +-
 drivers/net/phy/Kconfig                            |   29 +-
 drivers/net/phy/Makefile                           |   22 +-
 drivers/net/phy/air_en8811h.c                      |  103 +-
 drivers/net/phy/aquantia/aquantia_main.c           |    6 +-
 drivers/net/phy/as21xxx.c                          | 1087 +++++++++
 drivers/net/phy/bcm87xx.c                          |   14 +-
 drivers/net/phy/dp83640.c                          |   13 +-
 drivers/net/phy/dp83822.c                          |   33 +
 drivers/net/phy/dp83867.c                          |   76 +-
 drivers/net/phy/fixed_phy.c                        |   40 +-
 drivers/net/phy/icplus.c                           |    6 +-
 drivers/net/phy/marvell-88q2xxx.c                  |  111 +-
 drivers/net/phy/marvell10g.c                       |   12 +-
 drivers/net/phy/mdio_bus.c                         |  476 +---
 drivers/net/phy/mdio_bus_provider.c                |  484 ++++
 drivers/net/phy/mdio_device.c                      |    1 +
 drivers/net/phy/mediatek/Kconfig                   |   20 +-
 drivers/net/phy/mediatek/Makefile                  |    3 +-
 drivers/net/phy/mediatek/mtk-2p5ge.c               |  321 +++
 drivers/net/phy/mediatek/mtk-ge-soc.c              |   91 +-
 drivers/net/phy/micrel.c                           |   23 +-
 drivers/net/phy/microchip.c                        |    2 +
 drivers/net/phy/microchip_rds_ptp.c                |    5 +-
 drivers/net/phy/mscc/mscc_ptp.c                    |   20 +-
 drivers/net/phy/mxl-86110.c                        |  616 +++++
 drivers/net/phy/nxp-c45-tja11xx.c                  |   54 +-
 drivers/net/phy/nxp-tja11xx.c                      |    6 +-
 drivers/net/phy/phy_device.c                       |  102 +-
 drivers/net/phy/phylink.c                          |    7 -
 drivers/net/phy/realtek/realtek_main.c             |  337 ++-
 drivers/net/phy/teranetics.c                       |    3 +-
 drivers/net/ppp/ppp_generic.c                      |   25 +-
 drivers/net/tap.c                                  |   14 +-
 drivers/net/team/team_core.c                       |    2 +-
 drivers/net/tun.c                                  |    8 +-
 drivers/net/usb/Kconfig                            |    4 +-
 drivers/net/usb/aqc111.c                           |   10 +-
 drivers/net/usb/asix.h                             |    1 -
 drivers/net/usb/asix_common.c                      |   22 -
 drivers/net/usb/asix_devices.c                     |   17 +-
 drivers/net/usb/lan78xx.c                          |  462 +++-
 drivers/net/usb/r8152.c                            |   98 +-
 drivers/net/veth.c                                 |   57 +-
 drivers/net/vrf.c                                  |    4 +-
 drivers/net/vxlan/vxlan_core.c                     |  560 ++---
 drivers/net/vxlan/vxlan_private.h                  |   11 +-
 drivers/net/vxlan/vxlan_vnifilter.c                |   20 +-
 drivers/net/wireguard/allowedips.c                 |  102 +-
 drivers/net/wireguard/allowedips.h                 |    4 +
 drivers/net/wireguard/cookie.c                     |    4 +-
 drivers/net/wireguard/netlink.c                    |   47 +-
 drivers/net/wireguard/noise.c                      |    4 +-
 drivers/net/wireguard/selftest/allowedips.c        |   48 +
 drivers/net/wireless/ath/ath10k/ahb.c              |    2 +-
 drivers/net/wireless/ath/ath10k/bmi.c              |    6 +-
 drivers/net/wireless/ath/ath10k/ce.c               |   32 +-
 drivers/net/wireless/ath/ath10k/core.c             |    4 +-
 drivers/net/wireless/ath/ath10k/htc.c              |    6 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c           |    2 +-
 drivers/net/wireless/ath/ath10k/hw.c               |   62 +-
 drivers/net/wireless/ath/ath10k/hw.h               |   34 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   22 +-
 drivers/net/wireless/ath/ath10k/pci.c              |    2 +-
 drivers/net/wireless/ath/ath10k/sdio.c             |    2 +-
 drivers/net/wireless/ath/ath10k/testmode.c         |    4 +-
 drivers/net/wireless/ath/ath10k/txrx.c             |    2 +-
 drivers/net/wireless/ath/ath10k/usb.c              |    4 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |    4 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |    4 +-
 drivers/net/wireless/ath/ath11k/ce.c               |   11 +-
 drivers/net/wireless/ath/ath11k/core.c             |  302 ++-
 drivers/net/wireless/ath/ath11k/core.h             |   16 +
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   25 +-
 drivers/net/wireless/ath/ath11k/hal.c              |    4 +-
 drivers/net/wireless/ath/ath11k/hif.h              |   14 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   52 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |   14 +-
 drivers/net/wireless/ath/ath11k/mhi.h              |    4 +-
 drivers/net/wireless/ath/ath11k/pci.c              |   50 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |   13 +-
 drivers/net/wireless/ath/ath11k/testmode.c         |    2 +-
 drivers/net/wireless/ath/ath12k/Kconfig            |    8 +
 drivers/net/wireless/ath/ath12k/Makefile           |    1 +
 drivers/net/wireless/ath/ath12k/ahb.c              | 1155 ++++++++++
 drivers/net/wireless/ath/ath12k/ahb.h              |   80 +
 drivers/net/wireless/ath/ath12k/ce.c               |  103 +-
 drivers/net/wireless/ath/ath12k/ce.h               |   18 +-
 drivers/net/wireless/ath/ath12k/core.c             |  329 ++-
 drivers/net/wireless/ath/ath12k/core.h             |  169 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |  497 +++-
 drivers/net/wireless/ath/ath12k/debugfs.h          |   17 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    |    3 +
 drivers/net/wireless/ath/ath12k/dp.c               |  154 +-
 drivers/net/wireless/ath/ath12k/dp.h               |   53 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           | 1097 ++++++++-
 drivers/net/wireless/ath/ath12k/dp_mon.h           |    8 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  596 +++--
 drivers/net/wireless/ath/ath12k/dp_rx.h            |   41 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |  209 +-
 drivers/net/wireless/ath/ath12k/dp_tx.h            |    3 +-
 drivers/net/wireless/ath/ath12k/fw.c               |    9 +-
 drivers/net/wireless/ath/ath12k/fw.h               |    3 +-
 drivers/net/wireless/ath/ath12k/hal.c              |  153 +-
 drivers/net/wireless/ath/ath12k/hal.h              |   80 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h         |   13 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c           |  121 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h           |   27 +-
 drivers/net/wireless/ath/ath12k/hw.c               |  511 ++++-
 drivers/net/wireless/ath/ath12k/hw.h               |   30 +-
 drivers/net/wireless/ath/ath12k/mac.c              | 1439 +++++++++---
 drivers/net/wireless/ath/ath12k/mac.h              |   56 +
 drivers/net/wireless/ath/ath12k/mhi.c              |    9 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   66 +-
 drivers/net/wireless/ath/ath12k/pci.h              |    5 +-
 drivers/net/wireless/ath/ath12k/peer.c             |    5 +-
 drivers/net/wireless/ath/ath12k/peer.h             |    3 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |  238 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |    5 +-
 drivers/net/wireless/ath/ath12k/reg.c              |  526 +++--
 drivers/net/wireless/ath/ath12k/reg.h              |   20 +-
 drivers/net/wireless/ath/ath12k/testmode.c         |    4 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  558 +++--
 drivers/net/wireless/ath/ath12k/wmi.h              |  119 +-
 drivers/net/wireless/ath/ath9k/ahb.c               |   13 +-
 drivers/net/wireless/ath/ath9k/htc_drv_beacon.c    |    3 +
 drivers/net/wireless/ath/carl9170/tx.c             |    3 +-
 drivers/net/wireless/ath/wcn36xx/testmode.c        |    2 +-
 drivers/net/wireless/ath/wil6210/txrx.h            |    4 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   44 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         |   25 +
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |    1 +
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |    2 +
 .../broadcom/brcm80211/brcmfmac/cyw/core.c         |  308 +++
 .../broadcom/brcm80211/brcmfmac/cyw/fwil_types.h   |   87 +
 .../wireless/broadcom/brcm80211/brcmfmac/feature.c |    3 +-
 .../wireless/broadcom/brcm80211/brcmfmac/feature.h |    4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fweh.c    |    7 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fweh.h    |    8 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwvid.h   |   29 +
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |   23 +-
 .../wireless/broadcom/brcm80211/brcmsmac/aiutils.c |    6 +-
 .../wireless/broadcom/brcm80211/brcmsmac/aiutils.h |    2 +-
 .../wireless/broadcom/brcm80211/brcmsmac/ampdu.c   |    4 +-
 .../wireless/broadcom/brcm80211/brcmsmac/channel.c |    4 +-
 .../net/wireless/broadcom/brcm80211/brcmsmac/dma.c |    2 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |    4 +-
 .../wireless/broadcom/brcm80211/brcmsmac/main.c    |    4 +-
 .../wireless/broadcom/brcm80211/brcmsmac/main.h    |    2 +-
 .../net/wireless/broadcom/brcm80211/brcmsmac/pmu.c |    2 +-
 drivers/net/wireless/intel/iwlwifi/Makefile        |   17 +-
 drivers/net/wireless/intel/iwlwifi/cfg/1000.c      |   51 +-
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c      |   90 +-
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c     |  378 +---
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c      |   83 +-
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c      |  227 +-
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c      |  173 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c      |   92 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c      |  168 +-
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |  228 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |  169 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |  170 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c     |   51 +
 drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c     |   42 +
 drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c     |   42 +
 drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c     |   84 +
 drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c     |   16 +
 drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c     |   15 +
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |  148 +-
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h       |    4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c   |    8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h       |    3 +-
 drivers/net/wireless/intel/iwlwifi/dvm/devices.c   |    4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c    |   53 +-
 drivers/net/wireless/intel/iwlwifi/dvm/led.c       |    6 +-
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c  |   10 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |   77 +-
 drivers/net/wireless/intel/iwlwifi/dvm/power.c     |   34 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c        |    8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c      |    8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c        |    6 +-
 drivers/net/wireless/intel/iwlwifi/dvm/ucode.c     |   10 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |   28 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |   11 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h  |   10 +
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |    6 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |    8 +-
 .../net/wireless/intel/iwlwifi/fw/api/location.h   |   89 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |  192 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h    |    6 +-
 .../net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h   |    9 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |   47 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h     |   83 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |   32 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h  |    5 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h   |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |   40 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  120 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |   12 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |    7 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |   28 +
 drivers/net/wireless/intel/iwlwifi/fw/init.c       |   20 +-
 drivers/net/wireless/intel/iwlwifi/fw/paging.c     |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c       |   61 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h       |    5 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |   45 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |   23 +-
 drivers/net/wireless/intel/iwlwifi/fw/rs.c         |  137 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |    9 +-
 drivers/net/wireless/intel/iwlwifi/fw/smem.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |   74 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |   37 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |  498 ++--
 ...l-context-info-gen3.h => iwl-context-info-v2.h} |   59 +-
 .../net/wireless/intel/iwlwifi/iwl-context-info.h  |   14 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |   29 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |    8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h  |    9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  154 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h       |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h        |   30 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c        |   24 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.h        |   14 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |  122 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |   16 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c |   17 +-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h   |   17 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |  237 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |  241 +-
 drivers/net/wireless/intel/iwlwifi/iwl-utils.c     |    1 -
 drivers/net/wireless/intel/iwlwifi/mld/agg.c       |   14 +-
 drivers/net/wireless/intel/iwlwifi/mld/ap.c        |    9 +
 drivers/net/wireless/intel/iwlwifi/mld/coex.c      |    8 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |    9 +-
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c   |   25 +-
 drivers/net/wireless/intel/iwlwifi/mld/fw.c        |  121 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |   49 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.h     |   11 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |    9 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.h      |   10 +-
 .../net/wireless/intel/iwlwifi/mld/low_latency.c   |   12 +-
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |   94 +-
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |   95 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |   21 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |  235 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h       |   16 +-
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |   65 +-
 drivers/net/wireless/intel/iwlwifi/mld/notif.h     |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/phy.c       |   43 +
 drivers/net/wireless/intel/iwlwifi/mld/phy.h       |    5 +
 drivers/net/wireless/intel/iwlwifi/mld/power.c     |    3 +
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c       |    2 +-
 .../net/wireless/intel/iwlwifi/mld/regulatory.c    |    6 +-
 drivers/net/wireless/intel/iwlwifi/mld/roc.c       |  105 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c        |  155 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      |    3 +
 drivers/net/wireless/intel/iwlwifi/mld/sta.c       |   54 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.h       |    7 +
 drivers/net/wireless/intel/iwlwifi/mld/stats.c     |   29 +-
 .../net/wireless/intel/iwlwifi/mld/tests/Makefile  |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c |   14 +-
 .../intel/iwlwifi/mld/tests/emlsr_with_bt.c        |  140 ++
 .../net/wireless/intel/iwlwifi/mld/tests/hcmd.c    |    6 +-
 .../intel/iwlwifi/mld/tests/link-selection.c       |  144 +-
 .../net/wireless/intel/iwlwifi/mld/tests/link.c    |    4 +-
 .../net/wireless/intel/iwlwifi/mld/tests/utils.c   |   39 +-
 .../net/wireless/intel/iwlwifi/mld/tests/utils.h   |   84 +-
 drivers/net/wireless/intel/iwlwifi/mld/thermal.c   |   89 +-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c       |    8 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c        |  122 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c      |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   34 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   85 +-
 drivers/net/wireless/intel/iwlwifi/mvm/led.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   19 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  155 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c   |   46 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |   15 -
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |   10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   54 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |   42 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |  122 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/quota.c     |   43 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c     |   23 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |  204 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h        |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   83 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   34 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |    7 +-
 .../net/wireless/intel/iwlwifi/mvm/tests/Makefile  |    2 +-
 .../net/wireless/intel/iwlwifi/mvm/tests/hcmd.c    |   38 +
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |   93 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  194 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |   24 +-
 .../pcie/{ctxt-info-gen3.c => ctxt-info-v2.c}      |  200 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info.c    |   20 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      | 2383 +++++++++-----------
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |  114 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |  187 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |  144 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  292 +--
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  |   76 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |  226 +-
 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c |  174 +-
 drivers/net/wireless/intersil/p54/fwio.c           |    2 +
 drivers/net/wireless/intersil/p54/p54.h            |    1 +
 drivers/net/wireless/intersil/p54/txrx.c           |   13 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   42 +-
 drivers/net/wireless/marvell/mwifiex/cfp.c         |    4 +-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c      |   74 +-
 drivers/net/wireless/marvell/mwifiex/init.c        |   21 +-
 drivers/net/wireless/marvell/mwifiex/main.c        |   44 +-
 drivers/net/wireless/marvell/mwifiex/main.h        |   13 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c        |    2 +-
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c     |   51 +-
 drivers/net/wireless/marvell/mwifiex/txrx.c        |    3 +-
 drivers/net/wireless/marvell/mwifiex/util.c        |   20 +-
 drivers/net/wireless/marvell/mwifiex/wmm.c         |   12 +-
 drivers/net/wireless/mediatek/mt76/channel.c       |    4 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   10 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |   20 +-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |    7 +-
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  |    1 +
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   43 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   14 +
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  |    1 -
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c    |    2 +
 .../net/wireless/mediatek/mt76/mt76x2/usb_init.c   |   13 +-
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c    |   28 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c |   33 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h |    1 +
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   14 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |   60 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |   48 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |    6 +
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |   25 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |    5 +
 drivers/net/wireless/mediatek/mt76/mt7925/Makefile |    1 +
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |    8 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |   28 +
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  154 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |   82 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |    6 +
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h   |    2 +-
 .../net/wireless/mediatek/mt76/mt7925/testmode.c   |  201 ++
 .../net/wireless/mediatek/mt76/mt7996/coredump.c   |    4 +-
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |   17 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |  196 +-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c |   42 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |   41 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  120 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   29 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  120 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |   12 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |  195 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |   82 +-
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |   21 +-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |   51 +-
 drivers/net/wireless/purelifi/plfxlc/usb.c         |    4 +-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |    2 +-
 drivers/net/wireless/realtek/rtlwifi/core.c        |   11 -
 drivers/net/wireless/realtek/rtlwifi/core.h        |    1 -
 drivers/net/wireless/realtek/rtlwifi/pci.c         |   10 +
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.c   |    5 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192du/phy.c   |    5 -
 .../net/wireless/realtek/rtlwifi/rtl8192du/phy.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ee/phy.c   |    4 -
 .../net/wireless/realtek/rtlwifi/rtl8192ee/phy.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8821ae/phy.c   |    4 -
 .../net/wireless/realtek/rtlwifi/rtl8821ae/phy.h   |    1 -
 drivers/net/wireless/realtek/rtlwifi/usb.c         |   12 -
 drivers/net/wireless/realtek/rtlwifi/usb.h         |    2 -
 drivers/net/wireless/realtek/rtw88/coex.c          |    2 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |    8 +-
 drivers/net/wireless/realtek/rtw88/hci.h           |    8 +
 drivers/net/wireless/realtek/rtw88/mac.c           |   11 +-
 drivers/net/wireless/realtek/rtw88/mac.h           |    2 +
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    2 +
 drivers/net/wireless/realtek/rtw88/main.c          |   35 +-
 drivers/net/wireless/realtek/rtw88/main.h          |    4 +
 drivers/net/wireless/realtek/rtw88/pci.c           |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |   61 +-
 drivers/net/wireless/realtek/rtw88/rtw8723cs.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8723de.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723ds.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723du.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723x.c      |   59 +
 drivers/net/wireless/realtek/rtw88/rtw8812a.c      |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8812au.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8814a.c      |   12 +
 drivers/net/wireless/realtek/rtw88/rtw8814ae.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8814au.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821a.c      |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8821au.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8821ce.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821cs.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8822be.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822bs.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c     |    4 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |    5 +-
 drivers/net/wireless/realtek/rtw88/rtw8822ce.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822cs.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822cu.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |   27 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |   63 +-
 drivers/net/wireless/realtek/rtw89/acpi.c          | 1037 ++++++++-
 drivers/net/wireless/realtek/rtw89/acpi.h          |  190 ++
 drivers/net/wireless/realtek/rtw89/cam.c           |    7 +
 drivers/net/wireless/realtek/rtw89/chan.c          |  418 ++--
 drivers/net/wireless/realtek/rtw89/chan.h          |   17 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  493 ++--
 drivers/net/wireless/realtek/rtw89/core.h          |  144 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |  174 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  480 +++-
 drivers/net/wireless/realtek/rtw89/fw.h            |   94 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |   58 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   19 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   38 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    3 +
 drivers/net/wireless/realtek/rtw89/pci.c           |   36 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |  131 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |   15 +
 drivers/net/wireless/realtek/rtw89/phy_be.c        |    2 +-
 drivers/net/wireless/realtek/rtw89/ps.c            |  147 ++
 drivers/net/wireless/realtek/rtw89/ps.h            |    3 +
 drivers/net/wireless/realtek/rtw89/reg.h           |   15 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |   46 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |    2 +
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |   24 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   30 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   32 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |    5 -
 drivers/net/wireless/realtek/rtw89/sar.c           |  296 ++-
 drivers/net/wireless/realtek/rtw89/sar.h           |   19 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |    3 +
 drivers/net/wireless/realtek/rtw89/txrx.h          |   31 +
 drivers/net/wireless/realtek/rtw89/wow.c           |    3 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   12 +-
 drivers/nfc/s3fwrn5/core.c                         |    2 +-
 drivers/nfc/s3fwrn5/firmware.c                     |    2 +-
 drivers/nfc/s3fwrn5/firmware.h                     |    2 +-
 drivers/nfc/s3fwrn5/i2c.c                          |    2 +-
 drivers/nfc/s3fwrn5/nci.c                          |    2 +-
 drivers/nfc/s3fwrn5/nci.h                          |    2 +-
 drivers/nfc/s3fwrn5/phy_common.c                   |    4 +-
 drivers/nfc/s3fwrn5/phy_common.h                   |    4 +-
 drivers/nfc/s3fwrn5/s3fwrn5.h                      |    2 +-
 drivers/nfc/virtual_ncidev.c                       |    2 +-
 drivers/nvme/host/Kconfig                          |    4 +-
 drivers/nvme/host/tcp.c                            |  124 +-
 drivers/nvme/target/rdma.c                         |    2 +-
 drivers/nvme/target/tcp.c                          |    2 +-
 drivers/ptp/Kconfig                                |    4 +-
 drivers/ptp/ptp_chardev.c                          |   16 +-
 drivers/ptp/ptp_clockmatrix.c                      |   14 +-
 drivers/ptp/ptp_fc3.c                              |    1 +
 drivers/ptp/ptp_idt82p33.c                         |   15 +-
 drivers/ptp/ptp_ocp.c                              |    2 +-
 drivers/s390/net/ism_drv.c                         |    2 +-
 drivers/ssb/driver_gpio.c                          |    8 +-
 drivers/target/iscsi/iscsi_target.c                |    2 +-
 drivers/vhost/net.c                                |   30 +-
 fs/afs/Kconfig                                     |    1 +
 fs/afs/Makefile                                    |    1 +
 fs/afs/cm_security.c                               |  340 +++
 fs/afs/internal.h                                  |   20 +
 fs/afs/main.c                                      |    1 +
 fs/afs/misc.c                                      |   27 +
 fs/afs/rxrpc.c                                     |   40 +-
 fs/afs/server.c                                    |    2 +
 include/crypto/krb5.h                              |    5 +
 include/keys/rxrpc-type.h                          |   17 +
 include/linux/btf.h                                |    1 +
 include/linux/can/dev.h                            |   28 +-
 include/linux/crc32.h                              |   23 -
 include/linux/dccp.h                               |  289 ---
 include/linux/ethtool.h                            |   98 +-
 include/linux/fsl/ntmp.h                           |  121 +
 include/linux/ieee80211.h                          |   78 +
 include/linux/inet.h                               |    2 +-
 include/linux/mdio.h                               |    5 +-
 include/linux/mm.h                                 |   58 +
 include/linux/net.h                                |   15 +-
 include/linux/net/intel/iidc.h                     |  109 -
 include/linux/net/intel/iidc_rdma.h                |   68 +
 include/linux/net/intel/iidc_rdma_ice.h            |   70 +
 include/linux/net_tstamp.h                         |    7 +-
 include/linux/netdevice.h                          |   49 +-
 include/linux/netdevice_xmit.h                     |    6 +
 include/linux/netfilter.h                          |   15 +-
 include/linux/netlink.h                            |    3 +-
 include/linux/pds/pds_adminq.h                     |    3 +-
 include/linux/phy.h                                |   70 +-
 include/linux/phy_fixed.h                          |   30 +-
 include/linux/poison.h                             |    4 +
 include/linux/ptp_clock_kernel.h                   |   18 +
 include/linux/sched.h                              |    1 +
 include/linux/skbuff.h                             |   41 +-
 include/linux/skbuff_ref.h                         |    4 +-
 include/linux/soc/mediatek/mtk_wed.h               |    2 +-
 include/linux/socket.h                             |    2 +-
 include/linux/stmmac.h                             |    4 +-
 include/linux/tcp.h                                |    5 +-
 include/linux/tfrc.h                               |   51 -
 include/linux/udp.h                                |   19 +
 include/linux/uio.h                                |    8 +-
 include/linux/virtio_vsock.h                       |    1 +
 include/net/af_rxrpc.h                             |   54 +-
 include/net/af_vsock.h                             |    1 +
 include/net/bluetooth/bluetooth.h                  |    4 +
 include/net/bluetooth/hci.h                        |    4 +-
 include/net/bluetooth/hci_core.h                   |   51 +-
 include/net/bluetooth/hci_drv.h                    |   76 +
 include/net/bluetooth/hci_mon.h                    |    2 +
 include/net/cfg80211.h                             |   44 +-
 include/net/checksum.h                             |   12 -
 include/net/devlink.h                              |   10 +-
 include/net/dropreason-core.h                      |   10 +
 include/net/dsa.h                                  |    5 +-
 include/net/flow.h                                 |    1 +
 include/net/inet_hashtables.h                      |    7 +-
 include/net/ip6_fib.h                              |    1 +
 include/net/ip_fib.h                               |    3 +-
 include/net/ip_tunnels.h                           |    7 +-
 include/net/lwtunnel.h                             |   13 +-
 include/net/mac80211.h                             |   28 +-
 include/net/mana/mana.h                            |    4 +-
 include/net/mptcp.h                                |   13 +-
 include/net/net_namespace.h                        |    4 +-
 include/net/netdev_lock.h                          |   47 +-
 include/net/netdev_queues.h                        |   22 +-
 include/net/netdev_rx_queue.h                      |    6 +-
 include/net/netfilter/nf_tables.h                  |   12 +-
 include/net/netfilter/nft_fib.h                    |    9 +
 include/net/netlink.h                              |   22 +
 include/net/netmem.h                               |   34 +-
 include/net/netns/ipv4.h                           |   11 +
 include/net/netns/ipv6.h                           |    1 +
 include/net/nexthop.h                              |    2 +
 include/net/p8022.h                                |   16 -
 include/net/page_pool/helpers.h                    |   11 +
 include/net/page_pool/types.h                      |    6 +
 include/net/route.h                                |    3 +
 include/net/rps.h                                  |   29 +-
 include/net/rstreason.h                            |    2 +-
 include/net/sch_generic.h                          |    8 +
 include/net/scm.h                                  |  121 +-
 include/net/sctp/checksum.h                        |   29 +-
 include/net/sctp/sctp.h                            |    2 -
 include/net/sctp/sm.h                              |    1 -
 include/net/sctp/structs.h                         |    2 -
 include/net/secure_seq.h                           |    4 -
 include/net/sock.h                                 |   46 +-
 include/net/strparser.h                            |    2 -
 include/net/tcp.h                                  |    3 +-
 include/net/udp.h                                  |    1 +
 include/net/udp_tunnel.h                           |   15 +
 include/net/vxlan.h                                |    5 +-
 include/net/xdp.h                                  |    4 +
 include/net/xfrm.h                                 |   19 +-
 include/soc/mscc/ocelot.h                          |    7 +-
 include/trace/events/afs.h                         |   11 +-
 include/trace/events/rxrpc.h                       |  163 +-
 include/trace/events/sock.h                        |    1 -
 include/trace/events/sunrpc.h                      |    2 -
 include/trace/events/tcp.h                         |   99 +-
 include/uapi/asm-generic/socket.h                  |    2 +
 include/uapi/linux/devlink.h                       |   15 +
 include/uapi/linux/ethtool.h                       |  134 +-
 include/uapi/linux/ethtool_netlink_generated.h     |   14 +
 include/uapi/linux/fib_rules.h                     |    4 +-
 include/uapi/linux/if_addr.h                       |    4 +-
 include/uapi/linux/if_addrlabel.h                  |    4 +-
 include/uapi/linux/if_alg.h                        |    6 +-
 include/uapi/linux/if_arcnet.h                     |    6 +-
 include/uapi/linux/if_bonding.h                    |    6 +-
 include/uapi/linux/if_bridge.h                     |   10 +-
 include/uapi/linux/if_fc.h                         |    6 +-
 include/uapi/linux/if_hippi.h                      |    6 +-
 include/uapi/linux/if_link.h                       |   15 +
 include/uapi/linux/if_packet.h                     |    4 +-
 include/uapi/linux/if_plip.h                       |    4 +-
 include/uapi/linux/if_slip.h                       |    4 +-
 include/uapi/linux/if_x25.h                        |    6 +-
 include/uapi/linux/if_xdp.h                        |    6 +-
 include/uapi/linux/ip6_tunnel.h                    |    4 +-
 include/uapi/linux/neighbour.h                     |    4 +-
 include/uapi/linux/net_dropmon.h                   |    4 +-
 include/uapi/linux/net_tstamp.h                    |    6 +-
 include/uapi/linux/netdev.h                        |    1 +
 include/uapi/linux/netfilter/nf_tables.h           |   22 +
 include/uapi/linux/netfilter/nfnetlink.h           |    2 +
 include/uapi/linux/netlink_diag.h                  |    4 +-
 include/uapi/linux/nl80211.h                       |    6 +
 include/uapi/linux/ovpn.h                          |  109 +
 include/uapi/linux/pkt_cls.h                       |    5 +-
 include/uapi/linux/pkt_sched.h                     |    5 +-
 include/uapi/linux/rxrpc.h                         |   77 +-
 include/uapi/linux/snmp.h                          |    1 +
 include/uapi/linux/tcp.h                           |    1 +
 include/uapi/linux/udp.h                           |    1 +
 include/uapi/linux/wireguard.h                     |    9 +
 io_uring/zcrx.c                                    |    3 +-
 kernel/bpf/btf.c                                   |    7 +-
 kernel/configs/debug.config                        |    5 +
 lib/crc32.c                                        |    6 -
 lib/pldmfw/pldmfw.c                                |    6 +
 lib/tests/crc_kunit.c                              |    6 -
 mm/page_alloc.c                                    |    8 +-
 net/802/Makefile                                   |    5 +-
 net/802/p8022.c                                    |   64 -
 net/8021q/vlan.c                                   |    1 -
 net/Kconfig                                        |    7 +-
 net/Makefile                                       |    1 -
 net/batman-adv/main.c                              |    4 +-
 net/batman-adv/main.h                              |    3 +-
 net/batman-adv/mesh-interface.c                    |   15 -
 net/batman-adv/send.c                              |    4 +-
 net/batman-adv/translation-table.c                 |    2 +-
 net/bluetooth/Makefile                             |    3 +-
 net/bluetooth/af_bluetooth.c                       |   87 +
 net/bluetooth/hci_conn.c                           |   79 +-
 net/bluetooth/hci_core.c                           |   45 +-
 net/bluetooth/hci_drv.c                            |  105 +
 net/bluetooth/hci_event.c                          |   40 +-
 net/bluetooth/hci_sock.c                           |   12 +-
 net/bluetooth/hci_sync.c                           |   63 +-
 net/bluetooth/iso.c                                |   30 +-
 net/bluetooth/mgmt.c                               |    3 +-
 net/bluetooth/mgmt_util.c                          |    2 +-
 net/bridge/br.c                                    |   22 +-
 net/bridge/br_arp_nd_proxy.c                       |    7 +
 net/bridge/br_input.c                              |    3 +-
 net/bridge/br_mdb.c                                |   28 +-
 net/bridge/br_mst.c                                |    4 +-
 net/bridge/br_multicast.c                          |  103 +-
 net/bridge/br_private.h                            |   41 +-
 net/bridge/br_switchdev.c                          |   13 +-
 net/bridge/netfilter/nf_conntrack_bridge.c         |   12 +-
 net/core/datagram.c                                |   90 +-
 net/core/dev.c                                     |  183 +-
 net/core/dev.h                                     |   22 +-
 net/core/dev_api.c                                 |   11 +-
 net/core/dev_ioctl.c                               |    6 +-
 net/core/devmem.c                                  |  132 +-
 net/core/devmem.h                                  |   84 +-
 net/core/dst_cache.c                               |   30 +-
 net/core/fib_rules.c                               |   14 +-
 net/core/lock_debug.c                              |    6 +-
 net/core/lwtunnel.c                                |   15 +-
 net/core/neighbour.c                               |   16 +-
 net/core/net-procfs.c                              |    9 +-
 net/core/net_namespace.c                           |  171 +-
 net/core/netdev-genl-gen.c                         |   13 +
 net/core/netdev-genl-gen.h                         |    1 +
 net/core/netdev-genl.c                             |  157 +-
 net/core/netmem_priv.h                             |   33 +-
 net/core/page_pool.c                               |   89 +-
 net/core/pktgen.c                                  |  103 +-
 net/core/rtnetlink.c                               |   63 +-
 net/core/scm.c                                     |  122 +
 net/core/secure_seq.c                              |   42 -
 net/core/skbuff.c                                  |  214 +-
 net/core/sock.c                                    |  104 +-
 net/core/sock_diag.c                               |    2 -
 net/core/sysctl_net_core.c                         |    6 +-
 net/core/utils.c                                   |    8 +-
 net/core/xdp.c                                     |   72 +-
 net/dccp/Kconfig                                   |   46 -
 net/dccp/Makefile                                  |   30 -
 net/dccp/ackvec.c                                  |  403 ----
 net/dccp/ackvec.h                                  |  136 --
 net/dccp/ccid.c                                    |  219 --
 net/dccp/ccid.h                                    |  262 ---
 net/dccp/ccids/Kconfig                             |   55 -
 net/dccp/ccids/ccid2.c                             |  794 -------
 net/dccp/ccids/ccid2.h                             |  121 -
 net/dccp/ccids/ccid3.c                             |  866 -------
 net/dccp/ccids/ccid3.h                             |  148 --
 net/dccp/ccids/lib/loss_interval.c                 |  184 --
 net/dccp/ccids/lib/loss_interval.h                 |   69 -
 net/dccp/ccids/lib/packet_history.c                |  439 ----
 net/dccp/ccids/lib/packet_history.h                |  142 --
 net/dccp/ccids/lib/tfrc.c                          |   46 -
 net/dccp/ccids/lib/tfrc.h                          |   73 -
 net/dccp/ccids/lib/tfrc_equation.c                 |  702 ------
 net/dccp/dccp.h                                    |  483 ----
 net/dccp/diag.c                                    |   85 -
 net/dccp/feat.c                                    | 1581 -------------
 net/dccp/feat.h                                    |  133 --
 net/dccp/input.c                                   |  739 ------
 net/dccp/ipv4.c                                    | 1101 ---------
 net/dccp/ipv6.c                                    | 1174 ----------
 net/dccp/ipv6.h                                    |   27 -
 net/dccp/minisocks.c                               |  266 ---
 net/dccp/options.c                                 |  609 -----
 net/dccp/output.c                                  |  708 ------
 net/dccp/proto.c                                   | 1293 -----------
 net/dccp/qpolicy.c                                 |  136 --
 net/dccp/sysctl.c                                  |  107 -
 net/dccp/timer.c                                   |  272 ---
 net/dccp/trace.h                                   |   82 -
 net/devlink/dev.c                                  |    2 +-
 net/devlink/health.c                               |   52 +-
 net/devlink/netlink_gen.c                          |   29 +-
 net/devlink/param.c                                |   46 +-
 net/dsa/port.c                                     |   10 +-
 net/dsa/user.c                                     |   41 +-
 net/ethtool/common.c                               |   29 +-
 net/ethtool/ioctl.c                                |   99 +-
 net/ethtool/mm.c                                   |  279 ++-
 net/ethtool/netlink.c                              |  217 +-
 net/ethtool/netlink.h                              |    4 -
 net/ethtool/phy.c                                  |  342 +--
 net/ethtool/tsinfo.c                               |   23 +
 net/hsr/hsr_device.c                               |    5 +
 net/hsr/hsr_main.c                                 |    9 +
 net/hsr/hsr_main.h                                 |    1 +
 net/hsr/hsr_slave.c                                |    2 +
 net/ieee802154/nl-phy.c                            |    6 +-
 net/ipv4/Kconfig                                   |    2 +-
 net/ipv4/af_inet.c                                 |    5 +-
 net/ipv4/devinet.c                                 |    4 +-
 net/ipv4/fib_frontend.c                            |    8 +-
 net/ipv4/fib_semantics.c                           |   50 +-
 net/ipv4/gre_demux.c                               |    2 +-
 net/ipv4/inet_connection_sock.c                    |   23 +-
 net/ipv4/inet_diag.c                               |    4 +-
 net/ipv4/inet_hashtables.c                         |   36 +-
 net/ipv4/inet_timewait_sock.c                      |    4 -
 net/ipv4/ip_gre.c                                  |   27 +-
 net/ipv4/ip_output.c                               |    3 +-
 net/ipv4/ip_tunnel.c                               |   29 +-
 net/ipv4/ip_vti.c                                  |    9 +-
 net/ipv4/ipip.c                                    |    9 +-
 net/ipv4/ipmr.c                                    |    8 +-
 net/ipv4/netfilter/ip_tables.c                     |    2 +-
 net/ipv4/netfilter/nf_dup_ipv4.c                   |    6 +-
 net/ipv4/netfilter/nft_fib_ipv4.c                  |   11 +-
 net/ipv4/nexthop.c                                 |   38 +-
 net/ipv4/proc.c                                    |    1 +
 net/ipv4/route.c                                   |   26 +-
 net/ipv4/tcp.c                                     |   53 +-
 net/ipv4/tcp_fastopen.c                            |    1 +
 net/ipv4/tcp_input.c                               |  110 +-
 net/ipv4/tcp_ipv4.c                                |    7 +-
 net/ipv4/tcp_minisocks.c                           |    9 +-
 net/ipv4/tcp_output.c                              |    5 +-
 net/ipv4/udp.c                                     |  227 +-
 net/ipv4/udp_offload.c                             |  172 +-
 net/ipv4/udp_tunnel_core.c                         |   15 +
 net/ipv6/addrconf.c                                |   12 +-
 net/ipv6/addrlabel.c                               |    8 +-
 net/ipv6/af_inet6.c                                |    2 +-
 net/ipv6/inet6_connection_sock.c                   |    2 -
 net/ipv6/ioam6_iptunnel.c                          |   76 +-
 net/ipv6/ip6_fib.c                                 |  115 +-
 net/ipv6/ip6_gre.c                                 |   22 +-
 net/ipv6/ip6_output.c                              |    5 +-
 net/ipv6/ip6_tunnel.c                              |   24 +-
 net/ipv6/ip6_vti.c                                 |   27 +-
 net/ipv6/netfilter.c                               |   12 +-
 net/ipv6/netfilter/ip6_tables.c                    |    2 +-
 net/ipv6/netfilter/nf_dup_ipv6.c                   |    6 +-
 net/ipv6/netfilter/nft_fib_ipv6.c                  |   17 +-
 net/ipv6/route.c                                   |  424 ++--
 net/ipv6/seg6_hmac.c                               |   13 +-
 net/ipv6/sit.c                                     |   23 +-
 net/ipv6/tcp_ipv6.c                                |    5 +-
 net/ipv6/udp.c                                     |    2 +
 net/ipv6/udp_offload.c                             |    5 +
 net/key/af_key.c                                   |    2 +-
 net/mac80211/cfg.c                                 |   78 +-
 net/mac80211/chan.c                                |    3 +
 net/mac80211/debugfs_sta.c                         |    6 -
 net/mac80211/ibss.c                                |   19 +-
 net/mac80211/ieee80211_i.h                         |   16 +-
 net/mac80211/iface.c                               |   87 +-
 net/mac80211/link.c                                |   90 +-
 net/mac80211/mesh.c                                |   10 +-
 net/mac80211/mesh_hwmp.c                           |    6 +-
 net/mac80211/mesh_pathtbl.c                        |    2 +-
 net/mac80211/mesh_plink.c                          |   10 +-
 net/mac80211/mlme.c                                |    4 +-
 net/mac80211/parse.c                               |    3 -
 net/mac80211/rate.c                                |   12 +-
 net/mac80211/rc80211_minstrel_ht.c                 |   13 +-
 net/mac80211/scan.c                                |   18 +-
 net/mac80211/spectmgmt.c                           |   55 +-
 net/mac80211/sta_info.c                            |   28 -
 net/mac80211/sta_info.h                            |   11 -
 net/mac80211/tdls.c                                |    4 +-
 net/mac80211/tx.c                                  |   35 +-
 net/mac80211/util.c                                |   25 +-
 net/mctp/device.c                                  |    4 +-
 net/mctp/neigh.c                                   |    5 +-
 net/mpls/af_mpls.c                                 |    8 +-
 net/mptcp/mib.c                                    |    1 +
 net/mptcp/mib.h                                    |    1 +
 net/mptcp/pm.c                                     |    5 +-
 net/mptcp/protocol.c                               |   12 +-
 net/mptcp/protocol.h                               |   10 +-
 net/mptcp/sched.c                                  |   35 +-
 net/mptcp/subflow.c                                |   12 +-
 net/ncsi/internal.h                                |   23 +-
 net/ncsi/ncsi-pkt.h                                |   23 +-
 net/ncsi/ncsi-rsp.c                                |   39 +-
 net/netfilter/Kconfig                              |    6 +-
 net/netfilter/core.c                               |    3 -
 net/netfilter/ipvs/Kconfig                         |    2 +-
 net/netfilter/nf_conntrack_core.c                  |   10 +-
 net/netfilter/nf_conntrack_standalone.c            |   88 +-
 net/netfilter/nf_dup_netdev.c                      |   22 +-
 net/netfilter/nf_tables_api.c                      |  428 +++-
 net/netfilter/nf_tables_offload.c                  |   51 +-
 net/netfilter/nf_tables_trace.c                    |   54 +-
 net/netfilter/nfnetlink.c                          |    1 +
 net/netfilter/nft_chain_filter.c                   |   94 +-
 net/netfilter/nft_flow_offload.c                   |    2 +-
 net/netfilter/nft_inner.c                          |   18 +-
 net/netfilter/nft_quota.c                          |   20 +-
 net/netfilter/nft_set_pipapo.c                     |   64 +-
 net/netfilter/nft_tunnel.c                         |    8 +-
 net/netfilter/xt_IDLETIMER.c                       |   12 +-
 net/netfilter/xt_TCPOPTSTRIP.c                     |    4 +-
 net/netfilter/xt_cgroup.c                          |   26 +
 net/netfilter/xt_mark.c                            |    2 +-
 net/netlabel/netlabel_kapi.c                       |    3 +
 net/netlink/policy.c                               |    5 +
 net/openvswitch/Kconfig                            |    2 +-
 net/openvswitch/actions.c                          |   86 +-
 net/openvswitch/datapath.c                         |   33 +-
 net/openvswitch/datapath.h                         |   52 +-
 net/openvswitch/flow.c                             |    2 +-
 net/openvswitch/flow_netlink.c                     |    3 +-
 net/packet/af_packet.c                             |   21 +-
 net/packet/internal.h                              |    1 +
 net/rds/connection.c                               |    6 +-
 net/rds/page.c                                     |   25 +-
 net/rxrpc/Kconfig                                  |   23 +
 net/rxrpc/Makefile                                 |    6 +-
 net/rxrpc/af_rxrpc.c                               |  130 +-
 net/rxrpc/ar-internal.h                            |   83 +-
 net/rxrpc/call_accept.c                            |   34 +-
 net/rxrpc/call_object.c                            |   24 +-
 net/rxrpc/conn_event.c                             |  134 +-
 net/rxrpc/conn_object.c                            |    2 +
 net/rxrpc/insecure.c                               |   13 +-
 net/rxrpc/io_thread.c                              |   12 +-
 net/rxrpc/key.c                                    |  187 ++
 net/rxrpc/oob.c                                    |  379 ++++
 net/rxrpc/output.c                                 |   60 +-
 net/rxrpc/peer_object.c                            |   22 +-
 net/rxrpc/protocol.h                               |   20 +
 net/rxrpc/recvmsg.c                                |  132 +-
 net/rxrpc/rxgk.c                                   | 1371 +++++++++++
 net/rxrpc/rxgk_app.c                               |  286 +++
 net/rxrpc/rxgk_common.h                            |  139 ++
 net/rxrpc/rxgk_kdf.c                               |  288 +++
 net/rxrpc/rxkad.c                                  |  296 ++-
 net/rxrpc/rxperf.c                                 |   78 +-
 net/rxrpc/security.c                               |    3 +
 net/rxrpc/sendmsg.c                                |   25 +-
 net/rxrpc/server_key.c                             |   42 +
 net/rxrpc/txbuf.c                                  |    8 -
 net/sched/Kconfig                                  |   14 +-
 net/sched/Makefile                                 |    1 +
 net/sched/act_api.c                                |   16 +-
 net/sched/act_mirred.c                             |   28 +-
 net/sched/bpf_qdisc.c                              |  475 ++++
 net/sched/sch_api.c                                |   11 +-
 net/sched/sch_frag.c                               |   10 +-
 net/sched/sch_generic.c                            |    7 +-
 net/sched/sch_hfsc.c                               |    9 +-
 net/sctp/Kconfig                                   |    2 +-
 net/sctp/associola.c                               |   18 -
 net/sctp/offload.c                                 |    1 -
 net/sctp/sm_make_chunk.c                           |    8 -
 net/sctp/socket.c                                  |    9 +-
 net/strparser/strparser.c                          |   13 -
 net/tipc/crypto.c                                  |    2 +-
 net/tipc/link.c                                    |    2 +-
 net/tipc/node.c                                    |    2 +-
 net/unix/af_unix.c                                 |  104 +-
 net/vmw_vsock/af_vsock.c                           |   33 +
 net/vmw_vsock/virtio_transport_common.c            |   52 +-
 net/wireless/nl80211.c                             |   42 +-
 net/xdp/xsk_buff_pool.c                            |    6 +-
 net/xfrm/xfrm_device.c                             |   18 +-
 net/xfrm/xfrm_interface_core.c                     |   34 +-
 net/xfrm/xfrm_nat_keepalive.c                      |   30 +-
 net/xfrm/xfrm_policy.c                             |    4 +-
 net/xfrm/xfrm_state.c                              |   46 +-
 net/xfrm/xfrm_user.c                               |   77 +-
 rust/kernel/net/phy.rs                             |    1 +
 samples/bpf/sockex2_kern.c                         |    1 -
 scripts/checkpatch.pl                              |    2 +-
 security/lsm_audit.c                               |   19 -
 security/selinux/hooks.c                           |   41 +-
 security/selinux/include/classmap.h                |    2 -
 security/selinux/nlmsgtab.c                        |    1 -
 security/smack/smack_lsm.c                         |    9 +-
 tools/Makefile                                     |   16 +-
 tools/include/uapi/asm-generic/socket.h            |    2 +
 tools/include/uapi/linux/if_xdp.h                  |    6 +-
 tools/include/uapi/linux/netdev.h                  |    1 +
 tools/lib/bpf/libbpf.h                             |    5 +-
 tools/lib/bpf/netlink.c                            |   20 +-
 tools/net/ynl/Makefile.deps                        |   17 +
 tools/net/ynl/generated/Makefile                   |    7 +-
 tools/net/ynl/lib/ynl-priv.h                       |   19 +-
 tools/net/ynl/lib/ynl.c                            |  160 +-
 tools/net/ynl/lib/ynl.h                            |   18 +
 tools/net/ynl/pyynl/cli.py                         |   15 +-
 tools/net/ynl/pyynl/lib/__init__.py                |    5 +-
 tools/net/ynl/pyynl/lib/ynl.py                     |   39 +-
 tools/net/ynl/pyynl/ynl_gen_c.py                   |  843 +++++--
 tools/net/ynl/pyynl/ynl_gen_rst.py                 |    2 +-
 tools/net/ynl/samples/.gitignore                   |    6 +-
 tools/net/ynl/samples/devlink.c                    |    7 +-
 tools/net/ynl/samples/rt-addr.c                    |   80 +
 tools/net/ynl/samples/rt-link.c                    |  184 ++
 tools/net/ynl/samples/rt-route.c                   |   80 +
 tools/net/ynl/samples/tc.c                         |   80 +
 tools/testing/selftests/Makefile                   |    2 +
 tools/testing/selftests/bpf/config                 |    2 +
 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c |  231 ++
 .../selftests/bpf/prog_tests/sock_iter_batch.c     |  447 +++-
 .../testing/selftests/bpf/progs/bpf_qdisc_common.h |   27 +
 .../bpf/progs/bpf_qdisc_fail__incompl_ops.c        |   41 +
 tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c |  126 ++
 tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c   |  756 +++++++
 .../testing/selftests/bpf/progs/bpf_tracing_net.h  |    1 +
 tools/testing/selftests/bpf/progs/setget_sockopt.c |   11 +
 .../testing/selftests/bpf/progs/sock_iter_batch.c  |   24 +-
 tools/testing/selftests/bpf/progs/xsk_xdp_progs.c  |   50 +
 tools/testing/selftests/bpf/xsk_xdp_common.h       |    1 +
 tools/testing/selftests/bpf/xskxceiver.c           |  118 +-
 tools/testing/selftests/bpf/xskxceiver.h           |    2 +
 tools/testing/selftests/drivers/net/.gitignore     |    2 +-
 tools/testing/selftests/drivers/net/Makefile       |    6 +-
 tools/testing/selftests/drivers/net/hw/Makefile    |    3 +-
 tools/testing/selftests/drivers/net/hw/devmem.py   |   45 +-
 tools/testing/selftests/drivers/net/hw/iou-zcrx.c  |   27 +-
 tools/testing/selftests/drivers/net/hw/iou-zcrx.py |  140 +-
 .../selftests/drivers/net/hw/lib/py/__init__.py    |    1 -
 .../selftests/drivers/net/hw/lib/py/linkconfig.py  |  222 --
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  |  327 ++-
 .../selftests/drivers/net/hw/nic_link_layer.py     |  113 -
 .../selftests/drivers/net/hw/nic_performance.py    |  137 --
 .../selftests/drivers/net/hw/rss_input_xfrm.py     |    5 +
 .../selftests/drivers/net/hw/xsk_reconfig.py       |   60 +
 tools/testing/selftests/drivers/net/lib/py/env.py  |    2 +-
 tools/testing/selftests/drivers/net/lib/py/load.py |   20 +-
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |    1 -
 tools/testing/selftests/drivers/net/napi_id.py     |   23 +
 .../testing/selftests/drivers/net/napi_id_helper.c |   83 +
 .../selftests/drivers/net/netdevsim/peer.sh        |    2 +-
 tools/testing/selftests/drivers/net/ping.py        |   16 +
 tools/testing/selftests/drivers/net/queues.py      |    4 +-
 tools/testing/selftests/drivers/net/team/Makefile  |    2 +-
 tools/testing/selftests/drivers/net/team/config    |    1 +
 .../selftests/drivers/net/team/propagation.sh      |   80 +
 tools/testing/selftests/nci/nci_dev.c              |    2 +-
 tools/testing/selftests/net/Makefile               |    2 +-
 tools/testing/selftests/net/af_unix/scm_rights.c   |   80 +-
 tools/testing/selftests/net/bareudp.sh             |   49 +-
 tools/testing/selftests/net/busy_poll_test.sh      |    2 +-
 tools/testing/selftests/net/can/.gitignore         |    2 +
 tools/testing/selftests/net/can/Makefile           |   11 +
 tools/testing/selftests/net/can/test_raw_filter.c  |  405 ++++
 tools/testing/selftests/net/can/test_raw_filter.sh |   45 +
 tools/testing/selftests/net/config                 |    1 -
 tools/testing/selftests/net/fib_rule_tests.sh      |    3 -
 tools/testing/selftests/net/fib_tests.sh           |  123 +-
 .../selftests/net/forwarding/bridge_igmp.sh        |   80 +-
 .../testing/selftests/net/forwarding/bridge_mld.sh |   81 +-
 tools/testing/selftests/net/forwarding/config      |    1 +
 tools/testing/selftests/net/icmp_redirect.sh       |    2 -
 .../selftests/net/ipv6_route_update_soft_lockup.sh |    1 -
 tools/testing/selftests/net/lib.sh                 |   47 +
 tools/testing/selftests/net/lib/.gitignore         |    1 +
 tools/testing/selftests/net/lib/Makefile           |    1 +
 tools/testing/selftests/net/lib/ksft.h             |   56 +
 tools/testing/selftests/net/lib/py/ksft.py         |   24 +-
 tools/testing/selftests/net/lib/py/ynl.py          |    4 +-
 .../{drivers/net => net/lib}/xdp_helper.c          |   82 +-
 tools/testing/selftests/net/mptcp/Makefile         |    2 +-
 tools/testing/selftests/net/mptcp/diag.sh          |   32 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |   21 +-
 tools/testing/selftests/net/mptcp/mptcp_diag.c     |  231 +-
 tools/testing/selftests/net/mptcp/mptcp_inq.c      |   16 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   26 +-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   10 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c  |   16 +-
 tools/testing/selftests/net/net_helper.sh          |   25 -
 tools/testing/selftests/net/netfilter/Makefile     |    2 +
 .../selftests/net/netfilter/br_netfilter.sh        |    3 -
 .../selftests/net/netfilter/bridge_brouter.sh      |    2 -
 tools/testing/selftests/net/netfilter/config       |    1 +
 .../selftests/net/netfilter/conntrack_resize.sh    |  427 ++++
 .../selftests/net/netfilter/conntrack_vrf.sh       |   37 -
 tools/testing/selftests/net/netfilter/ipvs.sh      |    6 -
 .../selftests/net/netfilter/nft_concat_range.sh    |  165 +-
 tools/testing/selftests/net/netfilter/nft_fib.sh   |  635 +++++-
 .../net/netfilter/nft_interface_stress.sh          |  154 ++
 .../selftests/net/netfilter/nft_nat_zones.sh       |    2 -
 tools/testing/selftests/net/netfilter/nft_queue.sh |   38 +-
 tools/testing/selftests/net/netfilter/rpath.sh     |   18 +-
 tools/testing/selftests/net/ovpn/.gitignore        |    2 +
 tools/testing/selftests/net/ovpn/Makefile          |   32 +
 tools/testing/selftests/net/ovpn/common.sh         |  108 +
 tools/testing/selftests/net/ovpn/config            |   10 +
 tools/testing/selftests/net/ovpn/data64.key        |    5 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2383 ++++++++++++++++++++
 tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
 .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
 .../selftests/net/ovpn/test-close-socket-tcp.sh    |    9 +
 .../selftests/net/ovpn/test-close-socket.sh        |   45 +
 tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
 tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
 tools/testing/selftests/net/ovpn/test.sh           |  117 +
 tools/testing/selftests/net/ovpn/udp_peers.txt     |    6 +
 tools/testing/selftests/net/pmtu.sh                |    1 -
 tools/testing/selftests/net/reuseport_addr_any.c   |   36 +-
 .../selftests/net/srv6_end_dt46_l3vpn_test.sh      |    5 -
 .../selftests/net/srv6_end_dt4_l3vpn_test.sh       |    5 -
 .../testing/selftests/net/srv6_end_flavors_test.sh |    4 +-
 .../selftests/net/srv6_end_next_csid_l3vpn_test.sh |   77 +-
 .../net/srv6_end_x_next_csid_l3vpn_test.sh         |   83 +-
 .../selftests/net/srv6_hencap_red_l3vpn_test.sh    |   74 +-
 .../selftests/net/srv6_hl2encap_red_l2vpn_test.sh  |   83 +-
 .../selftests/net/test_bridge_neigh_suppress.sh    |  125 +
 tools/testing/selftests/net/udpgro.sh              |    2 +-
 tools/testing/selftests/net/udpgro_bench.sh        |    2 +-
 tools/testing/selftests/net/udpgro_frglist.sh      |    2 +-
 tools/testing/selftests/net/udpgro_fwd.sh          |    2 +-
 .../tc-testing/tc-tests/infra/qdiscs.json          |   35 +
 tools/testing/selftests/tc-testing/tdc.sh          |    4 +
 tools/testing/selftests/wireguard/netns.sh         |   29 +
 tools/testing/selftests/wireguard/qemu/Makefile    |    3 +-
 .../testing/selftests/wireguard/qemu/debug.config  |    1 -
 tools/testing/vsock/timeout.c                      |   18 +
 tools/testing/vsock/timeout.h                      |    1 +
 tools/testing/vsock/util.c                         |   38 +
 tools/testing/vsock/util.h                         |    2 +
 tools/testing/vsock/vsock_test.c                   |  129 +-
 1735 files changed, 83145 insertions(+), 38939 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
 create mode 100644 Documentation/devicetree/bindings/net/network-class.yaml
 create mode 100644 Documentation/devicetree/bindings/net/renesas,r9a09g057-gbeth.yaml
 create mode 100644 Documentation/devicetree/bindings/net/via,vt8500-rhine.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/via-rhine.txt
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
 create mode 100644 Documentation/devicetree/bindings/net/wireless/wireless-controller.yaml
 create mode 100644 Documentation/netlink/specs/ovpn.yaml
 rename Documentation/netlink/specs/{rt_addr.yaml => rt-addr.yaml} (89%)
 rename Documentation/netlink/specs/{rt_link.yaml => rt-link.yaml} (93%)
 rename Documentation/netlink/specs/{rt_neigh.yaml => rt-neigh.yaml} (97%)
 rename Documentation/netlink/specs/{rt_route.yaml => rt-route.yaml} (93%)
 rename Documentation/netlink/specs/{rt_rule.yaml => rt-rule.yaml} (97%)
 delete mode 100644 Documentation/networking/dccp.rst
 create mode 100644 Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst
 create mode 100644 Documentation/networking/device_drivers/ethernet/ti/icssg_prueth.rst
 create mode 100644 Documentation/networking/devlink/ixgbe.rst
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-smn.h
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_debugfs.h
 create mode 100644 drivers/net/ethernet/freescale/enetc/ntmp.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/ntmp_private.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/Kconfig
 create mode 100644 drivers/net/ethernet/huawei/hinic3/Makefile
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_common.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_common.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_lld.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_main.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_wq.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_wq.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/devlink.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/region.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.h
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.h
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
 create mode 100644 drivers/net/mdio/mdio-realtek-rtl9300.c
 create mode 100644 drivers/net/ovpn/Makefile
 create mode 100644 drivers/net/ovpn/bind.c
 create mode 100644 drivers/net/ovpn/bind.h
 create mode 100644 drivers/net/ovpn/crypto.c
 create mode 100644 drivers/net/ovpn/crypto.h
 create mode 100644 drivers/net/ovpn/crypto_aead.c
 create mode 100644 drivers/net/ovpn/crypto_aead.h
 create mode 100644 drivers/net/ovpn/io.c
 create mode 100644 drivers/net/ovpn/io.h
 create mode 100644 drivers/net/ovpn/main.c
 create mode 100644 drivers/net/ovpn/main.h
 create mode 100644 drivers/net/ovpn/netlink-gen.c
 create mode 100644 drivers/net/ovpn/netlink-gen.h
 create mode 100644 drivers/net/ovpn/netlink.c
 create mode 100644 drivers/net/ovpn/netlink.h
 create mode 100644 drivers/net/ovpn/ovpnpriv.h
 create mode 100644 drivers/net/ovpn/peer.c
 create mode 100644 drivers/net/ovpn/peer.h
 create mode 100644 drivers/net/ovpn/pktid.c
 create mode 100644 drivers/net/ovpn/pktid.h
 create mode 100644 drivers/net/ovpn/proto.h
 create mode 100644 drivers/net/ovpn/skb.h
 create mode 100644 drivers/net/ovpn/socket.c
 create mode 100644 drivers/net/ovpn/socket.h
 create mode 100644 drivers/net/ovpn/stats.c
 create mode 100644 drivers/net/ovpn/stats.h
 create mode 100644 drivers/net/ovpn/tcp.c
 create mode 100644 drivers/net/ovpn/tcp.h
 create mode 100644 drivers/net/ovpn/udp.c
 create mode 100644 drivers/net/ovpn/udp.h
 create mode 100644 drivers/net/phy/as21xxx.c
 create mode 100644 drivers/net/phy/mdio_bus_provider.c
 create mode 100644 drivers/net/phy/mediatek/mtk-2p5ge.c
 create mode 100644 drivers/net/phy/mxl-86110.c
 create mode 100644 drivers/net/wireless/ath/ath12k/ahb.c
 create mode 100644 drivers/net/wireless/ath/ath12k/ahb.h
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c
 rename drivers/net/wireless/intel/iwlwifi/{iwl-context-info-gen3.h => iwl-context-info-v2.h} (86%)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/emlsr_with_bt.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/hcmd.c
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ctxt-info-gen3.c => ctxt-info-v2.c} (75%)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/testmode.c
 create mode 100644 fs/afs/cm_security.c
 create mode 100644 include/linux/fsl/ntmp.h
 delete mode 100644 include/linux/net/intel/iidc.h
 create mode 100644 include/linux/net/intel/iidc_rdma.h
 create mode 100644 include/linux/net/intel/iidc_rdma_ice.h
 delete mode 100644 include/linux/tfrc.h
 create mode 100644 include/net/bluetooth/hci_drv.h
 delete mode 100644 include/net/p8022.h
 create mode 100644 include/uapi/linux/ovpn.h
 delete mode 100644 net/802/p8022.c
 create mode 100644 net/bluetooth/hci_drv.c
 delete mode 100644 net/dccp/Kconfig
 delete mode 100644 net/dccp/Makefile
 delete mode 100644 net/dccp/ackvec.c
 delete mode 100644 net/dccp/ackvec.h
 delete mode 100644 net/dccp/ccid.c
 delete mode 100644 net/dccp/ccid.h
 delete mode 100644 net/dccp/ccids/Kconfig
 delete mode 100644 net/dccp/ccids/ccid2.c
 delete mode 100644 net/dccp/ccids/ccid2.h
 delete mode 100644 net/dccp/ccids/ccid3.c
 delete mode 100644 net/dccp/ccids/ccid3.h
 delete mode 100644 net/dccp/ccids/lib/loss_interval.c
 delete mode 100644 net/dccp/ccids/lib/loss_interval.h
 delete mode 100644 net/dccp/ccids/lib/packet_history.c
 delete mode 100644 net/dccp/ccids/lib/packet_history.h
 delete mode 100644 net/dccp/ccids/lib/tfrc.c
 delete mode 100644 net/dccp/ccids/lib/tfrc.h
 delete mode 100644 net/dccp/ccids/lib/tfrc_equation.c
 delete mode 100644 net/dccp/dccp.h
 delete mode 100644 net/dccp/diag.c
 delete mode 100644 net/dccp/feat.c
 delete mode 100644 net/dccp/feat.h
 delete mode 100644 net/dccp/input.c
 delete mode 100644 net/dccp/ipv4.c
 delete mode 100644 net/dccp/ipv6.c
 delete mode 100644 net/dccp/ipv6.h
 delete mode 100644 net/dccp/minisocks.c
 delete mode 100644 net/dccp/options.c
 delete mode 100644 net/dccp/output.c
 delete mode 100644 net/dccp/proto.c
 delete mode 100644 net/dccp/qpolicy.c
 delete mode 100644 net/dccp/sysctl.c
 delete mode 100644 net/dccp/timer.c
 delete mode 100644 net/dccp/trace.h
 create mode 100644 net/rxrpc/oob.c
 create mode 100644 net/rxrpc/rxgk.c
 create mode 100644 net/rxrpc/rxgk_app.c
 create mode 100644 net/rxrpc/rxgk_common.h
 create mode 100644 net/rxrpc/rxgk_kdf.c
 create mode 100644 net/sched/bpf_qdisc.c
 create mode 100644 tools/net/ynl/samples/rt-addr.c
 create mode 100644 tools/net/ynl/samples/rt-link.c
 create mode 100644 tools/net/ynl/samples/rt-route.c
 create mode 100644 tools/net/ynl/samples/tc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__incompl_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
 delete mode 100644 tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py
 delete mode 100644 tools/testing/selftests/drivers/net/hw/nic_link_layer.py
 delete mode 100644 tools/testing/selftests/drivers/net/hw/nic_performance.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_reconfig.py
 create mode 100755 tools/testing/selftests/drivers/net/napi_id.py
 create mode 100644 tools/testing/selftests/drivers/net/napi_id_helper.c
 create mode 100755 tools/testing/selftests/drivers/net/team/propagation.sh
 create mode 100644 tools/testing/selftests/net/can/.gitignore
 create mode 100644 tools/testing/selftests/net/can/Makefile
 create mode 100644 tools/testing/selftests/net/can/test_raw_filter.c
 create mode 100755 tools/testing/selftests/net/can/test_raw_filter.sh
 create mode 100644 tools/testing/selftests/net/lib/ksft.h
 rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (69%)
 delete mode 100644 tools/testing/selftests/net/net_helper.sh
 create mode 100755 tools/testing/selftests/net/netfilter/conntrack_resize.sh
 create mode 100755 tools/testing/selftests/net/netfilter/nft_interface_stress.sh
 create mode 100644 tools/testing/selftests/net/ovpn/.gitignore
 create mode 100644 tools/testing/selftests/net/ovpn/Makefile
 create mode 100644 tools/testing/selftests/net/ovpn/common.sh
 create mode 100644 tools/testing/selftests/net/ovpn/config
 create mode 100644 tools/testing/selftests/net/ovpn/data64.key
 create mode 100644 tools/testing/selftests/net/ovpn/ovpn-cli.c
 create mode 100644 tools/testing/selftests/net/ovpn/tcp_peers.txt
 create mode 100755 tools/testing/selftests/net/ovpn/test-chachapoly.sh
 create mode 100755 tools/testing/selftests/net/ovpn/test-close-socket-tcp.sh
 create mode 100755 tools/testing/selftests/net/ovpn/test-close-socket.sh
 create mode 100755 tools/testing/selftests/net/ovpn/test-float.sh
 create mode 100755 tools/testing/selftests/net/ovpn/test-tcp.sh
 create mode 100755 tools/testing/selftests/net/ovpn/test.sh
 create mode 100644 tools/testing/selftests/net/ovpn/udp_peers.txt


