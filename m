Return-Path: <bpf+bounces-46012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EA09E298F
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 18:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558A62834B6
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 17:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699B21FBEAE;
	Tue,  3 Dec 2024 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AVNnOntV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280EC1FAC51;
	Tue,  3 Dec 2024 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247651; cv=none; b=IPfsUpVPLATaEqwXTaSvpuq9UMdcY0H42p3Kbhuc0qsJfRYuGRzYWgeFtqjbgJOz1hu6gmrUiAc1KGl9oQD0KxnKx09aiPg5PHhm8zpTjCMn8sky4rqT83OFPQqqrrQkBdfwwvzRgPiWGDDj04lkhJ4T9JROQvOr/vKqOwd6O5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247651; c=relaxed/simple;
	bh=5f8V0ViCWSwHPKr9N1Ee9MvOVQtipiD141WC9doMRfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=odpbwVu0Nt4Cj5bozIlHnMTy5IYuGG6Ogru5x1yYXyfvlpsLTOxU3ObiSp8eiI72kwk0O74p3D10dUMob9bwD9AcYyAjh28qVTwDNSRVdh7MdjSnOmmzQO7jAXLtfUwTcvtz68loXUA8ApSDkIPy56nBLYTzd9OuJOQ5QBHX8u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AVNnOntV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733247651; x=1764783651;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5f8V0ViCWSwHPKr9N1Ee9MvOVQtipiD141WC9doMRfs=;
  b=AVNnOntV90hiZXOqX2mMQps7nFFfPsr4CZQZ02V+Jtc3frAlTu3fbtHL
   8e4jSxPaVM0p+XUA2diEZgQ3x9NNb8/lAiJroS24espMJ/ARSoZBvUZj1
   37cDDra1GJUN49Moh/ibskq9DnqJLX+aceYIgMWwOlZx2D8IFeZWKYEVq
   yczEzDCNSyf5FLuUO9dYeNNoGVcnO+y8RdWRZ41cxC8fXmIr+Se0tDmtp
   fbnSW0Rvr5s1ChtVHsoxkHOVPjGIgNwCiyM7Fqx7LvbuC+OuGKYMScAg4
   703Btoti6Bh1a4IEN34A+k2ZMmtYI/0SBeEDKjjvoMnpau9VQa8hZJKes
   w==;
X-CSE-ConnectionGUID: mNeqAZu1Tsub2Uf8JAfkUw==
X-CSE-MsgGUID: LSUlTI4xQkqs8dmZ791XBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37135271"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="37135271"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 09:40:50 -0800
X-CSE-ConnectionGUID: y/5LGjzMRACcXQoC2TjPLg==
X-CSE-MsgGUID: n7FXlJYgTGGlQccDcgKKoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="124336982"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 03 Dec 2024 09:40:46 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 00/10] xdp: a fistful of generic changes pt. I
Date: Tue,  3 Dec 2024 18:37:23 +0100
Message-ID: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

XDP for idpf is currently 6 chapters:
* convert Rx to libeth;
* convert Tx and stats to libeth;
* generic XDP and XSk code changes (you are here);
* generic XDP and XSk code additions;
* actual XDP for idpf via new libeth_xdp;
* XSk for idpf (via ^).

Part III does the following:
* improve &xdp_buff_xsk cacheline placement;
* does some cleanups with marking read-only bpf_prog and xdp_buff
  arguments const for some generic functions;
* allows attaching already registered XDP memory model to RxQ info;
* makes system percpu page_pools valid XDP memory models;
* starts using netmems in the XDP core code (1 function);
* allows mixing pages from several page_pools within one XDP frame;
* optimizes &xdp_frame layout and removes no-more-used field.

Bullets 4-6 are the most important ones. All of them are prereqs to
libeth_xdp.

Alexander Lobakin (9):
  xsk: align &xdp_buff_xsk harder
  bpf, xdp: constify some bpf_prog * function arguments
  xdp, xsk: constify read-only arguments of some static inline helpers
  xdp: allow attaching already registered memory model to xdp_rxq_info
  xsk: allow attaching XSk pool via xdp_rxq_info_reg_mem_model()
  netmem: add a couple of page helper wrappers
  page_pool: make page_pool_put_page_bulk() handle array of netmems
  page_pool: allow mixing PPs within one bulk
  xdp: get rid of xdp_frame::mem.id

Toke Høiland-Jørgensen (1):
  xdp: register system page pool as an XDP memory model

 include/net/page_pool/types.h                 |   6 +-
 include/linux/bpf.h                           |  12 +-
 include/linux/filter.h                        |   9 +-
 include/linux/netdevice.h                     |   7 +-
 include/linux/skbuff.h                        |   2 +-
 include/net/netmem.h                          |  78 +++++++++++-
 include/net/xdp.h                             |  93 ++++++++++----
 include/net/xdp_sock_drv.h                    |  11 +-
 include/net/xsk_buff_pool.h                   |   4 +-
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    |   2 +-
 drivers/net/veth.c                            |   4 +-
 kernel/bpf/cpumap.c                           |   2 +-
 kernel/bpf/devmap.c                           |   8 +-
 net/bpf/test_run.c                            |   4 +-
 net/core/dev.c                                |  20 ++-
 net/core/filter.c                             |  41 +++---
 net/core/page_pool.c                          |  79 ++++++++----
 net/core/skbuff.c                             |   2 +-
 net/core/xdp.c                                | 118 +++++++++++-------
 19 files changed, 348 insertions(+), 154 deletions(-)

---
From v5[0]:
* split the overgrowth series into 2 parts: changes and additions
  (Jakub);
* 008: future-proof: make the touched function MP-agnostic to avoid
  double work in future;
* send to better fitting now bpf instead of netdev.

From v4[1]:
* 12: pick RB from Toke;
* 19: drop redundant ';'s (Jakub);
* 19: fix a couple context imbalance warnings by moving __acquires() /
  __releases() to the proper place (smatch);
* no functional changes.

From v3[2]:
* rebase on top of the latest net-next to solve conflict (Jakub);
* 09: use iterative approach instead of recursive to not blow the stack
  (Toke);
* 12: rephrase the commitmsg since the functionality changed, so that
  it's not actual anymore (Toke);
* align &xdp_buff_xsk a bit harder since its alignment degraded
  recently;
* pick RBs from Toke.

From v2[3]:
* cover: rename the series;
* collect RBs and Acks from Maciej;
* 007: reword the commitmsg;
* 011: fix typos in the commitmsg (M);
* 012: 'ts' -> 'tsize' (M; not 'truesize' to fit into 80 cols =\);
* 016: fix the intro sentence (M);
* no functional changes.

From v1[4]:
* rebase on top of the latest net-next;
* no other changes.

[0] https://lore.kernel.org/netdev/20241113152442.4000468-1-aleksander.lobakin@intel.com
[1] https://lore.kernel.org/netdev/20241107161026.2903044-1-aleksander.lobakin@intel.com
[2] https://lore.kernel.org/netdev/20241030165201.442301-1-aleksander.lobakin@intel.com
[3] https://lore.kernel.org/netdev/20241015145350.4077765-1-aleksander.lobakin@intel.com
[4] https://lore.kernel.org/netdev/20241009152756.3113697-1-aleksander.lobakin@intel.com
-- 
2.47.0


