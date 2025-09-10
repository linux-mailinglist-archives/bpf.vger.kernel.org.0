Return-Path: <bpf+bounces-68017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 899E7B518EE
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 16:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5761C860BF
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 14:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E1C321F24;
	Wed, 10 Sep 2025 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n7PmtqlO"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C9322777
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513171; cv=none; b=YkcMEzdvfFTgHy6gv6NF1rHs9llsr836+WlN0z8wxhbGSwSE0hsL47B70aRLkMx+Ow32DEEvlgdguIQd3OZCZozgaWEjfOxn/rfGm1IO6Lr5EQTv1blRsGw0LSI/nbZ0BUgPX4nw62QPBp7hbekQDA8chFtsL0XtUA/Yl00HOUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513171; c=relaxed/simple;
	bh=Bjhex7LejrbRQaESQF5Epo/8YEFXGCfX/zfXr9uPhYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWzXO7GPCHAFQr6DgSLS83fbsRCTFTXXIeE6nk3S1fySYP2HaC48fGqcaCHQHpF4bOG/2PPJSZ1N/kZPU4loV3JL9mf5LaCqgYC8xmIutvyw/YnsLkBZCsg9Fn9L5NNLQbV3xffKnDxlLo7RqA6kxaQn82azFmLJN10bL1707Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n7PmtqlO; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <effcf89d-925a-4bf6-9c6c-39a9b6731409@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757513156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7/m/rIMOan/KvaJDI/7faZKA7j5+5vMGRzv9YnAqCQ=;
	b=n7PmtqlOoANH8MFq4N43pNmgqxju3jBfwrmJRdS2rw6Bcz/+rp2HPeZcPDNjjoeigbq2OS
	WifDv0/lAyQIZwMT4NFOEjIWACyr40nHgLl3J7bY5o7ybti+ocUfOOkRQjmr9DdtWLdhOj
	Pq3vGnefsF1duEzaKTAkb6SWP68nj10=
Date: Wed, 10 Sep 2025 07:05:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf] tcp_bpf: Call sk_msg_free() when
 tcp_bpf_send_verdict() fails to allocate psock->cork.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, syzbot+4cabd1d2fa917a456db8@syzkaller.appspotmail.com
References: <20250909232623.4151337-1-kuniyu@google.com>
 <a29689e0-cabc-4fdb-a030-443f0ccfb468@linux.dev>
 <CAAVpQUDeaiGUdxGQHSMRU3=zwJy7a0hMWXjoRkfdYPqaZLU09Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAAVpQUDeaiGUdxGQHSMRU3=zwJy7a0hMWXjoRkfdYPqaZLU09Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/9/25 11:56 PM, Kuniyuki Iwashima wrote:
> On Tue, Sep 9, 2025 at 10:15 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 9/9/25 4:26 PM, Kuniyuki Iwashima wrote:
>>> syzbot reported the splat below. [0]
>>>
>>> The repro does the following:
>>>
>>>     1. Load a sk_msg prog that calls bpf_msg_cork_bytes(msg, cork_bytes)
>>>     2. Attach the prog to a SOCKMAP
>>>     3. Add a socket to the SOCKMAP
>>>     4. Activate fault injection
>>>     5. Send data less than cork_bytes
>>>
>>> At 5., the data is carried over to the next sendmsg() as it is
>>> smaller than the cork_bytes specified by bpf_msg_cork_bytes().
>>>
>>> Then, tcp_bpf_send_verdict() tries to allocate psock->cork to hold
>>> the data, but this fails silently due to fault injection + __GFP_NOWARN.
>>>
>>> If the allocation fails, we need to revert the sk->sk_forward_alloc
>>> change done by sk_msg_alloc().
>>>
>>> Let's call sk_msg_free() when tcp_bpf_send_verdict fails to allocate
>>> psock->cork.
>>>
>>> [0]:
>>> WARNING: net/ipv4/af_inet.c:156 at inet_sock_destruct+0x623/0x730 net/ipv4/af_inet.c:156, CPU#1: syz-executor/5983
>>> Modules linked in:
>>> CPU: 1 UID: 0 PID: 5983 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full)
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
>>> RIP: 0010:inet_sock_destruct+0x623/0x730 net/ipv4/af_inet.c:156
>>> Code: 0f 0b 90 e9 62 fe ff ff e8 7a db b5 f7 90 0f 0b 90 e9 95 fe ff ff e8 6c db b5 f7 90 0f 0b 90 e9 bb fe ff ff e8 5e db b5 f7 90 <0f> 0b 90 e9 e1 fe ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 9f fc
>>> RSP: 0018:ffffc90000a08b48 EFLAGS: 00010246
>>> RAX: ffffffff8a09d0b2 RBX: dffffc0000000000 RCX: ffff888024a23c80
>>> RDX: 0000000000000100 RSI: 0000000000000fff RDI: 0000000000000000
>>> RBP: 0000000000000fff R08: ffff88807e07c627 R09: 1ffff1100fc0f8c4
>>> R10: dffffc0000000000 R11: ffffed100fc0f8c5 R12: ffff88807e07c380
>>> R13: dffffc0000000000 R14: ffff88807e07c60c R15: 1ffff1100fc0f872
>>> FS:  00005555604c4500(0000) GS:ffff888125af1000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00005555604df5c8 CR3: 0000000032b06000 CR4: 00000000003526f0
>>> Call Trace:
>>>    <IRQ>
>>>    __sk_destruct+0x86/0x660 net/core/sock.c:2339
>>>    rcu_do_batch kernel/rcu/tree.c:2605 [inline]
>>>    rcu_core+0xca8/0x1770 kernel/rcu/tree.c:2861
>>>    handle_softirqs+0x286/0x870 kernel/softirq.c:579
>>>    __do_softirq kernel/softirq.c:613 [inline]
>>>    invoke_softirq kernel/softirq.c:453 [inline]
>>>    __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
>>>    irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
>>>    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
>>>    sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1052
>>>    </IRQ>
>>>
>>> Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
>>> Reported-by: syzbot+4cabd1d2fa917a456db8@syzkaller.appspotmail.com
>>> Closes: https://lore.kernel.org/netdev/68c0b6b5.050a0220.3c6139.0013.GAE@google.com/
>>> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>>> ---
>>>    net/ipv4/tcp_bpf.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>>> index ba581785adb4..ee6a371e65a4 100644
>>> --- a/net/ipv4/tcp_bpf.c
>>> +++ b/net/ipv4/tcp_bpf.c
>>> @@ -408,8 +408,10 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>>>                if (!psock->cork) {
>>>                        psock->cork = kzalloc(sizeof(*psock->cork),
>>>                                              GFP_ATOMIC | __GFP_NOWARN);
>>> -                     if (!psock->cork)
>>> +                     if (!psock->cork) {
>>> +                             sk_msg_free(sk, msg);
>>
>> Nothing has been corked yet, does it need to update the "*copied":
>>
>>                                  *copied -= sk_msg_free(sk, msg);
> 
> Oh exactly, or simply *copied = 0 ?

Make sense. I made the change and updated the commit message for this fix also. 
Applied. Thanks.



