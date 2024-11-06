Return-Path: <bpf+bounces-44162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC709BF8E8
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 23:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D93284540
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 22:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562FC20CCC6;
	Wed,  6 Nov 2024 22:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/wHrRRr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BF0824A3
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 22:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730930815; cv=none; b=c5Kf7sIgTmJkaahgZcNf3NKdtrHSs7vab1L2tsXcVn6abd4XoQiPKW/dC3d6CiaF99HFYg2f54GGzsXqkDdWxtqfluUb6aTnu4g9L2Tj8q4MS/9EsiA63nTBe1VxIkLtVUiDFLE/i7NqZB+S9pKkORZm5PSN1vWZuEP8DM6xX3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730930815; c=relaxed/simple;
	bh=N5qByCHviCixE4YNqc+S0L9/dRmPpriXPzugmHZ0Rog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZdezuPrO3zwpJMiecK3h3/kwX02HkYeC82i9iK+fzZAO1WFToNqpKUVqlvhOLFP4g7jpfHQ2UY9Gvet82koMVnjm3uQlmiWxjXwqxzLvRSsMW2YkSvPTmtCYSXxBvUNXHHrb0haIY/h1l4tYYQdI6+Fix5SoMTEAUGl5Gu4/IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/wHrRRr; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2e6a1042dso235978a91.2
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2024 14:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730930814; x=1731535614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Rx6j0lpGnWjSZIpVIhks8cGxP3aBMT4e9o59wIPKQQ=;
        b=N/wHrRRrLn5va5BsLE4QI4DYatwrE47IdF4yMM8WH/kw2o7a6jeUV2ty99qKlawTHb
         /P6EC5HAKI9TtStbCI8cmHWY1OErVe6dH1pxrdNs5dTBDH9bvdbOGZRmaG3gPl/axTj4
         MUM8MiADS9naPxIDsK4Cm+3esdrVl7fCC1/j175HQaPsfX3bcXjsnl/gGsYt4vEXl5Fu
         EzwPuXLETJRICkk/SGefaT1RDI/Bc/JmDktis+EDX9yo3feAYysyKUG+QCVXOZQTRzyX
         T/wRWQ96TmphsiPWQ0sg9l0Jgoezjd8NVNKkcq6DneqU5MxdZgETwJnSJbvdXUjk5kk6
         Izhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730930814; x=1731535614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Rx6j0lpGnWjSZIpVIhks8cGxP3aBMT4e9o59wIPKQQ=;
        b=uakPcQgYByH690RPvpZxN2EoY9cqhK09kXdIWjBy0N+n44uT3gtagh0NTOh3f07I4G
         jE65joBYapXuphId38fVTkfajOKlNy2RUFf2CL31Y+Sw4caKdI0Sz+YacUKNIrjm9U8a
         EUAsy4ZvD9fn1T8tKzFmN9aA7kPmposBb51F0PzUbyNcaZu+BIyjoVWhPJsWn9p7zqsd
         Gb0P+zpLC0mNMAcR2v+e1ibtYm2FTjm+UaTqki0Z8woipWA31dNMQV+XNJl5wGSQ+8ry
         /WNbiQUmoYsfEQlS+FLQ+ut1xeb9PScc1ILz3mzazUXDl+zm3fFK8Y6nI5Qw5eowaiYV
         IIOg==
X-Forwarded-Encrypted: i=1; AJvYcCUeh1sFm7NRWiYon8U5MOwnCG4s8tHWCkSCWAmUeGEe17lqPLu94A3dT32eBtAy9AEWSXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0yB1CAEEj6RSnav//xjfbo2Tu55ycjXe0zxza3KslJDJGoHuQ
	o/npdBUIQs+w14FNtmW1zidXPpcmxrz9Sgv1soTaXi1TIpsZwhzCBIUfv48K5e5NFASI6Osb8Gl
	vRWXCQZSwASkzvmKqkWrs+b+Ybo0=
