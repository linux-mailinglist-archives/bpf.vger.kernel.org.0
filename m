Return-Path: <bpf+bounces-52952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C62A4A7A3
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 02:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC201703BB
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 01:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC66D39AD6;
	Sat,  1 Mar 2025 01:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrUgiCix"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E89182D2
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 01:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793459; cv=none; b=XDe1dxJbiqyS4XjzgN7GWxTwaizGc5RBrTWJmtj9vvQFpQsxbebme63YZYnddek4atDXOpr2p62GZfeN8S6dpt37gssVdh+6PEWsep6bsWcHQZ1KW98vsOek+16roT74TzV3onkaPh85JvWMf1KLAWkLBDRsJkW5qkuvCUTgFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793459; c=relaxed/simple;
	bh=38ZRQ3qKI8VkqcLNcHJahuPkOpA/TW3qjwnkasQ1lEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfoWj+h20C8EkAPPz4Pmus4AupLTkJBwXgbI8fwzmqZt4/nSUe8NfjBNPOmX8vZPr4hxRY3s0HSeK1tVxul1cOnELvaymEy9Qdtf2iP9pyGfGAGjKXneBZyhDYgoNAAziPGjKDj20DB1mtCLjg+yDqZYIVEpjY0jEPsvA4Qd9DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrUgiCix; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-abf4d756135so57381566b.1
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 17:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740793454; x=1741398254; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FoHKkAzoOWpxlKyvirxZbndx1O7H/2vOyHxtyVv86/M=;
        b=IrUgiCixNWXRpZWSB2uY1za6+lOEGMNhJPp4zGRooBomIDq2sHbXTbiL/PG/7/R8Wb
         GJLSSYEI8aItRhN2yaqvJZVl3Q12UaihtzcmNgrMxTVYeYyI8y9mj6u3zO/9rwJdoT5I
         fVaBsGctHAG6YMGIRarTnW5BBGQvUewSowjTx2t4BCrxWi6gxQnJ5A47F7MYJU/q6oo2
         ocaVxtkQE2RRhKqOzCnLmxozK6/f0dIfrv5Lm3exFdAyDWCf1jvXoKAr0iMIN+23fIKh
         h9Up4hgBZyzj6u/NTYprpdlrVw8WYDNB/bQeQsa+rBkfb+QFph+Dzl0k0X86g+4K/0RW
         kG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740793454; x=1741398254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FoHKkAzoOWpxlKyvirxZbndx1O7H/2vOyHxtyVv86/M=;
        b=cdxshwYCZ/NGh8NO9+Hs9C9Ct8ght35jNEQeV30foUjqW+KKUmrNZXZs/KfjGbPIMz
         J+/sPKiLpWT4zC+KXqzcGD43YQ5a9R94I9mdokVoT8W+c3iJtOJHTVA9MglwN1UnzlEi
         CLPDHPRb/uBZkohp9VTNxxSfWiXFWdOlwa/php8xMDVThLY07SjZ0xh1k3Fkkvcvx5hM
         28cCMOQIuPf7ZOstth1HhzYeifpxmwfKC93CdeGBrh6axjEuTlobfnlAz7Z4gNzstN3h
         mUw37Y2NCHC5prlGfUCWrIMsaUuY4wmmTHEzzfkZcPt2+kBHZIoMjX4e64pO48F/rAds
         P1EA==
X-Forwarded-Encrypted: i=1; AJvYcCUBB1PX1esfKoaOOhtOjFEs3H3ZtwAENvEJCtBBX6RYVAwA3B62GyBG+gyAhFOncoHn62U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA91owW2ikTpazd0XUXSbR2SIsTSqvYUaCu7XpckC2EJIz4SXd
	GYwhX9wM7onirob7DjvwErCcU1By9X3utkcnFsF26SviRBrkQIbzj7TIGlo3Fyd38NZ9tYMEMsW
	Q/hh9M1TqpkBcFVz6tY8lhoHDXE4tmnCLxdM=
