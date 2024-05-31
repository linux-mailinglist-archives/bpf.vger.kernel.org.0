Return-Path: <bpf+bounces-31024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9168D6253
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 15:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E0C1F26040
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 13:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1041586CB;
	Fri, 31 May 2024 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRZCRdMn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D142381AD
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160643; cv=none; b=CybnIbKSoO7I+uTiMgFtduGs3AFAt7TcI+tgIipZzY5EW1O9Pv2bvQSH+KhjpQAnlO6gSg8RGmEJN2MXCvap/z4ciW1wsuxQ4t5Dp+Csg0UBgviA98NwM0NSLPsNPGpMlwtfZMQUKyETdawtI2QL/sjaZEEf1957OQY9AsDY+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160643; c=relaxed/simple;
	bh=4d4CAcsTlKEAUREN6eZFifVvV4Bx4+yNhu0oD+ljosQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7WPM7LUCe2CnN8fd0sjxhPbD2SNsOe91FP1Cm5CishG7NmIJQReSY6RZQrxXg31fqzC121mOL5v1BhwGY7sBhXDjD3OHlZAeETQwGhkCKHXCyT85fbUEkKZyKC3dVBRkIm4YM4K6n5HfyxEuvFKzbmd+fr5zE3qKm2ZOc1hXHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRZCRdMn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f480624d10so16634285ad.1
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 06:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717160641; x=1717765441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iK6/CGTOXtM6O+kwwqjksz1KLhq9Bh7jF5Fod6iRyH0=;
        b=FRZCRdMn0Q33kAr1VN/NoeEKl0+ZpiHUeEO6Wwp1NRkegJgs1yP00bqGeNewzSgq3D
         rJIv+WGEkgS4NvP65sXyCZg7t9RPKOgmDDct4XtfhFZw7V04cupKPXX1FVqnOG7+Dv78
         9ViACD/8RU3W0PSWPoKHw4LgcgtfLmAX+h/QQBG2Yk/6RcmDs3PzBERBlg1dnJubO0aQ
         NaojhSiE+aAD/mKAaQ02GDwD8ZXnjCkm+n5pay7OCAx/SUPv9emrvk/uDikiWYnx9BGu
         gSzoklD+MDyq6wteDkGLfULO51OQ4lNDeHTuLdULZ3RpFm9SJlcEfsXmetsPqmtLPROB
         8l/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717160641; x=1717765441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iK6/CGTOXtM6O+kwwqjksz1KLhq9Bh7jF5Fod6iRyH0=;
        b=SU8T/61GcN9VkPyCoe2Aus1GJaR8kmVH9gs0/cqarjhsQhy/DEr5xUqqjIstRCXmJc
         y6s8O7mV+xsGsAqSvK8zki0SCraVdrC7u64wjKx2SwJEkggJbCfmuDhGGBPaJLgi3PqX
         new1Y1WmrpzNq0Ja3HD1Rpi0pxUCox4Z6mRpF1EhIFnR0hmIFEHW74qCJTMxvmd3E2nS
         QA1FKTlmn+5VRs4EMxH3exwTC+RPi81KZqOuXhdS/p4qPXFybGRRu7ltAe5km9ED4bih
         kP/cYOwLQ5Jy7VWJm/OsfmfCEhTJvuePD0AUpurm9PzrQnw9WrUCtd/HAq/L855A6my/
         Or2A==
X-Gm-Message-State: AOJu0Ywd2gaKRc91cv2jjIkjOx/g8ColhXd8YIzyemKqo1BhPGiVEkRq
	f7dd76bJmXs5JTbVA1I0HeRtAXp+yn/PVgzWElZ6AeenqjTBLq4s
X-Google-Smtp-Source: AGHT+IGMPd2T1LnjNTmN8f+VJIA5Af5oyzEBZc1WOqtFPdH6UWEoRKb2xPES+b7V/10v0x8goJ7ulA==
X-Received: by 2002:a17:902:bb16:b0:1f6:3b03:6fa1 with SMTP id d9443c01a7336-1f63b0376c1mr9681175ad.56.1717160640822;
        Fri, 31 May 2024 06:04:00 -0700 (PDT)
