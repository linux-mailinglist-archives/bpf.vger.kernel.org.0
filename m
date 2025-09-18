Return-Path: <bpf+bounces-68777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E59CB8484D
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 14:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165FB1C83901
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079D92EAB68;
	Thu, 18 Sep 2025 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WwOCUgSy"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2662E2C08B2
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197400; cv=none; b=i8q4/RRkQQ3RONt+OAcq1m54dnnxGlSA0i/76uso5Eyh7SI0w8Ua/7teobVrEnKv9u8GZ2EU5y94I2gPEK8KTQq4fRNFR6B8sZjTJ76Yw24/0RVxVpoqDbIUEL/MxZnJd4WDkH4/p0ZKOjAXt+QCcScEZoOxJEU5UYfr5mr9bRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197400; c=relaxed/simple;
	bh=HPWDvVvZFp0Al1cAgGloqtq5hQbxjXEJXYnhHINu37g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrsByGcSZrLi2IBEor4oPWb910QZRt9WL9eLGxeIQzzdMICycXD7gUfvsCCiUdty9R8bv5zzLz51VpQAILRS8TJSg4WsznDz4pnvO/O2+rbeggwCcqrtOO2kFH+HthtWVfgHPbPhXUhn/+7LMk0idMWnZlvronsVsj+rDC2Z2V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WwOCUgSy; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758197385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8jolFmDH4ogl9vwxtpxZ+7+PbiwgVjtHWsh4DqmjD+0=;
	b=WwOCUgSy5eG38yzlTnVxNAGofCLHaaOCH6ALv8YlD9F7h3PmYQxHD6VdTn59jPwVAkHC3x
	gOiTl7O/8M7T1fwORrIW6959sl2HN+9WsJckcEYPz63IN4FKBJjabfK4esdesMB6xb9xaw
	4BXCaDlNs9xmPCEgOKTJBZ32iGS+myU=
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
Subject: [PATCH bpf-next v3 2/2] bpftool: Fix UAF in get_delegate_value
Date: Thu, 18 Sep 2025 20:09:08 +0800
Message-ID: <20250918120908.1255263-2-chen.dylane@linux.dev>
In-Reply-To: <20250918120908.1255263-1-chen.dylane@linux.dev>
References: <20250918120908.1255263-1-chen.dylane@linux.dev>
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
 tools/bpf/bpftool/token.c | 90 +++++++++++++++------------------------
 1 file changed, 35 insertions(+), 55 deletions(-)

diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
index 82b829e44c8..20c4c78a8a8 100644
--- a/tools/bpf/bpftool/token.c
+++ b/tools/bpf/bpftool/token.c
@@ -20,6 +20,16 @@
 
 #define MOUNTS_FILE "/proc/mounts"
 
+struct {
+	const char *header;
+	const char *key;
+} sets[] = {
+	{"allowed_cmds", "delegate_cmds"},
+	{"allowed_maps", "delegate_maps"},
+	{"allowed_progs", "delegate_progs"},
+	{"allowed_attachs", "delegate_attachs"},
+};
+
 static bool has_delegate_options(const char *mnt_ops)
 {
 	return strstr(mnt_ops, "delegate_cmds") ||
@@ -28,15 +38,14 @@ static bool has_delegate_options(const char *mnt_ops)
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
@@ -44,24 +53,19 @@ static char *get_delegate_value(const char *opts, const char *key)
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
@@ -69,38 +73,29 @@ static void print_items_per_line(const char *input, int items_per_line)
 		printf("%-20s", str);
 		cnt++;
 	}
-
-	free(strs);
 }
 
 #define ITEMS_PER_LINE 4
 static void show_token_info_plain(struct mntent *mntent)
 {
-	char *value;
+	char *opts, *value;
 
 	printf("token_info  %s", mntent->mnt_dir);
 
-	printf("\n\tallowed_cmds:");
-	value = get_delegate_value(mntent->mnt_opts, "delegate_cmds");
-	print_items_per_line(value, ITEMS_PER_LINE);
-
-	printf("\n\tallowed_maps:");
-	value = get_delegate_value(mntent->mnt_opts, "delegate_maps");
-	print_items_per_line(value, ITEMS_PER_LINE);
-
-	printf("\n\tallowed_progs:");
-	value = get_delegate_value(mntent->mnt_opts, "delegate_progs");
-	print_items_per_line(value, ITEMS_PER_LINE);
+	for (size_t i = 0; i < ARRAY_SIZE(sets); i++) {
+		printf("\n\t%s:", sets[i].header);
+		opts = strdup(mntent->mnt_opts);
+		value = get_delegate_value(opts, sets[i].key);
+		print_items_per_line(value, ITEMS_PER_LINE);
+		free(opts);
+	}
 
-	printf("\n\tallowed_attachs:");
-	value = get_delegate_value(mntent->mnt_opts, "delegate_attachs");
-	print_items_per_line(value, ITEMS_PER_LINE);
 	printf("\n");
 }
 
-static void split_json_array_str(const char *input)
+static void split_json_array_str(char *input)
 {
-	char *str, *rest, *strs;
+	char *str, *rest;
 
 	if (!input) {
 		jsonw_start_array(json_wtr);
@@ -108,43 +103,28 @@ static void split_json_array_str(const char *input)
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
 
 static void show_token_info_json(struct mntent *mntent)
 {
-	char *value;
+	char *opts, *value;
 
 	jsonw_start_object(json_wtr);
-
 	jsonw_string_field(json_wtr, "token_info", mntent->mnt_dir);
 
-	jsonw_name(json_wtr, "allowed_cmds");
-	value = get_delegate_value(mntent->mnt_opts, "delegate_cmds");
-	split_json_array_str(value);
-
-	jsonw_name(json_wtr, "allowed_maps");
-	value = get_delegate_value(mntent->mnt_opts, "delegate_maps");
-	split_json_array_str(value);
-
-	jsonw_name(json_wtr, "allowed_progs");
-	value = get_delegate_value(mntent->mnt_opts, "delegate_progs");
-	split_json_array_str(value);
-
-	jsonw_name(json_wtr, "allowed_attachs");
-	value = get_delegate_value(mntent->mnt_opts, "delegate_attachs");
-	split_json_array_str(value);
+	for (size_t i = 0; i < ARRAY_SIZE(sets); i++) {
+		jsonw_name(json_wtr, sets[i].header);
+		opts = strdup(mntent->mnt_opts);
+		value = get_delegate_value(opts, sets[i].key);
+		split_json_array_str(value);
+		free(opts);
+	}
 
 	jsonw_end_object(json_wtr);
 }
-- 
2.48.1


