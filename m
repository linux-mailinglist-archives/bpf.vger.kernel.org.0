Return-Path: <bpf+bounces-73899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8A7C3D3D7
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 20:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FC43B63B8
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 19:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C4D355800;
	Thu,  6 Nov 2025 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GCvW05bH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF042355025
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457298; cv=none; b=OWBFkPseVJkcUFOnJFGAl+jD6qwcR5+0LxVRZVKEylp6mBgnIr4zy3VoOzigSyTLgK6MahyarsECNV93qGotCxVrMoSL0T5CfBwFw/eOu7hdzEyw0E/psuFoYkWB1n9FO+rhMxay+wVukykzNTbCtTr0+5NcJnez5mL5PU0Q3C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457298; c=relaxed/simple;
	bh=pcL4mwaNz826zqpYk9r6miFynK/UjPiuyy50810qFLw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f3XYrYF1VtZSDwu+ptAZVI6EeFioryi5JfTdx3HOPJ49NcpbK07KDtTZEeder6ufnSlg9T2joctmGjnfDtF9SPAKMK+MwK4ge/Wdp8qzGStsvQiu2H8oOL148O7KJWvilXbdqQdYMVwSKkunkjbn2d2cel9ht2WwVKzy1zUfZ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GCvW05bH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b993eb2701bso1144480a12.0
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 11:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762457296; x=1763062096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iKgJEyI/mY8AR1xsdJxGBP2wYE2Ojj7dC3lzuPfMB5Q=;
        b=GCvW05bHps3K0Tca2deUNoeHJJwg8ATqXCoLyOvJwtuv8zprmc+4h+s8vDkd/VQFyN
         TYPmIcBe60XRr9HFkyHkk2tBzRkncUtOjTsSvqE2BMpI9qvc3YLPHzhX2BxkxQArnWQd
         h0FV/uGvLHshQjDgWepPOUCwPslGvYvzljLL1E8eqwdqB763ePZmZMBXrUYPRVKoGh2k
         MLl5b47ahBBCiWprCCuOlWeA2ULHSrreUOxXOpwDfBxI2ajlxRjgnml4W1dqPaIBLhgv
         /jM7A1U7MKpda699DPzr5RykL9NpTyKeuE5uSZnFQimIOOlUX0gnz8+1IrbAzYjdkeVf
         lhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457296; x=1763062096;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKgJEyI/mY8AR1xsdJxGBP2wYE2Ojj7dC3lzuPfMB5Q=;
        b=B4x5Zf2kskOU92S2iTkAD2doNnyqPd0lorfXHZ7GE5YDvma4s9lE1PYFYMCRRU+zZX
         98tqSQVd0ZnPFtKhyCimHhKC6OcY5gMYkhoK+CYXjhN5eABhmHPGx66nqn7mv0wq55J6
         +wn6uNPRMBeBA7MFLBXM/JPQbqAj+xYaDmZrEF2f2Bm3fVa8QNpGZ9IY8EDubp0usK25
         Y5ojhaH/PIRBc/6eltd0cJOKcvF1ftp7j2jdOAvEd97HrCoF7f+3mCL3qdIQU2zH5XU3
         Lw5Ztd6uvW2AChguD3gdwhrBCQUN0B4zRB8oWVbe86Ld99/5Rn9MYiJ3RTLB7rK9LnI+
         L5hA==
X-Forwarded-Encrypted: i=1; AJvYcCXHN3iGhKcUgjf+tMPgg37guMLa847bZY9dsD+RHrYuvVuhanjcSjghoAaMzqIUJ9wC+Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNwnB/fzMmQoH7Akan9zsaSrgYWXnJ+aNEdtOi9Dtqt6YMC/KW
	EHEtxwBgtU6hi8oJ+QAAfR3I8mMifFAVDGfF06/bcIwQi+vzeXnPFR24MAF/Fo5BO2yspYaShvO
	4moYhfN7R02jL5g==
