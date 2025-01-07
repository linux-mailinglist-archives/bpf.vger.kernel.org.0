Return-Path: <bpf+bounces-48135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFE9A044A0
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 16:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0AC166AC3
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB6F1F7064;
	Tue,  7 Jan 2025 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APWW3StN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387FB1F4276;
	Tue,  7 Jan 2025 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263912; cv=none; b=Z4C2mtmeCsn3dbhapXQ07p8bsjLDsF+2kOHaD7u/HLXd5RTNWY4jBZbM9nZx9UJJaB3RzLw7dL9qBTeha7uleWGiyzlD48gIbF/xAkqfoQeBFXgXdxEetY8p+Ro64JJ0kiGs+VXaUyM96jESQuO715p5LihFRIxX1aNpBvQu1oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263912; c=relaxed/simple;
	bh=02kZtbtipIWVTWFg7jgWGOul0B8zGr6oxzoMcfkW5U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eiQwle3aH5b6hB4Oi5gDkTfiecKH48/flxJ66UyU54KFli0WkkMt3/Va0OvfXWacviFsAfypEneElva9dZVuayJ0+UKTvUOFF044uAILc9jGZ4s5ywR7myWkybslAfiE6kbo3L+joyLnzdgWHY1vB/SaPFd4bpfuvC1EkgLMs5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APWW3StN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736263909; x=1767799909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=02kZtbtipIWVTWFg7jgWGOul0B8zGr6oxzoMcfkW5U4=;
  b=APWW3StNxbi49///Ry3zcuacxr76YSB0poC7/hrsCSTMVkP+/l14A4gb
   3eRKO13K5e6jO6yWaMg4q4KMlnffYRazIk65+t76xcOnM9NZ4F71OXrSr
   Z0Q/bqk4I3cjHymdJoR7x5eDo8+JywkyJu9oFgqtgIjkdSbREtdeyQGON
   JRr6M7331lG7Mf/ku9CngLO2Dmc0bAAc0fiJOgV95+zbyoOeDccRtjrhe
   c1LiD4bjv1kvvA9jYHTud+kpMFQLhwYyv4qX8QG47lWu5ZEzprDAqNjHY
   Z51qtbXlyBqZQK5WH2z37heLSHlSylu41WgbTsNKfTi/oKvl4qUZfPm8J
   Q==;
X-CSE-ConnectionGUID: FfyrkbRuQKS59eTBliu3UA==
X-CSE-MsgGUID: 8B3XdXEqRDKN7D3abgyclw==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="35685915"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="35685915"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 07:31:39 -0800
X-CSE-ConnectionGUID: Q6Imvzp/TniSvLBViwAYpw==
X-CSE-MsgGUID: n+pHpbs5S5+aC992Y7kejw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103646975"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 07 Jan 2025 07:31:35 -0800
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
Subject: [PATCH net-next v2 8/8] xdp: remove xdp_alloc_skb_bulk()
Date: Tue,  7 Jan 2025 16:29:40 +0100
Message-ID: <20250107152940.26530-9-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107152940.26530-1-aleksander.lobakin@intel.com>
References: <20250107152940.26530-1-aleksander.lobakin@intel.com>
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
2.47.1


