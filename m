Return-Path: <bpf+bounces-41314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BED995BC8
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E192873A8
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 23:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95729218599;
	Tue,  8 Oct 2024 23:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgwBfIIR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB313C3CD;
	Tue,  8 Oct 2024 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430678; cv=none; b=JZlkID8thy7Te9yynx9ZFY+yamUYZWIHR87XkLn4Tws6i7gQ+lvYksabRY+v5OOtlSIOIwO6aOGCIWuf5kCkw0AGKmHp71bMaOxvJ0t1nlBdv0n1rPgDltLcwKOOz5T61iBmY2Vy4tRT3CVlP//z8ANW2HpR9vZgyEAJj6SnDg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430678; c=relaxed/simple;
	bh=ujsj3DMawkb/Wltjnad+uYMoFLGr3e0vWCsEiDRyiq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6F9gT9fyzRr8BWdVDQ7zPesF/LIqKGGTN3txdbRv72Jglrmnl5JAwuf5o5N/zRzQNiGqzRsqcivDk8r2Dz2/kA4AK92McAKL59kBykLb+Hir+Peh2pDFxO3IdrHnNsrqzdmee5LKhFoDGvMZ2ha4/buLsZ1xdYA9Bl49QLfBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgwBfIIR; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82fa0ccb0cdso219054939f.3;
        Tue, 08 Oct 2024 16:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728430676; x=1729035476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOGZpsnR8Gju+cDRXQcnsLpWSL2hRVraCtbjXlFumqo=;
        b=OgwBfIIRfCzgYL7KFwvOvRJEg7KQgRYrn+5qsiSAyuGLpc/bmvHLN5LERbjr0HmRWF
         Imj0tNz3p7nBO5izBcyWPr4dLpMHYFGnZ2eC9coOPWYc8Dps3nZnk9BAzdMrFvlSo1xm
         GRiVQNaOw1f0i3e9v7whDeuYh7O6NbD7odD8XqMMoQXYtFMc8lbRR6z57su2jbenrcsT
         tcjsTlhpa/IX3497/Yf1lzAUX9ut0VmFvDtrWWwkKYCP3qOxyyypLQJ49RaduMWEdnTp
         Sz5C9naEQ5pOUD3egM+Ep9vQsJJ9Aen/3H6eg2L80FXqhINexQlcYXlvwYArnWADzMZG
         IM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728430676; x=1729035476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOGZpsnR8Gju+cDRXQcnsLpWSL2hRVraCtbjXlFumqo=;
        b=eV6OkaJTBBVBP1oWhPNKyPmVjaVZSwE5lAS5yy9cU7oTsHf5Rou7hlCNKdG8dZybAY
         waoW7sSATJCSrucoTVVKOwpu/uiVWjXH2qApUXVXnhmN6IeCLJI4xbssxjLhf7AG0SPN
         BgfhrsiJXbhhTwm0cYr6ukbkI5X/LwRj/I2k3R8xmD7KKIQe6tLrNV5a2cE0vIYAjr1B
         lvoIvcPcN0Y+JgWev8m5v8gLuOI3W+0xbxkFFI+yk73Rg4kjLEPHIu+cfj22sDOE3emW
         zMyAiO9Pv/DN7E/w599cxBV+zPNVwWRx8taI39t+P5oafcKtuK6O4cV8FpHQmbNcI+Ol
         E+Xw==
X-Forwarded-Encrypted: i=1; AJvYcCU1q9HCp9nSAalS3bX9iRjWdzYvhlRG3HGCYWQx47/YsS6WRyYk2GOOgy+S9/LnTctwaB8=@vger.kernel.org, AJvYcCXchRZKUOE6RNh+4shm6vYoOP/R9wJWd4NANXZ5I1wIyZu42XV1cA7UIlxTHiWby/KKHw+DmLLP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ATN26/C85F4qKvumCsAUe5bBhWIaNfJdoalIvSN5idH0ueqP
	TdZvTfxZAKGZ+VOMv2Y/737YoGtxFwSPH43s7SmJB19WaKRkXKGNuFeHP8sx5wzEJKaonjp9MjR
	HezrU9OgJtI3HY39izXMg+ah1vmk=
