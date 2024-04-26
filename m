Return-Path: <bpf+bounces-27888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 118AE8B2F7D
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 06:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799B01F23B38
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 04:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C588139D1E;
	Fri, 26 Apr 2024 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gVRIuPRv"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3907A6A8BE;
	Fri, 26 Apr 2024 04:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714106270; cv=none; b=szWGYKscVP6hV0A8Pho2NoH8j3o8jtmISAjVytuVn5xklj5OTCllS5Qcdqp1b+WZlmu7VU1hMJ6JeeqN7oXK3aId3+0saUaSPzAn9zvtqKh1Dg/OYDJTc+7d221Hv+heIt0lZ/j3HLuBgU+9y9/PweGGvX/O3fnSfTn6EVIyFWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714106270; c=relaxed/simple;
	bh=VBnerWe9odlE1gH4sH6mg97BNX4ACgD+Vo56ggWb0Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxZKyv9gL//fIMCeRNjus8DRnE+gFpxjkp5xOTmhgDjfWRZ+lBqH+ay8snTiBpO8H7FJPYUXlK2k6GTYa7g2qMGpwn5fLM8AHTdCBc3+mn5EpF8IQAPD/g+NYTgJDuwG4cWmC0jK21jHWs+7TSQDKgQuMbmyRR01zNitoO7LavY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gVRIuPRv; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2b2c3eb1-df87-40fe-b871-b52812c8ecd0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714106266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZAL030xc3FF4NPa5fbMaKFx6oanSsxF4hlluX+c9eA=;
	b=gVRIuPRvzwwCYoX1aH8gbDfYhdcW072Sd8T2qbPOP4gDJutUt8xwMv11Ts+25K45GNfkE0
	JGsgOqwi3fPELDxAuNRmDrAyG95v5N5A/vi9IvquQN3LNJlIg3TEhXKNIbItVhE5CrLaYM
	nKuYpKPZHl2Ed6R9OADWGHXfwAcmzts=
Date: Thu, 25 Apr 2024 21:37:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v5 2/2] net: Add additional bit to support
 clockid_t timestamp type
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
 kernel@quicinc.com
References: <20240424222028.1080134-1-quic_abchauha@quicinc.com>
 <20240424222028.1080134-3-quic_abchauha@quicinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240424222028.1080134-3-quic_abchauha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/24/24 3:20 PM, Abhishek Chauhan wrote:
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index e464d0ebc9c1..3ad0de07d261 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -711,6 +711,8 @@ typedef unsigned char *sk_buff_data_t;
>   enum skb_tstamp_type {
>   	SKB_CLOCK_REALTIME,
>   	SKB_CLOCK_MONOTONIC,
> +	SKB_CLOCK_TAI,
> +	__SKB_CLOCK_MAX = SKB_CLOCK_TAI,
>   };
>   
>   /**
> @@ -831,8 +833,8 @@ enum skb_tstamp_type {
>    *	@decrypted: Decrypted SKB
>    *	@slow_gro: state present at GRO time, slower prepare step required
>    *	@tstamp_type: When set, skb->tstamp has the
> - *		delivery_time in mono clock base Otherwise, the
> - *		timestamp is considered real clock base.
> + *		delivery_time in mono clock base or clock base of skb->tstamp.
> + *		Otherwise, the timestamp is considered real clock base
>    *	@napi_id: id of the NAPI struct this skb came from
>    *	@sender_cpu: (aka @napi_id) source CPU in XPS
>    *	@alloc_cpu: CPU which did the skb allocation.
> @@ -960,7 +962,7 @@ struct sk_buff {
>   	/* private: */
>   	__u8			__mono_tc_offset[0];
>   	/* public: */
> -	__u8			tstamp_type:1;	/* See skb_tstamp_type */
> +	__u8			tstamp_type:2;	/* See skb_tstamp_type */
>   #ifdef CONFIG_NET_XGRESS
>   	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
>   	__u8			tc_skip_classify:1;
> @@ -1090,15 +1092,17 @@ struct sk_buff {
>   #endif
>   #define PKT_TYPE_OFFSET		offsetof(struct sk_buff, __pkt_type_offset)
>   
> -/* if you move tc_at_ingress or mono_delivery_time
> +/* if you move tc_at_ingress or tstamp_type:2
>    * around, you also must adapt these constants.
>    */
>   #ifdef __BIG_ENDIAN_BITFIELD
> -#define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7)
> -#define TC_AT_INGRESS_MASK		(1 << 6)
> +#define SKB_TSTAMP_TYPE_MASK		(3 << 6)
> +#define SKB_TSTAMP_TYPE_RSH		(6)
> +#define TC_AT_INGRESS_RSH		(5)

TC_AT_INGRESS_RSH is not used.
  
> +#define TC_AT_INGRESS_MASK		(1 << 5)
>   #else
> -#define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
> -#define TC_AT_INGRESS_MASK		(1 << 1)
> +#define SKB_TSTAMP_TYPE_MASK		(3)
> +#define TC_AT_INGRESS_MASK		(1 << 2)
>   #endif
>   #define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)
>   
> @@ -4204,6 +4208,12 @@ static inline void skb_set_tstamp_type_frm_clkid(struct sk_buff *skb,
>   	case CLOCK_MONOTONIC:
>   		skb->tstamp_type = SKB_CLOCK_MONOTONIC;
>   		break;
> +	case CLOCK_TAI:
> +		skb->tstamp_type = SKB_CLOCK_TAI;
> +		break;
> +	default:
> +		WARN_ONCE(true, "clockid %d not supported", clockid);
> +		skb->tstamp_type = SKB_CLOCK_REALTIME;
>   	}
>   }
>   
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index cee0a7915c08..1376ed5ece10 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h

