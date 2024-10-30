Return-Path: <bpf+bounces-43490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B21399B5A56
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 04:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D127E1C22304
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 03:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BD71991AE;
	Wed, 30 Oct 2024 03:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZe6sVGj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF20315E96;
	Wed, 30 Oct 2024 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730258916; cv=none; b=XDUgu7Z+xsCD61RqqAogu8jTZ2yW+dXpzc5EUvuoujmgvuRUVwBjTSvSy1xpZhaY6QiL//FV5Oqt684pIkGsxssXrhbVlvx1bK/H1wvmDU2yK4Cx+AMfk2hVvoRxSkdgkQueFVBMUMvbuCME8/SXh9EVMnf6PI5PXIEgkZShMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730258916; c=relaxed/simple;
	bh=cXJbaxeXWonrYgxgh+fgAZzdTbkoxoeVYW42plVwIEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flGDWhJBEzhRZMRFC3xG5u0W3CMyQ8lKJtJtVl1KGoORjLvEEigFAZtU3aKCeg4MLcP92pTvRsRoAuKIixQQCnQZZ1mEK23eZB1IuclEQB8GApEnsYdbrEGkutF8FInW4BYBuZIOfycflJQgRWJWRueeAA3ktoLdK9eAr/sTvAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZe6sVGj; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3b4663e40so22668515ab.2;
        Tue, 29 Oct 2024 20:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730258913; x=1730863713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4/B7jYJxsmXi0zwcYVhFehp+FhAEaVOMktEuU/AI3M=;
        b=kZe6sVGjJ5vX66PKpUpomR0NruFw7TN883ZYSrWFEAm6uRewDJ5emmGa7wJi6SC5BV
         y9vKYwR0tcufMwXiV88I2X4m4rbg6I7eUA0qk5PPIwKbuVLtbK8g5Co/tbzPICoU8dJE
         uTP6+mTeq1mwJqSZOz9VuysjozQbqKet7OzIhuPqvx6+j5xdmsAe0j2kTpWzzf0hvFO3
         IHVR4iCgisDb1b+GzNOoVcdKQrJmb2AqxvbvuKiEKVi8T4kTL8/CDTpb1uyvGBEqMqon
         Zk/c33YLCaCcCddW/u/ugZFxv7Py2dWW6cybveIZppP7W8SWF3NHcrJL9TbHfO2YRJJB
         kAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730258913; x=1730863713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4/B7jYJxsmXi0zwcYVhFehp+FhAEaVOMktEuU/AI3M=;
        b=Panp6Dl2LTykkiUX0V5K/XPfa57N8wzpFQauLH1AMb2kZGQnwWJHhkVcudGg0BXz/A
         Vtyr+mgaUd43nnCRuVGchhVjYCMBVj7SnNno9Ja8+Fy54tftBvDb3YOxaeDcmyj4NLbt
         DaVvy09RbbU7x4Fcw3ATO6SayCLgaP+fUfHGbF6tkq7b/vUoEc8nSh1ceJb3PIs2Pp8D
         TmjztWF4ULXqR6jqjKEM0tkzk0qwACO8pJ23/Yo39UdZYY49qK/u7d+wXDOQ0ecTb9Xy
         6CFHQCHRfpf4bTXvLaRuFd82emPgl7RG9vn9G8hB3asxer8Feo3lnMfcrz4CkCgpsuFf
         IBLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6wIbCIZtPln+ro9bm0o4NRPlWj+cXEqLHy8eGjUeii+H6OdmOnitXhzIKeM0fPXt2hYGkZySx@vger.kernel.org, AJvYcCWR9hJgLn1Wv222A+Ty5n+JFnNKxYCfYW1qYx2ghQN6mvg6e43tfapAuX1k7J2YiqgTFOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYrUoJlw8HLAinl3pAgXsHk3xHmqwgCbgQQ0lr1+sCTbrq6L4K
	Cuuwe0MR7bT54sNyjHdFb8eeOfovK7W1WgmpKwM61n7g1kkazAIuVWdJe776VvTmbftfrRTL85L
	I/fDVGY/rdoNzUnSrQK7VPuxnM+A=
