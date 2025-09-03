Return-Path: <bpf+bounces-67334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 381D1B4296C
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 21:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DDC16220D
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 19:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21B42D7809;
	Wed,  3 Sep 2025 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W9tNQLvs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BF2369338
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 19:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926171; cv=none; b=l8j45OW7Dgt5YdMUCjYlkkh5Tt8eNIYn6rp0LLQdg/A1cGJZ6F/7vLuMeLyL2aTIcgZM5+PevpacDvYJuB06Y5y6SZO4u2/9c7V8fwsISr1HEhMurVmP/1jytfxFfTie1i4maThppF38IAHhzu6o+n5hGoJITcpjMGDP37ahsvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926171; c=relaxed/simple;
	bh=gj6aYZ7KQ1aqhXUG3Ur52eLx4emNHQiYmnCTH+MCwmY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r+EH1v9197RwrUrNMGhLQBF0iXd7Sxqw1P+5QJGfzgdNk/LElLUWoU5KoLGER/OXaoOax086t/4/+E/wcOa7gHM0T8BII2B3emoa1vwlJdIho+vPfYi2dNzzTcsmkFQrA5XFvFeEx841whBuJTgmDktW0I4OyrJcff32Q/DpyiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W9tNQLvs; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4fb59a89acso130557a12.0
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 12:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756926169; x=1757530969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vzF4zJ5+F1zF9VaKrU/tXWM1tjtt/QoM4YGbOeZxyBQ=;
        b=W9tNQLvszgdha1+oynwM0f0mG5SfWdHZ6vDF/PC/rweDdDPDR5HtO+sEnLkAszTnH5
         upRvYOtvPiEw9Rp5XRjxtLdK8x/f7pSMyFyZPdULuqHTuLNyy7pZyQORUm2j5zhnVnE0
         OXSC9YV5GdTEYExRD8RmaWVV0FYBTC3IVB+6VErc6kynEhHASu4lihN+l7ZaRiFBdrnn
         WMWGwiB1XCjCl9+KPvj17dcE5FCaYB4ukMQ0PKE6Nl1VCs8l7sZZKFkktSAIDMNt38+i
         0cPndAN0TaG1K/4PmfoBfl4WLljD5sc45Fu2HEEHNh9quxnvuZcQRGvI4AzSe3ljJod3
         8T4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756926169; x=1757530969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzF4zJ5+F1zF9VaKrU/tXWM1tjtt/QoM4YGbOeZxyBQ=;
        b=RwH0vbumGErz8n6qLXSFQntpznZVbqkZoiC0B5XpVlYLpwYSPjQHlQ1OM4+wn4IVrV
         i3lbrE5zMHbuZbEFS+sYGzvz2biaOoNOsrCXI5sDhUPWHaH3RM4mqVrPf2dWNey/Jut4
         /kNi2NocO6+TmiZzvl07q2GNLDmnpsoDwC+xx/1kp4rIyC+lKzY7q4sXeHxtjKt8l7VO
         VDQTmT9ZEnBUSlvsQ1YXwg0XefPg0fjPtZZgVVtingfD++jNSyQ/oCo0DyCYjot1RVXs
         16v54PBOX5EnPpX6cYHmEE/m2GgPkD4i6TXyLnLuNQ85HsrCyJyXkow8YT6T/D/9xwBL
         axEA==
X-Forwarded-Encrypted: i=1; AJvYcCX18/h8Fy0nS2iPtnYmo5ytpYiToghL3cc2+jmRuoSPTAKOmxBZ5iAG4sVoUcdNOTDYfkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YywAbzM36qs/dd/549Txsve6+75FiYdghrn8glLj5ooAW+gRSWF
	4ZJLplPbYEcEb+dyC8TEyKwMcqzZaMmFodIrKlK8T6dtKcS+4jlpPVJjb4ag2zRHWKJ6DxU0jh9
	6vPKMNw==
