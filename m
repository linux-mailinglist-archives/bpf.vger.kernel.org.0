Return-Path: <bpf+bounces-3226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4D973AEAD
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 04:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071EB1C20DAA
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 02:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED50B642;
	Fri, 23 Jun 2023 02:36:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B179719B;
	Fri, 23 Jun 2023 02:36:07 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B8D10DB;
	Thu, 22 Jun 2023 19:36:05 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b479d53d48so3040891fa.1;
        Thu, 22 Jun 2023 19:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687487763; x=1690079763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdG92V2GOXoNehwU7QTs+LQEcxpx1gs9A5JAVl9Xq44=;
        b=hGpcJ0Hej9SOBUie73m0+YCe0/UZDzQD5BJuOrliKnwL3M5LPalJG6y1ZT148Y4CaW
         JYQjkXd5TVsCKZb8h4vxgxEM0hCsz4mU6hmZq3kX0tYdodYjLEroFK9+YiI713CkEZzf
         HNC/YxwijMKjQfweeL7gSYNgsBW0NFKtDOUCqj4udBcznvC1QhTrQse/GGVolfPliuH1
         w0zHm02N6UkCOdkR+SlsBF3Avvw5Any51sU6p9hzJEhxlcF0sYB8f86QNjJu4DE1HMwM
         MAHbPdd4C2fPfB/B3NZ5TQFlDluD4e4pZkfRhGIKwBrZPARmTCsmSl7Xny7NlWDgbUCd
         /4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687487763; x=1690079763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdG92V2GOXoNehwU7QTs+LQEcxpx1gs9A5JAVl9Xq44=;
        b=hpPgVMpK0WN8mqeJ5SgsM1usrsdDVEopzMZX1/LLY5Pf+8IJuhJoM0IRNKe4brxKIv
         PX2MxCIAZjfzW1h51jJHe3wO8mV0HD7FWgmO9XZk8WMWTXzwyBoWKyHiPe6QHZPdYFd3
         ztEOFHhDZ3EsSKHjVjeMVok4QPe2jNYyczUDhQzRNYTVls7AopdLb2zKchUbuqiZKUPv
         HR/l/7e7ISqXNlwwMMoIOwAjMgXDUVqi1xPW1vNPkV4A1RiM7on8XtwrK8+S6bjzLFJE
         3zXx+Vl23zaIAKvHJTs317hoxKOnQMWpeVrGO1G9Zk6+y9+1o6rFwhmG1ydUrR9puh/m
         ESOA==
X-Gm-Message-State: AC+VfDwAvZW39xSfCuk0Rty9KwAZfSn4A6TJOAIFo5hAHL4pKQp2Xuyn
	ZN5owjZD0T/36w7O5dsQrUNFQZinPLXFzsMucM4=
X-Google-Smtp-Source: ACHHUZ6+6xAxtVyu21JZYJgPpOvI1EDCkXyDE+cEWEF0EtJ7zKlPmowS8y+26NSderQbg3k73tbBF1H8lnqDrbujEw4=
X-Received: by 2002:a05:651c:217:b0:2b4:6cd4:be6e with SMTP id
 y23-20020a05651c021700b002b46cd4be6emr9951903ljn.13.1687487763256; Thu, 22
 Jun 2023 19:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <20230621170244.1283336-12-sdf@google.com>
 <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
 <CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
 <CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com> <CAKH8qBuJpybiTFz9vx+M+5DoGuK-pPq6HapMKq7rZGsngsuwkw@mail.gmail.com>
In-Reply-To: <CAKH8qBuJpybiTFz9vx+M+5DoGuK-pPq6HapMKq7rZGsngsuwkw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Jun 2023 19:35:51 -0700
Message-ID: <CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 3:13=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On Thu, Jun 22, 2023 at 2:47=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jun 22, 2023 at 1:13=E2=80=AFPM Stanislav Fomichev <sdf@google.=
com> wrote:
> > >
> > > On Thu, Jun 22, 2023 at 12:58=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Wed, Jun 21, 2023 at 10:02:44AM -0700, Stanislav Fomichev wrote:
> > > > > WIP, not tested, only to show the overall idea.
> > > > > Non-AF_XDP paths are marked with 'false' for now.
> > > > >
> > > > > Cc: netdev@vger.kernel.org
> > > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > > ---
> > > > >  .../net/ethernet/mellanox/mlx5/core/en/txrx.h | 11 +++
> > > > >  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 96 +++++++++++++=
+++++-
> > > > >  .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  9 +-
> > > > >  .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  3 +
> > > > >  .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 16 ++++
> > > > >  .../net/ethernet/mellanox/mlx5/core/main.c    | 26 ++++-
> > > > >  6 files changed, 156 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/=
drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > > > > index 879d698b6119..e4509464e0b1 100644
> > > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > > > > @@ -6,6 +6,7 @@
> > > > >
> > > > >  #include "en.h"
> > > > >  #include <linux/indirect_call_wrapper.h>
> > > > > +#include <net/devtx.h>
> > > > >
> > > > >  #define MLX5E_TX_WQE_EMPTY_DS_COUNT (sizeof(struct mlx5e_tx_wqe)=
 / MLX5_SEND_WQE_DS)
