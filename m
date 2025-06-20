Return-Path: <bpf+bounces-61218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34957AE2588
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 00:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1376F5A49AD
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 22:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1549A24466C;
	Fri, 20 Jun 2025 22:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiMvH70o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9938223E324;
	Fri, 20 Jun 2025 22:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750458083; cv=none; b=VVLB2WV4QU6NaZPdKHzOGSW/R2rYkdDxF2Al3JCVSFLcmg2U/SoLbIJLvI2fuUGo95o4csPxF9dmCOWLKt4RDRJi0TkF1wb0F+KZ8ohBLHmmZ6owdInRdaV5/kLhb3G2YnZknViY9YFVpEYFpLqcLh1+pisj+D72w2hoNHtMUpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750458083; c=relaxed/simple;
	bh=0fveV5BVEE33jCOBIkTWqJ2P2Ox80pQRtae9npV236o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=J+v/jfU0XeXOTJJcXoKFCZEVHB1pXViUtk8g09aItaakPVdT5xyql+gQ2rLjXJYzm8sHrV6UXoTeMz6IBLSVRbI6R6+lg3oBzCjTQPc8f6MUFQzD8JY4018CRu+ru6plaSz7N0TkPJAcIWXe7vRZQrWmyxFdYhiBtsZxyfc5/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiMvH70o; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7115e32802bso20343487b3.1;
        Fri, 20 Jun 2025 15:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750458080; x=1751062880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSHnGtkJy75nQrfwNnEbkEYOCDTPzLCeEgoZTEl9i1U=;
        b=UiMvH70omlgVEs673JfXfJ/Uhx/acsRyiokiVTDjCidmapiXp2jQEPmpaSrwQqRTMT
         IuSvOANUHlOyCx/BT0dVAJopPevpKooKp9A9NYSak6Yya+F52wUONf/u443nV6RoOgnq
         VD/4QkiLZql/kNRepnStdR7JZhrW4nQdbwrfvV0YsdbMvvtLiiyOaPj4sXk0N7/pYBgE
         eCPR6THPWn2H0WVEafCBmmaKGNBRBdTblh5+jQviEFWgSEwl9dnBmGgGDIVu7jHkcNXg
         22U6Z7whajfQtghia2Tg30Mo9LaTPE+55yuJKL1QzRNySzvumB2kw0ZV0nTKa+aznOwp
         arog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750458080; x=1751062880;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SSHnGtkJy75nQrfwNnEbkEYOCDTPzLCeEgoZTEl9i1U=;
        b=FibNui7bZOde9fLG+bk8B3jpWsUDfepBXZcgbd+xveS1hrQDlLn1m4K9olmtgJtzrE
         0exAokFapRyr8euWZv7nplKHvI2KnYMTXjPtD0yoxKtigA1i3WtAxYvEoerngaZUi+4u
         LpP4zaG0STyQScP1NxfGBY33l2bhkb/MfMKRPs93QVQescQ519X1HzI9MAhlS1Jg4b53
         3ByxdgFVuXCaeNGhmmH/pSWebTv2dHYdbK4MNX92Omi/n5dcEAz6unQr6DH5YKec2SDU
         69f7kFjtI8z/TqAe94Kn8aSXa7Kl6wRtd7I2twJEtSW1tAXKcwYQeVWN+D3uIVlBtz1s
         ilHw==
X-Forwarded-Encrypted: i=1; AJvYcCV7nFr3zOa/w9bA5Yb9becuX4UWFpTiT27VqpJuqZL/Zfl01V/GeJbnYYRdjBWMjLkAlS8=@vger.kernel.org, AJvYcCW8qYrimdWLdWz1DqBGdKhQeLRYHcoLvgxk3esXV4sj8t5I6cfmYYzSx85+JYbH+gxpOT6+SRw7@vger.kernel.org
X-Gm-Message-State: AOJu0YyIKZ2GyFAcCAPHCA4eBMVYZ9bS4kpuzp8CDI3uZ2dTeToDhCq8
	sSCtPpb1kYwOq78YBHXK/8s4KmN3z6eP7LYjb1zra5PoVdyIbMgXQhAA
