Return-Path: <bpf+bounces-50542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D54F4A296A4
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 17:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC721882C13
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A4D1FECBB;
	Wed,  5 Feb 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/wbPNQr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC4E1FCF63;
	Wed,  5 Feb 2025 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774007; cv=none; b=ua9z97edMPQCt7YxyqRkITdQMh/t82KDB6X4lcsirR51+EhNEY93YwdBV27wAz0W6KGPlUYlxzM9k84rsQVYu9PKb8ewq//PT9XUN4zoBInAq6zfJ1/WRZUhawSGMwDk/E4qkVlYNk3UK1BXx9oVpXDNy7V9+cvOHFXxOKJDcok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774007; c=relaxed/simple;
	bh=EDUd8AUDXZD+TVEFowQGG4u/w1Xjx6TUQuNUxP09fkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqHByadauyI7CxNoT6jy7bml7zgxMwpGo9+wkQ7Tu+LSZXPWjFPuNSpERJ/ZmN2/pagK1MiRaoJT9/nq/Nb6VJDIum+LwNnIeSegQzHUZ9GfMo6FHgS0EfP5g+n53oZWGRqYO3CHMPW8TgkxEag4MVMbu2/FqgjPXudB9pA4uU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/wbPNQr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738774006; x=1770310006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EDUd8AUDXZD+TVEFowQGG4u/w1Xjx6TUQuNUxP09fkg=;
  b=i/wbPNQrpmS0IlxkU9wqlfTa6UztjCNh7F7JQ9MhbmFD2FAWGU9UcHtd
   KqrSD9OcRB7+rIEVEU0SovRFDna625YEELsimDWPQxSkm1ThHA3xGBAMT
   j3sUrsV0Pysnmt0EYiTq25ow2LdSwre/TI253QmckfCZPo/HznxPNTcOA
   9GmiebvUifHis0DtpxhFsjgSnDxNnwVP+Ql+CJruLL81hcklXeY19mA53
   qNb58Ow+kivg+1OH4dNuEgrGpSRWxSvPypZPzoPwaP9y/ba/jRBHk/sZf
   18SWeuWum1BR5DgZOlmV08faEWXCjuPOhu3/YqQJyAFgSAr18aCa8dFvA
   Q==;
X-CSE-ConnectionGUID: YyANVcUZTriBuh1Nce15lA==
X-CSE-MsgGUID: n0xYfkZAQZyeQ7ZUafdewg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50741194"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="50741194"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 08:40:23 -0800
X-CSE-ConnectionGUID: rhcFTesQQ1qklFGQYzXS6g==
X-CSE-MsgGUID: 0sm3FrgjTVyBBvPAKZs7OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="110742149"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa009.jf.intel.com with ESMTP; 05 Feb 2025 08:40:19 -0800
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
Subject: [PATCH net-next v4 8/8] xdp: remove xdp_alloc_skb_bulk()
Date: Wed,  5 Feb 2025 17:36:09 +0100
Message-ID: <20250205163609.3208829-9-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205163609.3208829-1-aleksander.lobakin@intel.com>
References: <20250205163609.3208829-1-aleksander.lobakin@intel.com>
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


