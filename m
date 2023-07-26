Return-Path: <bpf+bounces-5982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4D4763CB7
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 18:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA42281ABE
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 16:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F8F1AA72;
	Wed, 26 Jul 2023 16:43:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62041AA63;
	Wed, 26 Jul 2023 16:43:13 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A4626B8;
	Wed, 26 Jul 2023 09:43:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b89cfb4571so55417545ad.3;
        Wed, 26 Jul 2023 09:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690389792; x=1690994592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCv8whutDfLJorKpUOqJ8+KkOpc2kOBhY8hTu1PhHvI=;
        b=QMUznHOLJYfI3Cg1OGbvbUK2zwN4Xs54ZJ3JbZrw4JhdF1uxPQBZ3HVCSn31MYAgdc
         Q3UdwouTq+Mcv+ne7ujpatnJtig71lQqScyMfCpcd4njFTx2RrYTuWYS75n+F8Ub+lJb
         sgYnZK0m3NpEEtpkxeXqvlCQL5FyNn9joXe4bALGP92MnaPs+jHcAWAHXearGlrCz8vp
         NiOWaE+mGvO2zNT5aJxPyQVlYzpIxZgun8DIiMsIyNzjTELMbe8K/8SOPkhf+s3/lXjk
         II5NtI1EzZjw6UkqZdZsvukqb8KGZBLOTuS3MfVf02FYRvI+M5kRxGwBzEWcbh/IBuyC
         WI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690389792; x=1690994592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCv8whutDfLJorKpUOqJ8+KkOpc2kOBhY8hTu1PhHvI=;
        b=GBt3NA5pNQ1akjvGOAZItclKXqBzKoEc9R+/iZ4uWNPpeAs1ZMC2STAudf54WM8YPr
         oEznqknjN1S5jLmJpBkyplAi9+3A34DJZ4L7EfCZdLhHn522n0OEYpJA4O8JkR5dngjv
         pWtP0MogwAQTEU+8g6lqEnj48k47bM1ALXY5k9Jms3ORK2Q0P0f8uuC0v//1kdRbripe
         ydXFDYsa5+uRYdmHO7/DCGhoUX+AsD3QT/sXR6zHL0PugOlYffmgAzUfkMgVct3m5vEh
         XzYRFfqG/duH9w3UKYKdh3z1f/7gnZxt1eOmnzYu5p2liSyvrpM1AtEx5qHzfXmlrDnY
         x07g==
X-Gm-Message-State: ABy/qLYhU4dukQt5W0+ubN3zpnyzYGDdYO06KOw22brnUGgkGAKpBNlM
	Nak27gn0Z8BuShSCHRpH1D87JTjtvobx6LhC1nU=
X-Google-Smtp-Source: APBJJlExta4H2GjqFCFJjAPMwlKu75pRye0RG2yh6z7/8hWP5WKagkLUkY7X/mJhBRsTApJB/W2FhSG2fN3oUXYQ7wA=
X-Received: by 2002:a17:90a:c714:b0:263:f643:4bd3 with SMTP id
 o20-20020a17090ac71400b00263f6434bd3mr2209207pjt.27.1690389791855; Wed, 26
 Jul 2023 09:43:11 -0700 (PDT)
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
 <CAKgT0UfL4ri-o7WifeewpezGQY1UQKwcBEUSSY80DyKoE8g-0w@mail.gmail.com> <20230726085049.36b527a4@kernel.org>
In-Reply-To: <20230726085049.36b527a4@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 26 Jul 2023 09:42:34 -0700
Message-ID: <CAKgT0UddT2CY_HrQ-d+5vPbpguuscsfF=oUVW02AFy0JAYet3w@mail.gmail.com>
Subject: Re: [PATCH net-next v2] page_pool: split types and declarations from page_pool.h
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, davem@davemloft.net, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
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

On Wed, Jul 26, 2023 at 8:50=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 26 Jul 2023 08:39:43 -0700 Alexander Duyck wrote:
> > > > I suppose the above suggestion is about splitting or naming by
> > > > the user as the discussed in the below thread?
> > > > https://lore.kernel.org/all/20230721182942.0ca57663@kernel.org/
> > >
> > > Actually my suggestion is more about defining boundaries for what is
> > > meant to be used by drivers and what isn't. The stuff you could keep
> > > in net/core/page_pool.h would only be usable by the files in net/core=
/
> > > whereas the stuff you are keeping in the include/net/ folder is usabl=
e
> > > by drivers. It is meant to prevent things like what you were
> > > complaining about with the Mellanox drivers making use of interfaces
> > > you didn't intend them to use.
>
> FWIW moving stuff which is only supposed to be used by core (xdp, skb,
> etc.) to net/core/page_pool.h is a good idea, too.
> Seems a bit independent from splitting the main header, tho.

It seems a bit independent, but I was reacting only because I feel
like this ijust adding to the technical debt on this. Basically before
we can really just go ahead and split it the header file itself should
probably be cleaned up a bit.

The reason why it occurred to me is that I noticed things like
page_pool_use_xdp_mem and the forward declaration for xdp_mem_info was
being picked up and moved into the types.h file in the move. The whole
block was in a #if/#else statement w/ definitions for the PAGE_POOL
and non-PAGE_POOL cases.

We also have functions that don't really need to be included such as
page_pool_unlink_napi which is exported but not used outside of
page_pool.c from what I can tell.

