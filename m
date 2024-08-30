Return-Path: <bpf+bounces-38496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A329653F3
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 02:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F131C21D52
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 00:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8714623B1;
	Fri, 30 Aug 2024 00:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NJLr497Q"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6EC4C7E
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724977222; cv=none; b=nMQcnmp44Ch8vqd/s4fSlgywUOlDUGuWtBsFJ82S/St9jqLxhnhahyiOnHxuFvZ4YzGfNxXzUq5cEYtvkSSMc2+8oNYIn0c1pQZir9mAODsme8OhjajzyEr546yE7Nc4JTbbLz+RJ2kRROc9iLjz+KSuajRm9UBo/uxwbfqxpJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724977222; c=relaxed/simple;
	bh=uwRiDl2mY1nS1kP4HcPK4arraEVy3vBva2cl4RP5K14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2+2A5YfTH9IVXPSrOwfvjBoahod7PnZxrG2dijGgg7KSiAitCQkNKo32sSq0hTmK+/fgm1AdavbsRgGs8Q3mvYpY0IgXmAhP+lp2Pk5fqFnGCZ3gaYv3w/KlC3i5L/3gW97ePndAHHD0ExupV5b0SUuJJQGXP+AlAS7lo9Qs7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NJLr497Q; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <84cf2784-49af-481f-9b43-901f7aeeaef8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724977217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KAcjblpU0yHTanJ1yRp13TSrXfz1BjmaZgFR0xXv03s=;
	b=NJLr497Q18TsOCwnMBLWcSh2VOdxh+QqCZd7i+8EBn704VkhNZzI6vAr2pHZ9JMZbeJ/Tb
	OKoOBZ5a3bP7Xv7O70pISv3BkKqS2qsm/JJ6mLCcrigjLcWQuVAJA8WxyaU2yi90gfhpJo
	3AwjaEaxcvFrUqVwkqEt1V/8Y5q5FI8=
Date: Thu, 29 Aug 2024 17:20:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: tcp: prevent bpf_reserve_hdr_opt()
 from growing skb larger than MTU
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: zijianzhang@bytedance.com, Amery Hung <amery.hung@bytedance.com>,
 bpf@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, wangdongdong.6@bytedance.com, zhoufeng.zf@bytedance.com
References: <20240827013736.2845596-1-zijianzhang@bytedance.com>
 <20240827013736.2845596-2-zijianzhang@bytedance.com>
 <5186a69b-c53d-4afa-b3be-e6bd272d264f@linux.dev>
 <ZtCl3kQrldshCFam@pop-os.localdomain>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ZtCl3kQrldshCFam@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/29/24 9:46 AM, Cong Wang wrote:
> On Wed, Aug 28, 2024 at 02:29:17PM -0700, Martin KaFai Lau wrote:
>> On 8/26/24 6:37 PM, zijianzhang@bytedance.com wrote:
>>> From: Amery Hung <amery.hung@bytedance.com>
>>>
>>> This series prevents sockops users from accidentally causing packet
>>> drops. This can happen when a BPF_SOCK_OPS_HDR_OPT_LEN_CB program
>>> reserves different option lengths in tcp_sendmsg().
>>>
>>> Initially, sockops BPF_SOCK_OPS_HDR_OPT_LEN_CB program will be called to
>>> reserve a space in tcp_send_mss(), which will return the MSS for TSO.
>>> Then, BPF_SOCK_OPS_HDR_OPT_LEN_CB will be called in __tcp_transmit_skb()
>>> again to calculate the actual tcp_option_size and skb_push() the total
>>> header size.
>>>
>>> skb->gso_size is restored from TCP_SKB_CB(skb)->tcp_gso_size, which is
>>> derived from tcp_send_mss() where we first call HDR_OPT_LEN. If the
>>> reserved opt size is smaller than the actual header size, the len of the
>>> skb can exceed the MTU. As a result, ip(6)_fragment will drop the
>>> packet if skb->ignore_df is not set.
>>>
>>> To prevent this accidental packet drop, we need to make sure the
>>> second call to the BPF_SOCK_OPS_HDR_OPT_LEN_CB program reserves space
>>> not more than the first time.
>>
>> iiuc, it is a bug in the bpf prog itself that did not reserve the same
>> header length and caused a drop. It is not the only drop case though for an
>> incorrect bpf prog. There are other cases where a bpf prog can accidentally
>> drop a packet.
> 
> But safety is the most important thing for eBPF programs, do we really
> allow this kind of bug to happen in eBPF programs?
> 
>>
>> Do you have an actual use case that the bpf prog cannot reserve the correct
>> header length for the same sk ?
> 
> You can think of it as a simple call of bpf_get_prandom_u32():
> 
> SEC("sockops")
> int bpf_sock_ops_cb(struct bpf_sock_ops *skops)
> {
>      if (skops->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB) {
>          return bpf_get_prandom_u32();

It compiles but this won't even pass the verifier.

If you want to go to this extreme to consider any random bpf program, it is 
essentially deploying a fuzzer to the production traffic, right? Sure, syzbot 
has programs that are rejected by verifier or cause a packet drop. afaik, I 
don't recall syzbot reported them as a crash.

Is a drop a safety issue as you said? I don't think so. It is why this set is 
tagged as bpf-next also and I agree. What is the hurry here?

Is it something that can be improved? may be. Note that the patchwork status has 
not been changed yet. Instead of wasting time here, please allow Zijian (/Amery) 
to continue the discussion on another thread. I have asked question on the 
changes and also suggested other ways.


>      }
>      return 0;
> }
> 
> And eBPF programs are stateful anyway, at least we should not assume
> it is stateless since maps are commonly used. Therefore, different invocations
> of a same eBPF program are expected to return different values. IMHO,
> this is a situation we have to deal with in the kernel, hence stricter
> checks are reasonable and necessary.

