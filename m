Return-Path: <bpf+bounces-51378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF81FA338BE
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 08:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D073A46E1
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 07:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A481A20898D;
	Thu, 13 Feb 2025 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWq18+Yt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32ED207643;
	Thu, 13 Feb 2025 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431443; cv=none; b=GaU77H9qf4f4bPu2f98aYHRYxbXA7ncDNges6W4Sy8Pu7Saqp8fXE9bDvIqBbFBrvcHWcjTxElVuKvbiVemAtjXNElkNH04stcMH/YdQxHL3VxuFvXOb4/KPiBoh/LSJKZuuZJOKIS47FsWe6SmIvcCf/C87yMokw5+2x0ohED8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431443; c=relaxed/simple;
	bh=oh3L02/WVwUlwTyYeHA4A/bgUd/1Hv10vu6KgGoTQEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDsOpxe3e8HaLgaXCbn02Ge8HirdqqsZEArsjVY8F4UMKJC0WYuA5Bh5xgiO8PfcpOf9qR6gtW6PEGdCuIEHKrG40G5FMttiCoKTfI3HZvBcUAzmmIpWhQ51MObJIeWHxhT02agj1GfWvm/A6Av6YZAPp7sRqWQP5NzF9WM+Q78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWq18+Yt; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d162ecb2beso1687465ab.2;
        Wed, 12 Feb 2025 23:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739431440; x=1740036240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mP3iiGLxcVmjNVxY2s0LPVzYdz/JJamMxaZIfcB7Ug0=;
        b=iWq18+Yt+gRqxWio9es1mho0GB9ShH0xuqYB2cYuJHXt85mYH1o6UF3BMCqdjQNFWI
         rAM5RghwXRxcMkcaonCFlzXqBfGoqwKLv05tFfYQCtCDvhIgMPvVXu/JSmjD3I88JsyJ
         aBpsLDdqmn2u/cUG4vLKTEKlOYdjNiT4UYEa9/AZ6jTjAVxlmcaYFd/UmOYzwjKfwDuM
         246jn7fi5w4ATyW7egRKcy+KNDNo0yBJ9j9jMhoTUg8WMawowNok5PkCyZRIpddSBd9y
         vi20tGSDZYKmTvY1zo28Y/45I+Py1g2T3aPDq6cNhIZW4aSr0+g6VDH5xwSs85dUhZ7O
         PRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739431440; x=1740036240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mP3iiGLxcVmjNVxY2s0LPVzYdz/JJamMxaZIfcB7Ug0=;
        b=pvfwYXJzjFzx5B/N2FEfU1ktFdDx5gHJfRrqL4XGxa0Gi/ST10Cpo0TFbuZ5i8xjc7
         v/k7iZaLlivNx8HInQVH0AbGF8/4RV/6JNoVXmWC8jd4mDsG8tCENW58gJKRxdMxjlpY
         v8drUeoboSISsZUpoOx58oDHVzIWqwoZ15mcDsgHQCwIMbHa6b+fTuXfAb16ADXgA0So
         JYoeSADJ6+EFjWhlaZkeZHYYaf+HaQv66NOgHcyZvAw/29/6uR+cLsDmBcf/RRydEOnV
         Ki7D2PBTfe9OpMih+2SNnY/Q4eEDb8H0WIazRejx8ZXTAilp/odyw+SuFDWO2TavvANn
         eRHg==
X-Forwarded-Encrypted: i=1; AJvYcCVmtHYe7fIaz7QfxRBarfAMr97Bb+m9LnMq+qwmS1f35d22If8ayklUJ70vK+FKtehPW/A=@vger.kernel.org, AJvYcCWLpVU47FIUqiDn+0T8iH5hyZby3rdVM9fuCazy/C5UVA2F2VC47lL4vXWUkB62b+DR3x+D93WI@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv9Gjdi9QlPiT/o9KOGFO8vuV0c/cRbeju2daHtHFEZDnIfln5
	QoyYMnGDZJRyBGN7UDyOB/bY9UJAbjUruUfyF/8exkdpQJrM2psY3Nvwa+338pctY5YvV8c1G3F
	8R4i3+b84C2Kmi9VlA+l8XI0UOKU=
