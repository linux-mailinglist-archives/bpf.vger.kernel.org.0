Return-Path: <bpf+bounces-38575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4612D9666D2
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 18:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D8A283DDD
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 16:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CB21BD4F0;
	Fri, 30 Aug 2024 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RerfOeeh"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E14C1BD00B;
	Fri, 30 Aug 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035166; cv=none; b=ly1frr9g5tY/+0HiS8W/LWYNv2UKR91/mSv51GtK7VsjjAppxKTvJkpR3zcspBlxSEFDkil/d/RrqvkMcGiVH6I3HeYTAyRM6GjlYC+dv+f75Gb/6p4spCoXoEsEQX4jv1eRt58WLe0miRJdafsW/stCHZ16/kOiGQbRPIEh4cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035166; c=relaxed/simple;
	bh=j2+AZk0CsXXjVOjOXZCdGaih+ir0sDyytVAQE5WUi20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/TaTtQb8WOrHXrEIxjaCQkXmeMDb3rxlIOJf+3mpqFV3SVh49ARLE1HdkmT7Z0Ymd3gS8OokLkgzFPprGwJv+ymd25XjxhBTeEKD00pdx6PKnqRcZzDsGEJS+o44DUXRT+R7fZFDbaM+PP3QjdVmIYsTXfrcX8oki7+8n5NsZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RerfOeeh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725035165; x=1756571165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j2+AZk0CsXXjVOjOXZCdGaih+ir0sDyytVAQE5WUi20=;
  b=RerfOeehav4Al0LLZaTEyznoItXQ4wEQnWfWNh+gjDmLlhDzjAktgN+K
   7aAJoh6g5gckiuuw0TwAJyhFE5ffGc1j0HtFCQtjEXjdMnVudjhuMb/B2
   JkrZWlCHfjMG+c2IcCRUmR3WxycT4PEsuObYZbb029Ct5uZGhEBWz06ZM
   48qwcrq/Od+CKkI4OY088QS/feVyD6tnQB4BptiadX17VppB5W01nrttG
   dpthgYBrVczTeppYZYxszo/7Jw0csKwaoyR1t8d1aoROLsqjP9YOXWWEO
   Ax1Scj2azIeaJUfk/b0FNOdJC3nrVETG+TlnmvIYwOga2Li2m3ZMMirVo
   A==;
X-CSE-ConnectionGUID: cPk3HRwuSKODHnPYxNwmmw==
X-CSE-MsgGUID: LDdpWjg5SwScA30/9jfAfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="49068975"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="49068975"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:26:05 -0700
X-CSE-ConnectionGUID: HDToTPshTM65WgoCtd7RVw==
X-CSE-MsgGUID: if0gYkwKR8uHL2UIvzn1Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63996487"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa009.fm.intel.com with ESMTP; 30 Aug 2024 09:26:01 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 7/9] bpf: cpumap: switch to napi_skb_cache_get_bulk()
Date: Fri, 30 Aug 2024 18:25:06 +0200
Message-ID: <20240830162508.1009458-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that cpumap uses GRO, which drops unused skb heads to the NAPI
cache, use napi_skb_cache_get_bulk() to try to reuse cached entries
and lower the MM layer pressure. The polling loop already happens in
the BH context, so the switch is safe from that perspective.
The better GRO aggregates packets, the less new skbs will be allocated.
If an aggregated skb contains 16 frags, this means 15 skbs were returned
to the cache, so next 15 skbs will be built without allocating anything.

The same trafficgen UDP GRO test now shows:

                GRO off   GRO on
threaded GRO    2.3       4         Mpps
thr bulk GRO    2.4       4.7       Mpps
diff            +4        +17       %

Comparing to the baseline cpumap:

baseline        2.7       N/A       Mpps
thr bulk GRO    2.4       4.7       Mpps
diff            -11       +74       %

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 kernel/bpf/cpumap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index d7206f3f6e80..992f4e30a589 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -286,7 +286,6 @@ static int cpu_map_napi_poll(struct napi_struct *napi, int budget)
 	rcpu = container_of(napi, typeof(*rcpu), napi);
 
 	while (likely(done < budget)) {
-		gfp_t gfp = __GFP_ZERO | GFP_ATOMIC;
 		int i, n, m, nframes, xdp_n;
 		void *frames[CPUMAP_BATCH];
 		void *skbs[CPUMAP_BATCH];
@@ -331,8 +330,7 @@ static int cpu_map_napi_poll(struct napi_struct *napi, int budget)
 		if (!nframes)
 			continue;
 
-		m = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache, gfp,
-					  nframes, skbs);
+		m = napi_skb_cache_get_bulk(skbs, nframes);
 		if (unlikely(!m)) {
 			for (i = 0; i < nframes; i++)
 				skbs[i] = NULL; /* effect: xdp_return_frame */
-- 
2.46.0


