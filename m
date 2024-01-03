Return-Path: <bpf+bounces-18914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950FA8236C7
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 21:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620BB1C2451B
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967031D550;
	Wed,  3 Jan 2024 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feQ1fiOQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B761CFBB;
	Wed,  3 Jan 2024 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d9a795cffbso616445b3a.0;
        Wed, 03 Jan 2024 12:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704314893; x=1704919693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWTOfCLbDZyv1pDpUMPr4JrixaTsYv9ye0Brkumz4dM=;
        b=feQ1fiOQOd7VQ+YvTWqT+XUTKqLgmxGGJQ4yiXm0paq4QiOL6TOnHOkRve/0vOpC2e
         NMPmLdM4vxBPRdWf32I7r5kZwuSoggxJ/6OHet7PQYzlXKxpAJNixci5narVksWRS/i8
         jZXeNT8kJPX/0XahPmag/2bPx6hVQaF5/T6CtqpZi55jTHwYOqYaiEkwW7J7u/bYokU5
         oynbL33aPBqyaohhMAErf4rK0jK/5yXdMrcujcwTKZRJQK2/GrK+2WZjm4BDZvB0rFLr
         GfdQf4Ma39WCKYY1NZGheJt+uO1HE1BVILcrWpgw1mU3C+aqj0Cigg3fW1gXJjT3kxWc
         pBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704314893; x=1704919693;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IWTOfCLbDZyv1pDpUMPr4JrixaTsYv9ye0Brkumz4dM=;
        b=KY9Ae9A7wa65K6FfPRUhEKa9+8p4dqZtVSjwPzQlFuEzmkmu90nf779s/IdY65U4PO
         WzlU6h40NhxZ9bEocFqTdhnehREiUiEL5aTeq5HzFLsl3l9TMjMm2iFJBvx+6vsnTGpr
         QqhKsmcI9kTFfXIzpXYW/hbHHr52RHhmw88xCmhn1SfaNBIxwM57cqe677fh50mZxgcU
         s/tPBxmf0nRkl2WCWgAICz7o9JWZr6naUEKfR8N9ydUBQH5JRSarGNpmfR+kNuAgaDnM
         S1MKQmPA1JOfxkVrrOFDmW/dksPMi/aubVMspZJLCgg3OAZC0dNt4u4SBty56nmf82qF
         pahg==
X-Gm-Message-State: AOJu0Yyuiszvnyt1KS+yXlZv0nTE0EDj37dXXhLGF+H7G3AlcTd6cD9w
	4WWkSS3FdyGzQb+ZLs9uDdZfrNaHkVk=
X-Google-Smtp-Source: AGHT+IEJMhEwp/lrmjY2CiSuaYTdmn9J/3c6y1l2OsOY6D6B8+pH4QUD04PKEDCIWB/yekr+y3vMlQ==
X-Received: by 2002:a05:6a00:b82:b0:6da:b57f:d4d7 with SMTP id g2-20020a056a000b8200b006dab57fd4d7mr1460706pfj.35.1704314892768;
        Wed, 03 Jan 2024 12:48:12 -0800 (PST)
Received: from localhost ([98.97.37.198])
        by smtp.gmail.com with ESMTPSA id f29-20020a63555d000000b005c60ad6c4absm22831034pgm.4.2024.01.03.12.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:48:12 -0800 (PST)
Date: Wed, 03 Jan 2024 12:48:10 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org
Cc: netdev@vger.kernel.org, 
 magnus.karlsson@intel.com, 
 bjorn@kernel.org, 
 maciej.fijalkowski@intel.com, 
 echaudro@redhat.com, 
 lorenzo@kernel.org, 
 tirthendu.sarkar@intel.com
Message-ID: <6595c80a83de0_256122088a@john.notmuch>
In-Reply-To: <20231221132656.384606-3-maciej.fijalkowski@intel.com>
References: <20231221132656.384606-1-maciej.fijalkowski@intel.com>
 <20231221132656.384606-3-maciej.fijalkowski@intel.com>
Subject: RE: [PATCH v3 bpf 2/4] xsk: fix usage of multi-buffer BPF helpers for
 ZC XDP
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Maciej Fijalkowski wrote:
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

hmm it looks like xsk_buff_free() called by __xdp_return would
pull the frag out of the xskb_list? Or am I wrong?

Then the issue is primarily the NULL handling?

