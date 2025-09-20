Return-Path: <bpf+bounces-69027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219E8B8BAC8
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 02:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B918C1C02B9C
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 00:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDECE140E34;
	Sat, 20 Sep 2025 00:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vWsh1iYY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E26578F4F
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 00:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758326887; cv=none; b=a7svasEn4VQyFP9nTJJvSYMPRH2yQ2rPc2ZCdY013PsDzL5QTJhuKBaOLFvI5Y1UWItlJ0EGnvdYGzvYi70ZnpNNpUAn7pb7Wr66jo/DoAm/9eJqWzka2qtVFQ+2wUM56xYs7ujID0jg+CnCn1TQskhszNq5HIOtbflhzwBuyT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758326887; c=relaxed/simple;
	bh=dePfMyGmSkx6t6WXYwxyDfB2BE0vzHOqQS7534SA+6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VqIwGBEv7cRwDK/BdFqROAn5H+rASIrh0OeVftypUXek0srM+W+KsEmgcMd1/zeydOGz6/AmnAZvyIx+VpA+5nMXKkJdo3MirQDLcfeP1VYRYrMEHNVI8syR2UO575WdyPLjTzVOYti6gtrWXLWhrowttBpAdBCIiGemZkvWCQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vWsh1iYY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2711a55da20so900725ad.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 17:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758326885; x=1758931685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c/ccEl1zaBY/ZABE36aIiHm3JwGfH4bBFJgJn4j4oaE=;
        b=vWsh1iYYqpePpAw5hzYkQI5/DNEl4DtpFjxtQX/uqy82+WG5xe6vog+I3rQXk5c+Ok
         1aTU0dod5+9XtJg0EKTgQ+hvOx+WvJxHa5EVm9v7dXpP2pd9Y2cUsA8MA+C9hkxnf+xY
         YLC/vGV79vZMm+0aMoR3bdxgapEis6UmiKXOu+awTzVYEDhJHjC/LxKobSa31Roa0wfQ
         IXNKyxYd/gwapGT643k9to+fYjXC9boFN1ef40ki+oeb1Nt8dTiJojriazhbzlzG/SPC
         +5v6KlCmEqISmis8bK2XmEdzO8WBuRg8aC9AsZnW4QXF64zIRCNaNYKdJcfSVWJzxmSM
         MMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758326885; x=1758931685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/ccEl1zaBY/ZABE36aIiHm3JwGfH4bBFJgJn4j4oaE=;
        b=n5DiakuXFrUFHVPJ7NVHyaFpfJj6JdxwmCmz6f4sZyNkYGtWn74eOx0RZ961meY25s
         27JNb8PABNAsGwd5UAeJO3lzKpNfhIbTXBAfCwp3w6dDEzc+dUW3lIeAYZ3srWDrkbwn
         Gz+ur/lXwFxTTvzo+2TNlzhr4ncYNu0X0lVLfbb7LLbCnzi9ijzZzR3cZ2Zy9QL0N9ay
         7PD3C+2/jR00KT+nbgzmZs4hX5LFzOle77sCKK5ShMysa4FTYrG4KQNHFR0C5umyrCv0
         DTwGEzwbsz1Jtiu+PaGF21PXCuKexcY6oBSyPq+6aeiigS7zfyNcCNGFKDHUrCm8uano
         uIRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP33OjGaqYG2qfdzekb1jwsegR5TK6o77BXqvfwsJnlecXeu8TSQgfur+8/o1CSsHyE9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza/GpmIFeTFbTvH6mtVwqWHbQfHHttBZ68mEldsEI9g8Ui+Dgu
	w5R3mlsXVqPCt/9i6jFn0Q6ixeED3qJPG/I0zXetErrokFzCNf+PGnVudJ4tQNrMmg60vO+J1nB
	4//zOhQ==
X-Google-Smtp-Source: AGHT+IGyZiuYqz0ZUpvtxcj1y3NPozXSZFAerRM1DVo9S9a0H5NuLchdXTjjFR6BadqRSTvHYC1QGz6ePzQ=
X-Received: from pliy12.prod.google.com ([2002:a17:903:3d0c:b0:267:f916:ba14])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aa5:b0:25c:d4b6:f111
 with SMTP id d9443c01a7336-269ba544020mr75342285ad.47.1758326884839; Fri, 19
 Sep 2025 17:08:04 -0700 (PDT)
