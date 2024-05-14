Return-Path: <bpf+bounces-29717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EED8C5E0B
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 01:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771DB1F21A91
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 23:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E35182CA2;
	Tue, 14 May 2024 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPp/SrMS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AF7182C95;
	Tue, 14 May 2024 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715728317; cv=none; b=bTr4sE8cA4vrlWkqkJqeJK+i0i3cKZQIldF76BfVUr1IOgMtzjf81ghM83QdCRwEJzk4TYmLe6kBYq6aT9w5P3bln/qESjc2jQEWu9c34ULHnf11L25shdjeL/k1x2wOyptFmyELCJgSN1YdvJ+0hchO7AWPET5uZ4kr+nhyHGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715728317; c=relaxed/simple;
	bh=nw9ep/9OHJEtPx0jr6nC3TXyZHfzPjIL3U+PdwNT43s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H0j/CLmf6m+0NOvCHfKSFt3b9IAxMUTSD990A94YNRPMGXEIoX9x/8rXyOg5BSgfDV4C917nwhfYPXLggCC5lOw7fV5Co/cjAblPjqjiz+RL+XWHrh0v9zcprHiKybOXA0cbWZQPXD9QVGW+MGnKYEJtEFOx8ff/hLCA5a1Q/wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPp/SrMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF86CC2BD10;
	Tue, 14 May 2024 23:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715728316;
	bh=nw9ep/9OHJEtPx0jr6nC3TXyZHfzPjIL3U+PdwNT43s=;
	h=From:To:Cc:Subject:Date:From;
	b=RPp/SrMSLQWcmdgHW9tDZaX/DR5QtkBdPOBh/u+H8AY5aYElBFhOQvvPXWeh3CTnp
	 F2T2Mgkr7Woq2lnc+1ACV2pVVkMZkUc5HbMNfYmedbKLx1QG4rpv1zYv9YqArZ4Bnr
	 o9IhD2sxTQqueZJWRODl/YflgWzd8TG5i9JZUPdj+VfJFAed6rnMT8b9CI9Hh0o896
	 wjpp8LpW6IEzcXZeb+7i2gFb1xA7ZUoVZuNeKtpetdgL5Yix+2ZegyalnDUzOrMTJ9
	 RbsK5OtOd/Co6xH9L8fcQPIbD8doB5HTou1qQc361yAATKQpgyU4foq1dso6mYBuYw
	 ZNsJ9EucnZxPg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	bpf@vger.kernel.org
Subject: [GIT PULL] Networking for v6.10
Date: Tue, 14 May 2024 16:11:55 -0700
Message-ID: <20240514231155.1004295-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

Full disclosure I hit a KASAN OOB read warning in BPF when testing
on Meta's production servers (which load a lot of BPF).
BPF folks aren't super alarmed by it, and also they are partying at
LSFMM so I don't think it's worth waiting for the fix.
But you may feel differently...  https://pastebin.com/0fzqy3cW

In terms of conflicts - there's one trivial one in drivers/of/property.c
https://lore.kernel.org/all/20240424134038.28532f2f@canb.auug.org.au/
That's the only one at the time of writing.

Some more we got from Stephen:

drivers/net/wireless/intel/iwlwifi/mvm/Makefile
https://lore.kernel.org/all/20240506112810.02ae6c17@canb.auug.org.au/

net/core/page_pool.c
https://lore.kernel.org/all/20240509115307.71ae8787@canb.auug.org.au/

The only less trivial one is with MM in include/linux/slab.h
https://lore.kernel.org/all/20240429114302.7af809e8@canb.auug.org.au/
but I'm not sure this is actually coming to you in this merge window.


The following changes since commit 8c3b7565f81e030ef448378acd1b35dabb493e3b:

  Merge tag 'net-6.9-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-05-09 08:48:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.10

for you to fetch changes up to 654de42f3fc6edc29d743c1dbcd1424f7793f63d:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-05-14 10:53:19 -0700)

----------------------------------------------------------------
Networking changes for 6.10.

Core & protocols
----------------

 - Complete rework of garbage collection of AF_UNIX sockets.
   AF_UNIX is prone to forming reference count cycles due to fd passing
   functionality. New method based on Tarjan's Strongly Connected Components
   algorithm should be both faster and remove a lot of workarounds
   we accumulated over the years.

 - Add TCP fraglist GRO support, allowing chaining multiple TCP packets
   and forwarding them together. Useful for small switches / routers which
   lack basic checksum offload in some scenarios (e.g. PPPoE).

 - Support using SMP threads for handling packet backlog i.e. packet
   processing from software interfaces and old drivers which don't
   use NAPI. This helps move the processing out of the softirq jumble.

 - Continue work of converting from rtnl lock to RCU protection.
   Don't require rtnl lock when reading: IPv6 routing FIB, IPv6 address
   labels, netdev threaded NAPI sysfs files, bonding driver's sysfs files,
   MPLS devconf, IPv4 FIB rules, netns IDs, tcp metrics, TC Qdiscs,
   neighbor entries, ARP entries via ioctl(SIOCGARP), a lot of the link
   information available via rtnetlink.

 - Small optimizations from Eric to UDP wake up handling, memory accounting,
   RPS/RFS implementation, TCP packet sizing etc.

 - Allow direct page recycling in the bulk API used by XDP, for +2% PPS.

 - Support peek with an offset on TCP sockets.

 - Add MPTCP APIs for querying last time packets were received/sent/acked,
   and whether MPTCP "upgrade" succeeded on a TCP socket.

 - Add intra-node communication shortcut to improve SMC performance.

 - Add IPv6 (and IPv{4,6}-over-IPv{4,6}) support to the GTP protocol driver.

 - Add HSR-SAN (RedBOX) mode of operation to the HSR protocol driver.

 - Add reset reasons for tracing what caused a TCP reset to be sent.

 - Introduce direction attribute for xfrm (IPSec) states.
   State can be used either for input or output packet processing.

Things we sprinkled into general kernel code
--------------------------------------------

 - Add bitmap_{read,write}(), bitmap_size(), expose BYTES_TO_BITS().
   This required touch-ups and renaming of a few existing users.

 - Add Endian-dependent __counted_by_{le,be} annotations.

 - Make building selftests "quieter" by printing summaries like
   "CC object.o" rather than full commands with all the arguments.

Netfilter
---------

 - Use GFP_KERNEL to clone elements, to deal better with OOM situations
   and avoid failures in the .commit step.

BPF
---

 - Add eBPF JIT for ARCv2 CPUs.

 - Support attaching kprobe BPF programs through kprobe_multi link in
   a session mode, meaning, a BPF program is attached to both function entry
   and return, the entry program can decide if the return program gets
   executed and the entry program can share u64 cookie value with return
   program. "Session mode" is a common use-case for tetragon and bpftrace.

 - Add the ability to specify and retrieve BPF cookie for raw tracepoint
   programs in order to ease migration from classic to raw tracepoints.

 - Add an internal-only BPF per-CPU instruction for resolving per-CPU
   memory addresses and implement support in x86, ARM64 and RISC-V JITs.
   This allows inlining functions which need to access per-CPU state.

 - Optimize x86 BPF JIT's emit_mov_imm64, and add support for various
   atomics in bpf_arena which can be JITed as a single x86 instruction.
   Support BPF arena on ARM64.

 - Add a new bpf_wq API for deferring events and refactor process-context
   bpf_timer code to keep common code where possible.

 - Harden the BPF verifier's and/or/xor value tracking.

 - Introduce crypto kfuncs to let BPF programs call kernel crypto APIs.

 - Support bpf_tail_call_static() helper for BPF programs with GCC 13.

 - Add bpf_preempt_{disable,enable}() kfuncs in order to allow a BPF
   program to have code sections where preemption is disabled.

Driver API
----------

 - Skip software TC processing completely if all installed rules are
   marked as HW-only, instead of checking the HW-only flag rule by rule.

 - Add support for configuring PoE (Power over Ethernet), similar to
   the already existing support for PoDL (Power over Data Line) config.

 - Initial bits of a queue control API, for now allowing a single queue
   to be reset without disturbing packet flow to other queues.

 - Common (ethtool) statistics for hardware timestamping.

Tests and tooling
-----------------

 - Remove the need to create a config file to run the net forwarding tests
   so that a naive "make run_tests" can exercise them.

 - Define a method of writing tests which require an external endpoint
   to communicate with (to send/receive data towards the test machine).
   Add a few such tests.

 - Create a shared code library for writing Python tests. Expose the YAML
   Netlink library from tools/ to the tests for easy Netlink access.

 - Move netfilter tests under net/, extend them, separate performance tests
   from correctness tests, and iron out issues found by running them
   "on every commit".

 - Refactor BPF selftests to use common network helpers.

 - Further work filling in YAML definitions of Netlink messages for:
   nftables, team driver, bonding interfaces, vlan interfaces, VF info,
   TC u32 mark, TC police action.

 - Teach Python YAML Netlink to decode attribute policies.

 - Extend the definition of the "indexed array" construct in the specs
   to cover arrays of scalars rather than just nests.

 - Add hyperlinks between definitions in generated Netlink docs.

Drivers
-------

 - Make sure unsupported flower control flags are rejected by drivers,
   and make more drivers report errors directly to the application rather
   than dmesg (large number of driver changes from Asbjørn Sloth Tønnesen).

 - Ethernet high-speed NICs:
   - Broadcom (bnxt):
     - support multiple RSS contexts and steering traffic to them
     - support XDP metadata
     - make page pool allocations more NUMA aware
   - Intel (100G, ice, idpf):
     - extract datapath code common among Intel drivers into a library
     - use fewer resources in switchdev by sharing queues with the PF
     - add PFCP filter support
     - add Ethernet filter support
     - use a spinlock instead of HW lock in PTP clock ops
     - support 5 layer Tx scheduler topology
   - nVidia/Mellanox:
     - 800G link modes and 100G SerDes speeds
     - per-queue IRQ coalescing configuration
   - Marvell Octeon:
     - support offloading TC packet mark action

 - Ethernet NICs consumer, embedded and virtual:
   - stop lying about skb->truesize in USB Ethernet drivers, it messes up
     TCP memory calculations
   - Google cloud vNIC:
     - support changing ring size via ethtool
     - support ring reset using the queue control API
   - VirtIO net:
     - expose flow hash from RSS to XDP
     - per-queue statistics
     - add selftests
   - Synopsys (stmmac):
     - support controllers which require an RX clock signal from the MII
       bus to perform their hardware initialization
   - TI:
     - icssg_prueth: support ICSSG-based Ethernet on AM65x SR1.0 devices
     - icssg_prueth: add SW TX / RX Coalescing based on hrtimers
     - cpsw: minimal XDP support
   - Renesas (ravb):
     - support describing the MDIO bus
   - Realtek (r8169):
     - add support for RTL8168M
   - Microchip Sparx5:
     - matchall and flower actions mirred and redirect

 - Ethernet switches:
   - nVidia/Mellanox:
     - improve events processing performance
   - Marvell:
     - add support for MV88E6250 family internal PHYs
   - Microchip:
     - add DCB and DSCP mapping support for KSZ switches
     - vsc73xx: convert to PHYLINK
   - Realtek:
     - rtl8226b/rtl8221b: add C45 instances and SerDes switching

 - Many driver changes related to PHYLIB and PHYLINK deprecated API cleanup.

 - Ethernet PHYs:
   - Add a new driver for Airoha EN8811H 2.5 Gigabit PHY.
   - micrel: lan8814: add support for PPS out and external timestamp trigger

 - WiFi:
   - Disable Wireless Extensions (WEXT) in all Wi-Fi 7 devices drivers.
     Modern devices can only be configured using nl80211.
   - mac80211/cfg80211
     - handle color change per link for WiFi 7 Multi-Link Operation
   - Intel (iwlwifi):
     - don't support puncturing in 5 GHz
     - support monitor mode on passive channels
     - BZ-W device support
     - P2P with HE/EHT support
     - re-add support for firmware API 90
     - provide channel survey information for Automatic Channel Selection
   - MediaTek (mt76):
     - mt7921 LED control
     - mt7925 EHT radiotap support
     - mt7920e PCI support
   - Qualcomm (ath11k):
     - P2P support for QCA6390, WCN6855 and QCA2066
     - support hibernation
     - ieee80211-freq-limit Device Tree property support
   - Qualcomm (ath12k):
     - refactoring in preparation of multi-link support
     - suspend and hibernation support
     - ACPI support
     - debugfs support, including dfs_simulate_radar support
   - RealTek:
     - rtw88: RTL8723CS SDIO device support
     - rtw89: RTL8922AE Wi-Fi 7 PCI device support
     - rtw89: complete features of new WiFi 7 chip 8922AE including
       BT-coexistence and Wake-on-WLAN
     - rtw89: use BIOS ACPI settings to set TX power and channels
     - rtl8xxxu: enable Management Frame Protection (MFP) support

 - Bluetooth:
   - support for Intel BlazarI and Filmore Peak2 (BE201)
   - support for MediaTek MT7921S SDIO
   - initial support for Intel PCIe BT driver
   - remove HCI_AMP support

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aditya Kumar Singh (5):
      wifi: mac80211_hwsim: set link ID information during Rx
      wifi: mac80211: handle sdata->u.ap.active flag with MLO
      wifi: cfg80211: handle color change per link
      wifi: mac80211: handle color change per link
      wifi: mac80211_hwsim: add support for BSS color

Adrian Moreno (1):
      selftests: openvswitch: Fix escape chars in regexp.

Ajit Khaparde (1):
      bnxt_en: Add VF PCI ID for 5760X (P7) chips

Akiva Goldberger (2):
      net/mlx5: Add a timeout to acquire the command queue semaphore
      net/mlx5: Discard command completions in internal error

Alan Maguire (2):
      selftests/bpf: Use syscall(SYS_gettid) instead of gettid() wrapper in bench
      kbuild,bpf: Switch to using --btf_features for pahole v1.26 and later

Alessandro Carminati (Red Hat) (1):
      selftests/bpf: Prevent client connect before server bind in test_tc_tunnel.sh

Alex Elder (15):
      net: ipa: include some standard header files
      net: ipa: remove unneeded standard includes
      net: ipa: include "ipa_interrupt.h" where needed
      net: ipa: add some needed struct declarations
      net: ipa: eliminate unneeded struct declarations
      net: ipa: more include file cleanup
      net: ipa: sort all includes
      net: ipa: maintain bitmap of suspend-enabled endpoints
      net: ipa: only enable the SUSPEND IPA interrupt when needed
      net: ipa: call device_init_wakeup() earlier
      net: ipa: remove unneeded FILT_ROUT_HASH_EN definitions
      net: ipa: make ipa_table_hash_support() a real function
      net: ipa: fix two bogus argument names
      net: ipa: fix two minor ipa_cmd problems
      net: ipa: kill ipa_version_supported()

Alexander Couzens (1):
      net: phy: realtek: configure SerDes mode for rtl822xb PHYs

Alexander Lobakin (31):
      net: pin system percpu page_pools to the corresponding NUMA nodes
      compiler_types: add Endianness-dependent __counted_by_{le,be}
      idpf: make virtchnl2.h self-contained
      idpf: sprinkle __counted_by{,_le}() in the virtchnl2 header
      bitops: add missing prototype check
      bitops: make BYTES_TO_BITS() treewide-available
      bitops: let the compiler optimize {__,}assign_bit()
      linkmode: convert linkmode_{test,set,clear,mod}_bit() to macros
      s390/cio: rename bitmap_size() -> idset_bitmap_size()
      fs/ntfs3: add prefix to bitmap_size() and use BITS_TO_U64()
      btrfs: rename bitmap_set_bits() -> btrfs_bitmap_set_bits()
      tools: move alignment-related macros to new <linux/align.h>
      bitmap: introduce generic optimized bitmap_size()
      bitmap: make bitmap_{get,set}_value8() use bitmap_{read,write}()
      lib/bitmap: add compile-time test for __assign_bit() optimization
      ip_tunnel: use a separate struct to store tunnel params in the kernel
      ip_tunnel: convert __be16 tunnel flags to bitmaps
      net: net_test: add tests for IP tunnel flags conversion helpers
      page_pool: check for PP direct cache locality later
      page_pool: try direct bulk recycling
      ip_tunnel: harden copying IP tunnel params to userspace
      net: intel: introduce {, Intel} Ethernet common library
      iavf: kill "legacy-rx" for good
      iavf: drop page splitting and recycling
      slab: introduce kvmalloc_array_node() and kvcalloc_node()
      page_pool: constify some read-only function arguments
      page_pool: add DMA-sync-for-CPU inline helper
      libeth: add Rx buffer management
      iavf: pack iavf_ring more efficiently
      iavf: switch to Page Pool
      MAINTAINERS: add entry for libeth and libie

Alexander Mikhalitsyn (2):
      ipvs: add READ_ONCE barrier for ipvs->sysctl_amemthresh
      ipvs: allow some sysctls in non-init user namespaces

Alexander Potapenko (2):
      lib/test_bitmap: add tests for bitmap_{read,write}()
      lib/test_bitmap: use pr_info() for non-error messages

Alexandru Gagniuc (1):
      dt-bindings: net: ipq4019-mdio: add IPQ9574 compatible

Alexei Starovoitov (24):
      Merge branch 'bpf-raw-tracepoint-support-for-bpf-cookie'
      Merge branch 'bench-fast-in-kernel-triggering-benchmarks'
      Merge branch 'bpf-fix-a-couple-of-test-failures-with-lto-kernel'
      bpf: Avoid kfree_rcu() under lock in bpf_lpm_trie.
      Merge branch 'bpf-arm64-add-support-for-bpf-arena'
      Merge branch 'add-internal-only-bpf-per-cpu-instruction'
      bpf: Optimize emit_mov_imm64().
      Merge branch 'inline-bpf_get_branch_snapshot-bpf-helper'
      Merge branch 'bpf-allow-bpf_for_each_map_elem-helper-with-different-input-maps'
      bpf: Add support for certain atomics in bpf_arena to x86 JIT
      selftests/bpf: Add tests for atomics in bpf_arena.
      Merge branch 'bpf-add-bpf_link-support-for-sk_msg-and-sk_skb-progs'
      bpf: Fix JIT of is_mov_percpu_addr instruction.
      Merge branch 'introduce-bpf_wq'
      bpf: Don't check for recursion in bpf_wq_work.
      Merge branch 'introduce-bpf_preempt_-disable-enable'
      selftests/bpf: Fix wq test.
      bpf: Add bpf_guard_preempt() convenience macro
      Merge branch 'check-bpf_dummy_struct_ops-program-params-for-test-runs'
      bpf: Fix verifier assumptions about socket->sk
      Merge branch 'bpf-verifier-range-computation-improvements'
      Merge branch 'selftests-bpf-retire-bpf_tcp_helpers-h'
      Merge branch 'bpf-inline-helpers-in-arm64-and-riscv-jits'
      Merge branch 'retire-progs-test_sock_addr'

Alexis Lothoré (2):
      wifi: wilc1000: set atomic flag on kmemdup in srcu critical section
      wifi: wilc1000: convert list management to RCU

Allen Pais (1):
      archnet: Convert from tasklet to BH workqueue

Aloka Dixit (1):
      wifi: ath12k: use correct flag field for 320 MHz channels

Amit Cohen (20):
      mlxsw: pci: Move mlxsw_pci_eq_{init, fini}()
      mlxsw: pci: Move mlxsw_pci_cq_{init, fini}()
      mlxsw: pci: Do not setup tasklet from operation
      mlxsw: pci: Arm CQ doorbell regardless of number of completions
      mlxsw: pci: Remove unused counters
      mlxsw: pci: Make style changes in mlxsw_pci_eq_tasklet()
      mlxsw: pci: Poll command interface for each cmd_exec()
      mlxsw: pci: Rename MLXSW_PCI_EQS_COUNT
      mlxsw: pci: Use only one event queue
      mlxsw: pci: Remove unused wait queue
      mlxsw: pci: Make style change in mlxsw_pci_cq_tasklet()
      mlxsw: pci: Break mlxsw_pci_cq_tasklet() into tasklets per queue type
      mlxsw: pci: Remove mlxsw_pci_sdq_count()
      mlxsw: pci: Remove mlxsw_pci_cq_count()
      mlxsw: pci: Store DQ pointer as part of CQ structure
      mlxsw: pci: Handle up to 64 Rx completions in tasklet
      mlxsw: pci: Ring RDQ and CQ doorbells once per several completions
      mlxsw: pci: Initialize dummy net devices for NAPI
      mlxsw: pci: Reorganize 'mlxsw_pci_queue' structure
      mlxsw: pci: Use NAPI for event processing

Andrea Righi (4):
      libbpf: Start v1.5 development cycle
      libbpf: ringbuf: Allow to consume up to a certain amount of items
      libbpf: Add ring__consume_n / ring_buffer__consume_n
      selftests/bpf: Add ring_buffer__consume_n test.

Andrew Lunn (2):
      net: usb: lan78xx: Fixup EEE
      net: lan743x: Fixup EEE

Andrii Nakryiko (46):
      Merge branch 'ignore-additional-fields-in-the-struct_ops-maps-in-an-updated-version'
      bpf: preserve sleepable bit in subprog info
      Merge branch 'current_pid_tgid-for-all-prog-types'
      bpf: flatten bpf_probe_register call chain
      bpf: pass whole link instead of prog when triggering raw tracepoint
      bpf: support BPF cookie in raw tracepoint (raw_tp, tp_btf) programs
      libbpf: add support for BPF cookie for raw_tp/tp_btf programs
      selftests/bpf: add raw_tp/tp_btf BPF cookie subtests
      selftests/bpf: scale benchmark counting by using per-CPU counters
      bpf: Avoid get_kernel_nofault() to fetch kprobe entry IP
      selftests/bpf: rename and clean up userspace-triggered benchmarks
      selftests/bpf: add batched, mostly in-kernel BPF triggering benchmarks
      selftests/bpf: remove syscall-driven benchs, keep syscall-count only
      selftests/bpf: lazy-load trigger bench BPF programs
      bpf: add bpf_modify_return_test_tp() kfunc triggering tracepoint
      selftests/bpf: add batched tp/raw_tp/fmodret tests
      selftests/bpf: make multi-uprobe tests work in RELEASE=1 mode
      bpftool: Use __typeof__() instead of typeof() in BPF skeleton
      bpf: add special internal-only MOV instruction to resolve per-CPU addrs
      bpf: inline bpf_get_smp_processor_id() helper
      bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY maps
      bpf: inline bpf_map_lookup_elem() helper for PERCPU_HASH map
      bpf: handle CONFIG_SMP=n configuration in x86 BPF JIT
      bpf: make bpf_get_branch_snapshot() architecture-agnostic
      bpf: inline bpf_get_branch_snapshot() helper
      bpf: prevent r10 register from being marked as precise
      selftests/bpf: add fp-leaking precise subprog result tests
      Merge branch 'bpf-allow-invoking-kfuncs-from-bpf_prog_type_syscall-progs'
      Merge branch 'libbpf-api-to-partially-consume-items-from-ringbuffer'
      Merge branch 'free-strdup-memory-in-selftests'
      libbpf: handle nulled-out program in struct_ops correctly
      selftests/bpf: validate nulled-out struct_ops program is handled properly
      Merge branch 'bpf-introduce-kprobe_multi-session-attach'
      Merge branch 'libbpf-support-module-function-syntax-for-tracing-programs'
      libbpf: better fix for handling nulled-out struct_ops program
      libbpf: fix potential overflow in ring__consume_n()
      libbpf: fix ring_buffer__consume_n() return result logic
      Merge branch 'bpf-avoid-attribute-ignored-warnings-in-gcc'
      Merge branch 'fix-number-of-arguments-in-test'
      libbpf: remove unnecessary struct_ops prog validity check
      libbpf: handle yet another corner case of nulling out struct_ops program
      selftests/bpf: add another struct_ops callback use case test
      libbpf: fix libbpf_strerror_r() handling unknown errors
      libbpf: improve early detection of doomed-to-fail BPF program loading
      selftests/bpf: validate struct_ops early failure detection logic
      selftests/bpf: shorten subtest names for struct_ops_module test

Andy Shevchenko (7):
      net: stmmac: dwmac-rk: Remove unused of_gpio.h
      nfc: st95hf: Switch to using gpiod API
      net: mdio-gpio: Use device_is_compatible()
      bpf: Use struct_size()
      bpf: Switch to krealloc_array()
      wifi: mt76: mt7915: Remove unused of_gpio.h
      net: ethernet: adi: adin1110: Replace linux/gpio.h by proper one

Anjaneyulu (7):
      wifi: mac80211: handle indoor AFC/LPI AP on assoc success
      wifi: cfg80211: handle indoor AFC/LPI AP in probe response and beacon
      wifi: iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD cmd v9
      wifi: iwlwifi: move WTAS macro to api file
      wifi: iwlwifi: move lari_config handlig to regulatory
      wifi: iwlwifi: mvm: Add support for PPAG cmd v6
      wifi: iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD v10

Anton Protopopov (5):
      bpf: Add support for passing mark with bpf_fib_lookup
      selftests/bpf: Add BPF_FIB_LOOKUP_MARK tests
      bpf: Add a check for struct bpf_fib_lookup size
      bpf: Add a verbose message if map limit is reached
      bpf: Pack struct bpf_fib_lookup

Antonio Quartulli (1):
      ynl: ensure exact-len value is resolved

Antony Antony (5):
      udpencap: Remove Obsolete UDP_ENCAP_ESPINUDP_NON_IKE Support
      xfrm: Add Direction to the SA in or out
      xfrm: Add dir validation to "out" data path lookup
      xfrm: Add dir validation to "in" data path lookup
      xfrm: Restrict SA direction attribute to specific netlink message types

Archie Pusaka (1):
      Bluetooth: Populate hci_set_hw_info for Intel and Realtek

Ard Biesheuvel (1):
      btf: Avoid weak external references

Arnd Bergmann (10):
      enetc: avoid truncating error message
      qed: avoid truncating work queue length
      mlx5: avoid truncating error message
      mlx5: stop warning for 64KB pages
      wifi: carl9170: re-fix fortified-memset warning
      wifi: ath9k: work around memset overflow warning
      bpf: fix perf_snapshot_branch_stack link failure
      3c515: remove unused 'mtu' variable
      isdn: kcapi: don't build unused procfs code
      net: xgbe: remove extraneous #ifdef checks

Arınç ÜNAL (20):
      net: phy: mediatek-ge: do not disable EEE advertisement
      net: dsa: mt7530-mdio: read PHY address of switch from device tree
      net: dsa: mt7530: simplify core operations
      net: dsa: mt7530: disable EEE abilities on failure on MT7531 and MT7988
      net: dsa: mt7530: refactor MT7530_PMCR_P()
      net: dsa: mt7530: rename p5_intf_sel and use only for MT7530 switch
      net: dsa: mt7530: rename mt753x_bpdu_port_fw enum to mt753x_to_cpu_fw
      net: dsa: mt7530: refactor MT7530_MFC and MT7531_CFC, add MT7531_QRY_FFP
      net: dsa: mt7530: refactor MT7530_HWTRAP and MT7530_MHWTRAP
      net: dsa: mt7530: move MT753X_MTRAP operations for MT7530
      net: dsa: mt7530: return mt7530_setup_mdio & mt7531_setup_common on error
      net: dsa: mt7530: define MAC speed capabilities per switch model
      net: dsa: mt7530: get rid of function sanity check
      net: dsa: mt7530: refactor MT7530_PMEEECR_P()
      net: dsa: mt7530: get rid of mac_port_validate member of mt753x_info
      net: dsa: mt7530: use priv->ds->num_ports instead of MT7530_NUM_PORTS
      net: dsa: mt7530: do not pass port variable to mt7531_rgmii_setup()
      net: dsa: mt7530: explain exposing MDIO bus of MT7531AE better
      net: dsa: mt7530: do not set MT7530_P5_DIS when PHY muxing is being used
      net: dsa: mt7530: detect PHY muxing when PHY is defined on switch MDIO bus

Asbjørn Sloth Tønnesen (52):
      net: sched: cls_api: add skip_sw counter
      net: sched: cls_api: add filter counter
      net: sched: make skip_sw actually skip software
      cxgb4: flower: use NL_SET_ERR_MSG_MOD for validation errors
      flow_offload: fix flow_offload_has_one_action() kdoc
      flow_offload: add control flag checking helpers
      nfp: flower: fix check for unsupported control flags
      net: prestera: flower: validate control flags
      net: dsa: microchip: ksz9477: flower: validate control flags
      mlxsw: spectrum_flower: validate control flags
      sfc: use flow_rule_is_supp_control_flags()
      net: mscc: ocelot: flower: validate control flags
      net: dsa: felix: flower: validate control flags
      net: dsa: sja1105: flower: validate control flags
      cxgb4: flower: validate control flags
      dpaa2-switch: flower: validate control flags
      net: ethernet: mtk_eth_soc: flower: validate control flags
      bnxt_en: flower: validate control flags
      net: ethernet: ti: am65-cpsw: flower: validate control flags
      net: ethernet: ti: cpsw: flower: validate control flags
      net: hns3: flower: validate control flags
      octeontx2-pf: flower: check for unsupported control flags
      net: sparx5: flower: only do lookup if fragment flags are set
      net: sparx5: flower: add extack to sparx5_tc_flower_handler_control_usage()
      net: sparx5: flower: remove goto in sparx5_tc_flower_handler_control_usage()
      net: sparx5: flower: check for unsupported control flags
      net: lan966x: flower: add extack to lan966x_tc_flower_handler_control_usage()
      net: lan966x: flower: rename goto in lan966x_tc_flower_handler_control_usage()
      net: lan966x: flower: check for unsupported control flags
      net/mlx5e: flower: check for unsupported control flags
      net: qede: use return from qede_parse_actions() for flow_spec
      net: qede: use return from qede_flow_spec_validate_unused()
      net: qede: use return from qede_flow_parse_ports()
      i40e: flower: validate control flags
      iavf: flower: validate control flags
      ice: flower: validate control flags
      igb: flower: validate control flags
      net: qede: use extack in qede_flow_parse_ports()
      net: qede: use extack in qede_set_v6_tuple_to_profile()
      net: qede: use extack in qede_set_v4_tuple_to_profile()
      net: qede: use extack in qede_flow_parse_v6_common()
      net: qede: use extack in qede_flow_parse_v4_common()
      net: qede: use extack in qede_flow_parse_tcp_v6()
      net: qede: use extack in qede_flow_parse_tcp_v4()
      net: qede: use extack in qede_flow_parse_udp_v6()
      net: qede: use extack in qede_flow_parse_udp_v4()
      net: qede: add extack in qede_add_tc_flower_fltr()
      net: qede: use extack in qede_parse_flow_attr()
      net: qede: use faked extack in qede_flow_spec_to_rule()
      net: qede: propagate extack through qede_flow_spec_validate()
      net: qede: use extack in qede_parse_actions()
      net: qede: flower: validate control flags

Avraham Stern (1):
      wifi: iwlwifi: mvm: add debugfs for forcing unprotected ranging request

Ayala Beker (3):
      wifi: mac80211: fix BSS_CHANGED_MLD_TTLM description
      wifi: mac80211: add support for tearing down negotiated TTLM
      wifi: mac80211: don't select link ID if not provided in scan request

Balazs Scheidler (2):
      net: port TP_STORE_ADDR_PORTS_SKB macro to be tcp/udp independent
      net: udp: add IP/port data to the tracepoint udp/udp_fail_queue_rcv_skb

Baochen Qiang (19):
      wifi: ath10k: poll service ready message before failing
      wifi: ath11k: don't force enable power save on non-running vdevs
      wifi: ath11k: do not process consecutive RDDM event
      bus: mhi: host: Add mhi_power_down_keep_dev() API to support system suspend/hibernation
      net: qrtr: support suspend/hibernation
      wifi: ath11k: support hibernation
      wifi: ath12k: fix kernel crash during resume
      wifi: ath12k: rearrange IRQ enable/disable in reset path
      wifi: ath12k: remove MHI LOOPBACK channels
      wifi: ath12k: do not dump SRNG statistics during resume
      wifi: ath12k: fix warning on DMA ring capabilities event
      wifi: ath12k: decrease MHI channel buffer length to 8KB
      wifi: ath12k: flush all packets before suspend
      wifi: ath12k: no need to handle pktlog during suspend/resume
      wifi: ath12k: avoid stopping mac80211 queues in ath12k_core_restart()
      wifi: ath12k: support suspend/resume
      wifi: ath12k: change supports_suspend to true for WCN7850
      wifi: ath12k: check M3 buffer size as well whey trying to reuse it
      wifi: ath12k: fix flush failure in recovery scenarios

Ben Greear (2):
      wifi: mt76: mt7915: add missing chanctx ops
      wifi: iwlwifi: Use request_module_nowait

Benjamin Berg (11):
      wifi: mac80211: improve association error reporting slightly
      wifi: cfg80211: check BSSID Index against MaxBSSID
      wifi: cfg80211: ignore non-TX BSSs in per-STA profile
      wifi: iwlwifi: mvm: always apply 6 GHz probe limitations
      wifi: iwlwifi: mvm: assign link STA ID lookups during restart
      wifi: iwlwifi: mvm: fix active link counting during recovery
      wifi: iwlwifi: mvm: mark EMLSR disabled in cleanup iterator
      wifi: iwlwifi: mvm: move phy band to nl80211 band helper
      wifi: mac80211: keep mac80211 consistent on link activation failure
      wifi: iwlwifi: mvm: add the firmware API for channel survey
      wifi: iwlwifi: mvm: record and return channel survey information

Benjamin Tissoires (19):
      bpf: make timer data struct more generic
      bpf: replace bpf_timer_init with a generic helper
      bpf: replace bpf_timer_set_callback with a generic helper
      bpf: replace bpf_timer_cancel_and_free with a generic helper
      bpf: add support for bpf_wq user type
      tools: sync include/uapi/linux/bpf.h
      bpf: verifier: bail out if the argument is not a map
      bpf: add support for KF_ARG_PTR_TO_WORKQUEUE
      bpf: allow struct bpf_wq to be embedded in arraymaps and hashmaps
      selftests/bpf: add bpf_wq tests
      bpf: wq: add bpf_wq_init
      selftests/bpf: wq: add bpf_wq_init() checks
      bpf: wq: add bpf_wq_set_callback_impl
      selftests/bpf: add checks for bpf_wq_set_callback()
      bpf: add bpf_wq_start
      selftests/bpf: wq: add bpf_wq_start() checks
      bpf: Do not walk twice the map on free
      bpf: Do not walk twice the hash map on free
      selftests/bpf: Drop an unused local variable

Bharath SM (1):
      dns_resolver: correct module name in dns resolver documentation

