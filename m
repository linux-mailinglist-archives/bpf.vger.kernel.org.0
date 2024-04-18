Return-Path: <bpf+bounces-27172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D18098AA45D
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 22:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA2C1F2353E
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 20:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9AA199E9F;
	Thu, 18 Apr 2024 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuqyely7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06380199E8C;
	Thu, 18 Apr 2024 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713473360; cv=none; b=a0a60DfwqFg/Ym36f3wPGzURy3EwfWxq2m1r2CmCXeF67rtuUzWHT0j8kcEy+8rKknA2BqVVGi1TJ7eaeBXsm9JH9lt8//V3Gi8xxBmqs+YQje5VndfYmDpcPnZOgVnp07QvoNbKckAgrQ3cvwbElEBee4tu6sagmR8UN1ilqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713473360; c=relaxed/simple;
	bh=lHuFGjMewt+O9EVZ0+MMM8BRjHsBOe46NIZGmVPANxE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cw2I8dYTzfEMwE2R1h5h0xqsyVKMnFM5ChZbylh1JZOOvJYTXUX3yZDWBVmE3JECSZr3F8OLAQLCjTa8Q62W89o+ul4fq0gbAk0c8DrU582ssdNwCkJdW/4i6MQr0AH01BsGmBLWEQNZQ71/S46zL5FW8mNxbUooOXBJosHTLWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuqyely7; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6eb86b69e65so738280a34.3;
        Thu, 18 Apr 2024 13:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713473358; x=1714078158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWrjJx94Oq6p6Fj3fSMcSBCeKIos22t/p8iuVTeSOuo=;
        b=kuqyely7ql51SXi1AATsg6c/zGRX01EPqnIaKW5T9WdzFYFKgS3/h0m6Kd4cRifzuE
         ALRzMhz+Xa6gqzF6466zwxSchRZ3/xc1miiHhodSpKryS5eUcZK5+tE4wxMiE5Paf9Pg
         8f1/4l/gnZs4I2N4qmKRmcjZmTxtTZNIrjvLf+ks3pguQsIPgSjnx8t2/S/UIseBDLQQ
         5avbEYwVZNLeq9XYet4OcdqawjZyQqfqhqaGQYz0uE4Xkq1OuM7e/bcaVBT8ydj4nKrv
         ekrIFch8WDc8BSZYnLA1Z0dNg+dAYNYfQg16nBvyeOxI1TusnfKD4paeP1g7r5ewl043
         bZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713473358; x=1714078158;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rWrjJx94Oq6p6Fj3fSMcSBCeKIos22t/p8iuVTeSOuo=;
        b=QMFqrD5ZqZ1qCMvyBBK4mIpfMiXUHaa8rp9rhhY4wkt+MlQhklVHYfBHBAzTbm4ZSJ
         xbSK7/SgGtbD3wmHUX3me3tbsUadwAUjHJ7+9us8FSMG10H8/RSD9qE1nhUl0ehE2e0y
         omauiYZXol4+uYlrDzNGe7nswdVT8pKHlLHHD7qbDsmfIq1UiKf3W6UQakfxt/HLHHtZ
         A9tsKMVeLIRLI+EqhCoIokEgp4Rd/aH5ixCtqllqoDCyVRlbTSJ4EIaotMFlOrSihd+v
         pWMPIwvUU5U3h94H++kAtjY3DNjcsXej9aa6qi5aw/c+RyQgY+io0q3Aq8eTdLk8pzk4
         3/Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWRjDsB0mTgPIHL5xpkQ9MNEpkMbq6mDhCrbnamBWT0bHfchxBnZGYuZFzCTdGrnSnyagrjbvRIH0tWc3b03VE+g+fGQwoh9O2+xzUBc58rAQ9CEULZrW3WfgiXhvhq9LVye1M6SFjtgiiTJ+fPim7txLX12sjkc/8W
X-Gm-Message-State: AOJu0YyqSY6Zdt6uHz+5PvptCVcUGIfbZ/SJ+4KLOkVxybiZuQhpUoM+
	bd2ywIFp8yqiX/vSCSl7nmWkFJX2T2OFepHn5/lDgtCXFGlalEOesR10CQ==
X-Google-Smtp-Source: AGHT+IFlZSYYCO9TSMWwJSEuw5i6GNPZE++e5TEgjijeKc+kJy+gT5w5+smUdEQXdoj2z8hnAzOGug==
X-Received: by 2002:a9d:634e:0:b0:6eb:ccef:f7ab with SMTP id y14-20020a9d634e000000b006ebcceff7abmr150111otk.29.1713473357992;
        Thu, 18 Apr 2024 13:49:17 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id wl20-20020a05620a57d400b0078ec846066fsm965729qkn.7.2024.04.18.13.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:49:17 -0700 (PDT)
