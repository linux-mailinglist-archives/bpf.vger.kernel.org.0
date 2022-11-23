Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F126A636A2E
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 20:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239274AbiKWTyG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 14:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239308AbiKWTxo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 14:53:44 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FECC7202
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 11:52:15 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id g13-20020a056a000b8d00b0056e28b15757so11452428pfj.1
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 11:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Md9ZWXHDLM85YwaZa/3mJElMaCka2JtXSIbE+IlBCds=;
        b=SdZWtsaRUwsnRl7l4iGx3Q8mmajbRUbVsT04AU6mUvnB2mzjIUJAH9DeWSKHkG6XWk
         hD3ytudVB7Lk+nDClU+1crv7MHoU/8Ds1vvdt32/Ftqne2KTcttnFGFLZffwPnJpzs7Z
         nrBqOk08IwQLjdJPzYK6GOSc6gYZdeFP2a0QxB/FJVSGOjabt1ZgyZyoTAbsE9ZK7btW
         aYiGBVvDeVvW8iJ0P2GJjmz8krDfZImkRU1UZvq0YM/Ty8mAxexOqK7c16LYvI7k4dYH
         GMkxa1d4QtmISwHuOfKoa8lzQZJ0WfxSWOZ0wV4I+bQci7JRHvXgZ68WgzqofW+3giyU
         4GYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Md9ZWXHDLM85YwaZa/3mJElMaCka2JtXSIbE+IlBCds=;
        b=d7JB/HzAN/f8IN3fvOKl2f3TPsdosdbW8fNlZAD0vznAaXxC5n7JbpTQvSTYRDz5aa
         bPxnG/y3RWMIoXEWvqYO7Skk1uFoaJGD1XC3nU5gLeZ2p2QulQfy2ZYjMxX3yzsC85Hs
         QmWsOe9uMlnpqpdTMWZwFsedzpLa807+eb78v268lx8St163XdM4r61y3vy/3Wvy3A6u
         EYUzFaFTj6zOYmEwXh9QrDi5AqwvZaONcb7HKyNJ7P/vrXv7bPlyLWN+NtF2OI2XsB7Q
         Kot+onkMmV9UBBw/+F+L5gv4NewT+ced2gwGHr6kkGvFpqiFiRIbyjIMGBsZ9yUTJLkI
         u4rQ==
X-Gm-Message-State: ANoB5pmKbSH3w0XQe4CvAEiH2MZ0hm1ygobuo/WJgdo0LFMeGvET5EOe
        KVQpjyn6Mn3Mq3TiYEesNIEEzCQ=
X-Google-Smtp-Source: AA0mqf6D3mjyGd46PLpkf4SCynyVivIxr+D0ItYoiaFgU5Sy5wjbFedEvH0VS5j1Oz4Z0Lbp6UOw2V8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:2013:b0:188:f7d0:3952 with SMTP id
 s19-20020a170903201300b00188f7d03952mr9949169pla.164.1669233134546; Wed, 23
 Nov 2022 11:52:14 -0800 (PST)
Date:   Wed, 23 Nov 2022 11:52:12 -0800
In-Reply-To: <20221123111431.7b54668e@kernel.org>
Mime-Version: 1.0
References: <20221121182552.2152891-1-sdf@google.com> <20221121182552.2152891-7-sdf@google.com>
 <874jupviyc.fsf@toke.dk> <CAKH8qBuF_1UoUPzh_X6FMrJ61zCNDroqSuc-Pp2uH7Q4azmN8Q@mail.gmail.com>
 <20221123111431.7b54668e@kernel.org>
Message-ID: <Y3557Ecr80Y9ZD2z@google.com>
Subject: Re: [xdp-hints] [PATCH bpf-next v2 6/8] mlx4: Introduce mlx4_xdp_buff
 wrapper for xdp_buff
From:   sdf@google.com
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?=" <toke@redhat.com>,
        bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/23, Jakub Kicinski wrote:
> On Wed, 23 Nov 2022 10:26:41 -0800 Stanislav Fomichev wrote:
> > > This embedding trick works for drivers that put xdp_buff on the stack,
> > > but mlx5 supports XSK zerocopy, which uses the xsk_buff_pool for
> > > allocating them. This makes it a bit awkward to do the same thing  
> there;
> > > and since it's probably going to be fairly common to do something like
> > > this, how about we just add a 'void *drv_priv' pointer to struct
> > > xdp_buff that the drivers can use? The xdp_buff already takes up a  
> full
> > > cache line anyway, so any data stuffed after it will spill over to a  
> new
> > > one; so I don't think there's much difference performance-wise.
> >
> > I guess the alternative is to extend xsk_buff_pool with some new
> > argument for xdp_buff tailroom? (so it can kmalloc(sizeof(xdp_buff) +
> > xdp_buff_tailroom))
> > But it seems messy because there is no way of knowing what the target
> > device's tailroom is, so it has to be a user setting :-/
> > I've started with a priv pointer in xdp_buff initially, it seems fine
> > to go back. I'll probably convert veth/mlx4 to the same mode as well
> > to avoid having different approaches in different places..

