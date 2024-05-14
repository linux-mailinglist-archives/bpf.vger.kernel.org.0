Return-Path: <bpf+bounces-29686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC08C8C4BD7
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 07:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8401F22FBF
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 05:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DBA175A5;
	Tue, 14 May 2024 05:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFqzZzY5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785B1125AC;
	Tue, 14 May 2024 05:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715663248; cv=none; b=qFkVt4XD8ooajPVBLqIDc5YNYgCmMFN0SQj6AfqBfsLagUWeqgg7W2KcEwYUUQDyGKdzbmkfwX0DtIB6uNHzeHtBkyHsPHw3Iofax+6TT7AzqPx1PxsJLYlOUvqiGRxfU0ESTM4AWoFgmaM3ABtXN1gRzhU+7lCmpFZkYUGwX1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715663248; c=relaxed/simple;
	bh=x7gcYCI6zg5BeEO0luHV8XtsAQCN7ZUeWGlfdaEHzWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1Rl3figGh0t53VnOO4Y8E4LkFznrfaFFqNLJI7IwGCnQjZv5Vr49YQejzlw4/mDP97+V5h3DRtc6727vUEZdntW0S3Ehfo8g3fP11iYixI61SmjTPJalwgk1DDNLMZ1Z0YxHhBwpPA+rP7fleSNVOun/PV07nxzs0K+15A3urs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFqzZzY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E784DC2BD10;
	Tue, 14 May 2024 05:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715663248;
	bh=x7gcYCI6zg5BeEO0luHV8XtsAQCN7ZUeWGlfdaEHzWc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oFqzZzY52lmQF+bcteQFS12LctlsVlKgDmgV8AuMqGnU0Nayi2+VbePt3B7KE5hFJ
	 EZCueac1uRYtr2yq7RDc/PhQXQNEiBOc2C00TrIMhbPf4wuivxY8Gm2C/NFjnm9Y7E
	 vnZJBQ8Xe9WBR+kxgXG4YYvQoL/HkGtB1HCIQ194V3Ur5o0orKgoOqSTc85w+HezUx
	 iJSkznecvRQClXvKp5DfaJdIo6iG4Uwx8DabgwP3zeoKUwKLDNpYnecl9aIwRJEE+T
	 QhZ76R/ygwv1ILhLEIrsTUNmjvw1khqZdyspxsAzoSEuFrCxKxLyFyPULC4uocjKHR
	 Uo0b4DFOv5jzQ==
Message-ID: <4949dca0-377a-45b1-a0fd-17bdf5a6ab10@kernel.org>
Date: Tue, 14 May 2024 07:07:21 +0200
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
 Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
 <20240503182957.1042122-15-bigeasy@linutronix.de> <87y18mohhp.fsf@toke.dk>
 <CAADnVQJkiwaYXUo+LyKoV96VFFCFL0VY5Jgpuv_0oypksrnciA@mail.gmail.com>
 <20240507123636.cTnT7TvU@linutronix.de>
 <93062ce7-8dfa-48a9-a4ad-24c5a3993b41@kernel.org>
 <20240510162121.f-tvqcyf@linutronix.de>
 <20240510162214.zNWRKgFU@linutronix.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240510162214.zNWRKgFU@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/05/2024 18.22, Sebastian Andrzej Siewior wrote:
> On 2024-05-10 18:21:24 [+0200], To Jesper Dangaard Brouer wrote:
>> The XDP redirect process is two staged:
> …
> On 2024-05-07 15:27:44 [+0200], Jesper Dangaard Brouer wrote:
>>
>> I need/want to echo Toke's request to benchmark these changes.
> 
> I have:
> boxA: ixgbe
> boxB: i40e
> 
> Both are bigger NUMA boxes. I have to patch ixgbe to ignore the 64CPU
> limit and I boot box with only 64CPUs. The IOMMU has been disabled on
> both box as well as CPU mitigations. The link is 10G.
> 
> The base for testing I have is commit a17ef9e6c2c1c ("net_sched:
> sch_sfq: annotate data-races around q->perturb_period") which I used to
> rebase my series on top of.
> 
> pktgen_sample03_burst_single_flow.sh has been used to send packets and
> "xdp-bench drop $nic -e" to receive them.
> 

Sorry, but a XDP_DROP test will not activate the code you are modifying.
Thus, this test is invalid and doesn't tell us anything about your code 
changes.

The code is modifying the XDP_REDIRECT handling system. Thus, the
benchmark test needs to activate this code.


> baseline
> ~~~~~~~~
> boxB -> boxA | gov performance
> -t2 (to pktgen)
> | receive total 14,854,233 pkt/s        14,854,233 drop/s                0 error/s
> 
> -t1 (to pktgen)
> | receive total 10,642,895 pkt/s        10,642,895 drop/s                0 error/s
> 
> 
> boxB -> boxA | gov powersave
> -t2 (to pktgen)
>    receive total 10,196,085 pkt/s        10,196,085 drop/s                0 error/s
>    receive total 10,187,254 pkt/s        10,187,254 drop/s                0 error/s
>    receive total 10,553,298 pkt/s        10,553,298 drop/s                0 error/s
> 
> -t1
>    receive total 10,427,732 pkt/s        10,427,732 drop/s                0 error/s
> 
> ======
> boxA -> boxB (-t1) gov performance
> performace:
>    receive total 13,171,962 pkt/s        13,171,962 drop/s                0 error/s
>    receive total 13,368,344 pkt/s        13,368,344 drop/s                0 error/s
> 
> powersave:
>    receive total 13,343,136 pkt/s        13,343,136 drop/s                0 error/s
>    receive total 13,220,326 pkt/s        13,220,326 drop/s                0 error/s
> 
> (I the CPU governor had no impact, just noise)
> 
> The series applied (with updated 14/15)
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> boxB -> boxA | gov performance
> -t2:
>    receive total  14,880,199 pkt/s        14,880,199 drop/s                0 error/s
> 
> -t1:
>    receive total  10,769,082 pkt/s        10,769,082 drop/s                0 error/s
> 
> boxB -> boxA | gov powersave
> -t2:
>   receive total   11,163,323 pkt/s        11,163,323 drop/s                0 error/s
> 
> -t1:
>   receive total   10,756,515 pkt/s        10,756,515 drop/s                0 error/s
> 
> boxA -> boxB | gov perfomance
> 
>   receive total  13,395,919 pkt/s        13,395,919 drop/s                0 error/s
> 
> boxA -> boxB | gov perfomance
>   receive total  13,290,527 pkt/s        13,290,527 drop/s                0 error/s
> 
> 
> Based on my numbers, there is just noise.  BoxA hit the CPU limit during
> receive while lowering the CPU-freq. BoxB seems to be unaffected by
> lowing CPU frequency during receive.
> 
> I can't comment on anything >10G due to HW limits.
> 
> Sebastian

