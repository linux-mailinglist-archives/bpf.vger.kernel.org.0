Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F3D5649ED
	for <lists+bpf@lfdr.de>; Sun,  3 Jul 2022 23:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiGCVZ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 17:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiGCVZ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 17:25:58 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600D85F46;
        Sun,  3 Jul 2022 14:25:56 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 74EBB5C00B9;
        Sun,  3 Jul 2022 17:25:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 03 Jul 2022 17:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1656883553; x=1656969953; bh=nU
        1WBasI1CUyTtj7GqIhMjBF+5+nCEgecH1nACNQeNA=; b=TPf9MSrrVx5dcJCbEI
        fDpDriAq7o1s7R9msbQlnuWUEQs21WQP5Km1V7AYclffPLLdvb1TTuid90AnU3sf
        0Z9VCb5krpQ+zg7QzvMLFHpQddPHVM8arHx15sBZyb9XYNRmheTPM7/ShUNMmQH/
        qWhEAS4S5YnWazM3qTmGzGgOSsiTey10X+39UPp9h21KlL/GdzEx6kvqNa1Tt5Ya
        LIMRbmkRxlKLyN9LqSvhw7E6nzwAHcIklEt15t7cWAk2Fzr7MZPu0N/j7/w3zKzE
        sDFgnY4ZCWQu9nkrqKBQWP7SRjTqvyYecJ+FU3uGrqgTptIN8YA+Wzj4D/n97XBb
        wAwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656883553; x=1656969953; bh=nU1WBasI1CUyT
        tj7GqIhMjBF+5+nCEgecH1nACNQeNA=; b=gXECe2Kn7PtEp4J3pFepQ1qQIZ5U3
        EeEUARXQFldkAxGdbEWPKS6XC0uodTG4t5ib36RsCw0bnbtQ5MmidMus1fS7Danw
        H6ltrmfSOqzbT5gHicKlL6+uOvB4WtEMwKR0x7xpG2HojlrJ8nQZEGzRrBnhPCbR
        hn2jU8PF8bZK2oflqXdoDQpqmgzz+LOy1Qu2Y9DpUBN5Jp2VV3hgW0asFrLrJ4jV
        K8Fr9Ip9QvPkGyWnBlI/p8gsedTzsP2Ft1MlEcE75YYZz4YXB/Lp7rk0xv58SNQH
        4mVdWZUPb1gIlwNu4dSRWlbem+QkqWBRRdYOsv3mQy9/teWZknP/TpfxA==
X-ME-Sender: <xms:YQnCYh_7GH5CjvpHjy4vuhAlalEI2jt1ddUsUfs5ixqErwgDmQRMJQ>
    <xme:YQnCYlviyswXwMUkX0UEqQYguDKk08H-dmDQ6P3n9kwqPJT3yfIbBULpmTfmaKevq
    YNt0oZwucgXLpsAAw>
X-ME-Received: <xmr:YQnCYvB6BAf29JJRnutdenvF2SGCYmpdI30lqQGSwRcVLXzqtPVJfq2_ihxRGvpZaU8ueSZLgdHeTPJpagu02eLA1x1TqFLThgJonWak0Bm00-5ybTmwPMf1ojxl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehjedgudeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgu
    rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
    frrghtthgvrhhnpeeljefgvdefhfdukedttdevgedtkeeigefftdekleejteduveffledt
    ieefueegieenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgpdhkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:YQnCYldkf7142I3yikA4UMbPQTPTdUMvw8bu9Qanu0SSQoaqgcGivQ>
    <xmx:YQnCYmOn21H0_nN_ThqFp4qCw6Fx_z7-hRFD7RWQcjNS9Ualj7bMUQ>
    <xmx:YQnCYnnTE90plwB3LatFRdari-qP2h9A_s2bNhnvUN91_kKda5K7vg>
    <xmx:YQnCYt1ViLvqCMaql_MLRmDywNMzGGUNuOl09tESIsOWv_U5M_pwGQ>
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
Subject: [PATCH v2 1/5] tools build: add feature test for init_disassemble_info API changes
Date:   Sun,  3 Jul 2022 14:25:47 -0700
Message-Id: <20220703212551.1114923-2-andres@anarazel.de>
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

This commit adds a feature test to detect the new signature.  Subsequent
commits will use it to fix the build failures.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>
Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
Signed-off-by: Andres Freund <andres@anarazel.de>
---
 tools/build/Makefile.feature                        |  4 +++-
 tools/build/feature/Makefile                        |  4 ++++
 tools/build/feature/test-all.c                      |  4 ++++
 tools/build/feature/test-disassembler-init-styled.c | 13 +++++++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 tools/build/feature/test-disassembler-init-styled.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 888a0421d43b..339686b99a6e 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -70,6 +70,7 @@ FEATURE_TESTS_BASIC :=                  \
         libaio				\
         libzstd				\
         disassembler-four-args		\
+        disassembler-init-styled	\
         file-handle
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
@@ -135,7 +136,8 @@ FEATURE_DISPLAY ?=              \
          bpf			\
          libaio			\
          libzstd		\
-         disassembler-four-args
+         disassembler-four-args	\
+         disassembler-init-styled
 
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
 # If in the future we need per-feature checks/flags for features not
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7c2a17e23c30..c3059739318a 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -18,6 +18,7 @@ FILES=                                          \
          test-libbfd.bin                        \
          test-libbfd-buildid.bin		\
          test-disassembler-four-args.bin        \
+         test-disassembler-init-styled.bin	\
          test-reallocarray.bin			\
          test-libbfd-liberty.bin                \
          test-libbfd-liberty-z.bin              \
@@ -248,6 +249,9 @@ $(OUTPUT)test-libbfd-buildid.bin:
 $(OUTPUT)test-disassembler-four-args.bin:
 	$(BUILD) -DPACKAGE='"perf"' -lbfd -lopcodes
 
+$(OUTPUT)test-disassembler-init-styled.bin:
+	$(BUILD) -DPACKAGE='"perf"' -lbfd -lopcodes
+
 $(OUTPUT)test-reallocarray.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 5ffafb967b6e..957c02c7b163 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -166,6 +166,10 @@
 # include "test-disassembler-four-args.c"
 #undef main
 
+#define main main_test_disassembler_init_styled
+# include "test-disassembler-init-styled.c"
+#undef main
+
 #define main main_test_libzstd
 # include "test-libzstd.c"
 #undef main
diff --git a/tools/build/feature/test-disassembler-init-styled.c b/tools/build/feature/test-disassembler-init-styled.c
new file mode 100644
index 000000000000..f1ce0ec3bee9
--- /dev/null
+++ b/tools/build/feature/test-disassembler-init-styled.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <dis-asm.h>
+
+int main(void)
+{
+	struct disassemble_info info;
+
+	init_disassemble_info(&info, stdout,
+			      NULL, NULL);
+
+	return 0;
+}
-- 
2.37.0.3.g30cc8d0f14

