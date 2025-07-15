Return-Path: <bpf+bounces-63344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BF6B064FA
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 19:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 511DE7B1ED5
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 17:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AC927A455;
	Tue, 15 Jul 2025 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nslnATdC"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD6827F003
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599546; cv=none; b=kARZ1hD1vYk1AzDTNKpZ9O5G8bIp7w0FqocXFPDeEPEaJIzK/B3HM4F3VARr5ZP+hQIIlAtRfEa2A22+a7i6IXN8g9A3nv5jDB4VqwYXvfvgGNB/+vSyfst+yYGbFF+KXK3euI/kNINEAeB21xjzfQECyBTNNOWjakGopD88Mag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599546; c=relaxed/simple;
	bh=YCtVVMpvD/xdVI+sdp+CCepVQsM+MeTkXp7piqk3goY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xge1X+k4ldoaet62RNVKhY1FjTWppyzLjbgmVteiQbVGjmENoELgm5ijSE7nIYo6t9fyGXzKef0Y/hvoJKY6zhXbPuYB62KcRGmaKCJ8UXBiUh/5qF91S6mnYBFvy1SwYUjXvtfCMrt7MdGfpypJpS0UQSRHJdle69ui1H8oGgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nslnATdC; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba5c04f4-a33d-4d7f-9272-eee4a4389def@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752599531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NCkuFDRYiHgZPUOR6AcG8fkwmC5F3Os71WzjkaB/swA=;
	b=nslnATdCk5nZ3ZvgSdd+4yfRxO3vc8f/WtBxAXt5EqKJgrxRWH1om/M8h4J8dTGubYcGMS
	jagtWbWmJeQERNOnPnFAk4s4hp7joNwYmwZLp6SVElD35W+X7SMHCm54rOAe82QrMfHlsI
	f+Iuu2GpnhPle9XMlmhHLNINsq+aMdI=
Date: Tue, 15 Jul 2025 10:12:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/7] bpf: Add bpf_perf_event_aux_pause kfunc
Content-Language: en-GB
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>, "Liang, Kan"
 <kan.liang@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>
References: <20241215193436.275278-1-leo.yan@arm.com>
 <20241215193436.275278-3-leo.yan@arm.com>
 <80f412f1-a060-463b-9034-3128906e6929@linux.dev>
 <20250714174505.GA3020098@e132581.arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250714174505.GA3020098@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/14/25 10:45 AM, Leo Yan wrote:
> Hi Yonghong,
>
> Really sorry for the long delay. Now I am restarting this work.
>
> On Mon, Dec 16, 2024 at 09:21:15AM -0800, Yonghong Song wrote:
>> On 12/15/24 11:34 AM, Leo Yan wrote:
>>> The bpf_perf_event_aux_pause kfunc will be used to control the Perf AUX
>>> area to pause or resume.
>>>
>>> An example use-case is attaching eBPF to Ftrace tracepoints.  When a
>>> tracepoint is hit, the associated eBPF program will be executed.  The
>>> eBPF program can invoke bpf_perf_event_aux_pause() to pause or resume
>>> AUX trace.  This is useful for fine-grained tracing by combining
>>> Perf and eBPF.
>>>
>>> This commit implements the bpf_perf_event_aux_pause kfunc, and make it
>>> pass the eBPF verifier.
>> The subject and commit message mentions to implement a kfunc,
>> but actually you implemented a uapi helper. Please implement a kfunc
>> instead (searching __bpf_kfunc in kernel/bpf directory).
> After some research, my understanding is that kfunc is flexible for
> exposing APIs via BTF, whereas BPF_CALL is typically used for core BPF
> features - such as accessing BPF maps.
>
> Coming back to this patch: it exposes a function with the following
> definition:
>
>    int bpf_perf_event_aux_pause(struct bpf_map *map, u64 flags, u32 pause);
>
> I'm not certain whether using __bpf_kfunc is appropriate here, or if I
> should stick to BPF_CALL to ensure support for accessing bpf_map
> pointers?

Using helpers (BPF_CALL) is not an option as the whole bpf ecosystem
moves to kfunc mechanism. You can certainly use kfunc with 'struct bpf_map *'
as the argument. For example the following kfunc:
   __bpf_kfunc s64 bpf_map_sum_elem_count(const struct bpf_map *map)
in kernel/bpf/map_iter.c
   

>
> Thanks,
> Leo


