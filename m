Return-Path: <bpf+bounces-3596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFBB74038E
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 20:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D4F281163
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 18:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7005013096;
	Tue, 27 Jun 2023 18:48:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E31306E;
	Tue, 27 Jun 2023 18:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40865C433C8;
	Tue, 27 Jun 2023 18:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687891711;
	bh=UzrY1CHuLR/gMX29r3z5LaAVZt4+O5g7GXe8IzMpXK0=;
	h=From:To:Cc:Subject:Date:From;
	b=FlgUsZlOyTdhYJ1ZueKa70JQfdBAdYKJDZ4nxx7PAGgMj/dv+EvGTRxyB2ifg8v3v
	 ku6y5CF1tOJrs0aPDEEyi+Lqx4jNeNQSLW6IXm9rWum6/eBEsNnjrTohyPyQvJrABQ
	 lSas7+9P+i/PAP8UEgiovYNHRtlrxbFTMXCYl42+iWF/6gDQxmo8mhbPa04ZlxZf3g
	 BIGdnXe8tosu9X+qQdUXn8nAg8hnHYZA5njydfPz1s8y8sl4z2fYy4Cn/uJ6nFAkyp
	 NqTi86J6JQKTBIEndZYcWdY5Hcu/m1aFIavZIWZIXD6a+F4x4nK2VOq7kiJWDlEWrA
	 eC6oPJbv5bqsQ==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	bpf@vger.kernel.org
Subject: [GIT PULL] Networking for v6.5
Date: Tue, 27 Jun 2023 11:48:30 -0700
Message-Id: <20230627184830.1205815-1-kuba@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

WiFi 7 and sendpage changes are the biggest pieces of work for
this release. The latter will definitely require fixes but
I think that we got it to a reasonable point.

The following changes since commit 8a28a0b6f1a1dcbf5a834600a9acfbe2ba51e5eb:

  Merge tag 'net-6.4-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-06-22 17:59:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.5

for you to fetch changes up to ae230642190a51b85656d6da2df744d534d59544:

  Merge branch 'af_unix-followup-fixes-for-so_passpidfd' (2023-06-27 10:50:25 -0700)

----------------------------------------------------------------
Networking changes for 6.5.

Core
----

 - Rework the sendpage & splice implementations. Instead of feeding
   data into sockets page by page extend sendmsg handlers to support
   taking a reference on the data, controlled by a new flag called
   MSG_SPLICE_PAGES. Rework the handling of unexpected-end-of-file
   to invoke an additional callback instead of trying to predict what
   the right combination of MORE/NOTLAST flags is.
   Remove the MSG_SENDPAGE_NOTLAST flag completely.

 - Implement SCM_PIDFD, a new type of CMSG type analogous to
   SCM_CREDENTIALS, but it contains pidfd instead of plain pid.

 - Enable socket busy polling with CONFIG_RT.

 - Improve reliability and efficiency of reporting for ref_tracker.

 - Auto-generate a user space C library for various Netlink families.

Protocols
---------

 - Allow TCP to shrink the advertised window when necessary, prevent
   sk_rcvbuf auto-tuning from growing the window all the way up to
   tcp_rmem[2].

 - Use per-VMA locking for "page-flipping" TCP receive zerocopy.

 - Prepare TCP for device-to-device data transfers, by making sure
   that payloads are always attached to skbs as page frags.

 - Make the backoff time for the first N TCP SYN retransmissions
   linear. Exponential backoff is unnecessarily conservative.

 - Create a new MPTCP getsockopt to retrieve all info (MPTCP_FULL_INFO).

 - Avoid waking up applications using TLS sockets until we have
   a full record.

 - Allow using kernel memory for protocol ioctl callbacks, paving
   the way to issuing ioctls over io_uring.

 - Add nolocalbypass option to VxLAN, forcing packets to be fully
   encapsulated even if they are destined for a local IP address.

 - Make TCPv4 use consistent hash in TIME_WAIT and SYN_RECV. Ensure
   in-kernel ECMP implementation (e.g. Open vSwitch) select the same
   link for all packets. Support L4 symmetric hashing in Open vSwitch.

 - PPPoE: make number of hash bits configurable.

 - Allow DNS to be overwritten by DHCPACK in the in-kernel DHCP client
   (ipconfig).

 - Add layer 2 miss indication and filtering, allowing higher layers
   (e.g. ACL filters) to make forwarding decisions based on whether
   packet matched forwarding state in lower devices (bridge).

 - Support matching on Connectivity Fault Management (CFM) packets.

 - Hide the "link becomes ready" IPv6 messages by demoting their
   printk level to debug.

 - HSR: don't enable promiscuous mode if device offloads the proto.

 - Support active scanning in IEEE 802.15.4.

 - Continue work on Multi-Link Operation for WiFi 7.

BPF
---

 - Add precision propagation for subprogs and callbacks. This allows
   maintaining verification efficiency when subprograms are used,
   or in fact passing the verifier at all for complex programs,
   especially those using open-coded iterators.

 - Improve BPF's {g,s}setsockopt() length handling. Previously BPF
   assumed the length is always equal to the amount of written data.
   But some protos allow passing a NULL buffer to discover what
   the output buffer *should* be, without writing anything.

 - Accept dynptr memory as memory arguments passed to helpers.

 - Add routing table ID to bpf_fib_lookup BPF helper.

 - Support O_PATH FDs in BPF_OBJ_PIN and BPF_OBJ_GET commands.

 - Drop bpf_capable() check in BPF_MAP_FREEZE command (used to mark
   maps as read-only).

 - Show target_{obj,btf}_id in tracing link fdinfo.

 - Addition of several new kfuncs (most of the names are self-explanatory):
   - Add a set of new dynptr kfuncs: bpf_dynptr_adjust(),
     bpf_dynptr_is_null(), bpf_dynptr_is_rdonly(), bpf_dynptr_size()
     and bpf_dynptr_clone().
   - bpf_task_under_cgroup()
   - bpf_sock_destroy() - force closing sockets
   - bpf_cpumask_first_and(), rework bpf_cpumask_any*() kfuncs

Netfilter
---------

 - Relax set/map validation checks in nf_tables. Allow checking
   presence of an entry in a map without using the value.

 - Increase ip_vs_conn_tab_bits range for 64BIT builds.

 - Allow updating size of a set.

 - Improve NAT tuple selection when connection is closing.

Driver API
----------

 - Integrate netdev with LED subsystem, to allow configuring HW
   "offloaded" blinking of LEDs based on link state and activity
   (i.e. packets coming in and out).

 - Support configuring rate selection pins of SFP modules.

 - Factor Clause 73 auto-negotiation code out of the drivers, provide
   common helper routines.

 - Add more fool-proof helpers for managing lifetime of MDIO devices
   associated with the PCS layer.

 - Allow drivers to report advanced statistics related to Time Aware
   scheduler offload (taprio).

 - Allow opting out of VF statistics in link dump, to allow more VFs
   to fit into the message.

 - Split devlink instance and devlink port operations.

New hardware / drivers
----------------------

 - Ethernet:
   - Synopsys EMAC4 IP support (stmmac)
   - Marvell 88E6361 8 port (5x1GE + 3x2.5GE) switches
   - Marvell 88E6250 7 port switches
   - Microchip LAN8650/1 Rev.B0 PHYs
   - MediaTek MT7981/MT7988 built-in 1GE PHY driver

 - WiFi:
   - Realtek RTL8192FU, 2.4 GHz, b/g/n mode, 2T2R, 300 Mbps
   - Realtek RTL8723DS (SDIO variant)
   - Realtek RTL8851BE

 - CAN:
   - Fintek F81604

Drivers
-------

 - Ethernet NICs:
   - Intel (100G, ice):
     - support dynamic interrupt allocation
     - use meta data match instead of VF MAC addr on slow-path
   - nVidia/Mellanox:
     - extend link aggregation to handle 4, rather than just 2 ports
     - spawn sub-functions without any features by default
   - OcteonTX2:
     - support HTB (Tx scheduling/QoS) offload
     - make RSS hash generation configurable
     - support selecting Rx queue using TC filters
   - Wangxun (ngbe/txgbe):
     - add basic Tx/Rx packet offloads
     - add phylink support (SFP/PCS control)
   - Freescale/NXP (enetc):
     - report TAPRIO packet statistics
   - Solarflare/AMD:
     - support matching on IP ToS and UDP source port of outer header
     - VxLAN and GENEVE tunnel encapsulation over IPv4 or IPv6
     - add devlink dev info support for EF10

 - Virtual NICs:
   - Microsoft vNIC:
     - size the Rx indirection table based on requested configuration
     - support VLAN tagging
   - Amazon vNIC:
     - try to reuse Rx buffers if not fully consumed, useful for ARM
       servers running with 16kB pages
   - Google vNIC:
     - support TCP segmentation of >64kB frames

 - Ethernet embedded switches:
   - Marvell (mv88e6xxx):
     - enable USXGMII (88E6191X)
   - Microchip:
    - lan966x: add support for Egress Stage 0 ACL engine
    - lan966x: support mapping packet priority to internal switch
      priority (based on PCP or DSCP)

 - Ethernet PHYs:
   - Broadcom PHYs:
     - support for Wake-on-LAN for BCM54210E/B50212E
     - report LPI counter
   - Microsemi PHYs: support RGMII delay configuration (VSC85xx)
   - Micrel PHYs: receive timestamp in the frame (LAN8841)
   - Realtek PHYs: support optional external PHY clock
   - Altera TSE PCS: merge the driver into Lynx PCS which it is
     a variant of

 - CAN: Kvaser PCIEcan:
   - support packet timestamping

 - WiFi:
   - Intel (iwlwifi):
     - major update for new firmware and Multi-Link Operation (MLO)
     - configuration rework to drop test devices and split
       the different families
     - support for segmented PNVM images and power tables
     - new vendor entries for PPAG (platform antenna gain) feature
   - Qualcomm 802.11ax (ath11k):
     - Multiple Basic Service Set Identifier (MBSSID) and
       Enhanced MBSSID Advertisement (EMA) support in AP mode
     - support factory test mode
   - RealTek (rtw89):
     - add RSSI based antenna diversity
     - support U-NII-4 channels on 5 GHz band
   - RealTek (rtl8xxxu):
     - AP mode support for 8188f
     - support USB RX aggregation for the newer chips

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aaron Conole (1):
      net: openvswitch: add support for l4 symmetric hashing

Abel Wu (1):
      inet: Cleanup on charging memory for newly accepted sockets

Abhijeet Rastogi (1):
      ipvs: increase ip_vs_conn_tab_bits range for 64BIT

Abhishek Naik (4):
      wifi: iwlwifi: update response for mcc_update command
      wifi: iwlwifi: update response for mcc_update command
      wifi: mac80211: handle TDLS data frames with MLO
      wifi: mac80211: Add HE and EHT capa elements in TDLS frames

Aditi Ghag (9):
      bpf: tcp: Avoid taking fast sock lock in iterator
      udp: seq_file: Helper function to match socket attributes
      bpf: udp: Encapsulate logic to get udp table
      udp: seq_file: Remove bpf_seq_afinfo from udp_iter_state
      bpf: udp: Implement batching for sockets iterator
      bpf: Add kfunc filter function to 'struct btf_kfunc_id_set'
      bpf: Add bpf_sock_destroy kfunc
      selftests/bpf: Add helper to get port using getsockname
      selftests/bpf: Test bpf_sock_destroy

Aishwarya R (1):
      wifi: ath12k: increase vdev setup timeout

Alan Maguire (2):
      bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25
      bpftool: JIT limited misreported as negative value on aarch64

Alexander Mikhalitsyn (6):
      sctp: add bpf_bypass_getsockopt proto callback
      scm: add SO_PASSPIDFD and SCM_PIDFD
      net: core: add getsockopt SO_PEERPIDFD
      selftests: net: add SCM_PIDFD / SO_PEERPIDFD test
      af_unix: Kconfig: make CONFIG_UNIX bool
      net: scm: introduce and use scm_recv_unix helper

Alexander Wetzel (1):
      wifi: ath10k: Serialize wake_tx_queue ops

Alexei Starovoitov (6):
      Merge branch 'Add precision propagation for subprogs and callbacks'
      Merge branch 'Introduce a new kfunc of bpf_task_under_cgroup'
      Merge branch 'Dynptr Verifier Adjustments'
      Merge branch 'bpf: Move kernel test kfuncs into bpf_testmod'
      Merge branch 'seltests/xsk: prepare for AF_XDP multi-buffer testing'
      Merge branch 'bpf: Show target_{obj,btf}_id for tracing link'

Alexey Gladkov (1):
      selftests/bpf: Do not use sign-file as testcase

Alexis Lothoré (7):
      dt-bindings: net: dsa: marvell: add MV88E6361 switch to compatibility list
      net: dsa: mv88e6xxx: pass directly chip structure to mv88e6xxx_phy_is_internal
      net: dsa: mv88e6xxx: use mv88e6xxx_phy_is_internal in mv88e6xxx_port_ppu_updates
      net: dsa: mv88e6xxx: add field to specify internal phys layout
      net: dsa: mv88e6xxx: fix 88E6393X family internal phys layout
      net: dsa: mv88e6xxx: pass mv88e6xxx_chip structure to port_max_speed_mode
      net: dsa: mv88e6xxx: enable support for 88E6361 switch

Aloka Dixit (7):
      wifi: ath11k: driver settings for MBSSID and EMA
      wifi: ath11k: MBSSID configuration during vdev create/start
      wifi: ath11k: rename MBSSID fields in wmi_vdev_up_cmd
      wifi: ath11k: MBSSID parameter configuration in AP mode
      wifi: ath11k: refactor vif parameter configurations
      wifi: ath11k: MBSSID beacon support
      wifi: ath11k: EMA beacon support

Alon Giladi (16):
      wifi: iwlwifi: support PPAG in China for older FW cmd version
      wifi: iwlwifi: Add vendors to TAS approved list
      wifi: iwlwifi: Add Dell to ppag approved list
      wifi: iwlwifi: Generalize the parsing of the pnvm image
      wifi: iwlwifi: Separate loading and setting of pnvm image into two functions
      wifi: iwlwifi: Take loading and setting of pnvm image out of parsing part
      wifi: iwlwifi: Allow trans_pcie track more than 1 pnvm DRAM region
      wifi: iwlwifi: Add support for fragmented pnvm images
      wifi: iwlwifi: Implement loading and setting of fragmented pnvm image
      wifi: iwlwifi: Separate loading and setting of power reduce tables
      wifi: iwlwifi: Use iwl_pnvm_image in reduce power tables flow
      wifi: iwlwifi: Enable loading of reduce-power tables into several segments
      wifi: iwlwifi: Separate reading and parsing of reduce power table
      wifi: iwlwifi: debugfs: add ppag capa to fw info file
      wifi: iwlwifi: improve debug prints in iwl_read_ppag_table()
      wifi: mac80211: drop unprotected robust mgmt before 4-way-HS

Amisha Patel (2):
      wifi: wilc1000: fix for absent RSN capabilities WFA testcase
      wifi: wilc1000: Increase ASSOC response buffer

Andrew Lunn (5):
      leds: add API to get attached device for LED hw control
      leds: trigger: netdev: refactor code setting device name
      leds: trigger: netdev: validate configured netdev
      net: dsa: qca8k: add op to get ports netdev
      net: phy-c45: Fix genphy_c45_ethtool_set_eee description

Andrii Nakryiko (29):
      Merge branch 'selftests/bpf: test_progs can read test lists from file'
      veristat: add -t flag for adding BPF_F_TEST_STATE_FREQ program flag
      bpf: mark relevant stack slots scratched for register read instructions
      bpf: encapsulate precision backtracking bookkeeping
      bpf: improve precision backtrack logging
      bpf: maintain bitmasks across all active frames in __mark_chain_precision
      bpf: fix propagate_precision() logic for inner frames
      bpf: fix mark_all_scalars_precise use in mark_chain_precision
      bpf: support precision propagation in the presence of subprogs
      selftests/bpf: add precision propagation tests in the presence of subprogs
      selftests/bpf: revert iter test subprog precision workaround
      libbpf: fix offsetof() and container_of() to work with CO-RE
      bpf: fix calculation of subseq_idx during precision backtracking
      selftests/bpf: improve netcnt test robustness
      bpf: drop unnecessary user-triggerable WARN_ONCE in verifierl log
      bpf: Validate BPF object in BPF_OBJ_PIN before calling LSM
      libbpf: Start v1.3 development cycle
      bpf: Support O_PATH FDs in BPF_OBJ_PIN and BPF_OBJ_GET commands
      libbpf: Add opts-based bpf_obj_pin() API and add support for path_fd
      selftests/bpf: Add path_fd-based BPF_OBJ_PIN and BPF_OBJ_GET tests
      Merge branch 'libbpf: capability for resizing datasec maps'
      bpf: drop unnecessary bpf_capable() check in BPF_MAP_FREEZE command
      libbpf: Ensure libbpf always opens files with O_CLOEXEC
      libbpf: Ensure FD >= 3 during bpf_map__reuse_fd()
      Merge branch 'verify scalar ids mapping in regsafe()'
      bpf: Move unprivileged checks into map_create() and bpf_prog_load()
      bpf: Inline map creation logic in map_create() function
      bpf: Centralize permissions checks for all BPF map types
      bpf: Keep BPF_PROG_LOAD permission checks clear of validations

Andrzej Hajda (4):
      lib/ref_tracker: add unlocked leak print helper
      lib/ref_tracker: improve printing stats
      lib/ref_tracker: add printing to memory buffer
      lib/ref_tracker: remove warnings in case of allocation failure

Andy Shevchenko (3):
      dsa: lan9303: Remove stray gpiod_unexport() call
      mac_pton: Clean up the header inclusions
      ieee802154: ca8210: Remove stray gpiod_unexport() call

Angus Chen (1):
      net: Remove low_thresh in ip defrag

Anjaneyulu (7):
      wifi: mac80211: consistently use u64 for BSS changes
      wifi: mac80211: pass roc->sdata to drv_cancel_remain_on_channel()
      wifi: iwlwifi: pcie: fix NULL pointer dereference in iwl_pcie_irq_rx_msix_handler()
      wifi: iwlwifi: mvm: Validate tid is in valid range before using it
      wifi: iwlwifi: Validate slots_num before allocating memory
      wifi: iwlwifi: add a few rate index validity checks
      wifi: mac80211: add consistency check for compat chandef

Antoine Tenart (3):
      net: tcp: make the txhash available in TIME_WAIT sockets for IPv4 too
      net: ipv4: use consistent txhash in TIME_WAIT and SYN_RECV
      Documentation: net: net.core.txrehash is not specific to listening sockets

Anton Protopopov (2):
      bpf, docs: BPF Iterator Document
      bpf, docs: Document existing macros instead of deprecated

Anup Sharma (1):
      net: ethernet: microchip: vcap: Remove extra semicolon

Ariel Malamud (3):
      wifi: iwlwifi: fw: Add new ODM vendor to ppag approved list
      wifi: iwlwifi: mvm: Refactor iwl_mvm_get_lmac_id()
      wifi: iwlwifi: fw: Add new FSEQ defines to fw dump

Arjun Roy (1):
      tcp: Use per-vma locking for receive zerocopy

Arnd Bergmann (8):
      wifi: ath: work around false-positive stringop-overread warning
      net: ipconfig: move ic_nameservers_fallback into #ifdef block
      wifi: rtw89: use flexible array member in rtw89_btc_btf_tlv
      bpf: Hide unused bpf_patch_call_args
      net: phy: mediatek: fix compile-test dependencies
      sfc: add CONFIG_INET dependency for TC offload
      sfc: fix uninitialized variable use
      wifi: ath10k: improve structure padding

Atin Bainada (1):
      net: dsa: qca8k: remove unnecessary (void*) conversions

Avraham Stern (5):
      wifi: iwlwifi: mvm: support PASN for MLO
      wifi: iwlwifi: iwlmei: fix compilation error
      wifi: iwlwifi: mvm: FTM initiator MLO support
      wifi: iwlwifi: mvm: FTM initiator MLO support
      wifi: iwlwifi: mvm: FTM responder MLO support

Azeem Shaikh (4):
      bpf: Replace all non-returning strlcpy with strscpy
      wifi: cfg80211: replace strlcpy() with strscpy()
      wifi: mac80211: Replace strlcpy with strscpy
      wifi: mt7601u: replace strlcpy() with strscpy()

Bagas Sanjaya (5):
      net: bonding: Add SPDX identifier to remaining files
      net: ethernet: 8390: Convert unversioned GPL notice to SPDX license identifier
      net: ethernet: 8390: Replace GPL 2.0 boilerplate with SPDX identifier
      net: ethernet: i825xx: Replace unversioned GPL (GPL 1.0) notice with SPDX identifier
      net: ethernet: i825xx: sun3_8256: Add SPDX license identifier

Balamurugan S (1):
      wifi: ath12k: Avoid NULL pointer access during management transmit cleanup

Baochen Qiang (1):
      wifi: ath12k: Use msdu_end to check MCBC

Baozhu Ni (1):
      e1000e: Add @adapter description to kdoc

Bartosz Golaszewski (26):
      net: stmmac: dwmac-qcom-ethqos: shrink clock code with devres
      net: stmmac: dwmac-qcom-ethqos: rename a label in probe()
      net: stmmac: dwmac-qcom-ethqos: tweak the order of local variables
      net: stmmac: dwmac-qcom-ethqos: use a helper variable for &pdev->dev
      net: stmmac: dwmac-qcom-ethqos: add missing include
      net: stmmac: dwmac-qcom-ethqos: add a newline between headers
      net: stmmac: dwmac-qcom-ethqos: remove stray space
      net: stmmac: dwmac-qcom-ethqos: add support for the optional serdes phy
      net: stmmac: dwmac-qcom-ethqos: add support for the phyaux clock
      net: stmmac: dwmac-qcom-ethqos: prepare the driver for more PHY modes
      net: stmmac: dwmac-qcom-ethqos: add support for SGMII
      net: stmmac: add new switch to struct plat_stmmacenet_data
      dt-bindings: net: qcom,ethqos: add description for sa8775p
      net: stmmac: dwmac-qcom-ethqos: add support for emac4 on sa8775p platforms
      net: stmmac: fix double serdes powerdown
      net: stmmac: platform: provide stmmac_pltfr_init()
      net: stmmac: dwmac-generic: use stmmac_pltfr_init()
      net: stmmac: platform: provide stmmac_pltfr_exit()
      net: stmmac: dwmac-generic: use stmmac_pltfr_exit()
      net: stmmac: platform: provide stmmac_pltfr_probe()
      net: stmmac: dwmac-generic: use stmmac_pltfr_probe()
      net: stmmac: platform: provide stmmac_pltfr_remove_no_dt()
      net: stmmac: platform: provide devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-qco-ethqos: use devm_stmmac_probe_config_dt()
      net: stmmac: platform: provide devm_stmmac_pltfr_probe()
      net: stmmac: dwmac-qcom-ethqos: use devm_stmmac_pltfr_probe()

Ben Greear (1):
      wifi: mac80211: add eht_capa debugfs field

Benjamin Berg (28):
      wifi: iwlwifi: do not log undefined DRAM buffers unnecessarily
      wifi: mac80211: fix CSA processing while scanning
      wifi: iwlwifi: make debugfs entries link specific
      wifi: mac80211: stop passing cbss to parser
      wifi: cfg80211: move regulatory_hint_found_beacon to be earlier
      wifi: cfg80211: keep bss_lock held when informing
      wifi: cfg80211: add inform_bss op to update BSS
      wifi: mac80211: use new inform_bss callback
      wifi: cfg80211: ignore invalid TBTT info field types
      wifi: cfg80211: rewrite merging of inherited elements
      wifi: cfg80211: drop incorrect nontransmitted BSS update code
      wifi: cfg80211: add element defragmentation helper
      wifi: mac80211: use cfg80211 defragmentation helper
      wifi: ieee80211: add helper to validate ML element type and size
      wifi: ieee80211: use default for medium synchronization delay
      wifi: cfg80211: Always ignore ML element
      wifi: ieee80211: add definitions for RNR MLD params
      wifi: cfg80211: use a struct for inform_single_bss data
      wifi: ieee80211: add structs for TBTT information access
      wifi: cfg80211: use structs for TBTT information access
      wifi: cfg80211: handle BSS data contained in ML probe responses
      wifi: cfg80211: do not scan disabled links on 6GHz
      wifi: mac80211: add ___ieee80211_disconnect variant not locking sdata
      wifi: mac80211: add set_active_links variant not locking sdata
      wifi: cfg80211: stop parsing after allocation failure
      wifi: cfg80211: search all RNR elements for colocated APs
      wifi: mac80211: avoid lockdep checking when removing deflink
      wifi: iwlwifi: mvm: send LARI configuration earlier

Bitterblue Smith (3):
      wifi: rtl8xxxu: Support USB RX aggregation for the newer chips
      wifi: rtl8xxxu: Support new chip RTL8192FU
      wifi: rtl8xxxu: Rename some registers

Bodong Wang (1):
      mlx5/core: E-Switch, Allocate ECPF vport if it's an eswitch manager

Breno Leitao (1):
      net: ioctl: Use kernel memory on protocol ioctl callbacks

Cambda Zhu (1):
      ipvlan: Fix return value of ipvlan_queue_xmit()

Carl Huang (4):
      wifi: ath12k: add qmi_cnss_feature_bitmap field to hardware parameters
      wifi: ath12k: set PERST pin no pull request for WCN7850
      wifi: ath12k: send WMI_PEER_REORDER_QUEUE_SETUP_CMDID when ADDBA session starts
      wifi: ath12k: check hardware major version for WCN7850

Carsten Schmidt (1):
      can: kvaser_usb: Add len8_dlc support

Chia-Yuan Li (1):
      wifi: rtw89: add CFO XTAL registers field to support 8851B

Chih-Kang Chang (2):
      wifi: rtw89: 8851b: add support WoWLAN to 8851B
      wifi: rtw88: process VO packets without workqueue to avoid PTK rekey failed

Chin-Yen Lee (2):
      wifi: rtw89: suppress the log for specific SER called CMDPSR_FRZTO
      wifi: rtw89: add tx_wake notify for 8851B

Christian Lamparter (1):
      dt-bindings: net: wireless: ath10k: add ieee80211-freq-limit property

