Return-Path: <bpf+bounces-75161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB93C74108
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 13:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9151535AAA8
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 12:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA1833971D;
	Thu, 20 Nov 2025 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LK6h2R1k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C93337105
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763643456; cv=none; b=nIn1wL+fxau08FJUXDXC3Jfb+CYvkU618x929TkM0Yv96Ix6eEMGVuUIfdEzmdtdjCr6EbgUTC7K56DpH7ZJHTisolfstDOWOpT1nZ+n10toLQUr0ndrd6kFhIw2cOl+E+CLJyut0lw9RTC6HPOh3XmyHSDfjuuqcy9zYtZKhF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763643456; c=relaxed/simple;
	bh=DlRSuw45zIEthlFLbe/jMJveTKZL5QA485HX22SfP2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhV+YzbC0vtKfheNzbj9BeCNCUV5Ug29jSCalJ4lgse9rwk67l1Pd7p5zl3b8GGpU7jeBT69+Gz8yD5ekK5JjjbUK+doU8PIyeR85GOXfx2CNWsWDJJEWaQDuQMdC4yEsCXk156y1Vkb7EkIvwjNLFCJBDjZvBRV1+sqXIYKfPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LK6h2R1k; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-949042bca69so30114439f.1
        for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 04:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763643453; x=1764248253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxXWUNYSugTUj7jm7rNW2NYHXtSZ+qgvkDUb3b77jtw=;
        b=LK6h2R1k1WALTr1WHAeiBS+MTwqlx+NPqcTwNl8ScqQPuHM5M1zMhqMTax2Gn0Nilq
         2318/srWq2dBw33XZ5Uxod8zNCghgSsiUUlRAxMGVOHJe0ejEWYv8RXf4VaLj4AFOvXw
         312RDk+pKJsSPrQ+n4wwkzqDla8WAqf2SeBzM8o2asppoMj5ujlCRvhBYKwl3NkR5igF
         WO0xCrsAZG/6prE62bubS+aU73L/5aHZb7+M5Ly22FEddy4Bk/q5G6SlbBULftHe/z3K
         Y4mVu+reaKRObx57WZEIWC5cNSnYPdyVBq+wn2lzuTnTTSrAYETQ3m+ge4VO6NLKXAS9
         EQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763643453; x=1764248253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DxXWUNYSugTUj7jm7rNW2NYHXtSZ+qgvkDUb3b77jtw=;
        b=Bj7rmBKfa/0HjQBGkpdUxDKbPm9taUrqVv+pXnZXVTToVS7suWAILYkGM/md2+nJ1K
         T1QOj7PQ2q0Frro1I0eU15YxR0GMQO7n6cDXYlMiMfHJVLJuH4WRbrxDfEPM/f2Ny3WW
         D+aYLzE10eNc8wq2+T7j3au9tbXXyABXs71EC0/QV7ph6fjbAMeBgo1R1BOJGIC2kEUj
         /acrYk3B0yz4Wkp/7aOwQTosh/3iN2ZsyleZW4hTm46LJ9IUR2w4ScJPvVf8QEQqBH1k
         Q8BVhlkjsvgJMk3ReLKn3L1I8SDqeCIaZadAkne1TaO14VHBYZ2U6M9PbjYrpM+vFc7V
         9vBA==
X-Forwarded-Encrypted: i=1; AJvYcCUmekVKjy4zcvAbUOEAkSvmjo/aDpssTv0zVwxUpHQ+C2CdifY3xOf779JMRTNTAyLZo7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPpbNzhHRk24+5CdVuCviaeHizRzK+4ZkCDSPtsqdFIaPGtQiQ
	o2+3O4ALZUiyWl5Pfrt50BcB3VV+IC96arU2Xzljt60VSiTrD/U6GDxRH8AcjLMvJAHNt7Tlskp
	TIL1ZQvAa9lQqZd17Cmp2k3Ibd5nl0YU=
X-Gm-Gg: ASbGnctaEt2Yxai3H3tTTmoFBtG4M62UAh9Aw1QuNzQkXPrs768OjjM4MkFc6IwYq57
	64EjJ+E4YiTXiczviYXqfmB5ekpSRAgMXGFtrQGmXDujA8aGSoCZtYcNTRs4oo5eNpoBTphECUm
	IAyYNcXjWAx8cSBOmK1NszF5mWdyASB1+j7eqiDYqR600kjqme5rbteKsiRn0OjPK1qVdtzM+c3
	7jCBSYtcyUvkFUdKgSqXIKI/qrvgh7Wd8k/5UvhGrX4bYOIlLFYrGcV7LluP5GKT0n/S0ji5MWd
	7X8lyJTclA==
X-Google-Smtp-Source: AGHT+IE5/Bx7Kj2nryOtt9W2gh3UM6Z0lWG2ODMyhrSig8eL6F4T6r8T0FHAE9suZ/3ETgztA0/hMP94MKR0bPT/sdg=
X-Received: by 2002:a05:6e02:3106:b0:433:43fb:3802 with SMTP id
 e9e14a558f8ab-435a8f778demr32617525ab.0.1763643453419; Thu, 20 Nov 2025
 04:57:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120110228.4288-1-fmancera@suse.de>
