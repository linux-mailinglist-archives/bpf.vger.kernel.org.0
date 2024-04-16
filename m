Return-Path: <bpf+bounces-26881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D5F8A6135
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 04:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B12D2828B6
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 02:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1FD171AB;
	Tue, 16 Apr 2024 02:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EnOWv3mz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EA1E572
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 02:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713236044; cv=none; b=JvRr6mM2pt7UZtnyjq7jeSzBKYY1E33l4TRqIqxA+lIPp08CUMEoCM+4Vawf+778SnFQQYQhCbPQnrUSAvF36u6za/UpLnnxPV/doQr5mX/DiUu60w2IPQ6x69RsEktobzvkl4OCdd6CLBp9yuOvRWfQWb2AvlCGCqx6km1tNAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713236044; c=relaxed/simple;
	bh=IRel4Lsu2YoxCkxFMRRoIZ+lVMAqvPZv1ftyFTWXsh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mt/lzr66zRN1t/kcZhjJRcplTgenzD+ODgURbGyFCYcd4MsTTGnby0J/to2bFSCeZNsVIZLeI+BgVWfdWKAdbO2GlJMvrjiMFJAAAXzNJ0J+u/iLEEBT8SRBF6N6JD1aoH/e3JnsYdE1EsT+yxk5rFCsW6S+YvRWZky2rqA8ad4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EnOWv3mz; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so4979a12.0
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 19:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713236040; x=1713840840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaSImIW1hTM0apnFwhhJ7XqvtxkKwtwLHWxv6+n7UWE=;
        b=EnOWv3mzyfm0rDKRKtC0GRU5HCWIYQMK7OF/1epFYwmgVwL79xrCiAqKCN2jIQm+Jt
         d3qXf3rAzN/mn+YvPJwir8nVDGd5GxQpM4ZB23x5VwpDPtQXwXqzTaXqnTMBI9vapfe0
         AUlqQQJeJXhaXg/kF511CW8+Wpes2fdg2EaL/IDJECZ0zD1YrFqAb09YinmUQlu3AbPB
         Yj0h+Ae/auAnSCpzclgKlTcO6Rv6aSV6X9aRTUYzIUl55xS7KLxEjP+CdjbVBv3i1Sk6
         5Q1nSc2qfzb5y+wYSdyvuF1aYcQiCiurxzb6VyniUH+JY+hOfZRGQEg5TRzTm7PwNXc2
         u4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713236040; x=1713840840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaSImIW1hTM0apnFwhhJ7XqvtxkKwtwLHWxv6+n7UWE=;
        b=oAkQja6kOOn2i63hhIdjfXaCo8yifQ2F56aaZdICYQPIKE/LzLnD7tdmwlKQGs/fCV
         TJFAnX2C30hnRVes42IR5u6qapdogtPtfaGb0VVqXsapSecaPSgxL6y0ibxrGEF6GiIK
         8j00EnVBuzT5HHr0KmsRXHo2tLOWtjqEXAKxEugJwlqAFqTbkkbpD8PHDsgrIKMbfBpq
         DS8q5wYZ94K0/BP6tEeNVpE6bZJ4/vrVV6uXGQrQH9uY1TRXzxb5vbCNXug0G6wfcEdj
         EkD+8QNzFhwc2ORCvVfKT3RhXxLPtzZ5OjbFTdK64Le5hn29l6ZUe/xHMXlNH+x3bnDf
         GnwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJKgN2ZCvyzO9xwMApM3MkPifyfrl7AyNH9tI1H1UXvyByNg2N1qMjKFQPbdSY4228g6vsJe3JJCa7vrssqRPC7bWG
X-Gm-Message-State: AOJu0YyFoUtqQzusklrNpfMDbGXFVjeXpiLFRUBH7zfFxaEu4jJcChhz
	00R1m1t8ie9CnCv/ZMXtZR4N4d/YZb1hViowArdmGN3SUJxs2zpoKm/9gz2NhInBZxpIyNfv+lj
	SN299wIv7UmmAbsi7VjidtRvQVusllk1UqbDl
X-Google-Smtp-Source: AGHT+IGZQ7v6n8rnAdMX07vEbWN6xVu0E1WerrXVb2RxsdXJKzkDUgNzJP6JnEDwvByBxmg2WGvOBWYueEk74xSmxSI=
X-Received: by 2002:a05:6402:7cf:b0:570:257:8ea3 with SMTP id
 u15-20020a05640207cf00b0057002578ea3mr55062edy.7.1713236039593; Mon, 15 Apr
 2024 19:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
 <661d93b4e3ec3_3010129482@willemb.c.googlers.com.notmuch> <65e3e88a53d466cf5bad04e5c7bc3f1648b82fd7.camel@mediatek.com>
