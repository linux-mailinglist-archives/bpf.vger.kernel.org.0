Return-Path: <bpf+bounces-28724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A78088BD6E1
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 23:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD152823DC
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 21:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B826715B988;
	Mon,  6 May 2024 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLaZqyQw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B608B2BAE5;
	Mon,  6 May 2024 21:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715030982; cv=none; b=a03VCAfvcpUoZa5eVL6XbydbcdSJCKwjy858csWgBMMZHl4sGrLaD2hp8KFL4GCF/AV0Ex5tIhxNnBlNuEbBRDE5FW5MkWSLHmk6KXMw54k5O8YqgWbuNrgAxaOdVHbpTAnXNR70iTduanusae3i2BXw2N/J1gtoXoSNqASSIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715030982; c=relaxed/simple;
	bh=HwHIWivCgQmxxEHe8Ma/PFL0v6rChTH8FWlUeuHRPE4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pwTbvEGUm97HX5RthCsLRN08Ii/kL+FjF9UaBWtIFU0pbp+OKVpAglq5b5cVjN+9ijAZnBKcxoViFaZHiKysG/NGcdv7bMjvdItYUGHfiHcjKb/vjTe4kAfgqh4S67eQ8NT+Cs5uIpdfqa8Br3nEAt3UMW3FGe1wDsVpRveceC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLaZqyQw; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43692353718so18672051cf.0;
        Mon, 06 May 2024 14:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715030979; x=1715635779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiJACAf4cyGWo2MpxSY2i95vrrgN5uTrOokUZZjHftA=;
        b=hLaZqyQwLInBr58BVMmwFB3TTy4IFgJSaEQoEwYTz0DYs1eJ//YJUQFafaupEQqiFL
         p5bSLUUzNpR7otc4t1voLym61n/iCB1lxG4TUkztxzKaGwwQt/q0fDhi6t63kEDxgxRS
         mNRBphD4AudufgDwsaocdyDYwB10tz/EfP0kShpUcnOjkkwirAaxQRCjP2cUi78kXbJJ
         o3aSTnZ2arbiLO5o0DHWQNNw4s776t9uWr00r0zooMqMfLRLgiOggivAskvvh2D/dzYk
         s5pk9hncWBPlmjMxCWWTRr+V0ladwigHRXHxjX3InGfv00+rwyYFtL2KAC2uaSZRI+EV
         MgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715030979; x=1715635779;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XiJACAf4cyGWo2MpxSY2i95vrrgN5uTrOokUZZjHftA=;
        b=Ha0VevzrgFDLOCK2DN+xOVB6T+U2GJYahH2jVlns9ulO30kg5myEWM3dDuBeNMXgxo
         mJYDjo9K4mdD7tqfgKH0IIwkFymw5tSsCH0dIaAFPi44n52Pv1ou7luSQ73pZSP0MkiY
         r3bLTvmafayEjIabQ+02CJHsPXEvbywBnAwifDeSX8tBcWSR5r6y96avhpfomvFxq94m
         kChY8mdiKUhc9NKGGzbWx85L+WW2nJK5uRbT53A7osClgRjd6BC/vYlgKGeB+Vp4Ctia
         xzrID3EhACmM4guHtaTTGJ5EbLsuMVM27moJK/tmhPR31yRLEVNFUAGD9kOvAtyFaVY0
         eYsA==
X-Forwarded-Encrypted: i=1; AJvYcCXrscKFe2odLqyYQPflWETPzSyKIIdcQlFJF22FlxWbc1FshxoYiOsNwTmxQ0dw0f1/JU2C1sM7z4Zybeh4xG9ox98qT/tLv7LwBrC+jEsVsq5pSqy7UpzH14TXRsbvHD6HtKopdY2UWZUT2q5NwkWJ872lF+DhilZC
X-Gm-Message-State: AOJu0YyST/3ps1EdEf0JNUxODjo3xiqaqkzgoKU3Xgbkb6VYur8Hao7r
	fnipnMjODchnie45Ue9RmAOt6XYnyvvW5b0APdZjtqDUpX6i+iAq
