Return-Path: <bpf+bounces-13514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BF77DA2B4
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 23:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6351F2276D
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 21:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1C33FE5E;
	Fri, 27 Oct 2023 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176FF3FB02;
	Fri, 27 Oct 2023 21:57:39 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9302A1A1;
	Fri, 27 Oct 2023 14:57:37 -0700 (PDT)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id E6ED1140931;
	Fri, 27 Oct 2023 21:57:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 8C4C420010;
	Fri, 27 Oct 2023 21:57:11 +0000 (UTC)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 27 Oct 2023 14:57:11 -0700
From: Joe Perches <joe@perches.com>
To: Justin Stitt <justinstitt@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Shay Agroskin <shayagr@amazon.com>, Arthur Kiyanovski
 <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Noam Dagan
 <ndagan@amazon.com>, Saeed Bishara <saeedb@amazon.com>, Rasesh Mody
 <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Dimitris Michailidis <dmichail@fungible.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Louis Peens
 <louis.peens@corigine.com>, Shannon Nelson <shannon.nelson@amd.com>, Brett
 Creeley <brett.creeley@amd.com>, drivers@pensando.io, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Ronak Doshi
 <doshir@vmware.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CN?=
 =?UTF-8?Q?AL?= <arinc.unal@arinc9.com>, Daniel Golle
 <daniel@makrotopia.org>, Landen Chao <Landen.Chao@mediatek.com>, DENG
 Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Linus Walleij
 <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?=
 <alsi@bang-olufsen.dk>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
 <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team
 <linux-imx@nxp.com>, Lars Povlsen <lars.povlsen@microchip.com>, Steen
 Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, Jiawen Wu
 <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, Nathan
 Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>,
 intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
 linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH next v2 2/3] checkpatch: add ethtool_sprintf rules
In-Reply-To: <CAFhGd8p9ytqbRuqgWmKe=zCg7Nhft0NMvbuuEyjAQHNAcBedaQ@mail.gmail.com>
References: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
 <20231026-ethtool_puts_impl-v2-2-0d67cbdd0538@google.com>
 <8521c712250bcffce5c71e8d2b2574de786d4572.camel@perches.com>
 <CAFhGd8p9ytqbRuqgWmKe=zCg7Nhft0NMvbuuEyjAQHNAcBedaQ@mail.gmail.com>
Message-ID: <b24803fe577b5b6637688d53fc316ddf@perches.com>
X-Sender: joe@perches.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8C4C420010
X-Rspamd-Server: rspamout02
X-Stat-Signature: m1pbwndhwam5b1ag1hju7qk35oscyikg
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+TLe8vtqI1bKTGsQAk37rK7o0vYU0SCtE=
X-HE-Tag: 1698443831-782705
X-HE-Meta: U2FsdGVkX1+7OJ/aFWnkB1RSMYVx1/89hz0EtWGLmwlCSeRDArhrzCUyZnrWEkVwtCbR2zisjeu8Ak7YA/Z5oSNwmQqruchMId5hTfou6k5Nlx/UjmhgdhpIoFd7/sQe3f4pmdR63PJ4Y71c3CQurETODWjnWAXybZT0GbrbJBBQ3DrLip5C3y4b7gPpFcJUebManYXF8YpkYxCkdDnoKrKkALXKALqGtOYGLfNf6T5gYPqL/7FppGaVaEcqUnARFt3VnXsUDFxFbDiIz0Eipg==

On 2023-10-27 12:40, Justin Stitt wrote:

> Yeah you can push it but it's not really a standalone so perhaps I'll
> just steal the diff and
> wrap into v3?

Fine by me.
No need for my sign off.

