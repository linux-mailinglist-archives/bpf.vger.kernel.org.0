Return-Path: <bpf+bounces-41952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96F299DC86
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 05:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6859A282A76
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 03:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B7016E86F;
	Tue, 15 Oct 2024 03:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIAAGJI9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2FE20EB;
	Tue, 15 Oct 2024 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728961380; cv=none; b=lRXKKYRSLBBkm5wRAdbBZpjXOzNMDpmjVbWbnQ4ZF+ILmFfPlEDSnBhmd0p3UznVXYInyRxdMaDBoIoP+pFs16wO56WObz1oKbMVkjv5ZLo+Z5ThcctoO5bMDsueo9ihwKyjwHuPo2zlSxTTTi7780/C+ass9z+FTBBHDnInbr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728961380; c=relaxed/simple;
	bh=0X2cfRdeK/ryDcAiBkQTDP3ngJXQNSwzhR2QZ0hAcMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PlXmOw7zVUKTMMj3Bo3J/QynDkehAVJ1GbUsaq0MeeHy4XFOGMZvIs+tQ7X/2Nca5PPARs9saEkf6MiFlI+Nt4yKp+5iJrmWR1F+TUv6CeKG1EPy6JclgAmEIE23712qL+NPQOE1ky3pR6WC4yPvwf9sQXBS5Zr2a6JaAwyt3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIAAGJI9; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-83795fbfe4cso131414139f.2;
        Mon, 14 Oct 2024 20:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728961377; x=1729566177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6UU5ooZFAdRUkTAnuPd5XbFtIHBzKaMWkWSQZvnE/E=;
        b=ZIAAGJI9mdR8VGOKcU/aIjZuLKvscAHHlcXVjUJWUd3mtmn2LqX2ELo77r2UarqvSL
         zJ2jVfn+vbwSQHC7RVDowlh2EfqnrmTcz89/Sr7OmDdqzw+vGMAFDwOfOc6K2JGCMNk8
         BMODuOCG+4lcy6pfN4ugNlMO6eh04zWnlwVKl27Z/rMg4Yb7+F6IDuiNfl8qJlwikNLl
         oN5Kk/0LTw6PD917qp0cCGdC9v8Gsnuvk8oIfw1oyLs1erFx6exDeL+Je28iujgeUS+V
         GpNlmTG2iY1x4CxJjZrkChSKpCWwUA6VBAA33c8RXw1LE2p31sWGMdrUg4Xm6Knr1ddP
         sb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728961377; x=1729566177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6UU5ooZFAdRUkTAnuPd5XbFtIHBzKaMWkWSQZvnE/E=;
        b=b5RcJbjuR19Bl9qeppAroV2IHnAfzh3g0ZVLKf4Oi5yNgbUmiFUtMMIA94/bPAtlJT
         shCiKsaxeFVtVEuvPPheCUoKibOc1QJk+GiK9piz9qiKvzquB0uIHO/qUpHjptu0aKKm
         AlSdydCvVQ/jLGUl26Clbsmhertkz2QsUkykMZH/TcfVe4Qiu94Ya9SurDRAtdmGpbTk
         1cXV1K1D4WreK2WJaLcEFvCCJKD94rxAAoRDatw1gFFMw3j3OFM9s4urhkKJrDh+WGKS
         BAY0nCCE5PoF+jtoKSPUL3WvkQAUKyGgHxXrAug9zmPqKroxz4oY9ooVnoqD0YK/mV1M
         Hciw==
X-Forwarded-Encrypted: i=1; AJvYcCUSbUfzeXvruLeIY6s/G6ms8RdiXhkd/NnVWEQcQjIvSgmhADmZdC+sc19/XLCcdqQwC6U=@vger.kernel.org, AJvYcCV71QJapE5FUReewhhLIm7+u4aeV3xJny3Qq17cA+uRnNKmvZmpzqEB2NVBJmMbnVBFS+zjF3X9@vger.kernel.org
X-Gm-Message-State: AOJu0YzsAZPDZP5TIkNXXInK7WCmOuZ/PpndXikA5KNnveaxpD5ySO7I
	4RsM6r6fYpA8gcC1zbfzP0doZtNhIr44QdoytQ5ui48bM/qILGRyz+21vTyBz/MIuqQ3IfjZ3KZ
	tnB9KGt3+q0vB6BeA68dt6uTGwh8=
X-Google-Smtp-Source: AGHT+IGtoZastAPk4ELZ2j9CFlEuecBjRwEzLTDpMVEii0Xv1pBvxgtk/YWB1JbY84N0Tm0qk944D1eH1p8AsusxBEw=
X-Received: by 2002:a05:6e02:1446:b0:3a3:67b1:3080 with SMTP id
 e9e14a558f8ab-3a3bcdbb5acmr85098445ab.7.1728961377546; Mon, 14 Oct 2024
 20:02:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <670ab67920184_2737bf29465@willemb.c.googlers.com.notmuch>
 <CAL+tcoAv+QPUcNs6nV=TNjSZ69+GfaRgRROJ-LMEtpOC562-jA@mail.gmail.com>
 <670dc531710c_2e1742294b4@willemb.c.googlers.com.notmuch> <CAL+tcoA-pMZniF2wmYJBR+PKCWThT+i+h5K-cRs3P5yqe3x-PQ@mail.gmail.com>
 <670dda9437147_2e6c4029461@willemb.c.googlers.com.notmuch>
