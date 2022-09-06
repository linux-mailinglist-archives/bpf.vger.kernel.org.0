Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693035AEB03
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 15:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbiIFNop (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 09:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbiIFNna (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 09:43:30 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63382B40
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 06:37:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e13so15519450wrm.1
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=S7PgMe2exWuYmtTchtff0lomr9j48WSXfhH+F490Iio=;
        b=tSV2UH/+rQ7m08rslXJIJHUPKJYT0CtHCYVqWeoJUS2DNtflwZlKaHA+NurDWSY2Hi
         F1nkpFbCHOUnrxp4AFiPm46DspOAgtk0dhwob8M5rInhYedJCWPMxSkW8THbEydFFclB
         cHLC1Fefic1O8dsAKdriTt+YEz4ugBZVWEMOJVDkzZH8QcLp7ktZklSTSQNs5xHHFuLL
         wcASXi2BOb9xFGrESvwnCRXMB1DaCAj+cSk6JHrPpYcdznLHPoPXouM+d4zzxrL5TENQ
         y599MPE4EAs/cB69V1TSJSk499TsAbDUHDuQPkNCQU2CV1KJJu4ExT3zGuaq/gnW/cbj
         t26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=S7PgMe2exWuYmtTchtff0lomr9j48WSXfhH+F490Iio=;
        b=6YTvWvsH8zd0Fbimtut0XBtN7hD6yP9yb2i8dDC1oraVTzi+ZQSeOIzudkMQ+1Y3sj
         7bgG4rbrG+zmNwHPhuKYgVB6Dxz2KG9jnHK5RlID18vnFHHKDgcJiRRaxanGx/JnRvqF
         i+nvCa/CzAMFxt95AnMnQ+KkMfsu+vPYEsXIRMjOvID+3hUF2Qgna2FaGLBw4awlHS3H
         XI+Jh+6K8nASTl8cHgl3cCT+kFVZPJua5suTyo/LZslbuF2N2ApBtI/uG/mOfSiFmngt
         L2DXzw9bFxY6bmjQ72sJUInWHWQIWRNbsbbF36JCCow9qGRO91iSGBtfwhPNqQmMTaOc
         uQSQ==
X-Gm-Message-State: ACgBeo1piNLsfE2xyItKXQzKQ9LoE6CsuOFS4hnDZGX5nvqI2FoidrH/
        lAnADBXR2mNDz3hJPi9omZAgfw==
X-Google-Smtp-Source: AA6agR4y/v2f+5tzPQn4BL0zEIFPBo2KQfp3YqfpUFQm6amlJobspDMPcUOukLuqpMHhfgIEJEs+5A==
X-Received: by 2002:a5d:6d89:0:b0:228:da8b:2537 with SMTP id l9-20020a5d6d89000000b00228da8b2537mr1616678wrs.585.1662471398043;
        Tue, 06 Sep 2022 06:36:38 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id n189-20020a1ca4c6000000b003a5c244fc13sm21775621wme.2.2022.09.06.06.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 06:36:37 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 7/7] bpftool: Add llvm feature to "bpftool version"
Date:   Tue,  6 Sep 2022 14:36:13 +0100
Message-Id: <20220906133613.54928-8-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906133613.54928-1-quentin@isovalent.com>
References: <20220906133613.54928-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similarly to "libbfd", add a "llvm" feature to the output of command
"bpftool version" to indicate that LLVM is used for disassembling JIT-ed
programs. This feature is mutually exclusive with "libbfd".

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/Documentation/common_options.rst |  8 ++++----
 tools/bpf/bpftool/main.c                           | 10 ++++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/common_options.rst b/tools/bpf/bpftool/Documentation/common_options.rst
index 4107a586b68b..05350a1aadf9 100644
--- a/tools/bpf/bpftool/Documentation/common_options.rst
+++ b/tools/bpf/bpftool/Documentation/common_options.rst
@@ -7,10 +7,10 @@
 	  Print bpftool's version number (similar to **bpftool version**), the
 	  number of the libbpf version in use, and optional features that were
 	  included when bpftool was compiled. Optional features include linking
-	  against libbfd to provide the disassembler for JIT-ted programs
-	  (**bpftool prog dump jited**) and usage of BPF skeletons (some
-	  features like **bpftool prog profile** or showing pids associated to
-	  BPF objects may rely on it).
+	  against LLVM or libbfd to provide the disassembler for JIT-ted
+	  programs (**bpftool prog dump jited**) and usage of BPF skeletons
+	  (some features like **bpftool prog profile** or showing pids
+	  associated to BPF objects may rely on it).
 
 -j, --json
 	  Generate JSON output. For commands that cannot produce JSON, this
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index ccd7457f92bf..7e06ca2c5d42 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -89,6 +89,11 @@ static int do_version(int argc, char **argv)
 #else
 	const bool has_libbfd = false;
 #endif
+#ifdef HAVE_LLVM_SUPPORT
+	const bool has_llvm = true;
+#else
+	const bool has_llvm = false;
+#endif
 #ifdef BPFTOOL_WITHOUT_SKELETONS
 	const bool has_skeletons = false;
 #else
@@ -112,6 +117,7 @@ static int do_version(int argc, char **argv)
 		jsonw_name(json_wtr, "features");
 		jsonw_start_object(json_wtr);	/* features */
 		jsonw_bool_field(json_wtr, "libbfd", has_libbfd);
+		jsonw_bool_field(json_wtr, "llvm", has_llvm);
 		jsonw_bool_field(json_wtr, "libbpf_strict", !legacy_libbpf);
 		jsonw_bool_field(json_wtr, "skeletons", has_skeletons);
 		jsonw_end_object(json_wtr);	/* features */
@@ -132,6 +138,10 @@ static int do_version(int argc, char **argv)
 			printf(" libbfd");
 			nb_features++;
 		}
+		if (has_llvm) {
+			printf(" llvm");
+			nb_features++;
+		}
 		if (!legacy_libbpf) {
 			printf("%s libbpf_strict", nb_features++ ? "," : "");
 			nb_features++;
-- 
2.34.1

