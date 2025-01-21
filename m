Return-Path: <bpf+bounces-49364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DBDA17E2D
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 13:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08297A163C
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 12:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EB21F2C3C;
	Tue, 21 Jan 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apVcqgxe"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8361F237A
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464307; cv=none; b=nETH7sI+qZx8g5k6PZCenS5op8iU3iRYdMX0VSAIHFmH9x3U8KSUzSFpPCUp5d2yflXpdiT+xJnHiUILBZ8dcIPu0Adr02jX1i6qr32fZ9eRYfzuV8I6/Kbg66sMKXJ+/dC0aYr9WgRSqN3nDBEgzWfQ9BxahkXhm6lqheMkrIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464307; c=relaxed/simple;
	bh=HnV9YFsi79bcOBT5bDEym1PDR91iy4D3B1fidFhBYqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OkyYnhU12Diau+5xTUdRvn5AAcQRsPun7EPALShZzrW/Ig7FKB9HSkLiAug0Aho/v5Rh5M0LpWEk+Lsbnj/8fvt/HUfOiWgMB71EDnPN3FvvVHTygbq2cNxEgTcRvfK6rxg/pab8mXlLewFpromlBZwBy2tkhSO9C8ZOrMeHdH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=apVcqgxe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737464298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JS5nTlIzmSPqEO9RH8Lw1Ov7uGZtG1qtgsHDwW6IMpg=;
	b=apVcqgxeXnVBYUtiwKglwzNtA8WE/wJza09f+KA10ccibeRjMRmloUmXg0+6n9tbMjLNlp
	1rWITOJ2hERwzhnO+r7nP2VunVrqpcDlOoBFm0Hv4V4KUMbKyYe7Z73WwZqCstGkM2mc/w
	FS/IY7LJ4i/tpJ9Y6bB8xrP/CzJRXJU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-zz3mSDbWO2ORxfm-k9-Vqg-1; Tue,
 21 Jan 2025 07:58:11 -0500
X-MC-Unique: zz3mSDbWO2ORxfm-k9-Vqg-1
X-Mimecast-MFC-AGG-ID: zz3mSDbWO2ORxfm-k9-Vqg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA1C319560B7;
	Tue, 21 Jan 2025 12:58:09 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.107])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C782819560B1;
	Tue, 21 Jan 2025 12:58:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [GIT PULL] Networking for v6.14
Date: Tue, 21 Jan 2025 13:57:48 +0100
Message-ID: <20250121125748.37808-1-pabeni@redhat.com>
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

This is slightly smaller than usual, with the most interesting work
being still around RTNL scope reduction.

Stephen reported a trivial conflict vs the kselftest tree:
https://lore.kernel.org/linux-next/20250108144003.67532649@canb.auug.org.au/

The following changes since commit cf33d96f50903214226b379b3f10d1f262dae018:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-01-21 10:24:33 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.14

for you to fetch changes up to cf33d96f50903214226b379b3f10d1f262dae018:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-01-21 10:24:33 +0100)

----------------------------------------------------------------
Networking changes for 6.14.

Core
----

 - More core refactoring to reduce the RTNL lock contention,
   including preparatory work for the per-network namespace RTNL lock,
   replacing RTNL lock with a per device-one to protect NAPI-related
   net device data and moving synchronize_net() calls outside such
   lock.

 - Extend drop reasons usage, adding net scheduler, AF_UNIX, bridge and
   more specific TCP coverage.

 - Reduce network namespace tear-down time by removing per-subsystems
   synchronize_net() in tipc and sched.

 - Add flow label selector support for fib rules, allowing traffic
   redirection based on such header field.

Netfilter
---------

 - Do not remove netdev basechain when last device is gone, allowing
   netdev basechains without devices.

 - Revisit the flowtable teardown strategy, dealing better with fin,
   reset and re-open events.

 - Scale-up IP-vs connection dumping by avoiding linear search on
   each restart.

Protocols
---------

 - A significant XDP socket refactor, consolidating and optimizing
   several helpers into the core

 - Better scaling of ICMP rate-limiting, by removing false-sharing in
   inet peers handling.

 - Introduces netlink notifications for multicast IPv4 and IPv6
   address changes.

 - Add ipsec support for IP-TFS/AggFrag encapsulation, allowing
   aggregation and fragmentation of the inner IP.

 - Add sysctl to configure TIME-WAIT reuse delay for TCP sockets,
   to avoid local port exhaustion issues when the average connection
   lifetime is very short.

 - Support updating keys (re-keying) for connections using kernel
   TLS (for TLS 1.3 only).

 - Support ipv4-mapped ipv6 address clients in smc-r v2.

 - Add support for jumbo data packet transmission in RxRPC sockets,
   gluing multiple data packets in a single UDP packet.

 - Support RxRPC RACK-TLP to manage packet loss and retransmission in
   conjunction with the congestion control algorithm.

Driver API
----------

 - Introduce a unified and structured interface for reporting PHY
   statistics, exposing consistent data across different H/W via
   ethtool.

 - Make timestamping selectable, allow the user to select the desired
   hwtstamp provider (PHY or MAC) administratively.

 - Add support for configuring a header-data-split threshold (HDS)
   value via ethtool, to deal with partial or buggy H/W implementation.

 - Consolidate DSA drivers Energy Efficiency Ethernet support.

 - Add EEE management to phylink, making use of the phylib
   implementation.

 - Add phylib support for in-band capabilities negotiation.

 - Simplify how phylib-enabled mac drivers expose the supported
   interfaces.

Tests and tooling
-----------------

 - Make the YNL tool package-friendly to make it easier to deploy it
   separately from the kernel.

 - Increase TCP selftest coverage importing several packetdrill
   test-cases.

 - Regenerate the ethtool uapi header from the YNL spec,
   to ease maintenance and future development.

 - Add YNL support for decoding the link types used in net
   self-tests, allowing a single build to run both net and
   drivers/net.

Drivers
-------

 - Ethernet high-speed NICs:
   - nVidia/Mellanox (mlx5):
     - add cross E-Switch QoS support
     - add SW Steering support for ConnectX-8
     - implement support for HW-Managed Flow Steering, improving the
       rule deletion/insertion rate
     - support for multi-host LAG
   - Intel (ixgbe, ice, igb):
     - ice: add support for devlink health events
     - ixgbe: add initial support for E610 chipset variant
     - igb: add support for AF_XDP zero-copy
   - Meta:
     - add support for basic RSS config
     - allow changing the number of channels
     - add hardware monitoring support
   - Broadcom (bnxt):
     - implement TCP data split and HDS threshold ethtool support,
       enabling Device Memory TCP.
   - Marvell Octeon:
     - implement egress ipsec offload support for the cn10k family
   - Hisilicon (HIBMC):
     - implement unicast MAC filtering

 - Ethernet NICs embedded and virtual:
   - Convert UDP tunnel drivers to NETDEV_PCPU_STAT_DSTATS, avoiding
     contented atomic operations for drop counters
   - Freescale:
     - quicc: phylink conversion
     - enetc: support Tx and Rx checksum offload and improve TSO
       performances
   - MediaTek:
     - airoha: introduce support for ETS and HTB Qdisc offload
   - Microchip:
     - lan78XX USB: preparation work for phylink conversion
   - Synopsys (stmmac):
     - support DWMAC IP on NXP Automotive SoCs S32G2xx/S32G3xx/S32R45
     - refactor EEE support to leverage the new driver API
     - optimize DMA and cache access to increase raw RX performances
       by 40%
   - TI:
     - icssg-prueth: add multicast filtering support for VLAN
       interface
   - netkit:
     - add ability to configure head/tailroom
   - VXLAN:
     - accepts packets with user-defined reserved bit

 - Ethernet switches:
   - Microchip:
     - lan969x: add RGMII support
     - lan969x: improve TX and RX performance using the FDMA engine
   - nVidia/Mellanox:
     - move Tx header handling to PCI driver, to ease XDP support

 - Ethernet PHYs:
   - Texas Instruments DP83822:
     - add support for GPIO2 clock output
   - Realtek:
     - 8169: add support for RTL8125D rev.b
     - rtl822x: add hwmon support for the temperature sensor
   - Microchip:
     - add support for RDS PTP hardware
     - consolidate periodic output signal generation

 - CAN:
   - several DT-bindings to DT schema conversions
   - tcan4x5x:
     - add HW standby support
     - support nWKRQ voltage selection
   - kvaser:
     - allowing Bus Error Reporting runtime configuration

 - WiFi:
   - the on-going Multi-Link Operation (MLO) effort continues, affecting
     both the stack and in drivers
   - mac80211/cfg80211:
     - Emergency Preparedness Communication Services (EPCS) station mode
       support
     - support for adding and removing station links for MLO
     - add support for WiFi 7/EHT mesh over 320 MHz channels
     - report Tx power info for each link
   - RealTek (rtw88):
     - enable USB Rx aggregation and USB 3 to improve performance
     - LED support
   - RealTek (rtw89):
     - refactor power save to support Multi-Link Operations
     - add support for RTL8922AE-VS variant
   - MediaTek (mt76):
     - single wiphy multiband support (preparation for MLO)
     - p2p device support
     - add TP-Link TXE50UH USB adapter support
   - Qualcomm (ath10k):
     - support for the QCA6698AQ IP core
   - Qualcomm (ath12k):
     - enable MLO for QCN9274

 - Bluetooth:
   - Allow sysfs to trigger hdev reset, to allow recovering devices
     not responsive from user-space
   - MediaTek: add support for MT7922, MT7925, MT7921e devices
   - Realtek: add support for RTL8851BE devices
   - Qualcomm: add support for WCN785x devices
   - ISO: allow BIG re-sync

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Aditya Kumar Singh (17):
      wifi: ath12k: ath12k_bss_assoc(): MLO support
      wifi: mac80211_hwsim: add 6 GHz EHT Mesh capabilities
      wifi: ath12k: rename mlo_capable_flags to single_chip_mlo_supp
      wifi: ath12k: fix read pointer after free in ath12k_mac_assign_vif_to_vdev()
      wifi: ath12k: fix ath12k_qmi_alloc_chunk() to handle too large allocations
      wifi: ath12k: fix ar->supports_6ghz usage during hw register
      wifi: ath12k: pass link ID during MLO while delivering skb
      wifi: ath12k: symmetrize scan vdev creation and deletion during HW scan
      wifi: ath12k: add can_activate_links mac operation
      wifi: ath12k: add no-op without debug print in WMI Rx event
      wifi: ath12k: remove warning print in htt mlo offset event message
      wifi: ath12k: add ATH12K_FW_FEATURE_MLO capability firmware feature
      wifi: ath12k: assign unique hardware link IDs during QMI host cap
      wifi: ath12k: rename CAC_RUNNING flag
      wifi: ath12k: fix CAC running state during virtual interface start
      wifi: ath12k: handle radar detection with MLO
      wifi: ath12k: fix key cache handling

Akiva Goldberger (1):
      net/mlx5: Add nic_cap_reg and vhca_icm_ctrl registers

Aleksander Jan Bajkowski (1):
      net: phy: realtek: HWMON support for standalone versions of RTL8221B and RTL8251

Aleksandr Loktionov (1):
      i40e: add ability to reset VF for Tx and Rx MDD events

Ales Nezbeda (1):
      net: macsec: Add endianness annotations in salt struct

Alessandro Zanni (1):
      selftests/net/forwarding: teamd command not found

Alex Shumsky (1):
      wifi: brcmfmac: clarify unmodifiable headroom log message

Alexander Duyck (4):
      eth: fbnic: support querying RSS config
      eth: fbnic: support setting RSS configuration
      eth: fbnic: let user control the RSS hash fields
      eth: fbnic: centralize the queue count and NAPI<>queue setting

Alexander Lobakin (16):
      xsk: align &xdp_buff_xsk harder
      bpf, xdp: constify some bpf_prog * function arguments
      xdp, xsk: constify read-only arguments of some static inline helpers
      xdp: allow attaching already registered memory model to xdp_rxq_info
      xsk: allow attaching XSk pool via xdp_rxq_info_reg_mem_model()
      netmem: add a couple of page helper wrappers
      page_pool: make page_pool_put_page_bulk() handle array of netmems
      page_pool: allow mixing PPs within one bulk
      xdp: get rid of xdp_frame::mem.id
      xdp: make __xdp_return() MP-agnostic
      skbuff: allow 2-4-argument skb_frag_dma_map()
      page_pool: add page_pool_dev_alloc_netmem()
      xdp: add generic xdp_buff_add_frag()
      xdp: add generic xdp_build_skb_from_buff()
      xsk: make xsk_buff_add_frag() really add the frag via __xdp_buff_add_frag()
      xsk: add generic XSk &xdp_buff -> skb conversion

Alexander Sverdlin (2):
      net: ethernet: ti: cpsw: fix the comment regarding VLAN-aware ALE
      net: ethernet: ti: am65-cpsw: VLAN-aware CPSW only if !DSA

Alexis Lothoré (2):
      wifi: wilc1000: unregister wiphy only if it has been registered
      wifi: wilc1000: unregister wiphy only after netdev registration

Allan Wang (2):
      wifi: mt76: introduce mt792x_config_mac_addr_list routine
      wifi: mt76: mt7921: add rfkill_poll for hardware rfkill

Aloka Dixit (1):
      wifi: mac80211: fix variable used in for_each_sdata_link()

Amit Cohen (5):
      mlxsw: Add mlxsw_txhdr_info structure
      mlxsw: Initialize txhdr_info according to PTP operations
      mlxsw: Define Tx header fields in txheader.h
      mlxsw: Move Tx header handling to PCI driver
      mlxsw: Do not store Tx header length as driver parameter

Andreas Kemnade (1):
      wifi: wlcore: fix unbalanced pm_runtime calls

Andrei Otcheretianski (1):
      wifi: mac80211: Accept authentication frames on P2P device

