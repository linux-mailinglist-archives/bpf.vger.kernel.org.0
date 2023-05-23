Return-Path: <bpf+bounces-1088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FFF70DD8A
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 15:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DC0281361
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 13:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9F51E539;
	Tue, 23 May 2023 13:35:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E221E50A
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 13:35:52 +0000 (UTC)
X-Greylist: delayed 586 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 06:35:50 PDT
Received: from out-50.mta1.migadu.com (out-50.mta1.migadu.com [IPv6:2001:41d0:203:375::32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCAACA
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 06:35:50 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1684848356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H0dEGcbXJjtmfk5oCnm68LyMfF+W2OD+Dsi2E6Y5ZnE=;
	b=K4MOoEwzIg0gmmQ8G2U1sDU7RgamO9KB91GB4ux5hQEaL5f/r4tlb8JrDjWMM5Wc/SeByV
	fgEnwVx9mBKwx6+ug7DlX7RaGRlboll7qTEOoHJC4nwMFUU1BFMwRGNzhkTRWTR2vKwres
	iXQZ2ifOC1E8qZ6NRgsJxGkXMDp5sIo=
From: Jackie Liu <liu.yun@linux.dev>
To: andrii@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	bpf@vger.kernel.org,
	liuyun01@kylinos.cn
Subject: [PATCH] libbpf: kprobe.multi: Filter with blacklist and available_filter_functions
Date: Tue, 23 May 2023 21:25:47 +0800
Message-Id: <20230523132547.94384-1-liu.yun@linux.dev>
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

But, the addition of these checks will frequently probe whether a function
complies with "available_filter_functions" and ensure that it has not been
filtered by kprobe's blacklist. As a result, it may take a longer time
during startup. The function implementation is referenced from BCC's
"kprobe_exists()"

Here is the test eBPF program [1].
[1] https://github.com/JackieLiu1/ketones/commit/a9e76d1ba57390e533b8b3eadde97f7a4535e867

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 tools/lib/bpf/libbpf.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ad1ec893b41b..6a201267fa08 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10421,6 +10421,50 @@ struct kprobe_multi_resolve {
 	size_t cnt;
 };
 
+static bool filter_available_function(const char *name)
+{
+	char addr_range[256];
+	char sym_name[256];
+	FILE *f;
+	int ret;
+
+	f = fopen("/sys/kernel/debug/kprobes/blacklist", "r");
+	if (!f)
+		goto avail_filter;
+
+	while (true) {
+		ret = fscanf(f, "%s %s%*[^\n]\n", addr_range, sym_name);
+		if (ret == EOF && feof(f))
+			break;
+		if (ret != 2)
+			break;
+		if (!strcmp(name, sym_name)) {
+			fclose(f);
+			return false;
+		}
+	}
+	fclose(f);
+
+avail_filter:
+	f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
+	if (!f)
+		return true;
+
+	while (true) {
+		ret = fscanf(f, "%s%*[^\n]\n", sym_name);
+		if (ret == EOF && feof(f))
+			break;
+		if (ret != 1)
+			break;
+		if (!strcmp(name, sym_name)) {
+			fclose(f);
+			return true;
+		}
+	}
+	fclose(f);
+	return false;
+}
+
 static int
 resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
 			const char *sym_name, void *ctx)
@@ -10431,6 +10475,9 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
 	if (!glob_match(sym_name, res->pattern))
 		return 0;
 
+	if (!filter_available_function(sym_name))
+		return 0;
+
 	err = libbpf_ensure_mem((void **) &res->addrs, &res->cap, sizeof(unsigned long),
 				res->cnt + 1);
 	if (err)
-- 
2.25.1


