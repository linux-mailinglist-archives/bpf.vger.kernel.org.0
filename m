Return-Path: <bpf+bounces-5622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B0575CAC1
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 16:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C5828227D
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 14:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063DC27F2C;
	Fri, 21 Jul 2023 14:56:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7181D2E7;
	Fri, 21 Jul 2023 14:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9D1C433C7;
	Fri, 21 Jul 2023 14:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689951377;
	bh=GbEdKOfppLFqOiQbkW2R1KhTapJ4FFcPNoaoNaBCLKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NXlKWpLuPeKFqxlrQAj4ALgNKRqep1DB4i8zp75V7Cvk8c/efHwVnko4stlpjU4/i
	 90qJ6XaOrO/Q0iWCqzCKbSXeO6sa2SO8PtbYKhoqUEWtwhsbZNFjOGVPxUj9cQ1ONL
	 ea6ISpEAjOP6gaPvwe/PUjlGBh22NxI2o7vYtxmgTFkSWT1OlhLe0BLR1a4Np62JRc
	 WqwybNdxjwXcxp6R6p8oFhYpuRHyGsHIIyyOGgCnFxqCBiA6Kd8/VJqDZDqoNRCI9g
	 K+ABmjUwR9H1QO1ejIRI9WI99NrytMs340M2ScQtOwONLs/z+3O+SClu0JjxYM/nic
	 /bxbxhWrBks3A==
Date: Fri, 21 Jul 2023 07:56:15 -0700
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
Message-ID: <20230721075615.118acad4@kernel.org>
In-Reply-To: <f5d40062-bb0d-055b-8c02-912cfd020aca@huawei.com>
References: <20230719121339.63331-1-linyunsheng@huawei.com>
	<0838ed9e-8b5c-cc93-0175-9d6cbf695dda@intel.com>
	<7e9c1276-9996-d9dd-c061-b1e66361c48b@huawei.com>
	<20230720092247.279d65f3@kernel.org>
	<f5d40062-bb0d-055b-8c02-912cfd020aca@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jul 2023 19:12:25 +0800 Yunsheng Lin wrote:
> Just to be clear, include/net/page_pool.h is still there, we are not
> putting page_pool.h in include/net/page_pool/ and renaming it to
> something else, right? As there is no that kind of uniformity in
> include/net/* as far as I can see.

Like many things the uniformity is a plan which mostly exists in my head
at this stage :) But it is somewhat inspired by include/linux/sched.*

> More specificly, yon means the below, right?
> include/net/page_pool.h
> include/net/page_pool/types.h

Yes.

