Return-Path: <bpf+bounces-68725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A70CB824F2
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 01:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3891C24C0D
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 23:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A04C32950F;
	Wed, 17 Sep 2025 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J95J5G0K"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0005D329500
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 23:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758152306; cv=none; b=Ngb1rg3YzPu0Gg3PGVTx4jDbQOQMXZ6q4G69HEXL66dWuheXaic141HGolBwgj11buvhovdszIBX7e+BwgzuPSLuVOYQ3ct2R1zoRZyO0YxykDPF79JmldAVrm3371WnsTb2vEkzUG842Ku0PasX9FSVehNDSeh+wr3JbMJsPV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758152306; c=relaxed/simple;
	bh=lrTHq0RZKlXNr12IIHcf/QuBQ8dQbTXenh1lsayWT2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPin7ZED491I20zz/jnFPHII9GQ0AbmBd+0Rf4QCILKFExc378DWDHU72M1u85q8NvQCbUrsoCrumsD7i+OEnUMPQxI+s+hZYg2MR3oce1oAfBF1nFy4+6sZCgHstVSEXGTc8LnnKMfFU4IM+YQHnIpeJCAlbV/qpiuHhG/XOeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J95J5G0K; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a706bb87-46e1-4524-8d35-8f22569a73e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758152299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slS7VafjOvasitxCHtJrhEeq6XWzVWafcmogWCG+nCQ=;
	b=J95J5G0KYuSu5/ZRohC8ixTS2Cv5u1SyMOf/kXXN1fbHlSpO5RpO9KYnesYeZLnrZyYpeb
	etiK5JIrDZ3L5F0ulrtw/TVmJ3auVBf7L3w0wL6ikULVDoNwnMgb2cRqodp1Pr3lqguUtt
	ep1hB/WdIw9Jde8GBbx4F4tMTHHYvaw=
Date: Wed, 17 Sep 2025 16:38:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9 bpf-next/net 6/6] selftest: bpf: Add test for
 SK_MEMCG_EXCLUSIVE.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250917191417.1056739-1-kuniyu@google.com>
 <20250917191417.1056739-7-kuniyu@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250917191417.1056739-7-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/17/25 12:14 PM, Kuniyuki Iwashima wrote:
