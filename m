Return-Path: <bpf+bounces-40114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8308F97D121
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 08:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1157DB212EA
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 06:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85FE3FB1B;
	Fri, 20 Sep 2024 06:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlzjYcTL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB9533986;
	Fri, 20 Sep 2024 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726813497; cv=none; b=ORFtaFIMChEJSbYd0nnlZUJlekHPaiypGsYFt6Ur3gOmOxcWOdWPKQtJardSS1lwSUr8Qb9EWL1Zs7tixOGAApLn+21j7fhWFx0/CIPpAR6j4mTMJM3VD5szMxQG6VRPhT1zjuqKCgxmKDx/ysm4Rj0tsEcs7/fIfd9YvuGaWDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726813497; c=relaxed/simple;
	bh=iD9Y/yL3aGBC4s25B9LW2jfyRhLf6HUvOzzHXciOMQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fs4K8y54TPnuf73FvOeaOS3jdgni8+y9cdJ+7ytv/Xt54epVV4XMbV08NLt2Thfw8h+P2elvj0fr0jJvp5bdOIGYm7OWzSkEURt3Ugz6kIQgvMimaDGVp8dRgXjQ3TH2VoMuyDRSpd9HgaDvW9wuLDT12HO+8cMYrAOwR3lG4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlzjYcTL; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e116d2f5f7fso2105242276.1;
        Thu, 19 Sep 2024 23:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726813495; x=1727418295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgqpZk0zb0KFhIlK9zMKs0gaQ1N2DEGxcvt+Bmmy4CE=;
        b=VlzjYcTLmsy/nfUES2VDZaLAiZg0nlXY10k9No1ZuULe60GFDPZYNXt4PReAmj/Usv
         iW1iQce2z/6lLeP8fXWxg4qXj0f+PEJLKQ08LHRUnmOWx13SV6ahyhvOBX9MpM6DP1wg
         obpzTFHV0xNASPfUCpohKXnvNy0pgWSCqYKzZ7WpI3L5vZItjbgFOA3tZaYFl7kXKgCX
         ZBGB9ZqYudC5WOv1jbJWDI94ww5WHMb9ukaVXQIRg4a78E/paA/a0hX//Yg5ZoAUqzeQ
         sYu+J7d/Ujinz7qt26ExIS3hUC51Ts6Mcyui6e3HOcRQEZaevTJPzt0/xSoMMOFzaQhd
         qSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726813495; x=1727418295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgqpZk0zb0KFhIlK9zMKs0gaQ1N2DEGxcvt+Bmmy4CE=;
        b=Lpzee4LgAVB071AqV1lXceqiuQhNiQJQA2urV37gWXG8/QBekTCo49iL7E8D+AdVQS
         9Gk02y2d+e86qRm2PmJUwl6S6Ndb/nRBxu0sUBZHXdUIY/oiHaJLyxADrc8DuDZwkhqH
         z5dMdAdw4pfyT9+1uj0K1Qex2NSm+iMovvuKMeQDf34xfadxxAFieEr1deUMvHNLEyhs
         0ze8H51AEY5aJEBA1LYPpfZQGUGVtU21OwrmpQVcKl6py+3++cbnp4n/k9tzAih+kn7y
         SiMTk1dVCOsfrxzErIe1n39JYCLCFyNocC7p/WenGv1P1cOLe2zDVtJOgorIYktPs5Pw
         iF8g==
X-Forwarded-Encrypted: i=1; AJvYcCVnLG76ql+vkEQG9D2eeqDPtvr29Y8EnU34lGWUjJrzaaQwoBZsBaGyTEi0ZiyF2819hqU=@vger.kernel.org, AJvYcCWNBTLt1IjUZVBbtV7y/ae2AlvcUDPUTDF6bAP5VMQ9YqfwmXrJWtCcas1Vxik5qcP9ACopyXkZUAHEL9YS@vger.kernel.org, AJvYcCXuHEuv5Sur4gtyRcjJpJCvXHUxjoTJUB6zLGylRYztjkD9ZgmGOgmWY7tyB6WNfd7ngYgfawjJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxOF0q1qXznTWnZdXAClSfED70Zg62/uTyv5O5lbmA5vcJlrIvO
	FyG400f438kihZ3SMjuHVizs4c0vgGT7NmI0KjCt9j9ene1f/IHDpUgOfL6/KjYhe3/tCsvFsGP
	9RVQzqHU01KLrG3HmYIA/cReji88=
X-Google-Smtp-Source: AGHT+IHdHEDu9iVviJIaLKebjeZmOxgrndjdGZEqYT1kcilR+yz/IuUXG6kkMnfFclNjTnZgJ6fyn3bilFGup5BuIRA=
X-Received: by 2002:a05:6902:1202:b0:e03:5505:5b5b with SMTP id
 3f1490d57ef6-e22506b14ffmr1735324276.0.1726813494894; Thu, 19 Sep 2024
 23:24:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919094147.328737-1-dongml2@chinatelecom.cn>
 <20240919094147.328737-5-dongml2@chinatelecom.cn> <172675702580.6616.12370018117434278479@kwain.local>
In-Reply-To: <172675702580.6616.12370018117434278479@kwain.local>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 20 Sep 2024 14:25:12 +0800
Message-ID: <CADxym3Z-5rEinjiFVhnQuKKa8AhDJ+KuiYw=9RMkKg3FgRmSEQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 4/7] net: ip: make fib_validate_source()
 return drop reason
To: Antoine Tenart <atenart@kernel.org>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, dongml2@chinatelecom.cn, bigeasy@linutronix.de, 
	toke@redhat.com, idosch@nvidia.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 10:43=E2=80=AFPM Antoine Tenart <atenart@kernel.org=
> wrote:
>
> Quoting Menglong Dong (2024-09-19 11:41:44)
> >
> > @@ -2339,8 +2345,11 @@ static int ip_route_input_slow(struct sk_buff *s=
kb, __be32 daddr, __be32 saddr,
> >         if (!ipv4_is_zeronet(saddr)) {
> >                 err =3D fib_validate_source(skb, saddr, 0, tos, 0, dev,
> >                                           in_dev, &itag);
> > -               if (err < 0)
> > +               if (err < 0) {
> > +                       err =3D -EINVAL;
> > +                       __reason =3D -err;
>
> That should be:
>
>     __reason =3D -err;
>     err =3D -EINVAL;

Oops, my mistake!

>
>
> Also this patch should take care of the fib_validate_source call in
> ip_mc_validate_source.

Yeah, I should do the same thing in ip_mc_validate_source().

Thanks!

