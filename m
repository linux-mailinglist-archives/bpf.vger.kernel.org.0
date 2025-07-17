Return-Path: <bpf+bounces-63574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95049B0860F
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C32218924B3
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 07:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E326A256C7E;
	Thu, 17 Jul 2025 07:01:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E04F227E95;
	Thu, 17 Jul 2025 07:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735680; cv=none; b=l8DPoWj94d34ZmZStgy/Aj0h7H0JebbT8ns0dtBzoa3IurXMKzc6f5k1H9UvEPFMrTTNSGzQselTzKX/1vYw1Rb2fpvqHYzK+iPpyZWKud8vSrq9/leWel4/LqRPYWrsTyYFlJXMtfFMCNDoAGiZpSvFWigL9gbFzen9Lqa2L7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735680; c=relaxed/simple;
	bh=Q0WJqXFfUTyFwOtRRHU+KSzHhbvENu7oXCPyMWGWYfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IwrVlJ+KsWF7lDBOm7mXVehZ91TeoQb+vY+K35bEDNiygp5ncmn5JMFvUnj4n8RiDqZYVJdjFEb60h5ARQlZvazQRCDgs4TOLSxxM8saXWS+zCRx6F1LJ+zER0ggqy2pAoSVPSj/9qe9JpcraHDaw85VHJxCrKniV2le76QAfKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-84-68789fb4f16e
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
Subject: [PATCH net-next v11 11/12] net: ti: icssg-prueth: access ->pp through netmem_desc instead of page
Date: Thu, 17 Jul 2025 16:00:51 +0900
Message-Id: <20250717070052.6358-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250717070052.6358-1-byungchul@sk.com>
References: <20250717070052.6358-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTZxTHfd7nvbXS5E3HtncY42wgZE6ZTpznw+Y1MY8fNCZmHzYztRmv
	tlu5pEiBJcbCaghEilOcoCWClmvNyopAwRa3gkh0m1CQVe6WYNDV6QQaapGuYPz2yzn/8/+f
	kxweK4eYOF6bdkLSp6l1KlZOy5/FVG24cSVHs7G6/UOw2K+z0DdTxYBtPgdqJ5wMeOtFuNk7
	T4GloQXBbGiYA0fhCIaZrjssXKsKYgg1FtNguW+iYc7+CsNUt5+DHs9rGmyOfTBe85gGV0Er
	hs65BPCX9LBQbApjKB87zUJkKMyAO/QvB/nOOgrc/zRz0NtiZqD0VTWGVuNENGtykIH+dgsL
	/T/2IRi7HmHgsScaGKgb4cBsu4TAc6uehXzTZgg0z3Lw4kIXhnHzDlgsM0B35XsQvBdAMFz9
	gIKIy8nBX2O/MNBlb6Vg4FEIQ/BMBQtFz0oQPChvp+CPikYGrPcGqOgeB2EwskDBeW8lC5Om
	cQTeTj8Nl/PMCOwdPgb+c0VPDs9b2B27SGfgOSbOUSsiN+ofUmT67CJFfB13KdJ2aZQjlY4s
	0lS3jlxzPaFIkc+LiaOhkCWOl+c4MjLoYklPWZgmTdZTZLqpHB1Y/bX88xRJpzVI+k+2HZVr
	XC/ycUanLCccrGWMqJwvQjJeFJJFa1kH9ZbNpkfLzAqJos8XwkscK2wSZ/x36CIk57HwZ4zo
	bipbFr0jfCc29+Uvi2ghQfRMz9FLrBC2iLWm2/iN6RrR1vjbMsui9XDpOXaJldGwgatGbslU
	FGwy8cyvNubNwAfi73U++ixSVKIVDUipTTOkqrW65CRNbpo2J+nb9FQHin5czcmFQ070sveg
	Bwk8UsUojjZma5SM2pCZm+pBIo9VsYrzXoNGqUhR5/4g6dOP6LN0UqYHreJp1fuKT4PZKUrh
	uPqE9L0kZUj6t12Kl8UZUbbxyGeRlssrf76Y2LJ667QieQDHf6SKjT0mH71QsHbhKb/t5E8K
	4fSa7V9k7MZu88baxP62u8m6QOnCloqkeHfwcMHtxBKSvjXuqzznziE6YWrznvX3h/cP9yTM
	2qf+pg7xTuuew6f08ZN5ewsXd2Zd/OZ58ZdXJkr8rcaaj7vfbXuoojM16k3rsD5T/T/bKOPB
	bQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHfe5z39rZ5Kay7YrGlzpDJNHNOfQkmuliDDcajdE4DV+kKXdr
	FYpptYJmoWKNsdGqgBEQYhEQCgaaIlK06NKCsDmclEKqImBVBOnwpUAsdXSFxW+/c84/53c+
	HBbLm6h4VqM9LOq0ynQFLSWlO9afXHnzapb6u1GzBErqb9DQFSqjoPZjFlQNOinw2ni48+gj
	ASU1txCMh58y4DjThyHU2k5DedkkhrD9HAklf5tImKifwvDqfoCBDve/JNQ6tsPA9SESXKeb
	MHgmlkPgfAcN50wRDEX9p2iIPolQ0BIeYyDXWU2Ap/SPWDnayMCjWxYKCqYqMTQZB2PCF70U
	dN8uoaH7ZBeC/htRCobcMWuwuo8BS20xAvc9Gw25pjUQbBxn4N2lVgwDlk0wXWiA+9avYPJB
	EMHTyh4Coi4nAw/76yhorW8iwPc8jGHybCkN5n/OI+gpuk3AX6V2Cioe+IjYHbuhN/qJgHyv
	lYYXpgEEXk+AhCsnLAjq7/opeO8ykZs2C57gWyw4n1Ug4abtMSEMX5gmBP/dPwmhufgZI1gd
	R4SG6kSh3DVCCGa/FwuOmjO04PiQxwh9vS5a6CiMkEJDRY4w3FCEdi5KkW5IE9M1BlH37Y+p
	UrXrXS4+5JFkRSarKCMqYs1IwvLcD7zF9JyYYZpL4P3+MJ7hOG41Hwq0k2YkZTHXOZdvaSic
	Dc3jDvCNXbmzIZJbzruHJ8gZlnFJfJWpDf+/dDFfa/99liWxfqQgj55heUzmu2ZkLiCpFc2p
	QXEarSFDqUlPWqU/qM7WarJWqTIzHCj2Ttd/+3TRica7k92IY5FirizVflQtp5QGfXaGG/Es
	VsTJ8r0GtVyWpsw+Juoy9+uOpIt6N1rAkoqvZVv3iqly7lflYfGgKB4SdZ+nBCuJN6J8xZBh
	DRP/0uePBh9/4GWdysSFK6a3vem/skV7IJx5qs6x6+22E+VlrCqnRmpP22X/OWUk2TbR/vD1
	2YQvNlbtsS7tWXZnqKDNt4Rq/kaOrKcrRzxr51/Wdy6iVKGxL5dNGduKn/DrugLHVZ5ffvI2
	f++1hfx1oyuLxX2aa409LQpSr1auTsQ6vfI/eYGsbkoDAAA=
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


