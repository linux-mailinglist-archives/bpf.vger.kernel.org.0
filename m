Return-Path: <bpf+bounces-63874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A399B0BA9F
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 04:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DDA189BDA0
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 02:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232802571C7;
	Mon, 21 Jul 2025 02:18:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B17221D94;
	Mon, 21 Jul 2025 02:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064337; cv=none; b=MazXBQasV81a0+n3/iovk+aK1kG+s3MgcxxHtT1kUNF8UTZS2Pm3WepEQ3M2bu3/qnOwBxhPh3K8HoAuJtcclbFqlaq3L/XHHbVR3/DgCvdUTlnoc2s9bzyzQfJL5ohJWmwroqa8BWVjtZ0JYqoA5WEuw5t3Dg8IuxL+BQStM7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064337; c=relaxed/simple;
	bh=HXMDbfTv00/7A5kkhSM8+20skpcA9dA70cjXrMnYr4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uqcDiXlLCJbsyOcX7Y+GK/BtRXjnVaiJ5b9lvMxu1pg17TcZXTZ0CAV7rX0Q+YmCaiDkZnves8sfoqAKSpEcjhwu0NV5YGibaV6qDomxWLgBckJYWgjE+9ABT46rk3PMXVn6Iu6UtzJTJgm70TB0/JQWF7BUiazMTbKEvC4/OOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-a1-687da386a6f7
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
Subject: [PATCH net-next v12 07/12] octeontx2-pf: access ->pp through netmem_desc instead of page
Date: Mon, 21 Jul 2025 11:18:30 +0900
Message-Id: <20250721021835.63939-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250721021835.63939-1-byungchul@sk.com>
References: <20250721021835.63939-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTdxTH97u/+2pDk5vOuCtu2dL5SMymcz5ysixKXJb9EmdmwmKiZsEi
	N7bykLSIlIUJrobZTGAyY9FiwKKW0gxyy6PDgliYsLkBojZVoLgSCdPaOaqViootZv99cr7n
	ex45h8fqAJPK6/MKJEOeNkfDKmnlw5T6D8vtJbqPzs5QYGt2sXA9Ws9A02wRXLzrYWCkUYRL
	w7MJzdmO4HF8lAP52BiGaF8/C/b6GIZ4y3EabENmGp40P8Nw72qIgwHfCxqa5G0wcWGKBm95
	B4beJ8shVDnAwnHzHIaa4FEW5u/MMdAVj3BwxOOgoOtBGwfD7RUM/PzsPIaO0ruJXpN+Bm50
	2li48f11BEHXPANTvkTDsGOMg4qm0wh8lxtZOGJeB+G2xxw8OtmHYaIiDV5aC+Fq3WKIXQsj
	GD1/i4J5r4eDweAvDPQ1d1Bw8+84htiPtSxYHlYiuFXTScGftS0MNFy7SSXmSAf//HMKqkfq
	WJg0TyAY6Q3RcKasAkFzd4CB/7yJledmbWzaFtIb/hcTz3gDIq2NtykyXfWSIoHuPyjy6+lx
	jtTJB4nbsYrYvf9QxBIYwUR2HmOJPHOCI2N+L0sGrHM0cTccJtPuGrT9nV3KT7OkHH2hZFiz
	aY9S1+px0flRrih09KtSFGQtiOdFYb0Y6V1mQYoFbDxnRklmhZViIBDHSV4krBWjoX7agpQ8
	Fv5KEbvcViopvCloRZc/smCgheWiHG1YiKuEDaJvqhK/Lvqu2NTSs8AKYaMYShw/yepETvi+
	h0kWFQW7Qhx3DLGvDUvEK44AXYVUdegNJ1Lr8wpztfqc9at1pjx90eq9B3JllPi3CyXPd3vQ
	zHC6Dwk80qSo8ukSnZrRFhpNuT4k8lizSEX6i3VqVZbWVCwZDmQYDuZIRh9aytOat1Qfxw5l
	qYV92gIpW5LyJcP/KsUrUkvR/vKgYqg127/V9EmB6vPD6fiLTJetqtO6Yqpk8pErrT57S9n7
	o3RwZWYsY/N3v9fatw6ORpyxfXLXlVM9wfEXv5nKdSbT5W9u3zuz8we1o6j6bP4H1dGeqkvf
	FuxxV9eonw6usDqfthtb5emfyjJ27vhyc/eDk/63P/t6LxdZ815q8VINbdRp167CBqP2FQxi
	2iZrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRTHe97rHA3eltSLRdHoRtE95UghQh96iuxC0O1LjnppQ+dsy6GG
	ZbmKrNSyi6aWppnT0WyarlpWc6hl2dKSlbbVIrFadpmJc9aaRt9+5/zPOf8D54hIaQMdIVIm
	HRA0SfJEGSOmxBtXZS06Xp6hWJqfNxeKTUYGXvjKaKgZToUb7yw0dBp4uOcYJqC4ugHBoL+H
	BfPJXhJ89lYGysuGSPDXnqGg+Lmegl+mERI+tnhYaLP9pqDGHAfuyj4KrCcaSWj+NQc8uW0M
	nNEHSCh0HWMg+CZAw33/AAtHLVUENJc8DoVfbrPgaMih4fzIdRIaM9+FDD9009B1t5iBrqwX
	CFzGIA19tpCrt6qXhZyaywhsDwwMHNWvAO/tQRa+X7CT4M6JhT8FOmgpnQJD7V4EPddfERC0
	WljocN2kwW5qJODlez8JQ6dLGMj+movgVeFdAp6W1NJQ0f6SCO2xFbqDowTkd5Yy8EHvRtDZ
	7KGg6EgOAlOTk4YfVj0VuwY3e7+R2PK2AuF6w2sC9+f9IbCz6QmB71x+y+JScwquq1qAy62f
	CJzt7CSxufokg80/z7G4t9vK4LaCAIXrKg7j/rpCtHnGLvHqvUKiUidolsTEixX1FiOV7GNT
	Pcc2ZSIXk43CRDy3kjdc06MxZrh5vNPpJ8c4nFvG+zytVDYSi0ju2UT+fl0BMSZM5uS8sXtg
	vIHi5vBmX8V4XsJF8ra+XPLf0Jl8Te3DcQ7jonhP6OJjLA3VeD9b6DwkLkUTqlG4MkmnkisT
	IxdrExRpScrUxXvUKjMKfVNlxuhZCxrsWmtDnAjJJkqSqQyFlJbrtGkqG+JFpCxcglvTFVLJ
	XnlauqBR79akJApaG5omomRTJeu3C/FSbp/8gJAgCMmC5r9KiMIiMpFqvj1u7dQiy/H+JREp
	zP6fBneqJr5yzfSOokPEoR0HU3JNFy+WOLbtdMcsbJ9sfNT0ZUXHI8eWz4XPp7hWZ9iGfwcG
	dk5yHObyr45ER9u3uDY97NN0BWarW9KjIrM2jK4LSuL6l2t7TtXvuFSWHnVLHT17lnq6Knbk
	rKctQXclZuFNGaVVyJctIDVa+V+0aG5CSQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool users
should use netmem descriptor and APIs instead.

Make octeontx2-pf access ->pp through netmem_desc instead of page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 99ace381cc78..625bb5a05344 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -1571,7 +1571,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 		cq->pool_ptrs++;
 		if (xsk_buff) {
 			xsk_buff_free(xsk_buff);
-		} else if (page->pp) {
+		} else if (pp_page_to_nmdesc(page)->pp) {
 			page_pool_recycle_direct(pool->page_pool, page);
 		} else {
 			otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
-- 
2.17.1


