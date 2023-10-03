Return-Path: <bpf+bounces-11271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6437B66FA
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 13:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id F34AD1C20965
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B499920B36;
	Tue,  3 Oct 2023 11:00:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436E9208D7;
	Tue,  3 Oct 2023 11:00:38 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2B8AC;
	Tue,  3 Oct 2023 04:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=934M3M5cJg5fSPGaIg7428I8uQBQncWaQiT8PHBnuSE=; b=E7a738Qf1E4DMNUqfeslJzFl/i
	WOWmTL94prinRHALF/qMyMN09I9RpJ7x8T7Xdypumf8nd85DI68BeVaeIbFQMWYY0QIA0hP54VVOU
	rLzlieEhIW4OD55KsQwYalA84ZCe/Poq/H3Xvj0rcY8QHD5wfNeprAkQMoP2qV8lYhgpXiTDartTi
	OZax6sqtjgVS9ZNFFqXdDoy77t80atP/Rt6RD5Vpa/Bb2bE2V39NbtcJ+c+vZF1PywRqu4W1jluuW
	bOCKowaJEQDGQiWk9uMEy5M+AjkTf/sOepm2xvr+adHjkQSi0NybO1hKCi6KjtUhwM3VGgTPIFtj1
	K0tomjag==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qnd8U-00Ec4p-IJ; Tue, 03 Oct 2023 11:00:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 30FA6300665; Tue,  3 Oct 2023 13:00:18 +0200 (CEST)
Date: Tue, 3 Oct 2023 13:00:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tero Kristo <tero.kristo@linux.intel.com>
Cc: x86@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	tglx@linutronix.de, hpa@zytor.com, irogers@google.com,
	jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
	acme@kernel.org, mingo@redhat.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com
Subject: Re: [PATCHv2 2/2] perf/core: Allow reading package events from
 perf_event_read_local
Message-ID: <20231003110018.GG27267@noisy.programming.kicks-ass.net>
References: <20230912124432.3616761-2-tero.kristo@linux.intel.com>
 <20230913125956.3652667-1-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913125956.3652667-1-tero.kristo@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 13, 2023 at 03:59:56PM +0300, Tero Kristo wrote:
> Per-package perf events are typically registered with a single CPU only,
> however they can be read across all the CPUs within the package.
> Currently perf_event_read maps the event CPU according to the topology
> information to avoid an unnecessary SMP call, however
> perf_event_read_local deals with hard values and rejects a read with a
> failure if the CPU is not the one exactly registered. Allow similar
> mapping within the perf_event_read_local if the perf event in question
> can support this.
> 
> This allows users like BPF code to read the package perf events properly
> across different CPUs within a package.
> 
> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> ---
> v2:
>   * prevent illegal array access in case event->oncpu == -1
>   * split the event->cpu / event->oncpu handling to their own variables
> 
>  kernel/events/core.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4c72a41f11af..6b343bac0a71 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4425,6 +4425,9 @@ static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
>  {
>  	u16 local_pkg, event_pkg;
>  
> +	if (event_cpu < 0 || event_cpu >= nr_cpu_ids)
> +		return event_cpu;

	if ((unsigned)event_cpu >= nr_cpu_ids)
		return event_cpu;

As you could also find at the current __perf_event_read_cpu() callsite.

> +
>  	if (event->group_caps & PERF_EV_CAP_READ_ACTIVE_PKG) {
>  		int local_cpu = smp_processor_id();
>  
> @@ -4528,6 +4531,8 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
>  {
>  	unsigned long flags;
>  	int ret = 0;
> +	int event_cpu;
> +	int event_oncpu;

You wrecked the x-mas tree :-)

I'll fix both up.

Thanks!

