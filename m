Return-Path: <bpf+bounces-27052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA778A84FD
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 15:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283C61C20DD1
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 13:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEFE13FD62;
	Wed, 17 Apr 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3frWAbK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4C813F449;
	Wed, 17 Apr 2024 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361200; cv=none; b=Hcjv1zD3ApCLoLdrv96O+58JiLmAr0235OeEvlaoiuuydVOD/4Tp5lPaTI4qAyHRclL3nypflSFg3YX+ekyAkbfgGC0HbOW9BV87PU2yJBAU9OL3CaVj1AS918fd7Smnm/BSiCHoff0Q3luW6uU6kGJrwqRsh2DUphTpsBFbReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361200; c=relaxed/simple;
	bh=b/sDQSq5JjwUA6lrjG6U3vqq2NaTsKZLOqjslzcjaPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQibolCKgpF3dtCvNU1NPfn8B5guDxKRFP5oL1kceOgOmpoIoqQupt0ksKv8aSAjHEEbpst5LRhH1ex+I5reL12mbycw+fKXgngIgYlNLwrLMHPpqWSxLE0ZZlwHURYRWfw8k0NNej2QZaCBAos0gdbIQQ0mAldGsaHebu8wBIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3frWAbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE70DC072AA;
	Wed, 17 Apr 2024 13:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713361200;
	bh=b/sDQSq5JjwUA6lrjG6U3vqq2NaTsKZLOqjslzcjaPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3frWAbKid/PFYHRRbptixtGcA2rMU0xjx0kj6bXI+3GdbUHAYfUO9WURlMmxkr+4
	 EWl0ebX7frfwTRdfEC/HXAB/ldZIORDKJ/v5Bhw9QJI/mo5TZP0qkLbFQgPPaib+jb
	 fCNud3ASO8Lywj+Idh5ZHXx3Ze1Hpl0pHCP1SP+kjmfaqluWM/eAQWoHX4BMZ+8A1G
	 J2nAZoYzItEe6qqMwaeO2uaeb35ORQq3P6+w+t79IwBP9VvwRHQxkMMWRlf3z7EhK5
	 HEwrXkZl4hJVwOgnersh85w8K/xnDFXU7KfmwNlSk3nOhdZ+hSsQNSf8zJOtiHvhpk
	 vmHVResSMaxpw==
Date: Wed, 17 Apr 2024 10:39:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>,
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	anshuman.khandual@arm.com, Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linaro.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Chenyuan Mi <cymi20@fudan.edu.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
	Colin Ian King <colin.i.king@gmail.com>,
	Changbin Du <changbin.du@huawei.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Georg =?iso-8859-1?Q?M=FCller?= <georgmueller@gmx.net>,
	Liam Howlett <liam.howlett@oracle.com>, bpf@vger.kernel.org,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/8] perf tools: Fix test "perf probe of function from
 different CU"
Message-ID: <Zh_RLG7a1xauRNK1@x1>
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
 <d0dc91b6-98ee-4ddd-b0a9-ba74e1b6c85f@p183>
 <f57685aa-fdbf-4625-900b-d612ffb747f3@arm.com>
 <2d7a896b-bbee-4285-9b2b-3edfab6797d3@p183>
 <1b52699d-8f92-4a79-89aa-c4df1594e8b1@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b52699d-8f92-4a79-89aa-c4df1594e8b1@arm.com>

On Wed, Apr 17, 2024 at 02:24:33PM +0100, James Clark wrote:
> On 14/04/2024 12:41, Alexey Dobriyan wrote:
> > On Thu, Apr 11, 2024 at 05:40:04PM +0530, Chaitanya S Prakash wrote:
> >> On 4/9/24 11:02, Alexey Dobriyan wrote:
> >>> On Mon, Apr 08, 2024 at 11:52:22AM +0530, Chaitanya S Prakash wrote:
> >>>> - Add str_has_suffix() and str_has_prefix() to tools/lib/string.c
> >>>> - Delete ends_with() and replace its usage with str_has_suffix()
> >>>> - Delete strstarts() from tools/include/linux/string.h and replace its
> >>>>    usage with str_has_prefix()
> >>> It should be the other way: starts_with is normal in userspace.
> >>> C++, Python, Java, C# all have it. JavaScript too!
> >>
> >> This is done in accordance with Ian's comments on V1 of this patch
> >> series. Please find the link to the same below.
> > 
> > Yes, but str_has_suffix() doesn't make sense in the wider context.
> > 
> >> https://lore.kernel.org/all/CAP-5=fUFmeoTjLuZTgcaV23iGQU1AdddG+7Rw=d6buMU007+1Q@mail.gmail.com/
> > 
> > 	The naming ends_with makes sense but there is also strstarts and
> > 	str_has_prefix, perhaps str_has_suffix would be the most consistent
> > 	and intention revealing name?
 
> From a brief check it looks like str_has_prefix() is already quite
> common with 94 uses. So the path of least resistance is to make
> everything self consistent and add str_has_suffix().
 
> I agree it's a bit of a mouthful and not so common in other languages.
> Once this more complicated set gets through we could always do a simple
> search and replace change it to anything we like. But it would touch
> _lots_ of different drivers and trees, so it would be hard to justify.

Right, we try to follow the kernel APIs to make tools/perf more familiar
to kernel developers, this return strlen() thing on str_has_prefix()
looked too clever for me at first, but since we need to do it anyway,
and return !0 to indicate it has the prefix and there are usecase...

The bpftool people agreed as well, so in tools/ it seems we're in
general agreement about using str_has_{prefix,suffix}().

- Arnaldo

