Return-Path: <bpf+bounces-29557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF138C2CC6
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 00:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B1FB233C8
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 22:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C292E17108D;
	Fri, 10 May 2024 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9eJW+oz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC862481BA
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 22:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715381584; cv=none; b=doXRI1eKr7+hrzt3lXQM4rILx8ljGcfCZHnBSG+kMASpPzoqiPzsiJTlxURBmnzr1X80WW4ljlPLWXnG/DsvD2LveJQZpaN6JiBpRqJ1xQdobFbXRkC44VSdxwCl9YjsS0nt6CKlsOn7PmW+oKQju5RevAx/Sl3P8PgdY0WXng0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715381584; c=relaxed/simple;
	bh=pcnGw81pN1BmSt4487VrEyhz7BbzJphCo0vDlCBABZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWCiISqEfz4Lz/8GiavoBWFmWUh7elWR6/hlRvWC8HEqbRbdqgkA2Pg3YJepiB7im2u3KQJvhEGTVG1udjYzszWjD1z704shvfQC7m0INEjLgMLz2bQtO+jzXgtnI+3FlvACTE/c2dH29x9d9jCUnf5tZigXqQwIiKJV7kZA8lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9eJW+oz; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c9996178faso726537b6e.2
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 15:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715381582; x=1715986382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dFmQTNQMZxvZslsWm8kbdXOnNAzbFp4cA2dwRGRj8VI=;
        b=O9eJW+oze1wWuOgIK0LyFLmq0eQr9iy5Ls/eR4kS/JKWQFbCgz2TAnuY8I/rw/PlpJ
         FGdHjhm+ZLNN6VWkea01YQFGhf08apjj8I9bFmhOqyLg1LejgJIaQk82i58uGF8Bjn+l
         F3yS8yC1hrViCYUDP1W9wlBanOHCrEijY0GyK9t5tDqWq+BCf9eSNkbisIaFDJYv+p9/
         n7zqE0UL6IaUkDfIYjhS79j0Z1GDH4PlhpvbAuwO8vveXweKN3czskuPqrBsAT+h6F+R
         Q4AUK/ZPhzA9BbtrRjQFGFvuH4HmAzBPrVdkzAYGHWhZ98FDIJkE47A3UQg7CB0sqUOb
         mGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715381582; x=1715986382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFmQTNQMZxvZslsWm8kbdXOnNAzbFp4cA2dwRGRj8VI=;
        b=TBDT1KVh6lWJrUPnFjPQGP+RL2a/BLbXYhQynxrSkleUVVS6yi2Rn5X44sDgq+vRbK
         qhrtk0kJ13VECpnbdVHleWUKXSFF5h2h/KnJBiuygOUqdeVeIsTP2yhG8pf6paRuk7OZ
         QT08E9qzW4AyVsfkw3qrHaaA5GguhCFALVB4IClLH7CDGfEfdfnVVdnDAhKbcywT28nh
         c2Bu1pYH0KHKSIBjLmQTRj6F6dZENpcQKMRpef8hiAv2DiWGEhhQUFXe7WBE1y5cvkem
         GhPanTICZTsNrgYJQi1YGDSFf+Nxzulgf61fh9Ny4VtT7Ss8jbg//NxRVgd70OaDeSin
         Brrw==
X-Forwarded-Encrypted: i=1; AJvYcCX7/p1nHEZ3tVvtiRHIJN4uIj/dObWyURWUYY62qgccgAUW7JK6uJzKzdaQsfj3Reqy/h4Ya8TXktwEuRhOx97cQYX3
X-Gm-Message-State: AOJu0Yy9up5Tdp3WrO7Xh5UELQHBFQbOZ4UeRWadq2WTdaA2Ui065uYY
	wzWovgOSL3pg9StPYftxrStMhwMfgVsi1fgvMKH/coY3K9iqKANw
X-Google-Smtp-Source: AGHT+IFTqKuwyGy9Ahnw994kmK9o6Sw46enp527ys48lQccxdvOwS+EZLCsX2IKQyx9MLv2G5+AhEQ==
X-Received: by 2002:a05:6808:3ab:b0:3c9:68bd:5786 with SMTP id 5614622812f47-3c9970cec70mr4705102b6e.45.1715381581942;
        Fri, 10 May 2024 15:53:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:20fd:6927:f7be:d222? ([2600:1700:6cf8:1240:20fd:6927:f7be:d222])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c99308f4f3sm667027b6e.13.2024.05.10.15.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 15:53:01 -0700 (PDT)
Message-ID: <52912c4f-219a-45d4-bb61-aaeadaf880c5@gmail.com>
Date: Fri, 10 May 2024 15:53:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 7/9] selftests/bpf: Test kptr arrays and kptrs
 in nested struct fields.
To: Eduard Zingerman <eddyz87@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240510011312.1488046-1-thinker.li@gmail.com>
 <20240510011312.1488046-8-thinker.li@gmail.com>
 <d8f2fa21a9af5bfcb2acb1addecea435285c40e6.camel@gmail.com>
 <d2b9a943-ca26-404d-899a-c7651ce18a42@gmail.com>
 <62a51fcaddbf5eb8552a96e6a24ded83f8f9fa49.camel@gmail.com>
 <aa0cb7c8-f057-4f51-84c4-2cc9bc4e2edb@gmail.com>
 <a938837ff87adcdebaa58f612395dee06a0ea94a.camel@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <a938837ff87adcdebaa58f612395dee06a0ea94a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/10/24 15:31, Eduard Zingerman wrote:
> On Fri, 2024-05-10 at 15:25 -0700, Kui-Feng Lee wrote:
> 
>>>>> Also, in the tests below you check that a pointer to some object could
>>>>> be put into an array at different indexes. Tbh, I find it not very
>>>>> interesting if we want to check that offsets are correct.
>>>>> Would it be possible to create an array of object kptrs,
>>>>> put specific references at specific indexes and somehow check which
>>>>> object ended up where? (not necessarily 'bpf_cpumask').
>>>>
>>>> Do you mean checking index in the way like the following code?
>>>>
>>>>     if (array[0] != ref0 || array[1] != ref1 || array[2] != ref2 ....)
>>>>       return err;
>>>
>>> Probably, but I'd need your help here.
>>> There goal is to verify that offsets of __kptr's in the 'info' array
>>> had been set correctly. Where is this information is used later on?
>>> E.g. I'd like to trigger some action that "touches" __kptr at index N
>>> and verify that all others had not been "touched".
>>> But this "touch" action has to use offset stored in the 'info'.
>>
>> They are used for verifying the offset of instructions.
>> Let's assume we have an array of size 10.
>> Then, we have 10 infos with 10 different offsets.
>> And, we have a program includes one instruction for each element, 10 in
>> total, to access the corresponding element.
>> Each instruction has an offset different from others, generated by the
>> compiler. That means the verifier will fail to find an info for some of
>> instructions if there is one or more info having wrong offset.
> 
> That's a bit depressing, as there would be no way to check if e.g. all
> 10 refer to the same offset. Is it possible to trigger printing of the
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
How can that happen? Do you mean the compiler does it wrong?


> 'info.offset' to verifier log? E.g. via some 'illegal' action.
Yes if necessary!

