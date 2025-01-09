Return-Path: <bpf+bounces-48455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A3EA081F9
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CC7188CD94
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB014202F71;
	Thu,  9 Jan 2025 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWGwwdk7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651DB77102;
	Thu,  9 Jan 2025 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736457017; cv=none; b=VTKuYjzdWpeoW3/X1mxpKrkEvxnAaqOFvYEXgKM+pylevPyWxlDyDkghXEy00e4A+QLErF6PDqGY9XAoCVpdymZm1jyD44ZyjQV9n/i531U+unSs23VLqyXFvPRK2PbgwKseVGkaGgcq//8eJSvuQ3Vcp8Tin0wlcH5vuUBiRMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736457017; c=relaxed/simple;
	bh=V/DZsdTjbKeJFInZ/Oe4P/8D9ybp8q16WfD6DOFlXwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DU9jzNLHkC5l0y6Szd2x4MysACjbrh+WIObkn7WcTEWg5DT5ixvTL/W908INXGTNEVmT/30sAe/CfKED1YF2cLjXvz7ztdQGxDczYNh/TPR1x3TZ+raDtt4Niqi1ldiAcPd+LoAgl6wp33qsojYqTDXNoW3Dm0nGTG+6kQJKsj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWGwwdk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E49C4CED2;
	Thu,  9 Jan 2025 21:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736457016;
	bh=V/DZsdTjbKeJFInZ/Oe4P/8D9ybp8q16WfD6DOFlXwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LWGwwdk7xBuJrFN5f4Im3H5GGcQmxcMTkLNoNntupVCSoXZcZJsNvAN+BqQ6Kq9yK
	 q8eltPEkbW1zbzGojIC668/3+CIdR4YPkuaANWx5njKMVqd9vg2zP5wanNMGHTwc4j
	 8R7YFLgAuH1mjkTEvX8faQNetm7aAhDiTdCyLBYnE8Xi/K7ScoZ9AGlmEzvpxKnsNR
	 xc0dQjGHvKBeedlB80nAczERAVAaboN8BcWV7gKdX/Ba1Fp8Ihrk2DLeG87vFHajlq
	 Lic0dN14f5yLOcc6M6kIrXxI+qXQgUWaUsefaWndw4WnJJ+3pjmBPfUTZ+tUjV31Qs
	 JF+1qlqIbum9A==
Date: Thu, 9 Jan 2025 18:10:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH] perf trace: Fix unaligned access for augmented args
Message-ID: <Z4A7NdLPeXmplTXA@x1>
References: <20250102201248.790841-1-namhyung@kernel.org>
 <Z4AZiTNhI9qKGYh3@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4AZiTNhI9qKGYh3@x1>

On Thu, Jan 09, 2025 at 03:46:33PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jan 02, 2025 at 12:12:47PM -0800, Namhyung Kim wrote:
> > Some version of compilers reported unaligned accesses in perf trace when
> > undefined-behavior sanitizer is on.  I found that it uses raw data in the
> > sample directly and assuming it's properly aligned.

> > Unlike other sample fields, the raw data is not 8-byte aligned because
> > there's a size field (u32) before the actual data.  So I added a static
> > buffer in syscall__augmented_args() and return it instead.  This is not
> > ideal but should work well as perf trace is single-threaded.
 
> > A better approach would be aligning the raw data by adding a 4-byte data
> > before the augmented args but I'm afraid it'd break the backward
> > compatibility.
  
> You mean for 'perf trace record' files?
 
> Older tools will not be able to process new files, while old files will
> be remain processable by new tools if we insert a u32 with zeroes before
> the size field, that way if the first u32 is not zero, we do as you do
> below and incur the cost of copying to that intermediary buffer,
> otherwise we read the real size in the next u32 and don't incur the cost
> of copying.
 
> Your fix below works as it incurs the cost all the time, which is ok for
> now, but as a follow up patch we can see if the approach I described
> above works.
 
> Applying.

Applied, and forget about my suggestion above, as we discussed this is
not feasible, I added these notes to your patch:

   Committer testing:
    
    To build with the undefined behaviour sanitizer:
    
     $ make CC=clang EXTRA_CFLAGS=-fsanitize=undefined -C tools/perf
    
    Checking if the resulting binary is instrumented:
    
      root@number:~# nm ~/bin/perf | grep ubsan | wc -l
      113
      root@number:~# nm ~/bin/perf | grep ubsan | tail -5
      000000000043d5b0 t _ZN7__ubsanL19UBsanOnDeadlySignalEiPvS0_
      000000000043ce50 T _ZNK7__ubsan5Value12getSIntValueEv
      000000000043cf40 T _ZNK7__ubsan5Value12getUIntValueEv
      000000000043d140 T _ZNK7__ubsan5Value13getFloatValueEv
      000000000043cfd0 T _ZNK7__ubsan5Value19getPositiveIntValueEv
      root@number:~#
    
    Now running something that will access timespec, as reported in the
    Closes URL:
    
      root@number:~# perf trace --max-events=1 -e *nano* sleep 1.1
      trace/beauty/timespec.c:10:64: runtime error: member access within misaligned address 0x7fc583cfb2a4 for type 'struct augmented_arg', which requires 8 byte alignment
      0x7fc583cfb2a4: note: pointer points here
        99 99 11 00 10 00 00 00  00 00 00 00 01 00 00 00  00 00 00 00 01 e1 f5 05  00 00 00 00 00 00 00 00
                    ^
      SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior trace/beauty/timespec.c:10:64
      <SNIP>
    
    As Namhyung said we need to make the raw_data to be 64-bit aligned,
    probably we need to add a PERF_SAMPLE_ALIGNED_RAW with a 64-bit raw_size
    instead of the current u32 done at kernel/events/core.c,
    perf_output_sample(), that perf_output_put(handle, raw->size) where
    raw->size is an u32 and then the raw_data is always 64-bit unaligned...
    
    After the patch:
    
      root@number:~# perf trace -e *nano* sleep 1.1
           0.000 (1100.064 ms): sleep/1984224 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 100000001 }, rmtp: 0x7fff5b3fe970) = 0
      root@number:~#


