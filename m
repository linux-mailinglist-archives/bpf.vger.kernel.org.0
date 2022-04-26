Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7165250F95A
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 11:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345046AbiDZJrl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 05:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344889AbiDZJqP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 05:46:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4871E2C1F;
        Tue, 26 Apr 2022 02:01:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e24so830941pjt.2;
        Tue, 26 Apr 2022 02:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQOrvzoqpUoDGXa5Z21KCeKFPfO5fOqXnANuROModjY=;
        b=Wpu0IIShcjga24GdYlPiRkbuDlpsQVW12Gr11t18IG/vpxKEdbLk4nGmfFSoH3yp4i
         UGf+Gu99U5bwI+4Za6gLTx+LupbegNy+qucgxRRcq0XqUJ9SmaiSScsDcOjQH+vh4ZZ1
         /+QKBxlEEZrd/jVNZRy3GqsTRsSb6jVClvqDF9g0AWEi1aejeek+wC5ynH/hZ3mkKD4I
         3CxHiH+m2MTU73C1Lh7zRxr+Zl2rmwpF4nBdjvF1y0RVPcnrJioFw9O4vU8YBoUSuRuz
         8QEb7mVkUjXEejTsxbALxJX8aIwXFdgQhuwvZlWVCFVD80zH9+/tRfAEcDQkVFLXNR+0
         AZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQOrvzoqpUoDGXa5Z21KCeKFPfO5fOqXnANuROModjY=;
        b=cN7WHo4nVnaFcE3uY4Ssl8qLtt0ct6Jv9U3o8HVlvncXdHA2JHsTSQnVQ0eMTmOZAB
         UiwjDPYGn3VlNuN2HpDVmuiuPckYzvW0HeNCgI0QGybPdzDKWaGqIl7HqtvUMmEEf0vi
         HV+gl5eTVKL9JlrryAP5WNrakImpN4Ke1xYqgyULSfzgYuYb2+JcP+p9wWiRKCC66Wis
         ZoJ07qEQ8VXDOg+rEKso5jLltN60OKBK2rdA5G4bAuD/52xcItpQIaJGLHb0GVWSaDYk
         xhO55soWPqZxJYFrn57Sh8i8oWQFnH9wanaqAd4S8z9qVE0q308vwJBtGX8volFjFS/8
         ZmUw==
X-Gm-Message-State: AOAM532UCpGsnaRwV36oLr4QvzAbXBowmfg51wpz2SqYVDzzlb5pEYIU
        NdSUjwDRr6a+HRLgjgDdn70JF6bEX7Zxm0ivDag=
X-Google-Smtp-Source: ABdhPJwiwaps9ad0DjMmTmfdfyWSLUMNhL2KgYNV6+Cl6V0BDiSW0yxi8E9Ka3/uLeyN7ukCDUswrI5D6TTjBRg3jF8=
X-Received: by 2002:a17:902:8f94:b0:151:64c5:7759 with SMTP id
 z20-20020a1709028f9400b0015164c57759mr22454834plo.4.1650963697941; Tue, 26
 Apr 2022 02:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220425153745.481322-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20220425153745.481322-1-maciej.fijalkowski@intel.com>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Tue, 26 Apr 2022 11:01:26 +0200
Message-ID: <CAJ8uoz3X+zv_hLme7QDDWYy4AGyTdUPA9d=G302g-Rxq2WZiqA@mail.gmail.com>
Subject: Re: [PATCH bpf] xsk: fix possible crash when multiple sockets are created
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, andriin@kernel.org,
        Network Development <netdev@vger.kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 26, 2022 at 12:28 AM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Fix a crash that happens if an Rx only socket is created first, then a
