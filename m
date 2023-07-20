Return-Path: <bpf+bounces-5498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 265D175B40A
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 18:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C2B1C21324
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 16:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625B719BB7;
	Thu, 20 Jul 2023 16:22:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6817518C2D;
	Thu, 20 Jul 2023 16:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E0FC433C8;
	Thu, 20 Jul 2023 16:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689870169;
	bh=Ga7vIpJBGNUMApUSoun4tXfXEl7VbVUv4I6DCjjfbAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rDHLNXGwIvMHpNywshRgUPi+IXDPlOs5NO3euDhmRsGbXh0CscyAmfQpeQo/knivh
	 HR3UFzU5wkh0Mn273qVxXTfkibGeI10vuHAggrxFD7TPMkpXk1g3pxtEevHmB4lkaM
	 EttnT6/+FzHGmzbku9kikGP0MlFqFfXuG8vM2FXH3upqc1SoxuGxWjpJ/JbG0Ub2pO
	 4KW93kC4qEHEKKMVIFqEr9A/jChPzqTzc1PD/PTqgoF6rvuBd61iPbZBwqedCv+LIN
	 XDKa6i1hfxCGL4PaLA58iGFombeHuRO0dgM92lvfvmAVeBFO2yLlASlPYCivOgC8Pm
	 gpmfJGqETEZ7Q==
Date: Thu, 20 Jul 2023 09:22:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Wei
 Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, Sunil Goutham
 <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen
 <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Kalle Valo
 <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, <linux-rdma@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next] page_pool: split types and declarations from
 page_pool.h
Message-ID: <20230720092247.279d65f3@kernel.org>
In-Reply-To: <7e9c1276-9996-d9dd-c061-b1e66361c48b@huawei.com>
References: <20230719121339.63331-1-linyunsheng@huawei.com>
	<0838ed9e-8b5c-cc93-0175-9d6cbf695dda@intel.com>
	<7e9c1276-9996-d9dd-c061-b1e66361c48b@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 19:07:31 +0800 Yunsheng Lin wrote:
> > BTW, what do you think: is it better to have those two includes in the
> > root include/net/ folder or do something like
> > 
> > include/net/page_pool/
> >   * types.h
> >   * <some meaningful name>.h (let's say driver.h)
> > 
> > like it's done e.g. for GPIO (see include/linux/gpio/)?  
> 
> It make more sense to add a new dir for page pool if there are
> more new headers added. As we are still keeping the page_pool.h
> mirroring include/linux/gpio.h, adding a new dir for only one
> header file only add another level of dir without abvious benefit.
> We can add a new dir for it if we turn out to be needing more header
> file for page pool in the future, does it make sense?

It doesn't matter all that much so I think to have some uniformity 
in networking please go with Olek's suggestion which is also my
preference.

