Return-Path: <bpf+bounces-71169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FEDBE60AC
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 03:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B60A189511B
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 01:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1970C120;
	Fri, 17 Oct 2025 01:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OP4ojLfn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0EC19D082
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 01:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760664995; cv=none; b=QxHJl8GCtCnZsQpQAYQmSt75OWA/Ik2rMI18L9DekyqztOY4D5ZdAa4BL50IKfUC8gaJ09nq2Ny4kavtJuJ2/WB/pUe6IMGIn+CdtH6oYvkruyTQyKH0Br/quo0q76ao77Y+bh4hrLDSqIBINEy+c0JQS8GLgBaqKmTL7Y4jdqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760664995; c=relaxed/simple;
	bh=RQwrYt0jo4x0JqtpvYVOcaLNFM09oLFz4Yn4sD59UBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jV2xE46OVbPNFBlyXLfs/s1JD/iBLKZGDzN94cHfA0Zyh3yyD2AO7BZX20IrF1BRlHGlEVcIN6T6i+vp+zslP4Wz+WWCOwZ0/x0grYocW+U9V9KWnJksKFUkHnoZU1pKXXr7QNjAX+hiqrqcYxqH+fRt7MejSoSyYzicuKZEEjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OP4ojLfn; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3307de086d8so1224667a91.2
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 18:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760664993; x=1761269793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hpgU9ajqt26oT1UduOXd+QTKi374Ja1pljZUR5G7zo=;
        b=OP4ojLfnURtEhn6ldgW0NR3jx5LQJjAFSvHx4fq63kV0NOa3gFn0/J7pnfBY123WKP
         wNv+hNzU8ZDjX5BP+MAgQM9HnMaWf8FdY8WvN256KkmIGRdWC4KfaPyCaDiVUOwfRcgi
         JD5Vvxn+VAG+ern3aEpEI0gQdCLXP8DRzu00AimFzr8EcCCSt4W5yLq/1GKFMnkJLRV2
         01YnRdT5OAcDwQY2lhzBLWd5zTrE3/W6/QZqvNbTdZkXCkglioY7jYQDMG5LMNvC64hz
         lQAofaeVH8X9QzjgWFLKmYR+gFnLtRL6+nWSt/+aI1nzR6htTcmomRCkwVOPseAh2G8n
         v+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760664993; x=1761269793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hpgU9ajqt26oT1UduOXd+QTKi374Ja1pljZUR5G7zo=;
        b=QF6jrcZpnaGBtLnuJQm9QlZ9ZjZV0o/ylEm7m8w7+Rh2wS/9EkSu+ajKF8W0s00JWm
         caMrfweTtCH1jcCN8zhUO/TwAULQDdP28Y0C6QWQMSy0XqggaYiTnSQpWcf4qWpC8o3w
         0sbRTA0Q3oIbnlzy+zcNQGwhuqqwcVRSdxUmoSFh+gvbCUTlnI/Wqg6KYCriDciq2yk2
         xT/sXZlZP4RYoIQK5kjrnzpmwL8vo40I86lnvThEQME5AVpcHBPgVX7KhQEVx/xBsvcG
         axQHQLL2KuttRdYw1dQchIH7Ik7MYJ5Nblp5b9HbXn6LX8yvgYYC4aHT7O1FrQyhJF5a
         FGFA==
X-Forwarded-Encrypted: i=1; AJvYcCX6l/I+XGW4rlSMjdLgoxKLYPeeuybB0hLHZ81ujo8q9HXaNBMlR9yakaCH9wCYxk0O+Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2WTllk7sZVFY4pARqbC2RpFN1+bh+ol62S0hMpsNwpGIRJHka
	2/h2mxPC5gwSSQw1GexdxCSI5x1ApBSMmJ8EKsrGv1GAYdVKFzj4SnR86pg2oeWRWU+CBWYkZ7k
	LgHJ96NgXw8o3x1II020ncpC7EJAXXaRIf6pJEZ0D
