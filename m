Return-Path: <bpf+bounces-46019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEE99E29A9
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 18:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4A1167612
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 17:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123231FCCF9;
	Tue,  3 Dec 2024 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UoPlVh7r"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BB4209F27;
	Tue,  3 Dec 2024 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247679; cv=none; b=KGm6336G072pGRVA7sp5pvk44l1fgGfFOAbhq4VaJ1tOShqKzorJr361zS3JqOxMrFRIkmiM9iy8f59OuwgbwgyhMvkQtYFxB3Yb1Jky2AlV/FrpflAC3R8FhXfRxTZGh03hs03lYGoTkEY/jfUoGHFHDORzSKk8hGJxsw8q4dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247679; c=relaxed/simple;
	bh=VPW1eu/AFrwv4zinEijk1TynOkF5WD6sC/kIqc4BOF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KY4K4yfiea+snx94tLCe68Gx6OsuYqskvyR9Ydh6Cr3YnPcEFbYDdFYkhonO8LujgvaTpmujFX5Rl/I5iLBP4ufBkmUxtGMHgFxS9os6MLd/hBKsehJzlxzl07SZRHbhLeJ1P0dtxeHJP4SPVS0J4+62OfPdtI7WN3uEFFGJzuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UoPlVh7r; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733247678; x=1764783678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VPW1eu/AFrwv4zinEijk1TynOkF5WD6sC/kIqc4BOF0=;
  b=UoPlVh7r7S8PzE00PwdNyjQz788dJ/9M1HQPee+YH+dXkAHMqJYx22zl
   r2ShbyjG2+GSwuaxciTugeL1QaAWS06YnvFH4/oo7iqFWQPyojGemj/MG
   1nKDyOMsGoRqytYBJTKFwuzPS7fhiJui94lWhG1X4m6P5hAj2mwH9a4Dr
   biMLz5dLvwMJgOyjNppsUecjxppmoQdZ/esB/BVN1oWPt/Zlisd3tuuQi
   ozTVl0aGkxErsWgx/yeW7GTVHUWjtBCFSi1W/ywltOpwn/EOXzb/OaJZH
   0T/KPtEeT8AZGakaZUTwpH/qyejyMwkfn+7pijxtT4mvFKOsqgkvKH2GB
   w==;
X-CSE-ConnectionGUID: w1C3PKOKRGmx6zR1VCF9sA==
X-CSE-MsgGUID: YuPK8qT5SeSHgGL5uPKdig==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37135386"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="37135386"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 09:41:18 -0800
X-CSE-ConnectionGUID: I/BRDEg+TnuFpSK2SbsNOg==
X-CSE-MsgGUID: rQ4uWSLvQrqdq051j4rMcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="124337037"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 03 Dec 2024 09:41:14 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 07/10] netmem: add a couple of page helper wrappers
Date: Tue,  3 Dec 2024 18:37:30 +0100
Message-ID: <20241203173733.3181246-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following netmem counterparts:

* virt_to_netmem() -- simple page_to_netmem(virt_to_page()) wrapper;
* netmem_is_pfmemalloc() -- page_is_pfmemalloc() for page-backed
			    netmems, false otherwise;

and the following "unsafe" versions:

* __netmem_to_page()
* __netmem_get_pp()
* __netmem_address()

They do the same as their non-underscored buddies, but assume the netmem
is always page-backed. When working with header &page_pools, you don't
need to check whether netmem belongs to the host memory and you can
never get NULL instead of &page. Checks for the LSB, clearing the LSB,
branches take cycles and increase object code size, sometimes
significantly. When you're sure your PP is always host, you can avoid
this by using the underscored counterparts.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/netmem.h | 78 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 8a6e20be4b9d..1b58faa4f20f 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -72,6 +72,22 @@ static inline bool netmem_is_net_iov(const netmem_ref netmem)
 	return (__force unsigned long)netmem & NET_IOV;
 }
 
