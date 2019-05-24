Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0610C2984B
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 14:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391031AbfEXMxh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 08:53:37 -0400
Received: from foss.arm.com ([217.140.101.70]:42268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390781AbfEXMxh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 08:53:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13DEF15A2;
        Fri, 24 May 2019 05:53:37 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AEF5A3F703;
        Fri, 24 May 2019 05:53:35 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     will.deacon@arm.com, catalin.marinas@arm.com
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        yoshihiro.shimoda.uh@renesas.com, kuninori.morimoto.gx@renesas.com
Subject: [PATCH 2/2] arm64: insn: Add BUILD_BUG_ON() for invalid masks
Date:   Fri, 24 May 2019 13:52:20 +0100
Message-Id: <20190524125220.25463-2-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524125220.25463-1-jean-philippe.brucker@arm.com>
References: <20190524125220.25463-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Detect invalid instruction masks at build time. Some versions of GCC can
warn about the situation, but not all of them, it seems.

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
I couldn't manage to trigger the reported tautological-compare warning
with GCC 8.3.0, even when explicitly calling aarch64_insn_is_ldadd()
(since it's __always_inline) and even though the warning triggers when
inlining the test manually. So adding this check could be useful.
---
 arch/arm64/include/asm/insn.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index f71b84d9f294..87fdfba13a30 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -18,6 +18,7 @@
  */
 #ifndef	__ASM_INSN_H
 #define	__ASM_INSN_H
+#include <linux/build_bug.h>
 #include <linux/types.h>
 
 /* A64 instructions are always 32 bits. */
@@ -266,11 +267,16 @@ enum aarch64_insn_adr_type {
 	AARCH64_INSN_ADR_TYPE_ADR,
 };
 
-#define	__AARCH64_INSN_FUNCS(abbr, mask, val)	\
-static __always_inline bool aarch64_insn_is_##abbr(u32 code) \
-{ return (code & (mask)) == (val); } \
-static __always_inline u32 aarch64_insn_get_##abbr##_value(void) \
-{ return (val); }
+#define	__AARCH64_INSN_FUNCS(abbr, mask, val)				\
+static __always_inline bool aarch64_insn_is_##abbr(u32 code)		\
+{									\
+	BUILD_BUG_ON(~(mask) & (val));					\
+	return (code & (mask)) == (val);				\
+}									\
+static __always_inline u32 aarch64_insn_get_##abbr##_value(void)	\
+{									\
+	return (val);							\
+}
 
 __AARCH64_INSN_FUNCS(adr,	0x9F000000, 0x10000000)
 __AARCH64_INSN_FUNCS(adrp,	0x9F000000, 0x90000000)
-- 
2.21.0

