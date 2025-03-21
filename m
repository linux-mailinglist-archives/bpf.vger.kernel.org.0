Return-Path: <bpf+bounces-54510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3148A6B239
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 01:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F74880791
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 00:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B234812D758;
	Fri, 21 Mar 2025 00:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vaATa9cJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042DB78F47
	for <bpf@vger.kernel.org>; Fri, 21 Mar 2025 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516967; cv=none; b=UbWlbiacSMtey/UL6PJnUt8TQM6avCZ5okBIlNDw/lV4nZpEmcIVMnulvrTAVzCSB1yJIzR+PAlk8G4eMh7H6+uF89JsGSNiUmgdQtHgFhVoLnERT3O+rThLiaFK8tIQlOOibXd8dG1ZCyw28b4zdaUXOO5w1GRoujTqVo4U1FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516967; c=relaxed/simple;
	bh=5Q2hLfL/6xTp+NVwY9wDFTcWg1KyCiyDU4S9oH7ScIQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nGUrf0TIbi+9q67GPIQg+LQ+btdOmK9JSjM8FS4Olt7exAyloJuexuJWk66T8uUcyp1t7mjhcPEh0E5PJNfTYRHgYS21ckNNmjeKe8vmMjpYy2Tv+DjwFLzYgdUUKok5Nv0o9IhPWmfehSkjOMDgQX1dOen5TPi9iVuA5skgdm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vaATa9cJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso3757297a91.2
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 17:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742516964; x=1743121764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6CLh2uwiKlHnVBDMPMLQbP6E+zIgXPGKwGw0k/0Kf8=;
        b=vaATa9cJLn90KsA26SO+vcmvhsh33tH2/N2LiMYv57aa+Zi1I3oI9UcKl4WlBvM0SZ
         RA6kGc7emID4xpwmP5fRRSbwgn5v00aQzzWvE4yGJJcttXWiP3wMIN/U5iw5KtNZPFRw
         acjH/4ePddp0IkY9K5ocVYGFk1z7ER8Zd0H2ZPIxAu7NrdOMJPxO30Dwq4NhxGgUidor
         PtKxTeQ+kawuanyFdZbIoBmtAj1ln9Jkfgb0MeP6V4Sp86sKjvrIlZDufHz6E73BWYVr
         pIh+uY2QHxpRdpqYWovj5/ZVYv5XCRJ815Lea6CAxxNl0ZVK9YwSNIhGDlIQ7aFMbvLe
         HsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742516964; x=1743121764;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m6CLh2uwiKlHnVBDMPMLQbP6E+zIgXPGKwGw0k/0Kf8=;
        b=WlVTcIpE5szPT1qM2De99kJlD2YIxDafAqQes9MkoCHtoujK8/mwHNb7/1pnzXhP/v
         deis54gQwMjMGzLIq6J/lniv2xiTxBGU5bx00oZ/JFQAtQK6Y+UMT0Qepurlqu57cquv
         2fpRnVKTd2Uh1NJ4ZlPlGy4NEZY4dnotexPt2DiiqIw0QY7QSW9lwE57imTe6LafcSY3
         ubcEvm/gjSj0ekaGnaYcuwxpDMrvI2zsIJu1AF7EPt9PYRqAOY2BP20K2tlU8hW6wbhC
         o76fWVpVuAKEYAuEZhmlwYbtuE8Urt6mRMRoSXjtZmlpcIKbYWXqalnqVd/XjjjEiFLc
         vkPw==
X-Forwarded-Encrypted: i=1; AJvYcCUmjoLudyt8jOsgUplD/LnBzmQYSoYqfJ8Wo7oyRGFKtgEUQhPJaAfTHBlQXMVHIeecDyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6wEvSN0RDK3pG2SQo3OW4XBIThSPhCkz9W0s/hjyh8CP1ZU+l
	BHg0VMERrP4tJvc/X46uWQcwaIOYo/+7qZx/Vxq843Bn5/fDXW/YlbLLzUIV208JDTB1hz6sMeY
	le2eXQcCFyzT4t/CeH8BEnw==
X-Google-Smtp-Source: AGHT+IFrW+DH3avgHgSsTOKvSsVjSUZBWZi+ZXpd3AIRkFg75vMXDEfSVveSZRio2ZX9bRilDqgv3E2IyzYq5hNMPg==
X-Received: from pjur8.prod.google.com ([2002:a17:90a:d408:b0:2fa:b84:b308])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:46:b0:2f4:432d:250d with SMTP id 98e67ed59e1d1-3030fe9e93emr1840861a91.21.1742516964435;
 Thu, 20 Mar 2025 17:29:24 -0700 (PDT)
Date: Fri, 21 Mar 2025 00:29:06 +0000
In-Reply-To: <20250321002910.1343422-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321002910.1343422-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321002910.1343422-3-hramamurthy@google.com>
Subject: [PATCH net-next 2/6] gve: introduce config-based allocation for XDP
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, pkaligineedi@google.com, willemb@google.com, 
	ziweixiao@google.com, joshwash@google.com, horms@kernel.org, 
	shailend@google.com, bcf@google.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Joshua Washington <joshwash@google.com>

An earlier patch series[1] introduced RX/TX ring allocation configuration
structs which contained metadata used to allocate and configure new RX
and TX rings. This led to a much cleaner and safer allocation pattern
wherein queue resources were not deallocated until new queue resources
were successfully allocated.

