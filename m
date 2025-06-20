Return-Path: <bpf+bounces-61193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2DCAE2196
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 19:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64B06A4999
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 17:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7722EB5CD;
	Fri, 20 Jun 2025 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcBSOk4f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDBE2C032E;
	Fri, 20 Jun 2025 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441628; cv=none; b=Ys5ZuxrUV0XMmqF+5ALAEs3LNmY9HPKOV9lCQcrOPvjiwFfkQTl1Hb5s9fDXIQuu0aDt6PkVrDzZRRuYJZqALaPWJAGzxa3driOAjHx2q3s3GkIS4iLBMLTuxvx6QAbsEMYYEd+XJHG83mVPeYDCSLY/2NflOFqKRfBr67Egcac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441628; c=relaxed/simple;
	bh=G+uRjHUsAKHU7qr3i9K5U2L9j60GOaWBVQjAK4camcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPuP7ZMUIFETNG872X9DFPS+4Aahb7hUy2XGNW6UY0wtPKdEtiYvu+3G8VdRW5tYXBAHDmKHD8SBg0ppTn/KB7a+GKFZtXfyGVTu2bn/jfLh8w6ZukpX61TaHHKj78SowhIJdjQ82PX4EcRzSom7zX4xpzClcs7G54yAEJRHTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcBSOk4f; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3de18fde9cfso9379385ab.3;
        Fri, 20 Jun 2025 10:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441625; x=1751046425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fc1DRuvWMiWb4OzwWVTG5fXpPk1UbYHpZU6dF9pGGDU=;
        b=VcBSOk4frTZIFGRCSRPyiAb07ArvFjFVUJqFRZ6mKcFmN0RTjmdKkweWhtMqStHJcb
         VUAlUfnpY1ZjFPYvRnIua+AEVEVM+pvtKOnyzpiVnn4x5rUDuGN22tNE63z5Q/JRMYmp
         CSo1P3TNPpKGDil6Shff+jM/0P60dsqapUsIV78UNrrLin2Yc+mv3a6ep44HW4Y/GPjC
         ImCFF9HHxRjl54OQ7mfDZNizvprqndVQbOY0bullmXiaLQDjBTJ7lwSVBWVLbhoQpA0f
         0JKW64wAY+CIGpbxQyLKt0js1FtjXZ5X5eIriyhegDEbCEQK8K1y1Do73XiwY6wSqZfe
         iqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441625; x=1751046425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fc1DRuvWMiWb4OzwWVTG5fXpPk1UbYHpZU6dF9pGGDU=;
        b=sXzvPIBYUtjgLpJoeE18TK9DYEr1+qm6glWUkP04gawQROQ42aXeGDjeCqRh0X5+Un
         2fsMvS6z5LmjyGu6dzlAwzqL4im8P/gUbXCLJRvU9wiYvVDqV2c+EitQdgmv9IvrJ+FN
         SaMQtMbcTnQ8n92i++1pqjemU423Fmztuk5uanQ/pNhQPeQopPTPm1dOq3MPnFvZWDH7
         IT4x2Cyy+27DqhYrT9WvSyZD9NXpAFZ6ko+kGIdF3+uPF4D9Xyzsnm1GJslCgTEhujuS
         IjDZAz2yfs2BSPlgBcoKqxlUL6vH7FotMzJ1Qlz/hcB4cTasVst0rnu58sY0hTa0HVRY
         B2Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVIFfSR4gfFZO9YPRo02wJ6T1YvN7fCU7CYZZObsKuXY8BRoYKOj4M1F55WYEamrLBm3ug=@vger.kernel.org, AJvYcCX8iYpqpf4mjP8p3UliFTT1yEGcTY9buVWeShB+eiY5BuoKtgzRdbu7bSZDfSzt3I+buCVWgC6u@vger.kernel.org
X-Gm-Message-State: AOJu0YytC66/ZUWJ7Vo+QfH/fEkHlowy/UXqbq/Mc3BwFms624UeG6qy
	BZdd0yNWFqOaKvDdldV/0gVLACgpm81UYoJ2eg7zJpfyVpBZ8RWSjOOv/mcRDo1XmpSDhpG8U0w
	5jHlHI8QgxJcZqHBcStGPvXxp6JAKQvU=
X-Gm-Gg: ASbGncvvGaP/inpo8eNE8FtHBwpDmuQ87HIQssm/JYwRoM9zcyuwFf3oVy/3kRaa5DW
	SzfHiqoSywiTwr5nYzRoAi5Xo5sqmUhH4x/QaOXu4gZCJQKAtt4PlMQ5eJX30C8ekfucZJbCKlJ
	FtBOUH496J4nOYN/frE+8H5Crb9Y4xCqfjxSmnFJCSZsM=
