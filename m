Return-Path: <bpf+bounces-19049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CF0824822
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 19:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A0DB244D7
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 18:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED4E28E13;
	Thu,  4 Jan 2024 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nxGHI1kG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D87728DB0
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a28cc85e6b5so98833566b.1
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 10:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704392681; x=1704997481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w906pRFrrBglgFN05sIbeh3rO+uVc2/5xWCV3xYhIB8=;
        b=nxGHI1kGpJdyecUGvE6QDOGs3aN2TRKl0NThtScBMBlo9F3Y8IYqT2pfYzqvBtNxNV
         oFn8YMnzMINKa6MeSpfn3DCzx2oUBHsBhv722hk2wCqAd+QglEhZbeZiPoyo87dxkIh4
         qseus14cA1agPIE2PndGD7LxTD8gKHF6vFnl1h1QTrpTR65C1O6UZfYBmJ3wdTdtqmD2
         M17gR2fLHa6nachcQ9vbg/cLWwsL224Dv+j41gAlS+hI3PoF0P4d8uJ+cdkVTkAcWDnD
         EMiCjpqMfp6FggwYlSJtAupy3qFWiLtG0YP+B2fWoV9STRPnLUWmS6Dcxkkjx5xXmkhy
         gzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704392681; x=1704997481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w906pRFrrBglgFN05sIbeh3rO+uVc2/5xWCV3xYhIB8=;
        b=vNUn2kIqbaQDlZ9Yb4+VmS+EisUlUo3AguGPgV9HR3VMRR+sJ1QsQ2OB7moqZLGfaf
         Bl5yT2nri2JFbQr9yhSEzZxfz9epw4FB0yKuP0AteFhNDH2LGvSIg0s/aRhctUB57e6a
         o2bQlStlbZYf6m+P95u3jgcX9mF4LmQBbBIceQ7Xlfcp/KsoF95h9DQ5EXztR2rw3YU/
         hzEDpp7sTUN4sPSpw8RRb0xtqAkWH2bnxtj19n3IqNOKcUDbMpkEo+kHl1M5JRZ57ItE
         BTYGMa5KYnqabjVEBpF+eYaQKiqAqLcGStz3vR72IeJvUBt19pIzWFhxTPaLDjHAbXO5
         x4HA==
X-Gm-Message-State: AOJu0YyeVwAuBbv4pJIyUwn+6FBfjxq7MA+nsofGA9DuPGp+8FUKwKwm
	lUptcTZuvn1xIjPqS7l6wJ4REA91DFR+lUWAy00FHJr8I2Yp
X-Google-Smtp-Source: AGHT+IFb3qidV0D4JPL/qRoMWhyg/IoIqwyNCMrXmuouehjW0ZVP9W8+Ops3eA7v/T4FpfjuuzycczrTtcVH8Tzq2Rw=
X-Received: by 2002:a17:906:e0d8:b0:a27:6e73:a248 with SMTP id
 gl24-20020a170906e0d800b00a276e73a248mr344849ejb.68.1704392681125; Thu, 04
 Jan 2024 10:24:41 -0800 (PST)
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
 <fda068d0-f7fb-90fc-cdd6-1f853a4a225f@huawei.com> <CAHS8izNAxB=DQzSBOGbm6SsiL1cLSijj9n=g3d3egSxnOcBibQ@mail.gmail.com>
 <99817ed2-8ba6-ef8f-3ccb-2a2ab284b4af@huawei.com>
In-Reply-To: <99817ed2-8ba6-ef8f-3ccb-2a2ab284b4af@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 4 Jan 2024 10:24:29 -0800
Message-ID: <CAHS8izMMdmWoUHetA=GceJWVBgrCNAutn+B4ErMZFG=gmF5rww@mail.gmail.com>
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

On Thu, Jan 4, 2024 at 12:48=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/1/4 2:38, Mina Almasry wrote:
> > On Wed, Jan 3, 2024 at 1:47=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei=
.com> wrote:
> >>
> >> On 2024/1/3 0:14, Mina Almasry wrote:
> >>>
> >>> The idea being that skb_frag_page() can return NULL if the frag is no=
t
> >>> paged, and the relevant callers are modified to handle that.
> >>
> >> There are many existing drivers which are not expecting NULL returning=
 for
> >> skb_frag_page() as those drivers are not supporting devmem, adding add=
itionl
> >> checking overhead in skb_frag_page() for those drivers does not make m=
uch
> >> sense, IMHO, it may make more sense to introduce a new helper for the =
driver
> >> supporting devmem or networking core that needing dealing with both no=
rmal
> >> page and devmem.
> >>
> >> And we are also able to keep the old non-NULL returning semantic for
> >> skb_frag_page().
> >
> > I think I'm seeing agreement that the direction we're heading into
> > here is that most net stack & drivers should use the abstract netmem
>
> As far as I see, at least for the drivers, I don't think we have a clear
> agreement if we should have a unified driver facing struct or API for bot=
h
> normal page and devmem yet.
>

To be honest I definitely read that we have agreement that we should
have a unified driver facing struct from the responses in this thread
like this one:

https://lore.kernel.org/netdev/20231215190126.1040fa12@kernel.org/

But I'll let folks correct me if I'm wrong.

> > type, and only specific code that needs a page or devmem (like
> > tcp_receive_zerocopy or tcp_recvmsg_dmabuf) will be the ones that
> > unpack the netmem and get the underlying page or devmem, using
> > skb_frag_page() or something like skb_frag_dmabuf(), etc.
> >
> > As Jason says repeatedly, I'm not allowed to blindly cast a netmem to
> > a page and assume netmem=3D=3Dpage. Netmem can only be cast to a page
> > after checking the low bits and verifying the netmem is actually a
>
> I thought it would be best to avoid casting a netmem or devmem to a
> page in the driver, I think the main argument is that it is hard
> to audit very single driver doing a checking before doing the casting
> in the future? and we can do better auditting if the casting is limited
> to a few core functions in the networking core.
>

Correct, the drivers should never cast directly, but helpers like
skb_frag_page() must check that the netmem is a page before doing a
cast.

> > page. I think any suggestions that blindly cast a netmem to page
> > without the checks will get nacked by Jason & Christian, so the
> > checking in the specific cases where the code needs to know the
> > underlying memory type seems necessary.
> >
> > IMO I'm not sure the checking is expensive. With likely/unlikely &
> > static branches the checks should be very minimal or a straight no-op.
> > For example in RFC v2 where we were doing a lot of checks for devmem
> > (we don't do that anymore for RFCv5), I had run the page_pool perf
> > tests and proved there is little to no perf regression:
>
> For MAX_SKB_FRAGS being 17, it means we may have 17 additional checking
> overhead for the drivers not supporting devmem, not to mention we may
> have bigger value for MAX_SKB_FRAGS if BIG TCP is enable.
>

With static branch the checks should be complete no-ops unless the
user's set up enabled devmem.

> Even there is no notiable performance degradation for a specific case,
> we should avoid the overhead as much as possible for the existing use
> case when supporting a new use case.
>
> >
> > https://lore.kernel.org/netdev/CAHS8izM4w2UETAwfnV7w+ZzTMxLkz+FKO+xTgRd=
tYKzV8RzqXw@mail.gmail.com/
>
> The above test case does not even seems to be testing a code path calling
> skb_frag_page() as my understanding.
>
> >



--=20
Thanks,
Mina

