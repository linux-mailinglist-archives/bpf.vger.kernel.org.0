Return-Path: <bpf+bounces-2290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC06B72A759
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 03:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D5F280E3D
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 01:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81CA8BFC;
	Sat, 10 Jun 2023 00:59:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F39B79E3
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 00:59:01 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323A33AB2
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 17:58:53 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-6261a8bbe5fso18276296d6.0
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 17:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686358732; x=1688950732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PT++VZNUMXEFhvCG58k2InRSiOzVfFUx6mXd86yXfnU=;
        b=cSg5caQeIBvwWDH70orHwCvAFbiGeRsgy7S9WZEbKNb46uRN6NOw/fAZfIDTT2uLu2
         k/B6hEhzqgUq+hpMt5uaaKnmjKPJWj4eDbN+Ac5lR/sQg/GcJLaNoyjnWOFb1yug8CoG
         6UzllIeqddTDolRxdW70Yr2kPglZLUHgkn2t7T4zyPbqO4Q1RzltvqZ82VYva7xdrKJS
         y9NI0E4SK2mdTgQvpNi+XNKubtAvr1xzXQKDbffZ1L6bL0kzhruFf1x1PsBKWPwhbGtv
         PLavA8vJMIw38VpoaxgSIhT9fe1W8iy2xPzuLFEJWL4JffMwyonnNNh5CIxA8L0YG9BD
         q/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686358732; x=1688950732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PT++VZNUMXEFhvCG58k2InRSiOzVfFUx6mXd86yXfnU=;
        b=F61u4zXac0yGw8ZESoYLJUFqiqWo6MxfvuA876n+XVszK+g1hkuDVIwIXkUz9En77s
         4PlyDa2kg3dV3Lme+2/9l1UnV1ODCS2N63v2xyMBUJHzqXQVYFM0q+Bofj2ZUJmd7yAg
         t+GlTe1Y/sESUIFnDRAfbzI+IkXQcdACQU8Oi16/NCr+yHsdANE0FcbjUm6QNntoWCDM
         leWXwvNUXKenzR6AJfOnfbh/UJRJ8bj48ePM8ZYUkdVVObxna0cnXu9ja9x72qAo37iR
         nadFoFkwGTD52T4rw7XU3qK90ujxy0yjml/h6sKtdgyg18zRkkByjuiN9SlngO+NHGu+
         bf8A==
X-Gm-Message-State: AC+VfDxiQbVg27mecDWU/eQudnydnB6pXdMwELBnyLAAZKThxTTVFCc2
	Pjrh6Zht2QkJ7WJLVoHBPsymsQ==
X-Google-Smtp-Source: ACHHUZ713Od678QMcSR5DMuXIRgaRrbTL+iz+vtwxzFzmUW5LdfmeeUfZQzDanBF2yCyAiCHNyy7/Q==
X-Received: by 2002:a05:6214:f61:b0:623:8d60:da60 with SMTP id iy1-20020a0562140f6100b006238d60da60mr3351561qvb.34.1686358731747;
        Fri, 09 Jun 2023 17:58:51 -0700 (PDT)
Received: from [172.17.0.4] ([130.44.212.126])
        by smtp.gmail.com with ESMTPSA id x17-20020a0ce251000000b00606750abaf9sm1504075qvl.136.2023.06.09.17.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 17:58:51 -0700 (PDT)
From: Bobby Eshleman <bobby.eshleman@bytedance.com>
Date: Sat, 10 Jun 2023 00:58:35 +0000
Subject: [PATCH RFC net-next v4 8/8] tests: add vsock dgram tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-b4-vsock-dgram-v4-8-0cebbb2ae899@bytedance.com>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
In-Reply-To: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryantan@vmware.com>, 
 Vishnu Dasa <vdasa@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Simon Horman <simon.horman@corigine.com>, 
 Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 bpf@vger.kernel.org, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 Jiang Wang <jiang.wang@bytedance.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiang Wang <jiang.wang@bytedance.com>

This patch adds tests for vsock datagram.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
---
 tools/testing/vsock/util.c       | 141 ++++++++++++-
 tools/testing/vsock/util.h       |   6 +
 tools/testing/vsock/vsock_test.c | 432 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 578 insertions(+), 1 deletion(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 01b636d3039a..811e70d7cf1e 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -99,7 +99,8 @@ static int vsock_connect(unsigned int cid, unsigned int port, int type)
 	int ret;
 	int fd;
 
-	control_expectln("LISTENING");
+	if (type != SOCK_DGRAM)
+		control_expectln("LISTENING");
 
 	fd = socket(AF_VSOCK, type, 0);
 
@@ -130,6 +131,11 @@ int vsock_seqpacket_connect(unsigned int cid, unsigned int port)
 	return vsock_connect(cid, port, SOCK_SEQPACKET);
 }
 