> > > > >
> > > > > @@ -506,4 +507,14 @@ static inline struct mlx5e_mpw_info *mlx5e_g=
et_mpw_info(struct mlx5e_rq *rq, int
> > > > >
> > > > >       return (struct mlx5e_mpw_info *)((char *)rq->mpwqe.info + a=
rray_size(i, isz));
> > > > >  }
> > > > > +
> > > > > +struct mlx5e_devtx_frame {
> > > > > +     struct devtx_frame frame;
> > > > > +     struct mlx5_cqe64 *cqe; /* tx completion */
> > > >
> > > > cqe is only valid at completion.
> > > >
> > > > > +     struct mlx5e_tx_wqe *wqe; /* tx */
> > > >
> > > > wqe is only valid at submission.
> > > >
> > > > imo that's a very clear sign that this is not a generic datastructu=
re.
> > > > The code is trying hard to make 'frame' part of it look common,
> > > > but it won't help bpf prog to be 'generic'.
> > > > It is still going to precisely coded for completion vs submission.
> > > > Similarly a bpf prog for completion in veth will be different than =
bpf prog for completion in mlx5.
> > > > As I stated earlier this 'generalization' and 'common' datastructur=
e only adds code complexity.
> > >
> > > The reason I went with this abstract context is to allow the programs
> > > to be attached to the different devices.
> > > For example, the xdp_hw_metadata we currently have is not really tied
> > > down to the particular implementation.
> > > If every hook declaration looks different, it seems impossible to
> > > create portable programs.
> > >
> > > The frame part is not really needed, we can probably rename it to ctx
> > > and pass data/frags over the arguments?
> > >
> > > struct devtx_ctx {
> > >   struct net_device *netdev;
> > >   /* the devices will be able to create wrappers to stash descriptor =
pointers */
> > > };
> > > void veth_devtx_submit(struct devtx_ctx *ctx, void *data, u16 len, u8
> > > meta_len, struct skb_shared_info *sinfo);
> > >
> > > But striving to have a similar hook declaration seems useful to
> > > program portability sake?
> >
> > portability across what ?
> > 'timestamp' on veth doesn't have a real use. It's testing only.
> > Even testing is a bit dubious.
> > I can see a need for bpf prog to run in the datacenter on mlx, brcm
> > and whatever other nics, but they will have completely different
> > hw descriptors. timestamp kfuncs to request/read can be common,
> > but to read the descriptors bpf prog authors would need to write
> > different code anyway.
> > So kernel code going out its way to present somewhat common devtx_ctx
> > just doesn't help. It adds code to the kernel, but bpf prog still
> > has to be tailored for mlx and brcm differently.
>
> Isn't it the same discussion/arguments we had during the RX series?

Right, but there we already have xdp_md as an abstraction.
Extra kfuncs don't change that.
Here is the whole new 'ctx' being proposed with assumption that
it will be shared between completion and submission and will be
useful in both.

But there is skb at submission time and no skb at completion.
xdp_frame is there, but it's the last record of what was sent on the wire.
Parsing it with bpf is like examining steps in a sand. They are gone.
Parsing at submission makes sense, not at completion
and the driver has a way to associate wqe with cqe.

> We want to provide common sane interfaces/abstractions via kfuncs.
> That will make most BPF programs portable from mlx to brcm (for
> example) without doing a rewrite.
> We're also exposing raw (readonly) descriptors (via that get_ctx
> helper) to the users who know what to do with them.
> Most users don't know what to do with raw descriptors;

Why do you think so?
Who are those users?
I see your proposal and thumbs up from onlookers.
afaict there are zero users for rx side hw hints too.

> the specs are
> not public; things can change depending on fw version/etc/etc.
> So the progs that touch raw descriptors are not the primary use-case.
> (that was the tl;dr for rx part, seems like it applies here?)
>
> Let's maybe discuss that mlx5 example? Are you proposing to do
> something along these lines?
>
> void mlx5e_devtx_submit(struct mlx5e_tx_wqe *wqe);
> void mlx5e_devtx_complete(struct mlx5_cqe64 *cqe);
>
> If yes, I'm missing how we define the common kfuncs in this case. The
> kfuncs need to have some common context. We're defining them with:
> bpf_devtx_<kfunc>(const struct devtx_frame *ctx);

I'm looking at xdp_metadata and wondering who's using it.
I haven't seen a single bug report.
No bugs means no one is using it. There is zero chance that we managed
to implement it bug-free on the first try.
So new tx side things look like a feature creep to me.
rx side is far from proven to be useful for anything.
Yet you want to add new things.

