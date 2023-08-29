Return-Path: <bpf+bounces-8879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B33F378BD7D
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 06:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30795280E0D
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 04:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1466310F1;
	Tue, 29 Aug 2023 04:18:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B11EC0;
	Tue, 29 Aug 2023 04:18:22 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014FE109;
	Mon, 28 Aug 2023 21:18:20 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68bec3a9bdbso2452871b3a.3;
        Mon, 28 Aug 2023 21:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693282700; x=1693887500;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTgsziPyop0UogkGd7ZGdfJFeCYyGjagwgGI7/9gEM8=;
        b=WPs7cR2b+1DmUoAjiBTkxCkrzmam9Hbibeb2F4egm0jjZbur0hjyiyWk1PEdqt2z1Z
         Rn/J0UaHkSvAmuU/iS4OZmbujvrvz3zKJyMVXMfTP8B6FgC6X5XtScqKcSVoDLbJoBVK
         NVob3hE5mA3KscXc8m/sHiUb9b5wp0jwbtqFizPRLrt9f9fN0OSFrvT6UNSw2sGHRMwq
         eu+U5oDFJ0mJo0WrdHeiGzGMq6NPuXqx5u/f7XT5xDGd5M5DUKCJAboxU4vIvXTMuxHR
         FKRCLm9vjyw8LZxTs5mOgmVW8K1hSHodZuZqoMYIoC29oI0xWEjd6GlKh3RqzluaZuza
         /iVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693282700; x=1693887500;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HTgsziPyop0UogkGd7ZGdfJFeCYyGjagwgGI7/9gEM8=;
        b=I7UNSJRVRZQcGtURvYhuYz3ubjxBpKPv7MWgytHaFV5bsMimdZjX1aUY1wgKSe955D
         Bm7rMNDM3qex3elYulOwNVOU1fNw3WlMn5HHQ6U6f9IHRPXcooXlL395b/POya9tBWgB
         yRQXtxHBgPMPf/1w3ARH7Tbw8TdI52SWpBSOT7Vr/k37uUDyi2yjZZB0mzKXVw+ZEepI
         fcJO1eOOXFZsY5qGRCVB2qGffu3lDjLV/2ZPwC1YEeVd3KpACcxNVPyaqvwGVx7q9GN2
         Ngow00mNF2LiU+9B2IR0luhCaPPk/mMkbLT5Wq+o/US+h0HXCeLOVbnwbKf1wJSxN2Q3
         IY2w==
X-Gm-Message-State: AOJu0YzQb3kzF78iOmo1lP3rcvcCjyOAzEv3AMq9maCQfImOx/zZMwuZ
	WPxdjtZtX3PFOaUO3Tb5sxk=
X-Google-Smtp-Source: AGHT+IErKqG9RJPr78VekWRdSK84LNG1VWe0qyWe9VjnveUQMOATLtinlscjdUKOf0cl/mDEqErHGg==
X-Received: by 2002:a05:6a20:14f:b0:14d:382c:f908 with SMTP id 15-20020a056a20014f00b0014d382cf908mr4422057pzs.32.1693282700106;
        Mon, 28 Aug 2023 21:18:20 -0700 (PDT)
Received: from localhost ([12.183.168.230])
        by smtp.gmail.com with ESMTPSA id p15-20020a170902a40f00b001c0de73564dsm7774151plq.205.2023.08.28.21.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 21:18:19 -0700 (PDT)
Date: Mon, 28 Aug 2023 21:18:16 -0700
From: willemjdebruijn <willemdebruijn.kernel@gmail.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>, 
 Alexander Duyck <alexanderduyck@fb.com>, 
 David Howells <dhowells@redhat.com>, 
 Jesper Dangaard Brouer <brouer@redhat.com>, 
 Kees Cook <keescook@chromium.org>, 
 netdev@vger.kernel.org (open list:NETWORKING [GENERAL]), 
 linux-kernel@vger.kernel.org (open list), 
 bpf@vger.kernel.org (open list:BPF [MISC])
Message-ID: <64ed7188a2745_9cf208e1@penguin.notmuch>
In-Reply-To: <20230828233210.36532-1-mkhalfella@purestorage.com>
References: <20230828233210.36532-1-mkhalfella@purestorage.com>
Subject: RE: [PATCH] skbuff: skb_segment, Update nfrags after calling zero
 copy functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mohamed Khalfella wrote:
