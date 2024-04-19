Return-Path: <bpf+bounces-27242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B216D8AB461
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 19:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4190C1F223A3
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 17:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B66B13A87A;
	Fri, 19 Apr 2024 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tqHCGa+/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A1139CE8
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713547809; cv=none; b=hUn/qYoPKI/sNvsfyschGhBzW8fRUgaNsoJO3H4rXwgIQQANkHAFTnpjfH4Zz4Kl9Zmvs8s51k/jcm6zTp2LKEXspFRP9pHfFqSIv1AxvKt5egdGh63zXnNAlZo41QX5SooowWSE9xXrDdPL7HGM2HxDo3KM2sm6XyZgxPmWAH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713547809; c=relaxed/simple;
	bh=9hYjyGUXEwckVg1Cg/VDpqtc9aM7eGRDW+Aan8bidik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rizE3Cj4hPRLowtoxYBs+UzGxgIJhpORNaEARij9ncBAD07J58tZe3bZfqoLs+ukX8ysX8xGsCs/NQWRba6Ms1S1sZEze3tws/55VdTI+zvoFA9Dta7KuaEqWkl6wu0xRa9JpOJ3asZk1ilnUJEVBkkwgEBo+6rzaBgeHIXTVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tqHCGa+/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56fd95160e5so797a12.0
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713547806; x=1714152606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACB+KsWFGBZZ7V+PQeAnsd5K8b26YfVzTbpcO/UizmY=;
        b=tqHCGa+/HIpvPLzUV8QvO7QV07y0QLxKdqRdDYgGgXDBNtpgR8P/1jErys5zHT1g4a
         5BnIl3JdEaHOisBFZcrvbuGvDvUEXZZJjemNQ1SF5v+qzaG2oXWHG0bbvdsSP/MHckqJ
         tHFRG9q1Y/f1eApyVt+sY/KIOKqnduM4Ufxns1nIpZu2vRq5QjVNoGpys+dB1piuz1jN
         vX2dFDZBiKRLYDqos/Uit4KEWAGlxoPlcvONYeul37HlGJGkuBIyAwUPgYC9lkuGXT7N
         1f/pEiiEghTZb8AmX9fryjXvW6LW4xpL+dAKuyPWLwpknupt7P7AEXe2Oy6EcHk7TVUG
         jc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713547806; x=1714152606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACB+KsWFGBZZ7V+PQeAnsd5K8b26YfVzTbpcO/UizmY=;
        b=A6TUo/KdtZtE/7FJfRMWuTaSpmkvRH6d5XMX5PYY1DrfDRXkLNtGBtNbFQrUFrB+Dh
         pUsz0ORWixozzw51yP3ekTNlTZOtdKNCzx9RlyMNfOMg18RWWXFuIPPFBIY0YseyG6U4
         Jd2kvjq+8Z2Ooe8SmjNE5hDhfB9GoSHDtoRnlBi7qnSJDYfZhr93qymotfyZ8MbJfobo
         /HSyc52iuQO8bNvvX1W7lwzL9n62MXSRmyJJOQpOrmHGOQXEXFQN1k4yX/KlNZ+XoHkE
         XLGPrc7siUJGY+Vo9OBhJhVVQ2wOplah8OzI5fo+Mm/mC6wnZgduwyczq3tfZXEKtqtv
         oXSA==
X-Forwarded-Encrypted: i=1; AJvYcCVwcVSZLk2t1pX8oyW4cEvdpSn/RmtbHTaAE5BSyC5NOJYSNAUmxWXboa3Z0qdBEfQ1jbZ/EcuYrCbZ+jptE9H8tzet
X-Gm-Message-State: AOJu0Yy3WdAbyheehKgNK64qvWCagxWZ7VJMVGfhtiJGbAT+9cW5wm21
	VodDMoisLnvvSU5DePmkds4PKet8fscWaUTyM5+xn3dONzXsVwDofwj0SXOEAtjGXRRQUH+N8mW
	XFQImTrG4nOa07xOSROrkbApZHR23RsynFDA9
