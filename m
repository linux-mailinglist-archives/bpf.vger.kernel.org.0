Return-Path: <bpf+bounces-63178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198ACB03E2C
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 14:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229F74A4E47
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 12:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0ED25BF15;
	Mon, 14 Jul 2025 12:01:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973802517AC;
	Mon, 14 Jul 2025 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494466; cv=none; b=kUyQ21twf1KzaXuwcUREIG+onIAjQbpHz39rO7jW89VOP/3/OOdAEkCtvco+Qdd7B+cDpASYB3thmPbu4QrlkisffPcd5KosAMZ+cWOqqhcN0X6va4i4TYuUCx1iQsVCLkYfWNqVh0e1Z25kI6EsLriIasXnBhXoq3iqo1s0BzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494466; c=relaxed/simple;
	bh=Q0WJqXFfUTyFwOtRRHU+KSzHhbvENu7oXCPyMWGWYfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TUYLHBDma3r2u4sRFv0Cj2jxErCmF+tmsfcNWCV5eK5koho3i3tWtnytbDku2Gd33M/qMpDUW+pN18pYSbttGHYImb7igg9MCCUK5nouJFHgro9l/2nXW/yXdJLktZ3vBK695JF4BbndJMaZfr5T4cv71+Bs2jbxHU90DcYNZCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-b3-6874f17a8079
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
Subject: [PATCH net-next v10 11/12] net: ti: icssg-prueth: access ->pp through netmem_desc instead of page
Date: Mon, 14 Jul 2025 21:00:46 +0900
Message-Id: <20250714120047.35901-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250714120047.35901-1-byungchul@sk.com>
References: <20250714120047.35901-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHfe5z39q1ybWaeSfZNFWzxKgbKttZYoz66YmLidFvGtFm3HDr
	ALUggss2hqihUTC+ZK0WBaFYXhRsBSq2yFqmTNEVBFKkgEImoEVFtKFUYa3Eb7+c88v5n5Mc
	Hmt6mIW8Pi1DMqTpUrSsklaOqS6vPDyeIX87XrsaLDXVLLRPlDBQNZkFV544GeioEOGWb5IC
	S2U9grfhXg7s+QEMEy13WSgtCWEI156kwfJvHg3vaqYw/HdnkINWzwcaquxbYKD8GQ2u4w0Y
	vO+WwWBhKwsn8yIYzP1HWZh5HGHAHX7JQa7TRoH7RR0HvvoCBs5OWTE05DyJZg11M/Co0cLC
	oyPtCPqrZxh45okGBm0BDgqqziPw3K5gITdvDQTr3nLw+lwLhoGCDTBtyoQ7xZ9D6H4QQa+1
	i4IZl5ODh/3XGGipaaCg82kYQ+hEEQvGsUIEXeZGCtqKahkou99JRffYDt0z7yk401HMwlDe
	AIIO7yANF/4oQFDT5Gdg3BU9OTJpYTdsIt7gK0ycfWWI3KjoocjIqWmK+JvuUeTm+T6OFNsP
	EodtOSl1jVLE6O/AxF6ZzxL7m9McCXS7WNJqitDEUfY7GXGY0dYvdyjXJUkp+kzJ8M36PUrZ
	9ToX7/cqsiKhK0wOMvNGpOBFYa344rSV/sSem2fYGLPC16LfH8Yxni/EixODd6OOksfCA5Xo
	dpioWGOesFesa3R/lGhhmVgabGdirBa+E0dLCpnZoYvEqtrmj44iWr9U9BTFWCMkiE3GMjzr
	XFKI+aNLZvkL8S+bnz6F1MVoTiXS6NMyU3X6lLWr5Ow0fdaqn/al2lH04cp/fb/Tid74tnuQ
	wCOtSg3PM2QNo8tMz071IJHH2vnq530GWaNO0mUflgz7dhsOpkjpHhTH09oF6tWhQ0kaIVmX
	If0sSfslw6cuxSsW5qAs0tZonPrtYo/slg8ds9XPtauazduSd6nijyU6N7YtDlQnWB6YA9uU
	S1ZKpun6IdmYuGK8+eLtIe9SX/vm0iNq5cPyvdbPevv/Gd5auXGz78Dfw9dPKEa++iVu04Xh
	hM62RVd3LaWnuR9h+IPjWpFpMs5qyR5L1i74/s8fbHMTb3Vp6XRZF78cG9J1/wP0SuBYbAMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5//ubkaHabUyahoFIGQXc0XijCEOgRFEFH4xVYd2kxnbFPU
	kMxW4UqtLFCbpGh5i5SzdNOmxSZldnOassp57WK2ytKsNdO2om+/930e3uf58LJYYaXCWY3W
	IOq0qkQlLSNluzefXp3x1aBe65GWgLnuFg2uiTIKan+mQeWgjYKuah7udv4kwFzTiGDS95oB
	KacPw0TbQxrKy6Yw+OpzSTA/N5Lwve4XhrcPhhlod/wmoVbaBQM335FgP2fF4Py+Eobz22nI
	NfoxFPWfoWH2lZ+CFt9nBrJtVQQ4Sx4Fxo8NDHQ25lFw5dcNDNaswUDgSC8F3c1mGrpPuxD0
	35ql4J0jkOqt6mMgr7YYgeNeNQ3Zxg3gbZhkYPxqG4aBvBiYKUyFB6ULYOqxF8HrGz0EzNpt
	DDzrv01BW52VgBdDPgxTF0poMH3KR9BT1EzAk5J6CioevyACPfZC7+w0AQVdpTSMGAcQdDmH
	Sbh2Kg9BXaubgq92IxkTKzi9X7Bg81Qg4U71S0IYvThDCO7WDkJoKvYwQqmUIliqIoRy+wdC
	MLm7sCDV5NCC9O0yI/T12mmhvdBPCpaKk8KopQjtWRon23JETNSkiro1Ww/K1PbxbHzcGZLm
	n6qkslARa0IhLM9t5B1NBXSQaW4V73b7cJDDuHX8xPBD0oRkLOaezuNbLIVEUAjlEviG5pa/
	JpJbyZd7XVSQ5dwm/kNZPvXv6DK+tv7+X09IYH+9ZAgFWcFF8a2mCnwRyUrRnBoUptGmJqk0
	iVGR+mPqdK0mLfJwcpKEAu90M3P6kg1Ndu9wII5FynlyGDOoFZQqVZ+e5EA8i5Vh8jGPTq2Q
	H1GlZ4i65HhdSqKod6DFLKlcKN+5Xzyo4I6qDOIxUTwu6v6rBBsSnoXk2TVN3M74cpfnUM54
	9I+JKHfo/KvX4iVnbO6Q8/fSvft6kndoV1eyi7SK0PMprLM+rm/Q0u46F6uPjDew62O3vZFm
	Vux/3zF3eUeO6r2nMXxfwljm/QsxKH08OuLwlmXSgczGJZffkttHL0UbzScaEkw/itcUjJ61
	xkWNdE77M5SkXq1aF4F1etUfkfJRL0oDAAA=
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