X-Google-Smtp-Source: AGHT+IELOo2GRkjTPUTVgvOb0l9KOXwTyVVAAUseHJuaZjmTyh3t9jPNV7rbNRv+rNipdEvHh3NDb6TeoMw=
X-Received: from pjbsl11.prod.google.com ([2002:a17:90b:2e0b:b0:325:8e70:8d5e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d603:b0:311:b413:f5e1
 with SMTP id 98e67ed59e1d1-328156e4731mr19519055a91.32.1756926168800; Wed, 03
 Sep 2025 12:02:48 -0700 (PDT)
Date: Wed,  3 Sep 2025 19:02:04 +0000
In-Reply-To: <20250903190238.2511885-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250903190238.2511885-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903190238.2511885-6-kuniyu@google.com>
Subject: [PATCH v5 bpf-next/net 5/5] selftest: bpf: Add test for SK_BPF_MEMCG_SOCK_ISOLATED.
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
  2. Send a bunch of data that requires more than 256 pages
  3. Read memory_allocated from the 3rd column in /proc/net/protocols
  4. Check if unread data is charged to memory_allocated

If BPF prog is attached, memory_allocated should not be changed,
but we allow a small error (up to 10 pages) in case other processes
on the host use some amounts of TCP/UDP memory.

At 2., the test actually sends more than 1024 pages because the sysctl
net.core.mem_pcpu_rsv is 256 is by default, which means 256 pages are
buffered per cpu before reporting to sk->sk_prot->memory_allocated.

  BUF_SINGLE (1024) * NR_SEND (128) * NR_SOCKETS (64) / 4096
  = 2048 pages

When it's reduced to 1024 pages, the following assertion for the
non-isolated case got flaky.

  ASSERT_GT(memory_allocated[1], memory_allocated[0] + 256, ...)

We use kern_sync_rcu() for UDP because UDP recv queue is destroyed
after 1 RCU grace period.

The test takes ~0.5s on QEMU w/ KVM but takes 2s w/o KVM.

  # time ./test_progs -t sk_memcg
  #370/1   sk_memcg/TCP       :OK
  #370/2   sk_memcg/UDP       :OK
  #370/3   sk_memcg/TCPv6     :OK
  #370/4   sk_memcg/UDPv6     :OK
  #370     sk_memcg:OK
  Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

  real	0m0.473s
  user	0m0.009s
  sys	0m0.201s

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v5:
  * Use kern_sync_rcu()
  * Double NR_SEND to 128

v4:
  * Only use inet_create() hook
  * Test bpf_getsockopt()
  * Add serial_ prefix
  * Reduce sleep() and the amount of sent data
---
 .../selftests/bpf/prog_tests/sk_memcg.c       | 218 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/sk_memcg.c  |  38 +++
 2 files changed, 256 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_memcg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_memcg.c b/tools/testing/selftests/bpf/prog_tests/sk_memcg.c
new file mode 100644
index 000000000000..66bdff2d6ec7
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
+#define NR_SOCKETS	64
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
+	if (isolated) {
+		ASSERT_LE(memory_allocated[1], memory_allocated[0] + 10, "isolated");
+	} else {
+		/* By default, net.core.mem_pcpu_rsv == 256 pages */
+		ASSERT_GT(memory_allocated[1], memory_allocated[0] + 256, "not isolated");
+	}
+
+close:
+	for (i = 0; i < ARRAY_SIZE(sk); i++)
+		close(sk[i]);
+
+	if (test_case->type == SOCK_DGRAM) {
+		/* Give 150ms to let RCU destruct UDP sockets */
+		kern_sync_rcu();
+	}
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
+void serial_test_sk_memcg(void)
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
index 000000000000..a613c1deeede
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sk_memcg.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2025 Google LLC */
+
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+#include <errno.h>
+
+SEC("cgroup/sock_create")
+int sock_create(struct bpf_sock *ctx)
+{
+	u32 flags = SK_BPF_MEMCG_SOCK_ISOLATED;
+	int err;
+
+	err = bpf_setsockopt(ctx, SOL_SOCKET, SK_BPF_MEMCG_FLAGS,
+			     &flags, sizeof(flags));
+	if (err)
+		goto err;
+
+	flags = 0;
+
+	err = bpf_getsockopt(ctx, SOL_SOCKET, SK_BPF_MEMCG_FLAGS,
+			     &flags, sizeof(flags));
+	if (err)
+		goto err;
+
+	if (flags != SK_BPF_MEMCG_SOCK_ISOLATED) {
+		err = -EINVAL;
+		goto err;
+	}
+
+	return 1;
+
+err:
+	bpf_set_retval(err);
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.51.0.338.gd7d06c2dae-goog


