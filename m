Return-Path: <bpf+bounces-61170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AA5AE1CA2
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 15:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B5E170529
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 13:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D806628E610;
	Fri, 20 Jun 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKcUlG3k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60761E47B7;
	Fri, 20 Jun 2025 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427430; cv=none; b=Cgz4wp5jtKu0mApDYBfsSkBnE3dcEIx7a4P9EHDPhXGZORcVaujUfRSr8Mj53LlsjGwfdUQJ78C4BFdMHMfD6ShmoI6ZeseTFRnu8hPH6l4fCIC407R6nUFDXVUMKabDyLntR7e1O8DsxM6+3tENdAzS7dhmQCbFLO6rneOv06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427430; c=relaxed/simple;
	bh=V9RKXCSdzPs9RnQSgYgt6zhXkh4lYLOKhIoew822ulw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=phqy8uB0m/vWZfR7KH+10jodaBX1IZFTsIkGAAHbecbYLacvNvprcVLZy0C5IqhGQz1v3EKUCfpU4QR3CwS3Ljr6a8LGhLVPIn4wDch30gl/5lp9ROUQ0bnCRwmCaeyjhPJOWoDpAf3qGhFUPSp7N6FWUzeIm5V9NmsQ7Bon8XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKcUlG3k; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e81a7d90835so2159445276.1;
        Fri, 20 Jun 2025 06:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750427428; x=1751032228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TD8kAkASSnG1wzUC5nTWjuLEj74fm4Uzyf/IkPMrDqY=;
        b=JKcUlG3kC+/L5EFVpAW/FR9FzyyY55P660tX/BGqaQ1B3SRMqdW5MPyTN4ccR2DKj6
         QqzgyaKnAurexhJoOou4jqtb4r57xVIa/uXwoMJ22qh2LTFmi7/3rJyWHukHDTZmDj/W
         x3nU+cNpB9Q6QqVUt3+7IDeo2L+f0jyiU1cB5q9xMZkIA/j/CJ1YtNxJ/Wldtn3Z5wkG
         UVvR73lmfiLOZHluplFCRlbRf2X+eELb83Yle+quBhAmhVeTWvr5Iyis2IA3H45N2/O8
         9rkCpUROS99PSuKQ9M1/+86NKaLJDRqxCnE+ld1GNd8XvbjZg0Yg2g8rKX3JGHliD+cI
         WZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750427428; x=1751032228;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TD8kAkASSnG1wzUC5nTWjuLEj74fm4Uzyf/IkPMrDqY=;
        b=TeayEOwZQd9m9PoVSWQcA2o7oXA5fuqGN5wy5zy4uDoUAgl6eUVnXVVIn0dgyhMAYY
         XgdogUjtgRYxftRk6s+ZxWxB5chrDuw+YUjjQrgawnkxpxCcH4uHfMurxHUODWOvNrau
         xFNfhx2D8Bir8W38cUYQ/Fyi+Hkwf0zxCtuGYY6vgtYIpme9vdWbPuWmTQa16TY0feU5
         mWIX+sYZoGZFvNwr9Q5R4V6EmzlhrMaI/tpGUVr1L60UlCw2yW0qloCWPR0tFzWPnxXZ
         AjzDFrSBLkXz5YH0soEdnuAn0iqDCM/pGVdAXQ6cwpXbDxSQfkDwqMaR+O4nglqvT7ln
         mtuw==
X-Forwarded-Encrypted: i=1; AJvYcCUV+rJwUkzXSoybW9KI4KkNQR++bdTplHOWiBAzUafVJK16kvGCv4Fc2XkB4eYIqlIwlDK4UkLQ@vger.kernel.org, AJvYcCVsDDiCFU6egxKnl2mDELCOXZMYQpJxOebkpfA5plLEBujnFNxVAJA6XK0B1q7WkBekUlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxipTQWkBGqONZQNkpKsRc74UlAliG4rXIoPV3s145xnwQ5tcdq
	C1xh9wIFlXhgx1hujFkuXIH7YbXD3tBH8fGZgtY/5I+Syyu9SANHoGE1
