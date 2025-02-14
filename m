Return-Path: <bpf+bounces-51623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6ABA36900
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 00:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0F516FC4E
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 23:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088F81FCF63;
	Fri, 14 Feb 2025 23:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFuPuDsq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA191FC7F2;
	Fri, 14 Feb 2025 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739575172; cv=none; b=DES1UjSpKvCH3oydndYfEcuzyz/L2IZKaOYqcd00ZBdxuGV3HnyDMOigH3ixksJYelrG0SEYberwXyQ66F0WfWD7AIH+yZHS95iZt4m6qmpVhQKWnrXwwCPGM1v+bEivTBhB76ZP069Gaex1DLFNSO14YK8bbvThOafcNv1qo/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739575172; c=relaxed/simple;
	bh=eyPPOWkGXNbhrVeWc7rPH5bzAvKPuBByqlIoAKY2YTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L66+XdqcwQIUfWDH6JKraMaHW29/hq620rfPNShgNjz911Bl6i4TB5sldqMezSu12ifi3w084gfEkxsGyYTborDWimCqEdExubOW4dawPXzB60W/WgXzfy/6t11egLZUBraAtT9uM5pR4ufHGS/N57SKTBzGgJNu+fVpODuizjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFuPuDsq; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d19f5ce8a0so3190185ab.1;
        Fri, 14 Feb 2025 15:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739575170; x=1740179970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVbwjvme6C8voTy2N8xaDDZTzYCw2X3AZpf/C9tCLZ4=;
        b=iFuPuDsq4tyGI4Ap34NYGDcno68vCS58BKCD990w+17FRfb8+cJDKgmwf3ENoOoVtS
         X7WtJyYHJy2TXQLxoYzKJFb5pNHki3qonT5cAUABrvGmyquFzVkE+7QxtTtPHlxOq7Uh
         TxB+n90Gr+FtQ69ilST8JWg3NK8Ksx47QDr9B3RaVoLYRr6/Z5rSZ6EfD71qOFxFhZ88
         ToGZE2fOH3v7JFB1FEjvFlrTRKxW6RARIuM/H9RR9fUdNdZsJ6xfamH3+JryMobjRFa5
         5dzKxtUg0u05tW0AXdElf7GFfZQdKnqmse1eM2HcgaAov1dg/dY5ENODcfODVJFIJcMo
         Q93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739575170; x=1740179970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVbwjvme6C8voTy2N8xaDDZTzYCw2X3AZpf/C9tCLZ4=;
        b=Xb6fcxJWfudAr41AsavyLWLCY/LCYTHTwAzb+KkvA5EWcUfao/nbbUxXJjZQdMrckp
         SX2dqeM6hLfdTGv72ma3ABpi23p2B8j8mTbLyHJKJeDf1F/kTy/1u/2QQhYxOqelp6w1
         ykfiy2vqww+PUh3NP5KkMsiU+AutaxChsuY5ZuyH2PC8LQ0yolfqFP1NS21L3yWOYXAM
         p+Uv4dZPcelvES+2QPHJvrgaEWnL4+QVzuvM1aACOZV6RK9l2scIf+/1BYkdQv5R+Qcs
         8kyMaJMQRUCvmOoI348OmyelRL71N9l17EgC3ES5DDTUuj6XmvFRCYV5jU7XK52qUkFV
         Edow==
X-Forwarded-Encrypted: i=1; AJvYcCVPWiZCKGqnACR7O1KXr8ozllVk/qvA4/ipc+xaxxipGc7nb0jjdGEy3xj9iUGhaNNMaFYwvKqL@vger.kernel.org, AJvYcCXd4hWuF4wZuJIn0ynlP8EXopJ1Pk+Tk/zhy22UCpp8Ev6b88lNLOzsxR0VkG0M8gC87ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFHdUF2jG3pQ2tdNodAOtieFEMttYlx7PDxI8xgWjO4Ln3IxXY
	hh/f/i8Ofb+amgCTEtT3gu5+PQbxdGMCn0bGF6qNlHzmLhZQC+VZKDyUTKVMHDmRO8J6t45Ksnb
	ucLC6zznYb71oLxObiwKFtyYwStA=
