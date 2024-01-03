Return-Path: <bpf+bounces-18881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FC08234A1
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1FE41F24D42
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 18:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2CE1C6BE;
	Wed,  3 Jan 2024 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ps9cD3Dx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8D11CA89
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-552d39ac3ccso1340557a12.0
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 10:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704307126; x=1704911926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYrCXAnsOH5ti259ZxbWJxLR6syqU5rDe0tyxmeWWuA=;
        b=Ps9cD3DxxvLm/nA8x2j//4AbGTxK+X6pG3Df7eOOVLqwjQdWlsjSaojsKFd1m6XVBr
         exUPW0Ctd30yPSvhvxXlwz/RJzloEBoY6U/ZG0Pqf3Fw3AfeLoNd2C4xtHjavl46pOC8
         jWwl6wNoYJzsu7J5H4gtoHnkZ5lX4XMYznnGWEdGOVSjxC/YSfHshtgOMUnmGLrpuVgy
         YgCCQ45iglhQxTNIVtd4ccexqPtDB7vWq/AZxELO4G5W3h1i3bqQT/haTXJlfoyN7mNr
         OFjnY6rXva0Vz97v4QVs8GMMwfG2En/soBv5RCqwaDzooEOOf50CJIut9MJJkMTRW/Vh
         ++4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704307126; x=1704911926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYrCXAnsOH5ti259ZxbWJxLR6syqU5rDe0tyxmeWWuA=;
        b=CYyocNOZsXujV9EYwTR/MlUfgzNFr3gIBX59ZGKrmaM1JJUMPcK8rWjJVtlcLv+8sD
         DlMUuY4THjOMWyySycLM7YxiT+Sy4dy92K0tTF61FfqimhdBWQZOJC+88NtyB31EaoZC
         fMuoEWGpeE7KA936Yf6gda7lSFDcwmJ6zk/RKUrqNowVSkx6fIkVE5RtaCrVpF6m5Vkd
         ptnaIrheKFJ7VVQTslHEhJ4E7AN01iFeH6TH/Mn3Jx80utGjc0TtqJg7ZJw2svP4D1JM
         6GTDQOQEU2ncc+lOc75L/SnOi7Utgw/Z2D908Zl6KYnNP0F2xCsO2ivsMSfxXfYplUuN
         20gA==
X-Gm-Message-State: AOJu0YxjWMFpJiew2jrAyS58JIPmthAQTBv35BjWfvbMrcMtc/m1g61D
	iTM4wT2fhVEyEFdezj+t3lMVjKBYRwiqodZQVnV6ngvaxPcl
X-Google-Smtp-Source: AGHT+IHjRdt5+uZ9nZA8crZD5uFYRphJnSJ6JCDKfN+HX/AxSHKzupPmd7ltprsCcDhr9SyYHn60vw2HqP99zs0fD8Y=
X-Received: by 2002:a17:907:9010:b0:a23:62ed:105b with SMTP id
 ay16-20020a170907901000b00a2362ed105bmr1147383ejc.69.1704307126074; Wed, 03
 Jan 2024 10:38:46 -0800 (PST)
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
 <7c6d35e3-165f-5883-1c1b-fce82c976028@huawei.com> <CAHS8izNqeiK1tq=48LMbbqq5B4d2mhgbuKRvnFtiBngf73jXZg@mail.gmail.com>
 <fda068d0-f7fb-90fc-cdd6-1f853a4a225f@huawei.com>
In-Reply-To: <fda068d0-f7fb-90fc-cdd6-1f853a4a225f@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 3 Jan 2024 10:38:31 -0800
Message-ID: <CAHS8izNAxB=DQzSBOGbm6SsiL1cLSijj9n=g3d3egSxnOcBibQ@mail.gmail.com>
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

On Wed, Jan 3, 2024 at 1:47=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/1/3 0:14, Mina Almasry wrote:
> >
> > The idea being that skb_frag_page() can return NULL if the frag is not
> > paged, and the relevant callers are modified to handle that.
>
> There are many existing drivers which are not expecting NULL returning fo=
r
> skb_frag_page() as those drivers are not supporting devmem, adding additi=
onl
> checking overhead in skb_frag_page() for those drivers does not make much
> sense, IMHO, it may make more sense to introduce a new helper for the dri=
ver
> supporting devmem or networking core that needing dealing with both norma=
l
> page and devmem.
>
> And we are also able to keep the old non-NULL returning semantic for
> skb_frag_page().

I think I'm seeing agreement that the direction we're heading into
here is that most net stack & drivers should use the abstract netmem
type, and only specific code that needs a page or devmem (like
tcp_receive_zerocopy or tcp_recvmsg_dmabuf) will be the ones that
unpack the netmem and get the underlying page or devmem, using
skb_frag_page() or something like skb_frag_dmabuf(), etc.

As Jason says repeatedly, I'm not allowed to blindly cast a netmem to
a page and assume netmem=3D=3Dpage. Netmem can only be cast to a page
after checking the low bits and verifying the netmem is actually a
page. I think any suggestions that blindly cast a netmem to page
without the checks will get nacked by Jason & Christian, so the
checking in the specific cases where the code needs to know the
underlying memory type seems necessary.

IMO I'm not sure the checking is expensive. With likely/unlikely &
static branches the checks should be very minimal or a straight no-op.
For example in RFC v2 where we were doing a lot of checks for devmem
(we don't do that anymore for RFCv5), I had run the page_pool perf
tests and proved there is little to no perf regression:

https://lore.kernel.org/netdev/CAHS8izM4w2UETAwfnV7w+ZzTMxLkz+FKO+xTgRdtYKz=
V8RzqXw@mail.gmail.com/

--=20
Thanks,
Mina

