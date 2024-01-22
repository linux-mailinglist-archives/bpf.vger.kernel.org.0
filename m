Return-Path: <bpf+bounces-20050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC62837602
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 23:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3102E1F256AC
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 22:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4F44B5A1;
	Mon, 22 Jan 2024 22:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mr3HdGcP"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFD14A9A8;
	Mon, 22 Jan 2024 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961808; cv=none; b=hLuM/PM2y3vUC0KcBlMGGmAi1y/hM+BDAsUsC8jI0Cl9Cehof3HCRdWxMimCUbM8mt8KZc7O3QgV1qO0zwtmXumUAMFaTHlNneeMdY6SiuvWwc6M/giJ+pqrn0PUrVKXKoHlFE4+3UpEpAoYpXWFx6gIpqlTIQiUZXaIkLTcsc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961808; c=relaxed/simple;
	bh=meNYqu0YNaFTAm5+BjD0H0A6IXvQTHaUHm0t63qW7Tc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LP820Gmja4nucco47LYOYqC8ozKR04CbQEPsHRX+T2CfjdsP1amjdFNHk5hH9lLHpa/Nz9Cv6VRQXV/py/leq+0/zP+3ibOq79q3jXfxBbIpftVD0/NjPGht07TVquyFDwGdebSq/1aKRgsQayw9cyCQAXdXl1UK0L0665bDF2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mr3HdGcP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705961807; x=1737497807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=meNYqu0YNaFTAm5+BjD0H0A6IXvQTHaUHm0t63qW7Tc=;
  b=Mr3HdGcPM/NLbJyLkL3UYJy3XhpbmZSUTYz7BLaHv3bYaU0OM9nduCYo
   1+Di69FgeaxrBStmsgctAlXRX1qbCGPlJpWUGOQYcBdHVLRZRB+7qGxq+
   908+HUSPuiAe4mn6FNB4F13epWrCWoDYXyuGqpYzDo8WKsZeGZSSCf3VX
   TDCB6WlXYYmdRdN60EBFkYGU8IKGNjt74ctgIk3nua+umQ/uNR9mDNZcH
   MJAF7YM6wsoBTeiH34ghgZWimcu61jqgbnFScDGwBf7oJfLoRWWo4rch7
   pnsSv6ABY3gHaJOcDb+pv7uAsXtOQWJGcDzj064cVXmM2sTnp6CW1+0IC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="7995639"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="7995639"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 14:16:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="1360783"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jan 2024 14:16:44 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	echaudro@redhat.com,
	lorenzo@kernel.org,
	martin.lau@linux.dev,
	tirthendu.sarkar@intel.com,
	john.fastabend@gmail.com,
	horms@kernel.org
Subject: [PATCH v5 bpf 09/11] xdp: reflect tail increase for MEM_TYPE_XSK_BUFF_POOL
Date: Mon, 22 Jan 2024 23:16:08 +0100
Message-Id: <20240122221610.556746-10-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XSK ZC Rx path calculates the size of data that will be posted to XSK Rx
queue via subtracting xdp_buff::data_end from xdp_buff::data.

In bpf_xdp_frags_increase_tail(), when underlying memory type of
xdp_rxq_info is MEM_TYPE_XSK_BUFF_POOL, add offset to data_end in tail
fragment, so that later on user space will be able to take into account
the amount of bytes added by XDP program.

Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 8e0cd8ca461e..9270b4d7acee 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4093,6 +4093,8 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
 	memset(skb_frag_address(frag) + skb_frag_size(frag), 0, offset);
 	skb_frag_size_add(frag, offset);
 	sinfo->xdp_frags_size += offset;
+	if (rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
+		xsk_buff_get_tail(xdp)->data_end += offset;
 
 	return 0;
 }
-- 
2.34.1


