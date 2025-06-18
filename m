Return-Path: <bpf+bounces-60879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCDDADDFFE
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 02:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFB8164ED4
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 00:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9102AD14;
	Wed, 18 Jun 2025 00:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAnYbqRY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020562F5319;
	Wed, 18 Jun 2025 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750206616; cv=none; b=Xw4bkJmLVLVzNFS8n4YDaRPUbroFMRk2KiWpUgGv0q6HrIlTQpIk6X/dYK9pmfvwXgDGTdYDMVxRziF6xFP1ggObPl5Bg9E8ZlOlOaTv5Rx3QXOZutNtgZoZl+e40kfpTiuxbWFQemrdRHMd2WUkAgLseEJBvXfcpfpDgJZxMjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750206616; c=relaxed/simple;
	bh=J5ySEFWhq9LCjitNgRpmtizRHVw23bPTElxZL9DBvzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PA7JgKSEUHTNlwXmmzaXYPLq5yjcG968wH86ykHJb9IH/VYOvNI2rWHdgSuf8UdO1W+r++JtlI3wFo+GLxXagPVfgsZuaBRvrmfT61gnSBRFxyYCSQ6CtbdbFv59CZltRQTVvq9blMcfFZCSXALJuoRaFPN+DUIukZf5HOKi43Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAnYbqRY; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-875f28fde67so247032039f.1;
        Tue, 17 Jun 2025 17:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750206614; x=1750811414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVarlzHXaw9fMY+SeAqt+J9Miev+/z+elaWT2O9AvXU=;
        b=AAnYbqRYidoFmPafbdXGEykobioSWrT/0JiLBA71DsrnVgcaRC9jHvrz3959P3m2Vx
         fnRHSzlchEBpK8YERrw3r235/nMBYUDC0OFPv9mIQ3pxJOoWCfrzGXAq07Mb8qZ25NiE
         1cQTxcrSU5Flh04RStItigHbpT9u2f46QcBq2J4+YCXeAsFezvCVxfUjSC7G6jvwnGnj
         gnYJe79D1F9DowA/jlPVNXULo9LNYPAK+X02viSD9gQwChGw4SNDGze0ralrr2DM+jzx
         Ct4udlqQRlu2pKm+1XSLLwXTcpPUV0YGR0Z8XjalFRkzxZlU27Nzxk7ejYdY8lBcRw03
         Ibfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750206614; x=1750811414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVarlzHXaw9fMY+SeAqt+J9Miev+/z+elaWT2O9AvXU=;
        b=q3+kupI2N0qbxB3kf016sjbF14ebunIrjT9us6s1aDfqMveplw1E5XmSrEpS+f/3HE
         /l+WTqzRRpVqce6YM1/lHbbnzS9PN3CY1XpequX4Elu1x5dpeqFiYejtsaL3xMJYT+6V
         3CTwiMzlfu44g4SwMeSNo0g1lufBhH2jqiRt6Xl8IsNkFhWiFfyrWWwXFCyjAYZusmH1
         ZKIWvojfhoCbC7NqwKyKHN0Jk4DuTKU2xH5OAsS20xXLponj9PK3o0rk236tTA8NbyiD
         LtwDNhOw/25iqc27ev9lQX62qZP01qsSBIUrsxuNkAMHPosC1I8X2tOZfdgyZ6iTHPRt
         H4Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWSz9z41BO2xlBFeWyDEi9UABHwRiLiPUQZBambiXZtTN5ZGIkQRNlJyq1d2l6CJygcpBU=@vger.kernel.org, AJvYcCXDtofKji1QUe/Bu+ZiN4NzYbEvneZz9JSmldnun7ZW3zqjcKsexixM3RLrmhH786mSB9rpqBCK@vger.kernel.org
X-Gm-Message-State: AOJu0YyRYyC/HYfNFpFaccblcZDpu0c1TjkPxtewW0cbHcUM+OBf50mh
	k4LiLZ06XgDEOYdbngzOln7QOYL8DnI6e1S9MqdISAXc3E5kx2M0Dt7i3jZ9U7V1JuNE8eR0prb
	sq1w3T9QQsxDChDySCkIhwe0HUF9sIFk=
X-Gm-Gg: ASbGncvWIK9BI6+oOu4GxQGHrJtg6gsPatNl2JrFEPcjBnXu4qqIMM0TyU8XEo6rmD7
	9sH3F1XDd+MQHjZWb04z4RKR/Vd1c7hfoWZmVWEpYDuwXJxwaOH4oDl/HqF9FU+eVe06zY3D7NE
	ymt3oUvFbHLeu/y8BdadyjbEEDtY4jtnKizNaRXdCnVA==
