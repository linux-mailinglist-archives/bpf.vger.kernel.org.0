Return-Path: <bpf+bounces-1305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD76A712679
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 14:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977E92817BB
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 12:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857BD18AFD;
	Fri, 26 May 2023 12:21:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C0C168A3
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 12:21:12 +0000 (UTC)
Received: from out-34.mta1.migadu.com (out-34.mta1.migadu.com [95.215.58.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FB5125
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 05:21:07 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1685103665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Igo+G2dOYhCKUPnfS1zvfNLkACTcic4K12WZQsUkIho=;
	b=L2qsnc11R8vujH2SjbpMlGA4JbQJZF/6LETeClUpxZ9efDYCNPHP9+dar7V+c0/8Ql1Wah
	4jhsTIRWXuKeH2711/Qo5XnBehMHHFvaV1wOzqyUwkLG5plMA7t1KIwFCUwSQ8BStfnVvG
	4PkBmnnJzVsH+QUn64F4y7yDIOeMcx0=
From: Jackie Liu <liu.yun@linux.dev>
To: olsajiri@gmail.com,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	bpf@vger.kernel.org,
	liuyun01@kylinos.cn
Subject: [PATCH v5] libbpf: kprobe.multi: Filter with available_filter_functions
Date: Fri, 26 May 2023 20:20:53 +0800
Message-Id: <20230526122053.1373871-1-liu.yun@linux.dev>
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

Use available_filter_functions check first, if failed, fallback to
kallsyms.

Here is the test eBPF program [1].
[1] https://github.com/JackieLiu1/ketones/commit/a9e76d1ba57390e533b8b3eadde97f7a4535e867

Suggested-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 tools/lib/bpf/libbpf.c | 100 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 93 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ad1ec893b41b..0914b7e98e30 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10106,6 +10106,12 @@ static const char *tracefs_uprobe_events(void)
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
@@ -10417,13 +10423,14 @@ static bool glob_match(const char *str, const char *pat)
 struct kprobe_multi_resolve {
 	const char *pattern;
 	unsigned long *addrs;
+	const char **syms;
 	size_t cap;
 	size_t cnt;
 };
 
 static int
-resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
-			const char *sym_name, void *ctx)
+kallsyms_resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
+				 const char *sym_name, void *ctx)
 {
 	struct kprobe_multi_resolve *res = ctx;
 	int err;
@@ -10440,6 +10447,77 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
 	return 0;
 }
 
+static int ftrace_resolve_kprobe_multi_cb(const char *sym_name, void *ctx)
+{
+	struct kprobe_multi_resolve *res = ctx;
+	int err;
+	char *name;
+
+	if (!glob_match(sym_name, res->pattern))
+		return 0;
+
+	err = libbpf_ensure_mem((void **) &res->syms, &res->cap,
+				sizeof(const char *), res->cnt + 1);
+	if (err)
+		return err;
+
+	name = strdup(sym_name);
+	if (!name)
+		return -errno;
+
+	res->syms[res->cnt++] = name;
+	return 0;
+}
+
+typedef int (*available_kprobe_cb_t)(const char *sym_name, void *ctx);
+
+static int
+libbpf_available_kprobes_parse(available_kprobe_cb_t cb, void *ctx)
+{
+	char sym_name[256];
+	FILE *f;
+	int ret, err = 0;
+	const char *available_path = tracefs_available_filter_functions();
+
+	f = fopen(available_path, "r");
+	if (!f) {
+		err = -errno;
+		pr_warn("failed to open %s, fallback to /proc/kallsyms.\n",
+			available_path);
+		return err;
+	}
+
+	while (true) {
+		ret = fscanf(f, "%255s%*[^\n]\n", sym_name);
+		if (ret == EOF && feof(f))
+			break;
+		if (ret != 1) {
+			pr_warn("failed to read available kprobe entry: %d\n",
+				ret);
+			err = -EINVAL;
+			break;
+		}
+
+		err = cb(sym_name, ctx);
+		if (err)
+			break;
+	}
+
+	fclose(f);
+	return err;
+}
+
+static void kprobe_multi_resolve_free(struct kprobe_multi_resolve *res)
+{
+	while (res->syms && res->cnt)
+		free((char *)res->syms[--res->cnt]);
+
+	free(res->syms);
+	free(res->addrs);
+	/* reset cap to zero, when fallback */
+	res->cap = 0;
+}
+
 struct bpf_link *
 bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 				      const char *pattern,
@@ -10476,13 +10554,21 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 		return libbpf_err_ptr(-EINVAL);
 
 	if (pattern) {
-		err = libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &res);
-		if (err)
-			goto error;
+		err = libbpf_available_kprobes_parse(ftrace_resolve_kprobe_multi_cb,
+						     &res);
+		if (err) {
+			/* fallback to kallsyms */
+			kprobe_multi_resolve_free(&res);
+			err = libbpf_kallsyms_parse(kallsyms_resolve_kprobe_multi_cb,
+						    &res);
+			if (err)
+				goto error;
+		}
 		if (!res.cnt) {
 			err = -ENOENT;
 			goto error;
 		}
+		syms = res.syms;
 		addrs = res.addrs;
 		cnt = res.cnt;
 	}
@@ -10511,12 +10597,12 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 		goto error;
 	}
 	link->fd = link_fd;
-	free(res.addrs);
+	kprobe_multi_resolve_free(&res);
 	return link;
 
 error:
 	free(link);
-	free(res.addrs);
+	kprobe_multi_resolve_free(&res);
 	return libbpf_err_ptr(err);
 }
 
-- 
2.25.1