Bitterblue Smith (10):
      wifi: rtl8xxxu: Fix the TX power of RTL8192CU, RTL8723AU
      wifi: rtl8xxxu: Add separate MAC init table for RTL8192CU
      wifi: rtl8xxxu: Add LED control code for RTL8192CU family
      wifi: rtl8xxxu: Add LED control code for RTL8723BU
      wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
      wifi: rtlwifi: rtl8192de: Fix low speed with WPA3-SAE
      wifi: rtlwifi: rtl8192de: Fix endianness issue in RX path
      wifi: rtlwifi: Move code from rtl8192de to rtl8192d-common
      wifi: rtlwifi: Clean up rtl8192d-common a bit
      wifi: rtlwifi: Adjust rtl8192d-common for USB

Bjorn Helgaas (5):
      net: amd8111e: Drop unused copy of pm_cap
      qed: Drop useless pci_params.pm_cap
      e1000e: Remove redundant runtime resume for ethtool_ops
      igb: Remove redundant runtime resume for ethtool_ops
      igc: Remove redundant runtime resume for ethtool ops

Bo Jiao (1):
      wifi: mt76: mt7915: only set MT76_MCU_RESET for the main phy

Breno Leitao (29):
      wifi: qtnfmac: allocate dummy net_device dynamically
      ip6_vti: Do not use custom stat allocator
      ip6_vti: Remove generic .ndo_get_stats64
      net: usb: qmi_wwan: Leverage core stats allocator
      net: usb: qmi_wwan: Remove generic .ndo_get_stats64
      net: ipv6_gre: Do not use custom stat allocator
      net: ip6_gre: Remove generic .ndo_get_stats64
      net: dql: Avoid calling BUG() when WARN() is enough
      net: dql: Separate queue function responsibilities
      net: dql: Optimize stall information population
      net: dqs: make struct dql more cache efficient
      net: core: Fix documentation
      net: free_netdev: exit earlier if dummy
      net: create a dummy net_device allocator
      net: marvell: prestera: allocate dummy net_device dynamically
      net: mediatek: mtk_eth_sock: allocate dummy net_device dynamically
      net: ipa: allocate dummy net_device dynamically
      net: ibm/emac: allocate dummy net_device dynamically
      wifi: qtnfmac: Use netdev dummy allocator helper
      wifi: ath10k: allocate dummy net_device dynamically
      wifi: ath11k: allocate dummy net_device dynamically
      net: wwan: t7xx: Un-embed dummy device
      net: loopback: Do not allocate lstats explicitly
      netpoll: Fix race condition in netpoll_owner_active
      wifi: qtnfmac: Move stats allocation to core
      wifi: qtnfmac: Remove generic .ndo_get_stats64
      IB/hfi1: allocate dummy net_device dynamically
      wifi: iwlwifi: pcie: allocate dummy net_device dynamically
      af_unix: Fix data races in unix_release_sock/unix_stream_sendmsg

Carolina Jubran (3):
      net/mlx5e: XDP, Fix an inconsistent comment
      net/mlx5e: Expose the VF/SF RX drop counter on the representor
      net/mlx5e: Modifying channels number and updating TX queues

Catalin Popescu (1):
      net: phy: dp8382x: keep WOL settings across suspends

Chad Monroe (1):
      wifi: mt76: mt7996: fix size of txpower MCU command

Chaitanya Tata (1):
      wifi: mac80211_hwsim: Use wider regulatory for custom for 6GHz tests

Chen Ni (1):
      dpll: fix return value check for kmemdup

Chen Pei (1):
      bpf, tests: Fix typos in comments

Chen-Yu Tsai (1):
      dt-bindings: net: bluetooth: Add MediaTek MT7921S SDIO Bluetooth

Chia-Yuan Li (3):
      wifi: rtw89: disable txptctrl IMR to avoid flase alarm
      wifi: rtw89: download firmware with five times retry
      wifi: rtw89: 8852c: refine power sequence to imporve power consumption

Chih-Kang Chang (11):
      wifi: rtw89: 8922a: update scan offload H2C fields
      wifi: rtw89: wow: refine WoWLAN flows of HCI interrupts and low power mode
      wifi: rtw89: wow: parsing Auth Key Management from associate request
      wifi: rtw89: wow: prepare PTK GTK info from mac80211
      wifi: rtw89: use struct to access firmware command h2c_dctl_sec_cam_v1
      wifi: rtw89: use struct to fill H2C of WoWLAN global configuration
      wifi: rtw89: wow: construct EAPoL packet for GTK rekey offload
      wifi: rtw89: wow: add GTK rekey feature related H2C commands
      wifi: rtw89: wow: update latest PTK GTK info to mac80211 after resume
      wifi: rtw89: wow: support 802.11w PMF IGTK rekey
      wifi: rtw89: wow: support WEP cipher on WoWLAN

Chin-Yen Lee (3):
      wifi: rtw89: reset AFEDIG register in power off sequence
      wifi: rtw89: wow: send RFK pre-nofity H2C command in WoWLAN mode
      wifi: rtw89: wow: add ARP offload feature

Ching-Te Ku (23):
      wifi: rtw89: coex: Add WiFi role info format version 8
      wifi: rtw89: coex: Add antenna setting function for RTL8922A
      wifi: rtw89: coex: Add TDMA version 7
      wifi: rtw89: coex: Add TDMA slot parameter setting version 7
      wifi: rtw89: 8922a: update chip parameter for coex
      wifi: rtw88: coex: Prevent doing I/O during Wi-Fi power saving
      wifi: rtw89: coex: Allow Bluetooth doing traffic during Wi-Fi scan
      wifi: rtw89: coex: Add v7 firmware cycle status report
      wifi: rtw89: coex: Add version 3 report map of H2C command
      wifi: rtw89: coex: Add PTA path control condition for chip RTL8922A
      wifi: rtw89: coex: Update Bluetooth polluted Wi-Fi TX logic
      wifi: rtw89: coex: Add register monitor report v7 format
      wifi: rtw89: coex: Add GPIO signal control version 7
      wifi: rtw89: coex: Add coexistence firmware control report version 8
      wifi: rtw89: coex: Re-order the index for the report from firmware
      wifi: rtw89: coex: Add Wi-Fi null data status version 7
      wifi: rtw89: coex: Add Bluetooth scan parameter report version 7
      wifi: rtw89: coex: Add Bluetooth frequency hopping map version 7
      wifi: rtw89: coex: Add Bluetooth version report version 7
      wifi: rtw89: coex: Fix unexpected value in version 7 slot parameter
      wifi: rtw89: coex: Add Wi-Fi role v8 condition when set Bluetooth channel
      wifi: rtw89: coex: Add Wi-Fi role v8 condition when set BTG control
      wifi: rtw89: coex: Check and enable reports after run coex

Chintan Vankar (3):
      net: ethernet: ti: am65-cpts: Enable RX HW timestamp for PTP packets using CPTS FIFO
      net: ethernet: ti: am65-cpsw/ethtool: Enable RX HW timestamp only for PTP packets
      net: ethernet: ti: am65-cpsw-nuss: Enable SGMII mode for J784S4 CPSW9G

Christian Lamparter (2):
      dt-bindings: net: wireless: ath11k: add ieee80211-freq-limit property
      wifi: ath11k: add support DT ieee80211-freq-limit

Christian Marangi (1):
      net: stmmac: dwmac-ipq806x: account for rgmii-txid/rxid/id phy-mode

Christophe JAILLET (5):
      caif: Use UTILITY_NAME_LENGTH instead of hard-coding 16
      net: fman: Remove some unused fields in some structure
      wifi: ath11k: Fix error handling in ath11k_wmi_p2p_noa_event()
      wifi: brcmsmac: ampdu: remove unused cb_del_ampdu_pars struct
      wifi: brcmfmac: remove unused brcmf_usb_image struct

Christophe Leroy (4):
      bpf: Take return from set_memory_ro() into account with bpf_prog_lock_ro()
      bpf: Take return from set_memory_rox() into account with bpf_jit_binary_lock_ro()
      bpf: Remove arch_unprotect_bpf_trampoline()
      bpf: Check return from set_memory_rox()

Christophe Roullier (1):
      dt-bindings: net: dwmac: Document STM32 property st,ext-phyclk

Clément Léger (2):
      dt-bindings: net: renesas,rzn1-gmac: Document RZ/N1 GMAC support
      net: stmmac: add support for RZ/N1 GMAC

Coia Prant (1):
      net: usb: qmi_wwan: add Lonsung U8300/U9300 product

Colin Ian King (8):
      selftests/bpf: Remove second semicolon
      wifi: brcmfmac: Fix spelling mistake "ivalid" -> "invalid"
      tls: remove redundant assignment to variable decrypted
      tipc: remove redundant assignment to ret, simplify code
      net/handshake: remove redundant assignment to variable ret
      wifi: rtlwifi: rtl8723be: Make read-only arrays static const
      net: dsa: microchip: Fix spellig mistake "configur" -> "configure"
      selftest: epoll_busy_poll: Fix spelling mistake "couldnt" -> "couldn't"

Corinna Vinschen (1):
      igc: fix a log entry using uninitialized netdev

Cosmin Ratiu (2):
      net/mlx5e: Extract checking of FEC support for a link mode
      net/mlx5e: Support FEC settings for 100G/lane modes

Cupertino Miranda (9):
      bpf/verifier: replace calls to mark_reg_unknown.
      bpf/verifier: refactor checks for range computation
      bpf/verifier: improve XOR and OR range computation
      selftests/bpf: XOR and OR range computation tests.
      bpf/verifier: relax MUL range computation check
      selftests/bpf: MUL range computation tests.
      selftests/bpf: Add CFLAGS per source file and runner
      selftests/bpf: Change functions definitions to support GCC
      selftests/bpf: Fix a few tests for GCC related warnings.

Dan Carpenter (3):
      net: phy: air_en8811h: fix some error codes
      wifi: mwl8k: initialize cmd->addr[] properly
      Bluetooth: qca: Fix error code in qca_read_fw_build_info()

Dan Nowlin (1):
      ice: Fix package download algorithm

Daniel Amosi (1):
      wifi: iwlwifi: Print a specific device name.

Daniel Gabay (3):
      wifi: iwlwifi: Print EMLSR states name
      wifi: iwlwifi: Force SCU_ACTIVE for specific platforms
      wifi: iwlwifi: Ensure prph_mac dump includes all addresses

Daniel Golle (3):
      net: sfp: add quirk for ATS SFP-GE-T 1000Base-TX module
      net: ethernet: mediatek: use ADMAv1 instead of ADMAv2.0 on MT7981 and MT7986
      net: phy: air_en8811h: reset netdev rules when LED is set manually

Daniel Jurgens (9):
      virtio_net: Store RSS setting in virtnet_info
      virtio_net: Remove command data from control_buf
      virtio_net: Add a lock for the command VQ.
      virtio_net: Do DIM update for specified queue only
      virtio_net: Add a lock for per queue RX coalesce
      virtio_net: Remove rtnl lock protection of command buffers
      virtio_net: Fix memory leak in virtnet_rx_mod_work
      netdev: Add queue stats for TX stop and wake
      virtio_net: Add TX stopped and wake counters

Daniel Machon (7):
      net: sparx5: add support for tc flower mirred action.
      net: sparx5: add support for tc flower redirect action
      net: sparx5: add new register definitions
      net: sparx5: add bookkeeping code for matchall rules
      net: sparx5: add port mirroring implementation
      net: sparx5: add the tc glue to support port mirroring
      net: sparx5: add support for matchall mirror stats

Danielle Ratson (1):
      selftests: mlxsw: ethtool_lanes: Wait for lanes parameter dump explicitly

Dariusz Aftanski (1):
      ice: Remove ndo_get_phys_port_name

Dave Thaler (5):
      bpf, docs: Editorial nits in instruction-set.rst
      bpf, docs: Clarify helper ID and pointer terms in instruction-set.rst
      bpf, docs: Fix formatting nit in instruction-set.rst
      bpf, docs: Add introduction for use in the ISA Internet Draft
      bpf, docs: Clarify PC use in instruction-set.rst

David Arinzon (5):
      net: ena: Add a counter for driver's reset failures
      net: ena: Reduce holes in ena_com structures
      net: ena: Add validation for completion descriptors consistency
      net: ena: Changes around strscpy calls
      net: ena: Change initial rx_usec interval

David Faust (1):
      bpf: avoid gcc overflow warning in test_xdp_vlan.c

David Lechner (1):
      bpf: Fix typo in uapi doc comments

David S. Miller (27):
      Merge branch 'net-sched-skip_sw'
      Merge branch 'ice-pfcp-filter'
      Merge branch 'net-rps-misc'
      Merge branch 'gve-ring-size-changes'
      Merge branch 'phy-listing-link_topology-tracking'
      Merge tag 'batadv-next-pullrequest-20240405' of git://git.open-mesh.org/linux-merge
      Merge branch 'ynl-tests'
      Merge branch 'mptcp-selftests'
      Merge branch 'phy-cleanup-EEE'
      Merge branch 'devlink-io-eqs'
      Merge branch 'rtl8226b-serdes-switching'
      Merge branch 'nfp-minor-improvements'
      Merge branch 'flower-control-flags'
      Merge branch 'cpsw-xdp'
      Merge branch 'net_sched-dump-no-rtnl'
      Merge branch 'net-rps-lockless'
      Merge branch 'net-neigh-rcu'
      Merge branch 'dsa-mt7530-improvements'
      Merge branch 'net-dunamic-dummy-device'
      Merge branch 'sparx5-port-mirroring'
      Merge branch 'tcp-trace-next'
      Merge branch 'mlxsw-events-processing-performance'
      Merge branch 'dsa-realtek-leds'
      Merge branch 'net-sysctl-sentinel'
      Merge branch 'gve-queue-api'
      Merge branch 'ksz-dcb-dscp'
      Merge tag 'gtp-24-05-07' of git://git.kernel.org/pub/scm/linux/kernel/git/pablo/gtp Pablo neira Ayuso says:

David Vernet (2):
      bpf: Allow invoking kfuncs from BPF_PROG_TYPE_SYSCALL progs
      selftests/bpf: Verify calling core kfuncs from BPF_PROG_TYPE_SYCALL

David Wei (3):
      bnxt: fix bnxt_get_avail_msix() returning negative values
      netdevsim: add NAPI support
      net: selftest: add test for netdev netlink queue-get API

Davide Caratti (3):
      net/sched: fix false lockdep warning on qdisc root lock
      net/sched: unregister lockdep keys in qdisc_create/qdisc_alloc error path
      netlabel: fix RCU annotation for IPv4 options on socket creation

Dawei Li (2):
      net/iucv: Avoid explicit cpumask var allocation on stack
      net/dpaa2: Avoid explicit cpumask var allocation on stack

Deren Wu (2):
      wifi: mt76: mt7921: introduce mt7920 PCIe support
      wifi: mt76: mt7925: add EHT radiotap support in monitor mode

Dian-Syuan Yang (1):
      wifi: rtw89: Correct EHT TX rate on 20MHz connection

Diogo Ivo (10):
      dt-bindings: net: Add support for AM65x SR1.0 in ICSSG
      eth: Move IPv4/IPv6 multicast address bases to their own symbols
      net: ti: icssg-prueth: Move common functions into a separate file
      net: ti: icssg-prueth: Add SR1.0-specific configuration bits
      net: ti: icssg-prueth: Add SR1.0-specific description bits
      net: ti: icssg-prueth: Adjust IPG configuration for SR1.0
      net: ti: icssg-prueth: Adjust the number of TX channels for SR1.0
      net: ti: icssg-prueth: Add functions to configure SR1.0 packet classifier
      net: ti: icssg-prueth: Modify common functions for SR1.0
      net: ti: icssg-prueth: Add ICSSG Ethernet driver for AM65x SR1.0 platforms

Dmitrii Bundin (1):
      bpf: Include linux/types.h for u32

Dmitry Antipov (3):
      wifi: rtlwifi: drop WMM stubs from rtl8192cu
      wifi: rtlwifi: always assume QoS mode in rtl8192cu
      batman-adv: prefer kfree_rcu() over call_rcu() with free-only callbacks

Dmitry Baryshkov (5):
      dt-bindings: net: wireless: ath10k: describe firmware-name property
      wifi: ath10k: support board-specific firmware overrides
      wifi: ath10k: populate board data for WCN3990
      wifi: ath10k: drop chip-specific board data file name
      wifi: ath10k: drop fw.eboard file name

Donald Hunter (9):
      tools/net/ynl: Add extack policy attribute decoding
      doc: netlink: Change generated docs to limit TOC to depth 3
      doc: netlink: Add hyperlinks to generated Netlink docs
      doc: netlink: Update tc spec with missing definitions
      doc/netlink/specs: Add draft nftables spec
      tools/net/ynl: Fix extack decoding for directional ops
      tools/net/ynl: Add multi message support to ynl
      netfilter: nfnetlink: Handle ACK flags for batch messages
      netlink/specs: Add VF attributes to rt_link spec

Dr. David Alan Gilbert (1):
      atm/fore200e: Delete unused 'fore200e_boards'

Duoming Zhou (4):
      wifi: brcmfmac: pcie: handle randbuf allocation failure
      ax25: Use kernel universal linked list to implement ax25_dev_list
      ax25: Fix reference count leak issues of ax25_dev
      ax25: Fix reference count leak issue of net_device

Eduard Zingerman (5):
      bpf: mark bpf_dummy_struct_ops.test_1 parameter as nullable
      selftests/bpf: adjust dummy_st_ops_success to detect additional error
      selftests/bpf: do not pass NULL for non-nullable params in dummy_st_ops
      bpf: check bpf_dummy_struct_ops program params for test runs
      selftests/bpf: dummy_st_ops should reject 0 for non-nullable params

Edwin Peer (1):
      bnxt_en: share NQ ring sw_stats memory with subrings

Emmanuel Grumbach (6):
      wifi: iwlwifi: mvm: support iwl_dev_tx_power_cmd_v8
      wifi: iwlwifi: remove devices that never came out
      wifi: iwlwifi: remove wrong CRF_IDs
      wifi: iwlwifi: add support for BZ_W
      wifi: iwlwifi: add a device ID for BZ-W
      wifi: iwlwifi: mvm: introduce esr_disable_reason

Eric Dumazet (99):
      net: remove skb_free_datagram_locked()
      tcp/dccp: bypass empty buckets in inet_twsk_purge()
      udp: annotate data-race in __udp_enqueue_schedule_skb()
      udp: relax atomic operation on sk->sk_rmem_alloc
      udp: avoid calling sock_def_readable() if possible
      net: add sk_wake_async_rcu() helper
      batman-adv: bypass empty buckets in batadv_purge_orig_ref()
      net: move kick_defer_list_purge() to net/core/dev.h
      net: move dev_xmit_recursion() helpers to net/core/dev.h
      net: enqueue_to_backlog() change vs not running device
      net: make softnet_data.dropped an atomic_t
      net: enqueue_to_backlog() cleanup
      net: rps: change input_queue_tail_incr_save()
      net: rps: add rps_input_queue_head_add() helper
      net: rps: move received_rps field to a better location
      inet: preserve const qualifier in inet_csk()
      tcp/dccp: do not care about families in inet_twsk_purge()
      ipv6: remove RTNL protection from inet6_dump_fib()
      tcp: annotate data-races around tp->window_clamp
      inet: frags: delay fqdir_free_fn()
      ipv6: remove RTNL protection from ip6addrlbl_dump()
      net: dqs: use sysfs_emit() in favor of sprintf()
      tcp: more struct tcp_sock adjustments
      af_packet: avoid a false positive warning in packet_setsockopt()
      net: display more skb fields in skb_dump()
      tcp: propagate tcp_tw_isn via an extra parameter to ->route_req()
      tcp: replace TCP_SKB_CB(skb)->tcp_tw_isn with a per-cpu field
      bonding: no longer use RTNL in bonding_show_bonds()
      bonding: no longer use RTNL in bonding_show_slaves()
      bonding: no longer use RTNL in bonding_show_queue_id()
      tcp: tweak tcp_sock_write_txrx size assertion
      mpls: no longer hold RTNL in mpls_netconf_dump_devconf()
      tcp: small optimization when TCP_TW_SYN is processed
      fib: rules: no longer hold RTNL in fib_nl_dumprule()
      tcp: accept bare FIN packets under memory pressure
      netns: no longer hold RTNL in rtnl_net_dumpid()
      tcp_metrics: fix tcp_metrics_nl_dump() return value
      tcp_metrics: use parallel_ops for tcp_metrics_nl_family
      net_sched: sch_fq: implement lockless fq_dump()
      net_sched: cake: implement lockless cake_dump()
      net_sched: sch_cbs: implement lockless cbs_dump()
      net_sched: sch_choke: implement lockless choke_dump()
      net_sched: sch_codel: implement lockless codel_dump()
      net_sched: sch_tfs: implement lockless etf_dump()
      net_sched: sch_ets: implement lockless ets_dump()
      net_sched: sch_fifo: implement lockless __fifo_dump()
      net_sched: sch_fq_codel: implement lockless fq_codel_dump()
      net_sched: sch_fq_pie: implement lockless fq_pie_dump()
      net_sched: sch_hfsc: implement lockless accesses to q->defcls
      net_sched: sch_hhf: implement lockless hhf_dump()
      net_sched: sch_pie: implement lockless pie_dump()
      net_sched: sch_skbprio: implement lockless skbprio_dump()
      neighbour: add RCU protection to neigh_tables[]
      neighbour: fix neigh_dump_info() return value
      neighbour: no longer hold RTNL in neigh_dump_info()
      tcp: do not export tcp_twsk_purge()
      tcp: remove dubious FIN exception from tcp_cwnd_test()
      tcp: call tcp_set_skb_tso_segs() from tcp_write_xmit()
      tcp: try to send bigger TSO packets
      neighbour: fix neigh_master_filtered()
      tcp: avoid premature drops in tcp_add_backlog()
      net: add two more call_rcu_hurry()
      tcp: fix tcp_grow_skb() vs tstamps
      net: give more chances to rcu in netdev_wait_allrefs_any()
      inet: use call_rcu_hurry() in inet_free_ifa()
      ipv6: use call_rcu_hurry() in fib6_info_release()
      ipv6: introduce dst_rt6_info() helper
      net: hsr: init prune_proxy_timer sooner
      inet: introduce dst_rtable() helper
      net: move sysctl_max_skb_frags to net_hotdata
      net: move sysctl_skb_defer_max to net_hotdata
      tcp: move tcp_out_of_memory() to net/ipv4/tcp.c
      net: add <net/proto_memory.h>
      net: move sysctl_mem_pcpu_rsv to net_hotdata
      ipv6: anycast: use call_rcu_hurry() in aca_put()
      net_sched: sch_sfq: annotate data-races around q->perturb_period
      rtnetlink: change rtnl_stats_dump() return value
      rtnetlink: use for_each_netdev_dump() in rtnl_stats_dump()
      net: no longer acquire RTNL in threaded_show()
      rtnetlink: do not depend on RTNL for IFLA_QDISC output
      rtnetlink: do not depend on RTNL for IFLA_IFNAME output
      rtnetlink: do not depend on RTNL for IFLA_TXQLEN output
      net: write once on dev->allmulti and dev->promiscuity
      rtnetlink: do not depend on RTNL for many attributes
      rtnetlink: do not depend on RTNL in rtnl_fill_proto_down()
      rtnetlink: do not depend on RTNL in rtnl_xdp_prog_skb()
      rtnetlink: allow rtnl_fill_link_netnsid() to run under RCU protection
      net: annotate writes on dev->mtu from ndo_change_mtu()
      mptcp: fix possible NULL dereferences
      usb: aqc111: stop lying about skb->truesize
      net: usb: smsc75xx: stop lying about skb->truesize
      net: usb: sr9700: stop lying about skb->truesize
      net: dst_cache: annotate data-races around dst_cache->reset_ts
      net: dst_cache: minor optimization in dst_cache_set_ip6()
      net: annotate data-races around dev->if_port
      phonet: no longer hold RTNL in route_dumpit()
      tcp: get rid of twsk_unique()
      net: usb: smsc95xx: stop lying about skb->truesize
      inet: fix inet_fill_ifaddr() flags truncation

Eric Woudstra (5):
      dt-bindings: net: airoha,en8811h: Add en8811h
      net: phy: air_en8811h: Add the Airoha EN8811H PHY driver
      net: phy: realtek: add get_rate_matching() for rtl822xb PHYs
      net: phy: realtek: Change rtlgen_get_speed() to rtlgen_decode_speed()
      net: phy: realtek: add rtl822x_c45_get_features() to set supported port

Erick Archer (5):
      net: mana: Add flex array to struct mana_cfg_rx_steer_req_v2
      RDMA/mana_ib: Prefer struct_size over open coded arithmetic
      net: mana: Avoid open coded arithmetic
      sctp: prefer struct_size over open coded arithmetic
      net: prestera: Add flex arrays to some structs

Fei Qin (2):
      devlink: add a new info version tag
      nfp: update devlink device info output

Felix Fietkau (16):
      wifi: mt76: mt7915: initialize rssi on adding stations
      wifi: mt76: replace skb_put with skb_put_zero
      wifi: mt76: fix tx packet loss when scanning on DBDC
      wifi: mt76: mt7996: only set MT76_MCU_RESET for the main phy
      wifi: mt76: mt7915: add fallback in case of missing precal data
      wifi: mt76: mt7603: fix tx queue of loopback packets
      wifi: mt76: mt7603: add wpdma tx eof flag for PSE client reset
      wifi: mt76: connac: use muar idx 0xe for non-mt799x as well
      wifi: mt76: make const arrays in functions static
      wifi: mt76: enable spectrum management
      net: move skb_gro_receive_list from udp to core
      net: add support for segmenting TCP fraglist GSO packets
      net: add code for TCP fraglist GRO
      net: create tcp_gro_lookup helper function
      net: create tcp_gro_header_pull helper function
      net: add heuristic for enabling TCP fraglist GRO

Fiona Klute (9):
      wifi: rtw88: Shared module for rtw8723x devices
      wifi: rtw88: Debug output for rtw8723x EFUSE
      wifi: rtw88: Add definitions for 8703b chip
      wifi: rtw88: Add rtw8703b.h
      wifi: rtw88: Add rtw8703b.c
      wifi: rtw88: Add rtw8703b_tables.h
      wifi: rtw88: Add rtw8703b_tables.c
      wifi: rtw88: Reset 8703b firmware before download
      wifi: rtw88: SDIO device driver for RTL8723CS

Flavio Suligoi (1):
      dt-bindings: net: snps, dwmac: remove tx-sched-sp property

Florian Fainelli (11):
      net: dsa: b53: Stop exporting b53_phylink_* routines
      net: dsa: b53: Introduce b53_adjust_531x5_rgmii()
      net: dsa: b53: Introduce b53_adjust_5325_mii()
      net: dsa: b53: Force flow control for BCM5301X CPU port(s)
      net: dsa: b53: Configure RGMII for 531x5 and MII for 5325
      net: dsa: b53: Call b53_eee_init() from b53_mac_link_up()
      net: dsa: b53: Remove b53_adjust_link()
      net: dsa: b53: provide own phylink MAC operations
      net: dsa: Remove fixed_link_update member
      net: dsa: Remove adjust_link paths
      lib: Allow for the DIM library to be modular

Florian Westphal (55):
      selftests: netfilter: move to net subdir
      selftests: netfilter: bridge_brouter.sh: move to lib.sh infra
      selftests: netfilter: br_netfilter.sh: move to lib.sh infra
      selftests: netfilter: conntrack_icmp_related.sh: move to lib.sh infra
      selftests: netfilter: conntrack_tcp_unreplied.sh: move to lib.sh infra
      selftests: netfilter: conntrack_sctp_collision.sh: move to lib.sh infra
      selftests: netfilter: conntrack_vrf.sh: move to lib.sh infra
      selftests: netfilter: conntrack_ipip_mtu.sh" move to lib.sh infra
      selftests: netfilter: place checktool helper in lib.sh
      selftests: netfilter: ipvs.sh: move to lib.sh infra
      selftests: netfilter: nf_nat_edemux.sh: move to lib.sh infra
      selftests: netfilter: nft_conntrack_helper.sh: test to lib.sh infra
      selftests: netfilter: nft_fib.sh: move to lib.sh infra
      selftests: netfilter: nft_flowtable.sh: move test to lib.sh infra
      selftests: netfilter: nft_nat.sh: move to lib.sh infra
      ip6_vti: fix memleak on netns dismantle
      selftests: netfilter: nft_queue.sh: move to lib.sh infra
      selftests: netfilter: nft_queue.sh: shellcheck cleanups
      selftests: netfilter: nft_synproxy.sh: move to lib.sh infra
      selftests: netfilter: nft_zones_many.sh: move to lib.sh infra
      selftests: netfilter: xt_string.sh: move to lib.sh infra
      selftests: netfilter: xt_string.sh: shellcheck cleanups
      selftests: netfilter: nft_nat_zones.sh: shellcheck cleanups
      selftests: netfilter: conntrack_ipip_mtu.sh: shellcheck cleanups
      selftests: netfilter: nft_fib.sh: shellcheck cleanups
      selftests: netfilter: nft_meta.sh: small shellcheck cleanup
      selftests: netfilter: nft_audit.sh: add more skip checks
      selftests: netfilter: update makefiles and kernel config
      selftests: netfilter: nft_concat_range.sh: move to lib.sh infra
      selftests: netfilter: nft_concat_range.sh: drop netcat support
      selftests: netfilter: nft_concat_range.sh: shellcheck cleanups
      selftests: netfilter: nft_flowtable.sh: re-run with random mtu sizes
      selftests: netfilter: nft_flowtable.sh: shellcheck cleanups
      selftests: netfilter: skip tests on early errors
      selftests: netfilter: conntrack_vrf.sh: prefer socat, not iperf3
      selftests: netfilter: nft_zones_many.sh: set ct sysctl after ruleset load
      selftests: netfilter: fix conntrack_dump_flush retval on unsupported kernel
      tools: testing: selftests: prefer TEST_PROGS for conntrack_dump_flush
      selftests: netfilter: avoid test timeouts on debug kernels
      selftests: netfilter: nft_concat_range.sh: reduce debug kernel run time
      netfilter: conntrack: documentation: remove reference to non-existent sysctl
      netfilter: conntrack: remove flowtable early-drop test
      netfilter: nft_set_pipapo: move prove_locking helper around
      netfilter: nft_set_pipapo: make pipapo_clone helper return NULL
      netfilter: nft_set_pipapo: prepare destroy function for on-demand clone
      netfilter: nft_set_pipapo: prepare walk function for on-demand clone
      netfilter: nft_set_pipapo: merge deactivate helper into caller
      selftests: netfilter: conntrack_tcp_unreplied.sh: wait for initial connection attempt
      netfilter: nft_set_pipapo: prepare pipapo_get helper for on-demand clone
      netfilter: nft_set_pipapo: move cloning of match info to insert/removal path
      netfilter: nft_set_pipapo: remove dirty flag
      selftests: netfilter: add packetdrill based conntrack tests
      netfilter: nf_tables: allow clone callbacks to sleep
      selftests: netfilter: nft_flowtable.sh: bump socat timeout to 1m
      selftests: netfilter: fix packetdrill conntrack testcase

Gabriel Krisman Bertazi (1):
      udp: Avoid call to compute_score on multiple sites

Gal Pressman (6):
      net/mlx5e: Use ethtool_sprintf/puts() to fill priv flags strings
      net/mlx5e: Use ethtool_sprintf/puts() to fill selftests strings
      net/mlx5e: Use ethtool_sprintf/puts() to fill stats strings
      net/mlx5e: Make stats group fill_stats callbacks consistent with the API
      net/mlx5: Convert uintX_t to uX
      net/mlx5e: Add support for 800Gbps link modes

Geetha sowjanya (1):
      octeontx2-pf: Add support for offload tc with skbedit mark action

Geliang Tang (43):
      selftests/bpf: Use start_server in bpf_tcp_ca
      selftests/bpf: Use connect_fd_to_fd in bpf_tcp_ca
      selftests/bpf: Drop settimeo in do_test
      selftests/bpf: Add pid limit for mptcpify prog
      selftests: mptcp: add tc check for check_tools
      selftests: mptcp: add ms units for tc-netem delay
      selftests: mptcp: export ip_mptcp to mptcp_lib
      selftests: mptcp: netlink: add 'limits' helpers
      selftests: mptcp: add {get,format}_endpoint(s) helpers
      selftests: mptcp: netlink: add change_address helper
      selftests: mptcp: join: update endpoint ops
      selftests: mptcp: export pm_nl endpoint ops
      selftests: mptcp: use pm_nl endpoint ops
      selftests: mptcp: ip_mptcp option for more scripts
      selftests: mptcp: netlink: drop disable=SC2086
      mptcp: add last time fields in mptcp_info
      selftests: mptcp: test last time mptcp_info
      selftests/bpf: Fix umount cgroup2 error in test_sockmap
      selftests/bpf: Add struct send_recv_arg
      selftests/bpf: Export send_recv_data helper
      selftests/bpf: Add start_server_addr helper
      selftests/bpf: Use start_server_addr in cls_redirect
      selftests/bpf: Use start_server_addr in sk_assign
      selftests/bpf: Update arguments of connect_to_addr
      selftests/bpf: Use connect_to_addr in cls_redirect
      selftests/bpf: Use connect_to_addr in sk_assign
      selftests/bpf: Fix a fd leak in error paths in open_netns
      selftests/bpf: Use log_err in open_netns/close_netns
      selftests/bpf: Use start_server_addr in test_sock_addr
      selftests/bpf: Use connect_to_addr in test_sock_addr
      selftests/bpf: Use make_sockaddr in test_sock_addr
      selftests/bpf: Free strdup memory in test_sockmap
      selftests/bpf: Free strdup memory in veristat
      selftests/bpf: Add opts argument for __start_server
      selftests/bpf: Make start_mptcp_server static
      selftests/bpf: Drop start_server_proto helper
      selftests/bpf: Add post_socket_cb for network_helper_opts
      selftests/bpf: Use start_server_addr in sockopt_inherit
      selftests/bpf: Use start_server_addr in test_tcp_check_syncookie
      selftests/bpf: Use connect_to_fd in sockopt_inherit
      selftests/bpf: Use connect_to_fd in test_tcp_check_syncookie
      selftests/bpf: Drop get_port in test_tcp_check_syncookie
      selftests/bpf: Free strdup memory in xdp_hw_metadata

Gregory Detal (1):
      mptcp: add net.mptcp.available_schedulers

Guillaume Nault (2):
      ipv4: Set scope explicitly in ip_route_output().
      ipv4: Remove RTO_ONLINK.

