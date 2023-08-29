Return-Path: <bpf+bounces-8915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA1F78C4B7
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 15:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7414C1C20A19
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 13:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63933156F5;
	Tue, 29 Aug 2023 13:01:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E522A156C7
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 13:01:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59549CC1
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 06:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693314084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l9zeaDOLiw4QOeMr2GWJNUSya8Oeqd83P0EQYtjbo6k=;
	b=YXynjObe2ab7hspjl15lpacfYHxWbA1NG0JO/JZT6ijnDPAsxNwUHyloEYJqgvuH1UwP4d
	iZWmP7RZhnUsPXtXb0AqAXmWSfaUwAaVDVp9dbn8rY9igZkpXGk6QEJOycHRr0kVTBI5rX
	HHOxx/jjo3oBSp8BeYT5mOATBi53DZ0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-L58Ube89MheyD1Fnj3q2Xw-1; Tue, 29 Aug 2023 09:00:00 -0400
X-MC-Unique: L58Ube89MheyD1Fnj3q2Xw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA41A3811803;
	Tue, 29 Aug 2023 12:59:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.148])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0AB012166B25;
	Tue, 29 Aug 2023 12:59:56 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [GIT PULL] Networking for 6.6
Date: Tue, 29 Aug 2023 14:59:50 +0200
Message-ID: <20230829125950.39432-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Linus!

The following changes since commit b5cc3833f13ace75e26e3f7b51cd7b6da5e9cf17:

  Merge tag 'net-6.5-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-08-24 08:23:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.6

for you to fetch changes up to c873512ef3a39cc1a605b7a5ff2ad0a33d619aa8:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-08-29 07:44:56 +0200)

----------------------------------------------------------------
Networking changes for 6.6.

Core
----

 - Increase size limits for to-be-sent skb frag allocations. This
   allows tun, tap devices and packet sockets to better cope with large
   writes operations.

 - Store netdevs in an xarray, to simplify iterating over netdevs.

 - Refactor nexthop selection for multipath routes.

 - Improve sched class lifetime handling.

 - Add backup nexthop ID support for bridge.

 - Implement drop reasons support in openvswitch.

 - Several data races annotations and fixes.

 - Constify the sk parameter of routing functions.

 - Prepend kernel version to netconsole message.

Protocols
---------

 - Implement support for TCP probing the peer being under memory
   pressure.

 - Remove hard coded limitation on IPv6 specific info placement
   inside the socket struct.

 - Get rid of sysctl_tcp_adv_win_scale and use an auto-estimated
   per socket scaling factor.

 - Scaling-up the IPv6 expired route GC via a separated list of
   expiring routes.

 - In-kernel support for the TLS alert protocol.

 - Better support for UDP reuseport with connected sockets.

 - Add NEXT-C-SID support for SRv6 End.X behavior, reducing the SR
   header size.

 - Get rid of additional ancillary per MPTCP connection struct socket.

 - Implement support for BPF-based MPTCP packet schedulers.

 - Format MPTCP subtests selftests results in TAP.

 - Several new SMC 2.1 features including unique experimental options,
   max connections per lgr negotiation, max links per lgr negotiation.

BPF
---

 - Multi-buffer support in AF_XDP.

 - Add multi uprobe BPF links for attaching multiple uprobes
   and usdt probes, which is significantly faster and saves extra fds.

 - Implement an fd-based tc BPF attach API (TCX) and BPF link support on
   top of it.

 - Add SO_REUSEPORT support for TC bpf_sk_assign.

 - Support new instructions from cpu v4 to simplify the generated code and
   feature completeness, for x86, arm64, riscv64.

 - Support defragmenting IPv(4|6) packets in BPF.

 - Teach verifier actual bounds of bpf_get_smp_processor_id()
   and fix perf+libbpf issue related to custom section handling.

 - Introduce bpf map element count and enable it for all program types.

 - Add a BPF hook in sys_socket() to change the protocol ID
   from IPPROTO_TCP to IPPROTO_MPTCP to cover migration for legacy.

 - Introduce bpf_me_mcache_free_rcu() and fix OOM under stress.

 - Add uprobe support for the bpf_get_func_ip helper.

 - Check skb ownership against full socket.

 - Support for up to 12 arguments in BPF trampoline.

 - Extend link_info for kprobe_multi and perf_event links.

Netfilter
---------

 - Speed-up process exit by aborting ruleset validation if a
   fatal signal is pending.

 - Allow NLA_POLICY_MASK to be used with BE16/BE32 types.

Driver API
----------

 - Page pool optimizations, to improve data locality and cache usage.

 - Introduce ndo_hwtstamp_get() and ndo_hwtstamp_set() to avoid the need
   for raw ioctl() handling in drivers.

 - Simplify genetlink dump operations (doit/dumpit) providing them
   the common information already populated in struct genl_info.

 - Extend and use the yaml devlink specs to [re]generate the split ops.

 - Introduce devlink selective dumps, to allow SF filtering SF based on
   handle and other attributes.

 - Add yaml netlink spec for netlink-raw families, allow route, link and
   address related queries via the ynl tool.

 - Remove phylink legacy mode support.

 - Support offload LED blinking to phy.

 - Add devlink port function attributes for IPsec.

New hardware / drivers
----------------------

 - Ethernet:
   - Broadcom ASP 2.0 (72165) ethernet controller
   - MediaTek MT7988 SoC
   - Texas Instruments AM654 SoC
   - Texas Instruments IEP driver
   - Atheros qca8081 phy
   - Marvell 88Q2110 phy
   - NXP TJA1120 phy

 - WiFi:
   - MediaTek mt7981 support

 - Can:
   - Kvaser SmartFusion2 PCI Express devices
   - Allwinner T113 controllers
   - Texas Instruments tcan4552/4553 chips

 - Bluetooth:
   - Intel Gale Peak
   - Qualcomm WCN3988 and WCN7850
   - NXP AW693 and IW624
   - Mediatek MT2925

Drivers
-------

 - Ethernet NICs:
   - nVidia/Mellanox:
     - mlx5:
       - support UDP encapsulation in packet offload mode
       - IPsec packet offload support in eswitch mode
       - improve aRFS observability by adding new set of counters
       - extends MACsec offload support to cover RoCE traffic
       - dynamic completion EQs
     - mlx4:
       - convert to use auxiliary bus instead of custom interface logic
   - Intel
     - ice:
       - implement switchdev bridge offload, even for LAG interfaces
       - implement SRIOV support for LAG interfaces
     - igc:
       - add support for multiple in-flight TX timestamps
   - Broadcom:
     - bnxt:
       - use the unified RX page pool buffers for XDP and non-XDP
       - use the NAPI skb allocation cache
   - OcteonTX2:
     - support Round Robin scheduling HTB offload
     - TC flower offload support for SPI field
   - Freescale:
     -  add XDP_TX feature support
   - AMD:
     - ionic: add support for PCI FLR event
     - sfc:
       - basic conntrack offload
       - introduce eth, ipv4 and ipv6 pedit offloads
   - ST Microelectronics:
     - stmmac: maximze PTP timestamping resolution

 - Virtual NICs:
   - Microsoft vNIC:
     - batch ringing RX queue doorbell on receiving packets
     - add page pool for RX buffers
   - Virtio vNIC:
     - add per queue interrupt coalescing support
   - Google vNIC:
     - add queue-page-list mode support

 - Ethernet high-speed switches:
   - nVidia/Mellanox (mlxsw):
     - add port range matching tc-flower offload
     - permit enslavement to netdevices with uppers

 - Ethernet embedded switches:
   - Marvell (mv88e6xxx):
     - convert to phylink_pcs
   - Renesas:
     - r8A779fx: add speed change support
     - rzn1: enables vlan support

 - Ethernet PHYs:
   - convert mv88e6xxx to phylink_pcs

 - WiFi:
   - Qualcomm Wi-Fi 7 (ath12k):
     - extremely High Throughput (EHT) PHY support
   - RealTek (rtl8xxxu):
     - enable AP mode for: RTL8192FU, RTL8710BU (RTL8188GU),
       RTL8192EU and RTL8723BU
   - RealTek (rtw89):
     - Introduce Time Averaged SAR (TAS) support

 - Connector:
   - support for event filtering

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Aaron Conole (4):
      selftests: openvswitch: add an initial flow programming case
      selftests: openvswitch: add a test for ipv4 forwarding
      selftests: openvswitch: add basic ct test case parsing
      selftests: openvswitch: add ct-nat test case with ipv4

Abel Wu (1):
      net-memcg: Fix scope of sockmem pressure indicators

Adham Faris (5):
      net/mlx5: Expose port.c/mlx5_query_module_num() function
      net/mlx5: Expose NIC temperature via hardware monitoring kernel API
      net/mlx5e: aRFS, Prevent repeated kernel rule migrations requests
      net/mlx5e: aRFS, Warn if aRFS table does not exist for aRFS rule
      net/mlx5e: aRFS, Introduce ethtool stats

Aditya Kumar Singh (1):
      wifi: ath11k: fix band selection for ppdu received in channel 177 of 5 GHz

Adrian Moreno (7):
      selftests: openvswitch: support key masks
      net: openvswitch: add last-action drop reason
      net: openvswitch: add action error drop reason
      net: openvswitch: add meter drop reason
      net: openvswitch: add misc error drop reasons
      selftests: openvswitch: add drop reason testcase
      selftests: openvswitch: add explicit drop testcase

Alan Maguire (2):
      bpf: sync tools/ uapi header with
      selftests/bpf: fix static assert compilation issue for test_cls_*.c

Alan Stern (1):
      Fix nomenclature for USB and PCI wireless devices

Alex Austin (1):
      sfc: Check firmware supports Ethernet PTP filter

Alex Maftei (2):
      selftests/ptp: Add -x option for testing PTP_SYS_OFFSET_EXTENDED
      selftests/ptp: Add -X option for testing PTP_SYS_OFFSET_PRECISE

Alexander Couzens (1):
      wifi: mt76: mt7915: add support for MT7981

Alexander Lobakin (10):
      bpftool: use a local copy of perf_event to fix accessing :: Bpf_cookie
      bpftool: Define a local bpf_perf_link to fix accessing its fields
      bpftool: Use a local bpf_perf_event_value to fix accessing its fields
      net: skbuff: don't include <net/page_pool/types.h> to <linux/skbuff.h>
      page_pool: place frag_* fields in one cacheline
      net: skbuff: avoid accessing page_pool if !napi_safe when returning page
      net: skbuff: always try to recycle PP pages directly when in softirq
      virtchnl: fix fake 1-elem arrays in structs allocated as `nents + 1` - 1
      virtchnl: fix fake 1-elem arrays in structures allocated as `nents + 1`
      virtchnl: fix fake 1-elem arrays for structures allocated as `nents`

Alexandra Winter (1):
      s390/lcs: Remove FDDI option

Alexei Starovoitov (31):
      Merge branch 'bpf: add percpu stats for bpf_map'
      Merge branch 'bpf: Support ->fill_link_info for kprobe_multi and perf_event links'
      bpf: Rename few bpf_mem_alloc fields.
      bpf: Simplify code of destroy_mem_alloc() with kmemdup().
      bpf: Let free_all() return the number of freed elements.
      bpf: Refactor alloc_bulk().
      bpf: Factor out inc/dec of active flag into helpers.
      bpf: Further refactor alloc_bulk().
      bpf: Change bpf_mem_cache draining process.
      bpf: Add a hint to allocated objects.
      bpf: Allow reuse from waiting_for_gp_ttrace list.
      selftests/bpf: Improve test coverage of bpf_mem_alloc.
      bpf: Introduce bpf_mem_free_rcu() similar to kfree_rcu().
      bpf: Convert bpf_cpumask to bpf_mem_cache_free_rcu.
      Merge branch 'bpf-x86-allow-function-arguments-up-to-12-for-tracing'
      Merge branch 'bpf-refcount-followups-2-owner-field'
      Merge branch 'allow-bpf_map_sum_elem_count-for-all-program-types'
      Merge branch 'xsk-multi-buffer-support'
      Merge branch 'bpf-link-support-for-tc-bpf-programs'
      bpf, net: Introduce skb_pointer_if_linear().
      Merge branch 'bpf-support-new-insns-from-cpu-v4'
      Merge branch 'support-defragmenting-ipv-4-6-packets-in-bpf'
      Merge branch 'bpf-xdp-add-tracepoint-to-xdp-attaching-failure'
      Merge branch 'remove-unnecessary-synchronizations-in-cpumap'
      Merge branch 'samples-bpf-make-bpf-programs-more-libbpf-aware'
      Merge branch 'bpf-add-multi-uprobe-link'
      Merge branch 'fix-for-check_func_arg_reg_off'
      Merge branch 'bpf-fix-an-issue-in-verifing-allow_ptr_leaks'
      Merge branch 'samples-bpf-remove-unmaintained-xdp-sample-utilities'
      Merge branch 'add-support-cpu-v4-insns-for-rv64'
      Merge branch 'bpf-refcount-followups-3-bpf_mem_free_rcu-refcounted-nodes'

Alexis Lothoré (2):
      net: dsa: rzn1-a5psw: remove redundant logs
      dt-bindings: net: dsa: marvell: fix wrong model in compatibility list

Aloka Dixit (9):
      wifi: ath12k: rename HE capabilities setup/copy functions
      wifi: ath12k: move HE capabilities processing to a new function
      wifi: ath12k: WMI support to process EHT capabilities
      wifi: ath12k: propagate EHT capabilities to userspace
      wifi: ath12k: prepare EHT peer assoc parameters
      wifi: ath12k: add WMI support for EHT peer
      wifi: ath12k: peer assoc for 320 MHz
      wifi: ath12k: parse WMI service ready ext2 event
      wifi: ath12k: configure puncturing bitmap

Amisha Patel (1):
      wifi: wilc1000: add SPI commands retry mechanism

Amit Cohen (2):
      mlxsw: reg: Move 'mpsc' definition in 'mlxsw_reg_infos'
      mlxsw: reg: Add Management Capabilities Mask Register

Andrea Mayer (1):
      seg6: add NEXT-C-SID support for SRv6 End.X behavior

Andrea Terzolo (1):
      libbpf: Skip modules BTF loading when CAP_SYS_ADMIN is missing

Andrew Halaney (5):
      net: stmmac: dwmac-qcom-ethqos: Use of_get_phy_mode() over device_get_phy_mode()
      net: stmmac: dwmac-qcom-ethqos: Use dev_err_probe()
      net: stmmac: dwmac-qcom-ethqos: Log more errors in probe
      net: stmmac: Make ptp_clk_freq_config variable type explicit
      net: stmmac: dwmac-qcom-ethqos: Use max frequency for clk_ptp_ref

Andrew Lunn (4):
      led: trig: netdev: Fix requesting offload device
      net: phy: phy_device: Call into the PHY driver to set LED offload
      net: phy: marvell: Add support for offloading LED blinking
      leds: trig-netdev: Disable offload on deactivation of trigger

Andrii Nakryiko (8):
      Merge branch 'libbpf: add netfilter link attach helper'
      libbpf: only reset sec_def handler when necessary
      Merge branch 'bpftool: Fix skeletons compilation for older kernels'
      libbpf: Fix realloc API handling in zero-sized edge cases
      bpf: teach verifier actual bounds of bpf_get_smp_processor_id() result
      selftests/bpf: extend existing map resize tests for per-cpu use case
      selftests/bpf: add uprobe_multi test binary to .gitignore
      libbpf: fix signedness determination in CO-RE relo handling logic

Andy Shevchenko (2):
      net/core: Make use of assign_bit() API
      netlink: Make use of __assign_bit() API

Anh Tuan Phan (1):
      samples/bpf: README: Update build dependencies required

Anilkumar Kolli (1):
      wifi: ath11k: Add coldboot calibration support for QCN9074

Anjali Kulkarni (6):
      netlink: Reverse the patch which removed filtering
      netlink: Add new netlink_release function
      connector/cn_proc: Add filtering to fix some bugs
      connector/cn_proc: Performance improvements
      connector/cn_proc: Allow non-root users access
      connector/cn_proc: Selftest for proc connector

Ante Knezic (1):
      net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X

Anton Protopopov (9):
      bpf: add percpu stats for bpf_map elements insertions/deletions
      bpf: add a new kfunc to return current bpf_map elements count
      bpf: populate the per-cpu insertions/deletions counters for hashmaps
      bpf: make preloaded map iterators to display map elements count
      selftests/bpf: test map percpu stats
      bpf: consider types listed in reg2btf_ids as trusted
      bpf: consider CONST_PTR_TO_MAP as trusted pointer to struct bpf_map
      bpf: make an argument const in the bpf_map_sum_elem_count kfunc
      bpf: allow any program to use the bpf_map_sum_elem_count kfunc

Antonio Napolitano (1):
      r8152: add vendor/device ID pair for D-Link DUB-E250

Arnd Bergmann (8):
      bpf: work around -Wuninitialized warning
      wifi: ath12k: fix memcpy array overflow in ath12k_peer_assoc_h_he()
      bpf: fix bpf_probe_read_kernel prototype mismatch
      ethernet: ldmvsw: mark ldmvsw_open() static
      ethernet: atarilance: mark init function static
      qed: remove unused 'resp_size' calculation
      mac80211: make ieee80211_tx_info padding explicit
      wifi: ath: remove unused-but-set parameter

Arseniy Krasnov (4):
      virtio/vsock: rework MSG_PEEK for SOCK_STREAM
      virtio/vsock: support MSG_PEEK for SOCK_SEQPACKET
      vsock/test: rework MSG_PEEK test for SOCK_STREAM
      vsock/test: MSG_PEEK test for SOCK_SEQPACKET

Atul Raut (1):
      net/macmace: Replace zero-length array with DECLARE_FLEX_ARRAY() helper

Avraham Stern (5):
      wifi: iwlwifi: pcie: avoid a warning in case prepare card failed
      wifi: iwlmei: don't send SAP messages if AMT is disabled
      wifi: iwlmei: send HOST_GOES_DOWN message even if wiamt is disabled
      wifi: iwlmei: send driver down SAP message only if wiamt is enabled
      wifi: iwlmei: don't send nic info with invalid mac address

Azeem Shaikh (1):
      wifi: mt76: Replace strlcpy() with strscpy()

Baochen Qiang (1):
      wifi: ath12k: Use pdev_id rather than mac_id to get pdev

Bartosz Golaszewski (12):
      net: stmmac: replace the has_integrated_pcs field with a flag
      net: stmmac: replace the sph_disable field with a flag
      net: stmmac: replace the use_phy_wol field with a flag
      net: stmmac: replace the has_sun8i field with a flag
      net: stmmac: replace the tso_en field with a flag
      net: stmmac: replace the serdes_up_after_phy_linkup field with a flag
      net: stmmac: replace the vlan_fail_q_en field with a flag
      net: stmmac: replace the multi_msi_en field with a flag
      net: stmmac: replace the ext_snapshot_en field with a flag
      net: stmmac: replace the int_snapshot_en field with a flag
      net: stmmac: replace the rx_clk_runs_in_lpi field with a flag
      net: stmmac: replace the en_tx_lpi_clockgating field with a flag

Bastien Nocera (1):
      Bluetooth: btusb: Fix quirks table naming

Ben Greear (1):
      wifi: mt76: mt7921: Support temp sensor

Benjamin Poirier (4):
      nexthop: Factor out hash threshold fdb nexthop selection
      nexthop: Factor out neighbor validity check
      nexthop: Do not return invalid nexthop object during multipath selection
      selftests: net: Add test cases for nexthop groups with invalid neighbors

Bitterblue Smith (4):
      wifi: rtl8xxxu: Enable AP mode for RTL8192FU
      wifi: rtl8xxxu: Enable AP mode for RTL8710BU (RTL8188GU)
      wifi: rtl8xxxu: Enable AP mode for RTL8192EU
      wifi: rtl8xxxu: Enable AP mode for RTL8723BU

Björn Töpel (3):
      selftests/bpf: Add F_NEEDS_EFFICIENT_UNALIGNED_ACCESS to some tests
      selftests/bpf: Honor $(O) when figuring out paths
      selftests/bpf: Bump and validate MAX_SYMS

Bo Jiao (2):
      wifi: mt76: mt7915: disable WFDMA Tx/Rx during SER recovery
      wifi: mt76: mt7996: disable WFDMA Tx/Rx during SER recovery

Breno Leitao (5):
      netconsole: Append kernel version to message
      netconsole: Use sysfs_emit() instead of snprintf()
      netconsole: Use kstrtobool() instead of kstrtoint()
      netconsole: Create a allocation helper
      netconsole: Enable compile time configuration

Brett Creeley (1):
      pds_core: Fix documentation for pds_client_register

Budimir Markovic (1):
      net/sched: sch_hfsc: Ensure inner classes have fsc curve

Chen Jiahao (1):
      net: bcmasp: Clean up redundant dev_err_probe()

Cheng-Chieh Hsieh (1):
      wifi: rtw89: phy: modify register setting of ENV_MNTR, PHYSTS and DIG

Chin-Yen Lee (2):
      wifi: rtw89: recognize log format from firmware file
      wifi: rtw89: support firmware log with formatted text

Chris Lu (5):
      Bluetooth: btmtk: add printing firmware information
      Bluetooth: btusb: Add a new VID/PID 0489/e0f6 for MT7922
      Bluetooth: btusb: Add new VID/PID 0489/e102 for MT7922
      Bluetooth: btusb: Add new VID/PID 04ca/3804 for MT7922
      Bluetooth: btmtk: Fix kernel crash when processing coredump

Christian Marangi (7):
      wifi: mt76: split get_of_eeprom in subfunction
      wifi: mt76: add support for providing eeprom in nvmem cells
      net: dsa: tag_qca: return early if dev is not found
      net: dsa: qca8k: make learning configurable and keep off if standalone
      net: dsa: qca8k: limit user ports access to the first CPU port on setup
      net: dsa: qca8k: move qca8xxx hol fixup to separate function
      net: dsa: qca8k: use dsa_for_each macro instead of for loop

Christophe JAILLET (1):
      Bluetooth: hci_debugfs: Use kstrtobool() instead of strtobool()

Christophe Leroy (11):
      net: fs_enet: Remove set but not used variable
      net: fs_enet: Fix address space and base types mismatches
      net: fs_enet: Remove fs_get_id()
      net: fs_enet: Remove unused fields in fs_platform_info struct
      net: fs_enet: Remove has_phy field in fs_platform_info struct
      net: fs_enet: Remove stale prototypes from fsl_soc.c
      net: fs_enet: Move struct fs_platform_info into fs_enet.h
      net: fs_enet: Don't include fs_enet_pd.h when not needed
      net: fs_enet: Remove linux/fs_enet_pd.h
      net: fs_enet: Use cpm_muram_xxx() functions instead of cpm_dpxxx() macros
      kunit: Fix checksum tests on big endian CPUs

Chuck Lever (7):
      net/tls: Move TLS protocol elements to a separate header
      net/tls: Add TLS Alert definitions
      net/handshake: Add API for sending TLS Closure alerts
      SUNRPC: Send TLS Closure alerts before closing a TCP socket
      net/handshake: Add helpers for parsing incoming TLS Alerts
      SUNRPC: Use new helpers to handle TLS Alerts
      net/handshake: Trace events for TLS Alert helpers

Claudia Draghicescu (3):
      Bluetooth: Check for ISO support in controller
      Bluetooth: hci_sync: Enable events for BIS capable devices
      Bluetooth: ISO: Add support for periodic adv reports processing

Clément Léger (3):
      net: dsa: rzn1-a5psw: use a5psw_reg_rmw() to modify flooding resolution
      net: dsa: rzn1-a5psw: add support for .port_bridge_flags
      net: dsa: rzn1-a5psw: add vlan support

Colin Ian King (3):
      selftests/xsk: Fix spelling mistake "querrying" -> "querying"
      net: ethernet: slicoss: remove redundant increment of pointer data
      net/mlx5e: Fix spelling mistake "Faided" -> "Failed"

Csókás Bence (1):
      net: fec: Refactor: rename `adapter` to `fep`

Dan Carpenter (4):
      net/mlx4: clean up a type issue
      net: bcmasp: Prevent array undereflow in bcmasp_netfilt_get_init()
      Bluetooth: msft: Fix error code in msft_cancel_address_filter_sync()
      wifi: rtw89: fix a width vs precision bug

Daniel Borkmann (19):
      selftests/bpf: Fix bpf_nf failure upon test rerun
      Merge branch 'bpf-mem-cache-free-rcu'
      bpf: Add generic attach/detach/query API for multi-progs
      bpf: Add fd-based tcx multi-prog infra with link support
      libbpf: Add opts-based attach/detach/query API for tcx
      libbpf: Add link-based API for tcx
      libbpf: Add helper macro to clear opts structs
      bpftool: Extend net dump with tcx progs
      selftests/bpf: Add mprog API tests for BPF tcx opts
      selftests/bpf: Add mprog API tests for BPF tcx links
      tcx: Fix splat in ingress_destroy upon tcx_entry_free
      selftests/bpf: Test that SO_REUSEPORT can be used with sk_assign helper
      bpf: Fix mprog detachment for empty mprog entry
      selftests/bpf: Add test for detachment on empty mprog entry
      selftests/bpf: Add various more tcx test cases
      bpftool: Implement link show support for tcx
      bpftool: Implement link show support for xdp
      net: Fix skb consume leak in sch_handle_egress
      net: Make consumed action consistent in sch_handle_egress

Daniel Golle (12):
      dt-bindings: net: wireless: mt76: add bindings for MT7981
      dt-bindings: net: mediatek,net: add missing mediatek,mt7621-eth
      dt-bindings: net: mediatek,net: add mt7988-eth binding
      net: ethernet: mtk_eth_soc: convert clock bitmap to u64
      net: ethernet: mtk_eth_soc: support per-flow accounting on MT7988
      net: dsa: mt7530: improve and relax PHY driver dependency
      net: phy: mediatek-ge-soc: support PHY LEDs
      net: pcs: lynxi: implement pcs_disable op
      net: ethernet: mtk_eth_soc: fix register definitions for MT7988
      net: ethernet: mtk_eth_soc: add reset bits for MT7988
      net: ethernet: mtk_eth_soc: add support for in-SoC SRAM
      net: ethernet: mtk_eth_soc: support 36-bit DMA addressing on MT7988

Daniel T. Lee (10):
      bpftool: fix perf help message
      samples/bpf: fix warning with ignored-attributes
      samples/bpf: convert to vmlinux.h with tracing programs
      samples/bpf: unify bpf program suffix to .bpf with tracing programs
      samples/bpf: fix symbol mismatch by compiler optimization
      samples/bpf: make tracing programs to be more CO-RE centric
      samples/bpf: fix bio latency check with tracepoint
      samples/bpf: fix broken map lookup probe
      samples/bpf: refactor syscall tracing programs using BPF_KSYSCALL macro
      samples/bpf: simplify spintest with kprobe.multi

Daniel Xu (7):
      netfilter: defrag: Add glue hooks for enabling/disabling defrag
      netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link
      bpf: selftests: Support not connecting client socket
      bpf: selftests: Support custom type and proto for client sockets
      bpf: selftests: Add defrag selftests
      netfilter: bpf: Only define get_proto_defrag_hook() if necessary
      libbpf: Add bpf_object__unpin()

Dave Ertman (9):
      ice: Add driver support for firmware changes for LAG
      ice: changes to the interface with the HW and FW for SRIOV_VF+LAG
      ice: implement lag netdev event handler
      ice: process events created by lag netdev event handler
      ice: Flesh out implementation of support for SRIOV on bonded interface
      ice: support non-standard teardown of bond interface
      ice: enforce interface eligibility and add messaging for SRIOV LAG
      ice: enforce no DCB config changing when in bond
      ice: update reset path for SRIOV LAG support

Dave Marchevsky (13):
      bpf: Introduce internal definitions for UAPI-opaque bpf_{rb,list}_node
      bpf: Add 'owner' field to bpf_{list,rb}_node
      selftests/bpf: Add rbtree test exercising race which 'owner' field prevents
      selftests/bpf: Disable newly-added 'owner' field test until refcount re-enabled
      libbpf: Support triple-underscore flavors for kfunc relocation
      selftests/bpf: Add CO-RE relocs kfunc flavors tests
      bpf: Ensure kptr_struct_meta is non-NULL for collection insert and refcount_acquire
      bpf: Consider non-owning refs trusted
      bpf: Use bpf_mem_free_rcu when bpf_obj_dropping refcounted nodes
      bpf: Reenable bpf_refcount_acquire
      bpf: Consider non-owning refs to refcounted nodes RCU protected
      bpf: Allow bpf_spin_{lock,unlock} in sleepable progs
      selftests/bpf: Add tests for rbtree API interaction in sleepable progs

Dave Thaler (1):
      bpf, docs: Fix definition of BPF_NEG operation

David Howells (1):
      udp6: Fix __ip6_append_data()'s handling of MSG_SPLICE_PAGES

David S. Miller (54):
      Merge branch 'stmmac-errors'
      Merge branch 'sk-const'
      Merge branch 'mv88e6xxx-phylink_pcs'
      Merge branch 'macsec-selftests'
      Merge branch 'mlxsw-rif-pvid'
      Merge branch 'brcm-asp-2.0-support'
      Merge branch 'qrtr-fixes'
      Merge branch 'phy-at803x-support'
      Merge branch 'backup-nexthop-ID'
      Merge branch 'mptcp-selftests'
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'remove-RTO_ONLINK-users'
      Merge branch 'mlxsw-enslavement'
      Merge branch 'octeontx2-pf-round-robin-sched'
      Merge branch 'process-connector-bug-fixes-and-enhancements'
      Merge branch 'phy-motorcomm-driver-strength'
      Merge branch 'ionic-FLR-support'
      Merge branch 'rxfh-custom-rss'
      Merge branch 'sfc-siena-next'
      Merge tag 'linux-can-next-for-6.6-20230728' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge branch 'selftest-ptp'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/nex t-queue
      Merge branch 'selftests-mlxsw'
      Merge branch 'oxnas=dwmac-removal'
      Merge branch 'tc-flower-SPI'
      Merge branch 'icssg-driver'
      Merge tag 'linux-can-next-for-6.6-20230803' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge branch 'tcp-options-lockless'
      Merge branch 'gve-desc'
      Merge branch 'sfc-conntrack-offload'
      Merge branch 'bond-cleanups'
      Merge branch 'rzn1-a5psw-vlan-port_bridge_flags'
      Merge branch 'tcp-oom-probe'
      Merge branch 'net-pci_dev_id'
      Merge tag 'for-net-next-2023-08-11' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Merge branch 'mptcp-remove-msk-subflow'
      Merge branch 'ovs-drop-reasons'
      Merge branch 'net-stats-helpers'
      Merge branch 'mlxsw-redirection'
      Merge branch 'fec-XDP_TX'
      Merge branch 'hns3-ethtool'
      Merge branch 'redundant-of_match_ptr'
      Merge branch 'inet-data-races'
      Merge branch 'ipv6-expired-routes'
      Merge branch 'smc-features'
      Merge branch 'vcap_get_rule-return-value'
      Merge branch 'fixed_phy_register-return-value'
      Merge branch 'ipv6-update-route-when-delete-saddr'
      Merge branch 'mlx4-aux-bus'
      Merge branch 'txgbe-link-modes'
      Merge branch 'mlxsw-fixes'
      Merge branch 'sfc-pedit-offloads'
      Merge branch 'iep-drver-timestamping-support'
      Merge branch 'octeontx2-af-misc-mac-block-changes'

David Vernet (3):
      bpf,docs: Create new standardization subdirectory
      bpf: Support default .validate() and .update() behavior for struct_ops links
      bpf: Document struct bpf_struct_ops fields

Deren Wu (3):
      wifi: mt76: mt7921: do not support one stream on secondary antenna only
      wifi: mt76: mt7921e: report tx retries/failed counts in tx free event
      wifi: mt76: mt7921: fix skb leak by txs missing in AMSDU

