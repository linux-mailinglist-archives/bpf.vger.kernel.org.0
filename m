Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090DF1C9A93
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 21:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgEGTM1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 15:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727826AbgEGTMZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 15:12:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09733C05BD43
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 12:12:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x13so8146765ybg.23
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 12:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=z8xXvRgmfzMrOeYAEEE+2l0lBUZXZ9yqcWvnRcj8fIg=;
        b=i3L9ZnFhA4l0carKdjjtPLUDimtHSuOF9Uq3XDjqAUA2Kfa9zZIq6VWc1HK5scPfte
         MNilJYE5b5nsn9kyb2wtWVeX1x1BWgA8NlomGdXwfRnrwPL1Mb5f+hPZIflfKhxdmT8+
         /1/i0niFW/szlAClVeK5BAisCTgQgLI2rmF6Bi5v+Vg1RPO3ZqUTpXArJ/9GwgVy/Yox
         n4Z4/ik1yepsU1F+qtRgfIsL5Hrcj4d6Wzul4rNYXm/BLAVbzukc7Ck9KsuEzsi405ik
         1ZU5nwd1GnaMGu3QwJQrHDJeIaVIkDRRs/GfLjKo80qf0bWcR1F6+tk74fKxuxXvBMyQ
         5Pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=z8xXvRgmfzMrOeYAEEE+2l0lBUZXZ9yqcWvnRcj8fIg=;
        b=ABIzXs79/crHCvIDAyR4wn2RzbCefvjGPS9Fed8uK6qK7jRohUpGM0RhMAfI4NgIjI
         tv/MhcTjrKsTMZzyCtm5IH2eW03xwGSPjcpxZGnD/8GVQYPFqkHKBgLyHkT6wckRzU4e
         EPgxrzrdgo1BoMimM8ZGT7eDuCBqL27s//qyOINIsC6Lukw5qIEX2HP4nR1oW1UBxWGX
         kJFUexGlbhZCJjVluU5YPbd9T75GccXqG/pj06IfPl/y1fE9YwQ0FwUUaBDnvrEVvECA
         sQHOPuAFeuTqZBrkIHUKaaDsXbNL1KOYZH+dHmN4bCJG2X6dxZgpfkG+w18xrOx2rnLE
         5Opw==
X-Gm-Message-State: AGi0PuYKZ1NoyM3VASlkKLsu8AYcukC1RBb5jHx0egfFcfEBYBWcLge1
        VYl6Z9an9FzeH4bvP6rNeSMI5Ts=
X-Google-Smtp-Source: APiQypIC6xaDlc0AcWFTHvucHEYL+GZRGkgpXxvJTRyqmlpoqRlXHtg806HTa0AWvlwLzZgXxO8B5Kw=
X-Received: by 2002:a25:37c8:: with SMTP id e191mr1757699yba.388.1588878744227;
 Thu, 07 May 2020 12:12:24 -0700 (PDT)
Date:   Thu,  7 May 2020 12:12:15 -0700
In-Reply-To: <20200507191215.248860-1-sdf@google.com>
Message-Id: <20200507191215.248860-5-sdf@google.com>
Mime-Version: 1.0
References: <20200507191215.248860-1-sdf@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH bpf-next v4 4/4] bpf: allow any port in bpf_bind helper
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrey Ignatov <rdna@fb.com>, Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We want to have a tighter control on what ports we bind to in
the BPF_CGROUP_INET{4,6}_CONNECT hooks even if it means
connect() becomes slightly more expensive. The expensive part
comes from the fact that we now need to call inet_csk_get_port()
that verifies that the port is not used and allocates an entry
in the hash table for it.

Since we can't rely on "snum || !bind_address_no_port" to prevent
us from calling POST_BIND hook anymore, let's add another bind flag
to indicate that the call site is BPF program.

v3:
* More bpf_bind documentation refinements (Martin KaFai Lau)
* Add UDP tests as well (Martin KaFai Lau)
* Don't start the thread, just do socket+bind+listen (Martin KaFai Lau)

