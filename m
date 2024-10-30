Return-Path: <bpf+bounces-43578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F95E9B69B6
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 17:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0131F21908
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 16:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345C2218D64;
	Wed, 30 Oct 2024 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="feTYX0Yi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897E1218946;
	Wed, 30 Oct 2024 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307236; cv=none; b=U4HgNM/7zRLQztde8JHkVYXL7mY4Ztc7SpMcgfO21Dg0QlBJxOX4qCZ9pgwmEr8k5Iu2/zcS+EI6kqMhazmrETloTRZcZEdB6Rff1oFquFkttg2W3UON+hbPMu2FTrHd8T/mLzggf9jDPe3jbulZoa2qNLSmBLe4weLf3Vt6Ayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307236; c=relaxed/simple;
	bh=8askIUmsQgl1HXCaVlVXTKLdGD1JlCwkqLub/Cb6krs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6Tr9t4NKn6YsPC8gWlCDGlua1OEjVQwF3/7DVb1/6uDQi+7GWbZZePP7qlFK1Y94bX6GzMxH7bt8zJYE7+got6G8vySJvDd//KI6pwcFZQt3ZvL9RSoB1u1nwWY4vv16O0GJ2seiboR1vFESc6cAY/wom3/pOkGJCwd3QwPX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=feTYX0Yi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730307235; x=1761843235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8askIUmsQgl1HXCaVlVXTKLdGD1JlCwkqLub/Cb6krs=;
  b=feTYX0YiJI8TBX5jxrBoSPvgRgo2nx4MuTHtnHr2Rn+SA/iFlV191sFB
   wpZcIbPZ71jqI2p9ue0QeHxS3EEi5OMIzLp9eNMnInW+INX0VdNpQovJw
   uFyr8cmwVuifrLCC2d/nugz3w6nIQA722nuYwpbsU53p+3lMvBzUL/LF6
   utbRDlQNE8fmiRcLIXSzSCm59rNixXVTI8r0hSG0p65aykNQFApFcu1Hk
   O0tvucbXbkRFesBdgxV8mUy+Qtx9DyyKw9StWO+N8PDR5pCZiOPECgz8V
   4hdP9Nt5poL97bZAU1Z4WbLD4OJ+8efef8eTC2Z5iUAkzEgvtAA7VmQEe
   g==;
X-CSE-ConnectionGUID: e7vD74ljQWqHFQ2i/IYg8A==
X-CSE-MsgGUID: n3/wixFDSomXEkeUZh8+NQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="41389677"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="41389677"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:53:54 -0700
X-CSE-ConnectionGUID: JVhSkv3ARieLetJ/O9hNXg==
X-CSE-MsgGUID: chToUT6VTRWHllf5sxiIDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="87524500"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 30 Oct 2024 09:53:51 -0700
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
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 06/18] xdp: allow attaching already registered memory model to xdp_rxq_info
Date: Wed, 30 Oct 2024 17:51:49 +0100
Message-ID: <20241030165201.442301-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030165201.442301-1-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
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
2.47.0


