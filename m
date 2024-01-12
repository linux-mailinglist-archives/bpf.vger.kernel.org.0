Return-Path: <bpf+bounces-19463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 415FA82C50A
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 18:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DC91C21A2F
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 17:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9D717C8A;
	Fri, 12 Jan 2024 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QdHN8Urp"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0684A17C84
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e69f86ff-9751-4d06-a2d7-778d23b79fe1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705081853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Dyo+0kZQkBiLcHch8fYFaPG30B9VCEvCFIp7Z1X1xY=;
	b=QdHN8UrpahQyIW7880O2I7YPSu0i55/fZxuPdeBNEM8UxQtPHPFo4AEfAopnLRAHvj0+3G
	ornp9qFVBGunFtdpsa8AudyJjTDPiGIPrhJFAu+NZt7aUtGHc2r9eiUH75JXQtkB+L/kPG
	z7xs1oRNKDE01RIC8YxenNNIQpcM5yM=
Date: Fri, 12 Jan 2024 09:50:45 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf 3/3] selftests/bpf: Test udp and tcp iter batching
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
 'Andrii Nakryiko ' <andrii@kernel.org>,
 'Daniel Borkmann ' <daniel@iogearbox.net>, netdev@vger.kernel.org,
 kernel-team@meta.com
References: <20240110175743.2220907-1-martin.lau@linux.dev>
 <20240110175743.2220907-4-martin.lau@linux.dev>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240110175743.2220907-4-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/10/24 9:57 AM, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> The patch adds a test to exercise the bpf_iter_udp batching
> logic. It specifically tests the case that there are multiple
> so_reuseport udp_sk in a bucket of the udp_table.
>
> The test creates two sets of so_reuseport sockets and
> each set on a different port. Meaning there will be
> two buckets in the udp_table.
>
> The test does the following:
> 1. read() 3 out of 4 sockets in the first bucket.
> 2. close() all sockets in the first bucket. This
>     will ensure the current bucket's offset in
>     the kernel does not affect the read() of the
>     following bucket.
> 3. read() all 4 sockets in the second bucket.
>
> The test also reads one udp_sk at a time from
> the bpf_iter_udp prog. The true case in
> "do_test(..., bool onebyone)". This is the buggy case
> that the previous patch fixed.
>
> It also tests the "false" case in "do_test(..., bool onebyone)",
> meaning the userspace reads the whole bucket. There is
> no bug in this case but adding this test also while
> at it.
>
> Considering the way to have multiple tcp_sk in the same
> bucket is similar (by using so_reuseport),
> this patch also tests the bpf_iter_tcp even though the
> bpf_iter_tcp batching logic works correctly.
>
> Both IP v4 and v6 are exercising the same bpf_iter batching
> code path, so only v6 is tested.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

