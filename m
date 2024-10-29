Return-Path: <bpf+bounces-43393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF959B4E8B
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 16:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2501C2272C
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 15:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EFC195FE3;
	Tue, 29 Oct 2024 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U33bWqkz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357B0802;
	Tue, 29 Oct 2024 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217091; cv=none; b=pzZR9USRyvqw/pkZ9AVveaWqM5VKUBKWH4Wa+LdcZS2Ozqx6mYU4ab4F5nVCnEjGy/BdgkDr5Ecy59Lm5gV0tQbdkk4par/c651fT1CvRFmPTYG8NGpCV9CEMyI88/rUPCAmP/Ede4PKmApc0cY/ZBIkyxVO/vYzjcrIrFLv7B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217091; c=relaxed/simple;
	bh=4Ef1Je1uizyMOUEPXOAIEtr/cV8nbgakg7WgivBjah4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asM9p91Q6Ime6X31huHeDs6E6u72h+c0Fd3p7QWJYzr2bjR9jgtRHmrxjMVfz9BHs8APx8UIQtMKLXA8eWeBU4jJYlrgKHhdQ0e0UhD3TgTmZ2bSQkeeLoytmRoj2MSlvUm/32Bfraf5k1oPEp7A1fwh67zQYXXHxiYcRetJzys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U33bWqkz; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-83aae6aba1aso189541639f.2;
        Tue, 29 Oct 2024 08:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730217088; x=1730821888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siw+zOXQennOM+dBt0Vhe84s5MTugPfQlRewQPm0dVQ=;
        b=U33bWqkzaip1+Z7tEV8areIZNc5pUw5jpItyFQyxKXkMbO/SaTStj4vrjSF7Xm+v0R
         ZC9QflxAdObHxQFpU5RywCEhDXQMz9iYE1K7Eire0fcXeLv/p/4beRGvsX1Sn5gc7naJ
         MEZWMWA2IfVY+xV3qmqHTNwUOvexbZP4SD5bMvpDFumOMzCkf5gpGTSsUb3xx44uBh/3
         OCrak+IEl4qhZ3yizIkSn28Z0cuFS0Ea+CnA8WSUm0LSVhRGlk+DYympls6X5hNLun88
         1m5If8sR6xCYc3GvfLB2hcJxgPhxvrFFapnVNDnlMYuI29uMgOOUEpwADmGmR+VGx+gF
         7MSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730217088; x=1730821888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siw+zOXQennOM+dBt0Vhe84s5MTugPfQlRewQPm0dVQ=;
        b=BipZ/stM3/M5VBBsKuN84J5p85nhfZn6b3X/AYRJmLW+3Ik3LHlzfABtuWm6RVGf/L
         vBCo7TKFNaUBAaTvEyPk6gVSKSvlgC7gbwwhMbi06S9lobOuGdMQat6jnTlCINvbD2ZD
         FB8UkuYkHjzKlUWbZhMm3pi6YNzHC8MJbCMgj8OgN9YobD8kSahieyhZVxgeOMIpFWti
         90JqvQt7xsa37Uo7IqY5UBv5paESoOwrjPWxIFIHfN0QE8FLT/njD/bT77+lm7pBeKDr
         eQKUIh0miRIcHgF4XUG+2L96UAKWZq2G6T1NWdsXILCcdyfxs2BzJEIYN3GEgQv+Adbr
         +41A==
X-Forwarded-Encrypted: i=1; AJvYcCUbp0nfp28BuXTFs52m79VW5j+8P1EF9NrnpsmIYv4qqT/XCTafg3rmDIcdCyxXCKDIWh8=@vger.kernel.org, AJvYcCVemwsTtYHVYP4nNpv19o+tE+YqyomZhdEjI1S4jL6t40cmAL9aB9g8odYktnvnguVekgmc3sJw@vger.kernel.org
X-Gm-Message-State: AOJu0YxMcHhGcnuaSCsi+lJW/t4c1i7w3o0YYXYNXHE2dWPvN240gszw
	3XC/oEOuv2M03ZUHE+Lv8BGiSHDtyTsSdSFlYtK0u/dNTELZ+gEOO2pvtDEA1ik0HnTdQZ0c/T7
	6UjDaG3xrQxBJRR4eQrfK6gWmLs4=
