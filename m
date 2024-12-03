Return-Path: <bpf+bounces-46017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEF59E299E
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 18:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897BB16A1E0
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 17:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A7F207A0B;
	Tue,  3 Dec 2024 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IaqzKq5h"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C9F1FC0EC;
	Tue,  3 Dec 2024 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247671; cv=none; b=bk4x5Fh4+/nH9m6/x9kKPVylDEnLSo9GM1oMVTJmRGUEwfe36UtdmJg5OeZ6g7l7ZUWNVb0uJDLBAaqSvDa1SxOnZfhPQ4d3a7bAOew0sT24QVp7cKiN9jMU0a6gDa61486dzxdzcX8wYpkb8PQwHW5xuiJMrBe91jYkeaeDn7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247671; c=relaxed/simple;
	bh=lFVljj64h6xU3WRZp8bn35AIfB3HeBx8boL8YxgOD4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdvOsoxtbEZtk8RlD8CMUA4455/HJ9slNm3UNJ/BHj41jnrqmErKjI8NOc9E4ywQ6iKQPC5zPgaK+S7Eh1A50SfUbBldDs+k9p1P482wx7VRxPWJBxQS/SsFqRa7dPDs/S0t8qbpUp14pNSauAbe6wf8qiWwgxj+3SfWTWH2iKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IaqzKq5h; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733247670; x=1764783670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lFVljj64h6xU3WRZp8bn35AIfB3HeBx8boL8YxgOD4s=;
  b=IaqzKq5hf+596G6IvtWJQu0ITuH3OBQgTFbk35DP8YAnXm5g50vU3lDq
   fc6jTm8tTaBal5lJKefrO3M9GKEvOHxU2uu6dBiQAIzq9ESnXk688Riha
   yRtE8hArv6qpB9rJZgThmi4cYZFW5e/lV8bD+kP8xc1DK8LRkDCYxtVQb
   WR+P7242teOYhTrA2s11TU9SEjSN3YsdeJOH236e8Xky6Jbl0Lt7yJPy5
   H8svZCnUf2Ohydri0SwKJA0ObRNKsycoX9TJ21TfOYFH5SkhhVsnqvfPW
   X7R3zFbeHrTzsBuUoaJwTPYXIL6ro+A5eVXkU72bY1hhYx0KYok2w5Noj
   g==;
X-CSE-ConnectionGUID: GxJro/2xSEyfpNxDIvA44g==
X-CSE-MsgGUID: ItQTlhExQNiNc0JIe63qag==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37135344"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="37135344"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 09:41:10 -0800
X-CSE-ConnectionGUID: Kpn848ABR/CeVe3WwbsK0w==
X-CSE-MsgGUID: wmDhvKtiQ8ua+PJEafi0wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="124337029"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 03 Dec 2024 09:41:06 -0800
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
Subject: [PATCH net-next v6 05/10] xsk: allow attaching XSk pool via xdp_rxq_info_reg_mem_model()
Date: Tue,  3 Dec 2024 18:37:28 +0100
Message-ID: <20241203173733.3181246-6-aleksander.lobakin@intel.com>
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
index 885a2a664bce..de1e9cb78718 100644
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


