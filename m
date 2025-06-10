Return-Path: <bpf+bounces-60241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8370AD44EB
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 23:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDD817CDEE
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 21:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A518F2857C6;
	Tue, 10 Jun 2025 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpwwgXEj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264AC2853E7;
	Tue, 10 Jun 2025 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749591628; cv=none; b=O/0r6/U7HxGE8DIkr0GhYWdAaW/hK+if6SMwDA7KOrgSpA3cAAWuKssLTL4gXEysO3oZYHpeZ0Mml+ZznTgTWn6g3gLu/tXAxHSmHSz5FGZAVeAfAPa5tlgdM7mHjKn05O/cE9DQZK2TDb+1rTOqyGigRN3kQgsAJ02GSzYHDww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749591628; c=relaxed/simple;
	bh=YXLtPs3yCm0mDid6VlwTvUt0+WCyQFVd+zGBmbLvQuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8Mw/QiWTNy+HAD6FfWR1D1QVNhVPy0arvNhpIuz+/0bIEamD7xbLn37XN059X0Six9GZE15rZySOqNZW9SzGBsunQNqNsB9OjIYMJbk7+HLpDvEmaHAtv/3kWKIsob4k7i7FJ+a6+/63hj6YGAUOm+GSpzt9L+mmstQkSdqJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpwwgXEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85100C4CEED;
	Tue, 10 Jun 2025 21:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749591627;
	bh=YXLtPs3yCm0mDid6VlwTvUt0+WCyQFVd+zGBmbLvQuE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DpwwgXEjHgjOeA3zS9rkTYmep/fXGKJz4NDGJNUBoSiaKoMPZ2sTtBVXUkFu4hHZu
	 /JCi+iBVAwivLghm2GoJwu9j7U+mRaz4z7ykdrGXFfnTjkgqa3QKW6IjRNbmsZ84fb
	 TB7hJl1EWxFP3qsZ3kSucZwBeS4AARo6htzRUGcAOKh3RlvWzRcgSKsSAy3PtXC+S3
	 hoRPsQYGRQfHpRnF+P34L9z/RQhpE3l/hKOv9eEeu0WB66P2xzqPqqfTG4Hon9hJFt
	 09dD3R1pQsIbxvX3+CBwVnOeNQnpmcDR0ZtxJ6ngo76Scv6V5bSho8Lp0E7w+xmYr5
	 c6LIBe4/l+9UA==
Message-ID: <cba926c1-66b9-45fb-a203-13ff646567f9@kernel.org>
Date: Tue, 10 Jun 2025 23:40:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V7 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
To: Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <174559288731.827981.8748257839971869213.stgit@firesoul>
 <174559294022.827981.1282809941662942189.stgit@firesoul>
 <fecfcad0-7a16-42b8-bff2-66ee83a6e5c4@linux.dev>
 <b158cffc-582b-4a2f-bb13-a27c8f58b6fc@kernel.org>
 <46a47776-dcd9-4c6f-8d71-f94b22b077e2@kernel.org>
 <6812c58a-4f33-46b5-8886-1198e36823ed@linux.dev>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <6812c58a-4f33-46b5-8886-1198e36823ed@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/06/2025 20.26, Ihor Solodrai wrote:
