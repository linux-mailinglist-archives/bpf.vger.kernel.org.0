Return-Path: <bpf+bounces-28195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF778B65B2
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 00:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53996281104
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 22:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3D3194C68;
	Mon, 29 Apr 2024 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C/Ft3JLR"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB2982D90
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 22:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429599; cv=none; b=QuhqF64w42QlVMd14XUQ+UDScXQkgZiz+NvevLhmbTAPVgA8NPL0QGHy2H/J21OOAoFf9Ywr0tWEeyyc4huQarpz8lB2LxkW36/wam2qscVt4lM1B3VZ1erhG2mx/FE7bJPqOWAEbxPqDMeCGLYaD0PNQCt+/aI73cdxw6a9ZaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429599; c=relaxed/simple;
	bh=arCgxFpGiqlTDAnr3vsGsa4oYK1F6r9hnFcfpg4zYJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNabe71oRumy8j2e9lTJ0Zi2MeAfopyM+SL6UPIPLwRHLoTF6P1KeBTUQENwF9iSi/hd0WH86mgvd9iyBmHj//eZrJVUqWV3wWt4+w8Mz60HNhN7H77vk2k0Vs8gixBntHuSdvGvIwGTA+xQeUn/w/csPQWnZwjlcOAZH46GLsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C/Ft3JLR; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a8e502fd-db39-4129-96ff-18e65f0f753b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714429595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvJsplm6fxDyUmU3K6iq1qEtbNNqj5jXvy98EBMU2po=;
	b=C/Ft3JLRBS7UtTko/m1DxZnZtsrq787h2mFCpkS/xzmmdFJWKlZruTlAQRbzx699MxWTTU
	zpSrrH6PIy491EYs3jbrj2PJ9VqDN6Br4eJc9l0vcLtGizRGaAxHdDCs58hmqm6QY+y189
	nLr4hoFOdEKSN78fiwGgfHCyvrRYd0o=
Date: Mon, 29 Apr 2024 15:26:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: add support to read cpu_entry in bpf
 program
Content-Language: en-GB
To: Florian Lehner <dev@der-flo.net>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org
References: <20240427151825.174486-1-dev@der-flo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240427151825.174486-1-dev@der-flo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/27/24 8:18 AM, Florian Lehner wrote:
> Add new field "cpu_entry" to bpf_perf_event_data which could be read by
> bpf programs attached to perf events. The value contains the CPU value
> recorded by specifying sample_type with PERF_SAMPLE_CPU when calling
> perf_event_open().

You can use bpf_cast_to_kern_ctx kfunc which can cast 'struct bpf_perf_event_data'
ctx to 'struct bpf_perf_event_data_kern'.

struct bpf_perf_event_data_kern {
         bpf_user_pt_regs_t *regs;
         struct perf_sample_data *data;
         struct perf_event *event;
};

You can access bpf_perf_event_data_kern->data and then to access 'cpu_entry' field.

>
> Signed-off-by: Florian Lehner <dev@der-flo.net>
> ---
>   include/uapi/linux/bpf_perf_event.h       |  4 ++++
>   kernel/trace/bpf_trace.c                  | 13 +++++++++++++
>   tools/include/uapi/linux/bpf_perf_event.h |  4 ++++
>   3 files changed, 21 insertions(+)
>
> diff --git a/include/uapi/linux/bpf_perf_event.h b/include/uapi/linux/bpf_perf_event.h
> index eb1b9d21250c..4856b4396ece 100644
> --- a/include/uapi/linux/bpf_perf_event.h
> +++ b/include/uapi/linux/bpf_perf_event.h
> @@ -14,6 +14,10 @@ struct bpf_perf_event_data {
>   	bpf_user_pt_regs_t regs;
>   	__u64 sample_period;
>   	__u64 addr;
> +	struct {
> +		u32	cpu;
> +		u32	reserved;
> +	}			cpu_entry;
>   };
>   
>   #endif /* _UAPI__LINUX_BPF_PERF_EVENT_H__ */
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index afb232b1d7c2..2b303221af5c 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2176,6 +2176,11 @@ static bool pe_prog_is_valid_access(int off, int size, enum bpf_access_type type
>   		if (!bpf_ctx_narrow_access_ok(off, size, size_u64))
>   			return false;
>   		break;
> +	case bpf_ctx_range(struct bpf_perf_event_data, cpu_entry):
> +		bpf_ctx_record_field_size(info, size_u64);
> +		if (!bpf_ctx_narrow_access_ok(off, size, size_u64))
> +			return false;
> +		break;
>   	default:
>   		if (size != sizeof(long))
>   			return false;
> @@ -2208,6 +2213,14 @@ static u32 pe_prog_convert_ctx_access(enum bpf_access_type type,
>   				      bpf_target_off(struct perf_sample_data, addr, 8,
>   						     target_size));
>   		break;
> +	case offsetof(struct bpf_perf_event_data, cpu_entry):
> +		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_perf_event_data_kern,
> +						       data), si->dst_reg, si->src_reg,
> +				      offsetof(struct bpf_perf_event_data_kern, data));
> +		*insn++ = BPF_LDX_MEM(BPF_DW, si->dst_reg, si->dst_reg,
> +				      bpf_target_off(struct perf_sample_data, cpu_entry, 8,
> +						     target_size));
> +		break;
>   	default:
>   		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_perf_event_data_kern,
>   						       regs), si->dst_reg, si->src_reg,
> diff --git a/tools/include/uapi/linux/bpf_perf_event.h b/tools/include/uapi/linux/bpf_perf_event.h
> index eb1b9d21250c..4856b4396ece 100644
> --- a/tools/include/uapi/linux/bpf_perf_event.h
> +++ b/tools/include/uapi/linux/bpf_perf_event.h
> @@ -14,6 +14,10 @@ struct bpf_perf_event_data {
>   	bpf_user_pt_regs_t regs;
>   	__u64 sample_period;
>   	__u64 addr;
> +	struct {
> +		u32	cpu;
> +		u32	reserved;
> +	}			cpu_entry;
>   };
>   
>   #endif /* _UAPI__LINUX_BPF_PERF_EVENT_H__ */

