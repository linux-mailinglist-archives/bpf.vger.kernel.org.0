Return-Path: <bpf+bounces-64032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888F4B0D8AB
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 13:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368BE17DAE9
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 11:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081602E2EFF;
	Tue, 22 Jul 2025 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s8XpoOgD"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91012E4260
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185524; cv=none; b=n9/X1B3alfXjwRlhEzxb2vbdzQJgoHOZG6G92vCoAA2/Uq4mcfjIV9K61rn/RJdMtP2+tKxGxiZAkOGPbigEOOj4QkoVtFQHJFgdsQf7zrwdSWfqSAPH8BK7LE3ql/3oyRyt0dFMy+Zwni+wO8Hg0zBgAW6lwkmJjqEaRB/N3yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185524; c=relaxed/simple;
	bh=UWOsxDW4wNbm+cwDgqi8i0/t6t8eiMPBQol3sPy5HDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCS7Yq+DgbGbh62Dilp41Ctde3BguHGVEyXrcB8e+sY8EBU+ePz4xNz7tx54DlQK5fZA+ZFqIac5NJJEngXV9ddLcavX6DZ6MGPw+wElGorfM+C8MLDzoL7Ac42fiH7iWK1gppMrwIEOi96Uayf67UZfVxZIkZocs+cH7WlLLqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s8XpoOgD; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753185517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pLbp31z2Sp/stf08Tea2LEkAy17kQTrn/aAQvN+dazk=;
	b=s8XpoOgDzUTb9HRzBFKrAftf3dPrcfE3OeMTfo6jxq4Z3Lcpohl/qsuEvrskdy6sUwb812
	OcgSnnxhaYdm+HVgu7BPOz7+9lnQJCsQq3n8rxeOQmcgJJC9M9Giyj/8eM/CbyC8gwr7TM
	XLzUnGqwgms6fACiwRnwyk0S1NA9W6Q=
From: Tao Chen <chen.dylane@linux.dev>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v2 1/3] bpftool: Add bpf_token show
Date: Tue, 22 Jul 2025 19:58:13 +0800
Message-ID: <20250722115815.1390761-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add `bpftool token show` command to get token info
from bpffs in /proc/mounts.

Example plain output for `token show`:
token_info  /sys/fs/bpf/token
	allowed_cmds:
	  map_create          prog_load
	allowed_maps:
	allowed_progs:
	  kprobe
	allowed_attachs:
	  xdp
token_info  /sys/fs/bpf/token2
	allowed_cmds:
	  map_create          prog_load
	allowed_maps:
	allowed_progs:
	  kprobe
	allowed_attachs:
	  xdp

Example json output for `token show`:
[{
	"token_info": "/sys/fs/bpf/token",
	"allowed_cmds": ["map_create", "prog_load"],
	"allowed_maps": [],
	"allowed_progs": ["kprobe"],
	"allowed_attachs": ["xdp"]
}, {
	"token_info": "/sys/fs/bpf/token2",
	"allowed_cmds": ["map_create", "prog_load"],
	"allowed_maps": [],
	"allowed_progs": ["kprobe"],
	"allowed_attachs": ["xdp"]
}]

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/bpf/bpftool/main.c  |   3 +-
 tools/bpf/bpftool/main.h  |   1 +
 tools/bpf/bpftool/token.c | 232 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 235 insertions(+), 1 deletion(-)
 create mode 100644 tools/bpf/bpftool/token.c

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 2b7f2bd3a7d..0f1183b2ed0 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -61,7 +61,7 @@ static int do_help(int argc, char **argv)
 		"       %s batch file FILE\n"
 		"       %s version\n"
 		"\n"
-		"       OBJECT := { prog | map | link | cgroup | perf | net | feature | btf | gen | struct_ops | iter }\n"
+		"       OBJECT := { prog | map | link | cgroup | perf | net | feature | btf | gen | struct_ops | iter | token }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-V|--version} }\n"
 		"",
@@ -87,6 +87,7 @@ static const struct cmd commands[] = {
 	{ "gen",	do_gen },
 	{ "struct_ops",	do_struct_ops },
 	{ "iter",	do_iter },
+	{ "token",	do_token },
 	{ "version",	do_version },
 	{ 0 }
 };
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 6db704fda5c..a2bb0714b3d 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -166,6 +166,7 @@ int do_tracelog(int argc, char **arg) __weak;
 int do_feature(int argc, char **argv) __weak;
 int do_struct_ops(int argc, char **argv) __weak;
 int do_iter(int argc, char **argv) __weak;
+int do_token(int argc, char **argv) __weak;
 
 int parse_u32_arg(int *argc, char ***argv, __u32 *val, const char *what);
 int prog_parse_fd(int *argc, char ***argv);
diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
new file mode 100644
index 00000000000..f72a116f9c6
--- /dev/null
+++ b/tools/bpf/bpftool/token.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/* Copyright (C) 2025 Didi Technology Co., Tao Chen */
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <mntent.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include "json_writer.h"
+#include "main.h"
+
+#define MOUNTS_FILE "/proc/mounts"
+
+static bool has_delegate_options(const char *mnt_ops)
+{
+	return strstr(mnt_ops, "delegate_cmds") != NULL ||
+	       strstr(mnt_ops, "delegate_maps") != NULL ||
+	       strstr(mnt_ops, "delegate_progs") != NULL ||
+	       strstr(mnt_ops, "delegate_attachs") != NULL;
+}
+
+static char *get_delegate_value(const char *opts, const char *key)
+{
+	char *token, *rest, *ret = NULL;
+	char *opts_copy = strdup(opts);
+
+	if (!opts_copy)
+		return NULL;
+
+	for (token = strtok_r(opts_copy, ",", &rest); token != NULL;
+			token = strtok_r(NULL, ",", &rest)) {
+		if (strncmp(token, key, strlen(key)) == 0 &&
+				token[strlen(key)] == '=') {
+			ret = token + strlen(key) + 1;
+			break;
+		}
+	}
+	free(opts_copy);
+
+	return ret;
+}
+
+static void print_items_per_line(const char *input, int items_per_line)
+{
+	char *str, *rest, *strs;
+	int cnt = 0;
+
+	if (!input)
+		return;
+
+	strs = strdup(input);
+	if (!strs)
+		return;
+
+	for (str = strtok_r(strs, ":", &rest); str != NULL;
+			str = strtok_r(NULL, ":", &rest)) {
+		if (cnt % items_per_line == 0)
+			printf("\n\t  ");
+
+		printf("%-20s", str);
+		cnt++;
+	}
+
+	free(strs);
+}
+
+#define ITEMS_PER_LINE 4
+static void show_token_info_plain(struct mntent *mntent)
+{
+	char *value;
+
+	printf("token_info  %s", mntent->mnt_dir);
+
+	printf("\n\tallowed_cmds:");
+	value = get_delegate_value(mntent->mnt_opts, "delegate_cmds");
+	print_items_per_line(value, ITEMS_PER_LINE);
+
+	printf("\n\tallowed_maps:");
+	value = get_delegate_value(mntent->mnt_opts, "delegate_maps");
+	print_items_per_line(value, ITEMS_PER_LINE);
+
+	printf("\n\tallowed_progs:");
+	value = get_delegate_value(mntent->mnt_opts, "delegate_progs");
+	print_items_per_line(value, ITEMS_PER_LINE);
+
+	printf("\n\tallowed_attachs:");
+	value = get_delegate_value(mntent->mnt_opts, "delegate_attachs");
+	print_items_per_line(value, ITEMS_PER_LINE);
+	printf("\n");
+}
+
+static void split_json_array_str(const char *input)
+{
+	char *str, *rest, *strs;
+
+	if (!input) {
+		jsonw_start_array(json_wtr);
+		jsonw_end_array(json_wtr);
+		return;
+	}
+
+	strs = strdup(input);
+	if (!strs)
+		return;
+
+	jsonw_start_array(json_wtr);
+	for (str = strtok_r(strs, ":", &rest); str != NULL;
+			str = strtok_r(NULL, ":", &rest)) {
+		jsonw_string(json_wtr, str);
+	}
+	jsonw_end_array(json_wtr);
+
+	free(strs);
+}
+
+static void show_token_info_json(struct mntent *mntent)
+{
+	char *value;
+
+	jsonw_start_object(json_wtr);
+
+	jsonw_string_field(json_wtr, "token_info", mntent->mnt_dir);
+
+	jsonw_name(json_wtr, "allowed_cmds");
+	value = get_delegate_value(mntent->mnt_opts, "delegate_cmds");
+	split_json_array_str(value);
+
+	jsonw_name(json_wtr, "allowed_maps");
+	value = get_delegate_value(mntent->mnt_opts, "delegate_maps");
+	split_json_array_str(value);
+
+	jsonw_name(json_wtr, "allowed_progs");
+	value = get_delegate_value(mntent->mnt_opts, "delegate_progs");
+	split_json_array_str(value);
+
+	jsonw_name(json_wtr, "allowed_attachs");
+	value = get_delegate_value(mntent->mnt_opts, "delegate_attachs");
+	split_json_array_str(value);
+
+	jsonw_end_object(json_wtr);
+}
+
+static int __show_token_info(struct mntent *mntent)
+{
+
+	if (json_output)
+		show_token_info_json(mntent);
+	else
+		show_token_info_plain(mntent);
+
+	return 0;
+}
+
+static int show_token_info(void)
+{
+	FILE *fp;
+	struct mntent *ent;
+	bool hit = false;
+
+	fp = setmntent(MOUNTS_FILE, "r");
+	if (!fp) {
+		p_err("Failed to open: %s", MOUNTS_FILE);
+		return -1;
+	}
+
+	if (json_output)
+		jsonw_start_array(json_wtr);
+
+	while ((ent = getmntent(fp)) != NULL) {
+		if (strncmp(ent->mnt_type, "bpf", 3) == 0) {
+			if (has_delegate_options(ent->mnt_opts)) {
+				__show_token_info(ent);
+				hit = true;
+			}
+		}
+	}
+
+	if (json_output)
+		jsonw_end_array(json_wtr);
+
+	if (!hit)
+		p_info("Token info not found");
+
+	endmntent(fp);
+
+	return 0;
+}
+
+static int do_show(int argc, char **argv)
+{
+	if (argc)
+		return BAD_ARG();
+
+	return show_token_info();
+}
+
+static int do_help(int argc, char **argv)
+{
+	if (json_output) {
+		jsonw_null(json_wtr);
+		return 0;
+	}
+
+	fprintf(stderr,
+		"Usage: %1$s %2$s { show | list }\n"
+		"	%1$s %2$s help\n"
+		"\n"
+		"",
+		bin_name, argv[-2]);
+	return 0;
+}
+
+static const struct cmd cmds[] = {
+	{ "show",	do_show },
+	{ "list",	do_show },
+	{ "help",	do_help },
+	{ 0 }
+};
+
+int do_token(int argc, char **argv)
+{
+	return cmd_select(cmds, argc, argv, do_help);
+}
-- 
2.48.1


