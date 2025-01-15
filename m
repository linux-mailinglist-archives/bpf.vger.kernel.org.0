Return-Path: <bpf+bounces-48944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0184EA1273A
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 16:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143801888553
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 15:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866ED16A92E;
	Wed, 15 Jan 2025 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLReDJWO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F87C1D5141;
	Wed, 15 Jan 2025 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954414; cv=none; b=PLbzg563tDcXi+968yQflq9LoD7YGG1hH9xOdId4aQ9uM/y6gW/iqi9mrjzAolQ5mdFNAs+ayN2DOOLieti4SOTufEDS6cPrgAVxeaZfNn7P0G8Ltu7gJMO0Mks3eEifjWD30Rey9/AMBPBIGDG9RZUdAjIEB7hDM4h4wqr+vyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954414; c=relaxed/simple;
	bh=gYThw4IhgAdjQNMaa4ehGdflq3N1o9M5hYC6GD2Idn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6TBEGFwoYkz1MW8N0P6X4Ol5kh2MMVYO2EI1ZFqLjqDn3Y2NkdhS4buSLBa/BniNjKRjj+/C7Xv8U88X+aPDC4FNxpOX8OEZW+hWHjTt0iY+OGkBIT4JZOj1pzkBxK3SzQDu3kclE32NZqHIXHINUEgKgUrcUZcqUMD3RfqNo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLReDJWO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736954413; x=1768490413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gYThw4IhgAdjQNMaa4ehGdflq3N1o9M5hYC6GD2Idn8=;
  b=GLReDJWOeDs/+t4IUGC/++eWzqe18tqFjXfCyLDXX3sDye7fL6MJeOaK
   Ln3CI997Du6aOmjaawEEyiQTSPpNcduRZC7M5MDo2bAR000lk3ZW+Uf3s
   tMeLIFhfqSAFqfVhBln/VPnJW4RAc3avYWrKL4+sx0XaNvAQwIVwEi+Ns
   TMXap7nopFFz4qFCECol8Xot67JqrM9k/ivMPStk6jeo2XycEem/CfFSI
   VyksFZA6sFchEj3Ycuf/jcgoyz60m0zU4fAeiPuyQFK6rV3qYGEpJzGQe
   OO3sa8IrU2+r5Qp/lFsZ29/eKYBalEWYjoMIO5H4tLuAewJpvECClaxnM
   w==;
X-CSE-ConnectionGUID: 9Oy/yLEpRs+6yulYT+dydw==
X-CSE-MsgGUID: 5s2Rf1XFR1qOKRiAFROc8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37451863"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="37451863"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 07:20:12 -0800
X-CSE-ConnectionGUID: LDYTDqRxTKKxPBFqu6CjZQ==
X-CSE-MsgGUID: V9ZyurDcR8O5d0YAEUF4vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="105116708"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa007.fm.intel.com with ESMTP; 15 Jan 2025 07:20:09 -0800
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
Subject: [PATCH net-next v3 8/8] xdp: remove xdp_alloc_skb_bulk()
Date: Wed, 15 Jan 2025 16:19:01 +0100
Message-ID: <20250115151901.2063909-9-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only user was veth, which now uses napi_skb_cache_get_bulk().
It's now preferred over a direct allocation and is exported as
well, so remove this one.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp.h |  1 -
 net/core/xdp.c    | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 6da0e746cf75..e2f83819405b 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -344,7 +344,6 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct net_device *dev);
 struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					 struct net_device *dev);
-int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp_t gfp);
 struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
 
 static inline
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 67b53fc7191e..eb8762ff16cb 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -619,16 +619,6 @@ void xdp_warn(const char *msg, const char *func, const int line)
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
2.48.0