Andrew Halaney (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3610 for MT7922

Andrew Kreimer (1):
      net: hinic: Fix typo in dev_err message

Andrew Lunn (3):
      dsa: mv88e6xxx: Move available stats into info structure
      dsa: mv88e6xxx: Centralise common statistics check
      net: dsa: qca8k: Fix inconsistent use of jiffies vs milliseconds

Andy Moreton (1):
      sfc: remove efx_writed_page_locked

Andy Shevchenko (2):
      nfc: st21nfca: Remove unused of_gpio.h
      nfc: mrvl: Don't use "proxy" headers

Andy Strohman (1):
      wifi: mac80211: fix tid removal during mesh forwarding

Anjaneyulu (7):
      wifi: iwlwifi: mvm: update documentation for iwl_nvm_channel_flags
      wifi: iwlwifi: mvm: add UHB canada support in TAS_CONFIG cmd
      wifi: iwlwifi: mvm: add UHB canada support in GET_TAS_STATUS cmd resp
      wifi: iwlwifi: add WIKO to PPAG approved list
      wifi: iwlwifi: extend TAS_CONFIG cmd support for v5
      wifi: iwlwifi: mvm: handle version 3 GET_TAS_STATUS notification
      wifi: iwlwifi: mvm: remove unused tas_rsp variable

Anna Emese Nyiri (4):
      sock: Introduce sk_set_prio_allowed helper function
      sock: support SO_PRIORITY cmsg
      selftests: net: test SO_PRIORITY ancillary data with cmsg_sender
      sock: Introduce SO_RCVPRIORITY socket option

Antoine Tenart (2):
      net: avoid race between device unregistration and ethnl ops
      netfilter: br_netfilter: remove unused conditional and dead code

Antonio Quartulli (1):
      MAINTAINERS: mailmap: add entries for Antonio Quartulli

Ariel Otilibili (2):
      can: dev: can_get_state_str(): Remove dead code
      wifi: rt2x00: Remove unused rfval values

Arnd Bergmann (1):
      octeontx2-af: fix build regression without CONFIG_DCB

Balaji Pothunoori (2):
      wifi: ath11k: Suspend hardware before firmware mode off for WCN6750
      wifi: ath11k: Fix unexpected return buffer manager error for WCN6750/WCN6855

Baochen Qiang (1):
      wifi: ath12k: fix leaking michael_mic for non-primary links

Barnabás Czémán (1):
      wifi: wcn36xx: fix channel survey memory allocation size

Bastien Curutchet (2):
      selftests/bpf: test_xdp_meta: Rename BPF sections
      selftests/bpf: Migrate test_xdp_meta.sh into xdp_context_test_run.c

Ben Greear (2):
      wifi: mt76: mt7996: Add eht radiotap tlv
      wifi: mt76: Fix EHT NSS radiotap reporting.

Ben Shelton (1):
      ice: Add MDD logging via devlink health

Benjamin Berg (13):
      wifi: iwlwifi: mvm: log error for failures after D3
      wifi: iwlwifi: mvm: skip short statistics window when updating EMLSR
      wifi: mac80211: Remove unused basic_rates variable
      wifi: mac80211: fix typo in HE MCS check
      wifi: mac80211: log link information in ieee80211_determine_chan_mode
      wifi: mac80211: skip all known membership selectors
      wifi: mac80211: parse BSS selectors and unknown rates
      wifi: nl80211: permit userspace to pass supported selectors
      wifi: mac80211: verify BSS membership selectors and basic rates
      wifi: mac80211: also verify requirements in EXT_SUPP_RATES
      wifi: mac80211: tests: add utility to create sdata skeleton
      wifi: mac80211: pass correct link ID on assoc
      wifi: mac80211: set key link ID to the deflink one

Benjamin Lin (2):
      wifi: mt76: mt7996: fix incorrect indexing of MIB FW event
      wifi: mt76: mt7996: fix definition of tx descriptor

Bhagavathi Perumal S (1):
      wifi: ath12k: Add MLO WMI setup and teardown functions

Bharat Bhushan (9):
      octeontx2-pf: map skb data as device writeable
      octeontx2-pf: Move skb fragment map/unmap to common code
      octeontx2-af: Disable backpressure between CPT and NIX
      cn10k-ipsec: Init hardware for outbound ipsec crypto offload
      cn10k-ipsec: Add SA add/del support for outb ipsec crypto offload
      cn10k-ipsec: Process outbound ipsec crypto offload
      cn10k-ipsec: Allow ipsec crypto offload for skb with SA
      cn10k-ipsec: Enable outbound ipsec crypto offload
      cn10k-ipsec: Fix compilation error when CONFIG_XFRM_OFFLOAD disabled

Bitterblue Smith (12):
      wifi: rtw88: usb: Support USB 3 with RTL8812AU
      wifi: rtw88: usb: Enable RX aggregation for 8821au/8812au
      wifi: rtlwifi: rtl8821ae: Fix media status report
      wifi: rtw88: 8812a: Support RFE type 2
      wifi: rtw88: 8821a/8812a: Set ptct_efuse_size to 0
      wifi: rtw88: usb: Copy instead of cloning the RX skb
      wifi: rtw88: Handle C2H_ADAPTIVITY in rtw_fw_c2h_cmd_handle()
      wifi: rtw88: usb: Preallocate and reuse the RX skbs
      wifi: rtl8xxxu: Fix RTL8188EU firmware upload block size
      wifi: rtw88: Add USB PHY configuration
      wifi: rtw88: Delete rf_type member of struct rtw_sta_info
      wifi: rtw88: Add support for LED blinking

Breno Leitao (5):
      netpoll: Use rtnl_dereference() for npinfo pointer access
      netconsole: Warn if MAX_USERDATA_ITEMS limit is exceeded
      netconsole: selftest: Split the helpers from the selftest
      netconsole: selftest: Delete all userdata keys
      netconsole: selftest: verify userdata entry limit

Brett Creeley (3):
      ionic: Use VLAN_ETH_HLEN when possible
      ionic: Translate IONIC_RC_ENOSUPP to EOPNOTSUPP
      ionic: remove the unused nb_work

Carolina Jubran (2):
      net/mlx5: Add support for new scheduling elements
      net/mlx5: Remove PTM support log message

Chad Monroe (2):
      wifi: mt76: mt7915: exclude tx backoff time from airtime
      wifi: mt76: mt7996: exclude tx backoff time from airtime

Charan Pedumuru (1):
      dt-bindings: net: can: atmel: Convert to json schema

Charles Han (2):
      wifi: mt76: mt7925: fix NULL deref check in mt7925_change_vif_links
      Bluetooth: btbcm: Fix NULL deref in btbcm_get_board_name()

Cheng Jiang (3):
      dt-bindings: net: bluetooth: qca: Expand firmware-name property
      Bluetooth: qca: Update firmware-name to support board specific nvm
      Bluetooth: qca: Expand firmware-name to load specific rampatch

Chih-Kang Chang (5):
      wifi: rtw89: 8922a: use RSSI from PHY report in RX descriptor
      wifi: rtw89: add crystal_cap check to avoid setting as overflow value
      wifi: rtw89: 8922a: update format of RFK pre-notify H2C command v2
      wifi: rtw89: adjust thermal protection step and more RTL8852BE-VT ID
      wifi: rtw89: avoid to init mgnt_entry list twice when WoWLAN failed

Chin-Yen Lee (1):
      wifi: rtw89: pci: disable PCI completion timeout control

Christian Hopps (15):
      xfrm: config: add CONFIG_XFRM_IPTFS
      include: uapi: protocol number and packet structs for AGGFRAG in ESP
      xfrm: netlink: add config (netlink) options
      xfrm: add mode_cbs module functionality
      xfrm: add generic iptfs defines and functionality
      xfrm: iptfs: add new iptfs xfrm mode impl
      xfrm: iptfs: add user packet (tunnel ingress) handling
      xfrm: iptfs: share page fragments of inner packets
      xfrm: iptfs: add fragmenting of larger than MTU user packets
      xfrm: iptfs: add basic receive packet (tunnel egress) handling
      xfrm: iptfs: handle received fragmented inner packets
      xfrm: iptfs: add reusing received skb for the tunnel egress packet
      xfrm: iptfs: add skb-fragment sharing code
      xfrm: iptfs: handle reordering of received packets
      xfrm: iptfs: add tracepoint functionality

Christophe JAILLET (3):
      wifi: wlcore: testmode: Constify strutc nla_policy
      wifi: mt76: mt7915: Fix an error handling path in mt7915_add_interface()
      net: phy: Constify struct mdio_device_id

ChunHao Lin (2):
      r8169: add support for RTL8125D rev.b
      r8169: add support for RTL8125BP rev.b

Colin Ian King (4):
      wifi: rtlwifi: rtl8821ae: phy: restore removed code to fix infinite loop
      wifi: ath12k: Fix spelling mistake "requestted" -> "requested"
      net: phy: dp83822: Fix typo "outout" -> "output"
      net/mlx5: fix unintentional sign extension on shift of dest_attr->vport.vhca_id

Cosmin Ratiu (5):
      net/mlx5: ifc: Reorganize mlx5_ifc_flow_table_context_bits
      net/mlx5: qos: Add ifc support for cross-esw scheduling
      net/mlx5e: CT: Add initial support for Hardware Steering
      net/mlx5e: CT: Make mlx5_ct_fs_smfs_ct_validate_flow_rule reusable
      net/mlx5e: CT: Offload connections with hardware steering rules

Dan Carpenter (5):
      wifi: ath12k: Off by one in ath12k_wmi_process_csa_switch_count_event()
      net/smc: delete pointless divide by one
      wifi: mt76: mt7925: fix off by one in mt7925_load_clc()
      wifi: mac80211: fix memory leak in ieee80211_mgd_assoc_ml_reconf()
      tipc: re-order conditions in tipc_crypto_key_rcv()

Daniel Borkmann (3):
      netkit: Allow for configuring needed_{head,tail}room
      netkit: Add add netkit {head,tail}room to rt_link.yaml
      selftests/bpf: Extend netkit tests to validate set {head,tail}room

Daniel Gabay (6):
      wifi: iwlwifi: Remove mvm prefix from iwl_mvm_compressed_ba_notif
      wifi: iwlwifi: mvm: Check BAR packet size before accessing data
      wifi: iwlwifi: mvm: Use IWL_FW_CHECK() for BAR notif size validation
      wifi: iwlwifi: mvm: Move TSO code to shared utility
      wifi: iwlwifi: Remove MVM prefix from TX API macros
      wifi: iwlwifi: mvm: don't count mgmt frames as MPDU

Daniel Golle (4):
      net: pcs: pcs-mtk-lynxi: correctly report in-band status capabilities
      net: phy: realtek: clear 1000Base-T lpa if link is down
      net: phy: realtek: clear master_slave_state if link is down
      net: phy: realtek: always clear NBase-T lpa

Daniel Machon (14):
      net: sparx5: do some preparation work
      net: sparx5: add function for RGMII port check
      net: sparx5: use is_port_rgmii() throughout
      net: sparx5: skip low-speed configuration when port is RGMII
      net: sparx5: only return PCS for modes that require it
      net: sparx5: verify RGMII speeds
      net: lan969x: add RGMII registers
      net: lan969x: add RGMII implementation
      dt-bindings: net: sparx5: document RGMII delays
      net: sparx5: enable FDMA on lan969x
      net: sparx5: split sparx5_fdma_{start(),stop()}
      net: sparx5: activate FDMA tx in start()
      net: sparx5: ops out certain FDMA functions
      net: lan969x: add FDMA implementation

Dario Binacchi (2):
      can: sun4i_can: continue to use likely() to check skb
      dt-bindings: can: st,stm32-bxcan: fix st,gcan property type

David Howells (41):
      ktime: Add us_to_ktime()
      rxrpc: Fix handling of received connection abort
      rxrpc: Use umin() and umax() rather than min_t()/max_t() where possible
      rxrpc: Clean up Tx header flags generation handling
      rxrpc: Don't set the MORE-PACKETS rxrpc wire header flag
      rxrpc: Show stats counter for received reason-0 ACKs
      rxrpc: Request an ACK on impending Tx stall
      rxrpc: Use a large kvec[] in rxrpc_local rather than every rxrpc_txbuf
      rxrpc: Implement path-MTU probing using padded PING ACKs (RFC8899)
      rxrpc: Separate the packet length from the data length in rxrpc_txbuf
      rxrpc: Prepare to be able to send jumbo DATA packets
      rxrpc: Add a tracepoint to show variables pertinent to jumbo packet size
      rxrpc: Fix CPU time starvation in I/O thread
      rxrpc: Fix injection of packet loss
      rxrpc: Only set DF=1 on initial DATA transmission
      rxrpc: Timestamp DATA packets before transmitting them
      rxrpc: Don't need barrier for ->tx_bottom and ->acks_hard_ack
      rxrpc: Implement progressive transmission queue struct
      rxrpc: call->acks_hard_ack is now the same call->tx_bottom, so remove it
      rxrpc: Replace call->acks_first_seq with tracking of the hard ACK point
      rxrpc: Display stats about jumbo packets transmitted and received
      rxrpc: Adjust names and types of congestion-related fields
      rxrpc: Use the new rxrpc_tx_queue struct to more efficiently process ACKs
      rxrpc: Store the DATA serial in the txqueue and use this in RTT calc
      rxrpc: Don't use received skbuff timestamps
      rxrpc: Generate rtt_min
      rxrpc: Adjust the rxrpc_rtt_rx tracepoint
      rxrpc: Display userStatus in rxrpc_rx_ack trace
      rxrpc: Fix the calculation and use of RTO
      rxrpc: Fix initial resend timeout
      rxrpc: Send jumbo DATA packets
      rxrpc: Don't allocate a txbuf for an ACK transmission
      rxrpc: Use irq-disabling spinlocks between app and I/O thread
      rxrpc: Tidy up the ACK parsing a bit
      rxrpc: Add a reason indicator to the tx_data tracepoint
      rxrpc: Add a reason indicator to the tx_ack tracepoint
      rxrpc: Manage RTT per-call rather than per-peer
      rxrpc: Fix request for an ACK when cwnd is minimum
      rxrpc: Implement RACK/TLP to deal with transmission stalls [RFC8985]
      rxrpc: Disable IRQ, not BH, to take the lock for ->attend_link
      rxrpc: Fix ability to add more data to a call once MSG_MORE deasserted

David S. Miller (7):
      Merge branch 'ucc_geth-phylink-conversion'
      Merge branch 'cn10k-ipswec-outbound-inline-support'
      Merge branch 'dp83822-gpio2'
      Merge branch 'tls1.3-key-updates'
      Merge branch 'net-timestamp-selectable'
      Merge tag 'ipsec-next-2025-01-09' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next
      Merge branch 'realtek-link-down'

Deming Wang (1):
      wifi: iwlwifi: api: remove the double word

Denis Kirjanov (1):
      sysctl net: Remove macro checks for CONFIG_SYSCTL

Dimitri Fedrau (4):
      net: phy: dp83822: Replace DP83822_DEVADDR with MDIO_MMD_VEND2
      dt-bindings: net: dp83822: Add support for GPIO2 clock output
      net: phy: dp83822: Add support for GPIO2 clock output
      net: phy: dp83822: Add support for PHY LEDs on DP83822

Dinesh Karthikeyan (4):
      wifi: ath12k: Support Downlink Pager Stats
      wifi: ath12k: Support phy counter and TPC stats
      wifi: ath12k: Support SoC Common Stats
      wifi: ath12k: Support Transmit PER Rate Stats

Divya Koppera (9):
      net: phy: microchip_rds_ptp: Add header file for Microchip rds ptp library
      net: phy: microchip_rds_ptp : Add rds ptp library for Microchip phys
      net: phy: Kconfig: Add rds ptp library support and 1588 optional flag in Microchip phys
      net: phy: Makefile: Add makefile support for rds ptp in Microchip phys
      net: phy: microchip_t1 : Add initialization of ptp for lan887x
      net: phy: microchip_t1: depend on PTP_1588_CLOCK_OPTIONAL
      net: phy: microchip_rds_ptp: Header file library changes for PEROUT
      net: phy: microchip_t1: Enable pin out specific to lan887x phy for PEROUT signal
      net: phy: microchip_rds_ptp : Add PEROUT feature library for RDS PTP supported Microchip phys

Dmitry Antipov (11):
      wifi: ath9k: miscellaneous spelling fixes
      wifi: ath11k: cleanup struct ath11k_vif
      wifi: ath11k: cleanup struct ath11k_reg_tpc_power_info
      wifi: ath11k: cleanup struct ath11k_mon_data
      wifi: ath11k: miscellaneous spelling fixes
      wifi: brcmsmac: add gain range check to wlc_phy_iqcal_gainparams_nphy()
      wifi: ath9k: cleanup ath_txq_skb_done()
      wifi: ath9k: cleanup a few (mostly) TX-related routines
      wifi: ath9k: simplify internal time management
      wifi: ath9k: cleanup ath9k_hw_get_nf_hist_mid()
      wifi: cfg80211: adjust allocation of colocated AP data

Donald Hunter (4):
      netlink: specs: add uint, sint to netlink-raw schema
      netlink: specs: add phys-binding attr to rt_link spec
      tools/net/ynl: add support for --family and --list-families
      tools/net/ynl: ethtool: support spec load from install location

Dr. David Alan Gilbert (28):
      gve: Remove unused gve_adminq_set_mtu
      isdn: Remove unused get_Bprotocol4id()
      net: Remove bouncing hippi list
      net: hisilicon: hns: Remove unused hns_dsaf_roce_reset
      net: hisilicon: hns: Remove unused hns_rcb_start
      net: hisilicon: hns: Remove reset helpers
      net: hisilicon: hns: Remove unused enums
      net: mac802154: Remove unused ieee802154_mlme_tx_one
      i40e: Deadcode i40e_aq_*
      i40e: Remove unused i40e_blink_phy_link_led
      i40e: Remove unused i40e_(read|write)_phy_register
      i40e: Deadcode profile code
      i40e: Remove unused i40e_get_cur_guaranteed_fd_count
      i40e: Remove unused i40e_del_filter
      i40e: Remove unused i40e_commit_partition_bw_setting
      i40e: Remove unused i40e_asq_send_command_v2
      i40e: Remove unused i40e_dcb_hw_get_num_tc
      igc: Remove unused igc_acquire/release_nvm
      igc: Remove unused igc_read/write_pci_cfg wrappers
      igc: Remove unused igc_read/write_pcie_cap_reg
      ixgbevf: Remove unused ixgbevf_hv_mbx_ops
      intel/fm10k: Remove unused fm10k_iov_msg_mac_vlan_pf
      wifi: iwlegacy: Remove unused il3945_calc_db_from_ratio()
      wifi: iwlegacy: Remove unused il_get_single_channel_number()
      wifi: mac80211: Clean up debugfs_key deadcode
      wifi: mac80211: Remove unused ieee80211_smps_is_restrictive
      socket: Remove unused kernel_sendmsg_locked
      Bluetooth: hci: Remove deadcode

Dylan Eskew (1):
      wifi: mac80211: ethtool: add monitor channel reporting

Easwar Hariharan (2):
      nfp: Convert timeouts to secs_to_jiffies()
      gve: Convert timeouts to secs_to_jiffies()

Emmanuel Grumbach (9):
      wifi: iwlwifi: add a new NMI type
      wifi: iwlwifi: mvm: rename iwl_dev_tx_power_common::mac_context_id
      wifi: iwlwifi: move fw_ver debugfs to firmware runtime
      wifi: iwlwifi: move fw_dbg_collect to fw debugfs
      wifi: iwlwifi: cleanup unused variable in trans.h
      wifi: iwlwifi: mvm: remove unneeded NULL pointer checks
      wifi: mac80211: remove an unneeded check in Rx
      wifi: mac80211: improve stop/wake queue tracing
      wifi: iwlwifi: get the max number of links from the firmware

En-Wei Wu (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3628 for MT7925

Eric Dumazet (34):
      inet: add indirect call wrapper for getfrag() calls
      net_sched: sch_fq: add three drop_reason
      net: tipc: remove one synchronize_net() from tipc_nametbl_stop()
      mctp: no longer rely on net->dev_index_head[]
      rtnetlink: add ndo_fdb_dump_context
      rtnetlink: switch rtnl_fdb_dump() to for_each_netdev_dump()
      rtnetlink: remove pad field in ndo_fdb_dump_context
      ipv6: mcast: reduce ipv6_chk_mcast_addr() indentation
      ipv6: mcast: annotate data-races around mc->mca_sfcount[MCAST_EXCLUDE]
      ipv6: mcast: annotate data-race around psf->sf_count[MCAST_XXX]
      inetpeer: remove create argument of inet_getpeer_v[46]()
      inetpeer: remove create argument of inet_getpeer()
      inetpeer: update inetpeer timestamp in inet_getpeer()
      inetpeer: do not get a refcount in inet_getpeer()
      ptr_ring: do not block hard interrupts in ptr_ring_resize_multiple()
      inetpeer: avoid false sharing in inet_peer_xrlim_allow()
      netfilter: xt_hashlimit: htable_selective_cleanup() optimization
      ax25: rcu protect dev->ax25_ptr
      net: hsr: remove one synchronize_rcu() from hsr_del_port()
      net: watchdog: rename __dev_watchdog_up() and dev_watchdog_down()
      net: no longer reset transport_header in __netif_receive_skb_core()
      net: hsr: remove synchronize_rcu() from hsr_add_port()
      net: sched: calls synchronize_net() only when needed
      tcp: add drop_reason support to tcp_disordered_ack()
      tcp: add TCP_RFC7323_PAWS_ACK drop reason
      tcp: add LINUX_MIB_PAWS_OLD_ACK SNMP counter
      inet: ipmr: fix data-races
      net: expedite synchronize_net() for cleanup_net()
      net: no longer assume RTNL is held in flush_all_backlogs()
      net: no longer hold RTNL while calling flush_all_backlogs()
      net: reduce RTNL hold duration in unregister_netdevice_many_notify() (part 1)
      net: reduce RTNL hold duration in unregister_netdevice_many_notify() (part 2)
      net: destroy dev->lock later in free_netdev()
      net: introduce netdev_napi_exit()

Eric Huang (1):
      wifi: rtw89: ps: update data for firmware and settings for hardware before/after PS

Eric-SY Chang (1):
      wifi: mt76: mt7925: fix wrong band_idx setting when enable sniffer mode

Etienne Champetier (2):
      ipvlan: Support bonding events
      selftests: bonding: add ipvlan over bond testing

Fedor Pchelkin (1):
      Bluetooth: L2CAP: handle NULL sock pointer in l2cap_sock_alloc

Felix Fietkau (37):
      wifi: mt76: remove mt76_calculate_default_rate()
      wifi: mt76: mt7996: remove phy->monitor_vif
      wifi: mt76: mt7915: fix slot time for 5/6GHz
      wifi: mt76: mt7915: fix eifs value on older chipsets
      wifi: mt76: mt7996: fix rx filter setting for bfee functionality
      wifi: mt76: mt7915: reduce the number of command retries
      wifi: mt76: mt7915: decrease timeout for commonly issued MCU commands
      wifi: mt76: only enable tx worker after setting the channel
      wifi: mt76: mt7915: ensure that only one sta entry is active per mac address
      wifi: mt76: mt7915: hold dev->mutex while interacting with the thermal state
      wifi: mt76: mt7915: firmware restart on devices with a second pcie link
      wifi: mt76: mt7915: fix omac index assignment after hardware reset
      wifi: mt76: mt7996: use mac80211 .sta_state op
      wifi: mt76: do not add wcid entries to sta poll list during MCU reset
      wifi: mt76: add code for emulating hardware scanning
      wifi: mt76: add support for allocating a phy without hw
      wifi: mt76: rename struct mt76_vif to mt76_vif_link
      wifi: mt76: add vif link specific data structure
      wifi: mt76: mt7996: split link specific data from struct mt7996_vif
      wifi: mt76: initialize more wcid fields mt76_wcid_init
      wifi: mt76: add chanctx functions for multi-channel phy support
      wifi: mt76: remove dev->wcid_phy_mask
      wifi: mt76: add multi-radio support to a few core hw ops
      wifi: mt76: add multi-radio support to tx scheduling
      wifi: mt76: add multi-radio support to scanning code
      wifi: mt76: add multi-radio remain_on_channel functions
      wifi: mt76: mt7996: use emulated hardware scan support
      wifi: mt76: mt7996: pass wcid to mt7996_mcu_sta_hdr_trans_tlv
      wifi: mt76: mt7996: prepare mt7996_mcu_add_dev/bss_info for MLO support
      wifi: mt76: mt7996: prepare mt7996_mcu_add_beacon for MLO support
      wifi: mt76: mt7996: prepare mt7996_mcu_set_tx for MLO support
      wifi: mt76: mt7996: prepare mt7996_mcu_set_timing for MLO support
      wifi: mt76: connac: prepare mt76_connac_mcu_sta_basic_tlv for MLO support
      wifi: mt76: mt7996: prepare mt7996_mcu_update_bss_color for MLO support
      wifi: mt76: mt7996: move all debugfs files to the primary phy
      wifi: mt76: mt7996: switch to single multi-radio wiphy
      wifi: mt76: mt7996: fix monitor mode

Fiona Klute (1):
      wifi: rtw88: sdio: Fix disconnection after beacon loss

Florent Revest (1):
      af_unix: Add a prompt to CONFIG_AF_UNIX_OOB

Florian Westphal (6):
      ipvs: speed up reads from ip_vs_conn proc file
      netfilter: conntrack: add conntrack event timestamp
      netfilter: nft_flow_offload: clear tcp MAXACK flag before moving to slowpath
      netfilter: nft_flow_offload: update tcp state flags under lock
      netfilter: conntrack: remove skb argument from nf_ct_refresh
      netfilter: conntrack: rework offload nf_conn timeout extension logic

Frederic Weisbecker (1):
      net: pktgen: Use kthread_create_on_cpu()

Furong Xu (11):
      net: stmmac: Relocate extern declarations in common.h and hwif.h
      net: stmmac: Drop redundant dwxgmac_tc_ops variable
      net: stmmac: Drop useless code related to ethtool rx-copybreak
      net: stmmac: TSO: Simplify the code flow of DMA descriptor allocations
      net: stmmac: Set dma_sync_size to zero for discarded frames
      net: stmmac: Unexport stmmac_rx_offset() from stmmac.h
      net: stmmac: Switch to zero-copy in non-XDP RX path
      net: stmmac: Set page_pool_params.max_len to a precise size
      net: stmmac: Optimize cache prefetch in RX path
      net: stmmac: Convert prefetch() to net_prefetch() for received frames
      net: stmmac: Drop redundant skb_mark_for_recycle() for SKB frags

Gan Jie (1):
      wifi: iwlwifi: fw: fix typo 'adderss'

Garrett Wilke (2):
      Bluetooth: btusb: Add MT7921e device 13d3:3576
      Bluetooth: btusb: Add RTL8851BE device 13d3:3600

Geert Uytterhoeven (1):
      ethernet: Make OA_TC6 config symbol invisible

Geliang Tang (9):
      mptcp: add mptcp_userspace_pm_lookup_addr helper
      mptcp: add mptcp_for_each_userspace_pm_addr macro
      mptcp: add mptcp_userspace_pm_get_sock helper
      mptcp: move mptcp_pm_remove_addrs into pm_userspace
      mptcp: drop free_list for deleting entries
      mptcp: change local addr type of subflow_destroy
      mptcp: drop useless "err = 0" in subflow_destroy
      mptcp: fix for setting remote ipv4mapped address
      selftests: mptcp: sockopt: save nstat infos

Gerhard Engleder (1):
      tsnep: Link queues to NAPIs

Guangguan Wang (3):
      net/smc: support SMC-R V2 for rdma devices with max_recv_sge equals to 1
      net/smc: support ipv4 mapped ipv6 addr client for smc-r v2
      net/smc: fix data error when recvmsg with MSG_PEEK flag

Guillaume Nault (15):
      vrf: Make pcpu_dstats update functions available to other modules.
      vxlan: Handle stats using NETDEV_PCPU_STAT_DSTATS.
      geneve: Handle stats using NETDEV_PCPU_STAT_DSTATS.
      bareudp: Handle stats using NETDEV_PCPU_STAT_DSTATS.
      gre: Drop ip_route_output_gre().
      ipv4: Define inet_sk_init_flowi4() and use it in inet_sk_rebuild_header().
      ipv4: Use inet_sk_init_flowi4() in ip4_datagram_release_cb().
      ipv4: Use inet_sk_init_flowi4() in inet_csk_rebuild_route().
      ipv4: Use inet_sk_init_flowi4() in __ip_queue_xmit().
      l2tp: Use inet_sk_init_flowi4() in l2tp_ip_sendmsg().
      sctp: Prepare sctp_v4_get_dst() to dscp_t conversion.
      gre: Prepare ipgre_open() to .flowi4_tos conversion.
      ipv4: Prepare inet_rtm_getroute() to .flowi4_tos conversion.
      dccp: Prepare dccp_v4_route_skb() to .flowi4_tos conversion.
      gtp: Prepare ip4_route_output_gtp() to .flowi4_tos conversion.

Hans de Goede (1):
      wifi: rtl8xxxu: add more missing rtl8192cu USB IDs

Hao Qin (1):
      Bluetooth: btmtk: Remove resetting mt7921 before downloading the fw

Hao Zhang (1):
      wifi: mt76: mt792x: add P2P_DEVICE support

Heiner Kallweit (12):
      r8169: remove unused flag RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE
      r8169: remove support for chip version 11
      r8169: simplify setting hwmon attribute visibility
      r8169: adjust version numbering for RTL8126
      net: phy: add phy_disable_eee
      net: ethernet: ti: cpsw: disable PHY EEE advertisement
      net: phy: fix phy_disable_eee
      net: phy: micrel: use helper phy_disable_eee
      net: phy: realtek: add support for reading MDIO_MMD_VEND2 regs on RTL8125/RTL8126
      net: phy: move realtek PHY driver to its own subdirectory
      net: phy: realtek: add hwmon support for temp sensor on RTL822x
      net: phy: remove leftovers from switch to linkmode bitmaps

Hongguang Gao (1):
      bnxt_en: Use FW defined resource limits for RoCE

Howard Hsu (4):
      wifi: mt76: mt7996: fix the capability of reception of EHT MU PPDU
      wifi: mt76: mt7996: fix HE Phy capability
      wifi: mt76: connac: adjust phy capabilities based on band constraints
      wifi: mt76: mt7996: add implicit beamforming support for mt7992

Hsin-chen Chuang (3):
      Bluetooth: Remove the cmd timeout count in btusb
      Bluetooth: Get rid of cmd_timeout and use the reset callback
      Bluetooth: Allow reset via sysfs

Ido Schimmel (11):
      mlxsw: spectrum_flower: Do not allow mixing sample and mirror actions
      mlxsw: Switch to napi_gro_receive()
      net: fib_rules: Add flow label selector attributes
      ipv4: fib_rules: Reject flow label attributes
      ipv6: fib_rules: Add flow label support
      net: fib_rules: Enable flow label selector usage
      netlink: specs: Add FIB rule flow label attributes
      ipv6: Add flow label to route get requests
      netlink: specs: Add route flow label attribute
      tracing: ipv6: Add flow label to fib6_table_lookup tracepoint
      selftests: fib_rule_tests: Add flow label selector match tests

Ilan Peer (9):
      wifi: ieee80211: Add some missing MLO related definitions
      wifi: nl80211: Split the links handling of an association request
      wifi: cfg80211: Add support for dynamic addition/removal of links
      wifi: mac80211: Refactor adding association elements
      wifi: mac80211: Pull link space calculation to a function
      wifi: mac80211: Support dynamic link addition and removal
      wifi: cfg80211: Add support for controlling EPCS
      wifi: mac80211: Fix common size calculation for ML element
      wifi: mac80211: Support parsing EPCS ML element

Itamar Gozlan (2):
      net/mlx5: DR, expand SWS STE callbacks and consolidate common structs
      net/mlx5: DR, add support for ConnectX-8 steering

Iulia Tanasescu (1):
      Bluetooth: iso: Allow BIG re-sync

Jacob Keller (12):
      lib: packing: document recently added APIs
      ice: remove int_q_state from ice_tlan_ctx
      ice: use structures to keep track of queue context size
      ice: use <linux/packing.h> for Tx and Rx queue context data
      ice: reduce size of queue context fields
      ice: move prefetch enable to ice_setup_rx_ctx
      ice: cleanup Rx queue context programming functions
      ice: use read_poll_timeout_atomic in ice_read_phy_tstamp_ll_e810
      ice: rename TS_LL_READ* macros to REG_LL_PROXY_H_*
      ice: add lock to protect low latency interface
      ice: check low latency PHY timer update firmware capability
      ice: implement low latency PHY timer updates

Jakub Kicinski (157):
      Revert "ptp: Switch back to struct platform_driver::remove()"
      Merge branch 'netcons-add-udp-send-fail-statistics-to-netconsole'
      Merge branch 'net-add-negotiation-of-in-band-capabilities'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'ethtool-generate-uapi-header-from-the-spec'
      Merge branch 'net_sched-sch_sfq-reject-limit-of-1'
      Merge branch 'xdp-a-fistful-of-generic-changes-pt-i'
      Merge branch 'net-phylib-eee-cleanups'
      Merge branch 'lan78xx-preparations-for-phylink'
      Merge branch 'net-convert-some-udp-tunnel-drivers-to-netdev_pcpu_stat_dstats'
      Merge branch 'net-net-add-negotiation-of-in-band-capabilities-remainder'
      Merge branch 'rxrpc-implement-jumbo-data-transmission-and-rack-tlp'
      net: reformat kdoc return statements
      Merge branch 'vxlan-support-user-defined-reserved-bits'
      Merge branch 'add-support-for-synopsis-dwmac-ip-on-nxp-automotive-socs-s32g2xx-s32g3xx-s32r45'
      Merge branch 'dsa-mv88e6xxx-refactor-statistics-ready-for-rmu-support'
      Merge branch 'net-prepare-for-removal-of-net-dev_index_head'
      Merge branch 'lan78xx-preparations-for-phylink'
      Merge branch 'lib-packing-introduce-and-use-un-pack_fields'
      Merge branch 'ipv6-mcast-add-data-race-annotations'
      Merge branch 'make-time-wait-reuse-delay-deterministic-and-configurable'
      Merge branch 'net-dsa-cleanup-eee-part-1'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'xdp-a-fistful-of-generic-changes-pt-ii'
      Merge branch 'devmem-tcp-fixes'
      Merge branch 'mptcp-pm-userspace-misc-cleanups'
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge branch 'add-support-for-so_priority-cmsg'
      Merge branch 'r8169-add-support-for-rtl8125d-rev-b'
      net: page_pool: rename page_pool_is_last_ref()
      Merge branch 'net-constify-struct-bin_attribute'
      Merge branch 'inetpeer-reduce-false-sharing-and-atomic-operations'
      Merge branch 'lan78xx-preparations-for-phylink'
      Merge branch 'support-some-features-for-the-hibmcge-driver'
      Merge branch 'selftests-net-packetdrill-import-multiple-tests'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'mdio-support-updates'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'bnxt_en-driver-update'
      net: netlink: catch attempts to send empty messages
      Merge tag 'wireless-next-2024-12-19' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'net-add-and-use-phy_disable_eee'
      Merge branch 'xdp-a-fistful-of-generic-changes-pt-iii'
      Merge branch 'hisilicon-hns-deadcoding'
      Merge branch 'bridge-handle-changes-in-vlan_flag_bridge_binding'
      Merge branch 'ipv4-consolidate-route-lookups-from-ipv4-sockets'
      Merge branch 'add-more-feautues-for-enetc-v4-round-1'
      Merge branch 'net-bridge-add-skb-drop-reasons-to-the-most-common-drop-points'
      selftests: drv-net: assume stats refresh is 0 if no ethtool -c support
      Merge branch 'vsock-test-tests-for-memory-leaks'
      Merge branch 'add-rds-ptp-library-for-microchip-phys'
      Merge branch 'mlx5-misc-changes-2024-12-19'
      eth: fbnic: reorder ethtool code
      eth: fbnic: don't reset the secondary RSS indir table
      eth: fbnic: store NAPIs in an array instead of the list
      eth: fbnic: add IRQ reuse support
      eth: fbnic: support ring channel get and set while down
      eth: fbnic: support ring channel set while up
      Merge branch 'eth-fbnic-support-basic-rss-config-and-setting-channel-count'
      Merge branch '10GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'net-lan969x-add-rgmii-support'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'ieee802154-for-net-next-2025-01-03' of git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next
      Merge branch 'i40e-deadcoding'
      Merge branch 'igc-deadcoding'
      Merge branch 'net-pcs-add-supported_interfaces-bitmap-for-pcs'
      Merge branch 'mlx5-hardware-steering-part-2'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'net-hold-per-netns-rtnl-during-netdev-notifier-registration'
      Merge branch 'net-dsa-cleanup-eee-part-2'
      if_vlan: fix kdoc warnings
      tools: ynl: correctly handle overrides of fields in subset
      tools: ynl: print some information about attribute we can't parse
      netlink: specs: rt_link: decode ip6tnl, vti and vti6 link attrs
      Merge branch 'tools-ynl-decode-link-types-present-in-tests'
      Merge branch 'intel-wired-lan-driver-updates-2025-01-06-igb-igc-ixgbe-ixgbevf-i40e-fm10k'
      selftests: drv-net: test drivers sleeping in ndo_get_stats64
      net: make sure we retain NAPI ordering on netdev->napi_list
      netdev: define NETDEV_INTERNAL
      netdevsim: support NAPI config
      netdevsim: allocate rqs individually
      netdevsim: add queue alloc/free helpers
      netdevsim: add queue management API support
      netdevsim: add debugfs-triggered queue reset
      selftests: net: test listing NAPI vs queue resets
      Merge branch 'enic-set-link-speed-only-after-link-up'
      tools: ynl-gen-c: improve support for empty nests
      Merge branch 'tools-ynl-add-install-target'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'netconsole-selftest-for-userdata-overflow'
      Merge branch 'net-stmmac-clean-up-and-fix-eee-implementation'
      Merge branch 'ipvlan-support-bonding-events'
      net: warn during dump if NAPI list is not sorted
      net: hide the definition of dev_get_by_napi_id()
      Merge tag 'linux-can-next-for-6.14-20250110' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      can: grcan: move napi_enable() from under spin lock
      net: remove init_dummy_netdev()
      net: cleanup init_dummy_netdev_core()
      eth: iavf: extend the netdev_lock usage
      Merge branch 'mlx5-hw-managed-flow-steering-in-fs-core-level'
      net: ethtool: plumb PHY stats to PHY drivers
      net: ethtool: add support for structured PHY statistics
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge branch 'tcp-add-a-new-paws_ack-drop-reason'
      docs: netdev: document requirements for Supported status
      MAINTAINERS: downgrade Ethernet NIC drivers without CI reporting
      Merge branch 'net-phy-realtek-add-hwmon-support'
      Merge branch 'net-ethernet-simplify-few-things'
      Merge branch 'net-stmmac-further-eee-cleanups-and-one-fix'
      Merge branch 'net-bcm-asp2-fix-fallout-from-phylib-eee-changes'
      Merge branch 'mptcp-selftests-more-debug-in-case-of-errors'
      Merge branch 'net-phylink-fix-pcs-without-autoneg'
      Merge branch 'net-lan969x-add-fdma-support'
      Merge branch 'eth-fbnic-add-hardware-monitoring-support'
      Merge branch 'bnxt_en-implement-tcp-data-split-and-thresh-option'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      net: add netdev_lock() / netdev_unlock() helpers
      net: make netdev_lock() protect netdev->reg_state
      net: add helpers for lookup and walking netdevs under netdev_lock()
      net: add netdev->up protected by netdev_lock()
      net: protect netdev->napi_list with netdev_lock()
      net: protect NAPI enablement with netdev_lock()
      net: make netdev netlink ops hold netdev_lock()
      net: protect threaded status of NAPI with netdev_lock()
      net: protect napi->irq with netdev_lock()
      net: protect NAPI config fields with netdev_lock()
      netdev-genl: remove rtnl_lock protection from NAPI ops
      Merge branch 'net-use-netdev-lock-to-protect-napi'
      Merge branch 'net-reduce-rtnl-pressure-in-unregister_netdevice'
      Merge branch 'net-mlx5e-ct-add-support-for-hardware-steering'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'dev-covnert-dev_change_name-to-per-netns-rtnl'
      Merge branch 'net-add-phylink-managed-eee-support'
      selftests/net: packetdrill: make tcp buf limited timing tests benign
      Merge branch 'add-perout-library-for-rds-ptp-supported-phys'
      selftests: net: give up on the cmsg_time accuracy on slow machines
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'mlxsw-move-tx-header-handling-to-pci-driver'
      Merge branch 'ethtool-get_ts_stats-for-dsa-and-ocelot-driver'
      Merge branch 'net-xilinx-axienet-enable-adaptive-irq-coalescing-with-dim'
      Merge branch 'fix-race-conditions-in-ndo_get_stats64'
      eth: bnxt: fix string truncation warning in FW version
      Merge tag 'wireless-next-2025-01-17' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge tag 'for-net-next-2025-01-15' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Merge tag 'batadv-next-pullrequest-20250117' of git://git.open-mesh.org/linux-merge
      Merge branch 'af_unix-set-skb-drop-reason-in-every-kfree_skb-path'
      net: move HDS config from ethtool state
      net: ethtool: store netdev in a temp variable in ethnl_default_set_doit()
      net: provide pending ring configuration in net_device
      eth: bnxt: apply hds_thrs settings correctly
      net: ethtool: populate the default HDS params in the core
      eth: bnxt: allocate enough buffer space to meet HDS threshold
      eth: bnxt: update header sizing defaults
      Merge branch 'net-ethtool-fixes-for-hds-threshold'
      Merge tag 'nf-next-25-01-19' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'ipv6-convert-rtm_-new-del-addr-and-more-to-per-netns-rtnl'
      Merge branch 'net-ethernet-ti-am65-cpsw-streamline-rx-tx-queue-creation-and-cleanup'

Jakub Sitnicki (2):
      tcp: Measure TIME-WAIT reuse delay with millisecond precision
      tcp: Add sysctl to configure TIME-WAIT reuse delay

Jamal Hadi Salim (2):
      selftests: net: remove redundant ncdevmem print
      net: sched: Disallow replacing of child qdisc from one parent to another

James Chapman (1):
      l2tp: Handle eth stats using NETDEV_PCPU_STAT_DSTATS.

Jan Petrous (OSS) (15):
      net: stmmac: Fix CSR divider comment
      net: stmmac: Extend CSR calc support
      net: stmmac: Fix clock rate variables size
      net: phy: Add helper for mapping RGMII link speed to clock rate
      net: dwmac-dwc-qos-eth: Use helper rgmii_clock
      net: dwmac-imx: Use helper rgmii_clock
      net: dwmac-intel-plat: Use helper rgmii_clock
      net: dwmac-rk: Use helper rgmii_clock
      net: dwmac-starfive: Use helper rgmii_clock
      net: macb: Use helper rgmii_clock
      net: xgene_enet: Use helper rgmii_clock
      net: dwmac-sti: Use helper rgmii_clock
      dt-bindings: net: Add DT bindings for DWMAC on NXP S32G/R SoCs
      net: stmmac: dwmac-s32: add basic NXP S32G/S32R glue driver
      MAINTAINERS: Add Jan Petrous as the NXP S32G/R DWMAC driver maintainer

Jan Stancek (4):
      tools: ynl: move python code to separate sub-directory
      tools: ynl: add initial pyproject.toml for packaging
      tools: ynl: add install target for generated content
      tools: ynl: add main install target

Janaki Ramaiah Thota (1):
      dt-bindings: bluetooth: Utilize PMU abstraction for WCN6750

Jason Wang (1):
      wifi: iwlwifi: mvm: Fix duplicated 'if' in comment

Jeff Johnson (9):
      wifi: ath12k: mark QMI driver event helpers as noinline
      wifi: ath11k: mark some QMI driver event helpers as noinline
      wifi: ath11k: mark ath11k_dp_rx_mon_mpdu_pop() as noinline
      wifi: ath11k: mark ath11k_wow_convert_8023_to_80211() as noinline
      wifi: ath12k: Decrease ath12k_mac_op_remain_on_channel() stack usage
      wifi: ath12k: Decrease ath12k_bss_assoc() stack usage
      wifi: ath12k: Decrease ath12k_sta_rc_update_wk() stack usage
      wifi: ath12k: Decrease ath12k_mac_station_assoc() stack usage
      wifi: brcmfmac: Add missing Return: to function documentation

Jesse Van Gavere (1):
      net: dsa: microchip: Make MDIO bus name unique

Jianbo Liu (4):
      xfrm: Support ESN context update to hardware for TX
      net/mlx5e: Update TX ESN context for IPSec hardware offload
      net/mlx5: Update mlx5_ifc to support FEC for 200G per lane link modes
      net/mlx5: Add support for MRTCQ register

Jijie Shao (7):
      net: hibmcge: Add debugfs supported in this module
      net: hibmcge: Add irq_info file to debugfs
      net: hibmcge: Add unicast frame filter supported in this module
      net: hibmcge: Add register dump supported in this module
      net: hibmcge: Add pauseparam supported in this module
      net: hibmcge: Add reset supported in this module
      net: hibmcge: Add nway_reset supported in this module

Jilin Yuan (1):
      wifi: iwlwifi: fw: fix repeated words in comments

Jimmy Assarsson (4):
      can: kvaser_usb: Update stats and state even if alloc_can_err_skb() fails
      can: kvaser_usb: Add support for CAN_CTRLMODE_BERR_REPORTING
      can: kvaser_pciefd: Update stats and state even if alloc_can_err_skb() fails
      can: kvaser_pciefd: Add support for CAN_CTRLMODE_BERR_REPORTING

Joe Damato (3):
      selftests: net: cleanup busy_poller.c
      igc: Link IRQs to NAPI instances
      igc: Link queues to NAPI instances

Johannes Berg (42):
      wifi: cfg80211: define and use wiphy guard
      wifi: mac80211: use wiphy guard
      tools: ynl-gen-c: annotate valid choices for --mode
      tools: ynl-gen-c: don't require -o argument
      wifi: iwlwifi: differentiate NIC error types
      wifi: iwlwifi: mvm: remove warning on unallocated BAID
      wifi: iwlwifi: fw: read STEP table from correct UEFI var
      wifi: iwlwifi: context-info: add kernel-doc markers
      wifi: iwlwifi: return ERR_PTR from opmode start()
      wifi: iwlwifi: restrict driver retry loops to timeouts
      wifi: iwlwifi: mvm: restrict MAC start retry to timeouts
      wifi: iwlwifi: mvm: remove STARTING state
      wifi: iwlwifi: mvm: clean up FW restart a bit
      wifi: iwlwifi: unify cmd_queue_full() into nic_error()
      wifi: iwlwifi: mvm: restart device through NMI
      wifi: iwlwifi: rework firmware error handling
      wifi: iwlwifi: iwl_fw_error_collect() is always called sync
      wifi: iwlwifi: rename bits in config/boot control register
      wifi: iwlwifi: iwl-drv: refactor image loading a bit
      wifi: iwlwifi: mvm: fix add stream vs. restart race
      wifi: iwlwifi: fw: api: tdls: remove MVM_ from name
      wifi: iwlwifi: mvm: fix AP STA comparison
      wifi: mac80211: add some support for RX OMI power saving
      wifi: mac80211: reject per-band vendor elements with MLO
      wifi: mac80211: mlme: improve messages from config_bw()
      wifi: cfg80211: scan: skip duplicate RNR entries
      wifi: cfg80211: check extended MLD capa/ops in assoc
      wifi: mac80211: prohibit deactivating all links
      wifi: iwlwifi: pcie: check for WiAMT/CSME presence
      wifi: iwlwifi: implement product reset for TOP errors
      wifi: iwlwifi: implement reset escalation
      wifi: iwlwifi: mvm: improve/fix chanctx min_def use logic
      wifi: iwlwifi: config: unify fw/pnvm MODULE_FIRMWARE
      wifi: iwlwifi: mvm: support EMLSR on WH/PE
      wifi: iwlwifi: remove Mr/Ms radio
      wifi: iwlwifi: pcie: make _iwl_trans_pcie_gen2_stop_device() static
      wifi: iwlwifi: pcie: make iwl_pcie_d3_complete_suspend() static
      wifi: nl80211: simplify nested if checks
      wifi: iwlwifi: simplify nested if checks
      wifi: mac80211: don't flush non-uploaded STAs
      wifi: mac80211: ibss: stop transmit when merging IBSS
      wifi: mac80211: ibss: mark IBSS left before leaving

John Daley (4):
      enic: Move RX coalescing set function
      enic: Obtain the Link speed only after the link comes up
      enic: Fix typo in comment in table indexed by link speed
      selftests: drv-net-hw: inject pp_alloc_fail errors in the right place

John Ousterhout (1):
      net: tc: improve qdisc error messages

Juan José Arboleda (2):
      wifi: iwlwifi: mvm: Replace spaces for tabs in iwl_mvm_vendor_events_idx
      wifi: iwlwifi: mvm: Improve code style in pointer declarations

Justin Iurman (4):
      include: net: add static inline dst_dev_overhead() to dst.h
      net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue
      net: ipv6: seg6_iptunnel: mitigate 2-realloc issue
      net: ipv6: rpl_iptunnel: mitigate 2-realloc issue

Justin Lai (2):
      rtase: Add support for RTL907XD-VA PCIe port
      rtase: Refine the if statement

Kalle Valo (10):
      wifi: ath12k: ath12k_mac_vdev_create(): use goto for error handling
      wifi: ath12k: introduce ath12k_hw_warn()
      wifi: ath12k: convert struct ath12k::wmi_mgmt_tx_work to struct wiphy_work
      wifi: ath12k: ath12k_mac_op_set_key(): fix uninitialized symbol 'ret'
      wifi: ath12k: ath12k_mac_op_sta_rc_update(): use mac80211 provided link id
      Merge tag 'ath-next-20241209' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'rtw-next-2024-12-12' of https://github.com/pkshih/rtw
      Merge tag 'rtw-next-2025-01-12' of https://github.com/pkshih/rtw
      Merge tag 'mt76-for-kvalo-2025-01-14' of https://github.com/nbd168/wireless
      Merge tag 'ath-next-20250114' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Karol Kolacinski (1):
      ice: Add in/out PTP pin delays

Karol Przybylski (1):
      wifi: ath12k: Fix for out-of bound access error

Karthikeyan Periyasamy (33):
      wifi: ath12k: Refactor core startup
      wifi: ath12k: add ath12k_ab_to_ah() and ath12k_ab_set_ah()
      wifi: ath12k: add ath12k_get_num_hw()
      wifi: ath12k: introduce QMI firmware ready flag
      wifi: ath12k: move ATH12K_FLAG_REGISTERED handling to ath12k_mac_register()
      wifi: ath12k: introduce device group abstraction
      wifi: ath12k: refactor core start based on hardware group
      wifi: ath12k: move struct ath12k_hw from per device to group
      wifi: ath12k: send QMI host capability after device group is ready
      wifi: ath12k: introduce mlo_capable flag for device group
      wifi: ath12k: send partner device details in QMI MLO capability
      wifi: ath12k: refactor ath12k_qmi_alloc_target_mem_chunk()
      wifi: ath12k: add support to allocate MLO global memory region
      wifi: ath12k: enable MLO setup and teardown from core
      wifi: ath12k: avoid redundant code in DP Rx error process
      wifi: ath12k: move to HW link id based receive handling
      wifi: ath12k: add partner device buffer support in receive data path
      wifi: ath12k: add helper function to init partner cmem configuration
      wifi: ath12k: introduce interface combination cleanup helper
      wifi: ath12k: Refactor radio frequency information
      wifi: ath12k: advertise multi device interface combination
      wifi: ath12k: Add documentation HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG
      wifi: ath12k: Refactor monitor status TLV structure
      wifi: ath12k: cleanup Rx peer statistics structure
      wifi: ath12k: Fix the misspelled of hal TLV tag HAL_PHYRX_GENERICHT_SIG
      wifi: ath12k: fix incorrect TID updation in DP monitor status path
      wifi: ath12k: Remove unused HAL Rx mask in DP monitor path
      wifi: ath12k: Change the Tx monitor SRNG ring ID
      wifi: ath12k: Avoid explicit type cast in monitor status parse handler
      wifi: ath12k: Refactor ath12k_hw set helper function argument
      wifi: ath12k: Refactor the ath12k_hw get helper function argument
      wifi: ath12k: Remove ath12k_get_num_hw() helper function
      wifi: ath12k: Fix uninitialized variable access in ath12k_mac_allocate() function

Kavita Kavita (1):
      wifi: cfg80211: skip regulatory for punctured subchannels

Kees Cook (1):
      wifi: cfg80211: Move cfg80211_scan_req_add_chan() n_channels increment earlier

Kenjiro Nakayama (1):
      selftests/net: call sendmmsg via udpgso_bench.sh

Konrad Knitter (4):
      ice: add fw and port health reporters
      pldmfw: enable selected component update
      devlink: add devl guard
      ice: support FW Recovery Mode

Kory Maincent (18):
      net: Make dev_get_hwtstamp_phylib accessible
      net: Make net_hwtstamp_validate accessible
      net: Add the possibility to support a selected hwtstamp in netdevice
      net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology
      net: ethtool: Add support for tsconfig command to get/set hwtstamp config
      net: ethtool: Fix suspicious rcu_dereference usage
      net: pse-pd: Remove unused pse_ethtool_get_pw_limit function declaration
      net: pse-pd: Avoid setting max_uA in regulator constraints
      net: pse-pd: Add power limit check
      net: pse-pd: tps23881: Simplify function returns by removing redundant checks
      net: pse-pd: tps23881: Use helpers to calculate bit offset for a channel
      net: pse-pd: tps23881: Add missing configuration register after disable
      net: pse-pd: Use power limit at driver side instead of current limit
      net: pse-pd: Split ethtool_get_status into multiple callbacks
      net: pse-pd: Remove is_enabled callback from drivers
      net: pse-pd: tps23881: Add support for power limit and measurement features
      net: pse-pd: Fix missing PI of_node description
      net: pse-pd: Clean ethtool header of PSE structures

Krzysztof Kozlowski (10):
      nfc: st21nfca: Drop unneeded null check in st21nfca_tx_work()
      dt-bindings: net: Correct indentation and style in DTS example
      dt-bindings: net: qcom,ipa: Use recommended MBN firmware format in DTS example
      net: ti: icssg-prueth: Do not print physical memory addresses
      net: ti: am65-cpsw-nuss: Use syscon_regmap_lookup_by_phandle_args
      net: stmmac: imx: Use syscon_regmap_lookup_by_phandle_args
      net: stmmac: sti: Use syscon_regmap_lookup_by_phandle_args
      net: stmmac: stm32: Use syscon_regmap_lookup_by_phandle_args
      Bluetooth: Use str_enable_disable-like helpers
      dsa: Use str_enable_disable-like helpers

Kuan-Chung Chen (5):
      wifi: rtw89: sar: tweak 6GHz SAR subbands span
      wifi: rtw89: introduce dynamic antenna gain feature
      wifi: rtw89: handle different TX power between RF path
      wifi: rtw89: disable firmware training HE GI and LTF
      wifi: rtw89: 8852c: disable ER SU when 4x HE-LTF and 0.8 GI capability differ

Kuniyuki Iwashima (41):
      af_unix: Set error only when needed in unix_stream_connect().
      af_unix: Clean up error paths in unix_stream_connect().
      af_unix: Set error only when needed in unix_stream_sendmsg().
      af_unix: Clean up error paths in unix_stream_sendmsg().
      af_unix: Set error only when needed in unix_dgram_sendmsg().
      af_unix: Move !sunaddr case in unix_dgram_sendmsg().
      af_unix: Use msg->{msg_name,msg_namelen} in unix_dgram_sendmsg().
      af_unix: Split restart label in unix_dgram_sendmsg().
      af_unix: Defer sock_put() to clean up path in unix_dgram_sendmsg().
      af_unix: Clean up SOCK_DEAD error paths in unix_dgram_sendmsg().
      af_unix: Clean up error paths in unix_dgram_sendmsg().
      af_unix: Remove unix_our_peer().
      rtnetlink: Add rtnl_net_lock_killable().
      dev: Hold per-netns RTNL in (un)?register_netdev().
      net: Hold __rtnl_net_lock() in (un)?register_netdevice_notifier().
      net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_net().
      net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net().
      net: loopback: Hold rtnl_net_lock() in blackhole_netdev_init().
      dev: Acquire netdev_rename_lock before restoring dev->name in dev_change_name().
      dev: Remove devnet_rename_sem.
      dev: Hold rtnl_net_lock() for dev_ifsioc().
      net: dropreason: Gather SOCKET_ drop reasons.
      af_unix: Set drop reason in unix_release_sock().
      af_unix: Set drop reason in unix_sock_destructor().
      af_unix: Set drop reason in __unix_gc().
      af_unix: Set drop reason in manage_oob().
      af_unix: Set drop reason in unix_stream_read_skb().
      af_unix: Set drop reason in unix_dgram_disconnected().
      af_unix: Reuse out_pipe label in unix_stream_sendmsg().
      af_unix: Use consume_skb() in connect() and sendmsg().
      ipv6: Add __in6_dev_get_rtnl_net().
      ipv6: Convert net.ipv6.conf.${DEV}.XXX sysctl to per-netns RTNL.
      ipv6: Hold rtnl_net_lock() in addrconf_verify_work().
      ipv6: Hold rtnl_net_lock() in addrconf_dad_work().
      ipv6: Hold rtnl_net_lock() in addrconf_init() and addrconf_cleanup().
      ipv6: Convert inet6_ioctl() to per-netns RTNL.
      ipv6: Pass dev to inet6_addr_add().
      ipv6: Set cfg.ifa_flags before device lookup in inet6_rtm_newaddr().
      ipv6: Move lifetime validation to inet6_rtm_newaddr().
      ipv6: Convert inet6_rtm_newaddr() to per-netns RTNL.
      ipv6: Convert inet6_rtm_deladdr() to per-netns RTNL.

Kurt Kanzenbach (1):
      igb: Add XDP finalize and stats update functions

Larry Finger (1):
      wifi: rtw88: 8821au: Add additional devices to the USB_DEVICE list

Leo Stone (1):
      Documentation: ieee802154: fix grammar

Leon Yen (4):
      wifi: mt76: mt7921s: fix a potential firmware freeze during startup
      wifi: mt76: mt7925: Fix CNM Timeout with Single Active Link in MLO
      wifi: mt76: mt7921: introduce CSA support
      wifi: mt76: mt7921: avoid undesired changes of the preset regulatory domain

Li RongQing (1):
      net: ethtool: Use hwprov under rcu_read_lock

Linus Lüssing (1):
      batman-adv: netlink: reduce duplicate code by returning interfaces

Liu Jian (1):
      net: let net.core.dev_weight always be non-zero

Liu Jing (1):
      wifi: qtnfmac: fix spelling error in core.h

Liu Ye (1):
      selftests/net/ipsec: Fix Null pointer dereference in rtattr_pack()

Lorenzo Bianconi (7):
      net: airoha: Fix error path in airoha_probe()
      net: airoha: Enable Tx drop capability for each Tx DMA ring
      net: airoha: Introduce ndo_select_queue callback
      net: airoha: Add sched ETS offload support
      net: airoha: Add sched HTB offload support
      net: airoha: Fix channel configuration for ETS Qdisc
      net: airoha: Enforce ETS Qdisc priomap

Luiz Augusto von Dentz (1):
      Bluetooth: MGMT: Mark LL Privacy as stable

MD Danish Anwar (4):
      net: ti: icssg-prueth: Add VLAN support in EMAC mode
      net: ti: icssg-prueth: Add Multicast Filtering support for VLAN in MAC mode
      net: hsr: Create and export hsr_get_port_ndev()
      net: ti: icssg-prueth: Add Support for Multicast filtering with VLAN in HSR mode

Maciej S. Szmigiero (1):
      net: wwan: iosm: Fix hibernation by re-binding the driver around it

Mahdi Arghavani (1):
      tcp_cubic: fix incorrect HyStart round start detection

Maher Sanalla (1):
      net/mlxfw: Drop hard coded max FW flash image size

Maksym Kutsevol (2):
      netpoll: Make netpoll_send_udp return status instead of void
      netcons: Add udp send fail statistics to netconsole

Marc Kleine-Budde (3):
      Merge patch series "can: tcan4x5x: add option for selecting nWKRQ voltage"
      Merge patch series "can: tcan4x5x/m_can: use standby mode when down and in suspend"
      Merge patch series "can: kvaser_usb: Update stats and state even if alloc_can_err_skb() fails"

Marcel Hamer (2):
      wifi: brcmfmac: add missing header include for brcmf_dbg
      wifi: brcmfmac: fix NULL pointer dereference in brcmf_txfinalize()

Marek Lindner (1):
      MAINTAINERS: update email address of Marek Linder

Mark Bloch (1):
      net/mlx5: fs, retry insertion to hash table on EBUSY

Mark Dietzer (1):
      Bluetooth: btusb: Add ID 0x2c7c:0x0130 for Qualcomm WCN785x

Martin KaFai Lau (1):
      Merge branch 'selftests-bpf-migrate-test_xdp_meta-sh-to-test_progs'

Mateusz Polchlopek (1):
      devlink: add devlink_fmsg_dump_skb() function

Mathieu Othacehe (1):
      net: dwmac-imx: add imx93 clock input support in RMII mode

Matthew Wilcox (Oracle) (1):
      niu: Use page->private instead of page->index

Matthieu Baerts (NGI0) (6):
      selftests: mptcp: simult_flows: unify errors msgs
      selftests: mptcp: move stats info in case of errors to lib.sh
      selftests: mptcp: add -m with ss in case of errors
      selftests: mptcp: connect: remove unused variable
      selftests: mptcp: connect: better display the files size
      mptcp: sysctl: add syn_retrans_before_tcp_fallback

Max Chou (1):
      Bluetooth: btrtl: check for NULL in btrtl_setup_realtek()

Maxime Chevallier (10):
      net: freescale: ucc_geth: Drop support for the "interface" DT property
      net: freescale: ucc_geth: split adjust_link for phylink conversion
      net: freescale: ucc_geth: Use netdev->phydev to access the PHY
      net: freescale: ucc_geth: Fix WOL configuration
      net: freescale: ucc_geth: Use the correct type to store WoL opts
      net: freescale: ucc_geth: Simplify frame length check
      net: freescale: ucc_geth: Hardcode the preamble length to 7 bytes
      net: freescale: ucc_geth: Move the serdes configuration around
      net: freescale: ucc_geth: Introduce a helper to check Reduced modes
      net: freescale: ucc_geth: phylink conversion

Maximilian Güntner (1):
      ipv4: output metric as unsigned int

Mazin Al Haddad (1):
      Bluetooth: MGMT: Fix slab-use-after-free Read in mgmt_remove_adv_monitor_sync

Miaoqing Pan (1):
      wifi: ath11k: add support for QCA6698AQ

Michael Chan (5):
      bnxt_en: Do not allow ethtool -m on an untrusted VF
      bnxt_en: Skip PHY loopback ethtool selftest if unsupported by FW
      bnxt_en: Skip MAC loopback selftest if it is unsupported by FW
      bnxt_en: Skip reading PXP registers during ethtool -d if unsupported
      MAINTAINERS: bnxt_en: Add Pavan Chebbi as co-maintainer

Michael Lo (2):
      wifi: mt76: mt7921: fix using incorrect group cipher after disconnection.
      wifi: mt76: mt7925: config the dwell time by firmware

Michael-CY Lee (2):
      wifi: cfg80211: copy multi-link element from the multi-link probe request's frame body to the generated elements
      wifi: mt76: mt7996: fix beacon command during disabling

Michal Luczaj (7):
      vsock/test: Use NSEC_PER_SEC
      vsock/test: Introduce option to select tests
      vsock/test: Add README blurb about kmemleak usage
      vsock/test: Adapt send_byte()/recv_byte() to handle MSG_ZEROCOPY
      vsock/test: Add test for accept_queue memory leak
      vsock/test: Add test for sk_error_queue memory leak
      vsock/test: Add test for MSG_ZEROCOPY completion memory leak

Michal Swiatkowski (1):
      ice: add recipe priority check in search

Mina Almasry (4):
      net: page_pool: rename page_pool_alloc_netmem to *_netmems
      net: page_pool: create page_pool_alloc_netmem
      page_pool: disable sync for cpu for dmabuf memory provider
      net: Document netmem driver support

Ming Yen Hsieh (15):
      wifi: mt76: mt7925: fix get wrong chip cap from incorrect pointer
      wifi: mt76: mt7925: fix the invalid ip address for arp offload
      wifi: mt76: mt7925: Fix incorrect MLD address in bss_mld_tlv for MLO support
      wifi: mt76: mt7925: Fix incorrect WCID assignment for MLO
      wifi: mt76: mt7925: fix wrong parameter for related cmd of chan info
      wifi: mt76: mt7925: Enhance mt7925_mac_link_bss_add to support MLO
      wifi: mt76: Enhance mt7925_mac_link_sta_add to support MLO
      wifi: mt76: mt7925: Update mt7925_mcu_sta_update for BC in ASSOC state
      wifi: mt76: mt7925: Update mt792x_rx_get_wcid for per-link STA
      wifi: mt76: mt7925: Update mt7925_unassign_vif_chanctx for per-link BSS
      wifi: mt76: mt7925: Update secondary link PS flow
      wifi: mt76: mt7925: Init secondary link PM state
      wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO
      wifi: mt76: mt7925: Cleanup MLO settings post-disconnection
      wifi: mt76: mt7925: Properly handle responses for commands with events

Minjie Du (1):
      wifi: iwlwifi: Remove a duplicate assignment in iwl_dbgfs_amsdu_len_write()

Miri Korenblit (19):
      wifi: iwlwifi: mvm: remove pre-mld code from mld path
      wifi: iwlwifi: mvm: send the right link id
      wifi: mac80211: add an option to filter a sta from being flushed
      wifi: mac80211: change disassoc sequence a bit
      wifi: iwlwifi: mvm: cleanup iwl_mvm_sta_del
      wifi: iwlwifi: bump FW API to 95 for BZ/SC devices
      wifi: iwlwifi: support BIOS override for UNII4 in CA/US also in LARI versions < 12
      wifi: iwlwifi: support BIOS override for 5G9 in CA also in LARI version 8
      wifi: iwlwifi: mld: make iwl_mvm_find_ie_offset a iwlwifi util
      wifi: iwlwifi: mark that we support TX_CMD_API_S_VER_10
      wifi: iwlwifi: avoid memory leak
      wifi: iwlwifi: bump FW API to 96 for BZ/SC devices
      wifi: iwlwifi: mvm: avoid NULL pointer dereference
      wifi: iwlwifi: mvm: fix iwl_ssid_exist() check
      wifi: iwlwifi: mvm: Use helper function IS_ERR_OR_NULL()
      wifi: iwlwifi: mvm: Fix duplicated 'the' in comment
      wifi: mac80211: clarify key idx documententaion
      wifi: iwlwifi: rename iwl_datapath_monitor_notif::mac_id to link_id
      wifi: mac80211: avoid double free in auth/assoc timeout

Mohsin Bashir (1):
      eth: fbnic: update fbnic_poll return value

Moshe Shemesh (15):
      net/mlx5: fs, add counter object to flow destination
      net/mlx5: fs, add mlx5_fs_pool API
      net/mlx5: fs, add HWS root namespace functions
      net/mlx5: fs, add HWS flow table API functions
      net/mlx5: fs, add HWS flow group API functions
      net/mlx5: fs, add HWS actions pool
      net/mlx5: fs, add HWS packet reformat API function
      net/mlx5: fs, add HWS modify header API function
      net/mlx5: fs, manage flow counters HWS action sharing by refcount
      net/mlx5: fs, add dest table cache
      net/mlx5: fs, add HWS fte API functions
      net/mlx5: fs, add support for dest vport HWS action
      net/mlx5: fs, set create match definer to not supported by HWS
      net/mlx5: fs, add HWS get capabilities
      net/mlx5: fs, add HWS to steering mode options

Nick Morrow (3):
      wifi: rtw88: 8812au: Add more device IDs
      wifi: rtw88: Add additional USB IDs for RTL8812BU
      wifi: mt76: mt7921u: Add VID/PID for TP-Link TXE50UH

Nicolas Cavallari (1):
      wifi: mt76: mt7915: Fix mesh scan on MT7916 DBDC

Nicolas Escande (1):
      wifi: nl80211: fix nl80211_start_radar_detection return value

Nihar Chaithanya (1):
      octeontx2-pf: mcs: Remove dead code and semi-colon from rsrc_name()

Nikita Yushchenko (8):
      net: renesas: rswitch: do not deinit disabled ports
      net: renesas: rswitch: remove speed from gwca structure
      net: renesas: rswitch: enable only used MFWD features
      net: renesas: rswitch: do not write to MPSM register at init time
      net: renesas: rswitch: use FIELD_PREP for remaining MPIC register fields
      net: renesas: rswitch: align mdio C45 operations with datasheet
      net: renesas: rswitch: use generic MPSM operation for mdio C45
      net: renesas: rswitch: add mdio C22 support

Nikita Zhandarovich (1):
      net/rose: prevent integer overflows in rose_setsockopt()

Norbert van Bolhuis (1):
      wifi: brcmfmac: fix scatter-gather handling by detecting end of sg list

Octavian Purdila (3):
      net_sched: sch_sfq: don't allow 1 packet limit
      selftests/tc-testing: sfq: test that kernel rejects limit of 1
      team: prevent adding a device which is already a team device lower

Oleksij Rempel (28):
      net: usb: lan78xx: Remove LAN8835 PHY fixup
      net: usb: lan78xx: Remove KSZ9031 PHY fixup
      net: usb: lan78xx: move functions to avoid forward definitions
      net: usb: lan78xx: Improve error reporting with %pe specifier
      net: usb: lan78xx: Fix error handling in MII read/write functions
      net: usb: lan78xx: Improve error handling in EEPROM and OTP operations
      net: usb: lan78xx: Add error handling to lan78xx_init_ltm
      net: usb: lan78xx: Add error handling to set_rx_max_frame_length and set_mtu
      net: usb: lan78xx: Add error handling to lan78xx_irq_bus_sync_unlock
      net: usb: lan78xx: Improve error handling in dataport and multicast writes
      net: usb: lan78xx: Add error handling to lan78xx_setup_irq_domain
      net: usb: lan78xx: Add error handling to lan78xx_init_mac_address
      net: usb: lan78xx: Add error handling to lan78xx_set_mac_addr
      net: usb: lan78xx: Simplify lan78xx_update_reg
      net: usb: lan78xx: Fix return value handling in lan78xx_set_features
      net: usb: lan78xx: Improve error handling in lan78xx_phy_wait_not_busy
      net: usb: lan78xx: Rename lan78xx_phy_wait_not_busy to lan78xx_mdiobus_wait_not_busy
      net: usb: lan78xx: Add error handling to lan78xx_get_regs
      net: usb: lan78xx: Use ETIMEDOUT instead of ETIME in lan78xx_stop_hw
      net: usb: lan78xx: Use action-specific label in lan78xx_mac_reset
      net: usb: lan78xx: rename phy_mutex to mdiobus_mutex
      net: usb: lan78xx: remove PHY register access from ethtool get_regs
      net: usb: lan78xx: Improve error handling in WoL operations
      ethtool: linkstate: migrate linkstate functions to support multi-PHY setups
      Documentation: networking: update PHY error counter diagnostics in twisted pair guide
      net: phy: introduce optional polling interface for PHY statistics
      net: phy: dp83td510: add statistics support
      net: phy: dp83tg720: add statistics support

Oliver Hartkopp (2):
      mailmap: add an entry for Oliver Hartkopp
      MAINTAINERS: assign em_canid.c additionally to CAN maintainers

P Praneesh (2):
      wifi: ath12k: Fix endianness issue in struct hal_tlv_64_hdr
      wifi: ath12k: Add support for parsing 64-bit TLVs

Pablo Neira Ayuso (3):
      netfilter: nf_tables: fix set size with rbtree backend
      netfilter: flowtable: teardown flow if cached mtu is stale
      netfilter: flowtable: add CLOSING state

Paolo Abeni (14):
      Merge branch 'mitigate-the-two-reallocations-issue-for-iptunnels'
      Merge branch 'ionic-minor-code-updates'
      Merge branch 'net-smc-two-features-for-smc-r'
      Merge branch 'af_unix-prepare-for-skb-drop-reason'
      Merge branch 'net-fib_rules-add-flow-label-selector-support'
      Merge branch 'net-airoha-add-qdisc-offload-support'
      Merge branch 'dev-hold-per-netns-rtnl-in-register-netdev'
      Merge branch 'net-make-sure-we-retain-napi-ordering-on-netdev-napi_list'
      Merge branch 'introduce-unified-and-structured-phy'
      Merge tag 'nf-next-25-01-11' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'add-multicast-filtering-support-for-vlan-interface'
      Merge branch 'arrange-pse-core-and-update-tps23881-driver'
      Merge branch 'net-stmmac-rx-performance-improvement'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Parav Pandit (1):
      devlink: Improve the port attributes description

Patrisious Haddad (1):
      net/mlx5: fs, Add support for RDMA RX steering over IB link layer

Peter Chiu (4):
      wifi: mt76: mt7915: fix register mapping
      wifi: mt76: mt7996: fix register mapping
      wifi: mt76: mt7996: add max mpdu len capability
      wifi: mt76: mt7996: fix ldpc setting

Petr Machata (15):
      vxlan: In vxlan_rcv(), access flags through the vxlan netdevice
      vxlan: vxlan_rcv() callees: Move clearing of unparsed flags out
      vxlan: vxlan_rcv() callees: Drop the unparsed argument
      vxlan: vxlan_rcv(): Extract vxlan_hdr(skb) to a named variable
      vxlan: Track reserved bits explicitly as part of the configuration
      vxlan: Bump error counters for header mismatches
      vxlan: vxlan_rcv(): Drop unparsed
      vxlan: Add an attribute to make VXLAN header validation configurable
      selftests: net: lib: Rename ip_link_master() to ip_link_set_master()
      selftests: net: lib: Add several autodefer helpers
      selftests: forwarding: Add a selftest for the new reserved_bits UAPI
      net: bridge: Extract a helper to handle bridge_binding toggles
      net: bridge: Handle changes in VLAN_FLAG_BRIDGE_BINDING
      selftests: net: lib: Add a couple autodefer helpers
      selftests: net: Add a VLAN bridge binding selftest

Phil Sutter (6):
      netfilter: nf_tables: Flowtable hook's pf value never varies
      netfilter: nf_tables: Store user-defined hook ifname
      netfilter: nf_tables: Use stored ifname in netdev hook dumps
      netfilter: nf_tables: Compare netdev hooks based on stored name
      netfilter: nf_tables: Tolerate chains with no remaining hooks
      netfilter: nf_tables: Simplify chain netdev notifier

Philipp Stanner (1):
      net: wwan: t7xx: Replace deprecated PCI functions

Pierre-Henry Moussay (1):
      dt-bindings: can: mpfs: add PIC64GX CAN compatibility

Pin-yen Lin (1):
      wifi: mwifiex: decrease timeout waiting for host sleep from 10s to 5s

Ping-Ke Shih (12):
      wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit
      wifi: rtw89: ps: refactor PS flow to support MLO
      wifi: rtw89: ps: refactor channel info to firmware before entering PS
      wifi: rtw89: 8852c: rfk: refine target channel calculation in _rx_dck_channel_calc()
      wifi: rtw89: 8851b: rfk: remove unnecessary assignment of return value of _dpk_dgain_read()
      wifi: rtw89: phy: add dummy C2H event handler for report of TAS power
      wifi: rtw88: add __packed attribute to efuse layout struct
      wifi: rtw89: pci: treat first receiving part as first segment for 8922AE
      wifi: rtw89: fix race between cancel_hw_scan and hw_scan completion
      wifi: rtw89: read hardware capabilities part 1 via firmware command
      wifi: rtw89: 8922ae: add variant info to support RTL8922AE-VS
      wifi: rtw88: add RTW88_LEDS depends on LEDS_CLASS to Kconfig

Piotr Kwapulinski (10):
      ixgbe: Add support for E610 FW Admin Command Interface
      ixgbe: Add support for E610 device capabilities detection
      ixgbe: Add link management support for E610 device
      ixgbe: Add support for NVM handling in E610 device
      ixgbe: Add support for EEPROM dump in E610 device
      ixgbe: Add ixgbe_x540 multiple header inclusion protection
      ixgbe: Clean up the E610 link management related code
      ixgbe: Enable link management in E610 device
      PCI: Add PCI_VDEVICE_SUB helper macro
      ixgbevf: Add support for Intel(R) E610 device

Po-Hao Huang (4):
      wifi: rtw89: 8922a: Extend channel info field length for scan
      wifi: rtw89: 8852b: add beacon filter and CQM support
      wifi: rtw89: 8852bt: add beacon filter and CQM support
      wifi: rtw89: correct header conversion rule for MLO only

Pradeep Kumar Chitrapu (2):
      wifi: ath12k: Support Transmit Rate Buffer Stats
      wifi: ath12k: Support Transmit Buffer OFDMA Stats

Przemek Kitszel (8):
      checkpatch: don't complain on _Generic() use
      devlink: add devlink_fmsg_put() macro
      ice: rename devlink_port.[ch] to port.[ch]
      ice: add Tx hang devlink health reporter
      ice: c827: move wait for FW to ice_init_hw()
      ice: split ice_init_hw() out from ice_init_dev()
      ice: minor: rename goto labels from err to unroll
      ice: ice_probe: init ice_adapter after HW init

Quan Zhou (6):
      wifi: mt76: mt7921: fix a potential scan no APs
      wifi: mt76: do not hold queue lock during initial rx buffer alloc
      wifi: mt76: mt7925: fix the unfinished command of regd_notifier before suspend
      wifi: mt76: mt7925: fix CLC command timeout when suspend/resume
      wifi: mt76: mt7925: add handler to hif suspend/resume event
      wifi: mt76: mt7925e: fix too long of wifi resume time

R Sundar (1):
      ice: use string choice helpers

Radu Rendec (2):
      net: vxlan: rename SKB_DROP_REASON_VXLAN_NO_REMOTE
      net: bridge: add skb drop reasons to the most common drop points

Rahul Rameshbabu (1):
      rust: net::phy scope ThisModule usage in the module_phy_driver macro

Raj Kumar Bhagat (3):
      dt-bindings: net: wireless: Describe ath12k PCI module with WSI
      wifi: ath12k: parse multiple device information from Device Tree
      wifi: ath12k: Include MLO memory in firmware coredump collection

Rajat Soni (1):
      wifi: ath12k: Support pdev Puncture Stats

Rameshkumar Sundaram (7):
      wifi: ath12k: add reo queue lookup table for ML peers
      wifi: ath12k: modify chanctx iterators for MLO
      wifi: ath12k: ath12k_mac_station_add(): fix potential rx_stats leak
      wifi: ath12k: defer vdev creation for MLO
      wifi: cfg80211: send MLO links tx power info in GET_INTERFACE
      wifi: mac80211: get tx power per link
      wifi: ath12k: advertise MLO support and capabilities

Ramya Gnanasekar (1):
      wifi: ath12k: set flag for mgmt no-ack frames in Tx completion

Raphael Gallais-Pou (1):
      net: stmmac: sti: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()

Remi Pommarel (2):
      batman-adv: Remove atomic usage for tt.local_changes
      batman-adv: Don't keep redundant TT change events

Renjaya Raga Zenta (1):
      wifi: brcmfmac: fix brcmf_vif_clear_mgmt_ies when stopping AP

Rob Herring (Arm) (1):
      net: dsa: qca8k: Use of_property_present() for non-boolean properties

Roger Quadros (4):
      net: ethernet: ti: am65-cpsw: fix freeing IRQ in am65_cpsw_nuss_remove_tx_chns()
      net: ethernet: ti: am65-cpsw: ensure proper channel cleanup in error path
      net: ethernet: ti: am65-cpsw: streamline RX queue creation and cleanup
      net: ethernet: ti: am65-cpsw: streamline TX queue creation and cleanup

Rolf Eike Beer (1):
      wifi: iwlwifi: fix documentation about initial values in station table

Rongwei Liu (3):
      net/mlx5: Add device cap abs_native_port_num
      net/mlx5: LAG, Refactor lag logic
      net/mlx5: LAG, Support LAG over Multi-Host NICs

Roopni Devanathan (2):
      wifi: ath12k: Fix inappropriate use of print_array_to_buf_index()
      wifi: ath12k: Support AST Entry Stats

Rosen Penev (1):
      net: simplify resource acquisition + ioremap

Russell King (Oracle) (91):
      net: phylink: pass phylink and pcs into phylink_pcs_neg_mode()
      net: phylink: split cur_link_an_mode into requested and active
      net: phylink: add debug for phylink_major_config()
      net: phy: add phy_inband_caps()
      net: phy: bcm84881: implement phy_inband_caps() method
      net: phy: marvell: implement phy_inband_caps() method
      net: phy: add phy_config_inband()
      net: phy: marvell: implement config_inband() method
      net: phylink: add pcs_inband_caps() method
      net: mvneta: implement pcs_inband_caps() method
      net: mvpp2: implement pcs_inband_caps() method
      net: phylink: add negotiation of in-band capabilities
      net: phylink: remove phylink_phy_no_inband()
      net: phy: marvell: use phydev->eee_cfg.eee_enabled
      net: phy: avoid genphy_c45_ethtool_get_eee() setting eee_enabled
      net: phy: remove genphy_c45_eee_is_active()'s is_enabled arg
      net: phy: update phy_ethtool_get_eee() documentation
      net: pcs: pcs-lynx: implement pcs_inband_caps() method
      net: pcs: pcs-mtk-lynxi: implement pcs_inband_caps() method
      net: pcs: xpcs: implement pcs_inband_caps() method
      net: fec: use phydev->eee_cfg.tx_lpi_timer
      net: dsa: remove check for dp->pl in EEE methods
      net: dsa: add hook to determine whether EEE is supported
      net: dsa: provide implementation of .support_eee()
      net: dsa: b53/bcm_sf2: implement .support_eee() method
      net: dsa: mt753x: implement .support_eee() method
      net: dsa: qca8k: implement .support_eee() method
      net: dsa: mv88e6xxx: implement .support_eee() method
      net: dsa: ksz: implement .support_eee() method
      net: dsa: require .support_eee() method to be implemented
      net: phylink: add support for PCS supported_interfaces bitmap
      net: pcs: xpcs: fill in PCS supported_interfaces
      net: pcs: mtk-lynxi: fill in PCS supported_interfaces
      net: pcs: lynx: fill in PCS supported_interfaces
      net: stmmac: use PCS supported_interfaces
      net: pcs: xpcs: make xpcs_get_interfaces() static
      net: dsa: ksz: remove setting of tx_lpi parameters
      net: dsa: mt753x: remove setting of tx_lpi parameters
      net: dsa: no longer call ds->ops->get_mac_eee()
      net: dsa: b53/bcm_sf2: remove b53_get_mac_eee()
      net: dsa: ksz: remove ksz_get_mac_eee()
      net: dsa: mt753x: remove ksz_get_mac_eee()
      net: dsa: mv88e6xxx: remove mv88e6xxx_get_mac_eee()
      net: dsa: qca: remove qca8k_get_mac_eee()
      net: dsa: remove get_mac_eee() method
      net: phy: add configuration of rx clock stop mode
      net: stmmac: move tx_lpi_timer tracking to phylib
      net: stmmac: use correct type for tx_lpi_timer
      net: stmmac: use unsigned int for eee_timer
      net: stmmac: make EEE depend on phy->enable_tx_lpi
      net: stmmac: remove redundant code from ethtool EEE ops
      net: stmmac: clean up stmmac_disable_eee_mode()
      net: stmmac: remove priv->tx_lpi_enabled
      net: stmmac: report EEE error statistics if EEE is supported
      net: stmmac: convert to use phy_eee_rx_clock_stop()
      net: stmmac: remove priv->eee_tw_timer
      net: stmmac: move priv->eee_enabled into stmmac_eee_init()
      net: stmmac: move priv->eee_active into stmmac_eee_init()
      net: stmmac: use boolean for eee_enabled and eee_active
      net: stmmac: move setup of eee_ctrl_timer to stmmac_dvr_probe()
      net: stmmac: remove unnecessary EEE handling in stmmac_release()
      net: stmmac: split hardware LPI timer control
      net: stmmac: remove stmmac_lpi_entry_timer_config()
      net: stmmac: rename stmmac_disable_sw_eee_mode()
      net: stmmac: correct priv->eee_sw_timer_en setting
      net: stmmac: simplify TX cleanup decision for ending sw LPI mode
      net: stmmac: check priv->eee_sw_timer_en in suspend path
      net: stmmac: add stmmac_try_to_start_sw_lpi()
      net: stmmac: provide stmmac_eee_tx_busy()
      net: stmmac: provide function for restarting sw LPI timer
      net: stmmac: combine stmmac_enable_eee_mode()
      net: stmmac: restart LPI timer after cleaning transmit descriptors
      net: bcm: asp2: fix LPI timer handling
      net: bcm: asp2: remove tx_lpi_enabled
      net: bcm: asp2: convert to phylib managed EEE
      net: phylink: use pcs_neg_mode in phylink_mac_pcs_get_state()
      net: phylink: pass neg_mode into .pcs_get_state() method
      net: phylink: pass neg_mode into c22 state decoder
      net: phylink: use neg_mode in phylink_mii_c22_pcs_decode_state()
      net: phylink: provide fixed state for 1000base-X and 2500base-X
      net: mdio: add definition for clock stop capable bit
      net: phy: add support for querying PHY clock stop capability
      net: phylink: add phylink_link_is_up() helper
      net: phylink: add EEE management
      net: mvneta: convert to phylink EEE implementation
      net: mvpp2: add EEE implementation
      net: lan743x: use netdev in lan743x_phylink_mac_link_down()
      net: lan743x: convert to phylink managed EEE
      net: stmmac: convert to phylink managed EEE support
      net: phylink: always do a major config when attaching a SFP PHY
      net: phylink: fix regression when binding a PHY

Sabrina Dubroca (7):
      tls: block decryption when a rekey is pending
      tls: implement rekey for TLS1.3
      tls: add counters for rekey
      docs: tls: document TLS1.3 key updates
      selftests: tls: add key_generation argument to tls_crypto_info_init
      selftests: tls: add rekey tests
      tls: skip setting sk_write_space on rekey

Saeed Mahameed (1):
      net/mlx5: SHAMPO: Introduce new SHAMPO specific HCA caps

Samiullah Khawaja (1):
      page_pool: Set `dma_sync` to false for devmem memory provider

Sanman Pradhan (3):
      eth: fbnic: hwmon: Add completion infrastructure for firmware requests
      eth: fbnic: hwmon: Add support for reading temperature and voltage sensors
      eth: fbnic: Add hardware monitoring support via HWMON interface

Sathishkumar Muruganandam (2):
      wifi: mac80211: add EHT 320 MHz support for mesh
      wifi: ath12k: fix tx power, max reg power update to firmware

Sean Anderson (2):
      net: xilinx: axienet: Add some symbolic constants for IRQ delay timer
      net: xilinx: axienet: Report an error for bad coalesce settings

Sean Nyekjaer (7):
      dt-bindings: can: convert tcan4x5x.txt to DT schema
      dt-bindings: can: tcan4x5x: Document the ti,nwkrq-voltage-vio option
      can: tcan4x5x: add option for selecting nWKRQ voltage
      can: tcan4x5x: get rid of false clock errors
      can: m_can: add deinit callback
      can: tcan4x5x: add deinit callback to set standby mode
      can: m_can: call deinit/init callback when going into suspend/resume

Sean Wang (1):
      wifi: mt76: connac: Extend mt76_connac_mcu_uni_add_dev for MLO

Shannon Nelson (3):
      ionic: add asic codes to firmware interface file
      ionic: add speed defines for 200G and 400G
      ionic: add support for QSFP_PLUS_CMIS

Shay Agroskin (1):
      net: ena: Fix incorrect indentation

Shayne Chen (5):
      wifi: mt76: mt7996: fix invalid interface combinations
      wifi: mt76: mt7996: extend flexibility of mt7996_mcu_get_eeprom()
      wifi: mt76: mt7996: add support for more variants
      wifi: mt76: mt7915: add module param to select 5 GHz or 6 GHz on MT7916
      wifi: mt76: connac: rework connac helpers

Shen Lichuan (1):
      wifi: mt76: mt7615: Convert comma to semicolon

Shinas Rasheed (5):
      octeon_ep: add ndo ops for VFs in PF driver
      octeon_ep: remove firmware stats fetch in ndo_get_stats64
      octeon_ep: update tx/rx stats locally for persistence
      octeon_ep_vf: remove firmware stats fetch in ndo_get_stats64
      octeon_ep_vf: update tx/rx stats locally for persistence

Sidhanta Sahu (1):
      wifi: ath12k: Support MBSSID Control Frame Stats

Simon Wunderlich (2):
      batman-adv: Start new development cycle
      mailmap: add entries for Simon Wunderlich

Soham Chakradeo (4):
      selftests/net: packetdrill: import tcp/ecn, tcp/close, tcp/sack, tcp/tcp_info
      selftests/net: packetdrill: import tcp/fast_recovery, tcp/nagle, tcp/timestamping
      selftests/net: packetdrill: import tcp/eor, tcp/splice, tcp/ts_recent, tcp/blocking
      selftests/net: packetdrill: import tcp/user_timeout, tcp/validate, tcp/sendfile, tcp/limited-transmit, tcp/syscall_bad_arg

Somashekhar(Som) (6):
      wifi: mvm: Request periodic system statistics earlier
      wifi: iwlwifi: pcie: Add support for new device ids
      wifi: iwlwifi: interpret STEP URM BIOS configuration
      wifi: iwlwifi: Allow entering EMLSR for more band combinations
      wifi: iwlwifi: add mapping of prph register crf for PE RF
      wifi: iwlwifi: add channel_load_not_by_us in iwl_mvm_phy_ctxt

Song Yoong Siang (3):
      selftests/bpf: Actuate tx_metadata_len in xdp_hw_metadata
      selftests/bpf: Enable Tx hwtstamp in xdp_hw_metadata
      igc: Allow hot-swapping XDP program

Sriram R (16):
      wifi: ath12k: MLO vdev bringup changes
      wifi: ath12k: Refactor sta state machine
      wifi: ath12k: Add helpers for multi link peer creation and deletion
      wifi: ath12k: add multi-link flag in peer create command
      wifi: ath12k: add helper to find multi-link station
      wifi: ath12k: Add MLO peer assoc command support
      wifi: ath12k: Add MLO station state change handling
      wifi: ath12k: support change_sta_links() mac80211 op
      wifi: ath12k: add primary link for data path operations
      wifi: ath12k: use arsta instead of sta
      wifi: ath12k: Use mac80211 vif's link_conf instead of bss_conf
      wifi: ath12k: Use mac80211 sta's link_sta instead of deflink
      wifi: ath12k: ath12k_mac_op_tx(): MLO support
      wifi: ath12k: ath12k_mac_op_flush(): MLO support
      wifi: ath12k: ath12k_mac_op_ampdu_action(): MLO support
      wifi: ath12k: do not return invalid link id for scan link

Sriram Yagnaraman (5):
      igb: Remove static qualifiers
      igb: Introduce igb_xdp_is_enabled()
      igb: Introduce XSK data structures and helpers
      igb: Add AF_XDP zero-copy Rx support
      igb: Add AF_XDP zero-copy Tx support

Stanislav Fomichev (8):
      ynl: support enum-cnt-name attribute in legacy definitions
      ynl: skip rendering attributes with header property in uapi mode
      ynl: support directional specs in ynl-gen-c.py
      ynl: add missing pieces to ethtool spec to better match uapi header
      ynl: include uapi header after all dependencies
      ethtool: separate definitions that are gonna be generated
      ethtool: remove the comments that are not gonna be generated
      ethtool: regenerate uapi header from the spec

StanleyYP Wang (1):
      wifi: mt76: mt7996: set correct background radar capability

Stas Sergeev (1):
      tun: fix group permission check

Stefan Dösinger (1):
      wifi: brcmfmac: Check the return value of of_property_read_string_index()

Stefano Brivio (1):
      udp: Deal with race between UDP socket address change and rehash

Steffen Klassert (1):
      Merge branch 'Add IP-TFS mode to xfrm'

Sven Eckelmann (3):
      batman-adv: Reorder includes for distributed-arp-table.c
      batman-adv: Map VID 0 to untagged TT VLAN
      mailmap: add entries for Sven Eckelmann

Taehee Yoo (10):
      net: ethtool: add hds_config member in ethtool_netdev_state
      net: ethtool: add support for configuring hds-thresh
      net: devmem: add ring parameter filtering
      net: ethtool: add ring parameter filtering
      net: disallow setup single buffer XDP when tcp-data-split is enabled.
      bnxt_en: add support for rx-copybreak ethtool command
      bnxt_en: add support for tcp-data-split ethtool command
      bnxt_en: add support for hds-thresh ethtool command
      netdevsim: add HDS feature
      selftest: net-drv: hds: add test for HDS feature

Ted Chen (1):
      bridge: Make br_is_nd_neigh_msg() accept pointer to "const struct sk_buff"

Thadeu Lima de Souza Cascardo (9):
      wifi: rtlwifi: do not complete firmware loading needlessly
      wifi: rtlwifi: rtl8192se: rise completion of firmware loading as last step
      wifi: rtlwifi: wait for firmware loading before releasing memory
      wifi: rtlwifi: fix init_sw_vars leak when probe fails
      wifi: rtlwifi: usb: fix workqueue leak when probe fails
      wifi: rtlwifi: remove unused check_buddy_priv
      wifi: rtlwifi: destroy workqueue at rtl_deinit_core
      wifi: rtlwifi: fix memory leaks and invalid access at probe error path
      wifi: rtlwifi: pci: wait for firmware loading before releasing memory

Thomas Weißschuh (6):
      net: bridge: constify 'struct bin_attribute'
      net: phy: ks8995: constify 'struct bin_attribute'
      netxen_nic: constify 'struct bin_attribute'
      wifi: wlcore: sysfs: constify 'struct bin_attribute'
      qlcnic: use const 'struct bin_attribute' callbacks
      ptp: ocp: constify 'struct bin_attribute'

Thorsten Blum (1):
      hv_netvsc: Replace one-element array with flexible array member

Toke Høiland-Jørgensen (4):
      wifi: ath9k: Add RX inactivity detection and reset chip when it occurs
      xdp: register system page pool as an XDP memory model
      net_sched: sch_cake: Add drop reasons
      net/sched: Add drop reasons for AQM-based qdiscs

Tristram Ha (2):
      net: dsa: microchip: Add suspend/resume support to KSZ DSA driver
      net: dsa: microchip: Do not execute PTP driver code for unsupported switches

Uwe Kleine-König (1):
      ptp: Switch back to struct platform_driver::remove()

Vadim Fedorenko (1):
      net/mlx5: use do_aux_work for PHC overflow checks

Vasily Khoruzhick (1):
      wifi: rtw88: 8703b: Fix RX/TX issues

Vlad Dogaru (2):
      net/mlx5: HWS, handle returned error value in pool alloc
      net/mlx5: HWS, support flow sampler destination

Vladimir Oltean (9):
      lib: packing: create __pack() and __unpack() variants without error checking
      lib: packing: demote truncation error in pack() to a warning in __pack()
      lib: packing: add pack_fields() and unpack_fields()
      selftests: forwarding: add a pvid_change test to bridge_vlan_unaware
      net: phylink: improve phylink_sfp_config_phy() error message with missing PHY driver
      net: ethtool: ts: add separate counter for unconfirmed one-step TX timestamps
      net: dsa: implement get_ts_stats ethtool operation for user ports
      net: mscc: ocelot: add TX timestamping statistics
      net: dsa: felix: report timestamping stats from the ocelot library

WangYuli (1):
      wifi: mt76: mt76u_vendor_request: Do not print error messages when -EPROTO

Wei Fang (4):
      net: enetc: add Tx checksum offload for i.MX95 ENETC
      net: enetc: update max chained Tx BD number for i.MX95 ENETC
      net: enetc: add LSO support for i.MX95 ENETC PF
      net: enetc: add UDP segmentation offload support

Willem de Bruijn (1):
      selftests/net: packetdrill: report benign debug flakes as xfail

Wolfram Sang (1):
      mctp i2c: drop check because i2c_unregister_device() is NULL safe

Xiangqian Zhang (1):
      net: mii: Fix the Speed display when the network cable is not connected

Xin Long (1):
      net: sched: refine software bypass handling in tc_run

Yafang Shao (1):
      net/mlx5e: Report rx_discards_phy via rx_dropped

Yedidya Benshimol (2):
      wifi: iwlwifi: remove mvm from session protection cmd's name
      wifi: iwlwifi: api: remove version number from latest stored_beacon_notif

Yevgeny Kliteynik (19):
      net/mlx5: Add ConnectX-8 device to ifc
      net/mlx5: HWS, no need to expose mlx5hws_send_queues_open/close
      net/mlx5: HWS, do not initialize native API queues
      net/mlx5: HWS, remove the use of duplicated structs
      net/mlx5: HWS, remove implementation of unused FW commands
      net/mlx5: HWS, denote how refcounts are protected
      net/mlx5: HWS, simplify allocations as we support only FDB
      net/mlx5: HWS, add error message on failure to move rules
      net/mlx5: HWS, change error flow on matcher disconnect
      net/mlx5: HWS, remove wrong deletion of the miss table list
      net/mlx5: HWS, reduce memory consumption of a matcher struct
      net/mlx5: HWS, num_of_rules counter on matcher should be atomic
      net/mlx5: HWS, separate SQ that HWS uses from the usual traffic SQs
      net/mlx5: HWS, fix definer's HWS_SET32 macro for negative offset
      net/mlx5: HWS, use the right size when writing arg data
      net/mlx5: HWS, set timeout on polling for completion
      net/mlx5: HWS, update flow - remove the use of dual RTCs
      net/mlx5: HWS, update flow - support through bigger action RTC
      net/mlx5: HWS, rework the check if matcher size can be increased

YiFei Zhu (1):
      sfc: Use netdev refcount tracking in struct efx_async_filter_insertion

Ying Hsu (1):
      Bluetooth: btusb: add sysfs attribute to control USB alt setting

Yu Tian (1):
      ipv4: remove useless arg

Yue Haibing (4):
      igc: Fix passing 0 to ERR_PTR in igc_xdp_run_prog()
      igb: Fix passing 0 to ERR_PTR in igb_run_xdp()
      ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()
      ixgbevf: Fix passing 0 to ERR_PTR in ixgbevf_run_xdp()

Yuyang Huang (3):
      netlink: add IGMP/MLD join/leave notifications
      netlink: correct nlmsg size for multicast notifications
      netlink: add IPv6 anycast join/leave notifications

Zhang Kunbo (1):
      wifi: mt76: mt7925: replace zero-length array with flexible-array member

Zichen Xie (1):
      wifi: cfg80211: tests: Fix potential NULL dereference in test_cfg80211_parse_colocated_ap()

Zijun Hu (2):
      net: wan: framer: Simplify API framer_provider_simple_of_xlate() implementation
      Bluetooth: qca: Fix poor RF performance for WCN6855

Zong-Zhe Yang (12):
      wifi: rtw89: 8922a: configure AP_LINK_PS if FW supports
      wifi: rtw89: register ops of can_activate_links
      wifi: rtw89: implement ops of change vif/sta links
      wifi: rtw89: apply MLD pairwise key to dynamically active links
      wifi: rtw89: pass target link_id to ieee80211_gtk_rekey_add()
      wifi: rtw89: pass target link_id to ieee80211_nullfunc_get()
      wifi: rtw89: refine link handling for link_sta_rc_update
      wifi: rtw89: regd: update regulatory map to R68-R51
      wifi: rtw89: debug: print regd for QATAR/UK/THAILAND
      wifi: rtw89: fix proceeding MCC with wrong scanning state after sequence changes
      wifi: rtw89: chan: fix soft lockup in rtw89_entity_recalc_mgnt_roles()
      wifi: rtw89: mcc: consider time limits not divisible by 1024

allan.wang (1):
      wifi: mt76: mt7925: Fix incorrect WCID phy_idx assignment

shitao (1):
      wifi: iwlwifi: Fix spelling typo in comment

shunlizhou (1):
      docs: net: bonding: fix typos

tuqiang (1):
      netfilter: nf_tables: remove the genmask parameter

xueqin Luo (2):
      wifi: mt76: mt7996: fix overflows seen when writing limit attributes
      wifi: mt76: mt7915: fix overflows seen when writing limit attributes

谢致邦 (XIE Zhibang) (2):
      net: ethernet: sunplus: Switch to ndo_eth_ioctl
      net: appletalk: Drop aarp_send_probe_phase1()

 .mailmap                                           |   21 +
 Documentation/Makefile                             |    2 +-
 Documentation/core-api/packing.rst                 |  118 +-
 .../bindings/net/amlogic,meson-dwmac.yaml          |   14 +-
 .../devicetree/bindings/net/asix,ax88178.yaml      |    4 +-
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |   10 +-
 .../devicetree/bindings/net/brcm,bcmgenet.yaml     |   32 +-
 .../bindings/net/brcm,mdio-mux-iproc.yaml          |   50 +-
 .../bindings/net/can/atmel,at91sam9263-can.yaml    |   58 +
 .../devicetree/bindings/net/can/atmel-can.txt      |   15 -
 .../devicetree/bindings/net/can/bosch,c_can.yaml   |   10 +-
 .../bindings/net/can/microchip,mcp2510.yaml        |   18 +-
 .../bindings/net/can/microchip,mpfs-can.yaml       |    6 +-
 .../bindings/net/can/st,stm32-bxcan.yaml           |    2 +-
 .../devicetree/bindings/net/can/tcan4x5x.txt       |   48 -
 .../devicetree/bindings/net/can/ti,tcan4x5x.yaml   |  199 ++
 .../bindings/net/microchip,sparx5-switch.yaml      |   18 +
 .../devicetree/bindings/net/nxp,s32-dwmac.yaml     |  105 +
 .../devicetree/bindings/net/qcom,ipa.yaml          |    2 +-
 .../devicetree/bindings/net/snps,dwmac.yaml        |    1 +
 .../devicetree/bindings/net/stm32-dwmac.yaml       |   94 +-
 .../devicetree/bindings/net/ti,davinci-mdio.yaml   |   10 +-
 .../devicetree/bindings/net/ti,dp83822.yaml        |   27 +
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml        |   20 +-
 .../devicetree/bindings/net/ti,k3-am654-cpts.yaml  |   38 +-
 .../bindings/net/wireless/marvell,sd8787.yaml      |   19 +-
 .../bindings/net/wireless/qcom,ath12k-wsi.yaml     |  204 ++
 Documentation/netlink/genetlink-c.yaml             |    3 +
 Documentation/netlink/genetlink-legacy.yaml        |    3 +
 Documentation/netlink/netlink-raw.yaml             |    2 +-
 Documentation/netlink/specs/ethtool.yaml           |  445 +++-
 Documentation/netlink/specs/rt_link.yaml           |   96 +
 Documentation/netlink/specs/rt_route.yaml          |    7 +
 Documentation/netlink/specs/rt_rule.yaml           |   12 +
 Documentation/networking/batman-adv.rst            |    2 +-
 Documentation/networking/bonding.rst               |    8 +-
 .../device_drivers/ethernet/intel/i40e.rst         |   12 +
 Documentation/networking/devlink/mlx5.rst          |    3 +
 .../diagnostic/twisted_pair_layer1_diagnostics.rst |   39 +-
 Documentation/networking/ethtool-netlink.rst       |  109 +-
 Documentation/networking/ieee802154.rst            |   16 +-
 Documentation/networking/index.rst                 |    1 +
 Documentation/networking/ip-sysctl.rst             |   14 +
 Documentation/networking/mptcp-sysctl.rst          |   16 +
 Documentation/networking/multi-pf-netdev.rst       |    4 +-
 Documentation/networking/napi.rst                  |    4 +-
 .../net_cachelines/netns_ipv4_sysctl.rst           |    1 +
 Documentation/networking/netconsole.rst            |    5 +-
 Documentation/networking/netdevices.rst            |   10 +
 Documentation/networking/netlink_spec/readme.txt   |    2 +-
 Documentation/networking/netmem.rst                |   79 +
 Documentation/networking/timestamping.rst          |   38 +-
 Documentation/networking/tls.rst                   |   36 +
 Documentation/networking/xfrm_device.rst           |    3 +-
 Documentation/process/maintainer-netdev.rst        |   46 +
 Documentation/userspace-api/netlink/c-code-gen.rst |    4 +-
 .../userspace-api/netlink/intro-specs.rst          |    8 +-
 MAINTAINERS                                        |  127 +-
 Makefile                                           |    4 +
 arch/alpha/include/uapi/asm/socket.h               |    2 +
 arch/mips/include/uapi/asm/socket.h                |    2 +
 arch/parisc/include/uapi/asm/socket.h              |    2 +
 arch/sparc/include/uapi/asm/socket.h               |    2 +
 drivers/bluetooth/btbcm.c                          |    3 +
 drivers/bluetooth/btintel.c                        |   17 +-
 drivers/bluetooth/btmrvl_main.c                    |    3 +-
 drivers/bluetooth/btmtk.c                          |    4 +-
 drivers/bluetooth/btmtksdio.c                      |    4 +-
 drivers/bluetooth/btqca.c                          |  200 +-
 drivers/bluetooth/btqca.h                          |    5 +-
 drivers/bluetooth/btrtl.c                          |    4 +-
 drivers/bluetooth/btusb.c                          |   73 +-
 drivers/bluetooth/hci_qca.c                        |   33 +-
 drivers/infiniband/hw/mlx5/fs.c                    |   37 +-
 drivers/isdn/mISDN/core.c                          |   14 -
 drivers/isdn/mISDN/core.h                          |    1 -
 drivers/net/bareudp.c                              |   16 +-
 drivers/net/can/dev/dev.c                          |    2 -
 drivers/net/can/grcan.c                            |    3 +-
 drivers/net/can/kvaser_pciefd.c                    |   81 +-
 drivers/net/can/m_can/m_can.c                      |   22 +-
 drivers/net/can/m_can/m_can.h                      |    1 +
 drivers/net/can/m_can/tcan4x5x-core.c              |   30 +-
 drivers/net/can/m_can/tcan4x5x.h                   |    2 +
 drivers/net/can/sja1000/sja1000_platform.c         |   15 +-
 drivers/net/can/sun4i_can.c                        |    2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |    3 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  |  133 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   |   38 +-
 drivers/net/dsa/b53/b53_common.c                   |   14 +-
 drivers/net/dsa/b53/b53_priv.h                     |    2 +-
 drivers/net/dsa/b53/b53_serdes.c                   |    4 +-
 drivers/net/dsa/bcm_sf2.c                          |    2 +-
 drivers/net/dsa/microchip/ksz9477_i2c.c            |    4 +
 drivers/net/dsa/microchip/ksz_common.c             |  118 +-
 drivers/net/dsa/microchip/ksz_common.h             |    3 +
 drivers/net/dsa/microchip/ksz_spi.c                |    4 +
 drivers/net/dsa/mt7530.c                           |   16 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   58 +-
 drivers/net/dsa/mv88e6xxx/chip.h                   |    1 +
 drivers/net/dsa/mv88e6xxx/pcs-6185.c               |    1 +
 drivers/net/dsa/mv88e6xxx/pcs-6352.c               |    1 +
 drivers/net/dsa/mv88e6xxx/pcs-639x.c               |    8 +-
 drivers/net/dsa/mv88e6xxx/port.c                   |    3 +-
 drivers/net/dsa/ocelot/felix.c                     |    9 +
 drivers/net/dsa/qca/qca8k-8xxx.c                   |   10 +-
 drivers/net/dsa/qca/qca8k-common.c                 |    7 -
 drivers/net/dsa/qca/qca8k.h                        |    3 +-
 drivers/net/dsa/realtek/rtl8366rb.c                |    7 +-
 drivers/net/dsa/sja1105/sja1105_static_config.c    |    8 +-
 drivers/net/ethernet/Kconfig                       |    2 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |    2 +-
 drivers/net/ethernet/amd/pcnet32.c                 |   11 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c     |   16 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.h        |    3 -
 .../net/ethernet/broadcom/asp2/bcmasp_ethtool.c    |   39 -
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |   22 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  109 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   25 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  114 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |    2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h      |    2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |    4 +
 drivers/net/ethernet/cadence/macb_main.c           |   17 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |    3 +
 drivers/net/ethernet/cisco/enic/enic_main.c        |   64 +-
 drivers/net/ethernet/engleder/tsnep_main.c         |   28 +-
 drivers/net/ethernet/freescale/Kconfig             |    3 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |    2 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |    3 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       |  330 ++-
 drivers/net/ethernet/freescale/enetc/enetc.h       |   29 +-
 drivers/net/ethernet/freescale/enetc/enetc4_hw.h   |   23 +
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |   31 +-
 .../net/ethernet/freescale/enetc/enetc_pf_common.c |   13 +-
 drivers/net/ethernet/freescale/enetc/enetc_vf.c    |    7 +-
 drivers/net/ethernet/freescale/fec.h               |    2 -
 drivers/net/ethernet/freescale/fec_main.c          |   16 +-
 drivers/net/ethernet/freescale/fman/fman.c         |   35 +-
 drivers/net/ethernet/freescale/fman/fman_dtsec.c   |    4 +-
 drivers/net/ethernet/freescale/ucc_geth.c          |  604 ++---
 drivers/net/ethernet/freescale/ucc_geth.h          |   22 +-
 drivers/net/ethernet/freescale/ucc_geth_ethtool.c  |   74 +-
 drivers/net/ethernet/google/gve/gve_adminq.c       |   14 -
 drivers/net/ethernet/google/gve/gve_adminq.h       |    1 -
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       |    6 +-
 drivers/net/ethernet/hisilicon/hibmcge/Makefile    |    3 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_common.h    |   29 +
 .../net/ethernet/hisilicon/hibmcge/hbg_debugfs.c   |  160 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_debugfs.h   |   12 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c   |  134 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h   |   13 +
 .../net/ethernet/hisilicon/hibmcge/hbg_ethtool.c   |  181 ++
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c    |   48 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h    |    6 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c  |  199 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c  |   15 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h   |   39 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c |  109 -
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h |   28 -
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c |   67 -
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |    5 -
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h  |    1 -
 drivers/net/ethernet/huawei/hinic/hinic_port.c     |    2 +-
 drivers/net/ethernet/intel/Kconfig                 |    1 +
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c        |  120 -
 drivers/net/ethernet/intel/fm10k/fm10k_pf.h        |    2 -
 drivers/net/ethernet/intel/i40e/i40e.h             |    7 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.c      |   10 -
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  458 ----
 drivers/net/ethernet/intel/i40e/i40e_dcb.c         |   13 -
 drivers/net/ethernet/intel/i40e/i40e_dcb.h         |    1 -
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |    2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  231 +-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   40 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   11 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |   30 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   79 +-
 drivers/net/ethernet/intel/ice/Makefile            |    3 +-
 drivers/net/ethernet/intel/ice/devlink/devlink.c   |   20 +-
 drivers/net/ethernet/intel/ice/devlink/health.c    |  550 ++++
 drivers/net/ethernet/intel/ice/devlink/health.h    |   71 +
 .../intel/ice/devlink/{devlink_port.c => port.c}   |    2 +-
 .../intel/ice/devlink/{devlink_port.h => port.h}   |    0
 drivers/net/ethernet/intel/ice/ice.h               |    2 +
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |   99 +-
 drivers/net/ethernet/intel/ice/ice_base.c          |    6 +-
 drivers/net/ethernet/intel/ice/ice_common.c        |  444 ++--
 drivers/net/ethernet/intel/ice/ice_common.h        |    8 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.h       |    2 +-
 drivers/net/ethernet/intel/ice/ice_fw_update.c     |   14 +-
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h     |   49 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |    6 +
 drivers/net/ethernet/intel/ice/ice_lib.h           |    1 +
 drivers/net/ethernet/intel/ice/ice_main.c          |  170 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |  130 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h           |    2 +
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h    |   12 -
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        |  164 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h        |   40 +-
 drivers/net/ethernet/intel/ice/ice_repr.c          |    2 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c        |    2 +-
 drivers/net/ethernet/intel/ice/ice_switch.c        |    3 +-
 drivers/net/ethernet/intel/ice/ice_type.h          |   17 +
 drivers/net/ethernet/intel/ice/ice_xsk.c           |   32 +-
 drivers/net/ethernet/intel/igb/Makefile            |    2 +-
 drivers/net/ethernet/intel/igb/igb.h               |   58 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |  270 +-
 drivers/net/ethernet/intel/igb/igb_xsk.c           |  562 ++++
 drivers/net/ethernet/intel/igc/igc.h               |    2 +
 drivers/net/ethernet/intel/igc/igc_hw.h            |    5 -
 drivers/net/ethernet/intel/igc/igc_main.c          |  118 +-
 drivers/net/ethernet/intel/igc/igc_nvm.c           |   50 -
 drivers/net/ethernet/intel/igc/igc_nvm.h           |    2 -
 drivers/net/ethernet/intel/igc/igc_xdp.c           |    8 +-
 drivers/net/ethernet/intel/ixgbe/Makefile          |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h           |   13 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c     |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    |   25 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c    |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c      | 2658 +++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h      |   81 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |    6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c       |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  459 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c       |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c       |    5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      |   72 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 1074 ++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c      |   12 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h      |    7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |   29 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h      |   20 +
 drivers/net/ethernet/intel/ixgbevf/defines.h       |    5 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h       |    7 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |   35 +-
 drivers/net/ethernet/intel/ixgbevf/mbx.c           |   12 -
 drivers/net/ethernet/intel/ixgbevf/vf.c            |   12 +-
 drivers/net/ethernet/intel/ixgbevf/vf.h            |    4 +-
 drivers/net/ethernet/lantiq_etop.c                 |   25 +-
 drivers/net/ethernet/marvell/mvneta.c              |  141 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h         |    5 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  113 +-
 .../net/ethernet/marvell/octeon_ep/octep_ethtool.c |   41 +-
 .../net/ethernet/marvell/octeon_ep/octep_main.c    |   68 +-
 .../net/ethernet/marvell/octeon_ep/octep_main.h    |    7 +
 .../ethernet/marvell/octeon_ep/octep_pfvf_mbox.c   |   23 +-
 .../ethernet/marvell/octeon_ep/octep_pfvf_mbox.h   |    6 +-
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c  |   11 +-
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.h  |    4 +-
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.c  |    7 +-
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.h  |    4 +-
 .../marvell/octeon_ep_vf/octep_vf_ethtool.c        |   29 +-
 .../ethernet/marvell/octeon_ep_vf/octep_vf_main.c  |   25 +-
 .../ethernet/marvell/octeon_ep_vf/octep_vf_main.h  |    6 +
 .../ethernet/marvell/octeon_ep_vf/octep_vf_rx.c    |    9 +-
 .../ethernet/marvell/octeon_ep_vf/octep_vf_rx.h    |    2 +-
 .../ethernet/marvell/octeon_ep_vf/octep_vf_tx.c    |    7 +-
 .../ethernet/marvell/octeon_ep_vf/octep_vf_tx.h    |    2 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |    4 +
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   68 +-
 .../net/ethernet/marvell/octeontx2/nic/Makefile    |    1 +
 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.c   | 1056 ++++++++
 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.h   |  265 ++
 .../ethernet/marvell/octeontx2/nic/cn10k_macsec.c  |    4 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |  114 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   28 +-
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c    |    3 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   19 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |   66 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.h |    3 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |   10 +-
 .../net/ethernet/marvell/prestera/prestera_main.c  |    1 +
 drivers/net/ethernet/mediatek/airoha_eth.c         |  567 +++-
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |    9 +-
 .../mellanox/mlx5/core/diag/fs_tracepoint.h        |    2 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc/ct_fs.h  |   10 +
 .../ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c |  292 +++
 .../ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c |   75 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c |   88 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.h |   10 +
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |   37 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |   20 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |    2 +-
 .../mellanox/mlx5/core/esw/acl/egress_lgcy.c       |    2 +-
 .../mellanox/mlx5/core/esw/acl/ingress_lgcy.c      |    2 +-
 .../net/ethernet/mellanox/mlx5/core/esw/bridge.c   |   20 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |    5 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   62 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |   62 +-
 .../net/ethernet/mellanox/mlx5/core/fs_counters.c  |  309 +--
 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c  |  195 ++
 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h  |   55 +
 drivers/net/ethernet/mellanox/mlx5/core/fw.c       |    6 +
 .../net/ethernet/mellanox/mlx5/core/lag/debugfs.c  |   13 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |  365 ++-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  |   17 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c   |   77 +-
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    |   16 +-
 .../net/ethernet/mellanox/mlx5/core/lag/port_sel.c |   55 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |   24 +-
 .../ethernet/mellanox/mlx5/core/lib/macsec_fs.c    |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   13 +-
 drivers/net/ethernet/mellanox/mlx5/core/rl.c       |    4 +
 .../mellanox/mlx5/core/steering/hws/action.c       |  159 +-
 .../mellanox/mlx5/core/steering/hws/action.h       |    9 +-
 .../ethernet/mellanox/mlx5/core/steering/hws/bwc.c |   72 +-
 .../ethernet/mellanox/mlx5/core/steering/hws/bwc.h |   18 +-
 .../ethernet/mellanox/mlx5/core/steering/hws/cmd.c |   95 +-
 .../ethernet/mellanox/mlx5/core/steering/hws/cmd.h |   13 +-
 .../mellanox/mlx5/core/steering/hws/context.c      |   35 +-
 .../mellanox/mlx5/core/steering/hws/context.h      |   10 +-
 .../mellanox/mlx5/core/steering/hws/debug.c        |   46 +-
 .../mellanox/mlx5/core/steering/hws/definer.c      |    2 +-
 .../mellanox/mlx5/core/steering/hws/definer.h      |    2 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.c       | 1377 ++++++++++
 .../mellanox/mlx5/core/steering/hws/fs_hws.h       |   80 +
 .../mellanox/mlx5/core/steering/hws/fs_hws_pools.c |  450 ++++
 .../mellanox/mlx5/core/steering/hws/fs_hws_pools.h |   73 +
 .../mellanox/mlx5/core/steering/hws/internal.h     |    1 -
 .../mellanox/mlx5/core/steering/hws/matcher.c      |  218 +-
 .../mellanox/mlx5/core/steering/hws/matcher.h      |   13 +-
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h      |    1 -
 .../mellanox/mlx5/core/steering/hws/pat_arg.c      |    2 +-
 .../mellanox/mlx5/core/steering/hws/pat_arg.h      |    2 +-
 .../mellanox/mlx5/core/steering/hws/pool.c         |    4 +-
 .../ethernet/mellanox/mlx5/core/steering/hws/prm.h |   42 -
 .../mellanox/mlx5/core/steering/hws/rule.c         |  143 +-
 .../mellanox/mlx5/core/steering/hws/rule.h         |   16 +-
 .../mellanox/mlx5/core/steering/hws/send.c         |   42 +-
 .../mellanox/mlx5/core/steering/hws/send.h         |    6 -
 .../mellanox/mlx5/core/steering/hws/table.c        |   22 +-
 .../mellanox/mlx5/core/steering/sws/dr_domain.c    |    2 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste.c       |    6 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste.h       |   19 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste_v0.c    |    6 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste_v1.c    |  207 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste_v1.h    |  147 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste_v2.c    |  169 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste_v2.h    |  168 ++
 .../mellanox/mlx5/core/steering/sws/dr_ste_v3.c    |  221 ++
 .../mellanox/mlx5/core/steering/sws/fs_dr.c        |    2 +-
 .../mellanox/mlx5/core/steering/sws/mlx5_ifc_dr.h  |   40 +
 .../mellanox/mlx5/core/steering/sws/mlx5dr.h       |    2 +-
 drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c    |    2 -
 drivers/net/ethernet/mellanox/mlxsw/core.c         |   21 +-
 drivers/net/ethernet/mellanox/mlxsw/core.h         |   14 +-
 drivers/net/ethernet/mellanox/mlxsw/i2c.c          |    2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |   48 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |  211 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |   11 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_flower.c  |   10 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c  |    8 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c |   44 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h |   28 -
 .../net/ethernet/mellanox/mlxsw/spectrum_trap.c    |    2 +-
 drivers/net/ethernet/mellanox/mlxsw/txheader.h     |   63 +
 drivers/net/ethernet/meta/fbnic/Makefile           |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h            |   20 +
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c    |  543 +++-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c         |  160 ++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h         |   28 +
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c      |   81 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c        |   53 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c        |   72 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h        |    7 +
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |   12 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h     |    7 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |    5 +-
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c    |    2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c        |    7 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c       |  238 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h       |   16 +-
 drivers/net/ethernet/microchip/lan743x_ethtool.c   |   21 -
 drivers/net/ethernet/microchip/lan743x_main.c      |   46 +-
 drivers/net/ethernet/microchip/lan743x_main.h      |    1 -
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |    2 +-
 .../ethernet/microchip/lan966x/lan966x_phylink.c   |    3 +-
 .../net/ethernet/microchip/lan966x/lan966x_port.c  |    4 +-
 drivers/net/ethernet/microchip/sparx5/Kconfig      |    1 +
 drivers/net/ethernet/microchip/sparx5/Makefile     |    4 +-
 .../ethernet/microchip/sparx5/lan969x/lan969x.c    |    9 +
 .../ethernet/microchip/sparx5/lan969x/lan969x.h    |   17 +
 .../microchip/sparx5/lan969x/lan969x_fdma.c        |  406 +++
 .../microchip/sparx5/lan969x/lan969x_rgmii.c       |  224 ++
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    |   68 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |   48 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   35 +-
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   |  145 +
 .../net/ethernet/microchip/sparx5/sparx5_packet.c  |   11 +-
 .../net/ethernet/microchip/sparx5/sparx5_phylink.c |   16 +-
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |   57 +-
 .../net/ethernet/microchip/sparx5/sparx5_port.h    |    5 +
 drivers/net/ethernet/mscc/ocelot_net.c             |   14 +-
 drivers/net/ethernet/mscc/ocelot_ptp.c             |   53 +-
 drivers/net/ethernet/mscc/ocelot_stats.c           |   37 +
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |    2 +-
 drivers/net/ethernet/pensando/ionic/ionic.h        |    3 -
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |   40 +
 drivers/net/ethernet/pensando/ionic/ionic_if.h     |   22 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |    9 +-
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |    3 +-
 .../net/ethernet/qlogic/netxen/netxen_nic_main.c   |   20 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c  |   69 +-
 drivers/net/ethernet/realtek/r8169.h               |    4 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  115 +-
 drivers/net/ethernet/realtek/r8169_phy_config.c    |   38 +-
 drivers/net/ethernet/realtek/rtase/rtase.h         |    1 +
 drivers/net/ethernet/realtek/rtase/rtase_main.c    |   14 +-
 drivers/net/ethernet/renesas/rswitch.c             |  119 +-
 drivers/net/ethernet/renesas/rswitch.h             |   48 +-
 drivers/net/ethernet/sfc/io.h                      |   24 -
 drivers/net/ethernet/sfc/net_driver.h              |    2 +
 drivers/net/ethernet/sfc/rx_common.c               |    5 +-
 drivers/net/ethernet/sfc/siena/net_driver.h        |    2 +
 drivers/net/ethernet/sfc/siena/rx_common.c         |    5 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   12 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 +
 drivers/net/ethernet/stmicro/stmmac/common.h       |   16 +-
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |   11 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |   37 +-
 .../net/ethernet/stmicro/stmmac/dwmac-intel-plat.c |   22 +-
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |   30 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c    |  202 ++
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   |   19 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    |   35 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |    9 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |    6 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h |    3 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |    5 +
 drivers/net/ethernet/stmicro/stmmac/hwif.c         |    6 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   19 +-
 drivers/net/ethernet/stmicro/stmmac/mmc.h          |    3 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   21 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h   |    2 +
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   64 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  328 ++-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h   |    3 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |   11 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.h   |    1 -
 drivers/net/ethernet/sun/niu.c                     |   22 +-
 drivers/net/ethernet/sunplus/spl2sw_driver.c       |    2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  452 ++--
 drivers/net/ethernet/ti/cpsw.c                     |    5 +-
 drivers/net/ethernet/ti/cpsw_ethtool.c             |   12 -
 drivers/net/ethernet/ti/cpsw_new.c                 |    5 +-
 drivers/net/ethernet/ti/cpsw_priv.h                |    1 -
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |  175 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h       |    8 +
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c   |    2 -
 drivers/net/ethernet/via/via-velocity.c            |    6 +-
 drivers/net/ethernet/xilinx/xilinx_axienet.h       |    3 +
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   37 +-
 drivers/net/geneve.c                               |   12 +-
 drivers/net/gtp.c                                  |    4 +-
 drivers/net/hyperv/hyperv_net.h                    |    2 +-
 drivers/net/hyperv/netvsc.c                        |    3 +-
 drivers/net/ipvlan/ipvlan_main.c                   |    6 +
 drivers/net/loopback.c                             |    5 +-
 drivers/net/mctp/mctp-i2c.c                        |    3 +-
 drivers/net/mdio/mdio-octeon.c                     |   25 +-
 drivers/net/mii.c                                  |    3 +
 drivers/net/netconsole.c                           |   62 +-
 drivers/net/netdevsim/ethtool.c                    |   12 +-
 drivers/net/netdevsim/netdev.c                     |  268 +-
 drivers/net/netdevsim/netdevsim.h                  |    8 +-
 drivers/net/netkit.c                               |   66 +-
 drivers/net/pcs/pcs-lynx.c                         |   39 +-
 drivers/net/pcs/pcs-mtk-lynxi.c                    |   25 +-
 drivers/net/pcs/pcs-xpcs.c                         |   40 +-
 drivers/net/phy/Kconfig                            |   14 +-
 drivers/net/phy/Makefile                           |    3 +-
 drivers/net/phy/adin.c                             |    2 +-
 drivers/net/phy/adin1100.c                         |    2 +-
 drivers/net/phy/air_en8811h.c                      |    2 +-
 drivers/net/phy/amd.c                              |    2 +-
 drivers/net/phy/aquantia/aquantia_main.c           |    2 +-
 drivers/net/phy/ax88796b.c                         |    2 +-
 drivers/net/phy/bcm-cygnus.c                       |    2 +-
 drivers/net/phy/bcm54140.c                         |    2 +-
 drivers/net/phy/bcm63xx.c                          |    2 +-
 drivers/net/phy/bcm7xxx.c                          |    2 +-
 drivers/net/phy/bcm84881.c                         |   12 +-
 drivers/net/phy/broadcom.c                         |    2 +-
 drivers/net/phy/cicada.c                           |    2 +-
 drivers/net/phy/cortina.c                          |    2 +-
 drivers/net/phy/davicom.c                          |    2 +-
 drivers/net/phy/dp83640.c                          |    2 +-
 drivers/net/phy/dp83822.c                          |  385 ++-
 drivers/net/phy/dp83848.c                          |    2 +-
 drivers/net/phy/dp83867.c                          |    2 +-
 drivers/net/phy/dp83869.c                          |    2 +-
 drivers/net/phy/dp83tc811.c                        |    2 +-
 drivers/net/phy/dp83td510.c                        |  114 +-
 drivers/net/phy/dp83tg720.c                        |  163 +-
 drivers/net/phy/et1011c.c                          |    2 +-
 drivers/net/phy/icplus.c                           |    2 +-
 drivers/net/phy/intel-xway.c                       |    2 +-
 drivers/net/phy/lxt.c                              |    2 +-
 drivers/net/phy/marvell-88q2xxx.c                  |    2 +-
 drivers/net/phy/marvell-88x2222.c                  |    2 +-
 drivers/net/phy/marvell.c                          |   54 +-
 drivers/net/phy/marvell10g.c                       |    2 +-
 drivers/net/phy/mediatek/mtk-ge-soc.c              |    2 +-
 drivers/net/phy/mediatek/mtk-ge.c                  |    2 +-
 drivers/net/phy/meson-gxl.c                        |    2 +-
 drivers/net/phy/micrel.c                           |    4 +-
 drivers/net/phy/microchip.c                        |    2 +-
 drivers/net/phy/microchip_rds_ptp.c                | 1309 +++++++++
 drivers/net/phy/microchip_rds_ptp.h                |  247 ++
 drivers/net/phy/microchip_t1.c                     |   53 +-
 drivers/net/phy/microchip_t1s.c                    |    2 +-
 drivers/net/phy/mscc/mscc_main.c                   |    2 +-
 drivers/net/phy/mxl-gpy.c                          |    2 +-
 drivers/net/phy/national.c                         |    2 +-
 drivers/net/phy/ncn26000.c                         |    2 +-
 drivers/net/phy/nxp-c45-tja11xx.c                  |    2 +-
 drivers/net/phy/nxp-cbtx.c                         |    2 +-
 drivers/net/phy/nxp-tja11xx.c                      |    2 +-
 drivers/net/phy/phy-c45.c                          |   14 +-
 drivers/net/phy/phy.c                              |  172 +-
 drivers/net/phy/phy_device.c                       |   83 +-
 drivers/net/phy/phylink.c                          |  588 ++++-
 drivers/net/phy/qcom/at803x.c                      |    2 +-
 drivers/net/phy/qcom/qca807x.c                     |    2 +-
 drivers/net/phy/qcom/qca808x.c                     |    2 +-
 drivers/net/phy/qcom/qca83xx.c                     |    2 +-
 drivers/net/phy/qsemi.c                            |    2 +-
 drivers/net/phy/realtek/Kconfig                    |   11 +
 drivers/net/phy/realtek/Makefile                   |    4 +
 drivers/net/phy/realtek/realtek.h                  |   10 +
 drivers/net/phy/realtek/realtek_hwmon.c            |   79 +
 .../net/phy/{realtek.c => realtek/realtek_main.c}  |   58 +-
 drivers/net/phy/rockchip.c                         |    2 +-
 drivers/net/phy/smsc.c                             |    2 +-
 drivers/net/phy/spi_ks8995.c                       |    8 +-
 drivers/net/phy/ste10Xp.c                          |    2 +-
 drivers/net/phy/teranetics.c                       |    2 +-
 drivers/net/phy/uPD60620.c                         |    2 +-
 drivers/net/phy/vitesse.c                          |    2 +-
 drivers/net/pse-pd/pd692x0.c                       |  224 +-
 drivers/net/pse-pd/pse_core.c                      |  183 +-
 drivers/net/pse-pd/pse_regulator.c                 |   23 +-
 drivers/net/pse-pd/tps23881.c                      |  449 +++-
 drivers/net/tap.c                                  |    6 +-
 drivers/net/team/team_core.c                       |    7 +
 drivers/net/tun.c                                  |   20 +-
 drivers/net/usb/lan78xx.c                          |  938 ++++---
 drivers/net/veth.c                                 |    4 +-
 drivers/net/vrf.c                                  |   49 +-
 drivers/net/vxlan/vxlan_core.c                     |  187 +-
 drivers/net/vxlan/vxlan_mdb.c                      |    2 +-
 drivers/net/wan/framer/framer-core.c               |   23 +-
 drivers/net/wireless/ath/ath11k/core.c             |  132 +
 drivers/net/wireless/ath/ath11k/core.h             |    4 +-
 drivers/net/wireless/ath/ath11k/dp.h               |    1 -
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   14 +-
 drivers/net/wireless/ath/ath11k/hal.h              |    6 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c           |    3 +-
 drivers/net/wireless/ath/ath11k/hw.h               |    1 +
 drivers/net/wireless/ath/ath11k/mac.c              |    7 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |    1 +
 drivers/net/wireless/ath/ath11k/pci.c              |    3 +
 drivers/net/wireless/ath/ath11k/pcic.c             |   13 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |    8 +-
 drivers/net/wireless/ath/ath11k/wow.c              |    6 +-
 drivers/net/wireless/ath/ath12k/core.c             |  747 +++++-
 drivers/net/wireless/ath/ath12k/core.h             |  179 +-
 drivers/net/wireless/ath/ath12k/coredump.c         |    3 +
 drivers/net/wireless/ath/ath12k/coredump.h         |    1 +
 drivers/net/wireless/ath/ath12k/debug.c            |    6 +-
 drivers/net/wireless/ath/ath12k/debug.h            |    5 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    | 1183 ++++++++-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |  373 ++-
 drivers/net/wireless/ath/ath12k/dp.c               |   84 +-
 drivers/net/wireless/ath/ath12k/dp.h               |   33 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |  156 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  327 ++-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |    6 +-
 drivers/net/wireless/ath/ath12k/fw.h               |    3 +
 drivers/net/wireless/ath/ath12k/hal.c              |    2 +-
 drivers/net/wireless/ath/ath12k/hal.h              |    2 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h         |    6 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c           |   12 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h           |   14 +-
 drivers/net/wireless/ath/ath12k/mac.c              | 2725 ++++++++++++++-----
 drivers/net/wireless/ath/ath12k/mac.h              |   27 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   10 +
 drivers/net/wireless/ath/ath12k/peer.c             |  225 +-
 drivers/net/wireless/ath/ath12k/peer.h             |   26 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |  489 +++-
 drivers/net/wireless/ath/ath12k/qmi.h              |   21 +
 drivers/net/wireless/ath/ath12k/wmi.c              |  430 ++-
 drivers/net/wireless/ath/ath12k/wmi.h              |  171 ++
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |    1 +
 drivers/net/wireless/ath/ath9k/antenna.c           |    2 +-
 drivers/net/wireless/ath/ath9k/ar9002_hw.c         |    2 +-
 drivers/net/wireless/ath/ath9k/ar9003_hw.c         |    2 +-
 drivers/net/wireless/ath/ath9k/ar9003_mci.c        |    4 +-
 drivers/net/wireless/ath/ath9k/ar9003_phy.h        |    2 +-
 drivers/net/wireless/ath/ath9k/ath9k.h             |   10 +-
 drivers/net/wireless/ath/ath9k/beacon.c            |    2 +-
 drivers/net/wireless/ath/ath9k/calib.c             |   24 +-
 drivers/net/wireless/ath/ath9k/channel.c           |   31 +-
 drivers/net/wireless/ath/ath9k/common-spectral.c   |    2 +-
 drivers/net/wireless/ath/ath9k/debug.c             |    1 +
 drivers/net/wireless/ath/ath9k/debug.h             |    1 +
 drivers/net/wireless/ath/ath9k/dfs.c               |    2 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |    2 +-
 drivers/net/wireless/ath/ath9k/hw.c                |   29 +-
 drivers/net/wireless/ath/ath9k/hw.h                |    4 +-
 drivers/net/wireless/ath/ath9k/link.c              |   33 +-
 drivers/net/wireless/ath/ath9k/mac.h               |    2 +-
 drivers/net/wireless/ath/ath9k/main.c              |   14 +-
 drivers/net/wireless/ath/ath9k/recv.c              |    4 +-
 drivers/net/wireless/ath/ath9k/wow.c               |    6 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |   54 +-
 drivers/net/wireless/ath/wcn36xx/main.c            |    5 +-
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |    5 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   14 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |    9 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwil.h    |    2 +
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c  |    8 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_n.c        |    3 +
 drivers/net/wireless/intel/iwlegacy/3945-mac.c     |   38 -
 drivers/net/wireless/intel/iwlegacy/3945.h         |    1 -
 drivers/net/wireless/intel/iwlegacy/common.c       |   31 -
 drivers/net/wireless/intel/iwlegacy/common.h       |    1 -
 drivers/net/wireless/intel/iwlwifi/Makefile        |    3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |   46 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   33 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |  167 ++
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   38 +-
 drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c    |    8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c  |   11 +
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |   78 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |   99 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |   49 +-
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |    6 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |   57 +-
 .../net/wireless/intel/iwlwifi/fw/api/offload.h    |    8 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |    8 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h   |    8 +-
 .../net/wireless/intel/iwlwifi/fw/api/time-event.h |   16 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |   32 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |   42 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |   11 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.c        |    2 +
 drivers/net/wireless/intel/iwlwifi/fw/img.h        |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/paging.c     |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |   62 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |   63 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |  101 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |   26 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   15 +-
 .../wireless/intel/iwlwifi/iwl-context-info-gen3.h |   40 +-
 .../net/wireless/intel/iwlwifi/iwl-context-info.h  |   32 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |   17 +-
 drivers/net/wireless/intel/iwlwifi/iwl-debug.h     |    3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  102 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |    6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h   |   79 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |    5 +
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |  223 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   93 +-
 drivers/net/wireless/intel/iwlwifi/iwl-utils.c     |   85 +
 drivers/net/wireless/intel/iwlwifi/iwl-utils.h     |   56 +
 drivers/net/wireless/intel/iwlwifi/mvm/binding.c   |    7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c      |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   29 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   77 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   93 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |   10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   55 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  121 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |   86 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |   27 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   36 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |  194 +-
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |   18 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   35 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   70 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c      |    6 +-
 .../net/wireless/intel/iwlwifi/mvm/tests/links.c   |    2 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   99 +-
 .../net/wireless/intel/iwlwifi/mvm/vendor-cmd.c    |    6 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |    8 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   67 +
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |    6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |    6 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   28 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  291 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  |    4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |    4 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |    2 +-
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/Makefile        |    2 +-
 drivers/net/wireless/mediatek/mt76/channel.c       |  406 +++
 drivers/net/wireless/mediatek/mt76/dma.c           |   22 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |  240 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |  154 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |    9 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    |   14 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |   11 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |    8 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c    |    6 +-
 .../net/wireless/mediatek/mt76/mt7615/pci_mac.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c   |    4 +-
 .../net/wireless/mediatek/mt76/mt7615/sdio_mcu.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c    |    4 +-
 .../net/wireless/mediatek/mt76/mt7615/usb_mcu.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |    4 +-
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.c  |    5 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |   45 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   79 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   23 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c  |    3 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/phy.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c |   21 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   24 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |   26 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   79 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |   34 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c    |    1 +
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h   |    7 +
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |    8 +
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |   18 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |  138 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   30 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h    |    5 +
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |    5 +
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |   10 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c    |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |   30 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |   28 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  130 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  236 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |   23 +
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |   33 +-
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c    |   20 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |   23 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |   48 +-
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |  150 +-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c |  216 +-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h |    2 +
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |  403 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   57 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  903 ++++---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  504 ++--
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  177 +-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |   12 +
 drivers/net/wireless/mediatek/mt76/scan.c          |  168 ++
 drivers/net/wireless/mediatek/mt76/sdio_txrx.c     |    4 +
 drivers/net/wireless/mediatek/mt76/tx.c            |   33 +-
 drivers/net/wireless/mediatek/mt76/usb.c           |    4 +-
 drivers/net/wireless/mediatek/mt76/util.c          |   10 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |    2 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   |    2 -
 drivers/net/wireless/microchip/wilc1000/sdio.c     |    9 +-
 drivers/net/wireless/microchip/wilc1000/spi.c      |    9 +-
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  |    2 +-
 drivers/net/wireless/quantenna/qtnfmac/core.h      |    2 +-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |    6 -
 drivers/net/wireless/realtek/rtl8xxxu/8188e.c      |    2 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |   20 +
 drivers/net/wireless/realtek/rtlwifi/base.c        |   13 +-
 drivers/net/wireless/realtek/rtlwifi/base.h        |    1 -
 drivers/net/wireless/realtek/rtlwifi/pci.c         |   61 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/sw.c    |    7 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/fw.h    |    4 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/phy.c   |    4 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c         |   12 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   12 -
 drivers/net/wireless/realtek/rtw88/Kconfig         |    5 +
 drivers/net/wireless/realtek/rtw88/Makefile        |    2 +
 drivers/net/wireless/realtek/rtw88/fw.c            |    7 +-
 drivers/net/wireless/realtek/rtw88/led.c           |   73 +
 drivers/net/wireless/realtek/rtw88/led.h           |   25 +
 drivers/net/wireless/realtek/rtw88/main.c          |   21 +-
 drivers/net/wireless/realtek/rtw88/main.h          |   10 +-
 drivers/net/wireless/realtek/rtw88/reg.h           |   22 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |    8 +-
 drivers/net/wireless/realtek/rtw88/rtw8723x.h      |    8 +-
 drivers/net/wireless/realtek/rtw88/rtw8812a.c      |   22 +-
 drivers/net/wireless/realtek/rtw88/rtw8812au.c     |   68 +-
 drivers/net/wireless/realtek/rtw88/rtw8821a.c      |   28 +-
 drivers/net/wireless/realtek/rtw88/rtw8821au.c     |   52 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |   19 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.h      |    9 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |   19 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.h      |    9 +-
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c     |    6 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |   19 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.h      |    9 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |    2 +
 drivers/net/wireless/realtek/rtw88/usb.c           |  267 +-
 drivers/net/wireless/realtek/rtw88/usb.h           |    3 +
 drivers/net/wireless/realtek/rtw89/Kconfig         |    6 +-
 drivers/net/wireless/realtek/rtw89/acpi.c          |   47 +
 drivers/net/wireless/realtek/rtw89/acpi.h          |    9 +
 drivers/net/wireless/realtek/rtw89/cam.c           |   32 +-
 drivers/net/wireless/realtek/rtw89/cam.h           |    5 +
 drivers/net/wireless/realtek/rtw89/chan.c          |   31 +-
 drivers/net/wireless/realtek/rtw89/chan.h          |    9 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  193 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  163 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |    7 +
 drivers/net/wireless/realtek/rtw89/fw.c            |  332 ++-
 drivers/net/wireless/realtek/rtw89/fw.h            |   85 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |  173 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   43 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  301 ++-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |   15 +
 drivers/net/wireless/realtek/rtw89/pci.c           |   40 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |   13 +-
 drivers/net/wireless/realtek/rtw89/pci_be.c        |    1 +
 drivers/net/wireless/realtek/rtw89/phy.c           |  323 ++-
 drivers/net/wireless/realtek/rtw89/phy.h           |   37 +-
 drivers/net/wireless/realtek/rtw89/ps.c            |   42 +-
 drivers/net/wireless/realtek/rtw89/ps.h            |    4 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |    4 +
 drivers/net/wireless/realtek/rtw89/regd.c          |   57 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    6 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    7 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |    3 +
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |   50 +-
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |    3 +
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c    |   10 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   54 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |    6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   27 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.h      |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |   17 +-
 drivers/net/wireless/realtek/rtw89/sar.c           |   57 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |    1 +
 drivers/net/wireless/realtek/rtw89/txrx.h          |    3 +
 drivers/net/wireless/realtek/rtw89/wow.c           |   11 +-
 drivers/net/wireless/ti/wlcore/main.c              |   10 +-
 drivers/net/wireless/ti/wlcore/sysfs.c             |    4 +-
 drivers/net/wireless/ti/wlcore/testmode.c          |    2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   39 +
 drivers/net/wwan/iosm/iosm_ipc_pcie.c              |   56 +-
 drivers/net/wwan/t7xx/t7xx_pci.c                   |   23 +-
 drivers/nfc/nfcmrvl/uart.c                         |    9 +-
 drivers/nfc/st21nfca/dep.c                         |   18 +-
 drivers/nfc/st21nfca/i2c.c                         |    1 -
 drivers/ptp/ptp_ocp.c                              |   16 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |    3 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |    4 +-
 include/linux/bpf.h                                |   12 +-
 include/linux/etherdevice.h                        |   18 +-
 include/linux/ethtool.h                            |   67 +-
 include/linux/filter.h                             |    9 +-
 include/linux/ieee80211.h                          |  100 +-
 include/linux/if_hsr.h                             |   17 +
 include/linux/if_vlan.h                            |   41 +-
 include/linux/igmp.h                               |    2 +
 include/linux/ktime.h                              |    5 +
 include/linux/mlx5/device.h                        |    4 +
 include/linux/mlx5/driver.h                        |    4 +-
 include/linux/mlx5/fs.h                            |    4 +-
 include/linux/mlx5/mlx5_ifc.h                      |  133 +-
 include/linux/mroute_base.h                        |    6 +-
 include/linux/net.h                                |    2 -
 include/linux/net_tstamp.h                         |   29 +
 include/linux/netdevice.h                          |  202 +-
 include/linux/netfilter/x_tables.h                 |    2 +-
 include/linux/netfilter_netdev.h                   |    3 +-
 include/linux/netpoll.h                            |    2 +-
 include/linux/packing.h                            |  425 +++
 include/linux/pci.h                                |   14 +
 include/linux/pcs/pcs-xpcs.h                       |    1 -
 include/linux/phy.h                                |  137 +-
 include/linux/phylib_stubs.h                       |   42 +
 include/linux/phylink.h                            |   76 +-
 include/linux/pldmfw.h                             |    8 +
 include/linux/pse-pd/pse.h                         |  134 +-
 include/linux/ptp_clock_kernel.h                   |    4 +-
 include/linux/ptr_ring.h                           |   21 +-
 include/linux/rfkill.h                             |    2 +-
 include/linux/rtnetlink.h                          |   14 +-
 include/linux/skb_array.h                          |   17 +-
 include/linux/skbuff.h                             |   65 +-
 include/linux/stmmac.h                             |   10 +-
 include/linux/wwan.h                               |    2 +-
 include/net/addrconf.h                             |   29 +
 include/net/ax25.h                                 |   10 +-
 include/net/bluetooth/hci.h                        |    1 -
 include/net/bluetooth/hci_core.h                   |   14 +-
 include/net/bluetooth/hci_sync.h                   |    1 -
 include/net/cfg80211.h                             |   75 +-
 include/net/devlink.h                              |   25 +-
 include/net/dropreason-core.h                      |   88 +-
 include/net/dsa.h                                  |    6 +-
 include/net/dst.h                                  |   11 +-
 include/net/genetlink.h                            |    6 +-
 include/net/inet_sock.h                            |    8 +-
 include/net/inet_timewait_sock.h                   |    4 +
 include/net/inetpeer.h                             |   12 +-
 include/net/ip.h                                   |    2 +-
 include/net/ipv6.h                                 |    2 +-
 include/net/iucv/iucv.h                            |   30 +-
 include/net/mac80211.h                             |   56 +-
 include/net/macsec.h                               |    4 +-
 include/net/net_namespace.h                        |    2 +
 include/net/netdev_queues.h                        |   10 +
 include/net/netfilter/nf_conntrack.h               |   18 +-
 include/net/netfilter/nf_conntrack_ecache.h        |   12 +
 include/net/netfilter/nf_flow_table.h              |    1 +
 include/net/netfilter/nf_tables.h                  |   10 +-
 include/net/netfilter/nf_tproxy.h                  |    4 +-
 include/net/netlink.h                              |   44 +-
 include/net/netmem.h                               |   78 +-
 include/net/netns/ipv4.h                           |    1 +
 include/net/page_pool/helpers.h                    |   82 +-
 include/net/page_pool/types.h                      |   11 +-
 include/net/pkt_cls.h                              |   17 +-
 include/net/route.h                                |   42 +-
 include/net/sch_generic.h                          |   13 +-
 include/net/sock.h                                 |    8 +-
 include/net/tcp.h                                  |    2 +-
 include/net/tls.h                                  |    3 +
 include/net/vxlan.h                                |    1 +
 include/net/xdp.h                                  |  193 +-
 include/net/xdp_sock_drv.h                         |   29 +-
 include/net/xfrm.h                                 |   44 +
 include/net/xsk_buff_pool.h                        |    4 +-
 include/soc/mscc/ocelot.h                          |   11 +
 include/trace/events/fib6.h                        |    8 +-
 include/trace/events/rxrpc.h                       |  878 ++++++-
 include/uapi/asm-generic/socket.h                  |    2 +
 include/uapi/linux/ethtool.h                       |    2 +
 include/uapi/linux/ethtool_netlink.h               |  899 +------
 include/uapi/linux/ethtool_netlink_generated.h     |  821 ++++++
 include/uapi/linux/fib_rules.h                     |    2 +
 include/uapi/linux/if_link.h                       |    3 +
 include/uapi/linux/in.h                            |    2 +
 include/uapi/linux/ip.h                            |   16 +
 include/uapi/linux/ipsec.h                         |    3 +-
 include/uapi/linux/mdio.h                          |    1 +
 include/uapi/linux/net_tstamp.h                    |   11 +
 include/uapi/linux/netfilter/nfnetlink_conntrack.h |    1 +
 include/uapi/linux/nl80211.h                       |   28 +
 include/uapi/linux/rtnetlink.h                     |   19 +-
 include/uapi/linux/snmp.h                          |    8 +
 include/uapi/linux/xfrm.h                          |    9 +-
 kernel/bpf/cpumap.c                                |    2 +-
 kernel/bpf/devmap.c                                |    8 +-
 lib/packing.c                                      |  293 ++-
 lib/packing_test.c                                 |   61 +
 lib/pldmfw/pldmfw.c                                |    8 +
 lib/win_minmax.c                                   |    1 +
 net/appletalk/aarp.c                               |   45 +-
 net/ax25/af_ax25.c                                 |   12 +-
 net/ax25/ax25_dev.c                                |    4 +-
 net/ax25/ax25_ip.c                                 |    3 +-
 net/ax25/ax25_out.c                                |   22 +-
 net/ax25/ax25_route.c                              |    2 +
 net/batman-adv/bridge_loop_avoidance.c             |   33 +-
 net/batman-adv/distributed-arp-table.c             |   20 +-
 net/batman-adv/gateway_client.c                    |   18 +-
 net/batman-adv/main.c                              |    7 +
 net/batman-adv/main.h                              |    4 +-
 net/batman-adv/multicast.c                         |   17 +-
 net/batman-adv/netlink.c                           |  146 +-
 net/batman-adv/netlink.h                           |    5 +-
 net/batman-adv/originator.c                        |  116 +-
 net/batman-adv/soft-interface.c                    |   16 +-
 net/batman-adv/translation-table.c                 |   92 +-
 net/batman-adv/types.h                             |    4 +-
 net/bluetooth/hci_core.c                           |   24 +-
 net/bluetooth/hci_sync.c                           |   76 +-
 net/bluetooth/hci_sysfs.c                          |   19 +
 net/bluetooth/iso.c                                |   36 +
 net/bluetooth/l2cap_sock.c                         |    3 +-
 net/bluetooth/mgmt.c                               |  145 +-
 net/bpf/test_run.c                                 |    4 +-
 net/bridge/br.c                                    |    7 +
 net/bridge/br_arp_nd_proxy.c                       |    2 +-
 net/bridge/br_fdb.c                                |    3 +-
 net/bridge/br_forward.c                            |   16 +-
 net/bridge/br_input.c                              |   20 +-
 net/bridge/br_netfilter_hooks.c                    |   30 +-
 net/bridge/br_private.h                            |   11 +-
 net/bridge/br_sysfs_br.c                           |    6 +-
 net/bridge/br_vlan.c                               |   44 +-
 net/can/raw.c                                      |    2 +-
 net/core/dev.c                                     |  545 +++-
 net/core/dev.h                                     |   33 +-
 net/core/dev_addr_lists.c                          |    7 +-
 net/core/dev_ioctl.c                               |   73 +-
 net/core/devmem.c                                  |   21 +-
 net/core/fib_rules.c                               |    2 +
 net/core/filter.c                                  |   46 +-
 net/core/net-sysfs.c                               |   39 +-
 net/core/net_namespace.c                           |    5 +
 net/core/netdev-genl.c                             |   63 +-
 net/core/netdev_rx_queue.c                         |    1 +
 net/core/netpoll.c                                 |   10 +-
 net/core/page_pool.c                               |  139 +-
 net/core/pktgen.c                                  |    7 +-
 net/core/rtnetlink.c                               |  119 +-
 net/core/rtnl_net_debug.c                          |   15 +-
 net/core/skbuff.c                                  |    2 +-
 net/core/sock.c                                    |   26 +-
 net/core/sysctl_net_core.c                         |    5 +-
 net/core/timestamping.c                            |   52 +-
 net/core/xdp.c                                     |  327 ++-
 net/dccp/ipv4.c                                    |    3 +-
 net/dccp/sysctl.c                                  |    4 -
 net/devlink/health.c                               |   67 +
 net/devlink/port.c                                 |   11 +-
 net/dsa/port.c                                     |   16 +
 net/dsa/user.c                                     |   34 +-
 net/ethtool/Makefile                               |    2 +-
 net/ethtool/common.c                               |  152 +-
 net/ethtool/common.h                               |   13 +
 net/ethtool/linkstate.c                            |   26 +-
 net/ethtool/netlink.c                              |   56 +-
 net/ethtool/netlink.h                              |   11 +-
 net/ethtool/pse-pd.c                               |    8 +-
 net/ethtool/rings.c                                |   55 +-
 net/ethtool/stats.c                                |   55 +
 net/ethtool/strset.c                               |    5 +
 net/ethtool/ts.h                                   |   20 +
 net/ethtool/tsconfig.c                             |  444 ++++
 net/ethtool/tsinfo.c                               |  360 ++-
 net/hsr/hsr_device.c                               |   13 +
 net/hsr/hsr_main.h                                 |   10 +-
 net/hsr/hsr_slave.c                                |    5 +-
 net/ipv4/af_inet.c                                 |   14 +-
 net/ipv4/datagram.c                                |   11 +-
 net/ipv4/esp4.c                                    |    3 +-
 net/ipv4/fib_rules.c                               |    6 +
 net/ipv4/fib_trie.c                                |    4 +-
 net/ipv4/icmp.c                                    |    9 +-
 net/ipv4/igmp.c                                    |   66 +
 net/ipv4/inet_connection_sock.c                    |   11 +-
 net/ipv4/inetpeer.c                                |   49 +-
 net/ipv4/ip_fragment.c                             |   15 +-
 net/ipv4/ip_gre.c                                  |   17 +-
 net/ipv4/ip_input.c                                |   11 +-
 net/ipv4/ip_output.c                               |   33 +-
 net/ipv4/ip_sockglue.c                             |    2 +-
 net/ipv4/ipmr.c                                    |   28 +-
 net/ipv4/ipmr_base.c                               |    6 +-
 net/ipv4/proc.c                                    |    1 +
 net/ipv4/raw.c                                     |    2 +-
 net/ipv4/route.c                                   |   26 +-
 net/ipv4/sysctl_net_ipv4.c                         |   10 +
 net/ipv4/tcp_cubic.c                               |    8 +-
 net/ipv4/tcp_input.c                               |   84 +-
 net/ipv4/tcp_ipv4.c                                |    7 +-
 net/ipv4/tcp_minisocks.c                           |    7 +-
 net/ipv4/udp.c                                     |   56 +
 net/ipv6/addrconf.c                                |  287 +-
 net/ipv6/anycast.c                                 |   35 +
 net/ipv6/esp6.c                                    |    3 +-
 net/ipv6/fib6_rules.c                              |   57 +-
 net/ipv6/icmp.c                                    |    6 +-
 net/ipv6/ioam6_iptunnel.c                          |   73 +-
 net/ipv6/ip6_output.c                              |   22 +-
 net/ipv6/ip6mr.c                                   |   28 +-
 net/ipv6/mcast.c                                   |  100 +-
 net/ipv6/ndisc.c                                   |    8 +-
 net/ipv6/ping.c                                    |    1 +
 net/ipv6/raw.c                                     |    3 +-
 net/ipv6/route.c                                   |   20 +-
 net/ipv6/rpl_iptunnel.c                            |   46 +-
 net/ipv6/seg6_iptunnel.c                           |   85 +-
 net/ipv6/udp.c                                     |   51 +
 net/l2tp/l2tp_eth.c                                |    9 +-
 net/l2tp/l2tp_ip.c                                 |   19 +-
 net/llc/sysctl_net_llc.c                           |    4 -
 net/mac80211/cfg.c                                 |   42 +-
 net/mac80211/chan.c                                |    7 +
 net/mac80211/debug.h                               |   10 +-
 net/mac80211/debugfs.c                             |    4 +-
 net/mac80211/debugfs_key.c                         |   47 -
 net/mac80211/debugfs_key.h                         |   15 -
 net/mac80211/debugfs_netdev.c                      |    2 +-
 net/mac80211/driver-ops.h                          |   10 +-
 net/mac80211/ethtool.c                             |   22 +-
 net/mac80211/he.c                                  |  119 +-
 net/mac80211/ibss.c                                |    3 +-
 net/mac80211/ieee80211_i.h                         |   25 +-
 net/mac80211/iface.c                               |   29 +-
 net/mac80211/key.c                                 |    2 +-
 net/mac80211/main.c                                |   14 +-
 net/mac80211/mesh_plink.c                          |    5 +-
 net/mac80211/mlme.c                                | 1200 +++++++--
 net/mac80211/parse.c                               |   29 +
 net/mac80211/rx.c                                  |   20 +-
 net/mac80211/sta_info.c                            |   23 +-
 net/mac80211/sta_info.h                            |   12 +-
 net/mac80211/tests/Makefile                        |    2 +-
 net/mac80211/tests/util.c                          |  313 +++
 net/mac80211/tests/util.h                          |   36 +
 net/mac80211/trace.h                               |  130 +-
 net/mac80211/util.c                                |   64 +-
 net/mac80211/vht.c                                 |   33 +-
 net/mac802154/ieee802154_i.h                       |    3 -
 net/mac802154/tx.c                                 |   13 -
 net/mctp/device.c                                  |   50 +-
 net/mptcp/ctrl.c                                   |   21 +-
 net/mptcp/pm_netlink.c                             |   46 +-
 net/mptcp/pm_userspace.c                           |  295 +--
 net/mptcp/protocol.c                               |    8 +-
 net/mptcp/protocol.h                               |    7 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |   50 +-
 net/netfilter/nf_conntrack_amanda.c                |    2 +-
 net/netfilter/nf_conntrack_broadcast.c             |    2 +-
 net/netfilter/nf_conntrack_core.c                  |   13 +-
 net/netfilter/nf_conntrack_ecache.c                |   23 +
 net/netfilter/nf_conntrack_h323_main.c             |    4 +-
 net/netfilter/nf_conntrack_netlink.c               |   25 +
 net/netfilter/nf_conntrack_sip.c                   |    4 +-
 net/netfilter/nf_flow_table_core.c                 |  187 +-
 net/netfilter/nf_flow_table_ip.c                   |   14 +-
 net/netfilter/nf_tables_api.c                      |  130 +-
 net/netfilter/nft_chain_filter.c                   |   48 +-
 net/netfilter/nft_ct.c                             |    2 +-
 net/netfilter/nft_flow_offload.c                   |   16 +-
 net/netfilter/nft_set_rbtree.c                     |   43 +
 net/netfilter/nft_xfrm.c                           |    3 +-
 net/netfilter/xt_hashlimit.c                       |    6 +-
 net/netlink/af_netlink.c                           |    1 +
 net/packet/af_packet.c                             |    2 +-
 net/rose/af_rose.c                                 |   16 +-
 net/rxrpc/Makefile                                 |    1 +
 net/rxrpc/af_rxrpc.c                               |    4 +-
 net/rxrpc/ar-internal.h                            |  342 ++-
 net/rxrpc/call_accept.c                            |   22 +-
 net/rxrpc/call_event.c                             |  385 ++-
 net/rxrpc/call_object.c                            |   66 +-
 net/rxrpc/conn_client.c                            |   26 +-
 net/rxrpc/conn_event.c                             |   40 +-
 net/rxrpc/conn_object.c                            |   14 +-
 net/rxrpc/input.c                                  |  706 +++--
 net/rxrpc/input_rack.c                             |  418 +++
 net/rxrpc/insecure.c                               |    5 +-
 net/rxrpc/io_thread.c                              |  113 +-
 net/rxrpc/local_object.c                           |    3 -
 net/rxrpc/misc.c                                   |    4 +-
 net/rxrpc/output.c                                 |  568 ++--
 net/rxrpc/peer_event.c                             |  114 +-
 net/rxrpc/peer_object.c                            |   30 +-
 net/rxrpc/proc.c                                   |   61 +-
 net/rxrpc/protocol.h                               |   13 +-
 net/rxrpc/recvmsg.c                                |   18 +-
 net/rxrpc/rtt.c                                    |  103 +-
 net/rxrpc/rxkad.c                                  |   59 +-
 net/rxrpc/rxperf.c                                 |    2 +-
 net/rxrpc/security.c                               |    4 +-
 net/rxrpc/sendmsg.c                                |  100 +-
 net/rxrpc/sysctl.c                                 |    6 +-
 net/rxrpc/txbuf.c                                  |  127 +-
 net/sched/cls_api.c                                |   57 +-
 net/sched/cls_bpf.c                                |    2 +
 net/sched/cls_flower.c                             |    2 +
 net/sched/cls_matchall.c                           |    2 +
 net/sched/cls_u32.c                                |    4 +
 net/sched/sch_api.c                                |   10 +-
 net/sched/sch_cake.c                               |   45 +-
 net/sched/sch_codel.c                              |    5 +-
 net/sched/sch_fq.c                                 |   14 +-
 net/sched/sch_fq_codel.c                           |    3 +-
 net/sched/sch_fq_pie.c                             |    6 +-
 net/sched/sch_generic.c                            |   59 +-
 net/sched/sch_gred.c                               |    4 +-
 net/sched/sch_pie.c                                |    5 +-
 net/sched/sch_red.c                                |    4 +-
 net/sched/sch_sfb.c                                |    4 +-
 net/sched/sch_sfq.c                                |    4 +
 net/sctp/protocol.c                                |   10 +-
 net/shaper/shaper.c                                |    6 +-
 net/smc/af_smc.c                                   |    7 +-
 net/smc/smc_core.c                                 |    7 +-
 net/smc/smc_core.h                                 |   11 +-
 net/smc/smc_ib.c                                   |    3 +-
 net/smc/smc_llc.c                                  |   21 +-
 net/smc/smc_rx.c                                   |   39 +-
 net/smc/smc_rx.h                                   |    8 +-
 net/smc/smc_wr.c                                   |   42 +-
 net/socket.c                                       |   41 +-
 net/tipc/crypto.c                                  |    4 +-
 net/tipc/name_table.c                              |    4 +-
 net/tipc/name_table.h                              |    2 +
 net/tls/tls.h                                      |    3 +-
 net/tls/tls_device.c                               |    2 +-
 net/tls/tls_main.c                                 |   75 +-
 net/tls/tls_proc.c                                 |    5 +
 net/tls/tls_sw.c                                   |  140 +-
 net/unix/Kconfig                                   |    4 +-
 net/unix/af_unix.c                                 |  239 +-
 net/unix/garbage.c                                 |    2 +-
 net/wireless/chan.c                                |  374 +--
 net/wireless/core.c                                |   42 +-
 net/wireless/core.h                                |    4 +
 net/wireless/mlme.c                                |   92 +-
 net/wireless/nl80211.c                             |  574 ++--
 net/wireless/nl80211.h                             |    3 +
 net/wireless/pmsr.c                                |    4 +-
 net/wireless/rdev-ops.h                            |   41 +-
 net/wireless/reg.c                                 |   55 +-
 net/wireless/scan.c                                |   87 +-
 net/wireless/sme.c                                 |   12 +-
 net/wireless/tests/scan.c                          |    2 +
 net/wireless/trace.h                               |  122 +-
 net/wireless/util.c                                |    7 +-
 net/wireless/wext-compat.c                         |  317 +--
 net/wireless/wext-sme.c                            |   43 +-
 net/xfrm/Kconfig                                   |   16 +
 net/xfrm/Makefile                                  |    1 +
 net/xfrm/trace_iptfs.h                             |  218 ++
 net/xfrm/xfrm_compat.c                             |   10 +-
 net/xfrm/xfrm_device.c                             |    4 +-
 net/xfrm/xfrm_input.c                              |   27 +-
 net/xfrm/xfrm_iptfs.c                              | 2764 ++++++++++++++++++++
 net/xfrm/xfrm_output.c                             |    6 +
 net/xfrm/xfrm_policy.c                             |   26 +-
 net/xfrm/xfrm_proc.c                               |    2 +
 net/xfrm/xfrm_replay.c                             |    1 +
 net/xfrm/xfrm_state.c                              |   84 +
 net/xfrm/xfrm_user.c                               |   77 +
 rust/kernel/net/phy.rs                             |    4 +-
 scripts/.gitignore                                 |    1 +
 scripts/Makefile                                   |    2 +-
 scripts/checkpatch.pl                              |    2 +
 scripts/gen_packed_field_checks.c                  |   37 +
 tools/include/uapi/asm-generic/socket.h            |    2 +
 tools/include/uapi/linux/if_link.h                 |    2 +
 tools/net/ynl/Makefile                             |   29 +-
 tools/net/ynl/generated/.gitignore                 |    1 +
 tools/net/ynl/generated/Makefile                   |   51 +-
 tools/net/ynl/lib/.gitignore                       |    1 -
 tools/net/ynl/lib/Makefile                         |    1 -
 tools/net/ynl/pyproject.toml                       |   24 +
 tools/net/ynl/pyynl/.gitignore                     |    2 +
 tools/net/ynl/pyynl/__init__.py                    |    0
 tools/net/ynl/{ => pyynl}/cli.py                   |   45 +-
 tools/net/ynl/{ => pyynl}/ethtool.py               |    7 +-
 tools/net/ynl/{ => pyynl}/lib/__init__.py          |    0
 tools/net/ynl/{ => pyynl}/lib/nlspec.py            |    5 +-
 tools/net/ynl/{ => pyynl}/lib/ynl.py               |   74 +-
 tools/net/ynl/{ynl-gen-c.py => pyynl/ynl_gen_c.py} |  185 +-
 .../ynl/{ynl-gen-rst.py => pyynl/ynl_gen_rst.py}   |    0
 tools/net/ynl/ynl-regen.sh                         |    2 +-
 tools/testing/selftests/bpf/Makefile               |    1 -
 tools/testing/selftests/bpf/prog_tests/tc_netkit.c |   49 +-
 .../bpf/prog_tests/xdp_context_test_run.c          |   87 +
 tools/testing/selftests/bpf/progs/test_tc_link.c   |   15 +
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |    4 +-
 tools/testing/selftests/bpf/test_xdp_meta.sh       |   58 -
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |    3 +-
 tools/testing/selftests/drivers/net/Makefile       |    3 +
 .../testing/selftests/drivers/net/bonding/Makefile |    2 +-
 .../selftests/drivers/net/bonding/bond_macvlan.sh  |   99 -
 .../drivers/net/bonding/bond_macvlan_ipvlan.sh     |   96 +
 tools/testing/selftests/drivers/net/bonding/config |    1 +
 tools/testing/selftests/drivers/net/hds.py         |  120 +
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  |    3 -
 .../selftests/drivers/net/hw/pp_alloc_fail.py      |    6 +-
 tools/testing/selftests/drivers/net/lib/py/env.py  |   10 +-
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  225 ++
 .../selftests/drivers/net/mlxsw/rif_bridge.sh      |    1 +
 .../testing/selftests/drivers/net/mlxsw/rif_lag.sh |    1 +
 .../selftests/drivers/net/mlxsw/rif_lag_vlan.sh    |    1 +
 .../testing/selftests/drivers/net/netcons_basic.sh |  218 +-
 .../selftests/drivers/net/netcons_overflow.sh      |   67 +
 tools/testing/selftests/drivers/net/stats.py       |   94 +-
 tools/testing/selftests/kselftest/ktap_helpers.sh  |   15 +-
 tools/testing/selftests/net/Makefile               |    2 +
 tools/testing/selftests/net/busy_poller.c          |   88 +-
 tools/testing/selftests/net/cmsg_sender.c          |   11 +-
 tools/testing/selftests/net/cmsg_so_priority.sh    |  151 ++
 tools/testing/selftests/net/cmsg_time.sh           |   35 +-
 tools/testing/selftests/net/fdb_notify.sh          |    6 +-
 tools/testing/selftests/net/fib_rule_tests.sh      |   31 +
 tools/testing/selftests/net/forwarding/Makefile    |    1 +
 .../net/forwarding/bridge_vlan_unaware.sh          |   25 +-
 tools/testing/selftests/net/forwarding/lib.sh      |   11 +-
 .../net/forwarding/mirror_gre_bridge_1q_lag.sh     |    1 +
 .../net/forwarding/mirror_gre_lag_lacp.sh          |    1 +
 .../net/forwarding/router_bridge_1d_lag.sh         |    1 +
 .../selftests/net/forwarding/router_bridge_lag.sh  |    1 +
 .../selftests/net/forwarding/vxlan_reserved.sh     |  352 +++
 tools/testing/selftests/net/ipsec.c                |    3 +-
 tools/testing/selftests/net/lib.sh                 |   68 +-
 tools/testing/selftests/net/lib/py/ksft.py         |    5 +
 tools/testing/selftests/net/lib/py/utils.py        |    6 +-
 tools/testing/selftests/net/lib/py/ynl.py          |    4 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |   13 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |    9 +-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   21 +
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |   17 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   21 +-
 tools/testing/selftests/net/nl_netdev.py           |   19 +-
 .../selftests/net/packetdrill/ksft_runner.sh       |   24 +-
 .../packetdrill/tcp_blocking_blocking-accept.pkt   |   18 +
 .../packetdrill/tcp_blocking_blocking-connect.pkt  |   13 +
 .../net/packetdrill/tcp_blocking_blocking-read.pkt |   29 +
 .../packetdrill/tcp_blocking_blocking-write.pkt    |   35 +
 ...tcp_close_close-local-close-then-remote-fin.pkt |   23 +
 .../packetdrill/tcp_close_close-on-syn-sent.pkt    |   21 +
 .../tcp_close_close-remote-fin-then-close.pkt      |   36 +
 .../net/packetdrill/tcp_ecn_ecn-uses-ect0.pkt      |   21 +
 .../net/packetdrill/tcp_eor_no-coalesce-large.pkt  |   38 +
 .../packetdrill/tcp_eor_no-coalesce-retrans.pkt    |   72 +
 .../net/packetdrill/tcp_eor_no-coalesce-small.pkt  |   36 +
 .../packetdrill/tcp_eor_no-coalesce-subsequent.pkt |   66 +
 .../tcp_fast_recovery_prr-ss-10pkt-lost-1.pkt      |   72 +
 ...p_fast_recovery_prr-ss-30pkt-lost-1_4-11_16.pkt |   50 +
 .../tcp_fast_recovery_prr-ss-30pkt-lost1_4.pkt     |   43 +
 ...ast_recovery_prr-ss-ack-below-snd_una-cubic.pkt |   41 +
 ...p_limited_transmit_limited-transmit-no-sack.pkt |   53 +
 .../tcp_limited_transmit_limited-transmit-sack.pkt |   50 +
 .../net/packetdrill/tcp_nagle_https_client.pkt     |   40 +
 .../net/packetdrill/tcp_nagle_sendmsg_msg_more.pkt |   66 +
 .../packetdrill/tcp_nagle_sockopt_cork_nodelay.pkt |   43 +
 .../tcp_sack_sack-route-refresh-ip-tos.pkt         |   37 +
 ...tcp_sack_sack-shift-sacked-2-6-8-3-9-nofack.pkt |   64 +
 .../tcp_sack_sack-shift-sacked-7-3-4-8-9-fack.pkt  |   66 +
 .../tcp_sack_sack-shift-sacked-7-5-6-8-9-fack.pkt  |   62 +
 .../packetdrill/tcp_sendfile_sendfile-simple.pkt   |   26 +
 .../tcp_splice_tcp_splice_loop_test.pkt            |   20 +
 ...cp_syscall_bad_arg_fastopen-invalid-buf-ptr.pkt |   42 +
 .../tcp_syscall_bad_arg_sendmsg-empty-iov.pkt      |   30 +
 ...tcp_syscall_bad_arg_syscall-invalid-buf-ptr.pkt |   25 +
 .../tcp_tcp_info_tcp-info-last_data_recv.pkt       |   20 +
 .../tcp_tcp_info_tcp-info-rwnd-limited.pkt         |   54 +
 .../tcp_tcp_info_tcp-info-sndbuf-limited.pkt       |   38 +
 .../tcp_timestamping_client-only-last-byte.pkt     |   92 +
 .../net/packetdrill/tcp_timestamping_partial.pkt   |   91 +
 .../net/packetdrill/tcp_timestamping_server.pkt    |  145 +
 .../net/packetdrill/tcp_ts_recent_fin_tsval.pkt    |   23 +
 .../net/packetdrill/tcp_ts_recent_invalid_ack.pkt  |   25 +
 .../net/packetdrill/tcp_ts_recent_reset_tsval.pkt  |   25 +
 .../tcp_user_timeout_user-timeout-probe.pkt        |   37 +
 .../packetdrill/tcp_user_timeout_user_timeout.pkt  |   32 +
 .../tcp_validate_validate-established-no-flags.pkt |   24 +
 tools/testing/selftests/net/tls.c                  |  478 +++-
 tools/testing/selftests/net/udpgso_bench.sh        |    3 +
 tools/testing/selftests/net/vlan_bridge_binding.sh |  256 ++
 tools/testing/selftests/net/ynl.mk                 |    3 +-
 .../tc-testing/scripts/sfq_rejects_limit_1.py      |   21 +
 .../selftests/tc-testing/tc-tests/qdiscs/sfq.json  |   20 +
 tools/testing/vsock/README                         |   15 +
 tools/testing/vsock/util.c                         |   33 +-
 tools/testing/vsock/util.h                         |    2 +
 tools/testing/vsock/vsock_test.c                   |  265 +-
 1383 files changed, 63625 insertions(+), 18819 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/atmel-can.txt
 delete mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
 create mode 100644 Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
 create mode 100644 Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml
 create mode 100644 Documentation/networking/netmem.rst
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/health.c
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/health.h
 rename drivers/net/ethernet/intel/ice/devlink/{devlink_port.c => port.c} (99%)
 rename drivers/net/ethernet/intel/ice/devlink/{devlink_port.h => port.h} (100%)
 create mode 100644 drivers/net/ethernet/intel/igb/igb_xsk.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
 create mode 100644 drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
 create mode 100644 drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
 create mode 100644 drivers/net/phy/microchip_rds_ptp.c
 create mode 100644 drivers/net/phy/microchip_rds_ptp.h
 create mode 100644 drivers/net/phy/realtek/Kconfig
 create mode 100644 drivers/net/phy/realtek/Makefile
 create mode 100644 drivers/net/phy/realtek/realtek.h
 create mode 100644 drivers/net/phy/realtek/realtek_hwmon.c
 rename drivers/net/phy/{realtek.c => realtek/realtek_main.c} (97%)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/dr.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-utils.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-utils.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/channel.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/scan.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/led.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/led.h
 create mode 100644 include/uapi/linux/ethtool_netlink_generated.h
 create mode 100644 net/ethtool/ts.h
 create mode 100644 net/ethtool/tsconfig.c
 create mode 100644 net/mac80211/tests/util.c
 create mode 100644 net/mac80211/tests/util.h
 create mode 100644 net/rxrpc/input_rack.c
 create mode 100644 net/xfrm/trace_iptfs.h
 create mode 100644 net/xfrm/xfrm_iptfs.c
 create mode 100644 scripts/gen_packed_field_checks.c
 create mode 100644 tools/net/ynl/pyproject.toml
 create mode 100644 tools/net/ynl/pyynl/.gitignore
 create mode 100644 tools/net/ynl/pyynl/__init__.py
 rename tools/net/ynl/{ => pyynl}/cli.py (70%)
 rename tools/net/ynl/{ => pyynl}/ethtool.py (98%)
 rename tools/net/ynl/{ => pyynl}/lib/__init__.py (100%)
 rename tools/net/ynl/{ => pyynl}/lib/nlspec.py (99%)
 rename tools/net/ynl/{ => pyynl}/lib/ynl.py (94%)
 rename tools/net/ynl/{ynl-gen-c.py => pyynl/ynl_gen_c.py} (96%)
 rename tools/net/ynl/{ynl-gen-rst.py => pyynl/ynl_gen_rst.py} (100%)
 delete mode 100755 tools/testing/selftests/bpf/test_xdp_meta.sh
 delete mode 100755 tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
 create mode 100755 tools/testing/selftests/drivers/net/hds.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
 create mode 100755 tools/testing/selftests/drivers/net/netcons_overflow.sh
 create mode 100755 tools/testing/selftests/net/cmsg_so_priority.sh
 create mode 100755 tools/testing/selftests/net/forwarding/vxlan_reserved.sh
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-accept.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-read.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-write.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_close_close-local-close-then-remote-fin.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_close_close-on-syn-sent.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_close_close-remote-fin-then-close.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_ecn_ecn-uses-ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-large.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-retrans.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-small.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-subsequent.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-10pkt-lost-1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-30pkt-lost-1_4-11_16.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-30pkt-lost1_4.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-ack-below-snd_una-cubic.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_limited_transmit_limited-transmit-no-sack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_limited_transmit_limited-transmit-sack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_nagle_https_client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_nagle_sendmsg_msg_more.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_nagle_sockopt_cork_nodelay.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_sack_sack-route-refresh-ip-tos.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_sack_sack-shift-sacked-2-6-8-3-9-nofack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_sack_sack-shift-sacked-7-3-4-8-9-fack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_sack_sack-shift-sacked-7-5-6-8-9-fack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_sendfile_sendfile-simple.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_splice_tcp_splice_loop_test.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_fastopen-invalid-buf-ptr.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_sendmsg-empty-iov.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_syscall-invalid-buf-ptr.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_tcp_info_tcp-info-last_data_recv.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_tcp_info_tcp-info-rwnd-limited.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_tcp_info_tcp-info-sndbuf-limited.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_timestamping_client-only-last-byte.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_timestamping_partial.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_timestamping_server.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_ts_recent_fin_tsval.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_ts_recent_invalid_ack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_ts_recent_reset_tsval.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_user_timeout_user-timeout-probe.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_user_timeout_user_timeout.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_validate_validate-established-no-flags.pkt
 create mode 100755 tools/testing/selftests/net/vlan_bridge_binding.sh
 create mode 100755 tools/testing/selftests/tc-testing/scripts/sfq_rejects_limit_1.py