X-Gm-Gg: ASbGncuZXKmlHZROXo2YpgJENQfsDeHBzZ7Q7t6Vs1gmo/Op0CNu/d+wTP+gq4GxVyA
	FhSfbQ+IZH/GgKJpBtgqDNOyX8cPavHYmmV5LTpZpcE1rcuLzNvCinXRKblRZpigBuzVoaoVNXA
	RaF2gYd3oJ2+PbNPGdwNNUfS3J8IWilyK2TfmNAF9QUIdVOVfoEmOUuyRpBf/UoYIv/Z3jHo9ll
	D47ijxyZL2fFW4i/gs0xPMr2q8BtvdqfeWRMl8LfCnHp4X0jNckqWaOwlROaju0zIJqFCw=
X-Google-Smtp-Source: AGHT+IE85DWd4T74Rw13SAZLG/N3BMOgO9UPgJIWQdGwyMQy7Chg4g85CUFQb5gp+L+cIAWc1RTkRplWgER41UnpWqk=
X-Received: by 2002:a17:90b:3f8d:b0:32d:d408:e86 with SMTP id
 98e67ed59e1d1-33bcf85b2e0mr2248726a91.7.1760664993087; Thu, 16 Oct 2025
 18:36:33 -0700 (PDT)
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
 <CAHC9VhTvxgufmxHZFBd023xgkOyp9Cmq-hA-Gv8sJF1xYQBFSA@mail.gmail.com> <CAADnVQJw_B-T6=TauUdyMLOxcfMDZ1hdHUFVnk59NmeWDBnEtw@mail.gmail.com>
In-Reply-To: <CAADnVQJw_B-T6=TauUdyMLOxcfMDZ1hdHUFVnk59NmeWDBnEtw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 Oct 2025 21:36:21 -0400
X-Gm-Features: AS18NWAGWHGN66wdUMxtmUiencObilqSTZxCihpcs5GznlUzJvdhSUquFKHlfYs
Message-ID: <CAHC9VhSRiZacAy=JTKgWnBDbycey37JRVC61373HERTEUFmxEA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	James Bottomley <james.bottomley@hansenpartnership.com>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, wufan@linux.microsoft.com, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 6:01=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Thu, Oct 16, 2025 at 1:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Sun, Oct 12, 2025 at 10:12=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > On Sat, Oct 11, 2025 at 1:09=E2=80=AFPM James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > On Sat, 2025-10-11 at 09:31 -0700, Alexei Starovoitov wrote:
> > > > > On Sat, Oct 11, 2025 at 7:52=E2=80=AFAM James Bottomley
> > > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > > >
> > > > > > It doesn't need to, once we check both the loader and the map, =
the
> > > > > > integrity is verified and the loader can be trusted to run and
> > > > > > relocate the map into the bpf program
> > > > >
> > > > > You should read KP's cover letter again and then research trusted
> > > > > hash chains. Here is a quote from the first googled link:
> > > > >
> > > > > "A trusted hash chain is a cryptographic process used to verify t=
he
> > > > > integrity and authenticity of data by creating a sequence of hash
> > > > > values, where each hash is linked to the next".
> > > > >
> > > > > In addition KP's algorithm was vetted by various security teams.
> > > > > There is nothing novel here. It's a classic algorithm used
> > > > > to verify integrity and that's what was implemented.
> > > >
> > > > Both KP and Blaise's patch sets are implementations of trusted hash
> > > > chains.  The security argument isn't about whether the hash chain
> > > > algorithm works, it's about where, in relation to the LSM hook, the
> > > > hash chain verification completes.
>
> Not true. Blaise's patch is a trusted hash chain denial.

It would be helpful if you could clarify what you mean by "trusted
hash chain denial" and how that differs from a "trusted hash chain".

> > > Alexei, considering the discussion from the past few days, and the
> > > responses to all of your objections, I'm not seeing a clear reason wh=
y
> > > you are opposed to sending Blaise's patchset up to Linus.  What is
> > > preventing you from sending Blaise's patch up to Linus?
> >
> > With the merge window behind us, and the link tag discussion winding
> > down ;) , I thought it might be worthwhile to bubble this thread back
> > up to the top of everyone's inbox.
>
> Please stop this spam. The reasons for rejection were explained
> multiple times.

I believe we have provided satisfactory counter arguments in each of
those cases, and those counter arguments remain unanswered.  Without a
response it's impossible to move forward towards a solution that
everyone can find acceptable, unless that is the core issue?  Is your
position that any solution outside of what you sent to Linus during
this past merge window is unacceptable?

--=20
paul-moore.com

