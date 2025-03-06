Return-Path: <bpf+bounces-53460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758B9A543EB
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 08:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C723A7C1A
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 07:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A551DC9B1;
	Thu,  6 Mar 2025 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+76IBHS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477464315F;
	Thu,  6 Mar 2025 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247439; cv=none; b=hpwtgflIjF8mjIMmhojXr1sYQW/srDLvDXCcgdGz/5bUOxXqC3FAvDPHZb6o0VPHb3D22L8Pu+KmWfPWIOJAHq2RvLD3QxT6e1A8LLU3DzB1KI36OV4+O73+uzRi4TUVDvhd13ScmCodHjXSc1LfbPg1bUn02wjjWBRM0prgdkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247439; c=relaxed/simple;
	bh=+vY9chWknPilNLXzUNVH0RQBHIclGuBPcRv00El1Mic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWVMbp++AltcGSMruzlyR93tsgx15ZZpvFZJlYXz2K5rE163prVcCOxjKy+wtr255dKoulvgdvRMgLM2+ITusTax1K7nfRgsgu9otOdj9K9Duya2N7uA3q7MAfgaBWMfCzOFKapwy62NCKPPinlwePNSALw2NNQ5B7qNZgnw8pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+76IBHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCBBC4CEE0;
	Thu,  6 Mar 2025 07:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741247439;
	bh=+vY9chWknPilNLXzUNVH0RQBHIclGuBPcRv00El1Mic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+76IBHSey2Hl/uLOgeRuzvGWedhUr7g944Y+vmd9t10P+wm2qr6VjouCpOmlZ7Du
	 4fTz/t7CiOPYIMyOlG/loK2xsH45yOKDGt01X6tqBsPXifxQ1izu/YBWQvrTNeY9VP
	 Y3bmvgxHZMnT6uZKHRZ6cHy0n1mI0trGy0o3UH09i63Wzr7R9cvyjMjzg//gYhaHoa
	 Okwl64Yzxnrd+DRpOCCWNQdVrLA+qT3uphstEajsaKF+jD5FMLZMnDLfhTUzoaCOo/
	 iK5EVCDZ/57x72SE8R3ECozZmF8hrMrxI3Sw3kVSArEjxR4C/az20hJZMj5RKU7Asc
	 TuKx4IlagHsfg==
Date: Wed, 5 Mar 2025 23:50:37 -0800
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
Message-ID: <Z8lTzROPDcoPQXFZ@google.com>
References: <20250305232838.128692-1-namhyung@kernel.org>
 <d962792a-c852-494b-b35c-e8f83cac7218@intel.com>
 <Z8lEdWxt8CKepTJ3@google.com>
 <bb2b30a1-8ce3-4565-b17a-27148234c10b@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb2b30a1-8ce3-4565-b17a-27148234c10b@intel.com>

On Thu, Mar 06, 2025 at 08:48:20AM +0200, Adrian Hunter wrote:
> On 6/03/25 08:45, Namhyung Kim wrote:
> > Hello,
> > 
> > On Thu, Mar 06, 2025 at 08:25:01AM +0200, Adrian Hunter wrote:
> >> On 6/03/25 01:28, Namhyung Kim wrote:
> >>> The length of PERF_RECORD_KSYMBOL for BPF is a size of JITed code so
> >>> it'd be 0 when it's not JITed.  The ksymbol is needed to symbolize the
> >>> code when it gets samples in the region but non-JITed code cannot get
> >>> samples.  Thus it'd be ok to ignore them.
> >>>
> >>> Actually it caused a performance issue in the perf tools on old ARM
> >>> kernels where it can refuse to JIT some BPF codes.  It ended up
> >>> splitting the existing kernel map (kallsyms).  And later lookup for a
> >>> kernel symbol would create a new kernel map from kallsyms and then
> >>> split it again and again. :(
> >>>
> >>> Probably there's a bug in the kernel map/symbol handling in perf tools.
> >>> But I think we need to fix this anyway.
> >>>
> >>> Reported-by: Kevin Nomura <nomurak@google.com>
> >>> Cc: Song Liu <song@kernel.org>
> >>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >>> ---
> >>>  tools/perf/util/machine.c | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> >>> index 3f1faf94198dbe56..c7d27384f0736408 100644
> >>> --- a/tools/perf/util/machine.c
> >>> +++ b/tools/perf/util/machine.c
> >>> @@ -779,6 +779,10 @@ int machine__process_ksymbol(struct machine *machine __maybe_unused,
> >>>  	if (dump_trace)
> >>>  		perf_event__fprintf_ksymbol(event, stdout);
> >>>  
> >>> +	/* no need to process non-JIT BPF as it cannot get samples */
> >>> +	if (event->ksymbol.len == 0)
> >>> +		return 0;
> >>
> >> Are all ksymbol events BPF?  Maybe it is OK
> >> for PERF_RECORD_KSYMBOL_TYPE_OOL also.  Perhaps adjust the
> >> comment in that case.
> > 
> > Probably, but I didn't see OOL with zero length yet.  Is it possible?
> 
> Probably not

Then I think it's ok to leave the comment as is.

Thanks,
Namhyung


