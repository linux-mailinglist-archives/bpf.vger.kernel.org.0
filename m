Return-Path: <bpf+bounces-46871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AFD9F1349
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 18:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA563281499
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 17:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA1D1E47AD;
	Fri, 13 Dec 2024 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLSB5NV7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1886A17C21E;
	Fri, 13 Dec 2024 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109815; cv=none; b=Ek6fvjLs/MjxlnzoFS3CmvxyGR3aMM+UMPgLLNUOdFZDsTucwWf7QuJpDa5NayThIatZ4TJt291UuDWO2xi39E1XfVxCl638AuFSrLzJsfAZH906wtaHiSiajiA8l+h7B/T+HabJWrWIy4LXFSrrYci/9xw/Qfr1ymsl6M+DPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109815; c=relaxed/simple;
	bh=FzbxNtPRI9eJSeo8RCJjgFaAAq9gXHyaLbj1CzzKD8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxJ8E7Wwa6N/vF/xLgxJ3hk8yl0kZIgil2hBADnMZ4JvDdgYRqDnw027dcl536q/MfanfTCV5oTo5aQjRU5KHuCdePAf601xt6iY6KLVlhGFILPMiYV3wCpq6IbrvFDxnDH++qQZUEA0XBWxXK2nWbbEg8IIzucAmdTFnZMjTpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLSB5NV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF73C4CED0;
	Fri, 13 Dec 2024 17:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734109814;
	bh=FzbxNtPRI9eJSeo8RCJjgFaAAq9gXHyaLbj1CzzKD8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LLSB5NV7qLwPeUWsPfcfbfreuZjY4hYPf9J+yxiOD+gJdl6N7KFAQArDJ8a4dFWx0
	 FwCuqwbwOpMF0fhib95adoQ6urHuUg2tUMs20eJXhMVDMZg18u6b3iS7SnZcqka7K5
	 BwgLPiWP2h+lWwacvklTgbZ8D6MNWyCYCNCqFuD9NYtwa2ovDMolOxZMMBd6Sr/WDX
	 X9b143zzvPsrGosV45ozXfsLoxBfrBmMAkjEMXUrCnUzrpd6Ywu/y233fl827WQU3e
	 JT+C5rF2uaP9h6RYmYBBPxX3WRRkOlGJM++6VJ13iEqM6i5gixFszEEMvzkrlXjSu8
	 8jJTkdoTF45mw==
Date: Fri, 13 Dec 2024 09:10:12 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 0/4] perf lock contention: Symbolize locks using slab
 cache names
Message-ID: <Z1xqdFB0210tP3RY@google.com>
References: <20241108061500.2698340-1-namhyung@kernel.org>
 <CAP-5=fWqE6bM=MVQy7P0tTSWW-ZBXY4in_bfQYFK-C4h6L-Ykw@mail.gmail.com>
 <ZzuI_08huDfK0Vvu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzuI_08huDfK0Vvu@google.com>

Hello,

On Mon, Nov 18, 2024 at 10:35:43AM -0800, Namhyung Kim wrote:
> On Mon, Nov 11, 2024 at 11:46:37AM -0800, Ian Rogers wrote:
> > On Thu, Nov 7, 2024 at 10:15 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > This is to support symbolization of dynamic locks using slab
> > > allocator's metadata.  The kernel support is in the bpf-next tree now.
> > >
> > > It provides the new "kmem_cache" BPF iterator and "bpf_get_kmem_cache"
> > > kfunc to get the information from an address.  The feature detection is
> > > done using BTF type info and it won't have any effect on old kernels.
> > >
> > > v2 changes)
> > >
> > >  * don't use libbpf_get_error()  (Andrii)
> > >
> > > v1) https://lore.kernel.org/linux-perf-users/20241105172635.2463800-1-namhyung@kernel.org
> > >
> > > With this change, it can show locks in a slab object like below.  I
> > > added "&" sign to distinguish them from global locks.
> > 
> > I know the & is intentional but I worry it could later complicate
> > parsing of filters. Perhaps @ is a viable alternative. Other than
> > that:
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> 
> Thanks for the review!
> 
> I don't think it clashes with BPF sample filters which works on sample
> data generated from a perf_event.  Technically this command doesn't use
> perf_event and just attaches the BPF program to tracepoint directly.
> 
> Also sample filters don't use '&' symbol in the syntax as of now. :)

Can we merge this series if no more feedback?

About the build issue, I think it's transient and it's not the default
to build with generated vmlinux.h.  We could disable the generation but
it might be better to keep it to test other issues.  Anyway, it can be
done independently.

Thanks,
Namhyung