Dima Chumak (4):
      devlink: Expose port function commands to control IPsec crypto offloads
      devlink: Expose port function commands to control IPsec packet offloads
      net/mlx5: Implement devlink port function cmds to control ipsec_crypto
      net/mlx5: Implement devlink port function cmds to control ipsec_packet

Dmitry Antipov (31):
      wifi: ath9k: avoid using uninitialized array
      wifi: ath9k: fix fortify warnings
      wifi: rtw88: delete timer and free skb queue when unloading
      wifi: rtw88: remove unused and set but unused leftovers
      wifi: rtw88: remove unused USB bulkout size set
      wifi: rtw88: simplify vif iterators
      wifi: mwifiex: prefer strscpy() over strlcpy()
      wifi: mwifiex: fix fortify warning
      wifi: brcmsmac: remove unused data type
      wifi: wil6210: fix fortify warnings
      wifi: libertas: add missing calls to cancel_work_sync()
      wifi: libertas: use convenient lists to manage SDIO packets
      wifi: libertas: simplify list operations in free_if_spi_card()
      wifi: libertas: cleanup SDIO reset
      wifi: libertas: handle possible spu_write_u16() errors
      wifi: libertas: prefer kstrtoX() for simple integer conversions
      wifi: brcmsmac: remove more unused data types
      wifi: brcmsmac: cleanup SCB-related data types
      wifi: mwifiex: fix error recovery in PCIE buffer descriptor management
      wifi: ath11k: simplify ath11k_mac_validate_vht_he_fixed_rate_settings()
      wifi: ath12k: relax list iteration in ath12k_mac_vif_unref()
      wifi: mwifiex: fix memory leak in mwifiex_histogram_read()
      wifi: mwifiex: cleanup private data structures
      wifi: mwifiex: handle possible sscanf() errors
      wifi: mwifiex: handle possible mwifiex_write_reg() errors
      wifi: mwifiex: drop BUG_ON from TX paths
      wifi: mwifiex: cleanup adapter data
      wifi: mwifiex: fix comment typos in SDIO module
      wifi: ath9k: consistently use kstrtoX_from_user() functions
      wifi: cfg80211: improve documentation for flag fields
      wifi: mwifiex: avoid possible NULL skb pointer dereference

Donald Hunter (13):
      doc/netlink: Add delete operation to ovs_vport spec
      doc/netlink: Fix typo in genetlink-* schemas
      doc/netlink: Add a schema for netlink-raw families
      doc/netlink: Update genetlink-legacy documentation
      doc/netlink: Document the netlink-raw schema extensions
      tools/ynl: Add mcast-group schema parsing to ynl
      tools/net/ynl: Fix extack parsing with fixed header genlmsg
      tools/net/ynl: Add support for netlink-raw families
      tools/net/ynl: Implement nlattr array-nest decoding in ynl
      tools/net/ynl: Add support for create flags
      doc/netlink: Add spec for rt addr messages
      doc/netlink: Add spec for rt link messages
      doc/netlink: Add spec for rt route messages

Dongliang Mu (1):
      wifi: ath9k: fix printk specifier

Douglas Anderson (1):
      Bluetooth: hci_sync: Don't double print name in add/remove adv_monitor

EN-WEI WU (1):
      wifi: mac80211_hwsim: avoid calling nlmsg_free() in IRQ or IRQ disabled

Eduard Zingerman (1):
      selftests/bpf: relax expected log messages to allow emitting BPF_ST

Edward Cree (7):
      sfc: add MAE table machinery for conntrack table
      sfc: functions to register for conntrack zone offload
      sfc: functions to insert/remove conntrack entries to MAE hardware
      sfc: offload conntrack flow entries (match only) from CT zones
      sfc: handle non-zero chain_index on TC rules
      sfc: conntrack state matches in TC rules
      sfc: offload left-hand side rules for conntrack

Emeel Hakim (1):
      net/mlx5e: Support IPsec upper protocol selector field offload for RX

Eric Dumazet (40):
      tcp: get rid of sysctl_tcp_adv_win_scale
      tcp: remove tcp_send_partial()
      tcp: tcp_enter_quickack_mode() should be static
      tcp: add TCP_OLD_SEQUENCE drop reason
      ipv6: remove hard coded limitation on ipv6_pinfo
      net: allow alloc_skb_with_frags() to allocate bigger packets
      net: tun: change tun_alloc_skb() to allow bigger paged allocations
      net/packet: change packet_alloc_skb() to allow bigger paged allocations
      net: tap: change tap_alloc_skb() to allow bigger paged allocations
      tcp/dccp: cache line align inet_hashinfo
      net: vlan: update wrong comments
      tcp_metrics: hash table allocation cleanup
      tcp: set TCP_SYNCNT locklessly
      tcp: set TCP_USER_TIMEOUT locklessly
      tcp: set TCP_KEEPINTVL locklessly
      tcp: set TCP_KEEPCNT locklessly
      tcp: set TCP_LINGER2 locklessly
      tcp: set TCP_DEFER_ACCEPT locklessly
      net: annotate data-races around sock->ops
      netlink: convert nlk->flags to atomic flags
      inet: introduce inet->inet_flags
      inet: set/get simple options locklessly
      inet: move inet->recverr to inet->inet_flags
      inet: move inet->recverr_rfc4884 to inet->inet_flags
      inet: move inet->freebind to inet->inet_flags
      inet: move inet->hdrincl to inet->inet_flags
      inet: move inet->mc_loop to inet->inet_frags
      inet: move inet->mc_all to inet->inet_frags
      inet: move inet->transparent to inet->inet_flags
      inet: move inet->is_icsk to inet->inet_flags
      inet: move inet->nodefrag to inet->inet_flags
      inet: move inet->bind_address_no_port to inet->inet_flags
      inet: move inet->defer_connect to inet->inet_flags
      inet: implement lockless IP_TTL
      inet: implement lockless IP_MINTTL
      tcp: refine skb->ooo_okay setting
      net: add skb_queue_purge_reason and __skb_queue_purge_reason
      net: selectively purge error queue in IP_RECVERR / IPV6_RECVERR
      net: annotate data-races around sk->sk_lingertime
      inet: fix IP_TRANSPARENT error handling

Eric Garver (1):
      net: openvswitch: add explicit drop action

Eugen Hristev (1):
      dt-bindings: net: rockchip-dwmac: add default 'input' for clock_in_out

Fangrui Song (1):
      bpf: Replace deprecated -target with --target= for Clang

Fedor Pchelkin (2):
      wifi: ath9k: fix races between ath9k_wmi_cmd and ath9k_wmi_ctrl_rx
      wifi: ath9k: protect WMI command response buffer replacement with a lock

Felix Fietkau (4):
      wifi: mt76: mt7915: fix capabilities in non-AP mode
      wifi: mt76: mt7915: remove VHT160 capability on MT7915
      wifi: mt76: mt7603: fix beacon interval after disabling a single vif
      wifi: mt76: mt7603: fix tx filter/flush function

Feng Liu (1):
      virtio_net: Introduce skb_vnet_common_hdr to avoid typecasting

Florian Fainelli (3):
      dt-bindings: net: Brcm ASP 2.0 Ethernet controller
      net: phy: bcm7xxx: Add EPHY entry for 74165
      net: bcmgenet: Remove TX ring full logging

Florian Westphal (5):
      libbpf: Add netfilter link attach helper
      selftests/bpf: Add bpf_program__attach_netfilter helper test
      netlink: allow be16 and be32 types in all uint policy checks
      netfilter: nf_tables: use NLA_POLICY_MASK to test for valid flag options
      netfilter: nf_tables: allow loop termination for pending fatal signal

Frank Jungclaus (1):
      can: esd_usb: Add support for esd CAN-USB/3

François Michel (3):
      netem: add prng attribute to netem_sched_data
      netem: use a seeded PRNG for generating random losses
      netem: use seeded PRNG for correlated loss events

Furong Xu (3):
      net: stmmac: xgmac: RX queue routing configuration
      net: stmmac: xgmac: show more MAC HW features in debugfs
      net: stmmac: Check more MAC HW features for XGMAC Core 3.20

GONG, Ruiqi (3):
      alx: fix OOB-read compiler warning
      netfilter: ebtables: fix fortify warnings in size_entry_mwt()
      netfilter: ebtables: replace zero-length array members

Gabor Juhos (1):
      net: phy: Introduce PSGMII PHY interface mode

Gal Pressman (3):
      rtnetlink: Move nesting cancellation rollback to proper function
      net/mlx5: Fix typo reminder -> remainder
      net/mlx5: Remove health syndrome enum duplication

Gavin Li (3):
      virtio_net: extract interrupt coalescing settings to a structure
      virtio_net: support per queue interrupt coalesce command
      virtio_net: enable per queue interrupt coalesce feature

Geert Uytterhoeven (1):
      bcmasp: BCMASP should depend on ARCH_BRCMSTB

Geliang Tang (19):
      selftests: mptcp: set all env vars as local ones
      selftests: mptcp: add fastclose env var
      selftests: mptcp: add fullmesh env var
      selftests: mptcp: add speed env var
      bpf: Drop useless btf_vmlinux in bpf_tcp_ca
      bpf: Add update_socket_protocol hook
      selftests/bpf: Add two mptcp netns helpers
      selftests/bpf: Fix error checks of mptcp open_and_load
      selftests/bpf: Add mptcpify test
      mptcp: refactor push_pending logic
      mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
      mptcp: add struct mptcp_sched_ops
      mptcp: add a new sysctl scheduler
      mptcp: add sched in mptcp_sock
      mptcp: add scheduled in mptcp_subflow_context
      mptcp: add scheduler wrappers
      mptcp: use get_send wrapper
      mptcp: use get_retrans wrapper
      mptcp: register default scheduler

Gerhard Uttenthaler (1):
      MAINTAINERS: Add myself as maintainer of the ems_pci.c driver

Gregory Greenman (1):
      wifi: iwlwifi: add Razer to ppag approved list

Grygorii Strashko (2):
      net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode
      net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support

Guangguan Wang (6):
      net/smc: support smc release version negotiation in clc handshake
      net/smc: add vendor unique experimental options area in clc handshake
      net/smc: support smc v2.x features validate
      net/smc: support max connections per lgr negotiation
      net/smc: support max links per lgr negotiation in clc handshake
      net/smc: Extend SMCR v2 linkgroup netlink attribute

Guillaume Nault (7):
      security: Constify sk in the sk_getsecid hook.
      ipv4: Constify the sk parameter of ip_route_output_*().
      ipv6: Constify the sk parameter of several helper functions.
      pptp: Constify the po parameter of pptp_route_output().
      gtp: Set TOS and routing scope independently for fib lookups.
      dccp: Set TOS and routing scope independently for fib lookups.
      sctp: Set TOS and routing scope independently for fib lookups.

Gustavo A. R. Silva (4):
      i40e: Replace one-element array with flex-array member in struct i40e_package_header
      i40e: Replace one-element array with flex-array member in struct i40e_profile_segment
      i40e: Replace one-element array with flex-array member in struct i40e_section_table
      i40e: Replace one-element array with flex-array member in struct i40e_profile_aq_section

Haiyang Zhang (1):
      net: mana: Add page pool for RX buffers

Hangbin Liu (6):
      IPv6: add extack info for IPv6 address add/delete
      selftests: vrf_route_leaking: remove ipv6_ping_frag from default testing
      ipv6: do not match device when remove source route
      selftests: fib_test: add a test case for IPv6 source address delete
      IPv4: add extack info for IPv4 address add/delete
      bonding: update port speed when getting bond speed

Hannes Reinecke (7):
      net/tls: handle MSG_EOR for tls_sw TX flow
      net/tls: handle MSG_EOR for tls_device TX flow
      selftests/net/tls: add test for MSG_EOR
      net/tls: Use tcp_read_sock() instead of ops->read_sock()
      net/tls: split tls_rx_reader_lock
      net/tls: implement ->read_sock()
      net/tls: avoid TCP window full during ->read_sock()

Hao Luo (1):
      libbpf: Free btf_vmlinux when closing bpf_object

Hariprasad Kelam (6):
      docs: octeontx2: extend documentation for Round Robin scheduling
      octeontx2-pf: Allow both ntuple and TC features on the interface
      octeontx2-af: CN10KB: fix PFC configuration
      octeontx2-af: CN10KB: Add USGMII LMAC mode
      octeontx2-af: Add validation of lmac
      octeontx2-af: print error message incase of invalid pf mapping

Hayes Wang (2):
      r8152: adjust generic_ocp_write function
      r8152: set bp in bulk

Heiner Kallweit (1):
      r8169: fix ASPM-related issues on a number of systems with NIC version from RTL8168h

Helge Deller (1):
      bpf/tests: Enhance output on error and fix typos

Herbert Xu (1):
      wifi: mac80211: Do not include crypto/algapi.h

Hilda Wu (2):
      Bluetooth: btrtl: Add Realtek devcoredump support
      Bluetooth: msft: Extended monitor tracking by address filter

Hou Tao (7):
      bpf: Remove unnecessary ring buffer size check
      selftests/bpf: Add benchmark for bpf memory allocator
      bpf: Add object leak check.
      bpf, cpumap: Remove unused cmap field from bpf_cpu_map_entry
      bpf, devmap: Remove unused dtab field from bpf_dtab_netdev
      bpf, cpumap: Use queue_rcu_work() to remove unnecessary rcu_barrier()
      bpf, cpumask: Clean up bpf_cpu_map_entry directly in cpu_map_free

Howard Hsu (1):
      wifi: mt76: mt7996: increase tx token size

Ido Schimmel (25):
      mlxsw: reg: Add Policy-Engine Port Range Register
      mlxsw: resource: Add resource identifier for port range registers
      mlxsw: spectrum_port_range: Add port range core
      mlxsw: spectrum_port_range: Add devlink resource support
      mlxsw: spectrum_acl: Add port range key element
      mlxsw: spectrum_acl: Pass main driver structure to mlxsw_sp_acl_rulei_destroy()
      mlxsw: spectrum_flower: Add ability to match on port ranges
      selftests: mlxsw: Add scale test for port ranges
      selftests: mlxsw: Test port range registers' occupancy
      selftests: forwarding: Add test cases for flower port range matching
      ip_tunnels: Add nexthop ID field to ip_tunnel_key
      vxlan: Add support for nexthop ID metadata
      bridge: Add backup nexthop ID support
      selftests: net: Add bridge backup port and backup nexthop ID test
      mlxsw: reg: Remove unused function argument
      mlxsw: reg: Increase Management Cable Info Access Register length
      mlxsw: core_env: Read transceiver module EEPROM in 128 bytes chunks
      mlxsw: core_acl_flex_actions: Add IGNORE_ACTION
      mlxsw: spectrum_flower: Disable learning and security lookup when redirecting
      mlxsw: spectrum: Stop ignoring learning notifications from redirected traffic
      selftests: forwarding: Add test case for traffic redirection from a locked port
      nexthop: Simplify nexthop bucket dump
      nexthop: Do not increment dump sentinel at the end of the dump
      vxlan: vnifilter: Use GFP_KERNEL instead of GFP_ATOMIC
      vrf: Remove unnecessary RCU-bh critical section

Itamar Gozlan (1):
      net/mlx5: DR, Supporting inline WQE when possible

Iulia Tanasescu (4):
      Bluetooth: ISO: Add support for connecting multiple BISes
      Bluetooth: ISO: Support multiple BIGs
      Bluetooth: ISO: Notify user space about failed bis connections
      Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync

Ivan Vecera (2):
      i40e: Add helper for VF inited state check with timeout
      i40e: Wait for pending VF reset in VF set callbacks

Jackie Liu (2):
      libbpf: Cross-join available_filter_functions and kallsyms for multi-kprobes
      libbpf: Use available_filter_functions_addrs with multi-kprobes

Jacob Keller (3):
      ice: Correctly initialize queue context values
      ice: move E810T functions to before device agnostic ones
      ice: avoid executing commands on other ports when driving sync

Jakub Kicinski (144):
      Merge branch 'net-freescale-convert-to-platform-remove-callback-returning-void'
      Merge branch 'mlxsw-add-port-range-matching-support'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'selftests-mptcp-join-pass-args-in-new-env-vars'
      Merge branch 'net-stmmac-replace-boolean-fields-in-plat_stmmacenet_data-with-flags'
      Merge branch 'net-mana-fix-doorbell-access-for-receive-queues'
      Merge branch 'remove-unnecessary-void-conversions'
      Merge tag 'linux-can-next-for-6.6-20230719' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge tag 'ipsec-next-2023-07-19' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next
      Merge branch 'net-stmmac-improve-driver-statistics'
      Merge branch 'clean-up-the-fec-driver'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      eth: bnxt: move and rename reset helpers
      eth: bnxt: take the bit to set as argument of bnxt_queue_sp_work()
      eth: bnxt: handle invalid Tx completions more gracefully
      Merge branch 'eth-bnxt-handle-invalid-tx-completions-more-gracefully'
      Merge branch 'nexthop-refactor-and-fix-nexthop-selection-for-multipath-routes'
      eth: tsnep: let page recycling happen with skbs
      eth: stmmac: let page recycling happen with skbs
      net: page_pool: hide page_pool_release_page()
      net: page_pool: merge page_pool_release_page() with page_pool_return_page()
      Merge branch 'net-page_pool-remove-page_pool_release_page'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'mlxsw-speed-up-transceiver-module-eeprom-dump'
      Merge branch 'net-ethernet-mtk_eth_soc-add-basic-support-for-mt7988-soc'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-tls-fixes-for-nvme-over-tls'
      Merge tag 'nf-next-23-07-27' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'net-stmmac-increase-clk_ptp_ref-rate'
      Revert "net: stmmac: correct MAC propagation delay"
      Merge branch 'ynl-couple-of-unrelated-fixes'
      net: store netdevs in an xarray
      net: convert some netlink netdev iterators to depend on the xarray
      Merge branch 'net-store-netdevs-in-an-xarray'
      Merge branch 'mlxsw-avoid-non-tracker-helpers-when-holding-and-putting-netdevices'
      Merge tag 'mlx5-updates-2023-07-24' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      eth: bnxt: fix one of the W=1 warnings about fortified memcpy()
      eth: bnxt: fix warning for define in struct_group
      Merge branch 'eth-bnxt-fix-a-couple-of-w-1-c-1-warnings'
      Merge branch 'in-kernel-support-for-the-tls-alert-protocol'
      Merge branch 'r8152-reduce-control-transfer'
      Merge branch 'connector-proc_filter-test-fixes'
      Merge branch 'mptcp-cleanup-and-improvements-in-the-selftests'
      net: make sure we never create ifindex = 0
      Merge branch 'virtio_net-add-per-queue-interrupt-coalescing-support'
      Merge branch 'add-tja1120-support'
      Merge branch 'mlx5-ipsec-packet-offload-support-in-eswitch-mode'
      Merge branch 'net-extend-alloc_skb_with_frags-max-size'
      Merge branch 'introduce-ndo_hwtstamp_get-and-ndo_hwtstamp_set'
      eth: add missing xdp.h includes in drivers
      net: move struct netdev_rx_queue out of netdevice.h
      net: invert the netdevice.h vs xdp.h dependency
      docs: net: page_pool: document PP_FLAG_DMA_SYNC_DEV parameters
      docs: net: page_pool: use kdoc to avoid duplicating the information
      Merge branch 'docs-net-page_pool-sync-dev-and-kdoc'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      eth: dpaa: add missing net/xdp.h include
      Merge branch 'devlink-use-spec-to-generate-split-ops'
      Merge branch 'tcp-disable-header-prediction-for-md5'
      Merge tag 'wireless-next-2023-08-04' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'net-stmmac-correct-mac-propagation-delay'
      Merge tag 'linux-can-next-for-6.6-20230807' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      page_pool: add a lockdep check for recycling in hardirq
      Merge branch 'page_pool-a-couple-of-assorted-optimizations'
      Merge branch 'octeontx2-af-tc-flower-offload-changes'
      Merge branch 'net-remove-redundant-initialization-owner'
      Merge branch 'net-fs_enet-driver-cleanup'
      Merge branch 'team-do-some-cleanups-in-team-driver'
      Merge branch 'bnxt_en-fix-2-compile-warnings-in-bnxt_dcb-c'
      Merge branch 'net-renesas-rswitch-add-speed-change-support'
      docs: net: page_pool: de-duplicate the intro comment
      Merge tag 'mlx5-updates-2023-08-07' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      tools: ynl-gen: add missing empty line between policies
      Merge tag 'nf-next-2023-08-08' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'mlxsw-set-port-stp-state-on-bridge-enslavement'
      Merge branch 'remove-redundant-functions-and-use-generic-functions'
      Merge branch 'mlx5-expose-nic-temperature-via-hwmon-api'
      Merge branch 'improve-the-taprio-qdisc-s-relationship-with-its-children'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'update-stmmac-fix_mac_speed'
      Merge branch 'support-offload-led-blinking-to-phy'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'devlink-introduce-selective-dumps'
      genetlink: push conditional locking into dumpit/done
      genetlink: make genl_info->nlhdr const
      genetlink: remove userhdr from struct genl_info
      genetlink: add struct genl_info to struct genl_dumpit_info
      genetlink: use attrs from struct genl_info
      genetlink: add a family pointer to struct genl_info
      genetlink: add genlmsg_iput() API
      netdev-genl: use struct genl_info for reply construction
      ethtool: netlink: simplify arguments to ethnl_default_parse()
      ethtool: netlink: always pass genl_info to .prepare_data
      Merge branch 'genetlink-provide-struct-genl_info-to-dumps'
      Merge branch 'seg6-add-next-c-sid-support-for-srv6-end-x-behavior'
      Merge branch 'nexthop-various-cleanups'
      eth: r8152: try to use a normal budget
      net: warn about attempts to register negative ifindex
      netlink: specs: add ovs_vport new command
      tools: ynl: add more info to KeyErrors on missing attrs
      Merge branch 'net-warn-about-attempts-to-register-negative-ifindex'
      Merge tag 'mlx5-updates-2023-08-14' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Revert "net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode"
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'netem-use-a-seeded-prng-for-loss-and-corruption-events'
      Merge branch 'netconsole-enable-compile-time-configuration'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'batadv-next-pullrequest-20230816' of git://git.open-mesh.org/linux-merge
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'bnxt_en-update-for-net-next'
      Revert "pds_core: Fix some kernel-doc comments"
      Merge tag 'mlx5-updates-2023-08-16' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch 'mptcp-prepare-mptcp-packet-scheduler-for-bpf-extension'
      Merge tag 'nf-next-23-08-22' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      bnxt: use the NAPI skb allocation cache
      Merge branch 'net-ethernet-mtk_eth_soc-improve-support-for-mt7988'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      docs: netdev: recommend against --in-reply-to
      Merge branch 'mlx5-next' of https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      tools: ynl: allow passing binary data
      tools: ynl-gen: set length of binary fields
      tools: ynl-gen: fix collecting global policy attrs
      tools: ynl-gen: support empty attribute lists
      netlink: specs: fix indent in fou
      Merge branch 'tools-ynl-handful-of-forward-looking-updates'
      Merge tag 'for-net-next-2023-08-24' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Merge tag 'wireless-next-2023-08-25' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'fix-pfc-related-issues'
      Merge branch 'stmmac-cleanups'
      tools: ynl-gen: fix uAPI generation after tempfile changes
      Merge branch 'pds_core-error-handling-fixes'
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'devlink-mlx5-add-port-function-attributes-for-ipsec'
      Merge branch 'tools-net-ynl-add-support-for-netlink-raw-families'
      Merge branch 'tls-expand-tls_cipher_size_desc-to-simplify-getsockopt-setsockopt'
      Merge branch 'devlink-finish-file-split-and-get-retire-leftover-c'

Jan Sokolowski (9):
      i40e: remove i40e_status
      ice: add FW load wait
      ice: remove unused methods
      ice: refactor ice_ddp to make functions static
      ice: refactor ice_lib to make functions static
      ice: refactor ice_vf_lib to make functions static
      ice: refactor ice_sched to make functions static
      ice: refactor ice_ptp_hw to make functions static
      ice: refactor ice_vsi_is_vlan_pruning_ena

Jann Horn (1):
      dccp: Fix out of bounds access in DCCP error handler

Jeff Johnson (5):
      wifi: Fix ieee80211.h kernel-doc issues
      wifi: ath11k: Consistently use ath11k_vif_to_arvif()
      wifi: ath10k: Fix a few spelling errors
      wifi: ath11k: Fix a few spelling errors
      wifi: ath12k: Fix a few spelling errors

Jeremy Sowden (1):
      lib/ts_bm: add helper to reduce indentation and improve readability

Jesper Dangaard Brouer (2):
      gve: trivial spell fix Recive to Receive
      net: use SLAB_NO_MERGE for kmem_cache skbuff_head_cache

Jialin Zhang (1):
      net: ena: Use pci_dev_id() to simplify the code

Jian Wen (1):
      tcp: add a scheduling point in established_get_first()

Jianbo Liu (14):
      net/mlx5e: Add function to get IPsec offload namespace
      net/mlx5e: Change the parameter of IPsec RX skb handle function
      net/mlx5e: Prepare IPsec packet offload for switchdev mode
      net/mlx5e: Refactor IPsec RX tables creation and destruction
      net/mlx5e: Support IPsec packet offload for RX in switchdev mode
      net/mlx5e: Handle IPsec offload for RX datapath in switchdev mode
      net/mlx5e: Refactor IPsec TX tables creation
      net/mlx5e: Support IPsec packet offload for TX in switchdev mode
      net/mlx5: Compare with old_dest param to modify rule destination
      net/mlx5e: Make IPsec offload work together with eswitch and TC
      net/mlx5e: Modify and restore TC rules for IPSec TX rules
      net/mlx5e: Add get IPsec offload stats for uplink representor
      net/mlx5e: Make TC and IPsec offloads mutually exclusive on a netdev
      net/mlx5: E-switch, Add checking for flow rule destinations

Jiawen Wu (9):
      net: txgbe: change LAN reset mode
      net: pcs: xpcs: add specific vendor supoprt for Wangxun 10Gb NICs
      net: pcs: xpcs: support to switch mode for Wangxun NICs
      net: pcs: xpcs: add 1000BASE-X AN interrupt support
      net: pcs: xpcs: adapt Wangxun NICs for SGMII mode
      net: txgbe: add FW version warning
      net: txgbe: support switching mode to 1000BASE-X and SGMII
      net: txgbe: support copper NIC with external PHY
      net: ngbe: move mdio access registers to libwx

Jijie Shao (4):
      net: hns3: move dump regs function to a separate file
      net: hns3: Support tlv in regs data for HNS3 PF driver
      net: hns3: Support tlv in regs data for HNS3 VF driver
      net: hns3: fix wrong rpu tln reg issue

Jimmy Assarsson (2):
      can: kvaser_pciefd: Move hardware specific constants and functions into a driver_data struct
      can: kvaser_pciefd: Add support for new Kvaser pciefd devices

Jing Cai (2):
      Bluetooth: btmtk: introduce btmtk reset work
      Bluetooth: btusb: mediatek: add MediaTek devcoredump support

Jinjie Ruan (4):
      dp83640: Use list_for_each_entry() helper
      Bluetooth: btusb: Do not call kfree_skb() under spin_lock_irqsave()
      net: arcnet: Do not call kfree_skb() under local_irq_disable()
      wifi: rtlwifi: rtl8723: Remove unused function rtl8723_cmd_send_packet()

Jiri Olsa (31):
      bpf: Add support for bpf_get_func_ip helper for uprobe program
      selftests/bpf: Add bpf_get_func_ip tests for uprobe on function entry
      selftests/bpf: Add bpf_get_func_ip test for uprobe inside function
      bpf: Switch BPF_F_KPROBE_MULTI_RETURN macro to enum
      bpf: Add attach_type checks under bpf_prog_attach_check_attach_type
      bpf: Add multi uprobe link
      bpf: Add cookies support for uprobe_multi link
      bpf: Add pid filter support for uprobe_multi link
      bpf: Add bpf_get_func_ip helper support for uprobe link
      libbpf: Add uprobe_multi attach type and link names
      libbpf: Move elf_find_func_offset* functions to elf object
      libbpf: Add elf_open/elf_close functions
      libbpf: Add elf symbol iterator
      libbpf: Add elf_resolve_syms_offsets function
      libbpf: Add elf_resolve_pattern_offsets function
      libbpf: Add bpf_link_create support for multi uprobes
      libbpf: Add bpf_program__attach_uprobe_multi function
      libbpf: Add support for u[ret]probe.multi[.s] program sections
      libbpf: Add uprobe multi link detection
      libbpf: Add uprobe multi link support to bpf_program__attach_usdt
      selftests/bpf: Move get_time_ns to testing_helpers.h
      selftests/bpf: Add uprobe_multi skel test
      selftests/bpf: Add uprobe_multi api test
      selftests/bpf: Add uprobe_multi link test
      selftests/bpf: Add uprobe_multi test program
      selftests/bpf: Add uprobe_multi bench test
      selftests/bpf: Add uprobe_multi usdt test code
      selftests/bpf: Add uprobe_multi usdt bench test
      selftests/bpf: Add uprobe_multi cookie test
      selftests/bpf: Add uprobe_multi pid filter tests
      selftests/bpf: Add extra link to uprobe_multi tests

Jiri Pirko (71):
      devlink: remove reload failed checks in params get/set callbacks
      genetlink: add explicit ordering break check for split ops
      net/mlx5: Don't check vport->enabled in port ops
      net/mlx5: Remove pointless devlink_rate checks
      net/mlx5: Make mlx5_esw_offloads_rep_load/unload() static
      net/mlx5: Make mlx5_eswitch_load/unload_vport() static
      net/mlx5: Give esw_offloads_load/unload_rep() "mlx5_" prefix
      netlink: specs: add dump-strict flag for dont-validate property
      ynl-gen-c.py: filter rendering of validate field values for split ops
      ynl-gen-c.py: allow directional model for kernel mode
      ynl-gen-c.py: render netlink policies static for split ops
      devlink: rename devlink_nl_ops to devlink_nl_small_ops
      devlink: rename couple of doit netlink callbacks to match generated names
      devlink: introduce couple of dumpit callbacks for split ops
      devlink: un-static devlink_nl_pre/post_doit()
      netlink: specs: devlink: add info-get dump op
      devlink: add split ops generated according to spec
      devlink: include the generated netlink header
      devlink: use generated split ops and remove duplicated commands from small ops
      tools: ynl-gen: avoid rendering empty validate field
      devlink: clear flag on port register error path
      devlink: parse linecard attr in doit() callbacks
      devlink: parse rate attrs in doit() callbacks
      devlink: introduce devlink_nl_pre_doit_port*() helper functions
      devlink: rename doit callbacks for per-instance dump commands
      devlink: introduce dumpit callbacks for split ops
      devlink: pass flags as an arg of dump_one() callback
      netlink: specs: devlink: add commands that do per-instance dump
      devlink: remove duplicate temporary netlink callback prototypes
      devlink: remove converted commands from small ops
      devlink: allow user to narrow per-instance dumps by passing handle attrs
      netlink: specs: devlink: extend per-instance dump commands to accept instance attributes
      devlink: extend health reporter dump selector by port index
      netlink: specs: devlink: extend health reporter dump attributes by port index
      net/mlx5: Use auxiliary_device_uninit() instead of device_put()
      net/mlx5: Remove redundant SF supported check from mlx5_sf_hw_table_init()
      net/mlx5: Use mlx5_sf_start_function_id() helper instead of directly calling MLX5_CAP_GEN()
      net/mlx5: Remove redundant check of mlx5_vhca_event_supported()
      net/mlx5: Fix error message in mlx5_sf_dev_state_change_handler()
      tools: ynl-gen: use temporary file for rendering
      net/mlx5: Call mlx5_esw_offloads_rep_load/unload() for uplink port directly
      net/mlx5: Remove VPORT_UPLINK handling from devlink_port.c
      net/mlx5: Rename devlink port ops struct for PFs/VFs
      net/mlx5: Rework devlink port alloc/free into init/cleanup
      net/mlx5: Push out SF devlink port init and cleanup code to separate helpers
      net/mlx5: Push devlink port PF/VF init/cleanup calls out of devlink_port_register/unregister()
      net/mlx5: Allow mlx5_esw_offloads_devlink_port_register() to register SFs
      net/mlx5: Introduce mlx5_eswitch_load/unload_sf_vport() and use it from SF code
      net/mlx5: Remove no longer used mlx5_esw_offloads_sf_vport_enable/disable()
      net/mlx5: Don't register ops for non-PF/VF/SF port and avoid checks in ops
      net/mlx5: Embed struct devlink_port into driver structure
      net/mlx5: Reduce number of vport lookups passing vport pointer instead of index
      net/mlx5: Return -EOPNOTSUPP in mlx5_devlink_port_fn_migratable_set() directly
      net/mlx5: Relax mlx5_devlink_eswitch_get() return value checking
      net/mlx5: Check vhca_resource_manager capability in each op and add extack msg
      net/mlx5: Store vport in struct mlx5_devlink_port and use it in port ops
      devlink: push object register/unregister notifications into separate helpers
      devlink: push port related code into separate file
      devlink: push shared buffer related code into separate file
      devlink: move and rename devlink_dpipe_send_and_alloc_skb() helper
      devlink: push dpipe related code into separate file
      devlink: push resource related code into separate file
      devlink: push param related code into separate file
      devlink: push region related code into separate file
      devlink: use tracepoint_enabled() helper
      devlink: push trap related code into separate file
      devlink: push rate related code into separate file
      devlink: push linecard related code into separate file
      devlink: move tracepoint definitions into core.c
      devlink: move small_ops definition into netlink.c
      devlink: move devlink_notify_register/unregister() to dev.c