X-Google-Smtp-Source: AGHT+IHZtqUI9H0D9ktq4iWlm7zz1lf1nbUIexTjWwBBup/DK+q/OHY0tZ7tLPnltptDRFnrT87ScKPDA3hUWVhlVQI=
X-Received: by 2002:a05:6e02:168c:b0:3a3:76c3:fcb0 with SMTP id
 e9e14a558f8ab-3a397d1c1ecmr4921525ab.26.1728430675806; Tue, 08 Oct 2024
 16:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-6-kerneljasonxing@gmail.com> <67057fa71f8a9_1a41992946d@willemb.c.googlers.com.notmuch>
In-Reply-To: <67057fa71f8a9_1a41992946d@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 07:37:20 +0800
Message-ID: <CAL+tcoDwdhqqSNcM7i5VcW0yGDd1hQ+3VMM0Nc=6DoQOX1P2xA@mail.gmail.com>
Subject: Re: [PATCH net-next 5/9] net-timestamp: ready to turn on the button
 to generate tx timestamps
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:53=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Once we set BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB_FLAG flag here, there
> > are three points in the previous patches where generating timestamps
> > works. Let us make the basic bpf mechanism for timestamping feature
> >  work finally.
> >
> > We can use like this as a simple example in bpf program:
> > __section("sockops")
> >
> > case BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB:
> >       dport =3D bpf_ntohl(skops->remote_port);
> >       sport =3D skops->local_port;
> >       skops->reply =3D SOF_TIMESTAMPING_TX_SCHED;
> >       bpf_sock_ops_cb_flags_set(skops, BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB=
_FLAG);
> > case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
> >       bpf_printk(...);
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> >  /* List of TCP states. There is a build check in net/ipv4/tcp.c to det=
ect
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 82cc4a5633ce..ddf4089779b5 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -477,12 +477,37 @@ void tcp_init_sock(struct sock *sk)
> >  }
> >  EXPORT_SYMBOL(tcp_init_sock);
> >
> > +static u32 bpf_tcp_tx_timestamp(struct sock *sk)
> > +{
> > +     u32 flags;
> > +
> > +     flags =3D tcp_call_bpf(sk, BPF_SOCK_OPS_TX_TS_OPT_CB, 0, NULL);
> > +     if (flags <=3D 0)
> > +             return 0;
> > +
> > +     if (flags & ~SOF_TIMESTAMPING_MASK)
> > +             return 0;
> > +
> > +     if (!(flags & SOF_TIMESTAMPING_TX_RECORD_MASK))
> > +             return 0;
> > +
> > +     return flags;
> > +}
> > +
> >  static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *so=
ckc)
> >  {
> >       struct sk_buff *skb =3D tcp_write_queue_tail(sk);
> >       u32 tsflags =3D sockc->tsflags;
> > +     u32 flags;
> > +
> > +     if (!skb)
> > +             return;
> > +
> > +     flags =3D bpf_tcp_tx_timestamp(sk);
> > +     if (flags)
> > +             tsflags =3D flags;
>
> So this feature overwrites the flags set by the user?

It only overrides each last skb instead of the whole socket so that
some time if we don't want to use this bpf program any more, we could
easily and directly detach it without having to find a proper time to
clear the fields in struct sock. That's the advantage of setting
through each sendmsg call, compared to bpf_setsockopt method.

> Ideally we would use an entirely separate field for BPF admin
> timestamping requests.

I understand what you mean. I'm not that familiar with how a bpf
extension actually implements, so I dug into how RTO min time can be
affected by bpf programs (see BPF_SOCK_OPS_TIMEOUT_INIT as an
example). It also modifies the existing field.

Thanks,
Jason

