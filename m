Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F419674628
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 23:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjASWdj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 17:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjASWcT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 17:32:19 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5865CAED84
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:15:56 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id f8-20020a170902ce8800b00190c6518e21so2069236plg.1
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DdiKboA1OinZW68Ps6utmlxIN/WHRtMp9NTtEZItVqo=;
        b=P68YSDFgefbeRUc21+cOfPdeWm7m5dX0uI3ajYDALuFzhpHKbJx7u9LfrxQW/noR6B
         5lXe4rpbdCcl0mti08Cr72hWRRKeE4GGbP0gmgXjpqAoa0CNszTfju9nJvC6ybvC5Paa
         dvlb0/YVXuFK65vLBsxMXFzudGXd6dVaRQfkrtkpEcmn+13I1kbq2UwMniSOI6y4gHL6
         B+lIZP7uFL57r5keeEl+4rCbOICUBt6RdhaZZLjjcZ8HcIjw8+Qa2pPv9EA/QChWigAh
         JSK3voiQnc/oBzZK6FrvOrOeTiN0zjQBhJ3dgzA8G/6Y/HW52Y537UbC4HHPY6hB+vnj
         Doaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DdiKboA1OinZW68Ps6utmlxIN/WHRtMp9NTtEZItVqo=;
        b=rTB4GWrUNHtL3Z7akAoxSo/iEYSupHSDOj0vB2PhGBLiadJLeN8XWBYKs17bStm2NB
         OFu5xD2mTuu0sq6TXicFsqs6UFPY0sr9Tc9Z/wQP3gNQbSlk4slXEc/6lBPxea2BK9Zu
         Law/0z83UirninU4olUQ/2blxTG1yYRG+2FpkIB+EjePkPf2nbwfYC3HX9puUDtKSdZ+
         T8vNlFSn6pmkoigwwBMgyBATCcybW0060CeWk4XUiagHEq+/32j6TwKtoQ7IuHULibpa
         a6HboH3S6JuW+hm6KJuQGaGoKhgSxKFew59pB/LSBFJMXzCDckMDdv20p5FAriPw3Vbi
         hSbw==
X-Gm-Message-State: AFqh2krjYTElAfzEDIXI1BWHOyKuRLdxwA8AwowpoPDq3gy6J2kmynUZ
        8TKm4O44JllNfRTqhyT+rRQ4OXsQ3O1AdY61RJmYM0bkVKCEVhcPgKc4nkCReuxTxQ+MkR0+IQ/
        tKwP2y/LPAth4sTYAFVeLboiWprNR+460s7IsiamO/zQHBS/+TQ==
X-Google-Smtp-Source: AMrXdXvAviVOQO16RvrAUOJynbCzmNs+BL1R17o46mu7wBT/6W0lvyC7VjwGyFDp+gwnwDpmsaXgLEQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:d703:b0:192:b43e:267 with SMTP id
 w3-20020a170902d70300b00192b43e0267mr1111668ply.38.1674166555550; Thu, 19 Jan
 2023 14:15:55 -0800 (PST)
Date:   Thu, 19 Jan 2023 14:15:29 -0800
In-Reply-To: <20230119221536.3349901-1-sdf@google.com>
Mime-Version: 1.0
References: <20230119221536.3349901-1-sdf@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230119221536.3349901-11-sdf@google.com>
Subject: [PATCH bpf-next v8 10/17] veth: Support RX XDP metadata
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The goal is to enable end-to-end testing of the metadata for AF_XDP.

Cc: John Fastabend <john.fastabend@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Maryam Tahhan <mtahhan@redhat.com>
Cc: xdp-hints@xdp-project.net
Cc: netdev@vger.kernel.org
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/veth.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 70f50602287a..ba3e05832843 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -118,6 +118,7 @@ static struct {
 
 struct veth_xdp_buff {
 	struct xdp_buff xdp;
+	struct sk_buff *skb;
 };
 
 static int veth_get_link_ksettings(struct net_device *dev,
@@ -602,6 +603,7 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
 
 		xdp_convert_frame_to_buff(frame, xdp);
 		xdp->rxq = &rq->xdp_rxq;
+		vxbuf.skb = NULL;
 
 		act = bpf_prog_run_xdp(xdp_prog, xdp);
 
@@ -823,6 +825,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	__skb_push(skb, skb->data - skb_mac_header(skb));
 	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
 		goto drop;
+	vxbuf.skb = skb;
 
 	orig_data = xdp->data;
 	orig_data_end = xdp->data_end;
@@ -1602,6 +1605,28 @@ static int veth_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
+static int veth_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
+{
+	struct veth_xdp_buff *_ctx = (void *)ctx;
+
+	if (!_ctx->skb)
+		return -EOPNOTSUPP;
+
+	*timestamp = skb_hwtstamps(_ctx->skb)->hwtstamp;
+	return 0;
+}
+
+static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash)
+{
+	struct veth_xdp_buff *_ctx = (void *)ctx;
+
+	if (!_ctx->skb)
+		return -EOPNOTSUPP;
+
+	*hash = skb_get_hash(_ctx->skb);
+	return 0;
+}
+
 static const struct net_device_ops veth_netdev_ops = {
 	.ndo_init            = veth_dev_init,
 	.ndo_open            = veth_open,
@@ -1623,6 +1648,11 @@ static const struct net_device_ops veth_netdev_ops = {
 	.ndo_get_peer_dev	= veth_peer_dev,
 };
 
+static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
+	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
+	.xmo_rx_hash			= veth_xdp_rx_hash,
+};
+
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
 		       NETIF_F_RXCSUM | NETIF_F_SCTP_CRC | NETIF_F_HIGHDMA | \
 		       NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ENCAP_ALL | \
@@ -1639,6 +1669,7 @@ static void veth_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_PHONY_HEADROOM;
 
 	dev->netdev_ops = &veth_netdev_ops;
+	dev->xdp_metadata_ops = &veth_xdp_metadata_ops;
 	dev->ethtool_ops = &veth_ethtool_ops;
 	dev->features |= NETIF_F_LLTX;
 	dev->features |= VETH_FEATURES;
-- 
2.39.0.246.g2a6d74b583-goog

