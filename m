Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308FB6963B5
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 13:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjBNMoo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 07:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjBNMoo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 07:44:44 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A076321A29;
        Tue, 14 Feb 2023 04:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676378683; x=1707914683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NCq3T4/ETUCcEAiQq3iahvZoxp33xntOznZpGg2dWrI=;
  b=C7Wd8R9Mbz0GXBryr/atlWZFcC/FNbp931ZafeN/sk4JQeRafJDEw8up
   SpbqM1qNjfy6W63BLyI5WAKBXdKVCidn+7ceWKoaRKSLjrcFCB0N2dt7t
   VSkvAV4k7/nu1LJT6MaqMJ1BWniBsq7BSfrAl2mfs/UuZzxlTJkzHVpVY
   KHRXG3uy6XYGr9hoG9/EYxphSkSG8BRcBf4BvZEmluv4bzuM+8xRrKcOt
   TFPpkZDGEJCXsUBv3EWtJItBwwQzdDV96gmWcm+JVUHcs/TQgNaygNrmD
   bAFwBhcAi9GxW7XMkeFTjSmlwfn7HBRD9eCjYrtwuCur6jmB0xtYHL+et
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="417371183"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="417371183"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 04:44:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="778308585"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="778308585"
Received: from unknown (HELO paamrpdk12-S2600BPB.aw.intel.com) ([10.228.151.145])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 04:44:42 -0800
From:   Tirthendu Sarkar <tirthendu.sarkar@intel.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        tirthendu.sarkar@intel.com
Subject: [PATCH intel-next v3 1/8] i40e: consolidate maximum frame size calculation for vsi
Date:   Tue, 14 Feb 2023 18:00:11 +0530
Message-Id: <20230214123018.54386-2-tirthendu.sarkar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214123018.54386-1-tirthendu.sarkar@intel.com>
References: <20230214123018.54386-1-tirthendu.sarkar@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce new helper function to calculate max frame size for validating
and setting of vsi frame size. This is used while configuring vsi,
changing the MTU and attaching an XDP program to the vsi.

This is in preparation of the legacy rx and multi-buffer changes to be
introduced in later patches.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 71 +++++++++++----------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3ee00c3bc319..672038801d1d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2896,15 +2896,35 @@ static void i40e_sync_filters_subtask(struct i40e_pf *pf)
 }
 
 /**
- * i40e_max_xdp_frame_size - returns the maximum allowed frame size for XDP
+ * i40e_calculate_vsi_rx_buf_len - Calculates buffer length
+ *
+ * @vsi: VSI to calculate rx_buf_len from
+ */
+static u16 i40e_calculate_vsi_rx_buf_len(struct i40e_vsi *vsi)
+{
+	if (!vsi->netdev || (vsi->back->flags & I40E_FLAG_LEGACY_RX))
+		return I40E_RXBUFFER_2048;
+
+	return PAGE_SIZE < 8192 ? I40E_RXBUFFER_3072 : I40E_RXBUFFER_2048;
+}
+
+/**
+ * i40e_max_vsi_frame_size - returns the maximum allowed frame size for VSI
  * @vsi: the vsi
+ * @xdp_prog: XDP program
  **/
