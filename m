Return-Path: <bpf+bounces-3935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A334C74679F
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 04:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F628280F09
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 02:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F697625;
	Tue,  4 Jul 2023 02:35:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE69181
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 02:35:00 +0000 (UTC)
Received: from out-40.mta1.migadu.com (out-40.mta1.migadu.com [IPv6:2001:41d0:203:375::28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B070B188
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 19:34:58 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1688438095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uHbYoVq30EpzujCoRi565ex9enRDsWDf1OCdTam+DxA=;
	b=Ay6zVRBPI7gZG1rHx0AUk5ydWYL6MlRbAOmj5x1wIR0LdN99hD+5HNiBBAsOIneCzlVcgv
	u7BSfc3YJlv4dh71znGLH9r77nNz1R/CHMKfy6IiNFtczKrUp+gwSTdvwev62xdT83tqYM
	wcobxZ964loeEjyFip/rC7t6kf8Gf8Q=
From: Jackie Liu <liu.yun@linux.dev>
To: olsajiri@gmail.com,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	bpf@vger.kernel.org,
	liuyun01@kylinos.cn,
	lkp@intel.com
Subject: [PATCH v4 1/2] libbpf: kprobe.multi: cross filter using available_filter_functions and kallsyms
Date: Tue,  4 Jul 2023 10:34:43 +0800
Message-Id: <20230704023444.2079069-1-liu.yun@linux.dev>
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

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307030355.TdXOHklM-lkp@intel.com/
Suggested-by: Jiri Olsa <jolsa@kernel.org>
Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 v3->v4: fix some issue suggested by jiri

 tools/lib/bpf/libbpf.c | 126 +++++++++++++++++++++++++++++++++++------
 1 file changed, 109 insertions(+), 17 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 214f828ece6b..9db0ff6f111f 100644
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
+	char sym_name[500];
+	const char *available_functions_file = tracefs_available_filter_functions();
+	FILE *f;
+	int err = 0, ret, i;
+	const char **syms;
+	size_t cap = 0, cnt = 0;
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
+		ret = fscanf(f, "%499s%*[^\n]\n", sym_name);
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
+		err = libbpf_ensure_mem((void **)&syms, &cap, sizeof(void *),
+					cnt + 1);
+		if (err)
+			goto cleanup;
+
+		name = strdup(sym_name);
+		if (!name) {
+			err = -errno;
+			goto cleanup;
+		}
+
+		syms[cnt++] = name;
+	}
+	fclose(f);
+
+	/* not found entry, return direct */
+	if (!cnt)
+		return -ENOENT;
+
+	/* sort available functions */
+	qsort(syms, cnt, sizeof(void *), qsort_compare_function);
+
+	f = fopen("/proc/kallsyms", "r");
+	if (!f) {
+		err = -errno;
+		pr_warn("failed to open /proc/kallsyms\n");
+		goto free_syms;
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
+			goto cleanup;
+		}
+
+		if (!bsearch(&sym_name, syms, cnt, sizeof(void *), bsearch_compare_function))
+			continue;
+
+		err = libbpf_ensure_mem((void **)&res->addrs, &res->cap,
+					sizeof(unsigned long), res->cnt + 1);
+		if (err)
+			goto cleanup;
+
+		res->addrs[res->cnt++] = (unsigned long) sym_addr;
+	}
+
+	if (!res->cnt)
+		err = -ENOENT;
+
+cleanup:
+	fclose(f);
+free_syms:
+	for (i = 0; i < cnt; i++)
+		free((char *)syms[i]);
+	free(syms);
+
+	return err;
 }
 
 struct bpf_link *
@@ -10594,13 +10690,9 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 		return libbpf_err_ptr(-EINVAL);
 
 	if (pattern) {
-		err = libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &res);
+		err = libbpf_available_kallsyms_parse(&res);
 		if (err)
 			goto error;
-		if (!res.cnt) {
-			err = -ENOENT;
-			goto error;
-		}
 		addrs = res.addrs;
 		cnt = res.cnt;
 	}
-- 
2.25.1


