Return-Path: <bpf+bounces-9082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DA178F081
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 17:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B032281697
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 15:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16DE168B2;
	Thu, 31 Aug 2023 15:35:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D8C134B7;
	Thu, 31 Aug 2023 15:35:27 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC998F;
	Thu, 31 Aug 2023 08:35:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c1f6f3884so110700966b.0;
        Thu, 31 Aug 2023 08:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693496123; x=1694100923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0V38OZAZ+/8KnQJ0LoAo4AXJPddy0zhKRJfzXBFgPnU=;
        b=dJ4hHR0nAKJVDU+ojNW8lK5uSud770Fm7EgyKZ6JYVzMYjH+KPSsJcRVSaSXycUEiy
         DvT/BVFlBLD0BDkPtclFP9nCurKrCw2j71AAU8P5508tTwR3VngWJiwccl6/mzhpwQZB
         CPGUWfrHg5PsXUDlLY/ltInxP0ZWKA1Rbm6aBfP2jmD1Yt+gGYxT0iVoGElmKgZdVjA8
         t6yA2kNnQC6LzAaUY2ENvV0evIvyql4/xIGu6u7PXEMIS2QIrBUGf5Ksu1yeTM5pd9kD
         beUVsP4c0crMvrBYPWMb0QotFoeEZDabzK8d1Jeq+9zBDi+AvH9xi6M12qKxpvMRTkzc
         i29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693496123; x=1694100923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0V38OZAZ+/8KnQJ0LoAo4AXJPddy0zhKRJfzXBFgPnU=;
        b=E2EcSzOGzscr08u6ZLLcnVayoanLgxfpzO8S4dH/7YdT11BqrEmJkve4L10xvTCR6U
         d8teQGoLttjVdRldBHlMj87Pi8pJgKRL8z+64BckB9AWTBj+S3pcG4fCWk5yBeBjLKik
         eqXMANEfR/ekVAQ9MtyVDJAeTuWQc/prRbU2qMvZHxY8QjcvkMwpD44zrDie/iz6QjbQ
         m++FnN2jUhy8EK4Jdvemldmqc13uuzpOQIv1bdVv0K3mcXR7koP1/CoLlCYz/aU1JIcT
         WpoYzDTb6aVIZ0JUSvFPddWlqdw4paeY18nwbYdVWbFH/y29vd6XcUZOlzyoPM9TgWP0
         fU5A==
X-Gm-Message-State: AOJu0YyOmrfzudee6iYLlKIHJ8o8rjnLBYqxWGC4RYVnWxrII1ntB0Ad
	H5OFMgUKeeH70mjPognU7XmJsE5bq2VNn3//yVg=
X-Google-Smtp-Source: AGHT+IGm/BLKA9sWimrsePDUae5aedwMWjdyDEVPEumZgnwH1eG/BuLS78b1BgHsisFEmmeCPHehUg==
X-Received: by 2002:a17:907:a057:b0:99c:a23b:b4f4 with SMTP id gz23-20020a170907a05700b0099ca23bb4f4mr3972345ejc.2.1693496122688;
        Thu, 31 Aug 2023 08:35:22 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:a62f])
        by smtp.googlemail.com with ESMTPSA id ds11-20020a170907724b00b0099bcf9c2ec6sm868583ejc.75.2023.08.31.08.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:35:22 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 9/9] selftests/bpf: Add tests for cgroup unix socket address hooks
Date: Thu, 31 Aug 2023 17:34:53 +0200
Message-ID: <20230831153455.1867110-10-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831153455.1867110-1-daan.j.demeyer@gmail.com>
References: <20230831153455.1867110-1-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

These selftests are written in prog_tests style instead of adding
them to the existing test_sock_addr tests. Migrating the existing
sock addr tests to prog_tests style is left for future work.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  14 +
 tools/testing/selftests/bpf/network_helpers.c |  34 ++
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/section_names.c  |  30 ++
 .../selftests/bpf/prog_tests/sock_addr.c      | 461 ++++++++++++++++++
 .../testing/selftests/bpf/progs/bindun_prog.c |  39 ++
 .../selftests/bpf/progs/connectun_prog.c      |  40 ++
 .../selftests/bpf/progs/recvmsgun_prog.c      |  39 ++
 .../selftests/bpf/progs/sendmsgun_prog.c      |  40 ++
 9 files changed, 698 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_addr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bindun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/connectun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/recvmsgun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/sendmsgun_prog.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 642dda0e758a..aa376792c4a4 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -1,6 +1,8 @@
 #ifndef __BPF_KFUNCS__
 #define __BPF_KFUNCS__
 
