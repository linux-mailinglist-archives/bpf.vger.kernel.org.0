Return-Path: <bpf+bounces-63568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF87B085F7
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E7F4A2BF5
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 07:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659DF2264C0;
	Thu, 17 Jul 2025 07:01:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334E721C9E9;
	Thu, 17 Jul 2025 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735676; cv=none; b=NyhiylXrgknpsC63XUDpVB63zZShysAgiJc75E/i6QWjCy95z4/JzEK+6wzKdi+msfHVS1cx5157tauTbs8Cqt9RFmWlshFGx7dzxvV2Ym3UeGp4aPEHBGkWVsoPdT6DOkoMxFzLZDu7EVibhnaiMsc7upSANYAEJP430tJ5An8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735676; c=relaxed/simple;
	bh=jZE4z2vlAcgsz6KEgAaLdhF3+0u4GDlDhy48OM3X6x8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jLMas7FFjZlgoE5DiI6OfW9SrpttexFG7K4v5pfPVDORQeql09C3QfV6XodrocXtfAfYbn7qBCqlOeKyXPd6JQs8Z4Se2lCqCpDf4ve/HwP761H9n1G7ZWs7xNquDlfUqELho4HQRaKqoNHOkgz5bg4Gvj+SrFN92IMVg/cnJDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-28-68789fb30299
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	akpm@linux-foundation.org,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	david@redhat.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	jackmanb@google.com,
	wei.fang@nxp.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	bbhushan2@marvell.com,
	tariqt@nvidia.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	saeedm@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	danishanwar@ti.com,
	rogerq@kernel.org,
	nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	m-malladi@ti.com,
	krzysztof.kozlowski@linaro.org,
	matthias.schiffer@ew.tq-group.com,
	robh@kernel.org,
	imx@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v11 06/12] net: fec: access ->pp through netmem_desc instead of page
