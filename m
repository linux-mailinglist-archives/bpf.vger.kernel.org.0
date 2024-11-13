Return-Path: <bpf+bounces-44755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3929F9C78C9
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 17:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C3AB3EC4C
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAB314C588;
	Wed, 13 Nov 2024 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="liMFllBF"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7461A770E2;
	Wed, 13 Nov 2024 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511503; cv=none; b=qpNHFoQf/JlFPq8+A6icYBpXO9X797i1jYRmNaS9o5QQvBRW/WOFWGhfQERu6z49enobKbqyiOwVFr9DZbNXP6UrHBgH8Aj1NLiU9DTpzfu+z1xVZyABCwS000SFtNLdoSvbtiH/eFGSqe+yfqpPeKeR2NSoPHy1rXon+t1pz50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511503; c=relaxed/simple;
	bh=WCrAxWwpOAyvuAGM50NmMD1HXewTYcsNb4PFEkMBTHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AXLFlIAwRLGYsAYVINWPgyQK1TujqCX0AEGhCGT6Lm8PIFY9/oJfKSCH5ZYm75TTUyAg6g3wAnLb8H6zKnx2t4pV5xcSGvU5qvxmZhxpuHNdajAUdi2GciXK0vK5BQAHvX/jhOKt4abiSJMP0h3M33k29WnoRIPglUZdycg8nyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=liMFllBF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731511501; x=1763047501;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WCrAxWwpOAyvuAGM50NmMD1HXewTYcsNb4PFEkMBTHI=;
  b=liMFllBF+8h2zh7xs+HvUjbpNrZJTGLoiHHNpIOOmMi9P7J/hqzrLn2l
   PKJq6TV32d++w/2W0RO+2Wd9VUbLwyLSTjTRtp8vql/nCmCbRYLQfEHdb
   VqXFV5OSzck53NcpGyPxHP6v8X1YvUhEck/X1X3+ehwFE9QOx93/yFjrT
   gus8KRwFFwspEw+pFAiC13QnZ24mfgFQLuKfT74ywv2gCX7+T5sLApL3E
   53lDAfvAhWvRkFJRtAdI2h89RTHxlHOP8egN8/31oQYAqwu5m/qvBH8Qe
   /TvAqYPCIK5XSvso6VfIOqsmjWR8ZKh6YzBudEuY5DKCilFBsAm3BO6Hc
   Q==;
X-CSE-ConnectionGUID: VjWatRebSCeSGmUYF1Gkeg==
X-CSE-MsgGUID: n0uWavrgRGe70IdMy6KHCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42799214"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42799214"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:25:01 -0800
X-CSE-ConnectionGUID: /JM+zewiTLymTT+CrooEmA==
X-CSE-MsgGUID: MasPLYUeQ5WcqW1nCqaE/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="118726803"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 07:24:57 -0800
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
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 00/19] xdp: a fistful of generic changes (+libeth_xdp)
Date: Wed, 13 Nov 2024 16:24:23 +0100
Message-ID: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
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
All exception and cold code is external. Error handling etc, anything
that doesn't happen at line rates, is external. Only the hottest things
are inlined ensuring driver code doesn't bloat for no gain and that
cold code won't push hot code into more cachelines than wanted.

Note on diffstat: don't be scared, almost 1500 lines are documentation
explaining everything in details. The actual new code is around 2500.

Alexander Lobakin (18):
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
  xsk: align &xdp_buff_xsk harder
  xsk: allow attaching XSk pool via xdp_rxq_info_reg_mem_model()
  xsk: make xsk_buff_add_frag really add a frag via
    __xdp_buff_add_frag()
  xsk: add generic XSk &xdp_buff -> skb conversion
  xsk: add helper to get &xdp_desc's DMA and meta pointer in one go
  libeth: support native XDP and register memory model
  libeth: add a couple of XDP helpers (libeth_xdp)

