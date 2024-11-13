Return-Path: <bpf+bounces-44760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D72F9C7845
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 17:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D4AB347A3
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 15:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A0C204923;
	Wed, 13 Nov 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G42zPcut"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93EC2038D4;
	Wed, 13 Nov 2024 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511533; cv=none; b=QHRX6RTXr/GUHtUdBPnrD7jch/9Iib+rEtbd/p+9uhIqBfaddSyb6EjhwtLImbhURk0z1CkVtuZQXP0cUN3aRHF1CyXi5e+QWw/pZtB/CSlTb/LjSp1OoUT4uj3xSAHIP/TjdfBMsGrtJNf7EHtU/BviQjhSmWbwbOkBnDHDEqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511533; c=relaxed/simple;
	bh=HZLVt3NKSatf1L4OsRgd6FV0DcJ57iInm81GihqPMDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FR6/r2QWCKMydhu/tTUQ2EnQgWD4WevZa0tBYEkJBIkrVqSJHp7IBTS5oSzFNq+98iv4zTKYrp0lqEQOOKfe2eY9jsBsBlVCV/LXJ455PiDblxxMaK9PGe+pw7GZ+O9DGlrhWQzZ7khzmVodFOiW3unTr8HBBSDgd0foQecNhbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G42zPcut; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731511532; x=1763047532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HZLVt3NKSatf1L4OsRgd6FV0DcJ57iInm81GihqPMDw=;
  b=G42zPcut6UvR1CemeFdQcIMSJp4Dyq3k9ATy/wsYF6JFvIJqDzuFyHaI
   gJFZ0dtLbwsyKAmyf1203N92zTThOGTRtzCU3q4Vpt6p6CvRc1L2mf84L
   E9CbAYt4zQDCpljjvrxhiNk15O+vhN/GG0dLK5MptGPIlw0TH9/AmZDd0
   kbAUAqfz12Y4RQWZkgjFGdLmehPBq8+no6snxdDeetnthduBJqEQ6Idtg
   6VoHr95/lARfxanqE4KTvjnpknSrzVEF2G2p0x/P6KDmimRfRFBFtNTEN
   ZymV5n7FDNz/b5F5+1vYMOg0tDu6jmleR853FVruHxnWm0bbp43UgZ+1I
   g==;
X-CSE-ConnectionGUID: bag3GovuRUOSfoMIf//rmQ==
X-CSE-MsgGUID: YfZ8eb+AT9KzIB8uLLp1ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42799303"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42799303"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:25:25 -0800
X-CSE-ConnectionGUID: 5RUvSglJQI+B/qJ2cGZrwQ==
X-CSE-MsgGUID: fbI8WOy3QxS2yFxIffbuYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="118726910"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 07:25:21 -0800
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
Subject: [PATCH net-next v5 06/19] xdp: allow attaching already registered memory model to xdp_rxq_info
Date: Wed, 13 Nov 2024 16:24:29 +0100
Message-ID: <20241113152442.4000468-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

One may need to register memory model separately from xdp_rxq_info. One
simple example may be XDP test run code, but in general, it might be
useful when memory model registering is managed by one layer and then
XDP RxQ info by a different one.
Allow such scenarios by adding a simple helper which "attaches" an
already registered memory model to the desired xdp_rxq_info. As this
is mostly needed for Page Pool, add a special function to do that for
a &page_pool pointer.

Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
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


