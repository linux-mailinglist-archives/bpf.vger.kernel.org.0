Return-Path: <bpf+bounces-71239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE71BEB252
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 20:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A963919C7CB9
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 18:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E7B32C928;
	Fri, 17 Oct 2025 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WP0zGgla"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCD32E1F02
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760724205; cv=none; b=V+aiqNfWt4lUh4JLsxN8j/Bm5y5EXfhBdP8hlazjE9GF3Rm56wn/N31DBNDN6BHXCfgXotKlniTFFQwts8XT0XPhrmdYoyfUCPs0av1yXxH6X+pIAoQGxLfKMaPNgrQH95PDyjS9MfeILBQlNmq4bstyyuGxbRn2PAFiMGHUUMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760724205; c=relaxed/simple;
	bh=hrY6WFUlSMAp+P2NK3uStCwS/x9y5KC5Ht/lCDtODdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOASjeti2eacL/wDqNW5s+Bw8OuH5VRLJyrMgwrQyFKekKn1SDJq0G7ZQYjvGVoulk7kbsGqWHJa1DF7kgrT0BC519lWWV0mfjW4CTH/KSLL/PRkA7FcOpyapCKjiKLtFpoag4p2UOQNKPgHQmb2WFjp7zAg2kTCriWzifAG9W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WP0zGgla; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so1284864f8f.0
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760724201; x=1761329001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6phIhVu+wctHAFPzvMGU++tpun4uAfFHZM4+TynflUg=;
        b=WP0zGgla5g6nXTqEysISaGkeGoAZ0IJDfroqqJnpQicjyJ8v8GaGSHlwTTPfsMFcfq
         NtXLbF07QVvLDS5wvGQ2yNrdRzz//3c1abFmTULtjGzC0DeInJKOqQ4uzw230NgV7lYG
         wlB+QtLM3lsr22PZoIgbNAa2GRhkhUU/d+f+iSIBpF/6Nz89o8XhDHOZVr0kcN+remDT
         YmCOqRJEATShsoY6AaH+vh9iywiIqmkYM/rzyAsbiaHznlnT+NkXnC5hG7vUgdpujonH
         KNadQjydMXHrQ/AV6yjemldg1LS7tFXYmi6AHygxrpJNGqp2OqyQan0E/09z+3ar6r+v
         3e7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760724201; x=1761329001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6phIhVu+wctHAFPzvMGU++tpun4uAfFHZM4+TynflUg=;
        b=Wx1ydjN8oUSiAsVZGVEgttAHV7JIJim8PAyU7BmWpMx9CRO07WUR5yt4g28E7DTEHC
         TnNXNl/dj5P3TALKqEu0/FOVMweXw/Roq7OGKSp/mGE7S0uuxiPe3jLEUw7U06ir4p8v
         zhhEdhdFAygWb5YRHLPIF0d1ssRM7tsYkjuGg0YwmLeDL+1CJMKOt6+EVt20WhFkRvDz
         LkvkdYuYuX8VkNt7FA1ngkWdjUy5Zz87VQFmnS6hkEec4mjORd1UU/Tq1AbJTCQEtUID
         tsMC+K463zC5MF9U3e8Y+UGamoLtn14fJ8+TzmAlrvABFJN2E8EMFdxbWgyuy+7DbLlI
         aqWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6lxW9jcufvgHmiFewx5KpG+xrPOgfpT0cnuPPuprbW+xVrGVSJ7nzS3G5EN5VT369/4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm11Zoo6gWFDM9eGzvfIsomsuzdcM9XVRp5J66pFYuX+AKtGQR
	S7OHXefhxy+YFObyb4FAmF2GAJnSoMStuFTnP90e8fG35VLKZA9O4N6GhqXyERp5iDJuZcUJ2gn
	a/+Y9P//VqBDvj2hnJz+Ccp8o+5RCXtE=
