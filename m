Return-Path: <bpf+bounces-19265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2028289E6
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 17:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FF1286D06
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 16:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182B73A268;
	Tue,  9 Jan 2024 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRK1nzA4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BF43A8C4
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704817418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NaXXuHuYUf19ODmyjGaGe/W5BBsRoD+cn9uJ1gN3FvA=;
	b=fRK1nzA4T5kdwlTmRx8gP4NAadPnjTCaL8OC1TGD+wsIJ6PuDRCfPBX+C1qDi2+fqsDM0d
	yFJsmZUncyO1nOrs4EBvWG5aJhl7L6ooITo6JURGztqV6+lrJL2Z51HMiz5qKhvP9uWK8e
	2iALqGdFFUT3UubqDZBcKkYqFEe5NGo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-HiIAQkwDM2CCeYIEYC41Tw-1; Tue, 09 Jan 2024 11:23:33 -0500
X-MC-Unique: HiIAQkwDM2CCeYIEYC41Tw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85D3E106D0C2;
	Tue,  9 Jan 2024 16:23:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 641BB40C6EB9;
	Tue,  9 Jan 2024 16:23:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [GIT PULL] Networking for v6.8
Date: Tue,  9 Jan 2024 17:23:23 +0100
Message-ID: <20240109162323.427562-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Hi Linus!

The most interesting thing is probably the networking structs
reorganization and a significant amount of changes is around
self-tests.

AFAIK there is only a minor conflict versus the pending changes in
the execve tree:

https://lore.kernel.org/linux-next/20231218161704.05c25766@canb.auug.org.au/

adjacent changes with trivial resolution.

The following changes since commit 1f874787ed9a2d78ed59cb21d0d90ac0178eceb0:

  Merge tag 'net-6.7-rc9' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-01-04 16:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.8

for you to fetch changes up to a7fe0881d9b78d402bbd9067dd4503a57c57a1d9:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-01-09 16:23:26 +0100)

----------------------------------------------------------------
Networking changes for 6.8.

Core & protocols
----------------

 - Analyze and reorganize core networking structs (socks, netdev,
   netns, mibs) to optimize cacheline consumption and set up
   build time warnings to safeguard against future header changes.
   This improves TCP performances with many concurrent connections
   up to 40%.

 - Add page-pool netlink-based introspection, exposing the
   memory usage and recycling stats. This helps indentify
   bad PP users and possible leaks.

 - Refine TCP/DCCP source port selection to no longer favor even
   source port at connect() time when IP_LOCAL_PORT_RANGE is set.
   This lowers the time taken by connect() for hosts having
   many active connections to the same destination.

 - Refactor the TCP bind conflict code, shrinking related socket
   structs.

 - Refactor TCP SYN-Cookie handling, as a preparation step to
   allow arbitrary SYN-Cookie processing via eBPF.

 - Tune optmem_max for 0-copy usage, increasing the default value
   to 128KB and namespecifying it.

 - Allow coalescing for cloned skbs coming from page pools, improving
   RX performances with some common configurations.

 - Reduce extension header parsing overhead at GRO time.

 - Add bridge MDB bulk deletion support, allowing user-space to
   request the deletion of matching entries.

 - Reorder nftables struct members, to keep data accessed by the
   datapath first.

 - Introduce TC block ports tracking and use. This allows supporting
   multicast-like behavior at the TC layer.

 - Remove UAPI support for retired TC qdiscs (dsmark, CBQ and ATM) and
   classifiers (RSVP and tcindex).

 - More data-race annotations.

 - Extend the diag interface to dump TCP bound-only sockets.

 - Conditional notification of events for TC qdisc class and actions.

 - Support for WPAN dynamic associations with nearby devices, to form
   a sub-network using a specific PAN ID.

 - Implement SMCv2.1 virtual ISM device support.

 - Add support for Batman-avd mulicast packet type.

