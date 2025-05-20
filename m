Return-Path: <bpf+bounces-58601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8828ABE544
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 22:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1F11BA81BB
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 20:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0392472BD;
	Tue, 20 May 2025 20:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRtgVEaS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFAFBE5E;
	Tue, 20 May 2025 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747774772; cv=none; b=BWxeRLCBvFygFPJ2r8rgZQTe3QTAseFXSmJ6fU6mQkC64k81DEOZJ5gv9Xg1alsZVPtetabIA7+WaguuByWYbnu/b8XrHvWwt1md/HU38VP/wQIADa3N8yZJEBDyzZFl+/ARqtE4E/9Kmt3HO2vyA8RYrm/6QVH1BlpP4NSO4Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747774772; c=relaxed/simple;
	bh=i2LXA6q4w9avQnr8XrVoLkY33W1jD6X9Kz+ZNsIjaUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jZILGpcHjyAEsHFmyOmViWI2iRzCa6leeRcpbBhS1k2Y6cvHCYbWai6AemeVVFcQFBiZ8upLXBcnLXrhUpOzH3tKzbkWxcnC0ZklkYY2wGfxvlB1JYCm0tV8jWnPnbcy/ybHnOuboImRiTQ3nBoz8Aam7bD5qeDAyZKVNumJ20M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRtgVEaS; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747774770; x=1779310770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i2LXA6q4w9avQnr8XrVoLkY33W1jD6X9Kz+ZNsIjaUE=;
  b=cRtgVEaSRela9HC6Jv29C5ZJ8ABTDjZifirMpONSiRLyoKy3UKyBzo20
   Z/BGlzaYGDMdJ6mfKFQI96rlTnyKhgUcm3dobpXTq5VaRgRLZ8mPvx91O
   Xbk8lVBSPoBBB+apoZYQ31nsnJdOdKpURYgvkMtXN35e1xeIXBUucgy64
   BmPMDbChnQtcRIuvYXi8YMrOCxCpfYcqsvjAB036mpD/Rb5EA+ZsDZVBw
   iQqsXyfddIn1tI3OjBmXCDg6W7fDixlgW4SeLkEKnarqpDAjGdIN39FOh
   BC6BZVFi3xN9h5F/bwRyv8Jz7ukVx16KaV7iIHK02jjNAC19FD7qmk5Wa
   g==;
X-CSE-ConnectionGUID: /2OgcT59SHqcLr5ieKSHTg==
X-CSE-MsgGUID: o5Jc3sYXQFaZPKKRIIWphw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="67142672"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="67142672"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 13:59:29 -0700
X-CSE-ConnectionGUID: FyJ2DKuiR6+JVL9IagIWGQ==
X-CSE-MsgGUID: Cm+nMiCRSG2zW7u72APeZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139850848"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 20 May 2025 13:59:29 -0700
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
Subject: [PATCH net-next 00/16][pull request] libeth: add libeth_xdp helper lib
Date: Tue, 20 May 2025 13:59:01 -0700
Message-ID: <20250520205920.2134829-1-anthony.l.nguyen@intel.com>
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
---
Was a part of "XDP for idpf" series, now submitted separately with
proper splitting into atomic commits. I hope 16 patches out of 15
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

From "XDP for idpf" series, no changes except splitting and a couple
of kdoc fixes. Also checked upstream Patchwork to make sure I didn't
miss anything.

IWL: https://lore.kernel.org/intel-wired-lan/20250415172825.3731091-1-aleksander.lobakin@intel.com/

The following are changes since commit 9ab0ac0e532afd167b3bec39b2eb25c53486dcb5:
  octeontx2-pf: Add tracepoint for NIX_PARSE_S
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE

Alexander Lobakin (16):
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
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |   33 +-
 drivers/net/ethernet/intel/libeth/Kconfig     |   10 +-
 drivers/net/ethernet/intel/libeth/Makefile    |    8 +-
 drivers/net/ethernet/intel/libeth/priv.h      |   37 +
 drivers/net/ethernet/intel/libeth/rx.c        |   40 +-
 drivers/net/ethernet/intel/libeth/tx.c        |   41 +
 drivers/net/ethernet/intel/libeth/xdp.c       |  449 ++++
 drivers/net/ethernet/intel/libeth/xsk.c       |  269 +++
 include/net/libeth/rx.h                       |   28 +-
 include/net/libeth/tx.h                       |   36 +-
 include/net/libeth/types.h                    |  106 +-
 include/net/libeth/xdp.h                      | 1872 +++++++++++++++++
 include/net/libeth/xsk.h                      |  685 ++++++
 15 files changed, 3576 insertions(+), 54 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/libeth/priv.h
 create mode 100644 drivers/net/ethernet/intel/libeth/tx.c
 create mode 100644 drivers/net/ethernet/intel/libeth/xdp.c
 create mode 100644 drivers/net/ethernet/intel/libeth/xsk.c
 create mode 100644 include/net/libeth/xdp.h
 create mode 100644 include/net/libeth/xsk.h

-- 
2.47.1


