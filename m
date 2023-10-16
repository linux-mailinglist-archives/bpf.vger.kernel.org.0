Return-Path: <bpf+bounces-12250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3817C9FC2
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 08:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC581C209DD
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 06:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAA415486;
	Mon, 16 Oct 2023 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhFTjkBs"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3020214294;
	Mon, 16 Oct 2023 06:41:32 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BD897;
	Sun, 15 Oct 2023 23:41:30 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-66d501d3ffbso1920166d6.1;
        Sun, 15 Oct 2023 23:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697438489; x=1698043289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U2AgiFgpa6O47pkmBK6yizLzUM3j74/+Btppzhh7DTg=;
        b=bhFTjkBsaH04PGaiBkmzQe/A+T5jKzXD6kjZSvuh4bOTJB6PPR2v/dz2b96UnoueB3
         p+hjc1/8v1Lm4Vg+UmdHwlyNujaYu8NyKCFlRywK74SXZhyHXP6hz4xWj/f7Ir1X9kdh
         UuMEALuue/R4si2E4Uuls688KPGOWbrgKna0050vbiHRBZbmrlVS+Oeu+lxK0TM9zupT
         /SExgKzW8WJuYyB69ChApcrnqjdLmtg96qwYJtqumctwZ9sLuMPcYlmxzGX9UhIFhzwm
         34NTCZwOTux9lyDXvCvn6fyr1esNuONarHo1/MnZhH8oyimFzxpSNPmiJkvMeXPJx1Vw
         X3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697438489; x=1698043289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2AgiFgpa6O47pkmBK6yizLzUM3j74/+Btppzhh7DTg=;
        b=aoIPmq+iq3oKxmk3ydDvUNQ/5GD3tutw82tD5BAJ61SnXZ+JEteR+IA2GPriykqZEf
         uD0TvXwq9MHok/jbI5RdCi34+dDWwLGb7sN2IAbmF69BsSsa7AmAzrvzw+JnChFYJNvh
         FerfVrsf0I6stAHsdJiOhUsU3ectPeRY54ezOkuTR6ToqHhYXicrSYugJ7pBcT2luA+d
         PdlBh3ZOastDiuGeegO1B37OQP90/SzelC1UffhCd7wV/cEKveqQ7Ynf42IlKylTlmAH
         w8PZRx13NR+fpUfXijIgWa/ig9/xlC83EiEJKgh5IgLCKxcTfEf7QLQtDhEdOHBLhSWJ
         y4Og==
X-Gm-Message-State: AOJu0YzrGyFeer6cgcxXfK9Jl/tVNY4dTcBW+sL8Q3lsTzpi3v5X3C/D
	CrFQ/9hKEI1aPau5EXz2WjfYNAAc0QVuSOd63qk=
X-Google-Smtp-Source: AGHT+IGOu5dCy5DsNJpTp0AkS3qCm43hqcvFo/YwF82YWmIpdeQwZY5gHOF2HV1zq1FBJiQdEfPmvpwyhBwF2SF+SxQ=
X-Received: by 2002:ad4:5a13:0:b0:66d:5d31:999b with SMTP id
 ei19-20020ad45a13000000b0066d5d31999bmr1038478qvb.3.1697438489105; Sun, 15
 Oct 2023 23:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016031649.35088-1-huangjie.albert@bytedance.com>
In-Reply-To: <20231016031649.35088-1-huangjie.albert@bytedance.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 16 Oct 2023 08:41:17 +0200
Message-ID: <CAJ8uoz2DUe3xySTKuLbA5=QDAGuTzPdGu3P_=ZvJmna25VtHCQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] xsk: Avoid starving xsk at the end of the list
To: Albert Huang <huangjie.albert@bytedance.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 16 Oct 2023 at 05:17, Albert Huang
<huangjie.albert@bytedance.com> wrote:
>
> In the previous implementation, when multiple xsk sockets were
> associated with a single xsk_buff_pool, a situation could arise
> where the xsk_tx_list maintained data at the front for one xsk
> socket while starving the xsk sockets at the back of the list.
> This could result in issues such as the inability to transmit packets,
> increased latency, and jitter. To address this problem, we introduced
> a new variable called tx_budget_cache, which limits each xsk to transmit
> a maximum of MAX_XSK_TX_BUDGET tx descriptors. This allocation ensures
> equitable opportunities for subsequent xsk sockets to send tx descriptors.
> The value of MAX_XSK_TX_BUDGET is temporarily set to 16.