X-Gm-Gg: ASbGncsxES6mD01y5j8SugZVhIsyvJfAlHntNyzot8MLcseIDBApLlxLogWEtff1oug
	M/0Y03cGncZ3ZJ9RX4AAN1QQ87vzo+Qb9MPnEIyP9t30vFay10WEEM+vsokMr3oIxvwEZQnZDKo
	wEi4v+NW7uBOdpcJ8bU+xaqCLl5rX9ksPV4oiDN3gDYcbu50tIsPYB90b80MxKKz0luTp1yb/E1
	CA4UahhQFe1wF7zhyBEnrB04r9b7cwXe7LKELRLye713TFg6HEvL+Hsa6gCzHjoga1m3cczYhMl
	f4QGwCurpx3L7p7sOj5UFBrztVFATLzeKpcKOD0gfYO3PpoZXOnrG0BB5urc36fAI8N4rnGErje
	atxDpOxbrGSG0QZOdguBEhmZtRHX1fTJxml86IpL7ow==
X-Google-Smtp-Source: AGHT+IG5u5som35pY4h58Azh8jqaaEQF10kZBaaGV03+id+6c++w4nIvI8/JPUiCkPY9VcHUZrlS5w==
X-Received: by 2002:a05:690c:61c9:b0:710:f401:2fd8 with SMTP id 00721157ae682-712c64e5727mr68830557b3.30.1750458080510;
        Fri, 20 Jun 2025 15:21:20 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4a2358fsm5981417b3.49.2025.06.20.15.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 15:21:19 -0700 (PDT)
Date: Fri, 20 Jun 2025 18:21:19 -0400
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
Message-ID: <6855dedf90dec_1ca4329463@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoAMHPYw2bZV87epRFU4oL0=aeUPE3oM6=BUSJuOHPgo8w@mail.gmail.com>
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <6854165ccb312_3a357029426@willemb.c.googlers.com.notmuch>
 <CAL+tcoBpfFPrYYfWa5P+Sr6S64_stUHiJj26QCtcx56cA5BWXg@mail.gmail.com>
 <685565722327f_3ffda42943d@willemb.c.googlers.com.notmuch>
 <68556906dc574_164a294f9@willemb.c.googlers.com.notmuch>
 <CAL+tcoAMHPYw2bZV87epRFU4oL0=aeUPE3oM6=BUSJuOHPgo8w@mail.gmail.com>
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
> On Fri, Jun 20, 2025 at 9:58=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Willem de Bruijn wrote:
> > > Jason Xing wrote:
> > > > On Thu, Jun 19, 2025 at 9:53=E2=80=AFPM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > The patch does the following things:
> > > > > > - Add XDP_MAX_TX_BUDGET socket option.
> > > > > > - Unify TX_BATCH_SIZE and MAX_PER_SOCKET_BUDGET into single o=
ne
> > > > > >   tx_budget_spent.
> > > > > > - tx_budget_spent is set to 32 by default in the initializati=
on phase.
> > > > > >   It's a per-socket granular control.
> > > > > >
> > > > > > The idea behind this comes out of real workloads in productio=
n. We use a
> > > > > > user-level stack with xsk support to accelerate sending packe=
ts and
> > > > > > minimize triggering syscall. When the packets are aggregated,=
 it's not
> > > > > > hard to hit the upper bound (namely, 32). The moment user-spa=
ce stack
> > > > > > fetches the -EAGAIN error number passed from sendto(), it wil=
l loop to try
> > > > > > again until all the expected descs from tx ring are sent out =
to the driver.
> > > > > > Enlarging the XDP_MAX_TX_BUDGET value contributes to less fre=
quencies of
> > > > > > sendto(). Besides, applications leveraging this setsockopt ca=
n adjust
> > > > > > its proper value in time after noticing the upper bound issue=
 happening.
> > > > > >
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > ---
> > > > > > V3
> > > > > > Link: https://lore.kernel.org/all/20250618065553.96822-1-kern=
eljasonxing@gmail.com/
> > > > > > 1. use a per-socket control (suggested by Stanislav)
> > > > > > 2. unify both definitions into one
> > > > > > 3. support setsockopt and getsockopt
> > > > > > 4. add more description in commit message
> > > > >
> > > > > +1 on an XSK setsockopt only
> > > >
> > > > May I ask why only setsockopt? In tradition, dev_tx_weight can be=
 read
> > > > and written through running sysctl. I think they are the same?
> > >
> > > This is not dev_tx_weight, which is per device.
> > >
> > > This is a per-socket choice. The reason for adding it that you gave=
,
> > > a specific application that is known to be able to batch more than =
32,
> > > can tune this configurable in the application.
> =

> I was thinking a pair is needed like some existing options I'm
> familiar with like TCP_RTO_MAX_MS. As I said, it's just a feeling.
> =

> Okay, I have no strong opinion on this. I will remove it then.
> =

