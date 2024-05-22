Return-Path: <bpf+bounces-30264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A278CBBBB
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 09:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C60F6B21B9F
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 07:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DBA7BB19;
	Wed, 22 May 2024 07:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsCV06B3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0CE757E3;
	Wed, 22 May 2024 07:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716361793; cv=none; b=a9nho3/ngfo+koRgIVxS5JjNelYF8iH4TmeNdYIKztF/odQ8uoAK5bJFMD265BOt76JBsTh4hh597QD9jwS7qZmn7X5hzf5kv+uW/HnO3TxNsz2yF61yGG32Ix0O1y1W9v9WyavHkIk0nK0aL29gHzXx6YaFoNRJoPK/c1yE4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716361793; c=relaxed/simple;
	bh=TR/+w1xfGGKNjUy7DN+IkbPohsKmp5v8H4Jsop/xNhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irOHYGg+d+h2cOlICRR4adjiSgmrqClrw3ltfHB0HZ22RytfHeUYHflXzkGPZAYP/PSKtB9svzB3gR7N+hwQWGQSj8aFywkSlJH+98OhizSicO/ttoMcXb2IuPs6oJE4RcCmJiImM7LdHMKURdKfO75ASxtTt8zGvP1fa1fZXqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsCV06B3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2236FC2BD11;
	Wed, 22 May 2024 07:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716361792;
	bh=TR/+w1xfGGKNjUy7DN+IkbPohsKmp5v8H4Jsop/xNhc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jsCV06B3hNueOFpV9R3NBPzP39pX+viO1rf2EXTvJL6MKySVfWh8yEST1zBzpfDZZ
	 elDNJaQQofBB2SQXnOqJw44mG1ueOaSten3N9uy+k/j9zpug382mtkY4OLbZOZ0K6N
	 mu/1jTdmBfpPrcPumJA+dL4nxwegxmuprFGIl/Ac08ikhs7X7eFPrHrCGLMuwLGGLA
	 lex5cyNkYq4CxqpKwwmoyUF0V8olmSBNES6JrujtBPxVuf2fOIyrenMZIc+lhDI7x6
	 uNi1BgK3Rf8LsEAovC37eMd5EvstnFgu79sMjnVy99tdijwSgHj/gv7z/lZ1DoX5J/
	 0ma7z11puuPaA==
Message-ID: <e3e21c87-d210-4360-8beb-25c6a04ce581@kernel.org>
Date: Wed, 22 May 2024 09:09:45 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 14/15 v2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Boqun Feng <boqun.feng@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20240503182957.1042122-15-bigeasy@linutronix.de>
 <87y18mohhp.fsf@toke.dk>
 <CAADnVQJkiwaYXUo+LyKoV96VFFCFL0VY5Jgpuv_0oypksrnciA@mail.gmail.com>
 <20240507123636.cTnT7TvU@linutronix.de>
 <93062ce7-8dfa-48a9-a4ad-24c5a3993b41@kernel.org>
 <20240510162121.f-tvqcyf@linutronix.de>
 <20240510162214.zNWRKgFU@linutronix.de>
 <4949dca0-377a-45b1-a0fd-17bdf5a6ab10@kernel.org>
 <20240514054345.DZkx7fJs@linutronix.de>
 <e4123697-3e6e-4d4a-8b06-f69e1c453225@kernel.org>
 <20240517161553.SSh4BNQO@linutronix.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240517161553.SSh4BNQO@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/05/2024 18.15, Sebastian Andrzej Siewior wrote:
> On 2024-05-14 14:20:03 [+0200], Jesper Dangaard Brouer wrote:
>> Trick for CPU-map to do early drop on remote CPU:
>>
>>   # ./xdp-bench redirect-cpu --cpu 3 --remote-action drop ixgbe1
>>
>> I recommend using Ctrl+\ while running to show more info like CPUs being
>> used and what kthread consumes.  To catch issues e.g. if you are CPU
>> redirecting to same CPU as RX happen to run on.
> 
> Okay. So I reworked the last two patches make the struct part of
> task_struct and then did as you suggested:
> 
> Unpatched:
> |Sending:
> |Show adapter(s) (eno2np1) statistics (ONLY that changed!)
> |Ethtool(eno2np1 ) stat:    952102520 (    952,102,520) <= port.tx_bytes /sec
> |Ethtool(eno2np1 ) stat:     14876602 (     14,876,602) <= port.tx_size_64 /sec
> |Ethtool(eno2np1 ) stat:     14876602 (     14,876,602) <= port.tx_unicast /sec
> |Ethtool(eno2np1 ) stat:    446045897 (    446,045,897) <= tx-0.bytes /sec
> |Ethtool(eno2np1 ) stat:      7434098 (      7,434,098) <= tx-0.packets /sec
> |Ethtool(eno2np1 ) stat:    446556042 (    446,556,042) <= tx-1.bytes /sec
> |Ethtool(eno2np1 ) stat:      7442601 (      7,442,601) <= tx-1.packets /sec
> |Ethtool(eno2np1 ) stat:    892592523 (    892,592,523) <= tx_bytes /sec
> |Ethtool(eno2np1 ) stat:     14876542 (     14,876,542) <= tx_packets /sec
> |Ethtool(eno2np1 ) stat:            2 (              2) <= tx_restart /sec
> |Ethtool(eno2np1 ) stat:            2 (              2) <= tx_stopped /sec
> |Ethtool(eno2np1 ) stat:     14876622 (     14,876,622) <= tx_unicast /sec
> |
> |Receive:
> |eth1->?                 8,732,508 rx/s                  0 err,drop/s
> |  receive total         8,732,508 pkt/s                 0 drop/s                0 error/s
> |    cpu:10              8,732,508 pkt/s                 0 drop/s                0 error/s
> |  enqueue to cpu 3      8,732,510 pkt/s                 0 drop/s             7.00 bulk-avg
> |    cpu:10->3           8,732,510 pkt/s                 0 drop/s             7.00 bulk-avg
> |  kthread total         8,732,506 pkt/s                 0 drop/s          205,650 sched
> |    cpu:3               8,732,506 pkt/s                 0 drop/s          205,650 sched
> |    xdp_stats                   0 pass/s        8,732,506 drop/s                0 redir/s
> |      cpu:3                     0 pass/s        8,732,506 drop/s                0 redir/s
> |  redirect_err                  0 error/s
> |  xdp_exception                 0 hit/s
> 
> I verified that the "drop only" case hits 14M packets/s while this
> redirect part reports 8M packets/s.
>

