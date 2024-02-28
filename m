Return-Path: <bpf+bounces-22927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4835C86B9BE
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4071F22E34
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 21:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AC320DF4;
	Wed, 28 Feb 2024 21:19:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6227586245;
	Wed, 28 Feb 2024 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155166; cv=none; b=YbX1sGIQd87ZvZdl5TssyrMGqdkZf4pmEB9o5bscmlvTbLTfSH28Io75FKL024gB3blGQzGzL5rIZsr+dze/n6geYYSXYOBih1O4OmGFLMtBAtQcw3iDoFhI3C86okYX0aU13Ivr3t4MzoUwpEEzEEw2xLLPDscAkAXe/KNYEo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155166; c=relaxed/simple;
	bh=84mYdSwdVbiEdNMN4g4S3x8nNzL8dNcpsA8MTb/tf3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUJkoDrsaBZCrDXmXjLb13uo3KWX9xI+unFKG0yMgFJTXamfZfQrp6+yAw/Xa0Wgg9PSvjypjuz5bII5WfoZbk/tsDbuh4D+XovwGqsxV/ZV/6wXGebgoePi821xGixo6lHy4fYwxAbUjp/vAcKL5cHMhtNBJlIYbwiCZdhq5v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29a858a0981so117555a91.0;
        Wed, 28 Feb 2024 13:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709155164; x=1709759964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00Zq06Xjz2j6uN/B4pNbgpBaeoAZi9AJgD48sQwk6os=;
        b=PvnqYEX2HCwpSz308ErIQ/tMRt0QDNFrHkWsj93Z9doiVrgG9QxEc/BzRFGOSt/gvm
         q0KWFwdJz+aBBUyyxNOjq/ElMuoktHCoOPloR2jvPoEHN85vvA7dQjAD+/mViSjN/ltY
         pZS8EyCwydW/ukqC4OLvzw+ZkUw6H3Yo8PaQjKAZnw6zqZbKyfna/HICAqoAqR6EyM4Z
         hGRKUvs/fa5WvBd+NUZQWPp+F8q+ZAF/SLzfPcdtFK5ruCRSIoF1EuMgENN3HTtiiaWn
         61/qCeG0KFeACZLsCBy+yR/Wt089UYc/7VcjA/xj8TafY/rhEQpXxBiPLY+m+DMf6m0Y
         qrPA==
X-Forwarded-Encrypted: i=1; AJvYcCWC6nzT1f021qE1RqfEzMPmeEDzWTywTcK4wE+FxC7GLVH4pUR3KvtVJLZMTq8aT/kgUj7MaZB0srB/jZh3An35rxxFOQlqiD6KIwO3oY8R8H6g+z07eOadqx2MmC3alkmpH0pogh9n6nNxLOcXCQ2evWnPkV7AjWy+8gQmrI6vP+iZGw==
X-Gm-Message-State: AOJu0YyzQzzFGEwLbTC4P2F9MHNbXMMNK1OPbLoJUCXJfF9Ojg/BjzUP
	rkAkvSL2g1CFolS9enYN2cVeBBmOn0p0OJy1wv6Y7qK+7x9Z0wf8MSQ67NQJ2/BbQMZGHdqDr2M
	B2KnarPsLh0vsikcPAipQAvWFYUJDGBAa
X-Google-Smtp-Source: AGHT+IFcW0lACQ0CndQCJr/f6bGON76AtKLM+nfx1xi+BTyeE3WaBGZEXzjCb+VwMIz56N9QsBGrOqFpzV7QUNqHOZI=
X-Received: by 2002:a17:90b:4cc7:b0:29b:a2d:1ac with SMTP id
 nd7-20020a17090b4cc700b0029b0a2d01acmr100043pjb.7.1709155164539; Wed, 28 Feb
 2024 13:19:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228053335.312776-1-namhyung@kernel.org> <Zd8lkcb5irCOY4-m@x1>
 <CAM9d7cicRtxCvMWu4pk6kdZAqT2pt3erpzL4_Jdt1pKLLYoFgQ@mail.gmail.com> <Zd-UmcqV0mbrKnd0@x1>
In-Reply-To: <Zd-UmcqV0mbrKnd0@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 28 Feb 2024 13:19:12 -0800
Message-ID: <CAM9d7cg-M_8V0O2rv_gx+1u=axpRmCp4XcBkkqsiGmDgeU2xZw@mail.gmail.com>
Subject: Re: [PATCH v2] perf lock contention: Account contending locks too
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:16=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Feb 28, 2024 at 12:01:55PM -0800, Namhyung Kim wrote:
> > On Wed, Feb 28, 2024 at 4:22=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Tue, Feb 27, 2024 at 09:33:35PM -0800, Namhyung Kim wrote:
> > > > Currently it accounts the contention using delta between timestamps=
 in
> > > > lock:contention_begin and lock:contention_end tracepoints.  But it =
means
> > > > the lock should see the both events during the monitoring period.
> > > >
> > > > Actually there are 4 cases that happen with the monitoring:
> > > >
> > > >                 monitoring period
> > > >             /                       \
> > > >             |                       |
> > > >  1:  B------+-----------------------+--------E
> > > >  2:    B----+-------------E         |
> > > >  3:         |           B-----------+----E
> > > >  4:         |     B-------------E   |
> > > >             |                       |
> > > >             t0                      t1
> > > >
> > > > where B and E mean contention BEGIN and END, respectively.  So it o=
nly
> > > > accounts the case 4 for now.  It seems there's no way to handle the=
 case
> > > > 1.  The case 2 might be handled if it saved the timestamp (t0), but=
 it
> > > > lacks the information from the B notably the flags which shows the =
lock
> > > > types.  Also it could be a nested lock which it currently ignores. =
 So
> > > > I think we should ignore the case 2.
> > >
> > > Perhaps have a separate output listing locks that were found to be wi=
th
> > > at least tE - t0 time, with perhaps a backtrace at that END time?
> >
> > Do you mean long contentions in case 3?  I'm not sure what do
> > you mean by tE, but they started after t0 so cannot be greater
>
> case 2
>
>                 monitoring period
>             /                       \
>             |                       |
>  2:    B----+-------------E         |
>             |             |         |
>             t0            tE        t1
>
> We get a notification for event E, right? We don=C2=B4t have one for B,
> because it happened before we were monitoring.

Ah, ok.  But there should be too many events in case 2 and
I don't think users want to see them all.  And they don't have
flags.  But maybe we can update the flag when it sees exactly
the same callstack later.

Thanks,
Namhyung

