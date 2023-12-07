Return-Path: <bpf+bounces-16990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47A2808147
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 07:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 306EAB20F61
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 06:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCE814291;
	Thu,  7 Dec 2023 06:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Tcse1drf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A41D7E;
	Wed,  6 Dec 2023 22:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701932234; x=1733468234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Vvnpis/gz1oxHrTFjPIS40mGTkwslGlZ+OiZhWbfNc=;
  b=Tcse1drf+lsvtOfqM3x7q+O5UFpQv+EXLzUyBbkgrmDnhcLMn5VhqtTv
   n8sWW9NPQLTn6/bTsPDlOgVkrHf7Xd3HnMhKtFaMahcEcW7i6JQOeNQbw
   Zw5XJSO1vgh0GTpQO4edZiM+SliBrCQTWbTbpkAsIDodU9Xf/teVsWWIY
   g=;
X-IronPort-AV: E=Sophos;i="6.04,256,1695686400"; 
   d="scan'208";a="48900924"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-edda28d4.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 06:57:11 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-edda28d4.us-east-1.amazon.com (Postfix) with ESMTPS id 0057D804CF;
	Thu,  7 Dec 2023 06:57:09 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:53201]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.39.23:2525] with esmtp (Farcaster)
 id c7833ab3-6198-4674-8278-7e8f84362cf3; Thu, 7 Dec 2023 06:57:09 +0000 (UTC)
X-Farcaster-Flow-ID: c7833ab3-6198-4674-8278-7e8f84362cf3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 06:57:08 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.249) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 06:57:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <edumazet@google.com>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 bpf-next 3/3] selftest: bpf: Test bpf_sk_assign_tcp_reqsk().
Date: Thu, 7 Dec 2023 15:56:56 +0900
Message-ID: <20231207065656.23862-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <7e04fc5f-30a9-468e-bf07-49b00040b6db@linux.dev>
References: <7e04fc5f-30a9-468e-bf07-49b00040b6db@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Tue, 5 Dec 2023 22:39:33 -0800
> On 12/4/23 5:34 PM, Kuniyuki Iwashima wrote:
> > This commit adds a sample selftest to demonstrate how we can use
> > bpf_sk_assign_tcp_reqsk() as the backend of SYN Proxy.
> > 
> > The test creates IPv4/IPv6 x TCP/MPTCP connections and transfer
> > messages over them on lo with BPF tc prog attached.
> > 
> > The tc prog will process SYN and returns SYN+ACK with the following
> > ISN and TS.  In a real use case, this part will be done by other
> > hosts.
> > 
> >          MSB                                   LSB
> >    ISN:  | 31 ... 8 | 7 6 |   5 |    4 | 3 2 1 0 |
> >          |   Hash_1 | MSS | ECN | SACK |  WScale |
> > 
> >    TS:   | 31 ... 8 |          7 ... 0           |
> >          |   Random |           Hash_2           |
> 
> Thanks for the details. It is helpful.
> 
> > 
> >    WScale in SYN is reused in SYN+ACK.
> > 
> > The client returns ACK, and tc prog will recalculate ISN and TS
> > from ACK and validate SYN Cookie.
> > 
> > If it's valid, the prog calls kfunc to allocate a reqsk for skb and
> > configure the reqsk based on the argument created from SYN Cookie.
> > 
> > Later, the reqsk will be processed in cookie_v[46]_check() to create
> > a connection.
> > 
> 
> [ ... ]
> 
> > +SEC("tc")
> > +int tcp_custom_syncookie(struct __sk_buff *skb)
> > +{
> > +	struct tcp_syncookie ctx = {
> > +		.skb = skb,
> > +	};
> > +
> > +	if (tcp_load_headers(&ctx))
> > +		return TC_ACT_OK;
> > +
> > +	if (ctx.tcp->rst)
> > +		return TC_ACT_OK;
> > +
> > +	if (ctx.tcp->syn) {
> > +		if (ctx.tcp->ack)
> > +			return TC_ACT_OK;
> > +
> > +		return tcp_handle_syn(&ctx);
> > +	}
> > +
> > +	return tcp_handle_ack(&ctx);
> 
> It may be useful to ensure tcp_handle_{syn,ack} is executed instead of the 
> kernel doing the regular syncookie. A global variable (bool or counter) can be 
> used by the prog_tests to check.

Sure, will add that check.


> 
> > +}
> > +
> > +char _license[] SEC("license") = "GPL";
> > diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h
> > new file mode 100644
> > index 000000000000..a401f59e46d8
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h
> > @@ -0,0 +1,162 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright Amazon.com Inc. or its affiliates. */
> > +
> > +#ifndef _TEST_TCP_SYNCOOKIE_H
> > +#define _TEST_TCP_SYNCOOKIE_H
> > +
> > +#define TC_ACT_OK	0
> > +#define TC_ACT_SHOT	2
> > +
> > +#define ETH_ALEN	6
> > +#define ETH_P_IP	0x0800
> > +#define ETH_P_IPV6	0x86DD
> > +
> > +#define NEXTHDR_TCP	6
> > +
> > +#define TCPOPT_NOP		1
> > +#define TCPOPT_EOL		0
> > +#define TCPOPT_MSS		2
> > +#define TCPOPT_WINDOW		3
> > +#define TCPOPT_TIMESTAMP	8
> > +#define TCPOPT_SACK_PERM	4
> > +
> > +#define TCPOLEN_MSS		4
> > +#define TCPOLEN_WINDOW		3
> > +#define TCPOLEN_TIMESTAMP	10
> > +#define TCPOLEN_SACK_PERM	2
> 
> Some of the above is already in the bpf_tracing_net.h. Move the non-existing 
> ones to bpf_tracing_net.h also.

