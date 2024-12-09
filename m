Return-Path: <bpf+bounces-46402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D569E99D1
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 16:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7683167713
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 15:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D575D224889;
	Mon,  9 Dec 2024 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXEZDTBV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BC5216E2D;
	Mon,  9 Dec 2024 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756260; cv=none; b=SiOXfKNMagb/LcdPWKCyYoXBout9zaZHERaz5PaTsxccn1z/Xtx0jbPqCRjV7zDE7FK6jxIzpWtrJc1FTJsI2wJNI3MQRksVll19hjDqVzy4jVpFPn1wz/8Zwi9Eh0FqNyyudbIyy8Ox/sh4UBaQTF1FUcDT/Vye4qZr96EXW0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756260; c=relaxed/simple;
	bh=/l0mvBOMk2HfZG67f5AV8KL1eBnmxAnmxVSyCDRMMRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFuMeKOcAfuQYeC4pa1jcY7L1cF5k1C3SpUumQ0w3+oxCuC6FJD54+btr2AcK5aD2vTfeAE37+IW5egHre04La8wgAnib8UV1IXPG5o9owxZT0jes+v2dGrGYBaoVOMHKHdxQqfXrTvDV1g2pJlIK3dIk+AAV7sTTnSvb/3dypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXEZDTBV; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8418ecda199so160004239f.2;
        Mon, 09 Dec 2024 06:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733756257; x=1734361057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRZqhFdv7qPXyVhJT3XighvpPtYublPV4yA41Zmvi3g=;
        b=AXEZDTBVupi7whzYl2+LkwZciMYOj0aHWJv2dy9pUyKjp+rH6tdperXaXcL5gP4uoH
         itD3WkzljydA0+KfNkw5gKMOB5d+IO2zPWAxg75+jKu+sx87tTiBZ6D1K5ST7KGkePb/
         Jcp9KGEJ0Ovsu0WWGA9G7OUlvuXeOjbLHO24fZ7FM6PGQYa5Tm4zqQHi7sjTSFAgpjAm
         SuC0c/ck9IKM/PFAHV133iNiLLd4QYL7SRsZ8kv77LX1UP8IDjq5ka6lkw045y9yQDCq
         YV5pnwZ0yCId1GTbovzM0MTk7b4Efw5rtDK6fZ6mQwcWXwKPAkLEARKtt2Lc/h3onuuL
         IeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756257; x=1734361057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRZqhFdv7qPXyVhJT3XighvpPtYublPV4yA41Zmvi3g=;
        b=URvUQbBEnRpi3g20djiC0H7e69apw9lcZuMiMixJixTSjhvc0piS1r5QJM3DYeXe7U
         0Z0xsdtjr3D6fzq4Q4noCU4aBzgauDChHq4W69SddxTbTjZLCoPw8b/IX1U8Y0U5P/me
         tbNKZ4evaDevfnr+9kS4dOq1adZZMOMBNde7s8P53JmHo3DddKDJVzklw9yddTsjBwtL
         y2Jkqoc8613o3AydYJRQ3es8zDD5TanxAh09Mstp4Xyv0E3uCnydqmv9kGFFaEkgPvoa
         belqpOCMUF9UvPKQQifBMwc325wxSGisFVbAeh1ggMVZT41Qc6cwGic2fRCq/VN5l+36
         Bw9A==
X-Forwarded-Encrypted: i=1; AJvYcCWWXL97bzGI4iMTFcwm1e58VtgoPCuKu/sGNnFZpozrYs+nCnyjV8jZGDIjer8fyKbyN2w=@vger.kernel.org, AJvYcCXNlKCY0GYFvYAvpjDvv6j4YPgL3DdzSmZLJeRuH6Wsd8tO++Y8UToNviULKvf9nUeWxfmr9df5@vger.kernel.org
X-Gm-Message-State: AOJu0YwoeXT281x/0IEGlSCYKCkLCrckjKvmYF1lwMXzYQ5MYsGgYqib
	b3FUokNtpfxl7QFDMAOna9DY71e0bkmJYg1ahr4p2g2FYvPIutlKKragUZrh04XebSt4oUCCLrf
	F486n1R6L1XTjOXIG6C4HN7CR1tw=
X-Gm-Gg: ASbGnctAo25QZsnmtPm5RL/cEeTWkQf4B186HczEPgR2VN7vcdnqDmlKV0Q2iHncax8
	T94GffTX6E+NMYVM6sQZpnPENvyt8nw==
X-Google-Smtp-Source: AGHT+IHxn5lYeUJYGcIfdEFo/Erk3mLKUZb5EmxoUguQxL1UMUzvpI6LUNtnhBCV1pjoZbdtSYpVlLYU7ehceSbbAV0=
X-Received: by 2002:a05:6e02:1889:b0:3a7:8720:9deb with SMTP id
 e9e14a558f8ab-3a811db1a67mr109184645ab.11.1733756257592; Mon, 09 Dec 2024
 06:57:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-4-kerneljasonxing@gmail.com> <6757009b87461_31657c294d6@willemb.c.googlers.com.notmuch>
