Return-Path: <bpf+bounces-3190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3E673A95E
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 22:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6028281AB5
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 20:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C60D2109B;
	Thu, 22 Jun 2023 20:13:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4918421080
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 20:13:45 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46231FCB
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 13:13:43 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-544c0d768b9so6006894a12.0
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687464823; x=1690056823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4s7Xb1mFKjZORtZXFmNM1Jj59hKU38cNm71OLPfccM=;
        b=CY0b2DGUimY4gE2KMnjbMx/01/6J/ljAQ0DyVTXFaG+QFQhtG6NkGdrXbdqL7d8zkQ
         Ddf6577+arcSIwnLZNxaxWsBwaQbR5TUf1hSKg4GGvqkgBXXJKuv0sMMdX03Ldcw/RYW
         34HOqKzuclT/6CR/HsRo0MvHcHNubWA27OV2rkPvovUmIFi1lTSpTwaDncLSL3Bbb/IY
         MIfOwya73/N2XbaT7HuD6ai3zv017V9EzEb/c5gJBeax1Ni6zAnmMQwtl90NZmHIn9TR
         o+kgKIG2wRilCy7w07x32t3D2CdoIHBrrIZ9an6PnN7fzWOQfXD1oOSKzI8WRqMtB8Qg
         1wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687464823; x=1690056823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4s7Xb1mFKjZORtZXFmNM1Jj59hKU38cNm71OLPfccM=;
        b=MOK7r8VUJZEkiiV6Fdc8otwgU5PhCCaIVGSEclznrN29x1+6cTtLh95e/BzCdG6TLK
         jF20+A5xwFjBfMKwFjGee1m2Wsa0sJBPFbl22UrXpLbO4S+u/9sOQAZrGlmy0PHJ0adY
         Z4BYMZMoZUj9Goikg87euE0dIlQysxDMe0aasYeGLEGgvuGFS6RiQo+7+iojDIUVZhk2
         1rHAeahg8vm0R2jW6ZAU8vhCnPlDMS3ha30vvTjanrLxq5ZFQEAQQWQiYh7AjJUWnbp7
         h5Yw8BYkly8H2BNu4dE9h2xukZ7qHVumfO3LH8KCf9FuZay7bFvcfpXkFLLxkOe3gI3l
         h8Fg==
X-Gm-Message-State: AC+VfDzysAGNGdvzU9v6NtCxJbA5WGWO7Y+wSmk+jhUbb7s1fvwcwzS0
	SU3V2yNxPmjnP7Zkr/crLT85ANBvIP2u8ob/jXwccg==
X-Google-Smtp-Source: ACHHUZ7hd2SuUXpCuYfbdCmfpqSroTeZ6cF/XbD2idLp3R8X0T5yTZLAIstTU+aC8zfiyU27ahYbya7gBcVxQoF7msc=
X-Received: by 2002:a05:6a20:5495:b0:122:5ed2:b521 with SMTP id
 i21-20020a056a20549500b001225ed2b521mr11020337pzk.59.1687464823122; Thu, 22
 Jun 2023 13:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <20230621170244.1283336-12-sdf@google.com>
 <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
In-Reply-To: <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 22 Jun 2023 13:13:31 -0700
Message-ID: <CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 12:58=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 21, 2023 at 10:02:44AM -0700, Stanislav Fomichev wrote:
> > WIP, not tested, only to show the overall idea.
> > Non-AF_XDP paths are marked with 'false' for now.
> >
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  .../net/ethernet/mellanox/mlx5/core/en/txrx.h | 11 +++
> >  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 96 ++++++++++++++++++-
> >  .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  9 +-
> >  .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  3 +
> >  .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 16 ++++
> >  .../net/ethernet/mellanox/mlx5/core/main.c    | 26 ++++-
> >  6 files changed, 156 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/driver=
s/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > index 879d698b6119..e4509464e0b1 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > @@ -6,6 +6,7 @@
> >
> >  #include "en.h"
> >  #include <linux/indirect_call_wrapper.h>
> > +#include <net/devtx.h>
> >
> >  #define MLX5E_TX_WQE_EMPTY_DS_COUNT (sizeof(struct mlx5e_tx_wqe) / MLX=
5_SEND_WQE_DS)
> >
> > @@ -506,4 +507,14 @@ static inline struct mlx5e_mpw_info *mlx5e_get_mpw=
_info(struct mlx5e_rq *rq, int
> >
> >       return (struct mlx5e_mpw_info *)((char *)rq->mpwqe.info + array_s=
ize(i, isz));
> >  }
> > +
> > +struct mlx5e_devtx_frame {
> > +     struct devtx_frame frame;
> > +     struct mlx5_cqe64 *cqe; /* tx completion */
>
> cqe is only valid at completion.
>
> > +     struct mlx5e_tx_wqe *wqe; /* tx */
>
> wqe is only valid at submission.
>
> imo that's a very clear sign that this is not a generic datastructure.
> The code is trying hard to make 'frame' part of it look common,
> but it won't help bpf prog to be 'generic'.
> It is still going to precisely coded for completion vs submission.
> Similarly a bpf prog for completion in veth will be different than bpf pr=
og for completion in mlx5.
> As I stated earlier this 'generalization' and 'common' datastructure only=
 adds code complexity.

The reason I went with this abstract context is to allow the programs
to be attached to the different devices.
For example, the xdp_hw_metadata we currently have is not really tied
down to the particular implementation.
If every hook declaration looks different, it seems impossible to
create portable programs.

The frame part is not really needed, we can probably rename it to ctx
and pass data/frags over the arguments?

struct devtx_ctx {
  struct net_device *netdev;
  /* the devices will be able to create wrappers to stash descriptor pointe=
rs */
};
void veth_devtx_submit(struct devtx_ctx *ctx, void *data, u16 len, u8
meta_len, struct skb_shared_info *sinfo);

But striving to have a similar hook declaration seems useful to
program portability sake?