> Can we not do this please? Add 16B of "private driver space" after
> the xdp_buff in xdp_buff_xsk (we have 16B to full cacheline), the
> drivers decide how they use it. Drivers can do BUILD_BUG_ON() for their
> expected size and cast that to whatever struct they want. This is how
> various offloads work, the variable size tailroom would be an over
> design IMO.

> And this way non XSK paths can keep its normal typing.

Good idea, prototyped below, lmk if it that's not what you had in mind.

struct xdp_buff_xsk {
	struct xdp_buff            xdp;                  /*     0    56 */
	u8                         cb[16];               /*    56    16 */
	/* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
	dma_addr_t                 dma;                  /*    72     8 */
	dma_addr_t                 frame_dma;            /*    80     8 */
	struct xsk_buff_pool *     pool;                 /*    88     8 */
	u64                        orig_addr;            /*    96     8 */
	struct list_head           free_list_node;       /*   104    16 */

	/* size: 120, cachelines: 2, members: 7 */
	/* last cacheline: 56 bytes */
};

Toke, I can try to merge this into your patch + keep your SoB (or feel free
to try this and retest yourself, whatever works).

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h  
b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
index bc2d9034af5b..837bf103b871 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
@@ -44,6 +44,11 @@
  	(MLX5E_XDP_INLINE_WQE_MAX_DS_CNT * MLX5_SEND_WQE_DS - \
  	 sizeof(struct mlx5_wqe_inline_seg))

+struct mlx5_xdp_cb {
+	struct mlx5_cqe64 *cqe;
+	struct mlx5e_rq *rq;
+};
+
  struct mlx5e_xsk_param;
  int mlx5e_xdp_max_mtu(struct mlx5e_params *params, struct mlx5e_xsk_param  
*xsk);
  bool mlx5e_xdp_handle(struct mlx5e_rq *rq, struct page *page,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c  
b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
index c91b54d9ff27..84d23b2da7ce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
@@ -5,6 +5,7 @@
  #include "en/xdp.h"
  #include <net/xdp_sock_drv.h>
  #include <linux/filter.h>
+#include <linux/build_bug.h>

  /* RX data path */

@@ -286,8 +287,14 @@ struct sk_buff *mlx5e_xsk_skb_from_cqe_linear(struct  
mlx5e_rq *rq,
  					      u32 cqe_bcnt)
  {
  	struct xdp_buff *xdp = wi->au->xsk;
+	struct mlx5_xdp_cb *cb;
  	struct bpf_prog *prog;

+	BUILD_BUG_ON(sizeof(struct mlx5_xdp_cb) > XSKB_CB_SIZE);
+	cb = xp_get_cb(xdp);
+	cb->cqe = NULL /*cqe*/;
+	cb->rq = rq;
+
  	/* wi->offset is not used in this function, because xdp->data and the
  	 * DMA address point directly to the necessary place. Furthermore, the
  	 * XSK allocator allocates frames per packet, instead of pages, so
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index f787c3f524b0..b298590429e7 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -19,8 +19,11 @@ struct xdp_sock;
  struct device;
  struct page;

+#define XSKB_CB_SIZE 16
+
  struct xdp_buff_xsk {
  	struct xdp_buff xdp;
+	u8 cb[XSKB_CB_SIZE]; /* Private area for the drivers to use. */
  	dma_addr_t dma;
  	dma_addr_t frame_dma;
  	struct xsk_buff_pool *pool;
@@ -143,6 +146,11 @@ static inline dma_addr_t xp_get_frame_dma(struct  
xdp_buff_xsk *xskb)
  	return xskb->frame_dma;
  }

+static inline void *xp_get_cb(struct xdp_buff *xdp)
+{
+	return (void *)xdp + offsetof(struct xdp_buff_xsk, cb);
+}
+
  void xp_dma_sync_for_cpu_slow(struct xdp_buff_xsk *xskb);
  static inline void xp_dma_sync_for_cpu(struct xdp_buff_xsk *xskb)
  {

> > > I'll send my patch to add support to mlx5 (using the drv_priv pointer
> > > approach) separately.
> >
> > Saw them, thanks! Will include them in v3+.
