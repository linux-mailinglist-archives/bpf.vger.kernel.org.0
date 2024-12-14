Return-Path: <bpf+bounces-46973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 567079F1B78
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 01:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997C0188906F
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB9ECA64;
	Sat, 14 Dec 2024 00:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5rhTv+x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EB42F56;
	Sat, 14 Dec 2024 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137371; cv=none; b=uK0IbzZ5/NjAKYTjPNux9gWy4cnb29Ho34NhIVItxXT4l+lvwi6hXIUsZeSY7BprMrn05AnnsCl0GcqId3owYrXhjOo4CEJY9KqeHlNCDbyVQR2GpEjDBW2o1Xmfu7By/2GzonbYBBDGCw8kwk6XBht+D1QQ6QJW3VKvU9/AUtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137371; c=relaxed/simple;
	bh=InXrvypmXjtmi3GHGMB0wgIT3ICJeV4aMRUyKwtu4cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bn1XejROXrgJiICPKRMbYeGutbcmH+jsIvqCHHKgF7lP+a4SPbN79/qEuP6Ple/2y0zwXU5IM9xcw3AnqFMxr/se5NNeu2K1Z6YN25Xuz3rgTX5DPQ6t4MNs+LTL4VaVA6t25GJWCHs7HMpV+AyCyNWp7ECj4fV2xBZovEeWHkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5rhTv+x; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a7d7db4d89so7039765ab.1;
        Fri, 13 Dec 2024 16:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734137369; x=1734742169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHxM7dbIPXmK10fGHJ5MnD0SLkeBrUv9mHxulf9+YUk=;
        b=E5rhTv+xpzNMMa6iZB1c9hAGeFuo0KLcH+5vhr1C9tPBXeDs1yW3v9i8m0ku9AE1gG
         w6D3GJkg5BNH2/75RjLylj0wyHw26x4w6DflauP9MQ11w8Hu5T+HwfkbLDVswpeoknOT
         wMf5EMfn9HOBmPh+B4gcwtVVsp9uGcv89EL98i+irzfJpb4wnVjM2BhhqY0OXdr79f4k
         pYU5TtxgkuUc69WNu3eu2u+3XVEJuOI8se7JRGV8kjBPFGAHACqURhXOOje2bdGDUf8O
         PB8JtMqbF1KqPNiFWaWAav11mVmFo6JzDBoXvlZUW/OELQSH8FUBn5T4kH9/Jdli4PNN
         Z/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734137369; x=1734742169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHxM7dbIPXmK10fGHJ5MnD0SLkeBrUv9mHxulf9+YUk=;
        b=QtIzeQAiuB6m1SVM3zcvOHvQSfXCe1SjCUhdH8bk9hV+W2vKB9+0U+QzoR7uvYwj+l
         jr3HIQbds3/lB9RYA0q+G5iLDHjXECiYHvwkPwGfufY79ppuapTzIvH22yfDZJ1XXbXf
         fX9VkiiGhbbm1Wuoq1yUWbP5Q/9Mgk7O5j8Z85jE733cBE2gXGteXtLybk8JZHu8iKXq
         y13SyDrvF4WXbLqkHN9ZSpHtALf3yae94hHjbd/9zbTMlUv7Xhji5g+B5Db28y2UhLrT
         7fpieNNhIdVidUvlH6ioJBzhY1QPRgWIzz1TVxk6LdWJV56f90403KgFy1Lr9dXABYbd
         Fhfw==
X-Forwarded-Encrypted: i=1; AJvYcCUvvwkSgOx8GXjTs5NIP/KzXD3LhgpiZFV1EHZ4TIejK+fKCciRsJsHNAVZi0Xi6AuA2AV+IjyB@vger.kernel.org, AJvYcCX8dC2C7wJMfla4YBCBvqUdsMV3kTejlK+HCx/OPxJsDGwUxRrwclpQAzwGFT8Q9vQD5vU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeWk8yKv89NJcU4Bm7qoB5V8lxSengPVjHaMCDFLKqUsUf/UXM
	Oz6FN54/FYpb3hf0ulGa/FDjBDQhiHH5pWP2ezzeJx6zSmminkVDsMwUtvhc/Z8t7+NkpHyeSE6
	cYvrDchWKrB7glqQMtGD/YxupgZk=
