Return-Path: <bpf+bounces-4019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BC4747BD1
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 05:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236211C2094F
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 03:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E990AEA5;
	Wed,  5 Jul 2023 03:29:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BECA3D
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 03:29:24 +0000 (UTC)
Received: from out-42.mta1.migadu.com (out-42.mta1.migadu.com [95.215.58.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944D61B6
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 20:29:22 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1688527760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikPMhK7aVYE2rQDQ2mbMt8jjsTsDtkMZimwda04ex3M=;
	b=pLAttrjZ+4CSheIvb82xP4U32gC4s9rETm4juMSZh9jWkhWm6/bO90j6fw7BRzIGATUoPI
	RFag+QWMVVrVDTeEPywib+4b8ji+blt7lDxn5gpMybla+DidCzy0jeC4b9u4oEwkkzrvKa
	4JoAMYV4lIjcWSsiYyCKCLLtOiMF3AM=
From: Jackie Liu <liu.yun@linux.dev>
To: olsajiri@gmail.com,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	bpf@vger.kernel.org,
	liuyun01@kylinos.cn
Subject: [PATCH v5 2/2] libbpf: kprobe.multi: Filter with available_filter_functions_addrs
Date: Wed,  5 Jul 2023 11:29:08 +0800
Message-Id: <20230705032908.3778010-2-liu.yun@linux.dev>
In-Reply-To: <20230705032908.3778010-1-liu.yun@linux.dev>
References: <20230705032908.3778010-1-liu.yun@linux.dev>
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

Now, we provide a new available_filter_functions_addrs interface, which can
help us not need to cross-validate available_filter_functions and kallsyms,
which can effectively improve efficiency. For example, on my device, the
sample program [1] of start time:

$ sudo ./funccount "tcp_*"

before   after
1.2s     1.0s

[1]: https://github.com/JackieLiu1/ketones/tree/master/src/funccount
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 tools/lib/bpf/libbpf.c | 62 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 327b4a9e9f0d..03ba17d8dd2f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10230,6 +10230,12 @@ static const char *tracefs_available_filter_functions(void)
 			       TRACEFS"/available_filter_functions";
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
@@ -10648,6 +10654,57 @@ static int libbpf_available_kallsyms_parse(struct kprobe_multi_resolve *res)
 	return err;
 }
 
+static bool has_available_filter_functions_addrs(void)
+{
+	return access(tracefs_available_filter_functions_addrs(), R_OK) != -1;
+}
+
+static int libbpf_available_kprobes_parse(struct kprobe_multi_resolve *res)
+{
+	char sym_name[500];
+	FILE *f;
+	int ret, err = 0;
+	unsigned long long sym_addr;
+	const char *available_path = tracefs_available_filter_functions_addrs();
+
+	f = fopen(available_path, "r");
+	if (!f) {
+		err = -errno;
+		pr_warn("failed to open %s\n", available_path);
+		return err;
+	}
+
+	while (true) {
+		ret = fscanf(f, "%llx %499s%*[^\n]\n", &sym_addr, sym_name);
+		if (ret == EOF && feof(f))
+			break;
+
+		if (ret != 2) {
+			pr_warn("failed to read available kprobe entry: %d\n",
+				ret);
+			err = -EINVAL;
+			goto cleanup;
+		}
+
+		if (!glob_match(sym_name, res->pattern))
+			continue;
+
+		err = libbpf_ensure_mem((void **) &res->addrs, &res->cap,
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
+	return err;
+}
+
 struct bpf_link *
 bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 				      const char *pattern,
@@ -10684,7 +10741,10 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 		return libbpf_err_ptr(-EINVAL);
 
 	if (pattern) {
-		err = libbpf_available_kallsyms_parse(&res);
+		if (has_available_filter_functions_addrs())
+			err = libbpf_available_kprobes_parse(&res);
+		else
+			err = libbpf_available_kallsyms_parse(&res);
 		if (err)
 			goto error;
 		addrs = res.addrs;
-- 
2.25.1


