Return-Path: <bpf+bounces-45583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0459D8C74
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 19:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF552285368
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 18:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8711B983E;
	Mon, 25 Nov 2024 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMaRpC00"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D108F1AF0CB;
	Mon, 25 Nov 2024 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732560647; cv=none; b=RGS3VIl1/WL3yO0DwjlZKnlZAjG94PKjY6JlLbjL5SFyDU6y5c9gi+PBTGCZjaL6SeqrWZkj8nDaicu6gKSs5NDtI6V1A/CSED6cr6oiibuajUaeOsKedVG3ylCQuo0K2Hzr+xTU2GfNes4Vpvtg2VCJoRYjcFD0kkimqz+mo00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732560647; c=relaxed/simple;
	bh=T3BifNSxIQLht5pOam5kqaF6/zJkRYG7joZ7EyNthPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTwXTpSqOmgsz4JpvHuGgYdT3MoEIw0yj7OGAdUiMpkLmsSFfbK5I8GknSCyZj+0/A0B+5FQi69Yj6eF/EvyElI4ljs1ihsNhOoLcCKWisci4ed9mURvOtq0tc1QATcxmtCHcxGmeXFsJWApxB6klYaiNsPPJGg/yC4ofkOmiSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMaRpC00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8707FC4CECE;
	Mon, 25 Nov 2024 18:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732560647;
	bh=T3BifNSxIQLht5pOam5kqaF6/zJkRYG7joZ7EyNthPw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YMaRpC00WJIZyiZ3KJV0MVBO/FwuNOzagC4Y/A+szWcfgYvsQcuU2cPwkVblUpoLh
	 dFrGvMszAlc2yYhdxl04gR0lQg9rHKmcnpzREkLoY5lTGElZE/REVIkjZ/9elbx+5O
	 dT18EK4MwK8h3lT0chQ3o42Of0Pm3pJvR/E6iuEF90Q25pris8BJeqaNOGTYG/5QX6
	 x9GyMWtQjB1nt+1pgZ+O7R2NvIPgmhX/8h/XuQ07q0NCRp4lKUe2z4QP83l4B+M4yK
	 rG6Y6/fKq1ilP7Z9JIMpt0dtiDdVnznV5/W6sGkfpVSHw55n5NyLiHoHzfcul6/pRQ
	 hwWlFKeVfHD1A==
Message-ID: <fcaae4c8-4083-4eef-8cfe-3d1f7e340079@kernel.org>
Date: Mon, 25 Nov 2024 19:50:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Daniel Xu <dxu@dxuuu.xyz>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
 kernel-team <kernel-team@cloudflare.com>, mfleming@cloudflare.com
References: <cover.1726480607.git.lorenzo@kernel.org>
 <amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
 <ZwZe6Bg5ZrXLkDGW@lore-desk> <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
 <ZwZ7fr_STZStsnln@lore-desk> <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
 <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
 <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
 <b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
 <rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
 <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/11/2024 16.12, Alexander Lobakin wrote:
> From: Daniel Xu <dxu@dxuuu.xyz>
> Date: Fri, 22 Nov 2024 17:10:06 -0700
> 
>> Hi Olek,
>>
>> Here are the results.
>>
>> On Wed, Nov 13, 2024 at 03:39:13PM GMT, Daniel Xu wrote:
>>>
>>>
>>> On Tue, Nov 12, 2024, at 9:43 AM, Alexander Lobakin wrote:
> 
> [...]
> 
>> Baseline (again)
>>
>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
>> Run 1	3169917	        0.00007295	0.00007871	0.00009343		Run 1	21749.43
>> Run 2	3228290	        0.00007103	0.00007679	0.00009215		Run 2	21897.17
>> Run 3	3226746	        0.00007231	0.00007871	0.00009087		Run 3	21906.82
>> Run 4	3191258	        0.00007231	0.00007743	0.00009087		Run 4	21155.15
>> Run 5	3235653	        0.00007231	0.00007743	0.00008703		Run 5	21397.06
>> Average	3210372.8	0.000072182	0.000077814	0.00009087		Average	21621.126
>>

We need to talk about what we are measuring, and how to control the
experiment setup to get reproducible results.
Especially controlling on what CPU cores our code paths are executing.