v2:
* Update documentation (Andrey Ignatov)
* Pass BIND_FORCE_ADDRESS_NO_PORT conditionally (Andrey Ignatov)

Cc: Andrey Ignatov <rdna@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/net/inet_common.h                     |   2 +
 include/uapi/linux/bpf.h                      |   9 +-
 net/core/filter.c                             |  18 ++-
 net/ipv4/af_inet.c                            |  10 +-
 net/ipv6/af_inet6.c                           |  12 +-
 tools/include/uapi/linux/bpf.h                |   9 +-
 .../bpf/prog_tests/connect_force_port.c       | 115 ++++++++++++++++++
 .../selftests/bpf/progs/connect_force_port4.c |  28 +++++
 .../selftests/bpf/progs/connect_force_port6.c |  28 +++++
 9 files changed, 203 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/connect_force_port.c
 create mode 100644 tools/testing/selftests/bpf/progs/connect_force_port4.c
 create mode 100644 tools/testing/selftests/bpf/progs/connect_force_port6.c

diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index c38f4f7d660a..cb2818862919 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -39,6 +39,8 @@ int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len);
 #define BIND_FORCE_ADDRESS_NO_PORT	(1 << 0)
 /* Grab and release socket lock. */
 #define BIND_WITH_LOCK			(1 << 1)
+/* Called from BPF program. */
+#define BIND_FROM_BPF			(1 << 2)
 int __inet_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 		u32 flags);
 int inet_getname(struct socket *sock, struct sockaddr *uaddr,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b3643e27e264..6e5e7caa3739 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1994,10 +1994,11 @@ union bpf_attr {
  *
  * 		This helper works for IPv4 and IPv6, TCP and UDP sockets. The
  * 		domain (*addr*\ **->sa_family**) must be **AF_INET** (or
- * 		**AF_INET6**). Looking for a free port to bind to can be
- * 		expensive, therefore binding to port is not permitted by the
- * 		helper: *addr*\ **->sin_port** (or **sin6_port**, respectively)
- * 		must be set to zero.
+ * 		**AF_INET6**). It's advised to pass zero port (**sin_port**
+ * 		or **sin6_port**) which triggers IP_BIND_ADDRESS_NO_PORT-like
+ * 		behavior and lets the kernel efficiently pick up an unused
+ * 		port as long as 4-tuple is unique. Passing non-zero port might
+ * 		lead to degraded performance.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
  *
