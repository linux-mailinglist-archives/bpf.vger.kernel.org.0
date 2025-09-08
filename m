Return-Path: <bpf+bounces-67811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378A8B49D08
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 00:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2013B45E4
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 22:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C7530AD09;
	Mon,  8 Sep 2025 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iVZa+Ske"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF352EF671
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371085; cv=none; b=XLhmZJ8+j6JX8soCM9ZQHlIsWp8IiX85oizVQj7rLhes9OEVGII5lTSytOuONJGbragUU5D+Ey71b5u06Yo/VyhAD3VwRRjad/5WTesWTvXKc3cWyOe1MwH3lQnYhDjVQhHOSufD3NMhZqEfq6Hv+RGzXo8zhPDPVs1Qec7X+sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371085; c=relaxed/simple;
	bh=xvN67whfpOhKIwxwIl11JsYnVj0DqrXhAlM3YdZ+s8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DcshtQH3PLMp5oQ7QZ1X5IZAriUAWRPRYzE+1kJwPxK2Ey08wMp/5gy4gTlocVc7PNW3ymKcFDtJqyRV0PDsr9Bd26696e8/hn9Pm61Hr7KGzc/a0rlzIT6iZ5AkLSz1CvaLVqR6Db/md59K4ERvKAtOQsqrTHIvmeGhAALKJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iVZa+Ske; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-329cb4c3f78so4985762a91.2
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 15:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757371083; x=1757975883; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/mgg2O9+HGTiL/F6Nv60Nv7w7MOKCLuTn/jqD9mWPI=;
        b=iVZa+SkeFYqE8XNd+NlrL+FTC2Ikil+AsrR2xRF4hChu9wfKVMR5h1cg1y+Vjn/Xe6
         25lC5nL/NdkreGLunezBjrpGdll//tI+jHqsEuLG/CjNjaOrIS63nZGg25ipnaANz8a1
         QKqSm277wkYnRMsOJfkZojtXlP1NNlwE5/z8UwEAgHtm7gxvsxEQ/uweQlcoS5wrVjKM
         1xfDgwRecJqGaNLEyAYt2GD/k/whalzZQA4/qTcf32w/+a0RIZ+Cy2ot+FCFwbYMxF0A
         21mYAsvrZ/vWELuqEgc1gcI4+ZCBbHgIMFJ+9sJzV5Sqf2OiVg170cq9ZTlLyeYHnJEL
         iZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371083; x=1757975883;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/mgg2O9+HGTiL/F6Nv60Nv7w7MOKCLuTn/jqD9mWPI=;
        b=H4Vqv5unbAwI3+xl2lalc8RP7G+xDATsUPqaenxVddRstFDK1/Xg13fzrVVpkwKl8Y
         /23lOHZmVToANm59sVw4rTqvn9vTRqioCyyjWiwi93ZNlpUpaLzUNmYX/Nze4G4oMKMT
         xyUoo/rj3Qh8z31xMV6zY1EvrcTBKBql5FOdrQpwYNh8Zr4yFTX5B9UDBJQIvdjb1vX1
         /TjZeuC+HUbfIh1NdGof+jnISFgCWUZ/QVM9aER0k4fhAi7qR5AuBNyK+Axtj3/+ckMu
         4D2GiOY6Zxod4ThRNwrpfpdAYdMyX1HJiYgwvvQp6FQTSpF2R/xzsbxGgkYN6IyR5G+K
         JhkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlI7MDA0zj6zNYcwIUZKpRpOib69Se1eZBhbcZiTy8pulgS5gc/Cjhqb3w9ikYOgXrlEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywu+EA5aFCb6AFU78IW6x1HSdVIAB4I2Krqp0ZV0K0zSSB51x3
	GYPh/rvNRmXhs7UGo27KF6rGeTS9lkMXEJohB5/n2vcKbNhS9nyxFjxFZwyeca6DXCR7QH1+S/9
	PPbgrLw==
