Return-Path: <bpf+bounces-34869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3033D931E33
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 02:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5CF1F22012
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 00:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471451C01;
	Tue, 16 Jul 2024 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVkKWNFv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2431860
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721091472; cv=none; b=B01/AAZGdZ77a+yG1Bu7ptwZcBSt2GVilAIsSRqJOFt3GXCNqxslb5aA3pubeO48yjfPvHvfF3H6jIhTcu6P5m9XohbGV2ByX6ZLmyRdOIiJ+iGrJnxSPSN8vMT06b2JdNoMsb5cgNGJ+LBnJKZPz0SoRYyRsaSkWRnMAeHplc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721091472; c=relaxed/simple;
	bh=I4mL9Ao/3yFAIGksCb4DcOI7EVi7AseFulnRhgbDnPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSDAMuy224PZvNsSMJsOBNy543ofLhAzxDz0FkQhlMU8Etzr9lYbdr5I5s2GgoU9WOmHqhmOzoBwvxK0VexlluoPpQ0v82pDvtmgYwmEld5mNJQGUmn1mujSt8elCmzk3P3k0IOiV7/4wDvkekaypJjq5sSmVcpMWg09XmMgG1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVkKWNFv; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-65465878c1fso56267497b3.2
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 17:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721091470; x=1721696270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xW2pCScye9pRbQhCrEvhJonroguMyntQisrBj9wxnXg=;
        b=JVkKWNFvcRopnwqmIXp4Gg1bRwgBBReJGgScpH+ADt05Q6Kh1v9i6hjcaGzs/rlpvg
         IIPc7rrcenNzGgXDGSlmWtm1toPWWyVH3gHiR3HF9V3CYchE7PZxckqpW8KyZU4lg6QK
         j6W7+PQMfM2MWbpRjqdzoWCquJoXaLpsKFFEnGjzzqMSXBXQD0SWyd/uHvHzAfA+8P3e
         l7aZO1NS2i4CfBKB+ticf9CL4W6pRFS00ct9H6VO1XfLoQ8lIxIyOYs84S6CQtn5bSSd
         0glVTzMjwDJTl1WifXK4V1krZqMmnCsMZXNFsyKB0qjjvVtU0cv8etMj4ciASKXFOcUS
         P91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721091470; x=1721696270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xW2pCScye9pRbQhCrEvhJonroguMyntQisrBj9wxnXg=;
        b=aTOklVhvLL59ALrR2CIZjkmSToXStOCaqnJ4Q9OWk1rHF5R46ovJOZ/lrjtb7sxL5q
         d0dE9qLf1fPAOSxD1k4p1ZveuJFs20TAgytXQbT16A8TnfWqVIAf216z61MNP3JhvfFR
         hotv/qY+6vq/x4gUTBHJl+jy8qI08V9gD0ICRtrOiHuSd19VCFBB6SEBVesgE54wifXN
         6fQD3ROQQoy82RNIB8qfp5fN63/9Ev14H27rr4dkabGqKgT7tQX4W3f00KU+Pti8mRNE
         SqlSAoGy+0/2Cc7XPadPtaFkUUBrrg8/SNP//iWQd9gnGkEs5/w8e7Solcxyui8r+dwT
         dS+w==
X-Forwarded-Encrypted: i=1; AJvYcCV5bNU51tSCah7gk6vzsy6upDL6mQmKSWznDb+BRHqDIkNV5hB5KkoslzJ7UA5W/ONpk06AHN6ACJUPGkpeVTjFLR2D
X-Gm-Message-State: AOJu0Yz05gMGNCsIoeKQXqp4R0DNreCAo4jA8E6lxHPJd6iQmFMUxVsG
	mzw+YuP7VXVUSdiP7xfWw4kFpCFAGZQV3VQCEGgwev4LNF8pf7aG
