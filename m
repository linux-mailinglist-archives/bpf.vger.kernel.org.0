Return-Path: <bpf+bounces-16853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A51B8067A7
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 07:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F135B1C211E5
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 06:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2CA111A4;
	Wed,  6 Dec 2023 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ki/USa01"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C59410C3
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 22:39:43 -0800 (PST)
Message-ID: <7e04fc5f-30a9-468e-bf07-49b00040b6db@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701844781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C+rRkxEDsRVqGW4fFbNq980n2/wUjGiwZBnVQet7ykY=;
	b=Ki/USa01yldyhh07jb4x9NHYDor2c2d7nolGuPt9yRBjrQPd8PF4iZHIh2zrZUbbWCsZie
	UXfaQtHxhjxWg3WTFkKpVEhzYTiBGVN5I3RwR0Ag8rk5uCNEYKHW8XkhqyCpQwQTEJok5L
	FPovi2gESwwTCpm0eIq6EN6On0KGp+I=
Date: Tue, 5 Dec 2023 22:39:33 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 3/3] selftest: bpf: Test
 bpf_sk_assign_tcp_reqsk().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
References: <20231205013420.88067-1-kuniyu@amazon.com>
 <20231205013420.88067-4-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231205013420.88067-4-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/4/23 5:34 PM, Kuniyuki Iwashima wrote:
> This commit adds a sample selftest to demonstrate how we can use
> bpf_sk_assign_tcp_reqsk() as the backend of SYN Proxy.
> 
> The test creates IPv4/IPv6 x TCP/MPTCP connections and transfer
> messages over them on lo with BPF tc prog attached.
> 
> The tc prog will process SYN and returns SYN+ACK with the following
> ISN and TS.  In a real use case, this part will be done by other
> hosts.
> 
>          MSB                                   LSB
>    ISN:  | 31 ... 8 | 7 6 |   5 |    4 | 3 2 1 0 |
>          |   Hash_1 | MSS | ECN | SACK |  WScale |
> 
>    TS:   | 31 ... 8 |          7 ... 0           |
>          |   Random |           Hash_2           |

Thanks for the details. It is helpful.

> 
>    WScale in SYN is reused in SYN+ACK.
> 
> The client returns ACK, and tc prog will recalculate ISN and TS
> from ACK and validate SYN Cookie.
> 
> If it's valid, the prog calls kfunc to allocate a reqsk for skb and
> configure the reqsk based on the argument created from SYN Cookie.
> 
> Later, the reqsk will be processed in cookie_v[46]_check() to create
> a connection.
> 

[ ... ]

> +SEC("tc")
> +int tcp_custom_syncookie(struct __sk_buff *skb)
> +{
> +	struct tcp_syncookie ctx = {
> +		.skb = skb,
> +	};
> +
> +	if (tcp_load_headers(&ctx))
> +		return TC_ACT_OK;
> +
> +	if (ctx.tcp->rst)
> +		return TC_ACT_OK;
> +
> +	if (ctx.tcp->syn) {
> +		if (ctx.tcp->ack)
> +			return TC_ACT_OK;
> +
> +		return tcp_handle_syn(&ctx);
> +	}
> +
> +	return tcp_handle_ack(&ctx);

It may be useful to ensure tcp_handle_{syn,ack} is executed instead of the 
kernel doing the regular syncookie. A global variable (bool or counter) can be 
used by the prog_tests to check.

> +}
> +
> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h
> new file mode 100644
> index 000000000000..a401f59e46d8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright Amazon.com Inc. or its affiliates. */
> +
> +#ifndef _TEST_TCP_SYNCOOKIE_H
> +#define _TEST_TCP_SYNCOOKIE_H
> +
> +#define TC_ACT_OK	0
> +#define TC_ACT_SHOT	2
> +
> +#define ETH_ALEN	6
> +#define ETH_P_IP	0x0800
> +#define ETH_P_IPV6	0x86DD
> +
> +#define NEXTHDR_TCP	6
> +
> +#define TCPOPT_NOP		1
> +#define TCPOPT_EOL		0
> +#define TCPOPT_MSS		2
> +#define TCPOPT_WINDOW		3
> +#define TCPOPT_TIMESTAMP	8
> +#define TCPOPT_SACK_PERM	4
> +
> +#define TCPOLEN_MSS		4
> +#define TCPOLEN_WINDOW		3
> +#define TCPOLEN_TIMESTAMP	10
> +#define TCPOLEN_SACK_PERM	2

Some of the above is already in the bpf_tracing_net.h. Move the non-existing 
ones to bpf_tracing_net.h also.

> +#define BPF_F_CURRENT_NETNS	(-1)

This should be already in the vmlinux.h

