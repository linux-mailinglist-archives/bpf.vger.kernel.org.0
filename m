Return-Path: <bpf+bounces-43770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D60529B98A1
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816C71F2522D
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5908C1E2855;
	Fri,  1 Nov 2024 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYlgEYUy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50081CF5DE;
	Fri,  1 Nov 2024 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489380; cv=none; b=PwOTWUI/2ZDcA4NTmXalnM+CuUGAMN+Zm82TdtE01JoBWFfGuIeNnaeMLYyagv2CbBEz+ErW+59cfml19EZgsFCLC1OAqH2RvQqeZ6MezcQm1eb6dZ+E5HE0kNAofV1tJF89oo6nWO02fxbpv2pIc7hpG91RkvDY3ZbDTiYVlnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489380; c=relaxed/simple;
	bh=tMMEau3NtPnyAeHx8uGed61FAphZVULNuA9qHtBhhOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsWKWrb8Ilao0xp8fL6PB/UwqKh6yfrKrx9012vPHYvsQkDmcsdqkpY1Ni/mnPv/ViUSCLUmv8JNHmeMpFmc+PjaAYY3epUx3CkhM0+KYWMDf8BJvNLupOyyvkEOjc+WAO6JGHbHKTD0bBFvM6XpsBhvYrFJcfPAT9u2N9i9YsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYlgEYUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6C4C4CECD;
	Fri,  1 Nov 2024 19:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730489380;
	bh=tMMEau3NtPnyAeHx8uGed61FAphZVULNuA9qHtBhhOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYlgEYUyOZizWXWR8eNVvJc/QqHohbl60GpAPw3rCs6NZAduJJyXWrK+9LLSPQanO
	 o/peCEWjEKNFFohrBB01XWsrx4sDpMLqHvdIygolfEUswTt/ryyvlx3de5SgK/ZubQ
	 JMQPTMACdQD3wGVsrfDJX2YfK8vgkQLErPyRIgQEbIdoyAYg7rfCXaKUFyVH9T9qau
	 ZhcABDQZLZVdDFwgGa41dxLej7yVMQo1o+LXcIdPOGLACbMqhLpULWpKh5xXDp+aHl
	 PwbTeiyOE13V5hc8RBriybTJaUYgAwD4GRm1+zio0HAEYmGA/nJxKyXlX2SehqvJJR
	 ZrH3uUg2RMkww==
Date: Fri, 1 Nov 2024 12:29:37 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Message-ID: <20241101192937.opf4cbsfaxwixgbm@jpoimboe>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com>
 <20241030055314.2vg55ychg5osleja@treble.attlocal.net>
 <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>
 <20241031230313.ubybve4r7mlbcbuu@jpoimboe>
 <CAEf4BzaQYqPfe2Qb5n71JVAAD3-1Q7q2+_cnQMQEa43DvV5PCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzaQYqPfe2Qb5n71JVAAD3-1Q7q2+_cnQMQEa43DvV5PCQ@mail.gmail.com>

On Fri, Nov 01, 2024 at 11:34:48AM -0700, Andrii Nakryiko wrote:
> 00200000-170ad000 r--p 00000000 07:01 5
> 172ac000-498e7000 r-xp 16eac000 07:01 5
> 49ae7000-49b8b000 r--p 494e7000 07:01 5
> 49d8b000-4a228000 rw-p 4958b000 07:01 5
> 4a228000-4c677000 rw-p 00000000 00:00 0
> 4c800000-4ca00000 r-xp 49c00000 07:01 5
> 4ca00000-4f600000 r-xp 49e00000 07:01 5
> 4f600000-5b270000 r-xp 4ca00000 07:01 5
>
> Sorry, I'm probably dense and missing something. But from the example
> process above, isn't this check violated already? Or it's two
> different things? Not sure, honestly.

It's hard to tell exactly what's going on, did you strip the file names?

The sframe limitation is per file, not per address space.  I assume
these are one file:

> 172ac000-498e7000 r-xp 16eac000 07:01 5

and these are another:

> 4c800000-4ca00000 r-xp 49c00000 07:01 5
> 4ca00000-4f600000 r-xp 49e00000 07:01 5
> 4f600000-5b270000 r-xp 4ca00000 07:01 5

Multiple mappings for a single file is fine, as long as they're
contiguous.

> > Actually I just double checked and even the kernel's ELF loader assumes
> > that each executable has only a single text start+end address pair.
> 
> See above, very confused by such assumptions, but I'm hoping we are
> talking about two different things here.

The "contiguous text" thing seems enforced by the kernel for
executables.  However it doesn't manage shared libraries, those are
mapped by the loader, e.g. /lib64/ld-linux-x86-64.so.2.

At a quick glance I can't tell if /lib64/ld-linux-x86-64.so.2 enforces
that.

> > There's no point in adding complexity to support some hypothetical.  I
> > can remove the printk though.
> 
> We are talking about fundamental things like format for supporting
> frame pointer-less stack trace capture. It will take years to adopt
> SFrame everywhere, so I think it's prudent to think a bit ahead beyond
> just saying "no real application should need more than 4GB text", IMO.

I don't think anybody is saying that...

-- 
Josh

