Return-Path: <bpf+bounces-75942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C36F5C9DF1B
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 07:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89F2F4E22E0
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 06:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73CA28CF52;
	Wed,  3 Dec 2025 06:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qc60mZQk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oRfq5Yrz"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EEA1427A
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764744037; cv=none; b=RdBNS/W7yjcxNk/EIAlipz+YulZsO350DQDfCFXG5+vKVOuK4ZhA1tk8ce7pRcepn9ViD9e0qZJ5QJxccOh3yymbfiicYkFeHBNNcf5Zo1z2zF5++ozypwegRbq7BYjGzNAIxy38uyzN2K6tuSsA8XXqbcxvm4gc0CYpzdVSzwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764744037; c=relaxed/simple;
	bh=5OeB6d2eKMyb9Anc/66tHp0r70lF7Im5eilAFCd+Q3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSNK3Am7rDzDPkv31Iyf0Oxid3KFBfEe03vftkW9W5+jmriCF0GAFxVHmTHJZb6R1c02Uc5ykA7cCiPYgzVOE3iQS6svbzzYWlH61gJTYBdEasE5n9v0q/4wGbWeuNUvopqeIgvEFemZwM1vzWg0xVzAmOLA+Y5TB8XTdWJhTPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qc60mZQk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oRfq5Yrz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764744034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jG0l340v7u/O9ieUzV/VHaUMn93PBmr7Ay6BZifPY5g=;
	b=Qc60mZQkSt2c0BxF1XB997yBRo2rPNRpSWxWfe2xn3l5tN93LRxka+Gnk4LLUpBlLkkDQr
	tt7Cti+I5yikBYo8a2rPSBrZw4A1kPeUHeJ5KQ2cuDH65izl/DbUSDFY4d7offcZHmwCtN
	TJx8+M9IwIeparnjnacO5C137NGHTfk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-4SjcMst7Nr-JBqUWAnCK8Q-1; Wed, 03 Dec 2025 01:40:32 -0500
X-MC-Unique: 4SjcMst7Nr-JBqUWAnCK8Q-1
X-Mimecast-MFC-AGG-ID: 4SjcMst7Nr-JBqUWAnCK8Q_1764744031
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-343bf6ded5cso10241184a91.0
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 22:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764744031; x=1765348831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jG0l340v7u/O9ieUzV/VHaUMn93PBmr7Ay6BZifPY5g=;
        b=oRfq5YrzVogY5tu7tfKMi6mzlt2Tu8uTE30FdDK0iiKtWIVNKQ+ergJvvYonCXEzv7
         v/q79Xf7p8DYWC9AThZ4/b5g1CTyJuadeMVtGBWbFlfy1t9m+q8Q2H8cQK8gTsvQzTZ2
         aNZTSnCv93IZ/aZBL1hkfV8xHNCjAbJ2VtdNG+mN25EUn+UTNSamyGLAxz+VkzGjygyI
         qjfOVK06N79/BVXPp15Lcz6eT9xu08iudmWo6ROmsvdJ08JYI1ZaxFAzbhvw95UH66ha
         HEa19OoMvbRCm0fNU/Ao7+fqEhi2hSXzslmuTpsw4WGA/bGCCgt7YqoK+yQqbZofo9SD
         xFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764744031; x=1765348831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jG0l340v7u/O9ieUzV/VHaUMn93PBmr7Ay6BZifPY5g=;
        b=BHkrjAWmWNTrhqBjsaRXer0U5svM/F7O31Igdx0OsrjUx8GiS3X+zfgQiyQSfd+CI4
         0dAUKzXdlphe0cSKE20/Gfmnqf4OUNYnP50Z7Lc0mrVO5puKE0tJL86p2CPM4vVRwu94
         FjfROo4isPIWdIgY3QsCLYuKOvrBnviqjRq9im4G8bHtC0mjjiD1JrcRscwEuIUR4z6l
         PWKjXqmXBY7hskB2fWuVbOJRxkVO8QEg3nrh7x5RKlmA6s3FkQE/5iGL/vatG6NiVZ6J
         6J0iNS2eXvA/Iqvh77v+H/56tzCcKAgh3hz3mWkm0jIYwp+5bCNcRg6Fayt3To2GzbGD
         yEmw==
