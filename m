Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635A94CEE31
	for <lists+bpf@lfdr.de>; Sun,  6 Mar 2022 23:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbiCFWfO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Mar 2022 17:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiCFWfL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Mar 2022 17:35:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 748E2457BB
        for <bpf@vger.kernel.org>; Sun,  6 Mar 2022 14:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646606057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+lf1N38ZX9XVggX4HhFIvd5rD9LZZ1E76V794dhBp8=;
        b=BmexMlXSo6vmDdSNltFBGrTxIy6RLw2Tylhk45kErlpvOIDJMOgO2Ndrbodfv1DZ6cbgY+
        8s8QKOPIEfsvY2mQh/Zz41BhK9DuAjtXJTt2HKmTJchMSkbrl3x8j+TDTQ4MG4Pa5JEs2d
        Q/taOLvmVtBGABYSBYvElDq7T9sRD3I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-NpNbIjDnNf6UDT6RO_I9FA-1; Sun, 06 Mar 2022 17:34:16 -0500
X-MC-Unique: NpNbIjDnNf6UDT6RO_I9FA-1
Received: by mail-ed1-f69.google.com with SMTP id y10-20020a056402358a00b00410deddea4cso7431963edc.16
        for <bpf@vger.kernel.org>; Sun, 06 Mar 2022 14:34:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5+lf1N38ZX9XVggX4HhFIvd5rD9LZZ1E76V794dhBp8=;
        b=XHgaVeOxL3SxwR0mo3Rn19++rNIZI50RGlPXsZGi5sWDlGkg8ndgiGb/wILIx12d65
         aS9mp6De+j+1SSaD3v3LLtmI7NyBKtao3tqhoZSTUl4qWnxXm8/GJ36o/KtvOjwZYTTo
         lsx1X0I+Y/Zsj0BxridLPXisUiTcvWaLxxg+XXh68T2Oax+bIr/1nZqWZFvA2rqR/kEF
         dqv2nv50SLHvJRKEaJBy7OYBtIkCg6jjuWTcvyot2uX/rPgzcXa2dH46Rac+HayHDGhk
         Qdl8igTkn8v+LpyjpjJqmu4gxtVxzt0lyfPwAvz5BUknp9vAIegKVUzXSMHZVPzjaCoJ
         gWEg==
X-Gm-Message-State: AOAM532CSptjVlyHMXrLyUx6r2avS+DMsc3ERYTwGzGdS4JIEMp1O2a7
        cNNXOj7LZ70joGYXytutg/EaO2r16xOQiFJcbq3v/DVmiz3IgCYEguTVjjoQfHl3e+gxpsxXJOj
        ENsGgN9XUZJ/u
X-Received: by 2002:a17:906:bb01:b0:6a7:df9:d67c with SMTP id jz1-20020a170906bb0100b006a70df9d67cmr6840801ejb.733.1646606054537;
        Sun, 06 Mar 2022 14:34:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybrBa5QYRZaQ+gWgHE/Lwqm/I/ON3okXGB9Z0yoNustLbe34U/40BRyNVXCBSq4nc704V30Q==
X-Received: by 2002:a17:906:bb01:b0:6a7:df9:d67c with SMTP id jz1-20020a170906bb0100b006a70df9d67cmr6840668ejb.733.1646606050506;
        Sun, 06 Mar 2022 14:34:10 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k3-20020a05640212c300b0041605b2d9c1sm3671473edx.58.2022.03.06.14.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 14:34:09 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4D540131DF3; Sun,  6 Mar 2022 23:34:08 +0100 (CET)
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
Subject: [PATCH bpf-next v9 4/5] selftests/bpf: Move open_netns() and close_netns() into network_helpers.c
Date:   Sun,  6 Mar 2022 23:34:03 +0100
Message-Id: <20220306223404.60170-5-toke@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220306223404.60170-1-toke@redhat.com>
References: <20220306223404.60170-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These will also be used by the xdp_do_redirect test being added in the next
commit.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 86 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  9 ++
 .../selftests/bpf/prog_tests/tc_redirect.c    | 86 -------------------
 3 files changed, 95 insertions(+), 86 deletions(-)

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
index 2b255e28ed26..d9e48b3ac9a6 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -22,7 +22,6 @@
 #include <sched.h>
 #include <stdbool.h>
 #include <stdio.h>
-#include <sys/mount.h>
 #include <sys/stat.h>
 #include <unistd.h>
 
@@ -92,91 +91,6 @@ static int write_file(const char *path, const char *newval)
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