X-Google-Smtp-Source: AGHT+IE9sJRBrHeOTryT6wi93gvj6ZEmCNsXW2HCxRToVtZqzozCKGSSna1yy6oJHQ62nwz5mrFTjl33ddfSg3D2Nb0=
X-Received: by 2002:a05:6e02:188a:b0:3a1:a20f:c09c with SMTP id
 e9e14a558f8ab-3a4ed34b940mr158792475ab.22.1730258912920; Tue, 29 Oct 2024
 20:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-11-kerneljasonxing@gmail.com> <6720394714070_24dce62944a@willemb.c.googlers.com.notmuch>
 <CAL+tcoBgbA1Q_7UaC0vp-mGHqDHxQ+eMybep0kw=E-T0oJAHfw@mail.gmail.com>
 <6720f9359d2ef_2bcd7f29458@willemb.c.googlers.com.notmuch>
 <CAL+tcoCDN+YSwXDocv9DcvPGW-sLhEfPHHbzcO2+1PBZFRkB0Q@mail.gmail.com> <67213b62f4100_2f188c294b7@willemb.c.googlers.com.notmuch>
In-Reply-To: <67213b62f4100_2f188c294b7@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 30 Oct 2024 11:27:56 +0800
Message-ID: <CAL+tcoAqvQPw6PXYa-4hz6B=krgOYxw8jdFNCzQRcZnOVT_i+w@mail.gmail.com>
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

