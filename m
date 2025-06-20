Return-Path: <bpf+bounces-61169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5ACAE1C73
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 15:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E7816F557
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FE528D83E;
	Fri, 20 Jun 2025 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHVRDVO7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F9227FB2E;
	Fri, 20 Jun 2025 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750426999; cv=none; b=QZ17zjxonNMTwv28HMTa9BjYgdOXVwqkp9G1lfj5QttV/2xi60j+eTyIsbE4COvajrmXorsuTk6ULD3JYmReLjJf6LIQ+phPjAut8QbHERIIMpwjk6f4vAvf5ZzbxpFwDdKxyV++KGQoK2oBHHeyqFjx0nDQpExunPSf0lHw13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750426999; c=relaxed/simple;
	bh=BtDzn8n/vqvHXpKItMPxj9V5I9fxi8LYOtEoDRhnw8Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lC1BT5EstMhnqBfbnkwEfVgW/whBJDrhVR15oCsFMaynqIi9SpAh4/AvDPsuweJ9McWsqDn2N/vuvFbPfVmyYCSQ0Lo6aiCUmtM7yHmOySALOtmpDlsKo5Sxw5OXgoQbApqbJCtHsqGeKtgVxkosLa9aeY+LxSb1KIJmM6unFTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHVRDVO7; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e81f8679957so1650011276.2;
        Fri, 20 Jun 2025 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750426996; x=1751031796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2s6n0Gr2kVAxEuR8mkjWcHPacOYcuDhEew9LLuHOWoc=;
        b=kHVRDVO7TPQqM4veyx6n/U+baiLCX39N/dPo2hrW8AK80rqYnOqBNSM1kiks3KpI3b
         q2Evcbwt42D08zVRftH50zbP0I51WqXMCOE4rCIG3ICRpmAI4+WAqRDWsBPHDN0yfaAJ
         6rz7yoCwht1JQVZyH3eFs6IRj8dwWY0RjbSx5+ajLTcDkYO0wnQYUODd6Je6OU71VomU
         4Z0huBAgS50gNfzGFg7wLUcZbhQyYWFisanbn5/dAzkXbYATjjjBxiidmbU45yNUk8eO
         ya8976HQew3rVaA5/PVAu69/Of/QeBsVNxzwhRkJVX7dfsw8rBbFpUFeA25E2LodqsE9
         C/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750426996; x=1751031796;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2s6n0Gr2kVAxEuR8mkjWcHPacOYcuDhEew9LLuHOWoc=;
        b=oBa0NXa8vlO6Pj9OC3sCXnAE8A188wiOswtNGC1K1Nr9Nx5pHB3uBOwak1z37ksrSE
         1FEMC89Z2qLTe1p+dJwVi9Eiv9KA41yaBXS9HWGh381OOkBm02QNm2uofMHaaaCP1y45
         ZRrvZdhLHp8zAPrY2oCBhiEUxkIHxqGiga3av8C3wFuGvpUQvECZp3sik2klfwnTc7J1
         EQDLyh6z7b5sdQCwuQC85gGcy4VkiajulLE5gImjvFmQcxC0fCsegokCjttSr75GWWgE
         etK/n4joTO9Qt97MLCKG5/TquzVelCA0cTDRUGqWs0L4gnUK/6JhOX1XMKua3yGFbFld
         39xg==
X-Forwarded-Encrypted: i=1; AJvYcCU6Jjkc24+41L0fbYMpOpBkpqoVwpbFBm6SzIwAT5FBJhEAtMMSMbBNhm0Kkr5aQFSJLfi5Nzkm@vger.kernel.org, AJvYcCXq/6S02WBmNinMH13oVMG2y0Zq0hKp4MJhBYJOo9kWws7nUelfuVh+QOrQSoJ/rkFJ4E8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvYushOvkgf0r1TW9qfKn1UfD8Ya+Lm5TfV7IU4zyBpZfAaWXf
	IXx9RdU4jKWzDj7+adbs3h9yzq68bYwJvxmQF2aMfWVg/n/9q3i7nEoI
X-Gm-Gg: ASbGnctJXlSnB+KRlZCkw5VRrw3gqRMTqDxzUx2rioqM8hMWzjwuVn697SZM5KHU4lX
	2AiLFgSk5MoeJTSn1EuXkXk4YiqVQ+BXRUQ8QsZ6wZvP7HyXsznfvBWx+rPRdyO/dNMaZglZEx3
	79kaoXoBfeDaini1AHRRdKc79KuD5wbFJ2Pi11lqfHOziXhlwP48aDNF936yHC5QYstgk9Tv3J+
	pxfloRi62ZbBLvd1YMEk1vJt/ckMK/sxoD/ZlZuGYEf+hwcx3uI2z3S/7NQvfjSbEDspT9ccGK9
	3MVFJwb67LEDeocJbdDP3k2aEMKioYd8NxECKKfXhcSSoGKMjTIKbia+g8rsOFsffNDtP2sDlOu
	X9nhpGIHc13e8785Wi12cWZQzFfNs0RnINOyelQfEmw==
X-Google-Smtp-Source: AGHT+IGacnm2dJajAQWwEaifazISo+w+Zi9LK/6bY8jXaRKNTiuhxjInUvYV81Fh9vO+YYvOlBN6sA==
X-Received: by 2002:a05:6902:2d41:b0:e84:37de:2368 with SMTP id 3f1490d57ef6-e8437de269amr6494276.8.1750426995487;
        Fri, 20 Jun 2025 06:43:15 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e843304e7fesm250378276.21.2025.06.20.06.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:43:14 -0700 (PDT)
