Return-Path: <bpf+bounces-76587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D76CBCBB4
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 08:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25DA0301C91B
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 07:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E517B3BB48;
	Mon, 15 Dec 2025 07:10:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA87831B13B;
	Mon, 15 Dec 2025 07:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765782646; cv=none; b=Ta1KzXvUP5hzf5rl0ZKmz8FO72bxJfLfE2mkY7rhIAzgo5jD3eU42EQLfeYOG8RYvOfESjFfRc0eeoluo4BSC113ddKClxL9J5NfYIND6qcNpQpGMrSGD72zaSfgHDuGA8EFS3RMyx5vk110XrxIVV81VNscSROCz+e/b2x9RHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765782646; c=relaxed/simple;
	bh=AJTQpL0AwT5x6g1BXMDRpmEijhUtcV95YYb8dBDDX5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=G97EMDN50YkQl8k5mIyhHiRuQVy9cqsiZON3Hx3ZRGcHh5LyldugQ9R1e7m5cQQ2GtDFCXYxKLmywDrnZfSEA9Gll9dGNBB9M8ha16FKRvhdzOkHd/ej5TAkZz4ZCeh8yfqjoBfUJoPB3tolW11+dNpIeWQczKB4C1vo7u7jh8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-60-693fb470c4fe
From: Byungchul Park <byungchul@sk.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	harry.yoo@oracle.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	ilias.apalodimas@linaro.org,
	willy@infradead.org,
	brauner@kernel.org,
	kas@kernel.org,
	yuzhao@google.com,
	usamaarif642@gmail.com,
	baolin.wang@linux.alibaba.com,
	almasrymina@google.com,
	toke@redhat.com,
	asml.silence@gmail.com,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	sfr@canb.auug.org.au,
	dw@davidwei.uk,
	ap420073@gmail.com,
	dtatulea@nvidia.com
Subject: [PATCH 2/2] mm, netmem: remove the page pool members in struct page
Date: Mon, 15 Dec 2025 16:10:01 +0900
Message-Id: <20251215071001.78263-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251215071001.78263-1-byungchul@sk.com>
References: <20251215071001.78263-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfZ/nued5Om6enfBgw25oGuXHsY/NzyFfVluGf8rG0TP30K/d
	VUpjl7J+cEmJXLVdKP0iu9IvpVypw0YLOcOVKzWkiNKVX9fRf6993u/3668PS8oTJHNZMTRC
	0ISqghW0lJJ+nnZ1eXjFJnFF131vyCkrpaFkNBpudFVLwFHaR0BOcSWC747XDPypb0HwrbmV
	hk9NQwiu5Y2QkPM0gYLhsjESamr7EHzMuknD+xY7AyUmP+gs6KWgLrGKBPt5Cw36hHES6h0D
	DJyuLnSKy3UMtFWmSuDiWD4JVbouBp7V5tBgK/0jgV6znoKHhiIKvmQ2k9CZuhlajLNg5HE/
	guayKgJGzuXS8OJKLQF36l8wkNFupKE7oRNBe5OdgsyfSTRkx6UiGB91KgfSvksg+4GN2eyF
	46xWGjf1D5K4ougVgTuyLlDYeu8RgWsMbxlsNEXi8kJPnGJtJ7GpOJnGpqF0Br/pqKOxJWuc
	wjXv1uGa6m8E1scP0P4zA6Trg4RgMUrQeG88KFXrLYHhX6dHX09uJXQoRZaC3FieU/J6SyYx
	ybavPeQE05wHb7U6XOzO+fG3Kp+jFCRlSW6A4esaftATwQzOly9yDLtKFLeYv9OZ5hLJuDV8
	S+PZ/9IFfMntRlfHjVvLX3t7CU2w3NlJ/3DZJeW5RpZ//HQQ/RvM4e8XWqk0JDOiKcVILoZG
	hajEYKWXOiZUjPY6HBZiQs7fKDj5M7AaDbXtMSOORYppsraKjaJcoorSxoSYEc+SCndZktV5
	kgWpYk4ImrADmshgQWtG81hKMVu2auR4kJw7oooQjglCuKCZTAnWba4OndyxfOHqjNK4L6JH
	Ul7Yr9it5T6DG3arGUProe2taE6vJTkAHg2bdvmX7Kyw4Z7IGe2ORI/i37xO5Mz2qUuM3Q+K
	EjdpZFqDURHrVxvgFq+0+Xsr+5RH7fN3+eQSS/cH7j71spBce2ZR3r6GZZot+fufxO+9q/ZN
	7vIM2+b3vkxBadWqlZ6kRqv6C7PmDPEXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRiH+59zds4cjo5L9GRhNIvATLtovGGUUtKf6PaljC7kyEMbXtlM
	NLC0DC+1ZV7KdMaksua15t1mhTNvBYWlnEqdWdl9lZo5tWwafXt4fw/Pl1dMyoYpD7EqOo5X
	Rysi5bSEkuwKPLMqtmazanXB2cWgryqnoWwiAW4ONojAXv6eAH1pHYIx+ysGZprbEIy2ttPw
	2TKC4FrxOAn6J6kU/KyaJKGx6T2CT/kVNLxrG2KgzLQTrCXDFJjT6kkYutBBgzZ1ioRmu42B
	0w23HOHqZAYsRZ0ieFqnE0Hu5A0S6pMHGXjWpKdhoHxGBMMtWgo6C4wUfM9rJcGqC4I2gxuM
	P/qCoLWqnoDx80U09FxpIqC2uYeBnG4DDW9SrQi6LUMU5E2n01CYokMwNeFI2rLGRFD4cIAJ
	8sMpgkBjy5dvJK4xviBwb/5FCgv3ugjcWNDPYIPpOK6+5Y0zhW4Sm0ozaGwayWZwX6+Zxh35
	UxRufL0BNzaMElh7xkbvcTsg2RjOR6riebXfpjCJUttxMPbH/ITrGe1EMsqUZiInMcf6cwM/
	3pKzTLMrOEGwz7Eru5OrrHuOMpFETLI2hjPf/0XPDgvYHZzR/nNOotjlXK01i5hlKRvAtT04
	R/yLLuHKbj+Yc5zY9dy1/ktolmUOJ/vjZZSFJAY0rxS5qqLjoxSqyABfTYQyMVqV4Hs0JsqE
	HN8vSZq+2IDGnm1rQawYyZ2lwt1NKplIEa9JjGpBnJiUu0rTBcdJGq5IPMGrY46oj0fymha0
	SEzJ3aXbQ/kwGXtMEcdH8Hwsr/6/EmInj2SEf3cewoF2l3B3yphbsndC1hqS/XVZ1+N04mtQ
	O0EGp9j9mGHPkPaRrZK+e0Ej1pt3Fn446+W12axweTm4v8QWuuXg0uCcNOXtCu2+w8Y/b3WV
	XtosF2cf/y2CxMNnRcLulevWKh9dTYn3jDAzzhZ78cnthZPSiVO6K/onSVGUQU5plIo13qRa
	o/gLKI2TbfkCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Now that all the users of the page pool members in struct page have been
