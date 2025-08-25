Return-Path: <bpf+bounces-66456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16ECB34C4B
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 22:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3158E1738ED
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 20:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152BA304BC8;
	Mon, 25 Aug 2025 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l1ah9tOJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6033009F6
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154535; cv=none; b=T/Zm5nyK9BXLG6qMyI1ahJbhsjl6IchGeqpDlJOaOT8Zmb8+Qonf/04I9BDXQdHbzLR3bPKI/fHokTxX2sGmjp9hKqMi7Ntz/rOMqVfj67Qb59MWBqh5DyarGi1wPGWHRUXif8Tt5c9/CkCZVOT1E5p0ZDbnvGGRf/ofbxy7fbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154535; c=relaxed/simple;
	bh=We2VWSLZ7KScG5KJvhPKGwZp2lJAodATPsUe9LXmRzc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GAn2fQFuHyRmEYFxqxnGvDjee8/+ryVynvYVd4hoK4u1SG2C9KyGk0XOQQVpCjqpZa8D35SQsbePTdTSpMHknxswB6z1b2JOEpb+1ASz0z6LAoAARZ7PwT+Ddl87MpE5icduouudMn3aaEiGSQI8A/1iPQVfCC7VOv90+hPDbMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l1ah9tOJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2464dc09769so73162955ad.0
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 13:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756154533; x=1756759333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GHQoOZdA4txyBFUPMj7jPIG1cuPTm44XKvXJIPVPLKs=;
        b=l1ah9tOJUpmO7kYxUrbss/liqJaDdg83zHu8j4XAuKHCYBejSdH0ExAPYZQ0YDs2Xc
         HTTnPNSlaTeapKQ7l5UqoQbaYx6y1Zb3OUiU32tFpHYFkDHG95svEUaB+f8nai2MuJHi
         7GU59CFf1sEvp64DmK4jp4+77BZTTaEDzwTOHg7jtGzXp7/rYoICL+0SfKcCNTRzs7aG
         oTMJL1BgkKLy513LVQ39JZb4AxisOijQZpdcL3rB6ou5vhSrSTz1zLXm/npHokbvmy7N
         5UlbIXhupkV8gfzoZqxnGjDeaGfgmnP1ty5Cb9p0DGKyVk5xCDqH1FvNFNXTR90QVvZs
         fCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756154533; x=1756759333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHQoOZdA4txyBFUPMj7jPIG1cuPTm44XKvXJIPVPLKs=;
        b=OfNaq/uQc/PL4EyfSBJmcq4jqy/ThyCCal0Es++c66RA67CxVqGiJrgQ4xfBwzRyLx
         ZZCP18Xoi0LTUPtDoyNrE+84SBrEcUMGiiFtDa6Klm03EiGaUFjBQyog4EwassrdG1QJ
         41l/rC4x3dkZXX0b6G9sO9OC5YH/QLFDDk4ZIgpnLyxSE193QLPQuN72Ioh9N4fjlS4b
         dR+MTjUG0SIZIJMtwA5H1MJKIWCl4gJ9fWzN01wi7GdqpT2OduSc0eyx1Yr16mdLV+kS
         o56QRkJYc7FdC64PLVmR7FR3FjrLxrTMbZhPB+A069bqaFUPSqkoWSgQIzJpHwgNTP5F
         sTpg==
X-Forwarded-Encrypted: i=1; AJvYcCWPy9MX/HShslM91vh+q6BtKyk/QpE9Pf/Bo3hK7tiLGqgWPrTovbIaXB63uufrhMJqGKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIp7HeW/y5e2jgKj6YnWW5qrJRIM9+9cZxw6bp1Mhn5E24gx36
	WbXj+M93791Rth9twovavyMkzyN8Jm2wnIAg590RJ2dw4VKUxeP1QVOxWAJrg4+VkEIEO0uopgd
	LEoP3hg==
X-Google-Smtp-Source: AGHT+IHt3UBeME9oYTVRGeRMPP76FpcbZZf4L92MxpjaV0vadDgxF3aj9dIaUhyXNn7Z3W3+C5xwaRwWC4c=
X-Received: from pldp2.prod.google.com ([2002:a17:902:eac2:b0:245:f002:d659])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c40f:b0:244:99aa:54a1
 with SMTP id d9443c01a7336-2462ee0b77emr186465385ad.7.1756154533300; Mon, 25
 Aug 2025 13:42:13 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:41:31 +0000
In-Reply-To: <20250825204158.2414402-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825204158.2414402-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825204158.2414402-9-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 8/8] selftest: bpf: Add test for SK_BPF_MEMCG_SOCK_ISOLATED.
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
 tools/testing/selftests/bpf/progs/sk_memcg.c  |  29 +++
 2 files changed, 247 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_memcg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_memcg.c b/tools/testing/selftests/bpf/prog_tests/sk_memcg.c
new file mode 100644
index 000000000000..053b833cdc27
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
2.51.0.261.g7ce5a0a67e-goog