> > >
> > > I see no immediately need to set this at a per netns or global leve=
l.
> > > If so, the extra cacheline space in those structs is not warranted.=

> > >
> > > > >
> > > > > >
> > > > > > V2
> > > > > > Link: https://lore.kernel.org/all/20250617002236.30557-1-kern=
eljasonxing@gmail.com/
> > > > > > 1. use a per-netns sysctl knob
> > > > > > 2. use sysctl_xsk_max_tx_budget to unify both definitions.
> > > > > > ---
> > > > > >  include/net/xdp_sock.h            |  3 ++-
> > > > > >  include/uapi/linux/if_xdp.h       |  1 +
> > > > > >  net/xdp/xsk.c                     | 36 +++++++++++++++++++++=
++++------
> > > > > >  tools/include/uapi/linux/if_xdp.h |  1 +
> > > > > >  4 files changed, 34 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > > > index e8bd6ddb7b12..8eecafad92c0 100644
> > > > > > --- a/include/net/xdp_sock.h
> > > > > > +++ b/include/net/xdp_sock.h
> > > > > > @@ -65,11 +65,12 @@ struct xdp_sock {
> > > > > >       struct xsk_queue *tx ____cacheline_aligned_in_smp;
> > > > > >       struct list_head tx_list;
> > > > > >       /* record the number of tx descriptors sent by this xsk=
 and
> > > > > > -      * when it exceeds MAX_PER_SOCKET_BUDGET, an opportunit=
y needs
> > > > > > +      * when it exceeds max_tx_budget, an opportunity needs
> > > > > >        * to be given to other xsks for sending tx descriptors=
, thereby
> > > > > >        * preventing other XSKs from being starved.
> > > > > >        */
> > > > > >       u32 tx_budget_spent;
> > > > > > +     u32 max_tx_budget;
> > > > >
> > > > > This probably does not need to be a u32?
> > > >
> > > > From what I've known, it's not possible to set a very large value=
 like
> > > > 1000 which probably brings side effects.
> > > >
> > > > But it seems we'd better not limit the use of this max_tx_budget?=
 We
> > > > don't know what the best fit for various use cases is. If the typ=
e
> > > > needs to be downsized to a smaller one like u16, another related
> > > > consideration is that dev_tx_weight deserves the same treatment?
> > >
> > > If the current constant is 32, is U16_MAX really a limiting factor.=

> > > See also the next point.
> > >
> > > > Or let me adjust to 'int' then?
> > > > > > @@ -1437,6 +1436,18 @@ static int xsk_setsockopt(struct socke=
t *sock, int level, int optname,
> > > > > >               mutex_unlock(&xs->mutex);
> > > > > >               return err;
> > > > > >       }
> > > > > > +     case XDP_MAX_TX_BUDGET:
> > > > > > +     {
> > > > > > +             unsigned int budget;
> > > > > > +
> > > > > > +             if (optlen < sizeof(budget))
> > > > > > +                     return -EINVAL;
> > > > > > +             if (copy_from_sockptr(&budget, optval, sizeof(b=
udget)))
> > > > > > +                     return -EFAULT;
> > > > > > +
> > > > > > +             WRITE_ONCE(xs->max_tx_budget, budget);
> > > > >
> > > > > Sanitize input: bounds check
> > > >
> > > > Thanks for catching this.
> > > >
> > > > I will change it like this:
> > > >     WRITE_ONCE(xs->max_tx_budget, min_t(int, budget, INT_MAX));?
> > >
> > > INT_MAX is not a valid upper bound. The current constant is 32.
> > > I would expect an upper bound to perhaps be a few orders larger.
> >
> > And this would need a clamp to also set a lower bound greater than 0.=

> =

> Sorry, I don't fully follow here. I'm worried if I understand it in
> the wrong way.
> =

> In this patch, max_tx_budget is u32. If we're doing this this:
>         case XDP_MAX_TX_BUDGET:
>         {
>                 unsigned int budget;
> =

>                 if (optlen !=3D sizeof(budget))    // this line can
> filter out those unmatched numbers, right?
>                         return -EINVAL;
>                 if (copy_from_sockptr(&budget, optval,
> sizeof(budget)))
>                         return -EFAULT;
> =

>                 WRITE_ONCE(xs->max_tx_budget, budget);
> =

>                 return 0;
>         }
> , I'm thinking, is it sufficient because u32 makes sure of zero as its
> lower bound?

The issue is that 0 is not a valid budget.

__xsk_generic_xmit will not make any progress as it will break out
immediately at the start of the while loop.

