Return-Path: <bpf+bounces-17934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A19813F9A
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 03:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B879D1C22029
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30657815;
	Fri, 15 Dec 2023 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S4ihFpEG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D20110E1
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shakeelb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d092b42fb4so14044125ad.0
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 18:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702606276; x=1703211076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hn2u3ohnyQZ77hNqSlm/EvFnLZDsF+Ox+1yQ+iYOeGU=;
        b=S4ihFpEGaGASqDXTKfIcJabS3ty2QxSafop+BYrFlYS3RFOOEXc4/eKAaKZjzU4WWh
         DRXxnvX7n3k/XvfTLWvDbDI7EuR8uo9fqmsBj1c8yy9c253JKQ6y5iHHgfx2WBSiVhqA
         2KaQxhu0iAwy+KIml+CkrMRTA2GIVTgZvPP7BdOXDTLu9HND3PfxIVB0/V1suO6spBxu
         w+ugljbilT8Xyj+wPr5aH1wcv+/1s6U3TWDxYLvRPl9zk0ug9BodKQROgmm6vOHwTIcs
         r8iMGrzQdnS2SkDKDnKlkoTa1Io+H5bE4s67IUAtJ3FgiB0G2oYsfA9jZ4ClQJbAipA7
         /6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702606276; x=1703211076;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hn2u3ohnyQZ77hNqSlm/EvFnLZDsF+Ox+1yQ+iYOeGU=;
        b=XwghupXN3PnxRYoOy0rdD8+8281jQGlaSZs461j3I2asuOt2or445zuHI1Nni1impe
         PBOwTP7RTN24hc7Ds+TKIy41400FaQPYqsla4fjTJUtTzACf+UnfxMXm57o8rlJeRdg6
         8ntxE2YK4T32l9x1kF/j668wlbQh5CV7k10VpG71/SI1WOBJ6eDyNzR8o5jNXoXO6H7s
         TVY45eJV+CMbmn0GTTAxP3m8ftrDzJFS+fEbvla7xr0x55bTNBGdVD1BOuVWt6+QWi1L
         fXChiGQK4rHxuGeycUQMLgvA4k2vqxpR+yMY/FfwNeiIpTW0ow/p/i31XIqi1hhCa2Q8
         R9DQ==
X-Gm-Message-State: AOJu0YzEQ6tM945Ofdd0ClW4NeB234p5Dkg0yh9ttPWg76icjblT7hFo
	WhFeghwZkG/W1Pci/XxkZ5zHZVjc3SJ0IA==
X-Google-Smtp-Source: AGHT+IFer5ptuGEEfLFmjy3FBazRTAHYraFtWH6cjZkWuSL5hJETliQbOEPas4rAqb9tpBNPAqzbmDmViSQbnQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:902:f690:b0:1d0:8be8:bb7c with SMTP
 id l16-20020a170902f69000b001d08be8bb7cmr1969874plg.4.1702606275789; Thu, 14
 Dec 2023 18:11:15 -0800 (PST)
Date: Fri, 15 Dec 2023 02:11:14 +0000
In-Reply-To: <CAHS8izO2nDHuxKau8iLcAmnho-1TYkzW09MBZ80+JzOo9YyVFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214020530.2267499-1-almasrymina@google.com>
 <20231214020530.2267499-5-almasrymina@google.com> <ddffff98-f3de-6a5d-eb26-636dacefe9aa@huawei.com>
 <CAHS8izO2nDHuxKau8iLcAmnho-1TYkzW09MBZ80+JzOo9YyVFA@mail.gmail.com>
Message-ID: <20231215021114.ipvdx2bwtxckrfdg@google.com>
Subject: Re: [RFC PATCH net-next v1 4/4] net: page_pool: use netmem_t instead
 of struct page in API
From: Shakeel Butt <shakeelb@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Michael Chan <michael.chan@broadcom.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Wei Fang <wei.fang@nxp.com>, 
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
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 08:27:55AM -0800, Mina Almasry wrote:
> On Thu, Dec 14, 2023 at 4:05=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.=
com> wrote:
> >
[...]
> > I perfer the second one personally, as devmem means that it is not
> > readable from cpu.
>=20
> From my POV it has to be the first one. We want to abstract the memory
> type from the drivers as much as possible, not introduce N new memory
> types and ask the driver to implement new code for each of them
> separately.
>=20

Agree with Mina's point. Let's aim to decouple memory types from
drivers.