In-Reply-To: <65e3e88a53d466cf5bad04e5c7bc3f1648b82fd7.camel@mediatek.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Mon, 15 Apr 2024 19:53:48 -0700
Message-ID: <CANP3RGdkxT4TjeSvv1ftXOdFQd5Z4qLK1DbzwATq_t_Dk+V8ig@mail.gmail.com>
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without fraglist
To: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
Cc: "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	=?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, 
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 7:14=E2=80=AFPM Lena Wang (=E7=8E=8B=E5=A8=9C) <Len=
a.Wang@mediatek.com> wrote:
>
> On Mon, 2024-04-15 at 16:53 -0400, Willem de Bruijn wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  shiming.cheng@ wrote:
> > > From: Shiming Cheng <shiming.cheng@mediatek.com>
> > >
> > > A GRO packet without fraglist is crashed and backtrace is as below:
> > >  [ 1100.812205][    C3] CPU: 3 PID: 0 Comm: swapper/3 Tainted:
> > > G        W  OE      6.6.17-android15-0-g380371ea9bf1 #1
> > >  [ 1100.812317][    C3]  __udp_gso_segment+0x298/0x4d4
> > >  [ 1100.812335][    C3]  __skb_gso_segment+0xc4/0x120
> > >  [ 1100.812339][    C3]  udp_rcv_segment+0x50/0x134
> > >  [ 1100.812344][    C3]  udp_queue_rcv_skb+0x74/0x114
> > >  [ 1100.812348][    C3]  udp_unicast_rcv_skb+0x94/0xac
> > >  [ 1100.812358][    C3]  udp_rcv+0x20/0x30
> > >
> > > The reason that the packet loses its fraglist is that in ingress
> > bpf
> > > it makes a test pull with to make sure it can read packet headers
> > > via direct packet access: In bpf_progs/offload.c
> > > try_make_writable -> bpf_skb_pull_data -> pskb_may_pull ->
> > > __pskb_pull_tail  This operation pull the data in fraglist into
> > linear
> > > and set the fraglist to null.
> >
> > What is the right behavior from BPF with regard to SKB_GSO_FRAGLIST
> > skbs?
> >
> > Some, like SCTP, cannot be linearized ever, as the do not have a
> > single gso_size.
> >
> > Should this BPF operation just fail?
> >
> In most situation for big gso size packet, it indeed fails but BPF
> doesn't check the result. It seems the udp GRO packet can't be pulled/
> trimed/condensed or else it can't be segmented correctly.
>
> As the BPF function comments it doesn't matter if the data pull failed
> or pull less. It just does a blind best effort pull.
>
> A patch to modify bpf pull length is upstreamed to Google before and
> below are part of Google BPF expert maze's reply:
> maze@google.com<maze@google.com> #5Apr 13, 2024 02:30AM
> I *think* if that patch fixes anything, then it's really proving that
> there's a bug in the kernel that needs to be fixed instead.
> It should be legal to call try_make_writable(skb, X) with *any* value
> of X.
>
> I add maze in loop and we could start more discussion here.

Personally, I think bpf_skb_pull_data() should have automatically
(ie. in kernel code) reduced how much it pulls so that it would pull
headers only,
and not packet content.
(This is assuming the rest of the code isn't ready to deal with a longer pu=
ll,
which I think is the case atm.  Pulling too much, and then crashing or forc=
ing
the stack to drop packets because of them being malformed seems wrong...)

In general it would be nice if there was a way to just say pull all headers=
...
(or possibly all L2/L3/L4 headers)
You in general need to pull stuff *before* you've even looked at the packet=
,
so that you can look at the packet,
so it's relatively hard/annoying to pull the correct length from bpf
code itself.

> > > BPF needs to modify a proper length to do pull data. However kernel
> > > should also improve the flow to avoid crash from a bpf function
> > call.
> > > As there is no split flow and app may not decode the merged UDP
> > packet,
> > > we should drop the packet without fraglist in skb_segment_list
> > here.
> > >
> > > Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> > > Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> > > Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> > > ---
> > >  net/core/skbuff.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index b99127712e67..f68f2679b086 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -4504,6 +4504,9 @@ struct sk_buff *skb_segment_list(struct
> > sk_buff *skb,
> > >  if (err)
> > >  goto err_linearize;
> > >
> > > +if (!list_skb)
> > > +goto err_linearize;
> > > +
> > >  skb_shinfo(skb)->frag_list =3D NULL;
> >
> > In absense of plugging the issue in BPF, dropping here is the best
> > we can do indeed, I think.
> >

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

