Return-Path: <bpf+bounces-46817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D139F032E
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 04:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85752833D1
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 03:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44273155C97;
	Fri, 13 Dec 2024 03:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGL80WH0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DA5170A23;
	Fri, 13 Dec 2024 03:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734061286; cv=none; b=C9MU058szt8djJ8esPGTXEKlda2CvWpvTOUScNhfZVVj9mHKcY3GC8Ntz9TtnececcA06ZdcBkd1Z2091xjGy8m20LEbVzUyrP90tHJjYLRkLGbT4zMXvr8dNcgydmQJaJXUzCdZyhieMWPm2SHCaS1+qH6MMMWj4Bkt6UuLzps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734061286; c=relaxed/simple;
	bh=o6+ipYCfyeTJUUzAwSx+HMq7uopLlioUeR7zPrDJfcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qtKQGNjTIS/XF6VzaEVNKyKRctjDeZI0pbnEMKpL2NxbYIiasBnDyEhUq8awgmocV+B2AtMnNd5BDuIa2lWQ1BbcRlGoCkUfHEkRKWom6nZ6cVw40oRAnrB3JXc+evfDetwDQMoa3kQHDPwRv6jWdzCdlDoU9u974SLHZ9i6axU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGL80WH0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-215770613dbso9133475ad.2;
        Thu, 12 Dec 2024 19:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734061284; x=1734666084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqHj1YtMVxEOHcGbjVYBonaoLEybW60vC4WWr8uTT58=;
        b=GGL80WH0ruGG8/XKxVsS1Z6VFL0ykIA6McolsP9PHXMssWb2x9QpCIR9HhwKVM4DkI
         ee0ht8pZwN7Fp1M3gZR04hw2pfN5KmRptC3ggio49RYArq+/Dahjaa+VPzCR5KJ776w4
         2NvHGbwkDG8TdUOgDEdh2/pCsERSsDV/vsylLpZHyV49zMtElA44S6BMoxWZRMbfgGn6
         2ZRCpoCeh3obssoh+PskpqH4eI+/SXR/pAuS3t8AoE+tI0uUzWWPV+0UB7fujcWyWsdm
         b2atB/QsjOukwytYO+bqjwmtLm13UhZAKf+hEpCu0ks70RBdyBkKUDNHG+KCAee67p2J
         IFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734061284; x=1734666084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqHj1YtMVxEOHcGbjVYBonaoLEybW60vC4WWr8uTT58=;
        b=d2GqTxcd0rCmF6SgFHWaERM224GxDrgWGeMTj0kYisa7z1yELNRYXfd4HldIYs0pV4
         kGpfeYA4hTs+7aHWEuZ6bFFaGC9GrxSiIj+88FbhKOe1s6m0p6nKJBzYxhed073S0ZSe
         k/UYgD75NVShIGb3LTTlVJypoanuZcuIpHX9VkKFwVNirEhWjduHttPRXRNx+1nqeakc
         9ohePt4POPdsV9MQOITTJktJnvCLjcDrGyGeXK1McLYlEGBlou0EtfEV5fJXOBiN2nol
         owF12Q/7pxFpYC7iuDz2Y211NKzVz04RaxClAfy3ewlXxvgeA6u2Q6BCZTOQdeM2kZ7M
         Xl/A==
X-Gm-Message-State: AOJu0YzgLHZaEfcfqm2lYkG132gODy5At5qcyv0uNfYt1riY+WymLMIL
	Yk6EcEd9piUAkoez3rtpbD6+hoSS2W6h+5Y0XNYwrwOeCmojoYxFBnV03g==