The bpf.h needs to be sync to tools/include/uapi/linux/bpf.h.
Otherwise, the bpf CI cannot compile the tests:

https://patchwork.kernel.org/project/netdevbpf/patch/20240424222028.1080134-2-quic_abchauha@quicinc.com/

Please monitor the bpf CI test result after submitting the patches.

> @@ -6209,6 +6209,7 @@ union {					\
>   enum {
>   	BPF_SKB_TSTAMP_UNSPEC,
>   	BPF_SKB_TSTAMP_DELIVERY_MONO,	/* tstamp has mono delivery time */
> +	BPF_SKB_TSTAMP_DELIVERY_TAI,	/* tstamp has tai delivery time */
>   	/* For any BPF_SKB_TSTAMP_* that the bpf prog cannot handle,
>   	 * the bpf prog should handle it like BPF_SKB_TSTAMP_UNSPEC
>   	 * and try to deduce it by ingress, egress or skb->sk->sk_clockid.

SKB_CLOCK_TAI is properly defined as an enum now and there is a
WARN for clock other than REAL, MONO, and TAI. I think it is
time to remove UNSPEC and give it back the proper name REALTIME.

I want to take this chance to do some renaming:

/* The enum used in skb->tstamp_type. It specifies the clock type
  * of the time stored in the skb->tstamp.
  */
enum {
	BPF_SKB_TSTAMP_UNSPEC = 0,              /* DEPRECATED */
	BPF_SKB_TSTAMP_DELIVERY_MONO = 1,       /* DEPRECATED */
	BPF_SKB_CLOCK_REALTIME = 0,             /* Realtime clock */
	BPF_SKB_CLOCK_MONOTONIC = 1,            /* Monotonic clock */
	BPF_SKB_CLOCK_TAI = 2,                  /* TAI clock */
	/* For any future BPF_SKB_CLOCK_* that the bpf prog cannot handle,
	 * the bpf prog can try to deduce it by ingress/egress/skb->sk->sk_clockid.
	 */
};


> diff --git a/net/core/filter.c b/net/core/filter.c
> index 957c2fc724eb..c67622f4fe98 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7733,6 +7733,12 @@ BPF_CALL_3(bpf_skb_set_tstamp, struct sk_buff *, skb,
>   		skb->tstamp = tstamp;
>   		skb->tstamp_type = SKB_CLOCK_MONOTONIC;
>   		break;
> +	case BPF_SKB_TSTAMP_DELIVERY_TAI:
> +		if (!tstamp)
> +			return -EINVAL;
> +		skb->tstamp = tstamp;
> +		skb->tstamp_type = SKB_CLOCK_TAI;
> +		break;
>   	case BPF_SKB_TSTAMP_UNSPEC:
>   		if (tstamp)

Allow to store any realtime tstamp here since BPF_SKB_TSTAMP_UNSPEC
becomes BPF_SKB_CLOCK_REALTIME.

Like:

BPF_CALL_3(bpf_skb_set_tstamp, struct sk_buff *, skb,
            u64, tstamp, u32, tstamp_type)
{
	/* ... */
	case BPF_SKB_CLOCK_TAI:
		if (!tstamp)
			return -EINVAL;
		skb->tstamp = tstamp;
		skb->tstamp_type = SKB_CLOCK_TAI;
		break;
         case BPF_SKB_CLOCK_REALTIME:
		skb->tstamp = tstamp;
		skb->tstamp_type = SKB_CLOCK_REALTIME;
		break;

	/* ... */
}

>   			return -EINVAL;

> @@ -9388,17 +9394,17 @@ static struct bpf_insn *bpf_convert_tstamp_type_read(const struct bpf_insn *si,
>   {
>   	__u8 value_reg = si->dst_reg;
>   	__u8 skb_reg = si->src_reg;
> -	/* AX is needed because src_reg and dst_reg could be the same */
> -	__u8 tmp_reg = BPF_REG_AX;
> -
> -	*insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg,
> -			      SKB_BF_MONO_TC_OFFSET);
> -	*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
> -				SKB_MONO_DELIVERY_TIME_MASK, 2);
> -	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_UNSPEC);
> -	*insn++ = BPF_JMP_A(1);
> -	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_MONO);
> -
> +	BUILD_BUG_ON(__SKB_CLOCK_MAX != BPF_SKB_TSTAMP_DELIVERY_TAI);

Add these also:

	BUILD_BUG_ON(SKB_CLOCK_REALTIME != BPF_SKB_CLOCK_REALTIME);
	BUILD_BUG_ON(SKB_CLOCK_MONOTONIC != BPF_SKB_CLOCK_MONOTONIC);
	BUILD_BUG_ON(SKB_CLOCK_TAI != BPF_SKB_CLOCK_TAI);

> +	*insn++ = BPF_LDX_MEM(BPF_B, value_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
> +	*insn++ = BPF_ALU32_IMM(BPF_AND, value_reg, SKB_TSTAMP_TYPE_MASK);
> +#ifdef __BIG_ENDIAN_BITFIELD
> +	*insn++ = BPF_ALU32_IMM(BPF_RSH, value_reg, SKB_TSTAMP_TYPE_RSH);
> +#else
> +	BUILD_BUG_ON(!(SKB_TSTAMP_TYPE_MASK & 0x1));
> +#endif
> +	*insn++ = BPF_JMP32_IMM(BPF_JNE, value_reg, SKB_TSTAMP_TYPE_MASK, 1);
> +	/* Both the bits set then mark it BPF_SKB_TSTAMP_UNSPEC */
> +	*insn++ = BPF_MOV64_IMM(value_reg, BPF_SKB_TSTAMP_UNSPEC);

The kernel should not have both bits set in skb->tstamp_type. No need to
add two extra bpf insns to check this. If there is a bug in the kernel,
it is better to be uncovered instead of hiding it under BPF_SKB_TSTAMP_UNSPEC (which
is renamed to BPF_SKB_CLOCK_REALTIME anyway).
Hence, the last two bpf insns should be removed.

>   	return insn;
>   }
>   
> @@ -9430,6 +9436,7 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
>   	__u8 value_reg = si->dst_reg;
>   	__u8 skb_reg = si->src_reg;
>   
> +BUILD_BUG_ON(__SKB_CLOCK_MAX != BPF_SKB_TSTAMP_DELIVERY_TAI);

It is a dup of the one in bpf_convert_tstamp_type_read and can be removed.

>   #ifdef CONFIG_NET_XGRESS
>   	/* If the tstamp_type is read,
>   	 * the bpf prog is aware the tstamp could have delivery time.
> @@ -9440,11 +9447,12 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
>   		__u8 tmp_reg = BPF_REG_AX;
>   
>   		*insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
> -		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg,
> -					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
> -		*insn++ = BPF_JMP32_IMM(BPF_JNE, tmp_reg,
> -					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
> -		/* skb->tc_at_ingress && skb->tstamp_type:1,
> +		/* check if ingress mask bits is set */
> +		*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg, TC_AT_INGRESS_MASK, 1);
> +		*insn++ = BPF_JMP_A(4);
> +		*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg, SKB_TSTAMP_TYPE_MASK, 1);
> +		*insn++ = BPF_JMP_A(2);
> +		/* skb->tc_at_ingress && skb->tstamp_type:2,
>   		 * read 0 as the (rcv) timestamp.
>   		 */
>   		*insn++ = BPF_MOV64_IMM(value_reg, 0);
> @@ -9469,7 +9477,7 @@ static struct bpf_insn *bpf_convert_tstamp_write(const struct bpf_prog *prog,
>   	 * the bpf prog is aware the tstamp could have delivery time.
>   	 * Thus, write skb->tstamp as is if tstamp_type_access is true.
>   	 * Otherwise, writing at ingress will have to clear the
> -	 * mono_delivery_time (skb->tstamp_type:1)bit also.
> +	 * mono_delivery_time (skb->tstamp_type:2)bit also.
>   	 */
>   	if (!prog->tstamp_type_access) {
>   		__u8 tmp_reg = BPF_REG_AX;
> @@ -9479,8 +9487,8 @@ static struct bpf_insn *bpf_convert_tstamp_write(const struct bpf_prog *prog,
>   		*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg, TC_AT_INGRESS_MASK, 1);
>   		/* goto <store> */
>   		*insn++ = BPF_JMP_A(2);
> -		/* <clear>: mono_delivery_time or (skb->tstamp_type:1) */
> -		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg, ~SKB_MONO_DELIVERY_TIME_MASK);
> +		/* <clear>: skb->tstamp_type:2 */
> +		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg, ~SKB_TSTAMP_TYPE_MASK);
>   		*insn++ = BPF_STX_MEM(BPF_B, skb_reg, tmp_reg, SKB_BF_MONO_TC_OFFSET);
>   	}
>   #endif
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 591226dcde26..f195b31d6e75 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1457,7 +1457,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
>   
>   	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
>   	skb->mark = cork->mark;
> -	skb->tstamp = cork->transmit_time;
> +	skb_set_tstamp_type_frm_clkid(skb, cork->transmit_time, sk->sk_clockid);