X-Google-Smtp-Source: AGHT+IFiRsd4BqchwYqqrWxVDWwa5HyWR9JGMu4j48aXLc21hefAl1vxc8dTjxUuVHr6d1F0LegUpg==
X-Received: by 2002:a05:622a:245:b0:43d:85ae:bf2 with SMTP id c5-20020a05622a024500b0043d85ae0bf2mr2025472qtx.21.1715030979440;
        Mon, 06 May 2024 14:29:39 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id bw17-20020a05622a099100b004349bb95e01sm5569598qtb.26.2024.05.06.14.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:29:39 -0700 (PDT)
Date: Mon, 06 May 2024 17:29:38 -0400
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
Message-ID: <66394bc2af8cb_5a436294c2@willemb.c.googlers.com.notmuch>
In-Reply-To: <36d9ffdf-5715-4814-97db-bbf669294b5f@quicinc.com>
References: <20240504031331.2737365-1-quic_abchauha@quicinc.com>
 <20240504031331.2737365-2-quic_abchauha@quicinc.com>
 <663926b74cbbd_516de29466@willemb.c.googlers.com.notmuch>
 <36d9ffdf-5715-4814-97db-bbf669294b5f@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v6 1/3] net: Rename mono_delivery_time to
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
> On 5/6/2024 11:51 AM, Willem de Bruijn wrote:
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
> >> sense to start assigning tstamp_type based on enum defined
> >> in this commit.
> >>
> >> Earlier we used bool arg flag to check if the tstamp is mono in
> >> function skb_set_delivery_time, Now the signature of the functions
> >> accepts tstamp_type to distinguish between mono and real time.
> >>
> >> Also skb_set_delivery_type_by_clockid is a new function which accepts
> >> clockid to determine the tstamp_type.
> >>
> >> In future tstamp_type:1 can be extended to support userspace timestamp
> >> by increasing the bitfield.
> >>
> >> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> >> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> >> ---
> >> Changes since v5
> >> - Avoided using garble function names as mentioned by
> >>   Willem.
> >> - Implemented a conversion function stead of duplicating 
> >>   the same logic as mentioned by Willem.
> >> - Fixed indentation problems and minor documentation issues
> >>   which mentions tstamp_type as a whole instead of bitfield
> >>   notations. (Mentioned both by Willem and Martin)
> >>   
> >> Changes since v4
> >> - Introduce new function to directly delivery_time and
> >>   another to set tstamp_type based on clockid. 
> >> - Removed un-necessary comments in skbuff.h as 
> >>   enums were obvious and understood.
> >>
> >> Changes since v3
> >> - Fixed inconsistent capitalization in skbuff.h
> >> - remove reference to MONO_DELIVERY_TIME_MASK in skbuff.h
> >>   and point it to skb_tstamp_type now.
> >> - Explicitely setting SKB_CLOCK_MONO if valid transmit_time
> >>   ip_send_unicast_reply 
> >> - Keeping skb_tstamp inline with skb_clear_tstamp. 
> >> - skb_set_delivery_time checks if timstamp is 0 and 
> >>   sets the tstamp_type to SKB_CLOCK_REAL.
> >> - Above comments are given by Willem 
> >> - Found out that skbuff.h has access to uapi/linux/time.h
> >>   So now instead of using  CLOCK_REAL/CLOCK_MONO 
> >>   i am checking actual clockid_t directly to set tstamp_type 
> >>   example:- CLOCK_REALTIME/CLOCK_MONOTONIC 
> >> - Compilation error fixed in 
> >>   net/ieee802154/6lowpan/reassembly.c
> >>
> >> Changes since v2
> >> - Minor changes to commit subject
> >>
> >> Changes since v1
> >> - Squashed the two commits into one as mentioned by Willem.
> >> - Introduced switch in skb_set_delivery_time.
> >> - Renamed and removed directionality aspects w.r.t tstamp_type 
> >>   as mentioned by Willem.
> >>
> >>  include/linux/skbuff.h                     | 53 ++++++++++++++++------
> >>  include/net/inet_frag.h                    |  4 +-
> >>  net/bridge/netfilter/nf_conntrack_bridge.c |  6 +--
> >>  net/core/dev.c                             |  2 +-
> >>  net/core/filter.c                          | 10 ++--
> >>  net/ieee802154/6lowpan/reassembly.c        |  2 +-
> >>  net/ipv4/inet_fragment.c                   |  2 +-
> >>  net/ipv4/ip_fragment.c                     |  2 +-
> >>  net/ipv4/ip_output.c                       |  9 ++--
> >>  net/ipv4/tcp_output.c                      | 16 +++----
> >>  net/ipv6/ip6_output.c                      |  6 +--
> >>  net/ipv6/netfilter.c                       |  6 +--
> >>  net/ipv6/netfilter/nf_conntrack_reasm.c    |  2 +-
> >>  net/ipv6/reassembly.c                      |  2 +-
> >>  net/ipv6/tcp_ipv6.c                        |  2 +-
> >>  net/sched/act_bpf.c                        |  4 +-
> >>  net/sched/cls_bpf.c                        |  4 +-
> >>  17 files changed, 80 insertions(+), 52 deletions(-)
> >>
> >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> >> index 1c2902eaebd3..de3915e2bfdb 100644
> >> --- a/include/linux/skbuff.h
> >> +++ b/include/linux/skbuff.h
> >> @@ -706,6 +706,11 @@ typedef unsigned int sk_buff_data_t;
> >>  typedef unsigned char *sk_buff_data_t;
> >>  #endif
> >>  
> >> +enum skb_tstamp_type {
> >> +	SKB_CLOCK_REALTIME,
> >> +	SKB_CLOCK_MONOTONIC,
> >> +};
> >> +
> >>  /**
> >>   * DOC: Basic sk_buff geometry
> >>   *
> >> @@ -823,10 +828,9 @@ typedef unsigned char *sk_buff_data_t;
> >>   *	@dst_pending_confirm: need to confirm neighbour
> >>   *	@decrypted: Decrypted SKB
> >>   *	@slow_gro: state present at GRO time, slower prepare step required
> >> - *	@mono_delivery_time: When set, skb->tstamp has the
> >> - *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
> >> - *		skb->tstamp has the (rcv) timestamp at ingress and
> >> - *		delivery_time at egress.
> >> + *	@tstamp_type: When set, skb->tstamp has the
> >> + *		delivery_time in mono clock base Otherwise, the
> >> + *		timestamp is considered real clock base.
> > 
> > Missing period. More importantly, no longer conditional. It always
> > captures the type of skb->tstamp.
> > 
> I think i should move the patchset 2 documentation to this patch itself. 
> 
> @tstamp_type: When set, skb->tstamp has the
> + *		delivery_time clock base of skb->tstamp.
> >> --- a/net/ipv4/tcp_output.c
> >> +++ b/net/ipv4/tcp_output.c
> >> @@ -1301,7 +1301,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
> >>  	tp = tcp_sk(sk);
> >>  	prior_wstamp = tp->tcp_wstamp_ns;
> >>  	tp->tcp_wstamp_ns = max(tp->tcp_wstamp_ns, tp->tcp_clock_cache);
> >> -	skb_set_delivery_time(skb, tp->tcp_wstamp_ns, true);
> >> +	skb_set_delivery_type_by_clockid(skb, tp->tcp_wstamp_ns, CLOCK_MONOTONIC);
> >>  	if (clone_it) {
> >>  		oskb = skb;
> >>  
> >> @@ -1655,7 +1655,7 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
> >>  
> >>  	skb_split(skb, buff, len);
> >>  
> >> -	skb_set_delivery_time(buff, skb->tstamp, true);
> >> +	skb_set_delivery_type_by_clockid(buff, skb->tstamp, CLOCK_MONOTONIC);
> >>  	tcp_fragment_tstamp(skb, buff);
> > 
> > All these hardcoded monotonic calls in TCP can be the shorter version
> > 
> >     skb_set_delivery_type(.., SKB_CLOCK_MONOTONIC);
> I think i should directly call skb_set_delivery_time if i know that TCP always uses Monotonic clock base, 
> rather than calling the wrapper api which does nothing but switch and then calls skb_set_delivery_Time. 
> 
> Makes sense. I will make the changes in v7 . 

Thanks, +1 on both


