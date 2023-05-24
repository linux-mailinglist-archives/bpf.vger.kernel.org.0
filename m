Return-Path: <bpf+bounces-1154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3646F70F139
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 10:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF211C20AF8
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 08:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33A5C15C;
	Wed, 24 May 2023 08:42:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACBF8472
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 08:42:05 +0000 (UTC)
Received: from out-57.mta1.migadu.com (out-57.mta1.migadu.com [95.215.58.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603CAFC
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 01:42:03 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1684917721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3itpCBk09cZ+yAVYdHeWHJJAtq3R3K33i3Jfr3K31xs=;
	b=ZCNpCwY95XDiwcwoZdGI/Q6ibQthCkT/t7lcT19A0MNNN804ruk8tJyipqDhA4fVMNqpIL
	3g6qeywGJBsufeHflkR2+TzFU4FuZsbXrIVWLxXLnleBkgWTSZZJP0vysxlaoWdBuAA7qy
	JPChMGY4DtLkGV0TqcQ0MdU4/cusaBA=
From: Jackie Liu <liu.yun@linux.dev>
To: olsajiri@gmail.com,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	bpf@vger.kernel.org,
	liuyun01@kylinos.cn
Subject: [PATCH v3] libbpf: kprobe.multi: Filter with available_filter_functions
Date: Wed, 24 May 2023 16:41:54 +0800
Message-Id: <20230524084154.89226-1-liu.yun@linux.dev>
In-Reply-To: <ZG2y/zBhk4hnUfSg@krava>
References: <ZG2y/zBhk4hnUfSg@krava>
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

Use available_filter_functions check first, if failed, fallback to
kallsyms.

Here is the test eBPF program [1].
[1] https://github.com/JackieLiu1/ketones/commit/a9e76d1ba57390e533b8b3eadde97f7a4535e867

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 v1: 0.27s user 5.09s system 99% cpu 5.392 total
 v2: 0.37s user 1.54s system 98% cpu 1.947 total
 v3: 0.10s user 0.98s system 97% cpu 1.107 total

 I saw that reading available_filter_functions takes 0.98s and kallsyms only
 takes 0.12s.  There is a big difference in performance between them.

 tools/lib/bpf/libbpf.c          | 80 ++++++++++++++++++++++++++++++---
 tools/lib/bpf/libbpf_internal.h |  4 +-
 2 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ad1ec893b41b..f3e3c92bdf8a 100644
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
@@ -10440,6 +10441,69 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
 	return 0;
 }
 
+static int resolve_kprobe_multi_cb(const char *sym_name, void *ctx)
+{
+	struct kprobe_multi_resolve *res = ctx;
+	int err;
+
+	if (!glob_match(sym_name, res->pattern))
+		return 0;
+
+	err = libbpf_ensure_mem((void **) &res->syms, &res->cap, sizeof(const char *),
+				res->cnt + 1);
+	if (err)
+		return err;
+
+	res->syms[res->cnt++] = strdup(sym_name);
+	return 0;
+}
+
+int libbpf_available_filter_functions_parse(available_filter_functions_cb_t cb,
+					    void *ctx)
+{
+	char sym_name[256];
+	FILE *f;
+	int ret, err = 0;
+
+	f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
+	if (!f) {
+		pr_warn("failed to open available_filter_functions, fallback to /proc/kallsyms.\n");
+		goto fallback;
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
+
+fallback:
+	return libbpf_kallsyms_parse(kallsyms_resolve_kprobe_multi_cb, ctx);
+}
+
+static void kprobe_multi_resolve_resource_free(struct kprobe_multi_resolve *res)
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
@@ -10476,14 +10540,18 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 		return libbpf_err_ptr(-EINVAL);
 
 	if (pattern) {
-		err = libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &res);
+		err = libbpf_available_filter_functions_parse(resolve_kprobe_multi_cb,
+							      &res);
 		if (err)
 			goto error;
 		if (!res.cnt) {
 			err = -ENOENT;
 			goto error;
 		}
-		addrs = res.addrs;
+		if (res.syms)
+			syms = res.syms;
+		else
+			addrs = res.addrs;
 		cnt = res.cnt;
 	}
 
@@ -10511,12 +10579,12 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 		goto error;
 	}
 	link->fd = link_fd;
-	free(res.addrs);
+	kprobe_multi_resolve_resource_free(&res);
 	return link;
 
 error:
 	free(link);
-	free(res.addrs);
+	kprobe_multi_resolve_resource_free(&res);
 	return libbpf_err_ptr(err);
 }
 
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index e4d05662a96c..fdf6b464481f 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -481,8 +481,10 @@ __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
 
 typedef int (*kallsyms_cb_t)(unsigned long long sym_addr, char sym_type,
 			     const char *sym_name, void *ctx);
-
 int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *arg);
+typedef int (*available_filter_functions_cb_t)(const char *sym_name, void *ctx);
+int libbpf_available_filter_functions_parse(available_filter_functions_cb_t cb,
+					    void *arg);
 
 /* handle direct returned errors */
 static inline int libbpf_err(int ret)
-- 
2.25.1


