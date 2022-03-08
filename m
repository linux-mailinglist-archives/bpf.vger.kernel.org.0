Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1794D1B28
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 15:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347711AbiCHO7V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 09:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347714AbiCHO7P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 09:59:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EDAA20F52
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 06:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646751494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3p/D+LKC0CPwTQtFCwaC048P3XZEYMeJHbFVjQHPik=;
        b=bEdptXGs22qYVE+MULDLg1AaZ2JBLjZ0uQ7iUQ4IRR8Lc7xtkbCBJ3K1bAbQWKhdiFZES2
        bzfdl0bLbfUmEkN2lJekqlKU4AYxM+5txYxqz5qzMrg2/1qal1jq5F+eBG4CP8NhpHIMNQ
        mIuxZedrrXl8blfJpmYGjUuCzw9jyas=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-k0Q_W8JDPtGrTnsQP9WMOQ-1; Tue, 08 Mar 2022 09:58:13 -0500
X-MC-Unique: k0Q_W8JDPtGrTnsQP9WMOQ-1
Received: by mail-ej1-f70.google.com with SMTP id q22-20020a1709064cd600b006db14922f93so2901543ejt.7
        for <bpf@vger.kernel.org>; Tue, 08 Mar 2022 06:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y3p/D+LKC0CPwTQtFCwaC048P3XZEYMeJHbFVjQHPik=;
        b=Y7srlTVxVcY2SQzDky5uyoUm7DvZ2unpWo+2B+MwE0ObtLGn9O56hKdRq0QjPE14W/
         WShmsBVSjSKs0+woRdRqOQ8Bkw281is7ZZ+86x8JkLaIslAq0hWsExKtSlJeHjFKUIrS
         VvFr4eVeqi1zMyroINfQX7tNJctVFtT85iiDUDuXS5WiLO1jKc0bIClYwQiLFTL05Q1a
         uSwaDnE2If7vgsUkHNnTd9ZgUfqlTTH/9hungRD5Fwni9BLW5EfwjglA2EZr30yG9T83
         dnxmqPzz07IZyclc/pqu1b61KKaVwb+UDNm/Ps898EN9L0GCDFXcB280BUYbf2bI2ixa
         cDUg==
X-Gm-Message-State: AOAM532nWdgQQ8CS3hwie3vlAbWXwgsKxUBv7fNRPn2B2a3RwWKtm8oB
        Fd3BO4IQElS8W4lb3pVl5cgYWnY1MOl8EWYAnAbovAr1J/lxNDrGJxZWrW45k9uxvLSRhJ8DRQc
        CsPPODEYnsZhl
X-Received: by 2002:a05:6402:2548:b0:416:4155:e12 with SMTP id l8-20020a056402254800b0041641550e12mr11276608edb.175.1646751489444;
        Tue, 08 Mar 2022 06:58:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYFLAl8d95Ga+0g/easO+CIUBnQ+jRcIsWAh5LlijQ4M+kGaSdtwCxmmEd0GZo4+vPNaH3ag==
X-Received: by 2002:a05:6402:2548:b0:416:4155:e12 with SMTP id l8-20020a056402254800b0041641550e12mr11276412edb.175.1646751486830;
        Tue, 08 Mar 2022 06:58:06 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id p24-20020a1709061b5800b006da6435cedcsm5939105ejg.132.2022.03.08.06.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:58:05 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 39D0D1928D8; Tue,  8 Mar 2022 15:58:04 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v10 4/5] selftests/bpf: Move open_netns() and close_netns() into network_helpers.c
Date:   Tue,  8 Mar 2022 15:58:00 +0100
Message-Id: <20220308145801.46256-5-toke@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220308145801.46256-1-toke@redhat.com>
References: <20220308145801.46256-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These will also be used by the xdp_do_redirect test being added in the next
commit.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 86 ++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  9 ++
 .../selftests/bpf/prog_tests/tc_redirect.c    | 89 -------------------
 3 files changed, 95 insertions(+), 89 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 6db1af8fdee7..2bb1f9b3841d 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -1,18 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#define _GNU_SOURCE
+
 #include <errno.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
+#include <sched.h>
 
 #include <arpa/inet.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
 
 #include <linux/err.h>
 #include <linux/in.h>
 #include <linux/in6.h>
+#include <linux/limits.h>
 
 #include "bpf_util.h"
 #include "network_helpers.h"
+#include "test_progs.h"
 
 #define clean_errno() (errno == 0 ? "None" : strerror(errno))
 #define log_err(MSG, ...) ({						\
@@ -356,3 +363,82 @@ char *ping_command(int family)
 	}
 	return "ping";
 }
