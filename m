Return-Path: <bpf+bounces-65157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 226E7B1CF37
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 00:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A963AB13F
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 22:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511612356BA;
	Wed,  6 Aug 2025 22:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIM0ppN8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A1D13A3F2;
	Wed,  6 Aug 2025 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754520794; cv=none; b=TAzR9fBYvllJZ09sbu+bWizZAaHWNZhDiZPz/+Jd2RMLjkiCazarZSp9e53fgf0r+VND2q2a3rtVyfzeOaOfe4WQxWNxhA408vkaeI6z+FLG0uxj60fsY0jjnIuOynAd9p9o+QRE5lZmQ2PFskOp1l5OMKPtSLWuRU4e1/D0ezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754520794; c=relaxed/simple;
	bh=aQ/0Dh3y8KRuO5nNN3e4yGDJrs5zHxpjrom8VAttomI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6tF1Fcnxvx+RhuSL/swA8l9oua6pyJ4MTXKhNLbdLJTH70QbITMptP37Q3Kb+lH1ZhVRSvrJyjA0VkOmRtZg0txE80V4CTBqxMbh2WdtF9ZPS+5Ns5rUTJ1dWyce0XKw/WDhyT1Y1o3DvFgsP18ijSM59RALIMytv2jJIVYJp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIM0ppN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1FEC4CEE7;
	Wed,  6 Aug 2025 22:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754520794;
	bh=aQ/0Dh3y8KRuO5nNN3e4yGDJrs5zHxpjrom8VAttomI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIM0ppN88Z7flsAgbKGOZcK6GIwviab7UaqjGLaSnHIRa1Yup7lsN5JZzecYTk/7j
	 OcxABp1dPJ4Iw7UTtcHJCYD4eWVhHBvZwljJAH+ntNK1xpKRatojIViTxBKtKBV4+C
	 np8iZu46T7YEkqoZgPMBC/Neb19nESIsqf5GB5IZkLd1dpvK3m7BNVB3shuSRR1MS+
	 82CG69YMAAFg37R6qV6tp1X2aXm7Nm4VNyoif9+WxUGwsBLDl+G4e5DVb3EESqvD6q
	 K/cq/0R/XJXpGMDOtdmqDqKkG7+EvG444pIHwJCXL4H9DG9Qy1PVgiL8eEVm8M3UpE
	 k5CI8GNw/nqOg==
Date: Wed, 6 Aug 2025 15:53:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>,
	Jiri Olsa <jolsa@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v4 2/2] perf bpf-filter: Enable events manually
Message-ID: <aJPc2NvJqLOGaIKl@google.com>
References: <20250806114227.14617-1-iii@linux.ibm.com>
 <20250806114227.14617-3-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250806114227.14617-3-iii@linux.ibm.com>

Hello,

