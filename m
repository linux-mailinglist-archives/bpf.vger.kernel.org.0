Return-Path: <bpf+bounces-51379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3113AA338C0
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 08:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936E8188B919
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 07:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A181C208992;
	Thu, 13 Feb 2025 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLq/4Xa/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9D81FAC42;
	Thu, 13 Feb 2025 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431490; cv=none; b=ONsal10+GNsFj8b5LlPPrEwtSvv6vvhI/fNvnyOOGlfxuRiku3rVml2+5K1C6L7MBN9220BPUWGwV8BPtzG6kIyRrKzpMHD+wFqmzbucUrQJ2VBFSmGA5EqW7Ue9YL5It3gLltqCkaXVstQaeVaPPJQgwMDc7TFJopYbtyQD7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431490; c=relaxed/simple;
	bh=feqe/40/5qW5/2s+ht1S110aoEiVG6iD5g++rhjZt4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmh//XDY1mj2PavLajMfDjZZ6/IWRlAARypQ8JE7k0itk85nxYWauZQF9k2XrJeTujFx+xavztoyt8zfHBPsDL1iAyVDrXw5+bGEAZFZ4xrOQIANqJoy6Ug5XQXBvtmcXuBoHXxMvnQiKLK7Vs3AHN50pKUsS5+pGbddKvKTQvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLq/4Xa/; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso5159815ab.1;
        Wed, 12 Feb 2025 23:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739431488; x=1740036288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrk4Q8yhR0vvAPmKu16H1qX57WGpxjdFvm7xelcHBqo=;
        b=WLq/4Xa/bD9d7ly/Qo696UIeQgWJ7AvdkzitUi3LUqx4ApdD5G8l+bTTRNOmKHPujV
         dzMLUqjF3wpd2HZ4QAgfkJ27bQI7jysFgHVkMZnxGERWl8RjNJPA0a0iZddug0NC98MI
         pXQSG6sk+rusHjfZNwbiysRDLNkNOJoCGJgQXsZGkdly6fq0epONCeE0/s3afgxuKmlV
         k6mL3MccXQPQ/QWFO5pFmZ45B4JxdHIg3qujChed8kRg0GybHH4yVUe1twl7aL0Za2zI
         1Y8IjKHIw1UOCvqznG39pVYQ3x84jjfbvL51chUl+9EOOWk7FG8OTFf2xK7RTjYudUdw
         iVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739431488; x=1740036288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrk4Q8yhR0vvAPmKu16H1qX57WGpxjdFvm7xelcHBqo=;
        b=RZHVuuXgccX2SGe7WdQUnx2nUdFGR61g14BkEpz/epKtQn0YlhmH1GYtd1Lv4+zH2p
         M6qK/JbFPNBMpFDqC/VhKaClsoNjGQKFiixkoItpC9NRgSNv5nmwtyWNSrGspG68JTjJ
         77qJS53b5NJBNGcQLxrf9jIUVdCNiG0GF9y1bXf7tkvqlnC9wj21StuEJcyz+H5QLCtZ
         Dj7x7nQRqeVnxZNJL5i2IM9k+xwr215alWnt3qGgX14iNCway3Cj78Gd+Bivw3hmyvE0
         ryJeEsnhH7uszePRLFHOndyl28tqWhIej6NtJNCv5cedW8iuCdv3nSTK0CWnrNRs1qhL
         Px5g==
X-Forwarded-Encrypted: i=1; AJvYcCUSDxJyb2rQyhC+JmMOJnObOpbmBmfm3JQnCaNj3wBRATJC+ZASgewR6GMG9wbqyQb//VM=@vger.kernel.org, AJvYcCVsyguqr0IZu1YbxEBWf3I7d9r4nQQrWsoo6nkJfsiGJTDL3cc6mD8AtlccocHC938Adz21xHAV@vger.kernel.org
X-Gm-Message-State: AOJu0YynDl8hVXaUx9fm3DTgjlnP5m23syEvnxqq8Bng/fK8De0/c+pO
	v+PeZLNKKsHIq5+5IOF+q+WmNdFiFtbDIZV67ub01ubYahfYRJEqLYZpWr4I7hBqhz7e4pXODku
	QvtCNZQvAWV+WpAM/cDRnNgoliGI=
X-Gm-Gg: ASbGncvMqiZQXKDMXJDDkp9iZAVGI/5ZCeCjnWycxgaWVK9W7kOEgJ1qlzKS8zQ+ZyG
	KpF6KcDYkf813hEEQQCpTNEwPbJf1FwsLsLqZbr7sgJTEjsMGPv33ENZw9dPj/exoYbzK6zqa
X-Google-Smtp-Source: AGHT+IFQQ5x4Wrw6FSIDEX8E3cYoqqrz0c5N2WaYNNxQdXt5EOSI8VKT3V8y/s84TDDeTYhi8Hz0HVi+k5UlWmmo6kw=
X-Received: by 2002:a05:6e02:1489:b0:3d0:1bc4:77a0 with SMTP id
 e9e14a558f8ab-3d17bc9a709mr55986925ab.0.1739431487696; Wed, 12 Feb 2025
 23:24:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212061855.71154-1-kerneljasonxing@gmail.com>
 <20250212061855.71154-8-kerneljasonxing@gmail.com> <b1b7106d-2c36-4663-bf46-807337f792bf@linux.dev>