Migrate the XDP allocation path to use the same pattern to allow for the
existence of a single allocation path instead of relying on XDP-specific
allocation methods. These extra allocation methods result in the
duplication of many existing behaviors while being prone to error when
configuration changes unrelated to XDP occur.

Link: https://lore.kernel.org/netdev/20240122182632.1102721-1-shailend@goog=
le.com/ [1]
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         |  56 ++--
 drivers/net/ethernet/google/gve/gve_ethtool.c |  19 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 261 ++++--------------
 drivers/net/ethernet/google/gve/gve_rx.c      |   6 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |   6 +-
 drivers/net/ethernet/google/gve/gve_tx.c      |  33 +--
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  |  31 +--
 7 files changed, 118 insertions(+), 294 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/g=
oogle/gve/gve.h
index 2064e592dfdd..e5cc3fada9c9 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -631,10 +631,17 @@ struct gve_notify_block {
 	u32 irq;
 };
=20
-/* Tracks allowed and current queue settings */
-struct gve_queue_config {
+/* Tracks allowed and current rx queue settings */
+struct gve_rx_queue_config {
 	u16 max_queues;
-	u16 num_queues; /* current */
+	u16 num_queues;
+};
+
+/* Tracks allowed and current tx queue settings */
+struct gve_tx_queue_config {
+	u16 max_queues;
+	u16 num_queues; /* number of TX queues, excluding XDP queues */
+	u16 num_xdp_queues;
 };
=20
 /* Tracks the available and used qpl IDs */
@@ -658,11 +665,11 @@ struct gve_ptype_lut {
=20
 /* Parameters for allocating resources for tx queues */
 struct gve_tx_alloc_rings_cfg {
-	struct gve_queue_config *qcfg;
+	struct gve_tx_queue_config *qcfg;
+
+	u16 num_xdp_rings;
=20
 	u16 ring_size;
-	u16 start_idx;
-	u16 num_rings;
 	bool raw_addressing;
=20
 	/* Allocated resources are returned here */
@@ -672,8 +679,8 @@ struct gve_tx_alloc_rings_cfg {
 /* Parameters for allocating resources for rx queues */
 struct gve_rx_alloc_rings_cfg {
 	/* tx config is also needed to determine QPL ids */
-	struct gve_queue_config *qcfg;
-	struct gve_queue_config *qcfg_tx;
+	struct gve_rx_queue_config *qcfg_rx;
+	struct gve_tx_queue_config *qcfg_tx;
=20
 	u16 ring_size;
 	u16 packet_buffer_size;
@@ -764,9 +771,8 @@ struct gve_priv {
 	u32 rx_copybreak; /* copy packets smaller than this */
 	u16 default_num_queues; /* default num queues to set up */
=20
-	u16 num_xdp_queues;
-	struct gve_queue_config tx_cfg;
-	struct gve_queue_config rx_cfg;
+	struct gve_tx_queue_config tx_cfg;
+	struct gve_rx_queue_config rx_cfg;
 	u32 num_ntfy_blks; /* spilt between TX and RX so must be even */
=20
 	struct gve_registers __iomem *reg_bar0; /* see gve_register.h */
@@ -1039,27 +1045,16 @@ static inline bool gve_is_qpl(struct gve_priv *priv=
)
 }
=20
 /* Returns the number of tx queue page lists */
-static inline u32 gve_num_tx_qpls(const struct gve_queue_config *tx_cfg,
-				  int num_xdp_queues,
+static inline u32 gve_num_tx_qpls(const struct gve_tx_queue_config *tx_cfg=
,
 				  bool is_qpl)
 {
 	if (!is_qpl)
 		return 0;
-	return tx_cfg->num_queues + num_xdp_queues;
-}
-
-/* Returns the number of XDP tx queue page lists
- */
-static inline u32 gve_num_xdp_qpls(struct gve_priv *priv)
-{
-	if (priv->queue_format !=3D GVE_GQI_QPL_FORMAT)
-		return 0;
-
-	return priv->num_xdp_queues;
+	return tx_cfg->num_queues + tx_cfg->num_xdp_queues;
 }
=20
 /* Returns the number of rx queue page lists */
-static inline u32 gve_num_rx_qpls(const struct gve_queue_config *rx_cfg,
+static inline u32 gve_num_rx_qpls(const struct gve_rx_queue_config *rx_cfg=
,
 				  bool is_qpl)
 {
 	if (!is_qpl)
@@ -1077,7 +1072,8 @@ static inline u32 gve_rx_qpl_id(struct gve_priv *priv=
, int rx_qid)
 	return priv->tx_cfg.max_queues + rx_qid;
 }
=20
-static inline u32 gve_get_rx_qpl_id(const struct gve_queue_config *tx_cfg,=
 int rx_qid)
+static inline u32 gve_get_rx_qpl_id(const struct gve_tx_queue_config *tx_c=
fg,
+				    int rx_qid)
 {
 	return tx_cfg->max_queues + rx_qid;
 }
@@ -1087,7 +1083,7 @@ static inline u32 gve_tx_start_qpl_id(struct gve_priv=
 *priv)
 	return gve_tx_qpl_id(priv, 0);
 }
=20
-static inline u32 gve_rx_start_qpl_id(const struct gve_queue_config *tx_cf=
g)
+static inline u32 gve_rx_start_qpl_id(const struct gve_tx_queue_config *tx=
_cfg)
 {
 	return gve_get_rx_qpl_id(tx_cfg, 0);
 }
@@ -1118,7 +1114,7 @@ static inline bool gve_is_gqi(struct gve_priv *priv)
=20
 static inline u32 gve_num_tx_queues(struct gve_priv *priv)
 {
-	return priv->tx_cfg.num_queues + priv->num_xdp_queues;
+	return priv->tx_cfg.num_queues + priv->tx_cfg.num_xdp_queues;
 }
=20
 static inline u32 gve_xdp_tx_queue_id(struct gve_priv *priv, u32 queue_id)
@@ -1234,8 +1230,8 @@ int gve_adjust_config(struct gve_priv *priv,
 		      struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
 		      struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
 int gve_adjust_queues(struct gve_priv *priv,
-		      struct gve_queue_config new_rx_config,
-		      struct gve_queue_config new_tx_config,
+		      struct gve_rx_queue_config new_rx_config,
+		      struct gve_tx_queue_config new_tx_config,
 		      bool reset_rss);
 /* flow steering rule */
 int gve_get_flow_rule_entry(struct gve_priv *priv, struct ethtool_rxnfc *c=
md);
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/et=
hernet/google/gve/gve_ethtool.c
index bc59b5b4235a..a862031ba5d1 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -475,8 +475,8 @@ static int gve_set_channels(struct net_device *netdev,
 			    struct ethtool_channels *cmd)
 {
 	struct gve_priv *priv =3D netdev_priv(netdev);
-	struct gve_queue_config new_tx_cfg =3D priv->tx_cfg;
-	struct gve_queue_config new_rx_cfg =3D priv->rx_cfg;
+	struct gve_tx_queue_config new_tx_cfg =3D priv->tx_cfg;
+	struct gve_rx_queue_config new_rx_cfg =3D priv->rx_cfg;
 	struct ethtool_channels old_settings;
 	int new_tx =3D cmd->tx_count;
 	int new_rx =3D cmd->rx_count;
@@ -491,10 +491,17 @@ static int gve_set_channels(struct net_device *netdev=
,
 	if (!new_rx || !new_tx)
 		return -EINVAL;
=20
-	if (priv->num_xdp_queues &&
-	    (new_tx !=3D new_rx || (2 * new_tx > priv->tx_cfg.max_queues))) {
-		dev_err(&priv->pdev->dev, "XDP load failed: The number of configured RX =
queues should be equal to the number of configured TX queues and the number=
 of configured RX/TX queues should be less than or equal to half the maximu=
m number of RX/TX queues");
-		return -EINVAL;
+	if (priv->xdp_prog) {
+		if (new_tx !=3D new_rx ||
+		    (2 * new_tx > priv->tx_cfg.max_queues)) {
+			dev_err(&priv->pdev->dev, "The number of configured RX queues should be=
 equal to the number of configured TX queues and the number of configured R=
X/TX queues should be less than or equal to half the maximum number of RX/T=
X queues when XDP program is installed");
+			return -EINVAL;
+		}
+
+		/* One XDP TX queue per RX queue. */
+		new_tx_cfg.num_xdp_queues =3D new_rx;
+	} else {
+		new_tx_cfg.num_xdp_queues =3D 0;
 	}
=20
 	if (new_rx !=3D priv->rx_cfg.num_queues &&
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ether=
net/google/gve/gve_main.c
index 6dcdcaf518f4..354f526a9238 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -795,30 +795,13 @@ static struct gve_queue_page_list *gve_rx_get_qpl(str=
uct gve_priv *priv, int idx
 		return rx->dqo.qpl;
 }
=20
-static int gve_register_xdp_qpls(struct gve_priv *priv)
-{
-	int start_id;
-	int err;
-	int i;
-
-	start_id =3D gve_xdp_tx_start_queue_id(priv);
-	for (i =3D start_id; i < start_id + gve_num_xdp_qpls(priv); i++) {
-		err =3D gve_register_qpl(priv, gve_tx_get_qpl(priv, i));
-		/* This failure will trigger a reset - no need to clean up */
-		if (err)
-			return err;
-	}
-	return 0;
-}
-
 static int gve_register_qpls(struct gve_priv *priv)
 {
 	int num_tx_qpls, num_rx_qpls;
 	int err;
 	int i;
=20
-	num_tx_qpls =3D gve_num_tx_qpls(&priv->tx_cfg, gve_num_xdp_qpls(priv),
-				      gve_is_qpl(priv));
+	num_tx_qpls =3D gve_num_tx_qpls(&priv->tx_cfg, gve_is_qpl(priv));
 	num_rx_qpls =3D gve_num_rx_qpls(&priv->rx_cfg, gve_is_qpl(priv));
=20
 	for (i =3D 0; i < num_tx_qpls; i++) {
@@ -836,30 +819,13 @@ static int gve_register_qpls(struct gve_priv *priv)
 	return 0;
 }
=20
-static int gve_unregister_xdp_qpls(struct gve_priv *priv)
-{
-	int start_id;
-	int err;
-	int i;
-
-	start_id =3D gve_xdp_tx_start_queue_id(priv);
-	for (i =3D start_id; i < start_id + gve_num_xdp_qpls(priv); i++) {
-		err =3D gve_unregister_qpl(priv, gve_tx_get_qpl(priv, i));
-		/* This failure will trigger a reset - no need to clean */
-		if (err)
-			return err;
-	}
-	return 0;
-}
-
 static int gve_unregister_qpls(struct gve_priv *priv)
 {
 	int num_tx_qpls, num_rx_qpls;
 	int err;
 	int i;
=20
-	num_tx_qpls =3D gve_num_tx_qpls(&priv->tx_cfg, gve_num_xdp_qpls(priv),
-				      gve_is_qpl(priv));
+	num_tx_qpls =3D gve_num_tx_qpls(&priv->tx_cfg, gve_is_qpl(priv));
 	num_rx_qpls =3D gve_num_rx_qpls(&priv->rx_cfg, gve_is_qpl(priv));
=20
 	for (i =3D 0; i < num_tx_qpls; i++) {
@@ -878,27 +844,6 @@ static int gve_unregister_qpls(struct gve_priv *priv)
 	return 0;
 }
=20
-static int gve_create_xdp_rings(struct gve_priv *priv)
-{
-	int err;
-
-	err =3D gve_adminq_create_tx_queues(priv,
-					  gve_xdp_tx_start_queue_id(priv),
-					  priv->num_xdp_queues);
-	if (err) {
-		netif_err(priv, drv, priv->dev, "failed to create %d XDP tx queues\n",
-			  priv->num_xdp_queues);
-		/* This failure will trigger a reset - no need to clean
-		 * up
-		 */
-		return err;
-	}
-	netif_dbg(priv, drv, priv->dev, "created %d XDP tx queues\n",
-		  priv->num_xdp_queues);
-
-	return 0;
-}
-
 static int gve_create_rings(struct gve_priv *priv)
 {
 	int num_tx_queues =3D gve_num_tx_queues(priv);
@@ -954,7 +899,7 @@ static void init_xdp_sync_stats(struct gve_priv *priv)
 	int i;
=20
 	/* Init stats */
-	for (i =3D start_id; i < start_id + priv->num_xdp_queues; i++) {
+	for (i =3D start_id; i < start_id + priv->tx_cfg.num_xdp_queues; i++) {
 		int ntfy_idx =3D gve_tx_idx_to_ntfy(priv, i);
=20
 		u64_stats_init(&priv->tx[i].statss);
@@ -979,24 +924,21 @@ static void gve_init_sync_stats(struct gve_priv *priv=
)
 static void gve_tx_get_curr_alloc_cfg(struct gve_priv *priv,
 				      struct gve_tx_alloc_rings_cfg *cfg)
 {
-	int num_xdp_queues =3D priv->xdp_prog ? priv->rx_cfg.num_queues : 0;
-
 	cfg->qcfg =3D &priv->tx_cfg;
 	cfg->raw_addressing =3D !gve_is_qpl(priv);
 	cfg->ring_size =3D priv->tx_desc_cnt;
-	cfg->start_idx =3D 0;
-	cfg->num_rings =3D priv->tx_cfg.num_queues + num_xdp_queues;
+	cfg->num_xdp_rings =3D cfg->qcfg->num_xdp_queues;
 	cfg->tx =3D priv->tx;
 }
=20
-static void gve_tx_stop_rings(struct gve_priv *priv, int start_id, int num=
_rings)
+static void gve_tx_stop_rings(struct gve_priv *priv, int num_rings)
 {
 	int i;
=20
 	if (!priv->tx)
 		return;
=20
-	for (i =3D start_id; i < start_id + num_rings; i++) {
+	for (i =3D 0; i < num_rings; i++) {
 		if (gve_is_gqi(priv))
 			gve_tx_stop_ring_gqi(priv, i);
 		else
@@ -1004,12 +946,11 @@ static void gve_tx_stop_rings(struct gve_priv *priv,=
 int start_id, int num_rings
 	}
 }
=20
-static void gve_tx_start_rings(struct gve_priv *priv, int start_id,
-			       int num_rings)
+static void gve_tx_start_rings(struct gve_priv *priv, int num_rings)
 {
 	int i;
=20
-	for (i =3D start_id; i < start_id + num_rings; i++) {
+	for (i =3D 0; i < num_rings; i++) {
 		if (gve_is_gqi(priv))
 			gve_tx_start_ring_gqi(priv, i);
 		else
@@ -1017,28 +958,6 @@ static void gve_tx_start_rings(struct gve_priv *priv,=
 int start_id,
 	}
 }
=20
-static int gve_alloc_xdp_rings(struct gve_priv *priv)
-{
-	struct gve_tx_alloc_rings_cfg cfg =3D {0};
-	int err =3D 0;
-
-	if (!priv->num_xdp_queues)
-		return 0;
-
-	gve_tx_get_curr_alloc_cfg(priv, &cfg);
-	cfg.start_idx =3D gve_xdp_tx_start_queue_id(priv);
-	cfg.num_rings =3D priv->num_xdp_queues;
-
-	err =3D gve_tx_alloc_rings_gqi(priv, &cfg);
-	if (err)
-		return err;
-
-	gve_tx_start_rings(priv, cfg.start_idx, cfg.num_rings);
-	init_xdp_sync_stats(priv);
-
-	return 0;
-}
-
 static int gve_queues_mem_alloc(struct gve_priv *priv,
 				struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
 				struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
@@ -1069,26 +988,6 @@ static int gve_queues_mem_alloc(struct gve_priv *priv=
,
 	return err;
 }
=20
-static int gve_destroy_xdp_rings(struct gve_priv *priv)
-{
-	int start_id;
-	int err;
-
-	start_id =3D gve_xdp_tx_start_queue_id(priv);
-	err =3D gve_adminq_destroy_tx_queues(priv,
-					   start_id,
-					   priv->num_xdp_queues);
-	if (err) {
-		netif_err(priv, drv, priv->dev,
-			  "failed to destroy XDP queues\n");
-		/* This failure will trigger a reset - no need to clean up */
-		return err;
-	}
-	netif_dbg(priv, drv, priv->dev, "destroyed XDP queues\n");
-
-	return 0;
-}
-
 static int gve_destroy_rings(struct gve_priv *priv)
 {
 	int num_tx_queues =3D gve_num_tx_queues(priv);
@@ -1113,20 +1012,6 @@ static int gve_destroy_rings(struct gve_priv *priv)
 	return 0;
 }
=20
-static void gve_free_xdp_rings(struct gve_priv *priv)
-{
-	struct gve_tx_alloc_rings_cfg cfg =3D {0};
-
-	gve_tx_get_curr_alloc_cfg(priv, &cfg);
-	cfg.start_idx =3D gve_xdp_tx_start_queue_id(priv);
-	cfg.num_rings =3D priv->num_xdp_queues;
-
-	if (priv->tx) {
-		gve_tx_stop_rings(priv, cfg.start_idx, cfg.num_rings);
-		gve_tx_free_rings_gqi(priv, &cfg);
-	}
-}
-
 static void gve_queues_mem_free(struct gve_priv *priv,
 				struct gve_tx_alloc_rings_cfg *tx_cfg,
 				struct gve_rx_alloc_rings_cfg *rx_cfg)
@@ -1253,7 +1138,7 @@ static int gve_reg_xdp_info(struct gve_priv *priv, st=
ruct net_device *dev)
 	int i, j;
 	u32 tx_qid;
=20
-	if (!priv->num_xdp_queues)
+	if (!priv->tx_cfg.num_xdp_queues)
 		return 0;
=20
 	for (i =3D 0; i < priv->rx_cfg.num_queues; i++) {
@@ -1283,7 +1168,7 @@ static int gve_reg_xdp_info(struct gve_priv *priv, st=
ruct net_device *dev)
 		}
 	}
=20
-	for (i =3D 0; i < priv->num_xdp_queues; i++) {
+	for (i =3D 0; i < priv->tx_cfg.num_xdp_queues; i++) {
 		tx_qid =3D gve_xdp_tx_queue_id(priv, i);
 		priv->tx[tx_qid].xsk_pool =3D xsk_get_pool_from_qid(dev, i);
 	}
@@ -1304,7 +1189,7 @@ static void gve_unreg_xdp_info(struct gve_priv *priv)
 {
 	int i, tx_qid;
=20
-	if (!priv->num_xdp_queues)
+	if (!priv->tx_cfg.num_xdp_queues || !priv->rx || !priv->tx)
 		return;
=20
 	for (i =3D 0; i < priv->rx_cfg.num_queues; i++) {
@@ -1317,7 +1202,7 @@ static void gve_unreg_xdp_info(struct gve_priv *priv)
 		}
 	}
=20
-	for (i =3D 0; i < priv->num_xdp_queues; i++) {
+	for (i =3D 0; i < priv->tx_cfg.num_xdp_queues; i++) {
 		tx_qid =3D gve_xdp_tx_queue_id(priv, i);
 		priv->tx[tx_qid].xsk_pool =3D NULL;
 	}
@@ -1334,7 +1219,7 @@ static void gve_drain_page_cache(struct gve_priv *pri=
v)
 static void gve_rx_get_curr_alloc_cfg(struct gve_priv *priv,
 				      struct gve_rx_alloc_rings_cfg *cfg)
 {
-	cfg->qcfg =3D &priv->rx_cfg;
+	cfg->qcfg_rx =3D &priv->rx_cfg;
 	cfg->qcfg_tx =3D &priv->tx_cfg;
 	cfg->raw_addressing =3D !gve_is_qpl(priv);
 	cfg->enable_header_split =3D priv->header_split_enabled;
@@ -1415,17 +1300,13 @@ static int gve_queues_start(struct gve_priv *priv,
=20
 	/* Record new configs into priv */
 	priv->tx_cfg =3D *tx_alloc_cfg->qcfg;
-	priv->rx_cfg =3D *rx_alloc_cfg->qcfg;
+	priv->tx_cfg.num_xdp_queues =3D tx_alloc_cfg->num_xdp_rings;
+	priv->rx_cfg =3D *rx_alloc_cfg->qcfg_rx;
 	priv->tx_desc_cnt =3D tx_alloc_cfg->ring_size;
 	priv->rx_desc_cnt =3D rx_alloc_cfg->ring_size;
=20
-	if (priv->xdp_prog)
-		priv->num_xdp_queues =3D priv->rx_cfg.num_queues;
-	else
-		priv->num_xdp_queues =3D 0;
-
-	gve_tx_start_rings(priv, 0, tx_alloc_cfg->num_rings);
-	gve_rx_start_rings(priv, rx_alloc_cfg->qcfg->num_queues);
+	gve_tx_start_rings(priv, gve_num_tx_queues(priv));
+	gve_rx_start_rings(priv, rx_alloc_cfg->qcfg_rx->num_queues);
 	gve_init_sync_stats(priv);
=20
 	err =3D netif_set_real_num_tx_queues(dev, priv->tx_cfg.num_queues);
@@ -1477,7 +1358,7 @@ static int gve_queues_start(struct gve_priv *priv,
 	/* return the original error */
 	return err;
 stop_and_free_rings:
-	gve_tx_stop_rings(priv, 0, gve_num_tx_queues(priv));
+	gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
 	gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
 	gve_queues_mem_remove(priv);
 	return err;
@@ -1526,7 +1407,7 @@ static int gve_queues_stop(struct gve_priv *priv)
=20
 	gve_unreg_xdp_info(priv);
=20
-	gve_tx_stop_rings(priv, 0, gve_num_tx_queues(priv));
+	gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
 	gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
=20
 	priv->interface_down_cnt++;
@@ -1556,56 +1437,6 @@ static int gve_close(struct net_device *dev)
 	return 0;
 }
=20
-static int gve_remove_xdp_queues(struct gve_priv *priv)
-{
-	int err;
-
-	err =3D gve_destroy_xdp_rings(priv);
-	if (err)
-		return err;
-
-	err =3D gve_unregister_xdp_qpls(priv);
-	if (err)
-		return err;
-
-	gve_unreg_xdp_info(priv);
-	gve_free_xdp_rings(priv);
-
-	priv->num_xdp_queues =3D 0;
-	return 0;
-}
-
-static int gve_add_xdp_queues(struct gve_priv *priv)
-{
-	int err;
-
-	priv->num_xdp_queues =3D priv->rx_cfg.num_queues;
-
-	err =3D gve_alloc_xdp_rings(priv);
-	if (err)
-		goto err;
-
-	err =3D gve_reg_xdp_info(priv, priv->dev);
-	if (err)
-		goto free_xdp_rings;
-
-	err =3D gve_register_xdp_qpls(priv);
-	if (err)
-		goto free_xdp_rings;
-
-	err =3D gve_create_xdp_rings(priv);
-	if (err)
-		goto free_xdp_rings;
-
-	return 0;
-
-free_xdp_rings:
-	gve_free_xdp_rings(priv);
-err:
-	priv->num_xdp_queues =3D 0;
-	return err;
-}
-
 static void gve_handle_link_status(struct gve_priv *priv, bool link_status=
)
 {
 	if (!gve_get_napi_enabled(priv))
@@ -1623,6 +1454,18 @@ static void gve_handle_link_status(struct gve_priv *=
priv, bool link_status)
 	}
 }
=20
+static int gve_configure_rings_xdp(struct gve_priv *priv,
+				   u16 num_xdp_rings)
+{
+	struct gve_tx_alloc_rings_cfg tx_alloc_cfg =3D {0};
+	struct gve_rx_alloc_rings_cfg rx_alloc_cfg =3D {0};
+
+	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
+	tx_alloc_cfg.num_xdp_rings =3D num_xdp_rings;
+
+	return gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
+}
+
 static int gve_set_xdp(struct gve_priv *priv, struct bpf_prog *prog,
 		       struct netlink_ext_ack *extack)
 {
@@ -1635,29 +1478,26 @@ static int gve_set_xdp(struct gve_priv *priv, struc=
t bpf_prog *prog,
 		WRITE_ONCE(priv->xdp_prog, prog);
 		if (old_prog)
 			bpf_prog_put(old_prog);
+
+		/* Update priv XDP queue configuration */
+		priv->tx_cfg.num_xdp_queues =3D priv->xdp_prog ?
+			priv->rx_cfg.num_queues : 0;
 		return 0;
 	}
=20
-	gve_turndown(priv);
-	if (!old_prog && prog) {
-		// Allocate XDP TX queues if an XDP program is
-		// being installed
-		err =3D gve_add_xdp_queues(priv);
-		if (err)
-			goto out;
-	} else if (old_prog && !prog) {
-		// Remove XDP TX queues if an XDP program is
-		// being uninstalled
-		err =3D gve_remove_xdp_queues(priv);
-		if (err)
-			goto out;
-	}
+	if (!old_prog && prog)
+		err =3D gve_configure_rings_xdp(priv, priv->rx_cfg.num_queues);
+	else if (old_prog && !prog)
+		err =3D gve_configure_rings_xdp(priv, 0);
+
+	if (err)
+		goto out;
+
 	WRITE_ONCE(priv->xdp_prog, prog);
 	if (old_prog)
 		bpf_prog_put(old_prog);
=20
 out:
-	gve_turnup(priv);
 	status =3D ioread32be(&priv->reg_bar0->device_status);
 	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status)=
;
 	return err;
@@ -1908,13 +1748,12 @@ int gve_adjust_config(struct gve_priv *priv,
 }
=20
 int gve_adjust_queues(struct gve_priv *priv,
-		      struct gve_queue_config new_rx_config,
-		      struct gve_queue_config new_tx_config,
+		      struct gve_rx_queue_config new_rx_config,
+		      struct gve_tx_queue_config new_tx_config,
 		      bool reset_rss)
 {
 	struct gve_tx_alloc_rings_cfg tx_alloc_cfg =3D {0};
 	struct gve_rx_alloc_rings_cfg rx_alloc_cfg =3D {0};
-	int num_xdp_queues;
 	int err;
=20
 	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
@@ -1922,13 +1761,8 @@ int gve_adjust_queues(struct gve_priv *priv,
 	/* Relay the new config from ethtool */
 	tx_alloc_cfg.qcfg =3D &new_tx_config;
 	rx_alloc_cfg.qcfg_tx =3D &new_tx_config;
-	rx_alloc_cfg.qcfg =3D &new_rx_config;
+	rx_alloc_cfg.qcfg_rx =3D &new_rx_config;
 	rx_alloc_cfg.reset_rss =3D reset_rss;
-	tx_alloc_cfg.num_rings =3D new_tx_config.num_queues;
-
-	/* Add dedicated XDP TX queues if enabled. */
-	num_xdp_queues =3D priv->xdp_prog ? new_rx_config.num_queues : 0;
-	tx_alloc_cfg.num_rings +=3D num_xdp_queues;
=20
 	if (netif_running(priv->dev)) {
 		err =3D gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
@@ -2056,7 +1890,7 @@ static void gve_turnup(struct gve_priv *priv)
 		napi_schedule(&block->napi);
 	}
=20
-	if (priv->num_xdp_queues && gve_supports_xdp_xmit(priv))
+	if (priv->tx_cfg.num_xdp_queues && gve_supports_xdp_xmit(priv))
 		xdp_features_set_redirect_target(priv->dev, false);
=20
 	gve_set_napi_enabled(priv);
@@ -2412,6 +2246,7 @@ static int gve_init_priv(struct gve_priv *priv, bool =
skip_describe_device)
 		priv->rx_cfg.num_queues =3D min_t(int, priv->default_num_queues,
 						priv->rx_cfg.num_queues);
 	}
+	priv->tx_cfg.num_xdp_queues =3D 0;
=20
 	dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
 		 priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/etherne=
t/google/gve/gve_rx.c
index acb73d4d0de6..7b774cc510cc 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -385,12 +385,12 @@ int gve_rx_alloc_rings_gqi(struct gve_priv *priv,
 	int err =3D 0;
 	int i, j;
=20
-	rx =3D kvcalloc(cfg->qcfg->max_queues, sizeof(struct gve_rx_ring),
+	rx =3D kvcalloc(cfg->qcfg_rx->max_queues, sizeof(struct gve_rx_ring),
 		      GFP_KERNEL);
 	if (!rx)
 		return -ENOMEM;
=20
-	for (i =3D 0; i < cfg->qcfg->num_queues; i++) {
+	for (i =3D 0; i < cfg->qcfg_rx->num_queues; i++) {
 		err =3D gve_rx_alloc_ring_gqi(priv, cfg, &rx[i], i);
 		if (err) {
 			netif_err(priv, drv, priv->dev,
@@ -419,7 +419,7 @@ void gve_rx_free_rings_gqi(struct gve_priv *priv,
 	if (!rx)
 		return;
=20
-	for (i =3D 0; i < cfg->qcfg->num_queues;  i++)
+	for (i =3D 0; i < cfg->qcfg_rx->num_queues;  i++)
 		gve_rx_free_ring_gqi(priv, &rx[i], cfg);
=20
 	kvfree(rx);
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/eth=
ernet/google/gve/gve_rx_dqo.c
index 856ade0c209f..dcdad6d09bf3 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -299,12 +299,12 @@ int gve_rx_alloc_rings_dqo(struct gve_priv *priv,
 	int err;
 	int i;
=20
-	rx =3D kvcalloc(cfg->qcfg->max_queues, sizeof(struct gve_rx_ring),
+	rx =3D kvcalloc(cfg->qcfg_rx->max_queues, sizeof(struct gve_rx_ring),
 		      GFP_KERNEL);
 	if (!rx)
 		return -ENOMEM;
=20
-	for (i =3D 0; i < cfg->qcfg->num_queues; i++) {
+	for (i =3D 0; i < cfg->qcfg_rx->num_queues; i++) {
 		err =3D gve_rx_alloc_ring_dqo(priv, cfg, &rx[i], i);
 		if (err) {
 			netif_err(priv, drv, priv->dev,
@@ -333,7 +333,7 @@ void gve_rx_free_rings_dqo(struct gve_priv *priv,
 	if (!rx)
 		return;
=20
-	for (i =3D 0; i < cfg->qcfg->num_queues;  i++)
+	for (i =3D 0; i < cfg->qcfg_rx->num_queues;  i++)
 		gve_rx_free_ring_dqo(priv, &rx[i], cfg);
=20
 	kvfree(rx);
diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/etherne=
t/google/gve/gve_tx.c
index c8c067e18059..1b40bf0c811a 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -334,27 +334,23 @@ int gve_tx_alloc_rings_gqi(struct gve_priv *priv,
 			   struct gve_tx_alloc_rings_cfg *cfg)
 {
 	struct gve_tx_ring *tx =3D cfg->tx;
+	int total_queues;
 	int err =3D 0;
 	int i, j;
=20
-	if (cfg->start_idx + cfg->num_rings > cfg->qcfg->max_queues) {
+	total_queues =3D cfg->qcfg->num_queues + cfg->num_xdp_rings;
+	if (total_queues > cfg->qcfg->max_queues) {
 		netif_err(priv, drv, priv->dev,
 			  "Cannot alloc more than the max num of Tx rings\n");
 		return -EINVAL;
 	}
=20
-	if (cfg->start_idx =3D=3D 0) {
-		tx =3D kvcalloc(cfg->qcfg->max_queues, sizeof(struct gve_tx_ring),
-			      GFP_KERNEL);
-		if (!tx)
-			return -ENOMEM;
-	} else if (!tx) {
-		netif_err(priv, drv, priv->dev,
-			  "Cannot alloc tx rings from a nonzero start idx without tx array\n");
-		return -EINVAL;
-	}
+	tx =3D kvcalloc(cfg->qcfg->max_queues, sizeof(struct gve_tx_ring),
+		      GFP_KERNEL);
+	if (!tx)
+		return -ENOMEM;
=20
-	for (i =3D cfg->start_idx; i < cfg->start_idx + cfg->num_rings; i++) {
+	for (i =3D 0; i < total_queues; i++) {
 		err =3D gve_tx_alloc_ring_gqi(priv, cfg, &tx[i], i);
 		if (err) {
 			netif_err(priv, drv, priv->dev,
@@ -370,8 +366,7 @@ int gve_tx_alloc_rings_gqi(struct gve_priv *priv,
 cleanup:
 	for (j =3D 0; j < i; j++)
 		gve_tx_free_ring_gqi(priv, &tx[j], cfg);
-	if (cfg->start_idx =3D=3D 0)
-		kvfree(tx);
+	kvfree(tx);
 	return err;
 }
=20
@@ -384,13 +379,11 @@ void gve_tx_free_rings_gqi(struct gve_priv *priv,
 	if (!tx)
 		return;
=20
-	for (i =3D cfg->start_idx; i < cfg->start_idx + cfg->num_rings; i++)
+	for (i =3D 0; i < cfg->qcfg->num_queues + cfg->qcfg->num_xdp_queues; i++)
 		gve_tx_free_ring_gqi(priv, &tx[i], cfg);
=20
-	if (cfg->start_idx =3D=3D 0) {
-		kvfree(tx);
-		cfg->tx =3D NULL;
-	}
+	kvfree(tx);
+	cfg->tx =3D NULL;
 }
=20
 /* gve_tx_avail - Calculates the number of slots available in the ring
@@ -844,7 +837,7 @@ int gve_xdp_xmit(struct net_device *dev, int n, struct =
xdp_frame **frames,
 		return -ENETDOWN;
=20
 	qid =3D gve_xdp_tx_queue_id(priv,
-				  smp_processor_id() % priv->num_xdp_queues);
+				  smp_processor_id() % priv->tx_cfg.num_xdp_queues);
=20
 	tx =3D &priv->tx[qid];
=20
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/eth=
ernet/google/gve/gve_tx_dqo.c
index 394debc62268..2eba868d8037 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -379,27 +379,23 @@ int gve_tx_alloc_rings_dqo(struct gve_priv *priv,
 			   struct gve_tx_alloc_rings_cfg *cfg)
 {
 	struct gve_tx_ring *tx =3D cfg->tx;
+	int total_queues;
 	int err =3D 0;
 	int i, j;
=20
-	if (cfg->start_idx + cfg->num_rings > cfg->qcfg->max_queues) {
+	total_queues =3D cfg->qcfg->num_queues + cfg->num_xdp_rings;
+	if (total_queues > cfg->qcfg->max_queues) {
 		netif_err(priv, drv, priv->dev,
 			  "Cannot alloc more than the max num of Tx rings\n");
 		return -EINVAL;
 	}
=20
-	if (cfg->start_idx =3D=3D 0) {
-		tx =3D kvcalloc(cfg->qcfg->max_queues, sizeof(struct gve_tx_ring),
-			      GFP_KERNEL);
-		if (!tx)
-			return -ENOMEM;
-	} else if (!tx) {
-		netif_err(priv, drv, priv->dev,
-			  "Cannot alloc tx rings from a nonzero start idx without tx array\n");
-		return -EINVAL;
-	}
+	tx =3D kvcalloc(cfg->qcfg->max_queues, sizeof(struct gve_tx_ring),
+		      GFP_KERNEL);
+	if (!tx)
+		return -ENOMEM;
=20
-	for (i =3D cfg->start_idx; i < cfg->start_idx + cfg->num_rings; i++) {
+	for (i =3D 0; i < total_queues; i++) {
 		err =3D gve_tx_alloc_ring_dqo(priv, cfg, &tx[i], i);
 		if (err) {
 			netif_err(priv, drv, priv->dev,
@@ -415,8 +411,7 @@ int gve_tx_alloc_rings_dqo(struct gve_priv *priv,
 err:
 	for (j =3D 0; j < i; j++)
 		gve_tx_free_ring_dqo(priv, &tx[j], cfg);
-	if (cfg->start_idx =3D=3D 0)
-		kvfree(tx);
+	kvfree(tx);
 	return err;
 }
=20
@@ -429,13 +424,11 @@ void gve_tx_free_rings_dqo(struct gve_priv *priv,
 	if (!tx)
 		return;
=20
-	for (i =3D cfg->start_idx; i < cfg->start_idx + cfg->num_rings; i++)
+	for (i =3D 0; i < cfg->qcfg->num_queues + cfg->qcfg->num_xdp_queues; i++)
 		gve_tx_free_ring_dqo(priv, &tx[i], cfg);
=20
-	if (cfg->start_idx =3D=3D 0) {
-		kvfree(tx);
-		cfg->tx =3D NULL;
-	}
+	kvfree(tx);
+	cfg->tx =3D NULL;
 }
=20
 /* Returns the number of slots available in the ring */
--=20
2.49.0.rc1.451.g8f38331e32-goog


