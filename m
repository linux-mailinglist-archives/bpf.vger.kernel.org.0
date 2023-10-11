Return-Path: <bpf+bounces-11943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972407C59F1
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 19:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95321C2125B
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 17:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678E839952;
	Wed, 11 Oct 2023 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUazSWB2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A03D39934;
	Wed, 11 Oct 2023 17:03:46 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4825AF;
	Wed, 11 Oct 2023 10:03:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40572aeb673so1312375e9.0;
        Wed, 11 Oct 2023 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697043820; x=1697648620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cXvPUSQ/VR5Kk26X/tfgKll3nR/q3liVedy7TUkcl4=;
        b=IUazSWB2Crpka5A95zfCq6zDPus776jtw6cNvTTSMGpQOOE9I/N2ZrM4Pi7wSaI1zZ
         qP/eGpOpt8Xn6wZFajITiH4TIu/GrxqgcwXk/ovmDwr+WwjK2PBv1uy8cjemBa0hrvXH
         GfrHFxycC3PjFgeA4NS92MgGejbT7xCjMWezEXukM/nU92VCzItX55FlWHNCUwjZawSU
         Ql1IpofAZdswEaLzweZAglIZo5W+e+MRbHufjYWJLXGhnZ6bAbSY4exLcbXAXLGvAhze
         38Ta6QPrudZb20q3BZ4olli+z+wt7eIrFG8LpHCwDP69ceKh4SVqlT7cMJnszqXTsH8G
         qeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043820; x=1697648620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cXvPUSQ/VR5Kk26X/tfgKll3nR/q3liVedy7TUkcl4=;
        b=O1wwe6gcY20TK5oUaTxQ8laVIYpL5be7464xG/V9Vl19ExrSAoHHChWqjMouzf/UGb
         fANhjnUMU/X0el6BZrtNyoWmGk/NO6AwUKr2jn8ho0Z7mWKrQhU8oExh2O+CEtfdZvPB
         qSxf7ZeUp3C4oEaCHCxslUmPbeu2Kvq2W9hynMOhb2DUmB1u7WwTgqU9/MeB6lTn9FQ7
         c5IA0EUZ2N6T4NwhLKtUY7IF8SP1umT/A5p8Jjn2NOMJeNBISjYom4AFkrgwlWSj/S/E
         1DBLu530PRI1tgf67CP4FPdOCzEvPax7Zhu+fL5++yup3PFeFtgs0xTcfetJhWa9Dsar
         PAaw==
X-Gm-Message-State: AOJu0YxDE5UIo1iAMd8j0S6LumGOEHV9ZGSfurve041kSKShl06GdY4c
	A2kmInt9J6mx/4PfarChiLa+KZIfy8CdRUAu
X-Google-Smtp-Source: AGHT+IGwVYbqxjcLKFOIQruPblom9WjeYJYERM5fIRPwycUsahx7tIud8CFXadEaRlRN9DWIiVRa2w==
X-Received: by 2002:adf:e8cc:0:b0:322:da1f:60d9 with SMTP id k12-20020adfe8cc000000b00322da1f60d9mr20138729wrn.47.1697043819712;
        Wed, 11 Oct 2023 10:03:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id h28-20020adfa4dc000000b003296b913bbesm2335480wrb.12.2023.10.11.10.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:03:39 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v10 9/9] selftests/bpf: Add tests for cgroup unix socket address hooks
