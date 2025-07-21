Return-Path: <bpf+bounces-63877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F5AB0BAA8
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 04:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738783BDFBC
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 02:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DC225A35E;
	Mon, 21 Jul 2025 02:18:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BA11F8BBD;
	Mon, 21 Jul 2025 02:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064338; cv=none; b=RVgFa3pmFNhyeWyEHvGZLC1t+YjTSzE8YUrVIkIrqigG52h7biz/T0fDTf9WybpOxiY2k+5lAjlD1EAHjmX55SNLbfU8TwqaNwIDGGpm9bpK2HO2StMaHjS1lsjKzHZdQwAnTNBWIX7ErhtkbEmUnWBAh5z6d/LL8E40K+ZnoTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064338; c=relaxed/simple;
	bh=d5pRUXcsNde4PyqBNFIgKWZO4NjNH9yOMdFkd645phM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GRaX/DT0PbrvKWMs3cb0q+aYJpk/JRpHox+moTs7mv+PzSB7OhzieorabszJI3Rd+Rov+ZqDabL8/e46fNdtTCsPWMRUCMeu/uKiFxtoqD5GeeH4hewa7odUDk7m3e/O5gry3RBgXBjdn+8J4yCxz3GGSfbmjcjJtrtv6Brv80Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-c5-687da3861238
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
Subject: [PATCH net-next v12 09/12] idpf: access ->pp through netmem_desc instead of page
Date: Mon, 21 Jul 2025 11:18:32 +0900
Message-Id: <20250721021835.63939-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250721021835.63939-1-byungchul@sk.com>
References: <20250721021835.63939-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTdxTG+b93Ko1vOi+vl2nWxOhYhqKiJ9EYo1/+0ZiY8EnU6Dt5Q5uV
	ii0gmBALQpSqxagzgNXAALmUCCsiHSs6CxMmXrAIVosgRQ1iKSrQUBFqq/HbL+fkeZ5zcg5H
	Klz0Yk6tTZV0WlGjZGSUbDTqz19PlmWp1rRNLgNzXS0Dj8dLabBMZUDlSxsNzmoB/umaIsBc
	cxPBRMDNgjW/j4TxtnYGykr9JATqz1JgfpRLwWTdJxJe3/Ww0OGYocBi3QUD195QYD/ZRELr
	5ArwFHQwcDZ3moSi/jwGgs+naWgJ+FjIsVUR0PKukYWumyYaLn6qIKHJ8DKUNdRLQ3ezmYHu
	E48R9NcGaXjjCAV6q/pYMFmKEThuVzOQk7sOvI0TLLz/o42EAdNWmC1Mh7slC8Df6UXgrugh
	IGi3sfCw/zoNbXVNBDwZDJDgP3OFAeNoAYKeomYC7l+pp6G88wkRmiMeeoOfCbjgLGFgKHcA
	gbPVQ8HlbBOCulsuGj7YQytPT5mZrdtwq3eMxLYX5QjfqH5G4OFzswR23bpH4L+LX7C4xJqG
	G6qicZn9LYGNLieJrTX5DLZ+PM/ivl47gzsKpyncUH4cDzcUod0/Jsg2J0oadbqkW73loEwV
	+P8VlZIXlTEztsmAKmRGFMkJ/HrBVPme+M63e0aZMDP8SsHlCpBhnsfHCuOedsqIZBzJP4gS
	WhoKvwp+4PcIhsYBKswUv0KY6RxCRsRxcn6D4Phv6TfP5YKl/t+vPpGhsid0/DAr+DjBO2Kj
	w54Cb4kULHcK2G+CRcKdKhd1DslLUEQNUqi16cmiWrM+RpWpVWfEHDqcbEWhf7uW9XmvDX3s
	incgnkPKKHkKlaVS0GK6PjPZgQSOVM6T4/ZjKoU8Ucw8JukOH9ClaSS9Ay3hKOVC+Vr/0UQF
	nySmSr9LUoqk+94luMjFBjT/qGWPb+LQulcbO91xZESCYq4vybc/eMTHfdgZPC2bc+Dnbcfp
	64sScrqy84Z3lCYNN54vc+0rjdh7ihvprb267JdV2we1ccaJeH/lfnfsvcEds2kb3O212b+l
	OZN26ceKY7pXeZ4aFM5LWKNeLno2X76hGZkrcmJq91+D+Zt+ylNSepUYG03q9OIXRy8+B2sD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSeUxTaRTF/d5OQ/Wlg84bNZo0EhPNoLjlupNo9ItbTIwxksloR5/TRra0
	yJYwIhaVRoprLAgGA8VCiZDWSgeLaGEEZTpCEVIHBC2KjFPcWGKtWFuN//3uPck5NzmXI2U2
	eianSkoV1UmKBDkjoSQ7Vh//+UR5tnJxZ88SKKmtYaBz9CoN5g8ZcO2pnQZ3lQC3Oj4QUFJ9
	E8GYv5cFS34fCaMtrQyUX50gwV9XQEHJQy0F47UfSXhxz8tCm3OSArNlOwxUDlHgOFlPQvN4
	NHgL2xgo0AZIKOrPYyD4b4CGRv9rFnLtJgKaS++Hxv9tLHTc1NNw4aORhPqcp6HAwR4auhpK
	GOg63omgvyZIw5AzlOoz9bGgNxcjcDZVMZCrXQo+2xgLby+2kDCgj4PPhjS4VzYDJtp9CHqN
	3QQEHXYW/um/TkNLbT0Bj575SZg4XcqAbqQQQXdRAwF/l9bRUNH+iAjdsQt6gp8IOO8uY2BQ
	O4DA3eyl4PIxPYLa2x4a3jm0VNwG3Ox7Q2L7kwqEb1Q9JvDwmc8E9tx+QOA/i5+wuMxyBFtN
	C3C54z8C6zxuEluq8xlseX+OxX09Dga3GQIUtlYcxcPWIrRzTrxkzUExQZUmqhet2y9R+u8/
	p1LyIjMm36zOQUaJDkVwAr9MaOoeYcLM8PMFj8dPhjmKjxVGva2UDkk4kndFCo1WAxEWfuD3
	Cjm2ASrMFB8tTLYPIh3iOCm/QnD+Nfub51zBXHfnq09EaO0NFR5mGb9c8L2y02eQpAxNqUZR
	qqS0RIUqYXmM5rAyM0mVEXMgOdGCQs9Umf3prB2NdW12Ip5D8khpCpWtlNGKNE1mohMJHCmP
	kuLWLKVMelCRmSWqk/epjySIGieaxVHyH6Vb9oj7ZfzvilTxsCimiOrvKsFFzMxB0+oN0elZ
	jy8+KBQn/3Btmq4P3B2f17B0fUzbVpcw1HRomwiXtEXx+xZqBodWCtbXrvFfYwIFD52pssQr
	P9Wlt5hswfPvX63litOnxso3rjOeeqv/pdLka7h2x51hbo1TLHMb18+W5+fN2vmyf3iVoW9L
	Y+9vl07YN924vtuVHYkXyimNUhG7gFRrFF8AWwb0mkgDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool users