> +
> +#define __packed __attribute__((__packed__))
> +#define __force
> +
> +#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
> +
> +#define swap(a, b)				\
> +	do {					\
> +		typeof(a) __tmp = (a);		\
> +		(a) = (b);			\
> +		(b) = __tmp;			\
> +	} while (0)
> +
> +#define swap_array(a, b)				\
> +	do {						\
> +		typeof(a) __tmp[sizeof(a)];		\
> +		__builtin_memcpy(__tmp, a, sizeof(a));	\
> +		__builtin_memcpy(a, b, sizeof(a));	\
> +		__builtin_memcpy(b, __tmp, sizeof(a));	\
> +	} while (0)
> +
> +/* asm-generic/unaligned.h */
> +#define __get_unaligned_t(type, ptr) ({						\
> +	const struct { type x; } __packed * __pptr = (typeof(__pptr))(ptr);	\
> +	__pptr->x;								\
> +})
> +
> +#define get_unaligned(ptr) __get_unaligned_t(typeof(*(ptr)), (ptr))
> +
> +static inline u16 get_unaligned_be16(const void *p)
> +{
> +	return bpf_ntohs(__get_unaligned_t(__be16, p));
> +}
> +
> +static inline u32 get_unaligned_be32(const void *p)
> +{
> +	return bpf_ntohl(__get_unaligned_t(__be32, p));
> +}
> +
> +/* lib/checksum.c */
> +static inline u32 from64to32(u64 x)
> +{
> +	/* add up 32-bit and 32-bit for 32+c bit */
> +	x = (x & 0xffffffff) + (x >> 32);
> +	/* add up carry.. */
> +	x = (x & 0xffffffff) + (x >> 32);
> +	return (u32)x;
> +}
> +
> +static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
> +					__u32 len, __u8 proto, __wsum sum)
> +{
> +	unsigned long long s = (__force u32)sum;
> +
> +	s += (__force u32)saddr;
> +	s += (__force u32)daddr;
> +#ifdef __BIG_ENDIAN
> +	s += proto + len;
> +#else
> +	s += (proto + len) << 8;
> +#endif
> +	return (__force __wsum)from64to32(s);
> +}
> +
> +/* asm-generic/checksum.h */
> +static inline __sum16 csum_fold(__wsum csum)
> +{
> +	u32 sum = (__force u32)csum;
> +
> +	sum = (sum & 0xffff) + (sum >> 16);
> +	sum = (sum & 0xffff) + (sum >> 16);
> +	return (__force __sum16)~sum;
> +}
> +
> +static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr, __u32 len,
> +					__u8 proto, __wsum sum)
> +{
> +	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
> +}
> +
> +/* net/ipv6/ip6_checksum.c */
> +static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
> +				      const struct in6_addr *daddr,
> +				      __u32 len, __u8 proto, __wsum csum)
> +{
> +	int carry;
> +	__u32 ulen;
> +	__u32 uproto;
> +	__u32 sum = (__force u32)csum;
> +
> +	sum += (__force u32)saddr->in6_u.u6_addr32[0];
> +	carry = (sum < (__force u32)saddr->in6_u.u6_addr32[0]);
> +	sum += carry;
> +
> +	sum += (__force u32)saddr->in6_u.u6_addr32[1];
> +	carry = (sum < (__force u32)saddr->in6_u.u6_addr32[1]);
> +	sum += carry;
> +
> +	sum += (__force u32)saddr->in6_u.u6_addr32[2];
> +	carry = (sum < (__force u32)saddr->in6_u.u6_addr32[2]);
> +	sum += carry;
> +
> +	sum += (__force u32)saddr->in6_u.u6_addr32[3];
> +	carry = (sum < (__force u32)saddr->in6_u.u6_addr32[3]);
> +	sum += carry;
> +
> +	sum += (__force u32)daddr->in6_u.u6_addr32[0];
> +	carry = (sum < (__force u32)daddr->in6_u.u6_addr32[0]);
> +	sum += carry;
> +
> +	sum += (__force u32)daddr->in6_u.u6_addr32[1];
> +	carry = (sum < (__force u32)daddr->in6_u.u6_addr32[1]);
> +	sum += carry;
> +
> +	sum += (__force u32)daddr->in6_u.u6_addr32[2];
> +	carry = (sum < (__force u32)daddr->in6_u.u6_addr32[2]);
> +	sum += carry;
> +
> +	sum += (__force u32)daddr->in6_u.u6_addr32[3];
> +	carry = (sum < (__force u32)daddr->in6_u.u6_addr32[3]);
> +	sum += carry;
> +
> +	ulen = (__force u32)bpf_htonl((__u32)len);
> +	sum += ulen;
> +	carry = (sum < ulen);
> +	sum += carry;
> +
> +	uproto = (__force u32)bpf_htonl(proto);
> +	sum += uproto;
> +	carry = (sum < uproto);
> +	sum += carry;
> +
> +	return csum_fold((__force __wsum)sum);
> +}

The above helpers are useful for other tests, so make sense to stay in 
test_tcp_custom_syncookie.h. e.g. In the future, some of the duplicated helpers 
in xdp_synproxy_kern.c can be removed.

> +#endif