In-Reply-To: <670dda9437147_2e6c4029461@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 15 Oct 2024 11:02:21 +0800
Message-ID: <CAL+tcoCvqkY4=XPLkwKguhPCH0Dduc4Xk4GO2ymySo9Nv2sh3A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/12] net-timestamp: bpf extension to equip
 applications transparently
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

On Tue, Oct 15, 2024 at 10:59=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Tue, Oct 15, 2024 at 9:28=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > On Sun, Oct 13, 2024 at 1:48=E2=80=AFAM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > A few weeks ago, I planned to extend SO_TIMESTMAMPING feature b=
y using
> > > > > > tracepoint to print information (say, tstamp) so that we can
> > > > > > transparently equip applications with this feature and require =
no
> > > > > > modification in user side.
> > > > > >
> > > > > > Later, we discussed at netconf and agreed that we can use bpf f=
or better
> > > > > > extension, which is mainly suggested by John Fastabend and Will=
em de
> > > > > > Bruijn. Many thanks here! So I post this series to see if we ha=
ve a
> > > > > > better solution to extend. My feeling is BPF is a good place to=
 provide
> > > > > > a way to add timestamping by administrators, without having to =
rebuild
> > > > > > applications.
> > > > > >
> > > > > > This approach mostly relies on existing SO_TIMESTAMPING feature=
, users
> > > > > > only needs to pass certain flags through bpf_setsocktop() to a =
separate
> > > > > > tsflags. For TX timestamps, they will be printed during generat=
ion
> > > > > > phase. For RX timestamps, we will wait for the moment when recv=
msg() is
> > > > > > called.
> > > > > >
> > > > > > After this series, we could step by step implement more advance=
d
> > > > > > functions/flags already in SO_TIMESTAMPING feature for bpf exte=
nsion.
> > > > > >
> > > > > > In this series, I only support TCP protocol which is widely use=
d in
> > > > > > SO_TIMESTAMPING feature.
> > > > > >
> > > > > > ---
> > > > > > V2
> > > > > > Link: https://lore.kernel.org/all/20241008095109.99918-1-kernel=
jasonxing@gmail.com/
> > > > > > 1. Introduce tsflag requestors so that we are able to extend mo=
re in the
> > > > > > future. Besides, it enables TX flags for bpf extension feature =
separately
> > > > > > without breaking users. It is suggested by Vadim Fedorenko.
> > > > > > 2. introduce a static key to control the whole feature. (Willem=
)
> > > > > > 3. Open the gate of bpf_setsockopt for the SO_TIMESTAMPING feat=
ure in
> > > > > > some TX/RX cases, not all the cases.
> > > > > >
> > > > > > Note:
> > > > > > The main concern we've discussion in V1 thread is how to deal w=
ith the
> > > > > > applications using SO_TIMESTAMPING feature? In this series, I a=
llow both
> > > > > > cases to happen at the same time, which indicates that even one
> > > > > > applications setting SO_TIMESTAMPING can still be traced throug=
h BPF
> > > > > > program. Please see patch [04/12].
> > > > >
> > > > > This revision does not address the main concern.
> > > > >
> > > > > An administrator installed BPF program can affect results of a pr=
ocess
> > > > > using SO_TIMESTAMPING in ways that break it.
> > > >
> > > > Sorry, I didn't get it. How the following code snippet would break =
users?
> > >
> > > The state between user and bpf timestamping needs to be separate to
> > > avoid interference.
> >
> > Do you agree that we will use this method as following, only allow
> > either of them to work?
> >
> > void __skb_tstamp_tx(struct sk_buff *orig_skb,
> >                      const struct sk_buff *ack_skb,
> >                      struct skb_shared_hwtstamps *hwtstamps,
> >                      struct sock *sk, int tstype)
> > {
> >         if (!sk)
> >                 return;
> >
> >        ret =3D skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, t=
stype);
> >        if (ret)
> >                /* Apps does set the SO_TIMESTAMPING flag, return direct=
ly */
> >                return;
> >
> >        if (static_branch_unlikely(&bpf_tstamp_control))
> >                 bpf_skb_tstamp_tx_output(sk, orig_skb, tstype, hwtstamp=
s);
> > }
> >
> > which means if the apps using non-bpf method, we will not see the
> > output even if we load bpf program.
>
> Could the bpf setsockopt fail hard in that case?

We can do this. I think I will add some if test statements to see if
sk_tsflags is initialized before.

>
> Your current patch tries to make them work at the same time. It mostly
> does work. There are just a few concerning edge cases that may result
> in hard to understand bugs.

Agree.

>
> Making only one method work per socket and fail hard if both try it is
> crude, but at least the failure will be clear: the setsockopt fails.
>
> I think that's safer. And in practice, the use cases for BPF
> timestamping probably are exactly when application timestamping is
> missing?

Fair enough. Let me try this way:)

Thanks,
Jason