X-Forwarded-Encrypted: i=1; AJvYcCWJiDQQdVSV7SFHRK8vjAnm444+66mxA4vQqRrmTIAayh+btBAMtduH0Jeq3JWLaldpaKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKN5opGDyjCnD3rL8Wfu4Gy63TqieOxVzhLvp1NrlMd8Jw0Aeb
	ymsJbHPYk16LQd90eK7MVtf0cB7+brlEzN2LhyruqntKXrTKfuB/okVi4pB7JeAKu3TBMwTU6xO
	JuMFP16SX8SDjeUWbOxFHsXUku1+8AZmQbSzJgvjNWBoDG9cq4FhjNRf2WW7ws+IBpDjcfKF5Mz
	lfH8SZPHTKv9vYqZYtwoCN9fcoaStB
X-Gm-Gg: ASbGncvn2KY+TIwWyXQzKa7UhzaPJRtwP0bG4xVFueoBjz8x+bO6MdYy6amE3zpvpLI
	wVY193t0c7GAOXhsAn9StwFtBseBANjJ8jCWma7O3qrmBTg6YRxITnQf+0KYPsR63hPzvvLoAOJ
	4ZuisP9af8GIETOCJjw/5OtIvv0pszpHP6o/kDcnccpVQsvs0Hhrd+AG5WKGy3vm3YyYM=
X-Received: by 2002:a17:90b:3b46:b0:340:bfcd:6afa with SMTP id 98e67ed59e1d1-349126e0b33mr1429762a91.8.1764744031344;
        Tue, 02 Dec 2025 22:40:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH+GLAIeSCTl394jWq87voij9DR7c5X8qqIhHzTPLPqc9A0OKLGcyWCnRWIIx3zlAmqkv8QUxSzHqTBcFBRRM=
X-Received: by 2002:a17:90b:3b46:b0:340:bfcd:6afa with SMTP id
 98e67ed59e1d1-349126e0b33mr1429736a91.8.1764744030853; Tue, 02 Dec 2025
 22:40:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125200041.1565663-1-jon@nutanix.com> <20251125200041.1565663-6-jon@nutanix.com>
 <CACGkMEsDCVKSzHSKACAPp3Wsd8LscUE0GO4Ko9GPGfTR0vapyg@mail.gmail.com>
 <CF8FF91A-2197-47F7-882B-33967C9C6089@nutanix.com> <c04b51c6-bc03-410e-af41-64f318b8960f@kernel.org>
 <E9CF75DC-118F-44A7-9752-C6001A1BADFF@nutanix.com> <CACGkMEtLQWzRLL3yGiUEvyM31fhcUiafHoGzFSnuF-XdDN0aUg@mail.gmail.com>
 <AABBC143-F665-44F8-8C5F-79805429A53E@nutanix.com>
In-Reply-To: <AABBC143-F665-44F8-8C5F-79805429A53E@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Dec 2025 14:40:19 +0800
X-Gm-Features: AWmQ_bk01DeKJcmpUBUh8pyMhWd25EOooz553whLE3tH2V6a9281rnWWzdH_plM
Message-ID: <CACGkMEsmN-Z2Kjhqt75-hb-fhW+00kiD0yi=CuX9Zb-nwZn4mA@mail.gmail.com>
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