+int vsock_dgram_connect(unsigned int cid, unsigned int port)
+{
+	return vsock_connect(cid, port, SOCK_DGRAM);
+}
+
 /* Listen on <cid, port> and return the first incoming connection.  The remote
  * address is stored to clientaddrp.  clientaddrp may be NULL.
  */
@@ -211,6 +217,34 @@ int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
 	return vsock_accept(cid, port, clientaddrp, SOCK_SEQPACKET);
 }
 
+int vsock_dgram_bind(unsigned int cid, unsigned int port)
+{
+	union {
+		struct sockaddr sa;
+		struct sockaddr_vm svm;
+	} addr = {
+		.svm = {
+			.svm_family = AF_VSOCK,
+			.svm_port = port,
+			.svm_cid = cid,
+		},
+	};
+	int fd;
+
+	fd = socket(AF_VSOCK, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		exit(EXIT_FAILURE);
+	}
+
+	if (bind(fd, &addr.sa, sizeof(addr.svm)) < 0) {
+		perror("bind");
+		exit(EXIT_FAILURE);
+	}
+
+	return fd;
+}
+
 /* Transmit one byte and check the return value.
  *
  * expected_ret:
@@ -260,6 +294,57 @@ void send_byte(int fd, int expected_ret, int flags)
 	}
 }
 
+/* Transmit one byte and check the return value.
+ *
+ * expected_ret:
+ *  <0 Negative errno (for testing errors)
+ *   0 End-of-file
+ *   1 Success
+ */
+void sendto_byte(int fd, const struct sockaddr *dest_addr, int len, int expected_ret,
+		 int flags)
+{
+	const uint8_t byte = 'A';
+	ssize_t nwritten;
+
+	timeout_begin(TIMEOUT);
+	do {
+		nwritten = sendto(fd, &byte, sizeof(byte), flags, dest_addr,
+				  len);
+		timeout_check("write");
+	} while (nwritten < 0 && errno == EINTR);
+	timeout_end();
+
+	if (expected_ret < 0) {
+		if (nwritten != -1) {
+			fprintf(stderr, "bogus sendto(2) return value %zd\n",
+				nwritten);
+			exit(EXIT_FAILURE);
+		}
+		if (errno != -expected_ret) {
+			perror("write");
+			exit(EXIT_FAILURE);
+		}
+		return;
+	}
+
+	if (nwritten < 0) {
+		perror("write");
+		exit(EXIT_FAILURE);
+	}
+	if (nwritten == 0) {
+		if (expected_ret == 0)
+			return;
+
+		fprintf(stderr, "unexpected EOF while sending byte\n");
+		exit(EXIT_FAILURE);
+	}
+	if (nwritten != sizeof(byte)) {
+		fprintf(stderr, "bogus sendto(2) return value %zd\n", nwritten);
+		exit(EXIT_FAILURE);
+	}
+}
+
 /* Receive one byte and check the return value.
  *
  * expected_ret:
@@ -313,6 +398,60 @@ void recv_byte(int fd, int expected_ret, int flags)
 	}
 }
 
+/* Receive one byte and check the return value.
+ *
+ * expected_ret:
+ *  <0 Negative errno (for testing errors)
+ *   0 End-of-file
+ *   1 Success
+ */
+void recvfrom_byte(int fd, struct sockaddr *src_addr, socklen_t *addrlen,
+		   int expected_ret, int flags)
+{
+	uint8_t byte;
+	ssize_t nread;
+
+	timeout_begin(TIMEOUT);
+	do {
+		nread = recvfrom(fd, &byte, sizeof(byte), flags, src_addr, addrlen);
+		timeout_check("read");
+	} while (nread < 0 && errno == EINTR);
+	timeout_end();
+
+	if (expected_ret < 0) {
+		if (nread != -1) {
+			fprintf(stderr, "bogus recvfrom(2) return value %zd\n",
+				nread);
+			exit(EXIT_FAILURE);
+		}
+		if (errno != -expected_ret) {
+			perror("read");
+			exit(EXIT_FAILURE);
+		}
+		return;
+	}
+
+	if (nread < 0) {
+		perror("read");
+		exit(EXIT_FAILURE);
+	}
+	if (nread == 0) {
+		if (expected_ret == 0)
+			return;
+
+		fprintf(stderr, "unexpected EOF while receiving byte\n");
+		exit(EXIT_FAILURE);
+	}
+	if (nread != sizeof(byte)) {
+		fprintf(stderr, "bogus recvfrom(2) return value %zd\n", nread);
+		exit(EXIT_FAILURE);
+	}
+	if (byte != 'A') {
+		fprintf(stderr, "unexpected byte read %c\n", byte);
+		exit(EXIT_FAILURE);
+	}
+}
+
 /* Run test cases.  The program terminates if a failure occurs. */
 void run_tests(const struct test_case *test_cases,
 	       const struct test_opts *opts)
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index fb99208a95ea..a69e128d120c 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -37,13 +37,19 @@ void init_signals(void);
 unsigned int parse_cid(const char *str);
 int vsock_stream_connect(unsigned int cid, unsigned int port);
 int vsock_seqpacket_connect(unsigned int cid, unsigned int port);