+struct bpf_sock_addr_kern;
+
 /* Description
  *  Initializes an skb-type dynptr
  * Returns
@@ -41,4 +43,16 @@ extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym;
 extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym;
 extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dynptr *clone__init) __ksym;
 
+/* Description
+ *  Modify the address of a AF_UNIX sockaddr.
+ * Returns__bpf_kfunc
+ *  -EINVAL if the address size is too big or, 0 if the sockaddr was successfully modified.
+ */
+extern int bpf_sock_addr_set_unix_addr(struct bpf_sock_addr_kern *sa_kern,
+				       const __u8 *addr, __u32 addrlen__sz) __ksym;
+
+void *bpf_cast_to_kern_ctx(void *) __ksym;
+
+void *bpf_rdonly_cast(void *obj, __u32 btf_id) __ksym;
+
 #endif
diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index da72a3a66230..6db27a9088e9 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -11,6 +11,7 @@
 #include <arpa/inet.h>
 #include <sys/mount.h>
 #include <sys/stat.h>
+#include <sys/un.h>
 
 #include <linux/err.h>
 #include <linux/in.h>
@@ -257,6 +258,26 @@ static int connect_fd_to_addr(int fd,
 	return 0;
 }
 
+int connect_to_addr(const struct sockaddr_storage *addr, socklen_t addrlen, int type)
+{
+	int fd;
+
+	fd = socket(addr->ss_family, type, 0);
+	if (fd < 0) {
+		log_err("Failed to create client socket");
+		return -1;
+	}
+
+	if (connect_fd_to_addr(fd, addr, addrlen, false))
+		goto error_close;
+
+	return fd;
+
+error_close:
+	save_errno_close(fd);
+	return -1;
+}
+
 static const struct network_helper_opts default_opts;
 
 int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts)
@@ -380,6 +401,19 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 		if (len)
 			*len = sizeof(*sin6);
 		return 0;
+	} else if (family == AF_UNIX) {
+		/* Note that we always use abstract unix sockets to avoid having
+		 * to clean up leftover files.
+		 */
+		struct sockaddr_un *sun = (void *)addr;
+
+		memset(addr, 0, sizeof(*sun));
+		sun->sun_family = family;
+		sun->sun_path[0] = 0;
+		strcpy(sun->sun_path + 1, addr_str);
+		if (len)
+			*len = offsetof(struct sockaddr_un, sun_path) + 1 + strlen(addr_str);
+		return 0;
 	}
 	return -1;
 }
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 5eccc67d1a99..34f1200a781b 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -51,6 +51,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 			    __u16 port, int timeout_ms,
 			    unsigned int nr_listens);
 void free_fds(int *fds, unsigned int nr_close_fds);
+int connect_to_addr(const struct sockaddr_storage *addr, socklen_t len, int type);
 int connect_to_fd(int server_fd, int timeout_ms);
 int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts);
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
diff --git a/tools/testing/selftests/bpf/prog_tests/section_names.c b/tools/testing/selftests/bpf/prog_tests/section_names.c
index fc5248e94a01..51ebc8e6065d 100644
--- a/tools/testing/selftests/bpf/prog_tests/section_names.c
+++ b/tools/testing/selftests/bpf/prog_tests/section_names.c
@@ -113,6 +113,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_BIND},
 		{0, BPF_CGROUP_INET6_BIND},
 	},
+	{
+		"cgroup/bindun",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_BIND},
+		{0, BPF_CGROUP_UNIX_BIND},
+	},
 	{
 		"cgroup/connect4",
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_CONNECT},
@@ -123,6 +128,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_CONNECT},
 		{0, BPF_CGROUP_INET6_CONNECT},
 	},
+	{
+		"cgroup/connectun",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_CONNECT},
+		{0, BPF_CGROUP_UNIX_CONNECT},
+	},
 	{
 		"cgroup/sendmsg4",
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_SENDMSG},
@@ -133,6 +143,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6_SENDMSG},
 		{0, BPF_CGROUP_UDP6_SENDMSG},
 	},
