Return-Path: <bpf+bounces-42047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2D599F04B
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA831F23F5C
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FC2227B9E;
	Tue, 15 Oct 2024 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnOU55h5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D577E227B82;
	Tue, 15 Oct 2024 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004080; cv=none; b=MNyWwQ1LVYIWCACoJnCw/IBAOMWVv9ftSHl/qsqU+3LJxgvkfOfw8h/udPIBxyJmdVHTnpDWEPjk2LLrA6MYgRhZo111ypm9CZMCJAwYHhspp6jjco3tY7NQWMjeGfGTTQfJUc6bUoxcNNr7zbkO+Dpm2f/f6UizpduZlgAF0gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004080; c=relaxed/simple;
	bh=RaQ7gF8bPN8nJeHsuActWIGr2uG+ljgxCJ+2skfq5+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRiHiZF5hAlVIHd2WbBOs3Dc2/ayapCAl+eazKqGCpCndFYtHPoQzegjX2rbYOi9XKrtaeqJjbVKcizeBjZsP0xgWUplhn0LzCSjmiCgE48b9CS4L+XcDPiEbJ7GDLm9b3Rf8Pzrcg9zgxEpxyCIP2cikEwaBEDoPsHmesb9ncU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnOU55h5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729004079; x=1760540079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RaQ7gF8bPN8nJeHsuActWIGr2uG+ljgxCJ+2skfq5+Q=;
  b=TnOU55h50x32+HaLhBhptkL3Q7/Lz1C6vIoqmxboN5prg1iSPhCa957t
   L7xMJd26YSjiCEN821orACM/eSY/z48+EolmMEPNEDdmYeVVZzYlUTeFQ
   8rYBj8UYcXezdMzr7nI/qFZXu6lC05e1jiDrBsccDRAJ/2zP1g3uaisBf
   8bBZJ1ZktOEEIhETc4/i2gL/vUhdVB7kgY4q686G9+cMqoE5/AypfWGaC
   IxaKSHBNgsirtBJiCVaP1l5n7Zw5Enzb18ZnqaxubHytMjnElM+Nnxe1v
   MNE4TU46vwvXo2NZNdk8nhJbsKqX01UHN6dXwIm0KQqe0PbhdIVCKTNMD
   w==;
X-CSE-ConnectionGUID: xDoSE0d0RiilEYrzvpeotQ==
X-CSE-MsgGUID: wh1HXmICRdaMaHuS1MLRxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="31277508"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="31277508"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 07:54:39 -0700
X-CSE-ConnectionGUID: AYJoMfHQQJSVP9yS7Cx2Pg==
X-CSE-MsgGUID: TI6B2mTySmmPE4o9BhrDMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82723087"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa003.jf.intel.com with ESMTP; 15 Oct 2024 07:54:35 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 06/18] xdp: allow attaching already registered memory model to xdp_rxq_info
Date: Tue, 15 Oct 2024 16:53:38 +0200
Message-ID: <20241015145350.4077765-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One may need to register memory model separately from xdp_rxq_info. One
simple example may be XDP test run code, but in general, it might be
useful when memory model registering is managed by one layer and then
XDP RxQ info by a different one.
Allow such scenarios by adding a simple helper which "attaches" an
already registered memory model to the desired xdp_rxq_info. As this
is mostly needed for Page Pool, add a special function to do that for
a &page_pool pointer.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp.h | 32 +++++++++++++++++++++++++++
 net/core/xdp.c    | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 197808df1ee1..3e748bb916d3 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -356,6 +356,38 @@ void xdp_rxq_info_unreg_mem_model(struct xdp_rxq_info *xdp_rxq);
 int xdp_reg_mem_model(struct xdp_mem_info *mem,
 		      enum xdp_mem_type type, void *allocator);
 void xdp_unreg_mem_model(struct xdp_mem_info *mem);
