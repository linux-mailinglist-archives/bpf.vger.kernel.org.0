Return-Path: <bpf+bounces-37918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA3095C3CD
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 05:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45DA1C223D8
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 03:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0E6383A1;
	Fri, 23 Aug 2024 03:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XFKh4TA/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF92A26AF6
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724384676; cv=none; b=YaBOfXG+h5LfWgEfo8iqBq0h6Q6oABi2nYCwyYU2Y5KYder+wfbjKYaNvQ1uCCbLVG9VXGI8WoxdjKsUl38IZ6F3gvH47aXG0kcAM39Vwh3RYub7rtuY7uEpMwtgOqFM5ylwVlIxECnjH+gSD5PHW8b3JWQ1WQF43O0z99nAsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724384676; c=relaxed/simple;
	bh=abw/z5IHn9ehJnDVo1tkNrFfQ0rzqPxCzKNQl+IeCAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9ns+7Szv59lgcMNeNiiLVLTnGsp22PfU/Iw/SzQ1Wjc7wjwh5WBG5Rn/zOcIbxKZgh/PIsul+o235sLFulpNdlwOGJSFvh4vSH1t5nRr4mKHKwV85Xsr/xPCNhO9rDolP/8qB1uj/233aYn8UxXa/cO9tH5zW0HK/GuwOAYOYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XFKh4TA/; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70968db52d0so1568907a34.3
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 20:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724384674; x=1724989474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n5lU/GKN15z6gCJEZbRxdqV0py7guJKEiEwgePvZeN4=;
        b=XFKh4TA/KWAGiboQUFjiL/WFHJwo7raMQmUb0FNaHedoT0tPON0LchDSOtwk8qc1NU
         yGd4UGZxJKRzCKdOOzFjjgrl5Wlj7w5StbSLRGKPAUnvsCwa9AVP7zkMloWcgQWp/j8A
         /wp+d57rEx8SOO93ORfZ4zsWaQkKVGJgIghE6u6H7+a/4Gzl4F8oWy2sbze+4apBuD1D
         8EISGS+OYelGDu4N/hrpJK0SJL7e/vXq64EW23sSXruzvc0u4xMTCTWRpRGpxpU69X51
         tkY2sRmID5ntSc25fOA6c0r17oWOblOW43plsQxyJNNpH4p7SpA/R35CduYnOtWL+00R
         ZjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724384674; x=1724989474;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5lU/GKN15z6gCJEZbRxdqV0py7guJKEiEwgePvZeN4=;
        b=FhnOuw5Klm8lWh1CZLtM+ZJd6qkgTZNOS1NFf5B7ErvhXneDvVfUms8+MLGVhxvdlb
         nta278iXyq2S9VqVpRNKcwt7xnARY4GJsox2zCAN4xnFKdU03UndKbPbWJz+5jy3O40M
         Gq0C05dBanHX2kN1G3Ivv367kakNIUfDaF4IGR7o/MCCZnLhPhUtlCLsyEc7la5laMpU
         FQuZj6cmfDYJx5E1qC1tRx8lLPi8kKlEQuAp7DE1lTXnWlwcN8BJgnUFNTZXzxchLB9k
         gmp5ZXiJ4WoArWxynRwbzIvdfKxQsaO9mMNbamYI4A+Srjt4T8817Zq2ts9XQTcGq/hA
         oW6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFH4NPJCG2s7jf34uXk1JLGlWQOhQ4zJCo/ru9xWkSG8ajU3IP7MKsx5LBFOaVC8oAOw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQhtRwFYKMwqFlMJgL8nS5FfcWOlNp1TbO2ZdAYr/Sx1r1cWmd
	kagj4XFxwvIMGcRD9Va5frWuazpJNTYGdS5H92QD2yCz48oLhEsDedavPLmIME4=
X-Google-Smtp-Source: AGHT+IGHqRlr3TWvbX9T+87JK+5tQ1Puj3ivKH2OiOFgN3/+Yp7Ctoze4SOb8Y5LBDrneheUREmhBA==
X-Received: by 2002:a05:6808:2e9a:b0:3d9:40c2:eb42 with SMTP id 5614622812f47-3de2a8f4438mr1003307b6e.39.1724384673837;
        Thu, 22 Aug 2024 20:44:33 -0700 (PDT)
Received: from [192.168.6.6] ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434315b02sm2089222b3a.152.2024.08.22.20.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 20:44:33 -0700 (PDT)
Message-ID: <95ef23f0-1215-4882-9b20-85bbfa1fdff1@bytedance.com>
Date: Fri, 23 Aug 2024 11:44:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] objpool: fix choosing allocation for percpu slots
To: Viktor Malik <vmalik@redhat.com>, linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org
References: <20240822082519.216070-1-vmalik@redhat.com>
Content-Language: en-US
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Autocrypt: addr=wuqiang.matt@bytedance.com; keydata=
 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
 4mCJUdEkdwCS
In-Reply-To: <20240822082519.216070-1-vmalik@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/22 16:25, Viktor Malik wrote:
> objpool intends to use vmalloc for default (non-atomic) allocations of
> percpu slots and objects. However, the condition checking if GFP flags
> are equal to GFP_ATOMIC is wrong and causes kmalloc to be used in most
> cases (even if GFP_KERNEL is requested). Since kmalloc cannot allocate
> large amounts of memory, this may lead to unexpected OOM errors.

Sure, good catch. Don't notice that GFP_ATOMIC is not atomic. My original
intention is using kmalloc only if GFP_ATOMIC is specified and other flags
should go with vmalloc, but (pool->gfp == GFP_ATOMIC) is not accurate.

Masami, please help review and include this patch into your patch set if
it's appropriate to you. Thanks.

Reviewed-by: Matt Wu <wuqiang.matt@bytedance.com>

> For instance, objpool is used by fprobe rethook which in turn is used by
> BPF kretprobe.multi and kprobe.session probe types. Trying to attach
> these to all kernel functions with libbpf using
> 
>      SEC("kprobe.session/*")
>      int kprobe(struct pt_regs *ctx)
>      {
>          [...]
>      }
> 
> fails on objpool slot allocation with ENOMEM.
> 
> Fix the condition to truly use vmalloc by default.
> 
> Fixes: b4edb8d2d464 ("lib: objpool added: ring-array based lockless MPMC")
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>   lib/objpool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/objpool.c b/lib/objpool.c
> index 234f9d0bd081..fd108fe0d095 100644
> --- a/lib/objpool.c
> +++ b/lib/objpool.c
> @@ -76,7 +76,7 @@ objpool_init_percpu_slots(struct objpool_head *pool, int nr_objs,
>   		 * mimimal size of vmalloc is one page since vmalloc would
>   		 * always align the requested size to page size
>   		 */
> -		if (pool->gfp & GFP_ATOMIC)
> +		if ((pool->gfp & GFP_ATOMIC) == GFP_ATOMIC)
>   			slot = kmalloc_node(size, pool->gfp, cpu_to_node(i));
>   		else
>   			slot = __vmalloc_node(size, sizeof(void *), pool->gfp,

