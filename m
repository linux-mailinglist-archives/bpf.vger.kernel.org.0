Return-Path: <bpf+bounces-67088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D28B3DF38
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 11:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A4117D6E9
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 09:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FE630EF65;
	Mon,  1 Sep 2025 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gP2FA4PR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C5330DEC4;
	Mon,  1 Sep 2025 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720693; cv=none; b=tTIRdnYWs9PshjxpadjG+c7J53e2GbWWYmFm2Y1FRbNuyj48NII8BCQ40tFhyGkc3nb7BrDIrnrJKA4Jf2haU+l8jJ/flin6ZwH4SB8jG7HfL8Ktc4ZEmBR76I0DQ4gYy15LrPBGZZe4JTgqA0NKaNcxAltKUufmtwcQgnmsSyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720693; c=relaxed/simple;
	bh=uvweM5ey37QsTWQAdiyDuf3UROFBuPL82YmcUdYKnz8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fmcFsBRRuopgwW8g1AwFhF49kJNnGfD5dc9qwRr0tTNbHfI34VNBXqTjUMc5S7/d4ZMr55Nry4KZ7gJ+b+ydmdfIGDsL08K5eYANu3LODKCD2NoPVUl++kHVjCP//KD8KR9K6PTQewX8UVd57C7nGqNwiaUmLYQMqACr55fKRBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gP2FA4PR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BFAC4CEF0;
	Mon,  1 Sep 2025 09:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756720693;
	bh=uvweM5ey37QsTWQAdiyDuf3UROFBuPL82YmcUdYKnz8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=gP2FA4PRHT5fFAIrxTN3DY5JqorBZbdpo6VlChuEtSJfh42HXw5EZWp8Ngms/xaZ7
	 YYg4KRk+3o+NOQVoZH+CxZkkRxA49bI0NIDj0Cm8Dm9F62uBwZHptyG4N9nXh5YIIo
	 EhUUsWeSrOD4UYcihjCf9Z6QJJTVEMG5IERpqSFErnD1Ljv7BHeTmyBm5WRSuUKATO
	 alTRzL+wWx/f6QKNr/0z7SOVPMWCJo54yHyln07mMSUL05yttBoiyrLfp+fbXYBs3J
	 jiBdXkytvDetOWkZ2g+067hLSSrHMhJuUYYL0j8q4oiK0HAgj4UuCDk3MqSzL658Y/
	 75SNHejElV8CQ==
Message-ID: <91a46a61-4a9c-452b-87ae-b8fb45a2e9f2@kernel.org>
Date: Mon, 1 Sep 2025 10:58:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] bpftool: Refactor config parsing and add CET
 symbol matching
From: Quentin Monnet <qmo@kernel.org>
To: chenyuan_fl@163.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Cc: yonghong.song@linux.dev, olsajiri@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, chenyuan@kylinos.cn
References: <20250829061107.23905-1-chenyuan_fl@163.com>
 <b245b389-e057-40d3-8e2a-7cce5c290c63@kernel.org>
Content-Language: en-GB
In-Reply-To: <b245b389-e057-40d3-8e2a-7cce5c290c63@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-09-01 10:32 UTC+0100 ~ Quentin Monnet <qmo@kernel.org>
> 2025-08-29 07:11 UTC+0100 ~ chenyuan_fl@163.com
>> From: Yuan CHen <chenyuan@kylinos.cn>
>>
>> 1. **Refactor kernel config parsing**  
>>    - Moves duplicate config file handling from feature.c to common.c  
>>    - Keeps all existing functionality while enabling code reuse  
>>
>> 2. **Add CET-aware symbol matching**  
>>    - Adjusts kprobe hook detection for x86_64 CET (endbr32/64 prefixes)  
>>    - Matches symbols at both original and CET-adjusted addresses  
>>
>> Changed in PATCH v4:
>> * Refactor repeated code into a function.
>> * Add detection for the x86 architecture.
>>
>> Changed int PATH v5:
>> * Remove detection for the x86 architecture.
>>
>>  Changed in PATCH v6:
>> * Add new helper patch (1/2) to refactor kernel config reading
>> * Use the new read_kernel_config() in CET symbol matching (2/2) to check CONFIG_X86_KERNEL_IBT
>>
>> Changed in PATCH v7:
>> * Display actual kprobe attachment addresses instead of symbol addresses
> 
> Hi Yuan,
> 
> Is there any difference between v7 and v8 of your series? They seem
> identical, from what I can see.


From Yuan's reply (please let's stick to the ML :) )

> The v7 and v8 patches are identical in code changes. The only update
> in v8 is the addition of "Ack-by" tags in commit messages.

OK thanks for confirming! No need to repost just to add the Ack tags
next time, maintainers can pick them up automatically before applying to
their tree.

Thanks,
Quentin