> second socket is created that is Tx only and bound to the same umem as
> the first socket and also the same netdev and queue_id together with the
> XDP_SHARED_UMEM flag. In this specific case, the tx_descs array page
> pool was not created by the first socket as it was an Rx only socket.
> When the second socket is bound it needs this tx_descs array of this
> shared page pool as it has a Tx component, but unfortunately it was
> never allocated, leading to a crash. Note that this array is only used
> for zero-copy drivers using the batched Tx APIs, currently only ice and
> i40e.
>
> [ 5511.150360] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [ 5511.158419] #PF: supervisor write access in kernel mode
> [ 5511.164472] #PF: error_code(0x0002) - not-present page
> [ 5511.170416] PGD 0 P4D 0
> [ 5511.173347] Oops: 0002 [#1] PREEMPT SMP PTI
> [ 5511.178186] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G            E     5.18.0-rc1+ #97
> [ 5511.187245] Hardware name: Intel Corp. GRANTLEY/GRANTLEY, BIOS GRRFCRB1.86B.0276.D07.1605190235 05/19/2016
> [ 5511.198418] RIP: 0010:xsk_tx_peek_release_desc_batch+0x198/0x310
> [ 5511.205375] Code: c0 83 c6 01 84 c2 74 6d 8d 46 ff 23 07 44 89 e1 48 83 c0 14 48 c1 e1 04 48 c1 e0 04 48 03 47 10 4c 01 c1 48 8b 50 08 48 8b 00 <48> 89 51 08 48 89 01 41 80 bd d7 00 00 00 00 75 82 48 8b 19 49 8b
> [ 5511.227091] RSP: 0018:ffffc90000003dd0 EFLAGS: 00010246
> [ 5511.233135] RAX: 0000000000000000 RBX: ffff88810c8da600 RCX: 0000000000000000
> [ 5511.241384] RDX: 000000000000003c RSI: 0000000000000001 RDI: ffff888115f555c0
> [ 5511.249634] RBP: ffffc90000003e08 R08: 0000000000000000 R09: ffff889092296b48
> [ 5511.257886] R10: 0000ffffffffffff R11: ffff889092296800 R12: 0000000000000000
> [ 5511.266138] R13: ffff88810c8db500 R14: 0000000000000040 R15: 0000000000000100
> [ 5511.274387] FS:  0000000000000000(0000) GS:ffff88903f800000(0000) knlGS:0000000000000000
> [ 5511.283746] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5511.290389] CR2: 0000000000000008 CR3: 00000001046e2001 CR4: 00000000003706f0
> [ 5511.298640] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 5511.306892] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 5511.315142] Call Trace:
> [ 5511.317972]  <IRQ>
> [ 5511.320301]  ice_xmit_zc+0x68/0x2f0 [ice]
> [ 5511.324977]  ? ktime_get+0x38/0xa0
> [ 5511.328913]  ice_napi_poll+0x7a/0x6a0 [ice]
> [ 5511.333784]  __napi_poll+0x2c/0x160
> [ 5511.337821]  net_rx_action+0xdd/0x200
> [ 5511.342058]  __do_softirq+0xe6/0x2dd
> [ 5511.346198]  irq_exit_rcu+0xb5/0x100
> [ 5511.350339]  common_interrupt+0xa4/0xc0
> [ 5511.354777]  </IRQ>
> [ 5511.357201]  <TASK>
> [ 5511.359625]  asm_common_interrupt+0x1e/0x40
> [ 5511.364466] RIP: 0010:cpuidle_enter_state+0xd2/0x360
> [ 5511.370211] Code: 49 89 c5 0f 1f 44 00 00 31 ff e8 e9 00 7b ff 45 84 ff 74 12 9c 58 f6 c4 02 0f 85 72 02 00 00 31 ff e8 02 0c 80 ff fb 45 85 f6 <0f> 88 11 01 00 00 49 63 c6 4c 2b 2c 24 48 8d 14 40 48 8d 14 90 49
> [ 5511.391921] RSP: 0018:ffffffff82a03e60 EFLAGS: 00000202
> [ 5511.397962] RAX: ffff88903f800000 RBX: 0000000000000001 RCX: 000000000000001f
> [ 5511.406214] RDX: 0000000000000000 RSI: ffffffff823400b9 RDI: ffffffff8234c046
> [ 5511.424646] RBP: ffff88810a384800 R08: 000005032a28c046 R09: 0000000000000008
> [ 5511.443233] R10: 000000000000000b R11: 0000000000000006 R12: ffffffff82bcf700
> [ 5511.461922] R13: 000005032a28c046 R14: 0000000000000001 R15: 0000000000000000
> [ 5511.480300]  cpuidle_enter+0x29/0x40
> [ 5511.494329]  do_idle+0x1c7/0x250
> [ 5511.507610]  cpu_startup_entry+0x19/0x20
> [ 5511.521394]  start_kernel+0x649/0x66e
> [ 5511.534626]  secondary_startup_64_no_verify+0xc3/0xcb
> [ 5511.549230]  </TASK>
>
> Detect such case during bind() and allocate this memory region via newly
> introduced xp_alloc_tx_descs(). Also, use kvcalloc instead of kcalloc as
> for other buffer pool allocations, so that it matches the kvfree() from
> xp_destroy().

Thank you for this fix Maciej.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Fixes: d1bc532e99be ("i40e: xsk: Move tmp desc array from driver to pool")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  include/net/xsk_buff_pool.h |  1 +
>  net/xdp/xsk.c               | 13 +++++++++++++
>  net/xdp/xsk_buff_pool.c     | 16 ++++++++++++----
>  3 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index 5554ee75e7da..647722e847b4 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -97,6 +97,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool, struct net_device *dev,
>                   u16 queue_id, u16 flags);
>  int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_umem *umem,
>                          struct net_device *dev, u16 queue_id);
> +int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs);
>  void xp_destroy(struct xsk_buff_pool *pool);
>  void xp_get_pool(struct xsk_buff_pool *pool);
>  bool xp_put_pool(struct xsk_buff_pool *pool);
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 040c73345b7c..57afb96c41e8 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -967,6 +967,19 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
>
>                         xp_get_pool(umem_xs->pool);
>                         xs->pool = umem_xs->pool;
> +
> +                       /* If underlying shared umem was created without Tx
> +                        * ring, allocate Tx descs array that Tx batching API
> +                        * utilizes
> +                        */
> +                       if (xs->tx && !xs->pool->tx_descs) {
> +                               err = xp_alloc_tx_descs(xs->pool, xs);
> +                               if (err) {
> +                                       xp_put_pool(xs->pool);
> +                                       sockfd_put(sock);
> +                                       goto out_unlock;
> +                               }
> +                       }
>                 }
>
>                 xdp_get_umem(umem_xs->umem);
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index af040ffa14ff..87bdd71c7bb6 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -42,6 +42,16 @@ void xp_destroy(struct xsk_buff_pool *pool)
>         kvfree(pool);
>  }
>
> +int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs)
> +{
> +       pool->tx_descs = kvcalloc(xs->tx->nentries, sizeof(*pool->tx_descs),
> +                                 GFP_KERNEL);
> +       if (!pool->tx_descs)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
>  struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
>                                                 struct xdp_umem *umem)
>  {
> @@ -59,11 +69,9 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
>         if (!pool->heads)
>                 goto out;
>
> -       if (xs->tx) {
> -               pool->tx_descs = kcalloc(xs->tx->nentries, sizeof(*pool->tx_descs), GFP_KERNEL);
> -               if (!pool->tx_descs)
> +       if (xs->tx)
> +               if (xp_alloc_tx_descs(pool, xs))
>                         goto out;
> -       }
>
>         pool->chunk_mask = ~((u64)umem->chunk_size - 1);
>         pool->addrs_cnt = umem->size;
> --
> 2.27.0
>
