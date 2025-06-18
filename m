Return-Path: <bpf+bounces-61018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAE0ADF9E0
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 01:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0663BF90D
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 23:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BA1284B56;
	Wed, 18 Jun 2025 23:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlBz6CRD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3A93085A6
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 23:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750290279; cv=none; b=CGGY7H62OMZu9IUecccFsc+4LBL0x8JvXLy1Io30ERGF/oaWgsHITXzBUURzDpWSVeP9iFeN4wxrpQL1sIA7yKlbcibovog4EJVn7uev0cJPAn7OSV2omoqrCiQWDvamPTcHU1C3h5TEZg5JTON88aFEoW05z68JLSEFaqrSfwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750290279; c=relaxed/simple;
	bh=8w0nYnPnQAcGOri/cfGPkbkxJCxjxAZ5zM/UICBifds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/h4sObEFcktw7eh0V/pL4UN4+2qkCJZ6V1fgnQ3iAbop71hU4OJH/CFLy6k8oVWHfgdufsKduEGvDKkokZNnJpqUXJkHpuKLQ8rj6LBnNgnx0e6vJaoWm5tVEW/YMxLRbIJwIBd869PC1XP9be3zfIUttbFxczqu9RCgPoBvfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlBz6CRD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4535fbe015aso445625e9.3
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 16:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750290276; x=1750895076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ALI+vCUTUDTiy/Di2BqEMAMQnAvN4UOylIxpHHkXQBU=;
        b=OlBz6CRD+TU1guNfjafQPynQuBjjx0eZjgWuJpcyFPo0drsirtybDQoKqV3XUSPcv0
         AihZaP2lBYhCMvNfLXvnJqFBWi2bGRZwPCy5PAt7qEm40zpcs5GKdvRpUWDjGtjq7T+i
         qU+fmHf+I2Pi3B9gRzJnRUzZMBNX/2Dxd9urwpPrNYw9dBuOlS7FthVBQjfEJEb9+Txq
         4fxZlmjHDtlSQPKR4R2P36uZqR1F7Yi9IYosgBAivnr/q4bd8wbcIQh290VSBeLoGNYu
         xmtAt1i7VxginSmsfwuq8X3Bzc7re9GBkik3cy6EpTK3NrfBtxBrEZPf7ibzyocYJJAq
         Ureg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750290276; x=1750895076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALI+vCUTUDTiy/Di2BqEMAMQnAvN4UOylIxpHHkXQBU=;
        b=tIHqnOK0Fbx7OuOlxPAE32V49tZCBVCG3JzRh2EDAN6eFbjmcRcUpaYB6Had1C2FT7
         w5niLQfyIGaBqiMuxhKP99pTuOZbVTYmwPo5Tk6uEpkbm3F9DMQ4bui5fXeec48MSVWe
         7o2gQXiq9xQnxmjn9pznaTpd85fnzOHGUTuMpb1o3jOENlFRyfZf/8tbEoGqVe+NjsiG
         MXSL3+FH/yY2TbNB5Y42kTbrv566szIhtdm/mU6ELHpHEJuxEwZllK0FyP9j3dqdhsbw
         BXwkw2Qp2rpNfD+LKGRf960hrlaKS3eKMvDMoPYtAy3c1RqPEUQIUpYwOQrGg6Me+w85
         WDZQ==
X-Gm-Message-State: AOJu0YwImMG0CZe8G6m6OYMVrtXlmFQWIVGEZceBPf4FVnoS4JatLMwe
	IUYbSBhjUxLURk6l5a1GII4H22WCY6BQkQNtuyxVVrnYMCxa4kKbtdtG
