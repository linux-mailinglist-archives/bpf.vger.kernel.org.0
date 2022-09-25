Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024665E9150
	for <lists+bpf@lfdr.de>; Sun, 25 Sep 2022 09:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIYHEt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Sep 2022 03:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIYHEr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Sep 2022 03:04:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAFB13F5E
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 00:04:46 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z6so5864765wrq.1
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 00:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=7qy4eyTtycg4Lj6NX8cEGFTWtc//JOsv8rqbt6B4C1E=;
        b=JOU8UoemVO/+IRVTJ5UsANwTu3ujY6JSWB4UWZ5CmUqiS9iVHz8liwHBFVp9/nf7WI
         H/jguB6qM+pNTK7zBQ+Mf7ZTf0nF+0xgoqfcz736NalLIdf+yz5X1jbn8waoPVTn1/TW
         PSW4RdF3HoD5q7qcvpg2lyPZQqu8PLOBMyPod9X38zUAJ7kGYg3ZS9VBopvrgtA6wq5C
         eSQy6TGsjxtLV7xZZGtiC0+vK1UB67sTsMsghjbzZIVVZ2VL/b4+jWHzsxw+zzjBricJ
         0yZUdQrJUFkIJSN/MX/+nHvzVrzpd2Z/sxtvxNK5ZAe3e6f9GmV9BbsH/sz62s/u0csK
         rCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7qy4eyTtycg4Lj6NX8cEGFTWtc//JOsv8rqbt6B4C1E=;
        b=x30SnYSLH5h+O90iCSJjyeGppEAvOgs/QBn8BF/U7o4AatNVsIFUUKOe/VpJgz6iCt
         5cB6fusflgLDvu2OgLaMeDT7KUBnhguD+DXISgpg8zZRo9Z78t6ppZmup03WB9VfQT99
         1jEm4yH/xpT9eDNH2gn5FkHtuzrZAbF6IGxsfm2gbYU/Ain0iBW8dVYmfEq+wlZPgWHA
         V6NXpRH6r94CcfplMi789RIp1J9DPEz00GGg3fMBRQJ1RB+/7GfpvB5W9lU7AGh5baj6
         xWGJpNUsiFZFP7DLqnhShCm1zaLqejyeAUU5PagjW+rE7udDcGqdftdnX79RJBkFmjL4
         icGQ==
X-Gm-Message-State: ACrzQf1k9cFnZgkkJBTW18qafmZKEiRcGxRmUfobVIGW9/xfMMP8MzDb
        fDhC4Y7CFu/qTaAaqu5NOvG4uBkaSWk=
X-Google-Smtp-Source: AMsMyM7uIuiin6rZcK1BzK6ssPzxBj7gWCKCXjpsKV8jvG0JuqDB4u15g5WCDngaGPWUljdfysNjWQ==
X-Received: by 2002:a05:6000:1882:b0:22a:f402:c975 with SMTP id a2-20020a056000188200b0022af402c975mr9910270wri.532.1664089484045;
        Sun, 25 Sep 2022 00:04:44 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:6fc2:4af0:cc00:f99d:5d19:6e17:dc3a])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d6d0a000000b0022aeba020casm13115495wrq.83.2022.09.25.00.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 00:04:43 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc:     Jon Doron <jond@wiz.io>
Subject: [PATCH bpf-next v3] libbpf: Fix the case of running as non-root with capabilities
Date:   Sun, 25 Sep 2022 10:04:31 +0300
Message-Id: <20220925070431.1313680-1-arilou@gmail.com>
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

To resolve this this patch replaces all the access API calls with
faccessat with AT_EACCESS flag.

Signed-off-by: Jon Doron <jond@wiz.io>
---
 tools/lib/bpf/btf.c    | 2 +-
 tools/lib/bpf/libbpf.c | 6 +++---
 tools/lib/bpf/usdt.c   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b4d9a96c3c1b..d88647da2c7f 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4664,7 +4664,7 @@ struct btf *btf__load_vmlinux_btf(void)
 	for (i = 0; i < ARRAY_SIZE(locations); i++) {
 		snprintf(path, PATH_MAX, locations[i], buf.release);
 
-		if (access(path, R_OK))
+		if (faccessat(AT_FDCWD, path, R_OK, AT_EACCESS))
 			continue;
 
 		btf = btf__parse(path, NULL);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e691f08a297f..184ce1684dcd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -884,7 +884,7 @@ __u32 get_kernel_version(void)
 	__u32 major, minor, patch;
 	struct utsname info;
 
-	if (access(ubuntu_kver_file, R_OK) == 0) {
+	if (faccessat(AT_FDCWD, ubuntu_kver_file, R_OK, AT_EACCESS) == 0) {
 		FILE *f;
 
 		f = fopen(ubuntu_kver_file, "r");
@@ -9904,7 +9904,7 @@ static bool use_debugfs(void)
 	static int has_debugfs = -1;
 
 	if (has_debugfs < 0)
-		has_debugfs = access(DEBUGFS, F_OK) == 0;
+		has_debugfs = faccessat(AT_FDCWD, DEBUGFS, F_OK, AT_EACCESS) == 0;
 
 	return has_debugfs == 1;
 }
@@ -10721,7 +10721,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 				continue;
 			snprintf(result, result_sz, "%.*s/%s", seg_len, s, file);
 			/* ensure it has required permissions */
-			if (access(result, perm) < 0)
+			if (faccessat(AT_FDCWD, result, perm, AT_EACCESS) < 0)
 				continue;
 			pr_debug("resolved '%s' to '%s'\n", file, result);
 			return 0;
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index d18e37982344..e83b497c2245 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -282,7 +282,7 @@ struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
 	 * If this is not supported, USDTs with semaphores will not be supported.
 	 * Added in: a6ca88b241d5 ("trace_uprobe: support reference counter in fd-based uprobe")
 	 */
-	man->has_sema_refcnt = access(ref_ctr_sysfs_path, F_OK) == 0;
+	man->has_sema_refcnt = faccessat(AT_FDCWD, ref_ctr_sysfs_path, F_OK, AT_EACCESS) == 0;
 
 	return man;
 }
-- 
2.37.3

