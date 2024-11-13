Return-Path: <bpf+bounces-44768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C709C7894
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 17:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A843CB32E31
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 15:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE172139A7;
	Wed, 13 Nov 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gy7gHIo+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E741922DB;
	Wed, 13 Nov 2024 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511555; cv=none; b=EVBo8QOGbOQpiYNfTf9KohXLu2C1FhWQIrR9zFAPqyFn3I7sel0gVpY6DtOkWhuVT4kfHmc68G+Lw66HemNkmOsrxiwtAw4NC2w8skHNsPGAht+WTgoL6ZiIHuBG3gKIoilMIrMJG76TB6xCLFOsu5JYcNboDK5Xb+vXly1r6SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511555; c=relaxed/simple;
	bh=e5HN06V8sUAbvrE1VRjupxomFxjPnp1tXPPH+D4Q7ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8PIkJzEpS21toqxiH6jAckyYBCv7VV9lSVg2a70UuO77iTN4I6xxLRAM0aBqrwg2gj06LZ5vjbUemHESTP6sehkjrkcf5jbdCL2DM1fY/bE7CvOwtAF/hfE3WZZGFHiHWy2OUC+0RJiYxd6cY+7Edh+zR27l15onWEsOi8nqwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gy7gHIo+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731511553; x=1763047553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e5HN06V8sUAbvrE1VRjupxomFxjPnp1tXPPH+D4Q7ws=;
  b=gy7gHIo+WyO/Tv3x50tEtGpF6QztspifnMFnYcjORlKnicFQH2OYKO7U
   4PC7+wsqLg7E0G3Kf4+KcVc/eUOYVSgOPy2vNB2WjZMhnPaC/axtWkk09
   n/XEQ/XJg6ytPfqwJQLShH4siYOjZPdIdfo5JVt5p2qHaXzw++mGwpteA
   xSB2k7iaP2ss1OSlU01lkTZhJnADGvdc4aMSK/XOKZ785s67Z14jq+yuo
   IdpPT3V8KZhARa8LAcbNi8yY4RjoptkAv7s1Hj9vh0n8b7uXqSoWFOPuu
   J9vyaDg4b1RKnZWqg6QVieVHe2Bg9NmfjLBnAjgHLxu+6cAOmt9itFrdA
   w==;
X-CSE-ConnectionGUID: 3kZB5DeUQuiSQfZ92qRSBQ==
X-CSE-MsgGUID: smLTX4k8QPyRQlPy7I+TLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42799380"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42799380"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:25:53 -0800
X-CSE-ConnectionGUID: R/0IYwoHScylHyezcLBMCA==
X-CSE-MsgGUID: 2omnfMMLQNawmbGzOg2blg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="118726976"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 07:25:49 -0800
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
Subject: [PATCH net-next v5 13/19] xsk: align &xdp_buff_xsk harder
Date: Wed, 13 Nov 2024 16:24:36 +0100
Message-ID: <20241113152442.4000468-14-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
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
index 3832997cc605..50779406bc2d 100644
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