Date: Sat, 20 Sep 2025 00:07:20 +0000
In-Reply-To: <20250920000751.2091731-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250920000751.2091731-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250920000751.2091731-7-kuniyu@google.com>
Subject: [PATCH v10 bpf-next/net 6/6] selftest: bpf: Add test for SK_MEMCG_EXCLUSIVE.
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
with/without SK_MEMCG_EXCLUSIVE, which can be turned on by
net.core.memcg_exclusive or bpf_setsockopt(SK_BPF_MEMCG_EXCLUSIVE).

  1. Create socket pairs
  2. Send NR_PAGES (32) of data (TCP consumes around 35 pages,
     and UDP consuems 66 pages due to skb overhead)
  3. Read memory_allocated from sk->sk_prot->memory_allocated and
     sk->sk_prot->memory_per_cpu_fw_alloc
  4. Check if unread data is charged to memory_allocated

If SK_MEMCG_EXCLUSIVE is set, memory_allocated should not be
changed, but we allow a small error (up to 10 pages) in case
other processes on the host use some amounts of TCP/UDP memory.

The amount of allocated pages are buffered to per-cpu variable
{tcp,udp}_memory_per_cpu_fw_alloc up to +/- net.core.mem_pcpu_rsv
before reported to {tcp,udp}_memory_allocated.

At 3., memory_allocated is calculated from the 2 variables at
fentry of socket create function.

We drain the receive queue only for UDP before close() because UDP
recv queue is destroyed after RCU grace period.  When I printed
memory_allocated, UDP exclusive cases sometimes saw the non-exclusive
case's leftover, but it's still in the small error range (<10 pages).

  bpf_trace_printk: memory_allocated: 0   <-- TCP non-exclusive
  bpf_trace_printk: memory_allocated: 35
  bpf_trace_printk: memory_allocated: 0   <-- TCP w/ sysctl
  bpf_trace_printk: memory_allocated: 0
  bpf_trace_printk: memory_allocated: 0   <-- TCP w/ bpf
  bpf_trace_printk: memory_allocated: 0
  bpf_trace_printk: memory_allocated: 0   <-- UDP non-exclusive
  bpf_trace_printk: memory_allocated: 66
  bpf_trace_printk: memory_allocated: 2   <-- UDP w/ sysctl (2 pages leftover)
  bpf_trace_printk: memory_allocated: 2
  bpf_trace_printk: memory_allocated: 2   <-- UDP w/ bpf (2 pages leftover)
  bpf_trace_printk: memory_allocated: 2

We prefer finishing tests faster than oversleeping for call_rcu()
 + sk_destruct().

The test completes within 2s on QEMU (64 CPUs) w/ KVM.

  # time ./test_progs -t sk_memcg
  #370/1   sk_memcg/TCP  :OK
  #370/2   sk_memcg/UDP  :OK
  #370/3   sk_memcg/TCPv6:OK
  #370/4   sk_memcg/UDPv6:OK
  #370     sk_memcg:OK
  Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

  real	0m1.609s
  user	0m0.167s
  sys	0m0.461s

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v10:
  * Clean up iterations in ->create_sockets()
  * Move ASSERT inside if to avoid noisy log in ->create_sockets()
  * Make run_test() static
  * Remove fexit progs & possible infinite loop in get_memory_allocated()
  * Use test__start_subtest() with if
  * Speed up test by reducing NR_PAGES to 32 and draing UDP queue
    instead of oversleeping for call_rcu()+sk_destruct()

v7:
  * Add test for sysctl

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
 .../selftests/bpf/prog_tests/sk_memcg.c       | 282 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/sk_memcg.c  | 105 +++++++
 2 files changed, 387 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_memcg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_memcg.c b/tools/testing/selftests/bpf/prog_tests/sk_memcg.c
