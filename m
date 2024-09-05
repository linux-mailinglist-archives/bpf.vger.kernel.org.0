Return-Path: <bpf+bounces-39029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904A396DDF3
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 17:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E70286591
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 15:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E937819CD11;
	Thu,  5 Sep 2024 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PqfEi0bW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ZAJUt7K"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B1917ADFF;
	Thu,  5 Sep 2024 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549754; cv=none; b=cVESWFgxwZcYEEgNOE3wiTAy0xdpfIvD5iRCjNm45o+U0+pwDHET1Wp0QaTiPF99oXumnlj5rD7jZzhVP9zsJXF008QGUJxy4RjFfZfVqlRRryyvvNwdands6lHihCBB2x0hNUmdNDbcXXhUltFORhiyu2AwLt45lmC+xmYlH+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549754; c=relaxed/simple;
	bh=8tYxiowcDg7sy/Bi1Tz51H/sNl2Ne4FxOgwju8iuLAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gaq4HQh2KaDbFVX6tnczfGzUCr8iimVYFL4u5gt25nwGE503C47ca3lNu7l2JDPUse2ds2M4201K/N0WMNJNEtbJvfEaLYhCNVJNp35IxZJfYFgyJOHN62rElYABv2eYhJrV5LpwnN8M6UL3awzqlqVwSaig6L9C7pOZIIOksEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PqfEi0bW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ZAJUt7K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <a276b92b-43b4-41ab-9861-4f7284298fe8@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725549750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gZ5SHBhKQ+lu5Rl62YJTZpEorQ9FWtUCGzdJxmy3UGk=;
	b=PqfEi0bWKV5NNI1oyIWjOagnxCNdabvVHk2m86eyi9aMWLzEnUiMeLEl5tv0r5/YJyVO4l
	1jhmr1pwM4XHyS99VgmEOXSfT/1iQ+/ENRqGVkjDx+cRt4qXurXSPn8mUIR1AN2iLUkQIy
	1ZPPD8aYMxmMd7r1SoVH0aaypKu6HFk1AlsfjPCuxr28/KaLmQD4qYjzX1NGELAQUzQb/u
	ROuXvvznxulMEU3Uqw/NXMpX5BhFAfbsQYmOjWHzJ0ue6YXinLAJKsKMjSQ7vBEAAokh/W
	XeBOutk72EYIY+w3tkTiUZAuAcvCnBLjbqk0dol/IY4kygyUu2RLkuZVFWfG4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725549750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gZ5SHBhKQ+lu5Rl62YJTZpEorQ9FWtUCGzdJxmy3UGk=;
	b=1ZAJUt7KwT1PUPcQyphiQMNXqJNT+obEOHGkSJgQIpVXheM86I3gHuZbFpcDbLt8zLQmTS
	Rvvm/O3O3boLPBAA==
Date: Thu, 5 Sep 2024 17:22:27 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] bpf: devmap: provide rxq after redirect
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240905-devel-koalo-fix-ingress-ifindex-v1-1-d12a0d74c29c@linutronix.de>
 <87bk12i12y.fsf@toke.dk>
Content-Language: en-US
From: Florian Kauer <florian.kauer@linutronix.de>
Autocrypt: addr=florian.kauer@linutronix.de; keydata=
 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
 ugsSqUGtSA==
