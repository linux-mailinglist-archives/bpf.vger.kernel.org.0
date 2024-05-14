Return-Path: <bpf+bounces-29692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6508C55F0
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 14:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E7C1F2246D
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 12:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE19C4594C;
	Tue, 14 May 2024 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUVlJvbL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3EB2D60A;
	Tue, 14 May 2024 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715689211; cv=none; b=IQhmLH1+5XCagUgA5YPr6IdrRyqlKQdCnqZGBqEYQcSLkgJ03XEsXxIvahtuTpIdE414X+6PK+KQnc0mdnNdYGQFf8wnnCyPe+RMQr8K70fbTUAK1yTqElXrjzJlbrANhUdD2sEH1r3OoLAcuqdEdca12zmKvdTQwCqfXC/DPz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715689211; c=relaxed/simple;
	bh=obSDg9eXO8e+fTU+HDY+zB/5/5ss2adUhKUPzf6dSAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shkGcrbZWE+Rp8qSCsflL6oyu4T9LpClVkoo7OYo2tZ7FdzOZkEn6YhJJ4TZlmXi5VLoT4/KVfWoczSLoWqLfhSchm2uqgovIr/JfRJVyEbdymJVph71TOYc4S6MgaSpMlcZdd2RMPjlg8nLe/EKh3YLz5Lj6iRZ34rqy6qCxCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUVlJvbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384B2C2BD10;
	Tue, 14 May 2024 12:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715689210;
	bh=obSDg9eXO8e+fTU+HDY+zB/5/5ss2adUhKUPzf6dSAQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sUVlJvbLDHFFQVdNDvNLxb6SbKJvUoQxFlHMxlDt9oyJNwsbnjlnHD6sApYm+tGIu
	 Dz0E2qEePDXxhCk90BtwYMe1JvbQY3Kh6t0MmbdC50hTwlNXfgRNEyb0uWdNEmFflo
	 doP2BxC+wAM06Myb8yI2Van73/yQ1Ob+uH21gveMcAuraJAyJCAKXQBIi/g0800AhK
	 aJvw8rb9DFnCxIhphCQHT1ZI6CdbXPDEGvevzNVQAPF1UyDqeIeu6ceYsgYWCfwBwz
	 so/Im7iyOwFeV5+r2gmqkBQBMAhBwjkoeAqfo2oZKZZfiWwN7a+SxBmTUmpuz4nXok
	 ill1zMx8crXUA==
Message-ID: <e4123697-3e6e-4d4a-8b06-f69e1c453225@kernel.org>
Date: Tue, 14 May 2024 14:20:03 +0200
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
 <4949dca0-377a-45b1-a0fd-17bdf5a6ab10@kernel.org>
 <20240514054345.DZkx7fJs@linutronix.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240514054345.DZkx7fJs@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/05/2024 07.43, Sebastian Andrzej Siewior wrote:
> On 2024-05-14 07:07:21 [+0200], Jesper Dangaard Brouer wrote:
>>> pktgen_sample03_burst_single_flow.sh has been used to send packets and
>>> "xdp-bench drop $nic -e" to receive them.
>>>
>>
>> Sorry, but a XDP_DROP test will not activate the code you are modifying.
>> Thus, this test is invalid and doesn't tell us anything about your code
>> changes.
>>
>> The code is modifying the XDP_REDIRECT handling system. Thus, the
>> benchmark test needs to activate this code.
> 
> This was a misunderstanding on my side then. What do you suggest
> instead? Same setup but "redirect" on the same interface instead of
> "drop"?
> 

Redirect is more flexible, but redirect back-out same interface is one
option, but I've often seen this will give issues, because it will
overload the traffic generator (without people realizing this) leading
to false-results. Thus, verify packet generator is sending faster than
results you are collecting. (I use this tool[2] on generator machine, in
another terminal, to see of something funky is happening with ethtool
stats).

To workaround this issue, I've previously redirected to device 'lo'
localhost, which is obviously invalid so packet gets dropped, but I can
see that when we converted from kernel samples/bpf/ to this tool, this
trick/hack is no longer supported.

The xdp-bench[1] tool also provide a number of redirect sub-commands.
E.g. redirect / redirect-cpu / redirect-map / redirect-multi.
Given you also modify CPU-map code, I would say we also need a
'redirect-cpu' test case.

Trick for CPU-map to do early drop on remote CPU:

  # ./xdp-bench redirect-cpu --cpu 3 --remote-action drop ixgbe1

I recommend using Ctrl+\ while running to show more info like CPUs being
used and what kthread consumes.  To catch issues e.g. if you are CPU
redirecting to same CPU as RX happen to run on.

--Jesper

[1] https://github.com/xdp-project/xdp-tools/tree/master/xdp-bench
[2] 
https://github.com/netoptimizer/network-testing/blob/master/bin/ethtool_stats.pl

