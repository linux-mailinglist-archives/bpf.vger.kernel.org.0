Return-Path: <bpf+bounces-67391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B1FB431CC
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 07:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBCF566F57
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 05:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A11F23B605;
	Thu,  4 Sep 2025 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WkKozhHs"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF59A18E377
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 05:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756965070; cv=none; b=XDpFF4m7Va6QuR/Rmc0x+54X5w0f1/JJ0ex8DJjTf9Sx4DiAjE+uodKbbZgcGzOfRKotCaKpeXTVboiT1MvMM7rgVMdd6REchHUgg0vG8dRcf/ciGFM2wtcILoU3m+KBXHY0M1Ihb7BTDHgNf/eYdHdRBjWG3Q7iFs91YA6php8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756965070; c=relaxed/simple;
	bh=OOF7HixicOsFQMfTDwMe/QQcFadtCg6wUvl0gIhKc80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enNj6mA/X4VC3tl+ZndHk2WYTucKm/8jLGrUjbPJGHmEUFscADmDkLBrV3rvIzvcOp+M7Fz4/hYht7q6bSxL/+3Lz+J4Le6luQjlAffeFshMItaYbg7Psa4Mn8prpFn5+TYK65BefltYAQ/JW/NMfHSjXC5Vm+IQsiP59ncI0to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WkKozhHs; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <40ed29b3-84d7-4812-890d-3676957d503f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756965062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMFKcVml4hRd8ozRNDMakWh5QQ2N0I2r7+WMED7nTfE=;
	b=WkKozhHsPeZ+Mee6RbPK4YR9MscoVm+sEWE3ryl4LVQjoYNYH0cxBC8y8K5SQVVeBaYF3b
	zdr+/mON4dT9CJuwrZD19mspbI96yeRfMjyitKPHeGyROHW2U8Hr9/WebvoLMd95whsUCb
	jrQgpZX1uGxrrnsCiOG3mm6EhdDFugM=
Date: Wed, 3 Sep 2025 22:50:53 -0700
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAAVpQUCyPPO1dfkkU4Hxz67JFcW6dhSfYnmUp0foNMYua_doyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/3/25 10:08 AM, Kuniyuki Iwashima wrote:
> On Wed, Sep 3, 2025 at 9:59 AM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>>
>> On Tue, Sep 2, 2025 at 1:49 PM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>>>
>>> On Tue, Sep 2, 2025 at 1:26 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> On 8/28/25 6:00 PM, Kuniyuki Iwashima wrote:
>>>>> The test does the following for IPv4/IPv6 x TCP/UDP sockets
>>>>> with/without BPF prog.
>>>>>
>>>>>     1. Create socket pairs
>>>>>     2. Send a bunch of data that requires more than 256 pages
>>>>>     3. Read memory_allocated from the 3rd column in /proc/net/protocols
>>>>>     4. Check if unread data is charged to memory_allocated
>>>>>
>>>>> If BPF prog is attached, memory_allocated should not be changed,
>>>>> but we allow a small error (up to 10 pages) in case other processes
>>>>> on the host use some amounts of TCP/UDP memory.
>>>>>
>>>>> At 2., the test actually sends more than 1024 pages because the sysctl
>>>>> net.core.mem_pcpu_rsv is 256 is by default, which means 256 pages are
>>>>> buffered per cpu before reporting to sk->sk_prot->memory_allocated.
>>>>>
>>>>>     BUF_SINGLE (1024) * NR_SEND (64) * NR_SOCKETS (64) / 4096
>>>>>     = 1024 pages
>>>>>
>>>>> When I reduced it to 512 pages, the following assertion for the
>>>>> non-isolated case got flaky.
>>>>>
>>>>>     ASSERT_GT(memory_allocated[1], memory_allocated[0] + 256, ...)
>>>>>
>>>>> Another contributor to slowness is 150ms sleep to make sure 1 RCU
>>>>> grace period passes because UDP recv queue is destroyed after that.
>>>>
>>>> There is a kern_sync_rcu() in testing_helpers.c.
>>>
>>> Nice helper :)  Will use it.
>>>
>>>>
>>>>>
>>>>>     # time ./test_progs -t sk_memcg
>>>>>     #370/1   sk_memcg/TCP       :OK
>>>>>     #370/2   sk_memcg/UDP       :OK
>>>>>     #370/3   sk_memcg/TCPv6     :OK
>>>>>     #370/4   sk_memcg/UDPv6     :OK
>>>>>     #370     sk_memcg:OK
>>>>>     Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
>>>>>
>>>>>     real       0m1.214s
>>>>>     user       0m0.014s
>>>>>     sys        0m0.318s
>>>>
>>>> Thanks. It finished much faster in my setup also comparing with the earlier
>>>> revision. However, it is a bit flaky when I run it in a loop:
>>>>
>>>> check_isolated:FAIL:not isolated unexpected not isolated: actual 861 <= expected 861
>>>>
>>>> I usually can hit this at ~40-th iteration.
>>>
>>> Oh.. I tested ~10 times manually but will try in a tight loop.
>>
>> This didn't reproduce on my QEMU with/without --enable-kvm.
>>
>> Changing the assert from _GT to _GE will address the very case
>> above, but I'm not sure if it's enough.
> 
> I doubled NR_SEND and it was still faster with kern_sync_rcu()
> than usleep(), so I'll simply double NR_SEND in v5
> 
> # time ./test_progs -t sk_memcg
> ...
> Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
> real 0m0.483s
> user 0m0.010s
> sys 0m0.191s
> 
> 
>>
>> Does the bpf CI run tests repeatedly or is this only a manual
>> scenario ?

I haven't seen bpf CI hit it yet. It is in my manual bash while loop. It should 
not be dismissed so easily. Some flaky CI tests were eventually reproduced in a 
loop before and fixed. I kept the bash loop continue this time until grep-ed a 
"0" from the error output:

check_isolated:FAIL:not isolated unexpected not isolated: actual 0 <= expected 256

The "long memory_allocated[2]" read from /proc/net/protocols are printed as 0 
but it is probably actually negative:

static inline long
proto_memory_allocated(const struct proto *prot)
{
         return max(0L, atomic_long_read(prot->memory_allocated));
}

prot->memory_allocated could be negative afaict but printed as 0 in 
/proc/net/protocols. Even the machine is network quiet after test_progs started, 
the "prot->memory_allocated" and the "proto->per_cpu_fw_alloc" could be in some 
random states before the test_progs start.  When I hit "0", it will take some 
efforts to send some random traffic to the machine to get the test working again. :(

Also, after reading the selftest closer, I am not sure I understand why "+ 256". 
The "proto->per_cpu_fw_alloc" can start with -255 or +255.

I don't think changing NR_SEND help here. It needs a better way. May be some 
functions can be traced such that prot->memory_allocated can be read directly? 
If fentry and fexit of that function has different memory_allocated values, then 
the test could also become more straight forward.



