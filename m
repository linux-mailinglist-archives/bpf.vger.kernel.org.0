Return-Path: <bpf+bounces-29226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 228AF8C1554
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 21:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4A2283207
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 19:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C845D811E6;
	Thu,  9 May 2024 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k83wz7aa"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A185D7F489
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282273; cv=none; b=u9J1PjOmDoTe7Y9jrI7/msUdBZxrtsJsG6VGgg6zbkxZGY69yYSJLPQ5QL4hyhMdP7mB8CgYzAky0mzgjVNaPmhVslK5aDuqIk7WvOHhVnNqXDSCBM9xI61xGBRzte2PAtWRBr+05RFyodVxE3C1obUS84x+z+va3HZ2iDVULv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282273; c=relaxed/simple;
	bh=T036fifrIA1AksrNL7AFJX0e/GPtXPfszP11ZVgPMCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kazKWjeQnKbvTr/q+u1JPGZMMfcb+adNzv8a/EVbFx/5EJSN2mA/7WWlOyVzjCk35a/4K3dLU+ienDHT0H+YVgv5+mKIjr3mHMnu+YOnV8PrKHlPmR1Rqo2mKFefqv9FyvVikszB7oxVvtQcCbMn5pV26gS56PB8vjsPmtzGYI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k83wz7aa; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c929dced-e70e-4f49-b812-026b2677bfd9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715282268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOgzY1WJHW9FwJa+ECKBwfARITf81KjLffAQbrFvkAo=;
	b=k83wz7aalbejSVXWLHFcLxiKRzT5kSW7NA+WKJgvBtn/C0vIRknQrGxh0peZ867AQccx0/
	nR/vlBtTtlKgscE9YlpFjWU+jX5QgqrVZ+jSo6aKjstFTWCX8uQX1vZSMUDlUMAwIIEtTW
	QfHyoynhNjpEEnM2hdGGKz5VjPMlOXE=
Date: Thu, 9 May 2024 12:17:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v7 3/3] selftests/bpf: Handle forwarding of
 UDP CLOCK_TAI packets
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
 kernel@quicinc.com
References: <20240508215842.2449798-1-quic_abchauha@quicinc.com>
 <20240508215842.2449798-4-quic_abchauha@quicinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240508215842.2449798-4-quic_abchauha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/8/24 2:58 PM, Abhishek Chauhan wrote:
> With changes in the design to forward CLOCK_TAI in the skbuff
> framework,  existing selftest framework needs modification
> to handle forwarding of UDP packets with CLOCK_TAI as clockid.

The set lgtm. I have a few final nits on the test.

> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
> Changes since v7
> - Fixed  issues in the ctx_rewrite.c
>    with respect to dissembly in both
>    .read and .write
> 
> Changes since v6
> - Moved all the selftest to another patch
> 
> Changes since v1 - v5
> - Patch was not present
> 
>   tools/include/uapi/linux/bpf.h                | 15 ++++---
>   .../selftests/bpf/prog_tests/ctx_rewrite.c    | 10 +++--
>   .../selftests/bpf/prog_tests/tc_redirect.c    |  3 --
>   .../selftests/bpf/progs/test_tc_dtime.c       | 39 +++++++++----------
>   4 files changed, 34 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 90706a47f6ff..25ea393cf084 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h

nit. Please move this bpf.h sync changes to patch 2 where the uapi changes happen.

