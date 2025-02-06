Return-Path: <bpf+bounces-50599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4066DA29F3A
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 04:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98433A7011
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 03:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7636E14A4DF;
	Thu,  6 Feb 2025 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNmXkpkZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8EE4C8F;
	Thu,  6 Feb 2025 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738811429; cv=none; b=rKFEmL8cdmGeirPXMftHiBCWUdDaij1of1Z6MR0VdwvMD0S/Uu4fhqyopo2ChuwQQjyJlsTGcvNzt22QkzeFQm+A8eH6Jsg/yXwRouf2B0l5CPYbbnm9FhOrRaw717jEG405dMymsAxOP9z40rYRcS8pxGHJJCE4kBTGYVdUUtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738811429; c=relaxed/simple;
	bh=RASwtiHnYy86SJqCPWE2ZWr5MicvEQwhTVNeDRL6AOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZckbEyKZLKbrr7yBcYdNxTZ2crPBfYyLWoI2fbWjSKeL0RaJOuKpd41yyRcHDxkcOSUmOousXElX9vgdx5mTuwnCgoMjYQyQmpsQUIUo/mSLtIB4g6nn8V7AuH2Z1epFmFcN9Xu5HkCTwMY23Ln4ccVLrv1RL7Utmylgxt6Jt58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNmXkpkZ; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-854a68f5a9cso41694039f.0;
        Wed, 05 Feb 2025 19:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738811426; x=1739416226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DJFiYJho7iFmETthVc5a9FgALKJ4JNHEIjjCv7hBnc=;
        b=cNmXkpkZvy9qSl5YQjat+YUzKvoWtXnuu+E08yx+nKYiGzIOI1BKoSPQFqB35hgBCZ
         FlCGsJGp/06914XdPa3QD4ujfjJRRrzNr1mck1Eqj+YgKdbpJPB7t2MSkMvuevKShM5D
         /aZLekk2uJb2KQVJkHA311USjKvDV9fIac889V6p/hUpeS10nPShM9c+ww+3cUJMIfTF
         bpd/DXU0+xuT0q9FqJh0wPfeMzHb6buXSBeZm95vFeiZUFmBiC7SaWTzluAgzX13nIgb
         30zlls/ib3Bk9Ba8un+XdQRE94/4gXFoKnQTTFy7+wom3rYxlCya5ZYwUiCIDrrCP0rY
         OAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738811426; x=1739416226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DJFiYJho7iFmETthVc5a9FgALKJ4JNHEIjjCv7hBnc=;
        b=j9Pjsx53gjABRc9Q2AQdOQ82pKfIPvIJsnvJ6ddtfdW6JIxuHoUoIc90h3jpNuiZWx
         DRleYVsHB1JsmNRJi5TmY/umtbZrbNjevll0OzDuUMAZD66gEe/VH3zSc+W/XdYKX+Bu
         6wFiCyhkkQR7Egp5LCYYWyi/dttAKFtfT2YKDnlbHQ7LRzTwUCOPIBEYVbaT+okQLvFt
         4j4mFgxXOhJjOO9iT3LOz/fSuxhDVqQH6V+gucVZFQoYLJWrXKk2EyTC6vQgZJcFSV/z
         keGHL4pdsntxyWa5AJsNWh3+CrJvx5TnHfZ420bbB7v6DLr1jLCYPA5lTRxHyDMffx/S
         5EZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmpOMk0lr0cy3KPTvY14zzBPi8p0YjTVrmq2q8Nkr+XiSLVzLeJFwT1yOjpl3eQ0Qg1mcEzMuI@vger.kernel.org, AJvYcCXpje04QrkqfgqFY93C4yeR+svWjj+hakGU+eGfOe9GBM2Bmx2pf/HKRy2j2A+R5v209l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0LXm891sED0hMw5tu4uDPrHv7I+LO3UAF2SIgC9eZbJ8Gfjp
	WZ6vVRi5yzfTrQmmojNyh96PERf6TjYFUZJfLtQ6ENWUUIqLKbyKQ7n0FD1W3sJ2i8F9npVoSZq
	kWr5e5LsK/t4dxLSh3bwHIKbSmdI=
X-Gm-Gg: ASbGncujoJqVUd3eYA9fhsFslniKl3a2MhXvOI4/2qyHEZjLr47nSDAfKlMQGpnO70z
	Q+RnvjKSc5DsIDLf6RaCLdnHgRTUyVEfoHwD3MiFGbWS01bN7xw+T+iSRuZpf7YblwbGyX7g=
