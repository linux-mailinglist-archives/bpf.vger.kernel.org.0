Return-Path: <bpf+bounces-70079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B0EBB06FC
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 15:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146901940319
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 13:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165492EC564;
	Wed,  1 Oct 2025 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEY9XrZI"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE262EBDE6
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324359; cv=none; b=fsZdWaAGRlypNHrb9zA05AXLOHKDhfJvKPknMVZUPMc2oYiXZ3/Q+G5aCYLKrC1dp5dCoiRZkK9iKjbc3OhYPXdb6sJJ8CIQzq9ol2LdTdmUp6u4I7kcbS0CHddrw18eED9IdMsdxgZjiHr0t761IYv0dvlarvSrehZWrZDLQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324359; c=relaxed/simple;
	bh=SXPOoJ+Znebz1EBM++xXjOGPp7jVwDce+TQtMOXeJLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FjzUMndAoggbn5coDi8lB/Oc7zMuIyeTgvAENQ5yB72SVKqd1w/lly6Y6zDgZqVvCYmb9fkx8GgZSgYg8en94fLBn4x1I9sw2DbAfte2WaU7CFoTokhnexUZcOjWfpfa7Q1zZn5P5YuaJwgmYfh9GIxelXtOWvd916ZFXSICECU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEY9XrZI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759324350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z1NnRpZKg4uAstBgGo3quqww9Z3ulowYV9P98VWpLFU=;
	b=YEY9XrZIU9t7HLK2AoOZQrUOQZHaeeZY0Dq5nBME2fWBxnostvRjTTavLNn8m57BAcXR42
	yCNoYhKlWjTcv0IJgpIEnq+i1HoY2kVMpNi9CW22LxKOt7vlIjres96W85YlTty8dw5bXv
	2ykBikaV57LBRQPzyELZDFcnJ7Ow0eE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-EpqQytRPP4KAet_j2J96bw-1; Wed,
 01 Oct 2025 09:12:23 -0400
X-MC-Unique: EpqQytRPP4KAet_j2J96bw-1
X-Mimecast-MFC-AGG-ID: EpqQytRPP4KAet_j2J96bw_1759324342
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A6BC1800370;
	Wed,  1 Oct 2025 13:12:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.192])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69F1730003BB;
	Wed,  1 Oct 2025 13:12:17 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [GIT PULL] Networking for v6.18
Date: Wed,  1 Oct 2025 15:11:56 +0200
Message-ID: <20251001131156.27805-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Linus!

We have a bunch of trivial/adjacent changes conflicts to be solved
accepting the chunks for both trees:

Vs your tree in arch/s390/configs/debug_defconfig and arch/s390/configs/defconfig.

Vs the v4l-dvb tree in .mailmap:

Vs the rdma tree in drivers/net/ethernet/broadcom/bnxt/bnxt.c and in
Documentation/networking/device_drivers/ethernet/index.rst.

Vs the regulator tree in MAINTAINERS.

Vs the bpf-next tree in include/net/xdp.h

Also a couple of a bit less trivial conflicts:

Vs the spacemit tree in arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
and in arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts, resolutios:
  https://lore.kernel.org/linux-next/aMqby4Cz8hn6lZgv@sirena.org.uk/

Vs the tip tree in drivers/net/ethernet/amd/xgbe/xgbe-ptp.c, resolution:
  https://lore.kernel.org/linux-next/20250722114246.2c683a44@canb.auug.org.au/

Finally a duplicate commit (different hash, same contents) with the vhost
tree:
  4e9510f162188 ("ptr_ring: drop duplicated tail zeroing code")
  4a37c69fc60bf ("ptr_ring: drop duplicated tail zeroing code")
both touching include/linux/ptr_ring.h the same way.

There is a very recent build failure for arm64 with oldish compiler currently
under investigation, I hope it should not block this PR.

The following changes since commit 4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4:

  Merge tag 'net-6.17-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-09-25 08:23:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.18

for you to fetch changes up to f1455695d2d99894b65db233877acac9a0e120b9:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-10-01 10:14:49 +0200)

----------------------------------------------------------------
Networking changes for 6.18.

Core & protocols
----------------

 - Improve drop account scalability on NUMA hosts for RAW and UDP sockets
   and the backlog, almost doubling the Pps capacity under DoS.

 - Optimize the UDP RX performance under stress, reducing contention,
   revisiting the binary layout of the involved data structs and
   implementing NUMA-aware locking. This improves UDP RX performance by
   an additional 50%, even more under extreme conditions.

 - Add support for PSP encryption of TCP connections; this mechanism has
   some similarities with IPsec and TLS, but offers superior HW offloads
   capabilities.

 - Ongoing work to support Accurate ECN for TCP. AccECN allows more than
   one congestion notification signal per RTT and is a building block for
   Low Latency, Low Loss, and Scalable Throughput (L4S).

 - Reorganize the TCP socket binary layout for data locality, reducing
   the number of touched cachelines in the fastpath.

 - Refactor skb deferral free to better scale on large multi-NUMA hosts,
   this improves TCP and UDP RX performances significantly on such HW.

 - Increase the default socket memory buffer limits from 256K to 4M to
   better fit modern link speeds.

 - Improve handling of setups with a large number of nexthop, making dump
   operating scaling linearly and avoiding unneeded synchronize_rcu() on
   delete.

 - Improve bridge handling of VLAN FDB, storing a single entry per bridge
   instead of one entry per port; this makes the dump order of magnitude
   faster on large switches.

 - Restore IP ID correctly for encapsulated packets at GSO segmentation
   time, allowing GRO to merge packets in more scenarios.

 - Improve netfilter matching performance on large sets.

 - Improve MPTCP receive path performance by leveraging recently
   introduced core infrastructure (skb deferral free) and adopting recent
   TCP autotuning changes.

 - Allow bridges to redirect to a backup port when the bridge port is
   administratively down.

 - Introduce MPTCP 'laminar' endpoint that con be used only once per
   connection and simplify common MPTCP setups.

 - Add RCU safety to dst->dev, closing a lot of possible races.

 - A significant crypto library API for SCTP, MPTCP and IPv6 SR, reducing
   code duplication.

 - Supports pulling data from an skb frag into the linear area of an XDP
   buffer.

Things we sprinkled into general kernel code
--------------------------------------------

 - Generate netlink documentation from YAML using an integrated
   YAML parser.

Driver API
----------

 - Support using IPv6 Flow Label in Rx hash computation and RSS queue
   selection.

 - Introduce API for fetching the DMA device for a given queue, allowing
   TCP zerocopy RX on more H/W setups.

 - Make XDP helpers compatible with unreadable memory, allowing more
   easily building DevMem-enabled drivers with a unified XDP/skbs
   datapath.

 - Add a new dedicated ethtool callback enabling drivers to provide the
   number of RX rings directly, improving efficiency and clarity in RX
   ring queries and RSS configuration.

 - Introduce a burst period for the health reporter, allowing better
   handling of multiple errors due to the same root cause.

 - Support for DPLL phase offset exponential moving average, controlling
   the average smoothing factor.

