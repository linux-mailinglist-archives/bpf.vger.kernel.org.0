Return-Path: <bpf+bounces-41410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5754C996CA7
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD24283BAA
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 13:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA90D199E9C;
	Wed,  9 Oct 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIfT12Gj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA46197A77;
	Wed,  9 Oct 2024 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481760; cv=none; b=Ejrv1+zMmApuWJmQCT2wHbFq+UBOmRmPqWB5JQtaUwnuXhrOGFQ5aqkrAwPiqVOgqksUfdk5qDhLASrEUl12PjITDh9I6wmmi7tbClRMPUBOF7AuzHoUoJw4rIugThTi1g8WqIWA4cFZkdj/vXexfN5/ScKMtdooSyT8cK0cqkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481760; c=relaxed/simple;
	bh=oEdZ8vauAp9BR5eYPfjb8EauOKchYEei3bMtlPMO0TM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TP83FdKnGHJjIH5BLaE6ibviYc7HyhkbQx7KLchbD6CbCCNj8eHzhVHy4DBsH2KJqs7NnrYLji5kc14Deixdl7YN0jD2HdE6USKIe23Isymz+BoMoZvVl2ZFH8rQ0mzDnEas/rsWBchVUgiacio5xGMVNsBeTdyJGxgvf3PaN8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIfT12Gj; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82aab679b7bso267372339f.0;
        Wed, 09 Oct 2024 06:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728481758; x=1729086558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlPVMs74xuZ0O9OsS83QdlqJFeHqND+s0RhvzLMyKnc=;
        b=FIfT12GjopJZjgUDWNGAxv5yZ1ixsC4pvoYwZMCQ15ri4Ax7ot7rweihCJwdVysU+1
         cTycXYV4QPkbMHGEgRKj0wZjFVzjtC8S14KTAuqLwizXvdSUOsdGpR7i5ms+a7ruwqwq
         YVH05HAg0/kDzsbx+TjhKk4qsEeLtd507hMluOKxDnV54GjA8RVtVL+PROOEF0774EKT
         4E77GvooEzYJspGGK2PO9w9qZggvCUBr43ah/tozpWfQh98BWGF2FKyMIJGxP77C9Cbk
         QdOHVZAjdWWgFJZDEhZowoC0DRNX277uLhJ3KBdiPCUZWOHAXnycd0QEbluQ0cp12+VT
         3+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728481758; x=1729086558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlPVMs74xuZ0O9OsS83QdlqJFeHqND+s0RhvzLMyKnc=;
        b=wspdJLoeDfUx6pusH7ZPQFOtcxYe0mQSNEzXNpwAXDoKmbIS4bCgoa1rlSfycwPMV3
         MWtCBviwzpsPUEDbjCgKQo2YGy8B64G6OkyQL8HAHTMFpclfSgTEFdvLTpHWlAHFGSUQ
         6mIuofLYZ93KXdviBN76ixDYFcfBJNcFxCAxHp1UhTJmKJuDR2JTuu5qSnzzA2pfjkQ9
         7YqsiT/1SzPTnNjMEZyHvGbOudNaM8RXUXHeC0cN5ZzDKvu34EyrU03nCflE3MzQOIlT
         ZCldiTyxBDl2psdz/jkO/GTskPbYpmtP582xGAeezVKOgrapxy0kTrts8wlDEsHmsh7p
         ulMw==
X-Forwarded-Encrypted: i=1; AJvYcCUp9as+3nGm+CC191iGYY4N989pa+2/Xc2iXym73bCVlB1wN/zCpQ1eNy6JRY2MQFueWFwD/NhH@vger.kernel.org, AJvYcCWhxCy3WVp8Q/iNdNZ2sS37TWtEk3IdD4+sWsUfLVB6TjaIv5p3r5y/zLP4JqlGQ9/wZls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxceblSnbeFv69txDrqkQJuCEOAFcp3xFl5vqF2Gjf1kRDOp73
	Yq/OM1ID9YOoyIkxz/cL7fbaET3wJNwteBQUxdiFGXWCUtiH+liSAqylhlDNrFltMup24mNWYqs
	3p9JJ/GzCsdfezIC9qZlcMwaauO8=