On Wed, Dec 3, 2025 at 12:35=E2=80=AFPM Jon Kohler <jon@nutanix.com> wrote:
>
>
>
> > On Dec 2, 2025, at 11:10=E2=80=AFPM, Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Wed, Dec 3, 2025 at 1:46=E2=80=AFAM Jon Kohler <jon@nutanix.com> wro=
te:
> >>
> >>
> >>
> >>> On Dec 2, 2025, at 12:32=E2=80=AFPM, Jesper Dangaard Brouer <hawk@ker=
nel.org> wrote:
> >>>
> >>>
> >>>
> >>> On 02/12/2025 17.49, Jon Kohler wrote:
> >>>>> On Nov 27, 2025, at 10:02=E2=80=AFPM, Jason Wang <jasowang@redhat.c=
om> wrote:
> >>>>>
> >>>>> On Wed, Nov 26, 2025 at 3:19=E2=80=AFAM Jon Kohler <jon@nutanix.com=
> wrote:
> >>>>>>
> >>>>>> Optimize TUN_MSG_PTR batch processing by allocating sk_buff struct=
ures
> >>>>>> in bulk from the per-CPU NAPI cache using napi_skb_cache_get_bulk.
> >>>>>> This reduces allocation overhead and improves efficiency, especial=
ly
> >>>>>> when IFF_NAPI is enabled and GRO is feeding entries back to the ca=
che.
> >>>>>
> >>>>> Does this mean we should only enable this when NAPI is used?
> >>>> No, it does not mean that at all, but I see what that would be confu=
sing.
> >>>> I can clean up the commit msg on the next go around
> >>>>>>
> >>>>>> If bulk allocation cannot fully satisfy the batch, gracefully drop=
 only