X-Google-Smtp-Source: AGHT+IFWGHaEyVtVfD1k+kMn+hvVlYBEbfE+kop7kkGmWKjveEGo8dEU7n6CGiSUCIw6g61z9EOJ7B9/Z2+VSy+eSrk=
X-Received: by 2002:a05:6e02:2401:b0:3dd:89b0:8e1b with SMTP id
 e9e14a558f8ab-3de07cc46d3mr199751495ab.15.1750206614075; Tue, 17 Jun 2025
 17:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617002236.30557-1-kerneljasonxing@gmail.com>
 <aFDAwydw5HrCXAjd@mini-arch> <CAL+tcoDYiwH8nz5u=sUiYucJL+VkGx4M50q9Lc2jsPPupZ2bFg@mail.gmail.com>
 <aFGp8tXaL7NCORhk@mini-arch>
In-Reply-To: <aFGp8tXaL7NCORhk@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 18 Jun 2025 08:29:37 +0800
X-Gm-Features: AX0GCFuU4Jx26_Q3UukDWBpW0S7oJpgBBZn_BF_pYuRRFkUWp-gjvlq_mALcIHU
Message-ID: <CAL+tcoAQ8xVXRmnjafgGWYDWy_FYuA=P4_Tzmh1zUkna2BF+nA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net: xsk: add two sysctl knobs
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 1:46=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 06/17, Jason Xing wrote:
> > Hi Stanislav,
> >
> > On Tue, Jun 17, 2025 at 9:11=E2=80=AFAM Stanislav Fomichev <stfomichev@=
gmail.com> wrote:
> > >
> > > On 06/17, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Introduce a control method in the xsk path to let users have the ch=
ance
> > > > to tune it manually.
> > >
> > > Can you expand more on why the defaults don't work for you?
> >
> > We use a user-level tcp stack with xsk to transmit packets that have
> > higher priorities than other normal kernel tcp flows. It turns out
> > that enlarging the number can minimize times of triggering sendto
> > sysctl, which contributes to faster transmission. it's very easy to
> > hit the upper bound (namely, 32) if you log the return value of
> > sendto. I mentioned a bit about this in the second patch, saying that
> > we can have a similar knob already appearing in the qdisc layer.
> > Furthermore, exposing important parameters can help applications
> > complete their AI/auto-tuning to judge which one is the best fit in
> > their production workload. That is also one of the promising
> > tendencies :)
> >
> > >
> > > Also, can we put these settings into the socket instead of (global/ns=
)
> > > sysctl?
> >
> > As to MAX_PER_SOCKET_BUDGET, it seems not easy to get its
> > corresponding netns? I have no strong opinion on this point for now.

To add to that, after digging into this part, I realized that we're
able to use sock_net(sk)->core.max_tx_budget directly to finish the
namespace stuff because xsk_create() calls sk_alloc() which correlates
its netns in the sk->sk_net. Sounds reasonable?

>
> I'm suggesting something along these lines (see below). And then add
> some way to configure it (plus, obviously, set the default value
> on init). There is also a question on whether you need separate
> values for MAX_PER_SOCKET_BUDGET and TX_BATCH_SIZE, and if yes,

For now, actually I don't see a specific reason to separate them, so
let me use a single one in V2. My use case only expects to see the
TX_BATCH_SIZE adjustment.

> then why.
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 72c000c0ae5f..fb2caec9914d 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -424,7 +424,7 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, str=
uct xdp_desc *desc)
>         rcu_read_lock();
>  again:
>         list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> -               if (xs->tx_budget_spent >=3D MAX_PER_SOCKET_BUDGET) {
> +               if (xs->tx_budget_spent >=3D xs->max_tx_budget) {

If we implement it like this, xs->max_tx_budget has to read a
per-netns from somewhere and then initialize it. The core problem
still remains: where to store the per netns value.

Do you think using the aforementioned sock_net(sk)->core.max_tx_budget
is possible?

Thanks,
Jason

>                         budget_exhausted =3D true;
>                         continue;
>                 }
> @@ -779,7 +779,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock =
*xs,
>  static int __xsk_generic_xmit(struct sock *sk)
>  {
>         struct xdp_sock *xs =3D xdp_sk(sk);
> -       u32 max_batch =3D TX_BATCH_SIZE;
>         bool sent_frame =3D false;
>         struct xdp_desc desc;
>         struct sk_buff *skb;
> @@ -797,7 +796,7 @@ static int __xsk_generic_xmit(struct sock *sk)
>                 goto out;
>
>         while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
> -               if (max_batch-- =3D=3D 0) {
> +               if (xs->max_tx_budget-- =3D=3D 0) {
>                         err =3D -EAGAIN;
>                         goto out;
>                 }

