Return-Path: <bpf+bounces-60750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1865BADBAF0
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 22:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F403B1FBA
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 20:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872B428A723;
	Mon, 16 Jun 2025 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZYa0v5/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BC820C476;
	Mon, 16 Jun 2025 20:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105034; cv=none; b=gfHqNmon60+jmrPB6Z0zq2T8mxRIVDP/wwIIwo+2msv90Vd/yKC0GbFaNYhxmhHjoiPmIbGqrXzPZr119KXAaesFB53zqLC3Nlt4dvTXjF5HfdGAwZwS1o50CSmjurR70Aupg4HpelYYwG02g9KJTiJHmO6OknM3bZQmrKb+zYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105034; c=relaxed/simple;
	bh=aqKLnTlcNBzCEBLsVUm3SGmFUJ5zA1fIafnJh5O1zNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SH01duy2etPlh3RxgMqXglQU0SsFt1T+2g0ym7CoKKIVOKN5IjjbiaCmlTzmkbPFwZ4dMWlSZU5I7cbgaFwE9BXBUTruLbbpE2M7lRRZ3rFK/UPP58DRXsJBMt8gE5fB4bNINRKFybFUePNRHj42/VHPN88VjTNrU3ZWAmu8lRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZYa0v5/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750105032; x=1781641032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aqKLnTlcNBzCEBLsVUm3SGmFUJ5zA1fIafnJh5O1zNE=;
  b=eZYa0v5/RG0PKYyC6ZDwnEpMcq1PzzrW26E136wXkLATS0MDNlenJiFK
   ygzQR1/8KefZ3XrQd+3Vbvk4zamZM/kb1f0sU5pcfwgFEVqMa36OQPV6k
   pDd4/lUN52kSSpnYdc6+C/Zw47dqWmOCUnuSCZEd5eeukWaaNEN6OOO21
   NIsxY8FPracaIeug7XiVmolaIgYLs3FiAzRICd8U2Har6JmjfajdK4YY7
   iFfMFhnVDyyWn2MQYgPZB4a+BkpnM9OlIGT0/K+KLSfWPh4skL8FydyA7
   AB9BKg0r7iIHWS7KYXpfiuJtposZlKmL1zkVyPkcWXV6fTOdUFc6QOcOL
   g==;
X-CSE-ConnectionGUID: 1tZ6G5qnRuad/PtuUVMeTg==
X-CSE-MsgGUID: oG1Pv8E3Sq2My9hvYCXwvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="62533446"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="62533446"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 13:17:10 -0700
X-CSE-ConnectionGUID: EW8Q2532TwqtCjF/PHO+eQ==
X-CSE-MsgGUID: AcgcbxPIRTeMR3H7DZ99NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="153530968"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 16 Jun 2025 13:17:10 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	przemyslaw.kitszel@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	bpf@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v2 01/17] libeth, libie: clean symbol exports up a little
Date: Mon, 16 Jun 2025 13:16:22 -0700
Message-ID: <20250616201639.710420-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250616201639.710420-1-anthony.l.nguyen@intel.com>
References: <20250616201639.710420-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Change EXPORT_SYMBOL_NS_GPL(x, "LIBETH") to EXPORT_SYMBOL_GPL(x) +
DEFAULT_SYMBOL_NAMESPACE "LIBETH" to make the code more compact.
Also, explicitly include <linux/export.h> to satisfy new
requirements from scripts/misc-check.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.47.1


