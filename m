Return-Path: <bpf+bounces-61145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CB6AE1227
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 06:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1225C4A06D2
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 04:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CFD204096;
	Fri, 20 Jun 2025 04:12:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ADB1DC1AB;
	Fri, 20 Jun 2025 04:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750392758; cv=none; b=Yn3XnkR1O9REuQTxPFUxSvEANI6cfVIcalJ7uzUsDWNquMG/e/pQgHOaHWyS1cv/uB6/SfOiDxxTKlgEOt/BXtQnt6T/pZPXPsQTpcRzldKhfsrrMd/l6qdouAp/Y95+1lHuMYuwocQ4qOjTRUMFmWdHf3FMrZUolPCevkaYL3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750392758; c=relaxed/simple;
	bh=5wmAbXkvBz9wa/ZdobtkB+f94h+QeIjLFQaRf9o9B5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XASWeslA+NbGU2k2b8mnrMRZaCmYewCNX/7b1ec2x1ViWn72zm21lsJu/vY8SwSERGHmKRFQxMbjfskUHMaBk4RlpCx6XQU8fHckcVJFJPxyWpdn+bp7efPRIJ26WhJvat9MWPxAt6CEl8l18lGxiHIegK46CVF5TTg1RZ5bhdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-53-6854dfb21c96
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
Subject: [PATCH net-next v6 1/9] netmem: introduce struct netmem_desc mirroring struct page
Date: Fri, 20 Jun 2025 13:12:16 +0900
Message-Id: <20250620041224.46646-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250620041224.46646-1-byungchul@sk.com>
References: <20250620041224.46646-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHeXaf++JocF2RN4OKlYSGVmJ5gij7INwoJTAssrCVFzfUGZua
	RoGpGJmzKKOcM65Kvk2dTc1ZJjktFQXfKGaWjpX6IStMG75RbUrktz//c36/8+UwhLyI9GXU
	mhRBq1EmKigpln7bUBpomTit2jfTEQRGcy0FpoV0qHRYSTDWPEcwvzhGw1xXNwXlpS4CjAM5
	GH6ZlwiYfOukwWSJgImKKQxtt1oIcN7toUCfs0zAq8XvNGRZqyQw+LyAhMKlpwS0ZDpoGHlh
	pGC89g8JUzY9hl5DNYaJgjB4K24GV98Mgi5ziwRc+SUUPBgWKficM4FguNOJofhmAQJzu52E
	5QW3o/jNOB22i++c+UHwTdWjEr7V8InmRUsq31gVwOfZhwneUnOb4i0/79P8x/dtFN/zeBnz
	rdY5Ca/P/k7xs5MfMP+j/R3Fm5veYb5f7KJPeZ+THo4TEtVpgnbvkYtS1cusu+iK0T89N7sP
	ZaL2HXnIi+HYEG66uZr+lxvLekhPptjdnN2+SHjyJnY/N+fsxnlIyhBsHcV11Y6tAhvZGG5+
	ctYNMAxm/bg/NzM8tYw9wImmCrTm3M6ZGl6verzYg9xs1kvKk+XunYWyHHJt35vrLfqCPRrC
	fdf8RO6pCTea3VxMeM5ybBvD3XKt4DXnFq6jyo7vIdawDjf8xw3rcBERNUiu1qQlKdWJIUGq
	DI06PehycpIFuR+m4sZKjBX9HIyyIZZBig0y63yUSk4q03QZSTbEMYRik6y8J1Ill8UpM64J
	2uRYbWqioLOhrQxW+MiCXVfj5Gy8MkVIEIQrgvbfVMJ4+WaiR/F3HDMnZNcbRN3O7oTzbP/8
	wMmR6KlL5YqiuoHf7Zf2pEXXh3uH+uCzTHzy9HCgw7/utuPCaNMz8WGdJKjc0jqb+VEMjezb
	tjRyqCaM1JQ0F4Qf3623JUfktzacMRU5c3/FVpoPH/MLLtMf9RsSCluyY4c09W39o50BfYee
	flVgnUq5P4DQ6pR/AddoijYsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRzF+e3e3XtdjW5L6qJZMrJQSLMyvlCEkODN0IzsgSE59eKGc8am
	4orwsaUkaU+i5pSlab5yNU2XL8Qt3SqoLMvUVDStIDWdiY/AtiTqv8M5n3O+/3wpTLSMe1Ay
	RSqnVEjkYkKACyL2a3aahqOku/ofbwG9sZaAmoUMeDBi5oO+uhHB3OIACQ5rNwFl9+Yx0L/S
	4vDTuITBeNcoCTWmcBiumMChNa8Jg9GrNgIKtMsYtC1OkZBjruSBpdjOh9eNhXy4tVSOQVPW
	CAlvm/UEDNWu8GGiswAHu64Kh+HCYOgybIT5F98RWI1NPJi/UkzAzR4DAWPaYQQ9llEcirIL
	ERjb+/iwvODcKHo2RAb7sJbv0xjbUPWRxz7VfSJZgymNra/0Y/P7ejDWVH2ZYE2zN0h28H0r
	wdruLOPsU7ODxxZopgh2ZrwfZ6fbewm27OsPHmts6MUjRdGCAwmcXJbOKQMOxgqkLTlX0Tm9
	b0au5gXKQu3e+ciNYui9TH2pje/SBL2D6etbxFzanQ5kHKPdeD4SUBj9kGCstQOkK9hAn2Hm
	xmecBYrCaR9mJVvtsoV0EGOoqUCrm1uZmkcdf3bc6H3MTE4L4dIiJ7NQquWv8usZ+93PuGsG
	c941lohcNuasap4UYdeQUPcfpftH6f6jDAirRu4yRXqyRCYP8lclSdUKWYZ/fEqyCTlfouLi
	r+tmNPc2tBPRFBKvFZrnjktFfEm6Sp3ciRgKE7sLy2wRUpEwQaI+zylTzirT5JyqE3lSuHiT
	MOwUFyuiEyWpXBLHneOUf1Me5eaRheIsR+sybWGH/L2iM9/sp9Ydvl9sceyRHm72Ot3YG2UI
	SCvuPXlku8O+NTlFY0VvwofiPUPLj63pqN6NJo9lNYe8jIxpG9TplupGvsXpykKKYk5MTdgW
	5r0Dt82WLPUrvsgb9n0g0/OeJ15YdPhOvqPGcm+veZ0YLgzYrN10yf0AT4yrpJJAP0ypkvwG
	Xn+cjQ4DAAA=
