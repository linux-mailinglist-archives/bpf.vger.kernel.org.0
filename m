Return-Path: <bpf+bounces-59062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF24AC5F6B
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84FCA1BC1792
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203341F91C7;
	Wed, 28 May 2025 02:29:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77591BBBE5;
	Wed, 28 May 2025 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399368; cv=none; b=Pmqr0ja83+0FBx9ZV3ejTFULOrlWemLNVigzBlGikHgAJ1msv1rWxpAbUMtOa1+3hf93V21hN+U/bqX4gTcXMpUm0zu74oFx9V2yWmXnwLmCksE/dV7Fiab7TjNDlPwOgt3lCw88OTezOdkbAE16S/K2CfxY0eU0XYg+zkpTxi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399368; c=relaxed/simple;
	bh=rxNVScw+WaIc/Pgeu3xYxyvDXEZ9IwYcwWvNAwGq7Bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=thIbyrNX9d9bOdfGDciuS7aZhap0N20pIFGski36SszE7G7KA89HjAKz9vMRuxd1ffRUxp8AJhV2drIhRLd+Y/ywgEzDLrjFo4OhvL3KrVo/7jchJpCcnjV7ydeG+zayb81aQXU73sNOba491wyIUblnXm+INmxF7PsB0SkgU1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-2b-68367501ca7a
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
Subject: [PATCH v2 02/16] netmem: introduce netmem alloc APIs to wrap page alloc APIs
Date: Wed, 28 May 2025 11:28:57 +0900
Message-Id: <20250528022911.73453-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250528022911.73453-1-byungchul@sk.com>
References: <20250528022911.73453-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG++9cdrYcHJask2XWICqhpaH2JpVCgf+USEiDCsrhTm00l23O
	GwTeILxHBYpNnZqmlsxW3sKspqVRkdltqTVbaH3IWZo6XWCO8tuP5/3x8MDLENJe0o/R6FJ4
	vU6pldNiUjzpU7MDGcPUQbU/FWCy3Kbhljsdbo51UmBqbkfwe2FECDN9/TTU1cwRYHqVR8Ks
	ZZGA8adOITgaJkjovtRBgLN0gIbiPA8BOZ2NAhhsL6Hg2mI9AR1ZY0J4c99Ew+fbSxRM2IpJ
	eFbRRIKjJBKemmUw9/wHgj5LhwDmiippuDpkpuFrngPBUK+ThOvZJQgsPXYKPG4THbkZ32v6
	KMBdFZ+E2Gw14ruNgbjAPkRga3M+ja3TV4R49H03jQfKPSTu6pwR4OJcF41/jQ+TeKrnHY0t
	996R+IW5T4hnrBtj2RPivSpeq0nl9Tv3J4jVDxYGBcltovQpaxmVhcaFBUjEcGwI1/Klmlph
	s+eGwMs0u5Wz2xcIL/uywdyMs58sQGKGYF0UN27yLEsMs4aN5xzDZ7wOyW7hyibrSS9L2FCu
	tO4t+tcZwN1qfUR4dREbxj0ZTfTG0mVlqtCCvJUcOyvkir5X/d+zjnvcaCcvI4kZrWpGUo0u
	NUmp0YYo1Bk6Tboi8XySFS2/tuHin5OdaHrwqA2xDJL7SHBrqFpKKVMNGUk2xDGE3FeSExGm
	lkpUyoxMXn/+tN6o5Q02tJ4h5Wslu+bSVFL2rDKFP8fzybx+5SpgRH5ZiHj4UhR1Ki5g+0hV
	7OSL49NLNJ/ZMx9uqj22sy2ez4yLjPbrL3C9sexS7FusPFDvjtpWJnPmrg62xWyqNM4H+e+J
	iwh2yQ+VTFhVbpg8uVuQVj71OiipJXzgW7728IfCC2N33dE5/ke6E6SROfoOavvmgzL/PFdM
	xDnZhuo7H7PlpEGtDA4k9AblX+1hWZzWAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRzGe3fenR1Hy+O0PFggLSoQ80LN/lGUFtGLHyIKM6LUg57c8Mqm
	okFlXrKsaalg6YSFad5wMm9TTPKSFywUb8xLKtakD6mVF9QZ5Yi+/XieH8+Xh6Hk5diNUccm
	CJpYPlpBS7H08un0YyjRT+VjnnAHvbGGhuqNZHg7ZxaDvqoJwermlARWuntpKH29ToF+MAPD
	mnGLAmvPvARmyxcwtGU1UzCf20eDLsNGQZq5QgRdJf1iGGrKEUPBVhkFzalzEhhp1dMwU/NH
	DAudOgz9RZUYZnP8ocewD9YHviPoNjaLYP1ZCQ35wwYavmTMIhjumsdQ/DAHgbHdIgbbhp72
	V5CGygkRaSn6LCEGUyKpr/Ag2ZZhipiqntDE9CtPQqbH22jS99KGSYt5RUR06Us0+WmdxGS5
	fYwmpd9+iIixYQyTj4ZuyRWnm9IzEUK0OknQeJ8Nk6rebQ6J4hsdkpdNheJUZJVkIweGY09w
	BtsbkZ1p9ihnsWxSdnZhfbmV+V6cjaQMxS6JOavetiMxjDMbxM1O3rE7mD3MFS6WYTvLWCWX
	WzqK/m26c9V17ym77sD6cR+mw+2xfEdZfmpEz5HUgHZVIRd1bFIMr45WemmjVCmx6mSv8LgY
	E9p5r/ze9gszWh251IlYBil2y0idUiUX80nalJhOxDGUwkWWds5PJZdF8Cl3BU1cqCYxWtB2
	ov0MVrjKAoOFMDkbyScIUYIQL2j+tyLGwS0VudZO6Q62BqzdgIsHQuZyfQN1e4YyPY8EvVI6
	DaYVLJSoOgruK0N6vXoKZvBi8OjvHv8i5+JP9fHp5/0cveOyTSfHQ4jn4wtxt6xD1wb8M66G
	WoSIss3GwrMPaqTVj/jQgOuyYPdDkVkdMS28j2Pm9qlajz66/2tW/16cf/t4nkGBtSre14PS
	aPm/uaHcObkCAAA=
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
index a721f9e060a2..37d0e0e002c2 100644
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


