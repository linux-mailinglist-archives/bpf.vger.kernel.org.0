Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E648F5649F2
	for <lists+bpf@lfdr.de>; Sun,  3 Jul 2022 23:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiGCV0B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 17:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiGCVZ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 17:25:59 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6031A5F52;
        Sun,  3 Jul 2022 14:25:56 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5D5235C00B7;
        Sun,  3 Jul 2022 17:25:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 03 Jul 2022 17:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1656883553; x=1656969953; bh=Ht
        QcPPA/DlVVCi6tbjL3qdhgqXmt8/dZoOdf9WiKYMM=; b=WBZlfip0ObfKCoEp9T
        u6kbdhyWlVyfwoZBO2UnJcWPl9DegZ2w12YI9Xs4wYiMGIT4EPN5pHTGfaNBz0rB
        0IYGLDFen1VMPzyyvhpXdslFWZLu+sZ4rC1qHXGN7pLGQ9H3n3Elr4ME1tk2FaTo
        F+ItQR2NW1NJAXG5Au9yYZcx3zWeOdBKcL57KeYHK7GW7kFm89nf7jx9TJdI+IUm
        4J9k+dqcXrpNpXAszNPDetZNxeenw61sHxrrdWfL7k3rjyOzR5N8l5MwGmnVJLQy
        so6Ud9oiBLET2nrytThKqNtB7LxLdASCPttS3uE7PtezjX2S7Y7PP+1GE/bxalKb
        8Beg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656883553; x=1656969953; bh=HtQcPPA/DlVVC
        i6tbjL3qdhgqXmt8/dZoOdf9WiKYMM=; b=NBdK458sWVd6bqN1LKtmTh1qD738U
        aQ3wTCG5Y19t82n4Syg1re+FUFIoV2KZqGHtvAp8YafhA4UGAPXk8fV4FOWO826c
        NDOCaQYCazthhhLJej5uoKdjU2zKykUidaSFEFfMbDcqDoK1inAu2duUzNDP5o5f
        pX0lsgCdj5zOzYjrZhVHwJBqO4wD0VNCsHyDMpJNN5txvbHK943zCrL+jHws4QRO
        o5joJ9F2O1N1YjDoql4Dxl/2U/PuDlKgqhr/mFI84AbDHwueCHYoQNT7uTbUAFnw
        p2gNjOPQ3d0H55SMYfPn5lINNyPPD4GNG0S2AKxDeFyTW+CyzgIeETrLw==
X-ME-Sender: <xms:YQnCYq_TxOu52g4hbZy--4vHcHHY2ClElOb7CfTZ5XXh5yS7lueInA>
    <xme:YQnCYqt3R2htod2gAvLj6x61acOyFYwRQ6stCIrpPwXqvaJfB0Eh0id01VENw5uzg
    ZuMbci1X30TwJPtog>
X-ME-Received: <xmr:YQnCYgDu9S6aTJy5H9r3d8tjJgbyHblF569kf3g2epFU94ftUmrmngsYVou64O3DhYtHJ1hfex_f3xaNKilKxn4uFA-kqTYQj0RTmH3jLarhJH4dOblahBDW4t_a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehjedgudeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgu
    rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
    frrghtthgvrhhnpeeljefgvdefhfdukedttdevgedtkeeigefftdekleejteduveffledt
    ieefueegieenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgpdhkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:YQnCYifCbZ_-IGYFpitJoR8jRwSJYY0GCHZ-Gk6qTwORi1kSy8cnSg>
    <xmx:YQnCYvN4YogIx21fP2ZkDcBIHME0h-oEn87VVmvo-DK7rhWCzML0Ew>
    <xmx:YQnCYsltgkXIAsHQHQTPDUCtMxol7qV-cGcQW0sVWlAxcA7UfVZc6Q>
    <xmx:YQnCYq1K4auqYD5vi46gRViKxS2_FB7BK2xx9yTtSzy6vvBivdw-JA>
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
Subject: [PATCH v2 3/5] tools perf: Fix compilation error with new binutils
Date:   Sun,  3 Jul 2022 14:25:49 -0700
Message-Id: <20220703212551.1114923-4-andres@anarazel.de>
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
compilation failures for tools/perf/util/annotate.c, e.g. on debian
unstable. Relevant binutils commit:
https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07

Wire up the feature test and switch to init_disassemble_info_compat(),
which were introduced in prior commits, fixing the compilation failure.

I verified that perf can still disassemble bpf programs by using bpftrace
under load, recording a perf trace, and then annotating the bpf "function"
with and without the changes. With old binutils there's no change in output
before/after this patch. When comparing the output from old binutils (2.35)
to new bintuils with the patch (upstream snapshot) there are a few output
differences, but they are unrelated to this patch. An example hunk is:

     1.15 :   55:mov    %rbp,%rdx
     0.00 :   58:add    $0xfffffffffffffff8,%rdx
     0.00 :   5c:xor    %ecx,%ecx
-    1.03 :   5e:callq  0xffffffffe12aca3c
+    1.03 :   5e:call   0xffffffffe12aca3c
     0.00 :   63:xor    %eax,%eax
-    2.18 :   65:leaveq
-    2.82 :   66:retq
+    2.18 :   65:leave
+    2.82 :   66:ret

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
Signed-off-by: Andres Freund <andres@anarazel.de>
---
 tools/perf/Makefile.config | 8 ++++++++
 tools/perf/util/annotate.c | 7 ++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 73e0762092fe..ee417c321adb 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -298,6 +298,7 @@ FEATURE_CHECK_LDFLAGS-libpython := $(PYTHON_EMBED_LDOPTS)
 FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
 FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
+FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
 
 CORE_CFLAGS += -fno-omit-frame-pointer
 CORE_CFLAGS += -ggdb3
@@ -905,13 +906,16 @@ ifndef NO_LIBBFD
     ifeq ($(feature-libbfd-liberty), 1)
       EXTLIBS += -lbfd -lopcodes -liberty
       FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -ldl
+      FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -ldl
     else
       ifeq ($(feature-libbfd-liberty-z), 1)
         EXTLIBS += -lbfd -lopcodes -liberty -lz
         FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
+        FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -lz -ldl
       endif
     endif
     $(call feature_check,disassembler-four-args)
+    $(call feature_check,disassembler-init-styled)
   endif
 
   ifeq ($(feature-libbfd-buildid), 1)
@@ -1025,6 +1029,10 @@ ifeq ($(feature-disassembler-four-args), 1)
     CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
 endif
 
+ifeq ($(feature-disassembler-init-styled), 1)
+    CFLAGS += -DDISASM_INIT_STYLED
+endif
+
 ifeq (${IS_64_BIT}, 1)
   ifndef NO_PERF_READ_VDSO32
     $(call feature_check,compile-32)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 82cc396ef516..daea1867381d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -41,6 +41,7 @@
 #include <linux/string.h>
 #include <subcmd/parse-options.h>
 #include <subcmd/run-command.h>
+#include <tools/dis-asm-compat.h>
 
 /* FIXME: For the HE_COLORSET */
 #include "ui/browser.h"
@@ -1762,9 +1763,9 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 		ret = errno;
 		goto out;
 	}
-	init_disassemble_info(&info, s,
-			      (fprintf_ftype) fprintf);
-
+	init_disassemble_info_compat(&info, s,
+				     (fprintf_ftype) fprintf,
+				     fprintf_styled);
 	info.arch = bfd_get_arch(bfdf);
 	info.mach = bfd_get_mach(bfdf);
 
-- 
2.37.0.3.g30cc8d0f14

