Return-Path: <bpf+bounces-27223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 211798AB08A
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 16:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC36D281BB5
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 14:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4717912D74E;
	Fri, 19 Apr 2024 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQmE/Xnr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534538562A;
	Fri, 19 Apr 2024 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536233; cv=none; b=CCZTdqF6TnKSS8sRBI+OltMzyNti5AeIxgiIBeCjKDhAyouXzhtdJqRO1z6V0ZeFkM6PQM9dQNUA5jkLC55tkOcH1/Xli9OceyckVYmmmD9oWGYp3AbG8G1uFMIF18Ob02NQoeoOTG+hBSahMKZO1RpxEbpQg6lHa4JIH+VNMBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536233; c=relaxed/simple;
	bh=sJIqAxmp0MkI+0Rle3MPmTH/t6Q5u46iHaETUAfB5/s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=i0Aq+kqtGSMsQQvifAry/wx7crMlfqgjYft8DPRW8tSuW6H1nEgZtzxrtCP0HxYKRznNvr/FAfV/tBpUX0BbwEpYu34FF9tbiI/tp9zS4et5zdOrIAs91YW8y4hP2gi6j6vJx35dP/0cJCsirsN2TztpD2xxyW6VSKmq+bgDoVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQmE/Xnr; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69b5ece41dfso9001766d6.2;
        Fri, 19 Apr 2024 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713536231; x=1714141031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTXvfmS2qR6Ir1vYAUrlQKPmC+TTAVl7HcrdLRbgBYI=;
        b=eQmE/XnrZcdmKG/rhobsYJFoDvWrig/PI9QMKAbqhQjCnbkyssQyWoOswTqqcjZTcy
         nLLBdQu5XOEbflyQyCwn6dMcY4MisIzGcGG05iVGpDB2EpnjJq0Ct6SAgAuybW9ze5Uv
         gC4GGMbM1omHLZZMq9ozxAt2nVW8og71xowM2fy4ljTMc3Wt0r3Lxzf1ZRO9QiyTYXSn
         gbn4ojz8mtxqh04GXzJRrxWSZuiKKlhse3/TtCseDO9iFTSjZxMKP58a478zG1yDIX/m
         +jt6eUZ/KRQLg5hiVeg3HhA4Cwolxqb6l0FU8T3QL/aHqzyvsLb0CuoGHd1fmaTII+aH
         /sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713536231; x=1714141031;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JTXvfmS2qR6Ir1vYAUrlQKPmC+TTAVl7HcrdLRbgBYI=;
        b=g/Y4g5j0VgmUmfBuSAVtH86nOtkOJ+IR73jBPE6ABFhHGyz/mS+OnyujeKz3WE4vx/
         PkcPFYifY8tsAg2vCaoTNCpvxo9rDBFEXxRioi4RkDlUw9FdTcffvL4mJfAorKyJdNUy
         oYibhUZFR6zSdLiS3C+41nYAJPDQ3J1eW6t5My2azlMIAYTSgy/W5s1fN0sf1NnKRF9B
         aFX+C7gVNQuolcrTpQYyvU0viPSDvjup7BISfkluyLtBqBoDpo4YTLEg9IOtu9kHKNOO
         YLuQPdmN+nrT/2J08fndAvgNzAbPPaNIxZcrhKUjVX9ejTB+hhNpX1nuqfY0bwKo3+CQ
         QEmw==
X-Forwarded-Encrypted: i=1; AJvYcCXsIW0aJZ4ELlRJxqbN5hvVmGUyRy7CK18OiKFVEN78sYNtPvtQmiPnpIU1bLRXOR0JwAxWKfbZoks7A37nb6FCssQLyz+Bm0qHKOay9iy6UYC1/AfQd3pdiz+p
X-Gm-Message-State: AOJu0Yxnxhp4sFJK7doVTe55ll1kzfa3uKcX8RLaxn9OIZxgv0h/Lp0H
	v4n9DjD6rVBlVUeuNMag6Aq23uQ5ScmJd+4HkmhXhi7wKCaqhyAlkiIvhg==