new file mode 100644
index 000000000000..9e0aa7e7df27
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sk_memcg.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2025 Google LLC */
+
+#include <test_progs.h>
+#include "sk_memcg.skel.h"
+#include "network_helpers.h"
+
+#define NR_PAGES	32
+#define NR_SOCKETS	2
+#define BUF_TOTAL	(NR_PAGES * 4096 / NR_SOCKETS)
+#define BUF_SINGLE	1024
+#define NR_SEND		(BUF_TOTAL / BUF_SINGLE)
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
+	/* Keep for-loop so we can change NR_SOCKETS easily. */
+	for (i = 0; i < len; i += 2) {
+		sk[i] = connect_to_fd(server, 0);
+		if (sk[i] < 0) {
+			ASSERT_GE(sk[i], 0, "connect_to_fd");
+			return sk[i];
+		}
+
+		sk[i + 1] = accept(server, NULL, NULL);
+		if (sk[i + 1] < 0) {
+			ASSERT_GE(sk[i + 1], 0, "accept");
+			return sk[i + 1];
+		}
+	}
+
+	close(server);
+
+	return 0;
+}
+
+static int udp_create_sockets(struct test_case *test_case, int sk[], int len)
+{
+	int i, j, err, rcvbuf = BUF_TOTAL;
+
+	/* Keep for-loop so we can change NR_SOCKETS easily. */
+	for (i = 0; i < len; i += 2) {
+		sk[i] = start_server(test_case->family, test_case->type, NULL, 0, 0);
+		if (sk[i] < 0) {
+			ASSERT_GE(sk[i], 0, "start_server");
+			return sk[i];
+		}
+
+		sk[i + 1] = connect_to_fd(sk[i], 0);
+		if (sk[i + 1] < 0) {
+			ASSERT_GE(sk[i + 1], 0, "connect_to_fd");
+			return sk[i + 1];
+		}
+
+		err = connect_fd_to_fd(sk[i], sk[i + 1], 0);
+		if (err) {
+			ASSERT_EQ(err, 0, "connect_fd_to_fd");
+			return err;
+		}
+
+		for (j = 0; j < 2; j++) {
+			err = setsockopt(sk[i + j], SOL_SOCKET, SO_RCVBUF, &rcvbuf, sizeof(int));
+			if (err) {
+				ASSERT_EQ(err, 0, "setsockopt(SO_RCVBUF)");
+				return err;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static long get_memory_allocated(struct test_case *test_case,
+				 bool *activated, long *memory_allocated)
+{
+	int sk;
+
+	*activated = true;
+
+	/* AF_INET and AF_INET6 share the same memory_allocated.
+	 * tcp_init_sock() is called by AF_INET and AF_INET6,
+	 * but udp_lib_init_sock() is inline.
+	 */
+	sk = socket(AF_INET, test_case->type, 0);
+	if (!ASSERT_GE(sk, 0, "get_memory_allocated"))
+		return -1;
+
+	close(sk);
+
+	return *memory_allocated;
+}
+
+static long tcp_get_memory_allocated(struct test_case *test_case, struct sk_memcg *skel)
+{
+	return get_memory_allocated(test_case,
+				    &skel->bss->tcp_activated,
+				    &skel->bss->tcp_memory_allocated);
+}
+
+static long udp_get_memory_allocated(struct test_case *test_case, struct sk_memcg *skel)
+{
+	return get_memory_allocated(test_case,
+				    &skel->bss->udp_activated,
+				    &skel->bss->udp_memory_allocated);
+}
+
+static int check_exclusive(struct test_case *test_case,
+			   struct sk_memcg *skel, bool exclusive)
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
+	/* allocate pages >= NR_PAGES */
+	for (i = 0; i < ARRAY_SIZE(sk); i++) {
+		for (j = 0; j < NR_SEND; j++) {
+			int bytes = send(sk[i], buf, sizeof(buf), 0);
+
+			/* Avoid too noisy logs when something failed. */
+			if (bytes != sizeof(buf)) {
+				ASSERT_EQ(bytes, sizeof(buf), "send");
+				if (bytes < 0) {
+					err = bytes;
+					goto drain;
+				}
+			}
+		}
+	}
+
+	memory_allocated[1] = test_case->get_memory_allocated(test_case, skel);
+
+	if (exclusive)
+		ASSERT_LE(memory_allocated[1], memory_allocated[0] + 10, "exclusive");
+	else
+		ASSERT_GT(memory_allocated[1], memory_allocated[0] + NR_PAGES, "not exclusive");
+
+drain:
+	if (test_case->type == SOCK_DGRAM) {
+		/* UDP starts purging sk->sk_receive_queue after one RCU
+		 * grace period, then udp_memory_allocated goes down,
+		 * so drain the queue before close().
+		 */
+		for (i = 0; i < ARRAY_SIZE(sk); i++) {
+			for (j = 0; j < NR_SEND; j++) {
+				int bytes = recv(sk[i], buf, 1, MSG_DONTWAIT | MSG_TRUNC);
+
+				if (bytes == sizeof(buf))
+					continue;
+				if (bytes != -1 || errno != EAGAIN)
+					PRINT_FAIL("bytes: %d, errno: %s\n", bytes, strerror(errno));
+				break;
+			}
+		}
+	}
+
+close:
+	for (i = 0; i < ARRAY_SIZE(sk); i++)
+		close(sk[i]);
+
+	return err;
+}
+
+static void run_test(struct test_case *test_case)
+{
+	struct nstoken *nstoken;
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
+	err = make_netns("sk_memcg");
+	if (!ASSERT_EQ(err, 0, "make_netns"))
+		goto close_cgroup;
+
+	nstoken = open_netns("sk_memcg");
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto remove_netns;
+
+	err = check_exclusive(test_case, skel, false);
+	if (!ASSERT_EQ(err, 0, "test_exclusive(false)"))
+		goto close_netns;
+
+	err = write_sysctl("/proc/sys/net/core/memcg_exclusive", "1");
+	if (!ASSERT_EQ(err, 0, "write_sysctl(1)"))
+		goto close_netns;
+
+	err = check_exclusive(test_case, skel, true);
+	if (!ASSERT_EQ(err, 0, "test_exclusive(true by sysctl)"))
+		goto close_netns;
+
+	err = write_sysctl("/proc/sys/net/core/memcg_exclusive", "0");
+	if (!ASSERT_EQ(err, 0, "write_sysctl(0)"))
+		goto close_netns;
+
+	skel->links.sock_create = bpf_program__attach_cgroup(skel->progs.sock_create, cgroup);
+	if (!ASSERT_OK_PTR(skel->links.sock_create, "attach_cgroup(sock_create)"))
+		goto close_netns;
+
+	err = check_exclusive(test_case, skel, true);
+	ASSERT_EQ(err, 0, "test_exclusive(true by bpf)");
+
+close_netns:
+	close_netns(nstoken);
+remove_netns:
+	remove_netns("sk_memcg");
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
+		if (test__start_subtest(test_cases[i].name))
+			run_test(&test_cases[i]);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/sk_memcg.c b/tools/testing/selftests/bpf/progs/sk_memcg.c
new file mode 100644
index 000000000000..8430ad920224
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sk_memcg.c
@@ -0,0 +1,105 @@
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
+bool tcp_activated, udp_activated;
+long tcp_memory_allocated, udp_memory_allocated;
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
+static void fentry_init_sock(struct sock *sk, bool *activated,
+			     long *memory_allocated, int *memory_per_cpu_fw_alloc)
+{
+	if (!*activated)
+		return;
+
+	*memory_allocated = get_memory_allocated(sk, memory_per_cpu_fw_alloc);
+	*activated = false;
+}
+
+SEC("fentry/tcp_init_sock")
+int BPF_PROG(fentry_tcp_init_sock, struct sock *sk)
+{
+	fentry_init_sock(sk, &tcp_activated,
+			 &tcp_memory_allocated, &tcp_memory_per_cpu_fw_alloc);
+	return 0;
+}
+
+SEC("fentry/udp_init_sock")
+int BPF_PROG(fentry_udp_init_sock, struct sock *sk)
+{
+	fentry_init_sock(sk, &udp_activated,
+			 &udp_memory_allocated, &udp_memory_per_cpu_fw_alloc);
+	return 0;
+}
+
+SEC("cgroup/sock_create")
+int sock_create(struct bpf_sock *ctx)
+{
+	u32 flags = SK_BPF_MEMCG_EXCLUSIVE;
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
+	if (flags != SK_BPF_MEMCG_EXCLUSIVE) {
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
2.51.0.470.ga7dc726c21-goog