X-CFilter-Loop: Reflected

To simplify struct page, the page pool members of struct page should be
moved to other, allowing these members to be removed from struct page.

Introduce a network memory descriptor to store the members, struct
netmem_desc, and make it union'ed with the existing fields in struct
net_iov, allowing to organize the fields of struct net_iov.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/net/netmem.h | 94 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 73 insertions(+), 21 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 7a1dafa3f080..e0aa67aca9bb 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -12,6 +12,50 @@
 #include <linux/mm.h>
 #include <net/net_debug.h>
 
+/* These fields in struct page are used by the page_pool and net stack:
+ *
+ *        struct {
+ *                unsigned long pp_magic;
+ *                struct page_pool *pp;
+ *                unsigned long _pp_mapping_pad;
+ *                unsigned long dma_addr;
+ *                atomic_long_t pp_ref_count;
+ *        };
+ *
+ * We mirror the page_pool fields here so the page_pool can access these
+ * fields without worrying whether the underlying fields belong to a
+ * page or netmem_desc.
+ *
+ * CAUTION: Do not update the fields in netmem_desc without also
+ * updating the anonymous aliasing union in struct net_iov.
+ */
+struct netmem_desc {
+	unsigned long _flags;
+	unsigned long pp_magic;
+	struct page_pool *pp;
+	unsigned long _pp_mapping_pad;
+	unsigned long dma_addr;
+	atomic_long_t pp_ref_count;
+};
+
+#define NETMEM_DESC_ASSERT_OFFSET(pg, desc)        \
+	static_assert(offsetof(struct page, pg) == \
+		      offsetof(struct netmem_desc, desc))
+NETMEM_DESC_ASSERT_OFFSET(flags, _flags);
+NETMEM_DESC_ASSERT_OFFSET(pp_magic, pp_magic);
+NETMEM_DESC_ASSERT_OFFSET(pp, pp);
+NETMEM_DESC_ASSERT_OFFSET(_pp_mapping_pad, _pp_mapping_pad);
+NETMEM_DESC_ASSERT_OFFSET(dma_addr, dma_addr);
+NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
+#undef NETMEM_DESC_ASSERT_OFFSET
+
+/*
+ * Since struct netmem_desc uses the space in struct page, the size
+ * should be checked, until struct netmem_desc has its own instance from
+ * slab, to avoid conflicting with other members within struct page.
+ */
+static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
+
 /* net_iov */
 
 DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
