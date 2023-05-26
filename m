Return-Path: <bpf+bounces-1264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70963711D80
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 04:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327BD1C20EF8
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 02:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63A917F3;
	Fri, 26 May 2023 02:11:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821B817C9
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 02:11:02 +0000 (UTC)
Received: from out-47.mta0.migadu.com (out-47.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0013A3
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 19:10:59 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1685067058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YEVicowmMkKTotgeSJrpTqhZWYlRQGdl4CaTq8FtF9s=;
	b=qHsvMoLAoTIX1cVICehY3LmJ3zto/5rjIHKRdYa4LJrLb916KLBFue62oVtOCYD7saazW4
	ZIXn6Wn8ApsM2vIyV7T4hh/N9YtjBkP8XyBUACitgENImMy8u4iegL9cKFSTE6DENGiIa5
	l7CZkaLLsnG1fUU6omwgX+YCUwGLkPw=
From: Jackie Liu <liu.yun@linux.dev>
To: olsajiri@gmail.com,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	bpf@vger.kernel.org,
	liuyun01@kylinos.cn
Subject: [PATCH v5] libbpf: kprobe.multi: Filter with available_filter_functions
Date: Fri, 26 May 2023 10:10:47 +0800
Message-Id: <20230526021047.368833-1-liu.yun@linux.dev>
In-Reply-To: <CAEf4Bzae7mdpCDBEafG-NUCPRohWkC8EBs0+twE2hUbB8LqWJA@mail.gmail.com>
References: <CAEf4Bzae7mdpCDBEafG-NUCPRohWkC8EBs0+twE2hUbB8LqWJA@mail.gmail.com>
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
 tools/lib/bpf/libbpf.c | 101 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 92 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ad1ec893b41b..5aac8fe76c0a 100644
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
@@ -10431,8 +10438,8 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
 	if (!glob_match(sym_name, res->pattern))
 		return 0;
 
-	err = libbpf_ensure_mem((void **) &res->addrs, &res->cap, sizeof(unsigned long),
-				res->cnt + 1);
+	err = libbpf_ensure_mem((void **) &res->addrs, &res->cap,
+				sizeof(unsigned long), res->cnt + 1);
 	if (err)
 		return err;
 
@@ -10440,6 +10447,75 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
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
+}
+
 struct bpf_link *
 bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 				      const char *pattern,
@@ -10476,13 +10552,20 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 		return libbpf_err_ptr(-EINVAL);
 
 	if (pattern) {
-		err = libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &res);
-		if (err)
-			goto error;
+		err = libbpf_available_kprobes_parse(ftrace_resolve_kprobe_multi_cb,
+						     &res);
+		if (err) {
+			/* fallback to kallsyms */
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
@@ -10511,12 +10594,12 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
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


