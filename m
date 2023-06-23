Return-Path: <bpf+bounces-3299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BC773BDC3
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 19:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A46A1C212D6
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 17:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741E9100D4;
	Fri, 23 Jun 2023 17:24:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F8100C0
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 17:24:49 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494301739
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:24:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-25e820b8bc1so471104a91.1
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687541087; x=1690133087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4M9Bl7dXhZ6Jxoy+pKZRXzkgBLpWGzM2r3wz56MQkg=;
        b=VZbhMtlhg3Gm/WM/VFxnnTvKD3mAhx3fhs5jV+RoADOtRoUuiUCdUix7BoS9c4C8/w
         ozYRo9spei2krmC0NAQYjwzEwtfBECZV6HlO0kAWkyukcvziQFt4isgrX/QVhADTX/LE
         ut+RKFfdklmlfgR/LYDomIOzmGOwRxJFAg/iNSqLBRFXaJkYugtJRCiMgqqutqMuy/6B
         nHbmMYGXZom/TbveGfmIEY691qsANf4+2Ivuuermz49bp6ffdoihBTs3BQy29hf3G1ai
         +WgRm8uWg80EHzqZLQBkq9tlg1BWiIscO2m6FulaffMMfunX4B3MVJ2+1qoWZw/kmBp/
         trhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687541087; x=1690133087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4M9Bl7dXhZ6Jxoy+pKZRXzkgBLpWGzM2r3wz56MQkg=;
        b=eAYZZBFvMsY+K19jIH/PgKnhq8ZaCsYjXCR317G2FRfp9Xn+MaaENfjsiPeQbU8XlL
         aGqp3u0oWmyzT/UlUiQ3oB/ZfsVR7XV4WNMr8qk7loJa5mW2zSjowN5PWctNYWMl8Hzx
         lvVjOKInmEVyEWGuk5M38iGOPI6aAwQp+nOa2by1UIfNDLlJutQDiVwomg6rFKOVcSop
         3TG5NKIOSznoH9XswWoDQJrEMWh6kNG25TqQIfURURG1JPrCIzHKMocPrA1CSREML/eD
         n0MI93ic8OIqVYDQ9kz+4aF+b+LKHVApH4B8h14r0ly9hXBcgsPkrQWbaIeDrFLmIa03
         zQtw==
X-Gm-Message-State: AC+VfDyByFxcF7VWFwAuSTNtLVrQTtlyxyuv4prCjsNxZmDw0QpvFWmf
	uEnCaJlDhLMgAjzKudxOe8229lelY6Lui1NZDCQQDg==
X-Google-Smtp-Source: ACHHUZ6+JUxu2/ENZUjNLq7Nh+eL1eC6+HdZ0vfMWME7LvCKQPk23oBNeRc6wncBLkcND6nTBK9Cy9aMq7SzdDCpx6Y=
X-Received: by 2002:a17:90a:b895:b0:25e:8169:1b44 with SMTP id
 o21-20020a17090ab89500b0025e81691b44mr14793361pjr.15.1687541086502; Fri, 23
 Jun 2023 10:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <20230621170244.1283336-12-sdf@google.com>
 <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
 <CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
 <CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com>
 <CAKH8qBuJpybiTFz9vx+M+5DoGuK-pPq6HapMKq7rZGsngsuwkw@mail.gmail.com> <CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
