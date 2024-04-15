Return-Path: <bpf+bounces-26871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 931CF8A5C61
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 22:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDAD4B22F0F
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 20:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC06A15696D;
	Mon, 15 Apr 2024 20:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0ELk9Z3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E299B156672;
	Mon, 15 Apr 2024 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713214012; cv=none; b=lzEss5kmWZ5FAZPlc5KAH7G6JiYFSzfFD+0VKjYG8T5GDoE062mqItKY0XLLpuC+ENyInmPhh8W4pxfK0xhrX7F23p1Z3ZAYDig06cs5ulqCN251R4uR30WVTrtrFDOPJmQUpYpklViQz6PwSxZ7RLXjTt+WhP/OPOsPZavuGGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713214012; c=relaxed/simple;
	bh=P92zzEucyx82oS8NWom5zJ8AjEe4RnkPkDfa+5IgYgw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=R/mcEMiXbgQXu8AduhXCEqCQxUHEhP3Ks0AzYa6nI8eIsrVVL6r25fZ0BpdPKwc4Vx8IGJxYIHeg1ui0MCv9xuuiaeoguqhgmLLddJZb+RiCrplATxDzR2GOqTI9ThxExhhjYwX6eTiyC0GL4LWp5TNIV4QwoD2NQiws4V69KkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0ELk9Z3; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6eb86b69e65so526511a34.3;
        Mon, 15 Apr 2024 13:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713214010; x=1713818810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odsCtMkxqrPn0+y+bCjZDpAIWxWwS5/3VrDCoNIGGnc=;
        b=I0ELk9Z3VufdD/ChUDq8nw+ludy6lJJNEpv7TDx7xH/v4/3/wVLHbCW5KBTIy+Zmfr
         B+3hzkf6QqrLkCsJ2Z4HT7pxHBHHQcZcDFfJuh4Sha2utLu1ul19NNEWfKX89uMpQa4R
         1VkqoQ3lrrhS/cORjYvacFcwb0YPuN5pwxWHzRndYktdpIHY+VST5/36wNZq95vXYaJ9
         GpetGIaZkgbCGtx46x/e6Fcemv34H9XuI/2tDn6x1kwzNh0qZ5tz1YUKwTFE5G5uc1ai
         HszH6FszbZJuD83SGWBU3gkJ91Zyz3lr1jm0KQBHesqKjjKuu5nvcHSiFsdZbzfOTxk4
         P7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713214010; x=1713818810;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=odsCtMkxqrPn0+y+bCjZDpAIWxWwS5/3VrDCoNIGGnc=;
        b=Qi+r9ly8mUoigcAs57TKZcktF174RDgqjO6+9QUmGthzALNRX+36PWifHXwfl7Jb7v
         zQSjFX7m6RV2khtjdDqyI2uxRVOW9Dk9adTw9mejPZzMx+zdbyI8/GIAuAmj7JvAwidz
         yUNymOt9cbQ9HhAotACW3a7fbFzW/LuRtabqTS6xTOVyPNccwJssxidmHA+qQEOOc4gg
         FOOXrMoM2LbnhtujEjGjUb2DtQi/oUMXkUu1YhGj/vbfnqtwPmdLLJsB7IvmYJ0o26o6
         muZ5IA3pYOYUFw2Fz5Cu2fcEKCauFAWqdkQF/ILVcokTWpbTSSkfvDBuVY7/G25y1nj2
         xjWg==
X-Forwarded-Encrypted: i=1; AJvYcCVokpOEY1uJ2WwZtBjki3BKN8ngp73yIsLHCkCTj4iIkP3rXjO5aqkRIUwatzLIRNQ1fumJjqgpRvWFCPUwVh1Wco54hWNUsSkhhd5o+iVoToEJfmowQ+RuVtw5vd72k3gUIY0MMeIcOIHIGKmULOwVyf0plpLMVsYS
X-Gm-Message-State: AOJu0YyXfuvkYWHkJK4rTL/diQeEIaCc3kl5QtKqYaKvNgy+cY+SHfAf
	UDKEXV+GQGNiRJJdB5Mq/v6k1zECn3akYZUf5DtYGUFq64SUkQ+S
