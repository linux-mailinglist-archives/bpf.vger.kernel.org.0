Return-Path: <bpf+bounces-49740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEEAA1C035
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C24F7A138E
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 01:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935F51EEA27;
	Sat, 25 Jan 2025 01:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWt2Qx0q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F201E98EC;
	Sat, 25 Jan 2025 01:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768372; cv=none; b=IxAA7lD7lxYgDr6IPNoKKpQcNHFrFmih+IhVlf1Oa+UpQ4mdvlWOoKjAzlR2mR1E3jTT8rHTHT4zBbJ6evI0hyokCsglR3g9lidFEK+EUUfTJVJM5DnQ4+mutynyfZR/GuCUWLdXimB6N7NfVZIAnJ16SBcKwhyKp5EtyNNQ1JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768372; c=relaxed/simple;
	bh=kejYI4U9XCDibvICfGpps4q1vYQN128mtoxeXqSI8iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+MPHchVfq/5WNhXILkb7HJpm0lEgWjnYxoq3/28qw3kGFCtITx3NwFqWcH1hHazIMVKLZ5sy4rlGGBlpbSW/jTFwoYKW9tRaQM8rK/Wfhtaf2uZ0lqvoaezj+hPHwGEjRZiikZTzhgc6YF52+O9N1KZlGiOOtEpUflWG1gpoKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWt2Qx0q; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a9c9f2a569so19391405ab.0;
        Fri, 24 Jan 2025 17:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737768369; x=1738373169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=360LvxS3qhSowC7ACi4AdIpZPkk0PMaN8qknksCB1e0=;
        b=IWt2Qx0qDcRgVK3e73wgcP2CEj0G1E0oXsGzx5S1D+3vOqqpcFuQRDXI/qqj+nxMKL
         b2IlVXvx+G1g7ksdJvpI5iU9PkaxUZ7KVzYQUsYdYlr6y9e5JGKasA/kcRlzxj7B1nRU
         TWNSrPZdCjFMOEkLfY2lmbDdZvCE1ZPmKG9Nj5L6NErz0cmXBP4oGT5MyP8G7DOIyFjT
         gcT4Z9ZpPx1KbkE/zJX7wTl0jd0X5iPRYgwPYm7OmAZ+iwDpwE165yzN/9U66WjGFzOU
         09r51JrQ6I4oMlqcorXBZGcIRo5PniFlhoflAY8VClKor6nNy+Imut4zM7AJdD95D6ww
         +mWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737768369; x=1738373169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=360LvxS3qhSowC7ACi4AdIpZPkk0PMaN8qknksCB1e0=;
        b=DfpY2mX1EyeAU33VuRrkpRRbwtjDkLpfTadTqm0/aVKspfUUcmrpQR/1fjrli8sQjn
         7TussW8Ta+UZCf9sCUJy5FB52nX7PQld/9DeikNg7iOV5cFjpQ9jTrvyMh++szOZBW05
         7z/MaiNBKY7NZuFQYoLTG5vu6Mkl+d15qUGMe2G3e4rK1CtBSIYNvN5Wvmc0NWfvc2kh
         jr6t7gPCpUNAaDh5VXr+BTxVTZQcrATAal/w1n3eK+ZNsCFzkaWkzj7tWGajR0jZD2bh
         ouEVEEHs4kgJELd0z12f8Oc56AKkeZNFD5/dBgvRwFxl70wZMeeyGrxN5WmV2NAxuAKN
         wNmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1CvTU7MjttorqsptdRyx6QA+eh0e5tqQIDeqdPaSVOgamYnfZnLvBWYl84/YRVFjr4a1OVMtG@vger.kernel.org, AJvYcCWOVDmjlBdfhr1VQXichOu/pSzxaq4WlCfItuhP9aYxghSsFtzWSQlF5D4SW9p5teppYcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynXkbw8qmv4bLc+yRhj7DTevFX862ht99aLDBRs9azpyWQNRQx
	3P8cmQ5l4gqqeP8wIEsR4ekwrNedbUe3aUopgCrwgrPFDck8Nwaae3wEE33Jt9VKKXYb6sQ0uWE
	KcbipbWSgVp1w0xnZpkFdZTCa9/Q=
X-Gm-Gg: ASbGncvVUIGVEkMCQSPYFaw7yijVJOyAOAgRIN4r/LWcCUEKuF/ehxiiOo8tPox54ES
	k14W9jCU+D0lqEHOJFQNqGQucxwFSeMgW52h6lkpmvSWr75JZgkA3iQEXiNpTjg==
