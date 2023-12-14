Return-Path: <bpf+bounces-17813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DFC812FA7
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 13:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFC21F221D2
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 12:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E62241237;
	Thu, 14 Dec 2023 12:05:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9306BD;
	Thu, 14 Dec 2023 04:05:39 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SrWHj4l4yzvS9D;
	Thu, 14 Dec 2023 20:04:49 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id A0C3F1400CD;
	Thu, 14 Dec 2023 20:05:37 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 20:05:37 +0800
Subject: Re: [RFC PATCH net-next v1 4/4] net: page_pool: use netmem_t instead
 of struct page in API
To: Mina Almasry <almasrymina@google.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=c3=b6nig?=
	<christian.koenig@amd.com>, Michael Chan <michael.chan@broadcom.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, Jeroen de Borst
	<jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>, Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Marcin Wojtas
	<mw@semihalf.com>, Russell King <linux@armlinux.org.uk>, Sunil Goutham
	<sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Felix Fietkau
	<nbd@nbd.name>, John Crispin <john@phrozen.org>, Sean Wang
	<sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Horatiu
 Vultur <horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Jassi Brar
	<jaswinder.singh@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, Ravi Gunasekaran
	<r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>, Jiawen Wu
	<jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, Ronak
 Doshi <doshir@vmware.com>, VMware PV-Drivers Reviewers
	<pv-drivers@vmware.com>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen
	<shayne.chen@mediatek.com>, Kalle Valo <kvalo@kernel.org>, Juergen Gross
	<jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr
 Tyshchenko <oleksandr_tyshchenko@epam.com>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Stefan Hajnoczi
	<stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan
	<shuah@kernel.org>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Shakeel Butt
	<shakeelb@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20231214020530.2267499-1-almasrymina@google.com>
 <20231214020530.2267499-5-almasrymina@google.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <ddffff98-f3de-6a5d-eb26-636dacefe9aa@huawei.com>
Date: Thu, 14 Dec 2023 20:05:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231214020530.2267499-5-almasrymina@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2023/12/14 10:05, Mina Almasry wrote:

...

> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index ac286ea8ce2d..0faa5207a394 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -6,6 +6,7 @@
>  #include <linux/dma-direction.h>
>  #include <linux/ptr_ring.h>
>  #include <linux/types.h>
> +#include <net/netmem.h>
>  
>  #define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
>  					* map/unmap
> @@ -199,9 +200,9 @@ struct page_pool {
>  	} user;
>  };
>  
> -struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
> -struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
> -				  unsigned int size, gfp_t gfp);
> +struct netmem *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
> +struct netmem *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
> +			       unsigned int size, gfp_t gfp);

Is it possible that we add a thin layer caller on top of the page_pool API?
So that the existing users can still use the old API, the new user supporting
the devmem can use the new API, something like below:

struct netmem *netmem_pool_alloc(struct netmem_pool *pool, gfp_t gfp)
or
struct devmem *devmem_pool_alloc(struct devmem_pool *pool, gfp_t gfp)

I perfer the second one personally, as devmem means that it is not
readable from cpu.
Perhaps netmem can be used in the networking core in the future to
indicate the generic type for all types of memory supported by networking
core.

As the main concern from Jason seems to be about safe type protection for
large driver facing API surface. And touching a lot of existing users does
not seem to bring a lot of benefit when we have not a clear idea how to
proceed yet.

