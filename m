Return-Path: <bpf+bounces-39418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F20D972D5C
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 11:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5CB1C2442C
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 09:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455D718953A;
	Tue, 10 Sep 2024 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2L83AY+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1F1188CBD;
	Tue, 10 Sep 2024 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960074; cv=none; b=HILjoBMRHZwgj0S4kSOny1/JZtloz4Edh0R/8zIgMMQC7KNKXQJPymv/A1C4hddYuh8trudIfuxjTS9093vvM5wpe/hb0BEh8D9HY3Jw7D9kdpImq6ASPNdKT5Fg76CqBfkHfaQ2MTN7NesIMB9h3qiFlr6fYuAosiGm25qdo6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960074; c=relaxed/simple;
	bh=RUqJ9tzaeKLVaKizK8HJaDC8VZ9gvBxJs3B6tN136nM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CoZJufnYx+HK/GceQi4oqcAKA7Pztxhy1u3e+h8+gieIu/kkTFeHnhwqgZIXGyU3l4cBhzQzAs4s6PhOp8etcM1whYvt5GlFp9RsoO6ducE5ORF0vV2FZK+LITQt5XML/9f1t4T8GPIbJEm+IZb3q+GCDQ07E1KGD/YDzKu6CkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2L83AY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857D2C4CEC3;
	Tue, 10 Sep 2024 09:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725960074;
	bh=RUqJ9tzaeKLVaKizK8HJaDC8VZ9gvBxJs3B6tN136nM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f2L83AY+Xya1hBflVtW4Gjq//v7mqcjYvnejFzhUZXBINCMe/v3sP94ihvWZY8TcH
	 5j6Om4KxbcvNDSjTw1m2He5KjiKL0KO/0cD5AfczCeLkpTlL/FjVDI6zEw5KeFijnr
	 ba/uzqs1aStHTRFGsRLQely2jm3JK4WqMpFfNxyfcepHy3RE78rXR/S9yGfaKVYVga
	 BHJL0n+doEzPScgzAKlhDQQpV8a7kZk6iOg41+n0LVnW2VchITNoG3LnBcj5fqDFLv
	 EyLMxKzP9ZlBh8/EW04+n1IUxVzu3P+E+7PWqy7uikT36ACnMMpvPC9LT2XPv9Prh/
	 UzbYvlEIv/mww==
Message-ID: <b6bef740-8feb-4a50-91a0-e705b5361df9@kernel.org>
Date: Tue, 10 Sep 2024 10:21:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Fix undefined behavior caused by shifting into
 the sign bit
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 jserv@ccns.ncku.edu.tw, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240908140009.3149781-1-visitorckw@gmail.com>
 <4a42a392-590d-4b90-a21d-df4290d86204@kernel.org>
 <Zt4Oc+4/DPqDSsoN@visitorckw-System-Product-Name>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <Zt4Oc+4/DPqDSsoN@visitorckw-System-Product-Name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

2024-09-09 04:52 UTC+0800 ~ Kuan-Wei Chiu <visitorckw@gmail.com>
> On Sun, Sep 08, 2024 at 08:48:40PM +0100, Quentin Monnet wrote:
>> On 08/09/2024 15:00, Kuan-Wei Chiu wrote:
>>> Replace shifts of '1' with '1U' in bitwise operations within
>>> __show_dev_tc_bpf() to prevent undefined behavior caused by shifting
>>> into the sign bit of a signed integer. By using '1U', the operations
>>> are explicitly performed on unsigned integers, avoiding potential
>>> integer overflow or sign-related issues.
>>>
>>> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>>
>>
>> Looks good, thank you.
>>
>> Acked-by: Quentin Monnet <qmo@kernel.org>
>>
>> How did you find these?
> 
> TL;DR: I discovered this issue through code review.
> 
> I am a student developer trying to contribute to the Linux kernel. I
> was attempting to compile bpftool with ubsan enabled, and while running
> ./bpftool net list, I encountered the following error message:
> 
> net.c:827:2: runtime error: null pointer passed as argument 1, which is declared to never be null
> 
> This prompted me to review the code in net.c, and during that process,
> I unexpectedly came across the bug that this patch addresses.


Nice


> 
> As for the ubsan complaint mentioned above, it was triggered because
> qsort is being called as qsort(NULL, 0, ...) when netfilter has no
> entries to display. In glibc, qsort is marked with __nonnull ((1, 4)).
> However, I found conflicting information on cppreference.com [1], which
> states that when count is zero, both ptr and comp can be NULL. This
> confused me, so I will need to check the C standard to clarify this. If
> it turns out that qsort(NULL, 0, ...) is invalid, I will submit a
> separate patch to fix it.


OK, thanks for looking into it!


> 
> BTW, should this patch include a Fixes tag and a Cc @stable?
> 

We could maybe have used a Fixes:, but the patch is merged already so 
never mind. As for stable, I don't think this is necessary. I don't 
believe we can hit the undefined behaviour today; and we encourage 
people to package bpftool from the GitHub mirror anyway, where your 
patch will land soon.

Thanks,
Quentin