@@ -31,12 +75,25 @@ enum net_iov_type {
 };
 
 struct net_iov {
-	enum net_iov_type type;
-	unsigned long pp_magic;
-	struct page_pool *pp;
+	union {
+		struct netmem_desc desc;
+
+		/* XXX: The following part should be removed once all
+		 * the references to them are converted so as to be
+		 * accessed via netmem_desc e.g. niov->desc.pp instead
+		 * of niov->pp.
+		 */
+		struct {
+			unsigned long _flags;
+			unsigned long pp_magic;
+			struct page_pool *pp;
+			unsigned long _pp_mapping_pad;
+			unsigned long dma_addr;
+			atomic_long_t pp_ref_count;
+		};
+	};
 	struct net_iov_area *owner;
-	unsigned long dma_addr;
-	atomic_long_t pp_ref_count;
+	enum net_iov_type type;
 };
 
 struct net_iov_area {
@@ -48,27 +105,22 @@ struct net_iov_area {
 	unsigned long base_virtual;
 };
 
-/* These fields in struct page are used by the page_pool and net stack:
+/* net_iov is union'ed with struct netmem_desc mirroring struct page, so
+ * the page_pool can access these fields without worrying whether the
+ * underlying fields are accessed via netmem_desc or directly via
+ * net_iov, until all the references to them are converted so as to be
+ * accessed via netmem_desc e.g. niov->desc.pp instead of niov->pp.
  *
- *        struct {
- *                unsigned long pp_magic;
- *                struct page_pool *pp;
- *                unsigned long _pp_mapping_pad;
- *                unsigned long dma_addr;
- *                atomic_long_t pp_ref_count;
- *        };
- *
- * We mirror the page_pool fields here so the page_pool can access these fields
- * without worrying whether the underlying fields belong to a page or net_iov.
- *
- * The non-net stack fields of struct page are private to the mm stack and must
- * never be mirrored to net_iov.
+ * The non-net stack fields of struct page are private to the mm stack
+ * and must never be mirrored to net_iov.
  */
-#define NET_IOV_ASSERT_OFFSET(pg, iov)             \
-	static_assert(offsetof(struct page, pg) == \
+#define NET_IOV_ASSERT_OFFSET(desc, iov)                    \
+	static_assert(offsetof(struct netmem_desc, desc) == \
 		      offsetof(struct net_iov, iov))
+NET_IOV_ASSERT_OFFSET(_flags, _flags);
 NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
 NET_IOV_ASSERT_OFFSET(pp, pp);
+NET_IOV_ASSERT_OFFSET(_pp_mapping_pad, _pp_mapping_pad);
 NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
 NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
 #undef NET_IOV_ASSERT_OFFSET
-- 
2.17.1


