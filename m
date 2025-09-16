Return-Path: <bpf+bounces-68469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9E5B58DF7
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 07:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D8F3B3193
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 05:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED73C2D6E6D;
	Tue, 16 Sep 2025 05:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TJoAfaGM"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CA826A09B
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 05:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001344; cv=none; b=UEh5hr+JQLdzkuo7j9np6MLl8q103yRc5bKFrwNn/X0uyYRuL0qj0EPBEGU88fcj0yY6NqM3ZOoyZBT8EKtYn8s11FMCrmoUX2E75VLETQzk5y+N/1IQgD3WPt7QlckU+qUWmLtpQ9N7WBlSD/n5SKwIK4R34Ne/yAHicNTMzpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001344; c=relaxed/simple;
	bh=6HwE6Pr1FMZJQJTx/nBTHBpVYjdfFe2TgsDwHZ1v5Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUiBazptwotxGWCpdVrU+xHyMJ/iwpCkiGjStpu/9jCJdAxG+oH5c1jytNvqu5qTsMKBusWohVvAtg+wtYSfbgEE8pAOJK3q9Aa53r+NFz2eSXPSDruuFvFZk+85wgiBgoFzQ+uytxEbsVgIfNujpxKcibn33B7A8l5z67gis/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TJoAfaGM; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758001338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PBqXqIBAXliLEIaRmiKltx7PaLxbdrR9kdSsL/p1Hw=;
	b=TJoAfaGMOnVb76fecDrUAtJ4mE+ril5ZZgma0CWR4buu7dA7B0TlSumJB8GE8LiR8B5/sk
	gyA2dY7vOFWHtYtmMMQ556HY7ur9WATmuRpkbZPND4UiSwGIe7QDadE3x3EvYQaXfm7gx8
	+VoovEFN2HlSFIHxxaXh0sKj1Mbjp+w=
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
Subject: [PATCH bpf-next 2/2] bpftool: Fix UAF in get_delegate_value
Date: Tue, 16 Sep 2025 13:41:11 +0800
Message-ID: <20250916054111.1151487-2-chen.dylane@linux.dev>
In-Reply-To: <20250916054111.1151487-1-chen.dylane@linux.dev>
References: <20250916054111.1151487-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The return value ret pointer is pointing opts_copy, but opts_copy
gets freed in get_delegate_value before return, fix this by strdup
a new buffer.

Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/bpf/bpftool/token.c | 47 ++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
index 82b829e44c8..c47256d8038 100644
--- a/tools/bpf/bpftool/token.c
+++ b/tools/bpf/bpftool/token.c
@@ -28,6 +28,12 @@ static bool has_delegate_options(const char *mnt_ops)
 	       strstr(mnt_ops, "delegate_attachs");
 }
 
+static void free_delegate_value(char *value)
+{
+	if (value)
+		free(value);
+}
+
 static char *get_delegate_value(const char *opts, const char *key)
 {
 	char *token, *rest, *ret = NULL;
@@ -40,7 +46,7 @@ static char *get_delegate_value(const char *opts, const char *key)
 			token = strtok_r(NULL, ",", &rest)) {
 		if (strncmp(token, key, strlen(key)) == 0 &&
 		    token[strlen(key)] == '=') {
-			ret = token + strlen(key) + 1;
+			ret = strdup(token + strlen(key) + 1);
 			break;
 		}
 	}
@@ -73,28 +79,29 @@ static void print_items_per_line(const char *input, int items_per_line)
 	free(strs);
 }
 
+#define PRINT_DELEGATE_OPT(opt_name) do {				\
+	char *value = get_delegate_value(mntent->mnt_opts, opt_name);	\
+	print_items_per_line(value, ITEMS_PER_LINE);			\
+	free_delegate_value(value);					\
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
 
@@ -122,29 +129,29 @@ static void split_json_array_str(const char *input)
 	free(strs);
 }
 
+#define PRINT_DELEGATE_OPT_JSON(opt_name) do {				\
+	char *value = get_delegate_value(mntent->mnt_opts, opt_name);	\
+	split_json_array_str(value);					\
+	free_delegate_value(value);					\
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