X-Gm-Gg: ASbGncuJssAcy3MO4phGn6g96iy7oYyQzRwj0Z5QsFnMFqGub2gFInyhn4kX0YJt7yu
	Zzwt16fJIiegokfK3iuG9g9JW4hTI/d1LSnGDcMvyu/NlyPvgHLeSfq6GDhvs7hp6yLijF1ZbM8
	/l0yEn/MpF+ANnXKRvP0zT7OPwuz4=
X-Google-Smtp-Source: AGHT+IHa0rYFn4zPpid509y+WJ4VyXWq9KI3D2r8q2KEku8n0r0euK6xLvue5JrqyISu0RzCgx/2GWqS/h2aTNFn0uY=
X-Received: by 2002:a17:907:7ea7:b0:aba:620a:acf8 with SMTP id
 a640c23a62f3a-abf25fac8e7mr597664366b.24.1740793453717; Fri, 28 Feb 2025
 17:44:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228162858.1073529-1-memxor@gmail.com> <20250228162858.1073529-2-memxor@gmail.com>
 <CAEf4BzZ_UQVtOhE3SRvHBE3NyCwfdFCxmiAPPNbLArZVQT6oZg@mail.gmail.com>
 <3736b28f9266bf8b9c227998e80eb08253aef43e.camel@gmail.com>
 <CAEf4BzZMhVCc0SVjbOLQj736kH-0yRdptqa7rNTftyD5X7ZDvw@mail.gmail.com> <69a875c3c8be2851f71d64c062d139d9a2c64b07.camel@gmail.com>
In-Reply-To: <69a875c3c8be2851f71d64c062d139d9a2c64b07.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 1 Mar 2025 02:43:37 +0100
X-Gm-Features: AQ5f1Jq6E1q5EV9CJ84Ndjj8fnoqNoMlCrhEryxKn6pWJLKl3ZD0PMbCzbk7qS4
Message-ID: <CAP01T75xRH-57yAxcj0b2rN+kV8e3SV_wYg47LPFxM2+B9C-WA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Summarize sleepable global subprogs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Mar 2025 at 00:57, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Fri, 2025-02-28 at 15:34 -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > > There were two alternatives on the table last time:
> > > - add support for tags on global functions;
> >
> > I was supportive of this, I believe
> >
> > > - verify global subprogram call tree in post-order,
> > >   in order to have the flags ready when needed.
> >
> > Remind me of the details here? we'd start validating the main prog,
> > suspend that process when encountering global func, go validate global
> > func, once done, come back to main prog, right?
>
> Yes.
> The tree can't be built statically if we account for dead code
> elimination, as post-order might change.
>
> > Alternatively, we could mark expected properties (restrictions) of
> > global subprogs as we encounter them, right? E.g, if we come to global
> > func call inside rcu_read_{lock,unlock}() region, we'd mark it
> > internally as "needs to be non-sleepable".
>
> For situation like below, suppose verification order is main, foo,
> bar, buz:
> - main() sleepable
>   - foo()
>   - bar()
> - foo():
>   - buz()
> - bar():
>   - foo() while holding lock
> - buz():
>   - calls something sleepable
>
> I think, to handle this the call-tree needs to be built on the main
> verification pass, and then checked for sleepable.
> But that won't work for changes_pkt_data, as verdict has to be known
> right-away to decide whether to invalidate packet pointers.
>

I know over-conservative marking in presence of possible DCE is
non-ideal (that's why I put in the comment, so we revisit it later),
I'm getting the sense from this thread that either option is a lot
more work/complexity, or insufficient.
Except for possibly taggings things properly, but that's been nipped in the bud.

So I'm going to prepare a v2 addressing Eduard's comments, and if we
reach a consensus, I can follow up to address both changes_pkt_data
and sleepable global subprogs.

> [...]
>

