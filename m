Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0891A586244
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 03:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiHABiu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jul 2022 21:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238779AbiHABim (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jul 2022 21:38:42 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FB711C04;
        Sun, 31 Jul 2022 18:38:41 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 02122320070D;
        Sun, 31 Jul 2022 21:38:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 31 Jul 2022 21:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1659317919; x=1659404319; bh=oS
        FTQojBZ/1qGNcUG/xxkjgz71sl82f+LgDJhWiGZqU=; b=pb3sFrip5okyDi1vzq
        rFD56uavUvzVIs2skzmLy270uvhJbpu8kGI8xaZFis9UFlbRjZ15f+ujPF0aYjxA
        QhoHz+3AZ1jypYhhAFkwi+Ehl/yD8MYbbugWaddPh+D60NVPw9sErWA0tdD6o9Oy
        bUUrK+2j7QESs+gMuu+C4V/72OrkVGkTOu3edZ3WGF8x4fq/4JIVU6EGIsoVqUcH
        cvI/3MeJcXCLXS/oxP5HsJBErzGAsUwsCrUO2EapCztBV89x7Up187hYKoVnF7Cg
        uOaUhTX4LDe9z+UvOqHRj9eYAiqek1CuO6PUc6TCGCCpsfwWrzVjC0Xpq9vyZtMN
        4cMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659317919; x=1659404319; bh=oSFTQojBZ/1qG
        NcUG/xxkjgz71sl82f+LgDJhWiGZqU=; b=zXtAJJoKRiKCzdoRvahlX09cNLdj9
        SPFFWVl01J8A83cBneacsWx+EV3Qaczjh5UuGMkVlUaS8Qqrpbrkyj7LGvSRklgM
        qFzkZUAJg8apv+mcpyOX8qqCrBg6zXa8CWnHHdqVxhpUqjnE71/DuS7tQhjnlWUn
        2vZHfgHaxvRasp7G1DZnc+dpXcCwXk95xlo9pqeQM74HMQ1svHMFAdPxt8SidoBV
        N+9vnJwonnuPUFU0kYkLe5RNSzwDf+czjX1gvAaMHrGJNmip/hjDmoAuJ1oPyFgJ
        crNabezgQGJLVnOl1rV0Hf0/h5bpYhgcs4f6bYJP5Dne5CcMJuEDp18XA==
X-ME-Sender: <xms:ny7nYtYpP2i9r921-iEyEYC7DjKFBeE8SXvzPt8i--MeiyZ3-vXYRg>
    <xme:ny7nYkYwuY_bwAXY8PIkAjgc4-rLF3fphdI2aLNqCEbq7B3sZhTFizs_iX-lCfqfD
    hAl8NH9djwLtSOoxg>
X-ME-Received: <xmr:ny7nYv_JIL9nZxrouzuSxipdhhLD71__jGIOcdBTFw5wGxSMTH9MArqzRsmWjHG1q-_MRjGHClnYzkUuCbQ2y79xg7yZFK2GRbaa8m2b2R33jUMM4gXlYJY8Ibfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepleejgfdvfefhudektddtveegtdekieegffdtkeeljeetudevffeltdei
    feeugeeinecuffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghdpkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    rghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:ny7nYrqHaHSR4UCJJ_IPf3e82HvCe8BCmDvMHuyjB675Z3_kA2MUqQ>
    <xmx:ny7nYoqqLiIeoNfkE0ee6WXg4RGwNav9ct1fnL-h1kNk7geOoTnwKA>
    <xmx:ny7nYhQ1Nd9nNO6TjGAicgjmHVTN37P1Z3PIXPT0__5xwvmVf4CNcg>
    <xmx:ny7nYpewwtahoNWuoeYXhRwKkDbLLawAEdMjRVYzlyYizYN0Pa-Zig>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Jul 2022 21:38:38 -0400 (EDT)
From:   Andres Freund <andres@anarazel.de>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Ben Hutchings <benh@debian.org>
Subject: [PATCH v3 7/8] tools bpftool: Fix compilation error with new binutils
Date:   Sun, 31 Jul 2022 18:38:33 -0700
Message-Id: <20220801013834.156015-8-andres@anarazel.de>
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
 tools/bpf/bpftool/Makefile     |  5 +++-
 tools/bpf/bpftool/jit_disasm.c | 42 +++++++++++++++++++++++++++-------
 2 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index c6d2c77d0252..436e671b2657 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -93,7 +93,7 @@ INSTALL ?= install
 RM ?= rm -f
 
 FEATURE_USER = .bpftool
-FEATURE_TESTS = libbfd disassembler-four-args zlib libcap \
+FEATURE_TESTS = libbfd disassembler-four-args disassembler-init-styled zlib libcap \
 	clang-bpf-co-re
 FEATURE_DISPLAY = libbfd disassembler-four-args zlib libcap \
 	clang-bpf-co-re
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

