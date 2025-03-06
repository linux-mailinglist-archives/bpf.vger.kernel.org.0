Return-Path: <bpf+bounces-53457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D60A542FF
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 07:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C79F3AF75C
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 06:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C3536D;
	Thu,  6 Mar 2025 06:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqnZooV7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411B71A0BE0;
	Thu,  6 Mar 2025 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741243512; cv=none; b=JCBqS3vCd/XspFY/nzwIYww5YMdlc0QI04lPlPz3CyL0BKWXPlF1uc25fzFF1jJsZytw8kgU0Jcn+V4ArPW3hi5sBJnsmdfoFjiGMmvxPUkK+z8KtPxzrepLzcNl5C0Hh/XsUqT5QdB0Cuq3mGPzKW2AfmyLFk0bWDFwFwRBPNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741243512; c=relaxed/simple;
	bh=GLDFpWa9p6ur71vANNFod64M62p+KiTefovBzlACU4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urHnHniNan81lf4X8kTTlYpdDmu4AFSzZjkn3luJ0SrrDinW5tcp1jBHMtA+aNVXCM7ZhK7eqA/zdMoVqYtxLNQbzWbtEE3xplECrJwpKxrReGyfVd2IRGlwNt8K0EQ7e15nzdgusG+zBUT53AULNL4v8Ay4hiZrgc4DvAvFskw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqnZooV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EFBC4CEE4;
	Thu,  6 Mar 2025 06:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741243511;
	bh=GLDFpWa9p6ur71vANNFod64M62p+KiTefovBzlACU4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fqnZooV7JonBPPbUC8OkkmA3A8hxkP/IdURpSFSEdeG5nSzC1L6PT2B2J+ApQPIV5
	 CKsVvxVYXjxjemTNZli8ZnlpkDS4Qc1BtdZmaQ45EClQsrWW9M1rbx2DzmvLGua3Pa
	 VQghnGbEIjZ45noMgUy4aP81OrVgOSu7yelz4OWQOSopXvRZp5CPgb08iloKJmxK86
	 CnUNL15yIR2N8njPWRpqDahOKNMcnPWbE4Xfi4v71CCpdqdcEQ6XA2PI2g307R0Aqs
	 BT6fucET9B3P6Bl/Vxpog57t8oslkrPDfb7Ar5enQTZ7gYJSXBvhoONe5m5gIkGK12
	 i/HOtuFjApH8w==
Date: Wed, 5 Mar 2025 22:45:09 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Kevin Nomura <nomurak@google.com>, Song Liu <song@kernel.org>
Subject: Re: [PATCH] perf report: Do not process non-JIT BPF ksymbol events
Message-ID: <Z8lEdWxt8CKepTJ3@google.com>
References: <20250305232838.128692-1-namhyung@kernel.org>
 <d962792a-c852-494b-b35c-e8f83cac7218@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d962792a-c852-494b-b35c-e8f83cac7218@intel.com>

Hello,

On Thu, Mar 06, 2025 at 08:25:01AM +0200, Adrian Hunter wrote:
> On 6/03/25 01:28, Namhyung Kim wrote:
> > The length of PERF_RECORD_KSYMBOL for BPF is a size of JITed code so
> > it'd be 0 when it's not JITed.  The ksymbol is needed to symbolize the
> > code when it gets samples in the region but non-JITed code cannot get
> > samples.  Thus it'd be ok to ignore them.
> > 
> > Actually it caused a performance issue in the perf tools on old ARM
> > kernels where it can refuse to JIT some BPF codes.  It ended up
> > splitting the existing kernel map (kallsyms).  And later lookup for a
> > kernel symbol would create a new kernel map from kallsyms and then
> > split it again and again. :(
> > 
> > Probably there's a bug in the kernel map/symbol handling in perf tools.
> > But I think we need to fix this anyway.
> > 
> > Reported-by: Kevin Nomura <nomurak@google.com>
> > Cc: Song Liu <song@kernel.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/machine.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 3f1faf94198dbe56..c7d27384f0736408 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -779,6 +779,10 @@ int machine__process_ksymbol(struct machine *machine __maybe_unused,
> >  	if (dump_trace)
> >  		perf_event__fprintf_ksymbol(event, stdout);
> >  
> > +	/* no need to process non-JIT BPF as it cannot get samples */
> > +	if (event->ksymbol.len == 0)
> > +		return 0;
> 
> Are all ksymbol events BPF?  Maybe it is OK
> for PERF_RECORD_KSYMBOL_TYPE_OOL also.  Perhaps adjust the
> comment in that case.

Probably, but I didn't see OOL with zero length yet.  Is it possible?

Thanks,
Namhyung


