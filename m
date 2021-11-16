Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55CC4528B2
	for <lists+bpf@lfdr.de>; Tue, 16 Nov 2021 04:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhKPDtM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 22:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbhKPDtF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Nov 2021 22:49:05 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A03C12DD00
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 16:04:50 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id j6-20020a17090276c600b0014377d8ede3so6814266plt.21
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 16:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mEaMzpGT8hwzie7SmcRFLqRLRjuEaBx07b4e/3XlXwY=;
        b=PdC1XcYa/KFQGUdiCqiZuWN02RfhAtZRr1yWPRxSJyn2jf/ZNHwf2XiIUN7LlUXPKS
         K02N3jJXeZUYOgYTSJsNhshIhoyW22AeZXvOZ4+uhKFBYNM8NfdDAYpjna/U7OkmkDUz
         paS4Zbx8KJHbQIFBJo9iTq76ZFMQUnvRgatVsR4+GzqiEaG0+iffwYyFgWOcsQFnaQOp
         QIDeYziSAZMX+RM4mRyZpGs9AWmsa35IplydD+7toRIL+R3TsNCUtOsEW0QTjHcGDZkR
         xv3BV1eH5gdQCmy8vhbBUyIDJA6MyA8p6qYu608the8Ujmi4AU1Wat0JLHTRsj9WIQ2+
         zLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mEaMzpGT8hwzie7SmcRFLqRLRjuEaBx07b4e/3XlXwY=;
        b=JNCPlMmvA9YEmIeFw4BCuAzh/Vl0kCjBu0Ato4VCTJVSmxINAf+2EkTKZtw8h8xaRI
         qxceXcaALBH4qGwsXw+wQnEBJqFRQ5pg0CIMVoDSE1XUTsXIIO7ClztUrCfh7UmK/nPU
         Snio4WfYH5+tXTloaGznB+a9zIi0uzhBoqKk7VF13s/BtSF5k83YKsxCIOHcHPxyr/Rg
         khj9VP0t7kmfo280VrFrnDXbdz3CGw/1rxrdgw9FUmhxLqFdXDT2L2jufCHxoChPEo0U
         rpokmCDTXobZEygOWBuKaLYdc2PjeUEXaqQmkGXVluv1FRl/MiahPd9MuvUWZQ0JNO2x
         zXDg==
X-Gm-Message-State: AOAM533ww+p75+2fxnw4vF0gnTc25c9cdMcvP3qy//vlCuzlcZQMDaq0
        Mdg9wEa/Na9hF2/2L5xqA0g1uFA=
X-Google-Smtp-Source: ABdhPJyVt6ATF8DQLrtA9kidX6nUhi241mxdKcVDkTvzuBu7eZcr+OLE/k+OFe1hpQwD0MwJMfVZHT8=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:b159:a155:9460:f1ca])
 (user=sdf job=sendgmr) by 2002:a17:902:7c02:b0:143:9d6a:8e42 with SMTP id
 x2-20020a1709027c0200b001439d6a8e42mr39553699pll.80.1637021090387; Mon, 15
 Nov 2021 16:04:50 -0800 (PST)
Date:   Mon, 15 Nov 2021 16:04:48 -0800
Message-Id: <20211116000448.2918854-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH bpf-next v3] bpftool: add current libbpf_strict mode to
 version output
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

+ bpftool --legacy --version
bpftool v5.15.0
features: libbfd, skeletons
+ bpftool --version
bpftool v5.15.0
features: libbfd, libbpf_strict, skeletons

+ bpftool --legacy --help
Usage: bpftool [OPTIONS] OBJECT { COMMAND | help }
       bpftool batch file FILE
       bpftool version

       OBJECT := { prog | map | link | cgroup | perf | net | feature | btf | gen | struct_ops | iter }
       OPTIONS := { {-j|--json} [{-p|--pretty}] | {-d|--debug} | {-l|--legacy} |
                    {-V|--version} }
+ bpftool --help
Usage: bpftool [OPTIONS] OBJECT { COMMAND | help }
       bpftool batch file FILE
       bpftool version

       OBJECT := { prog | map | link | cgroup | perf | net | feature | btf | gen | struct_ops | iter }
       OPTIONS := { {-j|--json} [{-p|--pretty}] | {-d|--debug} | {-l|--legacy} |
                    {-V|--version} }

+ bpftool --legacy
Usage: bpftool [OPTIONS] OBJECT { COMMAND | help }
       bpftool batch file FILE
       bpftool version

       OBJECT := { prog | map | link | cgroup | perf | net | feature | btf | gen | struct_ops | iter }
       OPTIONS := { {-j|--json} [{-p|--pretty}] | {-d|--debug} | {-l|--legacy} |
                    {-V|--version} }
+ bpftool
Usage: bpftool [OPTIONS] OBJECT { COMMAND | help }
       bpftool batch file FILE
       bpftool version

       OBJECT := { prog | map | link | cgroup | perf | net | feature | btf | gen | struct_ops | iter }
       OPTIONS := { {-j|--json} [{-p|--pretty}] | {-d|--debug} | {-l|--legacy} |
                    {-V|--version} }

+ bpftool --legacy version
bpftool v5.15.0
features: libbfd, skeletons
+ bpftool version
bpftool v5.15.0
features: libbfd, libbpf_strict, skeletons

+ bpftool --json --legacy version
{"version":"5.15.0","features":{"libbfd":true,"libbpf_strict":false,"skeletons":true}}
+ bpftool --json version
{"version":"5.15.0","features":{"libbfd":true,"libbpf_strict":true,"skeletons":true}}

v3:
- preserve proper exit status (Quentin Monnet)

v2:
- fixes for -h and -V (Quentin Monnet)

Suggested-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/bpftool/main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 473791e87f7d..8b71500e7cb2 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -93,6 +93,7 @@ static int do_version(int argc, char **argv)
 		jsonw_name(json_wtr, "features");
 		jsonw_start_object(json_wtr);	/* features */
 		jsonw_bool_field(json_wtr, "libbfd", has_libbfd);
+		jsonw_bool_field(json_wtr, "libbpf_strict", !legacy_libbpf);
 		jsonw_bool_field(json_wtr, "skeletons", has_skeletons);
 		jsonw_end_object(json_wtr);	/* features */
 
@@ -106,6 +107,10 @@ static int do_version(int argc, char **argv)
 			printf(" libbfd");
 			nb_features++;
 		}
+		if (!legacy_libbpf) {
+			printf("%s libbpf_strict", nb_features++ ? "," : "");
+			nb_features++;
+		}
 		if (has_skeletons)
 			printf("%s skeletons", nb_features++ ? "," : "");
 		printf("\n");
@@ -400,6 +405,7 @@ int main(int argc, char **argv)
 		{ "legacy",	no_argument,	NULL,	'l' },
 		{ 0 }
 	};
+	bool version_requested = false;
 	int opt, ret;
 
 	last_do_help = do_help;
@@ -414,7 +420,8 @@ int main(int argc, char **argv)
 				  options, NULL)) >= 0) {
 		switch (opt) {
 		case 'V':
-			return do_version(argc, argv);
+			version_requested = true;
+			break;
 		case 'h':
 			return do_help(argc, argv);
 		case 'p':
@@ -479,6 +486,9 @@ int main(int argc, char **argv)
 	if (argc < 0)
 		usage();
 
+	if (version_requested)
+		return do_version(argc, argv);
+
 	ret = cmd_select(cmds, argc, argv, do_help);
 
 	if (json_output)
-- 
2.34.0.rc1.387.gb447b232ab-goog

