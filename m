Return-Path: <bpf+bounces-64006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D19B0D42E
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 10:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E90E3A5184
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 08:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81C62D1F69;
	Tue, 22 Jul 2025 08:14:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDD7F9D9;
	Tue, 22 Jul 2025 08:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172068; cv=none; b=NBNU5JzAJH7qRQZhuCtrNsv7P+dk0giT2jtxPIp8PIzZEboGtYeGgWesQ4NtHJ8aqi34GrFrT/uru7jm7TWqJcbKSTa6y33Zceick72Iqu8h6eVp+uvlLluKoGIfiCAMwEGDOUFkpNrGtlut/oFzZ1L87R0itf1ctQlHdunx9do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172068; c=relaxed/simple;
	bh=io77pfkNQxAH6B7A33DmsVYNh5vPYMthoNtq1lqefY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1rnPzjsccNVjTUU/EmFrCnx26Jjoq2M6htOy6LcHpaaRUDOU1VF6z7DxVUDW/cv/LxyrfJxlWrbeEVClL4AsvKCRs9u/MKDjNQo1Hosf9Ir+2dNOfbSDnxLKV/0QsMy9Mgzb8MSuTrvwIzgHjujgNmCNXv64uPwJ/a08cnEJE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77E9E152B;
	Tue, 22 Jul 2025 01:14:19 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AD613F59E;
	Tue, 22 Jul 2025 01:14:24 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:14:22 +0100
From: Leo Yan <leo.yan@arm.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH PATCH v2 v2 2/6] bpf: Add bpf_perf_event_aux_pause kfunc
Message-ID: <20250722081422.GG3137075@e132581.arm.com>
References: <20250718-perf_aux_pause_resume_bpf_rebase-v2-0-992557b8fb16@arm.com>
 <20250718-perf_aux_pause_resume_bpf_rebase-v2-2-992557b8fb16@arm.com>
 <ac8266f19ecde10a49911192014dddf35b3b496d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac8266f19ecde10a49911192014dddf35b3b496d.camel@gmail.com>

Hi Eduard,

On Mon, Jul 21, 2025 at 03:38:59PM -0700, Eduard Zingerman wrote:
> On Fri, 2025-07-18 at 16:25 +0100, Leo Yan wrote:
> 
> [...]
> 
> > +__bpf_kfunc int bpf_perf_event_aux_pause(void *p__map, u64 flags, u32 pause)
> > +{
> > +	struct bpf_map *map = p__map;
> > +	struct bpf_array *array = container_of(map, struct bpf_array, map);
> 
> Verifier makes sure that p__map is a not null pointer to an object of
> type bpf_map, but it does not guarantee that the object is an instance
> of bpf_array.
> You need to check map->type, same way bpf_arena_alloc_pages() does.

Makes sense. Will do.

> > +	unsigned int cpu = smp_processor_id();
> > +	u64 index = flags & BPF_F_INDEX_MASK;
> > +	struct bpf_event_entry *ee;
> > +	int ret = 0;
> > +
> > +	/* Disabling IRQ avoids race condition with perf event flows. */
> > +	guard(irqsave)();
> > +
> > +	if (unlikely(flags & ~(BPF_F_INDEX_MASK))) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	if (index == BPF_F_CURRENT_CPU)
> > +		index = cpu;
> > +
> > +	if (unlikely(index >= array->map.max_entries)) {
> > +		ret = -E2BIG;
> > +		goto out;
> > +	}
> > +
> > +	ee = READ_ONCE(array->ptrs[index]);
> > +	if (!ee) {
> > +		ret = -ENOENT;
> > +		goto out;
> > +	}
> > +
> > +	if (!has_aux(ee->event))
> > +		ret = -EINVAL;

I should refactor a bit for removing "goto out" and directly return
error cases.

Thanks for review and your suggestion in another reply.

Leo

> > +
> > +	perf_event_aux_pause(ee->event, pause);
> > +out:
> > +	return ret;
> > +}
> 
> [...]