In-Reply-To: <87bk12i12y.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/5/24 17:15, Toke Høiland-Jørgensen wrote:
> Florian Kauer <florian.kauer@linutronix.de> writes:
> 
>> rxq contains a pointer to the device from where
>> the redirect happened. Currently, the BPF program
>> that was executed after a redirect via BPF_MAP_TYPE_DEVMAP*
>> does not have it set.
>>
>> This is particularly bad since accessing ingress_ifindex, e.g.
>>
>> SEC("xdp")
>> int prog(struct xdp_md *pkt)
>> {
>>         return bpf_redirect_map(&dev_redirect_map, 0, 0);
>> }
>>
>> SEC("xdp/devmap")
>> int prog_after_redirect(struct xdp_md *pkt)
>> {
>>         bpf_printk("ifindex %i", pkt->ingress_ifindex);
>>         return XDP_PASS;
>> }
>>
>> depends on access to rxq, so a NULL pointer gets dereferenced:
>>
>> <1>[  574.475170] BUG: kernel NULL pointer dereference, address: 0000000000000000
>> <1>[  574.475188] #PF: supervisor read access in kernel mode
>> <1>[  574.475194] #PF: error_code(0x0000) - not-present page
>> <6>[  574.475199] PGD 0 P4D 0
>> <4>[  574.475207] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>> <4>[  574.475217] CPU: 4 UID: 0 PID: 217 Comm: kworker/4:1 Not tainted 6.11.0-rc5-reduced-00859-g780801200300 #23
>> <4>[  574.475226] Hardware name: Intel(R) Client Systems NUC13ANHi7/NUC13ANBi7, BIOS ANRPL357.0026.2023.0314.1458 03/14/2023
>> <4>[  574.475231] Workqueue: mld mld_ifc_work
>> <4>[  574.475247] RIP: 0010:bpf_prog_5e13354d9cf5018a_prog_after_redirect+0x17/0x3c
>> <4>[  574.475257] Code: cc cc cc cc cc cc cc 80 00 00 00 cc cc cc cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 66 90 55 48 89 e5 f3 0f 1e fa 48 8b 57 20 <48> 8b 52 00 8b 92 e0 00 00 00 48 bf f8 a6 d5 c4 5d a0 ff ff be 0b
>> <4>[  574.475263] RSP: 0018:ffffa62440280c98 EFLAGS: 00010206
>> <4>[  574.475269] RAX: ffffa62440280cd8 RBX: 0000000000000001 RCX: 0000000000000000
>> <4>[  574.475274] RDX: 0000000000000000 RSI: ffffa62440549048 RDI: ffffa62440280ce0
>> <4>[  574.475278] RBP: ffffa62440280c98 R08: 0000000000000002 R09: 0000000000000001
>> <4>[  574.475281] R10: ffffa05dc8b98000 R11: ffffa05f577fca40 R12: ffffa05dcab24000
>> <4>[  574.475285] R13: ffffa62440280ce0 R14: ffffa62440549048 R15: ffffa62440549000
>> <4>[  574.475289] FS:  0000000000000000(0000) GS:ffffa05f4f700000(0000) knlGS:0000000000000000
>> <4>[  574.475294] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> <4>[  574.475298] CR2: 0000000000000000 CR3: 000000025522e000 CR4: 0000000000f50ef0
>> <4>[  574.475303] PKRU: 55555554
>> <4>[  574.475306] Call Trace:
>> <4>[  574.475313]  <IRQ>
>> <4>[  574.475318]  ? __die+0x23/0x70
>> <4>[  574.475329]  ? page_fault_oops+0x180/0x4c0
>> <4>[  574.475339]  ? skb_pp_cow_data+0x34c/0x490
>> <4>[  574.475346]  ? kmem_cache_free+0x257/0x280
>> <4>[  574.475357]  ? exc_page_fault+0x67/0x150
>> <4>[  574.475368]  ? asm_exc_page_fault+0x26/0x30
>> <4>[  574.475381]  ? bpf_prog_5e13354d9cf5018a_prog_after_redirect+0x17/0x3c
>> <4>[  574.475386]  bq_xmit_all+0x158/0x420
>> <4>[  574.475397]  __dev_flush+0x30/0x90
>> <4>[  574.475407]  veth_poll+0x216/0x250 [veth]
>> <4>[  574.475421]  __napi_poll+0x28/0x1c0
>> <4>[  574.475430]  net_rx_action+0x32d/0x3a0
>> <4>[  574.475441]  handle_softirqs+0xcb/0x2c0
>> <4>[  574.475451]  do_softirq+0x40/0x60
>> <4>[  574.475458]  </IRQ>
>> <4>[  574.475461]  <TASK>
>> <4>[  574.475464]  __local_bh_enable_ip+0x66/0x70
>> <4>[  574.475471]  __dev_queue_xmit+0x268/0xe40
>> <4>[  574.475480]  ? selinux_ip_postroute+0x213/0x420
>> <4>[  574.475491]  ? alloc_skb_with_frags+0x4a/0x1d0
>> <4>[  574.475502]  ip6_finish_output2+0x2be/0x640
>> <4>[  574.475512]  ? nf_hook_slow+0x42/0xf0
>> <4>[  574.475521]  ip6_finish_output+0x194/0x300
>> <4>[  574.475529]  ? __pfx_ip6_finish_output+0x10/0x10
>> <4>[  574.475538]  mld_sendpack+0x17c/0x240
>> <4>[  574.475548]  mld_ifc_work+0x192/0x410
>> <4>[  574.475557]  process_one_work+0x15d/0x380
>> <4>[  574.475566]  worker_thread+0x29d/0x3a0
>> <4>[  574.475573]  ? __pfx_worker_thread+0x10/0x10
>> <4>[  574.475580]  ? __pfx_worker_thread+0x10/0x10
>> <4>[  574.475587]  kthread+0xcd/0x100
>> <4>[  574.475597]  ? __pfx_kthread+0x10/0x10
>> <4>[  574.475606]  ret_from_fork+0x31/0x50
>> <4>[  574.475615]  ? __pfx_kthread+0x10/0x10
>> <4>[  574.475623]  ret_from_fork_asm+0x1a/0x30
>> <4>[  574.475635]  </TASK>
>> <4>[  574.475637] Modules linked in: veth br_netfilter bridge stp llc iwlmvm x86_pkg_temp_thermal iwlwifi efivarfs nvme nvme_core
>> <4>[  574.475662] CR2: 0000000000000000
>> <4>[  574.475668] ---[ end trace 0000000000000000 ]---
> 
> Yikes! I wonder how that has gone unnoticed this long. Could you please
> add a selftest for this so it doesn't happen again?

Yes, I will try to construct one.

> 
>> Therefore, provide it to the program by setting rxq properly.
>>
>> Fixes: fbee97feed9b ("bpf: Add support to attach bpf program to a devmap entry")
> 
> I think the fixes tag is wrong; the original commit was fine because the
> xdp_buff was still the one initialised by the driver. So this should be:
> 
> Fixes: cb261b594b41 ("bpf: Run devmap xdp_prog on flush instead of bulk enqueue")

Oh, I agree. On first glance it looked like the old dev_map_run_prog
was also only setting txq, but didn't notice that it was just overwriting
in the original xdp_buff.

> 
> Other than that, though, the patch LGTM:
> 
> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> 

Thanks,
Florian

