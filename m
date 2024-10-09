Return-Path: <bpf+bounces-41412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D81BD996CED
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088A11C20957
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 13:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5469B199E89;
	Wed,  9 Oct 2024 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDgaowdA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B85238DE5;
	Wed,  9 Oct 2024 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482279; cv=none; b=bgkUKEzmkxOzoQu9rJndtMZw6ciF3BTKlHqp1Zrdz3Ha2U3/HetZsgcSqg7Y8tVRhBM3p/yVEFiscvIMyGArjwj4O2zGoiKKnWwthg/3HsV+sh9oXNvIRCdHRyKRTdDl7d9H00VwX3y7nqqKFfeNNGX5hNSYHeivhPtd/9qafCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482279; c=relaxed/simple;
	bh=X4UBPVCBF59pppgeYeaEuC/R1Gs3Gk8FhNEbxSfClek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWS9o3A9hDjzV40uVb2V5L7LThB6NadvNchDcBF1KrcucmWLYi5UZqpty0yoIs1CzqWfLrok9BthU9dAOHmwh7ucYfhxhJZcYepdobeLFrJI+3HljnlgB/1YVcn0VqtlpUl0Q5ppU3ldDfJdC4neUqMv3rlKCyCiwUJLNK11aQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDgaowdA; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-835393376e1so64857339f.1;
        Wed, 09 Oct 2024 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728482277; x=1729087077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29OQgHkNKFjTrF9fYLuzeX4nKMiHAwoZghal1wz0P3s=;
        b=ZDgaowdAkzDLdeOMdv45YQwW5aeEk2wCQs6+3x9na+cgKrTGjyx1+2/i96+vlT+avy
         e3prTlLQEiXQGeinQrcX46F6DeqI2bR9UMKHpaSwHTKjswCb2aTcKREhrufK48AXQWcg
         zWPPwYF8hACQRCsr5Nvu0vO3W5maVZOHOGFDoROyszhSlIApT4REk0XGZ105heGNVahB
         zV7h5niMeIiKuEcguz1Ydiuud0tJEoWLhayEq46f5Kq5QMMO8PEr1BnFiLGkPSePD/Fw
         ZcBnjiBYTcBPUk7BStVHDIzqSbOfmLnW8Y0nrU5CfbBJsLwZCgQohmUkHirQ3ID1l3jG
         zDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728482277; x=1729087077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29OQgHkNKFjTrF9fYLuzeX4nKMiHAwoZghal1wz0P3s=;
        b=m+6gJfy835jVj4kutojDMBj+iGNqFrWvOp1APXPlIzU2RU6zi4I7RpXTvI2DkTPMKV
         PHvLQ7V/9WMa/1WvKgR+Wpo2w2Hsf34rxJ9UNx252CV9lvIhrcdtQg7M9YlVbKA+04Me
         vQey/NGSOKN3kZUPHLcHJHZVaIfioZrCYGzQMsMHmYcEneAQJ4U+/CR44hrryAx/OA61
         8Ya/BOiBJoBf92PpzUF+Mhpb91nDAcYbfrubd6OWR8WjFTyOSX9pior+M2UFjv6P1zR1
         2hnEqgSC1pF8Xd/5ZE7gGHTuCnRepIrzO4Q6t/yBfMObldXD/a0NT2kVRKZuJr/hC3VP
         WbdA==
X-Forwarded-Encrypted: i=1; AJvYcCUk4zono0isAPiL9wjejT6nBGC1oi8zfbVXSksRjmm7Gu/r6/B38OdBA8Yyq+WQdQWNskHqsv4S@vger.kernel.org, AJvYcCVq2Y9EH81iHVDCLXaPBN7HKK9KVdjaBebIevvi7XEn5qBdf+gMmP7qRyDtChm37z58xhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt66aljOSGcoOodfN/0c6Bak+RXz/bSrh5w08dD1YxYj1r3QJU
	oE7kPRZ+Rg8acdDysFM6DCVsHfyPiyNxQzO38cCS84HW6UyLJo6XHmTTqWGb4wJVih+7FW3pfII
	ecov4OGW+/BD5mEhhEGKEQbPJRsk=