X-Google-Smtp-Source: AGHT+IFB/siW0u9MZMXdgmUr0n+KiJOm7gtwcyncPXiCelJ3yrPxrmqqucGvkdLFXpTngy9W9wkHXcg2bMU=
X-Received: from pjeb1.prod.google.com ([2002:a17:90a:10c1:b0:32b:b3c4:a304])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d40e:b0:32b:656f:5a5d
 with SMTP id 98e67ed59e1d1-32d43f701admr11064178a91.29.1757371082858; Mon, 08
 Sep 2025 15:38:02 -0700 (PDT)
Date: Mon,  8 Sep 2025 22:34:39 +0000
In-Reply-To: <20250908223750.3375376-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250908223750.3375376-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250908223750.3375376-6-kuniyu@google.com>
Subject: [PATCH v6 bpf-next/net 5/5] selftest: bpf: Add test for SK_BPF_MEMCG_SOCK_ISOLATED.
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
with/without SK_BPF_MEMCG_SOCK_ISOLATED.

  1. Create socket pairs
  2. Send a bunch of data that requires more than 1024 pages
  3. Read memory_allocated from sk->sk_prot->memory_allocated and
     sk->sk_prot->memory_per_cpu_fw_alloc
  4. Check if unread data is charged to memory_allocated

If SK_BPF_MEMCG_SOCK_ISOLATED is set, memory_allocated should not
be changed, but we allow a small error (up to 10 pages) in case
other processes on the host use some amounts of TCP/UDP memory.

The amount of allocated pages are buffered to per-cpu variable
{tcp,udp}_memory_per_cpu_fw_alloc up to +/- net.core.mem_pcpu_rsv
before reported to {tcp,udp}_memory_allocated.

At 3., memory_allocated is calculated from the 2 variables twice
at fentry and fexit of socket create function to check if the per-cpu
value is drained during calculation.  In that case, 3. is retried.

We use kern_sync_rcu() for UDP because UDP recv queue is destroyed
after RCU grace period.

The test takes ~2s on QEMU (64 CPUs) w/ KVM but takes 6s w/o KVM.

  # time ./test_progs -t sk_memcg
  #370/1   sk_memcg/TCP  :OK
  #370/2   sk_memcg/UDP  :OK
  #370/3   sk_memcg/TCPv6:OK
  #370/4   sk_memcg/UDPv6:OK
  #370     sk_memcg:OK
  Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

  real	0m1.623s
  user	0m0.165s
  sys	0m0.366s

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v6:
  * Trace sk_prot->memory_allocated + sk_prot->memory_per_cpu_fw_alloc

v5:
  * Use kern_sync_rcu()
  * Double NR_SEND to 128

v4:
  * Only use inet_create() hook
  * Test bpf_getsockopt()
  * Add serial_ prefix
  * Reduce sleep() and the amount of sent data
---
 .../selftests/bpf/prog_tests/sk_memcg.c       | 236 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/sk_memcg.c  | 146 +++++++++++
 2 files changed, 382 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_memcg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_memcg.c b/tools/testing/selftests/bpf/prog_tests/sk_memcg.c
