Return-Path: <bpf+bounces-66918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4CAB3B02A
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 03:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B9EC7A4EDC
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 00:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FDF2135C5;
	Fri, 29 Aug 2025 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RhFnZOla"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC954673
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756429241; cv=none; b=fEucipquktHe40eAN7Ul4ZKl9FfM4/lriWTvdvBcbRYezH5TkGUfyzTMsI7q9PYQhxJ1bHxAi4IGsL6PuT/M0a1oDwVGtmm6WmU7sH9/SVypkDoQ6qgOIJjvukh2ySge+3ddpfELqQ9kUgXr+bYlSQEnSFiHPB/5QCQsKl/vFw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756429241; c=relaxed/simple;
	bh=k0O1L6qidTms+WXM1eLY3GsNk++vz37aRm/jfxqqCXU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d4r5xJ/ZhpdRhZ2u72pek6q8y8YIPyLXuDfEMOf9VVteGPAyJE+1YU4r9xzbjzAmb88bqvafznjZiDOKPIHZzAaLPQHYy9dc/9zY1nEBoihyTi8rzRJpbcqwbEMavP/xCBEbT32BGEJUXnQU1pFcuwh2H2aw5c2utzlffr29erI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RhFnZOla; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77057266d0bso2206427b3a.1
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 18:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756429239; x=1757034039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hJCCAA07wlvqPWd5mdefvna4BUyaB4xZnFkMfr2aKDU=;
        b=RhFnZOlasxIlw06L5jE96eoP7EmQ6YmhHQSMJInA+9ktpgZ0QojmjA8Qlq2Cmn3OtD
         xipk9L/pKmPKkddiNmsVYyu0BU92YcwheOwcy6qT3RWlRupTbtoMC6iI7oKgEAIRa89G
         05XAsh5ixH+7ySq0k37T2pZ/B4q1SSLGgJ+ayXobQ3gDt3xPak7G6xZYP8lnJ7EdyENi
         YnU99TCIyb/qKPK4wOKw43aTLGL7795ZG2tvhtECcZkOtoluz0ER2mCF+qYVvaKr8KEb
         PUiHJNSnSzKo4IMvTLNpQcnuSfu3S+MzySJ7weTJqVyREbYApryqkT1/k65uANfW6fV5
         qjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756429239; x=1757034039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJCCAA07wlvqPWd5mdefvna4BUyaB4xZnFkMfr2aKDU=;
        b=hdbUwtpxeTW60LTikzDwXxJykVC9encUmRRbmBTWfCx3jwjt0L9uc5YA9X3+kQE3ae
         MhlznVej9pOcl6Exh1ayW07ELNx2/PQoNU+JFhsYBj2kgzZDrf0MrkoCEx0WMLFfUXPX
         DyMQ8PlJBtvUpQP5h4wkuV3NkEbHoPezUjGIRCAkUl0s4Z3JzmF3Xl7MrfGrnZx9gEM1
         NbVKBipd8NO7AqEudDNr2vzx5f147l0929x6acn1mRTQ+jh4HKRgzsIxysmnwXpQ46Xt
         xM5+F+WjK1yBxEX6J+GhNu9geZfuuJ/qa7ApdopbKBTEhTYAwyeSYiRX3nDMVuaa/Jt4
         TwMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVblsHIJOZiHfCUYSO4JTy2S8+/5YAyjYrBy1gwboX8qLM3w+ZIqSzt55tUPuY4QWIUTO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4wxvEuv3LDuKMpX43DBCYkHtEenjN1kDJJ6wMs5r4kBVANY1l
	a7fVmdYeqd5+Sp6jQW8dfexMmYHEnVb353WgtpiK4jpdkSHRRz0illio5S8VjQKB7Way88rPNoG
	zfYI5lQ==
X-Google-Smtp-Source: AGHT+IH5t9NtiWA9j5wSJTpIwtnUL05oL4n2OT/q1x6yUz0jFYziNU4n7WBly8Gccn01MBUEfhKP5j9tJpc=
X-Received: from pfkh28.prod.google.com ([2002:a05:6a00:1c:b0:771:f406:9f46])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:198f:b0:771:f852:452e
 with SMTP id d2e1a72fcca58-771f852485dmr15795171b3a.29.1756429238513; Thu, 28
 Aug 2025 18:00:38 -0700 (PDT)
Date: Fri, 29 Aug 2025 01:00:08 +0000
In-Reply-To: <20250829010026.347440-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829010026.347440-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829010026.347440-6-kuniyu@google.com>
Subject: [PATCH v4 bpf-next/net 5/5] selftest: bpf: Add test for SK_BPF_MEMCG_SOCK_ISOLATED.
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

  BUF_SINGLE (1024) * NR_SEND (64) * NR_SOCKETS (64) / 4096
  = 1024 pages

When I reduced it to 512 pages, the following assertion for the
non-isolated case got flaky.

  ASSERT_GT(memory_allocated[1], memory_allocated[0] + 256, ...)

Another contributor to slowness is 150ms sleep to make sure 1 RCU
grace period passes because UDP recv queue is destroyed after that.

  # time ./test_progs -t sk_memcg
  #370/1   sk_memcg/TCP       :OK
  #370/2   sk_memcg/UDP       :OK
  #370/3   sk_memcg/TCPv6     :OK
  #370/4   sk_memcg/UDPv6     :OK
  #370     sk_memcg:OK
  Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

  real	0m1.214s
  user	0m0.014s
  sys	0m0.318s

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
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
index 000000000000..2d68b00419a2
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
+#define NR_SEND		64
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
+		usleep(150 * 1000);
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
2.51.0.318.gd7df087d1a-goog


