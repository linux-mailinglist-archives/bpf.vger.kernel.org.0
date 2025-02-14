Return-Path: <bpf+bounces-51622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 675E2A368F4
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 00:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4597E3B23C6
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 23:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C35B1FCCEE;
	Fri, 14 Feb 2025 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCgW8M/v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A41F191493;
	Fri, 14 Feb 2025 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739575045; cv=none; b=fe+79aDGoC86BQt9ei2zbw9yYvAob5jPuWHyqMaRCeh6/kQVgJDwwKUnFqEIAT7Zk962HqcCq9qIZPmidKMsq3jCIdEz/nrCJUSy1kkZcFAvFabDZGI9tze13BiZlOjwzoM4sBtFFhOjm+7M6+LLhMuoMUTBTIdnDAwg3BcsO/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739575045; c=relaxed/simple;
	bh=pOZ45U9cUXe4v4A3BNp1OQoM8u/UXcFSFR4d7ZCcb2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdY3Jfejisuw+URJrCgdRRwznzeoNpZ8ytKv5hL2ra4uAYFb4bqSnTFvjPyn55/9zGVzeXQ4UFbXqXgT5l78B1NnJwehXeJoO14htH8emjYvjQA+Genq5TD8kJoKtM9LqtKZK/KsthZkrLYVPVVX1bOgZRf7gt52piuuLnszKHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCgW8M/v; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d284b9734fso264695ab.2;
        Fri, 14 Feb 2025 15:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739575043; x=1740179843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TVa+GEHdIMw5XDJfrQRHrfiQ0akjWQPZFCDra18l/8=;
        b=GCgW8M/vM4jU42v3WydsqKSuhyn10i67RAbqrvKDAXgUe+Fzou2ff9w3oW/iwC60lA
         1KI/alQ/hcVSQsx/Q9XfHIe8Q1qE4SILknmpwhtsMFEH9xrlJ80Wr/kRG/9s9RqEhAIN
         8nVh4rKZasEJIodqSr6cH3KA1W+mxHuEhMuosbV+B2Fxmpt+Hv6xChywmzPtHAI8guAI
         A2bjMAh5fr/VxzF60eHEQE0Lpo37wDGsVFoQNxiOdkr1ActRWqq7/FBpqN43tTV3ylQ0
         QgH+6epsARgb+f1Hd4HAT4FEoz6kM4lZzWwwNDt91SzNRGjEoS30VRiEEhrkBTIYB8/T
         Z6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739575043; x=1740179843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TVa+GEHdIMw5XDJfrQRHrfiQ0akjWQPZFCDra18l/8=;
        b=YuINXJLomrkW/yjj8q1GsYh6WTMeD8hBnGWLk61joW0OakNi6Ia+XMFiWtbqJ0U9MZ
         mwA3H4dbyTCQvZWgAx21bQU1hnbv8QCGq7qTIp8GiWVq039kBKqU7mYXIGGAcfmbVdLA
         S/KPKJb639zGNYhLo/8CsSeEWnANLSv5pTURVyqXnw1flFi6OHsaxOJp22ub33bzQtdS
         lCswPqWBwFPTcHfNaqMd1rYzD/IHK7EjnQ+mRsP8jbHan7hQOJzRNSMYLx9JK2+4xxyR
         7y8+DMlx2mWEmYJevMrhb1157OqA+ULnRlYU3+DRGONhmLNFlgGAszDdRhwxsAlLBmg7
         7YZw==
X-Forwarded-Encrypted: i=1; AJvYcCW84oXSC0tq4Dvp1vaHiuM+Hzzg29kwmAV/KQ5wsOCFYw0M7eQCrDwai8SOB83jrQiLIzQ=@vger.kernel.org, AJvYcCXQbrry6Bl1IIv7cFu60/8QeshSXGMjpZigy95x+kPQ+wn41h2z33ofiH/81gj/4UFaRUsVUKy0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs4CMS/mUgFtMQBcnjrLhgLzQKbhWTOkRUI7UwfPFOPOHxCAjs
	XG5VbiwFclMm9SbvzQR67lqAA5DPG8ijsbED2RpacdMPD3Ax5yYYTlgCfJEd0AvS9F+6S96g+zj
	NEFnXIp+B6JUz6PIslXyZwGmkW1s=
X-Gm-Gg: ASbGnctljeMUIjXiOa04joY+i1wl8ZHhM4ByLxX+hnu88Efvs5+SH1MAz9o7sB2w74b
	W8EwshUsd/D3ZmGtmTH1jS8mmMY5RJW8Pa3uLo2gYkL0AO99K2RCkWlNlq65ONl7xAYZHCY+B
X-Google-Smtp-Source: AGHT+IF31TURnSGBBAMrHRyQCDh83TGwh6u5o99fMU5DEEmYgug04rfo/3z2qmkIv4iGW5vnQbBkNpf13o21cX28KpE=
X-Received: by 2002:a05:6e02:3089:b0:3d1:a380:bcd with SMTP id
 e9e14a558f8ab-3d2808b09f6mr10635885ab.10.1739575043555; Fri, 14 Feb 2025
 15:17:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-10-kerneljasonxing@gmail.com> <5f6e9e0b-1a5f-4129-9a88-ad612b6c6e3b@linux.dev>
In-Reply-To: <5f6e9e0b-1a5f-4129-9a88-ad612b6c6e3b@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 15 Feb 2025 07:16:46 +0800
X-Gm-Features: AWEUYZlziJb3X02rhkMtdcIIHocnZ5e9BIkHHoufyjlQW2Q6QZLubzoBssrIHwM
Message-ID: <CAL+tcoCYcpaBDG8GRyP1Fk8WYHAo4ic1YNhmazXEysYUWSTqxg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 09/12] bpf: add BPF_SOCK_OPS_TS_ACK_OPT_CB callback
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 4:34=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/13/25 5:00 PM, Jason Xing wrote:
> > diff --git a/net/dsa/user.c b/net/dsa/user.c
> > index 291ab1b4acc4..794fe553dd77 100644
> > --- a/net/dsa/user.c
> > +++ b/net/dsa/user.c
> > @@ -897,7 +897,7 @@ static void dsa_skb_tx_timestamp(struct dsa_user_pr=
iv *p,
> >   {
> >       struct dsa_switch *ds =3D p->dp->ds;
> >
> > -     if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
> > +     if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NOBPF))
>
> This change should be in patch 8.
>
> [ ... ]
>
> > diff --git a/net/socket.c b/net/socket.c
> > index 262a28b59c7f..517de433d4bb 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -676,7 +676,7 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_fl=
ags)
> >       u8 flags =3D *tx_flags;
> >
> >       if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE) {
> > -             flags |=3D SKBTX_HW_TSTAMP;
> > +             flags |=3D SKBTX_HW_TSTAMP_NOBPF;
>
> Same here.

Sure, you're right. If you feel it's necessary to re-spin, I will
adjust these two points :)

Thanks,
Jason

>
>