> appriopriate xsk helpers to do such node operation and use them
> accordingly within bpf_xdp_adjust_tail().
> 
> Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com> # For the xsk header part
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  include/net/xdp_sock_drv.h | 26 +++++++++++++++++++++
>  net/core/filter.c          | 48 +++++++++++++++++++++++++++++++-------
>  2 files changed, 65 insertions(+), 9 deletions(-)
> 
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index b62bb8525a5f..3d35ac0f838b 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -159,6 +159,23 @@ static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
>  	return ret;
>  }
>  
> +static inline void xsk_buff_del_tail(struct xdp_buff *tail)
> +{
> +	struct xdp_buff_xsk *xskb = container_of(tail, struct xdp_buff_xsk, xdp);
> +
> +	list_del(&xskb->xskb_list_node);
> +}
> +
> +static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
> +{
> +	struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
> +	struct xdp_buff_xsk *frag;
> +
> +	frag = list_last_entry(&xskb->pool->xskb_list, struct xdp_buff_xsk,
> +			       xskb_list_node);
> +	return &frag->xdp;
> +}
> +
>  static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
>  {
>  	xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
> @@ -350,6 +367,15 @@ static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
>  	return NULL;
>  }
>  
> +static inline void xsk_buff_del_tail(struct xdp_buff *tail)
> +{
> +}
> +
> +static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
> +{
> +	return NULL;
> +}
> +
>  static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
>  {
>  }
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 24061f29c9dd..1e20196687fd 100644
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
> @@ -4096,6 +4097,42 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
>  	return 0;
>  }
>  
> +static void __shrink_data(struct xdp_buff *xdp, struct xdp_mem_info *mem_info,
> +			  skb_frag_t *frag, int shrink)
> +{
> +	if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
> +		struct xdp_buff *tail = xsk_buff_get_tail(xdp);
> +
> +		if (tail)
> +			tail->data_end -= shrink;
> +	}
> +	skb_frag_size_sub(frag, shrink);
> +}
> +
> +static bool shrink_data(struct xdp_buff *xdp, skb_frag_t *frag, int shrink)
> +{
> +	struct xdp_mem_info *mem_info = &xdp->rxq->mem;
> +
> +	if (skb_frag_size(frag) == shrink) {
> +		struct page *page = skb_frag_page(frag);
> +		struct xdp_buff *zc_frag = NULL;
> +
> +		if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
> +			zc_frag = xsk_buff_get_tail(xdp);
> +
> +			if (zc_frag) {
> +				xdp_buff_clear_frags_flag(zc_frag);
> +				xsk_buff_del_tail(zc_frag);
> +			}
> +		}

Should this be fixed in xdp_return instead of here? The xdp_return
is doing what xsk_buff_del_tail() does. If we also called clear_frags
there could this be simpler?

 if (skb_frag_size(frag) == shrink) {
	struct page *page = skb_frag_page(frag);

	__xdp_return(page_address(page), mem_info, false, xsk_buff_get_tail(xdp));
 } else {
   __shrink_data(xdp, mem_info, frag, shrink);
 }

the return will need to have an unlikely(!xdp) to guard the case it
might be NULL, but also not sure if we would ever expect a NULL
here if MEM_TYPE_XSK_BUFF_POOL so you might skip that unlikely
as well?

> +
> +		__xdp_return(page_address(page), mem_info, false, zc_frag);
> +		return true;
> +	}
> +	__shrink_data(xdp, mem_info, frag, shrink);
> +	return false;
> +}
> +
>  static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
>  {
>  	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> @@ -4110,17 +4147,10 @@ static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
>  
>  		len_free += shrink;
>  		offset -= shrink;
> -
> -		if (skb_frag_size(frag) == shrink) {
> -			struct page *page = skb_frag_page(frag);
> -

And then I likely would avoid the helper altogether? And code
example above just lands here?

> -			__xdp_return(page_address(page), &xdp->rxq->mem,
> -				     false, NULL);
> +		if (shrink_data(xdp, frag, shrink))
>  			n_frags_free++;
> -		} else {
> -			skb_frag_size_sub(frag, shrink);
> +		else
>  			break;
> -		}
>  	}

I think the fix can be more straight-forward if we just populate
the NULL field with the xdp_buff using the get_tail() helper
created above.

>  	sinfo->nr_frags -= n_frags_free;
>  	sinfo->xdp_frags_size -= len_free;
> -- 
> 2.34.1
> 
> 