X-Google-Smtp-Source: AGHT+IHsl5i6N7MypZgUZVbfAOeSNCoA9udZ0W0Svk2jnoGC9uc4W4P349cXO7g3dqHs4KtDSqZ3AaRaZnE+4zB94uI=
X-Received: by 2002:aa7:c41a:0:b0:570:4467:ded7 with SMTP id
 j26-20020aa7c41a000000b005704467ded7mr173183edq.7.1713547805492; Fri, 19 Apr
 2024 10:30:05 -0700 (PDT)
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
 <CANP3RGdh24xyH2V7Sa2fs9Ca=tiZNBdKu1qQ8LFHS3sY41CxmA@mail.gmail.com>
 <b24bc70ae2c50dc50089c45afbed34904f3ee189.camel@mediatek.com> <66227ce6c1898_116a9b294be@willemb.c.googlers.com.notmuch>
In-Reply-To: <66227ce6c1898_116a9b294be@willemb.c.googlers.com.notmuch>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Fri, 19 Apr 2024 10:29:47 -0700
Message-ID: <CANP3RGfxeKDUmGwSsZrAs88Fmzk50XxN+-MtaJZTp641aOhotA@mail.gmail.com>
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without fraglist
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	=?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, yan@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 7:17=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Lena Wang (=E7=8E=8B=E5=A8=9C) wrote:
> > On Wed, 2024-04-17 at 21:15 -0700, Maciej =C5=BBenczykowski wrote:
> > >
> > > External email : Please do not click links or open attachments until
> > > you have verified the sender or the content.
> > >  On Wed, Apr 17, 2024 at 7:53=E2=80=AFPM Lena Wang (=E7=8E=8B=E5=A8=
=9C) <
> > > Lena.Wang@mediatek.com> wrote:
> > > >
> > > > On Wed, 2024-04-17 at 15:48 -0400, Willem de Bruijn wrote:
> > > > >
> > > > > External email : Please do not click links or open attachments
> > > until
> > > > > you have verified the sender or the content.
> > > > >  Lena Wang (=E7=8E=8B=E5=A8=9C) wrote:
> > > > > > On Tue, 2024-04-16 at 19:14 -0400, Willem de Bruijn wrote:
> > > > > > >
> > > > > > > External email : Please do not click links or open
> > > attachments
> > > > > until
> > > > > > > you have verified the sender or the content.
> > > > > > >  > > > > Personally, I think bpf_skb_pull_data() should have
> > > > > > > automatically
> > > > > > > > > > > (ie. in kernel code) reduced how much it pulls so
> > > that it
> > > > > > > would pull
> > > > > > > > > > > headers only,
> > > > > > > > > >
> > > > > > > > > > That would be a helper that parses headers to discover
> > > > > header
> > > > > > > length.
> > > > > > > > >
> > > > > > > > > Does it actually need to?  Presumably the bpf pull
> > > function
> > > > > could
> > > > > > > > > notice that it is
> > > > > > > > > a packet flagged as being of type X (UDP GSO FRAGLIST)
> > > and
> > > > > reduce
> > > > > > > the pull
> > > > > > > > > accordingly so that it doesn't pull anything from the
> > > non-
> > > > > linear
> > > > > > > > > fraglist portion???
> > > > > > > > >
> > > > > > > > > I know only the generic overview of what udp gso is, not
> > > any
> > > > > > > details, so I am
> > > > > > > > > assuming here that there's some sort of guarantee to how
> > > > > these
> > > > > > > packets
> > > > > > > > > are structured...  But I imagine there must be or we
> > > wouldn't
> > > > > be
> > > > > > > hitting these
> > > > > > > > > issues deeper in the stack?
> > > > > > > >
> > > > > > > > Perhaps for a packet of this type we're already guaranteed
> > > the
> > > > > > > headers
> > > > > > > > are in the linear portion,
> > > > > > > > and the pull should simply be ignored?
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > Parsing is better left to the BPF program.
> > > > > > >
> > > > > > > I do prefer adding sanity checks to the BPF helpers, over
> > > having
> > > > > to
> > > > > > > add then in the net hot path only to protect against
> > > dangerous
> > > > > BPF
> > > > > > > programs.
> > > > > > >
> > > > > > Is it OK to ignore or decrease pull length for udp gro fraglist
> > > > > packet?
> > > > > > It could save the normal packet and sent to user correctly.
> > > > > >
> > > > > > In common/net/core/filter.c
> > > > > > static inline int __bpf_try_make_writable(struct sk_buff *skb,
> > > > > >               unsigned int write_len)
> > > > > > {
> > > > > > +if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type &
> > > > > > +(SKB_GSO_UDP  |SKB_GSO_UDP_L4)) {
> > > > >
> > > > > The issue is not with SKB_GSO_UDP_L4, but with SKB_GSO_FRAGLIST.
> > > > >
> > > > Current in kernel just UDP uses SKB_GSO_FRAGLIST to do GRO. In
> > > > udp_offload.c udp4_gro_complete gso_type adds "SKB_GSO_FRAGLIST|
> > > > SKB_GSO_UDP_L4". Here checking these two flags is to limit the
> > > packet
> > > > as "UDP + need GSO + fraglist".
> > > >
> > > > We could remove SKB_GSO_UDP_L4 check for more packet that may
> > > addrive
> > > > skb_segment_list.
> > > >
> > > > > > +return 0;
> > > > >
> > > > > Failing for any pull is a bit excessive. And would kill a sane
> > > > > workaround of pulling only as many bytes as needed.
> > > > >
> > > > > > +     or if (write_len > skb_headlen(skb))
> > > > > > +write_len =3D skb_headlen(skb);
> > > > >
> > > > > Truncating requests would be a surprising change of behavior
> > > > > for this function.
> > > > >
> > > > > Failing for a pull > skb_headlen is arguably reasonable, as
> > > > > the alternative is that we let it go through but have to drop
> > > > > the now malformed packets on segmentation.
> > > > >
> > > > >
> > > > Is it OK as below?
> > > >
> > > > In common/net/core/filter.c
> > > > static inline int __bpf_try_make_writable(struct sk_buff *skb,
> > > >               unsigned int write_len)
> > > > {
> > > > +       if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type &
> > > > +               SKB_GSO_FRAGLIST) && (write_len >
> > > skb_headlen(skb))) {
> > > > +               return 0;
> > >
> > > please limit write_len to skb_headlen() instead of just returning 0
> > >
> >
> > Hi Maze & Willem,
> > Maze's advice is:
> > In common/net/core/filter.c
> > static inline int __bpf_try_make_writable(struct sk_buff *skb,
> >               unsigned int write_len)
> > {
> > +       if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type &
> > +               SKB_GSO_FRAGLIST) && (write_len > skb_headlen(skb))) {
> > +               write_len =3D skb_headlen(skb);
> > +       }
> >         return skb_ensure_writable(skb, write_len);
> > }
> >
> > Willem's advice is to "Failing for a pull > skb_headlen is arguably
> > reasonable...". It prefers to return 0 :
> > +       if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type &
> > +               SKB_GSO_FRAGLIST) && (write_len > skb_headlen(skb))) {
> > +               return 0;
> > +       }
> >
> > It seems a bit conflict. However I am not sure if my understanding is
> > right and hope to get your further guide.
>
> I did not mean to return 0. But to fail a request that would pull an
> unsafe amount. The caller must get a clear error signal.

