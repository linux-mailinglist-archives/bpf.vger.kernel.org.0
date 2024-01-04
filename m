Return-Path: <bpf+bounces-19016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA948823DDA
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 09:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 615BCB247D6
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 08:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D0C1EA6E;
	Thu,  4 Jan 2024 08:48:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8893D1E528;
	Thu,  4 Jan 2024 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4T5Kvk05cFz1g1dg;
	Thu,  4 Jan 2024 16:46:58 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 6981E1A0172;
	Thu,  4 Jan 2024 16:48:24 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Jan
 2024 16:48:23 +0800
Subject: Re: [RFC PATCH net-next v1 4/4] net: page_pool: use netmem_t instead
 of struct page in API
To: Mina Almasry <almasrymina@google.com>
CC: Shakeel Butt <shakeelb@google.com>, Jakub Kicinski <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Michael Chan
	<michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
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
 <54f226ef-df2d-9f32-fa3f-e846d6510758@huawei.com>
 <CAHS8izP63wXGH+Q3y1H=ycT=AHYnhGveBnuyF_rYioAjZ=Hn=g@mail.gmail.com>
 <7c6d35e3-165f-5883-1c1b-fce82c976028@huawei.com>
 <CAHS8izNqeiK1tq=48LMbbqq5B4d2mhgbuKRvnFtiBngf73jXZg@mail.gmail.com>
 <fda068d0-f7fb-90fc-cdd6-1f853a4a225f@huawei.com>
 <CAHS8izNAxB=DQzSBOGbm6SsiL1cLSijj9n=g3d3egSxnOcBibQ@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <99817ed2-8ba6-ef8f-3ccb-2a2ab284b4af@huawei.com>
Date: Thu, 4 Jan 2024 16:48:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHS8izNAxB=DQzSBOGbm6SsiL1cLSijj9n=g3d3egSxnOcBibQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/4 2:38, Mina Almasry wrote:
> On Wed, Jan 3, 2024 at 1:47 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/1/3 0:14, Mina Almasry wrote:
>>>
>>> The idea being that skb_frag_page() can return NULL if the frag is not
>>> paged, and the relevant callers are modified to handle that.
>>
>> There are many existing drivers which are not expecting NULL returning for
>> skb_frag_page() as those drivers are not supporting devmem, adding additionl
>> checking overhead in skb_frag_page() for those drivers does not make much
>> sense, IMHO, it may make more sense to introduce a new helper for the driver
>> supporting devmem or networking core that needing dealing with both normal
>> page and devmem.
>>
>> And we are also able to keep the old non-NULL returning semantic for
>> skb_frag_page().
> 
> I think I'm seeing agreement that the direction we're heading into
> here is that most net stack & drivers should use the abstract netmem

As far as I see, at least for the drivers, I don't think we have a clear
agreement if we should have a unified driver facing struct or API for both
normal page and devmem yet.

> type, and only specific code that needs a page or devmem (like
> tcp_receive_zerocopy or tcp_recvmsg_dmabuf) will be the ones that
> unpack the netmem and get the underlying page or devmem, using
> skb_frag_page() or something like skb_frag_dmabuf(), etc.
> 
> As Jason says repeatedly, I'm not allowed to blindly cast a netmem to
> a page and assume netmem==page. Netmem can only be cast to a page
> after checking the low bits and verifying the netmem is actually a

I thought it would be best to avoid casting a netmem or devmem to a
page in the driver, I think the main argument is that it is hard
to audit very single driver doing a checking before doing the casting
in the future? and we can do better auditting if the casting is limited
to a few core functions in the networking core.

> page. I think any suggestions that blindly cast a netmem to page
> without the checks will get nacked by Jason & Christian, so the
> checking in the specific cases where the code needs to know the
> underlying memory type seems necessary.
> 
> IMO I'm not sure the checking is expensive. With likely/unlikely &
> static branches the checks should be very minimal or a straight no-op.
> For example in RFC v2 where we were doing a lot of checks for devmem
> (we don't do that anymore for RFCv5), I had run the page_pool perf
> tests and proved there is little to no perf regression:

For MAX_SKB_FRAGS being 17, it means we may have 17 additional checking
overhead for the drivers not supporting devmem, not to mention we may
have bigger value for MAX_SKB_FRAGS if BIG TCP is enable.

Even there is no notiable performance degradation for a specific case,
we should avoid the overhead as much as possible for the existing use
case when supporting a new use case.

> 
> https://lore.kernel.org/netdev/CAHS8izM4w2UETAwfnV7w+ZzTMxLkz+FKO+xTgRdtYKzV8RzqXw@mail.gmail.com/

The above test case does not even seems to be testing a code path calling
skb_frag_page() as my understanding.

> 

