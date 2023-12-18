Return-Path: <bpf+bounces-18240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1CC817D56
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 23:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5F01C22DA9
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 22:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3369676089;
	Mon, 18 Dec 2023 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I3uUzqBp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3542E740B0
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55322dbac2fso2363204a12.0
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 14:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702939154; x=1703543954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvjmfRNkX4sQk84Kdm8DrzXfsoFjryBSCdk41+TbjH4=;
        b=I3uUzqBpXN9vkAAFlomaQRNFV8b4LNomjX0Lt1uKTJvLgcxrQzXvY/maQ8XfhRZp9G
         zP4C9f1oJkUiy+lgm7d/5oy7pQSaEeOjv1Yy7YdRaPhKHvepKwxLUKtu5s56UwGpDkKK
         /2YpB9lE7U9auU/z5lVcv+Iiq/HC9/MXE2EF2wzGPpItkCSJtCjE2m9emhaqQXzFFlNL
         iIvq1aE3Ig00EKAvHUsRXVg94lFadXcxJUiDQv9lvmpSU+hpgkgRM5fbL1TENRuuv+bd
         LefD9JIzhxMWcbi0Z7LY8tx8xJ5HYkeDfPqn+CnRds9y238zzu4rV0ueU1CtlQGJXYUH
         3ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702939154; x=1703543954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvjmfRNkX4sQk84Kdm8DrzXfsoFjryBSCdk41+TbjH4=;
        b=bqBqXfmuukAWwTkaI620ScjrBLHP7V0NPBXDdyrn4ZVmaabfZaAvS8NZwUd0Rz82zw
         CKlbxLpBgL6JZQUMqq/ag0ufByn8eRFLgZZmE1UXApQ8xOFzbXcNC0xMsyeAsJaTYyJI
         5gposahO1jhkrGv6opoxwrxjCVPyl2CGaC6MQFrrS6iATkZ1SrTuWTdNTDF7PbHlYPvf
         CZ1eczzHNRez/ZwFcUqL7Ti+aAc4W6EM8zEOMVMptsoeaOPvRaxWBAJMuaBUw1MwqB3W
         xOs8mEmFjWeFF6qB/+FfBC+gG9mJnM3tnBIJ/6/ptQwBAGEyVEgKCEuZCaecvy2cv0Dd
         hniQ==
X-Gm-Message-State: AOJu0YwKniVysGfAJpAbAWTTwth6GVnXO9ZoMTndNaTsXADJPr1DzXBq
	6c6/xwHlRCG2SJ9cbFWxCQnDbp/rZw8dt1woRicSwA==
X-Google-Smtp-Source: AGHT+IE38t56xKGEIq6v9fWBqcXWI3e+v/qbMcPaymGNE3vZkdT7rySUdUkAVxhjSZQ6JuBEoI7z0tYYM9Ug0h2HmPg=
X-Received: by 2002:a17:906:1044:b0:a1f:7f7e:9200 with SMTP id
 j4-20020a170906104400b00a1f7f7e9200mr8485209ejj.8.1702939154243; Mon, 18 Dec
 2023 14:39:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214020530.2267499-1-almasrymina@google.com>
 <20231214020530.2267499-3-almasrymina@google.com> <20231215185159.7bada9a7@kernel.org>
 <CAHS8izMcFWu7zSuX9q8QgVNLiOiE5RKsb_yh5LoTKA1K8FUu1w@mail.gmail.com>
 <84787af3-aa5e-4202-8578-7a9f14283d87@kernel.org> <CAHS8izOeCdA+WVRYbieTqaCyadARsOpYttAXh7Lhu-B7RC3Tmg@mail.gmail.com>
 <20231218140645.461169a7@kernel.org>
In-Reply-To: <20231218140645.461169a7@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 18 Dec 2023 14:38:58 -0800
Message-ID: <CAHS8izOZ3c_3hretPBhowW5u-o5r4+WBeG3VVg_k32PUhAZqHA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v1 2/4] net: introduce abstraction for
 network memory
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org, 
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
	Jason Gunthorpe <jgg@nvidia.com>, Shakeel Butt <shakeelb@google.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 2:06=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 17 Dec 2023 00:14:59 -0800 Mina Almasry wrote:
> > > > Sure thing I can do that. Is it better to do something like:
> > > >
> > > > struct netmem_ref;
> > > >
> > > > like in this patch:
> > > >
> > > > https://lore.kernel.org/linux-mm/20221108194139.57604-1-torvalds@li=
nux-foundation.org/
> > > >
> > > > Asking because checkpatch tells me not to add typedefs to the kerne=
l,
> > > > but checkpatch can be ignored if you think it's OK.
> > > >
> > > > Also with this approach I can't use container_of and I need to do a
> > > > cast, I assume that's fine.
> > > >
> > >
> > > Isn't that the whole point of this set - to introduce a new data type
> > > and avoid casts?
>
> I don't see how we can avoid casts if the type of the referenced object
> is encoded on the low bits of the pointer. If we had a separate member
> we could so something like:
>
> struct netmem_ref {
>         enum netmem_type type;
>         union {
>                 struct page *p;
>                 struct page_pool_iov *pi;
>         };
> };
>
> barring crazy things with endian-aware bitfields, we need at least one
> cast.
>
> > My understanding here the requirements from Jason are:
> >
> > 1. Never pass a non-page to an mm api.
> > 2. If a mangle a pointer to indicate it's not a page, then I must not
> > call it mm's struct page*, I must add a new type.
> >
> > I think both requirements are met regardless of whether
> > netmem_to_page() is implemented using union/container_of or straight
> > casts. folios implemented something similar being unioned with struct
> > page to avoid casts.
>
> Folios overlay a real struct page. It's completely different.
>
> > I honestly could go either way on this. The union
> > provides some self documenting code and avoids casts.
>
> Maybe you guys know some trick to mask out the bottom bit :S
>
> > The implementation without the union obfuscates the type and makes it m=
uch
> > more opaque.
>
> Some would say that that's the damn point of the wrapping..
>
> You don't want non-core code futzing with the inside of the struct.
>
> > I finished addressing the rest of the comments and I have this series
> > and the next devmem TCP series ready to go, so I fired v2 of this
> > patchset. If one feels strongly about this let me know and I will
> > re-spin.
>
> You didn't address my feedback :|
>
> struct netmem which contains struct page by value is almost as bad
> as passing around pretend struct page pointers.

Sorry about that. I misread your original request as 'here is
something else you can do if you want', not something that you feel is
critical. Honestly I missed the subtlety and the approaches seemed
roughly equivalent to me. I will respin after the 24hr cooldown.

--=20
Thanks,
Mina