+
+struct nstoken {
+	int orig_netns_fd;
+};
+
+static int setns_by_fd(int nsfd)
+{
+	int err;
+
+	err = setns(nsfd, CLONE_NEWNET);
+	close(nsfd);
+
+	if (!ASSERT_OK(err, "setns"))
+		return err;
+
+	/* Switch /sys to the new namespace so that e.g. /sys/class/net
+	 * reflects the devices in the new namespace.
+	 */
+	err = unshare(CLONE_NEWNS);
+	if (!ASSERT_OK(err, "unshare"))
+		return err;
+
+	/* Make our /sys mount private, so the following umount won't
+	 * trigger the global umount in case it's shared.
+	 */
+	err = mount("none", "/sys", NULL, MS_PRIVATE, NULL);
+	if (!ASSERT_OK(err, "remount private /sys"))
+		return err;
+
+	err = umount2("/sys", MNT_DETACH);
+	if (!ASSERT_OK(err, "umount2 /sys"))
+		return err;
+
+	err = mount("sysfs", "/sys", "sysfs", 0, NULL);
+	if (!ASSERT_OK(err, "mount /sys"))
+		return err;
+
+	err = mount("bpffs", "/sys/fs/bpf", "bpf", 0, NULL);
+	if (!ASSERT_OK(err, "mount /sys/fs/bpf"))
+		return err;
+
+	return 0;
+}
+
+struct nstoken *open_netns(const char *name)
+{
+	int nsfd;
+	char nspath[PATH_MAX];
+	int err;
+	struct nstoken *token;
+
+	token = malloc(sizeof(struct nstoken));
+	if (!ASSERT_OK_PTR(token, "malloc token"))
+		return NULL;
+
+	token->orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
+	if (!ASSERT_GE(token->orig_netns_fd, 0, "open /proc/self/ns/net"))
+		goto fail;
+
+	snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
+	nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
+	if (!ASSERT_GE(nsfd, 0, "open netns fd"))
+		goto fail;
+
+	err = setns_by_fd(nsfd);
+	if (!ASSERT_OK(err, "setns_by_fd"))
+		goto fail;
+
+	return token;
+fail:
+	free(token);
+	return NULL;
+}
+
+void close_netns(struct nstoken *token)
+{
+	ASSERT_OK(setns_by_fd(token->orig_netns_fd), "setns_by_fd");
+	free(token);
+}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index d198181a5648..a4b3b2f9877b 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -55,4 +55,13 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 		  struct sockaddr_storage *addr, socklen_t *len);
 char *ping_command(int family);
 
+struct nstoken;
+/**
+ * open_netns() - Switch to specified network namespace by name.
+ *
+ * Returns token with which to restore the original namespace
+ * using close_netns().
+ */
+struct nstoken *open_netns(const char *name);
+void close_netns(struct nstoken *token);
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 2b255e28ed26..7ad66a247c02 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -10,8 +10,6 @@
  * to drop unexpected traffic.
  */
 
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <linux/if.h>
 #include <linux/if_tun.h>
@@ -19,10 +17,8 @@
 #include <linux/sysctl.h>
 #include <linux/time_types.h>
 #include <linux/net_tstamp.h>
-#include <sched.h>
 #include <stdbool.h>
 #include <stdio.h>
-#include <sys/mount.h>
 #include <sys/stat.h>
 #include <unistd.h>
 
@@ -92,91 +88,6 @@ static int write_file(const char *path, const char *newval)
 	return 0;
 }
 
-struct nstoken {
-	int orig_netns_fd;
-};
-
-static int setns_by_fd(int nsfd)
-{
-	int err;
-
-	err = setns(nsfd, CLONE_NEWNET);
-	close(nsfd);
-
-	if (!ASSERT_OK(err, "setns"))
-		return err;
-
-	/* Switch /sys to the new namespace so that e.g. /sys/class/net
-	 * reflects the devices in the new namespace.
-	 */
-	err = unshare(CLONE_NEWNS);
-	if (!ASSERT_OK(err, "unshare"))
-		return err;
-
-	/* Make our /sys mount private, so the following umount won't
-	 * trigger the global umount in case it's shared.
-	 */
-	err = mount("none", "/sys", NULL, MS_PRIVATE, NULL);
-	if (!ASSERT_OK(err, "remount private /sys"))
-		return err;
-
-	err = umount2("/sys", MNT_DETACH);
-	if (!ASSERT_OK(err, "umount2 /sys"))
-		return err;
-
-	err = mount("sysfs", "/sys", "sysfs", 0, NULL);
-	if (!ASSERT_OK(err, "mount /sys"))
-		return err;
-
-	err = mount("bpffs", "/sys/fs/bpf", "bpf", 0, NULL);
-	if (!ASSERT_OK(err, "mount /sys/fs/bpf"))
-		return err;
-
-	return 0;
-}
-
-/**
- * open_netns() - Switch to specified network namespace by name.
- *
- * Returns token with which to restore the original namespace
- * using close_netns().
- */
-static struct nstoken *open_netns(const char *name)
-{
-	int nsfd;
-	char nspath[PATH_MAX];
-	int err;
-	struct nstoken *token;
-
-	token = calloc(1, sizeof(struct nstoken));
-	if (!ASSERT_OK_PTR(token, "malloc token"))
-		return NULL;
-
-	token->orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
-	if (!ASSERT_GE(token->orig_netns_fd, 0, "open /proc/self/ns/net"))
-		goto fail;
-
-	snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
-	nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
-	if (!ASSERT_GE(nsfd, 0, "open netns fd"))
-		goto fail;
-
-	err = setns_by_fd(nsfd);
-	if (!ASSERT_OK(err, "setns_by_fd"))
-		goto fail;
-
-	return token;
-fail:
-	free(token);
-	return NULL;
-}
-
-static void close_netns(struct nstoken *token)
-{
-	ASSERT_OK(setns_by_fd(token->orig_netns_fd), "setns_by_fd");
-	free(token);
-}
-
 static int netns_setup_namespaces(const char *verb)
 {
 	const char * const *ns = namespaces;
-- 
2.35.1

