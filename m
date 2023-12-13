Return-Path: <bpf+bounces-17721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DAC812027
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 21:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9842D1C21290
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 20:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E4C7E573;
	Wed, 13 Dec 2023 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jWg18e/6"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863E9DD
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 12:44:51 -0800 (PST)
Message-ID: <8fccb066-6d17-4fa8-ba67-287042046ea4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702500289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CXEmSiijjLrpapVsdj7qXE2yuQ7usappAWQ0VpcvhiQ=;
	b=jWg18e/6SGX979GAUUvuWZu3XH3dbs5yr6qHEEfdtAU9E08jojjrlY711hF6wytK2p9Qer
	poIf+XOZivG44PWAvZEi4JyVHf5+z2XCDCRtSSXLO4j7pVL9cO6VabmJhoITxTSzf7sKXk
	pI0yBqy/G0cshSfPJmLmTPfoDK4RsFw=
Date: Wed, 13 Dec 2023 12:44:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 6/6] selftest: bpf: Test
 bpf_sk_assign_tcp_reqsk().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Daniel Xu <dxu@dxuuu.xyz>,
 Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
References: <20231211073650.90819-1-kuniyu@amazon.com>
 <20231211073650.90819-7-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231211073650.90819-7-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/10/23 11:36 PM, Kuniyuki Iwashima wrote:
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

The patch set looks good.

One thing I just noticed is about writing/reading bits into/from "struct 
tcp_options_received". More on this below.

[ ... ]

> +void test_tcp_custom_syncookie(void)
> +{
> +	struct test_tcp_custom_syncookie *skel;
> +	int i;
> +
> +	if (setup_netns())
> +		return;
> +
> +	skel = test_tcp_custom_syncookie__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	if (setup_tc(skel))
> +		goto destroy_skel;
> +
> +	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
> +		skel->bss->handled_syn = false;
> +		skel->bss->handled_ack = false;
> +
> +		test__start_subtest(test_cases[i].name);


This should be tested with:

	if (!test__start_subtest(test_cases[i].name))
		continue;

to skip the create_connection(). Probably do it at the beginning of the for loop.

> +		create_connection(&test_cases[i]);
> +
> +		ASSERT_EQ(skel->bss->handled_syn, true, "SYN is not handled at tc.");
> +		ASSERT_EQ(skel->bss->handled_ack, true, "ACK is not handled at tc");
> +	}
> +
> +destroy_skel:
> +	system("tc qdisc del dev lo clsact");
> +
> +	test_tcp_custom_syncookie__destroy(skel);
> +}

[ ... ]

> +static int tcp_parse_option(__u32 index, struct tcp_syncookie *ctx)
> +{
> +	struct tcp_options_received *tcp_opt = &ctx->attr.tcp_opt;
> +	char opcode, opsize;
> +
> +	if (ctx->ptr + 1 > ctx->data_end)
> +		goto stop;
> +
> +	opcode = *ctx->ptr++;
> +
> +	if (opcode == TCPOPT_EOL)
> +		goto stop;
> +
> +	if (opcode == TCPOPT_NOP)
> +		goto next;
> +
> +	if (ctx->ptr + 1 > ctx->data_end)
> +		goto stop;
> +
> +	opsize = *ctx->ptr++;
> +
> +	if (opsize < 2)
> +		goto stop;
> +
> +	switch (opcode) {
> +	case TCPOPT_MSS:
> +		if (opsize == TCPOLEN_MSS && ctx->tcp->syn &&
> +		    ctx->ptr + (TCPOLEN_MSS - 2) < ctx->data_end)
> +			tcp_opt->mss_clamp = get_unaligned_be16(ctx->ptr);
> +		break;
> +	case TCPOPT_WINDOW:
> +		if (opsize == TCPOLEN_WINDOW && ctx->tcp->syn &&
> +		    ctx->ptr + (TCPOLEN_WINDOW - 2) < ctx->data_end) {
> +			tcp_opt->wscale_ok = 1;
> +			tcp_opt->snd_wscale = *ctx->ptr;

When writing to a bitfield of "struct tcp_options_received" which is a kernel 
struct, it needs to use the CO-RE api. The BPF_CORE_WRITE_BITFIELD has not been 
landed yet: 
https://lore.kernel.org/bpf/4d3dd215a4fd57d980733886f9c11a45e1a9adf3.1702325874.git.dxu@dxuuu.xyz/

The same for reading bitfield but BPF_CORE_READ_BITFIELD() has already been 
implemented in bpf_core_read.h

Once the BPF_CORE_WRITE_BITFIELD is landed, this test needs to be changed to use 
the BPF_CORE_{READ,WRITE}_BITFIELD.

> +		}
> +		break;
> +	case TCPOPT_TIMESTAMP:
> +		if (opsize == TCPOLEN_TIMESTAMP &&
> +		    ctx->ptr + (TCPOLEN_TIMESTAMP - 2) < ctx->data_end) {
> +			tcp_opt->saw_tstamp = 1;
> +			tcp_opt->rcv_tsval = get_unaligned_be32(ctx->ptr);
> +			tcp_opt->rcv_tsecr = get_unaligned_be32(ctx->ptr + 4);
> +
> +			if (ctx->tcp->syn && tcp_opt->rcv_tsecr)
> +				tcp_opt->tstamp_ok = 0;
> +			else
> +				tcp_opt->tstamp_ok = 1;
> +		}
> +		break;
> +	case TCPOPT_SACK_PERM:
> +		if (opsize == TCPOLEN_SACK_PERM && ctx->tcp->syn &&
> +		    ctx->ptr + (TCPOLEN_SACK_PERM - 2) < ctx->data_end)
> +			tcp_opt->sack_ok = 1;
> +		break;
> +	}
> +
> +	ctx->ptr += opsize - 2;
> +next:
> +	return 0;
> +stop:
> +	return 1;
> +}