X-Gm-Gg: ASbGncuZxejs/or/y6fTeaySfpbShzn/5M+36g8kJ3Ki1u25VOxEbGO2tBs15Ol9Vmx
	JjAQe0XdpyfK9S3L+CyQ1bP7yVEMXF1VaGQT4MlxB8FGjgTZHetNW5kYw3n3AvJgTDYSHlSYcwC
	k+pXpcRulAqNeI3BmbQ2rgQw+F6Zxj2Sch6maAKD0R8Im2JPf6RlGozK9ZATrinfnLKaI7FgHDP
	j1mLDGxtojP+g0zvQqDg7chO4OhCGMWhLMLTLGUcuY3/vyVX+A7sLp6xQdmhi/B/MosnzsXEKFr
	69aaNGH9mQn862BZtjrIBJaPC4xbuNt84Zpa8jXPmbavodfuwCoS6x1BH26q5q8uGVuzIj7ha0z
	qJVFJA9IJhoHFtmWRd+YF359NZrTVMNdqRAuiB+QTNxXlug==
X-Google-Smtp-Source: AGHT+IHUSaFkF4DXO4jWgr6IhKt6r7SUw4zRisTsBv6uckf4YSG1z5trfF9jVnd4D6KwGlxjaikOEg==
X-Received: by 2002:a05:600c:4e87:b0:442:d5dd:5b4b with SMTP id 5b1f17b1804b1-4533cac57efmr214672645e9.31.1750290276098;
        Wed, 18 Jun 2025 16:44:36 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9? ([2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535fdf82f9sm1325585e9.29.2025.06.18.16.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 16:44:30 -0700 (PDT)
Message-ID: <b35ce32e-a5e7-4589-ab16-d931194a32bb@gmail.com>
Date: Thu, 19 Jun 2025 00:44:28 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_dynptr_memset() kfunc
To: ihor.solodrai@linux.dev, andrii@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, mykolal@fb.com, kernel-team@meta.com
References: <20250618223310.3684760-1-isolodrai@meta.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250618223310.3684760-1-isolodrai@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/25 23:33, Ihor Solodrai wrote:
> Currently there is no straightforward way to fill dynptr memory with a
> value (most commonly zero). One can do it with bpf_dynptr_write(), but
> a temporary buffer is necessary for that.
>
> Implement bpf_dynptr_memset() - an analogue of memset() from libc.
>
> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> ---
>   kernel/bpf/helpers.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b71e428ad936..dfd04628a522 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2906,6 +2906,33 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_off,
>   	return 0;
>   }
>   
> +/**
> + * bpf_dynptr_memset() - Fill dynptr memory with a constant byte.
> + * @ptr: Destination dynptr - where data will be filled
> + * @val: Constant byte to fill the memory with
> + * @n: Number of bytes to fill
> + *
> + * Fills the first n bytes of the memory area pointed to by ptr
> + * with the constant byte val.
> + * Returns 0 on success; negative error, otherwise.
> + */
> + __bpf_kfunc int bpf_dynptr_memset(struct bpf_dynptr *ptr, u8 val, u32 n)
> + {
> +	struct bpf_dynptr_kern *p = (struct bpf_dynptr_kern *)ptr;
> +	int err;
> +
> +	if (__bpf_dynptr_is_rdonly(p))
> +		return -EINVAL;
> +
> +	err = bpf_dynptr_check_off_len(p, 0, n);
> +	if (err)
> +		return err;
> +
> +	memset(p->data + p->offset, val, n);
Do we need to handle non-contiguous buffers, similarly to 
bpf_dynptr_write (BPF_DYNPTR_TYPE_XDP case)?
> +
> +	return 0;
> +}
> +
>   __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>   {
>   	return obj;
> @@ -3364,6 +3391,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>   BTF_ID_FLAGS(func, bpf_dynptr_size)
>   BTF_ID_FLAGS(func, bpf_dynptr_clone)
>   BTF_ID_FLAGS(func, bpf_dynptr_copy)
> +BTF_ID_FLAGS(func, bpf_dynptr_memset)
>   #ifdef CONFIG_NET
>   BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
>   #endif


