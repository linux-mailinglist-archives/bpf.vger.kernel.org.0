Return-Path: <bpf+bounces-42115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8D299FD56
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 02:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07A91F22AD1
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 00:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C05DC8D7;
	Wed, 16 Oct 2024 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOMxMDrl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415E021E3C5;
	Wed, 16 Oct 2024 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729039564; cv=none; b=C821NgVx61f9nfcYWifaz03WFjPQI7z63fOVVy9XELnXKfULazm5mI5tlaGrpzu3JPSYVfaXPUj8MrBZON0+exQYuanQwHnsLAzWv89Qt3BuFC9UWuVrRn52K5CpzXqDVNAVU4WmKCzDNYjvSTrXntBT0j+p+gR1hofmajFschE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729039564; c=relaxed/simple;
	bh=a0JCHUe4pKZkx4NXe1jZJLJ5vcaceEw3NqIRkV4Phm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=as8/FrLQkFBtTuAsOhbhxuevUz9tq6PVE9Slt0cckOaSA/byGZE9wPxDmyTBwXtEa9jy4ldv4Zu8k3rRPY/rDUBoh0SL9F4c+e6tXKczW6OvqT9oRQX9HU/l2WeqEttLxjjAfScAt5+Jw6IASHQRZ7CGTh7LO9323wTVc6lYDQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOMxMDrl; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a3bb6a01eeso16634465ab.0;
        Tue, 15 Oct 2024 17:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729039562; x=1729644362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83f2oW3n/pBQyAUAhZcjT5TriAgaIyaUe34hO7f5lwE=;
        b=fOMxMDrlaB0csE6WZM7xaR871LOXPUOkKxd9n8p5R5dJRizaTX1lHFTFnMGH4kv/QC
         smmLIUA/RF5AK1JsoX+kn/cIPcu3t8tlxk7BbxyVapST8smT+FlLTpeCd5tZyfIptjQL
         37O1vlLygrzR4+XucTNNopHLQ33eBqqEdc0WW8/iklS3lzUWP3Vjtzm5/luiV5rSM05N
         3rEH6SaWEIB26HhS7ezAq8Rlo73BiALmW47F2Vp+5hcnqIG7lc3YXTgU6e7rfORl5NuG
         orfarWgYny2GqHdf2ssz5h8TqWWLV0qZC3OC8+a/rO0k8PuTRpYGxHBL2J3DXOW4CzlO
         ytag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729039562; x=1729644362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83f2oW3n/pBQyAUAhZcjT5TriAgaIyaUe34hO7f5lwE=;
        b=kooH+y2PxDuer9odvh5Kit+eOHjdAbClFPtKPWmluxfZtJA8xNhKvUUU7OMTnjpfRL
         3Trz5KoD7fzAGQ2ZtqBKZzXDaOFK/inQtqGQDHaeLZsWOfPQHVg2ZctqFpnisyMKxlNV
         ljNgFKrf41ayozZNdWxoMsfS2nKv4RT19c4IW/LKDQzE9vl0UKtby/4k5WWKU4HL6oKG
         aKqNruwTBWLt18NuIlTXwQlK3mC9gcZIjum/zcbkivveaViIxERZHP5/+QjCcT0GcCDT
         i9/VHyxqLRA9IbvBZEH5OW7gQDPSi0J5LgowBSqoUph6xwgbtdL8logyVU7/YW0+f3vb
         Nt/g==
X-Forwarded-Encrypted: i=1; AJvYcCUfEhG8yUmQV6jlGbtF3ykUfLGAzf4cLhn2ecKfRGcGNBSPpuGtNr49bxnK4QFjHAOhIs0=@vger.kernel.org, AJvYcCVLKVxXGeyY50KyLoM0loGNL99Y60iC2ah3hqWcEcUBodrtMH1/6L8mKYV1/x2xSV2OghFEeU/Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzN62Ep5t5yHSgiqPFowzJJV6eJ7Pky92Zpc3V8YnoNLed/pZcc
	2+1bEdpPbUGgIJsIWJNVT3ytafYsipOdyky+MEJ6LI1hbBQIOxLo1b4mTjvkH7XvOToxOzHeEDE
	4UGfW/cD1/nVNKRtWo4mkT0HpuoQ=
X-Google-Smtp-Source: AGHT+IHZ3PLnOiH0J357ky1EL3K0IzTUMlUu/C3MYiZ9vVEdpJWEgt5G8xLe8YCVCBs3c+1OMOyP4iIE1mGQo2eyNvc=
X-Received: by 2002:a05:6e02:1e04:b0:3a3:3a5e:a337 with SMTP id
 e9e14a558f8ab-3a3b5fb654cmr144806915ab.16.1729039562338; Tue, 15 Oct 2024
 17:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-3-kerneljasonxing@gmail.com> <cb96b56a-0c00-4f57-b4b5-8a7e00065cdc@linux.dev>
In-Reply-To: <cb96b56a-0c00-4f57-b4b5-8a7e00065cdc@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 16 Oct 2024 08:45:26 +0800
Message-ID: <CAL+tcoAE2NY4zFAS-_nk9ZX1X52Fvh4K2UJr9rawHo3jgLFWsw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/12] net-timestamp: open gate for bpf_setsockopt
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

On Wed, Oct 16, 2024 at 5:33=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/11/24 9:06 PM, Jason Xing wrote:
> >   static int sol_socket_sockopt(struct sock *sk, int optname,
> >                             char *optval, int *optlen,
> >                             bool getopt)
> >   {
> > +     struct so_timestamping ts;
> > +     int ret =3D 0;
> > +
> >       switch (optname) {
> >       case SO_REUSEADDR:
> >       case SO_SNDBUF:
> > @@ -5225,6 +5245,13 @@ static int sol_socket_sockopt(struct sock *sk, i=
nt optname,
> >               break;
> >       case SO_BINDTODEVICE:
> >               break;
> > +     case SO_TIMESTAMPING_NEW:
> > +     case SO_TIMESTAMPING_OLD:
>
> How about remove the "_OLD" support ?

Will do that. Thanks!