hmm... I think this will break for tcp. This sequence in particular:

tcp_v4_timewait_ack()
   tcp_v4_send_ack()
     ip_send_unicast_reply()
       ip_push_pending_frames()
         ip_finish_skb()
           __ip_make_skb()
             /* sk_clockid is REAL but cork->transmit_time should be in mono */
             skb_set_tstamp_type_frm_clkid(skb, cork->transmit_time, sk->sk_clockid);;

I think I hit it from time to time when running the test in this patch set.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_tc_dtime.c b/tools/testing/selftests/bpf/progs/test_tc_dtime.c
> index 74ec09f040b7..19dba6d88265 100644
> --- a/tools/testing/selftests/bpf/progs/test_tc_dtime.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_dtime.c

Please separate the selftests/bpf changes into another patch.

> @@ -227,6 +227,12 @@ int egress_host(struct __sk_buff *skb)
>   			inc_dtimes(EGRESS_ENDHOST);
>   		else
>   			inc_errs(EGRESS_ENDHOST);
> +	} else if (skb_proto(skb_type) == IPPROTO_UDP) {
> +		if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_TAI &&
> +		    skb->tstamp)
> +			inc_dtimes(EGRESS_ENDHOST);
> +		else
> +			inc_errs(EGRESS_ENDHOST);
>   	} else {
>   		if (skb->tstamp_type == BPF_SKB_TSTAMP_UNSPEC &&
>   		    skb->tstamp)
> @@ -255,6 +261,9 @@ int ingress_host(struct __sk_buff *skb)
>   	if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO &&
>   	    skb->tstamp == EGRESS_FWDNS_MAGIC)
>   		inc_dtimes(INGRESS_ENDHOST);
> +	else if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_TAI &&
> +		       skb->tstamp == EGRESS_FWDNS_MAGIC)
> +		inc_dtimes(INGRESS_ENDHOST);
>   	else
>   		inc_errs(INGRESS_ENDHOST);
>   
> @@ -323,12 +332,14 @@ int ingress_fwdns_prio101(struct __sk_buff *skb)
>   		/* Should have handled in prio100 */
>   		return TC_ACT_SHOT;
>   
> -	if (skb_proto(skb_type) == IPPROTO_UDP)
> +	if (skb_proto(skb_type) == IPPROTO_UDP &&
> +		  skb->tstamp_type != BPF_SKB_TSTAMP_DELIVERY_TAI)
>   		expected_dtime = 0;