Date: Wed, 11 Oct 2023 19:03:19 +0200
Message-ID: <20231011170321.73950-11-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011170321.73950-1-daan.j.demeyer@gmail.com>
References: <20231011170321.73950-1-daan.j.demeyer@gmail.com>
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
sock addr tests to prog_tests style is left for future work. This
commit adds support for testing bind() sockaddr hooks, even though
there's no unix socket sockaddr hook for bind(). We leave this code
intact for when the INET and INET6 tests are migrated in the future
which do support intercepting bind().

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  14 +
 tools/testing/selftests/bpf/network_helpers.c |  34 +
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/section_names.c  |  25 +
 .../selftests/bpf/prog_tests/sock_addr.c      | 612 ++++++++++++++++++
 .../selftests/bpf/progs/connect_unix_prog.c   |  40 ++
 .../bpf/progs/getpeername_unix_prog.c         |  39 ++
 .../bpf/progs/getsockname_unix_prog.c         |  39 ++
 .../selftests/bpf/progs/recvmsg_unix_prog.c   |  39 ++
 .../selftests/bpf/progs/sendmsg_unix_prog.c   |  40 ++
 10 files changed, 883 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_addr.c
 create mode 100644 tools/testing/selftests/bpf/progs/connect_unix_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getpeername_unix_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getsockname_unix_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 642dda0e758a..5ca68ff0b59f 100644
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
+extern int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
+				      const __u8 *sun_path, __u32 sun_path__sz) __ksym;
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
index fc5248e94a01..c3d78846f31a 100644
--- a/tools/testing/selftests/bpf/prog_tests/section_names.c
+++ b/tools/testing/selftests/bpf/prog_tests/section_names.c
@@ -123,6 +123,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_CONNECT},
 		{0, BPF_CGROUP_INET6_CONNECT},
 	},
+	{
+		"cgroup/connect_unix",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_CONNECT},
+		{0, BPF_CGROUP_UNIX_CONNECT},
+	},
 	{
 		"cgroup/sendmsg4",
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_SENDMSG},
@@ -133,6 +138,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6_SENDMSG},
 		{0, BPF_CGROUP_UDP6_SENDMSG},
 	},
+	{
+		"cgroup/sendmsg_unix",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_SENDMSG},
+		{0, BPF_CGROUP_UNIX_SENDMSG},
+	},
 	{
 		"cgroup/recvmsg4",
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_RECVMSG},
@@ -143,6 +153,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6_RECVMSG},
 		{0, BPF_CGROUP_UDP6_RECVMSG},
 	},
+	{
+		"cgroup/recvmsg_unix",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_RECVMSG},
+		{0, BPF_CGROUP_UNIX_RECVMSG},
+	},
 	{
 		"cgroup/sysctl",
 		{0, BPF_PROG_TYPE_CGROUP_SYSCTL, BPF_CGROUP_SYSCTL},
@@ -168,6 +183,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETPEERNAME},
 		{0, BPF_CGROUP_INET6_GETPEERNAME},
 	},
+	{
+		"cgroup/getpeername_unix",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_GETPEERNAME},
+		{0, BPF_CGROUP_UNIX_GETPEERNAME},
+	},
 	{
 		"cgroup/getsockname4",
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETSOCKNAME},
@@ -178,6 +198,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETSOCKNAME},
 		{0, BPF_CGROUP_INET6_GETSOCKNAME},
 	},
