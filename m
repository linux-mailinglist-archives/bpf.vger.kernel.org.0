Return-Path: <bpf+bounces-50595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CABA29F03
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 03:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CE23A6EA0
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 02:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570A3144304;
	Thu,  6 Feb 2025 02:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbg1SJAC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A598DF60;
	Thu,  6 Feb 2025 02:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738810582; cv=none; b=gJixOJQAu0Y6JpJlnvk+7IA2mjU+jpJ9RKNeaPEY59gg3VXeGQljJ4dtVSeY0ytfTztvE4eOiMZ6yy1e7CIWG6l6nhXkFu9uXtNUqNSrwkfmbWokdDvnden8INY7SYB6gjyIC6Vime0k+koi3pOiUULAZh0Ymj1AxBWNhdx+jsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738810582; c=relaxed/simple;
	bh=7gLTk/xrzSaQ2v1muuVbdr8jz7EeCNCLwfu5hsWhDM0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=klgEWt1oDyyuWRNkQqDHzRTsB2n5F1koEB+p+Z4fHL4ZYLGaaPnJocDxL9T+vPGhjbpo1IydVYy50M+aH7gafpzxmGqpTWX126itST0pRRGNb3toSuLVPWXk6bJ5WR2BWvM0hqgxFcubogmluAtf5hLpYIf1cXdMfU4oIk7Ow3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbg1SJAC; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e42ba364f1so4927836d6.2;
        Wed, 05 Feb 2025 18:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738810580; x=1739415380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkoxDuLr3qMD/H5a1S/XTKwSkzU/3R9O+BC12Qlz/8U=;
        b=mbg1SJACppTHGBCp4iIoqb/iYXCYHJTjDiIelQuNEg4xat0q3sbWYWR2dKRgFgAGBs
         oVbvI6fpw/PaS0W7kkQUNU7ISiV/14juxrwSO75r/N6ha8i/UolJ07eyrt1CHk9E7fso
         mDFzFa/X3Ju6Cwhp1aWmqkwtKn4atcqCVURNg5ThZSbZq40NqfYZ8hcrcVnZWvqwoX9M
         YAoe2QuzXH6ybgf+Srhxuy+WgpQnyXwawJ/uaZIZtLYp1DYBHdcnTJ98fWmRA53YA1Dr
         vZp04mmnNI4p/ForJgSM4gEdhcbNC9MWCisI1RIhreuG70p1LN9ZjD/dipo0z2JGJFtO
         GU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738810580; x=1739415380;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BkoxDuLr3qMD/H5a1S/XTKwSkzU/3R9O+BC12Qlz/8U=;
        b=itqQTUKhhvyOjV7gkRS+LAYzR2ERtt3MhipULVaJaYmmAHEVyjofeF9aO80Cl0mxS2
         azXxxkB/HHEqKYPd5tufEJDTfew+OhIY/Jk3dfaQizTyLbHxgFQHPwyNQADBk5aODfVO
         s8B1firWBd2DOi/dn3ldYJlSVwNEcAoSh54v3MPW5uavZLiHBVO0rqMAKoBU/6qidUcP
         0tu6i254f29kZIn5B9Vj9gAi7ICY6/gfgbPwVQ61qn/OowwDu+GDhz406sZaguza6jeC
         9/CEwEbWpKSz1VrGvlKwfxntgQISwpHz1XPp41FQrAcbIblcKFDq6LLGs0BrLYKNjXGf
         lPgA==
X-Forwarded-Encrypted: i=1; AJvYcCUhbpHlREwbMQp7MiRM43kMJbRIajHbKfHwhL+bfEB0gkR5kYiUGURPt58G5HU1nqvH3X8=@vger.kernel.org, AJvYcCVeQ8Lg1RNDiDDf133OLYIpJLU9pOEV20amxz3TAFYaeFxB/IS8YKXywK52m5w1BbwiIjbmIcB3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu0E5fG05j3tDwvh+bXRwxaVA9zbBqUxQxXnJGxdoS2v8c0K6J
	sHN78EBteQWZTlFd9qbmrr/FZYaZwM1po9ulZE6m2DBalplyEgWQ
X-Gm-Gg: ASbGncvpWVTYzpe3jmUqbDYzH7q2v0b3t7DFxTx+QqTJwdUDHN+E3VvHR/60ucvTka5
	ZzHLAWKLl5qDtT0EdP3hHHNX4grWE4pH3RJJ97kLa5vSe7aTKkKUI9Q1iPrRMKgdseH7KaWwWg/
	NekUuiJk3IVSV0kw3fgCRWIj1GDgqPzrqP+94x7sOmlGB25TlMV9xcmGXbCAxjncLz++fI/vLZa
	aX0bEKn5WOFPuETWmcL26yvpoJOfEP0DfTKGz76AAQ7FiFRFYBzS1eE9GLYRpGdHBxE4/DwExMS
	VW4trvJmirigYl7s/8zsRjAZXfP0L7wksWJWNTv8B6w4Pzc/FJElAjoq4mK06Xw=