Gustavo A. R. Silva (13):
      wifi: ti: Avoid a hundred -Wflex-array-member-not-at-end warnings
      wifi: mwl8k: Avoid -Wflex-array-member-not-at-end warnings
      nfp: Avoid -Wflex-array-member-not-at-end warnings
      net/smc: Avoid -Wflex-array-member-not-at-end warnings
      wifi: wil6210: cfg80211: Use __counted_by() in struct wmi_start_scan_cmd and avoid some -Wfamnae warnings
      wifi: wil6210: wmi: Use __counted_by() in struct wmi_set_link_monitor_cmd and avoid -Wfamnae warning
      wifi: rtlwifi: Remove unused structs and avoid multiple -Wfamnae warnings
      Bluetooth: L2CAP: Avoid -Wflex-array-member-not-at-end warnings
      Bluetooth: hci_conn, hci_sync: Use __counted_by() to avoid -Wfamnae warnings
      Bluetooth: hci_conn: Use __counted_by() to avoid -Wfamnae warning
      Bluetooth: hci_conn: Use struct_size() in hci_le_big_create_sync()
      Bluetooth: hci_sync: Use cmd->num_cis instead of magic number
      Bluetooth: hci_conn: Use __counted_by() and avoid -Wfamnae warning

Haiyang Zhang (1):
      net: mana: Enable MANA driver on ARM64 with 4K page size

Haiyue Wang (3):
      bpf,arena: Use helper sizeof_field in struct accessors
      bpf: update the comment for BTF_FIELDS_MAX
      bpf: Remove redundant page mask of vmf->address

Hangbin Liu (13):
      ynl: support hex display_hint for integer
      doc/netlink/specs: Add vlan attr in rt_link spec
      Documentation: netlink: add a YAML spec for team
      net: team: rename team to team_core for linking
      net: team: use policy generated by YAML spec
      uapi: team: use header file generated from YAML spec
      ynl: rename array-nest to indexed-array
      ynl: support binary and integer sub-type for indexed-array
      doc/netlink/specs: Add bond support to rt_link.yaml
      net: team: fix incorrect maxattr
      ipv6: sr: add missing seg6_local_exit
      ipv6: sr: fix incorrect unregister order
      ipv6: sr: fix invalid unregister error path

Hans de Goede (1):
      Bluetooth: hci_bcm: Limit bcm43455 baudrate to 2000000

Hao Chen (1):
      net: hns3: add support to query scc version by devlink info

Hao Lan (1):
      net: hns3: add command queue trace for hns3

Hao Zhang (1):
      wifi: mt76: mt7921e: add LED control support

Hariprasad Kelam (1):
      octeontx2-pf: Reuse Transmit queue/Send queue index of HTB class

Harishankar Vishwanathan (2):
      bpf-next: Avoid goto in regs_refine_cond_op()
      bpf: Harden and/or/xor value tracking in verifier

Harshitha Ramamurthy (5):
      gve: simplify setting decriptor count defaults
      gve: make the completion and buffer ring size equal for DQO
      gve: set page count for RX QPL for GQI and DQO queue formats
      gve: add support to read ring size ranges from the device
      gve: add support to change ring size via ethtool

Hayes Wang (1):
      r8152: replace dev_info with dev_dbg for loading firmware

Hechao Li (1):
      tcp: increase the default TCP scaling ratio

Heiner Kallweit (2):
      r8169: add support for RTL8168M
      net: constify net_class

Henry Yen (2):
      wifi: mt76: mt7915: fix bogus Tx/Rx airtime duration values
      wifi: mt76: mt7996: fix non-main BSS no beacon issue for MBSS scenario

Horatiu Vultur (4):
      net: phy: micrel: lan8814: Enable LTC at probe time
      net: phy: micrel: lan8814: Add support for PTP_PF_PEROUT
      net: phy: micrel: Add support for PTP_PF_EXTTS for lan8814
      net: micrel: Fix receiving the timestamp in the frame for lan8841

Howard Hsu (4):
      wifi: mt76: mt7915: fix HE PHY capabilities IE for station mode
      wifi: mt76: connac: enable HW CSO module for mt7996
      wifi: mt76: mt7996: fix potential memory leakage when reading chip temperature
      wifi: mt76: connac: enable critical packet mode support for mt7992

Ian W MORRISON (1):
      Bluetooth: Add support for MediaTek MT7922 device

Ido Schimmel (2):
      selftests: fib_rule_tests: Add VRF tests
      mlxsw: spectrum_ethtool: Add support for 100Gb/s per lane link modes

Ilan Peer (9):
      wifi: iwlwifi: mvm: Move beacon filtering to be per link
      wifi: iwlwifi: mvm: Refactor scan start
      wifi: iwlwifi: mvm: Introduce internal MLO passive scan
      wifi: iwlwifi: mvm: Add debugfs entry for triggering internal MLO scan
      wifi: iwlwifi: mvm: Do not warn on invalid link on scan complete
      wifi: mac80211_hwsim: Declare HE/EHT capabilities support for P2P interfaces
      wifi: iwlwifi: mvm: Declare HE/EHT capabilities support for P2P interfaces
      wifi: iwlwifi: mvm: Refactor tracking of scan UIDs
      wifi: iwlwifi: mvm: Fix race in scan completion

Ilpo Järvinen (1):
      net: e1000e & ixgbe: Remove PCI_HEADER_TYPE_MFD duplicates

Ilya Leoshkevich (1):
      s390/bpf: Emit a barrier for BPF_FETCH instructions

Ilya Maximets (1):
      net: openvswitch: fix overwriting ct original tuple for ICMPv6

Iulia Tanasescu (2):
      Bluetooth: ISO: Make iso_get_sock_listen generic
      Bluetooth: ISO: Handle PA sync when no BIGInfo reports are generated

Ivan Vecera (7):
      i40e: Remove flags field from i40e_veb
      i40e: Refactor argument of several client notification functions
      i40e: Refactor argument of i40e_detect_recover_hung()
      i40e: Add helper to access main VSI
      i40e: Consolidate checks whether given VSI is main
      i40e: Add helper to access main VEB
      i40e: Add and use helper to reconfigure TC for given VSI

Jacob Keller (2):
      ice: set vf->num_msix in ice_initialize_vf_entry()
      ice: store VF relative MSI-X index in q_vector->vf_reg_idx

Jakub Buchocki (1):
      ice: Implement 'flow-type ether' rules

Jakub Kicinski (176):
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'selftests-fixes-for-kernel-ci'
      Merge branch 'doc-netlink-specs-add-vlan-support'
      Merge branch 'ravb-support-describing-the-mdio-bus'
      net: remove gfp_mask from napi_alloc_skb()
      Merge branch 'compiler_types-add-endianness-dependent-__counted_by_-le-be'
      Merge branch 'fix-missing-phy-to-mac-rx-clock'
      Merge branch 'bnxt_en-ptp-and-rss-updates'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'af_unix-rework-gc'
      Merge branch 'add-en8811h-phy-driver-and-devicetree-binding-doc'
      Merge branch 'add-ip-port-information-to-udp-drop-tracepoint'
      Merge branch 'enabled-wformat-truncation-for-clang'
      Merge branch 'address-remaining-wtautological-constant-out-of-range-compare'
      Merge branch 'udp-small-changes-on-receive-path'
      Merge branch 'add-property-in-dwmac-stm32-documentation'
      Merge branch 'doc-netlink-add-hyperlinks-to-generated-docs'
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      netlink: create a new header for internal genetlink symbols
      net: openvswitch: remove unnecessary linux/genetlink.h include
      genetlink: remove linux/genetlink.h
      Merge branch 'genetlink-remove-linux-genetlink-h'
      tools: ynl: add ynl_dump_empty() helper
      Merge branch 'page_pool-allow-direct-bulk-recycling'
      Merge branch 'avoid-explicit-cpumask-var-allocation-on-stack'
      Merge branch 'doc-netlink-add-a-yaml-spec-for-team'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'tcp-make-trace-of-reset-logic-complete'
      Merge branch 'af_unix-remove-old-gc-leftovers'
      Merge tag 'wireless-next-2024-04-03' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'mlx5-misc-patches'
      Merge branch 'mlxsw-preparations-for-improving-performance'
      Merge branch 'bnxt_en-update-for-net-next'
      netlink: specs: define ethtool header flags
      tools: ynl: copy netlink error to NlError
      Merge branch 'selftests-net-groundwork-for-ynl-based-tests'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'add-starfive-jh8100-dwmac-support'
      Merge branch 'net-dsa-microchip-ksz8-refactor-fdb-dump-path'
      Merge branch 'mlx5e-rc2-misc-patches'
      Merge branch 'address-all-wunused-const-warnings'
      netlink: specs: ethtool: define header-flags as an enum
      Merge branch 'ethtool-hw-timestamping-statistics'
      Merge branch 'ynl-rename-array-nest-to-indexed-array'
      net: skbuff: generalize the skb->decrypted bit
      netlink: add nlmsg_consume() and use it in devlink compat
      selftests: net: add scaffolding for Netlink tests in Python
      selftests: nl_netdev: add a trivial Netlink netdev test
      netdevsim: report stats by default, like a real device
      selftests: drivers: add scaffolding for Netlink tests in Python
      testing: net-drv: add a driver test for stats reporting
      Merge branch 'bonding-remove-rtnl-from-three-sysfs-files'
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'minor-cleanups-to-skb-frag-ref-unref'
      selftests: move bpf-offload test from bpf to net
      selftests: net: bpf_offload: wait for maps
      selftests: net: declare section names for bpf_offload
      selftests: net: reuse common code in bpf_offload
      Merge branch 'selftests-move-bpf-offload-test-from-bpf-to-net'
      Merge branch 'optimise-local-cpu-skb_attempt_defer_free'
      Merge branch 'bnxt_en-updates-for-net-next'
      Merge branch mana-ib-flex of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
      Merge branch 'mptcp-add-last-time-fields-in-mptcp_info'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'minor-cleanups-to-skb-frag-ref-unref'
      Merge branch 'net-dsa-allow-phylink_mac_ops-in-dsa-drivers'
      Merge branch 'selftests-move-netfilter-tests-to-net'
      Merge branch 'ptp-convert-to-platform-remove-callback-returning-void'
      Merge branch 'support-some-features-for-the-hns3-ethernet-driver'
      net: dev_addr_lists: move locking out of init/exit in kunit
      Merge branch 'net-dqs-optimize-if-stall-threshold-is-not-set'
      net: netdevsim: add some fake page pool use
      tools: ynl: don't return None for dumps
      selftests: net: print report check location in python tests
      selftests: net: print full exception on failure
      selftests: net: support use of NetdevSimDev under "with" in python
      selftests: net: exercise page pool reporting via netlink
      Merge branch 'selftests-net-exercise-page-pool-reporting-via-netlink'
      selftests: drv-net: add stdout to the command failed exception
      selftests: drv-net: add config for netdevsim
      selftests: adopt BPF's approach to quieter builds
      net: netdevsim: select PAGE_POOL in Kconfig
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      selftests: net: fix counting totals when some checks fail
      selftests: net: set the exit code correctly in Python tests
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'net: Add support for Power over Ethernet (PoE)'
      Merge branch 'testing-make-netfilter-selftests-functional-in-vng-environment'
      Merge branch 'net-dsa-vsc73xx-convert-to-phylink-and-do-some-cleanup'
      Merge branch 'mlx5e-per-queue-coalescing'
      Merge branch 'tcp-avoid-sending-too-small-packets'
      Merge branch 'for-uring-ubufops' into HEAD
      Merge branch 'netlink-add-nftables-spec-w-multi-messages'
      netdev: support dumping a single netdev in qstats
      netlink: move extack writing helpers
      netlink: support all extack types in dumps
      selftests: drv-net: test dumping qstats per device
      Merge branch 'netdev-support-dumping-a-single-netdev-in-qstats'
      selftests: drv-net: define endpoint structures
      selftests: drv-net: factor out parsing of the env
      selftests: drv-net: construct environment for running tests which require an endpoint
      selftests: drv-net: add a trivial ping test
      selftests: net: support matching cases by name prefix
      selftests: drv-net: add a TCP ping test case (and useful helpers)
      selftests: drv-net: add require_XYZ() helpers for validating env
      Merge branch 'selftests-drv-net-support-testing-with-a-remote-system'
      Merge branch 'selftest-netfilter-additional-cleanups'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      selftests: net: name bpf objects consistently and simplify Makefile
      selftests: net: extract BPF building logic from the Makefile
      Merge branch 'selftests-net-extract-bpf-building-logic-from-the-makefile'
      Merge branch 'net-dsa-b53-remove-adjust_link'
      Merge tag 'wireless-next-2024-04-24' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-microchip-correct-spelling-in-comments'
      Merge branch 'net-sparx5-flower-validate-control-flags'
      Merge branch 'net-lan966x-flower-validate-control-flags'
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      selftests: drv-net: extend the README with more info and example
      selftests: drv-net: reimplement the config parser
      selftests: drv-net: validate the environment
      Merge branch 'selftests-drv-net-round-some-sharp-edges'
      tools: ynl: don't append doc of missing type directly to the type
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'net-dsa-microchip-use-phylink_mac_ops-for-ksz-driver'
      net: page_pool: support error injection
      selftests: drv-net-hw: support using Python from net hw tests
      selftests: net: py: extract tool logic
      selftests: net: py: avoid all ports < 10k
      selftests: drv-net: support generating iperf3 load
      selftests: drv-net-hw: add test for memory allocation failures with page pool
      Merge branch 'selftests-net-page_poll-allocation-error-injection'
      Merge branch 'net-three-additions-to-net_hotdata'
      Merge branch 'dt-bindings-net-snps-dwmac-remove-tx-sched-sp-property'
      Merge branch 'arp-random-clean-up-and-rcu-conversion-for-ioctl-siocgarp'
      Merge branch 'net-dsa-adjust_link-removal'
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'bnxt_en-updates-for-net-next'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      selftests: net: py: check process exit code in bkg() and background cmd()
      Merge branch 'rtnetlink-rtnl_stats_dump-changes'
      tools: ynl: add --list-ops and --list-msgs to CLI
      Merge tag 'ipsec-next-2024-05-03' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'netdevsim-add-napi-support'
      Merge tag 'wireless-next-2024-05-08' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      eth: sungem: remove .ndo_poll_controller to avoid deadlocks
      selftests: net: add missing config for amt.sh
      selftests: net: move amt to socat for better compatibility
      selftests: net: fix timestamp not arriving in cmsg_time.sh
      selftests: net: increase the delay for relative cmsg_time.sh test
      Merge branch 'gve-minor-cleanups'
      Merge branch 'ipv6-sr-fix-errors-during-unregister'
      Merge branch 'net-qede-convert-filter-code-to-use-extack'
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'mlx5-misc-fixes'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge tag 'nf-next-24-05-12' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'ena-driver-changes-may-2024'
      Merge branch 'net-gro-remove-network_header-use-move-p-flush-flush_id-calculations-to-l4'
      Merge branch 'add-tx-stop-wake-counters'
      Merge branch 'net-dsa-microchip-dcb-fixes'
      Merge branch 'ax25-fix-issues-of-ax25_dev-and-net_device'
      Merge branch 'mlx5-misc-patches'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'virtio_net-rx-enable-premapped-mode-by-default'
      Merge branch 'net-stmmac-add-support-for-rzn1-gmac-devices'
      Merge branch 'tcp-support-rstreasons-in-the-passive-logic'
      Merge branch 'mptcp-small-improvements-fix-and-clean-ups'
      Merge branch 'move-est-lock-and-est-structure-to-struct-stmmac_priv'
      net: revert partially applied PHY topology series
      Merge tag 'for-net-next-2024-05-14' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Jason Xing (26):
      trace: move to TP_STORE_ADDRS related macro to net_probe_common.h
      trace: use TP_STORE_ADDRS() macro in inet_sk_error_report()
      trace: use TP_STORE_ADDRS() macro in inet_sock_set_state()
      tcp/dccp: complete lockless accesses to sk->sk_max_ack_backlog
      trace: adjust TP_STORE_ADDR_PORTS_SKB() parameters
      trace: tcp: fully support trace_tcp_send_reset
      mptcp: add reset reason options in some places
      selftests/bpf: eliminate warning of get_cgroup_id_from_path()
      net: save some cycles when doing skb_attempt_defer_free()
      net: rps: protect last_qtail with rps_input_queue_tail_save() helper
      net: rps: protect filter locklessly
      net: rps: locklessly access rflow->cpu
      net: introduce rstreason to detect why the RST is sent
      rstreason: prepare for passive reset
      rstreason: prepare for active reset
      tcp: support rstreason for passive reset
      mptcp: support rstreason for passive reset
      mptcp: introducing a helper into active reset logic
      rstreason: make it work in trace world
      netfilter: conntrack: dccp: try not to drop skb in conntrack
      netfilter: use NF_DROP instead of -NF_DROP
      tcp: rstreason: fully support in tcp_rcv_synsent_state_process()
      tcp: rstreason: fully support in tcp_ack()
      tcp: rstreason: fully support in tcp_rcv_state_process()
      tcp: rstreason: handle timewait cases in the receive path
      tcp: rstreason: fully support in tcp_check_req()

Jeff Johnson (14):
      wifi: ath12k: remove obsolete struct wmi_start_scan_arg
      wifi: ath11k: remove obsolete struct wmi_start_scan_arg
      wifi: ath11k: fix soc_dp_stats debugfs file permission
      wifi: nl80211: rename enum plink_actions
      wifi: nl80211: fix nl80211 uapi comment style issues
      wifi: nl80211: cleanup nl80211.h kernel-doc
      wifi: ath11k: fix hal_rx_buf_return_buf_manager documentation
      wifi: ath12k: fix hal_rx_buf_return_buf_manager documentation
      wifi: mac80211: correctly document struct mesh_table
      wifi: mac80211: remove ieee80211_set_hw_80211_encap()
      wifi: mac80211: Add missing return value documentation
      wifi: ath12k: don't use %pK in dmesg format strings
      wifi: cfg80211: fix cfg80211 function kernel-doc
      net: dccp: Fix ccid2_rtt_estimator() kernel-doc

Jesper Dangaard Brouer (1):
      bpf/lpm_trie: Inline longest_prefix_match for fastpath

Jesse Brandeburg (2):
      igb: simplify pci ops declaration
      net: intel: implement modern PM ops declarations

Jian Wen (1):
      devlink: use kvzalloc() to allocate devlink instance resources

Jianbo Liu (4):
      net/mlx5: Support matching on l4_type for ttc_table
      net/mlx5: Skip pages EQ creation for non-page supplier function
      net/mlx5: Don't call give_pages() if request 0 page
      net: sched: cls_api: fix slab-use-after-free in fl_dump_key

Jiande Lu (2):
      Bluetooth: btusb: Add USB HW IDs for MT7921/MT7922/MT7925
      Bluetooth: btusb: Sort usb_device_id table by the ID

Jiapeng Chong (2):
      net: ipa: Remove unnecessary print function dev_err()
      wifi: rtw89: Remove the redundant else branch in the function rtw89_phy_get_kpath

Jijie Shao (1):
      net: hns3: move constants from hclge_debugfs.h to hclge_debugfs.c

Jiri Olsa (11):
      selftests/bpf: Mark uprobe trigger functions with nocf_check attribute
      selftests/bpf: Add read_trace_pipe_iter function
      bpf: Add support for kprobe session attach
      bpf: Add support for kprobe session context
      bpf: Add support for kprobe session cookie
      libbpf: Add support for kprobe session attach
      libbpf: Add kprobe session attach type name to attach_type_name
      selftests/bpf: Add kprobe session test
      selftests/bpf: Add kprobe session cookie test
      libbpf: Fix error message in attach_kprobe_session
      libbpf: Fix error message in attach_kprobe_multi

Jiri Pirko (5):
      virtio: add debugfs infrastructure to allow to debug virtio features
      selftests: forwarding: add ability to assemble NETIFS array by driver name
      selftests: forwarding: add check_driver() helper
      selftests: forwarding: add wait_for_dev() helper
      selftests: virtio_net: add initial tests

Joe Damato (1):
      selftest: epoll_busy_poll: epoll busy poll tests

Joel Granados (9):
      net: Remove the now superfluous sentinel elements from ctl_table array
      net: ipv{6,4}: Remove the now superfluous sentinel elements from ctl_table array
      net: rds: Remove the now superfluous sentinel elements from ctl_table array
      net: sunrpc: Remove the now superfluous sentinel elements from ctl_table array
      net: Remove ctl_table sentinel elements from several networking subsystems
      netfilter: Remove the now superfluous sentinel elements from ctl_table array
      appletalk: Remove the now superfluous sentinel elements from ctl_table array
      ax.25: x.25: Remove the now superfluous sentinel elements from ctl_table array
      ax25: Remove superfuous "return" from ax25_ds_set_timer

Johan Hovold (3):
      Bluetooth: qca: drop bogus edl header checks
      Bluetooth: qca: drop bogus module version
      Bluetooth: qca: clean up defines

Johannes Berg (42):
      wifi: iwlwifi: mvm: fix flushing during quiet CSA
      wifi: iwlwifi: mvm: advertise IEEE80211_HW_HANDLES_QUIET_CSA
      wifi: iwlwifi: pcie: remove duplicate PCI IDs entry
      wifi: mac80211: spectmgmt: simplify 6 GHz HE/EHT handling
      wifi: ieee80211: check for NULL in ieee80211_mle_size_ok()
      wifi: ieee80211: fix ieee80211_mle_basic_sta_prof_size_ok()
      wifi: mac80211_hwsim: move skip_beacons to be per link
      wifi: mac80211: clarify the dormant/suspended links docs
      wifi: mac80211: add flag to disallow puncturing in 5 GHz
      wifi: iwlwifi: add a kunit test for PCI table duplicates
      wifi: iwlwifi: fw: add clarifying comments about iwl_fwrt_dump_data
      wifi: iwlwifi: mvm: don't support puncturing in 5 GHz
      wifi: iwlwifi: remove 6 GHz NVM override
      wifi: iwlwifi: enable monitor on passive/inactive channels
      wifi: iwlwifi: mvm: allocate STA links only for active links
      wifi: mac80211: don't enter idle during link switch
      wifi: mac80211: clarify IEEE80211_STATUS_SUBDATA_MASK
      wifi: mac80211: don't ask driver about no-op link changes
      wifi: mac80211: improve drop for action frame return
      wifi: mac80211: reactivate multi-link later in restart
      wifi: iwlwifi: mvm: set wider BW OFDMA ignore correctly
      wifi: iwlwifi: mvm: select STA mask only for active links
      wifi: iwlwifi: mvm: don't change BA sessions during restart
      wifi: iwlwifi: reconfigure TLC during HW restart
      wifi: mac80211: use kvcalloc() for codel vars
      wifi: iwlwifi: mvm: fix check in iwl_mvm_sta_fw_id_mask
      netlink: introduce type-checking attribute iteration
      rtnetlink: add guard for RTNL
      netdevice: add DEFINE_FREE() for dev_put
      wifi: mac80211: transmit deauth only if link is available
      wifi: iwlwifi: mvm: extend STEP URM workaround for new devices
      wifi: iwlwifi: mvm: init vif works only once
      wifi: mac80211: reserve chanctx during find
      wifi: mac80211: simplify ieee80211_assign_link_chanctx()
      wifi: mac80211: add return docs for sta_info_flush()
      wifi: cfg80211: make some regulatory functions void
      wifi: cfg80211: add return docs for regulatory functions
      Merge wireless into wireless-next
      wifi: iwlwifi: mvm: exit EMLSR when CSA happens
      wifi: iwlwifi: mvm: don't reset link selection during restart
      wifi: iwlwifi: mvm: use already determined cmd_id
      wifi: iwlwifi: mvm: align UATS naming with firmware

John Fraker (2):
      gve: Add counter adminq_get_ptype_map_cnt to stats report
      gve: Correctly report software timestamping capabilities

John Hubbard (2):
      bpftool, selftests/hid/bpf: Fix 29 clang warnings
      selftests/net: fix uninitialized variables

Jon Maloy (1):
      tcp: add support for SO_PEEK_OFF socket option

Jonathan Neuschäfer (1):
      rhashtable: Improve grammar

Jordan Rife (23):
      selftests/bpf: Fix bind program for big endian systems
      selftests/bpf: Implement socket kfuncs for bpf_testmod
      selftests/bpf: Implement BPF programs for kernel socket operations
      selftests/bpf: Move IPv4 and IPv6 sockaddr test cases
      selftests/bpf: Make sock configurable for each test case
      selftests/bpf: Add kernel socket operation tests
      selftests/bpf: Migrate recvmsg* return code tests to verifier_sock_addr.c
      selftests/bpf: Use program name for skel load/destroy functions
      selftests/bpf: Handle LOAD_REJECT test cases
      selftests/bpf: Handle ATTACH_REJECT test cases
      selftests/bpf: Handle SYSCALL_EPERM and SYSCALL_ENOTSUPP test cases
      selftests/bpf: Migrate WILDCARD_IP test
      selftests/bpf: Migrate sendmsg deny test cases
      selftests/bpf: Migrate sendmsg6 v4 mapped address tests
      selftests/bpf: Migrate wildcard destination rewrite test
      selftests/bpf: Migrate expected_attach_type tests
      selftests/bpf: Migrate ATTACH_REJECT test cases
      selftests/bpf: Remove redundant sendmsg test cases
      selftests/bpf: Retire test_sock_addr.(c|sh)
      selftests/bpf: Expand sockaddr program return value tests
      sefltests/bpf: Expand sockaddr hook deny tests
      selftests/bpf: Expand getsockname and getpeername tests
      selftests/bpf: Expand ATTACH_REJECT tests