Jisheng Zhang (2):
      net: stmmac: don't clear network statistics in .ndo_open()
      net: stmmac: use per-queue 64 bit statistics where necessary

Joe Damato (2):
      net: ethtool: Unify ETHTOOL_{G,S}RXFH rxnfc copy
      net/mlx5: Fix flowhash key set/get for custom RSS

Johannes Berg (17):
      wifi: iwlwifi: mvm: advertise MLO only if EHT is enabled
      wifi: iwlwifi: api: fix a small upper/lower-case typo
      wifi: iwlwifi: remove WARN from read_mem32()
      wifi: iwlwifi: pcie: clean up gen1/gen2 TFD unmap
      wifi: iwlwifi: remove 'def_rx_queue' struct member
      wifi: iwlwifi: pcie: move gen1 TB handling to header
      wifi: iwlwifi: queue: move iwl_txq_gen2_set_tb() up
      wifi: iwlwifi: pcie: point invalid TFDs to invalid data
      wifi: iwlwifi: mvm: enable HE TX/RX <242 tone RU on new RFs
      wifi: iwlwifi: mvm: support flush on AP interfaces
      wifi: mac80211: check S1G action frame size
      wifi: cfg80211: reject auth/assoc to AP with our address
      wifi: cfg80211: ocb: don't leave if not joined
      wifi: mac80211: check for station first in client probe
      wifi: mac80211_hwsim: drop short frames
      wifi: mac80211: fix puncturing bitmap handling in CSA
      Revert "wifi: mac80211_hwsim: check the return value of nla_put_u32"

Johannes Wiesboeck (1):
      wifi: mwifiex: Set WIPHY_FLAG_NETNS_OK flag

Johannes Zink (3):
      net: stmmac: correct MAC propagation delay
      net: stmmac: correct MAC propagation delay
      net: stmmac: dwmac-imx: enable MAC propagation delay correction for i.MX8MP

John Sanpe (1):
      libbpf: Remove HASHMAP_INIT static initialization helper

John Watts (4):
      dt-bindings: net: can: Add support for Allwinner D1 CAN controller
      riscv: dts: allwinner: d1: Add CAN controller nodes
      can: sun4i_can: Add acceptance register quirk
      can: sun4i_can: Add support for the Allwinner D1

Jordan Rife (1):
      net: Avoid address overwrite in kernel_connect

Jose E. Marchesi (1):
      bpf, docs: fix BPF_NEG entry in instruction-set.rst

Jose Ignacio Tornos Martinez (1):
      net: wwan: t7xx: Add AP CLDMA

Judith Mendez (2):
      dt-bindings: net: can: Remove interrupt properties for MCAN
      can: m_can: Add hrtimer to generate software interrupt

Justin Chen (9):
      dt-bindings: net: brcm,unimac-mdio: Add asp-v2.0
      net: bcmasp: Add support for ASP2.0 Ethernet controller
      net: bcmasp: Add support for WoL magic packet
      net: bcmasp: Add support for wake on net filters
      net: bcmasp: Add support for eee mode
      net: bcmasp: Add support for ethtool standard stats
      net: bcmasp: Add support for ethtool driver stats
      net: phy: mdio-bcm-unimac: Add asp v2.0 support
      MAINTAINERS: ASP 2.0 Ethernet driver maintainers

Justin Stitt (9):
      net: mdio: fix -Wvoid-pointer-to-enum-cast warning
      wifi: ipw2x00: refactor to use kstrtoul
      netfilter: ipset: refactor deprecated strncpy
      netfilter: nf_tables: refactor deprecated strncpy
      netfilter: nf_tables: refactor deprecated strncpy
      netfilter: nft_osf: refactor deprecated strncpy
      netfilter: nft_meta: refactor deprecated strncpy
      netfilter: x_tables: refactor deprecated strncpy
      netfilter: xtables: refactor deprecated strncpy

Jörn-Thorben Hinz (1):
      net: Remove leftover include from nftables.h

Kai-Heng Feng (1):
      e1000e: Use PME poll to circumvent unreliable ACPI wake

Kalle Valo (3):
      Merge tag 'mt76-for-kvalo-2023-07-31' of https://github.com/nbd168/wireless
      Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
      Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

Karol Kolacinski (1):
      ice: Add get C827 PHY index function

Kees Cook (7):
      wifi: cfg80211: Annotate struct cfg80211_acl_data with __counted_by
      wifi: cfg80211: Annotate struct cfg80211_cqm_config with __counted_by
      wifi: cfg80211: Annotate struct cfg80211_mbssid_elems with __counted_by
      wifi: cfg80211: Annotate struct cfg80211_pmsr_request with __counted_by
      wifi: cfg80211: Annotate struct cfg80211_rnr_elems with __counted_by
      wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by
      wifi: cfg80211: Annotate struct cfg80211_tid_config with __counted_by

Kiran K (3):
      Bluetooth: btintel: Add support to reset bluetooth via ACPI DSM
      Bluetooth: btintel: Add support for Gale Peak
      Bluetooth: Add support for Gale Peak (8087:0036)

Krzysztof Kozlowski (6):
      dt-bindings: net: qca,ar803x: add missing unevaluatedProperties for each regulator
      net/xgene: fix Wvoid-pointer-to-enum-cast warning
      net/marvell: fix Wvoid-pointer-to-enum-cast warning
      wifi: ath11k: fix Wvoid-pointer-to-enum-cast warning
      wifi: ath10k: fix Wvoid-pointer-to-enum-cast warning
      net: dsa: use capital "OR" for multiple licenses in SPDX

Kuan-Chung Chen (1):
      wifi: rtw89: Introduce Time Averaged SAR (TAS) feature

Kui-Feng Lee (8):
      bpf, net: Check skb ownership against full socket.
      selftests/bpf: Verify that the cgroup_skb filters receive expected packets.
      selftests/bpf: fix the incorrect verification of port numbers.
      bpf: fix inconsistent return types of bpf_xdp_copy_buf().
      bpf: fix bpf_dynptr_slice() to stop return an ERR_PTR.
      selftests/bpf: remove duplicated functions
      net/ipv6: Remove expired routes with a separated list of routes.
      selftests: fib_tests: Add a test case for IPv6 garbage collection

Kumar Kartikeya Dwivedi (2):
      bpf: Fix check_func_arg_reg_off bug for graph root/node
      selftests/bpf: Add test for bpf_obj_drop with bad reg->off

Kuniyuki Iwashima (6):
      ipv6: rpl: Remove redundant skb_dst_drop().
      net: Use sockaddr_storage for getsockopt(SO_PEERNAME).
      tcp: Disable header prediction for MD5 flow.
      tcp: Update stale comment for MD5 in tcp_parse_options().
      mptcp: Remove unnecessary test for __mptcp_init_sock()
      netrom: Deny concurrent connect().

Kurt Kanzenbach (2):
      net: dsa: hellcreek: Replace bogus comment
      stmmac: intel: Enable correction of MAC propagation delay

Larry Finger (1):
      wifi: rtw89: Fix loading of compressed firmware

Lee, Chun-Yi (1):
      Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO

Leon Hwang (2):
      bpf, xdp: Add tracepoint to xdp attaching failure
      selftests/bpf: Add testcase for xdp attaching failure tracepoint

Leon Romanovsky (10):
      xfrm: delete not-needed clear to zero of encap_oa
      net/mlx5: Add relevant capabilities bits to support NAT-T
      net/mlx5e: Check for IPsec NAT-T support
      net/mlx5e: Support IPsec NAT-T functionality
      xfrm: Support UDP encapsulation in packet offload mode
      net/mlx5e: Support IPsec upper TCP protocol selector
      net/mlx5: Drop extra layer of locks in IPsec
      net/mlx5e: Rewrite IPsec vs. TC block interface
      net/mlx5: Add IFC bits to support IPsec enable/disable
      net/mlx5: Provide an interface to block change of IPsec capabilities

Li Zetao (15):
      net: microchip: vcap api: Use ERR_CAST() in vcap_decode_rule()
      net: dpaa2-eth: Remove redundant initialization owner in dpaa2_eth_driver
      net: dpaa2-switch: Remove redundant initialization owner in dpaa2_switch_drv
      bcm63xx_enet: Remove redundant initialization owner
      ethernet: s2io: Use ether_addr_to_u64() to convert ethernet address
      octeontx2-af: Remove redundant functions mac2u64() and cfg2mac()
      octeontx2-af: Use u64_to_ether_addr() to convert ethernet address
      octeontx2-af: Remove redundant functions rvu_npc_exact_mac2u64()
      net: mhi: Remove redundant initialization owner in mhi_net_driver
      net: macsec: Use helper functions to update stats
      vxlan: Use helper functions to update stats
      nfc: virtual_ncidev: Use module_misc_device macro to simplify the code
      net/mlx5: Devcom, only use devcom after NULL check in mlx5_devcom_send_event()
      wifi: wfx: Use devm_kmemdup to replace devm_kmalloc + memcpy
      wifi: wlcore: sdio: Use module_sdio_driver macro to simplify the code

Li kunyu (1):
      bpf: bpf_struct_ops: Remove unnecessary initial values of variables

Liang Chen (1):
      veth: Avoid NAPI scheduling on failed SKB forwarding

Lin Ma (4):
      wifi: mt76: testmode: add nla_policy for MT76_TM_ATTR_TX_LENGTH
      netfilter: conntrack: validate cta_ip via parsing
      rtnetlink: remove redundant checks for nlattr IFLA_BRIDGE_MODE
      wifi: nl80211/cfg80211: add forgotten nla_policy for BSS color attribute

Lokendra Singh (1):
      Bluetooth: btintel: Send new command for PPAG

Long Li (2):
      net: mana: Batch ringing RX queue doorbell on receiving packets
      net: mana: Use the correct WQE count for ringing RQ doorbell

Lorenz Bauer (9):
      udp: re-score reuseport groups when connected sockets are present
      bpf: reject unhashed sockets in bpf_sk_assign
      net: export inet_lookup_reuseport and inet6_lookup_reuseport
      net: remove duplicate reuseport_lookup functions
      net: document inet[6]_lookup_reuseport sk_state requirements
      net: remove duplicate sk_lookup helpers
      bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign
      net: remove duplicate INDIRECT_CALLABLE_DECLARE of udp[6]_ehashfn
      net: Fix slab-out-of-bounds in inet[6]_steal_sock

Lorenzo Bianconi (60):
      net: ethernet: mtk_ppe: add MTK_FOE_ENTRY_V{1,2}_SIZE macros
      wifi: mt76: mt7921: remove macro duplication in regs.h
      wifi: mt76: mt7915: move mib_stats structure in mt76.h
      wifi: mt76: mt7996: rely on mib_stats shared definition
      wifi: mt76: mt7921: rely on mib_stats shared definition
      wifi: mt76: mt7921: make mt7921_mac_sta_poll static
      mt76: mt7996: rely on mt76_sta_stats in mt76_wcid
      wifi: mt76: mt7921: get rid of MT7921_RESET_TIMEOUT marco
      wifi: mt76: mt7915: move sta_poll_list and sta_poll_lock in mt76_dev
      wifi: mt76: mt7603: rely on shared sta_poll_list and sta_poll_lock
      wifi: mt76: mt7615: rely on shared sta_poll_list and sta_poll_lock
      wifi: mt76: mt7996: rely on shared sta_poll_list and sta_poll_lock
      wifi: mt76: mt7921: rely on shared sta_poll_list and sta_poll_lock
      wifi: mt76: mt7915: move poll_list in mt76_wcid
      wifi: mt76: mt7603: rely on shared poll_list field
      wifi: mt76: mt7615: rely on shared poll_list field
      wifi: mt76: mt7996: rely on shared poll_list field
      wifi: mt76: mt7921: rely on shared poll_list field
      wifi: mt76: move ampdu_state in mt76_wcid
      mt76: connac: move more mt7921/mt7915 mac shared code in connac lib
      wifi: mt76: move rate info in mt76_vif
      wifi: mt76: connac: move connac3 definitions in mt76_connac3_mac.h
      wifi: mt76: connac: add connac3 mac library
      wifi: mt76: mt7921: move common register definition in mt792x_regs.h
      wifi: mt76: mt7921: convert acpisar and clc pointers to void
      wifi: mt76: mt7921: rename mt7921_vif in mt792x_vif
      wifi: mt76: mt7921: rename mt7921_sta in mt792x_sta
      wifi: mt76: mt7921: rename mt7921_phy in mt792x_phy
      wifi: mt76: mt7921: rename mt7921_dev in mt792x_dev
      wifi: mt76: mt7921: rename mt7921_hif_ops in mt792x_hif_ops
      wifi: mt76: mt792x: move shared structure definition in mt792x.h
      wifi: mt76: mt7921: move mt792x_mutex_{acquire/release} in mt792x.h
      wifi: mt76: mt7921: move mt792x_hw_dev in mt792x.h
      wifi: mt76: mt792x: introduce mt792x-lib module
      wifi: mt76: mt7921: move mac shared code in mt792x-lib module
      wifi: mt76: mt7921: move dma shared code in mt792x-lib module
      wifi: mt76: mt7921: move debugfs shared code in mt792x-lib module
      wifi: mt76: mt7921: move init shared code in mt792x-lib module
      wifi: mt76: mt792x: introduce mt792x_irq_map
      wifi: mt76: mt792x: move more dma shared code in mt792x_dma
      wifi: mt76: mt7921: move hif_ops macro in mt792x.h
      wifi: mt76: mt7921: move shared runtime-pm code on mt792x-lib
      wifi: mt76: mt7921: move runtime-pm pci code in mt792x-lib
      wifi: mt76: mt7921: move acpi_sar code in mt792x-lib module
      wifi: mt76: mt792x: introduce mt792x-usb module
      wifi: mt76: mt792x: move mt7921_load_firmware in mt792x-lib module
      wifi: mt76: mt76_connac3: move lmac queue enumeration in mt76_connac3_mac.h
      wifi: mt76: mt792x: move MT7921_PM_TIMEOUT and MT7921_HW_SCAN_TIMEOUT in common code
      wifi: mt76: mt7921: move mt7921_dma_init in pci.c
      wifi: mt76: mt7921: move mt7921u_disconnect mt792x-lib
      net: ethernet: mtk_eth_soc: add version in mtk_soc_data
      net: ethernet: mtk_eth_soc: increase MAX_DEVS to 3
      net: ethernet: mtk_eth_soc: rely on MTK_MAX_DEVS and remove MTK_MAC_COUNT
      net: ethernet: mtk_eth_soc: add NETSYS_V3 version support
      net: ethernet: mtk_eth_soc: convert caps in mtk_soc_data struct to u64
      net: ethernet: mtk_eth_soc: add basic support for MT7988 SoC
      net: ethernet: mtk_eth_soc: enable page_pool support for MT7988 SoC
      net: ethernet: mtk_eth_soc: enable nft hw flowtable_offload for MT7988 SoC
      net: ethernet: mtk_wed: add some more info in wed_txinfo_show handler
      net: ethernet: mtk_wed: minor change in wed_{tx,rx}info_show

Louis Peens (1):
      nfp: update maintainer

Lu Hongfei (1):
      selftests/bpf: Correct two typos

Luca Weiss (2):
      dt-bindings: net: qualcomm: Add WCN3988
      Bluetooth: btqca: Add WCN3988 support

Luiz Augusto von Dentz (22):
      Bluetooth: Consolidate code around sk_alloc into a helper function
      Bluetooth: Init sk_peer_* on bt_sock_alloc
      Bluetooth: hci_sock: Forward credentials to monitor
      Bluetooth: hci_conn: Consolidate code for aborting connections
      Bluetooth: hci_sync: Fix not handling ISO_LINK in hci_abort_conn_sync
      Bluetooth: hci_conn: Always allocate unique handles
      Bluetooth: MGMT: Fix always using HCI_MAX_AD_LENGTH
      Bluetooth: af_bluetooth: Make BT_PKT_STATUS generic
      Bluetooth: ISO: Add support for BT_PKT_STATUS
      Bluetooth: btusb: Move btusb_recv_event_intel to btintel
      Bluetooth: hci_sync: Fix handling of HCI_OP_CREATE_CONN_CANCEL
      Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync
      Bluetooth: ISO: Fix not checking for valid CIG/CIS IDs
      Bluetooth: hci_conn: Fix modifying handle while aborting
      Bluetooth: hci_conn: Fix not allowing valid CIS ID
      Bluetooth: hci_core: Make hci_is_le_conn_scanning public
      Bluetooth: hci_conn: Fix hci_le_set_cig_params
      Bluetooth: hci_sync: Introduce PTR_UINT/UINT_PTR macros
      Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync
      Bluetooth: hci_conn: Fix sending BT_HCI_CMD_LE_CREATE_CONN_CANCEL
      Bluetooth: hci_core: Fix missing instances using HCI_MAX_AD_LENGTH
      Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED

Luo Jie (6):
      net: phy: at803x: support qca8081 genphy_c45_pma_read_abilities
      net: phy: at803x: merge qca8081 slave seed function
      net: phy: at803x: enable qca8081 slave seed conditionally
      net: phy: at803x: support qca8081 1G chip type
      net: phy: at803x: remove qca8081 1G fast retrain and slave seed config
      net: phy: at803x: add qca8081 fifo reset on the link changed

MD Danish Anwar (11):
      net: ti: icssg-prueth: Add Firmware Interface for ICSSG Ethernet driver.
      net: ti: icssg-prueth: Add mii helper apis and macros
      net: ti: icssg-prueth: Add Firmware config and classification APIs.
      net: ti: icssg-prueth: Add icssg queues APIs and macros
      dt-bindings: net: Add ICSSG Ethernet
      net: ti: icssg-prueth: Add ICSSG Stats
      net: ti: icssg-prueth: Add Standard network staticstics
      net: ti: icssg-prueth: Add ethtool ops for ICSSG Ethernet driver
      net: ti: icssg-prueth: Add Power management support
      dt-bindings: net: Add ICSS IEP
      dt-bindings: net: Add IEP property in ICSSG

Maciej Fijalkowski (9):
      xsk: prepare both copy and zero-copy modes to co-exist
      xsk: allow core/drivers to test EOP bit
      xsk: add new netlink attribute dedicated for ZC max frags
      xsk: support mbuf on ZC RX
      ice: xsk: add RX multi-buffer support
      xsk: support ZC Tx multi-buffer in batch API
      ice: xsk: Tx multi-buffer support
      selftests/xsk: reset NIC settings to default after running test suite
      net: add missing net_device::xdp_zc_max_segs description

Maciej Żenczykowski (1):
      netfilter: nfnetlink_log: always add a timestamp

Magnus Karlsson (7):
      xsk: add multi-buffer documentation
      selftests/xsk: transmit and receive multi-buffer packets
      selftests/xsk: add basic multi-buffer test
      selftests/xsk: add unaligned mode test for multi-buffer
      selftests/xsk: add invalid descriptor test for multi-buffer
      selftests/xsk: add metadata copy test for multi-buff
      selftests/xsk: add test for too many frags

Maher Sanalla (11):
      net/mlx5: Track the current number of completion EQs
      net/mlx5: Refactor completion IRQ request/release API
      net/mlx5: Use xarray to store and manage completion IRQs
      net/mlx5: Refactor completion IRQ request/release handlers in EQ layer
      net/mlx5: Use xarray to store and manage completion EQs
      net/mlx5: Implement single completion EQ create/destroy methods
      net/mlx5: Introduce mlx5_cpumask_default_spread
      net/mlx5: Add IRQ vector to CPU lookup function
      net/mlx5: Rename mlx5_comp_vectors_count() to mlx5_comp_vectors_max()
      net/mlx5: Handle SF IRQ request in the absence of SF IRQ pool
      net/mlx5: Allocate completion EQs dynamically

Mahmoud Maatuq (2):
      selftests/net: replace manual array size calc with ARRAYSIZE macro.
      wifi: ath5k: ath5k_hw_get_median_noise_floor(): use swap()

Manish Mandlik (1):
      Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_add_adv_monitor()

Mans Rullgard (1):
      Bluetooth: btbcm: add default address for BCM43430A1

Mao Zhu (1):
      can: ucan: Remove repeated word

Marc Kleine-Budde (24):
      Merge patch series "Enable multiple MCAN on AM62x"
      Merge patch series "can: xilinx_can: Add support for reset"
      Merge patch series "can: kvaser_pciefd: Add support for new Kvaser PCI Express devices"
      MAINTAINERS: net: fix sort order
      Merge patch series "Add support for Allwinner D1 CAN controllers"
      can: gs_usb: remove leading space from goto labels
      can: gs_usb: gs_usb_probe(): align block comment
      can: gs_usb: gs_usb_set_timestamp(): remove return statements form void function
      can: gs_usb: uniformly use "parent" as variable name for struct gs_usb
      can: gs_usb: gs_usb_receive_bulk_callback(): make use of netdev
      can: gs_usb: gs_usb_receive_bulk_callback(): make use of stats
      can: gs_usb: gs_usb_receive_bulk_callback(): count RX overflow errors also in case of OOM
      can: gs_usb: gs_can_start_xmit(), gs_can_open(): clean up printouts in error path
      can: gs_usb: gs_can_close(): don't complain about failed device reset during ndo_stop
      can: gs_usb: gs_destroy_candev(): remove not needed usb_kill_anchored_urbs()
      can: gs_usb: gs_usb_disconnect(): remove not needed usb_kill_anchored_urbs()
      Merge patch series "can: gs_usb-cleanups: various clenaups"
      can: rx-offload: rename rx_offload_get_echo_skb() -> can_rx_offload_get_echo_skb_queue_timestamp()
      can: rx-offload: add can_rx_offload_get_echo_skb_queue_tail()
      can: gs_usb: convert to NAPI/rx-offload to avoid OoO reception
      Merge patch series "can: gs_usb: convert to NAPI"
      Merge patch series "can: tcan4x5x: Introduce tcan4552/4553"
      Merge patch "can: esd_usb: Add support for esd CAN-USB/3"
      Revert "riscv: dts: allwinner: d1: Add CAN controller nodes"

Marcin Szycik (5):
      ice: Add guard rule when creating FDB in switchdev
      ice: Add VLAN FDB support in switchdev mode
      ice: Add direction metadata
      ice: Rename enum ice_pkt_flags values
      ice: Remove redundant VSI configuration in eswitch setup

Marco Vedovati (1):
      libbpf: Set close-on-exec flag on gzopen

Mark Brown (1):
      net: dsa: ar9331: Use maple tree register cache

Markus Schneider-Pargmann (6):
      dt-bindings: can: tcan4x5x: Add tcan4552 and tcan4553 variants
      can: tcan4x5x: Remove reserved register 0x814 from writable table
      can: tcan4x5x: Check size of mram configuration
      can: tcan4x5x: Rename ID registers to match datasheet
      can: tcan4x5x: Add support for tcan4552/4553
      can: tcan4x5x: Add error messages in probe

Martin Habets (11):
      sfc: Remove falcon references
      sfc: Remove siena_nic_data and stats
      sfc: Remove support for siena high priority queue
      sfc: Remove EFX_REV_SIENA_A0
      sfc: Remove PTP code for Siena
      sfc: Remove some NIC type indirections that are no longer needed
      sfc: Filter cleanups for Falcon and Siena
      sfc: Remove struct efx_special_buffer
      sfc: Miscellaneous comment removals
      sfc: Cleanups in io.h
      sfc: Remove vfdi.h

Martin KaFai Lau (7):
      Merge branch 'Add SO_REUSEPORT support for TC bpf_sk_assign'
      tcx: Fix splat during dev unregister
      Merge branch 'Remove unused fields in cpumap & devmap'
      Merge branch 'net: struct netdev_rx_queue and xdp.h reshuffling'
      Merge branch 'bpf: Support bpf_get_func_ip helper in uprobes'
      Merge branch 'Update and document struct_ops'
      Merge branch 'bpf: Force to MPTCP'

Mateusz Kowalski (1):
      bonding: support balance-alb with openvswitch

Matt Whitlock (1):
      mt76: mt7921: don't assume adequate headroom for SDIO headers

Matthieu Baerts (17):
      selftests: mptcp: connect: don't stop if error
      selftests: mptcp: userspace pm: don't stop if error
      selftests: mptcp: userspace_pm: fix shellcheck warnings
      selftests: mptcp: userspace_pm: uniform results printing
      selftests: mptcp: userspace_pm: reduce dup code around printf
      selftests: mptcp: lib: format subtests results in TAP
      selftests: mptcp: connect: format subtests results in TAP
      selftests: mptcp: pm_netlink: format subtests results in TAP
      selftests: mptcp: join: format subtests results in TAP
      selftests: mptcp: diag: format subtests results in TAP
      selftests: mptcp: simult flows: format subtests results in TAP
      selftests: mptcp: sockopt: format subtests results in TAP
      selftests: mptcp: userspace_pm: format subtests results in TAP
      selftests: mptcp: join: rework detailed report
      selftests: mptcp: join: colored results
      selftests: mptcp: pm_nl_ctl: always look for errors
      selftests: mptcp: userspace_pm: unmute unexpected errors

Max Chou (2):
      Bluetooth: btrtl: Correct the length of the HCI command for drop fw
      Bluetooth: btrtl: Load FW v2 otherwise FW v1 for RTL8852C

Maxim Georgiev (5):
      net: add NDOs for configuring hardware timestamping
      net: add hwtstamping helpers for stackable net devices
      net: vlan: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
      net: macvlan: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
      net: bonding: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()

MeiChia Chiu (1):
      wifi: mt76: mt7996: add muru support

Menglong Dong (9):
      bnxt_en: use dev_consume_skb_any() in bnxt_tx_int
      bpf, x86: save/restore regs with BPF_DW size
      bpf, x86: allow function arguments up to 12 for TRACING
      selftests/bpf: add testcase for TRACING with 6+ arguments
      bpf, x86: initialize the variable "first_off" in save_args()
      net: tcp: send zero-window ACK when no memory
      net: tcp: allow zero-window ACK update the window
      net: tcp: fix unexcepted socket die when snd_wnd is 0
      net: tcp: refactor the dbg message in tcp_retransmit_timer()

Mengyuan Lou (1):
      net: ngbe: add Wake on Lan support

Michael Chan (6):
      bnxt_en: Fix W=1 warning in bnxt_dcb.c from fortify memcpy()
      bnxt_en: Fix W=stringop-overflow warning in bnxt_dcb.c
      bnxt_en: Increment rx_resets counter in bnxt_disable_napi()
      bnxt_en: Save ring error counters across reset
      bnxt_en: Display the ring error counters under ethtool -S
      bnxt_en: Add tx_resets ring counter

Michal Simek (1):
      dt-bindings: can: xilinx_can: Add reset description

Michal Swiatkowski (2):
      ice: implement bridge port vlan
      ice: implement static version of ageing

Mikhail Kobuk (1):
      ethernet: tg3: remove unreachable code

Min Li (1):
      Bluetooth: Fix potential use-after-free when clear keys

Ming Yen Hsieh (1):
      wifi: mt76: mt7921: fix non-PSC channel scan fail

Minjie Du (3):
      net: mvpp2: debugfs: remove redundant parameter check in three functions
      wifi: ath5k: remove phydir check from ath5k_debug_init_device()
      wifi: ath9k: fix parameter check in ath9k_init_debug()

Moshe Shemesh (1):
      net/mlx5: Check with FW that sync reset completed successfully

Muhammad Husaini Zulkifli (1):
      igc: Add TransmissionOverrun counter

Mukesh Sisodiya (1):
      wifi: iwlwifi: remove memory check for LMAC error address

Muna Sinada (1):
      wifi: ath12k: add EHT PHY modes

Nathan Chancellor (1):
      wifi: rtw89: Fix clang -Wimplicit-fallthrough in rtw89_query_sar()

Naveen Mamindlapalli (3):
      octeontx2-pf: implement transmit schedular allocation algorithm
      sch_htb: Allow HTB quantum parameter in offload mode
      octeontx2-pf: htb offload support for Round Robin scheduling

Neeraj Sanjay Kale (4):
      Bluetooth: btnxpuart: Add support for AW693 chipset
      Bluetooth: btnxpuart: Remove check for CTS low after FW download
      Bluetooth: btnxpuart: Add support for IW624 chipset
      Bluetooth: btnxpuart: Improve inband Independent Reset handling

Neil Armstrong (5):
      net: stmmac: dwmac-oxnas: remove obsolete dwmac glue driver
      dt-bindings: net: oxnas-dwmac: remove obsolete bindings
      dt-bindings: net: bluetooth: qualcomm: document WCN7850 chipset
      Bluetooth: qca: use switch case for soc type behavior
      Bluetooth: qca: add support for WCN7850

Nick Desaulniers (1):
      net/llc/llc_conn.c: fix 4 instances of -Wmissing-variable-declarations

Nicolas Dichtel (1):
      net: handle ARPHRD_PPP in dev_is_mac_header_xmit()

Paolo Abeni (25):
      Merge branch 'remove-some-unused-phylink-legacy'
      udp: use indirect call wrapper for data ready()
      Merge branch 'net-handle-the-exp-removal-problem-with-ovs-upcall-properly'
      Merge branch 'add-a-driver-for-the-marvell-88q2110-phy'
      mptcp: fix rcv buffer auto-tuning
      Merge branch 'remove-legacy-phylink-behaviour'
      Merge branch 'support-udp-encapsulation-in-packet-offload-mode'
      Merge branch 'virtio-vsock-some-updates-for-msg_peek-flag'
      Merge branch 'net-sched-improve-class-lifetime-handling'
      Merge branch 'selftests-openvswitch-add-flow-programming-cases'
      mptcp: avoid unneeded mptcp_token_destroy() calls
      mptcp: avoid additional __inet_stream_connect() call
      mptcp: avoid subflow socket usage in mptcp_get_port()
      net: factor out inet{,6}_bind_sk helpers
      mptcp: mptcp: avoid additional indirection in mptcp_bind()
      net: factor out __inet_listen_sk() helper
      mptcp: avoid additional indirection in mptcp_listen()
      mptcp: avoid additional indirection in mptcp_poll()
      mptcp: avoid unneeded indirection in mptcp_stream_accept()
      mptcp: avoid additional indirection in sockopt
      mptcp: avoid ssock usage in mptcp_pm_nl_create_listen_socket()
      mptcp: change the mpc check helper to return a sk
      mptcp: get rid of msk->subflow
      Merge tag 'mlx5-updates-2023-08-22' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Paolo Lungaroni (1):
      selftests: seg6: add selftest for NEXT-C-SID flavor in SRv6 End.X behavior

