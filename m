Return-Path: <bpf+bounces-52545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7793FA44800
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9C316EA33
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247D51946A2;
	Tue, 25 Feb 2025 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNrPqVYG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E972919992D;
	Tue, 25 Feb 2025 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504275; cv=none; b=Uyn9ZXkPZA1eI40ETyBpq86dsuRuj8ayoAp9hhd5biuHGldClTcNjIvXLMRKpIoyjArI62U2DDtjb0H1O07+eyHwe0ZKDwjz3R08JFiepB1ACE+R3Wkz+nPnD9ja88+Khzzs3b+t43+EKBtE9TccTSl5+b5l/ZTjafLMdQy7JJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504275; c=relaxed/simple;
	bh=B/JrfUv3KwTKpWmCJzL/AjBVf2xTESkAGarMss+veZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qG/Z8ZjsjA73A7kb9ortfwq0xeZ5ld0GyyA3/iXLMXgLUKk3IV+WA4uhEmWGAWIzjvvUnP1PQd91V2AZtcFRs1PaLCHXvZk2vLnmPrVghABzbBIFlm6h3jgdmaFczX4OdtjwpeFB9s+pNqVvOYwnPyPvfXkPD9tjzzgul79gFi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNrPqVYG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740504274; x=1772040274;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B/JrfUv3KwTKpWmCJzL/AjBVf2xTESkAGarMss+veZo=;
  b=mNrPqVYGkkGV8ID9q63m+pl+jamljxbjXVx/k3O6QTauuZDjzrAoOYci
   8+EUizUDycoS2TzgpVhdK2t8nWgQLsvzARBKghXCdPAPpnUVaY+qJ0Cbu
   A5r9Tw1ZMp/MI9BmeYSu70AN7glIA3NBkFhAYWcTiY2E0SdMzX+aJsC0G
   ObsgrPOCqSyZ4hkYR8Y+h8CF9SCNMgNVIZBCj6zgxutBhIEBZrCOpzo1I
   RyVVG7wnJzZ/GyTvL1Kb7K4hLFcPOywZnIvnnKlCbXvag1ECVPRdwe2nm
   UATQ3B+IP08BFQWUG1kM8q5LjQGL5TaPflCt55qwx27VwATUEm4nd4Nrg
   A==;
X-CSE-ConnectionGUID: 3nPStewYS+2tgKpq12BCpA==
X-CSE-MsgGUID: UFSdZOT6RvCS9c/PGe4wBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="44974069"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="44974069"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 09:24:33 -0800
X-CSE-ConnectionGUID: /AipXs/wT5m2Nz4zUlmAKw==
X-CSE-MsgGUID: G7BmK6lzTtSyLuXseDSgdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116256857"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa006.fm.intel.com with ESMTP; 25 Feb 2025 09:24:29 -0800
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
Subject: [PATCH net-next v5 0/8] bpf: cpumap: enable GRO for XDP_PASS frames
Date: Tue, 25 Feb 2025 18:17:42 +0100
Message-ID: <20250225171751.2268401-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

 include/linux/netdevice.h                  |  37 ++++--
 include/linux/skbuff.h                     |   1 +
 include/net/busy_poll.h                    |  12 +-
 include/net/gro.h                          |  38 ++++--
 include/net/xdp.h                          |   1 -
 drivers/net/ethernet/brocade/bna/bnad.c    |   1 +
 drivers/net/ethernet/cortina/gemini.c      |   1 +
 drivers/net/veth.c                         |   3 +-
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c |   1 +
 kernel/bpf/cpumap.c                        | 146 +++++++++++++--------
 net/core/dev.c                             |  79 ++++-------
 net/core/gro.c                             | 103 ++++++++++-----
 net/core/skbuff.c                          |  62 +++++++++
 net/core/xdp.c                             |  10 --
 14 files changed, 315 insertions(+), 180 deletions(-)

---
From v4[5]:
* 1:
  * use standalone struct gro_node instead of struct_group() again,
    this time make napi_struct::napi_id purely control path and use
    cached napi_id from gro_node on hotpath (Eric, Jakub).
    For napi_struct::napi_id, reuse one already existing padding,
    so that the structure size didn't change;
  * rebase on top of the latest net-next.

From v3[6]:
* series:
  * rebase on top of the latest net-next;
  * pick RBs from Toke;
* 1:
  * reduce possible false sharing of napi_struct (now gro_node is
    placed precisely at 64 byte offset, was 56);
  * pick Acked-by from Jakub;
* 2: RB from Jakub;
* 3: move the assignment out of the condition check :p (Jakub).

From v2[7]:
* 1: remove napi_id duplication in both &gro_node and &napi_struct by
     using a tagged struct group. The most efficient approach I've
     found so far: no additional branches, no inline expansion, no tail
     calls / double calls, saves 8 bytes of &napi_struct in comparison
     with v2 (Jakub, Paolo, me);
* 4: improve and streamline skb allocation fails (-1 branch per frame),
     skip more code for skb-only batches.

From v1[8]:
* use a standalone GRO instance instead of the threaded NAPI (Jakub);
* rebase and send to net-next as it's now more networking than BPF.

[5] https://lore.kernel.org/netdev/20250205163609.3208829-1-aleksander.lobakin@intel.com
[6] https://lore.kernel.org/netdev/20250115151901.2063909-1-aleksander.lobakin@intel.com
[7] https://lore.kernel.org/netdev/20250107152940.26530-1-aleksander.lobakin@intel.com
[8] https://lore.kernel.org/bpf/20240830162508.1009458-1-aleksander.lobakin@intel.com
-- 
2.48.1


