Return-Path: <bpf+bounces-70146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7380CBB1AE8
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 22:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497EC19C1645
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 20:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEC42F4A12;
	Wed,  1 Oct 2025 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ixySQk/g"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167552EE5F0
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350377; cv=none; b=N+RGp7JHJPZxy1sTooJ4IZfKHf19FmVpl66PYWyEjJlF8REGXoCMWIXvi39VGVhzrFWvmnX4xq8NJh0xYrZCM3ooDjRlv8rzkfFT7xNPYgmnSmFGCXO44CZ0749YAQfrNaj2nlXf5+XU4XwzOzzLUiJqGBxYdxKKXIs9ik1FOXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350377; c=relaxed/simple;
	bh=NQiQI9Q807hjIqkGXtbtLBXHnERC+TQrUUDR+mdzQ68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9OBSW0fm19wxOLvEl3oh8fU5QxDR49oKdudR0zwtsSftvHUVPICON2rBQ1b4xyq/vT1MTKUhCJ3v3v5bk3gnzYhcavuGx9ROPuzouvl8icnqvfJKOPnxd+gs6KgWpgCbsZ8z8rBD2CIiw3zxLsqo6v/yf4SGDESIW+xT36nh6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ixySQk/g; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5af7b3b9-3ee1-4ef6-8431-72b40445eacd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759350372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQlL5ywedBvZh8hykIOnAi0mUaP1OP0jkHJ2QU5nW7k=;
	b=ixySQk/gncD8iFibP60t+sPzMI1CRJG1GB98bznJC66nImeTLb772t+5YozM78gIfjklpi
	0Ojb5ftkiRO+ayRtNQzuLhbw6WbJffzvgEQD7VknxI3R5KNUJIKKFWHonBzzrr0CdRsV0j
	wNzlZHoTG7ZohOHIUwRwvCznFIJb1nU=
Date: Wed, 1 Oct 2025 13:26:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] xdp: update mem type when page pool is used for
 generic XDP
To: Octavian Purdila <tavip@google.com>, kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, kuniyu@google.com,
 aleksander.lobakin@intel.com, maciej.fijalkowski@intel.com, toke@redhat.com,
 lorenzo@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,
 Kernel Team <kernel-team@meta.com>