-static int i40e_max_xdp_frame_size(struct i40e_vsi *vsi)
+static int i40e_max_vsi_frame_size(struct i40e_vsi *vsi,
+				   struct bpf_prog *xdp_prog)
 {
-	if (PAGE_SIZE >= 8192 || (vsi->back->flags & I40E_FLAG_LEGACY_RX))
-		return I40E_RXBUFFER_2048;
+	u16 rx_buf_len = i40e_calculate_vsi_rx_buf_len(vsi);
+	u16 chain_len;
+
+	if (xdp_prog)
+		chain_len = 1;
 	else
-		return I40E_RXBUFFER_3072;
+		chain_len = I40E_MAX_CHAINED_RX_BUFFERS;
+
+	return min_t(u16, rx_buf_len * chain_len, I40E_MAX_RXBUFFER);
 }
 
 /**
@@ -2919,12 +2939,13 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
+	int frame_size;
 
-	if (i40e_enabled_xdp_vsi(vsi)) {
-		int frame_size = new_mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
-
-		if (frame_size > i40e_max_xdp_frame_size(vsi))
-			return -EINVAL;
+	frame_size = i40e_max_vsi_frame_size(vsi, vsi->xdp_prog);
+	if (new_mtu > frame_size - I40E_PACKET_HDR_PAD) {
+		netdev_err(netdev, "Error changing mtu to %d, Max is %d\n",
+			   new_mtu, frame_size - I40E_PACKET_HDR_PAD);
+		return -EINVAL;
 	}
 
 	netdev_dbg(netdev, "changing MTU from %d to %d\n",
@@ -3693,24 +3714,6 @@ static int i40e_vsi_configure_tx(struct i40e_vsi *vsi)
 	return err;
 }
 
-/**
- * i40e_calculate_vsi_rx_buf_len - Calculates buffer length
- *
- * @vsi: VSI to calculate rx_buf_len from
- */
-static u16 i40e_calculate_vsi_rx_buf_len(struct i40e_vsi *vsi)
-{
-	if (!vsi->netdev || (vsi->back->flags & I40E_FLAG_LEGACY_RX))
-		return I40E_RXBUFFER_2048;
-
-#if (PAGE_SIZE < 8192)
-	if (!I40E_2K_TOO_SMALL_WITH_PADDING && vsi->netdev->mtu <= ETH_DATA_LEN)
-		return I40E_RXBUFFER_1536 - NET_IP_ALIGN;
-#endif
-
-	return PAGE_SIZE < 8192 ? I40E_RXBUFFER_3072 : I40E_RXBUFFER_2048;
-}
-
 /**
  * i40e_vsi_configure_rx - Configure the VSI for Rx
  * @vsi: the VSI being configured
@@ -3722,13 +3725,15 @@ static int i40e_vsi_configure_rx(struct i40e_vsi *vsi)
 	int err = 0;
 	u16 i;
 
-	vsi->max_frame = I40E_MAX_RXBUFFER;
+	vsi->max_frame = i40e_max_vsi_frame_size(vsi, vsi->xdp_prog);
 	vsi->rx_buf_len = i40e_calculate_vsi_rx_buf_len(vsi);
 
 #if (PAGE_SIZE < 8192)
 	if (vsi->netdev && !I40E_2K_TOO_SMALL_WITH_PADDING &&
-	    vsi->netdev->mtu <= ETH_DATA_LEN)
-		vsi->max_frame = I40E_RXBUFFER_1536 - NET_IP_ALIGN;
+	    vsi->netdev->mtu <= ETH_DATA_LEN) {
+		vsi->rx_buf_len = I40E_RXBUFFER_1536 - NET_IP_ALIGN;
+		vsi->max_frame = vsi->rx_buf_len;
+	}
 #endif
 
 	/* set up individual rings */
@@ -13314,14 +13319,14 @@ static netdev_features_t i40e_features_check(struct sk_buff *skb,
 static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
 			  struct netlink_ext_ack *extack)
 {
-	int frame_size = vsi->netdev->mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
+	int frame_size = i40e_max_vsi_frame_size(vsi, prog);
 	struct i40e_pf *pf = vsi->back;
 	struct bpf_prog *old_prog;
 	bool need_reset;
 	int i;
 
 	/* Don't allow frames that span over multiple buffers */
-	if (frame_size > i40e_calculate_vsi_rx_buf_len(vsi)) {
+	if (vsi->netdev->mtu > frame_size - I40E_PACKET_HDR_PAD) {
 		NL_SET_ERR_MSG_MOD(extack, "MTU too large to enable XDP");
 		return -EINVAL;
 	}
-- 
2.34.1

