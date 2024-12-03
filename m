Return-Path: <bpf+bounces-46013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6669E2C09
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 20:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05915B80CF0
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 17:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8911FDE14;
	Tue,  3 Dec 2024 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJrLjLQo"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843501FC7DD;
	Tue,  3 Dec 2024 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247655; cv=none; b=dQskJyZnje99JqUwv3+fVxmeSrugGkt0uMcY3YZr40d8zDl/OZ13sBAGFB9MOxyq1U559h5wSZRr5NqABRCqFiU+5ugyJDihzDSQhsrOzZImwX6X/alCQ36DJ5qNqCPyvFvEsQJdp+SWci2aGbWJnnGCoXaSEMup2vyW/tZiTS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247655; c=relaxed/simple;
	bh=hCXkJobN9Y7lj3B9E3KE7PpBF8wrRPXTUlkmt82YSlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czkCeKtj84UAFccOhgdAw/NHR1CWJ995r2xyJABFKH0Fj/nuI9yWVWzi1YrdycBOnPmrSIiJ3+o4xrjPzkzr4qEpeSxbI1XQh4ZMep9tH+vK2T7rU28oM/+JJ3kLRy7EmlL1kj/n4LpyaEVn639w8XprTX9CDdhhFOkCAcu8zOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJrLjLQo; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733247654; x=1764783654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hCXkJobN9Y7lj3B9E3KE7PpBF8wrRPXTUlkmt82YSlU=;
  b=oJrLjLQouqhbXG5pbCwaANacmYYubsnV/Vg2MY7FSYav0WBxXkmps8S+
   Yk46Z3zeV7jJteSmmTyck3nDym8ZgCG3u2WVvdGCaJFnSq9Y7oj2+PG75
   RLZ4W1W7Gg/Fc1XS6zZXouEOQ1/69Uk7Iu8t8FFK6J5TLXyp79NscHszh
   KI6ffpnsXTbCAVtTTxCGamUGwCMhB+wwulX3UldYqK+MgRhLN7t0jhqma
   UDxbRdA0GxNsaCeFf5X47k4WNWpz/HV3s7oFg8mYmiVUwlRJz9iPVovC3
   ZNfHZRdeX9HKAUY0cwvlMM5yGC8krAJOqQsW04mYKZiAbx2aqTenMuu+b
   Q==;
X-CSE-ConnectionGUID: TKZ60ukqSiylW41U3ibCxw==
X-CSE-MsgGUID: oC7JNdkgRQKvMB0Gq185xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37135281"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="37135281"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 09:40:54 -0800
X-CSE-ConnectionGUID: 2zrK6qLoQauoxzNv2bxOLg==
X-CSE-MsgGUID: 7WiInC6lQbG5Jr+sYX/tZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="124336996"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 03 Dec 2024 09:40:50 -0800
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
Subject: [PATCH net-next v6 01/10] xsk: align &xdp_buff_xsk harder
Date: Tue,  3 Dec 2024 18:37:24 +0100
Message-ID: <20241203173733.3181246-2-aleksander.lobakin@intel.com>
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

After the series "XSk buff on a diet" by Maciej, the greatest pow-2
which &xdp_buff_xsk can be divided got reduced from 16 to 8 on x86_64.
Also, sizeof(xdp_buff_xsk) now is 120 bytes, which, taking the previous
sentence into account, leads to that it leaves 8 bytes at the end of
cacheline, which means an array of buffs will have its elements
messed between the cachelines chaotically.
Use __aligned_largest for this struct. This alignment is usually 16
bytes, which makes it fill two full cachelines and align an array
nicely. ___cacheline_aligned may be excessive here, especially on
arches with 128-256 byte CLs, as well as 32-bit arches (76 -> 96
bytes on MIPS32R2), while not doing better than _largest.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xsk_buff_pool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index bb03cee716b3..7637799b6c19 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -29,7 +29,7 @@ struct xdp_buff_xsk {
 	dma_addr_t frame_dma;
 	struct xsk_buff_pool *pool;
 	struct list_head list_node;
-};
+} __aligned_largest;
 
 #define XSK_CHECK_PRIV_TYPE(t) BUILD_BUG_ON(sizeof(t) > offsetofend(struct xdp_buff_xsk, cb))
 #define XSK_TX_COMPL_FITS(t) BUILD_BUG_ON(sizeof(struct xsk_tx_metadata_compl) > sizeof(t))
-- 
2.47.0


