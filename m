Return-Path: <bpf+bounces-45213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47CA9D2ABA
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 17:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 753F2B28983
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 16:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B151D0B8A;
	Tue, 19 Nov 2024 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JzrsD9Jv"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4121D042D
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033202; cv=none; b=UrOthwseAnzzRdOrHCg2yaUmsk89VsG7EmTHGjccrIjXuJrFNhLD0TNPBIEPAebooNR+nanx6AiC2n2uyd3KwPEkuUBWXvdQ167eiJ2CrH7/Avc5b5nfpMHJOCvc3ogPeyV546vMYeAPM17e1qLnyn6UuScrfi5HG6Y/Ty4b1qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033202; c=relaxed/simple;
	bh=Ed55eWmLmTsEmDvYR0hl4RmHjYzf82R9xzUn4Haa3lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nhpLvzKXmjrCNpEcLYQSfNNZeU8C9bLWL1J3ziTVB91GtP8kVtSxsBxVC1PIyn+ZQoj03xu9avyu4JMQqyiXGAVXeUVeedF4gYjn4NHIlhmQ3dbD1H2kCl49d/W6b/O/SkZtJNbR/IRkyd1RES6KEkq1GG/6RMHnyjCyddeLB2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JzrsD9Jv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732033192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4L3knCB1HC6eTfcN/cEPuas//I5I+Uq8X0YylwRVReM=;
	b=JzrsD9JvCFP+6n6EMb5kIoX+I2hcKNlyC8fwYiios4r1M8yNINDRn7bXcvJLbFvtqzmkF2
	3grt5Alblijr7ZnqgsGlGQfAWrRKsQXvl8FroGf4AkrFLHYzn55fmuQpJS8Udf99xfy0qA
	KHPjBFx2hhym6ElPVbWXmfvNULhImBQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-EvX_X-__Nwa9CYpIcQ9suA-1; Tue,
 19 Nov 2024 11:19:46 -0500
X-MC-Unique: EvX_X-__Nwa9CYpIcQ9suA-1
X-Mimecast-MFC-AGG-ID: EvX_X-__Nwa9CYpIcQ9suA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D893D19772EB;
	Tue, 19 Nov 2024 16:19:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.108])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AED0719560A3;
	Tue, 19 Nov 2024 16:19:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [GIT PULL] Networking for v6.13
Date: Tue, 19 Nov 2024 17:19:23 +0100
Message-ID: <20241119161923.29062-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Linus!

Stephen reported a trivial conflict in the MAINTAINERS file:
https://lore.kernel.org/linux-next/20241107214351.59b251f1@canb.auug.org.au/

and another one in tools/testing/selftests/bpf/Makefile:
https://lore.kernel.org/linux-next/20241104115924.2615858f@canb.auug.org.au/

The following changes since commit cfaaa7d010d1fc58f9717fcc8591201e741d2d49:

  Merge tag 'net-6.12-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-11-14 10:05:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.13

for you to fetch changes up to dd7207838d38780b51e4690ee508ab2d5057e099:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-11-19 13:56:02 +0100)

----------------------------------------------------------------
Networking changes for 6.13.

The most significant set of changes is the per netns RTNL. The new
behavior is disabled by default, regression risk should be contained.

Notably the new config knob PTP_1588_CLOCK_VMCLOCK will inherit its
default value from PTP_1588_CLOCK_KVM, as the first is intended to be
a more reliable replacement for the latter.

Core
----

 - Started a very large, in-progress, effort to make the RTNL lock
   scope per network-namespace, thus reducing the lock contention
   significantly in the containerized use-case, comprising:
   - RCU-ified some relevant slices of the FIB control path
   - introduce basic per netns locking helpers
   - namespacified the IPv4 address hash table
   - remove rtnl_register{,_module}() in favour of rtnl_register_many()
   - refactor rtnl_{new,del,set}link() moving as much validation as
     possible out of RTNL lock
   - convert all phonet doit() and dumpit() handlers to RCU
   - convert IPv4 addresses manipulation to per-netns RTNL
   - convert virtual interface creation to per-netns RTNL
   the per-netns lock infra is guarded by the CONFIG_DEBUG_NET_SMALL_RTNL
   knob, disabled by default ad interim.

 - Introduce NAPI suspension, to efficiently switching between busy
   polling (NAPI processing suspended) and normal processing.

 - Migrate the IPv4 routing input, output and control path from direct
   ToS usage to DSCP macros. This is a work in progress to make ECN
   handling consistent and reliable.

 - Add drop reasons support to the IPv4 rotue input path, allowing
   better introspection in case of packets drop.

 - Make FIB seqnum lockless, dropping RTNL protection for read
   access.

 - Make inet{,v6} addresses hashing less predicable.

 - Allow providing timestamp OPT_ID via cmsg, to correlate TX packets
   and timestamps

Things we sprinkled into general kernel code
--------------------------------------------

 - Add small file operations for debugfs, to reduce the struct ops size.

 - Refactoring and optimization for the implementation of page_frag API,
   This is a preparatory work to consolidate the page_frag
   implementation.

Netfilter
---------

 - Optimize set element transactions to reduce memory consumption

 - Extended netlink error reporting for attribute parser failure.

 - Make legacy xtables configs user selectable, giving users
   the option to configure iptables without enabling any other config.

 - Address a lot of false-positive RCU issues, pointed by recent
   CI improvements.

BPF
---

 - Put xsk sockets on a struct diet and add various cleanups. Overall,
   this helps to bump performance by 12% for some workloads.

 - Extend BPF selftests to increase coverage of XDP features in
   combination with BPF cpumap.

 - Optimize and homogenize bpf_csum_diff helper for all archs and also
   add a batch of new BPF selftests for it.

 - Extend netkit with an option to delegate skb->{mark,priority}
   scrubbing to its BPF program.

 - Make the bpf_get_netns_cookie() helper available also to tc(x) BPF
   programs.

Protocols
---------

 - Introduces 4-tuple hash for connected udp sockets, speeding-up
   significantly connected sockets lookup.

 - Add a fastpath for some TCP timers that usually expires after close,
   the socket lock contention.

 - Add inbound and outbound xfrm state caches to speed up state lookups.

 - Avoid sending MPTCP advertisements on stale subflows, reducing
   risks on loosing them.

 - Make neighbours table flushing more scalable, maintaining per device
   neigh lists.

Driver API
----------

 - Introduce a unified interface to configure transmission H/W shaping,
   and expose it to user-space via generic-netlink.

 - Add support for per-NAPI config via netlink. This makes napi
   configuration persistent across queues removal and re-creation.
   Requires driver updates, currently supported drivers are:
   nVidia/Mellanox mlx4 and mlx5, Broadcom brcm and Intel ice.

 - Add ethtool support for writing SFP / PHY firmware blocks.

 - Track RSS context allocation from ethtool core.

 - Implement support for mirroring to DSA CPU port, via TC mirror
   offload.

 - Consolidate FDB updates notification, to avoid duplicates on
   device-specific entries.

 - Expose DPLL clock quality level to the user-space.

 - Support master-slave PHY config via device tree.

Tests and tooling
-----------------

 - forwarding: introduce deferred commands, to simplify
   the cleanup phase

Drivers
-------

 - Updated several drivers - Amazon vNic, Google vNic, Microsoft vNic,
   Intel e1000e and Broadcom Tigon3 - to use netdev-genl to link the
   IRQs and queues to NAPI IDs, allowing busy polling and better
   introspection.

 - Ethernet high-speed NICs:
   - nVidia/Mellanox:
     - mlx5:
       - a large refactor to implement support for cross E-Switch
         scheduling
       - refactor H/W conter management to let it scale better
       - H/W GRO cleanups
   - Intel (100G, ice)::
     - adds support for ethtool reset
     - implement support for per TX queue H/W shaping
   - AMD/Solarflare:
     - implement per device queue stats support
   - Broadcom (bnxt):
     - improve wildcard l4proto on IPv4/IPv6 ntuple rules
   - Marvell Octeon:
     - Adds representor support for each Resource Virtualization Unit
       (RVU) device.
   - Hisilicon:
     - adds support for the BMC Gigabit Ethernet
   - IBM (EMAC):
     - driver cleanup and modernization
   - Cisco (VIC):
     - raise the queues number limit to 256

 - Ethernet virtual:
   - Google vNIC:
     - implements page pool support
   - macsec:
     - inherit lower device's features and TSO limits when offloading
   - virtio_net:
     - enable premapped mode by default
     - support for XDP socket(AF_XDP) zerocopy TX
   - wireguard:
     - set the TSO max size to be GSO_MAX_SIZE, to aggregate larger
       packets.

 - Ethernet NICs embedded and virtual:
   - Broadcom ASP:
     - enable software timestamping
   - Freescale:
     - add enetc4 PF driver
   - MediaTek: Airoha SoC:
     - implement BQL support
   - RealTek r8169:
     - enable TSO by default on r8168/r8125
     - implement extended ethtool stats
   - Renesas AVB:
     - enable TX checksum offload
   - Synopsys (stmmac):
     - support header splitting for vlan tagged packets
     - move common code for DWMAC4 and DWXGMAC into a separate FPE
       module.
     - Add the dwmac driver support for T-HEAD TH1520 SoC
   - Synopsys (xpcs):
     - driver refactor and cleanup
   - TI:
     - icssg_prueth: add VLAN offload support
   - Xilinx emaclite:
     - adds clock support

 - Ethernet switches:
   - Microchip:
     - implement support for the lan969x Ethernet switch family
     - add LAN9646 switch support to KSZ DSA driver

 - Ethernet PHYs:
   - Marvel: 88q2x: enable auto negotiation
   - Microchip: add support for LAN865X Rev B1 and LAN867X Rev C1/C2

 - PTP:
   - Add support for the Amazon virtual clock device
   - Add PtP driver for s390 clocks

 - WiFi:
   - mac80211
     - EHT 1024 aggregation size for transmissions
     - new operation to indicate that a new interface is to be added
     - support radio separation of multi-band devices
     - move wireless extension spy implementation to libiw
   - Broadcom:
     - brcmfmac: optional LPO clock support
   - Microchip:
     - add support for Atmel WILC3000
   - Qualcomm (ath12k):
     - firmware coredump collection support
     - add debugfs support for a multitude of statistics
   - Qualcomm (ath5k):
     -  Arcadyan ARV45XX AR2417 & Gigaset SX76[23] AR241[34]A support
   - Realtek:
     - rtw88: 8821au and 8812au USB adapters support
     - rtw89: add thermal protection
     - rtw89: fine tune BT-coexsitence to improve user experience
     - rtw89: firmware secure boot for WiFi 6 chip

 - Bluetooth
     - add Qualcomm WCN785x support for ids Foxconn 0xe0fc/0xe0f3 and
       0x13d3:0x3623
     - add Realtek RTL8852BE support for id Foxconn 0xe123
     - add MediaTek MT7920 support for wireless module ids
     - btintel_pcie: add handshake between driver and firmware
     - btintel_pcie: add recovery mechanism
     - btnxpuart: add GPIO support to power save feature

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Aaron Conole (1):
      openvswitch: Pass on secpath details for internal port rx.

Aaron Ma (1):
      Bluetooth: btusb: add Foxconn 0xe0fc for Qualcomm WCN785x

Abhinav Saxena (1):
      tc: fix typo probabilty in tc.yaml doc

Abhishek Chauhan (1):
      net: stmmac: Programming sequence for VLAN packets with split header

Abin Joseph (3):
      dt-bindings: net: emaclite: Add clock support
      net: emaclite: Replace alloc_etherdev() with devm_alloc_etherdev()
      net: emaclite: Adopt clock support

Aditya Kumar Singh (1):
      wifi: mac80211: re-order assigning channel in activate links

Ajay Singh (1):
      wifi: wilc1000: Add WILC3000 support

Aleksander Jan Bajkowski (1):
      net: macb: Adding support for Jumbo Frames up to 10240 Bytes in SAMA5D2

Aleksandr Mishin (1):
      fsl/fman: Validate cell-index value obtained from Device Tree

Aleksei Vetrov (1):
      wifi: nl80211: fix bounds checker error in nl80211_parse_sched_scan

Ales Nezbeda (1):
      netdevsim: macsec: pad u64 to correct length in logs

Alexander Zubkov (1):
      Fix misspelling of "accept*" in net

Alexandre Ferrieux (1):
      ipv4: avoid quadratic behavior in FIB insertion of common address

Alexis Lothoré (eBPF Foundation) (10):
      selftests/bpf: add missing header include for htons
      selftests/bpf: fix bpf_map_redirect call for cpu map test
      selftests/bpf: make xdp_cpumap_attach keep redirect prog attached
      selftests/bpf: check program redirect in xdp_cpumap_attach
      selftests/bpf: factorize conn and syncookies tests in a single runner
      selftests/bpf: add missing ns cleanups in btf_skc_cls_ingress
      selftests/bpf: get rid of global vars in btf_skc_cls_ingress
      selftests/bpf: add ipv4 and dual ipv4/ipv6 support in btf_skc_cls_ingress
      selftests/bpf: test MSS value returned with bpf_tcp_gen_syncookie
      selftests/bpf: remove test_tcp_check_syncookie

Alistair Francis (2):
      include: mdio: Remove mdio45_ethtool_gset()
      mdio: Remove mdio45_ethtool_gset_npage()

Alper Nebi Yasak (1):
      wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_config_scan()

Amit Cohen (1):
      selftests: mlxsw: rtnetlink: Use devlink_reload() API

Andrej Shadura (1):
      Bluetooth: Fix type of len in rfcomm_sock_getsockopt{,_old}()

Andrew Kreimer (4):
      wifi: wcn36xx: fix a typo in struct wcn36xx_sta documentation
      wifi: ath6kl: fix typos in struct wmi_rssi_threshold_params_cmd and wmi_snr_threshold_params_cmd comments
      fsl/fman: Fix a typo
      mISDN: Fix typos

Andrew Lunn (1):
      dsa: qca8k: Use nested lock to avoid splat

Andy Shevchenko (3):
      net: ks8851: use %*ph to print small buffer
      tg3: Increase buffer size for IRQ label
      Bluetooth: hci_bcm: Use the devm_clk_get_optional() helper

Antoine Tenart (3):
      net: sysctl: remove always-true condition
      net: sysctl: do not reserve an extra char in dump_cpumask temporary buffer
      net: sysctl: allow dump_cpumask to handle higher numbers of CPUs

Antonio Quartulli (1):
      netlink: add NLA_POLICY_MAX_LEN macro

Arnd Bergmann (5):
      wifi: ath12k: fix one more memcpy size error
      eth: fbnic: add CONFIG_PTP_1588_CLOCK_OPTIONAL dependency
      wifi: iwlwifi: work around -Wenum-compare-conditional warning
      wifi: rtw89: fix -Wenum-compare-conditional warnings
      net: sparx5: add missing lan969x Kconfig dependency

Aryan Srivastava (3):
      net: dsa: mv88e6xxx: Add FID map cache
      net: phy: aquantia: poll status register
      net: dsa: mv88e6xxx: Fix uninitialised err value

Asbjørn Sloth Tønnesen (1):
      tools: ynl-gen: use big-endian netlink attribute types

Avraham Stern (1):
      wifi: iwlwifi: mvm: support new initiator and responder command version

Balaji Pothunoori (2):
      wifi: ath11k: enable fw_wmi_diag_event hw param for WCN6750
      wifi: ath11k: Fix CE offset address calculation for WCN6750 in SSR

Baochen Qiang (2):
      wifi: ath10k: fix invalid VHT parameters in supported_vht_mcs_rate_nss1
      wifi: ath10k: fix invalid VHT parameters in supported_vht_mcs_rate_nss2

Bartosz Golaszewski (4):
      dt-bindings: net: ath11k: document the inputs of the ath11k on WCN6855
      net: phy: smsc: use devm_clk_get_optional_enabled_with_rate()
      wifi: brcmfmac: of: use devm_clk_get_optional_enabled_with_rate()
      Bluetooth: hci_qca: use devm_clk_get_optional_enabled_with_rate()

Ben Greear (1):
      mac80211: Remove NOP call to ieee80211_hw_config

Benjamin Berg (2):
      wifi: iwlwifi: mvm: log information about HW restart completion
      wifi: iwlwifi: do not warn about a flush with an empty TX queue

Benjamin Poirier (1):
      net/mlx5: Only create VEPA flow table when in VEPA mode

Bitterblue Smith (25):
      wifi: rtw88: Constify some arrays and structs
      wifi: rtw88: Parse the RX descriptor with a single function
      wifi: rtw88: Report the signal strength only if it's known
      wifi: rtw88: Add some definitions for RTL8821AU/RTL8812AU
      wifi: rtw88: Dump the HW features only for some chips
      wifi: rtw88: Allow different C2H RA report sizes
      wifi: rtw88: Extend the init table parsing for RTL8812AU
      wifi: rtw88: Allow rtw_chip_info.ltecoex_addr to be NULL
      wifi: rtw88: Let each driver control the power on/off process
      wifi: rtw88: Enable data rate fallback for older chips
      wifi: rtw88: Make txagc_remnant_ofdm an array
      wifi: rtw88: Support TX page sizes bigger than 128
      wifi: rtw88: Move pwr_track_tbl to struct rtw_rfe_def
      wifi: rtw88: usb: Set pkt_info.ls for the reserved page
      wifi: rtw88: Detect beacon loss with chips other than 8822c
      wifi: rtw88: coex: Support chips without a scoreboard
      wifi: rtw88: 8821a: Regularly ask for BT info updates
      wifi: rtw88: 8812a: Mitigate beacon loss
      wifi: rtw88: Add rtw8812a_table.{c,h}
      wifi: rtw88: Add rtw8821a_table.{c,h}
      wifi: rtw88: Add rtw88xxa.{c,h}
      wifi: rtw88: Add rtw8821a.{c,h}
      wifi: rtw88: Add rtw8812a.{c,h}
      wifi: rtw88: Add rtw8821au.c and rtw8812au.c
      wifi: rtw88: Enable the new RTL8821AU/RTL8812AU drivers

Breno Leitao (19):
      net: Remove likely from l3mdev_master_ifindex_by_index
      netfilter: Make legacy configs user selectable
      net: netconsole: remove msg_ready variable
      net: netconsole: split send_ext_msg_udp() function
      net: netconsole: separate fragmented message handling in send_ext_msg
      net: netconsole: rename body to msg_body
      net: netconsole: introduce variable to track body length
      net: netconsole: track explicitly if msgbody was written to buffer
      net: netconsole: extract release appending into separate function
      net: netconsole: do not pass userdata up to the tail
      net: netconsole: split send_msg_fragmented
      net: netconsole: selftests: Change the IP subnet
      net: netconsole: selftests: Add userdata validation
      net: netconsole: selftests: Check if netdevsim is available
      net: Implement fault injection forcing skb reallocation
      net: netpoll: Individualize the skb pool
      net: netpoll: flush skb pool during cleanup
      netpoll: Use rcu_access_pointer() in __netpoll_setup
      netpoll: Use rcu_access_pointer() in netpoll_poll_lock

Brett Creeley (1):
      ice: only allow Tx promiscuous for multicast

Caleb Connolly (1):
      wifi: ath11k: allow missing memory-regions

Caleb Sander Mateos (7):
      mlx5: fix typo in "mlx5_cqwq_get_cqe_enahnced_comp"
      mlx5: simplify EQ interrupt polling logic
      dim: make dim_calc_stats() inputs const pointers
      dim: pass dim_sample to net_dim() by reference
      mlx5/core: Schedule EQ comp tasklet only if necessary
      mlx5/core: relax memory barrier in eq_update_ci()
      mlx5/core: deduplicate {mlx5_,}eq_update_ci()

Carolina Jubran (19):
      net/mlx5: Unify QoS element type checks across NIC and E-Switch
      net/mlx5: Add support check for TSAR types in QoS scheduling
      net/mlx5: Refactor QoS group scheduling element creation
      net/mlx5: Introduce node type to rate group structure
      net/mlx5: Add parent group support in rate group structure
      net/mlx5: Restrict domain list insertion to root TSAR ancestors
      net/mlx5: Rename vport QoS group reference to parent
      net/mlx5: Introduce node struct and rename group terminology to node
      net/mlx5: Refactor vport scheduling element creation function
      net/mlx5: Refactor vport QoS to use scheduling node structure
      net/mlx5: Remove vport QoS enabled flag
      net/mlx5: Simplify QoS scheduling element configuration
      net/mlx5: Generalize QoS operations for nodes and vports
      net/mlx5: Simplify QoS normalization by removing error handling
      net/mlx5: Generalize max_rate and min_rate setting for nodes
      net/mlx5: Refactor scheduling element configuration bitmasks
      net/mlx5: Generalize scheduling element operations
      net/mlx5: Integrate esw_qos_vport_enable logic into rate operations
      net/mlx5: Make vport QoS enablement more flexible for future extensions

Chen-Yu Tsai (1):
      Bluetooth: btmtksdio: Lookup device node only as fallback

Chih-Kang Chang (2):
      wifi: rtw89: set pause_data field to avoid transmitting data in scan channels
      wifi: rtw89: 8852b: change RF mode to normal mode when set channel

Chin-Yen Lee (2):
      wifi: rtw89: wow: do not configure CPU IO to receive packets for old firmware
      wifi: rtw89: don't check done-ack for entering PS

Ching-Te Ku (6):
      wifi: rtw89: coex: Update priority setting for Wi-Fi is scanning
      wifi: rtw89: coex: Reorder Bluetooth info related logic
      wifi: rtw89: coex: Solved BT PAN profile idle decrease Wi-Fi throughput
      wifi: rtw89: coex: Add function to reorder Wi-Fi firmware report index
      wifi: rtw89: coex: Set Wi-Fi/Bluetooth priority for Wi-Fi scan case
      wifi: rtw89: coex: set higher priority to BT when WL scan and BT A2DP exist

Chris Lu (5):
      Bluetooth: btusb: mediatek: move Bluetooth power off command position
      Bluetooth: btusb: mediatek: add callback function in btusb_disconnect
      Bluetooth: btusb: mediatek: add intf release flow when usb disconnect
      Bluetooth: btusb: mediatek: change the conditions for ISO interface
      Bluetooth: btmtk: adjust the position to init iso data anchor

Christian Marangi (1):
      net: phy: Validate PHY LED OPs presence before registering

Christophe JAILLET (3):
      mlxsw: spectrum_acl_flex_keys: Constify struct mlxsw_afk_element_inst
      rtnetlink: Fix an error handling path in rtnl_newlink()
      wifi: cfg80211: Fix an error handling path in nl80211_start_ap()

Clark Wang (2):
      net: enetc: extract enetc_int_vector_init/destroy() from enetc_alloc_msix()
      net: enetc: optimize the allocation of tx_bdr

Colin Ian King (8):
      wifi: ath12k: make read-only array svc_id static const
      wifi: rtlwifi: make read-only arrays static const
      cxgb4: clip_tbl: Fix spelling mistake "wont" -> "won't"
      tcp: Fix spelling mistake "emtpy" -> "empty"
      ptp: fc3: remove redundant check on variable ret
      net: enetc: Fix spelling mistake "referencce" -> "reference"
      Bluetooth: btintel_pcie: remove redundant assignment to variable ret
      octeontx2-pf: Fix spelling mistake "reprentator" -> "representor"

Cosmin Ratiu (19):
      net/mlx5: hw counters: Make fc_stats & fc_pool private
      net/mlx5: hw counters: Use kvmalloc for bulk query buffer
      net/mlx5: hw counters: Replace IDR+lists with xarray
      net/mlx5: hw counters: Drop unneeded cacheline alignment
      net/mlx5: hw counters: Don't maintain a counter count
      net/mlx5: hw counters: Remove mlx5_fc_create_ex
      net/mlx5: qos: Flesh out element_attributes in mlx5_ifc.h
      net/mlx5: qos: Rename vport 'tsar' into 'sched_elem'.
      net/mlx5: qos: Consistently name vport vars as 'vport'
      net/mlx5: qos: Refactor and document bw_share calculation
      net/mlx5: qos: Maintain rate group vport members in a list
      net/mlx5: qos: Always create group0
      net/mlx5: qos: Drop 'esw' param from vport qos functions
      net/mlx5: qos: Store the eswitch in a mlx5_esw_rate_group
      net/mlx5: qos: Add an explicit 'dev' to vport trace calls
      net/mlx5: qos: Rename rate group 'list' as 'parent_entry'
      net/mlx5: qos: Store rate groups in a qos domain
      net/mlx5: qos: Refactor locking to a qos domain mutex
      net/mlx5: Rework esw qos domain init and cleanup

Dan Carpenter (3):
      net: ethernet: ti: am65-cpsw: Fix uninitialized variable
      wifi: rtw89: unlock on error path in rtw89_ops_unassign_vif_chanctx()
      net: enetc: clean up before returning in probe()

Daniel Borkmann (6):
      netkit: Add option for scrubbing skb meta data
      netkit: Simplify netkit mode over to use NLA_POLICY_MAX
      netkit: Add add netkit scrub support to rt_link.yaml
      tools: Sync if_link.h uapi tooling header
      selftests/bpf: Extend netkit tests to validate skb meta data
      wireguard: device: support big tcp GSO

Daniel Gabay (2):
      wifi: iwlwifi: mvm: Remove unused last_amsdu from reorder buffer
      wifi: iwlwifi: mvm: Remove redundant rcu_read_lock() in reorder buffer

Daniel Golle (13):
      net: phy: mxl-gpy: add basic LED support
      net: phy: mxl-gpy: add missing support for TRIGGER_NETDEV_LINK_10
      dt-bindings: net: marvell,aquantia: add property to override MDI_CFG
      net: phy: aquantia: allow forcing order of MDI pairs
      net: phylink: allow half-duplex modes with RATE_MATCH_PAUSE
      net: phy: support 'active-high' property for PHY LEDs
      net: phy: aquantia: correctly describe LED polarity override
      net: phy: mxl-gpy: correctly describe LED polarity
      net: phy: intel-xway: add support for PHY LEDs
      net: phy: aquantia: fix return value check in aqr107_config_mdi()
      net: phy: realtek: read duplex and gbit master from PHYSR register
      net: phy: realtek: change order of calls in C22 read_status()
      net: phy: realtek: clear 1000Base-T link partner advertisement

Daniel Machon (36):
      net: sparx5: add support for private match data
      net: sparx5: add indirection layer to register macros
      net: sparx5: modify SPX5_PORTS_ALL macro
      net: sparx5: add *sparx5 argument to a few functions
      net: sparx5: add constants to match data
      net: sparx5: use SPX5_CONST for constants which already have a symbol
      net: sparx5: use SPX5_CONST for constants which do not have a symbol
      net: sparx5: add ops to match data
      net: sparx5: ops out chip port to device index/bit functions
      net: sparx5: ops out functions for getting certain array values
      net: sparx5: ops out function for setting the port mux
      net: sparx5: ops out PTP IRQ handler
      net: sparx5: ops out function for DSM calendar calculation
      net: sparx5: add is_sparx5 macro and use it throughout
      net: sparx5: redefine internal ports and PGID's as offsets
      net: sparx5: add support for lan969x targets and core clock
      net: sparx5: change spx5_wr to spx5_rmw in cal update()
      net: sparx5: change frequency calculation for SDLB's
      net: sparx5: add sparx5 context pointer to a few functions
      net: sparx5: add registers required by lan969x
      net: lan969x: add match data for lan969x
      net: lan969x: add register diffs to match data
      net: lan969x: add constants to match data
      net: lan969x: add lan969x ops to match data
      net: lan969x: add PTP handler function
      net: lan969x: add function for calculating the DSM calendar
      net: sparx5: use is_sparx5() macro throughout
      dt-bindings: net: add compatible strings for lan969x targets
      net: sparx5: add compatible string for lan969x
      net: sparx5: add feature support
      net: sparx5: expose some sparx5 VCAP symbols
      net: sparx5: replace SPX5_PORTS with n_ports
      net: sparx5: add new VCAP constants to match data
      net: sparx5: execute sparx5_vcap_init() on lan969x
      net: lan969x: add autogenerated VCAP information
      net: lan969x: add VCAP configuration data

Daniel Xu (2):
      bnxt_en: ethtool: Remove ip4/ip6 ntuple support for IPPROTO_RAW
      bnxt_en: ethtool: Support unset l4proto on ip4/ip6 ntuple rules

Daniel Yang (1):
      xfrm: replace deprecated strncpy with strscpy_pad

Daniel Zahka (3):
      ethtool: rss: fix rss key initialization warning
      ethtool: rss: prevent rss ctx deletion when in use
      selftests: drv-net: rss_ctx: add rss ctx busy testcase

Danielle Ratson (2):
      net: ethtool: Add new parameters and a function to support EPL
      net: ethtool: Add support for writing firmware blocks using EPL payload

Danil Pylaev (3):
      Bluetooth: Add new quirks for ATS2851
      Bluetooth: Support new quirks for ATS2851
      Bluetooth: Set quirks for ATS2851