Parav Pandit (2):
      net/mlx5e: Remove duplicate code for user flow
      net/mlx5e: Make flow classification filters static

Patrick Rohr (4):
      net: add sysctl accept_ra_min_rtr_lft
      net: remove comment in ndisc_router_discovery
      net: change accept_ra_min_rtr_lft to affect all RA lifetimes
      net: release reference to inet6_dev pointer

Patrisious Haddad (14):
      macsec: add functions to get macsec real netdevice and check offload
      net/mlx5e: Move MACsec flow steering operations to be used as core library
      net/mlx5: Remove dependency of macsec flow steering on ethernet
      net/mlx5e: Rename MACsec flow steering functions/parameters to suit core naming style
      net/mlx5e: Move MACsec flow steering and statistics database from ethernet to core
      net/mlx5: Remove netdevice from MACsec steering
      net/mlx5: Maintain fs_id xarray per MACsec device inside macsec steering
      RDMA/mlx5: Implement MACsec gid addition and deletion
      net/mlx5: Add MACsec priorities in RDMA namespaces
      IB/core: Reorder GID delete code for RoCE
      net/mlx5: Configure MACsec steering for egress RoCEv2 traffic
      net/mlx5: Configure MACsec steering for ingress RoCEv2 traffic
      net/mlx5: Add RoCE MACsec steering infrastructure in core
      RDMA/mlx5: Handles RoCE MACsec steering rules addition and deletion

Paul E. McKenney (1):
      rcu: Export rcu_request_urgent_qs_task()

Paul Fertser (1):
      net: ftgmac100: support getting MAC address from NVMEM

Pauli Virtanen (6):
      Bluetooth: ISO: do not emit new LE Create CIS if previous is pending
      Bluetooth: ISO: handle bound CIS cleanup via hci_conn
      Bluetooth: hci_sync: delete CIS in BT_OPEN/CONNECT/BOUND when aborting
      Bluetooth: hci_event: drop only unbound CIS if Set CIG Parameters fails
      Bluetooth: hci_conn: avoid checking uninitialized CIG/CIS ids
      Bluetooth: hci_conn: fail SCO/ISO via hci_conn_failed if ACL gone early

Pawel Chmielewski (1):
      ice: add tracepoints for the switchdev bridge

Pedro Tammela (5):
      net/sched: wrap open coded Qdics class filter counter
      net/sched: sch_drr: warn about class in use while deleting
      net/sched: sch_hfsc: warn about class in use while deleting
      net/sched: sch_htb: warn about class in use while deleting
      net/sched: sch_qfq: warn about class in use while deleting

Peter Chiu (7):
      wifi: mt76: mt7915: rework tx packets counting when WED is active
      wifi: mt76: mt7915: rework tx bytes counting when WED is active
      wifi: mt76: report non-binding skb tx rate when WED is active
      wifi: mt76: connac: add support for dsp firmware download
      wifi: mt76: mt7996: fix bss wlan_idx when sending bss_info command
      wifi: mt76: mt7996: enable VHT extended NSS BW feature
      wifi: mt76: connac: add support to set ifs time by mcu command

Peter Seiderer (2):
      net: skbuff: remove unused HAVE_HW_TIME_STAMP feature define
      can: peak_usb: remove unused/legacy peak_usb_netif_rx() function

Peter Tsao (1):
      Bluetooth: btusb: Add support Mediatek MT7925

Petr Machata (45):
      mlxsw: spectrum_switchdev: Pass extack to mlxsw_sp_br_ban_rif_pvid_change()
      mlxsw: spectrum_router: Pass struct mlxsw_sp_rif_params to fid_get
      mlxsw: spectrum_router: Take VID for VLAN FIDs from RIF params
      mlxsw: spectrum_router: Adjust mlxsw_sp_inetaddr_vlan_event() coding style
      mlxsw: spectrum_router: mlxsw_sp_inetaddr_bridge_event: Add an argument
      mlxsw: spectrum_switchdev: Manage RIFs on PVID change
      selftests: forwarding: lib: Add ping6_, ping_test_fails()
      selftests: router_bridge: Add tests to remove and add PVID
      selftests: router_bridge_vlan: Add PVID change test
      selftests: router_bridge_vlan_upper_pvid: Add a new selftest
      selftests: router_bridge_pvid_vlan_upper: Add a new selftest
      net: bridge: br_switchdev: Tolerate -EOPNOTSUPP when replaying MDB
      net: switchdev: Add a helper to replay objects on a bridge port
      selftests: mlxsw: rtnetlink: Drop obsolete tests
      mlxsw: spectrum_router: Allow address handlers to run on bridge ports
      mlxsw: spectrum_router: Extract a helper to schedule neighbour work
      mlxsw: spectrum: Split a helper out of mlxsw_sp_netdevice_event()
      mlxsw: spectrum: Allow event handlers to check unowned bridges
      mlxsw: spectrum: Add a replay_deslavement argument to event handlers
      mlxsw: spectrum: On port enslavement to a LAG, join upper's bridges
      mlxsw: spectrum_switchdev: Replay switchdev objects on port join
      mlxsw: spectrum_router: Join RIFs of LAG upper VLANs
      mlxsw: spectrum_router: Offload ethernet nexthops when RIF is made
      mlxsw: spectrum_router: Replay MACVLANs when RIF is made
      mlxsw: spectrum_router: Replay neighbours when RIF is made
      mlxsw: spectrum_router: Replay IP NETDEV_UP on device enslavement
      mlxsw: spectrum_router: Replay IP NETDEV_UP on device deslavement
      mlxsw: spectrum: Permit enslavement to netdevices with uppers
      mlxsw: spectrum: Drop unused functions mlxsw_sp_port_lower_dev_hold/_put()
      mlxsw: spectrum_nve: Do not take reference when looking up netdevice
      mlxsw: spectrum_switchdev: Use tracker helpers to hold & put netdevices
      mlxsw: spectrum_router: FIB: Use tracker helpers to hold & put netdevices
      mlxsw: spectrum_router: hw_stats: Use tracker helpers to hold & put netdevices
      mlxsw: spectrum_router: RIF: Use tracker helpers to hold & put netdevices
      mlxsw: spectrum_router: IPv6 events: Use tracker helpers to hold & put netdevices
      selftests: router_bridge: Add remastering tests
      selftests: router_bridge_1d: Add a new selftest
      selftests: router_bridge_vlan_upper: Add a new selftest
      selftests: router_bridge_lag: Add a new selftest
      selftests: router_bridge_1d_lag: Add a new selftest
      selftests: mlxsw: rif_lag: Add a new selftest
      selftests: mlxsw: rif_lag_vlan: Add a new selftest
      selftests: mlxsw: rif_bridge: Add a new selftest
      mlxsw: Set port STP state on bridge enslavement
      selftests: mlxsw: router_bridge_lag: Add a new selftest

Petr Pavlu (11):
      mlx4: Get rid of the mlx4_interface.get_dev callback
      mlx4: Rename member mlx4_en_dev.nb to netdev_nb
      mlx4: Use 'void *' as the event param of mlx4_dispatch_event()
      mlx4: Replace the mlx4_interface.event callback with a notifier
      mlx4: Get rid of the mlx4_interface.activate callback
      mlx4: Move the bond work to the core driver
      mlx4: Avoid resetting MLX4_INTFF_BONDING per driver
      mlx4: Register mlx4 devices to an auxiliary virtual bus
      mlx4: Connect the ethernet part to the auxiliary bus
      mlx4: Connect the infiniband part to the auxiliary bus
      mlx4: Delete custom device management logic

Pieter Jansen van Vuuren (6):
      sfc: introduce ethernet pedit set action infrastructure
      sfc: add mac source and destination pedit action offload
      sfc: add decrement ttl by offloading set ipv4 ttl actions
      sfc: add decrement ipv6 hop limit by offloading set hop limit actions
      sfc: introduce pedit add actions on the ipv4 ttl field
      sfc: extend pedit add action to handle decrement ipv6 hop limit

Ping-Ke Shih (21):
      wifi: rtw89: add chip_info::chip_gen to determine chip generation
      wifi: rtw89: define hardware rate v1 for WiFi 7 chips
      wifi: rtw89: use struct to set RA H2C command
      wifi: rtw89: add H2C RA command V1 to support WiFi 7 chips
      wifi: rtw89: use struct to access firmware C2H event header
      wifi: rtw89: use struct to access RA report
      wifi: rtw89: add C2H RA event V1 to support WiFi 7 chips
      wifi: rtw89: add to display hardware rates v1 histogram in debugfs
      wifi: rtw89: get data rate mode/NSS/MCS v1 from RX descriptor
      wifi: rtw89: introduce v1 format of firmware header
      wifi: rtw89: add firmware parser for v1 format
      wifi: rtw89: add firmware suit for BB MCU 0/1
      wifi: rtw89: introduce infrastructure of firmware elements
      wifi: rtw89: add to parse firmware elements of BB and RF tables
      wifi: rtw89: return failure if needed firmware elements are not recognized
      wifi: rtw89: 8852b: rfk: fine tune IQK parameters to improve performance on 2GHz band
      wifi: rtw89: mac: add mac_gen_def::band1_offset to map MAC band1 register address
      wifi: rtw89: mac: generalize code to indirectly access WiFi internal memory
      wifi: rtw89: mac: define internal memory address for WiFi 7 chip
      wifi: rtw89: mac: define register address of rx_filter to generalize code
      wifi: rtw89: phy: add phy_gen_def::cr_base to support WiFi 7 chips

Polaris Pi (2):
      wifi: mwifiex: Fix OOB and integer underflow when rx packets
      wifi: mwifiex: Fix missed return in oob checks failed path

Pradeep Kumar Chitrapu (1):
      wifi: ath12k: add MLO header in peer association

Pranavi Somisetty (1):
      dt-bindings: net: xilinx_gmii2rgmii: Convert to json schema

Prasurjya Rohan Saikia (1):
      wifi: wilc1000: remove use of has_thrpt_enh3 flag

Przemek Kitszel (5):
      ice: clean up __ice_aq_get_set_rss_lut()
      ice: drop two params from ice_aq_alloc_free_res()
      ice: ice_aq_check_events: fix off-by-one check when filling buffer
      ice: embed &ice_rq_event_info event into struct ice_aq_task
      ice: split ice_aq_wait_for_event() func into two

Pu Lehui (8):
      riscv, bpf: Adapt bpf trampoline to optimized riscv ftrace framework
      riscv, bpf: Fix missing exception handling and redundant zext for LDX_B/H/W
      riscv, bpf: Support sign-extension load insns
      riscv, bpf: Support sign-extension mov insns
      riscv, bpf: Support 32-bit offset jmp insn
      riscv, bpf: Support signed div/mod insns
      riscv, bpf: Support unconditional bswap insn
      selftests/bpf: Enable cpu v4 tests for RV64

Quentin Monnet (2):
      bpftool: Use a local copy of BPF_LINK_TYPE_PERF_EVENT in pid_iter.bpf.c
      bpftool: Use "fallthrough;" keyword instead of comments

Radoslaw Tyl (1):
      igb: set max size RX buffer when store bad packet is enabled

Radu Pirea (NXP OSS) (11):
      net: phy: nxp-c45-tja11xx: use phylib master/slave implementation
      net: phy: nxp-c45-tja11xx: remove RX BIST frame counters
      net: phy: nxp-c45-tja11xx: prepare the ground for TJA1120
      net: phy: nxp-c45-tja11xx: use get_features
      net: phy: nxp-c45-tja11xx: add TJA1120 support
      net: phy: nxp-c45-tja11xx: enable LTC sampling on both ext_ts edges
      net: phy: nxp-c45-tja11xx: read egress ts on TJA1120
      net: phy: nxp-c45-tja11xx: handle FUSA irq
      net: phy: nxp-c45-tja11xx: run cable test with the PHY in test mode
      net: phy: nxp-c45-tja11xx: read ext trig ts on TJA1120
      net: phy: nxp-c45-tja11xx: reset PCS if the link goes down

Rafał Miłecki (1):
      dt-bindings: mt76: support pointing to EEPROM using NVMEM cell

Rahul Rameshbabu (5):
      net/mlx5: Consolidate devlink documentation in devlink/mlx5.rst
      net/mlx5e: Make tx_port_ts logic resilient to out-of-order CQEs
      net/mlx5e: Add recovery flow for tx devlink health reporter for unhealthy PTP SQ
      net/mlx5: Update dead links in Kconfig documentation
      net/mlx5: Dynamic cyclecounter shift calculation for PTP free running clock

Rajat Soni (1):
      wifi: ath12k: Fix memory leak in rx_desc and tx_desc

Randy Dunlap (4):
      libbpf: fix typos in Makefile
      wifi: cfg80211: remove dead/unused enum value
      wifi: radiotap: fix kernel-doc notation warnings
      wifi: mac80211: fix kernel-doc notation warning

Rany Hany (1):
      wifi: mt76: mt7915: fix command timeout in AP stop period

Ratheesh Kannoth (7):
      net: flow_dissector: Use 64bits for used_keys
      net: flow_dissector: Add IPSEC dissector
      tc: flower: support for SPI
      tc: flower: Enable offload support IPSEC SPI field.
      octeontx2-pf: TC flower offload support for SPI field
      octeontx2-af: Harden rule validation.
      octeontx2-pf: fix page_pool creation fail for rings > 32k

Rob Herring (9):
      ptp: Explicitly include correct DT includes
      can: Explicitly include correct DT includes
      dt-bindings: net: dsa: Fix JSON pointer references
      net: dsa: Explicitly include correct DT includes
      net: phy/pcs: Explicitly include correct DT includes
      net: Explicitly include correct DT includes
      can: Explicitly include correct DT includes, part 2
      wifi: drivers: Explicitly include correct DT includes
      bluetooth: Explicitly include correct DT includes

Robert Marko (1):
      dt-bindings: net: ethernet-controller: add PSGMII mode

Roger Gammans (1):
      Bluetooth: btusb: Add support for another MediaTek 7922 VID/PID

Roger Quadros (3):
      net: ti: icssg-prueth: Add ICSSG ethernet driver
      net: ti: icss-iep: Add IEP driver
      net: ti: icssg-prueth: add packet timestamping and ptp support

Rohan G Thomas (2):
      net: stmmac: xgmac: Fix L3L4 filter count
      net: stmmac: XGMAC support for mdio C22 addr > 3

Roi Dayan (6):
      net/mlx5: Use shared code for checking lag is supported
      net/mlx5: Devcom, Infrastructure changes
      net/mlx5e: E-Switch, Register devcom device with switch id key
      net/mlx5e: E-Switch, Allow devcom initialization on more vports
      net/mlx5: E-Switch, Remove redundant arg ignore_flow_lvl
      net/mlx5: Bridge, Only handle registered netdev bridge events

Rong Tao (1):
      samples/bpf: syscall_tp: Aarch64 no open syscall

Ruan Jinjie (28):
      can: flexcan: fix the return value handle for platform_get_irq()
      can: c_can: Do not check for 0 return after calling platform_get_irq()
      net: hisilicon: fix the return value handle and remove redundant netdev_err() for platform_get_irq()
      octeontx2: Remove unnecessary ternary operators
      bnx2x: Remove unnecessary ternary operators
      cirrus: cs89x0: fix the return value handle and remove redundant dev_warn() for platform_get_irq()
      drivers: net: xgene: Do not check for 0 return after calling platform_get_irq()
      net: gemini: Do not check for 0 return after calling platform_get_irq()
      net/mlx4: Remove many unnecessary NULL values
      net/mlx5: remove many unnecessary NULL values
      mlxsw: spectrum_switchdev: Use is_zero_ether_addr() instead of ether_addr_equal()
      net: dsa: realtek: Remove redundant of_match_ptr()
      net: dsa: rzn1-a5psw: Remove redundant of_match_ptr()
      net: gemini: Remove redundant of_match_ptr()
      net: qualcomm: Remove redundant of_match_ptr()
      wlcore: spi: Remove redundant of_match_ptr()
      sky2: Remove redundant NULL check for debugfs_create_dir
      net: dm9051: Use PTR_ERR_OR_ZERO() to simplify code
      net: microchip: vcap api: Always return ERR_PTR for vcap_get_rule()
      net: lan966x: Fix return value check for vcap_get_rule()
      net: microchip: sparx5: Update return value check for vcap_get_rule()
      net: bgmac: Return PTR_ERR() for fixed_phy_register()
      net: bcmgenet: Return PTR_ERR() for fixed_phy_register()
      net: lan743x: Return PTR_ERR() for fixed_phy_register()
      wifi: mwifiex: use is_zero_ether_addr() instead of ether_addr_equal()
      wifi: ath5k: Remove redundant dev_err()
      wifi: ath9k: Remove unnecessary ternary operators
      wifi: ath: Use is_multicast_ether_addr() to check multicast Ether address

Rushil Gupta (4):
      gve: Control path for DQO-QPL
      gve: Tx path for DQO-QPL
      gve: RX path for DQO-QPL
      gve: update gve.rst

Russell King (1):
      net: dsa: mv88e6xxx: convert 88e6352 to phylink_pcs

Russell King (Oracle) (34):
      net: phylink: add pcs_enable()/pcs_disable() methods
      net: phylink: add pcs_pre_config()/pcs_post_config() methods
      net: phylink: add support for PCS link change notifications
      net: mdio: add unlocked mdiobus and mdiodev bus accessors
      net: dsa: mv88e6xxx: remove handling for DSA and CPU ports
      net: dsa: mv88e6xxx: add infrastructure for phylink_pcs
      net: dsa: mv88e6xxx: export mv88e6xxx_pcs_decode_state()
      net: dsa: mv88e6xxx: convert 88e6185 to phylink_pcs
      net: dsa: mv88e6xxx: convert 88e639x to phylink_pcs
      net: dsa: mv88e6xxx: cleanup after phylink_pcs conversion
      net: dsa: remove legacy_pre_march2020 detection
      net: dsa: remove legacy_pre_march2020 from drivers
      net: phylink: remove legacy mac_an_restart() method
      net: ethernet: mtk_eth_soc: remove incorrect PLL configuration
      net: ethernet: mtk_eth_soc: remove mac_pcs_get_state and modernise
      net: phylink: strip out pre-March 2020 legacy code
      net: phylink: explicitly invalidate link_state members in mac_config
      net: mdio_bus: validate "addr" for mdiobus_is_registered_device()
      net: phy: move marking PHY on SFP module into SFP code
      net: dsa: mark parsed interface mode for legacy switch drivers
      net: dsa: mv88e6060: add phylink_get_caps implementation
      net: mdio: xgene: remove useless xgene_mdio_status
      net: dsa: realtek: add phylink_get_caps implementation
      net: phylink: add phylink_limit_mac_speed()
      net: stmmac: convert plat->phylink_node to fwnode
      net: stmmac: clean up passing fwnode to phylink
      net: stmmac: use "mdio_bus_data" local variable
      net: stmmac: use phylink_limit_mac_speed()
      net: stmmac: provide stmmac_mac_phylink_get_caps()
      net: stmmac: move gmac4 specific phylink capabilities to gmac4
      net: stmmac: move xgmac specific phylink caps to dwxgmac2 core
      net: stmmac: move priv->phylink_config.mac_managed_pm
      net: stmmac: convert half-duplex support to positive logic
      net: stmmac: clarify difference between "interface" and "phy_interface"

Ryder Lee (11):
      wifi: mt76: mt7996: fix header translation logic
      wifi: mt76: mt7996: enable BSS_CHANGED_MU_GROUPS support
      wifi: mt76: mt7615: enable BSS_CHANGED_MU_GROUPS support
      wifi: mt76: enable UNII-4 channel 177 support
      wifi: mt76: mt7915: report tx retries/failed counts for non-WED path
      wifi: mt76: mt7915: drop return in mt7915_sta_statistics
      wifi: mt76: mt7996: drop return in mt7996_sta_statistics
      wifi: mt76: add tx_nss histogram to ethtool stats
      wifi: mt76: mt7915: accumulate mu-mimo ofdma muru stats
      wifi: mt76: mt7915: fix tlv length of mt7915_mcu_get_chan_mib_info
      wifi: mt76: mt7915: fix power-limits while chan_switch

Sabrina Dubroca (19):
      netdevsim: add dummy macsec offload
      selftests: rtnetlink: add MACsec offload tests
      selftests: tls: add test variants for aria-gcm
      selftests: tls: add getsockopt test
      selftests: tls: test some invalid inputs for setsockopt
      tls: move tls_cipher_size_desc to net/tls/tls.h
      tls: add TLS_CIPHER_ARIA_GCM_* to tls_cipher_size_desc
      tls: reduce size of tls_cipher_size_desc
      tls: rename tls_cipher_size_desc to tls_cipher_desc
      tls: extend tls_cipher_desc to fully describe the ciphers
      tls: validate cipher descriptions at compile time
      tls: expand use of tls_cipher_desc in tls_set_device_offload
      tls: allocate the fallback aead after checking that the cipher is valid
      tls: expand use of tls_cipher_desc in tls_sw_fallback_init
      tls: get crypto_info size from tls_cipher_desc in do_tls_setsockopt_conf
      tls: use tls_cipher_desc to simplify do_tls_getsockopt_conf
      tls: use tls_cipher_desc to get per-cipher sizes in tls_set_sw_offload
      tls: use tls_cipher_desc to access per-cipher crypto_info in tls_set_sw_offload
      tls: get cipher_name from cipher_desc in tls_set_sw_offload

Saeed Mahameed (1):
      net/mlx5: IRQ, consolidate irq and affinity mask allocation

Sai Krishna (1):
      octeontx2-pf: Use PTP HW timestamp counter atomic update feature

Sai Teja Aluvala (2):
      Bluetooth: hci_qca: Add qcom devcoredump sysfs support
      Bluetooth: hci_qca: Add qcom devcoredump support

Samin Guo (2):
      dt-bindings: net: motorcomm: Add pad driver strength cfg
      net: phy: motorcomm: Add pad drive strength cfg support

Sascha Hauer (1):
      wifi: rtw88: usb: kill and free rx urbs on probe failure

Sasha Neftin (2):
      igc: Decrease PTM short interval from 10 us to 1 us
      e1000e: Add support for the next LOM generation

Sathesh Edara (1):
      octeon_ep: Add control plane host and firmware versions.

Sean Wang (1):
      Bluetooth: btusb: mediatek: readx_poll_timeout replaces open coding

Seevalamuthu Mariappan (2):
      wifi: ath11k: Split coldboot calibration hw_param
      wifi: ath11k: Remove cal_done check during probe

Sergei Antonov (1):
      net: ftmac100: add multicast filtering possibility

Sergey Kacheev (1):
      libbpf: Use local includes inside the library

Shannon Nelson (9):
      ionic: extract common bits from ionic_remove
      ionic: extract common bits from ionic_probe
      ionic: pull out common bits from fw_up
      ionic: add FLR recovery support
      pds_core: protect devlink callbacks from fw_down state
      pds_core: no health reporter in VF
      pds_core: no reset command for VF
      pds_core: check for work queue before use
      pds_core: pass opcode to devcmd_wait

Shay Drory (8):
      net/mlx5: Re-organize mlx5_cmd struct
      net/mlx5: Remove redundant cmdif revision check
      net/mlx5: split mlx5_cmd_init() to probe and reload routines
      net/mlx5: Allocate command stats with xarray
      net/mlx5: Expose max possible SFs via devlink resource
      net/mlx5: Remove unused CAPs
      net/mlx5: Remove unused MAX HCA capabilities
      net/mlx5: Don't query MAX caps twice

Shayne Chen (1):
      wifi: mt76: mt7996: move radio ctrl commands to proper functions

Shenwei Wang (2):
      net: stmmac: add new mode parameter for fix_mac_speed
      net: stmmac: dwmac-imx: pause the TXC clock in fixed-link

Shiji Yang (2):
      wifi: rt2x00: correct MAC_SYS_CTRL register RX mask in R-Calibration
      wifi: rt2x00: limit MT7620 TX power based on eeprom calibration

Shradha Gupta (1):
      net: mana: Add gdma stats to ethtool output for mana

Shuah Khan (3):
      selftests: connector: Fix Makefile to include KHDR_INCLUDES
      selftests: connector: Add .gitignore and poupulate it with test
      selftests: connector: Fix input argument error paths to skip

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Somnath Kotur (2):
      bnxt_en: Use the unified RX page pool buffers for XDP and non-XDP
      bnxt_en: Let the page pool manage the DMA mapping

Souradeep Chakrabarti (1):
      net: mana: Configure hwc timeout from hardware

Srinivas Neeli (1):
      can: xilinx_can: Add support for controller reset

Stanislav Fomichev (6):
      bpf: Resolve modifiers when walking structs
      selftests/bpf: Add test to exercise typedef walking
      ynl: expose xdp-zc-max-segs
      ynl: mark max/mask as private for kdoc
      ynl: regenerate all headers
      ynl: print xdp-zc-max-segs in the sample

StanleyYP Wang (3):
      wifi: mt76: mt7915: fix background radar event being blocked
      wifi: mt76: mt7996: use correct phy for background radar event
      wifi: mt76: mt7996: fix WA event ring size

Stefan Eichenberger (5):
      net: phy: add registers to support 1000BASE-T1
      net: phy: c45: add support for 1000BASE-T1 forced setup
      net: phy: c45: add a separate function to read BASE-T1 abilities
      net: phy: c45: detect the BASE-T1 speed from the ability register
      net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2110 PHY

Stephen Rothwell (1):
      net/mlx5e: fix up for "net/mlx5e: Move MACsec flow steering operations to be used as core library"

Suman Ghosh (6):
      octeontx2-af: Install TC filter rules in hardware based on priority
      octeontx2-af: Initialize 'cntr_val' to fix uninitialized symbol error
      octeontx2-af: Code restructure to handle TC outer VLAN offload
      octeontx2-af: TC flower offload support for inner VLAN
      octeontx2-pf: Fix PFC TX scheduler free
      cteonxt2-pf: Fix backpressure config for multiple PFC priorities to work simultaneously

Sumitra Sharma (1):
      lib/test_bpf: Call page_address() on page acquired with GFP_KERNEL flag

Sunil Goutham (1):
      octeontx2-af: Don't treat lack of CGX interfaces as error

Sven Eckelmann (7):
      batman-adv: Avoid magic value for minimum MTU
      batman-adv: Check hardif MTU against runtime MTU
      batman-adv: Drop unused function batadv_gw_bandwidth_set
      batman-adv: Keep batadv_netlink_notify_* static
      batman-adv: Drop per algo GW section class code
      wifi: ath11k: Don't drop tx_status when peer cannot be found
      wifi: ath11k: Cleanup mac80211 references on failure during tx_complete

Tahsin Erdogan (1):
      tun: avoid high-order page allocation for packet header

Thomas Weißschuh (1):
      net: generalize calculation of skb extensions length

Tirthendu Sarkar (9):
      xsk: prepare 'options' in xdp_desc for multi-buffer use
      xsk: introduce XSK_USE_SG bind flag for xsk socket
      xsk: move xdp_buff's data length check to xsk_rcv_check
      xsk: add support for AF_XDP multi-buffer on Rx path
      xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path
      xsk: add support for AF_XDP multi-buffer on Tx path
      xsk: discard zero length descriptors in Tx path
      i40e: xsk: add RX multi-buffer support
      i40e: xsk: add TX multi-buffer support

Toke Høiland-Jørgensen (7):
      samples/bpf: Remove the xdp_monitor utility
      samples/bpf: Remove the xdp_redirect* utilities
      samples/bpf: Remove the xdp_rxq_info utility
      samples/bpf: Remove the xdp1 and xdp2 utilities
      samples/bpf: Remove the xdp_sample_pkts utility
      samples/bpf: Cleanup .gitignore
      samples/bpf: Add note to README about the XDP utilities moved to xdp-tools

Tony Nguyen (1):
      ice: Utilize assign_bit() helper

Tristram Ha (1):
      net: phy: smsc: add WoL support to LAN8740/LAN8742 PHYs

Uwe Kleine-König (8):
      net: dpaa: Improve error reporting
      net: dpaa: Convert to platform remove callback returning void
      net: fec: Convert to platform remove callback returning void
      net: fman: Convert to platform remove callback returning void
      net: fs_enet: Convert to platform remove callback returning void
      net: fsl_pq_mdio: Convert to platform remove callback returning void
      net: gianfar: Convert to platform remove callback returning void
      net: ucc_geth: Convert to platform remove callback returning void

Vadim Pasternak (3):
      mlxsw: i2c: Fix chunk size setting in output mailbox buffer
      mlxsw: i2c: Limit single transaction buffer size
      mlxsw: core_hwmon: Adjust module label names based on MTCAP sensor counter

Valentin David (1):
      Bluetooth: btusb: Add device 0489:e0f5 as MT7922 device

Vignesh Viswanathan (3):
      net: qrtr: ns: Change servers radix tree to xarray
      net: qrtr: ns: Change nodes radix tree to xarray
      net: qrtr: Handle IPCR control port format of older targets

Vinicius Costa Gomes (1):
      igc: Add support for multiple in-flight TX timestamps

Vladimir Oltean (20):
      net: fec: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
      net: fec: delete fec_ptp_disable_hwts()
      net: sparx5: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
      net: lan966x: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
      net: transfer rtnl_lock() requirement from ethtool_set_ethtool_phy_ops() to caller
      net: phy: provide phylib stubs for hardware timestamping operations
      net: remove phy_has_hwtstamp() -> phy_mii_ioctl() decision from converted drivers
      net: omit ndo_hwtstamp_get() call when possible in dev_set_hwtstamp_phylib()
      net/sched: taprio: don't access q->qdiscs[] in unoffloaded mode during attach()
      net/sched: taprio: keep child Qdisc refcount elevated at 2 in offload mode
      net/sched: taprio: try again to report q->qdiscs[] to qdisc_leaf()
      net/sched: taprio: delete misleading comment about preallocating child qdiscs
      net/sched: taprio: dump class stats for the actual q->qdiscs[]
      net: ptp: create a mock-up PTP Hardware Clock driver
      net: netdevsim: use mock PHC driver
      net: netdevsim: mimic tc-taprio offload
      selftests/tc-testing: add ptp_mock Kconfig dependency
      selftests/tc-testing: test that taprio can only be attached as root
      selftests/tc-testing: verify that a qdisc can be grafted onto a taprio class
      net: pcs: lynx: fix lynx_pcs_link_up_sgmii() not doing anything in fixed-link mode

Wang Ming (2):
      wifi: ath6kl: Remove error checking for debugfs_create_dir()
      wifi: ath9k: use IS_ERR() with debugfs_create_dir()

Wei Fang (8):
      net: fec: remove the remaining code of rx copybreak
      net: fec: remove fec_set_mac_address() from fec_enet_init()
      net: fec: remove unused members from struct fec_enet_private
      net: fec: add XDP_TX feature support
      net: fec: improve XDP_TX performance
      net: fec: use napi_consume_skb() in fec_enet_tx_queue()
      net: fec: add exception tracing for XDP
      net: fec: add statistics for XDP_TX

Wen Gong (8):
      wifi: ath12k: Fix a NULL pointer dereference in ath12k_mac_op_hw_scan()
      wifi: ath12k: correct the data_type from QMI_OPT_FLAG to QMI_UNSIGNED_1_BYTE for mlo_capable
      wifi: ath12k: avoid array overflow of hw mode for preferred_hw_mode
      wifi: ath12k: trigger station disconnect on hardware restart
      wifi: ath12k: change to use dynamic memory for channel list of scan
      wifi: ath12k: add handler for scan event WMI_SCAN_EVENT_DEQUEUED
      wifi: ath12k: avoid deadlock by change ieee80211_queue_work for regd_update_work
      wifi: ath12k: add check max message length while scanning with extraie

