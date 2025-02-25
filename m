Return-Path: <bpf+bounces-52553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A71A4482B
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95AA8165874
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AAE20DD71;
	Tue, 25 Feb 2025 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrKq7hEh"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29C720CCF1;
	Tue, 25 Feb 2025 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504308; cv=none; b=rR86n/BLaqhLTjFz05G0SBma0w8TmHRxYFdT0pA3auHouVgl3jEdjoiekEVmI7mSLQSggRPHelMAYg47YqDi0tB7dK1qNVl/tzs9rMXa6XAuawYSLJoNeKdBpakllgIzlQuz2Dekpdl1W94auRw4w/8RreKorE3VpMi7RuUpQv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504308; c=relaxed/simple;
	bh=EDUd8AUDXZD+TVEFowQGG4u/w1Xjx6TUQuNUxP09fkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7Ofiv53JEJREBPireXmwhi/jErxwx1fZECS+cSM68F0HamBz6E5YzNM46X3wkvW0yzzBfw93VU2AxmHl7bPvuZaa7Le6nX1KM/z48eKKW652yyYrx7wA6bjG0yWIhAJjHVMwXe9M1V5pBtx87vXZ8DJXBuStsunVCQVroCgguM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VrKq7hEh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740504307; x=1772040307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EDUd8AUDXZD+TVEFowQGG4u/w1Xjx6TUQuNUxP09fkg=;
  b=VrKq7hEhBFK8v1ODLilgV7m7T3TOVryGF7g/kLnEExtR6GnFA4x5tEPv
   FpEvO8ano6catWI+NQxykcPyytvQrk9tNhZ8+q5DOelOHaIvba4eF8ur2
   b6NdKpy0mwI0Q6fDUVKPMqLvjUJjmXXFVlSmCztcbPSNVfj48T1bATfxw
   7kF8i5Xt10vJxuUUqYLBztoRL2Y4rP7D19fT7sVYkUxT10PlnMNKTpjTU
   SbAbOONWJRXzi59hRSR2or7CHXfN+dFKSe5srYOUZANufIP608vh2kp2x
   CKP/O/MeCSjdididspfKsNlaZe/GTa3jbUGeyhg31rJcGZOpBC8Ln70jA
   w==;
X-CSE-ConnectionGUID: +AElUEHhTFKODZkofeJOLw==
X-CSE-MsgGUID: OiUdA/cMSP+7r2E3/6o4oQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="44974197"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="44974197"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 09:25:07 -0800
X-CSE-ConnectionGUID: ZeQFXE/4Qo2Z918geIXl2w==
X-CSE-MsgGUID: 1rbA4SIRRZqqmontmfT0dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116256991"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa006.fm.intel.com with ESMTP; 25 Feb 2025 09:25:03 -0800
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
Subject: [PATCH net-next v5 8/8] xdp: remove xdp_alloc_skb_bulk()
Date: Tue, 25 Feb 2025 18:17:50 +0100
Message-ID: <20250225171751.2268401-9-aleksander.lobakin@intel.com>
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

The only user was veth, which now uses napi_skb_cache_get_bulk().
It's now preferred over a direct allocation and is exported as
well, so remove this one.

Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp.h |  1 -
 net/core/xdp.c    | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 4dafc5e021f1..48efacbaa35d 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -343,7 +343,6 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct net_device *dev);
 struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					 struct net_device *dev);
-int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp_t gfp);
 struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
 
 static inline
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 2c6ab6fb452f..f86eedad586a 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -618,16 +618,6 @@ void xdp_warn(const char *msg, const char *func, const int line)
 };
 EXPORT_SYMBOL_GPL(xdp_warn);
 
-int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp_t gfp)
-{
-	n_skb = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache, gfp, n_skb, skbs);
-	if (unlikely(!n_skb))
-		return -ENOMEM;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(xdp_alloc_skb_bulk);
-
 /**
  * xdp_build_skb_from_buff - create an skb from &xdp_buff
  * @xdp: &xdp_buff to convert to an skb
-- 
2.48.1


