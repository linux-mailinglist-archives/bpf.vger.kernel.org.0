Return-Path: <bpf+bounces-63176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17CBB03E40
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 14:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 482D27B0E29
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 12:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A08259CAF;
	Mon, 14 Jul 2025 12:01:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9994B24BD0C;
	Mon, 14 Jul 2025 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494465; cv=none; b=fLZrwFk/63UY2dIGAzgyjHfpd8HJbjrTlUcYBNMaGtSyKZa9UFoOOzcp6urzQ3l9C9J9lH2aBbm8Tc72Nm9mRJEkzuJE24suVB7eVArCJ4IL7bNI6c0PFns1H3qEMEBMmvBwJ3vwj3GYVpxzXiQHT+6YySGLxpSeE9zHCcucpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494465; c=relaxed/simple;
	bh=d5pRUXcsNde4PyqBNFIgKWZO4NjNH9yOMdFkd645phM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CZUM9HWlYuW//OnyWWuZusPCBpNQUTykhkOMwXo3E6muCk3GMs6WOuhsKkykI+OW4ut/3vKJbwAeDMoirZaynX+zrwijzBTA1iwkId97MZ4NUjNKNzkB8bSWTRmRg+yrQZJqRvThYpVLQQ+VT+VjLp292ZxXVvtvIRBeKZEu3Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-90-6874f17ac5f4
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
Subject: [PATCH net-next v10 09/12] idpf: access ->pp through netmem_desc instead of page
Date: Mon, 14 Jul 2025 21:00:44 +0900
Message-Id: <20250714120047.35901-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250714120047.35901-1-byungchul@sk.com>
References: <20250714120047.35901-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe2xLcRTH/e57zRo3JVxvaSxkiXlzEoKIcCMRjyHxCMrutNF10lVtQgxd
	xGzdMkS3dVZ0dBs2rVnRFd3MvKdYiq2zeWToGGPadVOtx3+fnHO+3+85yWFwyQtyOKNQaQS1
	SqaUUiJC1Bl9euLurxr55KvWCWCsOE/Bk+5TJJT7U+HcazsJ7lIOrjf6MTCWXUHwPfCKBuvh
	Zhy66+5QcOZUDw6BymwCjI91BPyo6MXhXX07DQ2ufgLKrUuh9ex7AhyHqnGo/RED7TkNFGTr
	gjjkezMoCL0MklAT+EzDAbsFg5pPVTQ0XtGTcKy3BIfq9NfhrDdNJDy9ZqTg6cEnCLznQyS8
	d4UDfZZmGvTlBQhcN0opOKCbBr6q7zR0Ha/DoVU/H34ZtFBvGgI9930IXpU8xyDksNPwyHuR
	hLqKagyetQVw6MkqoiCzMwfB8/xrGDwoqiTBfP8ZFt4jHppCfRgcdZsoeKNrReCubSegcL8e
	QYXTQ8JXR/jkoN9IzV/A1/q+4Ly9xYz4y6UvML4j9xfGe5z3MP5qQQvNm6w7eZsllj/j+IDx
	mR43zlvLDlO89VsezTc3OSi+wRAkeJt5H99hy0fLR60TzUkQlAqtoJ40d7NIHrj7ltiREZ3a
	/2V2OioRZaIohmOncz/r+oj/3N1xhI4wxY7nPJ4AHuHB7BSuu/1OeEbE4OzDaK7GZsAijUHs
	Wq6roO2PmGBjOF1TFxlhMTuTO2aux/6ajuHKK2/+MYoK14uL2lCEJewMzplpxiOmHFscxXlN
	vn+CYdwti4fIRWITGlCGJAqVNkmmUE6Pk6epFKlxW5OTrCj8cGf39q23o2+N8S7EMkgaLYaP
	GrmElGlT0pJciGNw6WDxxxa1XCJOkKXtFtTJm9Q7lUKKC41gCOlQ8dSeXQkSdptMI2wXhB2C
	+n8XY6KGpyO0MCZucl6yLTHevcqwLXFWYsu7Q1syWrFV1Ssf+B1TPxnjO0feZhaOJwurskLZ
	cf36PRsXz+M+xA5c1D9qyd5hElHuZSdbmLVmbM4mseuW/1zQnNc1Js1JnVSuKF42dOm4E3e3
	eHNGei4N0WpmzLXsH63aYDhptNeuljti2y5Yx/VKiRS5bEosrk6R/Qb7QWBBbAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5//uczh6rTEDgUVAwmMLnbjDaOEgk5REURF9aFOeWijuWSz
	4aLLylm48tIN1FwabeaNtJm6allNs5V28dKYebcLVlbW1FxqthV9+73PA8/zfHglWF5JzZCo
	NAmiViOoFbSUlG6OTpp/5HuCcpFxgIWc0hIaGn3XKCgeSYQb3Q4Kmgo5uPdqhICcokoEg/42
	Buwp7Rh8tU9ouH5tGIO/LJWEnJcmEoZKf2F4X9fLgNs1TkKxfRN05X8gwXmmCkPNUAT0prtp
	SDWNYsjqTKZh4s0oBff9Xxk45SggoMbyNHB+rmDgVWUaBZd+2TBUGbsDhW89FDTfzaGhOakR
	QWfJBAUfXIHW/oJ2BtKKsxG4HhTScMq0BPorBhkYuFyLoSstBn5n6qEuLxyG6/sRtNleEzDh
	dDDwovMmBbWlVQS09PgxDJ+z0GD+ko7gddZdAhosZRRY61uIwI6t4JkYI+BiUx4Nb01dCJpq
	ekm4cjINQWm1l4LvThMZs4av6f+GeUeHFfG3C1sJvi/jN8F7q58R/J3sDobPsx/mywsi+evO
	jwRv9jZh3l6UQvP2HxcYvt3jpHl35ijJl1tP8H3lWWjLrF3SlbGiWqUXtQtX7ZUq/U/fkfHJ
	oYnj36KNyCY1oxAJxy7lfH1nmSDT7FzO6/XjIIexUZyv9wlpRlIJZp+HcvfLM4mgMY3dyQ1k
	95BBJtkIzuQZoIIsY5dzl6x1xL/Q2Vxx2cO/QSEBPdfSg4IsZ5dx1WYrzkDSPDSpCIWpNPo4
	QaVetkB3UGnQqBIX7D8UZ0eBb8o/NnbegQab17kQK0GKUBl8SlDKKUGvM8S5ECfBijDZpw6t
	Ui6LFQxHRO2hPdrDalHnQjMlpGK6bMMOca+cPSAkiAdFMV7U/ncJScgMI7pquzPcAETj9vV4
	xdTju/UpvtWpYWXThPhk75ShqLUjutH3j0cyJ7fUzxHW3fA9P75v3oNkH5xuMSy2G5dUe6Ux
	7kfusYqCpJ8R4yG3Hnmc8lpbriU8XfvCjRrWbM84YBhPMeV/PGqPjdRs84dfIOsyIFSt3K9X
	R7bmTi8p3KggdUohKhJrdcIfZ+A0mkkDAAA=
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


