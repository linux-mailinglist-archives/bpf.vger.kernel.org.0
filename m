Return-Path: <bpf+bounces-68618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FF5B7CB81
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 699337A1E15
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 03:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1541F2D321A;
	Wed, 17 Sep 2025 03:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BRORkJgM"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD9425A2A2
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 03:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758080926; cv=none; b=jDyjLX8/LLNA232H8hkec/W8rgsOCKx6r2R7Fukbmlrn7EsODvBXQlaqboe2TXABWZwa9X7BvPwc8tie6VqQJLaHCcoXvud5+hNPmclMhaD6/iaclWGLg5PAwcwb6FIDamIbSaHvP6DbgDis1/teTWpTUi7Dk/XQFReDPQEUzI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758080926; c=relaxed/simple;
	bh=HJhEIj/EGFsVwisNyuSbquSaJhPriioYgDQ5ZPde8Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNCQo2E9RaS9kfWzMuNOXB+YDS7PXn8TAXOw1iInlwVGunbx1n+cLpYi7sw6BD7XEkrybMCNqes88Y4eDa9obmjpEM6VNZiZjUSrseu10rFrDVO2Tv9D+GVKUAOXkHodPjbnXcxYMHm+wfgZKGyawwv01TuOSEzYrpM4pW3E4gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BRORkJgM; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758080921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hge7Q8t2zGQIqH/1tKglsN7B2ICodZDLD87S/m4VssA=;
	b=BRORkJgMsPo899/cXMBFBNZ6xKFO6XwJjd9HNSgSfhd44rfyqhI6GHHPw9VdxczEAlC9bw
	2OFRILaVTk2+L+oBGbkGcpJbWSgmdmpKG8RbZ0ld9csp0q970kvcNRoOLnsClO9SiW1zyn
	GqvDmTzmE/U2dF4U+lWa8SUaCeJ8Cmk=
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
	chen.dylane@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] bpftool: Fix UAF in get_delegate_value
Date: Wed, 17 Sep 2025 11:47:32 +0800
Message-ID: <20250917034732.1185429-2-chen.dylane@linux.dev>
In-Reply-To: <20250917034732.1185429-1-chen.dylane@linux.dev>
References: <20250917034732.1185429-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The return value ret pointer is pointing opts_copy, but opts_copy
gets freed in get_delegate_value before return, fix this by free
the mntent->mnt_opts strdup memory after show delegate value.

Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/bpf/bpftool/token.c | 75 +++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 42 deletions(-)

diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
index 82b829e44c8..05bc76c7276 100644
--- a/tools/bpf/bpftool/token.c
+++ b/tools/bpf/bpftool/token.c
@@ -28,15 +28,14 @@ static bool has_delegate_options(const char *mnt_ops)
 	       strstr(mnt_ops, "delegate_attachs");
 }
 
