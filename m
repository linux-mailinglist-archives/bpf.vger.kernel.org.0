Return-Path: <bpf+bounces-44260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9D39C0B37
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D271F24175
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 16:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EB021895D;
	Thu,  7 Nov 2024 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJYxys3t"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DA82170DA;
	Thu,  7 Nov 2024 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996056; cv=none; b=ThXq4tUsK4ziC8ACtr6fUn9NQ4opbR0LgbrQ6m8oTVhuyTaipWv35UjoV9vXC6BfxckiTblqziumqNfABCIMW9z9JkGpPv0Dyb13PHaFhwvAr54XXJX5zld8EP5PYUAW3hvRJsrfXHeLZvKPdpJPFeVLc8aAodIGAAzIaqSOJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996056; c=relaxed/simple;
	bh=lzQozJnxc28M9tb2kFcVPKTtrPiOExOwKLdH2/fwo/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTEpq7qAcbY7Qi+DI2OAzBjjsV1pnE97wh0XsR8+DyhwAl56L7jcpOQIKR8KVwignpn+8NBIpXrU135jJZlS3y+m1fmrT/BbLbzg1+Wu17G+pHMDmi9AMpTeSAuufYFlzc7tm3YCfLdodqdXCCMe1y91oMlp57gp+yIxCbQjA30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJYxys3t; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730996055; x=1762532055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lzQozJnxc28M9tb2kFcVPKTtrPiOExOwKLdH2/fwo/k=;
  b=dJYxys3tZBtnJMg3v55XawUtvfVdupEzhvLlGJyqayU6P0yv0RmmUSPh
   kuat+IuCsGdJSPuUM716G5D7rTnIletBkEoVb9cr7g4rzDa2dtLhBPQZH
   XUaI0ATUPtzCvpNuyvk02zWof2JwZBBHaotNq6kxEeyAQgRe6xKAn/VHD
   35lVXsGpDi/glFrFkvBE17BcuzxmInnKMDeUectp8GRyzWl8zGGMun7xF
   axqhGJ6FQCrZ9JL9bsM/LZECKwxMcfd4Imx9H18zW5ic2or8oL3cPKnkb
   tnhZY8/hH0Zz9RQDN/Fw9ytdpay32ynw5sTdoD+pqqcTo9TSS4aL2mZHz
   A==;
X-CSE-ConnectionGUID: SPXtEJK5TAOOZOn5KAp2SQ==
X-CSE-MsgGUID: h2uNqxAeRJWm27G+kIv70Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41955883"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41955883"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 08:14:13 -0800
X-CSE-ConnectionGUID: 8Gvd+4jDTQKLKErRsJYzJg==
X-CSE-MsgGUID: agFYNRTHQY2hXY8K2BT/Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="90258196"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 07 Nov 2024 08:14:09 -0800
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
Subject: [PATCH net-next v4 07/19] xdp: register system page pool as an XDP memory model
Date: Thu,  7 Nov 2024 17:10:14 +0100
Message-ID: <20241107161026.2903044-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
References: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Toke Høiland-Jørgensen <toke@redhat.com>

To make the system page pool usable as a source for allocating XDP
frames, we need to register it with xdp_reg_mem_model(), so that page
return works correctly. This is done in preparation for using the system
page_pool to convert XDP_PASS XSk frames to skbs; for the same reason,
make the per-cpu variable non-static so we can access it from other
source files as well (but w/o exporting).

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/netdevice.h |  1 +
 net/core/dev.c            | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 201f0c0ec62e..943945702ac6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3305,6 +3305,7 @@ struct softnet_data {
 };
 
 DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
+DECLARE_PER_CPU(struct page_pool *, system_page_pool);
 
 #ifndef CONFIG_PREEMPT_RT
 static inline int dev_recursion_level(void)
diff --git a/net/core/dev.c b/net/core/dev.c
index 32dd742450b6..bc197c405a88 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -460,7 +460,7 @@ EXPORT_PER_CPU_SYMBOL(softnet_data);
  * PP consumers must pay attention to run APIs in the appropriate context
  * (e.g. NAPI context).
  */
-static DEFINE_PER_CPU(struct page_pool *, system_page_pool);
+DEFINE_PER_CPU(struct page_pool *, system_page_pool);
 
 #ifdef CONFIG_LOCKDEP
 /*
@@ -12107,11 +12107,18 @@ static int net_page_pool_create(int cpuid)
 		.nid = cpu_to_mem(cpuid),
 	};
 	struct page_pool *pp_ptr;
+	int err;
 
 	pp_ptr = page_pool_create_percpu(&page_pool_params, cpuid);
 	if (IS_ERR(pp_ptr))
 		return -ENOMEM;
 
+	err = xdp_reg_page_pool(pp_ptr);
+	if (err) {
+		page_pool_destroy(pp_ptr);
+		return err;
+	}
+
 	per_cpu(system_page_pool, cpuid) = pp_ptr;
 #endif
 	return 0;
@@ -12245,6 +12252,7 @@ static int __init net_dev_init(void)
 			if (!pp_ptr)
 				continue;
 
+			xdp_unreg_page_pool(pp_ptr);
 			page_pool_destroy(pp_ptr);
 			per_cpu(system_page_pool, i) = NULL;
 		}
-- 
2.47.0


