Return-Path: <bpf+bounces-36316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E28994646F
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 22:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC43B21248
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 20:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C590649634;
	Fri,  2 Aug 2024 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KC3xen82"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99A733DF
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631051; cv=none; b=dLEVWtmToXQ4Vqb+mP5MitBHKQDpIb7XYxh7IqfXWzQwitVw8/hIPg7Ygko/SsMFTbuIIwpxVPn8wR7kilUMzc8jEWAyz8+fyby9D7rLlR+bjkWY20MJAzu12FS/VJtjWtF1RCuub2om07MnJf6+pl00xceHhTXBLPuZ7tKElXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631051; c=relaxed/simple;
	bh=MWWvheC4Q6oLMmfbjR7TxIfRC7I5yADX3/WMFq4zXZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSTM23q7JtIlQjlUp0UeCIRkfR2iCIfDIVKHhlnCJM1Mj+TDvyyZwwdYV+SAXsZcZKk3UsteJAMTHHzfJQZT+pJMCvqtu1rA5AZH8RlSPav0WDQs/3mohV9vnloQozKcicpIXDGTGbBjKYeLU6FgTtSqqX1Pp9tcyYvjFETIho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KC3xen82; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6510c0c8e29so68532677b3.0
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2024 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722631049; x=1723235849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3YqAd47UcnIukCTh9OTlcAFXV2sGF+x4/uyCSSEezc4=;
        b=KC3xen82vbkieC8zn8QfaAXNzcXhXTOC12IjxC6IwFY2xmDgUvjmLK2HReGazUZwff
         R2IOQAROaL1tWjnFHA7TDrvKxLVJd8BEwooKHN5a8YbLraXDWfdhsNPt+1cOuVi1RLnB
         GBiBWxu8ZmvdVOkCv/yH60u99zfijxqQbQMYt/Vfnns8GzTlywwUCnC/9dBOy6KuZOUi
         BFwqPPwIN3NaZhhf9iVSTmliuc767hOSwM5gvUAoGCOMS8VpNZkWcQ/KFXdDNuuk9oKv
         0LwzkoYiIMsN2nPy0atvwhluPXu/P206zFHWHNED769vKOL2t/mjv13HEGYApcnZ4W2G
         lKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722631049; x=1723235849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YqAd47UcnIukCTh9OTlcAFXV2sGF+x4/uyCSSEezc4=;
        b=wd7UurxMe3eJIQymZX1wBlYbokeOiOyt+qOtLgShrDKo/TsyyZdqWnyRi3Vyitw7Zg
         1WqkmU+McfFuma+YDk8ids8TwqXMbKmCF3+v75YAgMkAlNPtsYjsWigyS+U8KWuhyjIa
         N1gRyMjncntB/nYCqmAj2/2Q9eUM21EcAYFBtiHR1XREVj+RNkSPXG8NbuvP/DAXumHl
         H5Fq/pdOIbWuiBxHy8WVeJQ2XwHOaetO55IVFJNlV7PmPMLkJyR2Hej01Y+j0k8L3qf7
         RM+SlOxziMBdCk0578No50AGaoktHf+FJVnDfb6p2SenBIRWBNCVdkb3HguYMgeLrKuv
         Ezpg==
X-Gm-Message-State: AOJu0YyOasCqZjWYCOxtpQnm24jGpCVky3aFPaN2yWrWguzmdhjMrotE
	zJXoU0j/sZmACaEMIZgnZtmKhvBozhFcaad2gIjaYewh5WzIPuZHJPAkbw==