+int vsock_dgram_connect(unsigned int cid, unsigned int port);
 int vsock_stream_accept(unsigned int cid, unsigned int port,
 			struct sockaddr_vm *clientaddrp);
 int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
 			   struct sockaddr_vm *clientaddrp);
+int vsock_dgram_bind(unsigned int cid, unsigned int port);
 void vsock_wait_remote_close(int fd);
 void send_byte(int fd, int expected_ret, int flags);
+void sendto_byte(int fd, const struct sockaddr *dest_addr, int len, int expected_ret,
+		 int flags);
 void recv_byte(int fd, int expected_ret, int flags);
+void recvfrom_byte(int fd, struct sockaddr *src_addr, socklen_t *addrlen,
+		   int expected_ret, int flags);
 void run_tests(const struct test_case *test_cases,
 	       const struct test_opts *opts);
 void list_tests(const struct test_case *test_cases);
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index ac1bd3ac1533..ded82d39ee5d 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1053,6 +1053,413 @@ static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
 	close(fd);
 }
 
+static void test_dgram_sendto_client(const struct test_opts *opts)
+{
+	union {
+		struct sockaddr sa;
+		struct sockaddr_vm svm;
+	} addr = {
+		.svm = {
+			.svm_family = AF_VSOCK,
+			.svm_port = 1234,
+			.svm_cid = opts->peer_cid,
+		},
+	};
+	int fd;
+
+	/* Wait for the server to be ready */
+	control_expectln("BIND");
+
+	fd = socket(AF_VSOCK, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		exit(EXIT_FAILURE);
+	}
+
+	sendto_byte(fd, &addr.sa, sizeof(addr.svm), 1, 0);
+
+	/* Notify the server that the client has finished */
+	control_writeln("DONE");
+
+	close(fd);
+}
+
+static void test_dgram_sendto_server(const struct test_opts *opts)
+{
+	union {
+		struct sockaddr sa;
+		struct sockaddr_vm svm;
+	} addr = {
+		.svm = {
+			.svm_family = AF_VSOCK,
+			.svm_port = 1234,
+			.svm_cid = VMADDR_CID_ANY,
+		},
+	};
+	int len = sizeof(addr.sa);
+	int fd;
+
+	fd = socket(AF_VSOCK, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		exit(EXIT_FAILURE);
+	}
+
+	if (bind(fd, &addr.sa, sizeof(addr.svm)) < 0) {
+		perror("bind");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Notify the client that the server is ready */
+	control_writeln("BIND");
+
+	recvfrom_byte(fd, &addr.sa, &len, 1, 0);
+
+	/* Wait for the client to finish */
+	control_expectln("DONE");
+
+	close(fd);
+}
+
+static void test_dgram_connect_client(const struct test_opts *opts)
+{
+	union {
+		struct sockaddr sa;
+		struct sockaddr_vm svm;
+	} addr = {
+		.svm = {
+			.svm_family = AF_VSOCK,
+			.svm_port = 1234,
+			.svm_cid = opts->peer_cid,
+		},
+	};
+	int ret;
+	int fd;
+
+	/* Wait for the server to be ready */
+	control_expectln("BIND");
+
+	fd = socket(AF_VSOCK, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		perror("bind");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = connect(fd, &addr.sa, sizeof(addr.svm));
+	if (ret < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	send_byte(fd, 1, 0);
+
+	/* Notify the server that the client has finished */
+	control_writeln("DONE");
+
+	close(fd);
+}
+
+static void test_dgram_connect_server(const struct test_opts *opts)
+{
+	test_dgram_sendto_server(opts);
+}
+
+static void test_dgram_multiconn_sendto_client(const struct test_opts *opts)
+{
+	union {
+		struct sockaddr sa;
+		struct sockaddr_vm svm;
+	} addr = {
+		.svm = {
+			.svm_family = AF_VSOCK,
+			.svm_port = 1234,
+			.svm_cid = opts->peer_cid,
+		},
+	};
+	int fds[MULTICONN_NFDS];
+	int i;
+
+	/* Wait for the server to be ready */
+	control_expectln("BIND");
+
+	for (i = 0; i < MULTICONN_NFDS; i++) {
+		fds[i] = socket(AF_VSOCK, SOCK_DGRAM, 0);
+		if (fds[i] < 0) {
+			perror("socket");
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	for (i = 0; i < MULTICONN_NFDS; i++)
+		sendto_byte(fds[i], &addr.sa, sizeof(addr.svm), 1, 0);
+
+	/* Notify the server that the client has finished */
+	control_writeln("DONE");
+
+	for (i = 0; i < MULTICONN_NFDS; i++)
+		close(fds[i]);
+}
+
+static void test_dgram_multiconn_sendto_server(const struct test_opts *opts)
+{
+	union {
+		struct sockaddr sa;
+		struct sockaddr_vm svm;
+	} addr = {
+		.svm = {
+			.svm_family = AF_VSOCK,
+			.svm_port = 1234,
+			.svm_cid = VMADDR_CID_ANY,
+		},
+	};
+	int len = sizeof(addr.sa);
+	int fd;
+	int i;
+
+	fd = socket(AF_VSOCK, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		exit(EXIT_FAILURE);
+	}
+
+	if (bind(fd, &addr.sa, sizeof(addr.svm)) < 0) {
+		perror("bind");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Notify the client that the server is ready */
+	control_writeln("BIND");
+
+	for (i = 0; i < MULTICONN_NFDS; i++)
+		recvfrom_byte(fd, &addr.sa, &len, 1, 0);
+
+	/* Wait for the client to finish */
+	control_expectln("DONE");
+
+	close(fd);
+}
+
+static void test_dgram_multiconn_send_client(const struct test_opts *opts)
+{
+	int fds[MULTICONN_NFDS];
+	int i;
+
+	/* Wait for the server to be ready */
+	control_expectln("BIND");
+
+	for (i = 0; i < MULTICONN_NFDS; i++) {
+		fds[i] = vsock_dgram_connect(opts->peer_cid, 1234);
+		if (fds[i] < 0) {
+			perror("socket");
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	for (i = 0; i < MULTICONN_NFDS; i++)
+		send_byte(fds[i], 1, 0);
+
+	/* Notify the server that the client has finished */
+	control_writeln("DONE");
+
+	for (i = 0; i < MULTICONN_NFDS; i++)
+		close(fds[i]);
+}
+
+static void test_dgram_multiconn_send_server(const struct test_opts *opts)
+{
+	union {
+		struct sockaddr sa;
+		struct sockaddr_vm svm;
+	} addr = {
+		.svm = {
+			.svm_family = AF_VSOCK,
+			.svm_port = 1234,
+			.svm_cid = VMADDR_CID_ANY,
+		},
+	};
+	int fd;
+	int i;
+
+	fd = socket(AF_VSOCK, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		exit(EXIT_FAILURE);
+	}
+
+	if (bind(fd, &addr.sa, sizeof(addr.svm)) < 0) {
+		perror("bind");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Notify the client that the server is ready */
+	control_writeln("BIND");
+
+	for (i = 0; i < MULTICONN_NFDS; i++)
+		recv_byte(fd, 1, 0);
+
+	/* Wait for the client to finish */
+	control_expectln("DONE");
+
+	close(fd);
+}
+
+static void test_dgram_msg_bounds_client(const struct test_opts *opts)
+{
+	unsigned long recv_buf_size;
+	int page_size;
+	int msg_cnt;
+	int fd;
+
+	fd = vsock_dgram_connect(opts->peer_cid, 1234);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Let the server know the client is ready */
+	control_writeln("CLNTREADY");
+
+	msg_cnt = control_readulong();
+	recv_buf_size = control_readulong();
+
+	/* Wait, until receiver sets buffer size. */
+	control_expectln("SRVREADY");
+
+	page_size = getpagesize();
+
+	for (int i = 0; i < msg_cnt; i++) {
+		unsigned long curr_hash;
+		ssize_t send_size;
+		size_t buf_size;
+		void *buf;
+
+		/* Use "small" buffers and "big" buffers. */
+		if (i & 1)
+			buf_size = page_size +
+					(rand() % (MAX_MSG_SIZE - page_size));
+		else
+			buf_size = 1 + (rand() % page_size);
+
+		buf_size = min(buf_size, recv_buf_size);
+
+		buf = malloc(buf_size);
+
+		if (!buf) {
+			perror("malloc");
+			exit(EXIT_FAILURE);
+		}
+
+		memset(buf, rand() & 0xff, buf_size);
+		/* Set at least one MSG_EOR + some random. */
+
+		send_size = send(fd, buf, buf_size, 0);
+
+		if (send_size < 0) {
+			perror("send");
+			exit(EXIT_FAILURE);
+		}
+
+		if (send_size != buf_size) {
+			fprintf(stderr, "Invalid send size\n");
+			exit(EXIT_FAILURE);
+		}
+
+		/* In theory the implementation isn't required to transmit
+		 * these packets in order, so we use this SYNC control message
+		 * so that server and client coordinate sending and receiving
+		 * one packet at a time. The client sends a packet and waits
+		 * until it has been received before sending another.
+		 */
+		control_writeln("PKTSENT");
+		control_expectln("PKTRECV");
+
+		/* Send the server a hash of the packet */
+		curr_hash = hash_djb2(buf, buf_size);
+		control_writeulong(curr_hash);
+		free(buf);
+	}
+
+	control_writeln("SENDDONE");
+	close(fd);
+}
+
+static void test_dgram_msg_bounds_server(const struct test_opts *opts)
+{
+	const unsigned long msg_cnt = 16;
+	unsigned long sock_buf_size;
+	struct msghdr msg = {0};
+	struct iovec iov = {0};
+	char buf[MAX_MSG_SIZE];
+	socklen_t len;
+	int fd;
+	int i;
+
+	fd = vsock_dgram_bind(VMADDR_CID_ANY, 1234);
+
+	if (fd < 0) {
+		perror("bind");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Set receive buffer to maximum */
+	sock_buf_size = -1;
+	if (setsockopt(fd, SOL_SOCKET, SO_RCVBUF,
+		       &sock_buf_size, sizeof(sock_buf_size))) {
+		perror("setsockopt(SO_RECVBUF)");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Retrieve the receive buffer size */
+	len = sizeof(sock_buf_size);
+	if (getsockopt(fd, SOL_SOCKET, SO_RCVBUF,
+		       &sock_buf_size, &len)) {
+		perror("getsockopt(SO_RECVBUF)");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Client ready to receive parameters */
+	control_expectln("CLNTREADY");
+
+	control_writeulong(msg_cnt);
+	control_writeulong(sock_buf_size);
+
+	/* Ready to receive data. */
+	control_writeln("SRVREADY");
+
+	iov.iov_base = buf;
+	iov.iov_len = sizeof(buf);
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+
+	for (i = 0; i < msg_cnt; i++) {
+		unsigned long remote_hash;
+		unsigned long curr_hash;
+		ssize_t recv_size;
+
+		control_expectln("PKTSENT");
+		recv_size = recvmsg(fd, &msg, 0);
+		control_writeln("PKTRECV");
+
+		if (!recv_size)
+			break;
+
+		if (recv_size < 0) {
+			perror("recvmsg");
+			exit(EXIT_FAILURE);
+		}
+
+		curr_hash = hash_djb2(msg.msg_iov[0].iov_base, recv_size);
+		remote_hash = control_readulong();
+
+		if (curr_hash != remote_hash) {
+			fprintf(stderr, "Message bounds broken\n");
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	close(fd);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -1128,6 +1535,31 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_virtio_skb_merge_client,
 		.run_server = test_stream_virtio_skb_merge_server,
 	},
+	{
+		.name = "SOCK_DGRAM client sendto",
+		.run_client = test_dgram_sendto_client,
+		.run_server = test_dgram_sendto_server,
+	},
+	{
+		.name = "SOCK_DGRAM client connect",
+		.run_client = test_dgram_connect_client,
+		.run_server = test_dgram_connect_server,
+	},
+	{
+		.name = "SOCK_DGRAM multiple connections using sendto",
+		.run_client = test_dgram_multiconn_sendto_client,
+		.run_server = test_dgram_multiconn_sendto_server,
+	},
+	{
+		.name = "SOCK_DGRAM multiple connections using send",
+		.run_client = test_dgram_multiconn_send_client,
+		.run_server = test_dgram_multiconn_send_server,
+	},
+	{
+		.name = "SOCK_DGRAM msg bounds",
+		.run_client = test_dgram_msg_bounds_client,
+		.run_server = test_dgram_msg_bounds_server,
+	},
 	{},
 };
 

-- 
2.30.2


