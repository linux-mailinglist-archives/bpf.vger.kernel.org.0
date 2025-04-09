Return-Path: <bpf+bounces-55525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F555A82466
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 14:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3B2F7B844D
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 12:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A06125E838;
	Wed,  9 Apr 2025 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCsM68lN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0118025E835
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744200562; cv=none; b=pBC0sAWA4KTXN9eR6Cz43bELDLotggJPrRMynYsU136vNlTr7D3AWNx78xJewMxp7rKmOXVQQTDfdZyMQ+JXK7/vNZmuQxgivNgzINboxvQRRAz3bsQVBWeFbzFKTfq1GgwBNzlaqzR8SPPJ9KRfkStsFPtDdV+UBas7HIO0dNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744200562; c=relaxed/simple;
	bh=DoYpSUdmuVOB+8k0Nwd1T5A4RDBsVV3y4se5b5iPk/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufCsQvsw8YZLGbbwtuJQU17I/jn60CXo8gBMngVkLFE7fW9kgHc8kShlGXFwVsX0IuKypC4ur/xZyflT27ozF71Ssq8Q42rgAhuWuVeCWzgaHRWLhLu4Hvvlunm/ghj8eVfqonopeX8s8+4vbbwE3zCLp6fn+IO8wVN4MH0cod8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCsM68lN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac7bd86f637so132481166b.1
        for <bpf@vger.kernel.org>; Wed, 09 Apr 2025 05:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744200559; x=1744805359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cLbnrezm8E8w75ZFttAuWQS3AN3Z1rYcjHaTsObIIU4=;
        b=dCsM68lNiiry2MrMtMcgcX8vm6jo+3xM50IWMW/jv+GHS20TZjn+diXUfCstwJqlNo
         Ko4rygG9K6qOkub4FKKeMvILDnuA0Mx+UMhG/bl73WKsPB0YRFPxe0AZ3QHXF0zBPNj6
         Y3nSip0ZCdUBQ/kisGMZzYUmLLhBxtAG5kvol/z8mdqwf3O8ojMV+VGho25/HFHBWqrA
         LfJOM1HesLfWamVUDstwVT/zJPWU0b6WaofDsmns4pkcftr7Tff5XY5LIl4hUEZe4Yel
         ZnAEyJknWe7TVblhnVAXKs8OolfvncAtyJSCVjr/ZvdKq4SoWjOKN8UzChey5JBDQjVI
         wR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744200559; x=1744805359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLbnrezm8E8w75ZFttAuWQS3AN3Z1rYcjHaTsObIIU4=;
        b=K8NFVHC1/laFd9CTMrdfAf4oZZ3Vu1nfEkU+EnxgYITqJJqaKt3R9CAYZXEVbnEYWa
         BY1WSnI7faJH3M1KIdijtV5E8m1RMDyA76k5LqVxbvSPu23N8K8/RZL9Th4t22n0AjUe
         i3vjc3hTbEecHM2RYp1dWuQQwM+Kpl3G5MzmcFD9q7i9QIogvQ/4uUeu3+HaPXOzoLSI
         yUSWlg8jfNhEkYFic1ct+MFHsVGpRVOCj1lxKZkIeU0h/PqNKRj/VtFtxM5nMxsCT8n9
         vztb0aEK3c9HCypGBbU37gML+fYzLHZkSk2JuHECVnSCBm3YH0OL9plW2rvjjhuxB3pM
         RtKw==
X-Gm-Message-State: AOJu0YxgH2N6CSyOKNhugn79cULoPxWtrqd/9sZrUYWB47Bsk9aU+vIb
	vWR317OOdaNK+AZcyfB19FnkmS0x6Z+FqRAi2nLSvOsmd2Z4txwo
X-Gm-Gg: ASbGncv2+OEyTs/4sWRR1NZBjM+N2fGVsyIXRLpfPLVav6qT3YTqbywF2FssWGqN2qg
	9lYZWG21E40DJP7qNya9NYfF3vG/y9JZFH6NZzFuh4M8SAKAQDecuJ70mQcU/5fhA1AQRxIOEJy
	FMIY6XTEiGbRW3hOfQA8IdZgmL2AwsFlLeEMHftLgQGdWbppzTR6vWW82wYzu5I547X0uDk0t4i
	9rjcWGn8zf2JDkI5xFeOQJULmTCeFs8wBcUvMkS/8wetRqAjpwlsbJDF6ltnQm5EQn2+ax0sQb0
	TEiNBOc7LoHzPzdpKzT6ULEHupOqGbnRA5bMKKXY8Z2Kg7WvM2hjvVrD846O8l0aNSYLpJX0C8h
	qpQ==
X-Google-Smtp-Source: AGHT+IHgIOCUzC2sAmf55aCuhbgaaXlJpEb/NJEYswahOXqGOd+pzRhlPB7yMcovBtJKucNA0NUOTw==
X-Received: by 2002:a17:907:1c91:b0:ac3:8895:2775 with SMTP id a640c23a62f3a-aca9c03b88cmr228838666b.13.1744200558826;
        Wed, 09 Apr 2025 05:09:18 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:ae83:3ab9:c21d:4db3? ([2620:10d:c092:500::6:3f75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be913asm85427366b.47.2025.04.09.05.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 05:09:18 -0700 (PDT)
Message-ID: <743d6d28-b3b3-4e55-b9e7-3655bd25ad70@gmail.com>
Date: Wed, 9 Apr 2025 13:09:17 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libbpf: check for empty BTF data section in btf_parse_elf
To: Ihor Solodrai <ihor.solodrai@linux.dev>, andrii@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com
Cc: bpf@vger.kernel.org, mykolal@fb.com, kernel-team@meta.com
References: <20250408184104.3962949-1-ihor.solodrai@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250408184104.3962949-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/04/2025 19:41, Ihor Solodrai wrote:
> A valid ELF file may contain a SHT_NOBITS .BTF section. This case is
> not handled correctly in btf_parse_elf, which leads to a segfault.
>
> Add a null check for a buffer returned by elf_getdata() before
> proceeding with its processing.
>
> Bug report: https://github.com/libbpf/libbpf/issues/894
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>   tools/lib/bpf/btf.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 38bc6b14b066..90599f0311bd 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1201,6 +1201,12 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
>   		goto done;
>   	}
>   
> +	if (!secs.btf_data->d_buf) {
> +		pr_warn("BTF data is empty in %s\n", path);
> +		err = -ENODATA;
> +		goto done;
> +	}
> +
>   	if (secs.btf_base_data) {
>   		dist_base_btf = btf_new(secs.btf_base_data->d_buf, secs.btf_base_data->d_size,
>   					NULL);

is `secs.btf_data->d_size` non-zero in this case, making it access 
`secs.btf_data->d_buf`?

Acked-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>

