Return-Path: <bpf+bounces-20255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC78B83B18A
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641251F2392A
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 18:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0035131E36;
	Wed, 24 Jan 2024 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvHtgRlL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F31C13175D;
	Wed, 24 Jan 2024 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122450; cv=none; b=tfizPKpcyrsTlC8eK24nK9kl9Dajph4tGyU8YkzHxh7zxl6jKfHdhsau5y9N9BmAGf7sprTeRK5/UDd/1gCt07uR5FKlyREJ8bl06r+FsPjLTa7N0RxhtNHbKU+WdmFQgdvg40Mr8i+TowWhuPmpzUX6IsejBLnIrcHVURkHvHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122450; c=relaxed/simple;
	bh=L3igyJHYbCDhLOOOZeQY+/7fItzANL3OcV+d19x9sKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K4yns4JFF//GIzmbC9qxdJMzmR8AYiG+JhuBgFkzBiVFToWjFAcD8BuVZXZg6BcjvUk6u2pulCKWCs49TNcoAs3F71KcOrOc4WZUGfYif6DoAh+/oTboMmjsw3E6QUr6lUIqXxx0tY+ur9NiK9YdjcmDaTpvR0g4Mwkhh+eKRBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvHtgRlL; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6dc6f47302bso2615866b3a.1;
        Wed, 24 Jan 2024 10:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706122448; x=1706727248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIy/qDrfZpGQr03QOGQZTj3QWnPvTmsJgQQT7l8hmHg=;
        b=KvHtgRlLFqa9OK+8vYkoQTeEvNP5FIXL95UHIR8LX5NGlTykAlNTb4dqwaZ4j4RQdE
         bsR7AjEKLCUesiJfNiNXzPzYtrdl52hKetpUMBE3Ni7r3B9NevQMq2yiyBRUHgPg6jeN
         fhCeE7r8y2VnhIoEr41TS6Lg6AVYJyeeZX5dsVw0qewbA8LNGQ+urmgab8MDIrRwc4QS
         f79iqLOeniN3KyFBORvG8haDLjKGwqbUMu1Qckp99lQnRwbIs8nGO7z4yrb96z2NAjBm
         HEXHXv+JgDQ9rxfvQyg162XEMjM0ZoEO0KlqcaktXWaW9+Et6Xm138gNqvwwyZIK3tHG
         CIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706122448; x=1706727248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIy/qDrfZpGQr03QOGQZTj3QWnPvTmsJgQQT7l8hmHg=;
        b=l4Qaa/BfUb46DFby/6LZm+FZfEFzTxDObMcJcImvrXpmeeH70VcCb5OstaS1cn5NQA
         ynSGCF6W2CFa9VagK32DFiKXgNO6pUSFUjO78syeiDME79EF8sCHe2Dh8xLQnrZWwCKI
         CnoMox3msmNNlxKQ3Q1/7QoMxYzXmPYkYl1c6ZBFS4RZbULDNeQWXlR0gVUfaURWvtm3
         wqMR0oySUkr9xCs3tREjQAG4ZqItOJFVQz63D2Fvv6D1StfmIHKbVgsmeqviwFif4IH1
         r7r7W9xY0LXjphBigisKev4SwTeY6Dq7ISjgralubF4P/exBdFIG8Ger1rW4W7A3EJoc
         5L1A==
X-Gm-Message-State: AOJu0YzaCQeDmj0aN+4WyQrBUEYKxOATI67TT/63JKK3ARyE0EA2YddQ
	WfwCznU+UoXgm6pd5SI0pU6qNPhe8/Lx8YeEvbJdnWS0RxInDNlk
X-Google-Smtp-Source: AGHT+IFLAsqXlNEwdbanfo/V3kjDEX+RvB/Z1dIJwIrExAfZD60qZ7cZZOXk1B3SUWemq6fcH9f9Qg==
X-Received: by 2002:a05:6a00:3a09:b0:6db:a0e5:7ec3 with SMTP id fj9-20020a056a003a0900b006dba0e57ec3mr10551981pfb.22.1706122447888;
        Wed, 24 Jan 2024 10:54:07 -0800 (PST)
Received: from john.. ([98.97.116.78])
        by smtp.gmail.com with ESMTPSA id ko18-20020a056a00461200b006dab0d72cd0sm14113696pfb.214.2024.01.24.10.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:54:06 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: jakub@cloudflare.com,
	bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org
Subject: [PATCH bpf-next v2 1/4] bpf: sockmap, add test for sk_msg prog pop msg helper
Date: Wed, 24 Jan 2024 10:54:00 -0800
Message-Id: <20240124185403.1104141-2-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240124185403.1104141-1-john.fastabend@gmail.com>
References: <20240124185403.1104141-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For msg_pop sk_msg helpers we only have older tests in test_sockmap, but
these are showing their age. They don't use any of the newer style BPF
and also require running test_sockmap. Lets use the prog_test framework
and add a test for msg_pop.

