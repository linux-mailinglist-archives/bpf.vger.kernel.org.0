Return-Path: <bpf+bounces-66938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D38CB3B300
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 08:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6397A189C3F4
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 06:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB29224B0D;
	Fri, 29 Aug 2025 06:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ACmqGIW0"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B028BEC;
	Fri, 29 Aug 2025 06:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447902; cv=none; b=A1FbMdCyPjv6qCAbPAauod/ZL7LOanq5wnaXYcXs3K22Ahojc2Z33RCqmzAgELBjPyBE+yIBf3WmB0YbY3YasVHhABwPUYPi3c6Fg784C8mL2B1WsfsImSHbIkobLvP30foIC91U8P+HWqehNG0kVCipxwiJIo172ttdDfq1PKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447902; c=relaxed/simple;
	bh=cu3KRq89+Yv5psuZer+g04DuZsJqadIh3W9DN+nJesk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ct3nyyqCXDLnjP/7ehcszRTJYuinDStnhC/5ageiZBbo21EWcYz5gqn+ZGiVckPcHV8H/Yc3IkAsr8ftE+clCGcUxPrX9G/WtHjcJ7ihSBO7HbN8t73UmURPPkHW6C3bd2MuoQ6dUMYXhQLlbHCBTs8xlSGyJN25PjLN3U1bEIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ACmqGIW0; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gk
	k5bJ+6QuOJA5OiM2jXUM7YEzFrEsHxta8bwk2tPtM=; b=ACmqGIW02Ep4SdZ6+k
	nrqOCWDo86nnAq+Mo+JEcVrwP6r473VU7czJPQ+YIATMj1fW+qzLcPEwtvWCS4Ww
	LAAZ2B/BwWDsLkzvafy5kck6etHX58QBIx9tBudXmDODVPEGiR/wjoJ1lhzl6CfS
	+p30KRu23I5QuqJqbxy4qa/FE=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3vTZ9RLFoGWmGEg--.4740S3;
	Fri, 29 Aug 2025 14:11:12 +0800 (CST)
From: chenyuan_fl@163.com
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: yonghong.song@linux.dev,
	olsajiri@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyuan@kylinos.cn,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v8 1/2] bpftool: Refactor kernel config reading into common helper
Date: Fri, 29 Aug 2025 07:11:06 +0100
Message-Id: <20250829061107.23905-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829061107.23905-1-chenyuan_fl@163.com>
References: <20250829061107.23905-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vTZ9RLFoGWmGEg--.4740S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jw1xCF43GF48JF1UJr15CFg_yoW3GrWxpF
	Z5Ga45Jry8XF1fuw4xtFWrCrWrGwn7J3yUKrZrW3yrZrnFyryqva18KFnaqasxZryvgr17
	ZrZY9Fyj9w4UXr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jxAwxUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbBSQa4vWixPi6UnAAAsL

From: Yuan Chen <chenyuan@kylinos.cn>

Extract the kernel configuration file parsing logic from feature.c into
a new read_kernel_config() function in common.c. This includes:

1. Moving the config file handling and option parsing code
2. Adding required headers and struct definition
3. Keeping all existing functionality

The refactoring enables sharing this logic with other components while
maintaining current behavior. This will be used by subsequent patches
that need to check kernel config options.

Acked-by: Quentin Monnet <qmo@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/common.c  | 93 +++++++++++++++++++++++++++++++++++++
 tools/bpf/bpftool/feature.c | 86 ++--------------------------------
 tools/bpf/bpftool/main.h    |  9 ++++
 3 files changed, 106 insertions(+), 82 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index b07317d2842f..e8daf963ecef 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -21,6 +21,7 @@
 #include <sys/resource.h>
 #include <sys/stat.h>
 #include <sys/vfs.h>
+#include <sys/utsname.h>
 
 #include <linux/filter.h>
 #include <linux/limits.h>
@@ -31,6 +32,7 @@
 #include <bpf/hashmap.h>
 #include <bpf/libbpf.h> /* libbpf_num_possible_cpus */
 #include <bpf/btf.h>
+#include <zlib.h>
 
 #include "main.h"
 
@@ -1208,3 +1210,94 @@ int pathname_concat(char *buf, int buf_sz, const char *path,
 
 	return 0;
 }
+
+static bool read_next_kernel_config_option(gzFile file, char *buf, size_t n,
+					   char **value)
+{
+	char *sep;
+
+	while (gzgets(file, buf, n)) {
+		if (strncmp(buf, "CONFIG_", 7))
+			continue;
+
+		sep = strchr(buf, '=');
+		if (!sep)
+			continue;
+
+		/* Trim ending '\n' */
+		buf[strlen(buf) - 1] = '\0';
+
+		/* Split on '=' and ensure that a value is present. */
+		*sep = '\0';
+		if (!sep[1])
+			continue;
+
+		*value = sep + 1;
+		return true;
+	}
+
+	return false;
+}
+
+int read_kernel_config(const struct kernel_config_option *requested_options,
+		       size_t num_options, char **out_values,
+		       const char *define_prefix)
+{
+	struct utsname utsn;
+	char path[PATH_MAX];
+	gzFile file = NULL;
+	char buf[4096];
+	char *value;
+	size_t i;
+	int ret = 0;
+
+	if (!requested_options || !out_values || num_options == 0)
+		return -1;
+
+	if (!uname(&utsn)) {
+		snprintf(path, sizeof(path), "/boot/config-%s", utsn.release);
+
+		/* gzopen also accepts uncompressed files. */
+		file = gzopen(path, "r");
+	}
+
+	if (!file) {
+		/* Some distributions build with CONFIG_IKCONFIG=y and put the
+		 * config file at /proc/config.gz.
+		 */
+		file = gzopen("/proc/config.gz", "r");
+	}
+
+	if (!file) {
+		p_info("skipping kernel config, can't open file: %s",
+			strerror(errno));
+		return -1;
+	}
+
+	if (!gzgets(file, buf, sizeof(buf)) || !gzgets(file, buf, sizeof(buf))) {
+		p_info("skipping kernel config, can't read from file: %s",
+			strerror(errno));
+		ret = -1;
+		goto end_parse;
+	}
+
+	if (strcmp(buf, "# Automatically generated file; DO NOT EDIT.\n")) {
+		p_info("skipping kernel config, can't find correct file");
+		ret = -1;
+		goto end_parse;
+	}
+
+	while (read_next_kernel_config_option(file, buf, sizeof(buf), &value)) {
+		for (i = 0; i < num_options; i++) {
+			if ((define_prefix && !requested_options[i].macro_dump) ||
+			     out_values[i] || strcmp(buf, requested_options[i].name))
+				continue;
+
+			out_values[i] = strdup(value);
+		}
+	}
+
+end_parse:
+	gzclose(file);
+	return ret;
+}
diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 24fecdf8e430..0f6070a0c8e7 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -10,7 +10,6 @@
 #ifdef USE_LIBCAP
 #include <sys/capability.h>
 #endif
