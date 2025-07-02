Return-Path: <bpf+bounces-62074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F6BAF0AF0
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 07:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADCA716896F
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA020223DCC;
	Wed,  2 Jul 2025 05:48:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A895020CCCC;
	Wed,  2 Jul 2025 05:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751435307; cv=none; b=V9aSeOdZA+c2JxOI/4HwjeeiBH8/bVhL6fgQC/3l1SECd8HVsa/CBZZypWejHFbGX3PlNcB7Ywug/xSlr2cVYZwpQsQ8mV0Gq6Nr/abnBhEvd5KZeBTcxoKm7M/+Ou4CoJqUU1hftI6VAqlMpw0eVQq3T0KN70NsElvttZoSNKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751435307; c=relaxed/simple;
	bh=OX7su+A2+XxOGEYJv11FdVH8w8M7m/9/3b1Kym7xqMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/t/+RKNSu6Aj+HsUR8uzUh+7TlH87WDH+m4Ey4ShQAQHjI9EXIP9t5+4nNtxL6v8ATN3VO3FtouKYSfNDlNojznS+45LI6VhznIAuUVqN2fzMzSGWqqLNbC+8yTVE+YRP7SI6tO7A4jqEE7odcz8/NuONxTE8Xn88KEPV84lqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-34-6864c492dad2
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
Subject: [PATCH net-next v8 5/5] page_pool: make page_pool_get_dma_addr() just wrap page_pool_get_dma_addr_netmem()
Date: Wed,  2 Jul 2025 14:32:56 +0900
Message-Id: <20250702053256.4594-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250702053256.4594-1-byungchul@sk.com>
References: <20250702053256.4594-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW0hTcRzH+Z9zds5xtDieok5GBKuQJM3K4FeUCfVwHhS6UuRDDXdqo6lr
	M9MiWGWZ4iw0oV2qVVi2Kct5m7ak5vIeiWUtzUvL6iErUxteytoUybcPv9/v+/m+/GicNYjC
	aGVKmqBJkamkpJgQf1twN7LQI1dE57TQYLaXkmAbz4AHA04RmK3VCMYmeigY9TSRcO+OHwfz
	yywCftkncfjU6KPA5kiA/vufCXBl1+Dgu9pMgj5rCocnE98puOAswaCjOl8E1yeLcajRDVDw
	qs5MQl/pXxF8dusJaDE+JKA/Pw4aLUvA3zaEwGOvwcCfd5OEwk4LCR+z+hF0NvgIMJ3PR2Cv
	94pgajzgMD3vo+JW8w1DP3C+8uE7jK819lK8xXGKryiJ4HO9nTjvsOaQvGOkgOLfv3GRfPON
	KYKvdY5ivP7id5L/+amb4H/Ud5G8vbKL4NstHmp36GHxNrmgUqYLmvWxR8UK0/BbTJ0vznBP
	gw710rkohOaYGO6d7TyaY7P+MR5kkgnnvN6JGV7MbOBGfU1ELhLTOFNGcp7SHiq4WMRouffF
	rpkwwazhely3sSBLAqK2r3WiWelKzvbo6YwohNnM1Tc2k0FmAzcfr3jI2ftQrsUwGCigAwXh
	nP0WGxzjgejFKhMe7OWYSporLL5LzjqXcc9KvMQ1xBjnxY3/48Z5cQvCrYhVpqQny5SqmChF
	ZooyIyopNdmBAg9z/9zvRCca6djnRgyNpAskza+TFKxIlq7NTHYjjsaliyULVwRGErks84yg
	ST2iOaUStG60nCakSyUb/aflLHNcliacEAS1oJnbYnRImA5d6d55tk19UsAiX2Pscuuk6tcW
	dXjBk3XHbg+PXXbmTBY82tulLGAPRKg2NURuT0hrX8tkt1vL7qBdLQfL6RUfiv5khprVt5Kq
	WltRrEERHRPfMbgj8YvO0BvWdHP4ktcSLS86urU0yaIYQvvFg9Wu0elDq154hk6Xx7sqdHl7
	pIRWIdsQgWu0sn9PaqIwLAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTcRSH+997d3cdLW43qYsV0aIXtDdD6ZQRUkQXoahPgYQ52qUt57St
	yQwCS6GStsoMcpu1Ek2dsVq1admKbfmCmGFUW1bWUulFNp1tadrLpkR9e/id5/zOl0PhzCSR
	RClUR3m1SqqUkCJCtDujdE2FVyZf7x9IA7OtiQTruA5uvG8WgLnRgeDbRJ8QxrztJNRci+Jg
	7ikjIGL7gcNgW0AIVvsu6K8bIqD1lBOHwLkOEvRlkzg8nAgK4WRzPQae6k4BPHMYBFD5oxYH
	Z8l7ITy/bybhXdNvAQy59QR0GhsI6DdkQptlPkS7hhF4bU4MomerSbjYayHhY1k/gl5PgADT
	CQMCm8sngMnxWIfpyTth5nLOMxzCubsNfoxrMb4Vcha7lrtTn8yV+3pxzt54huTs4Qoh9+Zl
	K8l1XJ4kuJbmMYzTlwZJbnTwNcGFXC9IrubTCMbZ7r4g9jDZoi0yXqko4tXrtuaK5KaRV1ih
	QaRz/4IS9JYqRwkUS6exZv0DPM4kvZL1+SamOZFOZccC7UQ5ElE4fZNkvU19wvhgHq1h39S2
	ojgT9HK2r/UqFmdxrKjr633BTOkS1nrr8XRRAp3Outo6yDgzMefjaS85489lO6sGYgeo2IGV
	rO0KE4/x2GrpPRN+HomN/1nGf5bxP8uC8EaUqFAV5UsVyvS1mjx5sUqhW3uwIN+OYi9Rd3zq
	QjP69nynG9EUkswWP+4+KGcE0iJNcb4bsRQuSRTPWRyLxDJp8TFeXXBArVXyGjdaSBGSBeKs
	fXwuQx+SHuXzeL6QV/+dYlRCUgl6pB0KV34J9Uf9VRH/Jp236PqFaHCvuWVDm4kZBU/2eO3n
	nMP1Gfe6rYu2jzA+hc7p9zZtjGQVTmVNpB9ybUthVs8KHpHv+PmhSutISVtlkF0PDUoylhna
	n1YEwo7zytt5338u3Zwy66KVUadGLKtOXerpDO1PzlkhkN0Kw6CE0Milqcm4WiP9A08AsP0O
	AwAA
X-CFilter-Loop: Reflected

The page pool members in struct page cannot be removed unless it's not
allowed to access any of them via struct page.

Do not access 'page->dma_addr' directly in page_pool_get_dma_addr() but
just wrap page_pool_get_dma_addr_netmem() safely.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/page_pool/helpers.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 773fc65780b5..db180626be06 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -444,12 +444,7 @@ static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
  */
 static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
 {
-	dma_addr_t ret = page->dma_addr;
-
-	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
-		ret <<= PAGE_SHIFT;
-
-	return ret;
+	return page_pool_get_dma_addr_netmem(page_to_netmem(page));
 }
 
 static inline void __page_pool_dma_sync_for_cpu(const struct page_pool *pool,
-- 
2.17.1