X-Google-Smtp-Source: AGHT+IHw3NLqlJnH42+F/k+lGDa3Wp/meAEZDW/E4egLiAZjjMBjfOjtXLbhDn80u3EbKCwXSrp69g==
X-Received: by 2002:a05:6830:1be1:b0:6ea:1dc5:514c with SMTP id k1-20020a0568301be100b006ea1dc5514cmr12761641otb.11.1713214009820;
        Mon, 15 Apr 2024 13:46:49 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id po13-20020a05620a384d00b0078ef0d4773bsm651810qkn.109.2024.04.15.13.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 13:46:49 -0700 (PDT)
Date: Mon, 15 Apr 2024 16:46:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 bpf <bpf@vger.kernel.org>
Cc: kernel@quicinc.com
Message-ID: <661d92391de45_30101294f2@willemb.c.googlers.com.notmuch>
In-Reply-To: <c992e03b-eee5-471a-9002-f35bdfa1be2d@quicinc.com>
References: <20240412210125.1780574-1-quic_abchauha@quicinc.com>
 <20240412210125.1780574-2-quic_abchauha@quicinc.com>
 <661ad4f0e3766_3be9a7294a1@willemb.c.googlers.com.notmuch>
 <c992e03b-eee5-471a-9002-f35bdfa1be2d@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] net: Rename mono_delivery_time to
 tstamp_type for scalabilty
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Abhishek Chauhan (ABC) wrote:
> 
> 
> On 4/13/2024 11:54 AM, Willem de Bruijn wrote:
> > Abhishek Chauhan wrote:
> >> mono_delivery_time was added to check if skb->tstamp has delivery
> >> time in mono clock base (i.e. EDT) otherwise skb->tstamp has
> >> timestamp in ingress and delivery_time at egress.
> >>
> >> Renaming the bitfield from mono_delivery_time to tstamp_type is for
> >> extensibilty for other timestamps such as userspace timestamp
> >> (i.e. SO_TXTIME) set via sock opts.
> >>
> >> As we are renaming the mono_delivery_time to tstamp_type, it makes
> >> sense to start assigning tstamp_type based out if enum defined as
> >> part of this commit
> >>
> >> Earlier we used bool arg flag to check if the tstamp is mono in
> >> function skb_set_delivery_time, Now the signature of the functions
> >> accepts enum to distinguish between mono and real time
> >>
> >> Bridge driver today has no support to forward the userspace timestamp
> >> packets and ends up resetting the timestamp. ETF qdisc checks the
> >> packet coming from userspace and encounters to be 0 thereby dropping
> >> time sensitive packets. These changes will allow userspace timestamps
> >> packets to be forwarded from the bridge to NIC drivers.
> >>
> >> In future tstamp_type:1 can be extended to support userspace timestamp
> >> by increasing the bitfield.
> >>
> >> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> >> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> >> ---
> >> Changes since v2
> >> - Minor changes to commit subject
> >>
> >> Changes since v1
> >> - Squashed the two commits into one as mentioned by Willem.
> >> - Introduced switch in skb_set_delivery_time.
> >> - Renamed and removed directionality aspects w.r.t tstamp_type 
> >>   as mentioned by Willem.
> >>
> >>  include/linux/skbuff.h                     | 33 +++++++++++++++-------
> >>  include/net/inet_frag.h                    |  4 +--
> >>  net/bridge/netfilter/nf_conntrack_bridge.c |  6 ++--
> >>  net/core/dev.c                             |  2 +-
> >>  net/core/filter.c                          |  8 +++---
> >>  net/ipv4/inet_fragment.c                   |  2 +-
> >>  net/ipv4/ip_fragment.c                     |  2 +-
> >>  net/ipv4/ip_output.c                       |  8 +++---
> >>  net/ipv4/tcp_output.c                      | 14 ++++-----
> >>  net/ipv6/ip6_output.c                      |  6 ++--
> >>  net/ipv6/netfilter.c                       |  6 ++--
> >>  net/ipv6/netfilter/nf_conntrack_reasm.c    |  2 +-
> >>  net/ipv6/reassembly.c                      |  2 +-
> >>  net/ipv6/tcp_ipv6.c                        |  2 +-
> >>  net/sched/act_bpf.c                        |  4 +--
> >>  net/sched/cls_bpf.c                        |  4 +--
> >>  16 files changed, 59 insertions(+), 46 deletions(-)
> >>
> >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> >> index 7135a3e94afd..a83a2120b57f 100644
> >> --- a/include/linux/skbuff.h
> >> +++ b/include/linux/skbuff.h
> >> @@ -702,6 +702,11 @@ typedef unsigned int sk_buff_data_t;
> >>  typedef unsigned char *sk_buff_data_t;
> >>  #endif
> >>  
> >> +enum skb_tstamp_type {
> >> +	CLOCK_REAL = 0, /* Time base is realtime */
> >> +	CLOCK_MONO = 1, /* Time base is Monotonic */
> >> +};
> > 
> > Minor: inconsistent capitalization
> > 
> I will fix this. 
> 
> >> +
> >>  /**
> >>   * DOC: Basic sk_buff geometry
> >>   *
> >> @@ -819,7 +824,7 @@ typedef unsigned char *sk_buff_data_t;
> >>   *	@dst_pending_confirm: need to confirm neighbour
> >>   *	@decrypted: Decrypted SKB
> >>   *	@slow_gro: state present at GRO time, slower prepare step required
> >> - *	@mono_delivery_time: When set, skb->tstamp has the
> >> + *	@tstamp_type: When set, skb->tstamp has the
> >>   *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
> >>   *		skb->tstamp has the (rcv) timestamp at ingress and
> >>   *		delivery_time at egress.
> >> @@ -950,7 +955,7 @@ struct sk_buff {
> >>  	/* private: */
> >>  	__u8			__mono_tc_offset[0];
> >>  	/* public: */
> >> -	__u8			mono_delivery_time:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
> >> +	__u8			tstamp_type:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
> > 
> > Also remove reference to MONO_DELIVERY_TIME_MASK, or instead refer to
> > skb_tstamp_type.
> > 
> >>  #ifdef CONFIG_NET_XGRESS
> >>  	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
> >>  	__u8			tc_skip_classify:1;
> >> @@ -4237,7 +4242,7 @@ static inline void skb_get_new_timestampns(const struct sk_buff *skb,
> >>  static inline void __net_timestamp(struct sk_buff *skb)
> >>  {
> >>  	skb->tstamp = ktime_get_real();
> >> -	skb->mono_delivery_time = 0;
> >> +	skb->tstamp_type = CLOCK_REAL;
> >>  }
> >>  
> >>  static inline ktime_t net_timedelta(ktime_t t)
> >> @@ -4246,10 +4251,18 @@ static inline ktime_t net_timedelta(ktime_t t)
> >>  }
> >>  
> >>  static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
> >> -					 bool mono)
> >> +					  u8 tstamp_type)
> >>  {
> >>  	skb->tstamp = kt;
> >> -	skb->mono_delivery_time = kt && mono;
> >> +
> >> +	switch (tstamp_type) {
> >> +	case CLOCK_REAL:
> >> +		skb->tstamp_type = CLOCK_REAL;
> >> +		break;
> >> +	case CLOCK_MONO:
> >> +		skb->tstamp_type = kt && tstamp_type;
> >> +		break;
> >> +	}
> > 
> > Technically this leaves the tstamp_type undefined if (skb, 0, CLOCK_REAL)
> Do you think i should be checking for valid value of tstamp before setting the tstamp_type ? Only then set it. 

A kt of 0 is interpreted as resetting the type. That should probably
be maintained.

For SO_TIMESTAMPING, a mono delivery time of 0 does have some meaning.
In __sock_recv_timestamp:

        /* Race occurred between timestamp enabling and packet
           receiving.  Fill in the current time for now. */
        if (need_software_tstamp && skb->tstamp == 0) {
                __net_timestamp(skb);
                false_tstamp = 1;
        }

