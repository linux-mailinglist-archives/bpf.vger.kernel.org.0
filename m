Return-Path: <bpf+bounces-63567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8781AB085E2
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2831A62672
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 07:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B8A221FD2;
	Thu, 17 Jul 2025 07:01:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87004219A67;
	Thu, 17 Jul 2025 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735673; cv=none; b=JNgeMELsImsH+VD/0E0wAfTXiPCzSCzEQ4gLKmul30AjN9hgFGd8r+y6I0W7jEtUs3lg11jZr/sM8d0kq2aYZf7AEw3FjLeD/SfOapK3YBckjx0HcchQzyWHKf8KbQ0UZQRmVwmHFuIICM/O0u10ezlIf+QdwEte+MUVfrYtRMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735673; c=relaxed/simple;
	bh=FbTHMum28TnB6gAWDNsPHheRdMMhAKjVl6Ju+pSw76M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=W0frk8IGjPPSRbfPFjKFkCvb625owZ8RaeHzHRlJuQKctrmj6E4uyD+c7JYBuNpbMHbuITPs+TfDuVSrxHXljRCFMYnyEgMa99sbIIBhqw0CEIyetG/ZGCXvOv80gbJUlwQbuYNKtGNmAQkW/pbO18/P7wB5qEbti/aazZvezwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-ef-68789fb32f32
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
Subject: [PATCH net-next v11 03/12] netmem, mlx4: access ->pp_ref_count through netmem_desc instead of page
Date: Thu, 17 Jul 2025 16:00:43 +0900
Message-Id: <20250717070052.6358-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250717070052.6358-1-byungchul@sk.com>
References: <20250717070052.6358-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0yTZxTG937vd6Oh4UtF/WQxxi7OSyLzhp4lBA1/zJctuyQqf2wm2si3
	tbEUV7CCiVgQNTZSGDLGpWZlgBZKpGlFKhamBZXMsWEF0gmCYkQXbs4ioRbpCsb/nuQ5z+85
	Jzk8VviZOF6jy5L0OpVWycpo2UR09UbXr9nqTdb2j8HS1MjC/UA1A/bZbLj82M2Ar16EGz2z
	FFgariGYDg5w4Dw3iCHQeZeFmuoZDEFHIQ2WvwtoeN30BsOzOyMcdHnf0mB3fgnDl0Zp8Jxt
	wdDxeg2MFHWxUFgQwlAxdJqF8MMQA23BSQ7y3TYK2saaOei5Zmag9E0dhhbj40jX034GHrRa
	WHhw6j6CocYwA6PeSOG4bZADs70Sgff3ehbyC7bCePM0By9/7sQwbN4F8+UGuGNdBjP3xhEM
	1PVREPa4Ofhr6AoDnU0tFPQ+CWKYOX+RBdNEEYK+ilYK/rzoYKD2Xi8V2WMP9IfnKLjgs7Lw
	tGAYga9jhIaqPDOCpnY/A/95IieHZi3srmTSMT6FiftRLSJX6/+hyIvieYr42/+gyPXKRxyx
	Oo8Sl20DqfH8SxGT34eJs+EcS5yvSjgy2O9hSVd5iCau2pPkhasCfbPyW1limqTVGCT9J0kH
	ZeqJmjA+kheb3du61ogsgglF8aKwTbzdfp59r3tHnYuaFdaKfn8QL+hYYbMYGLlLm5CMx0J3
	tNjmKqcWjCXCYbGsb3hxiBbWiEPe5kiY5+URUEdp8jvmKtHuuLk4EiUkiKHSkkW+YqHrNyO3
	wBSFqigxNDqB3wVWiLdsfroYya3ogwak0OgM6SqNdlu8OkenyY4/lJHuRJF/u3Ri7js3etWz
	x4sEHimj5Qcdx9QKRmXIzEn3IpHHylj5BZ9BrZCnqXKOS/qMA/qjWinTiz7kaeVy+ZaZY2kK
	4QdVlnRYko5I+vcuxUfFGdGVhAHv+tTnyz7vXLoymV+923AiYEvs4bobfzy7FEvz3I7ARxVt
	O80NDp1n0ri6+KszO7YU1pFEZ8qU9vK6mNa96+Rjqds/i00R95dlfRqTW1Zm2tfyi/lJQtEX
	qiVJ6fGi5RnKTaqsypv8OjzXyGvT6oJTmp8g9y2yp34firE9VNKZatXmDVifqfof/timYmsD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTcRTG+793h8uXJfXSFRYiBGlSwoEuREX9C4qiJOhDuerNDS/FVmsm
	ldkklLKbhdosy2nzQq4tc9m6sK1c95pTppmWllmtqxecs9Y0+vYcnuc8v/PhcKSsnp7KqTL2
	iuoMRZqckVCSdQuPzrVe0innvQ9NBENdLQOv+i/TUDOsg6tvbTR4qgS4/XKYAEP1TQQDgdcs
	WPI6SOh3NTFQfnmIhID5BAWGF3oKButGSPjwsJsFt+M3BTWWtdBV2UuB/VgDCc7BGOg+6Wbg
	hD5IQnFnLgOh9iANdwLfWMixmQhwlj4Kj1/qWXh5s4CGwpEKEhqy34aBPa00NDcaGGg++gpB
	Z22Ihl5HmOo3dbBQUFOCwHGvioEc/Xzw1w+w8OOci4SugqXwp0gLD8smw9ATP4LXFS0EhOw2
	Fp53XqPBVddAgPddgISh46UM5H89iaCluJGAp6VmGoxPvET4jo3QGhol4KynjIEefRcCj7Ob
	ggtHChDU3fXR8NOup5Yux07/dxLb3hgRvlHVRuC+U38I7Lv7mMC3St6wuMyyD1tNc3C5/ROB
	830eEluq8xhs+XWGxR2tdga7i4IUthoP4z5rMVo/c4tk0U4xTaUV1fFLkiXKr+Uhcs+RaJ23
	MTYbGfh8FMEJ/ALB22thxjTDxwo+X4Ac09F8gtDf3UTlIwlH8s8ihTvWImLMmMSnCudbusZD
	FB8jdDrqw8scJw0XOQuX/eucJdSY749HIvhEIVh4ZrxfNsa6ks2eQpIyNKEaRasytOkKVVpi
	nCZVmZmh0sXt2J1uQeFnqjw4etqGBppXORDPIXmkNNm8XymjFVpNZroDCRwpj5ae9WiVMulO
	ReYBUb17m3pfmqhxoGkcJZ8iXbNZTJbxKYq9Yqoo7hHV/12Ci5iajRZHXR2qTCjJiV0bytLP
	jXLNph/k2uJXWtW7plzn7eraHX2ji6cPr8tyXSz5ebEpyW9OssXk4sbP5dsnSvLaV3AXLEIw
	cqspyRi14fRvZ8zgjY/zlfZvm1JGjDNUXnmWN0XSFj/pqTjQ9iunVmdyr3bbXmjMcYlGew86
	dmh1e5+c0igVCXNItUbxFwNRKE1IAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool users
