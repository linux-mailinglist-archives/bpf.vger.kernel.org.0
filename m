Return-Path: <bpf+bounces-18100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4065E815C06
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 23:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97F21F22BD6
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 22:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E2A358AD;
	Sat, 16 Dec 2023 22:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lLU0lYDS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819EA35284
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 22:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55193d5e8cdso2133493a12.1
        for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 14:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702764412; x=1703369212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+A7W+kQw39I0W+Av8fUPMRQeHZ3+3clgt7HAcEmlw4M=;
        b=lLU0lYDSOvL7Pdd2ht480XXWFbTog77uJW3GTfVxty9Yo6ftdBe0qIAvqkxneVS8iw
         su0w5Q+ZgOL9reXN36S6iswgCRkkzJpOgZL1tkEHTPF5aC/6gPgsjfFlFsV9uy2lOvNa
         CliMKrSAutKrFZTp2jJ1NQ1jxdY/Rw9s2yUIeUtrOgdqbaMpQ1/448fznFnXN+W9V2Ib
         yT8JWrMA0TRzIFxIn/wS8aFice/kLFTkekGFkJuZpP1MVvH1KXVUuYrvZNBawl/Uwbwj
         bYOGEtIU/RCzWJ+bMRfLcFJaOfy7T38M+WdmyKnfaddKScHuw0BoB20QzKDZzgD3BXMc
         7q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702764412; x=1703369212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+A7W+kQw39I0W+Av8fUPMRQeHZ3+3clgt7HAcEmlw4M=;
        b=pt8DPdf06s6desYD6MPkGTinY9WprPp9q4S1q2FGTdaEcGifVBFqa9inxf8GDMtEs2
         1RdR44lVU4u0KIGRyX3gN9IUks6G0XukiEbpIDOtNy/xbtVOa2+JPMdnJGy2TisLsz9u
         tXWScbgseU95c7ZF9RB2lh7BhgqZ2eYHRyD9zYxtbIlDe2DPLlYn4ZoIqGE8hV6zsaP+
         JYjRazb+b9lAcw1zGAEvp+a/9krY5pYBEpa+hi8wfycnOXriGWfFU2Ig2l5lE60Lk/CB
         4VEYiHk8+F8pfvYInXaMfh9YR81z38Ej8jM9a284i3O/CE539oWdnsmPwc6srrRdW7Ed
         YpVQ==
X-Gm-Message-State: AOJu0Yx76zm/m76f6EjNv9EoK490S4eDRqifoWFt7YJAtNFI18Qs2noC
	jgqcfm7SDEzN41+xQnj+pqgv1iK1h/JEtq30TSFo8w==
X-Google-Smtp-Source: AGHT+IGDXfzXuemDkP4NhH4/F2a+MWPk45mdXOzcRD0E8CLBsGt8xOy7gIh+Vxsp5NTZ/wNHJ6UVEu48UkBiCbqW+qY=
X-Received: by 2002:a17:907:7d8c:b0:a19:a19b:55ef with SMTP id
 oz12-20020a1709077d8c00b00a19a19b55efmr7448815ejc.127.1702764411294; Sat, 16
 Dec 2023 14:06:51 -0800 (PST)
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
In-Reply-To: <CALvZod5myy2SvuCMNmqjjYeNONqSArV+8y8mrkfnNeog8WLjng@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sat, 16 Dec 2023 14:06:37 -0800
Message-ID: <CAHS8izOLBtjHOqbTS_PiTNe+rTE=jboDWDM9zS108B57vVNcwA@mail.gmail.com>
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

On Sat, Dec 16, 2023 at 11:47=E2=80=AFAM Shakeel Butt <shakeelb@google.com>=
 wrote:
>
> On Fri, Dec 15, 2023 at 7:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Fri, 15 Dec 2023 02:11:14 +0000 Shakeel Butt wrote:
> > > > From my POV it has to be the first one. We want to abstract the mem=
ory
> > > > type from the drivers as much as possible, not introduce N new memo=
ry
> > > > types and ask the driver to implement new code for each of them
> > > > separately.
> > >
> > > Agree with Mina's point. Let's aim to decouple memory types from
> > > drivers.
> >
> > What does "decouple" mean? Drivers should never convert netmem
> > to pages. Either a path in the driver can deal with netmem,
> > i.e. never touch the payload, or it needs pages.
>

I'm guessing the paths in the driver that need pages will have to be
disabled for non-paged netmem, which is fine.

One example that I ran into with GVE is that it calls page_address()
to copy small packets instead of adding them as a frag. I can add a
netmem_address() that returns page_address() for pages, and NULL for
non-pages (never passing non-pages to mm code). The driver can detect
that the netmem has no address, and disable the optimization for
non-paged netmem.

> "Decouple" might not be the right word. What I wanted to say was to
> avoid too much specialization such that we have to have a new API for
> every new fancy thing.
>
> >
> > Perhaps we should aim to not export netmem_to_page(),
> > prevent modules from accessing it directly.
>
> +1.

This is an aggressive approach and I like it. I'll try to make it work
(should be fine).


--
Thanks,
Mina

