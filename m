Return-Path: <bpf+bounces-42041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B5599F038
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBBF1F20F88
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830501AF0D5;
	Tue, 15 Oct 2024 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2WuTgAS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F9A1C4A3A;
	Tue, 15 Oct 2024 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004057; cv=none; b=tu6O+/jaYjUToDwS+cPRUsQjWKqAZsVfvYyr64P61hZ9pqvoC0wHLfcEynWAlp4doQTtiQkBELs0+h3Y8CEmoVo1tobB1OFCdVddzfLpl5u1N8m00InFgb4OdjQfZj4p0TGYDq03DQG4CC8zwPtmamRJAcGshbyrONeD2BFsTsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004057; c=relaxed/simple;
	bh=SO4sj3/Bwh3PRp0tHYME/aWmcCFMfITpBQUXLd0y0LY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IbQ2u9PSoZCChIW9WVXhLuohxiXb/bJreVChc6V7RMTA/Ut2HBHxWhztDNY4Z74EvGRSjN0ISxKR5p7X4K7Yp4qBlUCp1YYYo0e+l3OKliCtBOz3Omab32Jh7gxq2AU7FrIM1EQUXYhPmTuVMjL+u/uvPp/U0/iobIHoJg/RmE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2WuTgAS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729004055; x=1760540055;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SO4sj3/Bwh3PRp0tHYME/aWmcCFMfITpBQUXLd0y0LY=;
  b=m2WuTgASnO0avD/KnbLod2EfxcYqZBloeGmGpc5vP9ru+zJNE+3NGu8b
   wvv+Xkkkt1O0Ocppxt3JB4KXuK2Ep7iu9/N1SZWFdKRkIZn4QWRx25PQR
   Q9bEMRmQyAFgPYQ1YoheZFA5Du9GaU76SuUtoeRZp78rEwga4SXLuaq2R
   AgTBmtEjAo0wQrsNITlbeKDGP77DFqtMU5Jyr+JjOp6nv2G5sBbrBpiE8
   nfeYiyQqln3RWnlqlYnWs1KVmiaewW1FoVvSuFiiMCfS4i+M24kPdOfxn
   tdK5gyaG+v9PylD/5tJ3QtvSDWRqRkDnHRVwAEgr0hY716+b020gp56eb
   A==;
X-CSE-ConnectionGUID: qwre39DtQ7+oXXh1+BWuhA==
X-CSE-MsgGUID: pHYHI0MlSB2lCY4bJjOU0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="31277435"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="31277435"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 07:54:14 -0700
X-CSE-ConnectionGUID: Vk+NIBN0QyqtQSNNMln7TA==
X-CSE-MsgGUID: EIiTLIZaSU2ynDUMUW5d3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82723028"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa003.jf.intel.com with ESMTP; 15 Oct 2024 07:54:10 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 00/18] idpf: XDP chapter III: core XDP changes (+libeth_xdp)
Date: Tue, 15 Oct 2024 16:53:32 +0200
Message-ID: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

XDP for idpf is currently 5 chapters:
* convert Rx to libeth;
* convert Tx and stats to libeth;
* generic XDP and XSk code changes (this);
* actual XDP for idpf via libeth_xdp;
* XSk for idpf (^).

Part III does the following:
* does some cleanups with marking read-only bpf_prog and xdp_buff
  arguments const for some generic functions;
* allows attaching already registered XDP memory model to Rxq info;
* allows mixing pages from several Page Pools within one XDP frame;
* optimizes &xdp_frame structure and removes no-more-used field;
* adds generic functions to build skbs from xdp_buffs (regular and
  XSk) and attach frags to xdp_buffs (regular and XSk);
* adds helper to optimize XSk xmit in drivers;
* extends libeth Rx to support XDP requirements (headroom etc.) on Rx;
* adds libeth_xdp -- libeth module with common XDP and XSk routines.

They are implemented mostly as inlines with inline callback arguments.
They will be then uninlined in the drivers with sane function sizes,
but without any indirect calls.
All those inlines and macros really removes tons of driver code, which
is mostly the same across the drivers minus HW-specific part. You just
basically need functions which read Rx descriptors and fill Tx
descriptors, call a couple macros and that's it. The rest is written
once in libeth_xdp.
All exception and cold code are external. Error handling etc, anything
that don't happen at line rates, are external. Only the hottest things
are inlined ensuring driver code doesn't bloat for no gain and that
cold code won't push hot code into more cachelines than wanted.

