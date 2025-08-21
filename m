Return-Path: <bpf+bounces-66243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A041B30120
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 19:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175CFA03C5A
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 17:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8E5311955;
	Thu, 21 Aug 2025 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjImgYFD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B462DFA21;
	Thu, 21 Aug 2025 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797390; cv=none; b=gq0bjd1vGWOHrTEfJrwyrfJY4kbp1bX/B06UqLvV+Zj7iJ8TU5DUOxwxT+9pMdeSjAhZuKi1VAktQrtydqeuyJmkNV3vfnDb2+C6aYlhvYJKUAdvRHJdGGSv66elXgvCidRaPGXkSVICXo503tLuqUMSoPJTtEA9CzdMxICZlj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797390; c=relaxed/simple;
	bh=3cJ6X2W2PFxDwEeEoAnsOEX0ZLzSK8hEG/0SWi7KlRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWJLncdCx/sP5MZ9LIOkmHxNstjGaJaG8ARmxb/41ijAYC3v0LGAdebsr6yB3FYfHGPPK9tpgk8tF3DTenBcPk8/tzarUuCxX8E/WVtFt8vZE1MpfPeB6IRLBfP95BbmHxr1ZmizFv0SEnqAsqSpWEINjQGGidvIs4yKrZUOq50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjImgYFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FCFC4CEEB;
	Thu, 21 Aug 2025 17:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755797390;
	bh=3cJ6X2W2PFxDwEeEoAnsOEX0ZLzSK8hEG/0SWi7KlRM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HjImgYFD2oUolUoitOP6Q7i/tO34EXB4jpN0nh/Tpi2plOrATpra4qhc4R4pg3gkt
	 WUdsD1N7hVBwTIFyo8BVSd7QOAp0RwSGioszcRhLBlPDV+8VlK8UBKR7oW0zB4+KXs
	 KLuVS6D/bOhRmV2As7Vc8nksSVPFqEvhnO9jqlIx6FTJvAXnRL5zvQ3s/pjLT7xRi4
	 VCK/6KUGBV5Jr9UP2rdlW3++4uQU9ad0h9j5ETue0GGhPNUe+mja7f8Dzz7Ag7CarP
	 leKhe9wBB0cxXF0cmKRj6SrDsnunTgeyORE89l64u0yGjD070mvGAqa3XrvfEGm0Ti
	 oEZtsgqBA/7/g==
Message-ID: <599598da-5453-4cd9-b19d-ca7935985030@kernel.org>
Date: Thu, 21 Aug 2025 19:29:43 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] xsk: support generic batch xmit in copy mode
To: Jason Xing <kerneljasonxing@gmail.com>,
 "Karlsson, Magnus" <magnus.karlsson@intel.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20250811131236.56206-1-kerneljasonxing@gmail.com>
 <20250811131236.56206-3-kerneljasonxing@gmail.com>
 <b07b8930-e644-45a2-bef8-06f4494e7a39@kernel.org>
 <CAL+tcoBWOUCd8f1Q6BYh+xuKs5=Qgr2oOBb9CLU_6BrasD0vfg@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAL+tcoBWOUCd8f1Q6BYh+xuKs5=Qgr2oOBb9CLU_6BrasD0vfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I need some help from Cc Magnus or Björn, to explain why you changes
fails in xsk_destruct_skb().


