Return-Path: <bpf+bounces-63570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4699DB085EC
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D8B7A4814
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 07:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DC423373B;
	Thu, 17 Jul 2025 07:01:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B75F221557;
	Thu, 17 Jul 2025 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735677; cv=none; b=dyKWYP64AAE/XmTSWHpsu55ZV/4P9JA5yOLVAIbteLLMQwPAY/8sYCiHsdslJvHNNC/36J3r34n+aeHgOKvtE41IKolax2klnTaadtx6Dymjwv8i3GQrr4o+eit6Mj+xxN2PpFikrskv662fDbFn8cf9rjotU8JtIY6mjSug54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735677; c=relaxed/simple;
	bh=QOhmDSG8jrfmlxGLbdvqztAiBlRRR5rgcBBl2d5Txlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NxrGUa0va2LVIZWP+qctfBeJBM+drHu5hqBHT2cn1H6J37IR194Zy5ZAc/Ry4TRnUrYMU29dSCkDGSMcKB+dp7MlmP+cYiKxZbv1NLK/xx8xWRxhiHytbdKAmykGqdZsNys2VDSVkxHGVuLF18eY5KkuR19tUj13l9eaEew/esQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-4d-68789fb35395
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
Subject: [PATCH net-next v11 08/12] iavf: access ->pp through netmem_desc instead of page
Date: Thu, 17 Jul 2025 16:00:48 +0900
Message-Id: <20250717070052.6358-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250717070052.6358-1-byungchul@sk.com>
References: <20250717070052.6358-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAz2Se0hTcRTH+93nNlxdrqW3JKJFFEVW9jpERVR/3OglGIRF1MqbG80Vmy6N
	wlVWJKWSBVqLfJVTq62pbeUsm5LSUzeVZfPRehnZUx1bs9Y06r8PnHM+33PgiHC2i5wiUqpT
	BY1arpJREkLyOaJ4Xs3VdMWCXr0UDKYbFLQNFpNQ5U+H8j4bCc4KDupa/RgYKu8gGAq8osFy
	xoPDYFMzBaXFPhwC5nMEGF5kETBs+onDu0deGlocvwiosmyC3uvvCbCftuLQODwTvLktFJzL
	CuJQ2HOSglBXkIT6wBcajtuMGNR/qqWh9U4OCRd+XsPBqu8LZ73pJMF1z0CB60Qbgp4bIRLe
	O8KBA0YPDTlVlxA4HlRQcDxrEQzUDtHw7WITDr05q+F3gQ4eFUWB78kAglfXOjAI2W00PO+5
	RUKTyYpB++sADr6zVyjI/pyLoKPwHgZPr5hJKHvSjoX3SIDO0AgG+c4iCt5k9SJwNnoJuHws
	B4HpvpuE7/bwyUG/gVq9hm8c+Irztu4yxNdUvMT4/rzfGO++/xjj717qpvkiSxpfbZzDl9o/
	Yny224nzlsozFG/5cZ7mPZ12im8pCBJ8dVkm319diOKnbpesSBJUSp2gmb9qt0TRdfsUfrCE
	Tq/JH8b0KJfKRmIRxyzmGvKG/vPjtn5slClmFud2B/BRnsgs5Aa9zUQ2kohw5lkEV19dMNYU
	ySRyuZfdY0wwM7mR0hA5ytKwqPtLHfZXOo2rMjeMicTMEi544fxYGBvuaS/R06NSjjGJOYOz
	h/g7MJl7aHQTeUhahMZVIlap1qXIlarFsYoMtTI9du+BFAsKf9z1oyM7bOhHa4IDMSIki5Du
	Nh9SsKRcp81IcSBOhMsmSvOdOgUrTZJnHBY0B3Zp0lSC1oFiRIQsWhrnO5TEMsnyVGG/IBwU
	NP+qmEg8RY/EanqS+NTXyA3+5rMv92yeP9elmN2/svGdv6GE3Ld9ObEzsXzLzjp2JDGajNya
	Wuc4sj7VOsO9Nu1E3DHXYFL8xh03Yyrjt3iNmZv6fC575gwtva58OBnYKI9zuurDp+S4m4V3
	PR3Lxm+LqY16MD7xo8ZsWxpthVhJ8hq2dMLbvTJCq5AvnINrtPI/cTLsum0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHee5zX0pj401t9IYZXerMDEY3tpmdDLNo/OCjiUo0ETW+cDMu
	awUKtNoVdRGxOq1SRFwCAhkIIgW1XSu0g6KuEGCgm5SXdMqLw8zgZIryEgvMWlj89js5//z+
	58ORYaWbiZJpdYckvU5MUbNyWr419uQq108mzaeunBgotl9noXOsjIGaNya49tjDgN8mQMOD
	NxQUV9chGA8+4sB5tg/DWHMrC+VlkxiCjhwaiv8w0zBhn8Lwd8sQB22+/2iocW6BwcqnNHh/
	cGNomlgOQ7ltLOSYpzEUDpxiIfRwmoHG4AsOsj1VFDSV/BYen9dy8KDOysClqasY3FmPw4VP
	ehnoqi9moetkJ4KB6yEGnvrCrSNVfRxYay4j8N2xsZBt/hxGasc5GP2xGcOgdR28LTBCS+lC
	mOwYQfDoag8FIa+Hg98HbjLQbHdT0P1XEMPk+RIWLP/mIugprKfgXomDgYqObip8xw7oDc1Q
	kO8vZeGJeRCBv2mIhqITVgT22wEGXnnN9LoNpGnkJSae/gpEbtn+pMjwhbcUCdxup8gvl/s5
	Uuo8TFxV0aTc+4wiloAfE2f1WZY4X1/kSF+vlyVtBdM0cVUcJ8OuQhS3ZI98baKUojVK+k++
	TpBrHv58Gqdf4Uy38ieoLJTLWlCkTOC/ENo7h6lZZvmPhUAgiGdZxccIY0OttAXJZZi/P09o
	dBXMhRbwu4XcosAc0/xyYaY8xMyyIizqf9FA/S9dKtQ47s6JIvk1wvSli3NlynCm+0oWdwHJ
	S1FENVJpdcZUUZuyZrUhWZOp05pWf5OW6kThd6r8fibPg8a7NvoQL0PqeYoEx3caJSMaDZmp
	PiTIsFqlyPcbNUpFoph5RNKnHdAfTpEMPvSBjFYvUmyOlxKU/LfiISlZktIl/fstJYuMykIZ
	UbHxFnax3BYcHD21dSxCv7BxyhOXGG3viVtwPnv/OaFws5/k3Unadeb5ynOLMuJiYefez7zx
	2+rFu/NjPjqY15uddt9aNXH0tM4j3lA37FuP7/FbTM9+7fxwI+9YNhDlynlJJY3WHTxiO7bJ
	HTH/uPGfFbUtSartlSu+UvUv+bJMTRs0Ykw01hvEdx2uMCNKAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool users
should use netmem descriptor and APIs instead.

Make iavf access ->pp through netmem_desc instead of page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index aaf70c625655..363c42bf3dcf 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1216,7 +1216,7 @@ static struct sk_buff *iavf_build_skb(const struct libeth_fqe *rx_buffer,
 				      unsigned int size)
 {
 	struct page *buf_page = __netmem_to_page(rx_buffer->netmem);
-	u32 hr = buf_page->pp->p.offset;
+	u32 hr = pp_page_to_nmdesc(buf_page)->pp->p.offset;
 	struct sk_buff *skb;
 	void *va;
 
-- 
2.17.1


