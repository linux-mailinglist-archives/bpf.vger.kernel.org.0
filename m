Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8DA5649EE
	for <lists+bpf@lfdr.de>; Sun,  3 Jul 2022 23:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiGCV0A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 17:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiGCVZ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 17:25:58 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF3C55BC;
        Sun,  3 Jul 2022 14:25:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3452D5C00B0;
        Sun,  3 Jul 2022 17:25:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 03 Jul 2022 17:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1656883553; x=1656969953; bh=0R
        ZUqWbxu+taN9I0W5oF8rpbxdv9lwgATydm8NiGcEY=; b=MinVfeoCMi7nwpMH95
        eWYsOKE8/34rC5r/9BDSgkJL6sJgJ1aUb0KqkxTQEOWUHgOXTjsSpBM0Sc/EQtMA
        Zs7HJV0hgy8BaTakCqAR5SWPeF3W3373e/kF3e//y8hRmDcYscFOm675kbg+4CZd
        fIpUxwpqntW36ISEF3CRMMxKLJzy2xTEM9yMfrEsENap+UvNnpO/2eVrkl20ComQ
        2hMHwuE7EOeYh/vb1Ux6p4BaXbti0JvuCHHXYrTLgwmlMKfr+XpxipQ3T935FbA4
        8shOLH5FXI78W/cGqNh5rsqIyx26TDhFSA1/b2iPji6cDdTlWQWvIPWMC8DcTCRL
        O3+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656883553; x=1656969953; bh=0RZUqWbxu+taN
        9I0W5oF8rpbxdv9lwgATydm8NiGcEY=; b=rHCu5xFZhKXHLnheeWpuG5K+EMDjC
        t5ucExUAikF4GPKlGFEVphpzw1yYLL+uDYxnVHZmIxKzwwf+GjLawbkQei4SHks0
        iseEU4J9xawJOGCIh1bo6X9liBKcdv1vX1CE0pSuFf4hZ1VEMXTedvj4Q7m/590o
        AeMC5hlo302rRhgyyAqzkzZlSgIjdO2SVvGJ3qI5W6Y5H08uQXlKxf/s14Bpq/Fq
        Y+sLin2CHLEu6hc6+MpKK/xtN97Mz4693UaB7SE1LEE5z6nasd7G8+oS8ADg5SdW
        cLO9j7KGpsNVN/d4TKKUv0v3mRbSJZiMQ8F+cLb1+CeCkx1+6A1qyJuAQ==
X-ME-Sender: <xms:YQnCYqnANMkn4lvKNuwn50swv8Doe8wdLSDgaFuqML8i24BFTS8jVA>
    <xme:YQnCYh36T4LuD8R2pqjyD_yCDnckRvOa01m0Lz86NwPjvtYMJCNLkiHqB9m4IBr93
    7QvxOLr0V0NeS6RJg>
X-ME-Received: <xmr:YQnCYork3wYlxvlSYn1gXHy6743Y9nUKeeWDyVhwi0sz8YOef9m18q_jP_3Ym4omARENvxmwt6dt0b08Lk5UKdtUjpuPvk076K59ohRRLic7U--8JInmjKq9mkyx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehjedgudeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgu
    rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
    frrghtthgvrhhnpeeljefgvdefhfdukedttdevgedtkeeigefftdekleejteduveffledt
    ieefueegieenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgpdhkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:YQnCYum2w7QmknMnOYKcAJsXWXfF3zBV8kuncCfvbuKSYVt8XdaYiQ>
    <xmx:YQnCYo37ubaV6wUrfrzlMNKdcCWosvUhkm3LJg8WK0g919KZoEFKrA>
    <xmx:YQnCYltlE5L0KUsNwGzFjmhbvpw32ueWDsXh0Fn_IrDMs_RBUyuE4g>
    <xmx:YQnCYs_DopIgyegC3q-bBZSAKUeU3Ke6yeHW6e36QkI5vjWcYS1I9g>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Jul 2022 17:25:52 -0400 (EDT)
From:   Andres Freund <andres@anarazel.de>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH v2 2/5] tools include: add dis-asm-compat.h to handle version differences
Date:   Sun,  3 Jul 2022 14:25:48 -0700
Message-Id: <20220703212551.1114923-3-andres@anarazel.de>
X-Mailer: git-send-email 2.37.0.3.g30cc8d0f14
In-Reply-To: <20220703212551.1114923-1-andres@anarazel.de>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220703212551.1114923-1-andres@anarazel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

binutils changed the signature of init_disassemble_info(), which now causes
compilation failures for tools/{perf,bpf}, e.g. on debian unstable.
Relevant binutils commit:
https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07

This commit introduces a wrapper for init_disassemble_info(), to avoid
spreading #ifdef DISASM_INIT_STYLED to a bunch of places. Subsequent
commits will use it to fix the build failures.

It likely is worth adding a wrapper for disassember(), to avoid the already
existing DISASM_FOUR_ARGS_SIGNATURE ifdefery.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>
Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
Signed-off-by: Andres Freund <andres@anarazel.de>
---
 tools/include/tools/dis-asm-compat.h | 53 ++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 tools/include/tools/dis-asm-compat.h

diff --git a/tools/include/tools/dis-asm-compat.h b/tools/include/tools/dis-asm-compat.h
new file mode 100644
index 000000000000..d1d003ee3e2f
--- /dev/null
+++ b/tools/include/tools/dis-asm-compat.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_DIS_ASM_COMPAT_H
+#define _TOOLS_DIS_ASM_COMPAT_H
+
+#include <stdio.h>
+#include <linux/compiler.h>
+#include <dis-asm.h>
+
+/* define types for older binutils version, to centralize ifdef'ery a bit */
+#ifndef DISASM_INIT_STYLED
+enum disassembler_style {DISASSEMBLER_STYLE_NOT_EMPTY};
+typedef int (*fprintf_styled_ftype) (void *, enum disassembler_style, const char*, ...);
+#endif
+
+/*
+ * Trivial fprintf wrapper to be used as the fprintf_styled_func argument to
+ * init_disassemble_info_compat() when normal fprintf suffices.
+ */
+static inline int fprintf_styled(void *out,
+				 enum disassembler_style style __maybe_unused,
+				 const char *fmt, ...)
+{
+	va_list args;
+	int r;
+
+	va_start(args, fmt);
+	r = vfprintf(out, fmt, args);
+	va_end(args);
+
+	return r;
+}
+
+/*
+ * Wrapper for init_disassemble_info() that hides version
+ * differences. Depending on binutils version and architecture either
+ * fprintf_func or fprintf_styled_func will be called.
+ */
+static inline void init_disassemble_info_compat(struct disassemble_info *info,
+						void *stream,
+						fprintf_ftype unstyled_func,
+						fprintf_styled_ftype styled_func __maybe_unused)
+{
+#ifdef DISASM_INIT_STYLED
+	init_disassemble_info(info, stream,
+			      unstyled_func,
+			      styled_func);
+#else
+	init_disassemble_info(info, stream,
+			      unstyled_func);
+#endif
+}
+
+#endif /* _TOOLS_DIS_ASM_COMPAT_H */
-- 
2.37.0.3.g30cc8d0f14