In-Reply-To: <CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Fri, 23 Jun 2023 10:24:30 -0700
Message-ID: <CAKH8qBvJjtSb+80cNEJ_3qBR-smcc5mBAH4rTiWhckxVeZWxLA@mail.gmail.com>
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
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 7:36=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jun 22, 2023 at 3:13=E2=80=AFPM Stanislav Fomichev <sdf@google.co=
m> wrote:
> >
> > On Thu, Jun 22, 2023 at 2:47=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Jun 22, 2023 at 1:13=E2=80=AFPM Stanislav Fomichev <sdf@googl=
e.com> wrote:
> > > >
> > > > On Thu, Jun 22, 2023 at 12:58=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Wed, Jun 21, 2023 at 10:02:44AM -0700, Stanislav Fomichev wrot=
e:
> > > > > > WIP, not tested, only to show the overall idea.
> > > > > > Non-AF_XDP paths are marked with 'false' for now.
> > > > > >
> > > > > > Cc: netdev@vger.kernel.org
> > > > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > > > ---
> > > > > >  .../net/ethernet/mellanox/mlx5/core/en/txrx.h | 11 +++
> > > > > >  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 96 +++++++++++=
+++++++-
> > > > > >  .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  9 +-
> > > > > >  .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  3 +
> > > > > >  .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 16 ++++
> > > > > >  .../net/ethernet/mellanox/mlx5/core/main.c    | 26 ++++-
> > > > > >  6 files changed, 156 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h =
b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > > > > > index 879d698b6119..e4509464e0b1 100644
> > > > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > > > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > > > > > @@ -6,6 +6,7 @@
> > > > > >
> > > > > >  #include "en.h"
> > > > > >  #include <linux/indirect_call_wrapper.h>
> > > > > > +#include <net/devtx.h>
> > > > > >
> > > > > >  #define MLX5E_TX_WQE_EMPTY_DS_COUNT (sizeof(struct mlx5e_tx_wq=
e) / MLX5_SEND_WQE_DS)
> > > > > >
> > > > > > @@ -506,4 +507,14 @@ static inline struct mlx5e_mpw_info *mlx5e=
_get_mpw_info(struct mlx5e_rq *rq, int
> > > > > >
> > > > > >       return (struct mlx5e_mpw_info *)((char *)rq->mpwqe.info +=
 array_size(i, isz));
> > > > > >  }
> > > > > > +
> > > > > > +struct mlx5e_devtx_frame {
> > > > > > +     struct devtx_frame frame;
> > > > > > +     struct mlx5_cqe64 *cqe; /* tx completion */
> > > > >
> > > > > cqe is only valid at completion.
> > > > >
> > > > > > +     struct mlx5e_tx_wqe *wqe; /* tx */
> > > > >
> > > > > wqe is only valid at submission.
> > > > >
> > > > > imo that's a very clear sign that this is not a generic datastruc=
ture.
> > > > > The code is trying hard to make 'frame' part of it look common,
> > > > > but it won't help bpf prog to be 'generic'.
> > > > > It is still going to precisely coded for completion vs submission=
.
> > > > > Similarly a bpf prog for completion in veth will be different tha=
n bpf prog for completion in mlx5.
> > > > > As I stated earlier this 'generalization' and 'common' datastruct=
ure only adds code complexity.
> > > >
> > > > The reason I went with this abstract context is to allow the progra=
ms
> > > > to be attached to the different devices.
> > > > For example, the xdp_hw_metadata we currently have is not really ti=
ed
> > > > down to the particular implementation.
> > > > If every hook declaration looks different, it seems impossible to
> > > > create portable programs.
> > > >
> > > > The frame part is not really needed, we can probably rename it to c=
tx
> > > > and pass data/frags over the arguments?
> > > >
> > > > struct devtx_ctx {
> > > >   struct net_device *netdev;
> > > >   /* the devices will be able to create wrappers to stash descripto=
r pointers */
> > > > };
> > > > void veth_devtx_submit(struct devtx_ctx *ctx, void *data, u16 len, =
u8
> > > > meta_len, struct skb_shared_info *sinfo);
> > > >
> > > > But striving to have a similar hook declaration seems useful to
> > > > program portability sake?
> > >
> > > portability across what ?
> > > 'timestamp' on veth doesn't have a real use. It's testing only.
> > > Even testing is a bit dubious.
> > > I can see a need for bpf prog to run in the datacenter on mlx, brcm
> > > and whatever other nics, but they will have completely different
> > > hw descriptors. timestamp kfuncs to request/read can be common,
> > > but to read the descriptors bpf prog authors would need to write
> > > different code anyway.
> > > So kernel code going out its way to present somewhat common devtx_ctx
> > > just doesn't help. It adds code to the kernel, but bpf prog still
> > > has to be tailored for mlx and brcm differently.
> >
> > Isn't it the same discussion/arguments we had during the RX series?
>
> Right, but there we already have xdp_md as an abstraction.
> Extra kfuncs don't change that.
> Here is the whole new 'ctx' being proposed with assumption that
> it will be shared between completion and submission and will be
> useful in both.
>
> But there is skb at submission time and no skb at completion.
> xdp_frame is there, but it's the last record of what was sent on the wire=
.
> Parsing it with bpf is like examining steps in a sand. They are gone.
> Parsing at submission makes sense, not at completion
> and the driver has a way to associate wqe with cqe.

Right, and I'm not exposing neither skb nor xdp_md/frame, so we're on
the same page?
Or are you suggesting to further split devtx_frame into two contexts?
One for submit and another for complete?
And don't expose the payload at the complete time?
Having payload at complete might still be useful though, at least the heade=
r.
In case the users want only to inspect completion based on some marker/flow=
.

> > We want to provide common sane interfaces/abstractions via kfuncs.
> > That will make most BPF programs portable from mlx to brcm (for
> > example) without doing a rewrite.
> > We're also exposing raw (readonly) descriptors (via that get_ctx
> > helper) to the users who know what to do with them.
> > Most users don't know what to do with raw descriptors;
>
> Why do you think so?
> Who are those users?
> I see your proposal and thumbs up from onlookers.
> afaict there are zero users for rx side hw hints too.

My bias comes from the point of view of our internal use-cases where
we'd like to have rx/tx timestamps in the device-agnostic fashion.
I'm happy to incorporate other requirements as I did with exposing raw
descriptors at rx using get_ctx helper.
Regarding the usage: for the external ones I'm assuming it will take
time until it all percolates through the distros...

> > the specs are
> > not public; things can change depending on fw version/etc/etc.
> > So the progs that touch raw descriptors are not the primary use-case.
> > (that was the tl;dr for rx part, seems like it applies here?)
> >
> > Let's maybe discuss that mlx5 example? Are you proposing to do
> > something along these lines?
> >
> > void mlx5e_devtx_submit(struct mlx5e_tx_wqe *wqe);
> > void mlx5e_devtx_complete(struct mlx5_cqe64 *cqe);
> >
> > If yes, I'm missing how we define the common kfuncs in this case. The
> > kfuncs need to have some common context. We're defining them with:
> > bpf_devtx_<kfunc>(const struct devtx_frame *ctx);
>
> I'm looking at xdp_metadata and wondering who's using it.
> I haven't seen a single bug report.
> No bugs means no one is using it. There is zero chance that we managed
> to implement it bug-free on the first try.
> So new tx side things look like a feature creep to me.
> rx side is far from proven to be useful for anything.
> Yet you want to add new things.

I've been talking about both tx and rx timestamps right from the
beginning, so it's not really a new feature.
But what's the concern here? IIUC, the whole point of it being
kfunc-based is that we can wipe it all if/when it becomes a dead
weight.

Regarding the users, there is also a bit of a chicken and egg problem:
We have some internal interest in using AF_XDP, but it lacks multibuf
(which is in the review) and the offloads (which I'm trying to move
forward for both rx/tx).

