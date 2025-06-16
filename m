Return-Path: <bpf+bounces-60749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE15ADBAEF
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 22:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397DE3AA183
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 20:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AA0289E17;
	Mon, 16 Jun 2025 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7KBrdFR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4856A188734;
	Mon, 16 Jun 2025 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105033; cv=none; b=HEfcFwzGIGgehqdWvWGuDpRkXrE/PZgyhXCvjNhx+KrypI9KKcekSOUJ917oJnbNVawB7rBHbBdAZQKHN55bO/0yIRVhXSVyLCwkXaYxt9JRZU/2o0L57/u+FNmviZW/5L7LMre0JXKvO7d6krCKWcXDGeEI9Jia3xwoPUptQ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105033; c=relaxed/simple;
	bh=QqqcdBldOsKECqDeDnLCI7ssciXHHExLpk1j8BVrxVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TsRCSF+diaXlxhEIo/kdM/51q5kivn/JRfFioQ0/fWUK+SL4oheocZgIWrj1F8sif+h+Qya8+2InvMqKRVgkZxVlCUEfeP9aDWKyUh33hJIZglaihWlH6AM3btZwazLJhU0Jl0u63Voma9ZdXwaWKH7grB3n9fI2AOHqrY3a7+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f7KBrdFR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750105031; x=1781641031;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QqqcdBldOsKECqDeDnLCI7ssciXHHExLpk1j8BVrxVg=;
  b=f7KBrdFRlZcyrFVy5qOgN4X6SHsOVg518zgtKY4i2twQhTpBT1WnFsG2
   8BYTWy2e255dc5f/GxPjiFXKTxGxHClRF9L9tQ/F+On0DwyIQVzb9p1DU
   GqXsYolBoFtwRi1c7B5X+bFnoXb9bR5L9k6dn6OXsufFTlggJFHNgggmA
   nFyhAS+un7sb3TcBuyYT75K1wzNKGqEC4eH9cDdb6Ub4/8srNrSM5MvDx
   N69Q1nP9SqEEaECpthBo99pgSzoB51CF962A3gPOf94Mk75rTMVWCUVJK
   haUgRnMGPw5b/SjQOS6todSwPphEpB1koSW+sPh8QdTIMUpFGsCoN9cbI
   A==;
X-CSE-ConnectionGUID: 34Pi4Y39QXOtW9iCus/xvg==
X-CSE-MsgGUID: Up3J76l1TkCXi/40mEUZgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="62533436"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="62533436"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 13:17:10 -0700
X-CSE-ConnectionGUID: WLFE0wpWSOK15rp7dukoIA==
X-CSE-MsgGUID: a298UTcPT8WpCzlxwOt3gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="153530965"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 16 Jun 2025 13:17:10 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	aleksander.lobakin@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	przemyslaw.kitszel@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 00/17][pull request] libeth: add libeth_xdp helper lib
Date: Mon, 16 Jun 2025 13:16:21 -0700
Message-ID: <20250616201639.710420-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alexander Lobakin says:

Time to add XDP helpers infra to libeth to greatly simplify adding
XDP to idpf and iavf, as well as improve and extend XDP in ice and
i40e. Any vendor is free to reuse helpers. If this happens, I'm fine
with moving the folder of out intel/.

The helpers greatly simplify building xdp_buff, running a prog,
handling the verdict, implement XDP_TX, .ndo_xdp_xmit, XDP buffer
completion. Same applies to XSk (with XSk xmit instead of
.ndo_xdp_xmit, plus stuff like XSk wakeup).
They are entirely generic with no HW definitions or assumptions.
HW-specific stuff like parsing Rx desc / filling Tx desc is passed
from the driver as inline callbacks.

For now, key assumptions that optimize performance / avoid code
bloat, but might not fit every driver in driver/net/:
 * netmem holding the buffers are always order-0;
 * driver has separate XDP Tx queues, doesn't use stack queues for
   that. For best efficiency, you may want to have nr_cpu_ids XDP
   queues, but less (queue sharing) is also supported;
 * XDP Tx queues are interrupt-less and use "lazy" cleaning only
   when there are less than 1/4 free Tx descriptors of the queue
   size;
 * main target platforms are 64-bit, although 32-bit is also fully
   supported, but the code might be not as optimized for them.

Library code already supports multi-buffer for all kinds of Tx and
both header split and no split for Rx and Tx. Frags can come from
devmem/io_uring etc., direct `struct page *` is used only for header
buffers for which it's always true.
Drivers are free to pass their own Rx hints and XSK xmit hints ops.

XDP_TX and ndo_xdp_xmit use onstack bulk for the frames to be sent
and send them by batches of 16 buffers. This eats ~280 bytes on the
stack, but gives good boosts and allow to greatly optimize the main
sending function leaving it without any error/exception paths.

XSk xmit fills Tx descriptors in the loop unrolled by 8. This was
proven to improve perf on ice and i40e. XDP_TX and ndo_xdp_xmit
doesn't use unrolling as I wasn't able to get any improvements in
those scenenarios from this, while +1 Kb for their sending functions
for nothing doesn't sound reasonable.