new file mode 100644
index 000000000000..c6152240a6b7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sk_memcg.c
@@ -0,0 +1,236 @@
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
+	char name[8];
+	int family;
+	int type;
+	int (*create_sockets)(struct test_case *test_case, int sk[], int len);
+	long (*get_memory_allocated)(struct test_case *test_case, struct sk_memcg *skel);
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
+static long get_memory_allocated(struct test_case *test_case,
+				 bool *activated, bool *stable,
+				 long *memory_allocated)
+{
+	*stable = false;
+
+	do {
+		*activated = true;
+
+		/* AF_INET and AF_INET6 share the same memory_allocated.
+		 * tcp_init_sock() is called by AF_INET and AF_INET6,
+		 * but udp_lib_init_sock() is inline.
+		 */
+		socket(AF_INET, test_case->type, 0);
+	} while (!*stable);
+
+	return *memory_allocated;
+}
+
+static long tcp_get_memory_allocated(struct test_case *test_case, struct sk_memcg *skel)
+{
+	return get_memory_allocated(test_case,
+				    &skel->bss->tcp_activated,
+				    &skel->bss->tcp_stable,
+				    &skel->bss->tcp_memory_allocated);
+}
+
+static long udp_get_memory_allocated(struct test_case *test_case, struct sk_memcg *skel)
+{
+	return get_memory_allocated(test_case,
+				    &skel->bss->udp_activated,
+				    &skel->bss->udp_stable,
+				    &skel->bss->udp_memory_allocated);
+}
+
+static int check_isolated(struct test_case *test_case,
+			  struct sk_memcg *skel, bool isolated)
+{
+	char buf[BUF_SINGLE] = {};
+	long memory_allocated[2];
+	int sk[NR_SOCKETS] = {};
+	int err, i, j;
+
+	err = test_case->create_sockets(test_case, sk, ARRAY_SIZE(sk));
+	if (err)
+		goto close;
+
+	memory_allocated[0] = test_case->get_memory_allocated(test_case, skel);
+
+	/* allocate pages >= 1024 */
+	for (i = 0; i < ARRAY_SIZE(sk); i++) {
+		for (j = 0; j < NR_SEND; j++) {
+			int bytes = send(sk[i], buf, sizeof(buf), 0);
+
+			/* Avoid too noisy logs when something failed. */
+			if (bytes != sizeof(buf)) {
+				ASSERT_EQ(bytes, sizeof(buf), "send");
+				if (bytes < 0) {
+					err = bytes;
+					goto close;
+				}
+			}
+		}
+	}
+
+	memory_allocated[1] = test_case->get_memory_allocated(test_case, skel);
+
+	if (isolated)
+		ASSERT_LE(memory_allocated[1], memory_allocated[0] + 10, "isolated");
+	else
+		ASSERT_GT(memory_allocated[1], memory_allocated[0] + 1024, "not isolated");
+
+close:
+	for (i = 0; i < ARRAY_SIZE(sk); i++)
+		close(sk[i]);
+
+	if (test_case->type == SOCK_DGRAM) {
+		/* UDP recv queue is destroyed after RCU grace period.
+		 * With one kern_sync_rcu(), memory_allocated[0] of the
+		 * isoalted case often matches with memory_allocated[1]
+		 * of the preceding non-isolated case.
+		 */
+		kern_sync_rcu();
+		kern_sync_rcu();
+	}
+
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
+	skel->bss->nr_cpus = libbpf_num_possible_cpus();
+
+	err = sk_memcg__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto destroy_skel;
+
+	cgroup = test__join_cgroup("/sk_memcg");
+	if (!ASSERT_GE(cgroup, 0, "join_cgroup"))
+		goto destroy_skel;
+
+	err = check_isolated(test_case, skel, false);
+	if (!ASSERT_EQ(err, 0, "test_isolated(false)"))
+		goto close_cgroup;
+
+	skel->links.sock_create = bpf_program__attach_cgroup(skel->progs.sock_create, cgroup);
+	if (!ASSERT_OK_PTR(skel->links.sock_create, "attach_cgroup(sock_create)"))
+		goto close_cgroup;
+
+	err = check_isolated(test_case, skel, true);
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
+		.name = "TCP  ",
+		.family = AF_INET,
+		.type = SOCK_STREAM,
+		.create_sockets = tcp_create_sockets,
+		.get_memory_allocated = tcp_get_memory_allocated,
+	},
+	{
+		.name = "UDP  ",
+		.family = AF_INET,
+		.type = SOCK_DGRAM,
+		.create_sockets = udp_create_sockets,
+		.get_memory_allocated = udp_get_memory_allocated,
+	},
+	{
+		.name = "TCPv6",
+		.family = AF_INET6,
+		.type = SOCK_STREAM,
+		.create_sockets = tcp_create_sockets,
+		.get_memory_allocated = tcp_get_memory_allocated,
+	},
+	{
+		.name = "UDPv6",
+		.family = AF_INET6,
+		.type = SOCK_DGRAM,
+		.create_sockets = udp_create_sockets,
+		.get_memory_allocated = udp_get_memory_allocated,
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
index 000000000000..cd46d6dfa73c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sk_memcg.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2025 Google LLC */
+
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <errno.h>
+
+extern int tcp_memory_per_cpu_fw_alloc __ksym;
+extern int udp_memory_per_cpu_fw_alloc __ksym;
+
+int nr_cpus;
+bool tcp_activated, tcp_stable, udp_activated, udp_stable;
+long tcp_memory_allocated, udp_memory_allocated;
+static struct sock *tcp_sk_tracing, *udp_sk_tracing;
+
+struct sk_prot {
+	long *memory_allocated;
+	int *memory_per_cpu_fw_alloc;
+};
+
+static int drain_memory_per_cpu_fw_alloc(__u32 i, struct sk_prot *sk_prot_ctx)
+{
+	int *memory_per_cpu_fw_alloc;
+
+	memory_per_cpu_fw_alloc = bpf_per_cpu_ptr(sk_prot_ctx->memory_per_cpu_fw_alloc, i);
+	if (memory_per_cpu_fw_alloc)
+		*sk_prot_ctx->memory_allocated += *memory_per_cpu_fw_alloc;
+
+	return 0;
+}
+
+static long get_memory_allocated(struct sock *_sk, int *memory_per_cpu_fw_alloc)
+{
+	struct sock *sk = bpf_core_cast(_sk, struct sock);
+	struct sk_prot sk_prot_ctx;
+	long memory_allocated;
+
+	/* net_aligned_data.{tcp,udp}_memory_allocated was not available. */
+	memory_allocated = sk->__sk_common.skc_prot->memory_allocated->counter;
+
+	sk_prot_ctx.memory_allocated = &memory_allocated;
+	sk_prot_ctx.memory_per_cpu_fw_alloc = memory_per_cpu_fw_alloc;
+
+	bpf_loop(nr_cpus, drain_memory_per_cpu_fw_alloc, &sk_prot_ctx, 0);
+
+	return memory_allocated;
+}
+
+static void fentry_init_sock(struct sock *sk, struct sock **sk_tracing,
+			     long *memory_allocated, int *memory_per_cpu_fw_alloc,
+			     bool *activated)
+{
+	if (!*activated)
+		return;
+
+	if (__sync_val_compare_and_swap(sk_tracing, NULL, sk))
+		return;
+
+	*activated = false;
+	*memory_allocated = get_memory_allocated(sk, memory_per_cpu_fw_alloc);
+}
+
+static void fexit_init_sock(struct sock *sk, struct sock **sk_tracing,
+			    long *memory_allocated, int *memory_per_cpu_fw_alloc,
+			    bool *stable)
+{
+	long new_memory_allocated;
+
+	if (sk != *sk_tracing)
+		return;
+
+	new_memory_allocated = get_memory_allocated(sk, memory_per_cpu_fw_alloc);
+	if (new_memory_allocated == *memory_allocated)
+		*stable = true;
+
+	*sk_tracing = NULL;
+}
+
+SEC("fentry/tcp_init_sock")
+int BPF_PROG(fentry_tcp_init_sock, struct sock *sk)
+{
+	fentry_init_sock(sk, &tcp_sk_tracing,
+			 &tcp_memory_allocated, &tcp_memory_per_cpu_fw_alloc,
+			 &tcp_activated);
+	return 0;
+}
+
+SEC("fexit/tcp_init_sock")
+int BPF_PROG(fexit_tcp_init_sock, struct sock *sk)
+{
+	fexit_init_sock(sk, &tcp_sk_tracing,
+			&tcp_memory_allocated, &tcp_memory_per_cpu_fw_alloc,
+			&tcp_stable);
+	return 0;
+}
+
+SEC("fentry/udp_init_sock")
+int BPF_PROG(fentry_udp_init_sock, struct sock *sk)
+{
+	fentry_init_sock(sk, &udp_sk_tracing,
+			 &udp_memory_allocated, &udp_memory_per_cpu_fw_alloc,
+			 &udp_activated);
+	return 0;
+}
+
+SEC("fexit/udp_init_sock")
+int BPF_PROG(fexit_udp_init_sock, struct sock *sk)
+{
+	fexit_init_sock(sk, &udp_sk_tracing,
+			&udp_memory_allocated, &udp_memory_per_cpu_fw_alloc,
+			&udp_stable);
+	return 0;
+}
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
2.51.0.384.g4c02a37b29-goog


