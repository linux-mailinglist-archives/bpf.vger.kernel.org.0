Return-Path: <bpf+bounces-21717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8403850AF2
	for <lists+bpf@lfdr.de>; Sun, 11 Feb 2024 19:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E027282ED8
	for <lists+bpf@lfdr.de>; Sun, 11 Feb 2024 18:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFE95C5FC;
	Sun, 11 Feb 2024 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hYiS/TWg"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A93FC19
	for <bpf@vger.kernel.org>; Sun, 11 Feb 2024 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707677956; cv=none; b=Tv+KzXz1DUUguIUCMPNQmDE245eOP56+7RGIKCDBD3rhSlxGM62LpHOAT7GIHFkkRZKU4ZjnZuCDOLauFl+cfq51d+ojAzF7zB+Ek+6KtGG6RIjQQYk3eUNl31HWNkOifzEU+UGvefdvUZBN6G9Byq2Q/tI3oJ1xZxSUciDWh80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707677956; c=relaxed/simple;
	bh=b3jSZWRRkwyWwJ1sfhkXT2PF5lWAZWTBS7FZMNpFGjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccBxeBPSHgsxQL3PWczcbjSwsKf7FGpeHh2OoxGROBNNlXaqOuy1zohdxPLqoCDM2qbN/etr0BuLfuGjn4cX5nRJbagfK5lk0ocdtc2RUd7dRad7u370HGFQpxdTkH03txEaFRVS+gGXURL/8/EbUWP+FzHpB6Et6fkbNrL3+N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hYiS/TWg; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a2f58a16-ace4-4a1f-aab0-35aeff0e77fa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707677951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WznE728vpJSQ/IE+NWhghZ9r/d+hU2NHE6NPl7xnYZ0=;
	b=hYiS/TWgU/UWckIumjdY+5UOpIinZEejAwH4pKBrr8WxyiX9n18BYSM9IDRMNUkTm51GHQ
	pwrpt91pHUxJ6uHCkSrC0ISMCzagVj9foTRQWvKTsFsabP1OlG3/Y1ZWZjWixFSu+yL5nQ
	cHoX8Qtp0KMCVlF0DkEoZ9FqcdScwz8=
Date: Sun, 11 Feb 2024 10:59:00 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 1/4] bpf: add btf pointer to struct
 bpf_ctx_arg_aux.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 davemarchevsky@meta.com, dvernet@meta.com
References: <20240209023750.1153905-1-thinker.li@gmail.com>
 <20240209023750.1153905-2-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240209023750.1153905-2-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/8/24 6:37 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Enable the providers to use types defined in a module instead of in the
> kernel (btf_vmlinux).
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   include/linux/bpf.h | 1 +
>   kernel/bpf/btf.c    | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 1ebbee1d648e..9a2ee9456989 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1416,6 +1416,7 @@ struct bpf_ctx_arg_aux {
>   	u32 offset;
>   	enum bpf_reg_type reg_type;
>   	u32 btf_id;
> +	struct btf *btf;

It will leave a 4 bytes hole. Not a big deal considering the sizeof won't change 
regardless but still would be nice to avoid it.

Moving "struct btf *btf" to the top will need code churns in all the existing 
bpf_iter_* because they do not use the ".offset = " and ".reg_type = " style to 
initialize. I am going to move this pointer addition before the "u32 btf_id;" 
instead. No need to resend.

>   };
>   
>   struct btf_mod_pair {
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 8e06d29961f1..7c6c9fefdbd6 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6266,7 +6266,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>   			}
>   
>   			info->reg_type = ctx_arg_info->reg_type;
> -			info->btf = btf_vmlinux;
> +			info->btf = ctx_arg_info->btf ? ctx_arg_info->btf : btf_vmlinux;
>   			info->btf_id = ctx_arg_info->btf_id;
>   			return true;
>   		}