gone, the members can be removed from struct page.

However, since both struct netmem_desc and struct page still share the
same space, the important offsets should be checked properly, until
struct netmem_desc has its own instance from slab.

Remove the page pool members in struct page and adjust static checkers
for the offsets.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm_types.h | 11 -----------
 include/net/netmem.h     |  7 ++-----
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 9f6de068295d3..46d3c4b52cc10 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -114,17 +114,6 @@ struct page {
 			 */
 			unsigned long private;
 		};
-		struct {	/* page_pool used by netstack */
-			/**
-			 * @pp_magic: magic value to avoid recycling non
-			 * page_pool allocated pages.
-			 */
-			unsigned long pp_magic;
-			struct page_pool *pp;
-			unsigned long _pp_mapping_pad;
-			unsigned long dma_addr;
-			atomic_long_t pp_ref_count;
-		};
 		struct {	/* Tail pages of compound page */
 			unsigned long compound_head;	/* Bit zero is set */
 		};
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 2a73b68f16b15..01d689de11511 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -42,11 +42,8 @@ struct netmem_desc {
 	static_assert(offsetof(struct page, pg) == \
 		      offsetof(struct netmem_desc, desc))
 NETMEM_DESC_ASSERT_OFFSET(flags, _flags);
-NETMEM_DESC_ASSERT_OFFSET(pp_magic, pp_magic);
-NETMEM_DESC_ASSERT_OFFSET(pp, pp);
-NETMEM_DESC_ASSERT_OFFSET(_pp_mapping_pad, _pp_mapping_pad);
-NETMEM_DESC_ASSERT_OFFSET(dma_addr, dma_addr);
-NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
+NETMEM_DESC_ASSERT_OFFSET(lru, pp_magic);
+NETMEM_DESC_ASSERT_OFFSET(mapping, _pp_mapping_pad);
 #undef NETMEM_DESC_ASSERT_OFFSET
 
 /*
-- 
2.17.1


