Return-Path: <bpf+bounces-59251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B75AC7646
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101E01C06035
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0C125D20A;
	Thu, 29 May 2025 03:11:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E234253340;
	Thu, 29 May 2025 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488274; cv=none; b=c33WVjrRjGxK58BqDBrAs71JIggkRlUZOsMUBib6GFMHdPXVcseAdMXcbsNFuhm7yYsYmsoi5qC1Hz1WVjooPNoEKpqCxSTZNHtsmzgaFo5hgygAahkzBGplz36lvYbDOOS3HgZ7WmEOoMzErlzm9if9LdpzB9HQg9ydeKApc+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488274; c=relaxed/simple;
	bh=SjfVxyVYeMWAE9q6eJb9uRY4T5ndxmnxuHHIHWxPLyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jXp8p/4MH49Vgt1HAjnm37ZwwNmCF7L9NQid51zZfR2YDMV4OBcDT8kmQJ/We5mnaqWEKN0UzpYFs01lqRjIGeo1WwVsrJZPpk9z3IPjtsiFc+FsmuB7kMXATc7hG7ripYBNSIwAbISuVAbQpLOb7IyG0G2gMbWXN2Ur9dDILdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-67-6837d042e29f
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
Subject: [RFC v3 16/18] netmem: introduce a netmem API, virt_to_head_netmem()
Date: Thu, 29 May 2025 12:10:45 +0900
Message-Id: <20250529031047.7587-17-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529031047.7587-1-byungchul@sk.com>
References: <20250529031047.7587-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRe0hTcRQH8H67v917HY4uS/KqYDiQSkgzVp4iSpDgEgWFSFCEjby02Zy2
	6XyAYGaawy01k7JJs4fNB6ym6CyTfD+SFMuaPdQcSo+lqLl8RKUz//twzuF7DhyakHRgf1qp
	TuY1arlKSoqw6Id3xa6owQjF7qoiDCZrLQk1i2nwaNwuBFN1A4KfSx8omO/oJuF+hZsA00AO
	hgXrMgGTXRMUjFVOYWjOayRg4noPCYacFQKy7RYBDDYYhVCy/JCAxqxxCl4/NZEwWvtXCFNt
	Bgy9ZVUYxoyR0GXeCu6XLgQd1kYBuAvKSbgxZCbBmTOGYKh9AsOdy0YE1haHEFYWTWRkEFdf
	NSLgmso+UZzZlsLVWUI4vWOI4GzV+SRnmyumuI9vm0mu59YK5prs8wLOcGWa5GYn32NupmWY
	5Kz1w5jrN3dQ3Lwt8ARzWnQwjlcpdbwm7NA5kaJhdIhMukenFbvzhVnIReqRF80yMna6oJna
	sKHS6THJbGcdjiVizT5MODs/0Y31SEQTzLSQnTStCNYaW5jjbK69wGPMBLOW/j8ei5m97LXs
	PLweuo2tefzCE+S1Wi+tK/XMSFaX3da3/j9ilmJH2o+s249ttThwIRKb0aZqJFGqdQlypUoW
	qkhXK9NCzycm2NDqbyszf5+xo7nB6DbE0EjqLe5BEQqJUK7Tpie0IZYmpD7i7MP7FBJxnDw9
	g9ckxmpSVLy2DQXQWOor3uNOjZMwF+TJ/EWeT+I1G10B7eWfhbzIvumbM+WpjvJee61lqfR7
	7s7O5KDiGl3zwoPOQL8xV2KrjIqe/RLMpnUpFz87Mv4UGQSbd0QFGV8l98b6ao/FKGSuk5fe
	XFUksV+/DY8s22birM81U88Gji464wdOxXQ7Xe/inxTePRsWm9f6K6AwfLgzXC/T9ZWoM/c7
	DzRKsVYhDw8hNFr5P7iKDrvXAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRbUhTYRzFe3bvfXYdTW5L9GYfhIVIUpaV+q80LQkfoiIoDILIkZc2fGVT
	0SKwuTLNWVqo2YSVaNNZN6boDBXf8IUsRVNnL2qKEmGaaeJblhp9+3HO4ZwPh6UUFtqd1cQm
	CNpYVbQSy2jZ2aNpe0/0BKj326oOgEmswGBdTIbno3YGTOXVCOaXPkphrrUdQ/HTBQpM3QYa
	fonLFEy0jUlhpHSShrr0GgrG7ndgMBpWKNDbLRJoKepkoKc6m4FHyyUU1KSOSqHvtQnDcMUf
	BiabjTR0FpbRMJIdAm1mV1h4M4WgVayRwEJWEYaHvWYM44YRBL0tYzQ8uZWNQGxwMLCyaMIh
	SlJVNiQhtYWfpcRsSySVFm+S6eiliK08AxPbz1wp+TRQh0lHwQpNau1zEmJMm8ZkduIDTWYa
	+jEp/vpDQsSqfpp0mVul57ZdkgVGCtGaJEG771iETF093Ivjn7HJuQsZTCqawpnIieW5Q7yx
	dFy6wZjz4h2OJWqDXThffm6snc5EMpbiphl+wrQi2TC2c2f4O/asTaY5T97StbbJcs6Pv6tP
	p/+VevDWV42bRU7rel5l3mZGsT72OLMJP0AyM9pSjlw0sUkxKk20n48uSp0Sq0n2uRoXY0Pr
	/5XeXM2xo/m+sGbEsUi5Vd6BAtQKRpWkS4lpRjxLKV3k+mB/tUIeqUq5LmjjrmgTowVdM9rJ
	0ko3+amLQoSCu6ZKEKIEIV7Q/nclrJN7KnL27nZ719Txsqtq6H2B0TN8NWdXpO72fM6gyH4z
	aMNeMK6/Q5MSJdque403WkVczw40uIkQ9OXC6p4j1HH95UCHc/F4Q9vqYF/c4O7Qgyd3HDb4
	exQGqwmlb5xuMgXl11tP41Svt9/DuXxFcIlydlDat2aNS5g6z8yI+dazSlqnVvl6U1qd6i8s
	lIeIuwIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool code
should use netmem descriptor and APIs instead.

As part of the work, introduce a netmem API to convert a virtual address
to a head netmem allowing the code to use it rather than the existing
API, virt_to_head_page() for struct page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/net/netmem.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index ef639b5c70ec..f05a8b008d00 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -270,6 +270,13 @@ static inline netmem_ref netmem_compound_head(netmem_ref netmem)
 	return page_to_netmem(compound_head(netmem_to_page(netmem)));
 }
 
+static inline netmem_ref virt_to_head_netmem(const void *x)
+{
+	netmem_ref netmem = virt_to_netmem(x);
+
+	return netmem_compound_head(netmem);
+}
+
 /**
  * __netmem_address - unsafely get pointer to the memory backing @netmem
  * @netmem: netmem reference to get the pointer for
-- 
2.17.1