Toke Høiland-Jørgensen (1):
  xdp: register system page pool as an XDP memory model

 drivers/net/ethernet/intel/libeth/Kconfig     |    6 +
 drivers/net/ethernet/intel/libeth/Makefile    |    6 +
 include/net/libeth/types.h                    |  102 +-
 include/net/page_pool/types.h                 |    6 +-
 drivers/net/ethernet/intel/libeth/priv.h      |   37 +
 include/linux/bpf.h                           |   12 +-
 include/linux/filter.h                        |    9 +-
 include/linux/netdevice.h                     |    7 +-
 include/linux/skbuff.h                        |   49 +-
 include/linux/unroll.h                        |   43 +
 include/net/libeth/rx.h                       |    6 +-
 include/net/libeth/tx.h                       |   34 +-
 include/net/libeth/xdp.h                      | 1861 +++++++++++++++++
 include/net/libeth/xsk.h                      |  684 ++++++
 include/net/xdp.h                             |  185 +-
 include/net/xdp_sock_drv.h                    |   52 +-
 include/net/xsk_buff_pool.h                   |   12 +-
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |   30 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   32 +-
 drivers/net/ethernet/intel/libeth/rx.c        |   22 +-
 drivers/net/ethernet/intel/libeth/tx.c        |   39 +
 drivers/net/ethernet/intel/libeth/xdp.c       |  446 ++++
 drivers/net/ethernet/intel/libeth/xsk.c       |  264 +++
 drivers/net/veth.c                            |    4 +-
 kernel/bpf/cpumap.c                           |    2 +-
 kernel/bpf/devmap.c                           |    8 +-
 kernel/jump_label.c                           |    2 +
 net/bpf/test_run.c                            |    4 +-
 net/core/dev.c                                |   20 +-
 net/core/filter.c                             |   41 +-
 net/core/page_pool.c                          |   60 +-
 net/core/skbuff.c                             |    2 +-
 net/core/xdp.c                                |  311 ++-
 net/xdp/xsk_buff_pool.c                       |   40 +
 35 files changed, 4219 insertions(+), 221 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/libeth/priv.h
 create mode 100644 include/net/libeth/xdp.h
 create mode 100644 include/net/libeth/xsk.h
 create mode 100644 drivers/net/ethernet/intel/libeth/tx.c
 create mode 100644 drivers/net/ethernet/intel/libeth/xdp.c
 create mode 100644 drivers/net/ethernet/intel/libeth/xsk.c

---
From v4[0]:
* 12: pick RB from Toke;
* 19: drop redundant ';'s (Jakub);
* 19: fix a couple context imbalance warnings by moving __acquires() /
  __releases() to the proper place (smatch);
* no functional changes.

From v3[1]:
* rebase on top of the latest net-next to solve conflict (Jakub);
* 09: use iterative approach instead of recursive to not blow the stack
  (Toke);
* 12: rephrase the commitmsg since the functionality changed, so that
  it's not actual anymore (Toke);
* align &xdp_buff_xsk a bit harder since its alignment degraded
  recently;
* pick RBs from Toke.

From v2[2]:
* cover: rename the series;
* collect RBs and Acks from Maciej;
* 007: reword the commitmsg;
* 011: fix typos in the commitmsg (M);
* 012: 'ts' -> 'tsize' (M; not 'truesize' to fit into 80 cols =\);
* 016: fix the intro sentence (M);
* no functional changes.

From v1[3]:
* rebase on top of the latest net-next;
* no other changes.

[0] https://lore.kernel.org/netdev/20241107161026.2903044-1-aleksander.lobakin@intel.com
[1] https://lore.kernel.org/netdev/20241030165201.442301-1-aleksander.lobakin@intel.com
[2] https://lore.kernel.org/netdev/20241015145350.4077765-1-aleksander.lobakin@intel.com
[3] https://lore.kernel.org/netdev/20241009152756.3113697-1-aleksander.lobakin@intel.com
-- 
2.47.0


