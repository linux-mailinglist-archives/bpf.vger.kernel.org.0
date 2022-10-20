Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF71605BCE
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 12:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJTKDn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 06:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJTKDm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 06:03:42 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CC6FAA65
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 03:03:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id e18so14570292wmq.3
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 03:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HEDXAbcixc8o+P0bYiuI3arcPHGvX72uBEpjUzldvk8=;
        b=SbCW+ZS7/gXggBgGnNeS7aUtOXGuLu/pUk3apaibNoOrTLmCtbY5bcMGarVzFdBgSl
         DElC3FJDosMOJ91gPvq2oMViTwZRx6T31Ka2XjtHOwvzwpPl0hzjaCPOAnViVUuDqSgU
         Nk4eLLgTXAWPdEBK1ZG7Oi8jJOhPFPKUVql7iDDTlGqeX49wRRgeufXX4jyTzJIWL6FW
         hxajpCyDZe2rfuJxW2eQsxPH0HzhVsLkWNBJOfqeElXl9hj5FhqDgCcvv7R86shqx4VY
         awLjIr8IYhWzl5MYLcYEB3cnXeYpmspTuiPlGZ1Mo//iNMGePDWObNEtrh7mtZjUxBFE
         jG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEDXAbcixc8o+P0bYiuI3arcPHGvX72uBEpjUzldvk8=;
        b=QHbW6iM6tIwz+ikjLRQJE6DYC4rc/F+wruAQ0Omr9GTRbyBHlq+N2qN2nY5rIXX4Hp
         eJWrCaGnI5qzONtiZ+XtuRdU9aDh9vkyY8ma28/HlJ6seSBBsr3MnT+vpL1/qx+kzsgl
         FHWDz3pBJYW4PZJ2PZuCgjvKWgHBof61OukAqK3NaLBlsKxVf7lciFS7cClGMfUxvfmn
         zI+fOcPB/5SeS+IN9qSuggyPazxea9aeIVGAvYIwbuOv4UPYhH6imDB1PcL9NqVMqUcX
         OgDA3Hj6dauSWc9yQjUGx3GnLGJfKOlCr1zaENvbMeAv5NHpRFGny5eUwL162Rc2uUfY
         mo+Q==
X-Gm-Message-State: ACrzQf3hTfi8Xu7iAYv/IzajTxGtP5HRsiGG06VkC2xowNBrT+GPSCYB
        legVdw1wm77TY+vnqimRyEEKug==
X-Google-Smtp-Source: AMsMyM74jgQ++LgOlrkliq4ZyV06jK9uqWw/HL7zC+tWTXIS0IV39nxvQOSusaFA8M07MW8TEHfoPg==
X-Received: by 2002:a05:600c:4e94:b0:3c6:f648:9a29 with SMTP id f20-20020a05600c4e9400b003c6f6489a29mr14852609wmq.59.1666260219335;
        Thu, 20 Oct 2022 03:03:39 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c4ecc00b003b4ac05a8a4sm3274465wmq.27.2022.10.20.03.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 03:03:38 -0700 (PDT)
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
        bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next] bpftool: Add "bootstrap" feature to version output
Date:   Thu, 20 Oct 2022 11:03:32 +0100
Message-Id: <20221020100332.69563-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Along with the version number, "bpftool version" displays a list of
features that were selected at compilation time for bpftool. It would be
useful to indicate in that list whether a binary is a bootstrap version
of bpftool. Given that an increasing number of components rely on
bootstrap versions for generating skeletons, this could help understand
what a binary is capable of if it has been copied outside of the usual
"bootstrap" directory.

To detect a bootstrap version, we simply rely on the absence of
implementation for the do_prog() function. To do this, we must move the
(unchanged) list of commands before do_version(), which in turn requires
renaming this "cmds" array to avoid shadowing it with the "cmds"
argument in cmd_select().

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/main.c | 81 ++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 32 deletions(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 8bf3615f684f..b22223df4431 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -71,6 +71,27 @@ static int do_help(int argc, char **argv)
 	return 0;
 }
 
