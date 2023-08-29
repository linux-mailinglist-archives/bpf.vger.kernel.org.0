Return-Path: <bpf+bounces-8906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAF578C244
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 12:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8311C209AE
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 10:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8632F154A8;
	Tue, 29 Aug 2023 10:19:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EB414F88
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 10:19:32 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE0A1AE
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 03:19:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52a3ec08d93so5532478a12.2
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 03:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693304361; x=1693909161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PS0P2ePJao6FGEo5RBojMnEFLIH75anCWsaXNnUs73U=;
        b=nmDtUq268ryice0/RxnkY+G2+6AgfN0kEmLxxAxKZB/5mA3sptzro5YY9Bz4S6iepI
         uPQuPlXzbfEYZ4qGmVYcm4GozrKXlI5gpYLdjrxxB0FGVofxnXwOuICpoCJzIzctPqsb
         fmXAtnxD8wUext2evnJtiWbfvb5qkuSXa5cTugkvARjBM1UUiUm6DMSndGNmo8i0gC8X
         LLnrJX1UFeLHcAy0AIy9QAK7iVcPbBJ9v9gziJ33w60NMU5f3SnBVDMFq2zTdTvEJ60L
         rP/QUZp3L9H0HXbBC/aavmJyOhoIaOTjPKshHhpwIsLpIBk2/kIFmT14byKWGdYxBE8U
         5rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693304361; x=1693909161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PS0P2ePJao6FGEo5RBojMnEFLIH75anCWsaXNnUs73U=;
        b=KMdpSRe8wnhcsnm43/7l/J2ZZl+DBAJxLjH+qbJy1L8zsxErn/Ncq7pBpL4whB7PPf
         mEOtQc/q8k0NmL2DTd6AusUi5hUwdYxi/SjkzdAO5La1xexhqETzuPz/P856rIIUqZgz
         jc7TkjzndRQklJZwqyGXMj4PxlsDAhU1BY7SM3sqHRTYdpL0X9q6+Rsgcnj9hhs22bKr
         lZPMuP2om+dGbjH0VrkhJg11hZaT7jEP0V8ZZIfXgXX4nsM4w8Z17wUgIkeAEY+vBiIb
         lgW6mGM9n/49o5fxy/kChYxgnVxmCVZsDFHigHFqHkcy6LveJ1QWWUmZ9SiysdSUkkgp
         LmZA==
X-Gm-Message-State: AOJu0Ywf5I+G7FcXtIebR9QktER9VlCXb0Hp5ScySDW3FXyG1MIlJxAG
	pbKcxMpTepJcHssXMuTRhNe79IAguQ+/+i3dpII=
X-Google-Smtp-Source: AGHT+IG5S9nHKd413ymXyJh6dDxYA6AcavX4vim1PVw0ki97UQuSaWAt+bfgQv9dTRDk9IgEb3FZzA==
X-Received: by 2002:a50:e712:0:b0:523:7192:6803 with SMTP id a18-20020a50e712000000b0052371926803mr19954756edn.8.1693304361335;
        Tue, 29 Aug 2023 03:19:21 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-67a4-023c-67c4-b186.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:67a4:23c:67c4:b186])
        by smtp.googlemail.com with ESMTPSA id f15-20020a50ee8f000000b0051e2670d599sm5545606edr.4.2023.08.29.03.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 03:19:20 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 9/9] selftests/bpf: Add tests for cgroup unix socket address hooks
Date: Tue, 29 Aug 2023 12:18:33 +0200
Message-ID: <20230829101838.851350-10-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
References: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
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
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  13 +
 tools/testing/selftests/bpf/network_helpers.c |  34 ++
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/section_names.c  |  30 ++
 .../selftests/bpf/prog_tests/sock_addr.c      | 313 ++++++++++++++++++
 .../testing/selftests/bpf/progs/bindun_prog.c |  25 ++
 .../selftests/bpf/progs/connectun_prog.c      |  26 ++
 .../selftests/bpf/progs/recvmsgun_prog.c      |  25 ++
 .../selftests/bpf/progs/sendmsgun_prog.c      |  26 ++
 9 files changed, 493 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_addr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bindun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/connectun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/recvmsgun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/sendmsgun_prog.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 642dda0e758a..e974cd9cf634 100644
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
@@ -41,4 +43,15 @@ extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym;
 extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym;
 extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dynptr *clone__init) __ksym;
 
