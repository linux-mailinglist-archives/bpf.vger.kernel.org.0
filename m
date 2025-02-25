Return-Path: <bpf+bounces-52552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5B8A44839
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCFA883B45
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C9820C46B;
	Tue, 25 Feb 2025 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/SPPYSa"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5977B20B7EB;
	Tue, 25 Feb 2025 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504305; cv=none; b=tP1jDjokO48IErXtrk0q3bRCk1chTDvJLMPa1KITDQardabx6G4GSHHaHD2fZMX+nFoxUp1d4Uo+KB2NeLOVM+tttoTA1XfSjNzZaj9jFLpSr3ZHlltwcDsquhhqaMDz9y3xX3+pJCoV0ok1dOavUxV9WfE6fb13sRni3e6FH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504305; c=relaxed/simple;
	bh=at5laq0S9A36ZUKWkzLRYRU1WS5EvH7bROwshhyGo7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWwqVbnjYhkzmIZ7O9BqThfRXSVQOVZ3MD/vjdka8RUtfa+BazD+Ff+HbKK9DaR/uYcfHU54TousfxhakQAsei1FIebLODegPkiZZMUPyn/ktAC1w+dEqd6CSGRjjBTpOeHBiu1wJUQvACwLc0PvNjkQsVZc+ncmiZ7FaNulizs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/SPPYSa; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740504304; x=1772040304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=at5laq0S9A36ZUKWkzLRYRU1WS5EvH7bROwshhyGo7I=;
  b=Y/SPPYSa5u5SlKi2YFlPg6TnlipCSrjgPqXEm8QpMz1eGzpiUr9pQzEO
   q3nCWO+d6W1qDLUH0lxVJED+B41LWAak7Yic974vgsguEpnhk8oiu8U8u
   odprvuba4mjNVZ8Y4m2lNp/qkrYHw3RljLHcIecofqA9TJaTZVMfQSJ+M
   M8750+L9pr6DMlqAXM31tMtB5MJ7JZLzNhsBfPk7atJaJBy6QzKsVDArq
   tWP2Kn7AkLJ/RMG8YJ3fjOoRsCm6C88dxSU2gAWrzUxlztBE0UJ0BsIIU
   XhiujVteM1/UhnJWaQK08UgB7nrw8RKRwTx2AKrve6XUvWSGQUxJypVMl
   A==;
X-CSE-ConnectionGUID: IfiCmn0xTXW8M5qouJnWbw==
X-CSE-MsgGUID: vuCeZMGnQWibt4ZOWBk/eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="44974176"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="44974176"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 09:25:03 -0800
X-CSE-ConnectionGUID: Eg4S//TrToKvxow8ua6KIg==
X-CSE-MsgGUID: yHyj/RFTRcSyC4hdVNNdug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116256968"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa006.fm.intel.com with ESMTP; 25 Feb 2025 09:24:58 -0800
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
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v5 7/8] veth: use napi_skb_cache_get_bulk() instead of xdp_alloc_skb_bulk()
Date: Tue, 25 Feb 2025 18:17:49 +0100
Message-ID: <20250225171751.2268401-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225171751.2268401-1-aleksander.lobakin@intel.com>
References: <20250225171751.2268401-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that we can bulk-allocate skbs from the NAPI cache, use that
function to do that in veth as well instead of direct allocation from
the kmem caches. veth uses NAPI and GRO, so this is both context-safe
and beneficial.

Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/veth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index ba3ae2d8092f..05f5eeef539f 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -684,8 +684,7 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *rq, void **frames,
 	void *skbs[VETH_XDP_BATCH];
 	int i;
 
-	if (xdp_alloc_skb_bulk(skbs, n_xdpf,
-			       GFP_ATOMIC | __GFP_ZERO) < 0) {
+	if (unlikely(!napi_skb_cache_get_bulk(skbs, n_xdpf))) {
 		for (i = 0; i < n_xdpf; i++)
 			xdp_return_frame(frames[i]);
 		stats->rx_drops += n_xdpf;
-- 
2.48.1