On 15/08/2025 08.44, Jason Xing wrote:
> On Tue, Aug 12, 2025 at 10:30 PM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
> ...
>>
>> But this also requires changing the SKB alloc function used by
>> xsk_build_skb(). As a seperate patch, I recommend that you change the
>> sock_alloc_send_skb() to instead use build_skb (or build_skb_around).
>> I expect this will be a large performance improvement on it's own.
>> Can I ask you to benchmark this change before the batch xmit change?
>>
>> Opinions needed from other maintainers please (I might be wrong!):
>> I don't think the socket level accounting done in sock_alloc_send_skb()
>> is correct/relevant for AF_XDP/XSK, because the "backpressure mechanism"
>> code comment above.
> 
> Here I'm bringing back the last test you expected to know :)
> 
> I use alloc_skb() to replace sock_alloc_send_skb() and introduce other
> minor changes, say, removing sock_wfree() from xsk_destruct_skb(). It
> turns out to be a stable 5% performance improvement on i40e driver.
> slight improvement on virtio_net. That's good news.
> 
> Bad news is that the above logic has bugs like freeing skb in the napi
> poll causes accessing skb->sk in xsk_destruct_skb() which triggers a
> NULL pointer issue. How did I spot this one? I removed the BQL flow
> control and started two xdpsock on different queues, then I saw a
> panic[1]... To solve the problem like that, I'm afraid that we still
> need to charge a certain length value into sk_wmem_alloc so that
> sock_wfree(skb) can be the last one to free the socket finally.
> 
> So this socket level accounting mechanism keeps its safety in the above case.
> 
> IMHO, we can get rid of the limitation of sk_sndbuf but still use
> skb_set_owner_w() that charges the len of skb. If we stick to removing
> the whole accounting function, probably we have to adjust the position
> of xsk_cq_submit_locked(), but I reckon for now it's not practical...
> 
> Any thoughts on this?
> 
> [1]
>   997 [  133.528449] RIP: 0010:xsk_destruct_skb+0x6a/0x90
>   998 [  133.528920] Code: 8b 6c 02 28 48 8b 43 18 4c 8b a0 68 03 00 00
> 49 8d 9c 24 e8 00 00 00 48 89 df e8 f1 eb 06 00 48 89 c6 49 8b 84 24
> 88 00 00 00 <48> 8b 50 10 03 2a 48      8b 40 10 48 89 df 89 28 5b 5d
> 41 5c e9 6e ec
>   999 [  133.530526] RSP: 0018:ffffae71c06a0d08 EFLAGS: 00010046
> 1000 [  133.531005] RAX: 0000000000000000 RBX: ffff9f42c81c49e8 RCX:
> 00000000000002e7
> 1001 [  133.531631] RDX: 0000000000000001 RSI: 0000000000000286 RDI:
> ffff9f42c81c49e8
> 1002 [  133.532249] RBP: 0000000000000001 R08: 0000000000000008 R09:
> 00000000000000001003 [  133.532867] R10: ffffffff978080c0 R11:
> ffffae71c06a0ff8 R12: ffff9f42c81c4900
> 1004 [  133.533491] R13: ffffae71c06a0d88 R14: ffff9f42e0f1f900 R15:
> ffff9f42ce850d801005 [  133.534123] FS:  0000000000000000(0000)
> GS:ffff9f5227655000(0000) knlGS:00000000000000001006 [  133.534831]
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 1007 [  133.535366] CR2: 0000000000000010 CR3: 000000011c820000 CR4:
> 00000000003506f0
> 1008 [  133.536014] Call Trace:
> 1009 [  133.536313]  <IRQ>
> 1010 [  133.536583]  skb_release_head_state+0x20/0x90
> 1011 [  133.537021]  napi_consume_skb+0x42/0x120
> 1012 [  133.537429]  __free_old_xmit+0x76/0x170 [virtio_net]
> 1013 [  133.537923]  free_old_xmit+0x53/0xc0 [virtio_net]
> 1014 [  133.538395]  virtnet_poll+0xed/0x5d0 [virtio_net]
> 1015 [  133.538867]  ? blake2s_compress+0x52/0xa0
> 1016 [  133.539286]  __napi_poll+0x28/0x200
> 1017 [  133.539668]  net_rx_action+0x319/0x400
> 1018 [  133.540068]  ? sched_clock_cpu+0xb/0x190
> 1019 [  133.540482]  ? __run_timers+0x1d1/0x260
> 1020 [  133.540906]  ? __pfx_dl_task_timer+0x10/0x10
> 1021 [  133.541349]  ? lock_timer_base+0x72/0x90
> 1022 [  133.541767]  handle_softirqs+0xce/0x2e0
> 1023 [  133.542178]  __irq_exit_rcu+0xc6/0xf0
> 1024 [  133.542575]  common_interrupt+0x81/0xa0
> 
> Thanks,
> Jason


