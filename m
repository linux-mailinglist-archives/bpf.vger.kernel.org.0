Return-Path: <bpf+bounces-27108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98058A91E9
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 06:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC282827F4
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 04:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA13E54BCC;
	Thu, 18 Apr 2024 04:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o16NOjeI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E326548E9
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 04:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713413758; cv=none; b=bGAW+wqFOXa2Z2vq0FnfGcLXaRgMnvRjE+qPJKsMnS1+9TNoxBSTgffgfxGU3waPVFA44OPCRhQrZXfRE+l8Np1j0Y9NgouD+/ihKMdtrQTgsapLavs/NJvCkf5/coVLXtElA7ZMcsDx5dy7S04DYw6ffOtkl9+p22KZYCjHKk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713413758; c=relaxed/simple;
	bh=rIjhTSCAnsnjiu64hl14QjOMSBjuVyUzL8jWgHEufos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KblEg6dgCcCDwrdyWgFeJ7BmiJPeRWHdb/8yY7e9Mcmdd1RPvenIx5jg4CU50KwtiYIuUpDFW/DodV2P0nLBiZy51FZFxYkxhmxoGgC3gyzXRME+niMkhIKPW5AQKh136cUQ0igcR2jKzH4YaicEsIpAzyT9D925BrKejFAZ7sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o16NOjeI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so4416a12.1
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 21:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713413753; x=1714018553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ex9vkWAdcavtfrxF59Az8ojAz4XUwKMAJT3nUTpt4g=;
        b=o16NOjeI1QWj9dQkYZLX2YQuSzrHvu/k3nkubK07UFXv0FWnfxz1Ngw0p3yC54CjQX
         tXYqsBqU9Nv3M7s6QebiX9Y4XAOzSI/QyFhtGTw/rflH2sIEGYYo2/8lm7YpVjzcTAYz
         8KCCjeFpCxN6gZfBCDKu7xCPKHGal7ExYSegPOi7RzTPzrqcmmDTL32WFy89HyquDjgZ
         iNZpNhE8oRtH5eUzin2ub9DUGfZ7kPZPFyelPLqy1Zjr8dgPiSjx48+AfXYXAmNAZowi
         neI+dinR/n1yljPKvdpWOLOGHs4XRk76QNebpJ+tUbo8HrNlW64Yyp5ZWn4pdGWD/JyH
         xA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713413753; x=1714018553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ex9vkWAdcavtfrxF59Az8ojAz4XUwKMAJT3nUTpt4g=;
        b=IVk0wVeqsdhaIJmiw7SB35PgTg/7InX6UtU4KX4CFQkBUZg7iycrwTVhs1ugzbC1yX
         ZCSiTwboFH4fhBcKIcPyzyxtOhAy8HDxjS/k2BGqrAYiS2trM+P6d79ZK7mHyGLmSTj3
         WwGNyFbCtKDSQMDdqLRGysskSb7RD4pJh/trcRz+SP1NvysMQt/f23NXPZOhDYK2awlI
         LouHZ2oX5XzoFj5rmgZpbUey1fNmi2ACIkR6s4iEkDjjEW7rCpZ4JXLyRwa0Vl7IGCAq
         Rs1MBa1mQIMSyasoGEhg3aNWi/RRaXmIn40+ryZfrQ9Dq+epluM/pA3irD+gDDOXRU4O
         notQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm7lbWxFBUzWDWB/KkVQN+mmB0d0KwdiAN4ShA5zbijSA+/u4evuf0aXaBQ0f2JVN9X2uOloMeZ6IUPPBnLTNBlYdc
X-Gm-Message-State: AOJu0Yxelv02753KQmiECwHKX0K8hgtQu5RHt8KlIuM82LTJ+UHVW6m8
	3f523EP+6LRqOptlouQpqxT8hpnXJPY9B9eMPxtYnLBXDhV0kBEYL8a1DOEf+Xs18vAUsKicROA
	v4O+9vFGfIk1PX0olGvKDkINM9cfvNi//4mzW
