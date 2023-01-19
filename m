Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604826746FB
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 00:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjASXOL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 18:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjASXNb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 18:13:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6AA5BB9;
        Thu, 19 Jan 2023 15:10:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 097A761CEB;
        Thu, 19 Jan 2023 23:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA82C43392;
        Thu, 19 Jan 2023 23:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674169845;
        bh=hc+zSS6UN7/G+UWGJaA93YRrvGjaJMf/t5FWQ/bg9VE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bjsZBJmizHCvJgwlmNokNYxSyHU01LMXcd7WQWlNqRK2t7Mqpd4o6kzErdvDwZK+0
         ECoFT6rXetUkRVDeiWL2/ehqsqxgZE31/q6IoRihE50x0iHi71+kKk1Maz1dgU+Z48
         t+VgSU6VFw4VI3Mbfrcgk2Um8pK0o7ZIfrCQh6unrK7H9tHkdjvs6KQrIu+g9FUPiY
         m2EKA03ERBktiq8W84UjZG7emv8zWR1aQUR9C3bqK9TdODE2SfmXXZIH6E9eMxwgxk
         y/yzcDbKShH9hsHtAwKVqKrLjmci2Dy/PqmBCKuwL8S5H6DxuYj3EqnaPFzw1jiqkn
         j1ZehgtkTM0gQ==
From:   KP Singh <kpsingh@kernel.org>
To:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, casey@schaufler-ca.com,
        song@kernel.org, revest@chromium.org, keescook@chromium.org,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next 2/4] security: Generate a header with the count of enabled LSMs
Date:   Fri, 20 Jan 2023 00:10:31 +0100
Message-Id: <20230119231033.1307221-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
In-Reply-To: <20230119231033.1307221-1-kpsingh@kernel.org>
References: <20230119231033.1307221-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The header defines a MAX_LSM_COUNT constant which is used in a
subsequent patch to generate the static calls for each LSM hook which
are named using preprocessor token pasting. Since token pasting does not
work with arithmetic expressions, generate a simple lsm_count.h header
which represents the subset of LSMs that can be enabled on a given
kernel based on the config.

While one can generate static calls for all the possible LSMs that the
kernel has, this is actually wasteful as most kernels only enable a
handful of LSMs.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 scripts/Makefile                 |  1 +
 scripts/security/.gitignore      |  1 +
 scripts/security/Makefile        |  4 +++
 scripts/security/gen_lsm_count.c | 57 ++++++++++++++++++++++++++++++++
 security/Makefile                | 11 ++++++
 5 files changed, 74 insertions(+)
 create mode 100644 scripts/security/.gitignore
 create mode 100644 scripts/security/Makefile
 create mode 100644 scripts/security/gen_lsm_count.c

diff --git a/scripts/Makefile b/scripts/Makefile
index 1575af84d557..9712249c0fb3 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -41,6 +41,7 @@ targets += module.lds
 subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
 subdir-$(CONFIG_MODVERSIONS) += genksyms
 subdir-$(CONFIG_SECURITY_SELINUX) += selinux
+subdir-$(CONFIG_SECURITY) += security
 
 # Let clean descend into subdirs
 subdir-	+= basic dtc gdb kconfig mod
diff --git a/scripts/security/.gitignore b/scripts/security/.gitignore
new file mode 100644
index 000000000000..684af16735f1
--- /dev/null
+++ b/scripts/security/.gitignore
@@ -0,0 +1 @@
+gen_lsm_count
diff --git a/scripts/security/Makefile b/scripts/security/Makefile
new file mode 100644
index 000000000000..05f7e4109052
--- /dev/null
+++ b/scripts/security/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+hostprogs-always-y += gen_lsm_count
+HOST_EXTRACFLAGS += \
+	-I$(srctree)/include/uapi -I$(srctree)/include
diff --git a/scripts/security/gen_lsm_count.c b/scripts/security/gen_lsm_count.c
new file mode 100644
index 000000000000..a9a227724d84
--- /dev/null
+++ b/scripts/security/gen_lsm_count.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* NOTE: we really do want to use the kernel headers here */
+#define __EXPORTED_HEADERS__
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <ctype.h>
+
+#include <linux/kconfig.h>
+
+#define GEN_MAX_LSM_COUNT (				\
+	/* Capabilities */				\
+	IS_ENABLED(CONFIG_SECURITY) +			\
+	IS_ENABLED(CONFIG_SECURITY_SELINUX) +		\
+	IS_ENABLED(CONFIG_SECURITY_SMACK) +		\
+	IS_ENABLED(CONFIG_SECURITY_TOMOYO) +		\
+	IS_ENABLED(CONFIG_SECURITY_APPARMOR) +		\
+	IS_ENABLED(CONFIG_SECURITY_YAMA) +		\
+	IS_ENABLED(CONFIG_SECURITY_LOADPIN) +		\
+	IS_ENABLED(CONFIG_SECURITY_SAFESETID) +		\
+	IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) + 	\
+	IS_ENABLED(CONFIG_BPF_LSM) + \
+	IS_ENABLED(CONFIG_SECURITY_LANDLOCK))
+
+const char *progname;
+
+static void usage(void)
+{
+	printf("usage: %s lsm_count.h\n", progname);
+	exit(1);
+}
+
+int main(int argc, char *argv[])
+{
+	FILE *fout;
+
+	progname = argv[0];
+
+	if (argc < 2)
+		usage();
+
+	fout = fopen(argv[1], "w");
+	if (!fout) {
+		fprintf(stderr, "Could not open %s for writing:  %s\n",
+			argv[1], strerror(errno));
+		exit(2);
+	}
+
+	fprintf(fout, "#ifndef _LSM_COUNT_H_\n#define _LSM_COUNT_H_\n\n");
+	fprintf(fout, "\n#define MAX_LSM_COUNT %d\n", GEN_MAX_LSM_COUNT);
+	fprintf(fout, "#endif /* _LSM_COUNT_H_ */\n");
+	exit(0);
+}
diff --git a/security/Makefile b/security/Makefile
index 18121f8f85cd..7a47174831f4 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -3,6 +3,7 @@
 # Makefile for the kernel security code
 #
 
+gen := include/generated
 obj-$(CONFIG_KEYS)			+= keys/
 
 # always enable default capabilities
@@ -27,3 +28,13 @@ obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
 
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+= integrity/
+
+$(addprefix $(obj)/,$(obj-y)): $(gen)/lsm_count.h
+
+quiet_cmd_lsm_count = GEN     ${gen}/lsm_count.h
+      cmd_lsm_count = scripts/security/gen_lsm_count ${gen}/lsm_count.h
+
+targets += lsm_count.h
+
+${gen}/lsm_count.h: FORCE
+	$(call if_changed,lsm_count)
-- 
2.39.0.246.g2a6d74b583-goog

