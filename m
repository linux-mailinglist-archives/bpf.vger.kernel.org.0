Return-Path: <bpf+bounces-28395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CFC8B907F
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 22:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F491C22BD3
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 20:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696381635B5;
	Wed,  1 May 2024 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CpbfQLyv"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF71635A4
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594789; cv=none; b=lJ581HnpnfH8SnvTMnePpTB1yCfYNvEjSlLgRdlDV/o01FpCV55kHHFft64qWCuaVaeq43hv28LEzKaxmv56F60E//WW5J1p2DZrMSU1/lnMjKPqIgyIkyrC9eJY4s8LxQkJlPA1po8fwJgaaF6TZ2/96zFQufBghY3ikaTdvIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594789; c=relaxed/simple;
	bh=ZjYCQKJOfsopt4TvhGlDDrsAfLUHPktwffSbt/6tcQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iq3p5wS7Eel8reL3rtrF4zZ8J55gZxzb9BiY6I+jievIu7v2F769HJgjKa5dD65lhIZuctfRJSTWaYTnQ0n8GGCa1EbtE8lNk8FwGrwqNMJljCWL+wdbRaMW2t/g/RSFZc72rEyRX8GBcg+RhBE8Z8MMS51gJmyBIhwecDpMlgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CpbfQLyv; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a9aa6df0-b6ee-4512-acbe-7e30c98bba25@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714594785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5jk2HaGW95j1hEmVkOcC1ChSD3MUX4ikdql3+VHiIpY=;
	b=CpbfQLyvxYMJPklPAdTL1tmF89XE6qU7PcfW2dlndiS8eIap7w8z4KeF6WlZt/IxhO6Jwr
	0kmfdSucPp6EzsC1CJ0GrrkRfC+Oeq/iDcPpKMEqUIB+nzdxZ+FyYjyDn5PFs52KM+A8m5
	LRr4wcaao6fgFiu6TlgTHqY53i6t/4Q=
Date: Wed, 1 May 2024 13:19:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 3/3] Add test for the use of new args in
 cong_control
To: Miao Xu <miaxu@meta.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Martin Lau <kafai@meta.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20240501074338.362361-1-miaxu@meta.com>
 <20240501074338.362361-3-miaxu@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240501074338.362361-3-miaxu@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/1/24 12:43 AM, Miao Xu wrote:
> This patch adds a selftest to show the usage of the new arguments in
> cong_control. For simplicity's sake, the testing example reuses cubic's
> kernel functions.

Jakub, is it ok to target the set for the bpf-next?

The bpf_tcp_ca test failed (Jakub also mentioned). The progs/tcp_ca_kfunc.c 
requires changes. The func signature of bbr_main and the BPF_PROG(cong_control, 
...) has to be adjusted.

Since it needs a respin, a few nits.

Please add "selftests/bpf:" to the subject line of this patch 3. I think Patch 1 
can use "tcp:" and patch 2 can use "bpf: tcp:" also.

Please also add a cover letter, git format-patch --cover-letter ...

[ ... ]

> +void BPF_STRUCT_OPS(bpf_cubic_cong_control, struct sock *sk, __u32 ack, int flag,
> +		const struct rate_sample *rs)
> +{
> +	struct tcp_sock *tp = tcp_sk(sk);
> +
> +	if (((1<<TCP_CA_CWR) | (1<<TCP_CA_Recovery)) &
> +			(1 << inet_csk(sk)->icsk_ca_state)) {
> +		/* Reduce cwnd if state mandates */
> +		tcp_cwnd_reduction(sk, rs->acked_sacked, rs->losses, flag);
> +
> +		if (!before(tp->snd_una, tp->high_seq)) {
> +			/* Reset cwnd to ssthresh in CWR or Recovery (unless it's undone) */
> +			if (tp->snd_ssthresh < TCP_INFINITE_SSTHRESH &&
> +					inet_csk(sk)->icsk_ca_state == TCP_CA_CWR) {
> +				tp->snd_cwnd = tp->snd_ssthresh;
> +				tp->snd_cwnd_stamp = tcp_jiffies32;
> +			}
> +			// __cwnd_event(sk, CA_EVENT_COMPLETE_CWR);

Remove the commented out code.

> +		}
> +	} else if (tcp_may_raise_cwnd(sk, flag)) {
> +		/* Advance cwnd if state allows */
> +		cubictcp_cong_avoid(sk, ack, rs->acked_sacked);
> +		tp->snd_cwnd_stamp = tcp_jiffies32;
> +	}
> +
> +	tcp_update_pacing_rate(sk);
> +}
> +
> +__u32 BPF_STRUCT_OPS(bpf_cubic_recalc_ssthresh, struct sock *sk)
> +{
> +	return cubictcp_recalc_ssthresh(sk);
> +}
> +
> +void BPF_STRUCT_OPS(bpf_cubic_state, struct sock *sk, __u8 new_state)
> +{
> +	cubictcp_state(sk, new_state);
> +}
> +
> +void BPF_STRUCT_OPS(bpf_cubic_acked, struct sock *sk,
> +		const struct ack_sample *sample)
> +{
> +	cubictcp_acked(sk, sample);
> +}
> +
> +__u32 BPF_STRUCT_OPS(bpf_cubic_undo_cwnd, struct sock *sk)
> +{
> +	return tcp_reno_undo_cwnd(sk);
> +}
> +
> +
> +SEC(".struct_ops")
> +struct tcp_congestion_ops cubic = {
> +	.init		= (void *)bpf_cubic_init,
> +	.ssthresh	= (void *)bpf_cubic_recalc_ssthresh,
> +	.cong_control	= (void *)bpf_cubic_cong_control,
> +	.set_state	= (void *)bpf_cubic_state,
> +	.undo_cwnd	= (void *)bpf_cubic_undo_cwnd,
> +	.cwnd_event	= (void *)bpf_cubic_cwnd_event,
> +	.pkts_acked     = (void *)bpf_cubic_acked,
> +	.name		= "bpf_cubic",

nit. It has the same name as the tcp-cc in bpf_cubic.c. Rename it to 
"bpf_cc_cubic" ?



