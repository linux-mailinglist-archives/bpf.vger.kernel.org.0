Return-Path: <bpf+bounces-5876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B97762434
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 23:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2032281969
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 21:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5B226B87;
	Tue, 25 Jul 2023 21:12:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE17D1F188;
	Tue, 25 Jul 2023 21:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48769C433C9;
	Tue, 25 Jul 2023 21:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690319545;
	bh=+wjx3PSEq0K5+Aw7/+zFEoqif9hytq8mg416yZy/nHU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oDwGVunkHA4n7n03Gl8jk70U5ZjAYv48eGM6EMyCNpK27QgccD7LYKF9E3dH97YFT
	 cqvhh48Z9nPUtchSJ/KbUX3zg0yMj4pX5j5/0Xn/ZvzJ6HIn4FMUmu7H3wKLHN0PXK
	 zXoixoE1xRJinOW8sELWeoVoJKBphIpInvne8i+89HCy9OGrw636tFTmEixYbzEqkP
	 yLrrITncMcu6w3VjQYDrfxrpNKUJwxhHRYgfv6WcW5N3LhGttkAyegjJfYv0C61xul
	 pibX3ENru+yDIDv+zRTFwZbHQNBe0UH7lTDvydbQSgYvKj+dw/O78BZVL3tdK2a5aO
	 65imaNtu1zwLw==
Date: Tue, 25 Jul 2023 14:12:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Eric Dumazet
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
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2] page_pool: split types and declarations
 from page_pool.h
Message-ID: <20230725141223.19c1c34c@kernel.org>
In-Reply-To: <ZL/fVF7WetuLgB0l@hera>
References: <20230725131258.31306-1-linyunsheng@huawei.com>
	<ZL/fVF7WetuLgB0l@hera>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 17:42:28 +0300 Ilias Apalodimas wrote:
> Apologies for the very late replies, I was on long vacation with limited
> internet access.
> Yunsheng, since there's been a few mails and I lost track, this is instead of
> [0] right? If so, I prefer this approach.  It looks ok on a first quick pass,
> I'll have a closer look later.
> 
> [0] https://lore.kernel.org/netdev/20230714170853.866018-2-aleksander.lobakin@intel.com/


I prefer the more systematic approach of creating a separate types.h
file, so I don't have to keep chasing people or cleaning up the include
hell myself. I think it should be adopted more widely going forward,
it's not just about the page pool.

