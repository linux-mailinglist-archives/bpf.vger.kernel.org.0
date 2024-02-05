Return-Path: <bpf+bounces-21188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A19D8849241
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 02:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D321F22129
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 01:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034368BE7;
	Mon,  5 Feb 2024 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjB4WkMQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B1679CD
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 01:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707098040; cv=none; b=adHPTwEJzgssPj6RrdX5MC2to4HlIrXXYSV0ssRrJiI0mIZzBYWF8F052IXdVD9MbRUZSk/Tf1LgYcq5n1vYB556AMAN3h5A6ykfAd1+jfJU/mZbaSOYUEi7GPA9VfvalO/i1z5yzN7p9s0NZeVNa7fQHWl+k7vzmm29pZY/z8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707098040; c=relaxed/simple;
	bh=g8HlNn4T/9lDtpXhb6oYCyziQncacRrUBOcuTh5+Kyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOVh+RICYXddYtrBYw0E3HNbP3IssgQr26SOx5f3sZrifUE2XNCAec/FYCtn5Nz0Sb+67dHMHbFfJEZGaR8DJhJVdjvoe2xq9b1SkZmf5llfeOBeBXtoUzXFrk4rGn/2gxH+1kc6xV2m+ZT//txTKvV8YCtRmyu9Z5WbiTvoH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjB4WkMQ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6040d0c9cf1so37667907b3.0
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 17:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707098038; x=1707702838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W17rV7uOgRcMtu+S+notZ7lvoIPK2azYuew+tX+kbPs=;
        b=IjB4WkMQRL7OqdmXWYtmSA9wQ9k97Ae4LRYiodVqzEoFfq/jOGgUi5OIHnXxKbuMoI
         icryg1AWz77ai5OZ3hwM0lB4jTfm1KFC/RLTRJXu7KABgaCgxtmGhs/BfWx+ZvEI5rM9
         cgURHs5ly2BK3YL+KuyGXPOs8SqUEgcLCsTVCJ3/2/uaSHHPpxYWqmhGQMFpKvXJ78q6
         j93gnHFjnAUjYE4CVSdZqgJxJv8jOriibcXB7a2BfYHJcux4ufQGX1y7hh2SCildc1aV
         QdjqzVyYeS+OHmRE1qr1xFSNyKLAtYcug5LaDgsblMItPo+RAjhIeuHAnj76Q3sO7FNp
         RoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707098038; x=1707702838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W17rV7uOgRcMtu+S+notZ7lvoIPK2azYuew+tX+kbPs=;
        b=qdjMCjOp0ruflQvJQEN8Azah4vQ9CAXnktxaLWPmUtrYb28Q2oYJbe0tCwK5W4OSnI
         ls/2/mLSKKf3veGUAKPd6jT+mJs/MdmnkHLBDAqc1HoldzxmIoljtnXUK0/Ns4vHeECn
         M4wKRNpovXBo51sh0gwkZ8Q5fetZjYD7jPWwC4dzx58Yl9L2S4H6cT5JDkR4xYsGDd33
         6Fc0qiGbhkUL3chH1T/4XlsTuysFqKoT6xha8cR/UCG3JBn0Q8J6WwTaSVa7T9iecwJO
         +iWqWfqiK7nQtviA5NYqquGAqQqrWD4v45npsmIaVPvyiSzQGav1n/scDFx73dA+hsmO
         1BXQ==
X-Gm-Message-State: AOJu0YzX4tl0uB5dXL5dWdANcPaDd0zanEAwKBV+KeCQe4zc+xLRrxFt
	fK0SMjbHtyXP4AouavKqsojBf1E/q3BWtHlbPs9VRGoTVfrsRCj6
X-Google-Smtp-Source: AGHT+IEgDF13agQGO8MmSKT4frsFXafetNyPunN9w+06z2qxcV+j8j0ehXhR7OQR7rBJne4UOaey9g==
X-Received: by 2002:a81:9ad6:0:b0:602:acba:ece1 with SMTP id r205-20020a819ad6000000b00602acbaece1mr14117758ywg.15.1707098037957;
        Sun, 04 Feb 2024 17:53:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW2abqObbzV5+wKJmSgksvZAMSvzAmG+B11DPqxNBiCeAmwhN2wZGP2MIEtq3wdYDRD47RWxmdlUduiN0tqn9NPbzWzxD2Gk8utMpuXg5l6S/9icSM0dzH+/toJ/z9FVf2EYM3z8DG6HFKSpjrOjEuW1/4VW2PWNXj83+xkEpraJCXQ6GNCBVaS8VSkGL6wR3ggDeqo8QbjlgSypVuUBjDSzugL5v+Oxrxs5gW/EPEYRIcjwUbhOmZ951dp6IGo6ZGQgZuI5+7wQ20wEtZFVg==
Received: from ?IPV6:2600:1700:6cf8:1240:47a:ee2a:970f:b6f7? ([2600:1700:6cf8:1240:47a:ee2a:970f:b6f7])
        by smtp.gmail.com with ESMTPSA id z77-20020a0dd750000000b006040cbbe952sm1735372ywd.89.2024.02.04.17.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 17:53:57 -0800 (PST)
Message-ID: <337bf811-9e20-4a75-95e1-e0e60b831cbc@gmail.com>
Date: Sun, 4 Feb 2024 17:53:56 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next v4 5/6] bpf: Create argument information for
 nullable arguments.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, davemarchevsky@meta.com,
 dvernet@meta.com
References: <20240202220516.1165466-1-thinker.li@gmail.com>
 <20240202220516.1165466-6-thinker.li@gmail.com>
 <6b1d0822-73c4-472a-a170-947b53f2c66f@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <6b1d0822-73c4-472a-a170-947b53f2c66f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/2/24 16:40, Martin KaFai Lau wrote:
> 
> I have a question/request.
> 
> On top of tagging nullable, can we extend the ctx_arg_info idea here to 
> allow changing the pointer type?
> 
> In particular, take a stub function in bpf_tcp_ca.c:
> 
> static u32 bpf_tcp_ca_ssthresh(struct tcp_sock *tp)
> {
>          return 0;
> }
> 
> Instead of the "struct sock *sk" argument as defined in the 
> tcp_congestion_ops, the stub function uses "struct tcp_sock *tp'. If we 
> can reuse the ctx_arg_info idea here, then it can remove the existing 
> way of changing the pointer type from bpf_tcp_ca_is_valid_access.
> 

A question just come to me. Why doesn't just define the argument as a 
pointer to struct tpc_sock in the definition of the function pointer?

