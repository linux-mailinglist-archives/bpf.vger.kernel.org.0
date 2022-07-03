Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677DC5649F7
	for <lists+bpf@lfdr.de>; Sun,  3 Jul 2022 23:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiGCV0C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 17:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiGCVZ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 17:25:59 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F24E5F46;
        Sun,  3 Jul 2022 14:25:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 55A395C00BD;
        Sun,  3 Jul 2022 17:25:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 03 Jul 2022 17:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1656883554; x=1656969954; bh=Bn
        CSu4z9dXwavPNLrNVzFsrsFv86GTZpJNiCxUUqpwM=; b=WHu1Zn906HzTIscVZn
        0ZSXzL2FiMJpjnx6C4TBS1+FsWwaiGWhSrKFxMeAum9JJM7oG9p4cJHqQk6Hnmfb
        AvrkvEcWQjNWaLFdgGIlMKvIXI580cimSD8o4gPC2hBfKGntaiY8JCAJM2OQfbIG
        NXzmKxFB7gJ1GpCe4IApKrqJWnipalRQoT8r712d76XW1oUFQerUUHlOdM/hk7eG
        km5Y8XWPSlXseVMMf0kBOqruX4qN6DeammSckeOjflqJFCZCUq+uN9NWlRy09QN7
        R9C4E9zgn7Sx0utjlvbEdAjgo1h7kdyKW/a+z4DMCg+8SVLKyfKa4ySa/1rUJOcB
        5ocg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656883554; x=1656969954; bh=BnCSu4z9dXwav
        PNLrNVzFsrsFv86GTZpJNiCxUUqpwM=; b=VaK5+skPFW+4SkXiMma5WLMSLAEOH
        hTTEm/EyE7yO1Ej/w1wTZTFedcLC+XCK1ab4ojmCIf/yf2puoPX8t9eqVvixyzuJ
        R1raEw+qt/8mU9y9cY4xofM9jO02lkmtwhMAk07jTJWEne4qkFZixExExn68fy1t
        /Mx3sMLbb8C9x5iUhrFkgHYI8Qq9g+c1ggtDBxeGGm0ORvn7SrMRs+ndFzOWexjA
        IAK8+WVDirNk6uSB8+NBfhqhZ+tQEs0yXe+GH5RZ1WeBm8U53TwkpeHulVmH4+xM
        bKUGxFXa493fJVLWVFPT0T+2Yg3dDhu+43VPPnvTtUyke02xHFRz+l0FQ==
X-ME-Sender: <xms:YgnCYgW7ZsZ_DglSYH4CnddmaNn-s1tHNTaqtgSFuV9dTvvsFNBD0w>
    <xme:YgnCYkk7VsyQsi4AKO16hXUTBWSWxlJ5ejQ7Z176M1GdzkumzNZ-tg84EZ_tl7pPg
    2-ZBBJkHZl0_JIffw>
X-ME-Received: <xmr:YgnCYkYsp2ZUzHJl2T6QU9hL82EzPtsF-EQNkHvzU2KAfwnXIsuJOSEUHTb0U8bNtbgHJGN3tt8wZSwk5giKhrmPCtoln8iyvw4Oq7zteaipywiXU-yigMzkqXhb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehjedgudeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgu
    rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
    frrghtthgvrhhnpeeljefgvdefhfdukedttdevgedtkeeigefftdekleejteduveffledt
    ieefueegieenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgpdhkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:YgnCYvUpYLBz_5P7HpWVd86h92xLkfj8cqQzo6fXJWo2tzrESlEF_Q>
    <xmx:YgnCYqm_w943AIugIDXJ0d2xRX7bPm164h_uYHVTFxPEMihnjuDrow>
    <xmx:YgnCYkcNPXYdKpJ9aGKiO_WU09YVIaGlf51jwXKHEnOHnz5yodeq7Q>
    <xmx:YgnCYhuJrqPyDHGsOf0XTE628vmBsxx-8yk_vy-bpZcVm2xaFuH3og>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Jul 2022 17:25:54 -0400 (EDT)
From:   Andres Freund <andres@anarazel.de>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH v2 5/5] tools bpftool: Fix compilation error with new binutils
Date:   Sun,  3 Jul 2022 14:25:51 -0700
Message-Id: <20220703212551.1114923-6-andres@anarazel.de>
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
compilation to fail for tools/bpf/bpftool/jit_disasm.c, e.g. on debian
unstable. Relevant binutils commit:
https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07

