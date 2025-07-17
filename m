Return-Path: <bpf+bounces-63569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB63B085FC
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEE716329D
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 07:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2F022D9E9;
	Thu, 17 Jul 2025 07:01:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C163E22069A;
	Thu, 17 Jul 2025 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735676; cv=none; b=nrLQuip7SGPEMxyAo2B0LE1hJ+TNToCu7+A1qxaaYhEb5huHrhjNMjjZShd2XOqs+E5AF/t5cOTmccfMVxRPeCVJBM1kM/hD7EwwE3s4PglzPYlF0fRo6WHwJkrJTmh8MUZpMvQy0B6oyKc/OoMc3JwmIUyhHugHnDGZhVjoCek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735676; c=relaxed/simple;
	bh=HXMDbfTv00/7A5kkhSM8+20skpcA9dA70cjXrMnYr4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UfMO6/J1XUcdidUp0v8k5W26p5M/2u7VF0nf5z3o+BGBYQ1c6QKW177jt3fC92uwV6raWUDVGr7bIhOhwEO/KD+RK9fFHafBSmKaYTuacywSHDWBUanOR+bmwtXKZpmy469MpruNtqn4MP/AgfJTekv7qKfaKOrQEQeEdhzAFLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-3b-68789fb3feb4
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
Subject: [PATCH net-next v11 07/12] octeontx2-pf: access ->pp through netmem_desc instead of page
Date: Thu, 17 Jul 2025 16:00:47 +0900
Message-Id: <20250717070052.6358-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250717070052.6358-1-byungchul@sk.com>
References: <20250717070052.6358-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTdxTG/b93Gpq8qYa9012SLkSCkU1Bcz7gpsYP/y9GEz8saKJWeWMb
	uaXVWpYsVIQ4GgWjJYKrscrFconFcnvFFrEQILoNqICd1qJlQ8UKSrWhFu1azL49Oec5v+ec
	5HCkwkuv5jQFx0RtgSpPycgo2evka+s7rhjUP/zWTYLF3srAWOgqDS2LBrj+VKLB0yTA7dFF
	AizNXQjeRR6z4KjwkRAaGGKg7mqYhEjbWQosI2UUvLd/IOHfwQALw+6PFLQ4dsJU4wwFztNx
	dv/7VAhUDTNwtixKQq2/nIHYoygNrsgcC6WSjQDXq04WRrsqaTB/aCCh2/g0njU9ScODHgsD
	D06NIfC3xmiYcccDgzYfC5UtlxC47zQxUFqWCcHOdyy8qR4gYapyK3yq0cOgNQXC94MIHjdM
	EBBzSiz85b9Bw4C9m4DxZxESwmcuM2B6XYVgoraHgD8ut9FQf3+ciO+xByZjSwRc8FgZmC6b
	QuDpD1Dw+8lKBPZeLw1vnfGTo4sWZut23B+cJ7H0pB7hjqa/Cfzi3CcCe3vvEfjWpScstjqO
	43ZbOq5zviSwyeshsaO5gsGOhfMs9k06GTxcE6Vwe30JftFei3Z/vVeWnSvmafSi9vsfD8rU
	HVIrVRRiDYHyXUbkZ0woiRP4LKGzQiJMiFvWb0c0iTLDrxW83giZ0Kv4DUIoMESZkIwj+T+T
	BVd7DZForORVwtLk2LKJ4lMF88xDNqHlcU6Vf4L4zP9WaGnrW/Yk8ZuEqPn8cq4i7hm/ZmQT
	UIG3Jwl9FR7288CXwl2blzqH5Fa0ohkpNAX6fJUmLytDXVygMWQcLsx3oPi/Nf66tE9CC6N7
	3IjnkDJZfrDthFpBq/S64nw3EjhSuUp+waNXK+S5quJfRG3hAe3xPFHnRms4SvmFfGP4RK6C
	P6I6Jh4VxSJR+3+X4JJWG1HmmZyG+bQSo8KcHerNPJSdVpIzP4L3ZVcf/qa/cG67K/hsv3Ml
	1dU6G9nUuA2FU9fbivuyTktDndU3f66e3blZV5oz25NhsNJrd8To51Ku71HKktX603S6dd2O
	SNHFzflbphzyscG5i9G0e/8sHDHXuXwW5XeWlNuDu4a+mi4nlZROrdqQTmp1qv8ATxGIJWsD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTZxTHfd47DY1vOiKveEuaNETY2JwjOcvMQmKMj8Zb9MMW90EqvLGd
	XEwLXdnm7LBeqFpUMIJCLCsgN2nXcqla0bQEuuEFysUOobgaCJuwzXEJFRQLid9+J/9fzv98
	OBwpa6bjOHVWjqjJUmbIGQkl2fPFyY+cN/SqT9yzG6HM1sBAz1QFDfVzerj53EWDv1aAu91z
	BJTVtSCYDj9jwVEwRMJUeycD1opZEsL2CxSUPTFSMGN7TcJoR4gFn+cNBfWO3TBSPUaB+0wr
	Cd4ZBYQKfQxcMM6TUBo8xcDi4DwN98L/sJDvqiHAW/5bZHzZzEJ3i5mG4tdVJLQankcKXwzQ
	0HunjIHekz0Igg2LNIx5Iq0TNUMsmOuvIfDcr2Ug37gZJpqnWfjvSjsJI+YUeFuigw7LKpjt
	mkDwrKqfgEW3i4XHwUYa2m2tBPT9GSZh9nw5A6bJQgT9pXcIeFhup6Gyq4+I3HEABhYXCCjy
	Wxh4YRxB4PeGKLj+sxmBrS1Awyu3kUrZir0T/5LYNVyJcFPtHwQev/iWwIG23wl8+9owiy2O
	XOysScBW918ENgX8JHbUFTDY8f9lFg8NuBnsK5mnsLPyBB53lqJ96w9KtqSLGWqdqPn4y1SJ
	qsnVQB2bYvWhU3sNKMiYEMcJ/GfCqydqE4riGD5eCATC5BLH8JuEqVAnZUISjuQfRQv3nCXE
	UvABrxQWBnqWJYpXCMVjT9kllkb2FAb7lx2B3yDU2x8sO1F8sjBffJlZYlnE6fvFwF5EEgta
	UYdi1Fm6TKU6IzlJe1SVl6XWJ6VlZzpQ5Jmqjy9ccqHp3u0exHNIHi1NtX+nktFKnTYv04ME
	jpTHSIv8OpVMmq7M+17UZB/S5GaIWg9aw1HyWOnOr8RUGX9EmSMeFcVjouZ9SnBRcQZ0zh4f
	S53u/rs8oa3DffbzXYb8gh/c13el/fStNjpzYeenllh+eE6+/tcHyYct+0PRivgZ4kfzOr/1
	ttUwSO2YTHTUkV0vKy1rDiYNznQPp4ziZpn1isL34X3feJHzbs+tq41xiZMrvzmuO6Lzb8he
	vc2mL9i86uuN3s61jxRzoyVqOaVVKTclkBqt8h3bHVNiSAMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool users
should use netmem descriptor and APIs instead.

Make octeontx2-pf access ->pp through netmem_desc instead of page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 99ace381cc78..625bb5a05344 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -1571,7 +1571,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 		cq->pool_ptrs++;
 		if (xsk_buff) {
 			xsk_buff_free(xsk_buff);
-		} else if (page->pp) {
+		} else if (pp_page_to_nmdesc(page)->pp) {
 			page_pool_recycle_direct(pool->page_pool, page);
 		} else {
 			otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
-- 
2.17.1


