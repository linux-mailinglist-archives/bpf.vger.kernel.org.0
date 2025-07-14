Return-Path: <bpf+bounces-63177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0793FB03E25
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 14:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3E6189F869
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 12:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4681D25A33E;
	Mon, 14 Jul 2025 12:01:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFA72512FF;
	Mon, 14 Jul 2025 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494466; cv=none; b=DOV4pwEn8MDYRZ61uzfHlPu0T/ZT7DvPzfC3hXapanW536kXeUMhvCqkoKkOHd82UVa8FJN8KxVAO443EDiFKEdWsB0+SorlKfktPCLA2EKgzzaYW30BMMxhjPCZR76WLMcbayUsuK21sZjL1av+9lb4kY4y8hNrNN+QnOG/9eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494466; c=relaxed/simple;
	bh=TLxhqPJIfz3AvMf0ahyEZem0BqxOUvOB+Lo/b4vtNoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=noGuTr8dMpw3DXTDfOP8X5UnqR5r0hPxvnt/1Bhf+sl8A9X4mAhcIqr98mRwQSFChUP84ZE2TIZTBlG0bwXxFEI1vUjwXGxhjhk6gMo+VR0mCh1k/uH+rchWUriaAM+6oRjUgDRA9glOHFcY3rp1OlVZXTl5MzPJYsrliozF2tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-a1-6874f17a7c3b
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
Subject: [PATCH net-next v10 10/12] mlx5: access ->pp through netmem_desc instead of page
Date: Mon, 14 Jul 2025 21:00:45 +0900
Message-Id: <20250714120047.35901-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250714120047.35901-1-byungchul@sk.com>
References: <20250714120047.35901-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0yTZxTG9373NjT5Uo37xC26GhVNEPF6shglRpP3H5JtJiOD7NKsX2yV
	ixaoQDQy7QJUBdRNQEvAUbEFspKiULVc1qI04AUrkMpVSiRM640iUlCxxfjfL+fJ8zznJIcj
	5Y/oSE6TmiFqU5XJCkZKSZ9H/BOd8zpDveF8STQYrXUMPAhcoqF2JguuPLbT4LEIcLN7hgBj
	TSOCqeAAC7aCQRIC7R0MVF2aJiFYf5oC4309BW+ssyQ8ue1jwe18T0GtLR5GqscpcOQ1keB6
	swp8RW4GTuvnSCgb/pOB+f45GpqDL1g4bjcT0PzsGgvdjYU0/DV7mYSm3MehrrE+Gh7eMDLw
	8MQDBMN18zSMO0OFfvMgC4W1FxA4Wy0MHNdvAv+1KRZe/d1OwkhhHHwo1cHtyiUw3eVHMHC5
	l4B5h52Fe8P/0tBubSKgZzRIwvSpcgYMz4sQ9JbdIOBOeT0Npq4eIrTHXuibf0fAOU8lA2P6
	EQQel4+Ci38UIrC2eGl47QidPDdjZOJ2YZf/JYntQyaEr1oeEXii+AOBvS2dBL5+YYjFlbZM
	3GBeh6sc/xPY4PWQ2FZTwGDb5FkWD/Y5GOwunaNwg+kYnmgoQ999nSjdrhKTNTpRG7PjN6n6
	fGcHfbCHzbLP5LO5yMIYEMcJ/Gbh/WCsAUkW8Jw5lwkzw68RvN4gGebFfKwQ8HVQBiTlSP5u
	hNDcUEqEhUX8T8LY2yAVZopfJZx8UbdgkPFbBVfgGfEpdLlQW9+2MJeE5hXloyjMcn6L0GIw
	keFQga+SCNZRJ/vJsFT4z+ylipGsEn1Rg+SaVF2KUpO8eb06O1WTtf73tBQbCj1c9dF3SXY0
	2b3XiXgOKSJk8DRDLaeVuvTsFCcSOFKxWPZ0SKuWy1TK7BxRm/arNjNZTHeiZRyl+FK2cfqw
	Ss7vU2aIB0TxoKj9rBKcJDIXxZjG4/f175bkZWeeOLk8avIrHxcd9TJStauzxEP4ftiJ1q5J
	wm1pFXUx36/8sSNpUd7qRDyqd1Tof576JiEnqtEdXLu7M2uFUxXwdd/TcSnLGjfu//aXhAnL
	qy7ztlZt/lXzSjbB3TteP3Ug/9aekrRZf+K26pyLR+KXus4eOnbmiIJKVytj15HadOVHeN9t
	OWwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+93nHC0uS+r2oGgkQZT2Mg89TIrqEiVFRBS9bnVpq2m1qalQ
	aS6qVbOnuHK4cpU6azqzLVtam+SrpzpZqdOU3vb0kWulTaP/Puf75Zzv948jwqU2cqxIERsn
	qGJ5pYwSE+Lo+WnTk7/HyWcU1oyGLEsBBS+6rpBg7kuEG212EuryWLj3vA+DrPw7CLp9TTRY
	TzTj0FVRSUHOlV4cfIWnCch6piGgx/ILhzeP2mmocv4hwGxdBa3X3xLgOGbDwdUTAu3pVRSc
	1vhx0HuPUjDwyk/Cfd8XGo7YczFwGaoD46cSGp7f0ZFw4dc1HGwpbYHAjkYS6kuzKKhPe4HA
	WzBAwltnILUzt5kGnfkSAmd5HgVHNLOhs6Sbhm8XK3Bo1UVBf2YCPDKOgt7aTgRN19wYDDjs
	NDz13iKhwmLDoOG1D4feUwYKtJ/TEbj1pRg8NhSSYKptwAI91kLjwG8MztcZKejQtCKoc7UT
	cDlVh8BS5iHhu0NDRC3hXJ1fcc7eYkLc7byXGPf+TD/GecpqMO7upRaaM1rjueLcqVyO4wPG
	aT11OGfNP0Fx1h/naK650UFxVZl+gis2HebeF+vR6gkbxQt2CkpFgqAKi9wmlmfUVJL7GuhE
	e99xOgXlUVoUJGKZOez53JQhppgprMfjwwc5mJnJdrVXElokFuHMk+Hs/eJMbNAYyWxgO376
	iEEmmBD25JeCoQUJM5d1dX3C/h2dyJoLHwzpQQE92/AaDbKUCWfLtCb8DBIb0bB8FKyITYjh
	FcrwUPUeeVKsIjF0x94YKwq80/WDv8/aUXf9cidiREg2XAIf4+RSkk9QJ8U4ESvCZcGSjy0q
	uVSyk09KFlR7t6rilYLaicaJCNloyYr1wjYps4uPE/YIwj5B9d/FREFjU1Dq8hh9S3TPMHPb
	4gvZxihlqT+y5NyYyfHetMgtGdPE0SPmz1q0ome8OzMjf9nupZIQybybqYaix/2bLe7ytUWJ
	1VOy05ObHuaE9WZX8Zv07xTz0mymV/6nG9yCPF235l7rOyjfLjtQuzDiED99e1iNdNR+77rd
	EZMizBGWlVdlDctkhFrOz5yKq9T8X5jRLupKAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool users
should use netmem descriptor and APIs instead.

Make mlx5 access ->pp through netmem_desc instead of page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 5ce1b463b7a8..5d51600935a6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -710,7 +710,8 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				/* No need to check page_pool_page_is_pp() as we
 				 * know this is a page_pool page.
 				 */
-				page_pool_recycle_direct(page->pp, page);
+				page_pool_recycle_direct(pp_page_to_nmdesc(page)->pp,
+							 page);
 			} while (++n < num);
 
 			break;
-- 
2.17.1


