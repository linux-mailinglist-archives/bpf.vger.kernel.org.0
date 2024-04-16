Return-Path: <bpf+bounces-26999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F13AD8A72B8
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 19:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062891C2125B
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 17:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC51134425;
	Tue, 16 Apr 2024 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jSvXkSsk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FFD132C23
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713290272; cv=none; b=ejiF+g8m0ejdhYiPG9FWNrTrkjZsXPA8qPEskkIt8gwufTWfKmYc9LsghwJUMtnnOxK5ndB5kKwwQSHNPiQjdA16smEueYibkcGf0C1toCHCEhuKBG2gMsM8I+htZ8Wek+Cj6ci/XpOaHCyDfyBD1lGSs2925hnIyps4C6hTpNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713290272; c=relaxed/simple;
	bh=A+Dn9JU2Ub67zrb2LLRGQ+9jvnfSK7ebeHiPzPDswvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPS83PZc/Mrtu2HeomupFLIwXGJas3oJnH9vA290e5e5gziHPJmvhbRdtka8s2eHtdzQD5qK/D6kCqfcRLur1ujWcxUjAEL/qj1bX/sRkupxZK2ZxfXTJmEiiV//d1PILw7XBxTAdi/9X/nVhCvmNrBlS48BmUr7/Po/3OkW2B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jSvXkSsk; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so1745a12.0
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713290269; x=1713895069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqAfh1LemdGeoEGZBsK1uDH9ZqA59qr8lE2AuWsogk8=;
        b=jSvXkSsk8g51ci3n3KuiJikLLPMM3j6bXy3drTqTOXKx4a3DcynoRZBGqK9dp0VP1g
         55mHj/S1TNCTRlCBqAW9ncyphGc5VEpO/99xmQuCtHSeAS5yeKOgoXzSGCVQpywcQy2I
         QNjiZ+X3ZhAYtb5+yhurPLs7ihHrI2PMwAXpHO8E45lYz/8igUiT0V0aiRy0oPtves8Y
         9LS1tSNtURrhK/zXYEOJUYYqlE1XsmFVz8jbAiV1T6Mk9ZfnDRWS7/to9WZpAXEuiO+t
         ZFPZGAjuFJjeQJHncPWZqGWJdBoH+XsFl/OE9ZS/KDSQh8+5edhAbW55BP3vx4gYjpuS
         CC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713290269; x=1713895069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqAfh1LemdGeoEGZBsK1uDH9ZqA59qr8lE2AuWsogk8=;
        b=bu/UMTLk3+mhpfxR1FvDRAk8kh5aAYzJjkLN9XOyZf8rrWpaqMr/8r1hWXUNNOlriC
         17Gj1E/PQk8LCHv85WwN/UajlMWmKx7GiG89Utbv/EKIoxbpY7MUMqJdqUHpixTy/m7X
         KlD46CzKYIZvEwNl35L/GGTnhTnPtogGUZ95isg5gXlkezvN6eAZ9W10ophfTMe9PuM4
         r7yfK+3c/hRE6UXPZg9Ve+3xFdS8TKh4oFSbDkaND5PUSSJhrtoLcbpSTtm32Ws7znKu
         Ri4zmtA37Z9QN9HCOEg81EdsZzlwB6kJ5aKps7+DpAd9wE2blt80uEd6B7sgX9cWp6PZ
         KKyA==
X-Forwarded-Encrypted: i=1; AJvYcCVj9ei0cuyqEXsh4uDGaL1NH5FkAOld+AlPTARBiueblYxiKPtbORYhg8on4x1xrYKwoeP5xBL6lvcZ7humNVwYVMzt
X-Gm-Message-State: AOJu0Yyncdzk5HfNRHxw0HV4qWzvICbwuS6NAeJPQpjbPkea3u1WIBle
	0pji2w5uY+cEOeM8h40eyBz8BhfOIFxwxRv7N3JedzdiVuY+w8UJ4oFMgkvjWL+fn9cn2vpJiRr
	FjBgMOEHLrXSxVtTPJIXB6/8iVBm12PrcTkHd