X-Google-Smtp-Source: AGHT+IFtBPp05x4Gt43PJgKZuHCBaPT9SIJnaGjMBBmGzTlaXBVIIe7oqKuU1n08iv6jroCwKE9Iprc9cbGOb5q9FQI=
X-Received: by 2002:a05:6402:50a:b0:571:b9c7:2804 with SMTP id
 m10-20020a056402050a00b00571b9c72804mr45961edv.5.1713413753150; Wed, 17 Apr
 2024 21:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
 <661d93b4e3ec3_3010129482@willemb.c.googlers.com.notmuch> <65e3e88a53d466cf5bad04e5c7bc3f1648b82fd7.camel@mediatek.com>
 <CANP3RGdkxT4TjeSvv1ftXOdFQd5Z4qLK1DbzwATq_t_Dk+V8ig@mail.gmail.com>
 <661eb25eeb09e_6672129490@willemb.c.googlers.com.notmuch> <CANP3RGdrRDERiPFVQ1nZYVtopErjqOQ72qQ_+ijGQiL7bTtcLQ@mail.gmail.com>
 <CANP3RGd+Zd-bx6S-NzeGch_crRK2w0-u6xwSVn71M581uCp9cQ@mail.gmail.com>
 <661f066060ab4_7a39f2945d@willemb.c.googlers.com.notmuch> <77068ef60212e71b270281b2ccd86c8c28ee6be3.camel@mediatek.com>
 <662027965bdb1_c8647294b3@willemb.c.googlers.com.notmuch> <11395231f8be21718f89981ffe3703da3f829742.camel@mediatek.com>
