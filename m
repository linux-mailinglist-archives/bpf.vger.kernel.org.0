Return-Path: <bpf+bounces-18498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37F781AED3
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 07:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA0728682F
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 06:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D5CBA38;
	Thu, 21 Dec 2023 06:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gI4VwMlV"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DBE17989
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bd21939e-c6c8-4fb2-a4b6-e085a2230c8e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703140534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ko49BVL2CuEHlBz/olkzcGjHd1F9p4QV5+Fc8SJEqEk=;
	b=gI4VwMlVpnvU3pV6wQ0oxWRl5LJjGTRgVcCuV6TX/te8wDnx27i1She014SQyceA7e6LY/
	f+qQv8mOgTAEmWmYg3TQdlAdCEjl8HfpBafYeLOzKlfS2fhKIFHgMgXm7rWuQh7PeUuAXQ
	JOXAvBQ+gfF5lGm1Dlbg4Jla4/0Nvas=
Date: Wed, 20 Dec 2023 22:35:26 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 bpf-next 6/6] selftest: bpf: Test
 bpf_sk_assign_tcp_reqsk().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20231221012806.37137-1-kuniyu@amazon.com>
 <20231221012806.37137-7-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231221012806.37137-7-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/20/23 5:28 PM, Kuniyuki Iwashima wrote:
> +static int tcp_validate_header(struct tcp_syncookie *ctx)
> +{
> +	s64 csum;
> +
> +	if (tcp_reload_headers(ctx))
> +		goto err;
> +
> +	csum = bpf_csum_diff(0, 0, (void *)ctx->tcp, ctx->tcp->doff * 4, 0);
> +	if (csum < 0)
> +		goto err;
> +
> +	if (ctx->ipv4) {
> +		/* check tcp_v4_csum(csum) is 0 if not on lo. */
> +
> +		csum = bpf_csum_diff(0, 0, (void *)ctx->ipv4, ctx->ipv4->ihl * 4, 0);
> +		if (csum < 0)
> +			goto err;
> +
> +		if (csum_fold(csum) != 0)
> +			goto err;
> +	} else if (ctx->ipv6) {
> +		/* check tcp_v6_csum(csum) is 0 if not on lo. */
> +	}
> +
> +	return 0;
> +err:
> +	return -1;
> +}
> +
> +static int tcp_parse_option(__u32 index, struct tcp_syncookie *ctx)
> +{
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
> +			ctx->attrs.mss = get_unaligned_be16(ctx->ptr);
> +		break;
> +	case TCPOPT_WINDOW:
> +		if (opsize == TCPOLEN_WINDOW && ctx->tcp->syn &&
> +		    ctx->ptr + (TCPOLEN_WINDOW - 2) < ctx->data_end) {
> +			ctx->attrs.wscale_ok = 1;
> +			ctx->attrs.snd_wscale = *ctx->ptr;
> +		}
> +		break;
> +	case TCPOPT_TIMESTAMP:
> +		if (opsize == TCPOLEN_TIMESTAMP &&
> +		    ctx->ptr + (TCPOLEN_TIMESTAMP - 2) < ctx->data_end) {
> +			ctx->attrs.rcv_tsval = get_unaligned_be32(ctx->ptr);
> +			ctx->attrs.rcv_tsecr = get_unaligned_be32(ctx->ptr + 4);
> +
> +			if (ctx->tcp->syn && ctx->attrs.rcv_tsecr)
> +				ctx->attrs.tstamp_ok = 0;
> +			else
> +				ctx->attrs.tstamp_ok = 1;
> +		}
> +		break;
> +	case TCPOPT_SACK_PERM:
> +		if (opsize == TCPOLEN_SACK_PERM && ctx->tcp->syn &&
> +		    ctx->ptr + (TCPOLEN_SACK_PERM - 2) < ctx->data_end)
> +			ctx->attrs.sack_ok = 1;
> +		break;
> +	}
> +
> +	ctx->ptr += opsize - 2;
> +next:
> +	return 0;
> +stop:
> +	return 1;
> +}
> +
> +static void tcp_parse_options(struct tcp_syncookie *ctx)
> +{
> +	ctx->ptr = (char *)(ctx->tcp + 1);
> +
> +	bpf_loop(40, tcp_parse_option, ctx, 0);
> +}
> +
> +static int tcp_validate_sysctl(struct tcp_syncookie *ctx)
> +{
> +	if ((ctx->ipv4 && ctx->attrs.mss != MSS_LOCAL_IPV4) ||
> +	    (ctx->ipv6 && ctx->attrs.mss != MSS_LOCAL_IPV6))
> +		goto err;
> +
> +	if (!ctx->attrs.wscale_ok || ctx->attrs.snd_wscale != 7)
> +		goto err;
> +
> +	if (!ctx->attrs.tstamp_ok)

The bpf-ci reported error in cpuv4. The email from bot+bpf-ci@kernel.org has the 
link.

I tried the following:

	if (!ctx->attrs.tstamp_ok) {
		bpf_printk("ctx->attrs.tstamp_ok %u",
			ctx->attrs.tstamp_ok);
		goto err;
	}


The above prints tstamp_ok as 1 while there is a "if (!ctx->attrs.tstamp_ok)" 
test before it.

Yonghong and I debugged it quite a bit. verifier concluded the 
ctx->attrs.tstamp_ok is 0. We knew some red herring like cpuv4 has fewer 
register spilling but not able to root cause it yet.

In the mean time, there are existing selftests parsing the tcp header. For 
example, the test_parse_tcp_hdr_opt[_dynptr].c. Not as complete as your 
tcp_parse_option() but should be pretty close. It does not use bpf_loop. It uses 
a bounded loop + a subprog (the parse_hdr_opt in the selftests) instead. You can 
consider a similar construct to see if it works around the cpuv4 CI issue for 
the time being.

pw-bot: cr

> +		goto err;
> +
> +	if (!ctx->attrs.sack_ok)
> +		goto err;
> +
> +	if (!ctx->tcp->ece || !ctx->tcp->cwr)
> +		goto err;
> +
> +	return 0;
> +err:
> +	return -1;
> +}
> +

[ ... ]

> +static int tcp_handle_syn(struct tcp_syncookie *ctx)
> +{
> +	s64 csum;
> +
> +	if (tcp_validate_header(ctx))
> +		goto err;
> +
> +	tcp_parse_options(ctx);
> +
> +	if (tcp_validate_sysctl(ctx))
> +		goto err;
> +


