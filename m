Return-Path: <bpf+bounces-62216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0999AAF67E0
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 04:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44EE817CC6B
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 02:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996CC1DDC22;
	Thu,  3 Jul 2025 02:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Y15RNFeb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0DF10E5
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 02:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751509036; cv=none; b=SdaDOnLV05eEEe7w26v0PMfkE1ytFnV3MUyeyT7Kct4IcXw2ZjYnGcxnvPKk8PkQ0oV5rsn/iPZAKe3Dl2JNSUQreqEJxOIEESdExWwYfCnf9qWBOjiAwY/c4bIur4nHuI+M7WHuN4MnvuXELSGFWn2IeTvhaBUJUY76ULo/k/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751509036; c=relaxed/simple;
	bh=OIdDBt4YHQH/Z8F8kDFEE5iY7tyr2nh1TwvItwfIcWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZ77pQFYCNxUFpwim/6w09WJ65jYE8z8e6n8Au2mwc5qqfUvqK/piGEhByiSW7kbHlk3fy/vQWeigOL6JwzCRLXvp3N4Ydz2DtZTkrgjUo7CHfT2tnpZi+02U4NiD/g7G3q+vM4Fvv8Y7rpO0/YhYkUsl7zeXdigimydDeL3KxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Y15RNFeb; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-311e46d38ddso6398000a91.0
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 19:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751509033; x=1752113833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gW8ZgcyW/YE8BVQUnsKXenOjs+L4jlA4xpssC98G1Fs=;
        b=Y15RNFebjSEP0iI1nA09hE250Ckgbl5rVw4jVZ2BGRi+GXc8Ri5NAja2gZwPl1TXlj
         TkFrA22cvJz99pR84yCyePQ842EZJgNcPFeGVGBJYbxEHNhHxr2hKavA8cZpUCg/nTsc
         YwZv1VU5YZQvLz85l1zYxAVbmQZ/5hbT6y/+O060xshU7OZyX8VBOHVrThg2nL7pyXbx
         K/3gukrbB6kihleP4VSur/n2a/xOWgn3+/sQxR2aw6aai8h8oRJugK/uChB6GWECOl8d
         lQ3lL71O9rhxsdY/iztA9Iq1edbDq8l397HTSMWXlXjnscwYtWJZRPyhpCkwRWn7HNb5
         8IPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751509033; x=1752113833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gW8ZgcyW/YE8BVQUnsKXenOjs+L4jlA4xpssC98G1Fs=;
        b=w5AQwgunHEQBTMHRId5dL0AtQ9bOz1CrcSMnIB7nngtybjpV/sOV9P8Xm7P1vP8+CT
         /OViRmUZxvFtiKF3Od2FtINCi8OniWVWZUmILkd0VysID1JQWf0xRT+wAXTWS66vWpuU
         kXE5bO2cowcxPoctz6YJvTal0vBwltbaJrcVBicudFkwPxAwQCyIVWxRQeuAN4Hb9orh
         lRX1J9T0eO35nPoI5LNBgsxyoI+3IdWgIBrWUL2X3NymBJCAdL/g9n/LCRLRt9Dx+IOt
         NxB9d/KtrRg6FKOzzuatw7nd6fVfAN7nv9uG1gnZj6Vb7AHrUapCLA83exM0Ioc9da8e
         rXJA==
X-Forwarded-Encrypted: i=1; AJvYcCWTphdi/wBDmjIveqLCjfUYJT5yD2ZKhOoRtitdjBHXwYRvUo6szXsmHD1qVEdtMtGqTng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9oWKVm/ktvHT4m3Af92fKYQtC7k+hE1w0kXQOmxlno7Xf/7aV
	tALB0aqZ+o0ljXY9AB1PmH8Lw3GoCzYy2tILSYlUhZ9AFXIkYBt2tvxI/w9++bCo9B0=
X-Gm-Gg: ASbGnctvvO4tkqVfFOikzps1m/xifKFyqSmTr+C9LXDR7l8AKd0eqHdlvhf/nX17lAE
	6cDVhEohSW9R9AwsoY1dmOv0311QjauhWgi0FuyTRiGobqPTbgZY7OXRfldBeUzBqqxo3VIhwxB
	nZ+3nSpoFIcock/cAeqLXvktYQrqI0vC5QRETHVN/ycvAqlWwYgXRpyTOZcVGkoh8cZZEjVlPqx
	QiT6UqKnrra1qJkbVfPXUkRVMlVOLJay0K3MaO5dJJ8JfbFgoBUlJ3VTOkv51b1bQgmwAVdwmaQ
	kqwu2DbfwiStj6FEGAxY6hjOXtJrycLYDSbB77UY+zRA93jYW9/YaTeg94SZFKhYyMN32ifCqNp
	dN9izIg==