Jose E. Marchesi (14):
      bpf_helpers.h: Define bpf_tail_call_static when building with GCC
      bpf: Missing trailing slash in tools/testing/selftests/bpf/Makefile
      libbpf: Fix bpf_ksym_exists() in GCC
      libbpf: Avoid casts from pointers to enums in bpf_tracing.h
      bpf: Avoid __hidden__ attribute in static object
      bpf: Disable some `attribute ignored' warnings in GCC
      bpf: Temporarily define BPF_NO_PRESEVE_ACCESS_INDEX for GCC
      bpf: avoid uninitialized warnings in verifier_global_subprogs.c
      bpf: avoid UB in usages of the __imm_insn macro
      bpf: guard BPF_NO_PRESERVE_ACCESS_INDEX in skb_pkt_end.c
      bpf: Avoid uninitialized value in BPF_CORE_READ_BITFIELD
      bpf: disable strict aliasing in test_global_func9.c
      bpf: ignore expected GCC warning in test_global_func10.c
      bpf: make list_for_each_entry portable

Jose Fernandez (1):
      bpf: Improve program stats run-time calculation

Jose Ignacio Tornos Martinez (2):
      net: usb: ax88179_178a: non necessary second random mac address
      net: usb: ax88179_178a: fix link status when link is set to down/up

Julien Panis (4):
      net: ethernet: ti: Add accessors for struct k3_cppi_desc_pool members
      net: ethernet: ti: Add desc_infos member to struct k3_cppi_desc_pool
      net: ethernet: ti: am65-cpsw: Add minimal XDP support
      net: ethernet: ti: am65-cpsw: Fix xdp_rxq error for disabled port

Jun Gu (2):
      net: openvswitch: Check vport netdev name
      net: openvswitch: Release reference to netdev

Justin Stitt (3):
      bpf: Replace deprecated strncpy with strscpy
      trace: events: cleanup deprecated strncpy uses
      net: dsa: lan9303: use ethtool_puts() for lan9303_get_strings()

Kalesh AP (4):
      bnxt_en: Remove a redundant NULL check in bnxt_register_dev()
      bnxt_en: Don't support offline self test when RoCE driver is loaded
      bnxt_en: Add a mutex to synchronize ULP operations
      bnxt_en: Optimize recovery path ULP locking in the driver

Kalle Valo (17):
      wifi: ath6kl: fix sparse warnings
      wifi: wcn36xx: buff_to_be(): fix sparse warnings
      wifi: wcn36xx: main: fix sparse warnings
      wifi: wil6210: fix sparse warnings
      wifi: ath9k: ath9k_set_moredata(): fix sparse warnings
      wifi: ath9k: fix ath9k_use_msi declaration
      wifi: ath9k: eeprom: fix sparse endian warnings
      wifi: mt76: mt7915: workaround dubious x | !y warning
      Merge tag 'ath-next-20240402' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath
      Merge tag 'rtw-next-2024-04-04' of https://github.com/pkshih/rtw
      Merge branch 'mhi-immutable' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into ath-next
      wifi: ath12k: enable WIPHY_FLAG_DISABLE_WEXT
      wifi: rtl8xxxu: remove some unused includes
      wifi: rtl8xxxu: remove rtl8xxxu_ prefix from filenames
      Merge tag 'mt76-for-kvalo-2024-05-02' of https://github.com/nbd168/wireless
      Merge tag 'ath-next-20240502' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath
      Merge tag 'rtw-next-2024-05-04-v2' of https://github.com/pkshih/rtw

Kang Yang (11):
      wifi: ath11k: change interface combination for P2P mode
      wifi: ath11k: add P2P IE in beacon template
      wifi: ath11k: implement handling of P2P NoA event
      wifi: ath11k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
      wifi: ath11k: change scan flag scan_f_filter_prb_req for QCA6390/WCN6855/QCA2066
      wifi: ath11k: advertise P2P dev support for QCA6390/WCN6855/QCA2066
      wifi: ath12k: remove duplicate definitions in wmi.h
      wifi: ath11k: remove duplicate definitions in wmi.h
      wifi: mac80211: supplement parsing of puncturing bitmap
      wifi: ath12k: dynamically update peer puncturing bitmap for STA
      wifi: ath12k: add support to handle beacon miss for WCN7850

Karthikeyan Kathirvel (1):
      wifi: ath12k: fix out-of-bound access of qmi_invoke_handler()

Karthikeyan Periyasamy (12):
      wifi: ath12k: Refactor Rxdma buffer replinish argument
      wifi: ath12k: Optimize the lock contention of used list in Rx data path
      wifi: ath12k: Refactor error handler of Rxdma replenish
      wifi: ath12k: extend the link capable flag
      wifi: ath12k: fix link capable flags
      wifi: ath12k: correct the capital word typo
      wifi: ath12k: add multiple radio support in a single MAC HW un/register
      wifi: ath12k: fix mac id extraction when MSDU spillover in rx error path
      wifi: ath12k: avoid redundant code in Rx cookie conversion init
      wifi: ath12k: Refactor the hardware cookie conversion init
      wifi: ath12k: displace the Tx and Rx descriptor in cookie conversion table
      wifi: ath12k: Refactor data path cmem init

Kees Cook (1):
      wifi: nl80211: Avoid address calculations via out of bounds array indexing

Kevin Lo (1):
      wifi: ath11k: adjust a comment to reflect reality

Kiran K (10):
      Bluetooth: btintel: Define macros for image types
      Bluetooth: btintel: Add support to download intermediate loader
      Bluetooth: btintel: Add support for BlazarI
      Bluetooth: btintel: Add support for Filmore Peak2 (BE201)
      Bluetooth: btintel: Export few static functions
      Bluetooth: btintel_pcie: Add *setup* function to download firmware
      Bluetooth: btintel_pcie: Fix compiler warnings
      Bluetooth: btintel: Fix compiler warning for multi_v7_defconfig config
      Bluetooth: btintel_pcie: Fix warning reported by sparse
      Bluetooth: btintel_pcie: Refactor and code cleanup

Kory Maincent (Dent Project) (20):
      MAINTAINERS: net: Add Oleksij to pse-pd maintainers
      of: property: Add fw_devlink support for pse parent
      net: pse-pd: Rectify and adapt the naming of admin_cotrol member of struct pse_control_config
      ethtool: Expand Ethernet Power Equipment with c33 (PoE) alongside PoDL
      net: pse-pd: Introduce PSE types enumeration
      net: ethtool: pse-pd: Expand pse commands with the PSE PoE interface
      netlink: specs: Modify pse attribute prefix
      netlink: specs: Expand the pse netlink command with PoE interface
      MAINTAINERS: Add myself to pse networking maintainer
      net: pse-pd: Add support for PSE PIs
      dt-bindings: net: pse-pd: Add another way of describing several PSE PIs
      net: pse-pd: Add support for setup_pi_matrix callback
      net: pse-pd: Use regulator framework within PSE framework
      dt-bindings: net: pse-pd: Add bindings for PD692x0 PSE controller
      net: pse-pd: Add PD692x0 PSE controller driver
      dt-bindings: net: pse-pd: Add bindings for TPS23881 PSE controller
      net: pse-pd: Add TI TPS23881 PSE controller driver
      net: pse-pd: pse_core: Add missing kdoc return description
      net: pse-pd: pse_core: Fix pse regulator type
      net: pse-pd: Kconfig: Add missing Regulator API dependency

Krzysztof Kozlowski (12):
      net: microchip: encx24j600: drop driver owner assignment
      net: wwan: mhi: drop driver owner assignment
      nfc: mrvl: spi: drop driver owner assignment
      nfc: st95hf: drop driver owner assignment
      net: dsa: microchip: drop driver owner assignment
      net: dsa: sja1105: drop driver owner assignment
      wifi: ath6kl: sdio: simplify module initialization
      wifi: rsi: sdio: simplify module initialization
      wifi: wl1251: simplify module initialization
      wifi: wilc1000: replace open-coded module_sdio_driver()
      wifi: mwifiex: replace open-coded module_sdio_driver()
      net: dsa: microchip: drop unneeded MODULE_ALIAS

Kuan-Chung Chen (2):
      wifi: rtw89: 8922a: configure UL MU/OFDMA power setting
      wifi: rtw89: fix CTS transmission issue with center frequency deviation

Kuan-Wei Chiu (1):
      net: sched: cake: Optimize the number of function calls and branches in heap construction

Kui-Feng Lee (4):
      bpftool: Cast pointers for shadow types explicitly.
      libbpf: Skip zeroed or null fields if not found in the kernel type.
      selftests/bpf: Ensure libbpf skip all-zeros fields of struct_ops maps.
      selftests/bpf: Make sure libbpf doesn't enforce the signature of a func pointer.

Kumar Kartikeya Dwivedi (2):
      bpf: Introduce bpf_preempt_[disable,enable] kfuncs
      selftests/bpf: Add tests for preempt kfuncs

Kuniyuki Iwashima (27):
      af_unix: Allocate struct unix_vertex for each inflight AF_UNIX fd.
      af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
      af_unix: Link struct unix_edge when queuing skb.
      af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
      af_unix: Iterate all vertices by DFS.
      af_unix: Detect Strongly Connected Components.
      af_unix: Save listener for embryo socket.
      af_unix: Fix up unix_edge.successor for embryo socket.
      af_unix: Save O(n) setup of Tarjan's algo.
      af_unix: Skip GC if no cycle exists.
      af_unix: Avoid Tarjan's algorithm if unnecessary.
      af_unix: Assign a unique index to SCC.
      af_unix: Detect dead SCC.
      af_unix: Replace garbage collection algorithm.
      selftest: af_unix: Test GC for SCM_RIGHTS.
      af_unix: Remove scm_fp_dup() in unix_attach_fds().
      af_unix: Remove lock dance in unix_peek_fds().
      af_unix: Try not to hold unix_gc_lock during accept().
      af_unix: Don't access successor in unix_del_edges() during GC.
      arp: Move ATF_COM setting in arp_req_set().
      arp: Validate netmask earlier for SIOCDARP and SIOCSARP in arp_ioctl().
      arp: Factorise ip_route_output() call in arp_req_set() and arp_req_delete().
      arp: Remove a nest in arp_req_get().
      arp: Get dev after calling arp_req_(delete|set|get)().
      net: Protect dev->name by seqlock.
      arp: Convert ioctl(SIOCGARP) to RCU.
      af_unix: Add dead flag to struct scm_fp_list.

Kurt Kanzenbach (1):
      net: dsa: hellcreek: Convert to gettimex64()

Leon Yen (1):
      wifi: mt76: mt7921s: fix potential hung tasks during chip recovery

Li Zhijian (3):
      wifi: b43: Convert sprintf/snprintf to sysfs_emit
      wifi: ti: Convert sprintf/snprintf to sysfs_emit
      wifi: ath: Convert sprintf/snprintf to sysfs_emit

Liang Chen (1):
      virtio_net: Support RX hash XDP hint

Lin Ma (1):
      net: nfc: remove inappropriate attrs check

Lingbo Kong (5):
      wifi: ath12k: ACPI TAS support
      wifi: ath12k: ACPI SAR support
      wifi: ath12k: ACPI CCA threshold support
      wifi: ath12k: ACPI band edge channel power support
      wifi: ath12k: fix the problem that down grade phy mode operation

Linus Lüssing (1):
      netfilter: conntrack: fix ct-state for ICMPv6 Multicast Router Discovery

Linus Walleij (1):
      net: ethernet: cortina: Locking fixes

Lorenzo Bianconi (4):
      wifi: mt76: mt7915: workaround too long expansion sparse warnings
      wifi: mt76: mt7996: fix uninitialized variable in mt7996_irq_tasklet()
      wifi: mt76: sdio: move mcu queue size check inside critical section
      net: ethernet: mediatek: split tx and rx fields in mtk_soc_data struct

Luiz Angelo Daros de Luca (3):
      net: dsa: realtek: keep default LED state in rtl8366rb
      net: dsa: realtek: do not assert reset on remove
      net: dsa: realtek: add LED drivers for rtl8366rb

Luiz Augusto von Dentz (4):
      Bluetooth: Add proper definitions for scan interval and window
      Bluetooth: hci_event: Set DISCOVERY_FINDING on SCAN_ENABLED
      Bluetooth: HCI: Remove HCI_AMP support
      Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1

Lukasz Czapnik (1):
      ice: Add tx_scheduling_layers devlink param

Lukasz Majewski (7):
      net: hsr: Provide RedBox support (HSR-SAN)
      test: hsr: Remove script code already implemented in lib.sh
      test: hsr: Move common code to hsr_common.sh file
      test: hsr: Extract version agnostic information from ping command output
      test: hsr: Add test for HSR RedBOX (HSR-SAN) mode of operation
      test: hsr: Call cleanup_all_ns when hsr_redbox.sh script exits
      test: hsr: Extend the hsr_redbox.sh to have more SAN devices connected

Lukasz Plachno (1):
      ice: Remove unnecessary argument from ice_fdir_comp_rules()

MD Danish Anwar (1):
      net: ti: icssg_prueth: Add SW TX / RX Coalescing based on hrtimers

Ma Ke (1):
      net: usb: ax88179_178a: Add check for usbnet_get_endpoints()

Maciej Fijalkowski (1):
      i40e: avoid forward declarations in i40e_nvm.c

Maher Sanalla (1):
      net/mlx5: Reload only IB representors upon lag disable/enable

Mahesh Talewad (1):
      LE Create Connection command timeout increased to 20 secs

Marcelo Tosatti (1):
      net: enable timestamp static key if CPU

Marcin Szycik (4):
      ice: refactor ICE_TC_FLWR_FIELD_ENC_OPTS
      ice: Add support for PFCP hardware offload in switchdev
      ice: Add automatic VF reset on Tx MDD events
      ice: Deduplicate tc action setup

Marek Behún (4):
      net: phy: realtek: Add driver instances for rtl8221b via Clause 45
      net: sfp: add quirk for another multigig RollBall transceiver
      net: sfp: update comment for FS SFP-10G-T quirk
      net: sfp: enhance quirk for Fibrestore 2.5G copper SFP module

Marek Vasut (2):
      dt-bindings: net: wireless: brcm,bcm4329-fmac: Add CYW43439 DT binding
      dt-bindings: net: broadcom-bluetooth: Add CYW43439 DT binding

Martin KaFai Lau (27):
      bpf: Remove unnecessary err < 0 check in bpf_struct_ops_map_update_elem
      bpf: Remove CONFIG_X86 and CONFIG_DYNAMIC_FTRACE guard from the tcp-cc kfuncs
      selftests/bpf: Test loading bpf-tcp-cc prog calling the kernel tcp-cc kfuncs
      bpf: Mark bpf prog stack with kmsan_unposion_memory in interpreter mode
      Merge branch 'Use start_server and connect_fd_to_fd'
      Merge branch 'export send_recv_data'
      Merge branch 'use network helpers, part 1'
      Merge branch 'use network helpers, part 2'
      Merge branch 'BPF crypto API framework'
      Merge branch 'bpf: add mrtt and srtt as ctx->args for BPF_SOCK_OPS_RTT_CB'
      Merge branch 'bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type enforcement in BPF_LINK_CREATE'
      Merge branch 'use network helpers, part 3'
      Merge branch 'selftests/bpf: Add sockaddr tests for kernel networking'
      Merge branch 'Add new args into tcp_congestion_ops' cong_control'
      selftests/bpf: Use bpf_tracing.h instead of bpf_tcp_helpers.h
      Merge branch 'libbpf: further struct_ops fixes and improvements'
      selftests/bpf: Remove bpf_tracing_net.h usages from two networking tests
      selftests/bpf: Add a few tcp helper functions and macros to bpf_tracing_net.h
      selftests/bpf: Reuse the tcp_sk() from the bpf_tracing_net.h
      selftests/bpf: Sanitize the SEC and inline usages in the bpf-tcp-cc tests
      selftests/bpf: Rename tcp-cc private struct in bpf_cubic and bpf_dctcp
      selftests/bpf: Use bpf_tracing_net.h in bpf_cubic
      selftests/bpf: Use bpf_tracing_net.h in bpf_dctcp
      selftests/bpf: Remove bpf_tcp_helpers.h usages from other misc bpf tcp-cc tests
      selftests/bpf: Remove the bpf_tcp_helpers.h usages from other non tcp-cc tests
      selftests/bpf: Retire bpf_tcp_helpers.h
      Merge branch 'use network helpers, part 4'

Martin Kaistra (3):
      wifi: rtl8xxxu: enable MFP support
      Revert "wifi: rtl8xxxu: enable MFP support"
      wifi: rtl8xxxu: enable MFP support with security flag of RX descriptor

Mateusz Polchlopek (2):
      devlink: extend devlink_param *set pointer
      ice: refactor struct ice_vsi_cfg_params to be inside of struct ice_vsi

Matthias Schiffer (4):
      net: dsa: mv88e6xxx: Add support for model-specific pre- and post-reset handlers
      net: dsa: mv88e6xxx: Avoid EEPROM timeout without EEPROM on 88E6250-family switches
      net: phy: marvell: constify marvell_hw_stats
      net: phy: marvell: add support for MV88E6250 family internal PHYs

Matthieu Baerts (NGI0) (8):
      tcp: socket option to check for MPTCP fallback to TCP
      mptcp: SO_KEEPALIVE: fix getsockopt support
      mptcp: fix full TCP keep-alive support
      mptcp: sockopt: info: stop early if no buffer
      mptcp: prefer strscpy over strcpy
      mptcp: remove unnecessary else statements
      mptcp: move mptcp_pm_gen.h's include
      mptcp: include inet_common in mib.h

Maxime Chevallier (6):
      net: stmmac: don't rely on lynx_pcs presence to check for a PHY
      net: phy: Introduce ethernet link topology representation
      net: sfp: pass the phy_device when disconnecting an sfp module's PHY
      net: phy: add helpers to handle sfp phy connect/disconnect
      net: sfp: Add helper to return the SFP bus name
      net: ethtool: Allow passing a phy index for some commands

MeiChia Chiu (1):
      wifi: mt76: mt7915: add support for disabling in-band discovery

Miao Xu (3):
      tcp: Add new args for cong_control in tcp_congestion_ops
      bpf: tcp: Allow to write tp->snd_cwnd_stamp in bpf_tcp_ca
      selftests/bpf: Add test for the use of new args in cong_control

Miaoqing Pan (1):
      wifi: ath12k: fix missing endianness conversion in wmi_vdev_create_cmd()

Michael Chan (6):
      bnxt_en: Add a timeout parameter to bnxt_hwrm_port_ts_query()
      bnxt_en: Simplify bnxt_rfs_capable()
      bnxt_en: Refactor bnxt_set_rxfh()
      bnxt_en: Fix PTP firmware timeout parameter
      bnxt_en: Update MODULE_DESCRIPTION
      bnxt_en: Don't call ULP_STOP/ULP_START during L2 reset

Michael-CY Lee (2):
      wifi: mac80211: extend IEEE80211_KEY_FLAG_GENERATE_MMIE to other ciphers
      wifi: mt76: mt7996: let upper layer handle MGMT frame protection

Michal Schmidt (4):
      ice: add ice_adapter for shared data across PFs on the same NIC
      ice: avoid the PTP hardware semaphore in gettimex64 path
      ice: fold ice_ptp_read_time into ice_ptp_gettimex64
      selftests/bpf: Fix pointer arithmetic in test_xdp_do_redirect

Michal Swiatkowski (13):
      ice: remove eswitch changing queues algorithm
      ice: do Tx through PF netdev in slow-path
      ice: default Tx rule instead of to queue
      ice: control default Tx rule in lag
      ice: remove switchdev control plane VSI
      ice: change repr::id values
      ice: do switchdev slow-path Rx using PF VSI
      ice: count representor stats
      pfcp: always set pfcp metadata
      ice: move ice_devlink.[ch] to devlink folder
      ice: hold devlink lock for whole init/cleanup
      pfcp: avoid copy warning by simplifing code
      ice: remove correct filters during eswitch release

Michal Wilczynski (2):
      ice: Enable switching default Tx scheduler topology
      ice: Document tx_scheduling_layers parameter

Mikhail Lobanov (1):
      cxgb4: unnecessary check for 0 in the free_sge_txq_uld() function

Mina Almasry (6):
      net: make napi_frag_unref reuse skb_page_unref
      net: remove napi_frag_unref
      net: move skb ref helpers to new header
      net: mirror skb frag ref/unref helpers
      Revert "net: mirror skb frag ref/unref helpers"
      queue_api: define queue api

Ming Yen Hsieh (1):
      wifi: mt76: mt7925: ensure 4-byte alignment for suspend & wow command

Miri Korenblit (28):
      wifi: iwlwifi: mvm: Remove outdated comment
      wifi: mac80211: defer link switch work in reconfig
      wifi: iwlwifi: mvm: implement link grading
      wifi: iwlwifi: mvm: calculate EMLSR mode after connection
      wifi: iwlwifi: mvm: don't always disable EMLSR due to BT coex
      wifi: iwlwifi: mvm: check if EMLSR is allowed before selecting links
      wifi: iwlwifi: mvm: move EMLSR/links code
      wifi: iwlwifi: mvm: Implement new link selection algorithm
      wifi: iwlwifi: mvm: Add helper functions to update EMLSR status
      wifi: iwlwifi: mvm: exit EMLSR upon missed beacon
      wifi: iwlwifi: mvm: implement EMLSR prevention mechanism.
      wifi: iwlwifi: mvm: don't recompute EMLSR mode in can_activate_links
      wifi: iwlwifi: mvm: get periodic statistics in EMLSR
      wifi: iwlwifi: mvm: Don't allow EMLSR when the RSSI is low
      wifi: iwlwifi: cleanup EMLSR when BT is active handling
      wifi: iwlwifi: mvm: trigger link selection after exiting EMLSR
      wifi: iwlwifi: mvm: add a debugfs for (un)blocking EMLSR
      wifi: iwlwifi: mvm: Always allow entering EMLSR from debugfs
      wifi: iwlwifi: mvm: don't always unblock EMLSR
      wifi: iwlwifi: mvm: Activate EMLSR based on traffic volume
      wifi: iwlwifi: mvm: consider FWs recommendation for EMLSR
      wifi: iwlwifi: mvm: trigger link selection upon TTLM start/end
      wifi: iwlwifi: mvm: avoid always prefering single-link
      wifi: iwlwifi: mvm: fix typo in debug print
      wifi: iwlwifi: mvm: fix primary link setting
      wifi: iwlwifi: bump FW API to 90 for BZ/SC devices
      wifi: iwlwifi: mvm: exit EMLSR if secondary link is not used
      wifi: iwlwifi: mvm: don't request statistics in restart

Muhammad Usama Anjum (1):
      wifi: mt76: connac: check for null before dereferencing

Mukesh Sisodiya (1):
      wifi: iwlwifi: mvm: send ap_tx_power_constraints cmd to FW in AP mode

Mykyta Yatsenko (2):
      libbpbpf: Check bpf_map/bpf_program fd validity
      bpf: improve error message for unsupported helper

Nick Child (1):
      ibmvnic: Return error code on TX scrq flush fail

Nikita Kiryushin (1):
      tg3: Remove residual error handling in tg3_suspend

Nikita Zhandarovich (2):
      wifi: carl9170: add a proper sanity check for endpoints
      wifi: ar5523: enable proper endpoint verification

Niklas Schnelle (1):
      net: handle HAS_IOPORT dependencies

Niklas Söderlund (3):
      dt-bindings: net: renesas,etheravb: Add optional MDIO bus node
      ravb: Add support for an optional MDIO mode
      dt-bindings: net: renesas,ethertsn: Create child-node for MDIO bus

Oleksij Rempel (24):
      net: dsa: microchip: Remove unused FDB timestamp support in ksz8_r_dyn_mac_table()
      net: dsa: microchip: Make ksz8_r_dyn_mac_table() static
      net: dsa: microchip: ksz8: Refactor ksz8_fdb_dump()
      net: dsa: microchip: ksz8: Refactor ksz8_r_dyn_mac_table() for readability
      net: dsa: microchip: ksz8: Unify variable naming in ksz8_r_dyn_mac_table()
      net: dsa: microchip: ksz8_r_dyn_mac_table(): ksz: do not return EAGAIN on timeout
      net: dsa: microchip: ksz8_r_dyn_mac_table(): return read/write error if we got any
      net: dsa: microchip: ksz8_r_dyn_mac_table(): use entries variable to signal 0 entries
      net: dsa: add support for DCB get/set apptrust configuration
      net: dsa: microchip: add IPV information support
      net: add IEEE 802.1q specific helpers
      net: dsa: microchip: add multi queue support for KSZ88X3 variants
      net: dsa: microchip: add support for different DCB app configurations
      net: dsa: microchip: dcb: add special handling for KSZ88X3 family
      net: dsa: microchip: enable ETS support for KSZ989X variants
      net: dsa: microchip: init predictable IPV to queue mapping for all non KSZ8xxx variants
      net: dsa: microchip: let DCB code do PCP and DSCP policy configuration
      net: dsa: add support switches global DSCP priority mapping
      net: dsa: microchip: add support DSCP priority mapping
      selftests: microchip: add test for QoS support on KSZ9477 switch family
      net: bridge: switchdev: Improve error message for port_obj_add/del functions
      net: dsa: microchip: dcb: rename IPV to IPM
      net: dsa: microchip: dcb: add comments for DSCP related functions
      net: dsa: microchip: dcb: set default apptrust to PCP only

Pablo Neira Ayuso (14):
      netfilter: nf_tables: skip transaction if update object is not implemented
      netfilter: nf_tables: remove NETDEV_CHANGENAME from netdev chain event handler
      gtp: remove useless initialization
      gtp: properly parse extension headers
      gtp: prepare for IPv6 support
      gtp: add IPv6 support
      gtp: use IPv6 address /64 prefix for UE/MS
      gtp: pass up link local traffic to userspace socket
      gtp: move debugging to skbuff build helper function
      gtp: remove IPv4 and IPv6 header from context object
      gtp: add helper function to build GTP packets from an IPv4 packet
      gtp: add helper function to build GTP packets from an IPv6 packet
      gtp: support for IPv4-in-IPv6-GTP and IPv6-in-IPv4-GTP
      gtp: identify tunnel via GTP device + GTP version + TEID + family

Paolo Abeni (22):
      Merge branch 'trace-use-tp_store_addrs-macro'
      Merge branch 'net-provide-smp-threads-for-backlog-napi'
      Merge branch 'support-icssg-based-ethernet-on-am65x-sr1-0-devices'
      Merge branch 'add-support-for-flower-actions-mirred-and-redirect'
      Merge branch 'tcp-fix-isn-selection-in-timewait-syn_recv'
      Merge branch 'net-phy-micrel-lan8814-enable-ptp_pf_perout'
      Merge branch 'selftests-assortment-of-fixes'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'net-ipa-header-hygiene'
      Merge branch 'read-phy-address-of-switch-from-device-tree-on-mt7530-dsa-subdriver'
      Merge branch 'enable-rx-hw-timestamp-for-ptp-packets-using-cpts-fifo'
      Merge branch 'net-stmmac-fix-mac-capabilities-procedure'
      Merge branch 'net-ipa-eight-simple-cleanups'
      Merge branch 'net-hsr-add-support-for-hsr-san-redbox'
      Merge branch 'selftests-virtio_net-introduce-initial-testing-infrastructure'
      Merge branch 'implement-reset-reason-mechanism-to-detect'
      Merge branch 'virtio-net-support-device-stats'
      Merge branch 'net-smc-smc-intra-os-shortcut-with-loopback-ism'
      Merge branch 'add-tcp-fraglist-gro-support'
      Merge branch 'net-qede-don-t-restrict-error-codes'
      Merge branch 'rtnetlink-more-rcu-conversions-for-rtnl_fill_ifinfo'
      Merge branch 'remove-rtnl-lock-protection-of-cvq'

Parav Pandit (3):
      devlink: Support setting max_io_eqs
      mlx5/core: Support max_io_eqs for a function
      net/mlx5: Remove unused msix related exported APIs

Paul Greenwalt (2):
      ice: add additional E830 device ids
      ice: update E830 device ids and comments

Pavan Chebbi (11):
      bnxt_en: Retry PTP TX timestamp from FW for 1 second
      bnxt_en: Add helper function bnxt_hwrm_vnic_rss_cfg_p5()
      bnxt_en: Refactor VNIC alloc and cfg functions
      bnxt_en: Introduce rss ctx structure, alloc/free functions
      bnxt_en: Refactor RSS indir alloc/set functions
      bnxt_en: Add a new_rss_ctx parameter to bnxt_rfs_capable()
      bnxt_en: Support RSS contexts in ethtool .{get|set}_rxfh()
      bnxt_en: Refactor bnxt_cfg_rfs_ring_tbl_idx()
      bnxt_en: Support adding ntuple rules on RSS contexts
      bnxt_en: Update firmware interface to 1.10.3.39
      bnxt_en: Skip ethtool RSS context configuration in ifdown state

Pavel Begunkov (2):
      net: cache for same cpu skb_attempt_defer_free
      net: use SKB_CONSUMED in skb_attempt_defer_free()

Pawel Dembicki (9):
      net: phy: marvell: add basic support of 88E308X/88E609X family
      net: ethtool: Add impedance mismatch result code to cable test
      net: phy: marvell: implement cable-test for 88E308X/88E609X family
      net: phy: marvell: implement cable test for 88E1111
      net: dsa: vsc73xx: use read_poll_timeout instead delay loop
      net: dsa: vsc73xx: convert to PHYLINK
      net: dsa: vsc73xx: use macros for rgmii recognition
      net: dsa: vsc73xx: Add define for max num of ports
      net: dsa: vsc73xx: add structure descriptions

Paweł Owoc (1):
      net: phy: aquantia: add support for AQR114C PHY ID

Peilin He (1):
      net/ipv4: add tracepoint for icmp_send

Peiyang Wang (1):
      net: hns3: dump more reg info based on ras mod

Peng Fan (1):
      dt-bindings: net: nxp,dwmac-imx: allow nvmem cells property

Peter Chiu (3):
      wifi: mt76: mt7915: fix mcu command format for mt7915 tx stats
      wifi: mt76: mt7915: add mt7986, mt7916 and mt7981 pre-calibration
      wifi: mt76: mt7996: set RCPI value in rate control command

Peter Tsao (1):
      Bluetooth: btusb: Fix the patch for MT7920 the affected to MT7921

Petr Machata (23):
      selftests: net: libs: Change variable fallback syntax
      selftests: forwarding.config.sample: Move overrides to lib.sh
      selftests: forwarding: README: Document customization
      selftests: forwarding: ipip_lib: Do not import lib.sh
      selftests: forwarding: Move several selftests
      selftests: forwarding: Ditch skip_on_veth()
      selftests: forwarding: Change inappropriate log_test_skip() calls
      selftests: lib: Define more kselftest exit codes
      selftests: forwarding: Have RET track kselftest framework constants
      selftests: forwarding: Convert log_test() to recognize RET values
      selftests: forwarding: Support for performance sensitive tests
      selftests: forwarding: Mark performance-sensitive tests
      selftests: forwarding: router_mpath_nh_lib: Don't skip, xfail on veth
      selftests: forwarding: Add a test for testing lib.sh functionality
      selftests: net: Unify code of busywait() and slowwait()
      selftests: forwarding: lib.sh: Validate NETIFS
      selftests: forwarding: bail_on_lldpad() should SKIP
      selftests: drivers: hw: Fix ethtool_rmon
      selftests: drivers: hw: ethtool.sh: Adjust output
      selftests: drivers: hw: Include tc_common.sh in hw_stats_l3
      selftests: forwarding: router_mpath_nh: Add a diagram
      selftests: forwarding: router_mpath_nh_res: Add a diagram
      selftests: forwarding: router_nh: Add a diagram

Philo Lu (7):
      bpf: store both map ptr and state in bpf_insn_aux_data
      bpf: allow invoking bpf_for_each_map_elem with different maps
      selftests/bpf: add test for bpf_for_each_map_elem() with different maps
      tcp: move tcp_skb_cb->sacked flags to enum
      tcp: update sacked after tracepoint in __tcp_retransmit_skb
      bpf: add mrtt and srtt as BPF_SOCK_OPS_RTT_CB args
      selftests/bpf: extend BPF_SOCK_OPS_RTT_CB test for srtt and mrtt_us

Ping-Ke Shih (11):
      wifi: rtw89: 8922a: add 8922ae to Makefile and Kconfig
      wifi: rtw88: station mode only for SDIO chips
      wifi: rtw89: 8852c: add quirk to set PCI BER for certain platforms
      wifi: rtw89: 8852c: disable PCI PHY EQ to improve compatibility
      wifi: rtw88: remove unsupported interface type of mesh point
      wifi: rtw89: pci: correct TX resource checking for PCI DMA channel of firmware command
      wifi: rtw88: suppress messages of failed to flush queue
      wifi: rtw89: 8852b: update hardware parameters for RFE type 5
      wifi: rtl8xxxu: cleanup includes
      wifi: rtw89: correct aSIFSTime for 6GHz band
      wifi: rtlwifi: 8192d: initialize rate_mask in rtl92de_update_hal_rate_mask()

Piotr Raczynski (1):
      ice: move devlink port code to a separate file

Po-Hao Huang (3):
      wifi: rtw89: 8922a: download template probe requests for 6 GHz band
      wifi: rtw89: 8922a: add beacon filter and CQM support
      wifi: rtw88: Set default CQM config if not present

Praveen Kumar Kannoju (1):
      net/sched: adjust device watchdog timer to detect stopped queue at right time

Pu Lehui (1):
      selftests/bpf: Skip test when perf_event_open returns EOPNOTSUPP

Puranjay Mohan (11):
      bpf: implement insn_is_cast_user() helper for JITs
      bpf: Add arm64 JIT support for PROBE_MEM32 pseudo instructions.
      bpf: Add arm64 JIT support for bpf_addr_space_cast instruction.
      bpf, riscv: Implement PROBE_MEM32 pseudo instructions
      bpf, riscv: Implement bpf_addr_space_cast instruction
      bpf, arm64: Add support for lse atomics in bpf_arena
      riscv, bpf: add internal-only MOV instruction to resolve per-CPU addrs
      riscv, bpf: inline bpf_get_smp_processor_id()
      arm64, bpf: add internal-only MOV instruction to resolve per-CPU addrs
      bpf, arm64: inline bpf_get_smp_processor_id() helper
      riscv, bpf: make some atomic operations fully ordered

Quentin Deslandes (2):
      libbpf: Fix misaligned array closing bracket
      libbpf: Fix dump of subsequent char arrays

Quentin Monnet (6):
      libbpf: Prevent null-pointer dereference when prog to load has no BTF
      bpftool: Enable libbpf logs when loading pid_iter in debug mode
      bpftool: Remove unnecessary source files from bootstrap version
      bpftool: Clean up HOST_CFLAGS, HOST_LDFLAGS for bootstrap bpftool
      bpftool: Update documentation where progs/maps can be passed by name
      bpftool: Address minor issues in bash completion

Radha Mohan Chintakuntla (1):
      octeontx2-af: Increase maximum BPID channels

Rafael Passos (2):
      bpf: Fix typo in function save_aux_ptr_type
      bpf: Fix typos in comments

Rahul Rameshbabu (12):
      tools: ynl: ethtool.py: Make tool invokable from any CWD
      ethtool: add interface to read Tx hardware timestamping statistics
      net/mlx5e: Introduce lost_cqe statistic counter for PTP Tx port timestamping CQ
      net/mlx5e: Introduce timestamps statistic counter for Tx DMA layer
      net/mlx5e: Implement ethtool hardware timestamping statistics
      tools: ynl: ethtool.py: Output timestamping statistics from tsinfo-get operation
      ethtool: update tsinfo statistics attribute docs with correct type
      net/mlx5e: Move DIM function declarations to en/dim.h
      net/mlx5e: Use DIM constants for CQ period mode parameter
      net/mlx5e: Dynamically allocate DIM structure for SQs/RQs
      net/mlx5e: Support updating coalescing configuration without resetting channels
      net/mlx5e: Implement ethtool callbacks for supporting per-queue coalescing

Raj Kumar Bhagat (2):
      wifi: ath12k: read single_chip_mlo_support parameter from QMI PHY capability
      wifi: ath12k: set mlo_capable_flags based on QMI PHY capability

Raj Victor (2):
      ice: Support 5 layer topology
      ice: Adjust the VSI/Aggregator layers

Ramasamy Kaliappan (1):
      wifi: ath12k: initial debugfs support

Rameez Rehman (3):
      bpftool: Use simpler indentation in source rST for documentation
      bpftool: Remove useless emphasis on command description in man pages
      bpftool: Clean-up typos, punctuation, list formatting in docs

Ramya Gnanasekar (1):
      wifi: ath12k: debugfs: radar simulation support

Rand Deeb (1):
      ssb: Fix potential NULL pointer dereference in ssb_device_uevent()

Randy Dunlap (2):
      ssb: drop use of non-existing CONFIG_SSB_DEBUG symbol
      ssb: use "break" on default case to prevent warning

Rengarajan S (1):
      net: microchip: lan743x: Reduce PTP timeout on HW failure

Richard Gobert (4):
      net: gro: use cb instead of skb->network_header
      net: gro: move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment
      selftests/net: add flush id selftests
      net: gro: fix napi_gro_cb zeroed alignment

Rob Herring (1):
      dt-bindings: net: snps,dwmac: Align 'snps,priority' type definition

Romain Gantois (4):
      net: phylink: add rxc_always_on flag to phylink_pcs
      net: stmmac: Support a generic PCS field in mac_device_info
      net: stmmac: Signal to PHY/PCS drivers to keep RX clock on
      net: pcs: rzn1-miic: Init RX clock early if MAC requires it

Rong Yan (1):
      wifi: mt76: mt7921: cqm rssi low/high event notify

Russell King (Oracle) (30):
      net: phylink: add PHY_F_RXC_ALWAYS_ON to PHY dev flags
      net: phy: qcom: at803x: Avoid hibernating if MAC requires RX clock
      net: dsa: introduce dsa_phylink_to_port()
      net: dsa: allow DSA switch drivers to provide their own phylink mac ops
      net: dsa: mv88e6xxx: provide own phylink MAC operations
      net: dsa: convert dsa_user_phylink_fixed_state() to use dsa_phylink_to_port()
      net: dsa: sja1105: provide own phylink MAC operations
      net: dsa: ar9331: provide own phylink MAC operations
      net: dsa: qca8k: provide own phylink MAC operations
      net: dsa: lantiq_gswip: provide own phylink MAC operations
      net: dsa: mt7530: provide own phylink MAC operations
      net: dsa: bcm_sf2: provide own phylink MAC operations
      net: dsa: lan9303: provide own phylink MAC operations
      net: dsa: rzn1_a5psw: provide own phylink MAC operations
      net: dsa: xrs700x: provide own phylink MAC operations
      net: dsa: xrs700x: fix missing initialisation of ds->phylink_mac_ops
      net: dsa: ksz_common: remove phylink_mac_config from ksz_dev_ops
      net: dsa: ksz_common: provide own phylink MAC operations
      net: dsa: ksz_common: sub-driver phylink ops
      net: dsa: ksz_common: use separate phylink_mac_ops for ksz8830
      net: mvpp2: use phylink_pcs_change() to report PCS link change events
      net: mvneta: use phylink_pcs_change() to report PCS link change events
      net: prestera: use phylink_pcs_change() to report PCS link change events
      net: txgbe: use phylink_pcs_change() to report PCS link change events
      net: dsa: realtek: provide own phylink MAC operations
      net: phylink: add debug print for empty posssible_interfaces
      net: sfp: allow use 2500base-X for 2500base-T modules
      net: sfp-bus: constify link_modes to sfp_select_interface()
      net: stmmac: introduce pcs_init/pcs_exit stmmac operations
      net: stmmac: dwmac-socfpga: use pcs_init/pcs_exit

Sahil Siddiq (1):
      bpftool: Mount bpffs on provided dir instead of parent dir

Sai Krishna (1):
      octeontx2-pf: Reset MAC stats during probe

Samuel Thibault (2):
      l2tp: Support several sockets with same IP/port quadruple
      l2tp: Support different protocol versions with same IP/port quadruple

Sascha Hauer (1):
      dt-bindings: net: rockchip-dwmac: use rgmii-id in example

Sasha Neftin (1):
      igc: Refactor runtime power management flow

Satish Kharat (1):
      enic: Replace hardcoded values for vnic descriptor by defines

Sebastian Andrzej Siewior (4):
      net: Remove conditional threaded-NAPI wakeup based on task state.
      net: Allow to use SMP threads for backlog NAPI.
      net: Use backlog-NAPI to clean up the defer_list.
      net: Rename rps_lock to backlog_lock.

Sebastian Urban (1):
      Bluetooth: compute LE flow credits based on recvbuf space

Serge Semin (4):
      net: stmmac: Rename phylink_get_caps() callback to update_caps()
      net: stmmac: Move MAC caps init to phylink MAC caps getter
      net: stmmac: Add dedicated XPCS cleanup method
      net: stmmac: Make stmmac_xpcs_setup() generic to all PCS devices

Shahab Vahedi (1):
      ARC: Add eBPF JIT support

Shailend Chand (9):
      gve: Make the GQ RX free queue funcs idempotent
      gve: Add adminq funcs to add/remove a single Rx queue
      gve: Make gve_turn(up|down) ignore stopped queues
      gve: Make gve_turnup work for nonempty queues
      gve: Avoid rescheduling napi if on wrong cpu
      gve: Reset Rx ring state in the ring-stop funcs
      gve: Account for stopped queues when reading NIC stats
      gve: Alloc and free QPLs with the rings
      gve: Implement queue api

Shaul Triebitz (5):
      wifi: iwlwifi: fix firmware API kernel doc
      wifi: iwlwifi: mvm: fix the sta id in offload
      wifi: iwlwifi: mvm: stop assuming sta id 0 in d3
      wifi: iwlwifi: mvm: skip keys of other links
      wifi: iwlwifi: mvm: support wowlan notif version 4

Shay Drory (3):
      net/mlx5e: Fix netif state handling
      net/mlx5: Fix peer devlink set for SF representor devlink port
      net/mlx5: Enable 8 ports LAG

Shayne Chen (2):
      wifi: mt76: mt7996: disable rx header translation for BMC entry
      wifi: mt76: connac: use peer address for station BMC entry

Shi-Sheng Yang (1):
      mptcp: fix typos in comments

Simon Horman (8):
      net: lan743x: Correct spelling in comments
      net: lan966x: Correct spelling in comments
      net: encx24j600: Correct spelling in comments
      net: sparx5: Correct spelling in comments
      net: dsa: mv88e6xxx: Correct check for empty list
      octeontx2-pf: Treat truncation of IRQ name as an error
      gve: Avoid unnecessary use of comma operator
      gve: Use ethtool_sprintf/puts() to fill stats strings

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Somnath Kotur (4):
      bnxt_en: Enable XPS by default on driver load
      bnxt_en: Allocate page pool per numa node
      bnxt_en: Change bnxt_rx_xdp function prototype
      bnxt_en: Add XDP Metadata support

Song Yoong Siang (1):
      igc: Add Tx hardware timestamp request for AF_XDP zero-copy packet

Sreekanth Reddy (1):
      bnxt_en: Add warning message about disallowed speed change

Sriram R (12):
      wifi: ath12k: Modify add and remove chanctx ops for single wiphy support
      wifi: ath12k: modify ath12k mac start/stop ops for single wiphy
      wifi: ath12k: vdev statemachine changes for single wiphy
      wifi: ath12k: scan statemachine changes for single wiphy
      wifi: ath12k: fetch correct radio based on vdev status
      wifi: ath12k: Cache vdev configs before vdev create
      wifi: ath12k: Add additional checks for vif and sta iterators
      wifi: ath12k: modify regulatory support for single wiphy architecture
      wifi: ath12k: Modify set and get antenna mac ops for single wiphy
      wifi: ath12k: Modify rts threshold mac op for single wiphy
      wifi: ath12k: support get_survey mac op for single wiphy
      wifi: mac80211: handle link ID during management Tx

Stanislav Fomichev (3):
      bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type enforcement in BPF_LINK_CREATE
      selftests/bpf: Extend sockopt tests to use BPF_LINK_CREATE
      selftests/bpf: Add sockopt case to verify prog_type

StanleyYP Wang (1):
      wifi: mt76: mt7996: add sanity checks for background radar trigger

Steffen Klassert (1):
      Merge remote branch 'xfrm: Introduce direction attribute for SA'

Steven Zou (1):
      ice: Add switch recipe reusing feature

Su Hui (2):
      octeontx2-pf: remove unused variables req_hdr and rsp_hdr
      wifi: ath10k: Fix an error code problem in ath10k_dbg_sta_write_peer_debug_trigger()

Sungwoo Kim (1):
      Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()

Suraj Gupta (1):
      net: axienet: Fix kernel doc warnings

Syed Nayyar Waris (1):
      lib/bitmap: add bitmap_{read,write}()

Tan Chun Hau (1):
      dt-bindings: net: starfive,jh7110-dwmac: Add StarFive JH8100 support

Tanmay Patil (1):
      net: ethernet: ti: am65-cpsw-qos: Add support to taprio for past base_time

Tao Chen (1):
      samples/bpf: Add valid info for VMLINUX_BTF

Tariq Toukan (2):
      net/mlx5e: debugfs, Add reset option for command interface stats
      net/mlx5e: Un-expose functions in en.h

Tedd Ho-Jeong An (1):
      Bluetooth: btintel_pcie: Add support for PCIe transport

Thiraviyam Mariyappan (2):
      wifi: ath12k: fix desc address calculation in wbm tx completion
      wifi: ath12k: enable service flag for survey dump stats

Thomas Weißschuh (1):
      sysctl: treewide: constify ctl_table_header::ctl_table_arg

Thorsten Blum (3):
      ice: Remove newlines in NL_SET_ERR_MSG_MOD
      bpftool: Fix typo in error message
      net: smc91x: Fix m68k kernel compilation for ColdFire CPU

Tobias Böhm (1):
      libbpf: Use local bpf_helpers.h include

Tushar Vyavahare (8):
      tools: Add ethtool.h header to tooling infra
      selftests/xsk: Make batch size variable
      selftests/bpf: Implement get_hw_ring_size function to retrieve current and max interface size
      selftests/bpf: Implement set_hw_ring_size function to configure interface ring size
      selftests/xsk: Introduce set_ring_size function with a retry mechanism for handling AF_XDP socket closures
      selftests/xsk: Test AF_XDP functionality under minimal ring configurations
      selftests/xsk: Add new test case for AF_XDP under max ring sizes
      tools: remove redundant ethtool.h from tooling infra

Uri Arev (2):
      Bluetooth: hci_intel: Fix multiple issues reported by checkpatch.pl
      Bluetooth: ath3k: Fix multiple issues reported by checkpatch.pl

Uwe Kleine-König (11):
      bcma: convert to platform remove callback returning void
      net: rfkill: gpio: Convert to platform remove callback returning void
      net: wan: fsl_qmc_hdlc: Convert to platform remove callback returning void
      ptp: ptp_clockmatrix: Convert to platform remove callback returning void
      ptp: ptp_dte: Convert to platform remove callback returning void
      ptp: ptp_idt82p33: Convert to platform remove callback returning void
      ptp: ptp_ines: Convert to platform remove callback returning void
      ptp: ptp_qoriq: Convert to platform remove callback returning void
      Bluetooth: btqcomsmd: Convert to platform remove callback returning void
      Bluetooth: hci_bcm: Convert to platform remove callback returning void
      Bluetooth: hci_intel: Convert to platform remove callback returning void

Vadim Fedorenko (7):
      bpf: make common crypto API for TC/XDP programs
      bpf: crypto: add skcipher to bpf crypto
      selftests: bpf: crypto skcipher algo selftests
      selftests: bpf: crypto: add benchmark for crypto functions
      bpf: crypto: fix build when CONFIG_CRYPTO=m
      ptp: ocp: fix DPLL functions
      bnxt_en: silence clang build warning

Venkat Venkatsubra (1):
      ipvlan: handle NETDEV_DOWN event

Vikas Gupta (5):
      bnxt_en: Add delay to handle Downstream Port Containment (DPC) AER
      bnxt_en: Remove unneeded MSIX base structure fields and code
      bnxt_en: Refactor bnxt_rdma_aux_device_init/uninit functions
      bnxt_en: Change MSIX/NQs allocation policy
      bnxt_en: Utilize ulp client resources if RoCE is not registered

Viktor Malik (3):
      selftests/bpf: Run cgroup1_hierarchy test in own mount namespace
      libbpf: support "module: Function" syntax for tracing programs
      selftests/bpf: add tests for the "module: Function" syntax

Vladimir Oltean (2):
      selftests: net: use upstream mtools
      net: pcs: lynx: no need to read LPA in lynx_pcs_get_state_2500basex()

Víctor Gonzalo (1):
      wifi: mwifiex: Add missing MODULE_FIRMWARE() for SD8801

Wander Lairson Costa (1):
      drop_monitor: replace spin_lock by raw_spin_lock

Wei Fang (1):
      net: fec: remove .ndo_poll_controller to avoid deadlocks

Wen Gu (11):
      net/smc: decouple ism_client from SMC-D DMB registration
      net/smc: introduce loopback-ism for SMC intra-OS shortcut
      net/smc: implement ID-related operations of loopback-ism
      net/smc: implement DMB-related operations of loopback-ism
      net/smc: mark optional smcd_ops and check for support when called
      net/smc: ignore loopback-ism when dumping SMC-D devices
      net/smc: register loopback-ism into SMC-D device list
      net/smc: add operations to merge sndbuf with peer DMB
      net/smc: {at|de}tach sndbuf to peer DMB if supported
      net/smc: adapt cursor update when sndbuf and peer DMB are merged
      net/smc: implement DMB-merged operations of loopback-ism

Willem de Bruijn (2):
      selftests/net: skip partial checksum packets in csum test
      selftests: drv-net: add checksum tests

Wojciech Drewek (1):
      pfcp: add PFCP module

Xiao Wang (1):
      riscv, bpf: Fix typo in comment

Xiaolei Wang (2):
      net: stmmac: move the EST lock to struct stmmac_priv
      net: stmmac: move the EST structure to struct stmmac_priv

Xin Deng (1):
      wifi: cfg80211: Clear mlo_links info when STA disconnects

Xuan Zhuo (12):
      virtio_net: introduce ability to get reply info from device
      virtio_net: introduce device stats feature and structures
      virtio_net: remove "_queue" from ethtool -S
      virtio_net: support device stats
      virtio_net: device stats helpers support driver stats
      virtio_net: add the total stats field
      netdev: add queue stats
      virtio-net: support queue stat
      virtio_ring: enable premapped mode whatever use_dma_api
      virtio_net: big mode skip the unmap check
      virtio_net: rx remove premapped failover code
      virtio_net: remove the misleading comment

Yafang Shao (1):
      bpf: Mitigate latency spikes associated with freeing non-preallocated htab

Yedidya Benshimol (6):
      wifi: iwlwifi: mvm: disable EMLSR when we suspend with wowlan
      wifi: iwlwifi: mvm: Disable/enable EMLSR due to link's bandwidth/band
      wifi: iwlwifi: mvm: Block EMLSR when a p2p/softAP vif is active
      wifi: iwlwifi: mvm: Add active EMLSR blocking reasons prints
      wifi: iwlwifi: mvm: add a debugfs for reading EMLSR blocking reasons
      wifi: iwlwifi: mvm: Add a print for invalid link pair due to bandwidth

Yonghong Song (24):
      bpftool: Fix missing pids during link show
      bpf: Allow helper bpf_get_[ns_]current_pid_tgid() for all prog types
      selftests/bpf: Replace CHECK with ASSERT_* in ns_current_pid_tgid test
      selftests/bpf: Refactor out some functions in ns_current_pid_tgid test
      selftests/bpf: Add a cgroup prog bpf_get_ns_current_pid_tgid() test
      selftests/bpf: Add a sk_msg prog bpf_get_ns_current_pid_tgid() test
      libbpf: Add new sec_def "sk_skb/verdict"
      bpf: Sync uapi bpf.h to tools directory
      selftests/bpf: Fix flaky test btf_map_in_map/lookup_update
      selftests/bpf: Replace CHECK with ASSERT macros for ksyms test
      libbpf: Mark libbpf_kallsyms_parse static function
      libbpf: Handle <orig_name>.llvm.<hash> symbol properly
      selftests/bpf: Refactor some functions for kprobe_multi_test
      selftests/bpf: Refactor trace helper func load_kallsyms_local()
      selftests/bpf: Add {load,search}_kallsyms_custom_local()
      selftests/bpf: Fix kprobe_multi_bench_attach test failure with LTO kernel
      selftests/bpf: Add a kprobe_multi subtest to use addrs instead of syms
      selftests/bpf: Using llvm may_goto inline asm for cond_break macro
      bpf: Add bpf_link support for sk_msg and sk_skb progs
      libbpf: Add bpf_link support for BPF_PROG_TYPE_SOCKMAP
      bpftool: Add link dump support for BPF_LINK_TYPE_SOCKMAP
      selftests/bpf: Refactor out helper functions for a few tests
      selftests/bpf: Add some tests with new bpf_program__attach_sockmap() APIs
      selftests/bpf: Enable tests for atomics with cpuv4

Yujie Liu (1):
      selftests: fix netfilter path in Makefile

Zheng Li (1):
      neighbour: guarantee the localhost connections be established successfully even the ARP table is full

Zhengchao Shao (1):
      net/smc: make smc_hash_sk/smc_unhash_sk static

Zijun Hu (4):
      Bluetooth: btusb: Correct timeout macro argument used to receive control message
      Bluetooth: hci_conn: Remove a redundant check for HFP offload
      Bluetooth: Remove 3 repeated macro definitions
      Bluetooth: qca: Support downloading board id specific NVM for WCN7850

Ziwei Xiao (1):
      gve: Remove qpl_cfg struct since qpl_ids map with queues respectively

Zong-Zhe Yang (11):
      wifi: rtw89: 8852c: update TX power tables to R69
      wifi: rtw89: sar: correct TX power boundary for MAC domain
      wifi: rtw89: fw: scan offload prohibit all 6 GHz channel if no 6 GHz sband
      wifi: rtw89: 8852c: update TX power tables to R69.1 (1 of 2)
      wifi: rtw89: 8852c: update TX power tables to R69.1 (2 of 2)
      wifi: rtw89: regd: block 6 GHz by policy if not specific country
      wifi: rtw89: regd: extend policy of UNII-4 for IC regulatory
      wifi: rtw89: acpi: process 6 GHz SP policy from ACPI DSM
      wifi: rtw89: regd: handle policy of 6 GHz SP according to BIOS
      wifi: rtw89: set WIPHY_FLAG_DISABLE_WEXT before MLO
      wifi: rtw89: 8922a: fix argument to hal_reset in bb_cfg_txrx_path

gaoxingwang (1):
      net: ipv6: fix wrong start position when receive hop-by-hop fragment

linke li (2):
      net: ethernet: mtk_eth_soc: Reuse value using READ_ONCE instead of re-rereading it
      net: bridge: remove redundant check of f->dst

striebit (1):
      wifi: iwlwifi: mvm: add beacon template version 14

 Documentation/admin-guide/sysctl/net.rst           |    1 +
 .../bpf/standardization/instruction-set.rst        |  109 +-
 Documentation/conf.py                              |    2 +
 .../devicetree/bindings/net/airoha,en8811h.yaml    |   56 +
 .../net/bluetooth/mediatek,mt7921s-bluetooth.yaml  |   55 +
 .../bindings/net/broadcom-bluetooth.yaml           |   33 +-
 .../devicetree/bindings/net/nxp,dwmac-imx.yaml     |    4 +
 .../bindings/net/pse-pd/microchip,pd692x0.yaml     |  169 ++
 .../bindings/net/pse-pd/pse-controller.yaml        |  101 +-
 .../bindings/net/pse-pd/ti,tps23881.yaml           |   95 +
 .../devicetree/bindings/net/qcom,ipq4019-mdio.yaml |    2 +
 .../devicetree/bindings/net/renesas,etheravb.yaml  |   12 +-
 .../devicetree/bindings/net/renesas,ethertsn.yaml  |   33 +-
 .../devicetree/bindings/net/renesas,rzn1-gmac.yaml |   66 +
 .../devicetree/bindings/net/rockchip-dwmac.yaml    |    4 +-
 .../devicetree/bindings/net/snps,dwmac.yaml        |   20 +-
 .../bindings/net/starfive,jh7110-dwmac.yaml        |   26 +-
 .../devicetree/bindings/net/stm32-dwmac.yaml       |    7 +
 .../devicetree/bindings/net/ti,icssg-prueth.yaml   |   35 +-
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   |    1 +
 .../bindings/net/wireless/qcom,ath10k.yaml         |    6 +
 .../bindings/net/wireless/qcom,ath11k.yaml         |    3 +
 Documentation/mm/page_frags.rst                    |    2 +-
 Documentation/netlink/genetlink-c.yaml             |    2 +-
 Documentation/netlink/genetlink-legacy.yaml        |    2 +-
 Documentation/netlink/genetlink.yaml               |    2 +-
 Documentation/netlink/netlink-raw.yaml             |    2 +-
 Documentation/netlink/specs/ethtool.yaml           |   55 +-
 Documentation/netlink/specs/netdev.yaml            |  119 +
 Documentation/netlink/specs/nftables.yaml          | 1264 ++++++++
 Documentation/netlink/specs/nlctrl.yaml            |    6 +-
 Documentation/netlink/specs/rt_link.yaml           |  483 +++-
 Documentation/netlink/specs/tc.yaml                |   72 +-
 Documentation/netlink/specs/team.yaml              |  204 ++
 .../ethernet/mellanox/mlx5/counters.rst            |   11 +
 Documentation/networking/devlink/devlink-info.rst  |    5 +
 Documentation/networking/devlink/devlink-port.rst  |   33 +
 Documentation/networking/devlink/hns3.rst          |    5 +
 Documentation/networking/devlink/ice.rst           |   47 +
 Documentation/networking/devlink/nfp.rst           |    5 +-
 Documentation/networking/dns_resolver.rst          |    4 +-
 Documentation/networking/ethtool-netlink.rst       |   29 +
 Documentation/networking/filter.rst                |    4 +-
 Documentation/networking/index.rst                 |    1 +
 Documentation/networking/nf_conntrack-sysctl.rst   |    4 +-
 Documentation/networking/pse-pd/index.rst          |   10 +
 Documentation/networking/pse-pd/introduction.rst   |   73 +
 Documentation/networking/pse-pd/pse-pi.rst         |  301 ++
 Documentation/networking/xfrm_proc.rst             |    6 +
 Documentation/translations/zh_CN/mm/page_frags.rst |    2 +-
 .../userspace-api/netlink/genetlink-legacy.rst     |   22 +-
 MAINTAINERS                                        |   52 +
 arch/arc/Kbuild                                    |    1 +
 arch/arc/Kconfig                                   |    1 +
 arch/arc/net/Makefile                              |    6 +
 arch/arc/net/bpf_jit.h                             |  164 ++
 arch/arc/net/bpf_jit_arcv2.c                       | 3005 ++++++++++++++++++++
 arch/arc/net/bpf_jit_core.c                        | 1425 ++++++++++
 arch/arm/net/bpf_jit_32.c                          |   25 +-
 arch/arm64/include/asm/insn.h                      |    8 +
 arch/arm64/lib/insn.c                              |   11 +
 arch/arm64/net/bpf_jit.h                           |    8 +
 arch/arm64/net/bpf_jit_comp.c                      |  178 +-
 arch/loongarch/net/bpf_jit.c                       |   22 +-
 arch/mips/net/bpf_jit_comp.c                       |    3 +-
 arch/parisc/net/bpf_jit_core.c                     |    8 +-
 arch/riscv/net/bpf_jit.h                           |    6 +-
 arch/riscv/net/bpf_jit_comp64.c                    |  273 +-
 arch/riscv/net/bpf_jit_core.c                      |    2 +
 arch/s390/net/bpf_jit_comp.c                       |   14 +-
 arch/sparc/net/bpf_jit_comp_64.c                   |    6 +-
 arch/x86/net/bpf_jit_comp.c                        |  102 +-
 arch/x86/net/bpf_jit_comp32.c                      |    3 +-
 crypto/Makefile                                    |    3 +
 crypto/af_alg.c                                    |    4 +-
 crypto/bpf_crypto_skcipher.c                       |   82 +
 drivers/atm/fore200e.c                             |    3 -
 drivers/atm/fore200e.h                             |    1 -
 drivers/bcma/host_soc.c                            |    6 +-
 drivers/bluetooth/Kconfig                          |   11 +
 drivers/bluetooth/Makefile                         |    1 +
 drivers/bluetooth/ath3k.c                          |   25 +-
 drivers/bluetooth/btintel.c                        |   88 +-
 drivers/bluetooth/btintel.h                        |   51 +-
 drivers/bluetooth/btintel_pcie.c                   | 1357 +++++++++
 drivers/bluetooth/btintel_pcie.h                   |  430 +++
 drivers/bluetooth/btmrvl_main.c                    |    9 -
 drivers/bluetooth/btqca.c                          |   47 +-
 drivers/bluetooth/btqca.h                          |   58 +-
 drivers/bluetooth/btqcomsmd.c                      |    6 +-
 drivers/bluetooth/btrsi.c                          |    1 -
 drivers/bluetooth/btrtl.c                          |    7 +
 drivers/bluetooth/btsdio.c                         |    8 -
 drivers/bluetooth/btusb.c                          |   55 +-
 drivers/bluetooth/hci_bcm.c                        |    8 +-
 drivers/bluetooth/hci_bcm4377.c                    |    1 -
 drivers/bluetooth/hci_intel.c                      |   25 +-
 drivers/bluetooth/hci_ldisc.c                      |    6 -
 drivers/bluetooth/hci_serdev.c                     |    5 -
 drivers/bluetooth/hci_uart.h                       |    1 -
 drivers/bluetooth/hci_vhci.c                       |   10 +-
 drivers/bluetooth/virtio_bt.c                      |    2 -
 drivers/bus/mhi/host/internal.h                    |    4 +-
 drivers/bus/mhi/host/pm.c                          |   42 +-
 .../crypto/marvell/octeontx2/otx2_cpt_devlink.c    |    9 +-
 drivers/dpll/dpll_core.c                           |    2 +-
 drivers/infiniband/core/addr.c                     |   12 +-
 drivers/infiniband/hw/hfi1/netdev.h                |    2 +-
 drivers/infiniband/hw/hfi1/netdev_rx.c             |    9 +-
 drivers/infiniband/hw/irdma/cm.c                   |    3 +-
 drivers/infiniband/hw/mana/qp.c                    |   12 +-
 drivers/infiniband/hw/qedr/qedr_iw_cm.c            |    3 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |    4 +-
 drivers/isdn/capi/Makefile                         |    3 +-
 drivers/isdn/capi/kcapi.c                          |    7 +-
 drivers/md/dm-clone-metadata.c                     |    5 -
 drivers/net/Kconfig                                |   16 +-
 drivers/net/Makefile                               |    1 +
 drivers/net/arcnet/Kconfig                         |    2 +-
 drivers/net/arcnet/arcdevice.h                     |    3 +-
 drivers/net/arcnet/arcnet.c                        |   11 +-
 drivers/net/bareudp.c                              |   19 +-
 drivers/net/bonding/bond_main.c                    |   12 +-
 drivers/net/bonding/bond_netlink.c                 |    3 +-
 drivers/net/bonding/bond_options.c                 |    2 +-
 drivers/net/bonding/bond_procfs.c                  |    2 +-
 drivers/net/bonding/bond_sysfs.c                   |   25 +-
 drivers/net/bonding/bond_sysfs_slave.c             |    2 +-
 drivers/net/can/cc770/Kconfig                      |    1 +
 drivers/net/can/dev/dev.c                          |    2 +-
 drivers/net/can/sja1000/Kconfig                    |    1 +
 drivers/net/can/vcan.c                             |    2 +-
 drivers/net/can/vxcan.c                            |    2 +-
 drivers/net/dsa/b53/b53_common.c                   |  212 +-
 drivers/net/dsa/b53/b53_priv.h                     |   12 -
 drivers/net/dsa/bcm_sf2.c                          |   49 +-
 drivers/net/dsa/hirschmann/hellcreek_ptp.c         |   25 +-
 drivers/net/dsa/lan9303-core.c                     |   38 +-
 drivers/net/dsa/lantiq_gswip.c                     |   39 +-
 drivers/net/dsa/microchip/Kconfig                  |    2 +
 drivers/net/dsa/microchip/Makefile                 |    2 +-
 drivers/net/dsa/microchip/ksz8.h                   |    9 +-
 drivers/net/dsa/microchip/ksz8795.c                |  249 +-
 drivers/net/dsa/microchip/ksz8795_reg.h            |   10 +-
 drivers/net/dsa/microchip/ksz9477.c                |    6 -
 drivers/net/dsa/microchip/ksz9477_tc_flower.c      |    3 +
 drivers/net/dsa/microchip/ksz_common.c             |  224 +-
 drivers/net/dsa/microchip/ksz_common.h             |   16 +-
 drivers/net/dsa/microchip/ksz_dcb.c                |  809 ++++++
 drivers/net/dsa/microchip/ksz_dcb.h                |   23 +
 drivers/net/dsa/microchip/ksz_spi.c                |    8 -
 drivers/net/dsa/mt7530-mdio.c                      |   28 +-
 drivers/net/dsa/mt7530.c                           |  479 ++--
 drivers/net/dsa/mt7530.h                           |  279 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |  117 +-
 drivers/net/dsa/mv88e6xxx/chip.h                   |    6 +
 drivers/net/dsa/mv88e6xxx/global1.c                |   89 +
 drivers/net/dsa/mv88e6xxx/global1.h                |    2 +
 drivers/net/dsa/ocelot/felix_vsc9959.c             |    3 +
 drivers/net/dsa/qca/ar9331.c                       |   37 +-
 drivers/net/dsa/qca/qca8k-8xxx.c                   |   49 +-
 drivers/net/dsa/realtek/realtek.h                  |    2 +
 drivers/net/dsa/realtek/rtl8365mb.c                |   32 +-
 drivers/net/dsa/realtek/rtl8366rb.c                |  392 ++-
 drivers/net/dsa/realtek/rtl83xx.c                  |    8 +-
 drivers/net/dsa/rzn1_a5psw.c                       |   47 +-
 drivers/net/dsa/sja1105/sja1105_flower.c           |    3 +
 drivers/net/dsa/sja1105/sja1105_main.c             |   39 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c             |  263 +-
 drivers/net/dsa/vitesse-vsc73xx.h                  |   27 +-
 drivers/net/dsa/xrs700x/xrs700x.c                  |   26 +-
 drivers/net/ethernet/3com/3c515.c                  |    3 -
 drivers/net/ethernet/3com/3c589_cs.c               |    2 +-
 drivers/net/ethernet/3com/Kconfig                  |    4 +-
 drivers/net/ethernet/8390/Kconfig                  |    6 +-
 drivers/net/ethernet/8390/etherh.c                 |    2 +-
 drivers/net/ethernet/8390/pcnet_cs.c               |    2 +-
 drivers/net/ethernet/adi/adin1110.c                |    2 +-
 drivers/net/ethernet/agere/et131x.c                |    2 +-
 drivers/net/ethernet/alteon/acenic.c               |    2 +-
 drivers/net/ethernet/altera/altera_tse_main.c      |    2 +-
 drivers/net/ethernet/amazon/ena/ena_com.h          |    6 +-
 drivers/net/ethernet/amazon/ena/ena_eth_com.c      |   37 +-
 drivers/net/ethernet/amazon/ena/ena_eth_com.h      |    2 +-
 drivers/net/ethernet/amazon/ena/ena_ethtool.c      |   15 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   39 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.h       |    1 +
 drivers/net/ethernet/amazon/ena/ena_regs_defs.h    |    1 +
 drivers/net/ethernet/amd/Kconfig                   |    4 +-
 drivers/net/ethernet/amd/amd8111e.c                |    7 +-
 drivers/net/ethernet/amd/amd8111e.h                |    1 -
 drivers/net/ethernet/amd/nmclan_cs.c               |    2 +-
 drivers/net/ethernet/amd/pds_core/core.h           |    3 +-
 drivers/net/ethernet/amd/pds_core/devlink.c        |    3 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |    2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c      |    8 -
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   |    2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_main.c   |    2 +-
 drivers/net/ethernet/atheros/ag71xx.c              |    2 +-
 drivers/net/ethernet/atheros/alx/main.c            |    2 +-
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c    |    2 +-
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |    2 +-
 drivers/net/ethernet/atheros/atlx/atl1.c           |    2 +-
 drivers/net/ethernet/atheros/atlx/atl2.c           |    2 +-
 drivers/net/ethernet/broadcom/b44.c                |    4 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.c       |    2 +-
 drivers/net/ethernet/broadcom/bnx2.c               |    2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  704 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   45 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c  |   13 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  241 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h      |  184 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |   30 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h      |    5 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c       |    4 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |  169 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h      |   17 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |   30 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h      |    2 +-
 drivers/net/ethernet/broadcom/cnic.c               |    3 +-
 drivers/net/ethernet/broadcom/tg3.c                |   32 +-
 drivers/net/ethernet/brocade/bna/bnad.c            |    2 +-
 drivers/net/ethernet/cadence/macb_main.c           |    2 +-
 drivers/net/ethernet/calxeda/xgmac.c               |    2 +-
 drivers/net/ethernet/cavium/liquidio/lio_core.c    |    2 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c  |    2 +-
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c   |    2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |    2 +-
 drivers/net/ethernet/chelsio/cxgb/cxgb2.c          |    2 +-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |    2 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c   |   67 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c     |    2 +-
 .../net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c    |    2 +-
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c      |    1 +
 drivers/net/ethernet/cisco/enic/enic_main.c        |    2 +-
 drivers/net/ethernet/cisco/enic/vnic_dev.c         |   20 +-
 drivers/net/ethernet/cisco/enic/vnic_dev.h         |    5 +
 drivers/net/ethernet/cortina/gemini.c              |   14 +-
 drivers/net/ethernet/dlink/sundance.c              |    2 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |    5 +-
 drivers/net/ethernet/faraday/ftmac100.c            |    2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |    2 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |   16 +-
 .../ethernet/freescale/dpaa2/dpaa2-switch-flower.c |    6 +
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |    2 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       |    2 +-
 drivers/net/ethernet/freescale/fec_main.c          |   26 -
 drivers/net/ethernet/freescale/fman/fman_memac.c   |    1 -
 drivers/net/ethernet/freescale/fman/fman_muram.c   |    1 -
 drivers/net/ethernet/freescale/gianfar.c           |    2 +-
 drivers/net/ethernet/fujitsu/Kconfig               |    2 +-
 drivers/net/ethernet/fungible/funeth/funeth_main.c |    2 +-
 drivers/net/ethernet/google/gve/gve.h              |   97 +-
 drivers/net/ethernet/google/gve/gve_adminq.c       |  229 +-
 drivers/net/ethernet/google/gve/gve_adminq.h       |   50 +-
 drivers/net/ethernet/google/gve/gve_dqo.h          |    6 +
 drivers/net/ethernet/google/gve/gve_ethtool.c      |  160 +-
 drivers/net/ethernet/google/gve/gve_main.c         |  621 ++--
 drivers/net/ethernet/google/gve/gve_rx.c           |  138 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |  140 +-
 drivers/net/ethernet/google/gve/gve_tx.c           |   31 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       |   22 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |    2 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   13 +
 .../hisilicon/hns3/hns3_common/hclge_comm_cmd.c    |   19 +
 .../hisilicon/hns3/hns3_common/hclge_comm_cmd.h    |   24 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |    2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |  646 ++++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h |  643 +----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c |   44 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_devlink.h |    2 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c |  433 ++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h |   36 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   81 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |    1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_trace.h   |   94 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   40 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h |   50 +
 drivers/net/ethernet/huawei/hinic/hinic_main.c     |    2 +-
 drivers/net/ethernet/ibm/emac/core.c               |    4 +-
 drivers/net/ethernet/ibm/emac/mal.c                |   14 +-
 drivers/net/ethernet/ibm/emac/mal.h                |    2 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |    2 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |   10 +-
 drivers/net/ethernet/intel/Kconfig                 |    9 +-
 drivers/net/ethernet/intel/Makefile                |    3 +
 drivers/net/ethernet/intel/e100.c                  |    8 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c      |   16 +-
 drivers/net/ethernet/intel/e1000e/defines.h        |    2 -
 drivers/net/ethernet/intel/e1000e/ethtool.c        |   62 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |   24 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c       |   10 +-
 drivers/net/ethernet/intel/i40e/i40e.h             |   29 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c      |   28 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  253 --
 drivers/net/ethernet/intel/i40e/i40e_ddp.c         |    3 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |   36 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   29 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  225 +-
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         | 1160 ++++----
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |    7 -
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |    6 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   92 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h        |   88 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   14 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |    3 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c      |  253 --
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  140 -
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   54 +-
 drivers/net/ethernet/intel/iavf/iavf_prototype.h   |    7 -
 drivers/net/ethernet/intel/iavf/iavf_txrx.c        |  551 +---
 drivers/net/ethernet/intel/iavf/iavf_txrx.h        |  146 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h        |   90 -
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |   17 +-
 drivers/net/ethernet/intel/ice/Makefile            |    7 +-
 .../intel/ice/{ice_devlink.c => devlink/devlink.c} |  575 ++--
 .../intel/ice/{ice_devlink.h => devlink/devlink.h} |    0
 .../net/ethernet/intel/ice/devlink/devlink_port.c  |  430 +++
 .../net/ethernet/intel/ice/devlink/devlink_port.h  |   12 +
 drivers/net/ethernet/intel/ice/ice.h               |   26 +-
 drivers/net/ethernet/intel/ice/ice_adapter.c       |  116 +
 drivers/net/ethernet/intel/ice/ice_adapter.h       |   28 +
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |   34 +
 drivers/net/ethernet/intel/ice/ice_base.c          |   47 +-
 drivers/net/ethernet/intel/ice/ice_common.c        |   21 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c       |    6 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c           |  228 +-
 drivers/net/ethernet/intel/ice/ice_ddp.h           |    2 +
 drivers/net/ethernet/intel/ice/ice_devids.h        |   22 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c       |  369 +--
 drivers/net/ethernet/intel/ice/ice_eswitch.h       |   13 +-
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c  |  140 +-
 drivers/net/ethernet/intel/ice/ice_fdir.c          |  111 +-
 drivers/net/ethernet/intel/ice/ice_fdir.h          |    5 +
 drivers/net/ethernet/intel/ice/ice_flex_type.h     |    4 +-
 drivers/net/ethernet/intel/ice/ice_fw_update.c     |    7 +-
 drivers/net/ethernet/intel/ice/ice_fw_update.h     |    3 +
 drivers/net/ethernet/intel/ice/ice_lag.c           |   53 +-
 drivers/net/ethernet/intel/ice/ice_lag.h           |    3 +-
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h     |  320 ---
 drivers/net/ethernet/intel/ice/ice_lib.c           |   83 +-
 drivers/net/ethernet/intel/ice/ice_lib.h           |   39 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  239 +-
 drivers/net/ethernet/intel/ice/ice_nvm.c           |    7 +-
 drivers/net/ethernet/intel/ice/ice_nvm.h           |    3 +
 drivers/net/ethernet/intel/ice/ice_protocol_type.h |   12 +
 drivers/net/ethernet/intel/ice/ice_ptp.c           |   33 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        |    3 +
 drivers/net/ethernet/intel/ice/ice_repr.c          |  135 +-
 drivers/net/ethernet/intel/ice/ice_repr.h          |   24 +-
 drivers/net/ethernet/intel/ice/ice_sched.c         |   37 +-
 drivers/net/ethernet/intel/ice/ice_sched.h         |   11 +
 drivers/net/ethernet/intel/ice/ice_sriov.c         |   42 +-
 drivers/net/ethernet/intel/ice/ice_sriov.h         |    7 +-
 drivers/net/ethernet/intel/ice/ice_switch.c        |  276 +-
 drivers/net/ethernet/intel/ice/ice_switch.h        |    8 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c        |  128 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.h        |    8 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |    3 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h          |    1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c      |  122 +-
 drivers/net/ethernet/intel/ice/ice_type.h          |    5 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |   13 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |   14 +-
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_ops.c  |    1 -
 drivers/net/ethernet/intel/ice/ice_xsk.c           |    3 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |    2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |    5 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |    2 +
 drivers/net/ethernet/intel/idpf/virtchnl2.h        |   24 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |   15 -
 drivers/net/ethernet/intel/igb/igb_main.c          |   64 +-
 drivers/net/ethernet/intel/igbvf/netdev.c          |    8 +-
 drivers/net/ethernet/intel/igc/igc.h               |   71 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   17 -
 drivers/net/ethernet/intel/igc/igc_main.c          |  179 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c           |   51 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   21 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      |    1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       |    3 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |   10 +-
 drivers/net/ethernet/intel/libeth/Kconfig          |    9 +
 drivers/net/ethernet/intel/libeth/Makefile         |    6 +
 drivers/net/ethernet/intel/libeth/rx.c             |  150 +
 drivers/net/ethernet/intel/libie/Kconfig           |   10 +
 drivers/net/ethernet/intel/libie/Makefile          |    6 +
 drivers/net/ethernet/intel/libie/rx.c              |  124 +
 drivers/net/ethernet/jme.c                         |    2 +-
 drivers/net/ethernet/lantiq_etop.c                 |    2 +-
 drivers/net/ethernet/lantiq_xrx200.c               |    4 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c         |    2 +-
 drivers/net/ethernet/marvell/mvneta.c              |    5 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   11 +-
 .../net/ethernet/marvell/octeon_ep/octep_main.c    |    2 +-
 .../ethernet/marvell/octeon_ep_vf/octep_vf_main.c  |    2 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |   27 +
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h    |    1 +
 .../ethernet/marvell/octeontx2/af/lmac_common.h    |    1 +
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |    7 +-
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c    |   17 +
 drivers/net/ethernet/marvell/octeontx2/af/rpm.h    |    3 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |   29 +
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |   12 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |    2 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |    3 +
 .../ethernet/marvell/octeontx2/nic/otx2_devlink.c  |    3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |    1 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   42 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |   21 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |    3 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.h |    3 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |    2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c   |   80 +-
 .../ethernet/marvell/prestera/prestera_flower.c    |    4 +
 .../net/ethernet/marvell/prestera/prestera_hw.c    |   83 +-
 .../net/ethernet/marvell/prestera/prestera_main.c  |    6 +-
 .../net/ethernet/marvell/prestera/prestera_rxtx.c  |   15 +-
 drivers/net/ethernet/marvell/pxa168_eth.c          |    2 +-
 drivers/net/ethernet/marvell/skge.c                |    4 +-
 drivers/net/ethernet/marvell/sky2.c                |    5 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  259 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h        |   31 +-
 drivers/net/ethernet/mediatek/mtk_ppe.c            |    2 +-
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c    |    4 +
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |    4 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |    1 +
 drivers/net/ethernet/mellanox/mlx4/main.c          |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   46 +-
 drivers/net/ethernet/mellanox/mlx5/core/debugfs.c  |   22 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   45 +-
 .../net/ethernet/mellanox/mlx5/core/en/channels.c  |   83 +
 .../net/ethernet/mellanox/mlx5/core/en/channels.h  |    4 +
 drivers/net/ethernet/mellanox/mlx5/core/en/dim.h   |   45 +
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |   72 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.h    |    5 -
 drivers/net/ethernet/mellanox/mlx5/core/en/port.c  |   50 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |    1 +
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.h    |    2 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |    6 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_geneve.c |   12 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_gre.c    |    8 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c  |    9 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |    2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/setup.c |    6 +-
 .../ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c  |    2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h  |    4 +-
 .../mellanox/mlx5/core/en_accel/ipsec_stats.c      |   28 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls.h    |   14 +-
 .../mellanox/mlx5/core/en_accel/ktls_stats.c       |   26 +-
 .../mellanox/mlx5/core/en_accel/macsec_stats.c     |   22 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_dim.c   |   95 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  345 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c    |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  320 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   82 +-
 .../net/ethernet/mellanox/mlx5/core/en_selftest.c  |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |  539 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |   16 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   29 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c  |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |    9 +-
 .../net/ethernet/mellanox/mlx5/core/esw/bridge.c   |    2 +-
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |    4 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   11 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  128 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c       |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |    3 +-
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |    2 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |    9 +-
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    |    4 +-
 .../net/ethernet/mellanox/mlx5/core/lag/port_sel.c |    8 +-
 .../net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c   |  252 +-
 .../net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h   |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   14 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |    2 +-
 .../net/ethernet/mellanox/mlx5/core/pagealloc.c    |    3 +
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |   52 -
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c    |   19 +-
 .../mellanox/mlx5/core/steering/dr_ste_v0.c        |    2 +-
 .../mellanox/mlx5/core/steering/dr_ste_v1.c        |    4 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |  530 ++--
 drivers/net/ethernet/mellanox/mlxsw/pci_hw.h       |    4 +-
 drivers/net/ethernet/mellanox/mlxsw/reg.h          |    3 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |    2 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl_tcam.c    |    3 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_ethtool.c |   60 +
 .../net/ethernet/mellanox/mlxsw/spectrum_flower.c  |    4 +
 .../net/ethernet/mellanox/mlxsw/spectrum_ipip.c    |   56 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_ipip.h    |    2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_span.c    |   12 +-
 drivers/net/ethernet/micrel/ksz884x.c              |    2 +-
 drivers/net/ethernet/microchip/encx24j600-regmap.c |    4 +-
 drivers/net/ethernet/microchip/encx24j600.c        |    7 +-
 drivers/net/ethernet/microchip/encx24j600_hw.h     |    2 +-
 drivers/net/ethernet/microchip/lan743x_ethtool.c   |   21 -
 drivers/net/ethernet/microchip/lan743x_main.c      |   13 +-
 drivers/net/ethernet/microchip/lan743x_ptp.c       |    4 +-
 drivers/net/ethernet/microchip/lan743x_ptp.h       |    1 +
 .../net/ethernet/microchip/lan966x/lan966x_ifh.h   |    2 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |    6 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |    2 +-
 .../net/ethernet/microchip/lan966x/lan966x_port.c  |    2 +-
 .../ethernet/microchip/lan966x/lan966x_tc_flower.c |   14 +-
 .../net/ethernet/microchip/lan966x/lan966x_vlan.c  |    2 +-
 drivers/net/ethernet/microchip/sparx5/Makefile     |    3 +-
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    |    2 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |    3 +
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   25 +
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   |   68 +
 .../net/ethernet/microchip/sparx5/sparx5_mirror.c  |  235 ++
 .../net/ethernet/microchip/sparx5/sparx5_packet.c  |    2 +-
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |    2 +-
 .../ethernet/microchip/sparx5/sparx5_switchdev.c   |    2 +-
 .../ethernet/microchip/sparx5/sparx5_tc_flower.c   |   88 +-
 .../ethernet/microchip/sparx5/sparx5_tc_matchall.c |  125 +-
 drivers/net/ethernet/microchip/vcap/vcap_ag_api.h  |    2 +-
 drivers/net/ethernet/microchip/vcap/vcap_api.c     |   16 +-
 .../net/ethernet/microchip/vcap/vcap_api_client.h  |    4 +-
 .../net/ethernet/microchip/vcap/vcap_api_private.h |    2 +-
 drivers/net/ethernet/microsoft/Kconfig             |    3 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   18 +-
 drivers/net/ethernet/mscc/ocelot_flower.c          |    7 +-
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c   |    8 +-
 drivers/net/ethernet/natsemi/natsemi.c             |    2 +-
 drivers/net/ethernet/neterion/s2io.c               |    2 +-
 drivers/net/ethernet/netronome/nfp/devlink_param.c |    3 +-
 drivers/net/ethernet/netronome/nfp/flower/action.c |   27 +-
 .../net/ethernet/netronome/nfp/flower/offload.c    |    6 +-
 drivers/net/ethernet/netronome/nfp/nfp_devlink.c   |    1 +
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |    7 +-
 .../net/ethernet/netronome/nfp/nfp_net_debugdump.c |   41 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c  |    2 +-
 drivers/net/ethernet/ni/nixge.c                    |    2 +-
 drivers/net/ethernet/nvidia/forcedeth.c            |    2 +-
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   |    2 +-
 drivers/net/ethernet/pasemi/pasemi_mac.c           |    2 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |    4 +-
 drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c |    2 +-
 drivers/net/ethernet/qlogic/qed/qed.h              |    2 -
 drivers/net/ethernet/qlogic/qed/qed_devlink.c      |    3 +-
 drivers/net/ethernet/qlogic/qed/qed_main.c         |   12 +-
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |    2 +-
 drivers/net/ethernet/qlogic/qede/qede_filter.c     |  138 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c     |    2 +-
 drivers/net/ethernet/qualcomm/emac/emac.c          |    2 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c    |    2 +-
 drivers/net/ethernet/realtek/8139cp.c              |    4 +-
 drivers/net/ethernet/realtek/r8169_main.c          |    4 +-
 drivers/net/ethernet/renesas/ravb_main.c           |   11 +-
 drivers/net/ethernet/renesas/sh_eth.c              |    2 +-
 drivers/net/ethernet/rocker/rocker_main.c          |    2 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c    |    2 +-
 drivers/net/ethernet/sfc/efx_common.c              |    2 +-
 drivers/net/ethernet/sfc/falcon/efx.c              |    2 +-
 drivers/net/ethernet/sfc/siena/efx_common.c        |    2 +-
 drivers/net/ethernet/sfc/tc.c                      |    7 +-
 drivers/net/ethernet/sis/Kconfig                   |    4 +-
 drivers/net/ethernet/sis/sis900.c                  |    6 +-
 drivers/net/ethernet/smsc/Kconfig                  |    2 +-
 drivers/net/ethernet/smsc/smc91c92_cs.c            |    2 +-
 drivers/net/ethernet/smsc/smc91x.h                 |    4 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   12 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 +
 drivers/net/ethernet/stmicro/stmmac/common.h       |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ipq806x.c    |   12 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |    2 -
 drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c   |   86 +
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |  107 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |    8 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |    8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   20 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   90 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   50 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |   30 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |   58 +-
 drivers/net/ethernet/sun/cassini.c                 |    3 +-
 drivers/net/ethernet/sun/niu.c                     |    2 +-
 drivers/net/ethernet/sun/sungem.c                  |   16 +-
 drivers/net/ethernet/synopsys/dwc-xlgmac-net.c     |    2 +-
 drivers/net/ethernet/tehuti/tehuti.c               |    2 +-
 drivers/net/ethernet/ti/Kconfig                    |   17 +-
 drivers/net/ethernet/ti/Makefile                   |    9 +
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c        |   13 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  702 ++++-
 drivers/net/ethernet/ti/am65-cpsw-nuss.h           |   13 +
 drivers/net/ethernet/ti/am65-cpsw-qos.c            |   19 +-
 drivers/net/ethernet/ti/am65-cpts.c                |  107 +-
 drivers/net/ethernet/ti/am65-cpts.h                |   11 +-
 drivers/net/ethernet/ti/cpsw_new.c                 |    6 +-
 drivers/net/ethernet/ti/cpsw_priv.c                |    3 +
 drivers/net/ethernet/ti/icssg/icssg_classifier.c   |  113 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c       | 1252 ++++++++
 drivers/net/ethernet/ti/icssg/icssg_config.c       |   14 +-
 drivers/net/ethernet/ti/icssg/icssg_config.h       |   56 +
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c      |  105 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       | 1199 +-------
 drivers/net/ethernet/ti/icssg/icssg_prueth.h       |   88 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c   | 1181 ++++++++
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c        |   46 +-
 drivers/net/ethernet/ti/k3-cppi-desc-pool.h        |    6 +
 drivers/net/ethernet/via/Kconfig                   |    1 +
 drivers/net/ethernet/via/via-velocity.c            |    4 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |    2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |    2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet.h       |    4 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |    2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c  |   23 +-
 drivers/net/ethernet/xircom/Kconfig                |    2 +-
 drivers/net/ethernet/xircom/xirc2ps_cs.c           |    4 +-
 drivers/net/ethernet/xscale/ixp4xx_eth.c           |    2 +-
 drivers/net/fddi/defxx.c                           |    2 +-
 drivers/net/fjes/fjes_main.c                       |    2 +-
 drivers/net/geneve.c                               |   46 +-
 drivers/net/gtp.c                                  |  867 +++++-
 drivers/net/hamradio/Kconfig                       |    6 +-
 drivers/net/hyperv/netvsc_drv.c                    |    4 +-
 drivers/net/ipa/data/ipa_data-v3.1.c               |    5 +-
 drivers/net/ipa/data/ipa_data-v3.5.1.c             |    5 +-
 drivers/net/ipa/data/ipa_data-v4.11.c              |    5 +-
 drivers/net/ipa/data/ipa_data-v4.2.c               |    5 +-
 drivers/net/ipa/data/ipa_data-v4.5.c               |    5 +-
 drivers/net/ipa/data/ipa_data-v4.7.c               |    5 +-
 drivers/net/ipa/data/ipa_data-v4.9.c               |    5 +-
 drivers/net/ipa/data/ipa_data-v5.0.c               |    5 +-
 drivers/net/ipa/data/ipa_data-v5.5.c               |    5 +-
 drivers/net/ipa/gsi.c                              |   30 +-
 drivers/net/ipa/gsi.h                              |   12 +-
 drivers/net/ipa/gsi_private.h                      |    7 +-
 drivers/net/ipa/gsi_reg.c                          |    6 +-
 drivers/net/ipa/gsi_trans.c                        |   12 +-
 drivers/net/ipa/gsi_trans.h                        |    9 +-
 drivers/net/ipa/ipa.h                              |   15 +-
 drivers/net/ipa/ipa_cmd.c                          |   13 +-
 drivers/net/ipa/ipa_cmd.h                          |   18 +-
 drivers/net/ipa/ipa_data.h                         |    4 +-
 drivers/net/ipa/ipa_endpoint.c                     |   19 +-
 drivers/net/ipa/ipa_endpoint.h                     |   10 +-
 drivers/net/ipa/ipa_gsi.c                          |    7 +-
 drivers/net/ipa/ipa_interrupt.c                    |   56 +-
 drivers/net/ipa/ipa_interrupt.h                    |    6 +-
 drivers/net/ipa/ipa_main.c                         |   45 +-
 drivers/net/ipa/ipa_mem.c                          |   21 +-
 drivers/net/ipa/ipa_mem.h                          |    4 +-
 drivers/net/ipa/ipa_modem.c                        |   18 +-
 drivers/net/ipa/ipa_modem.h                        |    5 +-
 drivers/net/ipa/ipa_power.c                        |   29 +-
 drivers/net/ipa/ipa_power.h                        |   19 +-
 drivers/net/ipa/ipa_qmi.c                          |   10 +-
 drivers/net/ipa/ipa_qmi.h                          |    4 +-
 drivers/net/ipa/ipa_qmi_msg.c                      |    3 +-
 drivers/net/ipa/ipa_qmi_msg.h                      |    3 +-
 drivers/net/ipa/ipa_reg.c                          |    4 +-
 drivers/net/ipa/ipa_reg.h                          |    6 +-
 drivers/net/ipa/ipa_resource.c                     |    3 +-
 drivers/net/ipa/ipa_smp2p.c                        |   10 +-
 drivers/net/ipa/ipa_sysfs.c                        |    7 +-
 drivers/net/ipa/ipa_sysfs.h                        |    4 +-
 drivers/net/ipa/ipa_table.c                        |   29 +-
 drivers/net/ipa/ipa_table.h                        |    7 +-
 drivers/net/ipa/ipa_uc.c                           |   10 +-
 drivers/net/ipa/ipa_uc.h                           |    3 +-
 drivers/net/ipa/ipa_version.h                      |   22 +-
 drivers/net/ipa/reg.h                              |    8 +-
 drivers/net/ipa/reg/gsi_reg-v3.1.c                 |    8 +-
 drivers/net/ipa/reg/gsi_reg-v3.5.1.c               |    8 +-
 drivers/net/ipa/reg/gsi_reg-v4.0.c                 |    8 +-
 drivers/net/ipa/reg/gsi_reg-v4.11.c                |    8 +-
 drivers/net/ipa/reg/gsi_reg-v4.5.c                 |    8 +-
 drivers/net/ipa/reg/gsi_reg-v4.9.c                 |    8 +-
 drivers/net/ipa/reg/gsi_reg-v5.0.c                 |    8 +-
 drivers/net/ipa/reg/ipa_reg-v3.1.c                 |   20 +-
 drivers/net/ipa/reg/ipa_reg-v3.5.1.c               |   20 +-
 drivers/net/ipa/reg/ipa_reg-v4.11.c                |   20 +-
 drivers/net/ipa/reg/ipa_reg-v4.2.c                 |    6 +-
 drivers/net/ipa/reg/ipa_reg-v4.5.c                 |   20 +-
 drivers/net/ipa/reg/ipa_reg-v4.7.c                 |   20 +-
 drivers/net/ipa/reg/ipa_reg-v4.9.c                 |   20 +-
 drivers/net/ipa/reg/ipa_reg-v5.0.c                 |    6 +-
 drivers/net/ipa/reg/ipa_reg-v5.5.c                 |    6 +-
 drivers/net/ipvlan/ipvlan_main.c                   |    1 +
 drivers/net/loopback.c                             |    5 +-
 drivers/net/macsec.c                               |    2 +-
 drivers/net/macvlan.c                              |    2 +-
 drivers/net/mdio/mdio-gpio.c                       |    3 +-
 drivers/net/net_failover.c                         |    2 +-
 drivers/net/netdevsim/ethtool.c                    |   11 +
 drivers/net/netdevsim/netdev.c                     |  335 ++-
 drivers/net/netdevsim/netdevsim.h                  |   10 +
 drivers/net/ntb_netdev.c                           |    4 +-
 drivers/net/pcs/pcs-lynx.c                         |    5 +-
 drivers/net/pcs/pcs-rzn1-miic.c                    |   28 +
 drivers/net/pfcp.c                                 |  301 ++
 drivers/net/phy/Kconfig                            |    5 +
 drivers/net/phy/Makefile                           |    1 +
 drivers/net/phy/air_en8811h.c                      | 1090 +++++++
 drivers/net/phy/aquantia/aquantia_main.c           |   21 +
 drivers/net/phy/dp83822.c                          |   37 +-
 drivers/net/phy/marvell.c                          |  397 ++-
 drivers/net/phy/mediatek-ge.c                      |    3 -
 drivers/net/phy/micrel.c                           |  566 +++-
 drivers/net/phy/phylink.c                          |   28 +-
 drivers/net/phy/qcom/at803x.c                      |    3 +-
 drivers/net/phy/realtek.c                          |  324 ++-
 drivers/net/phy/sfp-bus.c                          |    5 +-
 drivers/net/phy/sfp.c                              |   27 +-
 drivers/net/ppp/ppp_generic.c                      |    2 +-
 drivers/net/pse-pd/Kconfig                         |   22 +-
 drivers/net/pse-pd/Makefile                        |    2 +
 drivers/net/pse-pd/pd692x0.c                       | 1223 ++++++++
 drivers/net/pse-pd/pse_core.c                      |  529 +++-
 drivers/net/pse-pd/pse_regulator.c                 |   51 +-
 drivers/net/pse-pd/tps23881.c                      |  820 ++++++
 drivers/net/slip/slip.c                            |    2 +-
 drivers/net/tap.c                                  |    2 +-
 drivers/net/team/Makefile                          |    1 +
 drivers/net/team/{team.c => team_core.c}           |   65 +-
 drivers/net/team/team_nl.c                         |   59 +
 drivers/net/team/team_nl.h                         |   29 +
 drivers/net/tun.c                                  |    2 +-
 drivers/net/usb/aqc111.c                           |   10 +-
 drivers/net/usb/asix_devices.c                     |    2 +-
 drivers/net/usb/ax88179_178a.c                     |   45 +-
 drivers/net/usb/cdc_ncm.c                          |    2 +-
 drivers/net/usb/lan78xx.c                          |   44 +-
 drivers/net/usb/qmi_wwan.c                         |   12 +-
 drivers/net/usb/r8152.c                            |    6 +-
 drivers/net/usb/smsc75xx.c                         |   12 +-
 drivers/net/usb/smsc95xx.c                         |   15 +-
 drivers/net/usb/sr9700.c                           |   10 +-
 drivers/net/usb/usbnet.c                           |    3 +-
 drivers/net/veth.c                                 |    1 +
 drivers/net/virtio_net.c                           | 1456 ++++++++--
 drivers/net/vmxnet3/vmxnet3_drv.c                  |    2 +-
 drivers/net/vrf.c                                  |    6 +-
 drivers/net/vsockmon.c                             |    2 +-
 drivers/net/vxlan/vxlan_core.c                     |   20 +-
 drivers/net/wan/Kconfig                            |    2 +-
 drivers/net/wan/fsl_qmc_hdlc.c                     |    6 +-
 drivers/net/wireguard/main.c                       |    2 +-
 drivers/net/wireless/ath/ar5523/ar5523.c           |   14 +
 drivers/net/wireless/ath/ath.h                     |    6 +-
 drivers/net/wireless/ath/ath10k/core.c             |   52 +-
 drivers/net/wireless/ath/ath10k/core.h             |    4 +-
 drivers/net/wireless/ath/ath10k/debugfs_sta.c      |    2 +-
 drivers/net/wireless/ath/ath10k/hw.h               |   14 +-
 drivers/net/wireless/ath/ath10k/pci.c              |   12 +-
 drivers/net/wireless/ath/ath10k/sdio.c             |    2 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |    7 +-
 drivers/net/wireless/ath/ath10k/targaddrs.h        |    3 +
 drivers/net/wireless/ath/ath10k/thermal.c          |    2 +-
 drivers/net/wireless/ath/ath10k/usb.c              |    2 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |   26 +-
 drivers/net/wireless/ath/ath11k/Makefile           |    3 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |   15 +-
 drivers/net/wireless/ath/ath11k/core.c             |  133 +-
 drivers/net/wireless/ath/ath11k/core.h             |    8 +-
 drivers/net/wireless/ath/ath11k/debugfs.c          |    4 +-
 drivers/net/wireless/ath/ath11k/hal.h              |    2 +-
 drivers/net/wireless/ath/ath11k/hif.h              |   14 +-
 drivers/net/wireless/ath/ath11k/mac.c              |  178 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |   29 +-
 drivers/net/wireless/ath/ath11k/mhi.h              |    5 +-
 drivers/net/wireless/ath/ath11k/p2p.c              |  149 +
 drivers/net/wireless/ath/ath11k/p2p.h              |   22 +
 drivers/net/wireless/ath/ath11k/pci.c              |   44 +-
 drivers/net/wireless/ath/ath11k/pci.h              |    1 +
 drivers/net/wireless/ath/ath11k/pcic.c             |   21 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |    2 +-
 drivers/net/wireless/ath/ath11k/thermal.c          |    2 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |  104 +-
 drivers/net/wireless/ath/ath11k/wmi.h              |   78 +-
 drivers/net/wireless/ath/ath12k/Kconfig            |    9 +
 drivers/net/wireless/ath/ath12k/Makefile           |    2 +
 drivers/net/wireless/ath/ath12k/acpi.c             |  394 +++
 drivers/net/wireless/ath/ath12k/acpi.h             |   76 +
 drivers/net/wireless/ath/ath12k/core.c             |  123 +-
 drivers/net/wireless/ath/ath12k/core.h             |   95 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |   90 +
 drivers/net/wireless/ath/ath12k/debugfs.h          |   30 +
 drivers/net/wireless/ath/ath12k/dp.c               |  121 +-
 drivers/net/wireless/ath/ath12k/dp.h               |   12 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |    6 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  236 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |    5 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |    2 +-
 drivers/net/wireless/ath/ath12k/hal.h              |    2 +-
 drivers/net/wireless/ath/ath12k/hif.h              |   14 +-
 drivers/net/wireless/ath/ath12k/htc.c              |    4 +-
 drivers/net/wireless/ath/ath12k/hw.c               |   12 +-
 drivers/net/wireless/ath/ath12k/hw.h               |    4 +
 drivers/net/wireless/ath/ath12k/mac.c              | 1147 ++++++--
 drivers/net/wireless/ath/ath12k/mac.h              |    4 +
 drivers/net/wireless/ath/ath12k/mhi.c              |   92 +-
 drivers/net/wireless/ath/ath12k/mhi.h              |    5 +-
 drivers/net/wireless/ath/ath12k/p2p.c              |    3 +-
 drivers/net/wireless/ath/ath12k/p2p.h              |    1 +
 drivers/net/wireless/ath/ath12k/pci.c              |   43 +-
 drivers/net/wireless/ath/ath12k/pci.h              |    2 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |  109 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |    4 +
 drivers/net/wireless/ath/ath12k/reg.c              |   55 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  197 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |  101 +-
 drivers/net/wireless/ath/ath6kl/htc_mbox.c         |    3 +-
 drivers/net/wireless/ath/ath6kl/htc_pipe.c         |    3 +-
 drivers/net/wireless/ath/ath6kl/sdio.c             |   20 +-
 drivers/net/wireless/ath/ath9k/ath9k.h             |    1 +
 drivers/net/wireless/ath/ath9k/eeprom_4k.c         |    2 +-
 drivers/net/wireless/ath/ath9k/eeprom_9287.c       |    4 +-
 drivers/net/wireless/ath/ath9k/eeprom_def.c        |    6 +-
 drivers/net/wireless/ath/ath9k/main.c              |    3 +-
 drivers/net/wireless/ath/ath9k/pci.c               |    2 -
 drivers/net/wireless/ath/ath9k/xmit.c              |   10 +-
 drivers/net/wireless/ath/carl9170/tx.c             |    3 +-
 drivers/net/wireless/ath/carl9170/usb.c            |   32 +
 drivers/net/wireless/ath/wcn36xx/main.c            |    4 +-
 drivers/net/wireless/ath/wcn36xx/txrx.c            |    4 +-
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h         |    7 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        |   25 +-
 drivers/net/wireless/ath/wil6210/fw.h              |    1 -
 drivers/net/wireless/ath/wil6210/fw_inc.c          |    4 +-
 drivers/net/wireless/ath/wil6210/wmi.c             |   19 +-
 drivers/net/wireless/ath/wil6210/wmi.h             |    4 +-
 drivers/net/wireless/broadcom/b43/sysfs.c          |   13 +-
 drivers/net/wireless/broadcom/b43legacy/sysfs.c    |   16 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |    6 +-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |   15 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |    7 -
 .../wireless/broadcom/brcm80211/brcmsmac/ampdu.c   |    6 -
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |    4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |   36 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |   16 +
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |   57 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |    7 +
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |   23 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |   61 +-
 .../net/wireless/intel/iwlwifi/fw/api/offload.h    |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/phy.h    |    7 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |   74 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h   |   33 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |   13 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   10 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |    3 +
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |  127 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |   26 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |    7 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |   23 +
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |   24 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |    7 +-
 .../wireless/intel/iwlwifi/iwl-context-info-gen3.h |    5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   16 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   28 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/Makefile    |    3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c      |  112 +-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |   15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  243 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   |   98 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |   17 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |  103 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |  800 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   28 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  350 ++-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |  431 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |   44 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |  242 +-
 .../net/wireless/intel/iwlwifi/mvm/offloading.c    |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   62 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |   16 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c     |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |  152 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   36 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |  614 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   86 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |   24 +
 .../net/wireless/intel/iwlwifi/mvm/tests/Makefile  |    3 +
 .../net/wireless/intel/iwlwifi/mvm/tests/links.c   |  435 +++
 .../net/wireless/intel/iwlwifi/mvm/tests/module.c  |   10 +
 .../net/wireless/intel/iwlwifi/mvm/tests/scan.c    |  110 +
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   19 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |    7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |   29 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |   31 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   54 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |    2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |   11 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   27 +-
 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c |   26 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c        |    3 +-
 drivers/net/wireless/marvell/mwl8k.c               |   94 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |    5 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |    1 +
 drivers/net/wireless/mediatek/mt76/mt76.h          |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c    |   46 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |    1 +
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |   10 +-
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.c  |   85 +
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  |   22 +
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   22 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   15 +
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c    |    9 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c |   29 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h |   47 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   10 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |   15 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   10 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |  160 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |    4 +
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c    |    1 -
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |    2 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   32 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   79 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |    6 +
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |   19 +-
 .../net/wireless/mediatek/mt76/mt7921/pci_mac.c    |    2 -
 .../net/wireless/mediatek/mt76/mt7921/sdio_mac.c   |    2 -
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |   15 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |    7 +
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |    5 +
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |    8 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   34 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |   71 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |    4 +-
 drivers/net/wireless/mediatek/mt76/sdio.c          |   17 +-
 drivers/net/wireless/mediatek/mt76/testmode.c      |    2 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |    2 +-
 drivers/net/wireless/mediatek/mt76/usb.c           |    3 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |   41 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |   17 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   |   43 +-
 drivers/net/wireless/microchip/wilc1000/netdev.h   |    5 +-
 drivers/net/wireless/microchip/wilc1000/sdio.c     |    5 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |    5 +-
 drivers/net/wireless/quantenna/qtnfmac/bus.h       |    2 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c      |   16 +-
 drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c |   12 +-
 .../wireless/quantenna/qtnfmac/pcie/pearl_pcie.c   |    6 +-
 .../wireless/quantenna/qtnfmac/pcie/topaz_pcie.c   |    6 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8188e.c => 8188e.c} |   18 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8188f.c => 8188f.c} |   18 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8192c.c => 8192c.c} |   67 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8192e.c => 8192e.c} |   18 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8192f.c => 8192f.c} |   18 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8710b.c => 8710b.c} |   18 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8723a.c => 8723a.c} |   45 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8723b.c => 8723b.c} |   41 +-
 drivers/net/wireless/realtek/rtl8xxxu/Makefile     |    6 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_core.c => core.c}   |   76 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_regs.h => regs.h}   |    0
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |   13 +-
 drivers/net/wireless/realtek/rtlwifi/Kconfig       |    4 +
 drivers/net/wireless/realtek/rtlwifi/Makefile      |    1 +
 drivers/net/wireless/realtek/rtlwifi/cam.c         |    5 +-
 drivers/net/wireless/realtek/rtlwifi/cam.h         |    6 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.c       |    2 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.h       |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/hw.c    |  193 +-
 .../net/wireless/realtek/rtlwifi/rtl8192d/Makefile |   11 +
 .../realtek/rtlwifi/{rtl8192de => rtl8192d}/def.h  |    0
 .../wireless/realtek/rtlwifi/rtl8192d/dm_common.c  | 1061 +++++++
 .../wireless/realtek/rtlwifi/rtl8192d/dm_common.h  |   79 +
 .../wireless/realtek/rtlwifi/rtl8192d/fw_common.c  |  370 +++
 .../wireless/realtek/rtlwifi/rtl8192d/fw_common.h  |   49 +
 .../wireless/realtek/rtlwifi/rtl8192d/hw_common.c  | 1225 ++++++++
 .../wireless/realtek/rtlwifi/rtl8192d/hw_common.h  |   24 +
 .../net/wireless/realtek/rtlwifi/rtl8192d/main.c   |    9 +
 .../wireless/realtek/rtlwifi/rtl8192d/phy_common.c |  856 ++++++
 .../wireless/realtek/rtlwifi/rtl8192d/phy_common.h |  111 +
 .../realtek/rtlwifi/{rtl8192de => rtl8192d}/reg.h  |  162 +-
 .../wireless/realtek/rtlwifi/rtl8192d/rf_common.c  |  359 +++
 .../wireless/realtek/rtlwifi/rtl8192d/rf_common.h  |   13 +
 .../wireless/realtek/rtlwifi/rtl8192d/trx_common.c |  516 ++++
 .../wireless/realtek/rtlwifi/rtl8192d/trx_common.h |  405 +++
 .../net/wireless/realtek/rtlwifi/rtl8192de/dm.c    | 1072 +------
 .../net/wireless/realtek/rtlwifi/rtl8192de/dm.h    |   91 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/fw.c    |  375 +--
 .../net/wireless/realtek/rtlwifi/rtl8192de/fw.h    |   37 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/hw.c    | 1168 +-------
 .../net/wireless/realtek/rtlwifi/rtl8192de/hw.h    |   11 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/led.c   |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.c   |  916 +-----
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.h   |   59 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/rf.c    |  375 +--
 .../net/wireless/realtek/rtlwifi/rtl8192de/rf.h    |    5 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/sw.c    |   12 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/trx.c   |  515 +---
 .../net/wireless/realtek/rtlwifi/rtl8192de/trx.h   |  433 ---
 .../net/wireless/realtek/rtlwifi/rtl8723be/phy.c   |   45 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c         |    3 +
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   33 +-
 drivers/net/wireless/realtek/rtw88/Kconfig         |   22 +
 drivers/net/wireless/realtek/rtw88/Makefile        |    9 +
 drivers/net/wireless/realtek/rtw88/coex.c          |    4 +-
 drivers/net/wireless/realtek/rtw88/debug.h         |    1 +
 drivers/net/wireless/realtek/rtw88/fw.c            |   14 +-
 drivers/net/wireless/realtek/rtw88/fw.h            |    2 +
 drivers/net/wireless/realtek/rtw88/mac.c           |   11 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    2 +
 drivers/net/wireless/realtek/rtw88/main.c          |   18 +-
 drivers/net/wireless/realtek/rtw88/main.h          |    3 +
 drivers/net/wireless/realtek/rtw88/pci.c           |    3 +-
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      | 2109 ++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8703b.h      |  102 +
 .../net/wireless/realtek/rtw88/rtw8703b_tables.c   |  902 ++++++
 .../net/wireless/realtek/rtw88/rtw8703b_tables.h   |   14 +
 drivers/net/wireless/realtek/rtw88/rtw8723cs.c     |   34 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |  673 +----
 drivers/net/wireless/realtek/rtw88/rtw8723d.h      |  269 +-
 drivers/net/wireless/realtek/rtw88/rtw8723x.c      |  721 +++++
 drivers/net/wireless/realtek/rtw88/rtw8723x.h      |  518 ++++
 drivers/net/wireless/realtek/rtw88/rx.h            |    2 +
 drivers/net/wireless/realtek/rtw89/Kconfig         |   15 +
 drivers/net/wireless/realtek/rtw89/Makefile        |   12 +-
 drivers/net/wireless/realtek/rtw89/acpi.c          |   47 +
 drivers/net/wireless/realtek/rtw89/acpi.h          |   21 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |  116 +-
 drivers/net/wireless/realtek/rtw89/cam.h           |   71 +-
 drivers/net/wireless/realtek/rtw89/coex.c          | 1964 +++++++++++--
 drivers/net/wireless/realtek/rtw89/coex.h          |  108 +
 drivers/net/wireless/realtek/rtw89/core.c          |   35 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  361 ++-
 drivers/net/wireless/realtek/rtw89/fw.c            |  436 ++-
 drivers/net/wireless/realtek/rtw89/fw.h            |  497 +---
 drivers/net/wireless/realtek/rtw89/mac.c           |   50 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |    7 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   28 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    5 +
 drivers/net/wireless/realtek/rtw89/pci.c           |   94 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |   13 +
 drivers/net/wireless/realtek/rtw89/phy.c           |   19 +-
 drivers/net/wireless/realtek/rtw89/phy_be.c        |   18 +
 drivers/net/wireless/realtek/rtw89/ps.c            |    3 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |    7 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |  174 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   15 +
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   13 +-
 .../net/wireless/realtek/rtw89/rtw8852c_table.c    | 2706 +-----------------
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |   23 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |  157 +-
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |    1 +
 drivers/net/wireless/realtek/rtw89/sar.h           |    4 +-
 drivers/net/wireless/realtek/rtw89/wow.c           |  716 ++++-
 drivers/net/wireless/realtek/rtw89/wow.h           |   57 +
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |   31 +-
 drivers/net/wireless/ti/wl1251/cmd.h               |    2 -
 drivers/net/wireless/ti/wl1251/sdio.c              |   20 +-
 drivers/net/wireless/ti/wl1251/wl12xx_80211.h      |    1 -
 drivers/net/wireless/ti/wlcore/cmd.h               |    2 -
 drivers/net/wireless/ti/wlcore/sysfs.c             |   11 +-
 drivers/net/wireless/ti/wlcore/wl12xx_80211.h      |    1 -
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   52 +-
 drivers/net/wwan/iosm/iosm_ipc_devlink.c           |    3 +-
 drivers/net/wwan/mhi_wwan_mbim.c                   |    1 -
 drivers/net/wwan/t7xx/t7xx_netdev.c                |   20 +-
 drivers/net/wwan/t7xx/t7xx_netdev.h                |    2 +-
 drivers/net/xen-netback/common.h                   |    5 +-
 drivers/net/xen-netback/interface.c                |    4 +-
 drivers/net/xen-netback/netback.c                  |   12 +-
 drivers/net/xen-netfront.c                         |    2 +-
 drivers/nfc/nfcmrvl/spi.c                          |    1 -
 drivers/nfc/st95hf/core.c                          |   28 +-
 drivers/of/property.c                              |    2 +
 drivers/ptp/ptp_clockmatrix.c                      |    6 +-
 drivers/ptp/ptp_dte.c                              |    6 +-
 drivers/ptp/ptp_idt82p33.c                         |    6 +-
 drivers/ptp/ptp_ines.c                             |    5 +-
 drivers/ptp/ptp_ocp.c                              |    6 +-
 drivers/ptp/ptp_qoriq.c                            |    5 +-
 drivers/s390/cio/idset.c                           |   12 +-
 drivers/s390/net/ctcm_main.c                       |    2 +-
 drivers/s390/net/ism_drv.c                         |    2 +-
 drivers/s390/net/qeth_core.h                       |    9 +-
 drivers/ssb/main.c                                 |    6 +-
 drivers/vhost/net.c                                |    8 +-
 drivers/virtio/Kconfig                             |   10 +
 drivers/virtio/Makefile                            |    1 +
 drivers/virtio/virtio.c                            |    8 +
 drivers/virtio/virtio_debug.c                      |  114 +
 drivers/virtio/virtio_ring.c                       |    7 +-
 fs/btrfs/free-space-cache.c                        |    8 +-
 fs/ntfs3/bitmap.c                                  |    4 +-
 fs/ntfs3/fsntfs.c                                  |    2 +-
 fs/ntfs3/index.c                                   |   11 +-
 fs/ntfs3/ntfs_fs.h                                 |    4 +-
 fs/ntfs3/super.c                                   |    2 +-
 include/linux/bitmap.h                             |   91 +-
 include/linux/bitops.h                             |   23 +-
 include/linux/bpf.h                                |   31 +-
 include/linux/bpf_crypto.h                         |   24 +
 include/linux/bpf_verifier.h                       |   11 +-
 include/linux/btf_ids.h                            |    2 +
 include/linux/compiler_types.h                     |   11 +
 include/linux/cpumask.h                            |    2 +-
 include/linux/dynamic_queue_limits.h               |   50 +-
 include/linux/etherdevice.h                        |   12 +-
 include/linux/ethtool.h                            |   27 +-
 include/linux/filter.h                             |   51 +-
 include/linux/genetlink.h                          |   19 -
 include/linux/genl_magic_struct.h                  |    2 +-
 include/linux/ieee80211.h                          |   30 +-
 include/linux/linkmode.h                           |   27 +-
 include/linux/marvell_phy.h                        |    3 +
 include/linux/mhi.h                                |   18 +-
 include/linux/mlx5/cq.h                            |    7 +-
 include/linux/mlx5/device.h                        |    8 +-
 include/linux/mlx5/driver.h                        |   10 +-
 include/linux/mlx5/mlx5_ifc.h                      |   63 +-
 include/linux/mmc/sdio_ids.h                       |    1 +
 include/linux/net/intel/libie/rx.h                 |   50 +
 include/linux/netdevice.h                          |   55 +-
 include/linux/phy.h                                |    1 +
 include/linux/phylink.h                            |   42 +
 include/linux/pse-pd/pse.h                         |   83 +-
 include/linux/rhashtable.h                         |   10 +-
 include/linux/rtnetlink.h                          |    3 +
 include/linux/sfp.h                                |    4 +-
 include/linux/skbuff.h                             |  136 +-
 include/linux/skbuff_ref.h                         |   75 +
 include/linux/skmsg.h                              |    4 +
 include/linux/slab.h                               |   17 +-
 include/linux/ssb/ssb.h                            |    8 -
 include/linux/stmmac.h                             |   18 +-
 include/linux/sysctl.h                             |    2 +-
 include/linux/tcp.h                                |    6 +-
 include/linux/trace_events.h                       |   36 +-
 include/linux/virtio.h                             |   35 +
 include/net/af_unix.h                              |   33 +-
 include/net/ax25.h                                 |    5 +-
 include/net/bluetooth/bluetooth.h                  |    2 +-
 include/net/bluetooth/hci.h                        |  136 +-
 include/net/bluetooth/hci_core.h                   |   69 +-
 include/net/bluetooth/l2cap.h                      |   33 +-
 include/net/cfg80211.h                             |  140 +-
 include/net/cipso_ipv4.h                           |    6 +-
 include/net/devlink.h                              |   21 +-
 include/net/dsa.h                                  |   38 +-
 include/net/dscp.h                                 |   76 +
 include/net/dst_cache.h                            |    2 +-
 include/net/dst_metadata.h                         |   10 +-
 include/net/espintcp.h                             |    2 +-
 include/net/flow_dissector.h                       |    2 +-
 include/net/flow_offload.h                         |   57 +-
 include/net/genetlink.h                            |   10 +-
 include/net/gre.h                                  |   66 +-
 include/net/gro.h                                  |   82 +-
 include/net/gtp.h                                  |    5 +
 include/net/hotdata.h                              |    3 +
 include/net/ieee8021q.h                            |   57 +
 include/net/inet_connection_sock.h                 |    7 +-
 include/net/inet_timewait_sock.h                   |    2 +-
 include/net/ip.h                                   |    4 +-
 include/net/ip6_fib.h                              |    8 +-
 include/net/ip6_route.h                            |   11 +-
 include/net/ip6_tunnel.h                           |    4 +-
 include/net/ip_tunnels.h                           |  139 +-
 include/net/libeth/rx.h                            |  242 ++
 include/net/mac80211.h                             |   82 +-
 include/net/mana/mana.h                            |    1 +
 include/net/mptcp.h                                |    3 +
 include/net/netdev_queues.h                        |   61 +
 include/net/netfilter/nf_tables.h                  |    4 +-
 include/net/netlabel.h                             |   12 +-
 include/net/netlink.h                              |   41 +-
 include/net/nexthop.h                              |    2 +-
 include/net/page_pool/helpers.h                    |   34 +-
 include/net/page_pool/types.h                      |    4 +-
 include/net/pfcp.h                                 |   90 +
 include/net/pkt_cls.h                              |    9 +
 include/net/proto_memory.h                         |   83 +
 include/net/red.h                                  |   12 +-
 include/net/request_sock.h                         |    4 +-
 include/net/route.h                                |   22 +-
 include/net/rps.h                                  |   28 +
 include/net/rstreason.h                            |  182 ++
 include/net/sch_generic.h                          |    5 +
 include/net/scm.h                                  |   10 +
 include/net/smc.h                                  |   24 +-
 include/net/sock.h                                 |   88 +-
 include/net/tcp.h                                  |   68 +-
 include/net/timewait_sock.h                        |    9 -
 include/net/tls.h                                  |    2 +-
 include/net/udp_tunnel.h                           |    4 +-
 include/net/xfrm.h                                 |    1 +
 include/trace/bpf_probe.h                          |    3 +-
 include/trace/events/bpf_test_run.h                |   17 +
 include/trace/events/icmp.h                        |   67 +
 include/trace/events/mdio.h                        |    2 +-
 include/trace/events/net_probe_common.h            |   71 +
 include/trace/events/sock.h                        |   37 +-
 include/trace/events/tcp.h                         |  134 +-
 include/trace/events/udp.h                         |   29 +-
 include/uapi/linux/bpf.h                           |   44 +-
 include/uapi/linux/devlink.h                       |    1 +
 include/uapi/linux/ethtool.h                       |   55 +
 include/uapi/linux/ethtool_netlink.h               |   32 +-
 include/uapi/linux/gtp.h                           |    3 +
 include/uapi/linux/icmpv6.h                        |    1 +
 include/uapi/linux/if_link.h                       |    3 +
 include/uapi/linux/if_team.h                       |  158 +-
 include/uapi/linux/if_tunnel.h                     |   36 +
 include/uapi/linux/mptcp.h                         |    4 +
 include/uapi/linux/netdev.h                        |   21 +
 include/uapi/linux/nl80211.h                       |  236 +-
 include/uapi/linux/pkt_cls.h                       |   14 +
 include/uapi/linux/snmp.h                          |    2 +
 include/uapi/linux/tcp.h                           |    2 +
 include/uapi/linux/udp.h                           |    2 +-
 include/uapi/linux/virtio_bt.h                     |    1 -
 include/uapi/linux/virtio_net.h                    |  143 +
 include/uapi/linux/xfrm.h                          |    6 +
 io_uring/notif.c                                   |   18 +-
 ipc/ipc_sysctl.c                                   |    2 +-
 ipc/mq_sysctl.c                                    |    2 +-
 kernel/bpf/Makefile                                |    3 +
 kernel/bpf/arena.c                                 |    4 +-
 kernel/bpf/arraymap.c                              |   54 +-
 kernel/bpf/bpf_local_storage.c                     |    2 +-
 kernel/bpf/bpf_struct_ops.c                        |   10 +-
 kernel/bpf/btf.c                                   |   27 +-
 kernel/bpf/cgroup.c                                |    2 -
 kernel/bpf/core.c                                  |   77 +-
 kernel/bpf/cpumask.c                               |    1 +
 kernel/bpf/crypto.c                                |  385 +++
 kernel/bpf/disasm.c                                |   14 +
 kernel/bpf/hashtab.c                               |   64 +-
 kernel/bpf/helpers.c                               |  366 ++-
 kernel/bpf/log.c                                   |    4 +-
 kernel/bpf/lpm_trie.c                              |   31 +-
 kernel/bpf/syscall.c                               |   53 +-
 kernel/bpf/sysfs_btf.c                             |    6 +-
 kernel/bpf/trampoline.c                            |   18 +-
 kernel/bpf/verifier.c                              |  656 +++--
 kernel/trace/bpf_trace.c                           |  162 +-
 kernel/trace/trace_probe.c                         |    2 -
 kernel/ucount.c                                    |    2 +-
 lib/Kconfig                                        |    2 +-
 lib/dim/Makefile                                   |    4 +-
 lib/dim/dim.c                                      |    3 +
 lib/dynamic_queue_limits.c                         |   13 +-
 lib/math/prime_numbers.c                           |    2 -
 lib/test_bitmap.c                                  |  203 +-
 lib/test_bpf.c                                     |    2 +-
 net/8021q/vlan_dev.c                               |    2 +-
 net/8021q/vlan_netlink.c                           |   10 +-
 net/Kconfig                                        |    6 +
 net/appletalk/sysctl_net_atalk.c                   |    1 -
 net/atm/clip.c                                     |    4 +-
 net/atm/common.c                                   |    2 +-
 net/ax25/Kconfig                                   |    2 +-
 net/ax25/ax25_dev.c                                |   51 +-
 net/ax25/sysctl_net_ax25.c                         |    5 +-
 net/batman-adv/main.c                              |    2 +-
 net/batman-adv/main.h                              |    2 +-
 net/batman-adv/netlink.c                           |    1 -
 net/batman-adv/originator.c                        |    2 +
 net/batman-adv/soft-interface.c                    |    2 +-
 net/batman-adv/translation-table.c                 |   47 +-
 net/bluetooth/6lowpan.c                            |    2 +-
 net/bluetooth/hci_conn.c                           |  150 +-
 net/bluetooth/hci_core.c                           |  170 +-
 net/bluetooth/hci_event.c                          |  242 +-
 net/bluetooth/hci_request.h                        |    4 -
 net/bluetooth/hci_sock.c                           |    5 +-
 net/bluetooth/hci_sync.c                           |  207 +-
 net/bluetooth/iso.c                                |  151 +-
 net/bluetooth/l2cap_core.c                         |  140 +-
 net/bluetooth/l2cap_sock.c                         |   91 +-
 net/bluetooth/mgmt.c                               |   84 +-
 net/bluetooth/sco.c                                |    6 +-
 net/bpf/bpf_dummy_struct_ops.c                     |   59 +-
 net/bpf/test_run.c                                 |    8 +
 net/bridge/br_device.c                             |    4 +-
 net/bridge/br_netfilter_hooks.c                    |    6 +-
 net/bridge/br_vlan_tunnel.c                        |    9 +-
 net/caif/cfctrl.c                                  |    8 +-
 net/core/Makefile                                  |    3 +-
 net/core/bpf_sk_storage.c                          |   23 +-
 net/core/datagram.c                                |   19 -
 net/core/dev.c                                     |  472 ++-
 net/core/dev.h                                     |   24 +-
 net/core/dev_addr_lists_test.c                     |   14 +-
 net/core/drop_monitor.c                            |   20 +-
 net/core/dst_cache.c                               |   11 +-
 net/core/fib_rules.c                               |   17 +-
 net/core/filter.c                                  |   48 +-
 net/core/flow_dissector.c                          |   20 +-
 net/core/gro.c                                     |   31 +-
 net/core/hotdata.c                                 |    7 +-
 net/core/ieee8021q_helpers.c                       |  242 ++
 net/core/neighbour.c                               |   79 +-
 net/core/net-procfs.c                              |    3 +-
 net/core/net-sysfs.c                               |   16 +-
 net/core/net_namespace.c                           |    5 +-
 net/core/{gso_test.c => net_test.c}                |  129 +-
 net/core/netdev-genl-gen.c                         |    1 +
 net/core/netdev-genl.c                             |   77 +-
 net/core/netpoll.c                                 |    2 +-
 net/core/page_pool.c                               |   50 +-
 net/core/rtnetlink.c                               |  166 +-
 net/core/scm.c                                     |   12 +
 net/core/skbuff.c                                  |  166 +-
 net/core/sock.c                                    |   15 +-
 net/core/sock_map.c                                |  263 +-
 net/core/sysctl_net_core.c                         |   22 +-
 net/dccp/ccids/ccid2.c                             |    1 +
 net/dccp/ipv4.c                                    |   12 +-
 net/dccp/ipv6.c                                    |   16 +-
 net/dccp/minisocks.c                               |    3 +-
 net/dccp/output.c                                  |    2 +-
 net/dccp/sysctl.c                                  |    2 -
 net/devlink/core.c                                 |    6 +-
 net/devlink/dev.c                                  |   14 +-
 net/devlink/param.c                                |    7 +-
 net/devlink/port.c                                 |   53 +
 net/dsa/devlink.c                                  |    3 +-
 net/dsa/dsa.c                                      |   10 +
 net/dsa/port.c                                     |  175 +-
 net/dsa/user.c                                     |  107 +-
 net/ethtool/pse-pd.c                               |   60 +-
 net/ethtool/tsinfo.c                               |   52 +-
 net/handshake/tlshd.c                              |    1 -
 net/hsr/hsr_device.c                               |   38 +-
 net/hsr/hsr_device.h                               |    4 +-
 net/hsr/hsr_forward.c                              |   85 +-
 net/hsr/hsr_framereg.c                             |   52 +
 net/hsr/hsr_framereg.h                             |    4 +
 net/hsr/hsr_main.c                                 |    2 +-
 net/hsr/hsr_main.h                                 |    7 +
 net/hsr/hsr_netlink.c                              |   30 +-
 net/hsr/hsr_slave.c                                |    1 +
 net/ieee802154/6lowpan/reassembly.c                |    8 +-
 net/ipv4/af_inet.c                                 |   48 +-
 net/ipv4/arp.c                                     |  204 +-
 net/ipv4/bpf_tcp_ca.c                              |    6 +-
 net/ipv4/cipso_ipv4.c                              |    7 +-
 net/ipv4/devinet.c                                 |   27 +-
 net/ipv4/esp4.c                                    |   15 +-
 net/ipv4/fib_semantics.c                           |    2 +-
 net/ipv4/fou_bpf.c                                 |    2 +-
 net/ipv4/gre_demux.c                               |    2 +-
 net/ipv4/icmp.c                                    |   30 +-
 net/ipv4/igmp.c                                    |    3 +-
 net/ipv4/inet_fragment.c                           |    4 +-
 net/ipv4/inet_hashtables.c                         |    3 +-
 net/ipv4/inet_timewait_sock.c                      |   16 +-
 net/ipv4/ip_fragment.c                             |    4 +-
 net/ipv4/ip_gre.c                                  |  146 +-
 net/ipv4/ip_input.c                                |    2 +-
 net/ipv4/ip_output.c                               |    8 +-
 net/ipv4/ip_tunnel.c                               |  119 +-
 net/ipv4/ip_tunnel_core.c                          |   82 +-
 net/ipv4/ip_vti.c                                  |   41 +-
 net/ipv4/ipip.c                                    |   33 +-
 net/ipv4/ipmr.c                                    |    2 +-
 net/ipv4/netfilter/iptable_filter.c                |    2 +-
 net/ipv4/proc.c                                    |    1 +
 net/ipv4/route.c                                   |   48 +-
 net/ipv4/syncookies.c                              |    3 +-
 net/ipv4/sysctl_net_ipv4.c                         |    9 +-
 net/ipv4/tcp.c                                     |   71 +-
 net/ipv4/tcp_bbr.c                                 |    6 +-
 net/ipv4/tcp_cubic.c                               |    4 -
 net/ipv4/tcp_dctcp.c                               |    4 -
 net/ipv4/tcp_input.c                               |   78 +-
 net/ipv4/tcp_ipv4.c                                |   52 +-
 net/ipv4/tcp_metrics.c                             |    7 +-
 net/ipv4/tcp_minisocks.c                           |   14 +-
 net/ipv4/tcp_offload.c                             |  256 +-
 net/ipv4/tcp_output.c                              |  139 +-
 net/ipv4/tcp_timer.c                               |   13 +-
 net/ipv4/udp.c                                     |   59 +-
 net/ipv4/udp_offload.c                             |   36 +-
 net/ipv4/udp_tunnel_core.c                         |    5 +-
 net/ipv4/xfrm4_input.c                             |   13 -
 net/ipv4/xfrm4_policy.c                            |    5 +-
 net/ipv6/addrconf.c                                |   13 +-
 net/ipv6/addrlabel.c                               |   18 +-
 net/ipv6/anycast.c                                 |    5 +-
 net/ipv6/esp6.c                                    |   15 +-
 net/ipv6/icmp.c                                    |    9 +-
 net/ipv6/ila/ila_lwt.c                             |    4 +-
 net/ipv6/inet6_hashtables.c                        |    4 +-
 net/ipv6/ip6_fib.c                                 |   51 +-
 net/ipv6/ip6_gre.c                                 |  110 +-
 net/ipv6/ip6_offload.c                             |   16 +-
 net/ipv6/ip6_output.c                              |   18 +-
 net/ipv6/ip6_tunnel.c                              |   18 +-
 net/ipv6/ip6_vti.c                                 |   14 +-
 net/ipv6/ip6mr.c                                   |    2 +-
 net/ipv6/ndisc.c                                   |    2 +-
 net/ipv6/netfilter/ip6table_filter.c               |    2 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |    3 +-
 net/ipv6/ping.c                                    |    2 +-
 net/ipv6/raw.c                                     |    4 +-
 net/ipv6/reassembly.c                              |    6 +-
 net/ipv6/route.c                                   |   33 +-
 net/ipv6/seg6.c                                    |    5 +-
 net/ipv6/sit.c                                     |   38 +-
 net/ipv6/syncookies.c                              |    2 +-
 net/ipv6/sysctl_net_ipv6.c                         |   14 +-
 net/ipv6/tcp_ipv6.c                                |   49 +-
 net/ipv6/tcpv6_offload.c                           |  123 +-
 net/ipv6/udp.c                                     |   34 +-
 net/ipv6/xfrm6_input.c                             |   20 +-
 net/ipv6/xfrm6_policy.c                            |    5 +-
 net/iucv/af_iucv.c                                 |    2 +-
 net/iucv/iucv.c                                    |   26 +-
 net/l2tp/l2tp_core.c                               |   37 +-
 net/l2tp/l2tp_ip.c                                 |    2 +-
 net/l2tp/l2tp_ip6.c                                |    2 +-
 net/llc/sysctl_net_llc.c                           |    8 +-
 net/mac80211/cfg.c                                 |  166 +-
 net/mac80211/chan.c                                |  113 +-
 net/mac80211/debugfs.c                             |    1 +
 net/mac80211/drop.h                                |    3 +-
 net/mac80211/ht.c                                  |    2 +-
 net/mac80211/ieee80211_i.h                         |   25 +-
 net/mac80211/iface.c                               |    9 +-
 net/mac80211/link.c                                |   28 +-
 net/mac80211/mlme.c                                |  135 +-
 net/mac80211/offchannel.c                          |   12 +-
 net/mac80211/rx.c                                  |   11 +-
 net/mac80211/scan.c                                |   16 +-
 net/mac80211/spectmgmt.c                           |   18 +-
 net/mac80211/sta_info.h                            |    4 +-
 net/mac80211/status.c                              |   22 +-
 net/mac80211/tx.c                                  |    6 +-
 net/mac80211/util.c                                |   21 +-
 net/mac80211/wpa.c                                 |   12 +-
 net/mpls/af_mpls.c                                 |   78 +-
 net/mpls/mpls_iptunnel.c                           |    4 +-
 net/mptcp/ctrl.c                                   |   32 +-
 net/mptcp/mib.h                                    |    2 +
 net/mptcp/options.c                                |    1 +
 net/mptcp/pm_netlink.c                             |    1 +
 net/mptcp/pm_userspace.c                           |    1 +
 net/mptcp/protocol.c                               |   19 +-
 net/mptcp/protocol.h                               |   49 +-
 net/mptcp/sched.c                                  |   22 +
 net/mptcp/sockopt.c                                |   86 +-
 net/mptcp/subflow.c                                |   91 +-
 net/netfilter/ipvs/ip_vs_core.c                    |    6 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |   36 +-
 net/netfilter/ipvs/ip_vs_lblc.c                    |    5 +-
 net/netfilter/ipvs/ip_vs_lblcr.c                   |    5 +-
 net/netfilter/ipvs/ip_vs_xmit.c                    |   36 +-
 net/netfilter/nf_conntrack_core.c                  |    4 +-
 net/netfilter/nf_conntrack_proto_dccp.c            |    4 +-
 net/netfilter/nf_conntrack_proto_icmpv6.c          |    4 +-
 net/netfilter/nf_conntrack_standalone.c            |    8 +-
 net/netfilter/nf_flow_table_core.c                 |    8 +-
 net/netfilter/nf_flow_table_ip.c                   |    8 +-
 net/netfilter/nf_log.c                             |    5 +-
 net/netfilter/nf_tables_api.c                      |   16 +-
 net/netfilter/nfnetlink.c                          |    5 +
 net/netfilter/nft_chain_filter.c                   |    6 +-
 net/netfilter/nft_connlimit.c                      |    4 +-
 net/netfilter/nft_counter.c                        |    4 +-
 net/netfilter/nft_dynset.c                         |    2 +-
 net/netfilter/nft_last.c                           |    4 +-
 net/netfilter/nft_limit.c                          |   14 +-
 net/netfilter/nft_quota.c                          |    4 +-
 net/netfilter/nft_rt.c                             |    4 +-
 net/netfilter/nft_set_pipapo.c                     |  262 +-
 net/netfilter/nft_set_pipapo.h                     |    2 -
 net/netfilter/nft_tunnel.c                         |   44 +-
 net/netlabel/netlabel_kapi.c                       |   31 +-
 net/netlink/af_netlink.c                           |  137 +-
 net/netlink/genetlink.c                            |    2 +
 net/netlink/genetlink.h                            |   11 +
 net/netrom/sysctl_net_netrom.c                     |    1 -
 net/nfc/netlink.c                                  |    6 +-
 net/openvswitch/datapath.c                         |    1 -
 net/openvswitch/flow.c                             |    3 +-
 net/openvswitch/flow_netlink.c                     |   61 +-
 net/openvswitch/meter.h                            |    1 -
 net/openvswitch/vport-netdev.c                     |    7 +
 net/packet/af_packet.c                             |   26 +-
 net/phonet/pn_netlink.c                            |   17 +-
 net/phonet/sysctl.c                                |    1 -
 net/psample/psample.c                              |   26 +-
 net/qrtr/mhi.c                                     |   46 +
 net/rds/ib_sysctl.c                                |    1 -
 net/rds/sysctl.c                                   |    1 -
 net/rds/tcp.c                                      |    1 -
 net/rfkill/rfkill-gpio.c                           |    6 +-
 net/rose/sysctl_net_rose.c                         |    1 -
 net/rxrpc/af_rxrpc.c                               |    2 +-
 net/rxrpc/sysctl.c                                 |    1 -
 net/sched/act_tunnel_key.c                         |   36 +-
 net/sched/cls_api.c                                |   41 +
 net/sched/cls_flower.c                             |  134 +-
 net/sched/sch_api.c                                |    3 +-
 net/sched/sch_cake.c                               |  112 +-
 net/sched/sch_cbs.c                                |   20 +-
 net/sched/sch_choke.c                              |   21 +-
 net/sched/sch_codel.c                              |   29 +-
 net/sched/sch_etf.c                                |   10 +-
 net/sched/sch_ets.c                                |   25 +-
 net/sched/sch_fifo.c                               |   13 +-
 net/sched/sch_fq.c                                 |  108 +-
 net/sched/sch_fq_codel.c                           |   57 +-
 net/sched/sch_fq_pie.c                             |   61 +-
 net/sched/sch_generic.c                            |   15 +-
 net/sched/sch_hfsc.c                               |    9 +-
 net/sched/sch_hhf.c                                |   35 +-
 net/sched/sch_htb.c                                |   22 +-
 net/sched/sch_mqprio.c                             |    6 +-
 net/sched/sch_pie.c                                |   39 +-
 net/sched/sch_sfq.c                                |   13 +-
 net/sched/sch_skbprio.c                            |    8 +-
 net/sched/sch_taprio.c                             |    5 +-
 net/sched/sch_teql.c                               |    4 +-
 net/sctp/ipv6.c                                    |    2 +-
 net/sctp/protocol.c                                |    4 +-
 net/sctp/sm_statefuns.c                            |    1 +
 net/sctp/socket.c                                  |    9 +-
 net/sctp/sysctl.c                                  |   12 +-
 net/smc/Kconfig                                    |   13 +
 net/smc/Makefile                                   |    1 +
 net/smc/af_smc.c                                   |   34 +-
 net/smc/smc_cdc.c                                  |   36 +-
 net/smc/smc_clc.c                                  |    6 +-
 net/smc/smc_clc.h                                  |   26 +-
 net/smc/smc_core.c                                 |   61 +-
 net/smc/smc_core.h                                 |    1 +
 net/smc/smc_ism.c                                  |   88 +-
 net/smc/smc_ism.h                                  |   10 +
 net/smc/smc_loopback.c                             |  427 +++
 net/smc/smc_loopback.h                             |   61 +
 net/smc/smc_rx.c                                   |    4 +-
 net/smc/smc_sysctl.c                               |    8 +-
 net/sunrpc/sysctl.c                                |    1 -
 net/sunrpc/xprtrdma/svc_rdma.c                     |    1 -
 net/sunrpc/xprtrdma/transport.c                    |    1 -
 net/sunrpc/xprtsock.c                              |    1 -
 net/switchdev/switchdev.c                          |   99 +-
 net/tipc/socket.c                                  |    5 +-
 net/tipc/sysctl.c                                  |    1 -
 net/tipc/udp_media.c                               |    2 +-
 net/tls/Kconfig                                    |    1 +
 net/tls/tls_device.c                               |    1 +
 net/tls/tls_device_fallback.c                      |    1 +
 net/tls/tls_strp.c                                 |    1 +
 net/tls/tls_sw.c                                   |    1 -
 net/unix/af_unix.c                                 |   82 +-
 net/unix/garbage.c                                 |  718 +++--
 net/unix/sysctl_net_unix.c                         |    3 +-
 net/wireless/nl80211.c                             |   27 +-
 net/wireless/reg.c                                 |   18 +-
 net/wireless/reg.h                                 |   13 +-
 net/wireless/scan.c                                |   54 +-
 net/wireless/sme.c                                 |    1 +
 net/wireless/trace.h                               |    6 +-
 net/x25/sysctl_net_x25.c                           |    1 -
 net/xfrm/xfrm_compat.c                             |    7 +-
 net/xfrm/xfrm_device.c                             |    6 +
 net/xfrm/xfrm_input.c                              |   11 +
 net/xfrm/xfrm_interface_core.c                     |    2 +-
 net/xfrm/xfrm_policy.c                             |    9 +-
 net/xfrm/xfrm_proc.c                               |    2 +
 net/xfrm/xfrm_replay.c                             |    3 +-
 net/xfrm/xfrm_state.c                              |    8 +
 net/xfrm/xfrm_sysctl.c                             |    7 +-
 net/xfrm/xfrm_user.c                               |  162 +-
 samples/bpf/Makefile                               |    2 +-
 scripts/Makefile.btf                               |   15 +-
 scripts/kernel-doc                                 |    1 +
 security/selinux/netlabel.c                        |    5 +-
 security/smack/smack_lsm.c                         |    3 +-
 tools/bpf/bpftool/Documentation/Makefile           |    6 +-
 tools/bpf/bpftool/Documentation/bpftool-btf.rst    |  100 +-
 tools/bpf/bpftool/Documentation/bpftool-cgroup.rst |  193 +-
 .../bpf/bpftool/Documentation/bpftool-feature.rst  |   99 +-
 tools/bpf/bpftool/Documentation/bpftool-gen.rst    |  284 +-
 tools/bpf/bpftool/Documentation/bpftool-iter.rst   |   52 +-
 tools/bpf/bpftool/Documentation/bpftool-link.rst   |   73 +-
 tools/bpf/bpftool/Documentation/bpftool-map.rst    |  232 +-
 tools/bpf/bpftool/Documentation/bpftool-net.rst    |   98 +-
 tools/bpf/bpftool/Documentation/bpftool-perf.rst   |   34 +-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst   |  374 ++-
 .../bpftool/Documentation/bpftool-struct_ops.rst   |   71 +-
 tools/bpf/bpftool/Documentation/bpftool.rst        |   60 +-
 tools/bpf/bpftool/Documentation/common_options.rst |   26 +-
 tools/bpf/bpftool/Makefile                         |   16 +-
 tools/bpf/bpftool/bash-completion/bpftool          |   61 +-
 tools/bpf/bpftool/common.c                         |   96 +-
 tools/bpf/bpftool/feature.c                        |    3 +-
 tools/bpf/bpftool/gen.c                            |    5 +-
 tools/bpf/bpftool/iter.c                           |    2 +-
 tools/bpf/bpftool/link.c                           |    9 +
 tools/bpf/bpftool/main.h                           |    3 +-
 tools/bpf/bpftool/pids.c                           |   19 +-
 tools/bpf/bpftool/prog.c                           |    7 +-
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c          |    4 +-
 tools/bpf/bpftool/struct_ops.c                     |    2 +-
 tools/include/linux/align.h                        |   12 +
 tools/include/linux/bitmap.h                       |    9 +-
 tools/include/linux/bitops.h                       |    2 +
 tools/include/linux/compiler.h                     |    4 +
 tools/include/linux/filter.h                       |   18 +
 tools/include/linux/mm.h                           |    5 +-
 tools/include/uapi/linux/bpf.h                     |   44 +-
 tools/include/uapi/linux/ethtool.h                 |  104 -
 tools/include/uapi/linux/netdev.h                  |   21 +
 tools/lib/bpf/bpf.c                                |   17 +-
 tools/lib/bpf/bpf.h                                |    9 +
 tools/lib/bpf/bpf_core_read.h                      |    3 +-
 tools/lib/bpf/bpf_helpers.h                        |   21 +-
 tools/lib/bpf/bpf_tracing.h                        |   70 +-
 tools/lib/bpf/btf_dump.c                           |    5 +
 tools/lib/bpf/libbpf.c                             |  261 +-
 tools/lib/bpf/libbpf.h                             |   29 +-
 tools/lib/bpf/libbpf.map                           |    9 +
 tools/lib/bpf/libbpf_internal.h                    |    5 -
 tools/lib/bpf/libbpf_probes.c                      |    6 +-
 tools/lib/bpf/libbpf_version.h                     |    2 +-
 tools/lib/bpf/ringbuf.c                            |   53 +-
 tools/lib/bpf/str_error.c                          |   16 +-
 tools/lib/bpf/usdt.bpf.h                           |   24 +-
 tools/net/ynl/cli.py                               |   34 +-
 tools/net/ynl/ethtool.py                           |   19 +-
 tools/net/ynl/lib/nlspec.py                        |    2 +
 tools/net/ynl/lib/ynl.h                            |   12 +
 tools/net/ynl/lib/ynl.py                           |  162 +-
 tools/net/ynl/samples/netdev.c                     |    2 +
 tools/net/ynl/ynl-gen-c.py                         |   22 +-
 tools/net/ynl/ynl-gen-rst.py                       |   62 +-
 tools/perf/util/probe-finder.c                     |    4 +-
 tools/testing/selftests/Makefile                   |   13 +-
 tools/testing/selftests/bpf/.gitignore             |    1 -
 tools/testing/selftests/bpf/DENYLIST.aarch64       |    2 -
 tools/testing/selftests/bpf/DENYLIST.s390x         |    1 +
 tools/testing/selftests/bpf/Makefile               |   65 +-
 tools/testing/selftests/bpf/bench.c                |   39 +-
 .../selftests/bpf/benchs/bench_bpf_crypto.c        |  185 ++
 .../bpf/benchs/bench_local_storage_create.c        |    2 +-
 tools/testing/selftests/bpf/benchs/bench_trigger.c |  431 +--
 .../selftests/bpf/benchs/run_bench_trigger.sh      |   22 +-
 .../selftests/bpf/benchs/run_bench_uprobes.sh      |    2 +-
 tools/testing/selftests/bpf/bpf_arena_list.h       |    4 +-
 tools/testing/selftests/bpf/bpf_experimental.h     |   71 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h           |    3 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h      |  241 --
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |  260 ++
 .../selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h  |   28 +
 tools/testing/selftests/bpf/cgroup_helpers.c       |    5 +-
 tools/testing/selftests/bpf/config                 |    7 +
 tools/testing/selftests/bpf/network_helpers.c      |  243 +-
 tools/testing/selftests/bpf/network_helpers.h      |   17 +-
 .../selftests/bpf/prog_tests/arena_atomics.c       |  186 ++
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |  114 +-
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  |  133 +-
 .../selftests/bpf/prog_tests/btf_map_in_map.c      |   26 +-
 .../selftests/bpf/prog_tests/cgroup1_hierarchy.c   |    7 +-
 .../selftests/bpf/prog_tests/cls_redirect.c        |   38 +-
 .../selftests/bpf/prog_tests/crypto_sanity.c       |  197 ++
 .../selftests/bpf/prog_tests/dummy_st_ops.c        |   34 +-
 tools/testing/selftests/bpf/prog_tests/empty_skb.c |    2 +
 .../testing/selftests/bpf/prog_tests/fib_lookup.c  |  132 +-
 .../selftests/bpf/prog_tests/flow_dissector.c      |    1 -
 tools/testing/selftests/bpf/prog_tests/for_each.c  |   62 +
 .../selftests/bpf/prog_tests/ip_check_defrag.c     |    2 +
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   |  334 ++-
 tools/testing/selftests/bpf/prog_tests/ksyms.c     |   30 +-
 .../selftests/bpf/prog_tests/module_attach.c       |    6 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c     |   18 +
 .../selftests/bpf/prog_tests/ns_current_pid_tgid.c |  216 +-
 .../selftests/bpf/prog_tests/preempt_lock.c        |    9 +
 tools/testing/selftests/bpf/prog_tests/ringbuf.c   |   65 +
 .../testing/selftests/bpf/prog_tests/send_signal.c |    2 +-
 tools/testing/selftests/bpf/prog_tests/sk_assign.c |   55 +-
 tools/testing/selftests/bpf/prog_tests/sock_addr.c | 2401 ++++++++++++++--
 .../selftests/bpf/prog_tests/sockmap_basic.c       |  171 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c      |   38 +
 tools/testing/selftests/bpf/prog_tests/sockopt.c   |   65 +-
 .../selftests/bpf/prog_tests/sockopt_inherit.c     |   64 +-
 .../bpf/prog_tests/stacktrace_build_id_nmi.c       |    2 +-
 .../testing/selftests/bpf/prog_tests/tc_redirect.c |    2 +-
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c   |   14 +
 .../bpf/prog_tests/test_struct_ops_module.c        |  163 +-
 .../testing/selftests/bpf/prog_tests/test_tunnel.c |    4 +
 .../selftests/bpf/prog_tests/trace_printk.c        |   36 +-
 .../selftests/bpf/prog_tests/trace_vprintk.c       |   36 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |    2 +
 .../bpf/prog_tests/verifier_kfunc_prog_types.c     |   11 +
 tools/testing/selftests/bpf/prog_tests/wq.c        |   40 +
 .../selftests/bpf/prog_tests/xdp_do_redirect.c     |    4 +-
 .../selftests/bpf/prog_tests/xdp_metadata.c        |   16 +
 tools/testing/selftests/bpf/progs/arena_atomics.c  |  178 ++
 tools/testing/selftests/bpf/progs/arena_list.c     |    2 +-
 .../bpf/progs/bench_local_storage_create.c         |    5 +-
 tools/testing/selftests/bpf/progs/bind4_prog.c     |   24 +-
 tools/testing/selftests/bpf/progs/bind6_prog.c     |   24 +-
 tools/testing/selftests/bpf/progs/bind_prog.h      |   19 +
 tools/testing/selftests/bpf/progs/bpf_cc_cubic.c   |  189 ++
 tools/testing/selftests/bpf/progs/bpf_cubic.c      |   74 +-
 tools/testing/selftests/bpf/progs/bpf_dctcp.c      |   62 +-
 .../selftests/bpf/progs/bpf_dctcp_release.c        |   10 +-
 tools/testing/selftests/bpf/progs/bpf_tcp_nogpl.c  |    8 +-
 .../testing/selftests/bpf/progs/bpf_tracing_net.h  |   52 +
 .../selftests/bpf/progs/cgrp_kfunc_common.h        |    2 +-
 tools/testing/selftests/bpf/progs/connect4_prog.c  |   12 +-
 tools/testing/selftests/bpf/progs/connect6_prog.c  |    6 +
 .../selftests/bpf/progs/connect_unix_prog.c        |    6 +
 tools/testing/selftests/bpf/progs/cpumask_common.h |    2 +-
 .../testing/selftests/bpf/progs/cpumask_failure.c  |    3 -
 tools/testing/selftests/bpf/progs/crypto_basic.c   |   68 +
 tools/testing/selftests/bpf/progs/crypto_bench.c   |  109 +
 tools/testing/selftests/bpf/progs/crypto_common.h  |   66 +
 tools/testing/selftests/bpf/progs/crypto_sanity.c  |  169 ++
 .../selftests/bpf/progs/dummy_st_ops_success.c     |   15 +-
 tools/testing/selftests/bpf/progs/dynptr_fail.c    |   12 +-
 tools/testing/selftests/bpf/progs/fib_lookup.c     |    2 +-
 .../selftests/bpf/progs/for_each_multi_maps.c      |   49 +
 .../selftests/bpf/progs/getpeername4_prog.c        |   24 +
 .../selftests/bpf/progs/getpeername6_prog.c        |   31 +
 .../selftests/bpf/progs/getsockname4_prog.c        |   24 +
 .../selftests/bpf/progs/getsockname6_prog.c        |   31 +
 tools/testing/selftests/bpf/progs/iters.c          |    2 +-
 .../selftests/bpf/progs/jeq_infer_not_null_fail.c  |    4 +
 .../selftests/bpf/progs/kprobe_multi_session.c     |   79 +
 .../bpf/progs/kprobe_multi_session_cookie.c        |   58 +
 tools/testing/selftests/bpf/progs/local_storage.c  |   20 +-
 tools/testing/selftests/bpf/progs/lsm_cgroup.c     |    8 +-
 tools/testing/selftests/bpf/progs/mptcp_sock.c     |    4 +-
 tools/testing/selftests/bpf/progs/mptcpify.c       |    4 +
 tools/testing/selftests/bpf/progs/preempt_lock.c   |  132 +
 tools/testing/selftests/bpf/progs/sendmsg4_prog.c  |    6 +
 tools/testing/selftests/bpf/progs/sendmsg6_prog.c  |   57 +
 .../selftests/bpf/progs/sendmsg_unix_prog.c        |    6 +
 tools/testing/selftests/bpf/progs/skb_pkt_end.c    |    2 +
 tools/testing/selftests/bpf/progs/sock_addr_kern.c |   65 +
 .../selftests/bpf/progs/sockopt_qos_to_cc.c        |   16 +-
 .../selftests/bpf/progs/struct_ops_forgotten_cb.c  |   19 +
 .../selftests/bpf/progs/struct_ops_module.c        |   36 +-
 .../selftests/bpf/progs/struct_ops_nulled_out_cb.c |   22 +
 .../selftests/bpf/progs/task_kfunc_common.h        |    2 +-
 .../selftests/bpf/progs/tcp_ca_incompl_cong_ops.c  |   12 +-
 tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c   |  121 +
 .../selftests/bpf/progs/tcp_ca_unsupp_cong_op.c    |    2 +-
 tools/testing/selftests/bpf/progs/tcp_ca_update.c  |   18 +-
 .../selftests/bpf/progs/tcp_ca_write_sk_pacing.c   |   20 +-
 tools/testing/selftests/bpf/progs/tcp_rtt.c        |    6 +
 .../testing/selftests/bpf/progs/test_bpf_cookie.c  |   16 +
 .../selftests/bpf/progs/test_btf_skc_cls_ingress.c |   16 +-
 .../selftests/bpf/progs/test_global_func10.c       |    4 +
 .../selftests/bpf/progs/test_lwt_redirect.c        |    2 +-
 .../selftests/bpf/progs/test_module_attach.c       |   23 +
 .../selftests/bpf/progs/test_ns_current_pid_tgid.c |   31 +-
 tools/testing/selftests/bpf/progs/test_ringbuf_n.c |   47 +
 .../selftests/bpf/progs/test_skmsg_load_helpers.c  |   27 +-
 .../testing/selftests/bpf/progs/test_sock_fields.c |    5 +-
 .../selftests/bpf/progs/test_sockmap_pass_prog.c   |   17 +-
 .../bpf/progs/test_sockmap_skb_verdict_attach.c    |    2 +-
 .../testing/selftests/bpf/progs/test_tcpbpf_kern.c |   13 +-
 .../testing/selftests/bpf/progs/test_tunnel_kern.c |   47 +-
 .../selftests/bpf/progs/test_xdp_noinline.c        |   27 +-
 tools/testing/selftests/bpf/progs/test_xdp_vlan.c  |    2 +-
 tools/testing/selftests/bpf/progs/timer.c          |    3 +-
 tools/testing/selftests/bpf/progs/timer_failure.c  |    2 +-
 tools/testing/selftests/bpf/progs/timer_mim.c      |    2 +-
 .../testing/selftests/bpf/progs/timer_mim_reject.c |    2 +-
 tools/testing/selftests/bpf/progs/trigger_bench.c  |  109 +-
 .../testing/selftests/bpf/progs/verifier_bounds.c  |   63 +
 .../selftests/bpf/progs/verifier_global_subprogs.c |    7 +
 .../bpf/progs/verifier_helper_restricted.c         |    8 +-
 .../bpf/progs/verifier_iterating_callbacks.c       |    9 +-
 .../bpf/progs/verifier_kfunc_prog_types.c          |  122 +
 .../selftests/bpf/progs/verifier_sock_addr.c       |  331 +++
 .../bpf/progs/verifier_subprog_precision.c         |   89 +
 tools/testing/selftests/bpf/progs/wq.c             |  180 ++
 tools/testing/selftests/bpf/progs/wq_failures.c    |  144 +
 tools/testing/selftests/bpf/test_cpp.cpp           |    5 +
 tools/testing/selftests/bpf/test_sock_addr.c       | 1434 ----------
 tools/testing/selftests/bpf/test_sock_addr.sh      |   58 -
 tools/testing/selftests/bpf/test_sockmap.c         |   12 +-
 tools/testing/selftests/bpf/test_tc_tunnel.sh      |   13 +-
 .../selftests/bpf/test_tcp_check_syncookie_user.c  |  117 +-
 tools/testing/selftests/bpf/testing_helpers.c      |   16 +-
 tools/testing/selftests/bpf/trace_helpers.c        |  109 +-
 tools/testing/selftests/bpf/trace_helpers.h        |    9 +
 tools/testing/selftests/bpf/uprobe_multi.c         |    2 +-
 tools/testing/selftests/bpf/veristat.c             |    5 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |   16 +-
 tools/testing/selftests/bpf/xskxceiver.c           |  123 +-
 tools/testing/selftests/bpf/xskxceiver.h           |   12 +-
 tools/testing/selftests/drivers/net/Makefile       |   11 +
 tools/testing/selftests/drivers/net/README.rst     |  136 +
 tools/testing/selftests/drivers/net/config         |    2 +
 tools/testing/selftests/drivers/net/hw/Makefile    |   28 +
 tools/testing/selftests/drivers/net/hw/csum.py     |  122 +
 .../{net => drivers/net/hw}/devlink_port_split.py  |    0
 .../{net/forwarding => drivers/net/hw}/ethtool.sh  |   20 +-
 .../net/hw}/ethtool_extended_state.sh              |    5 +-
 .../forwarding => drivers/net/hw}/ethtool_lib.sh   |    0
 .../forwarding => drivers/net/hw}/ethtool_mm.sh    |    3 +-
 .../forwarding => drivers/net/hw}/ethtool_rmon.sh  |    8 +-
 .../forwarding => drivers/net/hw}/hw_stats_l3.sh   |   20 +-
 .../net/hw}/hw_stats_l3_gre.sh                     |    8 +-
 .../selftests/drivers/net/hw/lib/py/__init__.py    |   16 +
 .../{net/forwarding => drivers/net/hw}/loopback.sh |    5 +-
 .../selftests/drivers/net/hw/pp_alloc_fail.py      |  129 +
 tools/testing/selftests/drivers/net/hw/settings    |    1 +
 .../selftests/drivers/net/lib/py/__init__.py       |   19 +
 tools/testing/selftests/drivers/net/lib/py/env.py  |  224 ++
 tools/testing/selftests/drivers/net/lib/py/load.py |   41 +
 .../testing/selftests/drivers/net/lib/py/remote.py |   15 +
 .../selftests/drivers/net/lib/py/remote_netns.py   |   21 +
 .../selftests/drivers/net/lib/py/remote_ssh.py     |   39 +
 .../selftests/drivers/net/microchip/ksz9477_qos.sh |  668 +++++
 .../selftests/drivers/net/mlxsw/ethtool_lanes.sh   |   14 +-
 .../selftests/drivers/net/mlxsw/mlxsw_lib.sh       |    2 +-
 .../drivers/net/mlxsw/spectrum-2/resource_scale.sh |    1 -
 .../drivers/net/mlxsw/spectrum/resource_scale.sh   |    1 -
 tools/testing/selftests/drivers/net/ping.py        |   51 +
 tools/testing/selftests/drivers/net/queues.py      |   66 +
 tools/testing/selftests/drivers/net/stats.py       |  144 +
 .../selftests/drivers/net/virtio_net/Makefile      |   15 +
 .../drivers/net/virtio_net/basic_features.sh       |  131 +
 .../selftests/drivers/net/virtio_net/config        |    2 +
 .../drivers/net/virtio_net/virtio_net_common.sh    |   99 +
 tools/testing/selftests/lib.mk                     |   17 +-
 tools/testing/selftests/net/.gitignore             |    3 +-
 tools/testing/selftests/net/Makefile               |   58 +-
 tools/testing/selftests/net/af_unix/Makefile       |    2 +-
 tools/testing/selftests/net/af_unix/scm_rights.c   |  286 ++
 tools/testing/selftests/net/amt.sh                 |   12 +-
 tools/testing/selftests/net/bpf.mk                 |   53 +
 .../{bpf/test_offload.py => net/bpf_offload.py}    |  138 +-
 tools/testing/selftests/net/cmsg_sender.c          |   52 +-
 tools/testing/selftests/net/cmsg_time.sh           |    7 +-
 tools/testing/selftests/net/config                 |    1 +
 tools/testing/selftests/net/epoll_busy_poll.c      |  320 +++
 tools/testing/selftests/net/fib_rule_tests.sh      |   46 +-
 tools/testing/selftests/net/forwarding/Makefile    |    9 +-
 tools/testing/selftests/net/forwarding/README      |   33 +
 .../net/forwarding/forwarding.config.sample        |   53 +-
 tools/testing/selftests/net/forwarding/ipip_lib.sh |    1 -
 tools/testing/selftests/net/forwarding/lib.sh      |  385 ++-
 .../selftests/net/forwarding/lib_sh_test.sh        |  208 ++
 .../selftests/net/forwarding/router_mpath_nh.sh    |   35 +
 .../net/forwarding/router_mpath_nh_lib.sh          |   12 +-
 .../net/forwarding/router_mpath_nh_res.sh          |   35 +
 .../testing/selftests/net/forwarding/router_nh.sh  |   14 +
 .../selftests/net/forwarding/sch_ets_tests.sh      |   19 +-
 tools/testing/selftests/net/forwarding/sch_red.sh  |   10 +-
 .../selftests/net/forwarding/sch_tbf_core.sh       |    2 +-
 .../testing/selftests/net/forwarding/tc_common.sh  |    2 +-
 .../selftests/net/forwarding/tc_tunnel_key.sh      |    2 -
 tools/testing/selftests/net/gro.c                  |  141 +
 tools/testing/selftests/net/hsr/Makefile           |    3 +-
 tools/testing/selftests/net/hsr/hsr_common.sh      |   84 +
 tools/testing/selftests/net/hsr/hsr_ping.sh        |  106 +-
 tools/testing/selftests/net/hsr/hsr_redbox.sh      |  121 +
 tools/testing/selftests/net/ip_local_port_range.c  |    2 +-
 tools/testing/selftests/net/lib.sh                 |   64 +-
 tools/testing/selftests/net/lib/.gitignore         |    2 +
 tools/testing/selftests/net/lib/Makefile           |   15 +
 tools/testing/selftests/net/{ => lib}/csum.c       |   18 +-
 tools/testing/selftests/net/lib/py/__init__.py     |    8 +
 tools/testing/selftests/net/lib/py/consts.py       |    9 +
 tools/testing/selftests/net/lib/py/ksft.py         |  159 ++
 tools/testing/selftests/net/lib/py/netns.py        |   31 +
 tools/testing/selftests/net/lib/py/nsim.py         |  134 +
 tools/testing/selftests/net/lib/py/utils.py        |  102 +
 tools/testing/selftests/net/lib/py/ynl.py          |   49 +
 tools/testing/selftests/net/mptcp/diag.sh          |   53 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |    2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  155 +-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  135 +
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |   34 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  281 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c      |    2 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   20 +-
 .../selftests/net/{nat6to4.c => nat6to4.bpf.c}     |    0
 .../selftests/{ => net}/netfilter/.gitignore       |    4 +-
 tools/testing/selftests/net/netfilter/Makefile     |   52 +
 .../selftests/{ => net}/netfilter/audit_logread.c  |    0
 .../selftests/net/netfilter/br_netfilter.sh        |  171 ++
 .../selftests/net/netfilter/bridge_brouter.sh      |  122 +
 tools/testing/selftests/net/netfilter/config       |   89 +
 .../selftests/{ => net}/netfilter/connect_close.c  |    0
 .../{ => net}/netfilter/conntrack_dump_flush.c     |   10 +-
 .../{ => net}/netfilter/conntrack_icmp_related.sh  |  179 +-
 .../netfilter/conntrack_ipip_mtu.sh}               |  118 +-
 .../net/netfilter/conntrack_sctp_collision.sh      |   87 +
 .../net/netfilter/conntrack_tcp_unreplied.sh       |  164 ++
 .../selftests/{ => net}/netfilter/conntrack_vrf.sh |  121 +-
 tools/testing/selftests/net/netfilter/ipvs.sh      |  211 ++
 tools/testing/selftests/net/netfilter/lib.sh       |   10 +
 .../net/netfilter/nf_conntrack_packetdrill.sh      |   71 +
 .../selftests/net/netfilter/nf_nat_edemux.sh       |   97 +
 .../nf-queue.c => net/netfilter/nf_queue.c}        |    0
 .../selftests/{ => net}/netfilter/nft_audit.sh     |   31 +-
 .../{ => net}/netfilter/nft_concat_range.sh        |  213 +-
 .../net/netfilter/nft_concat_range_perf.sh         |    9 +
 .../net/netfilter/nft_conntrack_helper.sh          |  171 ++
 tools/testing/selftests/net/netfilter/nft_fib.sh   |  234 ++
 .../selftests/{ => net}/netfilter/nft_flowtable.sh |  365 ++-
 .../selftests/{ => net}/netfilter/nft_meta.sh      |    4 +-
 .../selftests/{ => net}/netfilter/nft_nat.sh       |  476 ++--
 .../selftests/{ => net}/netfilter/nft_nat_zones.sh |  194 +-
 tools/testing/selftests/net/netfilter/nft_queue.sh |  417 +++
 .../selftests/net/netfilter/nft_synproxy.sh        |   96 +
 .../{ => net}/netfilter/nft_zones_many.sh          |   95 +-
 .../selftests/net/netfilter/packetdrill/common.sh  |   33 +
 .../packetdrill/conntrack_ack_loss_stall.pkt       |  118 +
 .../packetdrill/conntrack_inexact_rst.pkt          |   62 +
 .../packetdrill/conntrack_rst_invalid.pkt          |   59 +
 .../packetdrill/conntrack_syn_challenge_ack.pkt    |   44 +
 .../netfilter/packetdrill/conntrack_synack_old.pkt |   51 +
 .../packetdrill/conntrack_synack_reuse.pkt         |   34 +
 .../testing/selftests/{ => net}/netfilter/rpath.sh |   10 +-
 .../selftests/{ => net}/netfilter/sctp_collision.c |    0
 tools/testing/selftests/net/netfilter/settings     |    1 +
 .../selftests/{ => net}/netfilter/xt_string.sh     |   87 +-
 tools/testing/selftests/net/nl_netdev.py           |   98 +
 .../testing/selftests/net/openvswitch/ovs-dpctl.py |   16 +-
 .../sample_map_ret0.bpf.c}                         |    2 +-
 .../progs/sample_ret0.c => net/sample_ret0.bpf.c}  |    3 +
 tools/testing/selftests/net/udpgro.sh              |    2 +-
 tools/testing/selftests/net/udpgro_bench.sh        |    2 +-
 tools/testing/selftests/net/udpgro_frglist.sh      |    8 +-
 tools/testing/selftests/net/udpgro_fwd.sh          |    2 +-
 tools/testing/selftests/net/veth.sh                |    2 +-
 .../selftests/net/{xdp_dummy.c => xdp_dummy.bpf.c} |    0
 tools/testing/selftests/netfilter/Makefile         |   21 -
 .../testing/selftests/netfilter/bridge_brouter.sh  |  146 -
 .../selftests/netfilter/bridge_netfilter.sh        |  188 --
 tools/testing/selftests/netfilter/config           |    9 -
 .../netfilter/conntrack_sctp_collision.sh          |   89 -
 .../selftests/netfilter/conntrack_tcp_unreplied.sh |  167 --
 tools/testing/selftests/netfilter/ipvs.sh          |  228 --
 tools/testing/selftests/netfilter/nf_nat_edemux.sh |  127 -
 .../selftests/netfilter/nft_conntrack_helper.sh    |  197 --
 tools/testing/selftests/netfilter/nft_fib.sh       |  273 --
 tools/testing/selftests/netfilter/nft_queue.sh     |  449 ---
 tools/testing/selftests/netfilter/nft_synproxy.sh  |  117 -
 .../selftests/netfilter/nft_trans_stress.sh        |  151 -
 tools/testing/selftests/netfilter/settings         |    1 -
 1958 files changed, 90083 insertions(+), 37889 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en8811h.yaml
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
 create mode 100644 Documentation/devicetree/bindings/net/renesas,rzn1-gmac.yaml
 create mode 100644 Documentation/netlink/specs/nftables.yaml
 create mode 100644 Documentation/netlink/specs/team.yaml
 create mode 100644 Documentation/networking/pse-pd/index.rst
 create mode 100644 Documentation/networking/pse-pd/introduction.rst
 create mode 100644 Documentation/networking/pse-pd/pse-pi.rst
 create mode 100644 arch/arc/net/Makefile
 create mode 100644 arch/arc/net/bpf_jit.h
 create mode 100644 arch/arc/net/bpf_jit_arcv2.c
 create mode 100644 arch/arc/net/bpf_jit_core.c
 create mode 100644 crypto/bpf_crypto_skcipher.c
 create mode 100644 drivers/bluetooth/btintel_pcie.c
 create mode 100644 drivers/bluetooth/btintel_pcie.h
 create mode 100644 drivers/net/dsa/microchip/ksz_dcb.c
 create mode 100644 drivers/net/dsa/microchip/ksz_dcb.h
 rename drivers/net/ethernet/intel/ice/{ice_devlink.c => devlink/devlink.c} (77%)
 rename drivers/net/ethernet/intel/ice/{ice_devlink.h => devlink/devlink.h} (100%)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/devlink_port.c
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/devlink_port.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.h
 create mode 100644 drivers/net/ethernet/intel/libeth/Kconfig
 create mode 100644 drivers/net/ethernet/intel/libeth/Makefile
 create mode 100644 drivers/net/ethernet/intel/libeth/rx.c
 create mode 100644 drivers/net/ethernet/intel/libie/Kconfig
 create mode 100644 drivers/net/ethernet/intel/libie/Makefile
 create mode 100644 drivers/net/ethernet/intel/libie/rx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
 create mode 100644 drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_common.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
 create mode 100644 drivers/net/pfcp.c
 create mode 100644 drivers/net/phy/air_en8811h.c
 create mode 100644 drivers/net/pse-pd/pd692x0.c
 create mode 100644 drivers/net/pse-pd/tps23881.c
 rename drivers/net/team/{team.c => team_core.c} (97%)
 create mode 100644 drivers/net/team/team_nl.c
 create mode 100644 drivers/net/team/team_nl.h
 create mode 100644 drivers/net/wireless/ath/ath11k/p2p.c
 create mode 100644 drivers/net/wireless/ath/ath11k/p2p.h
 create mode 100644 drivers/net/wireless/ath/ath12k/acpi.c
 create mode 100644 drivers/net/wireless/ath/ath12k/acpi.h
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs.c
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/module.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/scan.c
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8188e.c => 8188e.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8188f.c => 8188f.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8192c.c => 8192c.c} (90%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8192e.c => 8192e.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8192f.c => 8192f.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8710b.c => 8710b.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8723a.c => 8723a.c} (90%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8723b.c => 8723b.c} (98%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_core.c => core.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_regs.h => regs.h} (100%)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/Makefile
 rename drivers/net/wireless/realtek/rtlwifi/{rtl8192de => rtl8192d}/def.h (100%)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/main.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h
 rename drivers/net/wireless/realtek/rtlwifi/{rtl8192de => rtl8192d}/reg.h (90%)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b_tables.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723cs.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723x.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723x.h
 create mode 100644 drivers/virtio/virtio_debug.c
 create mode 100644 include/linux/bpf_crypto.h
 delete mode 100644 include/linux/genetlink.h
 create mode 100644 include/linux/net/intel/libie/rx.h
 create mode 100644 include/linux/skbuff_ref.h
 create mode 100644 include/net/dscp.h
 create mode 100644 include/net/ieee8021q.h
 create mode 100644 include/net/libeth/rx.h
 create mode 100644 include/net/pfcp.h
 create mode 100644 include/net/proto_memory.h
 create mode 100644 include/net/rstreason.h
 create mode 100644 include/trace/events/icmp.h
 create mode 100644 kernel/bpf/crypto.c
 create mode 100644 net/core/ieee8021q_helpers.c
 rename net/core/{gso_test.c => net_test.c} (67%)
 create mode 100644 net/netlink/genetlink.h
 create mode 100644 net/smc/smc_loopback.c
 create mode 100644 net/smc/smc_loopback.h
 create mode 100644 tools/include/linux/align.h
 delete mode 100644 tools/include/uapi/linux/ethtool.h
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_crypto.c
 delete mode 100644 tools/testing/selftests/bpf/bpf_tcp_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_atomics.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/preempt_lock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier_kfunc_prog_types.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/wq.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_atomics.c
 create mode 100644 tools/testing/selftests/bpf/progs/bind_prog.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_basic.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_sanity.c
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_multi_maps.c
 create mode 100644 tools/testing/selftests/bpf/progs/getpeername4_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getpeername6_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getsockname4_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getsockname6_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_session.c
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/preempt_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_addr_kern.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_forgotten_cb.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nulled_out_cb.c
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_n.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_sock_addr.c
 create mode 100644 tools/testing/selftests/bpf/progs/wq.c
 create mode 100644 tools/testing/selftests/bpf/progs/wq_failures.c
 delete mode 100644 tools/testing/selftests/bpf/test_sock_addr.c
 delete mode 100755 tools/testing/selftests/bpf/test_sock_addr.sh
 create mode 100644 tools/testing/selftests/drivers/net/Makefile
 create mode 100644 tools/testing/selftests/drivers/net/README.rst
 create mode 100644 tools/testing/selftests/drivers/net/config
 create mode 100644 tools/testing/selftests/drivers/net/hw/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/hw/csum.py
 rename tools/testing/selftests/{net => drivers/net/hw}/devlink_port_split.py (100%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/ethtool.sh (92%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/ethtool_extended_state.sh (96%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/ethtool_lib.sh (100%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/ethtool_mm.sh (99%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/ethtool_rmon.sh (91%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/hw_stats_l3.sh (96%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/hw_stats_l3_gre.sh (90%)
 create mode 100644 tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/loopback.sh (92%)
 create mode 100755 tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/settings
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/__init__.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/env.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/load.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/remote.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/remote_netns.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
 create mode 100755 tools/testing/selftests/drivers/net/microchip/ksz9477_qos.sh
 create mode 100755 tools/testing/selftests/drivers/net/ping.py
 create mode 100755 tools/testing/selftests/drivers/net/queues.py
 create mode 100755 tools/testing/selftests/drivers/net/stats.py
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/config
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights.c
 create mode 100644 tools/testing/selftests/net/bpf.mk
 rename tools/testing/selftests/{bpf/test_offload.py => net/bpf_offload.py} (93%)
 create mode 100644 tools/testing/selftests/net/epoll_busy_poll.c
 create mode 100755 tools/testing/selftests/net/forwarding/lib_sh_test.sh
 create mode 100644 tools/testing/selftests/net/hsr/hsr_common.sh
 create mode 100755 tools/testing/selftests/net/hsr/hsr_redbox.sh
 create mode 100644 tools/testing/selftests/net/lib/.gitignore
 create mode 100644 tools/testing/selftests/net/lib/Makefile
 rename tools/testing/selftests/net/{ => lib}/csum.c (97%)
 create mode 100644 tools/testing/selftests/net/lib/py/__init__.py
 create mode 100644 tools/testing/selftests/net/lib/py/consts.py
 create mode 100644 tools/testing/selftests/net/lib/py/ksft.py
 create mode 100644 tools/testing/selftests/net/lib/py/netns.py
 create mode 100644 tools/testing/selftests/net/lib/py/nsim.py
 create mode 100644 tools/testing/selftests/net/lib/py/utils.py
 create mode 100644 tools/testing/selftests/net/lib/py/ynl.py
 rename tools/testing/selftests/net/{nat6to4.c => nat6to4.bpf.c} (100%)
 rename tools/testing/selftests/{ => net}/netfilter/.gitignore (92%)
 create mode 100644 tools/testing/selftests/net/netfilter/Makefile
 rename tools/testing/selftests/{ => net}/netfilter/audit_logread.c (100%)
 create mode 100755 tools/testing/selftests/net/netfilter/br_netfilter.sh
 create mode 100755 tools/testing/selftests/net/netfilter/bridge_brouter.sh
 create mode 100644 tools/testing/selftests/net/netfilter/config
 rename tools/testing/selftests/{ => net}/netfilter/connect_close.c (100%)
 rename tools/testing/selftests/{ => net}/netfilter/conntrack_dump_flush.c (98%)
 rename tools/testing/selftests/{ => net}/netfilter/conntrack_icmp_related.sh (52%)
 rename tools/testing/selftests/{netfilter/ipip-conntrack-mtu.sh => net/netfilter/conntrack_ipip_mtu.sh} (58%)
 create mode 100755 tools/testing/selftests/net/netfilter/conntrack_sctp_collision.sh
 create mode 100755 tools/testing/selftests/net/netfilter/conntrack_tcp_unreplied.sh
 rename tools/testing/selftests/{ => net}/netfilter/conntrack_vrf.sh (60%)
 create mode 100755 tools/testing/selftests/net/netfilter/ipvs.sh
 create mode 100644 tools/testing/selftests/net/netfilter/lib.sh
 create mode 100755 tools/testing/selftests/net/netfilter/nf_conntrack_packetdrill.sh
 create mode 100755 tools/testing/selftests/net/netfilter/nf_nat_edemux.sh
 rename tools/testing/selftests/{netfilter/nf-queue.c => net/netfilter/nf_queue.c} (100%)
 rename tools/testing/selftests/{ => net}/netfilter/nft_audit.sh (92%)
 rename tools/testing/selftests/{ => net}/netfilter/nft_concat_range.sh (90%)
 create mode 100755 tools/testing/selftests/net/netfilter/nft_concat_range_perf.sh
 create mode 100755 tools/testing/selftests/net/netfilter/nft_conntrack_helper.sh
 create mode 100755 tools/testing/selftests/net/netfilter/nft_fib.sh
 rename tools/testing/selftests/{ => net}/netfilter/nft_flowtable.sh (54%)
 rename tools/testing/selftests/{ => net}/netfilter/nft_meta.sh (95%)
 rename tools/testing/selftests/{ => net}/netfilter/nft_nat.sh (62%)
 rename tools/testing/selftests/{ => net}/netfilter/nft_nat_zones.sh (53%)
 create mode 100755 tools/testing/selftests/net/netfilter/nft_queue.sh
 create mode 100755 tools/testing/selftests/net/netfilter/nft_synproxy.sh
 rename tools/testing/selftests/{ => net}/netfilter/nft_zones_many.sh (59%)
 create mode 100755 tools/testing/selftests/net/netfilter/packetdrill/common.sh
 create mode 100644 tools/testing/selftests/net/netfilter/packetdrill/conntrack_ack_loss_stall.pkt
 create mode 100644 tools/testing/selftests/net/netfilter/packetdrill/conntrack_inexact_rst.pkt
 create mode 100644 tools/testing/selftests/net/netfilter/packetdrill/conntrack_rst_invalid.pkt
 create mode 100644 tools/testing/selftests/net/netfilter/packetdrill/conntrack_syn_challenge_ack.pkt
 create mode 100644 tools/testing/selftests/net/netfilter/packetdrill/conntrack_synack_old.pkt
 create mode 100644 tools/testing/selftests/net/netfilter/packetdrill/conntrack_synack_reuse.pkt
 rename tools/testing/selftests/{ => net}/netfilter/rpath.sh (95%)
 rename tools/testing/selftests/{ => net}/netfilter/sctp_collision.c (100%)
 create mode 100644 tools/testing/selftests/net/netfilter/settings
 rename tools/testing/selftests/{ => net}/netfilter/xt_string.sh (50%)
 create mode 100755 tools/testing/selftests/net/nl_netdev.py
 rename tools/testing/selftests/{bpf/progs/sample_map_ret0.c => net/sample_map_ret0.bpf.c} (96%)
 rename tools/testing/selftests/{bpf/progs/sample_ret0.c => net/sample_ret0.bpf.c} (70%)
 rename tools/testing/selftests/net/{xdp_dummy.c => xdp_dummy.bpf.c} (100%)
 delete mode 100644 tools/testing/selftests/netfilter/Makefile
 delete mode 100755 tools/testing/selftests/netfilter/bridge_brouter.sh
 delete mode 100644 tools/testing/selftests/netfilter/bridge_netfilter.sh
 delete mode 100644 tools/testing/selftests/netfilter/config
 delete mode 100755 tools/testing/selftests/netfilter/conntrack_sctp_collision.sh
 delete mode 100755 tools/testing/selftests/netfilter/conntrack_tcp_unreplied.sh
 delete mode 100755 tools/testing/selftests/netfilter/ipvs.sh
 delete mode 100755 tools/testing/selftests/netfilter/nf_nat_edemux.sh
 delete mode 100755 tools/testing/selftests/netfilter/nft_conntrack_helper.sh
 delete mode 100755 tools/testing/selftests/netfilter/nft_fib.sh
 delete mode 100755 tools/testing/selftests/netfilter/nft_queue.sh
 delete mode 100755 tools/testing/selftests/netfilter/nft_synproxy.sh
 delete mode 100755 tools/testing/selftests/netfilter/nft_trans_stress.sh
 delete mode 100644 tools/testing/selftests/netfilter/settings