Ack with a few nits below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   .../bpf/prog_tests/sock_iter_batch.c          | 130 ++++++++++++++++++
>   .../selftests/bpf/progs/bpf_tracing_net.h     |   3 +
>   .../selftests/bpf/progs/sock_iter_batch.c     | 121 ++++++++++++++++
>   3 files changed, 254 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
>   create mode 100644 tools/testing/selftests/bpf/progs/sock_iter_batch.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
> new file mode 100644
> index 000000000000..55b1f3f3d862
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2024 Meta
> +
> +#include <test_progs.h>
> +#include "network_helpers.h"
> +#include "sock_iter_batch.skel.h"
> +
> +#define TEST_NS "sock_iter_batch_netns"
> +
> +static const int nr_soreuse = 4;
> +
> +static void do_test(int sock_type, bool onebyone)
> +{
> +	int err, i, nread, to_read, total_read, iter_fd = -1;
> +	int first_idx, second_idx, indices[nr_soreuse];
> +	struct bpf_link *link = NULL;
> +	struct sock_iter_batch *skel;
> +	int *fds[2] = {};
> +
> +	skel = sock_iter_batch__open();
> +	if (!ASSERT_OK_PTR(skel, "sock_iter_batch__open"))
> +		return;
> +
> +	/* Prepare 2 buckets of sockets in the kernel hashtable */
> +	for (i = 0; i < ARRAY_SIZE(fds); i++) {
> +		fds[i] = start_reuseport_server(AF_INET6, sock_type, "::1", 0, 0,
> +						nr_soreuse);
> +		if (!ASSERT_OK_PTR(fds[i], "start_reuseport_server"))
> +			goto done;
> +		skel->rodata->ports[i] = ntohs(get_socket_local_port(*fds[i]));

should we ASSERT whether get_socket_local_port() returns a valid port or not?
cgroup_tcp_skb.c and sock_destroy.c have similar usage of get_socket_local_port()
and they all have ASSERT on the return value.

> +	}
> +
> +	err = sock_iter_batch__load(skel);
> +	if (!ASSERT_OK(err, "sock_iter_batch__load"))
> +		goto done;
> +
> +	link = bpf_program__attach_iter(sock_type == SOCK_STREAM ?
> +					skel->progs.iter_tcp_soreuse :
> +					skel->progs.iter_udp_soreuse,
> +					NULL);
> +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_iter"))
> +		goto done;
> +
> +	iter_fd = bpf_iter_create(bpf_link__fd(link));
> +	if (!ASSERT_GE(iter_fd, 0, "bpf_iter_create"))
> +		goto done;
> +
> +	/* Test reading a bucket (either from fds[0] or fds[1]).
> +	 * Only read "nr_soreuse - 1" number of sockets
> +	 * from a bucket and leave one socket out from
> +	 * that bucket on purpose.
> +	 */
> +	to_read = (nr_soreuse - 1) * sizeof(*indices);
> +	total_read = 0;
> +	first_idx = -1;
> +	do {
> +		nread = read(iter_fd, indices, onebyone ? sizeof(*indices) : to_read);
> +		if (nread <= 0 || nread % sizeof(*indices))
> +			break;
> +		total_read += nread;
> +
> +		if (first_idx == -1)
> +			first_idx = indices[0];
> +		for (i = 0; i < nread / sizeof(*indices); i++)
> +			ASSERT_EQ(indices[i], first_idx, "first_idx");
> +	} while (total_read < to_read);
> +	ASSERT_EQ(nread, onebyone ? sizeof(*indices) : to_read, "nread");
> +	ASSERT_EQ(total_read, to_read, "total_read");
> +
> +	free_fds(fds[first_idx], nr_soreuse);
> +	fds[first_idx] = NULL;
> +
> +	/* Read the "whole" second bucket */
> +	to_read = nr_soreuse * sizeof(*indices);
> +	total_read = 0;
> +	second_idx = !first_idx;
> +	do {
> +		nread = read(iter_fd, indices, onebyone ? sizeof(*indices) : to_read);
> +		if (nread <= 0 || nread % sizeof(*indices))
> +			break;
> +		total_read += nread;
> +
> +		for (i = 0; i < nread / sizeof(*indices); i++)
> +			ASSERT_EQ(indices[i], second_idx, "second_idx");
> +	} while (total_read <= to_read);
> +	ASSERT_EQ(nread, 0, "nread");
> +	/* Both so_reuseport ports should be in different buckets, so
> +	 * total_read must equal to the expected to_read.
> +	 *
> +	 * For a very unlikely case, both ports collide at the same bucket,
> +	 * the bucket offset (i.e. 3) will be skipped and it cannot
> +	 * expect the to_read number of bytes.
> +	 */
> +	if (skel->bss->bucket[0] != skel->bss->bucket[1])
> +		ASSERT_EQ(total_read, to_read, "total_read");
> +
> +done:
> +	for (i = 0; i < ARRAY_SIZE(fds); i++)
> +		free_fds(fds[i], nr_soreuse);
> +	if (iter_fd != -1)

iter_fd < 0?
bpf_iter_create() returns libbpf_err_errno(fd) and
libbpf_err_errno() returns -errno in case of error.

> +		close(iter_fd);
> +	bpf_link__destroy(link);
> +	sock_iter_batch__destroy(skel);
> +}
> +
[...]
> diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> index 0b793a102791..8cc2e869b34b 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> @@ -71,6 +71,8 @@
>   #define inet_rcv_saddr		sk.__sk_common.skc_rcv_saddr
>   #define inet_dport		sk.__sk_common.skc_dport
>   
> +#define udp_portaddr_hash	inet.sk.__sk_common.skc_u16hashes[1]
> +
>   #define ir_loc_addr		req.__req_common.skc_rcv_saddr
>   #define ir_num			req.__req_common.skc_num
>   #define ir_rmt_addr		req.__req_common.skc_daddr
> @@ -84,6 +86,7 @@
>   #define sk_rmem_alloc		sk_backlog.rmem_alloc
>   #define sk_refcnt		__sk_common.skc_refcnt
>   #define sk_state		__sk_common.skc_state
> +#define sk_net			__sk_common.skc_net
>   #define sk_v6_daddr		__sk_common.skc_v6_daddr
>   #define sk_v6_rcv_saddr		__sk_common.skc_v6_rcv_saddr
>   #define sk_flags		__sk_common.skc_flags
> diff --git a/tools/testing/selftests/bpf/progs/sock_iter_batch.c b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
> new file mode 100644
> index 000000000000..cc2181f95046
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2024 Meta
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
> +#include <bpf/bpf_endian.h>
> +#include "bpf_tracing_net.h"
> +#include "bpf_kfuncs.h"
> +
> +/* __always_inline to avoid the unused function warning for jhash() */