Date: Thu, 17 Jul 2025 16:00:46 +0900
Message-Id: <20250717070052.6358-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250717070052.6358-1-byungchul@sk.com>
References: <20250717070052.6358-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSe0yTdxT1971pqH6rZvsUH7FKZsiGY2pyF4w6Y8yPbMtY+EPnskkj39ZG
	QFOggo+IWGNsFBQfAS2jhaqFMktakc61KqUiEXVQEaryEtA4LSpPqVW7UuN/J+fcc869yeVI
	2X16DqfKzBbVmYp0OSOhJEPRxi/t5bnKr05dSwS9tYaBtlEjDZbJXDjf56DBWyXAP62TBOir
	LyEYCzxkwXaoi4RRzw0GKo0TJARqj1Cg/1dLwbj1DQmPm/pZaHa/o8Bi+wF6zz2hwHmwnoTG
	8VjoL2pm4Ig2SEJpzwEGQg+CNLgCL1gocJgJcD2vY6H1UiENJ96cJaE+vy/cNdBBw93Legbu
	7m9D0FMTouGJO1zoN3exUGg5jcB9tYqBAu0y8NeNsfDqpIeE3sI18L5EA02GT2GixY/g4dl7
	BIScDhbu9FygwWOtJ6D9UYCEicNlDOiGihDcK71MwK2yWhpMLe1EeI8U6Ai9JeC418DAgLYX
	gbexn4Iz+woRWK/4aBh2hk8OTuqZNWtxo/8liR3dJoQvVt0n8NOj7wnsu3KTwH+f7maxwZaD
	7eY4XOn8j8A6n5fEtupDDLaNFLO4q8PJ4OaSIIXtpr34qb0UJc/bJFmZJqarNKJ66apUiXK0
	swFtL5fmWnR3yHx0U6JDHCfwy4XQyPc6FBWBLc5Bcgoz/OeCzxeI4Fl8gjDaf4PSIQlH8rej
	BZe9hJgSZvK/CoEDRmYKU3ys0Odqjhik4aCG8gLmQ+gCwVJ7LcJH8SuE4IniCC8Lz7RX5LNT
	oQJvjxIOmy8QHwyzhQazjzqKpAY0rRrJVJmaDIUqfXm8Mi9TlRu/ZVuGDYUf7tyet7840Ehr
	ihvxHJJHS1NrdyhltEKTlZfhRgJHymdJj3s1Spk0TZG3U1Rv26zOSRez3CiGo+SfSb+e2JEm
	4/9QZItbRXG7qP6oElzUnHy0bG7C4i8GvkncXTRo3Pjs0d65w23s5mkrFhUvLHt9cjj+avux
	1IwZ1uumtUO/rb89v4FyrqvobN313V9L9v00Y8jw+88bEpPl08Ufv10yGHfQEduzafpF04vr
	62v+TNqyK+CZvyGxsXP12MKxmDrd0qZxP06yb90zM+kTp1bvyb7lEp4lx8ipLKUiIY5UZyn+
	Bwk0ZW1sAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSa0yTZxj1/d7v0jY2+VKrfmHLjJ1mhjjReHuWLcbELLyabTEaNWiMFPtt
	7SiXtNqVJWKF6kYnqKgJaBEYF4GqkHbSCgWlMEHwAgVZN+4XCSrOC5dYYbLCsn/nOed5zjk/
	HglWuJkwiS7+iGiIV+tVrIyWffN56qeuXLN2refcCrCXX2OhbTyfAcdbM1zt9zDgLxWguvUt
	BfaySgQTwS4OnGndGMYbGlkoyJ/CEKxIp8H+yErDZPk7DE/uDnLQ5PuHBofza+grHqHB+5Mb
	Q/3kShg808RCunUaQ3bvSRZm/5pmoCb4NwcpnhIK6nPuhcbnNzlorcxg4MK7IgxuS38ocKiT
	gfYqOwvtqW0Ieq/NMjDiC6WOlXRzkOG4hMB3u5SFFOt6GLs5wcGriw0Y+jK2wvssE9zNWwJT
	LWMIuooeUzDr9XDwsPcGAw3lbgo6BoIYpk7nsGB7cQbB4+wqCu7nVDBQ2NJBhXrshs7ZGQrO
	+/NYGLL2IfDXD9Jw+UQGgvLaAAOvvVZ66zZSP/YSE09PISK/lf5JkdGz7ykSqG2myK1LPRzJ
	cx4lrpJwUuB9ShFbwI+JsyyNJc43mRzp7vSypClrmiauwuNk1JWNdn60X/aFRtTrTKIhYku0
	TDv+Rx1KzJWbHbaH2IKaZTYklQj8BqHFO4znMMt/IgQCwXms5NcJ44ONtA3JJJh/sFCocWVR
	c8Ii/qAQPJnPzmGaXyn01zTNH8hDRnW5Kex/pssER8WdeV7KbxSmL2TO84rQTsevFu4skuWh
	BWVIqYs3xal1+o1rjLHapHidec3hhDgnCr1T8bGZcx400R7pQ7wEqRbKoyt+0CoYtcmYFOdD
	ggSrlPLzfpNWIdeok34UDQmHDEf1otGHPpDQqqXyHfvEaAX/nfqIGCuKiaLhf5WSSMMsKKbN
	cqCh9JBy8vgzzO5JDo97XfRV8S+VA8caR5ePKHcscX84lFyX+uLqlYhdM821muE7VyzUZ7g6
	c3Fq+vWoNO/P+/ynFjT/vqmXPqWJ+VYTOfTcvnl56+5wddflj6t0YYtbYjWriF+6LGv1sDs5
	YW/U96vvu8yVlu0xT76M1O/PkSaqaKNWvS4cG4zqfwG0B/LQSgMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool users
should use netmem descriptor and APIs instead.

Make fec access ->pp through netmem_desc instead of page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index d4eed252ad40..1d0bd6f75368 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1043,7 +1043,9 @@ static void fec_enet_bd_init(struct net_device *dev)
 				struct page *page = txq->tx_buf[i].buf_p;
 
 				if (page)
-					page_pool_put_page(page->pp, page, 0, false);
+					page_pool_put_page(pp_page_to_nmdesc(page)->pp,
+							   page, 0,
+							   false);
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
@@ -1581,7 +1583,8 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			xdp_return_frame_rx_napi(xdpf);
 		} else { /* recycle pages of XDP_TX frames */
 			/* The dma_sync_size = 0 as XDP_TX has already synced DMA for_device */
-			page_pool_put_page(page->pp, page, 0, true);
+			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
+					   0, true);
 		}
 
 		txq->tx_buf[index].buf_p = NULL;
@@ -3343,7 +3346,8 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 			} else {
 				struct page *page = txq->tx_buf[i].buf_p;
 
-				page_pool_put_page(page->pp, page, 0, false);
+				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
+						   page, 0, false);
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
-- 
2.17.1


