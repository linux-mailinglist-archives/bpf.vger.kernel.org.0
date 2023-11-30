Return-Path: <bpf+bounces-16295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B017FF926
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 19:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BE81C2104F
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 18:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF07C5916D;
	Thu, 30 Nov 2023 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AtBJI9Bu"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75EBD6C
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 10:13:49 -0800 (PST)
Message-ID: <ab31efa1-d6b9-499d-a735-0852ed036a2f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701368027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=58Q6JcRzCXrW3RrlsjnmRKm8ghiXbb5Xj7YAxJh8ddA=;
	b=AtBJI9BuCfKzfI5R9tI+Kwev5Bhl1Io5lMwCd6STjFUeCeZhabgbsxQb75w8hvz9j5cQAY
	cWDhainP961H9WYDZRAX1flA6b7azEidy2s357rMlEt8nZvCFrJx0AERt+N2peYPSakG0l
	ll7v67yTCS0osNPGmdspI+FG4s7AgE0=
Date: Thu, 30 Nov 2023 10:13:07 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: add sock_ops callbacks for data
 send/recv/acked events
Content-Language: en-US
To: Philo Lu <lulie@linux.alibaba.com>
Cc: xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
 hengqi@linux.alibaba.com, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, dsahern@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20231123030732.111576-1-lulie@linux.alibaba.com>
 <438f45f9-4e18-4d7d-bfa5-4a239c4a2304@linux.alibaba.com>
 <3aa60895-c149-4cac-a09a-169abbe4e2f5@linux.dev>
 <1bcd4871-7403-41d9-8ae6-4df4878d9275@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <1bcd4871-7403-41d9-8ae6-4df4878d9275@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/29/23 2:05 AM, Philo Lu wrote:
> 
> On 2023/11/29 08:33, Martin KaFai Lau wrote:
>> On 11/23/23 4:37 AM, Philo Lu wrote:
>>> Sorry, I forgot to cc the maintainers.
>>>
>>> On 2023/11/23 11:07, Philo Lu wrote:
>>>> Add 3 sock_ops operators, namely BPF_SOCK_OPS_DATA_SEND_CB,
>>>> BPF_SOCK_OPS_DATA_RECV_CB, and BPF_SOCK_OPS_DATA_ACKED_CB. A flag
>>>> BPF_SOCK_OPS_DATA_EVENT_CB_FLAG is provided to minimize the performance
>>>> impact. The flag must be explicitly set to enable these callbacks.
>>>>
>>>> If the flag is enabled, bpf sock_ops program will be called every time a
>>>> tcp data packet is sent, received, and acked.
>>>> BPF_SOCK_OPS_DATA_SEND_CB: call bpf after a data packet is sent.
>>>> BPF_SOCK_OPS_DATA_RECV_CB: call bpf after a data packet is receviced.
>>>> BPF_SOCK_OPS_DATA_ACKED_CB: call bpf after a valid ack packet is
>>>> processed (some sent data are ackknowledged).
>>>>
>>>> We use these callbacks for fine-grained tcp monitoring, which collects
>>>> and analyses every tcp request/response event information. The whole
>>>> system has been described in SIGMOD'18 (see
>>>> https://dl.acm.org/doi/pdf/10.1145/3183713.3190659 for details). To
>>>> achieve this with bpf, we require hooks for data events that call
>>>> sock_ops bpf (1) when any data packet is sent/received/acked, and (2)
>>>> after critical tcp state variables have been updated (e.g., snd_una,
>>>> snd_nxt, rcv_nxt). However, existing sock_ops operators cannot meet our
>>>> requirements.
>>>>
>>>> Besides, these hooks also help to debug tcp when data send/recv/acked.
>>
>> This all sounds like a tracing use case. Why tracepoint is not used instead?
> 
> Yes, our use case is pure tracing. We add hooks to sockops because we also use
> other ops like BPF_SOCK_OPS_STATE_CB. Thus, sockops seems a natural solution
> for us.

There is also an existing trace_inet_sock_set_state() tracepoint for tracking 
the state change. There are other existing tracepoints in 
include/trace/events/tcp.h for tcp perf monitoring/analysis purpose (e.g. 
trace_tcp_retransmit_skb). All it needs is read-only access to sk and the 
purpose is for tcp perf monitoring/analysis. If a hook is needed here 
(cgroup-bpf or tracepoint), I would think it is better to supplement the 
existing tcp tracepoints which were also added to do tcp monitoring.

I suspect the fexit bpf prog may also work because the fexit bpf prog is called 
after the traced kernel function is called. However, the kernel functions may 
get inlined and the tracepoint will still be needed. May be the netdev 
maintainer can chime in here regarding the tracepoint additions.

> 
> We can also use tracepoint (with sockops) instead. So we think which to use
> depends on your opinions. Many thanks.
> 
> 


