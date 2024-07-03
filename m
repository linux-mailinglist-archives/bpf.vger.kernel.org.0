Return-Path: <bpf+bounces-33838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E2A926C29
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 00:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3EA1F232BF
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 22:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE98194A42;
	Wed,  3 Jul 2024 22:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Irc4qML2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807051369A0;
	Wed,  3 Jul 2024 22:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047543; cv=none; b=T5BPvvqenHBPS0CXvN/T1WSrb0ZsJMZHp262Lz4xbycFtu40cDS7KsTqeyGkY4+JW0j5BaGp5dVechJ30pklPZYO/i5ScBn57/M9Bu74OSn/PJvGUBdrrjTkqVaBxGICIB33CJXsCy0SO6ebHM2tzvnZZp6Q2C6VumjznJI7hFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047543; c=relaxed/simple;
	bh=Dn6s3qu4JChWZeRiOFYv1ju6D+1sockuxvi7rzY6G94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDsfY4+3hYGGR9cRE/lhLsyXztaF1lZ389FEWNQxQIkTp0LMcqSZousNHmxUn2RYSptc+RhSYxQ6c4r4lz4Hj5gSE9ox4bZ3c5aDwUKcDvC03l4TdvP0mq2tOyzTTA5Br/ZAvT5xLnt6Pdqp5hwtYI9WWfpE8d1v1w1ztBT87W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Irc4qML2; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-706b14044cbso44428b3a.2;
        Wed, 03 Jul 2024 15:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720047542; x=1720652342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUYRLpN1HsvQ9Iub7j78dAtckWGp5xsN9z0zcOVj+Ws=;
        b=Irc4qML27MsHoKqIDTfa4buAbOMIWH2rOyUMW9uZHF1efhE8gZIIYm+mjX+bGXPaAO
         FUcrx81NKL1JD1wccIrWz6o8udHePw74OzyCObze8jxFLa3bCVS9nnggIRneIJAOKO40
         hJudQgeIaJdILrrst5fgnkENbk1C3VqVYD3hozoJ77vw8e17zoUtjgajRzOVLXaxyDhm
         hvl3QOtSf0dEltlnSikbbJtw6WMqE6EnvRGFgPfem3eYyWoFyhEONOEL4UcmBLE+0DXI
         K3xELYcbv83yr75p2REt8TsxHTczVzWI5wOVCiO78BkBRYQ8YD/2f0eqSYWZ+4v7OIH4
         WHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047542; x=1720652342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUYRLpN1HsvQ9Iub7j78dAtckWGp5xsN9z0zcOVj+Ws=;
        b=rsVMAl98qH4Cu53Y5+029NKwUMPkvZb8KLaWQWSMVBzoOIYwMfuh06XK0fbwbL167R
         jJadyEZV9lkt78vUYkNqBHW2SD09dMQSDlBD2lWd4MbD+Zknr1OKXcFpcMpQVv74k6sz
         EGu/+0Ce3+49NAEu+lBwthVRkCH286wOfm9bMd5NBn0eBNu81ILxltwv04H/bBeS+WK8
         pLQPLoVLM6YKbZY2DpTbZgnRrqJ9iU/QjtAT0jIO/ogyyewKpiSmWl/zvn7scQ4yTM6Y
         JmqD5pOjBbk9S9/BAatdbkgx9qc0IFIJ3g3U4mnowK72eHEpE/hInv9sd4Lia7dCJEQC
         UQ5w==
X-Forwarded-Encrypted: i=1; AJvYcCV5ey7UFkOp8OurwKtOjP+m006DNlWm9xr26evqlSmAxirPA0FynC3VvNK6DdLxkewhNbS3jkrBe427eOaRbNYPe1jJVNHjxPEvG4p1ZQEp/YD8bLGV97/u9DC4tjDeOqIp4NxlEghVVTJqdNaR2hWYI5ex4tSCS+NeCdXAcpnccXqAwvoJznAMUsJJTgxadXu4iSN8CeOXR++6JykgEPDgcwwx/bT9cw==
X-Gm-Message-State: AOJu0YxjEoArqptrqvq14EaoMkXLgyJS3X10TDF/GUf1lKnKt8RFmFo1
	MCIt4ehxpy1gqrV1MdUejw/72XYuHSWWSMeGHE0fuh7mPhfW1k2jkWBcc0eDSb16C2SXW6g62HS
	WAqj2KstuVKAi/HXE2B7mLrImKrdzgNDt