In-Reply-To: <11395231f8be21718f89981ffe3703da3f829742.camel@mediatek.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Wed, 17 Apr 2024 21:15:38 -0700
Message-ID: <CANP3RGdh24xyH2V7Sa2fs9Ca=tiZNBdKu1qQ8LFHS3sY41CxmA@mail.gmail.com>
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without fraglist
To: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
Cc: "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	=?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 7:53=E2=80=AFPM Lena Wang (=E7=8E=8B=E5=A8=9C) <Len=
a.Wang@mediatek.com> wrote:
>
> On Wed, 2024-04-17 at 15:48 -0400, Willem de Bruijn wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  Lena Wang (=E7=8E=8B=E5=A8=9C) wrote:
> > > On Tue, 2024-04-16 at 19:14 -0400, Willem de Bruijn wrote:
> > > >
> > > > External email : Please do not click links or open attachments
> > until
> > > > you have verified the sender or the content.
> > > >  > > > > Personally, I think bpf_skb_pull_data() should have
> > > > automatically
> > > > > > > > (ie. in kernel code) reduced how much it pulls so that it
> > > > would pull
> > > > > > > > headers only,
> > > > > > >
> > > > > > > That would be a helper that parses headers to discover
> > header
> > > > length.
> > > > > >
> > > > > > Does it actually need to?  Presumably the bpf pull function
> > could
> > > > > > notice that it is
> > > > > > a packet flagged as being of type X (UDP GSO FRAGLIST) and
> > reduce
> > > > the pull
> > > > > > accordingly so that it doesn't pull anything from the non-
> > linear
> > > > > > fraglist portion???
> > > > > >
> > > > > > I know only the generic overview of what udp gso is, not any
> > > > details, so I am
> > > > > > assuming here that there's some sort of guarantee to how
> > these
> > > > packets
> > > > > > are structured...  But I imagine there must be or we wouldn't
> > be
> > > > hitting these
> > > > > > issues deeper in the stack?
> > > > >
> > > > > Perhaps for a packet of this type we're already guaranteed the
> > > > headers
> > > > > are in the linear portion,
> > > > > and the pull should simply be ignored?
> > > > >
> > > > > >
> > > > > > > Parsing is better left to the BPF program.
> > > >
> > > > I do prefer adding sanity checks to the BPF helpers, over having
> > to
> > > > add then in the net hot path only to protect against dangerous
> > BPF
> > > > programs.
> > > >
> > > Is it OK to ignore or decrease pull length for udp gro fraglist
> > packet?
> > > It could save the normal packet and sent to user correctly.
> > >
> > > In common/net/core/filter.c
> > > static inline int __bpf_try_make_writable(struct sk_buff *skb,
> > >               unsigned int write_len)
> > > {
> > > +if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type &
> > > +(SKB_GSO_UDP  |SKB_GSO_UDP_L4)) {
> >
> > The issue is not with SKB_GSO_UDP_L4, but with SKB_GSO_FRAGLIST.
> >
> Current in kernel just UDP uses SKB_GSO_FRAGLIST to do GRO. In
> udp_offload.c udp4_gro_complete gso_type adds "SKB_GSO_FRAGLIST|
> SKB_GSO_UDP_L4". Here checking these two flags is to limit the packet
> as "UDP + need GSO + fraglist".
>
> We could remove SKB_GSO_UDP_L4 check for more packet that may addrive
> skb_segment_list.
>
> > > +return 0;
> >
> > Failing for any pull is a bit excessive. And would kill a sane
> > workaround of pulling only as many bytes as needed.
> >
> > > +     or if (write_len > skb_headlen(skb))
> > > +write_len =3D skb_headlen(skb);
> >
> > Truncating requests would be a surprising change of behavior
> > for this function.
> >
> > Failing for a pull > skb_headlen is arguably reasonable, as
> > the alternative is that we let it go through but have to drop
> > the now malformed packets on segmentation.
> >
> >
> Is it OK as below?
>
> In common/net/core/filter.c
> static inline int __bpf_try_make_writable(struct sk_buff *skb,
>               unsigned int write_len)
> {
> +       if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type &
> +               SKB_GSO_FRAGLIST) && (write_len > skb_headlen(skb))) {
> +               return 0;

please limit write_len to skb_headlen() instead of just returning 0

> +       }
>         return skb_ensure_writable(skb, write_len);
> }
>
> > > +}
> > > return skb_ensure_writable(skb, write_len);
> > > }
> > >
> > >
> > > > In this case, it would be detecting this GSO type and failing the
> > > > operation if exceeding skb_headlen().
> > > > > > >
> > > > > > > > and not packet content.
> > > > > > > > (This is assuming the rest of the code isn't ready to
> > deal
> > > > with a longer pull,
> > > > > > > > which I think is the case atm.  Pulling too much, and
> > then
> > > > crashing or forcing
> > > > > > > > the stack to drop packets because of them being malformed
> > > > seems wrong...)
> > > > > > > >
> > > > > > > > In general it would be nice if there was a way to just
> > say
> > > > pull all headers...
> > > > > > > > (or possibly all L2/L3/L4 headers)
> > > > > > > > You in general need to pull stuff *before* you've even
> > looked
> > > > at the packet,
> > > > > > > > so that you can look at the packet,
> > > > > > > > so it's relatively hard/annoying to pull the correct
> > length
> > > > from bpf
> > > > > > > > code itself.
> > > > > > > >
> > > > > > > > > > > BPF needs to modify a proper length to do pull
> > data.
> > > > However kernel
> > > > > > > > > > > should also improve the flow to avoid crash from a
> > bpf
> > > > function
> > > > > > > > > > call.
> > > > > > > > > > > As there is no split flow and app may not decode
> > the
> > > > merged UDP
> > > > > > > > > > packet,
> > > > > > > > > > > we should drop the packet without fraglist in
> > > > skb_segment_list
> > > > > > > > > > here.
> > > > > > > > > > >
> > > > > > > > > > > Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist
> > > > chaining.")
> > > > > > > > > > > Signed-off-by: Shiming Cheng <
> > > > shiming.cheng@mediatek.com>
> > > > > > > > > > > Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  net/core/skbuff.c | 3 +++
> > > > > > > > > > >  1 file changed, 3 insertions(+)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > > > > > > > > index b99127712e67..f68f2679b086 100644
> > > > > > > > > > > --- a/net/core/skbuff.c
> > > > > > > > > > > +++ b/net/core/skbuff.c
> > > > > > > > > > > @@ -4504,6 +4504,9 @@ struct sk_buff
> > > > *skb_segment_list(struct
> > > > > > > > > > sk_buff *skb,
> > > > > > > > > > >  if (err)
> > > > > > > > > > >  goto err_linearize;
> > > > > > > > > > >
> > > > > > > > > > > +if (!list_skb)
> > > > > > > > > > > +goto err_linearize;
> > > > > > > > > > > +
> > > > > > >
> > > > > > > This would catch the case where the entire data frag_list
> > is
> > > > > > > linearized, but not a pskb_may_pull that only pulls in part
> > of
> > > > the
> > > > > > > list.
> > > > > > >
> > > > > > > Even with BPF being privileged, the kernel should not crash
> > if
> > > > BPF
> > > > > > > pulls a FRAGLIST GSO skb.
> > > > > > >
> > > > > > > But the check needs to be refined a bit. For a UDP GSO
> > packet,
> > > > I
> > > > > > > think gso_size is still valid, so if the head_skb length
> > does
> > > > not
> > > > > > > match gso_size, it has been messed with and should be
> > dropped.
> > > > > > >
> > > Is it OK as below? Is it OK to add log to record the error for easy
> > > checking issue.
> > >
> > > In net/core/skbuff.c skb_segment_list
> > > +unsigned int mss =3D skb_shinfo(head_skb)->gso_size;
> > > +bool err_len =3D false;
> > >
> > > +if ( mss !=3D GSO_BY_FRAGS && mss !=3D skb_headlen(head_skb)) {
> > > +pr_err("skb is dropped due to messed data. gso size:%d,
> > > +hdrlen:%d", mss, skb_headlen(head_skb)
> >
> > Such logs should always be rate limited. But no need to log cases
> > where we well understood how we get there.
> >
> > I would stick with one approach: either in the BPF func or in
> > segmentation, not both. And then I find BPF preferable, as explained
> > before.
> >
> OK, we try make a patch in BPF func.
>
> > > +if (!list_skb)
> > > +goto err_linearize;
> > > +else
> > > +err_len =3D true;
> > > +}
> > >
> > > ...
> > > +if (err_len) {
> > > +goto err_linearize;
> > > +}
> > >
> > > skb_get(skb);
> > > ...

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