This is a much nicer test env using newer style BPF. We can
extend this to support all the other helpers shortly.

The bpf program is a template that lets us run through all the helpers
so we can cover not just pop, but all the other helpers as well.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 .../bpf/prog_tests/sockmap_helpers.h          |  10 +
 .../bpf/prog_tests/sockmap_msg_helpers.c      | 210 ++++++++++++++++++
 .../bpf/progs/test_sockmap_msg_helpers.c      |  52 +++++
 3 files changed, 272 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index e880f97bc44d..781cbdf01d7b 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -112,6 +112,16 @@
 		__ret;                                                         \
 	})
 
+#define xrecv_nonblock(fd, buf, len, flags)                                    \
+	({                                                                     \
+		ssize_t __ret = recv_timeout((fd), (buf), (len), (flags),      \
+					     IO_TIMEOUT_SEC);                  \
+		if (__ret == -1)                                               \
+			FAIL_ERRNO("recv");                                    \
+		__ret;                                                         \
+	})
+
+
 #define xsocket(family, sotype, flags)                                         \
 	({                                                                     \
 		int __ret = socket(family, sotype, flags);                     \
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
new file mode 100644
index 000000000000..9ffe02f45808
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Cloudflare
+#include <error.h>
+#include <netinet/tcp.h>
+#include <sys/epoll.h>
+
+#include "test_progs.h"
+#include "test_sockmap_msg_helpers.skel.h"
+#include "sockmap_helpers.h"
+
+#define TCP_REPAIR		19	/* TCP sock is under repair right now */
+
+#define TCP_REPAIR_ON		1
+#define TCP_REPAIR_OFF_NO_WP	-1	/* Turn off without window probes */
+
+struct msg_test_opts {
+	struct test_sockmap_msg_helpers *skel;
+	int server;
+	int client;
+};
+
+#define POP_END -1
+
+static void pop_simple_send(struct msg_test_opts *opts, int start, int len)
+{
+	struct test_sockmap_msg_helpers *skel = opts->skel;
+	char buf[] = "abcdefghijklmnopqrstuvwxyz";
+	char recvbuf[sizeof(buf)];
+	size_t sent, recv, cmp;
+
+	skel->bss->pop = true;
+
+	if (start == -1)
+		start = sizeof(buf) - len - 1;
+
+	skel->bss->pop_start = start;
+	skel->bss->pop_len = len;
+
+	sent = xsend(opts->client, buf, sizeof(buf), 0);
+	if (sent < sizeof(buf))
+		FAIL("xsend failed");
+
+	ASSERT_OK(skel->bss->err, "pop error");
+
+	recv = xrecv_nonblock(opts->server, recvbuf, sizeof(buf), 0);
+	if (recv != sent - skel->bss->pop_len)
+		FAIL("Received incorrect number number of bytes after pop");
+
+	cmp = memcmp(&buf[0], &recvbuf[0], start);
+	ASSERT_OK(cmp, "pop cmp start bytes failed");
+	cmp = memcmp(&buf[start+len], &recvbuf[start], sizeof(buf) - start - len);
+	ASSERT_OK(cmp, "pop cmp end bytes failed");
+}
+
+static void test_sockmap_pop(void)
+{
+	struct msg_test_opts opts;
+	struct test_sockmap_msg_helpers *skel;
+	int s, client, server;
+	int err, map, prog;
+
+	skel = test_sockmap_msg_helpers__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	map = bpf_map__fd(skel->maps.sock_map);
+	prog = bpf_program__fd(skel->progs.msg_helpers);
+	err = bpf_prog_attach(prog, map, BPF_SK_MSG_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	s = socket_loopback(AF_INET, SOCK_STREAM);
+	if (s < 0)
+		goto out;
+
+	err = create_pair(s, AF_INET, SOCK_STREAM, &client, &server);
+	if (err < 0)
+		goto close_loopback;
+
+	err = add_to_sockmap(map, client, server);
+	if (err < 0)
+		goto close_sockets;
+
+	opts.client = client;
+	opts.server = server;
+	opts.skel = skel;
+
+	/* Pop from start */
+	pop_simple_send(&opts, 0, 5);
+	/* Pop from the middle */
+	pop_simple_send(&opts, 10, 5);
+	/* Pop from end */
+	pop_simple_send(&opts, POP_END, 5);
+
+close_sockets:
+	close(client);
+	close(server);
+close_loopback:
+	close(s);
+out:
+	test_sockmap_msg_helpers__destroy(skel);
+}
+
+static void test_sockmap_pop_errors(void)
+{
+	char buf[] = "abcdefghijklmnopqrstuvwxyz";
+	struct test_sockmap_msg_helpers *skel;
+	int i, recv, err, map, prog;
+	char recvbuf[sizeof(buf)];
+	int s, client, server;
+
+	skel = test_sockmap_msg_helpers__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	map = bpf_map__fd(skel->maps.sock_map);
+	prog = bpf_program__fd(skel->progs.msg_helpers);
+	err = bpf_prog_attach(prog, map, BPF_SK_MSG_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	s = socket_loopback(AF_INET, SOCK_STREAM);
+	if (s < 0)
+		goto out;
+
+	err = create_pair(s, AF_INET, SOCK_STREAM, &client, &server);
+	if (err < 0)
+		goto close_loopback;
+
+	err = add_to_sockmap(map, client, server);
+	if (err < 0)
+		goto close_sockets;
+
+	skel->bss->pop = true;
+
+	/* Pop larger than buffer */
+	skel->bss->pop_start = 0;
+	skel->bss->pop_len = sizeof(buf) + 1;
+	xsend(client, buf, sizeof(buf), 0);
+	ASSERT_ERR(skel->bss->err, "popping more bytes than msg did not throw an error");
+	xrecv_nonblock(server, recvbuf, sizeof(recvbuf), 0);
+
+	/* Pop past end of buffer */
+	skel->bss->pop_start = sizeof(buf) - 5;
+	skel->bss->pop_len = 10;
+	xsend(client, buf, sizeof(buf), 0);
+	ASSERT_ERR(skel->bss->err, "popping past end of msg did not throw an error");
+	xrecv_nonblock(server, recvbuf, sizeof(recvbuf), 0);
+
+	/* Pop larger than buffer on complex send */
+	skel->bss->pop_start = 0;
+	skel->bss->pop_len = 0;
+	for (i = 0; i < 14; i++)
+		xsend(client, buf, sizeof(buf), MSG_MORE);
+	skel->bss->pop_start = 0;
+	skel->bss->pop_len = sizeof(buf) * 32;
+	xsend(client, buf, sizeof(buf), MSG_MORE);
+	ASSERT_ERR(skel->bss->err, "popping more bytes than sg msg did not throw an error");
+	i = 0;
+	do {
+		i++;
+		recv = xrecv_nonblock(server, recvbuf, sizeof(recvbuf), 0);
+	} while (recv > 0 && i < 15);
+
+	/* Pop past end of complex send */
+	skel->bss->pop_start = 0;
+	skel->bss->pop_len = 0;
+	for (i = 0; i < 14; i++)
+		xsend(client, buf, sizeof(buf), MSG_MORE);
+	skel->bss->pop_start = sizeof(buf) * 14;
+	skel->bss->pop_len = sizeof(buf) + 1;
+	xsend(client, buf, sizeof(buf), MSG_MORE);
+	ASSERT_ERR(skel->bss->err, "popping past end of sg msg did not throw an error");
+	i = 0;
+	do {
+		i++;
+		recv = xrecv_nonblock(server, recvbuf, sizeof(recvbuf), 0);
+	} while (recv > 0 && i < 15);
+
+	/* Pop past end of complex send starting in middle of last sg */
+	skel->bss->pop_start = 0;
+	skel->bss->pop_len = 0;
+	for (i = 0; i < 14; i++)
+		xsend(client, buf, sizeof(buf), MSG_MORE);
+	skel->bss->pop_start = (sizeof(buf) * 14) + sizeof(buf) - 5;
+	skel->bss->pop_len = 10;
+	xsend(client, buf, sizeof(buf), MSG_MORE);
+	ASSERT_ERR(skel->bss->err, "popping past end from offset of sg msg did not throw an error");
+	i = 0;
+	do {
+		i++;
+		recv = xrecv_nonblock(server, recvbuf, sizeof(recvbuf), 0);
+	} while (recv > 0 && i < 15);
+
+close_sockets:
+	close(client);
+	close(server);
+close_loopback:
+	close(s);
+out:
+	test_sockmap_msg_helpers__destroy(skel);
+}
+
+void test_sockmap_msg_helpers(void)
+{
+	if (test__start_subtest("sockmap pop"))
+		test_sockmap_pop();
+	if (test__start_subtest("sockmap pop errors"))
+		test_sockmap_pop_errors();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c b/tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c
new file mode 100644
index 000000000000..c721a00b6001
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Cloudflare
+
+#include <errno.h>
+#include <stdbool.h>
+#include <linux/bpf.h>
+
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 2);
+	__type(key, __u32);
+	__type(value, __u64);
+} sock_map SEC(".maps");
+
+int cork = 0;
+
+bool pull = false;
+bool push = false;
+bool pop = false;
+
+int pull_start = 0;
+int pull_end = 0;
+
+int push_start = 0;
+int push_end = 0;
+
+int pop_start = 0;
+int pop_len = 0;
+
+int err;
+
+SEC("sk_msg")
+int msg_helpers(struct sk_msg_md *msg)
+{
+	if (cork)
+		err = bpf_msg_cork_bytes(msg, cork);
+
+	if (pull)
+		err = bpf_msg_pull_data(msg, pull_start, pull_end, 0);
+
+	if (push)
+		err = bpf_msg_push_data(msg, push_start, push_end, 0);
+
+	if (pop)
+		err = bpf_msg_pop_data(msg, pop_start, pop_len, 0);
+
+	return SK_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.33.0