+/**
+ * __netmem_to_page - unsafely get pointer to the &page backing @netmem
+ * @netmem: netmem reference to convert
+ *
+ * Unsafe version of netmem_to_page(). When @netmem is always page-backed,
+ * e.g. when it's a header buffer, performs faster and generates smaller
+ * object code (no check for the LSB, no WARN). When @netmem points to IOV,
+ * provokes undefined behaviour.
+ *
+ * Return: pointer to the &page (garbage if @netmem is not page-backed).
+ */
+static inline struct page *__netmem_to_page(netmem_ref netmem)
+{
+	return (__force struct page *)netmem;
+}
+
 /* This conversion fails (returns NULL) if the netmem_ref is not struct page
  * backed.
  */
@@ -80,7 +96,7 @@ static inline struct page *netmem_to_page(netmem_ref netmem)
 	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
 		return NULL;
 
-	return (__force struct page *)netmem;
+	return __netmem_to_page(netmem);
 }
 
 static inline struct net_iov *netmem_to_net_iov(netmem_ref netmem)
@@ -103,6 +119,17 @@ static inline netmem_ref page_to_netmem(struct page *page)
 	return (__force netmem_ref)page;
 }
 
+/**
+ * virt_to_netmem - convert virtual memory pointer to a netmem reference
+ * @data: host memory pointer to convert
+ *
+ * Return: netmem reference to the &page backing this virtual address.
+ */
+static inline netmem_ref virt_to_netmem(const void *data)
+{
+	return page_to_netmem(virt_to_page(data));
+}
+
 static inline int netmem_ref_count(netmem_ref netmem)
 {
 	/* The non-pp refcount of net_iov is always 1. On net_iov, we only
@@ -127,6 +154,22 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
 	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
 }
 
+/**
+ * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
+ * @netmem: netmem reference to get the pointer from
+ *
+ * Unsafe version of netmem_get_pp(). When @netmem is always page-backed,
+ * e.g. when it's a header buffer, performs faster and generates smaller
+ * object code (avoids clearing the LSB). When @netmem points to IOV,
+ * provokes invalid memory access.
+ *
+ * Return: pointer to the &page_pool (garbage if @netmem is not page-backed).
+ */
+static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
+{
+	return __netmem_to_page(netmem)->pp;
+}
+
 static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
 {
 	return __netmem_clear_lsb(netmem)->pp;
@@ -158,12 +201,43 @@ static inline netmem_ref netmem_compound_head(netmem_ref netmem)
 	return page_to_netmem(compound_head(netmem_to_page(netmem)));
 }
 
+/**
+ * __netmem_address - unsafely get pointer to the memory backing @netmem
+ * @netmem: netmem reference to get the pointer for
+ *
+ * Unsafe version of netmem_address(). When @netmem is always page-backed,
+ * e.g. when it's a header buffer, performs faster and generates smaller
+ * object code (no check for the LSB). When @netmem points to IOV, provokes
+ * undefined behaviour.
+ *
+ * Return: pointer to the memory (garbage if @netmem is not page-backed).
+ */
+static inline void *__netmem_address(netmem_ref netmem)
+{
+	return page_address(__netmem_to_page(netmem));
+}
+
 static inline void *netmem_address(netmem_ref netmem)
 {
 	if (netmem_is_net_iov(netmem))
 		return NULL;
 
-	return page_address(netmem_to_page(netmem));
+	return __netmem_address(netmem);
+}
+
+/**
+ * netmem_is_pfmemalloc - check if @netmem was allocated under memory pressure
+ * @netmem: netmem reference to check
+ *
+ * Return: true if @netmem is page-backed and the page was allocated under
+ * memory pressure, false otherwise.
+ */
+static inline bool netmem_is_pfmemalloc(netmem_ref netmem)
+{
+	if (netmem_is_net_iov(netmem))
+		return false;
+
+	return page_is_pfmemalloc(netmem_to_page(netmem));
 }
 
 static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
-- 
2.47.0


