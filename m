Return-Path: <bpf+bounces-59619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A76ACD5F2
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 04:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11583A4D19
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9E023DEAD;
	Wed,  4 Jun 2025 02:53:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435F62144C4;
	Wed,  4 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005591; cv=none; b=GGHbU+JkjQqkTMJ2XJX+NEc6esT7a2uca7jZP0iS0MwANbnhZNjI/Q0mxXpG1Zjq3Ft+cA7figsvoLgU4pKkcd7gIdf1fU0j8Sd/YFmiWjVHiC54UnFkQ4QiZirMRUeavqiA9h3tiDc6/+rHO36AXPhkk52EwPhoXY/fbsNrImI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005591; c=relaxed/simple;
	bh=plIDmpqi+WGX1YT9ietvC0dgtetMEzfy1+tYj+jQ6pU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rcS9XGHZf2282/UuHePgb05kA5TwlxJ4oVTbUO1FZatvTRXA+xwF2Y1Q3Fq8cbHkrExyjnCyAPEyWVwFmoDwwrfZy4gjEPAOiiCFfO17vJval0WtpKA4g/IkqZVp0esBusUhVYJMtnU9ODZrF/bakES4Nx0G+JuJHbrkbj/YGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-ce-683fb509c117
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
Subject: [RFC v4 02/18] netmem: introduce netmem alloc APIs to wrap page alloc APIs
Date: Wed,  4 Jun 2025 11:52:30 +0900
Message-Id: <20250604025246.61616-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604025246.61616-1-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG/e+cnZ0Nh6clelTMWhdTULMs3yDULtSBLiR+KoMaeXJLnTbv
	QqI1qK2cUZmmM6aWeYvVvG0ikhe8pJJo1iptYqiYpuRK1AnmLL/9eN7n+X15SUzUjruTMnkS
	q5BLYsWEABf8dCz149eHSvf1rnmDVl9DQPVSGrwcM3JBW9WA4PfyVx5YO7oIKCtZxED7XonD
	H/0KBhOd4zywlE/i0HynEYPx3G4CcpQ2DG4ZKzgw0KDhwuOVFxg0Zo3xYKhJS8C3mjUuTLbl
	4NBTWImDRRMGnToXWOydRdChb+TA4v1iAh4N6gj4rrQgGGwfx6EoW4NA32Lmgm1JS4TtYOoq
	P3MYU+Eoj9EZkpnaCl9GbR7EGEOVimAMCw95zMjHZoLpLrDhjMlo5TA5t+cI5tfEF5yZbxkm
	GH3dMM706Tp4jNWw7Tx1UXAkio2VpbCKgJArAulUbQEnoZ6fZpkZIrLQKE+N+CRNBdGaZ5Pc
	TS42zWN2Jihv2mxe3mBnKpC2jnfhaiQgMWqOS09obRw1IsmtVARtVR63I07tpvs7z9rrQuog
	vbzU/l/vRVe/fruh4VOH6JG5fI6dReudHOMHzK6kqWUePfPEiv4N3OjWCjP+AAl1yKEKiWTy
	lDiJLDbIX5oul6X5X42PM6D115bfXI00ooWBiDZEkUjsKDSOhEhFXElKYnpcG6JJTOws9PJZ
	j4RRkvQMVhF/WZEcyya2IQ8SF7sK9y+mRomoaEkSG8OyCaxi88oh+e5ZKPOU2653eSpTysSY
	09yZE6vT7XtyL6leZThdk+QpmwLCt7gHWvX3steie1a3Hy7puqu+Hpkf7MiGswO+/X6etbSD
	T+pw6sx0X9mxtRuzRS0anefsp9NjrCW4e2ere97zmKdL1Mm4N/JQm2ol09UjXbXX41zS0c7S
	wgNBlS4Xpn6MiPFEqSTQF1MkSv4CCYnh6dYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG/Z9zdnY2HJ3M9GgfrImJRpaU9cvKSxEeugp+sAuhQw9uOJds
	ahoE1oxwNS1TEp2xsLwOF/M2zcymeKGs0JSV2szQwkRdmqjr5qS+Pbzvw/vlpXC3CsKbkinS
	OKVCIheTQkJ4+qB6p6AxXLr7RaMX6IwGEmqXM6Fy3MwDXU0TgsWVET4sdPWQUP5wCQfdmxwC
	fhhXcZjsnuCDrWKKgLabzThM5PeSoM1x4HDdXIVBZ1kfD9425fGgcPUxDs3Z43wYbNWR8NHw
	hwdTFi0BfSXVBNjyIqBb7wFLL2cQdBmbMVi6XUbCvQE9CZ9zbAgGOicIKL2Wh8DYbuWBY1lH
	RojZhur3GNtSMsZn9aZ0tr4qkNVYB3DWVJNLsqbvBXx2dLiNZHuLHQTbYl7AWK16lmTtkx8I
	dq59iGTLv85jrLFhiGBf6bv40RvPCw8lcnJZBqfcFRYvlH6pL8ZSGwWZtm+DZDYa42uQgGLo
	vUxZyxzuZJL2Z6zWlXV2p4OZhYkeQoOEFE7P8phJnQPTIIraRMcwCzlHnUjQfkx/9ymnLqJD
	mJXlzn+TPkztk471GQG9jxmdvY852W3N0Zrf4XeQUI9capC7TJGRIpHJQ4JUydIshSwzKOFS
	igmtvVdx9eddM1ocjLIgmkJiV5F5NEzqxpNkqLJSLIihcLG7yCdgLRIlSrKucMpLccp0Oaey
	oC0UIfYUHY/l4t3oJEkal8xxqZzyf4tRAu9sZHDUlk37+rvqD3TMH2uNEW++NXbkWWGdIdlc
	2B6zKrWuDkybfm9TWSrV4l/zM58S7H75YTP2qNBq/VZfz/y6UJelOXXEuf17tkdfuDyiri/Q
	esQKz0bmGi7eSHKUGjc8iDu5Iz58+ERRxevnwWlwJsBrrOhR5LKnx9OG7MOu/fY0MaGSSoID
	caVK8hfND+SUuQIAAA==
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
 net/core/netmem_priv.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index cd95394399b4..32e390908bb2 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -59,4 +59,18 @@ static inline void netmem_set_dma_index(netmem_ref netmem,
 	magic = netmem_get_pp_magic(netmem) | (id << PP_DMA_INDEX_SHIFT);
 	__netmem_clear_lsb(netmem)->pp_magic = magic;
 }
+
+static inline netmem_ref alloc_netmems_node(int nid, gfp_t gfp_mask,
+					    unsigned int order)
+{
+	return page_to_netmem(alloc_pages_node(nid, gfp_mask, order));
+}
+
+static inline unsigned long alloc_netmems_bulk_node(gfp_t gfp, int nid,
+						    unsigned long nr_netmems,
+						    netmem_ref *netmem_array)
+{
+	return alloc_pages_bulk_node(gfp, nid, nr_netmems,
+			(struct page **)netmem_array);
+}
 #endif
-- 
2.17.1