BPF
---

 - Tons of verifier improvements:
   - BPF register bounds logic and range support along with a large
     test suite
   - log improvements
   - complete precision tracking support for register spills
   - track aligned STACK_ZERO cases as imprecise spilled registers. It
     improves the verifier "instructions processed" metric from single
     digit to 50-60% for some programs
   - support for user's global BPF subprogram arguments with few
     commonly requested annotations for a better developer experience
   - support tracking of BPF_JNE which helps cases when the compiler
     transforms (unsigned) "a > 0" into "if a == 0 goto xxx" and the
     like
   - several fixes

 - Add initial TX metadata implementation for AF_XDP with support in
   mlx5 and stmmac drivers. Two types of offloads are supported right
   now, that is, TX timestamp and TX checksum offload.

 - Fix kCFI bugs in BPF all forms of indirect calls from BPF into
   kernel and from kernel into BPF work with CFI enabled. This allows
   BPF to work with CONFIG_FINEIBT=y.

 - Change BPF verifier logic to validate global subprograms lazily
   instead of unconditionally before the main program, so they can be
   guarded using BPF CO-RE techniques.

 - Support uid/gid options when mounting bpffs.

 - Add a new kfunc which acquires the associated cgroup of a task
   within a specific cgroup v1 hierarchy where the latter is identified
   by its id.

 - Extend verifier to allow bpf_refcount_acquire() of a map value field
   obtained via direct load which is a use-case needed in sched_ext.

 - Add BPF link_info support for uprobe multi link along with bpftool
   integration for the latter.

 - Support for VLAN tag in XDP hints.

 - Remove deprecated bpfilter kernel leftovers given the project
   is developed in user-space (https://github.com/facebook/bpfilter).

Misc
----

 - Support for parellel TC self-tests execution.

 - Increase MPTCP self-tests coverage.

 - Updated the bridge documentation, including several so-far
   undocumented features.

 - Convert all the net self-tests to run in unique netns, to
   avoid random failures due to conflict and allow concurrent
   runs.

 - Add TCP-AO self-tests.

 - Add kunit tests for both cfg80211 and mac80211.

 - Autogenerate Netlink families documentation from YAML spec.

 - Add yml-gen support for fixed headers and recursive nests, the
   tool can now generate user-space code for all genetlink families
   for which we have specs.

 - A bunch of additional module descriptions fixes.

 - Catch incorrect freeing of pages belonging to a page pool.

Driver API
----------

 - Rust abstractions for network PHY drivers; do not cover yet the
   full C API, but already allow implementing functional PHY drivers
   in rust.

 - Introduce queue and NAPI support in the netdev Netlink interface,
   allowing complete access to the device <> NAPIs <> queues
   relationship.

 - Introduce notifications filtering for devlink to allow control
   application scale to thousands of instances.

 - Improve PHY validation, requesting rate matching information for
   each ethtool link mode supported by both the PHY and host.

 - Add support for ethtool symmetric-xor RSS hash.

 - ACPI based Wifi band RFI (WBRF) mitigation feature for the AMD
   platform.

 - Expose pin fractional frequency offset value over new DPLL generic
   netlink attribute.

 - Convert older drivers to platform remove callback returning void.

 - Add support for PHY package MMD read/write.

New hardware / drivers
----------------------

 - Ethernet:
   - Octeon CN10K devices
   - Broadcom 5760X P7
   - Qualcomm SM8550 SoC
   - Texas Instrument DP83TG720S PHY

 - Bluetooth:
   - IMC Networks Bluetooth radio

Removed
-------

 - WiFi:
   - libertas 16-bit PCMCIA support
   - Atmel at76c50x drivers
   - HostAP ISA/PCMCIA style 802.11b driver
   - zd1201 802.11b USB dongles
   - Orinoco ISA/PCMCIA 802.11b driver
   - Aviator/Raytheon driver
   - Planet WL3501 driver
   - RNDIS USB 802.11b driver

Drivers
-------

 - Ethernet high-speed NICs:
   - Intel (100G, ice, idpf):
     - allow one by one port representors creation and removal
     - add temperature and clock information reporting
     - add get/set for ethtool's header split ringparam
     - add again FW logging
     - adds support switchdev hardware packet mirroring
     - iavf: implement symmetric-xor RSS hash
     - igc: add support for concurrent physical and free-running timers
     - i40e: increase the allowable descriptors
   - nVidia/Mellanox:
     - Preparation for Socket-Direct multi-dev netdev. That will allow
       in future releases combining multiple PFs devices attached to
       different NUMA nodes under the same netdev
   - Broadcom (bnxt):
     - TX completion handling improvements
     - add basic ntuple filter support
     - reduce MSIX vectors usage for MQPRIO offload
     - add VXLAN support, USO offload and TX coalesce completion for P7
   - Marvell Octeon EP:
     - xmit-more support
     - add PF-VF mailbox support and use it for FW notifications for VFs
   - Wangxun (ngbe/txgbe):
     - implement ethtool functions to operate pause param, ring param,
       coalesce channel number and msglevel
   - Netronome/Corigine (nfp):
     - add flow-steering support
     - support UDP segmentation offload

 - Ethernet NICs embedded, slower, virtual:
   - Xilinx AXI: remove duplicate DMA code adopting the dma engine driver
   - stmmac: add support for HW-accelerated VLAN stripping
   - TI AM654x sw: add mqprio, frame preemption & coalescing
   - gve: add support for non-4k page sizes.
   - virtio-net: support dynamic coalescing moderation

 - nVidia/Mellanox Ethernet datacenter switches:
   - allow firmware upgrade without a reboot
   - more flexible support for bridge flooding via the compressed
     FID flooding mode

 - Ethernet embedded switches:
   - Microchip:
     - fine-tune flow control and speed configurations in KSZ8xxx
     - KSZ88X3: enable setting rmii reference
   - Renesas:
     - add jumbo frames support
   - Marvell:
     - 88E6xxx: add "eth-mac" and "rmon" stats support

 - Ethernet PHYs:
   - aquantia: add firmware load support
   - at803x: refactor the driver to simplify adding support for more
     chip variants
   - NXP C45 TJA11xx: Add MACsec offload support

 - Wifi:
   - MediaTek (mt76):
     - NVMEM EEPROM improvements
     - mt7996 Extremely High Throughput (EHT) improvements
     - mt7996 Wireless Ethernet Dispatcher (WED) support
     - mt7996 36-bit DMA support
   - Qualcomm (ath12k):
     - support for a single MSI vector
     - WCN7850: support AP mode
   - Intel (iwlwifi):
     - new debugfs file fw_dbg_clear
     - allow concurrent P2P operation on DFS channels

 - Bluetooth:
   - QCA2066: support HFP offload
   - ISO: more broadcast-related improvements
   - NXP: better recovery in case receiver/transmitter get out of sync

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Ahelenia Ziemiańska (1):
      net: dns_resolver: the module is called dns_resolver, not dnsresolver

Ahmed Zaki (9):
      net: ethtool: pass a pointer to parameters to get/set_rxfh ethtool ops
      net: ethtool: get rid of get/set_rxfh_context functions
      net: ethtool: add support for symmetric-xor RSS hash
      ice: fix ICE_AQ_VSI_Q_OPT_RSS_* register values
      ice: refactor the FD and RSS flow ID generation
      iavf: enable symmetric-xor RSS for Toeplitz hash function
      net: ethtool: copy input_xfrm to user-space in ethtool_get_rxfh
      net: ethtool: add a NO_CHANGE uAPI for new RXFH's input_xfrm
      net: ethtool: reject unsupported RSS input xfrm values

Ajit Khaparde (1):
      bnxt_en: Refactor RSS capability fields

Akihiko Odaki (3):
      selftests/bpf: Choose pkg-config for the target
      selftests/bpf: Override PKG_CONFIG for static builds
      selftests/bpf: Use pkg-config for libelf

Alce Lafranque (1):
      vxlan: add support for flowlabel inherit

Aleksander Lobakin (1):
      net, xdp: Allow metadata > 32

Alex Austin (2):
      sfc: Implement ndo_hwtstamp_(get|set)
      sfc-siena: Implement ndo_hwtstamp_(get|set)

Alex Elder (5):
      dt-bindings: net: qcom,ipa: add SM8550 compatible
      net: ipa: update IPA version comments in "ipa_reg.h"
      net: ipa: prepare for IPA v5.5
      net: ipa: add IPA v5.5 register definitions
      net: ipa: add IPA v5.5 configuration data

Alexander Lobakin (1):
      ethtool: add SET for TCP_DATA_SPLIT ringparam

Alexei Starovoitov (38):
      Merge branch 'bpf-register-bounds-logic-and-testing-improvements'
      Merge branch 'allow-bpf_refcount_acquire-of-mapval-obtained-via-direct-ld'
      Merge branch 'for-6.8-bpf' of https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup into bpf-next
      Merge branch 'bpf-add-support-for-cgroup1-bpf-part'
      Merge branch 'bpf-register-bounds-range-vs-range-support'
      Merge branch 'bpf-verifier-log-improvements'
      Merge branch 'bpf-kernel-bpf-task_iter-c-don-t-abuse-next_thread'
      Merge branch 'xsk-tx-metadata'
      Merge branch 'bpf-file-verification-with-lsm-and-fsverity'
      Merge branch 'bpf-verifier-retval-logic-fixes'
      Merge branch 'bpf-fix-the-release-of-inner-map'
      Merge branch 'complete-bpf-verifier-precision-tracking-support-for-register-spills'
      Merge branch 'bpf-token-and-bpf-fs-based-delegation'
      Merge branch 'allocate-bpf-trampoline-on-bpf_prog_pack'
      Merge branch 'bpf-fixes-for-maybe_wait_bpf_programs'
      Merge branch 'add-new-bpf_cpumask_weight-kfunc'
      Merge branch 'bpf-token-support-in-libbpf-s-bpf-object'
      Merge branch 'xdp-metadata-via-kfuncs-for-ice-vlan-hint'
      Merge branch 'bpf-use-gfp_kernel-in-bpf_event_entry_gen'
      Merge branch 'add-bpf_xdp_get_xfrm_state-kfunc'
      Merge branch 'bpf-fs-mount-options-parsing-follow-ups'
      x86/cfi,bpf: Fix bpf_exception_cb() signature
      Merge branch 'x86-cfi-bpf-fix-cfi-vs-ebpf'
      selftests/bpf: Temporarily disable dummy_struct_ops test on s390
      s390/bpf: Fix indirect trampoline generation
      Merge branch 'bpf-support-to-track-bpf_jne'
      Merge branch 'enhance-bpf-global-subprogs-with-argument-tags'
      Merge branch 'bpf-fix-warning-in-check_obj_size'
      selftests/bpf: Attempt to build BPF programs with -Wsign-compare
      bpf: Introduce "volatile compare" macros
      selftests/bpf: Convert exceptions_assert.c to bpf_cmp
      selftests/bpf: Remove bpf_assert_eq-like macros.
      bpf: Add bpf_nop_mov() asm macro.
      selftests/bpf: Convert profiler.c to bpf_cmp.
      Merge branch 'bpf-reduce-memory-usage-for-bpf_global_percpu_ma'
      Merge branch 'libbpf-side-__arg_ctx-fallback-support'
      Merge branch 's390-bpf-fix-gotol-with-large-offsets'
      Merge branch 'relax-tracing-prog-recursive-attach-rules'

Allen Ye (2):
      wifi: mt76: use chainmask for power delta calculation
      wifi: mt76: connac: add beacon protection support for mt7996

Alyssa Ross (1):
      libbpf: Skip DWARF sections in linker sanity check

Amir Tzin (1):
      net/mlx5e: Some cleanup in mlx5e_tc_stats_matchall()

Amit Cohen (3):
      mlxsw: Extend MRSR pack() function to support new commands
      mlxsw: pci: Rename mlxsw_pci_sw_reset()
      mlxsw: pci: Move software reset code to a separate function

Amritha Nambiar (10):
      netdev-genl: spec: Extend netdev netlink spec in YAML for queue
      net: Add queue and napi association
      ice: Add support in the driver for associating queue with napi
      netdev-genl: Add netlink framework functions for queue
      netdev-genl: spec: Extend netdev netlink spec in YAML for NAPI
      netdev-genl: Add netlink framework functions for napi
      netdev-genl: spec: Add irq in netdev netlink YAML spec
      net: Add NAPI IRQ support
      netdev-genl: spec: Add PID in netdev netlink YAML spec
      netdev-genl: Add PID for the NAPI thread

Anders Roxell (1):
      selftests/bpf: Disable CONFIG_DEBUG_INFO_REDUCED in config.aarch64

Andrei Matei (10):
      bpf: Minor logging improvement
      bpf: Fix verification of indirect var-off stack access
      bpf: Add verifier regression test for previous patch
      bpf: Guard stack limits against 32bit overflow
      bpf: Add some comments to stack representation
      bpf: Fix accesses to uninit stack slots
      bpf: Minor cleanup around stack bounds
      bpf: Comment on check_mem_size_reg
      bpf: Simplify checking size of helper accesses
      bpf: Add a possibly-zero-sized read test

Andrei Otcheretianski (9):
      wifi: mac80211: Replace ENOTSUPP with EOPNOTSUPP
      wifi: cfg80211: Replace ENOTSUPP with EOPNOTSUPP
      wifi: cfg80211: reg: Support P2P operation on DFS channels
      wifi: cfg80211: Schedule regulatory check on BSS STA channel change
      wifi: mac80211: Schedule regulatory channels check on bandwith change
      wifi: mac80211_hwsim: Add custom reg for DFS concurrent
      wifi: iwlwifi: mvm: Allow DFS concurrent operation
      wifi: iwlwifi: Don't mark DFS channels as NO-IR
      wifi: iwlwifi: replace ENOTSUPP with EOPNOTSUPP

Andrew Halaney (2):
      net: phy: mdio_device: Reset device only when necessary
      net: stmmac: don't create a MDIO bus if unnecessary

Andrii Nakryiko (134):
      selftests/bpf: fix RELEASE=1 build for tc_opts
      selftests/bpf: satisfy compiler by having explicit return in btf test
      bpf: derive smin/smax from umin/max bounds
      bpf: derive smin32/smax32 from umin32/umax32 bounds
      bpf: derive subreg bounds from full bounds when upper 32 bits are constant
      bpf: add special smin32/smax32 derivation from 64-bit bounds
      bpf: improve deduction of 64-bit bounds from 32-bit bounds
      bpf: try harder to deduce register bounds from different numeric domains
      bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic
      bpf: rename is_branch_taken reg arguments to prepare for the second one
      bpf: generalize is_branch_taken() to work with two registers
      bpf: move is_branch_taken() down
      bpf: generalize is_branch_taken to handle all conditional jumps in one place
      bpf: unify 32-bit and 64-bit is_branch_taken logic
      bpf: prepare reg_set_min_max for second set of registers
      bpf: generalize reg_set_min_max() to handle two sets of two registers
      Merge branch 'selftests/bpf: Fixes for map_percpu_stats test'
      Merge branch 'bpf: __bpf_dynptr_data* and __str annotation'
      veristat: add ability to sort by stat's absolute value
      veristat: add ability to filter top N results
      bpf: generalize reg_set_min_max() to handle non-const register comparisons
      bpf: generalize is_scalar_branch_taken() logic
      bpf: enhance BPF_JEQ/BPF_JNE is_branch_taken logic
      bpf: add register bounds sanity checks and sanitization
      bpf: remove redundant s{32,64} -> u{32,64} deduction logic
      bpf: make __reg{32,64}_deduce_bounds logic more robust
      selftests/bpf: BPF register range bounds tester
      selftests/bpf: adjust OP_EQ/OP_NE handling to use subranges for branch taken
      selftests/bpf: add range x range test to reg_bounds
      selftests/bpf: add randomized reg_bounds tests
      selftests/bpf: set BPF_F_TEST_SANITY_SCRIPT by default
      veristat: add ability to set BPF_F_TEST_SANITY_STRICT flag with -r flag
      selftests/bpf: add iter test requiring range x range logic
      bpf: rename BPF_F_TEST_SANITY_STRICT to BPF_F_TEST_REG_INVARIANTS
      bpf: move verbose_linfo() into kernel/bpf/log.c
      bpf: move verifier state printing code to kernel/bpf/log.c
      bpf: extract register state printing
      bpf: print spilled register state in stack slot
      bpf: emit map name in register state if applicable and available
      bpf: omit default off=0 and imm=0 in register state log
      bpf: smarter verifier log number printing logic
      bpf: emit frameno for PTR_TO_STACK regs if it differs from current one
      selftests/bpf: reduce verboseness of reg_bounds selftest logs
      Merge branch 'selftests-bpf-update-multiple-prog_tests-to-use-assert_-macros'
      bpf: Emit global subprog name in verifier logs
      bpf: Validate global subprogs lazily
      selftests/bpf: Add lazy global subprog validation tests
      Merge branch 'bpf-add-link_info-support-for-uprobe-multi-link'
      Merge branch 'selftests-bpf-use-pkg-config-to-determine-ld-flags'
      bpf: rearrange bpf_func_state fields to save a bit of memory
      bpf: provide correct register name for exception callback retval check
      bpf: enforce precision of R0 on callback return
      bpf: enforce exact retval range on subprog/callback exit
      selftests/bpf: add selftest validating callback result is enforced
      bpf: enforce precise retval range on program exit
      bpf: unify async callback and program retval checks
      bpf: enforce precision of R0 on program/async callback return
      selftests/bpf: validate async callback return value check correctness
      selftests/bpf: adjust global_func15 test to validate prog exit precision
      bpf: simplify tnum output if a fully known constant
      bpf: support non-r10 register spill/fill to/from stack in precision tracking
      selftests/bpf: add stack access precision test
      bpf: fix check for attempt to corrupt spilled pointer
      bpf: preserve STACK_ZERO slots on partial reg spills
      selftests/bpf: validate STACK_ZERO is preserved on subreg spill
      bpf: preserve constant zero when doing partial register restore
      selftests/bpf: validate zero preservation for sub-slot loads
      bpf: track aligned STACK_ZERO cases as imprecise spilled registers
      selftests/bpf: validate precision logic in partial_stack_load_preserves_zeros
      bpf: align CAP_NET_ADMIN checks with bpf_capable() approach
      bpf: add BPF token delegation mount options to BPF FS
      bpf: introduce BPF token object
      bpf: add BPF token support to BPF_MAP_CREATE command
      bpf: add BPF token support to BPF_BTF_LOAD command
      bpf: add BPF token support to BPF_PROG_LOAD command
      bpf: take into account BPF token when fetching helper protos
      bpf: consistently use BPF token throughout BPF verifier logic
      bpf,lsm: refactor bpf_prog_alloc/bpf_prog_free LSM hooks
      bpf,lsm: refactor bpf_map_alloc/bpf_map_free LSM hooks
      bpf,lsm: add BPF token LSM hooks
      libbpf: add bpf_token_create() API
      libbpf: add BPF token support to bpf_map_create() API
      libbpf: add BPF token support to bpf_btf_load() API
      libbpf: add BPF token support to bpf_prog_load() API
      selftests/bpf: add BPF token-enabled tests
      bpf,selinux: allocate bpf_security_struct per BPF token
      bpf: rename MAX_BPF_LINK_TYPE into __MAX_BPF_LINK_TYPE for consistency
      Merge branch 'bpf-fix-verification-of-indirect-var-off-stack-access'
      Merge branch 'bpf-fix-accesses-to-uninit-stack-slots'
      selftests/bpf: fix timer/test_bad_ret subtest on test_progs-cpuv4 flavor
      bpf: handle fake register spill to stack with BPF_ST_MEM instruction
      selftests/bpf: validate fake register spill/fill precision backtracking logic
      selftests/bpf: validate eliminated global subprog is not freplaceable
      bpf: log PTR_TO_MEM memory size in verifier log
      bpf: emit more dynptr information in verifier log
      bpf: tidy up exception callback management a bit
      bpf: use bitfields for simple per-subprog bool flags
      selftests/bpf: fix compiler warnings in RELEASE=1 mode
      bpf: fail BPF_TOKEN_CREATE if no delegation option was set on BPF FS
      libbpf: split feature detectors definitions from cached results
      libbpf: further decouple feature checking logic from bpf_object
      libbpf: move feature detection code into its own file
      libbpf: wire up token_fd into feature probing logic
      libbpf: wire up BPF token support at BPF object level
      selftests/bpf: add BPF object loading tests with explicit token passing
      selftests/bpf: add tests for BPF object load with implicit token
      libbpf: support BPF token path setting through LIBBPF_BPF_TOKEN_PATH envvar
      selftests/bpf: add tests for LIBBPF_BPF_TOKEN_PATH envvar
      bpf: support symbolic BPF FS delegation mount options
      selftests/bpf: utilize string values for delegate_xxx mount options
      Merge branch 'bpf-add-check-for-negative-uprobe-multi-offset'
      bpf: Ensure precise is reset to false in __mark_reg_const_zero()
      Revert BPF token-related functionality
      bpf: abstract away global subprog arg preparation logic from reg state setup
      bpf: reuse btf_prepare_func_args() check for main program BTF validation
      bpf: prepare btf_prepare_func_args() for handling static subprogs
      bpf: move subprog call logic back to verifier.c
      bpf: reuse subprog argument parsing logic for subprog call checks
      bpf: support 'arg:xxx' btf_decl_tag-based hints for global subprog args
      bpf: add support for passing dynptr pointer to global subprog
      libbpf: add __arg_xxx macros for annotating global func args
      selftests/bpf: add global subprog annotation tests
      selftests/bpf: add freplace of BTF-unreliable main prog test
      Merge branch 'bpf-simplify-checking-size-of-helper-accesses'
      Merge branch 'bpf-volatile-compare'
      libbpf: make uniform use of btf__fd() accessor inside libbpf
      libbpf: use explicit map reuse flag to skip map creation steps
      libbpf: don't rely on map->fd as an indicator of map being created
      libbpf: use stable map placeholder FDs
      libbpf: move exception callbacks assignment logic into relocation step
      libbpf: move BTF loading step after relocation step
      libbpf: implement __arg_ctx fallback logic
      selftests/bpf: add arg:ctx cases to test_global_funcs tests
      selftests/bpf: add __arg_ctx BTF rewrite test

Andrii Staikov (3):
      i40e: Change user notification of non-SFP module in i40e_get_module_info()
      ice: Add support for packet mirroring using hardware in switchdev mode
      i40e: Fix VF disable behavior to block all traffic

Andy Shevchenko (4):
      net: dsa: sja1105: Use units.h instead of the copy of a definition
      net/sched: cbs: Use units.h instead of the copy of a definition
      net: dl2k: Use proper conversion of dev_addr before IO to device
      ptp: ocp: Use DEFINE_RES_*() in place

Anjaneyulu (1):
      wifi: iwlwifi: fix out of bound copy_from_user

Ante Knezic (2):
      dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal
      net: dsa: microchip: add property to select internal RMII reference clock

Arkadiusz Kubalewski (1):
      ice: add CGU info to devlink info callback

Armen Ratner (1):
      net/mlx5: Implement management PF Ethernet profile

Arnd Bergmann (13):
      wifi: libertas: drop 16-bit PCMCIA support
      wifi: atmel: remove wext style at76c50x drivers
      wifi: remove orphaned cisco/aironet driver
      wifi: remove obsolete hostap driver
      wifi: remove orphaned zd1201 driver
      wifi: remove orphaned orinoco driver
      wifi: remove orphaned ray_cs driver
      wifi: remove orphaned wl3501 driver
      wifi: remove orphaned rndis_wlan driver
      wifi: libertas: stop selecting wext
      net: hns3: reduce stack usage in hclge_dbg_dump_tm_pri()
      wifi: mt76: mt7996: fix mt7996_mcu_all_sta_info_event struct packing
      wifi: rtw89: avoid stringop-overflow warning

Arseniy Krasnov (3):
      virtio/vsock: fix logic which reduces credit update messages
      virtio/vsock: send credit update during setting SO_RCVLOWAT
      vsock/test: two tests to check credit update logic

Artem Savkov (1):
      bpftool: Fix prog object type in manpage

Asmaa Mnebhi (2):
      mlxbf_gige: Fix intermittent no ip issue
      mlxbf_gige: Enable the GigE port in mlxbf_gige_open

Ayala Beker (1):
      wifi: mac80211: fix advertised TTLM scheduling

Baochen Qiang (1):
      wifi: ath11k: fix race due to setting ATH11K_FLAG_EXT_IRQ_ENABLED too early

Baruch Siach (2):
      net: stmmac: remove extra newline from descriptors display
      net: stmmac: reduce dma ring display code duplication

Benjamin Berg (10):
      wifi: cfg80211: generate an ML element for per-STA profiles
      wifi: cfg80211: consume both probe response and beacon IEs
      wifi: cfg80211: free beacon_ies when overridden from hidden BSS
      wifi: cfg80211: ensure cfg80211_bss_update frees IEs on error
      wifi: cfg80211: avoid double free if updating BSS fails
      kunit: add parameter generation macro using description from array
      kunit: add a convenience allocation wrapper for SKBs
      wifi: cfg80211: tests: add some scanning related tests
      wifi: cfg80211: correct comment about MLD ID
      wifi: cfg80211: parse all ML elements in an ML probe response

Benjamin Lin (3):
      wifi: mt76: mt7996: switch to mcu command for TX GI report
      wifi: mt76: mt7996: add DMA support for mt7992
      wifi: mt76: connac: add new definition of tx descriptor

Benjamin Poirier (1):
      selftests: forwarding: Avoid failures to source net/lib.sh

Bjorn Helgaas (1):
      wifi: rtlwifi: drop unused const_amdpci_aspm

Bo Jiao (1):
      wifi: mt76: mt7996: add wed rx support

Breno Leitao (1):
      Documentation: Document each netlink family

Brett Creeley (4):
      ionic: Use cached VF attributes
      ionic: Don't check null when calling vfree()
      ionic: Make the check for Tx HW timestamping more obvious
      ionic: Re-arrange ionic_intr_info struct for cache perf

Chia-Yuan Li (1):
      wifi: rtw89: 8922a: dump MAC registers when SER occurs

Chih-Kang Chang (3):
      wifi: rtw88: fix RX filter in FIF_ALLMULTI flag
      wifi: rtw89: refine remain on channel flow to improve P2P connection
      wifi: rtw89: fix misbehavior of TX beacon in concurrent mode

Ching-Te Ku (11):
      wifi: rtw89: coex: Fix wrong Wi-Fi role info and FDDT parameter members
      wifi: rtw89: coex: Record down Wi-Fi initial mode information
      wifi: rtw89: coex: Add Pre-AGC control to enhance Wi-Fi RX performance
      wifi: rtw89: coex: Update BTG control related logic
      wifi: rtw89: coex: Still show hardware grant signal info even Wi-Fi is PS
      wifi: rtw89: coex: Update coexistence policy for Wi-Fi LPS
      wifi: rtw89: coex: Set Bluetooth scan low-priority when Wi-Fi link/scan
      wifi: rtw89: coex: Add Bluetooth RSSI level information
      wifi: rtw89: coex: Update RF parameter control setting logic
      wifi: rtw89: coex: Translate antenna configuration from ID to string
      wifi: rtw89: coex: To improve Wi-Fi performance while BT is idle

Chris Morgan (1):
      wifi: rtw88: Use random MAC when efuse MAC invalid

Christian Marangi (37):
      net: phy: aquantia: move to separate directory
      net: phy: aquantia: move MMD_VEND define to header
      dt-bindings: Document Marvell Aquantia PHY
      net: phy: correctly check soft_reset ret ONLY if defined for PHY
      net: phy: aquantia: drop wrong endianness conversion for addr and CRC
      wifi: mt76: fix broken precal loading from MTD for mt7915
      wifi: mt76: fix typo in mt76_get_of_eeprom_from_nvmem function
      wifi: mt76: limit support of precal loading for mt7915 to MTD only
      wifi: mt76: make mt76_get_of_eeprom static again
      wifi: mt76: permit to use alternative cell name to eeprom NVMEM load
      wifi: mt76: permit to load precal from NVMEM cell for mt7915
      net: phy: at803x: fix passing the wrong reference for config_intr
      net: phy: at803x: move disable WOL to specific at8031 probe
      net: phy: at803x: raname hw_stats functions to qca83xx specific name
      net: phy: at803x: move qca83xx specific check in dedicated functions
      net: phy: at803x: move specific DT option for at8031 to specific probe
      net: phy: at803x: move specific at8031 probe mode check to dedicated probe
      net: phy: at803x: move specific at8031 config_init to dedicated function
      net: phy: at803x: move specific at8031 WOL bits to dedicated function
      net: phy: at803x: move specific at8031 config_intr to dedicated function
      net: phy: at803x: make at8031 related DT functions name more specific
      net: phy: at803x: move at8031 functions in dedicated section
      net: phy: at803x: move at8035 specific DT parse to dedicated probe
      net: phy: at803x: drop specific PHY ID check from cable test functions
      net: phy: at803x: move specific qca808x config_aneg to dedicated function
      net: phy: at803x: make read specific status function more generic
      net: phy: make addr type u8 in phy_package_shared struct
      net: phy: extend PHY package API to support multiple global address
      net: phy: restructure __phy_write/read_mmd to helper and phydev user
      net: phy: add support for PHY package MMD read/write
      net: phy: at803x: remove extra space after cast
      net: phy: at803x: replace msleep(1) with usleep_range
      net: phy: at803x: better align function varibles to open parenthesis
      net: phy: at803x: generalize cdt fault length function
      net: phy: at803x: refactor qca808x cable test get status function
      net: phy: at803x: add support for cdt cross short test for qca808x
      net: phy: at803x: make read_status more generic

Christophe JAILLET (3):
      nfp: flower: Remove usage of the deprecated ida_simple_xx() API
      ipvlan: Fix a typo in a comment
      ipvlan: Remove usage of the deprecated ida_simple_xx() API

Claudiu Beznea (1):
      dt-bindings: net: renesas,etheravb: Document RZ/G3S support

Coco Li (6):
      Documentations: Analyze heavily used Networking related structs
      cache: enforce cache groups
      netns-ipv4: reorganize netns_ipv4 fast path variables
      net-device: reorganize net_device fast path variables
      tcp: reorganize tcp_sock fast path variables
      Documentations: fix net_cachelines documentation build warning

Colin Ian King (4):
      net: mana: Fix spelling mistake "enforecement" -> "enforcement"
      selftests/bpf: Fix spelling mistake "get_signaure_size" -> "get_signature_size"
      samples/bpf: Use %lu format specifier for unsigned long values
      selftests/net: Fix various spelling mistakes in TCP-AO tests

Damodharam Ammepalli (1):
      bnxt_en: add rx_filter_miss extended stats

Dan Carpenter (3):
      wifi: plfxlc: check for allocation failure in plfxlc_usb_wreq_async()
      ice: fix error code in ice_eswitch_attach()
      octeon_ep: Fix error code in probe()

Daniel Borkmann (1):
      bpf: Re-support uid and gid when mounting bpffs

Daniel Danzberger (1):
      net: dsa: microchip: move ksz_chip_id enum to platform include

Daniel Xu (9):
      libbpf: Add BPF_CORE_WRITE_BITFIELD() macro
      bpf: selftests: test_loader: Support __btf_path() annotation
      bpf: selftests: Add verifier tests for CO-RE bitfield writes
      bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
      bpf: selftests: test_tunnel: Setup fresh topology for each subtest
      bpf: selftests: test_tunnel: Use vmlinux.h declarations
      bpf: selftests: Move xfrm tunnel test to test_progs
      bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
      bpf: xdp: Register generic_kfunc_set with XDP programs

Dave Marchevsky (7):
      bpf: Add KF_RCU flag to bpf_refcount_acquire_impl
      selftests/bpf: Add test passing MAYBE_NULL reg to bpf_refcount_acquire
      bpf: Use bpf_mem_free_rcu when bpf_obj_dropping non-refcounted nodes
      bpf: Move GRAPH_{ROOT,NODE}_MASK macros into btf_field_type enum
      bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owning ref
      selftests/bpf: Test bpf_refcount_acquire of node obtained via direct ld
      selftests/bpf: Test bpf_kptr_xchg stashing of bpf_rb_root

David Ahern (1):
      net/ipv6: Remove gc_link warn on in fib6_info_release

David Arinzon (11):
      net: ena: Move XDP code to its new files
      net: ena: Pass ena_adapter instead of net_device to ena_xmit_common()
      net: ena: Put orthogonal fields in ena_tx_buffer in a union
      net: ena: Introduce total_tx_size field in ena_tx_buffer struct
      net: ena: Use tx_ring instead of xdp_ring for XDP channel TX
      net: ena: Don't check if XDP program is loaded in ena_xdp_execute()
      net: ena: Refactor napi functions
      net: ena: Add more debug prints to XDP related function
      net: ena: Always register RX queue info
      net: ena: Make queue stats code cleaner by removing the if block
      net: ena: Take xdp packets stats into account in ena_get_stats64()

David Howells (1):
      rxrpc: Fix skbuff cleanup of call's recvmsg_queue and rx_oos_queue

David Laight (1):
      Use READ/WRITE_ONCE() for IP local_port_range.

David Lin (3):
      wifi: mwifiex: add extra delay for firmware ready
      wifi: mwifiex: configure BSSID consistently when starting AP
      wifi: mwifiex: fix uninitialized firmware_stat

David S. Miller (66):
      Merge branch 'bnxt_en-tx-improvements'
      Merge branch 'octeon_ep-transmit-cleanups-and-optimizations'
      Merge branch 'tc-testing-tdc-updates'
      Merge branch 'tcp-change-reaction-to-ICMP'
      Merge branch 'phylink-sfp-linkmode'
      Merge branch 'net-make-timestamping-selectable'
      Merge branch 'ncsi-mac-address-command'
      Merge branch 'mlxsw-new-reset-flow'
      Merge tag 'batadv-next-pullrequest-20231115' of git://git.open-mesh.org/linux-merge
      Merge tag 'mlx5-updates-2023-11-13' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch 'am65-cpsw-ethtool-mac-stats'
      Merge branch 'smc-sysctl'
      Merge branch 'octeon_ep-max-rx'
      Merge branch 'net-ipa-v5.5'
      Merge branch 'net-cacheline-optimizations'
      Merge branch 'octeontx2-multicast-mirror-offload'
      Merge branch 'dsa-microchip-rmii-reference'
      Merge branch 'ethtool_puts'
      Merge branch 'net-selftests-unique-namespace'
      Merge branch 'rswitch-jumbo-frames'
      Merge branch 'ipv6-data-races'
      Merge branch 'net-at803x-cleanups'
      Merge branch 'ionic-pci-errors'
      Merge branch 'virtio-net-dynamic-coalescing-moderation'
      Merge branch 'net-phy-rust'
      Merge tag 'mlx5-updates-2023-12-13' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch 'vsock-credit-update'
      Merge branch 'net-at803x-cleanups'
      Merge branch 'mlxsw-CFF-flood-mode'
      Merge branch 'net-optmem_max-changes'
      Merge branch 'mv88e6xxx-counters'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'netlink-specs-legacy'
      Merge branch 'tcp-ao-selftests'
      Merge branch 'skb-coalescing-page_pool'
      Merge branch 'phy-ackage-addr-mmd-apis'
      Merge branch 'rtnl-rcu'
      Merge branch 'bridge-mdb-bulk-delete'
      Merge branch 'net-sched-tc-drop-reason'
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'tcp-refactor-bhash2'
      Merge branch 'net-selftests-unique-namespace-last-part'
      Merge branch 'am65-cpsw-preemption-coalescing'
      Merge branch 'dpaa2-switch-small-improvements'
      Merge branch 'net-smcv2.1-ISM-device-support'
      Merge branch 'net-sched-tc-block-ports-tracking'
      Merge branch 'mptcp-cleanups-ephemeral-port-sockopts'
      Merge branch 'net-tja11xx-macsec-support'
      Merge tag 'mlx5-updates-2023-12-20' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge tag 'nf-next-23-12-22' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'phy-listing-link_topology-tracking'
      Merge branch 'net-tc-ipt-retire'
      Merge tag 'wireless-next-2023-12-22' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'selftests-tcp-ao'
      Merge branch 'mptcp-mib-counters'
      Merge tag 'for-net-next-2023-12-22' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Merge branch 'bnxt_en-ntuple-fuilter-support'
      Merge branch 'octeon_ep_vf-driver'
      Merge branch 'remove-retired-tc-uapi'
      Merge branch 'renesas-rzg3s-add-support-for-ethernet'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/nex t-queue
      Merge branch 'net-wangxun-more-ethtool'
      Merge branch 'user_mii_bus-cleanup-part-one'
      Merge branch 'at803x-more-generalization'
      Merge branch 'stmmac-per-dma-channel-interrupt'

David Vernet (3):
      bpf: Load vmlinux btf for any struct_ops map
      bpf: Add bpf_cpumask_weight() kfunc
      selftests/bpf: Add test for bpf_cpumask_weight() kfunc

Davide Caratti (1):
      mptcp: don't overwrite sock_ops in mptcp_is_tcpsk()

Denis Kirjanov (2):
      net: remove SOCK_DEBUG leftovers
      net: remove SOCK_DEBUG macro

Dmitrii Dolgov (3):
      bpf: Relax tracing prog recursive attach rules
      selftests/bpf: Add test for recursive attachment of tracing progs
      selftests/bpf: Test re-attachment fix for bpf_tracing_prog_attach

Dmitry Antipov (19):
      wifi: rtlwifi: cleanup struct rtl_hal
      wifi: rtlwifi: cleanup struct rtl_phy
      wifi: rtlwifi: rtl92ee_dm_dynamic_primary_cca_check(): fix typo in function name
      wifi: rtw89: fix timeout calculation in rtw89_roc_end()
      wifi: wilc1000: simplify remain on channel support
      wifi: wilc1000: always release SDIO host in wilc_sdio_cmd53()
      wifi: wilc1000: cleanup struct wilc_conn_info
      wifi: wilc1000: simplify wilc_scan()
      wifi: rtw88: simplify __rtw_tx_work()
      wifi: rtlwifi: simplify rtl_action_proc() and rtl_tx_agg_start()
      wifi: ath10k: simplify __ath10k_htt_tx_txq_recalc()
      wifi: mac80211: cleanup airtime arithmetic with ieee80211_sta_keep_active()
      wifi: mac80211: drop spurious WARN_ON() in ieee80211_ibss_csa_beacon()
      wifi: wfx: fix possible NULL pointer dereference in wfx_set_mfp_ap()
      net: asix: fix fortify warning
      wifi: rt2x00: remove useless code in rt2x00queue_create_tx_descriptor()
      wifi: cfg80211: introduce cfg80211_ssid_eq()
      wifi: mwifiex: use cfg80211_ssid_eq() instead of mwifiex_ssid_cmp()
      wifi: rtw88: use cfg80211_ssid_eq() instead of rtw_ssid_equal()

Dmitry Safonov (15):
      selftests/net: Add TCP-AO library
      selftests/net: Verify that TCP-AO complies with ignoring ICMPs
      selftests/net: Add TCP-AO ICMPs accept test
      selftests/net: Add a test for TCP-AO keys matching
      selftests/net: Add test for TCP-AO add setsockopt() command
      selftests/net: Add TCP-AO + TCP-MD5 + no sign listen socket tests
      selftests/net: Add test/benchmark for removing MKTs
      selftests/net: Add TCP_REPAIR TCP-AO tests
      selftests/net: Add SEQ number extension test
      selftests/net: Add TCP-AO RST test
      selftests/net: Add TCP-AO selfconnect/simultaneous connect test
      selftests/net: Add TCP-AO key-management test
      selftest/tcp-ao: Rectify out-of-tree build
      selftest/tcp-ao: Set routes in a proper VRF table id
      selftest/tcp-ao: Work on namespace-ified sysctl_optmem_max

Donald Hunter (14):
      doc/netlink: Add bitfield32, s8, s16 to the netlink-raw schema
      tools/net/ynl: Use consistent array index expression formatting
      doc/netlink: Add sub-message support to netlink-raw
      doc/netlink: Document the sub-message format for netlink-raw
      tools/net/ynl: Add 'sub-message' attribute decoding to ynl
      tools/net/ynl: Add binary and pad support to structs for tc
      doc/netlink/specs: Add sub-message type to rt_link family
      doc/netlink/specs: use pad in structs in rt_link
      doc/netlink/specs: Add a spec for tc
      doc/netlink: Regenerate netlink .rst files if ynl-gen-rst changes
      tools/net/ynl-gen-rst: Add sub-messages to generated docs
      tools/net/ynl-gen-rst: Sort the index of generated netlink specs
      tools/net/ynl-gen-rst: Remove bold from attribute-set headings
      tools/net/ynl-gen-rst: Remove extra indentation from generated docs

Eduard Zingerman (1):
      libbpf: Start v1.4 development cycle

Edward Adam Davis (1):
      wifi: cfg80211: fix RCU dereference in __cfg80211_bss_update

Emmanuel Grumbach (3):
      wifi: iwlwifi: mvm: add a debugfs hook to clear the monitor data
      wifi: iwlwifi: mvm: do not send STA_DISABLE_TX_CMD for newer firmware
      wifi: iwlwifi: mvm: use the new command to clear the internal buffer

Eric Dumazet (21):
      tcp: use tp->total_rto to track number of linear timeouts in SYN_SENT state
      tcp: no longer abort SYN_SENT when receiving some ICMP
      gve: add gve_features_check()
      net: page_pool: fix general protection fault in page_pool_unlist
      tcp: tcp_gro_dev_warn() cleanup
      ipv6: add debug checks in fib6_info_release()
      ipv6: do not check fib6_has_expires() in fib6_info_release()
      ipv6: annotate data-races around np->mcast_oif
      ipv6: annotate data-races around np->ucast_oif
      docs: networking: timestamping: mention MSG_EOR flag
      sctp: support MSG_ERRQUEUE flag in recvmsg()
      net: increase optmem_max default value
      net: Namespace-ify sysctl_optmem_max
      selftests/net: optmem_max became per netns
      inet: returns a bool from inet_sk_get_local_port_range()
      tcp/dccp: change source port selection at connect() time
      net-device: move gso_partial_features to net_device_read_tx
      net-device: move xdp_prog to net_device_read_rx
      sctp: fix busy polling
      geneve: use DEV_STATS_INC()
      ip6_tunnel: fix NEXTHDR_FRAGMENT handling in ip6_tnl_parse_tlv_enc_lim()

Evan Quan (2):
      wifi: cfg80211: expose nl80211_chan_width_to_mhz for wide sharing
      wifi: mac80211: Add support for WBRF features

FUJITA Tomonori (4):
      rust: core abstractions for network PHY drivers
      rust: net::phy add module_phy_driver macro
      MAINTAINERS: add Rust PHY abstractions for ETHERNET PHY LIBRARY
      net: phy: add Rust Asix PHY driver

Fei Qin (1):
      nfp: support UDP segmentation offload

Felix Huettner (1):
      netfilter: ctnetlink: support filtering by zone

Florian Fainelli (1):
      net: dsa: tag_rtl4_a: Use existing ETH_P_REALTEK constant

Florian Lehner (1):
      bpf, lpm: Fix check prefixlen before walking trie

Florian Westphal (3):
      netfilter: nft_set_pipapo: prefer gfp_kernel allocation
      netfilter: flowtable: reorder nf_flowtable struct members
      netfilter: nf_tables: mark newset as dead on transaction abort

Francesco Dolcini (3):
      Bluetooth: btnxpuart: fix recv_buf() return value
      Bluetooth: btmtkuart: fix recv_buf() return value
      Bluetooth: btnxpuart: remove useless assignment

Frédéric Danis (1):
      Bluetooth: L2CAP: Fix possible multiple reject send

Furong Xu (1):
      net: stmmac: mmc: Support more counters for XGMAC Core

Gal Pressman (1):
      net/mlx5e: Access array with enum values instead of magic numbers

Gan, Yi Fang (1):
      net: stmmac: Add support for HW-accelerated VLAN stripping

Geetha sowjanya (1):
      octeontx2-pf: TC flower offload support for ICMP type and code

Geliang Tang (19):
      mptcp: add mptcpi_subflows_total counter
      selftests: mptcp: add evts_get_info helper
      selftests: mptcp: add chk_subflows_total helper
      selftests: mptcp: update userspace pm test helpers
      selftests: mptcp: userspace pm create id 0 subflow
      mptcp: userspace pm rename remove_err to out
      selftests: mptcp: userspace pm remove initial subflow
      selftests: mptcp: userspace pm send RM_ADDR for ID 0
      selftests: mptcp: add mptcp_lib_kill_wait
      selftests: mptcp: add mptcp_lib_is_v6
      selftests: mptcp: add mptcp_lib_get_counter
      selftests: mptcp: add missing oflag=append
      selftests: mptcp: add mptcp_lib_make_file
      selftests: mptcp: add mptcp_lib_check_transfer
      selftests: mptcp: add mptcp_lib_wait_local_port_listen
      mptcp: add CurrEstab MIB counter support
      mptcp: use mptcp_set_state
      selftests: mptcp: join: check CURRESTAB counters
      selftests: mptcp: diag: check CURRESTAB counters

Geoff Levand (1):
      net/ps3_gelic_net: Add gelic_descr structures

Gerhard Engleder (1):
      net: ethtool: Fix symmetric-xor RSS RX flow hash check

Greg Kroah-Hartman (1):
      iucv: make iucv_bus const

Gregory Greenman (1):
      MAINTAINERS: update iwlwifi maintainers

Grygorii Strashko (2):
      net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode
      net: ethernet: ti: am65-cpsw: add sw tx/rx irq coalescing based on hrtimers

Guangguan Wang (2):
      net/smc: add sysctl for max links per lgr for SMC-R v2.1
      net/smc: add sysctl for max conns per lgr for SMC-R v2.1

Gui-Dong Han (1):
      Bluetooth: Fix atomicity violation in {min,max}_key_size_set

Guillaume Nault (1):
      tcp: Dump bound-only sockets in inet_diag.

Gustavo A. R. Silva (1):
      wifi: mt76: mt7996: Use DECLARE_FLEX_ARRAY() and fix -Warray-bounds warnings

Hancheng Yang (1):
      wifi: ath9k: reset survey of current channel after a scan started

Hangbin Liu (54):
      docs: bridge: update doc format to rst
      net: bridge: add document for IFLA_BR enum
      net: bridge: add document for IFLA_BRPORT enum
      docs: bridge: Add kAPI/uAPI fields
      docs: bridge: add STP doc
      docs: bridge: add VLAN doc
      docs: bridge: add multicast doc
      docs: bridge: add switchdev doc
      docs: bridge: add netfilter doc
      docs: bridge: add other features
      selftests/net: add lib.sh
      selftests/net: convert arp_ndisc_evict_nocarrier.sh to run it in unique namespace
      selftests/net: specify the interface when do arping
      selftests/net: convert arp_ndisc_untracked_subnets.sh to run it in unique namespace
      selftests/net: convert cmsg tests to make them run in unique namespace
      selftests/net: convert drop_monitor_tests.sh to run it in unique namespace
      selftests/net: convert traceroute.sh to run it in unique namespace
      selftests/net: convert icmp_redirect.sh to run it in unique namespace
      sleftests/net: convert icmp.sh to run it in unique namespace
      selftests/net: convert ioam6.sh to run it in unique namespace
      selftests/net: convert l2tp.sh to run it in unique namespace
      selftests/net: convert ndisc_unsolicited_na_test.sh to run it in unique namespace
      selftests/net: convert sctp_vrf.sh to run it in unique namespace
      selftests/net: convert unicast_extensions.sh to run it in unique namespace
      selftests/net: convert test_bridge_backup_port.sh to run it in unique namespace
      selftests/net: convert test_bridge_neigh_suppress.sh to run it in unique namespace
      selftests/net: convert test_vxlan_mdb.sh to run it in unique namespace
      selftests/net: convert test_vxlan_nolocalbypass.sh to run it in unique namespace
      selftests/net: convert test_vxlan_under_vrf.sh to run it in unique namespace
      selftests/net: convert test_vxlan_vnifiltering.sh to run it in unique namespace
      selftests/net: convert vrf_route_leaking.sh to run it in unique namespace
      selftests/net: convert vrf_strict_mode_test.sh to run it in unique namespace
      selftests/net: convert vrf-xfrm-tests.sh to run it in unique namespace
      selftests/net: add variable NS_LIST for lib.sh
      selftests/net: convert srv6_end_dt46_l3vpn_test.sh to run it in unique namespace
      selftests/net: convert srv6_end_dt4_l3vpn_test.sh to run it in unique namespace
      selftests/net: convert srv6_end_dt6_l3vpn_test.sh to run it in unique namespace
      selftests/net: convert fcnal-test.sh to run it in unique namespace
      selftests/net: fix grep checking for fib_nexthop_multiprefix
      selftests/net: convert fib_nexthop_multiprefix to run it in unique namespace
      selftests/net: convert fib_nexthop_nongw.sh to run it in unique namespace
      selftests/net: convert fib_nexthops.sh to run it in unique namespace
      selftests/net: convert fib-onlink-tests.sh to run it in unique namespace
      selftests/net: convert fib_rule_tests.sh to run it in unique namespace
      selftests/net: convert fib_tests.sh to run it in unique namespace
      selftests/net: convert fdb_flush.sh to run it in unique namespace
      selftests/net: convert gre_gso.sh to run it in unique namespace
      selftests/net: convert netns-name.sh to run it in unique namespace
      selftests/net: convert rtnetlink.sh to run it in unique namespace
      selftests/net: convert stress_reuseport_listen.sh to run it in unique namespace
      selftests/net: convert xfrm_policy.sh to run it in unique namespace
      selftests/net: use unique netns name for setup_loopback.sh setup_veth.sh
      selftests/net: convert pmtu.sh to run it in unique namespace
      kselftest/runner.sh: add netns support

Heiko Stuebner (2):
      net: phy: micrel: use devm_clk_get_optional_enabled for the rmii-ref clock
      net: phy: micrel: allow usage of generic ethernet-phy clock

Heiner Kallweit (8):
      r8169: improve RTL8411b phy-down fixup
      r8169: remove not needed check in rtl_fw_write_firmware
      r8169: remove multicast filter limit
      r8169: improve handling task scheduling
      r8169: add support for LED's on RTL8168/RTL8101
      r8169: fix building with CONFIG_LEDS_CLASS=m
      lan743x: remove redundant statement in lan743x_ethtool_get_eee
      lan78xx: remove redundant statement in lan78xx_get_eee

Heng Qi (4):
      virtio-net: returns whether napi is complete
      virtio-net: separate rx/tx coalescing moderation cmds
      virtio-net: extract virtqueue coalescig cmd for reuse
      virtio-net: support rx netdim

Herve Codina (5):
      net: wan: Add framer framework support
      dt-bindings: net: Add the Lantiq PEF2256 E1/T1/J1 framer
      net: wan: framer: Add support for the Lantiq PEF2256 framer
      pinctrl: Add support for the Lantic PEF2256 pinmux
      MAINTAINERS: Add the Lantiq PEF2256 driver entry

Hongguang Gao (1):
      bnxt_en: Consolidate DB offset calculation

Hou Tao (27):
      selftests/bpf: Use value with enough-size when updating per-cpu map
      selftests/bpf: Export map_update_retriable()
      selftsets/bpf: Retry map update for non-preallocated per-cpu map
      bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers
      bpf: Add map and need_defer parameters to .map_fd_put_ptr()
      bpf: Set need_defer as false when clearing fd array during map free
      bpf: Defer the free of inner map when necessary
      bpf: Optimize the free of inner map
      selftests/bpf: Add test cases for inner map
      selftests/bpf: Test outer map update operations in syscall program
      bpf: Remove unnecessary wait from bpf_map_copy_value()
      bpf: Call maybe_wait_bpf_programs() only once for generic_map_update_batch()
      bpf: Add missed maybe_wait_bpf_programs() for htab of maps
      bpf: Only call maybe_wait_bpf_programs() when map operation succeeds
      bpf: Set uattr->batch.count as zero before batched update or deletion
      bpf: Update the comments in maybe_wait_bpf_programs()
      bpf: Reduce the scope of rcu_read_lock when updating fd map
      bpf: Use GFP_KERNEL in bpf_event_entry_gen()
      bpf: Limit the number of uprobes when attaching program to multiple uprobes
      bpf: Limit the number of kprobes when attaching program to multiple kprobes
      selftests/bpf: Add test for abnormal cnt during multi-uprobe attachment
      selftests/bpf: Don't use libbpf_get_error() in kprobe_multi_test
      selftests/bpf: Add test for abnormal cnt during multi-kprobe attachment
      selftests/bpf: Test the release of map btf
      selftests/bpf: Close cgrp fd before calling cleanup_cgroup_environment()
      bpf: Use c->unit_size to select target cache during free
      selftests/bpf: Remove tests for zeroed-array kptr

Howard Hsu (4):
      wifi: mt76: mt7996: add TX statistics for EHT mode in debugfs
      wifi: mt76: connac: add thermal protection support for mt7996
      wifi: mt76: mt7996: add thermal sensor device support
      wifi: mt76: connac: set fixed_bw bit in TX descriptor for fixed rate frames

Ido Schimmel (22):
      devlink: Move private netlink flags to C file
      devlink: Acquire device lock during netns dismantle
      devlink: Enable the use of private flags in post_doit operations
      devlink: Allow taking device lock in pre_doit operations
      devlink: Acquire device lock during reload command
      devlink: Add device lock assert in reload operation
      PCI: Add no PM reset quirk for NVIDIA Spectrum devices
      PCI: Add debug print for device ready delay
      mlxsw: pci: Add support for new reset flow
      mlxsw: pci: Implement PCI reset handlers
      selftests: mlxsw: Add PCI reset test
      mlxsw: pci: Fix missing error checking
      bridge: add MDB state mask uAPI attribute
      rtnetlink: bridge: Use a different policy for MDB bulk delete
      net: Add MDB bulk deletion device operation
      rtnetlink: bridge: Invoke MDB bulk deletion when needed
      bridge: mdb: Add MDB bulk deletion support
      vxlan: mdb: Add MDB bulk deletion support
      rtnetlink: bridge: Enable MDB bulk deletion
      selftests: bridge_mdb: Add MDB bulk deletion test
      selftests: vxlan_mdb: Add MDB bulk deletion test
      genetlink: Use internal flags for multicast groups

Igor Russkikh (1):
      net: atlantic: eliminate double free in error handling logic

Ilan Peer (7):
      wifi: cfg80211: Extend support for scanning while MLO connected
      wifi: mac80211: Extend support for scanning while MLO connected
      wifi: iwlwifi: mvm: Use the link ID provided in scan request
      wifi: iwlwifi: mvm: Correctly report TSF data in scan complete
      wifi: cfg80211: Add support for setting TID to link mapping
      wifi: iwlwifi: mvm: Do not warn if valid link pair was not found
      wifi: cfg80211: Update the default DSCP-to-UP mapping

Ilpo Järvinen (15):
      bcma: Use PCI_HEADER_TYPE_MASK instead of literal
      wifi: rtlwifi: Remove bogus and dangerous ASPM disable/enable code
      wifi: rtlwifi: Convert LNKCTL change to PCIe cap RMW accessors
      wifi: rtlwifi: Convert to use PCIe capability accessors
      wifi: rtlwifi: rtl8821ae: Remove unnecessary PME_Status bit set
      wifi: rtlwifi: rtl8821ae: Reverse PM Capability exists check
      wifi: rtlwifi: rtl8821ae: Use pci_find_capability()
      wifi: rtlwifi: rtl8821ae: Add pdev into _rtl8821ae_clear_pci_pme_status()
      wifi: rtlwifi: rtl8821ae: Access full PMCS reg and use pci_regs.h
      wifi: rtlwifi: Remove unused PCI related defines and struct
      wifi: rtlwifi: Remove bridge vendor/device ids
      igb: Use FIELD_GET() to extract Link Width
      e1000e: Use PCI_EXP_LNKSTA_NLW & FIELD_GET() instead of custom defines/code
      e1000e: Use pcie_capability_read_word() for reading LNKSTA
      net: mdio: mux-bcm-iproc: Use alignment helpers and SZ_4K

Ilya Leoshkevich (3):
      s390/bpf: Fix gotol with large offsets
      selftests/bpf: Double the size of test_loader log
      selftests/bpf: Test gotol with large offsets

Ioana Ciornei (8):
      dpaa2-switch: set interface MAC address only on endpoint change
      dpaa2-switch: declare the netdev as IFF_LIVE_ADDR_CHANGE capable
      dpaa2-switch: print an error when the vlan is already configured
      dpaa2-switch: add ENDPOINT_CHANGED to the irq_mask
      dpaa2-switch: do not clear any interrupts automatically
      dpaa2-switch: reorganize the [pre]changeupper events
      dpaa2-switch: move a check to the prechangeupper stage
      dpaa2-switch: cleanup the egress flood of an unused FDB

Iulia Tanasescu (3):
      Bluetooth: ISO: Allow binding a PA sync socket
      Bluetooth: ISO: Reassociate a socket with an active BIS
      Bluetooth: ISO: Avoid creating child socket if PA sync is terminating

Ivan Vecera (16):
      i40e: Remove unused flags
      i40e: Remove _t suffix from enum type names
      i40e: Use DECLARE_BITMAP for flags and hw_features fields in i40e_pf
      i40e: Use DECLARE_BITMAP for flags field in i40e_hw
      i40e: Consolidate hardware capabilities
      i40e: Initialize hardware capabilities at single place
      i40e: Move i40e_is_aq_api_ver_ge helper
      i40e: Add other helpers to check version of running firmware and AQ API
      i40e: Use helpers to check running FW and AQ API versions
      i40e: Remove VF MAC types
      i40e: Move inline helpers to i40e_prototype.h
      i40e: Delete unused i40e_mac_info fields
      i40e: Delete unused and useless i40e_pf fields
      i40e: Remove AQ register definitions for VF types
      i40e: Remove queue tracking fields from i40e_adminq_ring
      iavf: Remove queue tracking fields from iavf_adminq_ring

Jacob Keller (2):
      ice: periodically kick Tx timestamp interrupt
      ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()

Jagan Teki (1):
      Bluetooth: Add device 13d3:3572 IMC Networks Bluetooth Radio

Jakub Kicinski (119):
      Merge branch 'intel-wired-lan-driver-updates-2023-11-13-i40e'
      net: don't dump stack on queue timeout
      net: partial revert of the "Make timestamping selectable: series
      Merge branch 'net-sched-cls_u32-use-proper-refcounts'
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'net-axienet-introduce-dmaengine'
      Merge branch 'nfp-add-flow-steering-support'
      Merge branch 'selftests-tc-testing-more-updates-to-tdc'
      net: do not send a MOVE event when netdev changes netns
      Merge branch 'mlxsw-preparations-for-support-of-cff-flood-mode'
      net: page_pool: split the page_pool_params into fast and slow
      net: page_pool: avoid touching slow on the fastpath
      Merge branch 'net-page_pool-add-netlink-based-introspection-part1'
      Merge branch 'bnxt_en-prepare-to-support-new-p7-chips'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      tools: ynl-gen: always append ULL/LL to range types
      tools: ynl-get: use family c-name
      tools: ynl-gen: use enum name from the spec
      Merge branch 'firmware_loader'
      Merge branch 'net-phylink-improve-phy-validation'
      Merge branch 'selftests-tc-testing-updates-and-cleanups-for-tdc'
      Merge tag 'wireless-next-2023-11-27' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      net: page_pool: factor out uninit
      net: page_pool: id the page pools
      net: page_pool: record pools per netdev
      net: page_pool: stash the NAPI ID for easier access
      eth: link netdev to page_pools in drivers
      net: page_pool: add nlspec for basic access to page pools
      net: page_pool: implement GET in the netlink API
      net: page_pool: add netlink notifications for state changes
      net: page_pool: report amount of memory held by page pools
      net: page_pool: report when page pool was destroyed
      net: page_pool: expose page pool stats via netlink
      net: page_pool: mute the periodic warning for visible page pools
      tools: ynl: add sample for getting page-pool information
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'gve-add-support-for-non-4k-page-sizes'
      Merge branch 'fine-tune-flow-control-and-speed-configurations-in-microchip-ksz8xxx-dsa-driver'
      tools: ynl: fix build of the page-pool sample
      tools: ynl: make sure we use local headers for page-pool
      tools: ynl: order building samples after generated code
      tools: ynl: don't skip regeneration from make targets
      Merge branch 'tools-ynl-fixes-for-the-page-pool-sample-and-the-generation-process'
      Merge branch 'create-a-binding-for-the-marvell-mv88e6xxx-dsa-switches'
      Merge branch 'mlxsw-support-cff-flood-mode'
      Merge branch 'mptcp-more-selftest-coverage-and-code-cleanup-for-net-next'
      Merge branch 'clean-up-and-refactor-cookie_v46_check'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'support-octeon-cn98-devices'
      docs: netlink: link to family documentations from spec info
      Merge branch 'selftests-tc-testing-more-tdc-updates'
      Merge branch 'net-phy-micrel-additional-clock-handling'
      Merge branch 'bnxt_en-support-new-5760x-p7-devices'
      eth: bnxt: link NAPI instances to queues and IRQs
      Merge branch 'introduce-queue-and-napi-support-in-netdev-genl-was-introduce-napi-queues-support'
      Merge branch 'net-stmmac-est-implementation'
      Merge branch 'sfc-implement-ndo_hwtstamp_-get-set'
      tools: ynl: remove generated user space code from git
      Merge branch 'net-convert-to-platform-remove-callback-returning-void'
      tools: pynl: make flags argument optional for do()
      tools: ynl: use strerror() if no extack of note provided
      tools: ynl: move private definitions to a separate header
      Merge branch 'net-mvmdio-performance-related-improvements'
      Merge branch 'reorganize-remaining-patch-of-networking-struct-cachelines'
      Merge branch 'ionic-more-driver-fixes'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'nfp-add-ext_ack-messages-to-supported-callbacks'
      Merge branch 'net-sched-conditional-notification-of-events-for-cls-and-act'
      Merge tag 'pef2256-framer' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
      Merge branch 'bnxt_en-update-for-net-next'
      Merge branch 'net-sched-optimizations-around-action-binding-and-init'
      Merge branch 'add-support-for-dp83tg720s-phy'
      Merge branch 'idpf-add-get-set-for-ethtool-s-header-split-ringparam'
      net: page_pool: factor out releasing DMA from releasing the page
      Merge branch 'support-symmetric-xor-rss-hash'
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      tools: ynl-gen: add missing request free helpers for dumps
      tools: ynl-gen: use enum user type for members and args
      tools: ynl-gen: support fixed headers in genetlink
      tools: ynl-gen: fill in implementations for TypeUnused
      tools: ynl-gen: record information about recursive nests
      tools: ynl-gen: re-sort ignoring recursive nests
      tools: ynl-gen: store recursive nests by a pointer
      tools: ynl-gen: print prototypes for recursive stuff
      Merge branch 'tools-ynl-gen-fill-in-the-gaps-in-support-of-legacy-families'
      Merge branch 'net-mdio-mdio-bcm-unimac-optimizations-and-clean-up'
      Merge branch 'convert-net-selftests-to-run-in-unique-namespace-part-3'
      Merge branch 'mdio-mux-cleanup'
      netlink: specs: ovs: remove fixed header fields from attrs
      netlink: specs: ovs: correct enum names in specs
      netlink: specs: mptcp: rename the MPTCP path management spec
      Merge branch 'tcp-dccp-refine-source-port-selection'
      Merge branch 'tools-net-ynl-add-sub-message-support-to-ynl'
      Merge tag 'wireless-next-2023-12-18' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      bpf: Use nla_ok() instead of checking nla_len directly
      Revert "net: mdio: get/put device node during (un)registration"
      Merge branch 'bug-fixes-for-rss-symmetric-xor'
      Merge branch 'ena-driver-xdp-changes'
      Merge branch '10GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Revert "octeon_ep_vf: add octeon_ep_vf driver"
      Merge tag 'ieee802154-for-net-next-2023-12-20' of gitolite.kernel.org:pub/scm/linux/kernel/git/wpan/wpan-next
      Revert "Introduce PHY listing and link_topology tracking"
      Merge tag 'wireless-next-2024-01-03' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'dpll-expose-fractional-frequency-offset-value-to-user'
      net: fill in MODULE_DESCRIPTION()s for ATM
      net: fill in MODULE_DESCRIPTION()s for DSA tags
      net: fill in MODULE_DESCRIPTION() for AF_PACKET
      net: fill in MODULE_DESCRIPTION()s for CAIF
      Merge branch 'net-gro-reduce-extension-header-parsing-overhead'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Revert "net: stmmac: Enable Per DMA Channel interrupt"
      Revert "mlx5 updates 2023-12-20"
      Merge branch 'bnxt_en-ntuple-filter-fixes'

Jamal Hadi Salim (10):
      rtnl: add helper to check if rtnl group has listeners
      net: rtnl: introduce rcu_replace_pointer_rtnl
      net/sched: Retire ipt action
      net/sched: Remove CONFIG_NET_ACT_IPT from default configs
      net/sched: Remove uapi support for rsvp classifier
      net/sched: Remove uapi support for tcindex classifier
      net/sched: Remove uapi support for dsmark qdisc
      net/sched: Remove uapi support for ATM qdisc
      net/sched: Remove uapi support for CBQ qdisc
      net/sched: Remove ipt action tests

James Prestwood (3):
      wifi: ath11k: use select for CRYPTO_MICHAEL_MIC
      wifi: ath12k: use select for CRYPTO_MICHAEL_MIC
      wifi: ath10k: add support to allow broadcast action frame RX

Jan Glaza (1):
      ice: ice_base.c: Add const modifier to params and vars

Jan Sokolowski (1):
      ice: remove rx_len_errors statistic

Jason Xing (1):
      i40e: remove fake support of rx-frames-irq

Jedrzej Jagielski (2):
      ixgbe: Refactor overtemp event handling
      ixgbe: Refactor returning internal error codes

Jeff Guo (1):
      ice: enable symmetric-xor RSS for Toeplitz hash function

Jeff Johnson (14):
      wifi: ath10k: Remove unused struct ath10k_htc_frame
      wifi: ath11k: Remove struct ath11k::ops
      wifi: ath12k: Remove struct ath12k::ops
      wifi: ath11k: Remove obsolete struct wmi_peer_flags_map *peer_flags
      wifi: ath12k: Remove obsolete struct wmi_peer_flags_map *peer_flags
      wifi: ath11k: Consolidate WMI peer flags
      wifi: ath12k: Consolidate WMI peer flags
      wifi: ath12k: Update Qualcomm Innovation Center, Inc. copyrights
      wifi: ath11k: Update Qualcomm Innovation Center, Inc. copyrights
      wifi: ath10k: Update Qualcomm Innovation Center, Inc. copyrights
      wifi: ath10k: remove ath10k_htc_record::pauload[]
      wifi: ath10k: Use DECLARE_FLEX_ARRAY() for ath10k_htc_record
      wifi: ath11k: remove ath11k_htc_record::pauload[]
      wifi: ath11k: Fix ath11k_htc_record flexible record

Jeroen van Ingen Schenau (1):
      selftests/bpf: Fix erroneous bitmask operation

Jesper Dangaard Brouer (1):
      mm/page_pool: catch page_pool memory leaks

Jesse Brandeburg (15):
      e1000e: make lost bits explicit
      intel: add bit macro includes where needed
      intel: legacy: field prep conversion
      i40e: field prep conversion
      iavf: field prep conversion
      ice: field prep conversion
      ice: fix pre-shifted bit usage
      igc: field prep conversion
      intel: legacy: field get conversion
      igc: field get conversion
      i40e: field get conversion
      iavf: field get conversion
      ice: field get conversion
      ice: cleanup inconsistent code
      idpf: refactor some missing field get/prep conversions

Jiapeng Chong (3):
      wifi: iwlegacy: Remove the unused variable len
      net/mlx5: DR, Use swap() instead of open coding it
      selftests/net: remove unneeded semicolon

Jiawen Wu (8):
      net: libwx: add phylink to libwx
      net: txgbe: use phylink bits added in libwx
      net: ngbe: convert phylib to phylink
      net: wangxun: add flow control support
      net: wangxun: add ethtool_ops for ring parameters
      net: wangxun: add coalesce options support
      net: wangxun: add ethtool_ops for channel number
      net: wangxun: add ethtool_ops for msglevel

Jie Jiang (1):
      bpf: Support uid and gid when mounting bpffs

Jiri Olsa (9):
      libbpf: Add st_type argument to elf_resolve_syms_offsets function
      bpf: Store ref_ctr_offsets values in bpf_uprobe array
      bpf: Add link_info support for uprobe multi link
      selftests/bpf: Use bpf_link__destroy in fill_link_info tests
      selftests/bpf: Add link_info test for uprobe_multi link
      bpftool: Add support to display uprobe_multi links
      bpf: Fail uprobe multi link with negative offset
      selftests/bpf: Add more uprobe multi fail tests
      bpf: Fix re-attachment branch in bpf_tracing_prog_attach

Jiri Pirko (18):
      Documentation: devlink: extend reload-reinit description
      devlink: warn about existing entities during reload-reinit
      docs: netlink: add NLMSG_DONE message format for doit actions
      dpll: remove leftover mode_supported() op and use mode_get() instead
      dpll: allocate pin ids in cycle
      devlink: use devl_is_registered() helper instead xa_get_mark()
      devlink: introduce __devl_is_registered() helper and use it instead of xa_get_mark()
      devlink: send notifications only if there are listeners
      devlink: introduce a helper for netlink multicast send
      genetlink: introduce per-sock family private storage
      netlink: introduce typedef for filter function
      genetlink: introduce helpers to do filtered multicast
      devlink: add a command to set notification filter and use it for multicasts
      devlink: extend multicast filtering by port index
      net: sched: move block device tracking into tcf_block_get/put_ext()
      dpll: expose fractional frequency offset value to user
      net/mlx5: DPLL, Use struct to get values from mlx5_dpll_synce_status_get()
      net/mlx5: DPLL, Implement fractional frequency offset get pin op

Jiri Slaby (SUSE) (1):
      wifi: ath5k: remove unused ath5k_eeprom_info::ee_antenna

Johannes Berg (29):
      net: core: synchronize link-watch when carrier is queried
      wifi: nl80211: refactor nl80211_send_mlme_event() arguments
      wifi: cfg80211: make RX assoc data const
      net: rtnetlink: remove local list in __linkwatch_run_queue()
      net: sysfs: fix locking in carrier read
      Revert "net: rtnetlink: remove local list in __linkwatch_run_queue()"
      Merge tag 'platform-drivers-x86-amd-wbrf-v6.8-1' into wireless-next
      wifi: iwlwifi: refactor RX tracing
      wifi: iwlwifi: pcie: clean up device removal work
      wifi: iwlwifi: pcie: dump CSRs before removal
      wifi: iwlwifi: pcie: get_crf_id() can be void
      wifi: iwlwifi: fw: file: don't use [0] for variable arrays
      wifi: iwlwifi: remove async command callback
      wifi: cfg80211: add BSS usage reporting
      wifi: mac80211: update some locking documentation
      wifi: mac80211: add a flag to disallow puncturing
      wifi: mac80211: don't set ESS capab bit in assoc request
      wifi: cfg80211: sort certificates in build
      wifi: mac80211: rework RX timestamp flags
      wifi: mac80211: allow 64-bit radiotap timestamps
      wifi: iwlwifi: mvm: set siso/mimo chains to 1 in FW SMPS request
      wifi: iwlwifi: mvm: send TX path flush in rfkill
      wifi: iwlwifi: mvm: d3: avoid intermediate/early mutex unlock
      wifi: iwlwifi: mvm: add US/Canada MCC to API
      wifi: iwlwifi: mvm: disallow puncturing in US/Canada
      wifi: mac80211: add kunit tests for public action handling
      wifi: mac80211: kunit: generalize public action test
      wifi: mac80211: kunit: extend MFP tests
      wifi: mac80211: remove redundant ML element check

John Fastabend (5):
      bpf: sockmap, fix proto update hook to avoid dup calls
      bpf: sockmap, added comments describing update proto rules
      bpf: sockmap, add tests for proto updates many to single map
      bpf: sockmap, add tests for proto updates single socket to many map
      bpf: sockmap, add tests for proto updates replace socket

John Fraker (5):
      gve: Perform adminq allocations through a dma_pool.
      gve: Deprecate adminq_pfn for pci revision 0x1.
      gve: Remove obsolete checks that rely on page size.
      gve: Add page size register to the register_page_list command.
      gve: Remove dependency on 4k page size.

Jonathan Corbet (7):
      wifi: cfg80211: address several kerneldoc warnings
      wifi: mac80211: address some kerneldoc warnings
      net: skbuff: Remove some excess struct-member documentation
      tipc: Remove some excess struct member documentation
      net: sock: remove excess structure-member documentation
      ethtool: reformat kerneldoc for struct ethtool_link_settings
      ethtool: reformat kerneldoc for struct ethtool_fec_stats

Jordan Rome (2):
      bpf: Add crosstask check to __bpf_get_stack
      selftests/bpf: Add assert for user stacks in test_task_stack

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: avoid two consecutive device resets

Jouni Malinen (1):
      wifi: mac80211: Skip association timeout update after comeback rejection

Justin Bronder (1):
      i40e: increase max descriptors for XL710

Justin Chen (2):
      net: mdio: mdio-bcm-unimac: Delay before first poll
      net: mdio: mdio-bcm-unimac: Use read_poll_timeout

Justin Stitt (9):
      wifi: brcm80211: replace deprecated strncpy with strscpy
      wifi: brcmsmac: replace deprecated strncpy with memcpy
      wifi: airo: replace deprecated strncpy with strscpy_pad
      wifi: ath10k: replace deprecated strncpy with memcpy
      net/mlx5: simplify mlx5_set_driver_version string assignments
      wifi: iwlwifi: fw: replace deprecated strncpy with strscpy_pad
      qlcnic: replace deprecated strncpy with strscpy
      net: mdio_bus: replace deprecated strncpy with strscpy
      net: mdio-gpio: replace deprecated strncpy with strscpy

Kalle Valo (3):
      Merge tag 'mt76-for-kvalo-2023-12-06' of https://github.com/nbd168/wireless
      wifi: ath11k: workaround too long expansion sparse warnings
      Merge tag 'ath-next-20231215' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath

Kang Yang (8):
      wifi: ath12k: get msi_data again after request_irq is called
      wifi: ath12k: add CE and ext IRQ flag to indicate irq_handler
      wifi: ath12k: use ATH12K_PCI_IRQ_DP_OFFSET for DP IRQ
      wifi: ath12k: refactor multiple MSI vector implementation
      wifi: ath12k: add support one MSI vector
      wifi: ath12k: do not restore ASPM in case of single MSI vector
      wifi: ath12k: set IRQ affinity to CPU0 in case of one MSI vector
      wifi: ath12k: fix and enable AP mode for WCN7850

Karol Kolacinski (4):
      ice: Re-enable timestamping correctly after reset
      ice: Rename E822 to E82X
      ice: Schedule service task in IRQ top half
      ice: Enable SW interrupt from FW for LL TS

Karthikeyan Periyasamy (9):
      wifi: ath12k: fix the error handler of rfkill config
      wifi: ath12k: avoid explicit mac id argument in Rxdma replenish
      wifi: ath12k: avoid explicit RBM id argument in Rxdma replenish
      wifi: ath12k: avoid explicit HW conversion argument in Rxdma replenish
      wifi: ath12k: refactor DP Rxdma ring structure
      wifi: ath12k: Optimize the mac80211 hw data access
      wifi: ath12k: avoid repeated hw access from ar
      wifi: ath12k: avoid repeated wiphy access from hw
      Revert "wifi: ath12k: use ATH12K_PCI_IRQ_DP_OFFSET for DP IRQ"

Kees Cook (5):
      net/mlx5: Annotate struct mlx5_fc_bulk with __counted_by
      net/mlx5: Annotate struct mlx5_flow_handle with __counted_by
      netlink: Return unsigned value for nla_len()
      amd-xgbe: Avoid potential string truncation in name
      cxgb3: Avoid potential string truncation in desc

Kevin Hao (1):
      net: pktgen: Use wait_event_freezable_timeout() for freezable kthread

Kiran K (1):
      Bluetooth: btintel: Print firmware SHA1

Konrad Knitter (1):
      ice: read internal temperature sensor

Konstantin Taranov (1):
      net: mana: add msix index sharing between EQs

Kory Maincent (16):
      net: Convert PHYs hwtstamp callback to use kernel_hwtstamp_config
      net: phy: Remove the call to phy_mii_ioctl in phy_hwstamp_get/set
      net: macb: Convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
      net: Make dev_set_hwtstamp_phylib accessible
      net: phy: micrel: fix ts_info value in case of no phc
      net_tstamp: Add TIMESTAMPING SOFTWARE and HARDWARE mask
      net: ethtool: Add a command to expose current time stamping layer
      netlink: specs: Introduce new netlink command to get current timestamp
      net: ethtool: Add a command to list available time stamping layers
      netlink: specs: Introduce new netlink command to list available time stamping layers
      net: Replace hwtstamp_source by timestamping layer
      net: Change the API of PHY default timestamp to MAC
      net: ethtool: ts: Update GET_TS to reply the current selected timestamp
      net: ethtool: ts: Let the active time stamping layer be selectable
      netlink: specs: Introduce time stamping set command
      firmware_loader: Expand Firmware upload error codes with firmware invalid error

Kuniyuki Iwashima (20):
      tcp: Clean up reverse xmas tree in cookie_v[46]_check().
      tcp: Cache sock_net(sk) in cookie_v[46]_check().
      tcp: Clean up goto labels in cookie_v[46]_check().
      tcp: Don't pass cookie to __cookie_v[46]_check().
      tcp: Don't initialise tp->tsoffset in tcp_get_cookie_sock().
      tcp: Move TCP-AO bits from cookie_v[46]_check() to tcp_ao_syncookie().
      tcp: Factorise cookie-independent fields initialisation in cookie_v[46]_check().
      tcp: Factorise cookie-dependent fields initialisation in cookie_v[46]_check()
      tcp: Use bhash2 for v4-mapped-v6 non-wildcard address.
      tcp: Rearrange tests in inet_bind2_bucket_(addr_match|match_addr_any)().
      tcp: Save v4 address as v4-mapped-v6 in inet_bind2_bucket.v6_rcv_saddr.
      tcp: Save address type in inet_bind2_bucket.
      tcp: Rename tb in inet_bind2_bucket_(init|create)().
      tcp: Link bhash2 to bhash.
      tcp: Rearrange tests in inet_csk_bind_conflict().
      tcp: Iterate tb->bhash2 in inet_csk_bind_conflict().
      tcp: Check hlist_empty(&tb->bhash2) instead of hlist_empty(&tb->owners).
      tcp: Unlink sk from bhash.
      tcp: Link sk and twsk to tb2->owners using skc_bind_node.
      tcp: Remove dead code and fields for bhash2.

Kunwu Chan (2):
      wifi: iwlegacy: Add null pointer check to il_leds_init()
      ice: Fix some null pointer dereference issues in ice_ptp.c

Lad Prabhakar (1):
      dt-bindings: net: renesas,etheravb: Document RZ/Five SoC

Larysa Zaremba (18):
      selftests/bpf: Increase invalid metadata size
      ice: make RX hash reading code more reusable
      ice: make RX HW timestamp reading code more reusable
      ice: Make ptype internal to descriptor info processing
      ice: Introduce ice_xdp_buff
      ice: Support HW timestamp hint
      ice: Support RX hash XDP hint
      ice: Support XDP hints in AF_XDP ZC mode
      xdp: Add VLAN tag hint
      ice: Implement VLAN tag hint
      ice: use VLAN proto from ring packet context in skb path
      veth: Implement VLAN tag XDP hint
      net: make vlan_get_tag() return -ENODATA instead of -EINVAL
      mlx5: implement VLAN tag XDP hint
      selftests/bpf: Allow VLAN packets in xdp_hw_metadata
      selftests/bpf: Add flags and VLAN hint to xdp_hw_metadata
      selftests/bpf: Add AF_INET packet generation to xdp_metadata
      selftests/bpf: Check VLAN tag and proto in xdp_metadata

Leon Hwang (1):
      bpf, x86: Use emit_nops to replace memcpy x86_nops

Leone Fernando (1):
      ipmr: support IP_PKTINFO on cache report IGMP msg

Li RongQing (2):
      rtnetlink: introduce nlmsg_new_large and use it in rtnl_getlink
      net/smc: remove unneeded atomic operations in smc_tx_sndbuf_nonempty

Liam Kearney (1):
      wifi: ieee80211: fix PV1 frame control field name

Liang Chen (4):
      page_pool: transition to reference count management after page draining
      page_pool: halve BIAS_MAX for multiple user references of a fragment
      skbuff: Add a function to check if a page belongs to page_pool
      skbuff: Optimization of SKB coalescing for page pool

Lin Ma (2):
      bridge: cfm: fix enum typo in br_cc_ccm_tx_parse
      net/sched: cls_api: complement tcf_tfilter_dump_policy

Lingbo Kong (1):
      wifi: ath12k: fix the issue that the multicast/broadcast indicator is not read correctly for WCN7850

Linus Lüssing (3):
      batman-adv: mcast: implement multicast packet reception and forwarding
      batman-adv: mcast: implement multicast packet generation
      batman-adv: mcast: shrink tracker packet after scrubbing

Linus Walleij (8):
      dt-bindings: net: dsa: Require ports or ethernet-ports
      dt-bindings: net: mvusb: Fix up DSA example
      dt-bindings: net: ethernet-switch: Accept special variants
      dt-bindings: marvell: Rewrite MV88E6xxx in schema
      dt-bindings: marvell: Add Marvell MV88E6060 DSA schema
      net: dsa: realtek: Rename bogus RTL8368S variable
      net: dsa: realtek: Rewrite RTL8366RB MTU handling
      net: ethernet: cortina: Drop TSO support

Lorenzo Bianconi (15):
      net: ethernet: mtk_wed: rely on __dev_alloc_page in mtk_wed_tx_buffer_alloc
      net: ethernet: mtk_wed: add support for devices with more than 4GB of dram
      wifi: mt76: mmio: move mt76_mmio_wed_{init,release}_rx_buf in common code
      wifi: mt76: move mt76_mmio_wed_offload_{enable,disable} in common code
      wifi: mt76: move mt76_net_setup_tc in common code
      wifi: mt76: introduce mt76_queue_is_wed_tx_free utility routine
      wifi: mt76: introduce wed pointer in mt76_queue
      wifi: mt76: increase MT_QFLAG_WED_TYPE size
      wifi: mt76: dma: introduce __mt76_dma_queue_reset utility routine
      wifi: mt76: mt7996: use u16 for val field in mt7996_mcu_set_rro signature
      wifi: mt76: move wed reset common code in mt76 module
      wifi: mt76: mt7996: add wed reset support
      wifi: mt76: mt7996: add wed rro delete session garbage collector
      wifi: mt76: mt7915: fallback to non-wed mode if platform_get_resource fails in mt7915_mmio_wed_init()
      wifi: mt76: mt7925: remove iftype from mt7925_init_eht_caps signature

Luca Weiss (1):
      wifi: ath11k: Defer on rproc_get failure

Lucas Karpinski (1):
      selftests/net: synchronize udpgro tests' tx and rx connection

Luiz Angelo Daros de Luca (1):
      net: mdio: get/put device node during (un)registration

Luiz Augusto von Dentz (3):
      Bluetooth: btusb: Don't suspend when there are connections
      Bluetooth: hci_core: Remove le_restart_scan work
      Bluetooth: Fix bogus check for re-auth no supported with non-ssp

Lukas Bulwahn (1):
      wifi: libertas: fix config name in dependency for SDIO support

Ma Jun (2):
      Documentation/driver-api: Add document about WBRF mechanism
      platform/x86/amd: Add support for AMD ACPI based Wifi band RFI mitigation feature

Ma Ke (1):
      wifi: ath12k: drop NULL pointer check in ath12k_update_per_peer_tx_stats()

Maciej Fijalkowski (1):
      xsk: add functions to fill control buffer

Manu Bretelle (2):
      selftests/bpf: Consolidate VIRTIO/9P configs in config.vm file
      selftests/bpf: Fixes tests for filesystem kfuncs

Marcin Wojtas (1):
      net: mvpp2: initialize port fwnode pointer

Marco von Rosenberg (1):
      net: phy: broadcom: Wire suspend/resume for BCM54612E

Marek Behún (2):
      net: sfp: rework the RollBall PHY waiting code
      net: sfp: fix PHY discovery for FS SFP-10G-T module

Martin Blumenstingl (1):
      wifi: rtw88: sdio: Honor the host max_req_size in the RX path

Martin KaFai Lau (2):
      Merge branch 'bpf: Expand bpf_cgrp_storage to support cgroup1 non-attach case'
      Merge branch 'fix sockmap + stream  af_unix memleak'

Matt Bobrowski (1):
      bpf: add small subset of SECURITY_PATH hooks to BPF sleepable_lsm_hooks list

Maxim Galaganov (3):
      mptcp: rename mptcp_setsockopt_sol_ip_set_transparent()
      mptcp: sockopt: support IP_LOCAL_PORT_RANGE and IP_BIND_ADDRESS_NO_PORT
      selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE

Maxime Chevallier (14):
      Documentation: networking: add missing PLCA messages from the message list
      net: phy: Introduce ethernet link topology representation
      net: sfp: pass the phy_device when disconnecting an sfp module's PHY
      net: phy: add helpers to handle sfp phy connect/disconnect
      net: sfp: Add helper to return the SFP bus name
      net: ethtool: Allow passing a phy index for some commands
      netlink: specs: add phy-index as a header parameter
      net: ethtool: Introduce a command to list PHYs on an interface
      netlink: specs: add ethnl PHY_GET command set
      net: ethtool: plca: Target the command to the requested PHY
      net: ethtool: pse-pd: Target the command to the requested PHY
      net: ethtool: cable-test: Target the command to the requested PHY
      net: ethtool: strset: Allow querying phy stats by index
      Documentation: networking: document phy_link_topology

MeiChia Chiu (2):
      wifi: mt76: mt7996: fix rate usage of inband discovery frames
      wifi: mt76: connac: fix EHT phy mode check

Menglong Dong (4):
      bpf: make the verifier tracks the "not equal" for regs
      selftests/bpf: remove reduplicated s32 casting in "crafted_cases"
      selftests/bpf: activate the OP_NE logic in range_cond()
      selftests/bpf: add testcase to verifier_bounds.c for BPF_JNE

Michael Chan (62):
      bnxt_en: Put the TX producer information in the TX BD opaque field
      bnxt_en: Add completion ring pointer in TX and RX ring structures
      bnxt_en: Restructure cp_ring_arr in struct bnxt_cp_ring_info
      bnxt_en: Add completion ring pointer in TX and RX ring structures
      bnxt_en: Remove BNXT_RX_HDL and BNXT_TX_HDL
      bnxt_en: Refactor bnxt_tx_int()
      bnxt_en: New encoding for the TX opaque field
      bnxt_en: Refactor bnxt_hwrm_set_coal()
      bnxt_en: Support up to 8 TX rings per MSIX
      bnxt_en: Add helper to get the number of CP rings required for TX rings
      bnxt_en: Add macros related to TC and TX rings
      bnxt_en: Use existing MSIX vectors for all mqprio TX rings
      bnxt_en: Optimize xmit_more TX path
      bnxt_en: The caller of bnxt_alloc_ctx_mem() should always free bp->ctx
      bnxt_en: Free bp->ctx inside bnxt_free_ctx_mem()
      bnxt_en: Restructure context memory data structures
      bnxt_en: Add page info to struct bnxt_ctx_mem_type
      bnxt_en: Use the pg_info field in bnxt_ctx_mem_type struct
      bnxt_en: Add bnxt_setup_ctxm_pg_tbls() helper function
      bnxt_en: Add support for new backing store query firmware API
      bnxt_en: Add support for HWRM_FUNC_BACKING_STORE_CFG_V2 firmware calls
      bnxt_en: Add db_ring_mask and related macro to bnxt_db_info struct.
      bnxt_en: Modify TX ring indexing logic.
      bnxt_en: Modify RX ring indexing logic.
      bnxt_en: Modify the NAPI logic for the new P7 chips
      bnxt_en: Fix backing store V2 logic
      bnxt_en: Update firmware interface to 1.10.3.15
      bnxt_en: Define basic P7 macros
      bnxt_en: Implement the new toggle bit doorbell mechanism on P7 chips
      bnxt_en: Add new P7 hardware interface definitions
      bnxt_en: Refactor RX VLAN acceleration logic.
      bnxt_en: Refactor and refine bnxt_tpa_start() and bnxt_tpa_end().
      bnxt_en: Add support for new RX and TPA_START completion types for P7
      bnxt_en: Refactor ethtool speeds logic
      bnxt_en: Support new firmware link parameters
      bnxt_en: Support force speed using the new HWRM fields
      bnxt_en: Report the new ethtool link modes in the new firmware interface
      bnxt_en: Add 5760X (P7) PCI IDs
      bnxt_en: Fix trimming of P5 RX and TX rings
      bnxt_en: Fix TX ring indexing logic
      bnxt_en: Prevent TX timeout with a very small TX ring
      bnxt_en: Support TX coalesced completion on 5760X chips
      bnxt_en: Use proper TUNNEL_DST_PORT_ALLOC* commands
      bnxt_en: Add support for VXLAN GPE
      bnxt_en: Configure UDP tunnel TPA
      bnxt_en: Add support for UDP GSO on 5760X chips
      bnxt_en: Refactor bnxt_ntuple_filter structure.
      bnxt_en: Add bnxt_l2_filter hash table.
      bnxt_en: Re-structure the bnxt_ntuple_filter structure.
      bnxt_en: Refactor L2 filter alloc/free firmware commands.
      bnxt_en: Add bnxt_lookup_ntp_filter_from_idx() function
      bnxt_en: Add new BNXT_FLTR_INSERTED flag to bnxt_filter_base struct.
      bnxt_en: Refactor filter insertion logic in bnxt_rx_flow_steer().
      bnxt_en: Refactor the hash table logic for ntuple filters.
      bnxt_en: Refactor ntuple filter removal logic in bnxt_cfg_ntp_filters().
      bnxt_en: Add ntuple matching flags to the bnxt_ntuple_filter structure.
      bnxt_en: Add support for ntuple filters added from ethtool.
      bnxt_en: Add support for ntuple filter deletion by ethtool.
      bnxt_en: Fix compile error without CONFIG_RFS_ACCEL
      bnxt_en: Remove unneeded variable in bnxt_hwrm_clear_vnic_filter()
      bnxt_en: Fix RCU locking for ntuple filters in bnxt_srxclsrldel()
      bnxt_en: Fix RCU locking for ntuple filters in bnxt_rx_flow_steer()

Michal Kubiak (1):
      idpf: add get/set for Ethtool's header split ringparam

Michal Swiatkowski (15):
      ice: rename switchdev to eswitch
      ice: remove redundant max_vsi_num variable
      ice: remove unused control VSI parameter
      ice: track q_id in representor
      ice: use repr instead of vf->repr
      ice: track port representors in xarray
      ice: remove VF pointer reference in eswitch code
      ice: make representor code generic
      ice: return pointer to representor
      ice: allow changing SWITCHDEV_CTRL VSI queues
      ice: set Tx topology every time new repr is added
      ice: realloc VSI stats arrays
      ice: add VF representors one by one
      ice: adjust switchdev rebuild path
      ice: reserve number of CP queues

Mina Almasry (2):
      vsock/virtio: use skb_frag_*() helpers
      net: kcm: fix direct access to bv_len

Ming Yen Hsieh (3):
      wifi: mt76: mt7921: fix country count limitation for CLC
      wifi: mt76: mt7921: fix CLC command timeout when suspend/resume
      wifi: mt76: mt7921: fix wrong 6Ghz power type

Mingyi Zhang (1):
      libbpf: Fix NULL pointer dereference in bpf_object__collect_prog_relos

Minsuk Kang (1):
      wifi: ath9k: Fix potential array-index-out-of-bounds read in ath9k_htc_txstatus()

Miquel Raynal (16):
      ieee802154: Let PAN IDs be reset
      ieee802154: Internal PAN management
      ieee802154: Add support for user association requests
      mac802154: Handle associating
      ieee802154: Add support for user disassociation requests
      mac802154: Handle disassociations
      mac802154: Handle association requests from peers
      ieee802154: Add support for limiting the number of associated devices
      mac802154: Follow the number of associated devices
      mac802154: Handle disassociation notifications from peers
      ieee802154: Give the user the association list
      mac80254: Provide real PAN coordinator info in beacons
      mac802154: Use the PAN coordinator parameter when stamping packets
      mac802154: Only allow PAN controllers to process association requests
      ieee802154: Avoid confusing changes after associating
      mac802154: Avoid new associations while disassociating

Miri Korenblit (5):
      wifi: iwlwifi: don't support triggered EHT CQI feedback
      wifi: mac80211_hwsim: support HE 40 MHz in 2.4 GHz band
      wifi: mac80211: add a driver callback to check active_links
      wifi: iwlwifi: assign phy_ctxt before eSR activation
      wifi: iwlwifi: cleanup BT Shared Single Antenna code

Moshe Shemesh (2):
      net/mlx5: print change on SW reset semaphore returns busy
      net/mlx5: Allow sync reset flow when BF MGT interface device is present

Mukesh Sisodiya (2):
      wifi: cfg80211: handle UHB AP and STA power type
      wifi: iwlwifi: Add rf_mapping of new wifi7 devices

Muna Sinada (1):
      wifi: ath12k: add 320 MHz bandwidth enums

Murali Karicheri (1):
      net: hsr: Add support for MC filtering at the slave device

Neil Armstrong (1):
      dt-bindings: net: qcom,ipa: document SM8650 compatible

Niklas Söderlund (7):
      net: ethernet: renesas: rcar_gen4_ptp: Remove incorrect comment
      net: ethernet: renesas: rcar_gen4_ptp: Fail on unknown register layout
      net: ethernet: renesas: rcar_gen4_ptp: Prepare for shared register layout
      net: ethernet: renesas: rcar_gen4_ptp: Get clock increment from clock rate
      net: ethernet: renesas: rcar_gen4_ptp: Break out to module
      dt-bindings: net: renesas,ethertsn: Add Ethernet TSN
      net: ethernet: renesas: rcar_gen4_ptp: Depend on PTP_1588_CLOCK

Nithin Dabilpuram (1):
      octeontx2-af: debugfs: update CQ context fields

Oleg Nesterov (3):
      bpf: task_group_seq_get_next: use __next_thread() rather than next_thread()
      bpf: bpf_iter_task_next: use __next_thread() rather than next_thread()
      bpf: bpf_iter_task_next: use next_task(kit->task) rather than next_task(kit->pos)

Oleksij Rempel (5):
      net: dsa: microchip: ksz8: Make flow control, speed, and duplex on CPU port configurable
      net: dsa: microchip: ksz8: Add function to configure ports with integrated PHYs
      net: dsa: microchip: make phylink_mac_link_up() not optional
      net: phy: c45: add genphy_c45_pma_read_ext_abilities() function
      net: phy: Add support for the DP83TG720S Ethernet PHY

Or Har-Toov (1):
      net/mlx5e: Add local loopback counter to vport rep stats

Ovidiu Panait (1):
      ixgbe: report link state for VF devices

Pablo Neira Ayuso (1):
      netfilter: nf_tables: validate chain type update if available

Paolo Abeni (15):
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-ethernet-renesas-rcar_gen4_ptp-add-v4h-support'
      Merge branch 'net-page_pool-add-netlink-based-introspection'
      Merge branch 'devlink-warn-about-existing-entities-during-reload-reinit'
      Merge branch 'net-ethernet-convert-to-platform-remove-callback-returning-void'
      Merge branch 'doc-update-bridge-doc'
      Merge branch 'net-sched-act_api-contiguous-action-arrays'
      Merge branch 'intel-wired-lan-driver-updates-2023-12-01-ice'
      Merge branch 'conver-net-selftests-to-run-in-unique-namespace-part-1'
      Merge branch 'net-dsa-realtek-two-rtl8366rb-fixes'
      Merge branch 'add-pf-vf-mailbox-support'
      Merge branch 'devlink-introduce-notifications-filtering'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Paul M Stillwell Jr (5):
      ice: remove FW logging code
      ice: configure FW logging
      ice: enable FW logging
      ice: add ability to read and configure FW log data
      ice: add documentation for FW logging

Pavan Chebbi (3):
      bnxt_en: Skip nic close/open when configuring tstamp filters
      bnxt_en: Make PTP TX timestamp HWRM query silent
      bnxt_en: Add function to calculate Toeplitz hash

Pavan Nikhilesh (1):
      octeontx2-af: cn10k: Increase outstanding LMTST transactions

Pawel Kaminski (1):
      ice: Improve logs for max ntuple errors

Pedro Tammela (36):
      selftests: tc-testing: drop '-N' argument from nsPlugin
      selftests: tc-testing: rework namespaces and devices setup
      selftests: tc-testing: preload all modules in kselftests
      selftests: tc-testing: use parallel tdc in kselftests
      net/sched: cls_u32: replace int refcounts with proper refcounts
      selftests/tc-testing: add hashtable tests for u32
      selftests: tc-testing: cap parallel tdc to 4 cores
      selftests: tc-testing: move back to per test ns setup
      selftests: tc-testing: use netns delete from pyroute2
      selftests: tc-testing: leverage -all in suite ns teardown
      selftests: tc-testing: timeout on unbounded loops
      selftests: tc-testing: report number of workers in use
      selftests: tc-testing: remove buildebpf plugin
      selftests: tc-testing: remove unnecessary time.sleep
      selftests: tc-testing: prefix iproute2 functions with "ipr2"
      selftests: tc-testing: cleanup on Ctrl-C
      selftests: tc-testing: remove unused import
      selftests: tc-testing: remove spurious nsPlugin usage
      selftests: tc-testing: remove spurious './' from Makefile
      selftests: tc-testing: rename concurrency.json to flower.json
      selftests: tc-testing: remove filters/tests.json
      net/sched: act_api: use tcf_act_for_each_action
      net/sched: act_api: avoid non-contiguous action array
      net/sched: act_api: stop loop over ops array on NULL in tcf_action_init
      net/sched: act_api: use tcf_act_for_each_action in tcf_idr_insert_many
      rtnl: add helper to send if skb is not null
      net/sched: act_api: don't open code max()
      net/sched: act_api: conditional notification of events
      net/sched: cls_api: remove 'unicast' argument from delete notification
      net/sched: cls_api: conditional notification of events
      net/sched: act_api: rely on rcu in tcf_idr_check_alloc
      net/sched: act_api: skip idr replace on bound actions
      net: rtnl: use rcu_replace_pointer_rtnl in rtnl_unregister_*
      net/sched: introduce ACT_P_BOUND return code
      net/sched: sch_api: conditional netlink notifications
      net/sched: simplify tc_action_load_ops parameters

Peter Chiu (4):
      wifi: mt76: mt7996: adjust WFDMA settings to improve performance
      wifi: mt76: mt7996: handle IEEE80211_RC_SMPS_CHANGED
      wifi: mt76: mt7996: align the format of fixed rate command
      wifi: mt76: mt7996: rework ampdu params setting

Peter Delevoryas (3):
      net/ncsi: Simplify Kconfig/dts control flow
      net/ncsi: Fix netlink major/minor version numbers
      net/ncsi: Add NC-SI 1.2 Get MC MAC Address command

Peter Zijlstra (6):
      cfi: Flip headers
      x86/cfi,bpf: Fix BPF JIT call
      x86/cfi,bpf: Fix bpf_callback_t CFI
      x86/cfi,bpf: Fix bpf_struct_ops CFI
      cfi: Add CFI_NOSEAL()
      bpf: Fix dtor CFI

Petr Machata (34):
      mlxsw: cmd: Add cmd_mbox.query_fw.cff_support
      mlxsw: cmd: Add MLXSW_CMD_MBOX_CONFIG_PROFILE_FLOOD_MODE_CFF
      mlxsw: resources: Add max_cap_nve_flood_prf
      mlxsw: reg: Add Switch FID Flooding Profiles Register
      mlxsw: reg: Mark SFGC & some SFMR fields as reserved in CFF mode
      mlxsw: reg: Drop unnecessary writes from mlxsw_reg_sfmr_pack()
      mlxsw: reg: Extract flood-mode specific part of mlxsw_reg_sfmr_pack()
      mlxsw: reg: Add to SFMR register the fields related to CFF flood mode
      mlxsw: core, pci: Add plumbing related to CFF mode
      mlxsw: pci: Permit enabling CFF mode
      mlxsw: spectrum_fid: Drop unnecessary conditions
      mlxsw: spectrum_fid: Extract SFMR packing into a helper
      mlxsw: spectrum_router: Add a helper to get subport number from a RIF
      mlxsw: spectrum_router: Call RIF setup before obtaining FID
      mlxsw: spectrum_fid: Privatize FID families
      mlxsw: spectrum_fid: Rename FID ops, families, arrays
      mlxsw: spectrum_fid: Split a helper out of mlxsw_sp_fid_flood_table_mid()
      mlxsw: spectrum_fid: Make mlxsw_sp_fid_ops.setup return an int
      mlxsw: spectrum_fid: Move mlxsw_sp_fid_flood_table_init() up
      mlxsw: spectrum_fid: Add an op for flood table initialization
      mlxsw: spectrum_fid: Add an op to get PGT allocation size
      mlxsw: spectrum_fid: Add an op to get PGT address of a FID
      mlxsw: spectrum_fid: Add an op for packing SFMR
      mlxsw: spectrum_fid: Add a not-UC packet type
      mlxsw: spectrum_fid: Add hooks for RSP table maintenance
      mlxsw: spectrum_fid: Add an object to keep flood profiles
      mlxsw: spectrum_fid: Add profile_id to flood profile
      mlxsw: spectrum_fid: Initialize flood profiles in CFF mode
      mlxsw: spectrum_fid: Add a family for bridge FIDs in CFF flood mode
      mlxsw: spectrum_fid: Add support for rFID family in CFF flood mode
      mlxsw: spectrum: Use CFF mode where available
      mlxsw: reg: Add nve_flood_prf_id field to SFMR
      mlxsw: spectrum_fid: Add an "any" packet type
      mlxsw: spectrum_fid: Set NVE flood profile as part of FID configuration

Petr Oros (1):
      iavf: use iavf_schedule_aq_request() helper

Petr Tesarik (1):
      net: stmmac: fix ethtool per-queue statistics

Phil Sutter (3):
      netfilter: nf_tables: Pass const set to nft_get_set_elem
      netfilter: nf_tables: Introduce nft_set_dump_ctx_init()
      netfilter: nf_tables: Add locking for NFT_MSG_GETSETELEM_RESET requests

Ping-Ke Shih (50):
      wifi: rtw89: 8922ae: add 8922AE PCI entry and basic info
      wifi: rtw89: pci: define PCI ring address for WiFi 7 chips
      wifi: rtw89: pci: add new RX ring design to determine full RX ring efficiently
      wifi: rtw89: pci: generalize code of PCI control DMA IO for WiFi 7
      wifi: rtw89: set entry size of address CAM to H2C field by chip
      wifi: rtw89: consider RX info for WiFi 7 chips
      wifi: rtw89: extend PHY status parser to support WiFi 7 chips
      wifi: rtw89: pci: add PCI generation information to pci_info for each chip
      wifi: rtw89: pci: use gen_def pointer to configure mac_{pre,post}_init and clear PCI ring index
      wifi: rtw89: pci: implement PCI mac_pre_init for WiFi 7 chips
      wifi: rtw89: pci: add LTR v2 for WiFi 7 chip
      wifi: rtw89: pci: implement PCI mac_post_init for WiFi 7 chips
      wifi: rtw89: coex: use struct assignment to replace memcpy() to append TDMA content
      wifi: rtw89: pci: add pre_deinit to be called after probe complete
      wifi: rtw89: pci: generalize interrupt status bits of interrupt handlers
      wifi: rtw89: 8922ae: add v2 interrupt handlers for 8922AE
      wifi: rtw89: pci: correct interrupt mitigation register for 8852CE
      wifi: rtw89: pci: update interrupt mitigation register for 8922AE
      wifi: rtw89: 8922a: add 8922A basic chip info
      wifi: rtw89: mac: use mac_gen pointer to access about efuse
      wifi: rtw89: mac: add to access efuse for WiFi 7 chips
      wifi: rtw89: 8852c: read RX gain offset from efuse for 6GHz channels
      wifi: rtw89: 8922a: read efuse content via efuse map struct from logic map
      wifi: rtw89: 8922a: read efuse content from physical map
      wifi: rtw88: debug: remove wrapper of rtw_dbg()
      wifi: rtw89: debug: add to check if debug mask is enabled
      wifi: rtw89: debug: add debugfs entry to disable dynamic mechanism
      wifi: rtw89: debug: remove wrapper of rtw89_debug()
      wifi: rtw89: 8922a: extend and add quota number
      wifi: rtw89: mac: add to get DLE reserved quota
      wifi: rtw89: add reserved size as factor of DLE used size
      wifi: rtw89: mac: move code related to hardware engine to individual functions
      wifi: rtw89: mac: use pointer to access functions of hardware engine and quota
      wifi: rtw89: mac: functions to configure hardware engine and quota for WiFi 7 chips
      wifi: rtw89: 8922a: add SER IMR tables
      wifi: rtw89: mac: refine SER setting during WiFi CPU power on
      wifi: rtw89: fw: load TX power track tables from fw_element
      wifi: rtw89: fw: add version field to BB MCU firmware element
      wifi: rtw89: load RFK log format string from firmware file
      wifi: rtw89: add C2H event handlers of RFK log and report
      wifi: rtw89: parse and print out RFK log from C2H events
      wifi: rtw89: phy: print out RFK log with formatted string
      wifi: rtw89: add XTAL SI for WiFi 7 chips
      wifi: rtw89: 8922a: add power on/off functions
      wifi: rtw89: mac: add flags to check if CMAC and DMAC are enabled
      wifi: rtw89: mac: add suffix _ax to MAC functions
      wifi: rtw89: add DBCC H2C to notify firmware the status
      wifi: rtw89: only reset BB/RF for existing WiFi 6 chips while starting up
      wifi: rtw89: mac: add sys_init and filter option for WiFi 7 chips
      wifi: rtw89: mac: implement to configure TX/RX engines for WiFi 7 chips

Po-Hao Huang (2):
      wifi: rtw89: fix not entering PS mode after AP stops
      wifi: rtw89: Refine active scan behavior in 6 GHz

Puranjay Mohan (1):
      bpf: Remove test for MOVSX32 with offset=32

Qi Zhang (1):
      ice: refactor RSS configuration

Quentin Deslandes (1):
      bpfilter: remove bpfilter

Radhey Shyam Pandey (2):
      dt-bindings: net: xlnx,axi-ethernet: Introduce DMA support
      net: axienet: Introduce dmaengine support

Radu Pirea (NXP OSS) (9):
      net: rename dsa_realloc_skb to skb_ensure_writable_head_tail
      net: macsec: use skb_ensure_writable_head_tail to expand the skb
      net: macsec: move sci_to_cpu to macsec header
      net: macsec: documentation for macsec_context and macsec_ops
      net: macsec: revert the MAC address if mdo_upd_secy fails
      net: macsec: introduce mdo_insert_tx_tag
      net: phy: nxp-c45-tja11xx: add MACsec support
      net: phy: nxp-c45-tja11xx: add MACsec statistics
      net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag

Rahul Rameshbabu (4):
      net/mlx5: Refactor real time clock operation checks for PHC
      net/mlx5: Initialize clock->ptp_info inside mlx5_init_timer_clock
      net/mlx5: Convert scaled ppm values outside the s32 range for PHC frequency adjustments
      net/mlx5: Query maximum frequency adjustment of the PTP hardware clock

Randy Dunlap (7):
      wifi: cfg80211: fix spelling & punctutation
      wifi: nl80211: fix grammar & spellos
      wifi: mac80211: rx.c: fix sentence grammar
      wifi: mac80211: sta_info.c: fix sentence grammar
      net, xdp: Correct grammar
      net: skbuff: fix spelling errors
      page_pool: fix typos and punctuation

Randy Schacher (1):
      bnxt_en: Rename some macros for the P5 chips

Ravi Gunasekaran (1):
      net: ethernet: ti: davinci_mdio: Update K3 SoCs list for errata i2329

Richard Cochran (1):
      net: ethtool: Refactor identical get_ts_info implementations.

Richard Gobert (3):
      net: gso: add HBH extension header offload support
      net: gro: parse ipv6 ext headers without frag0 invalidation
      selftests/net: fix GRO coalesce test and add ext header coalesce tests

Rob Herring (1):
      dt-bindings: net: marvell,orion-mdio: Drop "reg" sizes schema

Robert Marko (1):
      net: phy: aquantia: add firmware load support

Roger Quadros (10):
      net: ethernet: am65-cpsw: Add standard Ethernet MAC stats to ethtool
      net: ethernet: ti: am65-cpsw: Re-arrange functions to avoid forward declaration
      net: ethernet: am65-cpsw: Set default TX channels to maximum
      net: ethernet: ti: am65-cpsw: Fix error handling in am65_cpsw_nuss_common_open()
      net: ethernet: am65-cpsw: Build am65-cpsw-qos only if required
      net: ethernet: am65-cpsw: Rename TI_AM65_CPSW_TAS to TI_AM65_CPSW_QOS
      net: ethernet: am65-cpsw: cleanup TAPRIO handling
      net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
      net: ethernet: am65-cpsw: Move register definitions to header file
      net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge support

Rohan G Thomas (3):
      net: stmmac: xgmac: EST interrupts handling
      net: stmmac: Refactor EST implementation
      net: stmmac: Add support for EST cycle-time-extension

Rong Yan (1):
      wifi: mt76: mt7921: support 5.9/6GHz channel config in acpi

Russell King (Oracle) (16):
      net: linkmode: add linkmode_fill() helper
      net: phylink: use linkmode_fill()
      net: sfp: use linkmode_*() rather than open coding
      net: phylink: use for_each_set_bit()
      net: phy: add possible interfaces
      net: phy: marvell10g: table driven mactype decode
      net: phy: marvell10g: fill in possible_interfaces
      net: phy: bcm84881: fill in possible_interfaces
      net: phy: aquantia: fill in possible_interfaces for AQR113C
      net: phylink: split out per-interface validation
      net: phylink: pass PHY into phylink_validate_one()
      net: phylink: pass PHY into phylink_validate_mask()
      net: phylink: split out PHY validation from phylink_bringup_phy()
      net: phylink: use the PHY's possible_interfaces if populated
      net: mdio_bus: add refcounting for fwnodes to mdiobus
      net: phylink: move phylink_pcs_neg_mode() into phylink.c

Ryder Lee (1):
      wifi: mt76: add ability to explicitly forbid LED registration with DT

Ryno Swart (2):
      nfp: ethtool: add extended ack report messages
      nfp: devlink: add extended ack report messages

Saeed Mahameed (1):
      net/mlx5e: Use the correct lag ports number when creating TISes

Sarath Babu Naidu Gaddam (1):
      net: axienet: Preparatory changes for dmaengine support

Sean Nyekjaer (1):
      net: dsa: microchip: use DSA_TAG_PROTO without _VALUE define

Sean Wang (1):
      wifi: mt76: mt7921: reduce the size of MCU firmware download Rx queue

Selvin Xavier (1):
      bnxt_en: Allocate extra QP backing store memory when RoCE FW reports it

Sergei Trofimovich (1):
      libbpf: Add pr_warn() for EINVAL cases in linker_sanity_check_elf

Shachar Kagan (1):
      tcp: Revert no longer abort SYN_SENT when receiving some ICMP

Shannon Nelson (9):
      ionic: set ionic ptr before setting up ethtool ops
      ionic: pass opcode to devcmd_wait
      ionic: keep filters across FLR
      ionic: bypass firmware cmds when stuck in reset
      ionic: prevent pci disable of already disabled device
      ionic: no fw read when PCI reset failed
      ionic: use timer_shutdown_sync
      ionic: lif debugfs refresh on reset
      ionic: fill out pci error handlers

Shayne Chen (4):
      wifi: mt76: mt7996: add support for variants with auxiliary RX path
      wifi: mt76: change txpower init to per-phy
      wifi: mt76: mt7996: add txpower setting support
      wifi: mt76: mt7996: introduce mt7996_band_valid()

Shigeru Yoshida (1):
      tipc: Remove redundant call to TLV_SPACE()

Shiji Yang (4):
      wifi: rt2x00: introduce DMA busy check watchdog for rt2800
      wifi: rt2x00: disable RTS threshold for rt2800 by default
      wifi: rt2x00: restart beacon queue when hardware reset
      wifi: rt2x00: correct wrong BBP register in RxDCOC calibration

Shinas Rasheed (23):
      octeon_ep: add padding for small packets
      octeon_ep: remove dma sync in trasmit path
      octeon_ep: implement xmit_more in transmit
      octeon_ep: remove atomic variable usage in Tx data path
      octeon_ep: support Octeon CN10K devices
      octeon_ep: Solve style issues in control net files
      octeon_ep: get max rx packet length from firmware
      octeon_ep: implement device unload control net API
      octeon_ep: support OCTEON CN98 devices
      octeon_ep: set backpressure watermark for RX queues
      octeon_ep: control net API framework to support offloads
      octeon_ep: add PF-VF mailbox communication
      octeon_ep: PF-VF mailbox version support
      octeon_ep: control net framework to support VF offloads
      octeon_ep: support firmware notifications for VFs
      octeon_ep_vf: Add driver framework and device initialization
      octeon_ep_vf: add hardware configuration APIs
      octeon_ep_vf: add VF-PF mailbox communication.
      octeon_ep_vf: add Tx/Rx ring resource setup and cleanup
      octeon_ep_vf: add support for ndo ops
      octeon_ep_vf: add Tx/Rx processing and interrupt support
      octeon_ep_vf: add ethtool support
      octeon_ep_vf: update MAINTAINERS

Shradha Gupta (1):
      net :mana :Add remaining GDMA stats for MANA to ethtool

Shung-Hsi Yu (1):
      bpf: replace register_is_const() with is_reg_const()

Simon Horman (2):
      bpf: Avoid unnecessary use of comma operator in verifier
      i40e: Avoid unnecessary use of comma operator

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Somnath Kotur (1):
      bnxt_en: Fix AGG ring check logic in bnxt_check_rings()

Song Liu (16):
      bpf: Add __bpf_dynptr_data* for in kernel use
      bpf: Factor out helper check_reg_const_str()
      bpf: Introduce KF_ARG_PTR_TO_CONST_STR
      bpf: Add kfunc bpf_get_file_xattr
      bpf, fsverity: Add kfunc bpf_get_fsverity_digest
      Documentation/bpf: Add documentation for filesystem kfuncs
      selftests/bpf: Sort config in alphabetic order
      selftests/bpf: Add tests for filesystem kfuncs
      selftests/bpf: Add test that uses fsverity and xattr to sign a file
      bpf: Let bpf_prog_pack_free handle any pointer
      bpf: Adjust argument names of arch_prepare_bpf_trampoline()
      bpf: Add helpers for trampoline image management
      bpf, x86: Adjust arch_prepare_bpf_trampoline return value
      bpf: Add arch_bpf_trampoline_size()
      bpf: Use arch_bpf_trampoline_size
      x86, bpf: Use bpf_prog_pack for bpf trampoline

Song Yoong Siang (1):
      net: stmmac: Add Tx HWTS support to XDP ZC

Stanislav Fomichev (16):
      bpftool: mark orphaned programs during prog show
      selftests/bpf: update test_offload to use new orphaned property
      xsk: Support tx_metadata_len
      xsk: Add TX timestamp and TX checksum offload support
      tools: ynl: Print xsk-features from the sample
      net/mlx5e: Implement AF_XDP TX timestamp and checksum offload
      xsk: Document tx_metadata_len layout
      xsk: Validate xsk_tx_metadata flags
      xsk: Add option to calculate TX checksum in SW
      selftests/xsk: Support tx_metadata_len
      selftests/bpf: Add csum helpers
      selftests/bpf: Add TX side to xdp_metadata
      selftests/bpf: Convert xdp_hw_metadata to XDP_USE_NEED_WAKEUP
      selftests/bpf: Add TX side to xdp_hw_metadata
      xsk: Add missing SPDX to AF_XDP TX metadata documentation
      selftests/bpf: Make sure we trigger metadata kfuncs for dst 8080

Stanislaw Gruszka (1):
      wifi: rt2x00: make watchdog param per device

StanleyYP Wang (9):
      wifi: mt76: connac: add beacon duplicate TX mode support for mt7996
      wifi: mt76: mt7996: fix alignment of sta info event
      wifi: mt76: mt7915: fix EEPROM offset of TSSI flag on MT7981
      wifi: mt76: mt7915: also MT7981 is 3T3R but nss2 on 5 GHz band
      wifi: mt76: connac: add firmware support for mt7992
      wifi: mt76: mt7996: rework register offsets for mt7992
      wifi: mt76: mt7996: support mt7992 eeprom loading
      wifi: mt76: mt7996: adjust interface num and wtbl size for mt7992
      wifi: mt76: mt7996: add PCI IDs for mt7992

Stefan Eichenberger (1):
      net: mvpp2: add support for mii

Stephen Rothwell (1):
      net: phy: aquantia: switch to crc_itu_t()

Su Hui (15):
      i40e: add an error code check in i40e_vsi_setup
      wifi: mwifiex: mwifiex_process_sleep_confirm_resp(): remove unused priv variable
      wifi: rtlwifi: rtl8821ae: phy: remove some useless code
      wifi: rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior
      wifi: rtlwifi: add calculate_bit_shift()
      wifi: rtlwifi: rtl8821ae: phy: using calculate_bit_shift()
      wifi: rtlwifi: rtl8188ee: phy: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192c: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192cu: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192ce: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192de: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192ee: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192se: using calculate_bit_shift()
      wifi: rtlwifi: rtl8723_common: using calculate_bit_shift()
      wifi: rtlwifi: rtl8723{be,ae}: using calculate_bit_shift()

Sujuan Chen (3):
      wifi: mt76: mt7996: add wed tx support
      wifi: mt76: mt7996: fix the size of struct bss_rate_tlv
      wifi: mt76: mt7996: set DMA mask to 36 bits for boards with more than 4GB of RAM

Suman Ghosh (6):
      octeontx2-af: Add new mbox to support multicast/mirror offload
      octeontx2-pf: TC flower offload support for mirror
      octeontx2-af: Fix multicast/mirror group lock/unlock issue
      octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs
      octeontx2-af: Fix a double free issue
      octeontx2-af: Fix max NPC MCAM entry check while validating ref_entry

Sven Eckelmann (2):
      batman-adv: Switch to linux/sprintf.h
      batman-adv: Switch to linux/array_size.h

Swarup Laxman Kotiaklapudi (1):
      netlink: specs: devlink: add some(not all) missing attributes in devlink.yaml

Swee Leong Ching (4):
      dt-bindings: net: snps,dwmac: per channel irq
      net: stmmac: Make MSI interrupt routine generic
      net: stmmac: Add support for TX/RX channel interrupt
      net: stmmac: Use interrupt mode INTM=1 for per channel irq

Tao Liu (1):
      net/sched: act_ct: fix skb leak and crash on ooo frags

Tariq Toukan (24):
      net/mlx5e: Remove early assignment to netdev->features
      net/mlx5: Add mlx5_ifc bits used for supporting single netdev Socket-Direct
      net/mlx5: Expose Management PCIe Index Register (MPIR)
      net/mlx5: fs, Command to control L2TABLE entry silent mode
      net/mlx5: fs, Command to control TX flow table root
      net/mlx5e: Remove TLS-specific logic in generic create TIS API
      net/mlx5: Move TISes from priv to mdev HW resources
      net/mlx5e: Statify function mlx5e_monitor_counter_arm
      net/mlx5e: Add wrapping for auxiliary_driver ops and remove unused args
      net/mlx5e: Decouple CQ from priv
      net/mlx5: devcom, Add component size getter
      net/mlx5: Fix query of sd_group field
      net/mlx5: SD, Introduce SD lib
      net/mlx5: SD, Implement basic query and instantiation
      net/mlx5: SD, Implement devcom communication and primary election
      net/mlx5: SD, Implement steering for primary and secondaries
      net/mlx5: SD, Add informative prints in kernel log
      net/mlx5e: Create single netdev per SD group
      net/mlx5e: Create EN core HW resources for all secondary devices
      net/mlx5e: Let channels be SD-aware
      net/mlx5e: Support cross-vhca RSS
      net/mlx5e: Support per-mdev queue counter
      net/mlx5e: Block TLS device offload on combined SD netdev
      net/mlx5: Enable SD feature

Thomas Weißschuh (1):
      rfkill: return ENOTTY on invalid ioctl

Tiezhu Yang (1):
      test_bpf: Rename second ALU64_SMOD_X to ALU64_SMOD_K

Tobias Klauser (1):
      indirect_call_wrapper: Fix typo in INDIRECT_CALL_$NR kerneldoc

Tobias Waldekranz (10):
      net: mvmdio: Avoid excessive sleeps in polled mode
      net: mvmdio: Support setting the MDC frequency on XSMI controllers
      net: dsa: mv88e6xxx: Push locking into stats snapshotting
      net: dsa: mv88e6xxx: Create API to read a single stat counter
      net: dsa: mv88e6xxx: Fix mv88e6352_serdes_get_stats error path
      net: dsa: mv88e6xxx: Give each hw stat an ID
      net: dsa: mv88e6xxx: Add "eth-mac" counter group support
      net: dsa: mv88e6xxx: Limit histogram counters to ingress traffic
      net: dsa: mv88e6xxx: Add "rmon" counter group support
      selftests: forwarding: ethtool_rmon: Add histogram counter test

Tushar Vyavahare (1):
      selftests/xsk: Fix for SEND_RECEIVE_UNALIGNED test

Uwe Kleine-König (18):
      ieee802154: fakelb: Convert to platform remove callback returning void
      ieee802154: hwsim: Convert to platform remove callback returning void
      net: ethernet: ti: am65-cpsw: Convert to platform remove callback returning void
      net: ethernet: ti: cpsw: Convert to platform remove callback returning void
      net: ethernet: ti: cpsw-new: Convert to platform remove callback returning void
      net: ethernet: ezchip: Convert to platform remove callback returning void
      wifi: ath11k: Convert to platform remove callback returning void
      wifi: brcmfmac: Convert to platform remove callback returning void
      wifi: ath5k: Convert to platform remove callback returning void
      wifi: wcn36xx: Convert to platform remove callback returning void
      net: ipa: Convert to platform remove callback returning void
      net: fjes: Convert to platform remove callback returning void
      net: pcs: rzn1-miic: Convert to platform remove callback returning void
      net: sfp: Convert to platform remove callback returning void
      net: wan/fsl_ucc_hdlc: Convert to platform remove callback returning void
      net: wan/ixp4xx_hss: Convert to platform remove callback returning void
      net: wwan: qcom_bam_dmux: Convert to platform remove callback returning void
      wifi: mt76: Convert to platform remove callback returning void

Vadim Fedorenko (1):
      ptp_ocp: adjust MAINTAINERS and mailmap

Vegard Nossum (1):
      Documentation: add pyyaml to requirements.txt

Victor Nogueira (9):
      rtnl: add helper to check if a notification is needed
      net: sched: Move drop_reason to struct tc_skb_cb
      net: sched: Make tc-related drop reason more flexible for remaining qdiscs
      net: sched: Add initial TC error skb drop reasons
      net/sched: Introduce tc block netdev tracking infra
      net/sched: cls_api: Expose tc block to the datapath
      net/sched: act_mirred: Create function tcf_mirred_to_dev and improve readability
      net/sched: act_mirred: Add helper function tcf_mirred_replace_dev
      net/sched: act_mirred: Allow mirred to block

Vinayak Yadawad (2):
      wifi: nl80211: Documentation update for NL80211_CMD_PORT_AUTHORIZED event
      wifi: nl80211: Extend del pmksa support for SAE and OWE security

Vincent Whitchurch (1):
      net: phy: adin: allow control of Fast Link Down

Vinicius Costa Gomes (2):
      igc: Simplify setting flags in the TX data descriptor
      igc: Add support for PTP .getcyclesx64()

Vishvambar Panth S (1):
      net: microchip: lan743x : bidirectional throughput improvement

Vladimir Oltean (18):
      net: dsa: microchip: properly support platform_data probing
      net: mdio-mux: show errors on probe failure
      net: mdio-mux: be compatible with parent buses which only support C45
      net: phylink: reimplement population of pl->supported for in-band
      selftests: forwarding: ethtool_mm: support devices with higher rx-min-frag-size
      selftests: forwarding: ethtool_mm: fall back to aggregate if device does not report pMAC stats
      xsk: make struct xsk_cb_desc available outside CONFIG_XDP_SOCKETS
      net: enetc: allow phy-mode = "1000base-x"
      net: dsa: lantiq_gswip: delete irrelevant use of ds->phys_mii_mask
      net: dsa: lantiq_gswip: use devres for internal MDIO bus, not ds->user_mii_bus
      net: dsa: lantiq_gswip: ignore MDIO buses disabled in OF
      net: dsa: qca8k: put MDIO bus OF node on qca8k_mdio_register() failure
      net: dsa: qca8k: skip MDIO bus creation if its OF node has status = "disabled"
      net: dsa: qca8k: assign ds->user_mii_bus only for the non-OF case
      net: dsa: qca8k: consolidate calls to a single devm_of_mdiobus_register()
      net: dsa: qca8k: use "dev" consistently within qca8k_mdio_register()
      net: dsa: bcm_sf2: stop assigning an OF node to the ds->user_mii_bus
      net: dsa: bcm_sf2: drop priv->master_mii_dn

Wang Jinchao (2):
      hv_netvsc: remove duplicated including of slab.h
      octeontx2-af: insert space after include

Wang Zhao (1):
      wifi: mt76: mt7921s: fix workqueue problem causes STA association fail

Wen Gu (10):
      net/smc: rename some 'fce' to 'fce_v2x' for clarity
      net/smc: introduce sub-functions for smc_clc_send_confirm_accept()
      net/smc: unify the structs of accept or confirm message for v1 and v2
      net/smc: support SMCv2.x supplemental features negotiation
      net/smc: introduce virtual ISM device support feature
      net/smc: define a reserved CHID range for virtual ISM devices
      net/smc: compatible with 128-bits extended GID of virtual ISM device
      net/smc: support extended GID in SMC-D lgr netlink attribute
      net/smc: disable SEID on non-s390 archs where virtual ISM may be used
      net/smc: manage system EID in SMC stack instead of ISM driver

Willem de Bruijn (1):
      selftests: net: verify fq per-band packet limit

Wu Yunchuan (2):
      wifi: ath9k: Remove unnecessary (void*) conversions
      wifi: mt76: Remove unnecessary (void*) conversions

Yafang Shao (10):
      compiler-gcc: Suppress -Wmissing-prototypes warning for all supported GCC
      bpf: Add a new kfunc for cgroup1 hierarchy
      selftests/bpf: Fix issues in setup_classid_environment()
      selftests/bpf: Add parallel support for classid
      selftests/bpf: Add a new cgroup helper get_classid_cgroup_id()
      selftests/bpf: Add a new cgroup helper get_cgroup_hierarchy_id()
      selftests/bpf: Add selftests for cgroup1 hierarchy
      bpf: Enable bpf_cgrp_storage for cgroup1 non-attach case
      selftests/bpf: Add a new cgroup helper open_classid()
      selftests/bpf: Add selftests for cgroup1 local storage

Yan Zhai (1):
      packet: add a generic drop reason for receive

Yang Li (3):
      wifi: ath11k: Remove unneeded semicolon
      wifi: rt2x00: Simplify bool conversion
      bpf: Remove unused backtrack_state helper functions

Yi-Chen Chen (1):
      wifi: rtw89: phy: dynamically adjust EDCCA threshold

Yi-Chia Hsieh (1):
      wifi: mt76: mt7996: fix uninitialized variable in parsing txfree

YiFei Zhu (1):
      selftests/bpf: Relax time_tai test for equal timestamps in tai_forward

Yinjun Zhang (3):
      nfp: add ethtool flow steering callbacks
      nfp: offload flow steering to the nfp
      nfp: ethtool: expose transmit SO_TIMESTAMPING capability

Yonghong Song (15):
      libbpf: Fix potential uninitialized tail padding with LIBBPF_OPTS_RESET
      bpf: Use named fields for certain bpf uapi structs
      selftests/bpf: Fix pyperf180 compilation failure with clang18
      bpf: Fix a few selftest failures due to llvm18 change
      bpf: Fix a race condition between btf_put() and map_free()
      selftests/bpf: Remove flaky test_btf_id test
      bpf: Avoid unnecessary extra percpu memory allocation
      bpf: Add objcg to bpf_mem_alloc
      bpf: Allow per unit prefill for non-fix-size percpu memory allocator
      bpf: Refill only one percpu element in memalloc
      bpf: Use smaller low/high marks for percpu allocation
      bpf: Limit up to 512 bytes for bpf_global_percpu_ma allocation
      selftests/bpf: Cope with 512 bytes limit with bpf_global_percpu_ma
      selftests/bpf: Add a selftest with > 512-byte percpu allocation size
      bpf: Remove unnecessary cpu == 0 check in memalloc

Yoshihiro Shimoda (9):
      net: rswitch: Drop unused argument/return value
      net: rswitch: Use unsigned int for desc related array index
      net: rswitch: Use build_skb() for RX
      net: rswitch: Add unmap_addrs instead of dma address in each desc
      net: rswitch: Add a setting ext descriptor function
      net: rswitch: Set GWMDNC register
      net: rswitch: Add jumbo frames handling for RX
      net: rswitch: Add jumbo frames handling for TX
      net: rswitch: Allow jumbo frames

Yu Xiao (1):
      nfp: ethtool: support TX/RX pause frame on/off

Yujie Liu (2):
      bpf/tests: Remove duplicate JSGT tests
      selftests/net: change shebang to bash to support "source"

Yuran Pereira (7):
      selftests/bpf: Convert CHECK macros to ASSERT_* macros in bpf_iter
      selftests/bpf: Add malloc failure checks in bpf_iter
      selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in bpf_tcp_ca
      selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in bind_perm
      selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in bpf_obj_id
      selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in vmlinux
      Bluetooth: Add documentation to exported functions in lib

Zenm Chen (1):
      wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU devices

Zheng tan (1):
      wifi: mac80211: fix spelling typo in comment

Zhengchao Shao (6):
      bonding: return -ENOMEM instead of BUG in alb_upper_dev_walk
      bonding: remove print in bond_verify_device_path
      macvlan: implement .parse_protocol hook function in macvlan_hard_header_ops
      ipvlan: implement .parse_protocol hook function in ipvlan_header_ops
      fib: remove unnecessary input parameters in fib_default_rule_add
      fib: rules: remove repeated assignment in fib_nl2rule

Zijun Hu (3):
      Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066
      Bluetooth: hci_conn: Check non NULL function before calling for HFP offload
      Bluetooth: qca: Support HFP offload for QCA2066

Zong-Zhe Yang (10):
      wifi: rtw89: configure PPDU max user by chip
      wifi: rtw89: pci: reset BDRAM according to chip gen
      wifi: rtw89: pci: stop/start DMA for level 1 recovery according to chip gen
      wifi: rtw89: acpi: process 6 GHz band policy from DSM
      wifi: rtw89: regd: handle policy of 6 GHz according to BIOS
      wifi: rtw89: regd: update regulatory map to R65-R44
      wifi: rtw89: refine element naming used by queue empty check
      wifi: rtw89: mac: check queue empty according to chip gen
      wifi: rtw89: 8922a: configure CRASH_TRIGGER FW feature
      wifi: rtw89: fw: extend program counter dump for Wi-Fi 7 chip

clancy shang (1):
      Bluetooth: hci_sync: fix BR/EDR wakeup bug

duanqiangwen (1):
      net: wangxun: fix changing mac failed when running

justinstitt@google.com (4):
      ethtool: Implement ethtool_puts()
      checkpatch: add ethtool_sprintf rules
      net: Convert some ethtool_sprintf() to ethtool_puts()
      net: ena: replace deprecated strncpy with strscpy

liyouhong (1):
      ppp: Fix spelling typo in comment in ppp_async_encode()

 .mailmap                                           |    3 +
 Documentation/Makefile                             |   16 +-
 Documentation/admin-guide/sysctl/net.rst           |    5 +-
 Documentation/bpf/cpumasks.rst                     |    2 +-
 Documentation/bpf/fs_kfuncs.rst                    |   21 +
 Documentation/bpf/index.rst                        |    1 +
 Documentation/bpf/kfuncs.rst                       |   24 +
 Documentation/dev-tools/kunit/usage.rst            |   12 +-
 Documentation/devicetree/bindings/net/dsa/dsa.yaml |    6 +
 .../bindings/net/dsa/marvell,mv88e6060.yaml        |   88 +
 .../bindings/net/dsa/marvell,mv88e6xxx.yaml        |  337 +
 .../devicetree/bindings/net/dsa/marvell.txt        |  109 -
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml |   34 +-
 .../devicetree/bindings/net/ethernet-switch.yaml   |   23 +-
 .../devicetree/bindings/net/lantiq,pef2256.yaml    |  213 +
 .../devicetree/bindings/net/marvell,aquantia.yaml  |  116 +
 .../devicetree/bindings/net/marvell,mvusb.yaml     |    7 +-
 .../bindings/net/marvell,orion-mdio.yaml           |   22 -
 .../devicetree/bindings/net/qcom,ipa.yaml          |   24 +-
 .../devicetree/bindings/net/renesas,etheravb.yaml  |    3 +-
 .../devicetree/bindings/net/renesas,ethertsn.yaml  |  133 +
 .../devicetree/bindings/net/xlnx,axi-ethernet.yaml |   16 +
 Documentation/driver-api/index.rst                 |    1 +
 Documentation/driver-api/wbrf.rst                  |   78 +
 Documentation/netlink/netlink-raw.yaml             |   68 +-
 Documentation/netlink/specs/devlink.yaml           |  392 +-
 Documentation/netlink/specs/dpll.yaml              |   11 +
 Documentation/netlink/specs/ethtool.yaml           |    4 +
 .../netlink/specs/{mptcp.yaml => mptcp_pm.yaml}    |    0
 Documentation/netlink/specs/netdev.yaml            |  289 +-
 Documentation/netlink/specs/ovs_datapath.yaml      |    3 +-
 Documentation/netlink/specs/ovs_flow.yaml          |    7 +-
 Documentation/netlink/specs/ovs_vport.yaml         |    4 -
 Documentation/netlink/specs/rt_link.yaml           |  449 +-
 Documentation/netlink/specs/tc.yaml                | 2031 +++++
 Documentation/networking/bridge.rst                |  334 +-
 .../device_drivers/ethernet/amazon/ena.rst         |    1 +
 .../device_drivers/ethernet/intel/ice.rst          |  141 +
 .../device_drivers/ethernet/marvell/octeon_ep.rst  |    5 +
 .../networking/device_drivers/wifi/index.rst       |    1 -
 .../networking/device_drivers/wifi/ray_cs.rst      |  165 -
 .../networking/devlink/devlink-reload.rst          |   13 +-
 Documentation/networking/devlink/ice.rst           |    9 +
 Documentation/networking/ethtool-netlink.rst       |   12 +-
 Documentation/networking/index.rst                 |    3 +
 Documentation/networking/net_cachelines/index.rst  |   16 +
 .../net_cachelines/inet_connection_sock.rst        |   50 +
 .../networking/net_cachelines/inet_sock.rst        |   44 +
 .../networking/net_cachelines/net_device.rst       |  178 +
 .../net_cachelines/netns_ipv4_sysctl.rst           |  158 +
 Documentation/networking/net_cachelines/snmp.rst   |  135 +
 .../networking/net_cachelines/tcp_sock.rst         |  157 +
 Documentation/networking/netlink_spec/.gitignore   |    1 +
 Documentation/networking/netlink_spec/readme.txt   |    4 +
 Documentation/networking/page_pool.rst             |   10 +-
 Documentation/networking/scaling.rst               |   15 +
 Documentation/networking/smc-sysctl.rst            |   14 +
 Documentation/networking/timestamping.rst          |    3 +-
 Documentation/networking/xdp-rx-metadata.rst       |   10 +-
 Documentation/networking/xsk-tx-metadata.rst       |   81 +
 Documentation/sphinx/requirements.txt              |    1 +
 Documentation/userspace-api/netlink/index.rst      |    4 +-
 Documentation/userspace-api/netlink/intro.rst      |    4 +
 .../userspace-api/netlink/netlink-raw.rst          |   96 +-
 Documentation/userspace-api/netlink/specs.rst      |    2 +-
 MAINTAINERS                                        |   78 +-
 arch/arm64/net/bpf_jit_comp.c                      |   55 +-
 arch/loongarch/configs/loongson3_defconfig         |    2 -
 arch/mips/configs/ip22_defconfig                   |    1 -
 arch/mips/configs/malta_defconfig                  |    1 -
 arch/mips/configs/malta_kvm_defconfig              |    1 -
 arch/mips/configs/maltaup_xpa_defconfig            |    1 -
 arch/mips/configs/rb532_defconfig                  |    1 -
 arch/powerpc/configs/ppc6xx_defconfig              |    1 -
 arch/riscv/include/asm/cfi.h                       |    3 +-
 arch/riscv/kernel/cfi.c                            |    2 +-
 arch/riscv/net/bpf_jit_comp64.c                    |   25 +-
 arch/s390/configs/debug_defconfig                  |    1 -
 arch/s390/configs/defconfig                        |    1 -
 arch/s390/net/bpf_jit_comp.c                       |   61 +-
 arch/sh/configs/titan_defconfig                    |    1 -
 arch/x86/include/asm/cfi.h                         |  126 +-
 arch/x86/kernel/alternative.c                      |   87 +-
 arch/x86/kernel/cfi.c                              |    4 +-
 arch/x86/net/bpf_jit_comp.c                        |  311 +-
 drivers/atm/atmtcp.c                               |    1 +
 drivers/atm/eni.c                                  |    1 +
 drivers/atm/idt77105.c                             |    1 +
 drivers/atm/iphase.c                               |    1 +
 drivers/atm/nicstar.c                              |    1 +
 drivers/atm/suni.c                                 |    1 +
 drivers/base/firmware_loader/sysfs_upload.c        |    1 +
 drivers/bcma/driver_pci_host.c                     |    2 +-
 drivers/bluetooth/btintel.c                        |    5 +
 drivers/bluetooth/btintel.h                        |    4 +-
 drivers/bluetooth/btmtkuart.c                      |   11 +-
 drivers/bluetooth/btnxpuart.c                      |    8 +-
 drivers/bluetooth/btusb.c                          |    6 +
 drivers/bluetooth/hci_qca.c                        |   23 +
 drivers/connector/connector.c                      |    5 +-
 drivers/dpll/dpll_core.c                           |    8 +-
 drivers/dpll/dpll_netlink.c                        |   40 +-
 drivers/net/Kconfig                                |    1 +
 drivers/net/bonding/bond_alb.c                     |    3 +-
 drivers/net/bonding/bond_main.c                    |   29 +-
 drivers/net/dsa/bcm_sf2.c                          |    7 +-
 drivers/net/dsa/bcm_sf2.h                          |    1 -
 drivers/net/dsa/lantiq_gswip.c                     |   74 +-
 drivers/net/dsa/microchip/ksz8.h                   |    4 +
 drivers/net/dsa/microchip/ksz8795.c                |  152 +-
 drivers/net/dsa/microchip/ksz8795_reg.h            |    3 +
 drivers/net/dsa/microchip/ksz_common.c             |   34 +-
 drivers/net/dsa/microchip/ksz_common.h             |   21 +-
 drivers/net/dsa/mt7530.c                           |    2 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |  392 +-
 drivers/net/dsa/mv88e6xxx/chip.h                   |   31 +-
 drivers/net/dsa/mv88e6xxx/global1.c                |    7 +-
 drivers/net/dsa/mv88e6xxx/serdes.c                 |   10 +-
 drivers/net/dsa/mv88e6xxx/serdes.h                 |    8 +-
 drivers/net/dsa/qca/qca8k-8xxx.c                   |   47 +-
 drivers/net/dsa/qca/qca8k-common.c                 |    2 +-
 drivers/net/dsa/qca/qca8k-leds.c                   |    4 +-
 drivers/net/dsa/qca/qca8k.h                        |    1 +
 drivers/net/dsa/realtek/rtl8365mb.c                |    2 +-
 drivers/net/dsa/realtek/rtl8366-core.c             |    2 +-
 drivers/net/dsa/realtek/rtl8366rb.c                |   59 +-
 drivers/net/dsa/sja1105/sja1105_main.c             |    3 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c             |    8 +-
 drivers/net/ethernet/amazon/ena/Makefile           |    2 +-
 drivers/net/ethernet/amazon/ena/ena_ethtool.c      |   50 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |  693 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.h       |   99 +-
 drivers/net/ethernet/amazon/ena/ena_xdp.c          |  468 ++
 drivers/net/ethernet/amazon/ena/ena_xdp.h          |  151 +
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       |   33 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h               |    2 +-
 .../net/ethernet/aquantia/atlantic/aq_ethtool.c    |   31 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c    |   28 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |   61 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h   |   22 +-
 drivers/net/ethernet/aquantia/atlantic/aq_vec.c    |   23 +-
 drivers/net/ethernet/asix/ax88796c_main.c          |    2 +-
 drivers/net/ethernet/asix/ax88796c_main.h          |    8 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    |   25 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          | 2757 +++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |  502 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c  |   10 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  733 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h      |  521 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |   38 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h      |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c    |    8 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |   10 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h      |    4 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |   37 +-
 drivers/net/ethernet/broadcom/tg3.c                |   22 +-
 drivers/net/ethernet/brocade/bna/bnad_ethtool.c    |    2 +-
 drivers/net/ethernet/cadence/macb.h                |   15 +-
 drivers/net/ethernet/cadence/macb_main.c           |   42 +-
 drivers/net/ethernet/cadence/macb_ptp.c            |   28 +-
 .../net/ethernet/cavium/thunder/nicvf_ethtool.c    |   31 +-
 drivers/net/ethernet/chelsio/cxgb3/adapter.h       |    2 +-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    |    9 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c |   24 +-
 drivers/net/ethernet/cisco/enic/enic_ethtool.c     |   25 +-
 drivers/net/ethernet/cortina/gemini.c              |   15 +-
 drivers/net/ethernet/dlink/dl2k.c                  |    3 +-
 drivers/net/ethernet/emulex/benet/be_ethtool.c     |   28 +-
 drivers/net/ethernet/ezchip/nps_enet.c             |    6 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |  132 +-
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   |   31 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |    3 +
 drivers/net/ethernet/freescale/fec_main.c          |    4 +-
 .../net/ethernet/fungible/funeth/funeth_ethtool.c  |   48 +-
 drivers/net/ethernet/google/gve/gve.h              |    8 +-
 drivers/net/ethernet/google/gve/gve_adminq.c       |   88 +-
 drivers/net/ethernet/google/gve/gve_adminq.h       |    3 +-
 drivers/net/ethernet/google/gve/gve_dqo.h          |    3 +
 drivers/net/ethernet/google/gve/gve_ethtool.c      |    2 +-
 drivers/net/ethernet/google/gve/gve_main.c         |   17 +-
 drivers/net/ethernet/google/gve/gve_register.h     |    9 +
 drivers/net/ethernet/google/gve/gve_rx.c           |   17 +-
 drivers/net/ethernet/google/gve/gve_tx.c           |    2 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       |   37 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |    2 +-
 .../net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c    |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |   82 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   23 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |   21 +-
 drivers/net/ethernet/huawei/hinic/hinic_ethtool.c  |   40 +-
 drivers/net/ethernet/intel/Kconfig                 |   11 +
 drivers/net/ethernet/intel/e1000/e1000_hw.c        |   46 +-
 drivers/net/ethernet/intel/e1000e/80003es2lan.c    |   23 +-
 drivers/net/ethernet/intel/e1000e/82571.c          |    3 +-
 drivers/net/ethernet/intel/e1000e/defines.h        |    3 -
 drivers/net/ethernet/intel/e1000e/ethtool.c        |    7 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |   18 +-
 drivers/net/ethernet/intel/e1000e/mac.c            |   20 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |   11 +-
 drivers/net/ethernet/intel/e1000e/phy.c            |   24 +-
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c   |   26 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c        |    7 +-
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c        |   10 +-
 drivers/net/ethernet/intel/i40e/i40e.h             |  164 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.c      |  229 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.h      |    7 -
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  214 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb.c         |  285 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c      |   32 +-
 drivers/net/ethernet/intel/i40e/i40e_ddp.c         |    4 +-
 drivers/net/ethernet/intel/i40e/i40e_debug.h       |    1 +
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |   10 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  304 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  731 +-
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |   24 +-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   70 +
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |   36 +-
 drivers/net/ethernet/intel/i40e/i40e_register.h    |   11 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   90 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |    8 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h        |   51 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   81 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |    1 +
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |    3 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |    5 +-
 drivers/net/ethernet/intel/iavf/iavf_adminq.c      |   86 +-
 drivers/net/ethernet/intel/iavf/iavf_adminq.h      |    7 -
 drivers/net/ethernet/intel/iavf/iavf_adv_rss.c     |    8 +-
 drivers/net/ethernet/intel/iavf/iavf_adv_rss.h     |    3 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c      |   42 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  101 +-
 drivers/net/ethernet/intel/iavf/iavf_fdir.c        |    3 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   27 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c        |   21 +-
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |   41 +
 drivers/net/ethernet/intel/ice/Makefile            |    5 +-
 drivers/net/ethernet/intel/ice/ice.h               |   30 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |  207 +-
 drivers/net/ethernet/intel/ice/ice_base.c          |   65 +-
 drivers/net/ethernet/intel/ice/ice_base.h          |    4 +-
 drivers/net/ethernet/intel/ice/ice_common.c        |  330 +-
 drivers/net/ethernet/intel/ice/ice_common.h        |    4 +-
 drivers/net/ethernet/intel/ice/ice_dcb.c           |   79 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c       |    2 +-
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c        |    2 +-
 drivers/net/ethernet/intel/ice/ice_debugfs.c       |  667 ++
 drivers/net/ethernet/intel/ice/ice_devlink.c       |   49 +
 drivers/net/ethernet/intel/ice/ice_devlink.h       |    1 +
 drivers/net/ethernet/intel/ice/ice_dpll.c          |   26 -
 drivers/net/ethernet/intel/ice/ice_eswitch.c       |  568 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.h       |   22 +-
 drivers/net/ethernet/intel/ice/ice_eswitch_br.c    |   22 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  116 +-
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c  |   51 +-
 drivers/net/ethernet/intel/ice/ice_fdir.c          |   69 +-
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c     |   52 +-
 drivers/net/ethernet/intel/ice/ice_flex_pipe.h     |    4 +-
 drivers/net/ethernet/intel/ice/ice_flex_type.h     |    7 +
 drivers/net/ethernet/intel/ice/ice_flow.c          |  482 +-
 drivers/net/ethernet/intel/ice/ice_flow.h          |   60 +-
 drivers/net/ethernet/intel/ice/ice_fwlog.c         |  470 ++
 drivers/net/ethernet/intel/ice/ice_fwlog.h         |   79 +
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h    |    6 +
 drivers/net/ethernet/intel/ice/ice_hwmon.c         |  126 +
 drivers/net/ethernet/intel/ice/ice_hwmon.h         |   15 +
 drivers/net/ethernet/intel/ice/ice_lag.c           |    7 +-
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h     |  412 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |  320 +-
 drivers/net/ethernet/intel/ice/ice_lib.h           |    4 +
 drivers/net/ethernet/intel/ice/ice_main.c          |  333 +-
 drivers/net/ethernet/intel/ice/ice_nvm.c           |   15 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |  319 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h           |   27 +-
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h    |   12 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        |  444 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h        |   49 +-
 drivers/net/ethernet/intel/ice/ice_repr.c          |  195 +-
 drivers/net/ethernet/intel/ice/ice_repr.h          |    9 +-
 drivers/net/ethernet/intel/ice/ice_sched.c         |    3 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c         |   85 +-
 drivers/net/ethernet/intel/ice/ice_switch.c        |  100 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c        |   45 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |   25 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h          |   32 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c      |  207 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h      |   18 +-
 drivers/net/ethernet/intel/ice/ice_type.h          |   42 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |   44 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h        |    3 +-
 .../net/ethernet/intel/ice/ice_vf_lib_private.h    |    1 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |  107 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h      |    1 +
 .../ethernet/intel/ice/ice_virtchnl_allowlist.c    |    1 +
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c |   48 +-
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c  |   41 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c           |   17 +-
 drivers/net/ethernet/intel/idpf/idpf.h             |    7 +-
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c     |   53 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |   65 +
 .../net/ethernet/intel/idpf/idpf_singleq_txrx.c    |    7 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |   70 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |    2 +
 drivers/net/ethernet/intel/igb/e1000_82575.c       |   29 +-
 drivers/net/ethernet/intel/igb/e1000_i210.c        |   19 +-
 drivers/net/ethernet/intel/igb/e1000_mac.c         |    8 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c         |   18 +-
 drivers/net/ethernet/intel/igb/e1000_phy.c         |   17 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |   44 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   13 +-
 drivers/net/ethernet/intel/igbvf/mbx.c             |    1 +
 drivers/net/ethernet/intel/igbvf/netdev.c          |   33 +-
 drivers/net/ethernet/intel/igc/igc.h               |   21 +-
 drivers/net/ethernet/intel/igc/igc_base.c          |    6 +-
 drivers/net/ethernet/intel/igc/igc_base.h          |    4 +
 drivers/net/ethernet/intel/igc/igc_defines.h       |    2 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   33 +-
 drivers/net/ethernet/intel/igc/igc_i225.c          |    6 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   75 +-
 drivers/net/ethernet/intel/igc/igc_phy.c           |    5 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c           |   50 +-
 drivers/net/ethernet/intel/igc/igc_regs.h          |    5 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c     |   38 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c     |   61 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    |  175 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |   42 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c      |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   44 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c       |   34 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h       |    1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c       |  113 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h       |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |   11 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      |   43 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c      |   52 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |  167 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c       |   27 +-
 drivers/net/ethernet/marvell/mvmdio.c              |   97 +-
 drivers/net/ethernet/marvell/mvneta.c              |   25 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  102 +-
 drivers/net/ethernet/marvell/octeon_ep/Makefile    |    3 +-
 .../net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c |   84 +-
 .../net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c |  925 +++
 .../net/ethernet/marvell/octeon_ep/octep_config.h  |   48 +-
 .../ethernet/marvell/octeon_ep/octep_ctrl_mbox.h   |    4 +-
 .../ethernet/marvell/octeon_ep/octep_ctrl_net.c    |   86 +-
 .../ethernet/marvell/octeon_ep/octep_ctrl_net.h    |  173 +-
 .../net/ethernet/marvell/octeon_ep/octep_main.c    |  241 +-
 .../net/ethernet/marvell/octeon_ep/octep_main.h    |   65 +-
 .../ethernet/marvell/octeon_ep/octep_pfvf_mbox.c   |  449 ++
 .../ethernet/marvell/octeon_ep/octep_pfvf_mbox.h   |  167 +
 .../marvell/octeon_ep/octep_regs_cn9k_pf.h         |   13 +
 .../marvell/octeon_ep/octep_regs_cnxk_pf.h         |  416 +
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c  |   12 +-
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.h  |   34 +-
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.c  |    5 +-
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.h  |   99 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |   74 +
 drivers/net/ethernet/marvell/octeontx2/af/npc.h    |    2 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |    9 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   42 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_cn10k.c  |    9 +
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |   25 +
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |   82 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  726 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  102 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |   96 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_reg.h    |    2 +
 .../net/ethernet/marvell/octeontx2/af/rvu_struct.h |   17 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |   80 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |  127 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |    5 +-
 drivers/net/ethernet/mediatek/mtk_wed.c            |   10 +-
 drivers/net/ethernet/mediatek/mtk_wed_wo.c         |    3 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |   40 +-
 .../net/ethernet/mellanox/mlx5/core/diag/crdump.c  |    5 +-
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c     |  103 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   35 +-
 .../ethernet/mellanox/mlx5/core/en/monitor_stats.c |    2 +-
 .../ethernet/mellanox/mlx5/core/en/monitor_stats.h |    1 -
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |   16 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h   |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c   |    9 +-
 .../net/ethernet/mellanox/mlx5/core/en/rep/tc.c    |   14 +
 .../ethernet/mellanox/mlx5/core/en/tc/act/pedit.c  |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/trap.c  |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |   87 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h   |   11 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/setup.c |    4 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/tx.c    |   17 +-
 .../net/ethernet/mellanox/mlx5/core/en_common.c    |   74 +
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   43 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  162 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   36 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   24 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.h    |    2 -
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |   34 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h   |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |    2 +-
 .../net/ethernet/mellanox/mlx5/core/fs_counters.c  |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |   32 +-
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |   19 +-
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h  |    2 +
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c |    7 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |   78 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   |    7 +
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   20 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |   10 +
 .../mellanox/mlx5/core/steering/dr_action.c        |    8 +-
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |   26 +-
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c   |    6 +-
 drivers/net/ethernet/mellanox/mlxsw/cmd.h          |   11 +
 drivers/net/ethernet/mellanox/mlxsw/core.c         |    7 +
 drivers/net/ethernet/mellanox/mlxsw/core.h         |    9 +
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |  119 +-
 drivers/net/ethernet/mellanox/mlxsw/reg.h          |  103 +-
 drivers/net/ethernet/mellanox/mlxsw/resources.h    |    2 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |   28 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |   21 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c |  853 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |   20 +-
 drivers/net/ethernet/microchip/lan743x_ethtool.c   |   35 +-
 drivers/net/ethernet/microchip/lan743x_main.h      |    2 +-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |    2 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |   76 +-
 drivers/net/ethernet/microsoft/mana/hw_channel.c   |    1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   51 +-
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c |   73 +-
 .../net/ethernet/netronome/nfp/flower/lag_conf.c   |   13 +-
 drivers/net/ethernet/netronome/nfp/nfd3/dp.c       |    9 +-
 drivers/net/ethernet/netronome/nfp/nfdk/dp.c       |    9 +-
 drivers/net/ethernet/netronome/nfp/nfp_devlink.c   |    8 +-
 drivers/net/ethernet/netronome/nfp/nfp_net.h       |   40 +-
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |  199 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h  |   16 +
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   |  537 +-
 .../net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h   |    6 +
 .../ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c   |   90 +-
 drivers/net/ethernet/pensando/ionic/ionic.h        |    2 -
 .../net/ethernet/pensando/ionic/ionic_bus_pci.c    |   43 +-
 .../net/ethernet/pensando/ionic/ionic_debugfs.c    |    3 +
 drivers/net/ethernet/pensando/ionic/ionic_dev.c    |   64 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |    8 +-
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |   26 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |  110 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.h    |    5 +
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |   44 +-
 drivers/net/ethernet/pensando/ionic/ionic_stats.c  |    4 +-
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |   10 +-
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |   32 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c  |   12 +-
 drivers/net/ethernet/realtek/Kconfig               |    7 +
 drivers/net/ethernet/realtek/Makefile              |    3 +-
 drivers/net/ethernet/realtek/r8169.h               |    7 +
 drivers/net/ethernet/realtek/r8169_firmware.c      |    3 -
 drivers/net/ethernet/realtek/r8169_leds.c          |  157 +
 drivers/net/ethernet/realtek/r8169_main.c          |  216 +-
 drivers/net/ethernet/renesas/Kconfig               |   12 +-
 drivers/net/ethernet/renesas/Makefile              |    5 +-
 drivers/net/ethernet/renesas/rcar_gen4_ptp.c       |   40 +-
 drivers/net/ethernet/renesas/rcar_gen4_ptp.h       |    9 +-
 drivers/net/ethernet/renesas/rswitch.c             |  381 +-
 drivers/net/ethernet/renesas/rswitch.h             |   43 +-
 drivers/net/ethernet/sfc/ef10.c                    |    4 +-
 drivers/net/ethernet/sfc/ef100_ethtool.c           |    3 +-
 drivers/net/ethernet/sfc/efx.c                     |   24 +-
 drivers/net/ethernet/sfc/ethtool.c                 |    3 +-
 drivers/net/ethernet/sfc/ethtool_common.c          |  126 +-
 drivers/net/ethernet/sfc/ethtool_common.h          |   13 +-
 drivers/net/ethernet/sfc/falcon/ethtool.c          |   26 +-
 drivers/net/ethernet/sfc/net_driver.h              |    2 +-
 drivers/net/ethernet/sfc/ptp.c                     |   30 +-
 drivers/net/ethernet/sfc/ptp.h                     |    7 +-
 drivers/net/ethernet/sfc/siena/efx.c               |   24 +-
 drivers/net/ethernet/sfc/siena/ethtool.c           |    3 +-
 drivers/net/ethernet/sfc/siena/ethtool_common.c    |  126 +-
 drivers/net/ethernet/sfc/siena/ethtool_common.h    |   13 +-
 drivers/net/ethernet/sfc/siena/net_driver.h        |    2 +-
 drivers/net/ethernet/sfc/siena/ptp.c               |   30 +-
 drivers/net/ethernet/sfc/siena/ptp.h               |    7 +-
 drivers/net/ethernet/sfc/siena/siena.c             |    2 +-
 drivers/net/ethernet/socionext/netsec.c            |    2 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |    2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   39 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |   13 +
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c       |  137 -
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h       |   51 -
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   16 -
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |   53 -
 drivers/net/ethernet/stmicro/stmmac/hwif.c         |   21 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   37 +-
 drivers/net/ethernet/stmicro/stmmac/mmc.h          |   14 +
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c     |  117 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   13 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c   |  165 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h   |   64 +
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   50 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  123 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   91 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |    4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |    8 +-
 drivers/net/ethernet/ti/Kconfig                    |   14 +-
 drivers/net/ethernet/ti/Makefile                   |    3 +-
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c        |  272 +
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  276 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.h           |    9 +
 drivers/net/ethernet/ti/am65-cpsw-qos.c            |  708 +-
 drivers/net/ethernet/ti/am65-cpsw-qos.h            |  186 +
 drivers/net/ethernet/ti/cpsw.c                     |   15 +-
 drivers/net/ethernet/ti/cpsw_new.c                 |   15 +-
 drivers/net/ethernet/ti/davinci_mdio.c             |   16 +-
 drivers/net/ethernet/toshiba/ps3_gelic_net.c       |  177 +-
 drivers/net/ethernet/toshiba/ps3_gelic_net.h       |   24 +-
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c    |  238 +-
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.h    |   27 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |  275 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h         |    1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |  154 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h        |    3 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |   94 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c   |   82 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c      |   86 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c      |  114 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.h      |    1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h      |    7 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c |   82 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |   63 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |   57 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h    |   15 +-
 drivers/net/ethernet/xilinx/Kconfig                |    1 +
 drivers/net/ethernet/xilinx/xilinx_axienet.h       |   35 +
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |  667 +-
 drivers/net/fjes/fjes_main.c                       |    6 +-
 drivers/net/geneve.c                               |   24 +-
 drivers/net/hyperv/netvsc_drv.c                    |   36 +-
 drivers/net/hyperv/rndis_filter.c                  |    1 -
 drivers/net/ieee802154/fakelb.c                    |    5 +-
 drivers/net/ieee802154/mac802154_hwsim.c           |    6 +-
 drivers/net/ipa/Makefile                           |    4 +-
 drivers/net/ipa/data/ipa_data-v5.5.c               |  487 ++
 drivers/net/ipa/gsi_reg.c                          |    1 +
 drivers/net/ipa/ipa_data.h                         |    1 +
 drivers/net/ipa/ipa_main.c                         |   42 +-
 drivers/net/ipa/ipa_mem.c                          |    2 +-
 drivers/net/ipa/ipa_reg.c                          |    6 +-
 drivers/net/ipa/ipa_reg.h                          |  111 +-
 drivers/net/ipa/ipa_version.h                      |    1 +
 drivers/net/ipa/reg/ipa_reg-v5.5.c                 |  565 ++
 drivers/net/ipvlan/ipvlan_main.c                   |   15 +-
 drivers/net/macsec.c                               |  151 +-
 drivers/net/macvlan.c                              |   15 +-
 drivers/net/mdio/mdio-bcm-unimac.c                 |   21 +-
 drivers/net/mdio/mdio-gpio.c                       |    4 +-
 drivers/net/mdio/mdio-mux-bcm-iproc.c              |    6 +-
 drivers/net/mdio/mdio-mux.c                        |   14 +-
 drivers/net/netdevsim/macsec.c                     |    5 -
 drivers/net/pcs/pcs-rzn1-miic.c                    |    6 +-
 drivers/net/phy/Kconfig                            |   37 +-
 drivers/net/phy/Makefile                           |   19 +-
 drivers/net/phy/adin.c                             |   53 +
 drivers/net/phy/aquantia.h                         |   16 -
 drivers/net/phy/aquantia/Kconfig                   |    6 +
 drivers/net/phy/aquantia/Makefile                  |    6 +
 drivers/net/phy/aquantia/aquantia.h                |  122 +
 drivers/net/phy/aquantia/aquantia_firmware.c       |  374 +
 drivers/net/phy/{ => aquantia}/aquantia_hwmon.c    |   14 -
 drivers/net/phy/{ => aquantia}/aquantia_main.c     |  137 +-
 drivers/net/phy/at803x.c                           | 1124 +--
 drivers/net/phy/ax88796b_rust.rs                   |  135 +
 drivers/net/phy/bcm-phy-ptp.c                      |   15 +-
 drivers/net/phy/bcm54140.c                         |   16 +-
 drivers/net/phy/bcm84881.c                         |   12 +
 drivers/net/phy/broadcom.c                         |    2 +
 drivers/net/phy/dp83640.c                          |   24 +-
 drivers/net/phy/dp83tg720.c                        |  188 +
 drivers/net/phy/marvell10g.c                       |  203 +-
 drivers/net/phy/mdio_bus.c                         |   15 +-
 drivers/net/phy/mdio_device.c                      |    6 +
 drivers/net/phy/micrel.c                           |   51 +-
 drivers/net/phy/mscc/mscc.h                        |    5 +
 drivers/net/phy/mscc/mscc_main.c                   |    4 +-
 drivers/net/phy/mscc/mscc_ptp.c                    |   18 +-
 drivers/net/phy/nxp-c45-tja11xx-macsec.c           | 1729 ++++
 drivers/net/phy/nxp-c45-tja11xx.c                  |   94 +-
 drivers/net/phy/nxp-c45-tja11xx.h                  |   62 +
 drivers/net/phy/nxp-tja11xx.c                      |    2 +-
 drivers/net/phy/phy-c45.c                          |  129 +-
 drivers/net/phy/phy-core.c                         |  204 +-
 drivers/net/phy/phy.c                              |   28 +-
 drivers/net/phy/phy_device.c                       |   47 +-
 drivers/net/phy/phylink.c                          |  324 +-
 drivers/net/phy/sfp-bus.c                          |    2 +-
 drivers/net/phy/sfp.c                              |   40 +-
 drivers/net/phy/smsc.c                             |    2 +-
 drivers/net/ppp/ppp_async.c                        |    2 +-
 drivers/net/usb/ax88179_178a.c                     |    2 -
 drivers/net/usb/lan78xx.c                          |    2 -
 drivers/net/veth.c                                 |   19 +
 drivers/net/virtio_net.c                           |  326 +-
 drivers/net/vmxnet3/vmxnet3_ethtool.c              |   32 +-
 drivers/net/vxlan/vxlan_core.c                     |   24 +-
 drivers/net/vxlan/vxlan_mdb.c                      |  174 +-
 drivers/net/vxlan/vxlan_private.h                  |    2 +
 drivers/net/wan/Kconfig                            |    2 +
 drivers/net/wan/Makefile                           |    2 +
 drivers/net/wan/framer/Kconfig                     |   42 +
 drivers/net/wan/framer/Makefile                    |    7 +
 drivers/net/wan/framer/framer-core.c               |  882 +++
 drivers/net/wan/framer/pef2256/Makefile            |    8 +
 drivers/net/wan/framer/pef2256/pef2256-regs.h      |  250 +
 drivers/net/wan/framer/pef2256/pef2256.c           |  880 +++
 drivers/net/wan/fsl_ucc_hdlc.c                     |    6 +-
 drivers/net/wan/ixp4xx_hss.c                       |    5 +-
 drivers/net/wireless/Kconfig                       |    3 -
 drivers/net/wireless/Makefile                      |    2 -
 drivers/net/wireless/ath/ath10k/bmi.c              |    1 +
 drivers/net/wireless/ath/ath10k/ce.c               |    1 +
 drivers/net/wireless/ath/ath10k/core.c             |   17 +
 drivers/net/wireless/ath/ath10k/core.h             |    3 +-
 drivers/net/wireless/ath/ath10k/coredump.c         |    1 +
 drivers/net/wireless/ath/ath10k/coredump.h         |    1 +
 drivers/net/wireless/ath/ath10k/debug.c            |    1 +
 drivers/net/wireless/ath/ath10k/debugfs_sta.c      |    1 +
 drivers/net/wireless/ath/ath10k/htc.c              |    1 +
 drivers/net/wireless/ath/ath10k/htc.h              |   20 +-
 drivers/net/wireless/ath/ath10k/htt.h              |    1 +
 drivers/net/wireless/ath/ath10k/htt_rx.c           |    3 +-
 drivers/net/wireless/ath/ath10k/htt_tx.c           |    4 +-
 drivers/net/wireless/ath/ath10k/hw.c               |    1 +
 drivers/net/wireless/ath/ath10k/hw.h               |    4 +
 drivers/net/wireless/ath/ath10k/mac.c              |   17 +-
 drivers/net/wireless/ath/ath10k/pci.c              |    1 +
 drivers/net/wireless/ath/ath10k/pci.h              |    1 +
 drivers/net/wireless/ath/ath10k/qmi.c              |    1 +
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.c     |    1 +
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h     |    1 +
 drivers/net/wireless/ath/ath10k/rx_desc.h          |    1 +
 drivers/net/wireless/ath/ath10k/sdio.c             |    1 +
 drivers/net/wireless/ath/ath10k/thermal.c          |    1 +
 drivers/net/wireless/ath/ath10k/usb.h              |    1 +
 drivers/net/wireless/ath/ath10k/wmi-tlv.h          |    1 +
 drivers/net/wireless/ath/ath10k/wmi.c              |    1 +
 drivers/net/wireless/ath/ath10k/wmi.h              |    1 +
 drivers/net/wireless/ath/ath10k/wow.c              |    1 +
 drivers/net/wireless/ath/ath11k/Kconfig            |    2 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |   10 +-
 drivers/net/wireless/ath/ath11k/ce.c               |    2 +-
 drivers/net/wireless/ath/ath11k/ce.h               |    1 +
 drivers/net/wireless/ath/ath11k/core.h             |    1 -
 drivers/net/wireless/ath/ath11k/dbring.c           |    1 +
 drivers/net/wireless/ath/ath11k/dbring.h           |    1 +
 drivers/net/wireless/ath/ath11k/debug.c            |    1 +
 drivers/net/wireless/ath/ath11k/debug.h            |    2 +-
 drivers/net/wireless/ath/ath11k/debugfs.c          |    1 +
 drivers/net/wireless/ath/ath11k/debugfs.h          |    1 +
 .../net/wireless/ath/ath11k/debugfs_htt_stats.c    |    2 +-
 .../net/wireless/ath/ath11k/debugfs_htt_stats.h    |    2 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c      |    1 +
 drivers/net/wireless/ath/ath11k/debugfs_sta.h      |    1 +
 drivers/net/wireless/ath/ath11k/dp.c               |    2 +-
 drivers/net/wireless/ath/ath11k/dp.h               |    2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |    1 +
 drivers/net/wireless/ath/ath11k/dp_tx.c            |    2 +-
 drivers/net/wireless/ath/ath11k/dp_tx.h            |    1 +
 drivers/net/wireless/ath/ath11k/fw.c               |    2 +-
 drivers/net/wireless/ath/ath11k/hal.c              |    2 +-
 drivers/net/wireless/ath/ath11k/hal.h              |    2 +-
 drivers/net/wireless/ath/ath11k/hal_desc.h         |    1 +
 drivers/net/wireless/ath/ath11k/hal_rx.c           |    1 +
 drivers/net/wireless/ath/ath11k/hal_rx.h           |    1 +
 drivers/net/wireless/ath/ath11k/hif.h              |    1 +
 drivers/net/wireless/ath/ath11k/htc.c              |    1 +
 drivers/net/wireless/ath/ath11k/htc.h              |    6 +-
 drivers/net/wireless/ath/ath11k/hw.c               |    2 +-
 drivers/net/wireless/ath/ath11k/hw.h               |    2 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   16 +-
 drivers/net/wireless/ath/ath11k/mac.h              |    1 +
 drivers/net/wireless/ath/ath11k/mhi.c              |    2 +-
 drivers/net/wireless/ath/ath11k/mhi.h              |    1 +
 drivers/net/wireless/ath/ath11k/pcic.c             |    6 +-
 drivers/net/wireless/ath/ath11k/peer.c             |    2 +-
 drivers/net/wireless/ath/ath11k/peer.h             |    2 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |    2 +-
 drivers/net/wireless/ath/ath11k/qmi.h              |    2 +-
 drivers/net/wireless/ath/ath11k/reg.c              |    1 +
 drivers/net/wireless/ath/ath11k/reg.h              |    1 +
 drivers/net/wireless/ath/ath11k/rx_desc.h          |    1 +
 drivers/net/wireless/ath/ath11k/spectral.c         |    1 +
 drivers/net/wireless/ath/ath11k/spectral.h         |    1 +
 drivers/net/wireless/ath/ath11k/thermal.c          |    1 +
 drivers/net/wireless/ath/ath11k/thermal.h          |    1 +
 drivers/net/wireless/ath/ath11k/trace.h            |    1 +
 drivers/net/wireless/ath/ath11k/wmi.c              |    2 +-
 drivers/net/wireless/ath/ath11k/wmi.h              |   63 +-
 drivers/net/wireless/ath/ath11k/wow.h              |    1 +
 drivers/net/wireless/ath/ath12k/Kconfig            |    2 +-
 drivers/net/wireless/ath/ath12k/core.c             |    6 +-
 drivers/net/wireless/ath/ath12k/core.h             |    5 +-
 drivers/net/wireless/ath/ath12k/dbring.c           |    2 +-
 drivers/net/wireless/ath/ath12k/debug.c            |    2 +-
 drivers/net/wireless/ath/ath12k/dp.c               |    6 +-
 drivers/net/wireless/ath/ath12k/dp.h               |   13 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   15 +-
 drivers/net/wireless/ath/ath12k/dp_mon.h           |    4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  151 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |    8 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |    2 +-
 drivers/net/wireless/ath/ath12k/hal.c              |    6 +-
 drivers/net/wireless/ath/ath12k/hal.h              |    2 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c           |    2 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h           |    3 +-
 drivers/net/wireless/ath/ath12k/hif.h              |    2 +-
 drivers/net/wireless/ath/ath12k/hw.c               |    5 +-
 drivers/net/wireless/ath/ath12k/hw.h               |    2 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  190 +-
 drivers/net/wireless/ath/ath12k/mac.h              |    3 +-
 drivers/net/wireless/ath/ath12k/mhi.c              |   18 +-
 drivers/net/wireless/ath/ath12k/pci.c              |  174 +-
 drivers/net/wireless/ath/ath12k/pci.h              |    4 +-
 drivers/net/wireless/ath/ath12k/peer.h             |    2 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |    2 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |    2 +-
 drivers/net/wireless/ath/ath12k/reg.c              |   21 +-
 drivers/net/wireless/ath/ath12k/reg.h              |    4 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h          |    2 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |    2 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |   64 +-
 drivers/net/wireless/ath/ath5k/ahb.c               |    8 +-
 drivers/net/wireless/ath/ath5k/eeprom.h            |    3 -
 .../net/wireless/ath/ath9k/ath9k_pci_owl_loader.c  |    2 +-
 drivers/net/wireless/ath/ath9k/common-init.c       |    2 +-
 drivers/net/wireless/ath/ath9k/common-spectral.c   |    2 +-
 drivers/net/wireless/ath/ath9k/debug.c             |    2 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |   10 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |    2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c      |   36 +-
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c      |    5 +-
 drivers/net/wireless/ath/ath9k/htc_hst.c           |    2 +-
 drivers/net/wireless/ath/ath9k/init.c              |   12 +-
 drivers/net/wireless/ath/ath9k/link.c              |    2 +-
 drivers/net/wireless/ath/ath9k/main.c              |   15 +
 drivers/net/wireless/ath/ath9k/pci.c               |    6 +-
 drivers/net/wireless/ath/wcn36xx/main.c            |    6 +-
 drivers/net/wireless/atmel/Kconfig                 |   35 -
 drivers/net/wireless/atmel/Makefile                |    4 -
 drivers/net/wireless/atmel/atmel.c                 | 4452 -----------
 drivers/net/wireless/atmel/atmel.h                 |   31 -
 drivers/net/wireless/atmel/atmel_cs.c              |  292 -
 drivers/net/wireless/atmel/atmel_pci.c             |   65 -
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |    2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |    6 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |    2 +-
 .../wireless/broadcom/brcm80211/brcmsmac/channel.c |    6 +-
 .../net/wireless/broadcom/brcm80211/brcmsmac/dma.c |    3 +-
 .../wireless/broadcom/brcm80211/brcmsmac/main.c    |    4 +-
 drivers/net/wireless/cisco/Kconfig                 |   59 -
 drivers/net/wireless/cisco/Makefile                |    3 -
 drivers/net/wireless/cisco/airo.c                  | 8288 --------------------
 drivers/net/wireless/cisco/airo.h                  |   10 -
 drivers/net/wireless/cisco/airo_cs.c               |  218 -
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |    6 -
 drivers/net/wireless/intel/iwlegacy/common.c       |    3 +
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |    6 +
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |    3 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   27 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |    1 +
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |   11 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |    1 -
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |    2 +
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h   |    1 +
 .../net/wireless/intel/iwlwifi/iwl-devtrace-data.h |   15 +-
 .../wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h  |   17 +-
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c  |   17 +-
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h  |   21 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   18 +-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h   |   11 -
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |    4 -
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   31 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c      |   22 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   17 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   20 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-responder.c |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |    7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   16 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |    3 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |    7 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   13 -
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |   11 -
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |   31 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   18 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |    5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |    3 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   10 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   47 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  |    5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |   34 +-
 drivers/net/wireless/intersil/Kconfig              |    2 -
 drivers/net/wireless/intersil/Makefile             |    2 -
 drivers/net/wireless/intersil/hostap/Kconfig       |   95 -
 drivers/net/wireless/intersil/hostap/Makefile      |    8 -
 drivers/net/wireless/intersil/hostap/hostap.h      |   98 -
 .../net/wireless/intersil/hostap/hostap_80211.h    |   97 -
 .../net/wireless/intersil/hostap/hostap_80211_rx.c | 1116 ---
 .../net/wireless/intersil/hostap/hostap_80211_tx.c |  554 --
 drivers/net/wireless/intersil/hostap/hostap_ap.c   | 3277 --------
 drivers/net/wireless/intersil/hostap/hostap_ap.h   |  264 -
 .../net/wireless/intersil/hostap/hostap_common.h   |  420 -
 .../net/wireless/intersil/hostap/hostap_config.h   |   49 -
 drivers/net/wireless/intersil/hostap/hostap_cs.c   |  710 --
 .../net/wireless/intersil/hostap/hostap_download.c |  810 --
 drivers/net/wireless/intersil/hostap/hostap_hw.c   | 3387 --------
 drivers/net/wireless/intersil/hostap/hostap_info.c |  509 --
 .../net/wireless/intersil/hostap/hostap_ioctl.c    | 3847 ---------
 drivers/net/wireless/intersil/hostap/hostap_main.c | 1123 ---
 drivers/net/wireless/intersil/hostap/hostap_pci.c  |  445 --
 drivers/net/wireless/intersil/hostap/hostap_plx.c  |  617 --
 drivers/net/wireless/intersil/hostap/hostap_proc.c |  411 -
 drivers/net/wireless/intersil/hostap/hostap_wlan.h | 1051 ---
 drivers/net/wireless/intersil/orinoco/Kconfig      |  143 -
 drivers/net/wireless/intersil/orinoco/Makefile     |   15 -
 drivers/net/wireless/intersil/orinoco/airport.c    |  268 -
 drivers/net/wireless/intersil/orinoco/cfg.c        |  291 -
 drivers/net/wireless/intersil/orinoco/cfg.h        |   15 -
 drivers/net/wireless/intersil/orinoco/fw.c         |  387 -
 drivers/net/wireless/intersil/orinoco/fw.h         |   21 -
 drivers/net/wireless/intersil/orinoco/hermes.c     |  778 --
 drivers/net/wireless/intersil/orinoco/hermes.h     |  534 --
 drivers/net/wireless/intersil/orinoco/hermes_dld.c |  477 --
 drivers/net/wireless/intersil/orinoco/hermes_dld.h |   52 -
 drivers/net/wireless/intersil/orinoco/hermes_rid.h |  165 -
 drivers/net/wireless/intersil/orinoco/hw.c         | 1362 ----
 drivers/net/wireless/intersil/orinoco/hw.h         |   60 -
 drivers/net/wireless/intersil/orinoco/main.c       | 2414 ------
 drivers/net/wireless/intersil/orinoco/main.h       |   50 -
 drivers/net/wireless/intersil/orinoco/mic.c        |   89 -
 drivers/net/wireless/intersil/orinoco/mic.h        |   23 -
 drivers/net/wireless/intersil/orinoco/orinoco.h    |  251 -
 drivers/net/wireless/intersil/orinoco/orinoco_cs.c |  350 -
 .../net/wireless/intersil/orinoco/orinoco_nortel.c |  314 -
 .../net/wireless/intersil/orinoco/orinoco_pci.c    |  257 -
 .../net/wireless/intersil/orinoco/orinoco_pci.h    |   54 -
 .../net/wireless/intersil/orinoco/orinoco_plx.c    |  362 -
 .../net/wireless/intersil/orinoco/orinoco_tmd.c    |  237 -
 .../net/wireless/intersil/orinoco/orinoco_usb.c    | 1787 -----
 drivers/net/wireless/intersil/orinoco/scan.c       |  259 -
 drivers/net/wireless/intersil/orinoco/scan.h       |   21 -
 .../net/wireless/intersil/orinoco/spectrum_cs.c    |  328 -
 drivers/net/wireless/intersil/orinoco/wext.c       | 1428 ----
 drivers/net/wireless/intersil/orinoco/wext.h       |   13 -
 drivers/net/wireless/legacy/Kconfig                |   55 -
 drivers/net/wireless/legacy/Makefile               |    6 -
 drivers/net/wireless/legacy/ray_cs.c               | 2824 -------
 drivers/net/wireless/legacy/ray_cs.h               |   74 -
 drivers/net/wireless/legacy/rayctl.h               |  734 --
 drivers/net/wireless/legacy/rndis_wlan.c           | 3760 ---------
 drivers/net/wireless/legacy/wl3501.h               |  615 --
 drivers/net/wireless/legacy/wl3501_cs.c            | 2036 -----
 drivers/net/wireless/marvell/libertas/Kconfig      |    9 +-
 drivers/net/wireless/marvell/libertas/Makefile     |    1 -
 drivers/net/wireless/marvell/libertas/if_cs.c      |  957 ---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |    2 +
 drivers/net/wireless/marvell/mwifiex/cmdevt.c      |    8 -
 drivers/net/wireless/marvell/mwifiex/fw.h          |    1 +
 drivers/net/wireless/marvell/mwifiex/ioctl.h       |    1 +
 drivers/net/wireless/marvell/mwifiex/join.c        |    4 +-
 drivers/net/wireless/marvell/mwifiex/main.h        |    1 -
 drivers/net/wireless/marvell/mwifiex/scan.c        |   11 -
 drivers/net/wireless/marvell/mwifiex/sdio.c        |   21 +-
 drivers/net/wireless/marvell/mwifiex/sdio.h        |    2 +
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c   |    4 +-
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c     |    8 +
 drivers/net/wireless/mediatek/mt76/dma.c           |  258 +-
 drivers/net/wireless/mediatek/mt76/dma.h           |   54 +
 drivers/net/wireless/mediatek/mt76/eeprom.c        |   22 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   60 +-
 drivers/net/wireless/mediatek/mt76/mmio.c          |  108 +
 drivers/net/wireless/mediatek/mt76/mt76.h          |  105 +-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c    |    9 +-
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c    |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/soc.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |    8 +-
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  |    7 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |    5 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |    5 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   29 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c    |   46 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   30 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   21 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |  118 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |   23 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   38 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   17 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |    4 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio_mac.c   |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |    6 +
 .../net/wireless/mediatek/mt76/mt792x_acpi_sar.c   |   53 +
 .../net/wireless/mediatek/mt76/mt792x_acpi_sar.h   |    2 +
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |  398 +-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c |   38 +-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h |    3 +
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |  520 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  219 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   89 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  642 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |  253 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |  295 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  160 +-
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |   79 +-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |  182 +-
 drivers/net/wireless/mediatek/mt76/sdio.c          |   18 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |   24 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |   46 +-
 drivers/net/wireless/microchip/wilc1000/hif.h      |   42 +-
 drivers/net/wireless/microchip/wilc1000/sdio.c     |    9 +-
 drivers/net/wireless/purelifi/plfxlc/usb.c         |    5 +-
 drivers/net/wireless/ralink/rt2x00/rt2800.h        |    4 +
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |   88 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00.h        |    5 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c     |    3 +
 drivers/net/wireless/ralink/rt2x00/rt2x00link.c    |    2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c     |   11 +
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c   |    3 -
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |   12 +
 drivers/net/wireless/realtek/rtlwifi/base.c        |    8 -
 drivers/net/wireless/realtek/rtlwifi/pci.c         |   99 +-
 drivers/net/wireless/realtek/rtlwifi/pci.h         |   25 -
 .../net/wireless/realtek/rtlwifi/rtl8188ee/phy.c   |   14 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/sw.c    |    3 -
 .../wireless/realtek/rtlwifi/rtl8192c/phy_common.c |   16 +-
 .../wireless/realtek/rtlwifi/rtl8192c/phy_common.h |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ce/phy.c   |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/phy.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ce/sw.c    |    3 -
 .../net/wireless/realtek/rtlwifi/rtl8192cu/phy.c   |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.c   |   15 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/sw.c    |    3 -
 .../net/wireless/realtek/rtlwifi/rtl8192ee/dm.c    |   11 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/hw.c    |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ee/phy.c   |   16 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/sw.c    |    3 -
 .../net/wireless/realtek/rtlwifi/rtl8192se/phy.c   |   15 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/sw.c    |    3 -
 .../net/wireless/realtek/rtlwifi/rtl8723ae/phy.c   |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/sw.c    |    3 -
 .../net/wireless/realtek/rtlwifi/rtl8723be/phy.c   |    4 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/sw.c    |    3 -
 .../realtek/rtlwifi/rtl8723com/phy_common.c        |   12 +-
 .../realtek/rtlwifi/rtl8723com/phy_common.h        |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8821ae/hw.c    |   76 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/phy.c   |   25 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/sw.c    |    3 -
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   24 +-
 drivers/net/wireless/realtek/rtw88/debug.c         |    6 +-
 drivers/net/wireless/realtek/rtw88/debug.h         |    6 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |    4 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    4 +-
 drivers/net/wireless/realtek/rtw88/main.c          |    5 +
 drivers/net/wireless/realtek/rtw88/main.h          |   12 -
 drivers/net/wireless/realtek/rtw88/sdio.c          |   35 +-
 drivers/net/wireless/realtek/rtw88/tx.c            |    3 +-
 drivers/net/wireless/realtek/rtw89/acpi.c          |   81 +-
 drivers/net/wireless/realtek/rtw89/acpi.h          |   32 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |   16 +-
 drivers/net/wireless/realtek/rtw89/coex.c          |  652 +-
 drivers/net/wireless/realtek/rtw89/coex.h          |   38 +
 drivers/net/wireless/realtek/rtw89/core.c          |  107 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  149 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   70 +-
 drivers/net/wireless/realtek/rtw89/debug.h         |   19 +-
 drivers/net/wireless/realtek/rtw89/efuse.c         |   11 +-
 drivers/net/wireless/realtek/rtw89/efuse.h         |   17 +-
 drivers/net/wireless/realtek/rtw89/efuse_be.c      |  420 +
 drivers/net/wireless/realtek/rtw89/fw.c            |  175 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |  154 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |  853 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |  150 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   21 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        | 2041 ++++-
 drivers/net/wireless/realtek/rtw89/pci.c           |  345 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |  519 ++
 drivers/net/wireless/realtek/rtw89/pci_be.c        |  509 ++
 drivers/net/wireless/realtek/rtw89/phy.c           |  511 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |   49 +-
 drivers/net/wireless/realtek/rtw89/ps.h            |    4 +
 drivers/net/wireless/realtek/rtw89/reg.h           | 3212 +++++++-
 drivers/net/wireless/realtek/rtw89/regd.c          |  175 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   27 +-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    3 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   27 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   27 +-
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   51 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.h      |   20 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |  710 ++
 drivers/net/wireless/realtek/rtw89/rtw8922a.h      |   73 +
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |   88 +
 drivers/net/wireless/realtek/rtw89/sar.c           |    4 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |   16 +-
 drivers/net/wireless/realtek/rtw89/txrx.h          |    4 +
 drivers/net/wireless/realtek/rtw89/wow.c           |    7 +-
 drivers/net/wireless/silabs/wfx/sta.c              |   42 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   25 +
 drivers/net/wireless/zydas/Kconfig                 |   19 -
 drivers/net/wireless/zydas/Makefile                |    2 -
 drivers/net/wireless/zydas/zd1201.c                | 1909 -----
 drivers/net/wireless/zydas/zd1201.h                |  144 -
 drivers/net/wwan/qcom_bam_dmux.c                   |    6 +-
 drivers/pci/pci.c                                  |    3 +
 drivers/pci/quirks.c                               |   13 +
 drivers/pinctrl/Kconfig                            |   15 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-pef2256.c                  |  358 +
 drivers/platform/x86/amd/Kconfig                   |   14 +
 drivers/platform/x86/amd/Makefile                  |    1 +
 drivers/platform/x86/amd/wbrf.c                    |  317 +
 drivers/ptp/ptp_ines.c                             |   16 +-
 drivers/ptp/ptp_ocp.c                              |   34 +-
 drivers/s390/net/ism.h                             |    7 -
 drivers/s390/net/ism_drv.c                         |   57 +-
 drivers/vhost/vsock.c                              |    1 +
 fs/verity/fsverity_private.h                       |   10 +
 fs/verity/init.c                                   |    1 +
 fs/verity/measure.c                                |   84 +
 include/asm-generic/Kbuild                         |    1 +
 include/asm-generic/cfi.h                          |    5 +
 include/kunit/skbuff.h                             |   56 +
 include/kunit/test.h                               |   19 +
 include/linux/acpi_amd_wbrf.h                      |   91 +
 include/linux/avf/virtchnl.h                       |   36 +-
 include/linux/bpf.h                                |   72 +-
 include/linux/bpf_mem_alloc.h                      |    8 +
 include/linux/bpf_verifier.h                       |  172 +-
 include/linux/bpfilter.h                           |   24 -
 include/linux/cache.h                              |   25 +
 include/linux/cfi.h                                |   12 +
 include/linux/cgroup-defs.h                        |    1 +
 include/linux/cgroup.h                             |    4 +-
 include/linux/compiler-gcc.h                       |    2 +-
 include/linux/connector.h                          |    3 +-
 include/linux/dpll.h                               |    6 +-
 include/linux/ethtool.h                            |   89 +-
 include/linux/filter.h                             |    2 +-
 include/linux/firmware.h                           |    2 +
 include/linux/framer/framer-provider.h             |  194 +
 include/linux/framer/framer.h                      |  205 +
 include/linux/framer/pef2256.h                     |   31 +
 include/linux/ieee80211.h                          |    5 +-
 include/linux/if_vlan.h                            |    4 +-
 include/linux/indirect_call_wrapper.h              |    2 +-
 include/linux/ism.h                                |    1 -
 include/linux/linkmode.h                           |    5 +
 include/linux/list.h                               |   20 +
 include/linux/mdio.h                               |    1 +
 include/linux/mii_timestamper.h                    |    4 +-
 include/linux/mlx5/device.h                        |    2 +-
 include/linux/mlx5/driver.h                        |    3 +
 include/linux/mlx5/mlx5_ifc.h                      |   50 +-
 include/linux/mm_types.h                           |    2 +-
 include/linux/netdevice.h                          |  159 +-
 include/linux/netfilter_ipv6.h                     |    8 +-
 include/linux/netlink.h                            |    7 +-
 include/linux/phy.h                                |   90 +-
 include/linux/phylink.h                            |   66 -
 include/linux/platform_data/microchip-ksz.h        |   23 +-
 include/linux/poison.h                             |    2 +
 include/linux/rtnetlink.h                          |   41 +
 include/linux/skbuff.h                             |   34 +-
 include/linux/skmsg.h                              |    5 +
 include/linux/tcp.h                                |  248 +-
 include/linux/tnum.h                               |    4 +
 include/linux/virtio_vsock.h                       |    1 +
 include/net/act_api.h                              |    6 +-
 include/net/af_vsock.h                             |    2 +-
 include/net/bluetooth/hci_core.h                   |   26 +-
 include/net/cfg80211.h                             |  148 +-
 include/net/cfg802154.h                            |   72 +
 include/net/dropreason-core.h                      |   24 +-
 include/net/fib_rules.h                            |    3 +-
 include/net/genetlink.h                            |   55 +-
 include/net/ieee802154_netdev.h                    |   60 +
 include/net/inet_hashtables.h                      |   21 +-
 include/net/inet_sock.h                            |    5 +-
 include/net/inet_timewait_sock.h                   |    4 -
 include/net/ip.h                                   |   10 +-
 include/net/ip_tunnels.h                           |   11 +
 include/net/ipv6.h                                 |    5 -
 include/net/iucv/iucv.h                            |    4 +-
 include/net/mac80211.h                             |   61 +-
 include/net/macsec.h                               |   54 +
 include/net/mana/gdma.h                            |    7 +-
 include/net/mana/mana.h                            |   46 +-
 include/net/netdev_rx_queue.h                      |    4 +
 include/net/netfilter/nf_flow_table.h              |    9 +-
 include/net/netlink.h                              |   47 +-
 include/net/netns/core.h                           |    1 +
 include/net/netns/ipv4.h                           |   50 +-
 include/net/netns/smc.h                            |    2 +
 include/net/nl802154.h                             |   22 +-
 include/net/page_pool/helpers.h                    |   85 +-
 include/net/page_pool/types.h                      |   49 +-
 include/net/pkt_cls.h                              |    6 -
 include/net/pkt_sched.h                            |   18 -
 include/net/sch_generic.h                          |   36 +-
 include/net/smc.h                                  |   16 +-
 include/net/sock.h                                 |   30 -
 include/net/tc_act/tc_ipt.h                        |   17 -
 include/net/tc_act/tc_mirred.h                     |    1 +
 include/net/tc_wrapper.h                           |    4 -
 include/net/tcp.h                                  |   22 +-
 include/net/tcp_ao.h                               |    6 +-
 include/net/tcp_states.h                           |    2 +
 include/net/vxlan.h                                |   33 +-
 include/net/xdp.h                                  |   20 +-
 include/net/xdp_sock.h                             |  111 +
 include/net/xdp_sock_drv.h                         |   51 +
 include/net/xfrm.h                                 |    9 +
 include/net/xsk_buff_pool.h                        |   10 +
 include/uapi/linux/batadv_packet.h                 |   45 +-
 include/uapi/linux/bpf.h                           |   44 +-
 include/uapi/linux/bpfilter.h                      |   21 -
 include/uapi/linux/devlink.h                       |    2 +
 include/uapi/linux/dpll.h                          |    1 +
 include/uapi/linux/ethtool.h                       |   41 +-
 include/uapi/linux/ethtool_netlink.h               |    1 +
 include/uapi/linux/if_bridge.h                     |    1 +
 include/uapi/linux/if_link.h                       |  529 ++
 include/uapi/linux/if_xdp.h                        |   47 +-
 include/uapi/linux/mptcp.h                         |    1 +
 include/uapi/linux/mptcp_pm.h                      |    2 +-
 include/uapi/linux/netdev.h                        |   80 +-
 include/uapi/linux/nl80211.h                       |  185 +-
 include/uapi/linux/pkt_cls.h                       |   51 +-
 include/uapi/linux/pkt_sched.h                     |  109 -
 include/uapi/linux/smc.h                           |    2 +
 include/uapi/linux/smc_diag.h                      |    2 +
 include/uapi/linux/tc_act/tc_ipt.h                 |   20 -
 include/uapi/linux/tc_act/tc_mirred.h              |    1 +
 kernel/bpf/arraymap.c                              |   35 +-
 kernel/bpf/bpf_cgrp_storage.c                      |    6 +-
 kernel/bpf/bpf_lsm.c                               |   12 +
 kernel/bpf/bpf_struct_ops.c                        |   35 +-
 kernel/bpf/btf.c                                   |  300 +-
 kernel/bpf/core.c                                  |   50 +-
 kernel/bpf/cpumask.c                               |   20 +-
 kernel/bpf/dispatcher.c                            |    7 +-
 kernel/bpf/hashtab.c                               |   12 +-
 kernel/bpf/helpers.c                               |   78 +-
 kernel/bpf/inode.c                                 |   53 +-
 kernel/bpf/log.c                                   |  504 ++
 kernel/bpf/lpm_trie.c                              |    3 +
 kernel/bpf/map_in_map.c                            |   17 +-
 kernel/bpf/map_in_map.h                            |    2 +-
 kernel/bpf/memalloc.c                              |  198 +-
 kernel/bpf/stackmap.c                              |   11 +-
 kernel/bpf/syscall.c                               |  114 +-
 kernel/bpf/task_iter.c                             |   29 +-
 kernel/bpf/tnum.c                                  |   13 +-
 kernel/bpf/trampoline.c                            |  101 +-
 kernel/bpf/verifier.c                              | 2586 +++---
 kernel/cgroup/cgroup-internal.h                    |    4 +-
 kernel/cgroup/cgroup-v1.c                          |   34 +
 kernel/cgroup/cgroup.c                             |   45 +-
 kernel/trace/bpf_trace.c                           |  180 +-
 lib/test_bpf.c                                     |   20 +-
 lib/test_firmware.c                                |    1 +
 mm/page_alloc.c                                    |    7 +
 net/8021q/vlan_dev.c                               |   15 +-
 net/Kconfig                                        |    2 -
 net/Makefile                                       |    1 -
 net/appletalk/ddp.c                                |   16 +-
 net/atm/common.c                                   |    1 +
 net/atm/lec.c                                      |    1 +
 net/batman-adv/Makefile                            |    1 +
 net/batman-adv/bridge_loop_avoidance.c             |    2 +-
 net/batman-adv/fragmentation.c                     |    8 +-
 net/batman-adv/gateway_client.c                    |    2 +-
 net/batman-adv/main.c                              |    5 +-
 net/batman-adv/main.h                              |    2 +-
 net/batman-adv/multicast.c                         |  129 +-
 net/batman-adv/multicast.h                         |   30 +-
 net/batman-adv/multicast_forw.c                    | 1178 +++
 net/batman-adv/netlink.c                           |    2 +-
 net/batman-adv/originator.c                        |   28 +
 net/batman-adv/originator.h                        |    3 +
 net/batman-adv/routing.c                           |   70 +
 net/batman-adv/routing.h                           |   11 +
 net/batman-adv/soft-interface.c                    |   18 +-
 net/batman-adv/types.h                             |   70 +
 net/bluetooth/hci_conn.c                           |   51 +-
 net/bluetooth/hci_debugfs.c                        |   12 +-
 net/bluetooth/hci_event.c                          |   11 +-
 net/bluetooth/hci_sync.c                           |  106 +-
 net/bluetooth/iso.c                                |  197 +-
 net/bluetooth/l2cap_core.c                         |    3 +-
 net/bluetooth/lib.c                                |   69 +-
 net/bluetooth/mgmt.c                               |   17 -
 net/bpf/bpf_dummy_struct_ops.c                     |   38 +-
 net/bpf/test_run.c                                 |   17 +-
 net/bpfilter/.gitignore                            |    2 -
 net/bpfilter/Kconfig                               |   23 -
 net/bpfilter/Makefile                              |   20 -
 net/bpfilter/bpfilter_kern.c                       |  136 -
 net/bpfilter/bpfilter_umh_blob.S                   |    7 -
 net/bpfilter/main.c                                |   64 -
 net/bpfilter/msgfmt.h                              |   17 -
 net/bridge/br_cfm_netlink.c                        |    2 +-
 net/bridge/br_device.c                             |    1 +
 net/bridge/br_mdb.c                                |  133 +
 net/bridge/br_private.h                            |   10 +
 net/caif/caif_dev.c                                |    1 +
 net/caif/caif_socket.c                             |    1 +
 net/caif/caif_usb.c                                |    1 +
 net/caif/chnl_net.c                                |    1 +
 net/core/Makefile                                  |    2 +-
 net/core/bpf_sk_storage.c                          |    3 +-
 net/core/dev.c                                     |  121 +-
 net/core/dev.h                                     |    3 +-
 net/core/dev_ioctl.c                               |    7 +-
 net/core/drop_monitor.c                            |    2 +-
 net/core/fib_rules.c                               |    4 +-
 net/core/filter.c                                  |   29 +-
 net/core/link_watch.c                              |    8 +-
 net/core/net-sysfs.c                               |   17 +-
 net/core/net_namespace.c                           |   49 +
 net/core/netdev-genl-gen.c                         |  110 +
 net/core/netdev-genl-gen.h                         |   16 +
 net/core/netdev-genl.c                             |  344 +-
 net/core/page_pool.c                               |  117 +-
 net/core/page_pool_priv.h                          |   12 +
 net/core/page_pool_user.c                          |  410 +
 net/core/pktgen.c                                  |    6 +-
 net/core/rtnetlink.c                               |   84 +-
 net/core/skbuff.c                                  |   84 +-
 net/core/sock.c                                    |    8 +-
 net/core/sysctl_net_core.c                         |   15 +-
 net/core/xdp.c                                     |   33 +
 net/dccp/ipv6.c                                    |    4 +-
 net/devlink/core.c                                 |    4 +-
 net/devlink/dev.c                                  |   37 +-
 net/devlink/devl_internal.h                        |   80 +-
 net/devlink/health.c                               |   13 +-
 net/devlink/linecard.c                             |    5 +-
 net/devlink/netlink.c                              |  161 +-
 net/devlink/netlink_gen.c                          |   20 +-
 net/devlink/netlink_gen.h                          |    9 +-
 net/devlink/param.c                                |    5 +-
 net/devlink/port.c                                 |    8 +-
 net/devlink/rate.c                                 |    5 +-
 net/devlink/region.c                               |    9 +-
 net/devlink/trap.c                                 |   18 +-
 net/dns_resolver/Kconfig                           |    2 +-
 net/dsa/tag_ar9331.c                               |    1 +
 net/dsa/tag_brcm.c                                 |    1 +
 net/dsa/tag_dsa.c                                  |    1 +
 net/dsa/tag_gswip.c                                |    1 +
 net/dsa/tag_hellcreek.c                            |    1 +
 net/dsa/tag_ksz.c                                  |    1 +
 net/dsa/tag_lan9303.c                              |    1 +
 net/dsa/tag_mtk.c                                  |    1 +
 net/dsa/tag_none.c                                 |    1 +
 net/dsa/tag_ocelot.c                               |    1 +
 net/dsa/tag_ocelot_8021q.c                         |    1 +
 net/dsa/tag_qca.c                                  |    1 +
 net/dsa/tag_rtl4_a.c                               |    6 +-
 net/dsa/tag_rtl8_4.c                               |    1 +
 net/dsa/tag_rzn1_a5psw.c                           |    1 +
 net/dsa/tag_sja1105.c                              |    1 +
 net/dsa/tag_trailer.c                              |    1 +
 net/dsa/tag_xrs700x.c                              |    1 +
 net/dsa/user.c                                     |   29 +-
 net/ethtool/common.c                               |   18 +-
 net/ethtool/ioctl.c                                |  198 +-
 net/ethtool/rings.c                                |   12 +
 net/ethtool/rss.c                                  |   24 +-
 net/hsr/hsr_device.c                               |   67 +-
 net/ieee802154/Makefile                            |    2 +-
 net/ieee802154/core.c                              |   24 +
 net/ieee802154/nl802154.c                          |  249 +-
 net/ieee802154/pan.c                               |  109 +
 net/ieee802154/rdev-ops.h                          |   30 +
 net/ieee802154/trace.h                             |   38 +
 net/ipv4/Makefile                                  |    2 -
 net/ipv4/af_inet.c                                 |    5 +-
 net/ipv4/bpf_tcp_ca.c                              |   69 +
 net/ipv4/bpfilter/Makefile                         |    2 -
 net/ipv4/bpfilter/sockopt.c                        |   71 -
 net/ipv4/fib_rules.c                               |    6 +-
 net/ipv4/inet_connection_sock.c                    |  121 +-
 net/ipv4/inet_diag.c                               |   86 +-
 net/ipv4/inet_hashtables.c                         |  125 +-
 net/ipv4/inet_timewait_sock.c                      |   21 +-
 net/ipv4/ip_sockglue.c                             |   51 +-
 net/ipv4/ipmr.c                                    |   15 +-
 net/ipv4/syncookies.c                              |  215 +-
 net/ipv4/sysctl_net_ipv4.c                         |   18 +-
 net/ipv4/tcp.c                                     |   94 +
 net/ipv4/tcp_ao.c                                  |   16 +-
 net/ipv4/tcp_input.c                               |   29 +-
 net/ipv4/tcp_timer.c                               |    4 +-
 net/ipv6/datagram.c                                |    6 +-
 net/ipv6/exthdrs_offload.c                         |   11 +
 net/ipv6/fib6_rules.c                              |    4 +-
 net/ipv6/icmp.c                                    |    8 +-
 net/ipv6/ip6_offload.c                             |   76 +-
 net/ipv6/ip6_tunnel.c                              |   26 +-
 net/ipv6/ip6mr.c                                   |    2 +-
 net/ipv6/ipv6_sockglue.c                           |  136 +-
 net/ipv6/ping.c                                    |    8 +-
 net/ipv6/raw.c                                     |    4 +-
 net/ipv6/syncookies.c                              |  108 +-
 net/ipv6/tcp_ipv6.c                                |    2 +-
 net/ipv6/udp.c                                     |    4 +-
 net/iucv/iucv.c                                    |    2 +-
 net/kcm/kcmsock.c                                  |    2 +-
 net/l2tp/l2tp_ip6.c                                |    4 +-
 net/mac80211/Makefile                              |    2 +
 net/mac80211/cfg.c                                 |    4 +-
 net/mac80211/chan.c                                |   13 +-
 net/mac80211/debugfs.c                             |    1 +
 net/mac80211/debugfs_sta.c                         |    2 +-
 net/mac80211/driver-ops.h                          |   22 +-
 net/mac80211/ibss.c                                |    2 +-
 net/mac80211/ieee80211_i.h                         |   36 +-
 net/mac80211/link.c                                |    3 +
 net/mac80211/main.c                                |    2 +
 net/mac80211/mesh_hwmp.c                           |    2 +-
 net/mac80211/mesh_pathtbl.c                        |    8 +-
 net/mac80211/mlme.c                                |  115 +-
 net/mac80211/rx.c                                  |   21 +-
 net/mac80211/scan.c                                |   52 +-
 net/mac80211/sta_info.c                            |    8 +-
 net/mac80211/sta_info.h                            |    2 +-
 net/mac80211/tdls.c                                |   18 +-
 net/mac80211/tests/Makefile                        |    2 +-
 net/mac80211/tests/mfp.c                           |  286 +
 net/mac80211/trace.h                               |   25 +
 net/mac80211/tx.c                                  |    7 +-
 net/mac80211/util.c                                |   16 +-
 net/mac80211/wbrf.c                                |   95 +
 net/mac802154/cfg.c                                |  175 +
 net/mac802154/ieee802154_i.h                       |   27 +
 net/mac802154/main.c                               |    2 +
 net/mac802154/rx.c                                 |   36 +-
 net/mac802154/scan.c                               |  407 +-
 net/mptcp/mib.c                                    |    1 +
 net/mptcp/mib.h                                    |    8 +
 net/mptcp/mptcp_pm_gen.c                           |    2 +-
 net/mptcp/mptcp_pm_gen.h                           |    2 +-
 net/mptcp/pm_netlink.c                             |    7 +-
 net/mptcp/pm_userspace.c                           |    8 +-
 net/mptcp/protocol.c                               |  164 +-
 net/mptcp/protocol.h                               |   10 +
 net/mptcp/sockopt.c                                |   29 +-
 net/mptcp/subflow.c                                |    2 +-
 net/ncsi/internal.h                                |    7 +-
 net/ncsi/ncsi-cmd.c                                |    3 +-
 net/ncsi/ncsi-manage.c                             |   29 +-
 net/ncsi/ncsi-netlink.c                            |    4 +-
 net/ncsi/ncsi-pkt.h                                |   17 +-
 net/ncsi/ncsi-rsp.c                                |   67 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |    2 +-
 net/netfilter/nf_conntrack_netlink.c               |   12 +-
 net/netfilter/nf_synproxy_core.c                   |    4 +-
 net/netfilter/nf_tables_api.c                      |  147 +-
 net/netfilter/nft_set_pipapo.c                     |    2 +-
 net/netlink/af_netlink.c                           |    6 +-
 net/netlink/genetlink.c                            |  148 +-
 net/packet/af_packet.c                             |   21 +-
 net/psample/psample.c                              |    2 +-
 net/rds/tcp_listen.c                               |    2 +-
 net/rfkill/core.c                                  |    4 +-
 net/rxrpc/call_object.c                            |    4 +-
 net/sched/Makefile                                 |    1 -
 net/sched/act_api.c                                |  251 +-
 net/sched/act_bpf.c                                |    2 +-
 net/sched/act_connmark.c                           |    2 +-
 net/sched/act_csum.c                               |    4 +-
 net/sched/act_ct.c                                 |   14 +-
 net/sched/act_ctinfo.c                             |    2 +-
 net/sched/act_gact.c                               |    2 +-
 net/sched/act_gate.c                               |    2 +-
 net/sched/act_ife.c                                |    2 +-
 net/sched/act_ipt.c                                |  464 --
 net/sched/act_mirred.c                             |  266 +-
 net/sched/act_mpls.c                               |    2 +-
 net/sched/act_nat.c                                |    2 +-
 net/sched/act_pedit.c                              |    2 +-
 net/sched/act_police.c                             |    2 +-
 net/sched/act_sample.c                             |    2 +-
 net/sched/act_simple.c                             |    2 +-
 net/sched/act_skbedit.c                            |    2 +-
 net/sched/act_skbmod.c                             |    2 +-
 net/sched/act_tunnel_key.c                         |    2 +-
 net/sched/act_vlan.c                               |    2 +-
 net/sched/cls_api.c                                |   96 +-
 net/sched/cls_u32.c                                |   36 +-
 net/sched/sch_api.c                                |   79 +-
 net/sched/sch_cbs.c                                |    4 +-
 net/sched/sch_generic.c                            |    9 +-
 net/sctp/socket.c                                  |   13 +-
 net/smc/af_smc.c                                   |  120 +-
 net/smc/smc.h                                      |   11 +-
 net/smc/smc_clc.c                                  |  333 +-
 net/smc/smc_clc.h                                  |   67 +-
 net/smc/smc_core.c                                 |   37 +-
 net/smc/smc_core.h                                 |   18 +-
 net/smc/smc_diag.c                                 |    9 +-
 net/smc/smc_ism.c                                  |   50 +-
 net/smc/smc_ism.h                                  |   30 +-
 net/smc/smc_pnet.c                                 |    4 +-
 net/smc/smc_sysctl.c                               |   24 +
 net/smc/smc_sysctl.h                               |    2 +
 net/smc/smc_tx.c                                   |   30 +-
 net/tipc/link.c                                    |   15 -
 net/tipc/netlink_compat.c                          |    2 +-
 net/unix/unix_bpf.c                                |   21 +-
 net/vmw_vsock/af_vsock.c                           |    9 +-
 net/vmw_vsock/hyperv_transport.c                   |    4 +-
 net/vmw_vsock/virtio_transport.c                   |    7 +-
 net/vmw_vsock/virtio_transport_common.c            |   43 +-
 net/vmw_vsock/vsock_loopback.c                     |    1 +
 net/wireless/Makefile                              |    4 +-
 net/wireless/chan.c                                |   97 +-
 net/wireless/core.h                                |   16 +-
 net/wireless/mlme.c                                |    2 +-
 net/wireless/nl80211.c                             |  314 +-
 net/wireless/nl80211.h                             |    2 +-
 net/wireless/rdev-ops.h                            |   26 +-
 net/wireless/reg.c                                 |    8 +-
 net/wireless/reg.h                                 |    5 +
 net/wireless/scan.c                                |  243 +-
 net/wireless/sme.c                                 |    2 +
 net/wireless/tests/Makefile                        |    2 +-
 net/wireless/tests/scan.c                          |  625 ++
 net/wireless/tests/util.c                          |   56 +
 net/wireless/tests/util.h                          |   66 +
 net/wireless/trace.h                               |   22 +-
 net/wireless/util.c                                |   56 +
 net/x25/af_x25.c                                   |   14 +-
 net/x25/x25_facilities.c                           |   14 +-
 net/x25/x25_out.c                                  |    2 +-
 net/xdp/xdp_umem.c                                 |   11 +-
 net/xdp/xsk.c                                      |   56 +-
 net/xdp/xsk_buff_pool.c                            |   14 +
 net/xdp/xsk_queue.h                                |   19 +-
 net/xfrm/Makefile                                  |    1 +
 net/xfrm/xfrm_policy.c                             |    2 +
 net/xfrm/xfrm_state_bpf.c                          |  134 +
 rust/bindings/bindings_helper.h                    |    3 +
 rust/kernel/lib.rs                                 |    3 +
 rust/kernel/net.rs                                 |    6 +
 rust/kernel/net/phy.rs                             |  901 +++
 rust/uapi/uapi_helper.h                            |    2 +
 samples/bpf/cpustat_user.c                         |    4 +-
 scripts/checkpatch.pl                              |   19 +
 scripts/kernel-doc                                 |    5 +
 tools/bpf/bpftool/Documentation/bpftool.rst        |    2 +-
 tools/bpf/bpftool/feature.c                        |    4 -
 tools/bpf/bpftool/link.c                           |  105 +-
 tools/bpf/bpftool/prog.c                           |   14 +-
 tools/include/uapi/linux/bpf.h                     |   43 +-
 tools/include/uapi/linux/if_xdp.h                  |   61 +-
 tools/include/uapi/linux/netdev.h                  |   80 +-
 tools/include/uapi/linux/pkt_cls.h                 |   47 -
 tools/include/uapi/linux/pkt_sched.h               |  109 -
 tools/lib/bpf/bpf_core_read.h                      |   32 +
 tools/lib/bpf/bpf_helpers.h                        |    3 +
 tools/lib/bpf/elf.c                                |    5 +-
 tools/lib/bpf/libbpf.c                             |  585 +-
 tools/lib/bpf/libbpf.map                           |    3 +
 tools/lib/bpf/libbpf_common.h                      |   13 +-
 tools/lib/bpf/libbpf_internal.h                    |   17 +-
 tools/lib/bpf/libbpf_version.h                     |    2 +-
 tools/lib/bpf/linker.c                             |   27 +-
 tools/net/ynl/Makefile                             |    2 +
 tools/net/ynl/generated/.gitignore                 |    2 +
 tools/net/ynl/generated/devlink-user.c             | 6864 ----------------
 tools/net/ynl/generated/devlink-user.h             | 5255 -------------
 tools/net/ynl/generated/ethtool-user.c             | 6370 ---------------
 tools/net/ynl/generated/ethtool-user.h             | 5535 -------------
 tools/net/ynl/generated/fou-user.c                 |  330 -
 tools/net/ynl/generated/fou-user.h                 |  343 -
 tools/net/ynl/generated/handshake-user.c           |  332 -
 tools/net/ynl/generated/handshake-user.h           |  145 -
 tools/net/ynl/generated/netdev-user.c              |  225 -
 tools/net/ynl/generated/netdev-user.h              |   90 -
 tools/net/ynl/generated/nfsd-user.c                |  203 -
 tools/net/ynl/generated/nfsd-user.h                |   67 -
 tools/net/ynl/lib/nlspec.py                        |   55 +
 tools/net/ynl/lib/ynl-priv.h                       |  144 +
 tools/net/ynl/lib/ynl.c                            |   14 +-
 tools/net/ynl/lib/ynl.h                            |  149 +-
 tools/net/ynl/lib/ynl.py                           |   98 +-
 tools/net/ynl/samples/.gitignore                   |    1 +
 tools/net/ynl/samples/Makefile                     |    4 +-
 tools/net/ynl/samples/netdev.c                     |   10 +-
 tools/net/ynl/samples/page-pool.c                  |  147 +
 tools/net/ynl/ynl-gen-c.py                         |  265 +-
 tools/net/ynl/ynl-gen-rst.py                       |  417 +
 tools/net/ynl/ynl-regen.sh                         |    4 +-
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/bpf/Makefile               |   15 +-
 tools/testing/selftests/bpf/README.rst             |    2 +-
 .../testing/selftests/bpf/benchs/bench_htab_mem.c  |    1 +
 tools/testing/selftests/bpf/bpf_experimental.h     |  220 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h           |   10 +
 tools/testing/selftests/bpf/cgroup_helpers.c       |  132 +-
 tools/testing/selftests/bpf/cgroup_helpers.h       |    5 +-
 tools/testing/selftests/bpf/config                 |    3 +-
 tools/testing/selftests/bpf/config.aarch64         |   18 +-
 tools/testing/selftests/bpf/config.s390x           |   10 -
 tools/testing/selftests/bpf/config.vm              |   12 +
 tools/testing/selftests/bpf/config.x86_64          |   13 -
 .../selftests/bpf/map_tests/map_percpu_stats.c     |   39 +-
 tools/testing/selftests/bpf/network_helpers.h      |   43 +
 tools/testing/selftests/bpf/prog_tests/align.c     |   42 +-
 tools/testing/selftests/bpf/prog_tests/bind_perm.c |    6 +-
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c  |   87 +-
 .../testing/selftests/bpf/prog_tests/bpf_obj_id.c  |  204 +-
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  |   48 +-
 .../selftests/bpf/prog_tests/bpf_verif_scale.c     |    2 +-
 tools/testing/selftests/bpf/prog_tests/btf.c       |    6 +-
 .../selftests/bpf/prog_tests/cgroup1_hierarchy.c   |  158 +
 .../testing/selftests/bpf/prog_tests/cgroup_v1v2.c |    2 +-
 .../selftests/bpf/prog_tests/cgrp_local_storage.c  |   98 +-
 tools/testing/selftests/bpf/prog_tests/cpumask.c   |    1 +
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c       |   30 +-
 .../selftests/bpf/prog_tests/fill_link_info.c      |  242 +-
 tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c |  142 +
 .../bpf/prog_tests/global_func_dead_code.c         |   60 +
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   |   31 +-
 .../testing/selftests/bpf/prog_tests/libbpf_str.c  |    2 +-
 .../selftests/bpf/prog_tests/local_kptr_stash.c    |   56 +
 tools/testing/selftests/bpf/prog_tests/log_buf.c   |    4 +-
 tools/testing/selftests/bpf/prog_tests/log_fixup.c |    4 +-
 tools/testing/selftests/bpf/prog_tests/map_btf.c   |   98 +
 .../testing/selftests/bpf/prog_tests/map_in_map.c  |  141 +
 .../selftests/bpf/prog_tests/recursive_attach.c    |  151 +
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  | 2131 +++++
 .../selftests/bpf/prog_tests/sockmap_basic.c       |  214 +-
 tools/testing/selftests/bpf/prog_tests/spin_lock.c |   14 +-
 tools/testing/selftests/bpf/prog_tests/syscall.c   |   30 +-
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   |    6 +-
 .../testing/selftests/bpf/prog_tests/test_bpf_ma.c |   20 +-
 .../selftests/bpf/prog_tests/test_global_funcs.c   |  106 +
 .../testing/selftests/bpf/prog_tests/test_tunnel.c |  162 +-
 tools/testing/selftests/bpf/prog_tests/time_tai.c  |    2 +-
 .../selftests/bpf/prog_tests/uprobe_multi_test.c   |  177 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |    6 +
 .../selftests/bpf/prog_tests/verify_pkcs7_sig.c    |  165 +-
 tools/testing/selftests/bpf/prog_tests/vmlinux.c   |   16 +-
 .../bpf/prog_tests/xdp_context_test_run.c          |    4 +-
 .../selftests/bpf/prog_tests/xdp_metadata.c        |  165 +-
 .../selftests/bpf/progs/access_map_in_map.c        |   93 +
 .../bpf/progs/bpf_iter_bpf_percpu_hash_map.c       |    2 +-
 .../selftests/bpf/progs/bpf_iter_task_stack.c      |    5 +
 .../selftests/bpf/progs/bpf_iter_task_vmas.c       |    2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_tasks.c |    2 +-
 .../selftests/bpf/progs/bpf_iter_test_kern4.c      |    2 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h       |    1 +
 .../testing/selftests/bpf/progs/bpf_tracing_net.h  |    1 +
 .../bpf/progs/cgroup_getset_retval_setsockopt.c    |    2 +-
 .../selftests/bpf/progs/cgrp_kfunc_failure.c       |    2 +-
 .../selftests/bpf/progs/cgrp_ls_recursion.c        |   84 +-
 .../selftests/bpf/progs/cgrp_ls_sleepable.c        |   63 +-
 tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c |   82 +-
 tools/testing/selftests/bpf/progs/cpumask_common.h |    1 +
 .../testing/selftests/bpf/progs/cpumask_success.c  |   45 +-
 tools/testing/selftests/bpf/progs/exceptions.c     |   20 +-
 .../selftests/bpf/progs/exceptions_assert.c        |   92 +-
 .../testing/selftests/bpf/progs/exceptions_fail.c  |    2 +-
 .../testing/selftests/bpf/progs/fentry_recursive.c |   14 +
 .../selftests/bpf/progs/fentry_recursive_target.c  |   25 +
 .../bpf/progs/freplace_dead_global_func.c          |   11 +
 .../selftests/bpf/progs/freplace_unreliable_prog.c |   20 +
 tools/testing/selftests/bpf/progs/iters.c          |   28 +-
 tools/testing/selftests/bpf/progs/iters_task_vma.c |    3 +-
 tools/testing/selftests/bpf/progs/linked_funcs1.c  |    2 +-
 tools/testing/selftests/bpf/progs/linked_funcs2.c  |    2 +-
 tools/testing/selftests/bpf/progs/linked_list.c    |    2 +-
 .../testing/selftests/bpf/progs/local_kptr_stash.c |  124 +
 tools/testing/selftests/bpf/progs/local_storage.c  |    2 +-
 tools/testing/selftests/bpf/progs/lsm.c            |    2 +-
 tools/testing/selftests/bpf/progs/map_in_map_btf.c |   73 +
 tools/testing/selftests/bpf/progs/normal_map_btf.c |   56 +
 .../selftests/bpf/progs/percpu_alloc_fail.c        |   18 +
 tools/testing/selftests/bpf/progs/profiler.inc.h   |   68 +-
 tools/testing/selftests/bpf/progs/pyperf180.c      |   22 +
 .../selftests/bpf/progs/refcounted_kptr_fail.c     |   19 +
 .../testing/selftests/bpf/progs/sockopt_inherit.c  |    2 +-
 tools/testing/selftests/bpf/progs/sockopt_multi.c  |    2 +-
 .../selftests/bpf/progs/sockopt_qos_to_cc.c        |    2 +-
 tools/testing/selftests/bpf/progs/syscall.c        |   96 +-
 .../selftests/bpf/progs/task_kfunc_failure.c       |    2 +-
 tools/testing/selftests/bpf/progs/test_bpf_ma.c    |   92 +-
 .../selftests/bpf/progs/test_cgroup1_hierarchy.c   |   71 +
 .../selftests/bpf/progs/test_core_reloc_kernel.c   |    2 +-
 .../selftests/bpf/progs/test_core_reloc_module.c   |    8 +-
 .../selftests/bpf/progs/test_fill_link_info.c      |    6 +
 tools/testing/selftests/bpf/progs/test_fsverity.c  |   48 +
 tools/testing/selftests/bpf/progs/test_get_xattr.c |   37 +
 .../selftests/bpf/progs/test_global_func12.c       |    4 +-
 .../selftests/bpf/progs/test_global_func15.c       |   34 +-
 .../selftests/bpf/progs/test_global_func16.c       |    2 +-
 .../selftests/bpf/progs/test_global_func17.c       |    1 +
 .../selftests/bpf/progs/test_global_func5.c        |    2 +-
 .../bpf/progs/test_global_func_ctx_args.c          |   49 +
 .../selftests/bpf/progs/test_sig_in_xattr.c        |   83 +
 .../selftests/bpf/progs/test_skc_to_unix_sock.c    |    2 +-
 .../testing/selftests/bpf/progs/test_tunnel_kern.c |  138 +-
 .../selftests/bpf/progs/test_verify_pkcs7_sig.c    |    8 +-
 .../selftests/bpf/progs/test_xdp_do_redirect.c     |    2 +-
 tools/testing/selftests/bpf/progs/timer_failure.c  |   37 +-
 .../selftests/bpf/progs/user_ringbuf_fail.c        |    2 +-
 .../selftests/bpf/progs/verifier_basic_stack.c     |    8 +-
 .../selftests/bpf/progs/verifier_bitfield_write.c  |  100 +
 .../testing/selftests/bpf/progs/verifier_bounds.c  |   64 +
 .../bpf/progs/verifier_btf_unreliable_prog.c       |   20 +
 .../bpf/progs/verifier_cgroup_inv_retcode.c        |    8 +-
 .../bpf/progs/verifier_direct_packet_access.c      |    2 +-
 .../selftests/bpf/progs/verifier_global_subprogs.c |  192 +
 tools/testing/selftests/bpf/progs/verifier_gotol.c |   19 +
 .../bpf/progs/verifier_helper_value_access.c       |   45 +-
 .../testing/selftests/bpf/progs/verifier_int_ptr.c |    7 +-
 .../bpf/progs/verifier_netfilter_retcode.c         |    2 +-
 .../selftests/bpf/progs/verifier_raw_stack.c       |    7 +-
 .../selftests/bpf/progs/verifier_spill_fill.c      |  287 +
 .../selftests/bpf/progs/verifier_stack_ptr.c       |    4 +-
 .../bpf/progs/verifier_subprog_precision.c         |  141 +-
 .../testing/selftests/bpf/progs/verifier_var_off.c |   91 +-
 .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |   38 +-
 tools/testing/selftests/bpf/progs/xdp_metadata.c   |   36 +-
 .../selftests/bpf/progs/xdp_synproxy_kern.c        |    4 +-
 tools/testing/selftests/bpf/test_loader.c          |   44 +-
 tools/testing/selftests/bpf/test_maps.c            |   17 +-
 tools/testing/selftests/bpf/test_maps.h            |    5 +
 tools/testing/selftests/bpf/test_offload.py        |   15 +-
 tools/testing/selftests/bpf/test_sock_addr.c       |    2 +-
 tools/testing/selftests/bpf/test_tunnel.sh         |   92 -
 tools/testing/selftests/bpf/test_verifier.c        |    2 +-
 tools/testing/selftests/bpf/testing_helpers.c      |    4 +-
 tools/testing/selftests/bpf/testing_helpers.h      |    3 +
 .../selftests/bpf/verifier/atomic_cmpxchg.c        |   11 -
 tools/testing/selftests/bpf/verifier/calls.c       |    4 +-
 tools/testing/selftests/bpf/verifier/precise.c     |   38 +-
 tools/testing/selftests/bpf/verify_sig_setup.sh    |   25 +
 tools/testing/selftests/bpf/veristat.c             |   91 +-
 tools/testing/selftests/bpf/vmtest.sh              |    4 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |  267 +-
 tools/testing/selftests/bpf/xdp_metadata.h         |   34 +-
 tools/testing/selftests/bpf/xsk.c                  |    3 +
 tools/testing/selftests/bpf/xsk.h                  |    1 +
 tools/testing/selftests/bpf/xskxceiver.c           |   25 +-
 .../selftests/drivers/net/mlxsw/pci_reset.sh       |   58 +
 tools/testing/selftests/hid/config                 |    1 -
 tools/testing/selftests/kselftest/runner.sh        |   38 +-
 tools/testing/selftests/net/Makefile               |    3 +-
 .../selftests/net/arp_ndisc_evict_nocarrier.sh     |   46 +-
 .../selftests/net/arp_ndisc_untracked_subnets.sh   |   20 +-
 tools/testing/selftests/net/cmsg_ipv6.sh           |   10 +-
 tools/testing/selftests/net/cmsg_sender.c          |   50 +-
 tools/testing/selftests/net/cmsg_so_mark.sh        |    7 +-
 tools/testing/selftests/net/cmsg_time.sh           |    7 +-
 tools/testing/selftests/net/drop_monitor_tests.sh  |   21 +-
 tools/testing/selftests/net/fcnal-test.sh          |   30 +-
 tools/testing/selftests/net/fdb_flush.sh           |   11 +-
 tools/testing/selftests/net/fib-onlink-tests.sh    |    9 +-
 .../selftests/net/fib_nexthop_multiprefix.sh       |   98 +-
 tools/testing/selftests/net/fib_nexthop_nongw.sh   |   34 +-
 tools/testing/selftests/net/fib_nexthops.sh        |  142 +-
 tools/testing/selftests/net/fib_rule_tests.sh      |   36 +-
 tools/testing/selftests/net/fib_tests.sh           |  184 +-
 tools/testing/selftests/net/forwarding/Makefile    |    1 +
 .../testing/selftests/net/forwarding/bridge_mdb.sh |  191 +-
 .../testing/selftests/net/forwarding/ethtool_mm.sh |   48 +-
 .../selftests/net/forwarding/ethtool_rmon.sh       |  143 +
 tools/testing/selftests/net/forwarding/lib.sh      |   70 +-
 tools/testing/selftests/net/fq_band_pktlimit.sh    |   57 +
 tools/testing/selftests/net/gre_gso.sh             |   18 +-
 tools/testing/selftests/net/gro.c                  |   93 +-
 tools/testing/selftests/net/gro.sh                 |    4 +-
 tools/testing/selftests/net/icmp.sh                |   10 +-
 tools/testing/selftests/net/icmp_redirect.sh       |  182 +-
 .../testing/selftests/net/io_uring_zerocopy_tx.sh  |    9 +-
 tools/testing/selftests/net/ioam6.sh               |  247 +-
 tools/testing/selftests/net/ip_local_port_range.c  |   12 +
 tools/testing/selftests/net/l2tp.sh                |  130 +-
 tools/testing/selftests/net/lib.sh                 |   93 +
 tools/testing/selftests/net/mptcp/diag.sh          |   32 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  110 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  422 +-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   91 +
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |   39 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   19 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  143 +-
 tools/testing/selftests/net/msg_zerocopy.sh        |    9 +-
 .../selftests/net/ndisc_unsolicited_na_test.sh     |   19 +-
 tools/testing/selftests/net/net_helper.sh          |   22 +
 tools/testing/selftests/net/netns-name.sh          |   44 +-
 tools/testing/selftests/net/pmtu.sh                |   29 +-
 tools/testing/selftests/net/rtnetlink.sh           |   34 +-
 tools/testing/selftests/net/sctp_vrf.sh            |   12 +-
 tools/testing/selftests/net/settings               |    2 +-
 tools/testing/selftests/net/setup_loopback.sh      |    8 +-
 tools/testing/selftests/net/setup_veth.sh          |    9 +-
 .../selftests/net/srv6_end_dt46_l3vpn_test.sh      |   51 +-
 .../selftests/net/srv6_end_dt4_l3vpn_test.sh       |   48 +-
 .../selftests/net/srv6_end_dt6_l3vpn_test.sh       |   46 +-
 .../selftests/net/stress_reuseport_listen.sh       |    6 +-
 tools/testing/selftests/net/tcp_ao/.gitignore      |    2 +
 tools/testing/selftests/net/tcp_ao/Makefile        |   56 +
 tools/testing/selftests/net/tcp_ao/bench-lookups.c |  360 +
 tools/testing/selftests/net/tcp_ao/connect-deny.c  |  264 +
 tools/testing/selftests/net/tcp_ao/connect.c       |   90 +
 tools/testing/selftests/net/tcp_ao/icmps-accept.c  |    1 +
 tools/testing/selftests/net/tcp_ao/icmps-discard.c |  449 ++
 .../testing/selftests/net/tcp_ao/key-management.c  | 1180 +++
 tools/testing/selftests/net/tcp_ao/lib/aolib.h     |  605 ++
 tools/testing/selftests/net/tcp_ao/lib/kconfig.c   |  148 +
 tools/testing/selftests/net/tcp_ao/lib/netlink.c   |  413 +
 tools/testing/selftests/net/tcp_ao/lib/proc.c      |  273 +
 tools/testing/selftests/net/tcp_ao/lib/repair.c    |  254 +
 tools/testing/selftests/net/tcp_ao/lib/setup.c     |  361 +
 tools/testing/selftests/net/tcp_ao/lib/sock.c      |  592 ++
 tools/testing/selftests/net/tcp_ao/lib/utils.c     |   30 +
 tools/testing/selftests/net/tcp_ao/restore.c       |  236 +
 tools/testing/selftests/net/tcp_ao/rst.c           |  415 +
 tools/testing/selftests/net/tcp_ao/self-connect.c  |  197 +
 tools/testing/selftests/net/tcp_ao/seq-ext.c       |  245 +
 .../selftests/net/tcp_ao/setsockopt-closed.c       |  835 ++
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c  |  741 ++
 .../selftests/net/test_bridge_backup_port.sh       |  371 +-
 .../selftests/net/test_bridge_neigh_suppress.sh    |  331 +-
 tools/testing/selftests/net/test_vxlan_mdb.sh      |  403 +-
 .../selftests/net/test_vxlan_nolocalbypass.sh      |   48 +-
 .../testing/selftests/net/test_vxlan_under_vrf.sh  |   70 +-
 .../selftests/net/test_vxlan_vnifiltering.sh       |  154 +-
 tools/testing/selftests/net/toeplitz.sh            |   14 +-
 tools/testing/selftests/net/traceroute.sh          |   82 +-
 tools/testing/selftests/net/udpgro.sh              |   13 +-
 tools/testing/selftests/net/udpgro_bench.sh        |    5 +-
 tools/testing/selftests/net/udpgro_frglist.sh      |    5 +-
 tools/testing/selftests/net/unicast_extensions.sh  |  101 +-
 tools/testing/selftests/net/vrf-xfrm-tests.sh      |   77 +-
 tools/testing/selftests/net/vrf_route_leaking.sh   |  201 +-
 .../testing/selftests/net/vrf_strict_mode_test.sh  |   47 +-
 tools/testing/selftests/net/xfrm_policy.sh         |  138 +-
 tools/testing/selftests/netfilter/.gitignore       |    2 +
 tools/testing/selftests/netfilter/Makefile         |    3 +-
 .../selftests/netfilter/conntrack_dump_flush.c     |  430 +
 tools/testing/selftests/run_kselftest.sh           |   10 +-
 tools/testing/selftests/tc-testing/Makefile        |   29 +-
 tools/testing/selftests/tc-testing/README          |    2 -
 tools/testing/selftests/tc-testing/action-ebpf     |  Bin 0 -> 856 bytes
 tools/testing/selftests/tc-testing/config          |    1 -
 .../tc-testing/plugin-lib/buildebpfPlugin.py       |   67 -
 .../selftests/tc-testing/plugin-lib/nsPlugin.py    |  210 +-
 .../selftests/tc-testing/tc-tests/actions/bpf.json |   14 +-
 .../selftests/tc-testing/tc-tests/actions/xt.json  |  243 -
 .../selftests/tc-testing/tc-tests/filters/bpf.json |   10 +-
 .../filters/{concurrency.json => flower.json}      |   98 +
 .../tc-testing/tc-tests/filters/matchall.json      |   23 +
 .../tc-testing/tc-tests/filters/tests.json         |  129 -
 .../selftests/tc-testing/tc-tests/filters/u32.json |   57 +
 tools/testing/selftests/tc-testing/tdc.py          |   14 +-
 tools/testing/selftests/tc-testing/tdc.sh          |   68 +-
 tools/testing/vsock/vsock_test.c                   |  175 +
 1796 files changed, 91950 insertions(+), 108990 deletions(-)
 create mode 100644 Documentation/bpf/fs_kfuncs.rst
 create mode 100644 Documentation/devicetree/bindings/net/dsa/marvell,mv88e6060.yaml
 create mode 100644 Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/dsa/marvell.txt
 create mode 100644 Documentation/devicetree/bindings/net/lantiq,pef2256.yaml
 create mode 100644 Documentation/devicetree/bindings/net/marvell,aquantia.yaml
 create mode 100644 Documentation/devicetree/bindings/net/renesas,ethertsn.yaml
 create mode 100644 Documentation/driver-api/wbrf.rst
 rename Documentation/netlink/specs/{mptcp.yaml => mptcp_pm.yaml} (100%)
 create mode 100644 Documentation/netlink/specs/tc.yaml
 delete mode 100644 Documentation/networking/device_drivers/wifi/ray_cs.rst
 create mode 100644 Documentation/networking/net_cachelines/index.rst
 create mode 100644 Documentation/networking/net_cachelines/inet_connection_sock.rst
 create mode 100644 Documentation/networking/net_cachelines/inet_sock.rst
 create mode 100644 Documentation/networking/net_cachelines/net_device.rst
 create mode 100644 Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
 create mode 100644 Documentation/networking/net_cachelines/snmp.rst
 create mode 100644 Documentation/networking/net_cachelines/tcp_sock.rst
 create mode 100644 Documentation/networking/netlink_spec/.gitignore
 create mode 100644 Documentation/networking/netlink_spec/readme.txt
 create mode 100644 Documentation/networking/xsk-tx-metadata.rst
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_xdp.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_xdp.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_debugfs.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_hwmon.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_hwmon.h
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
 create mode 100644 drivers/net/ethernet/realtek/r8169_leds.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
 create mode 100644 drivers/net/ipa/data/ipa_data-v5.5.c
 create mode 100644 drivers/net/ipa/reg/ipa_reg-v5.5.c
 delete mode 100644 drivers/net/phy/aquantia.h
 create mode 100644 drivers/net/phy/aquantia/Kconfig
 create mode 100644 drivers/net/phy/aquantia/Makefile
 create mode 100644 drivers/net/phy/aquantia/aquantia.h
 create mode 100644 drivers/net/phy/aquantia/aquantia_firmware.c
 rename drivers/net/phy/{ => aquantia}/aquantia_hwmon.c (90%)
 rename drivers/net/phy/{ => aquantia}/aquantia_main.c (91%)
 create mode 100644 drivers/net/phy/ax88796b_rust.rs
 create mode 100644 drivers/net/phy/dp83tg720.c
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx-macsec.c
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx.h
 create mode 100644 drivers/net/wan/framer/Kconfig
 create mode 100644 drivers/net/wan/framer/Makefile
 create mode 100644 drivers/net/wan/framer/framer-core.c
 create mode 100644 drivers/net/wan/framer/pef2256/Makefile
 create mode 100644 drivers/net/wan/framer/pef2256/pef2256-regs.h
 create mode 100644 drivers/net/wan/framer/pef2256/pef2256.c
 delete mode 100644 drivers/net/wireless/atmel/atmel.c
 delete mode 100644 drivers/net/wireless/atmel/atmel.h
 delete mode 100644 drivers/net/wireless/atmel/atmel_cs.c
 delete mode 100644 drivers/net/wireless/atmel/atmel_pci.c
 delete mode 100644 drivers/net/wireless/cisco/Kconfig
 delete mode 100644 drivers/net/wireless/cisco/Makefile
 delete mode 100644 drivers/net/wireless/cisco/airo.c
 delete mode 100644 drivers/net/wireless/cisco/airo.h
 delete mode 100644 drivers/net/wireless/cisco/airo_cs.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/Kconfig
 delete mode 100644 drivers/net/wireless/intersil/hostap/Makefile
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap.h
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_80211.h
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_80211_rx.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_80211_tx.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_ap.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_ap.h
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_common.h
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_config.h
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_cs.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_download.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_hw.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_info.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_ioctl.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_main.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_pci.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_plx.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_proc.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_wlan.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/Kconfig
 delete mode 100644 drivers/net/wireless/intersil/orinoco/Makefile
 delete mode 100644 drivers/net/wireless/intersil/orinoco/airport.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/cfg.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/cfg.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/fw.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/fw.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/hermes.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/hermes.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/hermes_dld.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/hermes_dld.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/hermes_rid.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/hw.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/hw.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/main.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/main.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/mic.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/mic.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/orinoco.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/orinoco_cs.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/orinoco_nortel.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/orinoco_pci.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/orinoco_pci.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/orinoco_plx.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/orinoco_tmd.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/orinoco_usb.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/scan.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/scan.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/spectrum_cs.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/wext.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/wext.h
 delete mode 100644 drivers/net/wireless/legacy/Kconfig
 delete mode 100644 drivers/net/wireless/legacy/Makefile
 delete mode 100644 drivers/net/wireless/legacy/ray_cs.c
 delete mode 100644 drivers/net/wireless/legacy/ray_cs.h
 delete mode 100644 drivers/net/wireless/legacy/rayctl.h
 delete mode 100644 drivers/net/wireless/legacy/rndis_wlan.c
 delete mode 100644 drivers/net/wireless/legacy/wl3501.h
 delete mode 100644 drivers/net/wireless/legacy/wl3501_cs.c
 delete mode 100644 drivers/net/wireless/marvell/libertas/if_cs.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/efuse_be.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/pci_be.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922a.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922a.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922ae.c
 delete mode 100644 drivers/net/wireless/zydas/zd1201.c
 delete mode 100644 drivers/net/wireless/zydas/zd1201.h
 create mode 100644 drivers/pinctrl/pinctrl-pef2256.c
 create mode 100644 drivers/platform/x86/amd/wbrf.c
 create mode 100644 include/asm-generic/cfi.h
 create mode 100644 include/kunit/skbuff.h
 create mode 100644 include/linux/acpi_amd_wbrf.h
 delete mode 100644 include/linux/bpfilter.h
 create mode 100644 include/linux/framer/framer-provider.h
 create mode 100644 include/linux/framer/framer.h
 create mode 100644 include/linux/framer/pef2256.h
 delete mode 100644 include/net/tc_act/tc_ipt.h
 delete mode 100644 include/uapi/linux/bpfilter.h
 delete mode 100644 include/uapi/linux/tc_act/tc_ipt.h
 create mode 100644 net/batman-adv/multicast_forw.c
 delete mode 100644 net/bpfilter/.gitignore
 delete mode 100644 net/bpfilter/Kconfig
 delete mode 100644 net/bpfilter/Makefile
 delete mode 100644 net/bpfilter/bpfilter_kern.c
 delete mode 100644 net/bpfilter/bpfilter_umh_blob.S
 delete mode 100644 net/bpfilter/main.c
 delete mode 100644 net/bpfilter/msgfmt.h
 create mode 100644 net/core/page_pool_priv.h
 create mode 100644 net/core/page_pool_user.c
 create mode 100644 net/ieee802154/pan.c
 delete mode 100644 net/ipv4/bpfilter/Makefile
 delete mode 100644 net/ipv4/bpfilter/sockopt.c
 create mode 100644 net/mac80211/tests/mfp.c
 create mode 100644 net/mac80211/wbrf.c
 delete mode 100644 net/sched/act_ipt.c
 create mode 100644 net/wireless/tests/scan.c
 create mode 100644 net/wireless/tests/util.c
 create mode 100644 net/wireless/tests/util.h
 create mode 100644 net/xfrm/xfrm_state_bpf.c
 create mode 100644 rust/kernel/net.rs
 create mode 100644 rust/kernel/net/phy.rs
 create mode 100644 tools/net/ynl/generated/.gitignore
 delete mode 100644 tools/net/ynl/generated/devlink-user.c
 delete mode 100644 tools/net/ynl/generated/devlink-user.h
 delete mode 100644 tools/net/ynl/generated/ethtool-user.c
 delete mode 100644 tools/net/ynl/generated/ethtool-user.h
 delete mode 100644 tools/net/ynl/generated/fou-user.c
 delete mode 100644 tools/net/ynl/generated/fou-user.h
 delete mode 100644 tools/net/ynl/generated/handshake-user.c
 delete mode 100644 tools/net/ynl/generated/handshake-user.h
 delete mode 100644 tools/net/ynl/generated/netdev-user.c
 delete mode 100644 tools/net/ynl/generated/netdev-user.h
 delete mode 100644 tools/net/ynl/generated/nfsd-user.c
 delete mode 100644 tools/net/ynl/generated/nfsd-user.h
 create mode 100644 tools/net/ynl/lib/ynl-priv.h
 create mode 100644 tools/net/ynl/samples/page-pool.c
 create mode 100755 tools/net/ynl/ynl-gen-rst.py
 create mode 100644 tools/testing/selftests/bpf/config.vm
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/global_func_dead_code.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_btf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_in_map.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursive_attach.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/reg_bounds.c
 create mode 100644 tools/testing/selftests/bpf/progs/access_map_in_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive_target.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_dead_global_func.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_in_map_btf.c
 create mode 100644 tools/testing/selftests/bpf/progs/normal_map_btf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fsverity.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_get_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sig_in_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bitfield_write.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_btf_unreliable_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/pci_reset.sh
 create mode 100755 tools/testing/selftests/net/forwarding/ethtool_rmon.sh
 create mode 100755 tools/testing/selftests/net/fq_band_pktlimit.sh
 create mode 100644 tools/testing/selftests/net/lib.sh
 create mode 100755 tools/testing/selftests/net/net_helper.sh
 create mode 100644 tools/testing/selftests/net/tcp_ao/.gitignore
 create mode 100644 tools/testing/selftests/net/tcp_ao/Makefile
 create mode 100644 tools/testing/selftests/net/tcp_ao/bench-lookups.c
 create mode 100644 tools/testing/selftests/net/tcp_ao/connect-deny.c
 create mode 100644 tools/testing/selftests/net/tcp_ao/connect.c
 create mode 120000 tools/testing/selftests/net/tcp_ao/icmps-accept.c
 create mode 100644 tools/testing/selftests/net/tcp_ao/icmps-discard.c
 create mode 100644 tools/testing/selftests/net/tcp_ao/key-management.c
 create mode 100644 tools/testing/selftests/net/tcp_ao/lib/aolib.h
 create mode 100644 tools/testing/selftests/net/tcp_ao/lib/kconfig.c
 create mode 100644 tools/testing/selftests/net/tcp_ao/lib/netlink.c
 create mode 100644 tools/testing/selftests/net/tcp_ao/lib/proc.c
 create mode 100644 tools/testing/selftests/net/tcp_ao/lib/repair.c
 create mode 100644 tools/testing/selftests/net/tcp_ao/lib/setup.c
 create mode 100644 tools/testing/selftests/net/tcp_ao/lib/sock.c
 create mode 100644 tools/testing/selftests/net/tcp_ao/lib/utils.c
 create mode 100644 tools/testing/selftests/net/tcp_ao/restore.c
 create mode 100644 tools/testing/selftests/net/tcp_ao/rst.c
 create mode 100644 tools/testing/selftests/net/tcp_ao/self-connect.c
 create mode 100644 tools/testing/selftests/net/tcp_ao/seq-ext.c
 create mode 100644 tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
 create mode 100644 tools/testing/selftests/net/tcp_ao/unsigned-md5.c
 create mode 100644 tools/testing/selftests/netfilter/conntrack_dump_flush.c
 create mode 100644 tools/testing/selftests/tc-testing/action-ebpf
 delete mode 100644 tools/testing/selftests/tc-testing/plugin-lib/buildebpfPlugin.py
 delete mode 100644 tools/testing/selftests/tc-testing/tc-tests/actions/xt.json
 rename tools/testing/selftests/tc-testing/tc-tests/filters/{concurrency.json => flower.json} (65%)
 delete mode 100644 tools/testing/selftests/tc-testing/tc-tests/filters/tests.json


