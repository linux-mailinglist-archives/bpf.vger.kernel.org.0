Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A846C394F
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 19:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCUSl5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 14:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCUSl5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 14:41:57 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA277132FF
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 11:41:55 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id ja10so17005948plb.5
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 11:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679424115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhY7Zex6hyzqegpd5VgFoVLv7FRdLDof3Jtch1qYh1M=;
        b=XMv6/qI7Scp6XV+eP33j1iv4T3/xyHBVKBbW7vMa1s4FWH07uwC1m/FNhBqxtIImBI
         YKgbmv8diP80jUJQlwWc/ZcEmCsfuzaZVxJcn3lZRS4Ex0rk6ye8tOiqs4xZgRijKlNy
         4rEjJXq5voTLyz3cc3seU+EM7ljP1Kz1VI+BOiGrlh6YTA71uc1ISQvtQqUTDVWoQUju
         k+1ztfr4hixFuNZgk2wJRmspLUF8P/L8s6uXZnV87UpUkJScjB7fXSWDtQ5YHsgsSF0K
         8PRZyf/HjVtVt4tCouMwaAbx14cOccpItd+ed9rOU1rQowJYtUNLREtNPEDGLcVRRliu
         GALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679424115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhY7Zex6hyzqegpd5VgFoVLv7FRdLDof3Jtch1qYh1M=;
        b=kAOBlEOXqoJD3NSk8T0ZXVNhtR/0TLKynNt6/zv9HIof0tzfC8PKgt4ukvljdpALCd
         3yqIw8Mjf/9aHe/hzYboHlgtimhoYyx/lpevGa3Zv0Gw+Tsh9I1ak5teWqeq2FIrWFQd
         G7mvp9sxv+p7HMHbc7UWEk+x0hVeVKJRaaE1dYab4xQC4KnT1SG08gkO/zCmSfEWHgjU
         sETICLcNQx40wkaeZDOnBIxhVffHxKZLsdRvrmOm3XvlCI7K4jDh37PFqS5DzsECnous
         NPFa2ZYwm7emkgBvGLUaTzHNzlFQD1+lRWSYpEO01Rju4eK0eos0sJfRUM+tNoi0fkVw
         mK8Q==
X-Gm-Message-State: AO0yUKWOz7iTk7bRYclZmfixxx/PL18XtNBLOjAoKAfY08OHGCrxlEr+
        rKsbW3WjnPD8WtS0C+xuZYKxjX3skScg1AYUc5lN3w==
X-Google-Smtp-Source: AK7set+5gjgppMNfTX5jYGAV+yB0SMlKUPDs49QdhUJDPR6i2bZA3Bm6KvlYJPkPM5kKYGCgo8lQUvsm4Ob9yPnemw0=
X-Received: by 2002:a17:902:e543:b0:19c:d14b:ee20 with SMTP id
 n3-20020a170902e54300b0019cd14bee20mr44564plf.8.1679424114956; Tue, 21 Mar
 2023 11:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <167940675120.2718408.8176058626864184420.stgit@firesoul>
In-Reply-To: <167940675120.2718408.8176058626864184420.stgit@firesoul>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 21 Mar 2023 11:41:43 -0700
Message-ID: <CAKH8qBsKEp=v-PR6AOR266MaNf+pm0wYJ-GPtKEm2xbHXgCtnA@mail.gmail.com>
Subject: Re: [PATCH bpf V2] xdp: bpf_xdp_metadata use EOPNOTSUPP for no driver support
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, alexandr.lobakin@intel.com,
        larysa.zaremba@intel.com, xdp-hints@xdp-project.net,
        anthony.l.nguyen@intel.com, yoong.siang.song@intel.com,
        boon.leong.ong@intel.com, intel-wired-lan@lists.osuosl.org,
        pabeni@redhat.com, jesse.brandeburg@intel.com, kuba@kernel.org,
        edumazet@google.com, john.fastabend@gmail.com, hawk@kernel.org,
        davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 21, 2023 at 6:52=E2=80=AFAM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> When driver doesn't implement a bpf_xdp_metadata kfunc the fallback