In-Reply-To: <20251120110228.4288-1-fmancera@suse.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 20 Nov 2025 20:56:57 +0800
X-Gm-Features: AWmQ_blUyMYivU_ghjE7xRW45AwacQWixGRYReUSq_BW43Gy2JphkgyDNcrdRvM
Message-ID: <CAL+tcoDKxaOT7DiLg2=jQPLo+6OJqL7ZkDurXZAGXo-xbxoDWw@mail.gmail.com>
Subject: Re: [PATCH net v5] xsk: avoid data corruption on cq descriptor number
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, csmate@nop.hu, maciej.fijalkowski@intel.com, 
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	john.fastabend@gmail.com, magnus.karlsson@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 7:02=E2=80=AFPM Fernando Fernandez Mancera
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
>
> v5: fixed increase logic so -EOVERFLOW is handled correctly as
> suggested by Jason. Also dropped the acks/reviewed tags as code changed.
> ---
>  net/xdp/xsk.c | 141 ++++++++++++++++++++++++++++++--------------------
>  1 file changed, 85 insertions(+), 56 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7b0c68a70888..f87cc4c89339 100644
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
> @@ -558,29 +551,63 @@ static int xsk_cq_reserve_locked(struct xsk_buff_po=
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
> +static void xsk_inc_num_desc(struct sk_buff *skb)
> +{
> +       struct xsk_addrs *xsk_addr;
> +
> +       if (!xsk_skb_destructor_is_addr(skb)) {

It's the condition that causes the above issues. Please see the
following comment.

> +               xsk_addr =3D (struct xsk_addrs *)skb_shinfo(skb)->destruc=
tor_arg;
> +               xsk_addr->num_descs++;
> +       }
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
> @@ -595,16 +622,6 @@ static void xsk_cq_cancel_locked(struct xsk_buff_poo=
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
> @@ -621,27 +638,22 @@ static void xsk_destruct_skb(struct sk_buff *skb)
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
> @@ -701,7 +713,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct =
xdp_sock *xs,
>  {
>         struct xsk_buff_pool *pool =3D xs->pool;
>         u32 hr, len, ts, offset, copy, copied;
> -       struct xsk_addr_node *xsk_addr;
>         struct sk_buff *skb =3D xs->skb;
>         struct page *page;
>         void *buffer;
> @@ -727,16 +738,26 @@ static struct sk_buff *xsk_build_skb_zerocopy(struc=
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

At this point, actually @num_descs should be equal to 2. I know it
will be incremented by one at the end of xsk_build_skb(). My concern
is when skb only carries one descriptor, I don't see any place setting
@num_descs to 1?

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
>         }
>
>         len =3D desc->len;
> @@ -813,10 +834,25 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
>                         }
>                 } else {
>                         int nr_frags =3D skb_shinfo(skb)->nr_frags;
> -                       struct xsk_addr_node *xsk_addr;
> +                       struct xsk_addrs *xsk_addr;
>                         struct page *page;
>                         u8 *vaddr;
>
> +                       if (xsk_skb_destructor_is_addr(skb)) {
> +                               xsk_addr =3D kmem_cache_zalloc(xsk_tx_gen=
eric_cache,
> +                                                            GFP_KERNEL);
> +                               if (!xsk_addr) {
> +                                       err =3D -ENOMEM;
> +                                       goto free_err;
> +                               }
> +
> +                               xsk_addr->num_descs =3D 1;

same for here.

> +                               xsk_addr->addrs[0] =3D xsk_skb_destructor=
_get_addr(skb);
> +                               skb_shinfo(skb)->destructor_arg =3D (void=
 *)xsk_addr;
> +                       } else {
> +                               xsk_addr =3D (struct xsk_addrs *)skb_shin=
fo(skb)->destructor_arg;
> +                       }
> +
>                         if (unlikely(nr_frags =3D=3D (MAX_SKB_FRAGS - 1) =
&& xp_mb_desc(desc))) {
>                                 err =3D -EOVERFLOW;
>                                 goto free_err;
> @@ -828,13 +864,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock=
 *xs,
>                                 goto free_err;
>                         }
>
> -                       xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_cac=
he, GFP_KERNEL);
> -                       if (!xsk_addr) {
> -                               __free_page(page);
> -                               err =3D -ENOMEM;
> -                               goto free_err;
> -                       }
> -
>                         vaddr =3D kmap_local_page(page);
>                         memcpy(vaddr, buffer, len);
>                         kunmap_local(vaddr);
> @@ -842,12 +871,12 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
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
>                 }
>         }
>
> -       xsk_inc_num_desc(skb);
> +       if (!xsk_skb_destructor_is_addr(skb))

nit: duplicate if statement

IIUC, I'm afraid you have to repost this patch after 24 hour...

Thanks,
Jason

> +               xsk_inc_num_desc(skb);
>
>         return skb;
>
> @@ -1904,7 +1933,7 @@ static int __init xsk_init(void)
>                 goto out_pernet;
>
>         xsk_tx_generic_cache =3D kmem_cache_create("xsk_generic_xmit_cach=
e",
> -                                                sizeof(struct xsk_addr_n=
ode),
> +                                                sizeof(struct xsk_addrs)=
,
>                                                  0, SLAB_HWCACHE_ALIGN, N=
ULL);
>         if (!xsk_tx_generic_cache) {
>                 err =3D -ENOMEM;
> --
> 2.51.1
>