XSk wakeup, instead of traditionally used "SW interrupts" provided
by NICs, uses IPI to schedule NAPI on the CPU corresponding to the
given queue pair. It gives better control over CPU distribution and
in general performs way better than "SW interrupts", plus allows us
to not pass any HW-specific callbacks there.

The code is built the way that all callbacks passed from drivers
get inlined; in general, most of hotpath gets inlined. Everything
slow/exception lands to .c files in the libeth folder, doesn't
create copies in the drivers themselves and doesn't overloat
hotpath.
Sure, inlining means that hotpath will be compiled into every driver
that uses the lib, but the core code is written in one place, so no
copying of bugs happens. Fixed once -- works everywhere.

The last commit might look like sorta hack, but it gives really good
boosts and decreases object code size, plus there are checks that
all those wider accesses are fully safe, so I don't feel anything
bad about it.

An example of using libeth_xdp can be found either on my GitHub or
on the mailing lists here ("XDP for idpf"). Macros for building
driver XDP functions lead to that some implementations (XDP_TX,
ndo_xdp_xmit etc.) consist of really only a few lines.
----
Was a part of "XDP for idpf" series, now submitted separately with
proper splitting into atomic commits. I hope 17 patches out of 15
maximum allowed is not a problem.

All checkpatch warnings are false-positives unless someone disagrees.
Checked with `--strict --codespell`, a well as building with W=12
and sparse/smatch.
W=12 is clean, sparse only warns about "context imbalance", but it's
intended that libeth_xdp_tx_init_bulk() takes rcu_read_lock() and
libeth_xdp_rx_finalize() does rcu_read_unlock(). This is how Eth
drivers with enabled XDP do: lock before the NAPI polling loop,
unlock after the loop is done and the pending XDP_TX and
XDP_REDIRECT frames/maps are flushed (both functions are always
required to be called when using libeth_xdp helpers on Rx).

v2:
* move EXPORT_SYMBOL*() stuff to a separate (1st) commit;
* annotate a couple big objects on the stack with `__uninitialized` to
  mitigate performance loss with `CONFIG_INIT_STACK_ALL_*` (Kees);
* 0001: idpf: drop invalid packets if header split workaround failed (Jakub);
* 0003: don't support XDP + netmem for now until the core is ready for
  this (Jakub);
* 0009: use new __DEFINE_FLEX() after the changes from the hardening PR
  (Kees).

v1: https://lore.kernel.org/netdev/20250520205920.2134829-1-anthony.l.nguyen@intel.com
IWL: https://lore.kernel.org/intel-wired-lan/20250612160234.68682-1-aleksander.lobakin@intel.com/

The following are changes since commit 8909f5f4ecd551c2299b28e05254b77424c8c7dc:
  net: stmmac: qcom-ethqos: add ethqos_pcs_set_inband()
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE

Alexander Lobakin (17):
  libeth, libie: clean symbol exports up a little
  libeth: convert to netmem
  libeth: support native XDP and register memory model
  libeth: xdp: add XDP_TX buffers sending
  libeth: xdp: add .ndo_xdp_xmit() helpers
  libeth: xdp: add XDPSQE completion helpers
  libeth: xdp: add XDPSQ locking helpers
  libeth: xdp: add XDPSQ cleanup timers
  libeth: xdp: add helpers for preparing/processing &libeth_xdp_buff
  libeth: xdp: add XDP prog run and verdict result handling
  libeth: xdp: add templates for building driver-side callbacks
  libeth: xdp: add RSS hash hint and XDP features setup helpers
  libeth: xsk: add XSk XDP_TX sending helpers
  libeth: xsk: add XSk xmit functions
  libeth: xsk: add XSk Rx processing support
  libeth: xsk: add XSkFQ refill and XSk wakeup helpers
  libeth: xdp, xsk: access adjacent u32s as u64 where applicable

 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   14 +-
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |    2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |   36 +-
 drivers/net/ethernet/intel/libeth/Kconfig     |   10 +-
 drivers/net/ethernet/intel/libeth/Makefile    |    8 +-
 drivers/net/ethernet/intel/libeth/priv.h      |   37 +
 drivers/net/ethernet/intel/libeth/rx.c        |   42 +-
 drivers/net/ethernet/intel/libeth/tx.c        |   41 +
 drivers/net/ethernet/intel/libeth/xdp.c       |  451 ++++
 drivers/net/ethernet/intel/libeth/xsk.c       |  271 +++
 drivers/net/ethernet/intel/libie/rx.c         |    7 +-
 include/net/libeth/rx.h                       |   28 +-
 include/net/libeth/tx.h                       |   36 +-
 include/net/libeth/types.h                    |  106 +-
 include/net/libeth/xdp.h                      | 1879 +++++++++++++++++
 include/net/libeth/xsk.h                      |  685 ++++++
 16 files changed, 3596 insertions(+), 57 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/libeth/priv.h
 create mode 100644 drivers/net/ethernet/intel/libeth/tx.c
 create mode 100644 drivers/net/ethernet/intel/libeth/xdp.c
 create mode 100644 drivers/net/ethernet/intel/libeth/xsk.c
 create mode 100644 include/net/libeth/xdp.h
 create mode 100644 include/net/libeth/xsk.h

-- 
2.47.1


