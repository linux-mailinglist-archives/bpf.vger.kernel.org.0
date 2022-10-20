Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4EE606060
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 14:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJTMhb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 08:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJTMha (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 08:37:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5803013D19
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 05:37:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f11so34185467wrm.6
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 05:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GV9CmvCIlsYdLq/sGCIYcCoDOmQGMNCcQVEpg6K0tb0=;
        b=O5neuHPcsnueCL+CJvWgrMUDzEkdPs/BexB0eGicHIF5o7qLLty4aDC5qcVDKVzWHd
         dH/UUjZokpwtsL3F0Owo0e/LZIyaQS9t4ZHh+EdfhIOEzyi/gMYRRHeF+u2xGO74keRQ
         kNBB7y5Im3tARFezmBc+A6N12pze3Atr/olE7BzSq8HrKNl9iETPkscpgChNeZgfLx9e
         U0oYzgsnazWT5RzjbhR/1CgI1jEIMUFvsdDuWD+WAUMhrTHVMLx8jLkLFIkOsTe9Dk5S
         boFTD2AanDgKSLuH1X1gt+B0E2D8bPdNKOPgeShBBND/0ui6kX6y9NaKVrKsHfcS5H2h
         ARQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GV9CmvCIlsYdLq/sGCIYcCoDOmQGMNCcQVEpg6K0tb0=;
        b=QoNWZqWEfeJRMhTS1ueM/hBag5jPCl0FWn9Q8v65/ZkUmIv5B2gnnJr96pNonPWYO4
         ITbwEbaLZXvJdaDrbJR67ViaqZIHVy7fB87UCwzoAi5EMWfig5UYSNMmqRsl/4yRW/dy
         4FAZmqXz32WCGnWiuAlvc0uG3Xp7ieVQFLNZVKE4xhwcYnWACE1LR3tCqAcRnMvI8OrJ
         9sKc2afi7hihTvnFryaImwpcmurHVYvkutQ/bQ4z35PBrh8u9ymO1PyLE7ev4PISJsHg
         ZAyD6nqubumwSV9Sw+1ad+vt8KoPwjodzxLu4oA5VZARbG76s+KiACq1IOck7hQRJ9M4
         evaw==
X-Gm-Message-State: ACrzQf0b7Tfji+xC/j1xN5YwLsp01+CXULmNRgXoRjqj5JVGL2q20TRo
        5uepop6XWgqGXw25+gOqA8311w==
X-Google-Smtp-Source: AMsMyM4FYNqGWyQZEiYyCaZsKNFJKOqpB6I1eKxDF0dZEZg1JiMXVp7XwyRHN3NIbuS1/Rsfix87Aw==
X-Received: by 2002:adf:e549:0:b0:230:6d12:fc84 with SMTP id z9-20020adfe549000000b002306d12fc84mr8454773wrm.64.1666269446453;
        Thu, 20 Oct 2022 05:37:26 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b0022a9246c853sm16329581wrt.41.2022.10.20.05.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 05:37:26 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 8/8] bpftool: Add llvm feature to "bpftool version"
Date:   Thu, 20 Oct 2022 13:37:04 +0100
Message-Id: <20221020123704.91203-9-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020123704.91203-1-quentin@isovalent.com>
References: <20221020123704.91203-1-quentin@isovalent.com>
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
programs. This feature is mutually exclusive with "libbfd".

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Tested-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
Note: There's a conflict on this change with the patch at
https://lore.kernel.org/bpf/20221020100332.69563-1-quentin@isovalent.com/
Supposiing both are accepted, I will of course rebase one or the other,
accordingly.
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

