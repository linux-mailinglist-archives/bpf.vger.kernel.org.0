Return-Path: <bpf+bounces-69469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E61B97278
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 20:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFC618923F3
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 18:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C575BE5E;
	Tue, 23 Sep 2025 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJ/H37Rw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8388B2D97BA
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650573; cv=none; b=UVHrlTYN+ggLLcFp9f3dex4yNZJfy+s2SN+iV5Hdcv55JooDUuyikwQ81NZimiHfkfDnymd2/OAtoB4+QYMY0E+GSpa1RdMdHfqiYjpLVpIi+6OWIQFP1WHaAv3skxTzaAh5nNq0z7kkb0EbWiEBvsoKHsKh4cpsPnNSx6PiLy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650573; c=relaxed/simple;
	bh=cwxWA5SjpJsmIGAEtf/ZI6lsWcCkGm6hw9JIin8TAEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsF4U+/ecJPon51cVRk1tp22TlopotC+A4fMbx23hnOi1TED01bc4QbyGe/xbILTts03fESxtFUP8U9ncpmjoFqGCnzhBo3A22RnueF9h2Q2DEilTIDoZG3EtRlPeTCFUVzolYmsG8FYpoy4uieJRPQ6CRDoJ5Udda09W4lz5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJ/H37Rw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f41086c11so2192219b3a.0
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 11:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758650571; x=1759255371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+tqvwE+E0cZ1fEaxr5t2bL8HNbMuR4y65gYrn4JYKo=;
        b=TJ/H37Rwjis6xDKTLdb06zEkg2wcvcRHJoq3/PEC1N98x+GsmG5N0K4KXFy1UTodCF
         mbVBafJ2DKGW+2aU7RCJirQeAEAuMqsOSIMPQQCt8/zV+eCSKSWh+QF4FvufuWwfvYkE
         7BD5f5WhGFylaQSDf26RHT2XkBs0MdNJNE5EOoVC3iAyHlvsMAWMhrbKCpRfo4nR2u8w
         JF210h4L8E+4ualBxHS9RadE3Lhi4XE6s8cQ7S8SsVSpxKPUEZ1aSjGJRZRYMqiR5tyF
         5kcr7cmyI8LyDCFKvLUbdkCFl4EVV/rwvcS9HQAVR/2CofrZvaEE16wBgD3Wi/v+sTVJ
         Tqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758650571; x=1759255371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+tqvwE+E0cZ1fEaxr5t2bL8HNbMuR4y65gYrn4JYKo=;
        b=FEGhOR5B/q2p+LCdnQR1nH+VomvrT1QyDkVUvr0heOEduo8auNhdp0REv9i83JdgE3
         AIsbXdLOV5NvXjpk5AfbMhYS7Pd278RGZOhlGkVgz+mmOl9xJMylsab6Q04K2/gKHvB4
         WmstYhY6Fue6rAN/yL3atxJwb0onMrmtD5GWkZ5EK14G1wkjznN24Z6aX7GY6wAcnIed
         0NRElCGe7UPLEUVXfBt33n79MnnbORfaTyTjiKbHjXlfozGMfoQQw9QDjCilHk5aTOHA
         L7GdoXYClSvUWS/zv3b4fdtFzU2PtQQuJW65tYA1acxZ0b7KRxPb3B04uipeW5jAyeUH
         4JJA==
X-Forwarded-Encrypted: i=1; AJvYcCUuxZdxQ2oaKyIt6JOZpS4JgJrdSwuS4LhrL6bYSii3H+eSHepMB1xTzLalc3OBWUF/Tj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA6AUpm6SKXh7XriCB0QZwT9w/DDlgesJ2Rx36Hf875oEobkJQ
	jw4V0nqlsrFpgZSPmglz3KDIKRWdSHddIIdsFVL7wHWKl92cc+wxa2uKAzJmDg==
X-Gm-Gg: ASbGncucczhYhVDv0ocoSPjk6NxErbkDZKPzI2Bsw14FtRHvIfrdo3l6ZZjuS7ip/2u
	X4Bk4NTzg/e4CH/Xl9y7BGbZOphD2+Z5ZSKArXhgE7mZXRrdXlZK+iWvwSr10S1Dry7Jn26JVKf
	cBETof/0lyGnJdvwbEJ5hslPetK+BOjx1qsBads0gw8ICik6uruvgIvoWENFTET+FhxGkDOlKLj
	YNbnqYIW6rMqep41CM/Ja71wdhkY3r9Xk9WsGHatbTHxiViOwwsNA4QyEHKaVz0lttUfA//+v0B
	o5iA9llxQKQ6ddoRvPfkhRy8UxKe9PO0nLqh8COryGP87SxPeMBu1OqLAxZmliYWFyNDe5IlDU7
	9kd1Q9Q+DQYKUDctzDRKL0M8z2RUHprL5
