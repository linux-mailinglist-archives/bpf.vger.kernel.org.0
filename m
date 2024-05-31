Return-Path: <bpf+bounces-31023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4148D624D
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 15:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66201F270FA
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 13:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8871581FB;
	Fri, 31 May 2024 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBVOefn0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D203D158A1D
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160474; cv=none; b=e4xKUClxhxCh+qsnZCt3TR2NlOokCtnSS92iAPwU0rogQA28AFXOqgc67TNA85x4lWA0FbDzgJ7h4rApcgdPDY7pjnC9moXpPCtnQaKwC/iZkE+pAzwV1JOpWXOqf0M/pxYeiJMcDpO+DWZBFkVEgnuqJ6hkZULbjIs8kPGgpTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160474; c=relaxed/simple;
	bh=VAAXDEDYBPQ/MeAs5eJw1t8zdZK9YnAZg77cRVOX414=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFQLoni9BGfMUlzzOUA762juJeiyxuCUtm3YHHkD2DJiy5+1lGOYT0OLsqdmnuxFYaoWupsVQd7Giy0Q97OXpKexVQCt9dKh/vTwPGNBd0UoDvka7QqW7yIRHq0G4HRtGLuA4ssaW73s9fw6n4hzVPYtTX/ZgHVLzbDwyHgjVDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBVOefn0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f6342c5faaso6666175ad.2
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 06:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717160472; x=1717765272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f05WHVnGxBtGQVtrJ9BF8vSFxzq0Ph/XQHusiG68p9M=;
        b=iBVOefn01oD7CaCYx4r9FM5O1tozxopHT9aFfSOjxCvrJWXqXZiZBdikchM8ii8QS3
         QBJ0vVfXbabAiOMG0pR17cicoKF4wNVetDnbZnVeZCYja52cQsfWDbp0NAaPD1deTcrg
         lUFK1HQUr4+eIdq197HkZNflyPygvHFO1cbs/I7aCKgbveBX4xVQw/XSxrmuMMvXcgmu
         Er8Gt6WzuaKJy572cGbWtQenBTMP1l/yBGxjoCaAaAg4pVylDiZ0CRBEZUSZyHx24Ypu
         lVSwqfvLccFvn2NZpQP7EUgwFKtMVNBK28NZpwawL/rW53W8fMAbhWxwaTYYWt8gbfES
         JEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717160472; x=1717765272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f05WHVnGxBtGQVtrJ9BF8vSFxzq0Ph/XQHusiG68p9M=;
        b=ICqN62iKQa6V76Qjs36YvsqhMHtZgoPsw+qaV3TWH7heEX2d7sPl+EMzvlurmjsqzr
         Mcm374Se4iH2K0oPXLTzmBqIOQdqOE4M3bktuNmPvTZ+8rVb0NqSXBv0W/F0nP36RDbW
         s2jb1537tpTJSSHXFX/8YpAPlwoBAmzZD50B7FvvYfVmHIJT5pquS/+7Ac5CSVXIaOg6
         14X+S/qtcrnsAk9vxKPC3kkaVRF/yHEZz0qZ9SXPOyWw5UNu7typ3npAha3+Gml6kBi6
         Z8kj4tVoclIGtFx+SmZ9Obvqw0nu+v33bf3t2LEHhkGTjlOa3lfCQe742OogeEBWiStt
         KdCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ4ssXhBBwePBkNcTW2v3oXY7VXoTdOKO6LwgHYDEfMWQdspOIJywK7rFvsy2IOo3kltCDpHjgsh5pMrbIQ6BCDM6k
X-Gm-Message-State: AOJu0Yx56d8M5BOt2BR59o1XsCVt0V1W5a50op8u7K8yceu3V71jpmpW
	YXq07S0joJ5t5OsIi4mGkMR4RXLwBtDAN9Y3oOtScyVJluvLTaRV
X-Google-Smtp-Source: AGHT+IGuhqTa0lPUTTxarErgnh1+cgWBlkYL/EOAYUX8GkIrGtBOU/oCkPDqwL3y2WZCDnte1dz2NA==
X-Received: by 2002:a17:902:d4c9:b0:1ea:201:5843 with SMTP id d9443c01a7336-1f636fd95e5mr20456075ad.6.1717160471720;
        Fri, 31 May 2024 06:01:11 -0700 (PDT)
