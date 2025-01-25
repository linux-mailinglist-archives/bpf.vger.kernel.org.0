Return-Path: <bpf+bounces-49727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A8DA1BFAB
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 01:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BF31887DC8
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 00:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A5A15D1;
	Sat, 25 Jan 2025 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNeqa31l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A158800;
	Sat, 25 Jan 2025 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737764946; cv=none; b=Q6cvXSXzhmYrilBMr7yuuQUXUnpyNF++LqaD2eeh5tYg6lSBoB2AIDUpz1I6+7S2cSjT0Oxb6P9/tQ/xTmsam3qHZM4xd8ouUMrFzqdC1/hwKg4R1xLuHKdEg5sKPo5g1AoL8GwIfCdAWE/BxiTi22Yha/Xd4nny0NRPngdDEP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737764946; c=relaxed/simple;
	bh=rZtOQIaOEYboESGvLF8rJs2woTvljCCjqikF9UX7zZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fyl5xMgmkRJQ4Bb4sIA7HcoznRcPwaFF8snz3upvUyiFCAFMLC+OPBFcuAY+kEjrgIcUPhk/YapS0tIfRdLL92c5d7ie8eTtT1FWIyGo4I5p0pn/9M20fdTqDAiD5dFk7vcR95JH6DOIGaJSOebVix11zJq1m5c5FSxVmAlqS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNeqa31l; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3ce868498d3so8003025ab.3;
        Fri, 24 Jan 2025 16:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737764944; x=1738369744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dqp6+gXG+c9UzhibAprENyabnqAxSlbnCSEqSx8bH/o=;
        b=bNeqa31lp3UPW11CuBUeMnBnn/9sqJxp7Oo+pt2vl9q+w9ty5WxoP7ysqCWDSsZL1+
         9VxxxApVtrXE7V055rmZdTmBMvArdxkaA4XSsHt8oSXfDCdDWn8VUEq+qZ7hR+c9VxfW
         +ASaJK9k+m+dVkotKLw70efpo0bFrabyYp+dEcad1k0NCMr6wTXNfRNwjx6E6dzPal/d
         6Dt+jvfMpSyC6z+F3o8+rcD8y2ld8InJTH785741TivYnOTEFizbWGMjMEOj9/eUXjgL
         WCIfMT7zRjcXiKLAVHZYVkSklXqCq285xVm0kKh5L28Qonf8Ws7bIkey6hDyHw1Sb5v0
         Y89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737764944; x=1738369744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dqp6+gXG+c9UzhibAprENyabnqAxSlbnCSEqSx8bH/o=;
        b=ViyYnuq+cqjBpZ28V0xOjOSpR9jMQfip9GHgfdGJ/XAluCIOmd7DBVjrit8/4RpODx
         exsXHv/Qwi1Jfk/3NJb9JfkeGbim4tgPzc1OrCRIoVLjn2e9oza/EmFsX2M3PU3xzgx4
         FavI42uJ5BZSgdhhIlp6EXFJAFnEytynjks7rf8Q9lgc+gZ4YZ7jehMPYy9O2xkJxgRF
         OiJOoCeTpwImYpF2FMz17MqZgh/Uy8564XUGdg8UkT0jJoRwh/oXw73arcBL25+mo+xZ
         OftPsTVBKOJ+r84o5Mld4pJgzO5mxVIHAtdeC5qnOE0XEuu7Wsq4hI2f/vDkhpdxGFX/
         TeCg==
X-Forwarded-Encrypted: i=1; AJvYcCU9ai650beie7uI0tFbIraHIjmfDBScZEJQ2ckhK9mk8MuqutvxM6+eA5gimaeHlKCBGPZNDPP1@vger.kernel.org, AJvYcCUn45DsnWQ5lBHeZoOd9thNEFnVlIlwepkSo7ylrkjTUF8VzvlReIlYaI41qnc9JZluAFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzibmM4RZ9T5NLx4jjGvI9h/08K7q6zdXfTiEUCZckH8ZR3C7NZ
	8aPq8NW2bx877syJCqeOA3yz5QlIF6AqZSlAwKDIypZ1DZx5gVBaQQ4uPlbksPDetC4ZLvhK3bx
	/l6W5J8Ddmm8WB7oCbdQNmcJxTMYjVw==
