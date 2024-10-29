Return-Path: <bpf+bounces-43386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE089B4CD0
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 16:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A826B224BF
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 15:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA7A18E379;
	Tue, 29 Oct 2024 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny8RV8NH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D490EEC5;
	Tue, 29 Oct 2024 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214203; cv=none; b=nl8+sKr9o8iSEptoNtiqKw+0JjWFRX/jm8mVgn7LePVlPm7/W1hGiirQne7F2ECYs4axituddk34VYmFnrWnjbmN83kQBkBywBdtVoOBZogq0DU56f5La1wI3ZK4bkLtOVtELeEn0gx12xpr6qCMBWiZTECdLY/dly0j38fqil4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214203; c=relaxed/simple;
	bh=/fnWBxxMh8TqwF6qDwewVMeXVmprHJpToDVtlDI5FbI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XyRyjXu5b31jbx1E+MTnLlIOqHZlFF48AJ8rotqsv264oTou2PSfKhI3p4CXddJqbmD/fl3bNo3mu4EKmX/fvlP0PTCmjDd3anVcPChS12/YOsQNK/BjsB0FfRat84ZjYnGRj93lieN6bkwwWcpKcMqbUbGLpg9SyEaiO6bLO/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ny8RV8NH; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cc2ea27a50so58019116d6.0;
        Tue, 29 Oct 2024 08:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730214200; x=1730819000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=py7eMLB6U4279XKeeWsMCCp2gymkkBx3RUkba6nxEOA=;
        b=Ny8RV8NH2hwVs4otnf57odNbOZFQr2zZHx2WDOtVwk54EWeTNB1x2XqU9eqavn0Ffd
         60AvxtrUgebR2hov2XPqPNlegesguJWFcDSMjRQyWx5WENOgcNl/uU1RxRap42xlEU0b
         zAyHkCgYUtUlIBIGpoHKPclJVsLkA50pFreqIfIf59uEvxZfFFfeXrBnh56Zf9gSnxov
         rd4x/2i16Wh9voE5mVEDSHoQzFAxRbBSqLPkvvhCKOfPHeIvZqCqXBdWzV2fBHaNP6K7
         9zG9u42w8ATtLBc7GmBP8AGx2JfPupNK/jU1As0Vhm7xxlhWXDBHXB8pRcjU/8fOGMzW
         TcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730214200; x=1730819000;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=py7eMLB6U4279XKeeWsMCCp2gymkkBx3RUkba6nxEOA=;
        b=ZV75Vi8Pg+/vSqq4D8BIsC+N1IlIJbWOLkb/ZnJ0epRsJs8eZwcedmBS/q+MgUknkv
         vixeTsHJ8CcEHYv+x8DpK3pJrBk5oH9Tv1TTlC6G/6rVWxxJk2ORZwVlWbdT1aunnZk7
         nPuoybUWtKZF1jevs1Aq7ejd6dFLgzkgHgaH4tXSofKhkoJ2tKQxnbYUJue9LUTtXjDZ
         OAHKakLqK85JqBg12ewxOfCTjww4yWdGwc1bMu9zHno97D0b0XQgRkePPhpAgBn9+Oup
         buh66f7oPw9RZo0UvwLNQqdLQugKkkp3oIScPR32/JVbN6SEi+rJ24yKfZzLoBeV3GaZ
         IB/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJh8zfQNVDOwdR0JVxjtzO80agFnMgQD5pbQwBDh+JEudw9AiVwchvxAdCzeS952S4lOzRPOwF@vger.kernel.org, AJvYcCX/uFDdppmERCnWqRmft+ESqNiskX8QFrfE7vEdISWTC8hFK3nPHNZiFdP8XOCISMq+rqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7r5AwgiKYU+9To/F7ycXUNlcuXfBTnbhnMEgcrMWHrr/QVsib
	CvDzoE4unAU5Hm2dDH5xlmHPD8XW1Np6lS2G9jctR9U9oGjG05GJ
X-Google-Smtp-Source: AGHT+IEOEkz3z5ZwiGQqZRDqE8MLLm+jADlpdiPbgivl3Pqmzgr5NaXHe9AiHr3ADMSKDpLEJ86/RQ==
X-Received: by 2002:a05:6214:3d9d:b0:6ce:23c0:b5d3 with SMTP id 6a1803df08f44-6d2e72505d4mr42773776d6.19.1730214199502;
        Tue, 29 Oct 2024 08:03:19 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a56620sm42673186d6.135.2024.10.29.08.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 08:03:18 -0700 (PDT)
Date: Tue, 29 Oct 2024 11:03:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <6720f9359d2ef_2bcd7f29458@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoBgbA1Q_7UaC0vp-mGHqDHxQ+eMybep0kw=E-T0oJAHfw@mail.gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-11-kerneljasonxing@gmail.com>
 <6720394714070_24dce62944a@willemb.c.googlers.com.notmuch>
 <CAL+tcoBgbA1Q_7UaC0vp-mGHqDHxQ+eMybep0kw=E-T0oJAHfw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 10/14] net-timestamp: add basic support with
 tskey offset
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Tue, Oct 29, 2024 at 9:24=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Use the offset to record the delta value between current socket key=

