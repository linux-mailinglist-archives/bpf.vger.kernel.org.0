Return-Path: <bpf+bounces-38576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4019666D5
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 18:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C4B1C23267
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 16:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A24C1BDA9D;
	Fri, 30 Aug 2024 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjS+FLTA"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BE91BD515;
	Fri, 30 Aug 2024 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035169; cv=none; b=HLv43Nd3Xm6OEh63ePzMCAstjENMfEWLZZeZzjLYnujj7sc0bEre4/Q4eBRvYkEck+Ncs0EcXveik7KI3V0dKwx0x9QOAkJ381rVhhFSobQ2hkwkR8W+AZyhb6/l9kGGPSdZkewvjYVmIvrndRQlr1Kn13Hk0dEM3oSFy2qulcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035169; c=relaxed/simple;
	bh=2E5MS1Ol4fcBhQi1/pEkQ0LUv2e4MXiN4O2hZZN3thk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRS6J88ZUWkXNoQytZLc91acRBOf6rDMV3IrPZRXiLtOnAL/l6070pIlwkVSzgXvI9X7lBerdhScZQbf3DsXkyd5TB8FSMBlgASpClpUwy3aNT9Ut9lpIC3xjefKIeOJd91FYBgUnsbICLYGNmpT2Yq98o4tYTkmRaJkJNwz19Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JjS+FLTA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725035169; x=1756571169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2E5MS1Ol4fcBhQi1/pEkQ0LUv2e4MXiN4O2hZZN3thk=;
  b=JjS+FLTA3ojfk9CyR54zOWGEqSBiD/oAXcXcrQayx9veu/BdKoOVC3Yr
   H0V+fd8rJB7oeVJ9ZPwItWO5SW4Zb5nTBtizDgmzApcBwawXkASYAyKfY
   zk4aZUDFNq2Nwuot3c+7RKH4Y3uIbifLA479ll8LLdJ+COiQHhXHrt9Cs
   7EOCTwzBOSROaevfKz6rEoStHbo8lGD9bh8PpiZZjSLWU5nUvgfMtp48V
   b0w4Tw/wEsBb2OUGHwJGxhimHuAWGPuCm69fPkiKFj47G5wNFVlJnxway
   A5NeA2Fkyyto2wmN8bm3JlkN8lslkC1bPIDfALswIYJh7Ly78viJgmCye
   Q==;
X-CSE-ConnectionGUID: wY+YDYe1QPakfxwLIOUMtA==
X-CSE-MsgGUID: TKdNvpd9TNarBS5nS0onlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="49068998"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="49068998"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:26:09 -0700
X-CSE-ConnectionGUID: rLMPYcbcTUKfkmrcVr/nnw==
X-CSE-MsgGUID: LIdNwYpzSpinkdl3soQIyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63996501"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa009.fm.intel.com with ESMTP; 30 Aug 2024 09:26:04 -0700
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
Subject: [PATCH bpf-next 8/9] veth: use napi_skb_cache_get_bulk() instead of xdp_alloc_skb_bulk()
Date: Fri, 30 Aug 2024 18:25:07 +0200
Message-ID: <20240830162508.1009458-9-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we can bulk-allocate skbs from the NAPI cache, use that
function to do that in veth as well instead of direct allocation from
the kmem caches. veth already uses NAPI for Rx processing, so this is
safe from the context perspective. veth also uses GRO, so using NAPI
caches makes real difference here.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/veth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 18148e068aa0..774f226666c8 100644
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
2.46.0