+int xdp_reg_page_pool(struct page_pool *pool);
+void xdp_unreg_page_pool(const struct page_pool *pool);
+void xdp_rxq_info_attach_page_pool(struct xdp_rxq_info *xdp_rxq,
+				   const struct page_pool *pool);
+
+/**
+ * xdp_rxq_info_attach_mem_model - attach a registered mem info to an RxQ info
+ * @xdp_rxq: XDP RxQ info to attach the memory info to
+ * @mem: already registered memory info
+ *
+ * If a driver registers its memory providers manually, it must use this
+ * function instead of xdp_rxq_info_reg_mem_model().
+ */
+static inline void
+xdp_rxq_info_attach_mem_model(struct xdp_rxq_info *xdp_rxq,
+			      const struct xdp_mem_info *mem)
+{
+	xdp_rxq->mem = *mem;
+}
+
+/**
+ * xdp_rxq_info_detach_mem_model - detach a registered mem info from RxQ info
+ * @xdp_rxq: XDP RxQ info to detach the memory info from
+ *
+ * If a driver registers its memory providers manually and then attaches it
+ * via xdp_rxq_info_attach_mem_model(), it must call this function before
+ * xdp_rxq_info_unreg().
+ */
+static inline void xdp_rxq_info_detach_mem_model(struct xdp_rxq_info *xdp_rxq)
+{
+	xdp_rxq->mem = (struct xdp_mem_info){ };
+}
 
 /* Drivers not supporting XDP metadata can use this helper, which
  * rejects any room expansion for metadata as a result.
diff --git a/net/core/xdp.c b/net/core/xdp.c
index bcc5551c6424..bd2aa340baad 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -365,6 +365,62 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 
 EXPORT_SYMBOL_GPL(xdp_rxq_info_reg_mem_model);
 
+/**
+ * xdp_reg_page_pool - register a &page_pool as a memory provider for XDP
+ * @pool: &page_pool to register
+ *
+ * Can be used to register pools manually without connecting to any XDP RxQ
+ * info, so that the XDP layer will be aware of them. Then, they can be
+ * attached to an RxQ info manually via xdp_rxq_info_attach_page_pool().
+ *
+ * Return: %0 on success, -errno on error.
+ */
+int xdp_reg_page_pool(struct page_pool *pool)
+{
+	struct xdp_mem_info mem;
+
+	return xdp_reg_mem_model(&mem, MEM_TYPE_PAGE_POOL, pool);
+}
+EXPORT_SYMBOL_GPL(xdp_reg_page_pool);
+
+/**
+ * xdp_unreg_page_pool - unregister a &page_pool from the memory providers list
+ * @pool: &page_pool to unregister
+ *
+ * A shorthand for manual unregistering page pools. If the pool was previously
+ * attached to an RxQ info, it must be detached first.
+ */
+void xdp_unreg_page_pool(const struct page_pool *pool)
+{
+	struct xdp_mem_info mem = {
+		.type	= MEM_TYPE_PAGE_POOL,
+		.id	= pool->xdp_mem_id,
+	};
+
+	xdp_unreg_mem_model(&mem);
+}
+EXPORT_SYMBOL_GPL(xdp_unreg_page_pool);
+
+/**
+ * xdp_rxq_info_attach_page_pool - attach a registered pool to an RxQ info
+ * @xdp_rxq: XDP RxQ info to attach the pool to
+ * @pool: pool to attach
+ *
+ * If the pool was registered manually, this function must be called instead
+ * of xdp_rxq_info_reg_mem_model() to connect it to an RxQ info.
+ */
+void xdp_rxq_info_attach_page_pool(struct xdp_rxq_info *xdp_rxq,
+				   const struct page_pool *pool)
+{
+	struct xdp_mem_info mem = {
+		.type	= MEM_TYPE_PAGE_POOL,
+		.id	= pool->xdp_mem_id,
+	};
+
+	xdp_rxq_info_attach_mem_model(xdp_rxq, &mem);
+}
+EXPORT_SYMBOL_GPL(xdp_rxq_info_attach_page_pool);
+
 /* XDP RX runs under NAPI protection, and in different delivery error
  * scenarios (e.g. queue full), it is possible to return the xdp_frame
  * while still leveraging this protection.  The @napi_direct boolean
-- 
2.46.2


