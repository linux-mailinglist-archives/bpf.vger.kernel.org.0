Return-Path: <bpf+bounces-69228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8238EB91E5D
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 17:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE0A16D0BD
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 15:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962CE2E2DFA;
	Mon, 22 Sep 2025 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iG5D5Sgp"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9D72E2663;
	Mon, 22 Sep 2025 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554790; cv=none; b=oKU3x5SsnZh1vmlLCDuFilYjwQnYcEf6y0gWVNTviDB3nbtz4j3yCSN6V0Rtm1J0Qj103r5pkl9ZZ2QbI8imlRORDZPQ9khwzETaBt95oIk2F/wmkgkHZJMdj4dCKYMpictYrSjTYuxihTu8qJQxI9Xwx3EGurNYOabALHgZWj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554790; c=relaxed/simple;
	bh=QfQv1CRqce2sTfzdg6xdwjsq7WOm99tM9MPylz2yMVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MUB3eQpZld5n80r32bz3fEFeBb7T2ybs5PVzmNMb3Ax0aW1KVb+yQdQNVMWaWhOSQZ2nuVrGp9vT9bPW19/duFx3vocGeyPW7GW+vgokKR2yMA/YfCduzIDWEJF6Q/FCCGC5Jj5hYq0RduTyFM8eDn6nJIjSXD5M0RfoABf0ZsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iG5D5Sgp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758554789; x=1790090789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QfQv1CRqce2sTfzdg6xdwjsq7WOm99tM9MPylz2yMVU=;
  b=iG5D5SgpsdaYbtTFwjibrE4mcclyt+jVxc0Gb1E2U9z3L07YT43+TnfG
   yQCEtJk6ywgW3jq8wZDbLcxk1qPIAg6zuMx+Y06apdn4rVWQdrSSdH29z
   PfLcbQ/YvKWbBSXdvQaxKzHyiQt+93WeBkh2WtOO9QUi6XH2w4JtTlUix
   Cz/yyqBcLREliGhR7x1G01C9eQRefS4TxS8nUomBjHpSnXv+0qLJJU0ni
   sCjPzuQFt2DQzIVH0nNegS5QiFHCOuRJDqU2QsPo2zbbPC3cyZtj26xP1
   E8MXSnRTBLM3Uc2Vl2Zcp3RwzKRCytVEmOGFNhq99Gds42KA6zBE9reKO
   w==;
X-CSE-ConnectionGUID: Rpx0Rw1XSyq6Nt3HCHWtAQ==
X-CSE-MsgGUID: UJuZa3VsTcm4AholnybOCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="63449207"
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="63449207"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 08:26:28 -0700
X-CSE-ConnectionGUID: 79e0kZsjRnSr8W/sRt4heA==
X-CSE-MsgGUID: 9QEo3DGYTCazldnt1fu32g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="207242225"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 22 Sep 2025 08:26:27 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kerneljasonxing@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next 1/3] xsk: avoid overwriting skb fields for multi-buffer traffic
Date: Mon, 22 Sep 2025 17:25:58 +0200
Message-Id: <20250922152600.2455136-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250922152600.2455136-1-maciej.fijalkowski@intel.com>
References: <20250922152600.2455136-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are unnecessarily setting a bunch of skb fields per each processed
descriptor, which is redundant for fragmented frames.

Let us set these respective members for first fragment only.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72e34bd2d925..72194f0a3fc0 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -758,6 +758,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				goto free_err;
 
 			xsk_set_destructor_arg(skb, desc->addr);
+			skb->dev = dev;
+			skb->priority = READ_ONCE(xs->sk.sk_priority);
+			skb->mark = READ_ONCE(xs->sk.sk_mark);
+			skb->destructor = xsk_destruct_skb;
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
 			struct xsk_addr_node *xsk_addr;
@@ -826,14 +830,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 			if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
 				skb->skb_mstamp_ns = meta->request.launch_time;
+			xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
 		}
 	}
 
-	skb->dev = dev;
-	skb->priority = READ_ONCE(xs->sk.sk_priority);
-	skb->mark = READ_ONCE(xs->sk.sk_mark);
-	skb->destructor = xsk_destruct_skb;
-	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
 	xsk_inc_num_desc(skb);
 
 	return skb;
-- 
2.43.0


