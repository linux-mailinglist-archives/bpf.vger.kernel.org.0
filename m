Return-Path: <bpf+bounces-44758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1B39C7713
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 16:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54411F2715A
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B7815E5CA;
	Wed, 13 Nov 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvPjoLub"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7EE202638;
	Wed, 13 Nov 2024 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511514; cv=none; b=Vg6rn9iLSEjEwMe480jDeRVGUkfMbAP/IS660nTgoYhvECXMndP0S4itZhvzKGVQYpTJhWp612KYcx8Cn5ZfIHEDyJr0yALed5q1ldwm3c5KaPvW9iNehfDecwiXIDvA0M767o2E2Mp0B1G1zPqVgPJaNXOn6BiQYShktHwDmns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511514; c=relaxed/simple;
	bh=DFGQJNxM+FgbEtL5yJWRP3oVCB90anzIfa9xYAuXcZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BR9Vqxu64WyKlRx0RqV79Ux00DxLzjpaikU6hAyiMG3VYy/OAASMRtkvg2X4+i+Tp0o7OsSSSLR+limpmSMcoq0NER/CHx8Z+N0UInttSsdrVtOl8VnZrHpQePeA3KbZPSfiWcbGxecGE3uuElT+84i73DXmm13s0ewb+nYZ3ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvPjoLub; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731511513; x=1763047513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DFGQJNxM+FgbEtL5yJWRP3oVCB90anzIfa9xYAuXcZk=;
  b=gvPjoLub21FeIQN6enyrwUUmp2IK3HEKvP3N3gBLJgsEh3HKtU13yUrg
   FbNCAbjXi57W13AyXAYR3av5anA7Cb1UWS/O/HgIM3pJEWu4v8CKdq40L
   fZeZXJYjrY9n8L4qcGD5zIceML1P1e/wa7veT+3UL2AmCV7iv18WdRTxZ
   BNIaQN1xBZXtDLCJhR5Dn0m/2+3ZwMgO7iQb6vcidagT3i+FkkiIP725a
   kcKMCXGtFHHGuyrIuWNh7dlzBke4zUoofrnMokn1/3B1Wb8817OnvrVNr
   BpzdlmDUbzmV6i0kGa9nBgC2H1Vu784XkYuY1a2yqjxgS0qckkKKzY/t9
   A==;
X-CSE-ConnectionGUID: Pc6lvl1jR2yksO3q6hQFaA==
X-CSE-MsgGUID: g1P6vJhFQFycVRd5TKkw7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42799265"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42799265"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:25:13 -0800
X-CSE-ConnectionGUID: ZERC9mzNSXaCEWuMikOuZA==
X-CSE-MsgGUID: CbFBbjJeQLm2gAoIKazP+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="118726860"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 07:25:08 -0800
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
	linux-kernel@vger.kernel.org,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v5 03/19] unroll: add generic loop unroll helpers
Date: Wed, 13 Nov 2024 16:24:26 +0100
Message-ID: <20241113152442.4000468-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are cases when we need to explicitly unroll loops. For example,
cache operations, filling DMA descriptors on very high speeds etc.
Add compiler-specific attribute macros to give the compiler a hint
that we'd like to unroll a loop.
Example usage:

 #define UNROLL_BATCH 8

	unrolled_count(UNROLL_BATCH)
	for (u32 i = 0; i < UNROLL_BATCH; i++)
		op(priv, i);

Note that sometimes the compilers won't unroll loops if they think this
would have worse optimization and perf than without unrolling, and that
unroll attributes are available only starting GCC 8. For older compiler
versions, no hints/attributes will be applied.
For better unrolling/parallelization, don't have any variables that
interfere between iterations except for the iterator itself.

Co-developed-by: Jose E. Marchesi <jose.marchesi@oracle.com> # pragmas
Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/unroll.h | 43 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/linux/unroll.h b/include/linux/unroll.h
index d42fd6366373..2870c89a93f4 100644
--- a/include/linux/unroll.h
+++ b/include/linux/unroll.h
@@ -9,6 +9,49 @@
 
 #include <linux/args.h>
 
+#ifdef CONFIG_CC_IS_CLANG
+#define __pick_unrolled(x, y)		_Pragma(#x)
+#elif CONFIG_GCC_VERSION >= 80000
+#define __pick_unrolled(x, y)		_Pragma(#y)
+#else
+#define __pick_unrolled(x, y)		/* not supported */
+#endif
+
+/**
+ * unrolled - loop attributes to ask the compiler to unroll it
+ *
+ * Usage:
+ *
+ * #define BATCH 4
+ *	unrolled_count(BATCH)
+ *	for (u32 i = 0; i < BATCH; i++)
+ *		// loop body without cross-iteration dependencies
+ *
+ * This is only a hint and the compiler is free to disable unrolling if it
+ * thinks the count is suboptimal and may hurt performance and/or hugely
+ * increase object code size.
+ * Not having any cross-iteration dependencies (i.e. when iter x + 1 depends
+ * on what iter x will do with variables) is not a strict requirement, but
+ * provides best performance and object code size.
+ * Available only on Clang and GCC 8.x onwards.
+ */
+
+/* Ask the compiler to pick an optimal unroll count, Clang only */
+#define unrolled							    \
+	__pick_unrolled(clang loop unroll(enable), /* nothing */)
+
+/* Unroll each @n iterations of a loop */
+#define unrolled_count(n)						    \
+	__pick_unrolled(clang loop unroll_count(n), GCC unroll n)
+
+/* Unroll the whole loop */
+#define unrolled_full							    \
+	__pick_unrolled(clang loop unroll(full), GCC unroll 65534)
+
+/* Never unroll a loop */
+#define unrolled_none							    \
+	__pick_unrolled(clang loop unroll(disable), GCC unroll 1)
+
 #define UNROLL(N, MACRO, args...) CONCATENATE(__UNROLL_, N)(MACRO, args)
 
 #define __UNROLL_0(MACRO, args...)
-- 
2.47.0


