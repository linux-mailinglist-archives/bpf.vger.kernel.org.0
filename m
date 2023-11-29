Return-Path: <bpf+bounces-16134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9387FD389
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 11:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E881C20C9C
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 10:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA631947B;
	Wed, 29 Nov 2023 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6081BDB;
	Wed, 29 Nov 2023 02:05:22 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0VxNrNao_1701252319;
Received: from 30.221.128.123(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0VxNrNao_1701252319)
          by smtp.aliyun-inc.com;
          Wed, 29 Nov 2023 18:05:20 +0800
Message-ID: <23c4b05e-1ffe-466f-bcfa-ae345d5bc90d@linux.alibaba.com>
Date: Wed, 29 Nov 2023 18:05:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: add sock_ops callbacks for data
 send/recv/acked events
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
 hengqi@linux.alibaba.com, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, dsahern@kernel.org,
 netdev@vger.kernel.org
References: <20231123030732.111576-1-lulie@linux.alibaba.com>
 <438f45f9-4e18-4d7d-bfa5-4a239c4a2304@linux.alibaba.com>
 <72166ea4-cae7-97e2-88fd-e9bde56523fb@iogearbox.net>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <72166ea4-cae7-97e2-88fd-e9bde56523fb@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2023/11/24 17:47, Daniel Borkmann wrote:
> On 11/23/23 1:37 PM, Philo Lu wrote:
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
>>>
>>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
>>> ---
>>>   include/net/tcp.h        |  9 +++++++++
>>>   include/uapi/linux/bpf.h | 14 +++++++++++++-
>>>   net/ipv4/tcp_input.c     |  4 ++++
>>>   net/ipv4/tcp_output.c    |  2 ++
>>>   4 files changed, 28 insertions(+), 1 deletion(-)
>
> Please also add selftests for the new hooks, and speaking of the latter
> looks like this fails current BPF selftests :
>
> https://github.com/kernel-patches/bpf/actions/runs/6974541866/job/18980491457 
>
>

We will add selftests in the next version. The current selftests fail just
because of the new flag added, and we can also fix this in the next version.

