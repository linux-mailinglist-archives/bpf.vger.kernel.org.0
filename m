Return-Path: <bpf+bounces-27128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D14D88A968D
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 11:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86DC01F22541
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 09:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6355B15AD8E;
	Thu, 18 Apr 2024 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhIKmwmm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639A9225D9
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433534; cv=none; b=V3MPVvc+HMjgepW8yH1b58eUO1O1wz2zXdvGOtktbAIfCYbVfydZZzuwpmBpw3uo8EgjwOYI336DxZIKKXkrUcw6+Wx4pGJP6myRnki9U2LAA0eZaw/pQkgb8m7C+Hv0JQd+7piJnn1vFtWqUY82pMqKLlLaOwVF/ahF/QJo4y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433534; c=relaxed/simple;
	bh=7l+Wo3CYORF9z1u0Mv7R456d3JEzDu4QHcw0HdGMRhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quFoZo8hpZgZYQVNqXUzs2dRuCxUX9CM5V8URLQ5KD0J9Q6qRCV0XX8tYPS+ivVFgXmhFovA0FqkycH9y3lz6rPRttiOswzMqeGU7v9N2euvoEjaQ+lqtxMooIY75pUh+mqNuvdrD/wDTEMadtjACEPK685EcGBtUqG4lhTwjKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhIKmwmm; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so7451a12.1
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713433531; x=1714038331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kDRahY2MpauPyYVEokZE5bAdiJqTUNsb9jMqY0UlP0=;
        b=EhIKmwmmvca/LLtCisMNmOJeTfRvacSCNWFw1vG6zz584Z8CC7irQPxGsR0jGPq084
         zeffplRvT4m947jd3NfUUJ6eacmjCscIWA+Z9uml3MdIsbMThV2W5Eqe0gHWaqzwp1on
         4EkCBPopS3leaESmdVHglO3uhwj2pC0Nt9YdbfQLWKLdkA7Bb2Pr/iy+LUMrc6VaSGFz
         FqOhCrKgP9A1hhVpsBDU291RbyijR1DWO5xRqXOUVy/asjCibtZQHYBg2ZFYszG5rZ3W
         Re7S1f9p7lxR6KNFbj4LUogBnXPzuREbq+OXvHJScdr7eRbfRausih6MpsPwcIqLCTNG
         aPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713433531; x=1714038331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kDRahY2MpauPyYVEokZE5bAdiJqTUNsb9jMqY0UlP0=;
        b=fFWRf2Hhr//eTV4HXbrn3ioF1i14Kg38dMHd728poRt5e8Jbw1ZwMl6Ck3GQlu60/P
         V0rusA19saDhQTOszfy/JE0SnHeCkhAoEznKXKnmFSKwxm5dNH8UvsureZP66g0UtYdx
         XiqcGE9oflQ/UfsYGE4HnoZBbOHyh0ruoyPzCbHJxxdubInUkIATZAo8CY7Kllzcl30R
         FRCTGze+MXRsBQZBvZu5ibh6wyaRaUacMz7ezVtSWs3lBkpp5hWFsdAMF9pFzA6r2dFz
         0CPh5dcJKQBH0AGpLkx1QYCyaRPAG+nwBPy2JavIFSL3V8wrJLMD7ARtVSBchVfWwwoD
         hAVw==
X-Forwarded-Encrypted: i=1; AJvYcCWyXUTUlgwr0ywYtj8DqrhyZvoZL/Zn9lPHUl8HA+pPivMoJMeLkYahbrR2dbImDzN66KwQiFB8P3jD5Ac6pON0Kwhx
X-Gm-Message-State: AOJu0YyWOU1xGguzEUfEwvYWazEBRQEQ94WDq7+tjapORv/xXkfb8VbB
	pdFsqZy2IzCmdw+n05LfC6gAp52hi+0G/GrWsprKhJrV1cdCfgiYrph/u8jKAfUfNJKlux5lnJr
	Z26uhGLl4srAovfXvT+43n2MnW7PC6cujL8PY
X-Google-Smtp-Source: AGHT+IFqScEzF9lTvG3JHYLX/LlUmjjLvCQX6KoWRorR0xEQSFMz6HqIi28QELYtDRr9bSkUsGM4qPzD3pAeZdjY5LE=
X-Received: by 2002:aa7:c987:0:b0:570:49e3:60a8 with SMTP id
 c7-20020aa7c987000000b0057049e360a8mr93401edt.7.1713433530514; Thu, 18 Apr
 2024 02:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416095343.540-1-lizheng043@gmail.com> <CANn89i+TKbGbmy0JJbyhUxQ9Zc_jj=EHv=bYXT5dUvQY7hw12g@mail.gmail.com>
 <IA1PR19MB6545F5F1940C0B326058987ABB082@IA1PR19MB6545.namprd19.prod.outlook.com>
 <3f487ef495da476e5b0564dbb024dca54e8bee10.camel@redhat.com>
In-Reply-To: <3f487ef495da476e5b0564dbb024dca54e8bee10.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Apr 2024 11:45:16 +0200
Message-ID: <CANn89i+d+NSk5VooFn=AHoby5JOJ3=D1oJ1GSKCzp3ZPM1zaLw@mail.gmail.com>
Subject: Re: [PATCH] neighbour: guarantee the localhost connections be
 established successfully even the ARP table is full
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Li, James Zheng" <James.Z.Li@dell.com>, Zheng Li <lizheng043@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"davem@davemloft.net" <davem@davemloft.net>, "jmorris@namei.org" <jmorris@namei.org>, 
	"kuba@kernel.org" <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 11:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Tue, 2024-04-16 at 10:36 +0000, Li, James Zheng wrote:
> > On Tuesday, April 16, 2024 6:02 PM Eric Dumazet <edumazet@google.com> w=
rote:
> > > Hmmm...
> >
> > > Loopback IPv4 can hold 2^24 different addresses, that is 16384 * 1024
> >
> > There is only one Loopback neigh "0.0.0.0 dev lo lladdr 00:00:00:00:00:=
00 NOARP"
> > existing even you have configured 2^24 different addresses on the loopb=
ack device.
>
> Eric, I think James is right, in __ipv4_neigh_lookup_noref():
>
>         if (dev->flags & (IFF_LOOPBACK | IFF_POINTOPOINT))
>                 key =3D INADDR_ANY;
>
>         return ___neigh_lookup_noref(&arp_tbl, neigh_key_eq32, arp_hashfn=
, &key, dev);
>
> So there should be at most one neigh entry over the loopback device.
> The patch looks safe to me, am I missing something?

This seems fine, thanks.

It is unfortunate ip command does not seem to display these
neighbours, for some reason.

(I am about to send a series of three patches to remove RTNL from "ip
neighbour show")

Reviewed-by: Eric Dumazet <edumazet@google.com>

