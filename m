Return-Path: <bpf+bounces-42081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C980599F508
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 20:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DEF1F23272
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 18:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5EF2216AF;
	Tue, 15 Oct 2024 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AnU8ncF0"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5A420822B
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016220; cv=none; b=CQJuvituZArON6GkkadaHmkHMTRLGvyEAnSi0U7Vy2pzdEagCr1/iGK5vDrPxaXXL5XmY+gC9KyPUk6E7J5zUwguWhF8TxRqHulwTzRl8eph+y1BXHDQElRiyS1jc7IjEfl4Otac6nX8DBfr4KadJbyvvNlsprX/qCkXozw4tl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016220; c=relaxed/simple;
	bh=tvWhqVZ+azkqS/p2nSYvXgUHuwmTr1/fYa6HINYnGCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWRfCWFmteb2569vHkbxn0PLRbqUX93JfP4wzBnh25YS5UbexTWW8jOnWPryOfvDIfAohnK4U29OMO7p1Nf1sUtlUZ/IlHO/0u7aBCmdYrFEI6ICHc9eHl2dVQf3VYJlD6kiEf+NsjSI2w7nPccv6OL8QhtXPSbpV0yc5Zcix58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AnU8ncF0; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dd4be9f4-71e3-4d71-bd71-1fda2c9572b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729016215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AM9YGLLMfMM3L05gwH2rP2Z6pyEbGrpsO5vilHNCUu0=;
	b=AnU8ncF0rkD1kJhHH+8taI6iKkayCtzo36kP/9QPUbO2+uRQ0xDeDTknluj5HpuAUl/k50
	1M5EiQrh+Cb7+g5DFWk9vaah9YL/0rADE4j/ZZniGz/DASDjD42NbA/N8OPrnBrjZ1Thj6
	oOaDo1Q3xpWCWJYSAUq+va262NUQP8I=
Date: Tue, 15 Oct 2024 11:16:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpftool: optimize if statement code
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241015110944.6975-1-liujing@cmss.chinamobile.com>
 <fe9261d8-1e1d-4060-9a7e-1902d75cff7a@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <fe9261d8-1e1d-4060-9a7e-1902d75cff7a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/15/24 5:11 AM, Quentin Monnet wrote:
> 2024-10-15 19:09 UTC+0800 ~ Liu Jing <liujing@cmss.chinamobile.com>
>> Since both conditions are used to check whether len is valid, we can combine 
>> the two conditions into a single if statement
>> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
>> ---
>>   tools/bpf/bpftool/feature.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
>> index 4dbc4fcdf473..0121e0fd6949 100644
>> --- a/tools/bpf/bpftool/feature.c
>> +++ b/tools/bpf/bpftool/feature.c
>> @@ -158,10 +158,9 @@ static int get_vendor_id(int ifindex)
>>       len = read(fd, buf, sizeof(buf));
>>       close(fd);
>> -    if (len < 0)
>> -        return -1;
>> -    if (len >= (ssize_t)sizeof(buf))
>> +    if ((len < 0) || (len >= (ssize_t)sizeof(buf)))
>>           return -1;
>> +
>>       buf[len] = '\0';
>>       return strtol(buf, NULL, 0);
> 
> 
> Thanks. I'm not strictly opposed to the change, but it doesn't bring much value 
> in my opinion. I don't think this will "optimize" the statement beyond what the 
> compiler does already.

+1

The current code is good as is.

pw-bot: cr


