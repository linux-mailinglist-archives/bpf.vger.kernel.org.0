Return-Path: <bpf+bounces-6835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E2276E535
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 12:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990881C212B1
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 10:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40A815AF7;
	Thu,  3 Aug 2023 10:05:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C868156EE;
	Thu,  3 Aug 2023 10:05:46 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B766358D;
	Thu,  3 Aug 2023 03:05:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGkxZ4bwHz4f4Fmf;
	Thu,  3 Aug 2023 18:05:38 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgAX_Qrye8tkqkqJOQ--.14862S2;
	Thu, 03 Aug 2023 18:05:39 +0800 (CST)
Message-ID: <941d6192-58dd-802c-0338-192558a3d3ea@huaweicloud.com>
Date: Thu, 3 Aug 2023 18:05:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf] bpf, sockmap: Fix NULL deref in sk_psock_backlog
Content-Language: en-US
To: John Fastabend <john.fastabend@gmail.com>,
 Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Cong Wang <cong.wang@bytedance.com>
References: <20230731134536.4058181-1-xukuohai@huaweicloud.com>
 <64c9c7a788bad_2c0b20833@john.notmuch>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <64c9c7a788bad_2c0b20833@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAX_Qrye8tkqkqJOQ--.14862S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AF48XFyDCrykur4rZr4fKrg_yoWxZw1rpF
	WrGa1UCF4kJryjqa1SqF4DJr13uw48AFyUArWxta4xZF1Ykr1rGr98JF4j9rn0yrs7u3W2
	qr4DGw4Yk3Z8GaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/2/2023 11:04 AM, John Fastabend wrote:
> Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> sk_psock_backlog triggers a NULL dereference:
>>
>>   BUG: kernel NULL pointer dereference, address: 000000000000000e
>>   #PF: supervisor read access in kernel mode
>>   #PF: error_code(0x0000) - not-present page
>>   PGD 0 P4D 0
>>   Oops: 0000 [#1] PREEMPT SMP PTI
>>   CPU: 0 PID: 70 Comm: kworker/0:3 Not tainted 6.5.0-rc2-00585-gb11bbbe4c66e #26
>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-p4
>>   Workqueue: events sk_psock_backlog
>>   RIP: 0010:0xffffffffc0205254
>>   Code: 00 00 48 89 94 24 a0 00 00 00 41 5f 41 5e 41 5d 41 5c 5d 5b 41 5b 41 5a 41 59 41 50
>>   RSP: 0018:ffffc90000acbcb8 EFLAGS: 00010246
>>   RAX: ffffffff81c5ee10 RBX: ffff888018260000 RCX: 0000000000000001
>>   RDX: 0000000000000003 RSI: ffffc90000acbd58 RDI: 0000000000000000
>>   RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000080100005
>>   R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000003
>>   R13: 0000000000000000 R14: 0000000000000021 R15: 0000000000000003
>>   FS:  0000000000000000(0000) GS:ffff88803ea00000(0000) knlGS:0000000000000000
>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   CR2: 000000000000000e CR3: 000000000b0de002 CR4: 0000000000170ef0
>>   Call Trace:
>>    <TASK>
>>    ? __die+0x24/0x70
>>    ? page_fault_oops+0x15d/0x480
>>    ? fixup_exception+0x26/0x330
>>    ? exc_page_fault+0x72/0x1d0
>>    ? asm_exc_page_fault+0x26/0x30
>>    ? __pfx_inet_sendmsg+0x10/0x10
>>    ? 0xffffffffc0205254
>>    ? inet_sendmsg+0x20/0x80
>>    ? sock_sendmsg+0x8f/0xa0
>>    ? __skb_send_sock+0x315/0x360
>>    ? __pfx_sendmsg_unlocked+0x10/0x10
>>    ? sk_psock_backlog+0xb4/0x300
>>    ? process_one_work+0x292/0x560
>>    ? worker_thread+0x53/0x3e0
>>    ? __pfx_worker_thread+0x10/0x10
>>    ? kthread+0x102/0x130
>>    ? __pfx_kthread+0x10/0x10
>>    ? ret_from_fork+0x34/0x50
>>    ? __pfx_kthread+0x10/0x10
>>    ? ret_from_fork_asm+0x1b/0x30
>>    </TASK>
>>
>> The bug flow is as follows:
>>
>> thread 1                                   thread 2
>>
>> sk_psock_backlog                           sock_close
>>    sk_psock_handle_skb                        __sock_release
>>      __skb_send_sock                            inet_release
>>        sendmsg_unlocked                           tcp_close
>>          sock_sendmsg                               lock_sock
>>                                                       __tcp_close
>>                                                     release_sock
>>                                                   sock->sk = NULL // (1)
>>            inet_sendmsg
>>              sk = sock->sk // (2)
>>              inet_send_prepare
>>                inet_sk(sk)->inet_num // (3)
> 
> We are doing a lot of hoping through calls here to find something we
> should already know. We know the psock we are sending has a protocol
> of tcp, udp, ... and could call the send directly instead of walking
> back into the sk_socket and so on. For tcp example we could simply
> call tcp_sendmsg(sk, msg, size).
> 

Sorry, the fix method in this patch is not correct:

1. though it works on tcp, it fails on udp and unix sockets due to the
    lack of sendmsg_locked callback, which only exists on tcp.

2. inet_release sets socket->sk = NULL outside lock_sock, so lock_sock
    cannot protect us from accessing a NULL socket->sk.

To fix it correctly, calling tcp/udp/unix sendmsg directly without
touching sk_socket seems a good idea, I'll try it. Thanks.

> I haven't tried it yet, but I wonder if a lot of this logic gets
> easier to reason about if we have per protocol backlog logic. Its
> just a hunch at this point though.
> 
>>
>> sock->sk is set to NULL by thread 2 at time (1), then fetched by
>> thread 1 at time (2), and used by thread 1 to access memory at
>> time (3), resulting in NULL pointer dereference.
>>
>> To fix it, add lock_sock back on the egress path for sk_psock_handle_skb.
>>
>> Fixes: 799aa7f98d53 ("skmsg: Avoid lock_sock() in sk_psock_backlog()")
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   net/core/skmsg.c | 44 ++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 34 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
>> index 7c2764beeb04..8b758c51aa0d 100644
>> --- a/net/core/skmsg.c
>> +++ b/net/core/skmsg.c
>> @@ -609,15 +609,42 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
>>   	return err;
>>   }
>>   
>> +static int sk_psock_handle_ingress_skb(struct sk_psock *psock,
>> +				       struct sk_buff *skb,
>> +				       u32 off, u32 len)
>> +{
>> +	if (sock_flag(psock->sk, SOCK_DEAD))
>> +		return -EIO;
> 
> We didn't previously have the SOCK_DEAD check on ingress which
> looks fine because we will come along and flush the ingress
> queue when psock is being torn down. Adding it looks fine
> though because __tcp_close is flushing the sk_receive_queue
> and detaching the user from the socket so we have no way
> to read the data anyways. This will then abort the backlog
> which moves the psock destruct op along a bit faster.
> 
>> +	return sk_psock_skb_ingress(psock, skb, off, len);
>> +}
>> +
>> +static int sk_psock_handle_egress_skb(struct sk_psock *psock,
>> +				      struct sk_buff *skb,
>> +				      u32 off, u32 len)
>> +{
>> +	int ret;
>> +
>> +	lock_sock(psock->sk);
>> +
>> +	if (sock_flag(psock->sk, SOCK_DEAD))
>> +		ret = -EIO;
> 
> OK, the sock_orphan() call from tcp_close adjudge_to_death block will set
> the SOCK_DEAD flag and ensure we abort the send here. EIO then forces
> backlog to abort. This looks correct to me.
> 
>> +	else if (!sock_writeable(psock->sk))
>> +		ret = -EAGAIN;
>> +	else
>> +		ret = skb_send_sock_locked(psock->sk, skb, off, len);
>> +
>> +	release_sock(psock->sk);
>> +
>> +	return ret;
>> +}
>> +
>>   static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
>>   			       u32 off, u32 len, bool ingress)
>>   {
>> -	if (!ingress) {
>> -		if (!sock_writeable(psock->sk))
>> -			return -EAGAIN;
>> -		return skb_send_sock(psock->sk, skb, off, len);
>> -	}
>> -	return sk_psock_skb_ingress(psock, skb, off, len);
>> +	if (ingress)
>> +		return sk_psock_handle_ingress_skb(psock, skb, off, len);
>> +	else
>> +		return sk_psock_handle_egress_skb(psock, skb, off, len);
>>   }
>>   
>>   static void sk_psock_skb_state(struct sk_psock *psock,
>> @@ -660,10 +687,7 @@ static void sk_psock_backlog(struct work_struct *work)
>>   		ingress = skb_bpf_ingress(skb);
>>   		skb_bpf_redirect_clear(skb);
>>   		do {
>> -			ret = -EIO;
>> -			if (!sock_flag(psock->sk, SOCK_DEAD))
>> -				ret = sk_psock_handle_skb(psock, skb, off,
>> -							  len, ingress);
>> +			ret = sk_psock_handle_skb(psock, skb, off, len, ingress);
>>   			if (ret <= 0) {
>>   				if (ret == -EAGAIN) {
>>   					sk_psock_skb_state(psock, state, len, off);
> 
> OK LGTM nice catch I left my commentary above that helped as I reviewed it. I
> guess we need more stress testing along this path all of our testing is on
> ingress path at the moment. Do you happen to have something coded up that
> stress tests the redirect send paths?
>
Not yet, this bug was triggered in one of our http pressure tests.

> Reviewed-by: John Fastabend <john.fastabend@gmail.com>
> 
> .


