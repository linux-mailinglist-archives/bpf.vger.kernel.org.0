Return-Path: <bpf+bounces-22638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB348622E0
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 07:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9061C21401
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 06:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718CF17588;
	Sat, 24 Feb 2024 06:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wscyeRtL"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC636171CD
	for <bpf@vger.kernel.org>; Sat, 24 Feb 2024 06:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708755590; cv=none; b=kgE1HFAQ2xKpCWZ3sWfMkLCLshquw751HUrJHfMxUHkp+XMNQvZTQuGxRDPRFCz+hZ7mf2I+1J88hjl4XGtiq4zEE+e2OFADVzm9Z9ZwOXaSvgriM6e5PWCyLMQbpmyx/ScRP6Td0tqpBJIJCxE5tfBBPOq8hEBFwR6eW/g7+Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708755590; c=relaxed/simple;
	bh=W0NG5CDi9oK2mrhh3Z3izDgWEvrTO38+XSZ/6n/70eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vxdm4za0g/u491v8F1onKOQAy1o/Hd1jZUvhs5QEe3hSso7PDek/1mXckYILZWHjwZuK9Q+zr9/rWDZo5SVWHlLIQE6uDYfxfVVP1ZBGv6pazvDRumJBA5Iw/URkzzV9ymS5MXE5xPY3IqXZtq6BkCZfsgS7ryI10VVzp+L7BhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wscyeRtL; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9d2dbd18-0d64-458a-8c95-9d549eabd3cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708755586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCkoTx3hD9psvUtAY6n19RtG7YrgAxp36QZp0m+GBpA=;
	b=wscyeRtLxaGGCKiqc0dYn8hG9CBY6rhGSf0hr6MYbfej1dINeXD8UUkb+uDgu6fdhMXA+3
	ePagVnoeI6gfl+gvc5fQCSz9T6B41IaPSrKTE6tfwVdKPSXF3454hOLLeMZvg6QxQPOB2n
	xtRsR9Th7QZkLwygY+u4sVfskqGfJcg=
Date: Fri, 23 Feb 2024 22:19:30 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/3] bpf: struct_ops supports more than one
 page for trampolines.
Content-Language: en-US
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20240224030302.1500343-1-thinker.li@gmail.com>
 <20240224030302.1500343-3-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240224030302.1500343-3-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/23/24 7:03 PM, Kui-Feng Lee wrote:
> +static void bpf_struct_ops_map_free_image(struct bpf_struct_ops_map *st_map)
> +{
> +	int i;
> +	void *image;
> +
> +	bpf_jit_uncharge_modmem(PAGE_SIZE * st_map->image_pages_cnt);
> +	for (i = 0; i < st_map->image_pages_cnt; i++) {
> +		image = st_map->image_pages[i];
> +		arch_free_bpf_trampoline(image, PAGE_SIZE);
> +	}
> +	st_map->image_pages_cnt = 0;
> +}
> +

[ ... ]

> @@ -133,7 +128,8 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
>   	err = bpf_struct_ops_prepare_trampoline(tlinks, link,
>   						&st_ops->func_models[op_idx],
>   						&dummy_ops_test_ret_function,
> -						image, image + PAGE_SIZE);
> +						&image, &image_off,
> +						true);
>   	if (err < 0)
>   		goto out;
>   
> @@ -147,6 +143,8 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
>   		err = -EFAULT;
>   out:
>   	kfree(args);
> +	if (image)
> +		bpf_jit_uncharge_modmem(PAGE_SIZE);
>   	arch_free_bpf_trampoline(image, PAGE_SIZE);

It seems my last reply on v2 has crossed over with v3.

The bpf_struct_ops_free_trampoline() highlighted in my last reply should
address your concern in v2 that the caller needs to remember
the bpf_jit_uncharge_modmem here.

I think the trampoline alloc(aka prepare here)/free pair that you also
suggested in v2 discussion is a nice match here and work as a
charge+alloc and uncharge+free pair.

>   	if (link)
>   		bpf_link_put(&link->link);


