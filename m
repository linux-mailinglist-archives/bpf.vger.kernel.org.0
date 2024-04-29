Return-Path: <bpf+bounces-28141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9608B6163
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 20:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96566B23E69
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 18:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE4413C3D5;
	Mon, 29 Apr 2024 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVFc224x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C813AD32;
	Mon, 29 Apr 2024 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416517; cv=none; b=o79GbM7WuOy7jErHWLyllyCiFm2ufLlnoKjo6K5MYP3XYrhRDtMcrAq1qqwa7/F3dYy4ZdJIPUnVNczNOjlGMBF6Q7IdwQ0WtriuHznTBgiawvHnY0FCFrbEuFWzTdNlTyE9YkXpmbdGZ/e1pYwMouoF/y4mstBc27QhC0XYeX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416517; c=relaxed/simple;
	bh=oIK9vUB1IDrrwPp8n2Cg14Jhx6oivr8vl18Nj4VwbKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmY99Jh/As4HNTm1sgDYXSHiVzBrfM8GBqb7+MA8vsKQnL17ecy4TrQOj/Kn8Yc8/LTB/hQmNoMIYriC6qLvJQjuYWJflIGZZJV5LPO0QqW+fKmKrc6o5W/1VOFKMP4WQKteIn52thVA1RbT2XOVbrrV5OtYXqwAPa9rrYtNz5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVFc224x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8329DC4AF1D;
	Mon, 29 Apr 2024 18:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714416517;
	bh=oIK9vUB1IDrrwPp8n2Cg14Jhx6oivr8vl18Nj4VwbKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KVFc224xm5qBnnNoFcvInYC8d8z0WDqGxROYTmypChsZ4dLidDZ51StFuu2hxTi9M
	 I0MPMX87Qr70fWjba70yPB1Ti640Q4oSbg+KKRykoSyS1lcnHyLOXq4gm14X2IHGIH
	 0HFoRyTfqij4jbeLpVqhZ4YjMX588fmXMYrIRxIdNPIqwLAutCEUdnFJjZVd7sfiy0
	 /uinSFjS88afyG6RUuFQFbcI3BtbRsVNfuonnV8odYY8AXVM4HZueXNKw4z3xvLDMp
	 tnV76VPTm/+BjaMnWOQ/hRxx2bVcgZol6+7bY8GqluRFNhNtV6Xs0W+3D/SHc4fuI2
	 PSA74B1qzYJKw==
Date: Mon, 29 Apr 2024 15:48:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, dwarves@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Daniel Xu <dxu@dxuuu.xyz>, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH 2/2] pahole: Allow asking for extra features using the
 '+' prefix in --btf_features
Message-ID: <Zi_rgQckDDFP7P72@x1>
References: <20240419205747.1102933-1-acme@kernel.org>
 <20240419205747.1102933-3-acme@kernel.org>
 <CAEf4Bzb0pyc_0AuP3O6wekpR3YcfEkk5bPGOOmS6_yJ3G5bKwQ@mail.gmail.com>
 <ZiwS0_O_CTesvjLC@x1>
 <d9e3a7ab-9799-42b0-9c6f-1809a0527867@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9e3a7ab-9799-42b0-9c6f-1809a0527867@oracle.com>

On Mon, Apr 29, 2024 at 12:16:18PM +0100, Alan Maguire wrote:
> On 26/04/2024 21:47, Arnaldo Carvalho de Melo wrote:
> > On Fri, Apr 26, 2024 at 01:26:40PM -0700, Andrii Nakryiko wrote:
> >> On Fri, Apr 19, 2024 at 1:58 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >> for older paholes that don't yet know about + syntax, but support
> >> --btf_features, will this effectively disable all features or how will
> >> it work?
> >>
> >> I'm thinking from the perspective of using +reproducible_build
> >> unconditionally in kernel's build scripts, will it regress something
> >> for current pahole versions?
> > 
> > Well, I think it will end up being discarded just like "all" or
> > "default", no? I.e. those were keywords not grokked by older pahole
> > versions, so ignored as we're not using --btf_features_strict, right?

> > Alan?
 
> Yep, it would just be ignored, so wouldn't have the desired behaviour
> of enabling defaults + reproducible build option.
 
> > But then we're not yet using --btf_features in scripts/Makefile.btf,
> > right?

> > But as Daniel pointed out and Alan (I think) agreed, for things like
> > scripts we probably end up using the most verbose thing as:

> > 	--btf_features=default,reproducible_build

> > to mean a set (the default set of BTF options) + an optional/extra
> > feature (reproducibe_build), that for people not used to the + syntax
> > may be more descriptive (I really think that both are confusing for
> > beginners knowing nothing about BTF and its evolution, etc).

> > Alan, also we released 1.26 with "all" meaning what we now call
> > "default", so we need to keep both meaning the same thing, right?

> I might be missing something here, but I think we should always call out

No you're not, I was just talking about what Daniel pointed out, that
when using a script using 'default,extra_feature' is more descriptive
than '+extra_feature', but you're right, for the kernel we go on adding
the features we need and older pahole versions will just ignore those.

The explanation you gave on this message is interesting to clarify when
'default' should be used and perhaps also use the kernel build process
needs/use of a list of features, etc. It would be good to have it in the
man page, can you provide a formal patch doing that?

Thanks,

- Arnaldo

> explicitly the set of features we want in the kernel Makefile.btf
> (something like [1]). The reason for this is that the concept of what is
> "default" may evolve over time; for example it's going to include
> Daniel's kfunc definitions for soon. That's a good thing, but it could
> conceivably cause problems down the line. Consider a newer pahole - with
> a newer set of defaults - running on an older kernel. In that case, we
> could end up encoding BTF features we don't want.  By contrast, if we
> always call out the full set of BTF features we want via
> --btf_features=feature1,feature2 etc we'll always get the expected set.
> Plus for folks consulting the code, it's much clearer which BTF features
> are in use when they look at the Makefiles for a particular kernel.
> So my sense of the value of "default" is as a shortcut for testing the
> latest and greatest set of BTF feature encoding, but not for use in the
> kernel tree Makefiles. Thanks!
> 
> Alan
> 
> [1]
> https://lore.kernel.org/bpf/20240424154806.3417662-7-alan.maguire@oracle.com/
> 
> > - Arnaldo
> >  
> >>> In the future we may want the '-' counterpart as a way to _remove_ some
> >>> of the standard set of BTF features.
> >>>
> >>> Cc: Alan Maguire <alan.maguire@oracle.com>
> >>> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> >>> Cc: Daniel Xu <dxu@dxuuu.xyz>
> >>> Cc: Eduard Zingerman <eddyz87@gmail.com>
> >>> Cc: Jiri Olsa <jolsa@kernel.org>
> >>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >>> ---
> >>>  man-pages/pahole.1          | 6 ++++++
> >>>  pahole.c                    | 6 ++++++
> >>>  tests/reproducible_build.sh | 2 +-
> >>>  3 files changed, 13 insertions(+), 1 deletion(-)
> >>>
> >>
> >> [...]