X-Google-Smtp-Source: AGHT+IHuoC9uSzkGJMnKST7Musb48MfIxk+yGYWyESYp6VWPanJk3sFt8EEnKt8WNeVDhpt7ClFHwkP8aV18dQ==
X-Received: from pjvp5.prod.google.com ([2002:a17:90a:df85:b0:340:e523:10dd])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3885:b0:340:bb64:c5e with SMTP id 98e67ed59e1d1-3434c4fa855mr370595a91.14.1762457295919;
 Thu, 06 Nov 2025 11:28:15 -0800 (PST)
Date: Thu,  6 Nov 2025 11:27:44 -0800
In-Reply-To: <20251106192746.243525-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106192746.243525-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106192746.243525-3-joshwash@google.com>
Subject: [PATCH net-next v3 2/4] gve: Use extack to log xdp config
 verification errors
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	John Fraker <jfraker@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Ankit Garg <nktgrg@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

Plumb extack as it allows us to send more detailed error messages back
and append 'gve' suffix to method name per convention.

NL_SET_ERR_MSG_FMT_MOD doesn't support format string longer than 80
chars so keeping netdev warning with actual queue count details.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
Changes in v3:
* Removed newline from extack messages (Jakub Kicinski)

Changes in v2:
* Add this patch to the series for RX buffer length management
  (Jakub Kicinski)
---
 drivers/net/ethernet/google/gve/gve_main.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 453e40a..c1d9916 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1707,18 +1707,21 @@ static int gve_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 	return 0;
 }
 
-static int verify_xdp_configuration(struct net_device *dev)
+static int gve_verify_xdp_configuration(struct net_device *dev,
+					struct netlink_ext_ack *extack)
 {
 	struct gve_priv *priv = netdev_priv(dev);
 	u16 max_xdp_mtu;
 
 	if (dev->features & NETIF_F_LRO) {
-		netdev_warn(dev, "XDP is not supported when LRO is on.\n");
+		NL_SET_ERR_MSG_MOD(extack,
+				   "XDP is not supported when LRO is on.");
 		return -EOPNOTSUPP;
 	}
 
 	if (priv->header_split_enabled) {
-		netdev_warn(dev, "XDP is not supported when header-data split is enabled.\n");
+		NL_SET_ERR_MSG_MOD(extack,
+				   "XDP is not supported when header-data split is enabled.");
 		return -EOPNOTSUPP;
 	}
 
@@ -1727,17 +1730,20 @@ static int verify_xdp_configuration(struct net_device *dev)
 		max_xdp_mtu -= GVE_RX_PAD;
 
 	if (dev->mtu > max_xdp_mtu) {
-		netdev_warn(dev, "XDP is not supported for mtu %d.\n",
-			    dev->mtu);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "XDP is not supported for mtu %d.",
+				       dev->mtu);
 		return -EOPNOTSUPP;
 	}
 
 	if (priv->rx_cfg.num_queues != priv->tx_cfg.num_queues ||
 	    (2 * priv->tx_cfg.num_queues > priv->tx_cfg.max_queues)) {
-		netdev_warn(dev, "XDP load failed: The number of configured RX queues %d should be equal to the number of configured TX queues %d and the number of configured RX/TX queues should be less than or equal to half the maximum number of RX/TX queues %d",
-			    priv->rx_cfg.num_queues,
-			    priv->tx_cfg.num_queues,
+		netdev_warn(dev,
+			    "XDP load failed: The number of configured RX queues %d should be equal to the number of configured TX queues %d and the number of configured RX/TX queues should be less than or equal to half the maximum number of RX/TX queues %d.",
+			    priv->rx_cfg.num_queues, priv->tx_cfg.num_queues,
 			    priv->tx_cfg.max_queues);
+		NL_SET_ERR_MSG_MOD(extack,
+				   "XDP load failed: The number of configured RX queues should be equal to the number of configured TX queues and the number of configured RX/TX queues should be less than or equal to half the maximum number of RX/TX queues");
 		return -EINVAL;
 	}
 	return 0;
@@ -1748,7 +1754,7 @@ static int gve_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	struct gve_priv *priv = netdev_priv(dev);
 	int err;
 
-	err = verify_xdp_configuration(dev);
+	err = gve_verify_xdp_configuration(dev, xdp->extack);
 	if (err)
 		return err;
 	switch (xdp->command) {
-- 
2.51.2.997.g839fc31de9-goog