The above comments are not precise. Without below define ATTR,
the compilation error message:

In file included from progs/sock_iter_batch.c:13:
progs/test_jhash.h:35:8: error: unknown type name 'ATTR'
    35 | static ATTR
       |        ^
progs/test_jhash.h:36:4: error: expected ';' after top level declarator
    36 | u32 jhash(const void *key, u32 length, u32 initval)
       |    ^
       |    ;
2 errors generated.

I think the comment is not needed. It will be self-explanary
if people look at test_jhash.h. Or you could add

> +#define ATTR __always_inline
> +#include "test_jhash.h"
> +
> +static u32 jhash2(const u32 *k, u32 length, u32 initval)
> +{
> +	u32 a, b, c;
> +
> +	/* Set up the internal state */
> +	a = b = c = JHASH_INITVAL + (length<<2) + initval;
> +
> +	/* Handle most of the key */
> +	while (length > 3) {
> +		a += k[0];
> +		b += k[1];
> +		c += k[2];
> +		__jhash_mix(a, b, c);
> +		length -= 3;
> +		k += 3;
> +	}
> +
> +	/* Handle the last 3 u32's */
> +	switch (length) {
> +	case 3: c += k[2];
> +	case 2: b += k[1];
> +	case 1: a += k[0];
> +		__jhash_final(a, b, c);
> +		break;
> +	case 0:	/* Nothing left to add */
> +		break;
> +	}
> +
> +	return c;
> +}

You could add the above function to test_jhash.h as well
for future reuse. But I am also okay not moving it since
this is the only usage for now.

> +
> +static bool ipv6_addr_loopback(const struct in6_addr *a)
> +{
> +	return (a->s6_addr32[0] | a->s6_addr32[1] |
> +		a->s6_addr32[2] | (a->s6_addr32[3] ^ bpf_htonl(1))) == 0;
> +}
> +
> +volatile const __u16 ports[2];
> +unsigned int bucket[2];
> +
> +SEC("iter/tcp")
> +int iter_tcp_soreuse(struct bpf_iter__tcp *ctx)
> +{
> +	struct sock *sk = (struct sock *)ctx->sk_common;
> +	struct inet_hashinfo *hinfo;
> +	unsigned int hash;
> +	struct net *net;
> +	int idx;
> +
> +	if (!sk)
> +		return 0;
> +
> +	sk = bpf_rdonly_cast(sk, bpf_core_type_id_kernel(struct sock));
> +	if (sk->sk_family != AF_INET6 ||
> +	    sk->sk_state != TCP_LISTEN ||
> +	    !ipv6_addr_loopback(&sk->sk_v6_rcv_saddr))
> +		return 0;
> +
> +	if (sk->sk_num == ports[0])
> +		idx = 0;
> +	else if (sk->sk_num == ports[1])
> +		idx = 1;
> +	else
> +		return 0;
> +
> +	net = sk->sk_net.net;
> +	hash = jhash2(sk->sk_v6_rcv_saddr.s6_addr32, 4, net->hash_mix);
> +	hash ^= sk->sk_num;
> +	hinfo = net->ipv4.tcp_death_row.hashinfo;
> +	bucket[idx] = hash & hinfo->lhash2_mask;
> +	bpf_seq_write(ctx->meta->seq, &idx, sizeof(idx));

Maybe add a little bit comments to refer to the corresponding
kernel implementation of computing the hash? This will make
cross-checking easier. The same for below udp hash computation.

> +
> +	return 0;
> +}
> +
> +#define udp_sk(ptr) container_of(ptr, struct udp_sock, inet.sk)
> +
> +SEC("iter/udp")
> +int iter_udp_soreuse(struct bpf_iter__udp *ctx)
> +{
> +	struct sock *sk = (struct sock *)ctx->udp_sk;
> +	struct udp_table *udptable;
> +	int idx;
> +
> +	if (!sk)
> +		return 0;
> +
> +	sk = bpf_rdonly_cast(sk, bpf_core_type_id_kernel(struct sock));
> +	if (sk->sk_family != AF_INET6 ||
> +	    !ipv6_addr_loopback(&sk->sk_v6_rcv_saddr))
> +		return 0;
> +
> +	if (sk->sk_num == ports[0])
> +		idx = 0;
> +	else if (sk->sk_num == ports[1])
> +		idx = 1;
> +	else
> +		return 0;
> +
> +	udptable = sk->sk_net.net->ipv4.udp_table;
> +	bucket[idx] = udp_sk(sk)->udp_portaddr_hash & udptable->mask;
> +	bpf_seq_write(ctx->meta->seq, &idx, sizeof(idx));
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";

