Return-Path: <bpf+bounces-67647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 684DFB46680
	for <lists+bpf@lfdr.de>; Sat,  6 Sep 2025 00:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8091B7C5167
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 22:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C191284684;
	Fri,  5 Sep 2025 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/t+P5+O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34B827CCEE;
	Fri,  5 Sep 2025 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110550; cv=none; b=Tg040FRhERrDvNNbqsWMbKX+MrPFO4phi6hOm2UGrrrPx2rIQWf0Ix6AxiZI5l5CNPhHfbHIOoyFEdG9mc09zOfOFRYbaZ20+H0j9g9LVWKE/ZEUQMIZmLZ3ZbPkirrLvowSiJ7Dg57l5wbxKkqaqUqFK79jZD02pTQIQ1DU5yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110550; c=relaxed/simple;
	bh=RmPWHSmTFGED2+phg1IDhj1Eqmc+Ugmbit9TQn6jp4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpg8hzuWezgHmrSNKrktrCbysrosfcvwiGNPfL/lwW1mKjCHq4CNrv3uAZVoyvdr6S4DFtLXYKL4SJX6SLmdPyKSSMx6znOlL3TbyPSqEAJFlZm358rVPiMrsdFv/dN/doVORs25rGR40Xy8XDtUAdp/N4UCajAkjX6J8ZJ2yhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/t+P5+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF60C4CEF9;
	Fri,  5 Sep 2025 22:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757110550;
	bh=RmPWHSmTFGED2+phg1IDhj1Eqmc+Ugmbit9TQn6jp4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/t+P5+OyhlFwueXEx46sUCxJRrNWV6Vgl1v8Fduoir2KKM50H363p2mrkLiIA5kF
	 dE4kJFlF4a7QZwmD79qCygMsvE8dj4+QkGocn+kTzfE3kuwEBPjylTuTaTJPoJVlpw
	 81RWN3jNeN2MA+MCraGq8+0X4uGdFbKRShTpxrw/bg7ch0nx36mukHLypQhidiV5gy
	 PfUaxf5Sa/iI/KlzkgiianppvcQJRYX7FJvfkzuFhWLRdeebB2FqWyKUumJFq0PLSb
	 H+ZtO4qj+05WudCpSNUmxguilyP8BzHlBB9I314aQAruZnBNZ/9TT3nFGxif7vD2ou
	 aqWAmdm0CabGg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	michael.chan@broadcom.com,
	anthony.l.nguyen@intel.com,
	marcin.s.wojtas@gmail.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	jasowang@redhat.com,
	bpf@vger.kernel.org,
	aleksander.lobakin@intel.com,
	pavan.chebbi@broadcom.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] net: xdp: handle frags with unreadable memory
Date: Fri,  5 Sep 2025 15:15:39 -0700
Message-ID: <20250905221539.2930285-3-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905221539.2930285-1-kuba@kernel.org>
References: <20250905221539.2930285-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't expect frags with unreadable memory to be presented
to XDP programs today, but the XDP helpers are designed to be
usable whether XDP is enabled or not. Support handling frags
with unreadable memory.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/xdp.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 57189fc21168..98f984d8f2c6 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -76,6 +76,11 @@ enum xdp_buff_flags {
 	XDP_FLAGS_FRAGS_PF_MEMALLOC	= BIT(1), /* xdp paged memory is under
 						   * pressure
 						   */
+	/* frags have unreadable mem, this can't be true for real XDP packets,
+	 * but drivers may use XDP helpers to construct Rx pkt state even when
+	 * XDP program is not attached.
+	 */
+	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
 };
 
 struct xdp_buff {
@@ -109,6 +114,11 @@ static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
 	xdp->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
 }
 
+static __always_inline void xdp_buff_set_frag_unreadable(struct xdp_buff *xdp)
+{
+	xdp->flags |= XDP_FLAGS_FRAGS_UNREADABLE;
+}
+
 static __always_inline u32 xdp_buff_get_skb_flags(const struct xdp_buff *xdp)
 {
 	return xdp->flags;
@@ -248,6 +258,8 @@ static inline bool xdp_buff_add_frag(struct xdp_buff *xdp, netmem_ref netmem,
 
 	if (unlikely(netmem_is_pfmemalloc(netmem)))
 		xdp_buff_set_frag_pfmemalloc(xdp);
+	if (unlikely(netmem_is_net_iov(netmem)))
+		xdp_buff_set_frag_unreadable(xdp);
 
 	return true;
 }
@@ -328,6 +340,7 @@ xdp_update_skb_frags_info(struct sk_buff *skb, u8 nr_frags,
 	skb->data_len += size;
 	skb->truesize += truesize;
 	skb->pfmemalloc |= !!(xdp_flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
+	skb->unreadable |= !!(xdp_flags & XDP_FLAGS_FRAGS_UNREADABLE);
 }
 
 /* Avoids inlining WARN macro in fast-path */
-- 
2.51.0