X-Gm-Gg: ASbGnctUoefktKC+M5UhV9cOKu4fMlRtElG6kSat9A7cy5MKr2J92NwVXqh8E87YhmJ
	hR2dBUpvKp6uBhn8AwpuQu5Y+UNQjejtc/l04Hd8mlWjerVIEVn32g7xzw2J/uImsTwFi2nObFa
	TdQ1GXzSV1jE/NLH5m8nYxwbygFVI/yPZXJRBz0cK6dx0C4brBUdtqvnkW4G8TJwNb9WiXdQxeb
	klGuB0+zc21nOdDDij9pEGyhkG1vHXHVHfCxlYqTkVLjv15MftCWEkQrQ19B30LxwkFCDJ0gMZ5
	QEoOdULTwm5ILgr4L7Z/jl5hmQVV
X-Google-Smtp-Source: AGHT+IGJaQwbB2fBnXd6ZLkKq7LnuwvgyHlRA8rakn6fMd9V7YGmmrX0Lu7ixfEkW836/PotQ0/f+4aOwx1Z1MqNIKM=
X-Received: by 2002:a05:6000:2005:b0:427:9d7:86fe with SMTP id
 ffacd0b85a97d-42709d7884cmr1427225f8f.49.1760724201366; Fri, 17 Oct 2025
 11:03:21 -0700 (PDT)
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
 <fe538d3d723b161ee5354bb2de8e3a2ac7cf8255.camel@HansenPartnership.com>
 <CAHC9VhSU0UCHW9ApHsVQLX9ar6jTEfAW4b4bBi5-fbbsOaashg@mail.gmail.com>
 <CAHC9VhTvxgufmxHZFBd023xgkOyp9Cmq-hA-Gv8sJF1xYQBFSA@mail.gmail.com>
 <CAADnVQJw_B-T6=TauUdyMLOxcfMDZ1hdHUFVnk59NmeWDBnEtw@mail.gmail.com> <CAHC9VhSRiZacAy=JTKgWnBDbycey37JRVC61373HERTEUFmxEA@mail.gmail.com>
In-Reply-To: <CAHC9VhSRiZacAy=JTKgWnBDbycey37JRVC61373HERTEUFmxEA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 17 Oct 2025 11:03:10 -0700
X-Gm-Features: AS18NWCCLiWGJLnJ_CLP_EP0C_sJ8kkIi2XPHajafzJenryM_7J5G_fZ5zUSEDo
Message-ID: <CAADnVQLRtfPrH6sffaPVyFP4Aib+e7uVVWLi7bb79d9TrHjHpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	James Bottomley <james.bottomley@hansenpartnership.com>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, wufan@linux.microsoft.com, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 6:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Oct 16, 2025 at 6:01=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Thu, Oct 16, 2025 at 1:51=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Sun, Oct 12, 2025 at 10:12=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > On Sat, Oct 11, 2025 at 1:09=E2=80=AFPM James Bottomley
> > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > > On Sat, 2025-10-11 at 09:31 -0700, Alexei Starovoitov wrote:
> > > > > > On Sat, Oct 11, 2025 at 7:52=E2=80=AFAM James Bottomley
> > > > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > > > >
> > > > > > > It doesn't need to, once we check both the loader and the map=
, the
> > > > > > > integrity is verified and the loader can be trusted to run an=
d
> > > > > > > relocate the map into the bpf program
> > > > > >
> > > > > > You should read KP's cover letter again and then research trust=
ed
> > > > > > hash chains. Here is a quote from the first googled link:
> > > > > >
> > > > > > "A trusted hash chain is a cryptographic process used to verify=
 the
> > > > > > integrity and authenticity of data by creating a sequence of ha=
sh
> > > > > > values, where each hash is linked to the next".
> > > > > >
> > > > > > In addition KP's algorithm was vetted by various security teams=
.
> > > > > > There is nothing novel here. It's a classic algorithm used
> > > > > > to verify integrity and that's what was implemented.
> > > > >
> > > > > Both KP and Blaise's patch sets are implementations of trusted ha=
sh
> > > > > chains.  The security argument isn't about whether the hash chain
> > > > > algorithm works, it's about where, in relation to the LSM hook, t=
he
> > > > > hash chain verification completes.
> >
> > Not true. Blaise's patch is a trusted hash chain denial.
>
> It would be helpful if you could clarify what you mean by "trusted
> hash chain denial" and how that differs from a "trusted hash chain".

Paul,
This is getting ridiculous. You're arguing about the code that you
don't understand. Stop this broken phone and let Blaise defend his code.

