Return-Path: <bpf+bounces-3204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A984F73AC64
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 00:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BA11C20B37
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 22:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCED222579;
	Thu, 22 Jun 2023 22:13:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903E920690
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 22:13:19 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35892116
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 15:13:17 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-39eab4bbe8aso5162042b6e.1
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 15:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687471997; x=1690063997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yjfet1c76BcQ5Q4APZ9MestCxufHqmp9KfsmJbI8P/k=;
        b=apZm26oiTGp+Uc1/K6gPWpMyPV1z21weNweGveS0P7VmmCo2i7lXPcCzQIdEBvi/Si
         8zI+KxBtFtErE7zkom/sZNC6QM4gK2KK7FvC4ueg7xDR+oK7YeBoKgkqHCB9Sp50HS+W
         vNg3GCBESr4WI2q+geDbPHwnOj0no+YHAiJI1EnOVZIDJ20Ys3yRmuPkelncoMIZiXi7
         WKfU9IuolvEojaOOnUak3SdOBuP3nVMwCmwsc7ndREpCa9rnHCdp6uVoyWM5112cQE+n
         esf1CQlWZY2nmk8+FLFW1m0qWnMdBM4qP24e/0PTNvw0jTOyeMcbKNXeV5tJLRTJtT49
         okLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687471997; x=1690063997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yjfet1c76BcQ5Q4APZ9MestCxufHqmp9KfsmJbI8P/k=;
        b=eb39daCY0hcKvLWe71OgodPRoJCb1dRZaoBmP/L4RXUKUhDckKjpdK31UORvAAvBnC
         3ZPfXJWOYfR6BJ+MbwWfUuxiluS+tsAbOvshgnolryJKJ3E0M0hwuR8ZPK4GKA/ISL/B
         JxQmV7RHxVvzp421Pqck7WWaJPxJuKD+6XBPvVZLZy+LUdqPQY13BTCa5VOLQzoTaC3P
         IcjULqbf+4ehNoZDnGeHYbgURUacCtMDd+3NbrMR01x9Arz/geWeq7U7LbKMpo6IizwG
         E45k+ddzGS5Bj0ssxnBorfmqWcBkiU0fgwH3sRi4q9ejAUl8QYuJMOvM41LzR+9ygR8D
         KucQ==
X-Gm-Message-State: AC+VfDyfeoWLyq7QMvjS63aIHAov8lKZIusJQbpICgWMnBKHXKTHg1gM
	J5eR7AwXkOjbJ+fanGG3RkXMqZLIB3hZjmm+DL/nMw==
X-Google-Smtp-Source: ACHHUZ5zUl/hOnjU20mL3ptukJG4Irq0Xf4zIX5/nbjQKq464j9kJBxiLroDFX59NUKRcqU1zjNqJmyfm7e8QbCV2Ag=
X-Received: by 2002:a05:6808:6397:b0:39c:767e:bfc6 with SMTP id
 ec23-20020a056808639700b0039c767ebfc6mr17903401oib.10.1687471997129; Thu, 22
 Jun 2023 15:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <20230621170244.1283336-12-sdf@google.com>
 <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
 <CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com> <CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com>
In-Reply-To: <CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 22 Jun 2023 15:13:05 -0700
Message-ID: <CAKH8qBuJpybiTFz9vx+M+5DoGuK-pPq6HapMKq7rZGsngsuwkw@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 2:47=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jun 22, 2023 at 1:13=E2=80=AFPM Stanislav Fomichev <sdf@google.co=
m> wrote:
> >
> > On Thu, Jun 22, 2023 at 12:58=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Jun 21, 2023 at 10:02:44AM -0700, Stanislav Fomichev wrote:
> > > > WIP, not tested, only to show the overall idea.
> > > > Non-AF_XDP paths are marked with 'false' for now.
> > > >
> > > > Cc: netdev@vger.kernel.org
> > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > ---
> > > >  .../net/ethernet/mellanox/mlx5/core/en/txrx.h | 11 +++
> > > >  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 96 +++++++++++++++=
+++-
> > > >  .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  9 +-
> > > >  .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  3 +
> > > >  .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 16 ++++
> > > >  .../net/ethernet/mellanox/mlx5/core/main.c    | 26 ++++-
> > > >  6 files changed, 156 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/dr=
ivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > > > index 879d698b6119..e4509464e0b1 100644
> > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > > > @@ -6,6 +6,7 @@
> > > >
> > > >  #include "en.h"
> > > >  #include <linux/indirect_call_wrapper.h>
> > > > +#include <net/devtx.h>
> > > >
> > > >  #define MLX5E_TX_WQE_EMPTY_DS_COUNT (sizeof(struct mlx5e_tx_wqe) /=
 MLX5_SEND_WQE_DS)