X-Google-Smtp-Source: AGHT+IEfpWDi9AI5G9opEJ999ceBrirGnidtW9pkIjH17KcFswz2qH/jhRgT+2hI/If6MfyQ++Bs2w==
X-Received: by 2002:a17:90b:3807:b0:312:f88d:25f9 with SMTP id 98e67ed59e1d1-31a9de8b153mr1828746a91.7.1751509033126;
        Wed, 02 Jul 2025 19:17:13 -0700 (PDT)
Received: from [10.3.202.172] ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cd0ba3dsm901644a91.36.2025.07.02.19.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 19:17:12 -0700 (PDT)
Message-ID: <509939c4-2e3e-41a6-888f-cbbf6d4c93cb@bytedance.com>
Date: Thu, 3 Jul 2025 10:17:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch bpf-next v4 4/4] tcp_bpf: improve ingress redirection
 performance with message corking
To: Jakub Sitnicki <jakub@cloudflare.com>,
 Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, john.fastabend@gmail.com,
 zhoufeng.zf@bytedance.com, Amery Hung <amery.hung@bytedance.com>,
 Cong Wang <cong.wang@bytedance.com>
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
 <20250701011201.235392-5-xiyou.wangcong@gmail.com>
 <87ecuyn5x2.fsf@cloudflare.com>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <87ecuyn5x2.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/2/25 8:17 PM, Jakub Sitnicki wrote:
> On Mon, Jun 30, 2025 at 06:12 PM -07, Cong Wang wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> The TCP_BPF ingress redirection path currently lacks the message corking
>> mechanism found in standard TCP. This causes the sender to wake up the
>> receiver for every message, even when messages are small, resulting in
>> reduced throughput compared to regular TCP in certain scenarios.
> 
> I'm curious what scenarios are you referring to? Is it send-to-local or
> ingress-to-local? [1]
> 

Thanks for your attention and detailed reviewing!
We are referring to "send-to-local" here.

> If the sender is emitting small messages, that's probably intended -
> that is they likely want to get the message across as soon as possible,
> because They must have disabled the Nagle algo (set TCP_NODELAY) to do
> that.
> 
> Otherwise, you get small segment merging on the sender side by default.
> And if MTU is a limiting factor, you should also be getting batching
> from GRO.
> 
> What I'm getting at is that I don't quite follow why you don't see
> sufficient batching before the sockmap redirect today?
> 

IMHO,

In “send-to-local” case, both sender and receiver sockets are added to
the sockmap. Their protocol is modified from TCP to eBPF_TCP, so that
sendmsg will invoke “tcp_bpf_sendmsg” instead of “tcp_sendmsg”. In this
case, the whole process is building a skmsg and moving it to the
receiver socket’s queue immediately. In this process, there is no
sk_buff generated, and we cannot benefit from TCP stack optimizations.
As a result, small segments will not be merged by default, that's the
reason why I am implementing skmsg coalescing here.

>> This change introduces a kernel worker-based intermediate layer to provide
>> automatic message corking for TCP_BPF. While this adds a slight latency
>> overhead, it significantly improves overall throughput by reducing
>> unnecessary wake-ups and reducing the sock lock contention.
> 
> "Slight" for a +5% increase in latency is an understatement :-)
> 
> IDK about this being always on for every socket. For send-to-local
> [1], sk_msg redirs can be viewed as a form of IPC, where latency
> matters.
> 
> I do understand that you're trying to optimize for bulk-transfer
> workloads, but please consider also request-response workloads.
> 
> [1] https://github.com/jsitnicki/kubecon-2024-sockmap/blob/main/cheatsheet-sockmap-redirect.png
> 

Totally understand that request-response workloads are also very
important.

Here are my thoughts:

I had an idea before: when the user sets NO_DELAY, we could follow the
original code path. However, I'm concerned about a specific scenario: if
a user sends part of a message and then sets NO_DELAY to send another
message, it's possible that messages sent via kworker haven't yet
reached the ingress_msg (maybe due to delayed kworker scheduling), while
the messages sent with NO_DELAY have already arrived. This could disrupt
the order. Since there's no TCP packet formation or retransmission
mechanism in this process, once the order is disrupted, it stays that
way.

As a result, I propose,

- When the user sets NO_DELAY, introduce a wait (I haven't determined
the exact location yet; maybe in tcp_bpf_sendmsg) to ensure all messages
from kworker are sent before proceeding. Then follow the original path
for packet transmission.

- When the user switches back from NO_DELAY to DELAY, it's less of an 
issue. We can simply follow our current code path.

If 5% degradation is not a blocker for this patchset, and the solution
looks good to you, we will do it in the next patchset.

>> Reviewed-by: Amery Hung <amery.hung@bytedance.com>
>> Co-developed-by: Cong Wang <cong.wang@bytedance.com>
>> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> ---


