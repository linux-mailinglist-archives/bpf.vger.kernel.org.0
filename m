Return-Path: <bpf+bounces-71161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E86BE5750
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 22:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C86547656
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA976296BC5;
	Thu, 16 Oct 2025 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Jdz2QpcY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29FE2E06C9
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647888; cv=none; b=ZqOOkuByO1ksZGE1HYIzXQ5D1A6ee9BDNMBVczig47tQPKWsztNxmbqPGAfxN/BfHY9lPzCU6mAjCoFDyUrJwVVIkQX/cSLOMgJfni06jx3e7rJWhAqq7w8AFvo4pqO60c4MeQuAvRU2iO1IEhHkqxBQxJIntOc0bXSb6ik8nJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647888; c=relaxed/simple;
	bh=ZnvMvv3Uyc9J3C8aWBzZjwlgOw6eIgWOGxBQRkiX5pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBKR7HT9n7nQnVg/gvhS8jn2BrDjcGoVRyBB75GuErpboldJeCAuV79Tj7TE9rI5nxjz6C2W2tTvtL2o2jo4/wBrBTUvcKAv42otvEHvyRn221p11fzeqFKbSQOUnpeD3gQW4UHUGPvPdoerImFu3YJPh7HL44cYxbsY037O204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Jdz2QpcY; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33bbc4e81dfso1047127a91.1
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 13:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760647883; x=1761252683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3slFqNAkYoyM4phFl5MHIcyAdrPRdCqrsNsGFA+mZ0E=;
        b=Jdz2QpcY4OpiPz3kkXPLHz+stKntk/gBksswr+3BgEjD5xsnx/mCjFzes8rHkvvygI
         MDPQ9ykYU6Rz2G+Qe9zqf0RZNpGxlWd5kk7IQjzoQA7rSPDhZtrcgohKo8Ba6tUb1BP8
         mUo96v6IzNns2GlDRzCpDjdoqVtWa3yT2NKNcNjsJfwedozmGu0ec1gvZMAlf0M5RgpE
         X0psJolrWqGC5CAhNR0FiYS5ilfXzYYy+8iUCwC5/yqe01SL2fFR9ztXEvcXpwqSLo4W
         gmbXemxzV6wFll52/AFvT612vZmjSD0lhLWVo4fHqrNgs4nb8dnuY/5Mp1WU4NM95WRQ
         a8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647883; x=1761252683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3slFqNAkYoyM4phFl5MHIcyAdrPRdCqrsNsGFA+mZ0E=;
        b=V+pnMT1mbFnvY5J9Cwbb29zHqS79cKS4ere0eBElDDtBNLHS1KxGWYRUK0rBESmeAF
         0+D84Y0OiYSd6yBzDHl3Mkis0tTSWXDjbN/PHELYAzd6WEB2iakqKZqxgQQRo3sb6y3t
         VxZTq8FkVTO1SfMfwxEjNuc9cvKGXjxv2aHFgL1LUDDCH6Hhm9XzKprA2rnqyMJ//IV4
         L8AVRAyBWc3OdiBqt26In3uOTO83oLHIIQLYsJX/AybBa6wCFKhYcVV4PlCSt4z2e5wx
         YzwacPmV5Sj0gGlw/pP7evIOA8rWCDFB3+NDKACm6Mb5F1pls8Iu+BB24Hm9xC8dp8AL
         x+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVmom4wKOTCYfQjQvFgvPqoB8ghRqH0HXVOePecWHitcyd/clZq7iL8WwKlyUS7eAQvHpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBEColqhP62Ee6Ev4DbvSU+oPN2KuaEWuyhfuBOb0c/RgYYMVL
	T0RD97L01sk2LMf7r83noPjlnDGa1TQ28ANujKMeu3ZHA6N0bEZPkHiGdWOSIMRoaXDBoxcGKzG
	j+Myrc+yheeeadstU+vSuV8nVwi9T2GOxNnTHEv5N7atbV+psvjoqUA==
X-Gm-Gg: ASbGncsRjECOTkHthRJvT3N0LEaKNQf/v8+ZITs31W+5BzgwOwEbsz7l9iNc945Xfcp
	zAyqQ6l5r1kwfG+Mq7/Z4lMxeGbEnJ2jyDosZos1dCzqi4Pu3Ov9IhNJ1VUDdXZnYYR/IzkwU7v
	i6JDc36VjcGOhPadGiSXSIt+9+RX+42sv06tvB/dAJyocdvPunoFgJKwh9ycrQhqQDLOW1O1xDA
	5HC4wDIgTHZ4pDxazkUaJFtzU96gnZ+2mfh82QXhIi7NEjEuf6HRpmJsdgxJLDNAH8bEw0=
