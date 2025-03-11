Return-Path: <bpf+bounces-53785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2998A5B817
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 05:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38EDA1892D7C
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 04:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EC61EB1AB;
	Tue, 11 Mar 2025 04:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5RaPE50"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CC51E3761;
	Tue, 11 Mar 2025 04:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741668673; cv=none; b=JkKg5c7o/aox4bnufg/2vldH+zywi71DEDo3N0MugK3pGbxZzYvv5ICBQcEBD+b3IOJBsc2eZ6ZlxOlWSCHmN2mnLwoNzTguA+SmKErTXT596IJWdhidGQFpb0DP3EoWk8/9W4uH8EUvQC/J515jxzxKRRt6KNQTs0MAO0YCqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741668673; c=relaxed/simple;
	bh=S4UMlBtzegNqR38x6+Ww6MPoakw8lUHi6YVOtIzT3w4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpbEI8o0kSDK5ALS0yvLvzfUzKJ91Skoxq027LBvKVJuoQyW4sweeYy5QokKN2pH5B4ugzm8fI1n5Kv1NqWnzT8BYyGHhcKbvZiKpX9y6LXc4qLsuVnTXgYgcxkN4ZOGXuKf1+Pa5gZKbV1WHi0FjsT9L8sDovI0VxXUL3QCXSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5RaPE50; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3cfc8772469so15097425ab.3;
        Mon, 10 Mar 2025 21:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741668671; x=1742273471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fC6YaNTXfEJ0j2TMC96dXUs8okBNqaxSup+zuIKQHw=;
        b=U5RaPE506DARIvfY+ps9AImJ+lxaCHWvmM4zLJLjD6Uptl6zMzC/wr8Zvh7nptB2FU
         TxtCOwgyRpvI2MhY4WJzTX5c47mCmw25qlOsAr04P2pOmNKXjah3b26siVr+M0mOdqjh
         SOg3MchotmBO7EsOCIsDlnNt5tPQ5Q+mHTWxoV3cEMp71PqBTSHgoK3CXL9rVZHw7cUV
         CeywI5DEX1mlfv2G5rgkqNW4nI1WYLos1R3Ms1/KM+Ua9ZlFRRmZleTEKqBdMPwfPPRX
         qjyIK9q57o/0d7nJMgjDZ2CNrT54WHGJLkciORFupyBxPqzShj2G/Fg1XgKRbLatn7kh
         6Z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741668671; x=1742273471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fC6YaNTXfEJ0j2TMC96dXUs8okBNqaxSup+zuIKQHw=;
        b=ErjuihnS/ip3I9TobubYYKOhtg4J6Y5WC6Zk1FmzzyMntHU+OE4YRlPKTx+YoHzBHp
         dgK9Gu9CCWfZuc8GHdbdvRmHXEqXEqUs1BEPKL1Zvph8V6fmdP+P90lNn0RxLMbvlbBq
         c3jrSiMJ5apdtADP3iRYPrbDgQJIZ7pXu6v8BtOr/WWcubpQx/KBevUE/76mrtY3rcso
         y5EWpdlG7rzEL8BL6mx88nQWzkp1sOicQC0KmhyE6MiM5HwBukvRKoRgZ8XKicKpZ+CT
         L46Q67sOR5vuw1BSW6a5N62op8no0pPhz2ak4g99eU2DOsTgv2Zu5CFEfv9ItCZ9JiZ8
         gjHg==
X-Forwarded-Encrypted: i=1; AJvYcCUaQiDWhwtgtoNXH+b1I92KUwFrwPD/qTwdeGYmT8q8zp9uFryv4qWEMzdM4kpFUaUm7GQ=@vger.kernel.org, AJvYcCV829ZOVBNO2OZfmZXRLIyTJuv0Ge/Y/fvw8Gkk19nky9mLiE/DGOWYjyAYTLgklKnqEULK+ug8@vger.kernel.org
X-Gm-Message-State: AOJu0YxI2YaF1F43OKKBqydUB8YO3u2TXg1PskMk+cy1hzpRxCgA+Qv2
	kgPdy4bHypRdz4CxkupUCYVhPeT9Jge1KxwEBVtJ2fwfkd3sQa6bjtolo01GPTHkCGBQ9eU7YXM
	ombGJIoIKRF/jQNrMTA9ttHqTn4w=
X-Gm-Gg: ASbGncsEMaCpZSV4QzDEfxivC5FKHqncI+4OWyDL4juzQD+bQwCV99QO1pDAtvkqrgM
	UhcJ6tfhuDB8DcEntgRK39MQmhVPyjgn2wsbz7G939wfoIABBHcAq6RsSVacE3+0n/7iyQGfAIt
	1PpMKvFX1ciOc4whd3yBze2X9r0vq9tDz2gAFN
X-Google-Smtp-Source: AGHT+IGnSgwVv0xW3dTQAhpj1GZtK9KavxBSsZdUgK39tdTqWu8txzc9yuXy1yDzMJaSwvHJiRiGjaUmDq/v7TE4pBk=
X-Received: by 2002:a05:6e02:180d:b0:3d3:dece:3dab with SMTP id
 e9e14a558f8ab-3d441958156mr197978095ab.1.1741668671353; Mon, 10 Mar 2025
 21:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309123004.85612-1-kerneljasonxing@gmail.com>
 <20250309123004.85612-3-kerneljasonxing@gmail.com> <4c5e97c4-2311-4a4f-9340-5e4a1c7d0e2b@linux.dev>
In-Reply-To: <4c5e97c4-2311-4a4f-9340-5e4a1c7d0e2b@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 11 Mar 2025 05:50:34 +0100
X-Gm-Features: AQ5f1JpxQ8pYTOrQXiTKXRlpQ8ZpgMyGARKjEhVEpVkj3vpXmxW3pPplU7mEL8A
Message-ID: <CAL+tcoA2cJLR-YRU3JNUr5F3mSy2Ne2TJEHZ_CsJWdukEVrLkA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/5] tcp: bpf: support bpf_getsockopt for TCP_BPF_DELACK_MAX
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org, 
	kuniyu@amazon.com, ncardwell@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 2:21=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 3/9/25 5:30 AM, Jason Xing wrote:
> > Support bpf_getsockopt if application tries to know what the delayed ac=
k
> > max time is.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   net/core/filter.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 31aef259e104..5564917e0c6d 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5415,6 +5415,17 @@ static int sol_tcp_sockopt(struct sock *sk, int =
optname,
> >               if (*optlen < 1)
> >                       return -EINVAL;
> >               break;
> > +     case TCP_BPF_DELACK_MAX:
> > +             if (*optlen !=3D sizeof(int))
> > +                     return -EINVAL;
> > +             if (getopt) {
> > +                     int delack_max =3D inet_csk(sk)->icsk_delack_max;
> > +                     int delack_max_us =3D jiffies_to_usecs(delack_max=
);
> > +
> > +                     memcpy(optval, &delack_max_us, *optlen);
> > +                     return 0;
> > +             }
> > +             return bpf_sol_tcp_setsockopt(sk, optname, optval, *optle=
n);
>
> There are three TCP_BPF_* specific optnames supported by bpf_getsockopt n=
ow.
> Please take this chance to create a bpf_sol_tcp_getsockopt and refactor t=
he
> existing bpf_getsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS) support into it also. =
The new
> bpf_sol_tcp_getsockopt can reject the TCP_BPF_IW and TCP_BPF_SNDCWND_CLAM=
P.
>

Will do it. BTW, it seems then I'm supposed to target bpf-next net branch?

Thanks,
Jason

