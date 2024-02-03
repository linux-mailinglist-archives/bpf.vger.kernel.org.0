Return-Path: <bpf+bounces-21119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2081847DF9
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 01:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAD1293AAB
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 00:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0CD80A;
	Sat,  3 Feb 2024 00:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GdqKnYar"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAADD636
	for <bpf@vger.kernel.org>; Sat,  3 Feb 2024 00:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706921172; cv=none; b=nE4lmrY0ie5ij7cI8H9wFZ3mEcxHjf+u+b9aC4fPRpW/9Yb9qEQzmyvMQ9z9mFrH4eMOC2Bx6U+4nramZt6zp9aY/1Iw+m3+GNQ+8w4+9rH2ThlJ8jIFIcaImRV2X0IrqEYi23uVHmVd/hx82+CciM9ehp+VuT3S4PkzjqQ2zVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706921172; c=relaxed/simple;
	bh=sSKpm2JbumWrOCzbEgxooQRRWGogTvBNsTycqhuszvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6QxUEm2lpgebZPeoO9LfN8AbUBGCIuH/7fEbah940ibL92MX25v13UTAFvQUiqg2OU1h96aDt1HUUHTbQw0R0nTih35Gf6n5wvwzwiENlifKXpvcmVwKZ4rp5XbgylW1HfWZNu8FWAbfgvSVdLaPjbigb0FyAHIiM8cj89LBB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GdqKnYar; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4a63f6cd-2b0b-4a2b-827b-75bee67b8757@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706921168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3f+IbgJO9fE87If+2kwMmjdJXNUfIPbyzrrMM1M86+I=;
	b=GdqKnYarXhUg5D4be6khD6J3ONRkQWshH0Vz1FcaPaoRMXGEeM1Fua3xI6kDrYqCHX5f4r
	QC22IubLyLrx6nl9m9ngmEBIoD5AMIjpFR0+wtYwCbz860lJdYEXD+oNCbML+LPxgeIhrX
	bEWF2ShqHnQ/p0fyY3vgGxhZ2Z9LxVQ=
Date: Fri, 2 Feb 2024 16:46:02 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v4 3/6] bpf: Remove an unnecessary check.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 davemarchevsky@meta.com, dvernet@meta.com
References: <20240202220516.1165466-1-thinker.li@gmail.com>
 <20240202220516.1165466-4-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240202220516.1165466-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/2/24 2:05 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> The "i" here is always equal to "btf_type_vlen(t)" since
> the "for_each_member()" loop never breaks.

It can be separated from the PTR_MAYBE_NULL support set. Please post this as its 
own patch without the RFC.
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   kernel/bpf/bpf_struct_ops.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 0decd862dfe0..f98f580de77a 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -189,20 +189,17 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>   		}
>   	}
>   
> -	if (i == btf_type_vlen(t)) {
> -		if (st_ops->init(btf)) {
> -			pr_warn("Error in init bpf_struct_ops %s\n",
> -				st_ops->name);
> -			return -EINVAL;
> -		} else {
> -			st_ops_desc->type_id = type_id;
> -			st_ops_desc->type = t;
> -			st_ops_desc->value_id = value_id;
> -			st_ops_desc->value_type = btf_type_by_id(btf,
> -								 value_id);
> -		}
> +	if (st_ops->init(btf)) {
> +		pr_warn("Error in init bpf_struct_ops %s\n",
> +			st_ops->name);
> +		return -EINVAL;
>   	}
>   
> +	st_ops_desc->type_id = type_id;
> +	st_ops_desc->type = t;
> +	st_ops_desc->value_id = value_id;
> +	st_ops_desc->value_type = btf_type_by_id(btf, value_id);
> +
>   	return 0;
>   }
>   


