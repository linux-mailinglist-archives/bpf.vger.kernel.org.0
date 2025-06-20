Return-Path: <bpf+bounces-61172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF7FAE1CF0
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 15:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EB94C0B5E
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 13:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB8528ECEA;
	Fri, 20 Jun 2025 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em00LVJL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5778F28DEFA;
	Fri, 20 Jun 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427915; cv=none; b=CC8LXle3IiRmyYUL5LAV8nOwRkFhQGDG/2aAUoPci+5WpMngXAeagqLWTecR/Mcke5CQU3qRg1Qus6aBwQEOO4CrcnL0wfkoQ9X7iZAVy6CU+aTH9XijCLcJ48mJQzCHvNxkxb6ekUgYN7Mf4tY6OfmUCeQ/11kWO6MskoDUpgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427915; c=relaxed/simple;
	bh=OnxhBu1DdASDRGlTCLQd/p/iHnlxQe3/QGETKt/+Q0c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MXI0P192io50sqDthJesWPFzfMhAr6W2s3+GMiepKHMe6TsXV615IuiFJvdYg8PY1z4x8pDvTSLcN19R1iT6danwZVdL5yMkJ2wVBjEUet8R3CK+d33lmaZPLsV0qwWOykvkQ4M+Vp847zVs+ItTAn46vIBHpZyADmL+EkFCuQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=em00LVJL; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-710fd2d0372so13681817b3.0;
        Fri, 20 Jun 2025 06:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750427912; x=1751032712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmK0l/F9i7GnOCLWKvJ4EyIhh1KQemPuTLvec4D5LUA=;
        b=em00LVJL0C5qh+bKbefLZbTNln89ltodftx9+Rw4LEo8jnGklIgvA5oN5SqSmXOKl3
         hU7vhdenWjcnLhmlW1cF8E796g8xcLpZuuX2WmGB6ab3zT0PAOjca3wbig5lq+wqxvVo
         dllyDA934oK7wpyZJrIh8tVbEg3HmDj0/1MtiYgl0ZVHSISA/MEUP6KVDugQxZjdBTUD
         sL1EUKd2CJw/gadD7Z0+XwM5mSYRVto5AevWgXGlSAPd7jVtRjZVzrkYagAZIRIKdH5O
         CPBc4rZtnd023M8bn+194WEcrjFC2ItuRIX5bzJvcUeQK3uMp16jws6aWOnltXK4oDti
         HVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750427912; x=1751032712;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dmK0l/F9i7GnOCLWKvJ4EyIhh1KQemPuTLvec4D5LUA=;
        b=en7GJfXi5i00qn5JSboTzT0jcznGSBhkbdBWR62N/aq0uWZUNFuIFIai7nPkgog4ys
         S1lq53YWDAhngNmNmfSWtqtoQ/mM/ru5sNZ0eAmFlphJDgGX5scNFwen2bLnZxeWVQL/
         ZRUmV9R7y146a9yfV+Wc/K5M7lVwYjYQaZUETMO8FTrcVwkXeg7RqhfOyT6ihnTVqGYE
         nXWAPbT/vDwLOaSaq2nzL55boxMBy2d2bzDevRI7kcLOZ3CRbODXp22i0t9FS5W/t6pA
         yOkPgutlJhjUWpUfsYmTa+uN8ohjuJVwapE7YUehLgV7ZXUXKG1vAxHQYjbN0d/cAnLU
         wMVA==
X-Forwarded-Encrypted: i=1; AJvYcCVAPKVsnTTrO5oNEnEjXJkIseAEvOLU0k5uLVYuUC2OfZBc7bGnFUQMH+KI1az4+KMx1MXEcqWH@vger.kernel.org, AJvYcCVSZevo3eAInPQhFSEggMdLGArLrrKCJ5WNpB07H0y6tydSll2JxYYYbAgaJSWxd/kqRvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDQR5CY8uOhweMf5XtZ1O6ZUvkghou6cIsFHOxGk9O+yP/oPAv
	7aCjZgJRBQfRlP0tK5R9SVmMMjbCbiX+AHZXXjKKtMLZlprO0SQUQAee
X-Gm-Gg: ASbGncuctP4HJvSoKNEoSJ0VOhCgDitIBdjjqipf01oaJZ89Q0cNE4XEIms0iDOizgD
	ToqDTIPkuj2wOVfqVZPcK++6hDPivnRBDfXW3P1Lr5uc6t/eNoH2cbPm6bBmW8+50bAevWFItDS
	k3zDlGYMbQe1d7rqz2kTA923HkEaDxQfIWmjWV7hBU1mlziXgNZizj5vOvSsYpptHu0ZIgl94Wm
	D2aT4TR71syiwPT/PvVBu4KqW7j535q3NzQXqNrYxJeGkmgEO+vnKY30O+lA/0c4IaJ+CuoRdLY
	yGbeBtbtM2yBjaELa9qsdE5bow2TyESinmbGnstQHZu/9gFAXW2olpjMnlRstjvoE0Fqn5MdEzm
	iv1B+xVfT5SDdGpar1AibQUGWksWRk2sixjb21Acfeg==
X-Google-Smtp-Source: AGHT+IEjEQs2rDIi5qWBbXo6NyYzeSnnjpG38irtfAzq/Blxq7bpX2Qw11CoaqYs1B4PZjK0XMj2dA==
X-Received: by 2002:a05:690c:2789:b0:712:c5f7:1eef with SMTP id 00721157ae682-712ca2f8191mr30219797b3.3.1750427911893;
        Fri, 20 Jun 2025 06:58:31 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4c236a1sm4206227b3.123.2025.06.20.06.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:58:31 -0700 (PDT)