Danila Tikhonov (1):
      dt-bindings: nfc: nxp,nci: Document PN553 compatible

David Howells (1):
      rxrpc: Add a tracepoint for aborts being proposed

David S. Miller (13):
      Merge branch 'sfc-per-q-stats'
      Merge branch 'pcs-xpcs-cleanups-batch-2'
      Merge branch 'net-improve-multicast-group-join-performance'
      Merge branch 'vxlan-skb-drop-reasons'
      Merge branch 'ethtool-write-firmware'
      Merge branch 'net-ti-ethernet-warnings'
      Merge branch 'tcp-warn-once'
      Merge branch 'mx95-netc-support'
      Merge branch 'octeontx2-rvu-rep'
      Merge branch 'phy-mediatek-reorg'
      Merge tag 'ipsec-next-2024-11-15' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next
      Merge branch 'udp-4tuple-hash'
      Merge branch 'am65-cpsw-rx-dscp-prio-map'

David Woodhouse (2):
      ptp: Add support for the AMZNC10C 'vmclock' device
      ptp: Remove 'default y' for VMCLOCK PTP device

Davide Caratti (1):
      mptcp: use "middlebox interference" RST when no DSS

Dheeraj Reddy Jonnalagadda (1):
      wireguard: allowedips: remove redundant selftest call

Dinesh Karthikeyan (5):
      wifi: ath12k: Support Self-Generated Transmit stats
      wifi: ath12k: Support Ring and SFM stats
      wifi: ath12k: Support pdev Transmit Multi-user stats
      wifi: ath12k: Support pdev CCA Stats
      wifi: ath12k: Support Pdev OBSS Stats

Diomidis Spinellis (1):
      ixgbe: Break include dependency cycle

Dipendra Khadka (6):
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_common.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_ethtool.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in cn10k.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dmac_flt.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dcbnl.c

Divya Koppera (1):
      net: phy: microchip_t1: Interrupt support for lan887x

Dmitry Antipov (5):
      wifi: mac80211, cfg80211: miscellaneous spelling fixes
      wifi: mwifiex: cleanup struct mwifiex_auto_tdls_peer
      wifi: mwifiex: cleanup struct mwifiex_private
      Bluetooth: fix use-after-free in device_for_each_child()
      rocker: fix link status detection in rocker_carrier_init()

Dmitry Kandybka (2):
      wifi: nl80211: remove redundant null pointer check in coalescing
      mptcp: fix possible integer overflow in mptcp_reset_tout_timer

Dmitry Safonov (2):
      net/tcp: Add missing lockdep annotations for TCP-AO hlist traversals
      net/netlink: Correct the comment on netlink message max cap

Donald Hunter (8):
      doc: net: Fix .rst rendering of net_cachelines pages
      netlink: specs: Add missing bitset attrs to ethtool spec
      tools/net/ynl: improve async notification handling
      netlink: specs: Add a spec for neighbor tables in rtnetlink
      netlink: specs: Add a spec for FIB rule management
      netfilter: nfnetlink: Report extack policy errors for batched ops
      Revert "tools/net/ynl: improve async notification handling"
      tools/net/ynl: add async notification handling

Dr. David Alan Gilbert (24):
      net/rds: remove unused struct 'rds_ib_dereg_odp_mr'
      appletalk: Remove deadcode
      caif: Remove unused cfsrvl_getphyid
      chelsio/chtls: Remove unused chtls_set_tcb_tflag
      net: liquidio: Remove unused cn23xx_dump_pf_initialized_regs
      cxgb4: Remove unused cxgb4_alloc/free_encap_mac_filt
      cxgb4: Remove unused cxgb4_alloc/free_raw_mac_filt
      cxgb4: Remove unused cxgb4_get_srq_entry
      cxgb4: Remove unused cxgb4_scsi_init
      cxgb4: Remove unused cxgb4_l2t_alloc_switching
      cxgb4: Remove unused t4_free_ofld_rxqs
      net: cxgb3: Remove stid deadcode
      wifi: brcmfmac: Remove unused brcmf_cfg80211_get_iftype()
      wifi: brcmsmac: Remove unused brcms_debugfs_get_devdir()
      wifi: cw1200: Remove unused cw1200_queue_requeue_all()
      wifi: brcm80211: Remove unused dma_txflush()
      net: ena: Remove autopolling mode
      net: ena: Remove deadcode
      sfc: Remove falcon deadcode
      sfc: Remove unused efx_mae_mport_vf
      sfc: Remove unused mcdi functions
      sfc: Remove more unused functions
      wifi: rtlwifi: Remove some exhalbtc deadcode
      net/fungible: Remove unused fun_create_queue

Dragos Tatulea (7):
      net/mlx5e: Update features on MTU change
      net/mlx5e: Update features on ring size change
      net/mlx5e: SHAMPO, Simplify UMR allocation for headers
      net/mlx5e: SHAMPO, Fix page_index calculation inconsistency
      net/mlx5e: SHAMPO, Change frag page setup order during allocation
      net/mlx5e: SHAMPO, Drop info array
      net/mlx5e: SHAMPO, Rework header allocation loop

Edward Cree (12):
      sfc: remove obsolete counters from struct efx_channel
      sfc: implement basic per-queue stats
      sfc: add n_rx_overlength to ethtool stats
      sfc: account XDP TXes in netdev base stats
      sfc: implement per-queue rx drop and overrun stats
      sfc: implement per-queue TSO (hw_gso) stats
      sfc: add per-queue RX bytes stats
      net: ethtool: only allow set_rxnfc with rss + ring_cookie if driver opts in
      net: ethtool: account for RSS+RXNFC add semantics when checking channel count
      selftest: include dst-ip in ethtool ntuple rules
      selftest: validate RSS+ntuple filters with nonzero ring_cookie
      selftest: extend test_rss_context_queue_reconfigure for action addition

Elena Salomatkina (1):
      net/sched: cbs: Fix integer overflow in cbs_set_port_rate()

Emmanuel Grumbach (13):
      wifi: mac80211: make bss_param_ch_cnt available for the low level driver
      wifi: mac80211: remove unneeded parameters
      wifi: mac80211: ieee80211_recalc_txpower receives a link
      wifi: mac80211: __ieee80211_recalc_txpower receives a link
      wifi: mac80211: update the right link for tx power
      wifi: iwlwifi: mvm: exit EMLSR earlier if bss_param_ch_cnt is updated
      wifi: iwlwifi: mvm: prepare the tx_power handling to be per-link
      wifi: iwlwifi: mvm: support new versions of the wowlan APIs
      wifi: iwlwifi: mvm: MLO scan upon channel condition degradation
      wifi: iwlwifi: allow fast resume on ax200
      wifi: iwlwifi: mvm: tell iwlmei when we finished suspending
      wifi: iwlwifi: be less noisy if the NIC is dead in S3
      wifi: iwlwifi: mvm: don't call power_update_mac in fast suspend

Eric Dumazet (35):
      tcp: annotate data-races around icsk->icsk_pending
      tcp: add a fast path in tcp_write_timer()
      tcp: add a fast path in tcp_delack_timer()
      net: add IFLA_MAX_PACING_OFFLOAD_HORIZON device attribute
      ipv4: remove fib_devindex_hashfn()
      ipv4: use rcu in ip_fib_check_default()
      ipv4: remove fib_info_lock
      ipv4: remove fib_info_devhash[]
      ipv6: switch inet6_addr_hash() to less predictable hash
      ipv6: switch inet6_acaddr_hash() to less predictable hash
      net_sched: sch_sfq: handle bigger packets
      tcp: move sysctl_tcp_l3mdev_accept to netns_ipv4_read_rx
      fib: rules: use READ_ONCE()/WRITE_ONCE() on ops->fib_rules_seq
      ipv4: use READ_ONCE()/WRITE_ONCE() on net->ipv4.fib_seq
      ipv6: use READ_ONCE()/WRITE_ONCE() on fib6_table->fib_seq
      ipmr: use READ_ONCE() to read net->ipv[46].ipmr_seq
      net: do not acquire rtnl in fib_seq_sum()
      net: add TIME_WAIT logic to sk_to_full_sk()
      net_sched: sch_fq: prepare for TIME_WAIT sockets
      net: add skb_set_owner_edemux() helper
      ipv6: tcp: give socket pointer to control skbs
      ipv4: tcp: give socket pointer to control skbs
      netpoll: remove ndo_netpoll_setup() second argument
      net: netdev_tx_sent_queue() small optimization
      vsock: do not leave dangling sk pointer in vsock_create()
      neighbour: use kvzalloc()/kvfree()
      dql: annotate data-races around dql->last_obj_cnt
      net: skb_reset_mac_len() must check if mac_header was set
      net: add debug check in skb_reset_inner_transport_header()
      net: add debug check in skb_reset_inner_network_header()
      net: add debug check in skb_reset_inner_mac_header()
      net: add debug check in skb_reset_transport_header()
      net: add debug check in skb_reset_network_header()
      net: add debug check in skb_reset_mac_header()
      phonet: do not call synchronize_rcu() from phonet_route_del()

Erick Archer (1):
      batman-adv: Add flex array to struct batadv_tvlv_tt_data

Erik Schumacher (1):
      net: phy: dp83822: Configure RMII mode on DP83825 devices

Erni Sri Satya Vennela (1):
      net: mana: Add get_link and get_link_ksettings in ethtool

Everest K.C (1):
      xfrm: Add error handling when nla_put_u32() returns an error

Everest K.C. (1):
      Bluetooth: btintel_pcie: Remove deadcode

FUJITA Tomonori (1):
      rust: net::phy always define device_table in module_phy_driver macro

Felix Fietkau (11):
      wifi: cfg80211: add option for vif allowed radios
      wifi: mac80211: use vif radio mask to limit ibss scan frequencies
      wifi: mac80211: use vif radio mask to limit creating chanctx
      wifi: cfg80211: report per wiphy radio antenna mask
      wifi: mac80211: remove status->ampdu_delimiter_crc
      wifi: cfg80211: pass net_device to .set_monitor_channel
      wifi: mac80211: add flag to opt out of virtual monitor support
      wifi: cfg80211: add monitor SKIP_TX flag
      wifi: mac80211: add support for the monitor SKIP_TX flag
      wifi: mac80211: refactor ieee80211_rx_monitor
      wifi: mac80211: filter on monitor interfaces based on configured channel

Felix Maurer (1):
      xsk: Free skb when TX metadata options are invalid

Florian Fainelli (2):
      net: systemport: Remove unused txchk accessors
      net: systemport: Move IO macros to header file

Florian Westphal (15):
      netfilter: nf_tables: prefer nft_trans_elem_alloc helper
      netfilter: nf_tables: avoid false-positive lockdep splat on rule deletion
      netfilter: nf_tables: avoid false-positive lockdep splats with sets
      netfilter: nf_tables: avoid false-positive lockdep splats with flowtables
      netfilter: nf_tables: avoid false-positive lockdep splats in set walker
      netfilter: nf_tables: avoid false-positive lockdep splats with basechain hook
      netfilter: nf_tables: must hold rcu read lock while iterating expression type list
      netfilter: nf_tables: must hold rcu read lock while iterating object type list
      selftests: netfilter: run conntrack_dump_flush in netns
      selftests: netfilter: nft_queue.sh: fix warnings with socat 1.8.0.0
      netfilter: nf_tables: add nft_trans_commit_list_add_elem helper
      netfilter: nf_tables: prepare for multiple elements in nft_trans_elem structure
      netfilter: nf_tables: prepare nft audit for set element compaction
      netfilter: nf_tables: switch trans_elem to real flex array
      netfilter: nf_tables: allocate element update information dynamically

Francesco Dolcini (3):
      dt-bindings: net: fec: add pps channel property
      net: fec: refactor PPS channel configuration
      net: fec: make PPS channel configurable

Frederic Weisbecker (1):
      ice: Unbind the workqueue

Furong Xu (8):
      net: stmmac: Introduce separate files for FPE implementation
      net: stmmac: Rework macro definitions for gmac4 and xgmac
      net: stmmac: Introduce stmmac_fpe_supported()
      net: stmmac: Refactor FPE functions to generic version
      net: stmmac: Get the TC number of net_device by netdev_get_num_tc()
      net: stmmac: xgmac: Rename XGMAC_RQ to XGMAC_FPRQ
      net: stmmac: xgmac: Complete FPE support
      net: stmmac: xgmac: Enable FPE for tc-mqprio/tc-taprio

Gang Yan (1):
      mptcp: annotate data-races around subflow->fully_established

Geert Uytterhoeven (1):
      dt-bindings: net: renesas,ether: Add iommus property

Geetha sowjanya (16):
      octeontx2-pf: Define common API for HW resources configuration
      octeontx2-pf: Add new APIs for queue memory alloc/free.
      octeontx2-pf: Reuse PF max mtu value
      octeontx2-pf: Move shared APIs to header file
      octeontx2-pf: RVU representor driver
      octeontx2-pf: Create representor netdev
      octeontx2-pf: Add basic net_device_ops
      octeontx2-af: Add packet path between representor and VF
      octeontx2-pf: Get VF stats via representor
      octeontx2-pf: Add support to sync link state between representor and VFs
      octeontx2-pf: Configure VF mtu via representor
      octeontx2-pf: Add representors for sdp MAC
      octeontx2-pf: Add devlink port support
      octeontx2-pf: Implement offload stats ndo for representors
      octeontx2-pf: Adds TC offload support
      Documentation: octeontx2: Add Documentation for RVU representors

Geliang Tang (5):
      selftests/bpf: Add getsockopt to inspect mptcp subflow
      selftests/bpf: Add mptcp subflow subtest
      mptcp: implement mptcp_pm_connection_closed
      selftests/bpf: Drop netns helpers in mptcp
      mptcp: pm: avoid code duplication to lookup endp

George Guo (1):
      netlabel: document doi_remove field of struct netlbl_calipso_ops

Gerd Bayer (1):
      net/smc: Run patches also by RDMA ML

Gilad Naaman (7):
      sctp: Avoid enqueuing addr events redundantly
      neighbour: Add hlist_node to struct neighbour
      neighbour: Define neigh_for_each_in_bucket
      neighbour: Convert seq_file functions to use hlist
      neighbour: Convert iteration to use hlist+macro
      neighbour: Remove bare neighbour::next pointer
      neighbour: Create netdev->neighbour association

Guilherme G. Piccoli (1):
      wifi: rtlwifi: Drastically reduce the attempts to read efuse in case of failures

Guillaume Nault (31):
      ipv4: Convert icmp_route_lookup() to dscp_t.
      ipv4: Convert ip_route_input() to dscp_t.
      ipv4: Convert ip_route_input_noref() to dscp_t.
      ipv4: Convert ip_route_input_rcu() to dscp_t.
      ipv4: Convert ip_route_input_slow() to dscp_t.
      ipv4: Convert ip_route_use_hint() to dscp_t.
      ipv4: Convert ip_mkroute_input() to dscp_t.
      ipv4: Convert __mkroute_input() to dscp_t.
      ipv4: Convert ip_route_input_mc() to dscp_t.
      ipv4: Convert ip_mc_validate_source() to dscp_t.
      ipv4: Convert fib_validate_source() to dscp_t.
      ipv4: Convert __fib_validate_source() to dscp_t.
      bareudp: Use pcpu stats to update rx_dropped counter.
      ipv4: Prepare fib_compute_spec_dst() to future .flowi4_tos conversion.
      ipv4: Prepare icmp_reply() to future .flowi4_tos conversion.
      ipv4: Prepare ipmr_rt_fib_lookup() to future .flowi4_tos conversion.
      ipv4: Prepare ip_rt_get_source() to future .flowi4_tos conversion.
      ipvlan: Prepare ipvlan_process_v4_outbound() to future .flowi4_tos conversion.
      vrf: Prepare vrf_process_v4_outbound() to future .flowi4_tos conversion.
      xfrm: Convert xfrm_get_tos() to dscp_t.
      xfrm: Convert xfrm_bundle_create() to dscp_t.
      xfrm: Convert xfrm_dst_lookup() to dscp_t.
      xfrm: Convert struct xfrm_dst_lookup_params -> tos to dscp_t.
      ipv4: Prepare ip_route_output() to future .flowi4_tos conversion.
      bpf: ipv4: Prepare __bpf_redirect_neigh_v4() to future .flowi4_tos conversion.
      bpf: lwtunnel: Prepare bpf_lwt_xmit_reroute() to future .flowi4_tos conversion.
      netfilter: ipv4: Convert ip_route_me_harder() to dscp_t.
      netfilter: flow_offload: Convert nft_flow_route() to dscp_t.
      netfilter: rpfilter: Convert rpfilter_mt() to dscp_t.
      netfilter: nft_fib: Convert nft_fib4_eval() to dscp_t.
      netfilter: nf_dup4: Convert nf_dup_ipv4_route() to dscp_t.

Gur Stavi (3):
      af_packet: allow fanout_add when socket is not RUNNING
      selftests: net/psock_fanout: socket joins fanout when link is down
      selftests: net/psock_fanout: unbound socket fanout

Gustavo A. R. Silva (2):
      UAPI: ethtool: Use __struct_group() in struct ethtool_link_settings
      net: ethtool: Avoid thousands of -Wflex-array-member-not-at-end warnings

Hangbin Liu (6):
      netdevsim: print human readable IP address
      netdevsim: copy addresses for both in and out paths
      selftests: rtnetlink: update netdevsim ipsec output format
      bonding: return detailed error when loading native XDP fails
      Documentation: bonding: add XDP support explanation
      wireguard: selftests: load nf_conntrack if not present

Hao Qin (1):
      Bluetooth: btusb: Add new VID/PID 0489/e111 for MT7925

Harshitha Ramamurthy (4):
      gve: move DQO rx buffer management related code to a new file
      gve: adopt page pool for DQ RDA mode
      gve: add support for basic queue stats
      gve: change to use page_pool_put_full_page when recycling pages

Heiner Kallweit (33):
      r8169: add support for the temperature sensor being available from RTL8125B
      r8169: don't apply UDP padding quirk on RTL8126A
      r8169: remove original workaround for RTL8125 broken rx issue
      r8169: enable SG/TSO on selected chip versions per default
      r8169: implement additional ethtool stats ops
      net: phy: realtek: merge the drivers for internal NBase-T PHY's
      r8169: don't take RTNL lock in rtl_task()
      r8169: replace custom flag with disable_work() et al
      r8169: avoid duplicated messages if loading firmware fails and switch to warn level
      r8169: remove rtl_dash_loop_wait_high/low
      net: phy: realtek: add RTL8125D-internal PHY
      r8169: enable EEE at 2.5G per default on RTL8125B
      r8169: add support for RTL8125D
      r8169: fix inconsistent indenting in rtl8169_get_eth_mac_stats
      r8169: align RTL8125 EEE config with vendor driver
      r8169: align RTL8125/RTL8126 PHY config with vendor driver
      r8169: align RTL8126 EEE config with vendor driver
      r8169: improve initialization of RSS registers on RTL8125/RTL8126
      r8169: remove leftover locks after reverted change
      net: phy: respect cached advertising when re-enabling EEE
      net: phy: make genphy_c45_write_eee_adv() static
      net: phy: export genphy_c45_an_config_eee_aneg
      net: phy: broadcom: use genphy_c45_an_config_eee_aneg in bcm_config_lre_aneg
      net: phy: remove genphy_config_eee_advert
      r8169: improve __rtl8169_set_wol
      r8169: improve rtl_set_d3_pll_down
      r8169: align WAKE_PHY handling with r8125/r8126 vendor drivers
      r8169: use helper r8169_mod_reg8_cond to simplify rtl_jumbo_config
      net: simplify eeecfg_mac_can_tx_lpi
      net: phy: c45: don't use temporary linkmode bitmaps in genphy_c45_ethtool_get_eee
      net: phy: convert eee_broken_modes to a linkmode bitmap
      net: phy: add phy_set_eee_broken
      r8169: copy vendor driver 2.5G/5G EEE advertisement constraints

Hilda Wu (2):
      Bluetooth: btusb: Add RTL8852BE device 0489:e123 to device tables
      Bluetooth: btrtl: Decrease HCI_OP_RESET timeout from 10 s to 2 s

Hongbo Li (1):
      ice: Make use of assign_bit() API

Hongguang Gao (3):
      bnxt_en: Refactor bnxt_free_ctx_mem()
      bnxt_en: Add a 'force' parameter to bnxt_free_ctx_mem()
      bnxt_en: Do not free FW log context memory

Hyunwoo Kim (1):
      hv_sock: Initializing vsk->trans to NULL to prevent a dangling pointer

Ido Schimmel (1):
      bridge: Allow deleting FDB entries with non-existent VLAN

Ignat Korchagin (9):
      af_packet: avoid erroring out after sock_init_data() in packet_create()
      Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
      Bluetooth: RFCOMM: avoid leaving dangling sk pointer in rfcomm_sock_alloc()
      net: af_can: do not leave a dangling sk pointer in can_create()
      net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
      net: inet: do not leave a dangling sk pointer in inet_create()
      net: inet6: do not leave a dangling sk pointer in inet6_create()
      net: warn, if pf->create does not clear sock->sk on error
      Revert "net: do not leave a dangling sk pointer, when socket creation fails"

Ilan Peer (2):
      wifi: mac80211: Add support to indicate that a new interface is to be added
      wifi: iwlwifi: mvm: Add support for prep_add_interface() callback

Iulia Tanasescu (6):
      Bluetooth: ISO: Do not emit LE PA Create Sync if previous is pending
      Bluetooth: ISO: Fix matching parent socket for BIS slave
      Bluetooth: ISO: Do not emit LE BIG Create Sync if previous is pending
      Bluetooth: ISO: Update hci_conn_hash_lookup_big for Broadcast slave
      Bluetooth: hci_conn: Remove alloc from critical section
      Bluetooth: ISO: Send BIG Create Sync via hci_sync

Jack Wu (1):
      net: wwan: t7xx: Change PM_AUTOSUSPEND_MS to 5000

Jacky Chou (2):
      net: ftgmac100: correct the phy interface of NC-SI mode
      net: ftgmac100: refactor getting phy device handle

Jacob Keller (7):
      lib: packing: add KUnit tests adapted from selftests
      lib: packing: add additional KUnit tests
      lib: packing: fix QUIRK_MSB_ON_THE_RIGHT behavior
      ice: consistently use q_idx in ice_vc_cfg_qs_msg()
      ice: store max_frame and rx_buf_len only in ice_rx_ring
      ice: initialize pf->supported_rxdids immediately after loading DDP
      ice: use stack variable for virtchnl_supported_rxdids

Jacobe Zang (4):
      dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
      dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
      wifi: brcmfmac: Add optional lpo clock enable support
      wifi: brcmfmac: add flag for random seed during firmware download

Jakub Kicinski (138):
      Merge branch 'net-pcs-xpcs-cleanups-batch-1'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'packing-various-improvements-and-kunit-tests'
      Merge branch 'ena-link-irqs-queues-and-napi-instances'
      Merge branch 'ipv4-convert-ip_route_input_slow-and-its-callers-to-dscp_t'
      Merge branch 'gve-link-irqs-queues-and-napi-instances'
      Merge branch 'net-ag71xx-small-cleanups'
      Merge branch 'net-mv643xx-devm-fixes'
      Merge branch 'qed-ethtool-d-faster-less-latency'
      Merge branch 'net-switch-to-scoped-device_for_each_child_node'
      Merge branch 'net-airoha-fix-pse-memory-configuration'
      Merge branch 'net-mlx5-hw-counters-refactor'
      Merge branch 'add-option-to-provide-opt_id-value-via-cmsg'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'selftests-net-ioam-add-tunsrc-support'
      Merge branch 'tcp-add-fast-path-in-timer-handlers'
      Merge branch 'net-prepare-pacing-offload-support'
      Merge branch 'net-switch-back-to-struct-platform_driver-remove'
      Merge branch 'ipv4-preliminary-work-for-per-netns-rtnl'
      tools: ynl-gen: refactor check validation for TypeBinary
      Merge branch 'selftests-mlxsw-stabilize-red-tests'
      Merge branch 'net-phy-marvell-88q2xxx-enable-auto-negotiation-for-mv88q2110'
      Merge branch 'ipv4-convert-__fib_validate_source-and-its-callers-to-dscp_t'
      Merge branch 'qca_spi-improvements-to-qca7000-sync'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'ipv4-namespacify-ipv4-address-hash-table'
      Merge branch 'net-introduce-tx-h-w-shaping-api'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'tg3-link-irqs-napis-and-queues'
      eth: remove the DLink/Sundance (ST201) driver
      Merge branch 'net-remove-rtnl-from-fib_seq_sum'
      Merge branch 'net-xilinx-emaclite-adopt-clock-support'
      Merge branch 'netdevsim-better-ipsec-output-format'
      selftests: drv-net: add missing trailing backslash
      Merge branch 'microchip_t1s-update-on-microchip-10base-t1s-phy-driver'
      Merge branch 'tcp-add-skb-sk-to-more-control-packets'
      Merge branch 'add-support-for-per-napi-config-via-netlink'
      selftests: net: rebuild YNL if dependencies changed
      selftests: net: move EXTRA_CLEAN of libynl.a into ynl.mk
      tools: ynl-gen: use names of constants in generated limits
      Merge branch 'net-af_packet-allow-joining-a-fanout-when-link-is-down'
      Merge branch 'replace-call_rcu-by-kfree_rcu-for-simple-kmem_cache_free-callback'
      Merge branch 'net-string-format-safety-updates'
      Merge branch 'net-ethernet-freescale-use-pa-to-format-resource_size_t'
      Merge branch 'cxgb4-deadcode-removal'
      Merge branch 'do-not-leave-dangling-sk-pointers-in-pf-create-functions'
      Merge branch 'gve-adopt-page-pool'
      Merge branch 'rtnetlink-use-rtnl_register_many'
      configs/debug: make sure PROVE_RCU_LIST=y takes effect
      Merge branch 'net-systemport-minor-io-macros-changes'
      Merge branch 'mptcp-various-small-improvements'
      Merge branch 'bonding-returns-detailed-error-about-xdp-failures'
      Merge branch 'ipv4-prepare-core-ipv4-files-to-future-flowi4_tos-conversion'
      Merge branch 'mlx5e-update-features-on-config-changes'
      Merge branch 'net-phylink-simplify-sfp-phy-attachment'
      Merge branch 'devlink-minor-cleanup'
      Merge tag 'wireless-next-2024-10-25' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'ptp-driver-for-s390-clocks'
      Merge branch 'mirroring-to-dsa-cpu-port'
      Merge branch 'refactoring-rvu-nic-driver'
      Merge branch 'net-sparx5-add-support-for-lan969x-switch-device'
      Merge branch 'bna-remove-error-checking-for-debugfs-create-apis'
      Merge branch 'add-ethernet-dts-schema-for-qcs615-qcs8300'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      selftests: netdevsim: add fib_notifications to Makefile
      Merge branch 'dpll-expose-clock-quality-level'
      Merge branch 'add-noinline_for_tracing-and-apply-it-to-tcp_drop_reason'
      Merge branch 'uapi-net-ethtool-avoid-thousands-of-wflex-array-member-not-at-end-warnings'
      Merge branch 'simplify-tx-napi-logic-in-airoha_eth-driver'
      Merge branch 'selftest-netconsole-enhance-selftest-to-validate-userdata-transmission'
      Merge branch 'ibm-emac-cleanup-modules-to-use-devm'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'r8169-align-rtl8125-rtl8126-phy-config-with-vendor-driver'
      Merge branch 'net-stmmac-refactor-fpe-as-a-separate-module'
      Merge branch 'mlx5-misc-patches-2024-10-31'
      tools: ynl-gen: de-kdocify enums with no doc for entries
      Merge branch 'fix-sparse-warnings-in-dpaa_eth-driver'
      Merge branch 'a-pile-of-sfc-deadcode'
      Merge branch 'add-support-for-synopsis-designware-version-3-72a'
      Merge branch 'add-the-dwmac-driver-support-for-t-head-th1520-soc'
      Merge branch 'ipv6-fix-hangup-on-device-removal'
      Merge branch 'net-add-debug-checks-to-skb_reset_xxx_header'
      Merge branch 'bnxt_en-ethtool-improve-wildcard-l4proto-on-ip4-ip6-ntuple-rules'
      Merge branch 'net-ucc_geth-devm-cleanups'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-phy-remove-genphy_config_eee_advert'
      Merge branch 'netlink-specs-add-neigh-and-rule-ynl-specs'
      Merge branch 'r8169-improve-wol-suspend-related-code'
      Merge branch 'improve-neigh_flush_dev-performance'
      Merge branch 'replace-page_frag-with-page_frag_cache-part-1'
      Merge branch 'macsec-inherit-lower-device-s-features-and-tso-limits-when-offloading'
      Merge branch 'knobs-for-npc-default-rule-counters'
      Merge branch 'side-mdio-support-for-lan937x-switches'
      Merge branch 'introduce-vlan-support-in-hsr'
      Merge branch 'net-stmmac-dwmac4-fixes-issues-in-dwmac4'
      Merge branch 'selftests-ncdevmem-add-ncdevmem-to-ksft'
      Merge branch 'rtnetlink-convert-rtnl_newlink-to-per-netns-rtnl'
      Merge branch 'suspend-irqs-during-application-busy-periods'
      Merge branch 'net-phylink-phylink_resolve-cleanups'
      Merge branch 'mlx5-esw-qos-refactor-and-shampo-cleanup'
      net: sched: cls_api: improve the error message for ID allocation failure
      eth: bnxt: use page pool for head frags
      net: page_pool: do not count normal frag allocation in stats
      Merge tag 'wireless-next-2024-11-13' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'tools-ynl-two-patches-to-ease-building-with-rpmbuild'
      Merge branch 'support-external-snapshots-on-dwmac1000'
      Merge branch 'net-dsa-microchip-add-lan9646-switch-support'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-phy-switch-eee_broken_modes-to-linkmode-bitmap-and-add-accessor'
      Merge branch 'tools-net-ynl-rework-async-notification-handling'
      Merge branch 'ipv4-prepare-bpf-helpers-to-flowi4_tos-conversion'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'net-make-rss-rxnfc-semantics-more-explicit'
      Merge tag 'nf-next-24-11-15' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge tag 'for-net-next-2024-11-14' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Merge tag 'nf-24-11-14' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'enic-use-all-the-resources-configured-on-vic'
      Merge branch 'net-netpoll-improve-skb-pool-management'
      Merge branch 'modifying-format-and-renaming-goto-labels'
      Merge branch 'net-ndo_fdb_add-del-have-drivers-report-whether-they-notified'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'virtio-net-support-af_xdp-zero-copy-tx'
      tools: ynl-gen: allow uapi headers in sub-dirs
      net/neighbor: clear error in case strict check is not set
      selftests: net: netlink-dumps: validation checks
      eth: fbnic: don't disable the PCI device twice
      eth: fbnic: add missing SPDX headers
      eth: fbnic: add missing header guards
      eth: fbnic: add basic debugfs structure
      Merge branch 'eth-fbnic-cleanup-and-add-a-few-stats'
      Merge branch 'mptcp-pm-lockless-list-traversal-and-cleanup'
      MAINTAINERS: exclude can core, drivers and DT bindings from netdev ML
      selftests: net: add more info to error in bpf_offload
      Merge branch 'uapi-ethtool-avoid-flex-array-in-struct-ethtool_link_settings'
      Merge branch 'netpoll-use-rcu-primitives-for-npinfo-pointer-access'
      Merge branch 'wireguard-updates-and-fixes-for-6-13'
      Merge branch 'bpf-fix-recursive-lock-and-add-test'
      Merge branch 'bnxt_en-add-context-memory-dump-to-coredump'