X-Google-Smtp-Source: AGHT+IFZRiuzbdgTkxXz3uUD9g2+l/fELPFRpuHlX/77yLUkEjYD0St6FUiiBSdtIb8NXRXArDbqbYrTi+9coeGUQrI=
X-Received: by 2002:a05:6e02:398e:b0:3dd:89dc:ab07 with SMTP id
 e9e14a558f8ab-3de38c550damr48498965ab.8.1750441625571; Fri, 20 Jun 2025
 10:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <20250619080904.0a70574c@kernel.org> <aFVvcgJpw5Cnog2O@mini-arch>
 <CAL+tcoAm-HitfFS+N+QRzECp5X0-X0FuGQEef5=e6cB1c_9UoA@mail.gmail.com> <aFWQoXrkIWF2LnRn@mini-arch>
In-Reply-To: <aFWQoXrkIWF2LnRn@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 21 Jun 2025 01:46:29 +0800
X-Gm-Features: AX0GCFtrUJLPMGfyW5I8aICjGUxHFHJeytyXTC_8bBZ-svjpdeliu4HVXX35D6Y
Message-ID: <CAL+tcoB-5Gt1_sJ_9-EjH5Nm_Ri+8+3QqFvapnLLpC5y4HW63g@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET set/getsockopt
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 12:47=E2=80=AFAM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 06/21, Jason Xing wrote:
> > On Fri, Jun 20, 2025 at 10:25=E2=80=AFPM Stanislav Fomichev
> > <stfomichev@gmail.com> wrote:
> > >
> > > On 06/19, Jakub Kicinski wrote:
> > > > On Thu, 19 Jun 2025 17:04:40 +0800 Jason Xing wrote:
> > > > > @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *p=
ool, struct xdp_desc *desc)
> > > > >     rcu_read_lock();
> > > > >  again:
> > > > >     list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > > > > -           if (xs->tx_budget_spent >=3D MAX_PER_SOCKET_BUDGET) {
> > > > > +           int max_budget =3D READ_ONCE(xs->max_tx_budget);
> > > > > +
> > > > > +           if (xs->tx_budget_spent >=3D max_budget) {
> > > > >                     budget_exhausted =3D true;
> > > > >                     continue;
> > > > >             }
> > > > > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct x=
dp_sock *xs,
> > > > >  static int __xsk_generic_xmit(struct sock *sk)
> > > > >  {
> > > > >     struct xdp_sock *xs =3D xdp_sk(sk);
> > > > > -   u32 max_batch =3D TX_BATCH_SIZE;
> > > > > +   u32 max_budget =3D READ_ONCE(xs->max_tx_budget);
> > > >
> > > > Hm, maybe a question to Stan / Willem & other XSK experts but are t=
hese
> > > > two max values / code paths really related? Question 2 -- is generi=
c
> > > > XSK a legit optimization target, legit enough to add uAPI?
> > >
> > > 1) xsk_tx_peek_desc is for zc case and xsk_build_skb is copy mode;
> > > whether we want to affect zc case given the fact that Jason seemingly
> > > cares about copy mode is a good question.
> >
> > Allow me to ask the similar question that you asked me before: even tho=
ugh I
> > didn't see the necessity to set the max budget for zc mode (just
> > because I didn't spot it happening), would it be better if we separate
> > both of them because it's an uAPI interface. IIUC, if the setsockopt
> > is set, we will not separate it any more in the future?
> >
> > We can keep using the hardcoded value (32) in the zc mode like
> > before and __only__ touch the copy mode? Later if someone or I found
> > the significance of making it tunable, then another parameter of
> > setsockopt can be added? Does it make sense?
>
> Related suggestion: maybe we don't need this limit at all for the copy mo=
de?
> If the user, with a socket option, can arbitrarily change it, what is the
> point of this limit? Keep it on the zc side to make sure one socket doesn=
't
> starve the rest and drop from the copy mode.. Any reason not to do it?

Thanks for bringing up the same question that I had in this thread. I
saw the commit[1] mentioned it is used to avoid the burst as DPDK
does, so my thought is that it might be used to prevent such a case
where multiple sockets try to send packets through a shared umem
nearly at the same time?

Making it tunable is to provide a chance to let users seek for a good
solution that is the best fit for them. It doesn't mean we
allow/expect to see the burst situation.

[1]
commit e7a1c1300891d8f11d05b42665e299cc22a4b383
Author: Li RongQing <lirongqing@baidu.com>
Date:   Wed Apr 14 13:39:12 2021 +0800

    xsk: Align XDP socket batch size with DPDK

    DPDK default burst size is 32, however, kernel xsk sendto
    syscall can not handle all 32 at one time, and return with
    error.

    So make kernel XDP socket batch size larger to avoid
    unnecessary syscall fail and context switch which will help
    to increase performance.

Thanks,
Jason