-static char *get_delegate_value(const char *opts, const char *key)
+static char *get_delegate_value(char *opts, const char *key)
 {
 	char *token, *rest, *ret = NULL;
-	char *opts_copy = strdup(opts);
 
-	if (!opts_copy)
+	if (!opts)
 		return NULL;
 
-	for (token = strtok_r(opts_copy, ",", &rest); token;
+	for (token = strtok_r(opts, ",", &rest); token;
 			token = strtok_r(NULL, ",", &rest)) {
 		if (strncmp(token, key, strlen(key)) == 0 &&
 		    token[strlen(key)] == '=') {
@@ -44,24 +43,19 @@ static char *get_delegate_value(const char *opts, const char *key)
 			break;
 		}
 	}
-	free(opts_copy);
 
 	return ret;
 }
 
-static void print_items_per_line(const char *input, int items_per_line)
+static void print_items_per_line(char *input, int items_per_line)
 {
-	char *str, *rest, *strs;
+	char *str, *rest;
 	int cnt = 0;
 
 	if (!input)
 		return;
 
-	strs = strdup(input);
-	if (!strs)
-		return;
-
-	for (str = strtok_r(strs, ":", &rest); str;
+	for (str = strtok_r(input, ":", &rest); str;
 			str = strtok_r(NULL, ":", &rest)) {
 		if (cnt % items_per_line == 0)
 			printf("\n\t  ");
@@ -69,38 +63,39 @@ static void print_items_per_line(const char *input, int items_per_line)
 		printf("%-20s", str);
 		cnt++;
 	}
-
-	free(strs);
 }
 
+#define PRINT_DELEGATE_OPT(opt_name) do {		\
+	char *opts, *value;				\
+	opts = strdup(mntent->mnt_opts);		\
+	value = get_delegate_value(opts, opt_name);	\
+	print_items_per_line(value, ITEMS_PER_LINE);	\
+	free(opts);					\
+} while (0)
+
 #define ITEMS_PER_LINE 4
 static void show_token_info_plain(struct mntent *mntent)
 {
-	char *value;
 
 	printf("token_info  %s", mntent->mnt_dir);
 
 	printf("\n\tallowed_cmds:");
-	value = get_delegate_value(mntent->mnt_opts, "delegate_cmds");
-	print_items_per_line(value, ITEMS_PER_LINE);
+	PRINT_DELEGATE_OPT("delegate_cmds");
 
 	printf("\n\tallowed_maps:");
-	value = get_delegate_value(mntent->mnt_opts, "delegate_maps");
-	print_items_per_line(value, ITEMS_PER_LINE);
+	PRINT_DELEGATE_OPT("delegate_maps");
 
 	printf("\n\tallowed_progs:");
-	value = get_delegate_value(mntent->mnt_opts, "delegate_progs");
-	print_items_per_line(value, ITEMS_PER_LINE);
+	PRINT_DELEGATE_OPT("delegate_progs");
 
 	printf("\n\tallowed_attachs:");
-	value = get_delegate_value(mntent->mnt_opts, "delegate_attachs");
-	print_items_per_line(value, ITEMS_PER_LINE);
+	PRINT_DELEGATE_OPT("delegate_attachs");
 	printf("\n");
 }
 
-static void split_json_array_str(const char *input)
+static void split_json_array_str(char *input)
 {
-	char *str, *rest, *strs;
+	char *str, *rest;
 
 	if (!input) {
 		jsonw_start_array(json_wtr);
@@ -108,43 +103,39 @@ static void split_json_array_str(const char *input)
 		return;
 	}
 
-	strs = strdup(input);
-	if (!strs)
-		return;
-
 	jsonw_start_array(json_wtr);
-	for (str = strtok_r(strs, ":", &rest); str;
+	for (str = strtok_r(input, ":", &rest); str;
 			str = strtok_r(NULL, ":", &rest)) {
 		jsonw_string(json_wtr, str);
 	}
 	jsonw_end_array(json_wtr);
-
-	free(strs);
 }
 
+#define PRINT_DELEGATE_OPT_JSON(opt_name) do {		\
+	char *opts, *value;				\
+	opts = strdup(mntent->mnt_opts);		\
+	value = get_delegate_value(opts, opt_name);	\
+	split_json_array_str(value);			\
+	free(opts);					\
+} while (0)
+
 static void show_token_info_json(struct mntent *mntent)
 {
-	char *value;
-
 	jsonw_start_object(json_wtr);
 
 	jsonw_string_field(json_wtr, "token_info", mntent->mnt_dir);
 
 	jsonw_name(json_wtr, "allowed_cmds");
-	value = get_delegate_value(mntent->mnt_opts, "delegate_cmds");
-	split_json_array_str(value);
+	PRINT_DELEGATE_OPT_JSON("delegate_cmds");
 
 	jsonw_name(json_wtr, "allowed_maps");
-	value = get_delegate_value(mntent->mnt_opts, "delegate_maps");
-	split_json_array_str(value);
+	PRINT_DELEGATE_OPT_JSON("delegate_maps");
 
 	jsonw_name(json_wtr, "allowed_progs");
-	value = get_delegate_value(mntent->mnt_opts, "delegate_progs");
-	split_json_array_str(value);
+	PRINT_DELEGATE_OPT_JSON("delegate_progs");
 
 	jsonw_name(json_wtr, "allowed_attachs");
-	value = get_delegate_value(mntent->mnt_opts, "delegate_attachs");
-	split_json_array_str(value);
+	PRINT_DELEGATE_OPT_JSON("delegate_attachs");
 
 	jsonw_end_object(json_wtr);
 }
-- 
2.48.1


