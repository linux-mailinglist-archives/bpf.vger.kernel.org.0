Return-Path: <bpf+bounces-18099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45044815B71
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 20:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5B21F2369A
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 19:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DBF328C2;
	Sat, 16 Dec 2023 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFfmWsIU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B79321B9
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-35f9f3e98f4so107455ab.1
        for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 11:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702756028; x=1703360828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xk2EOjATRTJxRrrcnsFLeLcL8neXxaj8OIxb84EMHzw=;
        b=OFfmWsIUMY2kYqh9vTdql015YTC3dnoxdnV97ZTUlcKD9Zbtj+Jm9vbyiEScZ6+Lv2
         DoKjKibIHgHn62Vb1wLzwCQpRPeCwmz8ot3GWB7MmUVxGSSd+5aqMLVCkQ7u2H0cGCAa
         H7jCDp48lyfOMaSLlSGkEJZomFBB5mrkl9NnOqNXy+/FTEsksbHgOoMYq6nR9zPux31h
         3HMsN/+IHqQOE7C3DDhQnBBEo/8CRndntfezBNwihqcPP2fE/MKJHY/sNaND09y0BTqN
         3caIzYnEyMno1RfETMVWyi/kRRi8BeplFC6tB9eRfL2wMBly1BT3TnAS8lnIBm1lh7r5
         ygFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702756028; x=1703360828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xk2EOjATRTJxRrrcnsFLeLcL8neXxaj8OIxb84EMHzw=;
        b=JtA3lTQ7tqlLDYU7hEUsL7kzqQ2BgqVmbDtSRC/tBoVY6GQDSdUq398ArO7YklWDdP
         gV74dOqhfPyhM9cQjfBYFVhZlUTZf/A+yMwTzp5n1H9RtetSHYKMUpcGK6tqUjcChI5F
         MVXjcrRpe94t+5Ph5iv4HnUZeyz2djEeia0z0SZ6asEPZT1Db7HNAFnWIWkeXNbCmJHO
         pxmK/L0nhkZ9HZ6tmStIEXUeiRtraZOScsXRgRQEj0fQdF+m6ZEeMi6LMlTYIcqiDzlk
         skoJdNnbwGE/NQyluoZLndNmDqX8QojLMehZkbG03Suqxil5fafJXjMtaCP1L7fjDer2
         UO8A==
X-Gm-Message-State: AOJu0YwCagxH+ZxCDoDk+j1HmQSh8UZDUnesYJ3yzR4kl5AZgGGqCnee
	ujEDwGvzFb3Y+/snMCaI73cwIa7D2hEv1saw3uKjRyjIN5uA
X-Google-Smtp-Source: AGHT+IHa9aIn8GHUUATHAR1L+/ljRLtkiN3R+7lVDsJdPWFsH3yTbIL2YrlMWg/x4IkixakKOEE3J0YlmnozG4Be4ic=
X-Received: by 2002:a92:d7cc:0:b0:35f:716d:443c with SMTP id
 g12-20020a92d7cc000000b0035f716d443cmr207119ilq.16.1702756027759; Sat, 16 Dec
 2023 11:47:07 -0800 (PST)
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
In-Reply-To: <20231215190126.1040fa12@kernel.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Sat, 16 Dec 2023 11:46:54 -0800
Message-ID: <CALvZod5myy2SvuCMNmqjjYeNONqSArV+8y8mrkfnNeog8WLjng@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v1 4/4] net: page_pool: use netmem_t instead
 of struct page in API
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
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

On Fri, Dec 15, 2023 at 7:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 15 Dec 2023 02:11:14 +0000 Shakeel Butt wrote:
> > > From my POV it has to be the first one. We want to abstract the memor=
y
> > > type from the drivers as much as possible, not introduce N new memory
> > > types and ask the driver to implement new code for each of them
> > > separately.
> >
> > Agree with Mina's point. Let's aim to decouple memory types from
> > drivers.
>
> What does "decouple" mean? Drivers should never convert netmem
> to pages. Either a path in the driver can deal with netmem,
> i.e. never touch the payload, or it needs pages.

"Decouple" might not be the right word. What I wanted to say was to
avoid too much specialization such that we have to have a new API for
every new fancy thing.

>
> Perhaps we should aim to not export netmem_to_page(),
> prevent modules from accessing it directly.

+1.

