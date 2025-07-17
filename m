Return-Path: <bpf+bounces-63575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD14DB08612
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01601A654CB
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 07:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4787F25A33F;
	Thu, 17 Jul 2025 07:01:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F54219A67;
	Thu, 17 Jul 2025 07:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735680; cv=none; b=pJy1leGCHyXGiIF1k0IEhAvrWusq7oCcAQs/OlDj7kEkDiiMKcimopNaAo1esHsn0S1C+3gX4Ztd004BIN2sAG1QW6k+7vyQ+uW7Cj5rzwTe/JYikznXBw1fVihdTQLRPP75DpImvG0Gat3QcvZCOUlV2AAH16s9qXaSq2uERGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735680; c=relaxed/simple;
	bh=L+RgS7V7Au6Ri2a8QuAHoPOcLqT0mibOxx0N+Vk0UOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QSuXFpyRQkk3ZHCgnnW5t/iH8Nhvh3fyoY23gFQCH/bPU7zrD17DxEsbdLa+l+53oecLQo+UHkAAYRiyuN/FvD2mFn8C1AFCJCq67A/XxawiLwOGgCqombQ76QU8MOjXlvdKwHgEcu0dGtHMPezrKordDJ4ddqNSTEhlF1JsNcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-97-68789fb4ad29
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
Subject: [PATCH net-next v11 12/12] libeth: xdp: access ->pp through netmem_desc instead of page
Date: Thu, 17 Jul 2025 16:00:52 +0900
Message-Id: <20250717070052.6358-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250717070052.6358-1-byungchul@sk.com>
References: <20250717070052.6358-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAz1SfUiTexjt935vOHpZcnsrolpXCuN6+9B6oA8iiF6IoK5w/7AoR77cDeeM
	aUuFylIJh63QIvWum1911XXvbH5Nm16bXpVqpVPXVqY5yxZpH5rmXLU2o/47nPOcc54HHgaX
	usmljFKdKmjUcpWMEhPiibDSX+qupSnW6/MjwGC6SUHvVCkJxtk0+PuZhQRHFQe3e2YxMFQ3
	IPjge0KDOXcQh6mOLgrKS2dw8NWcJ8DwMJuAadMcDi86PTR02z4TYDTvg+EbYwRYzzXi0D4d
	AZ4L3RScz/bjUDSUQ0HgsZ+EFt8bGs5aKjFoeV1PQ0+DnoRLc9dxaMx8FuwadZLQ12ygoC+r
	F8HQzQAJY7Zg4XjlIA16YzEC239VFJzN3gTj9R9oeHe5A4dh/U74UqiFzpKfYObeOIIn1wcw
	CFgtNDwY+peEDlMjBv0jPhxm8q5SoJu4gGCgqBmD+1drSKi4148F94gFZ+ATBgWOEgpGs4cR
	ONo9BPx5Ro/A1Ooi4b01eLJ/1kDt3MW3j7/FecvTCsTXVbkx3nvxC8a7Wu9ifFPxU5ovMR/n
	aysj+XLrK4zXuRw4b67OpXjzZD7NDzqtFN9d6Cf42orTvLe2CO1fHifeliColFpB8+uOeLGi
	zcMes1NpTfZ8MhN1kjokYjg2mnOb/vmBP3rniBCm2DWcy+XDQzic3cBNebqCvJjBWXsY11Jb
	iIWERWw81/B/0byBYCO4rAd/USEsYWO4ybFH9LfQFZyxpm0+SBTk/Zfy52ekwbL+skw6FMqx
	10TcgMOCvhmWcHcqXcRFJClBC6qRVKnWJsmVqugoRbpamRZ1NDnJjIIPd+Pkp4MWNNkTa0Ms
	g2RhkviaEwopKdempCfZEMfgsnBJgUOrkEoS5OkZgib5iOa4SkixoWUMIVss2ThzIkHK/iFP
	FRIF4Zig+a5ijGhpJtpiFI08rFr8cUTXXvezvezQaffKhS/LRGv25OyOvCU7peiKzeCuPBLF
	5BVjBzKmrcXe6NW/nQpsdy+Ijme0OctKY7z1XatWrR5ti2zdas9aF7XtNqZszFNPbH4T+D0u
	PO7l3oJE4/O1Emee6vGdhYoc577cJYePlKfu0bFDPlI7TcuIFIV8QySuSZF/BVvOg6FsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSa0iTYRjt/e5bjj6W1Fd2gYVEg0zpwkN3KOorKsJ+FP0oh360oa7acs0g
	slxEYtPMQGumluUVt6bpsqk1zbSybJotXVqLxGpd1dVctabRv/Oc8zznnB8Pg0vryNmMSn1E
	0KgVSTJKTIh3rEpfXFuoV0ZXW6eByVxFwbORYhIqf+qh9LWNBGc5B3e6fmJgqqhDMOrvp8F6
	1o3DSOsDCq4V+3DwW84RYHpqIGDMPI7DuzYPDe2O3wRUWrfD4I0hAuxn6nFoGYsET1Y7BecM
	ARzyB05TEOwLkNDo/0zDKVsZBi0FHaHx4y0auuqMJOSOX8ehPu11KPBtLwndDSYKutOfIRio
	CpIw5AilesvcNBgrLyFwNJdTcMqwFLy3Rmn4erEVh0HjeviTp4O2ohnge+RF0H/9OQZBu42G
	JwPVJLSa6zHoeePHwZdZQEHGpywEz/MbMHhcYCGh5FEPFuqxC3qDvzC44Cyi4K1hEIGzxUPA
	5ZNGBOYmFwnf7AZi/Qa+xfsF522vShBfW/4S44ez/2C8q+khxt++9Irmi6wpfE2ZnL9mf4/x
	GS4nzlsrzlK89XsOzbt77RTfnhcg+JqSE/xwTT7aOW+veHWCkKTSCZola+PEyrse9lAnpb/d
	mUOmoTYyA4kYjl3G/RgeJyYwxS7kXC4/PoHD2RhuxPMgxIsZnO0M4xpr8rAJYTobx9Xdz588
	INhILv3JFWoCS9jl3PehF/Q/0/lcpeXupJEoxAdycyZ3pKGwnqtpdDYSF6EpFShcpdYlK1RJ
	y6O0icpUtUofFX8w2YpC33Tj+K/zNjTavdmBWAbJwiRxlqNKKanQaVOTHYhjcFm45IJTp5RK
	EhSpxwTNwf2alCRB60ARDCGbKdm6W4iTsgcUR4REQTgkaP6rGCOanYbcs5o2yTvEmVJfbiyT
	ualp7J6y+sfU6sPTs7McSwqNG02nLX2u6MDR2oh1ySm1jO/mHrn7TmFXKpEQEx+rPly4+N2K
	Zk6uzHC4hqM6ctasCcxdOWPL/fiqD6WexI5tDVNY0dM5xaKwBRHm2KgP7ubB496BDYuyZt47
	vy9a32gfD8oIrVIRI8c1WsVfeP6v00kDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool users
should use netmem descriptor and APIs instead.

Make xdp access ->pp through netmem_desc instead of page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/net/libeth/xdp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index 6ce6aec6884c..f4880b50e804 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -1292,7 +1292,7 @@ static inline void libeth_xdp_prepare_buff(struct libeth_xdp_buff *xdp,
 	xdp_init_buff(&xdp->base, fqe->truesize, xdp->base.rxq);
 #endif
 	xdp_prepare_buff(&xdp->base, page_address(page) + fqe->offset,
-			 page->pp->p.offset, len, true);
+			 pp_page_to_nmdesc(page)->pp->p.offset, len, true);
 }
 
 /**
-- 
2.17.1


