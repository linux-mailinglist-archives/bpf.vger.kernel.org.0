Return-Path: <bpf+bounces-28825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516918BE43E
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 15:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA2E2887D9
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0BE15FA86;
	Tue,  7 May 2024 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeeRFXLn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC6715E1FD;
	Tue,  7 May 2024 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088471; cv=none; b=LSTSOxD03G+Fq1fucrLo2sbrTq37lTXHWLH27jNhWonYfiKw16ABmmlxH/b9Dv85+kZGYj7nhZoQMub++YzlSL81EDoe61KqcYrzaoefKRDaF6SWnsA/hM/3B00WFvrdo4G48TRES+mU1K3v2L4rDnUWMh1XYZgc+vdmhV83hkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088471; c=relaxed/simple;
	bh=wSGVZ5eyp2TtRxuELZrZ5TmmY6mnjuj8g/MnrMUOfx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9uqbe5UsKOHDcFL/aS653wlfHdqsN5+Gdx+DZBxJamSHcfRu0b/cgfaYnm3t6p0w3N8UQvOogsa3dmMHz9xMclKfpBqi76TTE0sPA2OEcNVCMQarV4R13g5s+pGESpVH8d7XW3kjrkHsEk0RcVHYnLSYVcGY5yCWKFeYDQjZsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeeRFXLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C235C2BBFC;
	Tue,  7 May 2024 13:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715088471;
	bh=wSGVZ5eyp2TtRxuELZrZ5TmmY6mnjuj8g/MnrMUOfx4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZeeRFXLn7sWlW3FsWwj65mF2Jn3XVHaHgT1uSEdBDO7vlmy7e0GhSN5JLRCQPEroj
	 j/tHDw5TMBpcBNvDZ8zmp/9c6hHNE1BO9Fv79dHmLtj/s/E5C2f2J8JNCgG+yV36su
	 AOUWoVXXyUmwXf8eCiEV2Yd3GFwZcS5/22BwxfrdQx+N5m0T5+8d1IxRscP1n6onY8
	 Ms/Gh/AM/4mVSQV+g4beMkLwSNlIsp8lIpEx5PRHxNkM2SwvwfnRBiRtZ2Kt6xAyKO
	 Eu9sXzNVXxyhb8AVq4Og1zuZNgR6QHhAWHUE4X6iNP7lSI64JLk3r41gPt6AHrovKO
	 a9lew8Z0hbj5w==
Message-ID: <93062ce7-8dfa-48a9-a4ad-24c5a3993b41@kernel.org>
Date: Tue, 7 May 2024 15:27:44 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
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
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240507123636.cTnT7TvU@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/05/2024 14.36, Sebastian Andrzej Siewior wrote:
> On 2024-05-06 16:09:47 [-0700], Alexei Starovoitov wrote:
>>>> On PREEMPT_RT the pointer to bpf_net_context is saved task's
>>>> task_struct. On non-PREEMPT_RT builds the pointer saved in a per-CPU
>>>> variable (which is always NODE-local memory). Using always the
>>>> bpf_net_context approach has the advantage that there is almost zero
>>>> differences between PREEMPT_RT and non-PREEMPT_RT builds.
>>>
>>> Did you ever manage to get any performance data to see if this has an
>>> impact?
>>>
>>> [...]
>>>
>>>> +static inline struct bpf_net_context *bpf_net_ctx_get(void)
>>>> +{
>>>> +     struct bpf_net_context *bpf_net_ctx = this_cpu_read(bpf_net_context);
>>>> +
>>>> +     WARN_ON_ONCE(!bpf_net_ctx);
>>>
>>> If we have this WARN...
>>>

When asking for change anyhow...

XDP redirect is an extreme fast-path.

Adding an WARN macro cause adding an 'ud2' instruction that cause CPU
instruction-cache to stop pre-fetching.

For this reason we in include/net/xdp.h have #define XDP_WARN and
function xdp_warn() that lives in net/core/xdp.c.
See how it is used in xdp_update_frame_from_buff().

Described in https://git.kernel.org/torvalds/c/34cc0b338a61
  - 34cc0b338a61 ("xdp: Xdp_frame add member frame_sz and handle in 
convert_to_xdp_frame")



>>>> +static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
>>>> +{
>>>> +     struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
>>>> +
>>>> +     if (!bpf_net_ctx)
>>>> +             return NULL;
>>>
>>> ... do we really need all the NULL checks?
>>
>> Indeed.
>> Let's drop all NULL checks, since they definitely add overhead.
>> I'd also remove ifdef CONFIG_PREEMPT_RT and converge on single implementation:
>> static inline struct bpf_net_context * bpf_net_ctx_get(void)
>> {
>>   return current->bpf_net_context;
>> }
> 
> Okay, let me do that then.

I need/want to echo Toke's request to benchmark these changes.

--Jesper


