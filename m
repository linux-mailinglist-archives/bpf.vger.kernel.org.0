Return-Path: <bpf+bounces-74036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2974C4484A
	for <lists+bpf@lfdr.de>; Sun, 09 Nov 2025 22:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9AD3B02AD
	for <lists+bpf@lfdr.de>; Sun,  9 Nov 2025 21:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A164280329;
	Sun,  9 Nov 2025 21:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AE/QsBKe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A027FB2B;
	Sun,  9 Nov 2025 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762724347; cv=none; b=o5xKJ82BmFNoxhEX3xpPqh9/fijeg/JfY5a2VBIvbz7DnJklybxoAcB8WcIrpjmeffcTQoAv5BGFppVeGYpAOvauUDzyS7WAjlPdys5PR1TZHVZWSpwG+3soBBDMDtfmMy2FHtF5+ovRx1VPYf/OIzTMEpZKTm+0JzcqiDyJex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762724347; c=relaxed/simple;
	bh=CN1oEXUSojkUBmaZlWlvuSVJlA/WWlAbJVlcXldCc2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UCC1CU8JIBevsJS8nALyNvAKJUMRp06EI4CtDAz1iN68f4G7nwHBRHo0PFeGHRj7JOdmV+vB41w7wZvnJBgdUJL0TCT8TfY45vH6cMi/Gir8UuRlNUEO5nHcN0YJr65GA/F2xDa4OT2yPOtZxDLnGJ6qG9O/12/RzNNZZwue3Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AE/QsBKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBEBC4CEF7;
	Sun,  9 Nov 2025 21:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762724347;
	bh=CN1oEXUSojkUBmaZlWlvuSVJlA/WWlAbJVlcXldCc2I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AE/QsBKeL4COZDbWNKyPSb/Yeb4U/0zyaGDjqv6fz7Yf7CZDZasUkJDL9fz2jvP1A
	 guxGCe+ViOhnrhhSbMo4ARJjAB+LGMNHwSNoCASXHrfHftFfwDOYyMV2rffepGqX2J
	 m7jLtHkNq9h6MYUTUl69gmK4j9+mGkgMkaCOoehqY30OB9SDoWRZxrgJQVw0+oB4dI
	 RphQ7zt0ZYEtu9OfwHOQb7mg+M/1ZD57U2qYKkvWDkJHM4JUmU4GYhonLk3LF87t16
	 4EjtEkee052stjebv+wipougewFrKDaIRwEKHF/Otk1APFTM/YBsZwyIEKYz+bgoS2
	 KTVvo0R0iTAFQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Sun, 09 Nov 2025 23:37:56 +0200
Subject: [PATCH net-next v2 6/7] net: ethernet: ti: am65-cpsw: enable zero
 copy in XDP features
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-am65-cpsw-xdp-zc-v2-6-858f60a09d12@kernel.org>
References: <20251109-am65-cpsw-xdp-zc-v2-0-858f60a09d12@kernel.org>
In-Reply-To: <20251109-am65-cpsw-xdp-zc-v2-0-858f60a09d12@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>
Cc: srk@ti.com, Meghana Malladi <m-malladi@ti.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=CN1oEXUSojkUBmaZlWlvuSVJlA/WWlAbJVlcXldCc2I=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBpEQna96yZlfyKuLZK25llM6B9VnnOag/jnGh9D
 91Dvo+PqVeJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCaREJ2gAKCRDSWmvTvnYw
 k+LtEADUgCFmF6aZIvEYu7sabE8u6Bp5lcZDbwYqnRBpvb8Vj4koNaounoTMuRmXWpOpUPIX/Xm
 TWvBAML53q3C79zHyatbDkcp0TymeiAQybxky5gS61YJLI3Ti947kKm/590u+tUsSFcKUeYe/Ny
 Fz3LFHW0Bm/YcGuR7xytB4DAvhra8VO5LhQXVwmIbewxf0OG8R1k8i8jzfY3CUQbRTVeuuUY+j2
 F+GcdAD3WqM9CIKrM1uhBJ9gAhstsl7XB4pVKUMosjJ5NnSwyTrUiDEkrUmx0hgQWtryXu6Yhjd
 bWW2+mYQmPPPssI6C3UROAD9j9sLnufwsY9mDzgQy/ko0jx2kH9KlQ2cp7p7dkIrukRVTXMTGiy
 lp1EgHGhUdjJszxldCwV08sx5O+IecOKlahvuU5GfGDrex0vRiTWe5AP7djJBCqAEySr0hHaG6F
 MtdyUDcfH8vbZau0Jgvaez5btY1MziZwQ0WTxZd2VROvdthaDeFR4pJGI9+ZnfmpJ8yjUCFyp7O
 mgFnof9Vp9f9TJSQhnFYPTQWOqUFsquvYoKvU1pszELddV2Uh9ncX3g9g1xZIECcJOH8suiIUVs
 nJ2cnfLqBvJkF+M4sGBcXkPT1DJ8yZcI2ODkZs5Pmb6RWfxOWysx3rveW7VM7+V77rq8TskBHQq
 ms57HQrnSzz98xQ==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Now that we have the plumbing in for XDP zero copy RX and TX, enable
the zero copy feature flag.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 2e06e7df23ad5249786d081e51434f87dd2a76b5..9d1048eea7e4734873676026906e07babf0345f5 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -3210,7 +3210,8 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
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