+	{
+		"cgroup/getsockname_unix",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_UNIX_GETSOCKNAME},
+		{0, BPF_CGROUP_UNIX_GETSOCKNAME},
+	},
 };
 
 static void test_prog_type_by_name(const struct sec_name_test *test)
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
new file mode 100644
index 000000000000..5fd617718991
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -0,0 +1,612 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/un.h>
+
+#include "test_progs.h"
+
+#include "connect_unix_prog.skel.h"
+#include "sendmsg_unix_prog.skel.h"
+#include "recvmsg_unix_prog.skel.h"
+#include "getsockname_unix_prog.skel.h"
+#include "getpeername_unix_prog.skel.h"
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
+	SOCK_ADDR_TEST_GETSOCKNAME,
+	SOCK_ADDR_TEST_GETPEERNAME,
+};
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
+static void *connect_unix_prog_load(int cgroup_fd)
+{
+	struct connect_unix_prog *skel;
+
+	skel = connect_unix_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	skel->links.connect_unix_prog = bpf_program__attach_cgroup(
+		skel->progs.connect_unix_prog, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.connect_unix_prog, "prog_attach"))
+		goto cleanup;
+
+	return skel;
+cleanup:
+	connect_unix_prog__destroy(skel);
+	return NULL;
+}
+
+static void connect_unix_prog_destroy(void *skel)
+{
+	connect_unix_prog__destroy(skel);
+}
+
+static void *sendmsg_unix_prog_load(int cgroup_fd)
+{
+	struct sendmsg_unix_prog *skel;
+
+	skel = sendmsg_unix_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	skel->links.sendmsg_unix_prog = bpf_program__attach_cgroup(
+		skel->progs.sendmsg_unix_prog, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.sendmsg_unix_prog, "prog_attach"))
+		goto cleanup;
+
+	return skel;
+cleanup:
+	sendmsg_unix_prog__destroy(skel);
+	return NULL;
+}
+
+static void sendmsg_unix_prog_destroy(void *skel)
+{
+	sendmsg_unix_prog__destroy(skel);
+}
+
+static void *recvmsg_unix_prog_load(int cgroup_fd)
+{
+	struct recvmsg_unix_prog *skel;
+
+	skel = recvmsg_unix_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	skel->links.recvmsg_unix_prog = bpf_program__attach_cgroup(
+		skel->progs.recvmsg_unix_prog, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.recvmsg_unix_prog, "prog_attach"))
+		goto cleanup;
+
+	return skel;
+cleanup:
+	recvmsg_unix_prog__destroy(skel);
+	return NULL;
+}
+
+static void recvmsg_unix_prog_destroy(void *skel)
+{
+	recvmsg_unix_prog__destroy(skel);
+}
+
+static void *getsockname_unix_prog_load(int cgroup_fd)
+{
+	struct getsockname_unix_prog *skel;
+
+	skel = getsockname_unix_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	skel->links.getsockname_unix_prog = bpf_program__attach_cgroup(
+		skel->progs.getsockname_unix_prog, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.getsockname_unix_prog, "prog_attach"))
+		goto cleanup;
+
+	return skel;
+cleanup:
+	getsockname_unix_prog__destroy(skel);
+	return NULL;
+}
+
+static void getsockname_unix_prog_destroy(void *skel)
+{
+	getsockname_unix_prog__destroy(skel);
+}
+
+static void *getpeername_unix_prog_load(int cgroup_fd)
+{
+	struct getpeername_unix_prog *skel;
+
+	skel = getpeername_unix_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	skel->links.getpeername_unix_prog = bpf_program__attach_cgroup(
+		skel->progs.getpeername_unix_prog, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.getpeername_unix_prog, "prog_attach"))
+		goto cleanup;
+
+	return skel;
+cleanup:
+	getpeername_unix_prog__destroy(skel);
+	return NULL;
+}
+
+static void getpeername_unix_prog_destroy(void *skel)
+{
+	getpeername_unix_prog__destroy(skel);
+}
+
+static struct sock_addr_test tests[] = {
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect_unix",
+		connect_unix_prog_load,
+		connect_unix_prog_destroy,
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
+		"sendmsg_unix",
+		sendmsg_unix_prog_load,
+		sendmsg_unix_prog_destroy,
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
+		"recvmsg_unix-dgram",
+		recvmsg_unix_prog_load,
+		recvmsg_unix_prog_destroy,
+		AF_UNIX,
+		SOCK_DGRAM,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		SERVUN_ADDRESS,
+	},
+	{
+		SOCK_ADDR_TEST_RECVMSG,
+		"recvmsg_unix-stream",
+		recvmsg_unix_prog_load,
+		recvmsg_unix_prog_destroy,
+		AF_UNIX,
+		SOCK_STREAM,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		SERVUN_ADDRESS,
+	},
+	{
+		SOCK_ADDR_TEST_GETSOCKNAME,
+		"getsockname_unix",
+		getsockname_unix_prog_load,
+		getsockname_unix_prog_destroy,
+		AF_UNIX,
+		SOCK_STREAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+	},
+	{
+		SOCK_ADDR_TEST_GETPEERNAME,
+		"getpeername_unix",
+		getpeername_unix_prog_load,
+		getpeername_unix_prog_destroy,
+		AF_UNIX,
+		SOCK_STREAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
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
+	if (test->socket_type == SOCK_DGRAM) {
+		memset(&iov, 0, sizeof(iov));
+		iov.iov_base = &data;
+		iov.iov_len = sizeof(data);
+
+		memset(&hdr, 0, sizeof(hdr));
+		hdr.msg_name = (void *)&addr;
+		hdr.msg_namelen = addr_len;
+		hdr.msg_iov = &iov;
+		hdr.msg_iovlen = 1;
+
+		err = sendmsg(client, &hdr, 0);
+		if (!ASSERT_EQ(err, sizeof(data), "sendmsg"))
+			goto cleanup;
+	} else {
+		/* Testing with connection-oriented sockets is only valid for
+		 * recvmsg() tests.
+		 */
+		if (!ASSERT_EQ(test->type, SOCK_ADDR_TEST_RECVMSG, "recvmsg"))
+			goto cleanup;
+
+		err = connect(client, (const struct sockaddr *)&addr, addr_len);
+		if (!ASSERT_OK(err, "connect"))
+			goto cleanup;
+
+		err = send(client, &data, sizeof(data), 0);
+		if (!ASSERT_EQ(err, sizeof(data), "send"))
+			goto cleanup;
+
+		err = listen(serv, 0);
+		if (!ASSERT_OK(err, "listen"))
+			goto cleanup;
+
+		err = accept(serv, NULL, NULL);
+		if (!ASSERT_GE(err, 0, "accept"))
+			goto cleanup;
+
+		close(serv);
+		serv = err;
+	}
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
+static void test_getsockname(struct sock_addr_test *test)
+{
+	struct sockaddr_storage expected_addr;
+	socklen_t expected_addr_len = sizeof(struct sockaddr_storage);
+	int serv = -1, err;
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
+cleanup:
+	if (serv != -1)
+		close(serv);
+}
+
+static void test_getpeername(struct sock_addr_test *test)
+{
+	struct sockaddr_storage addr, expected_addr;
+	socklen_t addr_len = sizeof(struct sockaddr_storage),
+		  expected_addr_len = sizeof(struct sockaddr_storage);
+	int serv = -1, client = -1, err;
+
+	serv = start_server(test->socket_family, test->socket_type,
+			    test->requested_addr, test->requested_port, 0);
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
+	err = cmp_peer_addr(client, &expected_addr, expected_addr_len, true);
+	if (!ASSERT_EQ(err, 0, "cmp_peer_addr"))
+		goto cleanup;
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
+		/* Not exercised yet but we leave this code here for when the
+		 * INET and INET6 sockaddr tests are migrated to this file in
+		 * the future.
+		 */
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
+		case SOCK_ADDR_TEST_GETSOCKNAME:
+			test_getsockname(test);
+			break;
+		case SOCK_ADDR_TEST_GETPEERNAME:
+			test_getpeername(test);
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
diff --git a/tools/testing/selftests/bpf/progs/connect_unix_prog.c b/tools/testing/selftests/bpf/progs/connect_unix_prog.c
new file mode 100644
index 000000000000..cdcaeca90c0d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/connect_unix_prog.c
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
+SEC("cgroup/connect_unix")
+int connect_unix_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock_addr_kern *sa_kern = bpf_cast_to_kern_ctx(ctx);
+	struct sockaddr_un *sa_kern_unaddr;
+	__u32 unaddrlen = offsetof(struct sockaddr_un, sun_path) +
+			  sizeof(SERVUN_REWRITE_ADDRESS) - 1;
+	int ret;
+
+	/* Rewrite destination. */
+	ret = bpf_sock_addr_set_sun_path(sa_kern, SERVUN_REWRITE_ADDRESS,
+					 sizeof(SERVUN_REWRITE_ADDRESS) - 1);
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
diff --git a/tools/testing/selftests/bpf/progs/getpeername_unix_prog.c b/tools/testing/selftests/bpf/progs/getpeername_unix_prog.c
new file mode 100644
index 000000000000..696a63f6046f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/getpeername_unix_prog.c
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
+SEC("cgroup/getpeername_unix")
+int getpeername_unix_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock_addr_kern *sa_kern = bpf_cast_to_kern_ctx(ctx);
+	struct sockaddr_un *sa_kern_unaddr;
+	__u32 unaddrlen = offsetof(struct sockaddr_un, sun_path) +
+			  sizeof(SERVUN_REWRITE_ADDRESS) - 1;
+	int ret;
+
+	ret = bpf_sock_addr_set_sun_path(sa_kern, SERVUN_REWRITE_ADDRESS,
+					 sizeof(SERVUN_REWRITE_ADDRESS) - 1);
+	if (ret)
+		return 1;
+
+	if (sa_kern->uaddrlen != unaddrlen)
+		return 1;
+
+	sa_kern_unaddr = bpf_rdonly_cast(sa_kern->uaddr,
+						bpf_core_type_id_kernel(struct sockaddr_un));
+	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
+			sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
+		return 1;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/getsockname_unix_prog.c b/tools/testing/selftests/bpf/progs/getsockname_unix_prog.c
new file mode 100644
index 000000000000..087670e1f623
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/getsockname_unix_prog.c
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
+SEC("cgroup/getsockname_unix")
+int getsockname_unix_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock_addr_kern *sa_kern = bpf_cast_to_kern_ctx(ctx);
+	struct sockaddr_un *sa_kern_unaddr;
+	__u32 unaddrlen = offsetof(struct sockaddr_un, sun_path) +
+			  sizeof(SERVUN_REWRITE_ADDRESS) - 1;
+	int ret;
+
+	ret = bpf_sock_addr_set_sun_path(sa_kern, SERVUN_REWRITE_ADDRESS,
+					 sizeof(SERVUN_REWRITE_ADDRESS) - 1);
+	if (ret)
+		return 1;
+
+	if (sa_kern->uaddrlen != unaddrlen)
+		return 1;
+
+	sa_kern_unaddr = bpf_rdonly_cast(sa_kern->uaddr,
+						bpf_core_type_id_kernel(struct sockaddr_un));
+	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
+			sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
+		return 1;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c b/tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c
new file mode 100644
index 000000000000..38d7a0a42ec0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c
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
+SEC("cgroup/recvmsg_unix")
+int recvmsg_unix_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock_addr_kern *sa_kern = bpf_cast_to_kern_ctx(ctx);
+	struct sockaddr_un *sa_kern_unaddr;
+	__u32 unaddrlen = offsetof(struct sockaddr_un, sun_path) +
+			  sizeof(SERVUN_ADDRESS) - 1;
+	int ret;
+
+	ret = bpf_sock_addr_set_sun_path(sa_kern, SERVUN_ADDRESS,
+					 sizeof(SERVUN_ADDRESS) - 1);
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
diff --git a/tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c b/tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c
new file mode 100644
index 000000000000..e7362b7803cd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c
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
+SEC("cgroup/sendmsg_unix")
+int sendmsg_unix_prog(struct bpf_sock_addr *ctx)
+{
+	struct bpf_sock_addr_kern *sa_kern = bpf_cast_to_kern_ctx(ctx);
+	struct sockaddr_un *sa_kern_unaddr;
+	__u32 unaddrlen = offsetof(struct sockaddr_un, sun_path) +
+			  sizeof(SERVUN_REWRITE_ADDRESS) - 1;
+	int ret;
+
+	/* Rewrite destination. */
+	ret = bpf_sock_addr_set_sun_path(sa_kern, SERVUN_REWRITE_ADDRESS,
+					 sizeof(SERVUN_REWRITE_ADDRESS) - 1);
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


