Return-Path: <bpf+bounces-38568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C61189666BD
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 18:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824B7283811
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 16:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F9F1B3B08;
	Fri, 30 Aug 2024 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vp7BOhho"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F121F942;
	Fri, 30 Aug 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035140; cv=none; b=DDOAgnW42xVE73foOfK5ophdl8SMKqkHohrGStu0+M2wZ/yfHQIdOj7ZjWHySespyfbp5cm/UJqS/JEKt+I2kAzC/XAi2VCYhf6P8xRhp5FyuFa9X8gb6MF2kpzc+tgrBRq3nzzVTRf0shkzGvDGp2R5q5IPGXSe3NEXNPvH9+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035140; c=relaxed/simple;
	bh=QKQd4OO54cY06mKFo8bq2agEDnOyPynVHO6T9olXObk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tp/YzkDyaTG7QRaO0RY3OJWCBXO6gLJrJ9pRTuRq94xk+6rNRk6ffDQTDFdoEEtaP2Xhmf7yZgutVh0IKRwh1GVUK9AMqIw3XB318gZuMebMDDB0O8OKDax62NqRfSVrt2ZtODsmJ6YaGJ8X1DcXJlG+Fi79v/COkp3UmchfvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vp7BOhho; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725035139; x=1756571139;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QKQd4OO54cY06mKFo8bq2agEDnOyPynVHO6T9olXObk=;
  b=Vp7BOhhobOzLvI0OjqrnTVZbH1+B9o8K806uPGu0H2DYZkt3/EGbw5UB
   iGzDn4HvsHeCqvgus4sT9GQmksWJh02t6n1Ee6fh1mWzcrDh2OugGNx0p
   e5gT/Mq6LnhVyPRvh+Jzf+mAkgQgURVReHsynvWgS/qJmK19tDXmL7tlk
   5fFIjH+wnO4DRUvCDPiiKFViZo+kEqW7SbRYvX7NxTVwKyoNoY/RvpsAP
   m8A0TAKjDFGBXWpY6j6lsUFgU9vakeDe/9tlZugUrR1+6otHoKEUP2BkY
   wQtTdc7t+oCinfRMCBnmFmyLYsuROWWUTXQF6vMgXXHUbjSgmKEcWgltY
   A==;
X-CSE-ConnectionGUID: po6Uc2idTFiG+ZKnkSBu5A==
X-CSE-MsgGUID: BLcKFJi5SRW2DaH+CkLxXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="49068870"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="49068870"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:25:38 -0700
X-CSE-ConnectionGUID: hrKFKfYSQ/adBhXf5pqw+A==
X-CSE-MsgGUID: Z8+XxyUiTGCFXGXg88XA8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63996431"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa009.fm.intel.com with ESMTP; 30 Aug 2024 09:25:34 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/9] bpf: cpumap: enable GRO for XDP_PASS frames
Date: Fri, 30 Aug 2024 18:24:59 +0200
Message-ID: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently, I've been looking through my old XDP hints tree[0] to check
whether some patches not directly related to hints can be sent
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

* patches 1-3: allow creating CPU-pinned threaded NAPIs;
* patch 4: switch cpumap from a custom kthread to a CPU-pinned
  threaded NAPI;

Additional improvements:

* patch 5: optimize XDP_PASS in cpumap by using arrays instead of linked
  lists;
* patch 6-7: introduce and use function do get skbs from the NAPI percpu
  caches by bulks, not one at a time;
* patch 8-9: use that function in veth and remove the one that was
  superseded by it.

My trafficgen UDP GRO tests, small frame sizes:

                GRO off    GRO on
baseline        2.7        N/A       Mpps
thread GRO      2.3        4         Mpps
thr bulk GRO    2.4        4.7       Mpps

1...2 diff      -17        +48       %
1...3 diff      -14        +75       %

Daniel reported +14% of throughput in neper's TCP RR tests[2].

[0] https://github.com/alobakin/linux/tree/xdp_hints
[1] https://lore.kernel.org/bpf/cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com
[2] https://lore.kernel.org/bpf/merfatcdvwpx2lj4j2pahhwp4vihstpidws3jwljwazhh76xkd@t5vsh4gvk4mh

Alexander Lobakin (7):
  firmware/psci: fix missing '%u' format literal in
    kthread_create_on_cpu()
  kthread: allow vararg kthread_{create,run}_on_cpu()
  bpf: cpumap: reuse skb array instead of a linked list to chain skbs
  net: skbuff: introduce napi_skb_cache_get_bulk()
  bpf: cpumap: switch to napi_skb_cache_get_bulk()
  veth: use napi_skb_cache_get_bulk() instead of xdp_alloc_skb_bulk()
  xdp: remove xdp_alloc_skb_bulk()

Lorenzo Bianconi (2):
  net: napi: add ability to create CPU-pinned threaded NAPI
  bpf: cpumap: use CPU-pinned threaded NAPI w/GRO instead of kthread

 include/linux/kthread.h              |  51 ++++---
 include/linux/netdevice.h            |  35 ++++-
 include/linux/skbuff.h               |   1 +
 include/net/xdp.h                    |   1 -
 drivers/firmware/psci/psci_checker.c |   2 +-
 drivers/net/veth.c                   |   3 +-
 kernel/bpf/cpumap.c                  | 210 ++++++++++++---------------
 kernel/kthread.c                     |  22 +--
 net/core/dev.c                       |  18 ++-
 net/core/skbuff.c                    |  62 ++++++++
 net/core/xdp.c                       |  10 --
 11 files changed, 251 insertions(+), 164 deletions(-)

-- 
2.46.0


