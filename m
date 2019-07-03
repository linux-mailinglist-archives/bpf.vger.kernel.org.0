Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB72B5EF87
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2019 01:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfGCXLP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Jul 2019 19:11:15 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:40317 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfGCXLO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jul 2019 19:11:14 -0400
Received: by mail-lj1-f177.google.com with SMTP id a21so4209907ljh.7
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2019 16:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5btz9JVxwoWcwKWM1YozdD2BPt/IYdei5CWUR7P6U5M=;
        b=IoKezuS8xoFVOM+xzhEgQYz5twVMxFszYNrlRV47QPE9HF9g+KzRBTXleGLtSSANP8
         5xishx0NVbfzAwSUklO0haPYtNgCb5kfXrUAKKuVLAfr1jYQH+FXmbzF+FPbxE5pVitE
         in7XvRxUcxT0KPv6VnpE702jXBpa2InnaQhRXJ6cXj0NKIZdG2gj8mYK1TgN7bgAqYvg
         fdT4IH3Qf9lvMG0P1VWwYvcB9Tr0hgfInrGVowIZAotmQ5vBSF3BSLK+dE67tpGxB84l
         Xowcc6k7IiVHgEMBLZr1O0ZKRKFtNzW/EBFVxYXK5fFqzXLzDapmfl42dfvEUM7wbFap
         L5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5btz9JVxwoWcwKWM1YozdD2BPt/IYdei5CWUR7P6U5M=;
        b=hopzf8YMNdcq+ZYX/NGxG4gGdUmf+mNHvlbckqQ2uJ7Yw4nArxv7XlPbUvYwsNCUCs
         cl9aRdkZ2vqFwzQBxYsBCwyn8qhyeKlOG+LjEZlbMSx5KfuX0bdjXEdmr4ANoBST5n9x
         9HAOEjGaKe6oNdelJYkTzsPsnU/qzlGtocVofuPv6V0qCoeb8Zv7RtVPJBJj8MbqGfj9
         BJVaSWMQii2I3H7BpdyQVFXgRHHnOR+vo3BS2V+iBZgei3dMA2h/NQxLTI/ZjgDqlwxY
         KDRLFbTXcGLyz3aF2jZk9FIl+Z18Hrke0I4HaH2RTZD5uhVPndr1YYZ0w7oXLSAwP+QV
         EhEw==
X-Gm-Message-State: APjAAAVJMOuOj76FTjwndGKmPRRtmimMsXASrIc1qrL1D3m8AGDsdMFR
        mes6pUPRUsN/sxQ4g/oeoxY9XdDHR0er+DCHx2oxCWTK
X-Google-Smtp-Source: APXvYqwf7d5zF8aLkWJFPrtpcbQJslgWQqVPeVkAlF+M0vGa4MZykKDA3gKJCmSd5Cp57stNUl5c3vR/3zltp/Oo/gY=
X-Received: by 2002:a2e:2993:: with SMTP id p19mr21974367ljp.202.1562195472639;
 Wed, 03 Jul 2019 16:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190703224740.15354-1-daniel@iogearbox.net>
In-Reply-To: <20190703224740.15354-1-daniel@iogearbox.net>
From:   Saeed Mahameed <saeedm@dev.mellanox.co.il>
Date:   Wed, 3 Jul 2019 16:11:01 -0700
Message-ID: <CALzJLG9vsv3A=SAGA97_HUZxdCr7gAMET8yTWofD6Wsq_7sCuA@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2019-07-03
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 3, 2019 at 3:47 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Hi David,
>
> The following pull-request contains BPF updates for your *net-next* tree.
>
> There is a minor merge conflict in mlx5 due to 8960b38932be ("linux/dim:
> Rename externally used net_dim members") which has been pulled into your
> tree in the meantime, but resolution seems not that bad ... getting current
> bpf-next out now before there's coming more on mlx5. ;) I'm Cc'ing Saeed
> just so he's aware of the resolution below:
>
> ** First conflict in drivers/net/ethernet/mellanox/mlx5/core/en_main.c:
>
>   <<<<<<< HEAD
>   static int mlx5e_open_cq(struct mlx5e_channel *c,
>                            struct dim_cq_moder moder,
>                            struct mlx5e_cq_param *param,
>                            struct mlx5e_cq *cq)
>   =======
>   int mlx5e_open_cq(struct mlx5e_channel *c, struct net_dim_cq_moder moder,
>                     struct mlx5e_cq_param *param, struct mlx5e_cq *cq)
>   >>>>>>> e5a3e259ef239f443951d401db10db7d426c9497
>
> Resolution is to take the second chunk and rename net_dim_cq_moder into
> dim_cq_moder. Also the signature for mlx5e_open_cq() in ...
>
>   drivers/net/ethernet/mellanox/mlx5/core/en.h +977
>
> ... and in mlx5e_open_xsk() ...
>
>   drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c +64
>
> ... needs the same rename from net_dim_cq_moder into dim_cq_moder.
>
> ** Second conflict in drivers/net/ethernet/mellanox/mlx5/core/en_main.c:
>
>   <<<<<<< HEAD
>           int cpu = cpumask_first(mlx5_comp_irq_get_affinity_mask(priv->mdev, ix));
>           struct dim_cq_moder icocq_moder = {0, 0};
>           struct net_device *netdev = priv->netdev;
>           struct mlx5e_channel *c;
>           unsigned int irq;
>   =======
>           struct net_dim_cq_moder icocq_moder = {0, 0};
>   >>>>>>> e5a3e259ef239f443951d401db10db7d426c9497
>
> Take the second chunk and rename net_dim_cq_moder into dim_cq_moder
> as well.
>

Thank you Daniel, Looks Good,
I didn't test this since i am traveling, will double check tomorrow.
but basically all you need is to pass the build.

Thanks,
Saeed.
