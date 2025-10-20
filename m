Return-Path: <bpf+bounces-71360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDECBEFE35
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 10:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A4A3E6EEF
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 08:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A5A2EA48E;
	Mon, 20 Oct 2025 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFsc/JS0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238493FB31
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948357; cv=none; b=OjLgdpHsJC9ElwEGuCh3RgcZNDGZfQZS4ireCNeKYFZgLfa9pn6O/jVQrnm+59gJv/+UzjsAm4rUUuv5y5bkTSci9Y5tz61i5Vrlx08r+tEvKJbDnDifCS3LXhlc7+2OB4GskGB6CTCdx2IiLfOz6ldnZIJ3QIe/b0Eia3Xsahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948357; c=relaxed/simple;
	bh=0fXq12iirln66Vse2pGIM6f8XTT1Eb6EvxlqqMLRYUw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdZuza8jDsxIwDd5JEfYFkwhtH65SyvhdVo93M1V1BBOGl6i83ByF9Z2gaHdbqVD5eCK8HirPW+NFGr/Wt9utWAKyG1znP/FnrfNR5cX07k0f9+y+dVplKwg8D56ZBpVxcsgxExvlVHG1PrUBkeN1gx1v0WljlODoEjIy2cYH38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFsc/JS0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47117f92e32so24185875e9.1
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 01:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760948354; x=1761553154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fazdpRfxsDD7fetjq1w/Glu0iHVJ/m+YWhcBobrHBOU=;
        b=AFsc/JS0u8Dj5b5Enforgj97auzKjJbJSewXFauddiCAFlDL4m85Hm6rTTG9NR6KHy
         Yh26KJcQ5IcQ3LQQGknAxOO7HARsV0TxtSaZqhT0oSH6NhpoJ8CrwJBxqi+rYeH2CWx5
         hG69ZE99F9c0la9R5NXpy/4BIYiw5TqL+BvY6Y1UBZ24WYPcNnQJlSdI0zJjtj/5j2FC
         YodVhpzEXixxwRi4xmuWnBnVur0VWmPXp+KQ8B4TxqqvaO27MTiF6UG2LxxIee8+jaQ9
         PlWNs8DIVSsuzm2yvn4ib9gCNCp+ITCDlRg7W1dRoOOsy3VP2h8nuDei/vi9OWwKz5zA
         7OYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948354; x=1761553154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fazdpRfxsDD7fetjq1w/Glu0iHVJ/m+YWhcBobrHBOU=;
        b=J7UntWsqjJodAXnUmTLNieuExPqJisniCm+ULRcVWeC9Ryv6VumBbK0H5JGTQ9gCIV
         ukblxFBIidYvP1s4CtuM9XTcyq5QTN9VrEzpsjaoj4v3UiajSUyZRZYvJ6tR7X630Lx+
         /Ofwg5XbyBCqnH+f1w0r6zLX15+VYUOPy7OxZQtXjaaDEZN9Uk/8lLL4h9PORTZIIw9q
         4nHytNtu1Rml+tSF+x0eTveUwTr1fWkFWs7G9BXySGqWpkYWUMI9octeRNGzxIsGnyUZ
         HOduHCP/1MMxido+EnXj9JFvmfDUonfp9s69OCk2vvUm+fvLk/UHIV9Pi/XhMY/I1Y6s
         cCjw==
X-Forwarded-Encrypted: i=1; AJvYcCVypZNDPWbsWOJ8LvOGzeDeTH09SzbJuy6LTVdkwyFriZAXG8UZTOLbLVKPn5uHIybzaaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+iNkr6F/wci6ZqoTvH3qHwZoIyLvEntasm8NFBuWTyS3Ls8Nv
	AtNbuF7JG3rNv04v79MmfiUVgrAxXuOKRLpq6he91+5RKNg+UJW84hJh
