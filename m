Return-Path: <bpf+bounces-5974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61312763B53
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 17:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921E31C21346
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 15:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DABF26B38;
	Wed, 26 Jul 2023 15:40:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFC01DA5F;
	Wed, 26 Jul 2023 15:40:24 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AEFE4D;
	Wed, 26 Jul 2023 08:40:21 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bba2318546so26891455ad.1;
        Wed, 26 Jul 2023 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690386020; x=1690990820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd0XKEVIQ26IMlUHdhjMjbO51vNzIsVA3nwslw/F47k=;
        b=R3ofZwIXsE8fcjEtK5ct6jjzVfEwbXsiXorqCg/0MJ41yfH0Ezm0yJV/3R41uTpXfK
         fEeR3wRS9gVVTnMqh6Lw26h6pk9S6Z+UX3nAaWah3vF4CTjM3sKcBxuln6Z04saaFvaI
         fSqRP48YkQGIljCDAMG5VJ1IGiin0Cx3DQxBQUMgqgMAyxboAdh8Jpcc66TQdWlAoZPa
         FUjEhVM2EXFVDV+ea3Lph23zPMmCp6ZAqXlstTClAM/oysB20UaYPoESRfS5ExjvMjZL
         +6StNfcQC7e2AF1/XYZ5vrE+qmSVGDMbrU/4SxrNv2nYTMc1gySHXjS/G5jfuljGV4/m
         tc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690386020; x=1690990820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qd0XKEVIQ26IMlUHdhjMjbO51vNzIsVA3nwslw/F47k=;
        b=EC3YbXCzQefgsq+6mZ14T8Y+rWyj8GH8tEXJWgNzoFpS1rkFvBw/74wW/eRWq3CEj4
         MFTewkf4YA+sg/xDt6C0jKFHPjl33PjaqjIeSRe8yyWJe10PaFXCkanx27XLT/abFxwA
         VMUUl1gACh019n74sFZois+9IEwDQrD9cs5L19NhAvyEagXPJB73rXDByZ3IyfjYOc8O
         HveGvnBnRpzHPCO8jJX2lJGgClOy4y953NeZ9eB5ZAfd86dh2vOYIkx7LHgbqVjqyDbR
         ucJWfN1hb9bdc6RSOIVI77ICfnQaNI4TP14nidU3Mh/ccHazLIkAYjGU6lMFSfiByRXI
         TmKA==
X-Gm-Message-State: ABy/qLbVabUwX6Bk7v0YNudBdxhoBTF2Ft2+pScFUFsRXllp+4zPMDGv
	HwJwDiEB6ET5Tr0hiSyE4le+HpWwHyG1BFr5Ic8=
X-Google-Smtp-Source: APBJJlGeBHTbhBX3m8Vmy0hhZqIvHH7U05vuFuDvBQ17u45lpSAHPWcH5x81Dz31f9TlEz+Hn+yoakrE5n19qB9A1bE=
X-Received: by 2002:a17:903:1108:b0:1b5:2fdf:5bd8 with SMTP id
 n8-20020a170903110800b001b52fdf5bd8mr2953334plh.8.1690386020390; Wed, 26 Jul
 2023 08:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725131258.31306-1-linyunsheng@huawei.com>
 <94272ffed7636c4c92fcc73ccfc15236dd8e47dc.camel@gmail.com>
 <16b4ab57-dfb0-2c1d-9be1-57da30dff3c3@intel.com> <22af47fe-1347-3e32-70bf-745d833e88b9@huawei.com>
 <CAKgT0UcU4RJj0SMQiVM8oZu86ZzK+5NjzZ2ELg_yWZyWGr04PA@mail.gmail.com>
In-Reply-To: <CAKgT0UcU4RJj0SMQiVM8oZu86ZzK+5NjzZ2ELg_yWZyWGr04PA@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 26 Jul 2023 08:39:43 -0700
Message-ID: <CAKgT0UfL4ri-o7WifeewpezGQY1UQKwcBEUSSY80DyKoE8g-0w@mail.gmail.com>
Subject: Re: [PATCH net-next v2] page_pool: split types and declarations from page_pool.h
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-rdma@vger.kernel.org, 
	bpf@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 8:30=E2=80=AFAM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> On Wed, Jul 26, 2023 at 4:23=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.=
com> wrote:
> >
> > On 2023/7/26 18:43, Alexander Lobakin wrote:
> > > From: Alexander H Duyck <alexander.duyck@gmail.com>
> > > Date: Tue, 25 Jul 2023 08:47:46 -0700
> > >
> > >> On Tue, 2023-07-25 at 21:12 +0800, Yunsheng Lin wrote:
> > >>> Split types and pure function declarations from page_pool.h
> > >>> and add them in page_pool/types.h, so that C sources can
> > >>> include page_pool.h and headers should generally only include
> > >>> page_pool/types.h as suggested by jakub.
> > >>>
> > >>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> > >>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > >>> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> > >
> > > [...]
> > >
> > >>> +/* Caller must provide appropriate safe context, e.g. NAPI. */
> > >>> +void page_pool_update_nid(struct page_pool *pool, int new_nid);
> > >>> +
> > >>> +#endif /* _NET_PAGE_POOL_H */
> > >>
> > >>
> > >> This seems kind of overkill for what is needed. It seems like the
> > >> general thought process with splitting this was so that you had just
> > >> the minimum of what is needed to support skbuff.h and the functions
> > >> declared there. The rest of this would then be added via the .h to t=
he
> > >> .c files that will actually be calling the functions.
> > >>
> > >> By that logic I think the only thing we really need is the function
> > >> declaration for page_pool_return_skb_page moved into skbuff.h. We co=
uld
> > >> then just remove page_pool.h from skbuff.h couldn't we?
> > >
> > > This patch is not to drop page_pool.h include from skbuff.h.
> > > This is more future-proof (since I'm dropping this include anyway in =
my
> > > series) to have includes organized and prevent cases like that one wi=
th
> > > skbuff.h from happening. And to save some CPU cycles on preprocessing=
 if
> > > that makes sense.
> >
> > The suggestion is from below:
> >
> > https://lore.kernel.org/all/20230710113841.482cbeac@kernel.org/
>
> I get that. But it seemed like your types.h is full of inline
> functions. That is what I was responding to. I would leave the inline
> functions in page_pool.h unless there is some significant need for
> them.
>
> > >
> > >>
> > >> Another thing we could consider doing is looking at splitting things=
 up
> > >> so that we had a include file in net/core/page_pool.h to handle some=
 of
> > >> the cases where we are just linking the page_pool bits to other core
> > >> file bits such as xdp.c and skbuff.c.
> >
> > I suppose the above suggestion is about splitting or naming by
> > the user as the discussed in the below thread?
> > https://lore.kernel.org/all/20230721182942.0ca57663@kernel.org/
>
> Actually my suggestion is more about defining boundaries for what is
> meant to be used by drivers and what isn't. The stuff you could keep
> in net/core/page_pool.h would only be usable by the files in net/core/
> whereas the stuff you are keeping in the include/net/ folder is usable
> by drivers. It is meant to prevent things like what you were
> complaining about with the Mellanox drivers making use of interfaces
> you didn't intend them to use.
>
> So for example you could pull out functions like
> page_pool_return_skb_page, page_pool_use_xdp_mem,
> page_pool_update_nid, and the like and look at relocating them into
> the net/core/ folder and thereby prevent abuse of those functions by
> drivers.

Okay, maybe not page_pool_update_nid. It looks like that is already in
use in the form of page_pool_nid_changed by drivers..

