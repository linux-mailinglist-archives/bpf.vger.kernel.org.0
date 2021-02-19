Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D8631FC58
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 16:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhBSPq0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 10:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhBSPqR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Feb 2021 10:46:17 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB63C061793
        for <bpf@vger.kernel.org>; Fri, 19 Feb 2021 07:44:13 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h98so4345290wrh.11
        for <bpf@vger.kernel.org>; Fri, 19 Feb 2021 07:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cI+4Q9B2K94JT+5DcTEoKVkp9ZKpdCHdFbImC42RINU=;
        b=ML3kdmbbpIyftsTOrKVlZPpVXWHgHuoF5jfTe6kyTWDrnvWYDTJyAw/e/JlJheESJD
         qg/DF9LYBgN/jQ5n5mVFUjh1RUV9JAGXNMJRWJevuovRxcfQYCTlfQujVWVISOhq0S3S
         6OlJw3ODsdm0KErWshrA9Ia1qsNehXmYEHFbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cI+4Q9B2K94JT+5DcTEoKVkp9ZKpdCHdFbImC42RINU=;
        b=MnfvnSU+FTgDYGmi92kBMe05UvIx7g6CIYVaOrRqwi4A/tbySS1l8k3DPKXCoa0yS2
         ElBUrnl/vA/t19dp4S2tTJFylG2f7i87YHr8pkuP0W1XJAnBDmChHjTf6+ekRckiSXTV
         mOK1OWv489lJGUQy2EIuj5Vvkz+2RvRqhH1I1ifSsASdoiAVPTPPqVlISdECayYPaT0w
         E1Fbo9fVW7hnnvqc00Y0b/VMHA762xCTbO2fUWG2wivd/OSey3LhBRcYkq7Z4QaNXMrC
         qXVDXV/5iTX9nkfnowx30mxBGlyUFWgvKlbtJA02YsemT7XY9d5ZBx020S1Igow0neXe
         Spcw==
X-Gm-Message-State: AOAM530N94/c0iujb7n00+L8KzKsV9S89nGLma6XEq5H4NJagKmDOrz/
        zDcYFf90Uar8LBrtxve8vlC6jw==
X-Google-Smtp-Source: ABdhPJxVajEgO7Z+gOU81z6VmDT2cmSmItdL24rRyJzznlubj4Yy9owD+ZdnbdLIj6KIULUAOzS4vQ==
X-Received: by 2002:a05:6000:1101:: with SMTP id z1mr9982196wrw.110.1613749452606;
        Fri, 19 Feb 2021 07:44:12 -0800 (PST)
Received: from antares.lan (b.3.5.8.9.a.e.c.e.a.6.2.c.1.9.b.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:b91c:26ae:cea9:853b])
        by smtp.gmail.com with ESMTPSA id v204sm12321929wmg.38.2021.02.19.07.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 07:44:12 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     eric.dumazet@gmail.com, daniel@iogearbox.net, ast@kernel.org,
        andrii@kernel.org
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 3/4] tools/testing: add test for NS_GET_COOKIE
Date:   Fri, 19 Feb 2021 15:43:29 +0000
Message-Id: <20210219154330.93615-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210219154330.93615-1-lmb@cloudflare.com>
References: <20210219154330.93615-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Check that NS_GET_COOKIE returns a non-zero value, and that distinct
network namespaces have different cookies.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 tools/testing/selftests/nsfs/.gitignore |  1 +
 tools/testing/selftests/nsfs/Makefile   |  2 +-
 tools/testing/selftests/nsfs/config     |  1 +
 tools/testing/selftests/nsfs/netns.c    | 57 +++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/nsfs/netns.c

diff --git a/tools/testing/selftests/nsfs/.gitignore b/tools/testing/selftests/nsfs/.gitignore
index ed79ebdf286e..ca31b216215b 100644
--- a/tools/testing/selftests/nsfs/.gitignore
+++ b/tools/testing/selftests/nsfs/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 owner
 pidns
+netns
diff --git a/tools/testing/selftests/nsfs/Makefile b/tools/testing/selftests/nsfs/Makefile
index dd9bd50b7b93..93793cdb5a7c 100644
--- a/tools/testing/selftests/nsfs/Makefile
+++ b/tools/testing/selftests/nsfs/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-TEST_GEN_PROGS := owner pidns
+TEST_GEN_PROGS := owner pidns netns
 
 CFLAGS := -Wall -Werror
 
diff --git a/tools/testing/selftests/nsfs/config b/tools/testing/selftests/nsfs/config
index 598d0a225fc9..ea654f6a4cd9 100644
--- a/tools/testing/selftests/nsfs/config
+++ b/tools/testing/selftests/nsfs/config
@@ -1,3 +1,4 @@
 CONFIG_USER_NS=y
 CONFIG_UTS_NS=y
 CONFIG_PID_NS=y
+CONFIG_NET_NS=y
diff --git a/tools/testing/selftests/nsfs/netns.c b/tools/testing/selftests/nsfs/netns.c
new file mode 100644
index 000000000000..8ab862667b45
--- /dev/null
+++ b/tools/testing/selftests/nsfs/netns.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+
+#define NSIO    0xb7
+#define NS_GET_COOKIE   _IO(NSIO, 0x5)
+
+#define pr_err(fmt, ...) \
+		({ \
+			fprintf(stderr, "%s:%d:" fmt ": %m\n", \
+				__func__, __LINE__, ##__VA_ARGS__); \
+			1; \
+		})
+
+int main(int argc, char *argvp[])
+{
+	uint64_t cookie1, cookie2;
+	char path[128];
+	int ns;
+
+	snprintf(path, sizeof(path), "/proc/%d/ns/net", getpid());
+	ns = open(path, O_RDONLY);
+	if (ns < 0)
+		return pr_err("Unable to open %s", path);
+
+	if (ioctl(ns, NS_GET_COOKIE, &cookie1))
+		return pr_err("Unable to get first namespace cookie");
+
+	if (!cookie1)
+		return pr_err("NS_GET_COOKIE returned zero first cookie");
+
+	close(ns);
+	if (unshare(CLONE_NEWNET))
+		return pr_err("unshare");
+
+	ns = open(path, O_RDONLY);
+	if (ns < 0)
+		return pr_err("Unable to open %s", path);
+
+	if (ioctl(ns, NS_GET_COOKIE, &cookie2))
+		return pr_err("Unable to get second namespace cookie");
+
+	if (!cookie2)
+		return pr_err("NS_GET_COOKIE returned zero second cookie");
+
+	if (cookie1 == cookie2)
+		return pr_err("NS_GET_COOKIE returned identical cookies for distinct ns");
+
+	close(ns);
+	return 0;
+}
-- 
2.27.0

