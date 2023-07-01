Return-Path: <bpf+bounces-3841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48507447EF
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 10:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5FD91C2031E
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 08:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AF45242;
	Sat,  1 Jul 2023 08:08:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73CC5239
	for <bpf@vger.kernel.org>; Sat,  1 Jul 2023 08:08:36 +0000 (UTC)
Received: from out-5.mta0.migadu.com (out-5.mta0.migadu.com [91.218.175.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA4CA2
	for <bpf@vger.kernel.org>; Sat,  1 Jul 2023 01:08:34 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1688198912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQoPy2oC72AU6UlKRf9pLai6dEbOpRXLZp1z98k33+0=;
	b=omzbFpGNt1nYrJagkfIzsjlYlNA0aKwh2BzZcExbgq0SkU1p8O0CYkcRBv0y7/4kpK4M4E
	8PzHDEe7O0TJaUvBXl26B982nfgxGIlo2oERuQk728vcfkzng7JkJgasNG//q3igw1qJ3W
	G99sKQByVJg5W7/Cv55X8Z/oeewly3c=
From: Jackie Liu <liu.yun@linux.dev>
To: olsajiri@gmail.com,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	bpf@vger.kernel.org,
	liuyun01@kylinos.cn
Subject: [PATCH v2 2/2] libbpf: kprobe.multi: Filter with available_filter_functions_addrs
Date: Sat,  1 Jul 2023 16:08:17 +0800
Message-Id: <20230701080817.1768865-2-liu.yun@linux.dev>
In-Reply-To: <20230701080817.1768865-1-liu.yun@linux.dev>
References: <20230701080817.1768865-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
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
 tools/lib/bpf/libbpf.c | 58 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8ea13de02c67..1ec861ad52a6 100644
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
@@ -10654,6 +10660,53 @@ static int libbpf_available_kallsyms_parse(struct kprobe_multi_resolve *res)
 	return err;
 }
 
+static bool has_available_filter_functions_addrs(void)
+{
+	return access(tracefs_available_filter_functions_addrs(), R_OK) != -1;
+}
+
+static int libbpf_available_kprobes_parse(struct kprobe_multi_resolve *res)
+{
+	char sym_name[256];
+	FILE *f;
+	int ret, err = 0;
+	unsigned long long sym_addr;
+	const char *available_path = tracefs_available_filter_functions_addrs();
+
+	f = fopen(available_path, "r");
+	if (!f) {
+		err = -errno;
+		pr_warn("failed to open %s.\n", available_path);
+		return err;
+	}
+
+	while (true) {
+		ret = fscanf(f, "%llx %s%*[^\n]\n", &sym_addr, sym_name);
+		if (ret == EOF && feof(f))
+			break;
+
+		if (ret != 2) {
+			pr_warn("failed to read available kprobe entry: %d\n",
+				ret);
+			err = -EINVAL;
+			break;
+		}
+
+		if (!glob_match(sym_name, res->pattern))
+			continue;
+
+		err = libbpf_ensure_mem((void **) &res->addrs, &res->cap,
+					sizeof(unsigned long), res->cnt + 1);
+		if (err)
+			break;
+
+		res->addrs[res->cnt++] = (unsigned long) sym_addr;
+	}
+
+	fclose(f);
+	return err;
+}
+
 struct bpf_link *
 bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 				      const char *pattern,
@@ -10690,7 +10743,10 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 		return libbpf_err_ptr(-EINVAL);
 
 	if (pattern) {
-		err = libbpf_available_kallsyms_parse(&res);
+		if (has_available_filter_functions_addrs())
+			err = libbpf_available_kprobes_parse(&res);
+		else
+			err = libbpf_available_kallsyms_parse(&res);
 		if (err)
 			goto error;
 		if (!res.cnt) {
-- 
2.25.1