> @@ -6207,12 +6207,17 @@ union {					\
>   	__u64 :64;			\
>   } __attribute__((aligned(8)))
>   
> +/* The enum used in skb->tstamp_type. It specifies the clock type
> + * of the time stored in the skb->tstamp.
> + */
>   enum {
> -	BPF_SKB_TSTAMP_UNSPEC,
> -	BPF_SKB_TSTAMP_DELIVERY_MONO,	/* tstamp has mono delivery time */
> -	/* For any BPF_SKB_TSTAMP_* that the bpf prog cannot handle,
> -	 * the bpf prog should handle it like BPF_SKB_TSTAMP_UNSPEC
> -	 * and try to deduce it by ingress, egress or skb->sk->sk_clockid.
> +	BPF_SKB_TSTAMP_UNSPEC = 0,		/* DEPRECATED */
> +	BPF_SKB_TSTAMP_DELIVERY_MONO = 1,	/* DEPRECATED */
> +	BPF_SKB_CLOCK_REALTIME = 0,
> +	BPF_SKB_CLOCK_MONOTONIC = 1,
> +	BPF_SKB_CLOCK_TAI = 2,
> +	/* For any future BPF_SKB_CLOCK_* that the bpf prog cannot handle,
> +	 * the bpf prog can try to deduce it by ingress/egress/skb->sk->sk_clockid.
>   	 */
>   };
>   
> diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
> index 3b7c57fe55a5..08b6391f2f56 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
> @@ -69,15 +69,17 @@ static struct test_case test_cases[] = {
>   	{
>   		N(SCHED_CLS, struct __sk_buff, tstamp),
>   		.read  = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
> -			 "w11 &= 3;"
> -			 "if w11 != 0x3 goto pc+2;"
> +			 "if w11 & 0x4 goto pc+1;"
> +			 "goto pc+4;"
> +			 "if w11 & 0x3 goto pc+1;"
> +			 "goto pc+2;"
>   			 "$dst = 0;"
>   			 "goto pc+1;"
>   			 "$dst = *(u64 *)($ctx + sk_buff::tstamp);",
>   		.write = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
> -			 "if w11 & 0x2 goto pc+1;"
> +			 "if w11 & 0x4 goto pc+1;"
>   			 "goto pc+2;"
> -			 "w11 &= -2;"
> +			 "w11 &= -4;"
>   			 "*(u8 *)($ctx + sk_buff::__mono_tc_offset) = r11;"
>   			 "*(u64 *)($ctx + sk_buff::tstamp) = $src;",
>   	},
> diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> index b1073d36d77a..327d51f59142 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> @@ -890,9 +890,6 @@ static void test_udp_dtime(struct test_tc_dtime *skel, int family, bool bpf_fwd)
>   
>   	ASSERT_EQ(dtimes[INGRESS_FWDNS_P100], 0,
>   		  dtime_cnt_str(t, INGRESS_FWDNS_P100));
> -	/* non mono delivery time is not forwarded */
> -	ASSERT_EQ(dtimes[INGRESS_FWDNS_P101], 0,
> -		  dtime_cnt_str(t, INGRESS_FWDNS_P101));
>   	for (i = EGRESS_FWDNS_P100; i < SET_DTIME; i++)
>   		ASSERT_GT(dtimes[i], 0, dtime_cnt_str(t, i));
>   
> diff --git a/tools/testing/selftests/bpf/progs/test_tc_dtime.c b/tools/testing/selftests/bpf/progs/test_tc_dtime.c
> index 74ec09f040b7..21f5be202e4b 100644
> --- a/tools/testing/selftests/bpf/progs/test_tc_dtime.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_dtime.c
> @@ -222,13 +222,19 @@ int egress_host(struct __sk_buff *skb)
>   		return TC_ACT_OK;
>   
>   	if (skb_proto(skb_type) == IPPROTO_TCP) {
> -		if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO &&
> +		if (skb->tstamp_type == BPF_SKB_CLOCK_MONOTONIC &&
> +		    skb->tstamp)
> +			inc_dtimes(EGRESS_ENDHOST);
> +		else
> +			inc_errs(EGRESS_ENDHOST);
> +	} else if (skb_proto(skb_type) == IPPROTO_UDP) {
> +		if (skb->tstamp_type == BPF_SKB_CLOCK_TAI &&
>   		    skb->tstamp)
>   			inc_dtimes(EGRESS_ENDHOST);
>   		else
>   			inc_errs(EGRESS_ENDHOST);
>   	} else {
> -		if (skb->tstamp_type == BPF_SKB_TSTAMP_UNSPEC &&
> +		if (skb->tstamp_type == BPF_SKB_CLOCK_REALTIME &&
>   		    skb->tstamp)

Since the UDP+TAI can be handled properly in the above "else if" case now, I 
would like to further tighten the bolt on detecting the non-zero REALTIME 
skb->tstamp here since it should not happen at egress. Something like:

	} else {
		if (skb->tstamp_type == BPF_SKB_CLOCK_REALTIME &&
		    skb->tstamp)
			inc_errs(EGRESS_ENDHOST);
	}

I ran the test (w or w/o the above inc_errs changes) in a loop and it 
consistently passes now.

Other than the above small nits, in the next re-spin, please remove the RFC tag 
and you can carry my reviewed-by to all 3 patches. Thanks.

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>

>   			inc_dtimes(EGRESS_ENDHOST);
>   		else


