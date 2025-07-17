Return-Path: <bpf+bounces-63573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA827B08610
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550953ABC07
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 07:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF975246BC4;
	Thu, 17 Jul 2025 07:01:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8182264B7;
	Thu, 17 Jul 2025 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735679; cv=none; b=n6jz7M/L/V1pERf7bltQzqeeX8o/5gK7osSs5mEAzwurIy/nK+Vvg+0Z8PzRa/axMOAXYD4dezGGWsCJUXsjqp0Mz20VV5xYE5jgO6UIEp8+VXF7DI/PyCkETLAZZApHLrKYQ4ZLepkNRKlBiO1aHghbJkFOdpP6M/hdY4TVGNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735679; c=relaxed/simple;
	bh=TLxhqPJIfz3AvMf0ahyEZem0BqxOUvOB+Lo/b4vtNoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TeLkIUhGk56qkb95p6q2/DaJ8dKYYtjxeU5AtJoinFOL6wgSclESXJC7YUxkhO4MJbOgrmDHkSAh/ly3tqorSvs2zfKuenn9nMBtCQewXFsj7xWgpaEAQnY1fKJjS4z+m7mNPFugVTXZEDcthmqziclnLnEQvkIgCs/X48WhEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-72-68789fb4929b
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
Subject: [PATCH net-next v11 10/12] mlx5: access ->pp through netmem_desc instead of page
Date: Thu, 17 Jul 2025 16:00:50 +0900
Message-Id: <20250717070052.6358-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250717070052.6358-1-byungchul@sk.com>
References: <20250717070052.6358-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTdxTG/d93GprddMruSsyWZmQGMxXF5HxAQpbF3MSMmJiYoVlmIzdr
	Q6naYi1zy5jUCN2oiGxCrQGxuvKisBZtwRa1JUKKL1BeUgHB1azBAG6ANC11Yovx2y/nyfM8
	5ySHwSVPSCmjVJcIGrVcJaNEhGg+temLzga9YlvcLAVLexsFQ0uXSWiN6uHPZy4SAs0c3B6M
	YmBpuYXgVWyCBnvlJA5LvX0UXLkcwSHWUUWA5bGBgOX2FRz+uR+iod/7PwGt9q9h+lqYAPcZ
	Jw6+5QwIne2noMoQx6F+6jQFq+NxEjyxlzScctkw8MzepGHwlomE2pWrODjLniW6no+RMNxt
	oWC4fAjBVNsqCWFvonDONkmDqdWMwHunmYJThh0wd/MVDf/93ovDtCkP3tTp4H5jGkQG5hBM
	XB3FYNXtouHR1A0SetudGIz8HcMh8tslCozzZxGM1ndj8OBSBwnWgREsscc+GFt9jcH5QCMF
	zw3TCAK+EAEXfzEhaO8JkrDgTpwcj1qovC9539y/OO96akV8Z/MTjJ+pfoPxwR4/xneZn9J8
	o/0477Bl8lfcLzDeGAzgvL2lkuLtizU0Pznmpvj+ujjBO6w/8zOOerR34wFRTqGgUuoEzdbc
	QyLFH/4+8ugIrXdFK+gy1EwZEcNwbDa3YMo1opQ1dLqMRJIp9nMuGIzhSV7PZnFLob7EXMTg
	7MNUzuOow5LCh2wB569oWjMQbAZ3MXyBTLKY3cmFqhfxd6GfcK0dd9c4JTGP19ZQSZYkykaa
	yuhkKMc2pHANF7rQO8PH3D1bkKhG4ka0rgVJlGpdsVypyt6iKFUr9VsOHym2o8TDXfvp9UEX
	Whzc50Usg2Sp4kMdJxQSUq7TlhZ7EcfgsvXi8wGdQiIulJf+IGiOfKc5rhK0XpTOELKPxNsj
	Jwol7PfyEqFIEI4KmvcqxqRIy9BXKqd6rGi4ej6cM+r5bHmm/K/TVr9xdmLp3P6TC2aPu2iI
	+fTbSHqJZqh+3L/r2H6PK+uuOxbO+NFRLj+wuZvN3FSYf/3wsYKcvV3fnLm9a/Oj4ZxJm/aF
	Z14a3DBeYLCWU8a8hZfR6zXZd3bn95jTPuj02fS5s9ukvqpf97RxQRmhVcizMnGNVv4W5kW2
	9WwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe2xLcRTH/e7vPrpmlasWrnk3EUK8YpLjvZBwIwiZRDwSq7m00XXSTm0E
	RcU2bDPDnnQP7CE23WjRIW1jD2O01RR7ULF4zHPTrIrqJv77nPPNOZ/zxxFhqZmKFinVyYJG
	LVfJaDEpXrPg6PT6iymKWUYDhqKaqzQ87S2hoLo/Ba68slDgrOTgzpN+AoqqbiLoC7xkwJTe
	jqHX0UhDWYkfQ6D2FAlFbQYSftT8xPD2gY+BJttvEqpNq6HrcjcJ1uNmDPYfk8CX1UTDKUMQ
	Q37nMRpCL4IUNAQ+M3DEUkGAvbg5XH68wcCTm5kU5P68hMGsfxUWvvFQ4LpdRIPr6FMEnVdD
	FHTbwtaeinYGMqsLENjuVdJwxDAHem70MfD1rANDV2Ys/MnTwQPjCPA/7EHw8tIzAkJWCwOP
	O69R4KgxE+B+HcDgP1lMQ8anLATP8m8T0FpcS0H5QzcRviMOPKFfBJxxGml4Y+hC4LT7SCg8
	nImg5q6Xgm9WAxm7jLf3fMG8paMc8fWVzwn+XfYfgvfebSH4WwUdDG807eHrKqbyZdb3BJ/h
	dWLeVJVO86bvOQzf7rHSfFNekOTryg/x7+ry0dpxm8QLtwsqpU7QzFwcL1aca2mkdruZFEt/
	GqNHlXQGihBxbAxntmSQA0yzkzmvN4AHOIqdzfX6GsN9sQizjyK5hro8YiAYzm7kWtJKBwdI
	dhJX2H2eGmAJO5fzZX/H/5aO56pr7w9yRLgfzM0ZlEnDMnepnslGYiMaUoWilGpdolypmjtD
	u0uRqlamzEhISjSh8DtdPvDrtAX1uVbYECtCskhJfO1ehZSS67SpiTbEibAsSnLGqVNIJdvl
	qfsETdJWzR6VoLWh0SJSNlKycoMQL2V3ypOFXYKwW9D8TwlRRLQeyUplY9T3Yl4wE1raLqgm
	R6yJ0yTdOeZbHyN29fpH7zjY1pyjLUj+vGiJJXfs2QUljvND01cbVrmXLs/1uCrIUdFTVnx1
	nhiWkOOPTVs0L+FWx9Zps2TXjzckz7Nva42bv3/bx/uOVYfpssjgxPqFMw96vOrCD5tLyta1
	Cs36rGVb4kMyUquQz56KNVr5X2kwSOZKAwAA
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