Hi Albert. Yes you are correct that there is nothing hindering this to
happen in the code at the moment, so let us fix it.

> Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> ---
>  include/net/xdp_sock.h |  6 ++++++
>  net/xdp/xsk.c          | 18 ++++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 69b472604b86..f617ff54e38c 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -44,6 +44,7 @@ struct xsk_map {
>         struct xdp_sock __rcu *xsk_map[];
>  };
>
> +#define MAX_XSK_TX_BUDGET 16

I think something like MAX_PER_SOCKET_BUDGET would be clearer.

>  struct xdp_sock {
>         /* struct sock must be the first member of struct xdp_sock */
>         struct sock sk;
> @@ -63,6 +64,11 @@ struct xdp_sock {
>
>         struct xsk_queue *tx ____cacheline_aligned_in_smp;
>         struct list_head tx_list;
> +       /* Record the actual number of times xsk has transmitted a tx
> +        * descriptor, with a maximum limit not exceeding MAX_XSK_TX_BUDGET
> +        */
> +       u32 tx_budget_cache;
> +
>         /* Protects generic receive. */
>         spinlock_t rx_lock;
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f5e96e0d6e01..087f2675333c 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -413,16 +413,25 @@ EXPORT_SYMBOL(xsk_tx_release);
>
>  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
>  {
> +       u32 xsk_full_count = 0;

Enough with a bool;

>         struct xdp_sock *xs;
>
>         rcu_read_lock();
> +again:
>         list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> +               if (xs->tx_budget_cache >= MAX_XSK_TX_BUDGET) {
> +                       xsk_full_count++;
> +                       continue;
> +               }

The problem here is that the fixed MAX_XSK_TX_BUDGET is only useful
for the <= 2 socket case. If I have 3 sockets sharing a
netdev/queue_id, the two first sockets can still starve the third one
since the total budget per send is 32. You need to go through the list
of sockets in the beginning to compute the MAX_XSK_TX_BUDGET to
compute this dynamically before each call. Or cache this value
somehow, in the pool for example. Actually, the refcount in the
buf_pool will tell you how many sockets are sharing the same buf_pool.
Try using that to form MAX_XSK_TX_BUDGET on the fly.

Another simpler way of accomplishing this would be to just reorder the
list every time. Put the first socket last in the list every time. The
drawback of this is that you need to hold the xsk_tx_list_lock while
doing this so might be slower. The per socket batch size would also be
32 and you would not receive "fairness" over a single call to
sendto(). Would that be a problem for you?

> +
>                 if (!xskq_cons_peek_desc(xs->tx, desc, pool)) {
>                         if (xskq_has_descs(xs->tx))
>                                 xskq_cons_release(xs->tx);
>                         continue;
>                 }
>
> +               xs->tx_budget_cache++;
> +
>                 /* This is the backpressure mechanism for the Tx path.
>                  * Reserve space in the completion queue and only proceed
>                  * if there is space in it. This avoids having to implement
> @@ -436,6 +445,14 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
>                 return true;
>         }
>
> +       if (unlikely(xsk_full_count > 0)) {
> +               list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> +                       xs->tx_budget_cache = 0;
> +               }
> +               xsk_full_count = 0;
> +               goto again;
> +       }
> +
>  out:
>         rcu_read_unlock();
>         return false;
> @@ -1230,6 +1247,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
>         xs->zc = xs->umem->zc;
>         xs->sg = !!(xs->umem->flags & XDP_UMEM_SG_FLAG);
>         xs->queue_id = qid;
> +       xs->tx_budget_cache = 0;
>         xp_add_xsk(xs->pool, xs);
>
>  out_unlock:
> --
> 2.20.1
>
>

