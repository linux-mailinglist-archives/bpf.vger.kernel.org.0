Return-Path: <bpf+bounces-18358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F3A819708
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 04:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2852D2837CB
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 03:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E458C02;
	Wed, 20 Dec 2023 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p7DU9Wi+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067A28BF9
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 03:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a22f59c6aeaso615938566b.2
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 19:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703041287; x=1703646087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pH2MC+JCVirOX6aXBHXvKDTSAfz8y1doyFVsXiJxsJk=;
        b=p7DU9Wi+ja7LZCfbmD8ln7S2AfqmXk3Y1DZtYbDRkFoe+uBmzXrXa128XRaSxb63IO
         AL1HsirLfnxTnJuDr9noON9nEYKvmH/cHBl/322cNWjMy+soC9kv+5oJPMCOu2lVb49w
         TejbBN4/F+khsFeYCv65rMGUA8ChBMIhsetl0UwZ91RxdtIPTGyfEr2CysDIEwZUHx0Q
         jPR1FsEjE31b03CtKqJnX9l88UN9knsrp9tlQOGP0krI3kRcix6jo9BIZu8L7wR2ml0N
         E3fi7jeX7jgExS6u1i1aXttuwnVUfF0emAbfGm/KL4mkurzotnUh0jRD6V5f/J7kFZjM
         1y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703041287; x=1703646087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pH2MC+JCVirOX6aXBHXvKDTSAfz8y1doyFVsXiJxsJk=;
        b=PtXASjdd0GH/pJ1S4lVKlmYiPjyRSyMfURzL9V7BixS27Wt/WBt4p3+E+dxheZ4lQe
         PlPKR8XxmDPQlQDAezVp56VawoQ/QYjaw7p7LUGxcdEawRJgorgvf3NqGNtsovq4X2DH
         LzqG8OiGjJ60m5EMq2ltzH4wIS5P03DaOa/VRa20wrt+wyTjYl1fm6+RfCjn8yt7/vmS
         JS9iWi1PUYxx43CaUJ6MUt4AXpOVkpWfdlB4Iyau/EqqAvj9GXJ+cf9llpUiYGFJ2rEq
         GN8z4CwV8ngLuWS2lFvTLAwtQoFi6OK3i1+zi/0Nk92ZmWJGeNQi6U3OO8KaBz95PFdt
         HTnw==
X-Gm-Message-State: AOJu0Yw5HZ3pQh+rI28xliTq028MPQIMZEuPiL7YweAo4hGQqGjMzGBQ
	tKAk6Iav9MBC31C7nTobLtgpkjco4qR7yzsY2Gae0g==
X-Google-Smtp-Source: AGHT+IFd0CMR8oOndSs9pPa6vty7A5RF77qbqSqiOEhvaFZJvbPWfZgqGjZmEwjrHvuDWKljCfDj1j1bwumMVK+pRi0=
X-Received: by 2002:a17:906:86:b0:a1f:a27f:d58d with SMTP id
 6-20020a170906008600b00a1fa27fd58dmr7450375ejc.105.1703041286894; Tue, 19 Dec
 2023 19:01:26 -0800 (PST)
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
 <CALvZod5myy2SvuCMNmqjjYeNONqSArV+8y8mrkfnNeog8WLjng@mail.gmail.com> <CAHS8izOLBtjHOqbTS_PiTNe+rTE=jboDWDM9zS108B57vVNcwA@mail.gmail.com>
In-Reply-To: <CAHS8izOLBtjHOqbTS_PiTNe+rTE=jboDWDM9zS108B57vVNcwA@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Dec 2023 19:01:14 -0800
Message-ID: <CAHS8izMkCwv3jak9KUHeDUrkwBNNpdYk4voEX7Cbp7mTpNAQdA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v1 4/4] net: page_pool: use netmem_t instead
 of struct page in API
To: Shakeel Butt <shakeelb@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Yunsheng Lin <linyunsheng@huawei.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
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

On Sat, Dec 16, 2023 at 2:06=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Sat, Dec 16, 2023 at 11:47=E2=80=AFAM Shakeel Butt <shakeelb@google.co=
m> wrote:
> >
> > On Fri, Dec 15, 2023 at 7:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Fri, 15 Dec 2023 02:11:14 +0000 Shakeel Butt wrote:
> > > > > From my POV it has to be the first one. We want to abstract the m=
emory
> > > > > type from the drivers as much as possible, not introduce N new me=
mory
> > > > > types and ask the driver to implement new code for each of them
> > > > > separately.
> > > >
> > > > Agree with Mina's point. Let's aim to decouple memory types from
> > > > drivers.
> > >
> > > What does "decouple" mean? Drivers should never convert netmem
> > > to pages. Either a path in the driver can deal with netmem,
> > > i.e. never touch the payload, or it needs pages.
> >
>
> I'm guessing the paths in the driver that need pages will have to be
> disabled for non-paged netmem, which is fine.
>
> One example that I ran into with GVE is that it calls page_address()
> to copy small packets instead of adding them as a frag. I can add a
> netmem_address() that returns page_address() for pages, and NULL for
> non-pages (never passing non-pages to mm code). The driver can detect
> that the netmem has no address, and disable the optimization for
> non-paged netmem.
>
> > "Decouple" might not be the right word. What I wanted to say was to
> > avoid too much specialization such that we have to have a new API for
> > every new fancy thing.
> >
> > >
> > > Perhaps we should aim to not export netmem_to_page(),
> > > prevent modules from accessing it directly.
> >
> > +1.
>

I looked into this, but it turns out it's a slightly bigger change
that needs some refactoring to make it work. There are few places
where I believe I need to add netmem_to_page() that are exposed to the
drivers via inline helpers, these are:

- skb_frag_page(), which returns NULL if the netmem is not a page, but
needs to do a netmem_to_page() to return the page otherwise.
- The helpers inside skb_add_rx_frag(), which needs to do a
netmem_to_page() to set skb->pfmemalloc.
- Some of the page_pool APIs are exposed to the drivers as static
inline helpers, and if I want the page_pool to use netmem internally
the page_pool needs to do a netmem_to_page() in these helpers.

The refactor is not an issue, but I was wondering if not exporting
netmem_to_page() was worth moving the code around. I was thinking in
the interim until netmem is adopted and has actual driver users we may
prefer to just add a comment on the netmem_to_page() helper that says
'try not to use this directly and use the netmem helpers instead'.

> This is an aggressive approach and I like it. I'll try to make it work
> (should be fine).
>
>
> --
> Thanks,
> Mina



--
Thanks,
Mina