> >>>>>> the uncovered portion, allowing the rest of the batch to proceed, =
which
> >>>>>> is what already happens in the previous case where build_skb() wou=
ld
> >>>>>> fail and return -ENOMEM.
> >>>>>>
> >>>>>> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >>>>>
> >>>>> Do we have any benchmark result for this?
> >>>> Yes, it is in the cover letter:
> >>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__patchwork.ker=
nel.org_project_netdevbpf_cover_20251125200041.1565663-2D1-2Djon-40nutanix.=
com_&d=3DDwIDaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=3DNGPRGGo37mQiSXgHKm5rCQ&m=3DD=
7piJwOOQSj7C1puBlbh5dmAc-qsLw6E660yC5jJXWZk9ppvjOqT9Xc61ewYSmod&s=3DyUPhRdq=
t2lVnW5FxiOpvKE34iXKyGEWk502Dko1i3PI&e=3D
> >
> > Ok but it only covers UDP, I think we want to see how it performs for
> > TCP as well as latency. Btw is the test for IFF_NAPI or not?
>
> This test was without IFF_NAPI, but I could get the NAPI numbers too
> More on that below
>
> >
> >>>>>> ---
> >>>>>> drivers/net/tun.c | 30 ++++++++++++++++++++++++------
> >>>>>> 1 file changed, 24 insertions(+), 6 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>>>> index 97f130bc5fed..64f944cce517 100644
> >>>>>> --- a/drivers/net/tun.c
> >>>>>> +++ b/drivers/net/tun.c
> >>> [...]
> >>>>>> @@ -2454,6 +2455,7 @@ static int tun_xdp_one(struct tun_struct *tu=
n,
> >>>>>>               ret =3D tun_xdp_act(tun, xdp_prog, xdp, act);
> >>>>>>               if (ret < 0) {
> >>>>>>                       /* tun_xdp_act already handles drop statisti=
cs */
> >>>>>> +                       kfree_skb_reason(skb, SKB_DROP_REASON_XDP)=
;
> >>>>>
> >>>>> This should belong to previous patches?
> >>>> Well, not really, as we did not even have an SKB to free at this poi=
nt
> >>>> in the previous code
> >>>>>
> >>>>>>                       put_page(virt_to_head_page(xdp->data));
> >>>
> >>> This calling put_page() directly also looks dubious.
> >>>
> >>>>>>                       return ret;
> >>>>>>               }
> >>>>>> @@ -2463,6 +2465,7 @@ static int tun_xdp_one(struct tun_struct *tu=
n,
> >>>>>>                       *flush =3D true;
> >>>>>>                       fallthrough;
> >>>>>>               case XDP_TX:
> >>>>>> +                       napi_consume_skb(skb, 1);
> >>>>>>                       return 0;
> >>>>>>               case XDP_PASS:
> >>>>>>                       break;
> >>>>>> @@ -2475,13 +2478,15 @@ static int tun_xdp_one(struct tun_struct *=
tun,
> >>>>>>                               tpage->page =3D page;
> >>>>>>                               tpage->count =3D 1;
> >>>>>>                       }
> >>>>>> +                       napi_consume_skb(skb, 1);
> >>>>>
> >>>>> I wonder if this would have any side effects since tun_xdp_one() is
> >>>>> not called by a NAPI.
> >>>> As far as I can tell, this napi_consume_skb is really just an artifa=
ct of
> >>>> how it was named and how it was traditionally used.
> >>>> Now this is really just a napi_consume_skb within a bh disable/enabl=
e
> >>>> section, which should meet the requirements of how that interface
> >>>> should be used (again, AFAICT)
> >>>
> >>> Yicks - this sounds super ugly.  Just wrapping napi_consume_skb() in =
bh
> >>> disable/enable section and then assuming you get the same protection =
as
> >>> NAPI is really dubious.
> >>>
> >>> Cc Sebastian as he is trying to cleanup these kind of use-case, to ma=
ke
> >>> kernel preemption work.
> >>>
> >>>
> >>>>>
> >>>>>>                       return 0;
> >>>>>>               }
> >>>>>>       }
> >>>>>>
> >>>>>> build:
> >>>>>> -       skb =3D build_skb(xdp->data_hard_start, buflen);
> >>>>>> +       skb =3D build_skb_around(skb, xdp->data_hard_start, buflen=
);
> >>>>>>       if (!skb) {
> >>>>>> +               kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
> >>>> Though to your point, I dont think this actually does anything given
> >>>> that if the skb was somehow nuked as part of build_skb_around, there
> >>>> would not be an skb to free. Doesn=E2=80=99t hurt though, from a sel=
f documenting
> >>>> code perspective tho?
> >>>>>>               dev_core_stats_rx_dropped_inc(tun->dev);
> >>>>>>               return -ENOMEM;
> >>>>>>       }
> >>>>>> @@ -2566,9 +2571,11 @@ static int tun_sendmsg(struct socket *sock,=
 struct msghdr *m, size_t total_len)
