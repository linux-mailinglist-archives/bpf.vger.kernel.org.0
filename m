Return-Path: <bpf+bounces-31576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9177390014E
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 12:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B8328432F
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 10:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA3616F291;
	Fri,  7 Jun 2024 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON5KXweg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F65D78C96
	for <bpf@vger.kernel.org>; Fri,  7 Jun 2024 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757832; cv=none; b=IpQxZneBmIUGqS4mDLqGnJPbqQ6RJ/DWC2sYtzwJmz5f9jmlhjpbO7/19lw0h4QX6rDTH95QRO2BksoHVTgnsZoPK+61u/DfIzdpzUd2hyXl55SwjxbjL1fdkEo/19QEr6NpuNv7CHmfwlSM3LjDvuz80IGj5j0DuD3rVUkssgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757832; c=relaxed/simple;
	bh=gneIqlv/s+RU0pDZi8G3iWD1DG0DnrREw0Xe6VBMFJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcDe4081HB0aYFcM88I6ASrhvTkpfaqVBzQFLj88n52DJRkkipcUQS9fFcp0G1l6lQb3CT/SSYJfCrhlepaOX97dOSiooKBRqVIoyRyGmVHPHIg7koNmUUA6I3TkDJy/osXvIGDG48hATb2GXV/Zq6Q0iQZpr0YeECmnqZ2YMyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ON5KXweg; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f93e7ebaf6so1017192a34.2
        for <bpf@vger.kernel.org>; Fri, 07 Jun 2024 03:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717757830; x=1718362630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=37qc5JjI5Bvb7lpBS4ch/INTf0kavlSRxNHChQ05DAU=;
        b=ON5KXwegrSro3YkYDUmle9+Qiym1s5N8G053lhEztUaULq9zqh6jAdWimj4xALqh0u
         I1wi6cLNDCefZsQ0s1n+QJxlmlxQ9DgeQnvfvcZ4o+j0N9a1AIP/egCczI2dRJu0usgO
         rPbS3lrK4CvzWp+VhHjWza7uE4ghb0Ugi6vnkg9CaaRTVCgpQ04BVyWh7mH7hPJOnEIu
         UsEuJ4PYm8DyRmrddU83KbUvVDIdirzZ843ixILfveqeJz+b/frMKJNNEo7xigl2aTeN
         mhnvSJbEc3NAVhrTSWBnq0g02iAogaeNmGiYsMHrRLRQzRg+Gw+ieA/WdYNLNLkzYd8Y
         HDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717757830; x=1718362630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37qc5JjI5Bvb7lpBS4ch/INTf0kavlSRxNHChQ05DAU=;
        b=fVwQkYNaE/rBxMp4+ZnEMt+5PyJGePdFxWCeA3Sng2Ft6wiTBk7F4AG0i+jXQhoQeG
         WvnGrrCxIbW168McKtmekMuxNNmY+ksYx2wyxrxf7i3qvOljZ3MXyHSTTB/+WHBMVa2J
         ShZv6IOAHcu9VeqrDDpLf0xPcieZfM6DmrYfvdzbgydh8QeYroeq9JjgylRZKSU5Fiby
         334YDoEkQG6erxAHZ0Vm1im46bxnfR6iUHC1GsyeyRspnvMFqeeByuyyCzzagqW+keAe
         XRvWCzbzGWNWPDUtqI8DHQh79/Uikt8sxamFRXOy5pMBR2RCn6mMSjKedukcTSlv1psd
         zf8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKcLO2HYODjkuXrK9tRxBOZwuOvjmFUsNQbLb4FGW+SjOjEJ0Qa58hb7ebOE2F7qeGOLx3R0dsJODx5ZkaaEG/Vo48
X-Gm-Message-State: AOJu0YwgkdUnX4dPlAn9HIRnP/UwJUuKo0IqL9EDQkc6Bu0kp8pzxwyu
	Vo1hXFFTc7UrwzPL/Ev3Xo1EQTmX1WP15V38elHZEKACyUNH3Nid
X-Google-Smtp-Source: AGHT+IGnTXgwalIOtcTvqzt5Qgf3z0dcUXbmk7wpq5EdcJLhaGU5OewX/Bt+htUvpnm/S4vEvmL9AA==
X-Received: by 2002:a05:6359:1b81:b0:19f:2d30:8e08 with SMTP id e5c5f4694b2df-19f2d309b89mr61194555d.27.1717757829995;
        Fri, 07 Jun 2024 03:57:09 -0700 (PDT)
Received: from ?IPV6:240d:1a:2e0:8a00:e49b:574:d394:8195? ([240d:1a:2e0:8a00:e49b:574:d394:8195])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de28f37482sm2388422a12.94.2024.06.07.03.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 03:57:09 -0700 (PDT)
Message-ID: <aa7994d8-b0ba-4404-b89e-44044c333518@gmail.com>
Date: Fri, 7 Jun 2024 19:57:05 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bpftool: Query only cgroup-related attach types
To: Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
References: <20240607102148.151272-1-tadakentaso@gmail.com>
 <e7ca0725-9cf7-49e3-b362-93430e3c649f@kernel.org>
