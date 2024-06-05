Return-Path: <bpf+bounces-31433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 138498FCC5E
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 14:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16851F21947
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 12:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EB11991CF;
	Wed,  5 Jun 2024 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihLNEHWW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828E1991BF;
	Wed,  5 Jun 2024 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588514; cv=none; b=U1Oz7Ycq87rLASIujOi+OcpAPjyrEsGZYx5bjJj1dSMkCsSoV60t3YSGY+RCg6RyBumWBa3UHEqziK4DfEjsITYyzhtBBZfd61aFX66grOrJMHXskDlrA1PNCpzIyLmSzCofK3CcqJq3y8G+CWAPxJORn4KLNnP/iwh4jJ7YQjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588514; c=relaxed/simple;
	bh=vxNta2dXvygcPDnAOyNlvvdZasfoIV/rkHu+VVyVUxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDM9VM8WUjB+KnCF+j5zdAmMyeRL7m6uzg2PaAvDuDWyKoGYNxE8TV3XIMODk0p+hdl6+rVcc9DSYD2c2xtY6fdapDSc+sxHs6c1SAobB8cxjJSSbqIzsp3m7jVCBWqQ38Z7FycNX+00JOu1xmITwoqCiBl2a16/sve+K+NgR2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihLNEHWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04B2C32781;
	Wed,  5 Jun 2024 11:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588513;
	bh=vxNta2dXvygcPDnAOyNlvvdZasfoIV/rkHu+VVyVUxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ihLNEHWWeyMq3gPlOBgaF5Yr8+BSQTQupEqqMvROYRzEKQYZrf7equbZ5cgHjtHf3
	 /bH29+vNWl3dLW4GrR3Au3z/zqxMQ1A/tjbEhu//vqflP3X+z7tpadFTQ8mQiIte3S
	 wwmXgTo/zGr2YixlSlgp7uQxTi6Z6DcKm9ywvQg6PUlUCob/YGOaJhyABcE5kEqR51
	 +jkebJYJU436NDgXyM+8dwJrHtOQ4fsHq3IVo3kwIl7NR/nign0GHFU4XjiLAXHgWk
	 ogIs6rqg2A9MMkMglaRI/1A3vub6C53MZJ+1T7CrrKNoFTWB25/9z/nYLakhK4ZYQ0
	 bpDJ9iE7wqFfw==
Message-ID: <c71e0891-a187-4ad9-b554-8f28c15984fd@kernel.org>
Date: Wed, 5 Jun 2024 13:55:07 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
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
 Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
References: <20240529162927.403425-1-bigeasy@linutronix.de>
 <20240529162927.403425-15-bigeasy@linutronix.de> <87y17sfey6.fsf@toke.dk>
 <20240531103807.QjzIOAOh@linutronix.de>
 <9afab1bb-43d6-4f17-b45d-7f4569d9db70@kernel.org>
 <20240605104128.Nn9Cp0CB@linutronix.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240605104128.Nn9Cp0CB@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/06/2024 12.41, Sebastian Andrzej Siewior wrote:
> On 2024-06-05 12:28:08 [+0200], Jesper Dangaard Brouer wrote:
>>
>> Hmm, but how will this affect performance?
> 
> As I wrote in the changelog for v4, I haven't notice a difference. I
> tried to move bpf_net_ctx_set() from cpu_map_bpf_prog_run() to
> cpu_map_kthread_run() to have this assignment only once and I didn't see
> a difference/ I couldn't tell the two kernels apart.
> 

This would be my preferred solution.
See below, your benchmark wasn't testing/measuring this changed code on
remote CPU running kthread.

> This is what I have been using for testing
> 
> | xdp-bench redirect-cpu --cpu 3 --remote-action drop eth1 -e
> 
> in case I was changing the wrong part…

As we saw earlier (with your hardware setup) this test is benchmarking
the RX-NAPI XDP-redirect code.  As the cpumap "remote" CPUs kthread had
idle cycles.

The extra clearing bpf_net_ctx_set() for each packet in the kthread on
the remote CPU will not change the benchmark numbers (as it have idle
cycles).

Looking closer at kernel code + your patch, I see that this clearing
isn't done for each packet, but per bulk (up-to CPUMAP_BATCH 8).  Given
that, I'm more okay with this change.

--Jesper



