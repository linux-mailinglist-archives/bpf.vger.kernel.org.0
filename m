Return-Path: <bpf+bounces-41407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F80A996BC8
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0667A1F2751A
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 13:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FB7198A32;
	Wed,  9 Oct 2024 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dum410J3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AE8194AEB;
	Wed,  9 Oct 2024 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480237; cv=none; b=ubnBetlgHt3VF5o1n/vyxa2azcDhtqCbZIewDHV2ldg77rugJuTCy+db0yO8PXkEtxPOQVO2fZc1ON/TtLrTkadNfMuvYqfFDA7QU8hVBXiSu8OrmvlefNBRBGfsrtZhbze5MeunZfW98RbxFbnuYyaiSgkf5dKZZGSUhD7BLRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480237; c=relaxed/simple;
	bh=bGsXFKNKJ/ZEsB0weYx7B4eBkJ95ptvOO3j0TCbklOc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pdWlJTl0QFm0aBqz2dfSyqHY73XOSLlpgwmBr7J8WArmmFd3NvxbJnCeGQ8UAPOPDtDz4wrW1BUmlGkCvcQ/a4CIC+Lga5lyMAZ2MIDlNU/SogetrKtFNEZqrIBeEjuc7xR9H5gTIBXMHsnVMEwILRwGYFzOPJL5mdGfo1+fJQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dum410J3; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cbce9e4598so3272096d6.2;
        Wed, 09 Oct 2024 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728480235; x=1729085035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQC0+J6J6vV0gkCLdluiggWxHNsh2NwQQJv/zLEAJ7o=;
        b=Dum410J3oWvOcWlEUkzkNY8EI+KrqGInmRqU26EINBjNIQ5ksE2xrmoJLJKfbBl1V7
         3CtOlTiEmQbmRmOeys6oqFEwjczBZw3KDtuzgMmTPZpCHRsvIzEo9dfwb+8VeDv/IuMS
         hG5s6QdiY2JXJ28Vpijb40AmTvhVEGlTJY4vjYyivRThVRXP3ZRErN6Rwn1DS85HMCPn
         zB61UpecVctCj7bkbXRTfdXIjO5mXrbzPmWaadQ/H7RKTGMkqb6YMnBInQwgMs73M6yt
         GEh0PBHkHLsAQmjuUaKHmzzffOKDS6oUl7FgnQcMPofouN0qZPOnuFf0Y9lqwVL/SVzB
         Ld0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728480235; x=1729085035;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LQC0+J6J6vV0gkCLdluiggWxHNsh2NwQQJv/zLEAJ7o=;
        b=ehdv4gStEXrLCBoyR+rkAy2wZaBmJsh8ciAA6m5g2iXicbOhke/dHg9HftpZAoqgId
         DtrR47709QIincEchWZbGmnBHZ1+PSZ3iN3sD/AnPaHFIoImRDo4dkQyhhYZEPtEjyy9
         aL3/Yxm/HeeTXjQg77tUTc3WJIEDpJrYdofXSTyARr2/wbhPpAiKiP7espdGybGQksPx
         ocIgZ7YtmFjv31NOEz+1uHeOZXkwAzFTwWKaO7fy01Y16axDYyI+3ZsbA/4zQeP5atz1
         qZf/QYQ1PH3lNSCX7lKdc169m1WsmzZUAGX1W8kckUIU5xumB991yA/yDt/8z7mF8UOj
         PZxA==
X-Forwarded-Encrypted: i=1; AJvYcCWi0AigFAPCQTo2Li3PlZlloY9XvQvjSNOE8s1yYj5aD/CKadVAtvGTfJY0tP3gMap5GbM=@vger.kernel.org, AJvYcCX+7Sr2yBmvmLvdVEjCFf0EF9H9opCKKZLQmKyIe5D1qUHDrAuNGen9uZ1Er6GYjA86y/Vk3HVt@vger.kernel.org
X-Gm-Message-State: AOJu0YwO/o5blic7dPX8f9+P3qY9GHwHahoEI1AD2JRJ1ruUhbHJhuDo
	uPUBpwgppq3/3eF8Qz0xeDmunpKeseYAWMCD30LAAFNV+XPoM1hb
