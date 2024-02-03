Return-Path: <bpf+bounces-21120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFDF847DFC
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 01:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E330D28357F
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 00:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D22EA3D;
	Sat,  3 Feb 2024 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rmBPyLRB"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA52655
	for <bpf@vger.kernel.org>; Sat,  3 Feb 2024 00:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706921557; cv=none; b=dovvLGpIJjDAXJ6HzTjd6gv3oZtFJfxMzZ1L8roxWRu6N6XXa1Jv/KLlgXy8tlR2nHlWnFDB/8Jg/MkPMbqXlDsF4oKtMeQJo0E2vBPSNMH7Mkbk6vz9B67nOnCzYTS0scJs3AIKGvRR2TJans7qiWtlr/9mCHt6bcobJwTQQaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706921557; c=relaxed/simple;
	bh=Hu+RENWbMKSgannqDCUQeIF+uU82xOsEak5VDAVq044=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7L6g5IHCiSRFrn+4YI30qLSNXBkjW2Wjw5OXn/4IFBLvAoSmXxhLXIMgiGFdXtkgb5Lj4Cmepbl/OWsJ41ZM5YyKEPVH3ODnPWc32h+RLw49VQMjkfs3KayPFOXV3RQ2Grba+klEI38EMPDAQJi9Ml5lvVTQwU0pxj5QZihniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rmBPyLRB; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <190cf3fc-5c5e-4044-9cdc-4804ee49a03f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706921553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9PTI1OW6Bse2qc3RLWDsJjefEsEAOUQQLyhdJ97qQc=;
	b=rmBPyLRBw6+Uq48ynHCjseDItZIGuViboxN4zAkF/00vuQOlDblKqcmDqiGHbR4um+T31t
	OSEfRH6xubKXk538DQz8lzwJbUJ35N1efNiywDrCVxZqFyIodnaIToYlQ1IwaffyrozONU
	CaL6MAqW5dOf2YSR3+pYdIsN75cNIxk=
Date: Fri, 2 Feb 2024 16:52:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v4 2/6] bpf: Extend PTR_TO_BTF_ID to handle
 pointers to scalar and array types.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 davemarchevsky@meta.com, dvernet@meta.com
References: <20240202220516.1165466-1-thinker.li@gmail.com>
 <20240202220516.1165466-3-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240202220516.1165466-3-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/2/24 2:05 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> The verifier calls btf_struct_access() to check the access for
> PTR_TO_BTF_ID. btf_struct_access() supported only pointer to struct types
> (including union). We add the support of scalar types and array types.
> 
> btf_reloc_array_access() is responsible for relocating the access from the
> whole array to an element in the array. That means to adjust the offset
> relatively to the start of an element and change the type to the type of
> the element. With this relocation, we can check the access against the
> element type instead of the array type itself.
> 
> After relocation, the struct types, including union types, will continue
> the loop of btf_struct_walk(). Other types are treated as scalar types,
> including pointers, and return from btf_struct_access().

Unless there is an immediate use case to support PTR_MAYBE_NULL on a non-struct 
pointer, I would suggest to separate the other pointer type support from the 
current PTR_MAYBE_NULL feature patchset. afaik, they are orthogonal.

> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   kernel/bpf/btf.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0847035bba99..d3f94d04c69d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6590,6 +6590,61 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
>   	return -EINVAL;
>   }
>   
> +/* Relocate the access relatively to the beginning of an element in an
> + * array.
> + *
> + * The offset is adjusted relatively to the beginning of the element and the
> + * type is adjusted to the type of the element.
> + *
> + * Return NULL for scalar, enum, and pointer type.
> + * Return a btf_type pointer for struct and union.
> + */
> +static const struct btf_type *
> +btf_reloc_array_access(struct bpf_verifier_log *log, const struct btf *btf,
> +		       const struct btf_type *t, int *off, int size)
> +{
> +	const struct btf_type *rt, *elem_type;
> +	u32 rt_size, elem_id, total_nelems, rt_id, elem_size;
> +	u32 elem_idx;
> +
> +	rt = __btf_resolve_size(btf, t, &rt_size, &elem_type, &elem_id,
> +				&total_nelems, &rt_id);
> +	if (IS_ERR(rt))
> +		return rt;
> +	if (btf_type_is_array(rt)) {
> +		if (*off >= rt_size) {
> +			bpf_log(log, "access out of range of type %s with offset %d and size %u\n",
> +				__btf_name_by_offset(btf, t->name_off), *off, rt_size);
> +			return ERR_PTR(-EACCES);
> +		}
> +
> +		/* Multi-dimensional arrays are flattened by
> +		 * __btf_resolve_size(). Check the comment in
> +		 * btf_struct_walk().
> +		 */
> +		elem_size = rt_size / total_nelems;
> +		elem_idx = *off / elem_size;
> +		/* Relocate the offset relatively to the start of the
> +		 * element at elem_idx.
> +		 */
> +		*off -= elem_idx * elem_size;
> +		rt = elem_type;
> +		rt_size = elem_size;
> +	}
> +
> +	if (btf_type_is_struct(rt))
> +		return rt;
> +
> +	if (*off + size > rt_size) {
> +		bpf_log(log, "access beyond the range of type %s with offset %d and size %d\n",
> +			__btf_name_by_offset(btf, rt->name_off), *off, size);
> +		return ERR_PTR(-EACCES);
> +	}
> +
> +	/* The access is accepted as a scalar. */
> +	return NULL;
> +}
> +
>   int btf_struct_access(struct bpf_verifier_log *log,
>   		      const struct bpf_reg_state *reg,
>   		      int off, int size, enum bpf_access_type atype __maybe_unused,
> @@ -6625,6 +6680,12 @@ int btf_struct_access(struct bpf_verifier_log *log,
>   	}
>   
>   	t = btf_type_by_id(btf, id);
> +	t = btf_reloc_array_access(log, btf, t, &off, size);
> +	if (IS_ERR(t))
> +		return PTR_ERR(t);
> +	if (!t)
> +		return SCALAR_VALUE;
> +
>   	do {
>   		err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag, field_name);
>   