X-Google-Smtp-Source: AGHT+IGFbZ/wtI2Ux9GLqrFrFUjEQd6scE8BHhVYDPsWmIa7g0WTRAJ6Tpm3UezMS7G0pRn2RoURrAHcO5aO2WmufnY=
X-Received: by 2002:a05:6e02:3d48:b0:3a1:a3bd:adcc with SMTP id
 e9e14a558f8ab-3a397ce56b2mr19889425ab.6.1728481757986; Wed, 09 Oct 2024
 06:49:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-8-kerneljasonxing@gmail.com> <9d5dce58-c019-48b3-8815-b9e0f9d4e8cb@linux.dev>
 <CAL+tcoBGe83v+1ej6GYpZpDkFt_hnuzw_mG8E3vEEhSQbUkreA@mail.gmail.com> <670683ea7b8a5_1cca3129485@willemb.c.googlers.com.notmuch>
In-Reply-To: <670683ea7b8a5_1cca3129485@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 21:48:42 +0800
Message-ID: <CAL+tcoB+-J9ezV==TEToanr6cxFaJSA1UvE5ui7wzfgsBraK2g@mail.gmail.com>
Subject: Re: [PATCH net-next 7/9] net-timestamp: open gate for bpf_setsockopt
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 9:23=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Wed, Oct 9, 2024 at 3:19=E2=80=AFPM Martin KaFai Lau <martin.lau@lin=
ux.dev> wrote:
> > >
> > > On 10/8/24 2:51 AM, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Now we allow users to set tsflags through bpf_setsockopt. What I
> > > > want to do is passing SOF_TIMESTAMPING_RX_SOFTWARE flag, so that
> > > > we can generate rx timestamps the moment the skb traverses through
> > > > driver.
> > > >
> > > > Here is an example:
> > > >
> > > > case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
> > > > case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
> > > >       sock_opt =3D SOF_TIMESTAMPING_RX_SOFTWARE;
> > > >       bpf_setsockopt(skops, SOL_SOCKET, SO_TIMESTAMPING,
> > > >                      &sock_opt, sizeof(sock_opt));
> > > >       break;
> > > >
> > > > In this way, we can use bpf program that help us generate and repor=
t
> > > > rx timestamp.
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >   net/core/filter.c | 3 +++
> > > >   1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > index bd0d08bf76bb..9ce99d320571 100644
> > > > --- a/net/core/filter.c
> > > > +++ b/net/core/filter.c
> > > > @@ -5225,6 +5225,9 @@ static int sol_socket_sockopt(struct sock *sk=
, int optname,
> > > >               break;
> > > >       case SO_BINDTODEVICE:
> > > >               break;
> > > > +     case SO_TIMESTAMPING_NEW:
> > > > +     case SO_TIMESTAMPING_OLD:
> > >
> > > I believe this change was proposed before. It will change the user ex=
pectation
> > > on the sk_error_queue. It needs some bits/fields/knobs for bpf. I thi=
nk this
> > > point is similar to other's earlier comments in this thread.
> >
> > Thanks for your reply.
> >
> > After seeing what you mentioned, I searched through the mailing list
> > and found one [1] which was designed to fetch hardware timestamps.
> >
> > [1]=EF=BC=9Ahttps://lore.kernel.org/bpf/51fd5249-140a-4f1b-b20e-703f159=
e88a3@linux.dev/T/
> >
> > >
> > > I only have a chance to briefly look at it. I think it is useful. Thi=
s
> > > bpf/timestamp feature request has come up before.
> >
> > At the very beginning, I had no intention to use bpf_setsockopt() to
> > retrieve the rx timestamp because it will override sk_tsflags, but I
> > cannot implement a good way like what I did to tx path: only setting
> > skb's field. I'm not sure if this override behaviour is acceptable, so
> > I post it to know what the bpf experts' suggestions are.
> >
> > >
> > > A high level comment. The current timestamp should work for non tcp s=
ock? The
> > > bpf/timestamp solution should be able to also.
> >
> > For now, it only supports TCP proto. I would like to quickly implement
> > a framework which is also suitable for other protos. TCP is just a
> > start point.
> >
> > >
> > > sockops is tcp centric. From looking at patch 9 that needs to initial=
ize 4 args,
> > > this interface feels old and not sure we want to extend to other sock=
 types.
> > > This needs some thoughts.
> >
> > For me, I have interests to extend to other sock types. But I'm
> > supposed to ask Willem's opinion first.
> >
> > +Willem de Bruijn Do you want this bpf extension feature to extend to
> > other protos?
>
> There would likely be users for other protocols too, just like
> SO_TIMESTAMPING. Though TCP is probably the most widely used case by
> far.

Agreed !

