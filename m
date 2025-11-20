Return-Path: <bpf+bounces-75164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4AFC7452F
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 14:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6FE0352D2D
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 13:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB8133EAF9;
	Thu, 20 Nov 2025 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeKPQvNo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF15434107B
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763646067; cv=none; b=Z98NYRdBxnSGl9l2pYXAtR16Fz/b2iQ6Wm9O5hTu0CrnfTX2tT6kbV09mvtQbRSs0LQkmYQR9wYjaOo8jJegQY767kl1SV9a57bWGURzi1bHtYRdyFstF1wsXLsGjs1LzoqiLWdV5G1hsXWo+TW7ZMAoD8LmXebwZwpy0D7+cO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763646067; c=relaxed/simple;
	bh=svRG4dOnFbhRlG1dBKOfXuNcWjS5LCTQdfgE041gxNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSoJly6Tzx/xlCNJvn1mSXn9HRW3grsquhKgKb0xmfqCEQgPRtIFRFmzEL6gwwHJ0+8Gi7ihfHW/5/2y80lNMH4Zxm90/hBkQOCdCaePhnKdiSpZXIjwl8JcxrY4U2+Fkxjpa2qK32UveICcYuaRWZJyYnndgsSCn/L5Rb+x8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeKPQvNo; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-4330e912c51so4582075ab.3
        for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 05:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763646065; x=1764250865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+nv3PTfWD1jgnO+qgCecljHHC2FzUSPFmeKSzJTqA4=;
        b=MeKPQvNobuz7c7VjcdQlP0zyerOtKs75N7kOKNS2D6JGXj4izsuaJwRSc1JligG8cu
         jDJCGtK5C5fMqejlQvRQdzt/S+XoS/9UetST0/uL4GVD9zE0baIoNJ2Pwn+uF++ePvkJ
         Gh+NAXQ7sXqnhOININ9rApFKXNSwR8YHcjf82FU+SGZIxme4wkdfzp3hNzU/2H7APDe1
         kbA+94v/Ehwhl08iEWcPM+epyTVxlEMjJxUuN6dXX+IiKWtcNek/QwsqxNt2SKm5wOrX
         +OF85YYKPItgCyZNSMhk7OGwS1yhkSATZpTHZssNy4WIHZ9sE2pj3TIPM+zoXpxFqSCJ
         KXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763646065; x=1764250865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b+nv3PTfWD1jgnO+qgCecljHHC2FzUSPFmeKSzJTqA4=;
        b=DkUgUk4Akt3BEzw/yRaSvVqYfLznMSnGdVq3mb5y7hOVSqU6yMChxes6nQ3hO9heG+
         Zy9ZY7CTlf2QZOWQ+67zp+fjE0Xx/sfhdL2+Ee/ywlcwC6fXAzk++VozyHMcTzdHtNzK
         6aCd435/Xlsux4fL9DRvjLjxyJKpJvSYFLzzZb0Wws0UKEOdUkaUx1uvqWM3mNFNSZZA
         hmY8dL++YekBPPgpqCxvvIXIIEicwtlzOawYHOEWTlqFO1MIzRoVYOjWGis0oJpjMUBh
         5kOLrYBtcBd8TszBFVzN0wrEupTBSoCJf8rNvlw1y9me/8Pa0bTGBRPz3KEVMTqE3+ec
         i1fg==
X-Forwarded-Encrypted: i=1; AJvYcCX434R312FIdEHRnkmRl0gfLlOJSBF59nywDY5Xofkrn2vtfm6Esvj/poAH7BS6czBk7Is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz21+S7IgKE2lbhPA+GYmhF+TsI3g2uoOvCd4Yq+U5IPTOP6nmy
	JYZbX0FOF7EI3D3gCN0K5xhpYj7URsI7nqQVY3Gy/HdMI3/DPzaFv58uDrj7nvg6QIrJKmY+Zi5
	sPaT0dvoIEKbdieDR6q2KQvnsl5DXfLM=