Christian Marangi (19):
      leds: trigger: netdev: Recheck NETDEV_LED_MODE_LINKUP on dev rename
      leds: trigger: netdev: Drop NETDEV_LED_MODE_LINKUP from mode
      leds: trigger: netdev: Rename add namespace to netdev trigger enum modes
      leds: trigger: netdev: Convert device attr to macro
      leds: trigger: netdev: Use mutex instead of spinlocks
      leds: add APIs for LEDs hw control
      Documentation: leds: leds-class: Document new Hardware driven LEDs APIs
      leds: trigger: netdev: introduce check for possible hw control
      leds: trigger: netdev: add basic check for hw control support
      leds: trigger: netdev: reject interval store for hw_control
      leds: trigger: netdev: add support for LED hw control
      leds: trigger: netdev: init mode if hw control already active
      leds: trigger: netdev: expose netdev trigger modes in linux include
      net: dsa: qca8k: implement hw_control ops
      leds: trigger: netdev: add additional specific link speed mode
      leds: trigger: netdev: add additional specific link duplex mode
      leds: trigger: netdev: expose hw_control status via sysfs
      docs: ABI: sysfs-class-led-trigger-netdev: add new modes and entry
      net: dsa: qca8k: add support for additional modes for netdev trigger

Christophe JAILLET (21):
      wifi: ath12k: Remove some dead code
      wifi: mwifiex: Use list_count_nodes()
      wifi: ath10k: Use list_count_nodes()
      wifi: ath11k: Use list_count_nodes()
      wifi: mwifiex: Fix the size of a memory allocation in mwifiex_ret_802_11_scan()
      net: openvswitch: Use struct_size()
      netfilter: Reorder fields in 'struct nf_conntrack_expect'
      netfilter: nft_set_pipapo: Use struct_size()
      net/mlx4: Use bitmap_weight_and()
      wifi: orinoco: Fix an error handling path in spectrum_cs_probe()
      wifi: orinoco: Fix an error handling path in orinoco_cs_probe()
      wifi: atmel: Fix an error handling path in atmel_probe()
      wifi: wl3501_cs: Fix an error handling path in wl3501_probe()
      wifi: ray_cs: Fix an error handling path in ray_probe()
      liquidio: Use vzalloc()
      net/mlx5e: Remove a useless function call
      net: phy: at803x: Use devm_regulator_get_enable_optional()
      mctp: Reorder fields in 'struct mctp_route'
      mptcp: Reorder fields in 'struct mptcp_pm_add_entry'
      netlabel: Reorder fields in 'struct netlbl_domaddr6_map'
      ice: Remove managed memory usage in ice_get_fw_log_cfg()

Chuck Lever (6):
      net/handshake: Remove unneeded check from handshake_dup()
      net/handshake: Fix handshake_dup() ref counting
      net/handshake: Fix uninitialized local variable
      net/handshake: handshake_genl_notify() shouldn't ignore @flags
      net/handshake: Unpin sock->file if a handshake is cancelled
      net/handshake: Enable the SNI extension to work properly

Coco Li (1):
      gve: Support IPv6 Big TCP on DQ

Colin Ian King (1):
      wifi: rtw89: 8851b: rfk: Fix spelling mistake KIP_RESOTRE -> KIP_RESTORE

Daire McNamara (1):
      net: macb: Shorten max_tx_len to 4KiB - 56 on mpfs

Dan Carpenter (6):
      wifi: rtw89: fix rtw89_read_chip_ver() for RTL8852B and RTL8851B
      wifi: rtw88: unlock on error path in rtw_ops_add_interface()
      net: fix signedness bug in skb_splice_from_iter()
      net: dsa: ocelot: unlock on error in vsc9959_qos_port_tas_set()
      leds: trigger: netdev: uninitialized variable in netdev_trig_activate()
      net/mlx5: Fix error code in mlx5_is_reset_now_capable()

Daniel Borkmann (2):
      selftests/bpf: Add test case to assert precise scalar path pruning
      bpf: Fix bad unlock balance on freeze_mutex

Daniel Golle (1):
      net: phy: add driver for MediaTek SoC built-in GE PHYs

Daniel Jurgens (13):
      net/mlx5: Simplify unload all rep code
      net/mlx5: mlx5_ifc updates for embedded CPU SRIOV
      net/mlx5: Enable devlink port for embedded cpu VF vports
      net/mlx5: Update vport caps query/set for EC VFs
      net/mlx5: Add management of EC VF vports
      net/mlx5: Add/remove peer miss rules for EC VFs
      net/mlx5: Add new page type for EC VF pages
      net/mlx5: Use correct vport when restoring GUIDs
      net/mlx5: Query correct caps for min msix vectors
      net/mlx5: Update SRIOV enable/disable to handle EC/VFs
      net/mlx5: Set max number of embedded CPU VFs
      net/mlx5: Fix the macro for accessing EC VF vports
      net/mlx5: DR, update query of HCA caps for EC VFs

Daniel Müller (1):
      selftests/bpf: Check whether to run selftest

Daniel Rosenberg (5):
      bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
      selftests/bpf: Test allowing NULL buffer in dynptr slice
      selftests/bpf: Check overflow in optional buffer
      bpf: verifier: Accept dynptr mem as mem in helpers
      selftests/bpf: Accept mem from dynptr in helper funcs

Daniel T. Lee (1):
      bpf: Replace open code with for allocated object check

Dave Ertman (1):
      ice: Remove LAG+SRIOV mutual exclusion

Dave Marchevsky (4):
      bpf: Remove anonymous union in bpf_kfunc_call_arg_meta
      bpf: Set kptr_struct_meta for node param to list and rbtree insert funcs
      bpf: Fix __bpf_{list,rbtree}_add's beginning-of-node calculation
      bpf: Make bpf_refcount_acquire fallible for non-owning refs

Dave Thaler (1):
      bpf, docs: Shift operations are defined to use a mask

David Arinzon (2):
      net: ena: Add dynamic recycling mechanism for rx buffers
      net: ena: Fix rst format issues in readme

David Howells (72):
      net: Declare MSG_SPLICE_PAGES internal sendmsg() flag
      net: Pass max frags into skb_append_pagefrags()
      net: Add a function to splice pages into an skbuff for MSG_SPLICE_PAGES
      tcp: Support MSG_SPLICE_PAGES
      tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES
      tcp_bpf: Inline do_tcp_sendpages as it's now a wrapper around tcp_sendmsg
      espintcp: Inline do_tcp_sendpages()
      tls: Inline do_tcp_sendpages()
      siw: Inline do_tcp_sendpages()
      tcp: Fold do_tcp_sendpages() into tcp_sendpage_locked()
      ip, udp: Support MSG_SPLICE_PAGES
      ip6, udp6: Support MSG_SPLICE_PAGES
      udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES
      ip: Remove ip_append_page()
      af_unix: Support MSG_SPLICE_PAGES
      unix: Convert unix_stream_sendpage() to use MSG_SPLICE_PAGES
      chelsio: Support MSG_SPLICE_PAGES
      chelsio: Convert chtls_sendpage() to use MSG_SPLICE_PAGES
      kcm: Support MSG_SPLICE_PAGES
      kcm: Convert kcm_sendpage() to use MSG_SPLICE_PAGES
      Drop the netfs_ prefix from netfs_extract_iter_to_sg()
      Fix a couple of spelling mistakes
      Wrap lines at 80
      Move netfs_extract_iter_to_sg() to lib/scatterlist.c
      crypto: af_alg: Pin pages rather than ref'ing if appropriate
      crypto: af_alg: Use extract_iter_to_sg() to create scatterlists
      crypto: af_alg: Indent the loop in af_alg_sendmsg()
      crypto: af_alg: Support MSG_SPLICE_PAGES
      crypto: af_alg: Convert af_alg_sendpage() to use MSG_SPLICE_PAGES
      crypto: af_alg/hash: Support MSG_SPLICE_PAGES
      net: Block MSG_SENDPAGE_* from being passed to sendmsg() by userspace
      tls: Allow MSG_SPLICE_PAGES but treat it as normal sendmsg
      splice, net: Use sendmsg(MSG_SPLICE_PAGES) rather than ->sendpage()
      splice, net: Add a splice_eof op to file-ops and socket-ops
      tls/sw: Use splice_eof() to flush
      tls/device: Use splice_eof() to flush
      ipv4, ipv6: Use splice_eof() to flush
      chelsio/chtls: Use splice_eof() to flush
      kcm: Use splice_eof() to flush
      splice, net: Fix SPLICE_F_MORE signalling in splice_direct_to_actor()
      tls/sw: Support MSG_SPLICE_PAGES
      tls/sw: Convert tls_sw_sendpage() to use MSG_SPLICE_PAGES
      tls/device: Support MSG_SPLICE_PAGES
      tls/device: Convert tls_device_sendpage() to use MSG_SPLICE_PAGES
      Remove file->f_op->sendpage
      algif: Remove hash_sendpage*()
      sunrpc: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
      tcp_bpf: Make tcp_bpf_sendpage() go through tcp_bpf_sendmsg(MSG_SPLICE_PAGES)
      kcm: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
      kcm: Send multiple frags in one sendmsg()
      splice, net: Fix splice_to_socket() to handle pipe bufs larger than a page
      ip, ip6: Fix splice to raw and ping sockets
      kcm: Fix unnecessary psock unreservation.
      crypto: Fix af_alg_sendmsg(MSG_SPLICE_PAGES) sglist limit
      crypto: af_alg/hash: Fix recvmsg() after sendmsg(MSG_MORE)
      tcp_bpf, smc, tls, espintcp, siw: Reduce MSG_SENDPAGE_NOTLAST usage
      net: Use sendmsg(MSG_SPLICE_PAGES) not sendpage in skb_send_sock()
      ceph: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
      ceph: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage()
      rds: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
      dlm: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
      nvme-tcp: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
      nvmet-tcp: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
      smc: Drop smc_sendpage() in favour of smc_sendmsg() + MSG_SPLICE_PAGES
      drbd: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage()
      scsi: iscsi_tcp: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
      scsi: target: iscsi: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
      ocfs2: Fix use of slab data with sendpage
      ocfs2: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage()
      sock: Remove ->sendpage*() in favour of sendmsg(MSG_SPLICE_PAGES)
      net: Kill MSG_SENDPAGE_NOTLAST
      libceph: Partially revert changes to support MSG_SPLICE_PAGES

David Morley (2):
      tcp: make the first N SYN RTO backoffs linear
      tcp: fix formatting in sysctl_net_ipv4.c

David S. Miller (39):
      Merge branch 'lan966x-es0-vcap'
      Merge branch 'net-handshake-fixes'
      Merge branch 'selftests-fcnal'
      Merge branch 'sfc-decap'
      Merge branch 'broadcom-phy-wol'
      Merge branch 'skb_frag_fill_page_desc'
      Merge tag 'wireless-next-2023-05-12' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'octeontx2-pf-HTB'
      Merge branch 'tcp-io_uring-zc-opts'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'RTO_ONLINK'
      Merge branch 'tools-ynl-byteorder'
      Merge branch 'devlink-port_del-new-cleanup'
      Merge branch 'mv88e6xxx-phylink-prepare'
      Merge branch 'net-led-hw-control-api'
      Merge branch 'dsa-marvell-mv88e6071-and-6020-support'
      Merge branch 'xstats-for-tc-taprio'
      Merge branch 'regmap-TSE-PCS'
      Merge branch 'sja1105-cleanups'
      Merge branch 'mlxsw-selftests-cleanups'
      Merge branch 'realtek-external-phy-clock'
      Merge branch 'net-ncsi-refactoring-for-GMA-cmd'
      Merge branch 'broadcom-phy-led-brightness'
      Merge branch 'renesas-rswitch-perf'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'taprio-xstats'
      Merge branch 'mlxsw-cleanups'
      Merge branch 'SCM_PIDFD-SCM_PEERPIDFD'
      Merge branch 'ynl-ethtool'
      Merge branch 'ethtool-extack'
      Merge branch 'tcp-tx-headless'
      Merge tag 'mlx5-updates-2023-06-09' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch 'octeontx2-updates'
      Merge branch 'netdev-tracking'
      Merge branch 'macb-partial-store-and-forward'
      Merge tag 'mlx5-updates-2023-06-16' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch 'ptp-adjphase-cleanups'
      Merge branch 'sfc-next'

David Vernet (8):
      bpf: Teach verifier that trusted PTR_TO_BTF_ID pointers are non-NULL
      selftests/bpf: Add test for non-NULLable PTR_TO_BTF_IDs
      selftests/bpf: Add missing selftests kconfig options
      bpf: Add bpf_cpumask_first_and() kfunc
      selftests/bpf: Add test for new bpf_cpumask_first_and() kfunc
      bpf: Replace bpf_cpumask_any* with bpf_cpumask_any_distribute*
      selftests/bpf: Update bpf_cpumask_any* tests to use bpf_cpumask_any_distribute*
      bpf/docs: Update documentation for new cpumask kfuncs

Davide Tronchin (1):
      net: usb: qmi_wwan: add u-blox 0x1312 composition

Deming Wang (1):
      wifi: rt2x00: fix the typo in comments

Detlev Casanova (3):
      net: phy: realtek: Add optional external PHY clock
      dt-bindings: net: phy: Document support for external PHY clk
      net: phy: realtek: Disable clock on suspend

Dmitry Antipov (10):
      wifi: rtlwifi: remove unused timer and related code
      wifi: rtlwifi: remove unused dualmac control leftovers
      wifi: rtlwifi: remove misused flag from HAL data
      wifi: rtw89: cleanup private data structures
      wifi: rtw89: cleanup rtw89_iqk_info and related code
      wifi: rtw89: fix spelling typo of IQK debug messages
      wifi: iwlwifi: dvm: fix -Wunused-const-variable gcc warning
      wifi: ath9k: convert msecs to jiffies where needed
      wifi: rtlwifi: simplify LED management
      wifi: rtlwifi: cleanup USB interface

Donald Hunter (10):
      tools: ynl: Use dict of predefined Structs to decode scalar types
      tools: ynl: Handle byte-order in struct members
      doc: ynl: Add doc attr to struct members in genetlink-legacy spec
      tools: ynl: Initialise fixed headers to 0 in genetlink-legacy
      tools: ynl: Support enums in struct members in genetlink-legacy
      netlink: specs: add ynl spec for ovs_flow
      netlink: specs: fixup openvswitch specs for code generation
      netlink: specs: add display-hint to schema definitions
      tools: ynl: add display-hint support to ynl
      netlink: specs: add display hints to ovs_flow

Dongliang Mu (2):
      wifi: ray_cs: remove one redundant del_timer
      wifi: ray_cs: add sanity check on local->sram/rmem/amem

Eduard Zingerman (5):
      selftests/bpf: Fix invalid pointer check in get_xlated_program()
      bpf: Use scalar ids in mark_chain_precision()
      selftests/bpf: Check if mark_chain_precision() follows scalar ids
      bpf: Verify scalar ids mapping in regsafe() using check_ids()
      selftests/bpf: Verify that check_ids() is used for scalars in regsafe()

Edward Cree (17):
      sfc: release encap match in efx_tc_flow_free()
      sfc: populate enc_ip_tos matches in MAE outer rules
      sfc: support TC decap rules matching on enc_ip_tos
      sfc: support TC decap rules matching on enc_src_port
      sfc: fix use-after-free in efx_tc_flower_record_encap_match()
      sfc: add fallback action-set-lists for TC offload
      sfc: some plumbing towards TC encap action offload
      sfc: add function to atomically update a rule in the MAE
      sfc: MAE functions to create/update/delete encap headers
      sfc: neighbour lookup for TC encap action offload
      sfc: generate encap headers for TC offload
      sfc: do not try to call tc functions when CONFIG_SFC_SRIOV=n
      sfc: keep alive neighbour entries while a TC encap action is using them
      sfc: fix crash when reading stats while NIC is resetting
      sfc: use padding to fix alignment in loopback test
      sfc: siena: use padding to fix alignment in loopback test
      sfc: falcon: use padding to fix alignment in loopback test

Edwin Peer (1):
      rtnetlink: extend RTEXT_FILTER_SKIP_STATS to IFLA_VF_INFO

Emmanuel Grumbach (8):
      wifi: iwlwifi: mvm: update the FW apis for LINK and MAC commands
      wifi: mac80211: fetch and store the EML capability information
      wifi: mac80211: provide a helper to fetch the medium synchronization delay
      wifi: iwlwifi: pass ESR parameters to the firmware
      wifi: iwlwifi: mvm: allow ADD_STA not to be advertised by the firwmare
      wifi: mac80211: feed the link_id to cfg80211_ch_switch_started_notify
      wifi: iwlwifi: mvm: check the right csa_active
      wifi: iwlwifi: mvm: make iwl_mvm_set_fw_mu_edca_params mld aware

Eric Dumazet (12):
      tcp: let tcp_mtu_probe() build headless packets
      net: move gso declarations and functions to their own files
      tcp: let tcp_send_syn_data() build headless packets
      tcp: remove some dead code
      tcp: remove size parameter from tcp_stream_alloc_skb()
      ipv6: also use netdev_hold() in ip6_route_check_nh()
      ipv6: fix a typo in ip6mr_sk_ioctl()
      net: remove sk_is_ipmr() and sk_is_icmpv6() helpers
      netlink: fix potential deadlock in netlink_set_err()
      netlink: do not hard code device address lenth in fdb dumps
      bonding: do not assume skb mac_header is set
      sch_netem: fix issues in netem_change() vs get_dist_table()

Eric Huang (3):
      wifi: rtw89: initialize antenna for antenna diversity
      wifi: rtw89: add RSSI based antenna diversity
      wifi: rtw89: add EVM for antenna diversity

Faicker Mo (1):
      netfilter: conntrack: allow insertion clash of gre protocol

Fedor Pchelkin (2):
      wifi: ath9k: avoid referencing uninit memory in ath9k_wmi_ctrl_rx
      wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

Feng Zhou (2):
      bpf: Add bpf_task_under_cgroup() kfunc
      selftests/bpf: Add testcase for bpf_task_under_cgroup

Florent Revest (2):
      selftests/bpf: Update the aarch64 tests deny list
      bpf, arm64: Support struct arguments in the BPF trampoline

Florian Fainelli (8):
      net: phy: Allow drivers to always call into ->suspend()
      net: phy: broadcom: Add support for Wake-on-LAN
      net: bcmgenet: Add support for PHY-based Wake-on-LAN
      net: phy: broadcom: Register dummy IRQ handler
      net: phy: broadcom: Add LPI counter
      net: phy: broadcom: Rename LED registers
      net: phy: broadcom: Add support for setting LED brightness
      net: bcmgenet: Ensure MDIO unregistration has clocks enabled

Florian Westphal (7):
      netfilter: nf_tables: relax set/map validation checks
      netfilter: nf_tables: always increment set element count
      netfilter: ipset: remove rcu_read_lock_bh pair from ip_set_test
      netfilter: nf_tables: permit update of set size
      netfilter: snat: evict closing tcp entries on reply tuple collision
      netfilter: nf_tables: limit allowed range via nla_policy
      netfilter: conntrack: dccp: copy entire header to stack buffer, not just basic one

Foster Snowhill (3):
      usbnet: ipheth: transmit URBs without trailing padding
      usbnet: ipheth: add CDC NCM support
      usbnet: ipheth: update Kconfig description

Frank Jungclaus (8):
      can: esd_usb: Make use of existing kernel macros
      can: esd_usb: Replace initializer macros used for struct can_bittiming_const
      can: esd_usb: Use consistent prefixes for macros
      can: esd_usb: Prefix all structures with the device name
      can: esd_usb: Replace hardcoded message length given to USB commands
      can: esd_usb: Don't bother the user with nonessential log message
      can: esd_usb: Make use of kernel macros BIT() and GENMASK()
      can: esd_usb: Use consistent prefix ESD_USB_ for macros

Gal Pressman (1):
      net/mlx5e: Remove mlx5e_dbg() and msglvl support

Geliang Tang (12):
      mptcp: export local_address
      mptcp: unify pm get_local_id interfaces
      mptcp: unify pm get_flags_and_ifindex_by_id
      mptcp: unify pm set_flags interfaces
      mptcp: pass addr to mptcp_pm_alloc_anno_list
      selftests: mptcp: test userspace pm out of transfer
      selftests: mptcp: check subflow and addr infos
      selftests: mptcp: set FAILING_LINKS in run_tests
      selftests: mptcp: drop test_linkfail parameter
      selftests: mptcp: drop addr_nr_ns1/2 parameters
      selftests: mptcp: drop sflags parameter
      selftests: mptcp: add pm_nl_set_endpoint helper

Georgi Valkov (1):
      usbnet: ipheth: fix risk of NULL pointer deallocation

Gilad Itzkovitch (1):
      wifi: cfg80211: S1G rate information and calculations

Gilad Sever (4):
      bpf: Factor out socket lookup functions for the TC hookpoint.
      bpf: Call __bpf_sk_lookup()/__bpf_skc_lookup() directly via TC hookpoint
      bpf: Fix bpf socket lookup from tc/xdp to respect socket VRF bindings
      selftests/bpf: Add vrf_socket_lookup tests

Giulio Benetti (1):
      net: phy: broadcom: drop brcm_phy_setbits() and use phy_set_bits() instead

Golan Ben Ami (2):
      wifi: iwlwifi: cfg: freeze 22500 devices FW API
      wifi: iwlwifi: acpi: add other Google OEMs to the ppag approved list

Govindaraj Saminathan (2):
      wifi: ath11k: remove unused function ath11k_tm_event_wmi()
      wifi: ath11k: factory test mode support

Gregory Greenman (9):
      wifi: iwlwifi: mvm: adjust csa notifications and commands to MLO
      wifi: iwlwifi: disable RX STBC when a device doesn't support it
      wifi: iwlwifi: fw: don't use constant size with efi.get_variable
      wifi: iwlwifi: pnvm: handle memory descriptor tlv
      wifi: iwlwifi: bump FW API to 79 for AX devices
      wifi: iwlwifi: mvm: add support for Extra EHT LTF
      wifi: iwlwifi: mvm: fix potential array out of bounds access
      wifi: iwlwifi: bump FW API to 81 for AX devices
      wifi: iwlwifi: bump FW API to 83 for AX/BZ/SC devices

Grygorii Strashko (1):
      net: phy: dp83869: support mii mode when rgmii strap cfg is used

Guillaume Nault (10):
      selftests: Add SO_DONTROUTE option to nettest.
      selftests: fcnal: Test SO_DONTROUTE on TCP sockets.
      selftests: fcnal: Test SO_DONTROUTE on UDP sockets.
      selftests: fcnal: Test SO_DONTROUTE on raw and ping sockets.
      ping: Stop using RTO_ONLINK.
      raw: Stop using RTO_ONLINK.
      udp: Stop using RTO_ONLINK.
      ipv4: Drop tos parameter from flowi4_update_output()
      ipv4: Set correct scope in inet_csk_route_*().
      tcp: Set route scope properly in cookie_v4_check().

Gustavo A. R. Silva (5):
      net: libwx: Replace zero-length array with flexible-array member
      mlxfw: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
      wifi: wil6210: fw: Replace zero-length arrays with DECLARE_FLEX_ARRAY() helper
      wifi: wil6210: wmi: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
      wifi: wext-core: Fix -Wstringop-overflow warning in ioctl_standard_iw_point()

Haim Dreyfuss (3):
      wifi: iwlwifi: don't silently ignore missing suspend or resume ops
      wifi: iwlwifi: mvm: offload BTM response during D3
      wifi: iwlwifi: mvm: rename BTM support flag and its TLV

Haiyang Zhang (1):
      net: mana: Add support for vlan tagging

Hao Chen (1):
      net: hns3: fix strncpy() not using dest-buf length as length issue

Hari Chandrakanthan (1):
      wifi: ath12k: delete the timer rx_replenish_retry during rmmod

Harini Katakam (2):
      phy: mscc: Use PHY_ID_MATCH_VENDOR to minimize PHY ID table
      phy: mscc: Add support for RGMII delay configuration

Hariprasad Kelam (5):
      octeontx2-pf: Rename tot_tx_queues to non_qos_queues
      octeontx2-pf: Refactor schedular queue alloc/free calls
      octeontx2-pf: Prepare for QOS offload
      octeontx2-pf: ethtool expose qos stats
      docs: octeontx2: Add Documentation for QOS

Heiner Kallweit (3):
      r8169: check for PCI read error in probe
      net: don't set sw irq coalescing defaults in case of PREEMPT_RT
      r8169: use dev_err_probe in all appropriate places in rtl_init_one()

Horatiu Vultur (11):
      net: lan966x: Add ES0 VCAP model
      net: lan966x: Add ES0 VCAP keyset configuration for lan966x
      net: lan966x: Add TC support for ES0 VCAP
      net: lan966x: Add registers to configure PCP, DEI, DSCP
      net: lan966x: Add support for offloading pcp table
      net: lan966x: Add support for apptrust
      net: lan966x: Add support for offloading dscp table
      net: lan966x: Add support for offloading default prio
      net: lan966x: Add support for PCP rewrite
      net: lan966x: Add support for DSCP rewrite
      net: micrel: Change to receive timestamp in the frame for lan8841

Hou Tao (5):
      bpf: Factor out a common helper free_all()
      selftests/bpf: Use producer_cnt to allocate local counter array
      selftests/bpf: Output the correct error code for pthread APIs
      selftests/bpf: Ensure that next_cpu() returns a valid CPU number
      selftests/bpf: Set the default value of consumer_cnt as 0

Ido Schimmel (10):
      skbuff: bridge: Add layer 2 miss indication
      flow_dissector: Dissect layer 2 miss from tc skb extension
      net/sched: flower: Allow matching on layer 2 miss
      flow_offload: Reject matching on layer 2 miss
      mlxsw: spectrum_flower: Split iif parsing to a separate function
      mlxsw: spectrum_flower: Do not force matching on iif
      mlxsw: spectrum_flower: Add ability to match on layer 2 miss
      selftests: forwarding: Add layer 2 miss test cases
      mlxsw: spectrum_nve_vxlan: Fix unsupported flag regression
      selftests: forwarding: Fix layer 2 miss test syntax

Ilan Peer (20):
      wifi: mac80211_hwsim: Fix possible NULL dereference
      wifi: mac80211: Add getter functions for vif MLD state
      wifi: mac80211_hwsim: Don't access vif valid links directly
      wifi: cfg80211: Support association to AP MLD with disabled links
      wifi: mac80211: Do not use "non-MLD AP" syntax
      wifi: mac80211: Fix permissions for valid_links debugfs entry
      wifi: iwlwifi: mvm: Propagate ERP slot changes to FW
      wifi: mac80211: Support disabled links during association
      wifi: mac80211: Add debugfs entry to report dormant links
      wifi: iwlwifi: Correctly indicate support for VHT TX STBC
      wifi: iwlwifi: mvm: Don't access vif valid links directly
      wifi: iwlwifi: mvm: Add support for SCAN API version 16
      wifi: mac80211: Rename multi_link
      wifi: mac80211: Add support for parsing Reconfiguration Multi Link element
      wifi: mac80211: Rename ieee80211_mle_sta_prof_size_ok()
      wifi: mac80211: Include Multi-Link in CRC calculation
      wifi: ieee80211: Fix the common size calculation for reconfiguration ML
      wifi: mac80211: Support link removal using Reconfiguration ML element
      wifi: cfg80211: Retrieve PSD information from RNR AP information
      wifi: iwlwifi: mvm: Add support for scan version 17

