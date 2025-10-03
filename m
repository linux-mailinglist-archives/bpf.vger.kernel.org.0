Return-Path: <bpf+bounces-70358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64847BB8679
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 01:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0123C6A74
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 23:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1710F27B357;
	Fri,  3 Oct 2025 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amfDKPVT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6955B278158;
	Fri,  3 Oct 2025 23:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534257; cv=none; b=u44/Cg5X7RnZa4a1aBS2nyc5IR7IVLMZpyVZkZvQgJhkjJDuMY9QI3Tnl8MH14YgfeVFe2szOpLUFs3bTVPYIFs7TwUfWD6IP7oBcgawby6FPv8E7DAKCPg1bPSAb+or3RANQ3wkJeHUuBV9B0yP+jyQwlCCRTenakaMBw/5h6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534257; c=relaxed/simple;
	bh=FeNLpcaZA4xZuw0anwXZJ831Pe936DwnSYp5C6yeNUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJ9QAp+mLV354AzllcxGNB7jXCe6cwH7+fDqLy7KOxW3dS6jOfKUcgydULMh1EtMMU4SS+ze6Sdayo6+dWwNShD9L0Ly3Kqf1z+Ha6Ofv9ayZqjSPvm5cCdmGImcRDX1ghZNGLN4Ne6YFYNrmmySKTmEUglAOox9aOAJHnZHKqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amfDKPVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C73AC4CEF5;
	Fri,  3 Oct 2025 23:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759534257;
	bh=FeNLpcaZA4xZuw0anwXZJ831Pe936DwnSYp5C6yeNUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=amfDKPVT2KjSYTEJsM9lagxiHHmHmUGk6ruU7A4z8/gnwyv0UPM5OcDTwypu22T9x
	 qa6kuyaJ9j+vtI9n07ccOonFXOxXmZMJDVtbYThdfnUo02WiUvMqFN9wc7PY7Nmkgw
	 jL/7njX5NMbmSlz+hDGrl24fhcuczgpAeiyJzv0fbX/FsHnwFTv5eGfHPtxXl0Z9jV
	 tBGJBbsE981e9f2dIksa4ILBW+Wm7JCysqQOWupaRnYVWpnk9YAKKKBDLcFlCZpp5h
	 xsL9zHkM40cUc9MITDABavvBnacI76oOxLSd1ruL5okRmCHlMO8w3xBiddEVpZtr/P
	 glbW2ETMmsjOw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com
Subject: [PATCH net 2/9] eth: fbnic: fix accounting of XDP packets
Date: Fri,  3 Oct 2025 16:30:18 -0700
Message-ID: <20251003233025.1157158-3-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003233025.1157158-1-kuba@kernel.org>
References: <20251003233025.1157158-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make XDP-handled packets appear in the Rx stats. The driver has been
counting XDP_TX packets on the Tx ring, but there wasn't much accounting
on the Rx side (the Rx bytes appear to be incremented on XDP_TX but
XDP_DROP / XDP_ABORT are only counted as Rx drops).

Counting XDP_TX packets (not just bytes) in Rx stats looks like
a simple bug of omission.

The XDP_DROP handling appears to be intentional. Whether XDP_DROP
packets should be counted in interface-level Rx stats is a bit
unclear historically. When we were defining qstats, however,
we clarified based on operational experience that in this context:

  name: rx-packets
  doc: |
    Number of wire packets successfully received and passed to the stack.
    For drivers supporting XDP, XDP is considered the first layer
    of the stack, so packets consumed by XDP are still counted here.

fbnic does not obey this requirement. Since XDP support has been added
in current release cycle, instead of splitting interface and qstat
handling - make them both follow the qstat definition.

Another small tweak here is that we count bytes as received on the wire
rather than post-XDP bytes (xdp_get_buff_len() vs skb->len).

Fixes: 5213ff086344 ("eth: fbnic: Collect packet statistics for XDP")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: alexanderduyck@fb.com
CC: sdf@fomichev.me
CC: mohsin.bashr@gmail.com
CC: bpf@vger.kernel.org
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 28 +++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index cf773cc78e40..b00d44926ba1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1242,6 +1242,7 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 	/* Walk the completion queue collecting the heads reported by NIC */
 	while (likely(packets < budget)) {
 		struct sk_buff *skb = ERR_PTR(-EINVAL);
+		u32 pkt_bytes;
 		u64 rcd;
 
 		if ((*raw_rcd & cpu_to_le64(FBNIC_RCD_DONE)) == done)
@@ -1272,37 +1273,38 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 			/* We currently ignore the action table index */
 			break;
 		case FBNIC_RCD_TYPE_META:
-			if (unlikely(pkt->add_frag_failed))
-				skb = NULL;
-			else if (likely(!fbnic_rcd_metadata_err(rcd)))
+			if (likely(!fbnic_rcd_metadata_err(rcd) &&
+				   !pkt->add_frag_failed)) {
+				pkt_bytes = xdp_get_buff_len(&pkt->buff);
 				skb = fbnic_run_xdp(nv, pkt);
+			}
 
 			/* Populate skb and invalidate XDP */
 			if (!IS_ERR_OR_NULL(skb)) {
 				fbnic_populate_skb_fields(nv, rcd, skb, qt,
 							  &csum_complete,
 							  &csum_none);
-
-				packets++;
-				bytes += skb->len;
-
 				napi_gro_receive(&nv->napi, skb);
 			} else if (skb == ERR_PTR(-FBNIC_XDP_TX)) {
 				pkt_tail = nv->qt[0].sub1.tail;
-				bytes += xdp_get_buff_len(&pkt->buff);
+			} else if (PTR_ERR(skb) == -FBNIC_XDP_CONSUME) {
+				fbnic_put_pkt_buff(qt, pkt, 1);
 			} else {
-				if (!skb) {
+				if (!skb)
 					alloc_failed++;
-					dropped++;
-				} else if (skb == ERR_PTR(-FBNIC_XDP_LEN_ERR)) {
+
+				if (skb == ERR_PTR(-FBNIC_XDP_LEN_ERR))
 					length_errors++;
-				} else {
+				else
 					dropped++;
-				}
 
 				fbnic_put_pkt_buff(qt, pkt, 1);
+				goto next_dont_count;
 			}
 
+			packets++;
+			bytes += pkt_bytes;
+next_dont_count:
 			pkt->buff.data_hard_start = NULL;
 
 			break;
-- 
2.51.0


