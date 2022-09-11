Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106165B511D
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 22:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiIKUP3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 16:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIKUP3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 16:15:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EDD1C12D
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 13:15:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t7so12257299wrm.10
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 13:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3svs1veSlQXEKs+OzbLdgeJamu/CII4Jy/jB0glIdS8=;
        b=IYANcLHPfz+UrUk2tl44OKL4nZyE5ZuZShjPqWEfwVhVy7OBUTvX+/1UWaEO8C1XfR
         MIg7roMfkx83d9QxuOXNG+Qecudpr8/McmleUgwg4pOlSstQNcW9dErj8253laX7uwrb
         eM+ewyrhkhKGYgNBWA3Qq8ReFsQ/blACsUSu9xaXJgckzBVqkn6kCESkgCe0uIkFNHFe
         GgtbF0WVmqBl67TuyQy8rZDrPKwad/GqfRgNVxtAB3IX0Kr4OiRtNULCtMcJ0Xo9OqXD
         xxTfn8T4kTsmdBBrMOX1hEVrULd0xC/F+W+G1g3EtG2uBt1Joz8yavIWM4I44kJtNQMv
         imug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3svs1veSlQXEKs+OzbLdgeJamu/CII4Jy/jB0glIdS8=;
        b=TSxgUNl7xtvJpzssOyStBUA5mIo7K4EE7DsMg8fztIx2+y8K1U7LdwVXxV2imSSpOF
         6txMBXFi0c6JOx1Uecr6dRZNmCKkdLuecktDZ2IsJgmbfF3jfJfI2KJeNVjpSrJcqRfn
         qYgr6sEICcAc5aBVzeg08bisRkiR93zSS5XJTAlACHKN2UkB0TJOLi/IDGIDwgnkQQyE
         Ia+FclaGNyEJBrUx5/oK1vuZocznxmtJTCD+PeMrFXh+W0DVXq9hQoa/2SDjIpd4CHgN
         Q+bzq4WZIbd6Ul6/S+ZT0rIuUD0Riy2YlxgTGVeSiWpRlWA575IjlVlSrBZUHTDnoxxN
         IGBw==
X-Gm-Message-State: ACgBeo2jk+A5/jnGh7lAmT6dWZeujpFBevg6Ssxc7aEF0ma0lV1fOSgf
        bxDxuvz2aL/ZDMOKc7NrA1u02w==
X-Google-Smtp-Source: AA6agR61bljDVqCAVvY6mMslz2eYM9NtUQbCi0KfvJY5eoWqmtRVeLXdIetqgeEZjUqxoPwMzY8F2w==
X-Received: by 2002:a5d:6da7:0:b0:226:e081:941a with SMTP id u7-20020a5d6da7000000b00226e081941amr13053639wrs.642.1662927325486;
        Sun, 11 Sep 2022 13:15:25 -0700 (PDT)
Received: from harfang.access.network ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id bh16-20020a05600c3d1000b003a60ff7c082sm7603789wmb.15.2022.09.11.13.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 13:15:23 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 8/8] bpftool: Add llvm feature to "bpftool version"
Date:   Sun, 11 Sep 2022 21:14:51 +0100
Message-Id: <20220911201451.12368-9-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911201451.12368-1-quentin@isovalent.com>
References: <20220911201451.12368-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Tested-by: Niklas Söderlund <niklas.soderlund@corigine.com>
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

