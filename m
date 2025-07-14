Return-Path: <bpf+bounces-63174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7D4B03E14
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 14:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8631A6211F
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 12:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C422571B3;
	Mon, 14 Jul 2025 12:01:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC1E248F56;
	Mon, 14 Jul 2025 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494465; cv=none; b=lCqV3LF02KI9PiYQisrRGdzkLWKwkUucq7D5//Il0pQLPyIcg1luDhmhw21SVdk0gCnL9SZ80bqLvL5ARLxZGVJNCITWL6jhMxdB2wQFQE5xcEqR1v3yQofwNrNU9qNjR0Oo852VVkS2Gnu2znZ2fWRNbyDfPlgylKCspboL/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494465; c=relaxed/simple;
	bh=QOhmDSG8jrfmlxGLbdvqztAiBlRRR5rgcBBl2d5Txlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JFSXyAcwMq4m5hV+putMNkz6/AKvfSIu/7lu6IV3nvefe+WkJQEmF9I36HvTk1HcK1Bks7GKsUHsBa6jwZ9/gVpPdyXg0lDVj/RnIyszQM7D/wvT8A3J7DrUwDJs6it1a/r5zenZtRBweg8DRib4uYitgO62ZBXQqBGdYS1sY9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-7d-6874f17adf47
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
Subject: [PATCH net-next v10 08/12] iavf: access ->pp through netmem_desc instead of page
Date: Mon, 14 Jul 2025 21:00:43 +0900
Message-Id: <20250714120047.35901-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250714120047.35901-1-byungchul@sk.com>
References: <20250714120047.35901-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxTGee97v9rQ5Kaa7Q6zGWuMCYs6HFtOiFvIovGayNQQTWRBbeTG
	NgKSggyIi0wqSsVidMsAi2JFbamxWBSqFtSWKBMdWIUU5MMWRYcgaG1DAa0txv+e5HnO7zkn
	OSyWe6g4Vp2dJ2qylZkKWkpKx2ONy4re5Km+Kzm5CAzWizQ89J+hwDJVABee2ilwm3m40TVF
	gKG+CcG70BMGbGX9GPxtd2k4eyaIIdRwlARDp5aEgHUaw/M7Pgbane9JsNhSYOj8CAmOQ80Y
	XIEl4Ktop+GodgZD1eBBGsJ9MxS0hF4zcMBuIqDl1VUGupr0FPw1fQ5Dc/HTSNdwDwWPrhto
	eFTyEMHgxTAFI85I4ZipnwG9pRqB86aZhgPa72Hs6jsGJv9uwzCkT4YPlflwp/YLCHaMIXhy
	rpuAsMPOwH+DlyhoszYT8NgbwhAsr6FBN16BoLvqOgH3axooqOt4TET2SIWe8CwBJ9y1NAxr
	hxC4XT4STv6pR2Bt9VDwxhE5eWbKQCf/IrjGJrBgH6hDwhVzLyG8PPaBEDyt9wjhWvUAI9Ta
	9gqNpnjhrON/QtB53Fiw1ZfRgu3tcUbo73HQQnvlDCk01u0XXjZWoY1fp0lXZYiZ6nxRs+Ln
	HVJV3+VSnGNkCq6cCBDFqILWIZbluUR+4qZchyRz8pKpholqmlvKezwhHNXzuQTe77tL6pCU
	xdyDWL6lsZKIGvO4rfzrYReKapJbwuuNWhRlyrgf+LLg6k/Mhbyl4dYcR8L9yJ+u8c7F5ZFI
	q64OR5k8Z5Hw5henqE8DX/G3TR7yGJLVoph6JFdn52cp1ZmJy1WF2eqC5Tv3ZNlQ5N/O/zH7
	mx297Up1Io5FilgZjOap5JQyP7cwy4l4Fivmy0YHNCq5LENZWCRq9mzX7M0Uc51oAUsqvpSt
	DP6eIed2KfPE3aKYI2o+uwQriStGh2eP8KnEWn1RknH8nwXpKw/e0ltDiVv2LwqsW1Of8syf
	8N47YnKXLeYk/25NP1Wyzfsq9V6S77661BvQnZ5Oqk6LMzbFlGwGeq30WbVtdJPFEk+uT15d
	2mn+NqbvcspkeOIn2e1eV1GOa+RB+Tcp+8oL03/t7pBM3ugt9acVbOhUkLkqZUI81uQqPwK9
	dXv1awMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxjFfe97v2hoclOR3bBEkmZKYjLROMyzbDNOZ3xjhCyRxLhk0UZv
	bEMppIUGSJYBdi40s6CgA2knH5WVDwULQsWCpiWIQ5wWJB1QPiNxDplIQSpoLS777/fknJzz
	/HF4rGhn4niNLkvS61RaJSujZSlfnPk0byFLvaNsSgbW5iYWHi9WM9C4kgO/T7oY8NWLcPvR
	CgXWhnYEwdAoB86iMQyLPfdYqK1exhBqOUeD9U8TDUvNbzA87Z3moM/zloZGZzJM1M3S4P65
	A4N3aQtMF/excM60iqFi/CcWwiOrDHSF5jkodDko8NruR85/bnLwqN3CQNmbqxg68icjhTPD
	DAx2WlkYPPMYwXhTmIFZT6R1zjHGgaXxMgLPnXoWCk27YO5mkIOXF3swTFj2wrtyI/RWxcJy
	/xyC0atPKAi7XRw8HL/OQE9zBwVDUyEMy7/YWDC/KEbwpKKTgge2Fgbs/UNU5I8jMBxeo6DU
	V8XCjGkCgc87TUNlgQVBc7efgQW3id67n3jn/sXEFbAj0lb/F0WelbyjiL/7D4rcuhzgSJUz
	m7Q6tpFa998UMft9mDgbiljifHWBI2PDbpb0la/SpNX+I3nWWoG+3fyd7MtTklZjlPSJe07I
	1CM3zuLMGi6nrXSJykfFrBlF8aLwmXjdYePWmRUSRL8/hNc5RtgpLk7fo81IxmNhIFrsai2n
	1oWNwjFxfsaL1pkWtoiWGlOEeV4uJIlFy9/8lxkvNrbc/ZATJewWr9imPtgVEUu32Y5LkKwK
	bWhAMRqdMV2l0SZtN6Spc3WanO0nM9KdKLKmuh/WzrtQcPCgBwk8UkbL4XmWWsGojIbcdA8S
	eayMkT8P6NUK+SlVbp6kzziuz9ZKBg/6mKeVH8kPHZVOKITTqiwpTZIyJf3/KsVHxeWjQ4P+
	2MOv01IOxH+1VlrdMuJ9mMlqfcPOIV63azGc++Jl6kJJfLvWXXB/a9nT7/cnMpVB/a8d0lR6
	hiOQP2aPms2uC1g/SV05Qu7OJgX3GTehBCivlM131e5JvqW8NhBMWaqJd1w6mHw+NTpY1vB5
	U5/6a5Kgdhw++9uGOuNMp5I2qFU7t2G9QfUewTvwW0kDAAA=
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


