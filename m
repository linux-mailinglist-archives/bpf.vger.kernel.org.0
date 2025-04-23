Return-Path: <bpf+bounces-56522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3E4A996E6
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 19:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBA71731B8
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 17:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F5B28C5DB;
	Wed, 23 Apr 2025 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTRxz3ej"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF726561E;
	Wed, 23 Apr 2025 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430118; cv=none; b=VgV040Bm1JFstbpu029S7H3zePDXE7rvpl41zNJ6Zh+D2JlzUYoeBkCAHfRDTkKDnlIeoAGRWBvfruQ0D00vHIJkn4At5/lvcxC8YeBEspOTqyrFgw2xFcn7o9weyIY2QNRakmUVsT4Y5K/sw6f6Km7h3KoqQ+Hyh1ZKlqoxX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430118; c=relaxed/simple;
	bh=xxDEXBF4JOStXbO8ET7ZNLV54di3BzCWH33hKVBt2ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I60lr/bvNK8p5iXxiAAZBbO7jQZjdHXaktCDnFNkzz/UlsjpJtiz5fK1HsGsiAmJTlVVq+RlN9BIvs9GuzE6AE/lacONNCp2XE1d+RrCBDZArgBlUG5zDSL88cwmO/1pSAyOdOkIWgQdQZUMKWIUnFXI+G7ZtqVEYUArs4zjUYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTRxz3ej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41F3C4CEEE;
	Wed, 23 Apr 2025 17:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745430117;
	bh=xxDEXBF4JOStXbO8ET7ZNLV54di3BzCWH33hKVBt2ME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fTRxz3ejXHjFcP3WcXvwUtu9b2s4sD4wHmnBIWzmOlNhMQfv4QTr9K35qcsboFZh8
	 8LDtsDVIuqpzW0RQhR0b3wK0Gu6VoSNeP6aoHWH+CzVo8T5vG1frkdilVs9hQHS5VC
	 Yc/1nJTIKM11meo5QpXvyicsiQkxwF0S6nnlStQaI1gMoNlD073xQP+QJ40w/T3JWQ
	 GJEE21eN9iGSHVMNPzfTFybdr1hCgm1ZWOl8/UdFZ0yEXV62YhNIul6+XCNXlX4Y87
	 3AuRAoyo9NDQlYEKksB2iNe5pL33MwSaQtfn1okUmwewtXxenyQOspigVe1iz6eDWd
	 qQez9mwkyntSw==
Date: Wed, 23 Apr 2025 10:41:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 1/2] perf trace: Implement syscall summary in BPF
Message-ID: <aAkmY0hLXarmCSIA@google.com>
References: <20250326044001.3503432-1-namhyung@kernel.org>
 <CAH0uvojPaZ-byE-quc=sUvXyExaZPU3PUjdTYOzE5iDAT_wNVA@mail.gmail.com>
 <aAkUyFjRFLkS170u@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aAkUyFjRFLkS170u@x1>

Hi Arnaldo,

On Wed, Apr 23, 2025 at 01:26:48PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Mar 28, 2025 at 06:46:36PM -0700, Howard Chu wrote:
> > Hello Namhyung,
> > 
> > On Tue, Mar 25, 2025 at 9:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > When -s/--summary option is used, it doesn't need (augmented) arguments
> > > of syscalls.  Let's skip the augmentation and load another small BPF
> > > program to collect the statistics in the kernel instead of copying the
> > > data to the ring-buffer to calculate the stats in userspace.  This will
> > > be much more light-weight than the existing approach and remove any lost
> > > events.
> > >
> > > Let's add a new option --bpf-summary to control this behavior.  I cannot
> > > make it default because there's no way to get e_machine in the BPF which
> > > is needed for detecting different ABIs like 32-bit compat mode.
> > >
> > > No functional changes intended except for no more LOST events. :)
> > >
> > >   $ sudo ./perf trace -as --summary-mode=total --bpf-summary sleep 1
> > >
> > >    Summary of events:
> > >
> > >    total, 6194 events
> > >
> > >      syscall            calls  errors  total       min       avg       max       stddev
> > >                                        (msec)    (msec)    (msec)    (msec)        (%)
> > >      --------------- --------  ------ -------- --------- --------- ---------     ------
> > >      epoll_wait           561      0  4530.843     0.000     8.076   520.941     18.75%
> > >      futex                693     45  4317.231     0.000     6.230   500.077     21.98%
> > >      poll                 300      0  1040.109     0.000     3.467   120.928     17.02%
> > >      clock_nanosleep        1      0  1000.172  1000.172  1000.172  1000.172      0.00%
> > >      ppoll                360      0   872.386     0.001     2.423   253.275     41.91%
> > >      epoll_pwait           14      0   384.349     0.001    27.453   380.002     98.79%
> > >      pselect6              14      0   108.130     7.198     7.724     8.206      0.85%
> > >      nanosleep             39      0    43.378     0.069     1.112    10.084     44.23%
> > >      ...
> 
> I added the following to align sched_[gs]etaffinity,

Thanks for processing the patch and updating this.  But I'm afraid there
are more syscalls with longer names and this is not the only place to
print the syscall names.  Also I think we need to update length of the
time fields.  So I prefer handling them in a separate patch later.

Thanks,
Namhyung
 
> 
> diff --git a/tools/perf/util/bpf-trace-summary.c b/tools/perf/util/bpf-trace-summary.c
> index 114d8d9ed9b2d3f3..af37d3bb5f9c42e7 100644
> --- a/tools/perf/util/bpf-trace-summary.c
> +++ b/tools/perf/util/bpf-trace-summary.c
> @@ -139,9 +139,9 @@ static int print_common_stats(struct syscall_data *data, FILE *fp)
>  		/* TODO: support other ABIs */
>  		name = syscalltbl__name(EM_HOST, node->syscall_nr);
>  		if (name)
> -			printed += fprintf(fp, "   %-15s", name);
> +			printed += fprintf(fp, "   %-17s", name);
>  		else
> -			printed += fprintf(fp, "   syscall:%-7d", node->syscall_nr);
> +			printed += fprintf(fp, "   syscall:%-9d", node->syscall_nr);
>  
>  		printed += fprintf(fp, " %8u %6u %9.3f %9.3f %9.3f %9.3f %9.2f%%\n",
>  				   stat->count, stat->error, total, min, avg, max,

