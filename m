Return-Path: <bpf+bounces-75938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AE0C9DBAD
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 05:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9140D4E5333
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 04:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AFB2749E6;
	Wed,  3 Dec 2025 04:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTVgKrGf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G57/Tq/l"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4244F1F91D6
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 04:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764735063; cv=none; b=pXTUhBrkdahLzoStViq7RIx9YZatgSOlo4vzXolWueFjG9xyA3JHeZQ5CjB4PdyvxF2XIN23L2FY4tvAChXz1C3XULlAmUWbDgbOVbJGsTwASxebJzjOs2r9AOLJWstTQOZqI4Zr1sVQLawtxrLGADJoovYv0+KkAI2ni/Cr6iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764735063; c=relaxed/simple;
	bh=KofCMlPEDsYDUCWF8ZZ+V+xpPpKKLVHZybTZyuJPKic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvN83wwtfhYqaXeFm8YMcz6euv39uBGBbEtTM21VRkFo6Mj2Zlc+gYWeloY4kXrjhEyhTFE5yNwt/1IIdP1IiK8Wb3InaP8uSv2QHRx7qHFiZt/+xeSBsq6L/sFb02LPMbAMKGj7E0rCo8i32TWSISChUS6ey+PAyX7TMWzwO5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GTVgKrGf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G57/Tq/l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764735059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dG4JjPSx0ktmS3X5/y1h/Ri2+EX3xWphwz5l40lCCa8=;
	b=GTVgKrGfzUKzV51KozgFOsd9XFlGUGjh18Fx+sh3JAKF0Nc2e/YiEaNaOhvoBf/lFJJEUj
	OM87oIl5we2MXRTErdjsHneAFxPnbsM7DAERnPyMuriPh0j4v9M+Lwf+x6tnyefFO3S/aZ
	WIUhGBUAWiMei6mvtJhaJoKaoYKg94M=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-idKBI7VAP8uJx4qoY7F66Q-1; Tue, 02 Dec 2025 23:10:57 -0500
X-MC-Unique: idKBI7VAP8uJx4qoY7F66Q-1
X-Mimecast-MFC-AGG-ID: idKBI7VAP8uJx4qoY7F66Q_1764735057
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34377900dbcso12415935a91.2
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 20:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764735057; x=1765339857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dG4JjPSx0ktmS3X5/y1h/Ri2+EX3xWphwz5l40lCCa8=;
        b=G57/Tq/l+ovOYVNoaWAFho2wIAHknNcXAxiFVdxNAJD9bXQtAr+YiJicS4uT8yoLrN
         Jt6yL5oLXcMhM8UCefM6+UO9KD471sswfTregDeqGRCMiLOuamUHMJMYLRoUnXQIApmC
         8VxtQDegwXwKsXo/Chc7kC2MJa9wgeyxxT2XQ6zq+KKLPwbh9Ka3RRydUgecE6wN6kFE
         f8PZdFgKuzJ9VC6q63NQ9x+RWBGd+rw5N9JQGW69NAhhXmiHpZ4l0S7iW4s02JD3zDtM
         zBozf7uaNFwC6OJpVlN0TO/ip3l1QtbMGeOIwE7XKJyzRfkfoRtmvc3yqsJf/XTAWK38
         T0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764735057; x=1765339857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dG4JjPSx0ktmS3X5/y1h/Ri2+EX3xWphwz5l40lCCa8=;
        b=vANsqmPmPm5HqcHWaXwHaEfzjo9uWJvFZXjmWZa/84UImgi3ID5ErFo8JpMlJHKWXt
         PUhBkpTIdYon++qvlkRHTqY3ERH094aObbZJAXpWHJ7LMplqB1fT+n05LV3uEynedo6P
         oqVs6fgTagpuRk8zL3bJofTGfX4k1D9MmusS4fkxEA8Z3NdPd3bFoALRpVCpkwrbKjm+
         lFxVbDWroWZmHrE4oEOY26Gyy3UzoaRokgFRxiE7yP+dYCDyD+eSW+fOwuk+1ltvTYnw
         lWktTNuczT4pxG3WtDLzSHFLFzCm443phQ2hjzND4sbMFrpL/HzDjrZxch0AVk++0OSA
         L0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUvS5xpMYzzqQ3OJcbev/hXrz4yP/qii/EemS7yKPyZwnqEOz3n8qOp4seFcxaNW93csmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyULmOMZMpSBukhGWpbQvBuvFVfrdeu9oRGhIofsnijYO/RpRyL
	gOvIyp7OdrL29Dt7Tn1VHUpAQEzH6ktKudAhMJAIjVJvIZxsf1QWFysRsdtKALCQSSeHo0bgqcD
	/BjMNr59j6ylyl/M6ioDdxuBpmgL/Q6Iz5TSfn9f/5ph1KZt/Sa2g6hoDwa8SpVb06U07u4Bqyt
	Tl0Zys6KyPMKaoqrdrtWjGIV/kD3qi
