Return-Path: <bpf+bounces-47267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771CF9F6C9F
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 18:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D70E16E700
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 17:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5141FDE15;
	Wed, 18 Dec 2024 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G27KAmJD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7C1FDE04;
	Wed, 18 Dec 2024 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734543954; cv=none; b=koatchYi9Tm4Tt6QQfAlzjP3QCfnm7XSh9jgLAmSQGMoWIEIIW2CcNqEBQ5aDebEhNh69b/2WD35yghPAwgBlITv4Z53u0gETN+64fPuL8V/3hivgzpGIamDzxyGJPHhhftpTLvzrVz9IT3LniYbMmBEQYgvzMENq8Au7zac7ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734543954; c=relaxed/simple;
	bh=UGK9PXGjTDILxlx3M92s+knR+V9YBUJZmeVx8m1Tmbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAwW8RpZLbS0oyjNxQxeL9itFJWyqRnxECxl/xkDh/fQe9zt2ATj7SaLD626LVc36LRwK+Fhu6yge1NvZ3BcJm9wpSZnQ2a3UYPNNcZvFWoZCfJZ0OwgxF2D0tuYOl+Rhylyfvc7unvNihpcOKyR3k+IcSSp/ZDc3yzG4+qjV1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G27KAmJD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734543953; x=1766079953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UGK9PXGjTDILxlx3M92s+knR+V9YBUJZmeVx8m1Tmbs=;
  b=G27KAmJDTIrZCOYd0NAsW4D84Tdu/1bBEd1IZCSyve8/rmvZMFMtm27x
   V2qpgupOyldck41edqYIO8R6k2g2W0CLxHP1ka3+cAPQqHYpUeFVbF3QC
   R5eUxHZ1CnooTHarwXaB5SALev0x8tJrhZx9mVSPt8VhJjV8xwmFqBc1a
   r4lPWYB4WoWz/8jtEYIIVsV9O2GwxWFZbs4tz8hUduJV1ZDTHG7gHM4Nj
   F4b8EiRsPrDkO+CYUu7QmfHv+0I0E+0Qdr6fMcETkmJoFV5RZw9qN9kO4
   h0pRhXSscoRnuKs+FGQWZyjO+f/CqBp5YyFAIW7vYHh4GYDyoAYSyr/2O
   w==;
X-CSE-ConnectionGUID: 12uYQKD7T26E093mMskSvA==
X-CSE-MsgGUID: 48VmCRj9SOOyKAvgh2f4VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="22621050"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="22621050"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 09:45:52 -0800
X-CSE-ConnectionGUID: j1MjQuvATR+tvTDQv4MMrw==
X-CSE-MsgGUID: IAjujpsBQwO1IMCJR3dSPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121192364"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 18 Dec 2024 09:45:48 -0800
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
Subject: [PATCH net-next 7/7] unroll: add generic loop unroll helpers
Date: Wed, 18 Dec 2024 18:44:35 +0100
Message-ID: <20241218174435.1445282-8-aleksander.lobakin@intel.com>
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
 include/linux/unroll.h | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/linux/unroll.h b/include/linux/unroll.h
index d42fd6366373..863fb69f6a7e 100644
--- a/include/linux/unroll.h
+++ b/include/linux/unroll.h
@@ -9,6 +9,50 @@
 
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
+ * #define BATCH 8
+ *
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
+#define unrolled							\
+	__pick_unrolled(clang loop unroll(enable), /* nothing */)
+
+/* Unroll each @n iterations of the loop */
+#define unrolled_count(n)						\
+	__pick_unrolled(clang loop unroll_count(n), GCC unroll n)
+
+/* Unroll the whole loop */
+#define unrolled_full							\
+	__pick_unrolled(clang loop unroll(full), GCC unroll 65534)
+
+/* Never unroll the loop */
+#define unrolled_none							\
+	__pick_unrolled(clang loop unroll(disable), GCC unroll 1)
+
 #define UNROLL(N, MACRO, args...) CONCATENATE(__UNROLL_, N)(MACRO, args)
 
 #define __UNROLL_0(MACRO, args...)
-- 
2.47.1


