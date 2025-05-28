Return-Path: <bpf+bounces-59069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B954DAC5F7E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2CB4166774
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4F621A458;
	Wed, 28 May 2025 02:29:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6EE1E9B08;
	Wed, 28 May 2025 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399371; cv=none; b=UsjSTCPCrtMQ/n2pSqoFAsrLJvTvgA3djqHVBK8T0OqlJCBX/pp8F3EtyRKIId5dDG5LAXZ0897vtiGKO4f/5R29KAqPvS7lgvZ0wQxtT51YJ6W4uB/EuisrLhWMtt0s3ElW6leXB0F9dHfgvxYXococyLtw0BCO4/X7wP43Adg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399371; c=relaxed/simple;
	bh=3Kt0d3eGR5T8xiFGwL/cldZmUj+PrXCfAZYAHnjIPuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rO8mcBq65IPVgi4xBcL4bzRDlY+WLbzjNiAX3Js1YKB9zJ2o1ME4RjSV7Njoc9J9IhWL2ABx4ztKitz4vEmiL/H18VO+1M1E0xVLrth+9HtoKwU14DmzhVjaVuKfDxLFT8vPSlzHt0qvVR9lb6xjUG44WZAcrPxTFysBLXloa5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-9d-68367502188d
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
	vishal.moola@gmail.com
Subject: [PATCH v2 13/16] netmem: remove __netmem_get_pp()
Date: Wed, 28 May 2025 11:29:08 +0900
Message-Id: <20250528022911.73453-14-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250528022911.73453-1-byungchul@sk.com>
References: <20250528022911.73453-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRjHe3fenXNcTU5L6rhuuMrIyDTUniJMiOD90AchhMoPdtJTG+rU
	zXkpkqWiac3squiiWXm3ZtN0RVnqvNFNNGtdzFgpFKWkNTSDconffvyeP/8P/4elFA6sZDXa
	VFGnFRJUtAzLvi+p2CIxhKmD7g76gdnaQEP9dAZUf7RLwVzXguDnzDsGphw9NNyocFNgfpGL
	4Zf1NwWj3S4GRqrGMDzIb6XAda6XBlPuLAXZ9hoJ9LcUSeHS70oKWo0fGRi8b6bhQ8NfKYx1
	mDD0ldViGCmKgG7LcnA/+YbAYW2VgPvsVRouDlho+JQ7gmCg04Wh/FQRAmubUwqz02Y6wo80
	176RkHtlwwyx2AykqSaAFDoHKGKrK6CJbfICQ96/ekCT3tJZTO7ZpyTElDNOkx+jbzGZaBui
	ibV5CJOnFgdDpmxrIrlDsl1xYoImTdRtDT8sUzsul1HJ12QZA9bX2Ii62ELkxfJcCJ9X1cks
	8OXmlxIP09xG3umcoTzswwXzU64eXIhkLMWNS/lR8+z/0DJuJz/2Oh97GHMb+Om80/+9nAvj
	Hz27Qc+XruXrGx/PFbGs15zveh/r0QoulJ84Y0WeTp77xfDXm4ap+bwv317jxMVIbkGL6pBC
	o01LFDQJIYHqTK0mIzA2KdGG5n5bdfJPtB1N9u/vQByLVEvkpDFUrZAKafrMxA7Es5TKR569
	O0ytkMcJmcdFXVKMzpAg6jvQSharVsi3udPjFNwxIVWMF8VkUbdwlbBeSiPy3bfqYZwu6mK5
	9y5n1p4vc8sf2LxGX1+c3h/t/3z9uPv2wVtR4UHGFFL61U+Zo2zbcb4y8MimlAz/TU329Dz/
	eGH6fr5J0rVYHhDepvYtaUoKLn3xuXryw5WuExOpWQXepr6be4cOpsY8L9g+rE2eSY4sGWzg
	VpeFGta134mpPLpUhfVqITiA0umFfzSUtwHXAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRW0iTYRzGffe9+/Y5G30us4+80AYVWHmItD9qZle+dGFdBJYX6tAPt5zT
	NhUNxCNZ5qmDFDZzKXm2yRweQkx0Og+d1NRllmJpkqGlJlODUqO7H7/n4bl5GEpajQ8ySnUi
	r1HLVTJajMUh/tknBEm+Cq+iZ06gMzTQUG9LgeqZNiHo6loQrG18EMGq2UJD5ZN1CnRvcjD8
	MmxSMNc3K4LpqnkMHbmtFMwW9dNQkLNFQVZbjQB6ygaE8LalUAj3N59S0JoxI4LR5zoaPjX8
	EcJ8dwGGgdJaDNOFQdCnd4b1oe8IzIZWAaznl9Fwb0RPw+ecaQQjPbMYHmUWIjB0WoWwZdPR
	QTJiqn0vIO2lH0VEb0wizTXuJM86QhFj3S2aGFfuisjUeAdN+h9uYdLetiogBdlLNPk5N4nJ
	cucYTSoXfgiIwTSGyUu9WXTRMUwcEM2rlMm8xjMwUqwwl5RSCeXilBHDBM5AvUwesmc49hRX
	Ynon2GGaPcpZrRvUDjux3tzqrAXnITFDsUtCbk63tVvax/px8xO5eIcxe5iz3bi56yWsL/fi
	VSX9b9SVq2/q2h5iGPtt3zsVtaOlrA+3fNuAipFYj+zqkJNSnRwnV6p8PLSxilS1MsUjKj7O
	iLbvq0r7facNrY0GdyOWQbI9EtLko5AK5cna1LhuxDGUzEmSddZXIZVEy1Ov85r4CE2Sitd2
	IxcGyw5IzofykVI2Rp7Ix/J8Aq/5nwoY+4MZCLulxyzoVoYdjR1mmUXVaI9iHWoHLdozrq+P
	TewPNrUWN6clu1w4Pd74hclcCgngFyM7HWyTcSdb2sOPLM+7qSwV7o8vOc5d1hmvmCKMhziv
	MZemsMGBYXVP2HFnxbWhcOtXLrQl32b3zfPcg71JzRWKq6ldfsVB/uzgYnpguQxrFXJvd0qj
	lf8FtSqMxroCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

There are no users of __netmem_get_pp().  Remove it.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 include/net/netmem.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 4c977512f9d7..96472e56e8ee 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -224,22 +224,6 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
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


