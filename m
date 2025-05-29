Return-Path: <bpf+bounces-59245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C3BAC7631
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C413D1C04A63
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1792256C6D;
	Thu, 29 May 2025 03:11:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ACE2629C;
	Thu, 29 May 2025 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488271; cv=none; b=oWQVm6hmbF1Zb/igeeAGRv5KL4S3fHbIfuY/F+fHprgsrCXWCprK09WUb5pC8pET1WcDNx9R52Mnrj1lyZnV7yXL/ajX48nWOSgOIIjEs8Ovp31TA4oG8LAqlX0uQL2QkvLMZsmERGHOVEM006sFnS0j4F5DKIwBcE1nLFGWRZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488271; c=relaxed/simple;
	bh=i7v/ih20Tz3GcCicwxl0b7oiso6HYdTd4j5M1pwRBAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hop2M+B4+u4PQqoMhvq+2O1OKKijTMmYqlAL1kdJ2TP7sWolzRzzeL33EYqHDWjYAhWz1fHVe+N4W7qA8SVTd2pu2YUHi+ls4U4CId85ROGyE0icskoxtCCeR1o/VPZydpwhb9fWI9NtCH9eyyxf/hKt25871KGCnU+IRQzLy3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-cb-6837d041fdaa
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
Subject: [RFC v3 01/18] netmem: introduce struct netmem_desc mirroring struct page
Date: Thu, 29 May 2025 12:10:30 +0900
Message-Id: <20250529031047.7587-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529031047.7587-1-byungchul@sk.com>
References: <20250529031047.7587-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG/e/8z8Xh4jQtTwaVI4kMtcLy98HLjD4chKDLhyKjWnloIzdl
	pmm1MJPSoavM1PRIM7G81WJK0xDJ5S0KlJWyMjMsJTCVNJeXqTnDbw+87/t8eRlC3oEDGI3u
	kqDXqRIVlBRLx30qQmJ7I9S7bzn2gWipp6BuNh2efmsiQax9ieDP3AAN0+1dFFRWuAgQe7Ix
	zFjmCRjpHKZh6MkohpbbNgKG73RTkJ+9QEBWU7UEel+aSCicryLAlvmNhg+vRAq+1i+TMGrP
	x/C2tAbDkEkJneaN4Hr3C0G7xSYBV145BfcdZgq+Zw8hcLwZxlB2w4TA0uokYWFWpJSBfGPN
	JwnfXDpI82ZrKt9QHcwbnQ6Ct9bmUrx1qoDmv/S3UHx3yQLmm5umJXz+zQmK/z3yGfOTrX0U
	b2nsw/x7czvNT1u3HGZPSiMThERNmqAPiz4rVQ9YOyTJ/TvTexwldCYq3WZE3gzHhnPjDUvk
	Gr+YHKQ9TLE7OKdzjvCwH7uHmx7uwkYkZQh2guRGxAWJJ/Blj3IlfwtXS5gN4p7ljGMPy1ZE
	jc4C4r90K1f34vUqe7P7uKKGotWtfKXz0NhGeaQcO0NzjmI7/j/YxLVVO/FdJDMjr1ok1+jS
	tCpNYnioOkOnSQ89n6S1opVznxjc8U1oqveYHbEMUvjIulGEWk6q0lIytHbEMYTCT5YVs18t
	lyWoMq4I+qQz+tREIcWONjNY4S/b67qcIGcvqC4JFwUhWdCvpRLGOyATFdd7K1+5W7cNluWd
	mFT/NJhKLT8ORR3BOTjOcr05zIWkgQNBog2FPQhJuFfl/rIYvT5SfB8V7b9hES+5t6t8M8i2
	ubENxKnia32Xo2zHd2n7C/PKY696uWcfJz9fFxxUGZ8Dgvb0uQMfDcEm/Gg521AjksqD68/H
	fbfH5I4pcIpatSeY0Keo/gGot6AM2AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG+59zds5xtDhOsZMR2chMI83I/JVRRlT/IirqQ+gXHXpyw3lh
	U1HL8BampNkSMZuwkMwrkyk6w6zUvJDhLXVmpswLFql5ybyROaNvDzzv+355WVJaTDmyyvAo
	QR0uV8loMSW+6pNy+GyXt+JIevcB0BnKaShbjoWXoyYR6EprECyuDDGw0NxKQ+HzJRJ0nakU
	/DKskjDRYmFgpGiSgvq0WhIsj9poyExdIyHZVExAU0G7CLpqskSQs/qChNrEUQZ6X+lo+Fq+
	IYLJxkwK2vNLKBjJ8oUWvQMsffiBoNlQS8DSwwIanvToaRhLHUHQ02Sh4FlSFgJDg1kEa8s6
	2leGq0sGCVyXP8xgvTEaVxW74QxzD4mNpek0Ns5rGfylv57GbXlrFK4zLRA4M2WGxnMTnyk8
	29BH48KpnwQ2VPdRuEPfzFy39RefChZUyhhB7XE6UKwYMr4nIvtdYzt78phElO+UgWxYnjvG
	V84OM1amORfebF4hrWzPefILllYqA4lZkpsR8RO6NcIq7LgbfN7vnK0QxTnzFQ+mKStLNoeq
	zVry3+hevqzy7RbbcF58blXuVle6mXma8Y7ORmI92laK7JXhMWFypcrLXROqiAtXxroHRYQZ
	0eZ/RQnrj01osfdiI+JYJNsuaUPeCqlIHqOJC2tEPEvK7CXJZ44rpJJgeVy8oI4IUEerBE0j
	2s1Ssp2Sy7eEQCkXIo8SQgUhUlD/twRr45iI/B34FWEueaBy3/ehPx6iKzt6Yzu61ukTIUWf
	UjoLkjQhjnW2TvsPvrmLO7Ufowfvd+/6NjyGTBtVlRVB8b71ieM3x/OSC1puMz7ayFFN0p2j
	LgElFxr81DHOAjd96OQ8f+ncnuwEImrgtWvalEo+0+HAXks5f2/w6Zxd67Kjn0VGaRRyTzdS
	rZH/BVcKACW7AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To simplify struct page, the page pool members of struct page should be