Ilia.Gavrilov (2):
      sctp: fix a potential OOB access in sctp_sched_set_sched()
      netfilter: nf_conntrack_sip: fix the ct_sip_parse_numerical_param() return value.

Ivan Mikhaylov (2):
      net/ncsi: make one oem_gma function for all mfr id
      net/ncsi: change from ndo_set_mac_address to dev_set_mac_address

Ivan Vecera (1):
      bnxt_en: Link representors to PCI device

JP Kobryn (3):
      libbpf: Add capability for resizing datasec maps
      libbpf: Selftests for resizing datasec maps
      libbpf: Change var type in datasec resize func

Jaco Coetzee (1):
      nfp: add L4 RSS hashing on UDP traffic

Jaco Kroon (1):
      net/pppoe: make number of hash bits configurable

Jacob Keller (4):
      ice: introduce ICE_TX_TSTAMP_WORK enumeration
      ice: trigger PFINT_OICR_TSYN_TX interrupt instead of polling
      ice: do not re-enable miscellaneous interrupt until thread_fn completes
      ice: reduce initial wait for control queue messages

Jakub Kicinski (148):
      Merge branch 'virtio_net-refactor-xdp-codes'
      Merge branch 'net-stmmac-convert-to-platform-remove-callback-returning-void'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Revert "net: Remove low_thresh in ip defrag"
      Merge tag 'linux-can-next-for-6.5-20230515' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge tag 'nf-next-2023-05-18' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-sfp-add-support-for-control-of-rate-selection'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'mptcp-refactor-inet_accept-and-mib-updates'
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge tag 'mlx5-updates-2023-05-19' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch 'splice-net-replace-sendpage-with-sendmsg-msg_splice_pages-part-1'
      Merge branch 'net-pcs-xpcs-cleanups-for-clause-73-support'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'ib-leds-netdev-v6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      net: ynl: prefix uAPI header include with uapi/
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'net-pcs-add-helpers-to-xpcs-and-lynx-to-manage-mdiodev'
      Merge branch 'netlink-specs-add-ynl-spec-for-ovs_flow'
      Merge branch 'devlink-move-port-ops-into-separate-structure'
      Merge branch 'add-layer-2-miss-indication-and-filtering'
      Merge branch 'net-dsa-mv88e6xxx-add-88e6361-support'
      Merge branch 'add-support-for-vsc85xx-dt-rgmii-delays'
      devlink: make health report on unregistered instance warn just once
      Merge branch 'wangxun-netdev-features-support'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'extend-dt-bindings-for-pse-pd-controllers-and-update-prtt1c-dts'
      tls: suppress wakeups unless we have a full record
      selftests: tls: add tests for poll behavior
      tools: ynl-gen: add extra headers for user space
      tools: ynl-gen: fix unused / pad attribute handling
      tools: ynl-gen: don't override pure nested struct
      tools: ynl-gen: loosen type consistency check for events
      tools: ynl-gen: add error checking for nested structs
      tools: ynl-gen: generate enum-to-string helpers
      tools: ynl-gen: move the response reading logic into YNL
      tools: ynl-gen: generate alloc and free helpers for req
      tools: ynl-gen: switch to family struct
      tools: ynl-gen: generate static descriptions of notifications
      Merge branch 'tools-ynl-gen-dust-off-the-user-space-code'
      Merge branch 'drm-i915-use-ref_tracker-library-for-tracking-wakerefs'
      Merge tag 'mlx5-updates-2023-05-31' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch 'splice-net-handle-msg_splice_pages-in-af_kcm'
      tools: ynl-gen: clean up stray new lines at the end of reply-less requests
      tools: ynl: user space helpers
      tools: ynl: support fou and netdev in C
      tools: ynl: add sample for netdev
      Merge branch 'tools-ynl-user-space-c'
      Merge branch 'move-ksz9477-errata-handling-to-phy-driver'
      Merge branch 'ipv4-remove-rt_conn_flags-calls-in-flowi4_init_output'
      tools: ynl-gen: fill in support for MultiAttr scalars
      tools: ynl-gen: improve unwind on parsing errors
      tools: ynl: generate code for the handshake family
      Merge branch 'tools-ynl-generate-code-for-the-handshake-family'
      Merge branch 'followup-fixes-for-the-dwmac-and-altera-lynx-conversion'
      net/mlx5e: simplify condition after napi budget handling change
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      netlink: specs: devlink: fill in some details important for C
      tools: ynl-gen: use enum names in op strmap more carefully
      tools: ynl-gen: refactor strmap helper generation
      tools: ynl-gen: enable code gen for directional specs
      tools: ynl-gen: try to sort the types more intelligently
      tools: ynl-gen: inherit struct use info
      tools: ynl-gen: walk nested types in depth
      tools: ynl-gen: don't generate forward declarations for policies
      tools: ynl-gen: don't generate forward declarations for policies - regen
      tools: ynl: generate code for the devlink family
      tools: ynl: add sample for devlink
      Merge branch 'tools-ynl-generate-code-for-the-devlink-family'
      Merge branch 'complete-lynx-mdio-device-handling'
      Merge tag 'mlx5-updates-2023-06-06' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch 'splice-net-rewrite-splice-to-socket-fix-splice_f_more-and-handle-msg_splice_pages-in-af_tls'
      Revert "tools: ynl: Remove duplicated include in handshake-user.c"
      tools: ynl-gen: cleanup user space header includes
      tools: ynl: regen: cleanup user space header includes
      tools: ynl-gen: complete the C keyword list
      tools: ynl-gen: combine else with closing bracket
      tools: ynl-gen: get attr type outside of if()
      tools: ynl: regen: regenerate the if ladders
      tools: ynl-gen: stop generating common notification handlers
      tools: ynl: regen: stop generating common notification handlers
      tools: ynl-gen: sanitize notification tracking
      tools: ynl-gen: support code gen for events
      tools: ynl-gen: don't pass op_name to RenderInfo
      tools: ynl-gen: support / skip pads on the way to kernel
      Merge branch 'tools-ynl-gen-code-gen-improvements-before-ethtool'
      Merge tag 'wireless-next-2023-06-09' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'mptcp-unify-pm-interfaces'
      Merge branch 'sfc-tc-encap-actions-offload'
      tools: ynl-gen: support excluding tricky ops
      tools: ynl-gen: record extra args for regen
      netlink: specs: support setting prefix-name per attribute
      netlink: specs: ethtool: add C render hints
      tools: ynl-gen: don't generate enum types if unnamed
      tools: ynl-gen: resolve enum vs struct name conflicts
      netlink: specs: ethtool: add empty enum stringset
      netlink: specs: ethtool: untangle UDP tunnels and cable test a bit
      netlink: specs: ethtool: untangle stats-get
      netlink: specs: ethtool: mark pads as pads
      tools: ynl: generate code for the ethtool family
      tools: ynl: add sample for ethtool
      netlink: support extack in dump ->start()
      net: ethtool: don't require empty header nests
      Merge branch 'net-flower-add-cfm-support'
      Merge branch 'splice-net-some-miscellaneous-msg_splice_pages-changes'
      tools: ynl-gen: correct enum policies
      tools: ynl-gen: inherit policy in multi-attr
      Merge branch 'tools-ynl-gen-improvements-for-dpll'
      net: create device lookup API with reference tracking
      netpoll: allocate netdev tracker right away
      net: tls: make the offload check helper take skb not socket
      tools: ynl: work around stale system headers
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      eth: fs_enet: fix print format for resource size
      Merge branch 'optimize-procedure-of-changing-mac-address-on-interface'
      gro: move the tc_ext comparison to a helper
      Merge branch 'ipv6-random-cleanup-for-extension-header'
      Merge branch 'net-stmmac-dwmac-qcom-ethqos-add-support-for-emac4'
      Merge branch 'selftests-preparations-for-out-of-order-operations-patches-in-mlxsw'
      Merge branch 'leds-trigger-netdev-add-additional-modes'
      Merge branch 'mptcp-expose-more-info-and-small-improvements'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'fix-comment-typos-about-transmit'
      Merge branch 'add-and-use-helper-for-pcs-negotiation-modes'
      tools: ynl: improve the direct-include header guard logic
      Merge branch 'net-dsa-microchip-fix-writes-to-phy-registers-0x10'
      Merge tag 'linux-can-fixes-for-6.4-20230622' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge tag 'linux-can-next-for-6.5-20230622' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge tag 'wireless-next-2023-06-22' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'mlxsw-maintain-candidate-rifs'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'net-stmmac-introduce-devres-helpers-for-stmmac-platform-drivers'
      Merge branch 'selftests-mptcp-refactoring-and-minor-fixes'
      Merge tag 'ieee802154-for-net-next-2023-06-23' of gitolite.kernel.org:pub/scm/linux/kernel/git/wpan/wpan-next
      Merge branch 'netlink-add-display-hint-to-ynl'
      Merge tag 'mlx5-updates-2023-06-21' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch 'splice-net-switch-over-users-of-sendpage-and-remove-it'
      Merge tag 'nf-next-23-06-26' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'use-vmalloc_array-and-vcalloc'
      phylink: ReST-ify the phylink_pcs_neg_mode() kdoc
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'af_unix-followup-fixes-for-so_passpidfd'

Jarkko Sakkinen (1):
      net: Use umd_cleanup_helper()

Jeremy Sowden (2):
      netfilter: nft_exthdr: add boolean DCCP option matching
      lib/ts_bm: reset initial match offset for every block of text

Jesper Dangaard Brouer (8):
      igc: Enable and fix RX hash usage by netstack
      igc: Add igc_xdp_buff wrapper for xdp_buff in driver
      igc: Add XDP hints kfuncs for RX hash
      igc: Add XDP hints kfuncs for RX timestamp
      selftests/bpf: xdp_hw_metadata track more timestamps
      samples/bpf: xdp1 and xdp2 reduce XDPBUFSIZE to 60
      bpf/xdp: optimize bpf_xdp_pointer to avoid reading sinfo
      selftests/bpf: Fix check_mtu using wrong variable type

Jesse Brandeburg (1):
      MAINTAINERS: update Intel Ethernet links

Ji-Ze Hong (1):
      can: usb: f81604: add Fintek F81604 support

Jian Shen (1):
      net: hns3: refine the tcam key convert handle

Jiapeng Chong (3):
      can: bxcan: Remove unnecessary print function dev_err()
      ip_gre: clean up some inconsistent indenting
      net/sched: act_pedit: Use kmemdup() to replace kmalloc + memcpy

Jiasheng Jiang (1):
      wifi: ath11k: Add missing check for ioremap

Jiawen Wu (8):
      net: txgbe: Add software nodes to support phylink
      net: txgbe: Register fixed rate clock
      net: txgbe: Register I2C platform device
      net: txgbe: Add SFP module identify
      net: txgbe: Support GPIO to SFP socket
      net: pcs: Add 10GBASE-R mode for Synopsys Designware XPCS
      net: txgbe: Implement phylink pcs
      net: txgbe: Support phylink MAC layer

Jiaxun Yang (1):
      net: pch_gbe: Allow build on MIPS_GENERIC kernel

Jimmy Assarsson (14):
      can: kvaser_pciefd: Remove useless write to interrupt register
      can: kvaser_pciefd: Remove handler for unused KVASER_PCIEFD_PACK_TYPE_EFRAME_ACK
      can: kvaser_pciefd: Add function to set skb hwtstamps
      can: kvaser_pciefd: Set hardware timestamp on transmitted packets
      can: kvaser_pciefd: Define unsigned constants with type suffix 'U'
      can: kvaser_pciefd: Remove SPI flash parameter read functionality
      can: kvaser_pciefd: Sort includes in alphabetic order
      can: kvaser_pciefd: Rename device ID defines
      can: kvaser_pciefd: Change return type for kvaser_pciefd_{receive,transmit,set_tx}_irq()
      can: kvaser_pciefd: Sort register definitions
      can: kvaser_pciefd: Use FIELD_{GET,PREP} and GENMASK where appropriate
      can: kvaser_pciefd: Add len8_dlc support
      can: kvaser_pciefd: Refactor code
      can: kvaser_pciefd: Use TX FIFO size read from CAN controller

Jiri Olsa (11):
      libbpf: Store zero fd to fd_array for loader kfunc relocation
      selftests/bpf: Move kfunc exports to bpf_testmod/bpf_testmod_kfunc.h
      selftests/bpf: Move test_progs helpers to testing_helpers object
      selftests/bpf: Use only stdout in un/load_bpf_testmod functions
      selftests/bpf: Do not unload bpf_testmod in load_bpf_testmod
      selftests/bpf: Use un/load_bpf_testmod functions in tests
      selftests/bpf: Load bpf_testmod for verifier test
      selftests/bpf: Allow to use kfunc from testmod.ko in test_verifier
      selftests/bpf: Remove extern from kfuncs declarations
      bpf: Move kernel test kfuncs to bpf_testmod
      selftests/bpf: Add missing prototypes for several test kfuncs

Jiri Pirko (25):
      devlink: remove duplicate port notification
      devlink: remove no longer true locking comment from port_new/del()
      devlink: pass devlink_port pointer to ops->port_del() instead of index
      devlink: introduce port ops placeholder
      ice: register devlink port for PF with ops
      mlxsw_core: register devlink port with ops
      nfp: devlink: register devlink port with ops
      devlink: move port_split/unsplit() ops into devlink_port_ops
      mlx4: register devlink port with ops
      devlink: move port_type_set() op into devlink_port_ops
      sfc: register devlink port with ops
      mlx5: register devlink ports with ops
      devlink: move port_fn_hw_addr_get/set() to devlink_port_ops
      devlink: move port_fn_roce_get/set() to devlink_port_ops
      devlink: move port_fn_migratable_get/set() to devlink_port_ops
      devlink: move port_fn_state_get/set() to devlink_port_ops
      devlink: move port_del() to devlink_port_ops
      devlink: save devlink_port_ops into a variable in devlink_port_function_validate()
      devlink: bring port new reply back
      net/mlx5: Skip inline mode check after mlx5_eswitch_enable_locked() failure
      net/mlx5: Remove unused ecpu field from struct mlx5_sf_table
      net/mlx5: Remove redundant MLX5_ESWITCH_MANAGER() check from is_ib_rep_supported()
      net/mlx5: Remove redundant is_mdev_switchdev_mode() check from is_ib_rep_supported()
      net/mlx5: Remove redundant check from mlx5_esw_query_vport_vhca_id()
      net/mlx5: Remove pointless vport lookup from mlx5_esw_check_port_type()

Jisheng Zhang (1):
      net: ethernet: litex: add support for 64 bit stats

Joanne Koong (5):
      bpf: Add bpf_dynptr_adjust
      bpf: Add bpf_dynptr_is_null and bpf_dynptr_is_rdonly
      bpf: Add bpf_dynptr_size
      bpf: Add bpf_dynptr_clone
      selftests/bpf: Add tests for dynptr convenience helpers

Joe Stringer (2):
      docs/bpf: Add table to describe LRU properties
      docs/bpf: Add LRU internals description and graph

Johannes Berg (108):
      wifi: iwlwifi: mvm: make internal callback structs const
      wifi: iwlwifi: mvm: dissolve iwl_mvm_mac_add_interface_common()
      wifi: iwlwifi: mvm: remove useless code
      wifi: iwlwifi: mvm: support injection rate control
      wifi: iwlwifi: mvm: clarify EHT RU allocation bits
      wifi: iwlwifi: pcie: adjust Bz device timings
      wifi: iwlwifi: mvm: remove warning for beacon filtering error
      wifi: iwlwifi: mvm: send time sync only if needed
      wifi: iwlwifi: mvm: tell firmware about per-STA MFP enablement
      wifi: iwlwifi: api: link context action in kernel-doc
      wifi: iwlwifi: api: use __le16 instead of u16
      wifi: iwlwifi: api: remove unused commands
      wifi: iwlwifi: api: fix kernel-doc links
      wifi: iwlwifi: fw: clean up PNVM loading code
      wifi: mac80211: HW restart for MLO
      wifi: mac80211: remove element scratch_len
      wifi: mac80211_hwsim: avoid warning with MLO PS stations
      wifi: mac80211: skip EHT BSS membership selector
      wifi: mac80211: implement proper AP MLD HW restart
      wifi: mac80211: recalc min chandef for new STA links
      wifi: mac80211: move sta_info_move_state() up
      wifi: mac80211: batch recalc during STA flush
      wifi: mac80211: stop warning after reconfig failures
      Revert "wifi: iwlwifi: mvm: FTM initiator MLO support"
      Revert "wifi: iwlwifi: update response for mcc_update command"
      Merge wireless into wireless-next
      wifi: cfg80211: hold wiphy lock in auto-disconnect
      wifi: cfg80211: hold wiphy lock in pmsr work
      wifi: cfg80211: move wowlan disable under locks
      wifi: cfg80211: wext: hold wiphy lock in siwgenie
      wifi: cfg80211: hold wiphy lock when sending wiphy
      wifi: cfg80211: add a work abstraction with special semantics
      wifi: mac80211: use wiphy work for sdata->work
      wifi: mac80211: unregister netdevs through cfg80211
      wifi: mac80211: use wiphy work for SMPS
      wifi: mac80211: use wiphy work for channel switch
      wifi: mac80211: ibss: move disconnect to wiphy work
      wifi: mac80211: mlme: move disconnects to wiphy work
      wifi: cfg80211: move sched scan stop to wiphy work
      wifi: cfg80211: move scan done work to wiphy work
      wifi: mac80211: add helpers to access sband iftype data
      wifi: mac80211: include key action/command in tracing
      wifi: mac80211: mlme: clarify WMM messages
      wifi: mac80211: don't update rx_stats.last_rate for NDP
      wifi: iwlwifi: unify checks for HW error values
      wifi: iwlwifi: mvm: always set MH len in offload_assist
      wifi: iwlwifi: mvm: support U-SIG EHT validate checks
      wifi: iwlwifi: mvm: put only a single IGTK into FW
      wifi: iwlwifi: dbg-tlv: fix DRAM data init
      wifi: iwlwifi: pcie: clear FW debug memory on init
      wifi: iwlwifi: pcie: remove redundant argument
      wifi: iwlwifi: dbg-tlv: clear FW debug memory on init
      Merge wireless into wireless-next
      wifi: iwlwifi: mvm: remove new checksum code
      wifi: iwlwifi: mvm: correctly access HE/EHT sband capa
      wifi: iwlwifi: fw: make some ACPI functions static
      wifi: iwlwifi: mvm: use iwl_mvm_is_vendor_in_approved_list()
      wifi: iwlwifi: pull from TXQs with softirqs disabled
      wifi: iwlwifi: pcie: double-check ACK interrupt after timeout
      wifi: iwlwifi: mvm: add a NULL pointer check
      wifi: iwlwifi: mvm: check link during TX
      wifi: iwlwifi: mvm: store WMM params per link
      wifi: iwlwifi: use array as array argument
      wifi: iwlwifi: mvm: always send spec link ID in link commands
      wifi: iwlwifi: add some FW misbehaviour check infrastructure
      wifi: iwlwifi: implement WPFC ACPI table loading
      wifi: iwlwifi: mvm: track u-APSD misbehaving AP by AP address
      wifi: cfg80211: fix regulatory disconnect for non-MLO
      wifi: cfg80211: fix regulatory disconnect with OCB/NAN
      wifi: ieee80211: reorder presence checks in MLE per-STA profile
      wifi: mac80211: agg-tx: add a few locking assertions
      wifi: mac80211: agg-tx: prevent start/stop race
      wifi: update multi-link element STA reconfig
      wifi: mac80211: check EHT basic MCS/NSS set
      wifi: mac80211: fix documentation config reference
      wifi: mac80211: move action length check up
      wifi: mac80211: drop some unprotected action frames
      wifi: mac80211: store BSS param change count from assoc response
      wifi: mac80211: always hold sdata lock in chanctx assign/unassign
      wifi: mac80211: fix CRC calculation for extended elems
      wifi: nl80211/reg: add no-EHT regulatory flag
      wifi: iwlwifi: pcie: refactor RB status size calculation
      wifi: iwlwifi: pcie: add size assertions
      wifi: iwlwifi: nvm: handle EHT/320 MHz regulatory flag
      wifi: iwlwifi: mvm: use EHT maximum MPDU length on 2.4 GHz
      wifi: iwlwifi: mvm: use min_t() for agg_size
      wifi: iwlwifi: mvm: add EHT A-MPDU size exponent support
      wifi: iwlwifi: limit EHT capabilities based on PCIe link speed
      wifi: iwlwifi: remove disable_dummy_notification
      wifi: iwlwifi: mvm: support new flush_sta method
      wifi: iwlwifi: mvm: indicate HW decrypt for beacon protection
      wifi: iwlwifi: mvm: avoid baid size integer overflow
      wifi: iwlwifi: mvm: check only affected links
      wifi: iwlwifi: mvm: adjust skip-over-dtim in D3
      wifi: iwlwifi: split 22000.c into multiple files
      wifi: iwlwifi: give Sc devices their own family
      wifi: iwlwifi: don't load old firmware for Sc
      wifi: iwlwifi: don't load old firmware for Bz
      wifi: iwlwifi: don't load old firmware for ax210
      wifi: iwlwifi: don't load old firmware for 22000
      wifi: iwlwifi: remove support for *nJ devices
      wifi: iwlwifi: pcie: also drop jacket from info macro
      wifi: iwlwifi: unify Bz/Gl device configurations
      wifi: iwlwifi: also unify Sc device configurations
      wifi: iwlwifi: also unify Ma device configurations
      wifi: iwlwifi: cfg: remove trailing dash from FW_PRE constants
      wifi: iwlwifi: cfg: clean up Bz module firmware lines
      wifi: ieee80211: fix erroneous NSTR bitmap size checks

Josua Mayer (1):
      net: sfp: add support for HXSX-ATRI-1 copper SFP+ module

Juerg Haefliger (1):
      wifi: p54: Add missing MODULE_FIRMWARE macro

Juhee Kang (3):
      wifi: rtlwifi: use helper function rtl_get_hdr()
      wifi: brcmutil: use helper function pktq_empty() instead of open code
      net/mlx5: Add header file for events

Julia Lawall (6):
      octeon_ep: use vmalloc_array and vcalloc
      gve: use vmalloc_array and vcalloc
      pds_core: use vmalloc_array and vcalloc
      ionic: use vmalloc_array and vcalloc
      net: enetc: use vmalloc_array and vcalloc
      net: mana: use vmalloc_array and vcalloc

Julian Anastasov (1):
      ipvs: dynamically limit the connection hash table

Justin Chen (2):
      ethtool: ioctl: improve error checking for set_wol
      ethtool: ioctl: account for sopass diff in set_wol

Kal Conley (1):
      xsk: Use pool->dma_pages to check for DMA

Kalle Valo (24):
      Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
      wifi: ath11k: debug: remove unused ATH11K_DBG_ANY
      wifi: ath11k: print debug level in debug messages
      wifi: ath11k: remove manual mask names from debug messages
      wifi: ath11k: add WMI event debug messages
      wifi: ath11k: remove unsupported event handlers
      wifi: ath11k: wmi: cleanup error handling in ath11k_wmi_send_init_country_cmd()
      wifi: ath11k: wmi: use common error handling style
      wifi: ath11k: wmi: add unified command debug messages
      wifi: ath11k: pci: cleanup debug logging
      wifi: ath11k: dp: cleanup debug message
      wifi: ath11k: debug: use all upper case in ATH11k_DBG_HAL
      wifi: ath11k: hal: cleanup debug message
      wifi: ath11k: don't use %pK
      wifi: ath11k: htc: cleanup debug messages
      wifi: ath11k: debug: add ATH11K_DBG_CE
      wifi: brcmfmac: fix gnu_printf warnings
      wifi: brcmsmac: fix gnu_printf warnings
      wifi: hostap: fix stringop-truncations GCC warning
      wifi: ray_cs: fix stringop-truncation GCC warning
      MAINTAINERS: mt76: add git tree
      MAINTAINERS: ath9k: add git tree
      MAINTAINERS: ath11k: add wiki and bugreport page
      Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

Karol Kolacinski (2):
      ice: handle extts in the miscellaneous interrupt thread
      ice: always return IRQ_WAKE_THREAD in ice_misc_intr()

Karthik M (2):
      wifi: ath12k: add wait operation for tx management packets for flush from mac80211
      wifi: ath12k: fix potential wmi_mgmt_tx_queue race condition

Kenjiro Nakayama (1):
      libbpf: Fix comment about arc and riscv arch in bpf_tracing.h

Kiran Kumar K (1):
      octeontx2-af: extend RSS supported offload types

Krzysztof Kozlowski (6):
      nfc: llcp: fix possible use of uninitialized variable in nfc_llcp_send_connect()
      dt-bindings: net: nxp,sja1105: document spi-cpol/cpha
      dt-bindings: net: drop unneeded quotes
      dt-bindings: net: bluetooth: qualcomm: document VDD_CH1
      dt-bindings: net: micrel,ks8851: allow SPI device properties
      Bluetooth: MAINTAINERS: add Devicetree bindings to Bluetooth drivers

Kui-Feng Lee (2):
      bpftool: Show map IDs along with struct_ops links.
      bpf: Print a warning only if writing to unprivileged_bpf_disabled.

Kuniyuki Iwashima (11):
      ping: Convert hlist_nulls to plain hlist.
      ipv6: rpl: Remove pskb(_may)?_pull() in ipv6_rpl_srh_rcv().
      ipv6: rpl: Remove redundant multicast tests in ipv6_rpl_srh_rcv().
      ipv6: exthdrs: Replace pskb_pull() with skb_pull() in ipv6_srh_rcv().
      ipv6: exthdrs: Reload hdr only when needed in ipv6_srh_rcv().
      ipv6: exthdrs: Remove redundant skb_headlen() check in ip6_parse_tlv().
      af_unix: Call scm_recv() only after scm_set_cred().
      gtp: Fix use-after-free in __gtp_encap_destroy().
      Revert "af_unix: Call scm_recv() only after scm_set_cred()."
      netlink: Add __sock_i_ino() for __netlink_diag_dump().
      af_unix: Skip SCM_PIDFD if scm->pid is NULL.

Kurt Kanzenbach (2):
      igc: Avoid transmit queue timeout for XDP
      net/core: Enable socket busy polling on -RT

Lama Kayal (2):
      net/mlx5e: Expose catastrophic steering error counters
      net/mlx5: Fix reserved at offset in hca_cap register

Larysa Zaremba (1):
      bpftool: Specify XDP Hints ifname when loading program

Liang Li (1):
      selftests: bonding: delete unnecessary line

Lin Ma (2):
      net: mctp: remove redundant RTN_UNICAST check
      net: nfc: Fix use-after-free caused by nfc_llcp_find_local

