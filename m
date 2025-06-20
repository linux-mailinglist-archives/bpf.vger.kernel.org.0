Return-Path: <bpf+bounces-61135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7460BAE1049
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 02:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1BBB7A20A5
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 00:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908D030E82C;
	Fri, 20 Jun 2025 00:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kw03tk+h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C34336D;
	Fri, 20 Jun 2025 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750378708; cv=none; b=Vfc/+y9w/FZjENHmsr31uRgqdiVshF3AVWaZS7nLl2WFaQKglpukjTPIIQVtL5qtDflU2Lj4qUiIIq5m+f5kEw/OKHadKhnz7HTUGOpmTvAKK27VGC3uUx0D59WjOOiYqMTPKcpcXoJdU/wQnQIcQlQebUO31MfMkgUHA/HRBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750378708; c=relaxed/simple;
	bh=w0CnN9nRxM8Gmxr87352B5HdJQn3ewdIkakAPqYfDpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTN1QEoWOOWmu7CB2IraAoT+s+RKuS9qX6PGI9mMMBq4LiNRH5UROqFwKg6xfiYkoKkK7ifvwqu13YjBG3+geHch+9v59B03q/wTu2OomtZqW2DBRhbgDdOrf6ScfUv6M40dgWygcCUf6VdcJxiSkKK12JLymA4VctW2f0aDvg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kw03tk+h; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3de0f5ff22dso4154265ab.1;
        Thu, 19 Jun 2025 17:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750378706; x=1750983506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZIYbY5bX7r6exf6PC2f3tF/R1sXpZVatFvAnCE92s8=;
        b=kw03tk+hcAkrEbHceA/hZPXUFASlnlzI6SPbbdPbcDDJfX2O9svWkImjCcI+mFUFrh
         +iImXKDLPNOVBEEe0LEBcAH3G2SPaPD8Td4elJs9MwLTDwHAA2y8Xky8li9sEur63tlj
         ge4bjzDaf0tKX2A9mIsHqlHm29mIyoErKWx9JzjliLgkIAn3SkuiMqMtGMqFvO8yYBBy
         XQ+MVGhJiarBmxqlAyYBa6iffHvtnxi9fUg2C84+2dymTe8PWBpmIcPW/+CGksgkvOUx
         zs9++lizQo1Y+9fytq5YbVFxHdxedR3jNcR2jh6obWvKIo8V1tH6B2GwyYWK7Kihu+io
         rt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750378706; x=1750983506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZIYbY5bX7r6exf6PC2f3tF/R1sXpZVatFvAnCE92s8=;
        b=Eyh21KfsTQpfMYxSv4nSxHc4G+Re/XDdHj0a4KuJ//BN9Z2Z2jjveKBhNNs/fnimuh
         hhkokM2/Ql17i0ro0oT3V2kBfArQEZcdnnYU9C6Yx2XRBYUrK4H0mJfIP5Ng/C9UlNlf
         XQSOZ1ETVNplwUVR9OpLpkUUyNdTg9koUhXwwhutabdsDp9ws3pcyp1gu0VovcOmvmCE
         YbRAogg9A0kM453zxc6IEd8JLlzHrqmGnIpFt7uz68nXeiA7G3qwHrms3X+iC9bKp3zc
         SA8AcRb8hSMkNmvQailJbNw3bZdJpOq+suawuApgjJJzJMKF/SXyYI2RKkJdoW6TphOD
         IH6g==
X-Forwarded-Encrypted: i=1; AJvYcCUwR117BRirnGSGl4+PD7HPh5cgZEeLfa+fv9HSvLg+P83IAYFFsjAhTyLcAtyxC5cfhII=@vger.kernel.org, AJvYcCWYbsOP/9qTVajCeERbYVp+FAUEBZ6FsfI461OqaQmWGbZjjthcpqQY7XmUY0TDyYN9+zKF/Ac8@vger.kernel.org
X-Gm-Message-State: AOJu0YwCQcLTXaDddBteAEt1IT1jgXPLYOBxrB35ECKvRV2uIkjmJlVY
	iCGDdY0g+ikJbl8te0nDi32h/I0eyY82iNRdG3Gvh1ekB6w2RbjW9RT9RYuB7nYOBndS/9ZzZJG
	Woj3e9B3G6XW+sPg7fGY5KQdWOLVqF3I=
