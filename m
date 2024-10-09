Return-Path: <bpf+bounces-41365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E119961E5
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 10:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3AA1F22934
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 08:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B51183CD9;
	Wed,  9 Oct 2024 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzfJSiNB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D021537D7;
	Wed,  9 Oct 2024 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461397; cv=none; b=WEMTipmd1EgNe1xP+QaWHtyG19Ot16taOmRDmsjwHGmsBRqD7N6N+y3SpoQCGFQ6yT9VVK2d+4nQe5G9qSNCHMB56MC8zvFnFaAtqzbDMSWcr6kat6FsUx14b/Y4uvVGLBHpQG4xZVD6yZifnBllTeF1r031RX3obEQtsaYgaTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461397; c=relaxed/simple;
	bh=IkTkrVyRCSwv3EpNMmPZLNdcW9UepVkbdkRW2pKFUbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyqjefKdN24j7Gq4eRr4erpCAeOUzKZbYZAQIXuT5Wgpdi9oGS+n9iT7k2TwVQOUsc0aAF4eLsI282kV4uUOC4cvmWc4eAOVO5tNcR9TqpqZ/6k6rjnJDOvbrC8CjQgzS2uRvkoyTfjIbK5EhiEQf4dphDhcliA2hCEeT1wcl78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzfJSiNB; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3636ddad6so23478045ab.2;
        Wed, 09 Oct 2024 01:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728461395; x=1729066195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqiAzVjZxlsttYgwKg8hz8xAiwvJXOp3NWV6IWxbUCg=;
        b=SzfJSiNBozcdaJQWqQ7wsdM9ou5fTAu9Me8y2QiKySjuRz4u6LFrVpgX1vISn5JRnw
         ieFFhxCvUNdZuv1SvhhL8ORD0x4g6zFZ0kKUh+pmorRr3DRQ0shkhh2ltl11CaBA9s+z
         wPLXwBqFkXyfmxrHTsIzamhSx4h9eMudyAsv91uJutcn8hjcRddAjzerl9Nxh42cMJE3
         ZqH/aM01Ua43ZlnHLvEM/CYZ5zjXbrAD2BrpBceAvbmtJ0aF8ST8GxPuiUJQKSpX8lmS
         RuWjYndTE4QswV1Grx42QyuNMxtCPRZ/tzt8zd3agbJmtiWqxp8gpDEHFdg/JCNRiO8f
         1qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728461395; x=1729066195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqiAzVjZxlsttYgwKg8hz8xAiwvJXOp3NWV6IWxbUCg=;
        b=qOF7v9YvvrFWCAAIA9EwczLY/KX/EzWcmUwuaBsHsgH7FuV72eWLZWyR2fF+r4f+G8
         hnJcGc4rPw7u1NOYxd/KxCmcCaI5Ash/Cq9EmIoodjJKIbks+qX1UcJpfb/frQks8n5L
         3WeLpgtbj6bQSmjF6OIh9NCaTpPdO61/XAOxRIGaP+BFnK08W4dO6f1LMS9YC1nSMSqM
         qUAy+IFK+poJkmTH1tnIEqAn2gwzCU9RaCpuu5jK6j694gvnemk/3bkNLth5PA5CdyIY
         LGqdcJHaYsPszyjdYlbtbXrnHkrLB0ymghed1u2gU/FTL5XmLgkAu3Hdajg4aCT998cU
         GwqA==
X-Forwarded-Encrypted: i=1; AJvYcCXdYvaTJjFFKL4d2iu7QHxPCAm5RDk7X+iF5SSmLZ8tDxndQFTtA2/ADMWvqXJfwQQwC+u81CIS@vger.kernel.org, AJvYcCXeto+isb/xPFfw0Lr9HDBqKCAIPG50T9mlo5LTq5QBwNLThwfv4y5Mn9COQryRyIaNwoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrDKhjMH3/zfvs6BYhB+4al0yqzb7EqGwy6j51hJXhR5JnnuDp
	4bj6p/Y6znTgo7FG1cJkwR6mPhegT9cdSs2oSwmJ8njM38z2nABQqHm5Hd9gu78Df3n+LFEr2b/
	pE+1+nSwm5j2uuAt59iy+vARtETw=