Lorenzo Bianconi (3):
      net: veth: rely on napi_build_skb in veth_convert_skb_to_xdp_buff
      net: veth: make PAGE_POOL_STATS optional
      selftests/bpf: Add xdp_feature selftest for bond device

Louis DeLosSantos (2):
      bpf: Add table ID to bpf_fib_lookup BPF helper
      selftests/bpf: Test table ID fib lookup BPF helper

Lucas Stach (1):
      net: fec: allow to build without PAGE_POOL_STATS

Lukas Bulwahn (2):
      net: skbuff: remove special handling for SLOB
      net/pppoe: fix a typo for the PPPOE_HASH_BITS_1 definition

Lukasz Majewski (2):
      net: dsa: Define .set_max_frame_size() callback for mv88e6250 SoC family
      net: dsa: mv88e6xxx: add support for MV88E6071 switch

M Chetan Kumar (4):
      net: wwan: iosm: remove unused macro definition
      net: wwan: iosm: remove unused enum definition
      net: wwan: iosm: clean up unused struct members
      net: wwan: iosm: enable runtime pm support for 7560

Maciej Fijalkowski (2):
      ice: allow hot-swapping XDP programs
      ice: use ice_down_up() where applicable

Magnus Karlsson (10):
      selftests/xsk: do not change XDP program when not necessary
      selftests/xsk: generate simpler packets with variable length
      selftests/xsk: add varying payload pattern within packet
      selftests/xsk: dump packet at error
      selftests/xsk: add packet iterator for tx to packet stream
      selftests/xsk: store offset in pkt instead of addr
      selftests/xsx: test for huge pages only once
      selftests/xsk: populate fill ring based on frags needed
      selftests/xsk: generate data for multi-buffer packets
      selftests/xsk: adjust packet pacing for multi-buffer support

Maharaja Kennadyrajan (2):
      wifi: ath11k: Relocate the func ath11k_mac_bitrate_mask_num_ht_rates() and change hweight16 to hweight8
      wifi: ath11k: Send HT fixed rate in WMI peer fixed param

Marc Kleine-Budde (11):
      can: length: make header self contained
      Merge patch series "can: Convert to platform remove callback returning void"
      Merge patch series "can: esd_usb: More preparation before supporting esd CAN-USB/3"
      Merge patch series "can: esd_usb: More preparation before supporting esd CAN-USB/3 (addendum)"
      Merge patch series "can: sja1000: Prepare the use of a threaded handler"
      can: rx-offload: fix coding style
      can: ti_hecc: fix coding style
      can: m_can: fix coding style
      Merge patch series "can: fix coding style"
      Merge patch series "can: length: fix definitions and add bit length calculation"
      Merge patch series "can: kvaser_pciefd: Fixes and improvements"

Marcel Hellwig (1):
      can: dev: add transceiver capabilities to xilinx_can

Marek Vasut (2):
      wifi: rsi: Do not configure WoWlan in shutdown hook if not enabled
      wifi: rsi: Do not set MMC_PM_KEEP_POWER in shutdown

Mark Bloch (3):
      net/mlx5e: en_tc, Extend peer flows to a list
      net/mlx5e: rep, store send to vport rules per peer
      net/mlx5e: en_tc, re-factor query route port

Martin Blumenstingl (4):
      wifi: rtw88: sdio: Check the HISR RX_REQUEST bit in rtw_sdio_rx_isr()
      wifi: rtw88: rtw8723d: Implement RTL8723DS (SDIO) efuse parsing
      mmc: sdio: Add/rename SDIO ID of the RTL8723DS SDIO wifi cards
      wifi: rtw88: Add support for the SDIO based RTL8723DS chipset

Martin Habets (1):
      sfc: Add devlink dev info support for EF10

Martin KaFai Lau (5):
      selftests/bpf: Add fexit_sleep to DENYLIST.aarch64
      libbpf: btf_dump_type_data_check_overflow needs to consider BTF_MEMBER_BITFIELD_SIZE
      bpf: Address KCSAN report on bpf_lru_list
      Merge branch 'bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen'
      Merge branch 'bpf: Add socket destroy capability'

Martin Kaiser (1):
      wifi: rtl8xxxu: rtl8xxxu_rx_complete(): remove unnecessary return

Martin Kaistra (18):
      wifi: rtl8xxxu: Add start_ap() callback
      wifi: rtl8xxxu: Select correct queue for beacon frames
      wifi: rtl8xxxu: Add beacon functions
      wifi: rtl8xxxu: Add set_tim() callback
      wifi: rtl8xxxu: Allow setting rts threshold to -1
      wifi: rtl8xxxu: Allow creating interface in AP mode
      wifi: rtl8xxxu: Actually use macid in rtl8xxxu_gen2_report_connect
      wifi: rtl8xxxu: Add parameter role to report_connect
      wifi: rtl8xxxu: Add parameter force to rtl8xxxu_refresh_rate_mask
      wifi: rtl8xxxu: Add sta_add() and sta_remove() callbacks
      wifi: rtl8xxxu: Put the macid in txdesc
      wifi: rtl8xxxu: Add parameter macid to update_rate_mask
      wifi: rtl8xxxu: Enable hw seq for mgmt/non-QoS data frames
      wifi: rtl8xxxu: Clean up filter configuration
      wifi: rtl8xxxu: Remove usage of ieee80211_get_tx_rate()
      wifi: rtl8xxxu: Remove usage of tx_info->control.rates[0].flags
      wifi: rtl8xxxu: Declare AP mode support for 8188f
      wifi: rtl8xxxu: Set maximum number of supported stations

Martin Wetterwald (1):
      net: ipconfig: Allow DNS to be overwritten by DHCPACK

Masahiro Yamada (1):
      net: liquidio: fix mixed module-builtin object

Matthias Brugger (1):
      wifi: brcmfmac: wcc: Add debug messages

Matthias Schiffer (1):
      net: dsa: mv88e6xxx: add support for MV88E6020 switch

Matthieu Baerts (3):
      ipv6: lower "link become ready"'s level message
      selftests: mptcp: join: skip check if MIB counter not supported (part 2)
      perf trace: fix MSG_SPLICE_PAGES build error

Maulik Jodhani (1):
      net: macb: Add support for partial store and forward

Maxim Kochetkov (1):
      net: axienet: Move reset before 64-bit DMA detection

Maxime Bizon (1):
      wifi: ath11k: fix registration of 6Ghz-only phy without the full channel range

Maxime Chevallier (9):
      net: mdio: Introduce a regmap-based mdio driver
      net: ethernet: altera-tse: Convert to mdio-regmap and use PCS Lynx
      net: pcs: Drop the TSE PCS driver
      net: stmmac: dwmac-sogfpga: use the lynx pcs driver
      net: altera-tse: Initialize local structs before using it
      net: altera_tse: Use the correct Kconfig option for the PCS_LYNX dependency
      net: stmmac: make the pcs_lynx cleanup sequence specific to dwmac_socfpga
      net: altera_tse: explicitly disable autoscan on the regmap-mdio bus
      net: dwmac_socfpga: initialize local data for mdio regmap configuration

Mengyuan Lou (8):
      net: wangxun: libwx add tx offload functions
      net: wangxun: libwx add rx offload functions
      net: wangxun: Implement vlan add and kill functions
      net: libwx: Implement xx_set_features ops
      net: ngbe: Add netdev features support
      net: ngbe: Implement vlan add and remove ops
      net: txgbe: Add netdev features support
      net: txgbe: Implement vlan add and remove ops

Michael Walle (1):
      dt-bindings: net: phy: gpy2xx: more precise description

Michal Smulski (1):
      net: dsa: mv88e6xxx: implement USXGMII mode for mv88e6393x

Michal Swiatkowski (5):
      ice: define meta data to match in switch
      ice: remove redundant Rx field from rule info
      ice: specify field names in ice_prot_ext init
      ice: allow matching on meta data
      ice: use src VSI instead of src MAC in slow-path

Miquel Raynal (9):
      ieee802154: Add support for user active scan requests
      mac802154: Handle active scanning
      ieee802154: Add support for allowing to answer BEACON_REQ
      mac802154: Handle received BEACON_REQ
      net: ieee802154: Handle limited devices with only datagram support
      ieee802154: ca8210: Flag the driver as being limited
      Merge tag 'v6.4-rc4' into wpan-next/staging
      can: sja1000: Prepare the use of a threaded handler
      can: sja1000: Prevent overrun stalls with a soft reset on Renesas SoCs

Miri Korenblit (5):
      wifi: iwlwifi: mvm: Make iwl_mvm_diversity_iter() MLO aware
      wifi: mac80211: allow disabling SMPS debugfs controls
      wifi: iwlwifi: fix max number of fw active links
      wifi: iwlwifi: handle eSR transitions
      wifi: iwlwifi: fw: send marker cmd before suspend cmd

Moritz Fischer (2):
      net: lan743x: Remove extranous gotos
      net: lan743x: Simplify comparison

Moshe Shemesh (4):
      net/mlx5: Ack on sync_reset_request only if PF can do reset_now
      net/mlx5: Expose timeout for sync reset unload stage
      net/mlx5: Check DTOR entry value is not zero
      net/mlx5: Handle sync reset unload event

Mukesh Sisodiya (17):
      wifi: iwlwifi: remove dead code in iwl_dump_ini_imr_get_size()
      wifi: mac80211: use u64 to hold enum ieee80211_bss_change flags
      wifi: mac80211: refactor ieee80211_select_link_key()
      wifi: mac80211_hwsim: check the return value of nla_put_u32
      wifi: iwlwifi: mvm: Handle return value for iwl_mvm_sta_init
      wifi: iwlwifi: mvm: fix getting LDPC/STBC support
      wifi: iwlwifi: fw: print PC register value instead of address
      wifi: iwlwifi: mvm: initialize the rx_vec before using it
      wifi: iwlwifi: support version C0 of BZ and GL devices
      wifi: iwlwifi: mvm: Add NULL check before dereferencing the pointer
      wifi: cfg80211: make TDLS management link-aware
      wifi: mac80211: handle TDLS negotiation with MLO
      wifi: mac80211: Extend AID element addition for TDLS frames
      wifi: iwlwifi: Add support for new PCI Id
      wifi: iwlwifi: Add support for new Bz version
      wifi: iwlwifi: Add support for new CNVi (SC)
      wifi: iwlwifi: remove support of A0 version of FM RF

Naveen Mamindlapalli (4):
      sch_htb: Allow HTB priority parameter in offload mode
      octeontx2-pf: Add support for HTB offload
      octeontx2-af: Add devlink option to adjust mcam high prio zone entries
      octeontx2-af: Set XOFF on other child transmit schedulers during SMQ flush

Neal Cardwell (1):
      tcp: remove unused TCP_SYNQ_INTERVAL definition

Neal Sidhwaney (1):
      wifi: brcmfmac: Detect corner error case earlier with log

Nicolas Cavallari (1):
      wifi: mac80211: Remove "Missing iftype sband data/EHT cap" spam

Nidhi Jain (1):
      wifi: ath11k: Add HTT stats for PHY reset case

Niklas Schnelle (2):
      s390/ism: Set DMA coherent mask
      wifi: add HAS_IOPORT dependencies

Nithin Dabilpuram (1):
      octeontx2-af: add option to toggle DROP_RE enable in rx cfg

Nitya Sunkad (1):
      ionic: add support for ethtool extended stat link_down_count

Oleksij Rempel (6):
      net: dsa: microchip: improving error handling for 8-bit register RMW operations
      net: dsa: microchip: remove ksz_port:on variable
      net: dsa: microchip: ksz8: Prepare ksz8863_smi for regmap register access validation
      net: dsa: microchip: Add register access control for KSZ8873 chip
      dt-bindings: net: pse-pd: Allow -N suffix for ethernet-pse node names
      net: phy: dp83td510: fix kernel stall during netboot in DP83TD510E PHY driver

Oliver Hartkopp (2):
      can: uapi: move CAN_RAW_FILTER_MAX definition to raw.h
      can: isotp: isotp_sendmsg(): fix return error fix on TX path

Or Har-Toov (2):
      net/mlx5: Expose bits for local loopback counter
      net/mlx5e: Add local loopback counter to vport stats

Oz Shlomo (1):
      net/mlx5e: TC, refactor access to hash key

P Praneesh (2):
      wifi: ath12k: Add support to parse new WMI event for 6 GHz regulatory
      wifi: ath11k: fix memory leak in WMI firmware stats

Pablo Neira Ayuso (6):
      netfilter: flowtable: simplify route logic
      netfilter: flowtable: split IPv4 datapath in helper functions
      netfilter: flowtable: split IPv6 datapath in helper functions
      netfilter: nft_payload: rebuild vlan header when needed
      netfilter: nf_tables: unbind non-anonymous set if rule construction fails
      netfilter: nf_tables: fix underflow in chain reference counter

Paolo Abeni (25):
      Merge branch 'net-mvneta-reduce-size-of-tso-header-allocation'
      Merge branch 'spdx-conversion-for-bonding-8390-and-i825xx-drivers'
      Merge branch 'net-lan966x-add-support-for-pcp-dei-dscp'
      inet: factor out locked section of inet_accept() in a new helper
      mptcp: refactor mptcp_stream_accept()
      mptcp: introduces more address related mibs
      selftests: mptcp: add explicit check for new mibs
      selftests: mptcp: centralize stats dumping
      Merge branch 'net-tcp-make-txhash-use-consistent-for-ipv4'
      Merge branch 'microchip-dsa-driver-improvements'
      Merge branch 'microchip_t1s-update-on-microchip-10base-t1s-phy-driver'
      Merge branch 'splice-net-handle-msg_splice_pages-in-chelsio-tls'
      Merge branch 'txgbe-phylink-support'
      Merge branch 'crypto-splice-net-make-af_alg-handle-sendmsg-msg_splice_pages'
      Merge branch 'mlxsw-preparations-for-out-of-order-operations-patches'
      mptcp: move snd_una update earlier for fallback socket
      mptcp: track some aggregate data counters
      selftests: mptcp: explicitly tests aggregate counters
      mptcp: add subflow unique id
      mptcp: introduce MPTCP_FULL_INFO getsockopt
      selftests: mptcp: add MPTCP_FULL_INFO testcase
      mptcp: consolidate transition to TCP_CLOSE in mptcp_do_fastclose()
      Merge branch 'net-hns3-there-are-some-cleanup-for-the-hns3-ethernet-driver'
      Merge branch 's390-net-updates-2023-06-10'
      Merge tag 'nf-23-06-27' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Parav Pandit (1):
      net: Make gro complete function to return void

Parthiban Veerasooran (6):
      net: phy: microchip_t1s: modify driver description to be more generic
      net: phy: microchip_t1s: replace read-modify-write code with phy_modify_mmd
      net: phy: microchip_t1s: update LAN867x PHY supported revision number
      net: phy: microchip_t1s: fix reset complete status handling
      net: phy: microchip_t1s: remove unnecessary interrupts disabling code
      net: phy: microchip_t1s: add support for Microchip LAN865x Rev.B0 PHYs

Paul Greenwalt (3):
      ice: update ICE_PHY_TYPE_HIGH_MAX_INDEX
      ice: refactor PHY type to ethtool link mode
      ice: update PHY type to ethtool link mode mapping

Pavel Begunkov (4):
      net/tcp: don't peek at tail for io_uring zc
      net/tcp: optimise io_uring zc ubuf refcounting
      net/tcp: refactor tcp_inet6_sk()
      net/tcp: optimise locking for blocking splice

Peiyang Wang (1):
      net: hns3: clear hns unused parameter alarm

Pengcheng Yang (2):
      samples/bpf: Fix buffer overflow in tcp_basertt
      bpftool: Support bpffs mountpoint as pin path for prog loadall

Peter Seiderer (1):
      wifi: ath9k: fix AR9003 mac hardware hang check register offset calculation

Petr Machata (50):
      mlxsw: spectrum_router: Clarify a comment
      mlxsw: spectrum_router: Use extack in mlxsw_sp~_rif_ipip_lb_configure()
      mlxsw: spectrum_router: Do not query MAX_RIFS on each iteration
      mlxsw: spectrum_router: Do not query MAX_VRS on each iteration
      selftests: mlxsw: ingress_rif_conf_1d: Fix the diagram
      selftests: mlxsw: egress_vid_classification: Fix the diagram
      selftests: router_bridge_vlan: Add a diagram
      selftests: router_bridge_vlan: Set vlan_default_pvid 0 on the bridge
      mlxsw: spectrum_router: mlxsw_sp_router_fini(): Extract a helper variable
      mlxsw: spectrum_router: Move here inetaddr validator notifiers
      mlxsw: spectrum_router: Pass router to mlxsw_sp_router_schedule_work() directly
      mlxsw: spectrum_router: Use the available router pointer for netevent handling
      mlxsw: spectrum_router: Reuse work neighbor initialization in work scheduler
      mlxsw: Convert RIF-has-netdevice queries to a dedicated helper
      mlxsw: Convert does-RIF-have-this-netdev queries to a dedicated helper
      mlxsw: spectrum_router: Privatize mlxsw_sp_rif_dev()
      mlxsw: spectrum_router: Extract a helper from mlxsw_sp_port_vlan_router_join()
      mlxsw: spectrum_router: Add a helper specifically for joining a LAG
      mlxsw: spectrum_router: Access rif->dev through a helper
      mlxsw: spectrum_router: Access rif->dev from params in mlxsw_sp_rif_create()
      mlxsw: spectrum_router: Access nh->rif->dev through a helper
      mlxsw: spectrum_router: Access nhgi->rif through a helper
      mlxsw: spectrum_router: Extract a helper to free a RIF
      mlxsw: spectrum_router: Add a helper to check if netdev has addresses
      mlxsw: spectrum_router: Extract a helper for RIF migration
      mlxsw: spectrum_router: Move IPIP init up
      selftests: forwarding: q_in_vni: Disable IPv6 autogen on bridges
      selftests: forwarding: dual_vxlan_bridge: Disable IPv6 autogen on bridges
      selftests: forwarding: skbedit_priority: Disable IPv6 autogen on a bridge
      selftests: forwarding: pedit_dsfield: Disable IPv6 autogen on a bridge
      selftests: forwarding: mirror_gre_*: Disable IPv6 autogen on bridges
      selftests: forwarding: mirror_gre_*: Use port MAC for bridge address
      selftests: forwarding: router_bridge: Use port MAC for bridge address
      selftests: mlxsw: q_in_q_veto: Disable IPv6 autogen on bridges
      selftests: mlxsw: extack: Disable IPv6 autogen on bridges
      selftests: mlxsw: mirror_gre_scale: Disable IPv6 autogen on a bridge
      selftests: mlxsw: qos_dscp_bridge: Disable IPv6 autogen on a bridge
      selftests: mlxsw: qos_ets_strict: Disable IPv6 autogen on bridges
      selftests: mlxsw: qos_mc_aware: Disable IPv6 autogen on bridges
      selftests: mlxsw: spectrum: q_in_vni_veto: Disable IPv6 autogen on a bridge
      selftests: mlxsw: vxlan: Disable IPv6 autogen on bridges
      selftests: mlxsw: one_armed_router: Use port MAC for bridge address
      mlxsw: spectrum_router: Add extack argument to mlxsw_sp_lb_rif_init()
      mlxsw: spectrum_router: Use mlxsw_sp_ul_rif_get() to get main VRF LB RIF
      mlxsw: spectrum_router: Maintain a hash table of CRIFs
      mlxsw: spectrum_router: Maintain CRIF for fallback loopback RIF
      mlxsw: spectrum_router: Link CRIFs to RIFs
      mlxsw: spectrum_router: Use router.lb_crif instead of .lb_rif_index
      mlxsw: spectrum_router: Split nexthop finalization to two stages
      mlxsw: spectrum_router: Track next hops at CRIFs

Petr Oros (1):
      devlink: report devlink_port_type_warn source device

Phil Sutter (1):
      netfilter: nf_tables: Introduce NFT_MSG_GETSETELEM_RESET

Philipp Rosenberger (1):
      net: enc28j60: Use threaded interrupt instead of workqueue

Pieter Jansen van Vuuren (1):
      sfc: handle VI shortage on ef100 by readjusting the channels

Ping-Ke Shih (42):
      wifi: rtw89: use struct rtw89_phy_sts_ie0 instead of macro to access PHY IE0 status
      wifi: rtw89: set capability of TX antenna diversity
      wifi: rtw89: add RSSI statistics for the case of antenna diversity to debugfs
      wifi: rtw89: add EVM and SNR statistics to debugfs
      wifi: rtw89: 8851b: add 8851B basic chip_info
      wifi: rtw89: 8851be: add 8851BE PCI entry and fill PCI capabilities
      wifi: rtw89: 8851b: add NCTL post table
      wifi: rtw89: use chip_info::small_fifo_size to choose debug_mask
      wifi: rtw89: change naming of BA CAM from V1 to V0_EXT
      wifi: rtw89: 8851b: add DLE mem and HFC quota
      wifi: rtw89: 8851b: add set_channel_rf()
      wifi: rtw89: 8851b: rfk: add AACK
      wifi: rtw89: 8851b: rfk: add RCK
      wifi: rtw89: 8851b: rfk: add DACK
      wifi: rtw89: 8851b: rfk: add IQK
      wifi: rtw89: 8851b: add to read efuse version to recognize hardware version B
      wifi: rtw89: 8851b: configure GPIO according to RFE type
      wifi: rtw89: 8851b: add BT coexistence support function
      wifi: rtw89: 8851b: add basic power on function
      wifi: rtw89: 8851b: add set channel function
      wifi: rtw89: 8851b: add to parse efuse content
      wifi: rtw89: 8851b: rfk: add RX DCK
      wifi: rtw89: 8851b: rfk: add DPK
      wifi: rtw89: 8851b: rfk: add TSSI
      wifi: rtw89: 8851b: add TX power related functions
      wifi: rtw89: 8851b: fill BB related capabilities to chip_info
      wifi: rtw89: 8851b: add MAC configurations to chip_info
      wifi: rtw89: 8851b: add RF configurations
      wifi: rtw89: enlarge supported length of read_reg debugfs entry
      wifi: rtw89: 8851b: add 8851be to Makefile and Kconfig
      wifi: rtw89: add chip_ops::query_rxdesc() and rxd_len as helpers to support newer chips
      wifi: rtw89: use struct and le32_get_bits to access RX info
      wifi: rtw89: use struct and le32_get_bits() to access received PHY status IEs
      wifi: rtw89: use struct and le32_get_bits() to access RX descriptor
      wifi: rtw89: use struct to access register-based H2C/C2H
      wifi: rtw89: 8852c: update RF radio A/B parameters to R63
      wifi: rtw88: add missing unwind goto for __rtw_download_firmware()
      wifi: rtw89: 8851b: update RF radio A parameters to R28
      wifi: rtw89: 8851b: rfk: add LCK track
      wifi: rtw89: 8851b: rfk: update IQK to version 0x8
      wifi: rtw89: 8851b: configure to force 1 TX power value
      wifi: rtw89: use struct to parse firmware header

Piotr Gardocki (4):
      net: add check for current MAC address in dev_set_mac_address
      i40e: remove unnecessary check for old MAC == new MAC
      ice: remove unnecessary check for old MAC == new MAC
      net: fix net device address assign type

Piotr Raczynski (8):
      ice: move interrupt related code to separate file
      ice: use pci_irq_vector helper function
      ice: use preferred MSIX allocation api
      ice: refactor VF control VSI interrupt handling
      ice: remove redundant SRIOV code
      ice: add individual interrupt allocation
      ice: track interrupt vectors with xarray
      ice: add dynamic interrupt allocation

Po-Hao Huang (8):
      wifi: rtw89: 8851b: enable hw_scan support
      wifi: rtw88: Fix action frame transmission fail before association
      wifi: rtw88: use struct instead of macros to set TX desc
      wifi: rtw88: Fix AP mode incorrect DTIM behavior
      wifi: rtw88: Skip high queue in hci_flush
      wifi: rtw88: Stop high queue during scan
      wifi: rtw88: refine register based H2C command
      wifi: rtw88: fix not entering PS mode after AP stops

Pranavi Somisetty (1):
      dt-bindings: net: cdns,macb: Add rx-watermark property

Przemek Kitszel (5):
      iavf: fix err handling for MAC replace
      iavf: remove some unused functions and pointless wrappers
      iavf: make functions static where possible
      ice: clean up freeing SR-IOV VFs
      ice: remove null checks before devm_kfree() calls

Radhey Shyam Pandey (1):
      dt-bindings: net: xlnx,axi-ethernet: convert bindings document to yaml

Rahul Rameshbabu (9):
      ptp: Clarify ptp_clock_info .adjphase expects an internal servo to be used
      docs: ptp.rst: Add information about NVIDIA Mellanox devices
      testptp: Remove magic numbers related to nanosecond to second conversion
      testptp: Add support for testing ptp_clock_info .adjphase callback
      ptp: Add .getmaxphase callback to ptp_clock_info
      net/mlx5: Add .getmaxphase ptp_clock_info callback
      ptp: ptp_clockmatrix: Add .getmaxphase ptp_clock_info callback
      ptp: idt82p33: Add .getmaxphase ptp_clock_info callback
      ptp: ocp: Add .getmaxphase ptp_clock_info callback

Raju Rangoju (1):
      amd-xgbe: extend 10Mbps support to MAC version 21H

Randy Dunlap (3):
      s390/net: lcs: use IS_ENABLED() for kconfig detection
      revert "s390/net: lcs: use IS_ENABLED() for kconfig detection"
      linux/netfilter.h: fix kernel-doc warnings

Rasmus Villemoes (3):
      net: dsa: microchip: simplify ksz_prmw8()
      net: dsa: microchip: add ksz_prmw32() helper
      net: dsa: microchip: fix writes to phy registers >= 0x10

Ratheesh Kannoth (2):
      octeontx2-pf: Add support for page pool
      octeontx2-pf: TC flower offload support for rxqueue mapping

Ravi Gunasekaran (1):
      net: hsr: Disable promiscuous mode in offload mode

Remi Pommarel (1):
      wifi: ath9k: Fix possible stall on ath9k_txq_list_has_key()

Richard Gobert (1):
      gro: decrease size of CB

Rob Herring (2):
      mdio: mdio-mux-mmioreg: Use of_property_read_reg() to parse "reg"
      dt-bindings: net: altr,tse: Fix error in "compatible" conditional schema

Robert Hancock (2):
      net: phy: micrel: Move KSZ9477 errata fixes to PHY driver
      net: dsa: microchip: remove KSZ9477 PHY errata handling

