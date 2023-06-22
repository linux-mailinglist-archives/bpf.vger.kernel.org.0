Return-Path: <bpf+bounces-3196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5A073ABC9
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 23:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C08028189C
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 21:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48EA2256B;
	Thu, 22 Jun 2023 21:47:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5C920690;
	Thu, 22 Jun 2023 21:47:46 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C687A10DB;
	Thu, 22 Jun 2023 14:47:44 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b47a15ca10so633031fa.1;
        Thu, 22 Jun 2023 14:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687470463; x=1690062463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVl3O8/i2scTIq4zPOBEmQzkZHDz+/CKiC2e22M744Y=;
        b=oi5TBwj1HwESiZwCL3OmGcPEs+SNfrdXV/3sNxYj81u/p6HO8IsrYJGSmKtXBwchQP
         am7lzjf9dckEfws1qVQDDT6tuQ+mdLBFtju3pInvS93rUSH5v6DJFJkUcK34pxIiCycC
         3PrlQ+Dr/RlkLQijPPQCbZK+UgYuByp1ce24KHFQqsKR/6yGlOXFWoyRwPbfbeS0cIgA
         l0XZxbVKytSIBH4+dgehTnA7qc/rizQMI3RvQotZ0KsXbQJC/nZk0Dt73prwa0L8jufG
         W5G6wRAQq6KxGwFL/pxGGdcjazSVWuUtE1kJuN4ZXo88BT3iRgNP0wqAmQP+EzW7QIfC
         9NTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687470463; x=1690062463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVl3O8/i2scTIq4zPOBEmQzkZHDz+/CKiC2e22M744Y=;
        b=RsFj2hJg51IgXpWEMkCxQhOPa62hHp8ik2iX0wLazv1CT39E4fhcUsFJJSNTuuXvCB
         ylbzz44mPNhtxGNkCtnfMAxUc+/r8BDW5YcJnMRg2zRTXaUhCWA9+Ec/YFvb6Km9vDZ6
         hna3tFNm/lPvpbGiy3X6DhVB34leReZyDlV62DsG5DDltb9GhUef9hOgZ2HeK1Xu4+Tf
         IfeH46wRlxYFA8izTXqtyefKqvCD+8iw4Bm1z5IQljlhUgyiPAHnNgby8O8T1BTolX8/
         ZlQ7Rd4YUVB+sSaefJeWwCUwy7jphr3jSGCeZ1axHxShKi/dPJUGCb1yjkZ27/E+mHax
         WWCw==
X-Gm-Message-State: AC+VfDxXy7XIiVfL3OkqPtsT9kSASR1btFBabu+WLiSqeSpI6HwiTLsQ
	IuGxTvluQvJyICHs2EZjOWEp5J64q/I66x7AL8/9YpQw9Po=
X-Google-Smtp-Source: ACHHUZ43tRYwbEecpIsg2VqN8Hl9eA7d+WczY2EbMIyBAjmRH+dh+rH9sAaRdwpQXUZH7VF8B/ceu6ERWzO+lkORnS8=
X-Received: by 2002:a2e:a307:0:b0:2b4:5afc:fe0c with SMTP id
 l7-20020a2ea307000000b002b45afcfe0cmr12944858lje.7.1687470462581; Thu, 22 Jun
 2023 14:47:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <20230621170244.1283336-12-sdf@google.com>
 <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com> <CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
In-Reply-To: <CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Jun 2023 14:47:29 -0700
Message-ID: <CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 1:13=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On Thu, Jun 22, 2023 at 12:58=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Jun 21, 2023 at 10:02:44AM -0700, Stanislav Fomichev wrote:
> > > WIP, not tested, only to show the overall idea.
> > > Non-AF_XDP paths are marked with 'false' for now.
> > >
> > > Cc: netdev@vger.kernel.org
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > ---
> > >  .../net/ethernet/mellanox/mlx5/core/en/txrx.h | 11 +++
> > >  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 96 +++++++++++++++++=
+-
> > >  .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  9 +-
> > >  .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  3 +
> > >  .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 16 ++++
> > >  .../net/ethernet/mellanox/mlx5/core/main.c    | 26 ++++-
> > >  6 files changed, 156 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/driv=
ers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > > index 879d698b6119..e4509464e0b1 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > > @@ -6,6 +6,7 @@
> > >
> > >  #include "en.h"
> > >  #include <linux/indirect_call_wrapper.h>
> > > +#include <net/devtx.h>
> > >
> > >  #define MLX5E_TX_WQE_EMPTY_DS_COUNT (sizeof(struct mlx5e_tx_wqe) / M=
LX5_SEND_WQE_DS)
> > >
> > > @@ -506,4 +507,14 @@ static inline struct mlx5e_mpw_info *mlx5e_get_m=
pw_info(struct mlx5e_rq *rq, int
> > >
> > >       return (struct mlx5e_mpw_info *)((char *)rq->mpwqe.info + array=
_size(i, isz));
> > >  }
> > > +
> > > +struct mlx5e_devtx_frame {
> > > +     struct devtx_frame frame;
> > > +     struct mlx5_cqe64 *cqe; /* tx completion */
> >
> > cqe is only valid at completion.
> >
> > > +     struct mlx5e_tx_wqe *wqe; /* tx */
> >
> > wqe is only valid at submission.
> >
> > imo that's a very clear sign that this is not a generic datastructure.
> > The code is trying hard to make 'frame' part of it look common,
> > but it won't help bpf prog to be 'generic'.
> > It is still going to precisely coded for completion vs submission.
> > Similarly a bpf prog for completion in veth will be different than bpf =
prog for completion in mlx5.
> > As I stated earlier this 'generalization' and 'common' datastructure on=
ly adds code complexity.
>
> The reason I went with this abstract context is to allow the programs
> to be attached to the different devices.
> For example, the xdp_hw_metadata we currently have is not really tied
> down to the particular implementation.
> If every hook declaration looks different, it seems impossible to
> create portable programs.
>
> The frame part is not really needed, we can probably rename it to ctx
> and pass data/frags over the arguments?
>
> struct devtx_ctx {
>   struct net_device *netdev;
>   /* the devices will be able to create wrappers to stash descriptor poin=
ters */
> };
> void veth_devtx_submit(struct devtx_ctx *ctx, void *data, u16 len, u8
> meta_len, struct skb_shared_info *sinfo);
>
> But striving to have a similar hook declaration seems useful to
> program portability sake?

portability across what ?
'timestamp' on veth doesn't have a real use. It's testing only.
Even testing is a bit dubious.
I can see a need for bpf prog to run in the datacenter on mlx, brcm
and whatever other nics, but they will have completely different
hw descriptors. timestamp kfuncs to request/read can be common,
but to read the descriptors bpf prog authors would need to write
different code anyway.
So kernel code going out its way to present somewhat common devtx_ctx
just doesn't help. It adds code to the kernel, but bpf prog still
has to be tailored for mlx and brcm differently.

