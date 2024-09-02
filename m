Return-Path: <bpf+bounces-38729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 233B0968DDA
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 20:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34B0283B53
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 18:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC1C1A3A99;
	Mon,  2 Sep 2024 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0X7ZZhP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2658E1A3A8E;
	Mon,  2 Sep 2024 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302692; cv=none; b=XaGJQcbLPpzs8z7MKL/t7pgXnuFyNHx542zOCs1ZOyYNiJSODMG8vZVC9rldSagUzl93YmC1g9s6jRWalEbMN/lMke+dGw2+YRSgyXeK2gSyMvDep5GnbaWh2+Iqu8WLYph/jFPwj6i8oQD1Z2jOnlQDEOLPjwNg+17bJPj4J60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302692; c=relaxed/simple;
	bh=HvJTC57CEcuMqHJ1O044sOAIGSvdGXbQRicP0ep4RKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eF25yyAnDnbZrsMINY+qMgY3YswR/sYtoyPFzI2rSaXGP2K6xQORcg2FEswR5GqRMHCZSoRpTHGfvRjISbQy6vsPZvPoBEBK/MGIh2jjkKc/XSI+nLhaP3VtIUjaCVKdpNelxwX6wBj+92V9Av9ksdTkdBRFWzgqJ4maiTw2BTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0X7ZZhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9966EC4CEC2;
	Mon,  2 Sep 2024 18:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725302692;
	bh=HvJTC57CEcuMqHJ1O044sOAIGSvdGXbQRicP0ep4RKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0X7ZZhPJ6iTrW+kC8Sph0925FjKlM2gF96xZgdcZdI+Lqtq87XyFlevB8W83Z2mv
	 M/AvPRaStoqB86zLPasmSj1nId+CwIiE36ZSuNyh+EU2rCYWIkHFU0Is0OF77zf+AK
	 Rc+UPeRZYgm775U1QBFRdGpAmffbfkhm9V3Wk2WAh87tcItVCny+chso09NNyHd8/7
	 dSgvQIbHV0nZkjdToa55Bp5XL3OLnzhVMWBOI0jtmnXzIk4bp7gxZeXfX+H0IOz3EN
	 P8FKeTiCpoJj61s9/1ddn0xXcpHCYDcZ7lTgej5GYsWMo6Fvj7fdOE6B4N49JtSTLe
	 Y1FJOo3hsMEBg==
Date: Mon, 2 Sep 2024 15:44:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@meta.com>,
	"dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: FYI: CI regression on big-endian arch (s390) after recent pahole
 changes
Message-ID: <ZtYHoZx-JkWTsv51@x1>
References: <442C7AEC-2919-4307-8700-F7A0B60B5565@fb.com>
 <322d9bac47bc3732b77cf2cf23d69f2c4665bc36.camel@gmail.com>
 <860fe244-157b-46cf-9b41-ee9fd36f9c1e@oracle.com>
 <ZtHG9YwwG5kwiRFt@x1>
 <CAEf4Bza9OJckdJ4=nask2m+bJsiDszvoLoaf+GhVFu8CNarb=g@mail.gmail.com>
 <ZtIwXdl_WyYmdLFx@x1>
 <CAEf4BzY5kx9HayBCViuXf0i7DyvFgcRObvnA1u3bqot2WjfyGg@mail.gmail.com>
 <2bd94dc7-172f-49c0-87c8-e3c51c840082@oracle.com>
 <ZtXG8TTMXTzXUkRg@x1>
 <ab553623-0e0a-496d-a2d8-6fd23de458b0@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab553623-0e0a-496d-a2d8-6fd23de458b0@oracle.com>

On Mon, Sep 02, 2024 at 03:59:26PM +0100, Alan Maguire wrote:
> On 02/09/2024 15:08, Arnaldo Carvalho de Melo wrote:
> > On Fri, Aug 30, 2024 at 11:34:40PM +0100, Alan Maguire wrote:
> >> On 30/08/2024 23:20, Andrii Nakryiko wrote:
> >>> On Fri, Aug 30, 2024 at 1:49 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >>>> On Fri, Aug 30, 2024 at 08:56:08AM -0700, Andrii Nakryiko wrote:
> >>>> +++ b/lib/bpf
> >>>> @@ -1 +1 @@
> >>>> -Subproject commit 6597330c45d185381900037f0130712cd326ae59
> >>>> +Subproject commit 686f600bca59e107af4040d0838ca2b02c14ff50
> >>>> ⬢[acme@toolbox pahole]$
> > 
> >>>> Right?
> > 
> >>> Yes, and I'm doing another Github sync today.
> > 
> > So, I just commited this locally:
> > 
> > ⬢[acme@toolbox pahole]$ git show
> > commit 5fd558301891d1c0456fcae79798a789b499c1f9 (HEAD -> master)
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Mon Sep 2 11:05:06 2024 -0300
> > 
> >     libbpf: Sync with master, i.e. what will become 1.5.0
> >     
> >     To pick this distilled BPF fix:
> >     
> >       fe28fae57a9463fbf ("libbpf: Ensure new BTF objects inherit input endianness")
> >     
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > diff --git a/lib/bpf b/lib/bpf
> > index 686f600bca59e107..caa17bdcbfc58e68 160000
> > --- a/lib/bpf
> > +++ b/lib/bpf
> > @@ -1 +1 @@
> > -Subproject commit 686f600bca59e107af4040d0838ca2b02c14ff50
> > +Subproject commit caa17bdcbfc58e68eaf4d017c058e6577606bf56
> > ⬢[acme@toolbox pahole]$
> > 
> > Ack?
> >
> 
> Acked-by: Alan Maguire <alan.maguire@oracle.com>
> 
> My patch for the same change crossed with your email [1], just ignore
> it. Thanks!

I dropped mine and picked yours :-)

Thanks!

- Arnaldo
 
> Alan
> 
> [1]
> https://lore.kernel.org/dwarves/20240902141043.177815-1-alan.maguire@oracle.com/T/#u
> 
> >>> Separate question, I think pahole supports the shared library version
> >>> of libbpf, as an option, is that right? How do you guys handle missing
> >>> APIs for distilled BTF in such a case?
> >  
> >> Good question - at present the distill-related code is conditionally
> >> compiled if LIBBPF_MAJOR_VERSION >=1 and LIBBF_MINOR_VERSION >= 5; so if
> >> an older shared library libbpf+headers is used, the btf_feature is
> >> simply ignored as if we didn't know about it. See [1] for the relevant
> >> code in btf_encoder.c. This problem doesn't arise if we're using the
> >> synced libbpf.
> >  
> >> There might be a better way to handle this, but I think that's enough to
> >> ensure we avoid compilation failures at least.
> > 
> > I guess this is good enough,
> > 
> > - Arnaldo
> >  
> >> [1]
> >> https://github.com/acmel/dwarves/blob/fd14dc67cb6aaead553074afb4a1ddad10209892/btf_encoder.c#L1766

