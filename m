Return-Path: <bpf+bounces-50476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C6AA281EE
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 03:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC273A47D2
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 02:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF6C211A09;
	Wed,  5 Feb 2025 02:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUDvyDh6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9459B200A3;
	Wed,  5 Feb 2025 02:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738723281; cv=none; b=tfBdJfiGdwtbIJzOFtStH8Qy4KSQS1XJPSpqxvLz+8AVFvNbUqb5sxLnz5KKf2M1k2jsueYrORs/+q10Vzm8nQm9uxYVEXdN5T20Nl5VXeOtoQJOWh5luRSk+Kkyc+WX6U4Beb4knwS/J/mb4bhlu6H674GJQEH9VTPMaKZGoVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738723281; c=relaxed/simple;
	bh=ygXQBi6hr1fOv87CFPNksUPOfVC5MrT9ajNAPt/JaCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcNz31gzP59q7aUFynS+cXvZw95LNqUxD/OAog89Y/DbS47i/wFfGot9IN6x+2iKtR7lsin99P8EuQSWg9FEb5nndkcxzyW4pU4nxRaoG2GGuXdBuj89PTctE5pXvKqXq2tCK+OtlHP/VB26T8tR+uRPmaNebJhNGhPjTSmS8ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUDvyDh6; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d04aec2b84so6394225ab.2;
        Tue, 04 Feb 2025 18:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738723278; x=1739328078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5DTo8ZaJA3jSDo6ZqDYm5jokOLqBcY7Cd18rezzyio=;
        b=LUDvyDh67CDn8zxQdI6lSsFR7EjXCmbMU/NHXzqSUxfae5vb40RNtc41SE8urL57tN
         0sxBEQMkPSau4VlrgM8m2AG3SkY6M7JrON4fIbQhQa9Co9VxvhK+fYZtVilR22mSLH51
         3jJlrzgbWgkK2LL94AKJUhKAuLjvweF7LevQfZi9pSvn6skY2/64EWHplXbz2M6OhwSD
         2aDpvLNFv0SgNZgwEMvFqWmJMlZTSt675yBiPUenadKQakPZrFuToGsqVf/3f1m4einJ
         2hGdLgwtZQvZUFtisdgKA37FCi0GYJP+aD8/KTCtBk7L64FoSxRxwKA8xf6Oubfj4sOb
         a1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738723278; x=1739328078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5DTo8ZaJA3jSDo6ZqDYm5jokOLqBcY7Cd18rezzyio=;
        b=q+6HFdvVLnhgUzog8RuSfZJqotPzqBKzO7kPlgRtonndcPhf3FKw9GteW8WtYvo7cA
         yQ7mQdpwq74tDYjon7pN9qpZkBR9y7T8FuTmVDblKQsLnvqbnwx06PoQiIGkO+yrW851
         qrZnTMETQvavFQKD2SVr8wdImCWP+CAqNUJi2Hv7yggIY3rxG3SnTqeapBhb3g1cDZli
         PHuEFkoHku1d3DSujHAMV44QX7kayQK7fAaPJ2IfCzVE6nXMu1MJEeaXZDrcMFLnvo+X
         gD9PI+LYmbnQbzPwNCTi2JasMEaPYdN6R3VmuRp+n1QQceFq1/p9TDWw4MBuG+AJkb5n
         AFXg==
X-Forwarded-Encrypted: i=1; AJvYcCVLG42kZ9Tup5cR/6tDK6+4QB8xXQ2HX/esNHLcYPqnnoaKgWkdLC7nUb1urhj6CHFTMJnfQbVy@vger.kernel.org, AJvYcCWrHiTjr7hkGvNJzotz6hJudzrLlBrm0G6Bhv7Hf7KzTqUfBpenaTsSRb3oSvJJjiR9JKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWCRDAHZpkz8zk89FEaUhdCa2ONYlCVvcCdKi8TWxRdYu85GR/
	vbIuoqrNmrmcbS2x+Fk6/ylBIog69wgA5yOBZOlBPPM4zeTCxhKEGlgSl8DYMBl+GGCOA+wnWz6
	OksMzHISEs0MWzvP78FrV/m6rqYk=
X-Gm-Gg: ASbGnctu/2lWNs1/r8UGizBPPV64uIuXx5YITGNIOiu0cv4oxJWlSZ+b3B/HRP852Ys
	XidY/c9Du3A1tE3xLttRYSwzo/kmzffWkkb/xX764vJgPk8dl2BZeqbn4pRfMnZu5LC69xAY=
X-Google-Smtp-Source: AGHT+IFTvvq7zCfxfbLnRgtQbgc0zI8ikF+7DaxVM1esUbCPUbronh8I7z4+wUtOHHJoXvtXtE3auMx2j8scU+1YrNo=
X-Received: by 2002:a05:6e02:3a08:b0:3cf:b26f:ff7c with SMTP id
 e9e14a558f8ab-3d04f47945amr10299555ab.5.1738723278587; Tue, 04 Feb 2025
 18:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-6-kerneljasonxing@gmail.com> <20250204174750.677e3520@kernel.org>
In-Reply-To: <20250204174750.677e3520@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Feb 2025 10:40:42 +0800
X-Gm-Features: AWEUYZm41rU1SS_veg-pcZR0w-JVoWm-YX2t2NAfjlxUJYC7SQ1k00lo0yZBXcU
Message-ID: <CAL+tcoDcJd9zNNnsxaCocA1W-eTj+=Ca=B-DoL5Qm6ENfSZ_Fw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 05/12] net-timestamp: prepare for isolating
 two modes of SO_TIMESTAMPING
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, willemdebruijn.kernel@gmail.com, willemb@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 9:47=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  5 Feb 2025 02:30:17 +0800 Jason Xing wrote:
> > @@ -4565,7 +4566,7 @@ static inline void skb_tx_timestamp(struct sk_buf=
f *skb)
> >  {
> >       skb_clone_tx_timestamp(skb);
> >       if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> > -             skb_tstamp_tx(skb, NULL);
> > +             __skb_tstamp_tx(skb, NULL, NULL, skb->sk, true, SCM_TSTAM=
P_SND);
> >  }
>
> Please move skb_tx_timestamp() to net/core/timestamping.c
> You can make skb_clone_tx_timestamp() static, this is its only caller.

I just tested it and it works after reading your message.

I wonder if we need a separate cleanup after this series about moving
this kind of functions into net/core/timestamping.c, say,
__skb_tstamp_tx()?

Thanks,
Jason

> This way on balance we won't be adding any non-inlined calls,
> and we don't have to drag the linux/errqueue.h include into skbuff.h

