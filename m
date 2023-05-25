Return-Path: <bpf+bounces-1217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA695710A0E
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 12:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4AE92814AF
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 10:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D826E572;
	Thu, 25 May 2023 10:27:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E316D2EF
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:27:59 +0000 (UTC)
Received: from out-20.mta0.migadu.com (out-20.mta0.migadu.com [IPv6:2001:41d0:1004:224b::14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B76E6
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 03:27:57 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1685010475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8jXQVx65DUKzx95tFzYCFwmOdnYHhwEFoU4fiDnSYA=;
	b=UdCn7yGWMtx6ri0t1NZEjLmhRwN95o682mZGB4VauJgRs7iD/4Ko428LlQChr5rJ3HlWja
	51z06+VZz+Kdk/lZfUD7zZJwAqkuvmG//vVlhrrYHDZpjf/Uk3JVtxCKqniTLaqcNxPBYc
	e1+Z4vJBPrYduG0EWs2RjFVFnGNEp5w=
From: Jackie Liu <liu.yun@linux.dev>
To: olsajiri@gmail.com,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	bpf@vger.kernel.org,
	liuyun01@kylinos.cn
Subject: [PATCH v4] libbpf: kprobe.multi: Filter with available_filter_functions
Date: Thu, 25 May 2023 18:27:47 +0800
Message-Id: <20230525102747.68708-1-liu.yun@linux.dev>
In-Reply-To: <ZG8f7ffghG7mLUhR@krava>
References: <ZG8f7ffghG7mLUhR@krava>
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
 tools/lib/bpf/libbpf.c | 92 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 83 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ad1ec893b41b..3dd72d69cdf7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10417,13 +10417,14 @@ static bool glob_match(const char *str, const char *pat)
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
@@ -10431,8 +10432,8 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
 	if (!glob_match(sym_name, res->pattern))
 		return 0;
 
-	err = libbpf_ensure_mem((void **) &res->addrs, &res->cap, sizeof(unsigned long),
-				res->cnt + 1);
+	err = libbpf_ensure_mem((void **) &res->addrs, &res->cap,
+				sizeof(unsigned long), res->cnt + 1);
 	if (err)
 		return err;
 
@@ -10440,6 +10441,73 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
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
+		return errno;
+
+	res->syms[res->cnt++] = name;
+	return 0;
+}
+
+typedef int (*available_filter_functions_cb_t)(const char *sym_name, void *ctx);
+
+static int
+libbpf_ftrace_parse(available_filter_functions_cb_t cb, void *ctx)
+{
+	char sym_name[256];
+	FILE *f;
+	int ret, err = 0;
+
+	f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
+	if (!f) {
+		pr_warn("failed to open available_filter_functions, fallback to /proc/kallsyms.\n");
+		return -EINVAL;
+	}
+
+	while (true) {
+		ret = fscanf(f, "%s%*[^\n]\n", sym_name);
+		if (ret == EOF && feof(f))
+			break;
+		if (ret != 1) {
+			pr_warn("failed to read available_filter_functions entry: %d\n",
+				ret);
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
+	if (res->syms) {
+		while (res->cnt)
+			free((char *)res->syms[--res->cnt]);
+		free(res->syms);
+	} else {
+		free(res->addrs);
+	}
+}
+
 struct bpf_link *
 bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 				      const char *pattern,
@@ -10476,13 +10544,19 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 		return libbpf_err_ptr(-EINVAL);
 
 	if (pattern) {
-		err = libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &res);
-		if (err)
-			goto error;
+		err = libbpf_ftrace_parse(ftrace_resolve_kprobe_multi_cb, &res);
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
@@ -10511,12 +10585,12 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
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


