Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99BE44C8EB
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 20:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhKJT0P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 14:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhKJT0O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 14:26:14 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6456C061766
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 11:23:26 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id t75-20020a63784e000000b002993a9284b0so1972078pgc.11
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 11:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2BhfvpKgEGwBch9CFGgvPmLPYxOzsJ+OgrHbpWvHr2E=;
        b=JxXb3C1P59Cc7Y1fCwFldAPQJhx773b4m6+ht3LUT+y16h5QzAjrxcH4ybzkbw9kEc
         YO+OADBe0cvXPL3z6b9wayDZaM3gxSmPSCL6wVMGcbaoiBroHDxqEVts6GMlvpMckjs1
         DIEBQQ0jfmXqqgpLp+LjWyQDmluQYjm5CDUC+OcnZPrsTCYLlrl8rq+RY+FQo+wuZix/
         z+OEKt8eaQU6zGj7mC8dcT/gSGvaZgyWOwba1mLg/8/Ti0rBP4MsEUxziS/owNPvMAbn
         mmh981V2o04V+I/qy7RbUfjv5u62nJnN48VhWFCglUK6hnMIFkBxI3ypZ0NE5YEXy8F2
         R0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2BhfvpKgEGwBch9CFGgvPmLPYxOzsJ+OgrHbpWvHr2E=;
        b=X+s5ccuJ6mZ8Xxpf1Hsl4zKFR4Ln2sY3RjKO3PdaSRLc2IdYUb+WtIt88o18RAEqrn
         anCD4XQFCy9OqGUVsPctHK9dO9nIT0dAgNuTqwfBKlWch5mUF8YWX9x/xZ9xHI3N/KWH
         ITOFRpWYj1qI/OrZ33x+2y59Eb2WbkvjeYqw0STXc0Ay1co/oqMTMEZbU+KLIvSEqLhe
         dgI+97i8AWjXPlkSlWoz2xwcag4hdP+K7CQ8XkBBVTaWH+Puu1w2WYjWI0Th6qJBeLc/
         yIRrbjc8xSVNoZCMfHXCcTzwjAoJ/wNnFept8ne/uwJIfEIoECJzzWB8cLGMMTQXwwyO
         +qzA==
X-Gm-Message-State: AOAM532XO8IG3vbIPQgyVhXu4HzfsVSHLYw0yRje783F+4Done8bH5cC
        D8rd54oqK8ILoZ+cfWQ10T1FhD4=
X-Google-Smtp-Source: ABdhPJwE+KTAHGX6NcN6E2WoRR0yd4wPOZH5m3y9ilAilNCVDPnC+In8loqxB+OH6fg45d7J6EIA1fM=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:a4b:588d:e527:9a6c])
 (user=sdf job=sendgmr) by 2002:a63:6d81:: with SMTP id i123mr786106pgc.121.1636572205978;
 Wed, 10 Nov 2021 11:23:25 -0800 (PST)
Date:   Wed, 10 Nov 2021 11:23:24 -0800
Message-Id: <20211110192324.920934-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH bpf-next v2] bpftool: enable libbpf's strict mode by default
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin@isovalent.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Otherwise, attaching with bpftool doesn't work with strict section names.

Also:

- add --legacy option to switch back to pre-1.0 behavior
- print a warning when program fails to load in strict mode to point
  to --legacy flag
- by default, don't append / to the section name; in strict
  mode it's relevant only for a small subset of prog types

+ bpftool --legacy prog loadall tools/testing/selftests/bpf/test_cgroup_link.o /sys/fs/bpf/kprobe type kprobe
libbpf: failed to pin program: File exists
Error: failed to pin all programs
+ bpftool prog loadall tools/testing/selftests/bpf/test_cgroup_link.o /sys/fs/bpf/kprobe type kprobe

v2:
- strict by default (Quentin Monnet)
- add more info to --legacy description (Quentin Monnet)
- add bash completion (Quentin Monnet)

Cc: Quentin Monnet <quentin@isovalent.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../bpftool/Documentation/common_options.rst  |  9 +++++
 tools/bpf/bpftool/bash-completion/bpftool     |  2 +-
 tools/bpf/bpftool/main.c                      | 13 +++++-
 tools/bpf/bpftool/main.h                      |  3 +-
 tools/bpf/bpftool/prog.c                      | 40 +++++++++++--------
 5 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/common_options.rst b/tools/bpf/bpftool/Documentation/common_options.rst
index 05d06c74dcaa..75adf23202d8 100644
--- a/tools/bpf/bpftool/Documentation/common_options.rst
+++ b/tools/bpf/bpftool/Documentation/common_options.rst
@@ -20,3 +20,12 @@
 	  Print all logs available, even debug-level information. This includes
 	  logs from libbpf as well as from the verifier, when attempting to
 	  load programs.
