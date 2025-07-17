Return-Path: <bpf+bounces-63572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C257B085F8
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4381887C22
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 07:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A53B2376EC;
	Thu, 17 Jul 2025 07:01:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F856221DA8;
	Thu, 17 Jul 2025 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735677; cv=none; b=bJAN0HvLg1iXHIMQF24bcGNlTplO+3P9NbYwvZjXJrEemfSlSiUgnj1JAJxIlTUx1ZIy8arg3qACGGubegEPNeIY+WyzVRRBFP5WelpNKPds2JJaxlRrFB0mPcFjG459s7LsoHusfPG1w5gezU6MUSQwcQa8A7o3aF+iaci1g/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735677; c=relaxed/simple;
	bh=d5pRUXcsNde4PyqBNFIgKWZO4NjNH9yOMdFkd645phM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WnBGaXxMr0xgm2qNMf2P8ieekmhc3kL7TqrC3NfOI8Z349kJmeUxSQwR+ArMykE4Gg92F8dJ3kb/2MghEzrCggewvvBYRTafbvZ1doBNByVBLK93xpDrXdWstaO3JBMXU+ADmE2vL3F9waKR/RnYGXesBtIfR95G6LaxbqZKVOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-5f-68789fb44589
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
Subject: [PATCH net-next v11 09/12] idpf: access ->pp through netmem_desc instead of page
Date: Thu, 17 Jul 2025 16:00:49 +0900
Message-Id: <20250717070052.6358-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250717070052.6358-1-byungchul@sk.com>
References: <20250717070052.6358-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0jTeRjH/Xx/u7b49l3U9/oJgwiK6rp+8BwdEUH0JYgCqSiJ/Jrfu438
	xdSlwXFWSmimlRWuFs2cOn9w7rbUVbNseqaZ51pzLVNn6y46cv3yB85layn99+L9PM/7/Tzw
	MDj3jFzEaFIzJW2qmKyiZIQsKC9fc+tGtvpHj0sJhoZ6Cp6MlpNQN5kN1cN2Etw1PNx1TWJg
	qG1CMBZ6QYO1YACH0faHFFSUT+AQspwjwNCbR8B4wxQO/3UEaOh0ThNQZ90N/qrXBDjONOPQ
	Nr4CAiWdFJzLC+OgH8qnINIfJqEl9I6GU3YzBi1vG2lwNRWTcGmqEofm3OFo1isvCU/vGCh4
	evoJgqH6CAmvndHAEfMADcV1VxE479dQcCpvA4w0jtHw4XI7Dv7ibfClTAcdxgUw0T2C4EVl
	HwYRh52Gf4b+JKG9oRkDz8sQDhNF1ykoDJYg6NPfweDxdQsJpm4PFt0jDryRzxiUuo0UvMrz
	I3C3BQi4drIYQcM9HwkfHdGTw5MGatt2oW3kPS7YB01IuFXzHBPenP+CCb57jzDh9tVBWjBa
	swSbeZVQ4fgfEwp9blyw1hZQgvXTRVoY8DooobMsTAg20x/CG5se7V16SPZLkpSs0UnadVsT
	ZOpQ179Eer48e/r9llxUKStEsQzPbuSbSsfx7xxptlDfmGJX8j5faEafz67nRwMPiUIkY3C2
	R8632MqwbwUle5A3dblnmGBX8EWt76LDDKNgN/FWGzfruZyvs7TO+MRG5fClizP+XDTLczOX
	nu25EcuXt+6c5R/4B2YfcR4pjCimFnGaVF2KqEneuFadk6rJXns0LcWKou9W9fvneDv65Ipz
	IpZBKrkiwXJczZGiLiMnxYl4BlfNV5S6dWpOkSTmnJC0aUe0WclShhMtZgjVQsVPE8eTOPY3
	MVM6JknpkvZ7FWNiF+WiPaa4LBVytPcnxqeNadODh6eObC2p2vwsePZn17LLXVKZs2j/sPlK
	d34BT+44ltb9txfXLvHv+vX52z6ySNn14GR8//RfNcEDek7pStTwg8p4Sl8xZ+68febpAKWv
	Xr66tz7R0O8xz72QKXYMlDDGGG+j/ERCjF92U3T3cHtVRIZaXL8K12aIXwG/KQ/1agMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTcRTG+793h6OXNeqloGIUQZAVFZxQogjsT9GNgm5EG/XSRs50s6XR
	xXJSrlKzC2qTVl7yRhtbtmWzYoppdp02Vtlm66ZkWXmhqbmm0bfnnIfze54PhyNldfR0TpOc
	JuqSVUkKRkJJNsRnLXBcS1cvsgSWg9lay8DL/us01PxOh5tdLhq8VQLce/GbAHP1HQQD4bcs
	2HM6SehvesRA6fUhEsK28xSYnxspGLQOk/CpOcRCi+cPBTX29RCs+EyB+7SThMbBuRDKa2Hg
	vHGEhKJANgORNyM0NIS/s3DKVUlAY0lrdPxax8KLO7k0XBouJ8GZ2RUN/OCjob3ezEB71ksE
	gdoIDZ890dTeyk4WcmuKEXgeVDFwyrgEeusGWPhxuYmEYO5KGCs0QLNlKgy19SJ4W/6KgIjb
	xcKzwC0amqxOAjreh0kYOlfCgOlbHoJXRfUEPCmx0VDW1kFEe2wBX2SUgIteCwMfjEEE3sYQ
	BVdP5iKw3vfT8NNtpFauxo29fSR2vStD+HbVawJ3548R2H//MYHvFr9jscV+CDsq5+NSdw+B
	TX4vie3VOQy2/ypgcafPzeCWwhEKO8pO4G5HEdo0c6ckYZ+YpDGIuoUrlBJ1uPUjlZIdm/6n
	Lz4TlUtMKIYT+KVCxGljxjXDzxP8/jA5ruX8YqE/9IgyIQlH8k9jhQZHITFuTOF3CGWt3glN
	8XOFcw+/R485TsovE+wO2T/mLKHG9nCCExNdj1wqmODLolkdNzLZfCSxoEnVSK5JNmhVmqRl
	cfoD6oxkTXrc3oNaO4o+U8Wx0QsuNNC+xoN4DilipUrbYbWMVhn0GVoPEjhSIZde9BrUMuk+
	VcYRUXdwj+5Qkqj3oBkcpZgmXbtNVMr4/ao08YAopoi6/y7BxUzPREt+yrXes6asRJ8yr3x0
	hjpx45zNyhO7j2hQ/NG8m2OBivpg/pmCuI7S180haWrqjerD7/uQuL3nwnEmI/hpKKFHpl0e
	m5Na375KvXleztE0RYN8yobTtnVtk7fu+mJfkzDoHi7eOFs7LdFpXtGVkr2q1trmO1bZjc82
	bEq5ci9AKii9WrV4PqnTq/4CUvlj8kgDAAA=
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


