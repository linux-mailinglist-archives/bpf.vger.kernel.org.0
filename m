Return-Path: <bpf+bounces-59238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BF9AC761E
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C687B3BDE
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3DA2512DD;
	Thu, 29 May 2025 03:11:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883DC20C47C;
	Thu, 29 May 2025 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488270; cv=none; b=D3Y/1yyUbF5QiElukU1EXSBpQ6r0Eqi6iQoh0N5KXuGCPMP28huoO8u88KV8bIAAqAvTUBc8hnOB1etUp2ukuYZabprji4EI9+xyeHee5W3379Wzn5j5lRCCxuKzU5KaiJUKM7N18NC7JRvlFQV3L6P9x0y1xG+693r9KEFkLd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488270; c=relaxed/simple;
	bh=kkPE9UXKMI1gEtf4kZgWa5jKNdnrxzdfhemlGA9uhco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uCoLdMKyyZ4nWROXTlpxG6yD67+L+vMfupkpt6ps2xEvKKwfClNqMFozoJbUa0mE1jgUQ5miKF+g5OC8Ge+OnUgIutwZvhQ7kmvtWDUENAXcv/wSSvuYZJATrNv7kpztOD01TiVlDPTXx08ImhmGvVWE8hqm2zADopGMlLMnJSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-eb-6837d041409d
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
Subject: [RFC v3 04/18] page_pool: rename __page_pool_alloc_page_order() to __page_pool_alloc_netmem_order()
Date: Thu, 29 May 2025 12:10:33 +0900
Message-Id: <20250529031047.7587-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529031047.7587-1-byungchul@sk.com>
References: <20250529031047.7587-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG+++cnXNcjk5L6mhQOLBISFtYvh/MRAr+1YeCCroQtdypLedW
	U+eFCrOFJU6lREwnzELzVospOkOcl5WXooZlLLO8oSCmosupzTIv+O3H87zP78vLEBIHGcCo
	NAm8TiNXSykRKZrwLdkb7QxX7rPnMGCyVFNQNZ8MLwZsQjBV1iH4vfCdBrejnYLnJR4CTJ8M
	JMxa/hAw8m6Ihv6yURIaM+oJGMrpoMBo8BKQbisXgLMuWwh5f0oJqE8boOHzGxMFP6uXhDDa
	aiShs7CChP7sKHhn3gqe978QOCz1AvBkFVPwpNtMwbChH0F32xAJRfeyEViaXELwzpuoqEBc
	W/FNgBsKf9DYbE3ENeXBONPVTWBr5SMKW2ce07jvayOFOwq8JG6wuQXYeH+SwtMjvSSeauqh
	sKW2h8QfzA4au607TrEXRBEKXq3S87rQyCsi5eC/V/TNDFGyveUenYZeMZnIh+HYMG7aOIfW
	+ft47ipT7G7O5VogVtiPlXHuoXYyE4kYgp0UciMmr2Cl2MKqudG/Y8sDhiHZIO5lnmYlFi97
	BkuHBWvOnVzV6+ZVjw97gMuvyV/NJcs3TzNbqBUnx87SXNvSlHBt4M+1lLvIXCQ2ow2VSKLS
	6OPkKnVYiDJFo0oOidHGWdHyb8vuLF60oRnn6VbEMkjqK+5A4UqJUK6PT4lrRRxDSP3E6YcP
	KiVihTwllddpL+sS1Xx8K9rOkNJt4v2eJIWEvS5P4GN5/iavW28FjE9AGjraNO4oKArU76qO
	fRY2AZbzoefsJw9oPtoMzbLji+NHejdNBHYm+V0KmiqO7doTrQwf7n9YlRfRdVB6e6zUPuBa
	wHcj+45LT7A+V7OkX0Y2Pr6InbfO+Osji8dStcQNmf2QFrY9mEuusMd42t6WKI492TxXSJYp
	zm5Bi+7Za51SMl4plwUTunj5f8WmAwjXAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRfyyUcRzH+z7Pc8/zuHXb02V6dv2hXWvMSqzw2bLiL8/8IWs21tZ0eNbd
	3B27Q7Qyv0oZkkQ4OslvuXaMU6Yc40hjLiIKZ241TcVlfqXQ+u+994/XP28aF9cRElqhTuA1
	aplSSgoJYci5zFOBo35yL7PJF3SGZhKa1pOhbs4kAF1jOwLHxjQFq30DJFRXreGgG8ki4Jdh
	E4fFfhsFs7V2ArqyO3Cw3beQkJe1hUOGqR6D3opBAYy25wugaLMGh460OQqsL3UkfG7+IwC7
	OY+AwbIGAmbzA6Bf7wJrb78h6DN0YLCWW0HCwzE9CQtZswjGem0ElKfnIzB0Twpga11HBki5
	toYpjOss+0RxemMi11rvweVMjuGcsfEeyRlXCiluZqKL5CyPtwiu07SKcXmZyyT3c/EjwX3v
	Hie56i8/MM7QNk5ww/o+KvTQZaF/DK9UJPGa0+evCuXzOy1UfLYw+XVPOpWGWugc5ESzzFl2
	eqkA7WmScWMnJzfwPe3MeLOrtgEiBwlpnFkWsIu6LWwvOMwoWfvvr7sDmiaYE+zzIvWeLdrl
	zNcsYP+YrmzTizf7HCfGhy1uLd73xbud0pwesgAJ9ehAI3JWqJNUMoXSx1MbK09RK5I9o+NU
	RrR7X+2t7Qcm5LAGmRFDI+lBkQX5ycUCWZI2RWVGLI1LnUUZF3zlYlGMLOUGr4mL1CQqea0Z
	HaUJ6RFRcDh/VcxckyXwsTwfz2v+pxjtJElD5VKVS8md4w6bf9yKW/Rmbkfl+Af3iRm+9Mmg
	6qn5ZMmQRCnZCLveNXJp0/Eu2gruFsp/dQoLiwwMynTNCl9uGL7yKPDZ0PbOUIDhlWDRfjtE
	rVmPvRvVcLM3+FjkxdTQVKIkqirwzPslY6g938uvsr7QGkFLSi0R7bT76I5FSmjlMm8PXKOV
	/QVTe/04ugIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Now that __page_pool_alloc_page_order() uses netmem alloc/put APIs, not
page alloc/put APIs, rename it to __page_pool_alloc_netmem_order() to
reflect what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 net/core/page_pool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index e101c39d65c7..a44acdb16a9a 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -518,8 +518,8 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t g
 	return false;
 }
 
-static netmem_ref __page_pool_alloc_page_order(struct page_pool *pool,
-					       gfp_t gfp)
+static netmem_ref __page_pool_alloc_netmem_order(struct page_pool *pool,
+						 gfp_t gfp)
 {
 	netmem_ref netmem;
 
@@ -555,7 +555,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 
 	/* Don't support bulk alloc for high-order pages */
 	if (unlikely(pp_order))
-		return __page_pool_alloc_page_order(pool, gfp);
+		return __page_pool_alloc_netmem_order(pool, gfp);
 
 	/* Unnecessary as alloc cache is empty, but guarantees zero count */
 	if (unlikely(pool->alloc.count > 0))
-- 
2.17.1