X-Google-Smtp-Source: AGHT+IFrzvKhslESmSMKSuHoTtBAiXMQ6HTXokSGlzRga/1vPAdPulKyyHamA3qe8J13IfxAyp0aMw==
X-Received: by 2002:a05:6214:1bc5:b0:6e1:700e:487a with SMTP id 6a1803df08f44-6e42fc52a8fmr69100236d6.40.1738810579898;
        Wed, 05 Feb 2025 18:56:19 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43ba2c000sm1720606d6.22.2025.02.05.18.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 18:56:19 -0800 (PST)
Date: Wed, 05 Feb 2025 21:56:18 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 horms@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <67a424d2aa9ea_19943029427@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoC5hmm1HQdbDaYiQ1iW1x2J+H42RsjbS_ghyG8mSDgqqQ@mail.gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-11-kerneljasonxing@gmail.com>
 <20250204175744.3f92c33e@kernel.org>
 <e894c427-b4b3-4706-b44c-44fc6402c14c@linux.dev>
 <CAL+tcoCQ165Y4R7UWG=J=8e=EzwFLxSX3MQPOv=kOS3W1Q7R0A@mail.gmail.com>
 <0a8e7b84-bab6-4852-8616-577d9b561f4c@linux.dev>
 <CAL+tcoAp8v49fwUrN5pNkGHPF-+RzDDSNdy3PhVoJ7+MQGNbXQ@mail.gmail.com>
 <CAL+tcoC5hmm1HQdbDaYiQ1iW1x2J+H42RsjbS_ghyG8mSDgqqQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 10/12] bpf: make TCP tx timestamp bpf
 extension work
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
> On Thu, Feb 6, 2025 at 9:05=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > On Thu, Feb 6, 2025 at 8:47=E2=80=AFAM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> > >
> > > On 2/5/25 4:12 PM, Jason Xing wrote:
> > > > On Thu, Feb 6, 2025 at 5:57=E2=80=AFAM Martin KaFai Lau <martin.l=
au@linux.dev> wrote:
> > > >>
> > > >> On 2/4/25 5:57 PM, Jakub Kicinski wrote:
> > > >>> On Wed,  5 Feb 2025 02:30:22 +0800 Jason Xing wrote:
> > > >>>> +    if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> > > >>>> +        SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) &&=
 skb) {
> > > >>>> +            struct skb_shared_info *shinfo =3D skb_shinfo(skb=
);
> > > >>>> +            struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
> > > >>>> +
> > > >>>> +            tcb->txstamp_ack_bpf =3D 1;
> > > >>>> +            shinfo->tx_flags |=3D SKBTX_BPF;
> > > >>>> +            shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len=
 - 1;
> > > >>>> +    }
> > > >>>
> > > >>> If BPF program is attached we'll timestamp all skbs? Am I readi=
ng this
> > > >>> right?
> > > >>
> > > >> If the attached bpf program explicitly turns on the SK_BPF_CB_TX=
_TIMESTAMPING
> > > >> bit of a sock, then all skbs of this sock will be tx timestamp-e=
d.
> > > >
> > > > Martin, I'm afraid it's not like what you expect. Only the last
> > > > portion of the sendmsg will enter the above function which means =
if
> > > > the size of sendmsg is large, only the last skb will be set SKBTX=
_BPF
> > > > and be timestamped.
> > >
> > > Sure. The last skb of a large msg and more skb of small msg (or MSG=
_EOR).
> > >
> > > My point is, only attaching a bpf alone is not enough. The
> > > SK_BPF_CB_TX_TIMESTAMPING still needs to be turned on.
> >
> > Right.
> >
> > >
> > > >
> > > >>
> > > >>>
> > > >>> Wouldn't it be better to let BPF_SOCK_OPS_TS_SND_CB return whet=
her it's
> > > >>> interested in tracing current packet all the way thru the stack=
?
> > > >>
> > > >> I like this idea. It can give the BPF prog a chance to do skb sa=
mpling on a
> > > >> particular socket.
> > > >>
> > > >> The return value of BPF_SOCK_OPS_TS_SND_CB (or any cgroup BPF pr=
og return value)
> > > >> already has another usage, which its return value is currently e=
nforced by the
> > > >> verifier. It is better not to convolute it further.
> > > >>
> > > >> I don't prefer to add more use cases to skops->reply either, whi=
ch is an union
> > > >> of args[4], such that later progs (in the cgrp prog array) may l=
ose the args value.
> > > >>
> > > >> Jason, instead of always setting SKBTX_BPF and txstamp_ack_bpf i=
n the kernel, a
> > > >> new BPF kfunc can be added so that the BPF prog can call it to s=
electively set
> > > >> SKBTX_BPF and txstamp_ack_bpf in some skb.
> > > >
> > > > Agreed because at netdev 0x19 I have an explicit plan to share th=
e
> > > > experience from our company about how to trace all the skbs which=
 were
