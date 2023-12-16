Return-Path: <bpf+bounces-18074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F420981568E
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 03:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE3D285AEB
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 02:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABE320F3;
	Sat, 16 Dec 2023 02:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8wt3Inh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6186412E43;
	Sat, 16 Dec 2023 02:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615E2C433C7;
	Sat, 16 Dec 2023 02:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702695123;
	bh=wEadWnvCc/HfoIu80FLtOBCdt6lNEYIGt4Ee9W8bEjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q8wt3InhMLHP4VwWMxtLBaYe3KIX1lISFdsJfCNMYuN6LBF/tbvmujO/sscks2DP0
	 qabxY/Lv3ST8+XiAtfpeCmmt9Rw3NTPWReIFKDc8VnIoM1aQNyRZ6IOMs4lSocMGwH
	 ClGUfqoazOPQtCpnh2M/dKPRR9nehaLyVlsdT3LDDeDHY3Cv9b6MN2yC8tRV6XZa3t
	 QYjHj/d5BCuH73p6iErkWyO30jEcjW/wGMw12uB8rzMQCAzU9zhRX4QTbUg7KF/blS
	 4zPRshHn9VtyganOS93WrDYuFSSvr2uFMnv/NoM/BXLMvpTjb5oT26u6a0Um1tmTXC
	 A+xUgIOjlTUqg==
Date: Fri, 15 Dec 2023 18:51:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 "Christian =?UTF-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Michael Chan
 <michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
 <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team
 <linux-imx@nxp.com>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Shailend Chand
 <shailend@google.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Thomas Petazzoni
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
 Gunthorpe <jgg@nvidia.com>, Shakeel Butt <shakeelb@google.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [RFC PATCH net-next v1 2/4] net: introduce abstraction for
 network memory
Message-ID: <20231215185159.7bada9a7@kernel.org>
In-Reply-To: <20231214020530.2267499-3-almasrymina@google.com>
References: <20231214020530.2267499-1-almasrymina@google.com>
	<20231214020530.2267499-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 18:05:25 -0800 Mina Almasry wrote:
> +struct netmem {
> +	union {
> +		struct page page;
> +
> +		/* Stub to prevent compiler implicitly converting from page*
> +		 * to netmem_t* and vice versa.
> +		 *
> +		 * Other memory type(s) net stack would like to support
> +		 * can be added to this union.
> +		 */
> +		void *addr;
> +	};
> +};

My mind went to something like:

typedef unsigned long __bitwise netmem_ref;

instead. struct netmem does not exist, it's a handle which has 
to be converted to a real type using a helper.