In-Reply-To: <6757009b87461_31657c294d6@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 9 Dec 2024 22:57:01 +0800
Message-ID: <CAL+tcoDnRmORP9UKg7k3grB0zaThY7V964pAfY=NuZu33-WkoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 03/11] net-timestamp: reorganize in skb_tstamp_tx_output()
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

On Mon, Dec 9, 2024 at 10:37=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > It's a prep for bpf print function later. This patch only puts the
> > original generating logic into one function, so that we integrate
> > bpf print easily. No functional changes here.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/linux/skbuff.h |  4 ++--
> >  net/core/dev.c         |  3 +--
> >  net/core/skbuff.c      | 41 +++++++++++++++++++++++++++++++++++------
> >  3 files changed, 38 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 58009fa66102..53c6913560e4 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -39,6 +39,7 @@
> >  #include <net/net_debug.h>
> >  #include <net/dropreason-core.h>
> >  #include <net/netmem.h>
> > +#include <uapi/linux/errqueue.h>
> >
> >  /**
> >   * DOC: skb checksums
> > @@ -4535,8 +4536,7 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
> >  static inline void skb_tx_timestamp(struct sk_buff *skb)
> >  {
> >       skb_clone_tx_timestamp(skb);
> > -     if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> > -             skb_tstamp_tx(skb, NULL);
> > +     __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SND);
> >  }
> >
> >  /**
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 45a8c3dd4a64..5d584950564b 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4350,8 +4350,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct =
net_device *sb_dev)
> >       skb_reset_mac_header(skb);
> >       skb_assert_len(skb);
> >
> > -     if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
> > -             __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHE=
D);
> > +     __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHED);
>
> This adds a function call in the hot path, as __skb_tstamp_tx is
> defined in a .c file.
>
> Currently this is only well predicted branch on a likely cache hot
> variable.

Oh, right, thanks for reminding me. I will figure out a better solution :)

> >
> >       /* Disable soft irqs for various locks below. Also
> >        * stops preemption for RCU.
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 6841e61a6bd0..74b840ffaf94 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5539,10 +5539,10 @@ void skb_complete_tx_timestamp(struct sk_buff *=
skb,
> >  }
> >  EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
> >
> > -void __skb_tstamp_tx(struct sk_buff *orig_skb,
> > -                  const struct sk_buff *ack_skb,
> > -                  struct skb_shared_hwtstamps *hwtstamps,
> > -                  struct sock *sk, int tstype)
> > +static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
> > +                              const struct sk_buff *ack_skb,
> > +                              struct skb_shared_hwtstamps *hwtstamps,
> > +                              struct sock *sk, int tstype)
> >  {
> >       struct sk_buff *skb;
> >       bool tsonly, opt_stats =3D false;
> > @@ -5594,13 +5594,42 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
> >
> >       __skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
> >  }
> > +
> > +static bool skb_tstamp_is_set(const struct sk_buff *skb, int tstype)
> > +{
> > +     switch (tstype) {
> > +     case SCM_TSTAMP_SCHED:
> > +             if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTA=
MP))
> > +                     return true;
> > +             return false;
> > +     case SCM_TSTAMP_SND:
> > +             if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)=
)
> > +                     return true;
>
> Also true for SKBTX_HW_TSTAMP
>
> > +             return false;
> > +     case SCM_TSTAMP_ACK:
> > +             if (TCP_SKB_CB(skb)->txstamp_ack)
> > +                     return true;
> > +             return false;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +void __skb_tstamp_tx(struct sk_buff *orig_skb,
> > +                  const struct sk_buff *ack_skb,
> > +                  struct skb_shared_hwtstamps *hwtstamps,
> > +                  struct sock *sk, int tstype)
> > +{
> > +     if (unlikely(skb_tstamp_is_set(orig_skb, tstype)))
> > +             skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, ts=
type);
> > +}
> >  EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
> >
> >  void skb_tstamp_tx(struct sk_buff *orig_skb,
> >                  struct skb_shared_hwtstamps *hwtstamps)
> >  {
> > -     return __skb_tstamp_tx(orig_skb, NULL, hwtstamps, orig_skb->sk,
> > -                            SCM_TSTAMP_SND);
> > +     return skb_tstamp_tx_output(orig_skb, NULL, hwtstamps, orig_skb->=
sk,
> > +                                 SCM_TSTAMP_SND);
> >  }
> >  EXPORT_SYMBOL_GPL(skb_tstamp_tx);
> >
> > --
> > 2.37.3
> >
>
>