should use netmem descriptor and APIs instead.

Make idpf access ->pp through netmem_desc instead of page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index cef9dfb877e8..6b5f440aede3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3276,8 +3276,10 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
 
 	hdr_page = __netmem_to_page(hdr->netmem);
 	buf_page = __netmem_to_page(buf->netmem);
-	dst = page_address(hdr_page) + hdr->offset + hdr_page->pp->p.offset;
-	src = page_address(buf_page) + buf->offset + buf_page->pp->p.offset;
+	dst = page_address(hdr_page) + hdr->offset +
+		pp_page_to_nmdesc(hdr_page)->pp->p.offset;
+	src = page_address(buf_page) + buf->offset +
+		pp_page_to_nmdesc(buf_page)->pp->p.offset;
 
 	memcpy(dst, src, LARGEST_ALIGN(copy));
 	buf->offset += copy;
@@ -3296,7 +3298,7 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
 struct sk_buff *idpf_rx_build_skb(const struct libeth_fqe *buf, u32 size)
 {
 	struct page *buf_page = __netmem_to_page(buf->netmem);
-	u32 hr = buf_page->pp->p.offset;
+	u32 hr = pp_page_to_nmdesc(buf_page)->pp->p.offset;
 	struct sk_buff *skb;
 	void *va;
 
-- 
2.17.1