X-Gm-Gg: ASbGnctwQAEskSWOCewmA/C7hiZbjU2bXC1WBe5mEo8+BpWG2Th7qjV7zaDm8WLqCRM
	5ppI55fwmAjgdRs6ftZZFKhcMyP7mEej9pnvn59o/NtYSLV/sM+W4Ryhjaeov4zzrz6be4WkI4Q
	w9dUu79IPwsBgNq0AL7K4JiPMZB1wZUwxCdkgyvOBLlVsIqWq+ecGds/X+aYDOsJKDiYvy6lvJm
	pnxjRYN+ULlfaG3CAG7GT0rVKYUqHclrO36h2zUdIIcKhfA1l3z7tJNgRvkbGqz0SmMA37VVOHQ
	gyfShV1P8Q==
X-Google-Smtp-Source: AGHT+IHO5ZGSWW5xCMhcBigtCu3TiRRijRs68fpnFsxYe/zkyWLigpM6vWU2zKOhzdaSfm7UgEmXArDfAwsEdrdENZ8=
X-Received: by 2002:a92:ca0b:0:b0:434:96ea:ff78 with SMTP id
 e9e14a558f8ab-435a90804e9mr28870845ab.40.1763646064427; Thu, 20 Nov 2025
 05:41:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120110228.4288-1-fmancera@suse.de> <CAL+tcoDKxaOT7DiLg2=jQPLo+6OJqL7ZkDurXZAGXo-xbxoDWw@mail.gmail.com>
 <01a09fe7-9f58-4fc5-a84d-12d5b4b92bbd@suse.de>
In-Reply-To: <01a09fe7-9f58-4fc5-a84d-12d5b4b92bbd@suse.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 20 Nov 2025 21:40:27 +0800
X-Gm-Features: AWmQ_bn5bzZqoetrmTe1Bnek_uVTadc3lhrLE4qibda9ieg4DSExyoO9qqbj-4g
Message-ID: <CAL+tcoBueigrGnKASad7XFybXMHvj5jAOcZS8_bY3J-7XVZShQ@mail.gmail.com>
Subject: Re: [PATCH net v5] xsk: avoid data corruption on cq descriptor number
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, csmate@nop.hu, maciej.fijalkowski@intel.com, 
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	john.fastabend@gmail.com, magnus.karlsson@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 9:16=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> On 11/20/25 1:56 PM, Jason Xing wrote:
> > On Thu, Nov 20, 2025 at 7:02=E2=80=AFPM Fernando Fernandez Mancera
> > <fmancera@suse.de> wrote:
> >>
> >> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> >> production"), the descriptor number is stored in skb control block and
> >> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> >> pool's completion queue.
> >>
> >> skb control block shouldn't be used for this purpose as after transmit
> >> xsk doesn't have control over it and other subsystems could use it. Th=
is
> >> leads to the following kernel panic due to a NULL pointer dereference.
> >>
> >>   BUG: kernel NULL pointer dereference, address: 0000000000000000
> >>   #PF: supervisor read access in kernel mode
> >>   #PF: error_code(0x0000) - not-present page
> >>   PGD 0 P4D 0
> >>   Oops: Oops: 0000 [#1] SMP NOPTI
> >>   CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14-clo=
ud-amd64 #1 PREEMPT(lazy)  Debian 6.16.12-1
> >>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-d=
ebian-1.17.0-1 04/01/2014
> >>   RIP: 0010:xsk_destruct_skb+0xd0/0x180
> >>   [...]
> >>   Call Trace:
> >>    <IRQ>
> >>    ? napi_complete_done+0x7a/0x1a0
> >>    ip_rcv_core+0x1bb/0x340
> >>    ip_rcv+0x30/0x1f0
> >>    __netif_receive_skb_one_core+0x85/0xa0
> >>    process_backlog+0x87/0x130
> >>    __napi_poll+0x28/0x180
> >>    net_rx_action+0x339/0x420
> >>    handle_softirqs+0xdc/0x320
> >>    ? handle_edge_irq+0x90/0x1e0
> >>    do_softirq.part.0+0x3b/0x60
> >>    </IRQ>
> >>    <TASK>
> >>    __local_bh_enable_ip+0x60/0x70
> >>    __dev_direct_xmit+0x14e/0x1f0
> >>    __xsk_generic_xmit+0x482/0xb70
> >>    ? __remove_hrtimer+0x41/0xa0
> >>    ? __xsk_generic_xmit+0x51/0xb70
> >>    ? _raw_spin_unlock_irqrestore+0xe/0x40
> >>    xsk_sendmsg+0xda/0x1c0
> >>    __sys_sendto+0x1ee/0x200
> >>    __x64_sys_sendto+0x24/0x30
> >>    do_syscall_64+0x84/0x2f0
> >>    ? __pfx_pollwake+0x10/0x10
> >>    ? __rseq_handle_notify_resume+0xad/0x4c0
> >>    ? restore_fpregs_from_fpstate+0x3c/0x90
> >>    ? switch_fpu_return+0x5b/0xe0
> >>    ? do_syscall_64+0x204/0x2f0
> >>    ? do_syscall_64+0x204/0x2f0
> >>    ? do_syscall_64+0x204/0x2f0
> >>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>    </TASK>
> >>   [...]
> >>   Kernel panic - not syncing: Fatal exception in interrupt
> >>   Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range:=
 0xffffffff80000000-0xffffffffbfffffff)
