Return-Path: <bpf+bounces-18518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A43281B4F8
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 12:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3072827B9
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 11:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC576E2BF;
	Thu, 21 Dec 2023 11:32:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7055D6BB55;
	Thu, 21 Dec 2023 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SwpDQ3sllzsSSJ;
	Thu, 21 Dec 2023 19:31:50 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id DD81318005E;
	Thu, 21 Dec 2023 19:32:08 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Dec
 2023 19:32:08 +0800
Subject: Re: [RFC PATCH net-next v1 4/4] net: page_pool: use netmem_t instead
 of struct page in API
To: Mina Almasry <almasrymina@google.com>, Shakeel Butt <shakeelb@google.com>
CC: Jakub Kicinski <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=c3=b6nig?=
	<christian.koenig@amd.com>, Michael Chan <michael.chan@broadcom.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, NXP
 Linux Team <linux-imx@nxp.com>, Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand
	<shailend@google.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
	<salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, Marcin Wojtas <mw@semihalf.com>, Russell King
	<linux@armlinux.org.uk>, Sunil Goutham <sgoutham@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, John Crispin
	<john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>, Mark Lee
	<Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>, "K. Y.
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
	<justinstitt@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
References: <20231214020530.2267499-1-almasrymina@google.com>
 <20231214020530.2267499-5-almasrymina@google.com>
 <ddffff98-f3de-6a5d-eb26-636dacefe9aa@huawei.com>
 <CAHS8izO2nDHuxKau8iLcAmnho-1TYkzW09MBZ80+JzOo9YyVFA@mail.gmail.com>
 <20231215021114.ipvdx2bwtxckrfdg@google.com>
 <20231215190126.1040fa12@kernel.org>
 <CALvZod5myy2SvuCMNmqjjYeNONqSArV+8y8mrkfnNeog8WLjng@mail.gmail.com>
 <CAHS8izOLBtjHOqbTS_PiTNe+rTE=jboDWDM9zS108B57vVNcwA@mail.gmail.com>
 <CAHS8izMkCwv3jak9KUHeDUrkwBNNpdYk4voEX7Cbp7mTpNAQdA@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <54f226ef-df2d-9f32-fa3f-e846d6510758@huawei.com>
Date: Thu, 21 Dec 2023 19:32:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHS8izMkCwv3jak9KUHeDUrkwBNNpdYk4voEX7Cbp7mTpNAQdA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2023/12/20 11:01, Mina Almasry wrote:

...

>>>> Perhaps we should aim to not export netmem_to_page(),
>>>> prevent modules from accessing it directly.
>>>
>>> +1.
>>
> 
> I looked into this, but it turns out it's a slightly bigger change
> that needs some refactoring to make it work. There are few places
> where I believe I need to add netmem_to_page() that are exposed to the
> drivers via inline helpers, these are:
> 
> - skb_frag_page(), which returns NULL if the netmem is not a page, but
> needs to do a netmem_to_page() to return the page otherwise.

Is it possible to introduce something like skb_frag_netmem() for
netmem? so that we can keep most existing users of skb_frag_page()
unchanged and avoid adding additional checking overhead for existing
users.

> - The helpers inside skb_add_rx_frag(), which needs to do a
> netmem_to_page() to set skb->pfmemalloc.

Similar as above, perhaps introduce something like skb_add_rx_netmem_frag()?

> - Some of the page_pool APIs are exposed to the drivers as static
> inline helpers, and if I want the page_pool to use netmem internally
> the page_pool needs to do a netmem_to_page() in these helpers.
> 
> The refactor is not an issue, but I was wondering if not exporting
> netmem_to_page() was worth moving the code around. I was thinking in
> the interim until netmem is adopted and has actual driver users we may
> prefer to just add a comment on the netmem_to_page() helper that says
> 'try not to use this directly and use the netmem helpers instead'.
> 


