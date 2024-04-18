Return-Path: <bpf+bounces-27167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 308028AA3E5
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 22:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86140B2279E
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 20:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78DA1836CC;
	Thu, 18 Apr 2024 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzZ/xxfX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ADD17B4F8;
	Thu, 18 Apr 2024 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713471104; cv=none; b=KgvfS91OcMiO0ZkumU1TvZ8Gw3oL7332TpNdMbAnV1Tzr8G9X4FXx+KeVFlPFy8pR8z+t+CGctngxMiGjuF3bGQ8qlNVpIc3siMZrG+568c0imsMZVhG+vhUHQSYpFbbDl9xtTTkWAzlTOJsfP7afOJPRjOltBfvQDVUDey1Fvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713471104; c=relaxed/simple;
	bh=w9QPgR67JPxBOUYeVl0ENHnaWdOJgRBXEMwIbrOQ96g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MZghOLhh9cpgOuMpTzZ1uANfvbumHIpvkCsAxCizZnYbCXVTyiGSCF23j5qsskQE8u6mKnbc7S6b6MSxh2esk2Lpm0E9dwX7DqcMPlBFdYAt9HkTiXfquleR3vpItbW3FmSjRG7F/g3c5E5HAEalWfPtqYv83GT2+FWsKM564eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzZ/xxfX; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-436ffd27871so7980881cf.2;
        Thu, 18 Apr 2024 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713471101; x=1714075901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dV6l302/vcFJVA3Oq8h48egizVittlBZ5cAu1pxtTHo=;
        b=EzZ/xxfXRSi1DLprehplWadj8984W7cnbUi2Ot6WKBzwGBngBj/+gRT366MI928Ojt
         HeFCMEVPFUFFTbG4B6FEMrWRUpvSQV1RW9zZNAvI7oA55/Mqq4xrO+FCCkCcamEjhDnX
         5tF3olF4ODrOddy7I6+/xRuhZB06aAdJGhKKqxHHbaZ6YssVZCmSPrZr00O1YyNr8etn
         +jQ9z6O5dICAuOn4B9eVDsPMtocZGsNUq6l33OZzlI1SWI/5z/zmn9w3Fz1+I7AXmCh3
         Qdca2WKwIALc54i48lDt6xzsYL9ifTwb1ql/ImGhQlW7swD9pEhOJ5xX2duq3UJgaB7P
         c4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713471101; x=1714075901;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dV6l302/vcFJVA3Oq8h48egizVittlBZ5cAu1pxtTHo=;
        b=o6SHg92ZezjgcAmTV+6POC9eTiESLS1DjhdTRLvLMxp+f02rK5OliWy/zgOBH/k8c0
         9rpw/+BwKC9sm4DIj1K+ABAV9wcTOGjOAXur/2EvL1sslgPVu+cERjG3qM1hwV64taSH
         13dIBqLJCPJdTYx9tlGA8a6IwIG451iEqgQi4W7vrBnKOzttXgKD0DZqFSy9GWBHcdDh
         4Z3eAZmwb1f4gUtXAzAnhTJI1S50YCHRrGNtJJg7o0vZKOurjUtzTJJEqyvkIx76ddUx
         Al0G+FkDhY/DlXaIeeum6kPH7XZkE+qbaXwO5EjlwWeWLlFuJ0NBhf9g9tG0LWebSkCN
         +jcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7+D2DMGLFUfqAei/Ae2goCYuz6mznD7BS8bx9Ia+z94z3+YCqFmLOebqY88GezoVLH33P/fvwca95XwZHChViEgdyHI6Sbjubr13URmxjtg0liiecUNSN2hiLIxPUxXHYP7hdQfvVUAsgpBalgGaQjpgnWRNVSH6j
X-Gm-Message-State: AOJu0Ywk2h/dYp9NXSitMX+r1L24dJHh7Mi/26L8pdoJTxEET3d0ZcY0
	I+Ua1WAevvKI8ulQsFAgvnh7O0atak9a03kDcC+mC9A4N2wd9MiD
