Return-Path: <bpf+bounces-49735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909ACA1C01B
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC80516D000
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 01:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC39E1E98EA;
	Sat, 25 Jan 2025 01:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6H8XSJp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729ECA4E;
	Sat, 25 Jan 2025 01:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737767850; cv=none; b=apuF8Uyax5afq6CCA+RdQC0/LytHg79ilLQhe34JIhxoBQv9OFlQvYQvQquGiSBzRCwSPnD71C7xR2KH6E8uMR+xq72oh4Gl7jJkJjBCLu+gNmQYozx/2eouFEdoTUIaDIxqd4Pr+zzcFdwJfUPK8YGvv5GPFoqmjmseaV7zkOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737767850; c=relaxed/simple;
	bh=igknYpXMSZJw7fY5apR6WcJS9ClN8zd3t4Wmz1AFtac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzRFxCtTJ9E6s3b8jEfSS9n8vTuJsGl8LDxhJOuWwEkEo2ymL+b9jzydH0zL+LQCHHAX1L5VC0wf/l/kvXcITs6B8pI64ONA1JQjiHcUeqTdJFDJCDxXWe8xvharc1usqgtBF7RJC/G6XxBL6wAlD5TNHwvkHM3s48nUzvRM72M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6H8XSJp; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a8160382d4so7359385ab.0;
        Fri, 24 Jan 2025 17:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737767848; x=1738372648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMOjtQFEYyNlXM8uoIQmKoTJULx0b8gS+8z7yNpa9es=;
        b=V6H8XSJpEiq0fA5NOpmUWYP1JG6hnANu8jBUfjvoeEUMPGazoMnmEoX1kIkq0cTHQ+
         l08WDNNT0eDOVNAKZgYCLvGS00LgdE1mPqc03I9HZeHRFyMZVo5QaV9YrmTeQ6ac6lng
         6cjtwlR42IuCZxhihrCn9rYWANcVX5wGwjbg5uQyHLP8GiXnft7STLrVlOceNJkeTIeP
         5TvDmnE46WodK00KbuMAAxXyuCwPehD4osfwD2xkWQj2/WMOJlU8Ksnt04+je8911JtS
         kUKI1MQXFXXL7tuPufmhwqv7amCzEfEdUQzlccJuTCX+O+/g4S7bYDK/f2gaFOH+6O5l
         W0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737767848; x=1738372648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMOjtQFEYyNlXM8uoIQmKoTJULx0b8gS+8z7yNpa9es=;
        b=smSr3pq+voUqbFkbm2WbrM4jzQU/8x+UazTXSq5b2mb/IjPuWC8PgC1vcobM142Tni
         QtG80s5pLGbFAWFg1582qMG8im+2N86+NSUQRDDwvVt7QSC+hK0/RM42aI5SwdKvjsHy
         weYb3MUBpb7JECUpOzZw204XC9t5yGEbWPLQCOrvpnWT9NKjRB5DGP1dXeDe2USMOIwD
         ipB0IzzhGEug2uQZkodmxnb4Pxhl17TQRdURyEZZr+i8+Pp39b9YqxjIN7NIG2rV+tVF
         aRhXpuxdpbT5TU78V8vCdt0XAE2e7Br6UjZ6777WgwgfZ+9Ncvtw7p29DPLuEHtwLqK+
         0khw==
X-Forwarded-Encrypted: i=1; AJvYcCVOJMVsx+/o4Q/BUnyrX90e0ON+J4Q8QdFpkfXnU8W6Hlf9s8xv9Z9r70uWtnJB5T4mlBk=@vger.kernel.org, AJvYcCVOprZFBMQQhTVdn2tfQmjkLI3fNdj9A/URIbWVSmOM9qg4rU7qsOmD1Z8moKbl+C680YhJD103@vger.kernel.org
X-Gm-Message-State: AOJu0YysEETc9Cf+g8cPVtbn147+ToE4grLzcLlZA4oYp5mBnub0hEU4
	cEB2sCuPcoVaHwj/H5BCGPckYIfZ/Fk5xeUzX2jRsFgyVLFwQuPF/qfzBEDMgOU4DvnhEdCgXQr
	isOeq7bo7PQj5/F24RFB1s+AJRF8=
