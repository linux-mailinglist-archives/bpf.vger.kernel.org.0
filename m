Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766AD6C3EE6
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 01:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjCVACQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 20:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVACP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 20:02:15 -0400
Received: from out-7.mta0.migadu.com (out-7.mta0.migadu.com [IPv6:2001:41d0:1004:224b::7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5D42686E
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 17:02:13 -0700 (PDT)
Message-ID: <1931c8d8-0706-a2cf-f156-cb17b7d8cce8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679443331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYlklpx/k/yKVztH5kDUqjzXoZs13UhwoQjJJhI22Ec=;
        b=wxWYwaoOgLouF/xfZTY+9nu2m1e4kNhaFEz9sxPw2b5NUUpSSKJ03UjMdGKbTLP/aoh4FS
        zbmclaUOZV3H6QJJtfz+YVuKod5US4g0KbX4CRU6uM3crtWbROi3yoYVjlgzKAkW3Eb/PN
        sblT1Et0d9dqjLz/uPIge3UmzqxxwtQ=
Date:   Tue, 21 Mar 2023 17:02:09 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 3/5] [RFC] net: Skip taking lock in BPF
 context
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Stanislav Fomichev <sdf@google.com>
References: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
 <20230321184541.1857363-4-aditi.ghag@isovalent.com>
 <ZBoiShkzD5KY2uIt@google.com>
 <DF1B817F-2623-421E-9C7E-FFA9816083EB@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <DF1B817F-2623-421E-9C7E-FFA9816083EB@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/21/23 4:39 PM, Aditi Ghag wrote:
> 
> 
>> On Mar 21, 2023, at 2:31 PM, Stanislav Fomichev <sdf@google.com> wrote:
>>
>> On 03/21, Aditi Ghag wrote:
>>> When sockets are destroyed in the BPF iterator context, sock
>>> lock is already acquired, so skip taking the lock. This allows
>>> TCP listening sockets to be destroyed from BPF programs.
>>
>>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>>> ---
>>>   net/ipv4/inet_hashtables.c | 9 ++++++---
>>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>>> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
>>> index e41fdc38ce19..5543a3e0d1b4 100644
>>> --- a/net/ipv4/inet_hashtables.c
>>> +++ b/net/ipv4/inet_hashtables.c
>>> @@ -777,9 +777,11 @@ void inet_unhash(struct sock *sk)
>>>   		/* Don't disable bottom halves while acquiring the lock to
>>>   		 * avoid circular locking dependency on PREEMPT_RT.
>>>   		 */
>>> -		spin_lock(&ilb2->lock);
>>> +		if (!has_current_bpf_ctx())
>>> +			spin_lock(&ilb2->lock);
>>>   		if (sk_unhashed(sk)) {
>>> -			spin_unlock(&ilb2->lock);
>>> +			if (!has_current_bpf_ctx())
>>> +				spin_unlock(&ilb2->lock);
>>
>> That's bucket lock, why do we have to skip it?
> 
> Good catch! We shouldn't skip it. So the issue is that BPF TCP iterator acquires the sock fast lock that disables BH, and then inet_unhash acquires the bucket lock, but this is in reverse order to when the sock lock is acquired with BH enabled.
> 
> @Martin: I wonder if you ran into similar issues while working on the BPF TCP iterator batching changes for setsockopt?

The existing helpers don't need to acquire bucket log. afaik, the destroy kfunc 
is the first. [ Unrelated note, the bh disable had recently be removed for lhash 
in commit 4f9bf2a2f5aa. ]

If I read this splat correctly, similar to the earlier reply in patch 2 for a 
different issue, an easy solution is to use lock_sock() instead of 
lock_sock_fast() in bpf_iter_tcp_seq_show() .

> 
> Here is the truncated stack trace:
> 
>      1.494510] test_progs/118 [HC0[0]:SC0[4]:HE1:SE0] is trying to acquire:
> [    1.495123] ffff9ec9c184da10 (&h->lhash2[i].lock){+.+.}-{2:2}, at: inet_unhash+0x96/0xd0
> [    1.495867]
> [    1.495867] and this task is already holding:
> [    1.496401] ffff9ec9c23400b0 (slock-AF_INET6){+.-.}-{2:2}, at: __lock_sock_fast+0x33/0x70
> [    1.497148] which would create a new lock dependency:
> [    1.497619]  (slock-AF_INET6){+.-.}-{2:2} -> (&h->lhash2[i].lock){+.+.}-{2:2}
> [    1.498278]
> [    1.498278] but this new dependency connects a SOFTIRQ-irq-safe lock:
> [    1.499011]  (slock-AF_INET6){+.-.}-{2:2}
> [    1.499014]
> [    1.499014] ... which became SOFTIRQ-irq-safe at:
> [    1.499968]   lock_acquire+0xcd/0x330
> [    1.500316]   _raw_spin_lock+0x33/0x40
> [    1.500670]   sk_clone_lock+0x146/0x520
> [    1.501030]   inet_csk_clone_lock+0x1b/0x110
> [    1.501433]   tcp_create_openreq_child+0x22/0x3f0
> [    1.501873]   tcp_v6_syn_recv_sock+0x96/0x940
> [    1.502284]   tcp_check_req+0x137/0x660
> [    1.502646]   tcp_v6_rcv+0xa63/0xe80
> [    1.502994]   ip6_protocol_deliver_rcu+0x78/0x590
> [    1.503434]   ip6_input_finish+0x72/0x140
> [    1.503818]   __netif_receive_skb_one_core+0x63/0xa0
> :
> :
> 
> [    1.512311] to a SOFTIRQ-irq-unsafe lock:
> [    1.512773]  (&h->lhash2[i].lock){+.+.}-{2:2}
> [    1.512776]
> [    1.512776] ... which became SOFTIRQ-irq-unsafe at:
> [    1.513691] ...
> [    1.513692]   lock_acquire+0xcd/0x330
> [    1.514168]   _raw_spin_lock+0x33/0x40
> [    1.514492]   __inet_hash+0x4b/0x210
> [    1.514802]   inet_csk_listen_start+0xe6/0x100
> [    1.515188]   inet_listen+0x95/0x1d0
> [    1.515510]   __sys_listen+0x69/0xb0
> [    1.515825]   __x64_sys_listen+0x14/0x20
> [    1.516163]   do_syscall_64+0x3c/0x90
> [    1.516481]   entry_SYSCALL_64_after_hwframe+0x72/0xdc
> :
> :
> 
> [    1.560494]  ... acquired at:
> [    1.560634]    lock_acquire+0xcd/0x330
> [    1.560804]    _raw_spin_lock_bh+0x38/0x50
> [    1.561002]    inet_unhash+0x96/0xd0
> [    1.561168]    tcp_set_state+0x6a/0x210
> [    1.561352]    tcp_abort+0x12b/0x230
> [    1.561518]    bpf_prog_f4110fb1100e26b5_iter_tcp6_server+0xa3/0xaa
> [    1.561799]    bpf_iter_run_prog+0x1ff/0x340
> [    1.561990]    bpf_iter_tcp_seq_show+0xca/0x190
> [    1.562193]    bpf_seq_read+0x177/0x450
> [    1.562363]    vfs_read+0xc6/0x300
> [    1.562516]    ksys_read+0x69/0xf0
> [    1.562665]    do_syscall_64+0x3c/0x90
> [    1.562838]    entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
>>
>>>   			return;
>>>   		}
>>
>>> @@ -788,7 +790,8 @@ void inet_unhash(struct sock *sk)
>>
>>>   		__sk_nulls_del_node_init_rcu(sk);
>>>   		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>>> -		spin_unlock(&ilb2->lock);
>>> +		if (!has_current_bpf_ctx())
>>> +			spin_unlock(&ilb2->lock);
>>>   	} else {
>>>   		spinlock_t *lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
>>
>>> --
>>> 2.34.1
> 

