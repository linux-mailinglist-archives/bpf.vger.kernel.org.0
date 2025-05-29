Return-Path: <bpf+bounces-59237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F3EAC7617
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9F13A10CB
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1BF24A078;
	Thu, 29 May 2025 03:11:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DFB1DEFE8;
	Thu, 29 May 2025 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488270; cv=none; b=h8featNZOSQIZcz/z1qtV0RgqHeK6NVmgu3Bv97KQf4SF0wz14JOgBzzh07cchVjK7GYT/Hd20iksCf6yFQY5ShzNWENs2Qzz+b1FqXn1J9xSiZ8zZpjxBlRUmHNlskzTs9ptXbtymz0ZJhCFbWCu4+s4Jx1BXHtBaygXcKCfAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488270; c=relaxed/simple;
	bh=plIDmpqi+WGX1YT9ietvC0dgtetMEzfy1+tYj+jQ6pU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZjW33p2Qsdla8ToDAqu/GWRgIbtlkQQFnmjhmuugoamgGGWoo2wrHKmZ6S0RqhcIG5ykAxzC1woKwvG/PCAKnzRaBEYTio2FCyUYtRxtOOBFJ5O4UFxYRnbN7j/qNf/99mnbFMhn2h1cgzKvR/fLdECCJ6dBaKLs9fWedTH74y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-d6-6837d041cb4f
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
Subject: [RFC v3 02/18] netmem: introduce netmem alloc APIs to wrap page alloc APIs
Date: Thu, 29 May 2025 12:10:31 +0900
Message-Id: <20250529031047.7587-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529031047.7587-1-byungchul@sk.com>
References: <20250529031047.7587-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRjHfXfenXMcjk5L6qRQOApJyEtYPh9Cpb68CEHgF6sPOvTUlnPa
	vKRdwEwqtc0oEV0T5iXzBot5myWWF+akQPPGsnSiqIQ3vA0voTnFbz+e//P/PR8elpJ1Yx9W
	pUkTtBqFWk5LsGTRq+LitYEwZXBuHBjNDTTUb2bCx0mrGIx1LQjWt34zsNbTS0NluYsCY38u
	hg3zNgUztikGnNWzGNpftlIwVWinQZe7Q0GOtUYEAy16MRRtf6CgNXuSgaHPRhomGvbEMNul
	w9BnqMXg1EeCzXQSXN8XEPSYW0Xgel1Gw7tBEw3TuU4Eg91TGN4/0yMwdzjEsLNppCP9SFPt
	LxFpM4wzxGRJJ401ASTfMUgRS10eTSyrbxnyZ7SdJvaSHUzarGsionu+RJOVmTFMljtGaGJu
	GsHkh6mHIWuWMze525KrCYJalSFog8LjJMq5xhJRSrNnpnN+iM5G40w+8mR5LpSfbi7ER1w6
	bkVupjl/3uHYotzszYXwa1O9+zsSluKWxPyMcUfkDk5w0fyuZW6fWRZz5/mS+WD3WLrvqfpb
	ID50nuXrP3078Hhyl/nixuKDqsx9K7+Tdjt5boXh+6rG0GHhNN9Z48BvkNSEPOqQTKXJSFKo
	1KGByiyNKjMwPjnJgvZfW/303x0rWh2I7kIci+ReUjsKU8rEiozUrKQuxLOU3FuaE3FFKZMm
	KLIeCdrkWG26WkjtQr4slp+SXnI9TJBx9xRpQqIgpAjao1TEevpkI49lmz10Nf5Y3kRL6YLp
	ulHGxYy8ujtcsO5zPLAiqMU7PyqssV3tk6i3ZTBt209EZcGG/lt90UX+wx2lsTc0tcSEKruH
	1ks3lnV+W+dCYgyL5ZBXuIkNuxeUX3/q7vfY55J8vaKc+pWIhCwbt2gKHxidj3ywl/nisTzg
	C96V41SlIiSA0qYq/gPRtppC1gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG/Z/Lf8fZ4DhFD/ahnFkkVlqaLxlmH6RDkQQWgZA68uCW88Km
	ooFhKkRT103EdOLCvEureZshUVPyUqBotnWxycQbil28Z2jO6NuP9+H9PR8ehpTWUz6MMjVD
	UKfKVTIspsTR4QVHzg6HKYLa9UdAb2zB0LyeDfUTZhr0TR0Ilje+iGCptw9DzZNVEvRDhRSs
	GH+TMPXWIQJ73TQF3Xc6SXDc68dQUrhJQr65gYCeqgEahjt0NJT+riWhM29CBKMv9Ri+tWzT
	MG0poWCgopECuy4S3hq8YPXdAoJeYycBq8VVGB6NGDBMFtoRjPQ4KKi8rUNgfGWjYXNdjyNl
	fFvjJ4LvqhgX8QZTJt/aEMBrbSMkb2q6i3nTr4ci/uvHbsz3l29SfJd5ieBLChYx/3PqM8V/
	fzWG+ZrZHwRvbBuj+PeGXtEl91jx6URBpcwS1MciEsSKmdZyIr3dNds+P4rz0LhIi1wZjg3h
	Ho+bkZMxe4iz2TZIJ3uywdySo4/SIjFDsos0N6XfJJyBBxvDbZlmdphhKNafK58Pcp4lO56n
	c0X0P+c+rvn5612PKxvKlbWW7b5KnV3aN/g+EhuQSxPyVKZmpciVqtCjmmRFTqoy++j1tBQT
	2pmvLvfPAzNaHj1nQSyDZHsk/ShMIaXlWZqcFAviGFLmKck/c1IhlSTKc24K6rR4daZK0FjQ
	XoaSeUvOXxUSpGySPENIFoR0Qf0/JRhXnzxUss83KsrHy6Ph4uUTdJVpItDteFLf3EzcqQgi
	9sNBPBh9zS3XigN6dSGlL5IqDyR3OlpL18Kta+7F3kWTISvPJqyDXJffvFl7y6Zj3RKra2fj
	NA6rfeHCVl3AnI9jm70RndC/wLpEx/dNx/gFig8vO+ZVVv8hVVy1L3vFsl9GaRTy4ABSrZH/
	BXliA8O6AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool code
should use netmem descriptor and APIs instead.

As part of the work, introduce netmem alloc APIs allowing the code to
use them rather than the existing APIs for struct page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 net/core/netmem_priv.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index cd95394399b4..32e390908bb2 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -59,4 +59,18 @@ static inline void netmem_set_dma_index(netmem_ref netmem,
 	magic = netmem_get_pp_magic(netmem) | (id << PP_DMA_INDEX_SHIFT);
 	__netmem_clear_lsb(netmem)->pp_magic = magic;
 }
+
+static inline netmem_ref alloc_netmems_node(int nid, gfp_t gfp_mask,
+					    unsigned int order)
+{
+	return page_to_netmem(alloc_pages_node(nid, gfp_mask, order));
+}
+
+static inline unsigned long alloc_netmems_bulk_node(gfp_t gfp, int nid,
+						    unsigned long nr_netmems,
+						    netmem_ref *netmem_array)
+{
+	return alloc_pages_bulk_node(gfp, nid, nr_netmems,
+			(struct page **)netmem_array);
+}
 #endif
-- 
2.17.1


