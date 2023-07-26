Return-Path: <bpf+bounces-5977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E98763B9C
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 17:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53EA31C21381
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 15:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D8527708;
	Wed, 26 Jul 2023 15:50:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481E8111A3;
	Wed, 26 Jul 2023 15:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D9AC433C8;
	Wed, 26 Jul 2023 15:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690386651;
	bh=FBVPvVza7HG5I1VIoHJB6h+yX1R7w7DkdilDfqNT6DU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=maYVcK7N/Vm7jnhc68l/McAk7CYwSeld6XBM85yy8GktdXapsIj0lVxwy91fEnsNM
	 qUHskpQW3xDpoahJa5Ia4h6ay96WSBm/MpB2E3Lwna0++qtXTylHp0/Fk7/om4dIXZ
	 5cDAEF+kcyCYwPw4Czm4VyAnVtOOkJ/lcJLYZhEEevuujEBllPDWuf8uuXmjareC3H
	 b7tO2FiRCA4uc9GitfhSc1qbPSIV0rNdyc2IfN9/vZauIQJctXvxD4/KI2jL1TRKcb
	 P+TuLrNc3bw6tMDq/GipoSv4zIAoTXgbZIHE4bsLnWqj70kdEX5PbT+ULYI9M4II26
	 P0CQC5tiJcQsA==
Date: Wed, 26 Jul 2023 08:50:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, davem@davemloft.net, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
 <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team
 <linux-imx@nxp.com>, Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya
 <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad
 <hkelam@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shayne
 Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Kalle
 Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, linux-rdma@vger.kernel.org,
 bpf@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2] page_pool: split types and declarations
 from page_pool.h
Message-ID: <20230726085049.36b527a4@kernel.org>
In-Reply-To: <CAKgT0UfL4ri-o7WifeewpezGQY1UQKwcBEUSSY80DyKoE8g-0w@mail.gmail.com>
References: <20230725131258.31306-1-linyunsheng@huawei.com>
	<94272ffed7636c4c92fcc73ccfc15236dd8e47dc.camel@gmail.com>
	<16b4ab57-dfb0-2c1d-9be1-57da30dff3c3@intel.com>
	<22af47fe-1347-3e32-70bf-745d833e88b9@huawei.com>
	<CAKgT0UcU4RJj0SMQiVM8oZu86ZzK+5NjzZ2ELg_yWZyWGr04PA@mail.gmail.com>
	<CAKgT0UfL4ri-o7WifeewpezGQY1UQKwcBEUSSY80DyKoE8g-0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 08:39:43 -0700 Alexander Duyck wrote:
> > > I suppose the above suggestion is about splitting or naming by
> > > the user as the discussed in the below thread?
> > > https://lore.kernel.org/all/20230721182942.0ca57663@kernel.org/  
> >
> > Actually my suggestion is more about defining boundaries for what is
> > meant to be used by drivers and what isn't. The stuff you could keep
> > in net/core/page_pool.h would only be usable by the files in net/core/
> > whereas the stuff you are keeping in the include/net/ folder is usable
> > by drivers. It is meant to prevent things like what you were
> > complaining about with the Mellanox drivers making use of interfaces
> > you didn't intend them to use.

FWIW moving stuff which is only supposed to be used by core (xdp, skb,
etc.) to net/core/page_pool.h is a good idea, too. 
Seems a bit independent from splitting the main header, tho.

> > So for example you could pull out functions like
> > page_pool_return_skb_page, page_pool_use_xdp_mem,
> > page_pool_update_nid, and the like and look at relocating them into
> > the net/core/ folder and thereby prevent abuse of those functions by
> > drivers.  
> 
> Okay, maybe not page_pool_update_nid. It looks like that is already in
> use in the form of page_pool_nid_changed by drivers..


