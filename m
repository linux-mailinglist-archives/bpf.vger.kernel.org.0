Return-Path: <bpf+bounces-75136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F78C71ED8
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 04:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id A93E028FB3
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 03:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28772FF65B;
	Thu, 20 Nov 2025 03:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0gRwZpt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD112FB983
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 03:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608115; cv=none; b=qdZygaA9QkwTsnv0pCVZv3qqkGTC6EbKHC3Htut9oCtFHiYc24OhcnGsf/e3qha2Jq41TJdpVJsvVlpuCpFmrtpf6IEb65+w0ckTn9d2PX7oqZq9TiaQus6/SstMNtTd1XX99cuxMOGTI89KRMGrnC4YKVJcYq9iZaVrr06UeKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608115; c=relaxed/simple;
	bh=LWc+YyzwKddEYH1BLwPQrQKmAOnZ7KnyMrHMQ/PVKfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgnDVpuoYEMZ8CJF3cPyow/Iboy6RIL0q6tqvQksQ0LaEGxLSySFLXXmt/MAZQzt2lbqhTLbX1EDlId/FGHogBMlaTHBhe0IJZuHN4OYQrdnx6weEbwmrgN8NWpYq/59Ri07pRTp5syY4IVqvm2ec8/BuWLrvZx6E43zB0dUn9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0gRwZpt; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-435a16798feso5618275ab.0
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 19:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763608112; x=1764212912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caz26oMi+UCo3/uICHKg72NE/aBjorpU9oL32xhO52M=;
        b=X0gRwZptfBVG9rmX01E/tm+BGcKSn+iuqF2Kp1/MUCNRP1yRzd+6i/UrfbmLb7mbK/
         HCj+K2qRm85jkJQYfCyT4wDHdz/Wt9SnjiwC8aDp3SW9Uysq0HqVDKLS6tyjblO3897Q
         O1jkCD2bbePjtShenjcrIk9nSryk/00bUkDbs05rf1t1wmtyc3WKeXWX/2n5byCeqS1/
         TJENA0Ip8AK2+Zkz+GN36DqLtQdAWtrrZ4t/jRkoOCb2Ep4FhjJ8oymI4rTALp1olilb
         ktM+gm/aYe2exZqBPB2iuGlZwbKlhkzRTCeBnuAi9fOe38PdcBeauxVpKsNAX/+B4BOE
         fbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763608112; x=1764212912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=caz26oMi+UCo3/uICHKg72NE/aBjorpU9oL32xhO52M=;
        b=oGsMHTBaT1rJk8+2xsdRO8N/9zbfSSPDEBCVIaeiXsnJRVoGMz9bXY2HjrPtsjIO+a
         FO54RAYvg4rxgKkqVyu/9RKDOktfqlLe/BkYqswNVIhrWN+6skreDEAqFRHgH7B2vTZ9
         NZ6hIpa8f3YB219LhuKRIAN62HvkVSk6h0fi8oMSDrVTLCkPEb/QSmftQ3NM120MqhVU
         153TdaD0w6dpbvYr+qm+INrtR1Z5+GkZ+rqAGybahZ5PssQexjl4EuVxPdI8u/jh7AXu
         Y777+/6fHZSN4fsEwAoyXYgUU2OCY7YrvHLBttlcU/9ZYW0nQYHBiT65/hL/a/GrF/rJ
         SMhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF04sKQr94hJ4DjFgA1r4HjkD88ZfQR3v1pwcfpXezxzAjPU0ocBtAmxeHApji6SjxXmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyll1xubeoEb+dG6YNSs9FMIFXMAVcbaWUzY1bVULj6WegWP/3x
	3EjNpdgR0YRCSMW08EV4Dx4bJlc9PnMmyHIM2SPnIehIkd9WKW9jTseHABNWM41HTfv/+tDMHtD
	lDg00KOVjfsC1WJVs6932WydjKGDxuYo=
X-Gm-Gg: ASbGncusU6fWVw9UBsJ8sC2P9vpSQwoClwDZ+Z7cOndtLMYv0pjm8oEN+29vpE9CGfk
	b99KrUnQnbteG9o92XyX0emBDWshxd2CHvNMoXbbdBa2tXkY6W2C+AipnovgRqmj85thG8dDWHU
	fXqABnlcroz4PHWwhMaD3jdBm98YDNfzofXmY8KEeOwPalEK3TTJLW/nsrHjDW9MKlrnyv870/f
	53cU4i3wrGyNawsEj/5jexd7WCoocjTJ4CLod+ddr+g8NcMo1oV7MNryfI4foEp9HuWkZD2l4M=
