Return-Path: <bpf+bounces-47261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E315B9F6C89
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 18:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF3D1894A49
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 17:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2131FBEBD;
	Wed, 18 Dec 2024 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JOC+FWqb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1541FBC85;
	Wed, 18 Dec 2024 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734543927; cv=none; b=EsHrwMdEZBuRk2RrZfgSyINsp+jsyBnRXicL3hX80i6etD3WlcsrPCpKTu1yflyxberoI6IM7OhDBjMLGxEB/s/1DMKlV8vC6+RGQwAoVoGeOPnhjJf1M+eccO61wsiB9fBlhWrA4TQUx9XbMGe+BGZlzNIEXvT2ASNgMlORV08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734543927; c=relaxed/simple;
	bh=DyOFUzSWa9wyfTfKT2Grlya27CgJbzdhKVB8lWcRTFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opvkpq7bfU8HsvjC7vIvK+C7roOSp6emOgIRfBr75zAp65MY4AeBKPQ4XjlOKG8bBncuWpzUkOSJNZcGAiEx9M1MvZN3kBU91tqn/2Ys50E6DWJhzycVErYojjoc+mIIDEXPsN5n8mSacN21kqqVr4uA9Rb2VHc4N6xs31QMeus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JOC+FWqb; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734543926; x=1766079926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DyOFUzSWa9wyfTfKT2Grlya27CgJbzdhKVB8lWcRTFc=;
  b=JOC+FWqbGW5iQZujFKrgdsRSsL+mGt11mFI3uvY+kzO5wie1XAWnV6Rn
   b8fCie/ljBbxGRmV0v54Y+Sm6104BBk4IhAuymesqHlc79Q65Q0aOnTg4
   i1Y3703OyFUDZXpiMmL85IddKEySKY6rA6mCWw29zaLLKYLYXoNKD6Wly
   NvQNAMGta3LinWabfubdKOZ+aDs6siVO70Z+iVbjYcbQ1pjSUduWkq61u
   Pt00thGZGYNXP7cb+gXvLE5bWjVm2/NX4bO7ALTw+mPIoyJne80eHe88c
   gH8aYL7fNpXIAjtvVpcK5AAdsVAui8WbtQ1RzIh2D9GX+yl9PgjM4Q4FL
   A==;
X-CSE-ConnectionGUID: vGrVZvcXT7a0NbD+I/PcHw==
X-CSE-MsgGUID: FUVGMJUfR6SvCkwq1jrt8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="22620959"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="22620959"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 09:45:25 -0800
X-CSE-ConnectionGUID: csS/MZUlRta8o7WdjvYViQ==
X-CSE-MsgGUID: WBYiAc4XS+eROQX4Z1wZZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121192210"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 18 Dec 2024 09:45:21 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jason Baron <jbaron@akamai.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Nathan Chancellor <nathan@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/7] page_pool: add page_pool_dev_alloc_netmem()
Date: Wed, 18 Dec 2024 18:44:29 +0100
Message-ID: <20241218174435.1445282-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218174435.1445282-1-aleksander.lobakin@intel.com>
References: <20241218174435.1445282-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to other _dev shorthands, add one for page_pool_alloc_netmem()
to allocate a netmem using the default Rx GFP flags (ATOMIC | NOWARN) to
make the page -> netmem transition of drivers easier.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/helpers.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 776a3008ac28..543f54fa3020 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -144,6 +144,15 @@ static inline netmem_ref page_pool_alloc_netmem(struct page_pool *pool,
 	return netmem;
 }
 
+static inline netmem_ref page_pool_dev_alloc_netmem(struct page_pool *pool,
+						    unsigned int *offset,
+						    unsigned int *size)
+{
+	gfp_t gfp = GFP_ATOMIC | __GFP_NOWARN;
+
+	return page_pool_alloc_netmem(pool, offset, size, gfp);
+}
+
 static inline struct page *page_pool_alloc(struct page_pool *pool,
 					   unsigned int *offset,
 					   unsigned int *size, gfp_t gfp)
-- 
2.47.1


