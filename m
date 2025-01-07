Return-Path: <bpf+bounces-48127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 580D6A04485
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 16:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B21164CBB
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372A61F37D3;
	Tue,  7 Jan 2025 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iig7RJe6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2331F2C4A;
	Tue,  7 Jan 2025 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263872; cv=none; b=m2P3qcE/ujC7Y6GltXrZHqi9HXD5T2/l4jDvbXIwNW/YEXoWdy9xxgZhYsOhq1dflnPdeR1jrgiRuMdqtLlbnI9O7/rHZTtBFdlmrrZjnOUOQxfXqe7eF7do55eAqDBwYpgDQw8cNRUSCajGbUc84meR3hBEkLOtq3vBIU+R8ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263872; c=relaxed/simple;
	bh=KGgL49IMtrqHOwLuaNJdIAPy7nRPMTdC4fAmIyy5GxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qLcOuyc5rapPOzNRP4IFGc3lzStTI/equrMvaWuO2II3VzdIxKFf2bHoyyNlIuQLerrbT5S3iUZ4aYHr9R0bHZRBR1BfOGpQPlTLPsGTlXsFtiWpxxCFZaNUsbMjF+gbyZtjUZgVmFLKkQrd8EofYsPJsOvuN3ouT4nWWmtHT2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iig7RJe6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736263867; x=1767799867;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KGgL49IMtrqHOwLuaNJdIAPy7nRPMTdC4fAmIyy5GxM=;
  b=iig7RJe6NFddcAxR127VoKqBPM9iQFP0c1LH5kHncckmKw2j425EKj1o
   FTz9oRJabvpyK3CltMpLir2343tXjrVOu6lAX7/h8Soq4i0uKkXW8DhUY
   GBrbLgRnOEPpxJIsYOnjHk0QN8hQfR+J+m6/ckYZscONtCgiOQYHBgFA/
   c01kyPHDaPiCMIgE1ceY7bJ1gbKKLo7Ov3Tx+Y54ecL7E4jBphxORwzy3
   fzngKVGOQKtNqhqONl3Z35q0Rhw5SWFiDaMgWmJfth094R+5sCccJ8Wl1
   nT1wXmFlvmhcsvtUkGwfh6dNeVZJpSSRpvfRky2pzH/v0acJXrX3MtV1n
   Q==;
X-CSE-ConnectionGUID: t8BHtlBFQVKhwazOirh9SA==
X-CSE-MsgGUID: vKH2h+YwSbyUwcFba4ZGwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="35685770"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="35685770"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 07:31:05 -0800
X-CSE-ConnectionGUID: K9rEp8BcQN6Ur3fEz8tk9w==
X-CSE-MsgGUID: WTutk9I2RpixOcdYlJAnoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103646924"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 07 Jan 2025 07:31:01 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/8] bpf: cpumap: enable GRO for XDP_PASS frames
Date: Tue,  7 Jan 2025 16:29:32 +0100
Message-ID: <20250107152940.26530-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several months ago, I had been looking through my old XDP hints tree[0]
to check whether some patches not directly related to hints can be sent
standalone. Roughly at the same time, Daniel appeared and asked[1] about
GRO for cpumap from that tree.

Currently, cpumap uses its own kthread which processes cpumap-redirected
frames by batches of 8, without any weighting (but with rescheduling
points). The resulting skbs get passed to the stack via
netif_receive_skb_list(), which means no GRO happens.
Even though we can't currently pass checksum status from the drivers,
in many cases GRO performs better than the listified Rx without the
aggregation, confirmed by tests.

In order to enable GRO in cpumap, we need to do the following:

* patches 1-2: decouple the GRO struct from the NAPI struct and allow
  using it out of a NAPI entity within the kernel core code;
* patch 3: switch cpumap from netif_receive_skb_list() to
  gro_receive_skb().

Additional improvements:

* patch 4: optimize XDP_PASS in cpumap by using arrays instead of linked
  lists;
* patch 5-6: introduce and use function do get skbs from the NAPI percpu
  caches by bulks, not one at a time;
* patch 7-8: use that function in veth as well and remove the one that
  was now superseded by it.

My trafficgen UDP GRO tests, small frame sizes:

                GRO off    GRO on
baseline        2.7        N/A       Mpps
patch 3         2.3        4         Mpps
patch 8         2.4        4.7       Mpps

1...3 diff      -17        +48       %
1...8 diff      -11        +74       %

Daniel reported from +14%[2] to +18%[3] of throughput in neper's TCP RR
tests. On my system however, the same test gave me up to +100%.

Note that there's a series from Lorenzo[4] which achieves the same, but
in a different way. During the discussions, the approach using a
standalone GRO instance was preferred over the threaded NAPI.

[0] https://github.com/alobakin/linux/tree/xdp_hints
[1] https://lore.kernel.org/bpf/cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com
[2] https://lore.kernel.org/bpf/merfatcdvwpx2lj4j2pahhwp4vihstpidws3jwljwazhh76xkd@t5vsh4gvk4mh
[3] https://lore.kernel.org/bpf/yzda66wro5twmzpmjoxvy4si5zvkehlmgtpi6brheek3sj73tj@o7kd6nurr3o6
[4] https://lore.kernel.org/bpf/20241130-cpumap-gro-v1-0-c1180b1b5758@kernel.org

Alexander Lobakin (8):
  net: gro: decouple GRO from the NAPI layer
  net: gro: expose GRO init/cleanup to use outside of NAPI
  bpf: cpumap: switch to GRO from netif_receive_skb_list()
  bpf: cpumap: reuse skb array instead of a linked list to chain skbs
  net: skbuff: introduce napi_skb_cache_get_bulk()
  bpf: cpumap: switch to napi_skb_cache_get_bulk()
  veth: use napi_skb_cache_get_bulk() instead of xdp_alloc_skb_bulk()
  xdp: remove xdp_alloc_skb_bulk()

 include/linux/netdevice.h                  |  35 ++++--
 include/linux/skbuff.h                     |   1 +
 include/net/busy_poll.h                    |  11 +-
 include/net/gro.h                          |  38 ++++--
 include/net/xdp.h                          |   1 -
 drivers/net/ethernet/brocade/bna/bnad.c    |   1 +
 drivers/net/ethernet/cortina/gemini.c      |   1 +
 drivers/net/veth.c                         |   3 +-
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c |   1 +
 kernel/bpf/cpumap.c                        | 131 ++++++++++++++-------
 net/core/dev.c                             |  79 ++++---------
 net/core/gro.c                             | 103 ++++++++++------
 net/core/skbuff.c                          |  62 ++++++++++
 net/core/xdp.c                             |  10 --
 14 files changed, 306 insertions(+), 171 deletions(-)

---
From v1[5]:
* use a standalone GRO instance instead of the threaded NAPI (Jakub);
* rebase and send to net-next as it's now more networking than BPF.

[5] https://lore.kernel.org/bpf/20240830162508.1009458-1-aleksander.lobakin@intel.com
-- 
2.47.1


