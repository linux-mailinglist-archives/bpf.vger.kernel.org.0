Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87C85BF97F
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 10:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiIUIkh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 04:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiIUIkh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 04:40:37 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB7C67CB9
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 01:40:32 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so424616wmb.0
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 01:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=qmpXKhIhcCGexLcp9f7CsO1I3cqDQestLKbYnaygb2E=;
        b=ZYw9gv44D2mrrAfIOrHF/2OaWzyTGhhL2Ksz06146xgbb2EjCw1ayD8GJdqhkccZ5I
         NLars0z+1VOLP/KjdvBuZD6WPcIQzI9almSci5O8Cdi/7pSE5+o6nW2TBe/EH5vIiwyq
         8yfHomZGeFDDR7CVfihWgC4vRt+FfY9s+vgetClR9S7iMsP6PJQLTFQG8K0lnQhZX2X+
         oIC9AMVvN1VZjl41o8l9r1rlz7ggdRILJa/AfGI4zOchiag4VO4ZRiSDWToauAsQidv5
         PrEW3sYcogleOzDtT2QkUzPrpSfDlhh8dYjvjc3VtKLiyGF03nud2rooCIWcJ4Q03URX
         QoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=qmpXKhIhcCGexLcp9f7CsO1I3cqDQestLKbYnaygb2E=;
        b=XSgHsaOuCPy4CavEvUyEfNJyhg0WUSDTyr6hyu+i57a99Mm51IrU+H9qXApA5bRQph
         uzHGWLIpqj6Ivr9vhxnk4naUBHp7Q/duVvwEfzqlQMIxDEIrweCL6VBXnWp49dPWgUCQ
         9ZToMTC8odghbyVmfr6mYx244L5LY3XHv/+ggdAe3xk045SLE0IsFZpfmZUQPx/dGqty
         e+a7v7UGVIJ9qJ8gGaKOi4sqUbCzIbwswoxiHIVWM84M7hxG5I/87RCDLWPkNISP6cLj
         cQny67EtHr08sfFJPUZpm/HzGKh44C5EBFp/DmOS6cudovTYjXfF5Xfw8vBYMqz8SD29
         5Gxw==
X-Gm-Message-State: ACrzQf2djf7Bo9npwa/MyPDpZLLrDuq07F1fW7+j4Uect8NUVZZmtrXz
        V4vMReDwAZ7s5ZGRHzj/I6rXuhh7FWk=
X-Google-Smtp-Source: AMsMyM5HyEetWiAWkZhSUEMITNdVPeX9iKJsGgZct/qglz+74cY7ddbn7YtZyUdOGeRYx3q5TQRoIQ==
X-Received: by 2002:a05:600c:3ba0:b0:3b4:8ad0:6c with SMTP id n32-20020a05600c3ba000b003b48ad0006cmr4991885wms.186.1663749630833;
        Wed, 21 Sep 2022 01:40:30 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:6fc2:4af0:cc00:f99d:5d19:6e17:dc3a])
        by smtp.gmail.com with ESMTPSA id m18-20020a5d56d2000000b0022878c0cc5esm1867268wrw.69.2022.09.21.01.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 01:40:29 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc:     Jon Doron <jond@wiz.io>
Subject: [PATCH bpf-next v2] libbpf: Fix the case of running as non-root with capabilities
Date:   Wed, 21 Sep 2022 11:40:14 +0300
Message-Id: <20220921084014.3744312-1-arilou@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jon Doron <jond@wiz.io>

When running rootless with special capabilities like:
FOWNER / DAC_OVERRIDE / DAC_READ_SEARCH

The "access" API will not make the proper check if there is really
access to a file or not.

From the access man page:
"
The check is done using the calling process's real UID and GID, rather
than the effective IDs as is done when actually attempting an operation
(e.g., open(2)) on the file.  Similarly, for the root user, the check
uses the set of permitted capabilities  rather than the set of effective
capabilities; ***and for non-root users, the check uses an empty set of
capabilities.***
"

