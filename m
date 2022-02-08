Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8774AD822
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 13:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344218AbiBHMG4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 07:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiBHMG4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 07:06:56 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E03C03FECF
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 04:06:55 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id st12so26747864ejc.4
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 04:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8fg00wYmgzGrMExRIHkll4yjvNxK+wTB/UV5qRmgneg=;
        b=cV8bIyZrbx+gtv+N/d+5xTcHKMz9Fei/XdNdWQvam5P2LKa279Fub7hBvDzUMki275
         d06x0RMMCAU8i3FiOpwq/CehPjDthqWHEuKcOhPtSsE5SK7VJHkajSSsv7AJMSVVz7vZ
         goT3d4jlT67noDZxR0FyokVepsSqZ06Bkb7FKq1vd+ef9zWXY1MDu7PFIEYJpRfWRTEV
         WHOjjEMCzF1F0JzrGfs51IG0zdw+v2z9kcE6ZkycrYKN+pXhkhs1W4VlfYsnHSxjFbCM
         qCcF1GJ1xPKpDtr84EGA8edfU2ZfTyJtXuyPiwWtZtTkGLVpR3XWJw4CgqkeBxcH6bOR
         XJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8fg00wYmgzGrMExRIHkll4yjvNxK+wTB/UV5qRmgneg=;
        b=roC4VrwDV/P+sMaNh0KU2PLUhpckcRYEzB2+YHlZv7Qy0gb4x8tOGtgUILbcjND569
         JnEX5rfSIfQgG0TdudXgbURz9inr0soTQ8f4wuKSSi+I5iCgDg9D69eoJQOp2KTp99oU
         5LAfXOzBvgcbP/DUXGfEwoOrl0TvipkUvLaEcB0EuOAsckPZqDHT4xVHNILc7QzuG1Kp
         SSh71l4YlBvmyr+waQP1JJpvke6PXvo5Ok/RUN4q/EYFIn6ugsg+1cixx0VPuHi81E8T
         BYCvv4RN0Peh2yX5/1w4sU42YNa6LZhxpWh8KA+E2qrcMl5+36jrjUewWU0X/Y30NzYG
         vssQ==
X-Gm-Message-State: AOAM533dlOSdLaJYa/+Coify5i/Y8SEHXDJrKvgA1Syc+1BjoRD4oN7q
        ueuLAD7eI6AOpWYq1tKH4BhsJg==
X-Google-Smtp-Source: ABdhPJyuvMBdSe2bNtslbnVFFXVnDfWJlLAybtE1CDhZ/H3kXJr70siSdBEvfiqjaQYT5wPW41txNQ==
X-Received: by 2002:a17:906:7383:: with SMTP id f3mr1212371ejl.687.1644322013816;
        Tue, 08 Feb 2022 04:06:53 -0800 (PST)
Received: from localhost.localdomain ([149.86.77.242])
        by smtp.gmail.com with ESMTPSA id m17sm5567351edr.62.2022.02.08.04.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:06:53 -0800 (PST)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 1/3] bpftool: Add libbpf's version number to "bpftool version" output
Date:   Tue,  8 Feb 2022 12:06:46 +0000
Message-Id: <20220208120648.49169-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208120648.49169-1-quentin@isovalent.com>
References: <20220208120648.49169-1-quentin@isovalent.com>
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

To help users check what version of libbpf is being used with bpftool,
print the number along with bpftool's own version number.

Output:

    $ ./bpftool version
    ./bpftool v5.16.0
    using libbpf v0.7
    features: libbfd, libbpf_strict, skeletons

    $ ./bpftool version --json --pretty
    {
        "version": "5.16.0",
        "libbpf_version": "0.7",
        "features": {
            "libbfd": true,
            "libbpf_strict": true,
            "skeletons": true
        }
    }

Note that libbpf_version_string() does note return the patch number.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/Documentation/common_options.rst | 13 +++++++------
 tools/bpf/bpftool/main.c                           |  4 ++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/common_options.rst b/tools/bpf/bpftool/Documentation/common_options.rst
index 908487b9c2ad..c88e4c6a06d2 100644
--- a/tools/bpf/bpftool/Documentation/common_options.rst
+++ b/tools/bpf/bpftool/Documentation/common_options.rst
@@ -4,12 +4,13 @@
 	  Print short help message (similar to **bpftool help**).
 
 -V, --version
-	  Print version number (similar to **bpftool version**), and optional
-	  features that were included when bpftool was compiled. Optional
-	  features include linking against libbfd to provide the disassembler
-	  for JIT-ted programs (**bpftool prog dump jited**) and usage of BPF
-	  skeletons (some features like **bpftool prog profile** or showing
-	  pids associated to BPF objects may rely on it).
+	  Print bpftool's version number (similar to **bpftool version**), the
+	  number of the version of libbpf in use, and optional features that
+	  were included when bpftool was compiled. Optional features include
+	  linking against libbfd to provide the disassembler for JIT-ted
+	  programs (**bpftool prog dump jited**) and usage of BPF skeletons
+	  (some features like **bpftool prog profile** or showing pids
+	  associated to BPF objects may rely on it).
 
 -j, --json
 	  Generate JSON output. For commands that cannot produce JSON, this
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 490f7bd54e4c..6265ac5bcf4e 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -89,6 +89,9 @@ static int do_version(int argc, char **argv)
 
 		jsonw_name(json_wtr, "version");
 		jsonw_printf(json_wtr, "\"%s\"", BPFTOOL_VERSION);
+		jsonw_name(json_wtr, "libbpf_version");
+		/* Offset by one to skip the "v" prefix */
+		jsonw_printf(json_wtr, "\"%s\"", libbpf_version_string() + 1);
 
 		jsonw_name(json_wtr, "features");
 		jsonw_start_object(json_wtr);	/* features */
@@ -102,6 +105,7 @@ static int do_version(int argc, char **argv)
 		unsigned int nb_features = 0;
 
 		printf("%s v%s\n", bin_name, BPFTOOL_VERSION);
+		printf("using libbpf %s\n", libbpf_version_string());
 		printf("features:");
 		if (has_libbfd) {
 			printf(" libbfd");
-- 
2.32.0