Will Hawkins (2):
      bpf, docs: Formalize type notation and function semantics in ISA standard
      bpf, docs: Fix small typo and define semantics of sign extension

Willem de Bruijn (1):
      selftests/net: report rcv_mss in tcp_mmap

William Tu (1):
      vmxnet3: Add XDP support.

Wojciech Drewek (8):
      ice: Skip adv rules removal upon switchdev release
      ice: Prohibit rx mode change in switchdev mode
      ice: Don't tx before switchdev is fully configured
      ice: Disable vlan pruning for uplink VSI
      ice: Unset src prune on uplink VSI
      ice: Implement basic eswitch bridge setup
      ice: Switchdev FDB events support
      ice: Accept LAG netdevs in bridge offloads

Wu Yunchuan (18):
      net: atlantic: Remove unnecessary (void*) conversions
      net: ppp: Remove unnecessary (void*) conversions
      net: hns3: remove unnecessary (void*) conversions.
      net: hns: Remove unnecessary (void*) conversions
      ice: remove unnecessary (void*) conversions
      ethernet: smsc: remove unnecessary (void*) conversions
      net: mdio: Remove unnecessary (void*) conversions
      can: ems_pci: Remove unnecessary (void*) conversions
      net: bna: Remove unnecessary (void*) conversions
      wifi: rsi: rsi_91x_coex: Remove unnecessary (void*) conversions
      wifi: rsi: rsi_91x_debugfs: Remove unnecessary (void*) conversions
      wifi: rsi: rsi_91x_hal: Remove unnecessary conversions
      wifi: rsi: rsi_91x_mac80211: Remove unnecessary conversions
      wifi: rsi: rsi_91x_main: Remove unnecessary (void*) conversions
      wifi: rsi: rsi_91x_sdio: Remove unnecessary (void*) conversions
      wifi: rsi: rsi_91x_sdio_ops: Remove unnecessary (void*) conversions
      wifi: rsi: rsi_91x_usb: Remove unnecessary (void*) conversions
      wifi: rsi: rsi_91x_usb_ops: Remove unnecessary (void*) conversions

Xin Long (3):
      netfilter: allow exp not to be removed in nf_ct_find_expectation
      net: sched: set IPS_CONFIRMED in tmpl status only when commit is set in act_ct
      openvswitch: set IPS_CONFIRMED in tmpl status only when commit is set in conntrack

Xiongfeng Wang (1):
      net: txgbe: Use pci_dev_id() to simplify the code

Xu Kuohai (7):
      arm64: insn: Add encoders for LDRSB/LDRSH/LDRSW
      bpf, arm64: Support sign-extension load instructions
      bpf, arm64: Support sign-extension mov instructions
      bpf, arm64: Support unconditional bswap
      bpf, arm64: Support 32-bit offset jmp instruction
      bpf, arm64: Support signed div/mod instructions
      selftests/bpf: Enable cpu v4 tests for arm64

Yafang Shao (18):
      bpf: Support ->fill_link_info for kprobe_multi
      bpftool: Dump the kernel symbol's module name
      bpftool: Show kprobe_multi link info
      bpf: Protect probed address based on kptr_restrict setting
      bpf: Clear the probe_addr for uprobe
      bpf: Expose symbol's respective address
      bpf: Add a common helper bpf_copy_to_user()
      bpf: Support ->fill_link_info for perf_event
      bpftool: Add perf event names
      bpftool: Show perf link info
      bpf: Fix an error around PTR_UNTRUSTED
      selftests/bpf: Add selftests for nested_trust
      bpf: Fix an error in verifying a field in a union
      selftests/bpf: Add selftest for PTR_UNTRUSTED
      bpf: Fix uninitialized symbol in bpf_perf_link_fill_kprobe()
      selftests/bpf: Add selftest for fill_link_info
      bpf: Fix issue in verifying allow_ptr_leaks
      selftests/bpf: Add selftest for allow_ptr_leaks

Yan Zhai (4):
      lwt: Fix return values of BPF xmit ops
      lwt: Check LWTUNNEL_XMIT_CONTINUE strictly
      selftests/bpf: Add lwt_xmit tests for BPF_REDIRECT
      selftests/bpf: Add lwt_xmit tests for BPF_REROUTE

Yang Li (4):
      team: Remove NULL check before dev_{put, hold}
      net: Remove duplicated include in mac.c
      sfc: Remove unneeded semicolon
      pds_core: Fix some kernel-doc comments

Yang Yingliang (6):
      bpf: change bpf_alu_sign_string and bpf_movsx_string to static
      net: ethernet: adi: adin1110: use eth_broadcast_addr() to assign broadcast address
      net: ethernet: 8390: ne2k-pci: use module_pci_driver() macro
      ice: use list_for_each_entry() helper
      wifi: rtlwifi: use eth_broadcast_addr() to assign broadcast address
      wifi: ath11k: simplify the code with module_platform_driver

Yauheni Kaliuta (1):
      tracing: bpf: use struct trace_entry in struct syscall_tp_t

Yevgeny Kliteynik (2):
      net/mlx5: DR, Fix code indentation
      net/mlx5: DR, Remove unneeded local variable

YiFei Zhu (1):
      bpf: Non-atomically allocate freelist during prefill

Ying Hsu (1):
      Bluetooth: Fix hci_suspend_sync crash

Yipeng Zou (2):
      selftests/bpf: Fix repeat option when kfunc_call verification fails
      selftests/bpf: Clean up fmod_ret in bench_rename test script

Yonghong Song (30):
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
      bpf: Fix an incorrect verification success with movsx insn
      selftests/bpf: Add a movsx selftest for sign-extension of R10
      selftests/bpf: Fix a selftest compilation error
      bpf: Fix a bpf_kptr_xchg() issue with local kptr
      selftests/bpf: Add a failure test for bpf_kptr_xchg() with local kptr
      bpf: Remove a WARN_ON_ONCE warning related to local kptr
      selftests/bpf: Add a local kptr test with no special fields

Yoshihiro Shimoda (2):
      net: renesas: rswitch: Add runtime speed change support
      net: renesas: rswitch: Add .[gs]et_link_ksettings support

Yu Liao (3):
      ibmvnic: remove unused rc variable
      pds_core: remove redundant pci_clear_master()
      net: dm9051: Use PTR_ERR_OR_ZERO() to simplify code

Yuanjun Gong (2):
      wifi: mt76: mt76x02: fix return value check in mt76x02_mac_process_rx
      Bluetooth: nokia: fix value check in nokia_bluetooth_serdev_probe()

Yue Haibing (62):
      devlink: Remove unused extern declaration devlink_port_region_destroy()
      tcp: Remove unused function declarations
      net/smc: Remove unused function declarations
      vsock: Remove unused function declarations
      net/hsr: Remove unused function declarations
      inet6: Remove unused function declaration udpv6_connect()
      udp: Remove unused function declaration udp_bpf_get_proto()
      ila: Remove unnecessary file net/ila.h
      netlabel: Remove unused declaration netlbl_cipsov4_doi_free()
      net: switchdev: Remove unused typedef switchdev_obj_dump_cb_t()
      sctp: Remove unused function declarations
      tipc: Remove unused function declarations
      net: Space.h: Remove unused function declarations
      net: llc: Remove unused function declarations
      net: hns3: Remove unused function declarations
      net: 802: Remove unused function declarations
      af_vsock: Remove unused declaration vsock_release_pending()/vsock_init_tap()
      ixgbevf: Remove unused function declarations
      mlxsw: spectrum: Remove unused function declarations
      net/tls: Remove unused function declarations
      neighbour: Remove unused function declaration pneigh_for_each()
      net: pkt_cls: Remove unused inline helpers
      ndisc: Remove unused ndisc_ifinfo_sysctl_strategy() declaration
      net: sfp: Remove unused function declaration sfp_link_configure()
      udp/udplite: Remove unused function declarations udp{,lite}_get_port()
      netfilter: gre: Remove unused function declaration nf_ct_gre_keymap_flush()
      netfilter: helper: Remove unused function declarations
      netfilter: conntrack: Remove unused function declarations
      netfilter: h323: Remove unused function declarations
      ixgbe: Remove unused function declarations
      i40e: Remove unused function declarations
      net: hns: Remove unused function declaration mac_adjust_link()
      net: fq: Remove unused typedef fq_flow_get_default_t
      devlink: Remove unused devlink_dpipe_table_resource_set() declaration
      bpf: lru: Remove unused declaration bpf_lru_promote()
      bpf: btf: Remove two unused function declarations
      tipc: Remove unused declaration tipc_link_build_bc_sync_msg()
      net: phy: Remove two unused function declarations
      mlxbf_gige: Remove two unused function declarations
      net: switchdev: Remove unused declaration switchdev_port_fwd_mark_set()
      net: caif: Remove unused declaration cfsrvl_ctrlcmd()
      sctp: Remove unused declaration sctp_backlog_migrate()
      Bluetooth: Remove unused declaration amp_read_loc_info()
      bpf: Remove unused declaration bpf_link_new_file()
      net/rds: Remove unused function declarations
      net: e1000: Remove unused declarations
      net: e1000e: Remove unused declarations
      net: freescale: Remove unused declarations
      wifi: ath9k: Remove unused declarations
      net: dsa: microchip: Remove unused declarations
      net: mscc: ocelot: Remove unused declarations
      ionic: Remove unused declarations
      net: microchip: Remove unused declarations
      net: ethernet: ti: Remove unused declarations
      wifi: wext: Remove unused declaration dev_get_wireless_info()
      wifi: mac80211: Remove unused function declarations
      wifi: mac80211: mesh: Remove unused function declaration mesh_ids_set_default()
      wifi: nl80211: Remove unused declaration nl80211_pmsr_dump_results()
      qed/qede: Remove unused declarations
      wifi: wilc1000: Remove unused declarations
      wifi: ath11k: Remove unused declarations
      wifi: ath12k: Remove unused declarations

YueHaibing (6):
      bridge: Remove unused declaration br_multicast_set_hash_max()
      dccp: Remove unused declaration dccp_feat_initialise_sysctls()
      net: Remove unused declaration dev_restart()
      net: datalink: Remove unused declarations
      bonding: 3ad: Remove unused declaration bond_3ad_update_lacp_active()
      batman-adv: Remove unused declarations

Yueh-Shun Li (1):
      wifi: zd1211rw: fix typo "tranmits"

Yunsheng Lin (1):
      page_pool: split types and declarations from page_pool.h

Zhang Shurong (1):
      wifi: rtw89: debug: Fix error handling in rtw89_debug_priv_btc_manual_set()

Zheng Zengkai (5):
      et131x: Use pci_dev_id() to simplify the code
      tg3: Use pci_dev_id() to simplify the code
      net: smsc: Use pci_dev_id() to simplify the code
      net: tc35815: Use pci_dev_id() to simplify the code
      net: ngbe: use pci_dev_id() to simplify the code

Zhengchao Shao (14):
      net: remove redundant NULL check in remove_xps_queue()
      team: add __exit modifier to team_nl_fini()
      team: remove unreferenced header in broadcast and roundrobin files
      team: change the init function in the team_option structure to void
      team: change the getter function in the team_option structure to void
      team: remove unused input parameters in lb_htpm_select_tx_port and lb_hash_select_tx_port
      bonding: add modifier to initialization function and exit function
      bonding: use IS_ERR instead of NULL check in bond_create_debugfs
      bonding: remove redundant NULL check in debugfs function
      bonding: use bond_set_slave_arr to simplify code
      bonding: remove unnecessary NULL check in bond_destructor
      selftests: bonding: remove redundant delete action of device link1_1
      net: remove unnecessary input parameter 'how' in ifdown function
      selftests: bonding: create directly devices in the target namespaces

Zhu Wang (2):
      nf_conntrack: fix -Wunused-const-variable=
      net: lan966x: Do not check 0 for platform_get_irq_byname()

Ziyang Chen (1):
      nfp: prevent dropped counter increment during probe

Ziyang Xuan (3):
      ipv6: exthdrs: Replace opencoded swap() implementation
      Bluetooth: Remove unnecessary NULL check before vfree()
      tun: add __exit annotations to module exit func tun_cleanup()

Zong-Zhe Yang (8):
      wifi: rtw89: phy: rate pattern handles HW rate by chip gen
      wifi: rtw89: regd: update regulatory map to R64-R43
      wifi: rtw89: add function prototype for coex request duration
      wifi: rtw89: refine rtw89_correct_cck_chan() by rtw89_hw_to_nl80211_band()
      wifi: rtw89: sar: let caller decide the center frequency to query
      wifi: rtw89: call rtw89_chan_get() by vif chanctx if aware of vif
      wifi: rtw89: provide functions to configure NoA for beacon update
      wifi: rtw89: initialize multi-channel handling

justinstitt@google.com (1):
      net: dsa: remove deprecated strncpy