X-Gm-Gg: ASbGncsEuxcHz0rWRKOpDJCNwcxV9fmY69bXjr1q0mxAZoMd0xfVrsW5pM7mlVbZJXC
	MC/1GANLjwZAn1C0LXO2qLsNj6vuyI4b67dvlmjPQdsBzVCgnY/CIEfnCrTweqD0K+Yb0dwOn
X-Google-Smtp-Source: AGHT+IHmkYmkfA5HpZoi0EGLS7GUKITBiRPM6/YirK4UXhR7VVvzSoTxc5RxuynsDyZWaOuDJfOZ8G4ontyFbpMzijQ=
X-Received: by 2002:a05:6e02:3706:b0:3d1:4a69:e58f with SMTP id
 e9e14a558f8ab-3d18cc3ff7cmr80280035ab.2.1739575170201; Fri, 14 Feb 2025
 15:19:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-13-kerneljasonxing@gmail.com> <efe32620-81d6-4e13-bfd4-9349e78c98fb@linux.dev>
In-Reply-To: <efe32620-81d6-4e13-bfd4-9349e78c98fb@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 15 Feb 2025 07:18:53 +0800
X-Gm-Features: AWEUYZlQUH6XAEIti8Am23MHexoDS0e2mrHChjMhJc7epVeuMF70PgOHuUvLg9I
Message-ID: <CAL+tcoDJ9EA0BDOE-6Qti3MkAa=u-yAtR-2zjbBrAAjBHXnuDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 12/12] selftests/bpf: add simple bpf tests in
 the tx path for timestamping feature
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 4:40=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/13/25 5:00 PM, Jason Xing wrote:
> > +static void test_recv_errmsg_cmsg(struct msghdr *msg)
> > +{
> > +     struct sock_extended_err *serr =3D NULL;
> > +     struct scm_timestamping *tss =3D NULL;
> > +     struct cmsghdr *cm;
> > +
> > +     for (cm =3D CMSG_FIRSTHDR(msg);
> > +          cm && cm->cmsg_len;
> > +          cm =3D CMSG_NXTHDR(msg, cm)) {
> > +             if (cm->cmsg_level =3D=3D SOL_SOCKET &&
> > +                 cm->cmsg_type =3D=3D SCM_TIMESTAMPING) {
> > +                     tss =3D (void *)CMSG_DATA(cm);
> > +             } else if ((cm->cmsg_level =3D=3D SOL_IP &&
> > +                         cm->cmsg_type =3D=3D IP_RECVERR) ||
> > +                        (cm->cmsg_level =3D=3D SOL_IPV6 &&
> > +                         cm->cmsg_type =3D=3D IPV6_RECVERR) ||
> > +                        (cm->cmsg_level =3D=3D SOL_PACKET &&
> > +                         cm->cmsg_type =3D=3D PACKET_TX_TIMESTAMP)) {
> > +                     serr =3D (void *)CMSG_DATA(cm);
> > +                     ASSERT_EQ(serr->ee_origin, SO_EE_ORIGIN_TIMESTAMP=
ING,
> > +                               "cmsg type");
> > +             }
> > +
> > +             if (serr && tss)
>
> Regarding this check, does it need to reset both serr and tss to NULL bef=
ore the
> next iteration? e.g. It can get >1 timestamps in one recvmsg(MSG_ERRQUEUE=
) ?

If more than one skb carrying timestamping is received in one recvmsg
from the error queue in this case, it means something goes wrong. So
we don't expect that to happen.

Thanks,
Jason

>
> > +                     test_socket_timestamp(tss, serr->ee_info,
> > +                                           serr->ee_data);
> > +     }
> > +}
> > +
>

