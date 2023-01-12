Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D676667B6
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 01:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbjALAd2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 19:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjALAcv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 19:32:51 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AD3140E3
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 16:32:49 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id bq10-20020a056a000e0a00b00581221976c0so7652033pfb.10
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 16:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wY4CHm/dlhkH6JmCucO1BIsfy2wsh3G3c7i4tQSl6Xk=;
        b=P9IA7Bc5KKc++o5Hh81jdspoLBd8DPfj1AoKUrzblpT9ar9j1uHq6Y2hazrnOD+JXP
         tHDyq1QWQddo0ncPP5lVq7zoD9sX5k+UDCdCipk0K8NHB4QLY998POL/8FHZpuRNiefw
         nGO+F5em9GlJ5NGS5hzIIpXUnSDRITXpQ+TV8pZFy1IufChev6g87DdkuRF+vSRqS4x+
         dGj/LMOaSZER/dhcyfcKfJvp/dTIwC0CAAYWtd2z3Q/KpS3npODAsLWeU+Ti+kOL+6mj
         aKYqzeNMtXy5Iph6MyD9Dy1z7ZZcFSvIsyEMiZpR/KBGH6/3D6OFTmnDvgYi4wzil6MT
         9KuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wY4CHm/dlhkH6JmCucO1BIsfy2wsh3G3c7i4tQSl6Xk=;
        b=qiiA5ibv+bpk1P15rXb/hlWwMnahuKjU2MhrMRP8MORtERMQejB7+pRaUxkdCreNtF
         pWOgsruUiBErZWeTMwVI9I3d3eXxj3jMn0JiVsBvhfXMDNdAjRAZnU+EHEDApKXCrgAL
         mFZLYJwTMZ4cU734QgTykj88aswugW8vz9ZjGbmfbxfN0kZf9y5zf+vDmWoPbv/rgYQS
         hWXdr/2+Qi93tNRrSunDJdUAE8pMoOtmIkwQMjEAaXI9n+uwaJuQeJvSd3nv9FeH5Jyc
         ubHDOaCRNSuj40mDk4OF+eT/7L/05r1AETK62TPYaU2jn36Ue/nNaoZHXRa4O9bRFQ/C
         7JcA==
X-Gm-Message-State: AFqh2kqDM2z9TQgecq6kKpnfs8loKAdl3M3ZSZbOlC6d+sQN25zKBshH
        AAZ1WO49S91MIRzpQKYmUG9dDL7Ju0LpW3QlAJ8YJLQqYo4FKwB+MfJ6UOnnZ6B1MN8dkLbrCRL
        bvjzqlymre8/DscR0t1bJVuB69SajcWDqkNPv+OhjbHiS4UAq6Q==
X-Google-Smtp-Source: AMrXdXvI01HYMbNdKc3+TR9flzcwjmAQ+GQN/sDzsCUe+1dijSVmU5PdWH9v8/SPAjdEue1oYa7SpWQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:d0c1:b0:219:65c0:619f with SMTP id
 y1-20020a17090ad0c100b0021965c0619fmr6911930pjw.150.1673483568580; Wed, 11
 Jan 2023 16:32:48 -0800 (PST)
Date:   Wed, 11 Jan 2023 16:32:23 -0800
In-Reply-To: <20230112003230.3779451-1-sdf@google.com>
Mime-Version: 1.0
References: <20230112003230.3779451-1-sdf@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230112003230.3779451-11-sdf@google.com>
Subject: [PATCH bpf-next v7 10/17] veth: Support RX XDP metadata
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
2.39.0.314.g84b9a713c41-goog