> >>
> >> Instead use the skb destructor_arg pointer along with pointer tagging.
> >> As pointers are always aligned to 8B, use the bottom bit to indicate
> >> whether this a single address or an allocated struct containing severa=
l
> >> addresses.
> >>
> >> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
> >> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-6886847=
4bf1c@nop.hu/
> >> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> >> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> >> ---
> >> v2: remove some leftovers on skb_build and simplify fragmented traffic
> >> logic
> >>
> >> v3: drop skb extension approach, instead use pointer tagging in
> >> destructor_arg to know whether we have a single address or an allocate=
d
> >> struct with multiple ones. Also, move from bpf to net as requested
> >>
> >> v4: repost after rebasing
> >>
> >> v5: fixed increase logic so -EOVERFLOW is handled correctly as
> >> suggested by Jason. Also dropped the acks/reviewed tags as code change=
d.
> >> ---
> >>   net/xdp/xsk.c | 141 ++++++++++++++++++++++++++++++------------------=
--
> >>   1 file changed, 85 insertions(+), 56 deletions(-)
> >>
> >> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> >> index 7b0c68a70888..f87cc4c89339 100644
> >> --- a/net/xdp/xsk.c
> >> +++ b/net/xdp/xsk.c
> >> @@ -36,20 +36,13 @@
> >>   #define TX_BATCH_SIZE 32
> >>   #define MAX_PER_SOCKET_BUDGET 32
> >>
> >> -struct xsk_addr_node {
> >> -       u64 addr;
> >> -       struct list_head addr_node;
> >> -};
> >> -
> >> -struct xsk_addr_head {
> >> +struct xsk_addrs {
> >>          u32 num_descs;
> >> -       struct list_head addrs_list;
> >> +       u64 addrs[MAX_SKB_FRAGS + 1];
> >>   };
> >>
> >>   static struct kmem_cache *xsk_tx_generic_cache;
> >>
> >> -#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))
> >> -
> >>   void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
> >>   {
> >>          if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> >> @@ -558,29 +551,63 @@ static int xsk_cq_reserve_locked(struct xsk_buff=
_pool *pool)
> >>          return ret;
> >>   }
> >>
> >> +static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
> >> +{
> >> +       return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
> >> +}
> >> +
> >> +static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
> >> +{
> >> +       return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1=
UL);
> >> +}
> >> +
> >> +static void xsk_inc_num_desc(struct sk_buff *skb)
> >> +{
> >> +       struct xsk_addrs *xsk_addr;
> >> +
> >> +       if (!xsk_skb_destructor_is_addr(skb)) {
> >
> > It's the condition that causes the above issues. Please see the
> > following comment.
> >
> >> +               xsk_addr =3D (struct xsk_addrs *)skb_shinfo(skb)->dest=
ructor_arg;
> >> +               xsk_addr->num_descs++;
> >> +       }
> >> +}
> >> +
> >> +static u32 xsk_get_num_desc(struct sk_buff *skb)
> >> +{
> >> +       struct xsk_addrs *xsk_addr;
> >> +
> >> +       if (xsk_skb_destructor_is_addr(skb))
> >> +               return 1;
> >> +
> >> +       xsk_addr =3D (struct xsk_addrs *)skb_shinfo(skb)->destructor_a=
rg;
> >> +
> >> +       return xsk_addr->num_descs;
> >> +}
> >> +
> >>   static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
> >>                                        struct sk_buff *skb)
> >>   {
> >> -       struct xsk_addr_node *pos, *tmp;
> >> +       u32 num_descs =3D xsk_get_num_desc(skb);
> >> +       struct xsk_addrs *xsk_addr;
> >>          u32 descs_processed =3D 0;
> >>          unsigned long flags;
> >> -       u32 idx;
> >> +       u32 idx, i;
> >>
> >>          spin_lock_irqsave(&pool->cq_lock, flags);
> >>          idx =3D xskq_get_prod(pool->cq);
> >>
> >> -       xskq_prod_write_addr(pool->cq, idx,
> >> -                            (u64)(uintptr_t)skb_shinfo(skb)->destruct=
or_arg);
> >> -       descs_processed++;
> >> +       if (unlikely(num_descs > 1)) {
> >> +               xsk_addr =3D (struct xsk_addrs *)skb_shinfo(skb)->dest=
ructor_arg;
> >>
> >> -       if (unlikely(XSKCB(skb)->num_descs > 1)) {
> >> -               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_=
list, addr_node) {
> >> +               for (i =3D 0; i < num_descs; i++) {
> >>                          xskq_prod_write_addr(pool->cq, idx + descs_pr=
ocessed,
> >> -                                            pos->addr);
> >> +                                            xsk_addr->addrs[i]);
> >>                          descs_processed++;
> >> -                       list_del(&pos->addr_node);
> >> -                       kmem_cache_free(xsk_tx_generic_cache, pos);
> >>                  }
> >> +               kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
> >> +       } else {
> >> +               xskq_prod_write_addr(pool->cq, idx,
> >> +                                    xsk_skb_destructor_get_addr(skb))=
;
> >> +               descs_processed++;
> >>          }
> >>          xskq_prod_submit_n(pool->cq, descs_processed);
> >>          spin_unlock_irqrestore(&pool->cq_lock, flags);
> >> @@ -595,16 +622,6 @@ static void xsk_cq_cancel_locked(struct xsk_buff_=
pool *pool, u32 n)
> >>          spin_unlock_irqrestore(&pool->cq_lock, flags);
> >>   }
> >>
> >> -static void xsk_inc_num_desc(struct sk_buff *skb)
> >> -{
> >> -       XSKCB(skb)->num_descs++;
> >> -}
> >> -
> >> -static u32 xsk_get_num_desc(struct sk_buff *skb)
> >> -{
> >> -       return XSKCB(skb)->num_descs;
> >> -}
> >> -
> >>   static void xsk_destruct_skb(struct sk_buff *skb)
> >>   {
> >>          struct xsk_tx_metadata_compl *compl =3D &skb_shinfo(skb)->xsk=
_meta;
> >> @@ -621,27 +638,22 @@ static void xsk_destruct_skb(struct sk_buff *skb=
)
> >>   static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *=
xs,
> >>                                u64 addr)
> >>   {
> >> -       BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
> >> -       INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> >>          skb->dev =3D xs->dev;
> >>          skb->priority =3D READ_ONCE(xs->sk.sk_priority);
> >>          skb->mark =3D READ_ONCE(xs->sk.sk_mark);
> >> -       XSKCB(skb)->num_descs =3D 0;
> >>          skb->destructor =3D xsk_destruct_skb;
> >> -       skb_shinfo(skb)->destructor_arg =3D (void *)(uintptr_t)addr;
> >> +       skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr |=
 0x1UL);
