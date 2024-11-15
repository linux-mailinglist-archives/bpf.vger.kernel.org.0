Return-Path: <bpf+bounces-44955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC92E9CE31D
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 15:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982601F21D59
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 14:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A961D4351;
	Fri, 15 Nov 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UO23ovRN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1793A1BF;
	Fri, 15 Nov 2024 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682361; cv=none; b=tboQK4ScmbzM4b0Gn7igiFioF0yGsdbBilNI+KdxHwygG/BB+styx1iAK+xzC45bKJkJ3hgRfmI/mcA12U+AUhGAPAzzkrgb3KdiNdjTYMFofCkawaAkXghQawsu5uykfRn5uBscjVh0bI3INjFDAZepk8m25UoaIzjlXTg00y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682361; c=relaxed/simple;
	bh=QwcfYhBD0i8gB/4ww709lJqiMwqd7Cgb+naBpGLOF+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVuYAYSYl1707kxuE0bOgD68rtRyOY3IS8gJ4uk8t843coyoWwmqQixfv2iKlvg51LEKDW0qUH+zxIXk/cev3eEXxWUaIlSbT2318VmalMljsAZKYZtig34oShTt3Q+7QJJCi0tKRkfATcoGqoakZgeZ7VIuuB/KCoLbwCTLW2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UO23ovRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F64EC4CECF;
	Fri, 15 Nov 2024 14:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731682360;
	bh=QwcfYhBD0i8gB/4ww709lJqiMwqd7Cgb+naBpGLOF+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UO23ovRN5F1ZEsMDOlvnAGQLN4GD6OjCNtdfJROXL9CEMGnHQesKs8jdz+9ibePOz
	 xQlT6AFzSYcDwwTofHdqwUlqTwXDE8S5C8uGIS8Idn4WomugIsPMgW8mrpgPnMdofp
	 b3qwZCwIAHmr+PYH47TC9G7qatLb0eZxlV7TozppxcOeBsebFboC36EMi2tMGT7PdS
	 KboWqnR4aVdiQ0ySmJkMscB6gyk7cBJvXniJBnhGiNFu4+wHzIQHpyxc/poO4N+5cx
	 k3AN4SeACbm+A3mOtlVsqsR0Z+NASHlf7yl3cbH+ZXc51sDwArPk0DiKASet2n0y/q
	 OGQIk4GSh9Ejw==
Date: Fri, 15 Nov 2024 11:52:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, yonghong.song@linux.dev,
	dwarves@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	bpf@vger.kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
	song@kernel.org, eddyz87@gmail.com
Subject: Re: [PATCH v2 dwarves 0/2] Check DW_OP_[GNU_]entry_value for
 possible parameter matching
Message-ID: <ZzdgNqf14cTjonaF@x1>
References: <20241114155822.898466-1-alan.maguire@oracle.com>
 <ZzcVq8zcdFm0mNxJ@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzcVq8zcdFm0mNxJ@krava>

On Fri, Nov 15, 2024 at 10:34:35AM +0100, Jiri Olsa wrote:
> On Thu, Nov 14, 2024 at 03:58:20PM +0000, Alan Maguire wrote:
> > Currently, pahole relies on DWARF to find whether a particular func
> > has its parameter mismatched with standard or optimized away.
> > In both these cases, the func will not be put in BTF and this
> > will prevent fentry/fexit tracing for these functions.
> > 
> > The current parameter checking focuses on the first location/expression
> > to match intended parameter register. But in some cases, the first
> > location/expression does not have expected matching information,
> > but further location like DW_OP_[GNU_]entry_value can provide
> > information which matches the expected parameter register.
> > 
> > Patch 1 supports this; patch 2 adds locking around dwarf_getlocation*
> > as it is unsafe in a multithreaded environment.
> > 
> > Run ~4000 times without observing a segmentation fault (as compared
> > to without patch 2, where a segmentation fault is observed approximately
> > every 200 invokations).
> > 
> > Changes since v1:
> > 
> > - used Eduard's approach of using a __dwarf_getlocations()
> >   internal wrapper (Eduard, patch 1).
> > - renamed function to parameter__reg(); did not rename
> >   __dwarf_getlocations() since its functionality is based around
> >   retrieving DWARF location info rather than parameter register
> >   indices (Yonghong, patch 2)
> > - added locking around dwarf_getlocation*() usage in dwarf_loader
> >   to avoid segmentation faults reported by Eduard (Jiri, Arnaldo,
> >   patch 2)
> 
> looks good, I got 95 more functions in clang build including perf_event_read
> and there's no change in generated functions with gcc build
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

I think since you tested it we can stick this, right?

Tested-by: Jiri Olsa <jolsa@kernel.org>
 
> thanks,
> jirka
> 
> > 
> > Alan Maguire (1):
> >   dwarf_loader: use libdw__lock for dwarf_getlocation(s)
> > 
> > Eduard Zingerman (1):
> >   dwarf_loader: Check DW_OP_[GNU_]entry_value for possible parameter
> >     matching
> > 
> >  dwarf_loader.c | 121 +++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 96 insertions(+), 25 deletions(-)
> > 
> > -- 
> > 2.31.1
> > 