Great, this is a good test.

The transmit speed 14.88 Mpps is 10G wirespeed at smallest Ethernet
packet size (84 bytes with overhead + intergap, 10*10^9/(84*8) = 14880952).


> Patched:
> |Sending:
> |Show adapter(s) (eno2np1) statistics (ONLY that changed!)
> |Ethtool(eno2np1 ) stat:    952635404 (    952,635,404) <= port.tx_bytes /sec
> |Ethtool(eno2np1 ) stat:     14884934 (     14,884,934) <= port.tx_size_64 /sec
> |Ethtool(eno2np1 ) stat:     14884928 (     14,884,928) <= port.tx_unicast /sec
> |Ethtool(eno2np1 ) stat:    446496117 (    446,496,117) <= tx-0.bytes /sec
> |Ethtool(eno2np1 ) stat:      7441602 (      7,441,602) <= tx-0.packets /sec
> |Ethtool(eno2np1 ) stat:    446603461 (    446,603,461) <= tx-1.bytes /sec
> |Ethtool(eno2np1 ) stat:      7443391 (      7,443,391) <= tx-1.packets /sec
> |Ethtool(eno2np1 ) stat:    893086506 (    893,086,506) <= tx_bytes /sec
> |Ethtool(eno2np1 ) stat:     14884775 (     14,884,775) <= tx_packets /sec
> |Ethtool(eno2np1 ) stat:           14 (             14) <= tx_restart /sec
> |Ethtool(eno2np1 ) stat:           14 (             14) <= tx_stopped /sec
> |Ethtool(eno2np1 ) stat:     14884937 (     14,884,937) <= tx_unicast /sec
> |
> |Receive:
> |eth1->?                 8,735,198 rx/s                  0 err,drop/s
> |  receive total         8,735,198 pkt/s                 0 drop/s                0 error/s
> |    cpu:6               8,735,198 pkt/s                 0 drop/s                0 error/s
> |  enqueue to cpu 3      8,735,193 pkt/s                 0 drop/s             7.00 bulk-avg
> |    cpu:6->3            8,735,193 pkt/s                 0 drop/s             7.00 bulk-avg
> |  kthread total         8,735,191 pkt/s                 0 drop/s          208,054 sched
> |    cpu:3               8,735,191 pkt/s                 0 drop/s          208,054 sched
> |    xdp_stats                   0 pass/s        8,735,191 drop/s                0 redir/s
> |      cpu:3                     0 pass/s        8,735,191 drop/s                0 redir/s
> |  redirect_err                  0 error/s
> |  xdp_exception                 0 hit/s
> 

Great basically zero overhead. Awesome you verified this!


> This looks to be in the same range/ noise level. top wise I have
> ksoftirqd at 100% and cpumap/./map at ~60% so I hit CPU speed limit on a
> 10G link. 

For our purpose of testing XDP_REDIRECT code, that you are modifying,
this is what we want.  Where RX CPU/NAPI is the bottleneck, given remote
cpumap CPU have idle cycles (also indicated by the 208,054 sched stats).

> perf top shows

I appreciate getting this perf data.

As we are explicitly dealing with splitting workload across CPUs, it
worth mentioning that perf support displaying and filtering on CPUs.

This perf commands include the CPU number (zero indexed):
  # perf report --sort cpu,comm,dso,symbol --no-children

For this benchmark, to focus, I would reduce this to:
   # perf report --sort cpu,symbol --no-children

The perf tool can also use -C to filter on some CPUs like:

  # perf report --sort cpu,symbol --no-children -C 3,6


> |   18.37%  bpf_prog_4f0ffbb35139c187_cpumap_l4_hash         [k] bpf_prog_4f0ffbb35139c187_cpumap_l4_hash

This bpf_prog_4f0ffbb35139c187_cpumap_l4_hash is running on RX CPU doing 
the load-balancing.

> |   13.15%  [kernel]                                         [k] cpu_map_kthread_run

This runs on remote cpumap CPU (in this case CPU 3).

> |   12.96%  [kernel]                                         [k] ixgbe_poll
> |    6.78%  [kernel]                                         [k] page_frag_free

The page_frag_free call might run on remote cpumap CPU.

> |    5.62%  [kernel]                                         [k] xdp_do_redirect
> 
> for the top 5. Is this something that looks reasonable?

Yes, except I had to guess how the workload was split between CPUs ;-)

Thanks for doing these benchmarks! :-)
--Jesper



