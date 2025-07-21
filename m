Return-Path: <bpf+bounces-63879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E326B0BAB9
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 04:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96B33BF5FB
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 02:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D206226656F;
	Mon, 21 Jul 2025 02:19:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CC6252906;
	Mon, 21 Jul 2025 02:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064340; cv=none; b=PzkRnnZrISZ3UDWMkmpFhjUolIvJOxb9ZbJHcFPbbVBzKuzbXS3xvWsD24Dbgbtha0sp3zzOmHZDVkQab8VapqBIqM7kOJc2jKhMKdWIeC5Ib85COdDQ5aUxGIWHPR43pOgo1wddoQZp7oOrPoaHocaRqzZVp+ED8EppcmUrs1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064340; c=relaxed/simple;
	bh=L+RgS7V7Au6Ri2a8QuAHoPOcLqT0mibOxx0N+Vk0UOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=trN4rlRYE96IPomlLFjQzc9FiBbr6siR+QvyUB+nUuXZlPj8IaBX5+f6TYpuIiokAlL4kEaN2OJ+AQK+Q8zUHFLsJt9Gs5gf0bQfg0EfEMCeaScIIdWCIUsshlYmi5iba8DppLsJlT9bL6F3rNP1PTPk1xEf0ABpKlaMFykRJd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-fe-687da38723dc
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
Subject: [PATCH net-next v12 12/12] libeth: xdp: access ->pp through netmem_desc instead of page
Date: Mon, 21 Jul 2025 11:18:35 +0900
Message-Id: <20250721021835.63939-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250721021835.63939-1-byungchul@sk.com>
References: <20250721021835.63939-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxTGfe9970c7ai6dmVecURvJMheZn/PMqDH+9W7LjMbETF2indzY
	ZgVJUQQjCogYGynqMAFXsAR0pTWWlK+KRbQQICIOi5KrtKBFGWrFjwKh4mStZv/9cp6c5zkn
	5/C0WmYSeH3qfsmYqjVoWCVWvoyrWHKiMlu3tLlpLVicl1m4G65gwDGZCX89cjPgqxbhWs8k
	BRZ7A4KxSD8HrpN+GsJtHSxUVkzQEKkpxGD5Ox/DuPMdDU/bgxx0ev/F4HD9DIOXhjF4TjTS
	0DqeCMGiThYK86doKB04zsL0wykGmiOjHOS5bRQ0v6jnoKfBzEDxu4s0NOY8imYN9THQ22Rh
	offYXQQDl6cZGPZGA0M2Pwdmx3kE3pZqFvLyV0CofoyD1+faaBg0b4APJRnQbv0CJrpCCPov
	3qdg2uPm4M7AFQbanI0U3HscoWHiVBkLppdFCO6XNlFwu6yGgaque1R0jq3QN/2egj98VhaG
	8gcR+FqDGP7MNSNwXpcZeOOJrjw1aWE3bCStoVc0cQeqEKmrfkCRkdMfKCJfv0WRq+cDHLG6
	DpBa22JS6XlGEZPso4nLfpIlrrdnOeLv87Cks2QKk9qqo2SkthRtnrdDuTZZMugzJOO363cr
	dTeCQlo3m3m1+yyTg9oZE+J5UVgpDjt2mpDiI56y+5gYs8JXoixH6BjPEpaJ4WAHNiElTwvd
	cWJzbQkVEz4XdouBW1dwjLGQKNbUjbIxVgnfiSMFY9Qn0/mio+bGRyNFtB6MHj/GamGVGHru
	ZmKmouBUiOGqIvypYY540ybj00hlRTPsSK1PzUjR6g0rk3RZqfrMpD37Ulwo+m+Xst/vdKO3
	PVu9SOCRJk6VhrN1akabkZ6V4kUiT2tmqUjHIZ1alazNOiQZ9+0yHjBI6V40l8ea2arlEweT
	1cJe7X7pd0lKk4z/qxSvSMhBP838WrHDsG7bN589iR98SII36xe0fb8iUpz0zzzvwm3lSbZV
	eaPbcxeucexVPXkz3lv8qxTINcWPx53pKo/vz36xAJuMpQmz8Z7A6Oa6a/bt8tKWX57NVC3f
	FJ6/68cL8pc/tJpfpZUVNGQOVRRsWXLOWp7oX21xpyxqOby6wH+k8LcmDU7XaZctpo3p2v8A
	/S99NmsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0yTZxTGfb/3u9HY5Esl84uLl9Rb1OjmEDzJlOim8c0SdQnJlpg4afSL
	bVoKaYWBkQylYkRBFJdwDSjogDogRaBKcVgqIAyVckkVaLFEhrPiBQQKam1d9t/vnCd5npM8
	h8eKBmYJr9Efkwx6lU7JymjZvm/TN54pS1V//cCxAopqbrDQM3mFAfNsMvwxYmXAWSlC06NZ
	CoqqGhBM+Qc5sJwdwjDpaGeh7Mo0Bn9tFg1FD000vKuZw/CszctBh/0DDWbLXvBcH6PBdqYR
	Q+u71eC90MFClmkeQ777NAuBJ/MMNPsnODhlraCgtfh+cHxRz8GjhmwGLs9dw9CYNhIMHB1g
	oPd2EQu96T0I3DcCDIzZg6m+iiEOss0FCOx/VbJwyhQBvvopDl7/7sDgyd4BH/OSoK30C5ju
	8iEYvNZPQcBm5eCBu5oBR00jBX1P/RimzxezkPnyAoL+/NsU/F1cy0B5Vx8VvCMGBgLvKch1
	lrIwavIgcLZ6aSg8mY2g5o6LgTc2E73je9Lqe4WJdbgckZuVjykynvORIq47nRS5VTDMkVJL
	IqmrWE/KbM8pkulyYmKpOssSy9tLHBkasLGkI2+eJnXlv5Hxunz047IDsm1HJJ0mSTJ8FR0r
	U7d4hYRuNvlW9yUmDbUxmSiMF4Ut4vkq52dmhbWiy+XHIQ4XNouT3nY6E8l4LHQvFJvr8qiQ
	sEiIFYc7q+kQ08JqsfbmBBtiuRAljmdMUf+ZLhfNtS2fjcKCe2+w8RArhEjR96+VyUGyUrSg
	CoVr9ElxKo0ucpNRq07Ra5I3HY6Ps6DgN11PfX/RiqZ699iRwCPlQnkCnapWMKokY0qcHYk8
	VobLSftxtUJ+RJVyXDLEHzIk6iSjHX3J08rF8h9+lmIVwlHVMUkrSQmS4X+V4sOWpKEodW7i
	/lV/Yt4UrTTfM3hwoafw8NVJd/32vq70uyVzb06YTt9ftvvh0aZF51Yla60xluq7ygxzyTfN
	vx6cESPsSz/8M8Nv+S5HF6FlNjT9tGaiecPKjKsjqnW/PH+alft2Z4eo9zauXakIlBzcVbDH
	HdUTvcYVO6s17tdNbHXsjWlR0ka1avN6bDCqPgGcUR1QSQMAAA==
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


