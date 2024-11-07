Return-Path: <bpf+bounces-44267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 523EC9C0B4E
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F6C1F2159A
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB8A21B425;
	Thu,  7 Nov 2024 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMquTBkn"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDB321A70D;
	Thu,  7 Nov 2024 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996081; cv=none; b=pXPRkny765jATgJP9BtV9ESWMfzHzwyuv4DslS22rEgDfktmRSAuFn33sozPss5q16OAYzBRoFc0nw+sjwCHjCqYMVIGEhH4ULeXOHcPaHTlcXSXffgYKMWnoqr2ezMMniywolIG/NAy5WOoywm2OWU7E7YK6fPMu6Hcwm9T4+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996081; c=relaxed/simple;
	bh=O+ZcPvQeQyS8JRU5HG6GQbO8AhKShZuu+h1CEOZZVdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cop8tifr7NLuzCBD8VEdCd+NrlzqP86h3CYk2o5awdzk9g2rfhUhPZNR3S4QpoTOfRwLAoIMm6ex6Qgzf9yWOuE8dYmeXYV96tsH1NFrAT6JexpyRNkizBIUbJvZb3MK0h5m8nKSHc0/5p/iAmKQbTX/Q3c9qDqncI+oxApCbsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMquTBkn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730996080; x=1762532080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O+ZcPvQeQyS8JRU5HG6GQbO8AhKShZuu+h1CEOZZVdA=;
  b=XMquTBknt3gAcGmCVG2/qX0DnExdRLCj4gHKp0VCUYx+lzTH5evGgP4Y
   NtqIQ2rUln0tdD3FauTig4efbwJNaNxCKm+/1Lheq8U3zLa18wqA23105
   UYz/d5+8cCGEpk6uHdUpI1sFpHeC5XqU+CQxlYYnBgkfzuV5wJFdecp9s
   +UFRWeV+/a2wmNqf2yoHVasX2z8iBYjTsYz7z0uZ33Iji6jSszS2hYj1q
   kYpvXVi0mYm9K3bVTIiMfJuwqHwB4k7tc00Q/DYew7lxDAtoEPqFcj3Xn
   1FAyIozW2UBhuD0Z3uD8GIg4HhKX5tu+75VKwexid5LZ/5BZ5BttChCr/
   g==;
X-CSE-ConnectionGUID: pfOEJJiTQ7eWzMNF+kIF8g==
X-CSE-MsgGUID: AfEH44APQ6GfihRLyjItBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41956029"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41956029"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 08:14:40 -0800
X-CSE-ConnectionGUID: J22vuX5pSrOos1EmwJeE9A==
X-CSE-MsgGUID: O53xNgItS8SGVtlfKcpHDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="90258236"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 07 Nov 2024 08:14:37 -0800
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
Subject: [PATCH net-next v4 14/19] xsk: allow attaching XSk pool via xdp_rxq_info_reg_mem_model()
Date: Thu,  7 Nov 2024 17:10:21 +0100
Message-ID: <20241107161026.2903044-15-aleksander.lobakin@intel.com>
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


