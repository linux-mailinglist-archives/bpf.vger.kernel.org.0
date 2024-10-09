Return-Path: <bpf+bounces-41425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1C8996FF6
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 17:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A73F1C21B39
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9961E3DF4;
	Wed,  9 Oct 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="htG5pqdG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261C1E3DD7;
	Wed,  9 Oct 2024 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487741; cv=none; b=PhyG/lcvmF2l4XvuYn+0FmYsyw5JBQzS/gtTZjqzPvjJl9hB86RmScYuBswNoc5jeegHLhur0qu/aLy5LVqSQbicBh1tiQczGmJL9JTaRLBUoLcZAE91SuCvBMIlZBliJJNqvUzrwC51cZO5jTCcxX8VmctJp2ALDAxgt0Fua40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487741; c=relaxed/simple;
	bh=44POJs3v9/8guCtY9BiRnRKSxN9pZUlcfyC0/KKE7gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8KgBptqpj/CZSpGJXim8gXFoAtX9E/pCXwxmPMalXfWhn7w71GTa+xmnbvHEq8Rzz2/6Rzcw8VcUS/L3jCahAI/fxIjVRgkCfnPgMGfGTTXFzCKxys8tJCiXQOPXhSlMmcNgCvMzvpomt+YJTulV9grYNbvuCzkirefqSBY3Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=htG5pqdG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728487740; x=1760023740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=44POJs3v9/8guCtY9BiRnRKSxN9pZUlcfyC0/KKE7gk=;
  b=htG5pqdGXwmM1ln5/blPA+QKBoPXDk6HRQwVvzYFgX9xwLvqI52egz3k
   BiM3vek6e9Zmm1AAhoKUR+/xF5kNeyxamW4970BXvzoja4PWaafglPutF
   qeMSpW1+L7CXFqlF5FH0ZQgmEynag0WfkhqKtvdyWUmi8VXx5BfrwzU3z
   pdfOk7j5qw14HkG4Ox6S9Dol9tCXdbcyTKfwbQzqUR/5V2c1jPnAqdXNf
   toTImMynrbtHZnaE98SW6AkJk+kRTDQr2rvk516NNnAD3NgYt4hBXBNdW
   scQmqh8MeGLx5yL/mA4EOR0ykqmI/Q1VuEtRI+RQtyTxe5/1Xw2Vcs6/f
   w==;
X-CSE-ConnectionGUID: oELuvMQGTs23/jpzt9tSWw==
X-CSE-MsgGUID: Xa2EPGkAR6S6j8I9b6ddsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27675743"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27675743"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 08:28:59 -0700
X-CSE-ConnectionGUID: Cr1T/hVCRqmrRMLoeWceVg==
X-CSE-MsgGUID: z2rQevScTxefXxuHl4I0Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="81305915"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 09 Oct 2024 08:28:56 -0700
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
Subject: [PATCH net-next 06/18] xdp: allow attaching already registered memory model to xdp_rxq_info
Date: Wed,  9 Oct 2024 17:27:44 +0200
Message-ID: <20241009152756.3113697-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009152756.3113697-1-aleksander.lobakin@intel.com>
References: <20241009152756.3113697-1-aleksander.lobakin@intel.com>
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
index e683e835ab82..fae6305e2123 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -355,6 +355,38 @@ void xdp_rxq_info_unreg_mem_model(struct xdp_rxq_info *xdp_rxq);
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
index 34d057089d20..72d2bd22bc40 100644
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


