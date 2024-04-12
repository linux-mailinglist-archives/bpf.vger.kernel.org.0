Return-Path: <bpf+bounces-26619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E23648A2FA3
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 15:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10EFE1C23B87
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 13:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9224055E43;
	Fri, 12 Apr 2024 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+z/AVyF"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3FD7E108
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929065; cv=none; b=gTWrALBQZMHVdwvYyrIfxBZFBZtIazlsgT9B3LSR2PGuYmC8L3IavK1SZuMrVVOROtA2NYVpm7d/J7wmmtwX3jL5jn6Wak/lKwy0ttXH7M4RQZF9M+biwHJreiHoxP6p1mRSRbiMhCXoPAtYiwpbNIWi5N9Oyjqbh2c5NTyQ224=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929065; c=relaxed/simple;
	bh=VDyVRCe/uq6VBNLvUlxtlFW0SvZoHXXGJGkwc0DcR/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhu1Qx2l8un8kodJCFLZxCFNGEjHIsDuzRKAi4MPgcva3RgMKbT1RqLh2Z8sxKIeyCd3dlh4e5LeJUqYMetZyqAEYB49+cpXSbVdKSmvwIzCajhLwrx+WaPeAYKp2gDmXekp1AMFalrKrNA+z92+TmzgPNhn7UdjCJ8Hke3aga8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+z/AVyF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712929062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5rHpcjLvZNC8nCVYPO03eLBLBqWq4wfPGe99ZwWS4u0=;
	b=c+z/AVyFco8wfNaDeOWvBX29d4VOlonJ2v92dPn/JVf/RJJ39ATwE6Xy7rdA+P3ewqR9Fe
	qTwrbuEP3LrjRtcFqfom+foa8Rg/6v4oGO4tRTNlatMVfHiZaZYQp51yap6yV6dhcsmi2f
	ZjTVRPXUdEudK37pdWzLRcwOaIi2GSM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-BXXHw6FmPwW4PUudatm1Rw-1; Fri, 12 Apr 2024 09:37:41 -0400
X-MC-Unique: BXXHw6FmPwW4PUudatm1Rw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78d678a5a1aso85844885a.2
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 06:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712929061; x=1713533861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rHpcjLvZNC8nCVYPO03eLBLBqWq4wfPGe99ZwWS4u0=;
        b=n3JWs5cfKvhO47FkkVUHvphxDkCTSA+EfmLVQa5l7GZ8a9a9/3V2gHBmhlkYP+fBql
         uCtohJs5nkrkufSdWw2gXXUy08/8rkaG94UuRMc8m4INA/ipajc9hoIMdpFOb4aIlpBP
         FTP5V1As1wyBI994cPRp1YcrQAq7bqndBeUHnzRXXg8GIWI7ZREDHJYOK5JvrBknEr1z
         UW3UwZdSprIlD6nkvxQCvDeIRN4YLEqQRAU+7s8aqhlsFI0wDMAivHaDGotDwphUVUCg
         DmdCQKG5W2mZdhDBx0UlfsIQ8YJxoJyO7fkmjeotDOsj537s+ASQ/mr/ar2Xr+Dwa9qA
         vV3A==
X-Forwarded-Encrypted: i=1; AJvYcCVWGUM3iqTh7lWrmvqHOQ0bJgkFd36svRHeuLyLfDodzxj2Jw0mIhCGRGmW9NwQEl1NPjRXrfxQlsEAc/bBa+P4MGEP
X-Gm-Message-State: AOJu0Yyt8IbFTon1qILIKWrY/e2KnzhDnQfHPkSoNJBrxgrQx7kubBlV
	GgUrNK88vlZa4z2l6WWPPG0y/GxwvnrdIawKcaG+CnA+oQ0BYK81tZSGdinYcRtn4lRodMxKRUE
	9v//lKZ07DmYjoUdGT15dV6d3D/Sfh7mVj+DmqWnEiVNL+fCi2g==
X-Received: by 2002:a05:622a:4c7:b0:436:6369:f632 with SMTP id q7-20020a05622a04c700b004366369f632mr3245897qtx.20.1712929060613;
        Fri, 12 Apr 2024 06:37:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV41/RB0tU7gyeLSyYlHZ0e7Hqe9jhFRRXnqXjk82nF9BXSyCx1232TEUhuhbQ19Wa4jeeqQ==
X-Received: by 2002:a05:622a:4c7:b0:436:6369:f632 with SMTP id q7-20020a05622a04c700b004366369f632mr3245866qtx.20.1712929060108;
        Fri, 12 Apr 2024 06:37:40 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id r8-20020ac87948000000b00436714b18b1sm1741379qtt.30.2024.04.12.06.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 06:37:39 -0700 (PDT)
Date: Fri, 12 Apr 2024 08:37:37 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	bpf <bpf@vger.kernel.org>, kernel@quicinc.com
Subject: Re: [RFC PATCH bpf-next v2] net: Add additional bit to support
 userspace timestamp type
