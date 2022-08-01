Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FE2586240
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 03:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbiHABin (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jul 2022 21:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbiHABil (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jul 2022 21:38:41 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE02D100;
        Sun, 31 Jul 2022 18:38:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6880632005D8;
        Sun, 31 Jul 2022 21:38:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 31 Jul 2022 21:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1659317916; x=1659404316; bh=mw
        HT53oEdmgh2incFIsZytWOGuM1iKeKZ98Mr0aqk+o=; b=oI5JViG/wLwbjvozJE
        FsC9MYTYIX5j0WbwLixwHirqd70d0gSawcJgSbKuYLuSceqjh0pw8IcENtrbketx
        QbesEg6ho0LQ2SKd+ms2dbPBQiuGE6e0eHcqmnDPKoSEZ8G078227s1wnjoHS8St
        m/XMMMitrpObCZeZDI6MlXv1JOebnd9HmpKk1Tda0KAA1JdCQRB7f36pDIqYJfWC
        M8RQ7lZB0ieI9ERxroUsIh2MWAwyMYmeViBajCXmwu67P/rbvkgZSTelHqGY7iYh
        s01Nr4Rr2rBsDN1k+cNOgNB9Ku6/1da5vqbdo6E+qS1q2i+tmnfAtKaXZE1RoNZo
        FbQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659317916; x=1659404316; bh=mwHT53oEdmgh2
        incFIsZytWOGuM1iKeKZ98Mr0aqk+o=; b=NpOvo10qFST+h13Zb5eJ2SU5Zf5Xz
        p8BPjAmE6yjNreQYLiTgvEn9plYR6gbLkDb6O/QRYN9frbkyphH3qNch2hLXQ89A
        0fo28HDjtP8RBDVi7vmQ5ql4FNvmcVOllFIEGqlZjt5UWn3HUgmc+brxyToazI2S
        typ5WEdtn3TOl+SO2DcDvbHbG7OfiDjUEiRGfFRV6cDxsW1k8htUxYD4XMVjT7uY
        khbAAf7gkhrWTCGkAJvuH526RpyORVKBu3cPS4/5VWdnWMX3oZ2421RMq1Uwx5ve
        qn28LYrRRPWx6NUVn5iO8VfenSU/Xz3gL3zEYfwSud8LBjspF2Tk0+EBQ==
X-ME-Sender: <xms:nC7nYn8AJ3SxXLEum9MNW3yZv4kVjs89kcxvCl91doljZ0fskF3hYw>
    <xme:nC7nYjtsF16C73JK3UaQZjO11yrJe2UhsFudrdkFB67AbQBo51vJOHIlDpHB2iKYu
    LVTUPbFVtEClCPnCQ>
X-ME-Received: <xmr:nC7nYlBv-gJ8hmv6HFXVVFI84tmN2_XgeYrfDX08LSZeQlFyRjYjXqfrulzP5Tb9dOfNlQsk_hZ2hpAFjz03KRplV4KGb6LzI79eIIPbJLScq6K0AsEVLg3k00iE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepleejgfdvfefhudektddtveegtdekieegffdtkeeljeetudevffeltdei
    feeugeeinecuffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghdpkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    rghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:nC7nYjexRoccBT20fjUmTMeYQvxCeylZFMpJJBJMrRRHhZ4UlSJXjQ>
    <xmx:nC7nYsOiSGnoCK6IwZY1ny2xfv-qfpxSnq1CplbTK15ngQQf0LQD-g>
    <xmx:nC7nYlkb07xeJsRiPWTotNGlRRSjneDnI54P0Kg6duvSg7V-DZm13A>
    <xmx:nC7nYoCD4VAPDX5FULWlFvJSXC6bLN--zH3mLsUk10ouD3pXwjlnXg>
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
Subject: [PATCH v3 1/8] tools build: Add feature test for init_disassemble_info API changes
Date:   Sun, 31 Jul 2022 18:38:27 -0700
Message-Id: <20220801013834.156015-2-andres@anarazel.de>
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

This commit adds a feature test to detect the new signature.  Subsequent
commits will use it to fix the build failures.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>
Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
Signed-off-by: Andres Freund <andres@anarazel.de>
---
 tools/build/Makefile.feature                        |  1 +
 tools/build/feature/Makefile                        |  4 ++++
 tools/build/feature/test-all.c                      |  4 ++++
 tools/build/feature/test-disassembler-init-styled.c | 13 +++++++++++++
 4 files changed, 22 insertions(+)
 create mode 100644 tools/build/feature/test-disassembler-init-styled.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 888a0421d43b..8f6578e4d324 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -70,6 +70,7 @@ FEATURE_TESTS_BASIC :=                  \
         libaio				\
         libzstd				\
         disassembler-four-args		\
+        disassembler-init-styled	\
         file-handle
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
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