X-Google-Smtp-Source: AGHT+IF73VNNDK1+xXIXGC9qMZCZbJsxKNZjsjl5kUk4gQI5LGKJwyCZ1jtsxA68jhPfrKaps+C5pIHCRUf4pQQ1Q4I=
X-Received: by 2002:a17:90b:4ac1:b0:2e0:a77e:82f7 with SMTP id
 98e67ed59e1d1-2e94c53a96cmr29310403a91.36.1730930813655; Wed, 06 Nov 2024
 14:06:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916195919.1872371-1-ihor.solodrai@pm.me> <172715882926.3893391.17604218740773697669.git-patchwork-notify@kernel.org>
 <6dc74cb9-2a99-4fa7-a731-802852770d4d@kernel.org>
In-Reply-To: <6dc74cb9-2a99-4fa7-a731-802852770d4d@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Nov 2024 14:06:41 -0800
Message-ID: <CAEf4BzZZbkZKqjtR1mCVDHFXYTieMNiWBXOUHL-YRZZEJ2Z0bQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: remove test_skb_cgroup_id.sh
 from TEST_PROGS
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, bjorn@kernel.org, 
	Ihor Solodrai <ihor.solodrai@pm.me>, Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 8:31=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Andrii,
>
> (+cc Geliang who reported me the issue)
>
> On 24/09/2024 08:20, patchwork-bot+netdevbpf@kernel.org wrote:
> > Hello:
> >
> > This series was applied to bpf/bpf-next.git (master)
> > by Andrii Nakryiko <andrii@kernel.org>:
> >
> > On Mon, 16 Sep 2024 19:59:22 +0000 you wrote:
> >> test_skb_cgroup_id.sh was deleted in
> >> https://git.kernel.org/bpf/bpf-next/c/f957c230e173
> >>
> >> It has to be removed from TEST_PROGS variable in
> >> tools/testing/selftests/bpf/Makefile, otherwise install target fails.
> >>
> >> Link:
> >> https://lore.kernel.org/bpf/Q3BN2kW9Kgy6LkrDOwnyY4Pv7_YF8fInLCd2_QA3Li=
mKYM3wD64kRdnwp7blwG2dI_s7UGnfUae-4_dOmuTrxpYCi32G_KTzB3PfmxIerH8=3D@pm.me/
>
> It looks like the two patches here are fixing issues that are on v6.12
> as well: I'm on top of net-next, and I can see these issues. They are
> fixed by these two patches that can be applied without conflicts.
>
> In these patches, we can find references to the commits that introduced
> the issues:
>
> - Patch 1: f957c230e173 ("selftests/bpf: convert test_skb_cgroup_id_user
> to test_progs")
>
> - Patch 2: 844f7315e77a ("selftests/bpf: Use auto-dependencies for test
> objects")
>
> The two commits are in v6.12-rc1. Could it eventually be possible to
> apply these two patches (with Fixes tags?) in the 'bpf' tree instead of
> the 'bpf-next' one please?

Those patches landed back in September, more than a month ago, so it's
way too late to move them between the trees, unfortunately. You'll
probably have to do a stable backport, I'm sorry.

>
> > Here is the summary with links:
> >   - [bpf-next,1/2] selftests/bpf: remove test_skb_cgroup_id.sh from TES=
T_PROGS
> >     https://git.kernel.org/bpf/bpf-next/c/e4c139a63aff
>
> Just in case, it looks like the history has been rewritten. The last ref
> seems to be:
>
>   d002b922c4d5 ("selftests/bpf: Remove test_skb_cgroup_id.sh from
> TEST_PROGS")
>
> >   - [bpf-next,2/2] selftests/bpf: set vpath in Makefile to search for s=
kels
> >     https://git.kernel.org/bpf/bpf-next/c/494c3a797257
>
> ... and:
>
>   fd4a0e67838c ("selftests/bpf: Set vpath in Makefile to search for skels=
")
>
> Thank you!
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