X-Gm-Gg: ASbGncuzKFvGX7GkM2jXBdLqd0/9U4XOGJCCPPOsPMHBhqH807+mSHoqDtYre8QQRjd
	otdthMiw2SqeMgnaq+gaWrnw3WLS8FmXSb92b6kbj3tjtaYCvfb39+c6nLflqaIZZhCN4vuwqjs
	JF+EgcrPcF5J/gNN9C5hhd5jaYGx/QTXpP5zhVJqUfB2ju82HWLRtE7uPSiWqYwNk=
X-Received: by 2002:a17:90b:2f8c:b0:341:8bdd:5cf3 with SMTP id 98e67ed59e1d1-349125ca2d0mr1323529a91.7.1764735056649;
        Tue, 02 Dec 2025 20:10:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvb4o2o1NZZnPtkDfJPlcJovxPHB7fhuPrYJvabP9qdQO50SjS7EFvUipjN+PcWvppTdItQFUI8CqUBj3csco=
X-Received: by 2002:a17:90b:2f8c:b0:341:8bdd:5cf3 with SMTP id
 98e67ed59e1d1-349125ca2d0mr1323514a91.7.1764735056181; Tue, 02 Dec 2025
 20:10:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125200041.1565663-1-jon@nutanix.com> <20251125200041.1565663-6-jon@nutanix.com>
 <CACGkMEsDCVKSzHSKACAPp3Wsd8LscUE0GO4Ko9GPGfTR0vapyg@mail.gmail.com>
 <CF8FF91A-2197-47F7-882B-33967C9C6089@nutanix.com> <c04b51c6-bc03-410e-af41-64f318b8960f@kernel.org>
 <E9CF75DC-118F-44A7-9752-C6001A1BADFF@nutanix.com>
