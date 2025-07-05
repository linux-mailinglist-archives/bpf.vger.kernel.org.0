Return-Path: <bpf+bounces-62468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B5AAF9E72
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 08:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B9A567E12
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 06:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372E11A3142;
	Sat,  5 Jul 2025 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E44hnmE5"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3431E2614
	for <bpf@vger.kernel.org>; Sat,  5 Jul 2025 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751696102; cv=none; b=DNepOPQcQ1WtY/YAckeHqQeCNOX1FWOcsp/ngho8WfU00s6NtVMzSTWS8MbEcQZiaMaTN13LxlMq0hzBuMHVPvqT7S1Xi2glHd7s29vUoXeJXSpzskFd/9O1XzDsYLO99+qt9lkn2aRyaeNaYcx7WHqFsnB7Q1SZBtr8Tj24pUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751696102; c=relaxed/simple;
	bh=rkms8nQaaFofjwnpukIbN0+gl/1ngWIh6XiWUuwCEdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAcRiuXttARxCV7niprn8BfKpvLk9brth+mSIvmQ3QpQm/g3oghyLcozvoR0A9HkanRNSgIhznWoDd8KLOHWo/aJ1qxQmJpWoJGkq8fDoJMh4JhfyJGiRFBvBnuPwHYa82yyL9HNqiWr4kJn2N21t/Rr0YzkwKg2+kEzcq5/Wkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E44hnmE5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=w6Jnj4e6P40/PI29vRZ2ACTkGloNLus5f6uRrrWax9o=; b=E44hnmE5RQw1oKjqpnyNVNZn9o
	PIL+yI8eFethsU6SpTw6Lo8iXXGBOSRQe5sDeKch6mLbmldguxtuSf5CcFYf/7jzLOqUbd+xEoHD8
	d7C475GgQafJxvp45qXIHnxRnw8wzeI6IlRL24WvQXuRdsFlVxeltINCKM8+JcDpz4KwrqNEWHPK3
	p1KskdKk3NJOnaRqexj5IsP3l6W5DfMURYQYtcg3T0fnq13NDrwfAPtiTkunrmF2HG7oortk0jlhX
	EgVKANxU/P7XSTqT3+AMEmOXC4AIbAXx15c3pq4idXxgc/7q/T9sxBanRXDJEKTRtKW+IBrDxALWM
	H3GIICgA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXwAr-00000002Hkz-159C;
	Sat, 05 Jul 2025 06:14:57 +0000
Message-ID: <7aef0fa1-09dd-4497-bf77-c4fa764c5882@infradead.org>
Date: Fri, 4 Jul 2025 23:14:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 2/2] bpf: Fix improper int-to-ptr cast in
 dump_stack_cb
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: "kernelci.org bot" <bot@kernelci.org>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, kernel-team@meta.com
References: <20250705053035.3020320-1-memxor@gmail.com>
 <20250705053035.3020320-3-memxor@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250705053035.3020320-3-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/4/25 10:30 PM, Kumar Kartikeya Dwivedi wrote:
> On 32-bit platforms, we'll try to convert a u64 directly to a pointer
> type which is 32-bit, which causes the compiler to complain about cast
> from an integer of a different size to a pointer type. Cast to long
> before casting to the pointer type to match the pointer width.
> 
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: d7c431cafcb4 ("bpf: Add dump_stack() analogue to print to BPF stderr")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  kernel/bpf/stream.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index 8c842f845245..ab592db4a4bf 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -498,11 +498,11 @@ static bool dump_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
>  		if (ret < 0)
>  			goto end;
>  		ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n  %s @ %s:%d\n",
> -						    (void *)ip, line, file, num);
> +						    (void *)(long)ip, line, file, num);
>  		return !ctxp->err;
>  	}
>  end:
> -	ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n", (void *)ip);
> +	ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n", (void *)(long)ip);
>  	return !ctxp->err;
>  }
>  

-- 
~Randy

