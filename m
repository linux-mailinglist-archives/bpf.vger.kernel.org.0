Return-Path: <bpf+bounces-56505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB756A994F6
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 18:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 324007A57F5
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 16:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9B4280CD9;
	Wed, 23 Apr 2025 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XqYH8PAR"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A2F45948
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425577; cv=none; b=q9D/wk2HcxbCU4qPINh64h99p2MGaR7PcOkRWOixun8llIeHWM/2Z2U7LfnxFavgep/i+AwSgdyB5QAE9vJqFRpWi2Yb6AuiMwlIQKYSfe0LoXJApa2hGn0dg/7vSpdORfCcDKkRidui2KpyxdpRC6a8i1TeLA5F9HVvRQAlxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425577; c=relaxed/simple;
	bh=rTKVGqTcpcHzYg9VIXbq8Jn8TK8RnJF0NhYPERmSdbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrHZu1cAbKwfGVj9nrS9QQGez736HUlCRxQSYJpL5kHaaGqHFUWfbvjNATr56K8pfXojUOKDb5h2eI1jG2CIo0dxMQ7fXcawRSAZFh2NgfmeQ/3GfrTTIqmWZsXatKnCrOhVzFjB5orh40lhNDddfOUz5M8K93oZMwOj42PmmXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XqYH8PAR; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <62ea70bf-69e8-4bfa-84ca-f56530ebbed3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745425573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6EaVd4uzCBm+InA2v4DBeIfAzSjd2ey57rmT4495uo=;
	b=XqYH8PARUmRPQtm7gNrZPWnpG4Wc3uxqdq45/YvcSer7UNwP7Az3XAmKbuYW1mRK7dpaGR
	SF+VzAv1KV1uu+sLVRIWdnWekrqIaqi+U+G18fVoT+jlz7DL2ZO9pQ5PmeoNMblqdd2rKi
	aQwFZZI7SzndOW/vTJuPLAgrsqIAir4=
Date: Thu, 24 Apr 2025 00:26:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next] libbpf: remove sample_period init in
 perf_buffer
To: Jiri Olsa <olsajiri@gmail.com>, Namhyung Kim <namhyung@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250422091558.2834622-1-chen.dylane@linux.dev>
 <aAedDw7fWAF2ej1f@krava> <aAfok3ha8QQkP8VB@google.com>
 <aAkMbBdzWX_iE1zM@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <aAkMbBdzWX_iE1zM@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/4/23 23:51, Jiri Olsa 写道:
> On Tue, Apr 22, 2025 at 12:05:55PM -0700, Namhyung Kim wrote:
>> Hello,
>>
>> On Tue, Apr 22, 2025 at 03:43:43PM +0200, Jiri Olsa wrote:
>>> On Tue, Apr 22, 2025 at 05:15:58PM +0800, Tao Chen wrote:
>>>> It seems that sample_period no used in perf buffer, actually only
>>>> wakeup_events valid about events aggregation for wakeup. So remove
>>>> it to avoid causing confusion.
>>>
>>> I don't see too much confusion in keeping it, but I think it
>>> should be safe to remove it
>>>
>>> PERF_COUNT_SW_BPF_OUTPUT is "trigered" by bpf_perf_event_output,
>>> AFAICS there's no path checking on sample_period for this event
>>> used in context of perf_buffer__new, Namhyung, thoughts?
>>
>> It seems to be ok to call mmap(2) for non-sampling events.
>>
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Tao Chen,
> could you please resend without rfc tag? plz keeps acks
> 

sure, will resend it, thanks.

> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks,
> jirka
> 
> 
>>
>> Thanks,
>> Namhyung
>>
>>>
>>>>
>>>> Fixes: fb84b8224655 ("libbpf: add perf buffer API")
>>>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>>>> ---
>>>>   tools/lib/bpf/libbpf.c | 1 -
>>>>   1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>>> index 194809da5172..1830e3c011a5 100644
>>>> --- a/tools/lib/bpf/libbpf.c
>>>> +++ b/tools/lib/bpf/libbpf.c
>>>> @@ -13306,7 +13306,6 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
>>>>   	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
>>>>   	attr.type = PERF_TYPE_SOFTWARE;
>>>>   	attr.sample_type = PERF_SAMPLE_RAW;
>>>> -	attr.sample_period = sample_period;
>>>>   	attr.wakeup_events = sample_period;
>>>>   
>>>>   	p.attr = &attr;
>>>> -- 
>>>> 2.43.0
>>>>


-- 
Best Regards
Tao Chen