X-Gm-Gg: ASbGncuEtgdj12QTrsNIEKN2e1fHhezgc9tj24XUaAW+5SflsQnBMVBx5e0TuDq+N22
	AEvwTGDxfTMNlHLSRVHNQiOKfGUSi8m7DJSzw
X-Google-Smtp-Source: AGHT+IHmaKdI1KId1SACIPMJRVij6WhWA93oBBLMk30fUZ6GNvB6STn17MpL+Kc3Gqx7TkZOLJeo57MYOrR9IA1QPig=
X-Received: by 2002:a05:6e02:1564:b0:3a2:6cd7:3250 with SMTP id
 e9e14a558f8ab-3aff50b64c1mr45958055ab.10.1734137369142; Fri, 13 Dec 2024
 16:49:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-8-kerneljasonxing@gmail.com> <a3abb0b6-cd94-46f6-b996-f90da7e790b9@linux.dev>
 <CAL+tcoCyu6w=O5y2fRSfrzDVm04SB2ycXB06uYn2+r2jSRhehA@mail.gmail.com>
 <53c3be2f-1d5d-44cb-8c27-18c84bc30c9e@linux.dev> <CAL+tcoBzapbhMuu6=jsDbf6N5eT84JmZ-siZFgHNogcRANj9bA@mail.gmail.com>
 <fd65a3e4-bc84-426d-b60b-eb4064dd7731@linux.dev>
In-Reply-To: <fd65a3e4-bc84-426d-b60b-eb4064dd7731@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 14 Dec 2024 08:48:53 +0800
Message-ID: <CAL+tcoCmUcRavWgjCpT73FfNM7c0Qoi3EYd30EwrOa_VVT5Rhw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 07/11] net-timestamp: support hwtstamp print
 for bpf extension
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 8:17=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 12/13/24 4:02 PM, Jason Xing wrote:
> > On Sat, Dec 14, 2024 at 7:15=E2=80=AFAM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> On 12/13/24 7:13 AM, Jason Xing wrote:
> >>>>> -static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *s=
kb, int tstype)
> >>>>> +static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *s=
kb,
> >>>>> +                             struct skb_shared_hwtstamps *hwtstamp=
s,
> >>>>> +                             int tstype)
> >>>>>     {
> >>>>> +     struct timespec64 tstamp;
> >>>>> +     u32 args[2] =3D {0, 0};
> >>>>>         int op;
> >>>>>
> >>>>>         if (!sk)
> >>>>> @@ -5552,6 +5556,11 @@ static void __skb_tstamp_tx_bpf(struct sock =
*sk, struct sk_buff *skb, int tstype
> >>>>>                 break;
> >>>>>         case SCM_TSTAMP_SND:
> >>>>>                 op =3D BPF_SOCK_OPS_TS_SW_OPT_CB;
> >>>>> +             if (hwtstamps) {
> >>>>> +                     tstamp =3D ktime_to_timespec64(hwtstamps->hwt=
stamp);
> >>>> Avoid this conversion which is likely not useful to the bpf prog. Di=
rectly pass
> >>>> hwtstamps->hwtstamp (in ns?) to the bpf prog. Put lower 32bits in ar=
gs[0] and
> >>>> higher 32bits in args[1].
> >>> It makes sense.
> >>
> >> When replying the patch 2 thread, I noticed it may not even have to pa=
ss the
> >> hwtstamps in args here.
> >>
> >> Can "*skb_hwtstamps(skb) =3D *hwtstamps;" be done before calling the b=
pf prog?
> >> Then the bpf prog can directly get it from skb_shinfo(skb)->hwtstamps.
> >> It is like reading other fields in skb_shinfo(skb), e.g. the
> >> skb_shinfo(skb)->tskey discussed in patch 10. The bpf prog will have a=
 more
> >> consistent experience in reading different fields of the skb_shinfo(sk=
b).
> >> skb_shinfo(skb)->hwtstamps is a more intuitive place to obtain the hwt=
stamp than
> >> the broken up args[0] and args[1]. On top of that, there is also an ol=
der
> >> "skb_hwtstamp" field in "struct bpf_sock_ops".
> >
> > Right, right, last night, fortunately, I also spotted it. Let the bpf
> > prog parse the shared info from skb then. A new callback for hwtstamp
> > is needed, I suppose.
>
> Why a new callback is needed? "*skb_hwtstamps(skb) =3D *hwtstamps;" canno=
t be done
> in __skb_tstamp_tx_bpf?

Oh, I have no preference on this point. I will abort adding a new callback =
then.

