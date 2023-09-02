Return-Path: <bpf+bounces-9136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 844B0790607
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 10:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E91E1C2091E
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 08:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BCC2596;
	Sat,  2 Sep 2023 08:13:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6523AA;
	Sat,  2 Sep 2023 08:13:33 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E361706;
	Sat,  2 Sep 2023 01:13:31 -0700 (PDT)
Received: from kwepemd100003.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rd6zQ14VFzVk1s;
	Sat,  2 Sep 2023 16:10:58 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemd100003.china.huawei.com (7.221.188.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Sat, 2 Sep 2023 16:13:28 +0800
Message-ID: <8a259e47-f119-9bba-acc1-a95a2f3d4cc3@huawei.com>
Date: Sat, 2 Sep 2023 16:13:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf] bpf: sockmap, fix skb refcnt race after locking
 changes
Content-Language: en-US
To: John Fastabend <john.fastabend@gmail.com>, <olsajiri@gmail.com>,
	<eddyz87@gmail.com>
CC: <edumazet@google.com>, <cong.wang@bytedance.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20230901202137.214666-1-john.fastabend@gmail.com>
From: Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <20230901202137.214666-1-john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100003.china.huawei.com (7.221.188.180)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/2/2023 4:21 AM, John Fastabend wrote:
> There is a race where skb's from the sk_psock_backlog can be referenced
> after userspace side has already skb_consumed() the sk_buff and its
> refcnt dropped to zer0 causing use after free.
> 
> The flow is the following,
> 
>    while ((skb = skb_peek(&psock->ingress_skb))
>      sk_psock_handle_Skb(psock, skb, ..., ingress)
>      if (!ingress) ...
>      sk_psock_skb_ingress
>         sk_psock_skb_ingress_enqueue(skb)
>            msg->skb = skb
>            sk_psock_queue_msg(psock, msg)
>      skb_dequeue(&psock->ingress_skb)
> 
> The sk_psock_queue_msg() puts the msg on the ingress_msg queue. This is
> what the application reads when recvmsg() is called. An application can
> read this anytime after the msg is placed on the queue. The recvmsg
> hook will also read msg->skb and then after user space reads the msg
> will call consume_skb(skb) on it effectively free'ing it.
> 
> But, the race is in above where backlog queue still has a reference to
> the skb and calls skb_dequeue(). If the skb_dequeue happens after the
> user reads and free's the skb we have a use after free.
> 
> The !ingress case does not suffer from this problem because it uses
> sendmsg_*(sk, msg) which does not pass the sk_buff further down the
> stack.
> 
> The following splat was observed with 'test_progs -t sockmap_listen':
> 
> [ 1022.710250][ T2556] general protection fault, ...
>   ...
> [ 1022.712830][ T2556] Workqueue: events sk_psock_backlog
> [ 1022.713262][ T2556] RIP: 0010:skb_dequeue+0x4c/0x80
> [ 1022.713653][ T2556] Code: ...
>   ...
> [ 1022.720699][ T2556] Call Trace:
> [ 1022.720984][ T2556]  <TASK>
> [ 1022.721254][ T2556]  ? die_addr+0x32/0x80^M
> [ 1022.721589][ T2556]  ? exc_general_protection+0x25a/0x4b0
> [ 1022.722026][ T2556]  ? asm_exc_general_protection+0x22/0x30
> [ 1022.722489][ T2556]  ? skb_dequeue+0x4c/0x80
> [ 1022.722854][ T2556]  sk_psock_backlog+0x27a/0x300
> [ 1022.723243][ T2556]  process_one_work+0x2a7/0x5b0
> [ 1022.723633][ T2556]  worker_thread+0x4f/0x3a0
> [ 1022.723998][ T2556]  ? __pfx_worker_thread+0x10/0x10
> [ 1022.724386][ T2556]  kthread+0xfd/0x130
> [ 1022.724709][ T2556]  ? __pfx_kthread+0x10/0x10
> [ 1022.725066][ T2556]  ret_from_fork+0x2d/0x50
> [ 1022.725409][ T2556]  ? __pfx_kthread+0x10/0x10
> [ 1022.725799][ T2556]  ret_from_fork_asm+0x1b/0x30
> [ 1022.726201][ T2556]  </TASK>
> 
> To fix we add an skb_get() before passing the skb to be enqueued in
> the engress queue. This bumps the skb->users refcnt so that consume_skb
> and kfree_skb will not immediately free the sk_buff. With this we can
> be sure the skb is still around when we do the dequeue. Then we just
> need to decrement the refcnt or free the skb in the backlog case which
> we do by calling kfree_skb() on the ingress case as well as the sendmsg
> case.
> 
> Before locking change from fixes tag we had the sock locked so we
> couldn't race with user and there was no issue here.
> 
> Fixes: 799aa7f98d53e (skmsg: Avoid lock_sock() in sk_psock_backlog())
> Reported-by: Jiri Olsa  <jolsa@kernel.org>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>   net/core/skmsg.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index a0659fc29bcc..6c31eefbd777 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -612,12 +612,18 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
>   static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
>   			       u32 off, u32 len, bool ingress)
>   {
> +	int err = 0;
> +
>   	if (!ingress) {
>   		if (!sock_writeable(psock->sk))
>   			return -EAGAIN;
>   		return skb_send_sock(psock->sk, skb, off, len);
>   	}
> -	return sk_psock_skb_ingress(psock, skb, off, len);
> +	skb_get(skb);
> +	err = sk_psock_skb_ingress(psock, skb, off, len);
> +	if (err < 0)
> +		kfree_skb(skb);
> +	return err;
>   }
>   
>   static void sk_psock_skb_state(struct sk_psock *psock,
> @@ -685,9 +691,7 @@ static void sk_psock_backlog(struct work_struct *work)
>   		} while (len);
>   
>   		skb = skb_dequeue(&psock->ingress_skb);
> -		if (!ingress) {
> -			kfree_skb(skb);
> -		}
> +		kfree_skb(skb);
>   	}
>   end:
>   	mutex_unlock(&psock->work_mutex);

Tested-by: Xu Kuohai <xukuohai@huawei.com>