X-Google-Smtp-Source: AGHT+IGFIpKOlM2KUWDCAFw2XNXedYO+QecNe/SHAxRhF4qF1dGBt4GgYLt1H/17WGv0giFrM1LZJhri7d5LlfFp9Ws=
X-Received: by 2002:a17:90b:2887:b0:32e:5cba:ae26 with SMTP id
 98e67ed59e1d1-33bcf8fa1aamr1286108a91.23.1760647882993; Thu, 16 Oct 2025
 13:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
 <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
 <CAHC9VhR2Ab8Rw8RBm9je9-Ss++wufstxh4fB3zrZXnBoZpSi_Q@mail.gmail.com>
 <CACYkzJ7u_wRyknFjhkzRxgpt29znoTWzz+ZMwmYEE-msc2GSUw@mail.gmail.com>
 <CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAmuuLT_i--GskQ@mail.gmail.com>
 <CACYkzJ4mJ6eJBzTLgbPG9A6i_dN2e0B=1WNp6XkAr-WmaEyzkA@mail.gmail.com>
 <CAHC9VhRyG9ooMz6wVA17WKA9xkDy=UEPVkD4zOJf5mqrANMR9g@mail.gmail.com>
 <CAADnVQLfyh=qby02AFe+MfJYr2sPExEU0YGCLV9jJk=cLoZoaA@mail.gmail.com>
 <88703f00d5b7a779728451008626efa45e42db3d.camel@HansenPartnership.com>
 <CAADnVQKdsF5_9Vb_J+z27y5Of3P6J3gPNZ=hXKFi=APm6AHX3w@mail.gmail.com>
 <42bc677e031ed3df4f379cd3d6c9b3e1e8fadd87.camel@HansenPartnership.com>
 <CAADnVQ+M+_zLaqmd6As0z95A5BwGR8n8oFto-X-i4BgMvuhrXQ@mail.gmail.com>
 <fe538d3d723b161ee5354bb2de8e3a2ac7cf8255.camel@HansenPartnership.com> <CAHC9VhSU0UCHW9ApHsVQLX9ar6jTEfAW4b4bBi5-fbbsOaashg@mail.gmail.com>
In-Reply-To: <CAHC9VhSU0UCHW9ApHsVQLX9ar6jTEfAW4b4bBi5-fbbsOaashg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 Oct 2025 16:51:11 -0400
X-Gm-Features: AS18NWCQabATt66LFXD87ybMXRR70yXNmQjQY1MqvhEq_Lvy7iGwxN8QWoiencU
Message-ID: <CAHC9VhTvxgufmxHZFBd023xgkOyp9Cmq-hA-Gv8sJF1xYQBFSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	James Bottomley <james.bottomley@hansenpartnership.com>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, wufan@linux.microsoft.com, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 10:12=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Sat, Oct 11, 2025 at 1:09=E2=80=AFPM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > On Sat, 2025-10-11 at 09:31 -0700, Alexei Starovoitov wrote:
> > > On Sat, Oct 11, 2025 at 7:52=E2=80=AFAM James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > > >
> > > > It doesn't need to, once we check both the loader and the map, the
> > > > integrity is verified and the loader can be trusted to run and
> > > > relocate the map into the bpf program
> > >
> > > You should read KP's cover letter again and then research trusted
> > > hash chains. Here is a quote from the first googled link:
> > >
> > > "A trusted hash chain is a cryptographic process used to verify the
> > > integrity and authenticity of data by creating a sequence of hash
> > > values, where each hash is linked to the next".
> > >
> > > In addition KP's algorithm was vetted by various security teams.
> > > There is nothing novel here. It's a classic algorithm used
> > > to verify integrity and that's what was implemented.
> >
> > Both KP and Blaise's patch sets are implementations of trusted hash
> > chains.  The security argument isn't about whether the hash chain
> > algorithm works, it's about where, in relation to the LSM hook, the
> > hash chain verification completes.
>
> Alexei, considering the discussion from the past few days, and the
> responses to all of your objections, I'm not seeing a clear reason why
> you are opposed to sending Blaise's patchset up to Linus.  What is
> preventing you from sending Blaise's patch up to Linus?

With the merge window behind us, and the link tag discussion winding
down ;) , I thought it might be worthwhile to bubble this thread back
up to the top of everyone's inbox.

--=20
paul-moore.com

