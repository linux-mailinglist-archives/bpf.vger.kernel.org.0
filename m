Return-Path: <bpf+bounces-18101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77EF815C0D
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 23:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9ED21C21006
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 22:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18313358B5;
	Sat, 16 Dec 2023 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fuUQCdiO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A10135290
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50bfd8d5c77so2003629e87.1
        for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 14:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702764641; x=1703369441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqDuxpqkCYRmFRVQUIH+FxUzUqjaLCey4VDwdozyUN4=;
        b=fuUQCdiOuo+EM1Ve6TpTjM7UQA0jCAL8UAmMv1EutEmYsT0e9iE7I7VHb43pY3HBt1
         iEc35ImAhnodO3omJrym5mIVVl9vOvxggO6CAJic+FxgL7LfcxouoFnfimU22wxxCxeG
         iFUupiBR2TKOBzgVUg61AWj88G7ObqC+B5rX3095Cqz5RfA4x5efDwLyb60Kj3fGDQ48
         8iIbgPWVGQFGt4xEPrV2SrjgdNYsWzG0p3NaNWmcVQAk3nkZoyQGx2pb4KexH1qKdn13
         4MuyiyFq0R50dFv6dy/1k6hARzf1TaXWe8Tp67a2baUfmXQusD+bkPB6caOUBUffXg+v
         9vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702764641; x=1703369441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqDuxpqkCYRmFRVQUIH+FxUzUqjaLCey4VDwdozyUN4=;
        b=QAoX8ysawyGF1k2JJxJuLnh2oFoqILJ/2HMiU8yy4mamVIrX5X/fhZdSYloit+AUsh
         +Isn5cc7FFrjS3i8FzRC5fD+870tsQ8mPVMz2UPIB1Rae+KhF7/J9w3X/8ksqWaqN45v
         cBIl4pdwsBZYGYFcj19VjQREdz6u4y1Ur7ApQOTpcV/GHJCEgkyRfosqEjcu5YRFfwhh
         dABAKG/EpBrJtQeC5J4T1/8NG0UdeGAebtOntP7ncJbVkc1ixJUt9BY6LV77lRYo5JVD
         CZ2sDggD45VtltTPoY6xb3nnSgCDWbhumqsGTlYxtn8eY/IBiyq4FUHxSa1zGHG7Sn8R
         gYxA==
X-Gm-Message-State: AOJu0Yxq6hZvhfWMJQBd+jos46C0e0qFIXSS7jMOfswWQVJH7BOUtJ7X
	ZTrou6R+fBjoGymiHA5q9EaAbCFJqQidFxviIDEsLw==
X-Google-Smtp-Source: AGHT+IGAclYmiH5WN9yyQ0WxfUBxZ4BiuAeWyY94oQjA7ONm7Yi0blXiDY2nJYl1YGdC3+WxBtP6F7ZJLXGrqo22kMc=
X-Received: by 2002:a05:6512:21d1:b0:50b:f82d:7feb with SMTP id
 d17-20020a05651221d100b0050bf82d7febmr2588560lft.267.1702764640940; Sat, 16
 Dec 2023 14:10:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214020530.2267499-1-almasrymina@google.com>
 <20231214020530.2267499-3-almasrymina@google.com> <20231215185159.7bada9a7@kernel.org>
In-Reply-To: <20231215185159.7bada9a7@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sat, 16 Dec 2023 14:10:29 -0800
Message-ID: <CAHS8izMcFWu7zSuX9q8QgVNLiOiE5RKsb_yh5LoTKA1K8FUu1w@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v1 2/4] net: introduce abstraction for
 network memory
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
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

On Fri, Dec 15, 2023 at 6:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 13 Dec 2023 18:05:25 -0800 Mina Almasry wrote:
> > +struct netmem {
> > +     union {
> > +             struct page page;
> > +
> > +             /* Stub to prevent compiler implicitly converting from pa=
ge*
> > +              * to netmem_t* and vice versa.
> > +              *
> > +              * Other memory type(s) net stack would like to support
> > +              * can be added to this union.
> > +              */
> > +             void *addr;
> > +     };
> > +};
>
> My mind went to something like:
>
> typedef unsigned long __bitwise netmem_ref;
>
> instead. struct netmem does not exist, it's a handle which has
> to be converted to a real type using a helper.

Sure thing I can do that. Is it better to do something like:

struct netmem_ref;

like in this patch:

https://lore.kernel.org/linux-mm/20221108194139.57604-1-torvalds@linux-foun=
dation.org/

Asking because checkpatch tells me not to add typedefs to the kernel,
but checkpatch can be ignored if you think it's OK.

Also with this approach I can't use container_of and I need to do a
cast, I assume that's fine.

--=20
Thanks,
Mina