X-Google-Smtp-Source: AGHT+IHijtWzePQq3Z5wgCqXwLlnr/uGS6lwE6Zzpj+8S3UlTQ/aJrGCm4FD7h9JUw96/KcssUF+iA==
X-Received: by 2002:a0d:eec1:0:b0:64a:efa6:b3d5 with SMTP id 00721157ae682-66380c110afmr7400377b3.37.1721091470304;
        Mon, 15 Jul 2024 17:57:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:4bf0:30f0:6cb2:3eab? ([2600:1700:6cf8:1240:4bf0:30f0:6cb2:3eab])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-65fc492c676sm9871497b3.139.2024.07.15.17.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 17:57:49 -0700 (PDT)
Message-ID: <528a8c8c-159c-4fb2-9c4c-c9c9b2e585df@gmail.com>
Date: Mon, 15 Jul 2024 17:57:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/4] monitor network traffic for flaky test cases
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Stanislav Fomichev <sdf@fomichev.me>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240713055552.2482367-1-thinker.li@gmail.com>
 <ZpWVvo5ypevlt9AB@mini-arch> <4c658385-dc3c-46ff-a868-0159edf84dc1@gmail.com>
 <940fff33-ed2b-41e0-bac6-d388deda9446@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <940fff33-ed2b-41e0-bac6-d388deda9446@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/15/24 16:56, Martin KaFai Lau wrote:
> On 7/15/24 3:07 PM, Kui-Feng Lee wrote:
>>
>>
>> On 7/15/24 14:33, Stanislav Fomichev wrote:
>>> On 07/12, Kui-Feng Lee wrote:
>>>> Run tcpdump in the background for flaky test cases related to network
>>>> features.
>>>
>>> Have you considered linking against libpcap instead of shelling out
>>> to tcpdump? As long as we have this lib installed on the runners
>>> (likely?) that should be a bit cleaner than doing tcpdump.. WDYT?
>>
>> I just checked the script building the root image for vmtest. [1]
>> It doesn't install libpcap.
>>
>> If our approach is to capture the packets in a file, and let developers
>> download the file, it would be a simple and straight forward solution.
>> If we want a log in text, it would be more complicated to parse
>> packets.
>>
>> Martin & Stanislay,
>>
>> WDYT about capture packets in a file and using libpcap directly?
>> Developers can download the file and parse it with tcpdump locally.
> 
> thinking out loud...
> 
> Re: libpcap (instead of tcpdump) part. I am not very experienced in 
> libpcap. I don't have a strong preference. I do hope patch 1 could be 
> more straight forward that no need to use loops and artificial udp 
> packets to ensure the tcpdump is fully ready to capture. I assume using 
> libpcap can make this sync part easier/cleaner (pthread_cond?) and not 
> too much code is needed to use libpcap?

Yes, it would be easier and cleaner if we don't parse the payload
of packets.

> 
> Re: dump to file and download by developer. If I read patch 1 correctly, 
> it only dumps everything at the end of the test (by calling 
> traffic_monitor_report). imo, it lost the chronological ordering with 
> other ASSERT_* logs and does not make a big difference (vs downloading 
> as a file).
> 
> The developer needs to go through another exercise to figure out (e.g.) 
> a captured packet may be related to a ASSERT_* failure by connecting the 
> timestamp between the ASSERT_* log and the captured packet (afaik, there 
> is a timestamp in the CI raw log). Ideally, the packet can be logged to 
> stderr/out as soon as it is captured such that the developer can still 
> sort of relate the packet with the other ASSERT_*() log around it.
> 

We can print an ordered number for each received packets to stderr asap
and use libpcap without parsing packets. Developers use tcpdump or
wireshark to parse packets.

Or, we can just run tcpdump on background and let it write to stderr
directly. This is convenient for developers. However, we still need to
wait for tcpdump ready.

Another hybrid solution is to have a libpcap thread to capture packets 
and feed packets to tcpdump through a pipe to parse packets. With this,
we don't need to wait for tcpdump anymore. However, I am not sure
how long tcpdump gets ready. It may make all these efforts of keeping
order useless. But, I can try it.