The IPPROTO_UDP check and expected_dtime can be removed. The UDP test
can expect the same EGRESS_ENDHOST_MAGIC in the skb->tstamp since
the TAI tstamp is also forwarded from egress to ingress now.

>   
>   	if (skb->tstamp_type) {
>   		if (fwdns_clear_dtime() ||
> -		    skb->tstamp_type != BPF_SKB_TSTAMP_DELIVERY_MONO ||
> +		    (skb->tstamp_type != BPF_SKB_TSTAMP_DELIVERY_MONO &&
> +		    skb->tstamp_type != BPF_SKB_TSTAMP_DELIVERY_TAI) ||
>   		    skb->tstamp != expected_dtime)
>   			inc_errs(INGRESS_FWDNS_P101);
>   		else
> @@ -338,7 +349,8 @@ int ingress_fwdns_prio101(struct __sk_buff *skb)
>   			inc_errs(INGRESS_FWDNS_P101);
>   	}
>   
> -	if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO) {
> +	if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO ||
> +		  skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_TAI) {

No need to check BPF_SKB_TSTAMP_DELIVERY_TAI such that the
bpf_skb_set_tstamp() helper can still be tested.

There are some other minor changes needed for the test_tc_dtime.c and
the tc_redirect.c. I quickly made the changes and put them here (first patch):

https://git.kernel.org/pub/scm/linux/kernel/git/martin.lau/bpf-next.git/log/?h=skb.tstamp_type



>   		skb->tstamp = INGRESS_FWDNS_MAGIC;
>   	} else {
>   		if (bpf_skb_set_tstamp(skb, INGRESS_FWDNS_MAGIC,
> @@ -370,7 +382,8 @@ int egress_fwdns_prio101(struct __sk_buff *skb)
>   
>   	if (skb->tstamp_type) {
>   		if (fwdns_clear_dtime() ||
> -		    skb->tstamp_type != BPF_SKB_TSTAMP_DELIVERY_MONO ||
> +		    (skb->tstamp_type != BPF_SKB_TSTAMP_DELIVERY_MONO &&
> +		     skb->tstamp_type != BPF_SKB_TSTAMP_DELIVERY_TAI) ||
>   		    skb->tstamp != INGRESS_FWDNS_MAGIC)
>   			inc_errs(EGRESS_FWDNS_P101);
>   		else
> @@ -380,7 +393,8 @@ int egress_fwdns_prio101(struct __sk_buff *skb)
>   			inc_errs(EGRESS_FWDNS_P101);
>   	}
>   
> -	if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO) {
> +	if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO ||
> +		  skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_TAI) {
>   		skb->tstamp = EGRESS_FWDNS_MAGIC;
>   	} else {
>   		if (bpf_skb_set_tstamp(skb, EGRESS_FWDNS_MAGIC,