Date: Fri, 20 Jun 2025 09:58:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
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
Message-ID: <68556906dc574_164a294f9@willemb.c.googlers.com.notmuch>
In-Reply-To: <685565722327f_3ffda42943d@willemb.c.googlers.com.notmuch>
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <6854165ccb312_3a357029426@willemb.c.googlers.com.notmuch>
 <CAL+tcoBpfFPrYYfWa5P+Sr6S64_stUHiJj26QCtcx56cA5BWXg@mail.gmail.com>
 <685565722327f_3ffda42943d@willemb.c.googlers.com.notmuch>
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

Willem de Bruijn wrote:
> Jason Xing wrote:
> > On Thu, Jun 19, 2025 at 9:53=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > The patch does the following things:
> > > > - Add XDP_MAX_TX_BUDGET socket option.
> > > > - Unify TX_BATCH_SIZE and MAX_PER_SOCKET_BUDGET into single one
> > > >   tx_budget_spent.
> > > > - tx_budget_spent is set to 32 by default in the initialization p=
hase.
> > > >   It's a per-socket granular control.
> > > >
> > > > The idea behind this comes out of real workloads in production. W=
e use a
> > > > user-level stack with xsk support to accelerate sending packets a=
nd
> > > > minimize triggering syscall. When the packets are aggregated, it'=
s not
> > > > hard to hit the upper bound (namely, 32). The moment user-space s=
tack
> > > > fetches the -EAGAIN error number passed from sendto(), it will lo=
op to try
> > > > again until all the expected descs from tx ring are sent out to t=
he driver.
> > > > Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequen=
cies of
> > > > sendto(). Besides, applications leveraging this setsockopt can ad=
just
> > > > its proper value in time after noticing the upper bound issue hap=
pening.
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > > V3
> > > > Link: https://lore.kernel.org/all/20250618065553.96822-1-kernelja=
sonxing@gmail.com/
> > > > 1. use a per-socket control (suggested by Stanislav)
> > > > 2. unify both definitions into one
> > > > 3. support setsockopt and getsockopt
> > > > 4. add more description in commit message
> > >
> > > +1 on an XSK setsockopt only
> > =

> > May I ask why only setsockopt? In tradition, dev_tx_weight can be rea=
d
> > and written through running sysctl. I think they are the same?
> =

> This is not dev_tx_weight, which is per device.
> =

> This is a per-socket choice. The reason for adding it that you gave,
> a specific application that is known to be able to batch more than 32,
> can tune this configurable in the application.
> =

> I see no immediately need to set this at a per netns or global level.
> If so, the extra cacheline space in those structs is not warranted.
> =

> > >
> > > >
> > > > V2
> > > > Link: https://lore.kernel.org/all/20250617002236.30557-1-kernelja=
sonxing@gmail.com/
> > > > 1. use a per-netns sysctl knob
> > > > 2. use sysctl_xsk_max_tx_budget to unify both definitions.
> > > > ---
> > > >  include/net/xdp_sock.h            |  3 ++-
> > > >  include/uapi/linux/if_xdp.h       |  1 +
> > > >  net/xdp/xsk.c                     | 36 +++++++++++++++++++++++++=
------
> > > >  tools/include/uapi/linux/if_xdp.h |  1 +
> > > >  4 files changed, 34 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > index e8bd6ddb7b12..8eecafad92c0 100644
> > > > --- a/include/net/xdp_sock.h
> > > > +++ b/include/net/xdp_sock.h
> > > > @@ -65,11 +65,12 @@ struct xdp_sock {
> > > >       struct xsk_queue *tx ____cacheline_aligned_in_smp;
> > > >       struct list_head tx_list;
> > > >       /* record the number of tx descriptors sent by this xsk and=

> > > > -      * when it exceeds MAX_PER_SOCKET_BUDGET, an opportunity ne=
eds
> > > > +      * when it exceeds max_tx_budget, an opportunity needs
> > > >        * to be given to other xsks for sending tx descriptors, th=
ereby
> > > >        * preventing other XSKs from being starved.
> > > >        */
> > > >       u32 tx_budget_spent;
> > > > +     u32 max_tx_budget;
> > >
> > > This probably does not need to be a u32?
> > =

> > From what I've known, it's not possible to set a very large value lik=
e
> > 1000 which probably brings side effects.
> > =

> > But it seems we'd better not limit the use of this max_tx_budget? We
> > don't know what the best fit for various use cases is. If the type
> > needs to be downsized to a smaller one like u16, another related
> > consideration is that dev_tx_weight deserves the same treatment?
> =

> If the current constant is 32, is U16_MAX really a limiting factor.
> See also the next point.
> =

> > Or let me adjust to 'int' then?
> > > > @@ -1437,6 +1436,18 @@ static int xsk_setsockopt(struct socket *s=
ock, int level, int optname,
> > > >               mutex_unlock(&xs->mutex);
> > > >               return err;
> > > >       }
> > > > +     case XDP_MAX_TX_BUDGET:
> > > > +     {
> > > > +             unsigned int budget;
> > > > +
> > > > +             if (optlen < sizeof(budget))
> > > > +                     return -EINVAL;
> > > > +             if (copy_from_sockptr(&budget, optval, sizeof(budge=
t)))
> > > > +                     return -EFAULT;
> > > > +
> > > > +             WRITE_ONCE(xs->max_tx_budget, budget);
> > >
> > > Sanitize input: bounds check
> > =

> > Thanks for catching this.
> > =

> > I will change it like this:
> >     WRITE_ONCE(xs->max_tx_budget, min_t(int, budget, INT_MAX));?
> =

> INT_MAX is not a valid upper bound. The current constant is 32.
> I would expect an upper bound to perhaps be a few orders larger.

And this would need a clamp to also set a lower bound greater than 0.

