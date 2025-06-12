Return-Path: <bpf+bounces-60488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD47AD77A7
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 18:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F8016928A
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 16:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ACB29C326;
	Thu, 12 Jun 2025 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7i/DMy4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2D7298CB2;
	Thu, 12 Jun 2025 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744571; cv=none; b=aGowjCvcz5GRLsX1A8T8tvQG8aF9Aq1Fonplri1mH87NCPzqob24EFMnroLj7xfOaQXF79krmdmMm60cqn6zknwqE9hIYT8rE81THD1QrdrUezpH5XXSWxVzWrrvWj8RFX1YmsrPJrzqaftKkvgB7D7mKBWyJ2lSgxLzIPUvLi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744571; c=relaxed/simple;
	bh=sMeZ2NdQYW3BtiKLWGQG4wGWHkBRcGPXDhnN6q0ykCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVWtU5V3jjJ8nFWrMyVaY0EGtKLYttgefFHPXsZeaI4eMxVD6vPNwR8MoQ8wW9tq0zHzvPNDudsZakXn+VDdrX620eYVW65ZIk1Q6VpbCZeZsYKoqwzxZ5Zu7vde8AEKZPcNUpnJorP4mL17uCpfNBCz74xNWUWwZLLSG66IIrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A7i/DMy4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749744570; x=1781280570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sMeZ2NdQYW3BtiKLWGQG4wGWHkBRcGPXDhnN6q0ykCM=;
  b=A7i/DMy4H7ffkBzdld68aXWjWzpJuHTT7g8fuzMqCxKkj7oyNKJsm3v8
   saZ2E6ySRVGhBDzcvvN9xFTSnz8Mthju3il2d/Mq1aXMZaMgHucb90d6o
   RXUJsnFDLWZBArZKcJICOYMYy/f/bgfywOD42YOqfzGsCftQJJGy2f/mO
   xP5AV7x/jfKmmO9v3N4OLMD2Cs2uXaX3sT1QD9vPCl+CgZ7gP5LFLTvzK
   3O4MPv+cYOiEBbgKrJl4T1U212Y2ZPXEEyUTXFoGwtxC263iuW7BdrsXS
   ha9+S8BI569E9CMXQOedhn0S7lNd/C2d1XqCp/9eSfNzHX0gPLVn1LWMf
   A==;
X-CSE-ConnectionGUID: yKeAvtowQC6KiM0TguBhNg==
X-CSE-MsgGUID: tvXT8k5WR8uIqWBmlQUgtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="55738810"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="55738810"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 09:09:30 -0700
X-CSE-ConnectionGUID: sBIjIyUVSP6ukykuQKyzvA==
X-CSE-MsgGUID: Wm9LG2pkTCKUC4aduY/z4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="148468548"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 12 Jun 2025 09:09:25 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 01/17] libeth, libie: clean symbol exports up a little
Date: Thu, 12 Jun 2025 18:02:18 +0200
Message-ID: <20250612160234.68682-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612160234.68682-1-aleksander.lobakin@intel.com>
References: <20250612160234.68682-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change EXPORT_SYMBOL_NS_GPL(x, "LIBETH") to EXPORT_SYMBOL_GPL(x) +
DEFAULT_SYMBOL_NAMESPACE "LIBETH" to make the code more compact.
Also, explicitly include <linux/export.h> to satisfy new
requirements from scripts/misc-check.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/libeth/rx.c | 14 +++++++++-----
 drivers/net/ethernet/intel/libie/rx.c  |  7 +++++--
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
index 66d1d23b8ad2..c2c53552c440 100644
--- a/drivers/net/ethernet/intel/libeth/rx.c
+++ b/drivers/net/ethernet/intel/libeth/rx.c
@@ -1,5 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (C) 2024 Intel Corporation */
+/* Copyright (C) 2024-2025 Intel Corporation */
+
+#define DEFAULT_SYMBOL_NAMESPACE	"LIBETH"
+
+#include <linux/export.h>
 
 #include <net/libeth/rx.h>
 
@@ -186,7 +190,7 @@ int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi)
 
 	return -ENOMEM;
 }
-EXPORT_SYMBOL_NS_GPL(libeth_rx_fq_create, "LIBETH");
+EXPORT_SYMBOL_GPL(libeth_rx_fq_create);
 
 /**
  * libeth_rx_fq_destroy - destroy a &page_pool created by libeth
@@ -197,7 +201,7 @@ void libeth_rx_fq_destroy(struct libeth_fq *fq)
 	kvfree(fq->fqes);
 	page_pool_destroy(fq->pp);
 }
-EXPORT_SYMBOL_NS_GPL(libeth_rx_fq_destroy, "LIBETH");
+EXPORT_SYMBOL_GPL(libeth_rx_fq_destroy);
 
 /**
  * libeth_rx_recycle_slow - recycle a libeth page from the NAPI context
@@ -209,7 +213,7 @@ void libeth_rx_recycle_slow(struct page *page)
 {
 	page_pool_recycle_direct(page->pp, page);
 }
-EXPORT_SYMBOL_NS_GPL(libeth_rx_recycle_slow, "LIBETH");
+EXPORT_SYMBOL_GPL(libeth_rx_recycle_slow);
 
 /* Converting abstract packet type numbers into a software structure with
  * the packet parameters to do O(1) lookup on Rx.
@@ -251,7 +255,7 @@ void libeth_rx_pt_gen_hash_type(struct libeth_rx_pt *pt)
 	pt->hash_type |= libeth_rx_pt_xdp_iprot[pt->inner_prot];
 	pt->hash_type |= libeth_rx_pt_xdp_pl[pt->payload_layer];
 }
-EXPORT_SYMBOL_NS_GPL(libeth_rx_pt_gen_hash_type, "LIBETH");
+EXPORT_SYMBOL_GPL(libeth_rx_pt_gen_hash_type);
 
 /* Module */
 
diff --git a/drivers/net/ethernet/intel/libie/rx.c b/drivers/net/ethernet/intel/libie/rx.c
index 66a9825fe11f..6fda656afa9c 100644
--- a/drivers/net/ethernet/intel/libie/rx.c
+++ b/drivers/net/ethernet/intel/libie/rx.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (C) 2024 Intel Corporation */
+/* Copyright (C) 2024-2025 Intel Corporation */
 
+#define DEFAULT_SYMBOL_NAMESPACE	"LIBIE"
+
+#include <linux/export.h>
 #include <linux/net/intel/libie/rx.h>
 
 /* O(1) converting i40e/ice/iavf's 8/10-bit hardware packet type to a parsed
@@ -116,7 +119,7 @@ const struct libeth_rx_pt libie_rx_pt_lut[LIBIE_RX_PT_NUM] = {
 	LIBIE_RX_PT_IP(4),
 	LIBIE_RX_PT_IP(6),
 };
-EXPORT_SYMBOL_NS_GPL(libie_rx_pt_lut, "LIBIE");
+EXPORT_SYMBOL_GPL(libie_rx_pt_lut);
 
 MODULE_DESCRIPTION("Intel(R) Ethernet common library");
 MODULE_IMPORT_NS("LIBETH");
-- 
2.49.0