X-Gm-Gg: ASbGnctWiQpOPMm/o6cR6Tue0Gs2Q812fHKsJZSAxEqQwDybLxQjNVJcsaQ+8/5/EJQ
	+AdtNjfQSr9KcW7nePbCu/opLdLuTvl50CIZLxtpSeZMS/2SvP3Uus56rbbpJGtf96oQpP3uTs/
	2otJEULcqi1KOk4FabLAF1yn72jWcdxPRDQuro1LAw2wWJVqwFTcsCjR3fEt3+W2+8Raj2c5PH0
	Dh54cShS16Zq+G0W8fGH+BAhqXTPNFx5SwL1FdgXVkSSjkd6irHIXZGDvK/sbQ4tkq+m1KsxtmV
	XlIDB2mSsA==
X-Google-Smtp-Source: AGHT+IGcXUWge0HwAHX3+MJVrlmDEcT/fZJU3YNoblpTFubQ8EgZjspg1l3lcps2eOVKwIDMHUBTCw==
X-Received: by 2002:a17:903:228c:b0:212:68e2:6c81 with SMTP id d9443c01a7336-218929c3a76mr19229745ad.24.1734061283619;
        Thu, 12 Dec 2024 19:41:23 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:a642:75a1:c5bb:c287])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163725faf4sm89526435ad.196.2024.12.12.19.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 19:41:23 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [Patch bpf v3 3/4] selftests/bpf: Introduce socket_helpers.h for TC tests
Date: Thu, 12 Dec 2024 19:40:56 -0800
Message-Id: <20241213034057.246437-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213034057.246437-1-xiyou.wangcong@gmail.com>
References: <20241213034057.246437-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

Pull socket helpers out of sockmap_helpers.h so that they can be reused
for TC tests as well. This prepares for the next patch.

Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 .../selftests/bpf/prog_tests/socket_helpers.h | 394 ++++++++++++++++++
 .../bpf/prog_tests/sockmap_helpers.h          | 385 +----------------
 2 files changed, 395 insertions(+), 384 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/socket_helpers.h

