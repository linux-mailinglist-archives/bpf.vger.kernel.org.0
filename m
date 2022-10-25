Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FAE60CFE5
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 17:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiJYPDu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 11:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiJYPDt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 11:03:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928261B8654
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 08:03:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l14so14334997wrw.2
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 08:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHQ6Nh6S2X3LiORSKMcrUXr81sCAtwRLflLk9YztkJQ=;
        b=TuupZUhN8/Rpk5xiI5AzNBI+sZtlaB8cR22HmienOPbLorsITNwDnUsCCVGTR18GEn
         3vIwsUd/Y1XK0TxxMSdVr6L0Rom46idnTqbNRX03VhKIaen1Uvu4gI2c9xIrw5Gf3fQq
         nGJlokYfza99XdgseODpVTNMGlbLq37edcShqI3TkXBOj6hddAm3q4p+8Bv3WEC09mAn
         j/wEXYRGfgtJcvcjOOk7l+lx5ddixfafLdQc1fuCiCuQUrm7tDO+zWFY6WQb0GWzoX8M
         Zt5DiLg8bxIrnGuivw9feB4Hf3KFN41zGP45n+FSv5KmQjzHH+1wvjgApFvE7tk1iX+a
         XAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHQ6Nh6S2X3LiORSKMcrUXr81sCAtwRLflLk9YztkJQ=;
        b=Qc6jPsmUZTPNj8tnCGb3FFVKtkwkgFeRcgNKRsLzWBOKiaSGMGfqHFRn9hRFRLkrrq
         Uw9OUXkqKaE1H5jMHFNFfH11662ezfBoRSkv5gMB/J2j2ElAuHndglgHP7+0I+PuId5J
         lbEOdGtEOxuoV07TzIIQrG+l8+014f74C+QKxpsnj4niEfhvqMCqMS9yYryX4d0aYrb7
         ZFVWx5lGdlCOemDVprq2xIcdOStl3d62OtJk4JdwxKD19pGGRUejKwtGiEQ0j65k64yf
         yMztDbebxmFwJZuXM6ZZ7bDOsqROMa4ekeL7ekm+RuXPI203+sgDBqgrcsxGY3r3E3lz
         W2Cw==
X-Gm-Message-State: ACrzQf0sXM29Qub4EX7zdqiecwf9WdRUsb1pUHYac8pM7JQf/XbL4w4n
        GBUPq9SeHC4bQEs/pK+a4NmYPw==
X-Google-Smtp-Source: AMsMyM61CxQ99ov9xA+7WhuDYQQv2155C3WLqpLEjo3JB4hC1EAyFxmJhUasZSe9XVBP899cnjZEww==
X-Received: by 2002:a05:6000:1a8d:b0:236:4810:9966 with SMTP id f13-20020a0560001a8d00b0023648109966mr18094487wry.366.1666710227068;
        Tue, 25 Oct 2022 08:03:47 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id i7-20020adff307000000b0023659925b2asm2724182wro.51.2022.10.25.08.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 08:03:46 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 8/8] bpftool: Add llvm feature to "bpftool version"
Date:   Tue, 25 Oct 2022 16:03:29 +0100
Message-Id: <20221025150329.97371-9-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025150329.97371-1-quentin@isovalent.com>
References: <20221025150329.97371-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similarly to "libbfd", add a "llvm" feature to the output of command
"bpftool version" to indicate that LLVM is used for disassembling JIT-ed
programs. This feature is mutually exclusive (from Makefile definitions)
with "libbfd".

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Tested-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/Documentation/common_options.rst | 8 ++++----
 tools/bpf/bpftool/main.c                           | 7 +++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

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
index b22223df4431..741e50ee0b6c 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -119,6 +119,11 @@ static int do_version(int argc, char **argv)
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
@@ -154,6 +159,7 @@ static int do_version(int argc, char **argv)
 		jsonw_name(json_wtr, "features");
 		jsonw_start_object(json_wtr);	/* features */
 		jsonw_bool_field(json_wtr, "libbfd", has_libbfd);
+		jsonw_bool_field(json_wtr, "llvm", has_llvm);
 		jsonw_bool_field(json_wtr, "libbpf_strict", !legacy_libbpf);
 		jsonw_bool_field(json_wtr, "skeletons", has_skeletons);
 		jsonw_bool_field(json_wtr, "bootstrap", bootstrap);
@@ -172,6 +178,7 @@ static int do_version(int argc, char **argv)
 		printf("using libbpf %s\n", libbpf_version_string());
 		printf("features:");
 		print_feature("libbfd", has_libbfd, &nb_features);
+		print_feature("llvm", has_llvm, &nb_features);
 		print_feature("libbpf_strict", !legacy_libbpf, &nb_features);
 		print_feature("skeletons", has_skeletons, &nb_features);
 		print_feature("bootstrap", bootstrap, &nb_features);
-- 
2.34.1

