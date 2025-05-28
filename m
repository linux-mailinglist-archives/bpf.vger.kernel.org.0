Return-Path: <bpf+bounces-59068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D14AAC5F82
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40832188E138
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43143D544;
	Wed, 28 May 2025 02:29:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D6D1E8331;
	Wed, 28 May 2025 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399371; cv=none; b=u9nQ+BJR3OvR1gu2EpT5jzpgQFszfqVUTgNnpodTy3b0D+pQ8Jt4PV8bdiVIsXWeu5xIP75cHge1xEDH96+Si1ZhXl4a2DITqkInMStRPfydtSXBwlfVb2bNBvKaCmKiCFBGHNWLKtYIQvpEsEbY/Vb/1eosMoseNCKSoXTTnXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399371; c=relaxed/simple;
	bh=Bn+B677u1SUXBMK6hXmuHKqv5b/inDpHW5BYywKSQyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NjvCYiD6eszAwpqKZhwUFE+J4IjLKpRm4rOasBYefEhP6wPjn74OhBzO6MoqOwZhxHzwIlyzfn+ruclOUqgUHxU7qbyDqnwMnG8To+Luv08fMG0zJ0vA0Y9YULVEvRPJppvtovJWgajCEvojmpPDEhajCAGymN+QOXBHL4sU52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-91-68367502f54e
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
Subject: [PATCH v2 12/16] netmem: use _Generic to cover const casting for page_to_netmem()
Date: Wed, 28 May 2025 11:29:07 +0900
Message-Id: <20250528022911.73453-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250528022911.73453-1-byungchul@sk.com>
References: <20250528022911.73453-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRiH+++cnXMcrk5L9JRiuBBJ8YqX94OYEuX/W0FfwgodenDDOWVT
	80KgJlSadofQhVPJO82W6DQx7xcMlJmxyutEMzBFl0udZM7y28Pzg4cXXoaQ9JNnGIUqg1er
	ZEopJSJFP52r/QWZ4fKgit/uoNU3U9C0nQ1180YhaBvbEPza+UaDdWCYgpoqGwHa8SIStvS7
	BCwNWWiYq10moeteOwGWRyMUlBbZCSg01gtgoq1MCM93XxPQnj9Pw2SnloLZ5n0hLPeVkjBa
	3kDCXFk0DOlcwTa2imBA3y4A28NXFDwz6ShYLJpDYOq3kFBRUIZA320Wgn1bS0V74daGLwLc
	UT5DY50hE7+r98XFZhOBDY0PKGzYfErj6c9dFB55aSdxh9EqwKV31yi8sfSVxOvdUxTWt06R
	+KNugMZWg+dVNk4UmcQrFVm8OjAqQSTXLdbS6V1MtnE7Lx+V0MXIieHYUK5xuIc64h3T9KGn
	WB/ObN4hHOzCBnNWyzBZjEQMwa4JuSWtXeAYTrFxXMdCJelgkvXmXvS8OQyJ2XBuYfQH8S96
	lmtq6TlghnE68IPTiQ4tYcO49RI9cjQ5doPm9sdm/x90muutN5OPkViHjjUiiUKVlSpTKEMD
	5DkqRXZAYlqqAR28tvbO3g0j2py41odYBkmdxbglTC4RyrI0Oal9iGMIqYu48EK4XCJOkuXk
	8uq0eHWmktf0IXeGlLqJQ2y3kyRssiyDT+H5dF59tAoYpzP5yOtt7Gq1WXY+5lxZlac67nqe
	JmHeb6s9pmZf9MlgaXLamWze9Xj/XVByZfySG8Pf6m0LnYjIjUgJsV/MKg9l/zwRriumwqxu
	lQpbmp93YPzsXnKCyD/Q5+Rl907xUFBk63HXzYIP2zODBdaUwMiolbqWtZvKpPvy2OCJlfAT
	ix5SUiOXBfsSao3sLz/oPL7WAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRa0hTYRwG8N6ds7PjcHFcUiejglFESpqR8o/K/OZLlBpR2cB06MENndqm
	oqU0dRFpajdLbNZMMq9NTNwsb8w7CommLTXnBTWj1NRsNqFc0bcfzwPPl4cmxKWkG62ITeBU
	sbIYCSUkhYHHMw/xEn3lh1c/bAWdoYqCSlsyvJww8UFXUY9gdX1UACvtXRSUFK8RoHunJeGH
	4RcBM51TArCWzpLQeMtIwFReNwU5WjsBGaYyHrQV9fChvz6XDw9/vSDAqJkQwOAbHQXjVb/5
	MGvOIaGnsJwEa64/dOq3w1rvVwTtBiMP1u4UUfBgQE/BtNaKYKBtioQn6bkIDM0WPthtOspf
	guvKP/JwQ+EnAdbXJuLXZe44yzJA4NqK2xSuXb4vwGPDjRTuLrCTuMG0wsM5mQsU/j4zQuLF
	5iEKl3xe4mFD3RCJ+/TtgmAXqfBEJBejSOJUXn7hQrl+ulQQ30gnm2zXNShbkIWcaJY5yq4P
	jP01xRxgLZZ1wmFXxptdmeois5CQJpgFPjujs/McxTZGyjZMPiMdJpn9bH7rK8phEePLTvbM
	E/9G97KVNa2bpmmnzbxjLMIRixkfdjHbgO4ioR5tqUCuitgkpUwR4+OpjpanxCqSPSPilLVo
	873StI17JrQ6GGBGDI0kziJc4yMX82VJ6hSlGbE0IXEVZZzylYtFkbKUa5wqLkyVGMOpzWgX
	TUp2iE5f4sLFTJQsgYvmuHhO9b/l0U5uGnRlvlWrdfE0pVskcU9Fw1XVig6lsfpnaFC26uDI
	MY/z+aP7+vdQHhrp2XNzgaPJmjCxskljm1kmmsa9QoxH1PmTbF2q1Bp08kuBJnLj8qPR3sUi
	Ucv7vKs3Kr/1NdlSzzwmLqQV828GL+28GDfyVjYb+twY0uLH5UTN2Z3HA3ZLSLVc5u1OqNSy
	P6ZKak65AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The current page_to_netmem() doesn't cover const casting resulting in
trying to cast const struct page * to const netmem_ref fails.

To cover the case, change page_to_netmem() to use macro and _Generic.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 include/net/netmem.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 37d0e0e002c2..4c977512f9d7 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -172,10 +172,9 @@ static inline netmem_ref net_iov_to_netmem(struct net_iov *niov)
 	return (__force netmem_ref)((unsigned long)niov | NET_IOV);
 }
 
-static inline netmem_ref page_to_netmem(struct page *page)
-{
-	return (__force netmem_ref)page;
-}
+#define page_to_netmem(p)	(_Generic((p),			\
+	const struct page * :	(__force const netmem_ref)(p),	\
+	struct page * :		(__force netmem_ref)(p)))
 
 static inline netmem_ref alloc_netmems_node(int nid, gfp_t gfp_mask,
 		unsigned int order)
-- 
2.17.1


