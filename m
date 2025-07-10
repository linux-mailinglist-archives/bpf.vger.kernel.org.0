Return-Path: <bpf+bounces-62896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FD6AFFC4D
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 10:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7D51C85C3A
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 08:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A01D29291F;
	Thu, 10 Jul 2025 08:28:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4398928C5D8;
	Thu, 10 Jul 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136110; cv=none; b=sDvGyYTSJHedtUPXY/1LmofkfE1TFWXqUfCeDeoh/0P5XGgCY0WoiLlNVHTYIlao96mVfjbLOpRmwZdYpp3/LsK1TJeTavRv6uUcQeRHfNnjmCj94Aqz9F6aWobsQHrjH31vSUlGSzr9jHxgO44nX+iPvBFn7nXsf/r3zvM1bNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136110; c=relaxed/simple;
	bh=v+EOdT63+5v3lSxwjvwFwvUYHefYLtoZ56NCZdM9eiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=X9Qjkm/3684N+W3Loqa8E7v6PPDvOaSMF61PLUnVoiq0XSr6dHHqACC3kO6Vryb6OXMZzUJa+Lz960XHBDztGIEiS6cQ15lqKdSxOiGmnVDKBY5+kdbsNJHtrhB6/5aJdtpeex2BE6fZyTGNpm0LfPHhPQBai++FT74H2r3/b0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-f6-686f79a1e3f4
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
Subject: [PATCH net-next v9 4/8] netmem: use netmem_desc instead of page to access ->pp in __netmem_get_pp()
Date: Thu, 10 Jul 2025 17:28:03 +0900
Message-Id: <20250710082807.27402-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250710082807.27402-1-byungchul@sk.com>
References: <20250710082807.27402-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG+++cnXNcLk5T6mRRMrSLdDMsfnanD/LvQxAVFRbUyINbzc22
	aa6IVinRyBUZYblkFprzwnJd3Ey7OHWGkbpYzFbNJgaFGqmt6cpyRd9e3vfh+fIyhKSXTGAU
	Kh2vUcmUUkpEioZjb6+o0Kvlqxt614PZVkdBbbgA7vY7hGCueYRgfMJPw1ibm4I7FSECzN2F
	JHy3TRIw2BGkoda+AwJVn0hovtBIQPByJwXFhRECWiZGaDjnqBZAzyOTEK5NVhLQaOin4XWT
	mYIPdb+F8Km1mIQXN60kBExbocMyB0JdQwjabI0CCF26RUGJx0LBQGEAgccVJKHsrAmB7YlP
	CJHwtKOs/QO9NQm7hr4S+IG1T4CdN9/T2GLPw/erU7DR5yGwveYihe2jV2n87k0zhTtLIyR2
	OsYEuPj8CIW/Db4l8dcnXgrbHnhJ/NLSRu+cnSnamMUrFfm8ZtXmwyJ5fdcvIreSLuga32ZA
	lygjimE4No2rHx8S/s+1pggdzRS7hPP5JohojmdTubGgmzQiEUOw9RTXVuf/C8WxSm5q3Dw9
	MAzJJnM+V2a0FrNrOU/ARPxzLuJq7z0jokgMu45zDJyK1pJpJOI1/lVybBHDlfY70T9+Hve8
	2kdeQWILmlGDJApVfo5MoUxbKderFAUrj6hz7Gj66KrTPw840GjP7lbEMkgaK+7JVsklQlm+
	Vp/TijiGkMaLw/uVcok4S6Y/yWvUhzR5Sl7biuYzpHSueE3oRJaEzZbp+GM8n8tr/q8CJibB
	gJZXhjLijxyP/HiV/jglNGU9c5+x4gv6pVZHUVXJvr26xIOWxTu5cp9f6VnWUqNr+rz9y0x3
	uuWLO1zWmLuliTq5IeNGeQO3Kykx/HHBw+G48/vvXXcW9fUvDKiWONMqB+YZ2slwccnsTakL
	Z6lt3uSn3a7qstBh155jR7N7m1v8UlIrl6WmEBqt7A/CEqOx5AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG+++cnXMczg5r1EHBYKCBliVo/MoSqaBDUGkEhl9y5MEtj1M2
	NS9EpkJmOrshpTOmonllMW+z1EzNS35IZrPlbaIooaaZc6gzzRV9e3neh/fLS2GSRtyTUqqS
	OLVKzssIES66EpJ9rCwtQXHiXfNR0BnqCajbSIXX0yYh6GpbENg3x0lY6+0noKLMgYHucw4O
	64YtDOb6ZkioM14GW9U8Du0PWjGYKRwgoCDHiUHH5jIJWaZqAfSUDgphuEUrhOdblRi0Zk6T
	MPJWR8BU/a4Q5rsLcBgsrsHBpg2DPv1BcAwtIeg1tArAkV9KwDOznoDZHBsCc88MDiX3tQgM
	nVYhODf2Nko+TpFhPmzP0grGNtV8E7BtxZMkqzcms43Vfmye1YyxxtqHBGv89ZRkJ0bbCXbg
	hRNn20xrArYge5lgV+fGcHal00KwFd9/ClhDkwUPl0SJzsRwvDKFUx8PjRYpGoZ+Y4mVZOqQ
	/VwmyifykBvF0EFMndZJujJBH2Gs1k3MlaV0ILM204/nIRGF0Q0E01s//lc6QPPMjl23V1AU
	Tvsw1p4oFxbTwYzZpsX+bR5m6t50YS7FjT7JmGYzXFiypzgtefhjJNKjfbVIqlSlxMuVfHCA
	Jk6RplKmBtxKiDeivSur7m4/MSH7yMVuRFNI5i4ejlUpJEJ5iiYtvhsxFCaTijdu8AqJOEae
	ls6pE26qk3lO0428KFx2SHwpkouW0LHyJC6O4xI59f9WQLl5ZqKr7l0yXZ/M/GjWdnvsusfC
	eemXVYspY6wiu6+ooXBx557pVFj60ujuYhbq6PcNm77jX1s2scJn6LH33tnp5b77L3SG70R8
	WK/xc7yiOv1CeP6rs8gr3bg6mZRYGuERWbqdf1pxbdc992XQj1BL7llRuTa0dcvb/5Njo3kh
	0lwgwzUKeaAfptbI/wBxH1YqxgIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of the page pool fields in struct page, the page
pool code should use netmem descriptor and APIs instead.

However, __netmem_get_pp() still accesses ->pp via struct page.  So
change it to use struct netmem_desc instead, since ->pp no longer will
be available in struct page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/net/netmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 11e9de45efcb..283b4a997fbc 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -306,7 +306,7 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
  */
 static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
 {
-	return __netmem_to_page(netmem)->pp;
+	return __netmem_to_nmdesc(netmem)->pp;
 }
 
 static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
-- 
2.17.1


