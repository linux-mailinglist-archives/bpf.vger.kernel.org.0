Return-Path: <bpf+bounces-60915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE80ADEB44
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 14:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36E83ABF6A
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 12:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3542E88BD;
	Wed, 18 Jun 2025 12:00:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDA42E427C
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248043; cv=none; b=JBDSna7w0UnsMk1Cs4X5+78i2qRTzm96ZRwshBLeIWST1Bbn5WsW2Uzr/gfpVuw5iTJCqfzC/EifXtcdJObbpQHTsvXZggNo/2i6ksN7YXYU/cpI48memCsftYjFLjdi4EknwtVpoalX9xNjmP1xqVxp8M+igBGxRpqrFJEdtMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248043; c=relaxed/simple;
	bh=MPShEsvVEvNuf0LjmYHvci6KO6a8CpEr7YMK5VwHOTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hs0zYVsH+DLWR02XE0GchvmnJEDsRkqOLYbyIMM7dqL6SyLgzalPWNO18ls/J3mSIFiLsd8ARn3IDfDRecClwtguOgW+Sk+sUNn4dtEAp5T/+HANl57hVLokPt5gg6Vqpo7DONmXVfqBSrJx39J2oKHRU/9+KweY1TIcz63ords=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:d189:60c:9a01:7dca])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id 9ADA466FCF6
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 12:00:37 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 6884D42B5D1
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 12:00:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id A776042B519;
	Wed, 18 Jun 2025 12:00:29 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2f0dd5d3;
	Wed, 18 Jun 2025 12:00:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 18 Jun 2025 14:00:07 +0200
Subject: [PATCH net-next v4 07/11] net: fec: fec_enet_rx_queue(): use same
 signature as fec_enet_tx_queue()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-fec-cleanups-v4-7-c16f9a1af124@pengutronix.de>
References: <20250618-fec-cleanups-v4-0-c16f9a1af124@pengutronix.de>
In-Reply-To: <20250618-fec-cleanups-v4-0-c16f9a1af124@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, bpf@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1492; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=MPShEsvVEvNuf0LjmYHvci6KO6a8CpEr7YMK5VwHOTo=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoUqpPl9ICbGyxU/EDp687zMOkAL2bHhyOXMvOD
 NG3He515a6JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaFKqTwAKCRAMdGXf+ZCR
 nBJHB/0egSKcFOAFfweyaha55ag/it4mNYc5fbQsbnoDuTKN+ODJ4QkioqCm4JZA9fE4cQmFCLg
 v+Mw/oOoFRct/Gk50wiGoi+GyFDgrYk5jEdp//Rgdux/YR0+MZB6sgj2Dqt8Jtf3pzI6EKum1Xy
 2wsBVYwcF4Wtfccerfwl9MAquvsmxDlhVf7Wa7K42EtxHLWrdGbAmTi1z+iqQD+LXBvOIBvFpF8
 aVQtPQAjULhJRCLetS+BshjMHmUIifJ9SY7x2iBU7nPnWypN5mCL3aDL9FH/CBN53AFsDQ8ylYF
 x54s1BzMYPKPiUD6LQtVWDF/k0pJ1gpdyGozMTKCkr+TKK1Y
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

There are the functions fec_enet_rx_queue() and fec_enet_tx_queue(),
one for handling the RX queue the other one handles the TX queue.

However they don't have the same signature. Align fec_enet_rx_queue()
argument order with fec_enet_tx_queue() to make code more readable.

Reviewed-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index e4fc1baf114d..9e4164fc0cd1 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1712,7 +1712,7 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
  * effectively tossing the packet.
  */
 static int
-fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
+fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct fec_enet_priv_rx_q *rxq;
@@ -1939,7 +1939,7 @@ static int fec_enet_rx(struct net_device *ndev, int budget)
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_rx_queues - 1; i >= 0; i--)
-		done += fec_enet_rx_queue(ndev, budget - done, i);
+		done += fec_enet_rx_queue(ndev, i, budget - done);
 
 	return done;
 }

-- 
2.47.2



