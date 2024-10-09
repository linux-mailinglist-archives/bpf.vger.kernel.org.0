Return-Path: <bpf+bounces-41422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38238996FE9
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 17:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD2EFB22319
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283521E284D;
	Wed,  9 Oct 2024 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MiPnJm9A"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F4C1E2841;
	Wed,  9 Oct 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487729; cv=none; b=DkO+Ro1sXNcZMDtyAkcV8V7mH36kD9XyEgEpGMdSrgHkrVKK16RhaFdo4czSSto7jsvJOpLvbcCDMEHfyuW1062QUpfSYEdh8mUWhcVwrLmrA26YbsbSEFZL+nQVtlvNw3I4rle58mqUrmdfMJB3s9RatzNyZvm1rmf3Nves3RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487729; c=relaxed/simple;
	bh=kbq20DXpdYwp9Xsh+Yl+6W8Tf+jQuZgByx3qLkTFaT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHUnvCsfpI8MsHGIv0AFQGznH6ALEINV6+Z6lizAnPswvERalFQcKxeGNTZ8UIDjeE+UsnyNCfbg4tiCzKCubpQ9GsTvZtSKL5K7puvMFFqkzFSq+lj7HkxI00kQ0/dkfYb/TNcpBPIqYQtGrUQlvAJmX30UP52nByCJVqk3q74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MiPnJm9A; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728487728; x=1760023728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kbq20DXpdYwp9Xsh+Yl+6W8Tf+jQuZgByx3qLkTFaT4=;
  b=MiPnJm9AJy2wMJUq6mSoLus/Lw2jjLIdzbuUV9d1e5HYXZM7AA+n2fYf
   GJA0sgo24BRbHt9TELUVLX69a8fIVMVm4sTX73fh0v1izJ+ZFuxt2XZOo
   IubHPsU590oLnyUsKaZGqLZV6+HMmbbEJ/jHk+j7NuxXhoWWJGbNcXhEH
   i8zHyYvKmG6dIBipnIVSO7dh2jD5EJ7GNIEn8DmmDZGm5qrT5vxQRBLjR
   3LMFp9mmSuR1pU0x7+wxjqsXJ1gE/BEmrdsz+stEXDVwDKRJitXBnAz1s
   ynsL0ESpjOt6svnY94yWIQipID7K8HUTXaeq1HXcCmEBc2gJ7TM2Cyjbm
   A==;
X-CSE-ConnectionGUID: PXVnQbBvR2G+yRmwKklXBA==
X-CSE-MsgGUID: 9QTnm7OjTGCg73FXl7ZT1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27675703"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27675703"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 08:28:47 -0700
X-CSE-ConnectionGUID: QW2j2/XQTH2RDkmfp3lFKQ==
X-CSE-MsgGUID: 3KF8sTI+RG2+RU/nPz8F+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="81305836"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 09 Oct 2024 08:28:43 -0700
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
Subject: [PATCH net-next 03/18] unroll: add generic loop unroll helpers
Date: Wed,  9 Oct 2024 17:27:41 +0200
Message-ID: <20241009152756.3113697-4-aleksander.lobakin@intel.com>
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


