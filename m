Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFB158623E
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 03:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbiHABim (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jul 2022 21:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238735AbiHABil (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jul 2022 21:38:41 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D59D10B;
        Sun, 31 Jul 2022 18:38:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 18EF03200488;
        Sun, 31 Jul 2022 21:38:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 31 Jul 2022 21:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1659317916; x=1659404316; bh=Kw
        EB0XSuZowjFupqaLWGnwmCrXRrnoFcU7ypZIYPRKA=; b=ZICyB0JaiDwyMguye1
        XbE7GSE+iKm5DlkLYNqBmbA0R+9PM/7og1noZqhelyrKxdaexoIqIrH6TDGx9VCj
        zcUqJPuq5HC423CAXt8JCxhtdzwdQZeOeHDYNTAPj5BsriQsFQoKUKk2FoUYO/eR
        rBgsv+O6mTOrtwrVLh3vQt+eiudwdAp7RiVEte5VCcL4iP2H1Ozb5YfVmjyK5uBR
        CT9SSKl5gHLS8pmq6WJS/MnjZamKKIh9xODjb3P5JEFcvtnOIT+yHNvqqNLT39eL
        x24ijVEsadiKxmbyIbmuODzQ13991sQxkgKDDVbOMGEYyw9uzZ8+w8SiUgSP3WE5
        HLHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659317916; x=1659404316; bh=KwEB0XSuZowjF
        upqaLWGnwmCrXRrnoFcU7ypZIYPRKA=; b=V/odDKolm4jQKEGcR6dsCavrAhH+x
        CKQgm5OKUsbmeKz1J+BHEOyGWBVSLYygUIseOD2Us6Dy14gLz2E41U1e5YijUiIv
        SG4Tlotk8kVtWzHv1Ctc8h7K74CpI6rbMEkFkp5sWZfGF7nNC3XAymJQhfgWwNYH
        tazyzNY6djvchFlFvIYQySu7hZDSrn6mD3QMDGzog9W+9BiVdlPOpBZ+juBRmhtd
        RulXzxqWkMHTh9q4n8ugvG5RcMFqwkS8BpdYjqCkGKIHDu4+bSx5LWByYqvPe6Vm
        ims7wvIlGA8uRzaXkIlaU/FD5QnNgOgD6ePMhKmkvzoqhdx2gzzSKh+sg==
X-ME-Sender: <xms:nC7nYmmEpxogtZEqL3Sl7dhOE5bYAfEQ7E3pnKxR4ODPfSsFKAdcig>
    <xme:nC7nYt3SC0Ht1cSiAlLBsY4J79Vc17wfuijRJvjMP5GREO_B6pqmfhET9cwA0Othv
    g0So5Qo6tV7Kr77uw>
X-ME-Received: <xmr:nC7nYkqul1J0vYVGSS1oy0xxSTgQKoTW7pB_lUcW7C1b4RXRE6-wqGI9IXCigj8IYLGedMsf5HwGLyAyLAWlGzqhTg9kNrINWkHHYxB2EGuMq89_3sOGii8MTWFS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepleejgfdvfefhudektddtveegtdekieegffdtkeeljeetudevffeltdei
    feeugeeinecuffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghdpkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    rghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:nC7nYqkdR44YPFzkL78jcVenUQARuVYi40bh1adCcJtYwNy5mH3_SQ>
    <xmx:nC7nYk07_Zo4_OQkTruSKmX0tmMrQZLH6gss3bd0i2BTmtVdsOfgsg>
    <xmx:nC7nYhsK_HIzWKXO39gKt6d9gz55nY3kA6Jj2M2mwSbqRY5uVp7xXA>
    <xmx:nC7nYurVkh5_GH29WNRhAN7myNEyNUD8OzWllHqRtgyoxzSGLLe1rg>
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
Subject: [PATCH v3 4/8] tools perf: Fix compilation error with new binutils
Date:   Sun, 31 Jul 2022 18:38:30 -0700
Message-Id: <20220801013834.156015-5-andres@anarazel.de>
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
index 82cc396ef516..2c6a485c3de5 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1720,6 +1720,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
 #include <linux/btf.h>
+#include <tools/dis-asm-compat.h>
 
 static int symbol__disassemble_bpf(struct symbol *sym,
 				   struct annotate_args *args)
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

