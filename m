Return-Path: <bpf+bounces-67495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF97B446B6
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 21:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D33B54E1E68
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 19:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF1F272E71;
	Thu,  4 Sep 2025 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G4G7wffP"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43F4202C43
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757015305; cv=none; b=GWg8BPpHn64kEXNT1sbfeOvwc6KS4vOa8lMwwRwGHQQ2VHtXwaG+PEsmP3iiXwaTLoqGSYh7BipWeEKr2vKtlRMHjyfoAhY1XdGHHsME9SWtNqGr8OwagxFRa5plOEX5UOzU+L28FuF6KrGacI9Z1xGqrhbL+VrqcdUz7Dbds2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757015305; c=relaxed/simple;
	bh=nqohl5jgX/PxcHT2z/UszfKDY7KocZbcLutl8HsU95c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Su/9kjVJGBGHtjtb5TGmuIm706eK1f6/J/G107AEn56+sw7agH5ms6aj0DISCSx/z/0EdNK+feQgLYoHGig4vXEBbF3XxsYge2RgCPrlZzIOeh57IZUZ2I3eB7DORR9mbqwFMo2vH9AVqDVpAAR4sHE8jSb87o9NFPlkNSDiMPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G4G7wffP; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <26939fec-b70f-4beb-8895-427db69c38a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757015291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gm8d/i/wGeuAxF6pbQHB1XvUNQ/PHAtfV3G4ujYsf1Q=;
	b=G4G7wffPcnURRryCPhCkm6h4fDpqQVnjamUYpmSQmAw8nOIpepq+fUJA3/h3uFVTWIUq/U
	FW36s5n49w+Wn00y/k8y5+PI080Rf97OpCreSqhBxyZdFyqAkSkK5PjBRGIREYNjIkP87F
	z84G+Ul1E8oS6DYE9bm7jK3Ui1+61lU=
Date: Thu, 4 Sep 2025 12:48:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next/net 5/5] selftest: bpf: Add test for
 SK_BPF_MEMCG_SOCK_ISOLATED.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250829010026.347440-1-kuniyu@google.com>
 <20250829010026.347440-6-kuniyu@google.com>
 <904c1ffb-107e-4f14-89b7-d42ac9a5aa14@linux.dev>
 <CAAVpQUDfQwb2nfGBV8NEONwaBAMVi_5F8+OPFX3=z+W8X9n9ZQ@mail.gmail.com>
 <CAAVpQUBWsVDu07xrQcqGMo4cHRu41zvb5CWuiUdJx9m6A+_2AQ@mail.gmail.com>
 <CAAVpQUCyPPO1dfkkU4Hxz67JFcW6dhSfYnmUp0foNMYua_doyg@mail.gmail.com>
 <40ed29b3-84d7-4812-890d-3676957d503f@linux.dev>
 <CAAVpQUCLpi+6w1SP=FKVaXwdDHQC_P6B1hzzDC5y4brsf3_UnQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAAVpQUCLpi+6w1SP=FKVaXwdDHQC_P6B1hzzDC5y4brsf3_UnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/4/25 9:45 AM, Kuniyuki Iwashima wrote:
