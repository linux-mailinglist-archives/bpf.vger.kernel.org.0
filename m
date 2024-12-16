Return-Path: <bpf+bounces-47048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B629F376A
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 18:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B33167FC7
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 17:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7327206F25;
	Mon, 16 Dec 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r29ylNXP"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B92063FF
	for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369692; cv=none; b=O7iZ7oyp/Ej+IbhUmuVs7moLlfgVO3BtBCzIxRYcYQ7HbC+ENAewD82eQarevPNSqUobBlDQTfKcHbNvMuGjS1lZjKuCCTgTAwbti37Nm0eg1nhR4y2gL3omyDIA46lpuMpAF6nfA9EYOg0v2qKhw6Dej5vfzlvM0+yHbltHgYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369692; c=relaxed/simple;
	bh=iSi59v8LNr+EPwWCBvXOnQ0Kss0DSiv4S3oup6h2dsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VBIyQTQ0YsYwVgIX5TWX4e6cBoiBaFf5r9QZkspzmLHjYjxeAepS/rENakKCeZgdPrnvSh0R3B/Au+o+DwUVVAVI2Zg+WXuuOA/Crd/LyCFf6hUlMZp2pNlmjAEuqEhE5mjMkbv55MG1+9KRdlClYE36GFL3mwW9Tjha+hPHHOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r29ylNXP; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <80f412f1-a060-463b-9034-3128906e6929@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734369686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9LLLaGjtfz1xmvBfYNrPAJD9KQz5/pkDMu0zRApdZY=;
	b=r29ylNXPDZN66EP4Nx70zpHwFezQHTn2fMdw5+OKcmlwm/aWiSqVfCa3roIbmCex4aBjz4
	A2CGZKihtsbe0U6kFvlauBQS7PALEyZOe1wcZcLlmzljOLnp20FqrvLWILlRHC4DlmXqh4
	zeLB7/4+49q8dHDvORF5l3Z7RyM12qU=
Date: Mon, 16 Dec 2024 09:21:15 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/7] bpf: Add bpf_perf_event_aux_pause kfunc
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241215193436.275278-3-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 12/15/24 11:34 AM, Leo Yan wrote:
> The bpf_perf_event_aux_pause kfunc will be used to control the Perf AUX
> area to pause or resume.
>
> An example use-case is attaching eBPF to Ftrace tracepoints.  When a
> tracepoint is hit, the associated eBPF program will be executed.  The
> eBPF program can invoke bpf_perf_event_aux_pause() to pause or resume
> AUX trace.  This is useful for fine-grained tracing by combining
> Perf and eBPF.
>
> This commit implements the bpf_perf_event_aux_pause kfunc, and make it
> pass the eBPF verifier.

The subject and commit message mentions to implement a kfunc,
but actually you implemented a uapi helper. Please implement a kfunc
instead (searching __bpf_kfunc in kernel/bpf directory).

>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   include/uapi/linux/bpf.h | 21 ++++++++++++++++
>   kernel/bpf/verifier.c    |  2 ++
>   kernel/trace/bpf_trace.c | 52 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 75 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 4162afc6b5d0..678278c91ce2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5795,6 +5795,26 @@ union bpf_attr {
>    *		0 on success.
>    *
>    *		**-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * long bpf_perf_event_aux_pause(struct bpf_map *map, u64 flags, u32 pause)
> + *	Description
> + *		Pause or resume an AUX area trace associated to the perf event.
> + *
> + *		The *flags* argument is specified as the key value for
> + *		retrieving event pointer from the passed *map*.
> + *
> + *		The *pause* argument controls AUX trace pause or resume.
> + *		Non-zero values (true) are to pause the AUX trace and the zero
> + *		value (false) is for re-enabling the AUX trace.
> + *	Return
> + *		0 on success.
> + *
> + *		**-ENOENT** if not found event in the events map.
> + *
> + *		**-E2BIG** if the event index passed in the *flags* parameter
> + *		is out-of-range of the map.
> + *
> + *		**-EINVAL** if the flags passed is an invalid value.
>    */
>   #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>   	FN(unspec, 0, ##ctx)				\
> @@ -6009,6 +6029,7 @@ union bpf_attr {
>   	FN(user_ringbuf_drain, 209, ##ctx)		\
>   	FN(cgrp_storage_get, 210, ##ctx)		\
>   	FN(cgrp_storage_delete, 211, ##ctx)		\
> +	FN(perf_event_aux_pause, 212, ##ctx)		\
>   	/* */
>   
>   /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
>
[...]