X-Gm-Gg: ASbGncuu4XDbOZSb7woR7GS0wbsnutR2ihUHsajQNpq7c5NWzBSzW36xQ5IjaBDG8Wp
	SJOe+jAqehBtyIanpVUl+iHdzeRFQubZptj9vYeiLjtN02bg0lsm6gVKJakEwEA==
X-Google-Smtp-Source: AGHT+IER2r9TP5iVDwWxiAPFzy4yeuW9/tiqsQHj+ALXpeEVajoMoPuDfpskE6ZUbRziEF3ucAbg5k7TZSKxVIabJXk=
X-Received: by 2002:a05:6e02:16ce:b0:3ce:8d4e:9c79 with SMTP id
 e9e14a558f8ab-3cf743d2bcamr266946095ab.4.1737767847769; Fri, 24 Jan 2025
 17:17:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-7-kerneljasonxing@gmail.com> <50459085-8517-4de2-bd59-d0ae740d36a5@linux.dev>
In-Reply-To: <50459085-8517-4de2-bd59-d0ae740d36a5@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Jan 2025 09:16:51 +0800
X-Gm-Features: AWEUYZl3Yp5MWj4T4O3lUOFOtfX3evfiCwNlKdYerg4j3LbhbLBrypA3cZ5Rm3Y
Message-ID: <CAL+tcoB3BA+qTdjEDPbZRzhXOXL58p5bt9uZVKe_Gr4oGoPfxA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 06/13] net-timestamp: support
 SCM_TSTAMP_SCHED for bpf extension
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

On Sat, Jan 25, 2025 at 8:38=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/20/25 5:28 PM, Jason Xing wrote:
> > Introducing SKBTX_BPF is used as an indicator telling us whether
> > the skb should be traced by the bpf prog.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   include/linux/skbuff.h         |  6 +++++-
> >   include/uapi/linux/bpf.h       |  5 +++++
> >   net/core/dev.c                 |  3 ++-
> >   net/core/skbuff.c              | 23 +++++++++++++++++++++++
> >   tools/include/uapi/linux/bpf.h |  5 +++++
> >   5 files changed, 40 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index dfc419281cc9..35c2e864dd4b 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -490,10 +490,14 @@ enum {
> >
> >       /* generate software time stamp when entering packet scheduling *=
/
> >       SKBTX_SCHED_TSTAMP =3D 1 << 6,
> > +
> > +     /* used for bpf extension when a bpf program is loaded */
> > +     SKBTX_BPF =3D 1 << 7,
> >   };
> >
> >   #define SKBTX_ANY_SW_TSTAMP (SKBTX_SW_TSTAMP    | \
> > -                              SKBTX_SCHED_TSTAMP)
> > +                              SKBTX_SCHED_TSTAMP | \
> > +                              SKBTX_BPF)
> >   #define SKBTX_ANY_TSTAMP    (SKBTX_HW_TSTAMP | \
> >                                SKBTX_HW_TSTAMP_USE_CYCLES | \
> >                                SKBTX_ANY_SW_TSTAMP)
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index e629e09b0b31..72f93c6e45c1 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7022,6 +7022,11 @@ enum {
> >                                        * by the kernel or the
> >                                        * earlier bpf-progs.
> >                                        */
> > +     BPF_SOCK_OPS_TS_SCHED_OPT_CB,   /* Called when skb is passing thr=
ough
> > +                                      * dev layer when SO_TIMESTAMPING
>
> The "SO_TIMESTAMPING" term is not accurate. I guess you meant
> "SK_BPF_CB_TX_TIMESTAMPING"?
>
> Also, may be "Called before skb entering qdisc"?
>
> > +                                      * feature is on. It indicates th=
e
> > +                                      * recorded timestamp.
>
> There is no timestamp recorded also.

Thanks for correcting me. I'll adjust them.

Thanks,
Jason