> On Wed, Sep 3, 2025 at 10:51 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 9/3/25 10:08 AM, Kuniyuki Iwashima wrote:
>>> On Wed, Sep 3, 2025 at 9:59 AM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>>>>
>>>> On Tue, Sep 2, 2025 at 1:49 PM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>>>>>
>>>>> On Tue, Sep 2, 2025 at 1:26 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>>>
>>>>>> On 8/28/25 6:00 PM, Kuniyuki Iwashima wrote:
>>>>>>> The test does the following for IPv4/IPv6 x TCP/UDP sockets
>>>>>>> with/without BPF prog.
>>>>>>>
>>>>>>>      1. Create socket pairs
>>>>>>>      2. Send a bunch of data that requires more than 256 pages
>>>>>>>      3. Read memory_allocated from the 3rd column in /proc/net/protocols
>>>>>>>      4. Check if unread data is charged to memory_allocated
>>>>>>>
>>>>>>> If BPF prog is attached, memory_allocated should not be changed,
>>>>>>> but we allow a small error (up to 10 pages) in case other processes
>>>>>>> on the host use some amounts of TCP/UDP memory.
>>>>>>>
>>>>>>> At 2., the test actually sends more than 1024 pages because the sysctl
>>>>>>> net.core.mem_pcpu_rsv is 256 is by default, which means 256 pages are
>>>>>>> buffered per cpu before reporting to sk->sk_prot->memory_allocated.
>>>>>>>
>>>>>>>      BUF_SINGLE (1024) * NR_SEND (64) * NR_SOCKETS (64) / 4096
>>>>>>>      = 1024 pages
>>>>>>>
>>>>>>> When I reduced it to 512 pages, the following assertion for the
>>>>>>> non-isolated case got flaky.
>>>>>>>
>>>>>>>      ASSERT_GT(memory_allocated[1], memory_allocated[0] + 256, ...)
>>>>>>>
>>>>>>> Another contributor to slowness is 150ms sleep to make sure 1 RCU
>>>>>>> grace period passes because UDP recv queue is destroyed after that.
>>>>>>
>>>>>> There is a kern_sync_rcu() in testing_helpers.c.
>>>>>
>>>>> Nice helper :)  Will use it.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>      # time ./test_progs -t sk_memcg
>>>>>>>      #370/1   sk_memcg/TCP       :OK
>>>>>>>      #370/2   sk_memcg/UDP       :OK
>>>>>>>      #370/3   sk_memcg/TCPv6     :OK
>>>>>>>      #370/4   sk_memcg/UDPv6     :OK
>>>>>>>      #370     sk_memcg:OK
>>>>>>>      Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
>>>>>>>
>>>>>>>      real       0m1.214s
>>>>>>>      user       0m0.014s
>>>>>>>      sys        0m0.318s
>>>>>>
>>>>>> Thanks. It finished much faster in my setup also comparing with the earlier
>>>>>> revision. However, it is a bit flaky when I run it in a loop:
>>>>>>
>>>>>> check_isolated:FAIL:not isolated unexpected not isolated: actual 861 <= expected 861
>>>>>>
>>>>>> I usually can hit this at ~40-th iteration.
>>>>>
>>>>> Oh.. I tested ~10 times manually but will try in a tight loop.
>>>>
>>>> This didn't reproduce on my QEMU with/without --enable-kvm.
>>>>
>>>> Changing the assert from _GT to _GE will address the very case
>>>> above, but I'm not sure if it's enough.
>>>
>>> I doubled NR_SEND and it was still faster with kern_sync_rcu()
>>> than usleep(), so I'll simply double NR_SEND in v5
>>>
>>> # time ./test_progs -t sk_memcg
>>> ...
>>> Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
>>> real 0m0.483s
>>> user 0m0.010s
>>> sys 0m0.191s
>>>
>>>
>>>>
>>>> Does the bpf CI run tests repeatedly or is this only a manual
>>>> scenario ?
>>
>> I haven't seen bpf CI hit it yet. It is in my manual bash while loop. It should
>> not be dismissed so easily. Some flaky CI tests were eventually reproduced in a
>> loop before and fixed. I kept the bash loop continue this time until grep-ed a
>> "0" from the error output:
>>
>> check_isolated:FAIL:not isolated unexpected not isolated: actual 0 <= expected 256
>>
>> The "long memory_allocated[2]" read from /proc/net/protocols are printed as 0
>> but it is probably actually negative:
>>
>> static inline long
>> proto_memory_allocated(const struct proto *prot)
>> {
>>           return max(0L, atomic_long_read(prot->memory_allocated));
>> }
>>
>> prot->memory_allocated could be negative afaict but printed as 0 in
>> /proc/net/protocols. Even the machine is network quiet after test_progs started,
>> the "prot->memory_allocated" and the "proto->per_cpu_fw_alloc" could be in some
>> random states before the test_progs start.  When I hit "0", it will take some
>> efforts to send some random traffic to the machine to get the test working again. :(
>>
>> Also, after reading the selftest closer, I am not sure I understand why "+ 256".
>> The "proto-> per_cpu_fw_alloc" can start with -255 or +255.
> 
> Actually I didn't expect the random state and assumed the test's
> local communication would complete on the same CPU thus 0~255.
> 
> Do you see the flakiness with net.core.mem_pcpu_rsv=0 ?
> 
> The per-cpu cache is just for performance and I think it's not
> critical for testing and it's fine to set it to 0 during the test.
> 
> 
>>
>> I don't think changing NR_SEND help here. It needs a better way. May be some
>> functions can be traced such that prot->memory_allocated can be read directly?
>> If fentry and fexit of that function has different memory_allocated values, then
>> the test could also become more straight forward.
> 
> Maybe like this ?  Not yet tested, but we could attach a prog to
> sock_init_data() or somewhere else and trigger it by additional socket(2).
> 
>          memory_allocated = sk->sk_prot->memory_allocated;
>          nr_cpu = bpf_num_possible_cpus();
> 
>          for (i = 0; i < nr_cpu; i++) {
>                  per_cpu_fw_alloc =
> bpf_per_cpu_ptr(sk->sk_prot->per_cpu_fw_alloc, i);

I suspect passing per_cpu_fw_alloc to bpf_per_cpu_ptr won't work for now. sk is 
trusted if it is a "tp_btf" but I don't think the verifier recognizes the 
sk->sk_prot is a trusted ptr. I haven't tested it though. If the above does not 
work, try to directly use the global percpu tcp_memory_per_cpu_fw_alloc. Take a 
look at how "bpf_prog_active" is used in test_ksyms_btf.c.

>                  if (per_cpu_fw_alloc)
>                          memory_allocated += *per_cpu_fw_alloc;

Yeah. I think figuring out the true memory_allocated value and use it as the 
before/after value should be good enough. Then no need to worry about the 
initial states. I wonder why proto_memory_allocated() does not do that for 
/proc/net/protocols but I guess it may not be accurate for a lot of cores.

>          }
> 
> per_cpu_fw_alloc might have been added to sk_prot->memory_allocated
> during loop, so it's not 100% accurate still.
> 
> Probably we should set net.core.mem_pcpu_rsv=0 and stress
> memory_allocated before the actual test to drain per_cpu_fw_alloc
> (at least on the testing CPU).
I think the best is if a suitable kernel func can be traced or figure out the 
true memory_allocated value. At least figuring out the true memory_allocated 
seems doable. If nothing of the above works out, mem_pcpu_rsv=0 and 
pre-stress/pre-flush should help by getting the per_cpu_fw_alloc and 
memory_allocated to some certain states before using it in the before/after result.

[ Before re-spinning, need to conclude/resolve the on-going discussion in v5 first ]