diff --git a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
new file mode 100644
index 000000000000..1bdfb79ef009
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
@@ -0,0 +1,394 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __SOCKET_HELPERS__
+#define __SOCKET_HELPERS__
+
+#include <linux/vm_sockets.h>
+
+/* include/linux/net.h */
+#define SOCK_TYPE_MASK 0xf
+
+#define IO_TIMEOUT_SEC 30
+#define MAX_STRERR_LEN 256
+
+/* workaround for older vm_sockets.h */
+#ifndef VMADDR_CID_LOCAL
+#define VMADDR_CID_LOCAL 1
+#endif
+
+/* include/linux/cleanup.h */
+#define __get_and_null(p, nullvalue)                                           \
+	({                                                                     \
+		__auto_type __ptr = &(p);                                      \
+		__auto_type __val = *__ptr;                                    \
+		*__ptr = nullvalue;                                            \
+		__val;                                                         \
+	})
+
+#define take_fd(fd) __get_and_null(fd, -EBADF)
+
+/* Wrappers that fail the test on error and report it. */
+
+#define _FAIL(errnum, fmt...)                                                  \
+	({                                                                     \
+		error_at_line(0, (errnum), __func__, __LINE__, fmt);           \
+		CHECK_FAIL(true);                                              \
+	})
+#define FAIL(fmt...) _FAIL(0, fmt)
+#define FAIL_ERRNO(fmt...) _FAIL(errno, fmt)
+#define FAIL_LIBBPF(err, msg)                                                  \
+	({                                                                     \
+		char __buf[MAX_STRERR_LEN];                                    \
+		libbpf_strerror((err), __buf, sizeof(__buf));                  \
+		FAIL("%s: %s", (msg), __buf);                                  \
+	})
+
+
+#define xaccept_nonblock(fd, addr, len)                                        \
+	({                                                                     \
+		int __ret =                                                    \
+			accept_timeout((fd), (addr), (len), IO_TIMEOUT_SEC);   \
+		if (__ret == -1)                                               \
+			FAIL_ERRNO("accept");                                  \
+		__ret;                                                         \
+	})
+
+#define xbind(fd, addr, len)                                                   \
+	({                                                                     \
+		int __ret = bind((fd), (addr), (len));                         \
+		if (__ret == -1)                                               \
+			FAIL_ERRNO("bind");                                    \
+		__ret;                                                         \
+	})
+
+#define xclose(fd)                                                             \
+	({                                                                     \
+		int __ret = close((fd));                                       \
+		if (__ret == -1)                                               \
+			FAIL_ERRNO("close");                                   \
+		__ret;                                                         \
+	})
+
+#define xconnect(fd, addr, len)                                                \
+	({                                                                     \
+		int __ret = connect((fd), (addr), (len));                      \
+		if (__ret == -1)                                               \
+			FAIL_ERRNO("connect");                                 \
+		__ret;                                                         \
+	})
+
+#define xgetsockname(fd, addr, len)                                            \
+	({                                                                     \
+		int __ret = getsockname((fd), (addr), (len));                  \
+		if (__ret == -1)                                               \
+			FAIL_ERRNO("getsockname");                             \
+		__ret;                                                         \
+	})
+
+#define xgetsockopt(fd, level, name, val, len)                                 \
+	({                                                                     \
+		int __ret = getsockopt((fd), (level), (name), (val), (len));   \
+		if (__ret == -1)                                               \
+			FAIL_ERRNO("getsockopt(" #name ")");                   \
+		__ret;                                                         \
+	})
+
+#define xlisten(fd, backlog)                                                   \
+	({                                                                     \
+		int __ret = listen((fd), (backlog));                           \
+		if (__ret == -1)                                               \
+			FAIL_ERRNO("listen");                                  \
+		__ret;                                                         \
+	})
+
+#define xsetsockopt(fd, level, name, val, len)                                 \
+	({                                                                     \
+		int __ret = setsockopt((fd), (level), (name), (val), (len));   \
+		if (__ret == -1)                                               \
+			FAIL_ERRNO("setsockopt(" #name ")");                   \
+		__ret;                                                         \
+	})
+
+#define xsend(fd, buf, len, flags)                                             \
+	({                                                                     \
+		ssize_t __ret = send((fd), (buf), (len), (flags));             \
+		if (__ret == -1)                                               \
+			FAIL_ERRNO("send");                                    \
+		__ret;                                                         \
+	})
+
+#define xrecv_nonblock(fd, buf, len, flags)                                    \
+	({                                                                     \
+		ssize_t __ret = recv_timeout((fd), (buf), (len), (flags),      \
+					     IO_TIMEOUT_SEC);                  \
+		if (__ret == -1)                                               \
+			FAIL_ERRNO("recv");                                    \
+		__ret;                                                         \
+	})
+
+#define xsocket(family, sotype, flags)                                         \
+	({                                                                     \
+		int __ret = socket(family, sotype, flags);                     \
+		if (__ret == -1)                                               \
+			FAIL_ERRNO("socket");                                  \
+		__ret;                                                         \
+	})
+
+static inline void close_fd(int *fd)
+{
+	if (*fd >= 0)
+		xclose(*fd);
+}
+
+#define __close_fd __attribute__((cleanup(close_fd)))
+
+static inline struct sockaddr *sockaddr(struct sockaddr_storage *ss)
+{
+	return (struct sockaddr *)ss;
+}
+
+static inline void init_addr_loopback4(struct sockaddr_storage *ss,
+				       socklen_t *len)
+{
+	struct sockaddr_in *addr4 = memset(ss, 0, sizeof(*ss));
+
+	addr4->sin_family = AF_INET;
+	addr4->sin_port = 0;
+	addr4->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	*len = sizeof(*addr4);
+}
+
+static inline void init_addr_loopback6(struct sockaddr_storage *ss,
+				       socklen_t *len)
+{
+	struct sockaddr_in6 *addr6 = memset(ss, 0, sizeof(*ss));
+
+	addr6->sin6_family = AF_INET6;
+	addr6->sin6_port = 0;
+	addr6->sin6_addr = in6addr_loopback;
+	*len = sizeof(*addr6);
+}
+
+static inline void init_addr_loopback_vsock(struct sockaddr_storage *ss,
+					    socklen_t *len)
+{
+	struct sockaddr_vm *addr = memset(ss, 0, sizeof(*ss));
+
+	addr->svm_family = AF_VSOCK;
+	addr->svm_port = VMADDR_PORT_ANY;
+	addr->svm_cid = VMADDR_CID_LOCAL;
+	*len = sizeof(*addr);
+}
+
+static inline void init_addr_loopback(int family, struct sockaddr_storage *ss,
+				      socklen_t *len)
+{
+	switch (family) {
+	case AF_INET:
+		init_addr_loopback4(ss, len);
+		return;
+	case AF_INET6:
+		init_addr_loopback6(ss, len);
+		return;
+	case AF_VSOCK:
+		init_addr_loopback_vsock(ss, len);
+		return;
+	default:
+		FAIL("unsupported address family %d", family);
+	}
+}
+
+static inline int enable_reuseport(int s, int progfd)
+{
+	int err, one = 1;
+
+	err = xsetsockopt(s, SOL_SOCKET, SO_REUSEPORT, &one, sizeof(one));
+	if (err)
+		return -1;
+	err = xsetsockopt(s, SOL_SOCKET, SO_ATTACH_REUSEPORT_EBPF, &progfd,
+			  sizeof(progfd));
+	if (err)
+		return -1;
+
+	return 0;
+}
+
+static inline int socket_loopback_reuseport(int family, int sotype, int progfd)
+{
+	struct sockaddr_storage addr;
+	socklen_t len = 0;
+	int err, s;
+
+	init_addr_loopback(family, &addr, &len);
+
+	s = xsocket(family, sotype, 0);
+	if (s == -1)
+		return -1;
+
+	if (progfd >= 0)
+		enable_reuseport(s, progfd);
+
+	err = xbind(s, sockaddr(&addr), len);
+	if (err)
+		goto close;
+
+	if (sotype & SOCK_DGRAM)
+		return s;
+
+	err = xlisten(s, SOMAXCONN);
+	if (err)
+		goto close;
+
+	return s;
+close:
+	xclose(s);
+	return -1;
+}
+
+static inline int socket_loopback(int family, int sotype)
+{
+	return socket_loopback_reuseport(family, sotype, -1);
+}
+
+static inline int poll_connect(int fd, unsigned int timeout_sec)
+{
+	struct timeval timeout = { .tv_sec = timeout_sec };
+	fd_set wfds;
+	int r, eval;
+	socklen_t esize = sizeof(eval);
+
+	FD_ZERO(&wfds);
+	FD_SET(fd, &wfds);
+
+	r = select(fd + 1, NULL, &wfds, NULL, &timeout);
+	if (r == 0)
+		errno = ETIME;
+	if (r != 1)
+		return -1;
+
+	if (getsockopt(fd, SOL_SOCKET, SO_ERROR, &eval, &esize) < 0)
+		return -1;
+	if (eval != 0) {
+		errno = eval;
+		return -1;
+	}
+
+	return 0;
+}
+
+static inline int poll_read(int fd, unsigned int timeout_sec)
+{
+	struct timeval timeout = { .tv_sec = timeout_sec };
+	fd_set rfds;
+	int r;
+
+	FD_ZERO(&rfds);
+	FD_SET(fd, &rfds);
+
+	r = select(fd + 1, &rfds, NULL, NULL, &timeout);
+	if (r == 0)
+		errno = ETIME;
+
+	return r == 1 ? 0 : -1;
+}
+
+static inline int accept_timeout(int fd, struct sockaddr *addr, socklen_t *len,
+				 unsigned int timeout_sec)
+{
+	if (poll_read(fd, timeout_sec))
+		return -1;
+
+	return accept(fd, addr, len);
+}
+
+static inline int recv_timeout(int fd, void *buf, size_t len, int flags,
+			       unsigned int timeout_sec)
+{
+	if (poll_read(fd, timeout_sec))
+		return -1;
+
+	return recv(fd, buf, len, flags);
+}
+
+
+static inline int create_pair(int family, int sotype, int *p0, int *p1)
+{
+	__close_fd int s, c = -1, p = -1;
+	struct sockaddr_storage addr;
+	socklen_t len = sizeof(addr);
+	int err;
+
+	s = socket_loopback(family, sotype);
+	if (s < 0)
+		return s;
+
+	err = xgetsockname(s, sockaddr(&addr), &len);
+	if (err)
+		return err;
+
+	c = xsocket(family, sotype, 0);
+	if (c < 0)
+		return c;
+
+	err = connect(c, sockaddr(&addr), len);
+	if (err) {
+		if (errno != EINPROGRESS) {
+			FAIL_ERRNO("connect");
+			return err;
+		}
+
+		err = poll_connect(c, IO_TIMEOUT_SEC);
+		if (err) {
+			FAIL_ERRNO("poll_connect");
+			return err;
+		}
+	}
+
+	switch (sotype & SOCK_TYPE_MASK) {
+	case SOCK_DGRAM:
+		err = xgetsockname(c, sockaddr(&addr), &len);
+		if (err)
+			return err;
+
+		err = xconnect(s, sockaddr(&addr), len);
+		if (err)
+			return err;
+
+		*p0 = take_fd(s);
+		break;
+	case SOCK_STREAM:
+	case SOCK_SEQPACKET:
+		p = xaccept_nonblock(s, NULL, NULL);
+		if (p < 0)
+			return p;
+
+		*p0 = take_fd(p);
+		break;
+	default:
+		FAIL("Unsupported socket type %#x", sotype);
+		return -EOPNOTSUPP;
+	}
+
+	*p1 = take_fd(c);
+	return 0;
+}
+
+static inline int create_socket_pairs(int family, int sotype, int *c0, int *c1,
+				      int *p0, int *p1)
+{
+	int err;
+
+	err = create_pair(family, sotype, c0, p0);
+	if (err)
+		return err;
+
+	err = create_pair(family, sotype, c1, p1);
+	if (err) {
+		close(*c0);
+		close(*p0);
+	}
+
+	return err;
+}
+
+#endif // __SOCKET_HELPERS__
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index 38e35c72bdaa..3e5571dd578d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -1,139 +1,12 @@
 #ifndef __SOCKMAP_HELPERS__
 #define __SOCKMAP_HELPERS__
 
-#include <linux/vm_sockets.h>
+#include "socket_helpers.h"
 
-/* include/linux/net.h */
-#define SOCK_TYPE_MASK 0xf
-
-#define IO_TIMEOUT_SEC 30
-#define MAX_STRERR_LEN 256
 #define MAX_TEST_NAME 80
 
-/* workaround for older vm_sockets.h */
-#ifndef VMADDR_CID_LOCAL
-#define VMADDR_CID_LOCAL 1
-#endif
-
 #define __always_unused	__attribute__((__unused__))
 
-/* include/linux/cleanup.h */
-#define __get_and_null(p, nullvalue)                                           \
-	({                                                                     \
-		__auto_type __ptr = &(p);                                      \
-		__auto_type __val = *__ptr;                                    \
-		*__ptr = nullvalue;                                            \
-		__val;                                                         \
-	})
-
-#define take_fd(fd) __get_and_null(fd, -EBADF)
-
-#define _FAIL(errnum, fmt...)                                                  \
-	({                                                                     \
-		error_at_line(0, (errnum), __func__, __LINE__, fmt);           \
-		CHECK_FAIL(true);                                              \
-	})
-#define FAIL(fmt...) _FAIL(0, fmt)
-#define FAIL_ERRNO(fmt...) _FAIL(errno, fmt)
-#define FAIL_LIBBPF(err, msg)                                                  \
-	({                                                                     \
-		char __buf[MAX_STRERR_LEN];                                    \
-		libbpf_strerror((err), __buf, sizeof(__buf));                  \
-		FAIL("%s: %s", (msg), __buf);                                  \
-	})
-
-/* Wrappers that fail the test on error and report it. */
-
-#define xaccept_nonblock(fd, addr, len)                                        \
-	({                                                                     \
-		int __ret =                                                    \
-			accept_timeout((fd), (addr), (len), IO_TIMEOUT_SEC);   \
-		if (__ret == -1)                                               \
-			FAIL_ERRNO("accept");                                  \
-		__ret;                                                         \
-	})
-
-#define xbind(fd, addr, len)                                                   \
-	({                                                                     \
-		int __ret = bind((fd), (addr), (len));                         \
-		if (__ret == -1)                                               \
-			FAIL_ERRNO("bind");                                    \
-		__ret;                                                         \
-	})
-
-#define xclose(fd)                                                             \
-	({                                                                     \
-		int __ret = close((fd));                                       \
-		if (__ret == -1)                                               \
-			FAIL_ERRNO("close");                                   \
-		__ret;                                                         \
-	})
-
-#define xconnect(fd, addr, len)                                                \
-	({                                                                     \
-		int __ret = connect((fd), (addr), (len));                      \
-		if (__ret == -1)                                               \
-			FAIL_ERRNO("connect");                                 \
-		__ret;                                                         \
-	})
-
-#define xgetsockname(fd, addr, len)                                            \
-	({                                                                     \
-		int __ret = getsockname((fd), (addr), (len));                  \
-		if (__ret == -1)                                               \
-			FAIL_ERRNO("getsockname");                             \
-		__ret;                                                         \
-	})
-
-#define xgetsockopt(fd, level, name, val, len)                                 \
-	({                                                                     \
-		int __ret = getsockopt((fd), (level), (name), (val), (len));   \
-		if (__ret == -1)                                               \
-			FAIL_ERRNO("getsockopt(" #name ")");                   \
-		__ret;                                                         \
-	})
-
-#define xlisten(fd, backlog)                                                   \
-	({                                                                     \
-		int __ret = listen((fd), (backlog));                           \
-		if (__ret == -1)                                               \
-			FAIL_ERRNO("listen");                                  \
-		__ret;                                                         \
-	})
-
-#define xsetsockopt(fd, level, name, val, len)                                 \
-	({                                                                     \
-		int __ret = setsockopt((fd), (level), (name), (val), (len));   \
-		if (__ret == -1)                                               \
-			FAIL_ERRNO("setsockopt(" #name ")");                   \
-		__ret;                                                         \
-	})
-
-#define xsend(fd, buf, len, flags)                                             \
-	({                                                                     \
-		ssize_t __ret = send((fd), (buf), (len), (flags));             \
-		if (__ret == -1)                                               \
-			FAIL_ERRNO("send");                                    \
-		__ret;                                                         \
-	})
-
-#define xrecv_nonblock(fd, buf, len, flags)                                    \
-	({                                                                     \
-		ssize_t __ret = recv_timeout((fd), (buf), (len), (flags),      \
-					     IO_TIMEOUT_SEC);                  \
-		if (__ret == -1)                                               \
-			FAIL_ERRNO("recv");                                    \
-		__ret;                                                         \
-	})
-
-#define xsocket(family, sotype, flags)                                         \
-	({                                                                     \
-		int __ret = socket(family, sotype, flags);                     \
-		if (__ret == -1)                                               \
-			FAIL_ERRNO("socket");                                  \
-		__ret;                                                         \
-	})
-
 #define xbpf_map_delete_elem(fd, key)                                          \
 	({                                                                     \
 		int __ret = bpf_map_delete_elem((fd), (key));                  \
@@ -193,130 +66,6 @@
 		__ret;                                                         \
 	})
 
-static inline void close_fd(int *fd)
-{
-	if (*fd >= 0)
-		xclose(*fd);
-}
-
-#define __close_fd __attribute__((cleanup(close_fd)))
-
-static inline int poll_connect(int fd, unsigned int timeout_sec)
-{
-	struct timeval timeout = { .tv_sec = timeout_sec };
-	fd_set wfds;
-	int r, eval;
-	socklen_t esize = sizeof(eval);
-
-	FD_ZERO(&wfds);
-	FD_SET(fd, &wfds);
-
-	r = select(fd + 1, NULL, &wfds, NULL, &timeout);
-	if (r == 0)
-		errno = ETIME;
-	if (r != 1)
-		return -1;
-
-	if (getsockopt(fd, SOL_SOCKET, SO_ERROR, &eval, &esize) < 0)
-		return -1;
-	if (eval != 0) {
-		errno = eval;
-		return -1;
-	}
-
-	return 0;
-}
-
-static inline int poll_read(int fd, unsigned int timeout_sec)
-{
-	struct timeval timeout = { .tv_sec = timeout_sec };
-	fd_set rfds;
-	int r;
-
-	FD_ZERO(&rfds);
-	FD_SET(fd, &rfds);
-
-	r = select(fd + 1, &rfds, NULL, NULL, &timeout);
-	if (r == 0)
-		errno = ETIME;
-
-	return r == 1 ? 0 : -1;
-}
-
-static inline int accept_timeout(int fd, struct sockaddr *addr, socklen_t *len,
-				 unsigned int timeout_sec)
-{
-	if (poll_read(fd, timeout_sec))
-		return -1;
-
-	return accept(fd, addr, len);
-}
-
-static inline int recv_timeout(int fd, void *buf, size_t len, int flags,
-			       unsigned int timeout_sec)
-{
-	if (poll_read(fd, timeout_sec))
-		return -1;
-
-	return recv(fd, buf, len, flags);
-}
-
-static inline void init_addr_loopback4(struct sockaddr_storage *ss,
-				       socklen_t *len)
-{
-	struct sockaddr_in *addr4 = memset(ss, 0, sizeof(*ss));
-
-	addr4->sin_family = AF_INET;
-	addr4->sin_port = 0;
-	addr4->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
-	*len = sizeof(*addr4);
-}
-
-static inline void init_addr_loopback6(struct sockaddr_storage *ss,
-				       socklen_t *len)
-{
-	struct sockaddr_in6 *addr6 = memset(ss, 0, sizeof(*ss));
-
-	addr6->sin6_family = AF_INET6;
-	addr6->sin6_port = 0;
-	addr6->sin6_addr = in6addr_loopback;
-	*len = sizeof(*addr6);
-}
-
-static inline void init_addr_loopback_vsock(struct sockaddr_storage *ss,
-					    socklen_t *len)
-{
-	struct sockaddr_vm *addr = memset(ss, 0, sizeof(*ss));
-
-	addr->svm_family = AF_VSOCK;
-	addr->svm_port = VMADDR_PORT_ANY;
-	addr->svm_cid = VMADDR_CID_LOCAL;
-	*len = sizeof(*addr);
-}
-
-static inline void init_addr_loopback(int family, struct sockaddr_storage *ss,
-				      socklen_t *len)
-{
-	switch (family) {
-	case AF_INET:
-		init_addr_loopback4(ss, len);
-		return;
-	case AF_INET6:
-		init_addr_loopback6(ss, len);
-		return;
-	case AF_VSOCK:
-		init_addr_loopback_vsock(ss, len);
-		return;
-	default:
-		FAIL("unsupported address family %d", family);
-	}
-}
-
-static inline struct sockaddr *sockaddr(struct sockaddr_storage *ss)
-{
-	return (struct sockaddr *)ss;
-}
-
 static inline int add_to_sockmap(int sock_mapfd, int fd1, int fd2)
 {
 	u64 value;
@@ -334,136 +83,4 @@ static inline int add_to_sockmap(int sock_mapfd, int fd1, int fd2)
 	return xbpf_map_update_elem(sock_mapfd, &key, &value, BPF_NOEXIST);
 }
 
-static inline int enable_reuseport(int s, int progfd)
-{
-	int err, one = 1;
-
-	err = xsetsockopt(s, SOL_SOCKET, SO_REUSEPORT, &one, sizeof(one));
-	if (err)
-		return -1;
-	err = xsetsockopt(s, SOL_SOCKET, SO_ATTACH_REUSEPORT_EBPF, &progfd,
-			  sizeof(progfd));
-	if (err)
-		return -1;
-
-	return 0;
-}
-
-static inline int socket_loopback_reuseport(int family, int sotype, int progfd)
-{
-	struct sockaddr_storage addr;
-	socklen_t len = 0;
-	int err, s;
-
-	init_addr_loopback(family, &addr, &len);
-
-	s = xsocket(family, sotype, 0);
-	if (s == -1)
-		return -1;
-
-	if (progfd >= 0)
-		enable_reuseport(s, progfd);
-
-	err = xbind(s, sockaddr(&addr), len);
-	if (err)
-		goto close;
-
-	if (sotype & SOCK_DGRAM)
-		return s;
-
-	err = xlisten(s, SOMAXCONN);
-	if (err)
-		goto close;
-
-	return s;
-close:
-	xclose(s);
-	return -1;
-}
-
-static inline int socket_loopback(int family, int sotype)
-{
-	return socket_loopback_reuseport(family, sotype, -1);
-}
-
-static inline int create_pair(int family, int sotype, int *p0, int *p1)
-{
-	__close_fd int s, c = -1, p = -1;
-	struct sockaddr_storage addr;
-	socklen_t len = sizeof(addr);
-	int err;
-
-	s = socket_loopback(family, sotype);
-	if (s < 0)
-		return s;
-
-	err = xgetsockname(s, sockaddr(&addr), &len);
-	if (err)
-		return err;
-
-	c = xsocket(family, sotype, 0);
-	if (c < 0)
-		return c;
-
-	err = connect(c, sockaddr(&addr), len);
-	if (err) {
-		if (errno != EINPROGRESS) {
-			FAIL_ERRNO("connect");
-			return err;
-		}
-
-		err = poll_connect(c, IO_TIMEOUT_SEC);
-		if (err) {
-			FAIL_ERRNO("poll_connect");
-			return err;
-		}
-	}
-
-	switch (sotype & SOCK_TYPE_MASK) {
-	case SOCK_DGRAM:
-		err = xgetsockname(c, sockaddr(&addr), &len);
-		if (err)
-			return err;
-
-		err = xconnect(s, sockaddr(&addr), len);
-		if (err)
-			return err;
-
-		*p0 = take_fd(s);
-		break;
-	case SOCK_STREAM:
-	case SOCK_SEQPACKET:
-		p = xaccept_nonblock(s, NULL, NULL);
-		if (p < 0)
-			return p;
-
-		*p0 = take_fd(p);
-		break;
-	default:
-		FAIL("Unsupported socket type %#x", sotype);
-		return -EOPNOTSUPP;
-	}
-
-	*p1 = take_fd(c);
-	return 0;
-}
-
-static inline int create_socket_pairs(int family, int sotype, int *c0, int *c1,
-				      int *p0, int *p1)
-{
-	int err;
-
-	err = create_pair(family, sotype, c0, p0);
-	if (err)
-		return err;
-
-	err = create_pair(family, sotype, c1, p1);
-	if (err) {
-		close(*c0);
-		close(*p0);
-	}
-
-	return err;
-}
-
 #endif // __SOCKMAP_HELPERS__
-- 
2.34.1


