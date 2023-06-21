Return-Path: <bpf+bounces-3053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FABE738CA0
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 19:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BEA1281741
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 17:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2F71ACDA;
	Wed, 21 Jun 2023 17:02:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF119E5E
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 17:02:59 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209B910D
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:02:58 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-66872bfa48aso3313419b3a.0
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687366977; x=1689958977;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oh4MSgHmxCb0wLEkBD2zbZNTxXKYUJSkffgOtaf+rTs=;
        b=RAIsuwPnJxewMm+JMGNDPEzSp7rm1vTOL3l+y+Ek4+VM6VDxu4eE1PyQ0u9FKximZ3
         koBXX5rYHhqULcsdiNZaqy29sLGW+n6d6GgP1i0tZYpp7HOtPBdAmlbuthG/TRdGhmoL
         vbgefmU1Lz6QrDmBv7dWneXWd6bz3BOSqLV1R9B3FzBOmD2NKWyGzCfpAProCLSkX/Vj
         Tc5auvESSEkxGAt+uSXPAHRCJr96XhsTHif/1PjX+0pLi9g96dZC7LmNL/YKK266Y89+
         LHAxIBIKQ4cL25fOyzXQgq+vI3LaRrbpnSJlw2JnIPEQDsMuYt9L0PC/oK6NuwSVoE+v
         1vMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687366977; x=1689958977;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oh4MSgHmxCb0wLEkBD2zbZNTxXKYUJSkffgOtaf+rTs=;
        b=ccEnBIgwcCAIazt1w+P7cEkXg+MRLCcCXnyXFGIKTlDP9M/P0pLbAkxesXE16dnnVs
         NOQULVXEsu6K1/dIJCdoRlmtBR1ehxMk3OWH+NcctvQllP8zu7+2eE6j2/CVynopVRyv
         onAj/u+dwOYpRbjYuL4RZCIrrfzp0xBvTr10CGRhQj2GoYUHNe4ekj2aGgit3YoR+cfF
         lFb5PEJObpQhZh8LC5fw3trFIdpqgSWUNY9H2ir7J+b68TE7zuiNhqIUy51A8ca3Fkls
         zxTWgMkR+fBRk2+rd86MIIGqAC5OtklkHYPzqAT3K4FcAhcXwSi07Urwt7hnAaDZ4/9E
         FLLw==
X-Gm-Message-State: AC+VfDzxk9kg2kIayX+ajppP7z5UcwEPRhK/hijUD69Vy/GAIp6aG75M
	aawoylP13QeA8zUSbNuyULPK/0BHqSbZFfx35sYHXx5QS6/cnan5f0Qo/tAzhyHx8IKbvICOKBI
	ZLAo2oZ4caMWJyam/2mj96Lev24OLhpnLgPs9rIj+3q8ar83pOg==
X-Google-Smtp-Source: ACHHUZ7noYnqFnY0BjqO4dFxzymGP5h5Lq4p21OkqJJlR/O84AnCDKsNb4KlYY4MWyOCBqsVKwEVPSI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:3912:b0:667:26bb:db7 with SMTP id
 fh18-20020a056a00391200b0066726bb0db7mr3521641pfb.1.1687366977569; Wed, 21
 Jun 2023 10:02:57 -0700 (PDT)
Date: Wed, 21 Jun 2023 10:02:39 -0700
In-Reply-To: <20230621170244.1283336-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621170244.1283336-7-sdf@google.com>
Subject: [RFC bpf-next v2 06/11] net: veth: Implement devtx timestamp kfuncs
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Have a software-based example for kfuncs to showcase how it
can be used in the real devices and to have something to
test against in the selftests.

Both path (skb & xdp) are covered. Only the skb path is really
tested though.

Cc: netdev@vger.kernel.org
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/veth.c | 116 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 112 insertions(+), 4 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 614f3e3efab0..632f0f3771e4 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -27,6 +27,7 @@
 #include <linux/bpf_trace.h>
 #include <linux/net_tstamp.h>
 #include <net/page_pool.h>
+#include <net/devtx.h>
 
 #define DRV_NAME	"veth"
 #define DRV_VERSION	"1.0"
@@ -123,6 +124,13 @@ struct veth_xdp_buff {
 	struct sk_buff *skb;
 };
 
+struct veth_devtx_frame {
+	struct devtx_frame frame;
+	bool request_timestamp;
+	ktime_t xdp_tx_timestamp;
+	struct sk_buff *skb;
+};
+
 static int veth_get_link_ksettings(struct net_device *dev,
 				   struct ethtool_link_ksettings *cmd)
 {
@@ -313,10 +321,43 @@ static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
 	return NET_RX_SUCCESS;
 }
 
+__weak noinline void veth_devtx_submit(struct devtx_frame *ctx)
+{
+}
+
+__weak noinline void veth_devtx_complete(struct devtx_frame *ctx)
+{
+}
+
+BTF_SET8_START(veth_devtx_hook_ids)
+BTF_ID_FLAGS(func, veth_devtx_submit)
+BTF_ID_FLAGS(func, veth_devtx_complete)
+BTF_SET8_END(veth_devtx_hook_ids)
+
 static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,