X-Gm-Gg: ASbGncvxZLVopHT9EHshSS3PRhhyp8Ft8dKGLVQPCNj7mYsSjkUN5shSJJeAislwzkc
	4hi0uQue1X9hbnepyiiz4auA0+xFQWLO3Mn4BsyiLGTj3Ji38/NnQcPNVTndbqA==
X-Google-Smtp-Source: AGHT+IHq84Kz5ZPzPeoyN8anjYDpx3ZCB57rkUSfLR5G1+nYRwX1B+YHGotuQ1Yh0qgzmSqvQSlH6nQagFOVIz27vRg=
X-Received: by 2002:a05:6e02:1f8a:b0:3cf:cd75:574b with SMTP id
 e9e14a558f8ab-3cfcd755848mr28981205ab.15.1737764944366; Fri, 24 Jan 2025
 16:29:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-4-kerneljasonxing@gmail.com> <e1440d0b-4803-49b2-ba17-b9523649ca8b@linux.dev>
In-Reply-To: <e1440d0b-4803-49b2-ba17-b9523649ca8b@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Jan 2025 08:28:28 +0800
X-Gm-Features: AWEUYZmTNqd8D-3Thv96QKOuvoEGj4NeHILXx54xC9JHonkG8UoskgubbuQEjvo
Message-ID: <CAL+tcoB182=QS0hLN9_ihf5Fcivr3BHuom8rrm+75bjpgC___Q@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 03/13] bpf: stop UDP sock accessing TCP
 fields in bpf callbacks
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

On Sat, Jan 25, 2025 at 7:41=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/20/25 5:28 PM, Jason Xing wrote:
> > Applying the new member allow_tcp_access in the existing callbacks
> > where is_fullsock is set to 1 can help us stop UDP socket accessing
> > struct tcp_sock, or else it could be catastrophe leading to panic.
> >
> > For now, those existing callbacks are used only for TCP. I believe
> > in the short run, we will have timestamping UDP callbacks support.
>
> The commit message needs adjustment. UDP is not supported yet, so this ch=
ange
> feels like it's unnecessary based on the commit message. However, even wi=
thout
> UDP support, the new timestamping callbacks cannot directly write some fi=
elds
> because the sk lock is not held, so this change is needed for TCP timesta=
mping

Thanks and I will revise them. But I still want to say that the
timestamping callbacks after this series are all under the protection
of socket lock.

> support.
>
> To keep it simple, instead of distinguishing between read and write acces=
s, we
> disallow all read/write access to the tcp_sock through the older bpf_sock=
_ops
> ctx. The new timestamping callbacks can use newer helpers to read everyth=
ing
> from a sk (e.g. bpf_core_cast), so nothing is lost.
>
> The "allow_tcp_access" flag is added to indicate that the callback site h=
as a
> tcp_sock locked. Yes, it will make future UDP support easier because a ud=
p_sock
> is not a tcp_sock to begin with.

I will add them :)

>
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   include/linux/filter.h | 1 +
> >   include/net/tcp.h      | 1 +
> >   net/core/filter.c      | 8 ++++----
> >   net/ipv4/tcp_input.c   | 2 ++
> >   net/ipv4/tcp_output.c  | 2 ++
> >   5 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index a3ea46281595..1b1333a90b4a 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -1508,6 +1508,7 @@ struct bpf_sock_ops_kern {
> >       void    *skb_data_end;
> >       u8      op;
> >       u8      is_fullsock;
> > +     u8      allow_tcp_access;
>
> It is useful to add a comment here to explain the sockops callback has th=
e
> tcp_sock locked when it is set.

Got it!

Thanks,
Jason

