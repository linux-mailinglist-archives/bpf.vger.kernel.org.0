Return-Path: <bpf+bounces-17795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28F781283A
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 07:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CAD52827DA
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 06:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C450ED296;
	Thu, 14 Dec 2023 06:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlJb41ft"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B316A21;
	Thu, 14 Dec 2023 06:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84CCC433C8;
	Thu, 14 Dec 2023 06:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702535686;
	bh=1KvqRRdnwqEvmlU+FTtgALcCS9FN2+H6/ZpytPxQYp8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VlJb41ftGhuFO+GxwcbjBxwGRGB2zf1smUTBpPP4JBA21Ox58C2c4TJJyLD2oij5K
	 mhW89hPQm8fkU3MEjAcZ53HkyHmCdWYJQhc/LAI1IGQAIuilBVJ6gO00dm42gKkRK9
	 T7P/gPUcj7Y3pkkaSoG3q/lhkVoLzh1sDJjSvR7LrXNUBxF8Ep4GagCnjp4YRTCjIl
	 f5haY1z8EdeGAaTNu6Xej1GiLHDG9EFd/kM3doSgDZS1KbY6yxPLrJSkvhiuYkdYYK
	 /q7BhYSEXQSWZIKGts3JsXifLENy7qPEzo+qd1/2oy0Lu4OzsIrqNxAnpvL2KkQUpK
	 iDg8FMq/DWfPw==
Message-ID: <80e14311-61ba-4dda-93bb-991ad4b779df@kernel.org>
Date: Wed, 13 Dec 2023 22:34:43 -0800
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
To: Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Michael Chan <michael.chan@broadcom.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
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
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231214020530.2267499-3-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/23 7:05 PM, Mina Almasry wrote:
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> new file mode 100644
> index 000000000000..e4309242d8be
> --- /dev/null
> +++ b/include/net/netmem.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * netmem.h
> + *	Author:	Mina Almasry <almasrymina@google.com>
> + *	Copyright (C) 2023 Google LLC
> + */
> +
> +#ifndef _NET_NETMEM_H
> +#define _NET_NETMEM_H
> +
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
> +
> +static inline struct page *netmem_to_page(struct netmem *netmem)
> +{
> +	return &netmem->page;
> +}
> +
> +static inline struct netmem *page_to_netmem(struct page *page)
> +{
> +	return (struct netmem *)page;

container_of; no typecasts.


> +}
> +
> +#endif /* _NET_NETMEM_H */


