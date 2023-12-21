Return-Path: <bpf+bounces-18560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A109781BFF7
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 22:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C635F1C24848
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 21:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9960176DBC;
	Thu, 21 Dec 2023 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FpmkzEA9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F2276915
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a268836254aso151373866b.1
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 13:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703193762; x=1703798562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYUr/8SYAD8b39z5juYQlTN6Eyhymmps+aUneiJvKeo=;
        b=FpmkzEA9zPl1p8a8GRZ2EVpHgvpop64pjFzbvtKGeEmVSlITDOSbAwhZmGY+Z3hGQf
         EfbybPZAetvjfvuKXxyxYj7QxhZ2W+JsgwjTXZ2OUgijqkzKgZkp1uE+/M7m4R7/gk8n
         d/Y3pzKykKim3eHpFzJlY61a6YdfTYQ91lVfEvmuzRpgIiKqjkP9L6E96qpkDmLbiLOC
         Q2CdsYR8vd8HgotAH7t2Hu4EZvNGuI+OFtgzFGyUbGbhoVXoJyPkudIkYuf+5Fe5Mp6s
         SO/qasNNqy8DFA7YxARunFCUD938SijQQvF8tGqKAJvqVSpXtH2pXwDGX5HSMQNByikg
         S1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703193762; x=1703798562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYUr/8SYAD8b39z5juYQlTN6Eyhymmps+aUneiJvKeo=;
        b=ZeAx9piWPbC0iu4W+qzwG3jol0I78ADsYFImsQXS1Wr3j+q3GfrdIOHOgz0wycZREv
         dKC7p0DR+E7oR/xzpujJ/QwDWchCqt4i2ALp24/LT9KBNxbtv2DaSqNX97Q2Fh3oOj5s
         clZv2HfCgQh4tivheI11EL8RxhF/lXsEVecjDxS9BLtnajwkcUUM/tUlc6Arh4hEbirw
         C1Q0ayRImGoCI+WPvYfDqeKrPYLvzlYpByJMegjZ8guIdZDt4i8008Z7Jm+7Lq/V/5/J
         rwaWGDguQ4S1MszXJjZB76aMrK0bPv27opZIyYGI+BEbslbiDMCLYKq81gV12sI+As9K
         Dvag==
X-Gm-Message-State: AOJu0YyRQw0o82N5ET3uCev1sq6co79B4tHrDry/QYm2gI7xDGPNXPfK
	BNQSRnsFOsber0oA+Aw2wIRZvhzJBU7hrhoPBNlTIgBVCMvf
X-Google-Smtp-Source: AGHT+IHDM2f7ijWZdoTjSAk3eayoWKc0Ruh5BmMJXvkM5vwkTlpIi6/Ha1gNGgAwpihHFrBWvplldaFAdyXrCwDNcxM=
X-Received: by 2002:a17:906:fb16:b0:a26:a296:2ba4 with SMTP id
 lz22-20020a170906fb1600b00a26a2962ba4mr241429ejb.69.1703193761749; Thu, 21
 Dec 2023 13:22:41 -0800 (PST)
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
 <CAHS8izMkCwv3jak9KUHeDUrkwBNNpdYk4voEX7Cbp7mTpNAQdA@mail.gmail.com> <54f226ef-df2d-9f32-fa3f-e846d6510758@huawei.com>
In-Reply-To: <54f226ef-df2d-9f32-fa3f-e846d6510758@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 21 Dec 2023 13:22:27 -0800
Message-ID: <CAHS8izP63wXGH+Q3y1H=ycT=AHYnhGveBnuyF_rYioAjZ=Hn=g@mail.gmail.com>
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

On Thu, Dec 21, 2023 at 3:32=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/12/20 11:01, Mina Almasry wrote:
>
> ...
>
> >>>> Perhaps we should aim to not export netmem_to_page(),
> >>>> prevent modules from accessing it directly.
> >>>
> >>> +1.
> >>
> >
> > I looked into this, but it turns out it's a slightly bigger change
> > that needs some refactoring to make it work. There are few places
> > where I believe I need to add netmem_to_page() that are exposed to the
> > drivers via inline helpers, these are:
> >
> > - skb_frag_page(), which returns NULL if the netmem is not a page, but
> > needs to do a netmem_to_page() to return the page otherwise.
>
> Is it possible to introduce something like skb_frag_netmem() for
> netmem? so that we can keep most existing users of skb_frag_page()
> unchanged and avoid adding additional checking overhead for existing
> users.
>

In my experience most current skb_frag_page() users need specifically
the struct page*. Example is illegal_highdma() which
PageHighMem(skb_frag_page())

But RFC v5 adds skb_frag_netmem() for callsites that want a netmem and
don't care about specifically a page:

https://patchwork.kernel.org/project/netdevbpf/patch/20231218024024.3516870=
-10-almasrymina@google.com/

> > - The helpers inside skb_add_rx_frag(), which needs to do a
> > netmem_to_page() to set skb->pfmemalloc.
>
> Similar as above, perhaps introduce something like skb_add_rx_netmem_frag=
()?
>

Yes, v3 of this series adds skb_add_rx_frag_netmem():

https://patchwork.kernel.org/project/netdevbpf/patch/20231220214505.2303297=
-4-almasrymina@google.com/

> > - Some of the page_pool APIs are exposed to the drivers as static
> > inline helpers, and if I want the page_pool to use netmem internally
> > the page_pool needs to do a netmem_to_page() in these helpers.
> >
> > The refactor is not an issue, but I was wondering if not exporting
> > netmem_to_page() was worth moving the code around. I was thinking in
> > the interim until netmem is adopted and has actual driver users we may
> > prefer to just add a comment on the netmem_to_page() helper that says
> > 'try not to use this directly and use the netmem helpers instead'.
> >
>


--=20
Thanks,
Mina

