Return-Path: <bpf+bounces-59498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064D7ACC623
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 14:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FA13A361D
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 12:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934482B2CF;
	Tue,  3 Jun 2025 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rjf9dCmd"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1664A146A66
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748952374; cv=none; b=DD4wh/xvdbpd25aJnvpx98nM2M8Iqrsk2wsP459J1b7zAvGd3++4ZT/KGRsuFpZku+wZE4Y3y7voWnv24MncNlWo9EjODza7GKohoWEr+OSpdCHqMlBRq3B5mxGDCxNcZQIULNeU65mtuI1PuaHRGTKeMxdeg0xFU66Dk0XvRVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748952374; c=relaxed/simple;
	bh=fPmKHi75xwI/I4zLEnhov/ZVHLXU+TfLkgaePipJgwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mg63FwLyvQPkQtWrlj0UdqFh1kmRWD8t54d3lHFJBOAgXNMxKSFe/fvveZQQVS2ljhn4NapJq77HwYuB8SPZLFwcEyYWpTJF9OcquuOSbqN9gxfkOlb93MuO6N8F4R72p6mIOWVfUqsIvEACECOIrXUbTl2FWfCenReCKHDPNPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rjf9dCmd; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2f41a74e-06a6-4dc3-806b-a88783d26c8f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748952359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOTHkJYnIu7YqcktCvF/rulIgNRIgccYCV1pgoiilTw=;
	b=rjf9dCmd/OIdOpetURczVXrOVdxR8NdeLpzrBFv14occaGV0KjibZpFG4s2D2+m3pc/zzA
	ljirg6ZNcFpNo8wbEaTvrODKzEvJhrXBFxRtnoyhh5dQmT7c1Fc8Mqu8BmklgdadNRCXAa
	q2N0tHQM/Ltt2e5V7upSMEYxYuwhTuY=
Date: Tue, 3 Jun 2025 20:05:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/3] bpftool: Display cookie for raw_tp link
 probe
To: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250603022610.3005963-1-chen.dylane@linux.dev>
 <20250603022610.3005963-3-chen.dylane@linux.dev>
 <c3b326ea-8d79-47c1-82b7-a9f2f46ab0c3@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <c3b326ea-8d79-47c1-82b7-a9f2f46ab0c3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/3 17:36, Quentin Monnet 写道:
> On 03/06/2025 03:26, Tao Chen wrote:
>> Display cookie for raw_tp link probe, in plain mode:
>>
>>   #bpftool link
>>
>> 22: raw_tracepoint  prog 14
>>          tp 'sys_enter'  cookie 23925373020405760
>>          pids test_progs(176)
>>
>> And in json mode:
>>
>>   #bpftool link -j | jq
>>
>> [
>>    {
>>      "id": 47,
>>      "type": "raw_tracepoint",
>>      "prog_id": 79,
>>      "tp_name": "sys_enter",
>>      "cookie": 23925373020405760,
>>      "pids": [
>>        {
>>          "pid": 274,
>>          "comm": "test_progs"
>>        }
>>      ]
>>    }
>> ]
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   tools/bpf/bpftool/link.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
>> index 52fd2c9fac..bd37f364be 100644
>> --- a/tools/bpf/bpftool/link.c
>> +++ b/tools/bpf/bpftool/link.c
>> @@ -484,6 +484,7 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
>>   	case BPF_LINK_TYPE_RAW_TRACEPOINT:
>>   		jsonw_string_field(json_wtr, "tp_name",
>>   				   u64_to_ptr(info->raw_tracepoint.tp_name));
>> +		jsonw_lluint_field(json_wtr, "cookie", info->raw_tracepoint.cookie);
>>   		break;
>>   	case BPF_LINK_TYPE_TRACING:
>>   		err = get_prog_info(info->prog_id, &prog_info);
>> @@ -876,6 +877,8 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
>>   	case BPF_LINK_TYPE_RAW_TRACEPOINT:
>>   		printf("\n\ttp '%s'  ",
> 
> 
> Nit: See how we use a double space at the end of the string here, to
> separate the different fields in the plain output...
> 
> 
>>   		       (const char *)u64_to_ptr(info->raw_tracepoint.tp_name));
>> +		if (info->raw_tracepoint.cookie)
>> +			printf("cookie %llu ", info->raw_tracepoint.cookie);
> 
> 
> ... Please use a double space here in a similar way, at the end of your
> "cookie %llu  " format string.
> 

Will fix it in v3, thanks.

> Looks good otherwise. Thanks,
> Quentin


-- 
Best Regards
Tao Chen

