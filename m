Return-Path: <bpf+bounces-28009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5818B438A
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 03:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A532836BE
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 01:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C4D383A0;
	Sat, 27 Apr 2024 01:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crPCgKfT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9670629409;
	Sat, 27 Apr 2024 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714181762; cv=none; b=j0oN+MVezT/h5nL5NVxgimxaasAtB2u6mcy9YQisAc4TCpWIw257/Tc6DhaW+nnkMGnKcjWN8/uGkbP6QcT4MgWfRI0etiYpIgAsG8feRvSjTJjA7o5mlpsnJgrLsFaQO+rDFnAkhOi2CyzOd51QkFQrPFRLJ4jdhNi0H7zbkuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714181762; c=relaxed/simple;
	bh=FgfvRvIIdKg5M8VTG3GygY/t5MgGGpquPipWcwa1BbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+48JnWoMarxgQuLl/RV6ZF38S7Zg8irtvAngLh92yFJNCXxhTT9xBDnZaa5PlhdXF0hCWzuyGdoChS3/zu3kw8guOxxsHc69msP+LMQ8CUifzdRdoB1aiPvliUUK+ptcPjp5jHpLWxHU/+cBy9cLixF2q8W05h/8rJXOZDnLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crPCgKfT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C975BC113CD;
	Sat, 27 Apr 2024 01:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714181762;
	bh=FgfvRvIIdKg5M8VTG3GygY/t5MgGGpquPipWcwa1BbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=crPCgKfTrZI69WjN8uB5eiXzpb46kN+36v9HtC11O3fsfXHLHCxx4LumYSIVXGZpT
	 GFChac4esj36x6sTMDjqAysyEJsaPuTEWkvtMccXpAwwU2Yh4ruGaPZGnI6HxnewQ/
	 4dG4NxFuN2z88eMrNpP8EYtaBiUiWizerlJcCqv18uLVpMpU/8g16sknhT9VI/24Ak
	 Bn7vtTKjfPi8C9KApCmf86JnFIDRAamOCKfy9dkblIZz+ZUA0//6+pxHIh2L3fBbVm
	 em9eaZqR8Re8l806rzxaBfTFvzK9UVPHTY9YCJgEp2XqpNaxm6v6aom0dn0Dh31pAu
	 vg7ungBkC2sTg==
Date: Fri, 26 Apr 2024 22:35:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org,
	Beeman Strong <beeman@rivosinc.com>
Subject: Re: [PATCH v2 11/16] perf parse-events: Improve error message for
 bad numbers
Message-ID: <ZixWfypP4FtKgv0F@x1>
References: <20240416061533.921723-1-irogers@google.com>
 <20240416061533.921723-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416061533.921723-12-irogers@google.com>

On Mon, Apr 15, 2024 at 11:15:27PM -0700, Ian Rogers wrote:
> Use the error handler from the parse_state to give a more informative
> error message.
> 
> Before:
> ```
> $ perf stat -e 'cycles/period=99999999999999999999/' true
> event syntax error: 'cycles/period=99999999999999999999/'
>                                   \___ parser error
> Run 'perf list' for a list of valid events
> 
>  Usage: perf stat [<options>] [<command>]
> 
>     -e, --event <event>   event selector. use 'perf list' to list available events
> ```
> 
> After:
> ```
> $ perf stat -e 'cycles/period=99999999999999999999/' true
> event syntax error: 'cycles/period=99999999999999999999/'
>                                   \___ parser error
> 

This ended up in perf-tools-next, will have to look at what this problem
is:

   9    11.46 amazonlinux:2                 : FAIL gcc version 7.3.1 20180712 (Red Hat 7.3.1-17) (GCC) 
     yy_size_t parse_events_get_leng (yyscan_t yyscanner );
               ^~~~~~~~~~~~~~~~~~~~~
    util/parse-events.l:22:5: note: previous declaration of 'parse_events_get_leng' was here
     int parse_events_get_leng(yyscan_t yyscanner);
         ^~~~~~~~~~~~~~~~~~~~~
     yy_size_t parse_events_get_leng  (yyscan_t yyscanner)
               ^~~~~~~~~~~~~~~~~~~~~
    util/parse-events.l:22:5: note: previous declaration of 'parse_events_get_leng' was here
     int parse_events_get_leng(yyscan_t yyscanner);
         ^~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [util] Error 2


Unsure if this will appear on the radar on other distros, maybe this is
just something that pops up with older distros...

Ran out of time today...

- Arnaldo