Received: from ?IPV6:240d:1a:2e0:8a00:2ef0:15d5:775:9d93? ([240d:1a:2e0:8a00:2ef0:15d5:775:9d93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632338adasm15860965ad.16.2024.05.31.06.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 06:01:11 -0700 (PDT)
Message-ID: <576c2804-a1a3-4499-8ede-17ea93d3e7d4@gmail.com>
Date: Fri, 31 May 2024 22:01:06 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Query only cgroup-related attach types
To: Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
References: <20240529131028.41200-1-tadakentaso@gmail.com>
 <ce5befac-f227-4d2a-bf4b-14e8c7d49052@kernel.org>
Content-Language: en-US
From: Kenta Tada <tadakentaso@gmail.com>
In-Reply-To: <ce5befac-f227-4d2a-bf4b-14e8c7d49052@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/05/30 5:22, Quentin Monnet wrote:
> On 29/05/2024 14:10, Kenta Tada wrote:
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
>> +	[BPF_CGROUP_INET_INGRESS] = true,
>> +	[BPF_CGROUP_INET_EGRESS] = true,
>> +	[BPF_CGROUP_INET_SOCK_CREATE] = true,
>> +	[BPF_CGROUP_INET_SOCK_RELEASE] = true,
>> +	[BPF_CGROUP_INET4_BIND] = true,
>> +	[BPF_CGROUP_INET6_BIND] = true,
>> +	[BPF_CGROUP_INET4_POST_BIND] = true,
>> +	[BPF_CGROUP_INET6_POST_BIND] = true,
>> +	[BPF_CGROUP_INET4_CONNECT] = true,
>> +	[BPF_CGROUP_INET6_CONNECT] = true,
>> +	[BPF_CGROUP_UNIX_CONNECT] = true,
>> +	[BPF_CGROUP_INET4_GETPEERNAME] = true,
>> +	[BPF_CGROUP_INET6_GETPEERNAME] = true,
>> +	[BPF_CGROUP_UNIX_GETPEERNAME] = true,
>> +	[BPF_CGROUP_INET4_GETSOCKNAME] = true,
>> +	[BPF_CGROUP_INET6_GETSOCKNAME] = true,
>> +	[BPF_CGROUP_UNIX_GETSOCKNAME] = true,
>> +	[BPF_CGROUP_UDP4_SENDMSG] = true,
>> +	[BPF_CGROUP_UDP6_SENDMSG] = true,
>> +	[BPF_CGROUP_UNIX_SENDMSG] = true,
>> +	[BPF_CGROUP_UDP4_RECVMSG] = true,
>> +	[BPF_CGROUP_UDP6_RECVMSG] = true,
>> +	[BPF_CGROUP_UNIX_RECVMSG] = true,
>> +	[BPF_CGROUP_SOCK_OPS] = true,
>> +	[BPF_CGROUP_DEVICE] = true,
>> +	[BPF_CGROUP_SYSCTL] = true,
>> +	[BPF_CGROUP_GETSOCKOPT] = true,
>> +	[BPF_CGROUP_SETSOCKOPT] = true,
>> +	[BPF_LSM_CGROUP] = true,
>> +	[__MAX_BPF_ATTACH_TYPE] = false,
>> +};
> 
> 
> Thanks for this!
> 
> I can't say I'm glad to see another version of the list of
> cgroup-related attach types (in addition to HELP_SPEC_ATTACH_TYPES and
> to the manual page). But the alternative would be to explicitly skip
> BPF_NETKIT_PRIMARY, which is not great, either. Too bad we don't have a
> way to check whether the type is cgroup-related in libbpf or from the
> bpf.h headers; but I don't think there's much interest to add it there,
> so we'll probably have the array. We should account for it in
> tools/testing/selftests/bpf/test_bpftool_synctypes.py, but I can do this
> as a follow-up if you don't feel like messing up with the Python script.

I think some bpf management tools require how to get cgroup-related attach types.
So I'm interested in adding the new API to check whether the type is cgroup-related in libbpf.

Thank you for the information about test_bpftool_synctypes.py.
BTW, I'm getting some syntax warnings when I use test_bpftool_synctypes.py in Python 3.12.
Python 3.12 changes the behavior of incorrect escape sequences.
To try test_bpftool_synctypes, I add r to the head and fix it in my local environment.

> 
> 
>> +
>>  #define HELP_SPEC_ATTACH_FLAGS						\
>>  	"ATTACH_FLAGS := { multi | override }"
>>  
>> @@ -187,14 +220,16 @@ static int cgroup_has_attached_progs(int cgroup_fd)
>>  	bool no_prog = true;
>>  
>>  	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
>> -		int count = count_attached_bpf_progs(cgroup_fd, type);
>> +		if (cgroup_attach_types[type]) {
> 
> 
> Please change here:
> 
>                 int count;
> 
>                 if (!cgroup_attach_types[type])
>                         continue;
> 
> And no need to further indent the rest of the block.
> 
> 
>> +			int count = count_attached_bpf_progs(cgroup_fd, type);
>>  
>> -		if (count < 0 && errno != EINVAL)
>> -			return -1;
>> +			if (count < 0 && errno != EINVAL)
>> +				return -1;
>>  
>> -		if (count > 0) {
>> -			no_prog = false;
>> -			break;
>> +			if (count > 0) {
>> +				no_prog = false;
>> +				break;
>> +			}
>>  		}
>>  	}
>>  
> 