X-Gm-Gg: ASbGncuwqq6uJyTutCOVsjywjqqL/Tjk5hj/XgCiNpJ5u8SpI2iqo2aiRdBYxHRwxBM
	h4lzDPSawJ97aY5ex55z50IpnEgdZ5WEyKaTA0K3heoAi4F9VmYJDjBhybN9rW1EDcYGMsoKmww
	w6iF2F4gAsdAOmU761sMmazhgpYK6OmQ0EXVpDw2suk1CK36jui21iSZLgIHUEiohTJn6VSWaUu
	P4ofDV7vscqegoM7g1BbAeIi5RhqvVl9TNKnco3GwYFiosnGx8zAZpR1KMPeG/Ar7VqwEZNULwu
	n+dSuSVCRh739OFORPIeUYZNt9phIEt45P0756bGdtUgnymfLYqOcHA5zs9+rJAnsFGihQzfi1K
	rozhr7Tyzm1kYJmp1HSt8ExANQLRkKfnIYa30ZTsHrA==
X-Google-Smtp-Source: AGHT+IFxRzHHxJdNQGryBWnMzOWVAoaXhH5x5MJogpJcYGKuMitX9ftWwL9+ldnbzzE4HpeDL8pngg==
X-Received: by 2002:a05:690c:368a:b0:710:edf9:d93b with SMTP id 00721157ae682-712c63afe2emr48005997b3.11.1750427427666;
        Fri, 20 Jun 2025 06:50:27 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4c2689bsm4207677b3.124.2025.06.20.06.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:50:27 -0700 (PDT)
Date: Fri, 20 Jun 2025 09:50:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 bjorn@kernel.org, 
 magnus.karlsson@intel.com, 
 maciej.fijalkowski@intel.com, 
 jonathan.lemon@gmail.com, 
 sdf@fomichev.me, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 joe@dama.to, 
 willemdebruijn.kernel@gmail.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <68556722b5c47_3ffda429453@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoA=KQCLdthH3VXPhd-z=sieKQu_xOPgQEzxdy0Mtnycag@mail.gmail.com>
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <20250619080904.0a70574c@kernel.org>
 <CAL+tcoA=KQCLdthH3VXPhd-z=sieKQu_xOPgQEzxdy0Mtnycag@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET
 set/getsockopt
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
> On Thu, Jun 19, 2025 at 11:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> >
> > On Thu, 19 Jun 2025 17:04:40 +0800 Jason Xing wrote:
> > > @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *poo=
l, struct xdp_desc *desc)
> > >       rcu_read_lock();
> > >  again:
> > >       list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > > -             if (xs->tx_budget_spent >=3D MAX_PER_SOCKET_BUDGET) {=

> > > +             int max_budget =3D READ_ONCE(xs->max_tx_budget);
> > > +
> > > +             if (xs->tx_budget_spent >=3D max_budget) {
> > >                       budget_exhausted =3D true;
> > >                       continue;
> > >               }
> > > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct xdp=
_sock *xs,
> > >  static int __xsk_generic_xmit(struct sock *sk)
> > >  {
> > >       struct xdp_sock *xs =3D xdp_sk(sk);
> > > -     u32 max_batch =3D TX_BATCH_SIZE;
> > > +     u32 max_budget =3D READ_ONCE(xs->max_tx_budget);
> >
> > Hm, maybe a question to Stan / Willem & other XSK experts but are the=
se
> > two max values / code paths really related? Question 2 -- is generic
> > XSK a legit optimization target, legit enough to add uAPI?
> =

> I'm not an expert but my take is:
> #1, I don't see the correlation actually while I don't see any reason
> to use the different values for both of them.
> #2, These two definitions are improvement points because whether to do
> the real send is driven by calling sendto(). Enlarging a little bit of
> this value could save many times of calling sendto(). As for the uAPI,
> I don't know if it's worth it, sorry. If not, the previous version 2
> patch (regarding per-netns policy) will be revived.
> =

> So I will leave those two questions to XSK experts as well.

You're proposing the code change, so I think it's on you to make
this argument?
 =

> #2 quantification
> It's really hard to do so mainly because of various stacks implemented
> in the user-space. AF_XDP is providing a fundamental mechanism only
> and its upper layer is prosperous.

I think it's a hard sell to argue adding a tunable, if no plausible
recommendation can be given on how the tunable is to be used.

It's not necessary, and most cases infeasible, to give a heuristic
that fits all possible users. But at a minimum the one workload that
prompted the patch. What value do you set it to and how did you
arrive at that number? =