X-Google-Smtp-Source: AGHT+IFsaCuVeRpNrNRZ9eIUa2hN5qCsFsOgQofXq+57jZ9+9vRM0zAYeac82aQmdRjWTArfqSRccA==
X-Received: by 2002:a81:6906:0:b0:650:9c5e:f6db with SMTP id 00721157ae682-68960c4ea3cmr50351427b3.18.1722631048680;
        Fri, 02 Aug 2024 13:37:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:9b84:fd3f:f496:98cc? ([2600:1700:6cf8:1240:9b84:fd3f:f496:98cc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a09e92aa2sm3868337b3.0.2024.08.02.13.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 13:37:28 -0700 (PDT)
Message-ID: <f183b180-3bb1-4650-89f9-704db529281b@gmail.com>
Date: Fri, 2 Aug 2024 13:37:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/6] selftests/bpf: Add traffic monitor
 functions.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 geliang@kernel.org, kuifeng@meta.com
References: <20240731193140.758210-1-thinker.li@gmail.com>
 <20240731193140.758210-2-thinker.li@gmail.com>
 <157ef482-a018-46da-b049-10c47fd286c7@linux.dev>
 <8c20454b-9e45-4371-bc47-6dd079573130@gmail.com>
 <2be68df9-2b73-42c6-b5da-2fd622fcef69@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <2be68df9-2b73-42c6-b5da-2fd622fcef69@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/2/24 11:58, Martin KaFai Lau wrote:
> On 8/1/24 9:31 PM, Kui-Feng Lee wrote:
>>
>>
>> On 8/1/24 20:29, Martin KaFai Lau wrote:
>>> On 7/31/24 12:31 PM, Kui-Feng Lee wrote:
>>>> Add functions that capture packets and print log in the background. 
>>>> They
>>>> are supposed to be used for debugging flaky network test cases. A 
>>>> monitored
>>>> test case should call traffic_monitor_start() to start a thread to 
>>>> capture
>>>> packets in the background for a given namespace and call
>>>> traffic_monitor_stop() to stop capturing. (Or, option '-m' 
>>>> implemented by
>>>> the later patches.)
>>>>
>>>>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 68, 
>>>> ifindex 1, SYN
>>>>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 60, 
>>>> ifindex 1, SYN, ACK
>>>>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 60, 
>>>> ifindex 1, ACK
>>>>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, 
>>>> ifindex 1, ACK
>>>>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 52, 
>>>> ifindex 1, FIN, ACK
>>>>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, 
>>>> ifindex 1, RST, ACK
>>>
>>> nit. Instead of ifindex, it should be ifname now.
>>
>> Sure! I will update it.
>>
>>>
>>>>      Packet file: packets-2172-86-select_reuseport:sockhash-test.log
>>>>      #280/87 select_reuseport/sockhash IPv4/TCP LOOPBACK 
>>>> test_detach_bpf:OK
>>>>
>>>> The above is the output of an example. It shows the packets of a 
>>>> connection
>>>> and the name of the file that contains captured packets in the 
>>>> directory
>>>> /tmp/tmon_pcap. The file can be loaded by tcpdump or wireshark.
>>>>
>>>> This feature only works if TRAFFIC_MONITOR variable has been passed to
>>>> build BPF selftests. For example,
>>>>
>>>>    make TRAFFIC_MONITOR=1 -C tools/testing/selftests/bpf
>>>>
>>>> This command will build BPF selftests with this feature enabled.
>>>>
>>>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>>>> ---
>>>>   tools/testing/selftests/bpf/Makefile     |   5 +
>>>>   tools/testing/selftests/bpf/test_progs.c | 432 
>>>> +++++++++++++++++++++++
>>>
>>> In the cover letter, it mentioned the traffic monitoring 
>>> implementation is moved from the network_helpers.c to test_progs.c.
>>>
>>> Can you share more about the reason?
>>
>> network_helpers.c has been used by several test programs.
>> However, they don't have env that we found in test_progs.c.
>> That means we could not access env directly. Instead, the caller
>> have to pass the test name and subtest name to the function.
>> Leter, we also need to check if a test name matches the patterns. It is
>> inconvient for users. So, I move these functions to test_progs.c to make
>> user's life eaiser.
>>
>>
>>>
>>> Is it because the traffic monitor now depends on the test_progs's 
>>> test name, should_tmon...etc ? Can the test name and should_tmon be 
>>> exported for the network_helpers to use?
>>
>> Yes! And in later patches, we also introduce a list of patterns.
> 
> The list of patterns matching is summarized in "should_tmon" which can 
> be exported through a function?

Yes! Even with a functio, it still depends on test_progs.c.

> 
> or I have missed another criteria when deciding tmon should be enabled 
> for a test?
> 
>>>
>>> What other compilation issues did it hit if the traffic monitor codes 
>>> stay in the network_helpers.c? Some individual binaries (with main()) 
>>> like test_tcp_check_syncookie_user that links to network_helpers.o 
>>> but not to test_progs.o?
>>
>> Yes, they are problems as well. These binary also need to link to
>> libpcap even they don't use it although this is not an important issue.
> 
> I don't think linking the non test_progs binaries to libpcap or not is 
> important.
> 
> I am positive there are ways out of it without adding the networking 
> codes to the test_progs.c. It sounds like an unnecessary nit now but I 
> believe it is useful going forward when making changes and extension to 
> the traffic monitoring. May be brainstorm a little to see if there is an 
> way out.
> 
> One way could be putting them in a new traffic_monitor.c such that the 
> non test_progs binaries won't link to it. and exports the test name and 
> shmod_tmon in test_progs.h (e.g. through function).
> 
> Another way (better and my preference if it works out) is to ask the 
> traffic_monitor_start() to take the the pcap file name args and makeup a 
> reasonable default if no filename is given.  Not that I am promoting non 
> test_progs tests, traffic_monitor_start() can then be reused by others 
> for legit reason. The test_progs's tests usually should not use 
> traffic_monitor_start() directly and they should stay with the 
> netns_{new, free}. I think only netns_new needs the env to figure out 
> the should_tmon and the pcap filename. May be netns_new() can stay in 
> test_progs.c, or rename it to test__netns_new().
> 
> wdyt?

How about put two ideas together?
Have traffic_monitor.c and macros in test_progs.h to collect
data from env, and pass the data to netns_new() in traffic_monitor.c.

For example,

#define test__netns_new(ns) netns_new(ns, env.test->should_tmon || \
             (env.subtest_state && env.subtest_state->should_tmon), \
             env.test->test_name,                                   \
             env.subtest_state ? env.subtest_state->name: NULL)