X-Google-Smtp-Source: AGHT+IExU9QukJp47ivw7BlcSxTD5zJM3yPwcs+RE9A2F0vx4qoHhl2g57MuOpuQQdp+zYOEPtANbZU5IFa5oGX4jVM=
X-Received: by 2002:a05:6e02:1c21:b0:3a3:94c5:e178 with SMTP id
 e9e14a558f8ab-3a4ed3180bemr101168075ab.26.1730217088192; Tue, 29 Oct 2024
 08:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-11-kerneljasonxing@gmail.com> <6720394714070_24dce62944a@willemb.c.googlers.com.notmuch>
 <CAL+tcoBgbA1Q_7UaC0vp-mGHqDHxQ+eMybep0kw=E-T0oJAHfw@mail.gmail.com> <6720f9359d2ef_2bcd7f29458@willemb.c.googlers.com.notmuch>
In-Reply-To: <6720f9359d2ef_2bcd7f29458@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 29 Oct 2024 23:50:52 +0800
Message-ID: <CAL+tcoCDN+YSwXDocv9DcvPGW-sLhEfPHHbzcO2+1PBZFRkB0Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 10/14] net-timestamp: add basic support with
 tskey offset
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 11:03=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Tue, Oct 29, 2024 at 9:24=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Use the offset to record the delta value between current socket key
> > > > and bpf socket key.
> > > >
> > > > 1. If there is only bpf feature running, the socket key is bpf sock=
et
> > > > key and the offset is zero;
> > > > 2. If there is only traditional feature running, and then bpf featu=
re
> > > > is turned on, the socket key is still used by the former while the =
offset
> > > > is the delta between them;
> > > > 3. if there is only bpf feature running, and then application uses =
it,
> > > > the socket key would be re-init for application and the offset is t=
he
> > > > delta.
> > >
> > > We need to also figure out the rare conflict when one user sets
> > > OPT_ID | OPT_ID_TCP while the other only uses OPT_ID.
> >
> > I think the current patch handles the case because:
> > 1. sock_calculate_tskey_offset() gets the final key first whether the
> > OPT_ID_TCP is set or not.
> > 2. we will use that tskey to calculate the delta.
>
> Oh yes of course. Great, then this is resolved.
>
> > > > +static long int sock_calculate_tskey_offset(struct sock *sk, int v=
al, int bpf_type)
> > > > +{
> > > > +     u32 tskey;
> > > > +
> > > > +     if (sk_is_tcp(sk)) {
> > > > +             if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
> > > > +                     return -EINVAL;
> > > > +
> > > > +             if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
> > > > +                     tskey =3D tcp_sk(sk)->write_seq;
> > > > +             else
> > > > +                     tskey =3D tcp_sk(sk)->snd_una;
> > > > +     } else {
> > > > +             tskey =3D 0;
> > > > +     }
> > > > +
> > > > +     if (bpf_type && (sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
> > > > +             sk->sk_tskey_bpf_offset =3D tskey - atomic_read(&sk->=
sk_tskey);
> > > > +             return 0;
> > > > +     } else if (!bpf_type && (sk->sk_tsflags_bpf & SOF_TIMESTAMPIN=
G_OPT_ID)) {
> > > > +             sk->sk_tskey_bpf_offset =3D atomic_read(&sk->sk_tskey=
) - tskey;
> > > > +     } else {
> > > > +             sk->sk_tskey_bpf_offset =3D 0;
> > > > +     }
> > > > +
> > > > +     return tskey;
> > > > +}
> > > > +
> > > >  int sock_set_tskey(struct sock *sk, int val, int bpf_type)
> > > >  {
> > > >       u32 tsflags =3D bpf_type ? sk->sk_tsflags_bpf : sk->sk_tsflag=
s;
> > > > @@ -901,17 +944,13 @@ int sock_set_tskey(struct sock *sk, int val, =
int bpf_type)
> > > >
> > > >       if (val & SOF_TIMESTAMPING_OPT_ID &&
> > > >           !(tsflags & SOF_TIMESTAMPING_OPT_ID)) {
> > > > -             if (sk_is_tcp(sk)) {
> > > > -                     if ((1 << sk->sk_state) &
> > > > -                         (TCPF_CLOSE | TCPF_LISTEN))
> > > > -                             return -EINVAL;
> > > > -                     if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
> > > > -                             atomic_set(&sk->sk_tskey, tcp_sk(sk)-=
>write_seq);
> > > > -                     else
> > > > -                             atomic_set(&sk->sk_tskey, tcp_sk(sk)-=
>snd_una);
> > > > -             } else {
> > > > -                     atomic_set(&sk->sk_tskey, 0);
> > > > -             }
> > > > +             long int ret;
> > > > +
> > > > +             ret =3D sock_calculate_tskey_offset(sk, val, bpf_type=
);
> > > > +             if (ret <=3D 0)
> > > > +                     return ret;
> > > > +
> > > > +             atomic_set(&sk->sk_tskey, ret);
> > > >       }
> > > >
> > > >       return 0;
> > > > @@ -956,10 +995,15 @@ static int sock_set_timestamping_bpf(struct s=
ock *sk,
> > > >                                    struct so_timestamping timestamp=
ing)
> > > >  {
> > > >       u32 flags =3D timestamping.flags;
> > > > +     int ret;
> > > >
> > > >       if (flags & ~SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK)
> > > >               return -EINVAL;
> > > >
> > > > +     ret =3D sock_set_tskey(sk, flags, 1);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > >       WRITE_ONCE(sk->sk_tsflags_bpf, flags);
> > > >
> > > >       return 0;
> > >
> > > I'm a bit hazy on when this can be called. We can assume that this ne=
w
> > > BPF operation cannot race with the existing setsockopt nor with the
> > > datapath that might touch the atomic fields, right?
> >
> > It surely can race with the existing setsockopt.
> >
> > 1)
> > if (only existing setsockopt works) {
> >         then sk->sk_tskey is set through setsockopt, sk_tskey_bpf_offse=
t is 0.
> > }
> >
> > 2)
> > if (only bpf setsockopt works) {
> >         then sk->sk_tskey is set through bpf_setsockopt,
> > sk_tskey_bpf_offset is 0.
> > }
> >
> > 3)
> > if (existing setsockopt already started, here we enable the bpf feature=
) {
> >         then sk->sk_tskey will not change, but the sk_tskey_bpf_offset
> > will be calculated.
> > }
> >
> > 4)
> > if (bpf setsockopt already started, here we enable the application feat=
ure) {
> >         then sk->sk_tskey will re-initialized/overridden by
> > setsockopt, and the sk_tskey_bpf_offset will be calculated.
> > }

I will copy the above to the commit message next time in order to
provide a clear design to future readers.

> >
> > Then the skb tskey will use the sk->sk_tskey like before.
>
> I mean race as in the setsockopt and bpf setsockopt and datapath
> running concurrently.
>
> As long as both variants of setsockopt hold the socket lock, that
> won't happen.
>
> The datapath is lockless for UDP, so atomic_inc sk_tskey can race
> with calculating the difference. But this is a known issue. A process
> that cares should not run setsockopt and send concurrently. So this is
> fine too.

Oh, now I see. Thanks for the detailed explanation! So Do you feel if
we need to take care of this in the future, I mean, after this series
gets merged...?

Thanks,
Jason