X-Google-Smtp-Source: AGHT+IFr04NbMFedS5PsaMHEQQnrJeYwnDmLyBo5tjso1mhnymhHom2UAmA9d+aMBqsaKF7js1jvSVq6zKf+eFeKz1I=
X-Received: by 2002:a05:6a00:148c:b0:706:6937:cb9d with SMTP id
 d2e1a72fcca58-70aaac1f237mr13299391b3a.0.1720047541566; Wed, 03 Jul 2024
 15:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702171858.187562-1-andrii@kernel.org> <20240702233554.slj6kh7dn2mc2w4n@treble>
 <20240702233902.p42gfhhnxo2veemf@treble> <CAEf4BzZ1GexY6uhO2Mwgbd7DgUnpMeTR2R37G5_5vdchQUAvjA@mail.gmail.com>
 <20240703011153.jfg6jakxaiedyrom@treble> <CAEf4BzbzsKLtzPUOhby0ZOM3FskE0q4bYx-o5bB4P=dVBVPSNw@mail.gmail.com>
 <20240703061119.iamshulwf3qzsdu3@treble> <CAEf4Bza6YdQ5HCcuPozOwVx75UrcyZL_1DGnYrJ=2pz=DxJpPQ@mail.gmail.com>
 <20240703224101.36r32g7j2atskidg@treble>
In-Reply-To: <20240703224101.36r32g7j2atskidg@treble>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jul 2024 15:58:49 -0700
Message-ID: <CAEf4Bzb+8FOcC0kRiW5D-OLfBkX6TcHfto9oK57yQRy_eFHepA@mail.gmail.com>
Subject: Re: [PATCH v2] perf,x86: avoid missing caller address in stack traces
 captured in uprobe
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	x86@kernel.org, mingo@redhat.com, tglx@linutronix.de, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, rihams@fb.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 3:41=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> On Wed, Jul 03, 2024 at 01:23:39PM -0700, Andrii Nakryiko wrote:
> > > >  [0] https://docs.google.com/presentation/d/1k10-HtK7pP5CMMa86dDCdL=
W55fHOut4co3Zs5akk0t4
> > >
> > > I don't seem to have permission to open it.
> > >
> >
> > Argh, sorry, it's under my corporate account which doesn't allow
> > others to view it. Try this, I "published" it, let me know if that
> > still doesn't work:
> >
> >   [0] https://docs.google.com/presentation/d/e/2PACX-1vRgL3UPbkrznwtNPK=
n-sSjvan7tFeMqOrIyZAFSSEPYiWG20JGSP80jBmZqGwqMuBGVmv9vyLU4KRTx/pub
>
> The new link doesn't work either :-)
>

Goodness, sorry about that. I just recreated it under my public
account and shared it with the world. This HAS to work:

  https://docs.google.com/presentation/d/1eaOf9CVZlCOD6b7_UtZBYMfTyYIDZw9cl=
yjzu-IIOIo

> > > > Few questions, while we are at it. Does it mean that
> > > > perf_callchain_user() will support working from sleepable context a=
nd
> > > > will wait for data to be paged in? Is anyone already working on thi=
s?
> > > > Any pointers?
> > >
> > > I had a prototype here:
> > >
> > >   https://lkml.kernel.org/lkml/cover.1699487758.git.jpoimboe@kernel.o=
rg
> > >
> > > Hopefully I can get started on v2 soon.
> >
> > Ok, so you are going to work on this. Please cc me on future revisions
> > then. Thanks!
>
> Will do!
>
> --
> Josh

