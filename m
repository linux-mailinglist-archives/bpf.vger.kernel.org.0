Return-Path: <bpf+bounces-21515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAED184E6FB
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 18:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D7AB2C8FD
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 17:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AE6823D6;
	Thu,  8 Feb 2024 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p/P7q0in"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05C181AC7
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414225; cv=none; b=VHXXIV69LGsoj8lc+n8XEXbCDqCfnc8leDhJJz5mmh97jxOuNOSypDcq/3B3hlc5FiaZXcAmFjFSwT4fHk/SVtOqNadB081N4MMypZyunZjFmxuoIztUh+TcaP6BV80H8lsQFNi/6iaUVF8yFapMdAw2lxO1biavzwBX8WvNWNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414225; c=relaxed/simple;
	bh=RAUtb5+F64AXDMIK6B/5O8E57jWTnbB/YjGvhyP3lE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvS8+mgsuIPk5D17EVLz68FSIU5WHOakl0PDvXOUiFhqPRORTEQ7ZSXgMIr5iyBmT9MqGN0ynaVziMMHraRSU4MWY6mexVdEr46kQ4l8/PAeJ4LZFu0ttzL2iTwjGFs+N/Bmf8xbtejc0RMCZzRaYdQ9wXufR7VKIL8F4n7ujQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p/P7q0in; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4e79dc07-ba34-49e3-92fe-a5f2c96045ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707414220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCr5/XB2tXYtNc3K1GulLHjeG6GIhyA61x5MdIiEgqQ=;
	b=p/P7q0inly9HZaF+9gbk5R8DzuGnuzLeNR4z/1taCEhvPSn3zKM3/6Ln6DKmd8O+cysPg9
	2Du5OA/HxFTuh0rWZ9hCEPk79q6KXhlC+v4pFT5hwMsHaI+JeLjFsgCKiVoem0AxdBnl+a
	IIW1zVU8TYxvrQvuK3CdPyNSZ1AJQnM=
Date: Thu, 8 Feb 2024 09:43:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/3] libbpf: Check the return value of
 bpf_iter_<type>_new()
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org
References: <20240208090906.56337-1-laoar.shao@gmail.com>
 <20240208090906.56337-4-laoar.shao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240208090906.56337-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/8/24 1:09 AM, Yafang Shao wrote:
> On success, bpf_iter_<type>_new() return 0. On failure, it returns ERR.
> We'd better check the return value of it.

Not sure whether this patch is necessary or not.

I checked:
   bpf_iter_num_{new,next}
   bpf_iter_task_vma_{new,next}
   bpf_iter_css_task_{new,next}

It looks like the convention is for *_next() return NULL or not
instead of relying on return value of _new() to decide whether to
proceed or not. Maybe Andrii can clarify.

>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>   tools/lib/bpf/bpf_helpers.h | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 79eaa581be98..2cd2428e3bc6 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -133,6 +133,15 @@
>   # define __bpf_unreachable()	__builtin_trap()
>   #endif
>   
> +#ifndef __must_check
> +#define __must_check __attribute__((warn_unused_result))
> +#endif
> +
> +static inline void * __must_check ERR_PTR(long error)
> +{
> +	return (void *) error;
> +}
> +
>   /*
>    * Helper function to perform a tail call with a constant/immediate map slot.
>    */
> @@ -340,14 +349,13 @@ extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __weak __ksym;
>   	/* initialize and define destructor */							\
>   	struct bpf_iter_##type ___it __attribute__((aligned(8), /* enforce, just in case */,	\
>   						    cleanup(bpf_iter_##type##_destroy))),	\
> -	/* ___p pointer is just to call bpf_iter_##type##_new() *once* to init ___it */		\
>   			       *___p __attribute__((unused)) = (				\
> -					bpf_iter_##type##_new(&___it, ##args),			\
>   	/* this is a workaround for Clang bug: it currently doesn't emit BTF */			\
>   	/* for bpf_iter_##type##_destroy() when used from cleanup() attribute */		\
> -					(void)bpf_iter_##type##_destroy, (void *)0);		\
> +					(void)bpf_iter_##type##_destroy,			\
> +					ERR_PTR(bpf_iter_##type##_new(&___it, ##args)));	\
>   	/* iteration and termination check */							\
> -	(((cur) = bpf_iter_##type##_next(&___it)));						\
> +	((!___p) && ((cur) = bpf_iter_##type##_next(&___it)));					\
>   )
>   #endif /* bpf_for_each */
>   

