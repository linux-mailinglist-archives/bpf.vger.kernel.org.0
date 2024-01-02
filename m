Return-Path: <bpf+bounces-18772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F7C821F4C
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 17:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6DE1C22481
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E110714F73;
	Tue,  2 Jan 2024 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nsYpGk6k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02CC14F60
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-555d4232e4fso3511564a12.3
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 08:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704212070; x=1704816870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hd2aplMCet1ULWImTVMnDRzK7TL9hZ+ZX0uPlm9Tbpc=;
        b=nsYpGk6kupUKR1Qxd4pt+MtzmA3B1XsadgguFFYG5Nk6G6jsf/0sK0dla4la28IPYe
         J68Sc+IIkxrem44lkKnwnmdNtv54oCHSz3aOaOydM9a6va5CTA1yQyUoOR0fP4coORcf
         9wCr9dU92Is4MmJNTvkRhNwRAWNCmcwWkBoOfYczAQjx6GnmxK4xwW779G0DNVwAj+++
         IaZVzjDcjTxPfmhZJtPS1LmbdfgCD+CQoRrALapZcFfl4wTyO+QnAgdVdlUatSejh6zU
         In+nuSkIJBwFiSS9NYQ4k0BHLGW7PJzWhuqalMZw0OgsP9yxxJmX1z5hoNzdOMB1LI8L
         RLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704212070; x=1704816870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hd2aplMCet1ULWImTVMnDRzK7TL9hZ+ZX0uPlm9Tbpc=;
        b=MUqduQl9fJSki6w0E5yX9ZkZWX1n9VxGFT5xQ0Qwspn6CuY+QHXAlymBGKDjFRmkcW
         R7ByG/UdsIC/6wVsO0/xRFQQqQLeLrhUEDUAlHNXl8GTF3LnmHiq4K/iQkUv8sSVzbzw
         GgTO79VqFmd4a7OAKuJRS2jFqKe71q/Ogb0O4PTxj4CHjKVmXNaHQaCObmhpcRODlRXC
         dfqKBtTZVIbWDRi/1cfMRyAwiPfduP2d4VGZ5lRpcbLVxoF6zFibgG/MNm5o8N8a1NPl
         44ULzmwKAhPcSgJxi9kk7xzTVBkAqzt8ZPvnyy0IDV1E7QTNfwryMRXZq/XILpJC1bGS
         VajQ==
X-Gm-Message-State: AOJu0YwbckJFoGm4x2tpfNopCtk5m5ozjEVPM3IxWWu4jMC+c7qEDWt3
	MG9SegHPXQBa+Pg+hQY4yxHZXKbl/708ZKQjlGy6qsR+zNN7
X-Google-Smtp-Source: AGHT+IFJ3xiAnAAHviNNi+mEA9xiSIWfCXxzkbkl9TWLLiupNuy3YZ8o9IKmk26LnKZQwIZ/I/z3OiIAFQuWEIa3Vgs=
X-Received: by 2002:a17:906:6a18:b0:a27:4725:6e4f with SMTP id
 qw24-20020a1709066a1800b00a2747256e4fmr6049949ejc.144.1704212069959; Tue, 02
 Jan 2024 08:14:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214020530.2267499-1-almasrymina@google.com>
 <20231214020530.2267499-5-almasrymina@google.com> <ddffff98-f3de-6a5d-eb26-636dacefe9aa@huawei.com>
 <CAHS8izO2nDHuxKau8iLcAmnho-1TYkzW09MBZ80+JzOo9YyVFA@mail.gmail.com>
 <20231215021114.ipvdx2bwtxckrfdg@google.com> <20231215190126.1040fa12@kernel.org>
 <CALvZod5myy2SvuCMNmqjjYeNONqSArV+8y8mrkfnNeog8WLjng@mail.gmail.com>
 <CAHS8izOLBtjHOqbTS_PiTNe+rTE=jboDWDM9zS108B57vVNcwA@mail.gmail.com>
 <CAHS8izMkCwv3jak9KUHeDUrkwBNNpdYk4voEX7Cbp7mTpNAQdA@mail.gmail.com>
 <54f226ef-df2d-9f32-fa3f-e846d6510758@huawei.com> <CAHS8izP63wXGH+Q3y1H=ycT=AHYnhGveBnuyF_rYioAjZ=Hn=g@mail.gmail.com>
 <7c6d35e3-165f-5883-1c1b-fce82c976028@huawei.com>