> implementation returns EOPNOTSUPP, which indicate device driver doesn't
> implement this kfunc.
>
> Currently many drivers also return EOPNOTSUPP when the hint isn't
> available, which is ambiguous from an API point of view. Instead
> change drivers to return ENODATA in these cases.
>
> There can be natural cases why a driver doesn't provide any hardware
> info for a specific hint, even on a frame to frame basis (e.g. PTP).
> Lets keep these cases as separate return codes.
>
> When describing the return values, adjust the function kernel-doc layout
> to get proper rendering for the return values.
>
> Fixes: ab46182d0dcb ("net/mlx4_en: Support RX XDP metadata")
> Fixes: bc8d405b1ba9 ("net/mlx5e: Support RX XDP metadata")
> Fixes: 306531f0249f ("veth: Support RX XDP metadata")
> Fixes: 3d76a4d3d4e5 ("bpf: XDP metadata RX kfuncs")
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  Documentation/networking/xdp-rx-metadata.rst     |    7 +++++--
>  drivers/net/ethernet/mellanox/mlx4/en_rx.c       |    4 ++--
>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |    4 ++--
>  drivers/net/veth.c                               |    4 ++--
>  net/core/xdp.c                                   |   10 ++++++++--
>  5 files changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation=
/networking/xdp-rx-metadata.rst
> index aac63fc2d08b..25ce72af81c2 100644
> --- a/Documentation/networking/xdp-rx-metadata.rst
> +++ b/Documentation/networking/xdp-rx-metadata.rst
> @@ -23,10 +23,13 @@ metadata is supported, this set will grow:
>  An XDP program can use these kfuncs to read the metadata into stack
>  variables for its own consumption. Or, to pass the metadata on to other
>  consumers, an XDP program can store it into the metadata area carried
> -ahead of the packet.
> +ahead of the packet. Not all packets will necessary have the requested
> +metadata available in which case the driver returns ``-ENODATA``.
>
>  Not all kfuncs have to be implemented by the device driver; when not
> -implemented, the default ones that return ``-EOPNOTSUPP`` will be used.
> +implemented, the default ones that return ``-EOPNOTSUPP`` will be used
> +to indicate the device driver have not implemented this kfunc.
> +
>
>  Within an XDP frame, the metadata layout (accessed via ``xdp_buff``) is
>  as follows::
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/eth=
ernet/mellanox/mlx4/en_rx.c
> index 0869d4fff17b..4b5e459b6d49 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> @@ -674,7 +674,7 @@ int mlx4_en_xdp_rx_timestamp(const struct xdp_md *ctx=
, u64 *timestamp)
>         struct mlx4_en_xdp_buff *_ctx =3D (void *)ctx;
>
>         if (unlikely(_ctx->ring->hwtstamp_rx_filter !=3D HWTSTAMP_FILTER_=
ALL))
> -               return -EOPNOTSUPP;
> +               return -ENODATA;
>
>         *timestamp =3D mlx4_en_get_hwtstamp(_ctx->mdev,
>                                           mlx4_en_get_cqe_ts(_ctx->cqe));
> @@ -686,7 +686,7 @@ int mlx4_en_xdp_rx_hash(const struct xdp_md *ctx, u32=
 *hash)
>         struct mlx4_en_xdp_buff *_ctx =3D (void *)ctx;
>
>         if (unlikely(!(_ctx->dev->features & NETIF_F_RXHASH)))
> -               return -EOPNOTSUPP;
> +               return -ENODATA;
>
>         *hash =3D be32_to_cpu(_ctx->cqe->immed_rss_invalid);
>         return 0;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/en/xdp.c
> index bcd6370de440..c5dae48b7932 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -162,7 +162,7 @@ static int mlx5e_xdp_rx_timestamp(const struct xdp_md=
 *ctx, u64 *timestamp)
>         const struct mlx5e_xdp_buff *_ctx =3D (void *)ctx;
>
>         if (unlikely(!mlx5e_rx_hw_stamp(_ctx->rq->tstamp)))
> -               return -EOPNOTSUPP;
> +               return -ENODATA;
>
>         *timestamp =3D  mlx5e_cqe_ts_to_ns(_ctx->rq->ptp_cyc2time,
>                                          _ctx->rq->clock, get_cqe_ts(_ctx=
->cqe));
> @@ -174,7 +174,7 @@ static int mlx5e_xdp_rx_hash(const struct xdp_md *ctx=
, u32 *hash)
>         const struct mlx5e_xdp_buff *_ctx =3D (void *)ctx;
>
>         if (unlikely(!(_ctx->xdp.rxq->dev->features & NETIF_F_RXHASH)))
> -               return -EOPNOTSUPP;
> +               return -ENODATA;
>
>         *hash =3D be32_to_cpu(_ctx->cqe->rss_hash_result);
>         return 0;
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 1bb54de7124d..046461ee42ea 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1610,7 +1610,7 @@ static int veth_xdp_rx_timestamp(const struct xdp_m=
d *ctx, u64 *timestamp)
>         struct veth_xdp_buff *_ctx =3D (void *)ctx;
>
>         if (!_ctx->skb)
> -               return -EOPNOTSUPP;
> +               return -ENODATA;
>
>         *timestamp =3D skb_hwtstamps(_ctx->skb)->hwtstamp;
>         return 0;
> @@ -1621,7 +1621,7 @@ static int veth_xdp_rx_hash(const struct xdp_md *ct=
x, u32 *hash)
>         struct veth_xdp_buff *_ctx =3D (void *)ctx;
>
>         if (!_ctx->skb)
> -               return -EOPNOTSUPP;
> +               return -ENODATA;
>
>         *hash =3D skb_get_hash(_ctx->skb);
>         return 0;
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 8d3ad315f18d..7133017bcd74 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -705,7 +705,10 @@ __diag_ignore_all("-Wmissing-prototypes",
>   * @ctx: XDP context pointer.
>   * @timestamp: Return value pointer.
>   *
> - * Returns 0 on success or ``-errno`` on error.
> + * Return:
> + * * Returns 0 on success or ``-errno`` on error.
> + * * ``-EOPNOTSUPP`` : means device driver does not implement kfunc
> + * * ``-ENODATA``    : means no RX-timestamp available for this frame
>   */
>  __bpf_kfunc int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx, =
u64 *timestamp)
>  {
> @@ -717,7 +720,10 @@ __bpf_kfunc int bpf_xdp_metadata_rx_timestamp(const =
struct xdp_md *ctx, u64 *tim
>   * @ctx: XDP context pointer.
>   * @hash: Return value pointer.
>   *
> - * Returns 0 on success or ``-errno`` on error.
> + * Return:
> + * * Returns 0 on success or ``-errno`` on error.
> + * * ``-EOPNOTSUPP`` : means device driver doesn't implement kfunc
> + * * ``-ENODATA``    : means no RX-hash available for this frame
>   */
>  __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *=
hash)
>  {
>
>
