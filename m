Return-Path: <bpf+bounces-37313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35840953CF2
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6FF028684E
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 21:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B15915443F;
	Thu, 15 Aug 2024 21:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+clNjij"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10BE143C65;
	Thu, 15 Aug 2024 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758852; cv=none; b=hUk8tOpPg1VQmjVBf6WeKJAZjLWHbnYbV+vhqDRpzwUFsMDWI+4Lo0M7aoHCS9VuYJe8JaPGPjlYPqfpbzUUniD4/gJImUa82hbH7SdsacE1sMyaWfjv8dQ9XPbv2L0OsCr7a5wuhyTyAVj9a8Bwe13/hWh9AsKGZFll7V4pLNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758852; c=relaxed/simple;
	bh=80VwrsKLrphNKpX94zFJw10504pi1Sj/ZHFc/qD2h4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9YL/lOCzZaySUD9gMm9IzMbwcrJTDiVb29kpEXC31TRD0CpMh205FXGGYHG7c9LdyN/Bx7udg6f+/np9TUDGpXb294rj1iaeGMchUBvCf6mDB2SkJ5FSg72BnxjQNd7xbKHYXRImYDFTKheUdH/ezzlT/6NEnSb3lMCVqtsFXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+clNjij; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cb5789297eso1033694a91.3;
        Thu, 15 Aug 2024 14:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723758850; x=1724363650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80VwrsKLrphNKpX94zFJw10504pi1Sj/ZHFc/qD2h4o=;
        b=X+clNjijXUnSpF65Qs0lPZIuE4B07fVWcc5PfxOFJtmxeX8ApI89gVLcE1NV36R6t3
         RF8iC/0+ft5Zjtt/xkNCjWHkzx0AOsLDZ5dtsro0nA1BouI5ccyuaVZfWYET33LWJs9o
         Z9CneryCKkD9++EGLidVkGq/7RJHkrT77eRhd+U5AW6HWL+iAvM1Tcet9TYWjRl0Jcej
         Axax/pJgTR4npJ7vILCFBRiN8ifqFngi49lxx8EzoKswgJnUKuLPadvC7gg7Cb6sv/Ut
         Nl+LR2WB6w4moXU0EoKJ3ZCuQgItNt/FVMIBaS0TqlBRE5VHaKRWw0P9efrHqEVXqo/C
         44Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758850; x=1724363650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80VwrsKLrphNKpX94zFJw10504pi1Sj/ZHFc/qD2h4o=;
        b=DCXL+HpwgbIs2jO0Nj+pz8KsC/8A2KShWe7FFCGq0/mbo8zXYi7/PxDl2cvp5gjc4i
         HWQEhvCTadG0/0uSxyaQKK4De8YCH0SmsyTAKQzecaWkifY0utLJjytxjTfBXq9E6qFO
         xax2EO2AIxuiWZCCFFmdR1Hb/EO0AoeYYFAHTRc9DLlhDCCrq4OX9T4N1TJj7+TgDLKM
         3QjGD91DncuTMWoMqForSzFJIbA7RLKSBQr00+W28roA1MQQABdrrC1FbtZjMOoA0zbb
         rZEnr1fPvlqOekV1HYBS1TUqvV3/8YE20QpT7QYhHfeLsZRe4PbFO+W9spo6S3UyLzpc
         Ybvw==
X-Forwarded-Encrypted: i=1; AJvYcCXG9GtV+knAiZFt2OsDB+edaIG9Ktn+DxsK6KHyTEOqgfpUW8GsZlN49rLVSnbyhrVc7ikwl7lZFBl35TM+g7bsdzKew7khe+V9Kty0utEIn9kVF1a05U47vIUN
X-Gm-Message-State: AOJu0YzeGOeoLOPCTlMfFIp6z3orhwrkOK7B1V+4HJdxk5vCGCSQn5y3
	SMCJ2+bFxRRvK6PxQkGaLhWgNxCazeYWjkjt6F0jgO3VaYSvlD2z3o12MVZg5TUr6B1PvWOZxGa
	5Zxk0/EZ5nDM7PqwTLAl4hGPZT3k=
X-Google-Smtp-Source: AGHT+IGCFmyl4kFUa9fepOgLWuBhrWbexmv7Hx/27UnKWH6CmMH6s2PbW8lnCHz3tV1J5VUAMmd6Pur7J2cuLJVMjgE=
X-Received: by 2002:a17:90a:d904:b0:2d3:c5f1:d0d9 with SMTP id
 98e67ed59e1d1-2d3dfd8c5b3mr1221843a91.25.1723758849931; Thu, 15 Aug 2024
 14:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQJgwGh+Jf=DUFuX28R2bpWVezigQYObNoKJT8UbqekOHA@mail.gmail.com>
 <20240815155439.GM632411@kernel.org>
In-Reply-To: <20240815155439.GM632411@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 14:53:57 -0700
Message-ID: <CAEf4BzYSZstRZsSdxryWvZ9yupwpT=-iG0gbu7q2Pg31f9DoGw@mail.gmail.com>
Subject: Re: bpf-next experiment
To: Simon Horman <horms@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 8:54=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Wed, Aug 14, 2024 at 12:32:00PM -0700, Alexei Starovoitov wrote:
> > Hi All,
> >
> > Couple years ago folks suggested that bpf-next should be
> > a separate pull request to increase subsystem visibility.
> > Back then we rejected the idea since many networking related
> > changes required bpf core changes. Things are different now.
> > bpf kfuncs can be added independently by various subsystems,
> > verifier additions are mainly driven by sched-ext,
> > so it's time to give it a shot. It's an experiment.
> > If things don't work out as expected we will go back to
> > the old model of feeding bpf trees through net/net-next trees.
> >
> > So here is the plan:
> >
> > 1. bpf fixes go directly to Linus (skipping net tree) and
> > net/bpf trees are fast forwarded afterwards as usual.
> >
> > 2. Non-networking bpf commits land in bpf-next/master branch.
> > It will form bpf-next PR during the merge window.
> >
> > 3. Networking related commits (like XDP) land in bpf-next/net branch.
> > They will be PR-ed to net-next and ffwded from net-next
> > as we do today. All these patches will get to mainline
> > via net-next PR.
>
> Hi Alexei,
>
> Nice plan :)
>
> I wonder if, bpf-next/net-next might be a more intuitive name, as the
> proposed branch is closely related to net-next.
>
> OTOH, mabey one '-next', as per your proposal, is enough :)
>
> >
> > 4. bpf-next/master and bpf-next/net branches are manually
> > merged into bpf-next/for-next branch.
> > This step achieves two objectives:
> > - bpf maintainers watch for conflicts between /master and /net
> > - Stephen Rothwell continues taking /for-next branch into linux-next
> > as usual
> >
> > bpf CI will run tests against 4 trees (instead of 2):
> > bpf, bpf-next/master, bpf-next/net, bpf-next/for-next.

BPF CI has been set up to recognize "bpf-net" as a marker for
bpf-next/net branch. We can update that, of course, but just FYI what
is currently recognized.

> > This is wip. Watch for more "Checks" in patchwork.
> >
> > By the merge window in September we will reassess
> > the situation and if it's still worth doing we will
> > proceed with PR formed from bpf-next/master.
> > If not, we will PR bpf-next/master into net-next and
> > call it a failed experiment.
> >
> > We feel that there are more positives to this process
> > than headaches, so fingers crossed.
> >