X-Google-Smtp-Source: AGHT+IFFtjsAGxHIqK6urzs3ElbttyIT8SQpqvN3M8Td9no71m3W3RiVReG0iTYxlPsLGH5znYh8pyHIGlEfnVWRtKo=
X-Received: by 2002:a92:cda6:0:b0:3d0:101e:45e7 with SMTP id
 e9e14a558f8ab-3d04f900afemr49520965ab.19.1738811426232; Wed, 05 Feb 2025
 19:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-11-kerneljasonxing@gmail.com> <20250204175744.3f92c33e@kernel.org>
 <e894c427-b4b3-4706-b44c-44fc6402c14c@linux.dev> <CAL+tcoCQ165Y4R7UWG=J=8e=EzwFLxSX3MQPOv=kOS3W1Q7R0A@mail.gmail.com>
 <0a8e7b84-bab6-4852-8616-577d9b561f4c@linux.dev> <CAL+tcoAp8v49fwUrN5pNkGHPF-+RzDDSNdy3PhVoJ7+MQGNbXQ@mail.gmail.com>
 <CAL+tcoC5hmm1HQdbDaYiQ1iW1x2J+H42RsjbS_ghyG8mSDgqqQ@mail.gmail.com> <67a424d2aa9ea_19943029427@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a424d2aa9ea_19943029427@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Feb 2025 11:09:49 +0800
X-Gm-Features: AWEUYZlNJds9wqwf1ghxRKkbC2PZQNxTRJUvHCka8hFtkvipGJUfTp7UUGZdmvE
Message-ID: <CAL+tcoCPGAjs=+Hnzr4RLkioUV7nzy=ZmKkTDPA7sBeVP=qzow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 10/12] bpf: make TCP tx timestamp bpf
 extension work
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 10:56=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Thu, Feb 6, 2025 at 9:05=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> > >
> > > On Thu, Feb 6, 2025 at 8:47=E2=80=AFAM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> > > >
> > > > On 2/5/25 4:12 PM, Jason Xing wrote:
> > > > > On Thu, Feb 6, 2025 at 5:57=E2=80=AFAM Martin KaFai Lau <martin.l=
au@linux.dev> wrote:
> > > > >>
> > > > >> On 2/4/25 5:57 PM, Jakub Kicinski wrote:
> > > > >>> On Wed,  5 Feb 2025 02:30:22 +0800 Jason Xing wrote:
> > > > >>>> +    if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> > > > >>>> +        SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) &&=
 skb) {
> > > > >>>> +            struct skb_shared_info *shinfo =3D skb_shinfo(skb=
);
> > > > >>>> +            struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
> > > > >>>> +
> > > > >>>> +            tcb->txstamp_ack_bpf =3D 1;
> > > > >>>> +            shinfo->tx_flags |=3D SKBTX_BPF;
> > > > >>>> +            shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len=
 - 1;
> > > > >>>> +    }
> > > > >>>
> > > > >>> If BPF program is attached we'll timestamp all skbs? Am I readi=
ng this
> > > > >>> right?
> > > > >>
> > > > >> If the attached bpf program explicitly turns on the SK_BPF_CB_TX=
_TIMESTAMPING
> > > > >> bit of a sock, then all skbs of this sock will be tx timestamp-e=
d.
> > > > >
> > > > > Martin, I'm afraid it's not like what you expect. Only the last
> > > > > portion of the sendmsg will enter the above function which means =
if
> > > > > the size of sendmsg is large, only the last skb will be set SKBTX=
_BPF
> > > > > and be timestamped.
> > > >
> > > > Sure. The last skb of a large msg and more skb of small msg (or MSG=
_EOR).
> > > >
> > > > My point is, only attaching a bpf alone is not enough. The
> > > > SK_BPF_CB_TX_TIMESTAMPING still needs to be turned on.
> > >
> > > Right.
> > >
> > > >
> > > > >
> > > > >>
> > > > >>>
> > > > >>> Wouldn't it be better to let BPF_SOCK_OPS_TS_SND_CB return whet=
her it's
> > > > >>> interested in tracing current packet all the way thru the stack=
?
> > > > >>
> > > > >> I like this idea. It can give the BPF prog a chance to do skb sa=
mpling on a
> > > > >> particular socket.
> > > > >>
> > > > >> The return value of BPF_SOCK_OPS_TS_SND_CB (or any cgroup BPF pr=
og return value)
> > > > >> already has another usage, which its return value is currently e=
nforced by the
> > > > >> verifier. It is better not to convolute it further.
> > > > >>
> > > > >> I don't prefer to add more use cases to skops->reply either, whi=
ch is an union
> > > > >> of args[4], such that later progs (in the cgrp prog array) may l=
ose the args value.
> > > > >>
> > > > >> Jason, instead of always setting SKBTX_BPF and txstamp_ack_bpf i=
n the kernel, a
> > > > >> new BPF kfunc can be added so that the BPF prog can call it to s=
electively set
> > > > >> SKBTX_BPF and txstamp_ack_bpf in some skb.
> > > > >
> > > > > Agreed because at netdev 0x19 I have an explicit plan to share th=
e
> > > > > experience from our company about how to trace all the skbs which=
 were
