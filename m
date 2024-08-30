Return-Path: <bpf+bounces-38577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCAC9666D8
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 18:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC671F2261D
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 16:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEF71BE236;
	Fri, 30 Aug 2024 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SybPVICr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080251B9B2E;
	Fri, 30 Aug 2024 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035173; cv=none; b=mcGsbykYF5miimUbUm2PhFQkI9msDx1UIPjLq3gRa6vta9TmJF1WBeMSXgVH/t69Z07VU4JZqiGXkew/KiK/X5j7qStVdzxexxRUMpbr53S4Ssv6EhOpdhJxCAVFgN5aWgRDTzqo6SdhtEuBlmvzIjv9KSmyCZWiQkslPJRQMdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035173; c=relaxed/simple;
	bh=/VslWGAIDy5p/4CWQoCT3JSpikohdk4tCvhbyE0xCgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLLEK63EWs/YEDgnkgZFkD/DY/yGiOWa3yhEAibZgr/XHHEwVzIaoy5Cp/SvzyxeLJr5kCJQ9F3Pq98lHPN4XH1nLIGN4vqjcTkyP/S0HsLfufH3gUgaXyuMrqOeNlAC+Ch74deddMw7oQnfbjEwZvKf+agj3O7mVG5mPxUiwwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SybPVICr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725035173; x=1756571173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/VslWGAIDy5p/4CWQoCT3JSpikohdk4tCvhbyE0xCgQ=;
  b=SybPVICrZUBjLieyFAfRtUMGmaFDj+s9zvRwKaYJ43JS1rFvr7fhjftM
   mzOGEw1q1ZNkD5SR8b0Wh6gP43vb5SscS8soL+nSm+CcG3Kp04AcefBQ5
   6yut8rHDHtzbRMNjjHvMNoO0smqtS9XF5abtO9z08GkQ5lfgm8OC9emXb
   rirF3E7ndfK/BtBTiIyFuK8EinGgM63Su+fblSZ5RkELBlqiMMzBxMDKK
   F0v8p9pN0w4s/8jcvcukAJh46NktWY5chN3sO0RUkhw6HH1jtpbP2oRFZ
   X+kNRIoC7LQeniHsjPqf9Jct3yrj6AzcmNAqeASIllaoPy1EYQd0R3Fkj
   g==;
X-CSE-ConnectionGUID: EcDHOY1fRby5UZfeSQG8JQ==
X-CSE-MsgGUID: umX4z53uTy+RfnrRSyCD6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="49069021"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="49069021"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:26:12 -0700
X-CSE-ConnectionGUID: DlCb8T8HRxWFJcV8eb1G9g==
X-CSE-MsgGUID: NzvQYEt2SN2w+Owk9Sjh7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63996508"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa009.fm.intel.com with ESMTP; 30 Aug 2024 09:26:08 -0700
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
Subject: [PATCH bpf-next 9/9] xdp: remove xdp_alloc_skb_bulk()
Date: Fri, 30 Aug 2024 18:25:08 +0200
Message-ID: <20240830162508.1009458-10-aleksander.lobakin@intel.com>
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

The only user was veth, which now uses napi_skb_cache_get_bulk().
It's now preferred over a direct allocation and is exported as
well, so remove this one.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp.h |  1 -
 net/core/xdp.c    | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index e6770dd40c91..bd3363e384b2 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -245,7 +245,6 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct net_device *dev);
 struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					 struct net_device *dev);
-int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp_t gfp);
 struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
 
 static inline
diff --git a/net/core/xdp.c b/net/core/xdp.c
index bcc5551c6424..34d057089d20 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -584,16 +584,6 @@ void xdp_warn(const char *msg, const char *func, const int line)
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
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct sk_buff *skb,
 					   struct net_device *dev)
-- 
2.46.0