moved to other, allowing these members to be removed from struct page.

Introduce a network memory descriptor to store the members, struct
netmem_desc and make it union'ed with the existing fields in struct
net_iov, allowing to organize the fields of struct net_iov.  The final
look of struct net_iov should be like:

	struct net_iov {
		struct netmem_desc;
		net_field1; /* e.g. struct net_iov_area *owner; */
		net_field2;
		...
	};

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/net/netmem.h | 101 +++++++++++++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 22 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 386164fb9c18..d52f86082271 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -12,6 +12,47 @@
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
@@ -31,12 +72,33 @@ enum net_iov_type {
 };
 
 struct net_iov {
-	enum net_iov_type type;
-	unsigned long pp_magic;
-	struct page_pool *pp;
-	struct net_iov_area *owner;
-	unsigned long dma_addr;
-	atomic_long_t pp_ref_count;
+	union {
+		struct netmem_desc desc;
+
+		/* XXX: The following part should be removed once all
+		 * the references to them are converted so as to be
+		 * accessed via netmem_desc e.g. niov->desc.pp instead
+		 * of niov->pp.
+		 *
+		 * Plus, once struct netmem_desc has it own instance
+		 * from slab, network's fields of the following can be
+		 * moved out of struct netmem_desc like:
+		 *
+		 *    struct net_iov {
+		 *       struct netmem_desc desc;
+		 *       struct net_iov_area *owner;
+		 *       ...
+		 *    };
+		 */
+		struct {
+			enum net_iov_type type;
+			unsigned long pp_magic;
+			struct page_pool *pp;
+			struct net_iov_area *owner;
+			unsigned long dma_addr;
+			atomic_long_t pp_ref_count;
+		};
+	};
 };
 
 struct net_iov_area {
@@ -48,27 +110,22 @@ struct net_iov_area {
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
+NET_IOV_ASSERT_OFFSET(_flags, type);
 NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
 NET_IOV_ASSERT_OFFSET(pp, pp);
+NET_IOV_ASSERT_OFFSET(_pp_mapping_pad, owner);
 NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
 NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
 #undef NET_IOV_ASSERT_OFFSET
-- 
2.17.1