Device drivers
--------------

 - Add a new Huawei driver for 3rd gen NIC (hinic3).

 - Add a new SpacemiT driver for K1 ethernet MAC.

 - Add a generic abstraction for shared memory communication devices
   (dibps)

 - Ethernet high-speed NICs:
   - nVidia/Mellanox:
     - Use multiple per-queue doorbell, to avoid MMIO contention issues
     - support adjacent functions, allowing them to delegate their
       SR-IOV VFs to sibling PFs
     - support RSS for IPSec offload
     - support exposing raw cycle counters in PTP and mlx5
     - support for disabling host PFs.
   - Intel (100G, ice, idpf):
     - ice: support for SRIOV VFs over an Active-Active link aggregate
     - ice: support for firmware logging via debugfs
     - ice: support for Earliest TxTime First (ETF) hardware offload
     - idpf: support basic XDP functionalities and XSk
   - Broadcom (bnxt):
     - support Hyper-V VF ID
     - dynamic SRIOV resource allocations for RoCE
   - Meta (fbnic):
     - support queue API, zero-copy Rx and Tx
     - support basic XDP functionalities
     - devlink health support for FW crashes and OTP mem corruptions
     - expand hardware stats coverage to FEC, PHY, and Pause
   - Wangxun:
     - support ethtool coalesce options
     - support for multiple RSS contexts

 - Ethernet virtual:
   - Macsec:
     - replace custom netlink attribute checks with policy-level checks
   - Bonding:
     - support aggregator selection based on port priority
   - Microsoft vNIC:
     - use page pool fragments for RX buffers instead of full pages to
       improve memory efficiency

 - Ethernet NICs consumer, and embedded:
   - Qualcomm: support Ethernet function for IPQ9574 SoC
   - Airoha: implement wlan offloading via NPU
   - Freescale
     - enetc: add NETC timer PTP driver and add PTP support
     - fec: enable the Jumbo frame support for i.MX8QM
   - Renesas (R-Car S4): support HW offloading for layer 2 switching
     - support for RZ/{T2H, N2H} SoCs
   - Cadence (macb): support TAPRIO traffic scheduling
   - TI:
     - support for Gigabit ICSS ethernet SoC (icssm-prueth)
   - Synopsys (stmmac): a lot of cleanups

 - Ethernet PHYs:
   - Support 10g-qxgmi phy-mode for AQR412C, Felix DSA and Lynx PCS
     driver
   - Support bcm63268 GPHY power control
   - Support for Micrel lan8842 PHY and PTP
   - Support for Aquantia AQR412 and AQR115

 - CAN:
   - a large CAN-XL preparation work
   - reorganize raw_sock and uniqframe struct to minimize memory usage
   - rcar_canfd: update the CAN-FD handling

 - WiFi:
   - extended Neighbor Awareness Networking (NAN) support
   - S1G channel representation cleanup
   - improve S1G support

 - WiFi drivers:
   - Intel (iwlwifi):
     - major refactor and cleanup
   - Broadcom (brcm80211):
     - support for AP isolation
   - RealTek (rtw88/89) rtw88/89:
     - preparation work for RTL8922DE support
   - MediaTek (mt76):
     - HW restart improvements
     - MLO support
   - Qualcomm/Atheros (ath10k_
     - GTK rekey fixes

 - Bluetooth drivers:
   - btusb: support for several new IDs for MT7925
   - btintel: support for BlazarIW core
   - btintel_pcie: support for _suspend() / _resume()
   - btintel_pcie: support for Scorpious, Panther Lake-H484 IDs

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Abdun Nihaal (1):
      wifi: mt76: fix potential memory leak in mt76_wmac_probe()

Adithya Jayachandran (2):
      net/mlx5: E-Switch, Add support for adjacent functions vports discovery
      net/mlx5: E-switch, Set representor attributes for adjacent VFs

Aditya Kumar Singh (4):
      wifi: cfg80211: fix return value in cfg80211_get_radio_idx_by_chan()
      wifi: mac80211: simplify return value handling of cfg80211_get_radio_idx_by_chan()
      wifi: mac80211: consider links for validating SCAN_FLAG_AP in scan request during MLO
      wifi: mac80211: fix Rx packet handling when pubsta information is not available

Akhilesh Patil (1):
      wifi: rtw89: 8852bt: Use standard helper for string choice

Akiva Goldberger (2):
      net/mlx5: Add uar access and odp page fault counters
      net/mlx5: Expose uar access and odp page fault counters

Alasdair McWilliam (1):
      rtnetlink: add needed_{head,tail}room attributes

Aleksander Jan Bajkowski (1):
      net: phy: realtek: support for TRIGGER_NETDEV_LINK on RTL8211E and RTL8211F

Aleksandr Loktionov (2):
      iavf: fix proper type for error code in iavf_resume()
      ixgbevf: fix proper type for error code in ixgbevf_resume()

Aleksej Smirnov (1):
      wifi: rtl8xxxu: Remove TL-WN722N V2 (0x2357: 0x010c) from untested devices

Alessandro Ratti (1):
      selftests: rtnetlink: skip tests if tools or feats are missing

Alessandro Zanni (1):
      selftest: net: Fix error message if empty variable

Alex Tran (1):
      selftests/net/socket.c: removed warnings from unused returns

Alexander Duyck (4):
      fbnic: Move promisc_sync out of netdev code and into RPC path
      fbnic: Pass fbnic_dev instead of netdev to __fbnic_set/clear_rx_mode
      fbnic: Add logic to repopulate RPC TCAM if BMC enables channel
      fbnic: Push local unicast MAC addresses to FW to populate TCAMs

Alexander Lobakin (13):
      xdp, libeth: make the xdp_init_buff() micro-optimization generic
      idpf: fix Rx descriptor ready check barrier in splitq
      idpf: use a saner limit for default number of queues to allocate
      idpf: link NAPIs to queues
      idpf: add support for nointerrupt queues
      idpf: use generic functions to build xdp_buff and skb
      idpf: add support for XDP on Rx
      idpf: add support for .ndo_xdp_xmit()
      idpf: add XDP RSS hash hint
      libie: fix linking with libie_{adminq,fwlog} when CONFIG_LIBIE=n
      idpf: implement XSk xmit
      idpf: implement Rx path for AF_XDP
      idpf: enable XSk features and ndo_xsk_wakeup

Alexander Wilhelm (1):
      wifi: ath12k: enforce CPU endian format for all QMI data

Alexandra Winter (12):
      net/smc: Improve log message for devices w/o pnetid
      net/smc: Remove error handling of unregister_dmb()
      net/smc: Decouple sf and attached send_buf in smc_loopback
      dibs: Create drivers/dibs
      dibs: Register smc as dibs_client
      dibs: Register ism as dibs device
      dibs: Define dibs loopback
      dibs: Define dibs_client_ops and dibs_dev_ops
      dibs: Local gid for dibs devices
      dibs: Move vlan support to dibs_dev_ops
      dibs: Move query_remote_gid() to dibs_dev_ops
      dibs: Move data path to dibs layer

Alok Tiwari (13):
      net: stmmac: rk: remove incorrect _DLY_DISABLE bit definition
      net: mctp: fix typo in comment
      ixgbe: fix typo in function comment for ixgbe_get_num_per_func()
      ipv4: udp: fix typos in comments
      ipv6: udp: fix typos in comments
      udp_tunnel: use netdev_warn() instead of netdev_WARN()
      ionic: use int type for err in ionic_get_module_eeprom_by_page
      net/mlx5: fix typo in pci_irq.c comment
      bonding: fix standard reference typo in ad_select description
      selftests: rtnetlink: correct error message in rtnetlink.sh fou test
      ixgbe: fix typos and docstring inconsistencies
      idpf: fix mismatched free function for dma_alloc_coherent
      net: rtnetlink: fix typo in rtnl_unregister_all() comment

Amery Hung (1):
      selftests: drv-net: Reload pkt pointer after calling filter_udphdr

Anantha Prabhu (1):
      bnxt_en: Support for RoCE resources dynamically shared within VFs.

Andre Carvalho (1):
      selftests: netconsole: Validate interface selection by MAC address

Andre Przywara (1):
      net: stmmac: sun8i: drop unneeded default syscon value

Andrei Otcheretianski (4):
      wifi: nl80211: Add more configuration options for NAN commands
      wifi: nl80211: Add NAN Discovery Window (DW) notification
      wifi: cfg80211: Add cluster joined notification APIs
      wifi: nl80211: Add more NAN capabilities

Andres Urian Florez (1):
      selftest:net: fixed spelling mistakes

Antoine Tenart (3):
      net: ipv4: make udp_v4_early_demux explicitly return drop reason
      net: ipv4: simplify drop reason handling in ip_rcv_finish_core
      net: ipv4: convert ip_rcv_options to drop reasons

Arend van Spriel (3):
      wifi: nl80211: allow drivers to support subset of NL80211_CMD_SET_BSS
      wifi: drivers: indicate support for attributes in NL80211_CMD_SET_BSS
      wifi: nl80211: strict checking attributes for NL80211_CMD_SET_BSS

Arkadiusz Bokowy (1):
      Bluetooth: btusb: Check for unexpected bytes when defragmenting HCI frames

Arnd Bergmann (1):
      wifi: ath10k: remove gpio number assignment

Arulanbu Balusamy (1):
      wifi: ath12k: Add support to handle reason inactivity STA kickout event for QCN9274/IPQ5332

Asbjørn Sloth Tønnesen (14):
      netlink: specs: fou: change local-v6/peer-v6 check
      tools: ynl-gen: use macro for binary min-len check
      genetlink: fix typo in comment
      tools: ynl-gen: allow overriding name-prefix for constants
      tools: ynl-gen: generate nested array policies
      tools: ynl-gen: add sub-type check
      tools: ynl-gen: refactor local vars for .attr_put() callers
      tools: ynl-gen: avoid repetitive variables definitions
      tools: ynl-gen: validate nested arrays
      tools: ynl-gen: rename TypeArrayNest to TypeIndexedArray
      tools: ynl: move nest packing to a helper function
      tools: ynl: encode indexed-arrays
      tools: ynl: decode hex input
      tools: ynl: add ipv4-or-v6 display hint

Bagas Sanjaya (4):
      Documentation: rxrpc: Demote three sections
      net: dns_resolver: Use reST bullet list for features list
      net: dns_resolver: Move dns_query() explanation out of code block
      net: dns_resolver: Fix request-key cross-reference

Baochen Qiang (6):
      wifi: ath12k: initialize eirp_power before use
      wifi: ath12k: fix overflow warning on num_pwr_levels
      wifi: ath11k: downgrade log level for CE buffer enqueue failure
      wifi: ath12k: fix wrong logging ID used for CE
      wifi: ath12k: downgrade log level for CE buffer enqueue failure
      wifi: ath10k: avoid unnecessary wait for service ready message

Bartosz Golaszewski (1):
      MAINTAINERS: add a sub-entry for the Qualcomm bluetooth driver

Bastien Curutchet (1):
      net: dsa: microchip: Set SPI as bus interface during reset for KSZ8463

Bastien Curutchet (Schneider Electric) (2):
      dt-bindings: net: dsa: microchip: Group if clause under allOf tag
      dt-bindings: net: dsa: microchip: Add strap description to set SPI mode

Benjamin Lin (1):
      wifi: mt76: mt7996: Temporarily disable EPCS

Bhargava Marreddy (10):
      bng_en: make bnge_alloc_ring() self-unwind on failure
      bng_en: Add initial support for RX and TX rings
      bng_en: Add initial support for CP and NQ rings
      bng_en: Introduce VNIC
      bng_en: Initialise core resources
      bng_en: Allocate packet buffers
      bng_en: Allocate stat contexts
      bng_en: Register rings with the firmware
      bng_en: Register default VNIC
      bng_en: Configure default VNIC

Biju Das (4):
      can: rcar_canfd: Update bit rate constants for RZ/G3E and R-Car Gen4
      can: rcar_canfd: Update RCANFD_CFG_* macros
      can: rcar_canfd: Simplify nominal bit rate config
      can: rcar_canfd: Simplify data bit rate config

Bitterblue Smith (4):
      wifi: rtw88: Lock rtwdev->mutex before setting the LED
      wifi: rtlwifi: rtl8192cu: Don't claim USB ID 07b8:8188
      wifi: rtl8xxxu: Don't claim USB ID 07b8:8188
      wifi: rtw88: Use led->brightness_set_blocking for PCI too

Bo Sun (2):
      octeontx2-vf: fix bitmap leak
      octeontx2-pf: fix bitmap leak

Brahmajit Das (1):
      net: intel: fm10k: Fix parameter idx set but not used

Breno Leitao (15):
      netconsole: move netpoll_parse_ip_addr() earlier for reuse
      netconsole: add support for strings with new line in netpoll_parse_ip_addr
      netconsole: use netpoll_parse_ip_addr in local_ip_store
      netconsole: use netpoll_parse_ip_addr in local_ip_store
      net: selftests: clean up tools/testing/selftests/net/lib/py/utils.py
      net: ethtool: pass the num of RX rings directly to ethtool_copy_validate_indir
      net: ethtool: add support for ETHTOOL_GRXRINGS ioctl
      net: ethtool: remove the duplicated handling from ethtool_get_rxrings
      net: ethtool: add get_rx_ring_count callback to optimize RX ring queries
      net: ethtool: update set_rxfh to use ethtool_get_rx_ring_count helper
      net: ethtool: update set_rxfh_indir to use ethtool_get_rx_ring_count helper
      net: ethtool: use the new helper in rss_set_prep_indir()
      net: virtio_net: add get_rxrings ethtool callback for RX ring queries
      net: netpoll: remove unused netpoll pointer from netpoll_info
      net: netpoll: use synchronize_net() instead of synchronize_rcu()

Brett A C Sheffield (1):
      selftests: net: add test for ipv6 fragmentation

Brian Masney (1):
      net: cadence: macb: convert from round_rate() to determine_rate()

Calvin Owens (1):
      Bluetooth: remove duplicate h4_recv_buf() in header

Camelia Groza (1):
      net: phy: aquantia: add support for AQR115

Carolina Jubran (14):
      ptp: Add ioctl commands to expose raw cycle counter values
      net/mlx5: Extract MTCTR register read logic into helper function
      net/mlx5: Support getcyclesx and getcrosscycles
      net/mlx5: Add RS FEC histogram infrastructure
      net/mlx5: Remove VLAN insertion fields from WQE Ether segment
      net/mlx5: Refactor MACsec WQE metadata shifts
      net/mlx5e: Prevent WQE metadata conflicts between timestamping and offloads
      net/mlx5e: Don't query FEC statistics when FEC is disabled
      net/mlx5e: Add logic to read RS-FEC histogram bin ranges from PPHCR
      net/mlx5e: Report RS-FEC histogram statistics via ethtool
      net/mlx5: Improve QoS error messages with actual depth values
      net/mlx5e: Remove unused mdev param from RSS indir init
      net/mlx5e: Introduce mlx5e_rss_init_params
      net/mlx5e: Introduce mlx5e_rss_params for RSS configuration

Chandra Mohan Sundar (1):
      net: macb: Validate the value of base_time properly

Chandrashekar Devegowda (2):
      Bluetooth: btintel_pcie: Add support for _suspend() / _resume()
      Bluetooth: btintel_pcie: Define hdev->wakeup() callback

Chaoyi Chen (2):
      net: ethernet: stmmac: dwmac-rk: Make the clk_phy could be used for external phy
      Revert "net: ethernet: stmmac: dwmac-rk: Make the clk_phy could be used for external phy"

Charalampos Mitrodimas (1):
      net: ipv6: fix field-spanning memcpy warning in AH output

Chen-Yu Tsai (2):
      dt-bindings: net: sun8i-emac: Add A523 GMAC200 compatible
      net: stmmac: Add support for Allwinner A523 GMAC200

Chia-Yu Chang (5):
      tcp: reorganize tcp_sock_write_txrx group for variables later
      tcp: ecn functions in separated include file
      tcp: accecn: AccECN option send control
      tcp: accecn: AccECN option failure handling
      tcp: accecn: try to fit AccECN option with SACK

Chih-Kang Chang (4):
      wifi: rtw89: 8852c: check LPS H2C command complete by C2H reg instead of done ack
      wifi: rtw89: disable RTW89_PHYSTS_IE09_FTR_0 for ppdu status
      wifi: rtw89: obtain RX path from ppdu status IE00
      wifi: rtw89: wow: enable TKIP related feature

Ching-Te Ku (1):
      wifi: rtw89: coex: Limit Wi-Fi scan slot cost to avoid A2DP glitch

Chris Lu (2):
      Bluetooth: btusb: Add new VID/PID 13d3/3627 for MT7925
      Bluetooth: btusb: Add new VID/PID 13d3/3633 for MT7922

Christian Marangi (5):
      net: phy: introduce phy_id_compare_vendor() PHY ID helper
      net: phy: as21xxx: better handle PHY HW reset on soft-reboot
      net: phy: introduce phy_id_compare_model() PHY ID helper
      net: phy: broadcom: Convert to phy_id_compare_model()
      net: phy: broadcom: Convert to PHY_ID_MATCH_MODEL macro

Christoph Paasch (4):
      net: Make nexthop-dumps scale linearly with the number of nexthops
      net: When removing nexthops, don't call synchronize_net if it is not necessary
      net: Add rfs_needed() helper
      mptcp: record subflows in RPS table

Christophe Leroy (2):
      netfilter: nft_payload: Use csum_replace4() instead of opencoding
      net: wan: framer: Add version sysfs attribute for the Lantiq PEF2256 framer

ChunHao Lin (1):
      r8169: set EEE speed down ratio to 1

Claudiu Manoil (1):
      net: enetc: Fix probing error message typo for the ENETCv4 PF driver

Colin Foster (1):
      smsc911x: add second read of EEPROM mac when possible corruption seen

Colin Ian King (1):
      net: stmmac: make variable data a u32

Conley Lee (1):
      dt-bindings: net: sun4i-emac: add dma support

Cosmin Ratiu (10):
      net/mlx5: Fix typo of MLX5_EQ_DOORBEL_OFFSET
      net/mlx5: Remove unused 'offset' field from mlx5_sq_bfreg
      net/mlx5e: Remove unused 'xsk' param of mlx5e_build_xdpsq_param
      net/mlx5: Store the global doorbell in mlx5_priv
      net/mlx5e: Prepare for using multiple TX doorbells
      net/mlx5e: Prepare for using different CQ doorbells
      net/mlx5e: Use multiple TX doorbells
      net/mlx5e: Use multiple CQ doorbells
      devlink: Add a 'num_doorbells' driverinit param
      net/mlx5e: Use the 'num_doorbells' devlink param

Cryolitia PukNgae (1):
      selftests: net: fix memory leak in tls.c

Dan Carpenter (6):
      nfc: pn533: Delete an unnecessary check
      wifi: mwifiex: fix double free in mwifiex_send_rgpower_table()
      hinic3: Fix NULL vs IS_ERR() check in hinic3_alloc_rxqs_res()
      net: ti: icssm-prueth: unwind cleanly in probe()
      dibs: Check correct variable in dibs_init()
      dpll: zl3073x: Fix double free in zl3073x_devlink_flash_update()

Daniel Gabay (1):
      wifi: iwlwifi: mld: add few missing hcmd/notif names

Daniel Golle (16):
      net: dsa: lantiq_gswip: deduplicate dsa_switch_ops
      net: dsa: lantiq_gswip: prepare for more CPU port options
      net: dsa: lantiq_gswip: move definitions to header
      net: dsa: lantiq_gswip: introduce bitmap for MII ports
      net: dsa: lantiq_gswip: load model-specific microcode
      net: dsa: lantiq_gswip: make DSA tag protocol model-specific
      net: dsa: lantiq_gswip: store switch API version in priv
      net: phy: mxl-86110: add basic support for led_brightness_set op
      net: phy: mxl-86110: fix indentation in struct phy_driver
      net: phy: mxl-86110: add basic support for MxL86111 PHY
      net: dsa: lantiq_gswip: move to dedicated folder
      net: dsa: lantiq_gswip: support model-specific mac_select_pcs()
      net: dsa: lantiq_gswip: ignore SerDes modes in phylink_mac_config()
      net: dsa: lantiq_gswip: support offset of MII registers
      net: dsa: lantiq_gswip: support standard MDIO node name
      net: dsa: lantiq_gswip: move MDIO bus registration to .setup()

Daniel Jurgens (2):
      net/mlx5: Query to see if host PF is disabled
      net/mlx5: Support disabling host PFs

Daniel Machon (1):
      net: sparx5/lan969x: Add support for ethtool pause parameters

Daniel Palmer (1):
      eth: 8139too: Make 8139TOO_PIO depend on !NO_IOPORT_MAP

Daniel Zahka (6):
      net: move sk_validate_xmit_skb() to net/core/dev.c
      net: tcp: allow tcp_timewait_sock to validate skbs before handing to device
      psp: make struct sock argument const in psp_sk_get_assoc_rcu()
      psp: fix preemptive inet_twsk() cast in psp_sk_get_assoc_rcu()
      psp: don't use flags for checking sk_state
      psp: clarify checksum behavior of psp_dev_rcv()

Darshan Rathod (1):
      wifi: brcmfmac: avoid assignment in if/else-if conditions in NVRAM load path

Dave Ertman (8):
      ice: Remove casts on void pointers in LAG code
      ice: replace u8 elements with bool where appropriate
      ice: Add driver specific prefix to LAG defines
      ice: move LAG function in code to prepare for Active-Active
      ice: Cleanup variable initialization in LAG code
      ice: cleanup capabilities evaluation
      ice: Implement support for SRIOV VFs across Active/Active bonds
      ice: Remove deprecated ice_lag_move_new_vf_nodes() call

Dave Stevenson (2):
      dt-bindings: net: cdns,macb: Add compatible for Raspberry Pi RP1
      net: cadence: macb: Add support for Raspberry Pi RP1 ethernet controller

David Ahern (2):
      selftests: Disable dad for ipv6 in fcnal-test.sh
      selftests: Replace sleep with slowwait

David Hildenbrand (1):
      wireguard: selftests: remove CONFIG_SPARSEMEM_VMEMMAP=y from qemu kernel config

David Yang (2):
      net: phylink: remove stale an_enabled from doc
      selftests: forwarding: Reorder (ar)ping arguments to obey POSIX getopt

Deepak Sharma (1):
      net: nfc: nci: Add parameter validation for packet data

Dimitri Daskalakis (3):
      selftests: drv-net: xdp: Extract common XDP_TX setup/validation.
      selftests: drv-net: xdp: Add a single-buffer XDP_TX test.
      selftests: drv-net: xdp: Validate single-buff XDP_TX in multi-buff mode

Dipayaan Roy (1):
      net: mana: Use page pool fragments for RX buffers instead of full pages to improve memory efficiency.

Dmitry Antipov (1):
      tipc: adjust tipc_nodeid2string() to return string length

Dmitry Safonov (2):
      tcp: Destroy TCP-AO, TCP-MD5 keys in .sk_destruct()
      tcp: Free TCP-AO/TCP-MD5 info/keys without RCU

Dragos Tatulea (10):
      queue_api: add support for fetching per queue DMA dev
      io_uring/zcrx: add support for custom DMA devices
      net: devmem: get netdev DMA device via new API
      net/mlx5e: add op for getting netdev DMA device
      net: devmem: pull out dma_dev out of net_devmem_bind_dmabuf
      net: devmem: pre-read requested rx queues during bind
      net: devmem: allow binding on rx queues with same DMA devices
      net/mlx5e: Make PCIe congestion event thresholds configurable
      net/mlx5e: Add stale counter for PCIe congestion events
      page_pool: Clamp pool size to max 16K pages

Eric Biggers (10):
      nfc: s3fwrn5: Use SHA-1 library instead of crypto_shash
      ppp: mppe: Use SHA-1 library instead of crypto_shash
      selftests: net: Explicitly enable CONFIG_CRYPTO_SHA1 for IPsec
      sctp: Fix MAC comparison to be constant-time
      sctp: Use HMAC-SHA1 and HMAC-SHA256 library for chunk authentication
      sctp: Convert cookie authentication to use HMAC-SHA256
      sctp: Stop accepting md5 and sha1 for net.sctp.cookie_hmac_alg
      ipv6: sr: Use HMAC-SHA1 and HMAC-SHA256 library functions
      ipv6: sr: Prepare HMAC key ahead of time
      mptcp: use HMAC-SHA256 library instead of open-coded HMAC

Eric Dumazet (79):
      phonet: add __rcu annotations
      net: set net.core.rmem_max and net.core.wmem_max to 4 MB
      idpf: do not linearize big TSO packets
      tcp: annotate data-races around tp->rx_opt.user_mss
      tcp: lockless TCP_MAXSEG option
      tcp: annotate data-races around icsk->icsk_retransmits
      tcp: annotate data-races around icsk->icsk_probes_out
      net: add sk_drops_read(), sk_drops_inc() and sk_drops_reset() helpers
      net: add sk_drops_skbadd() helper
      net: add sk->sk_drop_counters
      udp: add drop_counters to udp socket
      inet: raw: add drop_counters to raw sockets
      net_sched: remove BH blocking in eight actions
      net_sched: act_vlan: use RCU in tcf_vlan_dump()
      net_sched: act_tunnel_key: use RCU in tunnel_key_dump()
      net_sched: act_skbmod: use RCU in tcf_skbmod_dump()
      inet_diag: annotate data-races in inet_diag_msg_common_fill()
      tcp: annotate data-races in tcp_req_diag_fill()
      inet_diag: annotate data-races in inet_diag_bc_sk()
      inet_diag: change inet_diag_bc_sk() first argument
      inet_diag: avoid cache line misses in inet_diag_bc_sk()
      net: dst: introduce dst->dev_rcu
      ipv6: start using dst_dev_rcu()
      ipv6: use RCU in ip6_xmit()
      ipv6: use RCU in ip6_output()
      net: use dst_dev_rcu() in sk_setup_caps()
      tcp_metrics: use dst_dev_net_rcu()
      tcp: use dst_dev_rcu() in tcp_fastopen_active_disable_ofo_check()
      ipv4: start using dst_dev_rcu()
      inet: ping: check sock_net() in ping_get_port() and ping_lookup()
      inet: ping: remove ping_hash()
      inet: ping: make ping_port_rover per netns
      inet: ping: use EXPORT_IPV6_MOD[_GPL]()
      net_sched: add back BH safety to tcf_lock
      net_sched: act: remove tcfa_qstats
      tcp: fix __tcp_close() to only send RST when required
      selftests/net: packetdrill: add tcp_close_no_rst.pkt
      tcp: use tcp_eat_recv_skb in __tcp_close()
      net: call cond_resched() less often in __release_sock()
      ipv6: snmp: remove icmp6type2name[]
      ipv6: snmp: do not use SNMP_MIB_SENTINEL anymore
      ipv6: snmp: do not track per idev ICMP6_MIB_RATELIMITHOST
      ipv4: snmp: do not use SNMP_MIB_SENTINEL anymore
      mptcp: snmp: do not use SNMP_MIB_SENTINEL anymore
      sctp: snmp: do not use SNMP_MIB_SENTINEL anymore
      tls: snmp: do not use SNMP_MIB_SENTINEL anymore
      xfrm: snmp: do not use SNMP_MIB_SENTINEL anymore
      net: snmp: remove SNMP_MIB_SENTINEL
      net: use NUMA drop counters for softnet_data.dropped
      ipv6: make ipv6_pinfo.saddr_cache a boolean
      ipv6: make ipv6_pinfo.daddr_cache a boolean
      ipv6: np->rxpmtu race annotation
      ipv6: reorganise struct ipv6_pinfo
      udp: refine __udp_enqueue_schedule_skb() test
      udp: update sk_rmem_alloc before busylock acquisition
      net: group sk_backlog and sk_receive_queue
      udp: add udp_drops_inc() helper
      udp: make busylock per socket
      udp: use skb_attempt_defer_free()
      psp: rename our psp_dev_destroy()
      psp: do not use sk_dst_get() in psp_dev_get_for_sock()
      tcp: prefer sk_skb_reason_drop()
      net: move sk_uid and sk_protocol to sock_read_tx
      net: move sk->sk_err_soft and sk->sk_sndbuf
      tcp: remove CACHELINE_ASSERT_GROUP_SIZE() uses
      tcp: move tcp->rcv_tstamp to tcp_sock_write_txrx group
      tcp: move recvmsg_inq to tcp_sock_read_txrx
      tcp: move tcp_clean_acked to tcp_sock_read_tx group
      tcp: move mtu_info to remove two 32bit holes
      tcp: reclaim 8 bytes in struct request_sock_queue
      udp: remove busylock and add per NUMA queues
      netfilter: nf_conntrack: do not skip entries in /proc/net/nf_conntrack
      scm: use masked_user_access_begin() in put_cmsg()
      net: remove one stac/clac pair from move_addr_to_user()
      tcp: use skb->len instead of skb->truesize in tcp_can_ingest()
      Revert "net: group sk_backlog and sk_receive_queue"
      net: make softnet_data.defer_count an atomic
      net: use llist for sd->defer_list
      net: add NUMA awareness to skb_attempt_defer_free()

F.S. Peng (1):
      ptp: netc: add external trigger stamp support

Fabio Estevam (1):
      dt-bindings: nfc: ti,trf7970a: Restrict the ti,rx-gain-reduction-db values

Fan Gong (22):
      hinic3: Async Event Queue interfaces
      hinic3: Complete Event Queue interfaces
      hinic3: Command Queue framework
      hinic3: Command Queue interfaces
      hinic3: TX & RX Queue coalesce interfaces
      hinic3: Mailbox framework
      hinic3: Mailbox management interfaces
      hinic3: Interrupt request configuration
      hinic3: HW initialization
      hinic3: HW management interfaces
      hinic3: HW common function initialization
      hinic3: HW capability initialization
      hinic3: Command Queue flush interfaces
      hinic3: Nic_io initialization
      hinic3: Queue pair endianness improvements
      hinic3: Queue pair resource initialization
      hinic3: Queue pair context initialization
      hinic3: Tx & Rx configuration
      hinic3: Add Rss function
      hinic3: Add port management
      hinic3: Fix missing napi->dev in netif_queue_set_napi
      hinic3: Fix code style (Missing a blank line before return)

Fedor Pchelkin (4):
      wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()
      wifi: rtw89: avoid possible TX wait initialization race
      wifi: rtw89: fix leak in rtw89_core_send_nullfunc()
      wifi: rtw89: avoid circular locking dependency in ser_state_run()

Felix Fietkau (11):
      wifi: mt76: mt7996: remove redundant per-phy mac80211 calls during restart
      wifi: mt76: mt7996: improve hardware restart reliability
      wifi: mt76: mt7996: decrease timeout for commonly issued MCU commands
      wifi: mt76: mt7996: fix setting beacon protection keys
      wifi: mt76: mt7996: fix memory leak on mt7996_mcu_sta_key_tlv error
      wifi: mt76: mt7996: delete vif keys when requested
      wifi: mt76: mt7996: fix key add/remove imbalance
      wifi: mt76: mt7996: fix updating beacon protection with beacons enabled
      wifi: mt76: use altx queue for offchannel tx on connac+
      wifi: mt76: improve phy reset on hw restart
      wifi: mt76: abort scan/roc on hw restart

Feng Zhou (1):
      io_uring/zcrx: fix ifq->if_rxq is -1, get dma_dev is NULL

Fernando Fernandez Mancera (3):
      netfilter: nft_payload: extend offset to 65535 bytes
      netfilter: nft_meta_bridge: introduce NFT_META_BRI_IIFHWADDR support
      netfilter: nfnetlink: reset nlh pointer during batch replay

Florian Fainelli (1):
      net: mdio: mdio-bcm-unimac: Refine incorrect clock message

Florian Westphal (11):
      netfilter: ctnetlink: remove refcounting in dying list dumping
      netfilter: nft_set_pipapo_avx2: split lookup function in two parts
      netfilter: nft_set_pipapo: use avx2 algorithm for insertions too
      netfilter: nf_tables: allow iter callbacks to sleep
      netfilter: nf_tables: all transaction allocations can now sleep
      netfilter: nft_set_pipapo: remove redundant test for avx feature bit
      netfilter: nf_reject: remove unneeded exports
      netfilter: nf_reject: don't reply to icmp error messages
      netfilter: nft_set_pipapo: use 0 genmask for packetpath lookups
      netfilter: nft_set_pipapo_avx2: fix skip of expired entries
      selftests: netfilter: nft_concat_range.sh: add check for double-create bug

Furong Xu (1):
      net: stmmac: Convert open-coded register polling to helper macro

Gal Pressman (3):
      scripts/coccinelle: Find PTR_ERR() to %pe candidates
      net/mlx5: Use %pe format specifier for error pointers
      net/mlx5e: Use extack in set rxfh callback

Gang Yan (1):
      selftests: mptcp: add checks for fallback counters

Gatien Chevallier (2):
      time: export timespec64_add_safe() symbol
      drivers: net: stmmac: handle start time set in the past for flexible PPS

Geert Uytterhoeven (17):
      net: ethernet: qualcomm: QCOM_PPE should depend on ARCH_QCOM
      sh_eth: Remove dummy Runtime PM callbacks
      sh_eth: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
      sh_eth: Use async pm_runtime_put()
      can: rcar_can: Consistently use ndev for net_device pointers
      can: rcar_can: Add helper variable dev to rcar_can_probe()
      can: rcar_can: Convert to Runtime PM
      can: rcar_can: Convert to BIT()
      can: rcar_can: Convert to GENMASK()
      can: rcar_can: CTLR bitfield conversion
      can: rcar_can: TFCR bitfield conversion
      can: rcar_can: BCR bitfield conversion
      can: rcar_can: Mailbox bitfield conversion
      can: rcar_can: Do not print alloc_candev() failures
      can: rcar_can: Convert to %pe
      psp: Expand PSP acronym in INET_PSP help description
      net: renesas: rswitch: Remove unneeded semicolons

Geliang Tang (3):
      mptcp: make ADD_ADDR retransmission timeout adaptive
      selftests: mptcp: close server file descriptors
      selftests: mptcp: close server IPC descriptors

Gokul Sivakumar (1):
      wifi: brcmfmac: fix 43752 SDIO FWVID incorrectly labelled as Cypress (CYW)

Gopi Krishna Menon (1):
      selftests/net: add tcp_port_share to .gitignore

Guillaume Nault (1):
      ipv4: Convert ->flowi4_tos to dscp_t.

Gustavo A. R. Silva (6):
      wifi: iwlegacy: Remove unused structs and avoid -Wflex-array-member-not-at-end warnings
      wifi: iwlwifi: mei: Remove unused flexible-array member in struct iwl_sap_hdr
      geneve: Avoid -Wflex-array-member-not-at-end warning
      net: airoha: Avoid -Wflex-array-member-not-at-end warning
      tls: Avoid -Wflex-array-member-not-at-end warning
      Bluetooth: Avoid a couple dozen -Wflex-array-member-not-at-end warnings

Haiyang Zhang (1):
      net: mana: Reduce waiting time if HWC not responding

Hangbin Liu (8):
      selftests: net: bpf_offload: print loaded programs on mismatch
      selftests: rtnetlink: print device info on preferred_lft test failure
      bonding: add support for per-port LACP actor priority
      bonding: support aggregator selection based on port priority
      selftests: bonding: add test for LACP actor port priority
      hsr: use netdev_master_upper_dev_link() when linking lower ports
      bonding: fix xfrm offload feature setup on active-backup mode
      selftests: bonding: add ipsec offload test

Hari Chandrakanthan (1):
      wifi: ath12k: Fix peer lookup in ath12k_dp_mon_rx_deliver_msdu()

Hariprasad Kelam (1):
      Octeontx2-af: Broadcast XON on all channels

Heiner Kallweit (24):
      net: phy: fixed: remove usage of a faux device
      net: phy: fixed: let fixed_phy_add always use addr 0 and remove return value
      net: phy: fixed_phy: let fixed_phy_unregister free the phy_device
      net: phy: fixed_phy: simplify fixed_mdio_read
      net: phy: fixed_phy: remove link gpio support
      net: fman: clean up included headers
      net: phy: fixed_phy: remove unused interrupt support
      net: phy: fixed_phy: remove member no_carrier from struct fixed_phy
      net: phy: fixed_phy: add helper fixed_phy_find
      net: phy: fixed_phy: remove struct fixed_mdio_bus
      net: phy: fixed_phy: remove two function stubs
      of: mdio: warn if deprecated fixed-link binding is used
      net: phylink: warn if deprecated array-style fixed-link binding is used
      r8169: log that system vendor flags ASPM as safe
      net: dsa: dsa_loop: remove usage of mdio_board_info
      net: phy: remove mdio_board_info support from phylib
      net: dsa: dsa_loop: remove duplicated definition of NUM_FIXED_PHYS
      net: phy: move config symbol MDIO_BUS to drivers/net/phy/Kconfig
      net: phy: dp83640: improve phydev and driver removal handling
      net: phy: stop exporting phy_driver_register
      net: phy: stop exporting phy_driver_unregister
      net: phy: annotate linkmode initializers as not used after init phase
      net: sfp: don't include swphy.h
      net: sfp: improve poll interval handling

Horatiu Vultur (9):
      net: phy: micrel: Start using PHY_ID_MATCH_MODEL
      net: phy: micrel: Introduce lanphy_modify_page_reg
      net: phy: micrel: Replace hardcoded pages with defines
      net: phy: micrel: Add support for lan8842
      net: phy: micrel: Introduce function __lan8814_ptp_probe_once
      net: phy: micrel: Add PTP support for lan8842
      net: phy: micrel: Add Fast link failure support for lan8842
      net: phy: micrel: Fix default LED behaviour
      net: phy: micrel: Fix lan8814_config_init

Howard Hsu (3):
      wifi: mt76: mt7996: support writing MAC TXD for AddBA Request
      wifi: mt76: mt7996: remove the mem_total field of STA_REC_BF command
      wifi: mt76: mt7996: fill User Priority in skb->priority for rx packets

Håkon Bugge (1):
      rds: ib: Remove unused extern definition

I Viswanath (2):
      net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast
      ptp: Add a upper bound on max_vclocks

Ido Schimmel (12):
      selftests: forwarding: Add a test for FDB activity notification control
      bridge: Redirect to backup port when port is administratively down
      selftests: net: Test bridge backup port when port is administratively down
      vxlan: Make vxlan_fdb_find_uc() more robust against NPDs
      ipv4: cipso: Simplify IP options handling in cipso_v4_error()
      ipv4: icmp: Pass IPv4 control block structure as an argument to __icmp_send()
      ipv4: icmp: Fix source IP derivation in presence of VRFs
      selftests: traceroute: Return correct value on failure
      selftests: traceroute: Use require_command()
      selftests: traceroute: Reword comment
      selftests: traceroute: Test traceroute with different source IPs
      selftests: traceroute: Add VRF tests

Ilan Peer (11):
      wifi: mac80211: Fix HE capabilities element check
      wifi: cfg80211: Advertise supported NAN capabilities
      wifi: cfg80211: Support Tx/Rx of action frame for NAN
      wifi: cfg80211: Store the NAN cluster ID
      wifi: mac80211: Support Tx of action frame for NAN
      wifi: mac80211: Accept management frames on NAN interface
      wifi: mac80211: Track NAN interface start/stop
      wifi: mac80211: Get the correct interface for non-netdev skb status
      wifi: mac80211: Export an API to check if NAN is started
      wifi: mac80211: Extend support for changing NAN configuration
      wifi: mac80211_hwsim: Add simulation support for NAN device

Ilpo Järvinen (9):
      tcp: reorganize SYN ECN code
      tcp: fast path functions later
      tcp: AccECN core
      tcp: accecn: AccECN negotiation
      tcp: accecn: add AccECN rx byte counters
      tcp: accecn: AccECN needs to know delivered bytes
      tcp: sack option handling improvements
      tcp: accecn: AccECN option
      tcp: accecn: AccECN option ceb/cep and ACE field multi-wrap heuristics

Itamar Shalev (2):
      wifi: iwlwifi: pcie: relocate finish_nic_init logic to gen1_2
      wifi: iwlwifi: simplify iwl_poll_prph_bit return value

Ivan Pravdin (1):
      Bluetooth: bcsp: receive data only if registered

Ivan Vecera (8):
      dpll: zl3073x: Add functions to access hardware registers
      dpll: zl3073x: Add low-level flash functions
      dpll: zl3073x: Add firmware loading functionality
      dpll: zl3073x: Refactor DPLL initialization
      dpll: zl3073x: Implement devlink flash callback
      dpll: add phase-offset-avg-factor device attribute to netlink spec
      dpll: add phase_offset_avg_factor_get/set callback ops
      dpll: zl3073x: Allow to configure phase offset averaging factor

J. Neuschäfer (1):
      dt-bindings: net: ethernet-controller: Fix grammar in comment

Jacek Kowalski (5):
      e1000: drop unnecessary constant casts to u16
      e1000e: drop unnecessary constant casts to u16
      igb: drop unnecessary constant casts to u16
      igc: drop unnecessary constant casts to u16
      ixgbe: drop unnecessary casts to u16 / int

Jack Kao (1):
      wifi: mt76: mt7925: add pci restore for hibernate

Jakub Kicinski (233):
      Merge branch 'net-remove-redundant-__gfp_nowarn'
      Merge branch 'netconsole-reuse-netpoll_parse_ip_addr-in-configfs-helpers'
      Merge branch 'selftest-af_unix-enable-wall-and-wflex-array-member-not-at-end'
      Merge branch 'net-stmmac-improbe-suspend-resume-architecture'
      selftests: drv-net: add configs for zerocopy Rx
      selftests: drv-net: devmem: remove sudo from system() calls
      selftests: drv-net: devmem: add / correct the IPv6 support
      selftests: net: terminate bkg() commands on exception
      selftests: drv-net: devmem: flip the direction of Tx tests
      Merge branch 'selftests-drv-net-improve-zerocopy-tests'
      Merge branch 'net-airoha-introduce-npu-callbacks-for-wlan-offloading'
      Merge branch 'refine-stmmac-code'
      Merge branch 'net-don-t-use-pk-through-printk-or-tracepoints'
      net: ethtool: support including Flow Label in the flow hash for RSS
      eth: fbnic: support RSS on IPv6 Flow Label
      eth: bnxt: support RSS on IPv6 Flow Label
      selftests: drv-net: add test for RSS on flow label
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'docs/v6.17-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-docs
      Merge branch 'devlink-port-attr-cleanup'
      selftests: drv-net: wait for carrier
      Merge branch 'bridge-redirect-to-backup-port-when-port-is-administratively-down'
      Merge branch 'net-dsa-b53-mmap-add-bcm63268-gphy-power-control'
      Merge branch 'net-mlx5-support-disabling-host-pfs'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'net-dsa-move-ks8995-phy-driver-to-dsa'
      docs: netdev: refine the clean-up patch examples
      Merge branch 'net-use-vmalloc_array-to-simplify-code'
      Merge branch 'net-stmmac-eee-and-wol-cleanups'
      selftests: drv-net: test the napi init state
      selftests: drv-net: tso: increase the retransmit threshold
      selftests: drv-net: ncdevmem: make configure_channels() support combined channels
      Merge branch 'net-speedup-some-nexthop-handling-when-having-a-lot-of-nexthops'
      Merge branch 'net-convert-to-skb_dstref_steal-and-skb_dstref_restore'
      Merge branch 'there-are-a-cleancode-and-a-parameter-check-for-hns3-driver'
      Merge branch 'stmmac-stop-silently-dropping-bad-checksum-packets'
      Merge branch 'net-memcg-gather-memcg-code-under-config_memcg'
      Merge branch 'sctp-convert-to-use-crypto-lib-and-upgrade-cookie-auth'
      Merge branch 'bnxt_en-updates-for-net-next'
      net: page_pool: add page_pool_get()
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'net-remove-the-use-of-dev_err_probe'
      Merge tag 'nf-next-25-08-20' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'selftests-test-xdp_tx-for-single-buffer'
      Merge branch 'tcp-user_mss-and-tcp_maxseg-series'
      Merge branch 'rds-fix-semantic-annotations'
      Merge branch 'net-hinic3-add-a-driver-for-huawei-3rd-gen-nic-management-interfaces'
      Merge branch 'net-wangxun-complete-ethtool-coalesce-options'
      Merge branch 'aquantia-phy-driver-consolidation-part-1'
      selftests: drv-net: xdp: make sure we're actually testing native XDP
      Merge branch 'net-dsa-lantiq_gswip-prepare-for-supporting-new-features'
      Merge branch 'net-ipv4-allow-directed-broadcast-routes-to-use-dst-hint'
      Merge branch 'tcp-annotate-data-races-around-icsk_retransmits-and-icsk_probes_out'
      Merge branch 'net-airoha-add-ppe-support-for-rx-wlan-offload'
      Merge branch 'tcp-follow-up-for-dccp-removal'
      Merge branch 'expose-burst-period-for-devlink-health-reporter'
      selftests: drv-net: hds: restore hds settings
      selftests: drv-net: ncdevmem: remove use of error()
      selftests: drv-net: ncdevmem: save IDs of flow rules we added
      selftests: drv-net: ncdevmem: restore old channel config
      selftests: drv-net: ncdevmem: restore original HDS setting before exiting
      selftests: drv-net: ncdevmem: explicitly set HDS threshold to 0
      Merge branch 'selftests-drv-net-ncdevmem-fix-error-paths'
      Merge branch 'ipv6-sr-simplify-and-optimize-hmac-calculations'
      Merge branch 'net-prevent-rps-table-overwrite-of-active-flows'
      Merge branch 'macsec-replace-custom-netlink-attribute-checks-with-policy-level-checks'
      Merge branch 'eth-fbnic-extend-hw-stats-support'
      uapi: wrap compiler_types.h in an ifdef instead of the implicit strip
      Merge branch 'devmem-io_uring-allow-more-flexibility-for-zc-dma-devices'
      selftests: drv-net: rss_ctx: fix the queue count check
      Merge branch 'net_sched-extend-rcu-use-in-dump-methods-ii'
      eth: mlx5: remove Kconfig co-dependency with VXLAN
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'inet_diag-make-dumps-faster-with-simple-filters'
      Merge branch 'net-add-rcu-safety-to-dst-dev'
      Merge branch 'inet-ping-misc-changes'
      selftests: drv-net: adjust tests before defaulting to shell=False
      selftests: net: py: don't default to shell=True
      selftests: drv-net: rss_ctx: use Netlink for timed reconfig
      selftests: drv-net: rss_ctx: make the test pass with few queues
      Merge branch 'net-dsa-lantiq_gswip-prepare-for-supporting-maxlinear-gsw1xx'
      Merge tag 'mlx5-psp-ifc' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge branch 'mptcp-misc-features-for-v6-18'
      Merge branch 'tools-ynl-gen-misc-changes'
      Merge tag 'nf-next-25-09-02' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'net-stmmac-allow-generation-of-flexible-pps-relative-to-mac-time'
      Merge branch 'net-phy-micrel-add-ptp-support-for-lan8842'
      eth: fbnic: move page pool pointer from NAPI to the ring struct
      eth: fbnic: move xdp_rxq_info_reg() to resource alloc
      eth: fbnic: move page pool alloc to fbnic_alloc_rx_qt_resources()
      eth: fbnic: use netmem_ref where applicable
      eth: fbnic: request ops lock
      eth: fbnic: split fbnic_disable()
      eth: fbnic: split fbnic_flush()
      eth: fbnic: split fbnic_enable()
      eth: fbnic: split fbnic_fill()
      net: add helper to pre-check if PP for an Rx queue will be unreadable
      eth: fbnic: allocate unreadable page pool for the payloads
      eth: fbnic: defer page pool recycling activation to queue start
      eth: fbnic: don't pass NAPI into pp alloc
      eth: fbnic: support queue ops / zero-copy Rx
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch '10GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'tcp-__tcp_close-changes'
      Merge branch 'sh_eth-pm-related-cleanups'
      Merge branch 'net-stmmac-correctly-populate-ptp_clock_ops-getcrosststamp'
      Merge branch '10g-qxgmii-for-aqr412c-felix-dsa-and-lynx-pcs-driver'
      selftests: net: make the dump test less sensitive to mem accounting
      selftests: net: move netlink-dumps back to progs
      Merge branch 'ipv6-snmp-avoid-performance-issue-with-ratelimithost'
      Merge branch 'net-stmmac-mdio-cleanups'
      eth: fbnic: support persistent NAPI config
      Merge tag 'mlx5-rs-fec-ifc' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      selftests: net: run groups from fcnal-test in parallel
      selftests: net: speed up pmtu.sh by avoiding unnecessary cleanup
      Merge branch 'net-phy-fixed_phy-improvements'
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'mptcp-make-add_addr-retransmission-timeout-adaptive'
      Merge branch 'devlink-mlx5-add-new-parameters-for-link-management-and-sriov-eswitch-configurations'
      Merge branch 'net-mlx5e-add-pcie-congestion-event-extras'
      Merge branch 'ptp-add-pulse-signal-loopback-support-for-debugging'
      Merge branch 'tools-ynl-fix-errors-reported-by-ruff'
      selftests: net: replace sleeps in fcnal-test with waits
      net: xdp: pass full flags to xdp_update_skb_shared_info()
      net: xdp: handle frags with unreadable memory
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'wireless-next-2025-09-11' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'net-ethernet-renesas-rcar_gen4_ptp-simplify-register-layout'
      Merge branch 'net-af_packet-optimize-retire-operation'
      Merge branch 'wireguard-fixes-for-6-17-rc6'
      Merge branch 'bridge-allow-keeping-local-fdb-entries-only-on-vlan-0'
      Merge branch 'tcp-destroy-tcp-ao-tcp-md5-keys-in-sk_destruct'
      Merge tag 'nf-next-25-09-11' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'add-gmac-support-for-renesas-rz-t2h-n2h-socs'
      Merge branch 'net-dsa-mv88e6xxx-remove-redundant-ptp-timestamping-code'
      Merge branch 'net-stmmac-timestamping-ptp-cleanups'
      Merge branch 'pru-icssm-ethernet-driver'
      Merge branch '10GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'net-fec-add-the-jumbo-frame-support'
      Merge branch 'dpll-zl3073x-add-support-for-devlink-flash'
      Merge branch 'accecn-protocol-patch-series'
      Merge branch 'add-pcs-support-for-renesas-rz-t2h-n2h-socs'
      page_pool: always add GFP_NOWARN for ATOMIC allocations
      Merge branch 'mptcp-misc-minor-cleanups'
      Merge branch 'net-phy-print-warning-if-usage-of-deprecated-array-style-fixed-link-binding-is-detected'
      Merge branch 'tools-ynl-rst-display-attribute-set-doc'
      Merge branch 'microchip-lan865x-minor-improvements'
      Merge branch 'tools-ynl-prepare-for-wireguard'
      Merge branch 'net-mlx5-refactor-devcom-and-add-net-namespace-support'
      Merge tag 'batadv-next-pullrequest-20250916' of https://git.open-mesh.org/linux-merge
      tools: ynl-gen: support uint in multi-attr
      Merge branch 'ptp-safely-cleanup-when-unregistering-a-ptp-clock'
      Merge branch 'net-phy-remove-mdio_board_info-support-from-phylib'
      Merge branch 'net-fix-uaf-of-sk_dst_get-sk-dev'
      Merge branch 'net-dsa-mv88e6xxx-further-ptp-related-cleanups'
      Merge branch 'net-mlx5e-use-multiple-doorbells'
      eth: fbnic: support devmem Tx
      eth: fbnic: make fbnic_fw_log_write() parameter const
      eth: fbnic: use fw uptime to detect fw crashes
      eth: fbnic: factor out clearing the action TCAM
      eth: fbnic: reprogram TCAMs after FW crash
      eth: fbnic: support allocating FW completions with extra space
      eth: fbnic: support FW communication for core dump
      eth: fbnic: add FW health reporter
      eth: fbnic: report FW uptime in health diagnose
      eth: fbnic: add OTP health reporter
      psp: add documentation
      psp: base PSP device support
      net: modify core data structures for PSP datapath support
      tcp: add datapath logic for PSP with inline key exchange
      psp: add op for rotation of device key
      net: psp: add socket security association code
      net: psp: update the TCP MSS to reflect PSP packet overhead
      psp: track generations of device key
      Merge branch 'net-ethtool-add-dedicated-grxrings-driver-callbacks'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'mlx5-next-09-11' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      wan: framer: pef2256: use %pe in print format
      Merge branch 'net-mlx5e-support-rss-for-ipsec-offload'
      Merge branch 'address-miscellaneous-issues-with-psp_sk_get_assoc_rcu'
      net: phy: micrel: use %pe in print format
      Merge branch 'net-stmmac-remove-mac_interface'
      Merge branch 'net-ipv4-some-drop-reason-cleanup-and-improvements'
      Merge branch 'net-netpoll-remove-dead-code-and-speed-up-rtnl-locked-region'
      Merge branch 'tcp-clean-up-inet_hash-and-inet_unhash'
      Merge branch 'net-enetc-improve-the-interface-for-obtaining-phc_index'
      Merge branch 'mptcp-pm-netlink-announce-server-side-flag'
      Merge branch 'net-rework-sfp-capability-parsing-and-quirks'
      Merge tag 'mlx5-next-counters' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge branch 'net-dsa-microchip-add-strap-description-to-set-spi-as-interface-bus'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'net-replace-wq-users-and-add-wq_percpu-to-alloc_workqueue-users'
      Merge branch 'add-more-functionality-to-bnge'
      Merge branch 'tcp-move-few-fields-for-data-locality'
      Merge branch 'net-phy-stop-exporting-phy_driver_register'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'net-stmmac-yet-more-cleanups'
      Merge tag 'nf-next-25-09-24' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'convert-3-drivers-to-ndo_hwtstamp-api'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'scripts-coccinelle-symbolic-error-names-script'
      Merge branch 'xsk-refactors-around-generic-xmit-side'
      Merge tag 'wireless-next-2025-09-25' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge tag 'ipsec-next-2025-09-26' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next
      Merge tag 'linux-can-next-for-6.18-20250924' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'dns_resolver-docs-formatting-cleanup'
      Merge branch 'add-fec-bins-histogram-report-via-ethtool'
      Merge branch 'add-support-to-retrieve-hardware-channel-information'
      Merge branch 'mptcp-pm-special-case-for-c-flag-luminar-endp'
      Merge branch 'selftests-mark-auto-deferring-functions-clearly'
      Merge branch 'net-macb-various-fixes'
      Merge branch 'net-stmmac-drop-frames-causing-hlbs-error'
      Merge branch 'net-wangxun-support-to-configure-rss'
      Merge tag 'for-net-next-2025-09-27' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Merge branch 'mptcp-receive-path-improvement'
      Merge branch 'selftest-packetdrill-import-tfo-server-tests'
      Merge tag 'mlx5-next-lag' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge branch 'mlx5-misc-fixes-2025-09-28'
      Merge branch 'dpll-add-phase-offset-averaging-factor'
      netdevsim: a basic test PSP implementation
      selftests: drv-net: base device access API test
      selftests: drv-net: add PSP responder
      selftests: drv-net: psp: add basic data transfer and key rotation tests
      selftests: drv-net: psp: add association tests
      selftests: drv-net: psp: add connection breaking tests
      selftests: drv-net: psp: add test for auto-adjusting TCP MSS
      selftests: drv-net: psp: add tests for destroying devices
      Revert "net/mlx5e: Update and set Xon/Xoff upon MTU set"
      Merge branch 'net-mlx5-misc-changes-2025-09-28'
      Merge branch 'octeontx2-fix-bitmap-leaks-in-pf-and-vf'

Jakub Sitnicki (2):
      tcp: Update bind bucket state on port release
      selftests/net: Test tcp port reuse after unbinding a socket

James Flowers (1):
      net/smc: Replace use of strncpy on NUL-terminated string with strscpy

Jason A. Donenfeld (1):
      wireguard: selftests: select CONFIG_IP_NF_IPTABLES_LEGACY

Jay Vosburgh (1):
      bonding: Remove support for use_carrier

Jedrzej Jagielski (1):
      ixgbe: reduce number of reads when getting OROM data

Jianbo Liu (5):
      net/mlx5: Change TTC rules to match on undecrypted ESP packets
      net/mlx5e: Recirculate decrypted packets into TTC table
      net/mlx5e: Add flow groups for the packets decrypted by crypto offload
      net/mlx5e: Add flow rules for the decrypted ESP packets
      net/mlx5e: Prevent entering switchdev mode with inconsistent netns

Jiawen Wu (9):
      net: libwx: cleanup VF register macros
      net: ngbe: change the default ITR setting
      net: wangxun: limit tx_max_coalesced_frames_irq
      net: wangxun: cleanup the code in wx_set_coalesce()
      net: wangxun: support to use adaptive RX/TX coalescing
      net: libwx: support separate RSS configuration for every pool
      net: libwx: move rss_field to struct wx
      net: wangxun: add RSS reta and rxfh fields support
      net: libwx: restrict change user-set RSS configuration

Jijie Shao (3):
      net: phy: motorcomm: Add support for PHY LEDs on YT8521
      net: hns3: add parameter check for tx_copybreak and tx_spare_buf_size
      net: hns3: change the function return type from int to bool

Johannes Berg (11):
      wifi: iwlwifi: add a new FW file numbering scheme
      wifi: iwlwifi: iwl-config: include module.h
      wifi: iwlwifi: uefi: remove runtime check of constant values
      wifi: iwlwifi: acpi: make iwl_guid static
      Merge tag 'iwlwifi-next-2025-09-03' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next into HEAD
      Merge tag 'iwlwifi-next-2025-09-09' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      Merge tag 'mt76-next-2025-09-15' of https://github.com/nbd168/wireless
      wifi: cfg80211: remove IEEE80211_CHAN_{1,2,4,8,16}MHZ flags
      Merge tag 'rtw-next-2025-09-22' of https://github.com/pkshih/rtw
      Merge tag 'ath-next-20250922' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Revert "wifi: libertas: WQ_PERCPU added to alloc_workqueue users"

Jonas Rebmann (2):
      net: phy: micrel: Update Kconfig help text
      dt-bindings: net: dsa: nxp,sja1105: Add reset-gpios property

Joy Zou (1):
      net: stmmac: imx: add i.MX91 support

Julian Ruess (3):
      dibs: Move struct device to dibs_dev
      dibs: Create class dibs
      dibs: Move event handling to dibs layer

Juraj Šarinay (1):
      net: nfc: nci: Increase NCI_DATA_TIMEOUT to 3000 ms

Kalesh AP (4):
      bnxt_en: Drop redundant if block in bnxt_dl_flash_update()
      bnxt_en: Remove unnecessary VF check in bnxt_hwrm_nvm_req()
      bnxt_en: Optimize bnxt_sriov_disable()
      bnxt_en: Use VLAN_ETH_HLEN when possible

Kang Yang (3):
      wifi: ath12k: fix signal in radiotap for WCN7850
      wifi: ath12k: fix HAL_PHYRX_COMMON_USER_INFO handling in monitor mode
      wifi: ath12k: fix the fetching of combined rssi

Kashyap Desai (1):
      bnxt_en: Add err_qpc backing store handling

Kiran K (4):
      Bluetooth: btintel: Add support for BlazarIW core
      Bluetooth: btintel_pcie: Add Bluetooth core/platform as comments
      Bluetooth: btintel_pcie: Add id of Scorpious, Panther Lake-H484
      Bluetooth: btintel_pcie: Refactor Device Coredump

Kohei Enju (4):
      igbvf: add lbtx_packets and lbtx_bytes to ethtool statistics
      igbvf: remove redundant counter rx_long_byte_count from ethtool statistics
      nfp: fix RSS hash key size when RSS is not supported
      net: ena: return 0 in ena_get_rxfh_key_size() when RSS hash key is not configurable

Kory Maincent (Dent Project) (1):
      docs: devlink: Sort table of contents alphabetically

Krishna Kumar (2):
      net: Prevent RPS table overwrite of active flows
      net: Cache hash and flow_id to avoid recalculation

Krzysztof Kozlowski (5):
      dt-bindings: nfc: ti,trf7970a: Drop 'db' suffix duplicating dtschema
      dt-bindings: net: litex,liteeth: Correct example indentation
      dt-bindings: net: Drop vim style annotation
      dt-bindings: net: altr,socfpga-stmmac: Constrain interrupts
      dt-bindings: net: renesas,rzn1-gmac: Constrain interrupts

Kuan-Chung Chen (9):
      wifi: rtw89: introduce beacon tracking to improve connection stability
      wifi: rtw89: debug: add beacon_info debugfs
      wifi: rtw89: wow: remove notify during WoWLAN net-detect
      wifi: rtw89: 8851b: rfk: update IQK TIA setting
      wifi: rtw89: 8851b: rfk: update TX wideband IQK
      wifi: rtw89: fix BSSID comparison for non-transmitted BSSID
      wifi: rtw89: fix group frames loss when connected to non-transmitted BSSID
      wifi: rtw89: 8852b: enable beacon tracking support
      wifi: rtw89: 8922a: add TAS feature support

Kuniyuki Iwashima (47):
      selftest: af_unix: Silence -Wflex-array-member-not-at-end warning for scm_inq.c.
      selftest: af_unix: Silence -Wflex-array-member-not-at-end warning for scm_rights.c.
      selftest: af_unix: Silence -Wall warning for scm_pid.c.
      selftest: af_unix: Add -Wall and -Wflex-array-member-not-at-end to CFLAGS.
      mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
      mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
      tcp: Simplify error path in inet_csk_accept().
      net: Call trace_sock_exceed_buf_limit() for memcg failure with SK_MEM_RECV.
      net: Clean up __sk_mem_raise_allocated().
      net-memcg: Introduce mem_cgroup_from_sk().
      net-memcg: Introduce mem_cgroup_sk_enabled().
      net-memcg: Pass struct sock to mem_cgroup_sk_(un)?charge().
      net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
      net: Define sk_memcg under CONFIG_MEMCG.
      selftests/net: packetdrill: Support single protocol test.
      tcp: Remove sk_protocol test for tcp_twsk_unique().
      tcp: Remove timewait_sock_ops.twsk_destructor().
      tcp: Remove hashinfo test for inet6?_lookup_run_sk_lookup().
      tcp: Don't pass hashinfo to socket lookup helpers.
      tcp: Don't pass hashinfo to inet_diag helpers.
      tcp: Move TCP-specific diag functions to tcp_diag.c.
      tcp: Remove sk->sk_prot->orphan_count.
      smc: Fix use-after-free in __pnet_find_base_ndev().
      smc: Use __sk_dst_get() and dst_dev_rcu() in in smc_clc_prfx_set().
      smc: Use __sk_dst_get() and dst_dev_rcu() in smc_clc_prfx_match().
      smc: Use __sk_dst_get() and dst_dev_rcu() in smc_vlan_by_tcpsk().
      tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
      mptcp: Call dst_release() in mptcp_active_enable().
      mptcp: Use __sk_dst_get() and dst_dev_rcu() in mptcp_active_enable().
      psp: Fix typo in kdoc for struct psp_dev_caps.assoc_drv_spc.
      tcp: Remove osk from __inet_hash() arg.
      tcp: Remove inet6_hash().
      tcp: Remove redundant sk_unhashed() in inet_unhash().
      tcp: Remove stale locking comment for TFO.
      selftest: packetdrill: Set ktap_set_plan properly for single protocol test.
      selftest: packetdrill: Require explicit setsockopt(TCP_FASTOPEN).
      selftest: packetdrill: Define common TCP Fast Open cookie.
      selftest: packetdrill: Import TFO server basic tests.
      selftest: packetdrill: Add test for TFO_SERVER_WO_SOCKOPT1.
      selftest: packetdrill: Add test for experimental option.
      selftest: packetdrill: Import opt34/fin-close-socket.pkt.
      selftest: packetdrill: Import opt34/icmp-before-accept.pkt.
      selftest: packetdrill: Import opt34/reset-* tests.
      selftest: packetdrill: Import opt34/*-trigger-rst.pkt.
      selftest: packetdrill: Refine tcp_fastopen_server_reset-after-disconnect.pkt.
      selftest: packetdrill: Import sockopt-fastopen-key.pkt
      selftest: packetdrill: Import client-ack-dropped-then-recovery-ms-timestamps.pkt

Kyle Hendry (2):
      net: dsa: b53: mmap: Add gphy port to phy info for bcm63268
      net: dsa: b53: mmap: Implement bcm63268 gphy power control

Lachlan Hodges (6):
      wifi: mac80211: support block bitmap S1G TIM encoding
      wifi: mac80211: support parsing S1G TIM PVB
      wifi: mac80211: kunit: add kunit tests for S1G PVB decoding
      wifi: cfg80211: correctly implement and validate S1G chandef
      wifi: mac80211: correctly initialise S1G chandef for STA
      wifi: cfg80211: remove ieee80211_s1g_channel_width

Lad Prabhakar (13):
      dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/T2H and RZ/N2H SoCs
      net: stmmac: dwmac-renesas-gbeth: Use OF data for configuration
      net: stmmac: dwmac-renesas-gbeth: Add support for RZ/T2H SoC
      dt-bindings: net: pcs: renesas,rzn1-miic: Add RZ/T2H and RZ/N2H support
      net: pcs: rzn1-miic: Drop trailing comma from of_device_id table
      net: pcs: rzn1-miic: Add missing include files
      net: pcs: rzn1-miic: Move configuration data to SoC-specific struct
      net: pcs: rzn1-miic: move port range handling into SoC data
      net: pcs: rzn1-miic: Make switch mode mask SoC-specific
      net: pcs: rzn1-miic: Add support to handle resets
      net: pcs: rzn1-miic: Add per-SoC control for MIIC register unlock/lock
      net: pcs: rzn1-miic: Add RZ/T2H MIIC support
      net: pcs: Kconfig: Fix unmet dependency warning

Lei Wei (2):
      docs: networking: Add PPE driver documentation for Qualcomm IPQ9574 SoC
      net: ethernet: qualcomm: Initialize PPE L2 bridge settings

Li RongQing (1):
      eth: nfp: Remove u64_stats_update_begin()/end() for stats fetch

Liao Yuanhong (6):
      ptp: ptp_clockmatrix: Remove redundant semicolons
      wifi: rtw89: 8852bt: Simplify unnecessary if-else conditions in _dpk_onoff()
      vsock/test: Remove redundant semicolons
      wifi: rtw89: 8852bt: Remove redundant off_reverse variables
      wifi: iwlwifi: Remove redundant header files
      wifi: ath11k: Remove redundant semicolon

Lingbo Kong (1):
      wifi: ath12k: report station mode per-chain signal strength

Linus Walleij (4):
      net: dsa: Move KS8995 to the DSA subsystem
      net: dsa: ks8995: Add proper RESET delay
      net: dsa: ks8995: Delete sysfs register access
      net: dsa: ks8995: Add basic switch set-up

Loic Poulain (1):
      wifi: ath10k: Fix connection after GTK rekeying

Lorenzo Bianconi (37):
      dt-bindings: net: airoha: npu: Add memory regions used for wlan offload
      net: airoha: npu: Add NPU wlan memory initialization commands
      net: airoha: npu: Add wlan_{send,get}_msg NPU callbacks
      net: airoha: npu: Add wlan irq management callbacks
      net: airoha: npu: Read NPU wlan interrupt lines from the DTS
      net: airoha: npu: Enable core 3 for WiFi offloading
      net: airoha: Add airoha_offload.h header
      net: mediatek: wed: Introduce MT7992 WED support to MT7988 SoC
      net: airoha: Add wlan flowtable TX offload
      net: airoha: Rely on airoha_eth struct in airoha_ppe_flow_offload_cmd signature
      net: airoha: Add airoha_ppe_dev struct definition
      net: airoha: Introduce check_skb callback in ppe_dev ops
      wifi: mac80211: Make CONNECTION_MONITOR optional for MLO sta
      wifi: mt76: mt7996: Overwrite unspecified link_id in mt7996_tx()
      wifi: mt76: mt7996: Fix mt7996_mcu_sta_ba wcid configuration
      wifi: mt76: mt7996: Fix mt7996_mcu_bss_mld_tlv routine
      wifi: mt76: mt7996: Set def_wcid pointer in mt7996_mac_sta_init_link()
      wifi: mt76: mt7996: Set proper link destination address in mt7996_tx()
      wifi: mt76: mt7996: Use deflink for AMPDU rx reordering
      wifi: mt76: Remove dead code in mt76_scan_work
      wifi: mt76: mt7996: Use proper link_id in link_sta_rc_update callback
      wifi: mt76: mt7996: Check phy before init msta_link in mt7996_mac_sta_add_links()
      wifi: mt76: mt7996: Use proper link info in mt7996_mcu_add_group
      wifi: mt76: mt7996: Add all active links to poll list in mt7996_mac_tx_free()
      wifi: mt76: mt7996: Set EML capabilities for AP interface
      wifi: mt76: mt7996: Enable MLO support for client interfaces
      wifi: mt76: Add reset_idx to reset_q mt76_queue_ops signature.
      wifi: mt76: Remove q->ndesc check in mt76_dma_rx_fill()
      wifi: mt76: Do not always enable NAPIs for WED RRO queues
      wifi: mt76: mt7996: Fix tx-queues initialization for second phy on mt7996
      wifi: mt76: mt7996: Fix RX packets configuration for primary WED device
      wifi: mt76: mt7996: Convert mt7996_wed_rro_addr to LE
      wifi: mt76: Add rx_queue_init callback
      wifi: mt76: Add mt76_dma_get_rxdmad_c_buf utility routione
      wifi: mt76: Convert mt76_wed_rro_ind to LE
      net: airoha: Fix PPE_IP_PROTO_CHK register definitions
      net: airoha: npu: Add a NPU callback to initialize flow stats

Luiz Augusto von Dentz (12):
      Bluetooth: btintel_pcie: Move model comment before its definition
      Bluetooth: ISO: Don't initiate CIS connections if there are no buffers
      Bluetooth: HCI: Fix using LE/ACL buffers for ISO packets
      Bluetooth: ISO: Use sk_sndtimeo as conn_timeout
      Bluetooth: hci_core: Detect if an ISO link has stalled
      Bluetooth: MGMT: Fix not exposing debug UUID on MGMT_OP_READ_EXP_FEATURES_INFO
      Bluetooth: Add function and line information to bt_dbg
      Bluetooth: hci_core: Print number of packets in conn->data_q
      Bluetooth: hci_core: Print information of hcon on hci_low_sent
      Bluetooth: SCO: Fix UAF on sco_conn_free
      Bluetooth: ISO: Fix possible UAF on iso_conn_free
      Bluetooth: hci_sync: Fix using random address for BIG/PA advertisements

Luo Jie (12):
      dt-bindings: net: Add PPE for Qualcomm IPQ9574 SoC
      net: ethernet: qualcomm: Add PPE driver for IPQ9574 SoC
      net: ethernet: qualcomm: Initialize PPE buffer management for IPQ9574
      net: ethernet: qualcomm: Initialize PPE queue management for IPQ9574
      net: ethernet: qualcomm: Initialize the PPE scheduler settings
      net: ethernet: qualcomm: Initialize PPE queue settings
      net: ethernet: qualcomm: Initialize PPE service code settings
      net: ethernet: qualcomm: Initialize PPE port control settings
      net: ethernet: qualcomm: Initialize PPE RSS hash settings
      net: ethernet: qualcomm: Initialize PPE queue to Ethernet DMA ring mapping
      net: ethernet: qualcomm: Add PPE debugfs support for PPE counters
      MAINTAINERS: Add maintainer for Qualcomm PPE driver

Maciej Fijalkowski (3):
      xsk: avoid overwriting skb fields for multi-buffer traffic
      xsk: remove @first_frag from xsk_build_skb()
      xsk: wrap generic metadata handling onto separate function

Mahanta Jambigi (1):
      net/smc: Remove unused argument from 2 SMC functions

Maharaja Kennadyrajan (2):
      wifi: ath12k: enhance the WMI_PEER_STA_KICKOUT event with reasons and RSSI reporting
      wifi: ath12k: Extend beacon miss handling for MLO non-AP STA

Manish Dharanenthiran (2):
      wifi: ath12k: Add Retry Mechanism for REO RX Queue Update Failures
      wifi: ath12k: Use 1KB Cache Flush Command for QoS TID Descriptors

Marc Harvey (1):
      selftests: net: Add tests to verify team driver option set and get.

Marc Kleine-Budde (6):
      Merge patch series "can: rcar_canfd: R-Car CANFD Improvements"
      Merge patch series "can: rcar_can: Miscellaneous cleanups and improvements"
      Merge patch series "can: esd_usb: Fixes and improvements"
      Merge patch series "can: raw: optimize the sizes of struct uniqframe and struct raw_sock"
      Merge patch series "can: rework the CAN MTU logic (CAN XL preparation step 2/3)"
      Merge patch series "can: netlink: preparation before introduction of CAN XL step 3/3"

Marco Crivellari (5):
      net: replace use of system_unbound_wq with system_dfl_wq
      net: replace use of system_wq with system_percpu_wq
      net: WQ_PERCPU added to alloc_workqueue users
      wifi: libertas: WQ_PERCPU added to alloc_workqueue users
      wifi: libertas: add WQ_UNBOUND to alloc_workqueue users

Mark Bloch (1):
      net/mlx5: IFC add balance ID and LAG per MP group bits

Markus Heidelberg (2):
      net: ethtool: remove duplicated mm.o from Makefile
      docs: networking: phy: clarify abbreviation "PAL"

Markus Stockhausen (2):
      net: phy: realtek: convert RTL8226-CG to c45 only
      net: phy: realtek: enable serdes option mode for RTL8226-CG

Martin KaFai Lau (3):
      Merge branch 'bpf-next/skb-meta-dynptr' into 'bpf-next/net'
      Merge branch 'bpf-next/skb-meta-dynptr' into 'bpf-next/net'
      Merge branch 'bpf-next/xdp_pull_data' into 'bpf-next/net'

Martin Kaistra (1):
      wifi: rtl8xxxu: expose efuse via debugfs

Matthieu Baerts (NGI0) (38):
      selftests: mptcp: join: tolerate more ADD_ADDR
      selftests: mptcp: join: allow more time to send ADD_ADDR
      tools: ynl: fix undefined variable name
      tools: ynl: avoid bare except
      tools: ynl: remove assigned but never used variable
      tools: ynl: remove f-string without any placeholders
      tools: ynl: remove unused imports
      tools: ynl: remove unnecessary semicolons
      tools: ynl: use 'cond is None'
      tools: ynl: check for membership with 'not in'
      doc: mptcp: fix Netlink specs link
      mptcp: pm: netlink: fix if-idx type
      tools: ynl: rst: display attribute-set doc
      netlink: specs: team: avoid mangling multilines doc
      netlink: specs: explicitly declare block scalar strings
      mptcp: reset blackhole on success with non-loopback ifaces
      mptcp: pm: netlink: only add server-side attr when true
      mptcp: pm: netlink: announce server-side flag
      mptcp: pm: netlink: deprecate server-side attribute
      selftests: mptcp: pm: get server-side flag
      mptcp: use _BITUL() instead of (1 << x)
      mptcp: remove unused returned value of check_data_fin
      mptcp: pm: in-kernel: usable client side with C-flag
      selftests: mptcp: join: validate C-flag + def limit
      mptcp: pm: in-kernel: refactor fill_local_addresses_vec
      mptcp: pm: in-kernel: refactor fill_remote_addresses_vec
      mptcp: pm: rename 'subflows' to 'extra_subflows'
      mptcp: pm: in-kernel: rename 'subflows_max' to 'limit_extra_subflows'
      mptcp: pm: in-kernel: rename 'add_addr_signal_max' to 'endp_signal_max'
      mptcp: pm: in-kernel: rename 'add_addr_accept_max' to 'limit_add_addr_accepted'
      mptcp: pm: in-kernel: rename 'local_addr_max' to 'endp_subflow_max'
      mptcp: pm: in-kernel: rename 'local_addr_list' to 'endp_list'
      mptcp: pm: in-kernel: rename 'addrs' to 'endpoints'
      mptcp: pm: in-kernel: remove stale_loss_cnt
      mptcp: pm: in-kernel: reduce pernet struct size
      mptcp: pm: in-kernel: compare IDs instead of addresses
      mptcp: pm: in-kernel: add laminar endpoints
      selftests: mptcp: join: validate new laminar endp

Matvey Kovalev (1):
      wifi: ath11k: fix NULL dereference in ath11k_qmi_m3_load()

Mauro Carvalho Chehab (14):
      docs: netlink: netlink-raw.rst: use :ref: instead of :doc:
      tools: ynl_gen_rst.py: Split library from command line tool
      docs: netlink: index.rst: add a netlink index file
      tools: ynl_gen_rst.py: cleanup coding style
      docs: sphinx: add a parser for yaml files for Netlink specs
      docs: use parser_yaml extension to handle Netlink specs
      docs: uapi: netlink: update netlink specs link
      tools: ynl_gen_rst.py: drop support for generating index files
      docs: netlink: remove obsolete .gitignore from unused directory
      MAINTAINERS: add netlink_yml_parser.py to linux-doc
      tools: netlink_yml_parser.py: add line numbers to parsed data
      docs: parser_yaml.py: add support for line numbers from the parser
      docs: parser_yaml.py: fix backward compatibility with old docutils
      sphinx: parser_yaml.py: fix line numbers information

Mengyuan Lou (1):
      Wangxun: vf: Implement some ethtool apis for get_xxx

Miaoqian Lin (1):
      wifi: iwlwifi: Fix dentry reference leak in iwl_mld_add_link_debugfs

Michael Chan (4):
      bnxt_en: hsi: Update FW interface to 1.10.3.133
      bnxt_en: Improve bnxt_backing_store_cfg_v2()
      bnxt_en: Implement ethtool .get_tunable() for ETHTOOL_PFC_PREVENTION_TOUT
      bnxt_en: Implement ethtool .set_tunable() for ETHTOOL_PFC_PREVENTION_TOUT

Michael Dege (4):
      net: renesas: rswitch: rename rswitch.c to rswitch_main.c
      net: renesas: rswitch: configure default ageing time
      net: renesas: rswitch: add offloading for L2 switching
      net: renesas: rswitch: add modifiable ageing time

Michael S. Tsirkin (3):
      ptr_ring: drop duplicated tail zeroing code
      vhost: vringh: Fix copy_to_iter return value check
      ptr_ring: __ptr_ring_zero_tail micro optimization

Michal Kubiak (6):
      idpf: add 4-byte completion descriptor definition
      idpf: remove SW marker handling from NAPI
      idpf: prepare structures to support XDP
      idpf: implement XDP_SETUP_PROG in ndo_bpf for splitq
      idpf: add virtchnl functions to manage selected queues
      idpf: add XSk pool initialization

Michal Swiatkowski (15):
      ice: make fwlog functions static
      ice: move get_fwlog_data() to fwlog file
      ice: drop ice_pf_fwlog_update_module()
      ice: introduce ice_fwlog structure
      ice: add pdev into fwlog structure and use it for logging
      ice: allow calling custom send function in fwlog
      ice: move out debugfs init from fwlog
      ice: check for PF number outside the fwlog code
      ice: drop driver specific structure from fwlog code
      libie, ice: move fwlog admin queue to libie
      ice: move debugfs code to fwlog
      ice: prepare for moving file to libie
      ice: reregister fwlog after driver reinit
      ice, libie: move fwlog code to libie
      ixgbe: fwlog support for e610

Miguel García (3):
      tun: replace strcpy with strscpy for ifr_name
      xfrm: xfrm_user: use strscpy() for alg_name
      ipv6: ip6_gre: replace strcpy with strscpy for tunnel name

Milena Olech (1):
      idpf: add HW timestamping statistics

Mina Almasry (1):
      gve: support unreadable netmem

Ming Yen Hsieh (3):
      wifi: mt76: mt7925: add MBSSID support
      wifi: mt76: mt7921: add MBSSID support
      wifi: mt76: mt7925: refine the txpower initialization flow

Mingming Cao (1):
      ibmvnic: Increase max subcrq indirect entries with fallback

Miri Korenblit (50):
      wifi: iwlwifi: mld: cleanup cipher lookup in resume
      wifi: iwlwifi: mvm: cleanup cipher lookup in resume
      wifi: iwlwifi: mld: support MLO rekey on resume
      wifi: iwlwifi: mld: track BIGTK per link
      wifi: iwlwifi: mvm/mld: correctly retrieve the keyidx from the beacon
      wifi: iwlwifi: mld/mvm: set beacon protection capability in wowlan config
      wifi: iwlwifi: mvm: remove a function declaration
      wifi: iwlwifi: bump MIN API in HR/GF/BZ/SC/DR
      Reapply "wifi: iwlwifi: remove support of several iwl_ppag_table_cmd versions"
      wifi: iwlwifi: make ppag versioning clear
      wifi: iwlwifi: mld: don't consider old versions of PPAG
      wifi: iwlwifi: mld: refactor iwl_mld_add_all_rekeys
      wifi: iwlwifi: mld: rename iwl_mld_set_key_rx_seq
      wifi: iwlwifi: mld: don't validate keys state on resume
      wifi: iwlwifi: mld: don't check the cipher on resume
      wifi: iwlwifi: mvm: remove d3 test code
      wifi: iwlwifi: remove dump file name extension support
      wifi: iwlwifi: trans: remove d3 test code
      wifi: iwlwifi: trans: remove STATUS_SUSPENDED
      wifi: iwlwifi: simplify iwl_trans_pcie_d3_resume
      wifi: iwlwifi: mld: don't modify trans state where not needed
      wifi: iwlwifi: refactor iwl_pnvm_get_from_fs
      wifi: iwlwifi: remove .pnvm files from module info
      wifi: iwlwifi: trans: move dev_cmd_pool to trans specific
      wifi: iwlwifi: don't publish TWT capabilities
      wifi: iwlwifi: remove unneeded jacket indication
      wifi: iwlwifi: really remove hw_wfpm_id
      wifi: iwlwifi: gen1_2: rename iwl_trans_pcie_op_mode_enter
      wifi: iwlwifi: gen1_2: move gen specific code to a function
      wifi: iwlwifi: mld: support TLC command version 5
      wifi: iwlwifi: pcie: remember when interrupts are disabled
      wifi: iwlwifi: mld: make iwl_mld_rm_vif void
      wifi: iwlwifi: carefully select the PNVM source
      wifi: iwlwifi: mld: remove a TODO
      wifi: iwlwifi: don't support WH a step
      wifi: mac80211: count reg connection element in the size
      wifi: mac80211: reduce the scope of link_id
      wifi: mac80211: reduce the scope of rts_threshold
      wifi: iwlwifi: rename iwl_finish_nic_init
      wifi: iwlwifi: pcie: move pm_support to the specific transport
      wifi: iwlwifi: pcie: move ltr_enabled to the specific transport
      wifi: iwlwifi: api: add a flag to iwl_link_ctx_modify_flags
      wifi: iwlwifi: mld: don't consider phy cmd version 5
      wifi: iwlwifi: mld: remove support of mac cmd ver 2
      wifi: iwlwifi: mld: remove support of roc cmd version 5
      wifi: iwlwifi: mld: remove support from of sta cmd version 1
      wifi: iwlwifi: mld: remove support of iwl_esr_mode_notif version 1
      wifi: iwlwifi: mld: CHANNEL_SURVEY_NOTIF is always supported
      wifi: cfg80211: update the time stamps in hidden ssid
      wifi: mac80211: fix incorrect comment

Miroslav Lichvar (1):
      ptp: Limit time setting of PTP clocks

Mohsin Bashir (17):
      eth: fbnic: Add support for HDS configuration
      eth: fbnic: Update Headroom
      eth: fbnic: Use shinfo to track frags state on Rx
      eth: fbnic: Prefetch packet headers on Rx
      eth: fbnic: Add XDP pass, drop, abort support
      eth: fbnic: Add support for XDP queues
      eth: fbnic: Add support for XDP_TX action
      eth: fbnic: Collect packet statistics for XDP
      eth: fbnic: Report XDP stats via ethtool
      eth: fbnic: Move hw_stats_lock out of fbnic_dev
      eth: fbnic: Reset hw stats upon PCI error
      eth: fbnic: Reset MAC stats
      eth: fbnic: Fetch PHY stats from device
      eth: fbnic: Read PHY stats via the ethtool API
      eth: fbnic: Add pause stats support
      eth: fbnic: Read module EEPROM
      eth: fbnic: Add support to read lane count

Moshe Shemesh (2):
      net/mlx5: Stop polling for command response if interface goes down
      net/mlx5: fw reset, add reset timeout work

Muhammad Usama Anjum (1):
      wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again

Muna Sinada (1):
      wifi: nl80211: Add EHT fixed Tx rate support

Nai-Chen Cheng (1):
      selftests/Makefile: include $(INSTALL_DEP_TARGETS) in clean target to clean net/lib dependency

Nick Morrow (2):
      wifi: mt76: mt7925u: Add VID/PID for Netgear A9000
      wifi: mt76: mt7921u: Add VID/PID for Netgear A7500

Nidhish A N (1):
      wifi: iwlwifi: fw: Add ASUS to PPAG and TAS list

Niklas Söderlund (5):
      net: sh_eth: Disable WoL if system can not suspend
      net: ethernet: renesas: rcar_gen4_ptp: Remove different memory layout
      net: ethernet: renesas: rcar_gen4_ptp: Hide register layout
      net: ethernet: renesas: rcar_gen4_ptp: Use lockdep to verify internal usage
      net: ravb: Fix -Wmaybe-uninitialized warning

Nithyanantham Paramasivam (5):
      wifi: ath12k: Increase DP_REO_CMD_RING_SIZE to 256
      wifi: ath12k: Refactor RX TID deletion handling into helper function
      wifi: ath12k: Refactor RX TID buffer cleanup into helper function
      wifi: ath12k: Refactor REO command to use ath12k_dp_rx_tid_rxq
      wifi: ath12k: Fix flush cache failure during RX queue update

Oleksij Rempel (7):
      net: stmmac: Correctly handle Rx checksum offload errors
      net: stmmac: dwmac4: report Rx checksum errors in status
      net: stmmac: dwmac4: stop hardware from dropping checksum-error packets
      net: usb: lan78xx: add support for generic net selftests via ethtool
      net: phy: clear EEE runtime state in PHY_HALTED/PHY_ERROR
      net: phy: clear link parameters on admin link down
      Documentation: net: add flow control guide and document ethtool API

Onur Özkan (1):
      rust: phy: use to_result for error handling

Oscar Maes (2):
      net: ipv4: allow directed broadcast routes to use dst hint
      selftests: net: add test for dst hint mechanism with directed broadcast addresses

Pagadala Yesu Anjaneyulu (2):
      wifi: iwlwifi: mvm: remove MLO code
      wifi: iwlwifi: add kunit tests for nvm parse

Paolo Abeni (39):
      Merge branch 'net-ethtool-support-including-flow-label-in-the-flow-hash-for-rss'
      Merge branch 'eth-fbnic-add-xdp-support-for-fbnic'
      Merge branch 'net-macb-add-taprio-traffic-scheduling-support'
      Merge tag 'mlx5-next-vhca-id' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge branch 'net-phy-micrel-add-support-for-lan8842'
      Merge branch 'add-ppe-driver-for-qualcomm-ipq9574-soc'
      Merge branch 'net-better-drop-accounting'
      Merge branch 'add-si3474-pse-controller-driver'
      Merge branch 'fbnic-synchronize-address-handling-with-bmc'
      Merge branch 'add-netc-timer-ptp-driver-and-add-ptp-support-for-i-mx95'
      Merge branch 'e-switch-vport-sharing-delegation'
      Merge branch 'net-renesas-rswitch-r-car-s4-add-hw-offloading-for-layer-2-switching'
      Merge branch 'eth-fbnic-support-queue-api-and-zero-copy-rx'
      Merge branch 'support-exposing-raw-cycle-counters-in-ptp-and-mlx5'
      Merge branch 'bonding-support-aggregator-selection-based-on-port-priority'
      Merge branch 'net-xdp-handle-frags-with-unreadable-memory'
      Merge branch 'ipv4-icmp-fix-source-ip-derivation-in-presence-of-vrfs'
      Merge branch 'net-hinic3-add-a-driver-for-huawei-3rd-gen-nic-sw-and-hw-initialization'
      Merge branch 'add-ethernet-mac-support-for-spacemit-k1'
      Merge branch 'accecn-protocol-patch-series'
      Merge branch 'udp-increase-rx-performance-under-stress'
      Merge branch 'eth-fbnic-add-devlink-health-support-for-fw-crashes-and-otp-mem-corruptions'
      Merge branch 'add-basic-psp-encryption-for-tcp-connections'
      Merge branch 'bnxt_en-updates-for-net-next'
      Merge branch 'tcp-update-bind-bucket-state-on-port-release'
      Merge branch 'dibs-direct-internal-buffer-sharing'
      Merge branch 'net-gso-restore-outer-ip-ids-correctly'
      mptcp: leverage skb deferral free
      tcp: make tcp_rcvbuf_grow() accessible to mptcp code
      mptcp: rcvbuf auto-tuning improvement
      mptcp: introduce the mptcp_init_skb helper
      mptcp: remove unneeded mptcp_move_skb()
      mptcp: factor out a basic skb coalesce helper
      mptcp: minor move_skbs_to_msk() cleanup
      Merge branch 'psp-add-a-kselftest-suite-and-netdevsim-implementation'
      Merge branch 'net-lockless-skb_attempt_defer_free'
      Revert "Documentation: net: add flow control guide and document ethtool API"
      Merge branch 'net-stmmac-add-support-for-allwinner-a523-gmac200'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Parav Pandit (2):
      devlink/port: Simplify return checks
      devlink/port: Check attributes early and constify

Parthiban Veerasooran (1):
      microchip: lan865x: add ndo_eth_ioctl handler to enable PHY ioctl support

Parvathi Pudi (3):
      dt-bindings: net: ti: Adds DUAL-EMAC mode support on PRU-ICSS2 for AM57xx, AM43xx and AM33xx SOCs
      net: ti: icssm-prueth: Adds IEP support for PRUETH on AM33x, AM43x and AM57x SOCs
      MAINTAINERS: Add entries for ICSSM Ethernet driver

Patrisious Haddad (1):
      net/mlx5: Improve write-combining test reliability for ARM64 Grace CPUs

Paul Greenwalt (2):
      ice: move ice_qp_[ena|dis] for reuse
      ice: add E830 Earliest TxTime First Offload support

Pauli Virtanen (2):
      Bluetooth: ISO: free rx_skb if not consumed
      Bluetooth: ISO: don't leak skb in ISO_CONT RX

Pavan Chebbi (1):
      bnxt_en: Add Hyper-V VF ID

Pengtao He (1):
      net: avoid one loop iteration in __skb_splice_bits

Peter Chiu (2):
      wifi: mt76: mt7996: disable promiscuous mode by default
      wifi: mt76: mt7996: set VTA in txwi

Petr Machata (25):
      net: bridge: Introduce BROPT_FDB_LOCAL_VLAN_0
      net: bridge: BROPT_FDB_LOCAL_VLAN_0: Look up FDB on VLAN 0 on miss
      net: bridge: BROPT_FDB_LOCAL_VLAN_0: On port changeaddr, skip per-VLAN FDBs
      net: bridge: BROPT_FDB_LOCAL_VLAN_0: On bridge changeaddr, skip per-VLAN FDBs
      net: bridge: BROPT_FDB_LOCAL_VLAN_0: Skip local FDBs on VLAN creation
      net: bridge: Introduce UAPI for BR_BOOLOPT_FDB_LOCAL_VLAN_0
      selftests: defer: Allow spaces in arguments of deferred commands
      selftests: defer: Introduce DEFER_PAUSE_ON_FAIL
      selftests: net: lib.sh: Don't defer failed commands
      selftests: forwarding: Add test for BR_BOOLOPT_FDB_LOCAL_VLAN_0
      net: bridge: Install FDB for bridge MAC on VLAN 0
      selftests: bridge_fdb_local_vlan_0: Test FDB vs. NET_ADDR_SET behavior
      selftests: net: lib: Rename ip_link_add() to adf_*
      selftests: net: lib: Rename ip_link_set_master() to adf_*
      selftests: net: lib: Rename ip_link_set_addr() to adf_*
      selftests: net: lib: Rename ip_link_set_up() to adf_*
      selftests: net: lib: Rename ip_link_set_down() to adf_*
      selftests: net: lib: Rename ip_addr_add() to adf_*
      selftests: net: lib: Rename ip_route_add() to adf_*
      selftests: net: lib: Rename bridge_vlan_add() to adf_*
      selftests: net: vlan_bridge_binding: Rename dfr_set_binding_*() to adf_*
      selftests: forwarding: lib: Add an autodefer variant of vrf_prepare()
      selftests: forwarding: lib: Add an autodefer variant of simple_if_init()
      selftests: forwarding: lib: Add an autodefer variant of forwarding_enable()
      selftests: forwarding: README: Mention defer, adf_

Ping-Ke Shih (16):
      wifi: rtw88: sdio: use indirect IO for device registers before power-on
      wifi: rtw89: print just once for unknown C2H events
      wifi: rtw89: add dummy C2H handlers for BCN resend and update done
      wifi: rtw89: 8852c: update firmware crash trigger type for newer firmware
      wifi: rtw89: pci: move chip ISR definition out from chip generation
      wifi: rtw89: pci: prepare interrupt related registers and functions for 8922DE
      wifi: rtw89: pci: use RDU status of R_BE_PCIE_DMA_IMR_0_V1 instead for 8922DE
      wifi: rtw89: pci: add struct rtw89_{tx,rx}_rings to put related fields
      wifi: rtw89: pci: define TX/RX buffer descriptor pool
      wifi: rtw89: pci: add group BD address design
      wifi: rtw89: pci: abstract RPP parser
      wifi: rtw89: pci: add RPP parser v1
      wifi: rtw89: abstract getting function of DMA channel
      wifi: rtw89: add getting function of DMA channel v1
      wifi: rtw89: use ieee80211_tx_info::driver_data to store driver TX info
      wifi: rtw89: phy: initialize AFE by firmware element table

Piotr Kubik (2):
      dt-bindings: net: pse-pd: Add bindings for Si3474 PSE controller
      net: pse-pd: Add Si3474 PSE controller driver

Piotr Kwapulinski (1):
      ixgbe: add the 2.5G and 5G speeds in auto-negotiation for E610

Po-Hao Huang (2):
      wifi: rtw89: 8852a: report per-channel noise level by get_survey ops
      wifi: rtw89: 8852a: report average RSSI to avoid unnecessary scanning

Praveen Balakrishnan (1):
      selftests: net: fix spelling and grammar mistakes

Przemek Kitszel (14):
      ice: add virt/ and move ice_virtchnl* files there
      ice: split queue stuff out of virtchnl.c - tmp rename
      ice: split queue stuff out of virtchnl.c - copy back
      Merge branch 'add-virt/queues.c' into HEAD
      ice: extract virt/queues.c: cleanup - p1
      ice: extract virt/queues.c: cleanup - p2
      ice: extract virt/queues.c: cleanup - p3
      ice: finish virtchnl.c split into queues.c
      ice: split RSS stuff out of virtchnl.c - tmp rename
      ice: split RSS stuff out of virtchnl.c - copy back
      Merge branch 'add-virt/rss.c' into HEAD
      ice: extract virt/rss.c: cleanup - p1
      ice: extract virt/rss.c: cleanup - p2
      ice: finish virtchnl.c split into rss.c

Qianfeng Rong (11):
      tcp: cdg: remove redundant __GFP_NOWARN
      RDS: remove redundant __GFP_NOWARN
      eth: intel: use vmalloc_array() to simplify code
      nfp: flower: use vmalloc_array() to simplify code
      ppp: use vmalloc_array() to simplify code
      net: hns3: use kcalloc() instead of kzalloc()
      amd-xgbe: Use int type to store negative error codes
      net: wwan: iosm: use int type to store negative error codes
      wifi: rtw89: use int type to store negative error codes
      netfilter: ebtables: Use vmalloc_array() to improve code
      net: dsa: dsa_loop: use int type to store negative error codes

Qingfang Deng (4):
      ppp: remove rwlock usage
      pppoe: remove rwlock usage
      pppoe: drop sock reference counting on fast path
      6pack: drop redundant locking and refcounting

Quan Zhou (1):
      wifi: mt76: mt7921: Add 160MHz beamformee capability for mt7922 device

Raed Salem (9):
      net/mlx5e: Support PSP offload functionality
      net/mlx5e: Implement PSP operations .assoc_add and .assoc_del
      psp: provide encapsulation helper for drivers
      net/mlx5e: Implement PSP Tx data path
      net/mlx5e: Add PSP steering in local NIC RX
      net/mlx5e: Configure PSP Rx flow steering rules
      psp: provide decapsulation and receive helper for drivers
      net/mlx5e: Add Rx data path offload
      net/mlx5e: Implement PSP key_rotate operation

Raju Rangoju (1):
      amd-xgbe: Add PPS periodic output support

Ramya Gnanasekar (1):
      wifi: mac80211: Fix 6 GHz Band capabilities element advertisement in lower bands

Rex Lu (8):
      wifi: mt76: Differentiate between RRO data and RRO MSDU queues
      wifi: mt76: mt7996: Initial DMA configuration for MT7992 WED support
      wifi: mt76: mt7996: Enable HW RRO for MT7992 chipset
      wifi: mt76: mt7996: Introduce the capability to reset MT7992 WED device
      wifi: mt76: mt7996: Enable WED for MT7992 chipset
      wifi: mt76: mt7996: Introduce RRO MSDU callbacks
      wifi: mt76: mt7996: Decouple RRO logic from WED support
      wifi: mt76: mt7996: Add SW path for HW-RRO v3.1

Richard Gobert (5):
      net: gro: remove is_ipv6 from napi_gro_cb
      net: gro: only merge packets with incrementing or fixed outer ids
      net: gso: restore ids of outer ip headers correctly
      net: gro: remove unnecessary df checks
      selftests/net: test ipip packets in gro.sh

Rob Herring (Arm) (4):
      dt-bindings: net: Convert apm,xgene-enet to DT schema
      dt-bindings: net: Convert APM XGene MDIO to DT schema
      dt-bindings: net: Drop duplicate brcm,bcm7445-switch-v4.0.txt
      wifi: ath: Use of_reserved_mem_region_to_resource() for "memory-region"

Robert Marko (2):
      net: ethernet: microchip: sparx5: make it selectable for ARCH_LAN969X
      dt-bindings: net: sparx5: correct LAN969x register space windows

Roger Quadros (3):
      net: ti: icssm-prueth: Adds ICSSM Ethernet driver
      net: ti: icssm-prueth: Adds PRUETH HW and SW configuration
      net: ti: icssm-prueth: Adds link detection, RX and TX support.

Rohan G Thomas (3):
      net: phy: marvell: Fix 88e1510 downshift counter errata
      net: stmmac: est: Drop frames causing HLBS error
      net: stmmac: tc: Add HLBS drop count to taprio stats

Roopni Devanathan (1):
      wifi: ath12k: Add support to set per-radio RTS threshold

Rosen Penev (1):
      wifi: mt76: mt76_eeprom_override to int

Rotem Kerem (3):
      wifi: iwlwifi: add STATUS_FW_ERROR API
      wifi: iwlwifi: replace SUPPRESS_CMD_ERROR_ONCE status bit with a boolean
      wifi: iwlwifi: implement wowlan status notification API update

Russell King (2):
      net: mvneta: add support for hardware timestamps
      net: mvpp2: add support for hardware timestamps

Russell King (Oracle) (85):
      net: stmmac: add suspend()/resume() platform ops
      net: stmmac: provide a set of simple PM ops
      net: stmmac: platform: legacy hooks for suspend()/resume() methods
      net: stmmac: intel: convert to suspend()/resume() methods
      net: stmmac: loongson: convert to suspend()/resume() methods
      net: stmmac: pci: convert to suspend()/resume() methods
      net: stmmac: rk: convert to suspend()/resume() methods
      net: stmmac: stm32: convert to suspend()/resume() methods
      net: stmmac: mediatek: convert to resume() method
      net: phy: realtek: fix RTL8211F wake-on-lan support
      dt-bindings: net: realtek,rtl82xx: document wakeup-source property
      net: stmmac: remove unnecessary checks in ethtool eee ops
      net: stmmac: remove write-only mac->pmt
      net: stmmac: remove redundant WoL option validation
      net: stmmac: remove unnecessary "stmmac: wakeup enable" print
      net: stmmac: use core wake IRQ support
      net: stmmac: add helpers to indicate WoL enable status
      net: stmmac: explain the phylink_speed_down() call in stmmac_release()
      net: stmmac: fix stmmac_simple_pm_ops build errors
      net: stmmac: mdio: use netdev_priv() directly
      net: stmmac: minor cleanups to stmmac_bus_clks_config()
      net: stmmac: mdio: clean up c22/c45 accessor split
      net: stmmac: mdio: update runtime PM
      net: mvpp2: add xlg pcs inband capabilities
      net: stmmac: ptp: conditionally populate getcrosststamp() method
      net: stmmac: intel: only populate plat->crosststamp when supported
      net: stmmac: mdio: provide address register formatter
      net: stmmac: mdio: provide stmmac_mdio_wait()
      net: stmmac: mdio: provide priv->gmii_address_bus_config
      net: stmmac: mdio: move stmmac_mdio_format_addr() into read/write
      net: stmmac: mdio: merge stmmac_mdio_read() and stmmac_mdio_write()
      net: stmmac: mdio: move runtime PM into stmmac_mdio_access()
      net: stmmac: mdio: improve mdio register field definitions
      net: stmmac: mdio: move initialisation of priv->clk_csr to stmmac_mdio
      net: stmmac: mdio: return clk_csr value from stmmac_clk_csr_set()
      net: stmmac: mdio: remove redundant clock rate tests
      net: stmmac: use STMMAC_CSR_xxx definitions in platform glue
      net: stmmac: dwc-qos: use PHY WoL
      net: dsa: mv88e6xxx: remove mv88e6250_ptp_ops
      net: dsa: mv88e6xxx: remove chip->trig_config
      net: dsa: mv88e6xxx: remove chip->evcap_config
      net: dsa: mv88e6xxx: remove unused support for PPS event capture
      net: stmmac: ptp: improve handling of aux_ts_lock lifetime
      net: stmmac: disable PTP clock after unregistering PTP
      net: stmmac: fix PTP error cleanup in __stmmac_open()
      net: stmmac: fix stmmac_xdp_open() clk_ptp_ref error cleanup
      net: stmmac: unexport stmmac_init_tstamp_counter()
      net: stmmac: add __stmmac_release() to complement __stmmac_open()
      net: stmmac: move stmmac_init_ptp() messages into function
      net: stmmac: rename stmmac_init_ptp()
      net: stmmac: add stmmac_setup_ptp()
      net: stmmac: move PTP support check into stmmac_init_timestamping()
      net: stmmac: move timestamping/ptp init to stmmac_hw_setup() caller
      net: dsa: mv88e6xxx: clean up PTP clock during setup failure
      ptp: describe the two disables in ptp_set_pinfunc()
      ptp: rework ptp_clock_unregister() to disable events
      net: dsa: mv88e6xxx: rename TAI definitions according to core
      net: dsa: mv88e6xxx: remove unused TAI definitions
      net: dsa: mv88e6xxx: remove duplicated register definition
      net: dsa: mv88e6xxx: remove unused 88E6165 register definitions
      net: dsa: mv88e6xxx: move mv88e6xxx_hwtstamp_work() prototype
      net: stmmac: rework mac_interface and phy_interface documentation
      net: stmmac: use phy_interface in stmmac_check_pcs_mode()
      net: stmmac: imx: convert to use phy_interface
      net: stmmac: ingenic: convert to use phy_interface
      net: stmmac: socfpga: convert to use phy_interface
      net: stmmac: starfive: convert to use phy_interface
      net: stmmac: stm32: convert to use phy_interface
      net: stmmac: sun8i: convert to use phy_interface
      net: stmmac: thead: convert to use phy_interface
      net: stmmac: remove mac_interface
      net: phy: add phy_interface_copy()
      net: sfp: pre-parse the module support
      net: sfp: convert sfp quirks to modify struct sfp_module_support
      net: sfp: provide sfp_get_module_caps()
      net: phylink: use sfp_get_module_caps()
      net: phy: update all PHYs to use sfp_get_module_caps()
      net: sfp: remove old sfp_parse_* functions
      net: stmmac: move stmmac_bus_clks_config() to stmmac_platform.c
      net: stmmac: move xpcs clause 73 test into stmmac_init_phy()
      net: stmmac: move PHY attachment error message into stmmac_init_phy()
      net: stmmac: move initialisation of priv->tx_lpi_timer to stmmac_open()
      net: stmmac: move PHY handling out of __stmmac_open()/release()
      net: stmmac: simplify stmmac_init_phy()
      net: stmmac: remove stmmac_hw_setup() excess documentation parameter

Ryder Lee (1):
      wifi: cfg80211: fix width unit in cfg80211_radio_chandef_valid()

Sabrina Dubroca (13):
      macsec: replace custom checks on MACSEC_SA_ATTR_AN with NLA_POLICY_MAX
      macsec: replace custom checks on MACSEC_*_ATTR_ACTIVE with NLA_POLICY_MAX
      macsec: replace custom checks on MACSEC_SA_ATTR_SALT with NLA_POLICY_EXACT_LEN
      macsec: replace custom checks on MACSEC_SA_ATTR_KEYID with NLA_POLICY_EXACT_LEN
      macsec: use NLA_POLICY_MAX_LEN for MACSEC_SA_ATTR_KEY
      macsec: use NLA_UINT for MACSEC_SA_ATTR_PN
      macsec: remove validate_add_rxsc
      macsec: add NLA_POLICY_MAX for MACSEC_OFFLOAD_ATTR_TYPE and IFLA_MACSEC_OFFLOAD
      macsec: replace custom checks on IFLA_MACSEC_ICV_LEN with NLA_POLICY_RANGE
      macsec: use NLA_POLICY_VALIDATE_FN to validate IFLA_MACSEC_CIPHER_SUITE
      macsec: validate IFLA_MACSEC_VALIDATION with NLA_POLICY_MAX
      macsec: replace custom checks for IFLA_MACSEC_* flags with NLA_POLICY_MAX
      macsec: replace custom check on IFLA_MACSEC_ENCODING_SA with NLA_POLICY_MAX

Saeed Mahameed (11):
      net/mlx5: mlx5_ifc, Add hardware definitions needed for adjacent vports
      net/mlx5: E-Switch, Cache vport vhca id on first cap query
      net/mlx5: E-Switch, Set/Query hca cap via vhca id
      {rdma,net}/mlx5: export mlx5_vport_get_vhca_id
      net/mlx5: FS, Convert vport acls root namespaces to xarray
      net/mlx5: E-Switch, Move vport acls root namespaces creation to eswitch
      net/mlx5: E-Switch, Create acls root namespace for adjacent vports
      net/mlx5: E-Switch, Register representors for adjacent vports
      net/mlx5: {DR,HWS}, Use the cached vhca_id for this device
      net/mlx5: Add PSP capabilities structures and bits
      net/mlx5: Implement cqe_compress_type via devlink params

Sarika Sharma (3):
      wifi: mac80211: fix reporting of all valid links in sta_set_sinfo()
      wifi: mac80211: add tx_handlers_drop statistics to ethtool
      wifi: mac80211: remove tx_handlers_drop debugfs stats

Sathesh B Edara (2):
      octeon_ep: Add support to retrieve hardware channel information
      octeon_ep_vf: Add support to retrieve hardware channel information

Saurabh Sengar (1):
      net: mana: Remove redundant netdev_lock_ops_to_full() calls

Sebastian Andrzej Siewior (3):
      netfilter: nft_set_pipapo_avx2: Drop the comment regarding protection
      netfilter: nft_set_pipapo: Store real pointer, adjust later.
      netfilter: nft_set_pipapo: Use nested-BH locking for nft_pipapo_scratch

Shahar Shitrit (5):
      devlink: Move graceful period parameter to reporter ops
      devlink: Move health reporter recovery abort logic to a separate function
      devlink: Introduce burst period for health reporter
      devlink: Make health reporter burst period configurable
      net/mlx5e: Set default burst period for TX and RX reporters

Shay Drory (5):
      net/mlx5: Refactor devcom to use match attributes
      net/mlx5: Lag, move devcom registration to LAG layer
      net/mlx5: Add net namespace support to devcom
      net/mlx5: Lag, add net namespace support
      net/mlx5: pagealloc: Fix reclaim race during command interface teardown

Shayne Chen (3):
      wifi: mt76: mt7996: Fix mt7996_reverse_frag0_hdr_trans for MLO
      wifi: mt76: mt7996: Implement MLD address translation for EAPOL
      wifi: mt76: mt7996: Export MLO AP capabilities to mac80211

Shenwei Wang (6):
      net: fec: use a member variable for maximum buffer size
      net: fec: add pagepool_order to support variable page size
      net: fec: update MAX_FL based on the current MTU
      net: fec: add rx_frame_size to support configurable RX length
      net: fec: add change_mtu to support dynamic buffer allocation
      net: fec: enable the Jumbo frame support for i.MX8QM

Shruti Parab (4):
      bnxt_en: Refactor bnxt_get_regs()
      bnxt_en: Add pcie_stat_len to struct bp
      bnxt_en: Add pcie_ctx_v2 support for ethtool -d
      bnxt_en: Add fw log trace support for 5731X/5741X chips

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sky Huang (1):
      net: phy: mtk-2p5ge: Add LED support for MT7988

Slavin Liu (1):
      ipvs: Defer ip_vs_ftp unregister during netns cleanup

Somashekhar Puttagangaiah (2):
      wifi: iwlwifi: mld: trigger mlo scan only when not in EMLSR
      wifi: iwlwifi: mld: Add debug log for second link

Sriram R (1):
      wifi: ath12k: Add fallback for invalid channel number in PHY metadata

Stanislav Fomichev (11):
      net: Add skb_dstref_steal and skb_dstref_restore
      xfrm: Switch to skb_dstref_steal to clear dst_entry
      netfilter: Switch to skb_dstref_steal to clear dst_entry
      net: Switch to skb_dstref_steal/skb_dstref_restore for ip_route_input callers
      staging: octeon: Convert to skb_dst_drop
      chtls: Convert to skb_dst_reset
      net: Add skb_dst_check_unset
      selftests: ncdevmem: don't retry EFAULT
      net: devmem: expose tcp_recvmsg_locked errors
      selftests: ncdevmem: remove sleep on rx
      selftests: drv-net: Enable BTF

Stefan Kerkmann (3):
      wifi: mwifiex: add rgpower table loading support
      wifi: mwifiex: send world regulatory domain to driver
      wifi: mwifiex: fix endianness handling in mwifiex_send_rgpower_table

Stefan Mätje (2):
      can: esd_usb: Rework display of error messages
      can: esd_usb: Avoid errors triggered from USB disconnect

Stefan Wahren (2):
      microchip: lan865x: Enable MAC address validation
      ethernet: Extend device_get_mac_address() to use NVMEM

Steven Rostedt (1):
      wifi: cfg80211: Remove unused tracepoints

Stéphane Grosjean (1):
      can: peak: Modification of references to email accounts being deleted

Suraj Gupta (1):
      net: xilinx: axienet: Fix kernel-doc warnings for missing return descriptions

Sven Eckelmann (3):
      batman-adv: remove network coding support
      batman-adv: keep skb crc32 helper local in BLA
      batman-adv: remove includes for extern declarations

Tariq Toukan (1):
      net/mlx5: Add IFC bit for TIR/SQ order capability

Thomas Weißschuh (2):
      ice: Don't use %pK through printk or tracepoints
      net/mlx5: Don't use %pK through tracepoints

Thorsten Blum (7):
      caif: Replace memset(0) + strscpy() with strscpy_pad()
      net/sched: Remove redundant memset(0) call in reset_policy()
      net: Space: Replace memset(0) + strscpy() with strscpy_pad()
      net: pktgen: Use min()/min_t() to improve pktgen_finalize_skb()
      net: phy: ax88796b: Replace hard-coded values with PHY_ID_MATCH_MODEL()
      Bluetooth: Annotate struct hci_drv_rp_read_info with __counted_by_le()
      Bluetooth: btintel_pcie: Use strscpy() instead of strscpy_pad()

Théo Lebrun (5):
      dt-bindings: net: cdns,macb: allow tsu_clk without tx_clk
      net: macb: remove illusion about TBQPH/RBQPH being per-queue
      net: macb: move ring size computation to functions
      net: macb: single dma_alloc_coherent() for DMA descriptors
      net: macb: avoid dealing with endianness in macb_set_hwaddr()

Tiezhu Yang (3):
      net: stmmac: Check stmmac_hw_setup() in stmmac_resume()
      net: stmmac: Change first parameter of fix_soc_reset()
      net: stmmac: Return early if invalid in loongson_dwmac_fix_reset()

Ujwal Kundur (4):
      rds: Replace POLLERR with EPOLLERR
      rds: Fix endianness annotation of jhash wrappers
      rds: Fix endianness annotation for RDS_MPATH_HASH
      rds: Fix endianness annotations for RDS extension headers

Vadim Fedorenko (7):
      ptp_ocp: make ptp_ocp driver compatible with PTP_EXTTS_REQUEST2
      net: ethtool: tsconfig: set command must provide a reply
      tg3: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
      bnxt_en: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
      selftests: drv-net: add HW timestamping tests
      ethtool: add FEC bins histogram report
      selftests: net-drv: stats: sanity check FEC histogram

Victor Nogueira (1):
      selftests/tc-testing: Adapt tc police action tests for Gb rounding changes

Vincent Mailhol (29):
      MAINTAINERS: update Vincent Mailhol's email address
      can: dev: sort includes by alphabetical order
      can: raw: reorder struct uniqframe's members to optimise packing
      can: raw: use bitfields to store flags in struct raw_sock
      can: raw: reorder struct raw_sock's members to optimise packing
      can: annotate mtu accesses with READ_ONCE()
      can: dev: turn can_set_static_ctrlmode() into a non-inline function
      can: populate the minimum and maximum MTU values
      can: enable CAN XL for virtual CAN devices by default
      can: dev: move struct data_bittiming_params to linux/can/bittiming.h
      can: dev: make can_get_relative_tdco() FD agnostic and move it to bittiming.h
      can: netlink: document which symbols are FD specific
      can: netlink: refactor can_validate_bittiming()
      can: netlink: add can_validate_tdc()
      can: netlink: add can_validate_databittiming()
      can: netlink: refactor CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
      can: netlink: remove useless check in can_tdc_changelink()
      can: netlink: make can_tdc_changelink() FD agnostic
      can: netlink: add can_dtb_changelink()
      can: netlink: add can_ctrlmode_changelink()
      can: netlink: make can_tdc_get_size() FD agnostic
      can: netlink: add can_data_bittiming_get_size()
      can: netlink: add can_bittiming_fill_info()
      can: netlink: add can_bittiming_const_fill_info()
      can: netlink: add can_bitrate_const_fill_info()
      can: netlink: make can_tdc_fill_info() FD agnostic
      can: calc_bittiming: make can_calc_tdco() FD agnostic
      can: dev: add can_get_ctrlmode_str()
      can: netlink: add userland error messages

Vineeth Karumanchi (2):
      net: macb: Add TAPRIO traffic scheduling support
      net: macb: Add capability-based QBV detection and Versal support

Vishal Badole (1):
      amd-xgbe: Configure and retrieve 'tx-usecs' for Tx coalescing

Vishnu Singh (1):
      net: ti: am65-cpsw: Update hw timestamping filter for PTPv1 RX packets

Vivian Wang (6):
      dt-bindings: net: Add support for SpacemiT K1
      net: spacemit: Add K1 Ethernet MAC
      riscv: dts: spacemit: Add Ethernet support for K1
      riscv: dts: spacemit: Add Ethernet support for BPI-F3
      riscv: dts: spacemit: Add Ethernet support for Jupiter
      net: spacemit: Make stats_lock softirq-safe

Vlad Dogaru (1):
      net/mlx5: HWS, Generalize complex matchers

Vlad Dumitrescu (4):
      devlink: Add 'total_vfs' generic device param
      net/mlx5: Implement devlink enable_sriov parameter
      net/mlx5: Implement devlink total_vfs parameter
      net/mlx5: Remove dead code from total_vfs setter

Vladimir Oltean (24):
      net: dsa: realtek: remove unnecessary file, dentry, inode declarations
      net: phy: mscc: report and configure in-band auto-negotiation for SGMII/QSGMII
      net: phy: aquantia: rename AQR412 to AQR412C and add real AQR412
      net: phy: aquantia: merge aqr113c_fill_interface_modes() into aqr107_fill_interface_modes()
      net: phy: aquantia: reorder AQR113C PMD Global Transmit Disable bit clearing with supported_interfaces
      net: phy: aquantia: rename some aqr107 functions according to generation
      net: phy: aquantia: fill supported_interfaces for all aqr_gen2_config_init() callers
      net: phy: aquantia: save a local shadow of GLOBAL_CFG register values
      net: phy: aquantia: remove handling for get_rate_matching(PHY_INTERFACE_MODE_NA)
      net: phy: aquantia: use cached GLOBAL_CFG registers in aqr107_read_rate()
      net: phy: aquantia: merge and rename aqr105_read_status() and aqr107_read_status()
      net: phy: aquantia: call aqr_gen2_fill_interface_modes() for AQCS109
      net: phy: aquantia: call aqr_gen3_config_init() for AQR112 and AQR412(C)
      net: phy: aquantia: reimplement aqcs109_config_init() as aqr_gen2_config_init()
      net: phy: aquantia: rename aqr113c_config_init() to aqr_gen4_config_init()
      net: phy: aquantia: promote AQR813 and AQR114C to aqr_gen4_config_init()
      net: pcs: lynx: support phy-mode = "10g-qxgmii"
      net: dsa: felix: support phy-mode = "10g-qxgmii"
      net: phy: aquantia: print global syscfg registers
      net: phy: aquantia: report and configure in-band autoneg capabilities
      net: phy: aquantia: create and store a 64-bit firmware image fingerprint
      net: phy: aquantia: support phy-mode = "10g-qxgmii" on NXP SPF-30841 (AQR412C)
      net: phy: aquantia: delete aqr_firmware_read_fingerprint() prototype
      tools: ynl: avoid "use of uninitialized variable" false positive in generated code

Wake Liu (2):
      selftests/net: Replace non-standard __WORDSIZE with sizeof(long) * 8
      selftests/net: Ensure assert() triggers in psock_tpacket.c

Wang Liang (2):
      vsock: use sizeof(struct sockaddr_storage) instead of magic value
      net: bridge: remove unused argument of br_multicast_query_expired()

Waqar Hameed (1):
      net: enetc: Remove error print for devm_add_action_or_reset()

Wei Fang (20):
      dt-bindings: ptp: add NETC Timer PTP clock
      dt-bindings: net: move ptp-timer property to ethernet-controller.yaml
      ptp: add helpers to get the phc_index by of_node or dev
      ptp: netc: add NETC V4 Timer PTP driver support
      ptp: netc: add PTP_CLK_REQ_PPS support
      ptp: netc: add periodic pulse output support
      MAINTAINERS: add NETC Timer PTP clock driver section
      net: enetc: save the parsed information of PTP packet to skb->cb
      net: enetc: extract enetc_update_ptp_sync_msg() to handle PTP Sync packets
      net: enetc: remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check
      net: enetc: move sync packet modification before dma_map_single()
      net: enetc: add PTP synchronization support for ENETC v4
      net: enetc: don't update sync packet checksum if checksum offload is used
      ptp: add debugfs interfaces to loop back the periodic output signal
      ptp: netc: add the periodic output signal loopback support
      ptp: qoriq: convert to use generic interfaces to set loopback mode
      ptp: netc: only enable periodic pulse event interrupts for PPS
      net: enetc: fix sleeping function called from rcu_read_lock() context
      net: enetc: use generic interfaces to get phc_index for ENETC v1
      net: enetc: initialize SW PIR and CIR based HW PIR and CIR values

Wright Feng (1):
      wifi: brcmfmac: support AP isolation to restrict reachability between stations

Xichao Zhao (4):
      sfc: replace min/max nesting with clamp()
      net: hibmcge: Remove the use of dev_err_probe()
      net: dsa: Remove the use of dev_err_probe()
      can: m_can: use us_to_ktime() where appropriate

Xin Zhao (2):
      net: af_packet: remove last_kactive_blk_num field
      net: af_packet: Use hrtimer to do the retire operation

Yafang Shao (1):
      net/cls_cgroup: Fix task_get_classid() during qdisc run

Yang Li (1):
      wifi: iwlwifi: Remove duplicated include in trans.c

Yeounsu Moon (1):
      net: dlink: handle copy_thresh allocation failure

Yue Haibing (5):
      net/sched: Use TC_RTAB_SIZE instead of magic number
      ipv6: mcast: Add ip6_mc_find_idev() helper
      octeontx2-af: Remove unused declarations
      ipv6: Add sanity checks on ipv6_devconf.rpl_seg_enabled
      ipv6: sit: Add ipip6_tunnel_dst_find() for cleanup

Yury Norov (NVIDIA) (5):
      net: openvswitch: Use for_each_cpu() where appropriate
      wireguard: queueing: always return valid online CPU in wg_cpumask_choose_online()
      mlxsw: spectrum_cnt: use bitmap_empty() in mlxsw_sp_counter_pool_fini()
      net: phy: nxp-c45-tja11xx: use bitmap_empty() where appropriate
      net: renesas: rswitch: simplify rswitch_stop()

Yury Norov [NVIDIA] (1):
      wireguard: queueing: simplify wg_cpumask_next_online()

Zenm Chen (3):
      wifi: rtw89: Add USB ID 2001:332a for D-Link AX9U rev. A1
      wifi: rtw89: Add USB ID 2001:3327 for D-Link AX18U rev. A1
      Bluetooth: btusb: Add USB ID 2001:332a for D-Link AX9U rev. A1

Zhang Tengfei (1):
      ipvs: Use READ_ONCE/WRITE_ONCE for ipvs->enable

Zhen Ni (2):
      netfilter: ipset: Remove unused htable_bits in macro ahash_region
      net: qed: Remove redundant NULL checks after list_first_entry()

Zheng tan (1):
      wifi: cfg80211: Remove the redundant wiphy_dev

Zhi-Jun You (1):
      wifi: mt76: mt7915: fix mt7981 pre-calibration

Zong-Zhe Yang (4):
      wifi: rtw89: chan: allow callers to check if a link has no managed chanctx
      wifi: rtw89: debug: support SER L0 simulation
      wifi: rtw89: renew a completion for each H2C command waiting C2H event
      wifi: rtw89: open C2H event waiting window first before sending H2C command

Zongmin Zhou (1):
      selftests: net: avoid memory leak

pengdonglin (1):
      wifi: mac80211: Remove redundant rcu_read_lock/unlock() in spin_lock

 .mailmap                                           |    3 +
 .../ABI/testing/sysfs-driver-framer-pef2256        |    8 +
 Documentation/Makefile                             |   17 -
 Documentation/admin-guide/sysctl/net.rst           |    4 +
 Documentation/conf.py                              |   20 +-
 .../devicetree/bindings/net/airoha,en7581-npu.yaml |   22 +-
 .../bindings/net/allwinner,sun4i-a10-emac.yaml     |    9 +
 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    |   95 +-
 .../bindings/net/altr,socfpga-stmmac.yaml          |    7 +
 .../devicetree/bindings/net/apm,xgene-enet.yaml    |  115 +
 .../bindings/net/apm,xgene-mdio-rgmii.yaml         |   54 +
 .../devicetree/bindings/net/apm-xgene-enet.txt     |   91 -
 .../devicetree/bindings/net/apm-xgene-mdio.txt     |   37 -
 .../bindings/net/brcm,bcm7445-switch-v4.0.txt      |   50 -
 .../devicetree/bindings/net/cdns,macb.yaml         |    3 +-
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml |   87 +-
 .../devicetree/bindings/net/dsa/nxp,sja1105.yaml   |    9 +
 .../bindings/net/ethernet-controller.yaml          |    7 +-
 .../devicetree/bindings/net/fsl,fman-dtsec.yaml    |    4 -
 .../devicetree/bindings/net/litex,liteeth.yaml     |   12 +-
 .../bindings/net/microchip,sparx5-switch.yaml      |   23 +-
 .../devicetree/bindings/net/nfc/ti,trf7970a.yaml   |    4 +-
 .../bindings/net/pcs/renesas,rzn1-miic.yaml        |  177 +-
 .../bindings/net/pse-pd/skyworks,si3474.yaml       |  144 ++
 .../devicetree/bindings/net/qcom,ipq9574-ppe.yaml  |  533 +++++
 .../devicetree/bindings/net/realtek,rtl82xx.yaml   |    6 +-
 .../devicetree/bindings/net/renesas,rzn1-gmac.yaml |    9 +
 .../bindings/net/renesas,rzv2h-gbeth.yaml          |  178 +-
 .../devicetree/bindings/net/snps,dwmac.yaml        |    9 +-
 .../devicetree/bindings/net/spacemit,k1-emac.yaml  |   81 +
 .../devicetree/bindings/net/ti,icss-iep.yaml       |   10 +-
 .../devicetree/bindings/net/ti,icssm-prueth.yaml   |  233 ++
 .../devicetree/bindings/net/ti,pruss-ecap.yaml     |   32 +
 .../devicetree/bindings/ptp/nxp,ptp-netc.yaml      |   63 +
 .../devicetree/bindings/soc/ti/ti,pruss.yaml       |    9 +
 Documentation/driver-api/dpll.rst                  |   18 +-
 Documentation/netlink/genetlink-legacy.yaml        |    2 +-
 Documentation/netlink/specs/conntrack.yaml         |    2 +-
 Documentation/netlink/specs/devlink.yaml           |    7 +
 Documentation/netlink/specs/dpll.yaml              |    6 +
 Documentation/netlink/specs/ethtool.yaml           |   32 +
 Documentation/netlink/specs/fou.yaml               |    4 +-
 Documentation/netlink/specs/index.rst              |   13 +
 Documentation/netlink/specs/mptcp_pm.yaml          |    5 +-
 Documentation/netlink/specs/netdev.yaml            |   22 +-
 Documentation/netlink/specs/nftables.yaml          |    2 +-
 Documentation/netlink/specs/nl80211.yaml           |    2 +-
 Documentation/netlink/specs/ovs_datapath.yaml      |    2 +-
 Documentation/netlink/specs/ovs_flow.yaml          |    2 +-
 Documentation/netlink/specs/ovs_vport.yaml         |    2 +-
 Documentation/netlink/specs/psp.yaml               |  187 ++
 Documentation/netlink/specs/rt-addr.yaml           |    2 +-
 Documentation/netlink/specs/rt-link.yaml           |    8 +-
 Documentation/netlink/specs/rt-neigh.yaml          |    2 +-
 Documentation/netlink/specs/rt-route.yaml          |    2 +-
 Documentation/netlink/specs/rt-rule.yaml           |    2 +-
 Documentation/netlink/specs/tc.yaml                |    2 +-
 Documentation/netlink/specs/team.yaml              |    6 +-
 Documentation/networking/bonding.rst               |  104 +-
 .../networking/device_drivers/ethernet/index.rst   |    1 +
 .../ethernet/mellanox/mlx5/counters.rst            |    7 +-
 .../device_drivers/ethernet/meta/fbnic.rst         |   30 +
 .../device_drivers/ethernet/qualcomm/ppe/ppe.rst   |  194 ++
 .../networking/devlink/devlink-health.rst          |    2 +-
 .../networking/devlink/devlink-params.rst          |    8 +
 Documentation/networking/devlink/index.rst         |   20 +-
 Documentation/networking/devlink/mlx5.rst          |  113 +-
 Documentation/networking/devlink/zl3073x.rst       |   14 +
 Documentation/networking/dns_resolver.rst          |   52 +-
 Documentation/networking/ethtool-netlink.rst       |    5 +
 Documentation/networking/index.rst                 |    3 +-
 Documentation/networking/ip-sysctl.rst             |   71 +-
 Documentation/networking/mptcp-sysctl.rst          |    8 +-
 Documentation/networking/mptcp.rst                 |    2 +-
 .../networking/net_cachelines/tcp_sock.rst         |   18 +-
 Documentation/networking/netlink_spec/.gitignore   |    1 -
 Documentation/networking/netlink_spec/readme.txt   |    4 -
 Documentation/networking/phy.rst                   |    2 +-
 Documentation/networking/psp.rst                   |  183 ++
 Documentation/networking/rxrpc.rst                 |    9 +-
 Documentation/networking/segmentation-offloads.rst |   22 +-
 Documentation/process/maintainer-netdev.rst        |    2 +-
 Documentation/sphinx/parser_yaml.py                |  123 ++
 Documentation/userspace-api/netlink/index.rst      |    2 +-
 .../userspace-api/netlink/netlink-raw.rst          |    6 +-
 Documentation/userspace-api/netlink/specs.rst      |    2 +-
 MAINTAINERS                                        |   58 +-
 arch/m68k/coldfire/m5272.c                         |    4 +-
 arch/mips/bcm47xx/setup.c                          |    4 +-
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |   48 +
 arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts  |   48 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi       |   48 +
 arch/riscv/boot/dts/spacemit/k1.dtsi               |   22 +
 arch/s390/configs/debug_defconfig                  |    4 +-
 arch/s390/configs/defconfig                        |    4 +-
 drivers/Makefile                                   |    1 +
 drivers/bluetooth/bpa10x.c                         |    2 +-
 drivers/bluetooth/btintel.c                        |    3 +
 drivers/bluetooth/btintel_pcie.c                   |  328 +--
 drivers/bluetooth/btintel_pcie.h                   |    2 +
 drivers/bluetooth/btmtksdio.c                      |    2 +-
 drivers/bluetooth/btmtkuart.c                      |    2 +-
 drivers/bluetooth/btnxpuart.c                      |    2 +-
 drivers/bluetooth/btusb.c                          |   23 +
 drivers/bluetooth/h4_recv.h                        |  153 --
 drivers/bluetooth/hci_bcsp.c                       |    3 +
 drivers/dibs/Kconfig                               |   23 +
 drivers/dibs/Makefile                              |    8 +
 drivers/dibs/dibs_loopback.c                       |  361 ++++
 drivers/dibs/dibs_loopback.h                       |   57 +
 drivers/dibs/dibs_main.c                           |  278 +++
 drivers/dpll/dpll_netlink.c                        |   66 +-
 drivers/dpll/dpll_nl.c                             |    5 +-
 drivers/dpll/zl3073x/Makefile                      |    2 +-
 drivers/dpll/zl3073x/core.c                        |  392 +++-
 drivers/dpll/zl3073x/core.h                        |   48 +-
 drivers/dpll/zl3073x/devlink.c                     |  155 +-
 drivers/dpll/zl3073x/devlink.h                     |    3 +
 drivers/dpll/zl3073x/dpll.c                        |   58 +
 drivers/dpll/zl3073x/dpll.h                        |    2 +
 drivers/dpll/zl3073x/flash.c                       |  666 ++++++
 drivers/dpll/zl3073x/flash.h                       |   29 +
 drivers/dpll/zl3073x/fw.c                          |  419 ++++
 drivers/dpll/zl3073x/fw.h                          |   52 +
 drivers/dpll/zl3073x/regs.h                        |   51 +
 drivers/infiniband/hw/mlx5/cq.c                    |    4 +-
 drivers/infiniband/hw/mlx5/std_types.c             |   27 +-
 drivers/net/Space.c                                |    3 +-
 drivers/net/amt.c                                  |    6 +-
 drivers/net/bonding/bond_3ad.c                     |   31 +
 drivers/net/bonding/bond_main.c                    |  115 +-
 drivers/net/bonding/bond_netlink.c                 |   46 +-
 drivers/net/bonding/bond_options.c                 |   54 +-
 drivers/net/bonding/bond_sysfs.c                   |    6 +-
 drivers/net/can/dev/calc_bittiming.c               |   10 +-
 drivers/net/can/dev/dev.c                          |   80 +-
 drivers/net/can/dev/netlink.c                      |  592 ++++--
 drivers/net/can/m_can/m_can.c                      |    6 +-
 drivers/net/can/peak_canfd/peak_canfd.c            |    4 +-
 drivers/net/can/peak_canfd/peak_canfd_user.h       |    4 +-
 drivers/net/can/peak_canfd/peak_pciefd_main.c      |    6 +-
 drivers/net/can/rcar/rcar_can.c                    |  292 +--
 drivers/net/can/rcar/rcar_canfd.c                  |   84 +-
 drivers/net/can/sja1000/peak_pci.c                 |    6 +-
 drivers/net/can/sja1000/peak_pcmcia.c              |    8 +-
 drivers/net/can/spi/hi311x.c                       |    3 +-
 drivers/net/can/spi/mcp251x.c                      |    3 +-
 drivers/net/can/usb/esd_usb.c                      |   64 +-
 drivers/net/can/usb/peak_usb/pcan_usb.c            |    6 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |    6 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h       |    4 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c         |    3 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c        |    4 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h        |    4 +-
 drivers/net/can/vcan.c                             |    2 +-
 drivers/net/can/vxcan.c                            |    2 +-
 drivers/net/dsa/Kconfig                            |   16 +-
 drivers/net/dsa/Makefile                           |    6 +-
 drivers/net/dsa/b53/b53_mmap.c                     |   35 +-
 drivers/net/dsa/dsa_loop.c                         |   77 +-
 drivers/net/dsa/dsa_loop.h                         |   20 -
 drivers/net/dsa/dsa_loop_bdinfo.c                  |   36 -
 drivers/net/{phy/spi_ks8995.c => dsa/ks8995.c}     |  453 +++-
 drivers/net/dsa/lantiq/Kconfig                     |    7 +
 drivers/net/dsa/lantiq/Makefile                    |    1 +
 drivers/net/dsa/{ => lantiq}/lantiq_gswip.c        |  469 ++---
 drivers/net/dsa/lantiq/lantiq_gswip.h              |  276 +++
 drivers/net/dsa/{ => lantiq}/lantiq_pce.h          |    9 +-
 drivers/net/dsa/microchip/ksz_common.c             |   45 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |   17 +-
 drivers/net/dsa/mv88e6xxx/chip.h                   |    2 -
 drivers/net/dsa/mv88e6xxx/hwtstamp.c               |    2 +-
 drivers/net/dsa/mv88e6xxx/hwtstamp.h               |    1 +
 drivers/net/dsa/mv88e6xxx/ptp.c                    |   70 +-
 drivers/net/dsa/mv88e6xxx/ptp.h                    |  133 +-
 drivers/net/dsa/ocelot/felix.c                     |    4 +
 drivers/net/dsa/ocelot/felix.h                     |    3 +-
 drivers/net/dsa/ocelot/felix_vsc9959.c             |    3 +-
 drivers/net/dsa/realtek/realtek.h                  |    3 -
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/airoha/airoha_eth.c           |    7 +-
 drivers/net/ethernet/airoha/airoha_eth.h           |   27 +-
 drivers/net/ethernet/airoha/airoha_npu.c           |  198 +-
 drivers/net/ethernet/airoha/airoha_npu.h           |   36 -
 drivers/net/ethernet/airoha/airoha_ppe.c           |  234 ++-
 drivers/net/ethernet/airoha/airoha_regs.h          |    4 +-
 drivers/net/ethernet/amazon/ena/ena_ethtool.c      |    5 +-
 drivers/net/ethernet/amd/pds_core/main.c           |    2 +-
 drivers/net/ethernet/amd/xgbe/Makefile             |    2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h        |   22 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |   15 +
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       |   30 +-
 drivers/net/ethernet/amd/xgbe/xgbe-i2c.c           |    2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c        |    2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-pps.c           |   74 +
 drivers/net/ethernet/amd/xgbe/xgbe-ptp.c           |   26 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h               |   17 +
 drivers/net/ethernet/broadcom/Kconfig              |    1 +
 drivers/net/ethernet/broadcom/bnge/bnge.h          |   27 +
 drivers/net/ethernet/broadcom/bnge/bnge_core.c     |   16 +
 drivers/net/ethernet/broadcom/bnge/bnge_db.h       |   34 +
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c |  482 +++++
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h |   31 +
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c   | 2217 ++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.h   |  250 ++-
 drivers/net/ethernet/broadcom/bnge/bnge_resc.c     |    6 +-
 drivers/net/ethernet/broadcom/bnge/bnge_resc.h     |    2 +
 drivers/net/ethernet/broadcom/bnge/bnge_rmem.c     |   67 +-
 drivers/net/ethernet/broadcom/bnge/bnge_rmem.h     |   14 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   83 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   12 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c |    4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h |    2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c  |   15 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  152 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |   35 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h      |    7 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c    |   21 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h    |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |    7 +-
 drivers/net/ethernet/broadcom/tg3.c                |   66 +-
 drivers/net/ethernet/cadence/macb.h                |   71 +-
 drivers/net/ethernet/cadence/macb_main.c           |  441 +++-
 drivers/net/ethernet/cavium/liquidio/lio_core.c    |    2 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c    |    8 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c |    3 +-
 .../net/ethernet/cavium/liquidio/request_manager.c |    2 +-
 .../ethernet/cavium/liquidio/response_manager.c    |    3 +-
 .../chelsio/inline_crypto/chtls/chtls_cm.c         |   20 +-
 .../chelsio/inline_crypto/chtls/chtls_cm.h         |    7 +-
 .../chelsio/inline_crypto/chtls/chtls_io.c         |    2 +-
 drivers/net/ethernet/dlink/dl2k.c                  |    7 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |    2 +-
 drivers/net/ethernet/freescale/enetc/Kconfig       |    3 +
 drivers/net/ethernet/freescale/enetc/enetc.c       |  209 +-
 drivers/net/ethernet/freescale/enetc/enetc.h       |   24 +-
 drivers/net/ethernet/freescale/enetc/enetc4_hw.h   |    6 +
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c   |    8 +-
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   |   86 +-
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |    1 +
 drivers/net/ethernet/freescale/enetc/enetc_ptp.c   |    5 -
 drivers/net/ethernet/freescale/enetc/ntmp.c        |   15 +-
 drivers/net/ethernet/freescale/fec.h               |   11 +-
 drivers/net/ethernet/freescale/fec_main.c          |   68 +-
 drivers/net/ethernet/freescale/fman/mac.c          |    2 -
 .../net/ethernet/fungible/funeth/funeth_ethtool.c  |    3 +-
 .../net/ethernet/google/gve/gve_buffer_mgmt_dqo.c  |    5 +
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |   35 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c  |    2 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c  |    3 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |    2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   36 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |    7 +-
 drivers/net/ethernet/huawei/hinic/hinic_devlink.c  |   10 +-
 drivers/net/ethernet/huawei/hinic3/Makefile        |    6 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c   |  915 ++++++++
 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h   |  156 ++
 drivers/net/ethernet/huawei/hinic3/hinic3_common.c |   23 +
 drivers/net/ethernet/huawei/hinic3/hinic3_common.h |   27 +
 drivers/net/ethernet/huawei/hinic3/hinic3_csr.h    |   79 +
 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c    |  776 +++++++
 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h    |  122 ++
 drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c |  211 ++
 drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h |    4 +
 .../net/ethernet/huawei/hinic3/hinic3_hw_comm.c    |  394 ++++
 .../net/ethernet/huawei/hinic3/hinic3_hw_comm.h    |   34 +
 .../net/ethernet/huawei/hinic3/hinic3_hw_intf.h    |  151 ++
 drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c  |  541 ++++-
 drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c   |  417 +++-
 drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h   |   32 +
 drivers/net/ethernet/huawei/hinic3/hinic3_irq.c    |  138 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_lld.c    |    9 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_main.c   |   69 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c   |  848 +++++++-
 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h   |  126 ++
 drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c   |   21 +
 drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h   |    2 +
 .../ethernet/huawei/hinic3/hinic3_mgmt_interface.h |  119 ++
 .../net/ethernet/huawei/hinic3/hinic3_netdev_ops.c |  426 +++-
 .../net/ethernet/huawei/hinic3/hinic3_nic_cfg.c    |  152 ++
 .../net/ethernet/huawei/hinic3/hinic3_nic_cfg.h    |   20 +
 .../net/ethernet/huawei/hinic3/hinic3_nic_dev.h    |   19 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c |  870 +++++++-
 drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h |   39 +-
 .../net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h |    9 +
 drivers/net/ethernet/huawei/hinic3/hinic3_rss.c    |  336 +++
 drivers/net/ethernet/huawei/hinic3/hinic3_rss.h    |   14 +
 drivers/net/ethernet/huawei/hinic3/hinic3_rx.c     |  226 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_rx.h     |   38 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c     |  190 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.h     |   30 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_wq.c     |  109 +
 drivers/net/ethernet/huawei/hinic3/hinic3_wq.h     |   19 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |   59 +-
 drivers/net/ethernet/ibm/ibmvnic.h                 |    6 +-
 drivers/net/ethernet/intel/Kconfig                 |    2 +
 drivers/net/ethernet/intel/Makefile                |    2 +-
 drivers/net/ethernet/intel/e1000/e1000.h           |    2 +-
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c   |    2 +-
 drivers/net/ethernet/intel/e1000/e1000_hw.c        |    4 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c      |    3 +-
 drivers/net/ethernet/intel/e1000e/e1000.h          |    2 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c        |    2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |    4 +-
 drivers/net/ethernet/intel/e1000e/nvm.c            |    4 +-
 drivers/net/ethernet/intel/fm10k/fm10k_common.c    |    5 +-
 drivers/net/ethernet/intel/fm10k/fm10k_common.h    |    2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c   |    2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c      |    2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c        |    2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c        |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   15 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |    2 +-
 drivers/net/ethernet/intel/ice/Makefile            |    9 +-
 drivers/net/ethernet/intel/ice/devlink/health.c    |    3 +-
 drivers/net/ethernet/intel/ice/ice.h               |   40 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |  117 +-
 drivers/net/ethernet/intel/ice/ice_base.c          |  390 +++-
 drivers/net/ethernet/intel/ice/ice_base.h          |    3 +
 drivers/net/ethernet/intel/ice/ice_common.c        |  143 +-
 drivers/net/ethernet/intel/ice/ice_common.h        |    8 +-
 drivers/net/ethernet/intel/ice/ice_debugfs.c       |  633 +-----
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |   18 +-
 drivers/net/ethernet/intel/ice/ice_fwlog.c         |  474 -----
 drivers/net/ethernet/intel/ice/ice_fwlog.h         |   79 -
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h    |    3 +
 drivers/net/ethernet/intel/ice/ice_lag.c           | 1008 ++++++---
 drivers/net/ethernet/intel/ice/ice_lag.h           |   22 +-
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h     |   41 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |    1 +
 drivers/net/ethernet/intel/ice/ice_main.c          |  154 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c         |    2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.h         |    4 +-
 drivers/net/ethernet/intel/ice/ice_trace.h         |   10 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |  188 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h          |   15 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h      |   14 +
 drivers/net/ethernet/intel/ice/ice_type.h          |   12 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |    2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h        |    2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c           |  153 +-
 drivers/net/ethernet/intel/ice/ice_xsk.h           |   22 +
 .../{ice_virtchnl_allowlist.c => virt/allowlist.c} |    2 +-
 .../{ice_virtchnl_allowlist.h => virt/allowlist.h} |    0
 .../intel/ice/{ice_virtchnl_fdir.c => virt/fdir.c} |    0
 .../intel/ice/{ice_virtchnl_fdir.h => virt/fdir.h} |    0
 drivers/net/ethernet/intel/ice/virt/queues.c       |  973 +++++++++
 drivers/net/ethernet/intel/ice/virt/queues.h       |   20 +
 drivers/net/ethernet/intel/ice/virt/rss.c          |  719 +++++++
 drivers/net/ethernet/intel/ice/virt/rss.h          |   18 +
 .../intel/ice/{ice_virtchnl.c => virt/virtchnl.c}  | 2055 ++----------------
 .../intel/ice/{ice_virtchnl.h => virt/virtchnl.h}  |    0
 drivers/net/ethernet/intel/idpf/Kconfig            |    2 +-
 drivers/net/ethernet/intel/idpf/Makefile           |    3 +
 drivers/net/ethernet/intel/idpf/idpf.h             |   57 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c         |   11 +-
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c     |   64 +-
 drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h    |    6 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |  179 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c        |    1 +
 drivers/net/ethernet/intel/idpf/idpf_ptp.c         |   11 +-
 .../net/ethernet/intel/idpf/idpf_singleq_txrx.c    |  110 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |  990 ++++++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |  210 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c      |   11 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    | 1233 +++++++----
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h    |   33 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl_ptp.c    |    4 +
 drivers/net/ethernet/intel/idpf/xdp.c              |  486 +++++
 drivers/net/ethernet/intel/idpf/xdp.h              |  175 ++
 drivers/net/ethernet/intel/idpf/xsk.c              |  633 ++++++
 drivers/net/ethernet/intel/idpf/xsk.h              |   33 +
 drivers/net/ethernet/intel/igb/e1000_82575.c       |    4 +-
 drivers/net/ethernet/intel/igb/e1000_i210.c        |    2 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c         |    4 +-
 drivers/net/ethernet/intel/igb/igb.h               |    2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |    8 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |    3 +-
 drivers/net/ethernet/intel/igbvf/ethtool.c         |    5 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |    8 +-
 drivers/net/ethernet/intel/igc/igc_i225.c          |    2 +-
 drivers/net/ethernet/intel/igc/igc_nvm.c           |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c      |  128 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h      |    2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   10 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      |    2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c      |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |   14 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c       |    6 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |    2 +-
 drivers/net/ethernet/intel/libie/Kconfig           |    9 +
 drivers/net/ethernet/intel/libie/Makefile          |    4 +
 drivers/net/ethernet/intel/libie/fwlog.c           | 1115 ++++++++++
 drivers/net/ethernet/marvell/mvneta.c              |   15 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   19 +-
 .../net/ethernet/marvell/octeon_ep/octep_ethtool.c |   10 +
 .../marvell/octeon_ep_vf/octep_vf_ethtool.c        |   10 +
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |    2 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h    |    4 -
 .../net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c |    2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |    3 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |    1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |    2 +-
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |   32 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   16 +
 .../net/ethernet/marvell/octeontx2/af/rvu_rep.c    |    2 +-
 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.c   |    3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |    3 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |    1 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |    1 +
 .../net/ethernet/marvell/prestera/prestera_main.c  |    2 +-
 .../net/ethernet/marvell/prestera/prestera_pci.c   |    2 +-
 drivers/net/ethernet/mediatek/mtk_wed.c            |   33 +-
 drivers/net/ethernet/mediatek/mtk_wed.h            |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig    |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |   10 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/cq.c       |    1 -
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |  145 +-
 drivers/net/ethernet/mellanox/mlx5/core/devlink.h  |    5 +
 .../mellanox/mlx5/core/diag/reporter_vnic.c        |   17 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   10 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h    |    7 +-
 .../ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c |    4 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |   10 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.h    |    2 +-
 .../mellanox/mlx5/core/en/pcie_cong_event.c        |   79 +-
 .../ethernet/mellanox/mlx5/core/en/port_buffer.h   |   12 -
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h   |    1 +
 .../ethernet/mellanox/mlx5/core/en/rep/bridge.c    |    7 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_rx.c   |   16 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |   16 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.c   |   91 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.h   |   30 +-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.c    |   43 +-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.h    |    2 +-
 .../ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c |    4 +-
 .../ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c |    4 +-
 .../ethernet/mellanox/mlx5/core/en/tc/int_port.c   |    8 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    |    7 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/trap.c  |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h  |    5 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/setup.c |    2 +-
 .../mellanox/mlx5/core/en_accel/en_accel.h         |   50 +-
 .../ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c  |    2 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |   44 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h       |    2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c |    9 +-
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c  |    2 +-
 .../net/ethernet/mellanox/mlx5/core/en_accel/psp.c |  952 +++++++++
 .../net/ethernet/mellanox/mlx5/core/en_accel/psp.h |   61 +
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c         |  200 ++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.h         |  121 ++
 .../net/ethernet/mellanox/mlx5/core/en_common.c    |   49 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   20 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c    |   21 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  110 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |   80 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |  127 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   19 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |    8 +-
 .../mellanox/mlx5/core/esw/acl/egress_lgcy.c       |    4 +-
 .../ethernet/mellanox/mlx5/core/esw/adj_vport.c    |  209 ++
 .../net/ethernet/mellanox/mlx5/core/esw/bridge.c   |   47 +-
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |   11 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  |   15 +-
 .../net/ethernet/mellanox/mlx5/core/esw/vporttbl.c |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  238 ++-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   52 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  159 +-
 .../net/ethernet/mellanox/mlx5/core/fpga/conn.c    |    1 -
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  183 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |   18 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c       |    6 +
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |   24 +
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |   51 +-
 .../net/ethernet/mellanox/mlx5/core/irq_affinity.c |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |   45 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c  |    8 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |  131 +-
 .../net/ethernet/mellanox/mlx5/core/lib/crypto.h   |    1 +
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   |   44 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |   16 +-
 .../net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c   |  395 +++-
 .../net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h   |   19 +
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.c         |    4 +
 .../ethernet/mellanox/mlx5/core/lib/macsec_fs.c    |   14 +-
 .../ethernet/mellanox/mlx5/core/lib/macsec_fs.h    |   15 +
 .../net/ethernet/mellanox/mlx5/core/lib/nv_param.c |  567 +++++
 .../net/ethernet/mellanox/mlx5/core/lib/nv_param.h |   14 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c   |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   40 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |    2 -
 .../net/ethernet/mellanox/mlx5/core/pagealloc.c    |    7 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |    2 +-
 .../mlx5/core/sf/dev/diag/dev_tracepoint.h         |    2 +-
 .../ethernet/mellanox/mlx5/core/steering/hws/bwc.c |   37 +-
 .../ethernet/mellanox/mlx5/core/steering/hws/bwc.h |   21 +-
 .../mellanox/mlx5/core/steering/hws/bwc_complex.c  | 1821 +++++++---------
 .../mellanox/mlx5/core/steering/hws/bwc_complex.h  |   60 +-
 .../ethernet/mellanox/mlx5/core/steering/hws/cmd.c |   30 +-
 .../mellanox/mlx5/core/steering/hws/definer.c      |   89 +-
 .../mellanox/mlx5/core/steering/hws/definer.h      |    9 +-
 .../mellanox/mlx5/core/steering/hws/send.c         |    8 +-
 .../mellanox/mlx5/core/steering/sws/dr_cmd.c       |   30 +-
 .../mellanox/mlx5/core/steering/sws/dr_send.c      |    1 -
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |   58 +-
 drivers/net/ethernet/mellanox/mlx5/core/wc.c       |   42 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c         |    6 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c |    3 +-
 drivers/net/ethernet/meta/fbnic/fbnic.h            |   14 +-
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h        |   37 +
 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c    |  249 +++
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c    |  209 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c         |  482 ++++-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h         |   92 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c     |    2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h     |    2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c   |   66 +-
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h   |   28 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c        |   57 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h        |    6 +
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |  149 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h     |   13 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |   61 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c        |  145 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h        |    4 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c       |  971 +++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h       |   33 +-
 drivers/net/ethernet/microchip/lan865x/lan865x.c   |    2 +
 drivers/net/ethernet/microchip/sparx5/Kconfig      |    2 +-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |   18 +
 drivers/net/ethernet/microsoft/mana/hw_channel.c   |    7 +-
 drivers/net/ethernet/microsoft/mana/mana_bpf.c     |   46 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  161 +-
 drivers/net/ethernet/netronome/nfp/crypto/tls.c    |    9 +-
 .../net/ethernet/netronome/nfp/flower/metadata.c   |    4 +-
 drivers/net/ethernet/netronome/nfp/nfd3/dp.c       |   16 +-
 drivers/net/ethernet/netronome/nfp/nfdk/dp.c       |   16 +-
 drivers/net/ethernet/netronome/nfp/nfp_main.c      |    2 +-
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   |    2 +-
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |    2 +-
 drivers/net/ethernet/qlogic/qed/qed_devlink.c      |    9 +-
 drivers/net/ethernet/qlogic/qed/qed_main.c         |    3 +-
 drivers/net/ethernet/qlogic/qed/qed_ooo.c          |    9 -
 drivers/net/ethernet/qualcomm/Kconfig              |   15 +
 drivers/net/ethernet/qualcomm/Makefile             |    1 +
 drivers/net/ethernet/qualcomm/ppe/Makefile         |    7 +
 drivers/net/ethernet/qualcomm/ppe/ppe.c            |  239 +++
 drivers/net/ethernet/qualcomm/ppe/ppe.h            |   39 +
 drivers/net/ethernet/qualcomm/ppe/ppe_config.c     | 2034 ++++++++++++++++++
 drivers/net/ethernet/qualcomm/ppe/ppe_config.h     |  317 +++
 drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c    |  847 ++++++++
 drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.h    |   16 +
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h       |  591 ++++++
 drivers/net/ethernet/realtek/Kconfig               |    2 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   12 +-
 drivers/net/ethernet/renesas/Makefile              |    1 +
 drivers/net/ethernet/renesas/ravb_main.c           |    3 +-
 drivers/net/ethernet/renesas/rcar_gen4_ptp.c       |   76 +-
 drivers/net/ethernet/renesas/rcar_gen4_ptp.h       |   33 +-
 drivers/net/ethernet/renesas/rswitch.h             |   43 +-
 drivers/net/ethernet/renesas/rswitch_l2.c          |  316 +++
 drivers/net/ethernet/renesas/rswitch_l2.h          |   15 +
 .../ethernet/renesas/{rswitch.c => rswitch_main.c} |   97 +-
 drivers/net/ethernet/renesas/rtsn.c                |    3 +-
 drivers/net/ethernet/renesas/sh_eth.c              |   34 +-
 drivers/net/ethernet/sfc/ef100_tx.c                |   17 +-
 drivers/net/ethernet/sfc/efx_channels.c            |    6 +-
 drivers/net/ethernet/sfc/ethtool.c                 |    3 +-
 drivers/net/ethernet/sfc/falcon/efx.c              |    5 +-
 drivers/net/ethernet/sfc/siena/efx_channels.c      |    6 +-
 drivers/net/ethernet/sfc/siena/ethtool.c           |    3 +-
 drivers/net/ethernet/sfc/tc_encap_actions.c        |    4 +-
 drivers/net/ethernet/smsc/smsc911x.c               |   14 +-
 drivers/net/ethernet/spacemit/Kconfig              |   29 +
 drivers/net/ethernet/spacemit/Makefile             |    6 +
 drivers/net/ethernet/spacemit/k1_emac.c            | 2159 +++++++++++++++++++
 drivers/net/ethernet/spacemit/k1_emac.h            |  416 ++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   24 +-
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 +
 drivers/net/ethernet/stmicro/stmmac/common.h       |    2 +-
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |    3 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |   30 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ingenic.c    |   25 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   86 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |   85 +-
 .../net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c    |    1 -
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |   10 +-
 .../ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c  |  108 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |   60 +-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   |    6 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |   94 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c |  159 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   51 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  |   24 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |    1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |    8 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |    2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    |    2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.c         |    2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   17 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c   |    9 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h   |    1 +
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   31 +-
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |   28 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  338 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |  391 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   |   78 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   94 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |   54 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |    7 +-
 drivers/net/ethernet/ti/Kconfig                    |   12 +
 drivers/net/ethernet/ti/Makefile                   |    3 +
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c        |   27 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |    9 +-
 drivers/net/ethernet/ti/icssg/icss_iep.c           |  101 +
 drivers/net/ethernet/ti/icssm/icssm_prueth.c       | 1746 +++++++++++++++
 drivers/net/ethernet/ti/icssm/icssm_prueth.h       |  262 +++
 drivers/net/ethernet/ti/icssm/icssm_prueth_ptp.h   |   85 +
 drivers/net/ethernet/ti/icssm/icssm_switch.h       |  257 +++
 drivers/net/ethernet/wangxun/Kconfig               |    1 +
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c    |  224 +-
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.h    |   13 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |  133 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h         |    5 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |  113 +-
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c      |   22 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |   28 +
 drivers/net/ethernet/wangxun/libwx/wx_vf.h         |   72 +-
 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c     |    2 +-
 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h     |    1 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c   |    9 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c      |    6 +-
 drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c  |    5 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c |    9 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |    1 +
 .../net/ethernet/wangxun/txgbevf/txgbevf_main.c    |    5 +
 drivers/net/ethernet/wiznet/w5100.c                |    2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   10 +-
 drivers/net/fjes/fjes_main.c                       |    5 +-
 drivers/net/geneve.c                               |    4 +-
 drivers/net/gtp.c                                  |    7 +-
 drivers/net/hamradio/6pack.c                       |   57 +-
 drivers/net/ipvlan/ipvlan_core.c                   |    4 +-
 drivers/net/macsec.c                               |  173 +-
 drivers/net/macvlan.c                              |    2 +-
 drivers/net/mdio/Kconfig                           |    5 -
 drivers/net/mdio/mdio-bcm-unimac.c                 |    4 +-
 drivers/net/mdio/of_mdio.c                         |    3 +-
 drivers/net/netconsole.c                           |   91 +-
 drivers/net/netdevsim/Makefile                     |    4 +
 drivers/net/netdevsim/dev.c                        |    6 +-
 drivers/net/netdevsim/ethtool.c                    |   25 +-
 drivers/net/netdevsim/health.c                     |    4 +-
 drivers/net/netdevsim/netdev.c                     |   43 +-
 drivers/net/netdevsim/netdevsim.h                  |   27 +
 drivers/net/netdevsim/psp.c                        |  225 ++
 drivers/net/pcs/Kconfig                            |   11 +-
 drivers/net/pcs/pcs-lynx.c                         |   11 +-
 drivers/net/pcs/pcs-rzn1-miic.c                    |  317 ++-
 drivers/net/phy/Kconfig                            |   11 +-
 drivers/net/phy/Makefile                           |    3 +-
 drivers/net/phy/aquantia/aquantia.h                |   52 +
 drivers/net/phy/aquantia/aquantia_main.c           |  702 ++++---
 drivers/net/phy/as21xxx.c                          |    7 +-
 drivers/net/phy/ax88796b.c                         |    5 +-
 drivers/net/phy/broadcom.c                         |  147 +-
 drivers/net/phy/dp83640.c                          |   58 +-
 drivers/net/phy/fixed_phy.c                        |  217 +-
 drivers/net/phy/marvell-88x2222.c                  |   13 +-
 drivers/net/phy/marvell.c                          |   47 +-
 drivers/net/phy/marvell10g.c                       |    7 +-
 drivers/net/phy/mdio-boardinfo.c                   |   79 -
 drivers/net/phy/mdio-boardinfo.h                   |   18 -
 drivers/net/phy/mdio_bus_provider.c                |   33 -
 drivers/net/phy/mediatek/mtk-2p5ge.c               |  104 +-
 drivers/net/phy/micrel.c                           | 1004 ++++++---
 drivers/net/phy/motorcomm.c                        |  117 ++
 drivers/net/phy/mscc/mscc.h                        |    3 +
 drivers/net/phy/mscc/mscc_main.c                   |   40 +
 drivers/net/phy/mxl-86110.c                        |  392 +++-
 drivers/net/phy/nxp-c45-tja11xx-macsec.c           |    8 +-
 drivers/net/phy/phy-caps.h                         |    2 +-
 drivers/net/phy/phy.c                              |   15 +
 drivers/net/phy/phy_caps.c                         |    2 +-
 drivers/net/phy/phy_device.c                       |   31 +-
 drivers/net/phy/phylink.c                          |   14 +-
 drivers/net/phy/qcom/at803x.c                      |    9 +-
 drivers/net/phy/qcom/qca807x.c                     |    7 +-
 drivers/net/phy/realtek/realtek_main.c             |  263 ++-
 drivers/net/phy/sfp-bus.c                          |  107 +-
 drivers/net/phy/sfp.c                              |   85 +-
 drivers/net/phy/sfp.h                              |    4 +-
 drivers/net/ppp/Kconfig                            |    3 +-
 drivers/net/ppp/bsd_comp.c                         |    4 +-
 drivers/net/ppp/ppp_generic.c                      |  120 +-
 drivers/net/ppp/ppp_mppe.c                         |  108 +-
 drivers/net/ppp/pppoe.c                            |  129 +-
 drivers/net/pse-pd/Kconfig                         |   11 +
 drivers/net/pse-pd/Makefile                        |    1 +
 drivers/net/pse-pd/si3474.c                        |  578 +++++
 drivers/net/tun.c                                  |    4 +-
 drivers/net/usb/Kconfig                            |    1 +
 drivers/net/usb/lan78xx.c                          |    6 +
 drivers/net/usb/rtl8150.c                          |    2 -
 drivers/net/virtio_net.c                           |   22 +-
 drivers/net/vrf.c                                  |    4 +-
 drivers/net/vxlan/vxlan_core.c                     |    7 +-
 drivers/net/wan/framer/pef2256/pef2256.c           |   28 +-
 drivers/net/wireguard/device.c                     |    6 +-
 drivers/net/wireguard/queueing.h                   |   13 +-
 drivers/net/wireless/ath/ath10k/leds.c             |    3 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   12 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |   14 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |   39 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |   17 +-
 drivers/net/wireless/ath/ath11k/ce.c               |    3 +-
 drivers/net/wireless/ath/ath11k/core.c             |    6 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |    1 -
 drivers/net/wireless/ath/ath11k/hal.c              |   16 +
 drivers/net/wireless/ath/ath11k/hal.h              |    1 +
 drivers/net/wireless/ath/ath11k/qmi.c              |   19 +-
 drivers/net/wireless/ath/ath12k/ce.c               |    5 +-
 drivers/net/wireless/ath/ath12k/core.h             |    7 +-
 drivers/net/wireless/ath/ath12k/debug.h            |    1 +
 drivers/net/wireless/ath/ath12k/dp.c               |    2 +
 drivers/net/wireless/ath/ath12k/dp.h               |   12 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   56 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  352 ++--
 drivers/net/wireless/ath/ath12k/dp_rx.h            |   18 +-
 drivers/net/wireless/ath/ath12k/hal.h              |    1 +
 drivers/net/wireless/ath/ath12k/hal_desc.h         |    1 +
 drivers/net/wireless/ath/ath12k/hal_rx.c           |    3 +
 drivers/net/wireless/ath/ath12k/hal_rx.h           |   12 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  117 +-
 drivers/net/wireless/ath/ath12k/mac.h              |    3 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |   24 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |   16 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  158 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |   33 +-
 drivers/net/wireless/ath/carl9170/rx.c             |    2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        |    1 +
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |    2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   23 +
 .../wireless/broadcom/brcm80211/brcmfmac/chip.c    |    4 +-
 .../broadcom/brcm80211/brcmfmac/firmware.c         |   14 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |    8 +-
 .../broadcom/brcm80211/include/brcm_hw_ids.h       |    1 -
 drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h |   24 -
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   18 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |   13 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c     |   22 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c     |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   18 +-
 drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c    |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c  |   10 +-
 drivers/net/wireless/intel/iwlwifi/dvm/power.c     |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |    2 -
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |  113 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |    3 +
 .../net/wireless/intel/iwlwifi/fw/api/offload.h    |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |   34 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h     |   35 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   43 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |   54 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c       |   81 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |   53 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |    1 -
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |    2 -
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |    7 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   40 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   47 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c        |   95 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.h        |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   80 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |   74 +
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |   71 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   81 +-
 drivers/net/wireless/intel/iwlwifi/mei/sap.h       |    2 -
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |  553 +++--
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c   |    8 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |   39 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.h     |    5 +-
 drivers/net/wireless/intel/iwlwifi/mld/key.c       |   38 +
 drivers/net/wireless/intel/iwlwifi/mld/key.h       |    7 +
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |   26 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.h      |    2 +
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |   19 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |    4 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |   34 +-
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |    1 -
 .../net/wireless/intel/iwlwifi/mld/regulatory.c    |   28 +-
 drivers/net/wireless/intel/iwlwifi/mld/roc.c       |   10 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c        |   26 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c       |    8 +-
 drivers/net/wireless/intel/iwlwifi/mld/stats.c     |   11 +-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c       |   75 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c      |  131 --
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |   20 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  384 +---
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   |   94 -
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |    3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |  809 -------
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   38 -
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  124 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |  138 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |    2 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |  136 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   53 -
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |  133 --
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   23 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |  101 -
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   89 -
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |   24 -
 .../net/wireless/intel/iwlwifi/mvm/tests/Makefile  |    2 +-
 .../net/wireless/intel/iwlwifi/mvm/tests/links.c   |  433 ----
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |    3 -
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |   10 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |    9 +-
 .../wireless/intel/iwlwifi/pcie/gen1_2/internal.h  |   53 +-
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c         |    2 +-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c |  237 ++-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c    |    5 +-
 drivers/net/wireless/intel/iwlwifi/tests/Makefile  |    2 +-
 .../net/wireless/intel/iwlwifi/tests/nvm_parse.c   |   72 +
 drivers/net/wireless/intersil/p54/txrx.c           |    2 +-
 drivers/net/wireless/marvell/libertas/if_sdio.c    |    3 +-
 drivers/net/wireless/marvell/libertas/if_spi.c     |    3 +-
 drivers/net/wireless/marvell/libertas_tf/main.c    |    2 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |    7 +-
 drivers/net/wireless/marvell/mwifiex/main.c        |    5 +
 drivers/net/wireless/marvell/mwifiex/main.h        |    3 +
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c     |  113 +
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c   |   58 +-
 drivers/net/wireless/mediatek/mt76/agg-rx.c        |    2 +
 drivers/net/wireless/mediatek/mt76/channel.c       |   13 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |  231 +-
 drivers/net/wireless/mediatek/mt76/dma.h           |   29 +-
 drivers/net/wireless/mediatek/mt76/eeprom.c        |    9 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   59 +
 drivers/net/wireless/mediatek/mt76/mt76.h          |   75 +-
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   |    5 +-
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  |    7 +
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   25 +
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c |    6 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c    |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |   29 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |    2 +
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c    |    3 +
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |   67 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |   28 +-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |   26 +-
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c    |    3 +
 drivers/net/wireless/mediatek/mt76/mt792x.h        |    1 -
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |    6 +-
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |  326 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |  356 +++-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  783 +++++--
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  507 +++--
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  314 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |   17 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |   97 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  106 +-
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |   32 +-
 drivers/net/wireless/mediatek/mt76/scan.c          |   13 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |    3 +-
 drivers/net/wireless/mediatek/mt76/wed.c           |    8 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |    7 -
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c     |    2 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |   27 +-
 drivers/net/wireless/realtek/rtlwifi/ps.c          |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/sw.c    |    1 -
 drivers/net/wireless/realtek/rtw88/led.c           |   13 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |    4 +
 drivers/net/wireless/realtek/rtw89/chan.c          |   11 +-
 drivers/net/wireless/realtek/rtw89/chan.h          |   10 +-
 drivers/net/wireless/realtek/rtw89/coex.c          |    5 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  684 +++++-
 drivers/net/wireless/realtek/rtw89/core.h          |  148 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |  125 +-
 drivers/net/wireless/realtek/rtw89/debug.h         |    1 +
 drivers/net/wireless/realtek/rtw89/fw.c            |  177 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |   77 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |   72 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |    1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   35 +
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    1 +
 drivers/net/wireless/realtek/rtw89/pci.c           |  462 +++-
 drivers/net/wireless/realtek/rtw89/pci.h           |  128 +-
 drivers/net/wireless/realtek/rtw89/pci_be.c        |   18 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |  476 ++++-
 drivers/net/wireless/realtek/rtw89/phy.h           |   24 +-
 drivers/net/wireless/realtek/rtw89/phy_be.c        |    9 +
 drivers/net/wireless/realtek/rtw89/ps.c            |    3 +
 drivers/net/wireless/realtek/rtw89/reg.h           |   56 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  |  159 +-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c     |    3 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   46 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c |   14 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c    |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   11 +-
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |    4 +
 drivers/net/wireless/realtek/rtw89/sar.c           |   15 +
 drivers/net/wireless/realtek/rtw89/sar.h           |    1 +
 drivers/net/wireless/realtek/rtw89/ser.c           |    5 +-
 drivers/net/wireless/realtek/rtw89/txrx.h          |   38 +-
 drivers/net/wireless/realtek/rtw89/wow.c           |   79 +-
 drivers/net/wireless/realtek/rtw89/wow.h           |    6 +
 drivers/net/wireless/virtual/mac80211_hwsim.c      |  259 ++-
 drivers/net/wireless/virtual/mac80211_hwsim.h      |    4 +-
 drivers/net/wwan/iosm/iosm_ipc_pcie.c              |    2 +-
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c         |    3 +-
 drivers/net/wwan/wwan_hwsim.c                      |    2 +-
 drivers/nfc/pn533/pn533.c                          |   12 +-
 drivers/nfc/s3fwrn5/Kconfig                        |    3 +-
 drivers/nfc/s3fwrn5/firmware.c                     |   17 +-
 drivers/ptp/Kconfig                                |   13 +-
 drivers/ptp/Makefile                               |    5 +-
 drivers/ptp/ptp_chardev.c                          |   62 +-
 drivers/ptp/ptp_clock.c                            |  150 +-
 drivers/ptp/ptp_clockmatrix.c                      |    2 +-
 drivers/ptp/ptp_netc.c                             | 1043 +++++++++
 drivers/ptp/ptp_ocp.c                              |    6 +-
 drivers/ptp/ptp_private.h                          |    3 +
 drivers/ptp/ptp_qoriq.c                            |   24 +-
 drivers/ptp/ptp_qoriq_debugfs.c                    |  101 -
 drivers/ptp/ptp_sysfs.c                            |    2 +-
 drivers/s390/net/Kconfig                           |    3 +-
 drivers/s390/net/ism.h                             |   53 +-
 drivers/s390/net/ism_drv.c                         |  573 ++---
 drivers/staging/octeon/ethernet-tx.c               |    3 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |    8 -
 drivers/vhost/vringh.c                             |    7 +-
 .../dt-bindings/net/renesas,r9a09g077-pcs-miic.h   |   36 +
 include/linux/bnxt/hsi.h                           |  376 +++-
 include/linux/bpf.h                                |    7 +-
 include/linux/can/bittiming.h                      |   48 +-
 include/linux/can/dev.h                            |   66 +-
 include/linux/can/dev/peak_canfd.h                 |    4 +-
 include/linux/dibs.h                               |  464 ++++
 include/linux/dpll.h                               |    6 +
 include/linux/ethtool.h                            |   27 +-
 include/linux/filter.h                             |    6 +
 include/linux/fsl/ptp_qoriq.h                      |   10 -
 include/linux/ieee80211.h                          |  300 ++-
 include/linux/if_pppox.h                           |    2 +-
 include/linux/inet_diag.h                          |   20 +-
 include/linux/ipv6.h                               |   39 +-
 include/linux/ism.h                                |   28 +-
 include/linux/memcontrol.h                         |   45 +-
 include/linux/micrel_phy.h                         |    1 +
 include/linux/mlx5/cq.h                            |    1 -
 include/linux/mlx5/device.h                        |    5 +
 include/linux/mlx5/driver.h                        |   10 +-
 include/linux/mlx5/mlx5_ifc.h                      |  274 ++-
 include/linux/mlx5/qp.h                            |   16 +-
 include/linux/mlx5/vport.h                         |    2 +
 include/linux/mmc/sdio_ids.h                       |    2 +-
 include/linux/net/intel/libie/adminq.h             |   95 +-
 include/linux/net/intel/libie/fwlog.h              |   85 +
 include/linux/netdevice.h                          |   47 +-
 include/linux/netpoll.h                            |    1 -
 include/linux/phy.h                                |   53 +-
 include/linux/phy_fixed.h                          |   18 +-
 include/linux/phylink.h                            |    7 +-
 include/linux/ptp_clock_kernel.h                   |   32 +
 include/linux/ptr_ring.h                           |   42 +-
 include/linux/sfp.h                                |   48 +-
 include/linux/skbuff.h                             |   52 +-
 include/linux/skmsg.h                              |    2 +-
 include/linux/soc/airoha/airoha_offload.h          |  316 +++
 include/linux/soc/mediatek/mtk_wed.h               |    2 +-
 include/linux/stmmac.h                             |   35 +-
 include/linux/tcp.h                                |   52 +-
 include/linux/udp.h                                |    9 +
 include/net/act_api.h                              |   14 +-
 include/net/bluetooth/bluetooth.h                  |    3 +-
 include/net/bluetooth/hci.h                        |    1 +
 include/net/bluetooth/hci_core.h                   |   11 +-
 include/net/bluetooth/hci_drv.h                    |    2 +-
 include/net/bluetooth/mgmt.h                       |    9 +-
 include/net/bond_3ad.h                             |    2 +
 include/net/bond_options.h                         |    1 +
 include/net/bonding.h                              |    2 +-
 include/net/cfg80211.h                             |  282 ++-
 include/net/cls_cgroup.h                           |    2 +-
 include/net/devlink.h                              |   24 +-
 include/net/dropreason-core.h                      |    6 +
 include/net/dst.h                                  |   16 +-
 include/net/flow.h                                 |   11 +-
 include/net/genetlink.h                            |    2 +-
 include/net/gro.h                                  |   32 +-
 include/net/hotdata.h                              |    7 +
 include/net/icmp.h                                 |   10 +-
 include/net/inet6_hashtables.h                     |   20 +-
 include/net/inet_connection_sock.h                 |   13 +-
 include/net/inet_dscp.h                            |    6 +
 include/net/inet_hashtables.h                      |   40 +-
 include/net/inet_timewait_sock.h                   |   11 +-
 include/net/ip.h                                   |   15 +-
 include/net/ip6_route.h                            |   10 +-
 include/net/ip_fib.h                               |    2 +-
 include/net/ip_tunnels.h                           |    4 +-
 include/net/libeth/xdp.h                           |   11 +-
 include/net/mac80211.h                             |   10 +
 include/net/mana/mana.h                            |    4 +
 include/net/netdev_queues.h                        |    9 +
 include/net/netfilter/ipv4/nf_reject.h             |    8 -
 include/net/netfilter/ipv6/nf_reject.h             |   10 -
 include/net/netfilter/nf_tables.h                  |    2 +
 include/net/netfilter/nf_tables_core.h             |    2 +-
 include/net/netns/ipv4.h                           |    3 +
 include/net/netns/sctp.h                           |    4 +-
 include/net/nfc/nci_core.h                         |    2 +-
 include/net/page_pool/helpers.h                    |   17 +
 include/net/ping.h                                 |    1 -
 include/net/proto_memory.h                         |    4 +-
 include/net/psp.h                                  |   12 +
 include/net/psp/functions.h                        |  209 ++
 include/net/psp/types.h                            |  184 ++
 include/net/raw.h                                  |    1 +
 include/net/request_sock.h                         |    2 +-
 include/net/route.h                                |    4 +-
 include/net/rps.h                                  |   92 +-
 include/net/sctp/auth.h                            |   17 +-
 include/net/sctp/constants.h                       |    9 +-
 include/net/sctp/structs.h                         |   35 +-
 include/net/seg6_hmac.h                            |   20 +-
 include/net/smc.h                                  |   51 +-
 include/net/snmp.h                                 |    5 -
 include/net/sock.h                                 |  135 +-
 include/net/tc_act/tc_skbmod.h                     |    1 +
 include/net/tc_act/tc_tunnel_key.h                 |    1 +
 include/net/tc_act/tc_vlan.h                       |    1 +
 include/net/tcp.h                                  |  108 +-
 include/net/tcp_ao.h                               |    1 -
 include/net/tcp_ecn.h                              |  642 ++++++
 include/net/timewait_sock.h                        |    7 -
 include/net/udp.h                                  |   20 +-
 include/net/xdp.h                                  |   69 +-
 include/net/xdp_sock_drv.h                         |   21 +-
 include/trace/events/fib.h                         |    4 +-
 include/uapi/linux/can/netlink.h                   |   14 +-
 include/uapi/linux/devlink.h                       |    2 +
 include/uapi/linux/dpll.h                          |    1 +
 include/uapi/linux/ethtool.h                       |    1 +
 include/uapi/linux/ethtool_netlink_generated.h     |   12 +
 include/uapi/linux/if_bridge.h                     |    3 +
 include/uapi/linux/if_link.h                       |    3 +
 include/uapi/linux/mptcp.h                         |   22 +-
 include/uapi/linux/mptcp_pm.h                      |    4 +-
 include/uapi/linux/netfilter/nf_tables.h           |    2 +
 include/uapi/linux/nl80211.h                       |  255 ++-
 include/uapi/linux/psp.h                           |   66 +
 include/uapi/linux/ptp_clock.h                     |    4 +
 include/uapi/linux/stddef.h                        |    2 +
 include/uapi/linux/tcp.h                           |    9 +
 io_uring/zcrx.c                                    |    3 +-
 kernel/bpf/helpers.c                               |   11 +
 kernel/bpf/log.c                                   |    2 +
 kernel/bpf/verifier.c                              |   28 +-
 kernel/time/time.c                                 |    1 +
 mm/memcontrol.c                                    |   40 +-
 net/Kconfig                                        |    2 +
 net/Makefile                                       |    1 +
 net/batman-adv/Kconfig                             |   13 -
 net/batman-adv/Makefile                            |    1 -
 net/batman-adv/bat_iv_ogm.c                        |    5 -
 net/batman-adv/bridge_loop_avoidance.c             |   34 +
 net/batman-adv/hard-interface.c                    |    1 +
 net/batman-adv/hard-interface.h                    |    1 -
 net/batman-adv/log.h                               |    3 -
 net/batman-adv/main.c                              |   50 -
 net/batman-adv/main.h                              |    5 +-
 net/batman-adv/mesh-interface.c                    |   15 +-
 net/batman-adv/mesh-interface.h                    |    1 -
 net/batman-adv/netlink.c                           |   17 -
 net/batman-adv/netlink.h                           |    1 -
 net/batman-adv/network-coding.c                    | 1878 -----------------
 net/batman-adv/network-coding.h                    |  106 -
 net/batman-adv/originator.c                        |    6 -
 net/batman-adv/routing.c                           |    9 +-
 net/batman-adv/send.c                              |   16 +-
 net/batman-adv/translation-table.c                 |    4 +-
 net/batman-adv/types.h                             |  216 --
 net/bluetooth/hci_conn.c                           |   27 +-
 net/bluetooth/hci_core.c                           |   52 +-
 net/bluetooth/hci_event.c                          |   16 +-
 net/bluetooth/hci_sync.c                           |   10 +-
 net/bluetooth/iso.c                                |   34 +-
 net/bluetooth/mgmt.c                               |   10 +-
 net/bluetooth/mgmt_config.c                        |    4 +-
 net/bluetooth/sco.c                                |    7 +
 net/bpf/test_run.c                                 |   37 +-
 net/bridge/br.c                                    |   27 +
 net/bridge/br_cfm.c                                |    6 +-
 net/bridge/br_fdb.c                                |  114 +-
 net/bridge/br_forward.c                            |    3 +-
 net/bridge/br_input.c                              |    8 +
 net/bridge/br_mrp.c                                |    8 +-
 net/bridge/br_multicast.c                          |    9 +-
 net/bridge/br_private.h                            |    3 +
 net/bridge/br_vlan.c                               |   10 +-
 net/bridge/netfilter/ebtables.c                    |   14 +-
 net/bridge/netfilter/nft_meta_bridge.c             |   11 +
 net/caif/cfctrl.c                                  |    4 +-
 net/can/af_can.c                                   |    2 +-
 net/can/isotp.c                                    |    2 +-
 net/can/raw.c                                      |   67 +-
 net/ceph/messenger.c                               |    3 +-
 net/ceph/mon_client.c                              |    2 +-
 net/core/Makefile                                  |    1 +
 net/core/datagram.c                                |    2 +-
 net/core/dev.c                                     |  156 +-
 net/core/dev.h                                     |    2 +-
 net/core/devmem.c                                  |    8 +-
 net/core/devmem.h                                  |    2 +
 net/core/dst.c                                     |    2 +-
 net/core/filter.c                                  |  201 +-
 net/core/gro.c                                     |    2 +
 net/core/link_watch.c                              |    4 +-
 net/core/lwt_bpf.c                                 |    4 +-
 net/core/net-procfs.c                              |    3 +-
 net/core/net-sysfs.c                               |    4 +-
 net/core/netdev-genl.c                             |  122 +-
 net/core/netdev_queues.c                           |   27 +
 net/core/netdev_rx_queue.c                         |    9 +
 net/core/netpoll.c                                 |    3 +-
 net/core/page_pool.c                               |   12 +-
 net/core/pktgen.c                                  |    7 +-
 net/core/request_sock.c                            |    4 +-
 net/core/rtnetlink.c                               |   12 +-
 net/core/scm.c                                     |    4 +-
 net/core/skbuff.c                                  |   33 +-
 net/core/skmsg.c                                   |    2 +-
 net/core/sock.c                                    |   94 +-
 net/core/sock_diag.c                               |    2 +-
 net/core/xdp.c                                     |   21 +-
 net/devlink/core.c                                 |    2 +-
 net/devlink/health.c                               |  109 +-
 net/devlink/netlink_gen.c                          |    5 +-
 net/devlink/param.c                                |   10 +
 net/devlink/port.c                                 |   33 +-
 net/ethernet/eth.c                                 |    5 +-
 net/ethtool/Makefile                               |    2 +-
 net/ethtool/common.c                               |   20 +
 net/ethtool/common.h                               |    2 +
 net/ethtool/fec.c                                  |   75 +-
 net/ethtool/ioctl.c                                |   94 +-
 net/ethtool/rss.c                                  |   42 +-
 net/ethtool/tsconfig.c                             |   12 +-
 net/hsr/hsr_slave.c                                |    5 +-
 net/ipv4/af_inet.c                                 |   12 +-
 net/ipv4/arp.c                                     |    2 +-
 net/ipv4/cipso_ipv4.c                              |   13 +-
 net/ipv4/esp4.c                                    |    4 +-
 net/ipv4/fib_frontend.c                            |    7 +-
 net/ipv4/fib_rules.c                               |    4 +-
 net/ipv4/fou_core.c                                |   32 +-
 net/ipv4/fou_nl.c                                  |    4 +-
 net/ipv4/icmp.c                                    |   33 +-
 net/ipv4/inet_connection_sock.c                    |   42 +-
 net/ipv4/inet_diag.c                               |  570 +----
 net/ipv4/inet_fragment.c                           |    2 +-
 net/ipv4/inet_hashtables.c                         |  108 +-
 net/ipv4/inet_timewait_sock.c                      |   11 +-
 net/ipv4/ip_fragment.c                             |    6 +-
 net/ipv4/ip_gre.c                                  |    4 +-
 net/ipv4/ip_input.c                                |   40 +-
 net/ipv4/ip_options.c                              |    5 +-
 net/ipv4/ip_output.c                               |    8 +-
 net/ipv4/ipmr.c                                    |    9 +-
 net/ipv4/netfilter.c                               |    9 +-
 net/ipv4/netfilter/ipt_rpfilter.c                  |    4 +-
 net/ipv4/netfilter/nf_dup_ipv4.c                   |    4 +-
 net/ipv4/netfilter/nf_reject_ipv4.c                |   52 +-
 net/ipv4/netfilter/nf_socket_ipv4.c                |    3 +-
 net/ipv4/netfilter/nf_tproxy_ipv4.c                |    5 +-
 net/ipv4/netfilter/nft_fib_ipv4.c                  |    4 +-
 net/ipv4/nexthop.c                                 |   42 +-
 net/ipv4/ping.c                                    |   68 +-
 net/ipv4/proc.c                                    |   65 +-
 net/ipv4/raw.c                                     |    7 +-
 net/ipv4/raw_diag.c                                |   10 +-
 net/ipv4/route.c                                   |   28 +-
 net/ipv4/syncookies.c                              |    4 +
 net/ipv4/sysctl_net_ipv4.c                         |   19 +
 net/ipv4/tcp.c                                     |  100 +-
 net/ipv4/tcp_ao.c                                  |    5 +-
 net/ipv4/tcp_cdg.c                                 |    2 +-
 net/ipv4/tcp_diag.c                                |  461 +++-
 net/ipv4/tcp_fastopen.c                            |    7 +-
 net/ipv4/tcp_input.c                               |  395 +++-
 net/ipv4/tcp_ipv4.c                                |   89 +-
 net/ipv4/tcp_metrics.c                             |    6 +-
 net/ipv4/tcp_minisocks.c                           |   80 +-
 net/ipv4/tcp_offload.c                             |    4 +-
 net/ipv4/tcp_output.c                              |  332 ++-
 net/ipv4/tcp_timer.c                               |    6 +-
 net/ipv4/udp.c                                     |  171 +-
 net/ipv4/udp_diag.c                                |   10 +-
 net/ipv4/udp_offload.c                             |    2 -
 net/ipv4/udp_tunnel_core.c                         |    3 +-
 net/ipv4/udp_tunnel_nic.c                          |    2 +-
 net/ipv4/xfrm4_policy.c                            |    4 +-
 net/ipv6/Kconfig                                   |    7 +-
 net/ipv6/addrconf.c                                |    4 +-
 net/ipv6/af_inet6.c                                |    2 +-
 net/ipv6/ah6.c                                     |   50 +-
 net/ipv6/anycast.c                                 |    2 +-
 net/ipv6/datagram.c                                |    2 +-
 net/ipv6/esp6.c                                    |    4 +-
 net/ipv6/icmp.c                                    |    9 +-
 net/ipv6/inet6_connection_sock.c                   |    2 +-
 net/ipv6/inet6_hashtables.c                        |   62 +-
 net/ipv6/ip6_gre.c                                 |   10 +-
 net/ipv6/ip6_output.c                              |   70 +-
 net/ipv6/ipv6_sockglue.c                           |    6 +-
 net/ipv6/mcast.c                                   |   67 +-
 net/ipv6/ndisc.c                                   |    4 +-
 net/ipv6/netfilter.c                               |    5 +-
 net/ipv6/netfilter/nf_reject_ipv6.c                |   67 +-
 net/ipv6/netfilter/nf_socket_ipv6.c                |    3 +-
 net/ipv6/netfilter/nf_tproxy_ipv6.c                |    5 +-
 net/ipv6/output_core.c                             |    8 +-
 net/ipv6/ping.c                                    |    1 -
 net/ipv6/proc.c                                    |   91 +-
 net/ipv6/raw.c                                     |   11 +-
 net/ipv6/route.c                                   |   14 +-
 net/ipv6/seg6.c                                    |    7 -
 net/ipv6/seg6_hmac.c                               |  211 +-
 net/ipv6/sit.c                                     |  104 +-
 net/ipv6/syncookies.c                              |    2 +
 net/ipv6/tcp_ipv6.c                                |   56 +-
 net/ipv6/tcpv6_offload.c                           |    3 +-
 net/ipv6/udp.c                                     |   19 +-
 net/ipv6/udp_offload.c                             |    2 -
 net/iucv/af_iucv.c                                 |    4 +-
 net/mac80211/cfg.c                                 |  186 +-
 net/mac80211/chan.c                                |   11 -
 net/mac80211/debugfs.c                             |    3 -
 net/mac80211/debugfs_netdev.c                      |    2 -
 net/mac80211/debugfs_sta.c                         |    2 -
 net/mac80211/ethtool.c                             |    6 +-
 net/mac80211/ieee80211_i.h                         |   17 +-
 net/mac80211/iface.c                               |   25 +-
 net/mac80211/main.c                                |   22 +-
 net/mac80211/mesh.c                                |    3 +
 net/mac80211/mesh_ps.c                             |    2 +-
 net/mac80211/mlme.c                                |   91 +-
 net/mac80211/offchannel.c                          |    5 +-
 net/mac80211/rate.c                                |   11 +-
 net/mac80211/rx.c                                  |   40 +-
 net/mac80211/scan.c                                |   13 +-
 net/mac80211/sta_info.c                            |   15 +-
 net/mac80211/status.c                              |   21 +-
 net/mac80211/tests/Makefile                        |    2 +-
 net/mac80211/tests/s1g_tim.c                       |  356 ++++
 net/mac80211/tx.c                                  |  187 +-
 net/mac80211/util.c                                |   67 +-
 net/mctp/af_mctp.c                                 |    2 +-
 net/mptcp/crypto.c                                 |   35 +-
 net/mptcp/ctrl.c                                   |    9 +-
 net/mptcp/mib.c                                    |   12 +-
 net/mptcp/mptcp_diag.c                             |   15 +-
 net/mptcp/pm.c                                     |   60 +-
 net/mptcp/pm_kernel.c                              |  569 +++--
 net/mptcp/pm_netlink.c                             |   11 +-
 net/mptcp/pm_userspace.c                           |    2 +-
 net/mptcp/protocol.c                               |  218 +-
 net/mptcp/protocol.h                               |   29 +-
 net/mptcp/sockopt.c                                |   22 +-
 net/mptcp/subflow.c                                |   11 +-
 net/netfilter/ipset/ip_set_hash_gen.h              |    8 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |    4 +-
 net/netfilter/ipvs/ip_vs_core.c                    |   11 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |    6 +-
 net/netfilter/ipvs/ip_vs_est.c                     |   16 +-
 net/netfilter/ipvs/ip_vs_ftp.c                     |    4 +-
 net/netfilter/nf_conntrack_ecache.c                |    2 +-
 net/netfilter/nf_conntrack_netlink.c               |   39 +-
 net/netfilter/nf_conntrack_standalone.c            |    3 +
 net/netfilter/nf_tables_api.c                      |   47 +-
 net/netfilter/nfnetlink.c                          |    2 +
 net/netfilter/nft_flow_offload.c                   |    4 +-
 net/netfilter/nft_payload.c                        |   20 +-
 net/netfilter/nft_set_hash.c                       |  100 +-
 net/netfilter/nft_set_pipapo.c                     |   96 +-
 net/netfilter/nft_set_pipapo.h                     |    8 +-
 net/netfilter/nft_set_pipapo_avx2.c                |  142 +-
 net/netfilter/nft_set_pipapo_avx2.h                |    4 +
 net/netfilter/nft_set_rbtree.c                     |   35 +-
 net/netlink/af_netlink.c                           |    4 +-
 net/nfc/nci/ntf.c                                  |  135 +-
 net/openvswitch/dp_notify.c                        |    2 +-
 net/openvswitch/flow.c                             |   12 +-
 net/openvswitch/flow_table.c                       |    7 +-
 net/packet/af_packet.c                             |  134 +-
 net/packet/diag.c                                  |    2 +-
 net/packet/internal.h                              |   14 +-
 net/phonet/af_phonet.c                             |    4 +-
 net/phonet/pep.c                                   |    6 +-
 net/phonet/socket.c                                |   25 +-
 net/psp/Kconfig                                    |   15 +
 net/psp/Makefile                                   |    5 +
 net/psp/psp-nl-gen.c                               |  119 ++
 net/psp/psp-nl-gen.h                               |   39 +
 net/psp/psp.h                                      |   54 +
 net/psp/psp_main.c                                 |  322 +++
 net/psp/psp_nl.c                                   |  505 +++++
 net/psp/psp_sock.c                                 |  292 +++
 net/rds/af_rds.c                                   |    2 +-
 net/rds/connection.c                               |    9 +-
 net/rds/ib_mr.h                                    |    1 -
 net/rds/ib_rdma.c                                  |    3 +-
 net/rds/ib_recv.c                                  |    2 +-
 net/rds/message.c                                  |    4 +-
 net/rds/rds.h                                      |    2 +-
 net/rds/recv.c                                     |    4 +-
 net/rds/send.c                                     |    4 +-
 net/rfkill/input.c                                 |    2 +-
 net/rxrpc/rxperf.c                                 |    2 +-
 net/sched/act_api.c                                |   12 +-
 net/sched/act_simple.c                             |    1 -
 net/sched/act_skbmod.c                             |   22 +-
 net/sched/act_tunnel_key.c                         |   16 +-
 net/sched/act_vlan.c                               |   16 +-
 net/sched/sch_api.c                                |    4 +-
 net/sctp/Kconfig                                   |   47 +-
 net/sctp/auth.c                                    |  166 +-
 net/sctp/chunk.c                                   |    3 +-
 net/sctp/diag.c                                    |    2 +-
 net/sctp/endpointola.c                             |   23 +-
 net/sctp/proc.c                                    |   12 +-
 net/sctp/protocol.c                                |   14 +-
 net/sctp/sm_make_chunk.c                           |   60 +-
 net/sctp/sm_statefuns.c                            |    5 +-
 net/sctp/socket.c                                  |   41 +-
 net/sctp/sysctl.c                                  |   49 +-
 net/smc/Kconfig                                    |   16 +-
 net/smc/Makefile                                   |    1 -
 net/smc/af_smc.c                                   |   30 +-
 net/smc/smc_clc.c                                  |   73 +-
 net/smc/smc_core.c                                 |   37 +-
 net/smc/smc_core.h                                 |    5 +
 net/smc/smc_diag.c                                 |    2 +-
 net/smc/smc_ib.c                                   |   18 +-
 net/smc/smc_ism.c                                  |  233 +-
 net/smc/smc_ism.h                                  |   36 +-
 net/smc/smc_loopback.c                             |  425 ----
 net/smc/smc_loopback.h                             |   60 -
 net/smc/smc_pnet.c                                 |   70 +-
 net/smc/smc_tx.c                                   |    3 +
 net/socket.c                                       |   35 +-
 net/tipc/addr.c                                    |    6 +-
 net/tipc/addr.h                                    |    2 +-
 net/tipc/link.c                                    |    9 +-
 net/tipc/socket.c                                  |    6 +-
 net/tls/tls.h                                      |    3 +-
 net/tls/tls_device.c                               |   20 +-
 net/tls/tls_proc.c                                 |   10 +-
 net/unix/garbage.c                                 |    2 +-
 net/vmw_vsock/af_vsock.c                           |    9 +-
 net/vmw_vsock/virtio_transport.c                   |    2 +-
 net/vmw_vsock/vsock_loopback.c                     |    2 +-
 net/wireless/chan.c                                |  103 +-
 net/wireless/core.c                                |    9 +
 net/wireless/ethtool.c                             |    2 +-
 net/wireless/nl80211.c                             |  805 ++++++-
 net/wireless/reg.c                                 |   76 +-
 net/wireless/scan.c                                |    9 +-
 net/wireless/trace.h                               |   91 +-
 net/wireless/util.c                                |   31 +-
 net/xdp/xsk.c                                      |  113 +-
 net/xfrm/xfrm_policy.c                             |   16 +-
 net/xfrm/xfrm_proc.c                               |   12 +-
 net/xfrm/xfrm_user.c                               |   10 +-
 rust/kernel/net/phy.rs                             |    7 +-
 scripts/coccinelle/misc/ptr_err_to_pe.cocci        |   34 +
 scripts/headers_install.sh                         |    2 +-
 tools/net/ynl/Makefile.deps                        |    1 +
 tools/net/ynl/lib/ynl-priv.h                       |   10 +-
 tools/net/ynl/lib/ynl.c                            |    6 +-
 tools/net/ynl/pyynl/ethtool.py                     |   14 +-
 tools/net/ynl/pyynl/lib/__init__.py                |    4 +-
 tools/net/ynl/pyynl/lib/doc_generator.py           |  402 ++++
 tools/net/ynl/pyynl/lib/nlspec.py                  |    2 +-
 tools/net/ynl/pyynl/lib/ynl.py                     |   45 +-
 tools/net/ynl/pyynl/ynl_gen_c.py                   |  135 +-
 tools/net/ynl/pyynl/ynl_gen_rst.py                 |  384 +---
 tools/testing/selftests/Makefile                   |    2 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h           |    3 +
 tools/testing/selftests/bpf/config                 |    1 +
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |    2 +
 .../bpf/prog_tests/xdp_context_test_run.c          |  222 +-
 .../selftests/bpf/prog_tests/xdp_pull_data.c       |  179 ++
 tools/testing/selftests/bpf/progs/bpf_iter_udp4.c  |    3 +-
 tools/testing/selftests/bpf/progs/bpf_iter_udp6.c  |    4 +-
 tools/testing/selftests/bpf/progs/dynptr_fail.c    |  258 +++
 tools/testing/selftests/bpf/progs/dynptr_success.c |   55 +
 tools/testing/selftests/bpf/progs/mptcp_subflow.c  |    2 +-
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  419 ++++
 .../selftests/bpf/progs/test_xdp_pull_data.c       |   48 +
 tools/testing/selftests/drivers/net/.gitignore     |    1 +
 tools/testing/selftests/drivers/net/Makefile       |   10 +
 .../testing/selftests/drivers/net/bonding/Makefile |    4 +-
 .../drivers/net/bonding/bond_ipsec_offload.sh      |  156 ++
 .../drivers/net/bonding/bond_lacp_prio.sh          |  108 +
 tools/testing/selftests/drivers/net/bonding/config |    4 +
 tools/testing/selftests/drivers/net/config         |    5 +-
 tools/testing/selftests/drivers/net/hds.py         |   39 +
 tools/testing/selftests/drivers/net/hw/Makefile    |    2 +
 tools/testing/selftests/drivers/net/hw/config      |    2 +
 tools/testing/selftests/drivers/net/hw/devmem.py   |   14 +-
 .../selftests/drivers/net/hw/lib/py/__init__.py    |    4 +-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  |  856 ++++++--
 .../selftests/drivers/net/hw/nic_timestamp.py      |  113 +
 tools/testing/selftests/drivers/net/hw/rss_ctx.py  |   18 +-
 .../selftests/drivers/net/hw/rss_flow_label.py     |  167 ++
 tools/testing/selftests/drivers/net/hw/tso.py      |   11 +-
 .../selftests/drivers/net/lib/py/__init__.py       |    6 +-
 tools/testing/selftests/drivers/net/lib/py/env.py  |   45 +-
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |   10 +-
 .../drivers/net/mlxsw/devlink_trap_policer.sh      |    9 +-
 .../selftests/drivers/net/mlxsw/qos_ets_strict.sh  |   12 +-
 .../drivers/net/mlxsw/qos_max_descriptors.sh       |    9 +-
 .../selftests/drivers/net/mlxsw/qos_mc_aware.sh    |   12 +-
 .../selftests/drivers/net/mlxsw/sch_red_core.sh    |    6 +-
 .../testing/selftests/drivers/net/napi_threaded.py |   34 +-
 .../selftests/drivers/net/netcons_cmdline.sh       |   55 +-
 tools/testing/selftests/drivers/net/psp.py         |  627 ++++++
 .../testing/selftests/drivers/net/psp_responder.c  |  483 +++++
 tools/testing/selftests/drivers/net/stats.py       |   35 +-
 tools/testing/selftests/drivers/net/team/Makefile  |    6 +-
 tools/testing/selftests/drivers/net/team/config    |    1 +
 .../testing/selftests/drivers/net/team/options.sh  |  188 ++
 tools/testing/selftests/drivers/net/xdp.py         |   75 +-
 tools/testing/selftests/net/.gitignore             |    2 +
 tools/testing/selftests/net/Makefile               |   11 +-
 tools/testing/selftests/net/af_unix/Makefile       |    2 +-
 tools/testing/selftests/net/af_unix/scm_inq.c      |   26 +-
 tools/testing/selftests/net/af_unix/scm_pidfd.c    |    2 -
 tools/testing/selftests/net/af_unix/scm_rights.c   |   28 +-
 tools/testing/selftests/net/bpf_offload.py         |    4 +-
 tools/testing/selftests/net/cmsg_sender.c          |   10 +-
 tools/testing/selftests/net/config                 |    1 +
 tools/testing/selftests/net/fcnal-ipv4.sh          |    2 +
 tools/testing/selftests/net/fcnal-ipv6.sh          |    2 +
 tools/testing/selftests/net/fcnal-other.sh         |    2 +
 tools/testing/selftests/net/fcnal-test.sh          |  435 ++--
 tools/testing/selftests/net/fdb_notify.sh          |   26 +-
 tools/testing/selftests/net/forwarding/Makefile    |    5 +-
 tools/testing/selftests/net/forwarding/README      |   15 +
 .../net/forwarding/bridge_activity_notify.sh       |  170 ++
 .../net/forwarding/bridge_fdb_local_vlan_0.sh      |  387 ++++
 .../net/forwarding/custom_multipath_hash.sh        |    2 +-
 .../net/forwarding/gre_custom_multipath_hash.sh    |    2 +-
 .../net/forwarding/ip6_forward_instats_vrf.sh      |    6 +-
 .../net/forwarding/ip6gre_custom_multipath_hash.sh |    2 +-
 tools/testing/selftests/net/forwarding/lib.sh      |   50 +-
 .../net/forwarding/mirror_gre_bridge_1q_lag.sh     |    2 +-
 .../net/forwarding/mirror_gre_vlan_bridge_1q.sh    |    4 +-
 .../selftests/net/forwarding/sch_ets_core.sh       |    9 +-
 tools/testing/selftests/net/forwarding/sch_red.sh  |   12 +-
 .../selftests/net/forwarding/sch_tbf_core.sh       |    6 +-
 .../net/forwarding/vxlan_bridge_1q_mc_ul.sh        |  141 +-
 .../selftests/net/forwarding/vxlan_reserved.sh     |   33 +-
 tools/testing/selftests/net/gro.c                  |   58 +-
 tools/testing/selftests/net/gro.sh                 |    2 +-
 tools/testing/selftests/net/ipv6_fragmentation.c   |  114 +
 tools/testing/selftests/net/lib.sh                 |   72 +-
 tools/testing/selftests/net/lib/py/__init__.py     |    2 +-
 tools/testing/selftests/net/lib/py/ksft.py         |   10 +
 tools/testing/selftests/net/lib/py/utils.py        |   45 +-
 tools/testing/selftests/net/lib/py/ynl.py          |    5 +
 tools/testing/selftests/net/lib/sh/defer.sh        |   20 +-
 tools/testing/selftests/net/lib/xdp_native.bpf.c   |   98 +-
 tools/testing/selftests/net/mptcp/mptcp_inq.c      |    9 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  228 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c  |    9 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c      |   18 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |    2 +-
 tools/testing/selftests/net/netfilter/config       |    1 +
 .../selftests/net/netfilter/nft_concat_range.sh    |   56 +-
 tools/testing/selftests/net/netfilter/nft_nat.sh   |    4 +-
 tools/testing/selftests/net/netlink-dumps.c        |   43 +-
 .../testing/selftests/net/openvswitch/ovs-dpctl.py |    2 +-
 .../testing/selftests/net/packetdrill/defaults.sh  |    3 +-
 .../selftests/net/packetdrill/ksft_runner.sh       |   53 +-
 .../selftests/net/packetdrill/tcp_close_no_rst.pkt |   32 +
 .../tcp_fastopen_server_basic-cookie-not-reqd.pkt  |   32 +
 .../tcp_fastopen_server_basic-no-setsockopt.pkt    |   21 +
 .../tcp_fastopen_server_basic-non-tfo-listener.pkt |   26 +
 .../tcp_fastopen_server_basic-pure-syn-data.pkt    |   50 +
 .../packetdrill/tcp_fastopen_server_basic-rw.pkt   |   23 +
 .../tcp_fastopen_server_basic-zero-payload.pkt     |   26 +
 ...ent-ack-dropped-then-recovery-ms-timestamps.pkt |   46 +
 .../tcp_fastopen_server_experimental_option.pkt    |   37 +
 .../tcp_fastopen_server_fin-close-socket.pkt       |   30 +
 .../tcp_fastopen_server_icmp-before-accept.pkt     |   49 +
 .../tcp_fastopen_server_reset-after-accept.pkt     |   37 +
 .../tcp_fastopen_server_reset-before-accept.pkt    |   32 +
 ...astopen_server_reset-close-with-unread-data.pkt |   32 +
 .../tcp_fastopen_server_reset-non-tfo-socket.pkt   |   37 +
 .../tcp_fastopen_server_sockopt-fastopen-key.pkt   |   74 +
 ...fastopen_server_trigger-rst-listener-closed.pkt |   21 +
 ... tcp_fastopen_server_trigger-rst-reconnect.pkt} |   10 +-
 ...topen_server_trigger-rst-unread-data-closed.pkt |   23 +
 tools/testing/selftests/net/pmtu.sh                |    9 +-
 tools/testing/selftests/net/psock_tpacket.c        |    4 +-
 tools/testing/selftests/net/route_hint.sh          |   79 +
 tools/testing/selftests/net/rps_default_mask.sh    |   12 +-
 tools/testing/selftests/net/rtnetlink.sh           |   15 +-
 tools/testing/selftests/net/socket.c               |   11 +-
 tools/testing/selftests/net/tcp_port_share.c       |  258 +++
 .../selftests/net/test_bridge_backup_port.sh       |   31 +-
 .../selftests/net/test_vxlan_fdb_changelink.sh     |    8 +-
 tools/testing/selftests/net/tfo_passive.sh         |    2 +-
 tools/testing/selftests/net/tls.c                  |    5 +
 tools/testing/selftests/net/traceroute.sh          |  250 ++-
 tools/testing/selftests/net/vlan_bridge_binding.sh |   44 +-
 tools/testing/selftests/net/ynl.mk                 |    5 +-
 .../tc-testing/tc-tests/actions/police.json        |    2 +-
 .../testing/selftests/wireguard/qemu/kernel.config |    8 +-
 tools/testing/vsock/util.c                         |    1 -
 1565 files changed, 81089 insertions(+), 27895 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-framer-pef2256
 create mode 100644 Documentation/devicetree/bindings/net/apm,xgene-enet.yaml
 create mode 100644 Documentation/devicetree/bindings/net/apm,xgene-mdio-rgmii.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/apm-xgene-enet.txt
 delete mode 100644 Documentation/devicetree/bindings/net/apm-xgene-mdio.txt
 delete mode 100644 Documentation/devicetree/bindings/net/brcm,bcm7445-switch-v4.0.txt
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/skyworks,si3474.yaml
 create mode 100644 Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
 create mode 100644 Documentation/devicetree/bindings/net/spacemit,k1-emac.yaml
 create mode 100644 Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
 create mode 100644 Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
 create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
 create mode 100644 Documentation/netlink/specs/index.rst
 create mode 100644 Documentation/netlink/specs/psp.yaml
 create mode 100644 Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst
 delete mode 100644 Documentation/networking/netlink_spec/.gitignore
 delete mode 100644 Documentation/networking/netlink_spec/readme.txt
 create mode 100644 Documentation/networking/psp.rst
 create mode 100755 Documentation/sphinx/parser_yaml.py
 delete mode 100644 drivers/bluetooth/h4_recv.h
 create mode 100644 drivers/dibs/Kconfig
 create mode 100644 drivers/dibs/Makefile
 create mode 100644 drivers/dibs/dibs_loopback.c
 create mode 100644 drivers/dibs/dibs_loopback.h
 create mode 100644 drivers/dibs/dibs_main.c
 create mode 100644 drivers/dpll/zl3073x/flash.c
 create mode 100644 drivers/dpll/zl3073x/flash.h
 create mode 100644 drivers/dpll/zl3073x/fw.c
 create mode 100644 drivers/dpll/zl3073x/fw.h
 delete mode 100644 drivers/net/dsa/dsa_loop.h
 delete mode 100644 drivers/net/dsa/dsa_loop_bdinfo.c
 rename drivers/net/{phy/spi_ks8995.c => dsa/ks8995.c} (50%)
 create mode 100644 drivers/net/dsa/lantiq/Kconfig
 create mode 100644 drivers/net/dsa/lantiq/Makefile
 rename drivers/net/dsa/{ => lantiq}/lantiq_gswip.c (80%)
 create mode 100644 drivers/net/dsa/lantiq/lantiq_gswip.h
 rename drivers/net/dsa/{ => lantiq}/lantiq_pce.h (98%)
 delete mode 100644 drivers/net/ethernet/airoha/airoha_npu.h
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-pps.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_db.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_rss.h
 delete mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.c
 delete mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.h
 rename drivers/net/ethernet/intel/ice/{ice_virtchnl_allowlist.c => virt/allowlist.c} (99%)
 rename drivers/net/ethernet/intel/ice/{ice_virtchnl_allowlist.h => virt/allowlist.h} (100%)
 rename drivers/net/ethernet/intel/ice/{ice_virtchnl_fdir.c => virt/fdir.c} (100%)
 rename drivers/net/ethernet/intel/ice/{ice_virtchnl_fdir.h => virt/fdir.h} (100%)
 create mode 100644 drivers/net/ethernet/intel/ice/virt/queues.c
 create mode 100644 drivers/net/ethernet/intel/ice/virt/queues.h
 create mode 100644 drivers/net/ethernet/intel/ice/virt/rss.c
 create mode 100644 drivers/net/ethernet/intel/ice/virt/rss.h
 rename drivers/net/ethernet/intel/ice/{ice_virtchnl.c => virt/virtchnl.c} (62%)
 rename drivers/net/ethernet/intel/ice/{ice_virtchnl.h => virt/virtchnl.h} (100%)
 create mode 100644 drivers/net/ethernet/intel/idpf/xdp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/xdp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/xsk.c
 create mode 100644 drivers/net/ethernet/intel/idpf/xsk.h
 create mode 100644 drivers/net/ethernet/intel/libie/fwlog.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/Makefile
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe.c
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe.h
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe_config.c
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe_config.h
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.h
 create mode 100644 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
 create mode 100644 drivers/net/ethernet/renesas/rswitch_l2.c
 create mode 100644 drivers/net/ethernet/renesas/rswitch_l2.h
 rename drivers/net/ethernet/renesas/{rswitch.c => rswitch_main.c} (95%)
 create mode 100644 drivers/net/ethernet/spacemit/Kconfig
 create mode 100644 drivers/net/ethernet/spacemit/Makefile
 create mode 100644 drivers/net/ethernet/spacemit/k1_emac.c
 create mode 100644 drivers/net/ethernet/spacemit/k1_emac.h
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_ptp.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_switch.h
 create mode 100644 drivers/net/netdevsim/psp.c
 delete mode 100644 drivers/net/phy/mdio-boardinfo.c
 delete mode 100644 drivers/net/phy/mdio-boardinfo.h
 create mode 100644 drivers/net/pse-pd/si3474.c
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/nvm_parse.c
 create mode 100644 drivers/ptp/ptp_netc.c
 delete mode 100644 drivers/ptp/ptp_qoriq_debugfs.c
 create mode 100644 include/dt-bindings/net/renesas,r9a09g077-pcs-miic.h
 create mode 100644 include/linux/dibs.h
 create mode 100644 include/linux/net/intel/libie/fwlog.h
 create mode 100644 include/linux/soc/airoha/airoha_offload.h
 create mode 100644 include/net/psp.h
 create mode 100644 include/net/psp/functions.h
 create mode 100644 include/net/psp/types.h
 create mode 100644 include/net/tcp_ecn.h
 create mode 100644 include/uapi/linux/psp.h
 delete mode 100644 net/batman-adv/network-coding.c
 delete mode 100644 net/batman-adv/network-coding.h
 create mode 100644 net/core/netdev_queues.c
 create mode 100644 net/mac80211/tests/s1g_tim.c
 create mode 100644 net/psp/Kconfig
 create mode 100644 net/psp/Makefile
 create mode 100644 net/psp/psp-nl-gen.c
 create mode 100644 net/psp/psp-nl-gen.h
 create mode 100644 net/psp/psp.h
 create mode 100644 net/psp/psp_main.c
 create mode 100644 net/psp/psp_nl.c
 create mode 100644 net/psp/psp_sock.c
 delete mode 100644 net/smc/smc_loopback.c
 delete mode 100644 net/smc/smc_loopback.h
 create mode 100644 scripts/coccinelle/misc/ptr_err_to_pe.cocci
 create mode 100644 tools/net/ynl/pyynl/lib/doc_generator.py
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh
 create mode 100755 tools/testing/selftests/drivers/net/hw/nic_timestamp.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_flow_label.py
 create mode 100755 tools/testing/selftests/drivers/net/psp.py
 create mode 100644 tools/testing/selftests/drivers/net/psp_responder.c
 create mode 100755 tools/testing/selftests/drivers/net/team/options.sh
 create mode 100755 tools/testing/selftests/net/fcnal-ipv4.sh
 create mode 100755 tools/testing/selftests/net/fcnal-ipv6.sh
 create mode 100755 tools/testing/selftests/net/fcnal-other.sh
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_activity_notify.sh
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
 create mode 100644 tools/testing/selftests/net/ipv6_fragmentation.c
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_close_no_rst.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-cookie-not-reqd.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-no-setsockopt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-non-tfo-listener.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-pure-syn-data.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-rw.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-zero-payload.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_client-ack-dropped-then-recovery-ms-timestamps.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_experimental_option.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_fin-close-socket.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_icmp-before-accept.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-after-accept.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-before-accept.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-close-with-unread-data.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-non-tfo-socket.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_sockopt-fastopen-key.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-listener-closed.pkt
 rename tools/testing/selftests/net/packetdrill/{tcp_fastopen_server_reset-after-disconnect.pkt => tcp_fastopen_server_trigger-rst-reconnect.pkt} (66%)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-unread-data-closed.pkt
 create mode 100755 tools/testing/selftests/net/route_hint.sh
 create mode 100644 tools/testing/selftests/net/tcp_port_share.c