-#include <sys/utsname.h>
 #include <sys/vfs.h>
 
 #include <linux/filter.h>
@@ -18,7 +17,6 @@
 
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
-#include <zlib.h>
 
 #include "main.h"
 
@@ -327,40 +325,9 @@ static void probe_jit_limit(void)
 	}
 }
 
-static bool read_next_kernel_config_option(gzFile file, char *buf, size_t n,
-					   char **value)
-{
-	char *sep;
-
-	while (gzgets(file, buf, n)) {
-		if (strncmp(buf, "CONFIG_", 7))
-			continue;
-
-		sep = strchr(buf, '=');
-		if (!sep)
-			continue;
-
-		/* Trim ending '\n' */
-		buf[strlen(buf) - 1] = '\0';
-
-		/* Split on '=' and ensure that a value is present. */
-		*sep = '\0';
-		if (!sep[1])
-			continue;
-
-		*value = sep + 1;
-		return true;
-	}
-
-	return false;
-}
-
 static void probe_kernel_image_config(const char *define_prefix)
 {
-	static const struct {
-		const char * const name;
-		bool macro_dump;
-	} options[] = {
+	struct kernel_config_option options[] = {
 		/* Enable BPF */
 		{ "CONFIG_BPF", },
 		/* Enable bpf() syscall */
@@ -435,52 +402,11 @@ static void probe_kernel_image_config(const char *define_prefix)
 		{ "CONFIG_HZ", true, }
 	};
 	char *values[ARRAY_SIZE(options)] = { };
-	struct utsname utsn;
-	char path[PATH_MAX];
-	gzFile file = NULL;
-	char buf[4096];
-	char *value;
 	size_t i;
 
-	if (!uname(&utsn)) {
-		snprintf(path, sizeof(path), "/boot/config-%s", utsn.release);
-
-		/* gzopen also accepts uncompressed files. */
-		file = gzopen(path, "r");
-	}
-
-	if (!file) {
-		/* Some distributions build with CONFIG_IKCONFIG=y and put the
-		 * config file at /proc/config.gz.
-		 */
-		file = gzopen("/proc/config.gz", "r");
-	}
-	if (!file) {
-		p_info("skipping kernel config, can't open file: %s",
-		       strerror(errno));
-		goto end_parse;
-	}
-	/* Sanity checks */
-	if (!gzgets(file, buf, sizeof(buf)) ||
-	    !gzgets(file, buf, sizeof(buf))) {
-		p_info("skipping kernel config, can't read from file: %s",
-		       strerror(errno));
-		goto end_parse;
-	}
-	if (strcmp(buf, "# Automatically generated file; DO NOT EDIT.\n")) {
-		p_info("skipping kernel config, can't find correct file");
-		goto end_parse;
-	}
-
-	while (read_next_kernel_config_option(file, buf, sizeof(buf), &value)) {
-		for (i = 0; i < ARRAY_SIZE(options); i++) {
-			if ((define_prefix && !options[i].macro_dump) ||
-			    values[i] || strcmp(buf, options[i].name))
-				continue;
-
-			values[i] = strdup(value);
-		}
-	}
+	if (read_kernel_config(options, ARRAY_SIZE(options), values,
+			       define_prefix))
+		return;
 
 	for (i = 0; i < ARRAY_SIZE(options); i++) {
 		if (define_prefix && !options[i].macro_dump)
@@ -488,10 +414,6 @@ static void probe_kernel_image_config(const char *define_prefix)
 		print_kernel_option(options[i].name, values[i], define_prefix);
 		free(values[i]);
 	}
-
-end_parse:
-	if (file)
-		gzclose(file);
 }
 
 static bool probe_bpf_syscall(const char *define_prefix)
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index a2bb0714b3d6..374cac2a8c66 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -275,4 +275,13 @@ int pathname_concat(char *buf, int buf_sz, const char *path,
 /* print netfilter bpf_link info */
 void netfilter_dump_plain(const struct bpf_link_info *info);
 void netfilter_dump_json(const struct bpf_link_info *info, json_writer_t *wtr);
+
+struct kernel_config_option {
+	const char *name;
+	bool macro_dump;
+};
+
+int read_kernel_config(const struct kernel_config_option *requested_options,
+		       size_t num_options, char **out_values,
+		       const char *define_prefix);
 #endif
-- 
2.39.5


