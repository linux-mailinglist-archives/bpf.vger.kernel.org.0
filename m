Return-Path: <bpf+bounces-50679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC90A2AFD0
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 19:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 718547A3727
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 18:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D77319DF4F;
	Thu,  6 Feb 2025 18:06:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A7719D062;
	Thu,  6 Feb 2025 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865165; cv=none; b=Q9y64jH62ps48mwH1o7FTpggmBpHKk9gAMDHUSMo7tz0PkeRvq3JEa3wM0qYRiePKL55mk/xYeu7llvbW9gsN6YxhqOnOKjHAWaSiCklEYoMlWnFH/3Tr4K6s6Wefv/b9cV3iWAHFMIAqy+9UQ2oUpfy8OjfhczI2F6Cj42N0s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865165; c=relaxed/simple;
	bh=RCN4JyDQaZ/01O2yrW7rKLv42aK+2wGHcwKxrJeCgjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XAkCBVi75R6l+lhtSogxT42AnyaeP3p6bJemLeb7mK+9JwZupDUw5qS9yPHJwgEsXfzpAi4KDl0kdK464ztb+/7rIWh9MdMzccuEHht5Nic28dUgNXUB0sYSAD4I/aHc68q9bxvoYamZPyAy74bLfLjI5NlCrtlEhl4u1nOpRfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ecsmtp.an.intel.com; spf=none smtp.mailfrom=ecsmtp.an.intel.com; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ecsmtp.an.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.an.intel.com
X-CSE-ConnectionGUID: Avbi0IbgRMSbS4pkmo51EQ==
X-CSE-MsgGUID: KiZv3842RVaIkiSWacAJTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38716727"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="38716727"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:06:04 -0800
X-CSE-ConnectionGUID: bMMqnKo8SrutgQUqD9zgVA==
X-CSE-MsgGUID: GEU7bGbAS363/pVUtu1vDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134527257"
Received: from anls2093.an.intel.com ([10.123.15.112])
  by fmviesa002.fm.intel.com with ESMTP; 06 Feb 2025 10:06:03 -0800
Received: from aus-labsrv3.an.intel.com (aus-labsrv3.an.intel.com [10.123.116.23])
	by anls2093.an.intel.com (Postfix) with SMTP id 555DA1007560;
	Thu,  6 Feb 2025 12:06:01 -0600 (CST)
Received: by aus-labsrv3.an.intel.com (sSMTP sendmail emulation); Thu, 06 Feb 2025 12:06:01 -0600
From: "sreedevi.joshi" <joshisre@ecsmtp.an.intel.com>
To: edumazet@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	almasrymina@google.com,
	asml.silence@gmail.com,
	lorenzo@kernel.org,
	aleksander.lobakin@intel.com,
	chopps@labn.net,
	bigeasy@linutronix.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Sreedevi Joshi <sreedevi.joshi@intel.com>
Subject: [RFC PATCH net 1/1] net: check transport_header before adding offset
Date: Thu,  6 Feb 2025 12:05:51 -0600
Message-Id: <20250206180551.1716413-2-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250206180551.1716413-1-sreedevi.joshi@intel.com>
References: <20250206180551.1716413-1-sreedevi.joshi@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sreedevi Joshi <sreedevi.joshi@intel.com>

skb_headers_offset_update() adds offset to the transport_header
of skb without checking if it was set. When the transport header
is not set, it's value is 65535. Adding offset to this causes it to
roll over and makes the transport_header value to be less than
network_header.
When a tc ingress hook is attached and it invokes bpf_skb_change_tail()
(to strip off extra bytes at the end of packet or to attach some
extra bytes), the logic in __bpf_skb_change_tail() that calculates
the min_len fails due to the transport_header being incorrectly set.

This issue was discovered when testing with veth interface with both xdp and
tc ingress hooks are attached. veth_convert_skb_to_xdp_buff() calls
skb_pp_cow_data() and it results in this function being called. Since
transport_header is incremented without checking, it results in the condition
where transport_header < network_header. __netif_receive_skb_core() when it
receives this skb, skips reset of the transport header as it is already set.

This is specific to XDP path. When there is no XDP hook, the logic takes a
different route (__netif_rx()) and the reset of the transport header happens in
__netif_receive_skb_core() before it reaches tc ingress hook.

Fixes: f5b1729443fd ("net: Add skb_headers_offset_update helper function.")
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
---
 net/core/skbuff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a441613a1e6c..79b10abd95f1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2098,7 +2098,8 @@ void skb_headers_offset_update(struct sk_buff *skb, int off)
 	if (skb->ip_summed == CHECKSUM_PARTIAL)
 		skb->csum_start += off;
 	/* {transport,network,mac}_header and tail are relative to skb->head */
-	skb->transport_header += off;
+	if (skb_transport_header_was_set(skb))
+		skb->transport_header += off;
 	skb->network_header   += off;
 	if (skb_mac_header_was_set(skb))
 		skb->mac_header += off;
-- 
2.25.1


