Return-Path: <bpf+bounces-61154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9FCAE1244
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 06:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415D9188B9C9
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 04:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F7C226CE4;
	Fri, 20 Jun 2025 04:12:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1DC1FDE02;
	Fri, 20 Jun 2025 04:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750392762; cv=none; b=AQ8Ja7fbu7ub7VwnKxQOGoHL3P3EysQCz93QUCkkSWPS6CjVhkUqYMy4ae50CnNN+dXbtdeXqkHeCNmkroG94QRoBd8dbDI5I0Wd6rFimhBcz6HTu2tuAy3loA4puQ0/HaTI1QT/U13iBNuEk96D0iSgfBik1qg2Nlxb5JSVKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750392762; c=relaxed/simple;
	bh=6XKzE5AjnkHOhNbJyUZM7HFd+RUUttC5m76509LyLgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=af+ReeLrKcROeYNxgW2fuOJVzxvlUeydwxh7rz3xTNSOwa4G79IF4BnjiV5QbhHhTlU+YsBjmWr38McBcj1d6o1dJCuWabFZUCHrbA59awiDr7h0op57i/0iTfoW0Bq2vzra7iXLH/47dPfAAk1lxXqNIdwbgABBE3tPHPzwiq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-8c-6854dfb2d233
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	tariqt@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	jackmanb@google.com
Subject: [PATCH net-next v6 6/9] netmem: remove __netmem_get_pp()
Date: Fri, 20 Jun 2025 13:12:21 +0900
Message-Id: <20250620041224.46646-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250620041224.46646-1-byungchul@sk.com>
References: <20250620041224.46646-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUiTYRzn2fPued8tR29L6s2iYHRQ0CUW/w8RdvqAKIX2oQNqtZe2mibT
	TDtNR8dIu6RyzlyJqdNYrdLZYWnzwg6PrFmmtuyATo+WZlCbEvntx+/8f/hzWJklDeJ0sQmi
	IVatVxE5I/8ScGnujc5o7YIXP1iw2EsIFA8kQUGXUwoWWymC/sFXLPS5agnkXfJisDw1MvDD
	/gvDuxoPC8WOCOi88p6Bu0fLMHhO1hFINw5huDf4lYVUZ6EEGkszpJD5Kx9DWUoXCy23LQQ6
	Sv5I4X1VOgP15iIGOjNCocY6AbwNnxG47GUS8J7IIXC22UrgrbETQfNDDwPZhzMQ2CvcUhga
	8HVkV3ewodPpw8/fML1Z1Cah5ebXLLU6dtMbhXOoyd2MqcN2nFBH7xmWtj+/S2jdhSGGljv7
	JDQ97SuhPe9eMvRbRSuh9putDH1kdbFrxm2QL9GIel2iaJi/dItc621MQ3ENY5Iqmo6RFOSR
	mRDHCXyI8NgUZkKyYeg0n2b8mPCzBLd7EPtxIL9Q6PPU+ng5h/mrRHCVvGL9wnh+mdDy8YPE
	jxl+hlDf82yYV/CLhHOmB2SkdJpQfO3BcJGMXyz0pN4Z5pU+z8Blo3TEP06oz+pm/Pdg37D9
	otJPY1807VY29u8KvJMTbMYvzEjnJKGy0M2cQrx5VNz8P24eFbcibENKXWxijFqnD5mnTY7V
	Jc3btivGgXwPc+XA741O1NsYVYV4DqkCFM7+KK1Sqk6MT46pQgKHVYGKvLpIrVKhUSfvFQ27
	Nht268X4KjSZY1QTFcHePRolv12dIO4UxTjR8E+VcLKgFLTVotlv6J/583BuSonK/XNT0Krn
	RqPHdmTlsvYpTVOiujNJqETAyz8VaNeWv7AU8IFhLcfG7uh1lc59dD33yeJ9OX9aKzsiZvcc
	tAbHNYVXr1ifEDSouX9+3Yp7TbIZYioXum5qekNkGo0gTwPaopvD80O+N+or294MTVh96IDx
	oEXFxGvVC+dgQ7z6LwIKOz4sAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e+cnR2Xw9MUO9gHYWSGpGVkvaSEadDBSrqRFIKuPLjllU3F
	SRfTWWpqmhU171reZbG8TDMTNS/4QfOSlnlhqUmK5m14xTYl8tvD8/ze5/nykphwA7cipcFh
	rCxYHCgi+Djf0znWXjN6TXK0pvgkZKrLCShbiYSiMS0XMkurESytDvFgsaWNgII8PQaZXUoc
	ltVrGEy06nhQprkIo4WTONQ/rsFA97SdgGTlOgYfV2d5EKMt5kBzVgcXuqtTuPB87S0GNdFj
	POityyRgpHyLC5NNyTh0qEpwGE1xhdZcS9B3ziBoUddwQJ+URUB6Ty4BP5WjCHqadThkPExB
	oG4Y5ML6iqEj4/MIz9WGaZ6Zw5jKkm8cplY1zGNyNeHM+2I7JnGwB2M0pQkEo1l4xmN+fK0n
	mPZX6zhTq13kMMmxswQzP/EdZ+Ya+gmmYOoPh1FX9uOXhDf5Ln5soDSClR057cuX6LtjUWjn
	nsiGL/FENNKZJCITkqaO01pVGm7UBGVLDw6uYkZtQTnSi7o2g88nMaqCoFvKh3jGwJw6Q/dO
	/eIYNU7Z0B3zfdu+gHKiXyY2Ejul1nTZu8btIhPqBD0f82HbFxqYlXwld4ffS3e8HjcMkIYB
	W1qdLTTamOE0tioDS0UC1S5K9Z9S7aJyEVaKLKTBEUFiaaCTgzxAogiWRjrcDgnSIMNPFN7b
	SNOipd5zTYgikchUoF26KhFyxRFyRVAToklMZCEoaPeUCAV+YkUUKwvxkYUHsvImtJ/ERfsE
	Hl6sr5DyF4exASwbysr+pRzSxCoaXRoeX+90U2QdTInT5+hOVRy4Fe/dFc5ezs/ZTB/YjLE/
	ViS09LzzyCw+wdU0zeHsp1K+u39USe2Lvv50JQxoL1i/CRK3XxFMK2zG6sJ+33/gb+dyON5Z
	eWN5w6vRPNXjUHmSe+jd7K3mvAXv62bnp9dEcVUKfoTnk0q3EDcMZD4iXC4RO9phMrn4L77r
	xaQPAwAA
X-CFilter-Loop: Reflected

There are no users of __netmem_get_pp().  Remove it.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/net/netmem.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index e27ed0b9c82e..d0a84557983d 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -245,22 +245,6 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
 	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
 }
 
-/**
- * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
- * @netmem: netmem reference to get the pointer from
- *
- * Unsafe version of netmem_get_pp(). When @netmem is always page-backed,
- * e.g. when it's a header buffer, performs faster and generates smaller
- * object code (avoids clearing the LSB). When @netmem points to IOV,
- * provokes invalid memory access.
- *
- * Return: pointer to the &page_pool (garbage if @netmem is not page-backed).
- */
-static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
-{
-	return __netmem_to_page(netmem)->pp;
-}
-
 static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
 {
 	return __netmem_clear_lsb(netmem)->pp;
-- 
2.17.1