Wire up the feature test and switch to init_disassemble_info_compat(),
which were introduced in prior commits, fixing the compilation failure.

I verified that bpftool can still disassemble bpf programs, both with an
old and new dis-asm.h API. There are no output changes for plain and json
formats. When comparing the output from old binutils (2.35)
to new bintuils with the patch (upstream snapshot) there are a few output
differences, but they are unrelated to this patch. An example hunk is:
   2f:	pop    %r14
   31:	pop    %r13
   33:	pop    %rbx
-  34:	leaveq
-  35:	retq
+  34:	leave
+  35:	ret

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>
Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
Signed-off-by: Andres Freund <andres@anarazel.de>
---
 tools/bpf/bpftool/Makefile     |  7 ++++--
 tools/bpf/bpftool/jit_disasm.c | 42 +++++++++++++++++++++++++++-------
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index c6d2c77d0252..62195118d377 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -93,9 +93,9 @@ INSTALL ?= install
 RM ?= rm -f
 
 FEATURE_USER = .bpftool
-FEATURE_TESTS = libbfd disassembler-four-args zlib libcap \
+FEATURE_TESTS = libbfd disassembler-four-args disassembler-init-styled zlib libcap \
 	clang-bpf-co-re
-FEATURE_DISPLAY = libbfd disassembler-four-args zlib libcap \
+FEATURE_DISPLAY = libbfd disassembler-four-args disassembler-init-styled zlib libcap \
 	clang-bpf-co-re
 
 check_feat := 1
@@ -117,6 +117,9 @@ endif
 ifeq ($(feature-disassembler-four-args), 1)
 CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
 endif
+ifeq ($(feature-disassembler-init-styled), 1)
+    CFLAGS += -DDISASM_INIT_STYLED
+endif
 
 LIBS = $(LIBBPF) -lelf -lz
 LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz
diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index 24734f2249d6..aaf99a0168c9 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -24,6 +24,7 @@
 #include <sys/stat.h>
 #include <limits.h>
 #include <bpf/libbpf.h>
+#include <tools/dis-asm-compat.h>
 
 #include "json_writer.h"
 #include "main.h"
@@ -39,15 +40,12 @@ static void get_exec_path(char *tpath, size_t size)
 }
 
 static int oper_count;
-static int fprintf_json(void *out, const char *fmt, ...)
+static int printf_json(void *out, const char *fmt, va_list ap)
 {
-	va_list ap;
 	char *s;
 	int err;
 
-	va_start(ap, fmt);
 	err = vasprintf(&s, fmt, ap);
-	va_end(ap);
 	if (err < 0)
 		return -1;
 
@@ -73,6 +71,32 @@ static int fprintf_json(void *out, const char *fmt, ...)
 	return 0;
 }
 
+static int fprintf_json(void *out, const char *fmt, ...)
+{
+	va_list ap;
+	int r;
+
+	va_start(ap, fmt);
+	r = printf_json(out, fmt, ap);
+	va_end(ap);
+
+	return r;
+}
+
+static int fprintf_json_styled(void *out,
+			       enum disassembler_style style __maybe_unused,
+			       const char *fmt, ...)
+{
+	va_list ap;
+	int r;
+
+	va_start(ap, fmt);
+	r = printf_json(out, fmt, ap);
+	va_end(ap);
+
+	return r;
+}
+
 void disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 		       const char *arch, const char *disassembler_options,
 		       const struct btf *btf,
@@ -99,11 +123,13 @@ void disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 	assert(bfd_check_format(bfdf, bfd_object));
 
 	if (json_output)
-		init_disassemble_info(&info, stdout,
-				      (fprintf_ftype) fprintf_json);
+		init_disassemble_info_compat(&info, stdout,
+					     (fprintf_ftype) fprintf_json,
+					     fprintf_json_styled);
 	else
-		init_disassemble_info(&info, stdout,
-				      (fprintf_ftype) fprintf);
+		init_disassemble_info_compat(&info, stdout,
+					     (fprintf_ftype) fprintf,
+					     fprintf_styled);
 
 	/* Update architecture info for offload. */
 	if (arch) {
-- 
2.37.0.3.g30cc8d0f14