Date: Fri, 20 Jun 2025 09:43:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
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
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <685565722327f_3ffda42943d@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoBpfFPrYYfWa5P+Sr6S64_stUHiJj26QCtcx56cA5BWXg@mail.gmail.com>
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <6854165ccb312_3a357029426@willemb.c.googlers.com.notmuch>
 <CAL+tcoBpfFPrYYfWa5P+Sr6S64_stUHiJj26QCtcx56cA5BWXg@mail.gmail.com>
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
> On Thu, Jun 19, 2025 at 9:53=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > The patch does the following things:
> > > - Add XDP_MAX_TX_BUDGET socket option.
> > > - Unify TX_BATCH_SIZE and MAX_PER_SOCKET_BUDGET into single one
> > >   tx_budget_spent.
> > > - tx_budget_spent is set to 32 by default in the initialization pha=
se.
> > >   It's a per-socket granular control.
> > >
> > > The idea behind this comes out of real workloads in production. We =
use a
> > > user-level stack with xsk support to accelerate sending packets and=

> > > minimize triggering syscall. When the packets are aggregated, it's =
not
> > > hard to hit the upper bound (namely, 32). The moment user-space sta=
ck
> > > fetches the -EAGAIN error number passed from sendto(), it will loop=
 to try
> > > again until all the expected descs from tx ring are sent out to the=
 driver.
> > > Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequenci=
es of
> > > sendto(). Besides, applications leveraging this setsockopt can adju=
st
> > > its proper value in time after noticing the upper bound issue happe=
ning.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > > V3
> > > Link: https://lore.kernel.org/all/20250618065553.96822-1-kerneljaso=
nxing@gmail.com/
> > > 1. use a per-socket control (suggested by Stanislav)
> > > 2. unify both definitions into one
> > > 3. support setsockopt and getsockopt
> > > 4. add more description in commit message
> >
> > +1 on an XSK setsockopt only
> =

> May I ask why only setsockopt? In tradition, dev_tx_weight can be read
> and written through running sysctl. I think they are the same?

This is not dev_tx_weight, which is per device.

This is a per-socket choice. The reason for adding it that you gave,
a specific application that is known to be able to batch more than 32,
can tune this configurable in the application.

I see no immediately need to set this at a per netns or global level.
If so, the extra cacheline space in those structs is not warranted.

> >
> > >
> > > V2
> > > Link: https://lore.kernel.org/all/20250617002236.30557-1-kerneljaso=
nxing@gmail.com/
> > > 1. use a per-netns sysctl knob
> > > 2. use sysctl_xsk_max_tx_budget to unify both definitions.
> > > ---
> > >  include/net/xdp_sock.h            |  3 ++-
> > >  include/uapi/linux/if_xdp.h       |  1 +
> > >  net/xdp/xsk.c                     | 36 +++++++++++++++++++++++++--=
----
> > >  tools/include/uapi/linux/if_xdp.h |  1 +
> > >  4 files changed, 34 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > index e8bd6ddb7b12..8eecafad92c0 100644
> > > --- a/include/net/xdp_sock.h
> > > +++ b/include/net/xdp_sock.h
> > > @@ -65,11 +65,12 @@ struct xdp_sock {
> > >       struct xsk_queue *tx ____cacheline_aligned_in_smp;
> > >       struct list_head tx_list;
> > >       /* record the number of tx descriptors sent by this xsk and
> > > -      * when it exceeds MAX_PER_SOCKET_BUDGET, an opportunity need=
s
> > > +      * when it exceeds max_tx_budget, an opportunity needs
> > >        * to be given to other xsks for sending tx descriptors, ther=
eby
> > >        * preventing other XSKs from being starved.
> > >        */
> > >       u32 tx_budget_spent;
> > > +     u32 max_tx_budget;
> >
> > This probably does not need to be a u32?
> =

> From what I've known, it's not possible to set a very large value like
> 1000 which probably brings side effects.
> =

> But it seems we'd better not limit the use of this max_tx_budget? We
> don't know what the best fit for various use cases is. If the type
> needs to be downsized to a smaller one like u16, another related
> consideration is that dev_tx_weight deserves the same treatment?

If the current constant is 32, is U16_MAX really a limiting factor.
See also the next point.

> Or let me adjust to 'int' then?
> > > @@ -1437,6 +1436,18 @@ static int xsk_setsockopt(struct socket *soc=
k, int level, int optname,
> > >               mutex_unlock(&xs->mutex);
> > >               return err;
> > >       }
> > > +     case XDP_MAX_TX_BUDGET:
> > > +     {
> > > +             unsigned int budget;
> > > +
> > > +             if (optlen < sizeof(budget))
> > > +                     return -EINVAL;
> > > +             if (copy_from_sockptr(&budget, optval, sizeof(budget)=
))
> > > +                     return -EFAULT;
> > > +
> > > +             WRITE_ONCE(xs->max_tx_budget, budget);
> >
> > Sanitize input: bounds check
> =

> Thanks for catching this.
> =

> I will change it like this:
>     WRITE_ONCE(xs->max_tx_budget, min_t(int, budget, INT_MAX));?

INT_MAX is not a valid upper bound. The current constant is 32.
I would expect an upper bound to perhaps be a few orders larger.