> > > > completed through a kernel module. It's how we use in production
> > > > especially for debug or diagnose use.
> > >
> > > This is fine. The bpf prog can still do that by calling the kfunc. =
I don't see
> > > why move the bit setting into kfunc makes the whole set won't work.=

> > >
> > > > I'm not knowledgeable enough about BPF, so I'd like to know if th=
ere
> > > > are some functions that I can take as good examples?
> > > >
> > > > I think it's a standalone and good feature, can I handle it after=
 this series?
> > >
> > > Unfortunately, no. Once the default is on, this cannot be changed.
> > >
> > > I think Jakub's suggestion to allow bpf prog selectively choose skb=
 to timestamp
> > > is useful, so I suggested a way to do it.
> >
> > Because, sorry, I don't want to postpone this series any longer (blam=
e
> > on me for delaying almost 4 months), only wanting to focus on the
> > extension for SO_TIMESTAMPING so that we can quickly move on with
> > small changes per series.
> >
> > Selectively sampling the skbs or sampling all the skbs could be an
> > optional good choice/feature for users instead of mandatory?
> >
> > There are two kinds of monitoring in production: 1) daily monitoring,=

> > 2) diagnostic monitoring which I'm not sure if I translate in the
> > right way. For the former that is obviously a light-weight feature, I=

> > think we don't need to trace that many skbs, only the last skb is
> > enough which was done in Google because even the selective feature[1]=

> > is a little bit heavy. I received some complaints from a few
> > latency-sensitive customers to ask us if we can reduce the monitoring=

> > in the kernel because as I mentioned before many issues are caused by=

> > the application itself instead of kernel.
> >
> > [1] selective feature consists of two parts, only selectively
> > collecting all the skbs in a certain period or selectively collecting=

> > exactly like what SO_TIMESTAMPING does in a certain period. It might
> > need a full discussion, I reckon.
> =

> I presume you might refer to the former. It works like the cmsg
> feature which can be a good selectively sampling example. It would be
> better to check the value of reply in the BPF_SOCK_OPS_TS_SND_CB
> callback which is nearly the very beginning of each sendmsg syscall
> because I have a hunch we will add more hook points before skb enters
> the qdisc.
> =

> I think we can split the whole idea into two parts: for now, because
> of the current series implementing the same function as SO_TIMETAMPING
> does, I will implement the selective sample feature in the series.
> After someday we finish tracing all the skb, then we will add the
> corresponding selective sample feature.

Are you saying that you will include selective sampling now or want to
postpone it?

Jakub brought up a great point. Our continuous deployment would not be
feasible without sampling. Indeed implemented using cmsg.

I think it should be included from the initial patch series.
 =

> But the default mode is the exact same as SO_TIMESTAMPING instead of
> asking bpf prog to enable the sample feature. Does it make sense to
> you?
> =

> With that said, the patch looks like this:
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 1f528e63bc71..73909dad7ed4 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -497,11 +497,14 @@ static void tcp_tx_timestamp(struct sock *sk,
> struct sockcm_cookie *sockc)
>             SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) =
{
>                 struct skb_shared_info *shinfo =3D skb_shinfo(skb);
>                 struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
> +               bool enable_sample =3D true;
> =

> -               tcb->txstamp_ack_bpf =3D 1;
> -               shinfo->tx_flags |=3D SKBTX_BPF;
> -               shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;
> -               bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TS_SND_=
CB);
> +               enable_sample =3D bpf_skops_tx_timestamping(sk, skb,
> BPF_SOCK_OPS_TS_SND_CB);
> +               if (enable_sample) {
> +                       tcb->txstamp_ack_bpf =3D 1;
> +                       shinfo->tx_flags |=3D SKBTX_BPF;
> +                       shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->l=
en - 1;
> +               }
>         }
>  }
> =

> Thanks,
> Jason