In above "baseline" case, we have two processes/tasks executing:
  (1) RX-napi softirq/thread (until napi_gro_receive deliver to socket)
  (2) Userspace netserver process TCP receiving data from socket.

My experience is that you will see two noticeable different
throughput performance results depending on whether (1) and (2) is
executing on the *same* CPU (multi-tasking context-switching),
or executing in parallel (e.g. pinned) on two different CPU cores.

The netperf command have an option

  -T lcpu,remcpu
       Request that netperf be bound to local CPU lcpu and/or netserver 
be bound to remote CPU rcpu.

Verify setting by listing pinning like this:
   for PID in $(pidof netserver); do taskset -pc $PID ; done

You can also set pinning runtime like this:
  export CPU=2; for PID in $(pidof netserver); do sudo taskset -pc $CPU 
$PID; done

For troubleshooting, I like to use the periodic 1 sec (netperf -D1)
output and adjust pinning runtime to observe the effect quickly.

My experience is unfortunately that TCP results have a lot of variation
(thanks for incliding 5 runs in your benchmarks), as it depends on tasks
timing, that can get affected by CPU sleep states. The systems CPU
latency setting can be seen in /dev/cpu_dma_latency, which can be read
like this:

  sudo hexdump --format '"%d\n"' /dev/cpu_dma_latency

For playing with changing /dev/cpu_dma_latency I choose to use tuned-adm
as it requires holding the file open. E.g I play with these profiles:

  sudo tuned-adm profile throughput-performance
  sudo tuned-adm profile latency-performance
  sudo tuned-adm profile network-latency


>> cpumap v2 Olek
>>
>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
>> Run 1	3253651	        0.00007167	0.00007807	0.00009343		Run 1	13497.57
>> Run 2	3221492	        0.00007231	0.00007743	0.00009087		Run 2	12115.53
>> Run 3	3296453	        0.00007039	0.00007807	0.00009087		Run 3	12323.38
>> Run 4	3254460	        0.00007167	0.00007807	0.00009087		Run 4	12901.88
>> Run 5	3173327	        0.00007295	0.00007871	0.00009215		Run 5	12593.22
>> Average	3239876.6	0.000071798	0.00007807	0.000091638		Average	12686.316
>> Delta	0.92%	        -0.53%	        0.33%	        0.85%			        -41.32%
>>
>>


We now three processes/tasks executing:
  (1) RX-napi softirq/thread (doing XDP_REDIRECT into cpumap)
  (2) CPUmap kthread (until gro_receive_skb/gro_flush deliver to socket)
  (3) Userspace netserver process TCP receiving data from socket.

Again, now the performance is going to depend on depending on which CPU
cores the processes/tasks are running and whether some are sharing the
same CPU. (There are both wakeup timing and cache-line effects).

There are now more combinations to test...

CPUmap is a CPU scaling facility, and you will likely also see different
CPU utilization on the difference cores one you start to pin these to
control the scenarios.

>> It's very interesting that we see -40% tput w/ the patches. I went back
> 

Sad that we see -40% throughput...  but do we know what CPU cores the
now three different tasks/processes run on(?)


> Oh no, I messed up something =\
>  > Could you please also test not the whole series, but patches 1-3 (up to
> "bpf:cpumap: switch to GRO...") and 1-4 (up to "bpf: cpumap: reuse skb
> array...")? Would be great to see whether this implementation works
> worse right from the start or I just broke something later on.
> 
>> and double checked and it seems the numbers are right. Here's the
>> some output from some profiles I took with:
>>
>>      perf record -e cycles:k -a -- sleep 10
>>      perf --no-pager diff perf.data.baseline perf.data.withpatches > ...
>>
>>      # Event 'cycles:k'
>>      # Baseline  Delta Abs  Shared Object                                                    Symbol
>>           6.13%     -3.60%  [kernel.kallsyms]                                                [k] _copy_to_iter
>

I really appreciate that you provide perf data and perf diff, but as
described above, we need data and information on what CPU cores are
running which workload.

Fortunately perf diff (and perf report) support doing like this:
  perf diff --sort=cpu,symbol

But then you also need to control the CPUs used in experiment for the
diff to work.

I hope I made sense as these kind of CPU scaling benchmarks are tricky,
--Jesper