X-Gm-Gg: ASbGnctuFoBYuoqvBH/+roCMFdK2XbmXrbzRlgIgTuA6DQhXMFiQWZByiYSpBE6rE+H
	6HhUTUXglhk7QNIA3fi4M/2QVCXKlCBMUtHLA+yG/uiIoEkxPqzcfZIA629aoH9Barq37WMVE
X-Google-Smtp-Source: AGHT+IEEQZVyyRcbFoMOE9AAqz7eWKjFxgyhRXAJIWIKc/xVcLuPduYVDdfX0UURwz5igndZSlxTC0/4b4wPjIjpJCc=
X-Received: by 2002:a05:6e02:470c:b0:3d1:9236:ca52 with SMTP id
 e9e14a558f8ab-3d19236cb38mr1554975ab.0.1739431440661; Wed, 12 Feb 2025
 23:24:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212061855.71154-1-kerneljasonxing@gmail.com>
 <20250212061855.71154-10-kerneljasonxing@gmail.com> <67acbdb3be6b5_1bcd3029470@willemb.c.googlers.com.notmuch>
 <CAL+tcoA-5noB0rfHwU=FxANd9yifADFoq-vGkkzW=ZJ=BOnGUA@mail.gmail.com>
In-Reply-To: <CAL+tcoA-5noB0rfHwU=FxANd9yifADFoq-vGkkzW=ZJ=BOnGUA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Feb 2025 15:23:23 +0800
X-Gm-Features: AWEUYZkyn0gKNHGbXSuQHZiAAl1YiZ-Edbg0D1jDUqJZNa0X4458j4SuEhmSEr8
Message-ID: <CAL+tcoA9mi7yfHKf+PGhgjWE0NSrZp44ok+u5v4kOUycSnnbfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 09/12] bpf: add BPF_SOCK_OPS_TS_ACK_OPT_CB callback
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 8:07=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Wed, Feb 12, 2025 at 11:26=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > Support the ACK case for bpf timestamping.
> > >
> > > Add a new sock_ops callback, BPF_SOCK_OPS_TS_ACK_OPT_CB. This
> > > callback will occur at the same timestamping point as the user
> > > space's SCM_TSTAMP_ACK. The BPF program can use it to get the
> > > same SCM_TSTAMP_ACK timestamp without modifying the user-space
> > > application.
> > >
> > > This patch extends txstamp_ack to two bits: 1 stands for
> > > SO_TIMESTAMPING mode, 2 bpf extension.
> > >
> > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > ---
> > >  include/net/tcp.h              | 6 ++++--
> > >  include/uapi/linux/bpf.h       | 5 +++++
> > >  net/core/skbuff.c              | 5 ++++-
> > >  net/dsa/user.c                 | 2 +-
> > >  net/ipv4/tcp.c                 | 2 +-
> > >  net/socket.c                   | 2 +-
> > >  tools/include/uapi/linux/bpf.h | 5 +++++
> > >  7 files changed, 21 insertions(+), 6 deletions(-)
> >
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index 0d704bda6c41..aa080f7ccea4 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -488,7 +488,7 @@ static void tcp_tx_timestamp(struct sock *sk, str=
uct sockcm_cookie *sockc)
> > >
> > >               sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
> > >               if (tsflags & SOF_TIMESTAMPING_TX_ACK)
> > > -                     tcb->txstamp_ack =3D 1;
> > > +                     tcb->txstamp_ack =3D TSTAMP_ACK_SK;
> >
> > Similar to the BPF code, should this by |=3D TSTAMP_ACK_SK?
> >
> > Does not matter in practice if the BPF setter can never precede this.
>
> I gave the same thought on this too. We've already fixed the position
> and order (of using socket timestamping and bpf timestamping).
>
> I have no strong preference. If you insist, I can surely adjust it.

I updated it in the next version locally :)

>
> Thanks,
> Jason