Roi Dayan (22):
      net/mlx5: Remove redundant esw multiport validate function
      net/mlx5: E-Switch, Remove redundant check
      net/mlx5e: E-Switch, Remove flow_source check for metadata matching
      net/mlx5e: Remove redundant __func__ arg from fs_err() calls
      net/mlx5e: E-Switch, Update when to set other vport context
      net/mlx5e: E-Switch, Allow get vport api if esw exists
      net/mlx5e: E-Switch, Use metadata for vport matching in send-to-vport rules
      net/mlx5: Remove redundant vport_group_manager cap check
      net/mlx5e: E-Switch, Check device is PF when stopping esw offloads
      net/mlx5e: E-Switch: move debug print of adding mac to correct place
      net/mlx5e: E-Switch, Add a check that log_max_l2_table is valid
      net/mlx5: E-Switch, Use RoCE version 2 for loopback traffic
      net/mlx5: E-Switch, Use metadata matching for RoCE loopback rule
      net/mlx5: devlink, Only show PF related devlink warning when needed
      net/mlx5e: E-Switch, Initialize E-Switch for eswitch manager
      net/mlx5: Lag, Remove duplicate code checking lag is supported
      net/mlx5e: Use vhca_id for device index in vport rx rules
      net/mlx5e: E-Switch, Add peer fdb miss rules for vport manager or ecpf
      net/mlx5e: E-Switch, Use xarray for devcom paired device index
      net/mlx5e: E-Switch, Pass other_vport flag if vport is not 0
      net/mlx5e: Remove redundant comment
      net/mlx5e: E-Switch, Fix shared fdb error flow

Ruiqi Gong (1):
      bpf: Cleanup unused function declaration

Russell King (1):
      net: phy: add helpers for comparing phy IDs

Russell King (Oracle) (66):
      net: mvneta: fix transmit path dma-unmapping on error
      net: mvneta: mark mapped and tso buffers separately
      net: mvneta: use buf->type to determine whether to dma-unmap
      net: mvneta: move tso_build_hdr() into mvneta_tso_put_hdr()
      net: mvneta: allocate TSO header DMA memory in chunks
      net: phylink: constify fwnode arguments
      net: sfp: add helper to modify signal states
      net: sfp: move rtnl lock to cover reading state
      net: sfp: swap order of rtnl and st_mutex locks
      net: sfp: move sm_mutex into sfp_check_state()
      net: sfp: change st_mutex locking
      net: sfp: add support for setting signalling rate
      net: sfp: add support for rate selection
      net: altera: tse: remove mac_an_restart() function
      net: sfp: add support for a couple of copper multi-rate modules
      net: phylink: require supported_interfaces to be filled
      net: phy: avoid kernel warning dump when stopping an errored PHY
      net: mdio: add clause 73 to ethtool conversion helper
      net: phylink: remove duplicated linkmode pause resolution
      net: phylink: add function to resolve clause 73 negotiation
      net: pcs: xpcs: clean up reading clause 73 link partner advertisement
      net: pcs: xpcs: use mii_c73_to_linkmode() helper
      net: pcs: xpcs: correct lp_advertising contents
      net: pcs: xpcs: correct pause resolution
      net: pcs: xpcs: use phylink_resolve_c73() helper
      net: pcs: xpcs: avoid reading STAT1 more than once
      net: phylink: provide phylink_pcs_config() and phylink_pcs_link_up()
      net: dsa: add support for mac_prepare() and mac_finish() calls
      net: dsa: mv88e6xxx: move link forcing to mac_prepare/mac_finish
      net: mdio: add mdio_device_get() and mdio_device_put()
      net: pcs: xpcs: add xpcs_create_mdiodev()
      net: stmmac: use xpcs_create_mdiodev()
      net: pcs: lynx: add lynx_pcs_create_mdiodev()
      net: dsa: ocelot: use lynx_pcs_create_mdiodev()
      net: enetc: use lynx_pcs_create_mdiodev()
      net: dpaa2-mac: use correct interface to free mdiodev
      net: phylib: fix phy_read*_poll_timeout()
      net: dsa: sja1105: allow XPCS to handle mdiodev lifetime
      net: dsa: sja1105: use xpcs_create_mdiodev()
      net: pcs: xpcs: remove xpcs_create() from public view
      net: dpaa2-mac: allow lynx PCS to manage mdiodev lifetime
      net: fman_memac: allow lynx PCS to handle mdiodev lifetime
      net: pcs: lynx: remove lynx_get_mdio_device()
      net: pcs: lynx: add lynx_pcs_create_fwnode()
      net: dpaa2-mac: use lynx_pcs_create_fwnode()
      net: fman_memac: use lynx_pcs_create_fwnode()
      net: pcs: lynx: make lynx_pcs_create() static
      net: pcs: lynx: change lynx_pcs_create() to return error-pointers
      net: pcs: lynx: check that the fwnode is available prior to use
      net: dpaa2: use pcs-lynx's check for fwnode availability
      net: fman_memac: use pcs-lynx's check for fwnode availability
      net: phylink: add PCS negotiation mode
      net: phylink: convert phylink_mii_c22_pcs_config() to neg_mode
      net: phylink: pass neg_mode into phylink_mii_c22_pcs_config()
      net: pcs: xpcs: update PCS driver to use neg_mode
      net: pcs: lynxi: update PCS driver to use neg_mode
      net: pcs: lynx: update PCS driver to use neg_mode
      net: lan966x: update PCS driver to use neg_mode
      net: mvneta: update PCS driver to use neg_mode
      net: mvpp2: update PCS driver to use neg_mode
      net: prestera: update PCS driver to use neg_mode
      net: qca8k: update PCS driver to use neg_mode
      net: sparx5: update PCS driver to use neg_mode
      net: dsa: b53: update PCS driver to use neg_mode
      net: dsa: mt7530: update PCS driver to use neg_mode
      net: macb: update PCS driver to use neg_mode

Sabrina Dubroca (1):
      selftests: rtnetlink: remove netdevsim device after ipsec offload test

Saeed Mahameed (2):
      net/mlx5: Devcom, introduce devcom_for_each_peer_entry
      net/mlx5: E-Switch, remove redundant else statements

Sascha Hauer (1):
      wifi: rtw88: usb: silence log flooding error message

Sathesh Edara (1):
      MAINTAINERS: update email addresses of octeon_ep driver maintainers

Sebastian Andrzej Siewior (1):
      bpf: Remove in_atomic() from bpf_link_put().

Shay Drory (23):
      net/mlx5e: tc, Refactor peer add/del flow
      net/mlx5e: Handle offloads flows per peer
      net/mlx5: E-switch, enlarge peer miss group table
      net/mlx5: E-switch, refactor FDB miss rule add/remove
      net/mlx5: E-switch, Handle multiple master egress rules
      net/mlx5: E-switch, generalize shared FDB creation
      net/mlx5: DR, handle more than one peer domain
      net/mlx5: Devcom, Rename paired to ready
      net/mlx5: E-switch, mark devcom as not ready when all eswitches are unpaired
      net/mlx5: Devcom, extend mlx5_devcom_send_event to work with more than two devices
      RDMA/mlx5: Free second uplink ib port
      {net/RDMA}/mlx5: introduce lag_for_each_peer
      net/mlx5: LAG, check if all eswitches are paired for shared FDB
      net/mlx5: LAG, generalize handling of shared FDB
      net/mlx5: LAG, change mlx5_shared_fdb_supported() to static
      net/mlx5: LAG, block multipath LAG in case ldev have more than 2 ports
      net/mlx5: LAG, block multiport eswitch LAG in case ldev have more than 2 ports
      net/mlx5: Enable 4 ports VF LAG
      net/mlx5: Split function_setup() to enable and open functions
      net/mlx5: Move esw multiport devlink param to eswitch code
      net/mlx5: Light probe local SFs
      net/mlx5: Fix UAF in mlx5_eswitch_cleanup()
      net/mlx5: Fix SFs kernel documentation error

Shenwei Wang (1):
      net: fec: using the standard return codes when xdp xmit errors

Shradha Gupta (1):
      hv_netvsc: Allocate rx indirection table size dynamically

Simon Horman (4):
      bonding: Always assign be16 value to vlan_proto
      devlink: Spelling corrections
      net: txgbe: Avoid passing uninitialised parameter to pci_wake_from_d3()
      nfc: nxp-nci: store __be16 value in __be16 variable

Sowmiya Sree Elavalagan (1):
      wifi: ath11k: Allow ath11k to boot without caldata in ftm mode

Stanislav Fomichev (4):
      bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen
      selftests/bpf: Update EFAULT {g,s}etsockopt selftests
      selftests/bpf: Correctly handle optlen > 4096
      bpf: Document EFAULT changes for sockopt

Stephen Rothwell (1):
      sunvnet: fix sparc64 build error after gso code split

Stephen Veiss (2):
      selftests/bpf: Extract insert_test from parse_test_list
      selftests/bpf: Test_progs can read test lists from file

Su Hui (1):
      bpf/tests: Use struct_size()

Subbaraya Sundeep (5):
      macsec: Use helper macsec_netdev_priv for offload drivers
      octeontx2-pf: mcs: Offload extended packet number(XPN) feature
      octeontx2-pf: qos send queues management
      octeontx2-pf: mcs: Support VLAN in clear text
      octeontx2-af: Enable LBK links only when switch mode is on.

Sunil Goutham (1):
      octeontx2-af: cn10k: Set NIX DWRR MTU for CN10KB silicon

Tariq Toukan (1):
      net/mlx5e: Remove RX page cache leftovers

Teoh Ji Sheng (1):
      net: stmmac: xgmac: add ethtool per-queue irq statistic support

Thorsten Winkler (4):
      s390/lcs: Convert sysfs sprintf to sysfs_emit
      s390/lcs: Convert sprintf to scnprintf
      s390/ctcm: Convert sysfs sprintf to sysfs_emit
      s390/ctcm: Convert sprintf/snprintf to scnprintf

Tom Rix (1):
      igb: Define igb_pm_ops conditionally on CONFIG_PM

Uwe Kleine-König (40):
      net: stmmac: Make stmmac_pltfr_remove() return void
      net: stmmac: dwmac-visconti: Make visconti_eth_clock_remove() return void
      net: stmmac: dwmac-qcom-ethqos: Drop an if with an always false condition
      net: stmmac: dwmac-visconti: Convert to platform remove callback returning void
      net: stmmac: dwmac-dwc-qos-eth: Convert to platform remove callback returning void
      net: stmmac: dwmac-qcom-ethqos: Convert to platform remove callback returning void
      net: stmmac: dwmac-rk: Convert to platform remove callback returning void
      net: stmmac: dwmac-sti: Convert to platform remove callback returning void
      net: stmmac: dwmac-stm32: Convert to platform remove callback returning void
      net: stmmac: dwmac-sun8i: Convert to platform remove callback returning void
      net: stmmac: dwmac-tegra: Convert to platform remove callback returning void
      net: samsung: sxgbe: Make sxgbe_drv_remove() return void
      can: at91_can: Convert to platform remove callback returning void
      can: bxcan: Convert to platform remove callback returning void
      can: c_can: Convert to platform remove callback returning void
      can: cc770_isa: Convert to platform remove callback returning void
      can: cc770_platform: Convert to platform remove callback returning void
      can: ctucanfd: Convert to platform remove callback returning void
      can: flexcan: Convert to platform remove callback returning void
      can: grcan: Convert to platform remove callback returning void
      can: ifi_canfd: Convert to platform remove callback returning void
      can: janz-ican3: Convert to platform remove callback returning void
      can: m_can: Convert to platform remove callback returning void
      can: mscan: mpc5xxx_can: Convert to platform remove callback returning void
      can: rcar: Convert to platform remove callback returning void
      can: sja1000_isa: Convert to platform remove callback returning void
      can: sja1000_platform: Convert to platform remove callback returning void
      can: softing: Convert to platform remove callback returning void
      can: sun4i_can: Convert to platform remove callback returning void
      can: ti_hecc: Convert to platform remove callback returning void
      can: xilinx: Convert to platform remove callback returning void
      net: arc: Make arc_emac_remove() return void
      nfc: Switch i2c drivers back to use .probe()
      net: dsa: Switch i2c drivers back to use .probe()
      wifi: ath10k: Drop cleaning of driver data from probe error path and remove
      wifi: ath10k: Drop checks that are always false
      wifi: ath10k: Convert to platform remove callback returning void
      wifi: atk10k: Don't opencode ath10k_pci_priv() in ath10k_ahb_priv()
      net: mlxsw: i2c: Switch back to use struct i2c_driver's .probe()
      mctp i2c: Switch back to use struct i2c_driver's .probe()

Veerendranath Jakkam (1):
      wifi: cfg80211/nl80211: Add support to indicate STA MLD setup links removal

Venkateswara Naralasetty (1):
      wifi: ath11k: update proper pdev/vdev id for testmode command

Viktor Malik (1):
      tools/resolve_btfids: Fix setting HOSTCFLAGS

Vincent Mailhol (3):
      can: length: fix description of the RRS field
      can: length: fix bitstuffing count
      can: length: refactor frame lengths definition to add size in bits

Vinicius Costa Gomes (4):
      igc: Fix race condition in PTP tx code
      igc: Check if hardware TX timestamping is enabled earlier
      igc: Retrieve TX timestamp during interrupt handling
      igc: Work around HW bug causing missing timestamps

Vlad Buslov (3):
      net/mlx5: Create eswitch debugfs root directory
      net/mlx5: Bridge, pass net device when linking vport to bridge
      net/mlx5: Bridge, expose FDB state via debugfs

Vladimir Nikishkin (3):
      net: vxlan: Add nolocalbypass option to vxlan.
      selftests: net: vxlan: Add tests for vxlan nolocalbypass option.
      selftests: net: vxlan: Fix selftest regression after changes in iproute2.

Vladimir Oltean (10):
      net: dsa: microchip: add an enum for regmap widths
      net/sched: taprio: don't overwrite "sch" variable in taprio_dump_class_stats()
      net/sched: taprio: replace tc_taprio_qopt_offload :: enable with a "cmd" enum
      net/sched: taprio: add netlink reporting for offload statistics counters
      net: enetc: refactor enetc_setup_tc_taprio() to have a switch/case for cmd
      net: enetc: report statistics counters for taprio
      net/sched: taprio: report class offload stats per TXQ, not per TC
      net: enetc: reset taprio stats when taprio is deleted
      net: phy: mscc: fix packet loss due to RGMII delays
      net: dsa: avoid suspicious RCU usage for synced VLAN-aware MAC addresses

Wang Jikai (1):
      wifi: mt7601u: delete dead code checking debugfs returns

Wei Fang (3):
      net: fec: turn on XDP features
      net: fec: remove useless fec_enet_reset_skb()
      net: fec: remove last_bdp from fec_enet_txq_xmit_frame()

Wen Gong (2):
      wifi: ath11k: add support default regdb while searching board-2.bin for WCN6855
      wifi: ath12k: fix conf_mutex in ath12k_mac_op_unassign_vif_chanctx()

Will Hawkins (1):
      bpf, docs: Update llvm_relocs.rst with typo fixes

Xin Long (3):
      tipc: delete tipc_mtu_bad from tipc_udp_enable
      tipc: replace open-code bearer rcu_dereference access in bearer.c
      rtnetlink: move validate_linkmsg out of do_setlink

Xuan Zhuo (15):
      virtio_net: mergeable xdp: put old page immediately
      virtio_net: introduce mergeable_xdp_get_buf()
      virtio_net: optimize mergeable_xdp_get_buf()
      virtio_net: introduce virtnet_xdp_handler() to seprate the logic of run xdp
      virtio_net: separate the logic of freeing xdp shinfo
      virtio_net: separate the logic of freeing the rest mergeable buf
      virtio_net: virtnet_build_xdp_buff_mrg() auto release xdp shinfo
      virtio_net: introduce receive_mergeable_xdp()
      virtio_net: merge: remove skip_xdp
      virtio_net: introduce receive_small_xdp()
      virtio_net: small: remove the delta
      virtio_net: small: avoid code duplication in xdp scenarios
      virtio_net: small: remove skip_xdp
      virtio_net: introduce receive_small_build_xdp
      virtio_net: introduce virtnet_build_skb()

Xueming Feng (1):
      bpftool: Dump map id instead of value for map_of_maps types

Yafang Shao (4):
      bpf: Remove bpf trampoline selector
      bpf: Fix memleak due to fentry attach failure
      bpf: Show target_{obj,btf}_id in tracing link fdinfo
      bpftool: Show target_{obj,btf}_id in tracing link info

Yang Li (3):
      ipvlan: Remove NULL check before dev_{put, hold}
      octeontx2-pf: mcs: Remove unneeded semicolon
      tools: ynl: Remove duplicated include in handshake-user.c

Yedidya Benshimol (5):
      wifi: iwlwifi: mvm: use link ID in missed beacon notification
      wifi: mac80211: mark keys as uploaded when added by the driver
      wifi: iwlwifi: mvm: Refactor security key update after D3
      wifi: iwlwifi: mvm: update two most recent GTKs on D3 resume flow
      wifi: iwlwifi: mvm: Add support for IGTK in D3 resume flow

Yi Kuo (1):
      wifi: iwlwifi: pcie: add device id 51F1 for killer 1675

Ying Hsu (1):
      igb: Fix igb_down hung on surprise removal

Yinjun Zhang (1):
      nfp: improve link modes reading process

Yonghong Song (8):
      selftests/bpf: Fix selftest test_global_funcs/global_func1 failure with latest clang
      bpf: Emit struct bpf_tcp_sock type in vmlinux BTF
      selftests/bpf: Fix s390 sock_field test failure
      selftests/bpf: Fix dynptr/test_dynptr_is_null
      selftests/bpf: Make bpf_dynptr_is_rdonly() prototyype consistent with kernel
      bpf: Silence a warning in btf_type_id_size()
      selftests/bpf: Add a test where map key_type_id with decl_tag type
      selftests/bpf: Fix compilation failure for prog vrf_socket_lookup

Yoshihiro Shimoda (2):
      net: renesas: rswitch: Use napi_gro_receive() in RX
      net: renesas: rswitch: Use hardware pause features

Youghandhar Chintala (1):
      wifi: ath10k: Trigger STA disconnect after reconfig complete on hardware restart

YueHaibing (2):
      net: sched: Remove unused qdisc_l2t()
      xsk: Remove unused inline function xsk_buff_discard()

Yueh-Shun Li (4):
      i40e, xsk: fix comment typo
      tcp: fix comment typo
      net/tls: fix comment typo
      selftests: mptcp: connect: fix comment typo

Yunsheng Lin (3):
      net: introduce and use skb_frag_fill_page_desc()
      net: remove __skb_frag_set_page()
      net: skbuff: update comment about pfmemalloc propagating

Yuya Tajima (1):
      seg6: Cleanup duplicates of skb_dst_drop calls

Zahari Doychev (3):
      net: flow_dissector: add support for cfm packets
      net: flower: add support for matching cfm fields
      selftests: net: add tc flower cfm test

Zhang Shurong (2):
      wifi: rtw88: fix incorrect error codes in rtw_debugfs_copy_from_user
      wifi: rtw88: fix incorrect error codes in rtw_debugfs_set_*

Zhengchao Shao (2):
      selftests/tc-testing: replace mq with invalid parent ID
      net: txgbe: remove unused buffer in txgbe_calc_eeprom_checksum

Ziyang Huang (3):
      wifi: ath11k: Add missing ops config for IPQ5018 in ath11k_ahb_probe()
      wifi: ath11k: Restart firmware after cold boot calibration for IPQ5018
      wifi: ath11k: Add missing hw_ops->get_ring_selector() for IPQ5018

Zong-Zhe Yang (25):
      wifi: rtw89: release bit in rtw89_fw_h2c_del_pkt_offload()
      wifi: rtw89: refine packet offload delete flow of 6 GHz probe
      wifi: rtw89: packet offload wait for FW response
      wifi: rtw89: mac: handle C2H receive/done ACK in interrupt context
      wifi: rtw89: scan offload wait for FW done ACK
      wifi: rtw89: introduce realtek ACPI DSM method
      wifi: rtw89: regd: judge UNII-4 according to BIOS and chip
      wifi: rtw89: support U-NII-4 channels on 5GHz band
      wifi: rtw89: pci: fix interrupt enable mask for HALT C2H of RTL8851B
      wifi: rtw89: ser: L1 add pre-M0 and post-M0 states
      wifi: rtw89: ser: reset total_sta_assoc and tdls_peer when L2
      wifi: rtw89: tweak H2C TX waiting function for SER
      wifi: rtw89: refine packet offload handling under SER
      wifi: rtw89: debug: txpwr table access only valid page according to chip
      wifi: rtw89: set TX power without precondition during setting channel
      wifi: rtw89: 8851b: configure CRASH_TRIGGER feature for 8851B
      wifi: rtw89: refine clearing supported bands to check 2/5 GHz first
      wifi: rtw89: regd: judge 6 GHz according to chip and BIOS
      wifi: rtw89: regd: update regulatory map to R64-R40
      wifi: rtw89: process regulatory for 6 GHz power type
      wifi: rtw89: 8852c: update TX power tables to R63 with 6 GHz power type (1 of 3)
      wifi: rtw89: 8852c: update TX power tables to R63 with 6 GHz power type (2 of 3)
      wifi: rtw89: 8852c: update TX power tables to R63 with 6 GHz power type (3 of 3)
      wifi: rtw89: 8851b: update TX power tables to R28
      wifi: rtw89: TX power stuffs replace confusing naming of _max with _num

mfreemon@cloudflare.com (1):
      tcp: enforce receive buffer memory limits by allowing the tcp window to shrink

renmingshuai (1):
      selftests: tc-testing: add one test for flushing explicitly created chain

