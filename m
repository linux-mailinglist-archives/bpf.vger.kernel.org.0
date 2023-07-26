Return-Path: <bpf+bounces-5973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD76763B1D
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 17:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37CE82815DA
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED25253D8;
	Wed, 26 Jul 2023 15:31:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D941DA3F;
	Wed, 26 Jul 2023 15:31:00 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEBD2701;
	Wed, 26 Jul 2023 08:30:54 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686bd857365so1101499b3a.3;
        Wed, 26 Jul 2023 08:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690385454; x=1690990254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIvg9RvPixHqfad2Kamp9kJBh4DIZcFMKZRn7pfOsNE=;
        b=UvNxr8eLJ9hNPoNo/nmVkgjI4LmuR9ztzcTY+8rMIzSoHv7gwljQlaHHd92gm95UVm
         nU56pgA2IgpkZ87/1SXR5DOwjHop16+wfwPEV6IS33mO1QlQi6mSJ8FVmwoSi/+kZx4P
         qanoK+6WcjuZX7MFStjdzc0nrwV3XSiclq3I9Cq47+YLuQmJjCuttPtZTA47gY8Px5VL
         M0KGCrZjA8PmkcEwyq7+BkhWwhnMHinBdCCuaa+ygSj2WTJ1OO0iLTikgnWKqb83HYA/
         7qGLhQ84+9qqmlQzBfUs/lur7fuEApadKSY61qyN9KpEKVsfsHhr/QJ2E0h+XppBvQji
         sYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690385454; x=1690990254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIvg9RvPixHqfad2Kamp9kJBh4DIZcFMKZRn7pfOsNE=;
        b=RwbvIAEsfrnnAkZp10d5GK2xnJ/PISXCb4hDRbDeoDEAmfqr/c4Ry6lcfXUFfrCNcq
         /YuhuMlV5YN/35P4vjYhnxHYyM4BmmUDKUTu5/TirswnbZ9XEu5zOFbpWIYFsYTOSH06
         xXSVVKhkHcEX3IxTQb9HvIVvz41o3dl1jg/0P+BkXFrleILggOmvUXldqNR/Yy4rmDY/
         P0yx34lN5RE6pu2uVLYN554MMMEu63ERszFVgcobyM4pMxinpMBUuk6fhQPtNZIrvjPt
         TuTkFx4KMcefaApb59FNLM4lPOOaEDRR/gr/HWit9Jg1XcHv0x1uze8oFF8beD4yzzoH
         INyg==
X-Gm-Message-State: ABy/qLaxNMwdkA9M8i8MKjifByrfhN1ISoeOjHYk1hO/kqAgpCx+3V03
	cXLWMZBv4nW+bJU2y4bHpyqZhuyxoMLZPOtpal4=
X-Google-Smtp-Source: APBJJlGsYifDPtFqieNjZSRGPJL2WJtbotBq8b23fwCEiS2YFyApRJq7zsSItWWZeZOofGURnKLE/TZxtTf3oC+7O6c=
X-Received: by 2002:a17:90b:a4e:b0:268:5620:cfc7 with SMTP id
 gw14-20020a17090b0a4e00b002685620cfc7mr1509855pjb.30.1690385453708; Wed, 26
 Jul 2023 08:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725131258.31306-1-linyunsheng@huawei.com>
 <94272ffed7636c4c92fcc73ccfc15236dd8e47dc.camel@gmail.com>
 <16b4ab57-dfb0-2c1d-9be1-57da30dff3c3@intel.com> <22af47fe-1347-3e32-70bf-745d833e88b9@huawei.com>
In-Reply-To: <22af47fe-1347-3e32-70bf-745d833e88b9@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 26 Jul 2023 08:30:17 -0700
Message-ID: <CAKgT0UcU4RJj0SMQiVM8oZu86ZzK+5NjzZ2ELg_yWZyWGr04PA@mail.gmail.com>
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

On Wed, Jul 26, 2023 at 4:23=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/7/26 18:43, Alexander Lobakin wrote:
> > From: Alexander H Duyck <alexander.duyck@gmail.com>
> > Date: Tue, 25 Jul 2023 08:47:46 -0700
> >
> >> On Tue, 2023-07-25 at 21:12 +0800, Yunsheng Lin wrote:
> >>> Split types and pure function declarations from page_pool.h
> >>> and add them in page_pool/types.h, so that C sources can
> >>> include page_pool.h and headers should generally only include
> >>> page_pool/types.h as suggested by jakub.
> >>>
> >>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> >>> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> >
> > [...]
> >
> >>> +/* Caller must provide appropriate safe context, e.g. NAPI. */
> >>> +void page_pool_update_nid(struct page_pool *pool, int new_nid);
> >>> +
> >>> +#endif /* _NET_PAGE_POOL_H */
> >>
> >>
> >> This seems kind of overkill for what is needed. It seems like the
> >> general thought process with splitting this was so that you had just
> >> the minimum of what is needed to support skbuff.h and the functions
> >> declared there. The rest of this would then be added via the .h to the
> >> .c files that will actually be calling the functions.
> >>
> >> By that logic I think the only thing we really need is the function
> >> declaration for page_pool_return_skb_page moved into skbuff.h. We coul=
d
> >> then just remove page_pool.h from skbuff.h couldn't we?
> >
> > This patch is not to drop page_pool.h include from skbuff.h.
> > This is more future-proof (since I'm dropping this include anyway in my
> > series) to have includes organized and prevent cases like that one with
> > skbuff.h from happening. And to save some CPU cycles on preprocessing i=
f
> > that makes sense.
>
> The suggestion is from below:
>
> https://lore.kernel.org/all/20230710113841.482cbeac@kernel.org/

I get that. But it seemed like your types.h is full of inline
functions. That is what I was responding to. I would leave the inline
functions in page_pool.h unless there is some significant need for
them.

> >
> >>
> >> Another thing we could consider doing is looking at splitting things u=
p
> >> so that we had a include file in net/core/page_pool.h to handle some o=
f
> >> the cases where we are just linking the page_pool bits to other core
> >> file bits such as xdp.c and skbuff.c.
>
> I suppose the above suggestion is about splitting or naming by
> the user as the discussed in the below thread?
> https://lore.kernel.org/all/20230721182942.0ca57663@kernel.org/

Actually my suggestion is more about defining boundaries for what is
meant to be used by drivers and what isn't. The stuff you could keep
in net/core/page_pool.h would only be usable by the files in net/core/
whereas the stuff you are keeping in the include/net/ folder is usable
by drivers. It is meant to prevent things like what you were
complaining about with the Mellanox drivers making use of interfaces
you didn't intend them to use.

So for example you could pull out functions like
page_pool_return_skb_page, page_pool_use_xdp_mem,
page_pool_update_nid, and the like and look at relocating them into
the net/core/ folder and thereby prevent abuse of those functions by
drivers.