X-Google-Smtp-Source: AGHT+IFwrjRVpq0snyoB1FHwCdBCa0bAZL0wV//OlWBYxoRztrm4rVxhQFgtzOTuyKRMA/r40ls8RA==
X-Received: by 2002:ad4:538c:0:b0:69b:fb9:9a75 with SMTP id i12-20020ad4538c000000b0069b0fb99a75mr1677835qvv.49.1713536231400;
        Fri, 19 Apr 2024 07:17:11 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id b17-20020a0cc991000000b006a0488c5cd1sm1568268qvk.83.2024.04.19.07.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 07:17:11 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:17:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>, 
 "maze@google.com" <maze@google.com>, 
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 yan@cloudflare.com
Message-ID: <66227ce6c1898_116a9b294be@willemb.c.googlers.com.notmuch>
In-Reply-To: <b24bc70ae2c50dc50089c45afbed34904f3ee189.camel@mediatek.com>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
 <661d93b4e3ec3_3010129482@willemb.c.googlers.com.notmuch>
 <65e3e88a53d466cf5bad04e5c7bc3f1648b82fd7.camel@mediatek.com>
 <CANP3RGdkxT4TjeSvv1ftXOdFQd5Z4qLK1DbzwATq_t_Dk+V8ig@mail.gmail.com>
 <661eb25eeb09e_6672129490@willemb.c.googlers.com.notmuch>
 <CANP3RGdrRDERiPFVQ1nZYVtopErjqOQ72qQ_+ijGQiL7bTtcLQ@mail.gmail.com>
 <CANP3RGd+Zd-bx6S-NzeGch_crRK2w0-u6xwSVn71M581uCp9cQ@mail.gmail.com>
 <661f066060ab4_7a39f2945d@willemb.c.googlers.com.notmuch>
 <77068ef60212e71b270281b2ccd86c8c28ee6be3.camel@mediatek.com>
 <662027965bdb1_c8647294b3@willemb.c.googlers.com.notmuch>
 <11395231f8be21718f89981ffe3703da3f829742.camel@mediatek.com>
 <CANP3RGdh24xyH2V7Sa2fs9Ca=tiZNBdKu1qQ8LFHS3sY41CxmA@mail.gmail.com>
 <b24bc70ae2c50dc50089c45afbed34904f3ee189.camel@mediatek.com>
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lena Wang (=E7=8E=8B=E5=A8=9C) wrote:
> On Wed, 2024-04-17 at 21:15 -0700, Maciej =C5=BBenczykowski wrote:
> >  	 =

> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Wed, Apr 17, 2024 at 7:53=E2=80=AFPM Lena Wang (=E7=8E=8B=E5=A8=9C=
) <
> > Lena.Wang@mediatek.com> wrote:
> > >
> > > On Wed, 2024-04-17 at 15:48 -0400, Willem de Bruijn wrote:
> > > >
> > > > External email : Please do not click links or open attachments
> > until
> > > > you have verified the sender or the content.
> > > >  Lena Wang (=E7=8E=8B=E5=A8=9C) wrote:
> > > > > On Tue, 2024-04-16 at 19:14 -0400, Willem de Bruijn wrote:
> > > > > >
> > > > > > External email : Please do not click links or open
> > attachments
> > > > until
> > > > > > you have verified the sender or the content.
> > > > > >  > > > > Personally, I think bpf_skb_pull_data() should have
> > > > > > automatically
> > > > > > > > > > (ie. in kernel code) reduced how much it pulls so
> > that it
> > > > > > would pull
> > > > > > > > > > headers only,
> > > > > > > > >
> > > > > > > > > That would be a helper that parses headers to discover
> > > > header
> > > > > > length.
> > > > > > > >
> > > > > > > > Does it actually need to?  Presumably the bpf pull
> > function
> > > > could
> > > > > > > > notice that it is
> > > > > > > > a packet flagged as being of type X (UDP GSO FRAGLIST)
> > and
> > > > reduce
> > > > > > the pull
> > > > > > > > accordingly so that it doesn't pull anything from the
> > non-
> > > > linear
> > > > > > > > fraglist portion???
> > > > > > > >
> > > > > > > > I know only the generic overview of what udp gso is, not
> > any
> > > > > > details, so I am
> > > > > > > > assuming here that there's some sort of guarantee to how
> > > > these
> > > > > > packets
> > > > > > > > are structured...  But I imagine there must be or we
> > wouldn't
> > > > be
> > > > > > hitting these
> > > > > > > > issues deeper in the stack?
> > > > > > >
> > > > > > > Perhaps for a packet of this type we're already guaranteed
> > the
> > > > > > headers
> > > > > > > are in the linear portion,
> > > > > > > and the pull should simply be ignored?
> > > > > > >
> > > > > > > >
> > > > > > > > > Parsing is better left to the BPF program.
> > > > > >
> > > > > > I do prefer adding sanity checks to the BPF helpers, over
> > having
> > > > to
> > > > > > add then in the net hot path only to protect against
> > dangerous
> > > > BPF
> > > > > > programs.
> > > > > >
> > > > > Is it OK to ignore or decrease pull length for udp gro fraglist=

