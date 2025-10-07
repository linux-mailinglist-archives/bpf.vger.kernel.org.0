Return-Path: <bpf+bounces-70469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65945BBFD7D
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 02:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B32604F2F9B
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 00:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7511DF74F;
	Tue,  7 Oct 2025 00:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FOgK7Rg6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E40845C0B
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795896; cv=none; b=mBKMUwWrexZBoM4cwthTJs2cWnAFRnGztPeT6DOah6AwXOCiaZ6AqfshorI17Ri6k7iQhHod1HLrqatGl+olf5f73orpETtfjDrsKgfabI7YCYHcdPiMYyGE8kDWCgIhN+uw3PioL47g4DJElRwiKUFmEpsALJz/NiVILBYgxBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795896; c=relaxed/simple;
	bh=p4BNYVf8bj6QBsYFk21IqiONkoCZv1bc3noLYcc2VT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iiKxBQSghbKexOtuB8UHiXYZKQH1dIckS/QsAeZyEiycYlZaFz/20aIR8Ob9qOXA8cF/TsDGBVeYcGKxCLId+IG0aQ7WcTfd/6vX543IASMPxnBfHHQaWEcuRXbdMN8maUsdcoi/oheynuoa8T6zr4HZswGDqwRraTkaGAzjgmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FOgK7Rg6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-277f0ea6fbaso73143915ad.0
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 17:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759795893; x=1760400693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcFTqjRwMOM0fY6/qjvt5YA2CCbFUbVK6jNxAxhZM7U=;
        b=FOgK7Rg6vcdPACvrsKIxVp2EB8NIXR/4DmcxI91nW5dubQuc9lSNjiIdXUm/+4ESWU
         FU59zL48ByWNakBUajienW/T/kBEbYirFxvUvFh3dGN9+3aw7r+7Nz/LHPbsDWDwPKd3
         7ZHLj/dpEYyHQV4uRT2+Ge31UeUgF6NVjXxTJIOZj4+1tH2PzKTWuZZVlN597NpRVMbr
         0OUAMi0SChnX3sWHnTxAwDh7cDeUJai0+JkoZr2W8KlRxeFpKq1A9LloiVu0qWiM4k7V
         FXVCeSZfIUvQVu7GA9ipUhzELtAeCQ47fItua6WFnBN3TZC5+ow33KCla05V1Q6hlfHX
         pffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795893; x=1760400693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcFTqjRwMOM0fY6/qjvt5YA2CCbFUbVK6jNxAxhZM7U=;
        b=XA3wKvjLq6y6fwUexEX+wC1FSdlV5DZ1ac09zI00r1BL5vlpOXBki1Klt7iTYPOYbF
         cGxJAC2YiMCKeVuC1gWwvNchBAjNXaxycLvRtSDyhzXD5n5WUY36kAkmFkwvxv4iQStx
         IzSai7MWVtk4gs1v9aBCJe4EjnMeZyxO0t77PCigMlMH7wBYSDkeP3++i/JV7FeCwNeq
         6W53UeiRsvvHvJ+b1LPaam69KpZm6kpk+7Nj2+467buL+GwT+JAqVzSRFHjsFsXI108T
         ExAOsmSUxQZRDk3+xJJsHtCMGPPpBY4DLGty7qh5SMLPm1Sj9xqpzq7HOvNKSmbMAc4L
         aI1A==
X-Forwarded-Encrypted: i=1; AJvYcCUaxo8dEyoLZcw3hVA/olLS0ZuHepEtLqPQki3WiG8DVg2PflOLJLuzo6bI6a4ubwkgjrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YygrUkffnFk1Dx9ByiaqcDXT93r1NAMz6TlyA/68RPvhtQ+Pi4g
	22CsoLcUfo7NJzqCtRYX0AIZdP7tKKkRLdJCPRBP9jn/ZWxmURCYr25sCGcCFPhSJ0O1md/STAE
	lc6+Scg==