X-Google-Smtp-Source: AGHT+IEGme5iigk4XHQBCdd6gcoajjzATynJLhntgF2uRdj3zL8ZhVHBPtFxOPLQf23ja4DkUuwLnw==
X-Received: by 2002:a0c:fc06:0:b0:6cb:ced6:ab52 with SMTP id 6a1803df08f44-6cbced6ababmr13812436d6.8.1728480235202;
        Wed, 09 Oct 2024 06:23:55 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba4763aa8sm45968436d6.119.2024.10.09.06.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 06:23:54 -0700 (PDT)
Date: Wed, 09 Oct 2024 09:23:54 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
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
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <670683ea7b8a5_1cca3129485@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoBGe83v+1ej6GYpZpDkFt_hnuzw_mG8E3vEEhSQbUkreA@mail.gmail.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-8-kerneljasonxing@gmail.com>
 <9d5dce58-c019-48b3-8815-b9e0f9d4e8cb@linux.dev>
 <CAL+tcoBGe83v+1ej6GYpZpDkFt_hnuzw_mG8E3vEEhSQbUkreA@mail.gmail.com>
Subject: Re: [PATCH net-next 7/9] net-timestamp: open gate for bpf_setsockopt
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
> On Wed, Oct 9, 2024 at 3:19=E2=80=AFPM Martin KaFai Lau <martin.lau@lin=
ux.dev> wrote:
> >
> > On 10/8/24 2:51 AM, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Now we allow users to set tsflags through bpf_setsockopt. What I
> > > want to do is passing SOF_TIMESTAMPING_RX_SOFTWARE flag, so that
> > > we can generate rx timestamps the moment the skb traverses through
> > > driver.
> > >
> > > Here is an example:
> > >
> > > case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
> > > case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
> > >       sock_opt =3D SOF_TIMESTAMPING_RX_SOFTWARE;
> > >       bpf_setsockopt(skops, SOL_SOCKET, SO_TIMESTAMPING,
> > >                      &sock_opt, sizeof(sock_opt));
> > >       break;
> > >
> > > In this way, we can use bpf program that help us generate and repor=
t
> > > rx timestamp.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >   net/core/filter.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > >
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index bd0d08bf76bb..9ce99d320571 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -5225,6 +5225,9 @@ static int sol_socket_sockopt(struct sock *sk=
, int optname,
> > >               break;
> > >       case SO_BINDTODEVICE:
> > >               break;
> > > +     case SO_TIMESTAMPING_NEW:
> > > +     case SO_TIMESTAMPING_OLD:
> >
> > I believe this change was proposed before. It will change the user ex=
pectation
> > on the sk_error_queue. It needs some bits/fields/knobs for bpf. I thi=
nk this
> > point is similar to other's earlier comments in this thread.
> =

> Thanks for your reply.
> =

> After seeing what you mentioned, I searched through the mailing list
> and found one [1] which was designed to fetch hardware timestamps.
> =

> [1]=EF=BC=9Ahttps://lore.kernel.org/bpf/51fd5249-140a-4f1b-b20e-703f159=
e88a3@linux.dev/T/
> =

> >
> > I only have a chance to briefly look at it. I think it is useful. Thi=
s
> > bpf/timestamp feature request has come up before.
> =

> At the very beginning, I had no intention to use bpf_setsockopt() to
> retrieve the rx timestamp because it will override sk_tsflags, but I
> cannot implement a good way like what I did to tx path: only setting
> skb's field. I'm not sure if this override behaviour is acceptable, so
> I post it to know what the bpf experts' suggestions are.
> =

> >
> > A high level comment. The current timestamp should work for non tcp s=
ock? The
> > bpf/timestamp solution should be able to also.
> =

> For now, it only supports TCP proto. I would like to quickly implement
> a framework which is also suitable for other protos. TCP is just a
> start point.
> =

> >
> > sockops is tcp centric. From looking at patch 9 that needs to initial=
ize 4 args,
> > this interface feels old and not sure we want to extend to other sock=
 types.
> > This needs some thoughts.
> =

> For me, I have interests to extend to other sock types. But I'm
> supposed to ask Willem's opinion first.
> =

> +Willem de Bruijn Do you want this bpf extension feature to extend to
> other protos?

There would likely be users for other protocols too, just like
SO_TIMESTAMPING. Though TCP is probably the most widely used case by
far.

