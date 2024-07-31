Return-Path: <bpf+bounces-36186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3763394396B
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 01:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4404D1C20ECC
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 23:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBE416D4E5;
	Wed, 31 Jul 2024 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="faoA2asE"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97261BC4E
	for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722469132; cv=none; b=Lzu84sGgqLbyaURaWibkwuX3Z0lVcN49vW4m4qJ26DTdSeF29foKNiD/8ZX9HYF4QOA5tajpmpnnP+OyvN4K9iLf1vZAaSNdRAhb9rOR+Eo1YoJLYJOBJTsN0L9ij3AE5/SogJFD/5t/rZzKhAs1pKClYwDuXz2qEe0EBOkYmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722469132; c=relaxed/simple;
	bh=uOXHLWlJ991YOaMH7aafDJ8mqfgKkO3l6jPhckjII1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fe7JaZl+2EziUDkm2yHvsUbcoa8LfdLAkX/NzgL62KRsZfkyJ+/ZNVdhTRcChKxyUGAxj9FkYQKyk4oZPm1rrUra/PNCgO7VJeNucvoROhaTCKHrCJEofYlG/ynlPtyLJ7sZl/oooeax5BRYII3qUU2xVpZmqEPd42gMrrLJxQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=faoA2asE; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fa767cc5-b330-4789-9a5e-e09e0f224c4e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722469128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RkXblhQWxzmg44eVyZv3xNksRLi5N9T7/5mOUKKVIm0=;
	b=faoA2asE/g6D4lvhAtWtVlaC7oUxM2BHVOZE+RIX9sEWEeReMtZ/OxRx1KBLD43NsMZ8kc
	0075xjA3lMqdyEdkdDMCE8XrURANAfge5EwUSVZbUQK+WefzemC+5wfj30cdOfoWwKmzW3
	+rcMDZP2vnESGLd1+fKYpzgJX/x0CO8=
Date: Wed, 31 Jul 2024 16:38:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 3/4] bpf: Support bpf_kptr_xchg into local
 kptr
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, sinquersw@gmail.com,
 davemarchevsky@fb.com, Amery Hung <amery.hung@bytedance.com>
References: <20240728030115.3970543-1-amery.hung@bytedance.com>
 <20240728030115.3970543-4-amery.hung@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240728030115.3970543-4-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/27/24 8:01 PM, Amery Hung wrote:
> @@ -8399,7 +8408,12 @@ static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
>   static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
>   static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
>   static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
> -static const struct bpf_reg_types kptr_xchg_dest_types = { .types = { PTR_TO_MAP_VALUE } };
> +static const struct bpf_reg_types kptr_xchg_dest_types = {
> +	.types = {
> +		PTR_TO_MAP_VALUE,
> +		PTR_TO_BTF_ID | MEM_ALLOC
> +	}
> +};
>   static const struct bpf_reg_types dynptr_types = {
>   	.types = {
>   		PTR_TO_STACK,
> @@ -8470,7 +8484,8 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>   	if (base_type(arg_type) == ARG_PTR_TO_MEM)
>   		type &= ~DYNPTR_TYPE_FLAG_MASK;
>   
> -	if (meta->func_id == BPF_FUNC_kptr_xchg && type_is_alloc(type)) {
> +	/* local kptr types are allowed as the source argument of bpf_kptr_xchg */
> +	if (meta->func_id == BPF_FUNC_kptr_xchg && type_is_alloc(type) && regno == BPF_REG_2) {
>   		type &= ~MEM_ALLOC;
>   		type &= ~MEM_PERCPU;
>   	}
> @@ -8563,7 +8578,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>   			verbose(env, "verifier internal error: unimplemented handling of MEM_ALLOC\n");
>   			return -EFAULT;
>   		}
> -		if (meta->func_id == BPF_FUNC_kptr_xchg) {
> +		if (meta->func_id == BPF_FUNC_kptr_xchg && regno == BPF_REG_2) {

I think this BPF_REG_2 check is because the dst (BPF_REG_1) can be MEM_ALLOC 
now. Just want to ensure I understand it correctly.

One nit. Please also update the document for bpf_kptr_xchg in uapi/linux/bpf.h:

==== >8888 ====
  * void *bpf_kptr_xchg(void *map_value, void *ptr)
  *      Description
  *              Exchange kptr at pointer *map_value* with *ptr*, and return the
==== 8888< ====


