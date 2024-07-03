Return-Path: <bpf+bounces-33805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3172E92697F
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 22:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645691C21C4E
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 20:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F9618FDC3;
	Wed,  3 Jul 2024 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkVM4a6x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E45D18FC7E;
	Wed,  3 Jul 2024 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720038233; cv=none; b=iy7d7b5Z2BF/wcHht1mHKBoE3pjlEvwNsXuUxSlcIs26eUZJLiidPbd6eV++OzQgqregkV0IE+ttOJG2PCGsEpexSKEBkEnvQrmNvR4mYRWv0zNBCr/7KOSYwwgi2+gB0hLS1vL3nTQxPoOB2AvtaRB0VGcoUUdzvi5s1nJ9t38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720038233; c=relaxed/simple;
	bh=lqDVL16W5PbR3pUnUv+XQD4CLo94RjrhSDsC+yXoXSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUOhikEWXP4DHfDmdMU7NrFkZ4GdLeQVsK+BNVbohYJ1brNiT4sAWrIcU+WptZwxVYkUE/fGB2Y0i8Nov+xL5xRjEkHA7vtlwYCJTd2r29NwC02deun8YG/O7xPm+kBdy1uHWnnfJ4tanTscXHvHjZMLIcYKhnjtx2GlaQQE8N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkVM4a6x; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7041053c0fdso3232749b3a.3;
        Wed, 03 Jul 2024 13:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720038232; x=1720643032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwvomoHjIbpct4hwfR4THyZoJBvV1mwfytBaKIOlC+o=;
        b=TkVM4a6x0VRnfV2L2DLphfkRlxeAeDXsnWyB7sHeYWfnNypKeLHQBe8rLPc46ve46C
         ggO5iKHZ6qJGevFOhQC/NQ5n3VWXKMape/6g/ns6uQO0y+BHcJIYFM5l7b1ONZnH6wx3
         ZwzZ6NctNNmiBcPXWMgt/ZRv9ym9A+zAuepWwaBmnrVBcCk4WxrtFacNIB0uoMqIQXnm
         7faQ6HjEi7mh8/9OdyOo1Vao3lbTXQ+YnpmR1AEunAgmmmhK+wVz0BK4YIJLO9ix6X5W
         pDFt4oF3QaAPWTwBfoN02bh7GODuWT6dTMc88oPUk8yjpYaPMbtj5/stwlx0KopgOeoJ
         zOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720038232; x=1720643032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwvomoHjIbpct4hwfR4THyZoJBvV1mwfytBaKIOlC+o=;
        b=te1Rm+GdB5OFl4oCgBgqssE7CCPUrxUwXm+MtXkCS5aJIqDovDUUloUfV1DdhbcMJk
         a1bsT7l98csJP34YKcI9XwbiwB9+VyFZ3JlLlBVKrkxNTnwjjYf03V2qhGrQ92iWyKKN
         kPIQ/hnTjbW15hhPszW85J459NeX1fpsmoleqjmMl5tcEruh43z1YwC/1M2nG79qE+gT
         xzGN+Bmd+rhHvPuy+YDGy0i++KtU6z0sKKj18P5okY4iY+qmeMMnMeeTa35BAciewgg/
         iy+AInLr0Tv+5dEkjJC8y6W9LG5IljtBEvLT2zFL4OokLrpcgpvo/KCGMsQ5bGFIF8m/
         36Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXLIFKYsAE1XumE0fJ8IBsxvoOawogR0MI2OyLeqd4tF04H4iv+qLnN6qqgFIS08Er/Sx5f9/aNnV+Dpx050U2SKpOS3D0Y334fItiqk1aBEXvOaCxSVnW7b1j+EioBucAqzXGMa20WfOqg3hbySJG+stJ6jZu4DvVIJeQ05voK+NHvDO6s0eqyJxxtbeWHrx9i+5fGwaSVxhsxhTorV4cELxPK7wXfbg==
