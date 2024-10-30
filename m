Return-Path: <bpf+bounces-43579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 180289B69B9
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 17:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D066B2813E3
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 16:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730C921948A;
	Wed, 30 Oct 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxKuoxEE"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116F218D81;
	Wed, 30 Oct 2024 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307241; cv=none; b=dvqPiK7HWmBMJiv5Xi5sxKrPxUogXzh9Kf5xGKuCl6Ab0owTONV51f7bwVvv4ShVOSYzDxaJkuMi5KL3b1IMBe9H6dATPNJCu+1NWdhzPohm7OM/RqODrsCoOpZ+wzWm+TsTPeF4iaTAB3inih/NV48381fMRsjotYkwS8eLbhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307241; c=relaxed/simple;
	bh=V0rf6LyOgxlvXHIs5UXsPwHDyLTya4oWuYU5lGC91sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCoLbCSf9d5e4PcAaeYV9t5c+NQZPQjvDZUX3C7E+aVEohkySltGgRIZLCyzUW0BWGgQaKGfmbROP9K76cE8cM1SukW8oMLSNz+L2MMAfFx5j0nsb8YfcyaNQ6wc9MPU3B+7h5bGIiL1zTZW6ASxeEO9EdqkgKaMm7Dfugzt29U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxKuoxEE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730307239; x=1761843239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V0rf6LyOgxlvXHIs5UXsPwHDyLTya4oWuYU5lGC91sA=;
  b=mxKuoxEEtuMGqpDelJXBHFDGWkD8iHbYmcalz34Er2Uz8+R04y0fwaY2
   gnTq4P8RE2fanF1j1x6M/nA6EQcMy24uMJWNmpLTVsrZABnqsgLysnV+O
   UwCNwjfhMbmwQbiGk1B3xEJeF+2s2UrudgwggFhbHi0Y8N/MuUcwKkoId
   yCHzmHz1QBWQqLiCQ3vnxrmbYpqgFupFsSKTPn7OUZDt/GSzU5ZdaM68/
   WubpcvjhiIpSvTrrzLLwP3lHTtxK3+agh1pilcK2fu+btdh9zNCOsXkeV
   w8E/zoZsa11RrYhFLsfAwcgRsm9TYQtQQFdfULo/Vw2NwYEuISpT0/jaG
   g==;
X-CSE-ConnectionGUID: uJipL4F7TjGU/sthC/sIRQ==
X-CSE-MsgGUID: 7WUMsHMtTNa4vyUkMkj0pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="41389706"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="41389706"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:53:59 -0700
X-CSE-ConnectionGUID: kBtaywZhSeeoCulfoNni9Q==
X-CSE-MsgGUID: Rt3WLeoRSX2ROSnYc6HqCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="87524505"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 30 Oct 2024 09:53:55 -0700
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
Subject: [PATCH net-next v3 07/18] xdp: register system page pool as an XDP memory model
Date: Wed, 30 Oct 2024 17:51:50 +0100
Message-ID: <20241030165201.442301-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030165201.442301-1-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
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
index b857abb5c0e9..773388f26d4f 100644
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
@@ -12103,11 +12103,18 @@ static int net_page_pool_create(int cpuid)
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
@@ -12241,6 +12248,7 @@ static int __init net_dev_init(void)
 			if (!pp_ptr)
 				continue;
 
+			xdp_unreg_page_pool(pp_ptr);
 			page_pool_destroy(pp_ptr);
 			per_cpu(system_page_pool, i) = NULL;
 		}
-- 
2.47.0


