Return-Path: <bpf+bounces-3840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 244C77447EE
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 10:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC492280D10
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 08:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F54522B;
	Sat,  1 Jul 2023 08:08:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF4B441B
	for <bpf@vger.kernel.org>; Sat,  1 Jul 2023 08:08:33 +0000 (UTC)
Received: from out-24.mta0.migadu.com (out-24.mta0.migadu.com [IPv6:2001:41d0:1004:224b::18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC76B0
	for <bpf@vger.kernel.org>; Sat,  1 Jul 2023 01:08:30 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1688198908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qIyMz2czfMAGGjfJ22MsX2tzifZepv8wr+AdouQjvjE=;
	b=FTPSk3gomX++e0cZVdMdHfJgb5/ghUsaAeMPVENmjcFoaDIDJk7FMgevQauzCeG3dp9CzE
	mYMExkbW+ZvoELNl+Dw3ZPdvSFc61mvOVJNjghjDQea5AUwcLHtsbjphe99n8Zn63v9Tzl
	qOw1rHrG5CdBVnTyD+hm3UyW4Jp53LA=
From: Jackie Liu <liu.yun@linux.dev>
To: olsajiri@gmail.com,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	bpf@vger.kernel.org,
	liuyun01@kylinos.cn
Subject: [PATCH v2 1/2] libbpf: kprobe.multi: cross filter using available_filter_functions and kallsyms
Date: Sat,  1 Jul 2023 16:08:16 +0800
Message-Id: <20230701080817.1768865-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jackie Liu <liuyun01@kylinos.cn>

When using regular expression matching with "kprobe multi", it scans all
the functions under "/proc/kallsyms" that can be matched. However, not all
of them can be traced by kprobe.multi. If any one of the functions fails
to be traced, it will result in the failure of all functions. The best
approach is to filter out the functions that cannot be traced to ensure
proper tracking of the functions.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 tools/lib/bpf/libbpf.c | 122 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 109 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 214f828ece6b..8ea13de02c67 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10224,6 +10224,12 @@ static const char *tracefs_uprobe_events(void)
 	return use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/uprobe_events";
 }
 
+static const char *tracefs_available_filter_functions(void)
+{
+	return use_debugfs() ? DEBUGFS"/available_filter_functions" :
+			       TRACEFS"/available_filter_functions";
+}
+
 static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
 					 const char *kfunc_name, size_t offset)
 {
@@ -10539,23 +10545,113 @@ struct kprobe_multi_resolve {
 	size_t cnt;
 };
 
-static int
-resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
-			const char *sym_name, void *ctx)
+static int qsort_compare_function(const void *a, const void *b)
 {
-	struct kprobe_multi_resolve *res = ctx;
-	int err;
+	return strcmp(*(const char **)a, *(const char **)b);
+}
 
-	if (!glob_match(sym_name, res->pattern))
-		return 0;
+static int bsearch_compare_function(const void *a, const void *b)
+{
+	return strcmp((const char *)a, *(const char **)b);
+}
 
-	err = libbpf_ensure_mem((void **) &res->addrs, &res->cap, sizeof(unsigned long),
-				res->cnt + 1);
-	if (err)
+static int libbpf_available_kallsyms_parse(struct kprobe_multi_resolve *res)
+{
+	char sym_name[256];
+	const char *available_functions_file = tracefs_available_filter_functions();
+	FILE *f;
+	int err = 0, ret, i;
+	struct function_info {
+		const char **syms;
+		size_t cap;
+		size_t cnt;
+	} infos = {};
+
+	f = fopen(available_functions_file, "r");
+	if (!f) {
+		err = -errno;
+		pr_warn("failed to open %s\n", available_functions_file);
 		return err;
+	}
 
-	res->addrs[res->cnt++] = (unsigned long) sym_addr;
-	return 0;
+	while (true) {
+		char *name;
+
+		ret = fscanf(f, "%s%*[^\n]\n", sym_name);
+		if (ret == EOF && feof(f))
+			break;
+
+		if (ret != 1) {
+			pr_warn("failed to read available function file entry: %d\n",
+				ret);
+			err = -EINVAL;
+			goto cleanup;
+		}
+
+		if (!glob_match(sym_name, res->pattern))
+			continue;
+
+		err = libbpf_ensure_mem((void **)&infos.syms, &infos.cap,
+					sizeof(void *), infos.cnt + 1);
+		if (err)
+			goto cleanup;
+
+		name = strdup(sym_name);
+		if (!name) {
+			err = -errno;
+			goto cleanup;
+		}
+
+		infos.syms[infos.cnt++] = name;
+	}
+	fclose(f);
+
+	/* sort available functions */
+	qsort(infos.syms, infos.cnt, sizeof(void *), qsort_compare_function);
+
+	f = fopen("/proc/kallsyms", "r");
+	if (!f) {
+		err = -errno;
+		pr_warn("failed to open /proc/kallsyms\n");
+		goto free_infos;
+	}
+
+	while (true) {
+		unsigned long long sym_addr;
+
+		ret = fscanf(f, "%llx %*c %499s%*[^\n]\n", &sym_addr, sym_name);
+		if (ret == EOF && feof(f))
+			break;
+
+		if (ret != 2) {
+			pr_warn("failed to read kallsyms entry: %d\n", ret);
+			err = -EINVAL;
+			break;
+		}
+
+		if (!glob_match(sym_name, res->pattern))
+			continue;
+
+		if (!bsearch(&sym_name, infos.syms, infos.cnt, sizeof(void *),
+			     bsearch_compare_function))
+			continue;
+
+		err = libbpf_ensure_mem((void **)&res->addrs, &res->cap,
+					sizeof(unsigned long), res->cnt + 1);
+		if (err)
+			break;
+
+		res->addrs[res->cnt++] = (unsigned long)sym_addr;
+	}
+
+cleanup:
+	fclose(f);
+free_infos:
+	for (i = 0; i < infos.cnt; i++)
+		free((char *)infos.syms[i]);
+	free(infos.syms);
+
+	return err;
 }
 
 struct bpf_link *
@@ -10594,7 +10690,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 		return libbpf_err_ptr(-EINVAL);
 
 	if (pattern) {
-		err = libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &res);
+		err = libbpf_available_kallsyms_parse(&res);
 		if (err)
 			goto error;
 		if (!res.cnt) {
-- 
2.25.1


