Return-Path: <bpf+bounces-62070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 938AFAF0AE2
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 07:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FC44E04F6
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1133E2192EC;
	Wed,  2 Jul 2025 05:48:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851F5205AA1;
	Wed,  2 Jul 2025 05:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751435306; cv=none; b=t7aIlfxu/cQHMVRPdOdMBjznv4v7owL/76A7rFgdVgDEbCvmDP0Xs0PK+slZF8TNOwG+mrQ6eb6BTyUka6PCgY/91yxA8V5CCQy0Weho61oEgG04oyKf9/j3qdeVVaeuH9Pf9hsGCaPIs8+Gq+9EAmdbdtMm7EFN7/zyDvWmTik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751435306; c=relaxed/simple;
	bh=wxnk9r+FyNg9hdx1j0MPOL3cgbkx04c6ngCe03TSGvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=se+BB9M6G7sD5Mbkr1kBvWYhsFlcKgf67OCsE/18fvN1mOxkL78aSdN4Bx2QxpEjYmtAgo+DMW1Hi1gP56DcPIYukZ3cNLV0IYsY5lyYNx8Ezy42sAB3Ci2RSC2vN4/7efaSbbaoZ2Bl8z6qj163fhx80n0coBHL1frUaMrvtak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-29-6864c492da24
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
Subject: [PATCH net-next v8 4/5] netmem: use _Generic to cover const casting for page_to_netmem()
Date: Wed,  2 Jul 2025 14:32:55 +0900
Message-Id: <20250702053256.4594-5-byungchul@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e9/ds5xtTgtq9NFolEYiqVl8gYV9iE6HwosiUQ/5Mmd2nCa
	zUsaVN6gGmliQTkt1s3mJafzNrvMmksnRollzExXy4zwVlkrs7JtEvXt4Xmf3/O+H14ay0rE
	S2lVcpqgSebVclJCSMbmXgsptimUoRV3N0OZsZqEqu+ZcOu1WQxllU0Ivkz1UzBp6yDh+lU3
	hrKn+QR8Nf7A8K7dRUGVaRc4y4cJuHeqGYPrnJ2EgvxpDPenxinINRtE0N1UKIYLP25iaM5+
	TcGzO2UkDFbPiGHYWkBAp66CAGdhJLTrF4G7axSBzdgsAvfZyySc79GT8DbfiaCnzUVAaU4h
	AqPFIYbp756O0keDVOQqrm10AnMNFX0irkU3QHF6UzpXbwjitI4ezJkqz5Cc6XMxxb16cY/k
	7JemCa7FPCniCvLGSe7Tu5cEN2HpJTljQy/BPdbbqKj5sZLNCkGtyhA067bGS5TjRd+olOt+
	mWM3ckXZaJjSIj+aZcLZ1qEmUoton3a9l3ltkglkHY4p7NX+TBg76eogtEhCY+Y2ydqq+33s
	AoZnG3SVvhDBrGbzSop8WurtrGtDs/0r2KraBz7fj9nIWtrtpFfLPJm3p23kbH4+21kyRHhv
	wJ7Fxiu+G7AHzWssxd69LGOm2RqXVjzbuYR9aHAQRYjR/Yfr/uG6/3A9wpVIpkrOSOJV6vC1
	yqxkVebahMNJJuR5mPLjP+PM6HN3tBUxNJLPldqfJyhlYj4jNSvJilgay/2l8wI8llTBZx0T
	NIf3a9LVQqoVLaMJ+WLpevdRhYw5xKcJiYKQImj+TkW039JsdMJpH9mw8knAxqPP3oiCd5/u
	W/5RGxEfc8LoosyN7ti0mIuJ4XtjB4JLCvKaJy07ww7+Pja1JipHEj1jIPYFZ81pjXR+Gh0Z
	Sltcx1/yF4+s0z79uKnry/acqL6TiYEhC+s3xV1RHLhv+dC4hT0ycDu0iN9RO/Arongbzq2J
	3tOq/iYnUpV8WBDWpPJ/ALvX9TksAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTcRTG/e9/d+91NLsu04sV0kDKQktKOJSYfepPkZR9CBPSldc2mis2
	FV8o1AnWSDPrQ22rLM33sVq+hpnNZUr0glJZmspMMzItLVNn1GZEfXt4zu885/lwWCxzUYGs
	SpMqaDUKtZyWUJKY7frQEkeScvOzxjAwW+toqJ3LgMrhZjGYaxoRfJvvZ2DG8ZiGshuzGMzP
	8yn4bl3AMNrpZKDWtheGKsYoaC1owuA830VDYb4Lw/35SQbymqtE0HG1WwwvGovEcGnhFoam
	nGEGeu+ZaRis+yWGMXshBd3GagqGiqKhs9QfZp9MIHBYm0Qwe+4qDRd7SmkYyR9C0NPhpMCU
	W4TA2tYnBtecO8P0aJCJDiYdE1OY1Fe/EZEW4zuGlNrSyN2qDcTQ14OJreYsTWzTJQwZeNVK
	k67LLoq0NM+ISKF+kiZfR99SZKrtJU3Kxr+IiLX+JbVPdkgSmSSoVemCdlNUokQ5WfyDOVnm
	nfG5PE+Ug8YYA2JZntvKOz/IDMibpbl1fF/fPPZoPy6cn3E+pgxIwmLOQvOOun7GM1jBKfh6
	Y80SRHHBvP5K8ZKWunMe3OlAHs1zQXzt7fYl35uL4Ns6u2iPlrmZkTMO+g/vy3dfeU95OmD3
	Yeu1pQ7YvapvMOFiJDX+Rxn/Ucb/qFKEa5CfSpOeolCpI8J0x5WZGlVG2NETKTbkfomKU4sX
	mtG33l12xLFIvkza/vSoUiZWpOsyU+yIZ7HcT+qzxm1JkxSZWYL2RII2TS3o7GgVS8kDpLsP
	Coky7pgiVTguCCcF7d+piPUOzEHcNF57eEvykZaRvOTFqtepAQ9bPq2OGzBZVi1WfKxMzA4d
	t6zM9lqtCQq/FHP6Z2TkHl2INNrfFmmfSdi4LXj5+vz4obexqZaI4E2/ekIMDSsyv5sP7DBR
	rJe60jdoZ+6beK9l70oi4qY7B/yX7y8PCb/pKiCvfWIbo/wtszjrul5O6ZSK8A1Yq1P8BkzG
	uQIOAwAA
X-CFilter-Loop: Reflected

The current page_to_netmem() doesn't cover const casting resulting in
trying to cast const struct page * to const netmem_ref fails.

To cover the case, change page_to_netmem() to use macro and _Generic.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netmem.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 7a1dafa3f080..de1d95f04076 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -139,10 +139,9 @@ static inline netmem_ref net_iov_to_netmem(struct net_iov *niov)
 	return (__force netmem_ref)((unsigned long)niov | NET_IOV);
 }
 
-static inline netmem_ref page_to_netmem(const struct page *page)
-{
-	return (__force netmem_ref)page;
-}
+#define page_to_netmem(p)	(_Generic((p),			\
+	const struct page * :	(__force const netmem_ref)(p),	\
+	struct page * :		(__force netmem_ref)(p)))
 
 /**
  * virt_to_netmem - convert virtual memory pointer to a netmem reference
-- 
2.17.1


