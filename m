Return-Path: <bpf+bounces-63878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625A8B0BAB0
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 04:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8215217AEA4
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 02:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5CE262FE7;
	Mon, 21 Jul 2025 02:19:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6CE22DFB6;
	Mon, 21 Jul 2025 02:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064339; cv=none; b=FoUfbbrf0FNZKKp3mBdKIiy5emqZZI5BpmkAZdVGn6ki5yvyoSJYtrw19J2mfJ4qgJvAonocgFYo8Wh0x8S8dH8tkuBt/5Fi8MEz1qMuvYVeJ0MG7Lqs0kMjYal1NbpmfqP6K4LsJl5fIG1LcIXK8llFgR58ly0s+NqqNE7bQ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064339; c=relaxed/simple;
	bh=Q0WJqXFfUTyFwOtRRHU+KSzHhbvENu7oXCPyMWGWYfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ekLbsGnxQMhhibmiHHoCCjoTRZLbMS78uebFpZGV3uQ/a0bkXarQvbQ+3Sg4Z7a2TtX8nfE6sSA2bIvY1bGZbQ3v0zynIlhZ+jf1QFt0zAcIzBe5j2pS1+3Yih+nKqFfpEP+Bw2oQddeAAiFTgm6i9UrNNAmcw1FYkOiQXEPmpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-ec-687da387f9c4
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
Subject: [PATCH net-next v12 11/12] net: ti: icssg-prueth: access ->pp through netmem_desc instead of page
Date: Mon, 21 Jul 2025 11:18:34 +0900
Message-Id: <20250721021835.63939-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250721021835.63939-1-byungchul@sk.com>
References: <20250721021835.63939-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0yTZxTGfb/3u7WjyZeOzE+N2VLj5iSysXk5f2zTmCx5EzNjdCZmZmHV
	frHduHQFEXBkjOEMDRezeaFSEgilXGNZO2mV4mapwIoyLkqKclvNDM4qDqShFKgtZv/98pyc
	5zkn5/BYOcqs53UZ2ZIhQ52mYuW0/GlC7bazdQXa963zKWC2tbIwOFfLQMtCLjRMuRgYahKh
	Y2CBAnNzO4IX4Qcc2EvGMMx5e1ioqw1hCLeV0WD+q5iGedsihn+6Axz0epZpaLF/BpPWRzS4
	zzoxdM1vhkBFLwtlxREMpokzLETvRxjoDD/joMjVSEHnk6scDLSXM3B+sR6Ds3AqlvVwhIHh
	62YWhn8cRDDRGmXgkScWGGwc46C85TICz+9NLBQVfwjBqy84eH7Bi2GyfA+sVOZAd80bEOoL
	InhQf4+CqNvFQf/EFQa8NicFd/8OYwiVVrNgfFqB4J7pOgW3q9sYsPTdpWJzHIKR6BIFvwzV
	sPCweBLBUFeAhqofyhHYbvgZ+M8dWzmyYGb37CVdwRlMXOMWRH5rGqXI9LkVivhv+Chy7fI4
	R2rsJ4mjcSupcz+miNE/hIm9uYQl9tmfOTI24mZJb2WEJg7L92TaYUIHNn4h/0gjpelyJMN7
	n3wl17qfF2F9lyw3EmpgCpGJNyIZLwrbxbqJAdaI+FX2zR6My6zwjuj3h3GcE4UUcS7QQxuR
	nMfCnQSx01FJxQuvC1+LtVbLKtPCZrHE7qDjrBB2iraVMuqV/5tiS9sfq0aymB6IXT/OSmGH
	GPzXxcRNRaFKJo5WDzKvGtaJNxv99DmkqEFrmpFSl5GTrtalbU/W5mXocpOPZ6bbUezhrAVL
	R11oduCQBwk8UiUo9HSBVsmoc7Ly0j1I5LEqUUF68rVKhUadly8ZMlMNJ9OkLA/awNOqtYoP
	Qqc0SuGEOlv6RpL0kuH/KsXL1heipCf9JWu69fsGTy/NK484FWsXDy9u+/zPLccs/db6DaWe
	Tebv+nqrNBWtuy69fXO5vcL77a96zbPW1PzXPt2d5GwoTc5rO5N9bL84HNV6v3zLl7i8L+ni
	wSup6969Zdrt2/Xx4+5xNtN34HRHypGpWxsrMbo4PXOewIkOuyyMZ34KOVR0lladshUbstQv
	AZbnnIBsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0iTYRTGfb+7q9HXEvswKFpZYGmFFSeKCIx6CYooK+g+6qOt5pRNTQvR
	dBGuNLuipaFoazppspVOmxWbpGk3p8kq8zIprNbVC62ZNoX++53ngfMceA5HymrpCE6lSRa1
	GoVazkgoyba1OdHnyjOUy+v7I6DYUs1A+1AZDebfaXCnz06Du1KAB69+E1BcVYtg2P+OBWtu
	NwlDTc0MlJeNkuCvyaOg+KWeghHLHxI+PPGy0OL8S4HZuhV6jR8pcJyrI8E1Egneiy0M5OkD
	JBT1nGVg4m2Ahkb/Nxay7SYCXCVPg+OX+yy8qs2n4eqf2yTUZfUFAwe6aOhoKGagI6cdQU/1
	BA0fncFUn6mbhXzzDQTOR5UMZOtjwXd/mIUf15pI6M3fAOOFqfCkNBxG23wI3t1+TcCEw87C
	i567NDRZ6gjo7PeTMHqhhAHD14sIXhc1EPCspIaGirZOInjHTuiaGCPgiruUgQF9LwK3y0vB
	zTP5CCwPPTT8dOipDXHY5ftOYvv7CoTvVb4h8GDBOIE9D1sJXH/jPYtLrSnYZorC5Y5PBDZ4
	3CS2VuUy2PrrMou7uxwMbikMUNhWkYkHbUVo+9y9knVHRbUqVdQuW39YonT8yCaTXKFpgdE7
	dBYq4gyI4wR+pdD6a4cBhXIMv1jwePzkJIfxK4QhbzNlQBKO5J9PFxpthcSkMYs/LpQZK6aY
	4iOFXKuNmmQpv1qwjOdN6QI/TzDXPJ5aFBrUvcHGJ1nGrxJ8n+10AZKUopAqFKbSpCYoVOpV
	MboTynSNKi3mSGKCFQW/yZgxdsmOhjs2OxHPIfl0aRKVoZTRilRdeoITCRwpD5Pi5lNKmfSo
	Iv2UqE08pE1RizonmsNR8tnSLXvEwzL+mCJZPCGKSaL2v0twoRFZ6Jn3UiYKoORrcsGbeFrc
	ftVYv7AgLny/IZY9ZmoKWfZ5UUxryskdB52uuw0NEYH49gX6PYu/rInrM8ofrZvR3xmj2bU0
	OnKjvFsyM55G0xo9B0x/nSVK6Yj7/KItYu0YhMQ+jcpSf1c/3r13yb62gWrFUM583fWxW9Hh
	mUvNg5vklE6pWBFFanWKfwvrg4BJAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool users
should use netmem descriptor and APIs instead.

Make icssg-prueth access ->pp through netmem_desc instead of page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index ff5f41bf499e..5e225310c9de 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -367,7 +367,7 @@ static irqreturn_t prueth_rx_mgm_ts_thread_sr1(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	prueth_tx_ts_sr1(emac, (void *)page_address(page));
-	page_pool_recycle_direct(page->pp, page);
+	page_pool_recycle_direct(pp_page_to_nmdesc(page)->pp, page);
 
 	return IRQ_HANDLED;
 }
@@ -392,7 +392,7 @@ static irqreturn_t prueth_rx_mgm_rsp_thread(int irq, void *dev_id)
 		complete(&emac->cmd_complete);
 	}
 
-	page_pool_recycle_direct(page->pp, page);
+	page_pool_recycle_direct(pp_page_to_nmdesc(page)->pp, page);
 
 	return IRQ_HANDLED;
 }
-- 
2.17.1


