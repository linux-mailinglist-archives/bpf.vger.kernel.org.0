Return-Path: <bpf+bounces-50541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0892A296A0
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 17:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62D2A7A22EC
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101181FE47E;
	Wed,  5 Feb 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDIaTMQF"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43221FCCF5;
	Wed,  5 Feb 2025 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774007; cv=none; b=kkpym9vNVfsMfXrahSLBFzvpgMepHS1qPVGsjzpR3vl1OQslsSxHqAqF0vicxKb7TxmzMgKKs7yOYcmTRGcagkJzm7K4Rq+4Iae74dbn0WA0MBykOg0RnUvyYb/bd5UkURncN3ZoiM484RRqMDLH1N4+r54tHAQNDQGf8aqzMUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774007; c=relaxed/simple;
	bh=yMTi/eHSCrHgYObNLZrnZrLZfYvACho+NdeyUKC600k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uwOXC92AZ8p4UWMVFnApfxw3dY4fmlGJsgjxKkUlnKo+rfy3XojsT5paTnwOfUmqI0eE0vSG7/egCICJq88sRwG+q20ZzgJWWerXpHorMWreEj4uu3HtlchjHi2SU8ShKjzmj9nQbmx25u7UIgV052Vu0SEs92Ygsq5ZIrWikyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDIaTMQF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738774006; x=1770310006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yMTi/eHSCrHgYObNLZrnZrLZfYvACho+NdeyUKC600k=;
  b=nDIaTMQFkpvbTbSgb2HRBojiKhRIc0bZFad1OiIyzwVysebpbZI5T1Xz
   5pdCyHSW1DdFwUG0XHS5yc65yq16GdxbbvMXfYw6jWATC9TkpUFXPe2vl
   FSnlHBejONzANL+Jn7F/pLDYP8JOFhfcqJruTluLaOyfyzmaac+hF6iBm
   QwldEe65fUek9Mo9/Nn1tbOO7rabtFfGBuq+8UZ7mBAzoR/hRlxhUMRiN
   IPl6d69J5PVT81BQLiyJs4HZdRJ7w0ldM8mtkqunGwuNR4L8Nq+pmZX/q
   KKG4MEpUu6bn92UFL6sJuZ149P1V93GM2PxQtdwgg6K0sCqeHjduPbGGZ
   Q==;
X-CSE-ConnectionGUID: +mL13FCjSxidz60IRowxag==
X-CSE-MsgGUID: GV/vvaebQhmo/KWFOmHodA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50741168"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="50741168"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 08:40:18 -0800
X-CSE-ConnectionGUID: aR3e1rzEQ0OIx+y2C3zGUw==
X-CSE-MsgGUID: rK8SGC2QTXy0KMmK/QW0Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="110742092"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa009.jf.intel.com with ESMTP; 05 Feb 2025 08:40:14 -0800
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
Subject: [PATCH net-next v4 7/8] veth: use napi_skb_cache_get_bulk() instead of xdp_alloc_skb_bulk()
Date: Wed,  5 Feb 2025 17:36:08 +0100
Message-ID: <20250205163609.3208829-8-aleksander.lobakin@intel.com>
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
index 01251868a9c2..7634ee8843bc 100644
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