In-Reply-To: <b1b7106d-2c36-4663-bf46-807337f792bf@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Feb 2025 15:24:11 +0800
X-Gm-Features: AWEUYZkngLJLl7pIFxbxCs9YwhjM-RGHNCbWoKgmQzsEWcnUl66jkYeWu8L5gtY
Message-ID: <CAL+tcoCWA9BSUb8qHacWD923kOysxXKmDbtDrAT_zvQ5kQB9nA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 07/12] bpf: add BPF_SOCK_OPS_TS_SW_OPT_CB callback
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 7:19=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/11/25 10:18 PM, Jason Xing wrote:
> > Support sw SCM_TSTAMP_SND case for bpf timestamping.
> >
> > Add a new sock_ops callback, BPF_SOCK_OPS_TS_SW_OPT_CB. This
> > callback will occur at the same timestamping point as the user
> > space's software SCM_TSTAMP_SND. The BPF program can use it to
> > get the same SCM_TSTAMP_SND timestamp without modifying the
> > user-space application.
> >
> > Based on this patch, BPF program will get the software
> > timestamp when the driver is ready to send the skb. In the
> > sebsequent patch, the hardware timestamp will be supported.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   include/linux/skbuff.h         | 2 +-
> >   include/uapi/linux/bpf.h       | 4 ++++
> >   net/core/skbuff.c              | 9 ++++++++-
> >   tools/include/uapi/linux/bpf.h | 4 ++++
> >   4 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 52f6e033e704..76582500c5ea 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -4568,7 +4568,7 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
> >   static inline void skb_tx_timestamp(struct sk_buff *skb)
> >   {
> >       skb_clone_tx_timestamp(skb);
> > -     if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> > +     if (skb_shinfo(skb)->tx_flags & (SKBTX_SW_TSTAMP | SKBTX_BPF))
> >               skb_tstamp_tx(skb, NULL);
> >   }
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 68664ececdc0..b3bd92281084 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7039,6 +7039,10 @@ enum {
> >                                        * dev layer when SK_BPF_CB_TX_TI=
MESTAMPING
> >                                        * feature is on.
> >                                        */
> > +     BPF_SOCK_OPS_TS_SW_OPT_CB,      /* Called when skb is about to se=
nd
> > +                                      * to the nic when SK_BPF_CB_TX_T=
IMESTAMPING
> > +                                      * feature is on.
> > +                                      */
> >   };
> >
> >   /* List of TCP states. There is a build check in net/ipv4/tcp.c to de=
tect
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 7bac5e950e3d..d80d2137692f 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5557,6 +5557,7 @@ static bool skb_tstamp_tx_report_so_timestamping(=
struct sk_buff *skb,
> >   }
> >
> >   static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb=
,
> > +                                               struct skb_shared_hwtst=
amps *hwts,
>
> s/hwts/hwtstamps/
> Use the same argument name as all other functions in this file. Its calle=
r is
> using hwtstamps as the argument name also. Easier to follow.
>
> Probably the same for the skb_tstamp_tx_report_so_timestamping().

Got it. Next version will include this modification.

Thanks,
Jason

>
> >                                                 struct sock *sk,
> >                                                 int tstype)
> >   {
> > @@ -5566,6 +5567,11 @@ static void skb_tstamp_tx_report_bpf_timestampin=
g(struct sk_buff *skb,
> >       case SCM_TSTAMP_SCHED:
> >               op =3D BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> >               break;
> > +     case SCM_TSTAMP_SND:
> > +             if (hwts)
> > +                     return;
> > +             op =3D BPF_SOCK_OPS_TS_SW_OPT_CB;
> > +             break;
> >       default:
> >               return;
> >       }
> > @@ -5586,7 +5592,8 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
> >               return;
> >
> >       if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
> > -             skb_tstamp_tx_report_bpf_timestamping(orig_skb, sk, tstyp=
e);
> > +             skb_tstamp_tx_report_bpf_timestamping(orig_skb, hwtstamps=
,
> > +                                                   sk, tstype);
> >
> >       if (!skb_tstamp_tx_report_so_timestamping(orig_skb, hwtstamps, ts=
type))
> >               return;
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/=
bpf.h
> > index eed91b7296b7..9bd1c7c77b17 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -7029,6 +7029,10 @@ enum {
> >                                        * dev layer when SK_BPF_CB_TX_TI=
MESTAMPING
> >                                        * feature is on.
> >                                        */
> > +     BPF_SOCK_OPS_TS_SW_OPT_CB,      /* Called when skb is about to se=
nd
> > +                                      * to the nic when SK_BPF_CB_TX_T=
IMESTAMPING
> > +                                      * feature is on.
> > +                                      */
> >   };
> >
> >   /* List of TCP states. There is a build check in net/ipv4/tcp.c to de=
tect
>