wuych (2):
      net: liquidio: lio_vf_main: Remove unnecessary (void*) conversions
      net: liquidio: lio_main: Remove unnecessary (void*) conversions

 .../ABI/testing/sysfs-class-led-trigger-netdev     |    89 +
 Documentation/admin-guide/sysctl/net.rst           |     4 +-
 Documentation/bpf/bpf_iterators.rst                |     7 +-
 Documentation/bpf/cpumasks.rst                     |     5 +-
 Documentation/bpf/instruction-set.rst              |     9 +-
 Documentation/bpf/kfuncs.rst                       |    61 +-
 Documentation/bpf/llvm_reloc.rst                   |    16 +-
 Documentation/bpf/map_hash.rst                     |    53 +-
 Documentation/bpf/map_lru_hash_update.dot          |   172 +
 Documentation/bpf/map_sockmap.rst                  |    10 +-
 Documentation/bpf/prog_cgroup_sockopt.rst          |    57 +-
 .../bindings/net/allwinner,sun7i-a20-gmac.yaml     |     2 +-
 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    |     2 +-
 .../devicetree/bindings/net/altr,tse.yaml          |     4 +-
 .../bindings/net/amlogic,meson-dwmac.yaml          |     2 +-
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |     3 +
 .../devicetree/bindings/net/brcm,bcmgenet.yaml     |     2 +-
 .../devicetree/bindings/net/cdns,macb.yaml         |    11 +
 .../devicetree/bindings/net/dsa/marvell.txt        |     2 +-
 .../devicetree/bindings/net/dsa/nxp,sja1105.yaml   |    32 +-
 .../devicetree/bindings/net/ethernet-phy.yaml      |     6 +
 .../devicetree/bindings/net/intel,dwmac-plat.yaml  |     2 +-
 .../devicetree/bindings/net/maxlinear,gpy2xx.yaml  |    11 +-
 .../devicetree/bindings/net/mediatek-dwmac.yaml    |     2 +-
 .../devicetree/bindings/net/micrel,ks8851.yaml     |     3 +-
 .../devicetree/bindings/net/nxp,dwmac-imx.yaml     |     2 +-
 .../bindings/net/pse-pd/pse-controller.yaml        |     2 +-
 .../devicetree/bindings/net/qcom,ethqos.yaml       |    12 +-
 .../devicetree/bindings/net/rockchip-dwmac.yaml    |     2 +-
 .../devicetree/bindings/net/snps,dwmac.yaml        |     3 +
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml        |     4 +-
 .../bindings/net/toshiba,visconti-dwmac.yaml       |     2 +-
 .../bindings/net/wireless/qcom,ath10k.yaml         |     4 +
 .../devicetree/bindings/net/xilinx_axienet.txt     |   101 -
 .../devicetree/bindings/net/xlnx,axi-ethernet.yaml |   183 +
 Documentation/driver-api/ptp.rst                   |    29 +
 Documentation/filesystems/locking.rst              |     2 -
 Documentation/filesystems/vfs.rst                  |     1 -
 Documentation/leds/leds-class.rst                  |    81 +
 Documentation/netlink/genetlink-c.yaml             |    10 +
 Documentation/netlink/genetlink-legacy.yaml        |    23 +-
 Documentation/netlink/genetlink.yaml               |     6 +
 Documentation/netlink/specs/devlink.yaml           |     8 +
 Documentation/netlink/specs/ethtool.yaml           |   120 +-
 Documentation/netlink/specs/ovs_datapath.yaml      |    30 +-
 Documentation/netlink/specs/ovs_flow.yaml          |   980 +
 Documentation/netlink/specs/ovs_vport.yaml         |    13 +-
 .../device_drivers/ethernet/amazon/ena.rst         |    34 +
 .../device_drivers/ethernet/intel/ice.rst          |    18 -
 .../device_drivers/ethernet/marvell/octeontx2.rst  |    45 +
 .../ethernet/mellanox/mlx5/counters.rst            |    10 +
 .../ethernet/mellanox/mlx5/devlink.rst             |     7 +
 .../ethernet/mellanox/mlx5/switchdev.rst           |    22 +
 Documentation/networking/ip-sysctl.rst             |    32 +-
 Documentation/networking/scaling.rst               |     4 +-
 .../userspace-api/netlink/intro-specs.rst          |    79 +
 MAINTAINERS                                        |    43 +-
 arch/alpha/include/uapi/asm/socket.h               |     3 +
 arch/arm64/net/bpf_jit_comp.c                      |    55 +-
 arch/mips/include/uapi/asm/socket.h                |     3 +
 arch/parisc/include/uapi/asm/socket.h              |     3 +
 arch/sparc/include/uapi/asm/socket.h               |     3 +
 crypto/af_alg.c                                    |   191 +-
 crypto/algif_aead.c                                |    56 +-
 crypto/algif_hash.c                                |   190 +-
 crypto/algif_rng.c                                 |     2 -
 crypto/algif_skcipher.c                            |    24 +-
 drivers/block/drbd/drbd_main.c                     |    12 +-
 drivers/infiniband/hw/mlx5/ib_rep.c                |   107 +-
 drivers/infiniband/sw/siw/siw_qp_tx.c              |    16 +-
 drivers/leds/trigger/ledtrig-netdev.c              |   380 +-
 drivers/net/Kconfig                                |     1 -
 drivers/net/bonding/bond_main.c                    |    17 +-
 drivers/net/bonding/bonding_priv.h                 |     4 +-
 drivers/net/can/Kconfig                            |     3 +-
 drivers/net/can/at91_can.c                         |     6 +-
 drivers/net/can/bxcan.c                            |    17 +-
 drivers/net/can/c_can/c_can_platform.c             |     6 +-
 drivers/net/can/cc770/cc770_isa.c                  |     6 +-
 drivers/net/can/cc770/cc770_platform.c             |     6 +-
 drivers/net/can/ctucanfd/ctucanfd_platform.c       |     6 +-
 drivers/net/can/dev/length.c                       |    15 +-
 drivers/net/can/dev/rx-offload.c                   |     2 +-
 drivers/net/can/flexcan/flexcan-core.c             |     6 +-
 drivers/net/can/grcan.c                            |     6 +-
 drivers/net/can/ifi_canfd/ifi_canfd.c              |     6 +-
 drivers/net/can/janz-ican3.c                       |     6 +-
 drivers/net/can/kvaser_pciefd.c                    |   945 +-
 drivers/net/can/m_can/m_can.c                      |     4 +-
 drivers/net/can/m_can/m_can_platform.c             |     6 +-
 drivers/net/can/mscan/mpc5xxx_can.c                |     6 +-
 drivers/net/can/rcar/rcar_can.c                    |     5 +-
 drivers/net/can/rcar/rcar_canfd.c                  |     6 +-
 drivers/net/can/sja1000/sja1000.c                  |    40 +-
 drivers/net/can/sja1000/sja1000.h                  |     1 +
 drivers/net/can/sja1000/sja1000_isa.c              |     6 +-
 drivers/net/can/sja1000/sja1000_platform.c         |    11 +-
 drivers/net/can/softing/softing_main.c             |     5 +-
 drivers/net/can/sun4i_can.c                        |     6 +-
 drivers/net/can/ti_hecc.c                          |     8 +-
 drivers/net/can/usb/Kconfig                        |    12 +
 drivers/net/can/usb/Makefile                       |     1 +
 drivers/net/can/usb/esd_usb.c                      |   350 +-
 drivers/net/can/usb/f81604.c                       |  1201 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |     2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  |    13 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   |     6 +-
 drivers/net/can/xilinx_can.c                       |    25 +-
 drivers/net/dsa/b53/b53_serdes.c                   |     3 +-
 drivers/net/dsa/hirschmann/hellcreek.c             |    14 +-
 drivers/net/dsa/lan9303-core.c                     |     1 -
 drivers/net/dsa/lan9303_i2c.c                      |     2 +-
 drivers/net/dsa/microchip/ksz8795.c                |    28 +-
 drivers/net/dsa/microchip/ksz8863_smi.c            |    13 +-
 drivers/net/dsa/microchip/ksz9477.c                |   116 +-
 drivers/net/dsa/microchip/ksz9477_i2c.c            |     4 +-
 drivers/net/dsa/microchip/ksz_common.c             |    51 +-
 drivers/net/dsa/microchip/ksz_common.h             |    76 +-
 drivers/net/dsa/microchip/ksz_spi.c                |     2 +-
 drivers/net/dsa/microchip/lan937x_main.c           |     8 +-
 drivers/net/dsa/mt7530.c                           |     3 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   176 +-
 drivers/net/dsa/mv88e6xxx/chip.h                   |    15 +-
 drivers/net/dsa/mv88e6xxx/global2.c                |     5 +-
 drivers/net/dsa/mv88e6xxx/port.c                   |    29 +-
 drivers/net/dsa/mv88e6xxx/port.h                   |    15 +-
 drivers/net/dsa/mv88e6xxx/serdes.c                 |    47 +-
 drivers/net/dsa/mv88e6xxx/serdes.h                 |     4 +
 drivers/net/dsa/ocelot/felix_vsc9959.c             |    25 +-
 drivers/net/dsa/ocelot/seville_vsc9953.c           |    20 +-
 drivers/net/dsa/qca/ar9331.c                       |    16 +-
 drivers/net/dsa/qca/qca8k-8xxx.c                   |    15 +-
 drivers/net/dsa/qca/qca8k-common.c                 |     6 +-
 drivers/net/dsa/qca/qca8k-leds.c                   |   201 +
 drivers/net/dsa/sja1105/sja1105_main.c             |    14 +-
 drivers/net/dsa/sja1105/sja1105_mdio.c             |    11 +-
 drivers/net/dsa/sja1105/sja1105_tas.c              |     7 +-
 drivers/net/dsa/xrs700x/xrs700x_i2c.c              |     2 +-
 drivers/net/ethernet/8390/8390.h                   |     2 +
 drivers/net/ethernet/8390/apne.c                   |     7 +-
 drivers/net/ethernet/8390/axnet_cs.c               |     6 +-
 drivers/net/ethernet/8390/hydra.c                  |     6 +-
 drivers/net/ethernet/8390/lib8390.c                |     5 +-
 drivers/net/ethernet/8390/mac8390.c                |     6 +-
 drivers/net/ethernet/8390/mcf8390.c                |     4 +-
 drivers/net/ethernet/8390/ne.c                     |     4 +-
 drivers/net/ethernet/8390/ne2k-pci.c               |     1 +
 drivers/net/ethernet/8390/pcnet_cs.c               |     5 +-
 drivers/net/ethernet/8390/smc-ultra.c              |     4 +-
 drivers/net/ethernet/8390/stnic.c                  |     5 +-
 drivers/net/ethernet/8390/wd.c                     |     4 +-
 drivers/net/ethernet/8390/zorro8390.c              |     7 +-
 drivers/net/ethernet/altera/Kconfig                |     4 +-
 drivers/net/ethernet/altera/altera_tse_main.c      |    65 +-
 drivers/net/ethernet/amazon/ena/ena_admin_defs.h   |     6 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   136 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.h       |     4 +
 drivers/net/ethernet/amd/pds_core/core.c           |     4 +-
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c        |    13 +-
 drivers/net/ethernet/aquantia/atlantic/aq_macsec.c |    40 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |     6 +-
 drivers/net/ethernet/arc/emac.h                    |     2 +-
 drivers/net/ethernet/arc/emac_arc.c                |     6 +-
 drivers/net/ethernet/arc/emac_main.c               |     4 +-
 drivers/net/ethernet/arc/emac_rockchip.c           |     5 +-
 drivers/net/ethernet/broadcom/bnx2.c               |     1 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |    10 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c      |     1 +
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |    14 +
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |     2 +
 drivers/net/ethernet/broadcom/tg3.c                |     1 +
 drivers/net/ethernet/cadence/macb.h                |    13 +
 drivers/net/ethernet/cadence/macb_main.c           |    47 +-
 drivers/net/ethernet/cavium/Kconfig                |     5 +
 drivers/net/ethernet/cavium/liquidio/Makefile      |     8 +-
 .../ethernet/cavium/liquidio/cn23xx_pf_device.c    |     8 +-
 .../ethernet/cavium/liquidio/cn23xx_vf_device.c    |     7 +-
 .../net/ethernet/cavium/liquidio/cn66xx_device.c   |     1 +
 .../net/ethernet/cavium/liquidio/cn68xx_device.c   |     1 +
 drivers/net/ethernet/cavium/liquidio/lio_core.c    |    16 +
 drivers/net/ethernet/cavium/liquidio/lio_ethtool.c |     1 +
 drivers/net/ethernet/cavium/liquidio/lio_main.c    |    18 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c |    15 +-
 .../net/ethernet/cavium/liquidio/octeon_device.c   |    24 +
 drivers/net/ethernet/cavium/liquidio/octeon_droq.c |     4 +
 .../net/ethernet/cavium/liquidio/octeon_mem_ops.c  |     5 +
 drivers/net/ethernet/cavium/liquidio/octeon_nic.c  |     3 +
 .../net/ethernet/cavium/liquidio/request_manager.c |    14 +
 .../ethernet/cavium/liquidio/response_manager.c    |     3 +
 drivers/net/ethernet/chelsio/cxgb3/sge.c           |     5 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |     2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h     |     5 -
 drivers/net/ethernet/chelsio/cxgb4/sge.c           |     2 +-
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c      |     2 +-
 .../ethernet/chelsio/inline_crypto/chtls/chtls.h   |     3 +-
 .../chelsio/inline_crypto/chtls/chtls_io.c         |   118 +-
 .../chelsio/inline_crypto/chtls/chtls_main.c       |     2 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |    32 +-
 drivers/net/ethernet/engleder/tsnep_selftests.c    |    12 +-
 drivers/net/ethernet/engleder/tsnep_tc.c           |     4 +-
 drivers/net/ethernet/freescale/Kconfig             |     2 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c   |    33 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       |    12 +-
 drivers/net/ethernet/freescale/enetc/enetc.h       |     1 +
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |    22 +-
 drivers/net/ethernet/freescale/enetc/enetc_qos.c   |   115 +-
 drivers/net/ethernet/freescale/fec_main.c          |    40 +-
 drivers/net/ethernet/freescale/fman/fman_dtsec.c   |     7 +-
 drivers/net/ethernet/freescale/fman/fman_memac.c   |    18 +-
 drivers/net/ethernet/freescale/fs_enet/mii-fec.c   |     2 +-
 drivers/net/ethernet/fungible/funeth/funeth_rx.c   |     5 +-
 drivers/net/ethernet/fungible/funeth/funeth_tx.c   |     3 +-
 drivers/net/ethernet/google/gve/gve_main.c         |     5 +
 drivers/net/ethernet/google/gve/gve_tx.c           |     2 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       |     4 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |     3 +-
 .../hisilicon/hns3/hns3_common/hclge_comm_rss.c    |     3 +-
 .../hisilicon/hns3/hns3_common/hclge_comm_rss.h    |     3 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |    38 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |     2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |     7 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |    29 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |    47 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |    11 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |    14 +-
 drivers/net/ethernet/i825xx/82596.c                |     5 +-
 drivers/net/ethernet/i825xx/lasi_82596.c           |     5 +-
 drivers/net/ethernet/i825xx/lib82596.c             |     5 +-
 drivers/net/ethernet/i825xx/sun3_82586.c           |     1 +
 drivers/net/ethernet/i825xx/sun3_82586.h           |     1 +
 drivers/net/ethernet/intel/e1000e/netdev.c         |     2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |     6 -
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |     2 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |    10 -
 drivers/net/ethernet/intel/iavf/iavf_alloc.h       |     3 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c      |    45 -
 drivers/net/ethernet/intel/iavf/iavf_main.c        |    78 +-
 drivers/net/ethernet/intel/iavf/iavf_osdep.h       |     9 -
 drivers/net/ethernet/intel/iavf/iavf_prototype.h   |     5 -
 drivers/net/ethernet/intel/iavf/iavf_txrx.c        |    43 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.h        |     4 -
 drivers/net/ethernet/intel/ice/Makefile            |     1 +
 drivers/net/ethernet/intel/ice/ice.h               |    51 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |     2 +-
 drivers/net/ethernet/intel/ice/ice_arfs.c          |     5 +-
 drivers/net/ethernet/intel/ice/ice_base.c          |    50 +-
 drivers/net/ethernet/intel/ice/ice_common.c        |    10 +-
 drivers/net/ethernet/intel/ice/ice_controlq.c      |    12 +-
 drivers/net/ethernet/intel/ice/ice_controlq.h      |     1 -
 drivers/net/ethernet/intel/ice/ice_devlink.c       |    10 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c       |    84 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.h       |    14 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |   311 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.h       |   105 +
 drivers/net/ethernet/intel/ice/ice_flow.c          |    23 +-
 drivers/net/ethernet/intel/ice/ice_idc.c           |    52 +-
 drivers/net/ethernet/intel/ice/ice_irq.c           |   378 +
 drivers/net/ethernet/intel/ice/ice_irq.h           |    25 +
 drivers/net/ethernet/intel/ice/ice_lag.c           |    12 -
 drivers/net/ethernet/intel/ice/ice_lag.h           |    54 -
 drivers/net/ethernet/intel/ice/ice_lib.c           |   332 +-
 drivers/net/ethernet/intel/ice/ice_lib.h           |     5 -
 drivers/net/ethernet/intel/ice/ice_main.c          |   355 +-
 drivers/net/ethernet/intel/ice/ice_protocol_type.h |   197 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |    64 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h           |    16 +-
 drivers/net/ethernet/intel/ice/ice_repr.c          |    17 -
 drivers/net/ethernet/intel/ice/ice_repr.h          |     5 +-
 drivers/net/ethernet/intel/ice/ice_sched.c         |    11 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c         |    52 +-
 drivers/net/ethernet/intel/ice/ice_switch.c        |   251 +-
 drivers/net/ethernet/intel/ice/ice_switch.h        |    13 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c        |    34 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.h        |     1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |    35 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h        |     7 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |     8 -
 drivers/net/ethernet/intel/ice/ice_vlan_mode.c     |     2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c           |     5 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |     7 +
 drivers/net/ethernet/intel/igc/igc.h               |    43 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   151 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c           |   142 +-
 drivers/net/ethernet/litex/litex_liteeth.c         |    19 +-
 drivers/net/ethernet/marvell/mvneta.c              |   178 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |    14 +-
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c  |     2 +-
 drivers/net/ethernet/marvell/octeontx2/Kconfig     |     1 +
 drivers/net/ethernet/marvell/octeontx2/af/common.h |     9 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |    11 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |    20 +
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |     5 +
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |    74 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   292 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_reg.h    |     3 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_switch.c |    18 +
 .../net/ethernet/marvell/octeontx2/nic/Makefile    |     2 +-
 .../ethernet/marvell/octeontx2/nic/cn10k_macsec.c  |   135 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   215 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |    93 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |    29 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   125 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_reg.h  |    13 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |    43 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |    43 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.h |     4 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |    14 +-
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c   |  1363 +
 drivers/net/ethernet/marvell/octeontx2/nic/qos.h   |    69 +
 .../net/ethernet/marvell/octeontx2/nic/qos_sq.c    |   296 +
 .../ethernet/marvell/prestera/prestera_flower.c    |     6 +
 .../net/ethernet/marvell/prestera/prestera_main.c  |    11 +-
 drivers/net/ethernet/mellanox/mlx4/main.c          |    65 +-
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |     3 +-
 drivers/net/ethernet/mellanox/mlx5/core/debugfs.c  |     1 +
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |    22 +-
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |    87 +-
 .../mellanox/mlx5/core/diag/reporter_vnic.c        |    10 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |    17 -
 .../ethernet/mellanox/mlx5/core/en/port_buffer.c   |    44 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c   |     7 +-
 .../ethernet/mellanox/mlx5/core/en/rep/bridge.c    |     9 +-
 .../ethernet/mellanox/mlx5/core/en/tc/act_stats.c  |     9 +-
 .../ethernet/mellanox/mlx5/core/en/tc/post_act.c   |     4 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc_priv.h   |     4 +-
 .../mellanox/mlx5/core/en_accel/en_accel.h         |     2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c |     2 +-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.h        |     5 -
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c  |     9 -
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  |     8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |    26 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |    18 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c    |    12 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |     5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   137 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.h   |     7 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |     4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |    25 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   193 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c  |     2 +-
 .../mellanox/mlx5/core/esw/acl/egress_ofld.c       |    25 +-
 .../ethernet/mellanox/mlx5/core/esw/acl/helper.c   |     3 +-
 .../net/ethernet/mellanox/mlx5/core/esw/acl/ofld.h |     1 +
 .../net/ethernet/mellanox/mlx5/core/esw/bridge.c   |    69 +-
 .../net/ethernet/mellanox/mlx5/core/esw/bridge.h   |    12 +-
 .../mellanox/mlx5/core/esw/bridge_debugfs.c        |    89 +
 .../ethernet/mellanox/mlx5/core/esw/bridge_mcast.c |    21 +-
 .../ethernet/mellanox/mlx5/core/esw/bridge_priv.h  |     6 +
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |    37 +-
 .../net/ethernet/mellanox/mlx5/core/esw/legacy.c   |     6 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   201 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |    80 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   451 +-
 drivers/net/ethernet/mellanox/mlx5/core/events.c   |     2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |    27 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h   |     3 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |     5 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |     3 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c       |     5 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |   160 +-
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |    25 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |   139 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  |    11 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c   |     6 +-
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    |     6 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |    31 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   |   143 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |    37 +-
 .../net/ethernet/mellanox/mlx5/core/lib/events.h   |    40 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h |    34 -
 drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c |     2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/tout.c |     7 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/tout.h |     1 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   242 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |    42 +-
 .../net/ethernet/mellanox/mlx5/core/pagealloc.c    |    11 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |    16 +-
 drivers/net/ethernet/mellanox/mlx5/core/rdma.c     |    24 +-
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c    |    15 +-
 .../net/ethernet/mellanox/mlx5/core/sf/devlink.c   |    14 +-
 drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h    |     5 +-
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c    |    50 +-
 .../mellanox/mlx5/core/steering/dr_action.c        |     5 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_cmd.c  |     4 +-
 .../mellanox/mlx5/core/steering/dr_domain.c        |    13 +-
 .../mellanox/mlx5/core/steering/dr_ste_v0.c        |     9 +-
 .../mellanox/mlx5/core/steering/dr_ste_v1.c        |     9 +-
 .../mellanox/mlx5/core/steering/dr_types.h         |     2 +-
 .../ethernet/mellanox/mlx5/core/steering/fs_dr.c   |     5 +-
 .../ethernet/mellanox/mlx5/core/steering/mlx5dr.h  |     3 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |    16 +-
 .../ethernet/mellanox/mlxfw/mlxfw_mfa2_format.h    |     2 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c         |    10 +-
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.c   |     1 +
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.h   |     3 +-
 drivers/net/ethernet/mellanox/mlxsw/i2c.c          |     2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |    22 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |     8 -
 .../mellanox/mlxsw/spectrum_acl_flex_keys.c        |     2 +
 .../net/ethernet/mellanox/mlxsw/spectrum_dpipe.c   |     2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_flower.c  |    45 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c  |    19 +-
 .../ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c   |     6 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |   844 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.h  |    12 +-
 drivers/net/ethernet/microchip/enc28j60.c          |    28 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |    22 +-
 drivers/net/ethernet/microchip/lan966x/Kconfig     |    11 +
 drivers/net/ethernet/microchip/lan966x/Makefile    |     1 +
 .../net/ethernet/microchip/lan966x/lan966x_dcb.c   |   365 +
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |     3 +
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |    60 +
 .../ethernet/microchip/lan966x/lan966x_phylink.c   |     7 +-
 .../net/ethernet/microchip/lan966x/lan966x_port.c  |   149 +
 .../net/ethernet/microchip/lan966x/lan966x_regs.h  |   147 +
 .../net/ethernet/microchip/lan966x/lan966x_tc.c    |    10 +-
 .../ethernet/microchip/lan966x/lan966x_tc_flower.c |    61 +
 .../microchip/lan966x/lan966x_vcap_ag_api.c        |   264 +-
 .../microchip/lan966x/lan966x_vcap_debugfs.c       |    23 +
 .../ethernet/microchip/lan966x/lan966x_vcap_impl.c |    82 +
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |     1 +
 .../net/ethernet/microchip/sparx5/sparx5_phylink.c |     8 +-
 drivers/net/ethernet/microchip/vcap/vcap_ag_api.h  |    67 +-
 drivers/net/ethernet/microchip/vcap/vcap_api.c     |     8 +-
 drivers/net/ethernet/microsoft/mana/hw_channel.c   |     2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |    19 +-
 drivers/net/ethernet/mscc/ocelot_flower.c          |    10 +
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c   |     1 +
 drivers/net/ethernet/netronome/nfp/nfp_devlink.c   |    10 +-
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |     6 +-
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   |    32 +-
 .../net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h   |     7 +-
 .../ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c   |    54 +-
 drivers/net/ethernet/oki-semi/pch_gbe/Kconfig      |     2 +-
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |    10 +
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |     5 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.h    |     1 +
 drivers/net/ethernet/realtek/r8169_main.c          |    41 +-
 drivers/net/ethernet/renesas/rswitch.c             |    38 +-
 drivers/net/ethernet/renesas/rswitch.h             |     7 +
 drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h  |     2 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c    |     4 +-
 .../net/ethernet/samsung/sxgbe/sxgbe_platform.c    |     5 +-
 drivers/net/ethernet/sfc/Kconfig                   |     1 +
 drivers/net/ethernet/sfc/Makefile                  |     3 +-
 drivers/net/ethernet/sfc/ef10.c                    |    13 +-
 drivers/net/ethernet/sfc/ef100_netdev.c            |    87 +-
 drivers/net/ethernet/sfc/efx.c                     |     9 +
 drivers/net/ethernet/sfc/efx_devlink.c             |    80 +-
 drivers/net/ethernet/sfc/falcon/selftest.c         |    47 +-
 drivers/net/ethernet/sfc/mae.c                     |   141 +-
 drivers/net/ethernet/sfc/mae.h                     |     9 +
 drivers/net/ethernet/sfc/net_driver.h              |     3 +
 drivers/net/ethernet/sfc/selftest.c                |    47 +-
 drivers/net/ethernet/sfc/siena/selftest.c          |    47 +-
 drivers/net/ethernet/sfc/siena/tx_common.c         |     1 +
 drivers/net/ethernet/sfc/tc.c                      |   407 +-
 drivers/net/ethernet/sfc/tc.h                      |    51 +
 drivers/net/ethernet/sfc/tc_bindings.c             |    13 +
 drivers/net/ethernet/sfc/tc_bindings.h             |    14 +
 drivers/net/ethernet/sfc/tc_counters.c             |    58 +
 drivers/net/ethernet/sfc/tc_counters.h             |     3 +
 drivers/net/ethernet/sfc/tc_encap_actions.c        |   747 +
 drivers/net/ethernet/sfc/tc_encap_actions.h        |   114 +
 drivers/net/ethernet/sfc/tx_common.c               |     1 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |     3 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |     2 +-
 drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c |   257 -
 drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.h |    29 -
 drivers/net/ethernet/stmicro/stmmac/common.h       |     1 +
 .../net/ethernet/stmicro/stmmac/dwmac-anarion.c    |     2 +-
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |     6 +-
 .../net/ethernet/stmicro/stmmac/dwmac-generic.c    |    16 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |     2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ingenic.c    |     2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-intel-plat.c |     9 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ipq806x.c    |     2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c    |     2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |     9 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c  |     2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    |     2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-oxnas.c  |     2 +-
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |   297 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |     6 +-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   108 +-
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   |     2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    |     6 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |     6 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |     6 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c  |     2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c  |     6 +-
 .../net/ethernet/stmicro/stmmac/dwmac-visconti.c   |    19 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |     2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |    20 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |    15 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   170 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.h  |    16 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |     7 +-
 drivers/net/ethernet/sun/cassini.c                 |     8 +-
 drivers/net/ethernet/sun/sunvnet_common.c          |     1 +
 drivers/net/ethernet/ti/am65-cpsw-qos.c            |    11 +-
 drivers/net/ethernet/wangxun/Kconfig               |    10 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |   272 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h         |     3 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |   737 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h        |     1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |   218 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c      |    20 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h      |     1 +
 drivers/net/ethernet/wangxun/txgbe/Makefile        |     1 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c |    28 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c      |    32 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |    96 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |   673 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h     |    10 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h    |    90 +
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |    16 +-
 drivers/net/gtp.c                                  |     2 +
 drivers/net/hyperv/hyperv_net.h                    |     5 +-
 drivers/net/hyperv/netvsc_drv.c                    |    10 +-
 drivers/net/hyperv/rndis_filter.c                  |    29 +-
 drivers/net/ieee802154/ca8210.c                    |     4 +-
 drivers/net/ipvlan/ipvlan_core.c                   |    12 +-
 drivers/net/mctp/mctp-i2c.c                        |     2 +-
 drivers/net/mdio/Kconfig                           |    11 +
 drivers/net/mdio/Makefile                          |     1 +
 drivers/net/mdio/mdio-mux-mmioreg.c                |     7 +-
 drivers/net/mdio/mdio-regmap.c                     |    93 +
 drivers/net/pcs/Kconfig                            |     6 -
 drivers/net/pcs/Makefile                           |     1 -
 drivers/net/pcs/pcs-altera-tse.c                   |   160 -
 drivers/net/pcs/pcs-lynx.c                         |   123 +-
 drivers/net/pcs/pcs-mtk-lynxi.c                    |    43 +-
 drivers/net/pcs/pcs-xpcs.c                         |   265 +-
 drivers/net/pcs/pcs-xpcs.h                         |     3 -
 drivers/net/phy/Kconfig                            |    17 +-
 drivers/net/phy/Makefile                           |     1 +
 drivers/net/phy/at803x.c                           |    44 +-
 drivers/net/phy/bcm-phy-lib.c                      |   264 +-
 drivers/net/phy/bcm-phy-lib.h                      |    10 +
 drivers/net/phy/broadcom.c                         |   177 +-
 drivers/net/phy/dp83869.c                          |    13 +-
 drivers/net/phy/dp83td510.c                        |    23 +-
 drivers/net/phy/mediatek-ge-soc.c                  |  1116 +
 drivers/net/phy/mediatek-ge.c                      |     3 +-
 drivers/net/phy/micrel.c                           |   331 +-
 drivers/net/phy/microchip_t1s.c                    |   278 +-
 drivers/net/phy/mscc/mscc.h                        |     1 +
 drivers/net/phy/mscc/mscc_main.c                   |    51 +-
 drivers/net/phy/phy-c45.c                          |     9 +-
 drivers/net/phy/phy.c                              |    11 +-
 drivers/net/phy/phy_device.c                       |    21 +-
 drivers/net/phy/phylink.c                          |   209 +-
 drivers/net/phy/realtek.c                          |    34 +-
 drivers/net/phy/sfp-bus.c                          |    20 +
 drivers/net/phy/sfp.c                              |   345 +-
 drivers/net/phy/sfp.h                              |     1 +
 drivers/net/ppp/Kconfig                            |    34 +
 drivers/net/ppp/pppoe.c                            |     2 +-
 drivers/net/tap.c                                  |     1 +
 drivers/net/usb/Kconfig                            |    10 +-
 drivers/net/usb/ipheth.c                           |   188 +-
 drivers/net/usb/qmi_wwan.c                         |     1 +
 drivers/net/usb/r8152.c                            |     1 +
 drivers/net/veth.c                                 |    26 +-
 drivers/net/virtio_net.c                           |   667 +-
 drivers/net/vmxnet3/vmxnet3_drv.c                  |     4 +-
 drivers/net/vxlan/vxlan_core.c                     |    21 +-
 drivers/net/wireguard/device.c                     |     1 +
 drivers/net/wireless/ath/ath10k/ahb.c              |    20 +-
 drivers/net/wireless/ath/ath10k/core.c             |    12 +-
 drivers/net/wireless/ath/ath10k/core.h             |     3 +
 drivers/net/wireless/ath/ath10k/debug.c            |     4 +-
 drivers/net/wireless/ath/ath10k/htt.h              |     6 +-
 drivers/net/wireless/ath/ath10k/mac.c              |    13 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |     8 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |    34 +-
 drivers/net/wireless/ath/ath10k/wmi.h              |     2 -
 drivers/net/wireless/ath/ath11k/ahb.c              |     8 +-
 drivers/net/wireless/ath/ath11k/ce.c               |     4 +-
 drivers/net/wireless/ath/ath11k/core.c             |    89 +-
 drivers/net/wireless/ath/ath11k/core.h             |    16 +-
 drivers/net/wireless/ath/ath11k/debug.c            |     2 +-
 drivers/net/wireless/ath/ath11k/debug.h            |    49 +-
 .../net/wireless/ath/ath11k/debugfs_htt_stats.c    |   114 +
 .../net/wireless/ath/ath11k/debugfs_htt_stats.h    |    43 +
 drivers/net/wireless/ath/ath11k/dp_rx.c            |     8 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c            |    12 +-
 drivers/net/wireless/ath/ath11k/hal.c              |    10 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c           |    24 +-
 drivers/net/wireless/ath/ath11k/htc.c              |    42 +-
 drivers/net/wireless/ath/ath11k/hw.c               |     5 +-
 drivers/net/wireless/ath/ath11k/hw.h               |     1 +
 drivers/net/wireless/ath/ath11k/mac.c              |   541 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |     6 +-
 drivers/net/wireless/ath/ath11k/pci.c              |    25 +-
 drivers/net/wireless/ath/ath11k/pcic.c             |     6 +-
 drivers/net/wireless/ath/ath11k/peer.c             |     4 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |    73 +-
 drivers/net/wireless/ath/ath11k/reg.c              |     4 +-
 drivers/net/wireless/ath/ath11k/testmode.c         |   389 +-
 drivers/net/wireless/ath/ath11k/testmode.h         |     6 +-
 drivers/net/wireless/ath/ath11k/testmode_i.h       |    18 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |   628 +-
 drivers/net/wireless/ath/ath11k/wmi.h              |    70 +-
 drivers/net/wireless/ath/ath11k/wow.c              |     3 +-
 drivers/net/wireless/ath/ath12k/core.c             |     2 +
 drivers/net/wireless/ath/ath12k/core.h             |     1 +
 drivers/net/wireless/ath/ath12k/dp_rx.c            |    27 +-
 drivers/net/wireless/ath/ath12k/hal.c              |    16 +-
 drivers/net/wireless/ath/ath12k/hal.h              |     2 +-
 drivers/net/wireless/ath/ath12k/hw.c               |     6 +
 drivers/net/wireless/ath/ath12k/hw.h               |     2 +
 drivers/net/wireless/ath/ath12k/mac.c              |    51 +-
 drivers/net/wireless/ath/ath12k/pci.c              |    14 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |     6 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |     1 +
 drivers/net/wireless/ath/ath12k/wmi.c              |   105 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |    10 +-
 drivers/net/wireless/ath/ath9k/ar9003_hw.c         |    27 +-
 drivers/net/wireless/ath/ath9k/htc_hst.c           |     8 +-
 drivers/net/wireless/ath/ath9k/main.c              |    11 +-
 drivers/net/wireless/ath/ath9k/wmi.c               |     4 +
 drivers/net/wireless/ath/wil6210/fw.h              |     4 +-
 drivers/net/wireless/ath/wil6210/wmi.h             |     2 +-
 drivers/net/wireless/atmel/Kconfig                 |     2 +-
 drivers/net/wireless/atmel/atmel_cs.c              |    13 +-
 .../wireless/broadcom/brcm80211/brcmfmac/chip.c    |     6 +
 .../broadcom/brcm80211/brcmfmac/tracepoint.h       |     7 +
 .../broadcom/brcm80211/brcmfmac/wcc/core.c         |     4 +-
 .../brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h  |     8 +
 .../wireless/broadcom/brcm80211/brcmutil/utils.c   |     4 +-
 drivers/net/wireless/intel/iwlwifi/Makefile        |     1 +
 drivers/net/wireless/intel/iwlwifi/cfg/1000.c      |    10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c      |    18 +-
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c     |   832 +-
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c      |    10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c      |    18 +-
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c      |    22 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c      |    10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c      |    10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |   301 +
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   183 +
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   166 +
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c        |    43 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |   121 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |    41 +-
 .../net/wireless/intel/iwlwifi/fw/api/binding.h    |    14 +-
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |    23 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/config.h |    15 +-
 .../net/wireless/intel/iwlwifi/fw/api/context.h    |    13 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |     6 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |     6 +-
 .../net/wireless/intel/iwlwifi/fw/api/location.h   |    16 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |    65 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h    |    24 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |    46 +-
 .../net/wireless/intel/iwlwifi/fw/api/offload.h    |     3 +-
 .../net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h   |     6 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/phy.h    |    10 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |     2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h     |     2 +
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |     6 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h   |    41 +-
 .../net/wireless/intel/iwlwifi/fw/api/time-event.h |     7 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |    13 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |    76 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |    18 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |    33 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |    15 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |     6 +
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c       |   254 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h       |    27 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |     6 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |   284 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |    47 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |    69 +-
 .../wireless/intel/iwlwifi/iwl-context-info-gen3.h |    32 +-
 .../net/wireless/intel/iwlwifi/iwl-context-info.h  |     5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |    58 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |    75 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h       |     6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c        |     4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   153 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |     4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |     6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   108 +-
 drivers/net/wireless/intel/iwlwifi/mei/main.c      |     5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/binding.c   |    10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |     6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   420 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   |     6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   202 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |    48 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-responder.c |    23 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |    97 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |    37 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   124 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   200 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c   |    99 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c   |    26 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |   177 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |    28 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   105 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |    65 +-
 .../net/wireless/intel/iwlwifi/mvm/offloading.c    |     4 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |    16 +-
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |    15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |    56 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c     |    77 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |    11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |    10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |    46 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |   163 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sf.c        |     5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |    92 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |    20 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |     4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   150 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |    26 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |   279 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info.c    |     8 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   517 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |    12 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |    31 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |    13 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |    67 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |     5 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c      |    12 +-
 drivers/net/wireless/intersil/hostap/Kconfig       |     2 +-
 .../net/wireless/intersil/hostap/hostap_ioctl.c    |     2 +-
 drivers/net/wireless/intersil/orinoco/orinoco_cs.c |    13 +-
 .../net/wireless/intersil/orinoco/spectrum_cs.c    |    13 +-
 drivers/net/wireless/intersil/p54/p54spi.c         |     1 +
 drivers/net/wireless/legacy/ray_cs.c               |    33 +-
 drivers/net/wireless/legacy/wl3501_cs.c            |    16 +-
 drivers/net/wireless/marvell/mwifiex/11n.h         |     4 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |     8 +-
 drivers/net/wireless/marvell/mwifiex/scan.c        |     6 +-
 drivers/net/wireless/marvell/mwifiex/wmm.h         |    15 -
 drivers/net/wireless/mediatek/mt7601u/debugfs.c    |     2 -
 drivers/net/wireless/mediatek/mt7601u/trace.h      |     2 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |     8 +-
 drivers/net/wireless/microchip/wilc1000/hif.h      |     2 -
 drivers/net/wireless/microchip/wilc1000/wlan_cfg.h |     2 +-
 drivers/net/wireless/microchip/wilc1000/wlan_if.h  |     2 +
 drivers/net/wireless/ralink/rt2x00/rt2x00link.c    |     2 +-
 drivers/net/wireless/realtek/rtl8xxxu/Kconfig      |     3 +-
 drivers/net/wireless/realtek/rtl8xxxu/Makefile     |     2 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |    84 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c |     3 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c |    25 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c |    28 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c |  2090 ++
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c |    37 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c |     5 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |   573 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h  |    52 +-
 drivers/net/wireless/realtek/rtlwifi/base.c        |    20 +-
 drivers/net/wireless/realtek/rtlwifi/base.h        |     1 -
 drivers/net/wireless/realtek/rtlwifi/core.c        |    10 +
 drivers/net/wireless/realtek/rtlwifi/core.h        |     2 +
 drivers/net/wireless/realtek/rtlwifi/pci.c         |     7 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/hw.c    |     8 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/led.c   |    40 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/led.h   |     5 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/sw.c    |     1 -
 .../net/wireless/realtek/rtlwifi/rtl8188ee/trx.c   |     2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/hw.c    |     8 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/led.c   |    41 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/led.h   |     5 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/sw.c    |     1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ce/trx.c   |     2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/led.c   |    56 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/led.h   |     6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/sw.c    |     2 -
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.c   |     4 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/hw.c    |     8 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/led.c   |    42 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/led.h   |     5 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/sw.c    |     1 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/trx.c   |     2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/hw.c    |     8 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/led.c   |    40 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/led.h   |     5 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/sw.c    |     1 -
 .../net/wireless/realtek/rtlwifi/rtl8192se/hw.c    |    16 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/led.c   |    42 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/led.h   |     5 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/sw.c    |     1 -
 .../net/wireless/realtek/rtlwifi/rtl8723ae/hw.c    |     8 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/led.c   |    42 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/led.h   |     5 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/sw.c    |     1 -
 .../net/wireless/realtek/rtlwifi/rtl8723ae/trx.c   |     2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/hw.c    |     8 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/led.c   |    42 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/led.h   |     5 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/sw.c    |     1 -
 .../net/wireless/realtek/rtlwifi/rtl8821ae/hw.c    |    14 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/led.c   |    60 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/led.h   |     9 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/sw.c    |     1 -
 drivers/net/wireless/realtek/rtlwifi/usb.c         |    42 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |    29 +-
 drivers/net/wireless/realtek/rtw88/Kconfig         |    11 +
 drivers/net/wireless/realtek/rtw88/Makefile        |     3 +
 drivers/net/wireless/realtek/rtw88/debug.c         |    59 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |    68 +
 drivers/net/wireless/realtek/rtw88/fw.h            |    13 +
 drivers/net/wireless/realtek/rtw88/mac.c           |     6 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    13 +-
 drivers/net/wireless/realtek/rtw88/main.c          |    15 +-
 drivers/net/wireless/realtek/rtw88/main.h          |     1 +
 drivers/net/wireless/realtek/rtw88/pci.c           |     5 +-
 drivers/net/wireless/realtek/rtw88/ps.c            |     3 +-
 drivers/net/wireless/realtek/rtw88/reg.h           |     2 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |    15 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.h      |     6 +
 drivers/net/wireless/realtek/rtw88/rtw8723ds.c     |    41 +
 drivers/net/wireless/realtek/rtw88/sdio.c          |    24 +-
 drivers/net/wireless/realtek/rtw88/tx.c            |    92 +-
 drivers/net/wireless/realtek/rtw88/tx.h            |   124 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |    17 +-
 drivers/net/wireless/realtek/rtw89/Kconfig         |    14 +
 drivers/net/wireless/realtek/rtw89/Makefile        |    12 +-
 drivers/net/wireless/realtek/rtw89/acpi.c          |    52 +
 drivers/net/wireless/realtek/rtw89/acpi.h          |    21 +
 drivers/net/wireless/realtek/rtw89/coex.c          |     9 +-
 drivers/net/wireless/realtek/rtw89/core.c          |   261 +-
 drivers/net/wireless/realtek/rtw89/core.h          |   217 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |    60 +-
 drivers/net/wireless/realtek/rtw89/efuse.c         |    21 +
 drivers/net/wireless/realtek/rtw89/efuse.h         |     1 +
 drivers/net/wireless/realtek/rtw89/fw.c            |   173 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |   277 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |   158 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |     5 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |    16 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |    25 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |     1 +
 drivers/net/wireless/realtek/rtw89/phy.c           |   344 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |    12 +
 drivers/net/wireless/realtek/rtw89/reg.h           |   134 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |   324 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |  2442 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.h      |    76 +
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  |  3621 +++
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h  |    28 +
 .../net/wireless/realtek/rtw89/rtw8851b_table.c    |   252 +-
 .../net/wireless/realtek/rtw89/rtw8851b_table.h    |     2 +-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    86 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    15 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c  |    36 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.h  |     1 -
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |     8 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |     8 +-
 .../net/wireless/realtek/rtw89/rtw8852b_table.c    |     2 +-
 .../net/wireless/realtek/rtw89/rtw8852b_table.h    |     2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |     8 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |    11 +-
 .../net/wireless/realtek/rtw89/rtw8852c_table.c    | 28040 ++++++++++++++++---
 .../net/wireless/realtek/rtw89/rtw8852c_table.h    |     2 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |    48 +-
 drivers/net/wireless/realtek/rtw89/txrx.h          |   170 +-
 drivers/net/wireless/realtek/rtw89/wow.c           |     2 +-
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |     9 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |    23 +-
 drivers/net/wwan/iosm/iosm_ipc_imem.c              |    17 +
 drivers/net/wwan/iosm/iosm_ipc_imem.h              |    15 +-
 drivers/net/wwan/iosm/iosm_ipc_mux.h               |     4 -
 drivers/net/wwan/iosm/iosm_ipc_pcie.c              |     4 +-
 drivers/net/wwan/iosm/iosm_ipc_port.c              |    17 +-
 drivers/net/wwan/iosm/iosm_ipc_trace.c             |     8 +
 drivers/net/wwan/iosm/iosm_ipc_wwan.c              |    23 +-
 drivers/net/xen-netback/netback.c                  |     4 +-
 drivers/nfc/fdp/i2c.c                              |     2 +-
 drivers/nfc/microread/i2c.c                        |     2 +-
 drivers/nfc/nfcmrvl/i2c.c                          |     2 +-
 drivers/nfc/nxp-nci/i2c.c                          |     4 +-
 drivers/nfc/pn533/i2c.c                            |     2 +-
 drivers/nfc/pn544/i2c.c                            |     2 +-
 drivers/nfc/s3fwrn5/i2c.c                          |     2 +-
 drivers/nfc/st-nci/i2c.c                           |     2 +-
 drivers/nfc/st21nfca/i2c.c                         |     2 +-
 drivers/nvme/host/tcp.c                            |    49 +-
 drivers/nvme/target/tcp.c                          |    46 +-
 drivers/ptp/Kconfig                                |     2 +-
 drivers/ptp/ptp_chardev.c                          |     5 +-
 drivers/ptp/ptp_clock.c                            |     4 +
 drivers/ptp/ptp_clockmatrix.c                      |    36 +-
 drivers/ptp/ptp_clockmatrix.h                      |     2 +-
 drivers/ptp/ptp_idt82p33.c                         |    18 +-
 drivers/ptp/ptp_idt82p33.h                         |     4 +-
 drivers/ptp/ptp_ocp.c                              |     7 +
 drivers/ptp/ptp_sysfs.c                            |    12 +
 drivers/s390/net/ctcm_dbug.c                       |     2 +-
 drivers/s390/net/ctcm_main.c                       |     6 +-
 drivers/s390/net/ctcm_main.h                       |     1 +
 drivers/s390/net/ctcm_mpc.c                        |    18 +-
 drivers/s390/net/ctcm_sysfs.c                      |    46 +-
 drivers/s390/net/ism_drv.c                         |     2 +-
 drivers/s390/net/lcs.c                             |    13 +-
 drivers/s390/net/lcs.h                             |     2 +-
 drivers/scsi/iscsi_tcp.c                           |    26 +-
 drivers/scsi/iscsi_tcp.h                           |     2 -
 drivers/target/iscsi/iscsi_target_util.c           |    15 +-
 fs/dlm/lowcomms.c                                  |    10 +-
 fs/netfs/iterator.c                                |   266 -
 fs/nfsd/vfs.c                                      |     2 +-
 fs/ocfs2/cluster/tcp.c                             |    38 +-
 fs/smb/client/smb2ops.c                            |     4 +-
 fs/smb/client/smbdirect.c                          |     2 +-
 fs/splice.c                                        |   205 +-
 include/crypto/if_alg.h                            |     9 +-
 include/linux/bpf.h                                |     7 +-
 include/linux/bpf_verifier.h                       |    52 +-
 include/linux/bpfilter.h                           |     1 -
 include/linux/brcmphy.h                            |    66 +-
 include/linux/btf.h                                |    18 +-
 include/linux/can/length.h                         |   318 +-
 include/linux/filter.h                             |     1 -
 include/linux/fs.h                                 |     4 +-
 include/linux/ieee80211.h                          |   287 +-
 include/linux/leds.h                               |    58 +
 include/linux/mdio.h                               |    49 +
 include/linux/mdio/mdio-regmap.h                   |    26 +
 include/linux/mlx5/device.h                        |     1 +
 include/linux/mlx5/driver.h                        |    15 +-
 include/linux/mlx5/mlx5_ifc.h                      |    36 +-
 include/linux/mlx5/vport.h                         |     2 +-
 include/linux/mmc/sdio_ids.h                       |     3 +-
 include/linux/mroute.h                             |    11 +-
 include/linux/mroute6.h                            |    31 +-
 include/linux/net.h                                |    10 +-
 include/linux/net_mm.h                             |    17 +
 include/linux/netdevice.h                          |    39 +-
 include/linux/netfilter.h                          |     4 +-
 include/linux/netfs.h                              |     4 -
 include/linux/netlink.h                            |     1 +
 include/linux/pcs-altera-tse.h                     |    17 -
 include/linux/pcs-lynx.h                           |     5 +-
 include/linux/pcs/pcs-xpcs.h                       |     9 +-
 include/linux/phy.h                                |    55 +-
 include/linux/phylink.h                            |   122 +-
 include/linux/ptp_clock_kernel.h                   |    11 +-
 include/linux/ref_tracker.h                        |    25 +-
 include/linux/sfp.h                                |    14 +
 include/linux/skbuff.h                             |   128 +-
 include/linux/socket.h                             |     6 +-
 include/linux/splice.h                             |     3 +
 include/linux/stmmac.h                             |     1 +
 include/linux/sunrpc/svc.h                         |    11 +-
 include/linux/uio.h                                |     5 +
 include/net/bonding.h                              |     4 +-
 include/net/cfg80211.h                             |   175 +-
 include/net/cfg802154.h                            |     3 +
 include/net/devlink.h                              |   238 +-
 include/net/dsa.h                                  |    18 +-
 include/net/flow.h                                 |     3 +-
 include/net/flow_dissector.h                       |    23 +
 include/net/gro.h                                  |    27 +-
 include/net/gso.h                                  |   109 +
 include/net/ieee80211_radiotap.h                   |     2 +
 include/net/ieee802154_netdev.h                    |    20 +-
 include/net/inet_common.h                          |     5 +-
 include/net/ip.h                                   |    22 +-
 include/net/kcm.h                                  |     2 +-
 include/net/mac80211.h                             |    88 +-
 include/net/macsec.h                               |    10 +
 include/net/mctp.h                                 |     4 +-
 include/net/netfilter/nf_conntrack_expect.h        |    18 +-
 include/net/netfilter/nf_flow_table.h              |     4 +-
 include/net/netfilter/nf_tables.h                  |     3 +
 include/net/netns/ipv4.h                           |     2 +
 include/net/phonet/phonet.h                        |    21 +
 include/net/pkt_cls.h                              |     1 +
 include/net/pkt_sched.h                            |    54 +-
 include/net/regulatory.h                           |    13 +-
 include/net/route.h                                |     6 +-
 include/net/rpl.h                                  |     3 -
 include/net/sch_generic.h                          |    14 -
 include/net/scm.h                                  |    74 +-
 include/net/sock.h                                 |    13 +-
 include/net/tcp.h                                  |    17 +-
 include/net/tls.h                                  |    10 +-
 include/net/udp.h                                  |     5 +-
 include/net/vxlan.h                                |     4 +-
 include/net/xdp_sock_drv.h                         |     4 -
 include/net/xsk_buff_pool.h                        |     2 +-
 include/uapi/asm-generic/socket.h                  |     3 +
 include/uapi/linux/bpf.h                           |    31 +-
 include/uapi/linux/can.h                           |     1 -
 include/uapi/linux/can/raw.h                       |     2 +
 include/uapi/linux/if_link.h                       |     1 +
 include/uapi/linux/mdio.h                          |    24 +
 include/uapi/linux/mptcp.h                         |    29 +
 include/uapi/linux/netfilter/nf_tables.h           |     4 +
 include/uapi/linux/nl80211.h                       |    30 +-
 include/uapi/linux/openvswitch.h                   |     1 +
 include/uapi/linux/pkt_cls.h                       |    11 +
 include/uapi/linux/pkt_sched.h                     |    10 +
 include/uapi/linux/ptp_clock.h                     |     3 +-
 io_uring/net.c                                     |     2 +
 kernel/bpf/bloom_filter.c                          |     3 -
 kernel/bpf/bpf_local_storage.c                     |     3 -
 kernel/bpf/bpf_lru_list.c                          |    21 +-
 kernel/bpf/bpf_lru_list.h                          |     7 +-
 kernel/bpf/bpf_struct_ops.c                        |     3 -
 kernel/bpf/btf.c                                   |    88 +-
 kernel/bpf/cgroup.c                                |    15 +
 kernel/bpf/core.c                                  |     8 +-
 kernel/bpf/cpumap.c                                |     4 -
 kernel/bpf/cpumask.c                               |    38 +-
 kernel/bpf/devmap.c                                |     3 -
 kernel/bpf/hashtab.c                               |     6 -
 kernel/bpf/helpers.c                               |   135 +-
 kernel/bpf/inode.c                                 |    27 +-
 kernel/bpf/log.c                                   |     3 -
 kernel/bpf/lpm_trie.c                              |     3 -
 kernel/bpf/memalloc.c                              |    31 +-
 kernel/bpf/preload/bpf_preload_kern.c              |     4 +-
 kernel/bpf/queue_stack_maps.c                      |     4 -
 kernel/bpf/reuseport_array.c                       |     3 -
 kernel/bpf/stackmap.c                              |     3 -
 kernel/bpf/syscall.c                               |   232 +-
 kernel/bpf/trampoline.c                            |    32 +-
 kernel/bpf/verifier.c                              |  1044 +-
 kernel/trace/bpf_trace.c                           |     4 +-
 lib/net_utils.c                                    |     3 +-
 lib/ref_tracker.c                                  |   179 +-
 lib/scatterlist.c                                  |   269 +
 lib/test_bpf.c                                     |     3 +-
 lib/test_ref_tracker.c                             |     2 +-
 lib/ts_bm.c                                        |     4 +-
 mm/memory.c                                        |     7 +-
 net/Kconfig                                        |     2 +-
 net/appletalk/ddp.c                                |     1 -
 net/atm/pvc.c                                      |     1 -
 net/atm/svc.c                                      |     1 -
 net/ax25/af_ax25.c                                 |     1 -
 net/bpf/test_run.c                                 |   204 +-
 net/bpfilter/bpfilter_kern.c                       |     2 +-
 net/bridge/br_device.c                             |     1 +
 net/bridge/br_forward.c                            |     3 +
 net/bridge/br_input.c                              |     1 +
 net/bridge/br_private.h                            |    27 +
 net/caif/caif_socket.c                             |     2 -
 net/can/bcm.c                                      |     1 -
 net/can/isotp.c                                    |     6 +-
 net/can/j1939/socket.c                             |     1 -
 net/can/raw.c                                      |     1 -
 net/ceph/messenger_v1.c                            |    30 +-
 net/ceph/messenger_v2.c                            |    19 +-
 net/core/Makefile                                  |     2 +-
 net/core/dev.c                                     |   170 +-
 net/core/filter.c                                  |   212 +-
 net/core/flow_dissector.c                          |    40 +
 net/core/gro.c                                     |   114 +-
 net/core/gso.c                                     |   273 +
 net/core/net_namespace.c                           |     4 +-
 net/core/netdev-genl-gen.c                         |     2 +-
 net/core/netdev-genl-gen.h                         |     2 +-
 net/core/netpoll.c                                 |     5 +-
 net/core/pktgen.c                                  |    13 +-
 net/core/rtnetlink.c                               |   187 +-
 net/core/skbuff.c                                  |   322 +-
 net/core/sock.c                                    |   160 +-
 net/core/sock_map.c                                |     4 -
 net/dccp/dccp.h                                    |     2 +-
 net/dccp/ipv4.c                                    |     1 -
 net/dccp/ipv6.c                                    |     1 -
 net/dccp/proto.c                                   |    12 +-
 net/devlink/health.c                               |     2 +-
 net/devlink/leftover.c                             |   196 +-
 net/dsa/dsa.c                                      |     2 +-
 net/dsa/port.c                                     |    32 +
 net/dsa/slave.c                                    |    84 +-
 net/dsa/switch.c                                   |     4 +-
 net/dsa/switch.h                                   |     3 +
 net/ethtool/ioctl.c                                |    15 +-
 net/ethtool/netlink.c                              |    12 +-
 net/handshake/genl.c                               |     2 +-
 net/handshake/genl.h                               |     2 +-
 net/hsr/hsr_device.c                               |     5 +
 net/hsr/hsr_main.h                                 |     1 +
 net/hsr/hsr_slave.c                                |    15 +-
 net/ieee802154/header_ops.c                        |    36 +
 net/ieee802154/nl802154.c                          |    13 +-
 net/ieee802154/socket.c                            |    17 +-
 net/ipv4/af_inet.c                                 |    56 +-
 net/ipv4/bpfilter/sockopt.c                        |    11 +-
 net/ipv4/esp4_offload.c                            |     1 +
 net/ipv4/fou_nl.c                                  |     2 +-
 net/ipv4/fou_nl.h                                  |     2 +-
 net/ipv4/gre_offload.c                             |     1 +
 net/ipv4/inet_connection_sock.c                    |    21 +-
 net/ipv4/ip_gre.c                                  |     8 +-
 net/ipv4/ip_output.c                               |   170 +-
 net/ipv4/ipconfig.c                                |    10 +-
 net/ipv4/ipmr.c                                    |    63 +-
 net/ipv4/ping.c                                    |    56 +-
 net/ipv4/raw.c                                     |    26 +-
 net/ipv4/syncookies.c                              |     4 +-
 net/ipv4/sysctl_net_ipv4.c                         |    19 +
 net/ipv4/tcp.c                                     |   334 +-
 net/ipv4/tcp_bpf.c                                 |    73 +-
 net/ipv4/tcp_input.c                               |     2 +-
 net/ipv4/tcp_ipv4.c                                |    26 +-
 net/ipv4/tcp_minisocks.c                           |     2 +-
 net/ipv4/tcp_offload.c                             |     8 +-
 net/ipv4/tcp_output.c                              |   195 +-
 net/ipv4/tcp_timer.c                               |    17 +-
 net/ipv4/udp.c                                     |   375 +-
 net/ipv4/udp_impl.h                                |     2 -
 net/ipv4/udp_offload.c                             |     1 +
 net/ipv4/udplite.c                                 |     1 -
 net/ipv6/addrconf.c                                |     4 +-
 net/ipv6/af_inet6.c                                |     6 +-
 net/ipv6/esp6_offload.c                            |     1 +
 net/ipv6/exthdrs.c                                 |    36 +-
 net/ipv6/ip6_offload.c                             |     1 +
 net/ipv6/ip6_output.c                              |    19 +
 net/ipv6/ip6mr.c                                   |    44 +-
 net/ipv6/raw.c                                     |    17 +-
 net/ipv6/route.c                                   |    25 +-
 net/ipv6/rpl.c                                     |     7 -
 net/ipv6/seg6_iptunnel.c                           |     3 +-
 net/ipv6/tcp_ipv6.c                                |    12 +-
 net/ipv6/tcpv6_offload.c                           |     3 +-
 net/ipv6/udp.c                                     |    15 +
 net/ipv6/udp_offload.c                             |     1 +
 net/kcm/kcmsock.c                                  |   339 +-
 net/key/af_key.c                                   |     1 -
 net/l2tp/l2tp_core.h                               |     2 +-
 net/l2tp/l2tp_ip.c                                 |    10 +-
 net/l2tp/l2tp_ip6.c                                |     1 -
 net/llc/af_llc.c                                   |     1 -
 net/mac80211/agg-tx.c                              |    14 +-
 net/mac80211/cfg.c                                 |   102 +-
 net/mac80211/chan.c                                |    13 +-
 net/mac80211/debug.h                               |     8 +-
 net/mac80211/debugfs_netdev.c                      |    21 +-
 net/mac80211/debugfs_sta.c                         |   185 +
 net/mac80211/driver-ops.h                          |    10 +-
 net/mac80211/eht.c                                 |     5 +-
 net/mac80211/he.c                                  |     3 +-
 net/mac80211/ht.c                                  |     5 +-
 net/mac80211/ibss.c                                |    38 +-
 net/mac80211/ieee80211_i.h                         |    69 +-
 net/mac80211/iface.c                               |    48 +-
 net/mac80211/key.c                                 |     8 +-
 net/mac80211/link.c                                |    55 +-
 net/mac80211/main.c                                |     7 +-
 net/mac80211/mesh.c                                |    40 +-
 net/mac80211/mesh.h                                |    19 +-
 net/mac80211/mesh_hwmp.c                           |     6 +-
 net/mac80211/mesh_plink.c                          |    37 +-
 net/mac80211/mesh_ps.c                             |     7 +-
 net/mac80211/mlme.c                                |   568 +-
 net/mac80211/ocb.c                                 |    10 +-
 net/mac80211/offchannel.c                          |     4 +-
 net/mac80211/rx.c                                  |    47 +-
 net/mac80211/scan.c                                |    95 +-
 net/mac80211/sta_info.c                            |   240 +-
 net/mac80211/status.c                              |     6 +-
 net/mac80211/tdls.c                                |   278 +-
 net/mac80211/trace.h                               |    10 +-
 net/mac80211/tx.c                                  |    75 +-
 net/mac80211/util.c                                |   306 +-
 net/mac802154/ieee802154_i.h                       |    21 +
 net/mac802154/main.c                               |     2 +
 net/mac802154/rx.c                                 |    70 +-
 net/mac802154/scan.c                               |    68 +-
 net/mctp/af_mctp.c                                 |     1 -
 net/mctp/route.c                                   |     3 -
 net/mpls/af_mpls.c                                 |     1 +
 net/mpls/mpls_gso.c                                |     1 +
 net/mptcp/mib.c                                    |     6 +
 net/mptcp/mib.h                                    |    18 +
 net/mptcp/options.c                                |    19 +-
 net/mptcp/pm.c                                     |    47 +-
 net/mptcp/pm_netlink.c                             |   142 +-
 net/mptcp/pm_userspace.c                           |     5 +-
 net/mptcp/protocol.c                               |    65 +-
 net/mptcp/protocol.h                               |    20 +-
 net/mptcp/sockopt.c                                |   153 +-
 net/mptcp/subflow.c                                |     2 +
 net/ncsi/ncsi-rsp.c                                |    93 +-
 net/netfilter/ipset/ip_set_core.c                  |     2 -
 net/netfilter/ipvs/Kconfig                         |    27 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |    26 +-
 net/netfilter/ipvs/ip_vs_xmit.c                    |     4 +-
 net/netfilter/nf_conntrack_proto_dccp.c            |    52 +-
 net/netfilter/nf_conntrack_proto_gre.c             |     1 +
 net/netfilter/nf_conntrack_sip.c                   |     2 +-
 net/netfilter/nf_flow_table_core.c                 |    24 +-
 net/netfilter/nf_flow_table_ip.c                   |   232 +-
 net/netfilter/nf_nat_core.c                        |    92 +-
 net/netfilter/nf_tables_api.c                      |    89 +-
 net/netfilter/nfnetlink_queue.c                    |     1 +
 net/netfilter/nft_bitwise.c                        |     2 +-
 net/netfilter/nft_byteorder.c                      |     6 +-
 net/netfilter/nft_ct.c                             |     2 +-
 net/netfilter/nft_dynset.c                         |     2 +-
 net/netfilter/nft_exthdr.c                         |   110 +-
 net/netfilter/nft_flow_offload.c                   |    14 +-
 net/netfilter/nft_fwd_netdev.c                     |     2 +-
 net/netfilter/nft_hash.c                           |     2 +-
 net/netfilter/nft_lookup.c                         |    23 +-
 net/netfilter/nft_meta.c                           |     2 +-
 net/netfilter/nft_payload.c                        |     3 +-
 net/netfilter/nft_range.c                          |     2 +-
 net/netfilter/nft_reject.c                         |     2 +-
 net/netfilter/nft_rt.c                             |     2 +-
 net/netfilter/nft_set_pipapo.c                     |     6 +-
 net/netfilter/nft_socket.c                         |     4 +-
 net/netfilter/nft_tproxy.c                         |     2 +-
 net/netfilter/nft_tunnel.c                         |     4 +-
 net/netfilter/nft_xfrm.c                           |     4 +-
 net/netlabel/netlabel_domainhash.h                 |     2 +-
 net/netlink/af_netlink.c                           |     8 +-
 net/netlink/diag.c                                 |     7 +-
 net/netlink/genetlink.c                            |     2 +
 net/netrom/af_netrom.c                             |     1 -
 net/nfc/llcp.h                                     |     1 -
 net/nfc/llcp_commands.c                            |    15 +-
 net/nfc/llcp_core.c                                |    51 +-
 net/nfc/llcp_sock.c                                |    18 +-
 net/nfc/netlink.c                                  |    20 +-
 net/nfc/nfc.h                                      |     1 +
 net/nsh/nsh.c                                      |     1 +
 net/openvswitch/actions.c                          |    13 +-
 net/openvswitch/datapath.c                         |     1 +
 net/openvswitch/flow_netlink.c                     |     2 +
 net/openvswitch/meter.c                            |     4 +-
 net/packet/af_packet.c                             |     2 -
 net/phonet/datagram.c                              |    11 +-
 net/phonet/pep.c                                   |    11 +-
 net/phonet/socket.c                                |     4 +-
 net/qrtr/af_qrtr.c                                 |     1 -
 net/rds/af_rds.c                                   |     1 -
 net/rds/tcp_send.c                                 |    21 +-
 net/rose/af_rose.c                                 |     1 -
 net/rxrpc/af_rxrpc.c                               |     1 -
 net/sched/act_pedit.c                              |     4 +-
 net/sched/act_police.c                             |     1 +
 net/sched/cls_flower.c                             |   132 +-
 net/sched/sch_cake.c                               |     1 +
 net/sched/sch_htb.c                                |     7 +-
 net/sched/sch_netem.c                              |    60 +-
 net/sched/sch_taprio.c                             |    90 +-
 net/sched/sch_tbf.c                                |     1 +
 net/sctp/offload.c                                 |     1 +
 net/sctp/protocol.c                                |     5 +-
 net/sctp/socket.c                                  |    26 +-
 net/sctp/stream_sched.c                            |     9 +-
 net/smc/af_smc.c                                   |    29 -
 net/smc/smc_stats.c                                |     2 +-
 net/smc/smc_stats.h                                |     1 -
 net/smc/smc_tx.c                                   |    19 +-
 net/smc/smc_tx.h                                   |     2 -
 net/socket.c                                       |    86 +-
 net/sunrpc/svcsock.c                               |    38 +-
 net/tipc/bearer.c                                  |    18 +-
 net/tipc/bearer.h                                  |     4 +-
 net/tipc/socket.c                                  |     3 -
 net/tipc/udp_media.c                               |     4 -
 net/tls/tls.h                                      |     8 +-
 net/tls/tls_device.c                               |   110 +-
 net/tls/tls_device_fallback.c                      |     2 +-
 net/tls/tls_main.c                                 |    70 +-
 net/tls/tls_sw.c                                   |   267 +-
 net/unix/Kconfig                                   |     6 +-
 net/unix/af_unix.c                                 |   226 +-
 net/vmw_vsock/af_vsock.c                           |     3 -
 net/wireless/core.c                                |   174 +-
 net/wireless/core.h                                |    14 +-
 net/wireless/nl80211.c                             |   119 +-
 net/wireless/pmsr.c                                |     4 +-
 net/wireless/rdev-ops.h                            |    27 +-
 net/wireless/reg.c                                 |    20 +-
 net/wireless/scan.c                                |  1295 +-
 net/wireless/sme.c                                 |    19 +-
 net/wireless/sysfs.c                               |     8 +-
 net/wireless/trace.h                               |    47 +-
 net/wireless/util.c                                |   110 +
 net/wireless/wext-core.c                           |     6 +
 net/wireless/wext-sme.c                            |     4 +-
 net/x25/af_x25.c                                   |     1 -
 net/xdp/xsk.c                                      |     1 -
 net/xdp/xsk_buff_pool.c                            |     7 +-
 net/xdp/xskmap.c                                   |     4 -
 net/xfrm/espintcp.c                                |    14 +-
 net/xfrm/xfrm_device.c                             |     1 +
 net/xfrm/xfrm_interface_core.c                     |     1 +
 net/xfrm/xfrm_ipcomp.c                             |     5 +-
 net/xfrm/xfrm_output.c                             |     1 +
 samples/bpf/tcp_basertt_kern.c                     |     2 +-
 samples/bpf/xdp1_kern.c                            |     2 +-
 samples/bpf/xdp2_kern.c                            |     2 +-
 scripts/pahole-flags.sh                            |     3 +
 tools/bpf/bpftool/Documentation/bpftool-map.rst    |     8 +-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst   |    11 +-
 tools/bpf/bpftool/bash-completion/bpftool          |     7 +-
 tools/bpf/bpftool/common.c                         |     9 +-
 tools/bpf/bpftool/feature.c                        |    24 +-
 tools/bpf/bpftool/iter.c                           |     2 +-
 tools/bpf/bpftool/link.c                           |    16 +-
 tools/bpf/bpftool/main.h                           |     2 +-
 tools/bpf/bpftool/map.c                            |    19 +-
 tools/bpf/bpftool/prog.c                           |    53 +-
 tools/bpf/bpftool/struct_ops.c                     |     2 +-
 tools/bpf/resolve_btfids/Makefile                  |     4 +-
 tools/include/uapi/asm-generic/socket.h            |     3 +
 tools/include/uapi/linux/bpf.h                     |    31 +-
 tools/lib/bpf/bpf.c                                |    17 +-
 tools/lib/bpf/bpf.h                                |    18 +-
 tools/lib/bpf/bpf_helpers.h                        |    15 +-
 tools/lib/bpf/bpf_tracing.h                        |     3 +-
 tools/lib/bpf/btf.c                                |     2 +-
 tools/lib/bpf/btf_dump.c                           |    22 +-
 tools/lib/bpf/gen_loader.c                         |    14 +-
 tools/lib/bpf/libbpf.c                             |   154 +-
 tools/lib/bpf/libbpf.h                             |    18 +-
 tools/lib/bpf/libbpf.map                           |     5 +
 tools/lib/bpf/libbpf_probes.c                      |     2 +-
 tools/lib/bpf/libbpf_version.h                     |     2 +-
 tools/lib/bpf/usdt.c                               |     5 +-
 tools/net/ynl/Makefile                             |    19 +
 tools/net/ynl/Makefile.deps                        |    20 +
 tools/net/ynl/generated/Makefile                   |    50 +
 tools/net/ynl/generated/devlink-user.c             |   721 +
 tools/net/ynl/generated/devlink-user.h             |   210 +
 tools/net/ynl/generated/ethtool-user.c             |  6353 +++++
 tools/net/ynl/generated/ethtool-user.h             |  5531 ++++
 tools/net/ynl/generated/fou-user.c                 |   328 +
 tools/net/ynl/generated/fou-user.h                 |   337 +
 tools/net/ynl/generated/handshake-user.c           |   331 +
 tools/net/ynl/generated/handshake-user.h           |   145 +
 tools/net/ynl/generated/netdev-user.c              |   200 +
 tools/net/ynl/generated/netdev-user.h              |    85 +
 tools/net/ynl/lib/Makefile                         |    28 +
 tools/net/ynl/lib/nlspec.py                        |    46 +-
 tools/net/ynl/lib/ynl.c                            |   901 +
 tools/net/ynl/lib/ynl.h                            |   237 +
 tools/net/ynl/lib/ynl.py                           |   135 +-
 tools/net/ynl/samples/.gitignore                   |     3 +
 tools/net/ynl/samples/Makefile                     |    30 +
 tools/net/ynl/samples/devlink.c                    |    60 +
 tools/net/ynl/samples/ethtool.c                    |    65 +
 tools/net/ynl/samples/netdev.c                     |   108 +
 tools/net/ynl/ynl-gen-c.py                         |   745 +-
 tools/net/ynl/ynl-regen.sh                         |     6 +-
 tools/perf/trace/beauty/include/linux/socket.h     |     1 -
 tools/perf/trace/beauty/msg_flags.c                |     6 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64       |    83 +-
 tools/testing/selftests/bpf/DENYLIST.s390x         |     1 +
 tools/testing/selftests/bpf/Makefile               |     3 +-
 tools/testing/selftests/bpf/bench.c                |    15 +-
 tools/testing/selftests/bpf/bench.h                |     1 +
 .../selftests/bpf/benchs/bench_bloom_filter_map.c  |    14 +-
 .../bpf/benchs/bench_bpf_hashmap_full_update.c     |    10 +-
 .../bpf/benchs/bench_bpf_hashmap_lookup.c          |    10 +-
 .../testing/selftests/bpf/benchs/bench_bpf_loop.c  |    10 +-
 tools/testing/selftests/bpf/benchs/bench_count.c   |    14 +-
 .../selftests/bpf/benchs/bench_local_storage.c     |    12 +-
 .../bpf/benchs/bench_local_storage_create.c        |     8 +-
 .../benchs/bench_local_storage_rcu_tasks_trace.c   |    10 +-
 tools/testing/selftests/bpf/benchs/bench_rename.c  |    15 +-
 .../testing/selftests/bpf/benchs/bench_ringbufs.c  |     2 +-
 tools/testing/selftests/bpf/benchs/bench_strncmp.c |    11 +-
 tools/testing/selftests/bpf/benchs/bench_trigger.c |    21 +-
 .../selftests/bpf/benchs/run_bench_ringbufs.sh     |    26 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h           |     6 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |   182 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h  |   107 +
 tools/testing/selftests/bpf/config                 |     4 +
 tools/testing/selftests/bpf/network_helpers.c      |    23 +
 tools/testing/selftests/bpf/network_helpers.h      |     1 +
 .../testing/selftests/bpf/prog_tests/arg_parsing.c |    68 +
 .../selftests/bpf/prog_tests/bpf_mod_race.c        |    34 +-
 .../selftests/bpf/prog_tests/bpf_obj_pinning.c     |   268 +
 tools/testing/selftests/bpf/prog_tests/btf.c       |    40 +
 .../bpf/prog_tests/cgroup_getset_retval.c          |    20 +
 tools/testing/selftests/bpf/prog_tests/check_mtu.c |     2 +-
 tools/testing/selftests/bpf/prog_tests/cpumask.c   |     2 +
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |     8 +
 .../testing/selftests/bpf/prog_tests/fib_lookup.c  |    61 +-
 .../selftests/bpf/prog_tests/global_map_resize.c   |   227 +
 .../selftests/bpf/prog_tests/module_attach.c       |    12 +-
 tools/testing/selftests/bpf/prog_tests/netcnt.c    |     4 +-
 .../selftests/bpf/prog_tests/sock_destroy.c        |   221 +
 tools/testing/selftests/bpf/prog_tests/sockopt.c   |   100 +-
 .../selftests/bpf/prog_tests/sockopt_inherit.c     |    61 +-
 .../selftests/bpf/prog_tests/sockopt_multi.c       |   108 +-
 .../selftests/bpf/prog_tests/sockopt_qos_to_cc.c   |     2 +
 .../selftests/bpf/prog_tests/task_under_cgroup.c   |    53 +
 .../selftests/bpf/prog_tests/unpriv_bpf_disabled.c |     6 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |     4 +
 .../selftests/bpf/prog_tests/vrf_socket_lookup.c   |   312 +
 .../testing/selftests/bpf/prog_tests/xdp_bonding.c |   121 +
 tools/testing/selftests/bpf/progs/bpf_misc.h       |     4 +
 tools/testing/selftests/bpf/progs/cb_refs.c        |     4 +-
 .../bpf/progs/cgroup_getset_retval_getsockopt.c    |    13 +
 .../bpf/progs/cgroup_getset_retval_setsockopt.c    |    17 +
 tools/testing/selftests/bpf/progs/cpumask_common.h |     6 +-
 .../testing/selftests/bpf/progs/cpumask_success.c  |    64 +-
 tools/testing/selftests/bpf/progs/dynptr_fail.c    |   308 +
 tools/testing/selftests/bpf/progs/dynptr_success.c |   337 +
 tools/testing/selftests/bpf/progs/iters.c          |    26 +-
 tools/testing/selftests/bpf/progs/jit_probe_mem.c  |     4 +-
 .../selftests/bpf/progs/kfunc_call_destructive.c   |     3 +-
 .../testing/selftests/bpf/progs/kfunc_call_fail.c  |     9 +-
 .../testing/selftests/bpf/progs/kfunc_call_race.c  |     3 +-
 .../testing/selftests/bpf/progs/kfunc_call_test.c  |    17 +-
 .../selftests/bpf/progs/kfunc_call_test_subprog.c  |     9 +-
 .../testing/selftests/bpf/progs/local_kptr_stash.c |     5 +-
 tools/testing/selftests/bpf/progs/map_kptr.c       |     5 +-
 tools/testing/selftests/bpf/progs/map_kptr_fail.c  |     4 +-
 .../testing/selftests/bpf/progs/refcounted_kptr.c  |     2 +
 .../selftests/bpf/progs/refcounted_kptr_fail.c     |     4 +-
 .../selftests/bpf/progs/sock_destroy_prog.c        |   145 +
 .../selftests/bpf/progs/sock_destroy_prog_fail.c   |    22 +
 .../testing/selftests/bpf/progs/sockopt_inherit.c  |    18 +-
 tools/testing/selftests/bpf/progs/sockopt_multi.c  |    26 +-
 .../selftests/bpf/progs/sockopt_qos_to_cc.c        |    10 +-
 tools/testing/selftests/bpf/progs/sockopt_sk.c     |    25 +-
 .../selftests/bpf/progs/test_global_func1.c        |     2 +
 .../selftests/bpf/progs/test_global_map_resize.c   |    58 +
 .../testing/selftests/bpf/progs/test_sock_fields.c |     5 +-
 .../selftests/bpf/progs/test_task_under_cgroup.c   |    51 +
 .../testing/selftests/bpf/progs/test_xdp_dynptr.c  |     1 +
 .../selftests/bpf/progs/verifier_scalar_ids.c      |   659 +
 .../bpf/progs/verifier_subprog_precision.c         |   536 +
 .../selftests/bpf/progs/vrf_socket_lookup.c        |    89 +
 .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |     4 +-
 tools/testing/selftests/bpf/test_progs.c           |   113 +-
 tools/testing/selftests/bpf/test_progs.h           |     1 -
 tools/testing/selftests/bpf/test_verifier.c        |   194 +-
 tools/testing/selftests/bpf/test_xsk.sh            |    10 +-
 tools/testing/selftests/bpf/testing_helpers.c      |   286 +-
 tools/testing/selftests/bpf/testing_helpers.h      |    12 +
 tools/testing/selftests/bpf/verifier/precise.c     |   143 +-
 tools/testing/selftests/bpf/veristat.c             |     9 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |    47 +-
 tools/testing/selftests/bpf/xdp_metadata.h         |     1 +
 tools/testing/selftests/bpf/xsk.h                  |     5 +
 tools/testing/selftests/bpf/xskxceiver.c           |   769 +-
 tools/testing/selftests/bpf/xskxceiver.h           |    31 +-
 .../drivers/net/bonding/bond-eth-type-change.sh    |     1 -
 .../drivers/net/mlxsw/egress_vid_classification.sh |     5 +-
 .../testing/selftests/drivers/net/mlxsw/extack.sh  |    24 +-
 .../drivers/net/mlxsw/ingress_rif_conf_1d.sh       |     5 +-
 .../drivers/net/mlxsw/mirror_gre_scale.sh          |     1 +
 .../drivers/net/mlxsw/one_armed_router.sh          |     3 +-
 .../selftests/drivers/net/mlxsw/q_in_q_veto.sh     |     8 +
 .../selftests/drivers/net/mlxsw/qos_dscp_bridge.sh |     1 +
 .../selftests/drivers/net/mlxsw/qos_ets_strict.sh  |     8 +-
 .../selftests/drivers/net/mlxsw/qos_mc_aware.sh    |     2 +
 .../drivers/net/mlxsw/spectrum/q_in_vni_veto.sh    |     1 +
 tools/testing/selftests/drivers/net/mlxsw/vxlan.sh |    41 +-
 tools/testing/selftests/net/.gitignore             |     1 +
 tools/testing/selftests/net/Makefile               |     1 +
 tools/testing/selftests/net/af_unix/Makefile       |     3 +-
 tools/testing/selftests/net/af_unix/scm_pidfd.c    |   430 +
 tools/testing/selftests/net/fcnal-test.sh          |    87 +
 tools/testing/selftests/net/forwarding/Makefile    |     2 +
 .../selftests/net/forwarding/dual_vxlan_bridge.sh  |     1 +
 .../selftests/net/forwarding/mirror_gre_bound.sh   |     1 +
 .../net/forwarding/mirror_gre_bridge_1d.sh         |     3 +-
 .../net/forwarding/mirror_gre_bridge_1d_vlan.sh    |     3 +-
 .../net/forwarding/mirror_gre_bridge_1q_lag.sh     |     3 +-
 .../selftests/net/forwarding/mirror_topo_lib.sh    |     1 +
 .../selftests/net/forwarding/pedit_dsfield.sh      |     4 +-
 tools/testing/selftests/net/forwarding/q_in_vni.sh |     1 +
 .../selftests/net/forwarding/router_bridge.sh      |     3 +-
 .../selftests/net/forwarding/router_bridge_vlan.sh |    24 +-
 .../selftests/net/forwarding/skbedit_priority.sh   |     4 +-
 .../selftests/net/forwarding/tc_flower_cfm.sh      |   206 +
 .../selftests/net/forwarding/tc_flower_l2_miss.sh  |   350 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |     2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   741 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c  |   120 +-
 tools/testing/selftests/net/nettest.c              |    46 +-
 tools/testing/selftests/net/rtnetlink.sh           |     1 +
 .../selftests/net/test_vxlan_nolocalbypass.sh      |   240 +
 tools/testing/selftests/net/tls.c                  |   131 +
 tools/testing/selftests/ptp/testptp.c              |    29 +-
 .../tc-testing/tc-tests/infra/filter.json          |    25 +
 .../selftests/tc-testing/tc-tests/qdiscs/mq.json   |    25 +-
 1491 files changed, 98684 insertions(+), 25408 deletions(-)
 create mode 100644 Documentation/bpf/map_lru_hash_update.dot
 delete mode 100644 Documentation/devicetree/bindings/net/xilinx_axienet.txt
 create mode 100644 Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
 create mode 100644 Documentation/netlink/specs/ovs_flow.yaml
 create mode 100644 drivers/net/can/usb/f81604.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_ethtool.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_irq.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_irq.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/qos.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/qos.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_debugfs.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/events.h
 create mode 100644 drivers/net/ethernet/microchip/lan966x/lan966x_dcb.c
 create mode 100644 drivers/net/ethernet/sfc/tc_encap_actions.c
 create mode 100644 drivers/net/ethernet/sfc/tc_encap_actions.h
 delete mode 100644 drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c
 delete mode 100644 drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.h
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
 create mode 100644 drivers/net/mdio/mdio-regmap.c
 delete mode 100644 drivers/net/pcs/pcs-altera-tse.c
 create mode 100644 drivers/net/phy/mediatek-ge-soc.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/bz.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/sc.c
 create mode 100644 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723ds.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/acpi.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/acpi.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851b.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851b.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851be.c
 create mode 100644 include/linux/mdio/mdio-regmap.h
 create mode 100644 include/linux/net_mm.h
 delete mode 100644 include/linux/pcs-altera-tse.h
 create mode 100644 include/net/gso.h
 create mode 100644 net/core/gso.c
 create mode 100644 tools/net/ynl/Makefile
 create mode 100644 tools/net/ynl/Makefile.deps
 create mode 100644 tools/net/ynl/generated/Makefile
 create mode 100644 tools/net/ynl/generated/devlink-user.c
 create mode 100644 tools/net/ynl/generated/devlink-user.h
 create mode 100644 tools/net/ynl/generated/ethtool-user.c
 create mode 100644 tools/net/ynl/generated/ethtool-user.h
 create mode 100644 tools/net/ynl/generated/fou-user.c
 create mode 100644 tools/net/ynl/generated/fou-user.h
 create mode 100644 tools/net/ynl/generated/handshake-user.c
 create mode 100644 tools/net/ynl/generated/handshake-user.h
 create mode 100644 tools/net/ynl/generated/netdev-user.c
 create mode 100644 tools/net/ynl/generated/netdev-user.h
 create mode 100644 tools/net/ynl/lib/Makefile
 create mode 100644 tools/net/ynl/lib/ynl.c
 create mode 100644 tools/net/ynl/lib/ynl.h
 create mode 100644 tools/net/ynl/samples/.gitignore
 create mode 100644 tools/net/ynl/samples/Makefile
 create mode 100644 tools/net/ynl/samples/devlink.c
 create mode 100644 tools/net/ynl/samples/ethtool.c
 create mode 100644 tools/net/ynl/samples/netdev.c
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/global_map_resize.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/vrf_socket_lookup.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_map_resize.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
 create mode 100644 tools/testing/selftests/bpf/progs/vrf_socket_lookup.c
 create mode 100644 tools/testing/selftests/net/af_unix/scm_pidfd.c
 create mode 100755 tools/testing/selftests/net/forwarding/tc_flower_cfm.sh
 create mode 100755 tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh
 create mode 100755 tools/testing/selftests/net/test_vxlan_nolocalbypass.sh
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/infra/filter.json