What that means is that for non-root user the access API will not do the
proper validation if the process really has permission to a file or not.

To resolve this this patch replaces all the access API calls with stat.

Signed-off-by: Jon Doron <jond@wiz.io>
---
 tools/lib/bpf/btf.c    |  3 ++-
 tools/lib/bpf/libbpf.c | 11 ++++++++---
 tools/lib/bpf/usdt.c   |  4 +++-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 2d14f1a52d7a..33ad4792d9e8 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4663,13 +4663,14 @@ struct btf *btf__load_vmlinux_btf(void)
 	struct utsname buf;
 	struct btf *btf;
 	int i, err;
+	struct stat sb;
 
 	uname(&buf);
 
 	for (i = 0; i < ARRAY_SIZE(locations); i++) {
 		snprintf(path, PATH_MAX, locations[i].path_fmt, buf.release);
 
-		if (access(path, R_OK))
+		if (stat(path, &sb))
 			continue;
 
 		if (locations[i].raw_btf)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 50d41815f431..c7fbce4225b5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -875,8 +875,9 @@ __u32 get_kernel_version(void)
 	const char *ubuntu_kver_file = "/proc/version_signature";
 	__u32 major, minor, patch;
 	struct utsname info;
+	struct stat sb;
 
-	if (access(ubuntu_kver_file, R_OK) == 0) {
+	if (stat(ubuntu_kver_file, &sb) == 0) {
 		FILE *f;
 
 		f = fopen(ubuntu_kver_file, "r");
@@ -9877,9 +9878,10 @@ static int append_to_file(const char *file, const char *fmt, ...)
 static bool use_debugfs(void)
 {
 	static int has_debugfs = -1;
+	struct stat sb;
 
 	if (has_debugfs < 0)
-		has_debugfs = access(DEBUGFS, F_OK) == 0;
+		has_debugfs = stat(DEBUGFS, &sb) == 0;
 
 	return has_debugfs == 1;
 }
@@ -10681,6 +10683,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 		for (s = search_paths[i]; s != NULL; s = strchr(s, ':')) {
 			char *next_path;
 			int seg_len;
+			struct stat sb;
 
 			if (s[0] == ':')
 				s++;
@@ -10690,7 +10693,9 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 				continue;
 			snprintf(result, result_sz, "%.*s/%s", seg_len, s, file);
 			/* ensure it is an executable file/link */
-			if (access(result, R_OK | X_OK) < 0)
+			if (stat(result, &sb) < 0)
+				continue;
+			if ((sb.st_mode & (S_IROTH | S_IXOTH)) != (S_IROTH | S_IXOTH))
 				continue;
 			pr_debug("resolved '%s' to '%s'\n", file, result);
 			return 0;
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index d18e37982344..19a6fbcfe9c0 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -7,6 +7,7 @@
 #include <libelf.h>
 #include <gelf.h>
 #include <unistd.h>
+#include <sys/stat.h>
 #include <linux/ptrace.h>
 #include <linux/kernel.h>
 
@@ -257,6 +258,7 @@ struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
 	static const char *ref_ctr_sysfs_path = "/sys/bus/event_source/devices/uprobe/format/ref_ctr_offset";
 	struct usdt_manager *man;
 	struct bpf_map *specs_map, *ip_to_spec_id_map;
+	struct stat sb;
 
 	specs_map = bpf_object__find_map_by_name(obj, "__bpf_usdt_specs");
 	ip_to_spec_id_map = bpf_object__find_map_by_name(obj, "__bpf_usdt_ip_to_spec_id");
@@ -282,7 +284,7 @@ struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
 	 * If this is not supported, USDTs with semaphores will not be supported.
 	 * Added in: a6ca88b241d5 ("trace_uprobe: support reference counter in fd-based uprobe")
 	 */
-	man->has_sema_refcnt = access(ref_ctr_sysfs_path, F_OK) == 0;
+	man->has_sema_refcnt = stat(ref_ctr_sysfs_path, &sb) == 0;
 
 	return man;
 }
-- 
2.37.3

