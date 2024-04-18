Return-Path: <bpf+bounces-27105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B678A9173
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 05:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D31C5B21F00
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 03:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3683F4F88E;
	Thu, 18 Apr 2024 03:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YDgX+imS"
X-Original-To: bpf@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161863D5;
	Thu, 18 Apr 2024 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713409874; cv=none; b=VzdR3cASjXT6yybkBOsrvirymVnprdBHuQg8phVWbprFNnUuBHGY7WlRVXGMFJR0JFLQK26k3BYkJB+Qgb48pkSmhCVsHCvTS/s8DaWhL+bWbTxCIijSRdo3F/qmluYVtBGbfnO5ieI+0XjuuczmAO7wEUdRuLEvoZxOn1yaFUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713409874; c=relaxed/simple;
	bh=49YA5bwd5aaJqE1+rtKqUQCOd/fOnn8C+82p+N5lIsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+TCxC5Q/Ob2D0SRigP/9SwiaqNASAjsaugE2BpCsDsft4gtqLnv1FpVzAzk/4JkkmoDqNSF29EPC503lwBwu46pZqahBiiKuplnlzZDxchYl0Lei9eQIrTTZl+Fh8dmcPLQgdEniderRKezDq10sglpswoHqe+qd7mWY0z4aHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YDgX+imS; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713409868; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kVF5Qk+qvSlVZp9kWvRyRWHVK/DL9TO3Qw2mqldmm6c=;
	b=YDgX+imS9B/SUPRtzReSn0sNdi/hnboWE6ZNc0MdKLLofODLoNhUu0T5TNqpYoGm2tN+JEYbVJVuLIUx8pJtJmQeo6qeVxTdp07IBfv6Ah1FGNaIru4cS3Gpyd9AoHxLrPsQnNNj7x3OdGn3VEwPifYIitkifIQLRm/NHyKgvLY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0W4n0ZmI_1713409866;
Received: from 30.221.128.105(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W4n0ZmI_1713409866)
          by smtp.aliyun-inc.com;
          Thu, 18 Apr 2024 11:11:07 +0800
Message-ID: <b312ee27-50a2-4eb0-81a0-731e56a9a18e@linux.alibaba.com>
Date: Thu, 18 Apr 2024 11:11:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: add sacked flag in BPF_SOCK_OPS_RETRANS_CB
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Eric Dumazet <edumazet@google.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, dsahern@kernel.org,
 laoar.shao@gmail.com, xuanzhuo@linux.alibaba.com, fred.cc@alibaba-inc.com
References: <20240417124622.35333-1-lulie@linux.alibaba.com>
 <CANn89iLWMhAOq0R7N3utrXdro_zTmp=9cs8a7_eviNcTK-_5+w@mail.gmail.com>
 <152f00e2-8f60-4f39-8ab4-fdab1b0bc01a@linux.dev>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <152f00e2-8f60-4f39-8ab4-fdab1b0bc01a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/18 06:48, Martin KaFai Lau wrote:
> On 4/17/24 6:11 AM, Eric Dumazet wrote:
>> On Wed, Apr 17, 2024 at 2:46 PM Philo Lu <lulie@linux.alibaba.com> wrote:
>>>
>>> Add TCP_SKB_CB(skb)->sacked as the 4th arg of sockops passed to bpf
>>> program. Then we can get the retransmission efficiency by counting skbs
>>> w/ and w/o TCPCB_EVER_RETRANS mark. And for this purpose, sacked
>>> updating is moved after the BPF_SOCK_OPS_RETRANS_CB hook.
>>>
>>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
>>
>> This might be a naive question, but how the bpf program know what is 
>> the meaning
>> of each bit ?
>>
>> Are they exposed already, and how future changes in TCP stack could
>> break old bpf programs ?
>>
>> #define TCPCB_SACKED_ACKED 0x01 /* SKB ACK'd by a SACK block */
>> #define TCPCB_SACKED_RETRANS 0x02 /* SKB retransmitted */
>> #define TCPCB_LOST 0x04 /* SKB is lost */
>> #define TCPCB_TAGBITS 0x07 /* All tag bits */
>> #define TCPCB_REPAIRED 0x10 /* SKB repaired (no skb_mstamp_ns) */
>> #define TCPCB_EVER_RETRANS 0x80 /* Ever retransmitted frame */
>> #define TCPCB_RETRANS (TCPCB_SACKED_RETRANS|TCPCB_EVER_RETRANS| \
>> TCPCB_REPAIRED)
> 
> I think it is the best to use the trace_tcp_retransmit_skb() tracepoint 
> instead.
> 
> iiuc the use case, moving the "TCP_SKB_CB(skb)->sacked |= 
> TCPCB_EVER_RETRANS;" after the tracepoint should have similar effect.

Good idea. This does also achieve this goal. So it would be like:
```
-TCP_SKB_CB(skb)->sacked |= TCPCB_EVER_RETRANS;

  if (likely(!err)) {
  	trace_tcp_retransmit_skb(sk, skb);
  } else if (err != -EBUSY) {
  	NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPRETRANSFAIL, segs);
  }

+TCP_SKB_CB(skb)->sacked |= TCPCB_EVER_RETRANS;
  return err;
```

> 
> If the TCPCB_* is moved to a enum, it will be included in the 
> "vmlinux.h" that the bpf prog can use and no need to expose them in uapi.

This is okay for me. Though I'm not sure if moving to enum brings any 
unexpected side effect?

BTW, need we concern about those that use trace_tcp_retransmit_skb to 
check TCPCB_EVER_RETRANS before?

Thanks.