X-Gm-Message-State: AOJu0YylrjT+TRkD0lmQuxXg5hW7EMLwioe5yGcXkYTEMcnT6lZzhZnR
	iZ8ar49swdEnO3jms0NykYQnBlROp+JmDWBaXa076Vies9TG9FevW0FJJLg5QGylNSs/EVQL/iG
	q4v7zvp5XotF7LqHOnoxr7foH0O8=
X-Google-Smtp-Source: AGHT+IEkPtR6WJw6D9+mrqSDTc+aTZrIYnAIpKILeYtKnzwURGBRPO835B/vkMpMUBZz2R+28Vqe7LW+nkXMye0Ibv0=
X-Received: by 2002:a05:6a00:4614:b0:706:726b:ae60 with SMTP id
 d2e1a72fcca58-70aaad60567mr12788838b3a.17.1720038231567; Wed, 03 Jul 2024
 13:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702171858.187562-1-andrii@kernel.org> <20240702233554.slj6kh7dn2mc2w4n@treble>
 <20240702233902.p42gfhhnxo2veemf@treble> <CAEf4BzZ1GexY6uhO2Mwgbd7DgUnpMeTR2R37G5_5vdchQUAvjA@mail.gmail.com>
 <20240703011153.jfg6jakxaiedyrom@treble> <CAEf4BzbzsKLtzPUOhby0ZOM3FskE0q4bYx-o5bB4P=dVBVPSNw@mail.gmail.com>
 <20240703061119.iamshulwf3qzsdu3@treble>
In-Reply-To: <20240703061119.iamshulwf3qzsdu3@treble>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jul 2024 13:23:39 -0700
Message-ID: <CAEf4Bza6YdQ5HCcuPozOwVx75UrcyZL_1DGnYrJ=2pz=DxJpPQ@mail.gmail.com>
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

On Tue, Jul 2, 2024 at 11:11=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Tue, Jul 02, 2024 at 08:35:08PM -0700, Andrii Nakryiko wrote:
> > On Tue, Jul 2, 2024 at 6:11=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.=
org> wrote:
> > > On Tue, Jul 02, 2024 at 05:06:14PM -0700, Andrii Nakryiko wrote:
> > > > In general, even with false positives, I think it's overwhelmingly
> > > > better to get correct entry stack trace 99.9% of the time, and in t=
he
> > > > rest 0.01% cases it's fine having one extra bogus entry (but the re=
st
> > > > should still be correct), which should be easy for humans to recogn=
ize
> > > > and filter out, if necessary.
> > >
> > > Agreed, this is a definite improvement overall.
> >
> > Cool, I'll incorporate that into v3 and send it soon.
> >

BTW, if you have a chance, please do take a look at v3 and leave your
ack, if you are ok with it. Thanks!

> > >
> > > BTW, soon there will be support for sframes instead of frame pointers=
,
> > > at which point these checks should only be done for the frame pointer
> > > case.
> >
> > Nice, this is one of the reasons I've been thinking about asynchronous
> > stack trace capture in BPF (see [0] from recent LSF/MM).
> >  [0] https://docs.google.com/presentation/d/1k10-HtK7pP5CMMa86dDCdLW55f=
HOut4co3Zs5akk0t4
>
> I don't seem to have permission to open it.
>

Argh, sorry, it's under my corporate account which doesn't allow
others to view it. Try this, I "published" it, let me know if that
still doesn't work:

  [0] https://docs.google.com/presentation/d/e/2PACX-1vRgL3UPbkrznwtNPKn-sS=
jvan7tFeMqOrIyZAFSSEPYiWG20JGSP80jBmZqGwqMuBGVmv9vyLU4KRTx/pub

> > Few questions, while we are at it. Does it mean that
> > perf_callchain_user() will support working from sleepable context and
> > will wait for data to be paged in? Is anyone already working on this?
> > Any pointers?
>
> I had a prototype here:
>
>   https://lkml.kernel.org/lkml/cover.1699487758.git.jpoimboe@kernel.org
>
> Hopefully I can get started on v2 soon.

Ok, so you are going to work on this. Please cc me on future revisions
then. Thanks!

>
> --
> Josh