> We have seen kernel panic with stacktrace below. This is 5.15.123
> LTS kernel running a qemu VM with virtio network interface and
> vhost=on. When enabling packet corruption, with command below, we see
> the kernel panic.
> 
> tc qdisc add dev eth2 root netem corrupt 0.7065335155074846%
> 
> [  193.894380] BUG: kernel NULL pointer dereference, address: 00000000000000bc
> [  193.894635] #PF: supervisor read access in kernel mode
> [  193.894828] #PF: error_code(0x0000) - not-present page
> [  193.895027] PGD 0 P4D 0
> [  193.895140] Oops: 0000 [#1] SMP
> [  193.895273] CPU: 13 PID: 18164 Comm: vh-net-17428 Kdump: loaded Tainted: G           O      5.15.123+ #26
> [  193.895602] Hardware name:
> [  193.903919] RIP: 0010:skb_segment+0xb0e/0x12f0
> [  193.908176] Code: 45 a8 50 e8 54 46 be ff 44 8b 5d 80 41 01 c7 48 83 c4 18 44 89 7d b4 44 3b 5d b0 0f 8c f0 00 00 00 4d 85 e4 0f 84 65 07 00 00 <45> 8b b4 24 bc 00 00 00 48 8b b5 70 ff ff ff 4d 03 b4 24 c0 00 00
> [  193.921099] RSP: 0018:ffffc9002bf2f770 EFLAGS: 00010282
> [  193.925552] RAX: 00000000000000ee RBX: ffff88baab5092c8 RCX: 0000000000000003
> [  193.934308] RDX: 0000000000000000 RSI: 00000000fff7ffff RDI: 0000000000000001
> [  193.943281] RBP: ffffc9002bf2f850 R08: 0000000000000000 R09: c0000000fff7ffff
> [  193.952658] R10: 0000000000000029 R11: ffffc9002bf2f310 R12: 0000000000000000
> [  193.962423] R13: ffff88abc2291e00 R14: ffff88abc2291d00 R15: ffff88abc2290600
> [  193.972593] FS:  0000000000000000(0000) GS:ffff88c07f840000(0000) knlGS:0000000000000000
> [  193.983302] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  193.988891] CR2: 00000000000000bc CR3: 0000001dccb4b006 CR4: 00000000001726e0
> [  193.999925] MSR 198h IA32 perf status 0x00001ba000001a00
> [  194.005488] MSR 19Ch IA32 thermal status 0x0000000088370000
> [  194.010983] MSR 1B1h IA32 package thermal status 0x0000000088330000
> [  194.021892] Call Trace:
> [  194.027422]  <TASK>
> [  194.032838]  ? __die_body+0x1a/0x60
> [  194.038172]  ? page_fault_oops+0x12d/0x4d0
> [  194.043395]  ? skb_segment+0xb0e/0x12f0
> [  194.048501]  ? search_bpf_extables+0x59/0x60
> [  194.053547]  ? fixup_exception+0x1d/0x250
> [  194.058537]  ? exc_page_fault+0x67/0x140
> [  194.063382]  ? asm_exc_page_fault+0x1f/0x30
> [  194.068171]  ? skb_segment+0xb0e/0x12f0
> [  194.072861]  tcp_gso_segment+0x107/0x540
> [  194.077507]  ? sk_common_release+0xe0/0xe0
> [  194.082031]  inet_gso_segment+0x15c/0x3d0
> [  194.086441]  ? __skb_get_hash_symmetric+0x190/0x190
> [  194.090783]  skb_mac_gso_segment+0x9f/0x110
> [  194.095016]  __skb_gso_segment+0xc1/0x190
> [  194.099124]  ? netif_skb_features+0xb5/0x280
> [  194.103131]  netem_enqueue+0x290/0xb10 [sch_netem]
> [  194.107071]  dev_qdisc_enqueue+0x16/0x70
> [  194.110884]  __dev_queue_xmit+0x63b/0xb30
> [  194.114569]  ? inet_gso_segment+0x15c/0x3d0
> [  194.118160]  ? bond_start_xmit+0x159/0x380 [bonding]
> [  194.121670]  bond_start_xmit+0x159/0x380 [bonding]
> [  194.125101]  ? skb_mac_gso_segment+0xa7/0x110
> [  194.128506]  dev_hard_start_xmit+0xc3/0x1e0
> [  194.131787]  __dev_queue_xmit+0x8a0/0xb30
> [  194.134977]  ? macvlan_start_xmit+0x4f/0x100 [macvlan]
> [  194.138225]  macvlan_start_xmit+0x4f/0x100 [macvlan]
> [  194.141477]  dev_hard_start_xmit+0xc3/0x1e0
> [  194.144622]  sch_direct_xmit+0xe3/0x280
> [  194.147748]  __dev_queue_xmit+0x54a/0xb30
> [  194.150924]  ? tap_get_user+0x2a8/0x9c0 [tap]
> [  194.154131]  tap_get_user+0x2a8/0x9c0 [tap]
> [  194.157358]  tap_sendmsg+0x52/0x8e0 [tap]
> [  194.160565]  ? get_tx_bufs+0x42/0x1d0 [vhost_net]
> [  194.163815]  ? get_tx_bufs+0x16a/0x1d0 [vhost_net]
> [  194.167049]  handle_tx_zerocopy+0x14e/0x4c0 [vhost_net]
> [  194.170351]  ? add_range+0x11/0x30
> [  194.173631]  handle_tx+0xcd/0xe0 [vhost_net]
> [  194.176959]  vhost_worker+0x76/0xb0 [vhost]
> [  194.180299]  ? vhost_flush_work+0x10/0x10 [vhost]
> [  194.183667]  kthread+0x118/0x140
> [  194.187007]  ? set_kthread_struct+0x40/0x40
> [  194.190358]  ret_from_fork+0x1f/0x30
> [  194.193670]  </TASK>
> 
> I have narrowed the issue down to these lines in skb_segment()
> 
> 4247                 if (skb_orphan_frags(frag_skb, GFP_ATOMIC) ||
> 4248                     skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
> 4249                         goto err;
> 
> It is possible for skb_orphan_frags() or skb_zerocopy_clone() to update
> `nr_frags` as both functions may call skb_copy_ubufs(). If `nr_frags`
> gets updated, the local copy in `nfrags` might end up stale and cause
> this panic. In particular it is possible the while loop below hits
> `i >= nrfrags` prematurely and tries to move to next `frag_skb` by using
> `list_skb`. If `list_skb` is NULL then we hit the panic above.
> 
> The naive way to fix this is to update `nfrags` as shown in this patch.
> This way we get the correct number of fragments and while loop can
> find all fragments without needing to move to next skbuff.
> 
> I wanted to share this with the list and see what people think before
> submitting a patch. Specially that I have not tested this on master
> branch.
> 
> Fixes: bf5c25d60861 ("skbuff: in skb_segment, call zerocopy functions once per nskb")
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>  net/core/skbuff.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a298992060e6..864cc8ad1969 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4567,6 +4567,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  		if (skb_orphan_frags(frag_skb, GFP_ATOMIC) ||
>  		    skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
>  			goto err;
> +		/* Update nfrags in case skb_copy_ubufs() updates nr_frags */
> +		nfrags = skb_shinfo(frag_skb)->nr_frags;
>  
>  		while (pos < offset + len) {
>  			if (i >= nfrags) {
> @@ -4587,6 +4589,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  				    skb_zerocopy_clone(nskb, frag_skb,
>  						       GFP_ATOMIC))
>  					goto err;
> +				/* Update nfrags in case skb_copy_ubufs() updates nr_frags */
> +				nfrags = skb_shinfo(frag_skb)->nr_frags;
>  
>  				list_skb = list_skb->next;
>  			}

In principle this makes sense to me. skb_copy_ubufs will create new
frags, which do not map 1:1 on to the original frags. It originally
allocated the number of order 0 pages required to store
__skb_pagelen(skb). Recently it switched to using high order pages.

The two calls to skb_orphan_frags and skb_zerocopy clone are called
for each new segment skb. But only on skb_orphan_frags will it
possibly call skb_copy_ubufs, an then always for the first call of the
input skb (head_skb or a list_skb). From commit "skbuff: in
skb_segment, call zerocopy functions once per nskb":

   "When segmenting skbs with user frags, either the user frags must be
    replaced with private copies and uarg released, or the uarg must have
    its refcount increased for each new skb.

    skb_orphan_frags does the first, except for cases that can handle
    reference counting. skb_zerocopy_clone then does the second."

skb_copy_ubufs only called on the first check for an input simplifies.
A possible realloc in the middle of processing a series of frags would
be much harder.

Small point: nfrags is not the only state that needs to be refreshed
after a fags realloc, also frag.

Thanks for the report. I'm traveling likely without internet until the
weekend. Apologies if it takes a while for me to follow up.

