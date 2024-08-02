Return-Path: <bpf+bounces-36309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9275D94637E
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 20:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD121C216BF
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 18:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9031547D0;
	Fri,  2 Aug 2024 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C5EA2P4y"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D499B1ABEC2
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722625148; cv=none; b=i0+Pfh9q49QuGxelcbe4hy5pAT2U4eWj15/4ev1uOBKh2EatZ2zhfhH7DyE4c9YTQNhW0AL9JjmPh4MnedPj9CW0TmQkZ6yEUWGm2O9BSXuge1C7+6P82kbKWxin4LCAtide+qC7O1W15VBVChy1OSBJd3BpI7FFvWlHHhz/iqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722625148; c=relaxed/simple;
	bh=rMJHGYIL97+uggAt8D5YPagsszlb6rKMxIbkJmP47M8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twfjgLVkyv5cBhn0tvfMbM4kQTIiIOg06d7q+mqz3o0jUnivT6LPae0IAq+0QPuxUk+9fdbTscT2iIFz5rEUCzx7USbSXFQ/bwbzVkeBcpDTqeNc3l/1Ie7WDra7o6RilSkRYm1+ZrvgtDu95SZHv1glNNGDla1B4SEb0ZMyE3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C5EA2P4y; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2be68df9-2b73-42c6-b5da-2fd622fcef69@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722625143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TC65ziIb4upHXEo9NS2Nmajh8O1JySnn9Rkbb/tScvU=;
	b=C5EA2P4yl3mdU5uZXLzksboSM2GlnMc8AhPVPw/ayzvHiMtiEi3bbzqq/M4TTyA0/UB1rN
	jIh+fpEFBkTf7Fr9xht/3tv6WyC693U0UW4IteaicJKdeWz377qv9tG85STBfiE2MEUb2t
	s/bqk5HuhllmUEz8W/bwH8G+2JVyb68=
Date: Fri, 2 Aug 2024 11:58:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/6] selftests/bpf: Add traffic monitor
 functions.
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 geliang@kernel.org, kuifeng@meta.com
References: <20240731193140.758210-1-thinker.li@gmail.com>
 <20240731193140.758210-2-thinker.li@gmail.com>
 <157ef482-a018-46da-b049-10c47fd286c7@linux.dev>
 <8c20454b-9e45-4371-bc47-6dd079573130@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <8c20454b-9e45-4371-bc47-6dd079573130@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/1/24 9:31 PM, Kui-Feng Lee wrote:
> 
> 
> On 8/1/24 20:29, Martin KaFai Lau wrote:
>> On 7/31/24 12:31 PM, Kui-Feng Lee wrote:
>>> Add functions that capture packets and print log in the background. They
>>> are supposed to be used for debugging flaky network test cases. A monitored
>>> test case should call traffic_monitor_start() to start a thread to capture
>>> packets in the background for a given namespace and call
>>> traffic_monitor_stop() to stop capturing. (Or, option '-m' implemented by
>>> the later patches.)
>>>
>>>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 68, ifindex 1, SYN
>>>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 60, ifindex 1, 
>>> SYN, ACK
>>>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 60, ifindex 1, ACK
>>>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, ACK
>>>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 52, ifindex 1, 
>>> FIN, ACK
>>>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, 
>>> RST, ACK
>>
>> nit. Instead of ifindex, it should be ifname now.
> 
> Sure! I will update it.
> 
>>
>>>      Packet file: packets-2172-86-select_reuseport:sockhash-test.log
>>>      #280/87 select_reuseport/sockhash IPv4/TCP LOOPBACK test_detach_bpf:OK
>>>
>>> The above is the output of an example. It shows the packets of a connection
>>> and the name of the file that contains captured packets in the directory
>>> /tmp/tmon_pcap. The file can be loaded by tcpdump or wireshark.
>>>
>>> This feature only works if TRAFFIC_MONITOR variable has been passed to
>>> build BPF selftests. For example,
>>>
>>>    make TRAFFIC_MONITOR=1 -C tools/testing/selftests/bpf
>>>
>>> This command will build BPF selftests with this feature enabled.
>>>
>>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>>> ---
>>>   tools/testing/selftests/bpf/Makefile     |   5 +
>>>   tools/testing/selftests/bpf/test_progs.c | 432 +++++++++++++++++++++++
>>
>> In the cover letter, it mentioned the traffic monitoring implementation is 
>> moved from the network_helpers.c to test_progs.c.
>>
>> Can you share more about the reason?
> 
> network_helpers.c has been used by several test programs.
> However, they don't have env that we found in test_progs.c.
> That means we could not access env directly. Instead, the caller
> have to pass the test name and subtest name to the function.
> Leter, we also need to check if a test name matches the patterns. It is
> inconvient for users. So, I move these functions to test_progs.c to make
> user's life eaiser.
> 
> 
>>
>> Is it because the traffic monitor now depends on the test_progs's test name, 
>> should_tmon...etc ? Can the test name and should_tmon be exported for the 
>> network_helpers to use?
> 
> Yes! And in later patches, we also introduce a list of patterns.

The list of patterns matching is summarized in "should_tmon" which can be 
exported through a function?

or I have missed another criteria when deciding tmon should be enabled for a test?

>>
>> What other compilation issues did it hit if the traffic monitor codes stay in 
>> the network_helpers.c? Some individual binaries (with main()) like 
>> test_tcp_check_syncookie_user that links to network_helpers.o but not to 
>> test_progs.o?
> 
> Yes, they are problems as well. These binary also need to link to
> libpcap even they don't use it although this is not an important issue.

I don't think linking the non test_progs binaries to libpcap or not is important.

I am positive there are ways out of it without adding the networking codes to 
the test_progs.c. It sounds like an unnecessary nit now but I believe it is 
useful going forward when making changes and extension to the traffic 
monitoring. May be brainstorm a little to see if there is an way out.

One way could be putting them in a new traffic_monitor.c such that the non 
test_progs binaries won't link to it. and exports the test name and shmod_tmon 
in test_progs.h (e.g. through function).

Another way (better and my preference if it works out) is to ask the 
traffic_monitor_start() to take the the pcap file name args and makeup a 
reasonable default if no filename is given.  Not that I am promoting non 
test_progs tests, traffic_monitor_start() can then be reused by others for legit 
reason. The test_progs's tests usually should not use traffic_monitor_start() 
directly and they should stay with the netns_{new, free}. I think only netns_new 
needs the env to figure out the should_tmon and the pcap filename. May be 
netns_new() can stay in test_progs.c, or rename it to test__netns_new().

wdyt?

