Return-Path: <bpf+bounces-66586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95433B37266
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 20:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CECEE8E3EDB
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236BE374279;
	Tue, 26 Aug 2025 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BX/9Ffrk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA843728B0
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233615; cv=none; b=MNk3sC908TpqLT+DIXCwKU6Ya6FYWdKiBXjK/HcwtDkuaOD7TY3+fLjXdyiJVdSd6oLVJP2e4WOUA34cns/tjQy2ECd1DODmt8RIpR0p2FEjRYZg/+4kpfDEzJrCfiEBYs4KxpYBQFYaptMvAlfisUfjMxJXMWM+HyPPzdHeTEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233615; c=relaxed/simple;
	bh=BXYiPxj4tg6DpWIw9uOj7AXESGYFviEJhKnYPOxQtZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OS0z38MSmovSjSM/xkzyGUQfU1RXpZCrbMDmdK2OLq1tE/l/uL658xGswRYNpg2NKDkzRmSImEnu7x97XbSewd0fnXkfxniyIS7COswqobHtMBbBlGEp9RILnoTjdRKJYtbruKteO1wl8z5QiG0ZG2+uDKqKw0wt/HzdXled4qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BX/9Ffrk; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2445803f0cfso65098095ad.1
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 11:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756233613; x=1756838413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PTLc5BiDS4A7GuBlvCw7BSfPe8a8YQsL7U8ppEKoLxQ=;
        b=BX/9FfrkmKOPSZxWM2LclB3L3ypQWbvn6y7ZArZ9ySTducbo19tsKZULz3ywgXXvVw
         zt86PTzezGKUosHUiQjAF03WTcVjntfwW0YuA4LMh/x9D5oxhaeUcVRTnWWfPzqgf5aW
         trCmb1FyR97SgGHZIr+PhxufJHN2D8AL6UhgzQQ0uEGAhKWIC/jEmxI59t/D03k44bBk
         4ZkBuhSiDDn8mS1gKgX50PZhSJXddeCYPSKBxKLRcgK670L5MjcS0wvhXNth6rQq+Dyw
         Tmhc39NvGtnqZAAmdjFCgxHuGG0RUKVdKm4yLvO9vQ3yCuBnQ284umG0Y5ARwvYIOjrv
         Rb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756233613; x=1756838413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTLc5BiDS4A7GuBlvCw7BSfPe8a8YQsL7U8ppEKoLxQ=;
        b=BcAGCMGfYA47OKGIIXZIyJee98sOe9jd2q+DBr9/1PVDFug2PxbO1SuxJsr2s4ZyT1
         1/P9AxFpU+LKsoBmiKThrbNhxyZf0x6EcWOqDFJchnDUmKC6szm2u7LKukWJomiLai35
         oGyKy8Jq3dPDjiM/noTEoG/Cz5V9f0sNZ2X5Ul+++CvS3GYNjlL5P4WemDgtuGzz4wPg
         8/q/9Y+wLF7mPJ2QFuf7rY9s+hQ0sX+KYOtpFmer1z+ng9oXVz7kRLWp6pGsiEFkEp/Q
         3xJTYupsGy2YAVowdAIQesIO/+06YKj0Beyj0MSJNU+zB4gpyc8bvTsJzlgDZ3ZWV7E0
         JdpA==
X-Forwarded-Encrypted: i=1; AJvYcCXc4KMOi9dTbMDlpTScCID18I3+037rBLy1ZjR4G8zojZajZynoZz75N889PIoz/6HEuIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjwiOt19HiF9S/UaND6inX7+ja/6e9ECUFjOoqbMkTQA2qlquV
	uPgeCtV7ckXiJXhnsTswv+xUHlNav1GHZcA2tFZzFDKh1j4NF6P92vsy/dMlnHxpHbQXFDgr3pa
	vEN+RLQ==
X-Google-Smtp-Source: AGHT+IFbc2+EkGeU3Rv4PhQiRWPRWYIKDFhEZYcvMsgpp5MhPuLbseQ2/uvUTGZCdzg/vVacE1kSVuHhySw=
X-Received: from pjbsp15.prod.google.com ([2002:a17:90b:52cf:b0:30a:7da4:f075])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d512:b0:248:95cd:525b
 with SMTP id d9443c01a7336-24895cd5bdamr3925205ad.48.1756233612784; Tue, 26
 Aug 2025 11:40:12 -0700 (PDT)