That's hostile on userspace.
Currently the caller doesn't even check the error return...
Why would we?  We already have to reload all pointers, and have to do
and will thus redo checking on those.

What do you expect the caller to do? Subtract -1 and try again?
That's hard to do from BPF as it involves looping... and is slow.

We already try to not pull too much:

void try_make_writable(struct __sk_buff* skb, int len) {
  if (len > skb->len) len =3D skb->len;
  if (skb->data_end - skb->data < len) bpf_skb_pull_data(skb, len);
}

Is there at least something like skb->len that has the actually
pullable length in it?

Or are these skb's structured in such a way that there is never a need
to pull anything,
because the headers are already always in the linear portion?

> Back to the original report: the issue should already have been fixed
> by commit 876e8ca83667 ("net: fix NULL pointer in skb_segment_list").
> But that commit is in the kernel for which you report the error.
>
> Turns out that the crash is not in skb_segment_list, but later in
> __udpv4_gso_segment_list_csum. Which unconditionally dereferences
> udp_hdr(seg).
>
> The above fix also mentions skb pull as the culprit, but does not
> include a BPF program. If this can be reached in other ways, then we
> do need a stronger test in skb_segment_list, as you propose.
>
> I don't want to narrowly check whether udp_hdr is safe. Essentially,
> an SKB_GSO_FRAGLIST skb layout cannot be trusted at all if even one
> byte would get pulled.

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