X-Google-Smtp-Source: AGHT+IFxCMda5906nh0Devdxatg/+3FcIZ/D6W495UPSNZY6EGW00h1ueg2qVcu9c/im8lmHZ6TLv0HSpSdLVBymSJE=
X-Received: by 2002:aa7:c058:0:b0:570:481a:8a1f with SMTP id
 k24-20020aa7c058000000b00570481a8a1fmr6183edo.5.1713290269009; Tue, 16 Apr
 2024 10:57:49 -0700 (PDT)
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
In-Reply-To: <CANP3RGdrRDERiPFVQ1nZYVtopErjqOQ72qQ_+ijGQiL7bTtcLQ@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Tue, 16 Apr 2024 10:57:37 -0700
Message-ID: <CANP3RGd+Zd-bx6S-NzeGch_crRK2w0-u6xwSVn71M581uCp9cQ@mail.gmail.com>
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without fraglist
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>, 
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	=?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 10:51=E2=80=AFAM Maciej =C5=BBenczykowski <maze@goo=
gle.com> wrote:
>
> On Tue, Apr 16, 2024 at 10:16=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Maciej =C5=BBenczykowski wrote:
> > > On Mon, Apr 15, 2024 at 7:14=E2=80=AFPM Lena Wang (=E7=8E=8B=E5=A8=9C=
) <Lena.Wang@mediatek.com> wrote:
> > > >
> > > > On Mon, 2024-04-15 at 16:53 -0400, Willem de Bruijn wrote:
> > > > >
> > > > > External email : Please do not click links or open attachments un=
til
> > > > > you have verified the sender or the content.
> > > > >  shiming.cheng@ wrote:
> > > > > > From: Shiming Cheng <shiming.cheng@mediatek.com>
> > > > > >
> > > > > > A GRO packet without fraglist is crashed and backtrace is as be=
low:
> > > > > >  [ 1100.812205][    C3] CPU: 3 PID: 0 Comm: swapper/3 Tainted:
> > > > > > G        W  OE      6.6.17-android15-0-g380371ea9bf1 #1
> > > > > >  [ 1100.812317][    C3]  __udp_gso_segment+0x298/0x4d4
> > > > > >  [ 1100.812335][    C3]  __skb_gso_segment+0xc4/0x120
> > > > > >  [ 1100.812339][    C3]  udp_rcv_segment+0x50/0x134
> > > > > >  [ 1100.812344][    C3]  udp_queue_rcv_skb+0x74/0x114
> > > > > >  [ 1100.812348][    C3]  udp_unicast_rcv_skb+0x94/0xac
> > > > > >  [ 1100.812358][    C3]  udp_rcv+0x20/0x30
> > > > > >
> > > > > > The reason that the packet loses its fraglist is that in ingres=
s
> > > > > bpf
> > > > > > it makes a test pull with to make sure it can read packet heade=
rs
> > > > > > via direct packet access: In bpf_progs/offload.c
> > > > > > try_make_writable -> bpf_skb_pull_data -> pskb_may_pull ->
> > > > > > __pskb_pull_tail  This operation pull the data in fraglist into
> > > > > linear
> > > > > > and set the fraglist to null.
> > > > >
> > > > > What is the right behavior from BPF with regard to SKB_GSO_FRAGLI=
ST
> > > > > skbs?
> > > > >
> > > > > Some, like SCTP, cannot be linearized ever, as the do not have a
> > > > > single gso_size.
> > > > >
> > > > > Should this BPF operation just fail?
> > > > >
> > > > In most situation for big gso size packet, it indeed fails but BPF
> > > > doesn't check the result. It seems the udp GRO packet can't be pull=
ed/
> > > > trimed/condensed or else it can't be segmented correctly.
> > > >
> > > > As the BPF function comments it doesn't matter if the data pull fai=
led
> > > > or pull less. It just does a blind best effort pull.
> > > >
> > > > A patch to modify bpf pull length is upstreamed to Google before an=
d
> > > > below are part of Google BPF expert maze's reply:
> > > > maze@google.com<maze@google.com> #5Apr 13, 2024 02:30AM
> > > > I *think* if that patch fixes anything, then it's really proving th=
at
> > > > there's a bug in the kernel that needs to be fixed instead.
> > > > It should be legal to call try_make_writable(skb, X) with *any* val=
ue
> > > > of X.
> > > >
> > > > I add maze in loop and we could start more discussion here.
> > >
> > > Personally, I think bpf_skb_pull_data() should have automatically
> > > (ie. in kernel code) reduced how much it pulls so that it would pull
> > > headers only,
> >
> > That would be a helper that parses headers to discover header length.
>
> Does it actually need to?  Presumably the bpf pull function could
> notice that it is
> a packet flagged as being of type X (UDP GSO FRAGLIST) and reduce the pul=
l
> accordingly so that it doesn't pull anything from the non-linear
> fraglist portion???
>
> I know only the generic overview of what udp gso is, not any details, so =
I am
> assuming here that there's some sort of guarantee to how these packets
> are structured...  But I imagine there must be or we wouldn't be hitting =
these
> issues deeper in the stack?

