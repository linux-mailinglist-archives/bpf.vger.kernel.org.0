Return-Path: <bpf+bounces-58549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DD3ABD491
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 12:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5431BA25D9
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1394026FA4B;
	Tue, 20 May 2025 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcmZeny2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C17E26F45F;
	Tue, 20 May 2025 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747736665; cv=none; b=NnxxCY1SaSAAGtBc5aC8WD0CLuARi6B0AlA46uqMZaMKFWLv06civMccO5gFcqLeFF5+F66kUBLDipTTE+kT0t2gMlepW2IesQ8x8X5btPyd3lpErQrBMGH0GfXwhF6nDc/bAYYWSs/JicG8XYiSC6qx826LwgvYG74zIiMeXkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747736665; c=relaxed/simple;
	bh=7bF1g5BtF5y8HRNr5uPegmqpZJu6hsSnvWmZWf6Q/iY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bCxhhhuCFs0WIZLhokJrRS+aOQV6eox3pD6NuuoEB3b2nNOF+p0lyg/d+EH4ZeGLjeh96kyWTbYyhwnhdrON9a0OdHEF9BEfKOpIkiyYArSVvcBcZGSvZYxqFwkqxeXf4PO9Erewl8fYIhwcEJSkEnD1oJG69NbZ1aYOyfNd7PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcmZeny2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B653C4CEF1;
	Tue, 20 May 2025 10:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747736665;
	bh=7bF1g5BtF5y8HRNr5uPegmqpZJu6hsSnvWmZWf6Q/iY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UcmZeny2V+OVqF1UOuUD8Jh/MQqIacA9L/qr4YU96otM70AsfGSMElfRCKoaN+Xat
	 Wz8sfaaKixrboNcxCObymaQbECItyxTbS171YyPnq4mRPo4Z6jzSUHlZsAD3fgCfv2
	 vGrop3Lve/PsZ9NyZpVt5VneT6dYoRNQ4IqVhpaWPjRPOgBUyibWWPhYOMuTTmCa9v
	 gZrDUGrUznVdjrGqCogC4BkQ7g+ORfjxlEM6sLeVvKy+yQslSBjKAaQQ0iEsE0nU2e
	 6H0Md/fIduMEnyAzViwFlfkQhPx1f5QgE38y3Vz3DrXZsMvgCRy5XPbe/YHILWiFGM
	 B+p7TV31fGyEw==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 20 May 2025 13:23:54 +0300
Subject: [PATCH RFC net-next 5/5] net: ethernet: ti: am65-cpsw: enable zero
 copy in XDP features
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-am65-cpsw-xdp-zc-v1-5-45558024f566@kernel.org>
References: <20250520-am65-cpsw-xdp-zc-v1-0-45558024f566@kernel.org>
In-Reply-To: <20250520-am65-cpsw-xdp-zc-v1-0-45558024f566@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: srk@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1004; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=7bF1g5BtF5y8HRNr5uPegmqpZJu6hsSnvWmZWf6Q/iY=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBoLFg9QqfTMXHaac7LIFLSN7eraJrtyYderlPHO
 EhdBr0HXECJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCaCxYPQAKCRDSWmvTvnYw
 kxhMD/9mdKqlMkzj8if68+vDH5qPukpjWb03+Wk/8S775fc1UwkpQ6gsQhHl5a6MRbjxE0j3kIg
 QP1x7fmCuM4IT0RGVKoZ9a1oS5k+7DhJJ5KJ2CLT3/NFNoxuBXZGFY+2PDMKkkG6DUGidwk7dC6
 PVOajDtNuKysAC9yXvnDP9om5Y28gd3Tn1wcn8g9ofDDZLRh50l+Nbk2QYLN6Zlv9GnDGRX/4qX
 ndWVkJDDmDFwz2GSfNMqZ7PpSP7g/ZHNCGHUrL3lSas+CNnFwYS9yCfJ2Akl/2eroFike45WlHg
 1MoKQBPhdE5yrl/lV4eDM76hJEggnbeuEawryBw0RxbOlpESBSEf2pP3pCDopevaUkZb2IbJEfz
 Dx4NayeRCxozAfQjlCVX7nD1ZHN1p0UILfBLl5JXoEb7hq9I5wY7onBmLrmVfh+TiPX8rR9h8Kb
 U57jsFJeqAp9jWOqa6IyKaeHyjPCpSCnes2lke5msQ9CtkJ1HqfHeWf/7cv/zfWxbYfvxeV0aG2
 Sq6yRxj0JICaUvv+cbWPjKchwbsn8RXWo6aX0l1+Jb7btIJyRQvgLB3nvmvHrpWbDm/a1VvcU4K
 PuKRIw398Y29PWrfsqBhGBNdcMUUdQGG1hZ0bGhr6dBb4S9Q67i+ceWAVyyFf/UE5AWiL1yQq2R
 gBEcc5+KQtzlzRw==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Now that we have the plumbing in for XDP zero copy RX and TX, enable
the zero copy feature flag.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index e89b3cefcb05..894a0bd2a810 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -3173,7 +3173,8 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
 			       NETIF_F_HW_VLAN_CTAG_FILTER;
 	port->ndev->xdp_features = NETDEV_XDP_ACT_BASIC |
 				   NETDEV_XDP_ACT_REDIRECT |
-				   NETDEV_XDP_ACT_NDO_XMIT;
+				   NETDEV_XDP_ACT_NDO_XMIT |
+				   NETDEV_XDP_ACT_XSK_ZEROCOPY;
 	port->ndev->vlan_features |=  NETIF_F_SG;
 	port->ndev->netdev_ops = &am65_cpsw_nuss_netdev_ops;
 	port->ndev->ethtool_ops = &am65_cpsw_ethtool_ops_slave;

-- 
2.34.1