diff --git a/net/core/filter.c b/net/core/filter.c
index fa9ddab5dd1f..da0634979f53 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4525,32 +4525,28 @@ BPF_CALL_3(bpf_bind, struct bpf_sock_addr_kern *, ctx, struct sockaddr *, addr,
 {
 #ifdef CONFIG_INET
 	struct sock *sk = ctx->sk;
+	u32 flags = BIND_FROM_BPF;
 	int err;
 
-	/* Binding to port can be expensive so it's prohibited in the helper.
-	 * Only binding to IP is supported.
-	 */
 	err = -EINVAL;
 	if (addr_len < offsetofend(struct sockaddr, sa_family))
 		return err;
 	if (addr->sa_family == AF_INET) {
 		if (addr_len < sizeof(struct sockaddr_in))
 			return err;
-		if (((struct sockaddr_in *)addr)->sin_port != htons(0))
-			return err;
-		return __inet_bind(sk, addr, addr_len,
-				   BIND_FORCE_ADDRESS_NO_PORT);
+		if (((struct sockaddr_in *)addr)->sin_port == htons(0))
+			flags |= BIND_FORCE_ADDRESS_NO_PORT;
+		return __inet_bind(sk, addr, addr_len, flags);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (addr->sa_family == AF_INET6) {
 		if (addr_len < SIN6_LEN_RFC2133)
 			return err;
-		if (((struct sockaddr_in6 *)addr)->sin6_port != htons(0))
-			return err;
+		if (((struct sockaddr_in6 *)addr)->sin6_port == htons(0))
+			flags |= BIND_FORCE_ADDRESS_NO_PORT;
 		/* ipv6_bpf_stub cannot be NULL, since it's called from
 		 * bpf_cgroup_inet6_connect hook and ipv6 is already loaded
 		 */
-		return ipv6_bpf_stub->inet6_bind(sk, addr, addr_len,
-						 BIND_FORCE_ADDRESS_NO_PORT);
+		return ipv6_bpf_stub->inet6_bind(sk, addr, addr_len, flags);
 #endif /* CONFIG_IPV6 */
 	}
 #endif /* CONFIG_INET */
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 68e74b1b0f26..fcf0d12a407a 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -526,10 +526,12 @@ int __inet_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 			err = -EADDRINUSE;
 			goto out_release_sock;
 		}
-		err = BPF_CGROUP_RUN_PROG_INET4_POST_BIND(sk);
-		if (err) {
-			inet->inet_saddr = inet->inet_rcv_saddr = 0;
-			goto out_release_sock;
+		if (!(flags & BIND_FROM_BPF)) {
+			err = BPF_CGROUP_RUN_PROG_INET4_POST_BIND(sk);
+			if (err) {
+				inet->inet_saddr = inet->inet_rcv_saddr = 0;
+				goto out_release_sock;
+			}
 		}
 	}
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 552c2592b81c..771a462a8322 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -407,11 +407,13 @@ static int __inet6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 			err = -EADDRINUSE;
 			goto out;
 		}
-		err = BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk);
-		if (err) {
-			sk->sk_ipv6only = saved_ipv6only;
-			inet_reset_saddr(sk);
-			goto out;
+		if (!(flags & BIND_FROM_BPF)) {
+			err = BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk);
+			if (err) {
+				sk->sk_ipv6only = saved_ipv6only;
+				inet_reset_saddr(sk);
+				goto out;
+			}
 		}
 	}
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b3643e27e264..6e5e7caa3739 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1994,10 +1994,11 @@ union bpf_attr {
  *
  * 		This helper works for IPv4 and IPv6, TCP and UDP sockets. The
  * 		domain (*addr*\ **->sa_family**) must be **AF_INET** (or
- * 		**AF_INET6**). Looking for a free port to bind to can be
- * 		expensive, therefore binding to port is not permitted by the
- * 		helper: *addr*\ **->sin_port** (or **sin6_port**, respectively)
- * 		must be set to zero.
+ * 		**AF_INET6**). It's advised to pass zero port (**sin_port**
+ * 		or **sin6_port**) which triggers IP_BIND_ADDRESS_NO_PORT-like
+ * 		behavior and lets the kernel efficiently pick up an unused
+ * 		port as long as 4-tuple is unique. Passing non-zero port might
+ * 		lead to degraded performance.
  * 	Return
  * 		0 on success, or a negative error in case of failure.
  *