X-Gm-Gg: ASbGncv2p7S+zVba67PdE5rC0pHc2pZiQj7cJmh7hLhUWf4d0RWHsq1zqETvPwn9JXl
	lVQTXzzEF/WoHZOXuYWL7YZ0/aZzjqpAGtccTV7DvzZOCzKW2nW5R+aKiXoUIE3P+asAyqT2K9E
	PbFLB3xoKAfPP7wklgrJ+FKfK5ISg/xHXnDEpIHCMBELgbsjcpOGuCBkEIi34w3AnUaqV8480QV
	mTPd//3bMzXuSvIRR/hn1+mhUTZt5CyC9x/hS5tfFPnUdVxN+nPmrC+VnAT7CLupz05wMCjqi2y
	C5etDtEjKT7DmhnEqtsp5VFFRHNPt7qwtOw42RMEcihmMF0WXJQoFwUifuOcEECRrR8nZMH9UJQ
	Y2tOohVOo38S+9257CIdha4fTcAOoVqV02p9Jf48//nvX6jLVrA==
X-Google-Smtp-Source: AGHT+IHpSaBl/fbDQGboMp5aBmz55psJfILfa3Nr3uL7f9e4C9aGVeEfJJbxbkWC+GMQnBRat0EiFQ==
X-Received: by 2002:a05:600c:3149:b0:470:bcc4:b0a0 with SMTP id 5b1f17b1804b1-47117925919mr99554785e9.34.1760948354254;
        Mon, 20 Oct 2025 01:19:14 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471556e1892sm130375105e9.18.2025.10.20.01.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:19:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 20 Oct 2025 10:19:11 +0200
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, mattbobrowski@google.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, leon.hwang@linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 2/5] bpf: add kfunc bpf_tracing_is_exit for
 TRACE_SESSION
Message-ID: <aPXwfxRvSk63FOxU@krava>
References: <20251018142124.783206-1-dongml2@chinatelecom.cn>
 <20251018142124.783206-3-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018142124.783206-3-dongml2@chinatelecom.cn>

On Sat, Oct 18, 2025 at 10:21:21PM +0800, Menglong Dong wrote:
> If TRACE_SESSION exists, we will use extra 8-bytes in the stack of the
> trampoline to store the flags that we needed, and the 8-bytes lie before
> the function argument count, which means ctx[-2]. And we will store the
> flag "is_exit" to the first bit of it.
> 
> Introduce the kfunc bpf_tracing_is_exit(), which is used to tell if it
> is fexit currently.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/verifier.c    |  5 ++++-
>  kernel/trace/bpf_trace.c | 43 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 40e3274e8bc2..a1db11818d01 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12284,6 +12284,7 @@ enum special_kfunc_type {
>  	KF___bpf_trap,
>  	KF_bpf_task_work_schedule_signal,
>  	KF_bpf_task_work_schedule_resume,
> +	KF_bpf_tracing_is_exit,
>  };
>  
>  BTF_ID_LIST(special_kfunc_list)
> @@ -12356,6 +12357,7 @@ BTF_ID(func, bpf_res_spin_unlock_irqrestore)
>  BTF_ID(func, __bpf_trap)
>  BTF_ID(func, bpf_task_work_schedule_signal)
>  BTF_ID(func, bpf_task_work_schedule_resume)
> +BTF_ID(func, bpf_tracing_is_exit)
>  
>  static bool is_task_work_add_kfunc(u32 func_id)
>  {
> @@ -12410,7 +12412,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>  	struct bpf_reg_state *reg = &regs[regno];
>  	bool arg_mem_size = false;
>  
> -	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
> +	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
> +	    meta->func_id == special_kfunc_list[KF_bpf_tracing_is_exit])
>  		return KF_ARG_PTR_TO_CTX;
>  
>  	/* In this function, we verify the kfunc's BTF as per the argument type,
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 4f87c16d915a..6dde48b9d27f 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3356,12 +3356,49 @@ static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set = {
>  	.filter = bpf_kprobe_multi_filter,
>  };
>  
> -static int __init bpf_kprobe_multi_kfuncs_init(void)
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc bool bpf_tracing_is_exit(void *ctx)
> +{
> +	/* ctx[-2] is the session flags, and the last bit is is_exit */
> +	return ((u64 *)ctx)[-2] & 1;
> +}

I think this could be inlined by verifier

jirka


> +
> +__bpf_kfunc_end_defs();

SNIP

