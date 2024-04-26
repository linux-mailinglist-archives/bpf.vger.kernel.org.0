Return-Path: <bpf+bounces-27982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C11E8B40F6
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 22:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6DB1C215F3
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 20:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07452C1BA;
	Fri, 26 Apr 2024 20:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBz7hXo4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2229413;
	Fri, 26 Apr 2024 20:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714164438; cv=none; b=u+cSotJ0vMH3FfImOIBWUn1ZDRiiwndWPbeQRnUhfn3UEukiT+6C4CvcCR4UH9+3XxVa7c6FkuegajQM95At0keSJdJ/K63b+DYyxLNOWd5a5djwt82W5ixPD3Wt90oKddmO4FuwelC7iXK8hxigjqPLGH6izFTVC+N6MIUFb2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714164438; c=relaxed/simple;
	bh=Ke6PnaHuYXUrGk7n/xW6HyC1qaYwrCBZDcX7ANMfGWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHS6/NKMc6tAzIWJUD+6zpfZwKElKDzTfFve9Kls/LcdzcENadjbK6s67pwpVBqYYMSw9wxnCy+6oJOIQnkTUZMblckWxAPq0qWkw61ciE4DmuQEZo36VDB8HmKFxP0+2pPiilXM2R3Xf8UJiEwHmEW6EtCXtpOiUlH3j6PE0CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBz7hXo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4DDC113CD;
	Fri, 26 Apr 2024 20:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714164438;
	bh=Ke6PnaHuYXUrGk7n/xW6HyC1qaYwrCBZDcX7ANMfGWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBz7hXo4rPfBVSzAt/h9RqUYJ6HtKJ6MAEogFiX/SRumIAjps5Babc4J6bhGLIlN7
	 CkpEzt0H1HC61eCNUksLD573m8vd3yXQ0uT2VlDwUICkw01oWntcpgRUsajIRjDs+w
	 wZ0DeuaFSFOsq+bbfYvC1iJ/ZIRoHKSRxcydKUWSPY+1yFnDC+B9kBgpoIHLh4k9C6
	 Kh+V7KLtpoa+F8leIcypKfqhMjAnMrIQqSE36TuiTb59kFiMWTdF4RXrIv8CbMU8el
	 EubzDxBl0WI1u/lumPHC7RDZemKC0Qr7WdB5G8Lz6OSmfXbX9pua8Wz9dBiMh55Cp3
	 Jx18e5eZuQucw==
Date: Fri, 26 Apr 2024 17:47:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>, Daniel Xu <dxu@dxuuu.xyz>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH 2/2] pahole: Allow asking for extra features using the
 '+' prefix in --btf_features
Message-ID: <ZiwS0_O_CTesvjLC@x1>
References: <20240419205747.1102933-1-acme@kernel.org>
 <20240419205747.1102933-3-acme@kernel.org>
 <CAEf4Bzb0pyc_0AuP3O6wekpR3YcfEkk5bPGOOmS6_yJ3G5bKwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb0pyc_0AuP3O6wekpR3YcfEkk5bPGOOmS6_yJ3G5bKwQ@mail.gmail.com>

On Fri, Apr 26, 2024 at 01:26:40PM -0700, Andrii Nakryiko wrote:
> On Fri, Apr 19, 2024 at 1:58 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > Instead of the somewhat confusing:
> >
> >   --btf_features=all,reproducible_build
> >
> > That means "'all' the standard BTF features plus the 'reproducible_build'
> > extra BTF feature", use + directly, making it more compact:
> >
> >   --btf_features=+reproducible_build
> >
> 
> for older paholes that don't yet know about + syntax, but support
> --btf_features, will this effectively disable all features or how will
> it work?
> 
> I'm thinking from the perspective of using +reproducible_build
> unconditionally in kernel's build scripts, will it regress something
> for current pahole versions?

Well, I think it will end up being discarded just like "all" or
"default", no? I.e. those were keywords not grokked by older pahole
versions, so ignored as we're not using --btf_features_strict, right?

Alan?

But then we're not yet using --btf_features in scripts/Makefile.btf,
right?

But as Daniel pointed out and Alan (I think) agreed, for things like
scripts we probably end up using the most verbose thing as:

	--btf_features=default,reproducible_build

to mean a set (the default set of BTF options) + an optional/extra
feature (reproducibe_build), that for people not used to the + syntax
may be more descriptive (I really think that both are confusing for
beginners knowing nothing about BTF and its evolution, etc).

Alan, also we released 1.26 with "all" meaning what we now call
"default", so we need to keep both meaning the same thing, right?

- Arnaldo
 
> > In the future we may want the '-' counterpart as a way to _remove_ some
> > of the standard set of BTF features.
> >
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Daniel Xu <dxu@dxuuu.xyz>
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  man-pages/pahole.1          | 6 ++++++
> >  pahole.c                    | 6 ++++++
> >  tests/reproducible_build.sh | 2 +-
> >  3 files changed, 13 insertions(+), 1 deletion(-)
> >
> 
> [...]

