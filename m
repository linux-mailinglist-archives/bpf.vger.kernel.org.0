Return-Path: <bpf+bounces-20135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD5C839C56
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 23:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19451C25D5B
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 22:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4083C53819;
	Tue, 23 Jan 2024 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3qtSRE8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4FF537E9;
	Tue, 23 Jan 2024 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049380; cv=none; b=sWF9wiFK5a3VhicNF/v1loe91MRTYy3DMVgb/aJiubpFjLj8NlNDAmYuPxukDvksrYLCOjnV4aOQwRspycNYp7G3Q/lSRa6Etj6JXwolV63wjJSb8LCYMXuyho5CL74aSegkK1h4w76JPI1+VQThbNX8x7Hax3So4KEWvnZENKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049380; c=relaxed/simple;
	bh=QSdmgz24hsXghzwu1g2Hb9eTf72nhtTudAlKinSjZrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tv8MRAdfMg01B7YxhpaXHK/bJ4I4bNj0J7gNFuKeCrl6uxodcS6l+NzYEUXuMgXlQVoxvltKjLN7UiC6Kblz669z7KoBFr64YkLJfA+cM3XPjwB7oIQVjMN0I8gB1ArTJ/i+ah/WObtEKaz/4beAx9oLpJS+z2qtiVX5xmmsRNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3qtSRE8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d76943baafso14165205ad.2;
        Tue, 23 Jan 2024 14:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706049377; x=1706654177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqDQo5sbKkbIdJoD5mE0BCooUO2QiAeTYNwUjxSUraw=;
        b=C3qtSRE8zCQRE44zfpU+XUa422PGMU13oJ0OOWU25CiotE8W/SX3irefPeDsJ1M3e9
         hOpP0Cv5ZKrhgVVIxTEhIsBu4mHiX8kno1mAEEudUj4EcuSeFJ/q16T32aCjv+10g+cJ
         t0DpaI3FWhaAUrcJAWDP6FSEeTfHGgFU9FHsghsxDUpB2gUGXYU6pWbkv0QkmadPpbJc
         ek9Ypmk2o5aRJzjQ68YzT6l89UeZU1X9I8ewwQi+LLZ0zbwY8FVDDnoFevTOjy7HlkoR
         HdoLKpLMmKVtYWmhdpy5PCYusy8Zk0Tajpqx80cjZnHhmOO0V/uFMuWwsG0xi3hZE/z7
         L9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706049377; x=1706654177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqDQo5sbKkbIdJoD5mE0BCooUO2QiAeTYNwUjxSUraw=;
        b=bdkMhflAQHPCqCCTxy3JnKV70xCsExw93X8UidEZR2DoWm+0sPfvkQG1Axj7bAG0/H
         RQYJqZrR8iyto1gCOuRZCtgo3l206jsc2Y24viItZbBGe62Oc/6vVOOgD7A5MXHFdZbo
         XzJEa21TKfcAKeMs2H+dwdlPXgYFwQlEbxvlTkrXvdaPxysSPHXeaGaq6tBrGGFRo60H
         aDzbOYnm/dM/zqbJAotLujb4A8+ww5+t9/lnaLzfqhKMask+rq2M5/emRF+LZa9EQntd
         E+m5/akc2uWBIXa4GiOuFUC4LpXPGI4zQmpKNw43OHmqIo5DGRitM+DRMpp+GWXYSHek
         wHZQ==
X-Gm-Message-State: AOJu0Yz1HkG5Hun7ZV0EaWQDS4q7/WR+fRCJkLOSzW1IfHX/g6M9BDCc
	WYq0cbYoki/eeY3G/KmqUmHhKH8frN6zX4cnRMUhRjd4w3GDanU3+rrCJYv1
X-Google-Smtp-Source: AGHT+IEy/TuZ4wT4xCd3W+KWN4YBN96pqN2h8k7BskkiybeE/0CQvsx4oLPrhr2WVvaOYdv4OAWXIg==
X-Received: by 2002:a17:902:f551:b0:1d7:4670:ffb0 with SMTP id h17-20020a170902f55100b001d74670ffb0mr4050741plf.9.1706049377262;
        Tue, 23 Jan 2024 14:36:17 -0800 (PST)
Received: from john.. ([98.97.113.214])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902e04900b001d73f1fbdd9sm4875241plx.154.2024.01.23.14.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 14:36:15 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: netdev@vger.kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 1/4] bpf: sockmap, add test for sk_msg prog pop msg helper
Date: Tue, 23 Jan 2024 14:36:09 -0800
Message-Id: <20240123223612.1015788-2-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240123223612.1015788-1-john.fastabend@gmail.com>
References: <20240123223612.1015788-1-john.fastabend@gmail.com>
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
index 000000000000..0fe3172a6c43
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
+		goto close_sockets;
+
+	err = create_pair(s, AF_INET, SOCK_STREAM, &client, &server);
+	if (err < 0)
+		goto close_loopback;
+
+	err = add_to_sockmap(map, client, server);
+	if (err < 0)
+		FAIL("add to sockmap");
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
+		goto close_sockets;
+
+	err = create_pair(s, AF_INET, SOCK_STREAM, &client, &server);
+	if (err < 0)
+		goto close_loopback;
+
+	err = add_to_sockmap(map, client, server);
+	if (err < 0)
+		FAIL("add to sockmap");
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