should use netmem descriptor and APIs instead.

Make mlx4 access ->pp_ref_count through netmem_desc instead of page.

While at it, add a helper, pp_page_to_nmdesc() and __pp_page_to_nmdesc(),
that can be used to get netmem_desc from page only if it's a pp page.
For now that netmem_desc overlays on page, it can be achieved by just
casting, and use macro and _Generic to cover const casting as well.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c |  4 +++-
 include/net/netmem.h                       | 17 +++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index b33285d755b9..92a16ddb7d86 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -460,9 +460,11 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_priv *priv,
 
 		truesize += frag_info->frag_stride;
 		if (frag_info->frag_stride == PAGE_SIZE / 2) {
+			struct netmem_desc *desc = pp_page_to_nmdesc(page);
+
 			frags->page_offset ^= PAGE_SIZE / 2;
 			release = page_count(page) != 1 ||
-				  atomic_long_read(&page->pp_ref_count) != 1 ||
+				  atomic_long_read(&desc->pp_ref_count) != 1 ||
 				  page_is_pfmemalloc(page) ||
 				  page_to_nid(page) != numa_mem_id();
 		} else if (!priv->rx_headroom) {
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 097bc74d9555..f7dacc9e75fd 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -285,6 +285,23 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
 	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
 }
 
+/* XXX: How to extract netmem_desc from page must be changed, once
+ * netmem_desc no longer overlays on page and will be allocated through
+ * slab.
+ */
+#define __pp_page_to_nmdesc(p)	(_Generic((p),				\
+	const struct page * :	(const struct netmem_desc *)(p),	\
+	struct page * :		(struct netmem_desc *)(p)))
+
+/* CAUTION: Check if the page is a pp page before calling this helper or
+ * know it's a pp page.
+ */
+#define pp_page_to_nmdesc(p)						\
+({									\
+	DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));		\
+	__pp_page_to_nmdesc(p);						\
+})
+
 /**
  * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
  * @netmem: netmem reference to get the pointer from
-- 
2.17.1


