Return-Path: <bpf+bounces-66324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9652CB32501
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66AED1887F83
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 22:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1710C313550;
	Fri, 22 Aug 2025 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g227RrXn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E56302747
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755901143; cv=none; b=H+Ws6ktUbgrgl/qOXnrawQSWjmhwnQ9k8K8ga8STL/yw9yUyokwIdhNpq1v+p277jG2m94SgMot96ycVEKfIc2G7/6fbvC6qWvRUW6DlTPcqz8C8efQ9e9uXRhRrU/Ijc8VzFQIGGHIKEy+XJ2j8yhpE0SF1wL+g5g79B1XtmD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755901143; c=relaxed/simple;
	bh=fF0tcGk/Q5jLq4iBgfLzLpdJo/KhVvdeIYH1F4qLZik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nkM6ieZajOFnNRh5jg43k155wJZJrFIUMdt7WYVWDO3BQfTTIDaITnuo7WuiiUkpxDK75rxjlq6OX3QeExCMH1+yZy9Gccds+Mqm1siF80wsmPlaDqaglrVW30ny4sWnjeNv8bO1KLRYUhYrJcvesg5Ot8LvQ0gh0YrJ42wx6ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g227RrXn; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581ce388so55928475ad.2
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 15:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755901141; x=1756505941; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLGbZ1zUyhdUdP5HKrHdHonbPASOGZvy2+MP5vV9+Lk=;
        b=g227RrXnHYKpF8kgrGm2ohcCKvsLerGIEv9rEPfUPcIfdAi/WH0QAXhghUyzGYl9kc
         QnltNhu1mpdKYAn0aD95Z+Vj4437g/gtXs93mMnbdMtMTzvSbvpItGhjrJZXqa5CNU/i
         o7du2HP74tm7DmUKx1NLLIEP57QKRNBkmNBemCKatxxsTA1gVxpOyRx79qnzQR6dPNZC
         6Dn8ydBn2wwxzYykldVvknKIh4YMcX5vACI7fIxRjfPsloZPQMuZwlwCNbTYbCD9jRR7
         fFX6QH6OMqCy9UyIYpP1A0A8hE+n+KWtfisqkAZsw2hcYnApUWUUmJK8o4Fr/mKc7AGA
         FuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755901141; x=1756505941;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLGbZ1zUyhdUdP5HKrHdHonbPASOGZvy2+MP5vV9+Lk=;
        b=F4U4K2O4bTgTWePx9w5jX0o9LMNPzkWPqZ3zaJXfhXOhE/0M8MWUYw7lImfO5AqZxC
         YB/8xbBn2uKV4iekle6NTE77jlK8bE/xCKC/YjybZUTPhaEp/pVvWqSBwP91GSoWkorH
         Mkb0FyIoTOwi0GaBVTRHR1a6h3KncmxwNKAzGyr38IxarKvkdzYsSiLKMV0mnk4wQn7T
         KmzdikNox1jPSc4vh3+5okZDwfb8p9bu31oKDgC+nRpm2TJgYEuvdlHn7Hz3YfPyAP3K
         sLwQzYzkrBpVrfD6pfEQ2qy6NmmPGaqV9v9gMUU4uUIUCXiK8mJQ18pPeuW0bnyFEnWT
         S6OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoGZk+EjD0hwtjU0TGJFkBgqwjEeWei6+zsiJP3xZyjYr0cIpoxdp/YUMjRewwPA9go3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/jZ3X02ME4LHv/3LP1zJdWiZE0Tf0BA5E6OAuzh2hjwsB2lEu
	/rIWVT0aXtaADW1/S0MTbKqgspO70ec+nqRt7g8m8LwuLKTKxAFHnjOrH/2L8MrgSk2WA2XbCQF
	9LefQZg==
X-Google-Smtp-Source: AGHT+IFy5kEfiWW0LyzxCAytfgyR+wOKWYkUJhbIKW09qWQsUhSQecd62glK5OfFguhfP5MHNEy4kqj5RM4=
X-Received: from plaq19.prod.google.com ([2002:a17:903:2053:b0:23f:fd13:e74d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce81:b0:246:6446:8ae1
 with SMTP id d9443c01a7336-2466446a05cmr22921575ad.19.1755901141454; Fri, 22
 Aug 2025 15:19:01 -0700 (PDT)
Date: Fri, 22 Aug 2025 22:18:03 +0000
In-Reply-To: <20250822221846.744252-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822221846.744252-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822221846.744252-9-kuniyu@google.com>
Subject: [PATCH v1 bpf-next/net 8/8] selftest: bpf: Add test for SK_BPF_MEMCG_SOCK_ISOLATED.
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
 .../selftests/bpf/prog_tests/sk_memcg.c       | 214 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/sk_memcg.c  |  29 +++
 2 files changed, 243 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_memcg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_memcg.c b/tools/testing/selftests/bpf/prog_tests/sk_memcg.c
new file mode 100644
index 000000000000..486e58277eec
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sk_memcg.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2025 Google LLC */
+
+#include <test_progs.h>
+#include "sk_memcg.skel.h"
+#include "network_helpers.h"
+
+#define NR_SOCKETS	128
+#define NR_SEND		128
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
+	int i, err, rcvbuf = 1024 * NR_SEND;
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
+	long memory_allocated[2];
+	int sk[NR_SOCKETS] = {};
+	char buf[1024] = {};
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
+			ASSERT_EQ(bytes, sizeof(buf), "send");
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
+	skel->links.sock_accept = bpf_program__attach_cgroup(skel->progs.sock_accept, cgroup);
+	if (!ASSERT_OK_PTR(skel->links.sock_accept, "attach_cgroup(sock_accept)"))
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
index 000000000000..8a43e05be14b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sk_memcg.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2025 Google LLC */
+
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+
+void isolate_memcg(struct bpf_sock *ctx)
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
+SEC("cgroup/sock_accept")
+int sock_accept(struct bpf_sock *ctx)
+{
+	isolate_memcg(ctx);
+	return 1;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


