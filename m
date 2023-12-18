Return-Path: <bpf+bounces-18239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BAC817D19
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 23:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF7F2837B1
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 22:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE9174E09;
	Mon, 18 Dec 2023 22:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7H9+Sby"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16A4740A3;
	Mon, 18 Dec 2023 22:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24844C433C8;
	Mon, 18 Dec 2023 22:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702937210;
	bh=JRDQObUf/WROaXC2TkDgUYKUAbVrKHE0oead3omIraI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n7H9+SbylKmNBllkPLk67C+s3qBTkN5kg5IPuij3RSIzvCYvgw7DQlXuvaxgWwfe5
	 4bWmsjcsK/3oJqHmJyx5Bwf5Z4Wa6uI7UXg/oks+Rs7b8lz8uoXraQdKPGZcptPa0c
	 YKdYevBe3Mlqs0xnIhqUGvL0ttlgOH+VAuzZWuvI/N88D7qli3aAOq1bS57nwyB3dU
	 40bHJ5lHG2gn1WCXcr8kRC153hBcvSC9WEWaEpGFa1wrS+GtvSmMs6PgULVfu5NcVh
	 fvhX63egnA2LysXBZEoIheB4FzM5Yd1AKC2WYUrIzTGDMmZfmAIhETuKuHDKFeEboT
	 fWR115dNc4f4w==
Date: Mon, 18 Dec 2023 14:06:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
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
 Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Shakeel Butt <shakeelb@google.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [RFC PATCH net-next v1 2/4] net: introduce abstraction for
 network memory
Message-ID: <20231218140645.461169a7@kernel.org>
In-Reply-To: <CAHS8izOeCdA+WVRYbieTqaCyadARsOpYttAXh7Lhu-B7RC3Tmg@mail.gmail.com>
References: <20231214020530.2267499-1-almasrymina@google.com>
	<20231214020530.2267499-3-almasrymina@google.com>
	<20231215185159.7bada9a7@kernel.org>
	<CAHS8izMcFWu7zSuX9q8QgVNLiOiE5RKsb_yh5LoTKA1K8FUu1w@mail.gmail.com>
	<84787af3-aa5e-4202-8578-7a9f14283d87@kernel.org>
	<CAHS8izOeCdA+WVRYbieTqaCyadARsOpYttAXh7Lhu-B7RC3Tmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Dec 2023 00:14:59 -0800 Mina Almasry wrote:
> > > Sure thing I can do that. Is it better to do something like:
> > >
> > > struct netmem_ref;
> > >
> > > like in this patch:
> > >
> > > https://lore.kernel.org/linux-mm/20221108194139.57604-1-torvalds@linux-foundation.org/
> > >
> > > Asking because checkpatch tells me not to add typedefs to the kernel,
> > > but checkpatch can be ignored if you think it's OK.
> > >
> > > Also with this approach I can't use container_of and I need to do a
> > > cast, I assume that's fine.
> > >  
> >
> > Isn't that the whole point of this set - to introduce a new data type
> > and avoid casts?  

I don't see how we can avoid casts if the type of the referenced object
is encoded on the low bits of the pointer. If we had a separate member
we could so something like:

struct netmem_ref {
	enum netmem_type type;
	union {
		struct page *p;
		struct page_pool_iov *pi;
	};
};

barring crazy things with endian-aware bitfields, we need at least one
cast.

> My understanding here the requirements from Jason are:
> 
> 1. Never pass a non-page to an mm api.
> 2. If a mangle a pointer to indicate it's not a page, then I must not
> call it mm's struct page*, I must add a new type.
> 
> I think both requirements are met regardless of whether
> netmem_to_page() is implemented using union/container_of or straight
> casts. folios implemented something similar being unioned with struct
> page to avoid casts. 

Folios overlay a real struct page. It's completely different.

> I honestly could go either way on this. The union
> provides some self documenting code and avoids casts. 

Maybe you guys know some trick to mask out the bottom bit :S

> The implementation without the union obfuscates the type and makes it much
> more opaque.

Some would say that that's the damn point of the wrapping..

You don't want non-core code futzing with the inside of the struct.

> I finished addressing the rest of the comments and I have this series
> and the next devmem TCP series ready to go, so I fired v2 of this
> patchset. If one feels strongly about this let me know and I will
> re-spin.

You didn't address my feedback :|

struct netmem which contains struct page by value is almost as bad
as passing around pretend struct page pointers.

