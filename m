Return-Path: <bpf+bounces-1148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D68ED70EBFE
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 05:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91129280EEA
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 03:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E91D15B8;
	Wed, 24 May 2023 03:44:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A339EC2
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 03:44:33 +0000 (UTC)
X-Greylist: delayed 51504 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 20:44:30 PDT
Received: from out-53.mta1.migadu.com (out-53.mta1.migadu.com [95.215.58.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B172C1
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 20:44:30 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1684899868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZFRBivtXFIWlkQZPP3SmEdFDvp05e98JHCCJQN0X2s=;
	b=YST34r5An3nH5w6tAUzkTQdYSdZ4HjnGkE1b5/eyWDf1/yqMlblYag7Ob84vqntRGo+dA/
	/Rgs8rjE7PMTRclNat9Ht+hhaYe+5+JeOexM6KhGA2sPXc3vvaxETWQi5sN0Vj6tytKvRn
	9Fh/7jT6q7WfA6pRuwFr8Mpg4URM02A=
From: Jackie Liu <liu.yun@linux.dev>
To: olsajiri@gmail.com,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	bpf@vger.kernel.org,
	liuyun01@kylinos.cn
Subject: [PATCH v2] libbpf: kprobe.multi: Filter with available_filter_functions
Date: Wed, 24 May 2023 11:44:19 +0800
Message-Id: <20230524034419.1811561-1-liu.yun@linux.dev>
In-Reply-To: <ZGznHMU1uhdPnE/F@krava>
References: <ZGznHMU1uhdPnE/F@krava>
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

Check available_filter_functions first, speed up for function check than
/proc/kallsyms. since each function needs to check kallsyms and
available_filter_functions, its startup time will increase. The function
implementation is referenced from BCC's kprobe_exists().

Here is the test eBPF program [1].
[1] https://github.com/JackieLiu1/ketones/commit/a9e76d1ba57390e533b8b3eadde97f7a4535e867

Suggested-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 v1->v2: speed up startup time.
	 Before: 0.27s user 5.09s system 99% cpu 5.392 total
	 After : 0.37s user 1.54s system 98% cpu 1.947 total

 tools/lib/bpf/libbpf.c          | 100 +++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf_internal.h |   4 +-
 2 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ad1ec893b41b..0380d171c1cd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10422,8 +10422,8 @@ struct kprobe_multi_resolve {
 };
 
 static int
-resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
-			const char *sym_name, void *ctx)
+kallsyms_resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
+				 const char *sym_name, void *ctx)
 {
 	struct kprobe_multi_resolve *res = ctx;
 	int err;
@@ -10440,6 +10440,99 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
 	return 0;
 }
 
+static int
+resolve_function_addrs(const char *name, unsigned long long *sym_addr)
+{
+	char sym_name[500];
+	int ret, err = 0;
+	FILE *f;
+
+	f = fopen("/proc/kallsyms", "r");
+	if (!f) {
+		err = -errno;
+		pr_warn("failed to open /proc/kallsyms: %d\n", err);
+		return err;
+	}
+
+	while (true) {
+		ret = fscanf(f, "%llx %*c %499s%*[^\n]\n",
+			     sym_addr, sym_name);
+		if (ret == EOF && feof(f)) {
+			pr_warn("not found syms in /proc/kallsyms\n");
+			err = -ENOENT;
+			break;
+		}
+		if (ret != 2) {
+			pr_warn("failed to read kallsyms entry: %d\n", ret);
+			err = -EINVAL;
+			break;
+		}
+
+		if (strcmp(name, sym_name) == 0)
+			return 0;
+	}
+
+	return err;
+}
+
+static int resolve_kprobe_multi_cb(const char *sym_name, void *ctx)
+{
+	unsigned long long sym_addr;
+	struct kprobe_multi_resolve *res = ctx;
+	int err;
+
+	if (!glob_match(sym_name, res->pattern))
+		return 0;
+
+	err = resolve_function_addrs(sym_name, &sym_addr);
+	if (err)
+		return err;
+
+	err = libbpf_ensure_mem((void **) &res->addrs, &res->cap, sizeof(unsigned long),
+				res->cnt + 1);
+	if (err)
+		return err;
+
+	res->addrs[res->cnt++] = (unsigned long) sym_addr;
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
+		pr_warn("failed to open /sys/kernel/debug/tracing/available_filter_functions, ");
+		pr_warn("fallback to /proc/kallsyms.\n");
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
+			return err;
+	}
+
+	fclose(f);
+	return err;
+
+fallback:
+	return libbpf_kallsyms_parse(kallsyms_resolve_kprobe_multi_cb, ctx);
+}
+
 struct bpf_link *
 bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 				      const char *pattern,
@@ -10476,7 +10569,8 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 		return libbpf_err_ptr(-EINVAL);
 
 	if (pattern) {
-		err = libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &res);
+		err = libbpf_available_filter_functions_parse(resolve_kprobe_multi_cb,
+							      &res);
 		if (err)
 			goto error;
 		if (!res.cnt) {
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