Will move it.


> 
> > +#define BPF_F_CURRENT_NETNS	(-1)
> 
> This should be already in the vmlinux.h

I thought so, but the kernel robot complained ...
https://lore.kernel.org/bpf/202311222353.3MM8wxm0-lkp@intel.com/

> 
> > +
> > +#define __packed __attribute__((__packed__))
> > +#define __force
> > +
> > +#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
> > +
> > +#define swap(a, b)				\
> > +	do {					\
> > +		typeof(a) __tmp = (a);		\
> > +		(a) = (b);			\
> > +		(b) = __tmp;			\
> > +	} while (0)
> > +
> > +#define swap_array(a, b)				\
> > +	do {						\
> > +		typeof(a) __tmp[sizeof(a)];		\
> > +		__builtin_memcpy(__tmp, a, sizeof(a));	\
> > +		__builtin_memcpy(a, b, sizeof(a));	\
> > +		__builtin_memcpy(b, __tmp, sizeof(a));	\
> > +	} while (0)
> > +
> > +/* asm-generic/unaligned.h */
> > +#define __get_unaligned_t(type, ptr) ({						\
> > +	const struct { type x; } __packed * __pptr = (typeof(__pptr))(ptr);	\
> > +	__pptr->x;								\
> > +})
> > +
> > +#define get_unaligned(ptr) __get_unaligned_t(typeof(*(ptr)), (ptr))
> > +
> > +static inline u16 get_unaligned_be16(const void *p)
> > +{
> > +	return bpf_ntohs(__get_unaligned_t(__be16, p));
> > +}
> > +
> > +static inline u32 get_unaligned_be32(const void *p)
> > +{
> > +	return bpf_ntohl(__get_unaligned_t(__be32, p));
> > +}
> > +
> > +/* lib/checksum.c */
> > +static inline u32 from64to32(u64 x)
> > +{
> > +	/* add up 32-bit and 32-bit for 32+c bit */
> > +	x = (x & 0xffffffff) + (x >> 32);
> > +	/* add up carry.. */
> > +	x = (x & 0xffffffff) + (x >> 32);
> > +	return (u32)x;
> > +}
> > +
> > +static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
> > +					__u32 len, __u8 proto, __wsum sum)
> > +{
> > +	unsigned long long s = (__force u32)sum;
> > +
> > +	s += (__force u32)saddr;
> > +	s += (__force u32)daddr;
> > +#ifdef __BIG_ENDIAN
> > +	s += proto + len;
> > +#else
> > +	s += (proto + len) << 8;
> > +#endif
> > +	return (__force __wsum)from64to32(s);
> > +}
> > +
> > +/* asm-generic/checksum.h */
> > +static inline __sum16 csum_fold(__wsum csum)
> > +{
> > +	u32 sum = (__force u32)csum;
> > +
> > +	sum = (sum & 0xffff) + (sum >> 16);
> > +	sum = (sum & 0xffff) + (sum >> 16);
> > +	return (__force __sum16)~sum;
> > +}
> > +
> > +static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr, __u32 len,
> > +					__u8 proto, __wsum sum)
> > +{
> > +	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
> > +}
> > +
> > +/* net/ipv6/ip6_checksum.c */
> > +static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
> > +				      const struct in6_addr *daddr,
> > +				      __u32 len, __u8 proto, __wsum csum)
> > +{
> > +	int carry;
> > +	__u32 ulen;
> > +	__u32 uproto;
> > +	__u32 sum = (__force u32)csum;
> > +
> > +	sum += (__force u32)saddr->in6_u.u6_addr32[0];
> > +	carry = (sum < (__force u32)saddr->in6_u.u6_addr32[0]);
> > +	sum += carry;
> > +
> > +	sum += (__force u32)saddr->in6_u.u6_addr32[1];
> > +	carry = (sum < (__force u32)saddr->in6_u.u6_addr32[1]);
> > +	sum += carry;
> > +
> > +	sum += (__force u32)saddr->in6_u.u6_addr32[2];
> > +	carry = (sum < (__force u32)saddr->in6_u.u6_addr32[2]);
> > +	sum += carry;
> > +
> > +	sum += (__force u32)saddr->in6_u.u6_addr32[3];
> > +	carry = (sum < (__force u32)saddr->in6_u.u6_addr32[3]);
> > +	sum += carry;
> > +
> > +	sum += (__force u32)daddr->in6_u.u6_addr32[0];
> > +	carry = (sum < (__force u32)daddr->in6_u.u6_addr32[0]);
> > +	sum += carry;
> > +
> > +	sum += (__force u32)daddr->in6_u.u6_addr32[1];
> > +	carry = (sum < (__force u32)daddr->in6_u.u6_addr32[1]);
> > +	sum += carry;
> > +
> > +	sum += (__force u32)daddr->in6_u.u6_addr32[2];
> > +	carry = (sum < (__force u32)daddr->in6_u.u6_addr32[2]);
> > +	sum += carry;
> > +
> > +	sum += (__force u32)daddr->in6_u.u6_addr32[3];
> > +	carry = (sum < (__force u32)daddr->in6_u.u6_addr32[3]);
> > +	sum += carry;
> > +
> > +	ulen = (__force u32)bpf_htonl((__u32)len);
> > +	sum += ulen;
> > +	carry = (sum < ulen);
> > +	sum += carry;
> > +
> > +	uproto = (__force u32)bpf_htonl(proto);
> > +	sum += uproto;
> > +	carry = (sum < uproto);
> > +	sum += carry;
> > +
> > +	return csum_fold((__force __wsum)sum);
> > +}
> 
> The above helpers are useful for other tests, so make sense to stay in 
> test_tcp_custom_syncookie.h. e.g. In the future, some of the duplicated helpers 
> in xdp_synproxy_kern.c can be removed.

Will post a followup patch after this series was merged.

Thanks!