diff --git a/tools/testing/selftests/bpf/prog_tests/connect_force_port.c b/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
new file mode 100644
index 000000000000..47fbb20cb6a6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "network_helpers.h"
+
+static int verify_port(int family, int fd, int expected)
+{
+	struct sockaddr_storage addr;
+	socklen_t len = sizeof(addr);
+	__u16 port;
+
+	if (getsockname(fd, (struct sockaddr *)&addr, &len)) {
+		log_err("Failed to get server addr");
+		return -1;
+	}
+
+	if (family == AF_INET)
+		port = ((struct sockaddr_in *)&addr)->sin_port;
+	else
+		port = ((struct sockaddr_in6 *)&addr)->sin6_port;
+
+	if (ntohs(port) != expected) {
+		log_err("Unexpected port %d, expected %d", ntohs(port),
+			expected);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int run_test(int cgroup_fd, int server_fd, int family, int type)
+{
+	struct bpf_prog_load_attr attr = {
+		.prog_type = BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
+	};
+	struct bpf_object *obj;
+	int expected_port;
+	int prog_fd;
+	int err;
+	int fd;
+
+	if (family == AF_INET) {
+		attr.file = "./connect_force_port4.o";
+		attr.expected_attach_type = BPF_CGROUP_INET4_CONNECT;
+		expected_port = 22222;
+	} else {
+		attr.file = "./connect_force_port6.o";
+		attr.expected_attach_type = BPF_CGROUP_INET6_CONNECT;
+		expected_port = 22223;
+	}
+
+	err = bpf_prog_load_xattr(&attr, &obj, &prog_fd);
+	if (err) {
+		log_err("Failed to load BPF object");
+		return -1;
+	}
+
+	err = bpf_prog_attach(prog_fd, cgroup_fd, attr.expected_attach_type,
+			      0);
+	if (err) {
+		log_err("Failed to attach BPF program");
+		goto close_bpf_object;
+	}
+
+	fd = connect_to_fd(family, type, server_fd);
+	if (fd < 0) {
+		err = -1;
+		goto close_bpf_object;
+	}
+
+	err = verify_port(family, fd, expected_port);
+
+	close(fd);
+
+close_bpf_object:
+	bpf_object__close(obj);
+	return err;
+}
+
+void test_connect_force_port(void)
+{
+	int server_fd, cgroup_fd;
+
+	cgroup_fd = test__join_cgroup("/connect_force_port");
+	if (CHECK_FAIL(cgroup_fd < 0))
+		return;
+
+	server_fd = start_server(AF_INET, SOCK_STREAM);
+	if (CHECK_FAIL(server_fd < 0))
+		goto close_cgroup_fd;
+	CHECK_FAIL(run_test(cgroup_fd, server_fd, AF_INET, SOCK_STREAM));
+	close(server_fd);
+
+	server_fd = start_server(AF_INET6, SOCK_STREAM);
+	if (CHECK_FAIL(server_fd < 0))
+		goto close_cgroup_fd;
+	CHECK_FAIL(run_test(cgroup_fd, server_fd, AF_INET6, SOCK_STREAM));
+	close(server_fd);
+
+	server_fd = start_server(AF_INET, SOCK_DGRAM);
+	if (CHECK_FAIL(server_fd < 0))
+		goto close_cgroup_fd;
+	CHECK_FAIL(run_test(cgroup_fd, server_fd, AF_INET, SOCK_DGRAM));
+	close(server_fd);
+
+	server_fd = start_server(AF_INET6, SOCK_DGRAM);
+	if (CHECK_FAIL(server_fd < 0))
+		goto close_cgroup_fd;
+	CHECK_FAIL(run_test(cgroup_fd, server_fd, AF_INET6, SOCK_DGRAM));
+	close(server_fd);
+
+close_cgroup_fd:
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/connect_force_port4.c b/tools/testing/selftests/bpf/progs/connect_force_port4.c
new file mode 100644
index 000000000000..1b8eb34b2db0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/connect_force_port4.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <string.h>
+
+#include <linux/bpf.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <sys/socket.h>
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+char _license[] SEC("license") = "GPL";
+int _version SEC("version") = 1;
+
+SEC("cgroup/connect4")
+int _connect4(struct bpf_sock_addr *ctx)
+{
+	struct sockaddr_in sa = {};
+
+	sa.sin_family = AF_INET;
+	sa.sin_port = bpf_htons(22222);
+	sa.sin_addr.s_addr = bpf_htonl(0x7f000001); /* 127.0.0.1 */
+
+	if (bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa)) != 0)
+		return 0;
+
+	return 1;
+}
diff --git a/tools/testing/selftests/bpf/progs/connect_force_port6.c b/tools/testing/selftests/bpf/progs/connect_force_port6.c
new file mode 100644
index 000000000000..8cd1a9e81f64
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/connect_force_port6.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <string.h>
+
+#include <linux/bpf.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <sys/socket.h>
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+char _license[] SEC("license") = "GPL";
+int _version SEC("version") = 1;
+
+SEC("cgroup/connect6")
+int _connect6(struct bpf_sock_addr *ctx)
+{
+	struct sockaddr_in6 sa = {};
+
+	sa.sin6_family = AF_INET;
+	sa.sin6_port = bpf_htons(22223);
+	sa.sin6_addr.s6_addr32[3] = bpf_htonl(1); /* ::1 */
+
+	if (bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa)) != 0)
+		return 0;
+
+	return 1;
+}
-- 
2.26.2.526.g744177e7f7-goog