In-Reply-To: <E9CF75DC-118F-44A7-9752-C6001A1BADFF@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Dec 2025 12:10:45 +0800
X-Gm-Features: AWmQ_bnmGq71x6-IR8KR1QQCvFGRY0pv3wc6fzdAGLh_H32MPUY55bc-Fb3Wz9I
Message-ID: <CACGkMEtLQWzRLL3yGiUEvyM31fhcUiafHoGzFSnuF-XdDN0aUg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/9] tun: use bulk NAPI cache allocation in tun_xdp_one
To: Jon Kohler <jon@nutanix.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 1:46=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
>
>
>
> > On Dec 2, 2025, at 12:32=E2=80=AFPM, Jesper Dangaard Brouer <hawk@kerne=
l.org> wrote:
> >
> >
> >
> > On 02/12/2025 17.49, Jon Kohler wrote:
> >>> On Nov 27, 2025, at 10:02=E2=80=AFPM, Jason Wang <jasowang@redhat.com=
> wrote:
> >>>
> >>> On Wed, Nov 26, 2025 at 3:19=E2=80=AFAM Jon Kohler <jon@nutanix.com> =
wrote:
> >>>>
> >>>> Optimize TUN_MSG_PTR batch processing by allocating sk_buff structur=
es
> >>>> in bulk from the per-CPU NAPI cache using napi_skb_cache_get_bulk.
> >>>> This reduces allocation overhead and improves efficiency, especially
> >>>> when IFF_NAPI is enabled and GRO is feeding entries back to the cach=
e.
> >>>
> >>> Does this mean we should only enable this when NAPI is used?
> >> No, it does not mean that at all, but I see what that would be confusi=
ng.
> >> I can clean up the commit msg on the next go around
> >>>>
> >>>> If bulk allocation cannot fully satisfy the batch, gracefully drop o=
nly
> >>>> the uncovered portion, allowing the rest of the batch to proceed, wh=
ich
> >>>> is what already happens in the previous case where build_skb() would
> >>>> fail and return -ENOMEM.
> >>>>
> >>>> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >>>
> >>> Do we have any benchmark result for this?
> >> Yes, it is in the cover letter:
> >> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__patchwork.kerne=
l.org_project_netdevbpf_cover_20251125200041.1565663-2D1-2Djon-40nutanix.co=
m_&d=3DDwIDaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=3DNGPRGGo37mQiSXgHKm5rCQ&m=3DD7p=
iJwOOQSj7C1puBlbh5dmAc-qsLw6E660yC5jJXWZk9ppvjOqT9Xc61ewYSmod&s=3DyUPhRdqt2=
lVnW5FxiOpvKE34iXKyGEWk502Dko1i3PI&e=3D

Ok but it only covers UDP, I think we want to see how it performs for
TCP as well as latency. Btw is the test for IFF_NAPI or not?

> >>>> ---
> >>>> drivers/net/tun.c | 30 ++++++++++++++++++++++++------
> >>>> 1 file changed, 24 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>> index 97f130bc5fed..64f944cce517 100644
> >>>> --- a/drivers/net/tun.c
> >>>> +++ b/drivers/net/tun.c
> > [...]
> >>>> @@ -2454,6 +2455,7 @@ static int tun_xdp_one(struct tun_struct *tun,
> >>>>                ret =3D tun_xdp_act(tun, xdp_prog, xdp, act);
> >>>>                if (ret < 0) {
> >>>>                        /* tun_xdp_act already handles drop statistic=
s */
> >>>> +                       kfree_skb_reason(skb, SKB_DROP_REASON_XDP);
> >>>
> >>> This should belong to previous patches?
> >> Well, not really, as we did not even have an SKB to free at this point
> >> in the previous code
> >>>
> >>>>                        put_page(virt_to_head_page(xdp->data));
> >
> > This calling put_page() directly also looks dubious.
> >
> >>>>                        return ret;
> >>>>                }
> >>>> @@ -2463,6 +2465,7 @@ static int tun_xdp_one(struct tun_struct *tun,
> >>>>                        *flush =3D true;
> >>>>                        fallthrough;
> >>>>                case XDP_TX:
> >>>> +                       napi_consume_skb(skb, 1);
> >>>>                        return 0;
> >>>>                case XDP_PASS:
> >>>>                        break;
> >>>> @@ -2475,13 +2478,15 @@ static int tun_xdp_one(struct tun_struct *tu=
n,
> >>>>                                tpage->page =3D page;
> >>>>                                tpage->count =3D 1;
> >>>>                        }
> >>>> +                       napi_consume_skb(skb, 1);
> >>>
> >>> I wonder if this would have any side effects since tun_xdp_one() is
> >>> not called by a NAPI.
> >> As far as I can tell, this napi_consume_skb is really just an artifact=
 of
> >> how it was named and how it was traditionally used.
> >> Now this is really just a napi_consume_skb within a bh disable/enable
> >> section, which should meet the requirements of how that interface
> >> should be used (again, AFAICT)
> >
> > Yicks - this sounds super ugly.  Just wrapping napi_consume_skb() in bh
> > disable/enable section and then assuming you get the same protection as
> > NAPI is really dubious.
> >
> > Cc Sebastian as he is trying to cleanup these kind of use-case, to make
> > kernel preemption work.
> >
> >
> >>>
> >>>>                        return 0;
> >>>>                }
> >>>>        }
> >>>>
> >>>> build:
> >>>> -       skb =3D build_skb(xdp->data_hard_start, buflen);
> >>>> +       skb =3D build_skb_around(skb, xdp->data_hard_start, buflen);
> >>>>        if (!skb) {
> >>>> +               kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
> >> Though to your point, I dont think this actually does anything given
> >> that if the skb was somehow nuked as part of build_skb_around, there
> >> would not be an skb to free. Doesn=E2=80=99t hurt though, from a self =
documenting
> >> code perspective tho?
> >>>>                dev_core_stats_rx_dropped_inc(tun->dev);
> >>>>                return -ENOMEM;
> >>>>        }
> >>>> @@ -2566,9 +2571,11 @@ static int tun_sendmsg(struct socket *sock, s=
truct msghdr *m, size_t total_len)
> >>>>        if (m->msg_controllen =3D=3D sizeof(struct tun_msg_ctl) &&
> >>>>            ctl && ctl->type =3D=3D TUN_MSG_PTR) {
> >>>>                struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
> >>>> +               int flush =3D 0, queued =3D 0, num_skbs =3D 0;
> >>>>                struct tun_page tpage;
> >>>>                int n =3D ctl->num;
> >>>> -               int flush =3D 0, queued =3D 0;
> >>>> +               /* Max size of VHOST_NET_BATCH */
> >>>> +               void *skbs[64];
> >>>
> >>> I think we need some tweaks
> >>>
> >>> 1) TUN is decoupled from vhost, so it should have its own value (a
> >>> macro is better)
> >> Sure, I can make another constant that does a similar thing
> >>> 2) Provide a way to fail or handle the case when more than 64
> >> What if we simply assert that the maximum here is 64, which I think
> >> is what it actually is in practice?

