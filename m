Return-Path: <bpf+bounces-41432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC0E997010
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 17:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA3FB20DFB
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963311E9077;
	Wed,  9 Oct 2024 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/bJcfFj"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04121E9066;
	Wed,  9 Oct 2024 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487768; cv=none; b=ZjrtcNvjt8RjfAHNqY0UE96G2ldx7ECgz3H92J/klVI54t4xdNEMAZQ2egNzzzKXI6Ji795JX1EbPyTKcGf6JIvAg2AlmcYnlILB48ARDRRAqms3i4XPJkGaKmgR3L2qRTVaxdHb7qySBzrjNlJ5ezhid9AMCPtsUpDRAqccopY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487768; c=relaxed/simple;
	bh=+8ZSgV1rvwP712o96If3RIbWx7f/0uNCZVHC70PupoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwLnm4mWLhIl7u7hGfZPZ4aLHkPkTeZVNsgDqNF2Db+PJBNlGQS8LfYaEsRIvOZctmiOUaoq9ryeuYXpJtmpLigLHs3O38mi9Q0t2LTbKUtDMPqcR6gMG4YT9t/5bbtVirrGZUhgcMi0ed1LcldOIwqYBv9GkTKm1f1FEvpGfwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/bJcfFj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728487766; x=1760023766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+8ZSgV1rvwP712o96If3RIbWx7f/0uNCZVHC70PupoE=;
  b=R/bJcfFjBzyk1YeBfNOlGNHiwwAJ3qLoH2X2Jl2rXBQwylkXPLrdr/h1
   bQ3eLEpLTKM0nS8ZwrIoqQhkHxup4rGG3PChQAEdR8+Vq/QdCYTJDEjQc
   Vre/J2EZj00HD6b7tF4O2C8TADi+iJEIxypS7a33iZRCA1gy+1MEyHUcX
   gA+IKqX0d5qxEkGBnGgB7IPoUsgBmZhiupehKGecvpxB7Wk9EwQTifaAu
   jPf0YrueD9eYNdK5W/KN7GyL5PKGZn56Z5nf5YdWKSSh0gMzcjNy+3b8S
   rLtUS3heQXlZ2zc0o9+zpQ6uXbhcUCNiqFZ66UXad42vvA7tSiay2Gyru
   Q==;
X-CSE-ConnectionGUID: 8aFUue/hTVCf7D9djwkc/w==
X-CSE-MsgGUID: irV9IdMLTKmxnUxSCSgbQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27675833"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27675833"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 08:29:26 -0700
X-CSE-ConnectionGUID: KqNd4tgARaOvLDBKkqTTaQ==
X-CSE-MsgGUID: 0jxynQ2tRy+cdxXusK/bdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="81306025"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 09 Oct 2024 08:29:23 -0700
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 13/18] xsk: allow attaching XSk pool via xdp_rxq_info_reg_mem_model()
Date: Wed,  9 Oct 2024 17:27:51 +0200
Message-ID: <20241009152756.3113697-14-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009152756.3113697-1-aleksander.lobakin@intel.com>
References: <20241009152756.3113697-1-aleksander.lobakin@intel.com>
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

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/core/xdp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index e5395048a925..1cccc00510ff 100644
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
2.46.2


