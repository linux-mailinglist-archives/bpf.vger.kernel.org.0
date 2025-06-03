Return-Path: <bpf+bounces-59508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CE1ACC9A2
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 16:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC883A54F7
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 14:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59642239E8B;
	Tue,  3 Jun 2025 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EvlsbfNV"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9EF15624B
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748962353; cv=none; b=WJfHW2SbmTgR2J+kZ64KSxzo15YVUvDxK2WFCPJZLUh3wCEyE9CtnzMGol/vLdvFb8/Ws309AdBZpnLV6xg+0rfyjOX6T38+df+3oiFmFXgMkTfKbyxEdHtnv0dw9dhvNFNPhNfGeX5+0DK8AJxRNJSX4JYNDX11A4VUbPb2aeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748962353; c=relaxed/simple;
	bh=Oa3m9v6ixL/w0XwxKBKC++92c510OYz+SUXhvliNM6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sduXSL+dapACGYnW3migtg5plWMzN1Xr0RmKbrPbRmEvGN73aeOpaUiOdLWV4mJ6FvTQrXPrnIdwdhA4+ylcbbSLFnq3eSRUYSpNH6kwrI2uQH/VJBvay6gjmOEdKbv4VqcmLcI/Hr8aEgDREtOvFJul066n6ZWfY4RuligY8Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EvlsbfNV; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <48e85d82-e5c7-463a-aef3-f1ecbe863524@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748962348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PqSQYLxF3PQOOUCwlDTNZNkyBsHb04BWAzgAdjdwyhc=;
	b=EvlsbfNVsYNh4qBEjeX7r8BS5ZKoBuC4I9Jy/KBSDAIXBkGlYjpPjQ7FrGvaoIc1YK2U82
	NY68Dzuod4b8+tEG4r5jp31kylunsiX/isw+4+jDKqldeuak53JEUJPyINM2hBW1tnQIfa
	GtmqikcwdAhnq/2Jt8WgugxlKH8rYx0=
Date: Tue, 3 Jun 2025 07:52:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add cookie to raw_tp bpf_link_info
Content-Language: en-GB
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 qmo@kernel.org, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250603022610.3005963-1-chen.dylane@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250603022610.3005963-1-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/2/25 7:26 PM, Tao Chen wrote:
> After commit 68ca5d4eebb8 ("bpf: support BPF cookie in raw tracepoint
> (raw_tp, tp_btf) programs"), we can show the cookie in bpf_link_info
> like kprobe etc.
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>   include/uapi/linux/bpf.h       | 2 ++
>   kernel/bpf/syscall.c           | 1 +
>   tools/include/uapi/linux/bpf.h | 2 ++
>   3 files changed, 5 insertions(+)
>
> Change list:
> - v1 -> v2:
>      - fill the hole in bpf_link_info.(Jiri)
> - v1:
>      https://lore.kernel.org/bpf/20250529165759.2536245-1-chen.dylane@linux.dev
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 07ee73cdf9..f3e2aae302 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6644,6 +6644,8 @@ struct bpf_link_info {
>   		struct {
>   			__aligned_u64 tp_name; /* in/out: tp_name buffer ptr */
>   			__u32 tp_name_len;     /* in/out: tp_name buffer len */
> +			__u32 reserved; /* just fill the hole */

See various examples in uapi/linux/bpf.h, '__u32 :32;' is the preferred
apporach to fill the hole.

> +			__u64 cookie;
>   		} raw_tracepoint;
>   		struct {
>   			__u32 attach_type;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 9794446bc8..1c3dbe44ac 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3687,6 +3687,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
>   		return -EINVAL;
>   
>   	info->raw_tracepoint.tp_name_len = tp_len + 1;
> +	info->raw_tracepoint.cookie = raw_tp_link->cookie;
>   
>   	if (!ubuf)
>   		return 0;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 07ee73cdf9..f3e2aae302 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6644,6 +6644,8 @@ struct bpf_link_info {
>   		struct {
>   			__aligned_u64 tp_name; /* in/out: tp_name buffer ptr */
>   			__u32 tp_name_len;     /* in/out: tp_name buffer len */
> +			__u32 reserved; /* just fill the hole */
> +			__u64 cookie;
>   		} raw_tracepoint;
>   		struct {
>   			__u32 attach_type;


