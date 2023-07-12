Return-Path: <bpf+bounces-4814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE8674FC7B
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 03:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44951281772
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 01:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA48390;
	Wed, 12 Jul 2023 01:05:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD44362
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 01:05:29 +0000 (UTC)
Received: from out-7.mta0.migadu.com (out-7.mta0.migadu.com [IPv6:2001:41d0:1004:224b::7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D107F1733
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 18:05:15 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1689123913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GGb4tvkBTvZZHQSCtPWn3p6rTSivJe5Ai182sk0nmrg=;
	b=jhlVdUI+owrdilP/RlEHzYTs/pOa25LpymPNEtDwC7n4QLftT5cjxW7R8vcT1k6OvYYt2N
	Sq0Urwlfh+A3cLBEKPuliDFqO84HP0JEEaC8O/62+7c/qqbQ5WkfkyB/SPaOms5HQK2plq
	MaxfiVv3SYRBA8Jzx+XVz0OhgaHlVdU=
From: Jackie Liu <liu.yun@linux.dev>
To: olsajiri@gmail.com,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	liuyun01@kylinos.cn
Subject: [PATCH] libbpf: Support POSIX regular expressions for multi kprobe
Date: Wed, 12 Jul 2023 09:05:03 +0800
Message-Id: <20230712010504.818008-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jackie Liu <liuyun01@kylinos.cn>

Now multi kprobe uses glob_match for function matching, it's not enough,
and sometimes we need more powerful regular expressions to support fuzzy
matching, and now provides a use_regex in bpf_kprobe_multi_opts to support
POSIX regular expressions.

This is useful, similar to `funccount.py -r '^vfs.*'` in BCC, and can also
be implemented with libbpf.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 tools/lib/bpf/libbpf.c | 52 ++++++++++++++++++++++++++++++++++++++----
 tools/lib/bpf/libbpf.h |  4 +++-
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 81aa52fa6807..fd217e9a232d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -25,6 +25,7 @@
 #include <fcntl.h>
 #include <errno.h>
 #include <ctype.h>
+#include <regex.h>
 #include <asm/unistd.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
@@ -10549,6 +10550,7 @@ struct kprobe_multi_resolve {
 	unsigned long *addrs;
 	size_t cap;
 	size_t cnt;
+	bool use_regex;
 };
 
 struct avail_kallsyms_data {
@@ -10589,6 +10591,7 @@ static int libbpf_available_kallsyms_parse(struct kprobe_multi_resolve *res)
 	int err = 0, ret, i;
 	char **syms = NULL;
 	size_t cap = 0, cnt = 0;
+	regex_t regex;
 
 	f = fopen(available_functions_file, "re");
 	if (!f) {
@@ -10597,6 +10600,18 @@ static int libbpf_available_kallsyms_parse(struct kprobe_multi_resolve *res)
 		return err;
 	}
 
+	if (res->use_regex) {
+		ret = regcomp(&regex, res->pattern, REG_EXTENDED | REG_NOSUB);
+		if (ret) {
+			char errbuf[128];
+
+			regerror(ret, &regex, errbuf, sizeof(errbuf));
+			pr_warn("Failed to compile regex: %s\n", errbuf);
+			fclose(f);
+			return -EINVAL;
+		}
+	}
+
 	while (true) {
 		char *name;
 
@@ -10610,8 +10625,13 @@ static int libbpf_available_kallsyms_parse(struct kprobe_multi_resolve *res)
 			goto cleanup;
 		}
 
-		if (!glob_match(sym_name, res->pattern))
-			continue;
+		if (res->use_regex) {
+			if (regexec(&regex, sym_name, 0, NULL, 0))
+				continue;
+		} else {
+			if (!glob_match(sym_name, res->pattern))
+				continue;
+		}
 
 		err = libbpf_ensure_mem((void **)&syms, &cap, sizeof(*syms), cnt + 1);
 		if (err)
@@ -10644,6 +10664,8 @@ static int libbpf_available_kallsyms_parse(struct kprobe_multi_resolve *res)
 		err = -ENOENT;
 
 cleanup:
+	if (res->use_regex)
+		regfree(&regex);
 	for (i = 0; i < cnt; i++)
 		free((char *)syms[i]);
 	free(syms);
@@ -10664,6 +10686,7 @@ static int libbpf_available_kprobes_parse(struct kprobe_multi_resolve *res)
 	FILE *f;
 	int ret, err = 0;
 	unsigned long long sym_addr;
+	regex_t regex;
 
 	f = fopen(available_path, "re");
 	if (!f) {
@@ -10672,6 +10695,18 @@ static int libbpf_available_kprobes_parse(struct kprobe_multi_resolve *res)
 		return err;
 	}
 
+	if (res->use_regex) {
+		ret = regcomp(&regex, res->pattern, REG_EXTENDED | REG_NOSUB);
+		if (ret) {
+			char errbuf[128];
+
+			regerror(ret, &regex, errbuf, sizeof(errbuf));
+			pr_warn("Failed to compile regex: %s\n", errbuf);
+			fclose(f);
+			return -EINVAL;
+		}
+	}
+
 	while (true) {
 		ret = fscanf(f, "%llx %499s%*[^\n]\n", &sym_addr, sym_name);
 		if (ret == EOF && feof(f))
@@ -10684,8 +10719,13 @@ static int libbpf_available_kprobes_parse(struct kprobe_multi_resolve *res)
 			goto cleanup;
 		}
 
-		if (!glob_match(sym_name, res->pattern))
-			continue;
+		if (res->use_regex) {
+			if (regexec(&regex, sym_name, 0, NULL, 0))
+				continue;
+		} else {
+			if (!glob_match(sym_name, res->pattern))
+				continue;
+		}
 
 		err = libbpf_ensure_mem((void **)&res->addrs, &res->cap,
 					sizeof(*res->addrs), res->cnt + 1);
@@ -10699,6 +10739,8 @@ static int libbpf_available_kprobes_parse(struct kprobe_multi_resolve *res)
 		err = -ENOENT;
 
 cleanup:
+	if (res->use_regex)
+		regfree(&regex);
 	fclose(f);
 	return err;
 }
@@ -10739,6 +10781,8 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 		return libbpf_err_ptr(-EINVAL);
 
 	if (pattern) {
+		res.use_regex = OPTS_GET(opts, use_regex, false);
+
 		if (has_available_filter_functions_addrs())
 			err = libbpf_available_kprobes_parse(&res);
 		else
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 754da73c643b..34031c722213 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -519,10 +519,12 @@ struct bpf_kprobe_multi_opts {
 	size_t cnt;
 	/* create return kprobes */
 	bool retprobe;
+	/* use regular expression */
+	bool use_regex;
 	size_t :0;
 };
 
-#define bpf_kprobe_multi_opts__last_field retprobe
+#define bpf_kprobe_multi_opts__last_field use_regex
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
-- 
2.25.1