X-Google-Smtp-Source: AGHT+IGovfQZtUpoy7F2jsy8lgngBQfkkIKGpQHXce4RXu2dAOmdMY58q+xLWKcT8RLV45Yiu2/0oVCpR+o=
X-Received: from pjzh5.prod.google.com ([2002:a17:90a:ea85:b0:32d:e264:a78e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:98b:b0:254:70cb:5b36
 with SMTP id d9443c01a7336-28e9a51345bmr161609845ad.8.1759795893316; Mon, 06
 Oct 2025 17:11:33 -0700 (PDT)
Date: Tue,  7 Oct 2025 00:07:31 +0000
In-Reply-To: <20251007001120.2661442-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007001120.2661442-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251007001120.2661442-7-kuniyu@google.com>
Subject: [PATCH bpf-next/net 6/6] selftest: bpf: Add test for sk->sk_bypass_prot_mem.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The test does the following for IPv4/IPv6 x TCP/UDP sockets
with/without sk->sk_bypass_prot_mem, which can be turned on by
net.core.bypass_prot_mem or bpf_setsockopt(SK_BPF_BYPASS_PROT_MEM).

  1. Create socket pairs
  2. Send NR_PAGES (32) of data (TCP consumes around 35 pages,
     and UDP consuems 66 pages due to skb overhead)
  3. Read memory_allocated from sk->sk_prot->memory_allocated and
     sk->sk_prot->memory_per_cpu_fw_alloc
  4. Check if unread data is charged to memory_allocated

If sk->sk_bypass_prot_mem is set, memory_allocated should not be
changed, but we allow a small error (up to 10 pages) in case
other processes on the host use some amounts of TCP/UDP memory.

The amount of allocated pages are buffered to per-cpu variable
{tcp,udp}_memory_per_cpu_fw_alloc up to +/- net.core.mem_pcpu_rsv
before reported to {tcp,udp}_memory_allocated.

At 3., memory_allocated is calculated from the 2 variables at
fentry of socket create function.

We drain the receive queue only for UDP before close() because UDP
recv queue is destroyed after RCU grace period.  When I printed
memory_allocated, UDP bypass cases sometimes saw the no-bypass
case's leftover, but it's still in the small error range (<10 pages).

  bpf_trace_printk: memory_allocated: 0   <-- TCP no-bypass
  bpf_trace_printk: memory_allocated: 35
  bpf_trace_printk: memory_allocated: 0   <-- TCP w/ sysctl
  bpf_trace_printk: memory_allocated: 0
  bpf_trace_printk: memory_allocated: 0   <-- TCP w/ bpf
  bpf_trace_printk: memory_allocated: 0
  bpf_trace_printk: memory_allocated: 0   <-- UDP no-bypass
  bpf_trace_printk: memory_allocated: 66
  bpf_trace_printk: memory_allocated: 2   <-- UDP w/ sysctl (2 pages leftover)
  bpf_trace_printk: memory_allocated: 2
  bpf_trace_printk: memory_allocated: 2   <-- UDP w/ bpf (2 pages leftover)
  bpf_trace_printk: memory_allocated: 2

We prefer finishing tests faster than oversleeping for call_rcu()
 + sk_destruct().

The test completes within 2s on QEMU (64 CPUs) w/ KVM.

  # time ./test_progs -t sk_bypass
  #371/1   sk_bypass_prot_mem/TCP  :OK
  #371/2   sk_bypass_prot_mem/UDP  :OK
  #371/3   sk_bypass_prot_mem/TCPv6:OK
  #371/4   sk_bypass_prot_mem/UDPv6:OK
  #371     sk_bypass_prot_mem:OK
  Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

  real	0m1.481s
  user	0m0.181s
  sys	0m0.441s

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../bpf/prog_tests/sk_bypass_prot_mem.c       | 282 ++++++++++++++++++
 .../selftests/bpf/progs/sk_bypass_prot_mem.c  | 104 +++++++
 2 files changed, 386 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_bypass_prot_mem.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_bypass_prot_mem.c b/tools/testing/selftests/bpf/prog_tests/sk_bypass_prot_mem.c
new file mode 100644
index 000000000000..ce4fc47b6bdb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sk_bypass_prot_mem.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2025 Google LLC */
+
+#include <test_progs.h>
+#include "sk_bypass_prot_mem.skel.h"
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
+	long (*get_memory_allocated)(struct test_case *test_case, struct sk_bypass_prot_mem *skel);
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
+static long tcp_get_memory_allocated(struct test_case *test_case, struct sk_bypass_prot_mem *skel)
+{
+	return get_memory_allocated(test_case,
+				    &skel->bss->tcp_activated,
+				    &skel->bss->tcp_memory_allocated);
+}
+
+static long udp_get_memory_allocated(struct test_case *test_case, struct sk_bypass_prot_mem *skel)
+{
+	return get_memory_allocated(test_case,
+				    &skel->bss->udp_activated,
+				    &skel->bss->udp_memory_allocated);
+}
+
+static int check_bypass(struct test_case *test_case,
+			struct sk_bypass_prot_mem *skel, bool bypass)
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
+	if (bypass)
+		ASSERT_LE(memory_allocated[1], memory_allocated[0] + 10, "bypass");
+	else
+		ASSERT_GT(memory_allocated[1], memory_allocated[0] + NR_PAGES, "no bypass");
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
+	struct sk_bypass_prot_mem *skel;
+	struct nstoken *nstoken;
+	int cgroup, err;
+
+	skel = sk_bypass_prot_mem__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	skel->bss->nr_cpus = libbpf_num_possible_cpus();
+
+	err = sk_bypass_prot_mem__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto destroy_skel;
+
+	cgroup = test__join_cgroup("/sk_bypass_prot_mem");
+	if (!ASSERT_GE(cgroup, 0, "join_cgroup"))
+		goto destroy_skel;
+
+	err = make_netns("sk_bypass_prot_mem");
+	if (!ASSERT_EQ(err, 0, "make_netns"))
+		goto close_cgroup;
+
+	nstoken = open_netns("sk_bypass_prot_mem");
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto remove_netns;
+
+	err = check_bypass(test_case, skel, false);
+	if (!ASSERT_EQ(err, 0, "test_bypass(false)"))
+		goto close_netns;
+
+	err = write_sysctl("/proc/sys/net/core/bypass_prot_mem", "1");
+	if (!ASSERT_EQ(err, 0, "write_sysctl(1)"))
+		goto close_netns;
+
+	err = check_bypass(test_case, skel, true);
+	if (!ASSERT_EQ(err, 0, "test_bypass(true by sysctl)"))
+		goto close_netns;
+
+	err = write_sysctl("/proc/sys/net/core/bypass_prot_mem", "0");
+	if (!ASSERT_EQ(err, 0, "write_sysctl(0)"))
+		goto close_netns;
+
+	skel->links.sock_create = bpf_program__attach_cgroup(skel->progs.sock_create, cgroup);
+	if (!ASSERT_OK_PTR(skel->links.sock_create, "attach_cgroup(sock_create)"))
+		goto close_netns;
+
+	err = check_bypass(test_case, skel, true);
+	ASSERT_EQ(err, 0, "test_bypass(true by bpf)");
+
+close_netns:
+	close_netns(nstoken);
+remove_netns:
+	remove_netns("sk_bypass_prot_mem");
+close_cgroup:
+	close(cgroup);
+destroy_skel:
+	sk_bypass_prot_mem__destroy(skel);
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
+void serial_test_sk_bypass_prot_mem(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
+		if (test__start_subtest(test_cases[i].name))
+			run_test(&test_cases[i]);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c b/tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c
new file mode 100644
index 000000000000..09a00d11ffcc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c
@@ -0,0 +1,104 @@
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
+	int err, val = 1;
+
+	err = bpf_setsockopt(ctx, SOL_SOCKET, SK_BPF_BYPASS_PROT_MEM,
+			     &val, sizeof(val));
+	if (err)
+		goto err;
+
+	val = 0;
+
+	err = bpf_getsockopt(ctx, SOL_SOCKET, SK_BPF_BYPASS_PROT_MEM,
+			     &val, sizeof(val));
+	if (err)
+		goto err;
+
+	if (val != 1) {
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
2.51.0.710.ga91ca5db03-goog