Perhaps for a packet of this type we're already guaranteed the headers
are in the linear portion,
and the pull should simply be ignored?

>
> > Parsing is better left to the BPF program.
> >
> > > and not packet content.
> > > (This is assuming the rest of the code isn't ready to deal with a lon=
ger pull,
> > > which I think is the case atm.  Pulling too much, and then crashing o=
r forcing
> > > the stack to drop packets because of them being malformed seems wrong=
...)
> > >
> > > In general it would be nice if there was a way to just say pull all h=
eaders...
> > > (or possibly all L2/L3/L4 headers)
> > > You in general need to pull stuff *before* you've even looked at the =
packet,
> > > so that you can look at the packet,
> > > so it's relatively hard/annoying to pull the correct length from bpf
> > > code itself.
> > >
> > > > > > BPF needs to modify a proper length to do pull data. However ke=
rnel
> > > > > > should also improve the flow to avoid crash from a bpf function
> > > > > call.
> > > > > > As there is no split flow and app may not decode the merged UDP
> > > > > packet,
> > > > > > we should drop the packet without fraglist in skb_segment_list
> > > > > here.
> > > > > >
> > > > > > Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> > > > > > Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> > > > > > Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> > > > > > ---
> > > > > >  net/core/skbuff.c | 3 +++
> > > > > >  1 file changed, 3 insertions(+)
> > > > > >
> > > > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > > > index b99127712e67..f68f2679b086 100644
> > > > > > --- a/net/core/skbuff.c
> > > > > > +++ b/net/core/skbuff.c
> > > > > > @@ -4504,6 +4504,9 @@ struct sk_buff *skb_segment_list(struct
> > > > > sk_buff *skb,
> > > > > >  if (err)
> > > > > >  goto err_linearize;
> > > > > >
> > > > > > +if (!list_skb)
> > > > > > +goto err_linearize;
> > > > > > +
> >
> > This would catch the case where the entire data frag_list is
> > linearized, but not a pskb_may_pull that only pulls in part of the
> > list.
> >
> > Even with BPF being privileged, the kernel should not crash if BPF
> > pulls a FRAGLIST GSO skb.
> >
> > But the check needs to be refined a bit. For a UDP GSO packet, I
> > think gso_size is still valid, so if the head_skb length does not
> > match gso_size, it has been messed with and should be dropped.
> >
> > For a GSO_BY_FRAGS skb, there is no single gso_size, and this pull
> > may be entirely undetectable as long as frag_list !=3D NULL?
> >
> >
> > > > > >  skb_shinfo(skb)->frag_list =3D NULL;
> > > > >
> > > > > In absense of plugging the issue in BPF, dropping here is the bes=
t
> > > > > we can do indeed, I think.

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