X-Gm-Gg: ASbGnctFBTPK1J0rbk2WcxVlPMMXrhtYOPtt/XejkDS2HFiRoM5LGHAB/i2PTlGrPJ1
	oY04xX3Sns6/7H3tWJYH3n53SEcQaBNjCdVBJdPQZikoHenjjWuQ7CAm/pLe9/up0q44giCMtpi
	nLvTZuabp0uGNN/1QXH937LRkgdQprJw39E9rYMB8p2g==
X-Google-Smtp-Source: AGHT+IEXV3K1E4s6uWsaZ7NhAsDf3K/vFVqKmzUtFBiO4ajGCvZ3FA0bqRJSYyOIYD799wHjWsdlfMefHwAMfHPvfUE=
X-Received: by 2002:a05:6e02:1786:b0:3dd:bb60:4600 with SMTP id
 e9e14a558f8ab-3de3955bf4bmr4303895ab.5.1750378705696; Thu, 19 Jun 2025
 17:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619090440.65509-1-kerneljasonxing@gmail.com> <20250619080904.0a70574c@kernel.org>
In-Reply-To: <20250619080904.0a70574c@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 20 Jun 2025 08:17:48 +0800
X-Gm-Features: AX0GCFtkfYezekGNgOug7Ex6UjGsdLp0tlaykkd2OPR0pdaaO8-DnHVsjYr0Dyg
Message-ID: <CAL+tcoA=KQCLdthH3VXPhd-z=sieKQu_xOPgQEzxdy0Mtnycag@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET set/getsockopt
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 11:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 19 Jun 2025 17:04:40 +0800 Jason Xing wrote:
> > @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, s=
truct xdp_desc *desc)
> >       rcu_read_lock();
> >  again:
> >       list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > -             if (xs->tx_budget_spent >=3D MAX_PER_SOCKET_BUDGET) {
> > +             int max_budget =3D READ_ONCE(xs->max_tx_budget);
> > +
> > +             if (xs->tx_budget_spent >=3D max_budget) {
> >                       budget_exhausted =3D true;
> >                       continue;
> >               }
> > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >  static int __xsk_generic_xmit(struct sock *sk)
> >  {
> >       struct xdp_sock *xs =3D xdp_sk(sk);
> > -     u32 max_batch =3D TX_BATCH_SIZE;
> > +     u32 max_budget =3D READ_ONCE(xs->max_tx_budget);
>
> Hm, maybe a question to Stan / Willem & other XSK experts but are these
> two max values / code paths really related? Question 2 -- is generic
> XSK a legit optimization target, legit enough to add uAPI?

I'm not an expert but my take is:
#1, I don't see the correlation actually while I don't see any reason
to use the different values for both of them.
#2, These two definitions are improvement points because whether to do
the real send is driven by calling sendto(). Enlarging a little bit of
this value could save many times of calling sendto(). As for the uAPI,
I don't know if it's worth it, sorry. If not, the previous version 2
patch (regarding per-netns policy) will be revived.

So I will leave those two questions to XSK experts as well.

>
> Jason, I think some additions to Documentation/ and quantification of
> the benefits would be needed as well.

Got it.

#1 Documentation. I would add one small section 'XDP_MAX_TX_BUDGET
setsockopt' in Documentation/networking/af_xdp.rst.

#2 quantification
It's really hard to do so mainly because of various stacks implemented
in the user-space. AF_XDP is providing a fundamental mechanism only
and its upper layer is prosperous.

Thanks,
Jason

> --
> pw-bot: cr