X-Google-Smtp-Source: AGHT+IHaR9b0T87nOqgLhqAa0DJank0nJdbqq/07TQgzYVqAw9N/jxBiC1prwjQBWssZkM3WA2mpvO+F3evDnMgICUc=
X-Received: by 2002:a05:6e02:1c01:b0:433:1d5a:5157 with SMTP id
 e9e14a558f8ab-435aa88e822mr7773155ab.6.1763608112308; Wed, 19 Nov 2025
 19:08:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118124807.3229-1-fmancera@suse.de>
In-Reply-To: <20251118124807.3229-1-fmancera@suse.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 20 Nov 2025 11:07:55 +0800
X-Gm-Features: AWmQ_blcF7JKkzTpqpXShAh_9y-RFG0kF_LLQ5C0sMYCXypS6Q45OfVZ6lCWt3s
Message-ID: <CAL+tcoCthXqJS=z3-HhMSn3nfGzrqt8co3jKru-=YX0iJ2Yd6w@mail.gmail.com>
Subject: Re: [PATCH net v4] xsk: avoid data corruption on cq descriptor number
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, csmate@nop.hu, maciej.fijalkowski@intel.com, 
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 8:48=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> production"), the descriptor number is stored in skb control block and
> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> pool's completion queue.
>
> skb control block shouldn't be used for this purpose as after transmit
> xsk doesn't have control over it and other subsystems could use it. This
> leads to the following kernel panic due to a NULL pointer dereference.
>
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14-cloud-a=
md64 #1 PREEMPT(lazy)  Debian 6.16.12-1
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debia=
n-1.17.0-1 04/01/2014
>  RIP: 0010:xsk_destruct_skb+0xd0/0x180
>  [...]
>  Call Trace:
>   <IRQ>
>   ? napi_complete_done+0x7a/0x1a0
>   ip_rcv_core+0x1bb/0x340
>   ip_rcv+0x30/0x1f0
>   __netif_receive_skb_one_core+0x85/0xa0
>   process_backlog+0x87/0x130
>   __napi_poll+0x28/0x180
>   net_rx_action+0x339/0x420
>   handle_softirqs+0xdc/0x320
>   ? handle_edge_irq+0x90/0x1e0
>   do_softirq.part.0+0x3b/0x60
>   </IRQ>
>   <TASK>
>   __local_bh_enable_ip+0x60/0x70
>   __dev_direct_xmit+0x14e/0x1f0
>   __xsk_generic_xmit+0x482/0xb70
>   ? __remove_hrtimer+0x41/0xa0
>   ? __xsk_generic_xmit+0x51/0xb70
>   ? _raw_spin_unlock_irqrestore+0xe/0x40
>   xsk_sendmsg+0xda/0x1c0
>   __sys_sendto+0x1ee/0x200
>   __x64_sys_sendto+0x24/0x30
>   do_syscall_64+0x84/0x2f0
>   ? __pfx_pollwake+0x10/0x10
>   ? __rseq_handle_notify_resume+0xad/0x4c0
>   ? restore_fpregs_from_fpstate+0x3c/0x90
>   ? switch_fpu_return+0x5b/0xe0
>   ? do_syscall_64+0x204/0x2f0
>   ? do_syscall_64+0x204/0x2f0
>   ? do_syscall_64+0x204/0x2f0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   </TASK>
>  [...]
>  Kernel panic - not syncing: Fatal exception in interrupt
>  Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range: 0xf=
fffffff80000000-0xffffffffbfffffff)
>
> Instead use the skb destructor_arg pointer along with pointer tagging.
> As pointers are always aligned to 8B, use the bottom bit to indicate
> whether this a single address or an allocated struct containing several
> addresses.
>
> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-68868474bf=
1c@nop.hu/
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v2: remove some leftovers on skb_build and simplify fragmented traffic
> logic
>
> v3: drop skb extension approach, instead use pointer tagging in
> destructor_arg to know whether we have a single address or an allocated
> struct with multiple ones. Also, move from bpf to net as requested
>
> v4: repost after rebasing
> ---
>  net/xdp/xsk.c | 130 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 74 insertions(+), 56 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7b0c68a70888..d7354a3e2545 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -36,20 +36,13 @@
>  #define TX_BATCH_SIZE 32
>  #define MAX_PER_SOCKET_BUDGET 32
>
> -struct xsk_addr_node {
> -       u64 addr;
> -       struct list_head addr_node;
> -};
> -
> -struct xsk_addr_head {
> +struct xsk_addrs {
>         u32 num_descs;
> -       struct list_head addrs_list;
> +       u64 addrs[MAX_SKB_FRAGS + 1];
>  };
>
>  static struct kmem_cache *xsk_tx_generic_cache;
>
> -#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))
> -
>  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
>  {
>         if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> @@ -558,29 +551,53 @@ static int xsk_cq_reserve_locked(struct xsk_buff_po=
ol *pool)
>         return ret;
>  }
>
> +static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
> +{
> +       return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
> +}
> +
> +static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
> +{
> +       return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL)=
;
> +}
> +
> +static u32 xsk_get_num_desc(struct sk_buff *skb)
> +{
> +       struct xsk_addrs *xsk_addr;
> +
> +       if (xsk_skb_destructor_is_addr(skb))
> +               return 1;
> +
> +       xsk_addr =3D (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +
> +       return xsk_addr->num_descs;
> +}
> +
>  static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
>                                       struct sk_buff *skb)
>  {
> -       struct xsk_addr_node *pos, *tmp;
> +       u32 num_descs =3D xsk_get_num_desc(skb);
> +       struct xsk_addrs *xsk_addr;
>         u32 descs_processed =3D 0;
>         unsigned long flags;
> -       u32 idx;
> +       u32 idx, i;
>
>         spin_lock_irqsave(&pool->cq_lock, flags);
>         idx =3D xskq_get_prod(pool->cq);
>
> -       xskq_prod_write_addr(pool->cq, idx,
> -                            (u64)(uintptr_t)skb_shinfo(skb)->destructor_=
arg);
> -       descs_processed++;
> +       if (unlikely(num_descs > 1)) {
> +               xsk_addr =3D (struct xsk_addrs *)skb_shinfo(skb)->destruc=
tor_arg;
>
> -       if (unlikely(XSKCB(skb)->num_descs > 1)) {
> -               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_lis=
t, addr_node) {
> +               for (i =3D 0; i < num_descs; i++) {
>                         xskq_prod_write_addr(pool->cq, idx + descs_proces=
sed,
> -                                            pos->addr);
> +                                            xsk_addr->addrs[i]);
>                         descs_processed++;
> -                       list_del(&pos->addr_node);
> -                       kmem_cache_free(xsk_tx_generic_cache, pos);
>                 }
> +               kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
> +       } else {
> +               xskq_prod_write_addr(pool->cq, idx,
> +                                    xsk_skb_destructor_get_addr(skb));
> +               descs_processed++;
>         }
>         xskq_prod_submit_n(pool->cq, descs_processed);
>         spin_unlock_irqrestore(&pool->cq_lock, flags);
> @@ -595,16 +612,6 @@ static void xsk_cq_cancel_locked(struct xsk_buff_poo=
l *pool, u32 n)
>         spin_unlock_irqrestore(&pool->cq_lock, flags);
>  }
>
> -static void xsk_inc_num_desc(struct sk_buff *skb)
> -{
> -       XSKCB(skb)->num_descs++;
> -}
> -
> -static u32 xsk_get_num_desc(struct sk_buff *skb)
> -{
> -       return XSKCB(skb)->num_descs;
> -}
> -
>  static void xsk_destruct_skb(struct sk_buff *skb)
>  {
>         struct xsk_tx_metadata_compl *compl =3D &skb_shinfo(skb)->xsk_met=
a;
> @@ -621,27 +628,22 @@ static void xsk_destruct_skb(struct sk_buff *skb)
>  static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
>                               u64 addr)
>  {
> -       BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
> -       INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
>         skb->dev =3D xs->dev;
>         skb->priority =3D READ_ONCE(xs->sk.sk_priority);
>         skb->mark =3D READ_ONCE(xs->sk.sk_mark);
> -       XSKCB(skb)->num_descs =3D 0;
>         skb->destructor =3D xsk_destruct_skb;
> -       skb_shinfo(skb)->destructor_arg =3D (void *)(uintptr_t)addr;
> +       skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | 0x=
1UL);
>  }
>
>  static void xsk_consume_skb(struct sk_buff *skb)
>  {
>         struct xdp_sock *xs =3D xdp_sk(skb->sk);
>         u32 num_descs =3D xsk_get_num_desc(skb);
> -       struct xsk_addr_node *pos, *tmp;
> +       struct xsk_addrs *xsk_addr;
>
>         if (unlikely(num_descs > 1)) {
> -               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_lis=
t, addr_node) {
> -                       list_del(&pos->addr_node);
> -                       kmem_cache_free(xsk_tx_generic_cache, pos);
> -               }
> +               xsk_addr =3D (struct xsk_addrs *)skb_shinfo(skb)->destruc=
tor_arg;
> +               kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
>         }
>
>         skb->destructor =3D sock_wfree;
> @@ -701,7 +703,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct =
xdp_sock *xs,
>  {
>         struct xsk_buff_pool *pool =3D xs->pool;
>         u32 hr, len, ts, offset, copy, copied;
> -       struct xsk_addr_node *xsk_addr;
>         struct sk_buff *skb =3D xs->skb;
>         struct page *page;
>         void *buffer;
> @@ -727,16 +728,27 @@ static struct sk_buff *xsk_build_skb_zerocopy(struc=
t xdp_sock *xs,
>                                 return ERR_PTR(err);
>                 }
>         } else {
> -               xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_cache, GFP_=
KERNEL);
> -               if (!xsk_addr)
> -                       return ERR_PTR(-ENOMEM);
> +               struct xsk_addrs *xsk_addr;
> +
> +               if (xsk_skb_destructor_is_addr(skb)) {
> +                       xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_cac=
he,
> +                                                    GFP_KERNEL);
> +                       if (!xsk_addr)
> +                               return ERR_PTR(-ENOMEM);
> +
> +                       xsk_addr->num_descs =3D 1;
> +                       xsk_addr->addrs[0] =3D xsk_skb_destructor_get_add=
r(skb);
> +                       skb_shinfo(skb)->destructor_arg =3D (void *)xsk_a=
ddr;
> +               } else {
> +                       xsk_addr =3D (struct xsk_addrs *)skb_shinfo(skb)-=
>destructor_arg;
> +               }
>
>                 /* in case of -EOVERFLOW that could happen below,
>                  * xsk_consume_skb() will release this node as whole skb
>                  * would be dropped, which implies freeing all list eleme=
nts
>                  */
> -               xsk_addr->addr =3D desc->addr;
> -               list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_li=
st);
> +               xsk_addr->addrs[xsk_addr->num_descs] =3D desc->addr;
> +               xsk_addr->num_descs++;
>         }
>
>         len =3D desc->len;
> @@ -813,7 +825,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock =
*xs,
>                         }
>                 } else {
>                         int nr_frags =3D skb_shinfo(skb)->nr_frags;
> -                       struct xsk_addr_node *xsk_addr;
> +                       struct xsk_addrs *xsk_addr;
>                         struct page *page;
>                         u8 *vaddr;
>
> @@ -828,11 +840,20 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
>                                 goto free_err;
>                         }
>
> -                       xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_cac=
he, GFP_KERNEL);
> -                       if (!xsk_addr) {
> -                               __free_page(page);
> -                               err =3D -ENOMEM;
> -                               goto free_err;
> +                       if (xsk_skb_destructor_is_addr(skb)) {
> +                               xsk_addr =3D kmem_cache_zalloc(xsk_tx_gen=
eric_cache,
> +                                                            GFP_KERNEL);
> +                               if (!xsk_addr) {
> +                                       __free_page(page);
> +                                       err =3D -ENOMEM;
> +                                       goto free_err;
> +                               }
> +
> +                               xsk_addr->num_descs =3D 1;
> +                               xsk_addr->addrs[0] =3D xsk_skb_destructor=
_get_addr(skb);
> +                               skb_shinfo(skb)->destructor_arg =3D (void=
 *)xsk_addr;
> +                       } else {
> +                               xsk_addr =3D (struct xsk_addrs *)skb_shin=
fo(skb)->destructor_arg;
>                         }
>
>                         vaddr =3D kmap_local_page(page);
> @@ -842,13 +863,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
>                         skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE=
_SIZE);
>                         refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
>
> -                       xsk_addr->addr =3D desc->addr;
> -                       list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->=
addrs_list);
> +                       xsk_addr->addrs[xsk_addr->num_descs] =3D desc->ad=
dr;
> +                       xsk_addr->num_descs++;

Wait, it's too late to increment it... Please find below.

>                 }
>         }
>
> -       xsk_inc_num_desc(skb);
> -
>         return skb;
>
>  free_err:
> @@ -857,7 +876,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock =
*xs,
>
>         if (err =3D=3D -EOVERFLOW) {
>                 /* Drop the packet */
> -               xsk_inc_num_desc(xs->skb);

Why did you remove this line? The error can occur in the above hidden
snippet[1] without IFF_TX_SKB_NO_LINEAR setting and then we will fail
to increment it by one.

[1]: https://elixir.bootlin.com/linux/v6.18-rc6/source/net/xdp/xsk.c#L821

Thanks,
Jason