> >>>>>>       if (m->msg_controllen =3D=3D sizeof(struct tun_msg_ctl) &&
> >>>>>>           ctl && ctl->type =3D=3D TUN_MSG_PTR) {
> >>>>>>               struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
> >>>>>> +               int flush =3D 0, queued =3D 0, num_skbs =3D 0;
> >>>>>>               struct tun_page tpage;
> >>>>>>               int n =3D ctl->num;
> >>>>>> -               int flush =3D 0, queued =3D 0;
> >>>>>> +               /* Max size of VHOST_NET_BATCH */
> >>>>>> +               void *skbs[64];
> >>>>>
> >>>>> I think we need some tweaks
> >>>>>
> >>>>> 1) TUN is decoupled from vhost, so it should have its own value (a
> >>>>> macro is better)
> >>>> Sure, I can make another constant that does a similar thing
> >>>>> 2) Provide a way to fail or handle the case when more than 64
> >>>> What if we simply assert that the maximum here is 64, which I think
> >>>> is what it actually is in practice?
> >
> > I still prefer a fallback.
>
> Ack, will chew on that for the next one, let=E2=80=99s settle on the larg=
er
> elephant in the room which is the NAPI stuff below, as none of this
> goes anywhere without resolving that first.
>
> >
> >>>>>
> >>>>>>
> >>>>>>               memset(&tpage, 0, sizeof(tpage));
> >>>>>>
> >>>>>> @@ -2576,13 +2583,24 @@ static int tun_sendmsg(struct socket *sock=
, struct msghdr *m, size_t total_len)
> >>>>>>               rcu_read_lock();
> >>>>>>               bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
> >>>>>>
> >>>>>> -               for (i =3D 0; i < n; i++) {
> >>>>>> +               num_skbs =3D napi_skb_cache_get_bulk(skbs, n);
> >>>>>
> >>>>> Its document said:
> >>>>>
> >>>>> """
> >>>>> * Must be called *only* from the BH context.
> >>>>> =E2=80=9C"=E2=80=9D
> >>>> We=E2=80=99re in a bh_disable section here, is that not good enough?
> >>>
> >>> Again this feels very ugly and prone to painting ourselves into a
> >>> corner, assuming BH-disabled sections have same protection as NAPI.
> >>>
> >>> (The napi_skb_cache_get/put function are operating on per CPU arrays
> >>> without any locking.)
> >>
> >> Happy to take suggestions on an alternative approach.
> >>
> >> Thoughts:
> >> 1. Instead of having IFF_NAPI be an opt-in thing, clean up tun so it
> >>   is *always* NAPI=E2=80=99d 100% of the time?
> >
> > IFF_NAPI will have some overheads and it is introduced basically for
> > testing if I was not wrong.
>
> IIRC it was originally introduced for testing, but under some circumstanc=
es
> can be wildly faster, see commit fb3f903769e805221eb19209b3d9128d398038a1
> ("tun: support NAPI for packets received from batched XDP buffs")
>
> You may be thinking of IFF_NAPI_FRAGS, which seems very much =E2=80=9Ctes=
t only=E2=80=9D
> at this point.
>
> Anyhow, assuming you are thinking of IFF_NAPI itself:
> - Are the overheads you=E2=80=99ve got in mind completely structural/unav=
oidable?

NAPI will introduce some latency but I'm not sure if it can be
amortized by the bulking logic you want to introduce. So I think we
need benchmark numbers to decide.

> - Or is that something that would be worth while looking at?

I think so.

>
> As a side note, one thing I did play with that is absolutely silly faster
> is using IFF_NAPI with NAPI threads. Under certain scenarios (high tput
> that is normally copy bound), gains were nutty (like ~75%+), so the point
> is there may be some very interesting juice to squeeze going down that
> path.

I see.

>
> Coming back to the main path here, the whole reason I=E2=80=99m going dow=
n this
> patchset is to try to pickup optimizations that are available in other
> general purpose drivers, which are all NAPI-ized. We=E2=80=99re at the po=
int now
> where tun is getting left behind for things like this because of non-full
> time NAPI.
>
> Said another way, I think it would be an advantage to NAPI-ize tun and
> make it more like regular ole network drivers, so that the generic core
> work being done will benefit tun by default.

The change looks non-trivial, maybe it would be easier to start to
optimize NAPI path first.

>
> >> Outside of people who have
> >>   wired this up in their apps manually, on the virtualization side
> >>   there is currently no support from QEMU/Libvirt to enable IFF_NAPI.
> >>   Might be a nice simplification/cleanup to just =E2=80=9Cdo it=E2=80=
=9D full time?
> >>   Then we can play all these sorts of games under the protection of
> >>   NAPI?
> >
> > A full benchmark needs to be run for this to see.
>
> Do you have a suggested test/suite of tests you=E2=80=99d prefer me to ru=
n
> so that I can make sure I=E2=80=99m gathering the data that you=E2=80=99d=
 like to
> see?

Just FYI, something like this:

https://lkml.org/lkml/2012/12/7/272

Thanks

>
> >> 2. (Some other non-dubious way of protecting this, without refactoring
> >>   for either conditional NAPI (yuck?) or refactoring for full time
> >>   NAPI? This would be nice, happy to take tips!
> >> 3. ... ?
> >>
> >
>


