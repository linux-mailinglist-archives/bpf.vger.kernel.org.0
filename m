Return-Path: <bpf+bounces-50337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E63AFA26870
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 01:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EFC3A59B7
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 00:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFEB9476;
	Tue,  4 Feb 2025 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCT7ysUL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D20027456;
	Tue,  4 Feb 2025 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738628433; cv=none; b=Y5B2DIoL+myNievxcakPvQQEX6cxRm54889l9jqXnv9TVVgL7BfZlFxMhm+Oo7E1hFci7Cu2RK5nAZHTkItLp0z3MbBeXiXhpa7xcPwPlrsRP7+BSOly45I3Z0cDbZ0tAoWhGkFook7zRAB/5Ms1EDRaGOwXRSyeX2zhiI9OvwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738628433; c=relaxed/simple;
	bh=STtq33ta4bEsqsI5UgFP9VMsgX6krD4EJB+oHjyFi7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrC8MYr6A+5dkZns3Q64VWCYA1bWixNMFv19J8MlCklAH1NHucdqN6xtV2o9YP4jqYqgl0Gyo76uM39rosadsLnz/uYxu0NNsKkkjMxP53hY/uGJAzP0OQVo25KF3X+VsvEFXXAv6rKfIR0RI0h/mDWekCx3d6Byj17gUfwiVkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCT7ysUL; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso14819605ab.1;
        Mon, 03 Feb 2025 16:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738628431; x=1739233231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxmW4Y2+wOmylyn5P7dlnLdORXbzWfEJhbDwSFBnIAI=;
        b=kCT7ysULP6qlrM+b2NOu+Yu4adrojZNNB/77NuQ/UEkPrKokdGK9qErwJ1Qge/tjvY
         BioD4EimDXDFtSgJM6dQhJIdR4cXJSi7UAJNQ57Imv3uIXwiPyOdjvxV8pehwYcQXeGG
         Mbi+Mum8p7lVyFDaG/trAKSGSPJel5f3GBW1sS8lW0LzZBTrNp3rfVtmaWxKRImMCV8F
         BKi4WpAQjgbypjK7JWT77++8ihMCkSCbg2EoL7eQi5rN1nqJUIyWUf0NJO+sGoDZGEXj
         T6hFMYU2lU9Wp3uyhLeVRV4fnTXs+4jkJjABGVy3Zq2Czf0FJHCnSJjdZxnlMgD/ZFRF
         pNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738628431; x=1739233231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxmW4Y2+wOmylyn5P7dlnLdORXbzWfEJhbDwSFBnIAI=;
        b=ZMLkZLg4mNnNfvB6pLomLyYwKCrvmhh5AP+nOXQ6KDAlsnMfQXKSnCldEHu/JxMbAs
         3pY/n0cWK7lInrqDBo2gW70Nx5QSsyseUIFveUfP79SfBzqCdJ9aF4id06KD3lXtVsZT
         F93MrROqOz07Y+F2g64cyzQdXW3jbJjcZ6d+XCL/BXc9EC12Jr5WRYOGQKsSKUsZ/7yj
         sgoLQ8nlLxbaFT+kfSo1BdfOj+9IrND+iivNk4YbfdtMOQ16lxM8gvIb3PazI4wj0DdH
         f+MdHcvMFlfbI47B1MiLGh5gtsKxtuDsXVYNSvRhwT78XlcsUfUdA2/NQNyQ3gO68/FZ
         fzRw==
X-Forwarded-Encrypted: i=1; AJvYcCUR5JO17Eixumr/XZ65UecfiB39VBmnwZdAkkPdOuuo1dE6fqmgV6jTfx9Tlq58IMzQYn0ZKeT2@vger.kernel.org, AJvYcCUnFyK0FSN6U5aRqdjMHgl3X7TE9+r7lpb9wN4BQjru8k3OXpq/KKZdHEI1W6IEBa0+MK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdRHooBsaeeGkyBYvCqcdKJxSLklEEA17j6Z+xS+XUuPX92Egw
	0iu+my6nsTJp6H4ZHzYKlA3wX4Gshf+PeMP2/ym3uMXlupPxKdmKd3+I3K9u45zzGe2dW+kiRcn
	XEUFxR6ThGyNGcPmuT1JiVhC+XPk=
X-Gm-Gg: ASbGncsDzorDECYmW2yEbd8vO7Cem4EL+S6cHCEgBgeSUCqgaVyarWHAXsookho+OAz
	nUDKxY5cvhJiUzCBhFEQ7veOmzYDx/bfvB2H3p+plS4D3Wlhhox48Fu5dz/kEY1LD7EnhITiY
X-Google-Smtp-Source: AGHT+IGxgTtWRrw2PnhuY8Fcwym41F1DXW9WLqIdNWtmF5t5YQyEsuvKGTHGWnXrrt54IGjKYmgTjakhH6h/rYoMtww=
X-Received: by 2002:a05:6e02:3789:b0:3d0:124d:99e8 with SMTP id
 e9e14a558f8ab-3d0124da53emr123648135ab.13.1738628430413; Mon, 03 Feb 2025
 16:20:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-7-kerneljasonxing@gmail.com> <2097d7a3-97f0-4c79-8f82-aa7e2b7d9d2b@linux.dev>
In-Reply-To: <2097d7a3-97f0-4c79-8f82-aa7e2b7d9d2b@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 4 Feb 2025 08:19:54 +0800
X-Gm-Features: AWEUYZleHSm7zkiMLx6jYNiRa6_1bVsT3cAFIc-w-tN0I_6DSTsVLMGmwAmJrDA
Message-ID: <CAL+tcoB5AVYkHu74VN+Xsiq=Lu-H=9q5qFEr-331T5YV8OfThA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 06/13] net-timestamp: support SCM_TSTAMP_SCHED
 for bpf extension
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

On Tue, Feb 4, 2025 at 7:23=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 1/28/25 12:46 AM, Jason Xing wrote:
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 6042961dfc02..d19d577b996f 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5564,6 +5564,24 @@ static bool skb_enable_app_tstamp(struct sk_buff=
 *skb, int tstype, bool sw)
> >       return false;
> >   }
> >
> > +static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk, in=
t tstype)
> > +{
> > +     int op;
> > +
> > +     if (!sk)
>
> This check is redundant.

Thanks. Will remove it.

>
> > +             return;
> > +
> > +     switch (tstype) {
> > +     case SCM_TSTAMP_SCHED:
> > +             op =3D BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> > +             break;
> > +     default:
> > +             return;
> > +     }
> > +
> > +     bpf_skops_tx_timestamping(sk, skb, op);
> > +}
> > +
> >   void __skb_tstamp_tx(struct sk_buff *orig_skb,
> >                    const struct sk_buff *ack_skb,
> >                    struct skb_shared_hwtstamps *hwtstamps,
> > @@ -5576,6 +5594,11 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
> >       if (!sk)
>
> It has been tested here...
>
> >               return;
> >
> > +     /* bpf extension feature entry */
> > +     if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
> > +             skb_tstamp_tx_bpf(orig_skb, sk, tstype);
>
> ...before calling this.
>
> > +
> > +     /* application feature entry */
> >       if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
> >               return;