+
+-l, --legacy
+	  Use legacy libbpf mode which has more relaxed BPF program
+	  requirements. By default, bpftool has more strict requirements
+	  about section names, changes pinning logic and doesn't support
+	  some of the older non-BTF map declarations.
+
+	  See https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0
+	  for details.
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 88e2bcf16cca..4a1b02ff72c1 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -261,7 +261,7 @@ _bpftool()
     # Deal with options
     if [[ ${words[cword]} == -* ]]; then
         local c='--version --json --pretty --bpffs --mapcompat --debug \
-	       --use-loader --base-btf'
+	       --use-loader --base-btf --legacy'
         COMPREPLY=( $( compgen -W "$c" -- "$cur" ) )
         return 0
     fi
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 28237d7cef67..473791e87f7d 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -31,6 +31,7 @@ bool block_mount;
 bool verifier_logs;
 bool relaxed_maps;
 bool use_loader;
+bool legacy_libbpf;
 struct btf *base_btf;
 struct hashmap *refs_table;
 
@@ -396,6 +397,7 @@ int main(int argc, char **argv)
 		{ "debug",	no_argument,	NULL,	'd' },
 		{ "use-loader",	no_argument,	NULL,	'L' },
 		{ "base-btf",	required_argument, NULL, 'B' },
+		{ "legacy",	no_argument,	NULL,	'l' },
 		{ 0 }
 	};
 	int opt, ret;
@@ -408,7 +410,7 @@ int main(int argc, char **argv)
 	bin_name = argv[0];
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "VhpjfLmndB:",
+	while ((opt = getopt_long(argc, argv, "VhpjfLmndB:l",
 				  options, NULL)) >= 0) {
 		switch (opt) {
 		case 'V':
@@ -454,6 +456,9 @@ int main(int argc, char **argv)
 		case 'L':
 			use_loader = true;
 			break;
+		case 'l':
+			legacy_libbpf = true;
+			break;
 		default:
 			p_err("unrecognized option '%s'", argv[optind - 1]);
 			if (json_output)
@@ -463,6 +468,12 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (!legacy_libbpf) {
+		ret = libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+		if (ret)
+			p_err("failed to enable libbpf strict mode: %d", ret);
+	}
+
 	argc -= optind;
 	argv += optind;
 	if (argc < 0)
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 383835c2604d..8d76d937a62b 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -57,7 +57,7 @@ static inline void *u64_to_ptr(__u64 ptr)
 #define HELP_SPEC_PROGRAM						\
 	"PROG := { id PROG_ID | pinned FILE | tag PROG_TAG | name PROG_NAME }"
 #define HELP_SPEC_OPTIONS						\
-	"OPTIONS := { {-j|--json} [{-p|--pretty}] | {-d|--debug}"
+	"OPTIONS := { {-j|--json} [{-p|--pretty}] | {-d|--debug} | {-l|--legacy}"
 #define HELP_SPEC_MAP							\
 	"MAP := { id MAP_ID | pinned FILE | name MAP_NAME }"
 #define HELP_SPEC_LINK							\
@@ -90,6 +90,7 @@ extern bool block_mount;
 extern bool verifier_logs;
 extern bool relaxed_maps;
 extern bool use_loader;
+extern bool legacy_libbpf;
 extern struct btf *base_btf;
 extern struct hashmap *refs_table;
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index dea7a49ec26e..bf85c914f2fa 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1483,8 +1483,6 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 
 	while (argc) {
 		if (is_prefix(*argv, "type")) {
-			char *type;
-
 			NEXT_ARG();
 
 			if (common_prog_type != BPF_PROG_TYPE_UNSPEC) {
@@ -1494,21 +1492,26 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 			if (!REQ_ARGS(1))
 				goto err_free_reuse_maps;
 
-			/* Put a '/' at the end of type to appease libbpf */
-			type = malloc(strlen(*argv) + 2);
-			if (!type) {
-				p_err("mem alloc failed");
-				goto err_free_reuse_maps;
-			}
-			*type = 0;
-			strcat(type, *argv);
-			strcat(type, "/");
+			err = libbpf_prog_type_by_name(*argv, &common_prog_type,
+						       &expected_attach_type);
+			if (err < 0) {
+				/* Put a '/' at the end of type to appease libbpf */
+				char *type = malloc(strlen(*argv) + 2);
 
-			err = get_prog_type_by_name(type, &common_prog_type,
-						    &expected_attach_type);
-			free(type);
-			if (err < 0)
-				goto err_free_reuse_maps;
+				if (!type) {
+					p_err("mem alloc failed");
+					goto err_free_reuse_maps;
+				}
+				*type = 0;
+				strcat(type, *argv);
+				strcat(type, "/");
+
+				err = get_prog_type_by_name(type, &common_prog_type,
+							    &expected_attach_type);
+				free(type);
+				if (err < 0)
+					goto err_free_reuse_maps;
+			}
 
 			NEXT_ARG();
 		} else if (is_prefix(*argv, "map")) {
@@ -1731,6 +1734,11 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 	else
 		bpf_object__unpin_programs(obj, pinfile);
 err_close_obj:
+	if (!legacy_libbpf) {
+		p_info("Warning: bpftool is now running in libbpf strict mode and has more stringent requirements about BPF programs.\n"
+		       "If it used to work for this object file but now doesn't, see --legacy option for more details.\n");
+	}
+
 	bpf_object__close(obj);
 err_free_reuse_maps:
 	for (i = 0; i < old_map_fds; i++)
-- 
2.34.0.rc0.344.g81b53c2807-goog