Content-Language: en-US
From: Kenta Tada <tadakentaso@gmail.com>
In-Reply-To: <e7ca0725-9cf7-49e3-b362-93430e3c649f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/07 19:50, Quentin Monnet wrote:
> 2024-06-07 11:21 UTC+0100 ~ Kenta Tada <tadakentaso@gmail.com>
>> When CONFIG_NETKIT=y,
>> bpftool-cgroup shows error even if the cgroup's path is correct:
>>
>> $ bpftool cgroup tree /sys/fs/cgroup
>> CgroupPath
>> ID       AttachType      AttachFlags     Name
>> Error: can't query bpf programs attached to /sys/fs/cgroup: No such device or address
>>
>> From strace and kernel tracing, I found netkit returned ENXIO and this command failed.
>> I think this AttachType(BPF_NETKIT_PRIMARY) is not relevant to cgroup.
>>
>> bpftool-cgroup should query just only cgroup-related attach types.
>>
>> v1->v2:
>>   - used an array of cgroup attach types
>>
>> Signed-off-by: Kenta Tada <tadakentaso@gmail.com>
>> ---
>>  tools/bpf/bpftool/cgroup.c | 38 +++++++++++++++++++++++++++++++++++---
>>  1 file changed, 35 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
>> index af6898c0f388..afab728468bf 100644
>> --- a/tools/bpf/bpftool/cgroup.c
>> +++ b/tools/bpf/bpftool/cgroup.c
>> @@ -19,6 +19,38 @@
>>  
>>  #include "main.h"
>>  
>> +static const int cgroup_attach_types[] = {
>> +	BPF_CGROUP_INET_INGRESS,
>> +	BPF_CGROUP_INET_EGRESS,
>> +	BPF_CGROUP_INET_SOCK_CREATE,
>> +	BPF_CGROUP_INET_SOCK_RELEASE,
>> +	BPF_CGROUP_INET4_BIND,
>> +	BPF_CGROUP_INET6_BIND,
>> +	BPF_CGROUP_INET4_POST_BIND,
>> +	BPF_CGROUP_INET6_POST_BIND,
>> +	BPF_CGROUP_INET4_CONNECT,
>> +	BPF_CGROUP_INET6_CONNECT,
>> +	BPF_CGROUP_UNIX_CONNECT,
>> +	BPF_CGROUP_INET4_GETPEERNAME,
>> +	BPF_CGROUP_INET6_GETPEERNAME,
>> +	BPF_CGROUP_UNIX_GETPEERNAME,
>> +	BPF_CGROUP_INET4_GETSOCKNAME,
>> +	BPF_CGROUP_INET6_GETSOCKNAME,
>> +	BPF_CGROUP_UNIX_GETSOCKNAME,
>> +	BPF_CGROUP_UDP4_SENDMSG,
>> +	BPF_CGROUP_UDP6_SENDMSG,
>> +	BPF_CGROUP_UNIX_SENDMSG,
>> +	BPF_CGROUP_UDP4_RECVMSG,
>> +	BPF_CGROUP_UDP6_RECVMSG,
>> +	BPF_CGROUP_UNIX_RECVMSG,
>> +	BPF_CGROUP_SOCK_OPS,
>> +	BPF_CGROUP_DEVICE,
>> +	BPF_CGROUP_SYSCTL,
>> +	BPF_CGROUP_GETSOCKOPT,
>> +	BPF_CGROUP_SETSOCKOPT,
>> +	BPF_LSM_CGROUP
>> +};
>> +
>>  #define HELP_SPEC_ATTACH_FLAGS						\
>>  	"ATTACH_FLAGS := { multi | override }"
>>  
>> @@ -183,11 +215,11 @@ static int count_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
>>  
>>  static int cgroup_has_attached_progs(int cgroup_fd)
>>  {
>> -	enum bpf_attach_type type;
>> +	unsigned int i = 0;
>>  	bool no_prog = true;
>>  
>> -	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
>> -		int count = count_attached_bpf_progs(cgroup_fd, type);
>> +	for (i = 0; i < ARRAY_SIZE(cgroup_attach_types); i++) {
> 
> 
> Thanks, it looks better that way.
> 
> 
>> +		int count = count_attached_bpf_progs(cgroup_fd, cgroup_attach_types[i]);
>>  
>>  		if (count < 0 && errno != EINVAL)
> 
> 
> I think the "errno != EINVAL" exception was here to allow iterating over
> unsupported attach types for the queries. Now that we only do supported
> types, we can probably remove it and return if "(count < 0)".

OK.
I'll fix it quickly.
Thanks!

> 
> 
>>  			return -1;
> 