X-Google-Smtp-Source: AGHT+IFUlOckCHI+KwnlDW4tzUdg15UTb2EGkiOLw73qogkO+0zulqJJ9EPdzpVIEp7UN6ZvkshONw==
X-Received: by 2002:a17:903:37d0:b0:25f:9682:74ae with SMTP id d9443c01a7336-27cc5a09d62mr39648005ad.29.1758650570586;
        Tue, 23 Sep 2025 11:02:50 -0700 (PDT)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269800541adsm168967475ad.4.2025.09.23.11.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 11:02:49 -0700 (PDT)
Message-ID: <01fdd968-8b82-4777-88c3-e1dc0c81e9bc@gmail.com>
Date: Tue, 23 Sep 2025 11:02:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] memcg: introduce kfuncs for fetching memcg stats
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: mkoutny@suse.com, yosryahmed@google.com, hannes@cmpxchg.org,
 tj@kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, kernel-team@meta.com, linux-mm@kvack.org,
 bpf@vger.kernel.org
References: <20250920015526.246554-1-inwardvessel@gmail.com>
 <ky2yjg6qrqf6hqych7v3usphpcgpcemsmfrb5ephc7bdzxo57b@6cxnzxap3bsc>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <ky2yjg6qrqf6hqych7v3usphpcgpcemsmfrb5ephc7bdzxo57b@6cxnzxap3bsc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/25 10:17 PM, Shakeel Butt wrote:
> +linux-mm, bpf
> 
> Hi JP,
> 
> On Fri, Sep 19, 2025 at 06:55:26PM -0700, JP Kobryn wrote:
>> The kernel has to perform a significant amount of the work when a user mode
>> program reads the memory.stat file of a cgroup. Aside from flushing stats,
>> there is overhead in the string formatting that is done for each stat. Some
>> perf data is shown below from a program that reads memory.stat 1M times:
>>
>> 26.75%  a.out [kernel.kallsyms] [k] vsnprintf
>> 19.88%  a.out [kernel.kallsyms] [k] format_decode
>> 12.11%  a.out [kernel.kallsyms] [k] number
>> 11.72%  a.out [kernel.kallsyms] [k] string
>>   8.46%  a.out [kernel.kallsyms] [k] strlen
>>   4.22%  a.out [kernel.kallsyms] [k] seq_buf_printf
>>   2.79%  a.out [kernel.kallsyms] [k] memory_stat_format
>>   1.49%  a.out [kernel.kallsyms] [k] put_dec_trunc8
>>   1.45%  a.out [kernel.kallsyms] [k] widen_string
>>   1.01%  a.out [kernel.kallsyms] [k] memcpy_orig
>>
>> As an alternative to reading memory.stat, introduce new kfuncs to allow
>> fetching specific memcg stats from within bpf iter/cgroup-based programs.
>> Reading stats in this manner avoids the overhead of the string formatting
>> shown above.
>>
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> 
> Thanks for this but I feel like you are drastically under-selling the
> potential of this work. This will not just reduce the cost of reading
> stats but will also provide a lot of flexibility.
> 
> Large infra owners which use cgroup, spent a lot of compute on reading
> stats (I know about Google & Meta) and even small optimizations becomes
> significant at the fleet level.
> 
> Your perf profile is focusing only on kernel but I can see similar
> operation in the userspace (i.e. from string to binary format) would be
> happening in the real world workloads. I imagine with bpf we can
> directly pass binary data to userspace or we can do custom serialization
> (like protobuf or thrift) in the bpf program directly.
> 
> Beside string formatting, I think you should have seen open()/close() as
> well in your perf profile. In your microbenchmark, did you read
> memory.stat 1M times with the same fd and use lseek(0) between the reads
> or did you open(), read() & close(). If you had done later one, then
> open/close would be visible in the perf data as well. I know Google
> implemented fd caching in their userspacecontainer library to reduce
> their open/close cost. I imagine with this approach, we can avoid this
> cost as well.

In the test program, I opened once and used lseek() at the end of each
iteration. It's a good point though about user programs typically
opening and closing. I'll adjust the test program to resemble that
action.

> 
> In terms of flexibility, I can see userspace can get the stats which it
> needs rather than getting all the stats. In addition, userspace can
> avoid flushing stats based on the fact that system is flushing the stats
> every 2 seconds.

That's true. The kfunc for flushing is made available but not required.

> 
> In your next version, please also include the sample bpf which uses
> these kfuncs and also include the performance comparison between this
> approach and the traditional reading memory.stat approach.

Thanks for the good input. Will do.


