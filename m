Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C5F55E9DA
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbiF1QfA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiF1QeT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99ACE2AC43
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656433866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lEhnt0ntlLy80SIkWe6Z9h7i/UK/zY7t9l1SJruL8OY=;
        b=WjQ1NB7wBvP4c2xJFHwV1/JiSgGrwtsz0OH7kKb9LuJcl/Sr9nwhV4eTbqNaEMVzCUx2Us
        CGSrR/6I22p1gH/fW+d/6xZ5CkZSWbIVdkCxRXdPPUM99NtHzQnc4FKfgE6ItcISWdQKGx
        jURENgXTwFD4/h/HrxF4M/w5Y1h4Ers=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-bvB1MvxRNfmloGPPZqBs0Q-1; Tue, 28 Jun 2022 12:31:05 -0400
X-MC-Unique: bvB1MvxRNfmloGPPZqBs0Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5343D80029D;
        Tue, 28 Jun 2022 16:31:05 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE7B41121314;
        Tue, 28 Jun 2022 16:31:04 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id E967830736C72;
        Tue, 28 Jun 2022 18:31:03 +0200 (CEST)
Subject: [PATCH RFC bpf-next 6/9] i40e: refactor i40e_rx_checksum with helper
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     xdp-hints@xdp-project.net,
        Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Tue, 28 Jun 2022 18:31:03 +0200
Message-ID: <165643386392.449467.4987795148640234037.stgit@firesoul>
In-Reply-To: <165643378969.449467.13237011812569188299.stgit@firesoul>
References: <165643378969.449467.13237011812569188299.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

No functional change, this is in preparation for later patches.

The helper function does not depend on skb, which will be used in later
patches.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |   66 ++++++++++++++++-----------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index b7967105a549..26459d7f68cc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1754,45 +1754,38 @@ bool i40e_alloc_rx_buffers(struct i40e_ring *rx_ring, u16 cleaned_count)
 	return true;
 }
 
-/**
- * i40e_rx_checksum - Indicate in skb if hw indicated a good cksum
- * @vsi: the VSI we care about
- * @skb: skb currently being received and modified
- * @rx_desc: the receive descriptor
- **/
-static inline void i40e_rx_checksum(struct i40e_vsi *vsi,
-				    struct sk_buff *skb,
-				    union i40e_rx_desc *rx_desc)
+struct i40e_rx_checksum_ret {
+	u16 ip_summed;
+	u16 csum_level;
+};
+
+static inline struct i40e_rx_checksum_ret
+_i40e_rx_checksum(struct i40e_vsi *vsi,
+		  u64 qword,
+		  struct i40e_rx_ptype_decoded decoded)
 {
-	struct i40e_rx_ptype_decoded decoded;
+	struct i40e_rx_checksum_ret ret = {};
 	u32 rx_error, rx_status;
 	bool ipv4, ipv6;
-	u8 ptype;
-	u64 qword;
 
-	qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
-	ptype = (qword & I40E_RXD_QW1_PTYPE_MASK) >> I40E_RXD_QW1_PTYPE_SHIFT;
 	rx_error = (qword & I40E_RXD_QW1_ERROR_MASK) >>
 		   I40E_RXD_QW1_ERROR_SHIFT;
 	rx_status = (qword & I40E_RXD_QW1_STATUS_MASK) >>
 		    I40E_RXD_QW1_STATUS_SHIFT;
-	decoded = decode_rx_desc_ptype(ptype);
 
-	skb->ip_summed = CHECKSUM_NONE;
-
-	skb_checksum_none_assert(skb);
+	ret.ip_summed = CHECKSUM_NONE;
 
 	/* Rx csum enabled and ip headers found? */
 	if (!(vsi->netdev->features & NETIF_F_RXCSUM))
-		return;
+		return ret;
 
 	/* did the hardware decode the packet and checksum? */
 	if (!(rx_status & BIT(I40E_RX_DESC_STATUS_L3L4P_SHIFT)))
-		return;
+		return ret;
 
 	/* both known and outer_ip must be set for the below code to work */
 	if (!(decoded.known && decoded.outer_ip))
-		return;
+		return ret;
 
 	ipv4 = (decoded.outer_ip == I40E_RX_PTYPE_OUTER_IP) &&
 	       (decoded.outer_ip_ver == I40E_RX_PTYPE_OUTER_IPV4);
@@ -1808,7 +1801,7 @@ static inline void i40e_rx_checksum(struct i40e_vsi *vsi,
 	if (ipv6 &&
 	    rx_status & BIT(I40E_RX_DESC_STATUS_IPV6EXADD_SHIFT))
 		/* don't increment checksum err here, non-fatal err */
-		return;
+		return ret;
 
 	/* there was some L4 error, count error and punt packet to the stack */
 	if (rx_error & BIT(I40E_RX_DESC_ERROR_L4E_SHIFT))
@@ -1819,30 +1812,51 @@ static inline void i40e_rx_checksum(struct i40e_vsi *vsi,
 	 * the csum.
 	 */
 	if (rx_error & BIT(I40E_RX_DESC_ERROR_PPRS_SHIFT))
-		return;
+		return ret;
 
 	/* If there is an outer header present that might contain a checksum
 	 * we need to bump the checksum level by 1 to reflect the fact that
 	 * we are indicating we validated the inner checksum.
 	 */
 	if (decoded.tunnel_type >= I40E_RX_PTYPE_TUNNEL_IP_GRENAT)
-		skb->csum_level = 1;
+		ret.csum_level = 1;
 
 	/* Only report checksum unnecessary for TCP, UDP, or SCTP */
 	switch (decoded.inner_prot) {
 	case I40E_RX_PTYPE_INNER_PROT_TCP:
 	case I40E_RX_PTYPE_INNER_PROT_UDP:
 	case I40E_RX_PTYPE_INNER_PROT_SCTP:
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		ret.ip_summed = CHECKSUM_UNNECESSARY;
 		fallthrough;
 	default:
 		break;
 	}
 
-	return;
+	return ret;
 
 checksum_fail:
 	vsi->back->hw_csum_rx_error++;
+	return ret;
+}
+
+/**
+ * i40e_rx_checksum - Indicate in skb if hw indicated a good cksum
+ * @vsi: the VSI we care about
+ * @skb: skb currently being received and modified
+ * @rx_desc: the receive descriptor
+ **/
+static inline void i40e_rx_checksum(struct i40e_vsi *vsi,
+				    struct sk_buff *skb,
+				    union i40e_rx_desc *rx_desc)
+{
+	struct i40e_rx_checksum_ret ret;
+	u64 qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
+	u8 ptype = (qword & I40E_RXD_QW1_PTYPE_MASK) >> I40E_RXD_QW1_PTYPE_SHIFT;
+	struct i40e_rx_ptype_decoded decoded = decode_rx_desc_ptype(ptype);
+
+	ret = _i40e_rx_checksum(vsi, qword, decoded);
+	skb->ip_summed  = ret.ip_summed;
+	skb->csum_level = ret.csum_level;
 }
 
 /**