X-Google-Smtp-Source: AGHT+IHa/JDiZwqOtKHb61N4+pRsNVlSL5KfmzgXVH8c4lIuoXjrh4Qh0elVRM8j1XPzvcsjQcwdzdcUZC7Np9iJe6U=
X-Received: by 2002:a05:6e02:144b:b0:3a0:98e9:1b7a with SMTP id
 e9e14a558f8ab-3a397cedc49mr23097585ab.2.1728482277391; Wed, 09 Oct 2024
 06:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-2-kerneljasonxing@gmail.com> <67057db07a8c6_1a4199294b6@willemb.c.googlers.com.notmuch>
 <CAL+tcoALeCguB0+HpTq+MHitHZft3drF5OunPh1Qme8XGifiNw@mail.gmail.com> <6706839620038_1cca31294cf@willemb.c.googlers.com.notmuch>
In-Reply-To: <6706839620038_1cca31294cf@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 21:57:21 +0800
Message-ID: <CAL+tcoAKeAkWMsUjoVW6EZaJg4eKgrfznk9XkvV5PcT9y+Poag@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] net-timestamp: add bpf infrastructure to
 allow exposing more information later
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

On Wed, Oct 9, 2024 at 9:22=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Wed, Oct 9, 2024 at 2:45=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Implement basic codes so that we later can easily add each tx point=
s.
> > > > Introducing BPF_SOCK_OPS_ALL_CB_FLAGS used as a test statement can =
help use
> > > > control whether to output or not.
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  include/uapi/linux/bpf.h       |  5 ++++-
> > > >  net/core/skbuff.c              | 18 ++++++++++++++++++
> > > >  tools/include/uapi/linux/bpf.h |  5 ++++-
> > > >  3 files changed, 26 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > index c6cd7c7aeeee..157e139ed6fc 100644
> > > > --- a/include/uapi/linux/bpf.h
> > > > +++ b/include/uapi/linux/bpf.h
> > > > @@ -6900,8 +6900,11 @@ enum {
> > > >        * options first before the BPF program does.
> > > >        */
> > > >       BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG =3D (1<<6),
> > > > +     /* Call bpf when the kernel is generating tx timestamps.
> > > > +      */
> > > > +     BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG =3D (1<<7),
> > > >  /* Mask of all currently supported cb flags */
> > > > -     BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0x7F,
> > > > +     BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0xFF,
> > > >  };
> > > >
> > > >  /* List of known BPF sock_ops operators.
> > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > index 74149dc4ee31..5ff1a91c1204 100644
> > > > --- a/net/core/skbuff.c
> > > > +++ b/net/core/skbuff.c
> > > > @@ -5539,6 +5539,21 @@ void skb_complete_tx_timestamp(struct sk_buf=
f *skb,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
> > > >
> > > > +static bool bpf_skb_tstamp_tx(struct sock *sk, u32 scm_flag,
> > > > +                           struct skb_shared_hwtstamps *hwtstamps)
> > > > +{
> > > > +     struct tcp_sock *tp;
> > > > +
> > > > +     if (!sk_is_tcp(sk))
> > > > +             return false;
> > > > +
> > > > +     tp =3D tcp_sk(sk);
> > > > +     if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_O=
PT_CB_FLAG))
> > > > +             return true;
> > > > +
> > > > +     return false;
> > > > +}
> > > > +
> > > >  void __skb_tstamp_tx(struct sk_buff *orig_skb,
> > > >                    const struct sk_buff *ack_skb,
> > > >                    struct skb_shared_hwtstamps *hwtstamps,
> > > > @@ -5551,6 +5566,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb=
,
> > > >       if (!sk)
> > > >               return;
> > > >
> > > > +     if (bpf_skb_tstamp_tx(sk, tstype, hwtstamps))
> > > > +             return;
> > > > +
> > >
> > > Eventually, this whole feature could probably be behind a
> > > static_branch.
> >
> > You want to implement another toggle to control it? But for tx path
> > "BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG)"
> > works as a per-netns toggle. I would like to know what you exactly
> > want to do in the next move?
>
> Not another toggle. A static branch that enables the datapath logic
> when a BPF program becomes active. See also for instance ipv4_min_ttl.

Thanks, I see. Then we can totally use the bpf_setsockopt() interface
with a new tsflag field, or something like this, to implement just
like how ip4_min_ttl works.

I will give it a try to see if it can easily work.

Thanks,
Jason

