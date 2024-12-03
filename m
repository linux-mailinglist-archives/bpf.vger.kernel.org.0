Return-Path: <bpf+bounces-46018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FC99E299F
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 18:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A137284E2E
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 17:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4341B1FC7E7;
	Tue,  3 Dec 2024 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7J/foaZ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B4A208962;
	Tue,  3 Dec 2024 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247675; cv=none; b=Tmazl5NGuoFAdeBsc9HE/yUnRHCtROrxb4JB5CZ9M4JqtCAr2J02Se8we/CUdl6hUM6oZw4QlmxP7cxERV4q9fO6pc4plwZdJiVlQLYvlcq+0+RKkSSTBJUONDG94+LtXHdGdwln512VIpC2qJIjyq7RY7XifI952X3nO5TAIZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247675; c=relaxed/simple;
	bh=bT/ZjpZysaG8idIDTbTorC5vwbYoxDtyjavkpNP9R0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMMt8lO6QjQ4d+cMGY7S2yZkC+kP04ZpBD3snQuCN2RjpE6ozxoltnQDu/YBRczJOUKT1OC59iJ+JkNvbo5E5N4oH1jj6ye2LzNQXm+wNaiH2Us1dye6KjJEWpy6ZB9+4ke/biHczMQj8nbz+d0X/LUhRN9r3OPKszlVHrejEj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7J/foaZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733247675; x=1764783675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bT/ZjpZysaG8idIDTbTorC5vwbYoxDtyjavkpNP9R0k=;
  b=b7J/foaZCmEDBonrZozRhl++EOkvZi5jVHztz3wBeQ+5dNgN7bpDPGxD
   Hll/ZXkfVn1+cY0+Z2h9bqdD04dZnHfYkP8KcCXKPd27/MjYaPGxQORLT
   mq/dJsN/lAOcnd5NGBJQZNJ1FO9DB1yNJfG+7lhjg0ncookKyNYbcG3lc
   ypNbfgPY4yPpsnC+N/XV8jczSMQp/WHzUql9D0ZTWZFF1xW3TAbpi4Opy
   g/UfeqyfF4r+fXjxaeredpn4cEMAJ9G3cATYPyydYwkynNRPu6NV2Vm6E
   WFDtf9PDEPn6nJEGnqa2mHqqS2RsuozCl/z7BzYeosXM0ooO7XLsqm+Rg
   g==;
X-CSE-ConnectionGUID: Vl8p7t0hRgaj7ZWDNa2qLA==
X-CSE-MsgGUID: FGtg1DwFRnmWQdUWvG6Ddg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37135369"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="37135369"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 09:41:14 -0800
X-CSE-ConnectionGUID: eTRghUMZSEKTE27uNOFB8g==
X-CSE-MsgGUID: ECBo35XKTcOXBlFs4mEYdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="124337032"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 03 Dec 2024 09:41:10 -0800
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
Subject: [PATCH net-next v6 06/10] xdp: register system page pool as an XDP memory model
Date: Tue,  3 Dec 2024 18:37:29 +0100
Message-ID: <20241203173733.3181246-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
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
index ecca21387a68..d1a8d98b132c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3322,6 +3322,7 @@ struct softnet_data {
 };
 
 DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
+DECLARE_PER_CPU(struct page_pool *, system_page_pool);
 
 #ifndef CONFIG_PREEMPT_RT
 static inline int dev_recursion_level(void)
diff --git a/net/core/dev.c b/net/core/dev.c
index bbb456b86e8b..b93dba1e98ee 100644
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
@@ -12146,11 +12146,18 @@ static int net_page_pool_create(int cpuid)
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
@@ -12284,6 +12291,7 @@ static int __init net_dev_init(void)
 			if (!pp_ptr)
 				continue;
 
+			xdp_unreg_page_pool(pp_ptr);
 			page_pool_destroy(pp_ptr);
 			per_cpu(system_page_pool, i) = NULL;
 		}
-- 
2.47.0