X-Google-Smtp-Source: AGHT+IFGKKuFpKQsFpVI14hYjO/ir3g02T02KUNgTzn5SbI2Hb7kAjLdkJAd73CGAnWjLnhgI2cStMKRUvLvJagWRPg=
X-Received: by 2002:a05:6e02:23c3:b0:3cf:b2ed:7e3b with SMTP id
 e9e14a558f8ab-3cfb2ed7f67mr138631305ab.10.1737768369630; Fri, 24 Jan 2025
 17:26:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-13-kerneljasonxing@gmail.com> <0697db8c-9909-4abb-932d-51413850cdd4@linux.dev>
In-Reply-To: <0697db8c-9909-4abb-932d-51413850cdd4@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Jan 2025 09:25:33 +0800
X-Gm-Features: AWEUYZkwAACjtmrKrbf3R1dStJfgHORLPcHJTw9K4R3tAWfDDzj0XO7prsKSX-4
Message-ID: <CAL+tcoAb4XAsWH1+A4uKuB4uFhj+Q9+=1hyxY1DFKk9_VX13fg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 12/13] net-timestamp: introduce cgroup
 lock to avoid affecting non-bpf cases
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

On Sat, Jan 25, 2025 at 9:09=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/20/25 5:29 PM, Jason Xing wrote:
> > Introducing the lock to avoid affecting the applications which
> > are not using timestamping bpf feature.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   net/core/skbuff.c     | 6 ++++--
> >   net/ipv4/tcp.c        | 3 ++-
> >   net/ipv4/tcp_input.c  | 3 ++-
> >   net/ipv4/tcp_output.c | 3 ++-
> >   4 files changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 33340e0b094f..db5b4b653351 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5605,11 +5605,13 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
> >               return;
> >
> >       /* bpf extension feature entry */
> > -     if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
> > +     if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
>
> I wonder if it is really needed. The caller has just tested the tx_flags.
>
> > +         skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
> >               skb_tstamp_tx_bpf(orig_skb, sk, tstype, sw, hwtstamps);
> >
> >       /* application feature entry */
> > -     if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
> > +     if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
>
> Same here and this one looks wrong also. The userspace may get something
> unexpected in the err queue. The bpf prog may have already detached here =
after
> setting the SKBTX_BPF earlier.

Oh, thanks for spotting this case.

>
> > +         !skb_enable_app_tstamp(orig_skb, tstype, sw))
> >               return;
> >
> >       tsflags =3D READ_ONCE(sk->sk_tsflags);
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 49e489c346ea..d88160af00c4 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -493,7 +493,8 @@ static void tcp_tx_timestamp(struct sock *sk, struc=
t sockcm_cookie *sockc)
> >                       shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len=
 - 1;
> >       }
> >
> > -     if (SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
> > +     if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
>
> This looks ok considering SK_BPF_CB_FLAG_TEST may get to another cachelin=
e.
>
> > +         SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
> >               struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> >               struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index c8945f5be31b..e30607ba41e5 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -3324,7 +3324,8 @@ static void tcp_ack_tstamp(struct sock *sk, struc=
t sk_buff *skb,
> >
> >       /* Avoid cache line misses to get skb_shinfo() and shinfo->tx_fla=
gs */
> >       if (likely(!TCP_SKB_CB(skb)->txstamp_ack &&
> > -                !TCP_SKB_CB(skb)->txstamp_ack_bpf))
> > +                !(cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
>
> Same here. txtstamp_ack has just been tested.... txstamp_ack_bpf is the n=
ext bit.
>
> > +                  TCP_SKB_CB(skb)->txstamp_ack_bpf)))
> >               return;
> >
> >       shinfo =3D skb_shinfo(skb);
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index fc84ca669b76..483f19c2083e 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -1556,7 +1556,8 @@ static void tcp_adjust_pcount(struct sock *sk, co=
nst struct sk_buff *skb, int de
> >   static bool tcp_has_tx_tstamp(const struct sk_buff *skb)
> >   {
> >       return TCP_SKB_CB(skb)->txstamp_ack ||
> > -            TCP_SKB_CB(skb)->txstamp_ack_bpf ||
> > +            (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
>
> Same here.

I thought the cgroup_bpf_enabled which nearly doesn't consume any
resources can protect the timestamping use everywhere. I have no
strong preference. I will remove them as you suggested.

Thanks,
Jason

>
> > +             TCP_SKB_CB(skb)->txstamp_ack_bpf) ||
> >               (skb_shinfo(skb)->tx_flags & SKBTX_ANY_TSTAMP);
> >   }
> >
>