> > > >
> > > > @@ -506,4 +507,14 @@ static inline struct mlx5e_mpw_info *mlx5e_get=
_mpw_info(struct mlx5e_rq *rq, int
> > > >
> > > >       return (struct mlx5e_mpw_info *)((char *)rq->mpwqe.info + arr=
ay_size(i, isz));
> > > >  }
> > > > +
> > > > +struct mlx5e_devtx_frame {
> > > > +     struct devtx_frame frame;
> > > > +     struct mlx5_cqe64 *cqe; /* tx completion */
> > >
> > > cqe is only valid at completion.
> > >
> > > > +     struct mlx5e_tx_wqe *wqe; /* tx */
> > >
> > > wqe is only valid at submission.
> > >
> > > imo that's a very clear sign that this is not a generic datastructure=
.
> > > The code is trying hard to make 'frame' part of it look common,
> > > but it won't help bpf prog to be 'generic'.
> > > It is still going to precisely coded for completion vs submission.
> > > Similarly a bpf prog for completion in veth will be different than bp=
f prog for completion in mlx5.
> > > As I stated earlier this 'generalization' and 'common' datastructure =
only adds code complexity.
> >
> > The reason I went with this abstract context is to allow the programs
> > to be attached to the different devices.
> > For example, the xdp_hw_metadata we currently have is not really tied
> > down to the particular implementation.
> > If every hook declaration looks different, it seems impossible to
> > create portable programs.
> >
> > The frame part is not really needed, we can probably rename it to ctx
> > and pass data/frags over the arguments?
> >
> > struct devtx_ctx {
> >   struct net_device *netdev;
> >   /* the devices will be able to create wrappers to stash descriptor po=
inters */
> > };
> > void veth_devtx_submit(struct devtx_ctx *ctx, void *data, u16 len, u8
> > meta_len, struct skb_shared_info *sinfo);
> >
> > But striving to have a similar hook declaration seems useful to
> > program portability sake?
>
> portability across what ?
> 'timestamp' on veth doesn't have a real use. It's testing only.
> Even testing is a bit dubious.
> I can see a need for bpf prog to run in the datacenter on mlx, brcm
> and whatever other nics, but they will have completely different
> hw descriptors. timestamp kfuncs to request/read can be common,
> but to read the descriptors bpf prog authors would need to write
> different code anyway.
> So kernel code going out its way to present somewhat common devtx_ctx
> just doesn't help. It adds code to the kernel, but bpf prog still
> has to be tailored for mlx and brcm differently.

Isn't it the same discussion/arguments we had during the RX series?
We want to provide common sane interfaces/abstractions via kfuncs.
That will make most BPF programs portable from mlx to brcm (for
example) without doing a rewrite.
We're also exposing raw (readonly) descriptors (via that get_ctx
helper) to the users who know what to do with them.
Most users don't know what to do with raw descriptors; the specs are
not public; things can change depending on fw version/etc/etc.
So the progs that touch raw descriptors are not the primary use-case.
(that was the tl;dr for rx part, seems like it applies here?)

Let's maybe discuss that mlx5 example? Are you proposing to do
something along these lines?

void mlx5e_devtx_submit(struct mlx5e_tx_wqe *wqe);
void mlx5e_devtx_complete(struct mlx5_cqe64 *cqe);

If yes, I'm missing how we define the common kfuncs in this case. The
kfuncs need to have some common context. We're defining them with:
bpf_devtx_<kfunc>(const struct devtx_frame *ctx);

