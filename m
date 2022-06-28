Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DF455E9D7
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiF1Qey (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiF1QeC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89BE5286D0
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656433841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ve3fL6e56zHBM1F6dKuSgsKexFwJa8X/ua0RDN8QPWg=;
        b=YdduEVYx5rsvBTZpPrFpq5vuiYUQW4X7o2SMGexzQtgGXsohNtZoa3FyDacM+EP8unnudL
        w0iRrWkJNrqvW3urbVNmyTZ37mrFh6C05zfVeTTVOg7ZL47yQQokE8r6AiFgDSdHwJkwCd
        KNhNyBgwRhUSg2Hn3H/BmIJ+fdWyavo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-75dOT8mZPCuG8N9OZeQ7UA-1; Tue, 28 Jun 2022 12:30:40 -0400
X-MC-Unique: 75dOT8mZPCuG8N9OZeQ7UA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EB4138149A6;
        Tue, 28 Jun 2022 16:30:40 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFFE01415108;
        Tue, 28 Jun 2022 16:30:39 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id AE43430736C72;
        Tue, 28 Jun 2022 18:30:38 +0200 (CEST)
Subject: [PATCH RFC bpf-next 1/9] i40e: Refactor i40e_ptp_rx_hwtstamp
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     xdp-hints@xdp-project.net,
        Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Tue, 28 Jun 2022 18:30:38 +0200
Message-ID: <165643383866.449467.13123784268411403387.stgit@firesoul>
In-Reply-To: <165643378969.449467.13237011812569188299.stgit@firesoul>
References: <165643378969.449467.13237011812569188299.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
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

Introduce i40e_ptp_rx_hwtstamp_raw() that doesn't depend on skb pointer
as input. Keep i40e_ptp_rx_hwtstamp with same semantics as before.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h     |    1 +
 drivers/net/ethernet/intel/i40e/i40e_ptp.c |   36 +++++++++++++++++++++-------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 57f4ec4f8d2f..9eb6ea92eafe 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1246,6 +1246,7 @@ void i40e_ptp_rx_hang(struct i40e_pf *pf);
 void i40e_ptp_tx_hang(struct i40e_pf *pf);
 void i40e_ptp_tx_hwtstamp(struct i40e_pf *pf);
 void i40e_ptp_rx_hwtstamp(struct i40e_pf *pf, struct sk_buff *skb, u8 index);
+u64  i40e_ptp_rx_hwtstamp_raw(struct i40e_pf *pf, u8 index);
 void i40e_ptp_set_increment(struct i40e_pf *pf);
 int i40e_ptp_set_ts_config(struct i40e_pf *pf, struct ifreq *ifr);
 int i40e_ptp_get_ts_config(struct i40e_pf *pf, struct ifreq *ifr);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 61e5789d78db..8906e4bbf291 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -816,18 +816,16 @@ void i40e_ptp_tx_hwtstamp(struct i40e_pf *pf)
 }
 
 /**
- * i40e_ptp_rx_hwtstamp - Utility function which checks for an Rx timestamp
+ * i40e_ptp_rx_hwtstamp_raw - Utility function which checks for an Rx timestamp
  * @pf: Board private structure
- * @skb: Particular skb to send timestamp with
  * @index: Index into the receive timestamp registers for the timestamp
  *
  * The XL710 receives a notification in the receive descriptor with an offset
- * into the set of RXTIME registers where the timestamp is for that skb. This
+ * into the set of RXTIME registers where the timestamp is for that pkt. This
  * function goes and fetches the receive timestamp from that offset, if a valid
- * one exists. The RXTIME registers are in ns, so we must convert the result
- * first.
+ * one exists, else zero is returned.
  **/
-void i40e_ptp_rx_hwtstamp(struct i40e_pf *pf, struct sk_buff *skb, u8 index)
+u64 i40e_ptp_rx_hwtstamp_raw(struct i40e_pf *pf, u8 index)
 {
 	u32 prttsyn_stat, hi, lo;
 	struct i40e_hw *hw;
@@ -837,7 +835,7 @@ void i40e_ptp_rx_hwtstamp(struct i40e_pf *pf, struct sk_buff *skb, u8 index)
 	 * doing Tx timestamping, check if Rx timestamping is configured.
 	 */
 	if (!(pf->flags & I40E_FLAG_PTP) || !pf->ptp_rx)
-		return;
+		return 0;
 
 	hw = &pf->hw;
 
@@ -849,7 +847,7 @@ void i40e_ptp_rx_hwtstamp(struct i40e_pf *pf, struct sk_buff *skb, u8 index)
 	/* TODO: Should we warn about missing Rx timestamp event? */
 	if (!(prttsyn_stat & BIT(index))) {
 		spin_unlock_bh(&pf->ptp_rx_lock);
-		return;
+		return 0;
 	}
 
 	/* Clear the latched event since we're about to read its register */
@@ -862,7 +860,27 @@ void i40e_ptp_rx_hwtstamp(struct i40e_pf *pf, struct sk_buff *skb, u8 index)
 
 	ns = (((u64)hi) << 32) | lo;
 
-	i40e_ptp_convert_to_hwtstamp(skb_hwtstamps(skb), ns);
+	return ns;
+}
+
+/**
+ * i40e_ptp_rx_hwtstamp - Utility function which checks for an Rx timestamp
+ * @pf: Board private structure
+ * @skb: Particular skb to send timestamp with
+ * @index: Index into the receive timestamp registers for the timestamp
+ *
+ * The XL710 receives a notification in the receive descriptor with an offset
+ * into the set of RXTIME registers where the timestamp is for that skb. This
+ * function goes and fetches the receive timestamp from that offset, if a valid
+ * one exists. The RXTIME registers are in ns, so we must convert the result
+ * first.
+ **/
+void i40e_ptp_rx_hwtstamp(struct i40e_pf *pf, struct sk_buff *skb, u8 index)
+{
+	u64 ns = i40e_ptp_rx_hwtstamp_raw(pf, index);
+
+	if (ns)
+		i40e_ptp_convert_to_hwtstamp(skb_hwtstamps(skb), ns);
 }
 
 /**


