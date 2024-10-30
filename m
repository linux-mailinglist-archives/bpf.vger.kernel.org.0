Return-Path: <bpf+bounces-43585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD589B6A0E
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 18:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A66282BD8
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 17:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171CA22EF3E;
	Wed, 30 Oct 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5Ei/TQw"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE8B22EF12;
	Wed, 30 Oct 2024 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307264; cv=none; b=MQsObsOTg5Ttcy4fXCuEnBpVeZgMX5IcmNUhamWYyZsgbxzsAyQ4wWR/kL1liLjewSU2CaC1qtAtkyFZj5fw+D4UqU5oe2zSDusD+p9yy2xW4jQq1GTrtxRa5Si30kMg3ilbx62aq5y6G+pn0xYBJ8AAkk4v9iNja2eJBfQdoaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307264; c=relaxed/simple;
	bh=OfFIbPRNu6BPOsagH00LK15AYtH3eRKScfEXeOXVBS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kz8P85ISswjYHsm5U1mZr8VqF//3POzlhO0AAst1A1qK/5xjKXNb4GM5Uw2wwFnkgRXtT138yGwTmoyVV8Hx+OLWxizIELHOKeIu2muLYlCbePDVtwD90X+tCX0Cf+QeO72FsGpRUMG2ATAWjA1n3ovJF4hZeXLRdAquWZJdL/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5Ei/TQw; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730307263; x=1761843263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OfFIbPRNu6BPOsagH00LK15AYtH3eRKScfEXeOXVBS8=;
  b=D5Ei/TQwjZvEb5Pcb/I2L6ESFJlquH6c3PgJa+Ip5pGp1qIhs/OntcDN
   jZXVPntOdu3z7i2iCDBl4cYgvaPfI9DuxtMYRv8TF3YB4INW1/wre9/OU
   o/p6xRZQICHX8qIt1JdkPN7s9q+u7t2ZtoTy6qwk0SUZ8/9cy2QE9mae5
   SYzbkhgNuUY7dI0h7zvWfgXjQmtXT45YHz/n9iqcYyXgJP4xQ2Q8x6s82
   8NwN4JGp8MinLM3HsORkA5mzbN3CSeOeuOjY71GH9dxbI650g/ax19R4A
   hKJlXl4WLqRkjLjsxYQIuf8GlWkTyPbC8w1fTuIjKAD+t0OrUAfGSUHZg
   Q==;
X-CSE-ConnectionGUID: GKqcObrlQfuuP7cWPgzxPQ==
X-CSE-MsgGUID: SrpWvPZETJuzkvLqGIR0BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="41389808"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="41389808"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:54:23 -0700
X-CSE-ConnectionGUID: r4UvfBPSQre/DFhvy3WJLw==
X-CSE-MsgGUID: YDLxLn3NSTyH33m9UnAHOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="87524541"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 30 Oct 2024 09:54:19 -0700
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
Subject: [PATCH net-next v3 13/18] xsk: allow attaching XSk pool via xdp_rxq_info_reg_mem_model()
Date: Wed, 30 Oct 2024 17:51:56 +0100
Message-ID: <20241030165201.442301-14-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030165201.442301-1-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When you register an XSk pool as XDP Rxq info memory model, you then
need to manually attach it after the registration.
Let the user combine both actions into one by just passing a pointer
to the pool directly to xdp_rxq_info_reg_mem_model(), which will take
care of calling xsk_pool_set_rxq_info(). This looks similar to how a
&page_pool gets registered and reduce repeating driver code.

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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