> > > > packet?
> > > > > It could save the normal packet and sent to user correctly.
> > > > >
> > > > > In common/net/core/filter.c
> > > > > static inline int __bpf_try_make_writable(struct sk_buff *skb,
> > > > >               unsigned int write_len)
> > > > > {
> > > > > +if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type &
> > > > > +(SKB_GSO_UDP  |SKB_GSO_UDP_L4)) {
> > > >
> > > > The issue is not with SKB_GSO_UDP_L4, but with SKB_GSO_FRAGLIST.
> > > >
> > > Current in kernel just UDP uses SKB_GSO_FRAGLIST to do GRO. In
> > > udp_offload.c udp4_gro_complete gso_type adds "SKB_GSO_FRAGLIST|
> > > SKB_GSO_UDP_L4". Here checking these two flags is to limit the
> > packet
> > > as "UDP + need GSO + fraglist".
> > >
> > > We could remove SKB_GSO_UDP_L4 check for more packet that may
> > addrive
> > > skb_segment_list.
> > >
> > > > > +return 0;
> > > >
> > > > Failing for any pull is a bit excessive. And would kill a sane
> > > > workaround of pulling only as many bytes as needed.
> > > >
> > > > > +     or if (write_len > skb_headlen(skb))
> > > > > +write_len =3D skb_headlen(skb);
> > > >
> > > > Truncating requests would be a surprising change of behavior
> > > > for this function.
> > > >
> > > > Failing for a pull > skb_headlen is arguably reasonable, as
> > > > the alternative is that we let it go through but have to drop
> > > > the now malformed packets on segmentation.
> > > >
> > > >
> > > Is it OK as below?
> > >
> > > In common/net/core/filter.c
> > > static inline int __bpf_try_make_writable(struct sk_buff *skb,
> > >               unsigned int write_len)
> > > {
> > > +       if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type &
> > > +               SKB_GSO_FRAGLIST) && (write_len >
> > skb_headlen(skb))) {
> > > +               return 0;
> > =

> > please limit write_len to skb_headlen() instead of just returning 0
> > =

> =

> Hi Maze & Willem,
> Maze's advice is:
> In common/net/core/filter.c
> static inline int __bpf_try_make_writable(struct sk_buff *skb,
>               unsigned int write_len)
> { =

> +       if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type &
> +               SKB_GSO_FRAGLIST) && (write_len > skb_headlen(skb))) {
> +               write_len =3D skb_headlen(skb);
> +       }
>         return skb_ensure_writable(skb, write_len);
> }
> =

> Willem's advice is to "Failing for a pull > skb_headlen is arguably =

> reasonable...". It prefers to return 0 :
> +       if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type &
> +               SKB_GSO_FRAGLIST) && (write_len > skb_headlen(skb))) {
> +               return 0;
> +       }
> =

> It seems a bit conflict. However I am not sure if my understanding is
> right and hope to get your further guide.

I did not mean to return 0. But to fail a request that would pull an
unsafe amount. The caller must get a clear error signal.

Back to the original report: the issue should already have been fixed
by commit 876e8ca83667 ("net: fix NULL pointer in skb_segment_list").
But that commit is in the kernel for which you report the error.

Turns out that the crash is not in skb_segment_list, but later in
__udpv4_gso_segment_list_csum. Which unconditionally dereferences
udp_hdr(seg).

The above fix also mentions skb pull as the culprit, but does not
include a BPF program. If this can be reached in other ways, then we
do need a stronger test in skb_segment_list, as you propose.

I don't want to narrowly check whether udp_hdr is safe. Essentially,
an SKB_GSO_FRAGLIST skb layout cannot be trusted at all if even one
byte would get pulled.=