Date: Thu, 18 Apr 2024 16:49:17 -0400
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
Message-ID: <6621874d772a9_fb2e029467@willemb.c.googlers.com.notmuch>
In-Reply-To: <d25533d6-5d09-4c9f-8801-54ac35db98ed@quicinc.com>
References: <20240418004308.1009262-1-quic_abchauha@quicinc.com>
 <20240418004308.1009262-2-quic_abchauha@quicinc.com>
 <66216adc8677c_f648a294aa@willemb.c.googlers.com.notmuch>
 <9a1f8011-2156-4855-8724-fea89d73df11@quicinc.com>
 <66217e7ccb46b_f9d5d294b0@willemb.c.googlers.com.notmuch>
 <d25533d6-5d09-4c9f-8801-54ac35db98ed@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v4 1/2] net: Rename mono_delivery_time to
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
> On 4/18/2024 1:11 PM, Willem de Bruijn wrote:
> > Abhishek Chauhan (ABC) wrote:
> >>
> >>
> >> On 4/18/2024 11:47 AM, Willem de Bruijn wrote:
> >>> Abhishek Chauhan wrote:
> >>>> mono_delivery_time was added to check if skb->tstamp has delivery
> >>>> time in mono clock base (i.e. EDT) otherwise skb->tstamp has
> >>>> timestamp in ingress and delivery_time at egress.
> >>>>
> >>>> Renaming the bitfield from mono_delivery_time to tstamp_type is for
> >>>> extensibilty for other timestamps such as userspace timestamp
> >>>> (i.e. SO_TXTIME) set via sock opts.
> >>>>
> >>>> As we are renaming the mono_delivery_time to tstamp_type, it makes
> >>>> sense to start assigning tstamp_type based on enum defined
> >>>> in this commit.
> >>>>
> >>>> Earlier we used bool arg flag to check if the tstamp is mono in
> >>>> function skb_set_delivery_time, Now the signature of the functions
> >>>> accepts tstamp_type to distinguish between mono and real time.
> >>>>
> >>>> In future tstamp_type:1 can be extended to support userspace timestamp
> >>>> by increasing the bitfield.
> >>>>
> >>>> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> >>>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> >>>
> >>>> +/**
> >>>> + * tstamp_type:1 can take 2 values each
> >>>> + * represented by time base in skb
> >>>> + * 0x0 => real timestamp_type
> >>>> + * 0x1 => mono timestamp_type
> >>>> + */
> >>>> +enum skb_tstamp_type {
> >>>> +	SKB_CLOCK_REAL,	/* Time base is skb is REALTIME */
> >>>> +	SKB_CLOCK_MONO,	/* Time base is skb is MONOTONIC */
> >>>> +};
> >>>> +
> >>>
> >>> Can drop the comments. These names are self documenting.
> >>
> >> Noted! . I will take care of this
> >>>
> >>>>  /**
> >>>>   * DOC: Basic sk_buff geometry
> >>>>   *
> >>>> @@ -819,7 +830,7 @@ typedef unsigned char *sk_buff_data_t;
> >>>>   *	@dst_pending_confirm: need to confirm neighbour
> >>>>   *	@decrypted: Decrypted SKB
> >>>>   *	@slow_gro: state present at GRO time, slower prepare step required
> >>>> - *	@mono_delivery_time: When set, skb->tstamp has the
> >>>> + *	@tstamp_type: When set, skb->tstamp has the
> >>>>   *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
> >>>>   *		skb->tstamp has the (rcv) timestamp at ingress and
> >>>>   *		delivery_time at egress.
> >>>
> >>> Is this still correct? I think all egress does now annotate correctly
> >>> as SKB_CLOCK_MONO. So when not set it always is SKB_CLOCK_REAL.
> >>>
> >> That is correct. 
> >>
> >>>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> >>>> index 61119d42b0fd..a062f88c47c3 100644
> >>>> --- a/net/ipv4/tcp_output.c
> >>>> +++ b/net/ipv4/tcp_output.c
> >>>> @@ -1300,7 +1300,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
> >>>>  	tp = tcp_sk(sk);
> >>>>  	prior_wstamp = tp->tcp_wstamp_ns;
> >>>>  	tp->tcp_wstamp_ns = max(tp->tcp_wstamp_ns, tp->tcp_clock_cache);
> >>>> -	skb_set_delivery_time(skb, tp->tcp_wstamp_ns, true);
> >>>> +	skb_set_delivery_time(skb, tp->tcp_wstamp_ns, CLOCK_MONOTONIC);
> >>>
> >>> Multiple references to CLOCK_MONOTONIC left
> >>>
> >> I think i took care of all the references. Apologies if i didn't understand your comment here. 
> > 
> > On closer read, there is a type issue here.
> > 
> > skb_set_delivery_time takes a u8 tstamp_type. But it is often passed
> > a clockid_t, and that is also what the switch expects.
> > 
> > But it does also get called with a tstamp_type in code like the
> > following:
> > 
> > +       u8 tstamp_type = skb->tstamp_type;
> >         unsigned int hlen, ll_rs, mtu;
> >         ktime_t tstamp = skb->tstamp;
> >         struct ip_frag_state state;
> > @@ -82,7 +82,7 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
> >                         if (iter.frag)
> >                                 ip_fraglist_prepare(skb, &iter);
> >   
> > -                       skb_set_delivery_time(skb, tstamp, mono_delivery_time);
> > +                       skb_set_delivery_time(skb, tstamp, tstamp_type);
> > 
> > So maybe we need two variants, one that takes a tstamp_type and one
> > that tames a clockid_t?
> > 
> > The first can be simple, not switch needed. Just apply the two stores.
> I agree to what you are saying but clockid_t => points to int itself. 
> 
> For example :- 
> 		void qdisc_watchdog_init_clockid(struct qdisc_watchdog *wd, struct Qdisc *qdisc,
> 				 clockid_t clockid)
> 
> 		qdisc_watchdog_init_clockid(wd, qdisc, CLOCK_MONOTONIC); => sch_api.c
> 	       qdisc_watchdog_init_clockid(&q->watchdog, sch, q->clockid); =>sch_etf.c (q->clockid is int)

My concern is more that we use CLOCK_MONOTONIC and SKB_CLOCK_MONO
(and other clocks) interchangeably, without invariant checks to make
sure that they map onto the same integer value.

