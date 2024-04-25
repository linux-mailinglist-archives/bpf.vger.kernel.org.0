Return-Path: <bpf+bounces-27850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE74B8B28CA
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 21:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40F8AB25EE6
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 19:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D291514FF;
	Thu, 25 Apr 2024 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MUeu+2Yj"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E4C146A74
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072209; cv=none; b=NceFt3hrLmLjvHSP3ikgYuGbArv70qhHa+jcKoIqHwez1pL5N7IBmb5GClP7BMg4TPnsA6RVPaTZTw0EwwpLO+Lwg1L/CEspBK98ohuEJ6ub10b0wsH3DracQESHAX4Q7RI8FHa2YW5M4tibSXJUHy+9TQBlyU/IMwk+ysd0kfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072209; c=relaxed/simple;
	bh=+7z5pqb53EPKMnwV3BOHBq5qDC7obfHC+TmhMEHiz5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEGjxmrZg3gq9paq+NWnEN1IQVX6r3Tdc1MUnDfq2EfFKvV8kP8ETjjs8b0pWk28CZEQH+NEzAQI/Jk5WnIsT0H9mPArnwuIOfNoQXek5qQ9bIhabFjs7DP6QvqIbZe6hF75GXhpjN1hsxoN7jOb79im+yj21pLhUl/ocNtRC6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MUeu+2Yj; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6e134365-b793-49f9-82dd-d148bdd16c85@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714072205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lphMlJkXwA25PKk5968OJZtZ5GZQEljdmi4NLx+cSEY=;
	b=MUeu+2YjYszkQhCMBP26iBl1zbLCEi4FU+LjESaKHmB4ELfcyzwIKZAZBvBI1Ld5IMcOH9
	U6t1mM0NnG7CEPtjhSf5gafDHRGbHTiCmrPaAZHnIqkr7CQt6XChprZc2O+9xy6lLv0GdB
	maV8fG8xWJ4hMPsuMEByyi6CrU12FV8=
Date: Thu, 25 Apr 2024 12:09:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] [PATCH net-next,2/2] Add test for the use of new args
 in cong_control
To: Miao Xu <miaxu@meta.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Martin Lau <kafai@meta.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20240424203713.4003974-1-miaxu@meta.com>
 <20240424203713.4003974-2-miaxu@meta.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240424203713.4003974-2-miaxu@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/24/24 1:37 PM, Miao Xu wrote:
> +#define USEC_PER_SEC 1000000UL
> +#define TCP_PACING_SS_RATIO (200)
> +#define TCP_PACING_CA_RATIO (120)
> +#define TCP_REORDERING (12)
> +#define likely(x) (__builtin_expect(!!(x), 1))
> +
> +static __always_inline __u64 div64_u64(__u64 dividend, __u64 divisor)
> +{
> +	return dividend / divisor;
> +}
> +
> +static void tcp_update_pacing_rate(struct sock *sk)
> +{
> +	const struct tcp_sock *tp = tcp_sk(sk);
> +	__u64 rate;
> +
> +	/* set sk_pacing_rate to 200 % of current rate (mss * cwnd / srtt) */
> +	rate = (__u64)tp->mss_cache * ((USEC_PER_SEC / 100) << 3);
> +
> +	/* current rate is (cwnd * mss) / srtt
> +	 * In Slow Start [1], set sk_pacing_rate to 200 % the current rate.
> +	 * In Congestion Avoidance phase, set it to 120 % the current rate.
> +	 *
> +	 * [1] : Normal Slow Start condition is (tp->snd_cwnd < tp->snd_ssthresh)
> +	 *	 If snd_cwnd >= (tp->snd_ssthresh / 2), we are approaching
> +	 *	 end of slow start and should slow down.
> +	 */
> +	if (tp->snd_cwnd < tp->snd_ssthresh / 2)
> +		rate *= TCP_PACING_SS_RATIO;
> +	else
> +		rate *= TCP_PACING_CA_RATIO;
> +
> +	rate *= max(tp->snd_cwnd, tp->packets_out);
> +
> +	if (likely(tp->srtt_us))
> +		rate = div64_u64(rate, (__u64)tp->srtt_us);
> +
> +	sk->sk_pacing_rate = min(rate, (__u64)sk->sk_max_pacing_rate);
> +}
> +
> +static __always_inline void tcp_cwnd_reduction(
> +		struct sock *sk,
> +		int newly_acked_sacked,
> +		int newly_lost,
> +		int flag) {
> +	struct tcp_sock *tp = tcp_sk(sk);
> +	int sndcnt = 0;
> +	__u32 pkts_in_flight = tp->packets_out - (tp->sacked_out + tp->lost_out) + tp->retrans_out;
> +	int delta = tp->snd_ssthresh - pkts_in_flight;
> +
> +	if (newly_acked_sacked <= 0 || !tp->prior_cwnd)
> +		return;
> +
> +	__u32 prr_delivered = tp->prr_delivered + newly_acked_sacked;
> +
> +	if (delta < 0) {
> +		__u64 dividend =
> +			(__u64)tp->snd_ssthresh * prr_delivered + tp->prior_cwnd - 1;
> +		sndcnt = (__u32)div64_u64(dividend, (__u64)tp->prior_cwnd) - tp->prr_out;
> +	} else {
> +		sndcnt = max(prr_delivered - tp->prr_out, newly_acked_sacked);
> +		if (flag & FLAG_SND_UNA_ADVANCED && !newly_lost)
> +			sndcnt++;
> +		sndcnt = min(delta, sndcnt);
> +	}
> +	/* Force a fast retransmit upon entering fast recovery */
> +	sndcnt = max(sndcnt, (tp->prr_out ? 0 : 1));
> +	tp->snd_cwnd = pkts_in_flight + sndcnt;
> +}
> +
> +/* Decide wheather to run the increase function of congestion control. */
> +static __always_inline bool tcp_may_raise_cwnd(
> +		const struct sock *sk,
> +		const int flag) {
> +	if (tcp_sk(sk)->reordering > TCP_REORDERING)
> +		return flag & FLAG_FORWARD_PROGRESS;
> +
> +	return flag & FLAG_DATA_ACKED;
> +}
> +
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
> +		}
> +	} else if (tcp_may_raise_cwnd(sk, flag)) {
> +		/* Advance cwnd if state allows */
> +		cubictcp_cong_avoid(sk, ack, rs->acked_sacked);
> +		tp->snd_cwnd_stamp = tcp_jiffies32;
> +	}
> +
> +	tcp_update_pacing_rate(sk);

It will be useful to highlight what you want to do differently from the kernel's 
tcp_cong_control()+tcp_cong_avoid() here. or it is something that I missed from 
the above example?