+/* Description
+ *  Modify the address of a sockaddr.
+ * Returns__bpf_kfunc
+ *  -EINVAL if the address size is too big or too small or, 0 if the sockaddr
+ * was successfully modified.
+ */
+extern int bpf_sock_addr_set_addr(struct bpf_sock_addr_kern *sa_kern,
+				  const __u8 *addr, __u32 addrlen__sz) __ksym;
+
+void *bpf_cast_to_kern_ctx(void *) __ksym;
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
index 000000000000..82976dd61344
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -0,0 +1,313 @@
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
+#include <stdio.h>
+
+#define TEST_NS "sock_addr_netns"
+
+#define SERVUN_ADDRESS         "bpf_cgroup_unix_test"
+#define SERVUN_REWRITE_ADDRESS "bpf_cgroup_unix_test_rewrite"
+#define SRCUN_ADDRESS	       "bpf_cgroup_unix_test_src"
+#define SRCUN_REWRITE_ADDRESS  "bpf_cgroup_unix_test_src_rewrite"
+
+typedef int (*info_fn)(int, struct sockaddr *, socklen_t *);
+
+static int cmp_addr(const struct sockaddr_storage *addr1, socklen_t addr1_len,
+		    const struct sockaddr_storage *addr2, socklen_t addr2_len,
+		    int cmp_port)
+{
+	const struct sockaddr_in *four1, *four2;
+	const struct sockaddr_in6 *six1, *six2;
+	const struct sockaddr_un *un1, *un2;
+
+	fprintf(stderr, "un1: %i\n", addr1->ss_family);
+	fprintf(stderr, "un2: %i\n", addr2->ss_family);
+
+	if (addr1->ss_family != addr2->ss_family)
+		return -1;
+
+	fprintf(stderr, "un1: %i\n", addr1_len);
+	fprintf(stderr, "un2: %i\n", addr2_len);
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
+		fprintf(stderr, "un1: %s\n", un1->sun_path + 1);
+		fprintf(stderr, "un2: %s\n", un2->sun_path + 1);
+		return memcmp(un1, un2, addr1_len);
+	}
+
+	return -1;
+}
+
+static int cmp_sock_addr(info_fn fn, int sock1,
+			 const struct sockaddr_storage *addr2,
+			 socklen_t addr2_len, int cmp_port)
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
+			  socklen_t addr2_len)
+{
+	return cmp_sock_addr(getsockname, sock1, addr2, addr2_len,
+			     /*cmp_port*/ 1);
+}
+
+static int cmp_peer_addr(int sock1, const struct sockaddr_storage *addr2,
+			 socklen_t addr2_len)
+{
+	return cmp_sock_addr(getpeername, sock1, addr2, addr2_len,
+			     /*cmp_port*/ 1);
+}
+
+void test_bind(int cgroup_fd)
+{
+	struct bindun_prog *skel;
+	struct sockaddr_storage expected_addr;
+	socklen_t expected_addr_len = sizeof(struct sockaddr_storage);
+	int serv = -1, client = -1, err;
+
+	skel = bindun_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->links.bindun_prog = bpf_program__attach_cgroup(
+		skel->progs.bindun_prog, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.bindun_prog, "prog_attach"))
+		goto cleanup;
+
+	serv = start_server(AF_UNIX, SOCK_STREAM, SERVUN_ADDRESS, 0, 0);
+	if (!ASSERT_GE(serv, 0, "start_server"))
+		goto cleanup;
+
+	err = make_sockaddr(AF_UNIX, SERVUN_REWRITE_ADDRESS, 0, &expected_addr, &expected_addr_len);
+	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
+		goto cleanup;
+
+	err = cmp_local_addr(serv, &expected_addr, expected_addr_len);
+	if (!ASSERT_EQ(err, 0, "cmp_local_addr"))
+		goto cleanup;
+
+	/* Try to connect to server just in case */
+	client = connect_to_addr(&expected_addr, expected_addr_len, SOCK_STREAM);
+	if (!ASSERT_GE(client, 0, "connect_to_addr"))
+		goto cleanup;
+
+cleanup:
+	if (client != -1)
+		close(client);
+	if (serv != -1)
+		close(serv);
+	bindun_prog__destroy(skel);
+}
+
+void test_connect(int cgroup_fd)
+{
+	struct connectun_prog *skel;
+	struct sockaddr_storage addr, expected_addr;
+	socklen_t addr_len = sizeof(struct sockaddr_storage),
+		  expected_addr_len = sizeof(struct sockaddr_storage);
+	int serv = -1, client = -1, err;
+
+	skel = connectun_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->links.connectun_prog = bpf_program__attach_cgroup(
+		skel->progs.connectun_prog, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.connectun_prog, "prog_attach"))
+		goto cleanup;
+
+	serv = start_server(AF_UNIX, SOCK_STREAM, SERVUN_REWRITE_ADDRESS, 0, 0);
+	if (!ASSERT_GE(serv, 0, "start_server"))
+		goto cleanup;
+
+	err = make_sockaddr(AF_UNIX, SERVUN_ADDRESS, 0, &addr, &addr_len);
+	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
+		goto cleanup;
+
+	client = connect_to_addr(&addr, addr_len, SOCK_STREAM);
+	if (!ASSERT_GE(client, 0, "connect_to_addr"))
+		goto cleanup;
+
+	err = make_sockaddr(AF_UNIX, SERVUN_REWRITE_ADDRESS, 0, &expected_addr, &expected_addr_len);
+	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
+		goto cleanup;
+
+	err = cmp_peer_addr(client, &expected_addr, expected_addr_len);
+	if (!ASSERT_EQ(err, 0, "cmp_peer_addr"))
+		goto cleanup;
+
+cleanup:
+	if (client != -1)
+		close(client);
+	if (serv != -1)
+		close(serv);
+	connectun_prog__destroy(skel);
+}
+
+void test_sendmsg(int cgroup_fd)
+{
+	struct sendmsgun_prog *skel;
+	struct sockaddr_storage addr;
+	socklen_t addr_len = sizeof(struct sockaddr_storage);
+	char data = 'a';
+	int serv = -1, client = -1, err;
+
+	skel = sendmsgun_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->links.sendmsgun_prog = bpf_program__attach_cgroup(
+		skel->progs.sendmsgun_prog, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.sendmsgun_prog, "prog_attach"))
+		goto cleanup;
+
+	serv = start_server(AF_UNIX, SOCK_DGRAM, SERVUN_REWRITE_ADDRESS, 0, 0);
+	if (!ASSERT_GE(serv, 0, "start_server"))
+		goto cleanup;
+
+	client = socket(AF_UNIX, SOCK_DGRAM, 0);
+	if (!ASSERT_GE(client, 0, "socket"))
+		goto cleanup;
+
+	err = make_sockaddr(AF_UNIX, SERVUN_ADDRESS, 0, &addr, &addr_len);
+	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
+		goto cleanup;
+
+	err = sendto(client, &data, sizeof(data), 0, (const struct sockaddr *) &addr, addr_len);
+	if (!ASSERT_EQ(err, sizeof(data), "sendto"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(recv(serv, &data, sizeof(data), 0), sizeof(data), "recv"))
+		goto cleanup;
+
+	ASSERT_EQ(data, 'a', "data mismatch");
+
+cleanup:
+	if (client != -1)
+		close(client);
+	if (serv != -1)
+		close(serv);
+	sendmsgun_prog__destroy(skel);
+}
+
+void test_recvmsg(int cgroup_fd)
+{
+	struct recvmsgun_prog *skel;
+	struct sockaddr_storage addr, src_addr;
+	socklen_t addr_len = sizeof(struct sockaddr_storage),
+		  src_addr_len = sizeof(struct sockaddr_storage);
+	char data = 'a';
+	int serv = -1, client = -1, err;
+
+	/* Unlike the other tests, here we test that we can rewrite the src addr
+	 * with a recvmsg() hook.
+	 */
+
+	skel = recvmsgun_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->links.recvmsgun_prog = bpf_program__attach_cgroup(
+		skel->progs.recvmsgun_prog, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.recvmsgun_prog, "prog_attach"))
+		goto cleanup;
+
+	serv = start_server(AF_UNIX, SOCK_DGRAM, SERVUN_ADDRESS, 0, 0);
+	if (!ASSERT_GE(serv, 0, "start_server"))
+		goto cleanup;
+
+	client = socket(AF_UNIX, SOCK_DGRAM, 0);
+	if (!ASSERT_GE(client, 0, "socket"))
+		goto cleanup;
+
+	err = make_sockaddr(AF_UNIX, SRCUN_ADDRESS, 0, &src_addr, &src_addr_len);
+	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bind(client, (const struct sockaddr *) &src_addr, src_addr_len), 0, "bind"))
+		goto cleanup;
+
+	err = make_sockaddr(AF_UNIX, SERVUN_ADDRESS, 0, &addr, &addr_len);
+	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
+		goto cleanup;
+
+	err = sendto(client, &data, sizeof(data), 0, (const struct sockaddr *) &addr, addr_len);
+	if (!ASSERT_EQ(err, sizeof(data), "sendto"))
+		goto cleanup;
+
+	addr_len = src_addr_len = sizeof(struct sockaddr_storage);
+
+	err = recvfrom(serv, &data, sizeof(data), 0, (struct sockaddr *) &addr, &addr_len);
+	if (!ASSERT_EQ(err, sizeof(data), "recvfrom"))
+		goto cleanup;
+
+	ASSERT_EQ(data, 'a', "data mismatch");
+
+	err = make_sockaddr(AF_UNIX, SRCUN_REWRITE_ADDRESS, 0, &src_addr, &src_addr_len);
+	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(cmp_addr(&addr, addr_len, &src_addr, src_addr_len, 0), 0, "cmp_addr"))
+		goto cleanup;
+
+cleanup:
+	if (client != -1)
+		close(client);
+	if (serv != -1)
+		close(serv);
+	recvmsgun_prog__destroy(skel);
+}
+
+void test_sock_addr(void)
+{
+	int cgroup_fd = -1;
+
+	cgroup_fd = test__join_cgroup("/sock_addr");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		goto cleanup;
+
+	if (test__start_subtest("bind"))
+		test_bind(cgroup_fd);
+	if (test__start_subtest("connect"))
+		test_connect(cgroup_fd);
+	if (test__start_subtest("sendmsg"))
+		test_sendmsg(cgroup_fd);
+	if (test__start_subtest("recvmsg"))
+		test_recvmsg(cgroup_fd);
+
+cleanup:
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/bindun_prog.c b/tools/testing/selftests/bpf/progs/bindun_prog.c
new file mode 100644
index 000000000000..e5e19c41f02d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bindun_prog.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include "bpf_kfuncs.h"
+
+__u8 SERVUN_REWRITE_ADDRESS[] = "\0bpf_cgroup_unix_test_rewrite";
+
+SEC("cgroup/bindun")
+int bindun_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock_addr_kern *sa_kern = bpf_cast_to_kern_ctx(ctx);
+	int ret;
+
+	ret = bpf_sock_addr_set_addr(sa_kern, SERVUN_REWRITE_ADDRESS,
+				     sizeof(SERVUN_REWRITE_ADDRESS) - 1);
+	if (ret)
+		return 0;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/connectun_prog.c b/tools/testing/selftests/bpf/progs/connectun_prog.c
new file mode 100644
index 000000000000..33cb6e4698e9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/connectun_prog.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include "bpf_kfuncs.h"
+
+__u8 SERVUN_REWRITE_ADDRESS[] = "\0bpf_cgroup_unix_test_rewrite";
+
+SEC("cgroup/connectun")
+int connectun_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock_addr_kern *sa_kern = bpf_cast_to_kern_ctx(ctx);
+	int ret;
+
+	/* Rewrite destination. */
+	ret = bpf_sock_addr_set_addr(sa_kern, SERVUN_REWRITE_ADDRESS,
+				     sizeof(SERVUN_REWRITE_ADDRESS) - 1);
+	if (ret)
+		return 0;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/recvmsgun_prog.c b/tools/testing/selftests/bpf/progs/recvmsgun_prog.c
new file mode 100644
index 000000000000..a53eb082c604
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/recvmsgun_prog.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include "bpf_kfuncs.h"
+
+__u8 SRCUN_REWRITE_ADDRESS[] = "\0bpf_cgroup_unix_test_src_rewrite";
+
+SEC("cgroup/recvmsgun")
+int recvmsgun_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock_addr_kern *sa_kern = bpf_cast_to_kern_ctx(ctx);
+	int ret;
+
+	ret = bpf_sock_addr_set_addr(sa_kern, SRCUN_REWRITE_ADDRESS,
+				     sizeof(SRCUN_REWRITE_ADDRESS) - 1);
+	if (ret)
+		return 1;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/sendmsgun_prog.c b/tools/testing/selftests/bpf/progs/sendmsgun_prog.c
new file mode 100644
index 000000000000..b78932e3d57b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sendmsgun_prog.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include "bpf_kfuncs.h"
+
+__u8 SERVUN_REWRITE_ADDRESS[] = "\0bpf_cgroup_unix_test_rewrite";
+
+SEC("cgroup/sendmsgun")
+int sendmsgun_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock_addr_kern *sa_kern = bpf_cast_to_kern_ctx(ctx);
+	int ret;
+
+	/* Rewrite destination. */
+	ret = bpf_sock_addr_set_addr(sa_kern, SERVUN_REWRITE_ADDRESS,
+				     sizeof(SERVUN_REWRITE_ADDRESS) - 1);
+	if (ret)
+		return 0;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.41.0


