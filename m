Return-Path: <bpf+bounces-17530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B82580ED9A
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 14:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A581D28119A
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 13:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E19D61FDD;
	Tue, 12 Dec 2023 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kl7buK6p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486E5100;
	Tue, 12 Dec 2023 05:31:03 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-67ad9844cb1so9760416d6.0;
        Tue, 12 Dec 2023 05:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702387862; x=1702992662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QPamqnA23M1uZlv773bjp8k0/UlABPvozTM/nwMkNpE=;
        b=kl7buK6pWu7wYk04BUuBtVdfNm7abPlDQAbS4y57AipYgOfuBVSrj3uN+lfNfcWlMj
         UDoQDcBLn1Q0I/xFHNslka7MMA1uxiU5YNcir41vL4o1snHS3TnTFn45yZL2/i5Q11qn
         2B9QoB7Zu6YdD+xgE0N+YSkQIsU5PTzBAH49h63kdA/nCKw3gqszDDJdps/mSZG7/zGU
         IzSRRRyWWuufS4Gn31RdKJyxh0XmJi+b83uX4DeDY8nSQdXx7LsnqyLXYmuV+5rz0GTV
         +dDb+1vk8xcM1w6JCddFsRN80gojFtP+DwK1cURo2F+WA931QdJ36q0SYkKPxQl/huCk
         Pbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702387862; x=1702992662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPamqnA23M1uZlv773bjp8k0/UlABPvozTM/nwMkNpE=;
        b=AkRZE2hublUjQtIPjeWEhCM8n/oFWAUkwrlhgEIdFvG/4yxPqyoolqPiR/IF6NbSBj
         qAxWuyv9Ij/LC7lKLWdS8Ojx7kjI/g5WU2S/C6r0JVSx8wOG8EqqLg9tRoY9trumwhUl
         HYGjfKJJUCOOqMxLc0WaYAkQbFWUHSUwy1FsJjUOkCrrIPq2MGY4o0Jl0KxAPhvDRW51
         QBWo32ADM6IhAr2F05DFmMeGNqlJ4NZ6hR6LwOuB0pXPF3u5gzMweDPV/A/lO9vgCaHR
         FKkei+5fwoMrr6gugDWlX3UqLVrIQDddua5XHKiFWjL8W9Rd/5d06WUHUin3NLfNER6t
         mA2w==
X-Gm-Message-State: AOJu0YzwfZWqhtap5+rWZ1dGgJ6ZwbYNSalTxGIwNgbipYd9sJFQji8G
	Xg3B+pbqWz2m9wSCpGt1BdeOFBOCks/0mFt2fyg=
X-Google-Smtp-Source: AGHT+IHAZXevz7MuvZami8oPncqF/HNhx8/21kOHF57z/VWamek2NsoPt6T9jn8KhHMhVcwO60a153ecP2GRFX0aSYU=
X-Received: by 2002:ad4:5b82:0:b0:678:35a9:c363 with SMTP id
 2-20020ad45b82000000b0067835a9c363mr10816904qvp.4.1702387862188; Tue, 12 Dec
 2023 05:31:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212125713.336271-1-maciej.fijalkowski@intel.com> <20231212125713.336271-3-maciej.fijalkowski@intel.com>
