Return-Path: <bpf+bounces-16083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D6E7FCB61
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 01:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D82FB217A5
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 00:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D355382;
	Wed, 29 Nov 2023 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RvJBv5Od"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514C11998
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 16:33:51 -0800 (PST)
Message-ID: <3aa60895-c149-4cac-a09a-169abbe4e2f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701218029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sxXhRIzLcviTgoCE4Nf/mM0yPRQhwasWKybayo59xmw=;
	b=RvJBv5OdSR68g/kFrYlTmw0N9T4IqFNj78JkyuHSXHQ0+9WLkTGDEbNOzC/+zMptQ4HTnA
	kFraO4QWA8EXnWT21tsrDYlWWZQURWS1a9Q0PT1zuHuXOzWUmOMARYGR0pUPPgNzsTeG0c
	HvnhcNjsACsWmPJnuxnur3qJedQZI5Y=
Date: Tue, 28 Nov 2023 16:33:42 -0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <438f45f9-4e18-4d7d-bfa5-4a239c4a2304@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/23/23 4:37 AM, Philo Lu wrote:
> Sorry, I forgot to cc the maintainers.
> 
> On 2023/11/23 11:07, Philo Lu wrote:
>> Add 3 sock_ops operators, namely BPF_SOCK_OPS_DATA_SEND_CB,
>> BPF_SOCK_OPS_DATA_RECV_CB, and BPF_SOCK_OPS_DATA_ACKED_CB. A flag
>> BPF_SOCK_OPS_DATA_EVENT_CB_FLAG is provided to minimize the performance
>> impact. The flag must be explicitly set to enable these callbacks.
>>
>> If the flag is enabled, bpf sock_ops program will be called every time a
>> tcp data packet is sent, received, and acked.
>> BPF_SOCK_OPS_DATA_SEND_CB: call bpf after a data packet is sent.
>> BPF_SOCK_OPS_DATA_RECV_CB: call bpf after a data packet is receviced.
>> BPF_SOCK_OPS_DATA_ACKED_CB: call bpf after a valid ack packet is
>> processed (some sent data are ackknowledged).
>>
>> We use these callbacks for fine-grained tcp monitoring, which collects
>> and analyses every tcp request/response event information. The whole
>> system has been described in SIGMOD'18 (see
>> https://dl.acm.org/doi/pdf/10.1145/3183713.3190659 for details). To
>> achieve this with bpf, we require hooks for data events that call
>> sock_ops bpf (1) when any data packet is sent/received/acked, and (2)
>> after critical tcp state variables have been updated (e.g., snd_una,
>> snd_nxt, rcv_nxt). However, existing sock_ops operators cannot meet our
>> requirements.
>>
>> Besides, these hooks also help to debug tcp when data send/recv/acked.

This all sounds like a tracing use case. Why tracepoint is not used instead?