> > > > > completed through a kernel module. It's how we use in production
> > > > > especially for debug or diagnose use.
> > > >
> > > > This is fine. The bpf prog can still do that by calling the kfunc. =
I don't see
> > > > why move the bit setting into kfunc makes the whole set won't work.
> > > >
> > > > > I'm not knowledgeable enough about BPF, so I'd like to know if th=
ere
> > > > > are some functions that I can take as good examples?
> > > > >
> > > > > I think it's a standalone and good feature, can I handle it after=
 this series?
> > > >
> > > > Unfortunately, no. Once the default is on, this cannot be changed.
> > > >
> > > > I think Jakub's suggestion to allow bpf prog selectively choose skb=
 to timestamp
> > > > is useful, so I suggested a way to do it.
> > >
> > > Because, sorry, I don't want to postpone this series any longer (blam=
e
> > > on me for delaying almost 4 months), only wanting to focus on the
> > > extension for SO_TIMESTAMPING so that we can quickly move on with
> > > small changes per series.
> > >
> > > Selectively sampling the skbs or sampling all the skbs could be an
> > > optional good choice/feature for users instead of mandatory?
> > >
> > > There are two kinds of monitoring in production: 1) daily monitoring,
> > > 2) diagnostic monitoring which I'm not sure if I translate in the
> > > right way. For the former that is obviously a light-weight feature, I
> > > think we don't need to trace that many skbs, only the last skb is
> > > enough which was done in Google because even the selective feature[1]
> > > is a little bit heavy. I received some complaints from a few
> > > latency-sensitive customers to ask us if we can reduce the monitoring
> > > in the kernel because as I mentioned before many issues are caused by
> > > the application itself instead of kernel.
> > >
> > > [1] selective feature consists of two parts, only selectively
> > > collecting all the skbs in a certain period or selectively collecting
> > > exactly like what SO_TIMESTAMPING does in a certain period. It might
> > > need a full discussion, I reckon.
> >
> > I presume you might refer to the former. It works like the cmsg
> > feature which can be a good selectively sampling example. It would be
> > better to check the value of reply in the BPF_SOCK_OPS_TS_SND_CB
> > callback which is nearly the very beginning of each sendmsg syscall
> > because I have a hunch we will add more hook points before skb enters
> > the qdisc.
> >
> > I think we can split the whole idea into two parts: for now, because
> > of the current series implementing the same function as SO_TIMETAMPING
> > does, I will implement the selective sample feature in the series.
> > After someday we finish tracing all the skb, then we will add the
> > corresponding selective sample feature.
>
> Are you saying that you will include selective sampling now or want to
> postpone it?

A few months ago, I planned to do it after this series. Since you all
ask, it's not complex to have it included in this series :)

Selective sampling has two kinds of meaning like I mentioned above, so
in the next re-spin I will implement the cmsg feature for bpf
extension in this series. I'm doing the test right now. And leave
another selective sampling small feature until the feature of tracing
all the skbs is implemented if possible.

>
> Jakub brought up a great point. Our continuous deployment would not be
> feasible without sampling. Indeed implemented using cmsg.

Right, right. I just realized that I misunderstood what Jakub offered.

>
> I think it should be included from the initial patch series.

I agree to include this in this series. Like what I wrote in the
previous thread, it should be simple :) And it will be manifested in
the selftests as well.

Thanks,
Jason