In-Reply-To: <20231212125713.336271-3-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 12 Dec 2023 14:30:50 +0100
Message-ID: <CAJ8uoz2MAquu8yMgyNAubFB+uj+Dk0jSwwr9GmngK6YTM6sH6A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 2/3] xsk: fix usage of multi-buffer BPF helpers for
 ZC XDP
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, echaudro@redhat.com, lorenzo@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Dec 2023 at 13:58, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Currently when packet is shrunk via bpf_xdp_adjust_tail(), null ptr
> dereference happens:
>
> [1136314.192256] BUG: kernel NULL pointer dereference, address:
> 0000000000000034
> [1136314.203943] #PF: supervisor read access in kernel mode
> [1136314.213768] #PF: error_code(0x0000) - not-present page
> [1136314.223550] PGD 0 P4D 0
> [1136314.230684] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [1136314.239621] CPU: 8 PID: 54203 Comm: xdpsock Not tainted 6.6.0+ #257
> [1136314.250469] Hardware name: Intel Corporation S2600WFT/S2600WFT,
> BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> [1136314.265615] RIP: 0010:__xdp_return+0x6c/0x210
> [1136314.274653] Code: ad 00 48 8b 47 08 49 89 f8 a8 01 0f 85 9b 01 00 00 0f 1f 44 00 00 f0 41 ff 48 34 75 32 4c 89 c7 e9 79 cd 80 ff 83 fe 03 75 17 <f6> 41 34 01 0f 85 02 01 00 00 48 89 cf e9 22 cc 1e 00 e9 3d d2 86
> [1136314.302907] RSP: 0018:ffffc900089f8db0 EFLAGS: 00010246
> [1136314.312967] RAX: ffffc9003168aed0 RBX: ffff8881c3300000 RCX:
> 0000000000000000
> [1136314.324953] RDX: 0000000000000000 RSI: 0000000000000003 RDI:
> ffffc9003168c000
> [1136314.336929] RBP: 0000000000000ae0 R08: 0000000000000002 R09:
> 0000000000010000
> [1136314.348844] R10: ffffc9000e495000 R11: 0000000000000040 R12:
> 0000000000000001
> [1136314.360706] R13: 0000000000000524 R14: ffffc9003168aec0 R15:
> 0000000000000001
> [1136314.373298] FS:  00007f8df8bbcb80(0000) GS:ffff8897e0e00000(0000)
> knlGS:0000000000000000
> [1136314.386105] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [1136314.396532] CR2: 0000000000000034 CR3: 00000001aa912002 CR4:
> 00000000007706f0
> [1136314.408377] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [1136314.420173] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [1136314.431890] PKRU: 55555554
> [1136314.439143] Call Trace:
> [1136314.446058]  <IRQ>
> [1136314.452465]  ? __die+0x20/0x70
> [1136314.459881]  ? page_fault_oops+0x15b/0x440
> [1136314.468305]  ? exc_page_fault+0x6a/0x150
> [1136314.476491]  ? asm_exc_page_fault+0x22/0x30
> [1136314.484927]  ? __xdp_return+0x6c/0x210
> [1136314.492863]  bpf_xdp_adjust_tail+0x155/0x1d0
> [1136314.501269]  bpf_prog_ccc47ae29d3b6570_xdp_sock_prog+0x15/0x60
> [1136314.511263]  ice_clean_rx_irq_zc+0x206/0xc60 [ice]
> [1136314.520222]  ? ice_xmit_zc+0x6e/0x150 [ice]
> [1136314.528506]  ice_napi_poll+0x467/0x670 [ice]
> [1136314.536858]  ? ttwu_do_activate.constprop.0+0x8f/0x1a0
> [1136314.546010]  __napi_poll+0x29/0x1b0
> [1136314.553462]  net_rx_action+0x133/0x270
> [1136314.561619]  __do_softirq+0xbe/0x28e
> [1136314.569303]  do_softirq+0x3f/0x60
>
> This comes from __xdp_return() call with xdp_buff argument passed as
> NULL which is supposed to be consumed by xsk_buff_free() call.
>
> To address this properly, in ZC case, a node that represents the frag
> being removed has to be pulled out of xskb_list. Introduce
> appriopriate xsk helpers to do such node operation and use them
> accordingly within bpf_xdp_adjust_tail().
>
> Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  include/net/xdp_sock_drv.h | 26 +++++++++++++++++++++
>  net/core/filter.c          | 48 +++++++++++++++++++++++++++++++-------
>  2 files changed, 65 insertions(+), 9 deletions(-)
>
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 81e02de3f453..123adc6d68c1 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -147,6 +147,23 @@ static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
>         return ret;
>  }
>
> +static inline void xsk_buff_tail_del(struct xdp_buff *tail)
> +{

I think it would be easier to remember function calls if we are
consistent in the naming. Most of them are _verb_noun(), so I would
call it xsk_buff_del_tail().

Apart from that:

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com> # For the xsk header part.

> +       struct xdp_buff_xsk *xskb = container_of(tail, struct xdp_buff_xsk, xdp);
> +
> +       list_del(&xskb->xskb_list_node);
> +}
> +
> +static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
> +{
> +       struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
> +       struct xdp_buff_xsk *frag;
> +
> +       frag = list_last_entry(&xskb->pool->xskb_list, struct xdp_buff_xsk,
> +                              xskb_list_node);
> +       return &frag->xdp;
> +}
> +
>  static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
>  {
>         xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
> @@ -333,6 +350,15 @@ static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
>         return NULL;
>  }
>
> +static inline void xsk_buff_tail_del(struct xdp_buff *tail)
> +{
> +}
> +
> +static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
> +{
> +       return NULL;
> +}
> +
>  static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
>  {
>  }
> diff --git a/net/core/filter.c b/net/core/filter.c
> index adcfc2c25754..8ce13d73a660 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -83,6 +83,7 @@
>  #include <net/netfilter/nf_conntrack_bpf.h>
>  #include <net/netkit.h>
>  #include <linux/un.h>
> +#include <net/xdp_sock_drv.h>
>
>  #include "dev.h"
>
> @@ -4075,6 +4076,42 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
>         return 0;
>  }
>
> +static void __shrink_data(struct xdp_buff *xdp, struct xdp_mem_info *mem_info,
> +                         skb_frag_t *frag, int shrink)
> +{
> +       if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
> +               struct xdp_buff *tail = xsk_buff_get_tail(xdp);
> +
> +               if (tail)
> +                       tail->data_end -= shrink;
> +       }
> +       skb_frag_size_sub(frag, shrink);
> +}
> +
> +static bool shrink_data(struct xdp_buff *xdp, skb_frag_t *frag, int shrink)
> +{
> +       struct xdp_mem_info *mem_info = &xdp->rxq->mem;
> +
> +       if (skb_frag_size(frag) == shrink) {
> +               struct page *page = skb_frag_page(frag);
> +               struct xdp_buff *zc_frag = NULL;
> +
> +               if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
> +                       zc_frag = xsk_buff_get_tail(xdp);
> +
> +                       if (zc_frag) {
> +                               xdp_buff_clear_frags_flag(zc_frag);
> +                               xsk_buff_tail_del(zc_frag);
> +                       }
> +               }
> +
> +               __xdp_return(page_address(page), mem_info, false, zc_frag);
> +               return true;
> +       }
> +       __shrink_data(xdp, mem_info, frag, shrink);
> +       return false;
> +}
> +
>  static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
>  {
>         struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> @@ -4089,17 +4126,10 @@ static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
>
>                 len_free += shrink;
>                 offset -= shrink;
> -
> -               if (skb_frag_size(frag) == shrink) {
> -                       struct page *page = skb_frag_page(frag);
> -
> -                       __xdp_return(page_address(page), &xdp->rxq->mem,
> -                                    false, NULL);
> +               if (shrink_data(xdp, frag, shrink))
>                         n_frags_free++;
> -               } else {
> -                       skb_frag_size_sub(frag, shrink);
> +               else
>                         break;
> -               }
>         }
>         sinfo->nr_frags -= n_frags_free;
>         sinfo->xdp_frags_size -= len_free;
> --
> 2.34.1
>
>