Jan Stancek (2):
      tools: ynl: add script dir to sys.path
      tools: ynl: extend CFLAGS to keep options from environment

Jason Xing (3):
      net-timestamp: namespacify the sysctl_tstamp_allow_data
      tcp: add a common helper to debug the underlying issue
      tcp: add more warn of socket in tcp_send_loss_probe()

Javier Carrasco (5):
      net: mdio: thunder: switch to scoped device_for_each_child_node()
      net: hns: hisilicon: hns_dsaf_mac: switch to scoped device_for_each_child_node()
      net: dsa: mv88e6xxx: fix unreleased fwnode_handle in setup_port()
      wifi: brcmfmac: release 'root' node in all execution paths
      Bluetooth: btbcm: fix missing of_node_put() in btbcm_get_board_name()

Jeff Johnson (1):
      wifi: mac80211: constify ieee80211_ie_build_{he,eht}_oper() chandef

Jeffrey Ji (1):
      net_sched: sch_fq: add the ability to offload pacing

Jeongjun Park (2):
      wifi: ath9k: add range check for conn_rsp_epid in htc_connect_service()
      netfilter: ipset: add missing range check in bitmap_ip_uadt

Jeremy Sowden (2):
      netfilter: bitwise: rename some boolean operation functions
      netfilter: bitwise: add support for doing AND, OR and XOR directly

Jianbo Liu (1):
      bonding: add ESP offload features when slaves support

Jiande Lu (2):
      Bluetooth: btusb: Add USB HW IDs for MT7920/MT7925
      Bluetooth: btusb: Add 3 HWIDs for MT7925

Jiapeng Chong (1):
      wifi: ipw2x00: libipw_rx_any(): fix bad alignment

Jiawen Wu (2):
      net: txgbe: remove GPIO interrupt controller
      net: txgbe: fix null pointer to pcs

Jiayuan Chen (2):
      bpf: fix recursive lock when verdict program return SK_PASS
      selftests/bpf: Add some tests with sockmap SK_PASS

Jijie Shao (10):
      net: hibmcge: Add pci table supported in this module
      net: hibmcge: Add read/write registers supported through the bar space
      net: hibmcge: Add mdio and hardware configuration supported in this module
      net: hibmcge: Add interrupt supported in this module
      net: hibmcge: Implement some .ndo functions
      net: hibmcge: Implement .ndo_start_xmit function
      net: hibmcge: Implement rx_poll function to receive packets
      net: hibmcge: Implement some ethtool_ops functions
      net: hibmcge: Add a Makefile and update Kconfig for hibmcge
      net: hibmcge: Add maintainer for hibmcge

Jinjian Song (3):
      wwan: core: Add WWAN ADB and MIPC port type
      net: wwan: t7xx: Add debug ports
      net: wwan: t7xx: Unify documentation column width

Jinjie Ruan (4):
      wifi: p54: Use IRQF_NO_AUTOEN flag in request_irq()
      wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()
      wifi: wl1251: Use IRQF_NO_AUTOEN flag in request_irq()
      netlink: Remove the dead code in netlink_proto_init()

Jiri Pirko (2):
      dpll: add clock quality level attribute and op
      net/mlx5: DPLL, Add clock quality level op implementation

Jisheng Zhang (2):
      dt-bindings: net: Add T-HEAD dwmac support
      net: stmmac: Add glue layer for T-HEAD TH1520 SoC

Joe Damato (25):
      ena: Link IRQs to NAPI instances
      ena: Link queues to NAPIs
      gve: Map IRQs to NAPI instances
      gve: Map NAPI instances to queues
      hv_netvsc: Link queues to NAPIs
      idpf: Don't hard code napi_struct size
      e1000e: Link NAPI instances to queues and IRQs
      e1000: Link NAPI instances to queues and IRQs
      tg3: Link IRQs to NAPI instances
      tg3: Link queues to NAPIs
      net: napi: Make napi_defer_hard_irqs per-NAPI
      netdev-genl: Dump napi_defer_hard_irqs
      net: napi: Make gro_flush_timeout per-NAPI
      netdev-genl: Dump gro_flush_timeout
      net: napi: Add napi_config
      netdev-genl: Support setting per-NAPI config values
      bnxt: Add support for persistent NAPI config
      mlx5: Add support for persistent NAPI config
      mlx4: Add support for persistent NAPI config to RX CQs
      selftests: net: Add busy_poll_test
      docs: networking: Describe irq suspension
      ice: Add support for persistent NAPI config
      e1000: Hold RTNL when e1000_down can be called
      netdev-genl: Hold rcu_read_lock in napi_get
      netdev-genl: Hold rcu_read_lock in napi_set

Johannes Berg (33):
      wifi: qtnfmac: don't include lib80211.h
      wifi: mwifiex: don't include lib80211.h
      wifi: libertas: don't select/include lib80211
      staging: rtl8192e: delete the driver
      wifi: ipw2x00/lib80211: move remaining lib80211 into libipw
      staging: don't recommend using lib80211
      wifi: wext/libipw: move spy implementation to libipw
      wifi: cfg80211: stop exporting wext symbols
      wifi: remove iw_public_data from struct net_device
      wifi: cfg80211: unexport wireless_nlevent_flush()
      wifi: wext: merge adjacent CONFIG_COMPAT ifdef blocks
      wireless: wext: shorten struct iw_ioctl_description
      Revert "wifi: cfg80211: unexport wireless_nlevent_flush()"
      Merge net-next/main to resolve conflicts
      wifi: ipw: select CRYPTO_LIB_ARC4
      wifi: cfg80211: disallow SMPS in AP mode
      wifi: mac80211: allow rate_control_rate_init() for links
      wifi: mac80211: call rate_control_rate_update() for link STA
      wifi: mac80211: chan: calculate min_def also for client mode
      wifi: mac80211: expose ieee80211_chan_width_to_rx_bw() to drivers
      wifi: iwlwifi: fw: api: update link context API version
      wifi: iwlwifi: allow IWL_FW_CHECK() with just a string
      wifi: mac80211_hwsim: use hrtimer_active()
      wifi: mac80211: remove misleading j_0 construction parts
      debugfs: add small file operations for most files
      wifi: mac80211: convert debugfs files to short fops
      wifi: iwlwifi: mvm: clarify fw_id_to_link_sta protection
      wifi: iwlwifi: mvm: unify link info initialization
      wifi: iwlwifi: mvm: allow always calling iwl_mvm_get_bss_vif()
      wifi: iwlwifi: mvm: use wiphy locked debugfs for low-latency
      net: netlink: add nla_get_*_default() accessors
      net: convert to nla_get_*_default()
      wifi: mac80211: pass MBSSID config by reference

Johnny Park (1):
      igb: Fix 2 typos in comments in igb_main.c

Jonas Rebmann (2):
      net: ipv4: igmp: optimize ____ip_mc_inc_group() using mc_hash
      net: dpaa: use __dev_mc_sync in dpaa_set_rx_mode()

Jonathan McCrohan (1):
      Bluetooth: btusb: Add new VID/PID 0489/e124 for MT7925

Jose Ignacio Tornos Martinez (2):
      wifi: ath12k: fix crash when unbinding
      wifi: ath12k: fix warning when unbinding

Julia Lawall (7):
      mac80211: Reorganize kerneldoc parameter names
      batman-adv: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
      ipv4: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
      inetpeer: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
      ipv6: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
      net: bridge: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
      kcm: replace call_rcu by kfree_rcu for simple kmem_cache_free callback

Juraj Šarinay (1):
      net: nfc: Propagate ISO14443 type A target ATS to userspace via netlink

Justin Chen (2):
      net: broadcom: remove select MII from brcmstb Ethernet drivers
      net: bcmasp: enable SW timestamping

Justin Iurman (2):
      selftests: net: remove ioam tests
      selftests: net: add new ioam tests

Justin Lai (2):
      rtase: Modify the name of the goto label
      rtase: Modify the content format of the enum rtase_registers

Justin Stitt (1):
      netfilter: nf_tables: replace deprecated strncpy with strscpy_pad

Kalle Valo (11):
      wifi: ath12k: fix atomic calls in ath12k_mac_op_set_bitrate_mask()
      wifi: ath12k: convert struct ath12k_sta::update_wk to use struct wiphy_work
      wifi: ath12k: switch to using wiphy_lock() and remove ar->conf_mutex
      wifi: ath12k: cleanup unneeded labels
      wifi: ath12k: ath12k_mac_set_key(): remove exit label
      wifi: ath12k: ath12k_mac_op_sta_state(): clean up update_wk cancellation
      wifi: ath12k: add missing lockdep_assert_wiphy() for ath12k_mac_op_ functions
      Merge tag 'rtw-next-2024-10-10' of https://github.com/pkshih/rtw
      Merge tag 'ath-next-20241030' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'rtw-next-2024-11-06' of https://github.com/pkshih/rtw
      Revert "wifi: iwlegacy: do not skip frames with bad FCS"

Kang Yang (9):
      wifi: ath10k: avoid NULL pointer error during sdio remove
      wifi: ath12k: remove unused variable monitor_present
      wifi: ath12k: fix struct hal_rx_ppdu_end_user_stats
      wifi: ath12k: fix struct hal_rx_ppdu_start
      wifi: ath12k: fix struct hal_rx_phyrx_rssi_legacy_info
      wifi: ath12k: fix struct hal_rx_mpdu_start
      wifi: ath12k: delete NSS and TX power setting for monitor vdev
      wifi: ath12k: use tail MSDU to get MSDU information
      wifi: ath12k: fix A-MSDU indication in monitor mode

Karan Sanghavi (1):
      selftests: tc-testing: Fix typo error

Karol Kolacinski (5):
      ice: Implement ice_ptp_pin_desc
      ice: Add SDPs support for E825C
      ice: Align E810T GPIO to other products
      ice: Cache perout/extts requests and check flags
      ice: Disable shared pin on E810 on setfunc

Karthikeyan Periyasamy (1):
      wifi: cfg80211: check radio iface combination for multi radio per wiphy

Kees Cook (3):
      Revert "net: ethtool: Avoid thousands of -Wflex-array-member-not-at-end warnings"
      Revert "UAPI: ethtool: Use __struct_group() in struct ethtool_link_settings"
      UAPI: ethtool: Avoid flex-array in struct ethtool_link_settings

Khang Nguyen (1):
      net: mctp: Expose transport binding identifier via IFLA attribute

Kiran K (5):
      Bluetooth: btintel_pcie: Add handshake between driver and firmware
      Bluetooth: btintel_pcie: Add recovery mechanism
      Bluetooth: btintel: Add DSBR support for BlazarIW, BlazarU and GaP
      Bluetooth: btintel: Do no pass vendor events to stack
      Bluetooth: btintel: Direct exception event to bluetooth stack

Kory Maincent (2):
      netlink: specs: Add missing phy-ntf command to ethtool spec
      Documentation: networking: Add missing PHY_GET command in the message list

Kuan-Chung Chen (1):
      wifi: rtw89: 8922a: fill the missing OP1dB configuration

Kuniyuki Iwashima (70):
      Revert "rtnetlink: add guard for RTNL"
      rtnetlink: Add per-netns RTNL.
      rtnetlink: Add assertion helpers for per-netns RTNL.
      rtnetlink: Add ASSERT_RTNL_NET() placeholder for netdev notifier.
      ipv4: Link IPv4 address to per-netns hash table.
      ipv4: Use per-netns hash table in inet_lookup_ifaddr_rcu().
      ipv4: Namespacify IPv4 address GC.
      ipv4: Retire global IPv4 hash table inet_addr_lst.
      rtnl_net_debug: Remove rtnl_net_debug_exit().
      neighbour: Remove NEIGH_DN_TABLE.
      rtnetlink: Panic when __rtnl_register_many() fails for builtin callers.
      rtnetlink: Use rtnl_register_many().
      neighbour: Use rtnl_register_many().
      net: sched: Use rtnl_register_many().
      net: Use rtnl_register_many().
      ipv4: Use rtnl_register_many().
      ipv6: Use rtnl_register_many().
      ipmr: Use rtnl_register_many().
      dcb: Use rtnl_register_many().
      can: gw: Use rtnl_register_many().
      rtnetlink: Remove rtnl_register() and rtnl_register_module().
      rtnetlink: Allocate linkinfo[] as struct rtnl_newlink_tbs.
      rtnetlink: Call validate_linkmsg() in do_setlink().
      rtnetlink: Factorise do_setlink() path from __rtnl_newlink().
      rtnetlink: Move simple validation from __rtnl_newlink() to rtnl_newlink().
      rtnetlink: Move rtnl_link_ops_get() and retry to rtnl_newlink().
      rtnetlink: Move ops->validate to rtnl_newlink().
      rtnetlink: Protect struct rtnl_link_ops with SRCU.
      rtnetlink: Call rtnl_link_get_net_capable() in rtnl_newlink().
      rtnetlink: Fetch IFLA_LINK_NETNSID in rtnl_newlink().
      rtnetlink: Clean up rtnl_dellink().
      rtnetlink: Clean up rtnl_setlink().
      rtnetlink: Call rtnl_link_get_net_capable() in do_setlink().
      rtnetlink: Return int from rtnl_af_register().
      rtnetlink: Protect struct rtnl_af_ops with SRCU.
      ip6mr: Add __init to ip6_mr_cleanup().
      ipv4: Switch inet_addr_hash() to less predictable hash.
      phonet: Pass ifindex to fill_addr().
      phonet: Pass net and ifindex to phonet_address_notify().
      phonet: Convert phonet_device_list.lock to spinlock_t.
      phonet: Don't hold RTNL for addr_doit().
      phonet: Don't hold RTNL for getaddr_dumpit().
      phonet: Pass ifindex to fill_route().
      phonet: Pass net and ifindex to rtm_phonet_notify().
      phonet: Convert phonet_routes.lock to spinlock_t.
      phonet: Don't hold RTNL for route_doit().
      rtnetlink: Make per-netns RTNL dereference helpers to macro.
      rtnetlink: Define RTNL_FLAG_DOIT_PERNET for per-netns RTNL doit().
      ipv4: Factorise RTM_NEWADDR validation to inet_validate_rtm().
      ipv4: Don't allocate ifa for 0.0.0.0 in inet_rtm_newaddr().
      ipv4: Convert RTM_NEWADDR to per-netns RTNL.
      ipv4: Use per-netns RTNL helpers in inet_rtm_newaddr().
      ipv4: Convert RTM_DELADDR to per-netns RTNL.
      ipv4: Convert check_lifetime() to per-netns RTNL.
      rtnetlink: Define rtnl_net_trylock().
      ipv4: Convert devinet_sysctl_forward() to per-netns RTNL.
      ipv4: Convert devinet_ioctl() to per-netns RTNL except for SIOCSIFFLAGS.
      ipv4: Convert devinet_ioctl to per-netns RTNL.
      rtnetlink: Fix kdoc of rtnl_af_register().
      socket: Print pf->create() when it does not clear sock->sk on failure.
      rtnetlink: Remove __rtnl_link_unregister().
      rtnetlink: Protect link_ops by mutex.
      rtnetlink: Remove __rtnl_link_register()
      rtnetlink: Introduce struct rtnl_nets and helpers.
      rtnetlink: Add peer_type in struct rtnl_link_ops.
      veth: Set VETH_INFO_PEER to veth_link_ops.peer_type.
      vxcan: Set VXCAN_INFO_PEER to vxcan_link_ops.peer_type.
      netkit: Set IFLA_NETKIT_PEER_INFO to netkit_link_ops.peer_type.
      rtnetlink: Convert RTM_NEWLINK to per-netns RTNL.
      rtnetlink: Register rtnl_dellink() and rtnl_setlink() with RTNL_FLAG_DOIT_PERNET_WIP.

Leo Stone (1):
      selftest/tcp-ao: Add filter tests

Ley Foon Tan (3):
      net: stmmac: dwmac4: Fix MTL_OP_MODE_RTC mask and shift macros
      net: stmmac: dwmac4: Fix the MTL_OP_MODE_*_MASK operation
      net: stmmac: dwmac4: Receive Watchdog Timeout is not in abnormal interrupt summary

Li Zetao (1):
      wifi: ath9k: use clamp() in ar9003_aic_cal_post_process()

Li Zhijian (2):
      selftests/net: Fix ./ns-XXXXXX not cleanup
      selftests: netfilter: Add missing gitignore file

Lingbo Kong (2):
      wifi: ath12k: remove msdu_end structure for WCN7850
      wifi: cfg80211: Remove the Medium Synchronization Delay validity check

Linu Cherian (3):
      octeontx2-af: Refactor few NPC mcam APIs
      octeontx2-af: Knobs for NPC default rule counters
      devlink: Add documentation for OcteonTx2 AF

Linus Walleij (3):
      net: dsa: mv88e6xxx: Support LED control
      dt-bindings: net: realtek: Use proper node names
      wifi: cw1200: Fix potential NULL dereference

Lorenz Brun (1):
      net: atlantic: support reading SFP module info

Lorenzo Bianconi (9):
      net: airoha: read default PSE reserved pages value before updating
      net: airoha: fix PSE memory configuration in airoha_fe_pse_ports_init()
      net: airoha: Fix EGRESS_RATE_METER_EN_MASK definition
      net: airoha: Implement BQL support
      net: airoha: Fix typo in REG_CDM2_FWD_CFG configuration
      net: airoha: Reset BQL stopping the netdevice
      net: airoha: Read completion queue data in airoha_qdma_tx_napi_poll()
      net: airoha: Simplify Tx napi logic
      net: dsa: mt7530: Add TBF qdisc offload support

Lothar Rubusch (2):
      net: stmmac: add support for dwmac 3.72a
      dt-bindings: net: snps,dwmac: add support for Arria10

Luiz Augusto von Dentz (8):
      Bluetooth: hci_conn: Use disable_delayed_work_sync
      Bluetooth: hci_core: Fix not checking skb length on hci_acldata_packet
      Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
      Bluetooth: HCI: Add IPC(11) bus type
      Bluetooth: SCO: Use kref to track lifetime of sco_conn
      Bluetooth: ISO: Use kref to track lifetime of iso_conn
      Bluetooth: hci_core: Fix calling mgmt_device_connected
      Bluetooth: MGMT: Add initial implementation of MGMT_OP_HCI_CMD_SYNC

Luo Yifan (1):
      ynl: samples: Fix the wrong format specifier

MD Danish Anwar (1):
      selftests: hsr: Add test for VLAN

Maciej Fijalkowski (7):
      bpf: Remove unused macro
      xsk: Get rid of xdp_buff_xsk::xskb_list_node
      xsk: s/free_list_node/list_node/
      xsk: Get rid of xdp_buff_xsk::orig_addr
      xsk: Carry a copy of xdp_zc_max_segs within xsk_buff_pool
      xsk: Wrap duplicated code to function
      xsk: Use xsk_buff_pool directly for cq functions

Mahe Tardy (2):
      bpf: add get_netns_cookie helper to tc programs
      selftests/bpf: add tcx netns cookie tests

Mahesh Bandewar (1):
      selftest/ptp: update ptp selftest to exercise the gettimex options

Manikanta Pubbisetty (1):
      wifi: ath11k: Fix double free issue during SRNG deinit

Marek Vasut (8):
      wifi: wilc1000: Keep slot powered on during suspend/resume
      dt-bindings: wireless: wilc1000: Document WILC3000 compatible string
      wifi: wilc1000: Clean up usage of wilc_get_chipid()
      wifi: wilc1000: Fold chip_allow_sleep()/chip_wakeup() into wlan.c
      wifi: wilc1000: Fill in missing error handling
      wifi: wilc1000: Fold wilc_create_wiphy() into cfg80211.c
      wifi: wilc1000: Register wiphy after reading out chipid
      wifi: wilc1000: Set MAC after operation mode

Markus Elfring (2):
      ice: Use common error handling code in two functions
      Bluetooth: hci_conn: Reduce hci_conn_drop() calls in two functions

Martin KaFai Lau (6):
      Merge branch 'selftests/bpf: new MPTCP subflow subtest'
      Merge branch 'netkit: Add option for scrubbing skb meta data'
      Merge branch 'selftests/bpf: add coverage for xdp_features in test_progs'
      Merge branch 'Two fixes for test_sockmap'
      Merge branch 'selftests/bpf: integrate test_tcp_check_syncookie.sh into test_progs'
      Merge branch 'Fixes to bpf_msg_push/pop_data and test_sockmap'

Martin Kaistra (1):
      wifi: rtl8xxxu: Perform update_beacon_work when beaconing is enabled

Martin Karsten (4):
      net: Add napi_struct parameter irq_suspend_timeout
      net: Add control functions for irq suspension
      eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
      eventpoll: Control irq suspension for prefer_busy_poll

Mateusz Polchlopek (2):
      ice: rework of dump serdes equalizer values feature
      ice: extend dump serdes equalizer values feature