> The test does the following for IPv4/IPv6 x TCP/UDP sockets
> with/without SK_MEMCG_EXCLUSIVE, which can be turned on by
> net.core.memcg_exclusive or bpf_setsockopt(SK_BPF_MEMCG_EXCLUSIVE).
> 
>    1. Create socket pairs
>    2. Send a bunch of data that requires more than 1024 pages
>    3. Read memory_allocated from sk->sk_prot->memory_allocated and
>       sk->sk_prot->memory_per_cpu_fw_alloc
>    4. Check if unread data is charged to memory_allocated
> 
> If SK_MEMCG_EXCLUSIVE is set, memory_allocated should not be
> changed, but we allow a small error (up to 10 pages) in case
> other processes on the host use some amounts of TCP/UDP memory.
> 
> The amount of allocated pages are buffered to per-cpu variable
> {tcp,udp}_memory_per_cpu_fw_alloc up to +/- net.core.mem_pcpu_rsv
> before reported to {tcp,udp}_memory_allocated.
> 
> At 3., memory_allocated is calculated from the 2 variables twice
> at fentry and fexit of socket create function to check if the per-cpu
> value is drained during calculation.  In that case, 3. is retried.
> 
> We use kern_sync_rcu() for UDP because UDP recv queue is destroyed
> after RCU grace period.
> 
> The test takes ~2s on QEMU (64 CPUs) w/ KVM but takes 6s w/o KVM.
> 
>    # time ./test_progs -t sk_memcg
>    #370/1   sk_memcg/TCP  :OK
>    #370/2   sk_memcg/UDP  :OK
>    #370/3   sk_memcg/TCPv6:OK
>    #370/4   sk_memcg/UDPv6:OK
>    #370     sk_memcg:OK
>    Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
> 
>    real	0m1.623s
>    user	0m0.165s
>    sys	0m0.366s
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v7:
>    * Add test for sysctl
> 
> v6:
>    * Trace sk_prot->memory_allocated + sk_prot->memory_per_cpu_fw_alloc
> 
> v5:
>    * Use kern_sync_rcu()
>    * Double NR_SEND to 128
> 
> v4:
>    * Only use inet_create() hook
>    * Test bpf_getsockopt()
>    * Add serial_ prefix
>    * Reduce sleep() and the amount of sent data
> ---
>   .../selftests/bpf/prog_tests/sk_memcg.c       | 261 ++++++++++++++++++
>   tools/testing/selftests/bpf/progs/sk_memcg.c  | 146 ++++++++++
>   2 files changed, 407 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_memcg.c
>   create mode 100644 tools/testing/selftests/bpf/progs/sk_memcg.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_memcg.c b/tools/testing/selftests/bpf/prog_tests/sk_memcg.c
> new file mode 100644
> index 000000000000..777fb81e9365
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sk_memcg.c
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright 2025 Google LLC */
> +
> +#include <test_progs.h>
> +#include "sk_memcg.skel.h"
> +#include "network_helpers.h"
> +
> +#define NR_SOCKETS	64
> +#define NR_SEND		128
> +#define BUF_SINGLE	1024
> +#define BUF_TOTAL	(BUF_SINGLE * NR_SEND)
> +
> +struct test_case {
> +	char name[8];
> +	int family;
> +	int type;
> +	int (*create_sockets)(struct test_case *test_case, int sk[], int len);
> +	long (*get_memory_allocated)(struct test_case *test_case, struct sk_memcg *skel);
> +};
> +
> +static int tcp_create_sockets(struct test_case *test_case, int sk[], int len)
> +{
> +	int server, i;
> +
> +	server = start_server(test_case->family, test_case->type, NULL, 0, 0);
> +	ASSERT_GE(server, 0, "start_server_str");
> +
> +	for (i = 0; i < len / 2; i++) {
> +		sk[i * 2] = connect_to_fd(server, 0);
> +		if (!ASSERT_GE(sk[i * 2], 0, "connect_to_fd"))
> +			return sk[i * 2];
> +
> +		sk[i * 2 + 1] = accept(server, NULL, NULL);
> +		if (!ASSERT_GE(sk[i * 2 + 1], 0, "accept"))
> +			return sk[i * 2 + 1];
> +	}
> +
> +	close(server);
> +
> +	return 0;
> +}
> +
> +static int udp_create_sockets(struct test_case *test_case, int sk[], int len)
> +{
> +	int i, err, rcvbuf = BUF_TOTAL;
> +
> +	for (i = 0; i < len / 2; i++) {

nit. How about "for (i = 0; i < len; i += 2) {" once here instead of "i * 2" 
below. Same for the tcp_create_sockets() above.

> +		sk[i * 2] = start_server(test_case->family, test_case->type, NULL, 0, 0);
> +		if (!ASSERT_GE(sk[i * 2], 0, "start_server"))
> +			return sk[i * 2];
> +
> +		sk[i * 2 + 1] = connect_to_fd(sk[i * 2], 0);
> +		if (!ASSERT_GE(sk[i * 2 + 1], 0, "connect_to_fd"))
> +			return sk[i * 2 + 1];
> +
> +		err = connect_fd_to_fd(sk[i * 2], sk[i * 2 + 1], 0);
> +		if (!ASSERT_EQ(err, 0, "connect_fd_to_fd"))
> +			return err;
> +
> +		err = setsockopt(sk[i * 2], SOL_SOCKET, SO_RCVBUF, &rcvbuf, sizeof(int));
> +		if (!ASSERT_EQ(err, 0, "setsockopt(SO_RCVBUF)"))
> +			return err;
> +
> +		err = setsockopt(sk[i * 2 + 1], SOL_SOCKET, SO_RCVBUF, &rcvbuf, sizeof(int));
> +		if (!ASSERT_EQ(err, 0, "setsockopt(SO_RCVBUF)"))
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static long get_memory_allocated(struct test_case *test_case,
> +				 bool *activated, bool *stable,
> +				 long *memory_allocated)
> +{
> +	*stable = false;
> +
> +	do {
> +		*activated = true;
> +
> +		/* AF_INET and AF_INET6 share the same memory_allocated.
> +		 * tcp_init_sock() is called by AF_INET and AF_INET6,
> +		 * but udp_lib_init_sock() is inline.
> +		 */
> +		socket(AF_INET, test_case->type, 0);

fd is leaked.

> +	} while (!*stable);

cannot loop forever. The test needs to assume the machine is relatively network 
quiet anyway (so serial_). Things can still change after the stable test also. I 
think having a way (the fentry in the progs/sk_memcg.c) to account for the 
percpu fw alloc is good enough, and this should help if there is some light 
background traffic that suddenly flush the hidden +255 percpu counter to the 
global one and another percpu counter still has a -254 for example.

> +
> +	return *memory_allocated;
> +}
> +
> +static long tcp_get_memory_allocated(struct test_case *test_case, struct sk_memcg *skel)
> +{
> +	return get_memory_allocated(test_case,
> +				    &skel->bss->tcp_activated,
> +				    &skel->bss->tcp_stable,
> +				    &skel->bss->tcp_memory_allocated);
> +}
> +
> +static long udp_get_memory_allocated(struct test_case *test_case, struct sk_memcg *skel)
> +{
> +	return get_memory_allocated(test_case,
> +				    &skel->bss->udp_activated,
> +				    &skel->bss->udp_stable,
> +				    &skel->bss->udp_memory_allocated);
> +}
> +
> +static int check_exclusive(struct test_case *test_case,
> +			   struct sk_memcg *skel, bool exclusive)
> +{
> +	char buf[BUF_SINGLE] = {};
> +	long memory_allocated[2];
> +	int sk[NR_SOCKETS] = {};
> +	int err, i, j;
> +
> +	err = test_case->create_sockets(test_case, sk, ARRAY_SIZE(sk));
> +	if (err)
> +		goto close;
> +
> +	memory_allocated[0] = test_case->get_memory_allocated(test_case, skel);
> +
> +	/* allocate pages >= 1024 */
> +	for (i = 0; i < ARRAY_SIZE(sk); i++) {
> +		for (j = 0; j < NR_SEND; j++) {
> +			int bytes = send(sk[i], buf, sizeof(buf), 0);
> +
> +			/* Avoid too noisy logs when something failed. */
> +			if (bytes != sizeof(buf)) {
> +				ASSERT_EQ(bytes, sizeof(buf), "send");
> +				if (bytes < 0) {
> +					err = bytes;
> +					goto close;
> +				}
> +			}
> +		}
> +	}
> +
> +	memory_allocated[1] = test_case->get_memory_allocated(test_case, skel);
> +
> +	if (exclusive)
> +		ASSERT_LE(memory_allocated[1], memory_allocated[0] + 10, "exclusive");
> +	else
> +		ASSERT_GT(memory_allocated[1], memory_allocated[0] + 1024, "not exclusive");The test is taking >10s in my environemnt. Although it has kasan and other dbg 
turned on, my environment is not a slow one tbh. The WATCHDOG > 10s warning is 
hit pretty often. The exclusive case is expecting +10. May be we just need to 
check +128 for non-exclusive which should be subtle enough to contrast with the 
exclusive case? With +128, NR_SEND 32 is more than enough?

> +
> +close:
> +	for (i = 0; i < ARRAY_SIZE(sk); i++)
> +		close(sk[i]);
> +
> +	if (test_case->type == SOCK_DGRAM) {
> +		/* UDP recv queue is destroyed after RCU grace period.
> +		 * With one kern_sync_rcu(), memory_allocated[0] of the
> +		 * isoalted case often matches with memory_allocated[1]
> +		 * of the preceding non-exclusive case.
> +		 */

I don't think I understand the double kern_sync_rcu() below.

> +		kern_sync_rcu();
> +		kern_sync_rcu();> +	}
> +
> +	return err;
> +}
> +
> +void run_test(struct test_case *test_case)

static

> +{
> +	struct nstoken *nstoken;
> +	struct sk_memcg *skel;
> +	int cgroup, err;
> +
> +	skel = sk_memcg__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	skel->bss->nr_cpus = libbpf_num_possible_cpus();
> +
> +	err = sk_memcg__attach(skel);
> +	if (!ASSERT_OK(err, "attach"))
> +		goto destroy_skel;
> +
> +	cgroup = test__join_cgroup("/sk_memcg");
> +	if (!ASSERT_GE(cgroup, 0, "join_cgroup"))
> +		goto destroy_skel;
> +
> +	err = make_netns("sk_memcg");
> +	if (!ASSERT_EQ(err, 0, "make_netns"))
> +		goto close_cgroup;
> +
> +	nstoken = open_netns("sk_memcg");
> +	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
> +		goto remove_netns;
> +
> +	err = check_exclusive(test_case, skel, false);
> +	if (!ASSERT_EQ(err, 0, "test_exclusive(false)"))
> +		goto close_netns;
> +
> +	err = write_sysctl("/proc/sys/net/core/memcg_exclusive", "1");
> +	if (!ASSERT_EQ(err, 0, "write_sysctl(1)"))
> +		goto close_netns;
> +
> +	err = check_exclusive(test_case, skel, true);
> +	if (!ASSERT_EQ(err, 0, "test_exclusive(true by sysctl)"))
> +		goto close_netns;
> +
> +	err = write_sysctl("/proc/sys/net/core/memcg_exclusive", "0");
> +	if (!ASSERT_EQ(err, 0, "write_sysctl(0)"))
> +		goto close_netns;
> +
> +	skel->links.sock_create = bpf_program__attach_cgroup(skel->progs.sock_create, cgroup);
> +	if (!ASSERT_OK_PTR(skel->links.sock_create, "attach_cgroup(sock_create)"))
> +		goto close_netns;
> +
> +	err = check_exclusive(test_case, skel, true);
> +	ASSERT_EQ(err, 0, "test_exclusive(true by bpf)");
> +
> +close_netns:
> +	close_netns(nstoken);
> +remove_netns:
> +	remove_netns("sk_memcg");
> +close_cgroup:
> +	close(cgroup);
> +destroy_skel:
> +	sk_memcg__destroy(skel);
> +}
> +
> +struct test_case test_cases[] = {
> +	{
> +		.name = "TCP  ",
> +		.family = AF_INET,
> +		.type = SOCK_STREAM,
> +		.create_sockets = tcp_create_sockets,
> +		.get_memory_allocated = tcp_get_memory_allocated,
> +	},
> +	{
> +		.name = "UDP  ",
> +		.family = AF_INET,
> +		.type = SOCK_DGRAM,
> +		.create_sockets = udp_create_sockets,
> +		.get_memory_allocated = udp_get_memory_allocated,
> +	},
> +	{
> +		.name = "TCPv6",
> +		.family = AF_INET6,
> +		.type = SOCK_STREAM,
> +		.create_sockets = tcp_create_sockets,
> +		.get_memory_allocated = tcp_get_memory_allocated,
> +	},
> +	{
> +		.name = "UDPv6",
> +		.family = AF_INET6,
> +		.type = SOCK_DGRAM,
> +		.create_sockets = udp_create_sockets,
> +		.get_memory_allocated = udp_get_memory_allocated,
> +	},
> +};
> +
> +void serial_test_sk_memcg(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
> +		test__start_subtest(test_cases[i].name);

This is not doing anything without "if".

> +		run_test(&test_cases[i]);
> +	}
> +}
> diff --git a/tools/testing/selftests/bpf/progs/sk_memcg.c b/tools/testing/selftests/bpf/progs/sk_memcg.c
> new file mode 100644
> index 000000000000..6b1a928a0c90
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/sk_memcg.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright 2025 Google LLC */
> +
> +#include "bpf_tracing_net.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <errno.h>
> +
> +extern int tcp_memory_per_cpu_fw_alloc __ksym;
> +extern int udp_memory_per_cpu_fw_alloc __ksym;
> +
> +int nr_cpus;
> +bool tcp_activated, tcp_stable, udp_activated, udp_stable;
> +long tcp_memory_allocated, udp_memory_allocated;
> +static struct sock *tcp_sk_tracing, *udp_sk_tracing;
> +
> +struct sk_prot {
> +	long *memory_allocated;
> +	int *memory_per_cpu_fw_alloc;
> +};
> +
> +static int drain_memory_per_cpu_fw_alloc(__u32 i, struct sk_prot *sk_prot_ctx)
> +{
> +	int *memory_per_cpu_fw_alloc;
> +
> +	memory_per_cpu_fw_alloc = bpf_per_cpu_ptr(sk_prot_ctx->memory_per_cpu_fw_alloc, i);
> +	if (memory_per_cpu_fw_alloc)
> +		*sk_prot_ctx->memory_allocated += *memory_per_cpu_fw_alloc;
> +
> +	return 0;
> +}
> +
> +static long get_memory_allocated(struct sock *_sk, int *memory_per_cpu_fw_alloc)
> +{
> +	struct sock *sk = bpf_core_cast(_sk, struct sock);
> +	struct sk_prot sk_prot_ctx;
> +	long memory_allocated;
> +
> +	/* net_aligned_data.{tcp,udp}_memory_allocated was not available. */
> +	memory_allocated = sk->__sk_common.skc_prot->memory_allocated->counter;
> +
> +	sk_prot_ctx.memory_allocated = &memory_allocated;
> +	sk_prot_ctx.memory_per_cpu_fw_alloc = memory_per_cpu_fw_alloc;
> +
> +	bpf_loop(nr_cpus, drain_memory_per_cpu_fw_alloc, &sk_prot_ctx, 0);
> +
> +	return memory_allocated;
> +}
> +
> +static void fentry_init_sock(struct sock *sk, struct sock **sk_tracing,
> +			     long *memory_allocated, int *memory_per_cpu_fw_alloc,
> +			     bool *activated)
> +{
> +	if (!*activated)
> +		return;
> +
> +	if (__sync_val_compare_and_swap(sk_tracing, NULL, sk))
> +		return;
> +
> +	*activated = false;
> +	*memory_allocated = get_memory_allocated(sk, memory_per_cpu_fw_alloc);
> +}
> +
> +static void fexit_init_sock(struct sock *sk, struct sock **sk_tracing,
> +			    long *memory_allocated, int *memory_per_cpu_fw_alloc,
> +			    bool *stable)
> +{
> +	long new_memory_allocated;
> +
> +	if (sk != *sk_tracing)
> +		return;
> +
> +	new_memory_allocated = get_memory_allocated(sk, memory_per_cpu_fw_alloc);
> +	if (new_memory_allocated == *memory_allocated)
> +		*stable = true;

I am not sure that help. The total memory_allocated can still change after this. 
I would just grab the total in fentry once and then move on without confirming 
in fexit.

> +
> +	*sk_tracing = NULL;
> +}
> +
> +SEC("fentry/tcp_init_sock")
> +int BPF_PROG(fentry_tcp_init_sock, struct sock *sk)
> +{
> +	fentry_init_sock(sk, &tcp_sk_tracing,
> +			 &tcp_memory_allocated, &tcp_memory_per_cpu_fw_alloc,
> +			 &tcp_activated);
> +	return 0;
> +}
> +
> +SEC("fexit/tcp_init_sock")
> +int BPF_PROG(fexit_tcp_init_sock, struct sock *sk)
> +{
> +	fexit_init_sock(sk, &tcp_sk_tracing,
> +			&tcp_memory_allocated, &tcp_memory_per_cpu_fw_alloc,
> +			&tcp_stable);
> +	return 0;
> +}
> +
> +SEC("fentry/udp_init_sock")
> +int BPF_PROG(fentry_udp_init_sock, struct sock *sk)
> +{
> +	fentry_init_sock(sk, &udp_sk_tracing,
> +			 &udp_memory_allocated, &udp_memory_per_cpu_fw_alloc,
> +			 &udp_activated);
> +	return 0;
> +}
> +
> +SEC("fexit/udp_init_sock")
> +int BPF_PROG(fexit_udp_init_sock, struct sock *sk)
> +{
> +	fexit_init_sock(sk, &udp_sk_tracing,
> +			&udp_memory_allocated, &udp_memory_per_cpu_fw_alloc,
> +			&udp_stable);
> +	return 0;
> +}
> +
> +SEC("cgroup/sock_create")
> +int sock_create(struct bpf_sock *ctx)
> +{
> +	u32 flags = SK_BPF_MEMCG_EXCLUSIVE;
> +	int err;
> +
> +	err = bpf_setsockopt(ctx, SOL_SOCKET, SK_BPF_MEMCG_FLAGS,
> +			     &flags, sizeof(flags));
> +	if (err)
> +		goto err;
> +
> +	flags = 0;
> +
> +	err = bpf_getsockopt(ctx, SOL_SOCKET, SK_BPF_MEMCG_FLAGS,
> +			     &flags, sizeof(flags));
> +	if (err)
> +		goto err;
> +
> +	if (flags != SK_BPF_MEMCG_EXCLUSIVE) {
> +		err = -EINVAL;
> +		goto err;
> +	}
> +
> +	return 1;
> +
> +err:
> +	bpf_set_retval(err);
> +	return 0;
> +}
> +
> +char LICENSE[] SEC("license") = "GPL";