I still prefer a fallback.

> >>>
> >>>>
> >>>>                memset(&tpage, 0, sizeof(tpage));
> >>>>
> >>>> @@ -2576,13 +2583,24 @@ static int tun_sendmsg(struct socket *sock, =
struct msghdr *m, size_t total_len)
> >>>>                rcu_read_lock();
> >>>>                bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
> >>>>
> >>>> -               for (i =3D 0; i < n; i++) {
> >>>> +               num_skbs =3D napi_skb_cache_get_bulk(skbs, n);
> >>>
> >>> Its document said:
> >>>
> >>> """
> >>> * Must be called *only* from the BH context.
> >>> =E2=80=9C"=E2=80=9D
> >> We=E2=80=99re in a bh_disable section here, is that not good enough?
> >
> > Again this feels very ugly and prone to painting ourselves into a
> > corner, assuming BH-disabled sections have same protection as NAPI.
> >
> > (The napi_skb_cache_get/put function are operating on per CPU arrays
> > without any locking.)
>
> Happy to take suggestions on an alternative approach.
>
> Thoughts:
> 1. Instead of having IFF_NAPI be an opt-in thing, clean up tun so it
>    is *always* NAPI=E2=80=99d 100% of the time?

IFF_NAPI will have some overheads and it is introduced basically for
testing if I was not wrong.

> Outside of people who have
>    wired this up in their apps manually, on the virtualization side
>    there is currently no support from QEMU/Libvirt to enable IFF_NAPI.
>    Might be a nice simplification/cleanup to just =E2=80=9Cdo it=E2=80=9D=
 full time?
>    Then we can play all these sorts of games under the protection of
>    NAPI?

A full benchmark needs to be run for this to see.

> 2. (Some other non-dubious way of protecting this, without refactoring
>    for either conditional NAPI (yuck?) or refactoring for full time
>    NAPI? This would be nice, happy to take tips!
> 3. ... ?
>


