Return-Path: <bpf+bounces-18075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF961815697
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 04:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46811C243AC
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 03:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AAF1FDA;
	Sat, 16 Dec 2023 03:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSJWuzXf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0F71869;
	Sat, 16 Dec 2023 03:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8FFC433C7;
	Sat, 16 Dec 2023 03:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702695691;
	bh=/P/ZhrLqJHACtkn9yyEkbbr1lTbkhgNG4DxVbVllBpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kSJWuzXf5JsHFjt6K7rC+2VlvyaR6vrFZPqXGVBXJ22KO4Xlf0lCZ6503KvqaGDL9
	 IS4QM56v9pkuRl1X3HiEY24kAYSv4YOAY0AZ/6yZjXOI4Qubv7whLLJ6VlTUKGRtoT
	 L1k7/gFq6GVPcg4ZfH/lgDpPFnzba89eyccX0FQbsbQFs3gfLhwEzKHSjRVwwazTVM
	 npO5CMl1qlngApV+pK6Cki843NGMwIUeJYmBnzSLUYFdflZM16+e9IHhFZW2xB0jMs
	 c7+bzsTrOS7SIewdnVCHELoCnspZ01H+edRsLNE8MGbibM1YZ+LoHXvhgn+1yeXICt
	 ny2/w064p7T4A==
Date: Fri, 15 Dec 2023 19:01:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shakeel Butt <shakeelb@google.com>
Cc: Mina Almasry <almasrymina@google.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Michael Chan <michael.chan@broadcom.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Wei
 Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, Jeroen de
 Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Shailend Chand <shailend@google.com>, Yisen Zhuang
 <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, Jesse
 Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Marcin Wojtas <mw@semihalf.com>, Russell
 King <linux@armlinux.org.uk>, Sunil Goutham <sgoutham@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, John Crispin
 <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>, Mark Lee
 <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Jassi Brar
 <jaswinder.singh@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Roger
 Quadros <rogerq@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan
 Lou <mengyuanlou@net-swift.com>, Ronak Doshi <doshir@vmware.com>, VMware
 PV-Drivers Reviewers <pv-drivers@vmware.com>, Ryder Lee
 <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, Kalle
 Valo <kvalo@kernel.org>, Juergen Gross <jgross@suse.com>, Stefano
 Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, "
 =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?=" <mic@digikod.net>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [RFC PATCH net-next v1 4/4] net: page_pool: use netmem_t
 instead of struct page in API
Message-ID: <20231215190126.1040fa12@kernel.org>
In-Reply-To: <20231215021114.ipvdx2bwtxckrfdg@google.com>
References: <20231214020530.2267499-1-almasrymina@google.com>
	<20231214020530.2267499-5-almasrymina@google.com>
	<ddffff98-f3de-6a5d-eb26-636dacefe9aa@huawei.com>
	<CAHS8izO2nDHuxKau8iLcAmnho-1TYkzW09MBZ80+JzOo9YyVFA@mail.gmail.com>
	<20231215021114.ipvdx2bwtxckrfdg@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 02:11:14 +0000 Shakeel Butt wrote:
> > From my POV it has to be the first one. We want to abstract the memory
> > type from the drivers as much as possible, not introduce N new memory
> > types and ask the driver to implement new code for each of them
> > separately.
> 
> Agree with Mina's point. Let's aim to decouple memory types from
> drivers.

What does "decouple" mean? Drivers should never convert netmem 
to pages. Either a path in the driver can deal with netmem,
i.e. never touch the payload, or it needs pages.

Perhaps we should aim to not export netmem_to_page(),
prevent modules from accessing it directly.