Note on diffstat: don't be scared, almost 1500 lines are documentation
explaining everything in details. The actual new code is around 2500.

Alexander Lobakin (17):
  jump_label: export static_key_slow_{inc,dec}_cpuslocked()
  skbuff: allow 2-4-argument skb_frag_dma_map()
  unroll: add generic loop unroll helpers
  bpf, xdp: constify some bpf_prog * function arguments
  xdp, xsk: constify read-only arguments of some static inline helpers
  xdp: allow attaching already registered memory model to xdp_rxq_info
  page_pool: make page_pool_put_page_bulk() actually handle array of
    pages
  page_pool: allow mixing PPs within one bulk
  xdp: get rid of xdp_frame::mem.id
  xdp: add generic xdp_buff_add_frag()
  xdp: add generic xdp_build_skb_from_buff()
  xsk: allow attaching XSk pool via xdp_rxq_info_reg_mem_model()
  xsk: make xsk_buff_add_frag really add a frag via
    __xdp_buff_add_frag()
  xsk: add generic XSk &xdp_buff -> skb conversion
  xsk: add helper to get &xdp_desc's DMA and meta pointer in one go
  libeth: support native XDP and register memory model
  libeth: add a couple of XDP helpers (libeth_xdp)

Toke Høiland-Jørgensen (1):
  net: Register system page pool as an XDP memory model

 drivers/net/ethernet/intel/libeth/Kconfig     |    6 +
 drivers/net/ethernet/intel/libeth/Makefile    |    6 +
 include/net/libeth/types.h                    |  102 +-
 include/net/page_pool/types.h                 |    7 +-
 drivers/net/ethernet/intel/libeth/priv.h      |   37 +
 include/linux/bpf.h                           |   12 +-
 include/linux/filter.h                        |    9 +-
 include/linux/netdevice.h                     |    7 +-
 include/linux/skbuff.h                        |   49 +-
 include/linux/unroll.h                        |   43 +
 include/net/libeth/rx.h                       |    6 +-
 include/net/libeth/tx.h                       |   34 +-
 include/net/libeth/xdp.h                      | 1864 +++++++++++++++++
 include/net/libeth/xsk.h                      |  684 ++++++
 include/net/xdp.h                             |  185 +-
 include/net/xdp_sock_drv.h                    |   52 +-
 include/net/xsk_buff_pool.h                   |   10 +-
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |   30 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   32 +-
 drivers/net/ethernet/intel/libeth/rx.c        |   22 +-
 drivers/net/ethernet/intel/libeth/tx.c        |   39 +
 drivers/net/ethernet/intel/libeth/xdp.c       |  444 ++++
 drivers/net/ethernet/intel/libeth/xsk.c       |  264 +++
 drivers/net/veth.c                            |    4 +-
 kernel/bpf/cpumap.c                           |    2 +-
 kernel/bpf/devmap.c                           |    8 +-
 kernel/jump_label.c                           |    2 +
 net/bpf/test_run.c                            |    2 +-
 net/core/dev.c                                |   20 +-
 net/core/filter.c                             |   41 +-
 net/core/page_pool.c                          |   50 +-
 net/core/skbuff.c                             |    2 +-
 net/core/xdp.c                                |  311 ++-
 net/xdp/xsk_buff_pool.c                       |   40 +
 35 files changed, 4215 insertions(+), 213 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/libeth/priv.h
 create mode 100644 include/net/libeth/xdp.h
 create mode 100644 include/net/libeth/xsk.h
 create mode 100644 drivers/net/ethernet/intel/libeth/tx.c
 create mode 100644 drivers/net/ethernet/intel/libeth/xdp.c
 create mode 100644 drivers/net/ethernet/intel/libeth/xsk.c

---
From v1[0]:
* rebase on top of the latest net-next;
* no other changes.

[0] https://lore.kernel.org/netdev/20241009152756.3113697-1-aleksander.lobakin@intel.com
-- 
2.46.2