Date: Tue, 26 Aug 2025 18:38:11 +0000
In-Reply-To: <20250826183940.3310118-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826183940.3310118-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250826183940.3310118-6-kuniyu@google.com>
Subject: [PATCH v3 bpf-next/net 5/5] selftest: bpf: Add test for SK_BPF_MEMCG_SOCK_ISOLATED.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The test does the following for IPv4/IPv6 x TCP/UDP sockets
with/without BPF prog.

  1. Create socket pairs
  2. Send a bunch of data that require more than 1000 pages
  3. Read memory_allocated from the 3rd column in /proc/net/protocols
  4. Check if unread data is charged to memory_allocated

If BPF prog is attached, memory_allocated should not be changed,
but we allow a small error (up to 10 pages) in case the test is ran
concurrently with other tests using TCP/UDP sockets.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../selftests/bpf/prog_tests/sk_memcg.c       | 218 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/sk_memcg.c  |  30 +++
 2 files changed, 248 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_memcg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_memcg.c b/tools/testing/selftests/bpf/prog_tests/sk_memcg.c
new file mode 100644
index 000000000000..a45dc30c5ab4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sk_memcg.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2025 Google LLC */
+
+#include <test_progs.h>
+#include "sk_memcg.skel.h"
+#include "network_helpers.h"
+
+#define NR_SOCKETS	128
+#define NR_SEND		128
+#define BUF_SINGLE	1024
+#define BUF_TOTAL	(BUF_SINGLE * NR_SEND)
+
+struct test_case {
+	char name[10]; /* protocols (%-9s) in /proc/net/protocols, see proto_seq_printf(). */
+	int family;
+	int type;
+	int (*create_sockets)(struct test_case *test_case, int sk[], int len);
+};
+
+static int tcp_create_sockets(struct test_case *test_case, int sk[], int len)
+{
+	int server, i;
+
+	server = start_server(test_case->family, test_case->type, NULL, 0, 0);
+	ASSERT_GE(server, 0, "start_server_str");
+
+	for (i = 0; i < len / 2; i++) {
+		sk[i * 2] = connect_to_fd(server, 0);
+		if (!ASSERT_GE(sk[i * 2], 0, "connect_to_fd"))
+			return sk[i * 2];
+
+		sk[i * 2 + 1] = accept(server, NULL, NULL);
+		if (!ASSERT_GE(sk[i * 2 + 1], 0, "accept"))
+			return sk[i * 2 + 1];
+	}
+
+	close(server);
+
+	return 0;
+}
+
+static int udp_create_sockets(struct test_case *test_case, int sk[], int len)
+{
+	int i, err, rcvbuf = BUF_TOTAL;
+
+	for (i = 0; i < len / 2; i++) {
+		sk[i * 2] = start_server(test_case->family, test_case->type, NULL, 0, 0);
+		if (!ASSERT_GE(sk[i * 2], 0, "start_server"))
+			return sk[i * 2];
+
+		sk[i * 2 + 1] = connect_to_fd(sk[i * 2], 0);
+		if (!ASSERT_GE(sk[i * 2 + 1], 0, "connect_to_fd"))
+			return sk[i * 2 + 1];
+
+		err = connect_fd_to_fd(sk[i * 2], sk[i * 2 + 1], 0);
+		if (!ASSERT_EQ(err, 0, "connect_fd_to_fd"))
+			return err;
+
+		err = setsockopt(sk[i * 2], SOL_SOCKET, SO_RCVBUF, &rcvbuf, sizeof(int));
+		if (!ASSERT_EQ(err, 0, "setsockopt(SO_RCVBUF)"))
+			return err;
+
+		err = setsockopt(sk[i * 2 + 1], SOL_SOCKET, SO_RCVBUF, &rcvbuf, sizeof(int));
+		if (!ASSERT_EQ(err, 0, "setsockopt(SO_RCVBUF)"))
+			return err;
+	}
+
+	return 0;
+}
+
+static int get_memory_allocated(struct test_case *test_case)
+{
+	long memory_allocated = -1;
+	char *line = NULL;
+	size_t unused;
+	FILE *f;
+
+	f = fopen("/proc/net/protocols", "r");
+	if (!ASSERT_OK_PTR(f, "fopen"))
+		goto out;
+
+	while (getline(&line, &unused, f) != -1) {
+		unsigned int unused_0;
+		int unused_1;
+		int ret;
+
+		if (strncmp(line, test_case->name, sizeof(test_case->name)))
+			continue;
+
+		ret = sscanf(line + sizeof(test_case->name), "%4u %6d  %6ld",
+			     &unused_0, &unused_1, &memory_allocated);
+		ASSERT_EQ(ret, 3, "sscanf");
+		break;
+	}
+
+	ASSERT_NEQ(memory_allocated, -1, "get_memory_allocated");
+
+	free(line);
+	fclose(f);
+out:
+	return memory_allocated;
+}
+
+static int check_isolated(struct test_case *test_case, bool isolated)
+{
+	char buf[BUF_SINGLE] = {};
+	long memory_allocated[2];
+	int sk[NR_SOCKETS] = {};
+	int err = -1, i, j;
+
+	memory_allocated[0] = get_memory_allocated(test_case);
+	if (!ASSERT_GE(memory_allocated[0], 0, "memory_allocated[0]"))
+		goto out;
+
+	err = test_case->create_sockets(test_case, sk, ARRAY_SIZE(sk));
+	if (err)
+		goto close;
+
+	/* Must allocate pages >= net.core.mem_pcpu_rsv */
+	for (i = 0; i < ARRAY_SIZE(sk); i++) {
+		for (j = 0; j < NR_SEND; j++) {
+			int bytes = send(sk[i], buf, sizeof(buf), 0);
+
+			/* Avoid too noisy logs when something failed. */
+			if (bytes != sizeof(buf))
+				ASSERT_EQ(bytes, sizeof(buf), "send");
+		}
+	}
+
+	memory_allocated[1] = get_memory_allocated(test_case);
+	if (!ASSERT_GE(memory_allocated[1], 0, "memory_allocated[1]"))
+		goto close;
+
+	if (isolated)
+		ASSERT_LE(memory_allocated[1], memory_allocated[0] + 10, "isolated");
+	else
+		ASSERT_GT(memory_allocated[1], memory_allocated[0] + 1000, "not isolated");
+
+close:
+	for (i = 0; i < ARRAY_SIZE(sk); i++)
+		close(sk[i]);
+
+	/* Let RCU destruct sockets */
+	sleep(1);
+out:
+	return err;
+}
+
+void run_test(struct test_case *test_case)
+{
+	struct sk_memcg *skel;
+	int cgroup, err;
+
+	skel = sk_memcg__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	cgroup = test__join_cgroup("/sk_memcg");
+	if (!ASSERT_GE(cgroup, 0, "join_cgroup"))
+		goto destroy_skel;
+
+	err = check_isolated(test_case, false);
+	if (!ASSERT_EQ(err, 0, "test_isolated(false)"))
+		goto close_cgroup;
+
+	skel->links.sock_create = bpf_program__attach_cgroup(skel->progs.sock_create, cgroup);
+	if (!ASSERT_OK_PTR(skel->links.sock_create, "attach_cgroup(sock_create)"))
+		goto close_cgroup;
+
+	skel->links.skops_setsockopt = bpf_program__attach_cgroup(skel->progs.skops_setsockopt, cgroup);
+	if (!ASSERT_OK_PTR(skel->links.skops_setsockopt, "attach_cgroup(skops_setsockopt)"))
+		goto close_cgroup;
+
+	err = check_isolated(test_case, true);
+	ASSERT_EQ(err, 0, "test_isolated(false)");
+
+close_cgroup:
+	close(cgroup);
+destroy_skel:
+	sk_memcg__destroy(skel);
+}
+
+struct test_case test_cases[] = {
+	{
+		.name = "TCP       ",
+		.family = AF_INET,
+		.type = SOCK_STREAM,
+		.create_sockets = tcp_create_sockets,
+	},
+	{
+		.name = "UDP       ",
+		.family = AF_INET,
+		.type = SOCK_DGRAM,
+		.create_sockets = udp_create_sockets,
+	},
+	{
+		.name = "TCPv6     ",
+		.family = AF_INET6,
+		.type = SOCK_STREAM,
+		.create_sockets = tcp_create_sockets,
+	},
+	{
+		.name = "UDPv6     ",
+		.family = AF_INET6,
+		.type = SOCK_DGRAM,
+		.create_sockets = udp_create_sockets,
+	},
+};
+
+void test_sk_memcg(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
+		test__start_subtest(test_cases[i].name);
+		run_test(&test_cases[i]);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/sk_memcg.c b/tools/testing/selftests/bpf/progs/sk_memcg.c
new file mode 100644
index 000000000000..1b0ea991099d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sk_memcg.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2025 Google LLC */
+
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+
+void isolate_memcg(void *ctx)
+{
+	int flags = SK_BPF_MEMCG_SOCK_ISOLATED;
+
+	bpf_setsockopt(ctx, SOL_SOCKET, SK_BPF_MEMCG_FLAGS,
+		       &flags, sizeof(flags));
+}
+
+SEC("cgroup/sock_create")
+int sock_create(struct bpf_sock *ctx)
+{
+	isolate_memcg(ctx);
+	return 1;
+}
+
+SEC("sockops")
+int skops_setsockopt(struct bpf_sock_ops *skops)
+{
+	if (skops->op == BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
+		isolate_memcg(skops);
+	return 1;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.51.0.318.gd7df087d1a-goog