In-Reply-To: <7c6d35e3-165f-5883-1c1b-fce82c976028@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 2 Jan 2024 08:14:17 -0800
Message-ID: <CAHS8izNqeiK1tq=48LMbbqq5B4d2mhgbuKRvnFtiBngf73jXZg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v1 4/4] net: page_pool: use netmem_t instead
 of struct page in API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Shakeel Butt <shakeelb@google.com>, Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Michael Chan <michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>, 
	Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Marcin Wojtas <mw@semihalf.com>, 
	Russell King <linux@armlinux.org.uk>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>, 
	Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Jassi Brar <jaswinder.singh@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Ravi Gunasekaran <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Ronak Doshi <doshir@vmware.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 10:42=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.c=
om> wrote:
>
> On 2023/12/22 5:22, Mina Almasry wrote:
> > On Thu, Dec 21, 2023 at 3:32=E2=80=AFAM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> On 2023/12/20 11:01, Mina Almasry wrote:
> >>
> >> ...
> >>
> >>>>>> Perhaps we should aim to not export netmem_to_page(),
> >>>>>> prevent modules from accessing it directly.
> >>>>>
> >>>>> +1.
> >>>>
> >>>
> >>> I looked into this, but it turns out it's a slightly bigger change
> >>> that needs some refactoring to make it work. There are few places
> >>> where I believe I need to add netmem_to_page() that are exposed to th=
e
> >>> drivers via inline helpers, these are:
> >>>
> >>> - skb_frag_page(), which returns NULL if the netmem is not a page, bu=
t
> >>> needs to do a netmem_to_page() to return the page otherwise.
> >>
> >> Is it possible to introduce something like skb_frag_netmem() for
> >> netmem? so that we can keep most existing users of skb_frag_page()
> >> unchanged and avoid adding additional checking overhead for existing
> >> users.
> >>
> >
> > In my experience most current skb_frag_page() users need specifically
> > the struct page*. Example is illegal_highdma() which
> > PageHighMem(skb_frag_page())
>
> For illegal_highdma() case, is it possible to use something like
> skb_readabe_frag() checking to avoid calling skb_frag_page() for netmem?
>

Not teh skb_readable_frag() check I think, because illegal_highdma()
is not trying to read the SKB per se.

But I agree with your general point, and that should be handled
correctly in this patch which adds devmem support:

https://patchwork.kernel.org/project/netdevbpf/patch/20231218024024.3516870=
-10-almasrymina@google.com/

The idea being that skb_frag_page() can return NULL if the frag is not
paged, and the relevant callers are modified to handle that.

> >
> > But RFC v5 adds skb_frag_netmem() for callsites that want a netmem and
> > don't care about specifically a page:
> >
> > https://patchwork.kernel.org/project/netdevbpf/patch/20231218024024.351=
6870-10-almasrymina@google.com/
> >
> >>> - The helpers inside skb_add_rx_frag(), which needs to do a
> >>> netmem_to_page() to set skb->pfmemalloc.
> >>
> >> Similar as above, perhaps introduce something like skb_add_rx_netmem_f=
rag()?
> >>
> >
> > Yes, v3 of this series adds skb_add_rx_frag_netmem():
> >
> > https://patchwork.kernel.org/project/netdevbpf/patch/20231220214505.230=
3297-4-almasrymina@google.com/



--=20
Thanks,
Mina

