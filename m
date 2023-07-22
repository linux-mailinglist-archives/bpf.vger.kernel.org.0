Return-Path: <bpf+bounces-5661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E2E75D8B9
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 03:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01391C21839
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 01:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237DE613D;
	Sat, 22 Jul 2023 01:29:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79FB39E;
	Sat, 22 Jul 2023 01:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D365C433C9;
	Sat, 22 Jul 2023 01:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689989385;
	bh=R5mM7X0dWWGe8uUNwpNWWJBPRCjYazXGxXdFnAodWvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HmuHP5XXPJ9OGtuSX0ZEUaobPZhKyyzy3vPE6pZquoHGaxKkuOBYJK6imJ3otDRay
	 GckHYEcvBviIAOUIw3ZdJtbN6F1o2H+lCIY7cYQ6rlgStZ1JAPRyy4yzkpDWSw2rA5
	 iCEa/d1g0S86jnzKTU5948tooRNODGKE9yL97nmTfJCwL7CruJltGOB+Tq5ejSar8W
	 G/DioqTgh+MEEAuF5EW/SrMesfAMaXhXwJFBpucPUUaC+OiyWaJm3lsjKMghTj/1pv
	 ayRVX+l0X3k8Z/M+GfF9SEGp4PJL82byym5BcnsB8T6OOY3SH7KRPb+uo1nAaBHe1s
	 2T3QLRT6rdakg==
Date: Fri, 21 Jul 2023 18:29:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Wei
 Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, Sunil Goutham
 <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, "Subbaraya
 Sundeep" <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen
 <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Kalle Valo
 <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 <linux-rdma@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-wireless@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next] page_pool: split types and declarations from
 page_pool.h
Message-ID: <20230721182942.0ca57663@kernel.org>
In-Reply-To: <ccb728be-832c-be93-2023-6a5c78c53e6a@intel.com>
References: <20230719121339.63331-1-linyunsheng@huawei.com>
	<0838ed9e-8b5c-cc93-0175-9d6cbf695dda@intel.com>
	<7e9c1276-9996-d9dd-c061-b1e66361c48b@huawei.com>
	<20230720092247.279d65f3@kernel.org>
	<f5d40062-bb0d-055b-8c02-912cfd020aca@huawei.com>
	<20230721075615.118acad4@kernel.org>
	<ccb728be-832c-be93-2023-6a5c78c53e6a@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jul 2023 17:51:17 +0200 Alexander Lobakin wrote:
> >> More specificly, yon means the below, right?
> >> include/net/page_pool.h
> >> include/net/page_pool/types.h  
> > 
> > Yes.  
> 
> What I meant is
> 
> include/net/page_pool/types.h
> include/net/page_pool/driver.h
> 
> I'm not insisting, just to be clear :)

I thought we already talked about naming headers after the user :S
Unless you're _defining_ a driver in driver.h that's not a good name.
types.h, helpers.h, functions.h, dma.h are good names.