+	{
+		"cgroup/sendmsgun",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_SENDMSG},
+		{0, BPF_CGROUP_UNIX_SENDMSG},
+	},
 	{
 		"cgroup/recvmsg4",
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_RECVMSG},
@@ -143,6 +158,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6_RECVMSG},
 		{0, BPF_CGROUP_UDP6_RECVMSG},
 	},
+	{
+		"cgroup/recvmsgun",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_RECVMSG},
+		{0, BPF_CGROUP_UNIX_RECVMSG},
+	},
 	{
 		"cgroup/sysctl",
 		{0, BPF_PROG_TYPE_CGROUP_SYSCTL, BPF_CGROUP_SYSCTL},
@@ -168,6 +188,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETPEERNAME},
 		{0, BPF_CGROUP_INET6_GETPEERNAME},
 	},
+	{
+		"cgroup/getpeernameun",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_GETPEERNAME},
+		{0, BPF_CGROUP_UNIX_GETPEERNAME},
+	},
 	{
 		"cgroup/getsockname4",
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETSOCKNAME},
@@ -178,6 +203,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETSOCKNAME},
 		{0, BPF_CGROUP_INET6_GETSOCKNAME},
 	},
+	{
+		"cgroup/getsocknameun",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_GETSOCKNAME},
+		{0, BPF_CGROUP_UNIX_GETSOCKNAME},
+	},
 };
 
 static void test_prog_type_by_name(const struct sec_name_test *test)
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
new file mode 100644
index 000000000000..07941dd48efb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/un.h>
+
+#include "test_progs.h"
+
+#include "bindun_prog.skel.h"
+#include "connectun_prog.skel.h"
+#include "sendmsgun_prog.skel.h"
+#include "recvmsgun_prog.skel.h"
+#include "network_helpers.h"
+
+#define SERVUN_ADDRESS         "bpf_cgroup_unix_test"
+#define SERVUN_REWRITE_ADDRESS "bpf_cgroup_unix_test_rewrite"
+#define SRCUN_ADDRESS	       "bpf_cgroup_unix_test_src"
+
+enum sock_addr_test_type {
+	SOCK_ADDR_TEST_BIND,
+	SOCK_ADDR_TEST_CONNECT,
+	SOCK_ADDR_TEST_SENDMSG,
+	SOCK_ADDR_TEST_RECVMSG,
+};
+
+struct sock_addr_test;
+
+typedef void *(*load_fn)(int cgroup_fd);
+typedef void (*destroy_fn)(void *skel);
+
+struct sock_addr_test {
+	enum sock_addr_test_type type;
+	const char *name;
+	/* BPF prog properties */
+	load_fn loadfn;
+	destroy_fn destroyfn;
+	/* Socket properties */
+	int socket_family;
+	int socket_type;
+	/* IP:port pairs for BPF prog to override */
+	const char *requested_addr;
+	unsigned short requested_port;
+	const char *expected_addr;
+	unsigned short expected_port;
+	const char *expected_src_addr;
+};
+
+static void *bindun_prog_load(int cgroup_fd)
+{
+	struct bindun_prog *skel;
+
+	skel = bindun_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	skel->links.bindun_prog = bpf_program__attach_cgroup(
+		skel->progs.bindun_prog, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.bindun_prog, "prog_attach"))
+		goto cleanup;
+
+	return skel;
+cleanup:
+	bindun_prog__destroy(skel);
+	return NULL;
+}
+
+static void bindun_prog_destroy(void *skel)
+{
+	bindun_prog__destroy(skel);
+}
+
+static void *connectun_prog_load(int cgroup_fd)
+{
+	struct connectun_prog *skel;
+
+	skel = connectun_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	skel->links.connectun_prog = bpf_program__attach_cgroup(
+		skel->progs.connectun_prog, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.connectun_prog, "prog_attach"))
+		goto cleanup;
+
+	return skel;
+cleanup:
+	connectun_prog__destroy(skel);
+	return NULL;
+}
+
+static void connectun_prog_destroy(void *skel)
+{
+	connectun_prog__destroy(skel);
+}
+
+static void *sendmsgun_prog_load(int cgroup_fd)
+{
+	struct sendmsgun_prog *skel;
+
+	skel = sendmsgun_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	skel->links.sendmsgun_prog = bpf_program__attach_cgroup(
+		skel->progs.sendmsgun_prog, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.sendmsgun_prog, "prog_attach"))
+		goto cleanup;
+
+	return skel;
+cleanup:
+	sendmsgun_prog__destroy(skel);
+	return NULL;
+}
+
+static void sendmsgun_prog_destroy(void *skel)
+{
+	sendmsgun_prog__destroy(skel);
+}
+
+static void *recvmsgun_prog_load(int cgroup_fd)
+{
+	struct recvmsgun_prog *skel;
+
+	skel = recvmsgun_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	skel->links.recvmsgun_prog = bpf_program__attach_cgroup(
+		skel->progs.recvmsgun_prog, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.recvmsgun_prog, "prog_attach"))
+		goto cleanup;
+
+	return skel;
+cleanup:
+	recvmsgun_prog__destroy(skel);
+	return NULL;
+}
+
+static void recvmsgun_prog_destroy(void *skel)
+{
+	recvmsgun_prog__destroy(skel);
+}
+
+static struct sock_addr_test tests[] = {
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bindun",
+		bindun_prog_load,
+		bindun_prog_destroy,
+		AF_UNIX,
+		SOCK_STREAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connectun",
+		connectun_prog_load,
+		connectun_prog_destroy,
+		AF_UNIX,
+		SOCK_STREAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsgun",
+		sendmsgun_prog_load,
+		sendmsgun_prog_destroy,
+		AF_UNIX,
+		SOCK_DGRAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+	},
+	{
+		SOCK_ADDR_TEST_RECVMSG,
+		"recvmsgun",
+		recvmsgun_prog_load,
+		recvmsgun_prog_destroy,
+		AF_UNIX,
+		SOCK_DGRAM,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		SERVUN_ADDRESS,
+	},
+};
+
+typedef int (*info_fn)(int, struct sockaddr *, socklen_t *);
+
+static int cmp_addr(const struct sockaddr_storage *addr1, socklen_t addr1_len,
+		    const struct sockaddr_storage *addr2, socklen_t addr2_len,
+		    bool cmp_port)
+{
+	const struct sockaddr_in *four1, *four2;
+	const struct sockaddr_in6 *six1, *six2;
+	const struct sockaddr_un *un1, *un2;
+
+	if (addr1->ss_family != addr2->ss_family)
+		return -1;
+
+	if (addr1_len != addr2_len)
+		return -1;
+
+	if (addr1->ss_family == AF_INET) {
+		four1 = (const struct sockaddr_in *)addr1;
+		four2 = (const struct sockaddr_in *)addr2;
+		return !((four1->sin_port == four2->sin_port || !cmp_port) &&
+			 four1->sin_addr.s_addr == four2->sin_addr.s_addr);
+	} else if (addr1->ss_family == AF_INET6) {
+		six1 = (const struct sockaddr_in6 *)addr1;
+		six2 = (const struct sockaddr_in6 *)addr2;
+		return !((six1->sin6_port == six2->sin6_port || !cmp_port) &&
+			 !memcmp(&six1->sin6_addr, &six2->sin6_addr,
+				 sizeof(struct in6_addr)));
+	} else if (addr1->ss_family == AF_UNIX) {
+		un1 = (const struct sockaddr_un *)addr1;
+		un2 = (const struct sockaddr_un *)addr2;
+		return memcmp(un1, un2, addr1_len);
+	}
+
+	return -1;
+}
+
+static int cmp_sock_addr(info_fn fn, int sock1,
+			 const struct sockaddr_storage *addr2,
+			 socklen_t addr2_len, bool cmp_port)
+{
+	struct sockaddr_storage addr1;
+	socklen_t len1 = sizeof(addr1);
+
+	memset(&addr1, 0, len1);
+	if (fn(sock1, (struct sockaddr *)&addr1, (socklen_t *)&len1) != 0)
+		return -1;
+
+	return cmp_addr(&addr1, len1, addr2, addr2_len, cmp_port);
+}
+
+static int cmp_local_addr(int sock1, const struct sockaddr_storage *addr2,
+			  socklen_t addr2_len, bool cmp_port)
+{
+	return cmp_sock_addr(getsockname, sock1, addr2, addr2_len, cmp_port);
+}
+
+static int cmp_peer_addr(int sock1, const struct sockaddr_storage *addr2,
+			 socklen_t addr2_len, bool cmp_port)
+{
+	return cmp_sock_addr(getpeername, sock1, addr2, addr2_len, cmp_port);
+}
+
+static void test_bind(struct sock_addr_test *test)
+{
+	struct sockaddr_storage expected_addr;
+	socklen_t expected_addr_len = sizeof(struct sockaddr_storage);
+	int serv = -1, client = -1, err;
+
+	serv = start_server(test->socket_family, test->socket_type,
+			    test->requested_addr, test->requested_port, 0);
+	if (!ASSERT_GE(serv, 0, "start_server"))
+		goto cleanup;
+
+	err = make_sockaddr(test->socket_family,
+			    test->expected_addr, test->expected_port,
+			    &expected_addr, &expected_addr_len);
+	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
+		goto cleanup;
+
+	err = cmp_local_addr(serv, &expected_addr, expected_addr_len, true);
+	if (!ASSERT_EQ(err, 0, "cmp_local_addr"))
+		goto cleanup;
+
+	/* Try to connect to server just in case */
+	client = connect_to_addr(&expected_addr, expected_addr_len, test->socket_type);
+	if (!ASSERT_GE(client, 0, "connect_to_addr"))
+		goto cleanup;
+
+cleanup:
+	if (client != -1)
+		close(client);
+	if (serv != -1)
+		close(serv);
+}
+
+static void test_connect(struct sock_addr_test *test)
+{
+	struct sockaddr_storage addr, expected_addr, expected_src_addr;
+	socklen_t addr_len = sizeof(struct sockaddr_storage),
+		  expected_addr_len = sizeof(struct sockaddr_storage),
+		  expected_src_addr_len = sizeof(struct sockaddr_storage);
+	int serv = -1, client = -1, err;
+
+	serv = start_server(test->socket_family, test->socket_type,
+			    test->expected_addr, test->expected_port, 0);
+	if (!ASSERT_GE(serv, 0, "start_server"))
+		goto cleanup;
+
+	err = make_sockaddr(test->socket_family, test->requested_addr, test->requested_port,
+			    &addr, &addr_len);
+	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
+		goto cleanup;
+
+	client = connect_to_addr(&addr, addr_len, test->socket_type);
+	if (!ASSERT_GE(client, 0, "connect_to_addr"))
+		goto cleanup;
+
+	err = make_sockaddr(test->socket_family, test->expected_addr, test->expected_port,
+			    &expected_addr, &expected_addr_len);
+	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
+		goto cleanup;
+
+	if (test->expected_src_addr) {
+		err = make_sockaddr(test->socket_family, test->expected_src_addr, 0,
+				    &expected_src_addr, &expected_src_addr_len);
+		if (!ASSERT_EQ(err, 0, "make_sockaddr"))
+			goto cleanup;
+	}
+
+	err = cmp_peer_addr(client, &expected_addr, expected_addr_len, true);
+	if (!ASSERT_EQ(err, 0, "cmp_peer_addr"))
+		goto cleanup;
+
+	if (test->expected_src_addr) {
+		err = cmp_local_addr(client, &expected_src_addr, expected_src_addr_len, false);
+		if (!ASSERT_EQ(err, 0, "cmp_local_addr"))
+			goto cleanup;
+	}
+cleanup:
+	if (client != -1)
+		close(client);
+	if (serv != -1)
+		close(serv);
+}
+
+static void test_xmsg(struct sock_addr_test *test)
+{
+	struct sockaddr_storage addr, src_addr;
+	socklen_t addr_len = sizeof(struct sockaddr_storage),
+		  src_addr_len = sizeof(struct sockaddr_storage);
+	struct msghdr hdr;
+	struct iovec iov;
+	char data = 'a';
+	int serv = -1, client = -1, err;
+
+	/* Unlike the other tests, here we test that we can rewrite the src addr
+	 * with a recvmsg() hook.
+	 */
+
+	serv = start_server(test->socket_family, test->socket_type,
+			    test->expected_addr, test->expected_port, 0);
+	if (!ASSERT_GE(serv, 0, "start_server"))
+		goto cleanup;
+
+	client = socket(test->socket_family, test->socket_type, 0);
+	if (!ASSERT_GE(client, 0, "socket"))
+		goto cleanup;
+
+	/* AF_UNIX sockets have to be bound to something to trigger the recvmsg bpf program. */
+	if (test->socket_family == AF_UNIX) {
+		err = make_sockaddr(AF_UNIX, SRCUN_ADDRESS, 0, &src_addr, &src_addr_len);
+		if (!ASSERT_EQ(err, 0, "make_sockaddr"))
+			goto cleanup;
+
+		err = bind(client, (const struct sockaddr *) &src_addr, src_addr_len);
+		if (!ASSERT_OK(err, "bind"))
+			goto cleanup;
+	}
+
+	err = make_sockaddr(test->socket_family, test->requested_addr, test->requested_port,
+			    &addr, &addr_len);
+	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
+		goto cleanup;
+
+	memset(&iov, 0, sizeof(iov));
+	iov.iov_base = &data;
+	iov.iov_len = sizeof(data);
+
+	memset(&hdr, 0, sizeof(hdr));
+	hdr.msg_name = (void *)&addr;
+	hdr.msg_namelen = addr_len;
+	hdr.msg_iov = &iov;
+	hdr.msg_iovlen = 1;
+
+	err = sendmsg(client, &hdr, 0);
+	if (!ASSERT_EQ(err, sizeof(data), "sendto"))
+		goto cleanup;
+
+	addr_len = src_addr_len = sizeof(struct sockaddr_storage);
+
+	err = recvfrom(serv, &data, sizeof(data), 0, (struct sockaddr *) &src_addr, &src_addr_len);
+	if (!ASSERT_EQ(err, sizeof(data), "recvfrom"))
+		goto cleanup;
+
+	ASSERT_EQ(data, 'a', "data mismatch");
+
+	if (test->expected_src_addr) {
+		err = make_sockaddr(test->socket_family, test->expected_src_addr, 0,
+				    &addr, &addr_len);
+		if (!ASSERT_EQ(err, 0, "make_sockaddr"))
+			goto cleanup;
+
+		err = cmp_addr(&src_addr, src_addr_len, &addr, addr_len, false);
+		if (!ASSERT_EQ(err, 0, "cmp_addr"))
+			goto cleanup;
+	}
+
+cleanup:
+	if (client != -1)
+		close(client);
+	if (serv != -1)
+		close(serv);
+}
+
+void test_sock_addr(void)
+{
+	int cgroup_fd = -1;
+	void *skel;
+
+	cgroup_fd = test__join_cgroup("/sock_addr");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		goto cleanup;
+
+	for (size_t i = 0; i < ARRAY_SIZE(tests); ++i) {
+		struct sock_addr_test *test = &tests[i];
+
+		if (!test__start_subtest(test->name))
+			continue;
+
+		skel = test->loadfn(cgroup_fd);
+		if (!skel)
+			continue;
+
+		switch (test->type) {
+		case SOCK_ADDR_TEST_BIND:
+			test_bind(test);
+			break;
+		case SOCK_ADDR_TEST_CONNECT:
+			test_connect(test);
+			break;
+		case SOCK_ADDR_TEST_SENDMSG:
+		case SOCK_ADDR_TEST_RECVMSG:
+			test_xmsg(test);
+			break;
+		default:
+			ASSERT_TRUE(false, "Unknown sock addr test type");
+			break;
+		}
+
+		test->destroyfn(skel);
+	}
+
+cleanup:
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/bindun_prog.c b/tools/testing/selftests/bpf/progs/bindun_prog.c
new file mode 100644
index 000000000000..c7bc93d5a904
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bindun_prog.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+
+#include <string.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_kfuncs.h"
+
+__u8 SERVUN_REWRITE_ADDRESS[] = "\0bpf_cgroup_unix_test_rewrite";
+
+SEC("cgroup/bindun")
+int bindun_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock_addr_kern *sa_kern = bpf_cast_to_kern_ctx(ctx);
+	struct sockaddr_un *sa_kern_unaddr;
+	__u32 unaddrlen = offsetof(struct sockaddr_un, sun_path) +
+			  sizeof(SERVUN_REWRITE_ADDRESS) - 1;
+	int ret;
+
+	ret = bpf_sock_addr_set_unix_addr(sa_kern, SERVUN_REWRITE_ADDRESS,
+					  sizeof(SERVUN_REWRITE_ADDRESS) - 1);
+	if (ret)
+		return 0;
+
+	if (sa_kern->uaddrlen != unaddrlen)
+		return 0;
+
+	sa_kern_unaddr = bpf_rdonly_cast(sa_kern->uaddr,
+						bpf_core_type_id_kernel(struct sockaddr_un));
+	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
+			sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
+		return 0;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/connectun_prog.c b/tools/testing/selftests/bpf/progs/connectun_prog.c
new file mode 100644
index 000000000000..8ab5b5d1fc3b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/connectun_prog.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+
+#include <string.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_kfuncs.h"
+
+__u8 SERVUN_REWRITE_ADDRESS[] = "\0bpf_cgroup_unix_test_rewrite";
+
+SEC("cgroup/connectun")
+int connectun_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock_addr_kern *sa_kern = bpf_cast_to_kern_ctx(ctx);
+	struct sockaddr_un *sa_kern_unaddr;
+	__u32 unaddrlen = offsetof(struct sockaddr_un, sun_path) +
+			  sizeof(SERVUN_REWRITE_ADDRESS) - 1;
+	int ret;
+
+	/* Rewrite destination. */
+	ret = bpf_sock_addr_set_unix_addr(sa_kern, SERVUN_REWRITE_ADDRESS,
+					  sizeof(SERVUN_REWRITE_ADDRESS) - 1);
+	if (ret)
+		return 0;
+
+	if (sa_kern->uaddrlen != unaddrlen)
+		return 0;
+
+	sa_kern_unaddr = bpf_rdonly_cast(sa_kern->uaddr,
+						bpf_core_type_id_kernel(struct sockaddr_un));
+	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
+			sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
+		return 0;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/recvmsgun_prog.c b/tools/testing/selftests/bpf/progs/recvmsgun_prog.c
new file mode 100644
index 000000000000..2baeaebac57e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/recvmsgun_prog.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+
+#include <string.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_kfuncs.h"
+
+__u8 SERVUN_ADDRESS[] = "\0bpf_cgroup_unix_test";
+
+SEC("cgroup/recvmsgun")
+int recvmsgun_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock_addr_kern *sa_kern = bpf_cast_to_kern_ctx(ctx);
+	struct sockaddr_un *sa_kern_unaddr;
+	__u32 unaddrlen = offsetof(struct sockaddr_un, sun_path) +
+			  sizeof(SERVUN_ADDRESS) - 1;
+	int ret;
+
+	ret = bpf_sock_addr_set_unix_addr(sa_kern, SERVUN_ADDRESS,
+					  sizeof(SERVUN_ADDRESS) - 1);
+	if (ret)
+		return 1;
+
+	if (sa_kern->uaddrlen != unaddrlen)
+		return 1;
+
+	sa_kern_unaddr = bpf_rdonly_cast(sa_kern->uaddr,
+						bpf_core_type_id_kernel(struct sockaddr_un));
+	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_ADDRESS,
+			sizeof(SERVUN_ADDRESS) - 1) != 0)
+		return 1;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/sendmsgun_prog.c b/tools/testing/selftests/bpf/progs/sendmsgun_prog.c
new file mode 100644
index 000000000000..23f2135c6eb0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sendmsgun_prog.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+
+#include <string.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_kfuncs.h"
+
+__u8 SERVUN_REWRITE_ADDRESS[] = "\0bpf_cgroup_unix_test_rewrite";
+
+SEC("cgroup/sendmsgun")
+int sendmsgun_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock_addr_kern *sa_kern = bpf_cast_to_kern_ctx(ctx);
+	struct sockaddr_un *sa_kern_unaddr;
+	__u32 unaddrlen = offsetof(struct sockaddr_un, sun_path) +
+			  sizeof(SERVUN_REWRITE_ADDRESS) - 1;
+	int ret;
+
+	/* Rewrite destination. */
+	ret = bpf_sock_addr_set_unix_addr(sa_kern, SERVUN_REWRITE_ADDRESS,
+					  sizeof(SERVUN_REWRITE_ADDRESS) - 1);
+	if (ret)
+		return 0;
+
+	if (sa_kern->uaddrlen != unaddrlen)
+		return 0;
+
+	sa_kern_unaddr = bpf_rdonly_cast(sa_kern->uaddr,
+						bpf_core_type_id_kernel(struct sockaddr_un));
+	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
+			sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
+		return 0;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.41.0


