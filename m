Return-Path: <bpf+bounces-16135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8277FD38D
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 11:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BAA3B2153B
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 10:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C7E19BC2;
	Wed, 29 Nov 2023 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A271AD;
	Wed, 29 Nov 2023 02:05:32 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0VxNrNbH_1701252320;
Received: from 30.221.128.123(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0VxNrNbH_1701252320)
          by smtp.aliyun-inc.com;
          Wed, 29 Nov 2023 18:05:30 +0800
Message-ID: <1bcd4871-7403-41d9-8ae6-4df4878d9275@linux.alibaba.com>
Date: Wed, 29 Nov 2023 18:05:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: add sock_ops callbacks for data
 send/recv/acked events
To: Martin KaFai Lau <martin.lau@linux.dev>
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
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <3aa60895-c149-4cac-a09a-169abbe4e2f5@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2023/11/29 08:33, Martin KaFai Lau wrote:
> On 11/23/23 4:37 AM, Philo Lu wrote:
>> Sorry, I forgot to cc the maintainers.
>>
>> On 2023/11/23 11:07, Philo Lu wrote:
>>> Add 3 sock_ops operators, namely BPF_SOCK_OPS_DATA_SEND_CB,
>>> BPF_SOCK_OPS_DATA_RECV_CB, and BPF_SOCK_OPS_DATA_ACKED_CB. A flag
>>> BPF_SOCK_OPS_DATA_EVENT_CB_FLAG is provided to minimize the performance
>>> impact. The flag must be explicitly set to enable these callbacks.
>>>
>>> If the flag is enabled, bpf sock_ops program will be called every 
>>> time a
>>> tcp data packet is sent, received, and acked.
>>> BPF_SOCK_OPS_DATA_SEND_CB: call bpf after a data packet is sent.
>>> BPF_SOCK_OPS_DATA_RECV_CB: call bpf after a data packet is receviced.
>>> BPF_SOCK_OPS_DATA_ACKED_CB: call bpf after a valid ack packet is
>>> processed (some sent data are ackknowledged).
>>>
>>> We use these callbacks for fine-grained tcp monitoring, which collects
>>> and analyses every tcp request/response event information. The whole
>>> system has been described in SIGMOD'18 (see
>>> https://dl.acm.org/doi/pdf/10.1145/3183713.3190659 for details). To
>>> achieve this with bpf, we require hooks for data events that call
>>> sock_ops bpf (1) when any data packet is sent/received/acked, and (2)
>>> after critical tcp state variables have been updated (e.g., snd_una,
>>> snd_nxt, rcv_nxt). However, existing sock_ops operators cannot meet our
>>> requirements.
>>>
>>> Besides, these hooks also help to debug tcp when data send/recv/acked.
>
> This all sounds like a tracing use case. Why tracepoint is not used 
> instead?

Yes, our use case is pure tracing. We add hooks to sockops because we 
also use
other ops like BPF_SOCK_OPS_STATE_CB. Thus, sockops seems a natural solution
for us.

We can also use tracepoint (with sockops) instead. So we think which to use
depends on your opinions. Many thanks.



