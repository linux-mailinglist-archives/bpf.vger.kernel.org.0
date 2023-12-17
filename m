Return-Path: <bpf+bounces-18108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A564B815D15
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 02:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E5A0B216C7
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 01:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1451ED0;
	Sun, 17 Dec 2023 01:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npth3316"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3593E1FA1;
	Sun, 17 Dec 2023 01:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DB1C433C7;
	Sun, 17 Dec 2023 01:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702777520;
	bh=GJ+yokT7RhwyIcN6IONxEy2r0GaoEnqwXkRiPSztTmg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=npth3316p6Vn06DE4RsPPOpdjwlc84G/9uIDZY/GWB9sqcOhYRX9+jj/QeeDcoCbc
	 r7VADqZfYpRmd1zvg1DeWicsplyeluRAKPAOvLhdT+o9bbpNELPO6S0I+ouEGjFNJ9
	 +QTamWw0A1HGaOdlCuZ6wGWwHJ1HsMhUPtdKhDsBbLJaJGaoPzOs+sTWel9McRpjd6
	 SZd0quVZmx26qvke9qRVBtBWAmz8+oTVBNLNlvvD7UVtjEU1VLXtGgMuW9/pAbP8Td
	 q5gqxlKd7mqiWQ/8t6S+sGUPoRen0xzLe5X+2qWQW24NoUlbwga49J6u26VMgnqRia
	 RkbKufMWzOk1Q==
Message-ID: <84787af3-aa5e-4202-8578-7a9f14283d87@kernel.org>
Date: Sat, 16 Dec 2023 18:45:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v1 2/4] net: introduce abstraction for
 network memory
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Michael Chan <michael.chan@broadcom.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 NXP Linux Team <linux-imx@nxp.com>, Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Shailend Chand <shailend@google.com>, Yisen Zhuang
 <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Marcin Wojtas <mw@semihalf.com>, Russell King <linux@armlinux.org.uk>,
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
 Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Jassi Brar <jaswinder.singh@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou
 <mengyuanlou@net-swift.com>, Ronak Doshi <doshir@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Kalle Valo <kvalo@kernel.org>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Shakeel Butt <shakeelb@google.com>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20231214020530.2267499-1-almasrymina@google.com>
 <20231214020530.2267499-3-almasrymina@google.com>
 <20231215185159.7bada9a7@kernel.org>
 <CAHS8izMcFWu7zSuX9q8QgVNLiOiE5RKsb_yh5LoTKA1K8FUu1w@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAHS8izMcFWu7zSuX9q8QgVNLiOiE5RKsb_yh5LoTKA1K8FUu1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/16/23 2:10 PM, Mina Almasry wrote:
> On Fri, Dec 15, 2023 at 6:52 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Wed, 13 Dec 2023 18:05:25 -0800 Mina Almasry wrote:
>>> +struct netmem {
>>> +     union {
>>> +             struct page page;
>>> +
>>> +             /* Stub to prevent compiler implicitly converting from page*
>>> +              * to netmem_t* and vice versa.
>>> +              *
>>> +              * Other memory type(s) net stack would like to support
>>> +              * can be added to this union.
>>> +              */
>>> +             void *addr;
>>> +     };
>>> +};
>>
>> My mind went to something like:
>>
>> typedef unsigned long __bitwise netmem_ref;
>>
>> instead. struct netmem does not exist, it's a handle which has
>> to be converted to a real type using a helper.
> 
> Sure thing I can do that. Is it better to do something like:
> 
> struct netmem_ref;
> 
> like in this patch:
> 
> https://lore.kernel.org/linux-mm/20221108194139.57604-1-torvalds@linux-foundation.org/
> 
> Asking because checkpatch tells me not to add typedefs to the kernel,
> but checkpatch can be ignored if you think it's OK.
> 
> Also with this approach I can't use container_of and I need to do a
> cast, I assume that's fine.
> 

Isn't that the whole point of this set - to introduce a new data type
and avoid casts?