Message-ID: <vap7jl4nvufr57cgu6wjmf2y2ijiuchlzchpdw5brdbouuqfg7@bjnec5hrxczk>
References: <20240411230506.1115174-1-quic_abchauha@quicinc.com>
 <20240411230506.1115174-3-quic_abchauha@quicinc.com>
 <f2ff9603-6e04-480a-8c1b-683075017ade@quicinc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ff9603-6e04-480a-8c1b-683075017ade@quicinc.com>

On Thu, Apr 11, 2024 at 04:45:57PM -0700, Abhishek Chauhan (ABC) wrote:
> 
> I see one problem which i will fix it as part of next patch (considering 24h to upload next patch) 
> is the subject does not show  [RFC PATCH bpf-next v2 (2/2)<== this is missing] 

Just a tip, but I've been using b4 for patches lately, and it really is
quite nice at handling these sorts of process bits (cover letters,
versioning, any prefixes like RFC bpf-next, etc):

https://b4.docs.kernel.org/en/latest/contributor/prep.html


> 
> On 4/11/2024 4:05 PM, Abhishek Chauhan wrote:
> > tstamp_type can be real, mono or userspace timestamp.
> > 
> > This commit adds userspace timestamp and sets it if there is
> > valid transmit_time available in socket coming from userspace.
> > 
> > To make the design scalable for future needs this commit bring in
> > the change to extend the tstamp_type:1 to tstamp_type:2 to support
> > userspace timestamp.
> > 
> > Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> > Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> > ---
> > Changes since v1 
> > - identified additional changes in BPF framework.
> > - Bit shift in SKB_MONO_DELIVERY_TIME_MASK and TC_AT_INGRESS_MASK.
> > - Made changes in skb_set_delivery_time to keep changes similar to 
> >   previous code for mono_delivery_time and just setting tstamp_type
> >   bit 1 for userspace timestamp.
> > 
> >  include/linux/skbuff.h                        | 19 +++++++++++++++----
> >  net/ipv4/ip_output.c                          |  2 +-
> >  net/ipv4/raw.c                                |  2 +-
> >  net/ipv6/ip6_output.c                         |  2 +-
> >  net/ipv6/raw.c                                |  2 +-
> >  net/packet/af_packet.c                        |  7 +++----
> >  .../selftests/bpf/prog_tests/ctx_rewrite.c    |  8 ++++----
> >  7 files changed, 26 insertions(+), 16 deletions(-)
> > 
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index a83a2120b57f..b6346c21c3d4 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -827,7 +827,8 @@ enum skb_tstamp_type {
> >   *	@tstamp_type: When set, skb->tstamp has the
> >   *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
> >   *		skb->tstamp has the (rcv) timestamp at ingress and
> > - *		delivery_time at egress.
> > + *		delivery_time at egress or skb->tstamp defined by skb->sk->sk_clockid
> > + *		coming from userspace
> >   *	@napi_id: id of the NAPI struct this skb came from
> >   *	@sender_cpu: (aka @napi_id) source CPU in XPS
> >   *	@alloc_cpu: CPU which did the skb allocation.
> > @@ -955,7 +956,7 @@ struct sk_buff {
> >  	/* private: */
> >  	__u8			__mono_tc_offset[0];
> >  	/* public: */
> > -	__u8			tstamp_type:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
> > +	__u8			tstamp_type:2;	/* See SKB_MONO_DELIVERY_TIME_MASK */
> >  #ifdef CONFIG_NET_XGRESS
> >  	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
> >  	__u8			tc_skip_classify:1;
> > @@ -1090,10 +1091,10 @@ struct sk_buff {
> >   */
> >  #ifdef __BIG_ENDIAN_BITFIELD
> >  #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7)
> > -#define TC_AT_INGRESS_MASK		(1 << 6)
> > +#define TC_AT_INGRESS_MASK		(1 << 5)
> >  #else
> >  #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
> > -#define TC_AT_INGRESS_MASK		(1 << 1)
> > +#define TC_AT_INGRESS_MASK		(1 << 2)
> >  #endif
> >  #define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)
> >  
> > @@ -4262,6 +4263,16 @@ static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
> >  	case CLOCK_MONO:
> >  		skb->tstamp_type = kt && tstamp_type;
> >  		break;
> > +	/* if any other time base, must be from userspace
> > +	 * so set userspace tstamp_type bit
> > +	 * See skbuff tstamp_type:2
> > +	 * 0x0 => real timestamp_type
> > +	 * 0x1 => mono timestamp_type
> > +	 * 0x2 => timestamp_type set from userspace
> > +	 */
> > +	default:
> > +		if (kt && tstamp_type)
> > +			skb->tstamp_type = 0x2;
> >  	}
> >  }
> >  
> > diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> > index 62e457f7c02c..c9317d4addce 100644
> > --- a/net/ipv4/ip_output.c
> > +++ b/net/ipv4/ip_output.c
> > @@ -1457,7 +1457,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
> >  
> >  	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
> >  	skb->mark = cork->mark;
> > -	skb->tstamp = cork->transmit_time;
> > +	skb_set_delivery_time(skb, cork->transmit_time, sk->sk_clockid);
> >  	/*
> >  	 * Steal rt from cork.dst to avoid a pair of atomic_inc/atomic_dec
> >  	 * on dst refcount
> > diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
> > index dcb11f22cbf2..a7d84fc0e530 100644
> > --- a/net/ipv4/raw.c
> > +++ b/net/ipv4/raw.c
> > @@ -360,7 +360,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
> >  	skb->protocol = htons(ETH_P_IP);
> >  	skb->priority = READ_ONCE(sk->sk_priority);
> >  	skb->mark = sockc->mark;
> > -	skb->tstamp = sockc->transmit_time;
> > +	skb_set_delivery_time(skb, sockc->transmit_time, sk->sk_clockid);
> >  	skb_dst_set(skb, &rt->dst);
> >  	*rtp = NULL;
> >  
> > diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> > index a9e819115622..0b8193bdd98f 100644
> > --- a/net/ipv6/ip6_output.c
> > +++ b/net/ipv6/ip6_output.c
> > @@ -1924,7 +1924,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
> >  
> >  	skb->priority = READ_ONCE(sk->sk_priority);
> >  	skb->mark = cork->base.mark;
> > -	skb->tstamp = cork->base.transmit_time;
> > +	skb_set_delivery_time(skb, cork->base.transmit_time, sk->sk_clockid);
> >  
> >  	ip6_cork_steal_dst(skb, cork);
> >  	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
> > diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> > index 0d896ca7b589..625f3a917e50 100644
> > --- a/net/ipv6/raw.c
> > +++ b/net/ipv6/raw.c
> > @@ -621,7 +621,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
> >  	skb->protocol = htons(ETH_P_IPV6);
> >  	skb->priority = READ_ONCE(sk->sk_priority);
> >  	skb->mark = sockc->mark;
> > -	skb->tstamp = sockc->transmit_time;
> > +	skb_set_delivery_time(skb, sockc->transmit_time, sk->sk_clockid);
> >  
> >  	skb_put(skb, length);
> >  	skb_reset_network_header(skb);
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index 8c6d3fbb4ed8..356c96f23370 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -2056,8 +2056,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
> >  	skb->dev = dev;
> >  	skb->priority = READ_ONCE(sk->sk_priority);
> >  	skb->mark = READ_ONCE(sk->sk_mark);
> > -	skb->tstamp = sockc.transmit_time;
> > -
> > +	skb_set_delivery_time(skb, sockc.transmit_time, sk->sk_clockid);
> >  	skb_setup_tx_timestamp(skb, sockc.tsflags);
> >  
> >  	if (unlikely(extra_len == 4))
> > @@ -2585,7 +2584,7 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
> >  	skb->dev = dev;
> >  	skb->priority = READ_ONCE(po->sk.sk_priority);
> >  	skb->mark = READ_ONCE(po->sk.sk_mark);
> > -	skb->tstamp = sockc->transmit_time;
> > +	skb_set_delivery_time(skb, sockc->transmit_time, po->sk.sk_clockid);
> >  	skb_setup_tx_timestamp(skb, sockc->tsflags);
> >  	skb_zcopy_set_nouarg(skb, ph.raw);
> >  
> > @@ -3063,7 +3062,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
> >  	skb->dev = dev;
> >  	skb->priority = READ_ONCE(sk->sk_priority);
> >  	skb->mark = sockc.mark;
> > -	skb->tstamp = sockc.transmit_time;
> > +	skb_set_delivery_time(skb, sockc.transmit_time, sk->sk_clockid);
> >  
> >  	if (unlikely(extra_len == 4))
> >  		skb->no_fcs = 1;
> > diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
> > index 3b7c57fe55a5..d7f58d9671f7 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
> > @@ -69,15 +69,15 @@ static struct test_case test_cases[] = {
> >  	{
> >  		N(SCHED_CLS, struct __sk_buff, tstamp),
> >  		.read  = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
> > -			 "w11 &= 3;"
> > -			 "if w11 != 0x3 goto pc+2;"
> > +			 "w11 &= 5;"
> > +			 "if w11 != 0x5 goto pc+2;"
> >  			 "$dst = 0;"
> >  			 "goto pc+1;"
> >  			 "$dst = *(u64 *)($ctx + sk_buff::tstamp);",
> >  		.write = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
> > -			 "if w11 & 0x2 goto pc+1;"
> > +			 "if w11 & 0x4 goto pc+1;"
> >  			 "goto pc+2;"
> > -			 "w11 &= -2;"
> > +			 "w11 &= -4;"
> >  			 "*(u8 *)($ctx + sk_buff::__mono_tc_offset) = r11;"
> >  			 "*(u64 *)($ctx + sk_buff::tstamp) = $src;",
> >  	},
> 