References: <20251001074704.2817028-1-tavip@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20251001074704.2817028-1-tavip@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/1/25 12:47 AM, Octavian Purdila wrote:
> When a BPF program that supports BPF_F_XDP_HAS_FRAGS is issuing
> bpf_xdp_adjust_tail and a large packet is injected via /dev/net/tun a
> crash occurs due to detecting a bad page state (page_pool leak).
> 
> This is because xdp_buff does not record the type of memory and
> instead relies on the netdev receive queue xdp info. Since
> netif_alloc_rx_queues only calls xdp_rxq_info_reg mem.type is going to
> be set to MEM_TYPE_PAGE_SHARED. So shrinking will eventually call
> page_frag_free. But with current multi-buff support for
> BPF_F_XDP_HAS_FRAGS programs buffers are allocated via the page pool
> in skb_cow_data_for_xdp.
> 
> To fix this issue use the same approach that is used in
> cpu_map_bpf_prog_run_xdp: declare an xdp_rxq_info structure on the
> stack instead of using the xdp_rxq_info structure from the netdev rx
> queue. And update mem.type to reflect how the buffers are allocated,
> in this case to MEM_TYPE_PAGE_POOL if skb_cow_data_for_xdp is used.
> 
> Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6756c37b.050a0220.a30f1.019a.GAE@google.com/
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
> Signed-off-by: Octavian Purdila <tavip@google.com>
> ---
> 
> v2:
> - use a local xdp_rxq_info structure and update mem.type instead of
>   skipping using page pool if the netdev xdp_rxq_info is not set to
>   MEM_TYPE_PAGE_POOL (which is always the case currently)
> v1: https://lore.kernel.org/netdev/20250924060843.2280499-1-tavip@google.com/
> 
>  include/linux/netdevice.h |  4 +++-
>  kernel/bpf/cpumap.c       |  2 +-
>  kernel/bpf/devmap.c       |  2 +-
>  net/core/dev.c            | 32 +++++++++++++++++++++-----------
>  4 files changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index f3a3b761abfb..41585414e45c 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -78,6 +78,7 @@ struct udp_tunnel_nic_info;
>  struct udp_tunnel_nic;
>  struct bpf_prog;
>  struct xdp_buff;
> +struct xdp_rxq_info;
>  struct xdp_frame;
>  struct xdp_metadata_ops;
>  struct xdp_md;
> @@ -4149,7 +4150,8 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
>  }
>  
>  u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
> -			     const struct bpf_prog *xdp_prog);
> +			     const struct bpf_prog *xdp_prog,
> +			     struct xdp_rxq_info *rxq);
>  void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog);
>  int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb);
>  int netif_rx(struct sk_buff *skb);
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index c46360b27871..a057a58ba969 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -145,7 +145,7 @@ static u32 cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
>  	for (u32 i = 0; i < skb_n; i++) {
>  		struct sk_buff *skb = skbs[i];
>  
> -		act = bpf_prog_run_generic_xdp(skb, &xdp, rcpu->prog);
> +		act = bpf_prog_run_generic_xdp(skb, &xdp, rcpu->prog, NULL);
>  		switch (act) {
>  		case XDP_PASS:
>  			skbs[pass++] = skb;
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 482d284a1553..29459b79bacb 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -512,7 +512,7 @@ static u32 dev_map_bpf_prog_run_skb(struct sk_buff *skb, struct bpf_dtab_netdev
>  	__skb_pull(skb, skb->mac_len);
>  	xdp.txq = &txq;
>  
> -	act = bpf_prog_run_generic_xdp(skb, &xdp, dst->xdp_prog);
> +	act = bpf_prog_run_generic_xdp(skb, &xdp, dst->xdp_prog, NULL);
>  	switch (act) {
>  	case XDP_PASS:
>  		__skb_push(skb, skb->mac_len);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 8d49b2198d07..365c43ffc9c1 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5230,10 +5230,10 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
>  }
>  
>  u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
> -			     const struct bpf_prog *xdp_prog)
> +			     const struct bpf_prog *xdp_prog,
> +			     struct xdp_rxq_info *rxq)
>  {
>  	void *orig_data, *orig_data_end, *hard_start;
> -	struct netdev_rx_queue *rxqueue;
>  	bool orig_bcast, orig_host;
>  	u32 mac_len, frame_sz;
>  	__be16 orig_eth_type;
> @@ -5251,8 +5251,9 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>  	frame_sz = (void *)skb_end_pointer(skb) - hard_start;
>  	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  
> -	rxqueue = netif_get_rxqueue(skb);
> -	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
> +	if (!rxq)
> +		rxq = &netif_get_rxqueue(skb)->xdp_rxq;
> +	xdp_init_buff(xdp, frame_sz, rxq);
>  	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
>  			 skb_headlen(skb) + mac_len, true);
>  	if (skb_is_nonlinear(skb)) {
> @@ -5331,17 +5332,23 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>  	return act;
>  }


Hi Octavian,

This patch seems to be causing a null pointer dereference.
See a splat caught by BPF CI below.

You might be able to reproduce with:

cd tools/testing/selftests/bpf
make test_progs
# in kernel with this patch
./test_progs -t xdp_veth

Reverting this commit mitigates the failure:
https://github.com/linux-netdev/testing-bpf-ci/commit/9e1eab63cd1bcbe37e205856f7ff7d1ad49669f5

Could you please take a look?


$ ./scripts/faddr2line ./net/core/dev.o bpf_prog_run_generic_xdp+0x536
bpf_prog_run_generic_xdp+0x536/0x1050:
__netif_receive_skb_list_core at /home/isolodrai/kernels/linux/./include/linux/filter.h:?

Splat:

2025-10-01T18:17:31.5122455Z #651     xdp_synproxy:OK
2025-10-01T18:17:42.3676827Z [  579.623193] BUG: kernel NULL pointer dereference, address: 00000000000000e0
2025-10-01T18:17:42.3679754Z [  579.623890] #PF: supervisor read access in kernel mode
2025-10-01T18:17:42.3683498Z [  579.624392] #PF: error_code(0x0000) - not-present page
2025-10-01T18:17:42.3685646Z [  579.624781] PGD 0 P4D 0
2025-10-01T18:17:42.3688931Z [  579.625000] Oops: Oops: 0000 [#1] SMP KASAN NOPTI
2025-10-01T18:17:42.3697156Z [  579.625326] CPU: 0 UID: 0 PID: 1027 Comm: kworker/0:7 Tainted: G        W  OE       6.17.0-rc7-g353b4dc5171a-dirty #1 PREEMPT(full)
2025-10-01T18:17:42.3701106Z [  579.626121] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
2025-10-01T18:17:42.3707833Z [  579.626537] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
2025-10-01T18:17:42.3710307Z [  579.627196] Workqueue: mld mld_ifc_work
2025-10-01T18:17:42.3715764Z [  579.627466] RIP: 0010:bpf_prog_5933448505fe5d21_xdp_redirect_map_multi_prog+0x41/0xe9
2025-10-01T18:17:42.3730250Z [  579.627995] Code: 08 00 00 00 53 b8 01 00 00 00 48 8b 57 08 48 8b 77 00 48 89 f1 48 83 c1 0e 48 39 d1 0f 87 a9 00 00 00 48 8b 5f 20 48 8b 5b 00 <8b> 9b e0 00 00 00 48 0f b6 7e 0c 48 0f b6 76 0d c1 e6 08 09 fe 66
2025-10-01T18:17:42.3731737Z [  579.629231] RSP: 0018:ffffc90000007778 EFLAGS: 00010297
2025-10-01T18:17:42.3736558Z [  579.629602] RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff888107798110
2025-10-01T18:17:42.3741383Z [  579.630082] RDX: ffff88810779815c RSI: ffff888107798102 RDI: ffffc90000007948
2025-10-01T18:17:42.3746171Z [  579.630560] RBP: ffffc90000007788 R08: ffff888107798ee3 R09: 1ffff11020ef31dc
2025-10-01T18:17:42.3750937Z [  579.631039] R10: dffffc0000000000 R11: ffffed1020ef31dd R12: ffffc90000007948
2025-10-01T18:17:42.3755794Z [  579.631519] R13: 1ffff92000000f2a R14: dffffc0000000000 R15: ffffc9000316f060
2025-10-01T18:17:42.3761599Z [  579.631999] FS:  0000000000000000(0000) GS:ffff888162441000(0000) knlGS:0000000000000000
2025-10-01T18:17:42.3765107Z [  579.632539] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2025-10-01T18:17:42.3769941Z [  579.632938] CR2: 00000000000000e0 CR3: 0000000105bae002 CR4: 0000000000770ef0
2025-10-01T18:17:42.3774730Z [  579.633421] DR0: 000055dd9fe121c0 DR1: 0000000000000000 DR2: 0000000000000000
2025-10-01T18:17:42.3779502Z [  579.633900] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
2025-10-01T18:17:42.3781786Z [  579.634376] PKRU: 55555554
2025-10-01T18:17:42.3784191Z [  579.634615] Call Trace:
2025-10-01T18:17:42.3786202Z [  579.634860]  <IRQ>
2025-10-01T18:17:42.3790811Z [  579.635060]  bpf_prog_run_generic_xdp+0x536/0x1040
2025-10-01T18:17:42.3794547Z [  579.635518]  do_xdp_generic+0x79f/0xe40
2025-10-01T18:17:42.3798463Z [  579.635910]  ? unwind_next_frame+0x1d06/0x25a0
2025-10-01T18:17:42.3802275Z [  579.636282]  ? do_xdp_generic+0x378/0xe40
2025-10-01T18:17:42.3805659Z [  579.636683]  ? __asan_memset+0x22/0x50
2025-10-01T18:17:42.3809203Z [  579.637005]  ? dl_server_update_idle_time+0x1e6/0x370
2025-10-01T18:17:42.3812506Z [  579.637376]  ? lock_is_held_type+0x95/0x130
2025-10-01T18:17:42.3817120Z [  579.637688]  __netif_receive_skb_core+0x113e/0x3110
2025-10-01T18:17:42.3821075Z [  579.638138]  ? __lock_acquire+0x5e5/0x2a80
2025-10-01T18:17:42.3824988Z [  579.638544]  ? lock_is_held_type+0x95/0x130
2025-10-01T18:17:42.3828694Z [  579.638940]  __netif_receive_skb+0x6d/0x310
2025-10-01T18:17:42.3832414Z [  579.639307]  ? lock_release+0xff/0x330
2025-10-01T18:17:42.3836338Z [  579.639677]  ? process_backlog+0x2de/0xf30
2025-10-01T18:17:42.3839804Z [  579.640068]  process_backlog+0x87b/0xf30
2025-10-01T18:17:42.3843676Z [  579.640420]  ? process_backlog+0x2de/0xf30
2025-10-01T18:17:42.3846948Z [  579.640805]  __napi_poll+0x98/0x2c0
2025-10-01T18:17:42.3851782Z [  579.641129]  ? lockdep_hardirqs_on_prepare+0x115/0x250
2025-10-01T18:17:42.3855038Z [  579.641635]  net_rx_action+0x404/0x9a0
2025-10-01T18:17:42.3858674Z [  579.641948]  handle_softirqs+0x24d/0x790
2025-10-01T18:17:42.3861893Z [  579.642329]  ? do_softirq+0x6f/0xb0
2025-10-01T18:17:42.3865863Z [  579.642641]  ? __dev_queue_xmit+0x12d/0x2640
2025-10-01T18:17:42.3869402Z [  579.643024]  do_softirq+0x6f/0xb0
2025-10-01T18:17:42.3870950Z [  579.643380]  </IRQ>
2025-10-01T18:17:42.3872470Z [  579.643532]  <TASK>
2025-10-01T18:17:42.3875951Z [  579.643685]  __local_bh_enable_ip+0x11d/0x160
2025-10-01T18:17:42.3879177Z [  579.644032]  ? __dev_queue_xmit+0x12d/0x2640
2025-10-01T18:17:42.3882770Z [  579.644374]  __dev_queue_xmit+0xd61/0x2640
2025-10-01T18:17:42.3886175Z [  579.644713]  ? __dev_queue_xmit+0x12d/0x2640
2025-10-01T18:17:42.3889313Z [  579.645055]  ? lock_acquire+0xef/0x260
2025-10-01T18:17:42.3894058Z [  579.645369]  ? ipv6_chk_mcast_addr+0x2c/0x610
2025-10-01T18:17:42.3897287Z [  579.645845]  ? lock_acquire+0xef/0x260
2025-10-01T18:17:42.3901267Z [  579.646164]  ? ip6_finish_output+0x2f9/0x7a0
2025-10-01T18:17:42.3905693Z [  579.646564]  ? ip6_finish_output2+0xd0c/0x1620
2025-10-01T18:17:42.3909956Z [  579.647006]  ip6_finish_output2+0xf64/0x1620
2025-10-01T18:17:42.3913138Z [  579.647433]  ip6_finish_output+0x2f9/0x7a0
2025-10-01T18:17:42.3915927Z [  579.647744]  ip6_output+0x22b/0x3b0
2025-10-01T18:17:42.3919351Z [  579.648032]  ? ip6_output+0xce/0x3b0
2025-10-01T18:17:42.3922445Z [  579.648375]  NF_HOOK+0xb6/0x320
2025-10-01T18:17:42.3926286Z [  579.648680]  ? __pfx_dst_output+0x10/0x10
2025-10-01T18:17:42.3929621Z [  579.649076]  mld_sendpack+0x574/0x930
2025-10-01T18:17:42.3933216Z [  579.649404]  ? mld_sendpack+0x113/0x930
2025-10-01T18:17:42.3936845Z [  579.649762]  mld_ifc_work+0x63c/0xa30
2025-10-01T18:17:42.3942035Z [  579.650121]  ? process_scheduled_works+0x768/0x1120
2025-10-01T18:17:42.3945976Z [  579.650637]  ? process_scheduled_works+0x768/0x1120
2025-10-01T18:17:42.3950095Z [  579.651033]  process_scheduled_works+0x7ec/0x1120
2025-10-01T18:17:42.3953728Z [  579.651451]  worker_thread+0x83e/0xca0
2025-10-01T18:17:42.3956821Z [  579.651802]  kthread+0x4fa/0x620
2025-10-01T18:17:42.3960308Z [  579.652144]  ? do_raw_spin_lock+0xdf/0x260
2025-10-01T18:17:42.3964376Z [  579.652469]  ? __pfx_worker_thread+0x10/0x10
2025-10-01T18:17:42.3968056Z [  579.652880]  ? __pfx_kthread+0x10/0x10
2025-10-01T18:17:42.3971233Z [  579.653241]  ret_from_fork+0x1f8/0x2f0
2025-10-01T18:17:42.3974717Z [  579.653562]  ? __pfx_kthread+0x10/0x10
2025-10-01T18:17:42.3978585Z [  579.653927]  ret_from_fork_asm+0x1a/0x30
2025-10-01T18:17:42.3980595Z [  579.654318]  </TASK>
2025-10-01T18:17:42.3987171Z [  579.654511] Modules linked in: bpf_testmod(OE) [last unloaded: bpf_test_no_cfi(OE)]
2025-10-01T18:17:42.3990310Z [  579.655141] CR2: 00000000000000e0
2025-10-01T18:17:42.3994781Z [  579.655471] ---[ end trace 0000000000000000 ]---
2025-10-01T18:17:42.4000455Z [  579.655917] RIP: 0010:bpf_prog_5933448505fe5d21_xdp_redirect_map_multi_prog+0x41/0xe9
2025-10-01T18:17:42.4015489Z [  579.656468] Code: 08 00 00 00 53 b8 01 00 00 00 48 8b 57 08 48 8b 77 00 48 89 f1 48 83 c1 0e 48 39 d1 0f 87 a9 00 00 00 48 8b 5f 20 48 8b 5b 00 <8b> 9b e0 00 00 00 48 0f b6 7e 0c 48 0f b6 76 0d c1 e6 08 09 fe 66
2025-10-01T18:17:42.4017037Z [  579.657759] RSP: 0018:ffffc90000007778 EFLAGS: 00010297
2025-10-01T18:17:42.4021865Z [  579.658131] RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff888107798110
2025-10-01T18:17:42.4026639Z [  579.658607] RDX: ffff88810779815c RSI: ffff888107798102 RDI: ffffc90000007948
2025-10-01T18:17:42.4031381Z [  579.659086] RBP: ffffc90000007788 R08: ffff888107798ee3 R09: 1ffff11020ef31dc
2025-10-01T18:17:42.4036164Z [  579.659563] R10: dffffc0000000000 R11: ffffed1020ef31dd R12: ffffc90000007948
2025-10-01T18:17:42.4040923Z [  579.660041] R13: 1ffff92000000f2a R14: dffffc0000000000 R15: ffffc9000316f060
2025-10-01T18:17:42.4046423Z [  579.660518] FS:  0000000000000000(0000) GS:ffff888162441000(0000) knlGS:0000000000000000
2025-10-01T18:17:42.4050167Z [  579.661060] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2025-10-01T18:17:42.4055028Z [  579.661449] CR2: 00000000000000e0 CR3: 0000000105bae002 CR4: 0000000000770ef0
2025-10-01T18:17:42.4059819Z [  579.661929] DR0: 000055dd9fe121c0 DR1: 0000000000000000 DR2: 0000000000000000
2025-10-01T18:17:42.4064651Z [  579.662409] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
2025-10-01T18:17:42.4066378Z [  579.662888] PKRU: 55555554
2025-10-01T18:17:42.4070808Z [  579.663077] Kernel panic - not syncing: Fatal exception in interrupt
2025-10-01T18:17:42.4082805Z [  579.663739] Kernel Offset: 0x33000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)



>  
> -static int
> -netif_skb_check_for_xdp(struct sk_buff **pskb, const struct bpf_prog *prog)
> +static int netif_skb_check_for_xdp(struct sk_buff **pskb,
> +				   const struct bpf_prog *prog,
> +				   struct xdp_rxq_info *rxq)
>  {
>  	struct sk_buff *skb = *pskb;
>  	int err, hroom, troom;
> +	struct page_pool *pool;
>  
> +	pool = this_cpu_read(system_page_pool.pool);
>  	local_lock_nested_bh(&system_page_pool.bh_lock);
> -	err = skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool), pskb, prog);
> +	err = skb_cow_data_for_xdp(pool, pskb, prog);
>  	local_unlock_nested_bh(&system_page_pool.bh_lock);
> -	if (!err)
> +	if (!err) {
> +		rxq->mem.type = MEM_TYPE_PAGE_POOL;
> +		rxq->mem.id = pool->xdp_mem_id;
>  		return 0;
> +	}
>  
>  	/* In case we have to go down the path and also linearize,
>  	 * then lets do the pskb_expand_head() work just once here.
> @@ -5379,13 +5386,13 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
>  
>  	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
>  	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
> -		if (netif_skb_check_for_xdp(pskb, xdp_prog))
> +		if (netif_skb_check_for_xdp(pskb, xdp_prog, xdp->rxq))
>  			goto do_drop;
>  	}
>  
>  	__skb_pull(*pskb, mac_len);
>  
> -	act = bpf_prog_run_generic_xdp(*pskb, xdp, xdp_prog);
> +	act = bpf_prog_run_generic_xdp(*pskb, xdp, xdp_prog, xdp->rxq);
>  	switch (act) {
>  	case XDP_REDIRECT:
>  	case XDP_TX:
> @@ -5442,7 +5449,10 @@ int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb)
>  	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
>  
>  	if (xdp_prog) {
> -		struct xdp_buff xdp;
> +		struct xdp_rxq_info rxq = {};
> +		struct xdp_buff xdp = {
> +			.rxq = &rxq,
> +		};
>  		u32 act;
>  		int err;
>  