On Wed, Oct 30, 2024 at 3:45=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> > > > > > +static long int sock_calculate_tskey_offset(struct sock *sk, i=
nt val, int bpf_type)
> > > > > > +{
> > > > > > +     u32 tskey;
> > > > > > +
> > > > > > +     if (sk_is_tcp(sk)) {
> > > > > > +             if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LIST=
EN))
> > > > > > +                     return -EINVAL;
> > > > > > +
> > > > > > +             if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
> > > > > > +                     tskey =3D tcp_sk(sk)->write_seq;
> > > > > > +             else
> > > > > > +                     tskey =3D tcp_sk(sk)->snd_una;
> > > > > > +     } else {
> > > > > > +             tskey =3D 0;
> > > > > > +     }
> > > > > > +
> > > > > > +     if (bpf_type && (sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID=
)) {
> > > > > > +             sk->sk_tskey_bpf_offset =3D tskey - atomic_read(&=
sk->sk_tskey);
> > > > > > +             return 0;
> > > > > > +     } else if (!bpf_type && (sk->sk_tsflags_bpf & SOF_TIMESTA=
MPING_OPT_ID)) {
> > > > > > +             sk->sk_tskey_bpf_offset =3D atomic_read(&sk->sk_t=
skey) - tskey;
> > > > > > +     } else {
> > > > > > +             sk->sk_tskey_bpf_offset =3D 0;
> > > > > > +     }
> > > > > > +
> > > > > > +     return tskey;
> > > > > > +}
> > > > > > +
> > > > > >  int sock_set_tskey(struct sock *sk, int val, int bpf_type)
> > > > > >  {
> > > > > >       u32 tsflags =3D bpf_type ? sk->sk_tsflags_bpf : sk->sk_ts=
flags;
> > > > > > @@ -901,17 +944,13 @@ int sock_set_tskey(struct sock *sk, int v=
al, int bpf_type)
> > > > > >
> > > > > >       if (val & SOF_TIMESTAMPING_OPT_ID &&
> > > > > >           !(tsflags & SOF_TIMESTAMPING_OPT_ID)) {
> > > > > > -             if (sk_is_tcp(sk)) {
> > > > > > -                     if ((1 << sk->sk_state) &
> > > > > > -                         (TCPF_CLOSE | TCPF_LISTEN))
> > > > > > -                             return -EINVAL;
> > > > > > -                     if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
> > > > > > -                             atomic_set(&sk->sk_tskey, tcp_sk(=
sk)->write_seq);
> > > > > > -                     else
> > > > > > -                             atomic_set(&sk->sk_tskey, tcp_sk(=
sk)->snd_una);
> > > > > > -             } else {
> > > > > > -                     atomic_set(&sk->sk_tskey, 0);
> > > > > > -             }
> > > > > > +             long int ret;
> > > > > > +
> > > > > > +             ret =3D sock_calculate_tskey_offset(sk, val, bpf_=
type);
> > > > > > +             if (ret <=3D 0)
> > > > > > +                     return ret;
> > > > > > +
> > > > > > +             atomic_set(&sk->sk_tskey, ret);
> > > > > >       }
> > > > > >
> > > > > >       return 0;
> > > > > > @@ -956,10 +995,15 @@ static int sock_set_timestamping_bpf(stru=
ct sock *sk,
> > > > > >                                    struct so_timestamping times=
tamping)
> > > > > >  {
> > > > > >       u32 flags =3D timestamping.flags;
> > > > > > +     int ret;
> > > > > >
> > > > > >       if (flags & ~SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK)
> > > > > >               return -EINVAL;
> > > > > >
> > > > > > +     ret =3D sock_set_tskey(sk, flags, 1);
> > > > > > +     if (ret)
> > > > > > +             return ret;
> > > > > > +
> > > > > >       WRITE_ONCE(sk->sk_tsflags_bpf, flags);
> > > > > >
> > > > > >       return 0;
> > > > >
> > > > > I'm a bit hazy on when this can be called. We can assume that thi=
s new
> > > > > BPF operation cannot race with the existing setsockopt nor with t=
he
> > > > > datapath that might touch the atomic fields, right?
> > > >
> > > > It surely can race with the existing setsockopt.
> > > >
> > > > 1)
> > > > if (only existing setsockopt works) {
> > > >         then sk->sk_tskey is set through setsockopt, sk_tskey_bpf_o=
ffset is 0.
> > > > }
> > > >
> > > > 2)
> > > > if (only bpf setsockopt works) {
> > > >         then sk->sk_tskey is set through bpf_setsockopt,
> > > > sk_tskey_bpf_offset is 0.
> > > > }
> > > >
> > > > 3)
> > > > if (existing setsockopt already started, here we enable the bpf fea=
ture) {
> > > >         then sk->sk_tskey will not change, but the sk_tskey_bpf_off=
set
> > > > will be calculated.
> > > > }
> > > >
> > > > 4)
> > > > if (bpf setsockopt already started, here we enable the application =
feature) {
> > > >         then sk->sk_tskey will re-initialized/overridden by
> > > > setsockopt, and the sk_tskey_bpf_offset will be calculated.
> > > > }
> >
> > I will copy the above to the commit message next time in order to
> > provide a clear design to future readers.
> >
> > > >
> > > > Then the skb tskey will use the sk->sk_tskey like before.
> > >
> > > I mean race as in the setsockopt and bpf setsockopt and datapath
> > > running concurrently.
> > >
> > > As long as both variants of setsockopt hold the socket lock, that
> > > won't happen.
> > >
> > > The datapath is lockless for UDP, so atomic_inc sk_tskey can race
> > > with calculating the difference. But this is a known issue. A process
> > > that cares should not run setsockopt and send concurrently. So this i=
s
> > > fine too.
> >
> > Oh, now I see. Thanks for the detailed explanation! So Do you feel if
> > we need to take care of this in the future, I mean, after this series
> > gets merged...?
>
> If there is a race condition, then that cannot be fixed up later.
>
> But from my admittedly brief analysis, it seems that there is nothing
> here that needs to be fixed: control plane operations (setsockopt)
> hold the socket lock. A setsockopt that conflicts with a lockless
> datapath update will have a slightly ambiguous offset. It is under
> controlof and up to the user to avoid that if they care.

I got it. Thanks.