Matthieu Baerts (NGI0) (4):
      mptcp: pm: send ACK on non-stale subflows
      selftests: net: include lib/sh/*.sh with lib.sh
      mptcp: remove unneeded lock when listing scheds
      mptcp: pm: lockless list traversal to dump endp

Maurice Lambert (1):
      netlink: typographical error in nlmsg_type constants definition

Maxime Chevallier (9):
      net: stmmac: Don't modify the global ptp ops directly
      net: stmmac: Use per-hw ptp clock ops
      net: stmmac: Only update the auto-discovered PTP clock features
      net: stmmac: Introduce dwmac1000 ptp_clock_info and operations
      net: stmmac: Introduce dwmac1000 timestamping operations
      net: stmmac: Enable timestamping interrupt on dwmac1000
      net: stmmac: Don't include dwmac4 definitions in stmmac_ptp
      net: stmmac: Configure only the relevant bits for timestamping setup
      net: stmmac: dwmac_socfpga: This platform has GMAC

MeiChia Chiu (1):
      wifi: mac80211: Support EHT 1024 aggregation size in TX

Menglong Dong (26):
      net: tcp: refresh tcp_mstamp for compressed ack in timer
      net: skb: add pskb_network_may_pull_reason() helper
      net: tunnel: add pskb_inet_may_pull_reason() helper
      net: tunnel: make skb_vlan_inet_prepare() return drop reasons
      net: vxlan: add skb drop reasons to vxlan_rcv()
      net: vxlan: make vxlan_remcsum() return drop reasons
      net: vxlan: make vxlan_snoop() return drop reasons
      net: vxlan: make vxlan_set_mac() return drop reasons
      net: vxlan: use kfree_skb_reason() in vxlan_xmit()
      net: vxlan: add drop reasons support to vxlan_xmit_one()
      net: vxlan: use kfree_skb_reason() in vxlan_mdb_xmit()
      net: vxlan: use kfree_skb_reason() in vxlan_encap_bypass()
      net: vxlan: use kfree_skb_reason() in encap_bypass_if_local()
      net: vxlan: replace VXLAN_INVALID_HDR with VNI_NOT_FOUND
      net: vxlan: update the document for vxlan_snoop()
      net: tcp: replace the document for "lsndtime" in tcp_sock
      net: ip: make fib_validate_source() support drop reasons
      net: ip: make ip_route_input_mc() return drop reason
      net: ip: make ip_mc_validate_source() return drop reason
      net: ip: make ip_route_input_slow() return drop reasons
      net: ip: make ip_route_input_rcu() return drop reasons
      net: ip: make ip_route_input_noref() return drop reasons
      net: ip: make ip_route_input() return drop reasons
      net: ip: make ip_mkroute_input/__mkroute_input return drop reasons
      net: ip: make ip_route_use_hint() return drop reasons
      net: ip: fix unexpected return in fib_validate_source()

Miaoqing Pan (3):
      wifi: ath10k: fix the stack frame size warning in ath10k_remain_on_channel
      wifi: ath10k: fix the stack frame size warning in ath10k_hw_scan
      wifi: ath11k: fix the stack frame size warning in ath11k_vif_wow_set_wakeups

Michael Chan (2):
      bnxt_en: Update firmware interface spec to 1.10.3.85
      bnxt_en: Add a new ethtool -W dump flag

Michael Kelley (1):
      hv_netvsc: Don't assume cpu_possible_mask is dense

Michael-CY Lee (1):
      wifi: mac80211: refactor BW limitation check for CSA parsing

Michal Schmidt (4):
      qed: make 'ethtool -d' 10 times faster
      qed: put cond_resched() in qed_grc_dump_ctx_data()
      qed: allow the callee of qed_mcp_nvm_read() to sleep
      qed: put cond_resched() in qed_dmae_operation_wait()

Minda Chen (1):
      net: stmmac: Add DW QoS Eth v4/v5 ip payload error statistics

Mingwei Zheng (1):
      net: rfkill: gpio: Add check for clk_enable()

Miri Korenblit (10):
      wifi: mac80211: rename IEEE80211_CHANCTX_CHANGE_MIN_WIDTH
      wifi: mac80211: parse A-MSDU len from EHT capabilities
      wifi: mac80211: add an option to fake ieee80211_connection_loss
      wifi: iwlwifi: bump FW API to 94 for BZ/SC devices
      wifi: iwlwifi: mvm: remove unneeded check
      wifi: iwlwifi: mvm: remove IWL_MVM_HW_CSUM_DISABLE
      wifi: iwlwifi: mvm: remove redundant check
      wifi: iwlwifi: move IWL_LMAC_*_INDEX to fw/api/context.h
      wifi: iwlwifi: bump minimum API version in BZ/SC to 92
      wifi: iwlwifi: s/IWL_MVM_INVALID_STA/IWL_INVALID_STA

MoYuanhao (1):
      mptcp: remove the redundant assignment of 'new_ctx->tcp_sock' in subflow_ulp_clone()

Mohammad Heib (3):
      bnxt_en: use irq_update_affinity_hint()
      nfp: use irq_update_affinity_hint()
      net: atlantic: use irq_update_affinity_hint()

Mohammed Anees (1):
      wifi: rtw88: Refactor looping in rtw_phy_store_tx_power_by_rate

Mohan Prasad J (3):
      selftests: nic_link_layer: Add link layer selftest for NIC driver
      selftests: nic_link_layer: Add selftest case for speed and duplex states
      selftests: nic_performance: Add selftest for performance of NIC driver

Mohsin Bashir (2):
      eth: fbnic: Add support to write TCE TCAM entries
      eth: fbnic: Add support to dump registers

Moshe Shemesh (3):
      net/mlx5: Add sync reset drop mode support
      net/mlx5: fs, rename packet reformat struct member action
      net/mlx5: fs, rename modify header struct member action

Murali Karicheri (1):
      net: hsr: Add VLAN CTAG filter support

Neeraj Sanjay Kale (4):
      Bluetooth: btnxpuart: Drop _v0 suffix from FW names
      Bluetooth: btnxpuart: Rename IW615 to IW610
      dt-bindings: net: bluetooth: nxp: Add support for power save feature using GPIO
      Bluetooth: btnxpuart: Add GPIO support to power save feature

Nelson Escobar (7):
      enic: Create enic_wq/rq structures to bundle per wq/rq data
      enic: Make MSI-X I/O interrupts come after the other required ones
      enic: Save resource counts we read from HW
      enic: Allocate arrays in enic struct based on VIC config
      enic: Adjust used MSI-X wq/rq/cq/interrupt resources in a more robust way
      enic: Move enic resource adjustments to separate function
      enic: Move kdump check into enic_adjust_resources()

Nick Child (1):
      ibmvnic: Add stat for tx direct vs tx batched

Nicolas Escande (1):
      wifi: ath12k: move txbaddr/rxbaddr into struct ath12k_dp

Nicolas Rybowski (1):
      selftests/bpf: Add mptcp subflow example

Niklas Söderlund (3):
      net: phy: marvell-88q2xxx: Align soft reset for mv88q2110 and mv88q2220
      net: phy: marvell-88q2xxx: Make register writer function generic
      net: phy: marvell-88q2xxx: Enable auto negotiation for mv88q2110

Norbert van Bolhuis (1):
      wifi: brcmfmac: Fix oops due to NULL pointer dereference in brcmf_sdiod_sglist_rw()

Oleksij Rempel (10):
      dt-bindings: net: ethernet-phy: Add timing-role role property for ethernet PHYs
      net: phy: Add support for PHY timing-role configuration via device tree
      Documentation: networking: add Twisted Pair Ethernet diagnostics at OSI Layer 1
      net: macb: avoid redundant lookup for "mdio" child node in MDIO setup
      dt-bindings: net: dsa: microchip: add internal MDIO bus description
      dt-bindings: net: dsa: microchip: add mdio-parent-bus property for internal MDIO
      net: dsa: microchip: Refactor MDIO handling for side MDIO access
      net: dsa: microchip: cleanup error handling in ksz_mdio_register
      net: dsa: microchip: add support for side MDIO interface in LAN937x
      net: dsa: microchip: parse PHY config from device tree

Omid Ehtemam-Haghighi (1):
      ipv6: Fix soft lockups in fib6_select_path under high next hop churn

Paolo Abeni (43):
      Merge branch 'net-phy-support-master-slave-config-via-device-tree'
      Merge branch 'net-sparx5-prepare-for-lan969x-switch-driver'
      Merge branch 'net-fec-add-pps-channel-configuration'
      Merge branch 'rtnetlink-per-netns-rtnl'
      Merge branch 'eth-fbnic-add-timestamping-support'
      Merge branch 'net-mlx5-qos-refactor-esw-qos-to-support-new-features'
      genetlink: extend info user-storage to match NL cb ctx
      netlink: spec: add shaper YAML spec
      net-shapers: implement NL get operation
      net-shapers: implement NL set and delete operations
      net-shapers: implement NL group operation
      net-shapers: implement delete support for NODE scope shaper
      net-shapers: implement shaper cleanup on queue deletion
      netlink: spec: add shaper introspection support
      net: shaper: implement introspection support
      net-shapers: implement cap validation in the core
      testing: net-drv: add basic shaper test
      Merge branch 'make-phy-output-rmii-reference-clock'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge tag 'batadv-next-pullrequest-20241015' of git://git.open-mesh.org/linux-merge
      Merge branch 'ethtool-rss-track-rss-ctx-busy-from-core'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'add-support-of-hibmcge-ethernet-driver'
      Merge branch 'net-mlx5-refactor-esw-qos-to-support-generalized-operations'
      Merge branch 'rtnetlink-refactor-rtnl_-new-del-set-link-for-per-netns-rtnl'
      Merge branch 'selftests-net-introduce-deferred-commands'
      Merge branch 'net-netconsole-refactoring-and-warning-fix'
      virtchnl: fix m68k build.
      Merge branch 'net-sysctl-allow-dump_cpumask-to-handle-higher-numbers-of-cpus'
      Merge branch 'net-pcs-xpcs-yet-more-cleanups'
      Merge branch 'phonet-convert-all-doit-and-dumpit-to-rcu'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'ipv4-convert-rtm_-new-del-addr-and-more-to-per-netns-rtnl'
      Merge branch 'ibm-emac-more-cleanups'
      Merge branch 'virtio_net-enable-premapped-mode-by-default'
      Merge branch 'net-lan969x-add-vcap-functionality'
      ipv6: release nexthop on device removal
      selftests: net: really check for bg process completion
      Merge tag 'nf-next-24-11-07' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'net-wwan-t7xx-add-t7xx-debug-ports'
      Merge branch 'net-ip-add-drop-reasons-to-input-route'
      Merge branch 'selftests-add-selftest-for-link-layer-and-performance-testing'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Parthiban Veerasooran (7):
      net: phy: microchip_t1s: restructure cfg read/write functions arguments
      net: phy: microchip_t1s: update new initial settings for LAN865X Rev.B0
      net: phy: microchip_t1s: add support for Microchip's LAN865X Rev.B1
      net: phy: microchip_t1s: move LAN867X reset handling to a new function
      net: phy: microchip_t1s: add support for Microchip's LAN867X Rev.C1
      net: phy: microchip_t1s: add support for Microchip's LAN867X Rev.C2
      net: phy: microchip_t1s: configure collision detection based on PLCA mode

Patrisious Haddad (1):
      net/mlx5: E-switch, refactor eswitch mode change

Paul Barker (10):
      net: ravb: Factor out checksum offload enable bits
      net: ravb: Disable IP header RX checksum offloading
      net: ravb: Drop IP protocol check from RX csum verification
      net: ravb: Combine if conditions in RX csum validation
      net: ravb: Simplify types in RX csum validation
      net: ravb: Disable IP header TX checksum offloading
      net: ravb: Simplify UDP TX checksum offload
      net: ravb: Enable IPv6 RX checksum offloading for GbEth
      net: ravb: Enable IPv6 TX checksum offload for GbEth
      net: ravb: Add VLAN checksum support

Paul Davey (2):
      net: phy: marvell: Add mdix status reporting
      net: phy: aquantia: Add mdix config and reporting

Paul Greenwalt (1):
      ice: add E830 HW VF mailbox message limit support

Pedro Tammela (1):
      selftests/tc-testing: add tests for qdisc_tree_reduce_backlog

Pei Xiao (1):
      wifi: rtw89: coex: check NULL return of kmalloc in btc_fw_set_monreg()

Pengcheng Yang (1):
      tcp: only release congestion control if it has been initialized

Peter Große (1):
      i40e: Fix handling changed priv flags

Petr Machata (22):
      selftests: mlxsw: sch_red_ets: Increase required backlog
      selftests: mlxsw: sch_red_core: Increase backlog size tolerance
      selftests: mlxsw: sch_red_core: Sleep before querying queue depth
      selftests: mlxsw: sch_red_core: Send more packets for drop tests
      selftests: mlxsw: sch_red_core: Lower TBF rate
      selftests: net: lib: Introduce deferred commands
      selftests: forwarding: Add a fallback cleanup()
      selftests: forwarding: lib: Allow passing PID to stop_traffic()
      selftests: RED: Use defer for test cleanup
      selftests: TBF: Use defer for test cleanup
      selftests: ETS: Use defer for test cleanup
      selftests: mlxsw: qos_mc_aware: Use defer for test cleanup
      selftests: mlxsw: qos_ets_strict: Use defer for test cleanup
      selftests: mlxsw: qos_max_descriptors: Use defer for test cleanup
      selftests: mlxsw: devlink_trap_police: Use defer for test cleanup
      ndo_fdb_add: Add a parameter to report whether notification was sent
      ndo_fdb_del: Add a parameter to report whether notification was sent
      selftests: net: lib: Move logging from forwarding/lib.sh here
      selftests: net: lib: Move tests_run from forwarding/lib.sh here
      selftests: net: lib: Move checks from forwarding/lib.sh here
      selftests: net: lib: Add kill_process
      selftests: net: fdb_notify: Add a test for FDB notifications

Philipp Stanner (2):
      ptp_pch: Replace deprecated PCI functions
      Bluetooth: btintel_pcie: Replace deprecated PCI functions

Philo Lu (4):
      net/udp: Add a new struct for hash2 slot
      net/udp: Add 4-tuple hash list basis
      ipv4/udp: Add 4-tuple hash for connected socket
      ipv6/udp: Add 4-tuple hash for connected socket

Ping-Ke Shih (32):
      wifi: rtw89: 8922a: rfk: enlarge TSSI timeout time to 20ms
      wifi: rtw89: 8922a: rfk: support firmware command RX DCK v1 format
      wifi: rtw89: rfk: add firmware debug log of TSSI
      wifi: rtw89: rfk: add firmware debug log of IQK
      wifi: rtw89: rfk: update firmware debug log of DACK to v2
      wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb
      wifi: rtw89: check return value of ieee80211_probereq_get() for RNR
      wifi: rtw89: coex: initialize local .dbcc_2g_phy in _set_btg_ctrl()
      wifi: rtw89: 8852c: rfk: remove unnecessary assignment of return value of _dpk_dgain_read()
      wifi: rtw89: pci: consolidate PCI basic configurations for probe and resume
      wifi: rtw89: 8922ae: disable PCI PHY EQ to improve compatibility
      wifi: rtw89: 8852ce: fix gray code conversion for filter out EQ
      wifi: rtw89: 8852ce: set offset K of PCI PHY EQ to manual mode to improve compatibility
      wifi: rtw89: debug: add beacon RSSI for debugging
      wifi: rtw89: wow: cast nd_config->delay to u64 in tsf arithmetic
      wifi: rtw89: pci: use 'int' as return type of error code in poll_{tx,rx}dma_ch_idle()
      wifi: rtw89: 8851b: use 'int' as return type of error code pwr_{on,off}_func()
      wifi: rtw89: 8852b: use 'int' as return type of error code pwr_{on,off}_func()
      wifi: rtw89: 8852bt: use 'int' as return type of error code pwr_{on,off}_func()
      wifi: rtw89: 8852c: use 'int' as return type of error code pwr_{on,off}_func()
      wifi: rtw89: sar: add supported UNII-4 frequency range along with UNII-3 of SAR subband
      wifi: rtw89: add thermal protection
      wifi: rtw89: pci: add quirks by PCI subsystem ID for thermal protection
      wifi: rtlwifi: use MODULE_FIRMWARE() to declare used firmware
      wifi: rtw89: efuse: move reading efuse of fw secure info to common
      wifi: rtw89: efuse: move recognize firmware MSS info v1 to common
      wifi: rtw89: efuse: read firmware secure info v0 from efuse for WiFi 6 chips
      wifi: rtw89: fw: shrink download size of security section for RTL8852B
      wifi: rtw89: fw: set recorded IDMEM share mode in firmware header to register
      wifi: rtw89: fw: move v1 MSSC out of __parse_security_section() to share with v0
      wifi: rtw89: fw: use common function to parse security section for WiFi 6 chips
      wifi: rtw89: mac: no configure CMAC/DMAC tables for firmware secure boot

Po-Hao Huang (3):
      wifi: rtw89: Fix TX fail with A2DP after scanning
      wifi: rtw89: Add header conversion for MLO connections
      wifi: rtw89: Add encryption support for MLO connections

Pradeep Kumar Chitrapu (1):
      wifi: ath12k: Support BE OFDMA Pdev Rate Stats

Przemek Kitszel (9):
      devlink: introduce devlink_nl_put_u64()
      devlink: use devlink_nl_put_u64() helper
      devlink: devl_resource_register(): differentiate error codes
      devlink: region: snapshot IDs: consolidate error values
      net: dsa: replace devlink resource registration calls by devl_ variants
      devlink: remove unused devlink_resource_occ_get_register() and _unregister()
      devlink: remove unused devlink_resource_register()
      ice: refactor "last" segment of DDP pkg
      ice: support optional flags in signature segment header

Puranjay Mohan (4):
      net: checksum: Move from32to16() to generic header
      bpf: bpf_csum_diff: Optimize and homogenize for all archs
      selftests/bpf: Don't mask result of bpf_csum_diff() in test_verifier
      selftests/bpf: Add a selftest for bpf_csum_diff()

Raj Kumar Bhagat (1):
      wifi: ath12k: convert tasklet to BH workqueue for CE interrupts

Rajat Soni (1):
      wifi: ath12k: Support DMAC Reset Stats

Rameshkumar Sundaram (5):
      wifi: ath12k: fix use-after-free in ath12k_dp_cc_cleanup()
      wifi: ath12k: prepare vif config caching for MLO
      wifi: ath12k: modify ath12k_mac_vif_chan() for MLO
      wifi: ath12k: modify ath12k_get_arvif_iter() for MLO
      wifi: ath12k: modify ath12k_mac_op_set_key() for MLO

Ramya Gnanasekar (1):
      wifi: ath12k: Skip Rx TID cleanup for self peer

Ravi Gunasekaran (1):
      net: ti: icssg-prueth: Add VLAN support for HSR mode

Riyan Dhiman (1):
      octeontx2-af: Change block parameter to const pointer in get_lf_str_list

Rob Herring (Arm) (5):
      dt-bindings: net: snps,dwmac: Fix "snps,kbbe" type
      dt-bindings: net: mdio-mux-gpio: Drop undocumented "marvell,reg-init"
      dt-bindings: net: sff,sfp: Fix "interrupts" property typo
      dt-bindings: net: dsa: microchip,ksz: Drop undocumented "id"
      dt-bindings: net: renesas,ether: Drop undocumented "micrel,led-mode"

Roger Quadros (2):
      net: ethernet: ti: am65-cpsw: update pri_thread_map as per IEEE802.1Q-2014
      net: ethernet: ti: am65-cpsw: enable DSCP to priority map for RX

Romain Gantois (1):
      net: phy: dp83869: fix status reporting for 1000base-x autonegotiation

Ronak Doshi (1):
      vmxnet3: support higher link speeds from vmxnet3 v9

Roopni Devanathan (1):
      wifi: ath12k: Modify print_array_to_buf() to support arrays with 1-based semantics

Rosen Penev (53):
      wifi: ath9k: eeprom: remove platform data
      wifi: ath9k: btcoex: remove platform_data
      wifi: ath9k: remove ath9k_platform_data
      net: marvell: mvmdio: use clk_get_optional
      net: ag71xx: use devm_ioremap_resource
      net: ag71xx: use some dev_err_probe
      net: ag71xx: remove platform_set_drvdata
      net: ag71xx: replace INIT_LIST_HEAD
      net: ag71xx: move assignment into main loop
      net: mv643xx: use devm_platform_ioremap_resource
      net: mv643xx: fix wrong devm_clk_get usage
      net: mvneta: use ethtool_puts
      net: mtk_eth_soc: use ethtool_puts
      wifi: ath5k: add PCI ID for SX76X
      wifi: ath5k: add PCI ID for Arcadyan devices
      net: mv643xx: use ethtool_puts
      net: ibm: emac: use netif_receive_skb_list
      net: ibm: emac: use devm_platform_ioremap_resource
      net: ibm: emac: use platform_get_irq
      net: ibm: emac: use devm for mutex_init
      net: ibm: emac: generate random MAC if not found
      ibmvnic: use ethtool string helpers
      net: mana: use ethtool string helpers
      amd-xgbe: use ethtool string helpers
      net: marvell: use ethtool string helpers
      net: qlogic: use ethtool string helpers
      net: freescale: use ethtool string helpers
      net: fjes: use ethtool string helpers
      net: dsa: use ethtool string helpers
      net: phy: use ethtool string helpers
      net: bnxt: use ethtool string helpers
      net: ibm: emac: tah: use devm for kzalloc
      net: ibm: emac: tah: use devm for mutex_init
      net: ibm: emac: tah: devm_platform_get_resources
      net: ibm: emac: rgmii: use devm for kzalloc
      net: ibm: emac: rgmii: use devm for mutex_init
      net: ibm: emac: rgmii: devm_platform_get_resource
      net: ibm: emac: zmii: use devm for kzalloc
      net: ibm: emac: zmii: use devm for mutex_init
      net: ibm: emac: zmii: devm_platform_get_resource
      net: ibm: emac: mal: use devm for kzalloc
      net: ibm: emac: mal: use devm for request_irq
      net: ibm: emac: mal: move irq maps down
      net: ena: remove devm from ethtool
      net: hisilicon: hns: use ethtool string helpers
      net: bnx2x: use ethtool string helpers
      net: hisilicon: hns3: use ethtool string helpers
      net: broadcom: use ethtool string helpers
      net: ucc_geth: use devm for kmemdup
      net: ucc_geth: use devm for alloc_etherdev
      net: ucc_geth: use devm for register_netdev
      net: ucc_geth: fix usage with NVMEM MAC address
      net: sfc: use ethtool string helpers

Russell King (Oracle) (46):
      net: pcs: xpcs: move PCS reset to .pcs_pre_config()
      net: pcs: xpcs: drop interface argument from internal functions
      net: pcs: xpcs: get rid of xpcs_init_iface()
      net: pcs: xpcs: add xpcs_destroy_pcs() and xpcs_create_pcs_mdiodev()
      net: wangxun: txgbe: use phylink_pcs internally
      net: dsa: sja1105: simplify static configuration reload
      net: dsa: sja1105: call PCS config/link_up via pcs_ops structure
      net: dsa: sja1105: use phylink_pcs internally
      net: pcs: xpcs: drop interface argument from xpcs_create*()
      net: pcs: xpcs: make xpcs_do_config() and xpcs_link_up() internal
      net: dsa: remove obsolete phylink dsa_switch operations
      net: pcs: xpcs: remove dw_xpcs_compat enum
      net: pcs: xpcs: don't use array for interface
      net: pcs: xpcs: pass xpcs instead of xpcs->id to xpcs_find_compat()
      net: pcs: xpcs: provide a helper to get the phylink pcs given xpcs
      net: pcs: xpcs: move definition of struct dw_xpcs to private header
      net: pcs: xpcs: rename xpcs_get_id()
      net: pcs: xpcs: move searching ID list out of line
      net: pcs: xpcs: use FIELD_PREP() and FIELD_GET()
      net: pcs: xpcs: add _modify() accessors
      net: pcs: xpcs: convert to use read_poll_timeout()
      net: pcs: xpcs: use dev_*() to print messages
      net: pcs: xpcs: correctly place DW_VR_MII_DIG_CTRL1_2G5_EN
      net: pcs: xpcs: move Wangxun VR_XS_PCS_DIG_CTRL1 configuration
      net: dsa: remove dsa_port_phylink_mac_select_pcs()
      net: dsa: mv88e6xxx: return NULL when no PCS is present
      net: phylink: allow mac_select_pcs() to remove a PCS
      net: phylink: remove use of pl->pcs in phylink_validate_mac_and_pcs()
      net: phylink: remove "using_mac_select_pcs"
      net: pcs: xpcs: use generic register definitions
      net: pcs: xpcs: remove switch() in xpcs_link_up_1000basex()
      net: pcs: xpcs: rearrange xpcs_link_up_1000basex()
      net: pcs: xpcs: replace open-coded mii_bmcr_encode_fixed()
      net: pcs: xpcs: combine xpcs_link_up_{1000basex,sgmii}()
      net: pcs: xpcs: rename xpcs_config_usxgmii()
      net: pcs: xpcs: remove return statements in void function
      net: phylink: simplify phylink_parse_fixedlink()
      net: phylink: add common validation for sfp_select_interface()
      net: phylink: validate sfp_select_interface() returned interface
      net: phylink: simplify how SFP PHYs are attached
      net: phylink: move manual flow control setting
      net: phylink: move MLO_AN_FIXED resolve handling to if() statement
      net: phylink: move MLO_AN_PHY resolve handling to if() statement
      net: phylink: remove switch() statement in resolve handling
      net: phylink: clean up phylink_resolve()
      net: phy: fix phylib's dual eee_enabled

Sabrina Dubroca (9):
      selftests: tls: add a selftest for wrapping rec_seq
      netdevsim: add more hw_features
      selftests: netdevsim: add a test checking ethtool features
      macsec: add some of the lower device's features when offloading
      macsec: clean up local variables in macsec_notify
      macsec: inherit lower device's TSO limits when offloading
      selftests: move macsec offload tests from net/rtnetlink to drivers/net/netdvesim
      selftests: netdevsim: add test toggling macsec offload
      selftests: netdevsim: add ethtool features to macsec offload tests

Sam Edwards (1):
      net: dsa: bcm_sf2: fix crossbar port bitwidth logic

Sanman Pradhan (3):
      eth: fbnic: Add hardware monitoring support via HWMON interface
      eth: fbnic: add PCIe hardware statistics
      eth: fbnic: add RPC hardware statistics

Sascha Hauer (1):
      wifi: mwifiex: add missing locking for cfg80211 calls

Sean Anderson (1):
      selftests: net: csum: Clean up recv_verify_packet_ipv6

Sebastian Ott (1):
      net/mlx5: unique names for per device caches

Sergey Temerkhanov (6):
      ice: Enable 1PPS out from CGU for E825C products
      ice: Introduce ice_get_phy_model() wrapper
      ice: Add ice_get_ctrl_ptp() wrapper to simplify the code
      ice: Initial support for E825C hardware in ice_adapter
      ice: Use ice_adapter for PTP shared data instead of auxdev
      ice: Drop auxbus use for PTP to finalize ice_adapter move

Shengyu Qu (1):
      net: sfp: change quirks for Alcatel Lucent G-010S-P

Shradha Gupta (2):
      net: mana: Increase the DEF_RX_BUFFERS_PER_QUEUE to 1024
      net: mana: Enable debugfs files for MANA device

Shruti Parab (5):
      bnxt_en: Add mem_valid bit to struct bnxt_ctx_mem_type
      bnxt_en: Allocate backing store memory for FW trace logs
      bnxt_en: Manage the FW trace context memory
      bnxt_en: Add 2 parameters to bnxt_fill_coredump_seg_hdr()
      bnxt_en: Add FW trace coredump segments to the coredump

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw: Enable USXGMII mode for J7200 CPSW5G

Sidhanta Sahu (1):
      wifi: ath12k: Support Pdev Scheduled Algorithm Stats

Simon Horman (13):
      net/smc: Address spelling errors
      net: ethernet: ti: am65-cpsw: Use __be64 type for id_temp
      net: ethernet: ti: am65-cpsw: Use tstats instead of open coded version
      net: ethernet: ti: cpsw_ale: Remove unused accessor functions
      tg3: Address byte-order miss-matches
      net: gianfar: Use __be64 * to store pointers to big endian values
      net: dsa: microchip: copy string using strscpy
      net: txgbe: Pass string literal as format argument of alloc_workqueue()
      net: fec_mpc52xx_phy: Use %pa to format resource_size_t
      net: ethernet: fs_enet: Use %pa to format resource_size_t
      net: usb: sr9700: only store little-endian values in __le16 variable
      wwan: core: Pass string literal as format argument of dev_set_name()
      netfilter: bpf: Pass string literal as format argument of request_module()

Simon Wunderlich (1):
      batman-adv: Start new development cycle

SkyLake.Huang (8):
      net: phy: mediatek-ge-soc: Fix coding style
      net: phy: mediatek-ge-soc: Shrink line wrapping to 80 characters
      net: phy: mediatek-ge-soc: Propagate error code correctly in cal_cycle()
      net: phy: mediatek: Re-organize MediaTek ethernet phy drivers
      net: phy: mediatek: Move LED helper functions into mtk phy lib
      net: phy: mediatek: Improve readability of mtk-phy-lib.c's mtk_phy_led_hw_ctrl_set()
      net: phy: mediatek: Integrate read/write page helper functions
      net: phy: mediatek: add MT7530 & MT7531's PHY ID macros

Sowmiya Sree Elavalagan (1):
      wifi: ath12k: Add firmware coredump collection support

Sreekanth Reddy (1):
      bnxt_en: Add functions to copy host context memory

Sriram R (7):
      wifi: ath12k: prepare vif data structure for MLO handling
      wifi: ath12k: pass ath12k_link_vif instead of vif/ahvif
      wifi: ath12k: prepare sta data structure for MLO handling
      wifi: ath12k: modify ath12k_mac_op_bss_info_changed() for MLO
      wifi: ath12k: update ath12k_mac_op_conf_tx() for MLO
      wifi: ath12k: update ath12k_mac_op_update_vif_offload() for MLO
      wifi: ath12k: modify link arvif creation and removal for MLO

Stanislav Fomichev (12):
      selftests: ncdevmem: Redirect all non-payload output to stderr
      selftests: ncdevmem: Separate out dmabuf provider
      selftests: ncdevmem: Unify error handling
      selftests: ncdevmem: Make client_ip optional
      selftests: ncdevmem: Remove default arguments
      selftests: ncdevmem: Switch to AF_INET6
      selftests: ncdevmem: Properly reset flow steering
      selftests: ncdevmem: Use YNL to enable TCP header split
      selftests: ncdevmem: Remove hard-coded queue numbers
      selftests: ncdevmem: Run selftest when none of the -s or -c has been provided
      selftests: ncdevmem: Move ncdevmem under drivers/net/hw
      selftests: ncdevmem: Add automated test

Stefan Wahren (2):
      qca_spi: Count unexpected WRBUF_SPC_AVA after reset
      qca_spi: Improve reset mechanism

Steffen Klassert (6):
      xfrm: Add support for per cpu xfrm state handling.
      xfrm: Cache used outbound xfrm states at the policy.
      xfrm: Add an inbound percpu state cache.
      xfrm: Restrict percpu SA attribute to specific netlink message types
      Merge branch 'xfrm: Convert __xfrm4_dst_lookup() and its callers to dscp_t.'
      xfrm: Fix acquire state insertion.

Sudheer Mogilappagari (2):
      iavf: Add net_shaper_ops support
      iavf: add support to exchange qos capabilities

Sven Eckelmann (1):
      batman-adv: Use string choice helper to print booleans

Sven Schnelle (2):
      s390/time: Add clocksource id to TOD clock
      s390/time: Add PtP driver

Takamitsu Iwai (1):
      e1000e: Remove duplicated writel() in e1000_configure_tx/rx()

Tarun Alle (2):
      net: phy: microchip_t1: SQI support for LAN887x
      net: phy: microchip_t1: Clause-45 PHY loopback support for LAN887x

Tobias Klauser (2):
      ipv6: Remove redundant unlikely()
      wireguard: device: omit unnecessary memset of netdev private data

Tristram Ha (2):
      dt-bindings: net: dsa: microchip: Add LAN9646 switch support
      net: dsa: microchip: Add LAN9646 switch support to KSZ DSA driver

Uros Bizjak (1):
      netfilter: nf_tables: Fix percpu address space issues in nf_tables_api.c

Uwe Kleine-König (5):
      net: ethernet: Switch back to struct platform_driver::remove()
      net: dsa: Switch back to struct platform_driver::remove()
      net: mdio: Switch back to struct platform_driver::remove()
      net: Switch back to struct platform_driver::remove()
      wifi: Switch back to struct platform_driver::remove()

Vadim Fedorenko (13):
      net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message
      net_tstamp: add SCM_TS_OPT_ID for RAW sockets
      selftests: txtimestamp: add SCM_TS_OPT_ID test
      eth: fbnic: add software TX timestamping support
      eth: fbnic: add initial PHC support
      eth: fbnic: add RX packets timestamping support
      eth: fbnic: add TX packets timestamping support
      eth: fbnic: add ethtool timestamping statistics
      mlx5_en: use read sequence for gettimex64
      bnxt_en: cache only 24 bits of hw counter
      bnxt_en: replace PTP spinlock with seqlock
      bnxt_en: add unlocked version of bnxt_refclk_read
      bnxt_en: optimize gettimex64

Vasileios Amoiridis (3):
      wifi: brcmfmac: of: Make use of irq_get_trigger_type()
      wifi: wlcore: sdio: Make use of irq_get_trigger_type()
      wifi: wlcore: sdio: Use helper to define resources

Vincent Li (1):
      selftests/bpf: remove xdp_synproxy IP_DF check

Vitalii Mordan (1):
      stmmac: dwmac-intel-plat: remove redundant dwmac->data check in probe

Vitaly Lifshits (1):
      igc: remove autoneg parameter from igc_mac_info

Vladimir Oltean (19):
      lib: packing: refuse operating on bit indices which exceed size of buffer
      lib: packing: adjust definitions and implementation for arbitrary buffer lengths
      lib: packing: remove kernel-doc from header file
      lib: packing: add pack() and unpack() wrappers over packing()
      lib: packing: duplicate pack() and unpack() implementations
      lib: packing: use BITS_PER_BYTE instead of 8
      lib: packing: use GENMASK() for box_mask
      lib: packing: catch kunit_kzalloc() failure in the pack() test
      net/sched: act_api: unexport tcf_action_dump_1()
      net: sched: propagate "skip_sw" flag to struct flow_cls_common_offload
      net: dsa: clean up dsa_user_add_cls_matchall()
      net: dsa: use "extack" as argument to flow_action_basic_hw_stats_check()
      net: dsa: add more extack messages in dsa_user_add_cls_matchall_mirred()
      net: dsa: allow matchall mirroring rules towards the CPU
      net: mscc: ocelot: allow tc-flower mirred action towards foreign interfaces
      net: enetc: remove ERR050089 workaround for i.MX95
      soc: fsl_qbman: use be16_to_cpu() in qm_sg_entry_get_off()
      net: dpaa_eth: add assertions about SGT entry offsets in sg_fd_to_skb()
      net: dpaa_eth: extract hash using __be32 pointer in rx_default_dqrr()

Vladimir Vdovin (1):
      net: ipv4: Cache pmtu for all packet paths if multipath enabled

Wander Lairson Costa (1):
      igbvf: remove unused spinlock

WangYuli (1):
      eth: Fix typo 'accelaration'. 'exprienced' and 'rewritting'

Wei Fang (11):
      dt-bindings: net: tja11xx: add "nxp,rmii-refclk-out" property
      net: phy: c45-tja11xx: add support for outputting RMII reference clock
      dt-bindings: net: add compatible string for i.MX95 EMDIO
      dt-bindings: net: add i.MX95 ENETC support
      dt-bindings: net: add bindings for NETC blocks control
      net: enetc: add initial netc-blk-ctrl driver support
      net: enetc: extract common ENETC PF parts for LS1028A and i.MX95 platforms
      net: enetc: build enetc_pf_common.c as a separate module
      net: enetc: add i.MX95 EMDIO support
      net: enetc: add preliminary support for i.MX95 ENETC PF
      MAINTAINERS: update ENETC driver files and maintainers

Wenjun Wu (2):
      virtchnl: support queue rate limit and quanta size configuration
      ice: Support VF queue rate limit and quanta size configuration

William Tu (2):
      net/mlx5e: move XDP_REDIRECT sq to dynamic allocation
      net/mlx5e: do not create xdp_redirect for non-uplink rep

WingMan Kwok (1):
      net: hsr: Add VLAN support

Wojciech Drewek (1):
      ice: Implement ethtool reset support

Xuan Zhuo (17):
      virtio-net: fix overflow inside virtnet_rq_alloc
      virtio_net: big mode skip the unmap check
      virtio_net: enable premapped mode for merge and small by default
      virtio_net: rx remove premapped failover code
      virtio_ring: introduce vring_need_unmap_buffer
      virtio_ring: split: record extras for indirect buffers
      virtio_ring: packed: record extras for indirect buffers
      virtio_ring: perform premapped operations based on per-buffer
      virtio_ring: introduce add api for premapped
      virtio-net: rq submits premapped per-buffer
      virtio_ring: remove API virtqueue_set_dma_premapped
      virtio_net: refactor the xmit type
      virtio_net: xsk: bind/unbind xsk for tx
      virtio_net: xsk: prevent disable tx napi
      virtio_net: xsk: tx: support xmit xsk buffer
      virtio_net: update tx timeout record
      virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY

Yafang Shao (2):
      compiler_types: Add noinline_for_tracing annotation
      net: tcp: Add noinline_for_tracing annotation for tcp_drop_reason()

Yajun Deng (1):
      net: use sock_valbool_flag() only in __sock_set_timestamps()

Yan Zhen (2):
      wifi: rt2x00: convert comma to semicolon
      bluetooth: Fix typos in the comments

Yazen Ghannam (1):
      net: amd8111e: Remove duplicate definition of PCI_VENDOR_ID_AMD

Yedidya Benshimol (1):
      wifi: iwlwifi: fw: add an error table status getter

Yevgeny Kliteynik (2):
      net/mlx5: DR, moved all the SWS code into a separate directory
      net/mlx5: HWS, renamed the files in accordance with naming convention

Yijie Yang (2):
      dt-bindings: net: qcom,ethqos: add description for qcs615
      dt-bindings: net: qcom,ethqos: add description for qcs8300

Yochai Hagvi (1):
      ice: Read SDP section from NVM for pin definitions

Yu Liao (1):
      net: hsr: convert to use new timer APIs

Yuan Can (1):
      wifi: wfx: Fix error handling in wfx_core_init()

Yue Haibing (3):
      ice: Cleanup unused declarations
      iavf: Remove unused declarations
      igb: Cleanup unused declarations

Yunsheng Lin (8):
      mm: page_frag: add a test module for page_frag
      mm: move the page fragment allocator from page_alloc into its own file
      mm: page_frag: use initial zero offset for page_frag_alloc_align()
      mm: page_frag: avoid caller accessing 'page_frag_cache' directly
      xtensa: remove the get_order() implementation
      mm: page_frag: reuse existing space for 'size' and 'pfmemalloc'
      mm: page_frag: use __alloc_pages() to replace alloc_pages_node()
      mm: page_frag: fix a compile error when kernel is not compiled

Yunshui Jiang (1):
      tests: hsr: Increase timeout to 50 seconds

Zhen Lei (2):
      bna: Remove error checking for debugfs create APIs
      bna: Remove field bnad_dentry_files[] in struct bnad

Zijian Zhang (10):
      selftests/bpf: Fix msg_verify_data in test_sockmap
      selftests/bpf: Fix txmsg_redir of test_txmsg_pull in test_sockmap
      selftests/bpf: Add txmsg_pass to pull/push/pop in test_sockmap
      selftests/bpf: Fix SENDPAGE data logic in test_sockmap
      selftests/bpf: Fix total_bytes in msg_loop_rx in test_sockmap
      selftests/bpf: Add push/pop checking for msg_verify_data in test_sockmap
      selftests/bpf: Add more tests for test_txmsg_push_pop in test_sockmap
      bpf, sockmap: Several fixes to bpf_msg_push_data
      bpf, sockmap: Several fixes to bpf_msg_pop_data
      bpf, sockmap: Fix sk_msg_reset_curr

Zijun Hu (3):
      net: qcom/emac: Find sgmii_ops by device_for_each_child()
      Bluetooth: btusb: Add one more ID 0x0489:0xe0f3 for Qualcomm WCN785x
      Bluetooth: btusb: Add one more ID 0x13d3:0x3623 for Qualcomm WCN785x

Ziwei Xiao (1):
      gve: Flow steering trigger reset only for timeout error

Zong-Zhe Yang (14):
      wifi: rtw89: rename rtw89_vif to rtw89_vif_link ahead for MLO
      wifi: rtw89: rename rtw89_sta to rtw89_sta_link ahead for MLO
      wifi: rtw89: read bss_conf corresponding to the link
      wifi: rtw89: read link_sta corresponding to the link
      wifi: rtw89: refactor VIF related func ahead for MLO
      wifi: rtw89: refactor STA related func ahead for MLO
      wifi: rtw89: tweak driver architecture for impending MLO support
      wifi: rtw89: initialize dual HW bands for MLO and control them by link
      wifi: rtw89: handle entity active flag per PHY
      wifi: rtw89: regd: block 6 GHz if marked as N/A in regd map
      wifi: rtw89: chan: manage active interfaces
      wifi: rtw89: tweak setting of channel and TX power for MLO
      wifi: rtw89: 8922a: extend RFK handling and consider MLO
      wifi: mac80211: fix description of ieee80211_set_active_links() for new sequence

guanjing (1):
      selftests: netfilter: Fix missing return values in conntrack_dump_flush

tuqiang (1):
      Documentation: tipc: fix formatting issue in tipc.rst

xin.guo (1):
      tcp: remove unnecessary update for tp->write_seq in tcp_connect()

zhang jiao (1):
      selftests/net: Add missing va_end.

 Documentation/admin-guide/kernel-parameters.txt    |    1 +
 Documentation/core-api/packing.rst                 |   71 +
 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml     |    8 +
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml |   22 +-
 .../devicetree/bindings/net/dsa/realtek.yaml       |   46 +-
 .../devicetree/bindings/net/ethernet-phy.yaml      |   21 +
 .../devicetree/bindings/net/fsl,enetc-mdio.yaml    |   11 +-
 .../devicetree/bindings/net/fsl,enetc.yaml         |   28 +-
 Documentation/devicetree/bindings/net/fsl,fec.yaml |    7 +
 .../devicetree/bindings/net/marvell,aquantia.yaml  |    6 +
 .../devicetree/bindings/net/mdio-mux-gpio.yaml     |   32 -
 .../bindings/net/microchip,sparx5-switch.yaml      |   20 +-
 .../devicetree/bindings/net/nfc/nxp,nci.yaml       |    1 +
 .../devicetree/bindings/net/nxp,netc-blk-ctrl.yaml |  104 +
 .../devicetree/bindings/net/nxp,tja11xx.yaml       |   16 +
 .../devicetree/bindings/net/qcom,ethqos.yaml       |   19 +-
 .../devicetree/bindings/net/renesas,ether.yaml     |    4 +-
 Documentation/devicetree/bindings/net/sff,sfp.yaml |    2 +-
 .../devicetree/bindings/net/snps,dwmac.yaml        |    5 +-
 .../devicetree/bindings/net/thead,th1520-gmac.yaml |  110 +
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   |    9 +
 .../bindings/net/wireless/microchip,wilc1000.yaml  |    6 +-
 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |   29 +
 .../devicetree/bindings/net/xlnx,emaclite.yaml     |    5 +
 Documentation/fault-injection/fault-injection.rst  |   40 +
 Documentation/netlink/specs/dpll.yaml              |   41 +
 Documentation/netlink/specs/ethtool.yaml           |   11 +-
 Documentation/netlink/specs/net_shaper.yaml        |  362 ++
 Documentation/netlink/specs/netdev.yaml            |   35 +
 Documentation/netlink/specs/rt_link.yaml           |   19 +
 Documentation/netlink/specs/rt_neigh.yaml          |  442 ++
 Documentation/netlink/specs/rt_rule.yaml           |  242 +
 Documentation/netlink/specs/tc.yaml                |    2 +-
 Documentation/networking/bonding.rst               |   11 +
 .../device_drivers/ethernet/intel/ice.rst          |   31 +
 .../device_drivers/ethernet/marvell/octeontx2.rst  |   91 +
 .../device_drivers/ethernet/meta/fbnic.rst         |   43 +
 .../networking/device_drivers/wwan/t7xx.rst        |   64 +-
 Documentation/networking/devlink/octeontx2.rst     |   21 +
 Documentation/networking/diagnostic/index.rst      |   17 +
 .../diagnostic/twisted_pair_layer1_diagnostics.rst |  767 ++++
 Documentation/networking/ethtool-netlink.rst       |    3 +
 Documentation/networking/index.rst                 |    1 +
 Documentation/networking/kapi.rst                  |    3 +
 Documentation/networking/napi.rst                  |  170 +-
 .../net_cachelines/inet_connection_sock.rst        |   86 +-
 .../networking/net_cachelines/inet_sock.rst        |   74 +-
 .../networking/net_cachelines/net_device.rst       |  359 +-
 .../net_cachelines/netns_ipv4_sysctl.rst           |  300 +-
 Documentation/networking/net_cachelines/snmp.rst   |  256 +-
 .../networking/net_cachelines/tcp_sock.rst         |  250 +-
 Documentation/networking/net_dim.rst               |    2 +-
 Documentation/networking/timestamping.rst          |   14 +
 Documentation/networking/tipc.rst                  |    2 +-
 MAINTAINERS                                        |   55 +-
 arch/alpha/include/uapi/asm/socket.h               |    2 +
 arch/mips/configs/mtx1_defconfig                   |    1 -
 arch/mips/include/uapi/asm/socket.h                |    2 +
 arch/parisc/include/uapi/asm/socket.h              |    2 +
 arch/parisc/lib/checksum.c                         |   13 +-
 arch/powerpc/configs/ppc6xx_defconfig              |    1 -
 arch/s390/include/asm/stp.h                        |    1 +
 arch/s390/include/asm/timex.h                      |    6 +
 arch/s390/kernel/time.c                            |    7 +
 arch/sparc/include/uapi/asm/socket.h               |    2 +
 arch/xtensa/include/asm/page.h                     |   18 -
 drivers/bluetooth/btbcm.c                          |    4 +-
 drivers/bluetooth/btintel.c                        |  108 +-
 drivers/bluetooth/btintel.h                        |   10 +
 drivers/bluetooth/btintel_pcie.c                   |  387 +-
 drivers/bluetooth/btintel_pcie.h                   |   18 +-
 drivers/bluetooth/btmtk.c                          |    3 +-
 drivers/bluetooth/btmtksdio.c                      |   21 +-
 drivers/bluetooth/btmtkuart.c                      |    2 +-
 drivers/bluetooth/btnxpuart.c                      |   81 +-
 drivers/bluetooth/btrtl.c                          |    2 +-
 drivers/bluetooth/btusb.c                          |   76 +-
 drivers/bluetooth/hci_bcm.c                        |   25 +-
 drivers/bluetooth/hci_ldisc.c                      |    2 +-
 drivers/bluetooth/hci_ll.c                         |    2 +-
 drivers/bluetooth/hci_nokia.c                      |    2 +-
 drivers/bluetooth/hci_qca.c                        |   32 +-
 drivers/dpll/dpll_netlink.c                        |   24 +
 drivers/isdn/hardware/mISDN/hfcmulti.c             |   16 +-
 drivers/net/Kconfig                                |    1 +
 drivers/net/amt.c                                  |   12 +-
 drivers/net/bareudp.c                              |   16 +-
 drivers/net/bonding/bond_main.c                    |   16 +-
 drivers/net/can/vxcan.c                            |   12 +-
 drivers/net/dsa/b53/b53_common.c                   |    3 +-
 drivers/net/dsa/b53/b53_mmap.c                     |    2 +-
 drivers/net/dsa/b53/b53_srab.c                     |    2 +-
 drivers/net/dsa/bcm_sf2.c                          |   15 +-
 drivers/net/dsa/bcm_sf2.h                          |    5 +-
 drivers/net/dsa/bcm_sf2_cfp.c                      |   22 +-
 drivers/net/dsa/dsa_loop.c                         |    3 +-
 drivers/net/dsa/hirschmann/hellcreek.c             |   10 +-
 drivers/net/dsa/lantiq_gswip.c                     |    2 +-
 drivers/net/dsa/microchip/ksz9477.c                |    4 +
 drivers/net/dsa/microchip/ksz9477_i2c.c            |   14 +-
 drivers/net/dsa/microchip/ksz_common.c             |  315 +-
 drivers/net/dsa/microchip/ksz_common.h             |   60 +
 drivers/net/dsa/microchip/ksz_ptp.c                |    2 +-
 drivers/net/dsa/microchip/ksz_spi.c                |    7 +
 drivers/net/dsa/microchip/lan937x.h                |    2 +
 drivers/net/dsa/microchip/lan937x_main.c           |  226 +-
 drivers/net/dsa/microchip/lan937x_reg.h            |    4 +
 drivers/net/dsa/mt7530-mmio.c                      |    2 +-
 drivers/net/dsa/mt7530.c                           |   49 +
 drivers/net/dsa/mt7530.h                           |   12 +
 drivers/net/dsa/mv88e6xxx/Kconfig                  |   10 +
 drivers/net/dsa/mv88e6xxx/Makefile                 |    1 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |  133 +-
 drivers/net/dsa/mv88e6xxx/chip.h                   |   22 +-
 drivers/net/dsa/mv88e6xxx/devlink.c                |   11 +-
 drivers/net/dsa/mv88e6xxx/global1_vtu.c            |    3 +
 drivers/net/dsa/mv88e6xxx/leds.c                   |  839 ++++
 drivers/net/dsa/mv88e6xxx/port.c                   |    1 +
 drivers/net/dsa/mv88e6xxx/port.h                   |  133 +
 drivers/net/dsa/mv88e6xxx/serdes.c                 |   14 +-
 drivers/net/dsa/mv88e6xxx/serdes.h                 |    8 +-
 drivers/net/dsa/ocelot/ocelot_ext.c                |    2 +-
 drivers/net/dsa/ocelot/seville_vsc9953.c           |    2 +-
 drivers/net/dsa/qca/qca8k-8xxx.c                   |    2 +-
 drivers/net/dsa/realtek/realtek-mdio.c             |    2 +-
 drivers/net/dsa/realtek/realtek-smi.c              |    2 +-
 drivers/net/dsa/realtek/rtl8365mb.c                |    2 +-
 drivers/net/dsa/realtek/rtl8366rb.c                |    2 +-
 drivers/net/dsa/rzn1_a5psw.c                       |    8 +-
 drivers/net/dsa/sja1105/sja1105.h                  |    2 +-
 drivers/net/dsa/sja1105/sja1105_ethtool.c          |    7 +-
 drivers/net/dsa/sja1105/sja1105_main.c             |   85 +-
 drivers/net/dsa/sja1105/sja1105_mdio.c             |   28 +-
 drivers/net/dsa/vitesse-vsc73xx-platform.c         |    2 +-
 drivers/net/dsa/xrs700x/xrs700x.c                  |    6 +-
 drivers/net/dummy.c                                |   17 +-
 drivers/net/ethernet/8390/ax88796.c                |    2 +-
 drivers/net/ethernet/8390/mcf8390.c                |    2 +-
 drivers/net/ethernet/8390/ne.c                     |    2 +-
 drivers/net/ethernet/actions/owl-emac.c            |    2 +-
 drivers/net/ethernet/aeroflex/greth.c              |    2 +-
 drivers/net/ethernet/allwinner/sun4i-emac.c        |    2 +-
 drivers/net/ethernet/altera/altera_tse_main.c      |    2 +-
 drivers/net/ethernet/amazon/ena/ena_com.c          |   58 +-
 drivers/net/ethernet/amazon/ena/ena_com.h          |   32 -
 drivers/net/ethernet/amazon/ena/ena_ethtool.c      |   14 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   42 +-
 drivers/net/ethernet/amd/amd8111e.h                |    1 -
 drivers/net/ethernet/amd/au1000_eth.c              |    2 +-
 drivers/net/ethernet/amd/sunlance.c                |    2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       |   22 +-
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c      |    2 +-
 drivers/net/ethernet/apm/xgene-v2/main.c           |    2 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   |    2 +-
 drivers/net/ethernet/apple/macmace.c               |    2 +-
 .../net/ethernet/aquantia/atlantic/aq_ethtool.c    |   73 +
 .../net/ethernet/aquantia/atlantic/aq_ethtool.h    |    8 +
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h     |    3 +
 .../net/ethernet/aquantia/atlantic/aq_pci_func.c   |    6 +-
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c  |  132 +
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c |   43 +
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.h |   21 +
 .../aquantia/atlantic/hw_atl/hw_atl_llh_internal.h |   32 +
 drivers/net/ethernet/arc/emac_rockchip.c           |    2 +-
 drivers/net/ethernet/atheros/ag71xx.c              |   37 +-
 drivers/net/ethernet/broadcom/Kconfig              |    3 -
 drivers/net/ethernet/broadcom/asp2/bcmasp.c        |    2 +-
 .../net/ethernet/broadcom/asp2/bcmasp_ethtool.c    |    7 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |    3 +
 drivers/net/ethernet/broadcom/bcm4908_enet.c       |    2 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.c       |   16 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |   48 +-
 drivers/net/ethernet/broadcom/bcmsysport.h         |   23 +
 drivers/net/ethernet/broadcom/bgmac-platform.c     |    2 +-
 drivers/net/ethernet/broadcom/bgmac.c              |    3 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    |   68 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  452 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   58 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c |  160 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h |   43 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c  |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  163 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h  |    1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h      |  173 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |  132 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h      |   43 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   10 +-
 drivers/net/ethernet/broadcom/sb1250-mac.c         |    2 +-
 drivers/net/ethernet/broadcom/tg3.c                |   80 +-
 drivers/net/ethernet/broadcom/tg3.h                |    2 +-
 drivers/net/ethernet/brocade/bna/bnad.h            |    1 -
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c    |   31 +-
 drivers/net/ethernet/cadence/macb_main.c           |   28 +-
 drivers/net/ethernet/calxeda/xgmac.c               |    2 +-
 .../ethernet/cavium/liquidio/cn23xx_pf_device.c    |  169 -
 .../ethernet/cavium/liquidio/cn23xx_pf_device.h    |    2 -
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c   |    2 +-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c |   39 -
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.h |    3 -
 drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c      |    4 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h         |   23 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |   12 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_mps.c     |   98 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h     |    2 -
 drivers/net/ethernet/chelsio/cxgb4/l2t.c           |   19 -
 drivers/net/ethernet/chelsio/cxgb4/l2t.h           |    2 -
 drivers/net/ethernet/chelsio/cxgb4/sge.c           |   16 -
 drivers/net/ethernet/chelsio/cxgb4/srq.c           |   58 -
 drivers/net/ethernet/chelsio/cxgb4/srq.h           |    2 -
 .../ethernet/chelsio/inline_crypto/chtls/chtls.h   |    1 -
 .../chelsio/inline_crypto/chtls/chtls_hw.c         |    9 -
 .../chelsio/inline_crypto/chtls/chtls_main.c       |    4 +-
 drivers/net/ethernet/cirrus/cs89x0.c               |    2 +-
 drivers/net/ethernet/cirrus/ep93xx_eth.c           |    2 +-
 drivers/net/ethernet/cirrus/mac89x0.c              |    2 +-
 drivers/net/ethernet/cisco/enic/enic.h             |   62 +-
 drivers/net/ethernet/cisco/enic/enic_ethtool.c     |    8 +-
 drivers/net/ethernet/cisco/enic/enic_main.c        |  386 +-
 drivers/net/ethernet/cisco/enic/enic_res.c         |   42 +-
 drivers/net/ethernet/cortina/gemini.c              |    4 +-
 drivers/net/ethernet/davicom/dm9000.c              |    2 +-
 drivers/net/ethernet/dlink/Kconfig                 |   20 -
 drivers/net/ethernet/dlink/Makefile                |    1 -
 drivers/net/ethernet/dlink/sundance.c              | 1985 ---------
 drivers/net/ethernet/dnet.c                        |    2 +-
 drivers/net/ethernet/engleder/tsnep_main.c         |    2 +-
 drivers/net/ethernet/ethoc.c                       |    2 +-
 drivers/net/ethernet/ezchip/nps_enet.c             |    2 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |   32 +-
 drivers/net/ethernet/faraday/ftmac100.c            |    2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |   48 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   40 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-ethtool.c   |   15 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c   |    9 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h   |    2 +-
 .../freescale/dpaa2/dpaa2-switch-ethtool.c         |    9 +-
 drivers/net/ethernet/freescale/enetc/Kconfig       |   40 +
 drivers/net/ethernet/freescale/enetc/Makefile      |    9 +
 drivers/net/ethernet/freescale/enetc/enetc.c       |  271 +-
 drivers/net/ethernet/freescale/enetc/enetc.h       |   30 +-
 drivers/net/ethernet/freescale/enetc/enetc4_hw.h   |  155 +
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c   |  756 ++++
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   |   70 +-
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |   53 +-
 .../net/ethernet/freescale/enetc/enetc_pci_mdio.c  |   31 +
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |  314 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.h    |   21 +
 .../net/ethernet/freescale/enetc/enetc_pf_common.c |  336 ++
 .../net/ethernet/freescale/enetc/enetc_pf_common.h |   19 +
 drivers/net/ethernet/freescale/enetc/enetc_qos.c   |    2 +-
 drivers/net/ethernet/freescale/enetc/enetc_vf.c    |    8 +
 .../net/ethernet/freescale/enetc/netc_blk_ctrl.c   |  445 ++
 drivers/net/ethernet/freescale/fec_main.c          |    2 +-
 drivers/net/ethernet/freescale/fec_mpc52xx.c       |    2 +-
 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c   |    4 +-
 drivers/net/ethernet/freescale/fec_ptp.c           |   11 +-
 drivers/net/ethernet/freescale/fman/fman.c         |    1 -
 drivers/net/ethernet/freescale/fman/fman.h         |    3 +
 drivers/net/ethernet/freescale/fman/fman_dtsec.c   |    1 -
 drivers/net/ethernet/freescale/fman/fman_memac.c   |    1 -
 drivers/net/ethernet/freescale/fman/fman_port.c    |    2 +-
 drivers/net/ethernet/freescale/fman/fman_tgec.c    |    1 -
 drivers/net/ethernet/freescale/fman/mac.c          |   49 +-
 drivers/net/ethernet/freescale/fman/mac.h          |    2 -
 .../net/ethernet/freescale/fs_enet/fs_enet-main.c  |    2 +-
 .../net/ethernet/freescale/fs_enet/mii-bitbang.c   |    4 +-
 drivers/net/ethernet/freescale/fs_enet/mii-fec.c   |    2 +-
 drivers/net/ethernet/freescale/fsl_pq_mdio.c       |    2 +-
 drivers/net/ethernet/freescale/gianfar.c           |    9 +-
 drivers/net/ethernet/freescale/gianfar_ethtool.c   |    8 +-
 drivers/net/ethernet/freescale/ucc_geth.c          |   36 +-
 drivers/net/ethernet/freescale/ucc_geth_ethtool.c  |   21 +-
 drivers/net/ethernet/fungible/funcore/fun_queue.c  |   65 -
 drivers/net/ethernet/fungible/funcore/fun_queue.h  |    1 -
 drivers/net/ethernet/google/Kconfig                |    1 +
 drivers/net/ethernet/google/gve/Makefile           |    3 +-
 drivers/net/ethernet/google/gve/gve.h              |   36 +
 drivers/net/ethernet/google/gve/gve_adminq.c       |    4 +-
 .../net/ethernet/google/gve/gve_buffer_mgmt_dqo.c  |  311 ++
 drivers/net/ethernet/google/gve/gve_main.c         |   66 +
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |  314 +-
 drivers/net/ethernet/google/gve/gve_utils.c        |    1 +
 drivers/net/ethernet/hisilicon/Kconfig             |   18 +-
 drivers/net/ethernet/hisilicon/Makefile            |    1 +
 drivers/net/ethernet/hisilicon/hibmcge/Makefile    |    8 +
 .../net/ethernet/hisilicon/hibmcge/hbg_common.h    |  131 +
 .../net/ethernet/hisilicon/hibmcge/hbg_ethtool.c   |   17 +
 .../net/ethernet/hisilicon/hibmcge/hbg_ethtool.h   |   11 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c    |  271 ++
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h    |   59 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c   |  127 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.h   |   11 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c  |  253 ++
 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c  |  222 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h  |   12 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h   |  143 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c  |  409 ++
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h  |   39 +
 drivers/net/ethernet/hisilicon/hip04_eth.c         |    2 +-
 drivers/net/ethernet/hisilicon/hisi_femac.c        |    2 +-
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c      |    2 +-
 drivers/net/ethernet/hisilicon/hns/hnae.h          |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  |   20 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |    5 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |   13 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h  |    4 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c |   72 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  |   31 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h  |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |   66 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h  |    2 +-
 .../net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c    |    5 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |   67 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |    2 +-
 .../hns3/hns3_common/hclge_comm_tqp_stats.c        |   11 +-
 .../hns3/hns3_common/hclge_comm_tqp_stats.h        |    2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |    4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   54 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   50 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |    6 +-
 drivers/net/ethernet/hisilicon/hns_mdio.c          |    2 +-
 drivers/net/ethernet/i825xx/sni_82596.c            |    2 +-
 drivers/net/ethernet/ibm/ehea/ehea_main.c          |    2 +-
 drivers/net/ethernet/ibm/emac/core.c               |   44 +-
 drivers/net/ethernet/ibm/emac/mal.c                |   90 +-
 drivers/net/ethernet/ibm/emac/rgmii.c              |   49 +-
 drivers/net/ethernet/ibm/emac/tah.c                |   49 +-
 drivers/net/ethernet/ibm/emac/zmii.c               |   49 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |   45 +-
 drivers/net/ethernet/ibm/ibmvnic.h                 |    3 +-
 drivers/net/ethernet/intel/Kconfig                 |    1 +
 drivers/net/ethernet/intel/e1000/e1000_main.c      |   15 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |   17 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |    3 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |   23 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  161 +-
 drivers/net/ethernet/intel/iavf/iavf_prototype.h   |    3 -
 drivers/net/ethernet/intel/iavf/iavf_txrx.h        |    2 +
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |  157 +-
 drivers/net/ethernet/intel/ice/ice.h               |   17 +-
 drivers/net/ethernet/intel/ice/ice_adapter.c       |   22 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h       |   22 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |   26 +
 drivers/net/ethernet/intel/ice/ice_base.c          |   39 +-
 drivers/net/ethernet/intel/ice/ice_common.c        |   21 +
 drivers/net/ethernet/intel/ice/ice_ddp.c           |  302 +-
 drivers/net/ethernet/intel/ice/ice_ddp.h           |    5 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.h       |    5 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  187 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.h       |   39 +-
 drivers/net/ethernet/intel/ice/ice_flex_pipe.h     |    3 -
 drivers/net/ethernet/intel/ice/ice_gnss.c          |    4 +-
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h    |   11 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |    9 +-
 drivers/net/ethernet/intel/ice/ice_lib.h           |    2 -
 drivers/net/ethernet/intel/ice/ice_main.c          |   68 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           | 1487 +++----
 drivers/net/ethernet/intel/ice/ice_ptp.h           |  143 +-
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h    |    2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        |  125 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h        |   80 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c         |    3 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |    4 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h          |    4 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h      |    1 -
 drivers/net/ethernet/intel/ice/ice_type.h          |    1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |   26 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h        |    8 +
 drivers/net/ethernet/intel/ice/ice_vf_mbx.c        |   32 +
 drivers/net/ethernet/intel/ice/ice_vf_mbx.h        |    9 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |  428 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h      |   11 +
 .../ethernet/intel/ice/ice_virtchnl_allowlist.c    |    6 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |    4 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |    3 +-
 drivers/net/ethernet/intel/igb/e1000_mac.h         |    1 -
 drivers/net/ethernet/intel/igb/e1000_nvm.h         |    1 -
 drivers/net/ethernet/intel/igb/igb_main.c          |    6 +-
 drivers/net/ethernet/intel/igbvf/igbvf.h           |    3 -
 drivers/net/ethernet/intel/igbvf/netdev.c          |    3 -
 drivers/net/ethernet/intel/igc/igc_diag.c          |    3 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   13 +-
 drivers/net/ethernet/intel/igc/igc_hw.h            |    1 -
 drivers/net/ethernet/intel/igc/igc_mac.c           |  316 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |    1 -
 drivers/net/ethernet/intel/igc/igc_phy.c           |   24 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c     |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h       |   16 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      |   15 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c      |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |    1 +
 drivers/net/ethernet/korina.c                      |    2 +-
 drivers/net/ethernet/lantiq_etop.c                 |    2 +-
 drivers/net/ethernet/lantiq_xrx200.c               |    2 +-
 drivers/net/ethernet/litex/litex_liteeth.c         |    2 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c         |   42 +-
 drivers/net/ethernet/marvell/mvmdio.c              |   13 +-
 drivers/net/ethernet/marvell/mvneta.c              |    6 +-
 drivers/net/ethernet/marvell/mvneta_bm.c           |    2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   41 +-
 .../net/ethernet/marvell/octeon_ep/octep_ethtool.c |   31 +-
 .../marvell/octeon_ep_vf/octep_vf_ethtool.c        |   31 +-
 drivers/net/ethernet/marvell/octeontx2/Kconfig     |    8 +
 drivers/net/ethernet/marvell/octeontx2/af/Makefile |    3 +-
 drivers/net/ethernet/marvell/octeontx2/af/common.h |    1 +
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |   75 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   38 +-
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |   41 +-
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |   35 +
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   49 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  132 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |   50 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_reg.h    |    1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_rep.c    |  468 ++
 .../net/ethernet/marvell/octeontx2/af/rvu_struct.h |   26 +
 .../net/ethernet/marvell/octeontx2/af/rvu_switch.c |   20 +-
 .../net/ethernet/marvell/octeontx2/nic/Makefile    |    2 +
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c |    9 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h |    2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   62 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   90 +-
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c    |    5 +
 .../ethernet/marvell/octeontx2/nic/otx2_devlink.c  |   49 +
 .../ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c |    9 +
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |   88 +-
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |   15 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  303 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |   25 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |   31 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.h |    3 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |   19 +-
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c   |  864 ++++
 drivers/net/ethernet/marvell/octeontx2/nic/rep.h   |   54 +
 drivers/net/ethernet/marvell/pxa168_eth.c          |    2 +-
 drivers/net/ethernet/marvell/skge.c                |    3 +-
 drivers/net/ethernet/marvell/sky2.c                |    3 +-
 drivers/net/ethernet/mediatek/airoha_eth.c         |  141 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   12 +-
 drivers/net/ethernet/mellanox/mlx4/en_cq.c         |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |   63 +-
 drivers/net/ethernet/mellanox/mlx5/core/cq.c       |   11 +
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c     |   81 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |    7 +-
 .../ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |    2 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |    3 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   96 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  127 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c  |   10 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |   36 +-
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |    4 +-
 .../mellanox/mlx5/core/esw/diag/qos_tracepoint.h   |   86 +-
 .../net/ethernet/mellanox/mlx5/core/esw/legacy.c   |   33 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  | 1072 +++--
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h  |   13 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   30 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   34 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   30 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |    7 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |    6 +-
 .../net/ethernet/mellanox/mlx5/core/fs_counters.c  |  387 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |    9 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h   |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/smfs.h |    4 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/qos.c      |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/rl.c       |   58 +
 .../steering/hws/{mlx5hws_action.c => action.c}    |    2 +-
 .../steering/hws/{mlx5hws_action.h => action.h}    |    6 +-
 .../core/steering/hws/{mlx5hws_buddy.c => buddy.c} |    4 +-
 .../core/steering/hws/{mlx5hws_buddy.h => buddy.h} |    6 +-
 .../core/steering/hws/{mlx5hws_bwc.c => bwc.c}     |    2 +-
 .../core/steering/hws/{mlx5hws_bwc.h => bwc.h}     |    6 +-
 .../hws/{mlx5hws_bwc_complex.c => bwc_complex.c}   |    2 +-
 .../hws/{mlx5hws_bwc_complex.h => bwc_complex.h}   |    6 +-
 .../core/steering/hws/{mlx5hws_cmd.c => cmd.c}     |    2 +-
 .../core/steering/hws/{mlx5hws_cmd.h => cmd.h}     |    6 +-
 .../steering/hws/{mlx5hws_context.c => context.c}  |    2 +-
 .../steering/hws/{mlx5hws_context.h => context.h}  |    6 +-
 .../core/steering/hws/{mlx5hws_debug.c => debug.c} |    2 +-
 .../core/steering/hws/{mlx5hws_debug.h => debug.h} |    6 +-
 .../steering/hws/{mlx5hws_definer.c => definer.c}  |    2 +-
 .../steering/hws/{mlx5hws_definer.h => definer.h}  |    6 +-
 .../hws/{mlx5hws_internal.h => internal.h}         |   36 +-
 .../steering/hws/{mlx5hws_matcher.c => matcher.c}  |    2 +-
 .../steering/hws/{mlx5hws_matcher.h => matcher.h}  |    6 +-
 .../steering/hws/{mlx5hws_pat_arg.c => pat_arg.c}  |    2 +-
 .../steering/hws/{mlx5hws_pat_arg.h => pat_arg.h}  |    0
 .../core/steering/hws/{mlx5hws_pool.c => pool.c}   |    4 +-
 .../core/steering/hws/{mlx5hws_pool.h => pool.h}   |    0
 .../core/steering/hws/{mlx5hws_prm.h => prm.h}     |    0
 .../core/steering/hws/{mlx5hws_rule.c => rule.c}   |    2 +-
 .../core/steering/hws/{mlx5hws_rule.h => rule.h}   |    0
 .../core/steering/hws/{mlx5hws_send.c => send.c}   |    2 +-
 .../core/steering/hws/{mlx5hws_send.h => send.h}   |    0
 .../core/steering/hws/{mlx5hws_table.c => table.c} |    2 +-
 .../core/steering/hws/{mlx5hws_table.h => table.h} |    0
 .../core/steering/hws/{mlx5hws_vport.c => vport.c} |    2 +-
 .../core/steering/hws/{mlx5hws_vport.h => vport.h} |    0
 .../mlx5/core/steering/{ => sws}/dr_action.c       |    0
 .../mellanox/mlx5/core/steering/{ => sws}/dr_arg.c |    0
 .../mlx5/core/steering/{ => sws}/dr_buddy.c        |    0
 .../mellanox/mlx5/core/steering/{ => sws}/dr_cmd.c |    0
 .../mellanox/mlx5/core/steering/{ => sws}/dr_dbg.c |    0
 .../mellanox/mlx5/core/steering/{ => sws}/dr_dbg.h |    0
 .../mlx5/core/steering/{ => sws}/dr_definer.c      |    0
 .../mlx5/core/steering/{ => sws}/dr_domain.c       |    0
 .../mellanox/mlx5/core/steering/{ => sws}/dr_fw.c  |    0
 .../mlx5/core/steering/{ => sws}/dr_icm_pool.c     |    0
 .../mlx5/core/steering/{ => sws}/dr_matcher.c      |    0
 .../mlx5/core/steering/{ => sws}/dr_ptrn.c         |    0
 .../mlx5/core/steering/{ => sws}/dr_rule.c         |    0
 .../mlx5/core/steering/{ => sws}/dr_send.c         |    0
 .../mellanox/mlx5/core/steering/{ => sws}/dr_ste.c |    0
 .../mellanox/mlx5/core/steering/{ => sws}/dr_ste.h |    0
 .../mlx5/core/steering/{ => sws}/dr_ste_v0.c       |    0
 .../mlx5/core/steering/{ => sws}/dr_ste_v1.c       |    0
 .../mlx5/core/steering/{ => sws}/dr_ste_v1.h       |    0
 .../mlx5/core/steering/{ => sws}/dr_ste_v2.c       |    0
 .../mlx5/core/steering/{ => sws}/dr_table.c        |    0
 .../mlx5/core/steering/{ => sws}/dr_types.h        |    0
 .../mellanox/mlx5/core/steering/{ => sws}/fs_dr.c  |   35 +-
 .../mellanox/mlx5/core/steering/{ => sws}/fs_dr.h  |    0
 .../mlx5/core/steering/{ => sws}/mlx5_ifc_dr.h     |    0
 .../core/steering/{ => sws}/mlx5_ifc_dr_ste_v1.h   |    0
 .../mellanox/mlx5/core/steering/{ => sws}/mlx5dr.h |    0
 drivers/net/ethernet/mellanox/mlx5/core/wq.h       |    2 +-
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |    2 +-
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.c   |    6 +-
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.h   |    2 +-
 .../mellanox/mlxsw/spectrum_acl_flex_keys.c        |   66 +-
 drivers/net/ethernet/meta/Kconfig                  |    1 +
 drivers/net/ethernet/meta/fbnic/Makefile           |    8 +-
 drivers/net/ethernet/meta/fbnic/fbnic.h            |   26 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.c        |  148 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h        |  122 +
 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c    |   68 +
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c    |  145 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h         |    7 +
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c   |  193 +
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h   |   28 +
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c      |   81 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c        |   22 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h        |    7 +
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |   92 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h     |   18 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |   30 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c        |  141 +
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h        |    4 +
 drivers/net/ethernet/meta/fbnic/fbnic_time.c       |  303 ++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c       |  168 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h       |    3 +
 drivers/net/ethernet/micrel/ks8842.c               |    2 +-
 drivers/net/ethernet/micrel/ks8851_common.c        |   20 +-
 drivers/net/ethernet/micrel/ks8851_par.c           |    2 +-
 drivers/net/ethernet/microchip/Kconfig             |    1 +
 drivers/net/ethernet/microchip/Makefile            |    1 +
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |    2 +-
 drivers/net/ethernet/microchip/lan969x/Kconfig     |    5 +
 drivers/net/ethernet/microchip/lan969x/Makefile    |   13 +
 drivers/net/ethernet/microchip/lan969x/lan969x.c   |  353 ++
 drivers/net/ethernet/microchip/lan969x/lan969x.h   |   65 +
 .../ethernet/microchip/lan969x/lan969x_calendar.c  |  191 +
 .../net/ethernet/microchip/lan969x/lan969x_regs.c  |  222 +
 .../microchip/lan969x/lan969x_vcap_ag_api.c        | 3843 ++++++++++++++++
 .../ethernet/microchip/lan969x/lan969x_vcap_impl.c |   85 +
 drivers/net/ethernet/microchip/sparx5/Makefile     |    2 +-
 .../ethernet/microchip/sparx5/sparx5_calendar.c    |  128 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_dcb.c |    5 +-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |   34 +-
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    |   12 +-
 .../ethernet/microchip/sparx5/sparx5_mactable.c    |   10 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  307 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  208 +-
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 4603 +++++++++++---------
 .../net/ethernet/microchip/sparx5/sparx5_mirror.c  |   10 +-
 .../net/ethernet/microchip/sparx5/sparx5_netdev.c  |   39 +-
 .../net/ethernet/microchip/sparx5/sparx5_packet.c  |   24 +-
 .../net/ethernet/microchip/sparx5/sparx5_pgid.c    |   15 +-
 .../net/ethernet/microchip/sparx5/sparx5_police.c  |    3 +-
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |  122 +-
 .../net/ethernet/microchip/sparx5/sparx5_port.h    |   23 +-
 .../net/ethernet/microchip/sparx5/sparx5_psfp.c    |   49 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c |   59 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.c |   11 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.h |    2 +
 .../net/ethernet/microchip/sparx5/sparx5_regs.c    |  222 +
 .../net/ethernet/microchip/sparx5/sparx5_regs.h    |  247 ++
 .../net/ethernet/microchip/sparx5/sparx5_sdlb.c    |   25 +-
 .../ethernet/microchip/sparx5/sparx5_switchdev.c   |   33 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_tc.c  |    8 +-
 .../ethernet/microchip/sparx5/sparx5_tc_flower.c   |    9 +-
 .../ethernet/microchip/sparx5/sparx5_vcap_ag_api.h |    2 +
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.c   |   48 +-
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.h   |   21 +
 .../net/ethernet/microchip/sparx5/sparx5_vlan.c    |   47 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |   43 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  105 +-
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c |   66 +-
 drivers/net/ethernet/moxa/moxart_ether.c           |    2 +-
 drivers/net/ethernet/mscc/ocelot_flower.c          |   54 +-
 drivers/net/ethernet/mscc/ocelot_net.c             |    4 +-
 drivers/net/ethernet/mscc/ocelot_vsc7514.c         |    2 +-
 drivers/net/ethernet/natsemi/jazzsonic.c           |    2 +-
 drivers/net/ethernet/natsemi/macsonic.c            |    2 +-
 drivers/net/ethernet/natsemi/ns83820.c             |    2 +-
 drivers/net/ethernet/natsemi/xtsonic.c             |    2 +-
 drivers/net/ethernet/neterion/s2io.c               |    2 +-
 drivers/net/ethernet/netronome/nfp/nfd3/dp.c       |    4 +-
 drivers/net/ethernet/netronome/nfp/nfdk/dp.c       |    4 +-
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |    4 +-
 drivers/net/ethernet/ni/nixge.c                    |    2 +-
 drivers/net/ethernet/nxp/lpc_eth.c                 |    2 +-
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |    2 +-
 .../ethernet/qlogic/netxen/netxen_nic_ethtool.c    |   14 +-
 drivers/net/ethernet/qlogic/qed/qed_debug.c        |    1 +
 drivers/net/ethernet/qlogic/qed/qed_hw.c           |    1 +
 drivers/net/ethernet/qlogic/qed/qed_mcp.c          |   45 +-
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |   34 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c    |   60 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c   |    4 +-
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.c    |   22 +-
 drivers/net/ethernet/qualcomm/emac/emac.c          |    2 +-
 drivers/net/ethernet/qualcomm/qca_debug.c          |    4 +-
 drivers/net/ethernet/qualcomm/qca_spi.c            |   30 +-
 drivers/net/ethernet/qualcomm/qca_spi.h            |    2 +-
 drivers/net/ethernet/realtek/r8169.h               |    1 +
 drivers/net/ethernet/realtek/r8169_firmware.c      |    6 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  436 +-
 drivers/net/ethernet/realtek/r8169_phy_config.c    |   36 +-
 drivers/net/ethernet/realtek/rtase/rtase.h         |    2 +-
 drivers/net/ethernet/realtek/rtase/rtase_main.c    |   10 +-
 drivers/net/ethernet/renesas/ravb.h                |    6 +
 drivers/net/ethernet/renesas/ravb_main.c           |  103 +-
 drivers/net/ethernet/renesas/rswitch.c             |    2 +-
 drivers/net/ethernet/renesas/sh_eth.c              |    2 +-
 drivers/net/ethernet/rocker/rocker_main.c          |    2 +-
 .../net/ethernet/samsung/sxgbe/sxgbe_platform.c    |    2 +-
 drivers/net/ethernet/seeq/sgiseeq.c                |    2 +-
 drivers/net/ethernet/sfc/ef10.c                    |    2 +-
 drivers/net/ethernet/sfc/ef100_ethtool.c           |    1 +
 drivers/net/ethernet/sfc/ef100_nic.c               |    2 +-
 drivers/net/ethernet/sfc/ef100_rx.c                |    5 +-
 drivers/net/ethernet/sfc/efx.c                     |  117 +-
 drivers/net/ethernet/sfc/efx.h                     |    1 -
 drivers/net/ethernet/sfc/efx_channels.c            |    6 +
 drivers/net/ethernet/sfc/efx_channels.h            |    7 +
 drivers/net/ethernet/sfc/efx_common.c              |   16 -
 drivers/net/ethernet/sfc/efx_common.h              |    1 -
 drivers/net/ethernet/sfc/ethtool.c                 |    1 +
 drivers/net/ethernet/sfc/ethtool_common.c          |   49 +-
 drivers/net/ethernet/sfc/falcon/efx.c              |    8 -
 drivers/net/ethernet/sfc/falcon/efx.h              |    1 -
 drivers/net/ethernet/sfc/falcon/ethtool.c          |   34 +-
 drivers/net/ethernet/sfc/falcon/falcon.c           |    2 +-
 drivers/net/ethernet/sfc/falcon/farch.c            |   22 -
 drivers/net/ethernet/sfc/falcon/net_driver.h       |    2 +-
 drivers/net/ethernet/sfc/falcon/nic.c              |   20 +-
 drivers/net/ethernet/sfc/falcon/nic.h              |    7 +-
 drivers/net/ethernet/sfc/falcon/tx.c               |    8 -
 drivers/net/ethernet/sfc/falcon/tx.h               |    3 -
 drivers/net/ethernet/sfc/mae.c                     |   11 -
 drivers/net/ethernet/sfc/mae.h                     |    1 -
 drivers/net/ethernet/sfc/mcdi.c                    |   76 -
 drivers/net/ethernet/sfc/mcdi.h                    |   10 -
 drivers/net/ethernet/sfc/net_driver.h              |   49 +-
 drivers/net/ethernet/sfc/nic.c                     |    9 +-
 drivers/net/ethernet/sfc/nic_common.h              |    2 +-
 drivers/net/ethernet/sfc/ptp.c                     |    7 +-
 drivers/net/ethernet/sfc/ptp.h                     |    3 +-
 drivers/net/ethernet/sfc/rx.c                      |    5 +-
 drivers/net/ethernet/sfc/rx_common.c               |    3 +
 drivers/net/ethernet/sfc/siena/ethtool_common.c    |   46 +-
 drivers/net/ethernet/sfc/siena/net_driver.h        |    2 +-
 drivers/net/ethernet/sfc/siena/nic.c               |   14 +-
 drivers/net/ethernet/sfc/siena/nic_common.h        |    5 +-
 drivers/net/ethernet/sfc/siena/ptp.c               |    2 +-
 drivers/net/ethernet/sfc/siena/ptp.h               |    2 +-
 drivers/net/ethernet/sfc/siena/siena.c             |    2 +-
 drivers/net/ethernet/sfc/tx.c                      |   14 +-
 drivers/net/ethernet/sfc/tx.h                      |    3 -
 drivers/net/ethernet/sfc/tx_common.c               |   33 +-
 drivers/net/ethernet/sfc/tx_common.h               |    4 +-
 drivers/net/ethernet/sgi/ioc3-eth.c                |    2 +-
 drivers/net/ethernet/sgi/meth.c                    |    2 +-
 drivers/net/ethernet/smsc/smc91x.c                 |    2 +-
 drivers/net/ethernet/smsc/smsc911x.c               |    2 +-
 drivers/net/ethernet/socionext/netsec.c            |    2 +-
 drivers/net/ethernet/socionext/sni_ave.c           |    2 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   10 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    3 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |    4 +
 .../net/ethernet/stmicro/stmmac/dwmac-anarion.c    |    2 +-
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-generic.c    |    1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ingenic.c    |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-intel-plat.c |   55 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ipq806x.c    |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c    |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c  |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c   |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |    3 +-
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c  |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c  |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  |  273 ++
 .../net/ethernet/stmicro/stmmac/dwmac-visconti.c   |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h    |   12 +
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |  101 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |   10 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   11 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |    2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |    9 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |    6 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c       |  150 -
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h       |   26 -
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |    6 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |   31 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.c         |   22 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   20 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   11 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |    8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c   |  413 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h   |   33 +
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |   26 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  165 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |    7 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |   38 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h   |   10 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |    4 +-
 drivers/net/ethernet/sun/niu.c                     |    2 +-
 drivers/net/ethernet/sun/sunbmac.c                 |    2 +-
 drivers/net/ethernet/sun/sunqe.c                   |    2 +-
 drivers/net/ethernet/sunplus/spl2sw_driver.c       |    2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  198 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.h           |    9 -
 drivers/net/ethernet/ti/cpsw.c                     |    2 +-
 drivers/net/ethernet/ti/cpsw_ale.c                 |   66 +-
 drivers/net/ethernet/ti/cpsw_new.c                 |    2 +-
 drivers/net/ethernet/ti/davinci_emac.c             |    2 +-
 drivers/net/ethernet/ti/davinci_mdio.c             |    2 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |   47 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c   |    2 +-
 drivers/net/ethernet/ti/netcp_core.c               |    2 +-
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.c  |    1 -
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.h  |    1 -
 drivers/net/ethernet/tundra/tsi108_eth.c           |    2 +-
 drivers/net/ethernet/via/via-rhine.c               |    2 +-
 drivers/net/ethernet/via/via-velocity.c            |    2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c     |   24 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |    1 -
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |  188 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h     |    2 -
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h    |    9 +-
 drivers/net/ethernet/wiznet/w5100.c                |    2 +-
 drivers/net/ethernet/wiznet/w5300.c                |    2 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c        |    2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |    2 +-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c      |   23 +-
 drivers/net/ethernet/xscale/ixp4xx_eth.c           |    2 +-
 drivers/net/fjes/fjes_ethtool.c                    |   64 +-
 drivers/net/fjes/fjes_main.c                       |    2 +-
 drivers/net/geneve.c                               |    4 +-
 drivers/net/gtp.c                                  |   16 +-
 drivers/net/hyperv/netvsc.c                        |   13 +-
 drivers/net/hyperv/netvsc_drv.c                    |    2 +-
 drivers/net/hyperv/rndis_filter.c                  |    9 +-
 drivers/net/ieee802154/fakelb.c                    |    2 +-
 drivers/net/ieee802154/mac802154_hwsim.c           |    2 +-
 drivers/net/ifb.c                                  |   17 +-
 drivers/net/ipa/ipa_main.c                         |    2 +-
 drivers/net/ipvlan/ipvlan_core.c                   |    3 +-
 drivers/net/ipvlan/ipvlan_l3s.c                    |    6 +-
 drivers/net/macsec.c                               |   70 +-
 drivers/net/macvlan.c                              |    6 +-
 drivers/net/mctp/mctp-i2c.c                        |    3 +-
 drivers/net/mctp/mctp-i3c.c                        |    2 +-
 drivers/net/mctp/mctp-serial.c                     |    5 +-
 drivers/net/mdio.c                                 |  172 -
 drivers/net/mdio/mdio-aspeed.c                     |    2 +-
 drivers/net/mdio/mdio-bcm-iproc.c                  |    2 +-
 drivers/net/mdio/mdio-bcm-unimac.c                 |    2 +-
 drivers/net/mdio/mdio-gpio.c                       |    2 +-
 drivers/net/mdio/mdio-hisi-femac.c                 |    2 +-
 drivers/net/mdio/mdio-ipq4019.c                    |    2 +-
 drivers/net/mdio/mdio-ipq8064.c                    |    2 +-
 drivers/net/mdio/mdio-moxart.c                     |    2 +-
 drivers/net/mdio/mdio-mscc-miim.c                  |    2 +-
 drivers/net/mdio/mdio-mux-bcm-iproc.c              |    2 +-
 drivers/net/mdio/mdio-mux-bcm6368.c                |    2 +-
 drivers/net/mdio/mdio-mux-gpio.c                   |    2 +-
 drivers/net/mdio/mdio-mux-meson-g12a.c             |    2 +-
 drivers/net/mdio/mdio-mux-meson-gxl.c              |    2 +-
 drivers/net/mdio/mdio-mux-mmioreg.c                |    2 +-
 drivers/net/mdio/mdio-mux-multiplexer.c            |    2 +-
 drivers/net/mdio/mdio-octeon.c                     |    2 +-
 drivers/net/mdio/mdio-sun4i.c                      |    2 +-
 drivers/net/mdio/mdio-thunder.c                    |    4 +-
 drivers/net/mdio/mdio-xgene.c                      |    2 +-
 drivers/net/netconsole.c                           |  197 +-
 drivers/net/netdevsim/ethtool.c                    |    2 +
 drivers/net/netdevsim/ipsec.c                      |   23 +-
 drivers/net/netdevsim/macsec.c                     |   56 +-
 drivers/net/netdevsim/netdev.c                     |   45 +-
 drivers/net/netkit.c                               |  102 +-
 drivers/net/pcs/pcs-rzn1-miic.c                    |    2 +-
 drivers/net/pcs/pcs-xpcs-nxp.c                     |   24 +-
 drivers/net/pcs/pcs-xpcs-wx.c                      |   56 +-
 drivers/net/pcs/pcs-xpcs.c                         |  641 ++-
 drivers/net/pcs/pcs-xpcs.h                         |   38 +-
 drivers/net/phy/Kconfig                            |   21 +-
 drivers/net/phy/Makefile                           |    3 +-
 drivers/net/phy/adin.c                             |    6 +-
 drivers/net/phy/aquantia/aquantia.h                |    1 +
 drivers/net/phy/aquantia/aquantia_leds.c           |   19 +-
 drivers/net/phy/aquantia/aquantia_main.c           |  116 +-
 drivers/net/phy/bcm-phy-lib.c                      |    5 +-
 drivers/net/phy/dp83822.c                          |   31 +-
 drivers/net/phy/dp83869.c                          |   20 +-
 drivers/net/phy/icplus.c                           |    3 +-
 drivers/net/phy/intel-xway.c                       |  253 +-
 drivers/net/phy/marvell-88q2xxx.c                  |  124 +-
 drivers/net/phy/marvell.c                          |   26 +-
 drivers/net/phy/mediatek/Kconfig                   |   27 +
 drivers/net/phy/mediatek/Makefile                  |    4 +
 .../{mediatek-ge-soc.c => mediatek/mtk-ge-soc.c}   |  419 +-
 .../net/phy/{mediatek-ge.c => mediatek/mtk-ge.c}   |   31 +-
 drivers/net/phy/mediatek/mtk-phy-lib.c             |  270 ++
 drivers/net/phy/mediatek/mtk.h                     |   89 +
 drivers/net/phy/micrel.c                           |    8 +-
 drivers/net/phy/microchip_t1.c                     |  233 +
 drivers/net/phy/microchip_t1s.c                    |  300 +-
 drivers/net/phy/mscc/mscc_main.c                   |    3 +-
 drivers/net/phy/mxl-gpy.c                          |  227 +
 drivers/net/phy/nxp-c45-tja11xx.c                  |   36 +-
 drivers/net/phy/nxp-c45-tja11xx.h                  |    1 +
 drivers/net/phy/nxp-cbtx.c                         |    2 +-
 drivers/net/phy/phy-c45.c                          |   34 +-
 drivers/net/phy/phy-core.c                         |   52 +-
 drivers/net/phy/phy_device.c                       |   47 +-
 drivers/net/phy/phylink.c                          |  235 +-
 drivers/net/phy/qcom/qca83xx.c                     |    6 +-
 drivers/net/phy/realtek.c                          |  121 +-
 drivers/net/phy/sfp.c                              |    5 +-
 drivers/net/phy/smsc.c                             |    5 +-
 drivers/net/team/team_core.c                       |    3 +-
 drivers/net/tun.c                                  |    2 +-
 drivers/net/usb/sr9700.c                           |   10 +-
 drivers/net/veth.c                                 |   18 +-
 drivers/net/virtio_net.c                           |  458 +-
 drivers/net/vmxnet3/vmxnet3_drv.c                  |    8 +
 drivers/net/vrf.c                                  |    2 +-
 drivers/net/vxlan/vxlan_core.c                     |  127 +-
 drivers/net/vxlan/vxlan_mdb.c                      |    4 +-
 drivers/net/wan/framer/pef2256/pef2256.c           |    2 +-
 drivers/net/wan/fsl_qmc_hdlc.c                     |    2 +-
 drivers/net/wan/fsl_ucc_hdlc.c                     |    2 +-
 drivers/net/wan/ixp4xx_hss.c                       |    2 +-
 drivers/net/wireguard/device.c                     |    3 +-
 drivers/net/wireguard/selftest/allowedips.c        |    1 -
 drivers/net/wireless/ath/ath10k/ahb.c              |    8 +-
 drivers/net/wireless/ath/ath10k/mac.c              |  105 +-
 drivers/net/wireless/ath/ath10k/sdio.c             |    6 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |    6 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |   20 +-
 drivers/net/wireless/ath/ath11k/core.c             |    2 +-
 drivers/net/wireless/ath/ath11k/hal.c              |    1 +
 drivers/net/wireless/ath/ath11k/mac.c              |    5 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |    3 +
 drivers/net/wireless/ath/ath11k/wow.c              |   39 +-
 drivers/net/wireless/ath/ath12k/Kconfig            |   10 +
 drivers/net/wireless/ath/ath12k/Makefile           |    1 +
 drivers/net/wireless/ath/ath12k/ce.h               |    2 +-
 drivers/net/wireless/ath/ath12k/core.c             |    9 +-
 drivers/net/wireless/ath/ath12k/core.h             |  110 +-
 drivers/net/wireless/ath/ath12k/coredump.c         |   51 +
 drivers/net/wireless/ath/ath12k/coredump.h         |   80 +
 drivers/net/wireless/ath/ath12k/debugfs.c          |    4 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    | 1358 +++++-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |  444 +-
 drivers/net/wireless/ath/ath12k/dp.c               |   58 +-
 drivers/net/wireless/ath/ath12k/dp.h               |    7 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |  122 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   16 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |    2 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |    9 +-
 drivers/net/wireless/ath/ath12k/dp_tx.h            |    2 +-
 drivers/net/wireless/ath/ath12k/hal.c              |   12 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h           |   53 +-
 drivers/net/wireless/ath/ath12k/hif.h              |    6 +
 drivers/net/wireless/ath/ath12k/hw.c               |    4 +-
 drivers/net/wireless/ath/ath12k/mac.c              | 1850 +++++---
 drivers/net/wireless/ath/ath12k/mac.h              |   11 +-
 drivers/net/wireless/ath/ath12k/mhi.c              |    5 +
 drivers/net/wireless/ath/ath12k/mhi.h              |    2 +-
 drivers/net/wireless/ath/ath12k/p2p.c              |   17 +-
 drivers/net/wireless/ath/ath12k/p2p.h              |    2 +-
 drivers/net/wireless/ath/ath12k/pci.c              |  200 +-
 drivers/net/wireless/ath/ath12k/peer.c             |   13 +-
 drivers/net/wireless/ath/ath12k/peer.h             |    4 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h          |   88 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |   30 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |    8 +-
 drivers/net/wireless/ath/ath12k/wow.c              |   87 +-
 drivers/net/wireless/ath/ath5k/ahb.c               |    8 +-
 drivers/net/wireless/ath/ath5k/pci.c               |    2 +
 drivers/net/wireless/ath/ath6kl/wmi.h              |    8 +-
 drivers/net/wireless/ath/ath9k/ahb.c               |   10 +-
 drivers/net/wireless/ath/ath9k/ar9003_aic.c        |   10 +-
 .../net/wireless/ath/ath9k/ath9k_pci_owl_loader.c  |    1 -
 drivers/net/wireless/ath/ath9k/btcoex.c            |   16 +-
 drivers/net/wireless/ath/ath9k/eeprom.c            |   12 -
 drivers/net/wireless/ath/ath9k/htc_drv_main.c      |    6 +-
 drivers/net/wireless/ath/ath9k/htc_hst.c           |    3 +
 drivers/net/wireless/ath/ath9k/hw.c                |    2 +-
 drivers/net/wireless/ath/ath9k/init.c              |   52 +-
 drivers/net/wireless/ath/wcn36xx/main.c            |    8 +-
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h         |    2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        |    1 +
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |    6 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |    7 -
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         |    1 -
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |    5 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c  |   29 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.h  |    9 +-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |   55 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |   22 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |    3 +
 .../wireless/broadcom/brcm80211/brcmsmac/debug.c   |    5 -
 .../wireless/broadcom/brcm80211/brcmsmac/debug.h   |    1 -
 .../net/wireless/broadcom/brcm80211/brcmsmac/dma.c |    9 -
 .../net/wireless/broadcom/brcm80211/brcmsmac/dma.h |    1 -
 .../broadcom/brcm80211/include/brcm_hw_ids.h       |    2 +
 drivers/net/wireless/intel/ipw2x00/Kconfig         |   11 +-
 drivers/net/wireless/intel/ipw2x00/Makefile        |    7 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.c       |    9 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.h       |    2 -
 drivers/net/wireless/intel/ipw2x00/ipw2200.c       |   25 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.h       |    4 -
 drivers/net/wireless/intel/ipw2x00/libipw.h        |  114 +-
 drivers/net/wireless/intel/ipw2x00/libipw_crypto.c |  246 ++
 .../wireless/intel/ipw2x00/libipw_crypto_ccmp.c    |   76 +-
 .../wireless/intel/ipw2x00/libipw_crypto_tkip.c    |  106 +-
 .../net/wireless/intel/ipw2x00/libipw_crypto_wep.c |   73 +-
 drivers/net/wireless/intel/ipw2x00/libipw_module.c |   36 +-
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c     |   19 +-
 .../net/wireless/intel/ipw2x00/libipw_spy.c        |   63 +-
 drivers/net/wireless/intel/ipw2x00/libipw_tx.c     |    4 +-
 drivers/net/wireless/intel/ipw2x00/libipw_wx.c     |   43 +-
 drivers/net/wireless/intel/iwlegacy/3945.c         |    2 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |    4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |    4 +-
 .../net/wireless/intel/iwlwifi/fw/api/binding.h    |    2 -
 .../net/wireless/intel/iwlwifi/fw/api/context.h    |    3 +
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |   69 +-
 .../net/wireless/intel/iwlwifi/fw/api/location.h   |   30 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |   32 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h    |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |    9 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |   27 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c      |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  179 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   |   66 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |    6 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-responder.c |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |   15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   25 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   63 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c   |    2 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |   89 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |   30 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   21 +-
 .../net/wireless/intel/iwlwifi/mvm/offloading.c    |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c     |   13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |   10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |    3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   57 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c      |   14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |    6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |    2 +
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |    4 +
 drivers/net/wireless/intersil/p54/p54spi.c         |    4 +-
 drivers/net/wireless/marvell/libertas/Kconfig      |    1 -
 drivers/net/wireless/marvell/libertas/cfg.c        |    1 +
 drivers/net/wireless/marvell/libertas/mesh.h       |    1 -
 drivers/net/wireless/marvell/mwifiex/cmdevt.c      |    2 +
 drivers/net/wireless/marvell/mwifiex/fw.h          |    2 +-
 drivers/net/wireless/marvell/mwifiex/ioctl.h       |    2 +-
 drivers/net/wireless/marvell/mwifiex/join.c        |   11 +-
 drivers/net/wireless/marvell/mwifiex/main.c        |    4 +-
 drivers/net/wireless/marvell/mwifiex/main.h        |    4 -
 drivers/net/wireless/marvell/mwifiex/sta_event.c   |    6 +-
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c   |    2 -
 drivers/net/wireless/marvell/mwifiex/tdls.c        |    2 -
 drivers/net/wireless/marvell/mwifiex/util.c        |    2 +
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/soc.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |    5 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  113 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.h |    2 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   |   37 +-
 drivers/net/wireless/microchip/wilc1000/sdio.c     |   99 +-
 drivers/net/wireless/microchip/wilc1000/spi.c      |    8 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |  444 +-
 drivers/net/wireless/microchip/wilc1000/wlan.h     |   53 +-
 drivers/net/wireless/quantenna/qtnfmac/commands.c  |    2 +-
 drivers/net/wireless/quantenna/qtnfmac/core.h      |    1 -
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |    2 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |    6 +-
 .../realtek/rtlwifi/btcoexist/halbtc8723b1ant.c    |   11 -
 .../realtek/rtlwifi/btcoexist/halbtc8723b1ant.h    |    1 -
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.c       |   79 -
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.h       |   10 -
 drivers/net/wireless/realtek/rtlwifi/efuse.c       |   11 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/sw.c    |    3 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/hw.c    |   18 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/sw.c    |    3 +
 drivers/net/wireless/realtek/rtw88/Kconfig         |   33 +
 drivers/net/wireless/realtek/rtw88/Makefile        |   15 +
 drivers/net/wireless/realtek/rtw88/coex.c          |   37 +-
 drivers/net/wireless/realtek/rtw88/coex.h          |   11 +
 drivers/net/wireless/realtek/rtw88/debug.c         |    2 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |   46 +-
 drivers/net/wireless/realtek/rtw88/fw.h            |   17 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |   15 +-
 drivers/net/wireless/realtek/rtw88/mac.h           |    3 +
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    6 +-
 drivers/net/wireless/realtek/rtw88/main.c          |   35 +-
 drivers/net/wireless/realtek/rtw88/main.h          |   52 +-
 drivers/net/wireless/realtek/rtw88/pci.c           |    4 +-
 drivers/net/wireless/realtek/rtw88/phy.c           |   82 +-
 drivers/net/wireless/realtek/rtw88/reg.h           |  174 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |   83 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |   70 +-
 drivers/net/wireless/realtek/rtw88/rtw8723x.c      |    3 +-
 drivers/net/wireless/realtek/rtw88/rtw8812a.c      | 1102 +++++
 drivers/net/wireless/realtek/rtw88/rtw8812a.h      |   10 +
 .../net/wireless/realtek/rtw88/rtw8812a_table.c    | 2812 ++++++++++++
 .../net/wireless/realtek/rtw88/rtw8812a_table.h    |   26 +
 drivers/net/wireless/realtek/rtw88/rtw8812au.c     |   28 +
 drivers/net/wireless/realtek/rtw88/rtw8821a.c      | 1197 +++++
 drivers/net/wireless/realtek/rtw88/rtw8821a.h      |   10 +
 .../net/wireless/realtek/rtw88/rtw8821a_table.c    | 2350 ++++++++++
 .../net/wireless/realtek/rtw88/rtw8821a_table.h    |   21 +
 drivers/net/wireless/realtek/rtw88/rtw8821au.c     |   28 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |   87 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.h      |   24 -
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |   73 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.h      |   12 -
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |   82 +-
 drivers/net/wireless/realtek/rtw88/rtw88xxa.c      | 1989 +++++++++
 drivers/net/wireless/realtek/rtw88/rtw88xxa.h      |  175 +
 drivers/net/wireless/realtek/rtw88/rx.c            |   82 +-
 drivers/net/wireless/realtek/rtw88/rx.h            |   64 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |   11 +-
 drivers/net/wireless/realtek/rtw88/tx.c            |    6 +-
 drivers/net/wireless/realtek/rtw88/tx.h            |    4 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |   14 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |  310 +-
 drivers/net/wireless/realtek/rtw89/cam.h           |   48 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |  384 +-
 drivers/net/wireless/realtek/rtw89/chan.h          |   23 +-
 drivers/net/wireless/realtek/rtw89/coex.c          |  391 +-
 drivers/net/wireless/realtek/rtw89/coex.h          |    6 +-
 drivers/net/wireless/realtek/rtw89/core.c          | 1091 +++--
 drivers/net/wireless/realtek/rtw89/core.h          |  512 ++-
 drivers/net/wireless/realtek/rtw89/debug.c         |  144 +-
 drivers/net/wireless/realtek/rtw89/efuse.c         |  150 +
 drivers/net/wireless/realtek/rtw89/efuse.h         |    2 +
 drivers/net/wireless/realtek/rtw89/efuse_be.c      |   52 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  896 ++--
 drivers/net/wireless/realtek/rtw89/fw.h            |  284 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |  761 ++--
 drivers/net/wireless/realtek/rtw89/mac.h           |  128 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  663 ++-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |   73 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |  105 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |   39 +
 drivers/net/wireless/realtek/rtw89/pci_be.c        |   77 +
 drivers/net/wireless/realtek/rtw89/phy.c           |  702 ++-
 drivers/net/wireless/realtek/rtw89/phy.h           |   13 +-
 drivers/net/wireless/realtek/rtw89/phy_be.c        |   12 +-
 drivers/net/wireless/realtek/rtw89/ps.c            |  109 +-
 drivers/net/wireless/realtek/rtw89/ps.h            |   14 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |    2 +
 drivers/net/wireless/realtek/rtw89/regd.c          |  111 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   18 +-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   18 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |    8 +-
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |   18 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c    |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   17 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |    8 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |  121 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |   61 +-
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |    8 +
 drivers/net/wireless/realtek/rtw89/sar.c           |    6 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |   37 +-
 drivers/net/wireless/realtek/rtw89/wow.c           |  217 +-
 drivers/net/wireless/realtek/rtw89/wow.h           |   10 +-
 drivers/net/wireless/silabs/wfx/main.c             |   17 +-
 drivers/net/wireless/st/cw1200/cw1200_spi.c        |    2 +-
 drivers/net/wireless/st/cw1200/queue.c             |   27 -
 drivers/net/wireless/st/cw1200/queue.h             |    1 -
 drivers/net/wireless/ti/wl1251/sdio.c              |    4 +-
 drivers/net/wireless/ti/wl12xx/main.c              |    2 +-
 drivers/net/wireless/ti/wl18xx/main.c              |    4 +-
 drivers/net/wireless/ti/wlcore/main.c              |    5 +-
 drivers/net/wireless/ti/wlcore/sdio.c              |   13 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   12 +-
 drivers/net/wwan/qcom_bam_dmux.c                   |    2 +-
 drivers/net/wwan/t7xx/t7xx_modem_ops.c             |    1 +
 drivers/net/wwan/t7xx/t7xx_pci.c                   |   60 +-
 drivers/net/wwan/t7xx/t7xx_pci.h                   |    1 +
 drivers/net/wwan/t7xx/t7xx_port.h                  |    3 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.c            |   51 +-
 drivers/net/wwan/t7xx/t7xx_port_proxy.h            |    1 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c             |    8 +-
 drivers/net/wwan/wwan_core.c                       |   10 +-
 drivers/ptp/Kconfig                                |   28 +
 drivers/ptp/Makefile                               |    2 +
 drivers/ptp/ptp_fc3.c                              |    5 -
 drivers/ptp/ptp_pch.c                              |    6 +-
 drivers/ptp/ptp_s390.c                             |  129 +
 drivers/ptp/ptp_vmclock.c                          |  615 +++
 drivers/soc/fsl/dpio/dpio-service.c                |    2 +-
 drivers/staging/Kconfig                            |    2 -
 drivers/staging/Makefile                           |    1 -
 drivers/staging/rtl8192e/Kconfig                   |   61 -
 drivers/staging/rtl8192e/Makefile                  |   19 -
 drivers/staging/rtl8192e/TODO                      |   18 -
 drivers/staging/rtl8192e/rtl8192e/Kconfig          |   10 -
 drivers/staging/rtl8192e/rtl8192e/Makefile         |   19 -
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h     |  266 --
 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c |  198 -
 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.h |   17 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c  |   79 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.h  |   12 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     | 1915 --------
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h     |   34 -
 .../staging/rtl8192e/rtl8192e/r8192E_firmware.c    |  189 -
 .../staging/rtl8192e/rtl8192e/r8192E_firmware.h    |   52 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h      |  244 --
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c     | 1110 -----
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h     |   55 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h  |  773 ----
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c        |  123 -
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h        |   25 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       | 2016 ---------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h       |  402 --
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         | 1856 --------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h         |  155 -
 drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.c     |   84 -
 drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.h     |   12 -
 drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c    |   37 -
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c        |   79 -
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.h        |   20 -
 drivers/staging/rtl8192e/rtl8192e/rtl_pm.c         |   89 -
 drivers/staging/rtl8192e/rtl8192e/rtl_pm.h         |   16 -
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c         |  230 -
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.h         |   31 -
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c         |  867 ----
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.h         |   13 -
 drivers/staging/rtl8192e/rtl8192e/table.c          |  543 ---
 drivers/staging/rtl8192e/rtl8192e/table.h          |   27 -
 drivers/staging/rtl8192e/rtl819x_BA.h              |   60 -
 drivers/staging/rtl8192e/rtl819x_BAProc.c          |  544 ---
 drivers/staging/rtl8192e/rtl819x_HT.h              |  223 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c          |  699 ---
 drivers/staging/rtl8192e/rtl819x_Qos.h             |   43 -
 drivers/staging/rtl8192e/rtl819x_TS.h              |   50 -
 drivers/staging/rtl8192e/rtl819x_TSProc.c          |  450 --
 drivers/staging/rtl8192e/rtllib.h                  | 1799 --------
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c       |  411 --
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c       |  706 ---
 drivers/staging/rtl8192e/rtllib_crypt_wep.c        |  242 -
 drivers/staging/rtl8192e/rtllib_module.c           |  179 -
 drivers/staging/rtl8192e/rtllib_rx.c               | 2564 -----------
 drivers/staging/rtl8192e/rtllib_softmac.c          | 2309 ----------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c       |  534 ---
 drivers/staging/rtl8192e/rtllib_tx.c               |  901 ----
 drivers/staging/rtl8192e/rtllib_wx.c               |  752 ----
 drivers/staging/rtl8712/TODO                       |    1 -
 drivers/staging/rtl8723bs/TODO                     |    1 -
 drivers/staging/vt6655/TODO                        |    1 -
 drivers/staging/vt6656/TODO                        |    1 -
 drivers/vhost/net.c                                |    2 +-
 drivers/virtio/virtio_ring.c                       |  356 +-
 fs/debugfs/file.c                                  |  100 +-
 fs/debugfs/inode.c                                 |   63 +-
 fs/debugfs/internal.h                              |    6 +
 fs/eventpoll.c                                     |   36 +-
 include/linux/ath9k_platform.h                     |   51 -
 include/linux/avf/virtchnl.h                       |  120 +
 include/linux/bpf-cgroup.h                         |    2 +-
 include/linux/clocksource_ids.h                    |    1 +
 include/linux/compiler_types.h                     |    6 +
 include/linux/debugfs.h                            |   62 +-
 include/linux/dim.h                                |    5 +-
 include/linux/dpll.h                               |    4 +
 include/linux/dynamic_queue_limits.h               |    2 +-
 include/linux/ethtool.h                            |    4 +
 include/linux/fsl/netc_global.h                    |   19 +
 include/linux/gfp.h                                |   22 -
 include/linux/ieee80211.h                          |    2 +
 include/linux/if_ltalk.h                           |    8 -
 include/linux/inetdevice.h                         |   11 +-
 include/linux/mdio.h                               |   19 -
 include/linux/mlx5/driver.h                        |   33 +-
 include/linux/mlx5/fs.h                            |    3 -
 include/linux/mlx5/mlx5_ifc.h                      |   67 +-
 include/linux/mm_types.h                           |   18 -
 include/linux/mm_types_task.h                      |   21 +
 include/linux/netdevice.h                          |  100 +-
 include/linux/netlink.h                            |    5 +-
 include/linux/netpoll.h                            |    3 +-
 include/linux/packing.h                            |   32 +-
 include/linux/page_frag_cache.h                    |   61 +
 include/linux/pcs/pcs-xpcs.h                       |   31 +-
 include/linux/phy.h                                |   29 +-
 include/linux/platform_data/microchip-ksz.h        |    1 +
 include/linux/rtnetlink.h                          |   66 +-
 include/linux/skbuff.h                             |   65 +-
 include/linux/tcp.h                                |    3 +-
 include/linux/udp.h                                |   11 +
 include/linux/virtio.h                             |   13 +-
 include/linux/wireless.h                           |    5 +-
 include/linux/wwan.h                               |    4 +
 include/net/act_api.h                              |    1 -
 include/net/bluetooth/hci.h                        |   19 +-
 include/net/bluetooth/hci_core.h                   |   85 +-
 include/net/bluetooth/mgmt.h                       |   10 +
 include/net/busy_poll.h                            |    3 +
 include/net/caif/cfsrvl.h                          |    1 -
 include/net/cfg80211.h                             |   23 +-
 include/net/checksum.h                             |    6 +
 include/net/devlink.h                              |   13 -
 include/net/dropreason-core.h                      |   66 +
 include/net/dsa.h                                  |   15 -
 include/net/eee.h                                  |    5 +-
 include/net/fib_notifier.h                         |    2 +-
 include/net/fib_rules.h                            |    2 +-
 include/net/flow_offload.h                         |    1 +
 include/net/genetlink.h                            |    8 +-
 include/net/inet_connection_sock.h                 |    9 +-
 include/net/inet_sock.h                            |   12 +-
 include/net/ip.h                                   |   13 +-
 include/net/ip6_fib.h                              |    8 +-
 include/net/ip_fib.h                               |   19 +-
 include/net/ip_tunnels.h                           |   23 +-
 include/net/iw_handler.h                           |   41 +-
 include/net/l3mdev.h                               |    2 +-
 include/net/lib80211.h                             |  122 -
 include/net/mac80211.h                             |   80 +-
 include/net/mana/gdma.h                            |    6 +-
 include/net/mana/mana.h                            |   10 +-
 include/net/mctp.h                                 |   18 +
 include/net/mctpdevice.h                           |    4 +-
 include/net/neighbour.h                            |   27 +-
 include/net/neighbour_tables.h                     |   12 +
 include/net/net_debug.h                            |    4 +-
 include/net/net_namespace.h                        |    4 +
 include/net/net_shaper.h                           |  120 +
 include/net/netfilter/nf_tables.h                  |   28 +-
 include/net/netlabel.h                             |    1 +
 include/net/netlink.h                              |  263 ++
 include/net/netns/core.h                           |    1 +
 include/net/netns/ipv4.h                           |    9 +-
 include/net/netns/xfrm.h                           |    1 +
 include/net/nfc/nci.h                              |    2 +-
 include/net/nfc/nci_core.h                         |    4 +
 include/net/nfc/nfc.h                              |    4 +
 include/net/phonet/pn_dev.h                        |    8 +-
 include/net/pkt_cls.h                              |    1 +
 include/net/route.h                                |   43 +-
 include/net/rtnetlink.h                            |   34 +-
 include/net/sock.h                                 |   55 +-
 include/net/tcp.h                                  |   26 +-
 include/net/tcp_ao.h                               |    3 +-
 include/net/udp.h                                  |  137 +-
 include/net/xdp_sock_drv.h                         |   14 +-
 include/net/xfrm.h                                 |   17 +-
 include/net/xsk_buff_pool.h                        |   23 +-
 include/soc/fsl/qman.h                             |    2 +-
 include/trace/events/rxrpc.h                       |   25 +
 include/uapi/asm-generic/socket.h                  |    2 +
 include/uapi/linux/batadv_packet.h                 |   29 +-
 include/uapi/linux/dpll.h                          |   24 +
 include/uapi/linux/ethtool.h                       |    7 +
 include/uapi/linux/if_link.h                       |   17 +
 include/uapi/linux/net_shaper.h                    |   95 +
 include/uapi/linux/netdev.h                        |    4 +
 include/uapi/linux/netfilter/nf_tables.h           |   18 +-
 include/uapi/linux/nfc.h                           |    3 +
 include/uapi/linux/nl80211.h                       |   10 +
 include/uapi/linux/pkt_sched.h                     |    2 +
 include/uapi/linux/rtnetlink.h                     |    2 +-
 include/uapi/linux/udp.h                           |    2 +-
 include/uapi/linux/vmclock-abi.h                   |  182 +
 include/uapi/linux/xfrm.h                          |    2 +
 kernel/configs/debug.config                        |    1 +
 lib/Kconfig                                        |   12 +
 lib/Kconfig.debug                                  |   10 +
 lib/Makefile                                       |    1 +
 lib/checksum.c                                     |   11 +-
 lib/dim/dim.c                                      |    3 +-
 lib/dim/net_dim.c                                  |   10 +-
 lib/dynamic_queue_limits.c                         |    2 +-
 lib/packing.c                                      |  322 +-
 lib/packing_test.c                                 |  413 ++
 mm/Makefile                                        |    1 +
 mm/page_alloc.c                                    |  136 -
 mm/page_frag_cache.c                               |  171 +
 net/8021q/vlan_dev.c                               |    2 +-
 net/8021q/vlan_netlink.c                           |    6 +-
 net/Kconfig                                        |    3 +
 net/Kconfig.debug                                  |   15 +
 net/Makefile                                       |    1 +
 net/appletalk/Makefile                             |    2 +-
 net/appletalk/dev.c                                |   46 -
 net/batman-adv/bat_iv_ogm.c                        |    4 +-
 net/batman-adv/bridge_loop_avoidance.c             |    8 +-
 net/batman-adv/main.h                              |    2 +-
 net/batman-adv/translation-table.c                 |   96 +-
 net/bluetooth/hci_conn.c                           |  230 +-
 net/bluetooth/hci_core.c                           |   26 +-
 net/bluetooth/hci_event.c                          |   47 +-
 net/bluetooth/hci_sync.c                           |    9 +-
 net/bluetooth/hci_sysfs.c                          |   15 +-
 net/bluetooth/iso.c                                |  121 +-
 net/bluetooth/l2cap_sock.c                         |    1 +
 net/bluetooth/mgmt.c                               |   60 +
 net/bluetooth/rfcomm/sock.c                        |   20 +-
 net/bluetooth/sco.c                                |   99 +-
 net/bridge/br_device.c                             |    2 +-
 net/bridge/br_fdb.c                                |   45 +-
 net/bridge/br_netfilter_hooks.c                    |   15 +-
 net/bridge/br_netlink.c                            |    6 +-
 net/bridge/br_private.h                            |    4 +-
 net/bridge/netfilter/Kconfig                       |    8 +-
 net/bridge/netfilter/nft_meta_bridge.c             |    2 +-
 net/caif/cfsrvl.c                                  |    6 -
 net/can/af_can.c                                   |    1 +
 net/can/gw.c                                       |   29 +-
 net/can/raw.c                                      |    2 +-
 net/core/Makefile                                  |    2 +
 net/core/dev.c                                     |  143 +-
 net/core/dev.h                                     |  123 +
 net/core/dev_ioctl.c                               |    6 +-
 net/core/fib_notifier.c                            |    2 -
 net/core/fib_rules.c                               |   34 +-
 net/core/filter.c                                  |  152 +-
 net/core/lwt_bpf.c                                 |   11 +-
 net/core/neighbour.c                               |  360 +-
 net/core/net-sysfs.c                               |    4 +-
 net/core/net_namespace.c                           |   26 +-
 net/core/netdev-genl-gen.c                         |   23 +-
 net/core/netdev-genl-gen.h                         |    1 +
 net/core/netdev-genl.c                             |   75 +-
 net/core/netpoll.c                                 |   49 +-
 net/core/page_pool.c                               |    2 +-
 net/core/rtnetlink.c                               | 1029 +++--
 net/core/rtnl_net_debug.c                          |  125 +
 net/core/skb_fault_injection.c                     |  106 +
 net/core/skbuff.c                                  |    8 +-
 net/core/skmsg.c                                   |    4 +-
 net/core/sock.c                                    |   34 +-
 net/core/sysctl_net_core.c                         |   56 +-
 net/dcb/dcbnl.c                                    |    8 +-
 net/devlink/dev.c                                  |   18 +-
 net/devlink/devl_internal.h                        |    7 +-
 net/devlink/dpipe.c                                |   18 +-
 net/devlink/health.c                               |   25 +-
 net/devlink/rate.c                                 |    8 +-
 net/devlink/region.c                               |   15 +-
 net/devlink/resource.c                             |  101 +-
 net/devlink/trap.c                                 |   34 +-
 net/dsa/devlink.c                                  |   23 +-
 net/dsa/dsa.c                                      |    8 -
 net/dsa/port.c                                     |   40 -
 net/dsa/user.c                                     |   94 +-
 net/ethtool/cmis.h                                 |   16 +-
 net/ethtool/cmis_cdb.c                             |   94 +-
 net/ethtool/cmis_fw_update.c                       |  108 +-
 net/ethtool/common.c                               |   90 +-
 net/ethtool/common.h                               |    1 +
 net/ethtool/ioctl.c                                |   13 +
 net/ethtool/rss.c                                  |    2 +-
 net/hsr/hsr_device.c                               |   85 +-
 net/hsr/hsr_forward.c                              |   19 +-
 net/hsr/hsr_netlink.c                              |   11 +-
 net/ieee802154/nl-mac.c                            |   15 +-
 net/ieee802154/nl802154.c                          |   26 +-
 net/ieee802154/socket.c                            |   12 +-
 net/ipv4/af_inet.c                                 |   22 +-
 net/ipv4/arp.c                                     |    2 +-
 net/ipv4/devinet.c                                 |  281 +-
 net/ipv4/esp4_offload.c                            |    6 +-
 net/ipv4/fib_frontend.c                            |   44 +-
 net/ipv4/fib_notifier.c                            |   10 +-
 net/ipv4/fib_rules.c                               |    2 +-
 net/ipv4/fib_semantics.c                           |   88 +-
 net/ipv4/fib_trie.c                                |    8 +-
 net/ipv4/fou_nl.c                                  |    4 +-
 net/ipv4/icmp.c                                    |   21 +-
 net/ipv4/igmp.c                                    |   26 +-
 net/ipv4/inet_connection_sock.c                    |    6 +-
 net/ipv4/inet_diag.c                               |   10 +-
 net/ipv4/inetpeer.c                                |    9 +-
 net/ipv4/ip_fragment.c                             |   11 +-
 net/ipv4/ip_input.c                                |   20 +-
 net/ipv4/ip_options.c                              |    3 +-
 net/ipv4/ip_output.c                               |   26 +-
 net/ipv4/ipmr.c                                    |   40 +-
 net/ipv4/netfilter.c                               |    2 +-
 net/ipv4/netfilter/Kconfig                         |   16 +-
 net/ipv4/netfilter/ipt_rpfilter.c                  |    2 +-
 net/ipv4/netfilter/nf_dup_ipv4.c                   |    2 +-
 net/ipv4/netfilter/nft_fib_ipv4.c                  |    3 +-
 net/ipv4/nexthop.c                                 |   44 +-
 net/ipv4/raw.c                                     |    2 +-
 net/ipv4/route.c                                   |  256 +-
 net/ipv4/tcp.c                                     |    9 +-
 net/ipv4/tcp_ao.c                                  |   42 +-
 net/ipv4/tcp_cong.c                                |    3 +-
 net/ipv4/tcp_input.c                               |    4 +-
 net/ipv4/tcp_ipv4.c                                |   17 +-
 net/ipv4/tcp_output.c                              |   18 +-
 net/ipv4/tcp_timer.c                               |   19 +-
 net/ipv4/udp.c                                     |  249 +-
 net/ipv4/xfrm4_input.c                             |    2 +-
 net/ipv4/xfrm4_policy.c                            |    3 +-
 net/ipv4/xfrm4_protocol.c                          |    2 +-
 net/ipv6/addrconf.c                                |   71 +-
 net/ipv6/addrlabel.c                               |   28 +-
 net/ipv6/af_inet6.c                                |   22 +-
 net/ipv6/anycast.c                                 |    5 +-
 net/ipv6/esp6_offload.c                            |    6 +-
 net/ipv6/fib6_notifier.c                           |    2 +-
 net/ipv6/fib6_rules.c                              |    2 +-
 net/ipv6/ila/ila_xlat.c                            |   15 +-
 net/ipv6/ioam6.c                                   |   14 +-
 net/ipv6/ioam6_iptunnel.c                          |    6 +-
 net/ipv6/ip6_fib.c                                 |   41 +-
 net/ipv6/ip6_output.c                              |   24 +-
 net/ipv6/ip6_tunnel.c                              |    4 +-
 net/ipv6/ip6mr.c                                   |   27 +-
 net/ipv6/netfilter/Kconfig                         |    9 +-
 net/ipv6/raw.c                                     |    2 +-
 net/ipv6/route.c                                   |   74 +-
 net/ipv6/seg6_local.c                              |   14 +-
 net/ipv6/tcp_ipv6.c                                |   17 +-
 net/ipv6/udp.c                                     |  117 +-
 net/kcm/kcmsock.c                                  |   10 +-
 net/key/af_key.c                                   |    7 +-
 net/mac80211/agg-rx.c                              |   94 +-
 net/mac80211/agg-tx.c                              |   33 +-
 net/mac80211/cfg.c                                 |  186 +-
 net/mac80211/chan.c                                |   65 +-
 net/mac80211/debugfs.c                             |   28 +-
 net/mac80211/debugfs_key.c                         |    9 +-
 net/mac80211/debugfs_netdev.c                      |    3 +-
 net/mac80211/debugfs_sta.c                         |    9 +-
 net/mac80211/driver-ops.c                          |   16 +-
 net/mac80211/driver-ops.h                          |   18 +-
 net/mac80211/eht.c                                 |   21 +-
 net/mac80211/ht.c                                  |    2 +-
 net/mac80211/ibss.c                                |    7 +-
 net/mac80211/ieee80211_i.h                         |   25 +-
 net/mac80211/iface.c                               |   52 +-
 net/mac80211/link.c                                |   54 +-
 net/mac80211/mesh.c                                |    2 +-
 net/mac80211/mesh_hwmp.c                           |    6 +-
 net/mac80211/mesh_pathtbl.c                        |   10 +-
 net/mac80211/mesh_plink.c                          |    7 +-
 net/mac80211/mesh_sync.c                           |    2 +-
 net/mac80211/mlme.c                                |  118 +-
 net/mac80211/ocb.c                                 |    4 +-
 net/mac80211/rate.c                                |   35 +-
 net/mac80211/rate.h                                |   10 +-
 net/mac80211/rc80211_minstrel_ht.c                 |    2 +-
 net/mac80211/rx.c                                  |   75 +-
 net/mac80211/scan.c                                |   22 +-
 net/mac80211/spectmgmt.c                           |    9 +-
 net/mac80211/sta_info.h                            |    2 +-
 net/mac80211/status.c                              |    5 +-
 net/mac80211/tdls.c                                |    3 +-
 net/mac80211/tkip.c                                |    2 +-
 net/mac80211/trace.h                               |   34 +-
 net/mac80211/tx.c                                  |    8 +-
 net/mac80211/util.c                                |   20 +-
 net/mac80211/vht.c                                 |   29 +-
 net/mac80211/wpa.c                                 |    3 -
 net/mctp/device.c                                  |   28 +-
 net/mpls/af_mpls.c                                 |    7 +-
 net/mptcp/diag.c                                   |    2 +-
 net/mptcp/mptcp_pm_gen.c                           |    2 +-
 net/mptcp/options.c                                |    4 +-
 net/mptcp/pm.c                                     |    3 +
 net/mptcp/pm_netlink.c                             |   47 +-
 net/mptcp/protocol.c                               |   15 +-
 net/mptcp/protocol.h                               |    6 +-
 net/mptcp/sched.c                                  |    2 -
 net/mptcp/subflow.c                                |   17 +-
 net/netfilter/ipset/ip_set_bitmap_ip.c             |    7 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |    5 +-
 net/netfilter/nf_bpf_link.c                        |    2 +-
 net/netfilter/nf_conntrack_netlink.c               |    2 +-
 net/netfilter/nf_nat_core.c                        |    6 +-
 net/netfilter/nf_tables_api.c                      |  517 ++-
 net/netfilter/nfnetlink.c                          |    2 +-
 net/netfilter/nft_bitwise.c                        |  166 +-
 net/netfilter/nft_flow_offload.c                   |    8 +-
 net/netfilter/nft_set_bitmap.c                     |   10 +-
 net/netfilter/nft_set_hash.c                       |    3 +-
 net/netfilter/nft_tunnel.c                         |    5 +-
 net/netlabel/netlabel_mgmt.c                       |   13 +-
 net/netlink/af_netlink.c                           |   10 +-
 net/netlink/genetlink.c                            |    4 +-
 net/nfc/nci/core.c                                 |   13 +-
 net/nfc/nci/ntf.c                                  |   32 +-
 net/nfc/netlink.c                                  |    5 +
 net/openvswitch/datapath.c                         |   10 +-
 net/openvswitch/flow_netlink.c                     |    2 +-
 net/openvswitch/vport-internal_dev.c               |    1 -
 net/packet/af_packet.c                             |   27 +-
 net/phonet/pn_dev.c                                |   74 +-
 net/phonet/pn_netlink.c                            |  127 +-
 net/rds/ib_rdma.c                                  |    4 -
 net/rfkill/rfkill-gpio.c                           |    8 +-
 net/rxrpc/conn_object.c                            |    4 +-
 net/rxrpc/local_object.c                           |    4 +-
 net/rxrpc/sendmsg.c                                |    1 +
 net/sched/act_api.c                                |  102 +-
 net/sched/act_ct.c                                 |   10 +-
 net/sched/act_ctinfo.c                             |    8 +-
 net/sched/act_gate.c                               |   11 +-
 net/sched/act_mpls.c                               |   18 +-
 net/sched/act_police.c                             |    6 +-
 net/sched/cls_api.c                                |   72 +-
 net/sched/sch_api.c                                |   20 +-
 net/sched/sch_cbs.c                                |    2 +-
 net/sched/sch_choke.c                              |    2 +-
 net/sched/sch_fq.c                                 |   36 +-
 net/sched/sch_gred.c                               |    2 +-
 net/sched/sch_htb.c                                |    4 +-
 net/sched/sch_qfq.c                                |    5 +-
 net/sched/sch_red.c                                |    2 +-
 net/sched/sch_sfq.c                                |   39 +-
 net/sched/sch_taprio.c                             |    2 +-
 net/sctp/ipv6.c                                    |    2 +-
 net/sctp/protocol.c                                |   16 +-
 net/shaper/Makefile                                |    8 +
 net/shaper/shaper.c                                | 1438 ++++++
 net/shaper/shaper_nl_gen.c                         |  154 +
 net/shaper/shaper_nl_gen.h                         |   44 +
 net/smc/smc.h                                      |    2 +-
 net/smc/smc_clc.h                                  |    2 +-
 net/smc/smc_core.c                                 |    2 +-
 net/smc/smc_core.h                                 |    4 +-
 net/socket.c                                       |    8 +-
 net/sunrpc/svcsock.c                               |    6 +-
 net/vmw_vsock/af_vsock.c                           |    1 +
 net/vmw_vsock/hyperv_transport.c                   |    1 +
 net/wireless/Kconfig                               |   45 +-
 net/wireless/Makefile                              |    5 -
 net/wireless/chan.c                                |    5 +-
 net/wireless/core.c                                |   66 +-
 net/wireless/core.h                                |    1 +
 net/wireless/lib80211.c                            |  257 --
 net/wireless/mlme.c                                |    6 -
 net/wireless/nl80211.c                             |  161 +-
 net/wireless/radiotap.c                            |    2 +-
 net/wireless/rdev-ops.h                            |    5 +-
 net/wireless/reg.c                                 |    2 +-
 net/wireless/scan.c                                |   12 +-
 net/wireless/trace.h                               |   10 +-
 net/wireless/util.c                                |   31 +-
 net/wireless/wext-compat.c                         |   13 +-
 net/wireless/wext-compat.h                         |    6 -
 net/wireless/wext-core.c                           |    2 +-
 net/xdp/xsk.c                                      |   49 +-
 net/xdp/xsk_buff_pool.c                            |   54 +-
 net/xdp/xsk_queue.h                                |    2 +-
 net/xfrm/xfrm_compat.c                             |    6 +-
 net/xfrm/xfrm_input.c                              |    2 +-
 net/xfrm/xfrm_policy.c                             |   28 +-
 net/xfrm/xfrm_state.c                              |  171 +-
 net/xfrm/xfrm_user.c                               |   83 +-
 rust/kernel/net/phy.rs                             |   16 +-
 tools/include/uapi/asm-generic/socket.h            |    2 +
 tools/include/uapi/linux/if_link.h                 |  554 ++-
 tools/include/uapi/linux/netdev.h                  |    4 +
 tools/net/ynl/cli.py                               |   19 +-
 tools/net/ynl/ethtool.py                           |    2 +
 tools/net/ynl/generated/Makefile                   |    2 +-
 tools/net/ynl/lib/Makefile                         |    2 +-
 tools/net/ynl/lib/nlspec.py                        |    3 +
 tools/net/ynl/lib/ynl.py                           |   28 +-
 tools/net/ynl/samples/Makefile                     |    2 +-
 tools/net/ynl/samples/page-pool.c                  |    2 +-
 tools/net/ynl/ynl-gen-c.py                         |   82 +-
 tools/testing/selftests/bpf/.gitignore             |    1 -
 tools/testing/selftests/bpf/Makefile               |   24 +-
 tools/testing/selftests/bpf/network_helpers.h      |    1 +
 .../selftests/bpf/prog_tests/btf_skc_cls_ingress.c |  264 +-
 tools/testing/selftests/bpf/prog_tests/mptcp.c     |  155 +-
 .../selftests/bpf/prog_tests/netns_cookie.c        |   29 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c       |   54 +
 tools/testing/selftests/bpf/prog_tests/tc_netkit.c |   94 +-
 .../selftests/bpf/prog_tests/test_csum_diff.c      |  408 ++
 .../selftests/bpf/prog_tests/xdp_cpumap_attach.c   |   44 +-
 tools/testing/selftests/bpf/progs/csum_diff_test.c |   42 +
 tools/testing/selftests/bpf/progs/mptcp_bpf.h      |   42 +
 tools/testing/selftests/bpf/progs/mptcp_subflow.c  |  128 +
 .../selftests/bpf/progs/netns_cookie_prog.c        |   10 +
 .../selftests/bpf/progs/test_btf_skc_cls_ingress.c |   82 +-
 tools/testing/selftests/bpf/progs/test_tc_link.c   |   12 +
 .../bpf/progs/test_tcp_check_syncookie_kern.c      |  167 -
 .../bpf/progs/test_xdp_with_cpumap_helpers.c       |    7 +-
 .../selftests/bpf/progs/verifier_array_access.c    |    3 +-
 .../selftests/bpf/progs/xdp_synproxy_kern.c        |    3 +-
 tools/testing/selftests/bpf/test_sockmap.c         |  202 +-
 .../selftests/bpf/test_tcp_check_syncookie.sh      |   85 -
 .../selftests/bpf/test_tcp_check_syncookie_user.c  |  213 -
 tools/testing/selftests/drivers/net/Makefile       |    1 +
 tools/testing/selftests/drivers/net/hw/.gitignore  |    1 +
 tools/testing/selftests/drivers/net/hw/Makefile    |   11 +
 tools/testing/selftests/drivers/net/hw/devmem.py   |   45 +
 .../selftests/drivers/net/hw/lib/py/__init__.py    |    1 +
 .../selftests/drivers/net/hw/lib/py/linkconfig.py  |  222 +
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  |  789 ++++
 .../selftests/drivers/net/hw/nic_link_layer.py     |  113 +
 .../selftests/drivers/net/hw/nic_performance.py    |  137 +
 tools/testing/selftests/drivers/net/hw/rss_ctx.py  |  107 +-
 tools/testing/selftests/drivers/net/lib/py/load.py |   20 +-
 .../selftests/drivers/net/mlxsw/devlink_trap.sh    |    2 +-
 .../drivers/net/mlxsw/devlink_trap_l3_drops.sh     |    4 +-
 .../net/mlxsw/devlink_trap_l3_exceptions.sh        |   12 +-
 .../drivers/net/mlxsw/devlink_trap_policer.sh      |   85 +-
 .../drivers/net/mlxsw/devlink_trap_tunnel_ipip.sh  |    4 +-
 .../drivers/net/mlxsw/devlink_trap_tunnel_ipip6.sh |    4 +-
 .../drivers/net/mlxsw/devlink_trap_tunnel_vxlan.sh |    4 +-
 .../net/mlxsw/devlink_trap_tunnel_vxlan_ipv6.sh    |    4 +-
 .../selftests/drivers/net/mlxsw/qos_ets_strict.sh  |  167 +-
 .../drivers/net/mlxsw/qos_max_descriptors.sh       |  118 +-
 .../selftests/drivers/net/mlxsw/qos_mc_aware.sh    |  138 +-
 .../selftests/drivers/net/mlxsw/rtnetlink.sh       |   10 +-
 .../testing/selftests/drivers/net/mlxsw/sch_ets.sh |   26 +-
 .../selftests/drivers/net/mlxsw/sch_red_core.sh    |  213 +-
 .../selftests/drivers/net/mlxsw/sch_red_ets.sh     |   32 +-
 .../selftests/drivers/net/mlxsw/sch_red_root.sh    |   18 +-
 .../selftests/drivers/net/mlxsw/tc_sample.sh       |    4 +-
 .../testing/selftests/drivers/net/netcons_basic.sh |   40 +-
 .../selftests/drivers/net/netdevsim/Makefile       |    3 +
 .../testing/selftests/drivers/net/netdevsim/config |    1 +
 .../drivers/net/netdevsim/ethtool-features.sh      |   31 +
 .../drivers/net/netdevsim/fib_notifications.sh     |    6 +-
 .../drivers/net/netdevsim/macsec-offload.sh        |  117 +
 tools/testing/selftests/drivers/net/shaper.py      |  461 ++
 tools/testing/selftests/mm/Makefile                |   21 +
 tools/testing/selftests/mm/page_frag/Makefile      |   18 +
 .../selftests/mm/page_frag/page_frag_test.c        |  198 +
 tools/testing/selftests/mm/run_vmtests.sh          |    8 +
 tools/testing/selftests/mm/test_page_frag.sh       |  175 +
 tools/testing/selftests/net/.gitignore             |    2 +-
 tools/testing/selftests/net/Makefile               |    7 +-
 tools/testing/selftests/net/bpf_offload.py         |    5 +-
 tools/testing/selftests/net/busy_poll_test.sh      |  165 +
 tools/testing/selftests/net/busy_poller.c          |  346 ++
 tools/testing/selftests/net/drop_monitor_tests.sh  |    2 +-
 tools/testing/selftests/net/fdb_notify.sh          |   96 +
 tools/testing/selftests/net/fib_tests.sh           |    8 +-
 tools/testing/selftests/net/forwarding/Makefile    |    3 +-
 .../selftests/net/forwarding/devlink_lib.sh        |    2 +-
 tools/testing/selftests/net/forwarding/lib.sh      |  200 +-
 tools/testing/selftests/net/forwarding/sch_ets.sh  |    7 +-
 .../selftests/net/forwarding/sch_ets_core.sh       |   81 +-
 .../selftests/net/forwarding/sch_ets_tests.sh      |   14 +-
 tools/testing/selftests/net/forwarding/sch_red.sh  |  103 +-
 .../selftests/net/forwarding/sch_tbf_core.sh       |   91 +-
 .../selftests/net/forwarding/sch_tbf_etsprio.sh    |    7 +-
 .../selftests/net/forwarding/sch_tbf_root.sh       |    3 +-
 .../testing/selftests/net/forwarding/tc_police.sh  |    8 +-
 tools/testing/selftests/net/hsr/config             |    1 +
 tools/testing/selftests/net/hsr/hsr_common.sh      |    4 +-
 tools/testing/selftests/net/hsr/hsr_ping.sh        |   98 +
 tools/testing/selftests/net/hsr/settings           |    1 +
 tools/testing/selftests/net/ioam6.sh               | 1832 ++++++--
 tools/testing/selftests/net/ioam6_parser.c         | 1087 +++--
 .../selftests/net/ipv6_route_update_soft_lockup.sh |  262 ++
 tools/testing/selftests/net/lib.sh                 |  226 +
 tools/testing/selftests/net/lib/Makefile           |    2 +-
 tools/testing/selftests/net/lib/csum.c             |   12 +-
 tools/testing/selftests/net/lib/py/__init__.py     |    1 +
 tools/testing/selftests/net/lib/py/ynl.py          |    5 +
 tools/testing/selftests/net/lib/sh/defer.sh        |  115 +
 tools/testing/selftests/net/mptcp/Makefile         |    2 +-
 tools/testing/selftests/net/ncdevmem.c             |  570 ---
 tools/testing/selftests/net/netfilter/.gitignore   |    1 +
 tools/testing/selftests/net/netfilter/Makefile     |    7 +-
 .../selftests/net/netfilter/conntrack_dump_flush.c |    6 +
 .../net/netfilter/conntrack_dump_flush.sh          |    3 +
 tools/testing/selftests/net/netfilter/nft_queue.sh |    8 +-
 tools/testing/selftests/net/netlink-dumps.c        |    4 +-
 tools/testing/selftests/net/pmtu.sh                |  114 +-
 tools/testing/selftests/net/psock_fanout.c         |   78 +-
 tools/testing/selftests/net/rtnetlink.sh           |  112 +-
 tools/testing/selftests/net/tcp_ao/lib/aolib.h     |    1 +
 .../selftests/net/tcp_ao/setsockopt-closed.c       |  186 +-
 tools/testing/selftests/net/tls.c                  |   19 +
 tools/testing/selftests/net/txtimestamp.c          |   44 +-
 tools/testing/selftests/net/txtimestamp.sh         |   12 +-
 tools/testing/selftests/net/veth.sh                |    2 -
 tools/testing/selftests/net/ynl.mk                 |   16 +-
 tools/testing/selftests/ptp/testptp.c              |   62 +-
 .../tc-testing/tc-tests/filters/basic.json         |    6 +-
 .../tc-testing/tc-tests/filters/cgroup.json        |    6 +-
 .../tc-testing/tc-tests/filters/flow.json          |    2 +-
 .../tc-testing/tc-tests/filters/route.json         |    2 +-
 .../tc-testing/tc-tests/infra/qdiscs.json          |   98 +
 tools/testing/selftests/wireguard/netns.sh         |    1 +
 1754 files changed, 77307 insertions(+), 52092 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
 create mode 100644 Documentation/netlink/specs/net_shaper.yaml
 create mode 100644 Documentation/netlink/specs/rt_neigh.yaml
 create mode 100644 Documentation/netlink/specs/rt_rule.yaml
 create mode 100644 Documentation/networking/diagnostic/index.rst
 create mode 100644 Documentation/networking/diagnostic/twisted_pair_layer1_diagnostics.rst
 create mode 100644 drivers/net/dsa/mv88e6xxx/leds.c
 delete mode 100644 drivers/net/ethernet/dlink/sundance.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_hw.h
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_pf.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
 create mode 100644 drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
 create mode 100644 drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/Makefile
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_action.c => action.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_action.h => action.h} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_buddy.c => buddy.c} (98%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_buddy.h => buddy.h} (86%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_bwc.c => bwc.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_bwc.h => bwc.h} (96%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_bwc_complex.c => bwc_complex.c} (98%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_bwc_complex.h => bwc_complex.h} (90%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_cmd.c => cmd.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_cmd.h => cmd.h} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_context.c => context.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_context.h => context.h} (95%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_debug.c => debug.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_debug.h => debug.h} (93%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_definer.c => definer.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_definer.h => definer.h} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_internal.h => internal.h} (67%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_matcher.c => matcher.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_matcher.h => matcher.h} (96%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_pat_arg.c => pat_arg.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_pat_arg.h => pat_arg.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_pool.c => pool.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_pool.h => pool.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_prm.h => prm.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_rule.c => rule.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_rule.h => rule.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_send.c => send.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_send.h => send.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_table.c => table.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_table.h => table.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_vport.c => vport.c} (98%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_vport.h => vport.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_action.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_arg.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_buddy.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_cmd.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_dbg.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_dbg.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_definer.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_domain.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_fw.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_icm_pool.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_matcher.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ptrn.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_rule.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_send.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ste.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ste.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ste_v0.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ste_v1.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ste_v1.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ste_v2.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_table.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_types.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/fs_dr.c (96%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/fs_dr.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/mlx5_ifc_dr.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/mlx5_ifc_dr_ste_v1.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/mlx5dr.h (100%)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_csr.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_time.c
 create mode 100644 drivers/net/ethernet/microchip/lan969x/Kconfig
 create mode 100644 drivers/net/ethernet/microchip/lan969x/Makefile
 create mode 100644 drivers/net/ethernet/microchip/lan969x/lan969x.c
 create mode 100644 drivers/net/ethernet/microchip/lan969x/lan969x.h
 create mode 100644 drivers/net/ethernet/microchip/lan969x/lan969x_calendar.c
 create mode 100644 drivers/net/ethernet/microchip/lan969x/lan969x_regs.c
 create mode 100644 drivers/net/ethernet/microchip/lan969x/lan969x_vcap_ag_api.c
 create mode 100644 drivers/net/ethernet/microchip/lan969x/lan969x_vcap_impl.c
 create mode 100644 drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
 create mode 100644 drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
 create mode 100644 drivers/net/phy/mediatek/Kconfig
 create mode 100644 drivers/net/phy/mediatek/Makefile
 rename drivers/net/phy/{mediatek-ge-soc.c => mediatek/mtk-ge-soc.c} (79%)
 rename drivers/net/phy/{mediatek-ge.c => mediatek/mtk-ge.c} (82%)
 create mode 100644 drivers/net/phy/mediatek/mtk-phy-lib.c
 create mode 100644 drivers/net/phy/mediatek/mtk.h
 create mode 100644 drivers/net/wireless/ath/ath12k/coredump.c
 create mode 100644 drivers/net/wireless/ath/ath12k/coredump.h
 create mode 100644 drivers/net/wireless/intel/ipw2x00/libipw_crypto.c
 rename net/wireless/lib80211_crypt_ccmp.c => drivers/net/wireless/intel/ipw2x00/libipw_crypto_ccmp.c (83%)
 rename net/wireless/lib80211_crypt_tkip.c => drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c (87%)
 rename net/wireless/lib80211_crypt_wep.c => drivers/net/wireless/intel/ipw2x00/libipw_crypto_wep.c (72%)
 rename net/wireless/wext-spy.c => drivers/net/wireless/intel/ipw2x00/libipw_spy.c (81%)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812au.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821au.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw88xxa.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw88xxa.h
 create mode 100644 drivers/ptp/ptp_s390.c
 create mode 100644 drivers/ptp/ptp_vmclock.c
 delete mode 100644 drivers/staging/rtl8192e/Kconfig
 delete mode 100644 drivers/staging/rtl8192e/Makefile
 delete mode 100644 drivers/staging/rtl8192e/TODO
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/Kconfig
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/Makefile
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_core.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_core.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_pci.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_pm.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_pm.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_ps.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_wx.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/table.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/table.h
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_BA.h
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_BAProc.c
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_HT.h
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_HTProc.c
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_Qos.h
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_TS.h
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_TSProc.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib.h
 delete mode 100644 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_crypt_tkip.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_crypt_wep.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_module.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_rx.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_softmac.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_softmac_wx.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_tx.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_wx.c
 delete mode 100644 include/linux/ath9k_platform.h
 create mode 100644 include/linux/fsl/netc_global.h
 delete mode 100644 include/linux/if_ltalk.h
 create mode 100644 include/linux/page_frag_cache.h
 delete mode 100644 include/net/lib80211.h
 create mode 100644 include/net/neighbour_tables.h
 create mode 100644 include/net/net_shaper.h
 create mode 100644 include/uapi/linux/net_shaper.h
 create mode 100644 include/uapi/linux/vmclock-abi.h
 create mode 100644 lib/packing_test.c
 create mode 100644 mm/page_frag_cache.c
 delete mode 100644 net/appletalk/dev.c
 create mode 100644 net/core/rtnl_net_debug.c
 create mode 100644 net/core/skb_fault_injection.c
 create mode 100644 net/shaper/Makefile
 create mode 100644 net/shaper/shaper.c
 create mode 100644 net/shaper/shaper_nl_gen.c
 create mode 100644 net/shaper/shaper_nl_gen.h
 delete mode 100644 net/wireless/lib80211.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_csum_diff.c
 create mode 100644 tools/testing/selftests/bpf/progs/csum_diff_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf.h
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_subflow.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
 delete mode 100755 tools/testing/selftests/bpf/test_tcp_check_syncookie.sh
 delete mode 100644 tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
 create mode 100644 tools/testing/selftests/drivers/net/hw/.gitignore
 create mode 100755 tools/testing/selftests/drivers/net/hw/devmem.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/ncdevmem.c
 create mode 100644 tools/testing/selftests/drivers/net/hw/nic_link_layer.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/nic_performance.py
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/ethtool-features.sh
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh
 create mode 100755 tools/testing/selftests/drivers/net/shaper.py
 create mode 100644 tools/testing/selftests/mm/page_frag/Makefile
 create mode 100644 tools/testing/selftests/mm/page_frag/page_frag_test.c
 create mode 100755 tools/testing/selftests/mm/test_page_frag.sh
 create mode 100755 tools/testing/selftests/net/busy_poll_test.sh
 create mode 100644 tools/testing/selftests/net/busy_poller.c
 create mode 100755 tools/testing/selftests/net/fdb_notify.sh
 create mode 100644 tools/testing/selftests/net/hsr/settings
 create mode 100755 tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
 create mode 100644 tools/testing/selftests/net/lib/sh/defer.sh
 delete mode 100644 tools/testing/selftests/net/ncdevmem.c
 create mode 100755 tools/testing/selftests/net/netfilter/conntrack_dump_flush.sh
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json


