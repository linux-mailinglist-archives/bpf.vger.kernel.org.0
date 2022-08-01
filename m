Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF25586241
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 03:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbiHABio (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jul 2022 21:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238760AbiHABil (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jul 2022 21:38:41 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E693D112;
        Sun, 31 Jul 2022 18:38:40 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 408E13200495;
        Sun, 31 Jul 2022 21:38:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 31 Jul 2022 21:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1659317916; x=1659404316; bh=Gg
        2ebcjopr7kTW9xl9o9LrGHFKJ9hVi1E0tGPNFW3e4=; b=Fv6WyHQgrFf+9yUKXv
        VaX/YquwfAkVD62fU0rQLUAo47tOUmPm7QCP5Ux0d1U+I7Si27AL4AVI9wD+rytP
        y0JAARgXmMYXoBivV23A2B0y+XUUjno0H7SN3mW56IQPWsKK/wIsoybAsDS45TBL
        tXE4RczYeDijWDjHnzYKnpZcL9Vfhx4Slv3bFJ00qUWm1Xj9gN7P/127Y4paTBK5
        VDSNXjIxxIwMXLct9+s8GISaP1MUhNbO1cbwUbI5wLCJdjSsltBp1fS5tiaD00Fe
        cn4gu4DCQRNnsuj39Z4de1do57GibZDGsXFe+UQS0osMwKpCcutkuAHENTStEmAS
        vugA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659317916; x=1659404316; bh=Gg2ebcjopr7kT
        W9xl9o9LrGHFKJ9hVi1E0tGPNFW3e4=; b=rj5gGOrMINZYw8RO81Qc5SJMYJxnP
        w3qhIhrsNytKPsqoLtsv76GbyRo5KcriPMQUi/18aeW4y8Bs4QrsqTS5jSevN3xY
        ILPJe7jEQ72JinzFWOEEtFPEmufadII+MmCRoO0zQxjjz/X0lptWi0LrtTTCtx+k
        hd4rfESsyx83mbllm32nZ6fukZ6/dkHYPGeQ8B+r1O5l77i67HuB0+5HRyLcQl4J
        DTreyvKZQwFAVY+kGhD4VQQ+JZAKffqjt7k5dZKrRu4I3G+jRr3mG8XETDf5wvZz
        3P5k2QCVMitJEUivzGXsRvzmDGdBfRFjwyfdDPbG1jMsNPS6Lf1nVYMcw==
X-ME-Sender: <xms:nC7nYojM8nFzM2gxRHny8JdyzSo-57IgdtrHNkXNMAIJKtiaNIVtrw>
    <xme:nC7nYhBieW1QeCr7JjRHwH7W_OZV1U_FP9snXZqf_SMHE_JS0Mh3aZy-U2YBh1Ej9
    NdDbAGjmvHilPnGqQ>
X-ME-Received: <xmr:nC7nYgF56egf59VWh2Xef98p4wLNd80VAUFA85A7zdRtYSmIwu976UugAw8MyneOs16roQqEYbLnPhRUJ5baeNLnQ9wUFrXuVl2MT0FAq-F1jsl2wgbuu2ptatkq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepleejgfdvfefhudektddtveegtdekieegffdtkeeljeetudevffeltdei
    feeugeeinecuffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghdpkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    rghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:nC7nYpTX7p196SS-AOFPuKrMFgZ1s2H94nrcbHHxFoCQ5KjBcwo8EA>
    <xmx:nC7nYlyGFCXlpzot14gmJ2P2qCzd8sMQywuET6yp_dNacm34RWrv2Q>
    <xmx:nC7nYn55KmB2snJx-vjR247lTHWag-meEvalip2ZWuwwwVi3JzhFMQ>
    <xmx:nC7nYsljTC1kW88_DeUuQmQsVHtC_mDMPtsxSAjvCRD8UFScYCflRA>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Jul 2022 21:38:36 -0400 (EDT)
From:   Andres Freund <andres@anarazel.de>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Ben Hutchings <benh@debian.org>
Subject: [PATCH v3 3/8] tools include: add dis-asm-compat.h to handle version differences
Date:   Sun, 31 Jul 2022 18:38:29 -0700
Message-Id: <20220801013834.156015-4-andres@anarazel.de>
X-Mailer: git-send-email 2.37.0.3.g30cc8d0f14
In-Reply-To: <20220801013834.156015-1-andres@anarazel.de>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220801013834.156015-1-andres@anarazel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Cc: Ben Hutchings <benh@debian.org>
Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
Signed-off-by: Andres Freund <andres@anarazel.de>
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 tools/include/tools/dis-asm-compat.h | 55 ++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 tools/include/tools/dis-asm-compat.h

diff --git a/tools/include/tools/dis-asm-compat.h b/tools/include/tools/dis-asm-compat.h
new file mode 100644
index 000000000000..70f331e23ed3
--- /dev/null
+++ b/tools/include/tools/dis-asm-compat.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+#ifndef _TOOLS_DIS_ASM_COMPAT_H
+#define _TOOLS_DIS_ASM_COMPAT_H
+
+#include <stdio.h>
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
+				 enum disassembler_style style,
+				 const char *fmt, ...)
+{
+	va_list args;
+	int r;
+
+	(void)style;
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
+						fprintf_styled_ftype styled_func)
+{
+#ifdef DISASM_INIT_STYLED
+	init_disassemble_info(info, stream,
+			      unstyled_func,
+			      styled_func);
+#else
+	(void)styled_func;
+	init_disassemble_info(info, stream,
+			      unstyled_func);
+#endif
+}
+
+#endif /* _TOOLS_DIS_ASM_COMPAT_H */
-- 
2.37.0.3.g30cc8d0f14

