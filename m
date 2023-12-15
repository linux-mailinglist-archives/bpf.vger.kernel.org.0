Return-Path: <bpf+bounces-18011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDC4814D76
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F581F24DEF
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 16:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093833E49F;
	Fri, 15 Dec 2023 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bXSXDzSB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6944D3DB96
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d0b40bb704so196015ad.0
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 08:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702658879; x=1703263679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFF1dta+xlyg8MLdIwibfZN3TDA+ceWGZnTEl/bvSYQ=;
        b=bXSXDzSBSErBYcDeSf04Oo/6R6KqHXIJ+J+UecNGsyyGc36MaoAYOxn8eNe4iyKOQF
         wxqNrO3f/8yyOsPdjso8UbmhlJwHZFDy9N8ICOxKoPX/9W04NuTzJInOW7r9Z69ZTjX7
         FbdVV80pAEbOx0wOznxquDjqLGoER5vNn6NFHuM2hmUvXlU/XA/gC6SniHJXjvJmURes
         FhWjTvknjXByoEo7eWAzor1aGBToDmpanONBT3eCSkN6YHhRgRUKrMMDzkAuW+fZljUV
         74P+kNT9M6eLqYz5PUmqEJRQUBHxiLyyNoG0lMRi4CRiz0x1NKtYB6fasW83xPFyMK+V
         +xNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702658879; x=1703263679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFF1dta+xlyg8MLdIwibfZN3TDA+ceWGZnTEl/bvSYQ=;
        b=nl1/sfAb1et09DEaOKUXjSX30dwatGC2lyAZ1Qn7jnMc6ABLA9E83fHrmYFVmfrDS/
         lEGnNP1aPSj5sPgyFUsom+DF8UZhumcN3mLwyvwWL9dqiu999HDdq9BFGI03SbqVOJrr
         XZPxHrXBTsyXNHAMbAVT3wp4VJP4Tu345N2XLOghd/BvkX7MtBDa5li6u1DKKdcFx7fn
         4nrFWkDbVGvMYBCNi9ncEAYR2D0ZHf8pR8SkC//1ImwVhdxlD/gxz3K0vPfCViTMFBex
         +V44fH4JKFQ8ArOGnbLfLIiFA6af/QwViMLxU9EG6ztz+MhoIOIKCeYR+xfz9mz5//AM
         QTnQ==
X-Gm-Message-State: AOJu0YysEqvdGZ7UDiScWuX+Fu0qxgcS4oELagVE7xUmC4hZoK6ArFwa
	lnlolZurMZhwu7KYazAnStgU315KmmmHpH6nFkZYag==
X-Google-Smtp-Source: AGHT+IEbjeJsIZp5rRAzjQJeOjn/ytdkm89roAe2N65CsvRTZlJkSLxF/eDtmABy6dq4nOdoTRoClIhD5j52IYQ8NPc=
X-Received: by 2002:a17:903:1108:b0:1d3:40ea:bf5b with SMTP id
 n8-20020a170903110800b001d340eabf5bmr1147864plh.21.1702658878388; Fri, 15 Dec
 2023 08:47:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214020530.2267499-1-almasrymina@google.com>
 <20231214020530.2267499-5-almasrymina@google.com> <ddffff98-f3de-6a5d-eb26-636dacefe9aa@huawei.com>
 <CAHS8izO2nDHuxKau8iLcAmnho-1TYkzW09MBZ80+JzOo9YyVFA@mail.gmail.com>
 <20231215021114.ipvdx2bwtxckrfdg@google.com> <793eb1bd-29bd-3c66-4ed2-9297879dbaa0@huawei.com>
In-Reply-To: <793eb1bd-29bd-3c66-4ed2-9297879dbaa0@huawei.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Fri, 15 Dec 2023 08:47:46 -0800
Message-ID: <CALvZod7-WsxLj8gdhu=FMfdunEDgBV+DwfOB2316NfXvf_K41g@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v1 4/4] net: page_pool: use netmem_t instead
 of struct page in API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Michael Chan <michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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

On Fri, Dec 15, 2023 at 3:04=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/12/15 10:11, Shakeel Butt wrote:
> > On Thu, Dec 14, 2023 at 08:27:55AM -0800, Mina Almasry wrote:
> >> On Thu, Dec 14, 2023 at 4:05=E2=80=AFAM Yunsheng Lin <linyunsheng@huaw=
ei.com> wrote:
> >>>
> > [...]
> >>> I perfer the second one personally, as devmem means that it is not
> >>> readable from cpu.
> >>
> >> From my POV it has to be the first one. We want to abstract the memory
> >> type from the drivers as much as possible, not introduce N new memory
> >> types and ask the driver to implement new code for each of them
> >> separately.
>
> That was my initial thinking too:
> https://www.spinics.net/lists/netdev/msg949376.html
>
> But after discussion, it may make more sense to have two sets of API from=
 the
> driver's piont of view if we want a complete safe type protection, so tha=
t
> compiler can check everything statically and devmem driver API have a cle=
ar
> semantic:
> 1. devmem is not allowed to be called into mm subsystem.
> 2. it will not provide a API like page_address().
>

I think all of us are on the same page that there will be two sets of
APIs here but Mina's point was let's aim to not make that N set of
APIs.