> >>   }
> >>
> >>   static void xsk_consume_skb(struct sk_buff *skb)
> >>   {
> >>          struct xdp_sock *xs =3D xdp_sk(skb->sk);
> >>          u32 num_descs =3D xsk_get_num_desc(skb);
> >> -       struct xsk_addr_node *pos, *tmp;
> >> +       struct xsk_addrs *xsk_addr;
> >>
> >>          if (unlikely(num_descs > 1)) {
> >> -               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_=
list, addr_node) {
> >> -                       list_del(&pos->addr_node);
> >> -                       kmem_cache_free(xsk_tx_generic_cache, pos);
> >> -               }
> >> +               xsk_addr =3D (struct xsk_addrs *)skb_shinfo(skb)->dest=
ructor_arg;
> >> +               kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
> >>          }
> >>
> >>          skb->destructor =3D sock_wfree;
> >> @@ -701,7 +713,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(stru=
ct xdp_sock *xs,
> >>   {
> >>          struct xsk_buff_pool *pool =3D xs->pool;
> >>          u32 hr, len, ts, offset, copy, copied;
> >> -       struct xsk_addr_node *xsk_addr;
> >>          struct sk_buff *skb =3D xs->skb;
> >>          struct page *page;
> >>          void *buffer;
> >> @@ -727,16 +738,26 @@ static struct sk_buff *xsk_build_skb_zerocopy(st=
ruct xdp_sock *xs,
> >>                                  return ERR_PTR(err);
> >>                  }
> >>          } else {
> >> -               xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_cache, G=
FP_KERNEL);
> >> -               if (!xsk_addr)
> >> -                       return ERR_PTR(-ENOMEM);
> >> +               struct xsk_addrs *xsk_addr;
> >> +
> >> +               if (xsk_skb_destructor_is_addr(skb)) {
> >> +                       xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_=
cache,
> >> +                                                    GFP_KERNEL);
> >> +                       if (!xsk_addr)
> >> +                               return ERR_PTR(-ENOMEM);
> >> +
> >> +                       xsk_addr->num_descs =3D 1;
> >
> > At this point, actually @num_descs should be equal to 2. I know it
> > will be incremented by one at the end of xsk_build_skb().My concern
>
> Why? if we reach this it means this is the first time we see fragmented
> traffic therefore we allocate xsk_addrs struct, store the previous umem
> address in addrs[0] and num_descs =3D 1 and finally if no -EOVERFLOW
> happens then the new desc->addr is added to addrs[num_descs] (which is
> addrs[1]).
>
> Later, at the end of xsk_build_skb() or if -EOVERFLOW happens we
> increase num_descs so if xsk_cq_cancel_locked() or
> xsk_cq_submit_addr_locked() is called we have the right number of
> descriptors.
>
> If we set @num_descs to 2 here, then when do we increase? I do not
> understand that.

I'm not saying the above logic is not right :)

>
> > is when skb only carries one descriptor, I don't see any place setting
> > @num_descs to 1?
> >
>
> When skb carries only one descriptor i.e traffic isn't segmented then
> xsk_addr struct isn't allocated and destructor_arg is carrying just an
> umem address.
>
> This is why xsk_get_num_desc() returns 1 if destructor_arg is an umem
> address, because it means there is just a single descriptor.

Here, It's the case that I'm worried about.

Ah, well, I see your point. I previously thought this function would
return @num_descs directly.

Surely it works. However, from my perspective I feel it's a bit weird
because when the skb only carries one desc, the @num_descs remains
zero which doesn't reflect the fact. I understand you use that
function to return one instead of reading @num_descs in this case.
Just a bit weird. I'm not sure what Maciej's opinion is here.

Anyway, thanks as always for fixing this:
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason


>
> >> +                       xsk_addr->addrs[0] =3D xsk_skb_destructor_get_=
addr(skb);
> >> +                       skb_shinfo(skb)->destructor_arg =3D (void *)xs=
k_addr;
> >> +               } else {
> >> +                       xsk_addr =3D (struct xsk_addrs *)skb_shinfo(sk=
b)->destructor_arg;
> >> +               }
> >>
> >>                  /* in case of -EOVERFLOW that could happen below,
> >>                   * xsk_consume_skb() will release this node as whole =
skb
> >>                   * would be dropped, which implies freeing all list e=
lements
> >>                   */
> >> -               xsk_addr->addr =3D desc->addr;
> >> -               list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs=
_list);
> >> +               xsk_addr->addrs[xsk_addr->num_descs] =3D desc->addr;
> >>          }
> >>
> >>          len =3D desc->len;
> >> @@ -813,10 +834,25 @@ static struct sk_buff *xsk_build_skb(struct xdp_=
sock *xs,
> >>                          }
> >>                  } else {
> >>                          int nr_frags =3D skb_shinfo(skb)->nr_frags;
> >> -                       struct xsk_addr_node *xsk_addr;
> >> +                       struct xsk_addrs *xsk_addr;
> >>                          struct page *page;
> >>                          u8 *vaddr;
> >>
> >> +                       if (xsk_skb_destructor_is_addr(skb)) {
> >> +                               xsk_addr =3D kmem_cache_zalloc(xsk_tx_=
generic_cache,
> >> +                                                            GFP_KERNE=
L);
> >> +                               if (!xsk_addr) {
> >> +                                       err =3D -ENOMEM;
> >> +                                       goto free_err;
> >> +                               }
> >> +
> >> +                               xsk_addr->num_descs =3D 1;
> >
> > same for here.
> >
> >> +                               xsk_addr->addrs[0] =3D xsk_skb_destruc=
tor_get_addr(skb);
> >> +                               skb_shinfo(skb)->destructor_arg =3D (v=
oid *)xsk_addr;
> >> +                       } else {
> >> +                               xsk_addr =3D (struct xsk_addrs *)skb_s=
hinfo(skb)->destructor_arg;
> >> +                       }
> >> +
> >>                          if (unlikely(nr_frags =3D=3D (MAX_SKB_FRAGS -=
 1) && xp_mb_desc(desc))) {
> >>                                  err =3D -EOVERFLOW;
> >>                                  goto free_err;
> >> @@ -828,13 +864,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_s=
ock *xs,
> >>                                  goto free_err;
> >>                          }
> >>
> >> -                       xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_=
cache, GFP_KERNEL);
> >> -                       if (!xsk_addr) {
> >> -                               __free_page(page);
> >> -                               err =3D -ENOMEM;
> >> -                               goto free_err;
> >> -                       }
> >> -
> >>                          vaddr =3D kmap_local_page(page);
> >>                          memcpy(vaddr, buffer, len);
> >>                          kunmap_local(vaddr);
> >> @@ -842,12 +871,12 @@ static struct sk_buff *xsk_build_skb(struct xdp_=
sock *xs,
> >>                          skb_add_rx_frag(skb, nr_frags, page, 0, len, =
PAGE_SIZE);
> >>                          refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc=
);
> >>
> >> -                       xsk_addr->addr =3D desc->addr;
> >> -                       list_add_tail(&xsk_addr->addr_node, &XSKCB(skb=
)->addrs_list);
> >> +                       xsk_addr->addrs[xsk_addr->num_descs] =3D desc-=
>addr;
> >>                  }
> >>          }
> >>
> >> -       xsk_inc_num_desc(skb);
> >> +       if (!xsk_skb_destructor_is_addr(skb))
> >
> > nit: duplicate if statement
> >
> > IIUC, I'm afraid you have to repost this patch after 24 hour...
> >
>
> Thanks, yes this if statement isn't necessary. Thanks! I will repost
> after 24 hours.
>
> > Thanks,
> > Jason
> >
> >> +               xsk_inc_num_desc(skb);
> >>
> >>          return skb;
> >>
> >> @@ -1904,7 +1933,7 @@ static int __init xsk_init(void)
> >>                  goto out_pernet;
> >>
> >>          xsk_tx_generic_cache =3D kmem_cache_create("xsk_generic_xmit_=
cache",
> >> -                                                sizeof(struct xsk_add=
r_node),
> >> +                                                sizeof(struct xsk_add=
rs),
> >>                                                   0, SLAB_HWCACHE_ALIG=
N, NULL);
> >>          if (!xsk_tx_generic_cache) {
> >>                  err =3D -ENOMEM;
> >> --
> >> 2.51.1
> >>
> >
>

