Return-Path: <bpf+bounces-58800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A94AC1A71
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 05:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E8B77B0FF4
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 03:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7F22248BD;
	Fri, 23 May 2025 03:26:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53E4220F20;
	Fri, 23 May 2025 03:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970787; cv=none; b=FB+9vP68Z18W7WUhJBq+EfNXP0deGJ5GS32awZSYGBhb7fCbaJDlhODHwo5WZqpHShFnzsSHIAWI4eeGl86Eqci4U3ZfA4f/CL82TwgUVyP9CAotb0GDV/ukcSVqAPJA/UEcnTh7XuicBstw0kyNJinu+HBRXeZ80LTexDqaQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970787; c=relaxed/simple;
	bh=OVeFBdEE2mdYFHAdWNbinXlUmid1uv560ErFLaRx+/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Vq8ZuJXzdw3kSpKa2roGZOX5OXqXVHTemRDeaClIJcXhOcCO/giNXC2CNI6DfkFNTFv1Cxxq82XDkHIGdftYe/jUFFdRQ4Mt3X1ebTlgOnhpzbDAJBmgIiu4coG9ptuelfjUjrDFyUexUZLrBzC5zU1NdRZTggSSijVrl5UzYxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-80-682feadbfceb
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
Subject: [PATCH 02/18] netmem: introduce netmem alloc APIs to wrap page alloc APIs
Date: Fri, 23 May 2025 12:25:53 +0900
Message-Id: <20250523032609.16334-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250523032609.16334-1-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRjHe3fenXO2XB2W1cmoaGCB5Lxg8QYhYiTvl0gUpPKDLT254ZV5
	yRWBqRGJUzMz0ZnLyDvN5tJ5QWqtaXRR5oXl7ZimoZjhNW9RzvDb73n+z/P78qcJqRW60ar4
	ZE4dr4iVkWIo/ulS4Tk846X0fmkQIp2hnkR1q2moasy8NdU2AbS0NkShRWsniZ4/WyGQrjsL
	omXDOoEmbeMU4iunIGq/30yg8bwuEmmzNgiUYa4WoJ6mXCEqXH9BoOb0MQr1tupINFr/V4im
	LFqIPpTUQMTnBiCb/gBa+TgLkNXQLEArOWUkemTXk2giiwfI/m4cotK7uQAZOhxCtLGqIwOO
	Y1PNVwFuKRmhsN6YghurPXC2w05gY+0DEhsXCig8PNBO4q7iDYhbzIsCrM2cI/H85CDEvzr6
	SWww9UP8SW+l8KLxaDBzVXwuiotVpXJqL/9rYqWplKcSX4vS9CUDRDqYpLKBiGYZPzZziAc7
	PL05RTiZZE6yDsfaNrsyPuzieCfMBmKaYOaE7KRuQ+AM9jEhbNuIXehkyLizRU/zt/Y0LWFO
	s7r5uP/OY2xdw5ttj4g5w+aPLpNOlm6dtPUNUk4ny8xTbNVIo+D/wyH2bbUD5gOJHuyqBVJV
	fGqcQhXrJ1dq4lVp8siEOCPY6rbyzma4GSz0hFoAQwOZi8Qs9lJKhYrUJE2cBbA0IXOVvJ+S
	K6WSKIXmFqdOiFCnxHJJFnCYhrKDEt+Vm1FSJlqRzMVwXCKn3kkFtMgtHZTJbbbP7uGdI9+O
	3L6+3ybCoRd9Hxf3zPj0fjkPc58UeUdMNPOXF2anNfqgeV7826S1Rl8oD867VBp2T+xZFQI9
	lwvmcgKbmgIsCa/qv0fv+dEtB90J5Q0nKvwb9i4t776hPlXZFaiJcQTNtoYNmkUPC6f5P9qz
	rul2/kpkX4YMJikVPh6EOknxDznkrCHXAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG+5+7q8HpZHYwIhiEFeRSUn6klgXlnz6UVBQFUUNPbeqmbSpa
	BprS0NTsSuiUlaTmpNUyLylSal4q0+aF5W2izLLELtbwRqVG3x7e9+X58nKkUEp5cxpdvKTX
	qWIUjIySHQxK3zbwWane/rooAEzWCgYsM0lQOlJDg6m8CsHP2QEWpptbGSi+5ybB1JlBwS/r
	HAmullEWnCXjFNQbq0kYvdbGQE7GPAmXa8oIaCpsp6GrKpeGW3MPSKhOHWGh+7mJgeGKPzSM
	N+ZQ0J7/kAJnbii0mL3A/WYSQbO1mgB3diEDN+1mBsYynAjsTaMUFKTlIrA2OGiYnzExoQpc
	+fADgWvzh1hstiXgp2VbcZbDTmJbeSaDbT9usHiwr57BbXfnKVxbM03gnPQpBn939VP4a0Mv
	g4s/fSOwtbKXwm/NzWz46pOy4EgpRpMo6ZW7zsjUlQVONu6ZR5I5v49MRS42C3lwIr9DnFgY
	J5eY4X1Eh2N2mT15P3F6tJXKQjKO5Kdo0WWaJ5aKNfxhsW7ITi8xxW8S7xTlLeYcJ+cDRNN3
	7T/nRtHy+MWyx4MPFPOGfzFLLCxO6nr62TwkM6MV5chTo0vUqjQxAb6GaHWyTpPkGxGrtaHF
	+0ouLVyvQT+7wxoRzyHFKvlmrVIt0KpEQ7K2EYkcqfCUvxr3VQvySFXyBUkfe1qfECMZGtF6
	jlKskx84Lp0R+HOqeClakuIk/f+W4Dy8U5EhSijbEtZyrOOlpafFOXjFf9+RzCcV93UdFvps
	2n5svHjKJ7NY0IdUtQcbLcVgo+xDcVffPRIm3hcRxgVjaspa14mITnfE+Q6/lN1jYx3ulWPZ
	vl6TaSGPujLrfgimcP8q5YZDhYFzihV7Pu4Nyo5SOoxRYfjozt+14cSX6tsKyqBW+W0l9QbV
	X/liCwm6AgAA
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
 include/net/netmem.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 08e9d76cdf14..29c005d70c4f 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -177,6 +177,19 @@ static inline netmem_ref page_to_netmem(struct page *page)
 	return (__force netmem_ref)page;
 }
 
+static inline netmem_ref alloc_netmems_node(int nid, gfp_t gfp_mask,
+		unsigned int order)
+{
+	return page_to_netmem(alloc_pages_node(nid, gfp_mask, order));
+}
+
+static inline unsigned long alloc_netmems_bulk_node(gfp_t gfp, int nid,
+		unsigned long nr_netmems, netmem_ref *netmem_array)
+{
+	return alloc_pages_bulk_node(gfp, nid, nr_netmems,
+			(struct page **)netmem_array);
+}
+
 /**
  * virt_to_netmem - convert virtual memory pointer to a netmem reference
  * @data: host memory pointer to convert
-- 
2.17.1