xu xin (1):
      net/ipv4: return the real errno instead of -EINVAL

 Documentation/bpf/bpf_design_QA.rst                |    5 -
 Documentation/bpf/bpf_devel_QA.rst                 |   10 +-
 Documentation/bpf/btf.rst                          |    4 +-
 Documentation/bpf/index.rst                        |    3 +-
 Documentation/bpf/llvm_reloc.rst                   |    6 +-
 Documentation/bpf/standardization/index.rst        |   18 +
 .../bpf/{ => standardization}/instruction-set.rst  |  227 +-
 .../bpf/{ => standardization}/linux-notes.rst      |    3 +-
 Documentation/core-api/netlink.rst                 |    9 +-
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |   25 +
 .../devicetree/bindings/net/brcm,asp-v2.0.yaml     |  155 +
 .../devicetree/bindings/net/brcm,unimac-mdio.yaml  |    2 +
 .../bindings/net/can/allwinner,sun4i-a10-can.yaml  |    6 +-
 .../devicetree/bindings/net/can/bosch,m_can.yaml   |   20 +-
 .../devicetree/bindings/net/can/tcan4x5x.txt       |   11 +-
 .../devicetree/bindings/net/can/xilinx,can.yaml    |    3 +
 Documentation/devicetree/bindings/net/dsa/dsa.yaml |    2 +-
 .../devicetree/bindings/net/dsa/marvell.txt        |    2 +-
 .../bindings/net/ethernet-controller.yaml          |    1 +
 .../devicetree/bindings/net/mediatek,net.yaml      |  109 +-
 .../devicetree/bindings/net/motorcomm,yt8xxx.yaml  |   34 +
 .../devicetree/bindings/net/oxnas-dwmac.txt        |   41 -
 .../devicetree/bindings/net/qca,ar803x.yaml        |    2 +
 .../devicetree/bindings/net/rockchip-dwmac.yaml    |    1 +
 .../devicetree/bindings/net/ti,icss-iep.yaml       |   45 +
 .../devicetree/bindings/net/ti,icssg-prueth.yaml   |  193 +
 .../bindings/net/wireless/mediatek,mt76.yaml       |   13 +-
 .../devicetree/bindings/net/xilinx_gmii2rgmii.txt  |   35 -
 .../bindings/net/xlnx,gmii-to-rgmii.yaml           |   55 +
 Documentation/netlink/genetlink-c.yaml             |    4 +-
 Documentation/netlink/genetlink-legacy.yaml        |    4 +-
 Documentation/netlink/genetlink.yaml               |    2 +-
 Documentation/netlink/netlink-raw.yaml             |  410 +
 Documentation/netlink/specs/devlink.yaml           |  471 +-
 Documentation/netlink/specs/fou.yaml               |   18 +-
 Documentation/netlink/specs/netdev.yaml            |    9 +-
 Documentation/netlink/specs/ovs_vport.yaml         |   31 +-
 Documentation/netlink/specs/rt_addr.yaml           |  179 +
 Documentation/netlink/specs/rt_link.yaml           | 1432 +++
 Documentation/netlink/specs/rt_route.yaml          |  327 +
 Documentation/networking/af_xdp.rst                |  211 +-
 .../device_drivers/ethernet/google/gve.rst         |    9 +
 .../device_drivers/ethernet/marvell/octeontx2.rst  |    8 +
 .../ethernet/mellanox/mlx5/counters.rst            |   29 +-
 .../ethernet/mellanox/mlx5/devlink.rst             |  313 -
 .../ethernet/mellanox/mlx5/index.rst               |    1 -
 .../ethernet/mellanox/mlx5/kconfig.rst             |   14 +-
 .../ethernet/mellanox/mlx5/switchdev.rst           |   20 +
 Documentation/networking/devlink/devlink-port.rst  |   55 +
 Documentation/networking/devlink/mlx5.rst          |  182 +
 Documentation/networking/ip-sysctl.rst             |    9 +
 Documentation/networking/mptcp-sysctl.rst          |    8 +
 Documentation/networking/netconsole.rst            |   11 +-
 Documentation/networking/page_pool.rst             |  149 +-
 Documentation/networking/phy.rst                   |    4 +
 Documentation/networking/xfrm_device.rst           |    1 +
 Documentation/process/maintainer-netdev.rst        |    6 +
 .../userspace-api/netlink/genetlink-legacy.rst     |   26 +-
 Documentation/userspace-api/netlink/index.rst      |    1 +
 .../userspace-api/netlink/netlink-raw.rst          |   58 +
 Documentation/userspace-api/netlink/specs.rst      |   13 +
 MAINTAINERS                                        |   41 +-
 arch/arm64/include/asm/insn.h                      |    4 +
 arch/arm64/lib/insn.c                              |    6 +
 arch/arm64/net/bpf_jit.h                           |   12 +
 arch/arm64/net/bpf_jit_comp.c                      |   91 +-
 arch/powerpc/platforms/8xx/adder875.c              |    1 -
 arch/powerpc/platforms/8xx/mpc885ads_setup.c       |    1 -
 arch/powerpc/platforms/8xx/tqm8xx_setup.c          |    1 -
 arch/powerpc/sysdev/fsl_soc.c                      |    3 -
 arch/riscv/net/bpf_jit.h                           |   30 +
 arch/riscv/net/bpf_jit_comp64.c                    |  255 +-
 arch/x86/net/bpf_jit_comp.c                        |  387 +-
 drivers/block/drbd/drbd_nl.c                       |    9 +-
 drivers/bluetooth/btbcm.c                          |    5 +
 drivers/bluetooth/btintel.c                        |  229 +-
 drivers/bluetooth/btintel.h                        |   10 +-
 drivers/bluetooth/btmtk.c                          |  133 +
 drivers/bluetooth/btmtk.h                          |   42 +
 drivers/bluetooth/btmtkuart.c                      |    1 -
 drivers/bluetooth/btnxpuart.c                      |  257 +-
 drivers/bluetooth/btqca.c                          |   96 +-
 drivers/bluetooth/btqca.h                          |   31 +-
 drivers/bluetooth/btrtl.c                          |  233 +-
 drivers/bluetooth/btrtl.h                          |   13 +
 drivers/bluetooth/btusb.c                          |  372 +-
 drivers/bluetooth/hci_h5.c                         |    2 +-
 drivers/bluetooth/hci_ldisc.c                      |    3 +-
 drivers/bluetooth/hci_nokia.c                      |    6 +-
 drivers/bluetooth/hci_qca.c                        |  428 +-
 drivers/connector/cn_proc.c                        |  111 +-
 drivers/connector/connector.c                      |   40 +-
 drivers/hid/bpf/entrypoints/Makefile               |    2 +-
 drivers/infiniband/core/cache.c                    |    6 +-
 drivers/infiniband/hw/mlx4/main.c                  |  218 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h               |    2 +
 drivers/infiniband/hw/mlx5/Makefile                |    1 +
 drivers/infiniband/hw/mlx5/cq.c                    |    2 +-
 drivers/infiniband/hw/mlx5/devx.c                  |    2 +-
 drivers/infiniband/hw/mlx5/macsec.c                |  364 +
 drivers/infiniband/hw/mlx5/macsec.h                |   29 +
 drivers/infiniband/hw/mlx5/main.c                  |   43 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |   17 +
 drivers/leds/trigger/ledtrig-netdev.c              |   10 +-
 drivers/net/Kconfig                                |   24 +
 drivers/net/arcnet/arcnet.c                        |    2 +-
 drivers/net/bonding/bond_alb.c                     |    2 +-
 drivers/net/bonding/bond_debugfs.c                 |   15 +-
 drivers/net/bonding/bond_main.c                    |  139 +-
 drivers/net/bonding/bond_sysfs.c                   |    4 +-
 drivers/net/can/Kconfig                            |    9 +-
 drivers/net/can/bxcan.c                            |    1 -
 drivers/net/can/c_can/c_can_platform.c             |    4 +-
 drivers/net/can/dev/rx-offload.c                   |   36 +-
 drivers/net/can/flexcan/flexcan-core.c             |   16 +-
 drivers/net/can/grcan.c                            |    3 +-
 drivers/net/can/ifi_canfd/ifi_canfd.c              |    1 -
 drivers/net/can/kvaser_pciefd.c                    |  307 +-
 drivers/net/can/m_can/m_can.c                      |   57 +-
 drivers/net/can/m_can/m_can.h                      |    5 +-
 drivers/net/can/m_can/m_can_platform.c             |   21 +-
 drivers/net/can/m_can/tcan4x5x-core.c              |  142 +-
 drivers/net/can/m_can/tcan4x5x-regmap.c            |    1 -
 drivers/net/can/rcar/rcar_canfd.c                  |    1 -
 drivers/net/can/sja1000/ems_pci.c                  |    6 +-
 drivers/net/can/sja1000/sja1000_platform.c         |    1 -
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c      |    6 +-
 drivers/net/can/sun4i_can.c                        |   23 +-
 drivers/net/can/ti_hecc.c                          |    5 +-
 drivers/net/can/usb/Kconfig                        |    1 +
 drivers/net/can/usb/esd_usb.c                      |  275 +-
 drivers/net/can/usb/gs_usb.c                       |  187 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |   13 -
 drivers/net/can/usb/peak_usb/pcan_usb_core.h       |    2 -
 drivers/net/can/usb/ucan.c                         |    2 +-
 drivers/net/can/xilinx_can.c                       |   25 +-
 drivers/net/dsa/Kconfig                            |    3 +-
 drivers/net/dsa/b53/b53_common.c                   |    6 -
 drivers/net/dsa/b53/b53_mdio.c                     |    1 +
 drivers/net/dsa/b53/b53_mmap.c                     |    1 +
 drivers/net/dsa/b53/b53_serdes.c                   |    2 +-
 drivers/net/dsa/b53/b53_serdes.h                   |    2 +-
 drivers/net/dsa/hirschmann/hellcreek.c             |    3 +-
 drivers/net/dsa/hirschmann/hellcreek.h             |    2 +-
 drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c    |    9 +-
 drivers/net/dsa/hirschmann/hellcreek_ptp.c         |    1 +
 drivers/net/dsa/lan9303-core.c                     |    7 +-
 drivers/net/dsa/microchip/ksz8.h                   |    2 -
 drivers/net/dsa/microchip/ksz8863_smi.c            |    3 +
 drivers/net/dsa/microchip/ksz9477.h                |    2 -
 drivers/net/dsa/microchip/ksz_common.c             |    4 +-
 drivers/net/dsa/mt7530-mmio.c                      |    3 +-
 drivers/net/dsa/mt7530.c                           |    6 -
 drivers/net/dsa/mv88e6060.c                        |   45 +
 drivers/net/dsa/mv88e6xxx/Makefile                 |    3 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |  426 +-
 drivers/net/dsa/mv88e6xxx/chip.h                   |   33 +-
 drivers/net/dsa/mv88e6xxx/pcs-6185.c               |  190 +
 drivers/net/dsa/mv88e6xxx/pcs-6352.c               |  390 +
 drivers/net/dsa/mv88e6xxx/pcs-639x.c               |  943 ++
 drivers/net/dsa/mv88e6xxx/port.c                   |   30 -
 drivers/net/dsa/mv88e6xxx/serdes.c                 | 1106 +--
 drivers/net/dsa/mv88e6xxx/serdes.h                 |  108 +-
 drivers/net/dsa/ocelot/felix.c                     |    6 -
 drivers/net/dsa/ocelot/felix_vsc9959.c             |    9 +-
 drivers/net/dsa/ocelot/seville_vsc9953.c           |    3 +-
 drivers/net/dsa/qca/ar9331.c                       |    2 +-
 drivers/net/dsa/qca/qca8k-8xxx.c                   |  198 +-
 drivers/net/dsa/qca/qca8k-common.c                 |   48 +
 drivers/net/dsa/qca/qca8k-leds.c                   |    1 +
 drivers/net/dsa/qca/qca8k.h                        |    6 +
 drivers/net/dsa/realtek/realtek-mdio.c             |    4 +-
 drivers/net/dsa/realtek/realtek-smi.c              |    3 +-
 drivers/net/dsa/realtek/rtl8366rb.c                |   28 +
 drivers/net/dsa/rzn1_a5psw.c                       |  236 +-
 drivers/net/dsa/rzn1_a5psw.h                       |    8 +-
 drivers/net/dsa/sja1105/sja1105_flower.c           |    8 +-
 drivers/net/dsa/sja1105/sja1105_main.c             |    7 -
 drivers/net/dsa/vitesse-vsc73xx-core.c             |    1 -
 drivers/net/dsa/xrs700x/xrs700x.c                  |    2 +-
 drivers/net/ethernet/8390/ne2k-pci.c               |   16 +-
 drivers/net/ethernet/adi/adin1110.c                |    8 +-
 drivers/net/ethernet/aeroflex/greth.c              |    4 +-
 drivers/net/ethernet/agere/et131x.c                |    3 +-
 drivers/net/ethernet/alacritech/slicoss.c          |    4 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |    2 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.h       |    1 +
 drivers/net/ethernet/amd/atarilance.c              |    2 +-
 drivers/net/ethernet/amd/pds_core/auxbus.c         |    2 +-
 drivers/net/ethernet/amd/pds_core/core.c           |   11 +-
 drivers/net/ethernet/amd/pds_core/dev.c            |    9 +-
 drivers/net/ethernet/amd/pds_core/devlink.c        |    3 +
 drivers/net/ethernet/amd/pds_core/main.c           |    6 +-
 drivers/net/ethernet/amd/sunlance.c                |    2 +-
 drivers/net/ethernet/apm/xgene-v2/main.h           |    1 +
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   |    6 +-
 drivers/net/ethernet/apple/macmace.c               |    2 +-
 .../ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c   |   12 +-
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c   |    2 +-
 drivers/net/ethernet/arc/emac_main.c               |    2 +-
 drivers/net/ethernet/atheros/ag71xx.c              |    3 +-
 drivers/net/ethernet/atheros/alx/ethtool.c         |    5 +-
 drivers/net/ethernet/broadcom/Kconfig              |   12 +
 drivers/net/ethernet/broadcom/Makefile             |    1 +
 drivers/net/ethernet/broadcom/asp2/Makefile        |    2 +
 drivers/net/ethernet/broadcom/asp2/bcmasp.c        | 1437 +++
 drivers/net/ethernet/broadcom/asp2/bcmasp.h        |  586 ++
 .../net/ethernet/broadcom/asp2/bcmasp_ethtool.c    |  503 ++
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   | 1415 +++
 .../net/ethernet/broadcom/asp2/bcmasp_intf_defs.h  |  257 +
 drivers/net/ethernet/broadcom/bcm63xx_enet.c       |    3 -
 drivers/net/ethernet/broadcom/bgmac.c              |    2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c     |    6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  311 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   27 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c      |   26 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.h      |    3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   49 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h      |  644 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c       |    6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |    6 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |    6 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |    2 +-
 drivers/net/ethernet/broadcom/tg3.c                |    8 +-
 drivers/net/ethernet/brocade/bna/bnad.c            |   13 +-
 drivers/net/ethernet/cadence/macb_main.c           |    1 -
 .../net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c   |   18 +-
 .../ethernet/chelsio/inline_crypto/chtls/chtls.h   |    1 +
 drivers/net/ethernet/cirrus/cs89x0.c               |    6 +-
 drivers/net/ethernet/cortina/gemini.c              |    8 +-
 drivers/net/ethernet/davicom/dm9051.c              |    9 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |    3 -
 drivers/net/ethernet/engleder/tsnep.h              |    1 +
 drivers/net/ethernet/engleder/tsnep_main.c         |    3 +-
 drivers/net/ethernet/ezchip/nps_enet.c             |    5 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |   16 +-
 drivers/net/ethernet/faraday/ftmac100.c            |   50 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |   12 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.h     |    1 +
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |    2 +
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |    1 -
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h   |    1 +
 .../ethernet/freescale/dpaa2/dpaa2-switch-flower.c |   22 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |    1 -
 drivers/net/ethernet/freescale/enetc/enetc.h       |    1 +
 drivers/net/ethernet/freescale/enetc/enetc_ierb.c  |    2 +-
 drivers/net/ethernet/freescale/enetc/enetc_qos.c   |    8 +-
 drivers/net/ethernet/freescale/fec.h               |   18 +-
 drivers/net/ethernet/freescale/fec_main.c          |  314 +-
 drivers/net/ethernet/freescale/fec_mpc52xx.c       |   10 +-
 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c   |    9 +-
 drivers/net/ethernet/freescale/fec_ptp.c           |   60 +-
 drivers/net/ethernet/freescale/fman/fman.c         |    1 +
 drivers/net/ethernet/freescale/fman/fman_port.c    |    1 +
 drivers/net/ethernet/freescale/fman/mac.c          |    6 +-
 drivers/net/ethernet/freescale/fman/mac.h          |    4 -
 .../net/ethernet/freescale/fs_enet/fs_enet-main.c  |    7 +-
 drivers/net/ethernet/freescale/fs_enet/fs_enet.h   |   24 +-
 drivers/net/ethernet/freescale/fs_enet/mac-fcc.c   |    5 +-
 drivers/net/ethernet/freescale/fs_enet/mac-fec.c   |   15 -
 drivers/net/ethernet/freescale/fs_enet/mac-scc.c   |    9 +-
 .../net/ethernet/freescale/fs_enet/mii-bitbang.c   |   10 +-
 drivers/net/ethernet/freescale/fs_enet/mii-fec.c   |    7 +-
 drivers/net/ethernet/freescale/fsl_pq_mdio.c       |    7 +-
 drivers/net/ethernet/freescale/gianfar.c           |    8 +-
 drivers/net/ethernet/freescale/gianfar_ethtool.c   |    2 +
 drivers/net/ethernet/freescale/ucc_geth.c          |    9 +-
 drivers/net/ethernet/freescale/xgmac_mdio.c        |    4 +-
 drivers/net/ethernet/fungible/funeth/funeth_txrx.h |    1 +
 drivers/net/ethernet/google/gve/gve.h              |  113 +-
 drivers/net/ethernet/google/gve/gve_adminq.c       |   89 +-
 drivers/net/ethernet/google/gve/gve_adminq.h       |   10 +
 drivers/net/ethernet/google/gve/gve_desc.h         |    4 +-
 drivers/net/ethernet/google/gve/gve_main.c         |   20 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |  126 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       |  404 +-
 drivers/net/ethernet/hisilicon/hip04_eth.c         |    4 +-
 drivers/net/ethernet/hisilicon/hisi_femac.c        |    4 +-
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c      |    5 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h  |    1 -
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  |    3 -
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |    4 -
 drivers/net/ethernet/hisilicon/hns3/Makefile       |    4 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |    1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |    1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |    2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |    2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |    8 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |    1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  576 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |    3 -
 .../ethernet/hisilicon/hns3/hns3pf/hclge_regs.c    |  668 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_regs.h    |   17 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  121 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |    1 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c  |  164 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.h  |   13 +
 drivers/net/ethernet/hisilicon/hns_mdio.c          |   10 +-
 drivers/net/ethernet/ibm/ehea/ehea_main.c          |    1 +
 drivers/net/ethernet/ibm/emac/core.c               |    1 +
 drivers/net/ethernet/ibm/emac/core.h               |    1 -
 drivers/net/ethernet/ibm/emac/mal.c                |    2 +
 drivers/net/ethernet/ibm/emac/rgmii.c              |    2 +
 drivers/net/ethernet/ibm/emac/tah.c                |    2 +
 drivers/net/ethernet/ibm/emac/zmii.c               |    2 +
 drivers/net/ethernet/ibm/ibmvnic.c                 |    3 +-
 drivers/net/ethernet/intel/e1000/e1000.h           |    1 -
 drivers/net/ethernet/intel/e1000/e1000_hw.h        |    3 -
 drivers/net/ethernet/intel/e1000e/ethtool.c        |    2 +
 drivers/net/ethernet/intel/e1000e/hw.h             |    3 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |    7 +
 drivers/net/ethernet/intel/e1000e/mac.h            |    2 -
 drivers/net/ethernet/intel/e1000e/netdev.c         |    8 +-
 drivers/net/ethernet/intel/e1000e/ptp.c            |    1 +
 drivers/net/ethernet/intel/i40e/i40e_adminq.c      |   49 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.h      |    3 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  116 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb.c         |   20 +-
 drivers/net/ethernet/intel/i40e/i40e_ddp.c         |    6 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |    4 +-
 drivers/net/ethernet/intel/i40e/i40e_diag.c        |    6 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_hmc.c         |   21 +-
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c     |   54 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   72 +-
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |   52 +-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   17 -
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_status.h      |   43 -
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |    4 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |    2 +
 drivers/net/ethernet/intel/i40e/i40e_type.h        |    9 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  253 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |  101 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |    6 +-
 drivers/net/ethernet/intel/iavf/iavf_client.c      |    4 +-
 drivers/net/ethernet/intel/iavf/iavf_client.h      |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   18 +-
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |   75 +-
 drivers/net/ethernet/intel/ice/Makefile            |    2 +-
 drivers/net/ethernet/intel/ice/ice.h               |   31 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |  107 +-
 drivers/net/ethernet/intel/ice/ice_base.c          |    9 +-
 drivers/net/ethernet/intel/ice/ice_common.c        |  285 +-
 drivers/net/ethernet/intel/ice/ice_common.h        |   12 +-
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c        |   50 +
 drivers/net/ethernet/intel/ice/ice_ddp.c           |  120 +-
 drivers/net/ethernet/intel/ice/ice_ddp.h           |   10 -
 drivers/net/ethernet/intel/ice/ice_eswitch.c       |   50 +-
 drivers/net/ethernet/intel/ice/ice_eswitch_br.c    | 1346 +++
 drivers/net/ethernet/intel/ice/ice_eswitch_br.h    |  120 +
 drivers/net/ethernet/intel/ice/ice_fw_update.c     |   45 +-
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h    |    3 +-
 drivers/net/ethernet/intel/ice/ice_lag.c           | 1946 +++-
 drivers/net/ethernet/intel/ice/ice_lag.h           |   34 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |  129 +-
 drivers/net/ethernet/intel/ice/ice_lib.h           |    7 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  181 +-
 drivers/net/ethernet/intel/ice/ice_protocol_type.h |    9 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        |  438 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h        |   10 +-
 drivers/net/ethernet/intel/ice/ice_repr.c          |    2 +-
 drivers/net/ethernet/intel/ice/ice_repr.h          |    3 +-
 drivers/net/ethernet/intel/ice/ice_sched.c         |   39 +-
 drivers/net/ethernet/intel/ice/ice_sched.h         |   25 +-
 drivers/net/ethernet/intel/ice/ice_switch.c        |  309 +-
 drivers/net/ethernet/intel/ice/ice_switch.h        |   37 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c        |   78 +-
 drivers/net/ethernet/intel/ice/ice_trace.h         |   90 +
 drivers/net/ethernet/intel/ice/ice_type.h          |   12 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |  465 +-
 .../net/ethernet/intel/ice/ice_vf_lib_private.h    |    2 -
 .../net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c   |  186 +-
 .../net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.h   |    4 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |   10 +-
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c  |   84 +-
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.h  |    8 +
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_ops.h  |    1 +
 drivers/net/ethernet/intel/ice/ice_xsk.c           |  221 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   19 +-
 drivers/net/ethernet/intel/igc/igc.h               |   19 +-
 drivers/net/ethernet/intel/igc/igc_base.h          |    3 +
 drivers/net/ethernet/intel/igc/igc_defines.h       |    9 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   76 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c           |  174 +-
 drivers/net/ethernet/intel/igc/igc_regs.h          |   12 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h           |    6 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.h    |    1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |    3 -
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h       |    3 -
 drivers/net/ethernet/korina.c                      |    2 +-
 drivers/net/ethernet/marvell/mvmdio.c              |    4 +-
 drivers/net/ethernet/marvell/mvneta.c              |    2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h         |    2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c |   10 -
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |    2 +-
 .../ethernet/marvell/octeon_ep/octep_cp_version.h  |   11 +
 .../ethernet/marvell/octeon_ep/octep_ctrl_mbox.c   |    9 +-
 .../ethernet/marvell/octeon_ep/octep_ctrl_mbox.h   |    6 +
 .../ethernet/marvell/octeon_ep/octep_ctrl_net.c    |   37 +-
 .../ethernet/marvell/octeon_ep/octep_ctrl_net.h    |    4 +
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |   37 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h    |    1 +
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |   26 +-
 drivers/net/ethernet/marvell/octeontx2/af/npc.h    |    4 +
 drivers/net/ethernet/marvell/octeontx2/af/ptp.c    |  155 +-
 drivers/net/ethernet/marvell/octeontx2/af/ptp.h    |    3 +-
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c    |   17 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |    2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   12 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |   12 +-
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |    9 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |   35 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.c   |   20 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_switch.c |    6 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   26 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   22 +-
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c    |   19 +-
 .../ethernet/marvell/octeontx2/nic/otx2_devlink.c  |    1 -
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |    1 +
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |    2 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |    3 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_ptp.c  |  177 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |  470 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.h |    2 +
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c   |  398 +-
 drivers/net/ethernet/marvell/octeontx2/nic/qos.h   |   11 +-
 .../ethernet/marvell/prestera/prestera_flower.c    |   20 +-
 .../net/ethernet/marvell/prestera/prestera_rxtx.c  |    3 -
 drivers/net/ethernet/marvell/sky2.c                |    3 +-
 drivers/net/ethernet/mediatek/mtk_eth_path.c       |   36 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  694 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h        |  376 +-
 drivers/net/ethernet/mediatek/mtk_ppe.c            |   56 +-
 drivers/net/ethernet/mediatek/mtk_ppe.h            |   22 +-
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c    |    2 +-
 drivers/net/ethernet/mediatek/mtk_ppe_regs.h       |    2 +
 drivers/net/ethernet/mediatek/mtk_star_emac.c      |    1 -
 drivers/net/ethernet/mediatek/mtk_wed.c            |    5 +-
 drivers/net/ethernet/mediatek/mtk_wed_debugfs.c    |   24 +-
 drivers/net/ethernet/mediatek/mtk_wed_regs.h       |    2 +
 drivers/net/ethernet/mediatek/mtk_wed_wo.c         |    3 +-
 drivers/net/ethernet/mellanox/mlx4/Kconfig         |    1 +
 drivers/net/ethernet/mellanox/mlx4/catas.c         |    2 +-
 drivers/net/ethernet/mellanox/mlx4/cmd.c           |    4 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |   10 +-
 drivers/net/ethernet/mellanox/mlx4/en_main.c       |  155 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |   66 +-
 drivers/net/ethernet/mellanox/mlx4/eq.c            |   15 +-
 drivers/net/ethernet/mellanox/mlx4/intf.c          |  363 +-
 drivers/net/ethernet/mellanox/mlx4/main.c          |  118 +-
 drivers/net/ethernet/mellanox/mlx4/mcg.c           |    4 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4.h          |   18 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h       |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig    |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |   10 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |  223 +-
 drivers/net/ethernet/mellanox/mlx5/core/debugfs.c  |   34 +-
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |    3 +
 drivers/net/ethernet/mellanox/mlx5/core/devlink.h  |    8 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |    7 +-
 .../net/ethernet/mellanox/mlx5/core/en/health.h    |    1 +
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |  237 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h   |   59 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c   |    4 +-
 .../ethernet/mellanox/mlx5/core/en/rep/bridge.c    |    4 +
 .../net/ethernet/mellanox/mlx5/core/en/rep/tc.c    |   17 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |   65 +
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.c    |   25 +-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.h    |    7 +-
 .../ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c |   25 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/trap.c  |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |    1 +
 .../mellanox/mlx5/core/en_accel/en_accel.h         |    4 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |   62 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |   77 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |  773 +-
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c    |   11 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c       |   25 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h       |    6 +-
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c  |  176 +-
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.h  |   26 +-
 .../mellanox/mlx5/core/en_accel/macsec_fs.c        | 1394 ---
 .../mellanox/mlx5/core/en_accel/macsec_fs.h        |   47 -
 .../mellanox/mlx5/core/en_accel/macsec_stats.c     |   22 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  |   21 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |    9 +-
 .../ethernet/mellanox/mlx5/core/en_fs_ethtool.c    |   37 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   15 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   22 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |    5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |   30 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |   17 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  136 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |   28 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |  360 +-
 .../net/ethernet/mellanox/mlx5/core/esw/bridge.c   |   22 +-
 .../ethernet/mellanox/mlx5/core/esw/bridge_mcast.c |   17 +-
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |  195 +-
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec.c    |  369 +
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c |  325 +
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h |   67 +
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  202 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |  129 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  665 +-
 .../net/ethernet/mellanox/mlx5/core/fpga/conn.c    |    2 +-
 .../net/ethernet/mellanox/mlx5/core/fpga/core.c    |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   51 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c       |   59 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |   39 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |   36 +-
 drivers/net/ethernet/mellanox/mlx5/core/hwmon.c    |  418 +
 drivers/net/ethernet/mellanox/mlx5/core/hwmon.h    |   24 +
 .../net/ethernet/mellanox/mlx5/core/irq_affinity.c |   78 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c  |    2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |   32 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   |  449 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |   74 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h   |    2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c  |    2 +-
 .../ethernet/mellanox/mlx5/core/lib/macsec_fs.c    | 2411 +++++
 .../ethernet/mellanox/mlx5/core/lib/macsec_fs.h    |   64 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   51 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |    6 +
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h |   26 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |   74 +-
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |    2 +-
 .../net/ethernet/mellanox/mlx5/core/sf/dev/dev.c   |   12 +-
 .../net/ethernet/mellanox/mlx5/core/sf/devlink.c   |   12 +-
 .../net/ethernet/mellanox/mlx5/core/sf/hw_table.c  |   49 +-
 .../mellanox/mlx5/core/steering/dr_action.c        |    1 -
 .../ethernet/mellanox/mlx5/core/steering/dr_send.c |  119 +-
 .../ethernet/mellanox/mlx5/core/steering/fs_dr.c   |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/thermal.c  |  114 -
 drivers/net/ethernet/mellanox/mlx5/core/thermal.h  |   20 -
 .../net/ethernet/mellanox/mlxbf_gige/mlxbf_gige.h  |    3 -
 drivers/net/ethernet/mellanox/mlxsw/Makefile       |    2 +-
 .../mellanox/mlxsw/core_acl_flex_actions.c         |   40 +
 .../mellanox/mlxsw/core_acl_flex_actions.h         |    2 +
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.c   |    1 +
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.h   |    1 +
 drivers/net/ethernet/mellanox/mlxsw/core_env.c     |   45 +-
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c   |    3 +-
 drivers/net/ethernet/mellanox/mlxsw/i2c.c          |    5 +-
 drivers/net/ethernet/mellanox/mlxsw/reg.h          |  166 +-
 drivers/net/ethernet/mellanox/mlxsw/resources.h    |    2 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |  368 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |   37 +-
 .../ethernet/mellanox/mlxsw/spectrum1_acl_tcam.c   |    4 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c |   20 +-
 .../mellanox/mlxsw/spectrum_acl_flex_keys.c        |    3 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c |   10 -
 .../net/ethernet/mellanox/mlxsw/spectrum_flower.c  |   98 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c |    7 +-
 .../ethernet/mellanox/mlxsw/spectrum_port_range.c  |  200 +
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |  626 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.h  |   11 +
 .../net/ethernet/mellanox/mlxsw/spectrum_span.h    |    5 -
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  193 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |    2 +-
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  |    1 +
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |   65 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |   15 +-
 .../net/ethernet/microchip/lan966x/lan966x_ptp.c   |   38 +-
 .../ethernet/microchip/lan966x/lan966x_tc_flower.c |    4 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   10 +-
 .../net/ethernet/microchip/sparx5/sparx5_netdev.c  |   35 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c |   24 +-
 .../ethernet/microchip/sparx5/sparx5_tc_flower.c   |    6 +-
 drivers/net/ethernet/microchip/vcap/vcap_api.c     |    4 +-
 drivers/net/ethernet/microchip/vcap/vcap_api.h     |    3 -
 .../net/ethernet/microchip/vcap/vcap_api_client.h  |    3 -
 drivers/net/ethernet/microchip/vcap/vcap_tc.c      |   18 +-
 drivers/net/ethernet/microchip/vcap/vcap_tc.h      |    2 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |   35 +-
 drivers/net/ethernet/microsoft/mana/hw_channel.c   |   24 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  142 +-
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c |   15 +
 drivers/net/ethernet/mscc/ocelot.h                 |    2 -
 drivers/net/ethernet/mscc/ocelot_fdma.c            |    1 -
 drivers/net/ethernet/mscc/ocelot_flower.c          |   28 +-
 drivers/net/ethernet/mscc/ocelot_vcap.h            |    1 -
 drivers/net/ethernet/mscc/ocelot_vsc7514.c         |    3 +-
 drivers/net/ethernet/neterion/s2io.c               |   17 +-
 .../net/ethernet/netronome/nfp/flower/conntrack.c  |   43 +-
 .../net/ethernet/netronome/nfp/flower/offload.c    |   64 +-
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |   57 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h  |    1 +
 drivers/net/ethernet/ni/nixge.c                    |    5 +-
 drivers/net/ethernet/pensando/ionic/ionic.h        |    1 -
 .../net/ethernet/pensando/ionic/ionic_bus_pci.c    |  160 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |    1 -
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   70 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.h    |    5 +
 .../net/ethernet/pensando/ionic/ionic_rx_filter.h  |    1 -
 drivers/net/ethernet/qlogic/qed/qed.h              |    1 -
 drivers/net/ethernet/qlogic/qed/qed_vf.c           |   45 +-
 drivers/net/ethernet/qlogic/qede/qede.h            |    3 -
 drivers/net/ethernet/qlogic/qede/qede_filter.c     |   12 +-
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.c    |    2 +
 drivers/net/ethernet/qualcomm/emac/emac.c          |    1 -
 drivers/net/ethernet/qualcomm/qca_spi.c            |    1 -
 drivers/net/ethernet/qualcomm/qca_uart.c           |    3 +-
 drivers/net/ethernet/realtek/r8169_main.c          |    4 -
 drivers/net/ethernet/renesas/ravb_main.c           |    3 +-
 drivers/net/ethernet/renesas/rswitch.c             |   32 +-
 drivers/net/ethernet/renesas/rswitch.h             |    1 +
 drivers/net/ethernet/renesas/sh_eth.c              |    2 -
 drivers/net/ethernet/sfc/Makefile                  |    2 +-
 drivers/net/ethernet/sfc/bitfield.h                |    2 +
 drivers/net/ethernet/sfc/ef10.c                    |    4 +-
 drivers/net/ethernet/sfc/ef100_nic.c               |    2 +-
 drivers/net/ethernet/sfc/ef100_tx.c                |    6 +-
 drivers/net/ethernet/sfc/ef10_sriov.h              |    2 -
 drivers/net/ethernet/sfc/efx.c                     |    1 -
 drivers/net/ethernet/sfc/efx.h                     |    2 -
 drivers/net/ethernet/sfc/efx_channels.c            |   30 +-
 drivers/net/ethernet/sfc/efx_common.c              |    7 -
 drivers/net/ethernet/sfc/farch_regs.h              | 2929 ------
 drivers/net/ethernet/sfc/filter.h                  |    7 -
 drivers/net/ethernet/sfc/io.h                      |   84 +-
 drivers/net/ethernet/sfc/mae.c                     |  916 +-
 drivers/net/ethernet/sfc/mae.h                     |   16 +
 drivers/net/ethernet/sfc/mcdi.c                    |    7 -
 drivers/net/ethernet/sfc/mcdi.h                    |   14 +
 drivers/net/ethernet/sfc/mcdi_functions.c          |   24 +-
 drivers/net/ethernet/sfc/mcdi_port_common.c        |    5 -
 drivers/net/ethernet/sfc/net_driver.h              |   63 +-
 drivers/net/ethernet/sfc/nic.c                     |  158 -
 drivers/net/ethernet/sfc/nic.h                     |  178 -
 drivers/net/ethernet/sfc/nic_common.h              |   13 +-
 drivers/net/ethernet/sfc/ptp.c                     |  231 +-
 drivers/net/ethernet/sfc/selftest.c                |    7 +-
 drivers/net/ethernet/sfc/tc.c                      | 1076 ++-
 drivers/net/ethernet/sfc/tc.h                      |  144 +-
 drivers/net/ethernet/sfc/tc_conntrack.c            |  533 ++
 drivers/net/ethernet/sfc/tc_conntrack.h            |   55 +
 drivers/net/ethernet/sfc/tc_counters.c             |    8 +-
 drivers/net/ethernet/sfc/tc_counters.h             |    4 +
 drivers/net/ethernet/sfc/tx.c                      |   45 +-
 drivers/net/ethernet/sfc/tx_tso.c                  |    2 +-
 drivers/net/ethernet/sfc/vfdi.h                    |  252 -
 drivers/net/ethernet/sfc/workarounds.h             |    7 -
 drivers/net/ethernet/smsc/smsc911x.c               |    5 +-
 drivers/net/ethernet/smsc/smsc9420.c               |    7 +-
 drivers/net/ethernet/socionext/netsec.c            |    2 +-
 drivers/net/ethernet/socionext/sni_ave.c           |    3 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   11 -
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 -
 drivers/net/ethernet/stmicro/stmmac/common.h       |   78 +-
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |    8 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |   65 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ingenic.c    |   21 +-
 .../net/ethernet/stmicro/stmmac/dwmac-intel-plat.c |    4 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   27 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ipq806x.c    |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c    |    4 +-
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |    9 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c  |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-oxnas.c  |  245 -
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |   57 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |    4 +-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |    4 +-
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   |   10 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    |    9 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |    9 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   23 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c  |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c  |    6 +-
 .../net/ethernet/stmicro/stmmac/dwmac-visconti.c   |    5 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c |    7 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |    8 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |   16 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |   15 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    |   12 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   39 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |   50 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_descs.c   |    6 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |   53 +-
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c     |   20 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   19 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c    |   15 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |    5 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  123 +-
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |   47 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  417 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   39 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   |    2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   19 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |    5 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h   |    6 +
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c |    6 +-
 drivers/net/ethernet/sun/ldmvsw.c                  |    3 +-
 drivers/net/ethernet/sun/niu.c                     |    2 +-
 drivers/net/ethernet/sun/sunbmac.c                 |    2 +-
 drivers/net/ethernet/sun/sungem.c                  |    1 +
 drivers/net/ethernet/sun/sunhme.c                  |    3 +-
 drivers/net/ethernet/sun/sunqe.c                   |    2 +-
 drivers/net/ethernet/ti/Kconfig                    |   25 +
 drivers/net/ethernet/ti/Makefile                   |   11 +
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |    1 +
 drivers/net/ethernet/ti/am65-cpsw-nuss.h           |    1 -
 drivers/net/ethernet/ti/am65-cpsw-qos.c            |    6 +-
 drivers/net/ethernet/ti/cpsw-common.c              |    1 -
 drivers/net/ethernet/ti/cpsw-phy-sel.c             |    1 -
 drivers/net/ethernet/ti/cpsw.c                     |    2 +-
 drivers/net/ethernet/ti/cpsw_new.c                 |    2 +-
 drivers/net/ethernet/ti/cpsw_priv.c                |    8 +-
 drivers/net/ethernet/ti/cpsw_priv.h                |    1 +
 drivers/net/ethernet/ti/davinci_mdio.c             |    1 -
 drivers/net/ethernet/ti/icssg/icss_iep.c           |  965 ++
 drivers/net/ethernet/ti/icssg/icss_iep.h           |   41 +
 drivers/net/ethernet/ti/icssg/icssg_classifier.c   |  367 +
 drivers/net/ethernet/ti/icssg/icssg_config.c       |  457 +
 drivers/net/ethernet/ti/icssg/icssg_config.h       |  200 +
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c      |  209 +
 drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c      |  120 +
 drivers/net/ethernet/ti/icssg/icssg_mii_rt.h       |  151 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       | 2336 +++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h       |  286 +
 drivers/net/ethernet/ti/icssg/icssg_queues.c       |   50 +
 drivers/net/ethernet/ti/icssg/icssg_stats.c        |   57 +
 drivers/net/ethernet/ti/icssg/icssg_stats.h        |  158 +
 drivers/net/ethernet/ti/icssg/icssg_switch_map.h   |  234 +
 drivers/net/ethernet/ti/netcp.h                    |    2 -
 drivers/net/ethernet/toshiba/tc35815.c             |    3 +-
 drivers/net/ethernet/via/via-rhine.c               |    2 +-
 drivers/net/ethernet/via/via-velocity.c            |    2 +-
 drivers/net/ethernet/wangxun/Kconfig               |    1 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |   68 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h         |    2 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |    2 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |   34 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c   |   35 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c      |   64 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c      |   88 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h      |   19 -
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c      |   39 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.h      |    2 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |   56 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |  188 +-
 drivers/net/ethernet/xilinx/ll_temac.h             |    1 +
 drivers/net/ethernet/xilinx/ll_temac_main.c        |    4 +-
 drivers/net/ethernet/xilinx/ll_temac_mdio.c        |    2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |    3 +-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c      |    4 +-
 drivers/net/gtp.c                                  |    3 +-
 drivers/net/hyperv/hyperv_net.h                    |    1 +
 drivers/net/ieee802154/ca8210.c                    |    1 -
 drivers/net/ipa/ipa_main.c                         |    2 +-
 drivers/net/macsec.c                               |   29 +-
 drivers/net/macvlan.c                              |   34 +-
 drivers/net/mdio/mdio-bcm-unimac.c                 |    2 +
 drivers/net/mdio/mdio-xgene.c                      |    9 +-
 drivers/net/mhi_net.c                              |    1 -
 drivers/net/netconsole.c                           |  163 +-
 drivers/net/netdevsim/Makefile                     |    4 +
 drivers/net/netdevsim/ethtool.c                    |   11 +
 drivers/net/netdevsim/macsec.c                     |  356 +
 drivers/net/netdevsim/netdev.c                     |   41 +-
 drivers/net/netdevsim/netdevsim.h                  |   36 +
 drivers/net/pcs/Makefile                           |    2 +-
 drivers/net/pcs/pcs-lynx.c                         |    2 +-
 drivers/net/pcs/pcs-mtk-lynxi.c                    |    8 +
 drivers/net/pcs/pcs-rzn1-miic.c                    |    1 +
 drivers/net/pcs/pcs-xpcs-wx.c                      |  209 +
 drivers/net/pcs/pcs-xpcs.c                         |  112 +-
 drivers/net/pcs/pcs-xpcs.h                         |   17 +
 drivers/net/phy/Kconfig                            |    9 +-
 drivers/net/phy/Makefile                           |    3 +
 drivers/net/phy/at803x.c                           |  135 +-
 drivers/net/phy/bcm7xxx.c                          |    1 +
 drivers/net/phy/dp83640.c                          |   15 +-
 drivers/net/phy/marvell-88q2xxx.c                  |  263 +
 drivers/net/phy/marvell-88x2222.c                  |    1 -
 drivers/net/phy/marvell.c                          |  281 +
 drivers/net/phy/mdio_bus.c                         |   37 +-
 drivers/net/phy/mediatek-ge-soc.c                  |  437 +-
 drivers/net/phy/motorcomm.c                        |  118 +
 drivers/net/phy/nxp-c45-tja11xx.c                  | 1136 ++-
 drivers/net/phy/phy-c45.c                          |   63 +-
 drivers/net/phy/phy-core.c                         |    2 +
 drivers/net/phy/phy.c                              |   34 +
 drivers/net/phy/phy_device.c                       |   96 +-
 drivers/net/phy/phylink.c                          |  199 +-
 drivers/net/phy/sfp.c                              |    3 +
 drivers/net/phy/sfp.h                              |    1 -
 drivers/net/phy/smsc.c                             |  252 +-
 drivers/net/phy/stubs.c                            |   10 +
 drivers/net/ppp/pppoe.c                            |    4 +-
 drivers/net/ppp/pptp.c                             |    8 +-
 drivers/net/tap.c                                  |    5 +-
 drivers/net/team/team.c                            |   65 +-
 drivers/net/team/team_mode_activebackup.c          |    8 +-
 drivers/net/team/team_mode_broadcast.c             |    1 -
 drivers/net/team/team_mode_loadbalance.c           |   50 +-
 drivers/net/team/team_mode_roundrobin.c            |    1 -
 drivers/net/tun.c                                  |   11 +-
 drivers/net/usb/r8152.c                            |  108 +-
 drivers/net/veth.c                                 |    7 +-
 drivers/net/virtio_net.c                           |  215 +-
 drivers/net/vmxnet3/Makefile                       |    2 +-
 drivers/net/vmxnet3/vmxnet3_drv.c                  |  236 +-
 drivers/net/vmxnet3/vmxnet3_ethtool.c              |   23 +
 drivers/net/vmxnet3/vmxnet3_int.h                  |   43 +-
 drivers/net/vmxnet3/vmxnet3_xdp.c                  |  419 +
 drivers/net/vmxnet3/vmxnet3_xdp.h                  |   47 +
 drivers/net/vrf.c                                  |    2 -
 drivers/net/vxlan/vxlan_core.c                     |   57 +-
 drivers/net/vxlan/vxlan_vnifilter.c                |    2 +-
 drivers/net/wireguard/netlink.c                    |    2 +-
 drivers/net/wireless/ath/ath10k/ahb.c              |    4 +-
 drivers/net/wireless/ath/ath10k/htt.h              |    4 +-
 drivers/net/wireless/ath/ath10k/pci.c              |    4 +-
 drivers/net/wireless/ath/ath10k/sdio.c             |    2 +-
 drivers/net/wireless/ath/ath10k/usb.c              |    2 +-
 drivers/net/wireless/ath/ath10k/wmi.h              |    8 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |   43 +-
 drivers/net/wireless/ath/ath11k/ce.h               |    3 -
 drivers/net/wireless/ath/ath11k/core.c             |   38 +-
 drivers/net/wireless/ath/ath11k/core.h             |    1 +
 drivers/net/wireless/ath/ath11k/dp.h               |    2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |    4 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c            |   12 +-
 drivers/net/wireless/ath/ath11k/hw.h               |    3 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   68 +-
 drivers/net/wireless/ath/ath11k/pci.c              |    4 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |   35 +-
 drivers/net/wireless/ath/ath11k/qmi.h              |    5 +-
 drivers/net/wireless/ath/ath11k/testmode.c         |    2 +-
 drivers/net/wireless/ath/ath12k/ce.h               |    3 -
 drivers/net/wireless/ath/ath12k/core.h             |   35 +-
 drivers/net/wireless/ath/ath12k/dp.c               |   30 +-
 drivers/net/wireless/ath/ath12k/dp.h               |    4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   13 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |   10 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  594 +-
 drivers/net/wireless/ath/ath12k/mac.h              |    2 +-
 drivers/net/wireless/ath/ath12k/pci.c              |    2 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |    2 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |    2 -
 drivers/net/wireless/ath/ath12k/rx_desc.h          |    2 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  280 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |  121 +-
 drivers/net/wireless/ath/ath5k/ahb.c               |    1 -
 drivers/net/wireless/ath/ath5k/debug.c             |    2 -
 drivers/net/wireless/ath/ath5k/mac80211-ops.c      |    1 -
 drivers/net/wireless/ath/ath5k/phy.c               |   29 +-
 drivers/net/wireless/ath/ath6kl/debug.c            |    2 -
 drivers/net/wireless/ath/ath9k/ahb.c               |    4 +-
 drivers/net/wireless/ath/ath9k/ath9k.h             |    1 -
 drivers/net/wireless/ath/ath9k/common-spectral.c   |   53 +-
 drivers/net/wireless/ath/ath9k/common.h            |    2 -
 drivers/net/wireless/ath/ath9k/debug.c             |  108 +-
 drivers/net/wireless/ath/ath9k/dfs_debug.c         |   14 +-
 drivers/net/wireless/ath/ath9k/eeprom_9287.c       |    3 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |    2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |   15 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c      |    3 +-
 drivers/net/wireless/ath/ath9k/mac.h               |    6 +-
 drivers/net/wireless/ath/ath9k/main.c              |    1 -
 drivers/net/wireless/ath/ath9k/pci.c               |    4 +-
 drivers/net/wireless/ath/ath9k/tx99.c              |   14 +-
 drivers/net/wireless/ath/ath9k/wmi.c               |   20 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |    6 +-
 drivers/net/wireless/ath/key.c                     |    2 +-
 drivers/net/wireless/ath/wcn36xx/main.c            |    3 +-
 drivers/net/wireless/ath/wil6210/txrx.c            |    2 +-
 drivers/net/wireless/ath/wil6210/txrx.h            |    6 +-
 drivers/net/wireless/ath/wil6210/txrx_edma.c       |    2 +-
 drivers/net/wireless/ath/wil6210/txrx_edma.h       |    6 +-
 drivers/net/wireless/atmel/at76c50x-usb.c          |    8 +-
 .../wireless/broadcom/brcm80211/brcmsmac/aiutils.h |    8 -
 .../wireless/broadcom/brcm80211/brcmsmac/ampdu.c   |    6 -
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |    8 +-
 .../wireless/broadcom/brcm80211/brcmsmac/main.c    |    2 -
 .../broadcom/brcm80211/brcmsmac/phy/phy_hal.h      |    5 -
 .../net/wireless/broadcom/brcm80211/brcmsmac/pub.h |    2 +-
 .../net/wireless/broadcom/brcm80211/brcmsmac/scb.h |   14 -
 .../wireless/broadcom/brcm80211/brcmsmac/types.h   |    9 -
 drivers/net/wireless/intel/ipw2x00/ipw2200.c       |   39 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |    5 +
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |    9 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |    3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h        |    2 +
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |    2 +
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |    7 +-
 drivers/net/wireless/intel/iwlwifi/mei/main.c      |   70 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   11 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   11 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |    4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   31 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |   24 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c      |  142 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.h      |   26 +-
 drivers/net/wireless/intersil/orinoco/airport.c    |    2 +-
 .../net/wireless/intersil/orinoco/orinoco_usb.c    |   12 +-
 drivers/net/wireless/legacy/rndis_wlan.c           |    2 +-
 drivers/net/wireless/marvell/libertas/if_sdio.c    |   73 +-
 drivers/net/wireless/marvell/libertas/if_spi.c     |   20 +-
 drivers/net/wireless/marvell/libertas/mesh.c       |   51 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |    1 +
 drivers/net/wireless/marvell/mwifiex/debugfs.c     |   19 +-
 drivers/net/wireless/marvell/mwifiex/decl.h        |    1 -
 drivers/net/wireless/marvell/mwifiex/init.c        |    2 -
 drivers/net/wireless/marvell/mwifiex/main.c        |   11 +-
 drivers/net/wireless/marvell/mwifiex/main.h        |   20 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c        |   25 +-
 drivers/net/wireless/marvell/mwifiex/scan.c        |    7 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c        |   26 +-
 drivers/net/wireless/marvell/mwifiex/sta_rx.c      |   12 +-
 drivers/net/wireless/marvell/mwifiex/sta_tx.c      |   15 +-
 drivers/net/wireless/marvell/mwifiex/tdls.c        |    9 +-
 drivers/net/wireless/marvell/mwifiex/txrx.c        |   44 +-
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c    |   45 +-
 drivers/net/wireless/marvell/mwifiex/util.c        |   10 +-
 drivers/net/wireless/mediatek/mt76/Kconfig         |    8 +
 drivers/net/wireless/mediatek/mt76/Makefile        |   10 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |    6 +
 drivers/net/wireless/mediatek/mt76/eeprom.c        |   87 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |    7 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |  107 +-
 drivers/net/wireless/mediatek/mt76/mt7603/Kconfig  |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7603/init.c   |    2 -
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |   43 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |   25 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7603/regs.h   |    7 +
 drivers/net/wireless/mediatek/mt76/mt7615/Kconfig  |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    |   31 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |   49 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h |    4 -
 .../wireless/mediatek/mt76/mt7615/mt7615_trace.h   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h   |    9 +
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |   20 +-
 .../net/wireless/mediatek/mt76/mt76_connac2_mac.h  |    2 +-
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.c  |  182 +
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  |  339 +
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |  106 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |    6 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig  |    4 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c   |    3 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_trace.h |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig  |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/Kconfig  |    8 +-
 drivers/net/wireless/mediatek/mt76/mt7915/Makefile |    2 +-
 .../net/wireless/mediatek/mt76/mt7915/coredump.c   |    7 +-
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c    |  128 +-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c    |  152 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   20 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |  194 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h    |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |  233 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |  151 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |   47 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |  100 +-
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h   |   16 +-
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c    |  163 +-
 drivers/net/wireless/mediatek/mt76/mt7921/Kconfig  |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/Makefile |    9 +-
 .../net/wireless/mediatek/mt76/mt7921/acpi_sar.h   |  105 -
 .../net/wireless/mediatek/mt76/mt7921/debugfs.c    |  228 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |  343 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |  554 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |  806 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |  230 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |  359 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |  225 +-
 .../net/wireless/mediatek/mt76/mt7921/pci_mac.c    |   34 +-
 .../net/wireless/mediatek/mt76/mt7921/pci_mcu.c    |   71 +-
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h   |  465 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |   32 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio_mac.c   |    6 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio_mcu.c   |   14 +-
 .../net/wireless/mediatek/mt76/mt7921/testmode.c   |   10 +-
 drivers/net/wireless/mediatek/mt76/mt7921/trace.c  |   12 -
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c    |  205 +-
 .../net/wireless/mediatek/mt76/mt7921/usb_mac.c    |  255 -
 drivers/net/wireless/mediatek/mt76/mt792x.h        |  367 +
 .../mt76/{mt7921/acpi_sar.c => mt792x_acpi_sar.c}  |  128 +-
 .../net/wireless/mediatek/mt76/mt792x_acpi_sar.h   |  105 +
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |  844 ++
 .../net/wireless/mediatek/mt76/mt792x_debugfs.c    |  168 +
 .../mediatek/mt76/{mt7921/dma.c => mt792x_dma.c}   |  336 +-
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c    |  385 +
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h   |  479 +
 drivers/net/wireless/mediatek/mt76/mt792x_trace.c  |   14 +
 .../mt76/{mt7921/mt7921_trace.h => mt792x_trace.h} |   16 +-
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c    |  309 +
 drivers/net/wireless/mediatek/mt76/mt7996/Kconfig  |    2 +-
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |   83 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  300 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.h    |  315 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  114 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  182 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |   17 +
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |   94 +-
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |    1 +
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |   21 +-
 drivers/net/wireless/mediatek/mt76/testmode.c      |    1 +
 drivers/net/wireless/mediatek/mt76/trace.h         |    2 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |   16 +-
 drivers/net/wireless/mediatek/mt76/usb_trace.h     |    2 +-
 drivers/net/wireless/mediatek/mt7601u/Kconfig      |    2 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.h |    4 -
 drivers/net/wireless/microchip/wilc1000/sdio.c     |  103 +-
 drivers/net/wireless/microchip/wilc1000/spi.c      |  148 +-
 drivers/net/wireless/purelifi/plfxlc/Kconfig       |    2 +-
 drivers/net/wireless/ralink/rt2x00/Kconfig         |    2 +-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |   59 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c |    2 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c |    2 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c |    2 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c |    2 +
 drivers/net/wireless/realtek/rtlwifi/core.c        |    2 +-
 .../realtek/rtlwifi/rtl8723com/fw_common.c         |   28 -
 .../realtek/rtlwifi/rtl8723com/fw_common.h         |    2 -
 drivers/net/wireless/realtek/rtw88/fw.c            |    2 +-
 drivers/net/wireless/realtek/rtw88/main.c          |   13 +-
 drivers/net/wireless/realtek/rtw88/main.h          |    9 -
 drivers/net/wireless/realtek/rtw88/pci.c           |    2 +-
 drivers/net/wireless/realtek/rtw88/ps.c            |    6 +-
 drivers/net/wireless/realtek/rtw88/tx.c            |    2 -
 drivers/net/wireless/realtek/rtw88/usb.c           |   25 +-
 drivers/net/wireless/realtek/rtw88/usb.h           |    7 -
 drivers/net/wireless/realtek/rtw88/util.c          |    7 +-
 drivers/net/wireless/realtek/rtw88/util.h          |    3 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |  124 +
 drivers/net/wireless/realtek/rtw89/chan.h          |    5 +
 drivers/net/wireless/realtek/rtw89/coex.c          |    3 +-
 drivers/net/wireless/realtek/rtw89/coex.h          |    9 +
 drivers/net/wireless/realtek/rtw89/core.c          |  156 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  350 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   83 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  690 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |  372 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |  200 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   69 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   14 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |   38 +
 drivers/net/wireless/realtek/rtw89/pci.c           |    2 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |  374 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |  114 +-
 drivers/net/wireless/realtek/rtw89/phy_be.c        |   77 +
 drivers/net/wireless/realtek/rtw89/ps.c            |   75 +-
 drivers/net/wireless/realtek/rtw89/ps.h            |    4 +
 drivers/net/wireless/realtek/rtw89/reg.h           |   38 +
 drivers/net/wireless/realtek/rtw89/regd.c          |   27 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   20 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   21 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   20 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |    4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   26 +-
 drivers/net/wireless/realtek/rtw89/sar.c           |  220 +-
 drivers/net/wireless/realtek/rtw89/sar.h           |   10 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |   20 +-
 drivers/net/wireless/realtek/rtw89/txrx.h          |   47 +-
 drivers/net/wireless/realtek/rtw89/wow.c           |    3 +-
 drivers/net/wireless/rsi/rsi_91x_coex.c            |   11 +-
 drivers/net/wireless/rsi/rsi_91x_debugfs.c         |    3 +-
 drivers/net/wireless/rsi/rsi_91x_hal.c             |    2 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |    4 +-
 drivers/net/wireless/rsi/rsi_91x_main.c            |    4 +-
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |   39 +-
 drivers/net/wireless/rsi/rsi_91x_sdio_ops.c        |   15 +-
 drivers/net/wireless/rsi/rsi_91x_usb.c             |   20 +-
 drivers/net/wireless/rsi/rsi_91x_usb_ops.c         |    2 +-
 drivers/net/wireless/silabs/wfx/bus_sdio.c         |    2 +-
 drivers/net/wireless/silabs/wfx/main.c             |    7 +-
 drivers/net/wireless/ti/wlcore/sdio.c              |   13 +-
 drivers/net/wireless/ti/wlcore/spi.c               |    2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   18 +-
 drivers/net/wireless/zydas/zd1201.c                |    6 +-
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c       |    2 +-
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c             |   17 +-
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h             |    2 +-
 drivers/net/wwan/t7xx/t7xx_mhccif.h                |    1 +
 drivers/net/wwan/t7xx/t7xx_modem_ops.c             |   76 +-
 drivers/net/wwan/t7xx/t7xx_modem_ops.h             |    2 +
 drivers/net/wwan/t7xx/t7xx_port.h                  |    6 +-
 drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c         |    8 +-
 drivers/net/wwan/t7xx/t7xx_port_proxy.c            |   18 +-
 drivers/net/wwan/t7xx/t7xx_reg.h                   |    2 +-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c         |   13 +-
 drivers/net/wwan/t7xx/t7xx_state_monitor.h         |    2 +
 drivers/net/xen-netfront.c                         |    2 +-
 drivers/nfc/virtual_ncidev.c                       |   13 +-
 drivers/platform/x86/eeepc-laptop.c                |    2 +-
 drivers/ptp/Kconfig                                |   11 +
 drivers/ptp/Makefile                               |    1 +
 drivers/ptp/ptp_mock.c                             |  175 +
 drivers/ptp/ptp_qoriq.c                            |    2 +-
 drivers/s390/net/Kconfig                           |    5 +-
 drivers/s390/net/lcs.c                             |   39 +-
 drivers/staging/wlan-ng/prism2usb.c                |   48 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |    2 +-
 drivers/vfio/pci/mlx5/cmd.c                        |    4 +-
 drivers/w1/w1_netlink.c                            |    6 +-
 include/linux/avf/virtchnl.h                       |  127 +-
 include/linux/bpf-cgroup.h                         |    4 +-
 include/linux/bpf.h                                |  114 +-
 include/linux/bpf_mem_alloc.h                      |    2 +
 include/linux/bpf_mprog.h                          |  343 +
 include/linux/bpf_verifier.h                       |    2 +-
 include/linux/brcmphy.h                            |    1 +
 include/linux/btf.h                                |    2 -
 include/linux/btf_ids.h                            |    1 +
 include/linux/can/rx-offload.h                     |   11 +-
 include/linux/connector.h                          |    8 +-
 include/linux/filter.h                             |   39 +-
 include/linux/fs_enet_pd.h                         |  165 -
 include/linux/icmpv6.h                             |   10 +-
 include/linux/ieee80211.h                          |  235 +-
 include/linux/if_arp.h                             |    4 +
 include/linux/if_team.h                            |    4 +-
 include/linux/if_vlan.h                            |    6 +-
 include/linux/ipv6.h                               |   16 +-
 include/linux/lockdep.h                            |    7 +
 include/linux/lsm_hook_defs.h                      |    2 +-
 include/linux/marvell_phy.h                        |    1 +
 include/linux/mdio.h                               |   26 +
 include/linux/memcontrol.h                         |    9 +-
 include/linux/mlx4/device.h                        |   20 +
 include/linux/mlx4/driver.h                        |   42 +-
 include/linux/mlx5/device.h                        |   71 +-
 include/linux/mlx5/driver.h                        |   93 +-
 include/linux/mlx5/eswitch.h                       |    3 +
 include/linux/mlx5/fs.h                            |    4 +
 include/linux/mlx5/macsec.h                        |   32 +
 include/linux/mlx5/mlx5_ifc.h                      |   70 +-
 include/linux/net.h                                |    2 +-
 include/linux/net_tstamp.h                         |   30 +
 include/linux/netdevice.h                          |  108 +-
 include/linux/netfilter.h                          |   10 +
 include/linux/netfilter/nf_conntrack_h323.h        |    4 -
 include/linux/netfilter/nf_conntrack_proto_gre.h   |    1 -
 include/linux/netlink.h                            |    6 +
 include/linux/pcs/pcs-xpcs.h                       |    8 +
 include/linux/phy.h                                |   49 +-
 include/linux/phylib_stubs.h                       |   68 +
 include/linux/phylink.h                            |   88 +-
 include/linux/platform_data/hirschmann-hellcreek.h |    2 +-
 include/linux/ptp_mock.h                           |   38 +
 include/linux/qed/qed_fcoe_if.h                    |    3 -
 include/linux/rcutiny.h                            |    2 +
 include/linux/rcutree.h                            |    1 +
 include/linux/security.h                           |    5 +-
 include/linux/skbuff.h                             |   45 +-
 include/linux/smscphy.h                            |   34 +
 include/linux/stmmac.h                             |   50 +-
 include/linux/tcp.h                                |    6 +-
 include/linux/trace_events.h                       |    9 +-
 include/linux/usb/r8152.h                          |    1 +
 include/net/Space.h                                |    7 -
 include/net/af_vsock.h                             |    2 -
 include/net/bluetooth/bluetooth.h                  |   11 +-
 include/net/bluetooth/hci.h                        |   32 +
 include/net/bluetooth/hci_core.h                   |  137 +-
 include/net/bluetooth/hci_sync.h                   |    5 +-
 include/net/bluetooth/mgmt.h                       |    2 +
 include/net/bluetooth/sco.h                        |    2 -
 include/net/bond_3ad.h                             |    1 -
 include/net/busy_poll.h                            |    1 +
 include/net/caif/cfsrvl.h                          |    3 -
 include/net/cfg80211.h                             |   25 +-
 include/net/datalink.h                             |    2 -
 include/net/devlink.h                              |   35 +-
 include/net/dropreason-core.h                      |    6 +
 include/net/dropreason.h                           |    6 +
 include/net/dsa.h                                  |    3 -
 include/net/dst_ops.h                              |    2 +-
 include/net/flow_dissector.h                       |   14 +-
 include/net/flow_offload.h                         |    6 +
 include/net/fq.h                                   |    5 -
 include/net/genetlink.h                            |   76 +-
 include/net/handshake.h                            |    5 +
 include/net/ieee80211_radiotap.h                   |    3 +-
 include/net/ila.h                                  |   16 -
 include/net/inet6_hashtables.h                     |   81 +-
 include/net/inet_common.h                          |    2 +
 include/net/inet_connection_sock.h                 |    7 +-
 include/net/inet_hashtables.h                      |   76 +-
 include/net/inet_sock.h                            |   92 +-
 include/net/ip6_fib.h                              |   64 +-
 include/net/ip6_route.h                            |    2 +-
 include/net/ip_tunnels.h                           |    1 +
 include/net/ipv6.h                                 |    4 +-
 include/net/iw_handler.h                           |   11 +-
 include/net/llc_c_ac.h                             |    1 -
 include/net/llc_c_ev.h                             |    1 -
 include/net/lwtunnel.h                             |    5 +-
 include/net/mac80211.h                             |    5 +-
 include/net/macsec.h                               |    2 +
 include/net/mana/gdma.h                            |   20 +-
 include/net/mana/hw_channel.h                      |    5 +
 include/net/mana/mana.h                            |   92 +
 include/net/mptcp.h                                |   21 +
 include/net/ndisc.h                                |    3 -
 include/net/neighbour.h                            |    2 -
 include/net/net_namespace.h                        |    4 +-
 include/net/netdev_rx_queue.h                      |   53 +
 include/net/netfilter/nf_conntrack.h               |    4 -
 include/net/netfilter/nf_conntrack_acct.h          |    2 -
 include/net/netfilter/nf_conntrack_expect.h        |    2 +-
 include/net/netfilter/nf_conntrack_helper.h        |    3 -
 include/net/netfilter/nf_conntrack_labels.h        |    1 -
 include/net/netlink.h                              |   10 +-
 include/net/netns/ipv4.h                           |    2 +-
 include/net/netns/nftables.h                       |    2 -
 include/net/p8022.h                                |    3 -
 include/net/page_pool.h                            |  402 -
 include/net/page_pool/helpers.h                    |  238 +
 include/net/page_pool/types.h                      |  236 +
 include/net/pkt_cls.h                              |   14 +-
 include/net/route.h                                |    8 +-
 include/net/sch_generic.h                          |   28 +-
 include/net/sctp/sctp.h                            |    2 -
 include/net/sctp/sm.h                              |    3 -
 include/net/sctp/structs.h                         |    2 -
 include/net/sock.h                                 |    8 +-
 include/net/switchdev.h                            |   12 +-
 include/net/tcp.h                                  |   41 +-
 include/net/tcx.h                                  |  206 +
 include/net/tls.h                                  |   14 -
 include/net/tls_prot.h                             |   68 +
 include/net/transp_v6.h                            |    2 -
 include/net/udp.h                                  |    4 -
 include/net/udplite.h                              |    2 -
 include/net/xdp.h                                  |   29 +-
 include/net/xdp_sock.h                             |    7 +
 include/net/xdp_sock_drv.h                         |   54 +
 include/net/xsk_buff_pool.h                        |    7 +
 include/soc/mscc/ocelot.h                          |    1 -
 include/trace/events/handshake.h                   |  160 +
 include/trace/events/page_pool.h                   |    2 +-
 include/trace/events/xdp.h                         |   18 +
 include/uapi/linux/bpf.h                           |  150 +-
 include/uapi/linux/cn_proc.h                       |   62 +-
 include/uapi/linux/devlink.h                       |    4 +
 include/uapi/linux/if_link.h                       |    1 +
 include/uapi/linux/if_xdp.h                        |   13 +
 include/uapi/linux/ipv6.h                          |    1 +
 include/uapi/linux/mdio.h                          |   18 +-
 include/uapi/linux/netdev.h                        |    4 +-
 include/uapi/linux/netfilter_bridge/ebtables.h     |   22 +-
 include/uapi/linux/openvswitch.h                   |    2 +
 include/uapi/linux/pkt_cls.h                       |    3 +
 include/uapi/linux/pkt_sched.h                     |    1 +
 include/uapi/linux/smc.h                           |    2 +
 include/uapi/linux/virtio_net.h                    |   14 +
 kernel/bpf/Kconfig                                 |    1 +
 kernel/bpf/Makefile                                |    3 +-
 kernel/bpf/bpf_lru_list.h                          |    1 -
 kernel/bpf/bpf_struct_ops.c                        |   21 +-
 kernel/bpf/btf.c                                   |   25 +-
 kernel/bpf/core.c                                  |  206 +-
 kernel/bpf/cpumap.c                                |  116 +-
 kernel/bpf/cpumask.c                               |   20 +-
 kernel/bpf/devmap.c                                |    2 -
 kernel/bpf/disasm.c                                |   58 +-
 kernel/bpf/hashtab.c                               |   22 +-
 kernel/bpf/helpers.c                               |   65 +-
 kernel/bpf/map_iter.c                              |   42 +-
 kernel/bpf/memalloc.c                              |  388 +-
 kernel/bpf/mprog.c                                 |  447 +
 kernel/bpf/offload.c                               |    1 +
 kernel/bpf/preload/iterators/Makefile              |    2 +-
 kernel/bpf/preload/iterators/iterators.bpf.c       |    9 +-
 .../iterators/iterators.lskel-little-endian.h      |  526 +-
 kernel/bpf/ringbuf.c                               |   26 +-
 kernel/bpf/syscall.c                               |  382 +-
 kernel/bpf/tcx.c                                   |  352 +
 kernel/bpf/verifier.c                              |  516 +-
 kernel/rcu/rcu.h                                   |    2 -
 kernel/trace/bpf_trace.c                           |  413 +-
 kernel/trace/trace_kprobe.c                        |   13 +-
 kernel/trace/trace_probe.h                         |    5 +
 kernel/trace/trace_syscalls.c                      |   12 +-
 kernel/trace/trace_uprobe.c                        |   10 +-
 lib/checksum_kunit.c                               |   54 +-
 lib/nlattr.c                                       |    6 +
 lib/test_bpf.c                                     |   24 +-
 lib/ts_bm.c                                        |   43 +-
 mm/vmpressure.c                                    |    8 +
 net/8021q/vlan_dev.c                               |   27 +-
 net/9p/trans_fd.c                                  |    4 +-
 net/Kconfig                                        |    5 +
 net/batman-adv/bat_iv_ogm.c                        |    1 +
 net/batman-adv/bat_v.c                             |   23 +-
 net/batman-adv/gateway_common.c                    |  162 +-
 net/batman-adv/gateway_common.h                    |    7 -
 net/batman-adv/hard-interface.c                    |   20 +-
 net/batman-adv/main.h                              |    2 +-
 net/batman-adv/netlink.c                           |   15 +-
 net/batman-adv/netlink.h                           |    6 -
 net/batman-adv/routing.h                           |    4 -
 net/batman-adv/soft-interface.c                    |    2 +-
 net/batman-adv/types.h                             |    7 +-
 net/bluetooth/af_bluetooth.c                       |   53 +-
 net/bluetooth/amp.h                                |    1 -
 net/bluetooth/bnep/sock.c                          |   10 +-
 net/bluetooth/coredump.c                           |    3 +-
 net/bluetooth/eir.c                                |    2 +-
 net/bluetooth/hci_conn.c                           |  728 +-
 net/bluetooth/hci_core.c                           |   34 +-
 net/bluetooth/hci_debugfs.c                        |    3 +-
 net/bluetooth/hci_event.c                          |  265 +-
 net/bluetooth/hci_request.c                        |   21 -
 net/bluetooth/hci_sock.c                           |   77 +-
 net/bluetooth/hci_sync.c                           |  310 +-
 net/bluetooth/hidp/sock.c                          |   10 +-
 net/bluetooth/iso.c                                |  302 +-
 net/bluetooth/l2cap_sock.c                         |   29 +-
 net/bluetooth/mgmt.c                               |   33 +-
 net/bluetooth/msft.c                               |  412 +-
 net/bluetooth/rfcomm/sock.c                        |   13 +-
 net/bluetooth/sco.c                                |   34 +-
 net/bpf/test_run.c                                 |   21 +-
 net/bridge/br.c                                    |    8 +
 net/bridge/br_forward.c                            |    1 +
 net/bridge/br_netlink.c                            |   12 +
 net/bridge/br_private.h                            |   20 +-
 net/bridge/br_switchdev.c                          |   15 +-
 net/bridge/br_vlan_tunnel.c                        |   15 +
 net/bridge/netfilter/ebtables.c                    |    3 +-
 net/core/dev.c                                     |  370 +-
 net/core/dev_ioctl.c                               |  187 +-
 net/core/dst.c                                     |    2 +-
 net/core/filter.c                                  |   15 +-
 net/core/flow_dissector.c                          |   55 +-
 net/core/flow_offload.c                            |    7 +
 net/core/lwt_bpf.c                                 |    7 +-
 net/core/net-sysfs.c                               |    1 +
 net/core/netdev-genl.c                             |   54 +-
 net/core/of_net.c                                  |    1 +
 net/core/page_pool.c                               |   87 +-
 net/core/rtnetlink.c                               |   11 +-
 net/core/scm.c                                     |    3 +-
 net/core/skbuff.c                                  |  174 +-
 net/core/skmsg.c                                   |    8 +-
 net/core/sock.c                                    |   63 +-
 net/core/xdp.c                                     |    2 +-
 net/dccp/feat.h                                    |    1 -
 net/dccp/ipv4.c                                    |   20 +-
 net/dccp/ipv6.c                                    |   16 +-
 net/dccp/ipv6.h                                    |    4 -
 net/devlink/Makefile                               |    3 +-
 net/devlink/core.c                                 |    6 +
 net/devlink/dev.c                                  |   79 +-
 net/devlink/devl_internal.h                        |  143 +-
 net/devlink/dpipe.c                                |  917 ++
 net/devlink/health.c                               |   42 +-
 net/devlink/leftover.c                             | 9510 --------------------
 net/devlink/linecard.c                             |  606 ++
 net/devlink/netlink.c                              |  393 +-
 net/devlink/netlink_gen.c                          |  481 +
 net/devlink/netlink_gen.h                          |   79 +
 net/devlink/param.c                                |  865 ++
 net/devlink/port.c                                 | 1515 ++++
 net/devlink/rate.c                                 |  722 ++
 net/devlink/region.c                               | 1260 +++
 net/devlink/resource.c                             |  579 ++
 net/devlink/sb.c                                   |  996 ++
 net/devlink/trap.c                                 | 1861 ++++
 net/dsa/port.c                                     |   53 +-
 net/dsa/slave.c                                    |    9 +-
 net/dsa/tag_qca.c                                  |    8 +-
 net/ethtool/channels.c                             |    2 +-
 net/ethtool/coalesce.c                             |    6 +-
 net/ethtool/common.c                               |    3 +-
 net/ethtool/debug.c                                |    2 +-
 net/ethtool/eee.c                                  |    2 +-
 net/ethtool/eeprom.c                               |    9 +-
 net/ethtool/features.c                             |    2 +-
 net/ethtool/fec.c                                  |    2 +-
 net/ethtool/ioctl.c                                |   91 +-
 net/ethtool/linkinfo.c                             |    2 +-
 net/ethtool/linkmodes.c                            |    2 +-
 net/ethtool/linkstate.c                            |    2 +-
 net/ethtool/mm.c                                   |    2 +-
 net/ethtool/module.c                               |    5 +-
 net/ethtool/netlink.c                              |   96 +-
 net/ethtool/netlink.h                              |    2 +-
 net/ethtool/pause.c                                |    5 +-
 net/ethtool/phc_vclocks.c                          |    2 +-
 net/ethtool/plca.c                                 |    4 +-
 net/ethtool/privflags.c                            |    2 +-
 net/ethtool/pse-pd.c                               |    6 +-
 net/ethtool/rings.c                                |    5 +-
 net/ethtool/rss.c                                  |    3 +-
 net/ethtool/stats.c                                |    5 +-
 net/ethtool/strset.c                               |    2 +-
 net/ethtool/tsinfo.c                               |    2 +-
 net/ethtool/tunnels.c                              |   73 +-
 net/ethtool/wol.c                                  |    5 +-
 net/handshake/Makefile                             |    2 +-
 net/handshake/alert.c                              |  110 +
 net/handshake/handshake.h                          |    6 +
 net/handshake/tlshd.c                              |   23 +
 net/handshake/trace.c                              |    2 +
 net/hsr/hsr_netlink.h                              |    2 -
 net/ieee802154/nl802154.c                          |    4 +-
 net/ipv4/af_inet.c                                 |   62 +-
 net/ipv4/bpf_tcp_ca.c                              |    2 -
 net/ipv4/cipso_ipv4.c                              |    4 +-
 net/ipv4/devinet.c                                 |   23 +-
 net/ipv4/igmp.c                                    |    2 +-
 net/ipv4/inet_diag.c                               |   22 +-
 net/ipv4/inet_hashtables.c                         |   66 +-
 net/ipv4/inet_timewait_sock.c                      |    2 +-
 net/ipv4/ip_output.c                               |   11 +-
 net/ipv4/ip_sockglue.c                             |  403 +-
 net/ipv4/netfilter/nf_defrag_ipv4.c                |   19 +-
 net/ipv4/nexthop.c                                 |   65 +-
 net/ipv4/ping.c                                    |    7 +-
 net/ipv4/raw.c                                     |   26 +-
 net/ipv4/route.c                                   |    8 +-
 net/ipv4/tcp.c                                     |  113 +-
 net/ipv4/tcp_fastopen.c                            |    2 +-
 net/ipv4/tcp_input.c                               |   69 +-
 net/ipv4/tcp_ipv4.c                                |    8 +-
 net/ipv4/tcp_metrics.c                             |   19 +-
 net/ipv4/tcp_minisocks.c                           |    7 +-
 net/ipv4/tcp_output.c                              |   40 +-
 net/ipv4/tcp_timer.c                               |   89 +-
 net/ipv4/udp.c                                     |   97 +-
 net/ipv4/udp_tunnel_core.c                         |    2 +-
 net/ipv4/xfrm4_policy.c                            |   11 +-
 net/ipv6/addrconf.c                                |   90 +-
 net/ipv6/af_inet6.c                                |   22 +-
 net/ipv6/anycast.c                                 |    2 +-
 net/ipv6/datagram.c                                |    9 +-
 net/ipv6/exthdrs.c                                 |    7 +-
 net/ipv6/icmp.c                                    |    6 +-
 net/ipv6/ila/ila_main.c                            |    1 -
 net/ipv6/ila/ila_xlat.c                            |    1 -
 net/ipv6/inet6_hashtables.c                        |   69 +-
 net/ipv6/ip6_fib.c                                 |   55 +-
 net/ipv6/ip6_output.c                              |   18 +-
 net/ipv6/ipv6_sockglue.c                           |   22 +-
 net/ipv6/mcast.c                                   |    8 +-
 net/ipv6/ndisc.c                                   |   17 +-
 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c          |   11 +
 net/ipv6/ping.c                                    |    1 +
 net/ipv6/raw.c                                     |   17 +-
 net/ipv6/route.c                                   |   23 +-
 net/ipv6/rpl_iptunnel.c                            |    3 +-
 net/ipv6/seg6_local.c                              |  108 +-
 net/ipv6/tcp_ipv6.c                                |    1 +
 net/ipv6/udp.c                                     |   99 +-
 net/ipv6/udplite.c                                 |    1 +
 net/ipv6/xfrm6_policy.c                            |    6 +-
 net/key/af_key.c                                   |    1 -
 net/l2tp/l2tp_ip.c                                 |    2 +-
 net/l2tp/l2tp_ip6.c                                |    4 +-
 net/llc/llc_conn.c                                 |   11 +-
 net/mac80211/cfg.c                                 |   27 +-
 net/mac80211/fils_aead.c                           |    2 +-
 net/mac80211/ieee80211_i.h                         |    2 -
 net/mac80211/key.c                                 |    2 +-
 net/mac80211/mesh.h                                |    1 -
 net/mac80211/rx.c                                  |    4 +
 net/mac80211/wpa.c                                 |    2 +-
 net/mptcp/Makefile                                 |    2 +-
 net/mptcp/bpf.c                                    |   15 +
 net/mptcp/ctrl.c                                   |   14 +
 net/mptcp/pm.c                                     |    9 +-
 net/mptcp/pm_netlink.c                             |   33 +-
 net/mptcp/protocol.c                               |  497 +-
 net/mptcp/protocol.h                               |   41 +-
 net/mptcp/sched.c                                  |  173 +
 net/mptcp/sockopt.c                                |   77 +-
 net/mptcp/subflow.c                                |    2 +-
 net/ncsi/ncsi-netlink.c                            |    2 +-
 net/ncsi/ncsi-netlink.h                            |    2 +-
 net/netfilter/core.c                               |    6 +
 net/netfilter/ipset/ip_set_core.c                  |   10 +-
 net/netfilter/ipvs/ip_vs_core.c                    |    4 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |    4 +-
 net/netfilter/nf_bpf_link.c                        |  125 +-
 net/netfilter/nf_conntrack_bpf.c                   |    1 +
 net/netfilter/nf_conntrack_core.c                  |    2 +-
 net/netfilter/nf_conntrack_expect.c                |    4 +-
 net/netfilter/nf_conntrack_netlink.c               |    8 +-
 net/netfilter/nf_conntrack_proto_dccp.c            |    2 +
 net/netfilter/nf_flow_table_offload.c              |   22 +-
 net/netfilter/nf_tables_api.c                      |    6 +
 net/netfilter/nf_tables_offload.c                  |   13 +-
 net/netfilter/nfnetlink_log.c                      |    6 +-
 net/netfilter/nft_cmp.c                            |    2 +-
 net/netfilter/nft_ct.c                             |    4 +-
 net/netfilter/nft_fib.c                            |   15 +-
 net/netfilter/nft_lookup.c                         |    6 +-
 net/netfilter/nft_masq.c                           |    8 +-
 net/netfilter/nft_meta.c                           |    6 +-
 net/netfilter/nft_nat.c                            |    8 +-
 net/netfilter/nft_osf.c                            |    6 +-
 net/netfilter/nft_redir.c                          |    8 +-
 net/netfilter/x_tables.c                           |    5 +-
 net/netfilter/xt_repldata.h                        |    2 +-
 net/netlabel/netlabel_cipso_v4.h                   |    3 -
 net/netlink/af_netlink.c                           |  128 +-
 net/netlink/af_netlink.h                           |   26 +-
 net/netlink/diag.c                                 |   10 +-
 net/netlink/genetlink.c                            |  125 +-
 net/netrom/af_netrom.c                             |    5 +
 net/nfc/netlink.c                                  |    4 +-
 net/openvswitch/actions.c                          |   42 +-
 net/openvswitch/conntrack.c                        |   83 +-
 net/openvswitch/datapath.c                         |   45 +-
 net/openvswitch/drop.h                             |   41 +
 net/openvswitch/flow_netlink.c                     |   10 +-
 net/openvswitch/meter.c                            |   10 +-
 net/packet/af_packet.c                             |    4 +-
 net/qrtr/af_qrtr.c                                 |    5 +
 net/qrtr/ns.c                                      |  139 +-
 net/rds/rdma_transport.h                           |    1 -
 net/rds/rds.h                                      |    3 -
 net/rds/tcp.h                                      |    1 -
 net/sched/Kconfig                                  |    4 +-
 net/sched/act_ct.c                                 |    3 +-
 net/sched/cls_flower.c                             |   35 +
 net/sched/em_meta.c                                |    2 +-
 net/sched/sch_drr.c                                |   11 +-
 net/sched/sch_hfsc.c                               |   14 +-
 net/sched/sch_htb.c                                |   17 +-
 net/sched/sch_ingress.c                            |   61 +-
 net/sched/sch_netem.c                              |   49 +-
 net/sched/sch_qfq.c                                |   12 +-
 net/sched/sch_taprio.c                             |   68 +-
 net/sctp/input.c                                   |    2 +-
 net/sctp/protocol.c                                |    5 +-
 net/sctp/socket.c                                  |    3 +-
 net/smc/af_smc.c                                   |   88 +-
 net/smc/smc.h                                      |    5 +-
 net/smc/smc_clc.c                                  |  147 +-
 net/smc/smc_clc.h                                  |   53 +-
 net/smc/smc_core.c                                 |   13 +-
 net/smc/smc_core.h                                 |   26 +-
 net/smc/smc_ib.h                                   |    1 -
 net/smc/smc_llc.c                                  |   25 +-
 net/socket.c                                       |  167 +-
 net/sunrpc/svcsock.c                               |   50 +-
 net/sunrpc/xprtsock.c                              |   45 +-
 net/switchdev/switchdev.c                          |   25 +
 net/tipc/addr.h                                    |    1 -
 net/tipc/bearer.h                                  |    2 -
 net/tipc/link.h                                    |    2 -
 net/tipc/name_distr.h                              |    1 -
 net/tipc/net.h                                     |    1 -
 net/tipc/netlink_compat.c                          |    4 +-
 net/tipc/node.c                                    |    4 +-
 net/tipc/socket.c                                  |    2 +-
 net/tipc/udp_media.c                               |    2 +-
 net/tls/tls.h                                      |   60 +-
 net/tls/tls_device.c                               |   58 +-
 net/tls/tls_device_fallback.c                      |   62 +-
 net/tls/tls_main.c                                 |  274 +-
 net/tls/tls_strp.c                                 |    3 +-
 net/tls/tls_sw.c                                   |  318 +-
 net/unix/scm.c                                     |    3 +-
 net/vmw_vsock/virtio_transport_common.c            |  104 +-
 net/vmw_vsock/vmci_transport.h                     |    3 -
 net/wireless/core.h                                |    2 +-
 net/wireless/mlme.c                                |   13 +
 net/wireless/nl80211.c                             |    8 +-
 net/wireless/nl80211.h                             |    1 -
 net/wireless/ocb.c                                 |    3 +
 net/wireless/pmsr.c                                |    3 +-
 net/xdp/xsk.c                                      |  366 +-
 net/xdp/xsk_buff_pool.c                            |    7 +
 net/xdp/xsk_queue.h                                |   95 +-
 net/xfrm/xfrm_device.c                             |   13 +-
 samples/bpf/.gitignore                             |   12 -
 samples/bpf/Makefile                               |   74 +-
 samples/bpf/README.rst                             |   20 +-
 samples/bpf/gnu/stubs.h                            |    2 +-
 samples/bpf/net_shared.h                           |    2 +
 .../bpf/{offwaketime_kern.c => offwaketime.bpf.c}  |   39 +-
 samples/bpf/offwaketime_user.c                     |    2 +-
 samples/bpf/{spintest_kern.c => spintest.bpf.c}    |   27 +-
 samples/bpf/spintest_user.c                        |   24 +-
 samples/bpf/syscall_tp_kern.c                      |    4 +
 samples/bpf/test_lwt_bpf.sh                        |    2 +-
 samples/bpf/test_map_in_map.bpf.c                  |   10 +-
 samples/bpf/test_overhead_kprobe.bpf.c             |   20 +-
 samples/bpf/test_overhead_tp.bpf.c                 |   29 +-
 samples/bpf/{tracex1_kern.c => tracex1.bpf.c}      |   25 +-
 samples/bpf/tracex1_user.c                         |    2 +-
 samples/bpf/{tracex3_kern.c => tracex3.bpf.c}      |   40 +-
 samples/bpf/tracex3_user.c                         |    2 +-
 samples/bpf/{tracex4_kern.c => tracex4.bpf.c}      |    3 +-
 samples/bpf/tracex4_user.c                         |    2 +-
 samples/bpf/{tracex5_kern.c => tracex5.bpf.c}      |   12 +-
 samples/bpf/tracex5_user.c                         |    2 +-
 samples/bpf/{tracex6_kern.c => tracex6.bpf.c}      |   20 +-
 samples/bpf/tracex6_user.c                         |    2 +-
 samples/bpf/{tracex7_kern.c => tracex7.bpf.c}      |    3 +-
 samples/bpf/tracex7_user.c                         |    2 +-
 samples/bpf/xdp1_kern.c                            |  100 -
 samples/bpf/xdp1_user.c                            |  166 -
 samples/bpf/xdp2_kern.c                            |  125 -
 samples/bpf/xdp_monitor.bpf.c                      |    8 -
 samples/bpf/xdp_monitor_user.c                     |  118 -
 samples/bpf/xdp_redirect.bpf.c                     |   49 -
 samples/bpf/xdp_redirect_cpu.bpf.c                 |  539 --
 samples/bpf/xdp_redirect_cpu_user.c                |  559 --
 samples/bpf/xdp_redirect_map.bpf.c                 |   97 -
 samples/bpf/xdp_redirect_map_multi.bpf.c           |   77 -
 samples/bpf/xdp_redirect_map_multi_user.c          |  232 -
 samples/bpf/xdp_redirect_map_user.c                |  228 -
 samples/bpf/xdp_redirect_user.c                    |  172 -
 samples/bpf/xdp_rxq_info_kern.c                    |  140 -
 samples/bpf/xdp_rxq_info_user.c                    |  614 --
 samples/bpf/xdp_sample_pkts_kern.c                 |   57 -
 samples/bpf/xdp_sample_pkts_user.c                 |  196 -
 samples/hid/Makefile                               |    6 +-
 security/security.c                                |    2 +-
 security/selinux/hooks.c                           |    4 +-
 tools/bpf/bpftool/Documentation/bpftool-gen.rst    |    4 +-
 tools/bpf/bpftool/Documentation/bpftool-net.rst    |   26 +-
 tools/bpf/bpftool/Makefile                         |    2 +-
 tools/bpf/bpftool/btf_dumper.c                     |    2 +-
 tools/bpf/bpftool/feature.c                        |    2 +-
 tools/bpf/bpftool/link.c                           |  476 +-
 tools/bpf/bpftool/net.c                            |   98 +-
 tools/bpf/bpftool/netlink_dumper.h                 |    8 +
 tools/bpf/bpftool/perf.c                           |    2 +-
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c          |   26 +-
 tools/bpf/bpftool/skeleton/profiler.bpf.c          |   27 +-
 tools/bpf/bpftool/xlated_dumper.c                  |    6 +-
 tools/bpf/bpftool/xlated_dumper.h                  |    2 +
 tools/bpf/runqslower/Makefile                      |    2 +-
 tools/build/feature/Makefile                       |    2 +-
 tools/include/uapi/linux/bpf.h                     |  150 +-
 tools/include/uapi/linux/if_xdp.h                  |    9 +
 tools/include/uapi/linux/netdev.h                  |    4 +-
 tools/lib/bpf/Build                                |    2 +-
 tools/lib/bpf/Makefile                             |    4 +-
 tools/lib/bpf/bpf.c                                |  146 +-
 tools/lib/bpf/bpf.h                                |  114 +-
 tools/lib/bpf/bpf_tracing.h                        |    2 +-
 tools/lib/bpf/elf.c                                |  440 +
 tools/lib/bpf/hashmap.h                            |   10 -
 tools/lib/bpf/libbpf.c                             |  756 +-
 tools/lib/bpf/libbpf.h                             |   85 +-
 tools/lib/bpf/libbpf.map                           |    5 +
 tools/lib/bpf/libbpf_common.h                      |   16 +
 tools/lib/bpf/libbpf_internal.h                    |   21 +
 tools/lib/bpf/netlink.c                            |    5 +
 tools/lib/bpf/relo_core.c                          |    2 +-
 tools/lib/bpf/usdt.bpf.h                           |    4 +-
 tools/lib/bpf/usdt.c                               |  121 +-
 tools/net/ynl/Makefile                             |    1 +
 tools/net/ynl/cli.py                               |   12 +-
 tools/net/ynl/generated/devlink-user.c             | 2449 ++++-
 tools/net/ynl/generated/devlink-user.h             | 1822 +++-
 tools/net/ynl/generated/ethtool-user.h             |    4 +
 tools/net/ynl/generated/fou-user.h                 |    6 +
 tools/net/ynl/generated/netdev-user.c              |    6 +
 tools/net/ynl/generated/netdev-user.h              |    2 +
 tools/net/ynl/lib/__init__.py                      |    4 +-
 tools/net/ynl/lib/nlspec.py                        |   31 +
 tools/net/ynl/lib/ynl.py                           |  220 +-
 tools/net/ynl/samples/netdev.c                     |    2 +
 tools/net/ynl/ynl-gen-c.py                         |   71 +-
 tools/net/ynl/ynl-regen.sh                         |    5 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/bpf/.gitignore             |    3 +
 tools/testing/selftests/bpf/DENYLIST.aarch64       |    5 +
 tools/testing/selftests/bpf/Makefile               |   51 +-
 tools/testing/selftests/bpf/bench.c                |    4 +
 tools/testing/selftests/bpf/bench.h                |    9 -
 .../testing/selftests/bpf/benchs/bench_htab_mem.c  |  350 +
 .../testing/selftests/bpf/benchs/bench_ringbufs.c  |    2 +-
 .../selftests/bpf/benchs/run_bench_htab_mem.sh     |   40 +
 .../selftests/bpf/benchs/run_bench_rename.sh       |    2 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |   58 +-
 tools/testing/selftests/bpf/cgroup_helpers.c       |   12 +
 tools/testing/selftests/bpf/cgroup_helpers.h       |    1 +
 tools/testing/selftests/bpf/cgroup_tcp_skb.h       |   35 +
 tools/testing/selftests/bpf/config                 |    2 +
 .../selftests/bpf/generate_udp_fragments.py        |   90 +
 tools/testing/selftests/bpf/gnu/stubs.h            |    2 +-
 .../testing/selftests/bpf/ip_check_defrag_frags.h  |   57 +
 .../selftests/bpf/map_tests/map_percpu_stats.c     |  447 +
 tools/testing/selftests/bpf/network_helpers.c      |   29 +-
 tools/testing/selftests/bpf/network_helpers.h      |    3 +
 .../selftests/bpf/prog_tests/assign_reuse.c        |  199 +
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |   78 +
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c    |    5 +-
 .../selftests/bpf/prog_tests/cgroup_tcp_skb.c      |  344 +
 .../testing/selftests/bpf/prog_tests/fentry_test.c |   43 +-
 .../testing/selftests/bpf/prog_tests/fexit_test.c  |   43 +-
 .../selftests/bpf/prog_tests/fill_link_info.c      |  342 +
 .../selftests/bpf/prog_tests/get_func_args_test.c  |    4 +-
 .../selftests/bpf/prog_tests/get_func_ip_test.c    |   57 +-
 .../selftests/bpf/prog_tests/global_map_resize.c   |   14 +-
 .../selftests/bpf/prog_tests/ip_check_defrag.c     |  283 +
 .../testing/selftests/bpf/prog_tests/kfunc_call.c  |    2 +-
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   |    8 -
 .../testing/selftests/bpf/prog_tests/linked_list.c |   78 +-
 .../selftests/bpf/prog_tests/local_kptr_stash.c    |   33 +-
 tools/testing/selftests/bpf/prog_tests/log_fixup.c |    2 +-
 .../testing/selftests/bpf/prog_tests/lwt_helpers.h |  139 +
 .../selftests/bpf/prog_tests/lwt_redirect.c        |  330 +
 .../testing/selftests/bpf/prog_tests/lwt_reroute.c |  262 +
 .../selftests/bpf/prog_tests/modify_return.c       |   10 +-
 tools/testing/selftests/bpf/prog_tests/mptcp.c     |  180 +-
 .../bpf/prog_tests/netfilter_link_attach.c         |   86 +
 .../selftests/bpf/prog_tests/ptr_untrusted.c       |   36 +
 .../selftests/bpf/prog_tests/refcounted_kptr.c     |   30 +
 tools/testing/selftests/bpf/prog_tests/spin_lock.c |   37 +-
 .../testing/selftests/bpf/prog_tests/task_kfunc.c  |    2 +
 tools/testing/selftests/bpf/prog_tests/tc_bpf.c    |   36 +-
 .../testing/selftests/bpf/prog_tests/tc_helpers.h  |   72 +
 tools/testing/selftests/bpf/prog_tests/tc_links.c  | 1919 ++++
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   | 2380 +++++
 .../selftests/bpf/prog_tests/tcp_hdr_options.c     |    2 +-
 .../selftests/bpf/prog_tests/test_ldsx_insn.c      |  139 +
 .../selftests/bpf/prog_tests/tracing_struct.c      |   19 +
 .../selftests/bpf/prog_tests/trampoline_count.c    |    4 +-
 .../selftests/bpf/prog_tests/uprobe_multi_test.c   |  415 +
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   12 +
 .../testing/selftests/bpf/prog_tests/xdp_attach.c  |   65 +
 tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c |  382 +
 .../testing/selftests/bpf/progs/fentry_many_args.c |   39 +
 .../testing/selftests/bpf/progs/fexit_many_args.c  |   40 +
 .../testing/selftests/bpf/progs/get_func_ip_test.c |   25 +-
 .../selftests/bpf/progs/get_func_ip_uprobe_test.c  |   18 +
 tools/testing/selftests/bpf/progs/htab_mem_bench.c |  105 +
 .../testing/selftests/bpf/progs/ip_check_defrag.c  |  104 +
 tools/testing/selftests/bpf/progs/linked_list.c    |    2 +-
 .../testing/selftests/bpf/progs/local_kptr_stash.c |   28 +
 .../selftests/bpf/progs/local_kptr_stash_fail.c    |   85 +
 .../testing/selftests/bpf/progs/map_percpu_stats.c |   24 +
 tools/testing/selftests/bpf/progs/map_ptr_kern.c   |    5 +
 tools/testing/selftests/bpf/progs/modify_return.c  |   40 +
 tools/testing/selftests/bpf/progs/mptcpify.c       |   20 +
 .../selftests/bpf/progs/nested_trust_failure.c     |   16 +
 .../selftests/bpf/progs/nested_trust_success.c     |   15 +
 .../testing/selftests/bpf/progs/refcounted_kptr.c  |  165 +-
 .../selftests/bpf/progs/refcounted_kptr_fail.c     |   28 +
 .../selftests/bpf/progs/task_kfunc_success.c       |   51 +
 .../selftests/bpf/progs/test_assign_reuse.c        |  142 +
 .../selftests/bpf/progs/test_cls_redirect.h        |    9 +
 .../selftests/bpf/progs/test_fill_link_info.c      |   42 +
 .../selftests/bpf/progs/test_global_map_resize.c   |    8 +-
 tools/testing/selftests/bpf/progs/test_ldsx_insn.c |  119 +
 .../selftests/bpf/progs/test_lwt_redirect.c        |   90 +
 .../testing/selftests/bpf/progs/test_lwt_reroute.c |   36 +
 .../bpf/progs/test_netfilter_link_attach.c         |   14 +
 .../selftests/bpf/progs/test_ptr_untrusted.c       |   29 +
 tools/testing/selftests/bpf/progs/test_tc_bpf.c    |   13 +
 tools/testing/selftests/bpf/progs/test_tc_link.c   |   56 +
 .../selftests/bpf/progs/test_xdp_attach_fail.c     |   54 +
 tools/testing/selftests/bpf/progs/tracing_struct.c |   54 +
 tools/testing/selftests/bpf/progs/uprobe_multi.c   |  101 +
 .../selftests/bpf/progs/uprobe_multi_bench.c       |   15 +
 .../selftests/bpf/progs/uprobe_multi_usdt.c        |   16 +
 tools/testing/selftests/bpf/progs/verifier_bswap.c |   60 +
 tools/testing/selftests/bpf/progs/verifier_gotol.c |   45 +
 tools/testing/selftests/bpf/progs/verifier_ldsx.c  |  132 +
 tools/testing/selftests/bpf/progs/verifier_movsx.c |  236 +
 tools/testing/selftests/bpf/progs/verifier_sdiv.c  |  782 ++
 .../testing/selftests/bpf/progs/verifier_typedef.c |   23 +
 tools/testing/selftests/bpf/progs/xsk_xdp_progs.c  |    6 +-
 tools/testing/selftests/bpf/test_xsk.sh            |    5 +
 tools/testing/selftests/bpf/testing_helpers.h      |   10 +
 tools/testing/selftests/bpf/trace_helpers.c        |    5 +-
 tools/testing/selftests/bpf/uprobe_multi.c         |   91 +
 .../selftests/bpf/verifier/atomic_cmpxchg.c        |    1 +
 tools/testing/selftests/bpf/verifier/basic_instr.c |    6 +-
 tools/testing/selftests/bpf/verifier/ctx_skb.c     |    2 +
 tools/testing/selftests/bpf/verifier/jmp32.c       |    8 +
 tools/testing/selftests/bpf/verifier/map_kptr.c    |    2 +
 tools/testing/selftests/bpf/verifier/precise.c     |    2 +-
 tools/testing/selftests/bpf/xsk.c                  |  136 +-
 tools/testing/selftests/bpf/xsk.h                  |    2 +
 tools/testing/selftests/bpf/xsk_prereqs.sh         |    7 +
 tools/testing/selftests/bpf/xskxceiver.c           |  458 +-
 tools/testing/selftests/bpf/xskxceiver.h           |   21 +-
 tools/testing/selftests/connector/.gitignore       |    1 +
 tools/testing/selftests/connector/Makefile         |    6 +
 tools/testing/selftests/connector/proc_filter.c    |  310 +
 .../net/bonding/bond-arp-interval-causes-panic.sh  |    9 +-
 .../selftests/drivers/net/mlxsw/port_range_occ.sh  |  111 +
 .../drivers/net/mlxsw/port_range_scale.sh          |   95 +
 .../selftests/drivers/net/mlxsw/rif_bridge.sh      |  183 +
 .../testing/selftests/drivers/net/mlxsw/rif_lag.sh |  136 +
 .../selftests/drivers/net/mlxsw/rif_lag_vlan.sh    |  146 +
 .../drivers/net/mlxsw/router_bridge_lag.sh         |   50 +
 .../selftests/drivers/net/mlxsw/rtnetlink.sh       |   31 -
 .../net/mlxsw/spectrum-2/port_range_scale.sh       |    1 +
 .../drivers/net/mlxsw/spectrum-2/resource_scale.sh |    1 +
 .../drivers/net/mlxsw/spectrum/port_range_scale.sh |   16 +
 .../drivers/net/mlxsw/spectrum/resource_scale.sh   |    1 +
 tools/testing/selftests/hid/Makefile               |    6 +-
 tools/testing/selftests/net/Makefile               |    8 +-
 tools/testing/selftests/net/config                 |    1 +
 tools/testing/selftests/net/csum.c                 |    6 +-
 tools/testing/selftests/net/fib_nexthops.sh        |  129 +
 tools/testing/selftests/net/fib_tests.sh           |  222 +-
 tools/testing/selftests/net/forwarding/Makefile    |    7 +
 .../selftests/net/forwarding/bridge_locked_port.sh |   36 +
 tools/testing/selftests/net/forwarding/lib.sh      |   18 +
 .../selftests/net/forwarding/router_bridge.sh      |   76 +
 .../selftests/net/forwarding/router_bridge_1d.sh   |  185 +
 .../net/forwarding/router_bridge_1d_lag.sh         |  408 +
 .../selftests/net/forwarding/router_bridge_lag.sh  |  323 +
 .../forwarding/router_bridge_pvid_vlan_upper.sh    |  155 +
 .../selftests/net/forwarding/router_bridge_vlan.sh |  100 +-
 .../net/forwarding/router_bridge_vlan_upper.sh     |  169 +
 .../forwarding/router_bridge_vlan_upper_pvid.sh    |  171 +
 .../net/forwarding/tc_flower_port_range.sh         |  228 +
 tools/testing/selftests/net/hwtstamp_config.c      |    6 +-
 tools/testing/selftests/net/mptcp/diag.sh          |    7 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |   66 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  762 +-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  105 +
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |   20 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |   12 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c      |   33 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  |    4 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  281 +-
 .../selftests/net/openvswitch/openvswitch.sh       |  325 +-
 .../testing/selftests/net/openvswitch/ovs-dpctl.py |  602 +-
 tools/testing/selftests/net/psock_lib.h            |    4 +-
 tools/testing/selftests/net/rtnetlink.sh           |   83 +
 .../net/srv6_end_x_next_csid_l3vpn_test.sh         | 1213 +++
 tools/testing/selftests/net/tcp_mmap.c             |   18 +-
 .../selftests/net/test_bridge_backup_port.sh       |  759 ++
 tools/testing/selftests/net/tls.c                  |   95 +
 tools/testing/selftests/net/vrf_route_leaking.sh   |    2 +-
 tools/testing/selftests/ptp/testptp.c              |   73 +-
 tools/testing/selftests/tc-testing/Makefile        |    2 +-
 tools/testing/selftests/tc-testing/config          |    3 +-
 .../selftests/tc-testing/taprio_wait_for_admin.sh  |   16 +
 .../tc-testing/tc-tests/qdiscs/taprio.json         |  102 +-
 tools/testing/vsock/vsock_test.c                   |  136 +-
 1855 files changed, 109626 insertions(+), 46103 deletions(-)
 create mode 100644 Documentation/bpf/standardization/index.rst
 rename Documentation/bpf/{ => standardization}/instruction-set.rst (69%)
 rename Documentation/bpf/{ => standardization}/linux-notes.rst (96%)
 create mode 100644 Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/oxnas-dwmac.txt
 create mode 100644 Documentation/devicetree/bindings/net/ti,icss-iep.yaml
 create mode 100644 Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt
 create mode 100644 Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
 create mode 100644 Documentation/netlink/netlink-raw.yaml
 create mode 100644 Documentation/netlink/specs/rt_addr.yaml
 create mode 100644 Documentation/netlink/specs/rt_link.yaml
 create mode 100644 Documentation/netlink/specs/rt_route.yaml
 delete mode 100644 Documentation/networking/device_drivers/ethernet/mellanox/mlx5/devlink.rst
 create mode 100644 Documentation/userspace-api/netlink/netlink-raw.rst
 create mode 100644 drivers/infiniband/hw/mlx5/macsec.c
 create mode 100644 drivers/infiniband/hw/mlx5/macsec.h
 create mode 100644 drivers/net/dsa/mv88e6xxx/pcs-6185.c
 create mode 100644 drivers/net/dsa/mv88e6xxx/pcs-6352.c
 create mode 100644 drivers/net/dsa/mv88e6xxx/pcs-639x.c
 create mode 100644 drivers/net/ethernet/broadcom/asp2/Makefile
 create mode 100644 drivers/net/ethernet/broadcom/asp2/bcmasp.c
 create mode 100644 drivers/net/ethernet/broadcom/asp2/bcmasp.h
 create mode 100644 drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
 create mode 100644 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
 create mode 100644 drivers/net/ethernet/broadcom/asp2/bcmasp_intf_defs.h
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.h
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.h
 delete mode 100644 drivers/net/ethernet/intel/i40e/i40e_status.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_eswitch_br.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_eswitch_br.h
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep/octep_cp_version.h
 delete mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c
 delete mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
 delete mode 100644 drivers/net/ethernet/mellanox/mlx5/core/thermal.c
 delete mode 100644 drivers/net/ethernet/mellanox/mlx5/core/thermal.h
 create mode 100644 drivers/net/ethernet/mellanox/mlxsw/spectrum_port_range.c
 delete mode 100644 drivers/net/ethernet/sfc/farch_regs.h
 create mode 100644 drivers/net/ethernet/sfc/tc_conntrack.c
 create mode 100644 drivers/net/ethernet/sfc/tc_conntrack.h
 delete mode 100644 drivers/net/ethernet/sfc/vfdi.h
 delete mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-oxnas.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.h
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_classifier.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_config.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_config.h
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_ethtool.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_mii_rt.h
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_prueth.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_prueth.h
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_queues.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_stats.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_stats.h
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_switch_map.h
 create mode 100644 drivers/net/netdevsim/macsec.c
 create mode 100644 drivers/net/pcs/pcs-xpcs-wx.c
 create mode 100644 drivers/net/phy/marvell-88q2xxx.c
 create mode 100644 drivers/net/phy/stubs.c
 create mode 100644 drivers/net/vmxnet3/vmxnet3_xdp.c
 create mode 100644 drivers/net/vmxnet3/vmxnet3_xdp.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/trace.c
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x.h
 rename drivers/net/wireless/mediatek/mt76/{mt7921/acpi_sar.c => mt792x_acpi_sar.c} (64%)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_core.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_debugfs.c
 rename drivers/net/wireless/mediatek/mt76/{mt7921/dma.c => mt792x_dma.c} (55%)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_regs.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_trace.c
 rename drivers/net/wireless/mediatek/mt76/{mt7921/mt7921_trace.h => mt792x_trace.h} (68%)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_usb.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/mac_be.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/phy_be.c
 create mode 100644 drivers/ptp/ptp_mock.c
 create mode 100644 include/linux/bpf_mprog.h
 delete mode 100644 include/linux/fs_enet_pd.h
 create mode 100644 include/linux/mlx5/macsec.h
 create mode 100644 include/linux/phylib_stubs.h
 create mode 100644 include/linux/ptp_mock.h
 delete mode 100644 include/net/ila.h
 create mode 100644 include/net/netdev_rx_queue.h
 delete mode 100644 include/net/page_pool.h
 create mode 100644 include/net/page_pool/helpers.h
 create mode 100644 include/net/page_pool/types.h
 create mode 100644 include/net/tcx.h
 create mode 100644 include/net/tls_prot.h
 create mode 100644 kernel/bpf/mprog.c
 create mode 100644 kernel/bpf/tcx.c
 create mode 100644 net/devlink/dpipe.c
 delete mode 100644 net/devlink/leftover.c
 create mode 100644 net/devlink/linecard.c
 create mode 100644 net/devlink/netlink_gen.c
 create mode 100644 net/devlink/netlink_gen.h
 create mode 100644 net/devlink/param.c
 create mode 100644 net/devlink/port.c
 create mode 100644 net/devlink/rate.c
 create mode 100644 net/devlink/region.c
 create mode 100644 net/devlink/resource.c
 create mode 100644 net/devlink/sb.c
 create mode 100644 net/devlink/trap.c
 create mode 100644 net/handshake/alert.c
 create mode 100644 net/mptcp/sched.c
 create mode 100644 net/openvswitch/drop.h
 rename samples/bpf/{offwaketime_kern.c => offwaketime.bpf.c} (76%)
 rename samples/bpf/{spintest_kern.c => spintest.bpf.c} (67%)
 rename samples/bpf/{tracex1_kern.c => tracex1.bpf.c} (60%)
 rename samples/bpf/{tracex3_kern.c => tracex3.bpf.c} (70%)
 rename samples/bpf/{tracex4_kern.c => tracex4.bpf.c} (95%)
 rename samples/bpf/{tracex5_kern.c => tracex5.bpf.c} (90%)
 rename samples/bpf/{tracex6_kern.c => tracex6.bpf.c} (71%)
 rename samples/bpf/{tracex7_kern.c => tracex7.bpf.c} (82%)
 delete mode 100644 samples/bpf/xdp1_kern.c
 delete mode 100644 samples/bpf/xdp1_user.c
 delete mode 100644 samples/bpf/xdp2_kern.c
 delete mode 100644 samples/bpf/xdp_monitor.bpf.c
 delete mode 100644 samples/bpf/xdp_monitor_user.c
 delete mode 100644 samples/bpf/xdp_redirect.bpf.c
 delete mode 100644 samples/bpf/xdp_redirect_cpu.bpf.c
 delete mode 100644 samples/bpf/xdp_redirect_cpu_user.c
 delete mode 100644 samples/bpf/xdp_redirect_map.bpf.c
 delete mode 100644 samples/bpf/xdp_redirect_map_multi.bpf.c
 delete mode 100644 samples/bpf/xdp_redirect_map_multi_user.c
 delete mode 100644 samples/bpf/xdp_redirect_map_user.c
 delete mode 100644 samples/bpf/xdp_redirect_user.c
 delete mode 100644 samples/bpf/xdp_rxq_info_kern.c
 delete mode 100644 samples/bpf/xdp_rxq_info_user.c
 delete mode 100644 samples/bpf/xdp_sample_pkts_kern.c
 delete mode 100644 samples/bpf/xdp_sample_pkts_user.c
 create mode 100644 tools/lib/bpf/elf.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_htab_mem.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_htab_mem.sh
 create mode 100644 tools/testing/selftests/bpf/cgroup_tcp_skb.h
 create mode 100755 tools/testing/selftests/bpf/generate_udp_fragments.py
 create mode 100644 tools/testing/selftests/bpf/ip_check_defrag_frags.h
 create mode 100644 tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/assign_reuse.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fill_link_info.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ptr_untrusted.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_links.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_opts.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_ldsx_insn.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_many_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/fexit_many_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_mem_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/ip_check_defrag.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_percpu_stats.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_assign_reuse.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fill_link_info.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ldsx_insn.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_redirect.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_reroute.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_netfilter_link_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_link.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bswap.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_gotol.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ldsx.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_movsx.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_sdiv.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_typedef.c
 create mode 100644 tools/testing/selftests/bpf/uprobe_multi.c
 create mode 100644 tools/testing/selftests/connector/.gitignore
 create mode 100644 tools/testing/selftests/connector/Makefile
 create mode 100644 tools/testing/selftests/connector/proc_filter.c
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/port_range_occ.sh
 create mode 100644 tools/testing/selftests/drivers/net/mlxsw/port_range_scale.sh
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/rif_bridge.sh
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/rif_lag.sh
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/rif_lag_vlan.sh
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/router_bridge_lag.sh
 create mode 120000 tools/testing/selftests/drivers/net/mlxsw/spectrum-2/port_range_scale.sh
 create mode 100644 tools/testing/selftests/drivers/net/mlxsw/spectrum/port_range_scale.sh
 create mode 100755 tools/testing/selftests/net/forwarding/router_bridge_1d.sh
 create mode 100755 tools/testing/selftests/net/forwarding/router_bridge_1d_lag.sh
 create mode 100755 tools/testing/selftests/net/forwarding/router_bridge_lag.sh
 create mode 100755 tools/testing/selftests/net/forwarding/router_bridge_pvid_vlan_upper.sh
 create mode 100755 tools/testing/selftests/net/forwarding/router_bridge_vlan_upper.sh
 create mode 100755 tools/testing/selftests/net/forwarding/router_bridge_vlan_upper_pvid.sh
 create mode 100755 tools/testing/selftests/net/forwarding/tc_flower_port_range.sh
 create mode 100755 tools/testing/selftests/net/srv6_end_x_next_csid_l3vpn_test.sh
 create mode 100755 tools/testing/selftests/net/test_bridge_backup_port.sh
 create mode 100755 tools/testing/selftests/tc-testing/taprio_wait_for_admin.sh


