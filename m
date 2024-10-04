Return-Path: <bpf+bounces-41004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA688990F3A
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 21:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15601C225DD
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 19:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEB61E7C32;
	Fri,  4 Oct 2024 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="egOAVtTQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741401E7C10
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067315; cv=none; b=JRPF+40gk9XBw3lPNHocsf/fGTNk3RNIO4jp1olhWEWCbZPoCUik9eWCLnVsediIzVqx2XiOO/B8yDjdr8a44k1hqau50Xs+wFlB9iBo/At8lU4IlUlDK2SUgW4TJzfGPpvczRw6kz/m76IY04YnshjT1+Uml+0W//PCzupFlok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067315; c=relaxed/simple;
	bh=4TK0He8dwCtdTdLxI3+U12GZbKcleL278kKQAMrdJKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqAkr08zHIxILdnnUh5F8riMnOG8g8lUeo9e6Bx0RqNNWvHMM3enbVrkEXsXNmx+3+r6ghsgUNKhqzIjO0uFnlbXwgwt6DXs0C74EhgpmCSWEKmYIs1dGpbwdqEvBxNOJCQDVQYOeOQICGiCz7zHcIaaU1j6/ljE3Smzjo9s7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=egOAVtTQ; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a34517248dso9401585ab.2
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2024 11:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728067311; x=1728672111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwwzeEiJ51opqJhPS5gdsXb8wf45NCbyQcZ446sEan4=;
        b=egOAVtTQtrQOlbXthuXG/9kL4F0hEEOD6k9IfhFzUFNiTzzrffCe79KS45OzJOpWhG
         Fjns4A3jtKGTS3fRTVdEUYG7t8zfVpj70rVpHy5OtEYkWdmPdBR0nyBW88d1Foj3wByA
         Cjw8kt/S112/uGELF2Pnu+4dkX6GfiZWUgNGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728067311; x=1728672111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwwzeEiJ51opqJhPS5gdsXb8wf45NCbyQcZ446sEan4=;
        b=Set1XHYvScK0pj+8qbUz7yP6Om1Fzfr5qkYXvM0Z9Q/OCnErP49e2dHNtFGBgaHFvy
         npj0EEWqVDRLd2k1SjknmGhzL8yf7FdA0evydiv96wYWGCuXWVK29xpCdkhlvmVlck1Y
         RslgEG9jIaUJy8ooEr3BYzHL3S8gVjkThZsfWBqvdC7AL/wnYsrnrB2lrHnACax/xDFw
         ALAJPIy7odKk6kQhwAUHGjDElHl7XorRHQKmHmCtokqVckkIl2IMLGflWGlNP+gMITNt
         xGxi+qu5ege3+MUaRHuRKfhfiSZJf2TD0pRCSd1yaYz7bCIpCuxTOb8Wn8h04ki6PhED
         pHJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFMW4XILMhlgVx/vjaZGY7Ub5Zd85ukXSUvEZ/cpltPviEeF3Q1xPfBnJbpdY/oF9ORrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAW80IJFOGlLM8yY2sdVo3mmTJptVdMY18vk8cl+tyG5qdNrVZ
	Iu1pjW8UiPzOBXAk4x2w8057btnQM/ixIt8xmh9EJ60awqWGmKZMO/g3duPeZQ8=
X-Google-Smtp-Source: AGHT+IH6mnLmqEkMpwU9kQVlZPZu54bW9Eh6OfVXFm/vCfvFb75bqD/YaW5wJrThyLGG3oGPjMxzCQ==
X-Received: by 2002:a05:6e02:190e:b0:3a0:8eb3:5160 with SMTP id e9e14a558f8ab-3a3759a102dmr37743035ab.11.1728067311627;
        Fri, 04 Oct 2024 11:41:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6eb868e3sm84295173.75.2024.10.04.11.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 11:41:51 -0700 (PDT)
Message-ID: <67224962-4ea4-4d78-923f-2c520488a090@linuxfoundation.org>
Date: Fri, 4 Oct 2024 12:41:50 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: sched_ext: Add sched_ext as proper selftest
 target
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 Anders Roxell <anders.roxell@linaro.org>
References: <20241004094247.795385-1-bjorn@kernel.org>
 <60dd0240-8e45-4958-acf2-7eeee917785b@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <60dd0240-8e45-4958-acf2-7eeee917785b@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/4/24 11:46, Shuah Khan wrote:
> On 10/4/24 03:42, Björn Töpel wrote:
>> From: Björn Töpel <bjorn@rivosinc.com>
>>
>> The sched_ext selftests is missing proper cross-compilation support, a
>> proper target entry, and out-of-tree build support.
>>
>> When building the kselftest suite, e.g.:
>>
>>    make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- \
>>      SKIP_TARGETS="" O=/output/foo -C tools/testing/selftests install
>>
>> The expectation is that the sched_ext is included, cross-built, and
>> placed into /output/foo.
>>
>> Add CROSS_COMPILE, OUTPUT, and TARGETS support to the sched_ext
>> selftest.
>>
>> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
>> ---
>>   tools/testing/selftests/Makefile           |  1 +
>>   tools/testing/selftests/sched_ext/Makefile | 59 +++++++++++++++-------
>>   2 files changed, 41 insertions(+), 19 deletions(-)
>>
> 
> Thank you for the find. It appears *sched* is also missing
> from the default TARGETS in selftests/Makefile
> 
> This change looks good to me.
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Tejun, Do let me know if you like me to take this through kselftest tree.
> 

Please don't take this patch at the moment.

Adding Mark.

After catching up with my Inbox - this is a no for me. This test
depends on bpf and will fail in CIs that don't have the support.

We are discussing the issue here in this thread.

https://patchwork.kernel.org/project/linux-kselftest/patch/20241004095348.797020-1-bjorn@kernel.org/

thanks,
-- Shuah