On Wed, Aug 06, 2025 at 01:40:35PM +0200, Ilya Leoshkevich wrote:
> On s390, and, in general, on all platforms where the respective event
> supports auxiliary data gathering, the command:
> 
>    # ./perf record -u 0 -aB --synth=no -- ./perf test -w thloop
>    [ perf record: Woken up 1 times to write data ]
>    [ perf record: Captured and wrote 0.011 MB perf.data ]
>    # ./perf report --stats | grep SAMPLE
>    #
> 
> does not generate samples in the perf.data file. On x86 the command:
> 
>   # sudo perf record -e intel_pt// -u 0 ls
> 
> is broken too.
> 
> Looking at the sequence of calls in 'perf record' reveals this
> behavior:
> 
> 1. The event 'cycles' is created and enabled:
> 
>    record__open()
>    +-> evlist__apply_filters()
>        +-> perf_bpf_filter__prepare()
> 	   +-> bpf_program.attach_perf_event()
> 	       +-> bpf_program.attach_perf_event_opts()
> 	           +-> __GI___ioctl(..., PERF_EVENT_IOC_ENABLE, ...)
> 
>    The event 'cycles' is enabled and active now. However the event's
>    ring-buffer to store the samples generated by hardware is not
>    allocated yet.
> 
> 2. The event's fd is mmap()ed to create the ring buffer:
> 
>    record__open()
>    +-> record__mmap()
>        +-> record__mmap_evlist()
> 	   +-> evlist__mmap_ex()
> 	       +-> perf_evlist__mmap_ops()
> 	           +-> mmap_per_cpu()
> 	               +-> mmap_per_evsel()
> 	                   +-> mmap__mmap()
> 	                       +-> perf_mmap__mmap()
> 	                           +-> mmap()
> 
>    This allocates the ring buffer for the event 'cycles'. With mmap()
>    the kernel creates the ring buffer:
> 
>    perf_mmap(): kernel function to create the event's ring
>    |            buffer to save the sampled data.
>    |
>    +-> ring_buffer_attach(): Allocates memory for ring buffer.
>        |        The PMU has auxiliary data setup function. The
>        |        has_aux(event) condition is true and the PMU's
>        |        stop() is called to stop sampling. It is not
>        |        restarted:
>        |
>        |        if (has_aux(event))
>        |                perf_event_stop(event, 0);
>        |
>        +-> cpumsf_pmu_stop():
> 
>    Hardware sampling is stopped. No samples are generated and saved
>    anymore.
> 
> 3. After the event 'cycles' has been mapped, the event is enabled a
>    second time in:
> 
>    __cmd_record()
>    +-> evlist__enable()
>        +-> __evlist__enable()
> 	   +-> evsel__enable_cpu()
> 	       +-> perf_evsel__enable_cpu()
> 	           +-> perf_evsel__run_ioctl()
> 	               +-> perf_evsel__ioctl()
> 	                   +-> __GI___ioctl(., PERF_EVENT_IOC_ENABLE, .)
> 
>    The second
> 
>       ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
> 
>    is just a NOP in this case. The first invocation in (1.) sets the
>    event::state to PERF_EVENT_STATE_ACTIVE. The kernel functions
> 
>    perf_ioctl()
>    +-> _perf_ioctl()
>        +-> _perf_event_enable()
>            +-> __perf_event_enable()
> 
>    return immediately because event::state is already set to
>    PERF_EVENT_STATE_ACTIVE.
> 
> This happens on s390, because the event 'cycles' offers the possibility
> to save auxilary data. The PMU callbacks setup_aux() and free_aux() are
> defined. Without both callback functions, cpumsf_pmu_stop() is not
> invoked and sampling continues.
> 
> To remedy this, remove the first invocation of
> 
>    ioctl(..., PERF_EVENT_IOC_ENABLE, ...).
> 
> in step (1.) Create the event in step (1.) and enable it in step (3.)
> after the ring buffer has been mapped.
> 
> Output after:
> 
>  # ./perf record -aB --synth=no -u 0 -- ./perf test -w thloop 2
>  [ perf record: Woken up 3 times to write data ]
>  [ perf record: Captured and wrote 0.876 MB perf.data ]
>  # ./perf  report --stats | grep SAMPLE
>               SAMPLE events:      16200  (99.5%)
>               SAMPLE events:      16200
>  #
> 
> The software event succeeded both before and after the patch:
> 
>  # ./perf record -e cpu-clock -aB --synth=no -u 0 -- \
> 					  ./perf test -w thloop 2
>  [ perf record: Woken up 7 times to write data ]
>  [ perf record: Captured and wrote 2.870 MB perf.data ]
>  # ./perf  report --stats | grep SAMPLE
>               SAMPLE events:      53506  (99.8%)
>               SAMPLE events:      53506
>  #
> 
> Fixes: b4c658d4d63d61 ("perf target: Remove uid from target")
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> Co-developed-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/bpf-filter.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index d0e013eeb0f7..a0b11f35395f 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -451,6 +451,8 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
>  	struct bpf_link *link;
>  	struct perf_bpf_filter_entry *entry;
>  	bool needs_idx_hash = !target__has_cpu(target);
> +	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts,
> +			    .dont_enable = true);
>  
>  	entry = calloc(MAX_FILTERS, sizeof(*entry));
>  	if (entry == NULL)
> @@ -522,7 +524,8 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
>  	prog = skel->progs.perf_sample_filter;
>  	for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
>  		for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
> -			link = bpf_program__attach_perf_event(prog, FD(evsel, x, y));
> +			link = bpf_program__attach_perf_event_opts(prog, FD(evsel, x, y),
> +								   &pe_opts);
>  			if (IS_ERR(link)) {
>  				pr_err("Failed to attach perf sample-filter program\n");
>  				ret = PTR_ERR(link);
> -- 
> 2.50.1
> 