> On 6/10/25 8:56 AM, Jesper Dangaard Brouer wrote:
>>
>>
>> On 10/06/2025 13.43, Jesper Dangaard Brouer wrote:
>>>
>>> On 10/06/2025 00.09, Ihor Solodrai wrote:
>>>> On 4/25/25 7:55 AM, Jesper Dangaard Brouer wrote:
>> [...]
>>>>> ---
>>>>>   drivers/net/veth.c |   57 
>>>>> ++++++++++++++++++++++++++++++++++++++++ +++---------
>>>>>   1 file changed, 47 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>>>>> index 7bb53961c0ea..e58a0f1b5c5b 100644
>>>>> --- a/drivers/net/veth.c
>>>>> +++ b/drivers/net/veth.c
>>>>> @@ -307,12 +307,10 @@ static void __veth_xdp_flush(struct veth_rq *rq)
>>>>>   static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
>>>>>   {
>>>>> -    if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb))) {
>>>>> -        dev_kfree_skb_any(skb);
>>>>> -        return NET_RX_DROP;
>>>>> -    }
>>>>> +    if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb)))
>>>>> +        return NETDEV_TX_BUSY; /* signal qdisc layer */
>>>>> -    return NET_RX_SUCCESS;
>>>>> +    return NET_RX_SUCCESS; /* same as NETDEV_TX_OK */
>>>>>   }
>>>>>   static int veth_forward_skb(struct net_device *dev, struct 
>>>>> sk_buff *skb,
>>>>> @@ -346,11 +344,11 @@ static netdev_tx_t veth_xmit(struct sk_buff 
>>>>> *skb, struct net_device *dev)
>>>>>   {
>>>>>       struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
>>>>>       struct veth_rq *rq = NULL;
>>>>> -    int ret = NETDEV_TX_OK;
>>>>> +    struct netdev_queue *txq;
>>>>>       struct net_device *rcv;
>>>>>       int length = skb->len;
>>>>>       bool use_napi = false;
>>>>> -    int rxq;
>>>>> +    int ret, rxq;
>>>>>       rcu_read_lock();
>>>>>       rcv = rcu_dereference(priv->peer);
>>>>> @@ -373,17 +371,45 @@ static netdev_tx_t veth_xmit(struct sk_buff 
>>>>> *skb, struct net_device *dev)
>>>>>       }
>>>>>       skb_tx_timestamp(skb);
>>>>> -    if (likely(veth_forward_skb(rcv, skb, rq, use_napi) == 
>>>>> NET_RX_SUCCESS)) {
>>>>> +
>>>>> +    ret = veth_forward_skb(rcv, skb, rq, use_napi);
>>>>> +    switch (ret) {
>>>>> +    case NET_RX_SUCCESS: /* same as NETDEV_TX_OK */
>>>>>           if (!use_napi)
>>>>>               dev_sw_netstats_tx_add(dev, 1, length);
>>>>>           else
>>>>>               __veth_xdp_flush(rq);
>>>>> -    } else {
>>>>> +        break;
>>>>> +    case NETDEV_TX_BUSY:
>>>>> +        /* If a qdisc is attached to our virtual device, returning
>>>>> +         * NETDEV_TX_BUSY is allowed.
>>>>> +         */
>>>>> +        txq = netdev_get_tx_queue(dev, rxq);
>>>>> +
>>>>> +        if (qdisc_txq_has_no_queue(txq)) {
>>>>> +            dev_kfree_skb_any(skb);
>>>>> +            goto drop;
>>>>> +        }
>>>>> +        /* Restore Eth hdr pulled by 
>>>>> dev_forward_skb/eth_type_trans */
>>>>> +        __skb_push(skb, ETH_HLEN);
>>>>> +        /* Depend on prior success packets started NAPI consumer via
>>>>> +         * __veth_xdp_flush(). Cancel TXQ stop if consumer stopped,
>>>>> +         * paired with empty check in veth_poll().
>>>>> +         */
>>>>> +        netif_tx_stop_queue(txq);
>>>>> +        smp_mb__after_atomic();
>>>>> +        if (unlikely(__ptr_ring_empty(&rq->xdp_ring)))
>>>>> +            netif_tx_wake_queue(txq);
>>>>> +        break;
>>>>> +    case NET_RX_DROP: /* same as NET_XMIT_DROP */
>>>>>   drop:
>>>>>           atomic64_inc(&priv->dropped);
>>>>>           ret = NET_XMIT_DROP;
>>>>> +        break;
>>>>> +    default:
>>>>> +        net_crit_ratelimited("%s(%s): Invalid return code(%d)",
>>>>> +                     __func__, dev->name, ret);
>>>>>       }
>>>>> -
>>>>>       rcu_read_unlock();
>>>>>       return ret;
>>>>> @@ -874,9 +900,17 @@ static int veth_xdp_rcv(struct veth_rq *rq, 
>>>>> int budget,
>>>>>               struct veth_xdp_tx_bq *bq,
>>>>>               struct veth_stats *stats)
>>>>>   {
>>>>> +    struct veth_priv *priv = netdev_priv(rq->dev);
>>>>> +    int queue_idx = rq->xdp_rxq.queue_index;
>>>>> +    struct netdev_queue *peer_txq;
>>>>> +    struct net_device *peer_dev;
>>>>>       int i, done = 0, n_xdpf = 0;
>>>>>       void *xdpf[VETH_XDP_BATCH];
>>>>> +    /* NAPI functions as RCU section */
>>>>> +    peer_dev = rcu_dereference_check(priv->peer, 
>>>>> rcu_read_lock_bh_held());
>>>>> +    peer_txq = netdev_get_tx_queue(peer_dev, queue_idx);
>>>>> +
>>>>>       for (i = 0; i < budget; i++) {
>>>>>           void *ptr = __ptr_ring_consume(&rq->xdp_ring);
>>>>>
>>>>
>>>> Hi Jesper.
>>>>
>>>> Could you please take a look at the reported call traces and help
>>>> understand whether this patch may have introduced a null dereference?
>>>
>>> I'm investigating... thanks for reporting.
> 
> Thank you for looking into this.
> 
>>> (more below)
>>>
>>>> Pasting a snippet, for full logs (2 examples) see the link:
>>>> https://lore.kernel.org/bpf/6fd7a5b5- 
>>>> ee26-4cc5-8eb0-449c4e326ccc@linux.dev/
>>
>> Do you have any qdisc's attached to the veth device when reproducing?
> 
> Looking at the selftest code, I don't see any qdisc set up in the
> create_network. But I am not familiar with all this, and could be
> wrong.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c#n172
> 
>>
>> Via above link I see that you managed to reproduce by running BPF 
>> selftest "xdp_veth_broadcast_redirect".  (Is this correct?)
>>
>> How often does this happen?
> 
> So far I wasn't able to reproduce it locally.
> 
> It does not happen often. There were two failures on BPF CI out of
> 100+ runs in the past couple of days:
> 
> * One on bpf-next:
>    * 
> https://github.com/kernel-patches/bpf/commit/e41079f53e8792c99cc8888f545c31bc341ea9ac
>    * 
> https://github.com/kernel-patches/bpf/actions/runs/15543380196/job/43759847203
> * One on netdev tree (netdev merged into bpf-next):
>    * 
> https://github.com/kernel-patches/bpf/commit/6f3b8b4f8c133ff4eaf3fb74865731d2105c77eb
>    * 
> https://github.com/kernel-patches/bpf/actions/runs/15563091012/job/43820682289
> 
> Click on a gear in top-right and "View raw logs" for full logs.
> Note that you can download kbuild-output from the job artifacts.
> 
> Also a syzbot report does not involve the selftests:
> * https://lore.kernel.org/lkml/683da55e.a00a0220.d8eae.0052.GAE@google.com/
> 
>>
>> Does this only happen with XDP redirected frames?
>> (Func veth_xdp_rcv() also active for SKBs when veth is in GRO mode)
> 
> 
> Sorry, I don't know an answer to this... Bastien, could you please comment?
> 
> It seems to happen after xdp_veth_broadcast_redirect test successfully
> completed, so before/during xdp_veth_egress tests.
> 
>>
>> I'm not able to reproduce this running selftests (bpf-next at 
>> 5fcf896efe28c)
>> Below example selecting all "xdp_veth*" related tests:
>>
>> $ sudo ./test_progs --name=xdp_veth
>> #630/1   xdp_veth_broadcast_redirect/0/BROADCAST:OK
>> #630/2   xdp_veth_broadcast_redirect/0/(BROADCAST | EXCLUDE_INGRESS):OK
>> #630/3   xdp_veth_broadcast_redirect/DRV_MODE/BROADCAST:OK
>> #630/4   xdp_veth_broadcast_redirect/DRV_MODE/(BROADCAST | 
>> EXCLUDE_INGRESS):OK
>> #630/5   xdp_veth_broadcast_redirect/SKB_MODE/BROADCAST:OK
>> #630/6   xdp_veth_broadcast_redirect/SKB_MODE/(BROADCAST | 
>> EXCLUDE_INGRESS):OK
>> #630     xdp_veth_broadcast_redirect:OK
>> #631/1   xdp_veth_egress/0/egress:OK
>> #631/2   xdp_veth_egress/DRV_MODE/egress:OK
>> #631/3   xdp_veth_egress/SKB_MODE/egress:OK
>> #631     xdp_veth_egress:OK
>> #632/1   xdp_veth_redirect/0:OK
>> #632/2   xdp_veth_redirect/DRV_MODE:OK
>> #632/3   xdp_veth_redirect/SKB_MODE:OK
>> #632     xdp_veth_redirect:OK
>> Summary: 3/12 PASSED, 0 SKIPPED, 0 FAILED
>>
>>
>>>> [  343.217465] BUG: kernel NULL pointer dereference, address: 
>>>> 0000000000000018
>>>> [  343.218173] #PF: supervisor read access in kernel mode
>>>> [  343.218644] #PF: error_code(0x0000) - not-present page
>>>> [  343.219128] PGD 0 P4D 0
>>>> [  343.219379] Oops: Oops: 0000 [#1] SMP NOPTI
>>>> [  343.219768] CPU: 1 UID: 0 PID: 7635 Comm: kworker/1:11 Tainted: G
>>>>      W  OE       6.15.0-g2b36f2252b0a-dirty #7 PREEMPT(full)
>>                              ^^^^^^^^^^^^
>> The SHA 2b36f2252b0 doesn't seem to exist.
>> What upstream kernel commit SHA is this kernel based on?
> 
> This sha isn't very helpful, unfortunately, because CI adds commits on
> top. See the links to github I shared above for exact revisions.
> 
>>
>>>> [  343.220844] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>>>> [  343.221436] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 
>>>> 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>>>> [  343.222356] Workqueue: mld mld_dad_work
>>>> [  343.222730] RIP: 0010:veth_xdp_rcv.constprop.0+0x6b/0x380
>>>>
>>>
>>> Can you give me the output from below command (on your compiled kernel):
>>>
>>>   ./scripts/faddr2line drivers/net/veth.o veth_xdp_rcv.constprop.0+0x6b
>>>
>>
>> Still need above data/info please.
> 
> root@devvm7589:/ci/workspace# ./scripts/faddr2line 
> ./kout.gcc/drivers/net/veth.o veth_xdp_rcv.constprop.0+0x6b
> veth_xdp_rcv.constprop.0+0x6b/0x390:
> netdev_get_tx_queue at 
> /ci/workspace/kout.gcc/../include/linux/netdevice.h:2637
> (inlined by) veth_xdp_rcv at 
> /ci/workspace/kout.gcc/../drivers/net/veth.c:912
> 
> Which is:
> 
> veth.c:912
>      struct veth_priv *priv = netdev_priv(rq->dev);
>      int queue_idx = rq->xdp_rxq.queue_index;
>      struct netdev_queue *peer_txq;
>      struct net_device *peer_dev;
>      int i, done = 0, n_xdpf = 0;
>      void *xdpf[VETH_XDP_BATCH];
> 
>      /* NAPI functions as RCU section */
>      peer_dev = rcu_dereference_check(priv->peer, rcu_read_lock_bh_held());
>   --->    peer_txq = netdev_get_tx_queue(peer_dev, queue_idx);
> 
> netdevice.h:2637
>      static inline
>      struct netdev_queue *netdev_get_tx_queue(const struct net_device *dev,
>                       unsigned int index)
>      {
>          DEBUG_NET_WARN_ON_ONCE(index >= dev->num_tx_queues);
>   --->        return &dev->_tx[index];
>      }
> 
> So the suspect is peer_dev (priv->peer)?

Yes, this is the problem!

So, it seems that peer_dev (priv->peer) can become a NULL pointer.

Managed to reproduce - via manually deleting the peer device:
  - ip link delete dev veth42
  - while overloading veth41 via XDP redirecting packets into it.

Managed to trigger concurrent crashes on two CPUs (C0 + C3)
  - so below output gets interlaced a bit:

[26700.481334][    C0] BUG: kernel NULL pointer dereference, address: 
0000000000000438
[26700.489097][    C0] #PF: supervisor read access in kernel mode
[26700.495008][    C0] #PF: error_code(0x0000) - not-present page
[26700.500920][    C0] PGD 0 P4D 0
[26700.504233][    C0] Oops: Oops: 0000 [#1] SMP PTI
[26700.509023][    C0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G 
         O     N  6.15.0-bpf-next+ #40 PREEMPT(full)
[26700.520173][    C0] Tainted: [O]=OOT_MODULE, [N]=TEST
[26700.525305][    C0] Hardware name: Supermicro Super Server/X10SRi-F, 
BIOS 2.0a 08/01/2016
[26700.533582][    C0] RIP: 0010:veth_xdp_rcv.constprop.0+0x37/0x2c0
[26700.539766][    C0] Code: 55 41 89 f5 41 54 55 53 48 89 fb 48 81 ec 
90 00 00 00 8b 87 48 03 00 00 48 89 14 24 48 8b 97 f8 01 00 00 48 8b 92 
c0 09 00 00 <3b> 82 38 04 00 00 0f 83 6d 02 00 00 4c 8d 3c 80 49 c1 e7 
06 4c 03
[26700.559359][    C0] RSP: 0000:ffffc90000003cb0 EFLAGS: 00010282
[26700.565367][    C0] RAX: 0000000000000000 RBX: ffff888160e5c000 RCX: 
ffffc90000003d78
[26700.573300][    C0] RDX: 0000000000000000 RSI: 0000000000000040 RDI: 
ffff888160e5c000
[26700.581233][    C0] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000101
[26700.589161][    C0] R10: ffffffff830080c0 R11: 0000000000000000 R12: 
0000000000000040
[26700.597092][    C0] R13: 0000000000000040 R14: ffffc90000003d78 R15: 
ffff88887fc2d400
[26700.605022][    C0] FS:  0000000000000000(0000) 
GS:ffff8888fbe16000(0000) knlGS:0000000000000000
[26700.613909][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[26700.620437][    C0] CR2: 0000000000000438 CR3: 000000010466c003 CR4: 
00000000003726f0
[26700.628370][    C0] DR0: ffffffff83f801a4 DR1: ffffffff83f801a5 DR2: 
ffffffff83f801a2
[26700.636301][    C0] DR3: ffffffff83f801a3 DR6: 00000000fffe0ff0 DR7: 
0000000000000600
[26700.644232][    C0] Call Trace:
[26700.647453][    C0]  <IRQ>
[26700.650243][    C0]  ? 
bpf_prog_4666c41a92ffb35e_tp_xdp_devmap_xmit_multi+0x129/0x1aa
[26700.658177][    C0]  ? bpf_trace_run5+0x78/0xe0
[26700.662788][    C0]  veth_poll+0x62/0x210
[26700.666878][    C0]  ? mlx5e_napi_poll+0x35c/0x710 [mlx5_core]
[26700.672887][    C0]  __napi_poll+0x2b/0x1f0
[26700.677155][    C0]  net_rx_action+0x352/0x400
[26700.681682][    C0]  handle_softirqs+0xe6/0x2d0
[26700.686300][    C0]  irq_exit_rcu+0x9d/0xc0
[26700.690565][    C0]  common_interrupt+0x81/0xa0
[26700.695183][    C0]  </IRQ>
[26700.698056][    C0]  <TASK>
[26700.700936][    C0]  asm_common_interrupt+0x22/0x40
[26700.705898][    C0] RIP: 0010:cpuidle_enter_state+0xc2/0x430
[26700.711643][    C0] Code: 00 e8 02 99 35 ff e8 8d f8 ff ff 8b 53 04 
49 89 c5 0f 1f 44 00 00 31 ff e8 4b 0c 34 ff 45 84 ff 0f 85 49 02 00 00 
fb 45 85 f6 <0f> 88 8a 01 00 00 49 63 ce 4c 8b 14 24 48 8d 04 49 48 8d 
14 81 48
[26700.731229][    C0] RSP: 0000:ffffffff83003e48 EFLAGS: 00000202
[26700.737229][    C0] RAX: ffff8888fbe16000 RBX: ffff88887fc347c0 RCX: 
000000000000001f
[26700.745165][    C0] RDX: 0000000000000000 RSI: 00000000238e3e11 RDI: 
0000000000000000
[26700.753095][    C0] RBP: 0000000000000002 R08: 0000000000000002 R09: 
0000000000000006
[26700.761025][    C0] R10: 00000000ffffffff R11: 0000000000000000 R12: 
ffffffff83350c40
[26700.768956][    C0] R13: 00001848b0b34003 R14: 0000000000000002 R15: 
0000000000000000
[26700.776885][    C0]  ? cpuidle_enter_state+0xb5/0x430
[26700.782019][    C0]  cpuidle_enter+0x29/0x40
[26700.786375][    C0]  do_idle+0x171/0x1d0
[26700.790378][    C0]  cpu_startup_entry+0x25/0x30
[26700.795076][    C0]  rest_init+0xcc/0xd0
[26700.799081][    C0]  start_kernel+0x379/0x5b0
[26700.803520][    C0]  x86_64_start_reservations+0x14/0x30
[26700.808910][    C0]  x86_64_start_kernel+0xcb/0xd0
[26700.813782][    C0]  common_startup_64+0x13e/0x148
[26700.818662][    C0]  </TASK>
[26700.821628][    C0] Modules linked in: iptable_filter ip_tables 
x_tables nf_defrag_ipv6 nf_defrag_ipv4 rpcrdma rdma_ucm ib_umad ib_ipoib 
rdma_cm iw_cm ib_cm mlx5_ib macsec ib_uverbs ib_core mlx5_core sunrpc 
intel_uncore_frequency intel_uncore_frequency_common coretemp i40e ixgbe 
bnxt_en igb i2c_i801 igc rapl intel_cstate mei_me psample mdio libie 
i2c_smbus acpi_ipmi ptp intel_uncore pcspkr mei i2c_algo_bit pps_core 
wmi ipmi_si ipmi_devintf ipmi_msghandler acpi_pad bfq sch_fq_codel drm 
i2c_core dm_multipath nfnetlink zram 842_decompress lz4hc_compress 
842_compress zstd_compress hid_generic scsi_dh_rdac fuse [last unloaded: 
nf_conntrack]
[26700.878187][    C0] CR2: 0000000000000438
[26700.882282][    C0] ---[ end trace 0000000000000000 ]---
[26700.882283][    C3] BUG: kernel NULL pointer dereference, address: 
0000000000000438
[26700.890195][    C0] pstore: backend (erst) writing error (-28)
[26700.895228][    C3] #PF: supervisor read access in kernel mode
[26700.901054][    C0] RIP: 0010:veth_xdp_rcv.constprop.0+0x37/0x2c0
[26700.906877][    C3] #PF: error_code(0x0000) - not-present page
[26700.912960][    C0] Code: 55 41 89 f5 41 54 55 53 48 89 fb 48 81 ec 
90 00 00 00 8b 87 48 03 00 00 48 89 14 24 48 8b 97 f8 01 00 00 48 8b 92 
c0 09 00 00 <3b> 82 38 04 00 00 0f 83 6d 02 00 00 4c 8d 3c 80 49 c1 e7 
06 4c 03
[26700.918786][    C3] PGD 0
[26700.938217][    C0] RSP: 0000:ffffc90000003cb0 EFLAGS: 00010282
[26700.938308][    C3] P4D 0
[26700.941016][    C0]
[26700.946927][    C3]
[26700.949629][    C0] RAX: 0000000000000000 RBX: ffff888160e5c000 RCX: 
ffffc90000003d78
[26700.951815][    C3] Oops: Oops: 0000 [#2] SMP PTI
[26700.953997][    C0] RDX: 0000000000000000 RSI: 0000000000000040 RDI: 
ffff888160e5c000
[26700.961816][    C3] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Tainted: G 
    D    O     N  6.15.0-bpf-next+ #40 PREEMPT(full)
[26700.966513][    C0] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000101
[26700.974331][    C3] Tainted: [D]=DIE, [O]=OOT_MODULE, [N]=TEST
[26700.985356][    C0] R10: ffffffff830080c0 R11: 0000000000000000 R12: 
0000000000000040
[26700.993173][    C3] Hardware name: Supermicro Super Server/X10SRi-F, 
BIOS 2.0a 08/01/2016
[26700.998995][    C0] R13: 0000000000000040 R14: ffffc90000003d78 R15: 
ffff88887fc2d400
[26701.006813][    C3] RIP: 0010:veth_xdp_rcv.constprop.0+0x37/0x2c0
[26701.014977][    C0] FS:  0000000000000000(0000) 
GS:ffff8888fbe16000(0000) knlGS:0000000000000000
[26701.022796][    C3] Code: 55 41 89 f5 41 54 55 53 48 89 fb 48 81 ec 
90 00 00 00 8b 87 48 03 00 00 48 89 14 24 48 8b 97 f8 01 00 00 48 8b 92 
c0 09 00 00 <3b> 82 38 04 00 00 0f 83 6d 02 00 00 4c 8d 3c 80 49 c1 e7 
06 4c 03
[26701.028879][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[26701.037650][    C3] RSP: 0018:ffffc900001accb0 EFLAGS: 00010282
[26701.057082][    C0] CR2: 0000000000000438 CR3: 000000010466c003 CR4: 
00000000003726f0
[26701.063511][    C3]
[26701.069423][    C0] DR0: ffffffff83f801a4 DR1: ffffffff83f801a5 DR2: 
ffffffff83f801a2
[26701.077241][    C3] RAX: 0000000000000003 RBX: ffff888160e5cb40 RCX: 
ffffc900001acd78
[26701.079423][    C0] DR3: ffffffff83f801a3 DR6: 00000000fffe0ff0 DR7: 
0000000000000600
[26701.087242][    C3] RDX: 0000000000000000 RSI: 0000000000000040 RDI: 
ffff888160e5cb40
[26701.095059][    C0] Kernel panic - not syncing: Fatal exception in 
interrupt
[26702.123660][    C0] Shutting down cpus with NMI
[26702.138666][    C0] Kernel Offset: disabled
[26702.145524][    C0] ---[ end Kernel panic - not syncing: Fatal 
exception in interrupt ]---


>>
>>>>      [...] >>>>
>>>>> @@ -925,6 +959,9 @@ static int veth_xdp_rcv(struct veth_rq *rq, int 
>>>>> budget,
>>>>>       rq->stats.vs.xdp_packets += done;
>>>>>       u64_stats_update_end(&rq->stats.syncp);
>>>>> +    if (unlikely(netif_tx_queue_stopped(peer_txq)))
>>>>> +        netif_tx_wake_queue(peer_txq);
>>>>> +
>>>>>       return done;
>>>>>   }


A fix could look like this:

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index e58a0f1b5c5b..a3046142cb8e 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -909,7 +909,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,

         /* NAPI functions as RCU section */
         peer_dev = rcu_dereference_check(priv->peer, 
rcu_read_lock_bh_held());
-       peer_txq = netdev_get_tx_queue(peer_dev, queue_idx);
+       peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : 
NULL;

         for (i = 0; i < budget; i++) {
                 void *ptr = __ptr_ring_consume(&rq->xdp_ring);
@@ -959,7 +959,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
         rq->stats.vs.xdp_packets += done;
         u64_stats_update_end(&rq->stats.syncp);

-       if (unlikely(netif_tx_queue_stopped(peer_txq)))
+       if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq)))
                 netif_tx_wake_queue(peer_txq);




--Jesper



