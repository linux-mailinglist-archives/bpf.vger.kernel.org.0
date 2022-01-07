Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55BE487E9C
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 22:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiAGVyt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 16:54:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28281 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230221AbiAGVys (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 Jan 2022 16:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641592488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+vG9Qa9OkGa6HWCa2Inpz3+8aGl216Qd1qEl2tq6fs=;
        b=Y27UVpTwZ2fZXzlMELr7DW3YphYpJ5KBNB/Fmqq6puAGXxgcdreH+KmLlJXJ95AJllWq0G
        E2iQpTepTEwrYknz7AI/H4vjpjwAmy+aJFH8Q8HAD4eOu7H04jLRO4CDXWYFaCnP5/fMZT
        okbKsALgsr/SaTWu4GYGcDHb6kL/ieA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-80DQZwFrPaCwbESbOCvI4Q-1; Fri, 07 Jan 2022 16:54:45 -0500
X-MC-Unique: 80DQZwFrPaCwbESbOCvI4Q-1
Received: by mail-ed1-f69.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so5742459edb.4
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 13:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+vG9Qa9OkGa6HWCa2Inpz3+8aGl216Qd1qEl2tq6fs=;
        b=dnKFzdAovZvC2t1aBT07K7cPc6nvLsn+RqToWtymcTg80Igz0YnXCcbksep38vaGXv
         lAiWitn+NAGT11Y3vYW2QHZaqZk8W62Vd2EoN0tW0Wh4arAFHLSHEgojt2RwnxUwb22C
         mrgYdiQ+Btu0xNQqfXHdLFmNN+/6Z2hVWVee1lF97ScDUDP2EIP1a7goJH2xOXoqsJAo
         3earmZbBsJawceQ4ctCYieqkjLPfVNi5931gSpu3DP8ojxOH5M9rsvN/tYfhxhMEPQep
         6EhHr9w6oRlmCFcu9DuhbBLKaHmjzVL9QjAClM4FMOxy9c+VFKj5Xs3/euaPiG1kd2YK
         Yh6Q==
X-Gm-Message-State: AOAM530/tXcnvPHfedP9Uka70fNRrguh9LIMnvUTEDwritvAABt+Iuct
        fF+WfKNE//90IVU6D1QomNHqLuyN/Yh+3db8YGTCIE1ubNWIStB/cawixHnx+ozy6fZbEKoc3Lu
        QKDWl2FMlsssv
X-Received: by 2002:a17:907:d29:: with SMTP id gn41mr53650754ejc.124.1641592483864;
        Fri, 07 Jan 2022 13:54:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy40LQrWwZFXRylXH/1vsdIoGMX06eJwTDefuArTsBOPiSVY2fwcREoSGAW4tVQUZG1f2FVzA==
X-Received: by 2002:a17:907:d29:: with SMTP id gn41mr53650733ejc.124.1641592483510;
        Fri, 07 Jan 2022 13:54:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ho14sm1726455ejc.73.2022.01.07.13.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:54:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2F50A181F2E; Fri,  7 Jan 2022 22:54:42 +0100 (CET)
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
Subject: [PATCH bpf-next v7 2/3] selftests/bpf: Move open_netns() and close_netns() into network_helpers.c
Date:   Fri,  7 Jan 2022 22:54:37 +0100
Message-Id: <20220107215438.321922-3-toke@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107215438.321922-1-toke@redhat.com>
References: <20220107215438.321922-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These will also be used by the xdp_do_redirect test being added in the next
commit.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 86 ++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  9 ++
 .../selftests/bpf/prog_tests/tc_redirect.c    | 87 -------------------
 3 files changed, 95 insertions(+), 87 deletions(-)

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
index c2426df58e17..0a13c7eb40f3 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -17,10 +17,8 @@
 #include <linux/if_tun.h>
 #include <linux/limits.h>
 #include <linux/sysctl.h>
-#include <sched.h>
 #include <stdbool.h>
 #include <stdio.h>
-#include <sys/mount.h>
 #include <sys/stat.h>
 #include <unistd.h>
 
@@ -84,91 +82,6 @@ static int write_file(const char *path, const char *newval)
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
-	token = malloc(sizeof(struct nstoken));
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
2.34.1