+static int do_batch(int argc, char **argv);
+static int do_version(int argc, char **argv);
+
+static const struct cmd commands[] = {
+	{ "help",	do_help },
+	{ "batch",	do_batch },
+	{ "prog",	do_prog },
+	{ "map",	do_map },
+	{ "link",	do_link },
+	{ "cgroup",	do_cgroup },
+	{ "perf",	do_perf },
+	{ "net",	do_net },
+	{ "feature",	do_feature },
+	{ "btf",	do_btf },
+	{ "gen",	do_gen },
+	{ "struct_ops",	do_struct_ops },
+	{ "iter",	do_iter },
+	{ "version",	do_version },
+	{ 0 }
+};
+
 #ifndef BPFTOOL_VERSION
 /* bpftool's major and minor version numbers are aligned on libbpf's. There is
  * an offset of 6 for the version number, because bpftool's version was higher
@@ -82,6 +103,15 @@ static int do_help(int argc, char **argv)
 #define BPFTOOL_PATCH_VERSION 0
 #endif
 
+static void
+print_feature(const char *feature, bool state, unsigned int *nb_features)
+{
+	if (state) {
+		printf("%s %s", *nb_features ? "," : "", feature);
+		*nb_features = *nb_features + 1;
+	}
+}
+
 static int do_version(int argc, char **argv)
 {
 #ifdef HAVE_LIBBFD_SUPPORT
@@ -94,6 +124,18 @@ static int do_version(int argc, char **argv)
 #else
 	const bool has_skeletons = true;
 #endif
+	bool bootstrap = false;
+	int i;
+
+	for (i = 0; commands[i].cmd; i++) {
+		if (!strcmp(commands[i].cmd, "prog")) {
+			/* Assume we run a bootstrap version if "bpftool prog"
+			 * is not available.
+			 */
+			bootstrap = !commands[i].func;
+			break;
+		}
+	}
 
 	if (json_output) {
 		jsonw_start_object(json_wtr);	/* root object */
@@ -114,6 +156,7 @@ static int do_version(int argc, char **argv)
 		jsonw_bool_field(json_wtr, "libbfd", has_libbfd);
 		jsonw_bool_field(json_wtr, "libbpf_strict", !legacy_libbpf);
 		jsonw_bool_field(json_wtr, "skeletons", has_skeletons);
+		jsonw_bool_field(json_wtr, "bootstrap", bootstrap);
 		jsonw_end_object(json_wtr);	/* features */
 
 		jsonw_end_object(json_wtr);	/* root object */
@@ -128,16 +171,10 @@ static int do_version(int argc, char **argv)
 #endif
 		printf("using libbpf %s\n", libbpf_version_string());
 		printf("features:");
-		if (has_libbfd) {
-			printf(" libbfd");
-			nb_features++;
-		}
-		if (!legacy_libbpf) {
-			printf("%s libbpf_strict", nb_features++ ? "," : "");
-			nb_features++;
-		}
-		if (has_skeletons)
-			printf("%s skeletons", nb_features++ ? "," : "");
+		print_feature("libbfd", has_libbfd, &nb_features);
+		print_feature("libbpf_strict", !legacy_libbpf, &nb_features);
+		print_feature("skeletons", has_skeletons, &nb_features);
+		print_feature("bootstrap", bootstrap, &nb_features);
 		printf("\n");
 	}
 	return 0;
@@ -279,26 +316,6 @@ static int make_args(char *line, char *n_argv[], int maxargs, int cmd_nb)
 	return n_argc;
 }
 
-static int do_batch(int argc, char **argv);
-
-static const struct cmd cmds[] = {
-	{ "help",	do_help },
-	{ "batch",	do_batch },
-	{ "prog",	do_prog },
-	{ "map",	do_map },
-	{ "link",	do_link },
-	{ "cgroup",	do_cgroup },
-	{ "perf",	do_perf },
-	{ "net",	do_net },
-	{ "feature",	do_feature },
-	{ "btf",	do_btf },
-	{ "gen",	do_gen },
-	{ "struct_ops",	do_struct_ops },
-	{ "iter",	do_iter },
-	{ "version",	do_version },
-	{ 0 }
-};
-
 static int do_batch(int argc, char **argv)
 {
 	char buf[BATCH_LINE_LEN_MAX], contline[BATCH_LINE_LEN_MAX];
@@ -386,7 +403,7 @@ static int do_batch(int argc, char **argv)
 			jsonw_name(json_wtr, "output");
 		}
 
-		err = cmd_select(cmds, n_argc, n_argv, do_help);
+		err = cmd_select(commands, n_argc, n_argv, do_help);
 
 		if (json_output)
 			jsonw_end_object(json_wtr);
@@ -528,7 +545,7 @@ int main(int argc, char **argv)
 	if (version_requested)
 		return do_version(argc, argv);
 
-	ret = cmd_select(cmds, argc, argv, do_help);
+	ret = cmd_select(commands, argc, argv, do_help);
 
 	if (json_output)
 		jsonw_destroy(&json_wtr);
-- 
2.34.1

