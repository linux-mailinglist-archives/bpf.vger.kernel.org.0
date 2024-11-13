Return-Path: <bpf+bounces-44769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBFE9C773F
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 16:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423951F28B9C
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7712141BC;
	Wed, 13 Nov 2024 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBBGM+bV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2E42141AB;
	Wed, 13 Nov 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511558; cv=none; b=jghuYz1cSnzrxUCnXGety9H5GSuX5R6rPawkPVbREf/3dSO1asTn4KdQufXI0vlw1GKq/BQHTIO5mY0ZJY6OgfAZ/RnpPC8RiE+pHFPfH7PbMH2CDJpEK07iNmXR2V11kcnqiiPdJzTT0NCgvy0wfV5fBGsJiJ29S1/16ZAMW8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511558; c=relaxed/simple;
	bh=O+ZcPvQeQyS8JRU5HG6GQbO8AhKShZuu+h1CEOZZVdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AoEJPTS466/OcdwAWoKClH60QAKUrWdNM24qMpGHk3puWNoWySHMnLkz18o3+ZHrsUryn7kSF3Eo2zgNWB2IyyucW7ay8zJc0Tbj3+dlq7CRb20fVOiTlL1eu3xp9ubIKqKLDSoaahLYBAn8RZJht9uTKcVheVGpHu+TRTM0Ooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBBGM+bV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731511557; x=1763047557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O+ZcPvQeQyS8JRU5HG6GQbO8AhKShZuu+h1CEOZZVdA=;
  b=OBBGM+bVIRMqbOmx01oFo9TjcOqebmDsynOtQkMBqVjkItD97Mv7mKZG
   ZOpc27FrBBa1LLM839nqhteJJbgHbNcxRZ8XmANl4KvyqmKrRa7oeeI5M
   kvuZ98zJFjEwJs9kD46RMPO1iCpWpE4SxrXHcfcB9AyrHLfAQWnTLAtbN
   YO8r1IVRRPogjqsoKDR4xbGni5f/4Iqzxtw1j5kG9VltqMi5zPsPh0/Io
   D1SDdBplgGVIKy0r/GIIzObwNCuR4W0YwwJ+dqUrgG2CG5PCzC9X+pCsu
   MjZXtIGUEEOrtSU5FzmE4+ArLQBEfcK2rOoQ6pZv3OGL6Yj7/mXT224YU
   Q==;
X-CSE-ConnectionGUID: zuq32msRTKWI/n0/S3o43Q==
X-CSE-MsgGUID: Bg5BdTF5RPu/2sz99S0Fqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42799401"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42799401"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:25:57 -0800
X-CSE-ConnectionGUID: HrWfWtebSxGxqAaF9sShxQ==
X-CSE-MsgGUID: OP1VQ0G/SM6eP6DbQ1jVyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="118726991"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 07:25:53 -0800
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
Subject: [PATCH net-next v5 14/19] xsk: allow attaching XSk pool via xdp_rxq_info_reg_mem_model()
Date: Wed, 13 Nov 2024 16:24:37 +0100
Message-ID: <20241113152442.4000468-15-aleksander.lobakin@intel.com>
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

When you register an XSk pool as XDP Rxq info memory model, you then
need to manually attach it after the registration.
Let the user combine both actions into one by just passing a pointer
to the pool directly to xdp_rxq_info_reg_mem_model(), which will take
care of calling xsk_pool_set_rxq_info(). This looks similar to how a
&page_pool gets registered and reduce repeating driver code.

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/core/xdp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 3a9a3c14b080..f046b93faaa0 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -358,6 +358,9 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 	if (IS_ERR(xdp_alloc))
 		return PTR_ERR(xdp_alloc);
 
+	if (type == MEM_TYPE_XSK_BUFF_POOL && allocator)
+		xsk_pool_set_rxq_info(allocator, xdp_rxq);
+
 	if (trace_mem_connect_enabled() && xdp_alloc)
 		trace_mem_connect(xdp_alloc, xdp_rxq);
 	return 0;
-- 
2.47.0


