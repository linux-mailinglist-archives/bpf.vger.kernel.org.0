Return-Path: <bpf+bounces-3379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9E573CDBE
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 03:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688F9280FBB
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 01:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7661D62C;
	Sun, 25 Jun 2023 01:14:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A657F
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 01:14:18 +0000 (UTC)
Received: from out-13.mta0.migadu.com (out-13.mta0.migadu.com [91.218.175.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6336B180
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:14:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1687655655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TGC4A9cBAZU+YrWtMMYq1EJQqi1FlIs4MUsVdbCdQqo=;
	b=Vh4bk/1mA7CBRLQRhYd6Y7U3Kj8PyMpgROptw2LBk1gQWrGd5c1SovGwAvm5TihTKsxgvn
	Eh0rJgiifJEZadoXpIyvhYA1TjRiF1ljBI6dPIisNuVynDjxaNLqKEww9HXV/nzYtkzLaW
	JJ9GOrJ8NEHl/g5OqMZylC1+yEsE/1I=
From: Jackie Liu <liu.yun@linux.dev>
To: olsajiri@gmail.com,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	bpf@vger.kernel.org,
	liuyun01@kylinos.cn
Subject: [PATCH v2] libbpf: kprobe.multi: Filter with available_filter_functions_addrs
Date: Sun, 25 Jun 2023 09:13:26 +0800
Message-Id: <20230625011326.1729020-1-liu.yun@linux.dev>
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
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jackie Liu <liuyun01@kylinos.cn>

When using regular expression matching with "kprobe multi", it scans all
the functions under "/proc/kallsyms" that can be matched. However, not all
of them can be traced by kprobe.multi. If any one of the functions fails
to be traced, it will result in the failure of all functions. The best
approach is to filter out the functions that cannot be traced to ensure
proper tracking of the functions.

Use available_filter_functions_addrs check first, if failed, fallback to
kallsyms.

Here is the test eBPF program [1].
[1] https://github.com/JackieLiu1/ketones/tree/master/src/funccount

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 tools/lib/bpf/libbpf.c | 81 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a27f6e9ccce7..fca5d2e412c5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10107,6 +10107,12 @@ static const char *tracefs_uprobe_events(void)
 	return use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/uprobe_events";
 }
 
+static const char *tracefs_available_filter_functions_addrs(void)
+{
+	return use_debugfs() ? DEBUGFS"/available_filter_functions_addrs" :
+			       TRACEFS"/available_filter_functions_addrs";
+}
+
 static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
 					 const char *kfunc_name, size_t offset)
 {
@@ -10422,9 +10428,8 @@ struct kprobe_multi_resolve {
 	size_t cnt;
 };
 
-static int
-resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
-			const char *sym_name, void *ctx)
+static int ftrace_resolve_kprobe_multi_cb(unsigned long long sym_addr,
+					  const char *sym_name, void *ctx)
 {
 	struct kprobe_multi_resolve *res = ctx;
 	int err;
@@ -10441,6 +10446,63 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
 	return 0;
 }
 
+static int
+kallsyms_resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
+				 const char *sym_name, void *ctx)
+{
+	return ftrace_resolve_kprobe_multi_cb(sym_addr, sym_name, ctx);
+}
+
+typedef int (*available_kprobe_cb_t)(unsigned long long sym_addr,
+				     const char *sym_name, void *ctx);
+
+static int
+libbpf_available_kprobes_parse(available_kprobe_cb_t cb, void *ctx)
+{
+	unsigned long long sym_addr;
+	char sym_name[256];
+	FILE *f;
+	int ret, err = 0;
+	const char *available_path = tracefs_available_filter_functions_addrs();
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
+		ret = fscanf(f, "%llx %255s%*[^\n]\n", &sym_addr, sym_name);
+		if (ret == EOF && feof(f))
+			break;
+		if (ret != 2) {
+			pr_warn("failed to read available kprobe entry: %d\n",
+				ret);
+			err = -EINVAL;
+			break;
+		}
+
+		err = cb(sym_addr, sym_name, ctx);
+		if (err)
+			break;
+	}
+
+	fclose(f);
+	return err;
+}
+
+static void kprobe_multi_resolve_reinit(struct kprobe_multi_resolve *res)
+{
+	free(res->addrs);
+
+	/* reset to zero, when fallback */
+	res->cap = 0;
+	res->cnt = 0;
+	res->addrs = NULL;
+}
+
 struct bpf_link *
 bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 				      const char *pattern,
@@ -10477,9 +10539,16 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 		return libbpf_err_ptr(-EINVAL);
 
 	if (pattern) {
-		err = libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &res);
-		if (err)
-			goto error;
+		err = libbpf_available_kprobes_parse(ftrace_resolve_kprobe_multi_cb,
+						     &res);
+		if (err) {
+			/* fallback to kallsyms */
+			kprobe_multi_resolve_reinit(&res);
+			err = libbpf_kallsyms_parse(kallsyms_resolve_kprobe_multi_cb,
+						    &res);
+			if (err)
+				goto error;
+		}
 		if (!res.cnt) {
 			err = -ENOENT;
 			goto error;
-- 
2.25.1


