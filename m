Return-Path: <bpf+bounces-44761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6769C78F7
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 17:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC01B3FAB8
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 15:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A6E20513F;
	Wed, 13 Nov 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hrQRAaPf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCE7204010;
	Wed, 13 Nov 2024 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511534; cv=none; b=iGcSPaOAPK4eArHxkGB9kSsbz4dXtoQm8jZxwXKWU1Df4sUCkH91uSBWkzh8+cm9530XfoVvBk7An90borriEssFruyRmHYJ5y4Ewkj5WKVOnYUG4uMFMeepirLtEl/hObWIJnXvpUoJ4Z0NMHbZvTBmrIMXAE2V5oM9qx64Y+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511534; c=relaxed/simple;
	bh=GzdaUQNQXC5qpa9+den8MiBXV9SF+151fxr4rWPgzJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSNSeLFr1LTha32g3kDmgHwRmUWsa6iGrafRKLRL5V2OYT3gP1xYdWTE93Scjbqu+ewNXYTQOCs23TZadixdQ3EOLCFZzGNX9vHh3JJLTE89+LKnY5fPA8BzFULLcZP7eRMzLYfvqARQ+4xacDQc/e2GchyVJxEgBacjImBkUcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hrQRAaPf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731511532; x=1763047532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GzdaUQNQXC5qpa9+den8MiBXV9SF+151fxr4rWPgzJE=;
  b=hrQRAaPfuBDKgI8wwGkYXmktLlWvOeL/JeUqzpx8EA9irl0VJd+CObwo
   jhxAPIUQ0nOlHbwGDzpHq9LDQQKcMv1NVrCHVvJXLQM79cJZ+oHKd/woo
   sWSDtvuxGroEJZFuTRYrImnTlyxmYY0ylSSjFltSyNOMr6TfGK7rE5AVn
   vgGgeQSKtDpfgMc15Ce7lg7qjdY+7IGVQZ+CMChKqBYxWn3EcNq+ZwTCx
   +b8oyIU0cVbEJ04rdYm8UWTv8fvFWd9E2SIdfw1aUE/fdu0R2a+O5tJhY
   3yHEIACzscLWSteup6qAqdl7VnqLm3HgPz+5U4VckmHtybi92oZB043nd
   A==;
X-CSE-ConnectionGUID: cKvUMIdfQyy//B4NrWSWhA==
X-CSE-MsgGUID: VI9getdyRpOQUQ/Srr9WWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42799314"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42799314"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:25:29 -0800
X-CSE-ConnectionGUID: 6qAqH9K5S6GzYcipcNO4dw==
X-CSE-MsgGUID: c7rT8FCYTHK+VnGbaMVBUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="118726920"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 07:25:25 -0800
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
Subject: [PATCH net-next v5 07/19] xdp: register system page pool as an XDP memory model
Date: Wed, 13 Nov 2024 16:24:30 +0100
Message-ID: <20241113152442.4000468-8-aleksander.lobakin@intel.com>
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
index 42715e1b9220..87fa2b6b565b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3314,6 +3314,7 @@ struct softnet_data {
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


