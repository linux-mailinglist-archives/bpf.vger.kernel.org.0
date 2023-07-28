Return-Path: <bpf+bounces-6217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4457671B3
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 18:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582352827EF
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 16:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EA214AAD;
	Fri, 28 Jul 2023 16:16:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313DD14A8B
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:16:43 +0000 (UTC)
Received: from out-117.mta0.migadu.com (out-117.mta0.migadu.com [91.218.175.117])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7406D3AB4
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 09:16:41 -0700 (PDT)
Message-ID: <2c3bec7a-812c-0a65-f8c1-b9749430adba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690560999; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4d5dX2QpOs/NQAOKyRlBye3q/eaKn/kIqTx/3BJqMA=;
	b=S05AXoOWkRtVDQgNWaAU61a0PxShD2p1OxKAwho6I33bMP7fQDFkZkX23n+ctKHnZCStqs
	Ts4R+FVbXlgRYYQbVBvxeT1Cd1Z5TGGngWG7uEaYCyfWE3mg8P5zxV/T7pOh4r4ERI0fZ0
	JCqPMJOh+BqLS6XHBsB5AoDSX8Trnyg=
Date: Fri, 28 Jul 2023 09:16:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH net] bpf: sockmap: Remove preempt_disable in
 sock_map_sk_acquire
Content-Language: en-US
To: Jiri Olsa <olsajiri@gmail.com>, tglozar@redhat.com
Cc: linux-kernel@vger.kernel.org, john.fastabend@gmail.com,
 jakub@cloudflare.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20230728064411.305576-1-tglozar@redhat.com>
 <ZMOrEi3cNWGXp9ZS@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZMOrEi3cNWGXp9ZS@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/28/23 4:48 AM, Jiri Olsa wrote:
> On Fri, Jul 28, 2023 at 08:44:11AM +0200, tglozar@redhat.com wrote:
>> From: Tomas Glozar <tglozar@redhat.com>
>>
>> Disabling preemption in sock_map_sk_acquire conflicts with GFP_ATOMIC
>> allocation later in sk_psock_init_link on PREEMPT_RT kernels, since
>> GFP_ATOMIC might sleep on RT (see bpf: Make BPF and PREEMPT_RT co-exist
>> patchset notes for details).
>>
>> This causes calling bpf_map_update_elem on BPF_MAP_TYPE_SOCKMAP maps to
>> BUG (sleeping function called from invalid context) on RT kernels.
>>
>> preempt_disable was introduced together with lock_sk and rcu_read_lock
>> in commit 99ba2b5aba24e ("bpf: sockhash, disallow bpf_tcp_close and update
>> in parallel"), probably to match disabled migration of BPF programs, and
>> is no longer necessary.
>>
>> Remove preempt_disable to fix BUG in sock_map_update_common on RT.
> 
> FYI, I'm not sure it's related but I started to see following splat recently:
> 
> [  189.360689][  T658] =============================
> [  189.361149][  T658] [ BUG: Invalid wait context ]
> [  189.361588][  T658] 6.5.0-rc2+ #589 Tainted: G           OE
> [  189.362174][  T658] -----------------------------
> [  189.362660][  T658] test_progs/658 is trying to lock:
> [  189.363176][  T658] ffff8881702652b8 (&psock->link_lock){....}-{3:3}, at: sock_map_update_common+0x1c4/0x340
> [  189.364152][  T658] other info that might help us debug this:
> [  189.364689][  T658] context-{5:5}
> [  189.365021][  T658] 3 locks held by test_progs/658:
> [  189.365508][  T658]  #0: ffff888177611a80 (sk_lock-AF_INET){+.+.}-{0:0}, at: sock_map_update_elem_sys+0x82/0x260
> [  189.366503][  T658]  #1: ffffffff835a3180 (rcu_read_lock){....}-{1:3}, at: sock_map_update_elem_sys+0x78/0x260
> [  189.367470][  T658]  #2: ffff88816cf19240 (&stab->lock){+...}-{2:2}, at: sock_map_update_common+0x12a/0x340
> [  189.368420][  T658] stack backtrace:
> [  189.368806][  T658] CPU: 0 PID: 658 Comm: test_progs Tainted: G           OE      6.5.0-rc2+ #589 98af30b3c42d747b51da05f1d0e4899e394be6c9
> [  189.369889][  T658] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
> [  189.370736][  T658] Call Trace:
> [  189.371063][  T658]  <TASK>
> [  189.371365][  T658]  dump_stack_lvl+0xb2/0x120
> [  189.371798][  T658]  __lock_acquire+0x9ad/0x2470
> [  189.372243][  T658]  ? lock_acquire+0x104/0x350
> [  189.372680][  T658]  lock_acquire+0x104/0x350
> [  189.373104][  T658]  ? sock_map_update_common+0x1c4/0x340
> [  189.373615][  T658]  ? find_held_lock+0x32/0x90
> [  189.374074][  T658]  ? sock_map_update_common+0x12a/0x340
> [  189.374587][  T658]  _raw_spin_lock_bh+0x38/0x80
> [  189.375060][  T658]  ? sock_map_update_common+0x1c4/0x340
> [  189.375571][  T658]  sock_map_update_common+0x1c4/0x340
> [  189.376118][  T658]  sock_map_update_elem_sys+0x184/0x260
> [  189.376704][  T658]  __sys_bpf+0x181f/0x2840
> [  189.377147][  T658]  __x64_sys_bpf+0x1a/0x30
> [  189.377556][  T658]  do_syscall_64+0x38/0x90
> [  189.377980][  T658]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  189.378473][  T658] RIP: 0033:0x7fe52f47ab5d
> 
> the patch did not help with that

I think the above splat is not related to this patch. In function
sock_map_update_common func we have
   raw_spin_lock_bh(&stab->lock);

   sock_map_add_link(psock, link, map, &stab->sks[idx]);
     spin_lock_bh(&psock->link_lock);
     ...
     spin_unlock_bh(&psock->link_lock);

   raw_spin_unlock_bh(&stab->lock);

I think you probably have CONFIG_PROVE_RAW_LOCK_NESTING turned on
in your config.

In the above case, for RT kernel, spin_lock_bh will become
'mutex' and it is sleepable, while raw_spin_lock_bh remains
to be a spin lock. The warning is about potential
locking violation with RT kernel.

To fix the issue, you can convert spin_lock_bh to raw_spin_lock_bh
to silence the warning.

> 
> jirka
> 
>>
>> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
>> ---
>>   net/core/sock_map.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>> index 19538d628714..08ab108206bf 100644
>> --- a/net/core/sock_map.c
>> +++ b/net/core/sock_map.c
>> @@ -115,7 +115,6 @@ static void sock_map_sk_acquire(struct sock *sk)
>>   	__acquires(&sk->sk_lock.slock)
>>   {
>>   	lock_sock(sk);
>> -	preempt_disable();
>>   	rcu_read_lock();
>>   }
>>   
>> @@ -123,7 +122,6 @@ static void sock_map_sk_release(struct sock *sk)
>>   	__releases(&sk->sk_lock.slock)
>>   {
>>   	rcu_read_unlock();
>> -	preempt_enable();
>>   	release_sock(sk);
>>   }
>>   
>> -- 
>> 2.39.3
>>
>>
> 