Received: from ?IPV6:240d:1a:2e0:8a00:2ef0:15d5:775:9d93? ([240d:1a:2e0:8a00:2ef0:15d5:775:9d93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63232dcf1sm16022885ad.53.2024.05.31.06.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 06:04:00 -0700 (PDT)
Message-ID: <0cec01b4-1ae5-40ea-bccf-f29c41e2cf74@gmail.com>
Date: Fri, 31 May 2024 22:03:56 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Query only cgroup-related attach types
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, qmo@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org
References: <20240529131028.41200-1-tadakentaso@gmail.com>
 <CAEf4Bzbt4FMqAOioJYZpuYDrtiFiT+STMqs_Z8ZhTNLD3AZxzg@mail.gmail.com>
Content-Language: en-US
From: Kenta Tada <tadakentaso@gmail.com>
In-Reply-To: <CAEf4Bzbt4FMqAOioJYZpuYDrtiFiT+STMqs_Z8ZhTNLD3AZxzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/05/31 6:20, Andrii Nakryiko wrote:
> On Wed, May 29, 2024 at 6:10 AM Kenta Tada <tadakentaso@gmail.com> wrote:
>>
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
>> Signed-off-by: Kenta Tada <tadakentaso@gmail.com>
>> ---
>>  tools/bpf/bpftool/cgroup.c | 47 +++++++++++++++++++++++++++++++++-----
>>  1 file changed, 41 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
>> index af6898c0f388..bb2703aa4756 100644
>> --- a/tools/bpf/bpftool/cgroup.c
>> +++ b/tools/bpf/bpftool/cgroup.c
>> @@ -19,6 +19,39 @@
>>
>>  #include "main.h"
>>
>> +static const bool cgroup_attach_types[] = {
>> +       [BPF_CGROUP_INET_INGRESS] = true,
>> +       [BPF_CGROUP_INET_EGRESS] = true,
>> +       [BPF_CGROUP_INET_SOCK_CREATE] = true,
>> +       [BPF_CGROUP_INET_SOCK_RELEASE] = true,
>> +       [BPF_CGROUP_INET4_BIND] = true,
>> +       [BPF_CGROUP_INET6_BIND] = true,
>> +       [BPF_CGROUP_INET4_POST_BIND] = true,
>> +       [BPF_CGROUP_INET6_POST_BIND] = true,
>> +       [BPF_CGROUP_INET4_CONNECT] = true,
>> +       [BPF_CGROUP_INET6_CONNECT] = true,
>> +       [BPF_CGROUP_UNIX_CONNECT] = true,
>> +       [BPF_CGROUP_INET4_GETPEERNAME] = true,
>> +       [BPF_CGROUP_INET6_GETPEERNAME] = true,
>> +       [BPF_CGROUP_UNIX_GETPEERNAME] = true,
>> +       [BPF_CGROUP_INET4_GETSOCKNAME] = true,
>> +       [BPF_CGROUP_INET6_GETSOCKNAME] = true,
>> +       [BPF_CGROUP_UNIX_GETSOCKNAME] = true,
>> +       [BPF_CGROUP_UDP4_SENDMSG] = true,
>> +       [BPF_CGROUP_UDP6_SENDMSG] = true,
>> +       [BPF_CGROUP_UNIX_SENDMSG] = true,
>> +       [BPF_CGROUP_UDP4_RECVMSG] = true,
>> +       [BPF_CGROUP_UDP6_RECVMSG] = true,
>> +       [BPF_CGROUP_UNIX_RECVMSG] = true,
>> +       [BPF_CGROUP_SOCK_OPS] = true,
>> +       [BPF_CGROUP_DEVICE] = true,
>> +       [BPF_CGROUP_SYSCTL] = true,
>> +       [BPF_CGROUP_GETSOCKOPT] = true,
>> +       [BPF_CGROUP_SETSOCKOPT] = true,
>> +       [BPF_LSM_CGROUP] = true,
>> +       [__MAX_BPF_ATTACH_TYPE] = false,
>> +};
>> +
>>  #define HELP_SPEC_ATTACH_FLAGS                                         \
>>         "ATTACH_FLAGS := { multi | override }"
>>
>> @@ -187,14 +220,16 @@ static int cgroup_has_attached_progs(int cgroup_fd)
>>         bool no_prog = true;
>>
>>         for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
> 
> instead of iterating over all possible attach types and then checking
> if attach type is cgroup-related, why not have an array of just cgroup
> attach types and iterate it directly?
> 
> pw-bot: cr

The size of the bool array is smaller than saving each attachment type as the value in an integer array.
But either is fine.

I think the problem is that we don't increase the list of cgroup attach types in multiple files.
Do you have any plans to add the new API to check whether the attach type is cgroup-related in libbpf?
I want to call the new API in this patch.

> 
> 
>> -               int count = count_attached_bpf_progs(cgroup_fd, type);
>> +               if (cgroup_attach_types[type]) {
>> +                       int count = count_attached_bpf_progs(cgroup_fd, type);
>>
>> -               if (count < 0 && errno != EINVAL)
>> -                       return -1;
>> +                       if (count < 0 && errno != EINVAL)
>> +                               return -1;
>>
>> -               if (count > 0) {
>> -                       no_prog = false;
>> -                       break;
>> +                       if (count > 0) {
>> +                               no_prog = false;
>> +                               break;
>> +                       }
>>                 }
>>         }
>>
>> --
>> 2.43.0
>>