-			    struct veth_rq *rq, bool xdp)
+			    struct veth_rq *rq, bool xdp, bool request_timestamp)
 {
-	return __dev_forward_skb(dev, skb) ?: xdp ?
+	struct net_device *orig_dev = skb->dev;
+	int ret;
+
+	ret = __dev_forward_skb(dev, skb);
+	if (ret)
+		return ret;
+
+	if (devtx_enabled()) {
+		struct veth_devtx_frame ctx;
+
+		if (unlikely(request_timestamp))
+			__net_timestamp(skb);
+
+		devtx_frame_from_skb(&ctx.frame, skb, orig_dev);
+		ctx.frame.data -= ETH_HLEN; /* undo eth_type_trans pull */
+		ctx.frame.len += ETH_HLEN;
+		ctx.skb = skb;
+		veth_devtx_complete(&ctx.frame);
+	}
+
+	return xdp ?
 		veth_xdp_rx(rq, skb) :
 		__netif_rx(skb);
 }
@@ -343,6 +384,7 @@ static bool veth_skb_is_eligible_for_gro(const struct net_device *dev,
 static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
+	bool request_timestamp = false;
 	struct veth_rq *rq = NULL;
 	struct net_device *rcv;
 	int length = skb->len;
@@ -356,6 +398,15 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop;
 	}
 
+	if (devtx_enabled()) {
+		struct veth_devtx_frame ctx;
+
+		devtx_frame_from_skb(&ctx.frame, skb, dev);
+		ctx.request_timestamp = false;
+		veth_devtx_submit(&ctx.frame);
+		request_timestamp = ctx.request_timestamp;
+	}
+
 	rcv_priv = netdev_priv(rcv);
 	rxq = skb_get_queue_mapping(skb);
 	if (rxq < rcv->real_num_rx_queues) {
@@ -370,7 +421,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	skb_tx_timestamp(skb);
-	if (likely(veth_forward_skb(rcv, skb, rq, use_napi) == NET_RX_SUCCESS)) {
+	if (likely(veth_forward_skb(rcv, skb, rq, use_napi, request_timestamp) == NET_RX_SUCCESS)) {
 		if (!use_napi)
 			dev_lstats_add(dev, length);
 	} else {
@@ -483,6 +534,7 @@ static int veth_xdp_xmit(struct net_device *dev, int n,
 {
 	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
 	int i, ret = -ENXIO, nxmit = 0;
+	ktime_t tx_timestamp = 0;
 	struct net_device *rcv;
 	unsigned int max_len;
 	struct veth_rq *rq;
@@ -511,9 +563,32 @@ static int veth_xdp_xmit(struct net_device *dev, int n,
 		void *ptr = veth_xdp_to_ptr(frame);
 
 		if (unlikely(xdp_get_frame_len(frame) > max_len ||
-			     __ptr_ring_produce(&rq->xdp_ring, ptr)))
+			     __ptr_ring_full(&rq->xdp_ring)))
+			break;
+
+		if (devtx_enabled()) {
+			struct veth_devtx_frame ctx;
+
+			devtx_frame_from_xdp(&ctx.frame, frame, dev);
+			ctx.request_timestamp = false;
+			veth_devtx_submit(&ctx.frame);
+
+			if (unlikely(ctx.request_timestamp))
+				tx_timestamp = ktime_get_real();
+		}
+
+		if (unlikely(__ptr_ring_produce(&rq->xdp_ring, ptr)))
 			break;
 		nxmit++;
+
+		if (devtx_enabled()) {
+			struct veth_devtx_frame ctx;
+
+			devtx_frame_from_xdp(&ctx.frame, frame, dev);
+			ctx.xdp_tx_timestamp = tx_timestamp;
+			ctx.skb = NULL;
+			veth_devtx_complete(&ctx.frame);
+		}
 	}
 	spin_unlock(&rq->xdp_ring.producer_lock);
 
@@ -1732,6 +1807,28 @@ static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 	return 0;
 }
 
+static int veth_devtx_sb_request_timestamp(const struct devtx_frame *_ctx)
+{
+	struct veth_devtx_frame *ctx = (struct veth_devtx_frame *)_ctx;
+
+	ctx->request_timestamp = true;
+
+	return 0;
+}
+
+static int veth_devtx_cp_timestamp(const struct devtx_frame *_ctx, u64 *timestamp)
+{
+	struct veth_devtx_frame *ctx = (struct veth_devtx_frame *)_ctx;
+
+	if (ctx->skb) {
+		*timestamp = ctx->skb->tstamp;
+		return 0;
+	}
+
+	*timestamp = ctx->xdp_tx_timestamp;
+	return 0;
+}
+
 static const struct net_device_ops veth_netdev_ops = {
 	.ndo_init            = veth_dev_init,
 	.ndo_open            = veth_open,
@@ -1756,6 +1853,8 @@ static const struct net_device_ops veth_netdev_ops = {
 static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
 	.xmo_rx_hash			= veth_xdp_rx_hash,
+	.xmo_sb_request_timestamp	= veth_devtx_sb_request_timestamp,
+	.xmo_cp_timestamp		= veth_devtx_cp_timestamp,
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
@@ -2041,11 +2140,20 @@ static struct rtnl_link_ops veth_link_ops = {
 
 static __init int veth_init(void)
 {
+	int ret;
+
+	ret = devtx_hooks_register(&veth_devtx_hook_ids, &veth_xdp_metadata_ops);
+	if (ret) {
+		pr_warn("failed to register devtx hooks: %d", ret);
+		return ret;
+	}
+
 	return rtnl_link_register(&veth_link_ops);
 }
 
 static __exit void veth_exit(void)
 {
+	devtx_hooks_unregister(&veth_devtx_hook_ids);
 	rtnl_link_unregister(&veth_link_ops);
 }
 
-- 
2.41.0.162.gfafddb0af9-goog