X-Google-Smtp-Source: AGHT+IEMZ8RaR5dhZS1Ehs7tfyrTBHG2qN3dN+U0VBBoBIHpjfkqIPrL0Y+zPETkfzCP7AWL0ErUcwMBpmybEr4mNHQ=
X-Received: by 2002:a05:6e02:13a7:b0:3a0:933a:2a0a with SMTP id
 e9e14a558f8ab-3a397ce693bmr16418605ab.7.1728461395498; Wed, 09 Oct 2024
 01:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-8-kerneljasonxing@gmail.com> <9d5dce58-c019-48b3-8815-b9e0f9d4e8cb@linux.dev>
In-Reply-To: <9d5dce58-c019-48b3-8815-b9e0f9d4e8cb@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 16:09:19 +0800
Message-ID: <CAL+tcoBGe83v+1ej6GYpZpDkFt_hnuzw_mG8E3vEEhSQbUkreA@mail.gmail.com>
Subject: Re: [PATCH net-next 7/9] net-timestamp: open gate for bpf_setsockopt
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 3:19=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 10/8/24 2:51 AM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Now we allow users to set tsflags through bpf_setsockopt. What I
> > want to do is passing SOF_TIMESTAMPING_RX_SOFTWARE flag, so that
> > we can generate rx timestamps the moment the skb traverses through
> > driver.
> >
> > Here is an example:
> >
> > case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
> > case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
> >       sock_opt =3D SOF_TIMESTAMPING_RX_SOFTWARE;
> >       bpf_setsockopt(skops, SOL_SOCKET, SO_TIMESTAMPING,
> >                      &sock_opt, sizeof(sock_opt));
> >       break;
> >
> > In this way, we can use bpf program that help us generate and report
> > rx timestamp.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   net/core/filter.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index bd0d08bf76bb..9ce99d320571 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5225,6 +5225,9 @@ static int sol_socket_sockopt(struct sock *sk, in=
t optname,
> >               break;
> >       case SO_BINDTODEVICE:
> >               break;
> > +     case SO_TIMESTAMPING_NEW:
> > +     case SO_TIMESTAMPING_OLD:
>
> I believe this change was proposed before. It will change the user expect=
ation
> on the sk_error_queue. It needs some bits/fields/knobs for bpf. I think t=
his
> point is similar to other's earlier comments in this thread.

Thanks for your reply.

After seeing what you mentioned, I searched through the mailing list
and found one [1] which was designed to fetch hardware timestamps.

[1]=EF=BC=9Ahttps://lore.kernel.org/bpf/51fd5249-140a-4f1b-b20e-703f159e88a=
3@linux.dev/T/

>
> I only have a chance to briefly look at it. I think it is useful. This
> bpf/timestamp feature request has come up before.

At the very beginning, I had no intention to use bpf_setsockopt() to
retrieve the rx timestamp because it will override sk_tsflags, but I
cannot implement a good way like what I did to tx path: only setting
skb's field. I'm not sure if this override behaviour is acceptable, so
I post it to know what the bpf experts' suggestions are.

>
> A high level comment. The current timestamp should work for non tcp sock?=
 The
> bpf/timestamp solution should be able to also.

For now, it only supports TCP proto. I would like to quickly implement
a framework which is also suitable for other protos. TCP is just a
start point.

>
> sockops is tcp centric. From looking at patch 9 that needs to initialize =
4 args,
> this interface feels old and not sure we want to extend to other sock typ=
es.
> This needs some thoughts.

For me, I have interests to extend to other sock types. But I'm
supposed to ask Willem's opinion first.

+Willem de Bruijn Do you want this bpf extension feature to extend to
other protos?

Thanks,
Jason