X-Google-Smtp-Source: AGHT+IFWqsMr8k14mrdzDa6mycXedZMQhFoiObtUgXjCJwj6RJcY2Kgqxc8upBgFwGD/3QohCpLpFA==
X-Received: by 2002:a05:622a:1209:b0:436:5ca6:cd90 with SMTP id y9-20020a05622a120900b004365ca6cd90mr98392qtx.60.1713471101595;
        Thu, 18 Apr 2024 13:11:41 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id n2-20020a0cdc82000000b0069b160230cbsm938434qvk.11.2024.04.18.13.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:11:41 -0700 (PDT)
Date: Thu, 18 Apr 2024 16:11:40 -0400
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
Message-ID: <66217e7ccb46b_f9d5d294b0@willemb.c.googlers.com.notmuch>
In-Reply-To: <9a1f8011-2156-4855-8724-fea89d73df11@quicinc.com>
References: <20240418004308.1009262-1-quic_abchauha@quicinc.com>
 <20240418004308.1009262-2-quic_abchauha@quicinc.com>
 <66216adc8677c_f648a294aa@willemb.c.googlers.com.notmuch>
 <9a1f8011-2156-4855-8724-fea89d73df11@quicinc.com>
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
> On 4/18/2024 11:47 AM, Willem de Bruijn wrote:
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
> >> In future tstamp_type:1 can be extended to support userspace timestamp
> >> by increasing the bitfield.
> >>
> >> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> >> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> > 
> >> +/**
> >> + * tstamp_type:1 can take 2 values each
> >> + * represented by time base in skb
> >> + * 0x0 => real timestamp_type
> >> + * 0x1 => mono timestamp_type
> >> + */
> >> +enum skb_tstamp_type {
> >> +	SKB_CLOCK_REAL,	/* Time base is skb is REALTIME */
> >> +	SKB_CLOCK_MONO,	/* Time base is skb is MONOTONIC */
> >> +};
> >> +
> > 
> > Can drop the comments. These names are self documenting.
> 
> Noted! . I will take care of this
> > 
> >>  /**
> >>   * DOC: Basic sk_buff geometry
> >>   *
> >> @@ -819,7 +830,7 @@ typedef unsigned char *sk_buff_data_t;
> >>   *	@dst_pending_confirm: need to confirm neighbour
> >>   *	@decrypted: Decrypted SKB
> >>   *	@slow_gro: state present at GRO time, slower prepare step required
> >> - *	@mono_delivery_time: When set, skb->tstamp has the
> >> + *	@tstamp_type: When set, skb->tstamp has the
> >>   *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
> >>   *		skb->tstamp has the (rcv) timestamp at ingress and
> >>   *		delivery_time at egress.
> > 
> > Is this still correct? I think all egress does now annotate correctly
> > as SKB_CLOCK_MONO. So when not set it always is SKB_CLOCK_REAL.
> > 
> That is correct. 
> 
> >> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> >> index 61119d42b0fd..a062f88c47c3 100644
> >> --- a/net/ipv4/tcp_output.c
> >> +++ b/net/ipv4/tcp_output.c
> >> @@ -1300,7 +1300,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
> >>  	tp = tcp_sk(sk);
> >>  	prior_wstamp = tp->tcp_wstamp_ns;
> >>  	tp->tcp_wstamp_ns = max(tp->tcp_wstamp_ns, tp->tcp_clock_cache);
> >> -	skb_set_delivery_time(skb, tp->tcp_wstamp_ns, true);
> >> +	skb_set_delivery_time(skb, tp->tcp_wstamp_ns, CLOCK_MONOTONIC);
> > 
> > Multiple references to CLOCK_MONOTONIC left
> > 
> I think i took care of all the references. Apologies if i didn't understand your comment here. 

On closer read, there is a type issue here.

skb_set_delivery_time takes a u8 tstamp_type. But it is often passed
a clockid_t, and that is also what the switch expects.

But it does also get called with a tstamp_type in code like the
following:

+       u8 tstamp_type = skb->tstamp_type;
        unsigned int hlen, ll_rs, mtu;
        ktime_t tstamp = skb->tstamp;
        struct ip_frag_state state;
@@ -82,7 +82,7 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
                        if (iter.frag)
                                ip_fraglist_prepare(skb, &iter);
  
-                       skb_set_delivery_time(skb, tstamp, mono_delivery_time);
+                       skb_set_delivery_time(skb, tstamp, tstamp_type);

So maybe we need two variants, one that takes a tstamp_type and one
that tames a clockid_t?

The first can be simple, not switch needed. Just apply the two stores.

