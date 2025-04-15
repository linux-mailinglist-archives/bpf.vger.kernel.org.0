Return-Path: <bpf+bounces-55976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8838A8A567
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 19:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722C2176E80
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479D121E08B;
	Tue, 15 Apr 2025 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NmbL0pQW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4933ADDDC;
	Tue, 15 Apr 2025 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738136; cv=none; b=YIucuDFIAjJja9n1Juwctr2HfR3hQGiKlD2fD9b28B+8z1C9Td7M7ImN2JuIDPXPqu6SVCav9r97ip87Cygk8syyqOUbPDnEMITThU5Ngh4JBghvxxgw6TxiA9/vmlyTBu05QAAeFsqmzp/F6tVg8CUTBej0HOCfal6r05PZqGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738136; c=relaxed/simple;
	bh=mEOz3O2WBIS6uD6OUFNzsZVjS3wbFaOZ1bsRQQQMqgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oyMIZkBFib1mEcmb1ZnzkDdR6GozWGUyHZAfFylhLNkqR8EN0HZU+PRoLVoT7X2hwld6Fx6gjXiQBnPn59P6Cwwkm1hZ5PmwIBOLRYPADGWvgmKA+m4GxWU9Tviznq5w/pjN/f/Mi3JHP2xXmm8kLcythB6h3tJzscfyvyV/KbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NmbL0pQW; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744738134; x=1776274134;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mEOz3O2WBIS6uD6OUFNzsZVjS3wbFaOZ1bsRQQQMqgE=;
  b=NmbL0pQWRLlslI/9rvMNoPnBwIesDjaeGltMGJYzbQ6UyCjZkMx6vuyj
   KnmgOZ4zXPRLG1M+4r0xP8qLQdBmkBH9osLhf1nXl3DbuMDd+1JkOEt3O
   33HJDeJ5mHo10fP8kpvJZ/oFOoIc/NeYh4XnNhZIO3gd4ToQgwGrH9jmk
   ahD/X2eebdHd09AtXsBYs+2hQzIG6mgavP9qq6nmpeM2Nw+UKVnOvzhPQ
   IwqliR692Ovl7DG38sFLv/xHqwkZ6NDl40llTHHhLxsJufqBCI1cwRsRx
   AE14zBLJYKyqSCZSvHCc3UzaUKbmxhBUL9XTRWt4rjvwsG80Lj6JLe2oz
   w==;
X-CSE-ConnectionGUID: vf6cWw+jTieB8bDDxnRINg==
X-CSE-MsgGUID: wMgce0rOSuCefffQgEiQwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46275576"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46275576"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 10:28:54 -0700
X-CSE-ConnectionGUID: DK52L1QkRu6Ac8/cs2VS5w==
X-CSE-MsgGUID: NCcMP3k9Rz6bis6wLogFrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130729626"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 15 Apr 2025 10:28:49 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next 00/16] libeth: add libeth_xdp helper lib
Date: Tue, 15 Apr 2025 19:28:09 +0200
Message-ID: <20250415172825.3731091-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 drivers/net/ethernet/intel/libeth/Kconfig     |   10 +-
 drivers/net/ethernet/intel/libeth/Makefile    |    8 +-
 include/net/libeth/types.h                    |  106 +-
 drivers/net/ethernet/intel/libeth/priv.h      |   37 +
 include/net/libeth/rx.h                       |   28 +-
 include/net/libeth/tx.h                       |   36 +-
 include/net/libeth/xdp.h                      | 1872 +++++++++++++++++
 include/net/libeth/xsk.h                      |  685 ++++++
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   14 +-
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |    2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |   33 +-
 drivers/net/ethernet/intel/libeth/rx.c        |   40 +-
 drivers/net/ethernet/intel/libeth/tx.c        |   41 +
 drivers/net/ethernet/intel/libeth/xdp.c       |  449 ++++
 drivers/net/ethernet/intel/libeth/xsk.c       |  269 +++
 15 files changed, 3576 insertions(+), 54 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/libeth/priv.h
 create mode 100644 include/net/libeth/xdp.h
 create mode 100644 include/net/libeth/xsk.h
 create mode 100644 drivers/net/ethernet/intel/libeth/tx.c
 create mode 100644 drivers/net/ethernet/intel/libeth/xdp.c
 create mode 100644 drivers/net/ethernet/intel/libeth/xsk.c

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

Targeted for iwl-next properly as no code outside the Intel folder
was changed.
-- 
2.49.0


