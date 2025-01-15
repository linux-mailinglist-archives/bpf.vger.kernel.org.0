Return-Path: <bpf+bounces-49006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACF7A12F75
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 01:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7392E3A53E8
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 00:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D6A1372;
	Thu, 16 Jan 2025 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLtUT3SR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A7015A8;
	Thu, 16 Jan 2025 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736985625; cv=none; b=CLBxuYYwXHbQCHS4veeTLGt8kFB26gIHNMbV8b7pZ87Fet0xH/qvL0tUCMydenqqCSYFzyWiYFUiGsriChM9NFfV8fHxoVrgKMmlsfrDvu/fvHVLBhlTosFHfhb0Yl3qw6I7Uba0fx6oZi4cUS0zXtejqCEB8ImFu63rV6hEVos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736985625; c=relaxed/simple;
	bh=BuQUULKf8UDdFcwhDS8sR1olUXjcieQqeL1LvRr0i0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3EQKnaeEKNPzJYfSH5+c9f0Q10P+PnVxXjiFU7/7mOndsTZP8dtStb9K5tObi8doGCNET8ye2MrcyCrwMZKE40+u/mtxvadvPaGoai1+504uNblQJSKWzsCLjKUv4HcLCth4n3ruumDULalNdsqZ5FLVFgWy6vzbls3ylCfkh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLtUT3SR; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ce464e52bdso1255235ab.1;
        Wed, 15 Jan 2025 16:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736985623; x=1737590423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMMiW4eLMBSrtJSHml+CBa5x0/PENIcgFtHuwxz5+a0=;
        b=LLtUT3SRa0L7YImZLWDDGaWsNfdmgXShxqNLVjSgMNL1pOlGTA4ZoG5ftkUHYr/cIv
         HI6r2OsMyt9q4UFQEO2CdI6eXQcf8NPkT0hRI2KOcP5cUE/maJ29K8/2hQkN4XYEhrmf
         IPhUFukTMT40ekG0xLoj+PWCJzOz2WgaHxxk1t8YcRtwl0Sxwz3BUwuJuHGHRBmscYIK
         TSR3nwqzwJyiH3dYuwWKGg+o7pO6dcaRjr7VY1HxNYiZInttBWC0NWz9grdhF9h7p7fv
         ObdBRdX96HE+hc9efngAWx++2MrycFB79ZszREJeL8HTpwEH6e5fJVkgwqDZb1JsdbdM
         +7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736985623; x=1737590423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMMiW4eLMBSrtJSHml+CBa5x0/PENIcgFtHuwxz5+a0=;
        b=vs+jsISBx1ROUQDstzvRWVNWIxTV+vfMYywZlXBOkkEYHrzZdIUqjhEgyWC4gIkYfU
         ftQ8wsY4cWy/Lu/+vWXM3hyY29O5IhH/0Ql0IV7LbYI4p2VF+bgpNyVGxVQWoKLR+F97
         nDFGdyeqLex6ifKUpt7l/fkrtJ8a5f2HPFOwQku+0jBABEA2ytMsrYoQ52G7wtWhi9BB
         Ps9QP9liTgfetAddeCCeKCtwkZiYEIEumPH2xgn4J9g4HzfKe01wYOZHxg0jX/TOEIoH
         kgz0NoaNpp+HPyTkzga+YTP7fGweXQ4jixr6p/z4ZwzEDgCZk3ZMxxeuzHttR24WJ3sn
         SzmA==
X-Forwarded-Encrypted: i=1; AJvYcCUqn6V+PoAmCXJFuYPXSxMGMisxv20w/l5TRICTMl7dQsvjaNAFZQtIwU4jQ44M5RG14au9cTRa@vger.kernel.org, AJvYcCWwenAoc+L/Zszyejkr9ibHqbh5Ve/ogB14lhCfzq0BAWBzsU4f6UFOboeZrVhVT9ECkLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0U8859h79jgsCKE9uDNEy92oMCMcyJuAJ6B3cFXvYZtwiiXwA
	QvkYkK+r4zduBvLPO9X2uK9NHsvsszCmxel/7JF9eEE5/sIqQS63LiTh9K3Ov5ytsfzXbeCy5h6
	PpDY328RZe6/SUYXYTFHv1GePLqQ=
X-Gm-Gg: ASbGncs+B6gjpBPINIvBshA3/KiX84S3p+GLi31MoUIGHfHmnqaYAi+Ml1gCHUu/OFS
	RnXCa5jyA3iRwMJCMp+gE5LSi6VQJe2UHuI7R
X-Google-Smtp-Source: AGHT+IEVYruWFffVVNBSgQRXA0oKghLUArDBhNUMepXFg7keuPiJH+gpRmfsbh3N4GQGC8r7fwNl8ccy5cL15nxzcgE=
X-Received: by 2002:a05:6e02:1d19:b0:3ce:856b:e451 with SMTP id
 e9e14a558f8ab-3ce856be641mr46515975ab.5.1736985623236; Wed, 15 Jan 2025
 16:00:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-12-kerneljasonxing@gmail.com> <8b9b9206-86ce-4d03-86b4-82f378fd0dc0@linux.dev>
In-Reply-To: <8b9b9206-86ce-4d03-86b4-82f378fd0dc0@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jan 2025 07:59:47 +0800
X-Gm-Features: AbW1kvaoBg-tBsHBJt5MSFtosIK8xr5yCzcYU1OSO-J5Q_f9poAuvsgjJqRRGoE
Message-ID: <CAL+tcoBSB44erQZxYtBW0DTOJscyZZCbGDOv6Oc4KqHiF2g=1w@mail.gmail.com>
Subject: Re: [PATCH net-next v5 11/15] net-timestamp: support export skb to
 the userspace
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

On Thu, Jan 16, 2025 at 7:05=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/12/25 3:37 AM, Jason Xing wrote:
> > People can follow these three steps as below to fetch the shared info
> > from the exported skb in the bpf prog:
> > 1. skops_kern =3D bpf_cast_to_kern_ctx(skops);
> > 2. skb =3D skops_kern->skb;
> > 3. shinfo =3D bpf_core_cast(skb->head + skb->end, struct skb_shared_inf=
o);
> >
> > It's worth to highlight we will be able to fetch the hwstamp, tskey
> > and more key information extracted from the skb.
> >
> > More details can be seen in the last selftest patch of the series.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   net/core/sock.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index dbb9326ae9d1..2f54e60a50d4 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -958,6 +958,7 @@ void bpf_skops_tx_timestamping(struct sock *sk, str=
uct sk_buff *skb, int op)
> >       if (sk_is_tcp(sk) && sk_fullsock(sk))
> >               sock_ops.is_fullsock =3D 1;
> >       sock_ops.sk =3D sk;
> > +     bpf_skops_init_skb(&sock_ops, skb, 0);
>
> nit. This change can fold into patch 1.

I understand what you meant here. You probably refer to patch [02/15].

Thanks,
Jason

