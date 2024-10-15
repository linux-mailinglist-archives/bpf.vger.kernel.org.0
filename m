Return-Path: <bpf+bounces-42044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E54E599F041
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25B42848B6
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F561FAEF0;
	Tue, 15 Oct 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYitEQfT"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585BF1D516D;
	Tue, 15 Oct 2024 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004068; cv=none; b=GsNZkI4zTagH+JgoSUN5DgyOHA+QX+b3T/SE6pfDAd+rwGuS81/9b0gHMxhSqpRWf6G8cVoZsBu5JHLWj/29GdNYv1TGHFiL9Q0oAQTE1rLLHekFsmXx1V5/xthjCXIY0pi16ryul6029IbhVT8sNQfhat7KopfuL3a0Vn/i2Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004068; c=relaxed/simple;
	bh=kbq20DXpdYwp9Xsh+Yl+6W8Tf+jQuZgByx3qLkTFaT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSaBxy5utOsiGpfHa9igSGAmbBY5gPbTd+Lc+gC4/SHrg53RedRac1g91RVaaXn94WzxmUl3SG7HPnDvYM3DJV6e38nZdzrqq7DJnqHiTg+WW/EX8Dt3E3tNt5lpdi688MRZWtNh2gMIsSlQhaakmCTNY3RuuNVFzDZchAuCm2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYitEQfT; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729004066; x=1760540066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kbq20DXpdYwp9Xsh+Yl+6W8Tf+jQuZgByx3qLkTFaT4=;
  b=cYitEQfTMxIvGe91MSaKuecg2SOYL9HttXLaBprGTHE49WpXIRfOer90
   lOrYcQy15RPPsHiezAg/3vf5iNKpZN81qzRsyoMCxIem8yLSFnBGgHdCh
   xuSyAQAMmcr2PrP+Rt8M4JNxSiZcTK+Y6Qtu/O4gWE3ao+kbh0HySp8jI
   GGsp76vT0Z+us8oCqVIfzcRtW+fACvID2Qc1OprDDh8VVBPbQEN+N41dZ
   7SbaskSRBURgOXyvn3P0k1756BTilobqusgPXB5VpWH7rCbDuNNNCiO0O
   lgclhkCHaVaOouGcHTL7afp2Iz9tVKV/shLDKHzWdZkWFngtvSyCNZ7n2
   w==;
X-CSE-ConnectionGUID: Sd3/tEDuQdemf6NaYQvw1Q==
X-CSE-MsgGUID: Nkoc8AjHQMebVeKhxKKqeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="31277474"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="31277474"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 07:54:26 -0700
X-CSE-ConnectionGUID: I+m00YcFQyuWirUiNfFpqw==
X-CSE-MsgGUID: lMEInDt+T42WwEHP2h8zXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82723060"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa003.jf.intel.com with ESMTP; 15 Oct 2024 07:54:22 -0700
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
	linux-kernel@vger.kernel.org,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 03/18] unroll: add generic loop unroll helpers
Date: Tue, 15 Oct 2024 16:53:35 +0200
Message-ID: <20241015145350.4077765-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
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
2.46.2