> > > and bpf socket key.
> > >
> > > 1. If there is only bpf feature running, the socket key is bpf sock=
et
> > > key and the offset is zero;
> > > 2. If there is only traditional feature running, and then bpf featu=
re
> > > is turned on, the socket key is still used by the former while the =
offset
> > > is the delta between them;
> > > 3. if there is only bpf feature running, and then application uses =
it,
> > > the socket key would be re-init for application and the offset is t=
he
> > > delta.
> >
> > We need to also figure out the rare conflict when one user sets
> > OPT_ID | OPT_ID_TCP while the other only uses OPT_ID.
> =

> I think the current patch handles the case because:
> 1. sock_calculate_tskey_offset() gets the final key first whether the
> OPT_ID_TCP is set or not.
> 2. we will use that tskey to calculate the delta.

Oh yes of course. Great, then this is resolved.

> > > +static long int sock_calculate_tskey_offset(struct sock *sk, int v=
al, int bpf_type)
> > > +{
> > > +     u32 tskey;
> > > +
> > > +     if (sk_is_tcp(sk)) {
> > > +             if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))=

> > > +                     return -EINVAL;
> > > +
> > > +             if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
> > > +                     tskey =3D tcp_sk(sk)->write_seq;
> > > +             else
> > > +                     tskey =3D tcp_sk(sk)->snd_una;
> > > +     } else {
> > > +             tskey =3D 0;
> > > +     }
> > > +
> > > +     if (bpf_type && (sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {=

> > > +             sk->sk_tskey_bpf_offset =3D tskey - atomic_read(&sk->=
sk_tskey);
> > > +             return 0;
> > > +     } else if (!bpf_type && (sk->sk_tsflags_bpf & SOF_TIMESTAMPIN=
G_OPT_ID)) {
> > > +             sk->sk_tskey_bpf_offset =3D atomic_read(&sk->sk_tskey=
) - tskey;
> > > +     } else {
> > > +             sk->sk_tskey_bpf_offset =3D 0;
> > > +     }
> > > +
> > > +     return tskey;
> > > +}
> > > +
> > >  int sock_set_tskey(struct sock *sk, int val, int bpf_type)
> > >  {
> > >       u32 tsflags =3D bpf_type ? sk->sk_tsflags_bpf : sk->sk_tsflag=
s;
> > > @@ -901,17 +944,13 @@ int sock_set_tskey(struct sock *sk, int val, =
int bpf_type)
> > >
> > >       if (val & SOF_TIMESTAMPING_OPT_ID &&
> > >           !(tsflags & SOF_TIMESTAMPING_OPT_ID)) {
> > > -             if (sk_is_tcp(sk)) {
> > > -                     if ((1 << sk->sk_state) &
> > > -                         (TCPF_CLOSE | TCPF_LISTEN))
> > > -                             return -EINVAL;
> > > -                     if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
> > > -                             atomic_set(&sk->sk_tskey, tcp_sk(sk)-=
>write_seq);
> > > -                     else
> > > -                             atomic_set(&sk->sk_tskey, tcp_sk(sk)-=
>snd_una);
> > > -             } else {
> > > -                     atomic_set(&sk->sk_tskey, 0);
> > > -             }
> > > +             long int ret;
> > > +
> > > +             ret =3D sock_calculate_tskey_offset(sk, val, bpf_type=
);
> > > +             if (ret <=3D 0)
> > > +                     return ret;
> > > +
> > > +             atomic_set(&sk->sk_tskey, ret);
> > >       }
> > >
> > >       return 0;
> > > @@ -956,10 +995,15 @@ static int sock_set_timestamping_bpf(struct s=
ock *sk,
> > >                                    struct so_timestamping timestamp=
ing)
> > >  {
> > >       u32 flags =3D timestamping.flags;
> > > +     int ret;
> > >
> > >       if (flags & ~SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK)
> > >               return -EINVAL;
> > >
> > > +     ret =3D sock_set_tskey(sk, flags, 1);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > >       WRITE_ONCE(sk->sk_tsflags_bpf, flags);
> > >
> > >       return 0;
> >
> > I'm a bit hazy on when this can be called. We can assume that this ne=
w
> > BPF operation cannot race with the existing setsockopt nor with the
> > datapath that might touch the atomic fields, right?
> =

> It surely can race with the existing setsockopt.
> =

> 1)
> if (only existing setsockopt works) {
>         then sk->sk_tskey is set through setsockopt, sk_tskey_bpf_offse=
t is 0.
> }
> =

> 2)
> if (only bpf setsockopt works) {
>         then sk->sk_tskey is set through bpf_setsockopt,
> sk_tskey_bpf_offset is 0.
> }
> =

> 3)
> if (existing setsockopt already started, here we enable the bpf feature=
) {
>         then sk->sk_tskey will not change, but the sk_tskey_bpf_offset
> will be calculated.
> }
> =

> 4)
> if (bpf setsockopt already started, here we enable the application feat=
ure) {
>         then sk->sk_tskey will re-initialized/overridden by
> setsockopt, and the sk_tskey_bpf_offset will be calculated.
> }
> =

> Then the skb tskey will use the sk->sk_tskey like before.

I mean race as in the setsockopt and bpf setsockopt and datapath
running concurrently.

As long as both variants of setsockopt hold the socket lock, that
won't happen.

The datapath is lockless for UDP, so atomic_inc sk_tskey can race
with calculating the difference. But this is a known issue. A process
that cares should not run setsockopt and send concurrently. So this is
fine too.



